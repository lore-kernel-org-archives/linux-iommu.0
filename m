Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506BF1109
	for <iommu@lists.linux.dev>; Thu, 29 Sep 2022 09:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664442055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lfm2hTAKHlSUCgBEt7l6ux7MJ6UqswZ64DGXOWdoD2U=;
	b=a9LwO6deQGGMsTxQ3BwxWbW2AnXavG67OgsnE0wLodMAvw0NPTjwHkrc7aPN/5feCmxKLt
	uynpN4UgMj1FiV11JwE8j/DgoiQgQr6j7Mp3mMhUcdJj6Eo3bGyiyEZDQklp2dfy1t4ljQ
	5LpIWhxhMxOx8QSKPn0sI6itj+yTkLQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-15-0NS79tUzNXaRfEkbMDWwHw-1; Thu, 29 Sep 2022 05:00:53 -0400
X-MC-Unique: 0NS79tUzNXaRfEkbMDWwHw-1
Received: by mail-wm1-f72.google.com with SMTP id ay21-20020a05600c1e1500b003b45fd14b53so2443712wmb.1
        for <iommu@lists.linux.dev>; Thu, 29 Sep 2022 02:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=lfm2hTAKHlSUCgBEt7l6ux7MJ6UqswZ64DGXOWdoD2U=;
        b=I8XaT5Rh+pBdPzCa01CGTb6tLojiiOuj17KQHGdlB87hvBHl5rQcy04FBiXx5t5eFU
         5M63gmJq99FZ1SLYW5mFm6Rzen9GnBmsFs6zEiw5skSRGr9QFs3l6Puiu0OSOMKtXpkz
         dkgx89buBLB/mrvAwuFfakNhL5VGwpnQN8h0u/h05xFhFoN4OB9NEp3DWkwQxAaz0ocp
         YZ6i9eD1JtjJIzlIv0QeUH+PaHaCfGgMOCPPEGZ1VOt6BZJA/LMlnQTAq8ziycwvpirX
         s+L1cgdCCtpZO1LJCCyOAmStLCrWW4vfBMo/OfB9+rIMOLLdUaGq++OX3dqRGG/E1acF
         W+8w==
X-Gm-Message-State: ACrzQf3+A3vMzEc/dXfl2xTi254Bg796SMtSXAKwGG6nCKV5GNF3C6An
	0mP922lfOfuSXqdJbfzSxgsjkoVqtdsdbELGf3HwVZiGX//WuQHZ54M4aKAoNAQmOjndKcmAiR4
	dCv9UFWn4760av84=
X-Received: by 2002:a05:6000:15cf:b0:228:45fb:110e with SMTP id y15-20020a05600015cf00b0022845fb110emr1297753wry.709.1664442052202;
        Thu, 29 Sep 2022 02:00:52 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM52VE1Cdiz4trKlF0jY9K1wv0SMUR9jsU25b3D1bwa9AGD05AbCfMciAWJF5swPx8VnyAl0ig==
X-Received: by 2002:a05:6000:15cf:b0:228:45fb:110e with SMTP id y15-20020a05600015cf00b0022845fb110emr1297713wry.709.1664442051792;
        Thu, 29 Sep 2022 02:00:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:ce00:b5d:2b28:1eb5:9245? (p200300cbc705ce000b5d2b281eb59245.dip0.t-ipconnect.de. [2003:cb:c705:ce00:b5d:2b28:1eb5:9245])
        by smtp.gmail.com with ESMTPSA id p25-20020a1c5459000000b003a5c7a942edsm3848977wmi.28.2022.09.29.02.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 02:00:51 -0700 (PDT)
Message-ID: <64c3aea2-331b-e482-bbb0-7fac2340163c@redhat.com>
Date: Thu, 29 Sep 2022 11:00:49 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
To: Doug Berger <opendmb@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Frank Rowand <frowand.list@gmail.com>, Mike Kravetz
 <mike.kravetz@oracle.com>, Muchun Song <songmuchun@bytedance.com>,
 Mike Rapoport <rppt@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Borislav Petkov <bp@suse.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <quic_neeraju@quicinc.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Zi Yan <ziy@nvidia.com>,
 Oscar Salvador <osalvador@suse.de>, Hari Bathini <hbathini@linux.ibm.com>,
 Kees Cook <keescook@chromium.org>, - <devicetree-spec@vger.kernel.org>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux.dev
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <b610a7b3-d740-8d45-c270-4c638deb1cfa@redhat.com>
 <02561695-df44-4df6-c486-1431bf152650@gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 00/21] mm: introduce Designated Movable Blocks
In-Reply-To: <02561695-df44-4df6-c486-1431bf152650@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.09.22 03:03, Doug Berger wrote:
> On 9/19/2022 2:00 AM, David Hildenbrand wrote:
>> Hi Dough,
>>
>> I have some high-level questions.
> Thanks for your interest. I will attempt to answer them.
> 

Hi Doug,

sorry for the late reply, slowly catching up on mails.

>>
>>> MOTIVATION:
>>> Some Broadcom devices (e.g. 7445, 7278) contain multiple memory
>>> controllers with each mapped in a different address range within
>>> a Uniform Memory Architecture. Some users of these systems have
>>
>> How large are these areas typically?
>>
>> How large are they in comparison to other memory in the system?
>>
>> How is this memory currently presented to the system?
> I'm not certain what is typical because these systems are highly
> configurable and Broadcom's customers have different ideas about
> application processing.
> 
> The 7278 device has four ARMv8 CPU cores in an SMP cluster and two
> memory controllers (MEMCs). Each MEMC is capable of controlling up to
> 8GB of DRAM. An example 7278 system might have 1GB on each controller,
> so an arm64 kernel might see 1GB on MEMC0 at 0x40000000-0x7FFFFFFF and
> 1GB on MEMC1 at 0x300000000-0x33FFFFFFF.
> 
> The Designated Movable Block concept introduced here has the potential
> to offer useful services to different constituencies. I tried to
> highlight this in my V1 patch set with the hope of attracting some
> interest, but it can complicate the overall discussion, so I would like
> to maybe narrow the discussion here. It may be good to keep them in mind
> when assessing the overall value, but perhaps the "other opportunities"
> can be covered as a follow on discussion.
> 
> The base capability described in commits 7-15 of this V1 patch set is to
> allow a 'movablecore' block to be created at a particular base address
> rather than solely at the end of addressable memory.
> 

Just so we're on the same page:

Having too much ZONE_MOVABLE memory (ratio compared to !ZONE_MOVABLE 
memory) is dangerous. Acceptable ratios highly depend on the target 
workload. An extreme example is memory-hungry applications that end up 
long-term pinning a lot of memory (e.g., VMs with SR-IO): we can run 
easily out of free memory in the !ZONE_MOVABLE zones and might not want 
ZONE_MOVABLE at all.

So whatever we do, this should in general not be the kernel sole 
decision to make this memory any special and let ZONE_MOVABLE manage it.

It's the same with CMA. "Heavy" CMA users require special configuration: 
hugetlb_cma is one prime example.

>>
>>> expressed the desire to locate ZONE_MOVABLE memory on each
>>> memory controller to allow user space intensive processing to
>>> make better use of the additional memory bandwidth.
>>
>> Can you share some more how exactly ZONE_MOVABLE would help here to make
>> better use of the memory bandwidth?
> ZONE_MOVABLE memory is effectively unusable by the kernel. It can be
> used by user space applications through both the page allocator and the
> Hugetlbfs. If a large 'movablecore' allocation is defined and it can

Hugetlbfs not necessarily by all architectures. Some architectures don't 
support placing hugetlb pages on ZONE_MOVABLE (not migratable) and 
gigantic pages are special either way.

> only be located at the end of addressable memory then it will always be
> located on MEMC1 of a 7278 system. This will create a tendency for user
> space accesses to consume more bandwidth on the MEMC1 memory controller
> and kernel space accesses to consume more bandwidth on MEMC0. A more
> even distribution of ZONE_MOVABLE memory between the available memory
> controllers in theory makes more memory bandwidth available to user
> space intensive loads.
> 

Sorry to be dense, is this also about different memory access latency or 
just memory bandwidth?

Do these memory areas have special/different performance 
characteristics? Using dedicated/fake NUMA nodes might be more in line 
with what CXL and PMEM are up to.

Using ZONE_MOVABLE for that purpose feels a little bit like an abuse of 
the mechanism. To be clearer what I mean:

We can place any movable allocations on ZONE_MOVABLE, including kernel 
allocations. User space allocations are just one example, and int he 
future we'll turn more and more allocations movable to be able to cope 
with bigger ZONE_MOVABLE demands due to DAX/CXL. I once looked into 
migrating user space page tables, just to give an example.


>>
>>> Unfortunately, the historical monotonic layout of zones would
>>> mean that if the lowest addressed memory controller contains
>>> ZONE_MOVABLE memory then all of the memory available from
>>> memory controllers at higher addresses must also be in the
>>> ZONE_MOVABLE zone. This would force all kernel memory accesses
>>> onto the lowest addressed memory controller and significantly
>>> reduce the amount of memory available for non-movable
>>> allocations.
>>
>> We do have code that relies on zones during boot to not overlap within a
>> single node.
> I believe my changes address all such reliance, but if you are aware of
> something I missed please let me know.
> 

One example I'm aware of is drivers/base/memory.c:memory_block_add_nid() 
/ early_node_zone_for_memory_block().

If we get it wrong, or actually have memory blocks that span multiple 
zones, we can no longer offline these memory blocks. We really wanted to 
avoid scanning the memmap for now and it seems to get the job done in 
environments we care about.

>>
>>>
>>> The main objective of this patch set is therefore to allow a
>>> block of memory to be designated as part of the ZONE_MOVABLE
>>> zone where it will always only be used by the kernel page
>>> allocator to satisfy requests for movable pages. The term
>>> Designated Movable Block is introduced here to represent such a
>>> block. The favored implementation allows modification of the
>>
>> Sorry to say, but that term is rather suboptimal to describe what you
>> are doing here. You simply have some system RAM you'd want to have
>> managed by ZONE_MOVABLE, no?
> That may be true, but I found it superior to the 'sticky' movable
> terminology put forth by Mel Gorman ;). I'm happy to entertain
> alternatives, but they may not be as easy to find as you think.

Especially the "blocks" part is confusing. Movable pageblocks? Movable 
Linux memory blocks?

Note that the sticky movable *pageblocks* were a completely different 
concept than simply reusing ZONE_MOVABLE for some memory ranges.

> 
>>
>>> 'movablecore' kernel parameter to allow specification of a base
>>> address and support for multiple blocks. The existing
>>> 'movablecore' mechanisms are retained. Other mechanisms based on
>>> device tree are also included in this set.
>>>
>>> BACKGROUND:
>>> NUMA architectures support distributing movablecore memory
>>> across each node, but it is undesirable to introduce the
>>> overhead and complexities of NUMA on systems that don't have a
>>> Non-Uniform Memory Architecture.
>>
>> How exactly would that look like? I think I am missing something :)
> The notion would be to consider each memory controller as a separate
> node, but as stated it is not desirable.
> 

Doing it the DAX/CXL way would be to expose these memory ranges as 
daxdev instead, and letting the admin decide how to online these memory 
ranges when adding them to the buddy via the dax/kmem kernel module.

That could mean that your booting with memory on MC0 only, and expose 
memory of MC1 via a daxdev, giving the admin the possibility do decide 
to which zone the memory should be onlined too.

That would avoid most kernel code changes.

>>
>> Why can't we simply designate these regions as CMA regions?
> We and others have encountered significant performance issues when large
> CMA regions are used. There are significant restrictions on the page
> allocator's use of MIGRATE_CMA pages and the memory subsystem works very
> hard to keep about half of the memory in the CMA region free. There have
> been attempts to patch the CMA implementation to alter this behavior
> (for example the set I referenced Mel's response to in [1]), but there
> are users that desire the current behavior.

Optimizing that would be great, eventually making it configurable or 
selecting the behavior based on the actual CMA area sizes.

> 
>>
>> Why do we have to start using ZONE_MOVABLE for them?
> One of the "other opportunities" for Designated Movable Blocks is to
> allow CMA to allocate from a DMB as an alternative. This would allow
> current users to continue using CMA as they want, but would allow users
> (e.g. hugetlb_cma) that are not sensitive to the allocation latency to
> let the kernel page allocator make more complete use (i.e. waste less)
> of the shared memory. ZONE_MOVABLE pageblocks are always MIGRATE_MOVABLE
> so the restrictions placed on MIGRATE_CMA pageblocks are lifted within a
> DMB.

The whole purpose of ZONE_MOVABLE is that *no* unmovable allocations end 
up on it. The biggest difference to CMA is that the CMA *owner* is able 
to place unmovable allocations on it.

Using ZONE_MOVABLE for unmovable allocations (hugetlb_cma) is not 
acceptable as is.

Using ZONE_MOVABLE in different context and calling it DMB is very 
confusing TBH.

Just a note that I described the idea of a "PREFER_MOVABLE" zone in the 
past. In contrast to ZONE_MOVABLE, we cannot run into weird OOM 
situations in a ZONE misconfiguration, and we'd end up placing only 
movable allocations on it as long as we can. However, especially 
gigantic pages could be allocated from it. It sounds kind-of more like 
what you want -- and maybe in combination of daxctl to let the user 
decide how to online memory ranges.


And just to make it clear again: depending on ZONE_MOVABLE == only user 
space allocations is not future proof.

> 
>>
> Thanks for your consideration,
> Dough Baker ... I mean Doug Berger :).


:) Thanks Doug!

-- 
Thanks,

David / dhildenb

