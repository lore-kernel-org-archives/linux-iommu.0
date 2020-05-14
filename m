Return-Path: <SRS0=Hf/t=64=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05294C433E0
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 05:59:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9614206BE
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 05:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hHyzcWqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9614206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6930289641;
	Thu, 14 May 2020 05:59:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4+aqNV3FcsM4; Thu, 14 May 2020 05:59:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E9AAB89613;
	Thu, 14 May 2020 05:59:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2CB3C0178;
	Thu, 14 May 2020 05:59:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DA48C016F
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 05:59:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 66D5C87EAF
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 05:59:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id II0W5d+6ZCmk for <iommu@lists.linux-foundation.org>;
 Thu, 14 May 2020 05:59:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EC67987FD9
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 05:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=M+qxD2Cel9ucZihBKyiJsuzooLuAoDllAt0yCxikIeQ=; b=hHyzcWqb/n45md9Y7kA0vEetZQ
 9GYNLJhY1t7JkNqD2wIthFRQWnlzHnHMZbl1BVg0L90kJ2CvlhPX5i3R9VEV08LR/vbC43YwQ87Cm
 oZYTjRfjtxVfOQUaBKm8OpVXZAdkrcHbFeQFhX3FETapL0DjyHnHKdvnVn7k0tZsF6AOsU5VKrDLk
 QB8u/VeY2CqbdKwgEQHf96c0yAtae5IiBJcEsB1Wn7xVMPcz5Fr8kYsAf8dmMTKyWFrQPEXCIP9vk
 +k08oJopswkSdNTBlFYTX4mIzoE7PPtO7mhc70S3g5MltNvwEdGpVVFwAyLLvWoiZC54lzb7zBbTg
 1qUcjySg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jZ6u2-0006mS-Ry; Thu, 14 May 2020 05:59:30 +0000
Date: Wed, 13 May 2020 22:59:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v13 4/8] iommu/vt-d: Add bind guest PASID support
Message-ID: <20200514055930.GD22388@infradead.org>
References: <1589410909-38925-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1589410909-38925-5-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1589410909-38925-5-git-send-email-jacob.jun.pan@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Raj Ashok <ashok.raj@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Jonathan Cameron <jic23@kernel.org>
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

> +	if (dev_is_pci(dev)) {
> +		/* VT-d supports devices with full 20 bit PASIDs only */
> +		if (pci_max_pasids(to_pci_dev(dev)) != PASID_MAX)
> +			return -EINVAL;
> +	} else {
> +		return -ENOTSUPP;
> +	}

This looks strange.  Why not:

	if (!dev_is_pci(dev)) {
		return -ENOTSUPP;

	/* VT-d supports devices with full 20 bit PASIDs only */
	if (pci_max_pasids(to_pci_dev(dev)) != PASID_MAX)
		return -EINVAL;

> +		for_each_svm_dev(sdev, svm, dev) {
> +			/*
> +			 * For devices with aux domains, we should allow multiple
> +			 * bind calls with the same PASID and pdev.
> +			 */
> +			if (iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX)) {
> +				sdev->users++;
> +			} else {
> +				dev_warn_ratelimited(dev, "Already bound with PASID %u\n",
> +						svm->pasid);
> +				ret = -EBUSY;
> +			}
> +			goto out;

Is this intentionally a for loop that jumps out of the loop after
the first device?

> +	/*
> +	 * PASID table is per device for better security. Therefore, for
> +	 * each bind of a new device even with an existing PASID, we need to
> +	 * call the nested mode setup function here.
> +	 */
> +	spin_lock(&iommu->lock);
> +	ret = intel_pasid_setup_nested(iommu,
> +				       dev,
> +				       (pgd_t *)data->gpgd,
> +				       data->hpasid,
> +				       &data->vtd,
> +				       dmar_domain,
> +				       data->addr_width);

Why not:

	et = intel_pasid_setup_nested(iommu, dev, (pgd_t *)data->gpgd,
			data->hpasid, &data->vtd, dmar_domain,
			data->addr_width);

?

> +	for_each_svm_dev(sdev, svm, dev) {
> +		ret = 0;

		...

> +		break;
> +	}

Same only looks at the first device style.  Why dos it only care about
the first device?  That needs at least a comment, and probably a
first_svm_dev or so heper to make it explicit.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
