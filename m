Return-Path: <SRS0=9w/B=G7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E77DC433DB
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 12:28:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F4BF64DDC
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 12:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F4BF64DDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2386A864EA;
	Thu, 28 Jan 2021 12:28:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tYYqeWDcxjBe; Thu, 28 Jan 2021 12:28:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 86BBE86470;
	Thu, 28 Jan 2021 12:28:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67CCEC08A1;
	Thu, 28 Jan 2021 12:28:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7FD1C013A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 12:28:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A0A2486B71
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 12:28:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bMTvE+5K-d0i for <iommu@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 12:28:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 62B9E86B6C
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 12:28:08 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 1103E51D; Thu, 28 Jan 2021 13:28:06 +0100 (CET)
Date: Thu, 28 Jan 2021 13:28:04 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lianbo Jiang <lijiang@redhat.com>
Subject: Re: [PATCH v3 0/2] iommu: fix the failure of deferred attach for
 iommu attach device
Message-ID: <20210128122804.GM32671@8bytes.org>
References: <20210126115337.20068-1-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210126115337.20068-1-lijiang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: thomas.lendacky@amd.com, will@kernel.org, linux-kernel@vger.kernel.org,
 hch@infradead.org, iommu@lists.linux-foundation.org, robin.murphy@arm.com
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

On Tue, Jan 26, 2021 at 07:53:35PM +0800, Lianbo Jiang wrote:
> Lianbo Jiang (2):
>   dma-iommu: use static-key to minimize the impact in the fast-path
>   iommu: use the __iommu_attach_device() directly for deferred attach
> 
>  drivers/iommu/dma-iommu.c | 29 +++++++++++------------------
>  drivers/iommu/iommu.c     | 10 ++++++++++
>  include/linux/iommu.h     |  1 +
>  3 files changed, 22 insertions(+), 18 deletions(-)

Sorry, missed that there was a newer version. Applied this instead of
v2.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
