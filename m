Return-Path: <SRS0=mUms=NC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A62C4338F
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 10:58:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 166FF60F38
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 10:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 166FF60F38
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD1EB823E8;
	Wed, 11 Aug 2021 10:58:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ls87h9MPnyeO; Wed, 11 Aug 2021 10:58:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C43A881DCA;
	Wed, 11 Aug 2021 10:58:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A581FC001A;
	Wed, 11 Aug 2021 10:58:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2DEBC000E
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 10:58:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B59D981DCA
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 10:58:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id np3NLF8zUR9c for <iommu@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 10:58:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 35FD581D3D
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 10:58:35 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 452813200924;
 Wed, 11 Aug 2021 06:58:33 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute1.internal (MEProxy); Wed, 11 Aug 2021 06:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm2; bh=QukJRM727lS1gcuLKaQE+uIs0YGF
 NOFtD4CuEIR6MPc=; b=FNl7oUb5D9vB2uK/GMLSX1rHvVIjzLSnoEph6wFYu7DO
 mPzyzb+Si/Lx/uTQaJxWDbGGFfJdnCUBEUIt9GTeXK5KHZi6CUvcn2u7Unjl8Mek
 80Eocr9ZlWWmpuuakYZDbcVpMkJtA5DFr4p3/pMQ0utJThRtDtl4gnh6YXYZZx7x
 Cw3AsyAj1M/yXmjwNTFWQNFFC4F0GZTAANKYYVD2GypitECpjbfd6ZdifO4OeXJH
 q+dZBEd3SSm0DtqiPNhCs1Bpb1fLPtHdH4pBk4oX50WD0tknuoKrd1iG7gjPqp46
 /MMYlP9SpLS11tnk3G8fHGMzQtE4AO2MCKu2Q5kdqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=QukJRM
 727lS1gcuLKaQE+uIs0YGFNOFtD4CuEIR6MPc=; b=RIOSccIeM5FEJgfw+v4sju
 ZivFE5AJkDojefZ/2o1JnvQwVvrY6ClDO7sFVhb8D2cGDtI8qYpb0zmdlt0Osdw4
 gavkSudCOi3AMyb1L9HBdXmgM4gXyS87C45yhUjPj3yJ+RgtkznvTRa/aSXo1oeF
 ZxqWUnxH8ksuKuEEqDZv8MzKmWF8ehxekzBCutoYedPGvEGD7Dus0wBXSULtZGQg
 DdCr9LJX2PiwPEbzXOkE9Pnb0psG2seZdsxWzyYW6qk9yy+k6vaJykwEyWjDsxAe
 Y0R7U58qYizLxW/4zfQspEDXG7iE5rUK6QtJkwpmuDd8X2w/Qr7yNQSQf8Wo8hBg
 ==
X-ME-Sender: <xms:V60TYXS5cIxUkw7NnUTXdaqwv0IO1sr8YQ87vbsnmxjJv5OmKHkdwQ>
 <xme:V60TYYxKg-kn_h4wB77yQzJn8LF6XsIobRvYFY7o7Nr6NakuaR8gCtlU1sgth7pao
 ZwRswsMsJOFtGXC4jI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkedugdeffecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhvvghn
 ucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrth
 htvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudehvdef
 keffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
 hvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:V60TYc3dUHrSsWRdqteQyKmRaqhGUg2N94cWYdgXFHfno-lS7yWr9w>
 <xmx:V60TYXAKlD-7k-yYd8Pab2xlnT8Ira7sl2lT5IIRHE-M_vJSwjHxBg>
 <xmx:V60TYQjW7A5CGo0XrIP6TdG99bWYGuYJdVIIRRYArSp8qx76mm90jg>
 <xmx:WK0TYYdzi1IUMOIDZnzq1vCG0Krr9Y3dT2ns2_8rNsn9wYhMuvLTqg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 0B01051C0060; Wed, 11 Aug 2021 06:58:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-554-g53a5f93b7d-fm-20210809.002-g53a5f93b
Mime-Version: 1.0
Message-Id: <ae4e4b9f-add0-4ab2-9c82-04124b1862b7@www.fastmail.com>
In-Reply-To: <44fcf525273b32c9afcd7e99acbd346d47f0e047.1628603162.git.geert+renesas@glider.be>
References: <44fcf525273b32c9afcd7e99acbd346d47f0e047.1628603162.git.geert+renesas@glider.be>
Date: Wed, 11 Aug 2021 12:58:10 +0200
To: "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Joerg Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>,
 "Hector Martin" <marcan@marcan.st>
Subject: Re: [PATCH] iommu: APPLE_DART should depend on ARCH_APPLE
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
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

Good catch, thanks!

Acked-by: Sven Peter <sven@svenpeter.dev>

Sven

On Tue, Aug 10, 2021, at 15:47, Geert Uytterhoeven wrote:
> The Apple DART (Device Address Resolution Table) IOMMU is only present
> on Apple ARM SoCs like the M1.  Hence add a dependency on ARCH_APPLE, to
> prevent asking the user about this driver when configuring a kernel
> without support for the Apple Silicon SoC family.
> 
> Fixes: 05ce9d20d699b093 ("iommu/dart: Add DART iommu driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/iommu/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index dfe81da483e9e073..e908b8222e4ed679 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -292,7 +292,7 @@ config SPAPR_TCE_IOMMU
>  
>  config APPLE_DART
>  	tristate "Apple DART IOMMU Support"
> -	depends on ARM64 || (COMPILE_TEST && !GENERIC_ATOMIC64)
> +	depends on ARCH_APPLE || (COMPILE_TEST && !GENERIC_ATOMIC64)
>  	select IOMMU_API
>  	select IOMMU_IO_PGTABLE_LPAE
>  	default ARCH_APPLE
> -- 
> 2.25.1
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
