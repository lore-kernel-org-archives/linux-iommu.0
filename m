Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B47BC433EF
	for <iommu@archiver.kernel.org>; Wed,  6 Jul 2022 08:57:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9C8160A9D;
	Wed,  6 Jul 2022 08:57:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C9C8160A9D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=WbD1If6f
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d6rx8u6sTwNS; Wed,  6 Jul 2022 08:57:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A6F3160F99;
	Wed,  6 Jul 2022 08:57:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A6F3160F99
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B0C5C0033;
	Wed,  6 Jul 2022 08:57:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3BEE3C002D
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 08:57:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1672860F99
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 08:57:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1672860F99
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W-lqet63tU73 for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 08:57:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 69D8C60A9D
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 69D8C60A9D
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 08:57:45 +0000 (UTC)
Received: by mail-pg1-x534.google.com with SMTP id i190so907353pge.7
 for <iommu@lists.linux-foundation.org>; Wed, 06 Jul 2022 01:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=9bOXUBsbXZmaBYzdut2n91pd8GDpqQDkHHTCpALSOcI=;
 b=WbD1If6fFhm+DWvJ31AEQrrcggmBAVShmCuXjXNLR/EVZnRJUDmLjPBezh+u8N3upE
 GXKjZxORcv3nTuTsXheqqTeRS4skn7EUMwPYGKEcKo3ObhN6T6QIWqvqxX6Jr8F8QElY
 /FFM0dQQSlpothQOx+YeobkCdnpTL1e0JIO9lvz1yIw30dwxN0fdT4a7Kza3H9j4qj6X
 xkNgj8iH/9xz6YGbQQGnLUiRk7GZcv/bnxehkOG5U5RMwAvat4EhTh1NTM/tC6yV7UUl
 l/1BXoGHW0yM0j0TcLjhlJm98q9lR4zh/p+boW25L80TLyb3fhDy9DvPsO/ZJQjltXZE
 u58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=9bOXUBsbXZmaBYzdut2n91pd8GDpqQDkHHTCpALSOcI=;
 b=ikRGXe3W1UYQ85e5wjc5agb2PFEOfxdB9oDzUueavx5p/be11wd1OoIdS3vQyE2/XQ
 vfHQB3MCoaWR/P8kySJHowFAPDMFDFhlSmL10CnkQgLZIPWiAk527OyX3AXY5372C2Y2
 huwvLV+kIsNq6IMZYsbLDueGZEjXa4h+DdcN5Qu8RbpXyK7azL1eL7VY59yb3TFH9Ksu
 4ufDPv+7SW+2kA2CGiY33SexU+VN6QSs5MJOx6rQU7SRc/VeaXM8Q2VgvLnnTRXt1b1v
 YQxK4mZFMvQoWfG3QG03h67XktM/+LwUgWsUf2W6As1TaHB+RsDY0jfTBLw7U47qpRHh
 ZkxA==
X-Gm-Message-State: AJIora9FsWgQ14nOKExAFJSbZxFfguQwXGTQnS/NU10WAEvI6juU+w19
 t2af70humn/HiHlqMKUINz8=
X-Google-Smtp-Source: AGRyM1sYGXX9loS3JRKD0954hjKimsXBBNwAgBw0D8WiC3yUj6I/JN7LKTG9QaIQg312XdOckDYv7w==
X-Received: by 2002:a05:6a00:1303:b0:528:2ed8:7e86 with SMTP id
 j3-20020a056a00130300b005282ed87e86mr29108564pfu.4.1657097864729; 
 Wed, 06 Jul 2022 01:57:44 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
 by smtp.gmail.com with ESMTPSA id
 d18-20020a170903231200b0016bf7981d0bsm2501495plh.86.2022.07.06.01.57.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Jul 2022 01:57:43 -0700 (PDT)
Message-ID: <10062b7d-f0a6-6724-4ccb-506da09a8533@gmail.com>
Date: Wed, 6 Jul 2022 16:57:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] x86/ACPI: Set swiotlb area according to the number of
 lapic entry in MADT
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
References: <20220627153150.106995-1-ltykernel@gmail.com>
 <20220627153150.106995-3-ltykernel@gmail.com>
 <YrxcCZKvFYjxLf9n@infradead.org>
 <a876f862-c005-108d-e6f9-68336a8d89f0@gmail.com>
 <YsVBKgxiQKfnCjvn@infradead.org>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <YsVBKgxiQKfnCjvn@infradead.org>
Cc: linux-hyperv@vger.kernel.org, rafael@kernel.org,
 dave.hansen@linux.intel.com, pavel@ucw.cz, hpa@zytor.com, kys@microsoft.com,
 wei.liu@kernel.org, Andi Kleen <ak@linux.intel.com>, corbet@lwn.net,
 damien.lemoal@opensource.wdc.com, x86@kernel.org,
 michael.h.kelley@microsoft.com, mingo@redhat.com, andi.kleen@intel.com,
 parri.andrea@gmail.com, len.brown@intel.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, keescook@chromium.org,
 paulmck@kernel.org, linux-pm@vger.kernel.org, kirill.shutemov@intel.com,
 bp@alien8.de, songmuchun@bytedance.com, tglx@linutronix.de,
 vkuznets@redhat.com, rdunlap@infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thomas.lendacky@amd.com, akpm@linux-foundation.org, robin.murphy@arm.com
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

On 7/6/2022 4:00 PM, Christoph Hellwig wrote:
> On Fri, Jul 01, 2022 at 01:02:21AM +0800, Tianyu Lan wrote:
>>> Can we reorder that initialization?  Because I really hate having
>>> to have an arch hook in every architecture.
>>
>> How about using "flags" parameter of swiotlb_init() to pass area number
>> or add new parameter for area number?
>>
>> I just reposted patch 1 since there is just some coding style issue and area
>> number may also set via swiotlb kernel parameter. We still need figure out a
>> good solution to pass area number from architecture code.
> 
> What is the problem with calling swiotlb_init after nr_possible_cpus()
> works?

Swiotlb_init() is called in the mem_init() of different architects and
memblock free pages are released to the buddy allocator just after
calling swiotlb_init() via memblock_free_all().

The mem_init() is called before smp_init(). If calling swiotlb_init()
after smp_init(), that means we can't allocate large chunk low end
memory via memblock_alloc() in the swiotlb(). Swiotlb_init() needs
to rework to allocate memory from the buddy allocator and just like
swiotlb_init_late() does. This will limit the bounce buffer size.
Otherwise We need to do the reorder for all achitectures and there maybe
some other unknown issues.

swiotlb flags parameter of swiotlb_init() seems to be a good place to
pass the area number in current code. If not set the swiotlb_area
number/flag, the area number will be one and keep the original behavior
of one single global spinlock protecting io tlb data structure.














_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
