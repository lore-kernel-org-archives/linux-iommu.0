Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE76C433F5
	for <iommu@archiver.kernel.org>; Mon,  7 Feb 2022 18:24:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C89C813BB;
	Mon,  7 Feb 2022 18:24:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a1SSCm_KPt7g; Mon,  7 Feb 2022 18:24:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 388DF81329;
	Mon,  7 Feb 2022 18:24:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A4B2C0011;
	Mon,  7 Feb 2022 18:24:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76430C000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 18:24:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1AE9460AFB
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 18:24:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lbt5Jl2sTXkj for <iommu@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 18:24:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0215060783
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 18:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644258271; x=1675794271;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+g3d/khpgpbVGXsUIHT4OSkqD8lvmSb0Jeo3mZpjGic=;
 b=PXr33cugTJVKB3ooO+5OtgD3clO8wk7CsQIiaZzJpdDnC4bkw2GJIEv+
 WntDmJtLvsw92lhvryhhpC1FQMe6niJ/+z3JMbLmDJrCi5JlW+QexoTQ9
 KrH8BShtEhLIgp8eU/k8h9d2bg+/DodrGBnqkGDqHIJ3zvU9ekLl55zqE
 kb8Stm7nLScvJndn+Sd51mg1D5CUw7hfhs6Q1XDPajifvJpdJUrEn2Na3
 oFLljaA5KONzi2sOMZYf6S72VWpa/yUA8qgqsOUBkh5FjOnp9xJsZtkYc
 OHfhzM6HUUOeX0yGoE2joUn8Tv/6aB+NyMBX8eyGLBEaxm39xoxdlZi2X Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="228748659"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; d="scan'208";a="228748659"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2022 10:24:30 -0800
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; d="scan'208";a="499290647"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2022 10:24:29 -0800
Date: Mon, 7 Feb 2022 10:27:25 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1 09/10] iommu/vt-d: Refactor dmar_insert_one_dev_info()
Message-ID: <20220207102725.3ce9320d@jacob-builder>
In-Reply-To: <20220207064142.1092846-10-baolu.lu@linux.intel.com>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
 <20220207064142.1092846-10-baolu.lu@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

Hi BaoLu,

On Mon,  7 Feb 2022 14:41:41 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

>  static void intel_iommu_release_device(struct device *dev)
>  {
> -	struct intel_iommu *iommu;
> -
> -	iommu = device_to_iommu(dev, NULL, NULL);
> -	if (!iommu)
> -		return;
> -
> -	dmar_remove_one_dev_info(dev);
> +	struct device_domain_info *info = get_domain_info(dev);
> +	unsigned long index = DEVI_IDX(info->segment, info->bus,
> info->devfn); 
> +	xa_erase(&device_domain_array, index);
> +	dev_iommu_priv_set(info->dev, NULL);
>  	set_dma_ops(dev, NULL);
> +	kfree(info);
Now that info and sinfo are under RCU, should we use kfree_rcu?

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
