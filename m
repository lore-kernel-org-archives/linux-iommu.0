Return-Path: <SRS0=OkX6=ZW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116E2C432C0
	for <iommu@archiver.kernel.org>; Sat, 30 Nov 2019 08:18:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A24942075C
	for <iommu@archiver.kernel.org>; Sat, 30 Nov 2019 08:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24942075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 50E5120480;
	Sat, 30 Nov 2019 08:18:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XTHitDFCpcuz; Sat, 30 Nov 2019 08:18:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C33B420353;
	Sat, 30 Nov 2019 08:18:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6C96C1DD9;
	Sat, 30 Nov 2019 08:18:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85427C0881
 for <iommu@lists.linux-foundation.org>; Sat, 30 Nov 2019 08:18:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 740CF8746B
 for <iommu@lists.linux-foundation.org>; Sat, 30 Nov 2019 08:18:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QbrMQJ4M6vKA for <iommu@lists.linux-foundation.org>;
 Sat, 30 Nov 2019 08:18:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0362C86E88
 for <iommu@lists.linux-foundation.org>; Sat, 30 Nov 2019 08:18:49 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1D9B168BE1; Sat, 30 Nov 2019 09:18:44 +0100 (CET)
Date: Sat, 30 Nov 2019 09:18:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: dma-mapping: use bit macros
Message-ID: <20191130081844.GA8928@lst.de>
References: <1519de9e-0bd6-c7e7-a911-d51481dfb415@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1519de9e-0bd6-c7e7-a911-d51481dfb415@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Fri, Nov 29, 2019 at 09:27:26PM +0100, Heiner Kallweit wrote:
> Not necessarily a big leap for mankind, but using bit macros makes
> the code better readable, especially the definition of DMA_BIT_MASK
> is more intuitive.

NAK, I'm against this pointless obsfucation.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
