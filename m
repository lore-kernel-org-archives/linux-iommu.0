Return-Path: <SRS0=A77v=NM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3B6C4338F
	for <iommu@archiver.kernel.org>; Sat, 21 Aug 2021 08:56:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75DDB611EF
	for <iommu@archiver.kernel.org>; Sat, 21 Aug 2021 08:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 75DDB611EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3527781AC1;
	Sat, 21 Aug 2021 08:56:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xvEEg6t3oj-I; Sat, 21 Aug 2021 08:56:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8EA6881AD7;
	Sat, 21 Aug 2021 08:56:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52EAEC001A;
	Sat, 21 Aug 2021 08:56:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 891ECC000E
 for <iommu@lists.linux-foundation.org>; Sat, 21 Aug 2021 08:56:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 62D51403D5
 for <iommu@lists.linux-foundation.org>; Sat, 21 Aug 2021 08:56:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="EM2C91Gm";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="MFS74d/0"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gaDPrDD8-RjB for <iommu@lists.linux-foundation.org>;
 Sat, 21 Aug 2021 08:56:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B4424403E2
 for <iommu@lists.linux-foundation.org>; Sat, 21 Aug 2021 08:56:24 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailnew.nyi.internal (Postfix) with ESMTP id AA9955808E8;
 Sat, 21 Aug 2021 04:56:20 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute1.internal (MEProxy); Sat, 21 Aug 2021 04:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm2; bh=h9Kir/nZ4viveWZj6if1mMoXrM2T
 79miit0Y6rMxCEQ=; b=EM2C91GmGrHqFGh783WiDVgsDjZMi8pTb3mo5cYNpPHr
 iLozLvafGomEW2jN2hOZ2dPMcnKQ9P5XBjfjjQ9zUIZpwC3Hz2omaeCTxvIk65ea
 LBDI1sqVF/fNQT4P87gvAbLorb+8dEIuTh9rAYfp6dQJtgluVZEv9acoZXLXBIGq
 ps3zXaYO28KwnyJU4+ogxT2g+MLkJt3tGoO160MMcxG3pgaA12SMhsLXgdP9ThJa
 BE6+bJMal9DlVP0t41pJc21diaVTXdR4Ox+Pg2VLrGKUKqIG1iEX7Nu/cPP5jtEb
 QCyDOsKtynpx1kc66nzjDMDp1VFtqs8u4qWGWxLEWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=h9Kir/
 nZ4viveWZj6if1mMoXrM2T79miit0Y6rMxCEQ=; b=MFS74d/0EDmAvum/E8QaZB
 kH2F5bbYwUvVN3TIYhuipoMTqwB2Tr7LhmxxbbIE3i4ovfAS74wI9d8MWHLxty4R
 lHsBtPCFRmXBsCG5AeGUeACEyHukD0uwGz1K6fiQDVdPXk2G3Si01JbFhOYuXkZ2
 Gc+PW3qJvqstPUQ0unWos52Cc26LNEy/k5xC6Mc2Wst66LwdzatvWULAEx9FRpst
 ThwiknP0C6VZFmLD3wIvLBdu3P2XLYG6WWLU1DYPdYnHb9VmVe33q/Vx1RTjt3/K
 2mnnZsTnX71RKVE91Z5PDMYsAeg/AwRq+dA2f2gDz8Lpiq26wDIcQJ7g/K8LD8kw
 ==
X-ME-Sender: <xms:r78gYeEJvDR5AvsMahKMyU3TF8l58iVSlNe4YdHyeNDTq_x4K9P8vA>
 <xme:r78gYfV2UuZnfhGjNAVV1vXinzDSZsD7z9em63H0cLoJVwHnhopqVaA2OCMorDvsS
 bXRNnQCuyC6vfsIVTs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtuddguddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
 feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:r78gYYIcOT94hR5G3e1oSh-RroUfbmvdg-RnBOuHaJWbrHjyHjhAww>
 <xmx:r78gYYFbqYMSwszfFwdoB8BYddxPImIjziBNPDm9lGUy5E7pDoXcgw>
 <xmx:r78gYUWggawHUsAA-3ynIaoqtseBuh391-tuWQ8eSotrs8Cc3f17uQ>
 <xmx:tL8gYaaGJviswBV6IMd-yrKua90y5suaZTYtN-KDNrhq0bYbmYT7IQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 023C451C0060; Sat, 21 Aug 2021 04:56:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1118-g75eff666e5-fm-20210816.002-g75eff666
Mime-Version: 1.0
Message-Id: <5704924b-e3e3-404a-a4f4-e38ece82673b@www.fastmail.com>
In-Reply-To: <914d7243-7f9d-425e-1ff7-6be218e04913@arm.com>
References: <cover.1628682048.git.robin.murphy@arm.com>
 <YRzvGxTW8m+NUcSi@8bytes.org> <914d7243-7f9d-425e-1ff7-6be218e04913@arm.com>
Date: Sat, 21 Aug 2021 10:55:52 +0200
To: "Robin Murphy" <robin.murphy@arm.com>
Subject: Re: [PATCH v4 00/24] iommu: Refactor DMA domain strictness
Cc: Maxime Ripard <mripard@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Heiko Stuebner <heiko@sntech.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-kernel@vger.kernel.org, Chunyan Zhang <chunyan.zhang@unisoc.com>,
 dianders@chromium.org, Sven Peter <iommu@lists.linux-foundation.org>,
 rajatja@google.com, Will Deacon <will@kernel.org>,
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
From: Sven Peter via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sven Peter <sven@svenpeter.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On Wed, Aug 18, 2021, at 17:13, Robin Murphy wrote:
> Sven - I've prepared the follow-up patches already[1], so consider 
> yourself off the hook (I see no point in trying to fix the nominal DART 
> cookie bugs between now and then) :)
> 

Great, thanks for taking care of that! :)
Just tested your branch and everything works. Feel free to add 
Acked-by: Sven Peter <sven@svenpeter.dev>
Tested-by: Sven Peter <sven@svenpeter.dev>


Best,


Sven
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
