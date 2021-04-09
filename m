Return-Path: <SRS0=LjD4=JG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E01CC43460
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 16:56:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC379610E5
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 16:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC379610E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9DBE483EFA;
	Fri,  9 Apr 2021 16:56:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OlAQ3WDbMpjg; Fri,  9 Apr 2021 16:56:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id A744783EF7;
	Fri,  9 Apr 2021 16:56:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85F20C000B;
	Fri,  9 Apr 2021 16:56:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EDFF9C000A
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 16:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CF5AC607A5
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 16:56:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="z9rxDFp0";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="b03f6ugp"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IVv8v1PeJVlI for <iommu@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 16:56:07 +0000 (UTC)
X-Greylist: delayed 00:05:51 by SQLgrey-1.8.0
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com
 [64.147.123.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 36C8B606DC
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 16:56:07 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.west.internal (Postfix) with ESMTP id EE6861924;
 Fri,  9 Apr 2021 12:50:12 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute3.internal (MEProxy); Fri, 09 Apr 2021 12:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm1; bh=I2ARre6sMlwVG8AO4ffutjQbbw3E
 mBEk5qjuhnkfh+Y=; b=z9rxDFp0oTlsSWd17C3tudQcxD8hvNIOUz8nWLhxFP0M
 OMTpLs1hQMz2uTzIRTHr/RWHv9M+/NQkHf6rXz4HJtgey+8/p3OmjBhl1aWfpVcO
 9iu021iIK12A3OAfRjaMXmYEjeTgKABqG2fW1jcfdOjhK+nq4YOKvQbF52TqwO5y
 OKVtRcTFw3aN0R5XRgLLmfSMrQP7lI3WgHKhr1J1F6X6FN3WnKz0G1R1YKkwRs40
 nrmkTtiuoKGxeBJ5Bh3ZP465qKVxvZxXp2u7hjedrR0FelvQG4UuOmXQxJ7QTTEd
 w/1KVsRxyhAtVJY/SuPG/qB8TOlzfiC1G16eddOlGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=I2ARre
 6sMlwVG8AO4ffutjQbbw3EmBEk5qjuhnkfh+Y=; b=b03f6ugp0gXJB7Ly6G51bd
 nR4nU03wq16kbLtA813Gale5AK2wz2lBIoS6p1mAFdfo7XqP6HWV8uOoyAyofgZ8
 eimFG25ADcw/HPqmpOkEhEFJuEEjO0MZ/cz0pitG/H3XoPMBxnrTc692r+CKQf7F
 DUnT+3JAlK/zT/F+QCmTEzDmS3pZ7C+s+xwuGZ0MFJ/nnLYwWN9OQZlRALskCrFC
 9IApcfxs+rwx7B/bSWu9UWGo24Os5pCpDivTlriqmNoA1sHXgPiYrfV6oCmWCAij
 qR18BzHDfXukOn3cIxFjNlUioBg1pOg1+ZOVN3IiON2LC7i2tsVWC77y0cBvGQMQ
 ==
X-ME-Sender: <xms:w4VwYHRlHHzwpvgwR7qsWHx6fWDGDTnkzHdMo8qOojRdJ1jvGdF8Xw>
 <xme:w4VwYIyGI8KdxgmjV2LCJabC53Z7V-_AWkwi58c4TD9Rz6XlmyvarZkszwQQzeHel
 LWV-XFBbpuosKkxj9E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekuddguddtkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
 vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
 grthhtvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudeh
 vdefkeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:w4VwYM1pcvx-UopNLhkBfzlGFZkwayv_YgFw7M9V9lqf1UEK406VxQ>
 <xmx:w4VwYHCmpNvJQKHMwyMLF_WiY9oo5R9Uw0W8vqTlkG7XCVudaPirbw>
 <xmx:w4VwYAhCJz4LwujvxcB-3-czvKN6xhHlAjWw4mlYkkrwEusrcHeGzA>
 <xmx:xIVwYKZM1rMFUGW9YZeMy6b34y1R1sHrmzLp_e9wUpm4eMkKYHLIgqOME2M>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 30C2751C005F; Fri,  9 Apr 2021 12:50:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-273-g8500d2492d-fm-20210323.002-g8500d249
Mime-Version: 1.0
Message-Id: <cc2a3f1f-da43-4767-b00b-6e88ecd3a05c@www.fastmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2104041724340.2958@hadrien>
References: <alpine.DEB.2.22.394.2104041724340.2958@hadrien>
Date: Fri, 09 Apr 2021 18:49:50 +0200
To: "Julia Lawall" <julia.lawall@inria.fr>
Subject: Re: [PATCH] iommu: dart: fix call_kern.cocci warnings
Cc: kbuild-all@lists.01.org, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org,
 Petr Mladek via iommu <iommu@lists.linux-foundation.org>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Sun, Apr 4, 2021, at 17:26, Julia Lawall wrote:
> From: kernel test robot <lkp@intel.com>
> 
> Function apple_dart_attach_stream called on line 519 inside
> lock on line 509 but uses GFP_KERNEL

Thanks! Fixed for v3.


Best,


Sven
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
