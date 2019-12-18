Return-Path: <SRS0=Tv0G=2I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80295C43603
	for <iommu@archiver.kernel.org>; Wed, 18 Dec 2019 16:13:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 403992072B
	for <iommu@archiver.kernel.org>; Wed, 18 Dec 2019 16:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TO3udsaM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 403992072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F2CFD86BC4;
	Wed, 18 Dec 2019 16:13:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2L76Bi1aedcg; Wed, 18 Dec 2019 16:13:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 521C885BC8;
	Wed, 18 Dec 2019 16:13:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D986C1797;
	Wed, 18 Dec 2019 16:13:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5FE0C077D
 for <iommu@lists.linux-foundation.org>; Wed, 18 Dec 2019 16:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D3EC6876F4
 for <iommu@lists.linux-foundation.org>; Wed, 18 Dec 2019 16:13:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d8uJFtLZial9 for <iommu@lists.linux-foundation.org>;
 Wed, 18 Dec 2019 16:13:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 13EBF87635
 for <iommu@lists.linux-foundation.org>; Wed, 18 Dec 2019 16:13:32 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id q10so2894804wrm.11
 for <iommu@lists.linux-foundation.org>; Wed, 18 Dec 2019 08:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=PXvdq6qWFeAmRkgUP6ivkMlcnTIDIWAWnzZnITD9gIQ=;
 b=TO3udsaM0wHSFHtqq3lx9Vpw/cuxpABpx0ZL6fQor8a23g56txPXE2jNc4FuScZ3Fi
 LXZKSp/98TUo9nRfA1Ld8V1forbku0Bk8tJ7SeCtxPlk3DYZ/BK9L2TwV3xh0U+J3QHt
 JSei+y68UXeLCYVSEiEOrmRm+hf9jKrLSy3waZ06SVfY3S32E4pocftRNi7yO6SsbTOE
 unPpzZIPwL0bn7imVjhmGKGqJ7kxahOEYFOwX2CzXvusbd5u0aHn0r4+JtE8EWQKZb4G
 tXYPPjKJCaNiGfLjAylBAAaSiaK44cjKb9WiZ+3GgVPYjq+oQZQM5pfgoyCaaxXTBT4G
 e4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PXvdq6qWFeAmRkgUP6ivkMlcnTIDIWAWnzZnITD9gIQ=;
 b=fkxaWMmGfI7h0gfedNFgem50+0X2iiUCwR9QKGtEia0hlq8nk4CiMMvlZ3HzwHZz5n
 2Irz+KY0QtmnUNxaaE84GD4Glvzdoro99BCZ0XLfD7Qyw3vyRz9IjmrnOsSbLhakLemM
 Dj97iWVc6LH6bJQkUH4FVjePH5JhpdctcptH6spmJYgl+HVvslV7bQGzzy5cYiw3L27B
 mjjPONjLa5FGiqPMt2i9gKXVqZxT5w+oHrsKsb6v8PeODBOvF1HNeJW9M5Rw7qHAwtsw
 ClCoUNaA+ALqf6yK3WuXxNpViXZmTLdnXo51I590PZPmMbkwMERXaKz3kT2rC8KRo0AW
 +Wvw==
X-Gm-Message-State: APjAAAXXJl1fJ4SclCTMhp0p8GTRwc+xUm+gLjbJVlkGlgUyTefXUFyC
 vGpXQtO0hIIAD+adrPViWCc35g==
X-Google-Smtp-Source: APXvYqz3/O6xngUMvfQZDBfpU617F1qkmNRS56a4TzmWh1A2QPAdGPRnlUyBsXlERsvvTcYDCOXcBA==
X-Received: by 2002:adf:f244:: with SMTP id b4mr3692481wrp.88.1576685610515;
 Wed, 18 Dec 2019 08:13:30 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id b17sm3034639wrp.49.2019.12.18.08.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 08:13:29 -0800 (PST)
Date: Wed, 18 Dec 2019 17:13:23 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v3 13/13] iommu/arm-smmu-v3: Add support for PCI PASID
Message-ID: <20191218161323.GI2371701@myrica>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
 <20191209180514.272727-14-jean-philippe@linaro.org>
 <551ce08c-4160-72c9-05b5-97799f6e5d25@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <551ce08c-4160-72c9-05b5-97799f6e5d25@redhat.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 sudeep.holla@arm.com, rjw@rjwysocki.net, robin.murphy@arm.com,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, guohanjun@huawei.com, bhelgaas@google.com,
 zhangfei.gao@linaro.org, will@kernel.org, linux-arm-kernel@lists.infradead.org,
 lenb@kernel.org
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

On Wed, Dec 18, 2019 at 11:17:55AM +0100, Auger Eric wrote:
> > +static int arm_smmu_enable_pasid(struct arm_smmu_master *master)
> > +{
> > +	int ret;
> > +	int features;
> > +	int num_pasids;
> > +	struct pci_dev *pdev;
> > +
> > +	if (!dev_is_pci(master->dev))
> > +		return -ENODEV;
> > +
> > +	pdev = to_pci_dev(master->dev);
> > +
> > +	features = pci_pasid_features(pdev);
> > +	if (features < 0)
> > +		return -ENODEV;
> why -ENODEV?

Right that should return features. The below should return num_pasids.

> > +
> > +	num_pasids = pci_max_pasids(pdev);
> > +	if (num_pasids <= 0)
> > +		return -ENODEV;
> > +
> > +	ret = pci_enable_pasid(pdev, features);
> > +	if (!ret)
> > +		master->ssid_bits = min_t(u8, ilog2(num_pasids),
> > +					  master->smmu->ssid_bits);
> so here we are ;-)
> > +	return ret;
> > +}
> > +
> > +static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
> > +{
> > +	struct pci_dev *pdev;
> > +
> > +	if (!dev_is_pci(master->dev))
> > +		return;
> > +
> > +	pdev = to_pci_dev(master->dev);
> > +
> > +	if (!pdev->pasid_enabled)
> > +		return;
> > +
> > +	master->ssid_bits = 0;
> > +	pci_disable_pasid(pdev);
> > +}
> > +
> >  static void arm_smmu_detach_dev(struct arm_smmu_master *master)
> >  {
> >  	unsigned long flags;
> > @@ -2851,13 +2894,16 @@ static int arm_smmu_add_device(struct device *dev)
> >  
> >  	master->ssid_bits = min(smmu->ssid_bits, fwspec->num_pasid_bits);
> >  
> > +	/* Note that PASID must be enabled before, and disabled after ATS */
> > +	arm_smmu_enable_pasid(master);
> No error handling?

The device still works if PASID isn't supported or cannot be enabled, it
just won't have some capabilities (IOMMU_DEV_FEAT_AUX and
IOMMU_DEV_FEAT_SVA), so I don't think add_device should return an error.

But it's a good point, I think at least printing an error like
arm_smmu_enable_ats() does would be better.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
