Return-Path: <SRS0=00Kx=7A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62530C433E1
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 13:38:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 300FF206D4
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 13:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 300FF206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 20D03885F6;
	Mon, 18 May 2020 13:38:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M2AclS6pe0+r; Mon, 18 May 2020 13:38:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 998DE881A8;
	Mon, 18 May 2020 13:38:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82B98C0888;
	Mon, 18 May 2020 13:38:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0DB5C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 13:38:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B6D2821505
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 13:38:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 586f-aTSIzxz for <iommu@lists.linux-foundation.org>;
 Mon, 18 May 2020 13:38:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 9D84720797
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 13:38:17 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 7404A386; Mon, 18 May 2020 15:38:15 +0200 (CEST)
Date: Mon, 18 May 2020 15:38:14 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 00/18] [PULL REQUEST] iommu/vt-d: patches for v5.8
Message-ID: <20200518133813.GB18353@8bytes.org>
References: <20200516062101.29541-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200516062101.29541-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, Tom Murphy <murphyt7@tcd.ie>
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

On Sat, May 16, 2020 at 02:20:43PM +0800, Lu Baolu wrote:
> Jacob Pan (9):
>   iommu/vt-d: Move domain helper to header
>   iommu/vt-d: Use a helper function to skip agaw for SL
>   iommu/vt-d: Add nested translation helper function
>   iommu/vt-d: Add bind guest PASID support
>   iommu/vt-d: Support flushing more translation cache types
>   iommu/vt-d: Add svm/sva invalidate function
>   iommu/vt-d: Add custom allocator for IOASID
>   iommu/vt-d: Report SVA feature with generic flag
>   iommu/vt-d: Replace intel SVM APIs with generic SVA APIs
> 
> Lu Baolu (8):
>   iommu/vt-d: Enlightened PASID allocation
>   iommu/vt-d: Add get_domain_info() helper
>   iommu/vt-d: Multiple descriptors per qi_submit_sync()
>   iommu/vt-d: debugfs: Add support to show inv queue internals
>   iommu/vt-d: Disable non-recoverable fault processing before unbind
>   iommu/vt-d: Add page request draining support
>   iommu/vt-d: Remove redundant IOTLB flush
>   iommu/vt-d: Remove duplicated check in intel_svm_bind_mm()
> 
> Tom Murphy (1):
>   iommu/vt-d: Remove IOVA handling code from the non-dma_ops path

Applied, thanks Baolu.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
