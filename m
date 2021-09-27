Return-Path: <SRS0=QBaT=OR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0930DC433EF
	for <iommu@archiver.kernel.org>; Mon, 27 Sep 2021 11:34:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE5160F58
	for <iommu@archiver.kernel.org>; Mon, 27 Sep 2021 11:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ADE5160F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 81DEB404C4;
	Mon, 27 Sep 2021 11:34:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4200_lXl6H0m; Mon, 27 Sep 2021 11:34:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 38F05404BC;
	Mon, 27 Sep 2021 11:34:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15115C0011;
	Mon, 27 Sep 2021 11:34:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA497C000D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 11:34:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D5395404BF
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 11:34:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jnz45rrtF2NS for <iommu@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 11:34:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 10FE1404BC
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 11:34:17 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10119"; a="211543655"
X-IronPort-AV: E=Sophos;i="5.85,326,1624345200"; d="scan'208";a="211543655"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2021 04:34:17 -0700
X-IronPort-AV: E=Sophos;i="5.85,326,1624345200"; d="scan'208";a="561186742"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.183])
 ([10.254.212.183])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2021 04:34:10 -0700
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-7-yi.l.liu@intel.com>
 <20210921170943.GS327412@nvidia.com>
 <BN9PR11MB5433DA330D4583387B59AA7F8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922123931.GI327412@nvidia.com>
 <BN9PR11MB5433CE19425E85E7F52093278CA79@BN9PR11MB5433.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC 06/20] iommu: Add iommu_device_init[exit]_user_dma interfaces
Message-ID: <4625393e-6203-2319-9c9f-9f35beb1c04a@linux.intel.com>
Date: Mon, 27 Sep 2021 19:34:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB5433CE19425E85E7F52093278CA79@BN9PR11MB5433.namprd11.prod.outlook.com>
Content-Language: en-US
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021/9/27 17:42, Tian, Kevin wrote:
> +int iommu_device_set_dma_hint(struct device *dev, enum dma_hint hint)
> +{
> +	struct iommu_group *group;
> +	int ret;
> +
> +	group = iommu_group_get(dev);
> +	/* not an iommu-probed device */
> +	if (!group)
> +		return 0;
> +
> +	mutex_lock(&group->mutex);
> +	ret = __iommu_group_viable(group, hint);
> +	mutex_unlock(&group->mutex);
> +
> +	iommu_group_put(group);
> +	return ret;
> +}

Conceptually, we could also move iommu_deferred_attach() from
iommu_dma_ops here to save unnecessary checks in the hot DMA API
paths?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
