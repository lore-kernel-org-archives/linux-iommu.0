Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A53C433EF
	for <iommu@archiver.kernel.org>; Fri, 26 Nov 2021 11:39:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11E8B40276;
	Fri, 26 Nov 2021 11:39:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0MXtPYfCxfqR; Fri, 26 Nov 2021 11:39:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DEB1F40310;
	Fri, 26 Nov 2021 11:39:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC0CAC001C;
	Fri, 26 Nov 2021 11:39:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AEF0C000A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Nov 2021 11:39:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 071E280F44
 for <iommu@lists.linux-foundation.org>; Fri, 26 Nov 2021 11:39:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KIOTBDh_uVND for <iommu@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 11:39:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4191F80F31
 for <iommu@lists.linux-foundation.org>; Fri, 26 Nov 2021 11:39:17 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id f65so7978350pgc.0
 for <iommu@lists.linux-foundation.org>; Fri, 26 Nov 2021 03:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=ambWW/4YEyu662pYE46PBmuDJfo9av+csYLqJQyv9eI=;
 b=be/+Ee7qIA99Wogw9aDbu8FGuY+NkyZyPMuDQQQMyfJu74GW/p4hwR7Uk3SV8SOWot
 OTvvRslVrIRWr+jhwF4djz3GnmhzFxoTjzdSB66EYMTFp4ObhQoXBUaxMmS0E8ljOC5C
 BvMJB5gq9CLv6RX+bLXdcwcuXLE+FMY5lUFCbxIImkmK67mwpllFQSs45yZerfLFiBCR
 DbhWdfqUQ3x6YsTjsY/25enAc6WD87puZv3GLXecg2pr4iVTltkGoYwbxLChdmS97p73
 BAHuN7hbOH9DJ41QGZsyZO96dnKzD8IZFOupSItaLv9c137ht8NLB+g2Qd6+KKgLGpSA
 nk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ambWW/4YEyu662pYE46PBmuDJfo9av+csYLqJQyv9eI=;
 b=Usp1hEsXlJy1kQlnNgDjsa+Dvzg3WpNLogAJa7pPLkMP7UsR+TKlpWveqhCgmUUb9o
 Gs273lfQGIR8o/6rK9WW8atK53M6sPLYGUDxdli3Kq0T29pP8fJxl3NwjzFnce7v7cne
 Bs9nFTHk4WA0ApExZzYZwNS2OtBT9tO4Ch7kCVPioFhQ0c2GA5erzYbaa2IcPjZ7bikn
 xlB/G2oAqWFfWy2H5abqTKP0oAdsKMIyLgdLJU+gvo8pOJjB6885VlslABb7guBkwCeO
 xK/QdVrNXjPRn82ArqSVDBHRgNu6SR1i9B4bt8Z9+jRzswfq/Jvben9o9PfIdg1odoig
 Q5/w==
X-Gm-Message-State: AOAM531t4MjERRRrImRrG0OWLHn4xytXpEL8UpJzHRI9IT82Shnjf2hH
 BJ8PaHML9Ax7aQ6dRuhHK6U=
X-Google-Smtp-Source: ABdhPJyqblxnRgV5wg5BPP9Vi1R0NhHs6AkjTX8lIUxkdCJzlfse/09nmYdMwJ3MumBswrLh4eDT7g==
X-Received: by 2002:a65:5a8e:: with SMTP id c14mr20429967pgt.241.1637926756738; 
 Fri, 26 Nov 2021 03:39:16 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::50b? ([2404:f801:9000:18:efec::50b])
 by smtp.gmail.com with ESMTPSA id
 f21sm7243932pfe.69.2021.11.26.03.39.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Nov 2021 03:39:16 -0800 (PST)
Message-ID: <e874b4c3-1d09-8d2a-bd59-80bae7e554d6@gmail.com>
Date: Fri, 26 Nov 2021 19:39:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 3/5] hyperv/IOMMU: Enable swiotlb bounce buffer for
 Isolation VM
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
References: <20211116153923.196763-1-ltykernel@gmail.com>
 <20211116153923.196763-4-ltykernel@gmail.com> <20211117100142.GB10330@lst.de>
 <c93bf3d4-75c1-bc3d-2789-1d65e7c19158@gmail.com>
 <20211126074022.GA23659@lst.de>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20211126074022.GA23659@lst.de>
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com, peterz@infradead.org,
 dave.hansen@linux.intel.com, dave.hansen@intel.com, hpa@zytor.com,
 kys@microsoft.com, will@kernel.org, boris.ostrovsky@oracle.com,
 wei.liu@kernel.org, sstabellini@kernel.org, sthemmin@microsoft.com,
 linux-scsi@vger.kernel.org, x86@kernel.org, decui@microsoft.com,
 michael.h.kelley@microsoft.com, mingo@redhat.com, kuba@kernel.org,
 haiyangz@microsoft.com, parri.andrea@gmail.com, thomas.lendacky@amd.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, konrad.wilk@oracle.com,
 jejb@linux.ibm.com, bp@alien8.de, luto@kernel.org,
 xen-devel@lists.xenproject.org, tglx@linutronix.de, jgross@suse.com,
 martin.petersen@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, robin.murphy@arm.com, davem@davemloft.net
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

On 11/26/2021 3:40 PM, Christoph Hellwig wrote:
> On Wed, Nov 17, 2021 at 10:00:08PM +0800, Tianyu Lan wrote:
>> On 11/17/2021 6:01 PM, Christoph Hellwig wrote:
>>> This doesn't really have much to do with normal DMA mapping,
>>> so why does this direct through the dma ops?
>>>
>>
>> According to the previous discussion, dma_alloc_noncontigous()
>> and dma_vmap_noncontiguous() may be used to handle the noncontigous
>> memory alloc/map in the netvsc driver. So add alloc/free and vmap/vunmap
>> callbacks here to handle the case. The previous patch v4 & v5 handles
>> the allocation and map in the netvsc driver. If this should not go though
>> dma ops, We also may make it as vmbus specific function and keep
>> the function in the vmbus driver.
> 
> But that only makes sense if they can actually use the normal DMA ops.
> If you implement your own incomplete ops and require to use them you
> do nothing but adding indirect calls to your fast path and making the
> code convoluted.
> 

Because the generic part implementation can't meet the netvsc driver
requests that allocate 16M memory and map pages via vmap_pfn(). So add 
Hyperv alloc_noncontiguous and vmap_noncontiguous callbacks. If this is
not a right way. we should call these hyper-V functions in the netvsc
driver directly, right?

Could you have a look at Michael summary about this series we made and
give some guides?

https://www.mail-archive.com/xen-devel@lists.xenproject.org/msg109284.html

Thanks.





_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
