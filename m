Return-Path: <SRS0=5Tlr=PG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC4BC433FE
	for <iommu@archiver.kernel.org>; Mon, 18 Oct 2021 18:34:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D53756115A
	for <iommu@archiver.kernel.org>; Mon, 18 Oct 2021 18:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D53756115A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A1FD760781;
	Mon, 18 Oct 2021 18:34:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R2zs_tNhCnga; Mon, 18 Oct 2021 18:34:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 931D56062D;
	Mon, 18 Oct 2021 18:34:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F961C0011;
	Mon, 18 Oct 2021 18:34:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51178C000D
 for <iommu@lists.linux-foundation.org>; Mon, 18 Oct 2021 18:34:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3FE9240235
 for <iommu@lists.linux-foundation.org>; Mon, 18 Oct 2021 18:34:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ESGOuHglqzi1 for <iommu@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 18:34:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 99CDC4020F
 for <iommu@lists.linux-foundation.org>; Mon, 18 Oct 2021 18:34:20 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id C4E9F36E; Mon, 18 Oct 2021 20:34:14 +0200 (CEST)
Date: Mon, 18 Oct 2021 20:33:43 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 0/9] [PULL REQUEST] Intel IOMMU Updates for Linux v5.16
Message-ID: <YW2+B2+glskmqzgC@8bytes.org>
References: <20211014053839.727419-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211014053839.727419-1-baolu.lu@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
 Kyung Min Park <kyung.min.park@intel.com>, iommu@lists.linux-foundation.org,
 Longpeng <longpeng2@huawei.com>
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

On Thu, Oct 14, 2021 at 01:38:30PM +0800, Lu Baolu wrote:
> Fenghua Yu (1):
>   iommu/vt-d: Clean up unused PASID updating functions
> 
> Kyung Min Park (1):
>   iommu/vt-d: Dump DMAR translation structure when DMA fault occurs
> 
> Longpeng(Mike) (2):
>   iommu/vt-d: Convert the return type of first_pte_in_page to bool
>   iommu/vt-d: Avoid duplicate removing in __domain_mapping()
> 
> Lu Baolu (4):
>   iommu/vt-d: Remove duplicate identity domain flag
>   iommu/vt-d: Check FL and SL capability sanity in scalable mode
>   iommu/vt-d: Use second level for GPA->HPA translation
>   iommu/vt-d: Delete dev_has_feat callback
> 
> Tvrtko Ursulin (1):
>   iommu/vt-d: Do not falsely log intel_iommu is unsupported kernel
>     option
> 
>  include/linux/dmar.h            |   8 ++
>  include/linux/intel-iommu.h     |  13 +-
>  arch/x86/include/asm/fpu/api.h  |   2 -
>  drivers/iommu/intel/cap_audit.h |   1 +
>  drivers/iommu/intel/cap_audit.c |  13 ++
>  drivers/iommu/intel/dmar.c      |  10 +-
>  drivers/iommu/intel/iommu.c     | 213 ++++++++++++++++++++++----------
>  drivers/iommu/intel/svm.c       |  24 +---
>  drivers/iommu/intel/Kconfig     |   4 +
>  9 files changed, 188 insertions(+), 100 deletions(-)

Applied, thanks Baolu.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
