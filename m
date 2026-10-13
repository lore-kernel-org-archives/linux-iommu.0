Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0068C4ED19D
	for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 11:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791890533; cv=none; b=sZmvfLc9g1ydEOULSdSkCxziMQaimPHFc4zEnl/c+9On6IkW8s2O8vUSk34p4b7ALbexS5DmcpdkCm6yNw7+8sq2GAKKhfitE8+3AlvrO1490QLWcDEiAT/qr4+MLMOtzk24h6Qi8ydklPdbLoTt29nidrFy+eLNQr1eRvEMR0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791890533; c=relaxed/simple;
	bh=RLr0yHOBIlWtoJQFIjulsw9CVLczgK/Gqty1vaAGW0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EOr7O/SICGaTUP9NpR3jb+fhkMGMspbJ1pRuJPQxZnRpBna+y8gk0W67PPJ8Eb/Mi4rnWRYZ27Q1vllbdHjnG5/HgsYY4Gfyud3OuFFvsRZcPiAEKzNJehzbyeFwSyvSW5oEgF+HW16fJZOSlqLNazhXrFLt6etXKJ2LWYZTUQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Aeav/vQ3; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Aeav/vQ3"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C9171476;
	Tue, 13 Oct 2026 04:22:07 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CFA43F66F;
	Tue, 13 Oct 2026 04:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791890530; bh=RLr0yHOBIlWtoJQFIjulsw9CVLczgK/Gqty1vaAGW0M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Aeav/vQ3OvT5QabGviuydsBH8ty/WEMQW4ieoZhDJE5GN2p6eezLkc4K4JiYJEDCs
	 gIp0YIapFfZG+H4T9HqxUjj1ShU7RX9VvYPH09Z7n/ao5NblF1OL4SuG0hUoLbkKNZ
	 LBWQT9p7H+G6jdqXDdNapBSRMay/jlktWjv+xtLo=
Message-ID: <e8c22eb2-ed1f-47c7-b2ac-c56ead1cba8b@arm.com>
Date: Tue, 13 Oct 2026 12:22:06 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v6 5/5] iommu/arm-smmu-v3: Wire up shared-SID STE
 ordering and feature gating
To: Nicolin Chen <nicolinc@nvidia.com>, Peng Fan <peng.fan@oss.nxp.com>
Cc: Will Deacon <will@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Jean-Philippe Brucker <jpb@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Thierry Reding <thierry.reding@kernel.org>, Krishna Reddy
 <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 Peng Fan <peng.fan@nxp.com>
References: <20261011-smmu-shared-sid-v6-0-cb76b89dc612@nxp.com>
 <20261011-smmu-shared-sid-v6-5-cb76b89dc612@nxp.com>
 <aszfVNP6DGzWYdK0@shlinux89> <as1zR1wc7ERxvR1F@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <as1zR1wc7ERxvR1F@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/10/2026 12:54 am, Nicolin Chen wrote:
> On Mon, Oct 12, 2026 at 09:23:32PM +0800, Peng Fan wrote:
>>> +static bool arm_smmu_skip_shared_ste(struct arm_smmu_device *smmu,
>>> +				     u32 sid, bool is_abort)
>>> +{
>>> +	struct arm_smmu_stream *stream;
>>> +
>>> +	lockdep_assert_held(&smmu->streams_mutex);
>>> +
>>> +	stream = arm_smmu_find_stream(smmu, sid);
>>> +	if (!stream || list_empty(&stream->shared_masters))
>>> +		return false;
>>> +
>>> +	if (is_abort) {
>>> +		stream->ste_installed = false;
>>> +		return true;
>>> +	}
>>> +	if (stream->ste_installed)
>>> +		return true;
>>> +	stream->ste_installed = true;
>>> +	return false;
>>
>> sashiko has comments: https://sashiko.dev/#/patchset/20261011-smmu-shared-sid-v6-0-cb76b89dc612%40nxp.com
>>
>> We just need to support a simple case that platform devices(single SID) which
>> could share there SIDs, such as MMC-0 and MMC-1 share one SID.
>>
>> Shared-SID masters are restricted to platform devices sharing a single SID.
>> SVA, IOPF, and vSMMU nesting are all rejected for shared-SID masters (patch 5),
>> so VFIO passthrough and direct domain replacement scenarios do not apply.
>> The only domain transitions are the default DMA domain attach at probe time
>> and ABORT on unbind. Or I may miss something.
>   
> Domain can be switched between DMA and IDENTITY via sysfs.
> 
> I think there should be a way to support that. But, without a concrete
> use case, it might be easier to add this into the attach_dev callbacks
> (except arm_smmu_attach_dev_blocked):
> 
> 	if (arm_smmu_master_shares_sid(master) &&
> 	    old_domain && old_domain != domain &&
> 	    old_domain != &arm_smmu_blocked_domain)
> 		return -EBUSY;
> 
> And Sashiko's second remark does reveal a real bug:
> "Additionally, when devices are detached from a domain, is_abort is true.
>   arm_smmu_skip_shared_ste() clears ste_installed but unconditionally returns
>   true for all masters. Will this cause the ABORT STE to never be written to
>   hardware?"
> 
> Given that your use case always group SID-sharing masters in the same
> iommu_group and attach/replace a domain on those masters together, I
> think a simpler solution can be to always let stream->master install
> the shared STE.
> 
> One pitfall would be the release domain's attach_dev, which would go
> through arm_smmu_attach_dev_blocked() just like a blocked domain. So,
> it has to skip correctly if the shared stream->master == master. This
> means we might have to add a separate arm_smmu_attach_dev_release().

Hmm, but in fact why are we worrying about skipping things at all? Yes 
originally trying to rewrite a "live" STE was a problem, but since 
Jason's redesign, isn't arm_smmu_write_ste() just going to see that the 
"new" entry is identical to what's already there and happily do nothing?

> And I realized that there is another problem in your design: the CD
> table is still allocated per master; see arm_smmu_alloc_cd_ptr(). If
> STE is shared, its CD table must be shared too.

If we're not going to support PASID for shared streams (which I suggest 
we don't...) than we shouldn't strictly need to worry about CD tables 
anyway. So rather than having to special-case CD table sharing for 
shared streams, perhaps it might make sense to generalise back to a 
"default" per-domain CD for non-PASID use, which can then get switched 
for the private per-stream cd_table if and when a device does enable PASID?

Thanks,
Robin.

> You'd need to redirect all the master->cd_table with something like:
> 
> static struct arm_smmu_master *arm_smmu_cd_owner(struct arm_smmu_master *master)
> {
> 	if (arm_smmu_master_shares_sid(master)) {
> 		int i;
> 
> 		for (i = 0; i < master->num_streams; i++) {
> 			struct arm_smmu_stream *stream = master->streams[i];
> 
> 			if (!list_empty(&stream->shared_masters))
> 				return stream->master;
> 		}
> 	}
> 
> 	return master;
> }
> 
>>> @@ -4360,9 +4391,11 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
>> I am thinking to simplify reject if stall_enabled is true:
>>   			if (list_empty(&stream->shared_masters)) {
>> +				if (stream->master->stall_enabled) {
>> +					dev_warn(master->dev,
>> +						 "Shared StreamID 0x%x rejected: existing master has stall enabled\n",
>> +						 sid);
>> +					ret = -EBUSY;
>> +					break;
>> +				}
>   
> I'd move it upwards: next to the existing "num_streams != 1" guard.
> 
> Nicolin

