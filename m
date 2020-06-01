Return-Path: <SRS0=mWFx=7O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5CDC433E0
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 13:13:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 114272074B
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 13:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114272074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D7D70881A4;
	Mon,  1 Jun 2020 13:13:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bpDJPXmIYYk7; Mon,  1 Jun 2020 13:13:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 40629881BF;
	Mon,  1 Jun 2020 13:13:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2AC0FC088C;
	Mon,  1 Jun 2020 13:13:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67598C0176
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 13:13:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4D02A881BF
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 13:13:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZXStBJCcouET for <iommu@lists.linux-foundation.org>;
 Mon,  1 Jun 2020 13:13:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 243FF881A4
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 13:13:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75F2055D;
 Mon,  1 Jun 2020 06:13:54 -0700 (PDT)
Received: from [10.57.29.3] (unknown [10.57.29.3])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA0E93F52E;
 Mon,  1 Jun 2020 06:13:52 -0700 (PDT)
Subject: Re: [PATCH] iommu/arm-smmu-v3: expose numa_node attribute to users in
 sysfs
To: Barry Song <song.bao.hua@hisilicon.com>, will@kernel.org, hch@lst.de,
 m.szyprowski@samsung.com, iommu@lists.linux-foundation.org
References: <20200530091505.56664-1-song.bao.hua@hisilicon.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <4e902884-7ac3-9e79-ec01-f56f2fc5ebad@arm.com>
Date: Mon, 1 Jun 2020 14:13:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200530091505.56664-1-song.bao.hua@hisilicon.com>
Content-Language: en-GB
Cc: linuxarm@huawei.com, linux-arm-kernel@lists.infradead.org
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

On 2020-05-30 10:15, Barry Song wrote:
> As tests show the latency of dma_unmap can increase dramatically while
> calling them cross NUMA nodes, especially cross CPU packages, eg.
> 300ns vs 800ns while waiting for the completion of CMD_SYNC in an
> empty command queue. The large latency causing by remote node will
> in turn make contention of the command queue more serious, and enlarge
> the latency of DMA users within local NUMA nodes.
> 
> Users might intend to enforce NUMA locality with the consideration of
> the position of SMMU. The patch provides minor benefit by presenting
> this information to users directly, as they might want to know it without
> checking hardware spec at all.

Hmm, given that dev-to_node() is a standard driver model thing, is there 
not already some generic device property that can expose it - and if 
not, should there be? Presumably if userspace cares enough to want to 
know whereabouts in the system an IOMMU is, it probably also cares where 
the actual endpoint devices are too.

At the very least, it doesn't seem right for it to be specific to one 
single IOMMU driver.

Robin.

> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>   drivers/iommu/arm-smmu-v3.c | 40 ++++++++++++++++++++++++++++++++++++-
>   1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 82508730feb7..754c4d59498b 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -4021,6 +4021,44 @@ err_reset_pci_ops: __maybe_unused;
>   	return err;
>   }
>   
> +static ssize_t numa_node_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%d\n", dev_to_node(dev));
> +}
> +static DEVICE_ATTR_RO(numa_node);
> +
> +static umode_t arm_smmu_numa_attr_visible(struct kobject *kobj, struct attribute *a,
> +		int n)
> +{
> +	struct device *dev = container_of(kobj, typeof(*dev), kobj);
> +
> +	if (!IS_ENABLED(CONFIG_NUMA))
> +		return 0;
> +
> +	if (a == &dev_attr_numa_node.attr &&
> +			dev_to_node(dev) == NUMA_NO_NODE)
> +		return 0;
> +
> +	return a->mode;
> +}
> +
> +static struct attribute *arm_smmu_dev_attrs[] = {
> +	&dev_attr_numa_node.attr,
> +	NULL
> +};
> +
> +static struct attribute_group arm_smmu_dev_attrs_group = {
> +	.attrs          = arm_smmu_dev_attrs,
> +	.is_visible     = arm_smmu_numa_attr_visible,
> +};
> +
> +
> +static const struct attribute_group *arm_smmu_dev_attrs_groups[] = {
> +	&arm_smmu_dev_attrs_group,
> +	NULL,
> +};
> +
>   static int arm_smmu_device_probe(struct platform_device *pdev)
>   {
>   	int irq, ret;
> @@ -4097,7 +4135,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   		return ret;
>   
>   	/* And we're up. Go go go! */
> -	ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
> +	ret = iommu_device_sysfs_add(&smmu->iommu, dev, arm_smmu_dev_attrs_groups,
>   				     "smmu3.%pa", &ioaddr);
>   	if (ret)
>   		return ret;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
