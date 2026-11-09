Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794225720;
	b=WeXFTRpMgUHBs3Kvbi1R8d19c9kOf75IxWTnCAjXiZoybwYYmdqrqrRlH2u5hzMVVEOd
	 wOx2Smkofq9pETXKL/3NVsRJyfajAin+BmegQiBSQ2LIdFTHnTmIAECri6/VFYsxguoNx
	 QFDwDpBGrwwHlDeZWAi6HwY05v1lZ1VS41zQ07arnMPFvqe2bfsfavTEWezIGJ0DUoO5L
	 ffYiKjvOLYA5e3Zh+w/01QfQKnDNjrzf8dnw+aPc74hUpyvGmgiXeZ8YM8poJg9emS82E
	 DJ9rKPQA2Nq1XCFXMV4Q5nX80t9zq8NAsrT3kZ+nFisCGkZuPljop9PAlLrX/gvyJLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=szgQb0dY5ZnhzHxi0dDY7s5APqPVFKBR+bd+pkS5brY=;
	b=IN2D4u5mtv83kZnDOixTI32dacdVdXt21pSfHE9Pt+AvI9YarFUldz5qXqzUj/xqhFyl
	 MWOy3l9WI3Suz+V++jfceDZ0CIUjPyWway39Rj65r0M6mhXaQ7ab+E13CQlvAqk/qLwdO
	 45eoqJE1SEm2AGAqI4RXQUpxD5mvAUCQ2TNRJQAdJfJgVaCbUHUpeaW0mJbp7hOeOWKEK
	 WbyZkQCypS7Aw7jha/7zzvneHoy4p0uXfF/GzcoLxjXpIu9a5EXLZ7VebNe5G0C9kIV15
	 Vy17c/rnZKbUDJ4ED0xEnad3Uib7F5d6Bg40gh0+tRwGLVUdWv6imcEYfSa8FfkISNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BqRRyPiI;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62907606A321
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 12:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62907606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BqRRyPiI
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4b76c15ae36so25925e9.1
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 04:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794225718; x=1794830518; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=szgQb0dY5ZnhzHxi0dDY7s5APqPVFKBR+bd+pkS5brY=;
        b=BqRRyPiIWei3DcDNGeeqWshIPB8zgfm2M+/g33eQEK19oD1Pe80oQibQp7rmNnF6yQ
         pygu5tf313rllBWZzOn259sxaIncw85GaviGyGvmMhg6o9Ss8Qr94IOLSvl5mcb/wmTl
         bVjkOsgVhY0vbuyw2loCeZfDXch8vCLF2OHaev9KDndgngj1W7atAoIuYW2GPyQKhaZw
         JBBfjcaLvyojsk+GqUf1X/oPNX5QPFxRSp6mbmoaVHhaLK5Bh73t/9W/uWLLMQJ+39KO
         Erd6i7vhxrHdDJVz/Bax5lkiKin72q6UPrrJ3yZoezfweXgi2zViP0dNfKRXhk4JZEM0
         Z3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794225718; x=1794830518;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=szgQb0dY5ZnhzHxi0dDY7s5APqPVFKBR+bd+pkS5brY=;
        b=fAnaS/fP/75SYokVSdLfm2LVZv1f26k5djvaHic17gbl5x+qJAoc5ynUImRIRZQTQp
         SZRQAYUfLtNUx2Da99+8UhL5Ps1eJ09jdoZdmBJSOa+lIJ7CHogoqG+SknbMrRvfdj3t
         TraW4ddz1JdKL2JEW8tjVZctV7hgnBbCHknCSA0ZiAcTvYagGpBRYMC7CClZJQ3BVNX6
         mI/EstAzoThae7zH/tVW19/neudtzA/7SDKPLle83J1luz9JVw4ZT3Uww+oy21EHEmkV
         +Tv+lxtal1b4NK+5Ynig/UDtGMzCX2pj1+gQSP6U4BOlmcSnHkn1wPrlhi5E4SR1WnS0
         DVIA==
X-Forwarded-Encrypted: i=1; AL+hErHl0jVkF87aXqKH+P1pWTXRFjz4T2/+JHo7gzbGxPCdT7zyKWCSILYhAHL4czpkHYK/wVhcZA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+as43BzioiEvfmgov80A1FlmcZ5y+r2u8l/lmHxecaATOjyVRm
	7+TiPW3IHzQ2o1YtwKruedBv8+jTFcH9XsRid4GTeqO2iqoXleh56IzZDBLpHUktbw==
X-Gm-Gg: AYBFou2iEGJO1/OZdArE6WH9UZ6zVW0derMiLecypDuIbW15sYTqDp0HWfdQpwLoR7k
	FPpH+QqJBcYwIomE/SVYWfGngnygxi0CVr2h3A5wLwYJdwbs+5RZZC/E9XoqMiRJGuATAohYgtb
	QtBzzHGFN1ljuTuIyu0Gbws3ozHzYV5A83i44Fv+kbe6y3XYOJ6N++Ij3jJJm7Jl1Ge81rQMary
	Ej9XxqrzRC+nD7Ywmwb2I/AMpbRVUgngywl+eCXokqHKMAel0QP7KbTyIdVW0Y9AFoZvXimtCzk
	eIlUA8LJOd9E1t9ezAHWX3OsYShYbdddtDQDFbNezei9W4uJWMymiSDVP+ApYaaXXGlJLJQtXcn
	ePgTpV/pX/vYLtkyle2mObFNjCyXCrTHY6J1mZDp7akjQlRv/7AuNqG67vEpzFZnOhcIeJuBp5m
	5fS5FJEPnzZkmlNLuPdXIrs3UzdkL1eumIbm0l280F68NjIJUoPcNnvAZogtmENc5puSXTTkWMD
	lrhST/AQfbh8IFtwq+ktAjlxsmNSGjVQ/aQ1Ara8zja1a5Vl3s4UK1ZyjtzIym2IDEDvj6uUPCO
	I55PGegn4rysrBrQ/GvVSfH+4eBCyBKrNg/X0Vq+WuJgIAA9uHHeD8Gg3TbCwcbfgHQrew==
X-Received: by 2002:a05:600c:c055:b0:4a2:bd1:a80a with SMTP id 5b1f17b1804b1-4b811e398ffmr1476265e9.2.1794225717416;
        Mon, 09 Nov 2026 04:01:57 -0800 (PST)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4967003fefbsm5468334f8f.13.2026.11.09.04.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 04:01:55 -0800 (PST)
Date: Mon, 9 Nov 2026 12:01:48 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jgg@ziepe.ca,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com
Subject: Re: [PATCH v9 17/25] iommu/arm-smmu-v3-kvm: Shadow stream table
Message-ID: <avG2LCJVZIyhWQSG@google.com>
References: <20261015200903.2735565-1-smostafa@google.com>
 <20261015200903.2735565-18-smostafa@google.com>
 <au4uTxliZFv12Bqn@nvidia.com>
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
In-Reply-To: <au4uTxliZFv12Bqn@nvidia.com>

On Fri, Nov 06, 2026 at 11:45:19AM -0800, Nicolin Chen wrote:
> On Thu, Oct 15, 2026 at 08:08:48PM +0000, Mostafa Saleh wrote:
> > @@ -538,6 +655,7 @@ static bool smmu_dabt_device(struct hyp_arm_smmu_v3_device *smmu,
> >  
> >  		if (is_write) {
> >  			bool last_cmdq_en = is_cmdq_enabled(smmu);
> > +			bool last_smmu_en = is_smmu_enabled(smmu);
> 
> It'd read better with smmu_was_enabled and smmu_is_enabled.
> 

Sure, will update them.

> > diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3-hyp.h b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3-hyp.h
> > index 3903ae358555..31ab7a0335a8 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3-hyp.h
> > +++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3-hyp.h
> > @@ -27,6 +27,12 @@
> >   * @cmdq_host:		Host view of the CMDQ, only q_base, base_dma and llq used
> >   * @cmdq_max_shift:	Max shift for the CMDQ probed from HW
> >   * @cr0:		Last value of CR0
> > + * @host_ste_cfg:	Host stream table config
> > + * @host_ste_base:	Host stream table base
> > + * @strtab_cfg:		Stream table config as seen by HW
> > + * @strtab_dma:		Physical address of the shadow stream table
> > + * @strtab_size:	Size of the shadow stream table
> > + *
> >   * @mmio_addr, @mmio_size and ARM_SMMU_FEAT_COHERENCY are filled by the host
> >   * before de-privilege, the rest by the hypervisor driver.
> >   */
> > @@ -50,6 +56,11 @@ struct hyp_arm_smmu_v3_device {
> >  	struct arm_smmu_queue	cmdq_host;
> >  	u32			cmdq_max_shift;
> >  	u32			cr0;
> > +	dma_addr_t		strtab_dma;
> > +	size_t			strtab_size;
> > +	u64			host_ste_cfg;
> > +	u64			host_ste_base;
> > +	struct arm_smmu_strtab_cfg strtab_cfg;
> 
> The order is different here than the kdocs.
> 
> Also, it might be cleaner to group host/shadow/hw stuff separately:
> 
> struct hyp_arm_smmu_v3_device {
> 	...
> 	struct hyp_arm_smmu_v3_device_host host;
> 	struct hyp_arm_smmu_v3_device_shadow shadow;
> 	struct hyp_arm_smmu_v3_device_hw hw;
> 	// Or
> 	struct {
> 		...
> 	} shadow;
> 	struct {
> 		...
> 	} host;
> 	struct {
> 		...
> 	} hw;
> 	...
> };

That looks better, thanks! I will try it in the next version.

Thanks,
Mostafa

> 
> Nicolin
