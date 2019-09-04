Return-Path: <SRS0=42j6=W7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B719CC3A5A7
	for <iommu@archiver.kernel.org>; Wed,  4 Sep 2019 09:38:39 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8122622CF7
	for <iommu@archiver.kernel.org>; Wed,  4 Sep 2019 09:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8122622CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 65C221393;
	Wed,  4 Sep 2019 09:38:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F3EC21391
	for <iommu@lists.linux-foundation.org>;
	Wed,  4 Sep 2019 09:38:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7CB8B7DB
	for <iommu@lists.linux-foundation.org>;
	Wed,  4 Sep 2019 09:38:21 +0000 (UTC)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id 86C12F2FF5C3E59212E6;
	Wed,  4 Sep 2019 17:38:19 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS413-HUB.china.huawei.com
	(10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Sep 2019
	17:38:15 +0800
Message-ID: <5D6F8606.8030109@huawei.com>
Date: Wed, 4 Sep 2019 17:38:14 +0800
From: zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64;
	rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 2/3] iommu/pamu: Use kzfree rather than its implementation
References: <1567566079-7412-1-git-send-email-zhongjiang@huawei.com>
	<1567566079-7412-3-git-send-email-zhongjiang@huawei.com>
	<20190904081517.GA29855@8bytes.org>
In-Reply-To: <20190904081517.GA29855@8bytes.org>
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Cc: herbert@gondor.apana.org.au, gregkh@linuxfoundation.org, arno@natisbad.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-crypto@vger.kernel.org, davem@davemloft.net
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 2019/9/4 16:15, Joerg Roedel wrote:
> On Wed, Sep 04, 2019 at 11:01:18AM +0800, zhong jiang wrote:
>> Use kzfree instead of memset() + kfree().
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  drivers/iommu/fsl_pamu.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
>> index cde281b..ca6d147 100644
>> --- a/drivers/iommu/fsl_pamu.c
>> +++ b/drivers/iommu/fsl_pamu.c
>> @@ -1174,10 +1174,8 @@ static int fsl_pamu_probe(struct platform_device *pdev)
>>  	if (irq != NO_IRQ)
>>  		free_irq(irq, data);
>>  
>> -	if (data) {
>> -		memset(data, 0, sizeof(struct pamu_isr_data));
>> -		kfree(data);
>> -	}
>> +	if (data)
>> +		kzfree(data);
> kzfree() is doing its own NULL-ptr check, no need to do it here.
Yep,   we should also remove the condition before kzfree.  will repost.

Thanks,
zhong jiang
> Regards,
>
> 	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
