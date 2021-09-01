Return-Path: <SRS0=1qmC=NX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06D1C432BE
	for <iommu@archiver.kernel.org>; Wed,  1 Sep 2021 17:14:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 580EA60F4B
	for <iommu@archiver.kernel.org>; Wed,  1 Sep 2021 17:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 580EA60F4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22DFE80E32;
	Wed,  1 Sep 2021 17:14:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TJV0ip6A3XPi; Wed,  1 Sep 2021 17:14:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5CA4B80E21;
	Wed,  1 Sep 2021 17:14:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41542C001A;
	Wed,  1 Sep 2021 17:14:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1FF9C000E
 for <iommu@lists.linux-foundation.org>; Wed,  1 Sep 2021 17:14:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 94952600CA
 for <iommu@lists.linux-foundation.org>; Wed,  1 Sep 2021 17:14:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="UdwBpIi5";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="qy6Y0tkB"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OOVd_QhtYf7b for <iommu@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 17:14:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2F39461431
 for <iommu@lists.linux-foundation.org>; Wed,  1 Sep 2021 17:14:49 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 1BB1B5C0076;
 Wed,  1 Sep 2021 13:14:48 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute1.internal (MEProxy); Wed, 01 Sep 2021 13:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm2; bh=PjI/Na3u99SdyJiZLuyCXPem/Uar
 db9RSRjNBRnAjTs=; b=UdwBpIi5+aPrVMeubICwqzZ+llcAdAR05tucL01juVRT
 nGKaB+eE/Iy0StUKvrPNyTMRa5Ob/wahSGNbK3/Oa5r70yJ0jp6TBRhoKddJNpeh
 M3iy54fDqlgE7TitGBKfPp6fj5JKuU44ANcLFXh1oJN9ScYBovp9qTAD3eC2Cfme
 lp+dz+9mVa/b25VrDfNgxuhyE0zfhA+mbP7OwenJ2zLeNTqkDaOC1DvyzTRsM5A4
 rxi+OOZ8wncpD9ItTeXVJeL8iaqDaMu6/l2dp8sm0S6bgbHjf2gLsTmff3BA6kE9
 phgNq7Y44jC0ZvkF6QbkiklatyS3a2eL+YNIlqwZ2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=PjI/Na
 3u99SdyJiZLuyCXPem/Uardb9RSRjNBRnAjTs=; b=qy6Y0tkBC5GAe4YphlEuTp
 Gj2DToBLWWn022elJsSRXYOy7MkorEbyu7ghipPnL0kk+oMwTj/aKIutsJ2Tyhq/
 ncYlMQ6OUW/OGGQhA2VThCfr33apDPFGbSj3/eYFktwLGT+cA+2I/KfkNkwKc8+k
 /YyYFMSnArCzb7vq2hOUf9huZl63dlgVo9gk56kPdTs1nUNfr72uc3S81JPx+xJ7
 7hVbvT7GJWG964ruks4Ku/cQU3rpbseIgREaa7KPXa6BeYspCUXy6PukuQQZ51YB
 pb4XDuXp3dU1nQemEnFXmJpvXmSHtIaEeCR/g4GaM/xrelvxYoBe1HT4bczf/7Jw
 ==
X-ME-Sender: <xms:BbUvYQ1sNZhPhSWZ8wIVBe4sSyytxkhOf_z9JCSwcl03vMZPCBfnVA>
 <xme:BbUvYbHLxPe1UnR19Mh0Iz_PGkO5OCoFmF3Wr_QnrhXk-rmzgzuJDHaoaHfZbcf2n
 felhpgWMqlinKYmASY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvfedguddutdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
 vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
 grthhtvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudeh
 vdefkeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:BbUvYY4YWIp3Eb0cjlTcK1NGDzD1hrSg7GgJW2rxK-EuY4W2S8kHBw>
 <xmx:BbUvYZ10XRl0fzvhCwZqF4SUKtlI4YUGzihYB7hXH5q8SHvrCx4PaQ>
 <xmx:BbUvYTF5j6atbFgqgrjN_jnYqxpqZx84e1kINutI5izBjfKDKxOq5w>
 <xmx:CLUvYS2kLBGQjA-3vfiLoeN_eHZSpnyrNkz9Yvh7O3ivVbhnvwUvmg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 7845151C0061; Wed,  1 Sep 2021 13:14:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1126-g6962059b07-fm-20210901.001-g6962059b
Mime-Version: 1.0
Message-Id: <adee671d-976a-4906-8592-c7391da9906b@www.fastmail.com>
In-Reply-To: <YS6hl0gAOMoMxNhf@sunset>
References: <20210828153642.19396-1-sven@svenpeter.dev>
 <20210828153642.19396-7-sven@svenpeter.dev> <YS6hl0gAOMoMxNhf@sunset>
Date: Wed, 01 Sep 2021 19:14:24 +0200
To: "Alyssa Rosenzweig" <alyssa@rosenzweig.io>
Subject: Re: [PATCH v2 6/8] iommu: Move IOMMU pagesize check to attach_device
Cc: Arnd Bergmann <arnd@kernel.org>, Will Deacon <will@kernel.org>,
 Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Alexander Graf <graf@amazon.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Robin Murphy <robin.murphy@arm.com>
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



On Tue, Aug 31, 2021, at 23:39, Alyssa Rosenzweig wrote:
> > +	if ((1 << __ffs(domain->pgsize_bitmap)) > PAGE_SIZE) {
> 
> Not a fan of this construction. Could you assign `(1 <<
> __ffs(domain->pgsize_bitmap))` to an appropriately named temporary (e.g
> min_io_pgsize) so it's clearer what's going on?

Good point, will do that for the next version.

> 
> > +		pr_warn("IOMMU page size cannot represent CPU pages.\n");
> 
> "Represent" how?
> 

Looks like I dropped an "exactly" there when taking this line from iova.c :)



Thanks,


Sven
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
