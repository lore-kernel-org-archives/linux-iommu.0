Return-Path: <SRS0=VgK/=GP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F7CC433DB
	for <iommu@archiver.kernel.org>; Tue, 12 Jan 2021 04:39:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9094C22287
	for <iommu@archiver.kernel.org>; Tue, 12 Jan 2021 04:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9094C22287
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3E10C8702B;
	Tue, 12 Jan 2021 04:39:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M8CfzYbuptIB; Tue, 12 Jan 2021 04:39:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 74E0787021;
	Tue, 12 Jan 2021 04:39:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57BEBC088B;
	Tue, 12 Jan 2021 04:39:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AFA0C013A
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 04:39:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E648985B73
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 04:39:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BhH9IpvrnXaW for <iommu@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 04:39:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 233E685B12
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 04:39:34 +0000 (UTC)
IronPort-SDR: 6zMoYxK7tXEBtA8svZca4tQPqgOJUeoXcPfen1kEQW3QbwbRaf+7w3TrIQYG9a55Z02e0+QaTC
 mqs5oqtKcmyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="175402166"
X-IronPort-AV: E=Sophos;i="5.79,340,1602572400"; d="scan'208";a="175402166"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2021 20:39:32 -0800
IronPort-SDR: rbtMIpU1AlGux/ENy6x92Hb2JJ7I19FCOibsAEwW3txKgPQT94r1a/Nk8Rt2IbZtTfttbufyMg
 6wmw9cE1hnAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,340,1602572400"; d="scan'208";a="464389805"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
 by fmsmga001.fm.intel.com with ESMTP; 11 Jan 2021 20:39:27 -0800
Subject: Re: [PATCH v9 03/10] iommu: Separate IOMMU_DEV_FEAT_IOPF from
 IOMMU_DEV_FEAT_SVA
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
 will@kernel.org
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-4-jean-philippe@linaro.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <4de8ef03-a2ed-316e-d3e3-6b8474e20113@linux.intel.com>
Date: Tue, 12 Jan 2021 12:31:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210108145217.2254447-4-jean-philippe@linaro.org>
Content-Language: en-US
Cc: vivek.gautam@arm.com, guohanjun@huawei.com, linux-acpi@vger.kernel.org,
 zhangfei.gao@linaro.org, lenb@kernel.org, devicetree@vger.kernel.org, "Tian,
 Kevin" <kevin.tian@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 robin.murphy@arm.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, sudeep.holla@arm.com,
 David Woodhouse <dwmw2@infradead.org>, linux-accelerators@lists.ozlabs.org
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

Hi Jean,

On 1/8/21 10:52 PM, Jean-Philippe Brucker wrote:
> Some devices manage I/O Page Faults (IOPF) themselves instead of relying
> on PCIe PRI or Arm SMMU stall. Allow their drivers to enable SVA without
> mandating IOMMU-managed IOPF. The other device drivers now need to first
> enable IOMMU_DEV_FEAT_IOPF before enabling IOMMU_DEV_FEAT_SVA.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
> Cc: Zhou Wang <wangzhou1@hisilicon.com>
> ---
>   include/linux/iommu.h | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 583c734b2e87..701b2eeb0dc5 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -156,10 +156,24 @@ struct iommu_resv_region {
>   	enum iommu_resv_type	type;
>   };
>   
> -/* Per device IOMMU features */
> +/**
> + * enum iommu_dev_features - Per device IOMMU features
> + * @IOMMU_DEV_FEAT_AUX: Auxiliary domain feature
> + * @IOMMU_DEV_FEAT_SVA: Shared Virtual Addresses
> + * @IOMMU_DEV_FEAT_IOPF: I/O Page Faults such as PRI or Stall. Generally using
> + *			 %IOMMU_DEV_FEAT_SVA requires %IOMMU_DEV_FEAT_IOPF, but
> + *			 some devices manage I/O Page Faults themselves instead
> + *			 of relying on the IOMMU. When supported, this feature
> + *			 must be enabled before and disabled after
> + *			 %IOMMU_DEV_FEAT_SVA.

Is this only for SVA? We may see more scenarios of using IOPF. For
example, when passing through devices to user level, the user's pages
could be managed dynamically instead of being allocated and pinned
statically.

If @IOMMU_DEV_FEAT_IOPF is defined as generic iopf support, the current
vendor IOMMU driver support may not enough.

Best regards,
baolu

> + *
> + * Device drivers query whether a feature is supported using
> + * iommu_dev_has_feature(), and enable it using iommu_dev_enable_feature().
> + */
>   enum iommu_dev_features {
> -	IOMMU_DEV_FEAT_AUX,	/* Aux-domain feature */
> -	IOMMU_DEV_FEAT_SVA,	/* Shared Virtual Addresses */
> +	IOMMU_DEV_FEAT_AUX,
> +	IOMMU_DEV_FEAT_SVA,
> +	IOMMU_DEV_FEAT_IOPF,
>   };
>   
>   #define IOMMU_PASID_INVALID	(-1U)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
