Return-Path: <SRS0=FRM4=CU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6010C43461
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 15:17:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55CA4221E7
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 15:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLZgioYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CA4221E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F0DFF87519;
	Fri, 11 Sep 2020 15:17:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6MJLEI0jZtPM; Fri, 11 Sep 2020 15:17:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 734AD874FB;
	Fri, 11 Sep 2020 15:17:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58277C0051;
	Fri, 11 Sep 2020 15:17:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE0C7C0859
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 15:17:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CABD787916
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 15:17:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6V0sKMSqAvhL for <iommu@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 15:17:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id F0E5D87938
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 15:17:00 +0000 (UTC)
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5BFE9207FB;
 Fri, 11 Sep 2020 15:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599837420;
 bh=UgW+C5QZjycibLoS/tcqKqhyMmI/U+lFQKYBS2XVPfA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=kLZgioYIEs3XGoa0lj43AdrxF1oOXBVHEQwIQcQdQQ6uniLSEZOA///PyQk1yAr7F
 R1a1Js+N7TSzeRMpZ4rTDZblWrr0SpM4Hgoi3EmVaLPwOWEqfMpu+aU6EGEmw+os7h
 F4UtW2iKcmB2ti/DMFP5NMxyftQvYRhY/4gEzkh8=
Date: Fri, 11 Sep 2020 10:16:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: [PATCH v2] iommu/dma: Fix IOVA reserve dma ranges
Message-ID: <20200911151659.GA868760@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200911102534.25218-1-srinath.mannam@broadcom.com>
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

On Fri, Sep 11, 2020 at 03:55:34PM +0530, Srinath Mannam wrote:
> Fix IOVA reserve failure in the case when address of first memory region
> listed in dma-ranges is equal to 0x0.
> 
> Fixes: aadad097cd46f ("iommu/dma: Reserve IOVA for PCIe inaccessible DMA address")
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> ---
> Changes from v1:
>    Removed unnecessary changes based on Robin's review comments.
> 
>  drivers/iommu/dma-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 5141d49a046b..682068a9aae7 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -217,7 +217,7 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
>  			lo = iova_pfn(iovad, start);
>  			hi = iova_pfn(iovad, end);
>  			reserve_iova(iovad, lo, hi);
> -		} else {
> +		} else if (end < start) {
>  			/* dma_ranges list should be sorted */
>  			dev_err(&dev->dev, "Failed to reserve IOVA\n");

You didn't actually change the error message, but the message would be
way more useful if it included the IOVA address range, e.g., the
format used in pci_register_host_bridge():

  bus address [%#010llx-%#010llx]

Incidentally, the pr_err() in copy_reserved_iova() looks bogus; it
prints iova->pfn_low twice, when it should probably print the base and
size or (my preference) something like the above:

        pr_err("Reserve iova range %lx@%lx failed\n",
               iova->pfn_lo, iova->pfn_lo);

>  			return -EINVAL;
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
