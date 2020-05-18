Return-Path: <SRS0=00Kx=7A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C648C433E0
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 15:37:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 013A4207E8
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 15:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="17iaSWZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013A4207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C3F6620495;
	Mon, 18 May 2020 15:37:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Es+9gAITuk1w; Mon, 18 May 2020 15:37:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BF66D20356;
	Mon, 18 May 2020 15:37:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 858B6C0888;
	Mon, 18 May 2020 15:37:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 674CBC07FF
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 15:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6326988581
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 15:37:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UMomWrhu5ujq for <iommu@lists.linux-foundation.org>;
 Mon, 18 May 2020 15:37:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B5DF388575
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 15:37:39 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B7CD720657;
 Mon, 18 May 2020 15:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589816259;
 bh=EhGDmXaw1hIzPjQBCe1L73zVhpK0WWSpGkldIfpkakQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=17iaSWZ809+SeQ4xkNM7+7yWrBt+CuPeic8ZjxN8zDpxcvigQFJAY6hS4xUTnZ0PV
 TVNE0WEfptLrFqoIPl+lzqq+9vY4pkCjIEfB45N5i++g4SKevueEzjo6flcMF7+Uv7
 CjtAqM5b0wEi2eNrbV0xoNpLji3A77Fduepja3Kw=
Date: Mon, 18 May 2020 16:37:34 +0100
From: Will Deacon <will@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 3/4] iommu/arm-smmu-v3: Use pci_ats_supported()
Message-ID: <20200518153733.GM32394@willie-the-truck>
References: <20200515104359.1178606-1-jean-philippe@linaro.org>
 <20200515104359.1178606-4-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200515104359.1178606-4-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: ashok.raj@intel.com, linux-pci@vger.kernel.org, alex.williamson@redhat.com,
 iommu@lists.linux-foundation.org, bhelgaas@google.com, robin.murphy@arm.com,
 dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org
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

On Fri, May 15, 2020 at 12:44:01PM +0200, Jean-Philippe Brucker wrote:
> The new pci_ats_supported() function checks if a device supports ATS and
> is allowed to use it.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> I dropped the Ack because I slightly changed the patch to keep the
> fwspec check, since last version:
> https://lore.kernel.org/linux-iommu/20200311124506.208376-8-jean-philippe@linaro.org/
> ---
>  drivers/iommu/arm-smmu-v3.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 82508730feb7a1..39b935e86ab203 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2652,26 +2652,16 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
>  	}
>  }
>  
> -#ifdef CONFIG_PCI_ATS
>  static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
>  {
> -	struct pci_dev *pdev;
> +	struct device *dev = master->dev;
>  	struct arm_smmu_device *smmu = master->smmu;
> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
> -
> -	if (!(smmu->features & ARM_SMMU_FEAT_ATS) || !dev_is_pci(master->dev) ||
> -	    !(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS) || pci_ats_disabled())
> -		return false;
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>  
> -	pdev = to_pci_dev(master->dev);
> -	return !pdev->untrusted && pdev->ats_cap;
> +	return (smmu->features & ARM_SMMU_FEAT_ATS) &&
> +		!(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS) &&
> +		dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev));

nit, but I think this is clearer if you leave it split up (untested diff
below).

Will

--->8

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 82508730feb7..c5730557dbe3 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2652,26 +2652,20 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
 	}
 }
 
-#ifdef CONFIG_PCI_ATS
 static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
 {
-	struct pci_dev *pdev;
+	struct device *dev = master->dev;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
-	if (!(smmu->features & ARM_SMMU_FEAT_ATS) || !dev_is_pci(master->dev) ||
-	    !(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS) || pci_ats_disabled())
+	if (!(smmu->features & ARM_SMMU_FEAT_ATS))
 		return false;
 
-	pdev = to_pci_dev(master->dev);
-	return !pdev->untrusted && pdev->ats_cap;
-}
-#else
-static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
-{
-	return false;
+	if (!(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS))
+		return false;
+
+	return dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev));
 }
-#endif
 
 static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 {
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
