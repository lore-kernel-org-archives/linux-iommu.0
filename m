Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F70C433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 14:48:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 02FAF404BF;
	Thu, 23 Jun 2022 14:48:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 02FAF404BF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=V2o5Ehf6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o7Wxsp6kDVs5; Thu, 23 Jun 2022 14:48:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A07514048D;
	Thu, 23 Jun 2022 14:48:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A07514048D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BD8EC0032;
	Thu, 23 Jun 2022 14:48:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B247C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 14:48:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DA5B98470E
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 14:48:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DA5B98470E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=V2o5Ehf6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wfpGexcKCjkP for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 14:48:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 15EFC8472E
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 15EFC8472E
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 14:48:46 +0000 (UTC)
Received: by mail-pf1-x436.google.com with SMTP id w6so12163105pfw.5
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=NsGuoNrKOwZi4+BNGtJiyK4WoJSitQyKFNOmJMq17xI=;
 b=V2o5Ehf6KJjGJXdWPnxArGMA5u68nQNPZm7nxJHmFuS/1tpE8JNXxg6GBlNJgaPPFx
 aHia/s+4wZmGBIBYLMsxrA+XRCg6ZpCdlq6zLzoLvli88rxxGavMue/9OT7OT3l1BM55
 +csszujMGX+HWqrj4ur/ALcKQDaY4XtH5XJq8fu39qbhOw92BJxEfFc/zpJfoeTNOTC6
 h//c8jmvej323nlLvc3FLJ99uDvgbHaaIdsIuQ7rUf1rCytujpZNamgA7f/awCe3P5eN
 AmkU52yJCHoMG8iHVNNcHGDzcQF7lHfYKcZoIB60QvPyYQ4tVM30wxbPngmCd0owLbfs
 /Ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=NsGuoNrKOwZi4+BNGtJiyK4WoJSitQyKFNOmJMq17xI=;
 b=KqF4zRngHWmJHWg91D7At0meIhrPz7W7U6PSXW+hHpTLELWY10XhOq5KFwpNaDfWAS
 9aXPyfJTR879NRIxLc4JUH95Kc1jvLAaS9KBrMYB1Kc4gbsHv5sheqGrnIsDRn38yj8A
 VWIQAHJhf7eIfAXbL+vhosYVov3UEtEhUNbO7v7y8Iaz2e7oJMLTuZnPIw90hCJVPiLZ
 +m9UIgTiyxmic7dO8TN+MjFdSyoZz4Tu2JQi57ClVJ2FosAG9BYeV+68Y7g9ejFhk5d8
 nDfqGzmp5DUstPzTa5Q+Diq7PJ4W42+qERw0B+a90fKxsWcb1gHCXn0/TgjiSEWvUFQB
 JMlw==
X-Gm-Message-State: AJIora9e7x2jBjEjL+BIuDvOlIV+o/unE2zblL9Lhl45UK4yfm7dcZiS
 PAiSzldmGbpn5crAdR9TrDs=
X-Google-Smtp-Source: AGRyM1uvG03JMk59g0aypaxhEUWEhGYWbNHLb64IATh4yVcG+Esi2oTV7YSoyn9H7gBse6gMRy873A==
X-Received: by 2002:a63:f415:0:b0:408:808b:238f with SMTP id
 g21-20020a63f415000000b00408808b238fmr7684450pgi.469.1655995725433; 
 Thu, 23 Jun 2022 07:48:45 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
 by smtp.gmail.com with ESMTPSA id
 25-20020aa79159000000b00522c0a75c39sm15815422pfi.196.2022.06.23.07.48.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jun 2022 07:48:44 -0700 (PDT)
Message-ID: <d80ad697-ed71-6671-c4ea-a7ca5883f65e@gmail.com>
Date: Thu, 23 Jun 2022 22:48:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH V4 1/1] swiotlb: Split up single swiotlb lock
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
References: <20220617144741.921308-1-ltykernel@gmail.com>
 <YrL02y/fYxDkDRlA@infradead.org>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <YrL02y/fYxDkDRlA@infradead.org>
Cc: linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org, kys@microsoft.com,
 wei.liu@kernel.org, Andi Kleen <ak@linux.intel.com>, corbet@lwn.net,
 damien.lemoal@opensource.wdc.com, michael.h.kelley@microsoft.com,
 andi.kleen@intel.com, bp@suse.de, parri.andrea@gmail.com,
 thomas.lendacky@amd.com, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 paulmck@kernel.org, kirill.shutemov@intel.com, songmuchun@bytedance.com,
 tglx@linutronix.de, akpm@linux-foundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, robin.murphy@arm.com
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

On 6/22/2022 6:54 PM, Christoph Hellwig wrote:
> Thanks,
> 
> this looks pretty good to me.  A few comments below:
> 

Thanks for your review.

> On Fri, Jun 17, 2022 at 10:47:41AM -0400, Tianyu Lan wrote:
>> +/**
>> + * struct io_tlb_area - IO TLB memory area descriptor
>> + *
>> + * This is a single area with a single lock.
>> + *
>> + * @used:	The number of used IO TLB block.
>> + * @index:	The slot index to start searching in this area for next round.
>> + * @lock:	The lock to protect the above data structures in the map and
>> + *		unmap calls.
>> + */
>> +struct io_tlb_area {
>> +	unsigned long used;
>> +	unsigned int index;
>> +	spinlock_t lock;
>> +};
> 
> This can go into swiotlb.c.

struct io_tlb_area is used in the struct io_tlb_mem.

> 
>> +void __init swiotlb_adjust_nareas(unsigned int nareas);
> 
> And this should be marked static.
> 
>> +#define DEFAULT_NUM_AREAS 1
> 
> I'd drop this define, the magic 1 and a > 1 comparism seems to
> convey how it is used much better as the checks aren't about default
> or not, but about larger than one.
> 
> I also think that we want some good way to size the default, e.g.
> by number of CPUs or memory size.

swiotlb_adjust_nareas() is exposed to platforms to set area number.
When swiotlb_init() is called, smp_init() isn't called at that point and
so standard API of checking cpu number (e.g, num_online_cpus()) doesn't
work. Platforms may have other ways to get cpu number(e.g x86 may ACPI
MADT table entries to get cpu nubmer) and set area number. I will post 
following patch to set cpu number via swiotlb_adjust_nareas(),

> 
>> +void __init swiotlb_adjust_nareas(unsigned int nareas)
>> +{
>> +	if (!is_power_of_2(nareas)) {
>> +		pr_err("swiotlb: Invalid areas parameter %d.\n", nareas);
>> +		return;
>> +	}
>> +
>> +	default_nareas = nareas;
>> +
>> +	pr_info("area num %d.\n", nareas);
>> +	/* Round up number of slabs to the next power of 2.
>> +	 * The last area is going be smaller than the rest if
>> +	 * default_nslabs is not power of two.
>> +	 */
> 
> Please follow the normal kernel comment style with a /* on its own line.
> 

OK. Will update.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
