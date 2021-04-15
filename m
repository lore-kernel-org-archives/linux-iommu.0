Return-Path: <SRS0=SOau=JM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B25AC433ED
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 14:13:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11AA761153
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 14:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11AA761153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA6E540FA3;
	Thu, 15 Apr 2021 14:13:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5YNKuu7iRuM7; Thu, 15 Apr 2021 14:13:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 917C440F94;
	Thu, 15 Apr 2021 14:13:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7651BC000C;
	Thu, 15 Apr 2021 14:13:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91ABDC000A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 14:13:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7581584715
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 14:13:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t-GY_mUxX8L6 for <iommu@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 14:13:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A025E84712
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 14:13:23 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id C1A0F386; Thu, 15 Apr 2021 16:13:20 +0200 (CEST)
Date: Thu, 15 Apr 2021 16:13:19 +0200
From: Joerg Roedel <joro@8bytes.org>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: Re: [PATCH v2] iommu/vt-d: Force to flush iotlb before creating
 superpage
Message-ID: <YHhJ/0b5i55zGib7@8bytes.org>
References: <20210415004628.1779-1-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210415004628.1779-1-longpeng2@huawei.com>
Cc: Kevin Tian <kevin.tian@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 iommu@lists.linux-foundation.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Gonglei <arei.gonglei@huawei.com>
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

On Thu, Apr 15, 2021 at 08:46:28AM +0800, Longpeng(Mike) wrote:
> Fixes: 6491d4d02893 ("intel-iommu: Free old page tables before creating superpage")
> Cc: <stable@vger.kernel.org> # v3.0+
> Link: https://lore.kernel.org/linux-iommu/670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com/
> Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
> v1 -> v2:
>   - add Joerg
>   - reconstruct the solution base on the Baolu's suggestion
> ---
>  drivers/iommu/intel/iommu.c | 52 +++++++++++++++++++++++++++++++++------------
>  1 file changed, 38 insertions(+), 14 deletions(-)

Applied, thanks.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
