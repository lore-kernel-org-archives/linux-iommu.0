Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5245FC433F5
	for <iommu@archiver.kernel.org>; Fri,  4 Mar 2022 15:47:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D5DC34021C;
	Fri,  4 Mar 2022 15:47:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B5fqobzkDCEs; Fri,  4 Mar 2022 15:47:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7EEDA40160;
	Fri,  4 Mar 2022 15:47:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5351AC001D;
	Fri,  4 Mar 2022 15:47:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D593C000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 15:47:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 014BE40160
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 15:47:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rYlNiCh_gy8X for <iommu@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 15:47:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A0DB2400F2
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 15:47:45 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id ECFE04ED; Fri,  4 Mar 2022 16:47:41 +0100 (CET)
Date: Fri, 4 Mar 2022 16:47:40 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 00/12] [PULL REQUEST] Intel IOMMU updates for Linux v5.18
Message-ID: <YiI0nAZmYrWikaDH@8bytes.org>
References: <20220301020159.633356-1-baolu.lu@linux.intel.com>
 <YiHdvx6nMQRsL74S@8bytes.org>
 <9cceda23-aa8b-f088-5c0b-1a0168e98ade@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9cceda23-aa8b-f088-5c0b-1a0168e98ade@linux.intel.com>
Cc: YueHaibing <yuehaibing@huawei.com>, Marco Bonelli <marco@mebeim.net>,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
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

On Fri, Mar 04, 2022 at 06:37:01PM +0800, Lu Baolu wrote:
> It's based on this series:
> 
> https://lore.kernel.org/linux-iommu/Yhy%2FawfTOkQLLZ95@8bytes.org/
> 
> which contains some cleanup in vt-d driver as well.
> 
> If I re-base the series onto the vt-d branch, there will also be
> conflicts when you merge the core and vt-d branch.
> 
> I can re-base anyway if you think that's not a problem.

Alright, I merged the core branch into the vt-d branch and applied your
changes on-top, thanks.

Regards,
	
	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
