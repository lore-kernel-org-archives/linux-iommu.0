Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4253CEB8D
	for <iommu@lists.linux.dev>; Mon,  4 May 2026 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777896792; cv=none; b=HUPbGIz4CfLCVcfD4DMFrLxvJqhIdvU/A1rudy2xU6eV8mmsAsNW7+9VqMoHPRAxszjrn3AjY35ErYPgchJH321CI4Sea0vrS0UBdQLSMRLdrl/uUwoycf42d5+BeZeAso0uu8MXS2T9xhvC4ztTFZ1aBAyF24O2yo0vSL1BwKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777896792; c=relaxed/simple;
	bh=bX2UkMsTl6OcCaUjBf88U30d1MFR4spQoSasIx4OSUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnQ76Re5c5OeTreMtSUEFkUR8cz6OysTl/j9AQK06OuogFjuNTZIbx+JNDAMO70zAkwPfPvv3z7mg1O/QRqNMgWRgoEp8HfyqhyGM0ymGFetGBH9clbDTNiY1D3Qh3j4FISEdtwwUVAF/CH2SwPV2w4AJTboKkkS5TU287WPKjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aWkwRa0s; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aWkwRa0s"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488940ccfa6so170505e9.1
        for <iommu@lists.linux.dev>; Mon, 04 May 2026 05:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777896789; x=1778501589; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7MdnKaX0TB6YagnPneZAL0SbiGRfNhnRbVRU61aMvP8=;
        b=aWkwRa0sakHPeRkmCPnYeOHZueipbmwAyziJmR6pA7W6cuQaxzyHfGsXInU44kLHD8
         B7t0l6sd6cIVbV3RegDN2wXzx8JaZu0L1HEa/BQDR7OdcOiLJxFuwDThN5eq2A7zc1gi
         qXl6izeulrUf0PyWXl1X67HLw7rd/3pEHWvkualyLdssHHZm2x8smlFlWKU6xWOq8QQJ
         zlMDCiWhMe3C7mTiW5IYOGidUnlEnPsW29dWicJa09WQK3OWMaFLy6z/S2r8+PhLf/5U
         bqImwvk9i27VCHrDBpHkXTsfNxdgJPc7UIfXuy85xzIExUHCpt/HH8epcjeoRNNKi7Wa
         iFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777896789; x=1778501589;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7MdnKaX0TB6YagnPneZAL0SbiGRfNhnRbVRU61aMvP8=;
        b=BfhCt5ULCFmRXOK1Joi1WM0JLRMmnM7OI5ISMn4hYzq1ReT8be3ukcrdztofo/LhTm
         r4mageHC1qomv3ZwACbkE7qgAdiKwuivq+1HosRVG9dIgpIkWBD9+Rmq4qQxweWuhlxV
         qG0omw4fEBRB8WS3MvuWuYkWEEjT/lpdTI5RBaDfkYjeLIQn210rajsceO0RWwGn0gz0
         7atiDv3CutQkXAq2MvmySLdO/bkZH3mmDCDvCEDdjDOYtFU14+9TzfFyfqCAOfOBIlML
         aBb8u0iFGyz2aPdERXf3kiOJdtFEZThRI6FEjEE35Txz2opXNkHoTg4Qlj7J9cPRVrUl
         QzXg==
X-Forwarded-Encrypted: i=1; AFNElJ/U/uU792UJyDb3kf3WnVleIyCT6qPFlvoPmXn/h66tXJsO2il9jBk6sNt6BgWQYuY7AyYiJw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwoapBeZ3PvelR3fonlKJMxL1oQq8QjQ6ocyNRe1YqlfBpwAIWa
	dQYbkbU7qPYO7s2X7L7RuqULeOfR5dOCdPnDHGpMk95XaGfYPgXFoVOz4DP1Cxz6TA==
X-Gm-Gg: AeBDiev5R2x7mIsZ9XLmdzDtulVWQu1+KpGkH/NOFU3sje9HAJoy653so00nZb//qB1
	dNSw9lRppx+8MIua5l/wpce6H6om3hGoymQzqXHG2CAVj2OYnuFU5AfoPt7xPSJIN53+28WsKkR
	gScgCfByUaF28Tcg5ZnEgYy41X6CTrHaLQraPID15y2zYFC5oGKriFGRh5dG1bNhapGVWjuMuLy
	ocpEnOiOj52tsPc8eD60jmQ+BjrQASb0TNm+7qD1ao0jYFl5Hi2yvcT/9PSl6kBJKGKRP3yDB+G
	CCKQIkkAWaKlHiEGY0EYLbEDowuWc9WC4hI90g5aVoxc/wMDtyvqRNZ4izd2D+nGGAuveIUTIDt
	wRz82GpLFopAWDKjFPSTrxLiAjKTLvgr5mX3AqlDd5szM6G2G936n/x1WRXmD8B9yOZzX4qzEX3
	mqQKMmWgJcIdCkFV7D6+yMODWQz8aeBEGUPJyBEeLqoEyxZkgoHBzME0zoHIVBi8RurcWvSvYYg
	J4TYg==
X-Received: by 2002:a05:600c:c3cf:10b0:485:1a54:9407 with SMTP id 5b1f17b1804b1-48a97f9d4cbmr1615265e9.0.1777896788643;
        Mon, 04 May 2026 05:13:08 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8bf18c9bsm25362412f8f.0.2026.05.04.05.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 05:13:07 -0700 (PDT)
Date: Mon, 4 May 2026 12:13:04 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 03/25] iommu/arm-smmu-v3: Split code with hyp
Message-ID: <afiNUBlnTGNzXIan@google.com>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-4-smostafa@google.com>
 <20260501124445.GC6912@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260501124445.GC6912@ziepe.ca>

On Fri, May 01, 2026 at 09:44:45AM -0300, Jason Gunthorpe wrote:
> On Fri, May 01, 2026 at 11:19:05AM +0000, Mostafa Saleh wrote:
> > +int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
> > +{
> > +	memset(cmd, 0, 1 << CMDQ_ENT_SZ_SHIFT);
> > +	cmd[0] |= FIELD_PREP(CMDQ_0_OP, ent->opcode);
> 
> Hopefully I get to it today, but I am going to post a series that will
> move this logic into the headers while deleting arm_smmu_cmdq_ent. It
> should be directly usable for pkvm as well to achieve this same split
> without having to shove a giant inline into a header file.
> 
> https://github.com/jgunthorpe/linux/commits/iommu_pt_arm64/
> 
> cover-letter: Remove SMMUv3 struct arm_smmu_cmdq_ent

I see it’s already posted, I will go through it and provide feedback there.

Thanks,
Mostafa

> 
> Jason
