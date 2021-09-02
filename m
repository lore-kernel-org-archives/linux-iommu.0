Return-Path: <SRS0=cE/7=NY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2915AC43214
	for <iommu@archiver.kernel.org>; Thu,  2 Sep 2021 11:21:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E4A610D0
	for <iommu@archiver.kernel.org>; Thu,  2 Sep 2021 11:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C7E4A610D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94B2482A0B;
	Thu,  2 Sep 2021 11:21:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LRU4ZFkGdNfF; Thu,  2 Sep 2021 11:21:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5978080DB5;
	Thu,  2 Sep 2021 11:21:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30EF0C0010;
	Thu,  2 Sep 2021 11:21:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9EA1CC000E
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 11:21:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 866D8614C0
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 11:21:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id amM6pYSGlgFK for <iommu@lists.linux-foundation.org>;
 Thu,  2 Sep 2021 11:21:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 562D16076B
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 11:21:33 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id r13so1371856pff.7
 for <iommu@lists.linux-foundation.org>; Thu, 02 Sep 2021 04:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uvXbklsYzxIxtTfrV32ffa9Nuwizcf2v49dwd36P0II=;
 b=l3pHshNaH16SxCRdn9z7Xh25o4zr254bVE4gj2gcLe03eGaxqkakkGTJFxJqfTpw1V
 mgl7jhuQxVjIwW/UeX7ktsAfn4KtTM1QiXhueAKmpi1umldFhOhm/opbthWUVENXfmXz
 sByuEIse1tA9cQPTkGsfIdaE+UkFVQTBoS0K+F+XP4S1/PfM9AjDF1PXXeVM/2D0/+Wg
 GFVcsUwXqGqAsvdSyylORw5dpuBcJnKleE7Htyj6/Iy7J3TtLZUSPSx2JgomTUK9XCbK
 tkwtRAK0M+aqYoU4ijzQ2mRPYIgBubcVFek78cQ2L31j1R5JU4P5nO/87EvlyqPdofPx
 bNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uvXbklsYzxIxtTfrV32ffa9Nuwizcf2v49dwd36P0II=;
 b=cpg99FWHoaiBSczAa7OhQ+1HQKRRX+D84dmJCuV/QnD6DsGdT0sAd2rkTyauVKt6fB
 XkCs2EvkHbhQ62vdtQShrygLrnxukpHAQgoDuicz91D4MO5wxt5hULCI/Jwnnkvjf2LI
 vD9ymi/VMhsm429/gQ9uxOd+dVO8vRFWFhnalEPrvbyvwNkAU9iCYSN7FQO02nLA9Qag
 wTECM7VfYmsxhdVjwC4xnrnxqo8g8QSpilJDZSRJbuO19uWHciGagi9fsTHCNq5JpbDG
 QNSYPGd8U1EdjLy9/crCyAMlVdg0td/LS5gP+VrVFxzqZNwlENBnERF5BIwThd8lgoDv
 HNSg==
X-Gm-Message-State: AOAM532vL+JskmzDXnj7w1qhrD/Oe74TvH8Fk1afxYMLkruhqajLgUvZ
 bJ2YLMwS1GCw8xTtG+s5bVo=
X-Google-Smtp-Source: ABdhPJxldFu1U8M2V5yK1yTHMDs9K9anELSSV02bNY0qtLdwF/4+Etf8R4JVmeL3O1gUAcLcNnmdKQ==
X-Received: by 2002:a63:5b08:: with SMTP id p8mr2815838pgb.28.1630581692705;
 Thu, 02 Sep 2021 04:21:32 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::50b? ([2404:f801:9000:1a:efea::50b])
 by smtp.gmail.com with ESMTPSA id
 j6sm2394666pgq.0.2021.09.02.04.21.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Sep 2021 04:21:32 -0700 (PDT)
Subject: Re: [PATCH V4 00/13] x86/Hyper-V: Add Hyper-V Isolation VM support
To: Christoph Hellwig <hch@lst.de>, Michael Kelley <mikelley@microsoft.com>
References: <20210827172114.414281-1-ltykernel@gmail.com>
 <20210830120036.GA22005@lst.de>
 <MWHPR21MB15933503E7C324167CB4132CD7CC9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210902075939.GB14986@lst.de>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <dc124c3d-a316-d36e-3ae4-21674280f55d@gmail.com>
Date: Thu, 2 Sep 2021 19:21:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210902075939.GB14986@lst.de>
Content-Language: en-US
Cc: "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "dave.hansen@intel.com" <dave.hansen@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
 "will@kernel.org" <will@kernel.org>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
 "x86@kernel.org" <x86@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "ardb@kernel.org" <ardb@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "pgonda@google.com" <pgonda@google.com>,
 "rientjes@google.com" <rientjes@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "martin.b.radev@gmail.com" <martin.b.radev@gmail.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, "bp@alien8.de" <bp@alien8.de>,
 "luto@kernel.org" <luto@kernel.org>,
 "krish.sadhukhan@oracle.com" <krish.sadhukhan@oracle.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, vkuznets <vkuznets@redhat.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "jgross@suse.com" <jgross@suse.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "saravanand@fb.com" <saravanand@fb.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "rppt@kernel.org" <rppt@kernel.org>, "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
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



On 9/2/2021 3:59 PM, Christoph Hellwig wrote:
> On Tue, Aug 31, 2021 at 05:16:19PM +0000, Michael Kelley wrote:
>> As a quick overview, I think there are four places where the
>> shared_gpa_boundary must be applied to adjust the guest physical
>> address that is used.  Each requires mapping a corresponding
>> virtual address range.  Here are the four places:
>>
>> 1)  The so-called "monitor pages" that are a core communication
>> mechanism between the guest and Hyper-V.  These are two single
>> pages, and the mapping is handled by calling memremap() for
>> each of the two pages.  See Patch 7 of Tianyu's series.
> 
> Ah, interesting.
> 
>> 3)  The network driver send and receive buffers.  vmap_phys_range()
>> should work here.
> 
> Actually it won't.  The problem with these buffers is that they are
> physically non-contiguous allocations.  We really have two sensible
> options:
> 
>   1) use vmap_pfn as in the current series.  But in that case I think
>      we should get rid of the other mapping created by vmalloc.  I
>      though a bit about finding a way to apply the offset in vmalloc
>      itself, but I think it would be too invasive to the normal fast
>      path.  So the other sub-option would be to allocate the pages
>      manually (maybe even using high order allocations to reduce TLB
>      pressure) and then remap them

Agree. In such case, the map for memory below shared_gpa_boundary is not 
necessary. allocate_pages() is limited by MAX_ORDER and needs to be 
called repeatedly to get enough memory.

>   2) do away with the contiguous kernel mapping entirely.  This means
>      the simple memcpy calls become loops over kmap_local_pfn.  As
>      I just found out for the send side that would be pretty easy,
>      but the receive side would be more work.  We'd also need to check
>      the performance implications.

kmap_local_pfn() requires pfn with backing struct page and this doesn't 
work pfn above shared_gpa_boundary.
> 
>> 4) The swiotlb memory used for bounce buffers.  vmap_phys_range()
>> should work here as well.
> 
> Or memremap if it works for 1.

Now use vmap_pfn() and the hv map function is reused in the netvsc driver.

> 
>> Case #2 above does unusual mapping.  The ring buffer consists of a ring
>> buffer header page, followed by one or more pages that are the actual
>> ring buffer.  The pages making up the actual ring buffer are mapped
>> twice in succession.  For example, if the ring buffer has 4 pages
>> (one header page and three ring buffer pages), the contiguous
>> virtual mapping must cover these seven pages:  0, 1, 2, 3, 1, 2, 3.
>> The duplicate contiguous mapping allows the code that is reading
>> or writing the actual ring buffer to not be concerned about wrap-around
>> because writing off the end of the ring buffer is automatically
>> wrapped-around by the mapping.  The amount of data read or
>> written in one batch never exceeds the size of the ring buffer, and
>> after a batch is read or written, the read or write indices are adjusted
>> to put them back into the range of the first mapping of the actual
>> ring buffer pages.  So there's method to the madness, and the
>> technique works pretty well.  But this kind of mapping is not
>> amenable to using vmap_phys_range().
> 
> Hmm.  Can you point me to where this is mapped?  Especially for the
> classic non-isolated case where no vmap/vmalloc mapping is involved
> at all?
> 

This is done via vmap() in the hv_ringbuffer_init()

182/* Initialize the ring buffer. */
183int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
184                       struct page *pages, u32 page_cnt, u32 
max_pkt_size)
185{
186        int i;
187        struct page **pages_wraparound;
188
189        BUILD_BUG_ON((sizeof(struct hv_ring_buffer) != PAGE_SIZE));
190
191        /*
192         * First page holds struct hv_ring_buffer, do wraparound 
mapping for
193         * the rest.
194         */
195        pages_wraparound = kcalloc(page_cnt * 2 - 1, sizeof(struct 
page *),
196                                   GFP_KERNEL);
197        if (!pages_wraparound)
198                return -ENOMEM;
199
/* prepare to wrap page array */
200        pages_wraparound[0] = pages;
201        for (i = 0; i < 2 * (page_cnt - 1); i++)
202                pages_wraparound[i + 1] = &pages[i % (page_cnt - 1) + 1];
203
/* map */
204        ring_info->ring_buffer = (struct hv_ring_buffer *)
205                vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP, 
PAGE_KERNEL);
206
207        kfree(pages_wraparound);
208
209
210        if (!ring_info->ring_buffer)
211                return -ENOMEM;
212
213        ring_info->ring_buffer->read_index =
214                ring_info->ring_buffer->write_index = 0;


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
