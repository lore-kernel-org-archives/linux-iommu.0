Return-Path: <SRS0=TfAO=UR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78861C31E51
	for <iommu@archiver.kernel.org>; Tue, 18 Jun 2019 14:06:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DBA220B1F
	for <iommu@archiver.kernel.org>; Tue, 18 Jun 2019 14:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="djkt6tnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DBA220B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 10D64E3A;
	Tue, 18 Jun 2019 14:05:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 873E8E3E
	for <iommu@lists.linux-foundation.org>;
	Tue, 18 Jun 2019 14:05:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B35FA822
	for <iommu@lists.linux-foundation.org>;
	Tue, 18 Jun 2019 14:05:53 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id c2so14137977wrm.8
	for <iommu@lists.linux-foundation.org>;
	Tue, 18 Jun 2019 07:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=8qHqhUTLPLAeUp/D+WrLyXnpz1H1Jll7QCXTM4rdBnU=;
	b=djkt6tnmuZedsgQ4v+Rua7yfQcRyCI0RbFda0KhvSR/oADzdiA/209ohNfhcVRf8d6
	lBE9K/fJZ8A/ZxP0jl48u8DqygtjLk6pPcX8AUimocdYXLXQw2RJnr38R2XKwe/o6X9N
	ZOamdY9l71DGHUPX8V3uIZCrEbLY+wqRqK7B1FvRUTZM/MkMpzxXqA7hgrkn5Vv+p3o/
	2i+Q5LM8XfqFHVaM1HEQ/GwNCw/9/FMpfSh9bxU2w3XRUBG016B+1xnhdb43B8UsSRqy
	+fvmLZDCETQ8DJLKlkJh49O4rQZNrKvjfVhSeSVPO8KLHJgxbRRnFB65V8aEhN9ws1tS
	SjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=8qHqhUTLPLAeUp/D+WrLyXnpz1H1Jll7QCXTM4rdBnU=;
	b=t1w4r52Vl1O2VpmYO1UZLdxvYZCT/CrGW8YzFNUAbFm2nP7A1oSJPPeF7RqrUOl8zN
	D2qSPpL3JpUttnLj2RAOlmogLP+Fe/IWfgq4TxtApxgDj5WkqoYvtm2OnitifsH/JZFr
	SWP2RwRgJWctbYU9d6m856xAzBQC2Iw+AWEnvhm9rTBa5SvjRpMG0qmsmxS9xHV4xzHT
	VsRNTub49yr97p/McSRMwBiGE4zt7VF1QCfUfkIcz7FbLzTiqZjNLomw+SSo2RzZ3K9H
	fWvuBsjpznRMYVOqXg1Bo++5d/3BkcjAMwbfl8FXvSuquIjzl+uNnTS1xNWMBeROKO5s
	SOHA==
X-Gm-Message-State: APjAAAULg4Ko0KtLi48MxEtf8gnm3vnaTfOsth3UuGixal4wBdm5ErRx
	nWqplAuTlQbn6oRbBp1NUTvT+tt9uDjIDY3rVOp1lA==
X-Google-Smtp-Source: APXvYqweODXawSwtgymTZRrJNdMT45q8SqezxZPypJ8zBOLy843m58QTD1p0JxHjbascNuxyphfbzEeuTcKrS6urlOY=
X-Received: by 2002:adf:90c3:: with SMTP id i61mr63288158wri.48.1560866751639; 
	Tue, 18 Jun 2019 07:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <1560169080-27134-1-git-send-email-yong.wu@mediatek.com>
	<1560169080-27134-15-git-send-email-yong.wu@mediatek.com>
	<CAAFQd5A5GUn1Zq1xF2_2V0MReNPd5bra2F=nquvodSAZUua5AQ@mail.gmail.com>
	<1560859743.8082.23.camel@mhfsdcap03>
In-Reply-To: <1560859743.8082.23.camel@mhfsdcap03>
Date: Tue, 18 Jun 2019 23:05:39 +0900
Message-ID: <CAAFQd5B8MiMA_OCUJ5HRmC5SA2772HF-rBGK0aZcKoWscOzOog@mail.gmail.com>
Subject: Re: [PATCH v7 14/21] iommu/mediatek: Add mmu1 support
To: Yong Wu <yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
	Nicolas Boichat <drinkcat@chromium.org>,
	srv_heupstream <srv_heupstream@mediatek.com>,
	Will Deacon <will.deacon@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Evan Green <evgreen@chromium.org>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	Rob Herring <robh+dt@kernel.org>, "moderated list:ARM/Mediatek SoC support"
	<linux-mediatek@lists.infradead.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	=?UTF-8?B?WWluZ2pvZSBDaGVuICjpmbPoi7HmtLIp?=
	<yingjoe.chen@mediatek.com>, anan.sun@mediatek.com,
	Robin Murphy <robin.murphy@arm.com>, Matthias Kaehlcke <mka@chromium.org>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>
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
From: Tomasz Figa via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tomasz Figa <tfiga@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue, Jun 18, 2019 at 9:09 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Tue, 2019-06-18 at 15:19 +0900, Tomasz Figa wrote:
> > On Mon, Jun 10, 2019 at 9:21 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > >
> > > Normally the M4U HW connect EMI with smi. the diagram is like below:
> > >               EMI
> > >                |
> > >               M4U
> > >                |
> > >             smi-common
> > >                |
> > >        -----------------
> > >        |    |    |     |    ...
> > >     larb0 larb1  larb2 larb3
> > >
> > > Actually there are 2 mmu cells in the M4U HW, like this diagram:
> > >
> > >               EMI
> > >            ---------
> > >             |     |
> > >            mmu0  mmu1     <- M4U
> > >             |     |
> > >            ---------
> > >                |
> > >             smi-common
> > >                |
> > >        -----------------
> > >        |    |    |     |    ...
> > >     larb0 larb1  larb2 larb3
> > >
> > > This patch add support for mmu1. In order to get better performance,
> > > we could adjust some larbs go to mmu1 while the others still go to
> > > mmu0. This is controlled by a SMI COMMON register SMI_BUS_SEL(0x220).
> > >
> > > mt2712, mt8173 and mt8183 M4U HW all have 2 mmu cells. the default
> > > value of that register is 0 which means all the larbs go to mmu0
> > > defaultly.
> > >
> > > This is a preparing patch for adjusting SMI_BUS_SEL for mt8183.
> > >
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > Reviewed-by: Evan Green <evgreen@chromium.org>
> > > ---
> > >  drivers/iommu/mtk_iommu.c | 46 +++++++++++++++++++++++++++++-----------------
> > >  1 file changed, 29 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > > index 3a14301..ec4ce74 100644
> > > --- a/drivers/iommu/mtk_iommu.c
> > > +++ b/drivers/iommu/mtk_iommu.c
> > > @@ -72,26 +72,32 @@
> > >  #define F_INT_CLR_BIT                          BIT(12)
> > >
> > >  #define REG_MMU_INT_MAIN_CONTROL               0x124
> > > -#define F_INT_TRANSLATION_FAULT                        BIT(0)
> > > -#define F_INT_MAIN_MULTI_HIT_FAULT             BIT(1)
> > > -#define F_INT_INVALID_PA_FAULT                 BIT(2)
> > > -#define F_INT_ENTRY_REPLACEMENT_FAULT          BIT(3)
> > > -#define F_INT_TLB_MISS_FAULT                   BIT(4)
> > > -#define F_INT_MISS_TRANSACTION_FIFO_FAULT      BIT(5)
> > > -#define F_INT_PRETETCH_TRANSATION_FIFO_FAULT   BIT(6)
> > > +                                               /* mmu0 | mmu1 */
> > > +#define F_INT_TRANSLATION_FAULT                        (BIT(0) | BIT(7))
> > > +#define F_INT_MAIN_MULTI_HIT_FAULT             (BIT(1) | BIT(8))
> > > +#define F_INT_INVALID_PA_FAULT                 (BIT(2) | BIT(9))
> > > +#define F_INT_ENTRY_REPLACEMENT_FAULT          (BIT(3) | BIT(10))
> > > +#define F_INT_TLB_MISS_FAULT                   (BIT(4) | BIT(11))
> > > +#define F_INT_MISS_TRANSACTION_FIFO_FAULT      (BIT(5) | BIT(12))
> > > +#define F_INT_PRETETCH_TRANSATION_FIFO_FAULT   (BIT(6) | BIT(13))
> >
> > If there are two IOMMUs, shouldn't we have two driver instances handle
> > them, instead of making the driver combine them two internally?
>
> Actually it means only one IOMMU(M4U) HW here. Each a M4U HW has two
> small iommu cells which have independent MTLB. As the diagram above, M4U
> contain mmu0 and mmu1.
>
> MT8173 and MT8183 have only one M4U HW while MT2712 have 2 M4U HWs(two
> driver instances).
>
> >
> > And, what is even more important from security point of view actually,
> > have two separate page tables (aka IOMMU groups) for them?
>
> Each a IOMMU(M4U) have its own pagetable, thus, mt8183 have only one
> pagetable while mt2712 have two.

I see, thanks for clarifying.

Best regards,
Tomasz
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
