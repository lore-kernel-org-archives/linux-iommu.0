Return-Path: <SRS0=8IIh=I2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11E7C433C1
	for <iommu@archiver.kernel.org>; Sun, 28 Mar 2021 09:23:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23D0E61976
	for <iommu@archiver.kernel.org>; Sun, 28 Mar 2021 09:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D0E61976
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D36B2401FB;
	Sun, 28 Mar 2021 09:23:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XUxIpCCB87w0; Sun, 28 Mar 2021 09:23:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id A357A400BF;
	Sun, 28 Mar 2021 09:23:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89F1BC000C;
	Sun, 28 Mar 2021 09:23:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE924C000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 09:23:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8954A83AD4
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 09:23:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="sUwmqaYL";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="Pq/t+IBb"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WJznSkT7M7OY for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 09:23:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D11AB83ABA
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 09:23:13 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id DF7A4580424;
 Sun, 28 Mar 2021 05:23:10 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute3.internal (MEProxy); Sun, 28 Mar 2021 05:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm1; bh=gbhn5OemD9Ow5QkhhT+PDUUX6xR+
 vJAarCksiI5FZS0=; b=sUwmqaYL/f34wjHBN6wy+4qaJh+WRKLGS+7m8ml5kW0Q
 XfnHMvBlKbbaX+Zmo6GTfjIY5uKjNMNkkUyGJF0m/ezrRFFvdqbFGPAYuajNt5Iz
 zkEb4Ije35L5fe3xA0LdoIA2pHi7UrrnKfYkqxbyE2D9k9uA6XluVpbSh+rcZG6Z
 77inPTBhM7kbPt3eh6pLUWT8swq4E1xn1QkYFpasU/yeJGX5GpXQnvKxmuhm2Nmy
 iGrsR59DkxUb/GU/lN7J0IWN+DMoRVR1+VQkAKO93DLFHcqbWtuccW2O/Aq7Nnut
 w3IbUgr8JOvhDxbq51TeA//SSPfh71nd0KsgxKQC7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=gbhn5O
 emD9Ow5QkhhT+PDUUX6xR+vJAarCksiI5FZS0=; b=Pq/t+IBbYYVbgx1nnnWjiJ
 pKURemFg4wonUQq6ZMZ8+YUZd4HWQhIb/WI/QmE03jQg3tpbRoos/+A8cKixEjNF
 1qnwZlQwJlaJb9ZAmlvs8HgFDXLBSry30O+GU8Rd3Jaw4YNea8EGqp5ckmZvI30V
 5ATYhtXiimtdzkL1QsrGMEEpDl8VyzDtLogFIi5mx3S7u9+uFCvdgOXeKGtJK6Pc
 wZ0SAU7uXlDiVxadSkGAl+0sNOBLsvlk/psEiKz/DU5eZ5s+4Mbb9gFWa8GNYe8a
 xT5FB+Ct/K4WpVvznhmV+ZCjPfByz15XeE4B9lsuujsSKvHBI4wHuNHumbRyQOnw
 ==
X-ME-Sender: <xms:_EpgYII3V3e3Q6ewvEk4pk36bGBZwLtWnt1OekHEe5vhtNWex6r8jw>
 <xme:_EpgYIKKz1u-ZvrOD4PbPcDFEhQn4hobZ3Sr2uGQJbQ3LEUUGfdN0dAWUkHvgd3p8
 ZAm02AvluoAu7PFi4s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehiedgudeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
 feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:_EpgYIsdB_Hwc_1z8Kc8FENyihSJfI09dMr8hXbwko87utZsyJ4wGw>
 <xmx:_EpgYFbimQ_YfF6h2SvvKkFxIpY-rSVwAkLUyC29vz1DtnJiQeVJPw>
 <xmx:_EpgYPZmal02IKKyLmyqNr-CGN8asUAoSgMiQksx3p4qtsGsGNPXWQ>
 <xmx:_kpgYNBtn-rzzfoku3w1B3x5wS_7Vp2ztQSlLZJvmjJntarn5gjfNRhCKaM>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 5CB0B51C005F; Sun, 28 Mar 2021 05:23:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-273-g8500d2492d-fm-20210323.002-g8500d249
Mime-Version: 1.0
Message-Id: <e05aa388-e1dd-4b94-b427-69cf0d14b7f6@www.fastmail.com>
In-Reply-To: <CAK8P3a3a1k9SyrRLammX8dGF3GjojUVUEZ4cMfb2+g6CXkBNCA@mail.gmail.com>
References: <20210328074009.95932-1-sven@svenpeter.dev>
 <20210328074009.95932-3-sven@svenpeter.dev>
 <CAK8P3a3a1k9SyrRLammX8dGF3GjojUVUEZ4cMfb2+g6CXkBNCA@mail.gmail.com>
Date: Sun, 28 Mar 2021 11:22:47 +0200
To: "Arnd Bergmann" <arnd@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: iommu: add DART iommu bindings
Cc: DTML <devicetree@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Hector Martin <marcan@marcan.st>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Stan Skowronek <stan@corellium.com>
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



On Sun, Mar 28, 2021, at 10:16, Arnd Bergmann wrote:
> On Sun, Mar 28, 2021 at 9:40 AM Sven Peter <sven@svenpeter.dev> wrote:
> 
> I noticed only one detail here:
> 
> > +  - |+
> > +    dart2a: dart2a@82f00000 {
> > +      compatible = "apple,t8103-dart";
> > +      reg = <0x82f00000 0x4000>;
> > +      interrupts = <1 781 4>;
> > +      #iommu-cells = <1>;
> > +    };
> 
> The name of the iommu should be iommu@82f00000, not dart2a@82f00000.
> 
>        Arnd
>

Thanks, fixed for v3. I've also just noticed that I forgot to update
the filename in MAINTAINERS after I renamed it from apple,t8103-dart.yaml
which I've fixed as well.


Sven

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
