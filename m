Return-Path: <SRS0=DnMm=7D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B62AC433E0
	for <iommu@archiver.kernel.org>; Thu, 21 May 2020 23:40:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD5DF207D8
	for <iommu@archiver.kernel.org>; Thu, 21 May 2020 23:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD5DF207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 77692894D1;
	Thu, 21 May 2020 23:40:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xr-FggerHd4c; Thu, 21 May 2020 23:40:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 83677894D2;
	Thu, 21 May 2020 23:40:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DDA6C088A;
	Thu, 21 May 2020 23:40:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9008FC0176
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 23:40:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5939C876C7
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 23:40:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uZTFOZE6o3NL for <iommu@lists.linux-foundation.org>;
 Thu, 21 May 2020 23:40:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EA5B4872B3
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 23:40:52 +0000 (UTC)
IronPort-SDR: 2YsEUysPlkQhyRofeK+qxfpTqtOSNC3PdOLWVS9iqjWbKq244F9xHGWqG5rsXjwceAh9T1TPkT
 kMGoRURgTqaQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2020 16:40:52 -0700
IronPort-SDR: oMV6pdOLmBBvp2tg/0s2cHXMXmtpef4jgFMpno2H4JRWJDg9h3nQBjoD400muqIm8TlxWhzOzA
 IvQNURBpQYgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,419,1583222400"; d="scan'208";a="283229047"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by orsmga002.jf.intel.com with ESMTP; 21 May 2020 16:40:49 -0700
Subject: Re: [PATCH -next] iommu/vt-d: fix a GCC warning
To: Qian Cai <cai@lca.pw>, jroedel@suse.de
References: <20200521215030.16938-1-cai@lca.pw>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <27cf90e4-57bc-38da-fa30-69244f006f63@linux.intel.com>
Date: Fri, 22 May 2020 07:37:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200521215030.16938-1-cai@lca.pw>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
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

Hi Qian,

Thanks!

On 5/22/20 5:50 AM, Qian Cai wrote:
> The commit 6ee1b77ba3ac ("iommu/vt-d: Add svm/sva invalidate function")
> introduced a GCC warning,
> 
> drivers/iommu/intel-iommu.c:5330:1: warning: 'static' is not at beginning of
> declaration [-Wold-style-declaration]
>   const static int
>   ^~~~~
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Fixes: 6ee1b77ba3ac0 ("iommu/vt-d: Add svm/sva invalidate function")
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel-iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index f75d7d9c231f..ff5a30a94679 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5327,7 +5327,7 @@ static void intel_iommu_aux_detach_device(struct iommu_domain *domain,
>    * [IOMMU_CACHE_INV_TYPE_IOTLB][IOMMU_INV_GRANU_ADDR]
>    */
>   
> -const static int
> +static const int
>   inv_type_granu_table[IOMMU_CACHE_INV_TYPE_NR][IOMMU_INV_GRANU_NR] = {
>   	/*
>   	 * PASID based IOTLB invalidation: PASID selective (per PASID),
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
