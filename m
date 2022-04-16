Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F968C433EF
	for <iommu@archiver.kernel.org>; Sat, 16 Apr 2022 00:04:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02A2B841AB;
	Sat, 16 Apr 2022 00:04:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 64426K_-2S88; Sat, 16 Apr 2022 00:04:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F3612841AF;
	Sat, 16 Apr 2022 00:04:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8783C0033;
	Sat, 16 Apr 2022 00:04:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 786EEC002C
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 00:04:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 50626419D6
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 00:04:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 20G7vdsmTOh6 for <iommu@lists.linux-foundation.org>;
 Sat, 16 Apr 2022 00:04:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 86E1B419A5
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 00:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650067489; x=1681603489;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ORZu87hIYWf3otFQvn50x69LdK/rm8I6UEhGlMpo+9U=;
 b=XqPlFDdaT7WQXu56QMCuM3U5ogFizyhzrMcuF2PnYChvX53Mvn6y4Tis
 vgltK5qoQo18evaER3I3IhVr2aOjrsL5EYHmEWOn+bpdHiw0KBVKYJ0jI
 ndKRKDiqWt3E8YMthcGp9AJtmQGOy/X2mgcf0X1TQTyMLxV6XBuhU1vXn
 HFGm+G8erZbvzOdRlGsnKPr/ZTlUdRbixgAJKw53+ue/E59xNxQExs84C
 VHgKUgOPudVnqyxIcCGfIV8nlnqNX3K6Laobm/p595N3BNuNcFYKAcbA8
 XtwA1nugBpvs0O4O4oCa8TlPeihC0mdpVJGuZQHGPUapFhh1ff0UhKhnQ A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="263007082"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; d="scan'208";a="263007082"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2022 17:04:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; d="scan'208";a="574590902"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.123])
 ([10.254.212.123])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2022 17:04:44 -0700
Message-ID: <d838c7f8-2d31-2327-9b4d-c05b06a516bb@linux.intel.com>
Date: Sat, 16 Apr 2022 08:04:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 02/13] iommu: Move bus setup to IOMMU device registration
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1649935679.git.robin.murphy@arm.com>
 <e607a32be8e84c56d65160902f4bd3fb434ee9d3.1649935679.git.robin.murphy@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <e607a32be8e84c56d65160902f4bd3fb434ee9d3.1649935679.git.robin.murphy@arm.com>
Cc: jean-philippe@linaro.org, zhang.lyra@gmail.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org,
 gerald.schaefer@linux.ibm.com
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

On 2022/4/14 20:42, Robin Murphy wrote:
> @@ -1883,27 +1900,12 @@ static int iommu_bus_init(struct bus_type *bus)
>    */
>   int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops)
>   {
> -	int err;
> -
> -	if (ops == NULL) {
> -		bus->iommu_ops = NULL;
> -		return 0;
> -	}
> -
> -	if (bus->iommu_ops != NULL)
> +	if (bus->iommu_ops && ops && bus->iommu_ops != ops)
>   		return -EBUSY;
>   
>   	bus->iommu_ops = ops;

Do we still need to keep above lines in bus_set_iommu()?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
