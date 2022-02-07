Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CE4C433EF
	for <iommu@archiver.kernel.org>; Mon,  7 Feb 2022 10:52:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 066B0813EA;
	Mon,  7 Feb 2022 10:52:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mJQ7QVL5SHF4; Mon,  7 Feb 2022 10:52:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E65E8813DD;
	Mon,  7 Feb 2022 10:51:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF5A8C0011;
	Mon,  7 Feb 2022 10:51:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17EE7C000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 10:51:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 05CA040012
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 10:51:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7EtuMaz7-p4f for <iommu@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 10:51:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D879540272
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 10:51:56 +0000 (UTC)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JsjXS1KShz67xjg;
 Mon,  7 Feb 2022 18:47:52 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Feb 2022 11:51:53 +0100
Received: from [10.47.86.164] (10.47.86.164) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 7 Feb
 2022 10:51:49 +0000
Message-ID: <37dcfcad-ff08-09dd-b35c-a3f90fcaa37f@huawei.com>
Date: Mon, 7 Feb 2022 10:51:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2] iommu/core: Remove comment reference to
 iommu_dev_has_feature
To: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>,
 <matthew.d.roper@intel.com>, <baolu.lu@linux.intel.com>,
 <dri-devel@lists.freedesktop.org>
References: <20220207032322.16667-1-akeem.g.abodunrin@intel.com>
In-Reply-To: <20220207032322.16667-1-akeem.g.abodunrin@intel.com>
X-Originating-IP: [10.47.86.164]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, hch@lst.de
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
From: John Garry via iommu <iommu@lists.linux-foundation.org>
Reply-To: John Garry <john.garry@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 07/02/2022 03:23, Akeem G Abodunrin wrote:
> iommu_dev_has_feature() api has been removed by the commit 262948f8ba573
> ("iommu: Delete iommu_dev_has_feature()") - So this patch removes comment
> about the api to avoid any confusion.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: John Garry <john.garry@huawei.com>

BTW, It looks like we can get rid of iommu_ops.dev_has_feat also.

It does not seem to be called, while arm-smmu-v3 driver does provide a 
callback.

> ---
>   include/linux/iommu.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index de0c57a567c8..bea054f2bd4d 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -153,8 +153,7 @@ struct iommu_resv_region {
>    *			 supported, this feature must be enabled before and
>    *			 disabled after %IOMMU_DEV_FEAT_SVA.
>    *
> - * Device drivers query whether a feature is supported using
> - * iommu_dev_has_feature(), and enable it using iommu_dev_enable_feature().
> + * Device drivers enable the feature via iommu_dev_enable_feature().
>    */
>   enum iommu_dev_features {
>   	IOMMU_DEV_FEAT_AUX,

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
