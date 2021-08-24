Return-Path: <SRS0=4dF3=NP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCB7C4338F
	for <iommu@archiver.kernel.org>; Tue, 24 Aug 2021 07:10:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82DE66136F
	for <iommu@archiver.kernel.org>; Tue, 24 Aug 2021 07:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 82DE66136F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48D33404CE;
	Tue, 24 Aug 2021 07:10:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dO3BPL11nOFq; Tue, 24 Aug 2021 07:10:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C8ADC40494;
	Tue, 24 Aug 2021 07:10:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1C4CC001A;
	Tue, 24 Aug 2021 07:10:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 426EFC000E
 for <iommu@lists.linux-foundation.org>; Tue, 24 Aug 2021 07:10:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 24255404B1
 for <iommu@lists.linux-foundation.org>; Tue, 24 Aug 2021 07:10:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DqbVj7F5NI7D for <iommu@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 07:10:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 07C5640494
 for <iommu@lists.linux-foundation.org>; Tue, 24 Aug 2021 07:10:39 +0000 (UTC)
Received: by mail-io1-xd30.google.com with SMTP id a15so25091120iot.2
 for <iommu@lists.linux-foundation.org>; Tue, 24 Aug 2021 00:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LgRucL3K4cUFafkmcwegDWstDciTynvkAhKij7AEIBk=;
 b=XjwCcBqTjO8zbpgRAvkXX4cEK21t+nleXjTkL4VzdxxdLsNvjwNcndFWSg6JlrSwJq
 bpSdGFO+BrTrAT8Vmftfwj9hkT+k9VzKKyZauDR/U1vyuv5aWPiz/wR4BLCxKVgR0+Ar
 HAtZRuWjONau0qmolRjDQ0es97dtHpDqC2jDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LgRucL3K4cUFafkmcwegDWstDciTynvkAhKij7AEIBk=;
 b=tTJ05nDsSrgiZxY1KtxgTNLN+cESHm3Y0tkHXlYnLJOAV9/NKgDDrfko7kP3Cduz1u
 tlxHnSEzrOwBNl18xf3hyoJKrMbFA6n9kKatdSnjBlLKGtk2EF2NA/iA33otbw8xaorn
 218mEvqICMCbfh1REgvR4tgG1p9cGNrKyV19XqABNJweNOiBGlccEpd8MyHe59lvTl1a
 4RMEZwymarjolX7QntnF2QBa5t75VLfPWbuqh+b9v3oGtuNFoigs13+pBFwoPuc+lcdk
 wXEdPm4nKGHcFSaYkIvCRdhAqIcKm6Ybpb9JM64vFtev3ZY5mqTxhPyMJluWMtQCbxvX
 MWBQ==
X-Gm-Message-State: AOAM533Btsc1kKErvLI4a2l0ZpRXnN3QLNN5w0b+xEmEDC/fXvy4wQOP
 vgG5sWArSyZYBP2pbNENeh8hUaTlj9rOJMDhxFaDnw==
X-Google-Smtp-Source: ABdhPJxa8cXPwlwxMitmLNqhhcUpAXaFNNqqlX3QkiCbaPVcTW2lKOWSXVoLKeh/GHZwtAyAQE/miho2FRPpMMPkaXY=
X-Received: by 2002:a05:6602:341:: with SMTP id
 w1mr29896459iou.40.1629789038867; 
 Tue, 24 Aug 2021 00:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210813065324.29220-1-yong.wu@mediatek.com>
 <20210813065324.29220-12-yong.wu@mediatek.com>
In-Reply-To: <20210813065324.29220-12-yong.wu@mediatek.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Tue, 24 Aug 2021 15:10:12 +0800
Message-ID: <CAJMQK-hkufqh2vaEKcuO+k0v2SzpCHcyZuEqrvJ__rrAek2P0A@mail.gmail.com>
Subject: Re: [PATCH v2 11/29] iommu/mediatek: Always pm_runtime_get while tlb
 flush
To: Yong Wu <yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, Devicetree List <devicetree@vger.kernel.org>,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Will Deacon <will@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 chao.hao@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>,
 anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
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

On Fri, Aug 13, 2021 at 2:57 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> Prepare for 2 HWs that sharing pgtable in different power-domains.
>
> The previous SoC don't have PM. Only mt8192 has power-domain,
> and it is display's power-domain which nearly always is enabled.
>
> When there are 2 M4U HWs, it may has problem.
> In this function, we get the pm_status via the m4u dev, but it don't
> reflect the real power-domain status of the HW since there may be other
> HW also use that power-domain.
>
> Currently we could not get the real power-domain status, thus always
> pm_runtime_get here.
>
> Prepare for mt8195, thus, no need fix tags here.
>
> This patch may drop the performance, we expect the user could
> pm_runtime_get_sync before dma_alloc_attrs which need tlb ops.

Can you check if there are existing users that need to add this change?


>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
<snip>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
