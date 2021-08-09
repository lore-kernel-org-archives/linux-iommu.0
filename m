Return-Path: <SRS0=YfIy=NA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FB9C4338F
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 12:52:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C6EC60EDF
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 12:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C6EC60EDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE93182EA1;
	Mon,  9 Aug 2021 12:52:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gZhHkoe2FVBc; Mon,  9 Aug 2021 12:52:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C4CC882CDE;
	Mon,  9 Aug 2021 12:52:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 930A2C0010;
	Mon,  9 Aug 2021 12:52:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 126EBC000E
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 12:52:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 01B6460756
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 12:52:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RPgaYZ2wdfpF for <iommu@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 12:52:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 862F260647
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 12:52:44 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id D482360E78;
 Mon,  9 Aug 2021 12:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628513564;
 bh=2GdN8DXcLKY6quaCw1rtuvP0Kw0zfqRfIg+LPre32c4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=itunlC02CLGsvDphIlDR/5dpsZL296ArW0IxZolvss0dFEd7dhOrjDGQ5oL8kUi+8
 ZSLKB6GrOeIEQnEL0YG+kij+D39yylkWqWcsQYmN31c5XX9gOpac6sJ5nQ2WJ9JndP
 m7fh+4pnBwzVj+Lh/HWS0Tbf65NwwGNYY89zjNmxi/g37dk646P9n/qDMST1+ZkGnp
 lwFctwo1zC2t8zfLRGCtw+1JqnX68dcCjppXGZt5+LvBO6y5oYoZGkCxMYch3B6Vo4
 JngGmJo9wH8dZ+UsstcyL2rGsf8wL2qCBNJbZRPT1wjrdOm2T0Yia767C61TT3mFlv
 5ubgaHRseS4Kw==
Date: Mon, 9 Aug 2021 13:52:39 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 24/25] iommu/dma: Factor out flush queue init
Message-ID: <20210809125238.GB1097@willie-the-truck>
References: <cover.1628094600.git.robin.murphy@arm.com>
 <3b5284ee394f267ba966839173f874fc9a996bb2.1628094601.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3b5284ee394f267ba966839173f874fc9a996bb2.1628094601.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 iommu@lists.linux-foundation.org, rajatja@google.com,
 linux-arm-kernel@lists.infradead.org
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

On Wed, Aug 04, 2021 at 06:15:52PM +0100, Robin Murphy wrote:
> Factor out flush queue setup from the initial domain init so that we
> can potentially trigger it from sysfs later on in a domain's lifetime.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/dma-iommu.c | 30 ++++++++++++++++++++----------
>  include/linux/dma-iommu.h |  9 ++++++---
>  2 files changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 2e19505dddf9..f51b8dc99ac6 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -310,6 +310,25 @@ static bool dev_is_untrusted(struct device *dev)
>  	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
>  }
>  
> +int iommu_dma_init_fq(struct iommu_domain *domain)
> +{
> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> +
> +	if (domain->type != IOMMU_DOMAIN_DMA_FQ)
> +		return -EINVAL;
> +	if (cookie->fq_domain)
> +		return 0;
> +
> +	if (init_iova_flush_queue(&cookie->iovad, iommu_dma_flush_iotlb_all,
> +				  iommu_dma_entry_dtor)) {
> +		pr_warn("iova flush queue initialization failed\n");
> +		domain->type = IOMMU_DOMAIN_DMA;
> +		return -ENODEV;

I do find this a bit odd: we assert that the caller has set domain->type
to IOMMU_DOMAIN_DMA_FQ but then on failure we reset it to IOMMU_DOMAIN_DMA
here. I think it would be less error-prone if the setting of domain->type
was handled in the same function.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
