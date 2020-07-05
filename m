Return-Path: <SRS0=UFel=AQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215CDC433E0
	for <iommu@archiver.kernel.org>; Sun,  5 Jul 2020 03:37:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDD3720890
	for <iommu@archiver.kernel.org>; Sun,  5 Jul 2020 03:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O2lLgZzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD3720890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A5BE9204C4;
	Sun,  5 Jul 2020 03:37:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xLxGdGv+Yw-K; Sun,  5 Jul 2020 03:37:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 620C6203AA;
	Sun,  5 Jul 2020 03:37:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47CEDC088C;
	Sun,  5 Jul 2020 03:37:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D36AC0733
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jul 2020 03:37:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2533A88A87
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jul 2020 03:37:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SGLMsapTiswA for <iommu@lists.linux-foundation.org>;
 Sun,  5 Jul 2020 03:37:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E963588A76
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jul 2020 03:37:35 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id s14so14025318plq.6
 for <iommu@lists.linux-foundation.org>; Sat, 04 Jul 2020 20:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=M5ZbztlPkvw+9ErJFWw7Qbat+ZkMk081NbvPHaI46hs=;
 b=O2lLgZzcbDRX8J92t5mKKUYXAwjo/sQXHSA3N7D4uuiEl8hO5WSoR/nmtz3zSlJyNz
 H4tFAx0OhM+bYW5A2+HaVgdhP8n38fXZCTnw9ok2Aahub5NKT/tgPW+8b/SMC7izclFy
 gYj2DhmS110EYhViIceJGIaX4DZMUPJkhNJ7o/feDHm78xBYlGfwCtuEq/mI08PXg5SN
 e7GCRB0oJVvxKxFFy1DmJpa1rNquJg9FjMhmetGE81blw8bV6lsReGYMclOJpkdYsX8S
 K8RbC0lFNrxBmYqQ9u2xuG964lHJL/qmc87VxTU6jwr5pmEiyqB01/PYLWoRyl/lHG8C
 bamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=M5ZbztlPkvw+9ErJFWw7Qbat+ZkMk081NbvPHaI46hs=;
 b=s+DyNQ1ChzcMLbbzwZ76CVPuHVnyThf535gNjkxWNYfHw+xBhweRwxMjJgtiZBDKAj
 RNWwv73bl8jv59Ractg888MR4dpm9dO+jucKZEH35gAVlRUznA4g8qHQL4EweHrepfsR
 sBFRfN3NVmCSWaI6RZFtOAMlZd+bynCg9QDCTqH6KlwWEnsQsSyKKzUgA+MGU5V3oQRX
 7vEcAib4XpIVkK3HDz+GFXGjKoWwbF+m4L3K7I9+z/Xeh7oe6qZOKmEt7i6kUmdcERi5
 uEuvElxD8p6nZ8I7+SdixNpZnTpSRKjo6QDcNv+bNL/xBlqnF972ACZSjzG4nMeeGu+1
 5KsA==
X-Gm-Message-State: AOAM531r3WLezKwXmkyzMC2y72ZdbuiB3kmA13ZaA2zTTTtVexkwvd9H
 jTep3nX0RsJTSP2Tg5rtRT9a8g==
X-Google-Smtp-Source: ABdhPJwYJ4bAkZPeI8sSzaQN9k6F5rcjd5JMGeKP/JEQ+CUkkHSBMoFuFc3gUDQ0nwnKd5YninLHog==
X-Received: by 2002:a17:90a:db48:: with SMTP id
 u8mr14034064pjx.169.1593920255249; 
 Sat, 04 Jul 2020 20:37:35 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id x10sm15766727pfp.80.2020.07.04.20.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 20:37:34 -0700 (PDT)
Date: Sat, 4 Jul 2020 20:35:11 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Implement qcom,skip-init
Message-ID: <20200705033511.GR388985@builder.lan>
References: <20200704122809.73794-1-konradybcio@gmail.com>
 <20200704130922.GB21333@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200704130922.GB21333@willie-the-truck>
Cc: devicetree@vger.kernel.org, skrzynka@konradybcio.pl,
 Konrad Dybcio <konradybcio@gmail.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 john.stultz@linaro.org, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Sat 04 Jul 06:09 PDT 2020, Will Deacon wrote:

> [Adding Bjorn, Jordan and John because I really don't want a bunch of
> different ways to tell the driver that the firmware is screwing things up]
> 

Thanks Will.

> On Sat, Jul 04, 2020 at 02:28:09PM +0200, Konrad Dybcio wrote:
> > This adds the downstream property required to support
> > SMMUs on SDM630 and other platforms (the need for it
> > most likely depends on firmware configuration).
> > 
> > Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
> > ---
> >  .../devicetree/bindings/iommu/arm,smmu.yaml       | 10 ++++++++++
> >  drivers/iommu/arm-smmu.c                          | 15 +++++++++------
> >  2 files changed, 19 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > index d7ceb4c34423..9abd6d41a32c 100644
> > --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > @@ -102,6 +102,16 @@ properties:
> >        access to SMMU configuration registers. In this case non-secure aliases of
> >        secure registers have to be used during SMMU configuration.
> >  
> > +  qcom,skip-init:
> > +    description: |
> > +      Disable resetting configuration for all context banks
> > +      during device reset.  This is useful for targets where
> > +      some context banks are dedicated to other execution
> > +      environments outside of Linux and those other EEs are
> > +      programming their own stream match tables, SCTLR, etc.
> > +      Without setting this option we will trample on their
> > +      configuration.
> 
> It would probably be better to know _which_ context banks we shouldn't
> touch, no? Otherwise what happens to the others?
> 

From my investigations of the issue of maintaining the boot display
through the initialization of arm-smmu I assume the reason for skipping
this step don't want to flush out the SMR, S2CR and context bank
initialization because it would disrupt the display hardware's access to
memory.

And in itself I believe that this is quite certainly going to work -
until you start attaching devices. Because in itself this does nothing
to ensure that the driver won't overwrite stream mapping or context bank
configuration as devices are attached.

So on e.g. SDM845 we need to ensure that the driver doesn't stomp over
the display mapping left by the bootloader.


Further more, on platforms such as QCS405 (which are derived from
platforms supported by qcom_iommu today), the stream mapping registers
(SMR and S2CR) are write ignore, which means that without knowledge
about the existing mappings the hardware and driver will be out of sync.

NB. Compared to the platforms that is supported by qcom_iommu, the
stream mapping registers are readable on these newer platforms, while on
e.g. MSM8916 we get an access violation by attempting to read SMR/S2CR.

> > +
> >    stream-match-mask:
> >      $ref: /schemas/types.yaml#/definitions/uint32
> >      description: |
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 243bc4cb2705..a5c623d4caf9 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -1655,13 +1655,16 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
> >  	 * Reset stream mapping groups: Initial values mark all SMRn as
> >  	 * invalid and all S2CRn as bypass unless overridden.
> >  	 */
> > -	for (i = 0; i < smmu->num_mapping_groups; ++i)
> > -		arm_smmu_write_sme(smmu, i);
> >  
> > -	/* Make sure all context banks are disabled and clear CB_FSR  */
> > -	for (i = 0; i < smmu->num_context_banks; ++i) {
> > -		arm_smmu_write_context_bank(smmu, i);
> > -		arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_FSR, ARM_SMMU_FSR_FAULT);
> > +	if (!of_find_property(smmu->dev->of_node, "qcom,skip-init", NULL)) {
> > +		for (i = 0; i < smmu->num_mapping_groups; ++i)
> > +			arm_smmu_write_sme(smmu, i);
> > +
> > +		/* Make sure all context banks are disabled and clear CB_FSR  */
> > +		for (i = 0; i < smmu->num_context_banks; ++i) {
> > +			arm_smmu_write_context_bank(smmu, i);
> > +			arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_FSR, ARM_SMMU_FSR_FAULT);
> > +		}
> >  	}
> 
> Do we not need to worry about the SMRs as well?
> 

I don't think we should skip the actual initialization, because to avoid
strange side effects we need to ensure that the driver and hardware are
in sync (either for specific streams/banks or for all of them).

I've continued my work on supporting boot display on e.g. SDM845, based
on Thierry's patches, but still have some unresolved corner cases to
fully resolve - e.g. how to ensure that the display hardware's stream
mapping survives the probe deferral of the display driver. Hopefully I
will be able to post something in a few days.



That said, there's a generation of platforms between MSM8916 (which we
support using qcom_iommu) and SDM845 (which can run with arm-smmu).
AngeloGioacchino proposed a series last year to extend the qcom_iommu to
support these [1]. If SD630 falls in this category, or in the newer
SDM845/SM8150 category I don't know.

It would be quite interesting to hear more about the exact behaviors
seems on SDM630, to see how we can support this as well.

[1] https://lore.kernel.org/linux-arm-msm/20191001155641.37117-1-kholk11@gmail.com/

Regards,
Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
