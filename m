Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BE6C433FE
	for <iommu@archiver.kernel.org>; Tue, 21 Dec 2021 17:25:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6AB99400C9;
	Tue, 21 Dec 2021 17:25:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CARaJ2K6x4fQ; Tue, 21 Dec 2021 17:25:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DB10D40A3A;
	Tue, 21 Dec 2021 17:25:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0222C002F;
	Tue, 21 Dec 2021 17:25:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 684ACC0012
 for <iommu@lists.linux-foundation.org>; Tue, 21 Dec 2021 17:25:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 56D60414C7
 for <iommu@lists.linux-foundation.org>; Tue, 21 Dec 2021 17:25:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SMhHiG6OpjFG for <iommu@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 17:25:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 56067414C1
 for <iommu@lists.linux-foundation.org>; Tue, 21 Dec 2021 17:25:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97EB4D6E;
 Tue, 21 Dec 2021 09:25:14 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27FF13F718;
 Tue, 21 Dec 2021 09:25:06 -0800 (PST)
Message-ID: <db0ba937-8785-a27b-afff-55c55456ae19@arm.com>
Date: Tue, 21 Dec 2021 17:25:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 00/33] Separate struct slab from struct page
Content-Language: en-GB
To: Vlastimil Babka <vbabka@suse.cz>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20211201181510.18784-1-vbabka@suse.cz>
 <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
 <YbtUmi5kkhmlXEB1@ip-172-31-30-232.ap-northeast-1.compute.internal>
 <38976607-b9f9-1bce-9db9-60c23da65d2e@suse.cz>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <38976607-b9f9-1bce-9db9-60c23da65d2e@suse.cz>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@kernel.org>,
 linux-mm@kvack.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>, Matthew Wilcox <willy@infradead.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Christoph Lameter <cl@linux.com>,
 Will Deacon <will@kernel.org>, Pekka Enberg <penberg@kernel.org>,
 Minchan Kim <minchan@kernel.org>, x86@kernel.org,
 iommu@lists.linux-foundation.org, kasan-dev@googlegroups.com,
 Ingo Molnar <mingo@redhat.com>, Vladimir Davydov <vdavydov.dev@gmail.com>,
 David Rientjes <rientjes@google.com>, Nitin Gupta <ngupta@vflare.org>,
 Marco Elver <elver@google.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, cgroups@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, patches@lists.linux.dev,
 Julia Lawall <julia.lawall@inria.fr>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, David Woodhouse <dwmw2@infradead.org>
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

On 2021-12-20 23:58, Vlastimil Babka wrote:
> On 12/16/21 16:00, Hyeonggon Yoo wrote:
>> On Tue, Dec 14, 2021 at 01:57:22PM +0100, Vlastimil Babka wrote:
>>> On 12/1/21 19:14, Vlastimil Babka wrote:
>>>> Folks from non-slab subsystems are Cc'd only to patches affecting them, and
>>>> this cover letter.
>>>>
>>>> Series also available in git, based on 5.16-rc3:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slab-struct_slab-v2r2
>>>
>>> Pushed a new branch slab-struct-slab-v3r3 with accumulated fixes and small tweaks
>>> and a new patch from Hyeonggon Yoo on top. To avoid too much spam, here's a range diff:
>>
>> Reviewing the whole patch series takes longer than I thought.
>> I'll try to review and test rest of patches when I have time.
>>
>> I added Tested-by if kernel builds okay and kselftests
>> does not break the kernel on my machine.
>> (with CONFIG_SLAB/SLUB/SLOB depending on the patch),
> 
> Thanks!
> 
>> Let me know me if you know better way to test a patch.
> 
> Testing on your machine is just fine.
> 
>> # mm/slub: Define struct slab fields for CONFIG_SLUB_CPU_PARTIAL only when enabled
>>
>> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>>
>> Comment:
>> Works on both SLUB_CPU_PARTIAL and !SLUB_CPU_PARTIAL.
>> btw, do we need slabs_cpu_partial attribute when we don't use
>> cpu partials? (!SLUB_CPU_PARTIAL)
> 
> The sysfs attribute? Yeah we should be consistent to userspace expecting to
> read it (even with zeroes), regardless of config.
> 
>> # mm/slub: Simplify struct slab slabs field definition
>> Comment:
>>
>> This is how struct page looks on the top of v3r3 branch:
>> struct page {
>> [...]
>>                  struct {        /* slab, slob and slub */
>>                          union {
>>                                  struct list_head slab_list;
>>                                  struct {        /* Partial pages */
>>                                          struct page *next;
>> #ifdef CONFIG_64BIT
>>                                          int pages;      /* Nr of pages left */
>> #else
>>                                          short int pages;
>> #endif
>>                                  };
>>                          };
>> [...]
>>
>> It's not consistent with struct slab.
> 
> Hm right. But as we don't actually use the struct page version anymore, and
> it's not one of the fields checked by SLAB_MATCH(), we can ignore this.
> 
>> I think this is because "mm: Remove slab from struct page" was dropped.
> 
> That was just postponed until iommu changes are in. Matthew mentioned those
> might be merged too, so that final cleanup will happen too and take care of
> the discrepancy above, so no need for extra churn to address it speficially.

FYI the IOMMU changes are now queued in linux-next, so if all goes well 
you might be able to sneak that final patch in too.

Robin.

> 
>> Would you update some of patches?
>>
>> # mm/sl*b: Differentiate struct slab fields by sl*b implementations
>> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> Works SL[AUO]B on my machine and makes code much better.
>>
>> # mm/slob: Convert SLOB to use struct slab and struct folio
>> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> It still works fine on SLOB.
>>
>> # mm/slab: Convert kmem_getpages() and kmem_freepages() to struct slab
>> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>>
>> # mm/slub: Convert __free_slab() to use struct slab
>> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>>
>> Thanks,
>> Hyeonggon.
> 
> Thanks again,
> Vlastimil
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
