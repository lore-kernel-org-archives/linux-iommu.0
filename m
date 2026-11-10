Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322709;
	b=QmctaxnOM2h7acGcFSjsS92YTk+VjT6RYFwod3L2pd44pYaAfN+SN0qX+1NxQjZPADDP
	 kncWP4A33i3zwxV4JOvtoqyQzLXLJ86YZu22NYFaPM6xJgGkCHVNwiPo3cxK/4XcKawtO
	 h1EZb5DavV0U1gk051sEtrbNST1ZLZGx8iIE7x6V4dhTNTD7DsKuw2UWst3dxzV+ib8ie
	 E+ACHsnREts6ql+LHEt0VewpMZbTbbhyf3WBxfQIkEaIEpbILGXuGy0hUjypyJzr+23LS
	 +leTsyS2Mg3/8PEMvjv5GOd7vdzKLeDU/8gqsl+OvrgPqIN5Qpj/RhArRGYp5pX1Nzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322709;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ilFrMbP1l4Dqble5vGUZCzOuHvz/JIBo8vMR2z18T1Y=;
	b=tPbwmoARqmU8/pKTNWVBgGfw8Fd+8/qIlbCWwtC2JONc9nj5/9d1qnZO7rgU+qzR3r79
	 cH5JkFZnPZxDJaAC07aBRGLzvA+sTV7wx/TrI3nbQAMyJHda5DS6gK2e4tZBzxdr5OeL2
	 g7lKbgQbHnAo91LSBRFYOLvzHV1YWp6arpZmlgBfQW2bl3W02lv7fwMbuI2xUjuP+0EbI
	 UiNxa2mgSonnPOqmoom2qT8d9/SOT8zoOFqFZdYbTTgu0MV6RNaNzp6zYOMSd+Ji7nSFS
	 fcDBR3D6OijjKcvY3KC1gUQ4+gpmE+CfOxHElQjpC6plLId+hH1tcO/gKJjvWmDKptA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VGB6Rlw8;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0012606A335
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 14:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0012606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VGB6Rlw8
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4b6266b5bc4so39575e9.1
        for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 06:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794322707; x=1794927507; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ilFrMbP1l4Dqble5vGUZCzOuHvz/JIBo8vMR2z18T1Y=;
        b=VGB6Rlw8pfpbnN/au7jWJrwyX8CtMnLDdwjrkvp7aDpZhlWpiy6kdEELHHl/5N+dtW
         nqAZOGOnGq8TiUZAf9m7/N7JSD4vOa9zXdft6gIDaDA06+xYsFSFnulSrjkm8VZ88kuH
         hfg/E8jXBXBFu+n4eyd/u1b1lPISawzBRzH/tg/zUWGQ6dfW39WE3Gw7LbufU61/+06b
         qollfvFvBRQ8Ymc/FM48Voamayd1Ns9Pc6t4vHtFGnCkRsoYOrSwoCvUOpiTZS+2gNly
         a+YmDxgXisN8oVUNyykY8UqPgEmJF1yX/2s39qFOy8mZRfwJ4th6gpFn5mFDkgYqTrJk
         rqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794322707; x=1794927507;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ilFrMbP1l4Dqble5vGUZCzOuHvz/JIBo8vMR2z18T1Y=;
        b=DffsMbsD9LeVKmvaFlsdl2nCgPiKPToFz/zGYmTXpQX+v0ZQ80RBuFE/H27y5X2A4u
         D0euuyYP+IgYrOvMHAL9PpRk0Po0iLUYPGeyoKNOueiX/HRw1Gq3CMaakZr9ELgbkapW
         C/GJ/c3CJj/pPqG68CvWOpUzD1EGUK070+xwHcvoe2r42MKz0G37oFlGvDM2l1jqP4fw
         674I+Y0r6qMxt2UlOYyAoZQbnYTh7v8Qmzp0uHCMDYQznN0MEU1RbOZRQUX7SpEbN0Rh
         0S8ptP55Cqf85DEDYBVRj+0ywgMvyCuVcwqEDleb3OvZda0CgKrOl8gK5/oaOQhvgrE8
         YT9g==
X-Forwarded-Encrypted: i=1; AL+hErFVHBHHj7F1Hq4oiwhViY2ljAse5i3jdLBds8pAKwMLvTodLAmLpH5mtKLTcatmeHlH2PvXVw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/gVPElBzBb8JC+H8gSofdCCtuU5/E25TYcEi9I7qxu3XxqyYz6
	527ZYXC3IyKh6ihcT0DE+JmVKIhG/jS5vU7uUfdAuyBapt/bYfUy+E8zjFLqsFhXOA==
X-Gm-Gg: AYBFou1C6MV0zUIpHiygTSZ3QLGZQQSzesgM8o4lwg4aga+KqnnTth93cwIsnmwJv0S
	iCrG155GSACIzHpuLVM1kWINKBe03UYSjxmnqwiG4RIj2I2TlpyjHbjthW/mpApF4SIIH5Q3m9z
	FOoZYC5v/q3IXtV/mRQTii7h78AHc2FAECWy9MZ2qkH3RfcTzFSThHPptWXKFYpnqlElWEqMIUB
	5LxMKM0j8f7XaKb98gTKgffaP1J9giR2JreviYw0BpgCAhgLFgGTX3FCsIMdfNQKAC3JyxcxxO9
	Myo+h6TMh2Sv+S4z+QF45FUi1W4WVC1Gw3wkGzliOjVZoiwAqlwTLn62izs04XVh5iMtOklfL1y
	18Y0QCUAKhOqCwmu3OtifZJfT8hYY6I32dG5+Nk2MJ23EbNuO8rWPGdGZ/iTa2uitxCchoucegb
	xF4M/TQt9bAswWI+tvQfF5PfSxt/xs4nt0sB98XHGvhluX1CvSaArnEpBuhrrrdfrL2e5ldDpTz
	NJP+vkNqGsuaP50WRtO+2yebDWExIfixBp6uFj+ZuEOOHIoHUjQb7jhp0yxPyFwFFVddS0rzHgF
	za8RksXtG2hIQOnFYhDKpJGqcKo+vlqA7p8uus2ENafmvT5Hm7gKw4lb43rMfbWZPUSt0AE=
X-Received: by 2002:a05:600c:4301:b0:4b6:24ca:8848 with SMTP id 5b1f17b1804b1-4ba02bdf97bmr587755e9.11.1794322705998;
        Tue, 10 Nov 2026 06:58:25 -0800 (PST)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0223c41csm70632855e9.14.2026.11.10.06.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:58:25 -0800 (PST)
Date: Tue, 10 Nov 2026 14:58:21 +0000
From: Mostafa Saleh <smostafa@google.com>
To: xuheng@cs.columbia.edu
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Invalidate a new level-1 stream table
 descriptor
Message-ID: <avMxDbv6JE0dg93E@google.com>
References: <20261109-smmu-l1std-cfgi-v1-1-65e5203a6516@cs.columbia.edu>
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
In-Reply-To: <20261109-smmu-l1std-cfgi-v1-1-65e5203a6516@cs.columbia.edu>

On Mon, Nov 09, 2026 at 09:36:54PM +0000, Xuheng Li via B4 Relay wrote:
> From: Xuheng Li <xuheng@cs.columbia.edu>
> 
> arm_smmu_init_l2_strtab() allocates a level-2 stream table when the first
> master in its range is added, and makes the level-1 descriptor valid. It
> issues no invalidation, and the attach that follows sends only the leaf
> form of CMD_CFGI_STE.
> 
> IHI 0070 5.1.1 requires the non-leaf form of CMD_CFGI_STE when an L1STD
> changes, including when an inactive descriptor with Span == 0 becomes
> active. An SMMU that cached the inactive descriptor can keep terminating
> the master's transactions as if its StreamID were invalid.
> 

Looking at the spec it says:
	An STE or L1STD that is successfully fetched might be cached by the
	SMMU in any state, therefore any modification, commissioning or
	decommissioning of an STE must be followed by a CMD_CFGI_STE command.

Which checks out. However, I am curious why this was not seen for
over 10 years with the current behaviour as I doubt any existing
implementation will do negative caching. Is that something that was
observed or found by inspection?

Interestingly, that is not the case for L1CD:
	/* An invalid L1CD can be cached */
	arm_smmu_sync_cd(master, ssid, false);

> Issue a non-leaf CMD_CFGI_STE after writing the descriptor. The RMR path
> runs before the stream table is programmed into the SMMU, and
> arm_smmu_device_reset() then issues CMD_CFGI_ALL, so it needs none.
> 
> Fixes: 48ec83bcbcf5 ("iommu/arm-smmu: Add initial driver support for ARM SMMUv3 devices")

With the few nits below:
Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> Signed-off-by: Xuheng Li <xuheng@cs.columbia.edu>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 6d4520c47..f61cc6d86 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2030,7 +2030,8 @@ static void arm_smmu_init_initial_stes(struct arm_smmu_ste *strtab,
>  	}
>  }
>  
> -static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
> +static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid,
> +				   bool live)
>  {
>  	dma_addr_t l2ptr_dma;
>  	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
> @@ -2053,6 +2054,14 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
>  				   ARRAY_SIZE((*l2table)->stes));
>  	arm_smmu_write_strtab_l1_desc(&cfg->l2.l1tab[arm_smmu_strtab_l1_idx(sid)],
>  				      l2ptr_dma);
> +
> +	/*
> +	 * The SMMU may have cached the old, invalid L1 descriptor. Making it
> +	 * valid needs the non-leaf form of CMD_CFGI_STE (IHI 0070 5.1.1).
> +	 */

A similar comment to the CD case is enough.

> +	if (live)
> +		arm_smmu_cmdq_issue_cmd_with_sync(smmu,
> +						  arm_smmu_make_cmd_cfgi_ste(sid, false));
>  	return 0;
>  }
>  
> @@ -4261,7 +4270,8 @@ static bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
>  	return sid < smmu->strtab_cfg.linear.num_ents;
>  }
>  
> -static int arm_smmu_init_sid_strtab(struct arm_smmu_device *smmu, u32 sid)
> +static int arm_smmu_init_sid_strtab(struct arm_smmu_device *smmu, u32 sid,
> +				    bool live)
>  {
>  	/* Check the SIDs are in range of the SMMU and our stream table */
>  	if (!arm_smmu_sid_in_range(smmu, sid))
> @@ -4269,7 +4279,7 @@ static int arm_smmu_init_sid_strtab(struct arm_smmu_device *smmu, u32 sid)
>  
>  	/* Ensure l2 strtab is initialised */
>  	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
> -		return arm_smmu_init_l2_strtab(smmu, sid);
> +		return arm_smmu_init_l2_strtab(smmu, sid, live);
>  
>  	return 0;
>  }
> @@ -4333,7 +4343,7 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
>  		struct rb_node *existing;
>  		u32 sid = new_stream->id;
>  
> -		ret = arm_smmu_init_sid_strtab(smmu, sid);
> +		ret = arm_smmu_init_sid_strtab(smmu, sid, true);
>  		if (ret)
>  			break;
>  
> @@ -5713,7 +5723,8 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
>  
>  		rmr = container_of(e, struct iommu_iort_rmr_data, rr);
>  		for (i = 0; i < rmr->num_sids; i++) {
> -			ret = arm_smmu_init_sid_strtab(smmu, rmr->sids[i]);
> +			/* The stream table is not programmed into the SMMU yet */

I don't think this comment is adding anything, there is another one a
couple of line below.

> +			ret = arm_smmu_init_sid_strtab(smmu, rmr->sids[i], false);
>  			if (ret) {
>  				dev_err(smmu->dev, "RMR SID(0x%x) bypass failed\n",
>  					rmr->sids[i]);
> 
> ---
> base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
> change-id: 20261109-smmu-l1std-cfgi-c194b2aafea4
> 
> Best regards,
> -- 
> Xuheng Li <xuheng@cs.columbia.edu>
> 
> 
