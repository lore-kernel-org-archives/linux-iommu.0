Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC37C433EF
	for <iommu@archiver.kernel.org>; Mon,  2 May 2022 15:23:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 63D2E60F1A;
	Mon,  2 May 2022 15:23:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1eUEDAGj8pQa; Mon,  2 May 2022 15:23:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4CDA560EC1;
	Mon,  2 May 2022 15:23:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04E85C0032;
	Mon,  2 May 2022 15:23:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F121CC002D
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 15:23:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DF1C04088E
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 15:23:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="JVXOWOnT";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="IiWhGgMt"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MVSq17LgDyPZ for <iommu@lists.linux-foundation.org>;
 Mon,  2 May 2022 15:23:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 01AE640876
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 15:23:36 +0000 (UTC)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 169243200999;
 Mon,  2 May 2022 11:23:34 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
 by compute2.internal (MEProxy); Mon, 02 May 2022 11:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=cc:cc:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm1; t=1651505014; x=1651591414; bh=j3
 oztXfiiTixSHUSE4nMfba+UoAMiIb0UBPpgppAZF8=; b=JVXOWOnT9nOTpZZ8g9
 Pzwhtiw3h5UVMarY9Ztfd4jI9lF8wfo8imbsRHIy1tlWfOBKihrxmP1bCVwmGwLl
 n6TmrgXXQ9q2QdBHEppAymCjQJfJUPZGOrzWZmsV0hQJspLENnmjORijEFcICdFa
 hat4Bg7dL8ecMiK2OCHCie9ahWp2hraAuKYaylvMMTwwyWhRR3Pt1xX4qwnA49O6
 RLxwufFjfpkcNv0SF8cVvNRySDzOxnAmXIkAxWk3U9RWe8Q8OOrTFrw3E9y2hbK5
 QQsZh7RgALmFIvJjiPuXjdcBETfp60qNmBxT5BDh2uvFvfQX4PetOAsFc+D9aQu3
 CIuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651505014; x=
 1651591414; bh=j3oztXfiiTixSHUSE4nMfba+UoAMiIb0UBPpgppAZF8=; b=I
 iWhGgMtgZiNuk5tUlfpYB5YIpVB4uKcJVrRsARRpw6iMZJlCkFytVVzsx9zXQmlS
 V+CQEiPI9/9D0j4GyiEa5qf9f79bkNZxAOxFUlQk0Ihjt+YQv30KCRZMddHBWoxh
 k4mhDNH6C5rb+9GAV6iQozaHQW9k4w4uNSfs1GGBje8AzejevxXnHk5NFs7Dy46z
 McHngw/9f7lASeUKT2lE3upNLl6PJTjB5Isjke54WUkaeTMpw9/nCkYIr5vixaF9
 KZdqD+uAzHalUPMMSYWboaj118jFeLoxk3CGJyJeEL9FgZg9GsWUlFD4+zUoPS3y
 mW3j1FaSKKF4CQbFDaSyA==
X-ME-Sender: <xms:dfdvYh3f1NqxGT3aNfT1NrbvS9Dakn6wg9Gn2eD0_kRIisqHxT3PTw>
 <xme:dfdvYoEpyYkvvd_KlxSVOL8TWizGC8gNwNgAC6-UmOueQyDG-Hkbn5C8TNbpj4Rxk
 PSEfVKMB3BB-NRpz3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehgdekjecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpeelvefggeffheevtdeivefhkeehfeettdejteduveeiheevveeilefghfei
 veeiueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:dvdvYh7qPH6er5JU0BFHVwdHS1vjgGCkwFkIzkLh-apI-SophSKHYQ>
 <xmx:dvdvYu0O0pYyoRy6c7ZYDAOIr7Y3pJBoGoX-MvD86K-EBGCZS5hOTQ>
 <xmx:dvdvYkENmXUMqtLpZrydrXkqYxtIxLhRFs7XHr5IM1w8dd5wz1nZSw>
 <xmx:dvdvYoBN1hM4SPd7BlzjXHoMKEhqgsVkoM_OTH4jmHLR37tFKRXFEA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id DE5C7A60063; Mon,  2 May 2022 11:23:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-591-gfe6c3a2700-fm-20220427.001-gfe6c3a27
Mime-Version: 1.0
Message-Id: <373887e4-2012-462c-82a9-10c70f39dd9f@www.fastmail.com>
In-Reply-To: <20220502092238.30486-1-marcan@marcan.st>
References: <20220502092238.30486-1-marcan@marcan.st>
Date: Mon, 02 May 2022 17:23:13 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "Hector Martin" <marcan@marcan.st>, "Joerg Roedel" <joro@8bytes.org>,
 "Will Deacon" <will@kernel.org>
Subject: Re: [PATCH] iommu: dart: Add missing module owner to ops structure
Cc: Sven Peter <iommu@lists.linux-foundation.org>, linux-kernel@vger.kernel.org,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, May 2, 2022, at 11:22, Hector Martin wrote:
> This is required to make loading this as a module work.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

this could probably use a 
Fixes: 46d1fb072e76 ("iommu/dart: Add DART iommu driver")

but otherwise
Reviewed-by: Sven Peter <sven@svenpeter.dev>


Thanks,

Sven
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
