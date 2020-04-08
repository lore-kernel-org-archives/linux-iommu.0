Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B29C2D0F4
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 19:14:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F5F220768
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 19:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="B5GQRG24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5F220768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2B95B88373;
	Wed,  8 Apr 2020 19:14:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6AuIMdkeKMHs; Wed,  8 Apr 2020 19:14:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7D81388362;
	Wed,  8 Apr 2020 19:14:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 688F3C1AE8;
	Wed,  8 Apr 2020 19:14:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D51BC0177
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 19:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2658888373
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 19:14:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WXhgivayMN+n for <iommu@lists.linux-foundation.org>;
 Wed,  8 Apr 2020 19:14:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C213388362
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 19:14:03 +0000 (UTC)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 038JE0A6026197;
 Wed, 8 Apr 2020 14:14:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1586373240;
 bh=Jan9WiQvt2G9+ylIarIQMuliXA1cCWyxA1RFqWRPzVY=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=B5GQRG24mhTkEdDH5w5DKJ6caXNu+qydPzTDAaJ9msmDCnX/cnjW9tDszzik4JtQH
 Bl8d0uz4DXD+4PuDOM4izIbQtMv2qz/E0kXnWCkd2ItLCQMnb1paNQaEkb1lncA3dx
 Ugu/CEWmfV7AigBK3/loMN3zpRaPbvWEgTuyHU2o=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 038JE0bB110973;
 Wed, 8 Apr 2020 14:14:00 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Apr
 2020 14:14:00 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Apr 2020 14:14:00 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 038JDurk103291;
 Wed, 8 Apr 2020 14:13:57 -0500
Subject: Re: [PATCH] dma-debug: fix displaying of dma allocation type
To: Christoph Hellwig <hch@lst.de>
References: <20200408184804.30522-1-grygorii.strashko@ti.com>
 <20200408184958.GA9945@lst.de>
Message-ID: <ccd0cca4-ca89-3ecd-90d5-66e5e4090f41@ti.com>
Date: Wed, 8 Apr 2020 22:13:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200408184958.GA9945@lst.de>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: Sekhar Nori <nsekhar@ti.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
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
From: Grygorii Strashko via iommu <iommu@lists.linux-foundation.org>
Reply-To: Grygorii Strashko <grygorii.strashko@ti.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 08/04/2020 21:49, Christoph Hellwig wrote:
> On Wed, Apr 08, 2020 at 09:48:04PM +0300, Grygorii Strashko wrote:
>> The commit 2e05ea5cdc1a ("dma-mapping: implement dma_map_single_attrs using
>> dma_map_page_attrs") removed "dma_debug_page" enum, but missed to update
>> type2name string table. This causes incorrect displaying of dma allocation
>> type. Fix it by removing "page" string from type2name string table.
>>
>> Before (dma_alloc_coherent()):
>> k3-ringacc 4b800000.ringacc: scather-gather idx 2208 P=d1140000 N=d114 D=d1140000 L=40 DMA_BIDIRECTIONAL dma map error check not applicable
>> k3-ringacc 4b800000.ringacc: scather-gather idx 2216 P=d1150000 N=d115 D=d1150000 L=40 DMA_BIDIRECTIONAL dma map error check not applicable
>>
>> After:
>> k3-ringacc 4b800000.ringacc: coherent idx 2208 P=d1140000 N=d114 D=d1140000 L=40 DMA_BIDIRECTIONAL dma map error check not applicable
>> k3-ringacc 4b800000.ringacc: coherent idx 2216 P=d1150000 N=d115 D=d1150000 L=40 DMA_BIDIRECTIONAL dma map error check not applicable
>>
>> Fixes: 2e05ea5cdc1a ("dma-mapping: implement dma_map_single_attrs using dma_map_page_attrs")
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>>   kernel/dma/debug.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
>> index 2031ed1ad7fa..09b85ba0c137 100644
>> --- a/kernel/dma/debug.c
>> +++ b/kernel/dma/debug.c
>> @@ -137,7 +137,7 @@ static const char *const maperr2str[] = {
>>   	[MAP_ERR_CHECKED] = "dma map error checked",
>>   };
>>   
>> -static const char *type2name[5] = { "single", "page",
>> +static const char *type2name[5] = { "single",
>>   				    "scather-gather", "coherent",
>>   				    "resource" };
> 
> To make sure this doesn't happen anymore, can you switch to
> named initializers?
> 

Just to clarify.
Do you mean
[dma_debug_coherent] = "coherent",
?


-- 
Best regards,
grygorii
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
