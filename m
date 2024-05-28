Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FA316D9DC
	for <iommu@lists.linux.dev>; Tue, 28 May 2024 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716901613; cv=none; b=OcqxyAYnnWSReLZfFBKcxk2Qquvd90+NGKbbcFtvZuYVME0Y/oHlk0hlp+it6S4KmZPthL2tRZ8t0aZtHwnQyhGm4I2mJUsV+2nyQIIuocggc18y1x3xYoC8TLwldHOTwakIfc1eG76PPifnxlnVSD6O1kiPR9C55W8lpICz5V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716901613; c=relaxed/simple;
	bh=ZjSXb5QFdaYC4KHHw8vBDJN44RBUEPkfV+5MYpMQ5M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4nLUOPV0gWQKTYwe63BFWcFnL+zXu5AZDtfx5ei/Op5UqrCG5hzTvDfcpdaIHIqQWrDaELs8qOAxRzwbpLWGMxNik0kLwKPlfJ6T0bt1R1aduAF4+OMdElUD5XWbRvjOUQ9gdB6UuiG03dQmZu0vyYUI9buq4Jfet7N8xTaBns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gtVe8mO7; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gtVe8mO7"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e9819a6327so9567661fa.1
        for <iommu@lists.linux.dev>; Tue, 28 May 2024 06:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716901609; x=1717506409; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GOBv4wkspGTZHjGiw1ESITmbKKi6oC3SplGyCdxHuQI=;
        b=gtVe8mO7jOy0C6i7ALN169L/R8o7C9Zc+EGhtt0fQ+w/pefA5mxh6GdsRmMuj5mDcX
         iOTDBPaEhouQ5xkHO4J6iVe5yXz3+NkfLWGSvLNH3N52G8RIi5+gGCuSqCbA+E+Xl41w
         WZP7zG1cEaMiu5WiAfngszfTEOycCuzOl4nv+UGTobomcQ+gZI6YndeM8MipY3WWID6o
         VQhjQegUFymNwnm+iqAI7jTUddMJ/9bD9QR+3M5vjs5McXHDtO79uxfpC9ypx78aiDA+
         6z57St0IjwdLioURj6sqjJQk5emHtETi7rB1bAclZjUC9+/aMb3G726JmFPUW7saz6M1
         37bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716901609; x=1717506409;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GOBv4wkspGTZHjGiw1ESITmbKKi6oC3SplGyCdxHuQI=;
        b=ZwklgDdDGYhYCpL2sB0ywmX/V3LAK3lbrxfbOonoRtl3+kLntBnFI9GpLbzByxplab
         1VW0PlEPNIK5n69IDHwR9FzFCeF0M7NtIpzCgPIyy2lgF13W9Ih56DqE5NUsMm7H7B00
         2hDfOs2iTQIfP8HUkVPVQDBXzIdACHLcjVvmeIjs61snRYlSZsetRq3BuCqYRwVtAIbB
         mynVc0nfl3SXdNEi5thXnR+KkZlPkjylM959AT1XHG+B0iMYellcCqO0oyIEo4kCcWjh
         9cWTtRV1njjmneI9Oc8vaRP5lWPBVi7tE5HUOLa0+ObqY/Ra6HmoSsfUhKzmnOSY02WV
         ft5A==
X-Forwarded-Encrypted: i=1; AJvYcCVCbKQFhpCXZ4DTJlJ4N1yH3WyvG2vPQdo0AQ4QPzZeBwchcJ4krIzrKElHiGYOJn67dVqj/NwhXuAmibP8MkjQv36NOBk=
X-Gm-Message-State: AOJu0YxIYgowmxJj6Y/Ny0MdNraJsXxwJDV8gh5nDP9e/LesIJjihpxW
	v9sUEWDXJmgNcXZ+PT9XCcb1SpgqHjI8x/4RX2LG477qaiU9zXvgeo8OyNc2ydU=
X-Google-Smtp-Source: AGHT+IGtTxUey92N1Y7JyzLJjX/huVXGMV3PnoHL5XuMv5BWbmYemBDkBlvarhgxlDFIAbXdISDDxw==
X-Received: by 2002:a2e:7d07:0:b0:2e1:ebec:1ded with SMTP id 38308e7fff4ca-2e95b0c0445mr68255751fa.25.1716901609297;
        Tue, 28 May 2024 06:06:49 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e98bbcda6fsm746891fa.80.2024.05.28.06.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 06:06:47 -0700 (PDT)
Date: Tue, 28 May 2024 16:06:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bibek Kumar Patro <quic_bibekkum@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	jsnitsel@redhat.com, quic_bjorande@quicinc.com, mani@kernel.org, 
	quic_eberman@quicinc.com, robdclark@chromium.org, u.kleine-koenig@pengutronix.de, 
	robh@kernel.org, vladimir.oltean@nxp.com, quic_pkondeti@quicinc.com, 
	quic_molvera@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/5] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
Message-ID: <omswcicgc2kqd6gp4bebd43sklfs2wqyaorhfyb2wumoeo6v74@gaay3p5m46xi>
References: <20240123144543.9405-1-quic_bibekkum@quicinc.com>
 <20240123144543.9405-4-quic_bibekkum@quicinc.com>
 <CAF6AEGs3_wBNo58EbGicFoQuq8--fDohTGv1JSFgoViygLS5Lg@mail.gmail.com>
 <f2222714-1e00-424e-946d-c314d55541b8@quicinc.com>
 <51b2bd40-888d-4ee4-956f-c5239c5be9e9@linaro.org>
 <0a867cd1-8d99-495e-ae7e-a097fc9c00e9@quicinc.com>
 <7140cdb8-eda4-4dcd-b5e3-c4acdd01befb@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7140cdb8-eda4-4dcd-b5e3-c4acdd01befb@linaro.org>

On Tue, May 28, 2024 at 02:59:51PM +0200, Konrad Dybcio wrote:
> 
> 
> On 5/15/24 15:59, Bibek Kumar Patro wrote:
> > 
> > 
> > On 5/10/2024 6:32 PM, Konrad Dybcio wrote:
> > > On 10.05.2024 2:52 PM, Bibek Kumar Patro wrote:
> > > > 
> > > > 
> > > > On 5/1/2024 12:30 AM, Rob Clark wrote:
> > > > > On Tue, Jan 23, 2024 at 7:00 AM Bibek Kumar Patro
> > > > > <quic_bibekkum@quicinc.com> wrote:
> > > > > > 
> > > > > > Currently in Qualcomm  SoCs the default prefetch is set to 1 which allows
> > > > > > the TLB to fetch just the next page table. MMU-500 features ACTLR
> > > > > > register which is implementation defined and is used for Qualcomm SoCs
> > > > > > to have a custom prefetch setting enabling TLB to prefetch the next set
> > > > > > of page tables accordingly allowing for faster translations.
> > > > > > 
> > > > > > ACTLR value is unique for each SMR (Stream matching register) and stored
> > > > > > in a pre-populated table. This value is set to the register during
> > > > > > context bank initialisation.
> > > > > > 
> > > > > > Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> > > > > > ---
> > > 
> > > [...]
> > > 
> > > > > > +
> > > > > > +               for_each_cfg_sme(cfg, fwspec, j, idx) {
> > > > > > +                       smr = &smmu->smrs[idx];
> > > > > > +                       if (smr_is_subset(smr, id, mask)) {
> > > > > > +                               arm_smmu_cb_write(smmu, cbndx, ARM_SMMU_CB_ACTLR,
> > > > > > +                                               actlrcfg[i].actlr);
> > > > > 
> > > > > So, this makes ACTLR look like kind of a FIFO.  But I'm looking at
> > > > > downstream kgsl's PRR thing (which we'll need to implement vulkan
> > > > > sparse residency), and it appears to be wanting to set BIT(5) in ACTLR
> > > > > to enable PRR.
> > > > > 
> > > > >           val = KGSL_IOMMU_GET_CTX_REG(ctx, KGSL_IOMMU_CTX_ACTLR);
> > > > >           val |= FIELD_PREP(KGSL_IOMMU_ACTLR_PRR_ENABLE, 1);
> > > > >           KGSL_IOMMU_SET_CTX_REG(ctx, KGSL_IOMMU_CTX_ACTLR, val);
> > > > > 
> > > > > Any idea how this works?  And does it need to be done before or after
> > > > > the ACTLR programming done in this patch?
> > > > > 
> > > > > BR,
> > > > > -R
> > > > > 
> > > > 
> > > > Hi Rob,
> > > > 
> > > > Can you please help provide some more clarification on the FIFO part? By FIFO are you referring to the storing of ACTLR data in the table?
> > > > 
> > > > Thanks for pointing to the downstream implementation of kgsl driver for
> > > > the PRR bit. Since kgsl driver is already handling this PRR bit's
> > > > setting, this makes setting the PRR BIT(5) by SMMU driver redundant.
> > > 
> > > The kgsl driver is not present upstream.
> > > 
> > 
> > Right kgsl is not present upstream, it would be better to avoid configuring the PRR bit and can be handled by kgsl directly in downstream.
> 
> No! Upstream is not a dumping ground to reduce your technical debt.
> 
> There is no kgsl driver upstream, so this ought to be handled here, in
> the iommu driver (as poking at hardware A from driver B is usually not good
> practice).

I'd second the request here. If another driver has to control the
behaviour of another driver, please add corresponding API for that.

> 
> > 
> > > > Thanks for bringing up this point.
> > > > I will send v10 patch series removing this BIT(5) setting from the ACTLR
> > > > table.
> > > 
> > > I think it's generally saner to configure the SMMU from the SMMU driver..
> > 
> > Yes, agree on this. But since PRR bit is not directly related to SMMU
> > configuration so I think it would be better to remove this PRR bit
> > setting from SMMU driver based on my understanding.
> 
> Why is it not related? We still don't know what it does.
> 
> Konrad

-- 
With best wishes
Dmitry
