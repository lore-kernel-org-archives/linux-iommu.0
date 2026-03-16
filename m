Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112C33081A2
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673091; cv=none; b=LmkgS0VgwVFT9YFMdp9f+tO937rP+afr5LH7hUctuZVmpCYp4+pb8LPS3oZNnKJSYqlz37FVgiUY3vP94uACjPlXrB0Q0LvmkwnjPla2RiTrT+hBzZ5sgom/TJptLaGnHZ2jqqHxtDQf6la4USX81Cg4kifgmn0mbebkxy3BsNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673091; c=relaxed/simple;
	bh=YLp8IBLUB/2oF/TqmmC60PrtnbfGBe44Ec0C/mk28Lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sxLSFGpMKpZxQJ6GfjCjeM2YeiY0DtJqorPxx80F3fkoLy7h3Ew0TN+Tt2QnosTyDv3c2JuuaxqfCp2ZFFuF7c1NdRATqYJtyCwpZYYrwh6qd9affsLCZWgosdbxZVnP1VpoUOyhmSEMRKzTp++82u1bRq8+AyxlkiQMBlkHlfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JHsT585e; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JHsT585e"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1C0KDzZKnKHSlUkdUXpl5bCbdxQFaILc3VGmf0dTPBc=;
	b=JHsT585eZKN+MQLHFnoAr95Q107TaXcgix74XdZ3mFwTDbhJFiL00YTeLDV3WbKkMsK6ZW5pL
	hnzU2RudCHaejI0E5TS70GBqlTN4a2Yp2T55GGLcwozsZzkwOBvJK1vRzNYUoVvVd3ukwWFCZJc
	08mdsEDeZtsql9CYDXB+GVI=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fZJ3s0Y8Hz1prNJ;
	Mon, 16 Mar 2026 22:52:57 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id CB51A2022B;
	Mon, 16 Mar 2026 22:57:57 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 16 Mar 2026 22:57:57 +0800
Message-ID: <b2a56e70-6555-48f6-bc5e-f1ce98c64cb7@huawei.com>
Date: Mon, 16 Mar 2026 22:57:56 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] iommu/arm-smmu-v3: Add stream table directory
 structure to debugfs
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <jpb@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<wangzhou1@hisilicon.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>
References: <20260313104351.3502293-1-xiaqinxin@huawei.com>
 <20260313104351.3502293-5-xiaqinxin@huawei.com>
 <abR3QXHGAWz9E6qV@Asurada-Nvidia>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <abR3QXHGAWz9E6qV@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2026/3/14 04:44:49, Nicolin Chen <nicolinc@nvidia.com> wrote:
> On Fri, Mar 13, 2026 at 06:43:50PM +0800, Qinxin Xia wrote:
>>    * The capabilities file provides detailed information about:
>>    * - Architecture version and translation stage support (Stage1/Stage2)
>> @@ -324,5 +327,78 @@ static int smmu_debugfs_ste_show(struct seq_file *seq, void *v)
>>   	smmu_debug_dump_ste(seq, dev);
>>   	return 0;
>>   }
>> -
>>   DEFINE_SHOW_ATTRIBUTE(smmu_debugfs_ste);
> 
> nit: let's not add that line in the first place
> 
>> +
>> +/**
>> + * smmu_debugfs_create_stream_table() - Create debugfs entries for stream table
>> + * @dev: device to create entries for
>> + * @smmu: SMMU device
>> + *
>> + * Return: 0 on success, negative error code on failure
>> + */
>> +int smmu_debugfs_create_stream_table(struct device *dev,
>> +				     struct arm_smmu_device *smmu)
>> +{
>> +	struct dentry *stream_dir, *cd_dir, *dev_dir;
>> +	struct dentry *ste_file, *all_cds_file;
>> +	struct iommu_fwspec *fwspec;
>> +	char name[64];
>> +	int i, ret = 0;
>> +
>> +	if (!smmu->debugfs->stream_dir) {
>> +		stream_dir = debugfs_create_dir("stream_table",
>> +						smmu->debugfs->smmu_dir);
>> +		if (!stream_dir)
>> +			return -ENOMEM;
>> +		smmu->debugfs->stream_dir = stream_dir;
>> +	} else {
>> +		stream_dir = smmu->debugfs->stream_dir;
>> +	}
>> +
>> +	fwspec = dev_iommu_fwspec_get(dev);
>> +	if (!fwspec)
>> +		return -ENODEV;
>> +
>> +	for (i = 0; i < fwspec->num_ids; i++) {
>> +		u32 sid = fwspec->ids[i];
>> +
>> +		if (dev_is_pci(dev)) {
>> +			struct pci_dev *pdev = to_pci_dev(dev);
>> +
>> +			snprintf(name, sizeof(name), "%04x:%02x:%02x.%d:%u",
>> +				 pci_domain_nr(pdev->bus), pdev->bus->number,
>> +				 PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
>> +				 sid);
> 
> Doesn't dev_name(dev) print the BDF numbers as well?
> 
>> +		} else {
>> +			snprintf(name, sizeof(name), "%s:%u", dev_name(dev),
>> +				 sid);
>> +		}
>> +
>> +		dev_dir = debugfs_create_dir(name, stream_dir);
>> +		if (!dev_dir) {
>> +			ret = -ENOMEM;
>> +			goto cleanup;
>> +		}
> 
> A device can have multiple streams. So, dev_dir should be the
> parent directory?
> 
dev_dir is a parent directory and it contains ste info and CD info
for all streams of this device.

[root@localhost stream_table]# ls
0000:34:00.0:13312  0000:34:01.0:13320  0000:35:00.0:13568 
0000:35:00.1:13569  0000:35:00.2:13570  0000:35:00.3:13571
[root@localhost stream_table]# cd 0000\:34\:00.0\:13312/
[root@localhost 0000:34:00.0:13312]# ls
context_descriptors  ste
[root@localhost 0000:34:00.0:13312]#
>> +
>> +		/* Success for this stream ID, continue to next */
>> +		continue;
>> +
>> +cleanup_dev:
>> +		debugfs_remove_recursive(dev_dir);
>> +cleanup:
>> +		if (ret) {
>> +			debugfs_remove_recursive(stream_dir);
> 
> One is the other's parent directory. So it should be good enough
> with a single debugfs_remove_recursive()?
> 
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 211a0c87507a..c57897e5f644 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -3133,6 +3133,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
>>   
>>   	arm_smmu_attach_commit(&state);
>>   	mutex_unlock(&arm_smmu_asid_lock);
>> +#ifdef CONFIG_ARM_SMMU_V3_DEBUGFS
>> +	smmu_debugfs_create_stream_table(dev, smmu);
>> +#endif
> 
> Calling in attach_dev doesn't seem correct to me. And device/master
> can be unplugged. So, we would need to unwind those dev/stream_dir.
> 
> Maybe probe_device/release_device are the places to go?
> 
> Nicolin
> 
Thanks for your review,
I will fix these bugs in the next RFC version.
-- 
Thanks,
Qinxin

