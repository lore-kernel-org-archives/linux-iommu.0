Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F66C47096
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 17:05:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B302A613C9
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 17:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B302A613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D8ED405F7;
	Thu,  3 Jun 2021 17:05:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KZQi6jjx_6rX; Thu,  3 Jun 2021 17:04:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id A307E405C7;
	Thu,  3 Jun 2021 17:04:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8693BC000D;
	Thu,  3 Jun 2021 17:04:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62276C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 17:04:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3B0D583D17
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 17:04:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HL2AS6afcLQj for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 17:04:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5D61D82B1B
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 17:04:51 +0000 (UTC)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FwsXl6FVKz6V03M;
 Fri,  4 Jun 2021 00:58:15 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 19:04:48 +0200
Received: from [10.47.80.115] (10.47.80.115) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 3 Jun 2021
 18:04:47 +0100
Subject: Re: [PATCH v10 1/3] iommu: Enhance IOMMU default DMA mode build
 options
To: Randy Dunlap <rdunlap@infradead.org>, <joro@8bytes.org>,
 <will@kernel.org>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <robin.murphy@arm.com>
References: <1622728715-209296-1-git-send-email-john.garry@huawei.com>
 <1622728715-209296-2-git-send-email-john.garry@huawei.com>
 <c8107ae9-b099-459f-eea4-b9b5a0929ee2@infradead.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <18764b43-6c60-eb6d-783f-b7d4fe146b8e@huawei.com>
Date: Thu, 3 Jun 2021 18:04:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <c8107ae9-b099-459f-eea4-b9b5a0929ee2@infradead.org>
Content-Language: en-US
X-Originating-IP: [10.47.80.115]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com
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

On 03/06/2021 18:00, Randy Dunlap wrote:
>> +config IOMMU_DEFAULT_STRICT
>> +	bool "strict"
>> +	help
>> +	  For every IOMMU DMA unmap operation, the flush operation of IOTLB and
>> +	  the free operation of IOVA are guaranteed to be done in the unmap
>> +	  function.
>> +
>> +	  This mode is safer than the two above, but it maybe slower in some
> There don't seem to be two above?
> 

Right, it's a remnant from a previous version - will fix, pending other 
reviews

>> +	  high performace scenarios.
> 	       performance
> 

ok

>> +
>> +endchoice

Thanks!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
