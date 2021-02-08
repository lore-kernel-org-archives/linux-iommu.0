Return-Path: <SRS0=aVDl=HK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCC4C433DB
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 08:22:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D7FF64E82
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 08:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D7FF64E82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 01CDF203E2;
	Mon,  8 Feb 2021 08:22:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CWqV4c5ajEPG; Mon,  8 Feb 2021 08:22:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 89BE820356;
	Mon,  8 Feb 2021 08:22:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75EB7C0174;
	Mon,  8 Feb 2021 08:22:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DBFBC013A
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 08:21:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4A2CC858B8
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 08:21:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x47MyjBGXi4u for <iommu@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 08:21:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 14048857CB
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 08:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612772515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJj/eM72zDKRzFdR3uq7IOOzFEK9yZtZ/1IHJ8Iiu80=;
 b=T9FOA9eOG1+AFbwsOlJujTJ2rS5/iWA9VAhV4m/lcSb/vy8pxpkw8qtyLQc9QsoEQgYcUx
 0LsgeiWsECraP8JSiA98bBEGI85xAkqvNYLcrDKJDOHfQB4+EGaJvxgtmH69XPFoJMsehO
 dZseg7mtbyvkavxW0WUBhr9CMu2Tipk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-wnE7NQ8nMlC-J6d6ylO5cA-1; Mon, 08 Feb 2021 03:21:51 -0500
X-MC-Unique: wnE7NQ8nMlC-J6d6ylO5cA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 805A4801962;
 Mon,  8 Feb 2021 08:21:49 +0000 (UTC)
Received: from [10.36.113.240] (ovpn-113-240.ams2.redhat.com [10.36.113.240])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1004AE14E;
 Mon,  8 Feb 2021 08:21:42 +0000 (UTC)
To: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
 Matthew Wilcox <willy@infradead.org>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
 <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <20210207213409.GL308988@casper.infradead.org>
 <f4b2d7db8a1047d9952cbbfaf9e27824@hisilicon.com>
 <20210208013056.GM308988@casper.infradead.org>
 <b4e2acc237e44ffe916135e96ad3ef20@hisilicon.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory pin
Message-ID: <beb4dfb5-e9d2-a76c-f965-28cff5e4658b@redhat.com>
Date: Mon, 8 Feb 2021 09:21:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <b4e2acc237e44ffe916135e96ad3ef20@hisilicon.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "chensihang \(A\)" <chensihang1@hisilicon.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liguozhu \(Kenneth\)" <liguozhu@hisilicon.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On 08.02.21 03:27, Song Bao Hua (Barry Song) wrote:
> 
> 
>> -----Original Message-----
>> From: owner-linux-mm@kvack.org [mailto:owner-linux-mm@kvack.org] On Behalf Of
>> Matthew Wilcox
>> Sent: Monday, February 8, 2021 2:31 PM
>> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
>> Cc: Wangzhou (B) <wangzhou1@hisilicon.com>; linux-kernel@vger.kernel.org;
>> iommu@lists.linux-foundation.org; linux-mm@kvack.org;
>> linux-arm-kernel@lists.infradead.org; linux-api@vger.kernel.org; Andrew
>> Morton <akpm@linux-foundation.org>; Alexander Viro <viro@zeniv.linux.org.uk>;
>> gregkh@linuxfoundation.org; jgg@ziepe.ca; kevin.tian@intel.com;
>> jean-philippe@linaro.org; eric.auger@redhat.com; Liguozhu (Kenneth)
>> <liguozhu@hisilicon.com>; zhangfei.gao@linaro.org; chensihang (A)
>> <chensihang1@hisilicon.com>
>> Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
>> pin
>>
>> On Sun, Feb 07, 2021 at 10:24:28PM +0000, Song Bao Hua (Barry Song) wrote:
>>>>> In high-performance I/O cases, accelerators might want to perform
>>>>> I/O on a memory without IO page faults which can result in dramatically
>>>>> increased latency. Current memory related APIs could not achieve this
>>>>> requirement, e.g. mlock can only avoid memory to swap to backup device,
>>>>> page migration can still trigger IO page fault.
>>>>
>>>> Well ... we have two requirements.  The application wants to not take
>>>> page faults.  The system wants to move the application to a different
>>>> NUMA node in order to optimise overall performance.  Why should the
>>>> application's desires take precedence over the kernel's desires?  And why
>>>> should it be done this way rather than by the sysadmin using numactl to
>>>> lock the application to a particular node?
>>>
>>> NUMA balancer is just one of many reasons for page migration. Even one
>>> simple alloc_pages() can cause memory migration in just single NUMA
>>> node or UMA system.
>>>
>>> The other reasons for page migration include but are not limited to:
>>> * memory move due to CMA
>>> * memory move due to huge pages creation
>>>
>>> Hardly we can ask users to disable the COMPACTION, CMA and Huge Page
>>> in the whole system.
>>
>> You're dodging the question.  Should the CMA allocation fail because
>> another application is using SVA?
>>
>> I would say no.
> 
> I would say no as well.
> 
> While IOMMU is enabled, CMA almost has one user only: IOMMU driver
> as other drivers will depend on iommu to use non-contiguous memory
> though they are still calling dma_alloc_coherent().
> 
> In iommu driver, dma_alloc_coherent is called during initialization
> and there is no new allocation afterwards. So it wouldn't cause
> runtime impact on SVA performance. Even there is new allocations,
> CMA will fall back to general alloc_pages() and iommu drivers are
> almost allocating small memory for command queues.
> 
> So I would say general compound pages, huge pages, especially
> transparent huge pages, would be bigger concerns than CMA for
> internal page migration within one NUMA.
> 
> Not like CMA, general alloc_pages() can get memory by moving
> pages other than those pinned.
> 
> And there is no guarantee we can always bind the memory of
> SVA applications to single one NUMA, so NUMA balancing is
> still a concern.
> 
> But I agree we need a way to make CMA success while the userspace
> pages are pinned. Since pin has been viral in many drivers, I
> assume there is a way to handle this. Otherwise, APIs like
> V4L2_MEMORY_USERPTR[1] will possibly make CMA fail as there
> is no guarantee that usersspace will allocate unmovable memory
> and there is no guarantee the fallback path- alloc_pages() can
> succeed while allocating big memory.
> 

Long term pinnings cannot go onto CMA-reserved memory, and there is 
similar work to also fix ZONE_MOVABLE in that regard.

https://lkml.kernel.org/r/20210125194751.1275316-1-pasha.tatashin@soleen.com

One of the reasons I detest using long term pinning of pages where it 
could be avoided. Take VFIO and RDMA as an example: these things 
currently can't work without them.

What I read here: "DMA performance will be affected severely". That does 
not sound like a compelling argument to me for long term pinnings. 
Please find another way to achieve the same goal without long term 
pinnings controlled by user space - e.g., controlling when migration 
actually happens.

For example, CMA/alloc_contig_range()/memory unplug are corner cases 
that happen rarely, you shouldn't have to worry about them messing with 
your DMA performance.

-- 
Thanks,

David / dhildenb

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
