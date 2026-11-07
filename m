Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794056915;
	b=2+z9WYUU/dWLLeoG+Py/H5PS5MGUJM9+4iyiXwBmDop0OcYXjjC7ndWDlqmC0RaadY9D
	 t/4sAEOKmUKpgIixBt9edNYYWguCoq1JBF0LcU2J0yqj6wem5Q+QRQISJrZVONsTGRl53
	 6uSfsDwh1670jS5iK0sS+nYsUXWbZIYIQ1wq4EuhEAUrOh12XD6BxqnwTB3qqo62krzQz
	 DlGFDMzmUs8xNgv17t03miSmC3xDf3jxKfM/6xB4pKzYPMnjGsI1Vy5a0739rYBIhKnBJ
	 1Ay7HX8adlm6C9TStWJU2LSHJJvEMi66+ofzUfvpjfY8WVRqozWrdBdsGFQL9V6ZBlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794056915;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QL67QE6ypnwqVZUieQLSAmYxM/GrcX0qjylvi7BSJVY=;
	b=RScex3JNDgLY0cfG0vxi+P70cWbPHkECljVVVFh5QUu5IkTvbMol4+3A21OOl1crWskR
	 x/ujhX+7OoaQhiUxtJMvHwe0Tkzjan4uU9gO9oBSeH7bYSUBnHNBkBJcTl3JUzK1ZtuUR
	 2Ae2XWu37Yv7S3zF9WLzjaS052aVxYYNqXxyhwlG5eQuxz6ONOX+oDuhiP8C+vgmipL15
	 nj3mqrWEVwTqk69W788yLhTvj2RN1/IUnsrd5rwCWIsJgepDIMEdNwaLAhJPv4/FAxUcY
	 RUrQb7ndMAa9LxNrD+h1OIEPLnR9UF6BBJOPCppEKBW2WXzCzkKVl4d1MsR2Azc13DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nKPa2GUu;
	arc=none smtp.remote-ip=95.215.58.119
Received: from mta1.migadu.com (out-119.mta1.migadu.com [95.215.58.119])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ED8606A32D
	for <iommu@lists.linux.dev>; Sat,  7 Nov 2026 13:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66ED8606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nKPa2GUu
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=Wzg9psy46NQFtiN5fc9mojAh/zLqq0GdyPhCMFvIY0I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794056911; v=1; x=1794661711;
 b=nKPa2GUuEJSWgO5viJ+kr68h9VuVHx0tvEJ+HeSISbCHh9JQZwyFvh0YKR4yroiJDy+s7N3v
 eEIj47k7UVaNI6hGzmIecyUNygk48JaXK7W4NJJcQ3/tvzuAMzYfnvkf32t9x3T9QgUgXoluIJz
 eV9BbYHtB0REK0++hGDFLfU8=
X-Envelope-To: iommu@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id bae0ebbbf597277d;
	Sat, 07 Nov 2026 13:08:31 +0000
X-Mizu-Trace-ID: bae0ebbbf597277d
X-Migadu-Flow: FLOW_OUT
Date: Sat, 7 Nov 2026 21:08:18 +0800
From: Peng Fan <peng.fan@linux.dev>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC v7 4/7] iommu/arm-smmu-v3: Use a per-domain CD table
 for non-PASID streams
Message-ID: <au8iwj68zXO1us_8@fedora>
References: <20261030-smmu-shared-sid-ver7-2026-10-26-v7-0-961726ebd6ab@Example.Com>
 <20261030-smmu-shared-sid-ver7-2026-10-26-v7-4-961726ebd6ab@Example.Com>
 <auU/RARTx8dv5mAE@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auU/RARTx8dv5mAE@nvidia.com>

On Fri, Oct 30, 2026 at 06:07:16PM -0700, Nicolin Chen wrote:
>On Fri, Oct 30, 2026 at 08:09:36PM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>> 
>> The CD describes the domain context, so non-PASID devices attached to the
>> same S1 domain do not need private copies of it. Store a CD table in
>> struct arm_smmu_domain and make non-PASID streams point their STE at that
>> table.
>
>> @@ -3044,6 +3055,9 @@ static void arm_smmu_domain_free_paging(struct iommu_domain *domain)
>>  		mutex_lock(&arm_smmu_asid_lock);
>>  		xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
>>  		mutex_unlock(&arm_smmu_asid_lock);
>> +
>> +		if (arm_smmu_cdtab_allocated(&smmu_domain->cd_table))
>> +			arm_smmu_free_domain_cd_tables(smmu_domain);
>
>Same comments as previous: fold arm_smmu_cdtab_allocated in.
>
>> @@ -3854,11 +3879,27 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
>>  		return -EINVAL;
>>  
>>  	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
>> -		cdptr = arm_smmu_alloc_cd_ptr(master, IOMMU_NO_PASID);
>> +		/*
>> +		 * Non-PASID devices use the domain's shared CD table. The
>> +		 * private table is needed for substreams (PASID), for
>> +		 * ATS-always-on (S1DSS), and for the stall model: CD.S is a
>> +		 * per-CD property and cannot be shared by devices that
>> +		 * terminate faults.
>> +		 */
>> +		if (master->ats_always_on ||
>> +		    master->stall_enabled ||
>
>For readability, let's add a helper:
>
>static bool arm_smmu_master_needs_private_cdtab(struct arm_smmu_master *master)
>{
>	/* Reason 1 */
>	if (master->ats_always_on)
>		return true;
>	/* Reason 2 */
>	if (master->stall_enabled)
>		return true;
>	return false;
>}
>
>> @@ -3978,10 +4022,17 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
>>  	    sid_domain->type != IOMMU_DOMAIN_BLOCKED)
>>  		return -EINVAL;
>>  
>> +	first = !arm_smmu_ssids_in_use(&master->cd_table);
>>  	cdptr = arm_smmu_alloc_cd_ptr(master, pasid);
>>  	if (!cdptr)
>>  		return -ENOMEM;
>>  
>> +	if (first) {
>> +		cd0ptr = arm_smmu_alloc_cd_ptr(master, IOMMU_NO_PASID);
>> +		if (!cd0ptr)
>> +			return -ENOMEM;
>> +	}
>
>Maybe allocate cd0ptr in arm_smmu_alloc_cd_tables()?
>
>We can also have a helper to share with arm_smmu_alloc_cd_ptr().
>
>static int arm_smmu_alloc_cd_ptr_l2(struct arm_smmu_master *master, u32 ssid)
>{
>	[...]
>	*l2ptr = dma_alloc_coherent(master->smmu->dev, sizeof(**l2ptr),
>				    &l2ptr_dma, GFP_KERNEL);
>	if (!*l2ptr)
>		return -ENOMEM;
>
>	arm_smmu_write_cd_l1_desc(&cd_table->l2.l1tab[idx], l2ptr_dma);
>	return 0;
>}
>
>> @@ -3997,8 +4048,39 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
>>  	cd->data[0] |= cpu_to_le64(
>>  		FIELD_PREP(CTXDESC_CD_0_ASID, smmu_domain->cd.asid));
>>  
>> +	/*
>> +	 * The private CD table is taking over the STE now. Make sure its
>> +	 * default substream matches the RID domain before the STE points at
>> +	 * it, since non-PASID traffic follows CD[0].
>> +	 */
>> +	if (first) {
>> +		if ((sid_domain->type & __IOMMU_DOMAIN_PAGING) &&
>> +		    to_smmu_domain(sid_domain)->stage == ARM_SMMU_DOMAIN_S1) {
>> +			struct arm_smmu_cd cd0;
>> +
>> +			arm_smmu_make_s1_cd(&cd0, master,
>> +					    to_smmu_domain(sid_domain));
>> +			arm_smmu_write_cd_entry(master, IOMMU_NO_PASID,
>> +						cd0ptr, &cd0);
>> +		} else if (sid_domain->type == IOMMU_DOMAIN_IDENTITY ||
>> +			   sid_domain->type == IOMMU_DOMAIN_BLOCKED) {
>> +			arm_smmu_clear_cd(master, IOMMU_NO_PASID);
>> +		} else {
>> +			WARN_ON(1);
>> +		}
>> +	}
>> +
>>  	arm_smmu_write_cd_entry(master, pasid, cdptr, cd);
>> -	arm_smmu_update_ste(master, sid_domain, state.ats_enabled);
>> +
>> +	/*
>> +	 * A repeat PASID attach leaves the STE on the private table with the
>> +	 * same S1DSS/EATS. Only the first attach (or an ATS change) needs to
>> +	 * rewrite it; arm_smmu_write_ste() would otherwise issue a redundant
>> +	 * CMD_PREFETCH_CFG for every stream.
>> +	 */
>> +	if (first || !master->cd_table.in_ste ||
>> +	    master->ste_ats_enabled != state.ats_enabled)
>> +		arm_smmu_update_ste(master, sid_domain, state.ats_enabled);
>
>master->cd_table.in_ste could be set when STE walks master's CD
>table. Then, you don't need to check "first". And move the guard
>back into arm_smmu_update_ste.
>
>> @@ -4017,35 +4099,48 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
>>  		.old_domain = old_domain,
>>  		.ssid = pasid,
>>  	};
>> +	int ret = 0;
>>  
>>  	mutex_lock(&arm_smmu_asid_lock);
>>  	arm_smmu_attach_prepare_invs(&state, NULL);
>> +	/*
>> +	 * Unlink the PASID from the domain before invalidating its CD.
>> +	 * arm_smmu_mm_release() walks this list with only devices_lock held
>> +	 * and writes a valid, faulting CD; unlinking first prevents it from
>> +	 * resurrecting used_ssids after the last PASID is detached.
>> +	 */
>> +	state.old_master_domain = arm_smmu_remove_master_domain(
>> +		master, &smmu_domain->domain, pasid);
>>  	arm_smmu_clear_cd(master, pasid);
>
>Sashiko pointed out that it needs devices_lock here.
>
>>  	/*
>> -	 * When the last user of the CD table goes away downgrade the STE back
>> -	 * to a non-cd_table one, by re-attaching its sid_domain.
>> +	 * When the last user of the CD table goes away, switch the STE back to
>> +	 * the domain's shared CD table (S1) or to the native bypass/abort STE
>> +	 * (identity/blocked), by re-attaching its sid_domain. The private CD
>> +	 * table is kept allocated for reuse and freed when the device goes
>> +	 * away.
>>  	 */
>>  	if (!arm_smmu_ssids_in_use(&master->cd_table)) {
>>  		struct iommu_domain *sid_domain =
>>  			iommu_driver_get_domain_for_dev(master->dev);
>>  		bool ats_always_on = master->ats_always_on &&
>>  				     sid_domain->type != IOMMU_DOMAIN_BLOCKED;
>> -		bool downgrade = sid_domain->type == IOMMU_DOMAIN_IDENTITY ||
>> -				 sid_domain->type == IOMMU_DOMAIN_BLOCKED;
>> +		bool s1 = (sid_domain->type & __IOMMU_DOMAIN_PAGING) &&
>> +			  to_smmu_domain(sid_domain)->stage ==
>> +				  ARM_SMMU_DOMAIN_S1;
>>  
>> -		if (!ats_always_on && downgrade)
>> -			sid_domain->ops->attach_dev(sid_domain, dev,
>> -						    sid_domain);
>> +		if (!ats_always_on &&
>> +		    (s1 || sid_domain->type == IOMMU_DOMAIN_IDENTITY ||
>> +		     sid_domain->type == IOMMU_DOMAIN_BLOCKED))
>> +			ret = sid_domain->ops->attach_dev(sid_domain, dev,
>> +							  sid_domain);
>
>This covers almost all the possible domain types here. So, just
>drop that downgrade, and it should cover the other cases:
>
>		if (!ats_always_on)

Thanks, I agree the reachable set here is only S1/identity/blocked, and the
outer condition is effectively !ats_always_on. The separate downgrade
check is gone in v8.

However, I don't think we can fold the inner check into a single
attach_dev() call for all cases. For an S1 RID domain this is a PASID
teardown path, and arm_smmu_attach_dev() -> arm_smmu_attach_prepare() can
allocate with GFP_KERNEL and return -ENOMEM. The IOMMU core requires
set_dev_pasid() not to fail here, so that would trip the WARN_ON() in
iommu_remove_dev_pasid(). It also flushes the RID ATC unnecessarily.

So v8 keeps the outer !ats_always_on gate, but handles S1 directly:

if (!ats_always_on) {
        if (S1 RID domain) {
                /*
                 * Switch the STE directly to sid_domain->cd_table.
                 * Skip this for stalling masters, which must stay on
                 * their private CD table.
                 */
        } else {
                /* identity/blocked: use attach_dev() */
        }
}

The private CD table is kept allocated for reuse and freed at device
release. This keeps the teardown non-failing while still using the
!ats_always_on condition you suggested.

Or I may miss something.

Thanks
Peng
>
>Nicolin
>
