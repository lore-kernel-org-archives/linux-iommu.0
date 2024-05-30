Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D7117836D
	for <iommu@lists.linux.dev>; Thu, 30 May 2024 11:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717067944; cv=none; b=LPC+MscF8/GWfTHwpm/qk35M+1DsbpKoG3dbQrs1pgo+me4QAjamR/u9zqSiuYSeF8HSsXnkhKgx27rhJaOlfZuTMjD7VX/ba5AidgoRC3+n1My079wd7McqG/YAjitVo25R2p8OQxeTAYfDLxbKoddYdfPEA/9nU3/WKaaU1dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717067944; c=relaxed/simple;
	bh=NUlEbNyavhHOhkm2XeeaMoGtHkkSo3W7X85piRfwEBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/noDmBhCEUGWSaQJb1/cZsF5lUPDxziUjyUeCfwQw6S8K5Wo0Jz4xzCXxGAlroUZ6PKlF7oYW0ZfHuFfMFzMQub7vTRxyPjH1C+X9EIT5ulYikwKMYhNv5CQEmZ6FEzTinu7i3dqmjpSnPl10dy0Xxb4z4DpxhK+Ml1bMO4wJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZcreHat8; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZcreHat8"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52b80e5688aso511476e87.0
        for <iommu@lists.linux.dev>; Thu, 30 May 2024 04:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717067941; x=1717672741; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N14dolJ0PkU7EYoMUWicS8K8p72D3KTXUMbK9wMcK6w=;
        b=ZcreHat8MT9qBhJoJ2HIZirKCUF7/1dtEbAYrq2EnFk3uw3e6eja/ky8o1twEptUJz
         ZmBctW/mFC+Hl058gfQYpGNf1BdkAFlImCuPW00TsTImnG9aMfUPgIaZgjDFF4GjZ9U5
         9qjPlaLgSX1fy+N4lVsSXp+IUhQAnnhTx2qJmavmiZWDJba+Stb9sRMxKipOxxTgIDNN
         LNwEqXrZ+n26u6DjhnZylWF0+zqy3RnH6+bUePmMJuSzZFLoOINzTfLaSinuhyDMd0Y4
         OtZNwvv+tmmpANBdcHYCbIUj6LfA2ZFRbAkZ00AtkgioA5ZrdTQTgw1iy3ggfUP/wYSq
         8NrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717067941; x=1717672741;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N14dolJ0PkU7EYoMUWicS8K8p72D3KTXUMbK9wMcK6w=;
        b=kMk+15zGKSS90ar6yQzF5hqk/OraEEHOzQHJzoPoCdiVyekxAdi2oDQuRtBYSzpDbo
         Bzxr0EwVaI4Yi2u48yyL/jlIf1O+i2TW2oyXybbuaCiA2fOha5R0b25D/quMVM61wzFm
         jBTQpTTocJau+c+fQvuGoZdHDyCqsPYfzpFq4DpACXNQuCnoyOS0H4Fs/WKEQIv73f8C
         oGo7emCg2I8sMWYLvIqLOExaImUXZM1oFI4M2V7cS09NrZkJPenUZ7eidgV8nSs1DTnP
         QpkAFJ8dQF1NeV5xW5w7IiU81BVjoCHc6+KzQZfKatU+0tsxPCBgTKJAh0TUSHU2GASj
         lr2w==
X-Forwarded-Encrypted: i=1; AJvYcCWkAxawWv7s9WBiOY3X8+jMP76CYLB36yMOzJOG1emXLOSyJdTEBO48J4soKA0LRL6Wag2K1bwqEbrCZ0jXZ4gc1XuX1hk=
X-Gm-Message-State: AOJu0Yw/+U/6Bz4I2/mttpVbWrnvG4fQtwoS9gUQOL80sabPVd/algx9
	Ry9F/DaEkLv0tdv1K18T44jDU1MG+ZxJhscUGmhfa5ysBrUVcV7r0w11+VrlZgw=
X-Google-Smtp-Source: AGHT+IHSkn8193QJ7bhYwashD1ckamm7z3rtCun6DGwToGY7eMTbmvAcTfjkx9QJktZvIttJ4it7/w==
X-Received: by 2002:a05:6512:2f4:b0:529:b6c3:be9e with SMTP id 2adb3069b0e04-52b7d419a3dmr1648588e87.9.1717067940962;
        Thu, 30 May 2024 04:19:00 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529b7360d1fsm964214e87.157.2024.05.30.04.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 04:19:00 -0700 (PDT)
Date: Thu, 30 May 2024 14:18:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	jsnitsel@redhat.com, quic_bjorande@quicinc.com, mani@kernel.org, 
	quic_eberman@quicinc.com, robdclark@chromium.org, u.kleine-koenig@pengutronix.de, 
	robh@kernel.org, vladimir.oltean@nxp.com, quic_pkondeti@quicinc.com, 
	quic_molvera@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/5] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
Message-ID: <tvlhu6kvlektss3kb52zxiynwz7ivte4al43pcgx3ratdxxeos@pkwwq4eecii7>
References: <20240123144543.9405-1-quic_bibekkum@quicinc.com>
 <20240123144543.9405-4-quic_bibekkum@quicinc.com>
 <CAF6AEGs3_wBNo58EbGicFoQuq8--fDohTGv1JSFgoViygLS5Lg@mail.gmail.com>
 <f2222714-1e00-424e-946d-c314d55541b8@quicinc.com>
 <51b2bd40-888d-4ee4-956f-c5239c5be9e9@linaro.org>
 <0a867cd1-8d99-495e-ae7e-a097fc9c00e9@quicinc.com>
 <7140cdb8-eda4-4dcd-b5e3-c4acdd01befb@linaro.org>
 <omswcicgc2kqd6gp4bebd43sklfs2wqyaorhfyb2wumoeo6v74@gaay3p5m46xi>
 <CAF6AEGub2b5SRw7kDUGfKQQ35VSsMkQ9LNExSkyHHczdFa2T4Q@mail.gmail.com>
 <9992067e-51c5-4a55-8d66-55a102a001b6@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9992067e-51c5-4a55-8d66-55a102a001b6@quicinc.com>

On Thu, May 30, 2024 at 02:51:56PM +0530, Bibek Kumar Patro wrote:
> 
> 
> On 5/28/2024 9:38 PM, Rob Clark wrote:
> > On Tue, May 28, 2024 at 6:06 AM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > > 
> > > On Tue, May 28, 2024 at 02:59:51PM +0200, Konrad Dybcio wrote:
> > > > 
> > > > 
> > > > On 5/15/24 15:59, Bibek Kumar Patro wrote:
> > > > > 
> > > > > 
> > > > > On 5/10/2024 6:32 PM, Konrad Dybcio wrote:
> > > > > > On 10.05.2024 2:52 PM, Bibek Kumar Patro wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > On 5/1/2024 12:30 AM, Rob Clark wrote:
> > > > > > > > On Tue, Jan 23, 2024 at 7:00 AM Bibek Kumar Patro
> > > > > > > > <quic_bibekkum@quicinc.com> wrote:
> > > > > > > > > 
> > > > > > > > > Currently in Qualcomm  SoCs the default prefetch is set to 1 which allows
> > > > > > > > > the TLB to fetch just the next page table. MMU-500 features ACTLR
> > > > > > > > > register which is implementation defined and is used for Qualcomm SoCs
> > > > > > > > > to have a custom prefetch setting enabling TLB to prefetch the next set
> > > > > > > > > of page tables accordingly allowing for faster translations.
> > > > > > > > > 
> > > > > > > > > ACTLR value is unique for each SMR (Stream matching register) and stored
> > > > > > > > > in a pre-populated table. This value is set to the register during
> > > > > > > > > context bank initialisation.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> > > > > > > > > ---
> > > > > > 
> > > > > > [...]
> > > > > > 
> > > > > > > > > +
> > > > > > > > > +               for_each_cfg_sme(cfg, fwspec, j, idx) {
> > > > > > > > > +                       smr = &smmu->smrs[idx];
> > > > > > > > > +                       if (smr_is_subset(smr, id, mask)) {
> > > > > > > > > +                               arm_smmu_cb_write(smmu, cbndx, ARM_SMMU_CB_ACTLR,
> > > > > > > > > +                                               actlrcfg[i].actlr);
> > > > > > > > 
> > > > > > > > So, this makes ACTLR look like kind of a FIFO.  But I'm looking at
> > > > > > > > downstream kgsl's PRR thing (which we'll need to implement vulkan
> > > > > > > > sparse residency), and it appears to be wanting to set BIT(5) in ACTLR
> > > > > > > > to enable PRR.
> > > > > > > > 
> > > > > > > >            val = KGSL_IOMMU_GET_CTX_REG(ctx, KGSL_IOMMU_CTX_ACTLR);
> > > > > > > >            val |= FIELD_PREP(KGSL_IOMMU_ACTLR_PRR_ENABLE, 1);
> > > > > > > >            KGSL_IOMMU_SET_CTX_REG(ctx, KGSL_IOMMU_CTX_ACTLR, val);
> > > > > > > > 
> > > > > > > > Any idea how this works?  And does it need to be done before or after
> > > > > > > > the ACTLR programming done in this patch?
> > > > > > > > 
> > > > > > > > BR,
> > > > > > > > -R
> > > > > > > > 
> > > > > > > 
> > > > > > > Hi Rob,
> > > > > > > 
> > > > > > > Can you please help provide some more clarification on the FIFO part? By FIFO are you referring to the storing of ACTLR data in the table?
> > > > > > > 
> > > > > > > Thanks for pointing to the downstream implementation of kgsl driver for
> > > > > > > the PRR bit. Since kgsl driver is already handling this PRR bit's
> > > > > > > setting, this makes setting the PRR BIT(5) by SMMU driver redundant.
> > > > > > 
> > > > > > The kgsl driver is not present upstream.
> > > > > > 
> > > > > 
> > > > > Right kgsl is not present upstream, it would be better to avoid configuring the PRR bit and can be handled by kgsl directly in downstream.
> > > > 
> > > > No! Upstream is not a dumping ground to reduce your technical debt.
> > > > 
> > > > There is no kgsl driver upstream, so this ought to be handled here, in
> > > > the iommu driver (as poking at hardware A from driver B is usually not good
> > > > practice).
> > > 
> > > I'd second the request here. If another driver has to control the
> > > behaviour of another driver, please add corresponding API for that.
> > 
> > We have adreno_smmu_priv for this purpose ;-)
> > 
> 
> Thanks Rob for pointing to this private interface structure between smmu
> and gpu. I think it's similar to what you're trying to implement here
> https://lore.kernel.org/all/CAF6AEGtm-KweFdMFvahH1pWmpOq7dW_p0Xe_13aHGWt0jSbg8w@mail.gmail.com/#t
> I can add an api "set_actlr_prr()" with smmu_domain cookie, page pointer as
> two parameters. This api then can be used by drm/msm driver to carry out the
> prr implementation by simply calling this.
> Would this be okay Rob,Konrad,Dmitry?

SGTM

> Let me know if any other suggestions you have in mind as well regarding
> parameters and placement.
> 
> Thanks & regards,
> Bibek
> 
> > BR,
> > -R
> > 
> > > > 
> > > > > 
> > > > > > > Thanks for bringing up this point.
> > > > > > > I will send v10 patch series removing this BIT(5) setting from the ACTLR
> > > > > > > table.
> > > > > > 
> > > > > > I think it's generally saner to configure the SMMU from the SMMU driver..
> > > > > 
> > > > > Yes, agree on this. But since PRR bit is not directly related to SMMU
> > > > > configuration so I think it would be better to remove this PRR bit
> > > > > setting from SMMU driver based on my understanding.
> > > > 
> > > > Why is it not related? We still don't know what it does.
> > > > 
> > > > Konrad
> > > 
> > > --
> > > With best wishes
> > > Dmitry

-- 
With best wishes
Dmitry
