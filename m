Return-Path: <SRS0=5tw2=PM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35229C433F5
	for <iommu@archiver.kernel.org>; Sun, 24 Oct 2021 18:01:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E25F60F0F
	for <iommu@archiver.kernel.org>; Sun, 24 Oct 2021 18:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8E25F60F0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B737402E3;
	Sun, 24 Oct 2021 18:01:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cqgYXwntKTLu; Sun, 24 Oct 2021 18:01:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4A0FD402E2;
	Sun, 24 Oct 2021 18:01:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A69BC0019;
	Sun, 24 Oct 2021 18:01:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 166DFC000E
 for <iommu@lists.linux-foundation.org>; Sun, 24 Oct 2021 18:01:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EAB80605DD
 for <iommu@lists.linux-foundation.org>; Sun, 24 Oct 2021 18:01:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aAUvD7ii_7K6 for <iommu@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 18:01:14 +0000 (UTC)
X-Greylist: delayed 00:06:22 by SQLgrey-1.8.0
Received: from smtprelay.hostedemail.com (smtprelay0206.hostedemail.com
 [216.40.44.206])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BF50E605CF
 for <iommu@lists.linux-foundation.org>; Sun, 24 Oct 2021 18:01:14 +0000 (UTC)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave04.hostedemail.com (Postfix) with ESMTP id D02FF18020D8B
 for <iommu@lists.linux-foundation.org>; Sun, 24 Oct 2021 17:54:52 +0000 (UTC)
Received: from omf02.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
 by smtprelay03.hostedemail.com (Postfix) with ESMTP id 38F50837F24A;
 Sun, 24 Oct 2021 17:54:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf02.hostedemail.com (Postfix) with ESMTPA id 045191D42FE; 
 Sun, 24 Oct 2021 17:54:48 +0000 (UTC)
Message-ID: <c8cd95bc81173fdbdff4f2b504db3ce89119fa0d.camel@perches.com>
Subject: Re: [PATCH] dma-mapping: Use 'bitmap_zalloc()' when applicable
From: Joe Perches <joe@perches.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, hch@lst.de, 
 m.szyprowski@samsung.com, robin.murphy@arm.com
Date: Sun, 24 Oct 2021 10:54:47 -0700
In-Reply-To: <20976d6fd4af266dec589b40929b53dfddd64b75.1635097161.git.christophe.jaillet@wanadoo.fr>
References: <20976d6fd4af266dec589b40929b53dfddd64b75.1635097161.git.christophe.jaillet@wanadoo.fr>
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 045191D42FE
X-Stat-Signature: dotqdwh1id9s5bqhiu7qf5wdox53djwc
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19VkHMpeC0Rf7DNqfV3OOTzbF+2tEL3N9E=
X-HE-Tag: 1635098088-252882
Cc: iommu@lists.linux-foundation.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
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

On Sun, 2021-10-24 at 19:40 +0200, Christophe JAILLET wrote:
> 'dma_mem->bitmap' is a bitmap. So use 'bitmap_zalloc()' to simplify code,
> improve the semantic and avoid some open-coded arithmetic in allocator
> arguments.

There is a cocci script for some of these.

https://lore.kernel.org/all/08b89608cfb1280624d1a89ead6547069f9a4c31.camel@perches.com/


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
