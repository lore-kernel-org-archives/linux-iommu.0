Return-Path: <SRS0=Y/a2=IZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C1EC433C1
	for <iommu@archiver.kernel.org>; Sat, 27 Mar 2021 15:34:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 931666192B
	for <iommu@archiver.kernel.org>; Sat, 27 Mar 2021 15:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931666192B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5C4B34019B;
	Sat, 27 Mar 2021 15:34:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BdCfpuUrHe7o; Sat, 27 Mar 2021 15:34:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id DC2FE40139;
	Sat, 27 Mar 2021 15:34:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B549CC000B;
	Sat, 27 Mar 2021 15:34:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF2F1C000A
 for <iommu@lists.linux-foundation.org>; Sat, 27 Mar 2021 15:34:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AC27A605FF
 for <iommu@lists.linux-foundation.org>; Sat, 27 Mar 2021 15:34:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="cejNuovT";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="KSStNAPR"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gg6EdmXN8Ijh for <iommu@lists.linux-foundation.org>;
 Sat, 27 Mar 2021 15:34:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C0B83605BC
 for <iommu@lists.linux-foundation.org>; Sat, 27 Mar 2021 15:34:14 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 67F1258055A;
 Sat, 27 Mar 2021 11:34:12 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute3.internal (MEProxy); Sat, 27 Mar 2021 11:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm1; bh=C7jUmzBlfmU9VFdYvmkyNor1Zqsj
 5fCr/9TW5SN6eG4=; b=cejNuovTAzdGTboZGSEobUwyj2OEBYn4LYOBN+UDnLmH
 f55CfBtYftdhKeCuZ+MGt8o7smZ0EaSsAfy9iVYge7EJ2AbYWRo1xUnr41Bsj5WC
 JfWy44cCOpuaKx9B37gWO3zrJa8jVeRXYWbzNs8k3Yqk+49lM5BhCWgHc6rnpnO7
 3wttehSaRphhIJ091wvtCkbu7dF8xxNryyGWIQzkq8y5wRdeQqep4R6dVRt33gCQ
 w3HIl+vARuRnFz9mUMMKR66Kfo1No4Szo0sW2mPFQa0kAmh74tIPEi3kNSHbEUX8
 MkGRf++HdPhPu6V7OjWwMP6vxHsLoyVuVe6ZUNfvdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=C7jUmz
 BlfmU9VFdYvmkyNor1Zqsj5fCr/9TW5SN6eG4=; b=KSStNAPRTX4FY94hwirZH5
 NtxQPIDTc2Tgq/dWZS3eABO/xJiFidm9zflpeUlb6i3Q6DAwnXeIYyVRqx1AcKLS
 1qz7rYzsaNhX+T//2nR9xIwnQM9K0NNPkBSEQIS+phXRVysFUK3lhqaps3z3lHrE
 F+9rTCBH0TKNRbHB5Y6roDui4sL0VdPnYuaQBSIYPO83epf8r2kGsg9eOp7b8JZa
 F0+XDu/dxfdZQvTO7HCp/wTbXjZEnAZhte+dAi6doLS88uyE8twBdGVHcyZBHGPg
 dpQ/9Y21a3E7TS2fZ4SJqnuOW5Z0qzShqpqbIu+WsrMMqxluMExX9TqFQwdfhPHQ
 ==
X-ME-Sender: <xms:clBfYOFPFuws3Bogj8L6vut9IW4jx38qBwnkGazFCO1hfksMFHfvtw>
 <xme:clBfYPVEppoHRsrWMflX_-brzskMBca5R-sXBE2kVM8R6P9Fz9EFP366wzJsdWzj8
 apJiIt9R_HhOVossw4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehgedgjeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
 feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:clBfYILS-zl8gTS50EZ6Xnlf0E7o21PnqahQbGpOM0GfyYJ9tL70GA>
 <xmx:clBfYIHZFADctNDkDLF7q5lbiLRj-gRWHR9icvvmgbK1GtMPbOoTxQ>
 <xmx:clBfYEVGemGhCYso8sTXthkYfvkPDIe96iyd9aMHfUdaQo0fGTSzzw>
 <xmx:c1BfYDNrk4QCK_Cx8E802W2WRJYlwHEiW_qIyGoCM2tjsK1kUrDCZIeZ8f4>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 6169E51C005E; Sat, 27 Mar 2021 11:34:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-273-g8500d2492d-fm-20210323.002-g8500d249
Mime-Version: 1.0
Message-Id: <26c9b3cc-a04f-444d-ada4-0c9bc99684e5@www.fastmail.com>
In-Reply-To: <33b3ce35-c42f-331a-79a2-e38917d588ef@arm.com>
References: <20210320151903.60759-1-sven@svenpeter.dev>
 <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl>
 <20210323205346.GA1283560@robh.at.kernel.org>
 <43685c67-6d9c-4e72-b320-0462c2273bf0@www.fastmail.com>
 <33b3ce35-c42f-331a-79a2-e38917d588ef@arm.com>
Date: Sat, 27 Mar 2021 16:33:29 +0100
To: "Robin Murphy" <robin.murphy@arm.com>, "Rob Herring" <robh@kernel.org>,
 "Mark Kettenis" <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
Cc: Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 mohamed.mediouni@caramail.com, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, stan@corellium.com
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

Hi Robin,


On Thu, Mar 25, 2021, at 12:50, Robin Murphy wrote:
> On 2021-03-25 07:53, Sven Peter wrote:
> > The iommu binding documentation [1] mentions that
> > 
> >      The device tree node of the IOMMU device's parent bus must contain a valid
> >      "dma-ranges" property that describes how the physical address space of the
> >      IOMMU maps to memory. An empty "dma-ranges" property means that there is a
> >      1:1 mapping from IOMMU to memory.
> > 
> > which, if I understand this correctly, means that the 'dma-ranges' for the
> > parent bus of the iommu should be empty since the DART hardware can see the
> > full physical address space with a 1:1 mapping.
> > 
> > 
> > The documentation also mentions that
> > 
> >       When an "iommus" property is specified in a device tree node, the IOMMU
> >       will be used for address translation. If a "dma-ranges" property exists
> >       in the device's parent node it will be ignored.
> > 
> > which means that specifying a 'dma-ranges' in the parent bus of any devices
> > that use the iommu will just be ignored.
> 
> I think that's just wrong and wants updating (or at least clarifying). 
> The high-level view now is that we use "dma-ranges" to describe 
> limitations imposed by a bridge or interconnect segment, and that can 
> certainly happen upstream of an IOMMU. As it happens, I've just recently 
> sent a patch for precisely that case[1].
> 
> I guess what it might have been trying to say is that "dma-ranges" 
> *does* become irrelevant in terms of constraining what physical memory 
> is usable for DMA, but that shouldn't imply that its meaning doesn't 
> just shift to a different purpose.

Should I add a patch to clarify this paragraph for v2 or submit a separate
one-off patch? I'm not entirely sure about the process here but I could add
a Suggested-by: to the commit if that's fine with you.



Best,

Sven
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
