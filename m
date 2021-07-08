Return-Path: <SRS0=RnLw=MA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5F4C07E96
	for <iommu@archiver.kernel.org>; Thu,  8 Jul 2021 10:03:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EB2161C5B
	for <iommu@archiver.kernel.org>; Thu,  8 Jul 2021 10:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB2161C5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EFACB83AE2;
	Thu,  8 Jul 2021 10:03:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id joun7G4Fhjlt; Thu,  8 Jul 2021 10:03:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D79E783A4A;
	Thu,  8 Jul 2021 10:03:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1380C0010;
	Thu,  8 Jul 2021 10:03:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 154A6C000E
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 10:03:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA1BF83A5B
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 10:03:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bxb91_ggFOqt for <iommu@lists.linux-foundation.org>;
 Thu,  8 Jul 2021 10:03:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 441AB83A4A
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 10:03:53 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id F1134312; Thu,  8 Jul 2021 12:03:50 +0200 (CEST)
Date: Thu, 8 Jul 2021 12:03:45 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] iommu: qcom: Revert "iommu/arm: Cleanup resources in
 case of probe error path"
Message-ID: <YObNgSs+pd0nDfjG@8bytes.org>
References: <CGME20210705065703eucas1p2e89258a2fc286896b755047e06f514cb@eucas1p2.samsung.com>
 <20210705065657.30356-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210705065657.30356-1-m.szyprowski@samsung.com>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 Amey Narkhede <ameynarkhede03@gmail.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>
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

On Mon, Jul 05, 2021 at 08:56:57AM +0200, Marek Szyprowski wrote:
> QCOM IOMMU driver calls bus_set_iommu() for every IOMMU device controller,
> what fails for the second and latter IOMMU devices. This is intended and
> must be not fatal to the driver registration process. Also the cleanup
> path should take care of the runtime PM state, what is missing in the
> current patch. Revert relevant changes to the QCOM IOMMU driver until
> a proper fix is prepared.
> 
> This partially reverts commit 249c9dc6aa0db74a0f7908efd04acf774e19b155.
> 
> Fixes: 249c9dc6aa0d ("iommu/arm: Cleanup resources in case of probe error path")
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)

Applied to iommu/fixes, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
