From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH 07/30] iommu/arm-smmu-v3: Add second level of context
 descriptor table
Date: Mon, 15 May 2017 14:57:15 +0100
Message-ID: <7ba38e5b-cbce-f468-42fc-2949e1a06176@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-8-jean-philippe.brucker@arm.com>
 <ef690c27-95cc-c15d-7e70-7e89de7bc08a@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <ef690c27-95cc-c15d-7e70-7e89de7bc08a@semihalf.com>
Sender: kvm-owner@vger.kernel.org
To: Tomasz Nowicki <tn@semihalf.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Shanker Donthineni <shankerd@qti.qualcomm.com>, kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>, Sinan Kaya <okaya@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org, Harv Abdulhamid <harba@qti.qualcomm.com>, Alex Williamson <alex.williamson@redhat.com>, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, Nate Watterson <nwatters@qti.qualcomm.com>
List-Id: iommu@lists.linux-foundation.org

On 15/05/17 13:47, Tomasz Nowicki wrote:
> Hi Jean,
> 
> On 27.02.2017 20:54, Jean-Philippe Brucker wrote:
>> @@ -1213,17 +1356,59 @@ static void arm_smmu_free_cd_tables(struct
>> arm_smmu_master_data *master)
>>  __maybe_unused
>>  static int arm_smmu_alloc_cd(struct arm_smmu_master_data *master)
>>  {
>> +    int ssid;
>> +    int i, ret;
>>      struct arm_smmu_cd_cfg *cfg = &master->ste.cd_cfg;
>>
>> -    return arm_smmu_bitmap_alloc(cfg->context_map,
>> ilog2(cfg->num_entries));
>> +    if (cfg->linear)
>> +        return arm_smmu_bitmap_alloc(cfg->table.context_map,
>> +                         ilog2(cfg->num_entries));
>> +
>> +    /* Find first leaf table with an empty slot, or allocate a new leaf */
>> +    for (i = cfg->l1.cur_table; i < cfg->num_entries; i++) {
>> +        struct arm_smmu_cd_table *table = &cfg->l1.tables[i];
>> +
>> +        if (!table->cdptr) {
>> +            __le64 *l1ptr = cfg->l1.ptr + i * CTXDESC_L1_DESC_DWORD;
>> +
>> +            ret = arm_smmu_alloc_cd_leaf_table(master->smmu, table,
>> +                               CTXDESC_NUM_L2_ENTRIES);
>> +            if (ret)
>> +                return ret;
>> +
>> +            arm_smmu_write_cd_l1_desc(l1ptr, table);
>> +            arm_smmu_sync_cd(master, i << CTXDESC_SPLIT, false);
>> +        }
>> +
>> +        ssid = arm_smmu_bitmap_alloc(table->context_map, CTXDESC_SPLIT);
>> +        if (ssid < 0)
>> +            continue;
>> +
>> +        cfg->l1.cur_table = i;
>> +        return i << CTXDESC_SPLIT | ssid;
>> +    }
>> +
>> +    return -ENOSPC;
>>  }
>>
>>  __maybe_unused
>>  static void arm_smmu_free_cd(struct arm_smmu_master_data *master, u32
>> ssid)
>>  {
>> +    unsigned long l1_idx, idx;
>>      struct arm_smmu_cd_cfg *cfg = &master->ste.cd_cfg;
>>
>> -    arm_smmu_bitmap_free(cfg->context_map, ssid);
>> +    if (cfg->linear) {
>> +        arm_smmu_bitmap_free(cfg->table.context_map, ssid);
>> +        return;
>> +    }
>> +
>> +    l1_idx = ssid >> CTXDESC_SPLIT;
>> +    idx = ssid & ((1 << CTXDESC_SPLIT) - 1);
>> +    arm_smmu_bitmap_free(cfg->l1.tables[l1_idx].context_map, idx);
>> +
>> +    /* Prepare next allocation */
>> +    if (cfg->l1.cur_table > idx)
>> +        cfg->l1.cur_table = idx;
>>  }
> 
> I am not sure what is the logic here. idx becomes index of l1.tables in
> arm_smmu_alloc_cd() which in turn may be out of allocated memory. I may
> miss something. Can you please elaborate on this?

The code is wrong, this should be:

+    if (cfg->l1.cur_table > l1_idx)
+        cfg->l1.cur_table = l1_idx;

Which tells alloc_cd() that there is a free slot in table l1_idx. It would
also look better with a min(). However this allocator will be replaced by
a global (IDR) allocator in next version, as requested by other users of
the IOMMU API.

Thanks,
Jean
