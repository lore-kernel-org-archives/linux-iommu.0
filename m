Return-Path: <SRS0=AdPL=CY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36173C43461
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 20:46:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0C6F20809
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 20:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jO71LRkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C6F20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 838A586B15;
	Tue, 15 Sep 2020 20:46:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RVtxCogXKNEn; Tue, 15 Sep 2020 20:46:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E69C086B1C;
	Tue, 15 Sep 2020 20:46:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2E17C0859;
	Tue, 15 Sep 2020 20:46:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6EF21C0051
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 20:46:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 57B80843EE
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 20:46:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ruieYYgwZA6F for <iommu@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 20:46:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BF01F86440
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 20:46:29 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FKdbd2086901;
 Tue, 15 Sep 2020 20:46:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=FmTz2fljRnoXwjllRl7fwASoDuhxx7pfhTKjMnx4SHY=;
 b=jO71LRkJPcAd11zSY1cRJVgUOCkoRNU82iNNWVF9pU6g0CAytZIab8/VDMxp+tis2DdM
 qMzCi8O/YwLIuRHgf0qjVz9sIHoNiSq5DmfkBoPYYBNKX22uzTTEWXEP9WsXzxvXce5S
 kChgRldBjUStVy1cVX3KcWl1BpOx1XssKqyVrx/+hYuw49hMrXgskrSXnebgXoJzRy/7
 C0apyML7V6f+5vYWuyICyHY7m68rYtGQUm+OgvmVWmFDMP0HcIrBliqzU6tp4laz+9nn
 uCC1CyhSuEt4lwQZH4ipGq1KyNNGXsaBB8sEprnBQo0OdlwaTxxp1A/d6qBu5ZbvW30o vA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 33gnrqyj1v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Sep 2020 20:46:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FKjpkX008110;
 Tue, 15 Sep 2020 20:46:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 33hm318bdx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Sep 2020 20:46:24 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08FKkIIj019081;
 Tue, 15 Sep 2020 20:46:18 GMT
Received: from [192.168.0.14] (/108.168.44.57)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 15 Sep 2020 20:46:18 +0000
Subject: Re: [PATCH] dma-direct: Fix potential NULL pointer dereference
To: Christoph Hellwig <hch@lst.de>
References: <1600178594-22801-1-git-send-email-thomas.tai@oracle.com>
 <20200915140719.GA14831@lst.de>
 <f5cba632-421a-f375-3697-51a182a53a32@oracle.com>
 <20200915142624.GA16005@lst.de>
 <da9ec51d-aab5-695d-e388-5ae7c0bb30ea@oracle.com>
 <20200915150929.GA19770@lst.de>
From: Thomas Tai <thomas.tai@oracle.com>
Message-ID: <5136ed8d-d37d-8144-a6f3-c23f272d8926@oracle.com>
Date: Tue, 15 Sep 2020 16:46:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200915150929.GA19770@lst.de>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009150163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150162
Cc: iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, konrad.wilk@oracle.com
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



On 2020-09-15 11:09 a.m., Christoph Hellwig wrote:
> On Tue, Sep 15, 2020 at 10:40:39AM -0400, Thomas Tai wrote:
>>> +++ b/include/linux/dma-direct.h
>>> @@ -62,9 +62,6 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
>>>    {
>>>    	dma_addr_t end = addr + size - 1;
>>>    -	if (!dev->dma_mask)
>>> -		return false;
>>> -
>>
>> I am concerned that some drivers may rely on this NULL checking. Would you
>> think we can keep this checking and use the following WARN_ON_ONCE()?
> 
> dma_capable is not a helper for drivers, but just for dma-direct
> and related code.  And this patch adds the checks for the three
> places how we call into the ->map* methods.
> 

Hi Christoph,
I tried out the suggested changes, and it successfully warned the null 
pointer without panic. I notice that there are some places outside the 
dma-direct, which calls dma_capable().

https://elixir.bootlin.com/linux/v5.9-rc5/source/arch/x86/kernel/amd_gart_64.c#L187

https://elixir.bootlin.com/linux/v5.9-rc5/source/drivers/xen/swiotlb-xen.c#L387

Also, if I remove the null checking in dma_capable(), I may run into the 
risk of a null pointer dereference within the function.

@@ -62,9 +62,6 @@ static inline bool dma_capable(struct device *dev, 
dma_addr_t addr, size_t size,
  {
  	dma_addr_t end = addr + size - 1;

-	if (!dev->dma_mask)
-		return false;
-
  	if (is_ram && !IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT) &&
  	    min(addr, end) < phys_to_dma(dev, PFN_PHYS(min_low_pfn)))
  		return false;
	
	return end <= min_not_zero(*dev->dma_mask, dev->bus_dma_limit);
                                     ^
                                     |
                                     ** risk of a null dereference **
}


Given that the WARN_ON_ONCE already did the intended warning, would you 
be ok that I keep the null checking in dma_capable()?

Thank you,
Thomas

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
