Return-Path: <SRS0=GV0T=MW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50019C4338F
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 09:33:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA76060F5C
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 09:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DA76060F5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9AA5C40258;
	Fri, 30 Jul 2021 09:33:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JaM46DFU--BH; Fri, 30 Jul 2021 09:33:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4E1E040241;
	Fri, 30 Jul 2021 09:33:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B2F1C001A;
	Fri, 30 Jul 2021 09:33:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A5E3C000E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 09:33:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7CCD183B65
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 09:33:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hRz1yRmoxSjU for <iommu@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 09:33:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 52F2C824A4
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 09:33:54 +0000 (UTC)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gbhf73wM6z6JBCT;
 Fri, 30 Jul 2021 17:18:39 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 30 Jul 2021 11:33:51 +0200
Received: from [10.47.25.95] (10.47.25.95) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 30 Jul
 2021 10:33:50 +0100
Subject: Re: [PATCH v2 20/24] iommu: Merge strictness and domain type configs
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
References: <cover.1627468308.git.robin.murphy@arm.com>
 <992b2952f0b173411c7b6f221dce82e8e082c0b8.1627468310.git.robin.murphy@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <a30a4d50-e798-c2d1-73a3-5b53fef2f75f@huawei.com>
Date: Fri, 30 Jul 2021 10:33:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <992b2952f0b173411c7b6f221dce82e8e082c0b8.1627468310.git.robin.murphy@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.25.95]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: dianders@chromium.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

On 28/07/2021 16:58, Robin Murphy wrote:
>   
> -config IOMMU_DEFAULT_LAZY
> -	bool "lazy"
> +	  Untrusted devices always use this mode, with an additional layer of
> +	  bounce-buffering such that they cannot gain access to any unrelated
> +	  data within a mapped page.
> +
> +config IOMMU_DEFAULT_DMA_LAZY
> +	bool "Translated - Lazy"
>   	help

Since these are being renamed, can you update the kernel-parameters.txt:


	iommu.strict=	[ARM64, X86] Configure TLB invalidation behaviour


....
		  DMA unmap operations invalidate IOMMU hardware TLBs
		  synchronously.
		unset - Use value of CONFIG_IOMMU_DEFAULT_{LAZY,STRICT}.

					^^^^^

Thanks
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
