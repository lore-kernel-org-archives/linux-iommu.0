Return-Path: <SRS0=tZpB=NH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E066C43214
	for <iommu@archiver.kernel.org>; Mon, 16 Aug 2021 06:49:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E93DC61A60
	for <iommu@archiver.kernel.org>; Mon, 16 Aug 2021 06:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E93DC61A60
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB9E440315;
	Mon, 16 Aug 2021 06:48:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0F2qj3pz99aW; Mon, 16 Aug 2021 06:48:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A4CD6402FA;
	Mon, 16 Aug 2021 06:48:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BDEAC001A;
	Mon, 16 Aug 2021 06:48:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1374C000E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 06:48:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A9D5D605A8
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 06:48:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="jB34i28S";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="P29pbTjF"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rw8aIhNJw2z9 for <iommu@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 06:48:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1F8D2605A9
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 06:48:48 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 2E8D55C00BE;
 Mon, 16 Aug 2021 02:48:46 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute1.internal (MEProxy); Mon, 16 Aug 2021 02:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm2; bh=KHpAoOoRonSlHnuSyki1WpC8Phkg
 qaifn+pSylc6qW8=; b=jB34i28SAcdeYLVW8GyocVkgAMoqHSneylqDUAFDwEGm
 cT02xr+M+5yHxFje4/LcLmOQSTiWRSuy20ATzMolDYS+76XVzyY3kyHDaHSUE+jC
 I2ObuKYmSPOKSVhT4fqYR68Z6p6+DPfCW2mlu2ZHpQeyt1ZWIsqIu4jjQEKtO/zD
 v95JGTjhfy3t9yE33N4towpXjXCGpvsrVU33tCFlhY2gUh3SbWrYGIAsTMpsOfjC
 GMC093CGo31q8uNV1hwYI0hafaD6HVnHYdBqfZJfvi8+f7GwAx49qFpLITwLsZm7
 mvPYhqBTr3MnCPxushPsti501VP5YObt1BZ7yAcNYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=KHpAoO
 oRonSlHnuSyki1WpC8Phkgqaifn+pSylc6qW8=; b=P29pbTjFG/+cIUXj8MRacB
 yhNAuNiFWZmAWIjGfWmChOjNtMaSyHPkVe4S+LuIpejygWQ8qU7r88kk9vLy+2wb
 XXCSSUT5U2NV6qoHnUxbYHdsY9CULjn54jEjSNOCiO5fvcBoByeob4hc9wodXUoK
 uitKmKbpbzWuMMxV7sr5dokOKfYomhzvCdzTHq+0q/550NhSeE5910t5SJtCjPel
 lbDKHb7hDJttnv1+VYoGDR767jvouGHPz443I4DWKFdVnVOFhjCOS8j6wE9QxtsL
 8W5NrDLGJg3roB5je+8UvcqLabiNFoK7mWyUgshszL7v785q3fZgB5WpTEJYe7yw
 ==
X-ME-Sender: <xms:TAoaYRXVOMQa9dPNHrzIDZQnpNyWNiwWw-Omw4vrGFlw00xXjkJYhg>
 <xme:TAoaYRm09YhVqF92rjEBC5qTlVOEPjtXF84j2f38Gtg-7Ga5a7BNLLCa_4f7hGVyc
 MHk966b1_lJ9wdkbLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrledtgdduuddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpeeuvdejgeehuefggeeiheegteelgfefvedtteejgeffffevudehfedtueeu
 leelvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdgu
 vghv
X-ME-Proxy: <xmx:TAoaYdZ82LxQsvXjoYvUdfMXGzUBQ3gM2X6XdtWXCmTshk3PIFxXpQ>
 <xmx:TAoaYUXXgNYXXWh3Os1als-ajEJn7Hi7GKtEcBDDrxB8xtS16NjZHw>
 <xmx:TAoaYblqI5xeHCIJOypRx0HiB1EwbrxoA_VD1AdcCKjse5aarainug>
 <xmx:TgoaYQy2YTDp-RJGnUhPoThnyfjPPTg_pz4DWc-73t4UtScTdIQy-A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 4FBC151C0060; Mon, 16 Aug 2021 02:48:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1118-g75eff666e5-fm-20210816.002-g75eff666
Mime-Version: 1.0
Message-Id: <3c71050b-950f-4dbc-902b-c7e64dd3d0bc@www.fastmail.com>
In-Reply-To: <YRUF/JNi5tclQo6L@suse.de>
References: <202108100801.aYU4IXvh-lkp@intel.com>
 <0589c725-401b-482f-ba2b-0707c02ea40a@www.fastmail.com>
 <YRUF/JNi5tclQo6L@suse.de>
Date: Mon, 16 Aug 2021 08:48:24 +0200
To: "Joerg Roedel" <jroedel@suse.de>, "Robin Murphy" <robin.murphy@arm.com>
Subject: =?UTF-8?Q?Re:_[iommu:apple/dart_3/3]_drivers/iommu/apple-dart.c:730:17:_?=
 =?UTF-8?Q?error:_initialization_of_'size=5Ft_(*)(struct_iommu=5Fdomain_?=
 =?UTF-8?Q?*,_long_unsigned_int,_size=5Ft,__struct_iommu=5Fiotlb=5Fgathe?=
 =?UTF-8?Q?r_*)'_{aka_'long_unsigned_int_(*)(struct_iommu=5Fdomain_*,_lo?=
 =?UTF-8?Q?ng_unsigned_int,__long_unsigned_int,__struct_iom...?=
Cc: iommu@lists.linux-foundation.org, kbuild-all@lists.01.org,
 kernel test robot <lkp@intel.com>
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



On Thu, Aug 12, 2021, at 13:29, Joerg Roedel wrote:
> Hi Sven,
> 
> On Tue, Aug 10, 2021 at 08:09:53AM +0200, Sven Peter wrote:
> > This happens because apple/dart is missing the "Optimizing iommu_[map/unmap] performance"
> > series which is already in the core branch [1].
> > The same commit works fine in iommu/next since that branch merges both iommu/core and
> > apple/dart.
> 
> Okay, thanks. I re-based the DART patches on-top of my core branch,
> which contains the changes for iommu_[map/unmap] performance. I
> generally don't like rebasing topic branches, but made an exception here
> to not break bisectability.
> 
> Thanks,
> 
> 	Joerg
> 

Hi Joerg,

Thanks, and sorry about that! I'll try to make it more clear if anything depends
on another series in the future or just try to avoid it altogether if possible.


Just a heads up about a similar situation you may already be aware of: Once Robin's
DMA domain strictness refactoring [1] is merged, the current DART driver will fail due
to patch 12 there, which unexports iommu_get_dma_cookie. It'll need a small
adjustment just like all the other drivers (which will also fix two small bugs
it just made me notice: I never use iommu_put_dma_cookie and also unconditionally
grab a DMA cookie for all domain types).

Unless I'm mistaken I can't make that adjustment before the first patch of
that series has been merged, and Robin can't make that adjustment in his series
because it'll presumably go through another topic branch.


Best,


Sven

[1] https://lore.kernel.org/linux-iommu/cover.1628682048.git.robin.murphy@arm.com/


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
