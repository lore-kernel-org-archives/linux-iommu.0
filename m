Return-Path: <SRS0=IFPa=LQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BB7C49EA4
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 02:05:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC5160FE9
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 02:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC5160FE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8EC3B4026C;
	Tue, 22 Jun 2021 02:05:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PVIbTaKOh5H0; Tue, 22 Jun 2021 02:05:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 90AAE4026B;
	Tue, 22 Jun 2021 02:05:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6022DC001A;
	Tue, 22 Jun 2021 02:05:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C76BC000E
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 02:05:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 09DB340322
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 02:05:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 29EkwNAamPwX for <iommu@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 02:05:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E003C40233
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 02:05:24 +0000 (UTC)
IronPort-SDR: WU9mSkdXz2acRsASt2qpgrToFWMqjTFvunym418PxVuVfM78Q0/MOfp/S+Jkpe3EvOQZn0Z6U5
 jrh5SohXGTLw==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="203955520"
X-IronPort-AV: E=Sophos;i="5.83,290,1616482800"; d="scan'208";a="203955520"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2021 19:05:24 -0700
IronPort-SDR: dLdw0mYa572hkEWgSGeMhCBpF7mlTIUXdEFSv85ioGGyeb0SniKyr3vmVizlAGg4dgBU+dFXJA
 S/uIZjF15L1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,290,1616482800"; d="scan'208";a="490101021"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga002.fm.intel.com with ESMTP; 21 Jun 2021 19:05:18 -0700
Subject: Re: [PATCH 4/6] iommu: Combine device strictness requests with the
 global default
To: Douglas Anderson <dianders@chromium.org>, gregkh@linuxfoundation.org,
 rafael@kernel.org, rafael.j.wysocki@intel.com, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, bjorn.andersson@linaro.org,
 ulf.hansson@linaro.org, adrian.hunter@intel.com, bhelgaas@google.com
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.4.Id84a954e705fcad3fdb35beb2bc372e4bf2108c7@changeid>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a86c2f9c-f66a-3a12-cf80-6e3fc6dafda4@linux.intel.com>
Date: Tue, 22 Jun 2021 10:03:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210621165230.4.Id84a954e705fcad3fdb35beb2bc372e4bf2108c7@changeid>
Content-Language: en-US
Cc: robdclark@chromium.org, saravanak@google.com, linux-arm-msm@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_c_gdjako@quicinc.com, iommu@lists.linux-foundation.org,
 linux-pci@vger.kernel.org, joel@joelfernandes.org, rajatja@google.com,
 sonnyrao@chromium.org, vbadigan@codeaurora.org
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

On 6/22/21 7:52 AM, Douglas Anderson wrote:
> @@ -1519,7 +1542,8 @@ static int iommu_get_def_domain_type(struct device *dev)
>   
>   static int iommu_group_alloc_default_domain(struct bus_type *bus,
>   					    struct iommu_group *group,
> -					    unsigned int type)
> +					    unsigned int type,
> +					    struct device *dev)
>   {
>   	struct iommu_domain *dom;
>   
> @@ -1534,6 +1558,12 @@ static int iommu_group_alloc_default_domain(struct bus_type *bus,
>   	if (!dom)
>   		return -ENOMEM;
>   
> +	/* Save the strictness requests from the device */
> +	if (dev && type == IOMMU_DOMAIN_DMA) {
> +		dom->request_non_strict = dev->request_non_strict_iommu;
> +		dom->force_strict = dev->force_strict_iommu;
> +	}
> +

An iommu default domain might be used by multiple devices which might
have different "strict" attributions. Then who could override who?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
