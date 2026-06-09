Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3123F39CE
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999945; cv=none; b=MG1gcV3ZvF5htwSI9cUvxbVi7ViHg+1GhSAMdd/aJikvg0ueqwkfFhtQDXlGphSOjCO8qpNIkHIMLihNZReMViXBIWEG/nkqPsksqjws0VNEEJW9MOWMmFSDNytK81w7eFwda8u+de+bSejipHLFcbZirLjb10QSl3Pq37cZbUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999945; c=relaxed/simple;
	bh=HyQMaUtTIuTaUMNr+CXehYn/xavNqulIRwmSrOPS3+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOAwEi0kxUtqUdWxwBbQNx6MhuiFPTUxBReEEG+bel4mlVlbDLX5IpIYSL4As5Fs1+D3tYMEQ4jn4zllrIqCOVgZifl0xU07CIkv3lFOh8WAX3CGfshZ+Gr8DAuCP+nccxN/azMZDpsB4pKnTFAgIEyA2AATp52c4F13OL77zVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b+7v1y3u; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b+7v1y3u"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0b1a48855so493475ad.0
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 03:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780999944; x=1781604744; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PmfA3ihkZI70+QmKMUq3GShPQIuZGsmDmch0QrGM1yw=;
        b=b+7v1y3ugdl7Zj44m7foyFA6rHeDqw/VAI5UsLCsqe7DTc1poHryK9+eR2J+kzsln4
         gpINhMY62avA82ZsGKMi1N918FzmfXhZkE+58nqfwpzj8DLsX5qtCzM8VAFDxC/i+ZVi
         xHVsV7Q3iiXklZOSg0N9b37mq4dQSwwKNP1DZi1DFQhetO80Rc6d1lXLL9215xiBYD/6
         EZ3PkmTZpHox/eSDfFh5m5ixQO443E31A37ivM7jofpPvyvyetZALpBGB9VScVZKI/QR
         9CS8PfpKVLNcGb6SgKR3x4Oe/+uMXPFUQQ7oBEdlOVlwB192AI+YbQfq6ZBRHlPHmIGr
         fx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780999944; x=1781604744;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PmfA3ihkZI70+QmKMUq3GShPQIuZGsmDmch0QrGM1yw=;
        b=P3eTM8Q9n0pOOC25Yx3lhfXw5lySBlj4Iq8W4odvGMdh5aMd37TD1PrfdJBFLIzLNZ
         8/6o6Lw6xnPUTxzh9SuclGAB/cwdCY7N/NmByVqzH+mROWioOKih85u6m+lpaJtD5V5Y
         Rg/LV9lfP3xGqasfAVfCdXk1m7CUsQftFjgcTmVYq72ylPHvgNGXK0IKqjRR7UE/6/uX
         Wqj+vZPUpvkkTpiGx7Jjx62mgVuuep+Bqz/f0+07YFTlFhqs0dbiCGoZEYF8fRP36hAX
         JNU40f4ViRKAv3AsYeNh1dmRk26NW9IYK3/+XmI77Y+JRrJfs8/guWRbEKbs0uRkE4d0
         43wg==
X-Gm-Message-State: AOJu0YwcTnuBS/VdogcyoZtjZIxaKUiELzXFIrVhZaleG8ih9VZmibVk
	ANkDyAzPp0Jzby+5PVO2q/7bQxt/d1hCrcRm6x2vraJ60g0P7J4OKzdC2fRHegpJ4g==
X-Gm-Gg: Acq92OGLC3egwqPbP75kP6Z5egaRXZs/pqA4oJIAROMjeRv4gUpVoJmKHvUm7NJrPyw
	2hkkzh4qnoxtb6HrwUXMac4wNzOWDUpxCkFmzbE7YQkiCMgx8AU7JF0T4+AV1ZQVOM10q402DiV
	gjQs60Ge/PtuQKog2bif4saLyTh4QHM4vMIESIVm5oOWLECCgg/g8yGDxvGMINtvtFmhOYj2Zo0
	Ahn7xi8aKQLXralD6gkd4eFcWImi72NmZ/OOwjz6wyzPv6ZXXRoY7Ew7i2293QTOs19oKAOrl0f
	EK47b/VYkn5YsN3ojcfk3sjvJeK6LWuwLJIhF+ez/jSFF2G5CP1hnB7kiYJGrO7crT4nsM5dIpF
	EMZ80V2gDf8Er9GOXhH92GfD2yvvrH09dTUaJXr2VzPpBH36+exFepy6SDegSRffQxeHnhHGssV
	Zd8u6TZ2gX80ql8n6EIuG8lWk6XUO3hciI/9a2pxSCrj6AAWLuiLnpUEpl0N71BQGk+CyDqAs=
X-Received: by 2002:a17:903:110f:b0:2c1:ee6e:be1f with SMTP id d9443c01a7336-2c1ee6ec559mr7525515ad.29.1780999943339;
        Tue, 09 Jun 2026 03:12:23 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d042sm216609875ad.60.2026.06.09.03.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:12:22 -0700 (PDT)
Date: Tue, 9 Jun 2026 10:12:17 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 09/12] iommu/arm-smmu-v3: Implement pm_runtime &
 system sleep ops
Message-ID: <aifnATxVw0k-yxqx@google.com>
References: <20260601215909.3958732-1-praan@google.com>
 <20260601215909.3958732-10-praan@google.com>
 <CAE2F3rDjFwacP0_TA8tv5_p7ZJejsXAKEb=juNaXgPcMPag+Eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rDjFwacP0_TA8tv5_p7ZJejsXAKEb=juNaXgPcMPag+Eg@mail.gmail.com>

On Sun, Jun 07, 2026 at 02:53:24PM -0700, Daniel Mentz wrote:
> On Mon, Jun 1, 2026 at 2:59 PM Pranjal Shrivastava <praan@google.com> wrote:
> > @@ -4898,6 +4939,21 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
> >         if (is_kdump_kernel())
> >                 enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
> >
> > +       /*
> > +        * While the SMMU was suspended, concurrent CPU threads may have
> > +        * updated in-memory structures (such as STEs, CDs, and PTEs).
> > +        * Any invalidations corresponding to those updates were safely
> > +        * elided because the command queue was stopped (STOP_FLAG == 1).
> > +        *
> > +        * Since the reset invalidate-all commands above have fully cleared
> > +        * the HW TLBs and config caches, the SMMU will fetch these descriptors
> > +        * directly from RAM as soon as translation is enabled.
> > +        *
> > +        * Add a memory barrier to collect all prior RAM writes to ensure the
> > +        * SMMU sees a consistent view of memory before translation is enabled.
> > +        */
> > +       smp_mb();
> 
> I'm not convinced that this is necessary. I understand that the write
> to smmu->cmdq.q.llq.atomic.prod needs to be ordered before setting
> CR0_SMMUEN in ARM_SMMU_CR0. However, this ordering requirement appears
> to already be met by the dma_wmb() in arm_smmu_cmdq_issue_cmdlist.
> Could you provide an example of a scenario that might fail if this
> smp_mb() were removed?

Agreed. The first dma_wmb() in the issue_cmdlist will handle this. We
don't need this smp_mb(); I'll add a note as specified in [1]

Thanks,
Praan

[1] https://lore.kernel.org/all/aiflaI4svEJvZbsC@google.com/
