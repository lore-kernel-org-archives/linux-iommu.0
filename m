Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EF5C433EF
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 20:57:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ED2E340439;
	Tue, 31 May 2022 20:57:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id spabr8NHJPfm; Tue, 31 May 2022 20:57:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CA4C84014B;
	Tue, 31 May 2022 20:57:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0746C0039;
	Tue, 31 May 2022 20:57:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76B81C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 20:57:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5693960C02
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 20:57:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yh70-zcYuXx1 for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 20:57:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9113B60BFE
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 20:57:37 +0000 (UTC)
Received: by mail-yb1-xb2f.google.com with SMTP id r82so16093282ybc.13
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 13:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=40PFJ0KLH49o2a7cmdjfg2UDZMZZdNplRaKSZa0P70Q=;
 b=LBlxs6gYEgXpIHzbh/d2m73G/hVo58iw9hM6LSB/n8UZVrLtWmWJcf/Kcknu7MJ9vm
 VSem7YSJt0MJpSwq27DrpYfJs87MeGMiD8s1bGVpRcg7ChM/HxOIEmrCouq8t3T4GkLy
 qRPBLVQk+Y8Nmh9lcPFusObbG7vzv07rFgyazbunNxfOYZ7ZpCAgsycDEnDP/TYzMZc2
 0Y04REpfMJ1rBdirpsJZ8obMwZJXp67ko/TkIn/YxOaZhlzPR+TRulxC0Iv6bpR4301M
 mGEp2JR8EDIg7LqW/OzT3eyNzutKNAZBp+VUQuOepprYS6fQLo+ZjaO4z/MDjkqkqLyT
 B8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=40PFJ0KLH49o2a7cmdjfg2UDZMZZdNplRaKSZa0P70Q=;
 b=sB2w2Qfk3yXzwZGtCxddkF2pCrVqy/hcAZ9xLkqGMeWeWvoEpM412gfTRDsyDedx4L
 6+YQJcEGu0WzgxUsDTrchNtps6wUvtnMTHgXZu7tO9uvZUmoe4OVnA5W32Q04y0mxUMR
 ltbPOYnNmvteTtmWrUsCPDBvxKMtGXuy29HCWSajV9GnDveMOAYeG9yiHzIkq2j0DsSs
 igyKxNUgc1QY05txSklX4lzfJReQeloK6FI26XqFC23MGHFbbh4vpXRFyvTSnEqYD4Ko
 C0yONVcfJ9d4BYlcYMb34kEJSWaqPnzlo+1IMjvzDZPsuxkV/ap47Emk3BUJZQNefgJd
 4wkQ==
X-Gm-Message-State: AOAM531vkey+OXPK94gODHgAv+5r+Sr9eBxcCLkCydan5WB2DcV+pG2r
 rDB8GkWRJYiuBcCrl5ZFSBrGuW7LNxTZXnxFiI4=
X-Google-Smtp-Source: ABdhPJzQE7CiGqybeME8r7CuvSaMGGUpdihIcHV4tk3SkMKBdECTjWnhek2dsW+WK3DiuQFC0Ll3kcDD08GIokCy2FA=
X-Received: by 2002:a05:6902:1003:b0:64f:2e69:c97d with SMTP id
 w3-20020a056902100300b0064f2e69c97dmr59688647ybt.605.1654030656439; Tue, 31
 May 2022 13:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220527212901.29268-1-konrad.dybcio@somainline.org>
 <20220527212901.29268-2-konrad.dybcio@somainline.org>
 <20220531154631.GA25502@willie-the-truck>
 <CAF6AEGsWsHfQZnszG=NgP0BufxO-DP4LwvsAYkrz2wRhcJuOXw@mail.gmail.com>
 <20220531161910.GE25502@willie-the-truck>
In-Reply-To: <20220531161910.GE25502@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 31 May 2022 13:57:37 -0700
Message-ID: <CAF6AEGvF+5mf6jE9Xac1qR9P+-=ELLu_LzoJhUV-Dx2RYH20Ag@mail.gmail.com>
Subject: Re: [PATCH 1/6] iommu/qcom: Use the asid read from device-tree if
 specified
To: Will Deacon <will@kernel.org>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 jamipkettunen@somainline.org, Rob Herring <robh+dt@kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Andy Gross <agross@kernel.org>, Martin Botka <martin.botka@somainline.org>,
 ~postmarketos/upstreaming@lists.sr.ht,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

On Tue, May 31, 2022 at 9:19 AM Will Deacon <will@kernel.org> wrote:
>
> On Tue, May 31, 2022 at 09:15:22AM -0700, Rob Clark wrote:
> > On Tue, May 31, 2022 at 8:46 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > On Fri, May 27, 2022 at 11:28:56PM +0200, Konrad Dybcio wrote:
> > > > From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > > >
> > > > As specified in this driver, the context banks are 0x1000 apart.
> > > > Problem is that sometimes the context number (our asid) does not
> > > > match this logic and we end up using the wrong one: this starts
> > > > being a problem in the case that we need to send TZ commands
> > > > to do anything on a specific context.
> > >
> > > I don't understand this. The ASID is a software construct, so it shouldn't
> > > matter what we use. If it does matter, then please can you explain why? The
> > > fact that the context banks are 0x1000 apart seems unrelated.
> >
> > I think the connection is that mapping from ctx bank to ASID is 1:1
>
> But in what sense? How is the ASID used beyond a tag in the TLB? The commit
> message hints at "TZ commands" being a problem.
>
> I'm not doubting that this is needed to make the thing work, I just don't
> understand why.

(disclaimer, it has been quite a while since I've looked at the smmu
setup with earlier tz, ie. things that use qcom_iommu, but from
memory...)

We cannot actually assign the context banks ourselves, so in the dt
bindings the "ASID" is actually the context bank index.  I don't
remember exactly if this was a limitation of the tz interface, or
result of not being able to program the smmu's global registers
ourselves.

BR,
-R
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
