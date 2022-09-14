Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05434403
	for <iommu@lists.linux.dev>; Wed, 14 Sep 2022 17:30:51 +0000 (UTC)
Received: by mail-qv1-f45.google.com with SMTP id g4so12282964qvo.3
        for <iommu@lists.linux.dev>; Wed, 14 Sep 2022 10:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=0L27G4iP/cuKuBXoxBJrd9C7v+AkXXve2e5WgZmnPFM=;
        b=OwNpFg7qm3P6LQcskO6h973FuZ5ZH5pqPhL9rSvFWvFDrm4IqvH2rasrZoz63gaIVM
         QBxwZeFlhTErfLCFnU/hBTKbTzaucoDPNVe+ec0H2jDaK8Ebhzi4iLc4B30cdh5SIP+J
         U/u8Q+X/XTfAqwup7cUdIYBZy2FMkUqtyZkZx1xbRc2bYhX/D4AOCAU6cAR2wn7cwBTv
         b/PDf4eVJsqSWzv4DCt6F0Fc7zS9N2yOjUi4GsS5Wj91RFeCQIxdy5ahy+ncakDr8iB6
         Fxan9Mw9UOkoWGjPBTPYJun8O3wwAS+yMUT6j8hC6rwUjtVB9XEcsUqg/IOrwP18C5+W
         aNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=0L27G4iP/cuKuBXoxBJrd9C7v+AkXXve2e5WgZmnPFM=;
        b=ppRxCTpfggtdtNzyMumbzx5VMykQw/ydZGWlG4lrSU+Dgv14ZHFTmVxDVq3wNPtkiX
         HJ/aZn6un8sGnklwP7azDSl+4kGupvkbBJrXPSu//MaoPKN63pFuMWInRqAYrtd2Zb3r
         4h6sYO1bwWnXaEnrtJLyAKZUf4UCzulZOFkpovJ0MZjTpht/GxvN2sKIaT4nxLS/w/3o
         SP5Q5IWdSqMGHDZ4UFeNctMOmNNvgp5i5YDYCncLmaYGRXs3pSPMw0C6ytl7UrsW0lu3
         P7d3rxBSgUy21/wu0vMWKVnS3dj8DC4HtURzKrHGFfAA/r+gblqRxf3259JdZqW38mbj
         cvmQ==
X-Gm-Message-State: ACgBeo2fllCQZ1dqTw7ZFNqhUaUaXFs9PYCXJy0h5znUXnWKBXYmo0bz
	t/K6J+75gW4sFj8dtpqHtt8=
X-Google-Smtp-Source: AA6agR4NanY+oRAKCwumuYS4qynQNlgRdXUQ9CoMAaXbiNck4dr+MBmcWBG+TscWXqo8NNLfJw1SfA==
X-Received: by 2002:a05:6214:2aaa:b0:4ac:acbd:7ef8 with SMTP id js10-20020a0562142aaa00b004acacbd7ef8mr16025208qvb.126.1663176650653;
        Wed, 14 Sep 2022 10:30:50 -0700 (PDT)
Received: from [10.69.40.226] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x8-20020ac85388000000b0035bafecff78sm1838006qtp.74.2022.09.14.10.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 10:30:50 -0700 (PDT)
Message-ID: <4d715585-413d-a506-1bc0-1f12a0aec716@gmail.com>
Date: Wed, 14 Sep 2022 10:30:45 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 02/21] mm/hugetlb: correct max_huge_pages accounting on
 demote
Content-Language: en-US
To: Mike Kravetz <mike.kravetz@oracle.com>
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
 Florian Fainelli <f.fainelli@gmail.com>, David Hildenbrand
 <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Oscar Salvador <osalvador@suse.de>, Hari Bathini <hbathini@linux.ibm.com>,
 Kees Cook <keescook@chromium.org>, - <devicetree-spec@vger.kernel.org>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux.dev
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <20220913195508.3511038-3-opendmb@gmail.com> <YyIN+bpKdCb3JuuY@monkey>
From: Doug Berger <opendmb@gmail.com>
In-Reply-To: <YyIN+bpKdCb3JuuY@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/2022 10:23 AM, Mike Kravetz wrote:
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
Excellent! Thanks for the pointer and sorry for the noise.
-Doug
