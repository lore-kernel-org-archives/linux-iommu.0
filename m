Return-Path: <SRS0=4RPJ=Z7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F70C43603
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 17:47:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A0BC2077B
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 17:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0BC2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5D18821541;
	Mon,  9 Dec 2019 17:47:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2gkoyFDeWmfN; Mon,  9 Dec 2019 17:47:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 58D3A2001D;
	Mon,  9 Dec 2019 17:47:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 416C6C1D7D;
	Mon,  9 Dec 2019 17:47:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29E59C0881
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 17:47:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1D8D687D41
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 17:47:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bmxlpD0HuvjK for <iommu@lists.linux-foundation.org>;
 Mon,  9 Dec 2019 17:47:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 73CC787D17
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 17:47:55 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 09:09:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,296,1571727600"; d="scan'208";a="362990817"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga004.jf.intel.com with ESMTP; 09 Dec 2019 09:09:29 -0800
Date: Mon, 9 Dec 2019 09:14:15 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v5 0/8] VT-d Native Shared virtual memory cleanup and fixes
Message-ID: <20191209091415.0a733af6@jacob-builder>
In-Reply-To: <1575316709-54903-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1575316709-54903-1-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Joe Perches <joe@perches.com>
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

Hi Joerg and Baolu,

Any more comments on this series? I rebased it on v5.5-rc1 without
changes.


Thanks,

Jacob

On Mon,  2 Dec 2019 11:58:21 -0800
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> Mostly extracted from nested SVA/SVM series based on review comments
> of v7. https://lkml.org/lkml/2019/10/24/852
> 
> This series also adds a few important fixes for native use of SVA.
> Nested SVA new code will be submitted separately as a smaller set.
> Based on the core branch of IOMMU tree staged for v5.5, where common
> APIs for vSVA were applied.
> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git core
> 
> Changelog:
> v5	- Regrouped patch 6 and 8, added comments suggested by Joe
> Perches v4	- Commit message fix
> 
> V3
> 	- Squashed 1/10 & 2/10
> 	- Deleted "8/10 Fix PASID cache flush" from this series
> 	- Addressed reviews from Eric Auger and Baolu
> V2
> 	- Coding style fixes based on Baolu's input, no functional
> change
> 	- Added Acked-by tags.
> 
> Thanks,
> 
> Jacob
> 
> 
> *** BLURB HERE ***
> 
> Jacob Pan (8):
>   iommu/vt-d: Fix CPU and IOMMU SVM feature matching checks
>   iommu/vt-d: Match CPU and IOMMU paging mode
>   iommu/vt-d: Reject SVM bind for failed capability check
>   iommu/vt-d: Avoid duplicated code for PASID setup
>   iommu/vt-d: Fix off-by-one in PASID allocation
>   iommu/vt-d: Replace Intel specific PASID allocator with IOASID
>   iommu/vt-d: Avoid sending invalid page response
>   iommu/vt-d: Misc macro clean up for SVM
> 
>  drivers/iommu/Kconfig       |   1 +
>  drivers/iommu/intel-iommu.c |  23 +++----
>  drivers/iommu/intel-pasid.c |  96 ++++++++------------------
>  drivers/iommu/intel-svm.c   | 163
> +++++++++++++++++++++++++-------------------
> include/linux/intel-iommu.h |   5 +- 5 files changed, 135
> insertions(+), 153 deletions(-)
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
