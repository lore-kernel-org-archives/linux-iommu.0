Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69833568F1
	for <iommu@lists.linux.dev>; Tue,  9 Sep 2025 15:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432127; cv=none; b=MYptyToxnsmj/799+Jh7XLQxeCGCnw8vIxqkCyHKOCHsWK4E1kOT9OKiAsExivb4a6nfYXTv7FRHjFlTXSDRlpjEEilGw0zhmtEsxK0f7HPypyM5WjqjtJ7P1r/ydLWXZhVw6sfJHAxHpXCht9AtcZwU4Zelv8oGQsb21/8Pjtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432127; c=relaxed/simple;
	bh=w4vgOObZw3YYbVIKYEvDXnCr95k+9nhWh3AEGiV+pkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1rPPPJBlO0P+Z5dytGxStdnm3xMvtG7RL2S5Xo83iKjVxdmuGn8W10kuk5ejbUBIOMG1pU9QVzFzyWhy/e2FyrvzpIRQFSf5DHeuk/6SbpLNpocesyW5m8EGjH/R0OyX9lnJZIMYG2sp69slZg57SeBBSxuX5S2msErMfNwPwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F5plpJ6b; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F5plpJ6b"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7ace3baso996537366b.3
        for <iommu@lists.linux.dev>; Tue, 09 Sep 2025 08:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757432124; x=1758036924; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A6rLLgpVdsegGOz+EoupeAx36VHy3lWka2XxE7GCX/E=;
        b=F5plpJ6bNn9jbNGHyh8JcCVjPfJow52OI560uhwlDepA8wuFARa1rV4oAC+gxVstUi
         7lPm/vXbqHOIToxlB7lgfJL6/jJMu4qx8uYWQU0B7mrayIRGC0UYJb1lAIcNvhjUYuRx
         jMhHlcnwY/7didtJl0m63YE8G35gUy25ai+SShixhWXWnmmW7tb2/U7aQaDj1SXiwgsJ
         +ZaiLoqK+O+wATLOEkUL+8Bf0LnaI8b0MrhHCFL2QZ2askazlzJMuqlzizOmZtLtPkP0
         +n2CdiJK8U5tO3hzqHZ7GU97+bH+VkUTTgsBTPpGK3MWVag6SBD6dPjq/q/6V230SkXE
         7fKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757432124; x=1758036924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6rLLgpVdsegGOz+EoupeAx36VHy3lWka2XxE7GCX/E=;
        b=I/uhuBnPGt2Z3Qm2JahHNBMTOh/9WdEO1G0tD8Csfe+DIr3jKpq2jVIgxMYFYDme8R
         ooVSXJJGYlIDujttbHbIpifg+FWK+YYrewzdqnjhlu3ebpVXbETRPu571p3Z/JVFuJij
         8aMAUntYHjuNUD2Cf7D5OVL8puKmHTakwS7gVYzLvEsdjPTbtHPifMb3/jsKL4tzNnng
         sDBtZSxl+UWuNmQ2KpgNvBosq6pxiTJh4YstayIGr1SLeb31S+XQ/2oLbVsddgcpCqWD
         Vb9cfFNwQXTN6Kh1WUHWlohV+uHVaKp3/uHORhhbxj7U9JBH08Uj0kLwhWuhJoQTqZqS
         uDlg==
X-Forwarded-Encrypted: i=1; AJvYcCXHJoOOWD5aPHtkRx4Exp1p2X9iw5ODEV+IcynsAP98HQtSE9JJ/71mEkpjI3o8Ij+DYBY2WQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy++n8nGT7Zyd46Z9UmvYHwGXk2kUaNLfKOoP7gBd+TG7rJZhQS
	sLY/Xzt+EYSAhkY9LjTQVj6WA6eAlF+/NZ6firHFY7Os3mV8Avn+m2dTF7ucm0FdlNI=
X-Gm-Gg: ASbGncuKug33iiiKgYdlB4D+NnL3Ye5dh1bqDHEGu23o8JBNHjHNHBLr7enAczUvaoZ
	jGeHzP6YUQiehSZA/1Uv8rhKJWhjZ9htwZU3x7XEtO/hLF4WsPXOaDSBe6uZu/R9vmnVkiABU9m
	DsFaJ9QPZ6Ht4H+DRTcALLjRUo1zZwlTxm7COD/KyWyle+uUSB9PFXmF2eOUcaMDAN2DKTCmhUw
	/Iv3WCe6iWCWWxdxgkwCEMS6qfbGvWA5c0TXMDPuE00J49fhOcampd3i4U6SJ2M6s/+I3/BX0dz
	BBhMNWH3KBaMDkrUbtAKRaJ4awFIe2XORxgQ937s7uPPBHcXAiZLdIHoTZ836VDiEYsdxxgjJ3m
	XRqL3tSOQlrfJeCQbMwONmARVhUsIjYP0
X-Google-Smtp-Source: AGHT+IHff9nCiQdFMDLMJ/hlSIro/R7UZcyBEWyHkdL401b61b17TqRRFBH3ULGPy356DE8iv2CdnA==
X-Received: by 2002:a17:907:9707:b0:b04:95cf:a39a with SMTP id a640c23a62f3a-b04b1714554mr1300624066b.52.1757432124140;
        Tue, 09 Sep 2025 08:35:24 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:30:cfb9:1327:6099:9e75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07830e613csm8636466b.46.2025.09.09.08.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:35:23 -0700 (PDT)
Date: Tue, 9 Sep 2025 17:35:19 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Enable use of all SMR groups when
 running bare-metal
Message-ID: <aMBJNzXpQTMg4Ncs@linaro.org>
References: <20250821-arm-smmu-qcom-all-smr-v1-1-7f5cbbceac3e@linaro.org>
 <aMAkJ7CfPQuhvhfm@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMAkJ7CfPQuhvhfm@willie-the-truck>

On Tue, Sep 09, 2025 at 01:57:11PM +0100, Will Deacon wrote:
> On Thu, Aug 21, 2025 at 10:33:53AM +0200, Stephan Gerhold wrote:
> > Some platforms (e.g. SC8280XP and X1E) support more than 128 stream
> > matching groups. This is more than what is defined as maximum by the ARM
> > SMMU architecture specification. Commit 122611347326 ("iommu/arm-smmu-qcom:
> > Limit the SMR groups to 128") disabled use of the additional groups because
> > they don't exhibit the same behavior as the architecture supported ones.
> > 
> > It seems like this is just another quirk of the hypervisor: When running
> > bare-metal without the hypervisor, the additional groups appear to behave
> > just like all others. The boot firmware uses some of the additional groups,
> > so ignoring them in this situation leads to stream match conflicts whenever
> > we allocate a new SMR group for the same SID.
> > 
> > The workaround exists primarily because the bypass quirk detection fails
> > when using a S2CR register from the additional matching groups, so let's
> > perform the test with the last reliable S2CR (127) and then limit the
> > number of SMR groups only if we detect that we are running below the
> > hypervisor (because of the bypass quirk).
> > 
> > Fixes: 122611347326 ("iommu/arm-smmu-qcom: Limit the SMR groups to 128")
> > Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > ---
> > I modified arm_smmu_find_sme() to prefer allocating from the SMR groups
> > above 128 (until they are all used). I did not see any issues, so I don't
> > see any indication that they behave any different from the others.
> > ---
> >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 27 +++++++++++++++++----------
> >  1 file changed, 17 insertions(+), 10 deletions(-)
> 
> Is the existing workaround causing you problems somehow? Limiting the SMR
> groups to what the architecture allows still seems like the best bet to
> me unless there's a compelling reason to do something else.
> 

Yes, the problem is the following (copied from commit message above):

> The boot firmware uses some of the additional groups, so ignoring them
> in this situation leads to stream match conflicts whenever we allocate
> a new SMR group for the same SID.

This happens e.g. in the following situation on SC8280XP when enabling
video decoding acceleration bare-metal without the hypervisor:

 1. The SMMU is already set up by the boot firmware before Linux is
    started, so some SMRs are already in use during boot. I added some
    code to dump them:

     arm-smmu 15000000.iommu: Found SMR0 <0xe0 0x0>
      ...
     arm-smmu 15000000.iommu: Found SMR8 <0x800 0x0>
     <unused>
     arm-smmu 15000000.iommu: Found SMR170 <0x2a22 0x400>
     arm-smmu 15000000.iommu: Found SMR171 <0x2a02 0x400>
      ...
     arm-smmu 15000000.iommu: Found SMR211 <0x400 0x3>

 2. We limit the SMRs to 128, so all the ones >= 170 just stay as-is.
    Only the ones < 128 are considered when allocating SMRs.

 3. We need to configure the following IOMMU for video acceleration:

	video-firmware {
		iommus = <&apps_smmu 0x2a02 0x400>;
	};

 4. arm-smmu 15000000.iommu: Picked SMR 14 for SID 0x2a02 mask 0x400
    ... but SMR170 already uses that SID+mask!

 5. arm-smmu 15000000.iommu: Unexpected global fault, this could be serious
    arm-smmu 15000000.iommu: GFSR 0x80000004, GFSYNR0 0x0000000c, GFSYNR1 0x00002a02, GFSYNR2 0x00000000

    SMCF, bit[2] is set -> Stream match conflict fault
    caused by SID GFSYNR1 0x00002a02

With my patch this does not happen anymore. As I wrote, so far I have
seen no indication that the extra groups behave any different from the
standard ones defined by the architecture. I don't know why it was done
this way (rather than e.g. implementing the Extended Stream Matching
Extension), but we definitely need to do something with the extra SMRs
to avoid stream match conflicts.

Thanks,
Stephan
