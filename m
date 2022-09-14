Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638B415AC
	for <iommu@lists.linux.dev>; Wed, 14 Sep 2022 00:59:50 +0000 (UTC)
Received: by mail-qk1-f173.google.com with SMTP id d17so9035447qko.13
        for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 17:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=7Ygc2a7zFUOpTRr5fFVTb8yN9D9ZfZYmNOPFpvUHUuQ=;
        b=lKEY2q7aar6XrlZKbMIH4phInaENFrHa/YSCJMCVoQzEjsT1ha6NBBahCldNIhKBg4
         wv0rE9xxFElY9UOciw0vh2x1IadY5l/UsfM285e044N65AdVPKTpbHSspLiUG+icLVNu
         syzXtky3e4G/wtKhPUaEEvsVbAgsMJXsrRF1HZ+J5DHfu4WD7/p+9xjWkuMwxU5BBcuX
         mQNx+cHcsVyGmw5nDhHekXil1IlNaZpy/DSUwLoO4+54ajKFSQZp/1ZJDlfPWChfzl7d
         FVVTNAFbX0Y1xTCA8DpRL1Qm6gFb2VU8eqJAxGVX0qHUVZMq7aGNqUJ0hKqKwdxbkoxK
         6Jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7Ygc2a7zFUOpTRr5fFVTb8yN9D9ZfZYmNOPFpvUHUuQ=;
        b=NyZmJDFsy0UNZWStUfUUryEUElYpNf/5/PelU+N07ug4puK3LLtKG8/0kVLGuPg8nG
         VwBrgtipcHxCipx2sjIwbJZR/mhH9bPykhmrbFH1D0iLeGRVCaFoYel1yEUlx6PxSniS
         NDf6yZR/pRBettj00Wbqt4HaK9M7L3TCbbg6KgtJulYz9HVjrnFgXhiO491Tgat6Z+3l
         FQN9t/Q7HDLwW0jg0t3L8aX9be8+FrmvNJpx88zHcskvz47yQFrDiU3je4tftezfUflM
         GJ4K5OCiJo1bCVrXrbZysf1gkl+7XgmrYsL9RF9U7VOpKRw+mqv21Uo9x5WKAOpCxz/2
         UVcA==
X-Gm-Message-State: ACgBeo02681NutAx3ukhLp4bTDGO/8a2weKvCYfCnaZwdnWc79WuJmvH
	tvj/gmB5F5MCOiODf97/9rs=
X-Google-Smtp-Source: AA6agR7dMWGP0iSvZ0sXq9Rz8YJoklcIXN65K7aCsyYoukqmr7ac1lgNLDoGTHUroAxGyFnrlIvjFQ==
X-Received: by 2002:a05:620a:2685:b0:6bc:374a:8f44 with SMTP id c5-20020a05620a268500b006bc374a8f44mr24790219qkp.165.1663117189214;
        Tue, 13 Sep 2022 17:59:49 -0700 (PDT)
Received: from [10.69.40.226] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h3-20020a05620a244300b006ce3fcee2bdsm865004qkn.50.2022.09.13.17.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 17:59:48 -0700 (PDT)
Message-ID: <ff84d89b-6d4f-c739-63be-4c4825b1fd03@gmail.com>
Date: Tue, 13 Sep 2022 17:59:43 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 01/21] mm/page_isolation: protect cma from
 isolate_single_pageblock
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
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
 Florian Fainelli <f.fainelli@gmail.com>, David Hildenbrand
 <david@redhat.com>, Oscar Salvador <osalvador@suse.de>,
 Hari Bathini <hbathini@linux.ibm.com>, Kees Cook <keescook@chromium.org>,
 - <devicetree-spec@vger.kernel.org>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux.dev
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <20220913195508.3511038-2-opendmb@gmail.com>
 <36E322BF-F052-4A8B-9FA5-4E0AA84E4AAF@nvidia.com>
Content-Language: en-US
From: Doug Berger <opendmb@gmail.com>
In-Reply-To: <36E322BF-F052-4A8B-9FA5-4E0AA84E4AAF@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/13/2022 5:02 PM, Zi Yan wrote:
> On 13 Sep 2022, at 15:54, Doug Berger wrote:
> 
>> The function set_migratetype_isolate() has special handling for
>> pageblocks of MIGRATE_CMA type that protects them from being
>> isolated for MIGRATE_MOVABLE requests.
>>
>> Since isolate_single_pageblock() doesn't receive the migratetype
>> argument of start_isolate_page_range() it used the migratetype
>> of the pageblock instead of the requested migratetype which
>> defeats this MIGRATE_CMA check.
>>
>> This allows an attempt to create a gigantic page within a CMA
>> region to change the migratetype of the first and last pageblocks
>> from MIGRATE_CMA to MIGRATE_MOVABLE when they are restored after
>> failure, which corrupts the CMA region.
>>
>> The calls to (un)set_migratetype_isolate() for the first and last
>> pageblocks of the start_isolate_page_range() are moved back into
>> that function to allow access to its migratetype argument and make
>> it easier to see how all of the pageblocks in the range are
>> isolated.
>>
>> Fixes: b2c9e2fbba32 ("mm: make alloc_contig_range work at pageblock granularity")
>> Signed-off-by: Doug Berger <opendmb@gmail.com>
>> ---
>>   mm/page_isolation.c | 75 +++++++++++++++++++++------------------------
>>   1 file changed, 35 insertions(+), 40 deletions(-)
> 
> Thanks for the fix.
Thanks for the review.

> 
> Why not just pass migratetype into isolate_single_pageblock() and use
> it when set_migratetype_isolate() is used? That would have much
> fewer changes. What is the reason of pulling skip isolation logic out?
I found the skip_isolation logic confusing and thought that setting and 
restoring the migratetype within the same function and consolidating the 
error recovery paths also within that function was easier to understand 
and less prone to accidental breakage.

In particular, setting MIGRATE_ISOLATE in isolate_single_pageblock() and 
having to remember to unset it in start_isolate_page_range() differently 
on different error paths was troublesome for me.

It could certainly be done differently, but this was my preference.

> 
> Ultimately, I would like to make MIGRATE_ISOLATE a separate bit,
> so that migratetype will not be overwritten during page isolation.
> Then, set_migratetype_isolate() and start_isolate_page_range()
> will not have migratetype to set in error recovery any more.
> That is on my TODO.
> 
>>
>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>> index 9d73dc38e3d7..8e16aa22cb61 100644
>> --- a/mm/page_isolation.c
>> +++ b/mm/page_isolation.c
>> @@ -286,8 +286,6 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>>    * @flags:			isolation flags
>>    * @gfp_flags:			GFP flags used for migrating pages
>>    * @isolate_before:	isolate the pageblock before the boundary_pfn
>> - * @skip_isolation:	the flag to skip the pageblock isolation in second
>> - *			isolate_single_pageblock()
>>    *
>>    * Free and in-use pages can be as big as MAX_ORDER-1 and contain more than one
>>    * pageblock. When not all pageblocks within a page are isolated at the same
>> @@ -302,9 +300,8 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>>    * the in-use page then splitting the free page.
>>    */
>>   static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>> -			gfp_t gfp_flags, bool isolate_before, bool skip_isolation)
>> +			gfp_t gfp_flags, bool isolate_before)
>>   {
>> -	unsigned char saved_mt;
>>   	unsigned long start_pfn;
>>   	unsigned long isolate_pageblock;
>>   	unsigned long pfn;
>> @@ -328,18 +325,6 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>>   	start_pfn  = max(ALIGN_DOWN(isolate_pageblock, MAX_ORDER_NR_PAGES),
>>   				      zone->zone_start_pfn);
>>
>> -	saved_mt = get_pageblock_migratetype(pfn_to_page(isolate_pageblock));
>> -
>> -	if (skip_isolation)
>> -		VM_BUG_ON(!is_migrate_isolate(saved_mt));
>> -	else {
>> -		ret = set_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt, flags,
>> -				isolate_pageblock, isolate_pageblock + pageblock_nr_pages);
>> -
>> -		if (ret)
>> -			return ret;
>> -	}
>> -
>>   	/*
>>   	 * Bail out early when the to-be-isolated pageblock does not form
>>   	 * a free or in-use page across boundary_pfn:
>> @@ -428,7 +413,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>>   					ret = set_migratetype_isolate(page, page_mt,
>>   						flags, head_pfn, head_pfn + nr_pages);
>>   					if (ret)
>> -						goto failed;
>> +						return ret;
>>   				}
>>
>>   				ret = __alloc_contig_migrate_range(&cc, head_pfn,
>> @@ -443,7 +428,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>>   					unset_migratetype_isolate(page, page_mt);
>>
>>   				if (ret)
>> -					goto failed;
>> +					return -EBUSY;
>>   				/*
>>   				 * reset pfn to the head of the free page, so
>>   				 * that the free page handling code above can split
>> @@ -459,24 +444,19 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>>   				while (!PageBuddy(pfn_to_page(outer_pfn))) {
>>   					/* stop if we cannot find the free page */
>>   					if (++order >= MAX_ORDER)
>> -						goto failed;
>> +						return -EBUSY;
>>   					outer_pfn &= ~0UL << order;
>>   				}
>>   				pfn = outer_pfn;
>>   				continue;
>>   			} else
>>   #endif
>> -				goto failed;
>> +				return -EBUSY;
>>   		}
>>
>>   		pfn++;
>>   	}
>>   	return 0;
>> -failed:
>> -	/* restore the original migratetype */
>> -	if (!skip_isolation)
>> -		unset_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt);
>> -	return -EBUSY;
>>   }
>>
>>   /**
>> @@ -534,21 +514,30 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>>   	unsigned long isolate_start = ALIGN_DOWN(start_pfn, pageblock_nr_pages);
>>   	unsigned long isolate_end = ALIGN(end_pfn, pageblock_nr_pages);
>>   	int ret;
>> -	bool skip_isolation = false;
>>
>>   	/* isolate [isolate_start, isolate_start + pageblock_nr_pages) pageblock */
>> -	ret = isolate_single_pageblock(isolate_start, flags, gfp_flags, false, skip_isolation);
>> +	ret = set_migratetype_isolate(pfn_to_page(isolate_start), migratetype,
>> +			flags, isolate_start, isolate_start + pageblock_nr_pages);
>>   	if (ret)
>>   		return ret;
>> -
>> -	if (isolate_start == isolate_end - pageblock_nr_pages)
>> -		skip_isolation = true;
>> +	ret = isolate_single_pageblock(isolate_start, flags, gfp_flags, false);
>> +	if (ret)
>> +		goto unset_start_block;
>>
>>   	/* isolate [isolate_end - pageblock_nr_pages, isolate_end) pageblock */
>> -	ret = isolate_single_pageblock(isolate_end, flags, gfp_flags, true, skip_isolation);
>> +	pfn = isolate_end - pageblock_nr_pages;
>> +	if (isolate_start != pfn) {
>> +		ret = set_migratetype_isolate(pfn_to_page(pfn), migratetype,
>> +				flags, pfn, pfn + pageblock_nr_pages);
>> +		if (ret)
>> +			goto unset_start_block;
>> +	}
>> +	ret = isolate_single_pageblock(isolate_end, flags, gfp_flags, true);
>>   	if (ret) {
>> -		unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
>> -		return ret;
>> +		if (isolate_start != pfn)
>> +			goto unset_end_block;
>> +		else
>> +			goto unset_start_block;
>>   	}
>>
>>   	/* skip isolated pageblocks at the beginning and end */
>> @@ -557,15 +546,21 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>>   	     pfn += pageblock_nr_pages) {
>>   		page = __first_valid_page(pfn, pageblock_nr_pages);
>>   		if (page && set_migratetype_isolate(page, migratetype, flags,
>> -					start_pfn, end_pfn)) {
>> -			undo_isolate_page_range(isolate_start, pfn, migratetype);
>> -			unset_migratetype_isolate(
>> -				pfn_to_page(isolate_end - pageblock_nr_pages),
>> -				migratetype);
>> -			return -EBUSY;
>> -		}
>> +					start_pfn, end_pfn))
>> +			goto unset_isolated_blocks;
>>   	}
>>   	return 0;
>> +
>> +unset_isolated_blocks:
>> +	ret = -EBUSY;
>> +	undo_isolate_page_range(isolate_start + pageblock_nr_pages, pfn,
>> +				migratetype);
>> +unset_end_block:
>> +	unset_migratetype_isolate(pfn_to_page(isolate_end - pageblock_nr_pages),
>> +				  migratetype);
>> +unset_start_block:
>> +	unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
>> +	return ret;
>>   }
>>
>>   /*
>> -- 
>> 2.25.1
> 
> 
> --
> Best Regards,
> Yan, Zi

