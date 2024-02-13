Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DEA2572
	for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821752; cv=none; b=B6Yk01mFudJKiyZJwjFp0V2ZU3eQSHkpKw5VsX+U9rlVbWhXdW6X/JIgX4+s0Muy0IfabbmtgT25R4EEzKgAnptn/6V03LUhcGleg4kyXqBuOGppDgGzxPG9rHbHo7W0U0TtccHUdTijM46G0sYJGkFMpJ06PjxAkSi3w9hx4fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821752; c=relaxed/simple;
	bh=eeHSKXhxBBEBBHPu6IwyIaC2BEPb18aNmTyIIpv1bTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4Qer7nGTfWd/S/UX00G0g8AnSc0KYxjF9b456/lYUc3tx723lQVsArVSFdqVbwI+2F3YjhJTXxEHj8uv3Bae8lqT+Pp5l9OH0yK5ltjH2HOMzOXj/aIs9wrx2RpSzdBz4fU4fNO4jNXD9ocAZIM2+8y24eVDYUEDTUbCBWxj9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DEkxU6jP; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DEkxU6jP"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc236729a2bso694279276.0
        for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 02:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707821749; x=1708426549; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/HQ6xmHFpXENMsUmSNbHpEOhuLJKkAL3XZJmfGZrxsI=;
        b=DEkxU6jPlLT7YvymWoNo+/0bxuAw2yb00/bYlHbrCLOE96tGgIwiD8JVSkUJnFE+lM
         mU8zhlDQFjQ5fe7rhYrBgutG00WQKu0J3UOngKOddYdYcFCjPcwF5JzPb40ZZrr15akl
         dt6G/hqzkUEIm2g+tfNOglgsG6S4ylrGNPBOO2qejQXajxAc54i3NTRR0ofwnIgasRTV
         ZOBpYTKsIIfwVyhJN+j2Br7tmZwsPlyF6xQMM/Kb+DgvvA4sAIZ3DmnIBVQd618PAru8
         hHYDS9eoJOv/iZJz2IkRZ3txHkjk5vtmsT7x3SDPX0yprrTKB4NZFIgBwsBH1WqnHnGM
         T2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707821749; x=1708426549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HQ6xmHFpXENMsUmSNbHpEOhuLJKkAL3XZJmfGZrxsI=;
        b=dZvbCNqnl6EYuxH7vPXuGFf+FXmPyforgja0kMsu52D3ZxAyx9eNObAXI0but/bxTs
         u4s6PTLxRiDv76CA5u5HiFiZtm5JWs8KLTIA2NN3cj8qSPWDJMwdacpRYr33exaD0FFo
         yKnnCVHMEgPjJXsH/EaEljiWvtsklq/7uvusiTqZ1E3oyXe2J8U6j3bu6pa1P1MUATW8
         KLhSXEZ9vQehw4RhVRWDEgijXGeueoDlYIpqSzOp76R4Nf2Sgj9oArpJD/cScikHSOUZ
         XWXpBuH9pKpQjsHZT9vrgWI/c5nn46vNGKN6CgnqJBUl1+2++NNph5l2pGlaS49TDyJ+
         pymg==
X-Forwarded-Encrypted: i=1; AJvYcCUk0h41mmNEy7pIcKOG1zKVzDCAFlSlPse6nDnAY890oahaRkSC/5cWGP1IYWor19Q/ZRHHQBC1dN7ZTR70SgXlHCAWn2w=
X-Gm-Message-State: AOJu0YxzYzzIK1Iw+AGTj5c4TFWJ3t6FU8TO++usrKDtKmuzj6FQx/rg
	3X9RTJh2uP8hohSAKAE0M3CEm1EF+D6x63zcrTykAxoj3GZlJWWwkSMEVBWULXe2K3hoawEBXev
	iImncJ9Bt4P26EE8hT1BV/ew/Pt6AORbF5odwnA==
X-Google-Smtp-Source: AGHT+IHv7HXJwemQKCIQmc6srSKMtRTeieMR8n2HOa9e9RIalrll/RieTuJ7semNLg7ZLeB3iw/yCHWSqzUPRVP/RPU=
X-Received: by 2002:a25:ad5b:0:b0:dc6:238e:d766 with SMTP id
 l27-20020a25ad5b000000b00dc6238ed766mr7865262ybe.2.1707821749659; Tue, 13 Feb
 2024 02:55:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <5-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
 <20240209200538.917366-1-dmitry.baryshkov@linaro.org> <20240209222349.GA923780@nvidia.com>
 <CAA8EJpp1wuMgawaUPnQWnhz1k023n8Q-k0_sO6P9p7ixntrCJQ@mail.gmail.com> <6511a289-fee6-4d08-9e01-695bd38d4ad6@arm.com>
In-Reply-To: <6511a289-fee6-4d08-9e01-695bd38d4ad6@arm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 13 Feb 2024 12:55:38 +0200
Message-ID: <CAA8EJpqtUnGXMPQO4F0JXQDv0oJKFYjuhf4hSBe2tY1ebWFjRA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] iommu/arm-smmu: Convert to domain_alloc_paging()
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev, joro@8bytes.org, 
	linux-arm-kernel@lists.infradead.org, nicolinc@nvidia.com, will@kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Feb 2024 at 12:20, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2024-02-13 7:51 am, Dmitry Baryshkov wrote:
> > On Sat, 10 Feb 2024 at 00:23, Jason Gunthorpe <jgg@nvidia.com> wrote:
> >>
> >> On Fri, Feb 09, 2024 at 10:05:38PM +0200, Dmitry Baryshkov wrote:
> >>> On Tue, 17 Oct 2023 Jason Gunthorpe <jgg@nvidia.com> wrote:
> >>>> Now that the BLOCKED and IDENTITY behaviors are managed with their own
> >>>> domains change to the domain_alloc_paging() op.
> >>>>
> >>>> The check for using_legacy_binding is now redundant,
> >>>> arm_smmu_def_domain_type() always returns IOMMU_DOMAIN_IDENTITY for this
> >>>> mode, so the core code will never attempt to create a DMA domain in the
> >>>> first place.
> >>>>
> >>>> Since commit a4fdd9762272 ("iommu: Use flush queue capability") the core
> >>>> code only passes in IDENTITY/BLOCKED/UNMANAGED/DMA domain types. It will
> >>>> not pass in IDENTITY or BLOCKED if the global statics exist, so the test
> >>>> for DMA is also redundant now too.
> >>>>
> >>>> Call arm_smmu_init_domain_context() early if a dev is available.
> >>>>
> >>>> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> >>>> ---
> >>>>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 21 +++++++++++++++------
> >>>>   1 file changed, 15 insertions(+), 6 deletions(-)
> >>>
> >>> For some reason this patch breaks booting of the APQ8096 Dragonboard820c
> >>> (qcom/apq8096-db820c.dts). Dispbling display subsystem (mdss) and venus
> >>> devices makes the board boot in most of the cases. Most frequently the
> >>> last parts of the log loog in a following way:
> >>
> >> It is surprising we tested this patch on some tegra systems with this
> >> iommu and didn't hit anything..
> >>
> >> The only real functional thing this changes is to move the domain
> >> initialization up in time, potentially a lot in time in some
> >> cases. That function does alot of things including touching HW so
> >> possibly there is some surprising interaction with something else.
> >
> > I should not be debugging strange platforms at 1 a.m. I forgot that
> > there was another patch to revert. So after reverting the MPM patch,
> > I'm getting the following results:
> >
> >>
> >> So, I would expect this to not WARN_ON and to make it work the same as
> >> before the patch:
> >
> > No warnings, the platform now boots up to the point of actually
> > bringing up the venus device:
> >
> >
> > [   11.906514] ath10k_pci 0000:01:00.0: qca6174 hw3.2 target
> > 0x05030000 chip_id 0x00340aff sub 0000:0000
> > [   11.907119] ath10k_pci 0000:01:00.0: kconfig debug 1 debugfs 0
> > tracing 0 dfs 0 testmode 0
> > [   11.915881] ath10k_pci 0000:01:00.0: firmware ver
> > WLAN.RM.4.4.1-00288- api 6 features wowlan,ignore-otp,mfp crc32
> > bf907c7c
> > [   11.979972] Console: switching to colour frame buffer device 320x90
> > [   11.990756] ath10k_pci 0000:01:00.0: board_file api 2 bmi_id 0:1
> > crc32 d2863f91
> > [   12.060834] msm_mdp 901000.display-controller: [drm] fb0: msmdrmfb
> > frame buffer device
> > [   12.096203] qcom-pcie 608000.pcie: Phy link never came up
> > [   12.103785] qcom-pcie 608000.pcie: PCI host bridge to bus 0001:00
> > [   12.103970] qcom-venus c00000.video-codec: Adding to iommu group 3
> >
> > Format: Log Type - Time(microsec) - Message - Optional Info
> > Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
> > S - QC_IMAGE_VERSION_STRING=BOOT.XF.1.0-00301
> > S - IMAGE_VARIANT_STRING=M8996LAB
> > S - OEM_IMAGE_VERSION_STRING=crm-ubuntu68
> > S - Boot Interface: UFS
> >
> >>
> >> Then I'd ask you to remove the comment and do:
> >>
> >> @@ -878,7 +878,9 @@ static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
> >>          if (dev) {
> >>                  struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
> >>
> >> +               WARN_ON(true);
> >>                  if (arm_smmu_init_domain_context(smmu_domain, cfg->smmu, dev)) {
> >> +                       printk("Allocation failure in arm_smmu_domain_alloc_paging()\n");
> >>                          kfree(smmu_domain);
> >>                          return NULL;
> >>                  }
> >>
> >>
> >> And then we may get a clue from the backtraces it generates. I only
> >> saw one iommu group reported in your log so I'd expect one trace?
> >
> > I added dev_info + mdelays() around the arm_smmu_init_domain_context()
> > and I can see that it crashes within that function.
>
> Yeah, this is totally broken. We can't just call the unmodified
> arm_smmu_init_domain_context() at domain allocation because half of what
> it's doing belongs to the attach operation. We should not be allocating
> context banks, IRQs, etc. for a not-yet-attached domain, and we
> certainly shouldn't be touching hardware there outside of RPM.

Should I send a revert?

>
> Thanks,
> Robin.



-- 
With best wishes
Dmitry
