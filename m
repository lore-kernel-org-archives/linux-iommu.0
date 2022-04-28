Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D8EC433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 09:02:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F229060C01;
	Thu, 28 Apr 2022 09:02:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zw4j28GVQf4q; Thu, 28 Apr 2022 09:02:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E734B60C0F;
	Thu, 28 Apr 2022 09:02:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9C8FC0039;
	Thu, 28 Apr 2022 09:02:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1724CC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 09:02:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 01480410E4
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 09:02:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j90PGzVigS7X for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 09:02:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4FF53410D0
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 09:02:47 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 346672FB; Thu, 28 Apr 2022 11:02:45 +0200 (CEST)
Date: Thu, 28 Apr 2022 11:02:44 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 0/1] iommu/vt-d: Fixes for v5.18-rc4
Message-ID: <YmpYNJ0hMJm5PNU7@8bytes.org>
References: <20220423082330.3897867-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220423082330.3897867-1-baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux-foundation.org
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

On Sat, Apr 23, 2022 at 04:23:29PM +0800, Lu Baolu wrote:
> Hi Joerg,
> 
> One fix is queued for v5.18. It aims to fix:
> 
>  - Handle PCI stop marker messages in IOMMU driver to meet the
>    requirement of I/O page fault handling framework.
> 
> Please consider it for the iommu/fix branch.
> 
> Best regards,
> Lu Baolu
> 
> Lu Baolu (1):
>   iommu/vt-d: Drop stop marker messages
> 
>  drivers/iommu/intel/svm.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied to iommu/fixes, thanks.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
