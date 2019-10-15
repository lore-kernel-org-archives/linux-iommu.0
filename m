Return-Path: <SRS0=BRyA=YI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D370BC10F14
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 13:06:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98DDB21848
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 13:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ki+vfrvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98DDB21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6519BE28;
	Tue, 15 Oct 2019 13:06:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C7EFBC6A
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 13:06:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 11A6C887
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 13:06:49 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id r3so23799643wrj.6
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 06:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=2mdtcLCY8eAT490bD9u11pSWwPTWL49M7Wk6C2lIRvY=;
	b=ki+vfrvNnR2epvoXdz9bd39emPdS6wAU7ZJMaV3zMpUf95o97k28nQOTJKjc8L1ovL
	eHEvfBH2vLMXeQF/eRFXrKBzzKjcj9ACvdfLXxCR19p/baiLEtLuEI1QKrPPKHjuE6cw
	8u23v3+kFxe/0UPQyy7ZZ7YbAbijs9QcdXE7v6Tk9IW+lw9IMELCjIfXMhyVkSzYSTMv
	D+2MOoGx/doWhxI3XlMAGpHX3p4dY5+IdsvgULkcOW3ZwmCB1JlNMpkSv7RkdhR/lgeo
	NBGTSIRZlQZn2WvvMxucst/z98IzslJyObifXEsTP9PAZAoGypcvm67XVk7WSEP+/9Ev
	qHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=2mdtcLCY8eAT490bD9u11pSWwPTWL49M7Wk6C2lIRvY=;
	b=DjUkfPQFhGWRA3gCertZgzPjwjj7sj7mRVroHSQqhBogeyOSSJuQAcCyXamZJegKWx
	kK9edoNBmbQqY5nHe3HF+U5YBVfUSk5s9f4AOwBs+TtXz7X3y2pUwLSo2oIjYVTDi0Gd
	1tmWVpzKQu+FJRExME9poWNyNEJ/4qKEoJU8hS9dhbxTrsqoxq4lLHybt7ye2BYvS9Hi
	EoMKJDRxLW9/LU5y3wLke7JM2t+eyngn8sGiT4qiA2nkQMuPaOvJ1OyVMY1638hMl7hK
	7UjGgLomRVQZNHjgPLuY3W6bWXdUAG2r8s5JErL5p8UNc64ztoccz+vyrw3AL6IEsCKH
	/GDg==
X-Gm-Message-State: APjAAAXwkojeWdwTufftbMMxgceHCDRKwSvqZ5FBA3MWyZZJA9FVLFmK
	qoMLzOS4vj96zAFXtbNJBilSPw2QYfKJqGqzLog=
X-Google-Smtp-Source: APXvYqxXI/pMr5w9Kvrc3bzxP5pQUoHqxa4C+hAfsxSw5IqFqs4L7tGe3DXDOk2+/2LSmC7J/NOX7c3ara1/seSSlBU=
X-Received: by 2002:adf:fe12:: with SMTP id n18mr19864066wrr.114.1571144807299;
	Tue, 15 Oct 2019 06:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191001220205.6423-1-kholk11@gmail.com>
	<20191001220205.6423-3-kholk11@gmail.com>
	<25f3e314-3fcc-fc4f-e7b5-4f28418ea02f@arm.com>
In-Reply-To: <25f3e314-3fcc-fc4f-e7b5-4f28418ea02f@arm.com>
From: AngeloGioacchino Del Regno <kholk11@gmail.com>
Date: Tue, 15 Oct 2019 15:06:36 +0200
Message-ID: <CAK7fi1biOEtjJFqiiPRPe5LxfzNEeQ2WUVNh5trmAj_xQ23bJA@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] iommu/qcom: Use the asid read from device-tree if
	specified
To: Robin Murphy <robin.murphy@arm.com>
Cc: MSM <linux-arm-msm@vger.kernel.org>, marijns95@gmail.com,
	Andy Gross <agross@kernel.org>, iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Il giorno mar 15 ott 2019 alle ore 14:10 Robin Murphy
<robin.murphy@arm.com> ha scritto:
>
> On 01/10/2019 23:02, kholk11@gmail.com wrote:
> > From: AngeloGioacchino Del Regno <kholk11@gmail.com>
> >
> > As specified in this driver, the context banks are 0x1000 apart.
> > Problem is that sometimes the context number (our asid) does not
> > match this logic and we end up using the wrong one: this starts
> > being a problem in the case that we need to send TZ commands
> > to do anything on a specific context.
> >
> > For this reason, read the ASID from the DT if the property
> > "qcom,ctx-num" is present on the IOMMU context node.
>
> Can you clarify exactly what the situation is here? Is the hypervisor
> broken in that it presents context banks at made-up offsets and fails to
> correctly associate those offsets with the real underlying hardware
> context in some cases? Or is the hypervisor actually intercepting
> TTBR/CONTEXTIDR/TLBI* writes such that we don't actually have control
> over the ASID used by a given context bank (which I would also consider
> broken)? Or is "context number" a specific thing in the SCM interface
> which represents neither of the above?
>
> At the moment, it seems like a bit too much is being conflated here just
> because of some implicit behaviour in the driver.
>
> Robin.
>

From what I've understood, it's a mix of everything you just said!

This IOMMU implementation is considered "secure IOMMU" from the
Qualcomm's point of view (at least that's what they wrote in their original
downstream driver), having - secured and unsecured - pre-set (by one of the
bootloader stages) contexts.

On some SoCs (or some firmwares, if you prefer) the context number does
not correspond to that "ctx_no = addr / 0x1000" calculation for some reason
which I'm 99.9% sure is that the bootloader just configures them like this...
so, let's make a true and practical example of what happens on MSM8956/76
(and not only on this SoC):

- GFX3D IOMMU
Offset 0 -- CTX number 0
Offset 0x1000 -- CTX number 2
Offset 0x2000 -- CTX number 1

- APPS IOMMU
Offset 0x1000 -- CTX number 1
Offset blahblah -- CTX number sequential until it starts doing...
Offset 0x10000 -- CTX number 14 (!!!)
Offset blahblah -- CTX number sequential again until the end

See how the context numbers are jumping around? That's only part of
the story why we want this kind of handling: of course, with the hypervisor
intercepting writes, we would be doing ops on the wrong context and we'd
see (personal experience, tested that) for example image corruption while
trying to use adreno, or worse "random" reboots because of the hypervisor
faulting on us because it doesn't like us writing on secured context regs like
FSR or trying to reset it.

Another part of the story is on another commit of this patch series, which is
the one that's introducing the switch to the AArch64 pagetable format: when
we want to do this operation, we have to send a request to TZ containing,
like the restore_sec_cfg, the sec_id and the ASID... then the hypervisor will
agree to switch our IOMMU context's pt format.

So, at the end of the day:
1. Hypervisor seems to be broken as you seem to think
2. We don't have control on the ASID. It's preallocated and fixed.
3. The SCM interface also uses the ASID number, for which - again - we
    have no control.

I hope that was a good enough and understandable explaination of
what we have here :))

Sorry for the wall of text!
Angelo


> > Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
> > ---
> >   .../devicetree/bindings/iommu/qcom,iommu.txt    |  1 +
> >   drivers/iommu/qcom_iommu.c                      | 17 ++++++++++++++---
> >   2 files changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> > index 059139abce35..ba0b77889f02 100644
> > --- a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> > +++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> > @@ -46,6 +46,7 @@ to non-secure vs secure interrupt line.
> >                        for routing of context bank irq's to secure vs non-
> >                        secure lines.  (Ie. if the iommu contains secure
> >                        context banks)
> > +- qcom,ctx-num     : The number associated to the context bank
> >
> >
> >   ** Examples:
> > diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
> > index c31e7bc4ccbe..504ca69adc5a 100644
> > --- a/drivers/iommu/qcom_iommu.c
> > +++ b/drivers/iommu/qcom_iommu.c
> > @@ -585,7 +585,8 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
> >        * index into qcom_iommu->ctxs:
> >        */
> >       if (WARN_ON(asid < 1) ||
> > -         WARN_ON(asid > qcom_iommu->num_ctxs))
> > +         WARN_ON(asid > qcom_iommu->num_ctxs) ||
> > +         WARN_ON(qcom_iommu->ctxs[asid - 1] == NULL))
> >               return -EINVAL;
> >
> >       if (!fwspec->iommu_priv) {
> > @@ -693,7 +694,8 @@ static int qcom_iommu_sec_ptbl_init(struct device *dev)
> >
> >   static int get_asid(const struct device_node *np)
> >   {
> > -     u32 reg;
> > +     u32 reg, val;
> > +     int asid;
> >
> >       /* read the "reg" property directly to get the relative address
> >        * of the context bank, and calculate the asid from that:
> > @@ -701,7 +703,16 @@ static int get_asid(const struct device_node *np)
> >       if (of_property_read_u32_index(np, "reg", 0, &reg))
> >               return -ENODEV;
> >
> > -     return reg / 0x1000;      /* context banks are 0x1000 apart */
> > +     /* Context banks are 0x1000 apart but, in some cases, the ASID
> > +      * number doesn't match to this logic and needs to be passed
> > +      * from the DT configuration explicitly.
> > +      */
> > +     if (of_property_read_u32(np, "qcom,ctx-num", &val))
> > +             asid = reg / 0x1000;
> > +     else
> > +             asid = val;
> > +
> > +     return asid;
> >   }
> >
> >   static int qcom_iommu_ctx_probe(struct platform_device *pdev)
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
