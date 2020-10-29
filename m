Return-Path: <SRS0=7pZu=EE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67EEC55178
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 10:21:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3927820719
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 10:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3927820719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B060584B96;
	Thu, 29 Oct 2020 10:21:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uuotBk-d6CkR; Thu, 29 Oct 2020 10:21:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7956287590;
	Thu, 29 Oct 2020 10:21:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BC9BC0859;
	Thu, 29 Oct 2020 10:21:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCFFEC0051
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 10:21:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B35F887593
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 10:21:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EwCKcEmDctk2 for <iommu@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 10:21:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id C257B87590
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 10:21:22 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1579D139F;
 Thu, 29 Oct 2020 03:21:22 -0700 (PDT)
Received: from [10.57.54.223] (unknown [10.57.54.223])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D42E63F66E;
 Thu, 29 Oct 2020 03:21:20 -0700 (PDT)
Subject: Re: [PATCH] iommu/sun50i: check return value of
 of_find_device_by_node() in sun50i_iommu_of_xlate()
To: Yu Kuai <yukuai3@huawei.com>, joro@8bytes.org, mripard@kernel.org,
 wens@csie.org
References: <20201029092244.900564-1-yukuai3@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <2c2669d1-7f19-5be4-b6df-7cf896015336@arm.com>
Date: Thu, 29 Oct 2020 10:21:19 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201029092244.900564-1-yukuai3@huawei.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, yi.zhang@huawei.com
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

On 2020-10-29 09:22, Yu Kuai wrote:
> If of_find_device_by_node() failed in sun50i_iommu_of_xlate(), null
> pointer dereference will be triggered. Thus return error code if
> of_find_device_by_node() failed.

Again, by what means can that ever actually happen?

Robin.

> Fixes: 4100b8c229b3("iommu: Add Allwinner H6 IOMMU driver")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/iommu/sun50i-iommu.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
> index ea6db1341916..ce94ffa15215 100644
> --- a/drivers/iommu/sun50i-iommu.c
> +++ b/drivers/iommu/sun50i-iommu.c
> @@ -764,6 +764,9 @@ static int sun50i_iommu_of_xlate(struct device *dev,
>   	struct platform_device *iommu_pdev = of_find_device_by_node(args->np);
>   	unsigned id = args->args[0];
>   
> +	if (!iommu_pdev)
> +		return -ENODEV;
> +
>   	dev_iommu_priv_set(dev, platform_get_drvdata(iommu_pdev));
>   
>   	return iommu_fwspec_add_ids(dev, &id, 1);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
