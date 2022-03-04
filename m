Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D911CC433EF
	for <iommu@archiver.kernel.org>; Fri,  4 Mar 2022 09:37:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E3A441682;
	Fri,  4 Mar 2022 09:37:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rr_8sS6-YrmQ; Fri,  4 Mar 2022 09:37:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5230841694;
	Fri,  4 Mar 2022 09:37:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25D71C001D;
	Fri,  4 Mar 2022 09:37:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96CFCC000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 09:37:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 81134402C3
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 09:37:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e7blJPqMLyfj for <iommu@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 09:37:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 725214029F
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 09:37:06 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 54E8E9BF; Fri,  4 Mar 2022 10:37:04 +0100 (CET)
Date: Fri, 4 Mar 2022 10:37:03 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 00/12] [PULL REQUEST] Intel IOMMU updates for Linux v5.18
Message-ID: <YiHdvx6nMQRsL74S@8bytes.org>
References: <20220301020159.633356-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220301020159.633356-1-baolu.lu@linux.intel.com>
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

Hi Baolu,

On Tue, Mar 01, 2022 at 10:01:47AM +0800, Lu Baolu wrote:
> This includes patches queued for v5.18. It includes:
> 
>  - [PATCH 1 ~ 11] Various cleanups, no intentional functional changes.
>  - [PATCH 12] Enable ATS in SoC-integrated devices listed in ACPI/SATC
>               table.
> 
> Please consider them for v5.18.

I would, but this shows non-trivial conflicts when I am applying it to
the x86/vt-d branch. Can you please re-base the changes and send again?

Thanks,

	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
