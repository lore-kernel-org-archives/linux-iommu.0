Return-Path: <SRS0=56b4=IQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C2AC433DB
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 10:29:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6257B64F40
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 10:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6257B64F40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 26F514328F;
	Thu, 18 Mar 2021 10:29:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 647WFrinJxmH; Thu, 18 Mar 2021 10:29:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 204A14325A;
	Thu, 18 Mar 2021 10:29:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3001C000B;
	Thu, 18 Mar 2021 10:29:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45584C0001
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 10:29:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2DDA083D85
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 10:29:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4MVMFwT34bVm for <iommu@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 10:29:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7837F82B81
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 10:29:51 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 646CB2D8; Thu, 18 Mar 2021 11:29:49 +0100 (CET)
Date: Thu, 18 Mar 2021 11:29:48 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Report more information about
 invalidation errors
Message-ID: <YFMrnJC0DEmGgukE@8bytes.org>
References: <20210318005340.187311-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210318005340.187311-1-baolu.lu@linux.intel.com>
Cc: Guo Kaijie <Kaijie.Guo@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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

On Thu, Mar 18, 2021 at 08:53:40AM +0800, Lu Baolu wrote:
> When the invalidation queue errors are encountered, dump the information
> logged by the VT-d hardware together with the pending queue invalidation
> descriptors.
> 
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Tested-by: Guo Kaijie <Kaijie.Guo@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/dmar.c  | 68 ++++++++++++++++++++++++++++++++++---
>  include/linux/intel-iommu.h |  6 ++++
>  2 files changed, 70 insertions(+), 4 deletions(-)

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
