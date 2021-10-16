Return-Path: <SRS0=DCF7=PE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213D8C433F5
	for <iommu@archiver.kernel.org>; Sat, 16 Oct 2021 14:28:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7EB761139
	for <iommu@archiver.kernel.org>; Sat, 16 Oct 2021 14:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B7EB761139
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 75B3340190;
	Sat, 16 Oct 2021 14:28:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 70Qu0j92_kJ2; Sat, 16 Oct 2021 14:28:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3251440017;
	Sat, 16 Oct 2021 14:28:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E757DC0011;
	Sat, 16 Oct 2021 14:28:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BDEDC000D
 for <iommu@lists.linux-foundation.org>; Sat, 16 Oct 2021 14:28:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6396C40163
 for <iommu@lists.linux-foundation.org>; Sat, 16 Oct 2021 14:28:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a9GbK9KCuQ3V for <iommu@lists.linux-foundation.org>;
 Sat, 16 Oct 2021 14:28:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 77CF340017
 for <iommu@lists.linux-foundation.org>; Sat, 16 Oct 2021 14:28:20 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id B515E5C0151;
 Sat, 16 Oct 2021 10:28:17 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
 by compute1.internal (MEProxy); Sat, 16 Oct 2021 10:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm2; bh=GRVN2QCx3h8Dn7GgNwjavdJhWEpR
 Qp2xWgOHeVQLVvo=; b=YvuFEt51buyLnuxSDUrv9YRlgyQVfGP4h+/v/1tFppYT
 MQf1RXPnyZeGX019XpTTlHxZz5+xKOQZ31iQlk4xJVATrfImPI0YVMXjRtZOPs2t
 aHTmXjypvIw9AKLW1+Bf7fAwWBxmcjwOVnPE1hr9x2n5CRLYVQmtRbZMp8ku9moC
 23uh/sakaRP5HPrng4k9L3qnGnhicX7KfeMXIYBwGQUIDdaqrQPaGt+73nB0Ju+V
 bJLoSp+l8/1kM86sM1q2nvKUfia/ddZ9AEGTYejGiZrfI2I5HpP2oR/tnUrl/ApL
 oNxAZaUDPMBgS5j9v4mCaJhRkR2yLnyy0fV2fyGzng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=GRVN2Q
 Cx3h8Dn7GgNwjavdJhWEpRQp2xWgOHeVQLVvo=; b=VbZSpCJdYtTZ00mqc5fXsa
 KQN88RDWOYKti20ui4VnDo7OM+0JBh9FPiCqaOP7/YL+NdSuNXoz8e0a+OS5T0eg
 FyyVP/+rlUzzuYhKK/AcEBwmVhGlgIfANsIA688mpLQ7SBKU60E+E2Rb3MB/PoCn
 GlO+yN+bVCW6uJCmi9W3dOoFrDNrXidhTq23RMP78op5V0mhj6TOg0oe7CjEkDm6
 J0JH3rCOGxIaS6jlttTAbfzrC3hjG/ypZIq3pJrfDVGPEjPbkBnCtYOrTdgXaga8
 JXTFjMpfO8rZVlxg17D7bv1f1dquMslNIJvnaGPT/x27Vn0mPWoieynx6k4SwLpw
 ==
X-ME-Sender: <xms:gOFqYcCU1r8z0YLfxjeSZYxcOQ9RvmvQcM2_pzcwuHZW66HWswCXqg>
 <xme:gOFqYejx92BPMSd6pIPgYY0Ywi4uR8tiGgFzuf-Lflwyh8uK-hf-zYH8T-jycraB5
 HOiIILgxn-FxKcoq0s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdduiedgjeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
 feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:geFqYfnHKDbVwP-Ut9NGO3JARMYuHQnpFC_ewqsZNGl8moD_ysJSGA>
 <xmx:geFqYSxHdj8XZg39Y5phltkZ1BCg21WuEfA1dSegpiMc4hN8yytI_g>
 <xmx:geFqYRSaIUqFDMxpApzgL2Cp3_MdV2lOKE4CRLNTYqoLDTR3ZqdP7A>
 <xmx:geFqYfMFw47j06gBMUM16CG5VpaDCQQM50U9XD_iecx5H3xnSFOIVA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id EB7802740063; Sat, 16 Oct 2021 10:28:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1345-g8441cd7852-fm-20211006.001-g8441cd78
Mime-Version: 1.0
Message-Id: <df7d123b-772d-4969-b091-78b09b6497b9@www.fastmail.com>
In-Reply-To: <20211013063441.29888-1-wanjiabing@vivo.com>
References: <20211013063441.29888-1-wanjiabing@vivo.com>
Date: Sat, 16 Oct 2021 16:27:55 +0200
To: "Wan Jiabing" <wanjiabing@vivo.com>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>, "Joerg Roedel" <joro@8bytes.org>, 
 "Will Deacon" <will@kernel.org>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/dart: use kmemdup instead of kzalloc and memcpy
Cc: kael_w@yeah.net
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



On Wed, Oct 13, 2021, at 08:34, Wan Jiabing wrote:
> Fix following coccicheck warning:
> drivers/iommu/apple-dart.c:704:20-27: WARNING opportunity for kmemdup
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/iommu/apple-dart.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Looks good to me, thanks!

Acked-by: Sven Peter <sven@svenpeter.dev>


Sven
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
