Return-Path: <SRS0=3/Zu=FA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092D5C56202
	for <iommu@archiver.kernel.org>; Thu, 26 Nov 2020 17:07:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF0E21D1A
	for <iommu@archiver.kernel.org>; Thu, 26 Nov 2020 17:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF0E21D1A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DFE8D878B5;
	Thu, 26 Nov 2020 17:07:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q06tfB6SFV5e; Thu, 26 Nov 2020 17:07:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7779E877F4;
	Thu, 26 Nov 2020 17:07:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 521C8C163C;
	Thu, 26 Nov 2020 17:07:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D330C0052
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 17:07:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1BCC3878B5
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 17:07:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2fvEza-CXYkZ for <iommu@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 17:07:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C7D08877F4
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 17:07:01 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8D7E768B05; Thu, 26 Nov 2020 18:06:57 +0100 (CET)
Date: Thu, 26 Nov 2020 18:06:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] dma-mapping: Fix sizeof() mismatch on tsk allocation
Message-ID: <20201126170657.GA21791@lst.de>
References: <20201125140523.1880669-1-colin.king@canonical.com>
 <a6c5e5ed9a66485da301c1e91b56ccc7@hisilicon.com>
 <20201125182941.GB10377@lst.de>
 <cf79f1ba-aeba-6237-81c8-ca7efc1425e2@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cf79f1ba-aeba-6237-81c8-ca7efc1425e2@canonical.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
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

On Wed, Nov 25, 2020 at 06:49:19PM +0000, Colin Ian King wrote:
> On 25/11/2020 18:29, Christoph Hellwig wrote:
> > I'll fold this one in as well.
> > 
> OK, so two SoB's disappear?

Yes, and are replaced by an annotation about folded fixes, just like
for all kinds of other commits.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
