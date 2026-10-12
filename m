Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D48848B37E
	for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 13:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810316; cv=none; b=nUejCIHTzVf3JAWxw87lacU/zJ9OD385b2yf5d6LCsltB7eznUjGPHsmH5YmWoICbAxKAgS4arwzhczLvBPt2NklRkd/tdN0sd5BKMTPXga1cAhUDTH3oU20vNANEH4v3OZ1jxbiiLD5vwpWunUoGvGTi+J9qvmjR/ZhNaSKeHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810316; c=relaxed/simple;
	bh=TJeQAN9KqZ2HQFMyvgo2CldFEYJ/Aevze9HuTjW/Msc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K3Buzik3rL+tHOovhrD0JxBE6ZBJnj4B1ii68ouRAbe0v7xRogR/dI+Z0h0B6O2g0NTaittpfgmSKTc1aEK95OCqs6UCRshvDmTMVtxfWfDVIh86WwgfwgxgAM3QXXjTks6wRcmcQgERZFrPoLzrjqMeqbGhZsJ+39ya1qvZQmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IfiXllgL; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IfiXllgL"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 702391655;
	Mon, 12 Oct 2026 06:05:11 -0700 (PDT)
Received: from [10.57.57.201] (unknown [10.57.57.201])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F2503F882;
	Mon, 12 Oct 2026 06:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791810314; bh=TJeQAN9KqZ2HQFMyvgo2CldFEYJ/Aevze9HuTjW/Msc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IfiXllgLUFnPwL1ik/aVjn/fqzAmj8Z1QCvTOC8vsF6oIi4fXTdRxIaAqQWv52U2M
	 1Gk4BmMEq9QtnWNQsI4/QExZU5+i5aQUAebFRpOJCyjysWhtlrApdaplP3B0CBN20s
	 wyiKH2Oq72Y0FWAt4XiIUlCLJJorj+LEJAKXX/BI=
Message-ID: <f15d35a3-9378-4363-b12b-f5c082331400@arm.com>
Date: Mon, 12 Oct 2026 14:05:03 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v6 4/5] iommu/arm-smmu-v3: Group aliasing devices into
 the same IOMMU group
To: Peng Fan <peng.fan@oss.nxp.com>, Will Deacon <will@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Jean-Philippe Brucker <jpb@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Thierry Reding <thierry.reding@kernel.org>,
 Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 Peng Fan <peng.fan@nxp.com>
References: <20261011-smmu-shared-sid-v6-0-cb76b89dc612@nxp.com>
 <20261011-smmu-shared-sid-v6-4-cb76b89dc612@nxp.com>
 <aszRgehfo5emwCt+@shlinux89>
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <aszRgehfo5emwCt+@shlinux89>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-10-12 1:24 pm, Peng Fan wrote:
> On Sun, Oct 11, 2026 at 07:31:28PM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> Devices sharing a SID must share a single IOMMU domain (and
>> therefore a single cd_table) because the STE can only point to one
>> cd_table at a time.
>>
>> Detect SID aliasing at group-assignment time by looking up the RB
>> tree for existing owners.  arm_smmu_device_group() is called before
>> arm_smmu_insert_master(), so any RB tree hit belongs to a
>> different, already-probed master.
> As Sashiko pointed, I need correct as below:
> 
> Detect SID aliasing at group-assignment time by looking up the RB
> tree for existing owners. Since probe_device() inserts the master
> before device_group() is called, skip the device's own stream and
> look for a different, already-probed master that shares the same
> SID.
> 
>>
>> Assisted-by: LLM
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 33 ++++++++++++++++++++---------
>> 1 file changed, 23 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 351ccdfa765b4..328d580935b96 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -4572,19 +4572,32 @@ static int arm_smmu_set_dirty_tracking(struct iommu_domain *domain,
>>
>> static struct iommu_group *arm_smmu_device_group(struct device *dev)
>> {
>> -	struct iommu_group *group;
>> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>> +	struct arm_smmu_device *smmu = master->smmu;
>> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>> +	struct iommu_group *group = NULL;
>> +	int i;
>> +
>> +	mutex_lock(&smmu->streams_mutex);
>> +	for (i = 0; i < fwspec->num_ids; i++) {
>> +		struct arm_smmu_stream *stream;
>> +
>> +		stream = arm_smmu_find_stream(smmu, fwspec->ids[i]);
>> +		if (!stream)
>> +			continue;
> 
> Not very sure here, should I use below as check condition?
>    if (!stream || stream->master == master)
>        continue?

By this point, we must always find a valid stream for every ID, or 
probe_device() hasn't done its job correctly. The difference is if it 
only belongs to this device then it doesn't represent a group yet, 
otherwise if it is shared then the other device(s) must already have a 
group (since we're within the serialised part of probing) and we need to 
return that.

Thanks,
Robin.

> Per my understanding stream->master will never equals to master,
> but Sashiko concerns: Could this logic be adjusted to better handle the
> device's own stream?
> 
> Thanks
> Peng
> 
>> +
>> +		group = iommu_group_get(stream->master->dev);
>> +		break;
>> +	}
>> +	mutex_unlock(&smmu->streams_mutex);
>> +
>> +	if (group)
>> +		return group;
>>
>> -	/*
>> -	 * We don't support devices sharing stream IDs other than PCI RID
>> -	 * aliases, since the necessary ID-to-device lookup becomes rather
>> -	 * impractical given a potential sparse 32-bit stream ID space.
>> -	 */
>> 	if (dev_is_pci(dev))
>> -		group = pci_device_group(dev);
>> -	else
>> -		group = generic_device_group(dev);
>> +		return pci_device_group(dev);
>>
>> -	return group;
>> +	return generic_device_group(dev);
>> }
>>
>> static int arm_smmu_of_xlate(struct device *dev,
>>
>> -- 
>> 2.34.1
>>
>>

