Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3CCC433EF
	for <iommu@archiver.kernel.org>; Fri, 15 Apr 2022 14:35:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 476988419F;
	Fri, 15 Apr 2022 14:35:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0WOM-zYMgq_U; Fri, 15 Apr 2022 14:35:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 29A1384197;
	Fri, 15 Apr 2022 14:35:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D117CC002F;
	Fri, 15 Apr 2022 14:35:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC3F6C002C
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 14:35:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 99CB48419D
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 14:35:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ewgy82C3Q-g4 for <iommu@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 14:35:46 +0000 (UTC)
X-Greylist: delayed 00:07:15 by SQLgrey-1.8.0
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1422184197
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 14:35:45 +0000 (UTC)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 7EA765C004D;
 Fri, 15 Apr 2022 10:28:30 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
 by compute2.internal (MEProxy); Fri, 15 Apr 2022 10:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=cc:cc:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm1; t=1650032910; x=1650119310; bh=5l
 m0diIP9ieTGp9XEJrpPEXmdf/lB1SHrDoovn9aIv8=; b=k0nC3rM1eNEU89aqyn
 6/O8pQom2q3VoLVUxyc0TjxqLbya+e3lItDAuSFw6eXP9dLsBL90ngojHOcsnqWN
 rsIPttNvwTwhujf8ype3CO/7nMwrHYwlmsdHUNK1DGGhP/q4JMMpIT5vVaHYUGtx
 R3Y9Nv0ao7ZlEgrdgWGSVUy7hzP7PVjmtQsjIg6/b0m8qlEOOW4FhXmWOupCRFwL
 eM4WKTrkqj8IVwmJ6nRy6NPYHmJ+3hQe77PXppvdin48JBg9J15iAUsYxikCenhi
 TKDUBUwYegdJdAfWlfKgyYVZjBmVoo0pL6EneLY+OTNuXtSbNN+ND0D7JuEGtpke
 kAuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1650032910; x=
 1650119310; bh=5lm0diIP9ieTGp9XEJrpPEXmdf/lB1SHrDoovn9aIv8=; b=e
 ijrk6Wkkk3qcNjTT08Mi2CTCr6PI56SzLkjALzUNWkDDofQKVQsGQ+1WFImpb3yG
 EFSs3KFaUgz5TwFxxk0bBp734qMoJEVoRS2CUsDaP/5HrlHfu+821eW4HyIPy8Zg
 bn+VQ3K/NxhO4wYnuPvulAoyUMUty6DQhfvfCHoV4Cs97bxlBoPuHpQlFnIPrQZb
 NOtVGcKxvQcwNnfATaIWnygEYYoE4CpnhjQS2V31LRj3K+J4RRoHK1hOdBoINpmR
 ShM1fpw86kdFP006oIdVN2qMje/kOq955jQFyklRYQtof5WLZV8emfvEnk6MBdxr
 H9tBStXYuIyf7jj5ovhOQ==
X-ME-Sender: <xms:DIFZYq5lYwIBoRvQ8dSpA-AolTJy5FoSyrjUgWUExfenrMwjcengwg>
 <xme:DIFZYj67Cjr6__H_KakdyYGd6BzLjKiHfoIU0DSPqBJ0Cr_h9wW7MUnpguEyaUGm6
 FvAgTD_pZFIRZPNbBI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudelhedgjeelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
 feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:DIFZYpfFU7M4PKuXP8zuPPolHy5nsmxeEOLs_OZaq_iolXEvsqaDkg>
 <xmx:DIFZYnI3SPwUOg0yzAhtFFctyL0oHoWwQiuKWlziFp2sAol5yH2NTQ>
 <xmx:DIFZYuLL64GzkvIPiRk4YM6fixhRYIxNbJ66sbQTAZfVeHTxcaNbSQ>
 <xmx:DoFZYgCNKeun78FQd3agXAF3s-f6iWuXExEaevTtWRPXYolhpxrn3A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id B8A0E27407D3; Fri, 15 Apr 2022 10:28:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-387-g7ea99c4045-fm-20220413.002-g7ea99c40
Mime-Version: 1.0
Message-Id: <f0c6c688-c3d6-45fa-8b0f-180faa4d1c46@www.fastmail.com>
In-Reply-To: <36df696dacfffd52e79b471572de9893b52ad0d9.1649935679.git.robin.murphy@arm.com>
References: <cover.1649935679.git.robin.murphy@arm.com>
 <36df696dacfffd52e79b471572de9893b52ad0d9.1649935679.git.robin.murphy@arm.com>
Date: Fri, 15 Apr 2022 16:28:08 +0200
To: "Robin Murphy" <robin.murphy@arm.com>, "Joerg Roedel" <joro@8bytes.org>,
 "Will Deacon" <will@kernel.org>
Subject: Re: [PATCH 06/13] iommu/dart: Clean up bus_set_iommu()
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, zhang.lyra@gmail.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 thierry.reding@gmail.com, gerald.schaefer@linux.ibm.com,
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

On Thu, Apr 14, 2022, at 14:42, Robin Murphy wrote:
> Stop calling bus_set_iommu() since it's now unnecessary, and simplify
> the probe failure path accordingly.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Tested-by: Sven Peter <sven@svenpeter.dev>
Reviewed-by: Sven Peter <sven@svenpeter.dev>

Can't wait until that saga is completed :)


Sven
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
