Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDE27A
	for <iommu@lists.linux.dev>; Mon, 11 Jul 2022 12:54:15 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id r14so6902752wrg.1
        for <iommu@lists.linux.dev>; Mon, 11 Jul 2022 05:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zjEIh4DqFEXRLYwuzGFMNC/3I63SrKxPqVblwnhPmog=;
        b=kJA/NAnsNsjB3IBO7apOW66xuZ2zMyaJxMhEURJWw1AwKCAKPExd0qEE3n+vu0wSYb
         CS2PCCgRiEn3I6CslpnOCHwUorwpj6K8k0IgRrGFjn824TgreOnqK8tZwz+4vfN8ytgY
         icHgMkdCeKHMWvpsvaIfl939GMlDT3Qfw1YZeoJpC7HsKakEY/QZ029hacHl7TBQ5pR9
         T8x1tiwT5HOx9mCxfaGA3AD7/N8EPrOe/P1BZODfpGh3dWB3/5Lo62edJA4b4ZuQlkzc
         QXuK6qboNB9OK+040ZMV4tHRgRGIZnmjgeJcXRYLtq4GJCmnNeioX+AgmHjI6JgKEg2b
         kf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zjEIh4DqFEXRLYwuzGFMNC/3I63SrKxPqVblwnhPmog=;
        b=hSGWPeUzHjNYFmmrqdePpLcuY5rbut/QWH8j/+Uzn0CjAUkoujqcnMEzmKzEcBZpkZ
         mg+MglBLdfEayhYFQF+ewD13hKcFnTIlfjDmVTRpe1r1HAmUuEkCY/l2AxM1K8nqxK5b
         u5Y+tLhP2zOUMku+fLKdcYqkRY/bBLONeRrwlmuXMImv2qHx037lU0qT/4KzNH5g1Eol
         S77HIQQ2L4SWJriDzU7f/6i1QDOBQ46DW2S8pEUaEF915nudKN0BCuocDqAzh/5TIG9l
         PbyPcwohaS2OO0Bl1s2/2BSveBpPLKrbdVNRK+OO9eT/F9qOuacyqMBA9Cr7sAJL+Dmo
         ni2g==
X-Gm-Message-State: AJIora9OMJcVFd2HPiQedpyEjMHYJUYkvBul3S4nOv8Avtk7VpRAy8PA
	LaOVyNARX1XObCwvqdIjwsuuVw==
X-Google-Smtp-Source: AGRyM1sEUkePYczWBSqEyhSQyn8LZryJCwMsuoh8eIAEeLas5yuDPs6yaRkyucKd4Hlu6ig/uWlZRw==
X-Received: by 2002:a5d:4a01:0:b0:21d:8ce1:8b6d with SMTP id m1-20020a5d4a01000000b0021d8ce18b6dmr16532000wrq.718.1657544053570;
        Mon, 11 Jul 2022 05:54:13 -0700 (PDT)
Received: from [10.35.4.171] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id l5-20020a05600c4f0500b003a04e6410e0sm10142773wmq.33.2022.07.11.05.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 05:54:12 -0700 (PDT)
Message-ID: <265d7b6b-a0a4-ecaf-10bd-15e1ea416a06@sifive.com>
Date: Mon, 11 Jul 2022 13:54:11 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] swiotlb: ensure io_tlb_default_mem spinlock always
 initialised
Content-Language: en-GB
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 iommu@lists.linux-foundation.org,
 Sudip Mukherjee <sudip.mukherjee@sifive.com>,
 Jude Onyenegecha <jude.onyenegecha@sifive.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <20220708170811.270589-1-ben.dooks@sifive.com>
 <fdf5d34e-7668-c05c-9098-30e34939c88a@arm.com>
 <683344bd-dc9b-0bb5-9377-b3e9ab410a74@sifive.com>
 <e6c43ef0-870b-5fe6-141e-0a3d566b030e@arm.com> <20220711102134.GB4639@lst.de>
 <4fa8b709-c883-54dc-c302-20c9e55ae93a@sifive.com>
 <20220711103921.GA6542@lst.de>
 <43426798-44df-c2c7-1f46-0b79201cb620@sifive.com>
 <ac4944b8-5d15-4761-6315-7dba6eaee0e7@arm.com>
From: Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <ac4944b8-5d15-4761-6315-7dba6eaee0e7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/07/2022 12:01, Robin Murphy wrote:
> On 2022-07-11 11:42, Ben Dooks wrote:
>> On 11/07/2022 11:39, Christoph Hellwig wrote:
>>> On Mon, Jul 11, 2022 at 11:24:51AM +0100, Ben Dooks wrote:
>>>> On 11/07/2022 11:21, Christoph Hellwig wrote:
>>>>> On Mon, Jul 11, 2022 at 11:07:17AM +0100, Robin Murphy wrote:
>>>>>> If none of your peripherals should need SWIOTLB, then the fact that
>>>>>> you're ending up in swiotlb_map() at all is a clear sign that
>>>>>> something's wrong. Most likely someone's forgotten to set their DMA
>>>>>> masks correctly.
>>>>>
>>>>> Yes.
>>>>
>>>> Possibly, we had at least one driver which attempted to set a 32 bit
>>>> DMA mask which had to be removed as the DMA layer accepts this but
>>>> since there is no DMA32 memory the allocator then just fails.
>>>>
>>>> I expect the above may need to be a separate discussion(s) of how to
>>>> default the DMA mask and how to stop the implicit acceptance of setting
>>>> a 32-bit DMA mask.
>>>
>>> No.  Linux simply assumes you can do 32-bit DMA and this won't
>>> change.  So we'll need to fix your platform to support swiotlb
>>> eventually.
>>
>> Ok, is there any examples currently in the kernel that have no memory
>> in the DMA32 zone that do use swiotlb?
> 
> The arm64 code originally made an assumption that a system with that 
> kind of memory layout would use a DMA offset in the interconnect, and so 
> placed ZONE_DMA32 in the first 4GB of available RAM rather than actual 
> physical address space. The only relatively mainstream platform we 
> subsequently saw with all RAM above 32 bits was AMD Seattle, which also 
> *didn't* use a DMA offset, so it "worked" by virtue of this bodge in the 
> sense that allocations didn't fail, but DMA transactions would then 
> disappear off into nowhere when the device truncated the MSBs of 
> whatever too-big DMA address it was given.
> 
> I think that stuff's long gone by now, and if any of handful of 
> remaining Seattle users plug in a 32-bit PCIe device and try to use it 
> with the IOMMU disabled, they'll probably see the fireworks as intended.
> 
> Much as we'd like to make DMA an explicit opt-in for all drivers, that's 
> something which can only really be solved 30 years ago.

I need to go back and check through what we did to get some that worked
for us, and then come back and try and make some idea of how that is
best done with upstream kernel.

It might be possible for the PCIe controller to do some sort of very
simple IOMMU for the case where we might have somehow an PCI device
added to the system, but that is a very rare use-case I expect and
if someone does it they can do the effort of updating the PCIe code
and everything else that goes with it.

-- 
Ben

