Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B253C10AD
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 19:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784145272; cv=none; b=Xv0zCQuGd7O8eEWm87p8VRDETFGyMibh0lb7stS/6dRpE2bfFTI2SOeifeo1N6Jkci+DAWoGWCN0Po4WZdVVybGVlbtHjtwXlAMJoYwxa3ySF0uiPQJSlb43MV9l59V526UpfO8E7+RwDQhnqO+JlHsKYsR+9R0oZR+YtevLoRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784145272; c=relaxed/simple;
	bh=4qb8T6qmU1ERimycQggw6mEfG7vDR8984uwJV16kjJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pc8+T0Z+rf5iPnrRv9bE2wMD6zhFeNRx/+R8RlFViCf4cVI64Rye281xwVTisWc29Jalu1r2S0Tz8/iKtibrZy08CSeLK3m/yQLyC+vOnsDzoVWhGsE5QBq1tOEo8QL1iJ0HffMfyiyoNV+vIw7AsrfmMeXiNFXtbKaRMg/2U9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tBbDac7H; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tBbDac7H"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cacef7d299so2035ad.1
        for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 12:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784145269; x=1784750069; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m53R6Qi+zQcNj87e/Jawa3dfMVvzT1k6XowiuqLX1eY=;
        b=tBbDac7Hy/DXvXd/oX6Yqz+Lxn2ZERy5z4xBxsRfH2QCvyFR7jigdO1Cpx6Ft4JL1d
         V5rSCcbhYnwVJP+/asKhZ3xfH/OP4h/emzocC01+cAypDjWTUFUAbQmdhpjnRi2dvMA5
         B+wSzgAYPVobq6Z1Iz90MXqq3E0Rog5W/DxlBBD+PgXvJTHBifXTsI4kA/6LT+A+8vs5
         2CZzL80NpQJ73HyQq8JO6dJb8cDWQ6Wx0oKSD1lQ9bCCcRYhm5k3Feo3FuZdbm+YhkZc
         7GCeH4MsFihiIFYt1tf03Smwj05Oy0XyxaxGjWC1lX8xHaqeG+x6lan9PFchNdDPcfj8
         tKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784145269; x=1784750069;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m53R6Qi+zQcNj87e/Jawa3dfMVvzT1k6XowiuqLX1eY=;
        b=h0bBrYYinB1PS/TDAINCQZEvAL5Jiu091EU8L1REkHKvekaXu0FRU/qCsdArdBuQ7R
         4JOe/XJLl3n57IxqzPXro3cN71/ZIXnJYgMG2Iuac/ru+phV6ktLQd+1UhVI8gJ/aVX8
         SLmgNnAxSU3Aku85e2oPh5DvgUvoozH5lEL6IvJKcADv9GGPEzuX+JUTbBP82lB50rJW
         +F1lGzzYmwMEqyYmjaVrjIyyxX3iQO18fyUUHTl5lk6tm8py0Qr0FXJCXiErEB3H561J
         bPp+qy5BBAMABmwP1MxeyREXt39GceWvRAwgBceeorStcTuIwsNUw6JCFzFka8bPQvkK
         8m0A==
X-Forwarded-Encrypted: i=1; AHgh+RoLm6fBZ4FVoTlJEsfGgbRA6rqeaU3oftVH8MfBKgrFiCHfspM/yt3z+VCAhHegYNSFMmS1Hg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+mTK5PvaC9KLlQlQnpZnOcLMBP9tjABtiAAnq8FHwRr+PIVid
	1sQ9vO+1BMFB88/Jq4lbWSArZvhNpeKdtiWt5NSYCXbpAEUjYW/VBPnQSPzvMWvfHw==
X-Gm-Gg: AfdE7ckaAQPvoVjrgqdQ5art6eKTrYRsMmXx/HDgwQV+E3+aeNqoYGYMFs8mpN3vt26
	FJjZXDjfcpgN122SYPI40RaCsuJJ/eJW6r2HuM6aMeM1/y0tFmUJhvGc3NDKFAqoci/xQ4FgC0T
	tZ1zq9Da+towmtOqPKhIpvJOAbGjFHakluqrGJX4gBz4JwHubzrKP41QFXK1rWlfgbN6dj2dvNm
	Mq17iV8cc6CUboCRLQQ+5OLcRuOpyZVPRuBOTphTH/pQzBx6BtWd+FRfzyBHXOs9fGdTidN4lyf
	LtYqiGqQ/PHPDePvZCtPnhTBr4CknqqfC+0SGuHCuLTbx+6Gcounu2c+H7IRoHM7OwjnCLvfcYe
	RzsO4hSvhlkYH9hWOTGepEt0+emEr93j4m/rr8FFd3VcWlRt9eCbny+QTxAYUKyhajXDwJX33Zn
	wVZkDyXeQGHAZFohMfgYTOL17nUCA3h0Ru6JF4tYBW60IQvCs=
X-Received: by 2002:a17:902:e804:b0:2ca:bf8e:360b with SMTP id d9443c01a7336-2cf1a93edebmr466595ad.9.1784145269137;
        Wed, 15 Jul 2026 12:54:29 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f271ddbsm3883142b3a.18.2026.07.15.12.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 12:54:27 -0700 (PDT)
Date: Wed, 15 Jul 2026 19:54:21 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] iommu/arm-smmu-v3-iommufd: Reject unsupported
 bits in invalidation commands
Message-ID: <alflbbClvEp_k6u-@google.com>
References: <cover.1784054606.git.nicolinc@nvidia.com>
 <5c70a336821e3cea176356470d94ff18329ff867.1784054606.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c70a336821e3cea176356470d94ff18329ff867.1784054606.git.nicolinc@nvidia.com>

On Tue, Jul 14, 2026 at 11:48:48AM -0700, Nicolin Chen wrote:
> The arm_vsmmu_cache_invalidate() op hands a guest's invalidation commands
> to the trusted main command queue after enforcing only the VMID or the SID,
> and passes the rest of the command through to the queue unchanged.
> 

[...]

> +
> +static int arm_vsmmu_validate_user_cmd(struct arm_vsmmu *vsmmu, u64 data[2])
> +{
> +	struct arm_smmu_device *smmu = vsmmu->smmu;
> +	u64 allowed[2] = { CMDQ_0_OP };
> +
> +	/* Collect the fields userspace is allowed to set for each opcode */
> +	switch (data[0] & CMDQ_0_OP) {
> +	case CMDQ_OP_TLBI_NH_VA:
> +		/* An SMMU with 8-bit ASIDs treats the upper 8 bits as RES0 */
> +		allowed[0] |= FIELD_PREP(CMDQ_TLBI_0_ASID,
> +					 GENMASK(smmu->asid_bits - 1, 0));
> +		fallthrough;
> +	case CMDQ_OP_TLBI_NH_VAA:
> +		/* NUM/SCALE/TG/TTL are range fields gated on FEAT_RANGE_INV */
> +		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
> +			if (arm_vsmmu_validate_range(smmu, data))
> +				return -EIO;
> +			allowed[0] |= CMDQ_TLBI_0_NUM | CMDQ_TLBI_0_SCALE;
> +			allowed[1] |= CMDQ_TLBI_1_TG | CMDQ_TLBI_1_TTL;
> +			/* SCALE bit 25 (values above 31) is RES0 without DS */
> +			if (!(smmu->features & ARM_SMMU_FEAT_DS))
> +				allowed[0] &= ~FIELD_PREP(CMDQ_TLBI_0_SCALE,
> +							  BIT(5));
> +		}
> +		allowed[0] |= CMDQ_TLBI_0_VMID;
> +		allowed[1] |= CMDQ_TLBI_1_LEAF | CMDQ_TLBI_1_VA_MASK;
> +		break;
> +	case CMDQ_OP_TLBI_NH_ASID:
> +		/* An SMMU with 8-bit ASIDs treats the upper 8 bits as RES0 */
> +		allowed[0] |= FIELD_PREP(CMDQ_TLBI_0_ASID,
> +					 GENMASK(smmu->asid_bits - 1, 0));
> +		fallthrough;
> +	case CMDQ_OP_TLBI_NH_ALL:
> +		allowed[0] |= CMDQ_TLBI_0_VMID;
> +		break;
> +	case CMDQ_OP_ATC_INV:
> +		/* ATC_INV is illegal unless the SMMU implements ATS */
> +		if (!(smmu->features & ARM_SMMU_FEAT_ATS))
> +			return -EIO;
> +		/* A Size above 52 (invalidate-all) may raise a CERROR_ILL */
> +		if (FIELD_GET(CMDQ_ATC_1_SIZE, data[1]) > ATC_INV_SIZE_ALL)
> +			return -EIO;
> +		/*
> +		 * SSV/SSID/Global need substream support. SSID and Global are
> +		 * IGNORED (not RES0) when SSV == 0, so they need no SSV check.
> +		 */
> +		if (smmu->ssid_bits)
> +			allowed[0] |= CMDQ_0_SSV | CMDQ_ATC_0_SSID |
> +				      CMDQ_ATC_0_GLOBAL;
> +		allowed[0] |= CMDQ_ATC_0_SID;
> +		allowed[1] |= CMDQ_ATC_1_SIZE | CMDQ_ATC_1_ADDR_MASK;
> +		break;
> +	case CMDQ_OP_CFGI_CD:
> +		/* No SSV for CFGI_CD; SSID requires substream support */
> +		if (smmu->ssid_bits)
> +			allowed[0] |= CMDQ_CFGI_0_SSID;
> +		allowed[1] |= CMDQ_CFGI_1_LEAF;
> +		fallthrough;
> +	case CMDQ_OP_CFGI_CD_ALL:
> +		allowed[0] |= CMDQ_CFGI_0_SID;
> +		break;

Nit: Although, the convert_user_cmd would check the CMDQ_OP again, it
seems like validate_user_cmd would return 0 for an unsupported cmd that
doesn't match any of the above cases, should we add a default case and
return -EIO there?

> +	}
> +
> +	/*
> +	 * Reject any other bit, e.g. a RES0 bit or a Secure bit, before the
> +	 * command reaches the trusted main cmdq, so a guest cannot wedge the
> +	 * shared queue for every device with a CERROR_ILL.
> +	 *
> +	 * By contrast, an out-of-range address or ID value does not need a
> +	 * check: the spec defines it as CONSTRAINED UNPREDICTABLE, which is
> +	 * scoped to the guest itself and does not raise a CERROR_ILL.
> +	 */
> +	if ((data[0] & ~allowed[0]) || (data[1] & ~allowed[1]))
> +		return -EIO;
> +	return 0;
> +}
> +

Apart from that,
Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
