Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7656FC433EF
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 19:52:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33BAE83FF4;
	Tue, 31 May 2022 19:52:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sazBAFhhzWEq; Tue, 31 May 2022 19:52:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 30AD383F82;
	Tue, 31 May 2022 19:52:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08153C0032;
	Tue, 31 May 2022 19:52:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C59CEC002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 19:52:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B3DC141BE2
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 19:52:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=cybernetics.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vfv7dm7BSgyG for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 19:52:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 600C3415F8
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 19:52:42 +0000 (UTC)
X-ASG-Debug-ID: 1654026760-1cf43917f334bc90001-DtgJuY
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with
 ESMTP id QMvSFwNwLMI2vW0s; Tue, 31 May 2022 15:52:40 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=cybernetics.com; s=mail; 
 bh=zaY0KN5bbdhdGj5w5iqbSpBFgDXMIwvTrwlB06Godyg=;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Content-Language:Subject:MIME-Version:Date:Message-ID; b=IFInqWoaVpE2F1jFz/+r
 jyb5wPZuz63wZQg6jpwm5m5ElcALvbK5NO5QskKNmwuWJqfKc7YaZ42NFF6+NjJ5DgR2mrihQ4ZoU
 x8Ap/beCyzlKBxutxj/P1Vc3ktqab1UlduPF13iLWKWhPHdW1PP3PM6YtKmCrknWqgNBRiomNQ=
Received: from [10.157.2.224] (HELO [192.168.200.1])
 by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
 with ESMTPS id 11829739; Tue, 31 May 2022 15:52:40 -0400
Message-ID: <a57d3dde-ac45-be9c-5c16-263415060334@cybernetics.com>
Date: Tue, 31 May 2022 15:52:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 04/10] dmapool: improve accuracy of debug statistics
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH 04/10] dmapool: improve accuracy of debug
 statistics
To: Robin Murphy <robin.murphy@arm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
 <a922c30f-d6d7-dde2-554f-254441290331@cybernetics.com>
 <b97645ed-b524-a505-2993-e04a37b50d35@arm.com>
From: Tony Battersby <tonyb@cybernetics.com>
In-Reply-To: <b97645ed-b524-a505-2993-e04a37b50d35@arm.com>
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1654026760
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 1028
Cc: Tony Lindgren <tony@atomide.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, iommu@lists.linux-foundation.org,
 Keith Busch <kbusch@kernel.org>, kernel-team@fb.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 5/31/22 15:48, Robin Murphy wrote:
> On 2022-05-31 19:17, Tony Battersby wrote:
>
>>   				 pool->name, blocks,
>> -				 (size_t) pages *
>> -				 (pool->allocation / pool->size),
>> +				 (size_t) pages * pool->blks_per_alloc,
>>   				 pool->size, pages);
>>   		size -= temp;
>>   		next += temp;
>> @@ -168,6 +168,9 @@ struct dma_pool *dma_pool_create(const char *name, struct device *dev,
>>   	retval->size = size;
>>   	retval->boundary = boundary;
>>   	retval->allocation = allocation;
>> +	retval->blks_per_alloc =
>> +		(allocation / boundary) * (boundary / size) +
>> +		(allocation % boundary) / size;
> Do we really need to store this? Sure, 4 divisions (which could possibly 
> be fewer given the constraints on boundary) isn't the absolute cheapest 
> calculation, but I still can't imagine anyone would be polling sysfs 
> stats hard enough to even notice.
>
The stored value is also used in patch #5, in more performance-critical
code, although only when debug is enabled.

Tony

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
