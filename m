Return-Path: <SRS0=w+D4=T3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7216C04AB3
	for <iommu@archiver.kernel.org>; Mon, 27 May 2019 14:17:16 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8760621726
	for <iommu@archiver.kernel.org>; Mon, 27 May 2019 14:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8760621726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4D9981838;
	Mon, 27 May 2019 14:17:16 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1DC1A1836
	for <iommu@lists.linux-foundation.org>;
	Mon, 27 May 2019 14:16:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B26B76C5
	for <iommu@lists.linux-foundation.org>;
	Mon, 27 May 2019 14:16:50 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 198CF2E2; Mon, 27 May 2019 16:16:49 +0200 (CEST)
Date: Mon, 27 May 2019 16:16:47 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: Re: [PATCH V3 0/3] Add debugfs support to show scalable mode DMAR
	table
Message-ID: <20190527141647.GG8420@8bytes.org>
References: <cover.1558735674.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1558735674.git.sai.praneeth.prakhya@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Ashok Raj <ashok.raj@intel.com>, iommu@lists.linux-foundation.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, May 24, 2019 at 04:40:14PM -0700, Sai Praneeth Prakhya wrote:
> Changes from V2 to V3:
> ----------------------
> Presently, for V2 patches if kernel command line argument "iommu=pt" is passed,
> dumping DMAR table seg faults. This happens because in pass through mode (for
> non-scalable DMAR's) 3rd bit of context entry is set and it is misinterpreted as
> PASID enabled by debugfs code and hence tries to dereference PASID directory
> pointer which leads to seg fault (PASID directory pointer is undefined for
> non-scalable DMAR's). To fix this, dereference PASID directory pointer only when
> 1. PASID is supported and
> 2. PASID is enabled.
> 
> This patch is tested on
> 1. Non-scalable DMAR with and without iommu=pt
> 2. Scalable DMAR with and without iommu=pt

Sorry, missed this patch-set. Applied this one instead of V2.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
