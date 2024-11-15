Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B85716D4E6
	for <iommu@lists.linux.dev>; Fri, 15 Nov 2024 19:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731698326; cv=none; b=ti8Qgm9pe6PufCHMERSze4hw5OdQCITnvuI7sXd3yXT+S0VM2ayZtUDOBbpzZ/TqzWxRuwmEWFKpyziOXj+s/uSjm213wi25dYAvYYVSJE1fdBk0UbA7E0t7Kkf3Co14p4nXf3SVNx+9URSdyOkUW66ixMsUXPqvhYPJ7w7qXdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731698326; c=relaxed/simple;
	bh=t3HGFRzcc7qSh3ekvRAyGEjFsPeneuzZNWnlcjmaNIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTvs4hkG7BhUguUsWdDTvwAXm9Eb+jJD7ecgPtWCHa7Ch8k3xLW3RxXN5/YniANzLgs1B5gM4Y/4CTeSJyAQh7fs8yhJGJj6Jr4bsAGvKqoOFn66n9lFmoIs8Ob3JKQaq15KuJqudAXEkEnqZljTDJi0fHx+xBZbhfVWgAIi6y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L/lmsRLj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L/lmsRLj"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315ee633dcso3885e9.1
        for <iommu@lists.linux.dev>; Fri, 15 Nov 2024 11:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731698322; x=1732303122; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gb7hmFy/0l+JpT17zGKACyUketzLohMMo6Nszps9h8Q=;
        b=L/lmsRLjEZ60YaeEJel6L4yVpHGxv7+0U3wOlwN3TuFao/D8pcUjkrCptg6ZvnX6lp
         nQXnBBq7iqr2MagUwbuGx1ZsG1H87ti/sMm0RyzhaL4TVScJ1eR53VpOnQeN85AkDLxx
         aewe1jBaunqaxo1AHSBkuUwURtaacGe0lJxcUINj05J1KiLZzTBzuOgR7R56tp2k88o6
         5rYyzci1uPQ5CDPFeGEy1uR1jujJ1FS0XA/w957AOp6bv/FN2Vk9JcQFDFwU/i3AnQJd
         V6D3vey5igxWlBOh+Kp8Axurv14JSxGBWu8W/8t205O3jgm1UQheHh0ODbtzKSqMdP2c
         9h3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731698322; x=1732303122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gb7hmFy/0l+JpT17zGKACyUketzLohMMo6Nszps9h8Q=;
        b=CDIn4w3c09uJNGqb22ATiu6B65/zwdNmhmkRfNnnSzhOqoO2ZZ5otYpbAwuyGX0cdg
         AHRWJXsLgsVnSd4VsPZdLQNDQWDxlPiBgz97jSv823CtZHqvujaNajS4fBk5VbsowYWz
         pvTrDK7BBdd0c0BrJBu2qdWVPTas89ss0gw4vCxFZ1rvGmw0hfQpMSCoo/EZpk62boRZ
         DBwNx42wXqHpKH05wHoFrp0JrqBAOaVazfnAVhT6XvwsWbfHIQIjab/JouGng60e4yOB
         UP+6q0PVEndrs7elWMNw2R/8sVcj7CrCCD2SzIyuduOV3dTyBlg+i7rORwLhgw5lIE9S
         nLFg==
X-Forwarded-Encrypted: i=1; AJvYcCUBFpBrUILdHHDAntRPhOMgvyNSofSPHkjktx0B/3u0nLPTtqEcSJ176sW0/+65zzZmMsXG1w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3PZMZVjNkkTdOtUN7ZmVE7fn5dWl/89UJHxSiQ89r1PKH/L5w
	I0IUljJ35nAKwAUaUC9PDPSWsBOSE7HFJTFy/ItIIn+jL38aY/laP1IIt6AioA==
X-Gm-Gg: ASbGncuGo9vxPOeRdgb9tezSqpuJxZ9auq5FTKL7b3JzFCx989vozoV2pqo0XgPvuf8
	2nMFNJcn5zPyv2atbmqbH0wOXFnoR385Qooqh1MTzjRkL82IQtv9hLzTedsE8Urir2s+qscPKfI
	2sGXfH0pFYWeeqhdaKAAQx39MvDaHruJLyuJHFUCgqwqW2PCct4YpijC6uHxg4ztxD+phYV0Q2E
	Ypi0/rMFdhgoM86QXsSIMc/vcIDyUNcy5fpzX75JIiY3vq2RPuxGIEi9aJN5WjhNkHaGfyVVHal
	BtG7zKwoH4bE
X-Google-Smtp-Source: AGHT+IG+0JQ95//Ajrq0lgO/WvKJa6AW6bqohkm2IbIyY8g9NlthrnZKtmPcJ0NxaAiAhUmfbGf1Ng==
X-Received: by 2002:a05:600c:3512:b0:426:66a0:6df6 with SMTP id 5b1f17b1804b1-432e609ec5dmr52285e9.0.1731698321726;
        Fri, 15 Nov 2024 11:18:41 -0800 (PST)
Received: from google.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab78918sm61906695e9.17.2024.11.15.11.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 11:18:40 -0800 (PST)
Date: Fri, 15 Nov 2024 19:18:36 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	joro@8bytes.org, Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH] drivers/io-pgtable-arm: Fix stage concatenation with 16K
Message-ID: <ZzeejJL3Tt4OlFdr@google.com>
References: <20241115172235.1493328-1-smostafa@google.com>
 <888e6542-2aa4-43f1-b31e-79432c1ad199@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <888e6542-2aa4-43f1-b31e-79432c1ad199@arm.com>

Hi Robin,

On Fri, Nov 15, 2024 at 06:29:20PM +0000, Robin Murphy wrote:
> On 2024-11-15 5:22 pm, Mostafa Saleh wrote:
> > According to the Arm spec DDI0487 K.a, in:
> > "Table D8-9 Implications of the effective minimum T0SZ value on the
> > initial stage 2 lookup level"
> > 
> > Some combinations of granule and input size with stage-2 would
> > require to use initial lookup levels that can only be achieved
> > with concatenated PGDs.
> > 
> > There was one missing case in the current implementation for 16K,
> > which is 40-bits.
> > 
> > Cc: Daniel Mentz <danielmentz@google.com>
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >   drivers/iommu/io-pgtable-arm.c | 14 +++++++++++---
> >   1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> > index 0e67f1721a3d..9a57874a5cb8 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -1044,10 +1044,18 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
> >   		return NULL;
> >   	/*
> > -	 * Concatenate PGDs at level 1 if possible in order to reduce
> > -	 * the depth of the stage-2 walk.
> > +	 * Some cases where concatenation is mandatory after de-ciphering RSRKBC
> > +	 * in the Arm DDI0487 (K.a):
> > +	 * - 40 bits with 4K: use 2 table at level 1 instead of level 0
> > +	 * - 40 bits with 16K: use 16 tables at level 2 instead of level 1
> > +	 * - 42 bits with 4K: use 8 tabels at level 1 instead of level 0
> > +	 * - 48 bits with 16K: use 2 tabels at level 1 instead of level 0
> 
> This confused me, since per R_DXBSH, that last one is the only one which is
> actually mandatory in general; the others may be valid per R_PZFHQ and
> R_FBHPY. The additional R_SRKBC constraints come from the PA size, not the
> choice of T0SZ (and thus ultimately start_level) itself, so although I guess
> this probably works out true in practice based on how the SMMU drivers
> happen to behave today, it's none too obvious why.

Ah, you are right, I got a bit confused, it's not actually about the
input size, but the fact that the SMMUv3 driver uses IAS = OAS for
stage-2.
And constraint R_SRKBC is about the OAS size.

So in case we change that IAS = OAS for stage-2, we could end up using
concatenation when it's not mandatory.
I don't think that's a bad thing (I was actually thinking of changing
the code to always use concatenation if possible)
But, I can re-write the code in terms of OAS + granule instead so it's
more robust incase we change the stage-2 config in the future.

Thanks,
Mostafa
> 
> Thanks,
> Robin.
> 
> > +	 * Looking at the possible valid input size, that concludes to always
> > +	 * use level 1 with concatentation if possible or at level 2 only
> > +	 * with 16K.
> >   	 */
> > -	if (data->start_level == 0) {
> > +	if ((data->start_level == 0) ||
> > +	    ((data->start_level == 1) && (ARM_LPAE_GRANULE(data) == SZ_16K))) {
> >   		unsigned long pgd_pages;
> >   		pgd_pages = ARM_LPAE_PGD_SIZE(data) / sizeof(arm_lpae_iopte);
> 
