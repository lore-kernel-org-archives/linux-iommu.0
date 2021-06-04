Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B130DC07E94
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 15:33:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5940B61402
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 15:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5940B61402
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 28C6440664;
	Fri,  4 Jun 2021 15:33:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id avUSfOKcPAkB; Fri,  4 Jun 2021 15:33:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id D66F6400E4;
	Fri,  4 Jun 2021 15:33:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D08CC000D;
	Fri,  4 Jun 2021 15:33:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC28EC0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 15:33:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A0B59402D6
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 15:33:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZZXCz7OL1xYH for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 15:33:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 746B440299
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 15:33:42 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 035A23A9; Fri,  4 Jun 2021 17:33:39 +0200 (CEST)
Date: Fri, 4 Jun 2021 17:33:38 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: [PATCH v3] iommu/dma: Fix IOVA reserve dma ranges
Message-ID: <YLpH0jpLzg5R1K5o@8bytes.org>
References: <20200914072319.6091-1-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200914072319.6091-1-srinath.mannam@broadcom.com>
Cc: poza@codeaurora.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, bcm-kernel-feedback-list@broadcom.com,
 Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>
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

On Mon, Sep 14, 2020 at 12:53:19PM +0530, Srinath Mannam wrote:
> Fix IOVA reserve failure in the case when address of first memory region
> listed in dma-ranges is equal to 0x0.
> 
> Fixes: aadad097cd46f ("iommu/dma: Reserve IOVA for PCIe inaccessible DMA address")
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> ---
> Changes from v2:
>    Modify error message with useful information based on Bjorn's comments.
> 
> Changes from v1:
>    Removed unnecessary changes based on Robin's review comments.
> 
>  drivers/iommu/dma-iommu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
