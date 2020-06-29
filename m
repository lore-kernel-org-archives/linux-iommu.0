Return-Path: <SRS0=qe9F=AK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181DFC433E0
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 08:13:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBE2123343
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 08:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE2123343
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A11C0220DA;
	Mon, 29 Jun 2020 08:13:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FEBZwI5u2OVo; Mon, 29 Jun 2020 08:13:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C5E44204F2;
	Mon, 29 Jun 2020 08:13:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5900C0865;
	Mon, 29 Jun 2020 08:13:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A545C016E
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 08:13:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 737D38937D
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 08:13:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bzfw+NclGyeC for <iommu@lists.linux-foundation.org>;
 Mon, 29 Jun 2020 08:13:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 463E88937B
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 08:13:00 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 335C268B05; Mon, 29 Jun 2020 10:12:56 +0200 (CEST)
Date: Mon, 29 Jun 2020 10:12:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v2] dma-pool: Fix too large DMA pools on medium systems
Message-ID: <20200629081255.GA32155@lst.de>
References: <20200608132217.29945-1-geert@linux-m68k.org>
 <20200620200936.GA106151@roeck-us.net> <20200624073815.GE18609@lst.de>
 <6473db8e-4116-c994-aa08-6b50a6c609fb@wanadoo.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6473db8e-4116-c994-aa08-6b50a6c609fb@wanadoo.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 David Rientjes <rientjes@google.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>
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

On Sat, Jun 27, 2020 at 06:13:43PM +0200, Marion & Christophe JAILLET wrote:
> I'm sorry, but I will not send pci_ --> dma_ conversion for this driver.
> I'm a bit puzzled by some choice of GFP_KERNEL and GFP_ATOMIC that not all 
> that obvious to me.
>
> I'll try to send some patches for other easier drivers in the coming weeks.

No problem, I sent a patch for the conversion of the allocations that
caused problems.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
