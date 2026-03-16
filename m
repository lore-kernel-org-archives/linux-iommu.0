Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6174525BEF8
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673945; cv=none; b=h0wxlSjDCJnD0FIMHqBDZOCotERh007Vo+BbCrjU1AMoKX/txFHaAxXOq8FJrWhAG/gpYHurX+2Xe2Txpt793bxCBVHfZTjHZBzPbnnYrIiQAIQYxpiRj/cXjTi83SEl+QxSTUz4qNAj8e72dfyvvakFsCbtobXm5JABOqx695k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673945; c=relaxed/simple;
	bh=cEtOnDHxmt60tW904cckms9HK8yIKSPLwIikKxpI7w4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lL2zslo0XlRsQP7dS0QfXeF9TMvs/uR/aV14sep+MkJaUxQo/rQyN4ga/0JkaDliTgL8Zrkg6w6Q2f2f6zZjKX4O7odPqxYS7bfOevkcNJfifVGK9K/3lE9O4iEJ5ONURw/qoyCYZuamHiLrSZJroGNnuCuAl3ji2xq5maDZn9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=kGhFhQks; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="kGhFhQks"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=q/0CKGvPOl7BVTBCKbKNZviyVP3Tup7TnwROT2hNFNE=;
	b=kGhFhQksGC037qL98iFElnN6J4GDIbTEoDJRsTIRpTk70CrjC0SeruGJXybv5vChluYmgXIxz
	JuGxB0P7xF/8jgQsBKYpKGypfrLi5SAFXl9lvb2Ix4mRmr1LCk03YX9wMO6XfSR9qOqqP8nWUVe
	imqnqyX2vS64eJyMDpAxB/g=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fZJN210Zjz1T4GK;
	Mon, 16 Mar 2026 23:06:58 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id E1E5A40561;
	Mon, 16 Mar 2026 23:12:16 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 16 Mar 2026 23:12:16 +0800
Message-ID: <42f9d052-f0df-419f-8aad-ea18e10962d8@huawei.com>
Date: Mon, 16 Mar 2026 23:12:15 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/5] iommu/arm-smmu-v3: Add Context Descriptor display
 to debugfs
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <jpb@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<wangzhou1@hisilicon.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>
References: <20260313104351.3502293-1-xiaqinxin@huawei.com>
 <20260313104351.3502293-6-xiaqinxin@huawei.com>
 <abR7ys1LYRhJ8Hn6@Asurada-Nvidia>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <abR7ys1LYRhJ8Hn6@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2026/3/14 05:04:10, Nicolin Chen <nicolinc@nvidia.com> wrote:
> On Fri, Mar 13, 2026 at 06:43:51PM +0800, Qinxin Xia wrote:
>>    * Directory Structure:
>>    * /sys/kernel/debug/iommu/arm_smmu_v3/
>>    * └── smmu0/
>> @@ -35,6 +42,8 @@
>>    *     └── stream_table
>>    *	   └── 0000:01:00.0:0/                    # PCI device with Stream ID 0
>>    *             ├── ste                           # Stream Table Entry
>> + *             └── context_descriptors/
>> + *                 └── all                       # All Context Descriptors
> 
> I wonder if we should do per-RID/PASID v.s. all. Otherwise, cd_dir
> seems unnecessary, as it could be a file instead?
> 

That's exactly what I'm thinking about.
Per-PASID could be better expanded, but now all maybe is enough.

>> +/**
>> + * smmu_debug_dump_cd() - Dump Context Descriptor details to seq_file
>> + * @seq: seq_file to write to
>> + * @dev: device associated with the CD
>> + * @ssid: Substream ID
>> + */
>> +static void smmu_debug_dump_cd(struct seq_file *seq, struct device *dev, u32 ssid)
>> +{
>> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>> +	struct arm_smmu_cd *cd;
>> +	u64 data;
>> +	int i;
>> +
>> +	if (!master) {
>> +		seq_puts(seq, "No master data\n");
>> +		return;
>> +	}
>> +
>> +	cd = arm_smmu_get_cd_ptr(master, ssid);
>> +	if (!cd) {
>> +		seq_printf(seq, "CD not available for SSID %u\n", ssid);
>> +		return;
>> +	}
> 
> master->cd_table can be free-ed. We could hit UAF in a race. This
> very likely needs arm_smmu_asid_lock.
> 
>> +	seq_printf(seq, "CD for Substream ID %u:\n", ssid);
>> +
>> +	/* CD 0 */
>> +	data = le64_to_cpu(cd->data[0]);
>> +	seq_printf(seq, "  Valid: %s\n", data & CTXDESC_CD_0_V ? "Yes" : "No");
>> +	seq_printf(seq, "  T0SZ: 0x%llx\n", data & CTXDESC_CD_0_TCR_T0SZ);
>> +	seq_printf(seq, "  EPD0: %s\n", data & CTXDESC_CD_0_TCR_EPD0 ? "Yes" : "No");
>> +	seq_printf(seq, "  EPD1: %s\n", data & CTXDESC_CD_0_TCR_EPD1 ? "Yes" : "No");
> 
> All these are unnecessary if V=0? Maybe the per-SSID output should
> depend on V=1 at all. Same might apply to STE.
> 
I made this judgment before dump:

		if (cd && (le64_to_cpu(cd->data[0]) & CTXDESC_CD_0_V)) {
			seq_printf(seq, "\n--- SSID %u ---\n", ssid);
			smmu_debug_dump_cd(seq, dev, ssid);
		}

So, the CDs dumped here are valid.
You remind me that "Valid" print can be omitted here :-)

>> +/* All CDs debugfs file operations */
>> +static int smmu_debugfs_all_cds_show(struct seq_file *seq, void *v)
>> +{
>> +	struct device *dev = seq->private;
>> +
>> +	smmu_debug_dump_all_cds(seq, dev);
>> +	return 0;
> 
> Just unwrap the smmu_debug_dump_all_cds().
> 
> Nicolin
> 
-- 
Thanks,
Qinxin

