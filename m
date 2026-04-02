Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B9135F185
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 03:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775101869; cv=none; b=MlxYvcI8BNqT3cXBW5TE2LWigantUV3Q4tMfnISQ3lE3qDoHtpCYBrhYfZkdX7Rjfc7B25euOsHj2f6ESToU/0Qqhvr/jrfFFx+LP8BnORK9KxtjeLWEeljtBi1gP6/F6tsdqKzuetDlV9xMXae55CtGchoViAOcah5o2VpK1wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775101869; c=relaxed/simple;
	bh=lt+zP9As4Yq+Wde10tJ1btezopsYQ1iFQzRQ5ny3Aro=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kxlU7bcISfEtFFIbI5BDOAR+MnZ1n4jynA7eQbMD3/1KudYsmGW1uyZIy/Y7TCk57yAHPsaSLgoviJhYXhuujA371lwKUTWMbDAcImdRT0PlJ5nLrhRPp7KxaDdDhmH92jW8H81UiGeFHrzLS1OqdlLT3QWD9wc+v1+JyK+iDj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=CcFoy4tx; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="CcFoy4tx"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=j98bfMfsCWtDp07VFYlUTyTLZgSB6CElM/PsxDfAV+0=;
	b=CcFoy4txwoulWUG9kwcJTkGrJpGJbgeSNPUpkz2j+7RRjr5AvKrumdOHsMMcM484IG9mihcx8
	5BbFNwL4vXB2hkUFd2hOy1EK3ivSlTG1f98p/S/alHQR88Ya6gYo2ZJY8zhGFsoQjKDDCgXcwmr
	Fo+G9i7d+7fztiVkZvnsR2o=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fmSRY4fXWz1T4L2;
	Thu,  2 Apr 2026 11:45:13 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C27E40569;
	Thu,  2 Apr 2026 11:50:55 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 2 Apr 2026 11:50:54 +0800
Message-ID: <b0e67dac-a95f-4b8f-b4c6-3e992b66a780@huawei.com>
Date: Thu, 2 Apr 2026 11:50:54 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/5] iommu/arm-smmu-v3: Add basic debugfs framework
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <robin.murphy@arm.com>, <will@kernel.org>, <jpb@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<wangzhou1@hisilicon.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <jonathan.cameron@huawei.com>,
	<wuyifan50@huawei.com>, <linuxarm@huawei.com>
References: <20260328101706.3448655-1-xiaqinxin@huawei.com>
 <20260328101706.3448655-2-xiaqinxin@huawei.com> <acpUoZ7wx9gdT5BG@nvidia.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <acpUoZ7wx9gdT5BG@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2026/3/30 18:46:57, Nicolin Chen <nicolinc@nvidia.com> wrote:
> On Sat, Mar 28, 2026 at 06:17:02PM +0800, Qinxin Xia wrote:
>> Add basic debugfs framework for ARM SMMUv3 driver.This creates the
> 
> Needs a space after "."
> 
>> +static int smmu_debugfs_capabilities_show(struct seq_file *seq, void *unused)
>> +{
>> +	struct arm_smmu_device *smmu = seq->private;
>> +
>> +	if (!smmu) {
>> +		seq_puts(seq, "SMMU not available\n");
>> +		return 0;
>> +	}
>> +
>> +	seq_puts(seq, "SMMUv3 Capabilities:\n");
>> +	seq_printf(seq, "  Stage1 Translation: %s\n",
>> +		   smmu->features & ARM_SMMU_FEAT_TRANS_S1 ? "Yes" : "No");
>> +	seq_printf(seq, "  Stage2 Translation: %s\n",
>> +		   smmu->features & ARM_SMMU_FEAT_TRANS_S2 ? "Yes" : "No");
>> +	seq_printf(seq, "  Coherent Walk: %s\n",
>> +		   smmu->features & ARM_SMMU_FEAT_COHERENCY ? "Yes" : "No");
>> +	seq_printf(seq, "  ATS Support: %s\n",
>> +		   smmu->features & ARM_SMMU_FEAT_ATS ? "Yes" : "No");
>> +	seq_printf(seq, "  PRI Support: %s\n",
>> +		   smmu->features & ARM_SMMU_FEAT_PRI ? "Yes" : "No");
>> +	seq_printf(seq, "  Stream Table Size: %d\n", 1 << smmu->sid_bits);
>> +	seq_printf(seq, "  Command Queue Depth: %d\n",
>> +		   1 << smmu->cmdq.q.llq.max_n_shift);
>> +	seq_printf(seq, "  Event Queue Depth: %d\n",
>> +		   1 << smmu->evtq.q.llq.max_n_shift);
> 
> Nit: should we do all sizes or all depths? Any good reason to mix
> them here?
>

Stream Table is a table, not a queue, so 'Size' is more appropriate; 
queues use 'Depth'. But I can change to unify if preferred.

>> +/**
>> + * arm_smmu_debugfs_remove() - Clean up debugfs entries for an SMMU device
>> + * @smmu: SMMU device
>> + *
>> + * This function removes the debugfs directories created by setup.
>> + */
>> +void arm_smmu_debugfs_remove(struct arm_smmu_device *smmu)
>> +{
>> +	struct arm_smmu_debugfs *debugfs;
>> +
>> +	scoped_guard(mutex, &arm_smmu_debugfs_lock) {
> 
> It could be just normal guard().
> 
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 4d00d796f078..cbb3fccc501b 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -4904,6 +4904,15 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>   	/* Check for RMRs and install bypass STEs if any */
>>   	arm_smmu_rmr_install_bypass_ste(smmu);
>>   
>> +#ifdef CONFIG_ARM_SMMU_V3_DEBUGFS
>> +	char name[32];
> 
> This could be moved to the top, as iommu_device_sysfs_add() can use
> it, whether CONFIG_ARM_SMMU_V3_DEBUGFS=y or =n.
> 
>> +	snprintf(name, sizeof(name), "smmu3.%pa", &ioaddr);
> 
> And this could be moved after ioaddr gets a copy from res->start.
> 
>>   
>> +#ifdef CONFIG_ARM_SMMU_V3_DEBUGFS
>> +struct arm_smmu_debugfs {
>> +	struct dentry			*smmu_dir;
> 
> A personal preference: for new structures, maybe drop those tabs?
> 
>>   /* An SMMUv3 instance */
>>   struct arm_smmu_device {
>>   	struct device			*dev;
>> @@ -803,6 +813,11 @@ struct arm_smmu_device {
>>   
>>   	struct rb_root			streams;
>>   	struct mutex			streams_mutex;
>> +
>> +#ifdef CONFIG_ARM_SMMU_V3_DEBUGFS
>> +	/* DebugFS Info */
> 
> Doesn't seem very useful. I'd drop it.
> 
>> +	struct arm_smmu_debugfs		*debugfs;
>> +#endif
>   
> Nicolin
> 
-- 
Thanks,
Qinxin

