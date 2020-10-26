Return-Path: <SRS0=cbBT=EB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A92EC4363A
	for <iommu@archiver.kernel.org>; Mon, 26 Oct 2020 20:09:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 998E421D41
	for <iommu@archiver.kernel.org>; Mon, 26 Oct 2020 20:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 998E421D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 09B05870C8;
	Mon, 26 Oct 2020 20:09:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KN+2+POmyXur; Mon, 26 Oct 2020 20:09:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6FDBC870BE;
	Mon, 26 Oct 2020 20:09:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 550DAC088B;
	Mon, 26 Oct 2020 20:09:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00A48C0051
 for <iommu@lists.linux-foundation.org>; Mon, 26 Oct 2020 20:09:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E3178805C6
 for <iommu@lists.linux-foundation.org>; Mon, 26 Oct 2020 20:09:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nnTA6P2JmDBV for <iommu@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 20:09:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4904185A1D
 for <iommu@lists.linux-foundation.org>; Mon, 26 Oct 2020 20:08:44 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id x1so10853562eds.1
 for <iommu@lists.linux-foundation.org>; Mon, 26 Oct 2020 13:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QAhJNTcBuylpc827Gc8DE790mcWVOqgUgREe8IN9rGk=;
 b=K89y24K8qgY7TykZAjBwj8aS06cFVjJbkuGK4AJi7fj1MK+vrdXZkxH8Vn30u/3lra
 sfsHAC1zX9szHb+WF2Sg05qIYstTpBOm39ejpO2uIJpxyx4SlafrN53fY9jJ1OrdDGPw
 bAgRE7NDPOMp2TsjMy8DOI0B8BmS8H5qWZOilv16C5OtfDtC1gLp/yr7rZMMCNYhDEgZ
 9e/2VJ7icGjR4g4LtA7MZZwczZGopQMYP/LoMTP780izLwiIUTfrrwJzR6mK7gEHqadi
 IW6nytB0FzdsGPQ0BIm/2Csn50hhiab50KBFnMd54HLIqknq6ygI1yLznTRrTj9fMy/D
 guDA==
X-Gm-Message-State: AOAM531I+hqLJ7/zD1K6j9kVKmWzqpI2av0aoSs5ot4LU57T4KtmfWcm
 d/N79r6FBdls0KynEwtdz04=
X-Google-Smtp-Source: ABdhPJyeTtkh+7BD+iZP00A29Rs+E9CbsQNM30SNnmXJaudtE/elyiDZQpiu12bDhX/8rOr3FlmfEA==
X-Received: by 2002:a50:fb0d:: with SMTP id d13mr17781115edq.85.1603742922751; 
 Mon, 26 Oct 2020 13:08:42 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
 by smtp.googlemail.com with ESMTPSA id f23sm6453141ejd.5.2020.10.26.13.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 13:08:41 -0700 (PDT)
Date: Mon, 26 Oct 2020 21:08:38 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v3 00/24] MT8192 IOMMU support
Message-ID: <20201026200838.GB240203@kozik-lap>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200930070647.10188-1-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 kernel-team@android.com, Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream@mediatek.com, chao.hao@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@google.com>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com,
 anan.sun@mediatek.com, Will Deacon <will@kernel.org>,
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

On Wed, Sep 30, 2020 at 03:06:23PM +0800, Yong Wu wrote:
> This patch mainly adds support for mt8192 IOMMU and SMI.
> 
> mt8192 also is MTK IOMMU gen2 which uses ARM Short-Descriptor translation
> table format. The M4U-SMI HW diagram is as below:
> 
>                           EMI
>                            |
>                           M4U
>                            |
>                       ------------
>                        SMI Common
>                       ------------
>                            |
>   +-------+------+------+----------------------+-------+
>   |       |      |      |       ......         |       |
>   |       |      |      |                      |       |
> larb0   larb1  larb2  larb4     ......      larb19   larb20
> disp0   disp1   mdp    vdec                   IPE      IPE
> 
> All the connections are HW fixed, SW can NOT adjust it.
> 
> Comparing with the preview SoC, this patchset mainly adds two new functions:
> a) add iova 34 bits support.
> b) add multi domains support since several HW has the special iova
> region requirement.
> 
> this patchset depend on v5.9-rc1.

Hi,

I think there will be v4 of this, right? If yes, please also describe
the dependencies between the patches. If the entire patchset is strictly
ordered, then mention this as well.

Best regards,
Krzysztof

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
