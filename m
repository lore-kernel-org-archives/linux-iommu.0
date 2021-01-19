Return-Path: <SRS0=ZMVL=GW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2472AC433E0
	for <iommu@archiver.kernel.org>; Tue, 19 Jan 2021 13:46:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A3702250E
	for <iommu@archiver.kernel.org>; Tue, 19 Jan 2021 13:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3702250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 14FF786844;
	Tue, 19 Jan 2021 13:46:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MueLgY9JEWVI; Tue, 19 Jan 2021 13:46:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 83F9E86817;
	Tue, 19 Jan 2021 13:46:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73E62C088B;
	Tue, 19 Jan 2021 13:46:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE23CC013A
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 13:46:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C9CD485092
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 13:46:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ckxlp6N0C3Ko for <iommu@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 13:46:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7FB6A80AE1
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 13:46:33 +0000 (UTC)
IronPort-SDR: LvSmSZpNDTkijEC7Q98UX9PxDuRQiKVaj5aoMaaJ9zvKjk7j4HfjBPEjFMxQT5LyltawzVYpyX
 r3j0VWAgaL8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="179074548"
X-IronPort-AV: E=Sophos;i="5.79,358,1602572400"; d="scan'208";a="179074548"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2021 05:46:32 -0800
IronPort-SDR: 9Drec6KDlJklq/AcoxMUfb1QCvAcoxdfbXtmTJNG22mG/Mp0KEG2VcE7luN4EQBo8XIwC9N242
 Rg5zSm+ThUOg==
X-IronPort-AV: E=Sophos;i="5.79,358,1602572400"; d="scan'208";a="383938590"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.174.34])
 ([10.249.174.34])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2021 05:46:30 -0800
Subject: Re: [PATCH 0/2 v2] iommu: fix the failure of deferred attach for
 iommu attach device
To: Lianbo Jiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org
References: <20210119111616.12761-1-lijiang@redhat.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e896bbd5-fdf3-ca04-b2f2-f1c7910f1ee0@linux.intel.com>
Date: Tue, 19 Jan 2021 21:46:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210119111616.12761-1-lijiang@redhat.com>
Content-Language: en-US
Cc: thomas.lendacky@amd.com, iommu@lists.linux-foundation.org, will@kernel.org,
 robin.murphy@arm.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021/1/19 19:16, Lianbo Jiang wrote:
> This patchset is to fix the failure of deferred attach for iommu attach
> device, it includes the following two patches:
> 
> [1] [PATCH 1/2] dma-iommu: use static-key to minimize the impact in the fast-path
>      This is a prepared patch for the second one, move out the is_kdump_kernel()
>      check from iommu_dma_deferred_attach() to iommu_dma_init(), and use the
>      static-key in the fast-path to minimize the impact in the normal case.
> 
> [2] [PATCH 2/2] iommu: use the __iommu_attach_device() directly for deferred attach
>      Move the handling currently in iommu_dma_deferred_attach() into the
>      iommu core code so that it can call the __iommu_attach_device()
>      directly instead of the iommu_attach_device(). The external interface
>      iommu_attach_device() is not suitable for handling this situation.
> 
> Changes since v1:
> [1] use the __iommu_attach_device() directly for deferred attach
> [2] use static-key to minimize the impact in the fast-path
> 
> Lianbo Jiang (2):
>    dma-iommu: use static-key to minimize the impact in the fast-path
>    iommu: use the __iommu_attach_device() directly for deferred attach
> 
>   drivers/iommu/dma-iommu.c | 29 +++++++++++------------------
>   drivers/iommu/iommu.c     | 12 ++++++++++++
>   include/linux/iommu.h     |  2 ++
>   3 files changed, 25 insertions(+), 18 deletions(-)
> 

Good fix and improvement. For the patches in this series:

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
