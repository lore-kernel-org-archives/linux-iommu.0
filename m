Return-Path: <SRS0=kiHz=X6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29560C47404
	for <iommu@archiver.kernel.org>; Sat,  5 Oct 2019 09:32:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5937222BE
	for <iommu@archiver.kernel.org>; Sat,  5 Oct 2019 09:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGgoSK/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5937222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8BB7BEDF;
	Sat,  5 Oct 2019 09:32:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 22B40EDC
	for <iommu@lists.linux-foundation.org>;
	Sat,  5 Oct 2019 09:32:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7B30F8BB
	for <iommu@lists.linux-foundation.org>;
	Sat,  5 Oct 2019 09:32:48 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id r5so9762224wrm.12
	for <iommu@lists.linux-foundation.org>;
	Sat, 05 Oct 2019 02:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=pntu1CK1dS0lzxHUf7ofFrO+ckSUEFkqFaRN5hyK1jU=;
	b=HGgoSK/5GYJR0F3GhQO9EUDjvhWsWUTrsahMmDknizjIbjJmLjXRmbnisKdFDlw1tb
	Fw4MJLW8E2VlPwkt0nwPlxiBoKuW/zCsEPpThmchb3CrQ3EqAH++QFEoesimKCIWnVMD
	ofLDZFqsBr+ThbFkMO2EfB8ZESM7/7KgpNq7fsk9/g+RlViKrzfXbIdHT1Qhbu3lvIMx
	UtXgkQ9vuoDvl5oMsNJk8JnHyaxlk1f4aIVnAav3PF6OoByX1K6fCXrEjXLm1henmxoK
	f1Y2evRq/iKiWRz1owlmAHKpucSsklKC/tTRzPWTL/JTKLa3oXOkfuVKdQvl9A4NfQf2
	AmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=pntu1CK1dS0lzxHUf7ofFrO+ckSUEFkqFaRN5hyK1jU=;
	b=tqyfcVgGBj5vNXrE6p4Kx1D4hYQQ6LiJTT/n9P3mlcEA6MBEeIC9D4wQBdPxKbBz8c
	tIw+0IX5E94qHcfkVtvi3Ba/NWEUjZ3jgRpDpMhqePPzLRsO3jTipapVKPcxuYYYC/Za
	7CyyT/TxIMtcchAtVuU4/DE/U38Fr4CN5Gbjf6COdFOcZ0Y7XYgVt66HMoszKvA3K/vJ
	YZ9rVCreZLIyYMui52Ll9B0Gj8WZaE03eFmrT/mSoqbvzRNZFliUuhp+NYj38qLmDNfM
	fWC+LwiLuEHz6hOBrGZO5jbsnb8+EW/MxlosiVXhCkOBwsHbFibkUltUsE6wYZC6Escq
	exRQ==
X-Gm-Message-State: APjAAAXFj2KkORX0s7oXwUvMc8jGcwlATyQqco/w8fSZXZyOqmNpHIB2
	A9lqwGb/8eZELqXm4F70AM168Lb8NzlAT6J36TE=
X-Google-Smtp-Source: APXvYqxNtYBHk5Odq96y9vD4Gs9Bcv17kGdUpQoSlANLkRooaQClL7PwH5ECnkRRm/7MQgBARX7Ox4LIRBgsSh74Oz4=
X-Received: by 2002:a05:6000:1090:: with SMTP id
	y16mr14481615wrw.316.1570267966846; 
	Sat, 05 Oct 2019 02:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20191001220205.6423-1-kholk11@gmail.com>
	<20191005045626.GE6390@tuxbook-pro>
In-Reply-To: <20191005045626.GE6390@tuxbook-pro>
From: AngeloGioacchino Del Regno <kholk11@gmail.com>
Date: Sat, 5 Oct 2019 11:32:35 +0200
Message-ID: <CAK7fi1ZkjV6vt=OeRYz2JGC9v4n4eb5Rupqc0TWQmnM1UdJ-mg@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Add support for QCOM IOMMU v2 and 500
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: marijns95@gmail.com, MSM <linux-arm-msm@vger.kernel.org>,
	iommu@lists.linux-foundation.org, agross@kernel.org
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

Il giorno sab 5 ott 2019 alle ore 06:56 Bjorn Andersson
<bjorn.andersson@linaro.org> ha scritto:
>
> On Tue 01 Oct 15:01 PDT 2019, kholk11@gmail.com wrote:
>
> > From: AngeloGioacchino Del Regno <kholk11@gmail.com>
> >
> > Some Qualcomm Family-B SoCs have got a different version of the QCOM
> > IOMMU, specifically v2 and 500, which perfectly adhere to the current
> > qcom_iommu driver, but need some variations due to slightly different
> > hypervisor behavior.
> >
>
> Do you think it's out of the question to get the arm-smmu driver to play
> nice with this platform?
>
>
> If not, would it be possible to change the DT binding so that we specify
> the SID and then read the SMR and S2CR registers to figure out the
> associated context bank?
>
> Regards,
> Bjorn
>
> > The personal aim is to upstream MSM8956 as much as possible.
> >
> > This code has been tested on two Sony phones featuring the Qualcomm
> > MSM8956 SoC.
> >
> > Changes in v2:
> > - Fixed optional properties placement in documentation
> >
> > Changes in v3:
> > - Rebased onto linux-next 01/10/2019
> > - Added missing SCM commit (required by the AArch64 PT switch support)
> >
> > Changes in v4:
> > - Removed rej files from the SCM patch (I'm truly sorry for the noise...)
> >
> > Angelo G. Del Regno (1):
> >   firmware: qcom: scm: Add function to set IOMMU pagetable addressing
> >
> > AngeloGioacchino Del Regno (6):
> >   iommu/qcom: Use the asid read from device-tree if specified
> >   iommu/qcom: Write TCR before TTBRs to fix ASID access behavior
> >   iommu/qcom: Properly reset the IOMMU context
> >   iommu/qcom: Add support for AArch64 IOMMU pagetables
> >   iommu/qcom: Index contexts by asid number to allow asid 0
> >   iommu/qcom: Add support for QCIOMMUv2 and QCIOMMU-500 secured contexts
> >
> >  .../devicetree/bindings/iommu/qcom,iommu.txt  |   5 +
> >  drivers/firmware/qcom_scm-32.c                |   6 +
> >  drivers/firmware/qcom_scm-64.c                |  15 ++
> >  drivers/firmware/qcom_scm.c                   |   7 +
> >  drivers/firmware/qcom_scm.h                   |   4 +
> >  drivers/iommu/qcom_iommu.c                    | 134 ++++++++++++++----
> >  include/linux/qcom_scm.h                      |   2 +
> >  7 files changed, 145 insertions(+), 28 deletions(-)
> >
> > --
> > 2.21.0
> >

In reality, when I started the IOMMU integration for this SoC, the
arm-smmu didn't even
have the new arm-smmu-impl stuff....
I tried multiple times to get the arm-smmu driver to play nice with
this IOMMU, but it's
really too much work to do there, (even with the new arm-smmu-impl
stuff) as we would
have to make a lot of changes in that driver just to support
this thing which, yes - it's standard-ish - but no, due to the
firmware configuration that
happens on this kind of platforms (the entire family, 8917, 8953,
8956, 8976 and others)
there is a lil percent of the arm-smmu code that would apply.

Shorter said, since it would be a complete mess to integrate the
support there, IMHO
it's really not a good idea.
In my trials for that I've ended up changing like 50% of the arm-smmu driver.

After all, the qcom_iommu driver is there to get IOMMUs with this kind
of firmware
configuration working and, even if it was originally done for
QCIOMMUv1, as I have
also explained in one of the patches here, 98-99% of the reasons why we have a
separate driver called qcom_iommu are applying to the implementation
that I've done.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
