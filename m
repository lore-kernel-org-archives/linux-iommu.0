Return-Path: <SRS0=CZco=62=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ECCCA90AF
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 18:34:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1EB120740
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 18:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n88seXet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1EB120740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5D5582107A;
	Tue, 12 May 2020 18:34:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XmKVr1NN5xkI; Tue, 12 May 2020 18:34:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B4BDE20133;
	Tue, 12 May 2020 18:34:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 948BEC0178;
	Tue, 12 May 2020 18:34:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F3BEC016F
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 18:34:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8A35087645
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 18:34:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LlCqJF5m2yaQ for <iommu@lists.linux-foundation.org>;
 Tue, 12 May 2020 18:34:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CA6C687503
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 18:34:44 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id s21so3754887ejd.2
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 11:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lDJyBodLMWu0qhUNufdBiDT9gXv62jTHVGYNy+RgCn4=;
 b=n88seXetfhopzoBMRSH8H9VRBmAOE1qq5c0Rz2YOxrb7fjtnwGYFVy0xIAjMr5JZEG
 1jevRTPR8k47xYy9FjCdr/cycRRhfzCw8Kld6E8R6tTwfOIe0MC3iZy/GsA6YtHWvbFg
 yLZnIfdP4edHVDZgAY0ziW9bj8PMHnwDOHFEbPVP2bQU6iQeEoN+bz8mojbIhrk2TrEb
 uxWMEFMFi2IMDNJo1ymEzFV5scdSuw46QjVteDezPyVWUDIU8bm9b6y0bVFkqgxQP1XS
 5sPu46jnj8szt3BSZ5GWwGrfn/tigDND/8QvJpwOmjN9buBvR/jxk7E4K5CdcQ310dd+
 2Ggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lDJyBodLMWu0qhUNufdBiDT9gXv62jTHVGYNy+RgCn4=;
 b=ZLYTwnhrmRd3h4HS/WxI1lOi9jYBcQAmkxv0KzdB2C/06YV3AwhvTfI1F9cdPqwaR7
 SiC/RowX9d/Ec/2aWoTq4DBrrAwxAwBG1fVReXFV2HCTs3Hp2Lo/gDixtvfLXe0W84wI
 VOVYFQF3NSkp05WIMSop+foQ829Z1p3rLkavnlDeps97DXFzxnXRUBpGAq8hWDDbfr8g
 9DRXCWfaEd9rVaozZfcVEs6I0L1UEoYpJIlnz545YBWXzE33CFe1xgvjn/SS4hpHido+
 wP6rjWfC2liENjRLwMx5SBlCuThJVQPMoMqEB/xlmLpBijdE/7NmilPsxCkj2b1eohkD
 kv1g==
X-Gm-Message-State: AGi0PuaRzcJfZFQtrBIe22l0tKhBlw3Hd3kY9+evPLyIoIOoF4FWdKr5
 5CfJs5ixlWyB8OoTLcV/BLxdwuIRWIFa4VjZRGg=
X-Google-Smtp-Source: APiQypLNhlqIAjCQGA1LPDeDlHX4a0qstJSP7J2QUAeG/WpcRIcYsCqmti86ji1+zZSUuFs9Qa1eyxxFTQLh/roDblc=
X-Received: by 2002:a17:906:cec5:: with SMTP id
 si5mr19319406ejb.267.1589308483166; 
 Tue, 12 May 2020 11:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200509130825.28248-1-shawn.guo@linaro.org>
 <20200512055242.GJ1302550@yoga>
In-Reply-To: <20200512055242.GJ1302550@yoga>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 12 May 2020 11:35:01 -0700
Message-ID: <CAF6AEGsod2L+VwJGhECpW8BhfexLgMMp_3V3AsnKjXcyLaT48w@mail.gmail.com>
Subject: Re: [PATCH] iommu/qcom: add optional clock for TLB invalidate
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Konrad Dybcio <konradybcio@gmail.com>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Andy Gross <agross@kernel.org>, Shawn Guo <shawn.guo@linaro.org>
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

On Mon, May 11, 2020 at 10:52 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Sat 09 May 06:08 PDT 2020, Shawn Guo wrote:
>
> > On some SoCs like MSM8939 with A405 adreno, there is a gfx_tbu clock
> > needs to be on while doing TLB invalidate. Otherwise, TLBSYNC status
> > will not be correctly reflected, causing the system to go into a bad
> > state.  Add it as an optional clock, so that platforms that have this
> > clock can pass it over DT.
> >
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

[snip]

> > @@ -839,6 +849,12 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
> >               return PTR_ERR(qcom_iommu->bus_clk);
> >       }
> >
> > +     qcom_iommu->tlb_clk = devm_clk_get(dev, "tlb");
>
> Wouldn't "tbu" be a better name for this clock? Given that seems the
> actually be the hardware block you're clocking.
>
>
> That said, I thought we used device links and pm_runtime to ensure that
> the TBUs are powered and clocked...
>

please don't rely on device-link for that, buffers can be freed (and
therefore need to be unmapped) at times when the gpu is off.

BR,
-R
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
