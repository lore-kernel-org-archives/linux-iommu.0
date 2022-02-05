Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406D0C433EF
	for <iommu@archiver.kernel.org>; Sat,  5 Feb 2022 07:15:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D0DBB8315C;
	Sat,  5 Feb 2022 07:15:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FKtOps1K9Tqe; Sat,  5 Feb 2022 07:15:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C94108317B;
	Sat,  5 Feb 2022 07:15:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 904FFC001A;
	Sat,  5 Feb 2022 07:15:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB560C000B
 for <iommu@lists.linux-foundation.org>; Sat,  5 Feb 2022 07:15:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D41E24013D
 for <iommu@lists.linux-foundation.org>; Sat,  5 Feb 2022 07:15:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vZBAOMPygcL6 for <iommu@lists.linux-foundation.org>;
 Sat,  5 Feb 2022 07:15:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1F6FB400BA
 for <iommu@lists.linux-foundation.org>; Sat,  5 Feb 2022 07:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644045339; x=1675581339;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=wqxjsPauSARkDVGNFGjAynKzR2PwO1TvvGupa+oiPS4=;
 b=cFgPqtxXkdhFs2nBh0uRRYyeVohMQFYbYiQ5LaEsf40UexVO5eCtD1MX
 bGafTdx2EnjVzT3USHFl4ACcdjuOeJ8/TPL2K8v9wp5cwvYwdyoq/jRCy
 jB6irBfWeviBy4TmrNaSOipYKHicT1wAboo/AczGk1utiBBqHdx4DbSrC
 HD+1QBjNOanL2Y+MXode/OqYTIwACQ0hvfayKOyX9QNxfZ4ICXiX9CaDy
 D02csKPXbbUWFF0K3hzAxXF0leI0nH3KOSf1lXL2L/W+RABp/YZJzD93t
 IbvUK+qqzK+uXhZ4TMFBkGYBBzoYY/iZWlVha5a0xJmXyWFIkVD8YSwma A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="235893756"
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; d="scan'208";a="235893756"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2022 23:15:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; d="scan'208";a="677305032"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 04 Feb 2022 23:15:36 -0800
Message-ID: <59dac4c6-b238-adb1-75a6-d17a260aa0ee@linux.intel.com>
Date: Sat, 5 Feb 2022 15:14:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] iommu/vt-d: Remove comment reference to
 iommu_dev_has_feature
Content-Language: en-US
To: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>,
 matthew.d.roper@intel.com, dri-devel@lists.freedesktop.org
References: <20220202023743.28135-1-akeem.g.abodunrin@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220202023743.28135-1-akeem.g.abodunrin@intel.com>
Cc: iommu@lists.linux-foundation.org
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

On 2/2/22 10:37 AM, Akeem G Abodunrin wrote:
> iommu_dev_has_feature() api has been removed by the commit 262948f8ba573
> ("iommu: Delete iommu_dev_has_feature()") - So this patch removes comment
> about the api to avoid any confusion.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>

It's not a change for iommu/vt-d, but for iommu core.

Please add Joerg in the to list.

Best regards,
baolu

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
