Return-Path: <SRS0=Uk+I=T5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36618C28CC0
	for <iommu@archiver.kernel.org>; Wed, 29 May 2019 15:45:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 178A523BB7
	for <iommu@archiver.kernel.org>; Wed, 29 May 2019 15:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178A523BB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A91822430;
	Wed, 29 May 2019 15:45:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 61939268B
	for <iommu@lists.linux-foundation.org>;
	Wed, 29 May 2019 15:38:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 17BAA7D2
	for <iommu@lists.linux-foundation.org>;
	Wed, 29 May 2019 15:38:27 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D31F30C0DC4;
	Wed, 29 May 2019 15:38:26 +0000 (UTC)
Received: from [10.36.116.67] (ovpn-116-67.ams2.redhat.com [10.36.116.67])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D53DE5C64D;
	Wed, 29 May 2019 15:38:16 +0000 (UTC)
Subject: Re: [PATCH v5 1/7] iommu: Fix a leak in iommu_insert_resv_region
To: Christoph Hellwig <hch@infradead.org>
References: <20190528115025.17194-1-eric.auger@redhat.com>
	<20190528115025.17194-2-eric.auger@redhat.com>
	<20190529061756.GB26055@infradead.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <c4edcb80-4003-7a1c-fca1-cad25436a5ad@redhat.com>
Date: Wed, 29 May 2019 17:38:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190529061756.GB26055@infradead.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Wed, 29 May 2019 15:38:26 +0000 (UTC)
Cc: alex.williamson@redhat.com, jean-philippe.brucker@arm.com,
	dwmw2@infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, robin.murphy@arm.com,
	eric.auger.pro@gmail.com
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

Hi Christoph,

On 5/29/19 8:17 AM, Christoph Hellwig wrote:
>>  		} else if ((start >= a) && (end <= b)) {
>>  			if (new->type == type)
>> -				goto done;
>> +				return 0;
>>  			else
>>  				pos = pos->next;
> 
> Please remove the pointless else after the return statement.
Sorry I don't get your point here. For both cases, we only return if
both types match. Otherwise we continue parsing the list as there may be
a region of the same type as @new following the current interval that
may need to be merged with @new. Let's consider the insertion of those
resv regions:

add_resv(head, 0xa001000, 0xa001FFF, IOMMU_RESV_TYPE1);
head -> 0x000000000a001000 0x000000000a001fff type1

add_resv(head, 0xa003000, 0xa003FFF, IOMMU_RESV_TYPE1);
head ->
0x000000000a001000 0x000000000a001fff type1 ->
0x000000000a003000 0x000000000a003fff type1

add_resv(head, 0xa002000, 0xa004FFF, IOMMU_RESV_TYPE2);
head ->
0x000000000a001000 0x000000000a001fff type1 ->
0x000000000a003000 0x000000000a003fff type1 ->
0x000000000a002000 0x000000000a004fff type2 ->

add_resv(head, 0xa0010FF, 0xa003000, IOMMU_RESV_TYPE2);

head ->
0x000000000a001000 0x000000000a001fff type1 ->
0x000000000a003000 0x000000000a003fff type1 ->
0x000000000a0010ff 0x000000000a004fff type2 <- merge

Or maybe I simply missed your point. Please let me know.

Thanks

Eric

> 
>>  		} else {
>>  			if (new->type == type) {
>>  				phys_addr_t new_start = min(a, start);
>>  				phys_addr_t new_end = max(b, end);
>> +				int ret;
>>  
>>  				list_del(&entry->list);
>>  				entry->start = new_start;
>>  				entry->length = new_end - new_start + 1;
>> -				iommu_insert_resv_region(entry, regions);
>> +				ret = iommu_insert_resv_region(entry, regions);
>> +				kfree(entry);
>> +				return ret;
>>  			} else {
>>  				pos = pos->next;
>>  			}
> 
> Same here.
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
