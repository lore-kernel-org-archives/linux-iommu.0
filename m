Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8169B3C1D
	for <iommu@lists.linux.dev>; Mon, 11 Jul 2022 10:42:46 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id v14so6431664wra.5
        for <iommu@lists.linux.dev>; Mon, 11 Jul 2022 03:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4EsrGLApiR7KrR1xe+qurlpT+LNNhJnrtqXG7Ct5qrg=;
        b=mBQ2tztMqWmZzMu8saxlYgxtl18KpAj78UtlG8syY6uZgAhZLM4LaHwE8b+pOSr7hS
         8P2+PoZ0Lgbvc39aLBqyanCJ33Mp30b/GPrixov9DM6+4NMexNzMeadogihoYvXVOqsh
         LUtFG5kzfp5t5bDAcpBb5x/g8d0ffk2k1JbKSCtfaXU5RJ1I5rHnKKlH1sNH7aihTr1L
         D9Q5GtRIy80EhNV1tDvG+OvhExwbnBWEf6eaLNvsLp3YIT/yRpTzE61P9IS7YG87yQ/a
         6uIGoHm4NWMSVhFYu9jHwDVzPfE8d5oiAGkv7mrvy2iFgJotaRla7e3tn8FJXfQcsvxL
         tjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4EsrGLApiR7KrR1xe+qurlpT+LNNhJnrtqXG7Ct5qrg=;
        b=Ynf/qhrMN80yPHJ1kzFCd1RtESyiogaenBGVBDslrbox6TzvrSN3WbuPuikqKDYIUh
         BC3AfUzgy9ngDpiuEcTeLwtwRB7GsWBurrK2w8xd6Q42hAln0oGuhOj7icg5xAZCzwY5
         Zc6QZCIKYldvT0aityQ2GXBASblmsouYVP6/HITDEYlcO2rDc9NLcqxvaT337zdp/Q0E
         GYNzEA6AMomaQoVteiDkf1BRLL/OzZzP/mE70FuoN5Ek+H8ZVE0JCH6tzAAvi9Yo76Aw
         PKiO+HoVtEBqsYak9NxNBixxZ7rq7upqswJCeRQr5g7Csulz8/v0D5FJEez1tlhHIZf7
         TVPQ==
X-Gm-Message-State: AJIora8j1XaNkuGDClqfhCiH0JDbegVsUAwaKZ3zZgT93mK39G4B6AVh
	9jT6hu4JcDUBWsBwWSKMfKp2Ig==
X-Google-Smtp-Source: AGRyM1sEB9+GDlLklpISpqNfzr+fBlk8GhUJnAMJ+JjMDQ1mQwHG2E1B/C0mLWNhigPNUqJnLchWXg==
X-Received: by 2002:a5d:60c1:0:b0:21d:7469:9687 with SMTP id x1-20020a5d60c1000000b0021d74699687mr15945574wrt.361.1657536164868;
        Mon, 11 Jul 2022 03:42:44 -0700 (PDT)
Received: from [10.35.4.171] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id m14-20020a5d624e000000b0021b9585276dsm5425864wrv.101.2022.07.11.03.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 03:42:44 -0700 (PDT)
Message-ID: <43426798-44df-c2c7-1f46-0b79201cb620@sifive.com>
Date: Mon, 11 Jul 2022 11:42:43 +0100
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
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, iommu@lists.linux-foundation.org,
 Sudip Mukherjee <sudip.mukherjee@sifive.com>,
 Jude Onyenegecha <jude.onyenegecha@sifive.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <20220708170811.270589-1-ben.dooks@sifive.com>
 <fdf5d34e-7668-c05c-9098-30e34939c88a@arm.com>
 <683344bd-dc9b-0bb5-9377-b3e9ab410a74@sifive.com>
 <e6c43ef0-870b-5fe6-141e-0a3d566b030e@arm.com> <20220711102134.GB4639@lst.de>
 <4fa8b709-c883-54dc-c302-20c9e55ae93a@sifive.com>
 <20220711103921.GA6542@lst.de>
From: Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <20220711103921.GA6542@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/07/2022 11:39, Christoph Hellwig wrote:
> On Mon, Jul 11, 2022 at 11:24:51AM +0100, Ben Dooks wrote:
>> On 11/07/2022 11:21, Christoph Hellwig wrote:
>>> On Mon, Jul 11, 2022 at 11:07:17AM +0100, Robin Murphy wrote:
>>>> If none of your peripherals should need SWIOTLB, then the fact that
>>>> you're ending up in swiotlb_map() at all is a clear sign that
>>>> something's wrong. Most likely someone's forgotten to set their DMA
>>>> masks correctly.
>>>
>>> Yes.
>>
>> Possibly, we had at least one driver which attempted to set a 32 bit
>> DMA mask which had to be removed as the DMA layer accepts this but
>> since there is no DMA32 memory the allocator then just fails.
>>
>> I expect the above may need to be a separate discussion(s) of how to
>> default the DMA mask and how to stop the implicit acceptance of setting
>> a 32-bit DMA mask.
> 
> No.  Linux simply assumes you can do 32-bit DMA and this won't
> change.  So we'll need to fix your platform to support swiotlb
> eventually.

Ok, is there any examples currently in the kernel that have no memory
in the DMA32 zone that do use swiotlb?
