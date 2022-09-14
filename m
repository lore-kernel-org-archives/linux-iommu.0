Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746D83FF9
	for <iommu@lists.linux.dev>; Wed, 14 Sep 2022 16:57:41 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id c19so9435183qkm.7
        for <iommu@lists.linux.dev>; Wed, 14 Sep 2022 09:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=UWYZ+LvZVhpAV6ZQBWEOlqo/TbgQPhE93gUN5h4Opa4=;
        b=lBXUbs9pZpO+yTmR2jdfhmRm/kBSeGhEo/6IKheeNxrOaZ+SSStX4UyGbG7noCTZnL
         lp4GNVPC+yuVX066hyg9SZyWVQUc+v0zWdguOY/nmscUyeDVvKy5jSWZaO+xzphOdvAQ
         aTsC9QANMQ3cKIIiE6++nnjm/oB7778JyBSse4UwGosbGCTpuV7jvDE16vVWkNMCWqqr
         paslr3euDOvfLPglAFtll6BbrIEH7G9dDqqDsbt8U2peyjwbTzpRL2hP2NTerae1SkXT
         SVn4fudGRJTBSCtwGh1X5bX9nACK+SBbNtTAxaGYxsK9dZyA1/5h4e4DVMpUTdy67eBY
         DA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=UWYZ+LvZVhpAV6ZQBWEOlqo/TbgQPhE93gUN5h4Opa4=;
        b=jA3/TdArQZNYBZdhipylohGQkdg+G01jeXaEyyhMpWG8R1EzOO38IS8qn4W7MPe4pr
         jaGc6aagW00mHNUCDIrAIQXk2t3EyM4SnSwCy+z7QJ2HUp0nI102g04MfFPR5/sWeCXo
         71x7a7XSNg8GiknnpN5y2jvMLDN+3IzFL1HZteOiea4Spl0YfAFVn2raTfjqyrTFiZ+f
         Cn5q+nIpVKAOnKjmt1SQ6WtdbWsauXLVBCcAudJ78ELo/4A3iyxApBJXf9Mt7gcKurFz
         p8kdD5se1c0o11A9KD+bgngJKUooQy3tY3BahAjzkG3lqoqvnCsRtTg/fTZDhnVD85qc
         FrUQ==
X-Gm-Message-State: ACgBeo3isLYGLlKPnBDHLQC4oCIBaq2KMHFAdcce8q1WEN1AxZx27Q+i
	+2m/CnGqkw7+l0xWDD+dLOk=
X-Google-Smtp-Source: AA6agR6Wu36k8hHB+/9VV1slDHLKSuMtkQx48tsI3xnwZirYVolN/T5Srax7wN9UvBnxLS0DXw6nUw==
X-Received: by 2002:a05:620a:13ae:b0:6ce:5926:1511 with SMTP id m14-20020a05620a13ae00b006ce59261511mr9345627qki.431.1663174660232;
        Wed, 14 Sep 2022 09:57:40 -0700 (PDT)
Received: from [10.69.40.226] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id b3-20020a05620a118300b006b8f4ade2c9sm2051740qkk.19.2022.09.14.09.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 09:57:38 -0700 (PDT)
Message-ID: <1825234b-f17a-dea4-38f6-ba5881ab9a3d@gmail.com>
Date: Wed, 14 Sep 2022 09:57:35 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 00/21] mm: introduce Designated Movable Blocks
Content-Language: en-US
To: Rob Herring <robh+dt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>,
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
 Mel Gorman <mgorman@suse.de>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 devicetree@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
 iommu@lists.linux.dev
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <CAL_JsqLmJcLHViPaBPvkBhR4xi+ZQuAJQpXoiJLVRW9EH4EX0Q@mail.gmail.com>
From: Doug Berger <opendmb@gmail.com>
In-Reply-To: <CAL_JsqLmJcLHViPaBPvkBhR4xi+ZQuAJQpXoiJLVRW9EH4EX0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/2022 6:21 AM, Rob Herring wrote:
> On Tue, Sep 13, 2022 at 2:57 PM Doug Berger <opendmb@gmail.com> wrote:
>>
>> MOTIVATION:
>> Some Broadcom devices (e.g. 7445, 7278) contain multiple memory
>> controllers with each mapped in a different address range within
>> a Uniform Memory Architecture. Some users of these systems have
>> expressed the desire to locate ZONE_MOVABLE memory on each
>> memory controller to allow user space intensive processing to
>> make better use of the additional memory bandwidth.
>> Unfortunately, the historical monotonic layout of zones would
>> mean that if the lowest addressed memory controller contains
>> ZONE_MOVABLE memory then all of the memory available from
>> memory controllers at higher addresses must also be in the
>> ZONE_MOVABLE zone. This would force all kernel memory accesses
>> onto the lowest addressed memory controller and significantly
>> reduce the amount of memory available for non-movable
>> allocations.
> 
> Why are you sending kernel patches to the Devicetree specification list?
> 
> Rob
My apologies if this is a problem. No offense was intended.

My process has been to run my patches through get_maintainers.pl to get 
the list of addresses to copy on submissions and my 
0016-dt-bindings-reserved-memory-introduce-designated-mov.patch 
solicited the
'- <devicetree-spec@vger.kernel.org>' address.

My preference when reviewing is to receive an entire patch set to 
understand the context of an individual commit, but I can certainly 
understand that others may have different preferences.

It was my understanding that the Devicetree specification list was part 
of the kernel (e.g. @vger.kernel.org) and would be willing to receive 
patches that might be of relevance to it.

I am inexperienced with yaml and devicetree processes in general so I 
have tried to lean on the examples of other reserved-memory node 
bindings for help.

There is much to learn and I am happy to modify my process to better 
accommodate your needs.

Regards,
     Doug
