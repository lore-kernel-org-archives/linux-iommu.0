Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D0115AC
	for <iommu@lists.linux.dev>; Wed, 14 Sep 2022 01:07:47 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id h28so9849148qka.0
        for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 18:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=plxos9uquFOD+IvTyP/oZn7J1wpWUgAiZjzQhRQDPPQ=;
        b=b5Ib02DcxbD8iGr+e9uO3ofxDa5NOXUgiKqm4v2kO2kVzLFaIksphZ+L5Zdbvek1wM
         Wmqq1e6M0COkpEIS2jTy/PtUgCdajEtU48nkMBXp1pD9XDM6s+PucJjIlGaVewK6jpAB
         MixvjHa8iEwvkFwCTzd4+IiI1JDNHjbquWMgFtpWgjJj6qqEw5WAYPSMVDEgpLo3HNek
         36boSZgTaGRXICe0uFLtjuI38uivs5RzA7nLftvI8tOPpKmyKy3pz/VsvafUilaTeUvi
         fcpstGUbfcwFK2RzmK6KZVIK3Hl4+3OGNIQyl05fWMzuh3cx6pq0kx437GIDICGwdU2D
         iecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=plxos9uquFOD+IvTyP/oZn7J1wpWUgAiZjzQhRQDPPQ=;
        b=w2h98znsDHjgW2nAGDK8Wlz/GqyV1fjYLB1EATGc0jilpxcNXHP8d63DP+XkXQLxIc
         Ni9MR77HGLex82j15kwZxF1ew7mTLQtnprqqO7CjQU/fV1bsI8I168TLWsVdQrWpixV7
         mzBTG6PP1w+ZFQQK6EINPkCqdZhv9FPd+JbpYnWHeqDqpaC1CDBR4P4vtYj0jHcQaGR2
         yRk+/uL1fNkwKeeNL7MC0mfHu5V3Z5E6tFDJEwSOYsrK5U50GW1fEGj9NateAzOEz2wT
         kv6vMZlXmd41k0KXaq2rqeTRoxXCGFvhbSQ3D129aSOIcDwX7stZzL9YvcPmwTz0nIp+
         Iztw==
X-Gm-Message-State: ACgBeo1wyMMgsM5XIrW22vp7UFKvwzxs60Eb00ly0XbM8mBp/Wlti4xC
	sgzev01zQhg1Akoe2LZwUOc=
X-Google-Smtp-Source: AA6agR6T8fHDs9UyqzsDp4Um9poKtPw3ia21pUGOlENIFjDdlRCXupm+CtiBRXcOgUDRfWYaL1iLtg==
X-Received: by 2002:a05:620a:4114:b0:6bb:33c2:45f9 with SMTP id j20-20020a05620a411400b006bb33c245f9mr24395201qko.374.1663117666899;
        Tue, 13 Sep 2022 18:07:46 -0700 (PDT)
Received: from [10.69.40.226] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id bs14-20020a05620a470e00b006b58d8f6181sm707879qkb.72.2022.09.13.18.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 18:07:45 -0700 (PDT)
Message-ID: <33ff9543-3396-7609-3865-7eed20b853f5@gmail.com>
Date: Tue, 13 Sep 2022 18:07:41 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 03/21] mm/hugetlb: correct demote page offset logic
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
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
 <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Oscar Salvador <osalvador@suse.de>, Hari Bathini <hbathini@linux.ibm.com>,
 Kees Cook <keescook@chromium.org>, - <devicetree-spec@vger.kernel.org>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux.dev
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <20220913195508.3511038-4-opendmb@gmail.com>
 <YyETeBdbldnoRZ+x@casper.infradead.org>
From: Doug Berger <opendmb@gmail.com>
In-Reply-To: <YyETeBdbldnoRZ+x@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/13/2022 4:34 PM, Matthew Wilcox wrote:
> On Tue, Sep 13, 2022 at 12:54:50PM -0700, Doug Berger wrote:
>> With gigantic pages it may not be true that struct page structures
>> are contiguous across the entire gigantic page. The mem_map_offset
>> function is used here in place of direct pointer arithmetic to
>> correct for this.
> 
> We're just eliminating mem_map_offset().  Please use nth_page()
> instead.That's good to know. I will include that in v2.

> 
>>   	for (i = 0; i < pages_per_huge_page(h);
>>   				i += pages_per_huge_page(target_hstate)) {
>> +		subpage = mem_map_offset(page, i);
>>   		if (hstate_is_gigantic(target_hstate))

