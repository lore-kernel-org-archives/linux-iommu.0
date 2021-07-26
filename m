Return-Path: <SRS0=C8jr=MS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16467C4338F
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 11:28:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A830A60F44
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 11:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A830A60F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6D8CA401B6;
	Mon, 26 Jul 2021 11:28:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hWz4OilcSQ4j; Mon, 26 Jul 2021 11:28:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6ADC04010E;
	Mon, 26 Jul 2021 11:28:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3114EC001A;
	Mon, 26 Jul 2021 11:28:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABEA1C000E
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 11:28:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8D37940139
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 11:28:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 83y0B158CPp3 for <iommu@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 11:28:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 06C8D4010E
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 11:28:07 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id BBC0A2B0; Mon, 26 Jul 2021 13:28:05 +0200 (CEST)
Date: Mon, 26 Jul 2021 13:28:00 +0200
From: Joerg Roedel <joro@8bytes.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v15 0/6] iommu: Enhance IOMMU default DMA mode build
 options
Message-ID: <YP6cQDSuH7toUouj@8bytes.org>
References: <1626088340-5838-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1626088340-5838-1-git-send-email-john.garry@huawei.com>
Cc: dianders@chromium.org, linux-doc@vger.kernel.org, corbet@lwn.net,
 will@kernel.org, linuxarm@huawei.com, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 dwmw2@infradead.org
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

On Mon, Jul 12, 2021 at 07:12:14PM +0800, John Garry wrote:
> John Garry (3):
>   iommu: Deprecate Intel and AMD cmdline methods to enable strict mode
>   iommu: Print strict or lazy mode at init time
>   iommu: Remove mode argument from iommu_set_dma_strict()
> 
> Zhen Lei (3):
>   iommu: Enhance IOMMU default DMA mode build options
>   iommu/vt-d: Add support for IOMMU default DMA mode build options
>   iommu/amd: Add support for IOMMU default DMA mode build options

Applied to iommu/core, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
