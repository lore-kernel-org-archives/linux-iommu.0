Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814CFC433F5
	for <iommu@archiver.kernel.org>; Sun, 22 May 2022 13:08:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DCD160B5A;
	Sun, 22 May 2022 13:08:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mBpUVELCErYk; Sun, 22 May 2022 13:08:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F1F5460773;
	Sun, 22 May 2022 13:08:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B17CCC0032;
	Sun, 22 May 2022 13:08:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6203C002D
 for <iommu@lists.linux-foundation.org>; Sun, 22 May 2022 13:08:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 95ABA831D5
 for <iommu@lists.linux-foundation.org>; Sun, 22 May 2022 13:08:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QGjxVNCtgrhN for <iommu@lists.linux-foundation.org>;
 Sun, 22 May 2022 13:08:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 68B58831A9
 for <iommu@lists.linux-foundation.org>; Sun, 22 May 2022 13:08:00 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 90DB668AFE; Sun, 22 May 2022 15:07:53 +0200 (CEST)
Date: Sun, 22 May 2022 15:07:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] dma-direct: Don't over-decrypt memory
Message-ID: <20220522130752.GA25785@lst.de>
References: <796ddc256b8a3054cb0b2f43363613463fcf0d61.1653066613.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <796ddc256b8a3054cb0b2f43363613463fcf0d61.1653066613.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: thomas.lendacky@amd.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, iommu@lists.linux-foundation.org, rientjes@google.com,
 hch@lst.de
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

Thanks,

applied to the dma-mapping for-next branch.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
