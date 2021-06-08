Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4AAC47082
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 09:35:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F9D66128A
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 09:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9D66128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CE4D9400DF;
	Tue,  8 Jun 2021 09:35:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9dJ389-Zi_uC; Tue,  8 Jun 2021 09:35:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id D837940291;
	Tue,  8 Jun 2021 09:35:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4417C000B;
	Tue,  8 Jun 2021 09:35:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CD17C0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 09:35:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 167A983459
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 09:35:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H-FQ7e4kTYuC for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 09:34:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9718883437
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 09:34:59 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD0A761208;
 Tue,  8 Jun 2021 09:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623144898;
 bh=OBg9ZyaK512GGHt182oF1kF5QsrSXhwvc7zhceE23oM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iDb+QR31ZeM+YOq1a0JSVmmISfgSlciNzX/PmhKHv1750KXls7wRjZCHvq/zT9stC
 CThLm/qbdLjJXoWle+V4R5fcGAdx4eoEIrVUm/It3A47aJVhN3Ctk7L1ZPuk6hpVxl
 abUtxuBD4DLrmkD/iXYD8kwVAX3uEy6SN9TQ25l4yeFGP5HwV4MTaIBsBsD00qni23
 t5k0+WW0QoavnXoqbxbazgVPF1B+gJFpQEr1Dcu3yAFFsTAanJ1gUETwGMz5xQAskA
 INiuFeE/aHoi5nG6BRZeuQP0CwrcXpdLuO/HOp9udFSE95oT1tggqpOoU3nsbadaQ6
 VDBodI6R5uqXg==
Date: Tue, 8 Jun 2021 10:34:53 +0100
From: Will Deacon <will@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Select PCI_ATS explicitly
Message-ID: <20210608093453.GB8935@willie-the-truck>
References: <20210512065313.3441309-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210512065313.3441309-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kevin.tian@intel.com, ashok.raj@intel.com, sanjay.k.kumar@intel.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jacob.jun.pan@intel.com
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

On Wed, May 12, 2021 at 02:53:13PM +0800, Lu Baolu wrote:
> The Intel VT-d implementation supports device TLB management. Select
> PCI_ATS explicitly so that the pci_ats helpers are always available.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> index 28a3d1596c76..7e5b240b801d 100644
> --- a/drivers/iommu/intel/Kconfig
> +++ b/drivers/iommu/intel/Kconfig
> @@ -14,6 +14,7 @@ config INTEL_IOMMU
>  	select SWIOTLB
>  	select IOASID
>  	select IOMMU_DMA
> +	select PCI_ATS
>  	help
>  	  DMA remapping (DMAR) devices support enables independent address
>  	  translations for Direct Memory Access (DMA) from devices.

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
