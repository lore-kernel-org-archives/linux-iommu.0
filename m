Return-Path: <SRS0=ylBP=CQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EB3C433E2
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 15:06:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8446217A0
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 15:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8446217A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 82D9A8612B;
	Mon,  7 Sep 2020 15:06:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9lM68fubHaeK; Mon,  7 Sep 2020 15:06:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4F0F086126;
	Mon,  7 Sep 2020 15:06:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3879FC0859;
	Mon,  7 Sep 2020 15:06:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5AB7C0051
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 15:06:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 97DDF86FB6
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 15:06:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p6eUVHERDrYV for <iommu@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 15:06:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 72F7086F12
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 15:06:24 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 1DD539F4;
 Mon,  7 Sep 2020 11:06:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 07 Sep 2020 11:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=L
 NZ9BDmmfmh8OGRK1OlhnYmyHiIUpzUacs8VOuZ8w04=; b=b4Lsgrtj1BefwDoze
 GoY+2YUuX9foRM6JEnPjjbbzW3QWu/bmUz7Y8VZC4vdfCNVhOUQiYrsxE/tjM15Z
 Dz64NKf4bO8eO2RwyKiQldZs/Uae1LIH4kuGpm0Grf56IJOGGLh0qooWon9sE726
 dg2PMCTq12IomJMDwyUYRfkUiaTD8dYE3dqupxdT5k1vcHp5HZMF34JjKOwvg8RR
 qlFRsdwzqpn7M4CXw3FXWJWT+w7qflADPCCxF37YVrC8M4D1QxqbrlD99nc+dewU
 R6XLlo2+gJRoXlokO3wjiJsxVtyO/ueqSt5A5n+xZhBWEjKAeFiI3WygY9yCoIvA
 8RYeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=LNZ9BDmmfmh8OGRK1OlhnYmyHiIUpzUacs8VOuZ8w
 04=; b=oit6HXSQwQ3Pc5j8CLHTcfTDtPuanq54o0vpR49cmF06zmWpqYYUm14wp
 R27+FUag2zO+7urGk+wkNjLto/xXB+MLX+i7a2750r/Z7IQKhnn2+RBp/UYsRTtw
 hEnnp49RKcfHKGmcc0VhMhW4u5gwFYxeO5N+EiD0LokC6RLILSFyo1UUOnmMBoDA
 6ghcZ3feLz13Pkcrq5W6KuklbwjnmYuLJUqToZGGjafxjFzD0PpedTWM531MPdSB
 VC7Uog1yTkJ9ShtAhICaubzvvWhhuxCyfT6+ZJcxOD9aFJDcUEjZb8eq1eyA0our
 9DpsB3HDTG2/DCx9Fwo/dgHRkDk2Q==
X-ME-Sender: <xms:bExWX5hvB2c1DXTApKg9kSFi8rcMFPEaFQSf7cgwA8l09xl8hei9kg>
 <xme:bExWX-Avg4SIZpEj2QHC8TJ4CiByNHtPQMuSKNUNMuQ2tHC4-GUKCM9g-Ohbmjvq8
 zqkujN-LfaYxK3zmWo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehtddgkeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgrgihi
 mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
 htthgvrhhnpefgjeettdejgffgffdvteeutdehtdehgeehueetkeefgefhtdetjeekledu
 gedvudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:bUxWX5H6vqLO6TSycubojKKngmIoVKgGlCxCk9NQg_-rQoIcb3dNUA>
 <xmx:bUxWX-Rh_uDvmu5v3LsrQmpThnnVvDA9u5fnXK-vEXEFGSN2z9aO0w>
 <xmx:bUxWX2xKtoq9D8FkMWi-ZJUHfZ5flWSVaDEo3i9ciggeuL2BhVHccQ>
 <xmx:bkxWXws13rGW-YmoakDpzmdVREQJx3esuT1q_JWn754Jk6pNqTiohA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id B5E35328005A;
 Mon,  7 Sep 2020 11:06:20 -0400 (EDT)
Date: Mon, 7 Sep 2020 17:06:18 +0200
From: Maxime Ripard <maxime@cerno.tech>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/sun50i: Fix set-but-not-used variable warning
Message-ID: <20200907150618.g6jbkmvosfh2ek73@gilmour.lan>
References: <20200904113906.3906-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200904113906.3906-1-joro@8bytes.org>
Cc: Joerg Roedel <jroedel@suse.de>, kernel test robot <lkp@intel.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org
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

On Fri, Sep 04, 2020 at 01:39:06PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Fix the following warning the the SUN50I driver:
> 
>    drivers/iommu/sun50i-iommu.c: In function 'sun50i_iommu_irq':
>    drivers/iommu/sun50i-iommu.c:890:14: warning: variable 'iova' set but not used [-Wunused-but-set-variable]
>      890 |  phys_addr_t iova;
>          |              ^~~~
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
