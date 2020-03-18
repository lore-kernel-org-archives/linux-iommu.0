Return-Path: <SRS0=LxCT=5D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A438C4332B
	for <iommu@archiver.kernel.org>; Wed, 18 Mar 2020 21:49:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB48720768
	for <iommu@archiver.kernel.org>; Wed, 18 Mar 2020 21:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYDwg6ol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB48720768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CA7A7272EB;
	Wed, 18 Mar 2020 21:49:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PakUHe5euinu; Wed, 18 Mar 2020 21:49:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 542622722B;
	Wed, 18 Mar 2020 21:49:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40CA9C1799;
	Wed, 18 Mar 2020 21:49:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78759C087F
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 21:49:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 74BA3882BB
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 21:49:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YSpVafORvFec for <iommu@lists.linux-foundation.org>;
 Wed, 18 Mar 2020 21:49:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id F3D06882B6
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 21:49:37 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3AB5F20754;
 Wed, 18 Mar 2020 21:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584568177;
 bh=P5WR7+CCKYuF1D3YjB6Qxj3jRbK8RLNPfWPK6xDhFJU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MYDwg6ol1Z+QGh9/zDrDHt8bnPDtWLxTMCHZXahQMrF2zKu+dxR/eo1lJ1FPMFmub
 rYxZ8TlyKf1p57qSoAehM9cwXmkd62W+Yj/ZFIe/fzmdsKEaGLM6wI5Isl4w5zHhXz
 i2Fyra1JtidfYnS4VkKmkpnTCTdgAjhqKz+PtDSA=
Date: Wed, 18 Mar 2020 21:49:30 +0000
From: Will Deacon <will@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 07/11] iommu/arm-smmu-v3: Use pci_ats_supported()
Message-ID: <20200318214930.GB8477@willie-the-truck>
References: <20200311124506.208376-1-jean-philippe@linaro.org>
 <20200311124506.208376-8-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200311124506.208376-8-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: mark.rutland@arm.com, linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
 liviu.dudau@arm.com, guohanjun@huawei.com, frowand.list@gmail.com,
 corbet@lwn.net, linux-acpi@vger.kernel.org, lenb@kernel.org,
 devicetree@vger.kernel.org, robh+dt@kernel.org, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org, dwmw2@infradead.org, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, sudeep.holla@arm.com, robin.murphy@arm.com,
 amurray@thegoodpenguin.co.uk
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

On Wed, Mar 11, 2020 at 01:45:02PM +0100, Jean-Philippe Brucker wrote:
> The new pci_ats_supported() function checks if a device supports ATS and
> is allowed to use it.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 4f0a38dae6db..87ae31ef35a1 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2592,26 +2592,14 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
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
>  
> -	pdev = to_pci_dev(master->dev);
> -	return !pdev->untrusted && pdev->ats_cap;
> +	return (smmu->features & ARM_SMMU_FEAT_ATS) && dev_is_pci(dev) &&
> +		pci_ats_supported(to_pci_dev(dev));
>  }
> -#else
> -static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
> -{
> -	return false;
> -}
> -#endif

Acked-by: Will Deacon <will@kernel.org>

Cheers for doing this.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
