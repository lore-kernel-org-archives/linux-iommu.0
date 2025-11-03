Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39A11DB12C
	for <iommu@lists.linux.dev>; Mon,  3 Nov 2025 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762180182; cv=none; b=O3iEi4igpO5i2dsykZvFGFnQzec0fkQjinmq407n/zIIumJZRapAzwYAKoSnk663hz+mwUxot4hmXHSEs0kV314Jg0X8yTSRZIZH7j9BOCmzAlqX87eeEFgp5hZa0Y8JyqGHn3l3Ge4uKZWJq+QVAmbjTLsEgctv4jkuRKKEcaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762180182; c=relaxed/simple;
	bh=kopMZhSSVjSpU7vbwiXfUO/3/NCj6jgZ4saCZU03NSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sb9pXH14XHlExM+3MLUzUgwRq4gAkjzehxoI39KJEMvTgMTXVdD/Y/xVgC1wtqXA1D9jDzUBmlcDXxPQPnbmZiOp50nLrUhGwOtbNd1UuWs7WOey/3ZD/FEiQmFncN+oBB4FjnxBb1wQh9HPuMIfdT+Tgjh+u9gMPZdlmgYAmEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nfxgLFo2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nfxgLFo2"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2959197b68eso279115ad.1
        for <iommu@lists.linux.dev>; Mon, 03 Nov 2025 06:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762180180; x=1762784980; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h2ss4O/i4KxhkbN9o8nJ4rRjGt4fkGep+vaOCctZv7Y=;
        b=nfxgLFo2pcAguHLqbIFiZ7TtMPbZdtsjK3+GJPzj5sckTRyLoR6IdtVSXASB4bBMl2
         j96tsYmmlszyWX9RKmsiBXRtDdYh/FyYubjz7iop3S4w4q+3xAoL5vDspzk3KdjhBZP5
         gyXqt3W4TX+5j6mhxU8l4cu3z/msu1YW0s7ljYiDFYLdhC+XfS4orq5o4o5ehWAZAaT3
         WF9eR86O2BI11XtJlfhk5CN/4066THIGClEB1XX53wlEX9vC8Gql4P5VkH0OvzwmWHx3
         XK4BtqXPJM8F8hWj+I8xmqmY1alisrsw6ORodlI7SzFSAFOKnRel7LffXV95kR60m0UY
         PFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762180180; x=1762784980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2ss4O/i4KxhkbN9o8nJ4rRjGt4fkGep+vaOCctZv7Y=;
        b=DJDeFXZaGvkD3JgJProxAkqDN1R5h4KSUYJvoncjHOIqblUBPH3UTCDJ4gezLQdtwC
         +Xuz7x3FZi4Y9GBXWQEnM8ePSYl2Upq3HrLSyf9gkS5ow/77jJu1eFCNiWu5ngwkRngZ
         mWXxNrqgZ1kzjYiueww35a53iIC4r0o0DEFvuJLSV7hecLMd95yw53j74MIjTIymOBeX
         3LWfvnX2f/Uk4+3JX5kuimJrJWxKwwatZy2XXVI5Cr1F7nSu6SbBadmDwPLMGT5585js
         Je4W4Jz2ESRcUFwqnucao7bmuPp50gGnaDiDO5asooDeeWLXZDaEntWgkR/6S6kuLZZe
         tYiA==
X-Forwarded-Encrypted: i=1; AJvYcCXbK9jwAMG6KktwO98BnI75n2rboqojDDuHcHrg6k02PFNiaFKpbkssrdLh0Knu+w7vLTt6zA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNXC3dMvokHMUr8gJPMuyNjybx+mJy3fqJp1VbTzAIjd1Jwab7
	1Bb3cmxV1MUv9nHGNEnHMKCtMSRKdfMNGc+fQ8kpRQVB6jvuyA8RePP8xxQaPH+Xlw==
X-Gm-Gg: ASbGncv4q14+PPxqPCWXLvRb9ixwPjrXHJZELAsiDu64fo15za5d8htbMMDl6VxA/Rx
	6gmcZdgETo6Wjuco2hM0TqPlLpAgs+20/8D17JqPYDRAogUllV5TRvdXiA5rlQIELMxGOyIzdSb
	qhkl+YXAsiC2S7REIWSC4ee50u0MXNRUOM1rjnzB05VZk48VHEhiA082CMd95syHNzA6VHJzyL5
	mzYpVi0KaRLt/gZc5tSCSo1kQ6yvlLCmWmSe9krK5FSvDvSVNP00KmB/1vKCfrJs/QLImQ8GI4u
	/EalYBbkyRIDOrEpVFUtH0//A2N+F9FaPVu/lOo/9COITrTc98HF/sAP8fk38ixqDDDGncAHvD0
	R6lbway0fhhNyLORq9JuBGLB4cf89L+gi8yAqbWrhIO08vaT4lOgyKIkEglz71cTfJez/qZjPVa
	VsWee+8Vmlup68CJP0DnEWbfmBao0E2KTpav4jPQ==
X-Google-Smtp-Source: AGHT+IGgprIYvEObzhmjpC9qpNiNgXC4S+j2D9xeUV3N2fiXTSvqkcZt/SDTOp4IK0p25zBW1FXM7Q==
X-Received: by 2002:a17:902:e548:b0:26a:befc:e7e1 with SMTP id d9443c01a7336-29554bab74amr6694685ad.12.1762180179869;
        Mon, 03 Nov 2025 06:29:39 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29556d61c4dsm87954645ad.56.2025.11.03.06.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 06:29:39 -0800 (PST)
Date: Mon, 3 Nov 2025 14:29:34 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	kevin.tian@intel.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	skolothumtho@nvidia.com
Subject: Re: [PATCH] iommu/arm-smmu-v3-iommufd: Allow attaching nested domain
 for GBPA cases
Message-ID: <aQi8TivdgmtAyb7v@google.com>
References: <20251024040551.1711281-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024040551.1711281-1-nicolinc@nvidia.com>

On Thu, Oct 23, 2025 at 09:05:51PM -0700, Nicolin Chen wrote:
> A vDEVICE has been a hard requirement for attaching a nested domain to the
> device. This makes sense when installing a guest STE, since a vSID must be
> present and given to the kernel during the vDEVICE allocation.
> 
> But, when CR0.SMMUEN is disabled, VM doesn't really need a vSID to program
> the vSMMU behavior as GBPA will take effect, in which case the vSTE in the
> nested domain could have carried the bypass or abort configuration in GBPA
> register. Thus, having such a hard requirement doesn't work well for GBPA.
> 
> Add an additional condition in arm_smmu_attach_prepare_vmaster(), to allow
> a bypass or abort vSTE working for a GBPA setup. And do not forget to skip
> vsid=0 when reporting vevents, since the guest SMMU in this setup will not
> report event anyway.
> 
> Update the uAPI doc accordingly.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    | 14 ++++++++++++--
>  include/uapi/linux/iommufd.h                       |  7 +++++++
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 

Overall, the approach seems fine as it adds value since we can't have
vSMMUs with ABORT / BYPASS config with the current code.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index 8cd8929bbfdf8..7d13b9f55512e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -99,15 +99,22 @@ static void arm_smmu_make_nested_domain_ste(
>  int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
>  				    struct arm_smmu_nested_domain *nested_domain)
>  {
> +	unsigned int cfg =
> +		FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(nested_domain->ste[0]));
>  	struct arm_smmu_vmaster *vmaster;
> -	unsigned long vsid;
> +	unsigned long vsid = 0;

I'm a little confused here, can we not have a vDEVICE allocated with
vSID = 0 ?

IIRC, vsid is given the value of vdev->virt_id, whereas vdev->virt_id is
allocated in iommufd_vdevice_alloc_ioctl() using the user-provided
cmd->virt_id.

Thus, should we mention this in the uAPI that vdev->virt_id 0 is reserved?

Because otherwise, a VMM may actually allocate a vDEVICE with vSID = 0
(which iommufd currently allows) and we'll start dropping its events
due to the if (!vmaster->vsid) check below. This would be a functional 
regression for such a VMM.

Perhaps a separate bool has_vdevice flag in struct arm_smmu_vmaster
would be clearer and avoid this ambiguity, allowing vsid = 0 to be a
valid ID for an allocated vdevice when user-space explicitly requests it?

>  	int ret;
>  
>  	iommu_group_mutex_assert(state->master->dev);
>  
>  	ret = iommufd_viommu_get_vdev_id(&nested_domain->vsmmu->core,
>  					 state->master->dev, &vsid);
> -	if (ret)
> +	/*
> +	 * Attaching to a translate nested domain must allocate a vDEVICE prior,
> +	 * as CD/ATS invalidations and vevents require a vSID to work properly.
> +	 * A bypass/abort domain is allowed to attach with vsid=0 for GBPA case.
> +	 */
> +	if (ret && cfg == STRTAB_STE_0_CFG_S1_TRANS)
>  		return ret;
>  
>  	vmaster = kzalloc(sizeof(*vmaster), GFP_KERNEL);
> @@ -460,6 +467,9 @@ int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt)
>  
>  	lockdep_assert_held(&vmaster->vsmmu->smmu->streams_mutex);
>  
> +	if (!vmaster->vsid)
> +		return -ENOENT;
> +
>  	vevt.evt[0] = cpu_to_le64((evt[0] & ~EVTQ_0_SID) |
>  				  FIELD_PREP(EVTQ_0_SID, vmaster->vsid));
>  	for (i = 1; i < EVTQ_ENT_DWORDS; i++)
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index c218c89e0e2eb..a2527425f398b 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -450,6 +450,13 @@ struct iommu_hwpt_vtd_s1 {
>   * nested domain will translate the same as the nesting parent. The S1 will
>   * install a Context Descriptor Table pointing at userspace memory translated
>   * by the nesting parent.
> + *
> + * Notes
> + * - when Cfg=translate, a vdevice must be allocated prior to attaching to the
> + *   allocated nested domain, as CD/ATS invalidations and vevents need a vSID.
> + * - when Cfg=bypass/abort, vdevice is not required to attach to the allocated
> + *   nested domain. This particularly works for a GBPA case, when CR0.SMMUEN=0
> + *   in the guest VM.
>   */
>  struct iommu_hwpt_arm_smmuv3 {
>  	__aligned_le64 ste[2];
> -- 
> 2.43.0
> 

Thanks,
Praan

