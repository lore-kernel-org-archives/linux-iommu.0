Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE43EC433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 14:54:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9072183DF8;
	Thu, 28 Apr 2022 14:54:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id maEgi018ezOK; Thu, 28 Apr 2022 14:53:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3CECD83DF4;
	Thu, 28 Apr 2022 14:53:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1842C0032;
	Thu, 28 Apr 2022 14:53:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27FB6C002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:53:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0700E83DF8
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:53:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4fmkp0a7S8QT for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 14:53:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D446B83DF4
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:53:56 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id x18so7185992wrc.0
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 07:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=XB6h972j5Zc5Yul0kh9vlaIZfxycg9OQhkbmMJ/20t8=;
 b=c/ri+iwJu54XxDDUxjRAyyeZXQg/x1z/8UR7R7qAnFzlIKkGhpuZSRtt5g+hSLafJB
 eR7InkulNarobbYa+axDXjKwE4ictyyHFKt4f+/zQXhYz73cWLBD+LK8/ForutsXBl0C
 JIRRMq6/jfDigNP7R6bS5UJMUf19Ki2MAmxeFjC4GXvxZnEwK6up3bFvn56+fgj+jdGO
 mgwO+zZ7ZHpSYDD8pV8IY9EiC1X6v1FiDD49K/a/165zmInJQANi3nYO5NigmcbdZDpm
 6RyZxKMGbEhh8JbJI+xkQAw3AJJrIdAFk98aq6I+qyEKnzT/TLU41K+KI2mPmdh8MvOc
 iDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XB6h972j5Zc5Yul0kh9vlaIZfxycg9OQhkbmMJ/20t8=;
 b=V0a0h8YYRVo56TMDBsewkKWr3zNVUZ5OIe0wERfpZk/nQq5e8OWfbLkajI7OSU2Ui1
 pTFLk33IOpyPY6hGbfVRLPJNISnKte4mABpRovjOTjGco174pjiF0LuKrx8v994GHdTN
 /9RlRAjyc8/vMfZrwoL4lAe9YiFDXHHp7gBjhg555UYwJRO0HHDh+QUv2QaFgjK9p+rd
 vynzpDsXCi5kmU08PVkvuNCzX9f90dnWxBMz+OVNWVzuw5TmFAvYzy8kdptEhaGkJFvj
 efkC2tCbvyEfGvbe4X662aAw608iU4i8p37g8u+CJkDV5/xda1yTpEp1kj7CzqyIH2Ul
 BgEg==
X-Gm-Message-State: AOAM532MEVw9OccnLYIxM+bkYDDzP6GrCzJnZc5S6fpZu3UqTq/baGNT
 WCk0MejKizVRH5HfHr+1fle19w==
X-Google-Smtp-Source: ABdhPJwpsxclCmp4KjVr6hySleD4JiRE2eyEIgPLnb1Xk0MUhP3G+i76OcP8pfdXW7USyRywbuGapQ==
X-Received: by 2002:adf:d1ea:0:b0:20a:2823:9e22 with SMTP id
 g10-20020adfd1ea000000b0020a28239e22mr27163586wrd.332.1651157635031; 
 Thu, 28 Apr 2022 07:53:55 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 f10-20020adff98a000000b0020af37b8d62sm43481wrr.113.2022.04.28.07.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 07:53:54 -0700 (PDT)
Date: Thu, 28 Apr 2022 15:53:29 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 03/12] iommu: Add attach/detach_dev_pasid domain ops
Message-ID: <YmqqaXtqev9FUJo7@myrica>
References: <20220421052121.3464100-1-baolu.lu@linux.intel.com>
 <20220421052121.3464100-4-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220421052121.3464100-4-baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
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

On Thu, Apr 21, 2022 at 01:21:12PM +0800, Lu Baolu wrote:
> Attaching an IOMMU domain to a PASID of a device is a generic operation
> for modern IOMMU drivers which support PASID-granular DMA address
> translation. Currently visible usage scenarios include (but not limited):
> 
>  - SVA (Shared Virtual Address)
>  - kernel DMA with PASID
>  - hardware-assist mediated device
> 
> This adds a pair of common domain ops for this purpose and adds helpers
> to attach/detach a domain to/from a {device, PASID}. Some buses, like
> PCI, route packets without considering the PASID value. Thus a DMA target
> address with PASID might be treated as P2P if the address falls into the
> MMIO BAR of other devices in the group. To make things simple, these
> interfaces only apply to devices belonging to the singleton groups, and
> the singleton is immutable in fabric i.e. not affected by hotplug.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
[...]
> +/*
> + * Use standard PCI bus topology, isolation features, and DMA
> + * alias quirks to check the immutable singleton attribute. If
> + * the device came from DT, assume it is static and then
> + * singleton can know from the device count in the group.
> + */
> +static bool device_group_immutable_singleton(struct device *dev)
> +{
> +	struct iommu_group *group = iommu_group_get(dev);
> +	int count;
> +
> +	if (!group)
> +		return false;
> +
> +	mutex_lock(&group->mutex);
> +	count = iommu_group_device_count(group);
> +	mutex_unlock(&group->mutex);
> +	iommu_group_put(group);
> +
> +	if (count != 1)
> +		return false;
> +
> +	if (dev_is_pci(dev)) {
> +		struct pci_dev *pdev = to_pci_dev(dev);
> +
> +		/*
> +		 * The device could be considered to be fully isolated if
> +		 * all devices on the path from the device to the host-PCI
> +		 * bridge are protected from peer-to-peer DMA by ACS.
> +		 */
> +		if (!pci_acs_path_enabled(pdev, NULL, REQ_ACS_FLAGS))
> +			return false;
> +
> +		/* Filter out devices which has any alias device. */
> +		if (pci_for_each_dma_alias(pdev, has_pci_alias, pdev))
> +			return false;

Aren't aliases already added to the group by pci_device_group()?  If so
it's part of the count check above

> +
> +		return true;
> +	}
> +
> +	/*
> +	 * If the device came from DT, assume it is static and then
> +	 * singleton can know from the device count in the group.
> +	 */
> +	return is_of_node(dev_fwnode(dev));

I don't think DT is relevant here because a platform device enumerated
through ACPI will also have its own group. It should be safe to stick to
what the IOMMU drivers declare with their device_group() callback. Except
for PCI those groups should be immutable so we can return true here.

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
