Return-Path: <SRS0=Ewjr=LG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A16C48BE5
	for <iommu@archiver.kernel.org>; Sat, 12 Jun 2021 12:25:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AADC6138C
	for <iommu@archiver.kernel.org>; Sat, 12 Jun 2021 12:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AADC6138C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C39C83C50;
	Sat, 12 Jun 2021 12:25:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fCJux3iVcEzC; Sat, 12 Jun 2021 12:25:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C5F6083B5E;
	Sat, 12 Jun 2021 12:25:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 757CDC000E;
	Sat, 12 Jun 2021 12:25:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCB24C000B
 for <iommu@lists.linux-foundation.org>; Sat, 12 Jun 2021 12:25:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9C1E1405B0
 for <iommu@lists.linux-foundation.org>; Sat, 12 Jun 2021 12:25:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="t+pToX6y";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="Ny6N8vAl"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vDdVwFMGaV83 for <iommu@lists.linux-foundation.org>;
 Sat, 12 Jun 2021 12:25:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 444ED405AA
 for <iommu@lists.linux-foundation.org>; Sat, 12 Jun 2021 12:25:29 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id CAA4758069B;
 Sat, 12 Jun 2021 08:25:26 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute3.internal (MEProxy); Sat, 12 Jun 2021 08:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm1; bh=3PQQZVdLA4n4rlbpJkJAKwEqsxv+
 D18QX971oe6+lnc=; b=t+pToX6ylR7fe3vR3pb6OB46fkMMUWm198p/1XFQzlYa
 mU+LDEFNrDGHzC8HgfOJovx/IZMzSsW2LznbFn720KiIRwOjYDF7KXgb2R+MzM+K
 JW1mhC54J3eW5uNby5olGvI2/A2fheOx1iJlpgbdg5fQAUhk+ENbTs4CbEIQHLvN
 OLY02bhKIcOe202N++fBVeZpsjEhkb4mkW58w8yOOgHF1HPcUDZzladLEKexg4mt
 rmCkEVeJfJuz9J6DcIyfnUAkEXDDYJHEE5LrQ17fRED1ael9BQgr0WINMlQSb6Lc
 Ixc1ZSAjuSu2Rk9qhRJG2rPfcTqbMS0oJHmbM18Vcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=3PQQZV
 dLA4n4rlbpJkJAKwEqsxv+D18QX971oe6+lnc=; b=Ny6N8vAlMSgGbeQFUTyrkq
 MPdVvNnienI+/h/kmb77s16Qrp++a1FnaC0wYyj6/Qafk6DZoa4mi3t0M4WbGfWF
 1beaUtLPeEnXFWDIAuua5ZfLD059AZjIOR6FaEqUzTVzWh5P7X5d5DmqZt0ptlYz
 b2DQw+Jf3znqhM3qDbbI7HN8oRSSNhDbC0pZqM5DUF4v7hwotIE05ZYMXHxuiOuM
 +y7ygfyzaTFQDG5Ky4lPdvEVFiE/UD9PbzTbfv1k8Q+Uj53EE5VOf+PXFJvtAgbX
 b47qqrdl21EeTUsG5PqmbIngbpp2FgpQWNpoH/kpCsEb9yXCMv5sm9p+EHtmHXDw
 ==
X-ME-Sender: <xms:tafEYEi3MG55JXV0hCxywKW0vRZ2HafBDz0WAwPlEtKXbv7LCn6sZg>
 <xme:tafEYNDVvl0I-YbiffTXe2foqONeaB_y759N8dWQDHGbqZbAfHk1CUBremEn76tvd
 6MhHxmiC97RzkYqfEI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvtddgheefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
 feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:tafEYMFBetGL7__tAMLZoxJvuG0ePGGvD8Hmc2A4PHbejjjg0SHZ0Q>
 <xmx:tafEYFTR8EihGqAyXC_pmGZb-7p29sSHv6LI4TXHQOg7SJ28LA-Mlw>
 <xmx:tafEYBxdTnji6KhAu7SZpG9LrOBKeDdSnmHvRICispTjtChOREGZiA>
 <xmx:tqfEYEooqma0hYH0rmDgi-41Y2cOrX_RumCZgg7OVucifelUf89UoQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id BE28B51C0060; Sat, 12 Jun 2021 08:25:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-519-g27a961944e-fm-20210531.001-g27a96194
Mime-Version: 1.0
Message-Id: <9b226219-bf87-4fd4-8d99-9436861ca3cf@www.fastmail.com>
In-Reply-To: <20210610165244.GA1948260@robh.at.kernel.org>
References: <20210603085003.50465-1-sven@svenpeter.dev>
 <20210603085003.50465-3-sven@svenpeter.dev>
 <20210610165244.GA1948260@robh.at.kernel.org>
Date: Sat, 12 Jun 2021 14:24:55 +0200
To: "Rob Herring" <robh@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: iommu: add DART iommu bindings
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
 Will Deacon <will@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org,
 Petr Mladek via iommu <iommu@lists.linux-foundation.org>,
 Alexander Graf <graf@amazon.com>, Marc Zyngier <maz@kernel.org>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, Stan Skowronek <stan@corellium.com>
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

Hi,

On Thu, Jun 10, 2021, at 18:52, Rob Herring wrote:
> On Thu, Jun 03, 2021 at 10:50:02AM +0200, Sven Peter wrote:
> > +
> > +examples:
> > +  - |+
> > +    dart1: iommu@82f80000 {
> > +      compatible = "apple,t8103-dart";
> > +      reg = <0x82f80000 0x4000>;
> > +      interrupts = <1 781 4>;
> > +      #iommu-cells = <1>;
> > +    };
> > +
> > +    master1 {
> > +      iommus = <&{/dart1} 0>;
> 
> /dart1 is a path, but 'dart1' is a label. You need '&dart1' (or 
> '&{/iommu@82f80000}' but that doesn't really work here because the 
> examples get prefixed with /example-n/...)
> 
> With that fixed,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Makes sense, thanks for the review!
Fixed for the next version.


Sven
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
