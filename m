Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E275C433F5
	for <iommu@archiver.kernel.org>; Fri, 13 May 2022 13:15:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 19EA7408C3;
	Fri, 13 May 2022 13:15:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DPoDJG9FFs3I; Fri, 13 May 2022 13:15:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 121C64011C;
	Fri, 13 May 2022 13:15:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5B6DC0032;
	Fri, 13 May 2022 13:15:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43148C002D
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 13:15:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1C352415D5
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 13:15:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0fgXUhGMYKn1 for <iommu@lists.linux-foundation.org>;
 Fri, 13 May 2022 13:15:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CC72A400DE
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 13:15:46 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 81BD94D2; Fri, 13 May 2022 15:15:44 +0200 (CEST)
Date: Fri, 13 May 2022 15:15:43 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 0/8] [PULL REQUEST] Intel IOMMU updates for Linux v5.19
Message-ID: <Yn5Z/wHPwVoy+y1O@8bytes.org>
References: <20220510023407.2759143-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220510023407.2759143-1-baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux-foundation.org,
 Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
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

On Tue, May 10, 2022 at 10:33:59AM +0800, Lu Baolu wrote:
> This includes patches queued for v5.19. It includes:
> 
>  - Domain force snooping improvement.
>  - Cleanups, no intentional functional changes.
> 
> Please consider them for v5.19.
> 
> [This series cannot be directly applied to vt-d branch. Some domain
>  force snooping patches have been merged on the core branch. You may
>  also need to add those patches to the vt-d branch, or just merge
>  this series into the core branch.]

Alright, merged the core branch into x86/vt-d and applied these patches
on-top.

Thanks Baolu.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
