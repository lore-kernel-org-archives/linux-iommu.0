Return-Path: <SRS0=RnLw=MA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44337C07E96
	for <iommu@archiver.kernel.org>; Thu,  8 Jul 2021 09:38:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE45661446
	for <iommu@archiver.kernel.org>; Thu,  8 Jul 2021 09:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE45661446
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A760D6070D;
	Thu,  8 Jul 2021 09:38:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9AWRjOxvvkBW; Thu,  8 Jul 2021 09:38:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9CE09606E9;
	Thu,  8 Jul 2021 09:38:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D257C0010;
	Thu,  8 Jul 2021 09:38:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC904C000E
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 09:38:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B8CBF6070D
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 09:38:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3r-t2iq4H_j9 for <iommu@lists.linux-foundation.org>;
 Thu,  8 Jul 2021 09:38:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F2A7F606E9
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 09:38:33 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 28043312; Thu,  8 Jul 2021 11:38:31 +0200 (CEST)
Date: Thu, 8 Jul 2021 11:38:29 +0200
From: "joro@8bytes.org" <joro@8bytes.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v14 0/6] iommu: Enhance IOMMU default DMA mode build
 options
Message-ID: <YObHla5Vyr+YaCI7@8bytes.org>
References: <1624016058-189713-1-git-send-email-john.garry@huawei.com>
 <1b75de8f-a2e3-6297-0f56-b2f1548495b0@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1b75de8f-a2e3-6297-0f56-b2f1548495b0@huawei.com>
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>,
 Linuxarm <linuxarm@huawei.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
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

Hi John,

On Fri, Jun 25, 2021 at 05:41:09PM +0100, John Garry wrote:
> We think that this series is ready to go.
> 
> There would be a build conflict with the following:
> https://lore.kernel.org/linux-iommu/20210616100500.174507-1-namit@vmware.com/
> 
> So please let us know where you stand on it, so that could be resolved.
> 
> Robin and Baolu have kindly reviewed all the patches, apart from the AMD
> one.

The AMD one also looks good to me, please re-send after the merge window
closes and I will take care of it then. Note that I usually start
merging new stuff after -rc3 is out.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
