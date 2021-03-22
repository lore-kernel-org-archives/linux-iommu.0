Return-Path: <SRS0=3kXM=IU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41580C433C1
	for <iommu@archiver.kernel.org>; Mon, 22 Mar 2021 18:17:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B19B961983
	for <iommu@archiver.kernel.org>; Mon, 22 Mar 2021 18:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19B961983
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22ABD6079C;
	Mon, 22 Mar 2021 18:17:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fv-MMSbkVLMz; Mon, 22 Mar 2021 18:17:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 14D7C60796;
	Mon, 22 Mar 2021 18:17:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5149C000A;
	Mon, 22 Mar 2021 18:17:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 850CFC0001
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 18:17:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 65FF76079D
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 18:17:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VgZfApstJT9Z for <iommu@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 18:17:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A36D96079C
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 18:17:12 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id B21EC580832;
 Mon, 22 Mar 2021 14:17:09 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute3.internal (MEProxy); Mon, 22 Mar 2021 14:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm1; bh=ai83ObAamB4LrMOc3G4nVgW5/sy+
 gIqBJIYzf+pgCMY=; b=DuFuR/KwjaKcHaXXBMn2JqyE1eTkT0Sa5EnZ7VumbIz9
 v0dWSGDrGOjsDGDU3kqYGB96ystm8c3PUOsr5A/aUSYEO5zaYd0pebE9GIo8WkDd
 IkOxpgnpq8/Fg0E+/D4w0Kkg0fM7dWqyLAhh+m+Cexmiq2hvM32qcHMxIAAJ+L1G
 setMVvh5n2Kjr33DuXwf4JEb+a/WpjR/nplHw9A8SkVkbCdfnKmTSbj7SdHQbEsc
 ZF1ggZw8YELFIqL7b0pGudPOsZSIcsbdNRAfUSYSBxxRHjnz9PH7V3FUYaDqRQei
 g8YVafRhbn9IkWKuhwZWjsgf1RmSycTMZo7kIvSWNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ai83Ob
 AamB4LrMOc3G4nVgW5/sy+gIqBJIYzf+pgCMY=; b=eZrFgoCxaH62cG8QlWk8eg
 pKZ40WJFfQSMIOV9zoFyuBS7LM27UXZE26C4y/bsgxya2LZeilAxB5UFDRuKWTYC
 sVZMd91BRzjpUHK1mFsqTNdz8tlYGQEwaCPry6sbCKD4VdoqEjQRhWfOsRCN0nzY
 Wyuh90UZIIV9UJ7g2x3xvfWLFCNqLWITbFZ26uNiEmNUZImRSZs/N8239+gfJlgq
 +VxRA0J0+VDu/hpd8b4O4jYL0jLa5/VGh39f5m1wP/OfXoyQ1bhFO+eIltwXIe0c
 O9COzT2p0qkKqX6jSkegg9kxzt8awNDSRFxiWIiLzGlEI5ZO+ec5q/n8s8Sj8HXg
 ==
X-ME-Sender: <xms:I99YYI9tjTasK_ZhXTuE4FaqxkRXRpnr6GVrP23ei15cHQLcaD0HRg>
 <xme:I99YYAs8cJS7jG3WP7ET5nBCQASRjlVsZVl2oONNFowMZXL4ybHOv4lO8qzVxwcMK
 5Auino15NbeGA4mQlM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeggedguddutdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
 vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
 grthhtvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudeh
 vdefkeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:I99YYODKP-UhuA3X3vZ4UMwQD-ACxt4NsPP9FePDaH0ezkSa3yWp8A>
 <xmx:I99YYIcN0ndJcxpPmCq1q-Cll4e7a37dAoo8rlVlGwquxYrAz0AlfQ>
 <xmx:I99YYNPQToM0YWuNtD7nFQfx-0GqXRe7-QSNZ5j6k0dEJBYgllmM4Q>
 <xmx:Jd9YYBnmKRQeOt2B0vl8-yha0HHOuF-cMHUXIKYiDXDNRWl8xmIrJtoPEEE>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id CFA9E51C005E; Mon, 22 Mar 2021 14:17:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-271-g88286cf463-fm-20210318.001-g88286cf4
Mime-Version: 1.0
Message-Id: <957e0f84-efcf-43f1-90b7-ef85a854d463@www.fastmail.com>
In-Reply-To: <1616372137.246877.1475028.nullmailer@robh.at.kernel.org>
References: <20210320151903.60759-1-sven@svenpeter.dev>
 <20210320151903.60759-3-sven@svenpeter.dev>
 <1616372137.246877.1475028.nullmailer@robh.at.kernel.org>
Date: Mon, 22 Mar 2021 19:16:25 +0100
To: "Rob Herring" <robh@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: iommu: add DART iommu bindings
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 Arnd Bergmann <arnd@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
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

Hi Rob,

On Mon, Mar 22, 2021, at 01:15, Rob Herring wrote:
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.

Sorry about that! It looks like I didn't have yamllint installed.
I have fixed the issues and will re-submit.


Thanks,

Sven

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
