Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E53C4403
	for <iommu@lists.linux.dev>; Wed, 14 Sep 2022 17:27:57 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id d17so10637505qko.13
        for <iommu@lists.linux.dev>; Wed, 14 Sep 2022 10:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=QyRGzlkoFcQG3CIMtJPpDZn+hUgACTBPPomMcutX19k=;
        b=Pn4nqjxVEX/40MaS2pCNxckO6W0GVqjplLgc4YUpDc+NUzQMdvYp+h9a2SUbKePdNf
         y8kZjtKbeOf8fVif7+dfDenYS/1jVYV5uoFoAs/cY4uIPSj19owpvWNd7wx/0m0l7rws
         oecBLvmQr6nar/9/rUQmFR9ltOIqaaW68CcY5Kgo8ysxDTvO6RFaQqmmpD1CQ5gzcJXf
         OFxlH1/pZ06zBltHk8fY4h1CK4yGsoQUovRnAPOdclXozylg4qtr0bgrQJa/egKMEPOb
         B6ZmZiy3RVdEFGRF2KkrY1qTREOETvJsBmdX8yhjBlcH4gn8S8Vz2XX1XviQtC12zn6h
         pu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QyRGzlkoFcQG3CIMtJPpDZn+hUgACTBPPomMcutX19k=;
        b=110KsO06zFgtb7mfb4v0Dwc01m2rqtX+mH1DWcJjHkkL934jRARq7pJOUYrvyKnSoL
         XSDdV5/jVcoYS+Wu6M6bjF2mtlv0rOrwH1f3uA0jawrIVB4g6YXfds8ZhFB26nDt8kNW
         A7195McUrSYYNiGDSGtuZDWeHoUwBeokrcPCDFdWMmMd4xtInHHTGSQqdzDhPrE2kb7d
         MCj0sHkYbFgweixyVRmA9jxXV6d3CHfwWv9S5LOe/aeLE5Xd1oq3laInbCOph5UmSw2A
         hlJme4e0wG7MF6046QqT/53Kq27YObRbtM26YFON+5nmtvZAYQfmk+16NMyEnA0a1m+4
         wNVQ==
X-Gm-Message-State: ACgBeo1sAYcjnODZdDJcodbZMm/oILuMkBd4bzVdTg5XSGgRZJFmkTSJ
	cOCu61Y4sZyBdTmxkSFujko=
X-Google-Smtp-Source: AA6agR5pvM1OqTJhrtgIA3p55nJJ77rDjYUI3TvVtLJ4yP/4XiCqo9RIOd8UUqhIagFXgfBGt0vKFQ==
X-Received: by 2002:a05:620a:24d6:b0:6cd:f96a:35b with SMTP id m22-20020a05620a24d600b006cdf96a035bmr15502737qkn.471.1663176476372;
        Wed, 14 Sep 2022 10:27:56 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d1-20020ac85341000000b0035ba48c032asm1838553qto.25.2022.09.14.10.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 10:27:55 -0700 (PDT)
Message-ID: <c4d40567-6ac6-d822-7098-a5ad1ae567ec@gmail.com>
Date: Wed, 14 Sep 2022 10:26:48 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 02/21] mm/hugetlb: correct max_huge_pages accounting on
 demote
Content-Language: en-US
To: Mike Kravetz <mike.kravetz@oracle.com>, Doug Berger <opendmb@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Frank Rowand <frowand.list@gmail.com>, Muchun Song
 <songmuchun@bytedance.com>, Mike Rapoport <rppt@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Borislav Petkov <bp@suse.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <quic_neeraju@quicinc.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Oscar Salvador <osalvador@suse.de>, Hari Bathini <hbathini@linux.ibm.com>,
 Kees Cook <keescook@chromium.org>, - <devicetree-spec@vger.kernel.org>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux.dev
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <20220913195508.3511038-3-opendmb@gmail.com> <YyIN+bpKdCb3JuuY@monkey>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <YyIN+bpKdCb3JuuY@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/22 10:23, Mike Kravetz wrote:
> On 09/13/22 12:54, Doug Berger wrote:
>> When demoting a hugepage to a smaller order, the number of pages
>> added to the target hstate will be the size of the large page
>> divided by the size of the smaller page.
>>
>> Fixes: 8531fc6f52f5 ("hugetlb: add hugetlb demote page support")
>> Signed-off-by: Doug Berger <opendmb@gmail.com>
>> ---
>>   mm/hugetlb.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index e070b8593b37..79949893ac12 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -3472,7 +3472,8 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
>>   	 * based on pool changes for the demoted page.
>>   	 */
>>   	h->max_huge_pages--;
>> -	target_hstate->max_huge_pages += pages_per_huge_page(h);
>> +	target_hstate->max_huge_pages += pages_per_huge_page(h) /
>> +					 pages_per_huge_page(target_hstate);
>>   
>>   	return rc;
>>   }
> 
> This has already been fixed here,
> 
> https://lore.kernel.org/linux-mm/20220823030209.57434-2-linmiaohe@huawei.com/
> 

Could we slap the Fixes tag when this Miaohe's patch series gets 
accepted since the offending commit is in v5.16 and beyond. Thanks!
-- 
Florian
