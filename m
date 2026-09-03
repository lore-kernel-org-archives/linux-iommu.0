Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6E042E417
	for <iommu@lists.linux.dev>; Thu,  3 Sep 2026 07:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421463; cv=none; b=UoLRVNK6kxmlguzsXUGGlq6IurRmCFIB/HcxltB5zD6fT95w2EmGAw8k6isVA9jbKuOC3kxwXgB7fEIs3wSRJCUogsu3igMTteE9x3dxDpweT99pNBYwwIve7vA5M58jDghIiWEVcKZKUtN9uZHfTvLqN4YuARJLVa+YJS6JDSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421463; c=relaxed/simple;
	bh=BhhbBow9CaHdcvbCIfGNDmsl/cn5E9ux6VKW5OeUCM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oYosybXE1crBPSLSUTK0p+scgH71Hb1/8rpHrwpc0k/qB+98DfhsPt3ldfGjMp5Ak7QL4uX34VbX0gSYqAIV3uL5ExO6N28b34rRdiws61M813Mycw0txX1d9bMa6yaRB80RarWBjoOtBbQXc4MQefMuQJmK2Bwa8cwVxHMEscY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=H65wnqG8; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="H65wnqG8"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788421449; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ge6lR+8ZfIiyvJs0V7pajWNgEd552Utb9P7OOcSsdJo=;
	b=H65wnqG8HnUs19vjwaZMaa0HRMPmbTAbjOxCYKNsxFU++9YCfrhws3T2NmOeuzEtKfcFOKhgF3ttNxIHGyycz+hAT8bwYVul0AeW7Knm3XHBsSmDiepXyaOk+OQPkMtRhlaaCaui+7HCBt+QOIVrOEIufCXblksKJWwVt0MZ6Nc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0XAFO2XN_1788421446;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XAFO2XN_1788421446 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 03 Sep 2026 15:44:08 +0800
From: fangyu.yu@linux.alibaba.com
To: sunilvl@oss.qualcomm.com
Cc: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	rafael@kernel.org
Subject: Re: [PATCH] ACPI: RIMT: Enable PCI ACS for root complexes mapped to an IOMMU  
Date: Thu,  3 Sep 2026 15:44:06 +0800
Message-Id: <20260903074406.43565-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <CAB19ukHwcDnApuWcn4MWm=bJZS2=UqbLT2=MnpfsJePG=qA_wA@mail.gmail.com>
References: <CAB19ukHwcDnApuWcn4MWm=bJZS2=UqbLT2=MnpfsJePG=qA_wA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>
>> Mirror the ACPI IORT solution used on arm64 (see iort_enable_acs())
>> by scanning the RIMT table for PCIe root complex nodes during
>> riscv_acpi_rimt_init(), which runs before ACPI PCI enumeration. If a
>> root complex node's ID mapping points at an IOMMU node, call
>> pci_request_acs() immediately, so pci_acs_enable is already set by
>> the time any PCI device is scanned and pci_enable_acs() runs.
>>
>> Only one call to pci_request_acs() is needed regardless of how many
>> root complexes are found, so track that with a static acs_enabled
>> flag, same as iort_enable_acs() does.
>>
>> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>> ---
>>  drivers/acpi/riscv/rimt.c | 56 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 56 insertions(+)
>>
>> diff --git a/drivers/acpi/riscv/rimt.c b/drivers/acpi/riscv/rimt.c
>> index e4538fa6c2c8..f22e28c8211e 100644
>> --- a/drivers/acpi/riscv/rimt.c
>> +++ b/drivers/acpi/riscv/rimt.c
>> @@ -179,6 +179,42 @@ static struct acpi_rimt_node *rimt_scan_node(enum acpi_rimt_node_type type,
>>         return NULL;
>>  }
>>
>> +#ifdef CONFIG_PCI
>> +static void __init rimt_enable_acs(struct acpi_rimt_node *rimt_node)
>> +{
>> +       static bool acs_enabled __initdata;
>> +       struct acpi_rimt_pcie_rc *pci_rc;
>> +       struct acpi_rimt_id_mapping *map;
>> +       struct acpi_rimt_node *parent;
>> +       int i;
>> +
>> +       if (acs_enabled || rimt_node->type != ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLEX)
>> +               return;
>> +
>> +       pci_rc = (struct acpi_rimt_pcie_rc *)rimt_node->node_data;
>> +       if (!pci_rc->id_mapping_offset || !pci_rc->num_id_mappings)
>> +               return;
>> +
>> +       map = ACPI_ADD_PTR(struct acpi_rimt_id_mapping, rimt_node,
>> +                          pci_rc->id_mapping_offset);
>> +
>> +       for (i = 0; i < pci_rc->num_id_mappings; i++, map++) {
>> +               if (!map->dest_offset)
>> +                       continue;
>> +
>> +               parent = ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table,
>> +                                     map->dest_offset);
>> +               if (parent->type == ACPI_RIMT_NODE_TYPE_IOMMU) {
>> +                       pci_request_acs();
>> +                       acs_enabled = true;
>> +                       return;
>> +               }
>> +       }
>> +}
>> +#else
>> +static inline void rimt_enable_acs(struct acpi_rimt_node *rimt_node) { }
>> +#endif
>> +
>>  /*
>>   * RISC-V supports IOMMU as a PCI device or a platform device.
>>   * When it is a platform device, there should be a namespace device as
>> @@ -509,7 +545,10 @@ int rimt_iommu_configure_id(struct device *dev, const u32 *id_in)
>>
>>  void __init riscv_acpi_rimt_init(void)
>>  {
>> +       struct acpi_rimt_node *rimt_node, *rimt_end;
>> +       struct acpi_table_rimt *rimt;
>>         acpi_status status;
>> +       int i;
>>
>>         /* rimt_table will be used at runtime after the rimt init,
>>          * so we don't need to call acpi_put_table() to release
>> @@ -525,4 +564,21 @@ void __init riscv_acpi_rimt_init(void)
>>
>>                 return;
>>         }
>> +
>> +       rimt = (struct acpi_table_rimt *)rimt_table;
>> +       rimt_node = ACPI_ADD_PTR(struct acpi_rimt_node, rimt,
>> +                                rimt->node_offset);
>> +       rimt_end = ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table,
>> +                               rimt_table->length);
>> +
>> +       for (i = 0; i < rimt->num_nodes; i++) {
>> +               if (rimt_node >= rimt_end) {
>> +                       pr_err("RIMT node pointer overflows, bad table\n");
>> +                       return;
>> +               }
>> +
>> +               rimt_enable_acs(rimt_node);
>>
>NIT: Can we check here itself if it is a PCI RC node and then only
>call enable_acs()?
>

Agreed, I will add the PCI RC node check here and invoke enable_acs()
only for that node type.

Thanks,
Fangyu

>> +               rimt_node = ACPI_ADD_PTR(struct acpi_rimt_node, rimt_node,
>> +                                        rimt_node->length);
>> +       }
>>  }
>> --
>> 2.50.1
>>
>Otherwise, LGTM.
>
>Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
