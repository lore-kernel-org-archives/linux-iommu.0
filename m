Return-Path: <SRS0=7Zqx=JL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A284C43461
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 07:24:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA047613B1
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 07:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA047613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ABA0040295;
	Wed, 14 Apr 2021 07:24:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EABygVYhN2NA; Wed, 14 Apr 2021 07:24:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39FF740285;
	Wed, 14 Apr 2021 07:24:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F346EC000B;
	Wed, 14 Apr 2021 07:24:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02F6BC000A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 07:24:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D56F283C00
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 07:24:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xd0OzL3Yl7xl for <iommu@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 07:24:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B496983BE8
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 07:24:14 +0000 (UTC)
IronPort-SDR: 1sntTJolxMjNEvs0SFuRCLBzt/TfYVZUQh2Q1fCMC7dYDqntk282hNARLV8GBeX1IjmvRxf8Ox
 QsUnxpShhswg==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="194611276"
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; d="scan'208";a="194611276"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2021 00:24:13 -0700
IronPort-SDR: 35lROPy9KaI3sWZf4uqKtjH/Qunpt9OTUZ5AFPasffdrQiGF7IKnLpGAMJwBXoXQVlETsZ32D6
 mVt3msA3+Tgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; d="scan'208";a="443720741"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 14 Apr 2021 00:24:09 -0700
Subject: Re: [PATCH v3 02/12] iommu: Add iommu_split_block interface
To: Keqian Zhu <zhukeqian1@huawei.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Yi Sun <yi.y.sun@linux.intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Tian Kevin <kevin.tian@intel.com>
References: <20210413085457.25400-1-zhukeqian1@huawei.com>
 <20210413085457.25400-3-zhukeqian1@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <fb350f27-be8b-80bf-1ce8-e7e8aba26f02@linux.intel.com>
Date: Wed, 14 Apr 2021 15:14:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210413085457.25400-3-zhukeqian1@huawei.com>
Content-Language: en-US
Cc: jiangkunkun@huawei.com, Cornelia Huck <cohuck@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, lushenming@huawei.com,
 Alex Williamson <alex.williamson@redhat.com>, wanghaibin.wang@huawei.com
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

On 4/13/21 4:54 PM, Keqian Zhu wrote:
> Block(largepage) mapping is not a proper granule for dirty log tracking.
> Take an extreme example, if DMA writes one byte, under 1G mapping, the
> dirty amount reported is 1G, but under 4K mapping, the dirty amount is
> just 4K.
> 
> This adds a new interface named iommu_split_block in IOMMU base layer.
> A specific IOMMU driver can invoke it during start dirty log. If so, the
> driver also need to realize the split_block iommu ops.
> 
> We flush all iotlbs after the whole procedure is completed to ease the
> pressure of IOMMU, as we will hanle a huge range of mapping in general.
> 
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
> ---
>   drivers/iommu/iommu.c | 41 +++++++++++++++++++++++++++++++++++++++++
>   include/linux/iommu.h | 11 +++++++++++
>   2 files changed, 52 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 667b2d6d2fc0..bb413a927870 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2721,6 +2721,47 @@ int iommu_domain_set_attr(struct iommu_domain *domain,
>   }
>   EXPORT_SYMBOL_GPL(iommu_domain_set_attr);
>   
> +int iommu_split_block(struct iommu_domain *domain, unsigned long iova,
> +		      size_t size)
> +{
> +	const struct iommu_ops *ops = domain->ops;
> +	unsigned int min_pagesz;
> +	size_t pgsize;
> +	bool flush = false;
> +	int ret = 0;
> +
> +	if (unlikely(!ops || !ops->split_block))
> +		return -ENODEV;
> +
> +	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
> +	if (!IS_ALIGNED(iova | size, min_pagesz)) {
> +		pr_err("unaligned: iova 0x%lx size 0x%zx min_pagesz 0x%x\n",
> +		       iova, size, min_pagesz);
> +		return -EINVAL;
> +	}
> +
> +	while (size) {
> +		flush = true;
> +
> +		pgsize = iommu_pgsize(domain, iova, size);
> +
> +		ret = ops->split_block(domain, iova, pgsize);
> +		if (ret)
> +			break;
> +
> +		pr_debug("split handled: iova 0x%lx size 0x%zx\n", iova, pgsize);
> +
> +		iova += pgsize;
> +		size -= pgsize;
> +	}
> +
> +	if (flush)
> +		iommu_flush_iotlb_all(domain);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_split_block);

Do you really have any consumers of this interface other than the dirty
bit tracking? If not, I don't suggest to make this as a generic IOMMU
interface.

There is an implicit requirement for such interfaces. The
iommu_map/unmap(iova, size) shouldn't be called at the same time.
Currently there's no such sanity check in the iommu core. A poorly
written driver could mess up the kernel by misusing this interface.

This also applies to iommu_merge_page().

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
