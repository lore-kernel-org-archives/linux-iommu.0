Return-Path: <SRS0=AdPL=CY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0860C433E2
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 15:14:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA4620770
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 15:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ykc5JfKy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA4620770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C671484D62;
	Tue, 15 Sep 2020 15:14:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AK6u1EKv-FKz; Tue, 15 Sep 2020 15:14:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id ABF0885008;
	Tue, 15 Sep 2020 15:13:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9575FC0864;
	Tue, 15 Sep 2020 15:13:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71149C0051
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 15:13:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5A7798671F
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 15:13:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CEPnn2bHiFbG for <iommu@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 15:13:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 390B986749
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 15:12:41 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FF4Ntu149991;
 Tue, 15 Sep 2020 15:12:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=OomBHSXo/Y1LDw5jEcMC2p6v5dx4Welq368VU3lWhic=;
 b=Ykc5JfKyNgOplXd5wkSLoaADDe/tMn1SYfFz4YSf7ed6O8hFwndcrvjriyILS/3kg5Ie
 100v0AJRpvaEAkF217udpkPwP78ZQfwAYlD2aWChql3wpcIoCtMROIzbSci4zq6KcoLt
 LcUaSG81M5YmQ6CBnEDCX8FqFjulaaYAabAr2pvT7esZxX5Gh/UIwOLmTN/J6eS18/KN
 KzBRaTlP829nGzL4vpoI7pyG7Zt0vHl/ZTYZI9IDbGb1c6XeJxOARPaiF/bCOOaz4fHV
 xxSj7vjBTDt9LJzZ06/V7WRxzWLI/7GziCkY92xFuH8Q6UGxYILYYuxt09ogDeGCQvyY dA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 33j91dfa98-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Sep 2020 15:12:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FF4hWO188266;
 Tue, 15 Sep 2020 15:12:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 33h88yg466-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Sep 2020 15:12:29 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08FFCRU5009088;
 Tue, 15 Sep 2020 15:12:27 GMT
Received: from [10.39.253.102] (/10.39.253.102)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 15 Sep 2020 15:12:27 +0000
Subject: Re: [PATCH] dma-direct: Fix potential NULL pointer dereference
To: Christoph Hellwig <hch@lst.de>
References: <1600178594-22801-1-git-send-email-thomas.tai@oracle.com>
 <20200915140719.GA14831@lst.de>
 <f5cba632-421a-f375-3697-51a182a53a32@oracle.com>
 <20200915142624.GA16005@lst.de>
 <da9ec51d-aab5-695d-e388-5ae7c0bb30ea@oracle.com>
 <20200915150929.GA19770@lst.de>
From: Thomas Tai <thomas.tai@oracle.com>
Message-ID: <9a819530-365b-9982-c9c9-ad20d6c8149e@oracle.com>
Date: Tue, 15 Sep 2020 11:12:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200915150929.GA19770@lst.de>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9744
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009150127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150127
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

Ok. That sounds good to me. I will make the suggested changes and run 
some tests before sending out the V2 patch.

Thank you,
Thomas
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
