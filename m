Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF252567
	for <iommu@lists.linux.dev>; Mon, 11 Jul 2022 10:24:54 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id v10-20020a05600c15ca00b003a2db8aa2c4so2746347wmf.2
        for <iommu@lists.linux.dev>; Mon, 11 Jul 2022 03:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TvTqqCDUEna97bn3dRoGEfTUf+bYfzYvHub5Bmfcni0=;
        b=MUGvDx8g0KClUUOFcs90au6+FanuvMY1PTcYDGVyOR+jsoKg/5ed6s+fNE/ccdGfdh
         wN/3Bvn6zVkULcpXhnxoBtqZxXhwZXVkskFbd3PBzwU6x5iHTS+qs3sAP2/kB1JBfG6U
         MuT4BUQS4OD8pUOBOYm8EbMArmedTDZDxEGgqkDik0ky95V08lqHI8R24LAbQBhbdSGF
         UYlvprMBfeeGtfdCJPhR8cm8vbeHDWnJl+2jIiXUPMCMXQjdnShET2+epSJCYcONNsH2
         owWQu3KNTWLTgnKlV9wHK5agUqYGMaYvA1t5pKK1T3ulj3brpjNNyB2hgvP2wLs5u2t4
         kE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TvTqqCDUEna97bn3dRoGEfTUf+bYfzYvHub5Bmfcni0=;
        b=fMecgVpCioa/fXy0oHxz8th2HR0iw/2B55NsmaRXq7AgH1UBW2eG533yplxg+ZJt5h
         K1mYh9azBUeO0MxDyAVPihYvClrtYEcVaZcUvYK39O3vFvQX6wLurKajL5I+c8/+4X1c
         2dLJ37ys6kwX4W6OHkcII5racTqB3F7izswzN1GwfBTQ9WqL0VK8FL7Scrh6B5LIM2CT
         QIp52ORuDfU29Jd1VcqJhmJeM/UMoK+RZfL+wugCrwgwRNGfu0hXLd3WKB9fMHVeogns
         AGqYYHOQK3hpVodk1ZQbt/WyTtV6WL3OoXkUt4NGJprosOUvWrspS8qGs6kggLCb6vhs
         oK1Q==
X-Gm-Message-State: AJIora/jP+RvgjuuyglCPV0evrClu/4G/VbnuXgy8HIk8Qydcmb0I8Ib
	R2W5kMl+xxxLIZU/BdnZo1pzSA==
X-Google-Smtp-Source: AGRyM1swswyk6K6Hpp5AUu/eyyOOlZu8PDhNMS8PZgnAZYMLG2pG5IQi2BZJvs3xOVmAzZx8Zpu8pA==
X-Received: by 2002:a1c:7707:0:b0:3a2:e9c6:f2f2 with SMTP id t7-20020a1c7707000000b003a2e9c6f2f2mr1569778wmi.102.1657535093079;
        Mon, 11 Jul 2022 03:24:53 -0700 (PDT)
Received: from [10.35.4.171] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id f16-20020a056000129000b0021d74906683sm5430339wrx.28.2022.07.11.03.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 03:24:52 -0700 (PDT)
Message-ID: <4fa8b709-c883-54dc-c302-20c9e55ae93a@sifive.com>
Date: Mon, 11 Jul 2022 11:24:51 +0100
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
To: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 iommu@lists.linux-foundation.org,
 Sudip Mukherjee <sudip.mukherjee@sifive.com>,
 Jude Onyenegecha <jude.onyenegecha@sifive.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <20220708170811.270589-1-ben.dooks@sifive.com>
 <fdf5d34e-7668-c05c-9098-30e34939c88a@arm.com>
 <683344bd-dc9b-0bb5-9377-b3e9ab410a74@sifive.com>
 <e6c43ef0-870b-5fe6-141e-0a3d566b030e@arm.com> <20220711102134.GB4639@lst.de>
From: Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <20220711102134.GB4639@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/07/2022 11:21, Christoph Hellwig wrote:
> On Mon, Jul 11, 2022 at 11:07:17AM +0100, Robin Murphy wrote:
>> If none of your peripherals should need SWIOTLB, then the fact that
>> you're ending up in swiotlb_map() at all is a clear sign that
>> something's wrong. Most likely someone's forgotten to set their DMA
>> masks correctly.
> 
> Yes.

Possibly, we had at least one driver which attempted to set a 32 bit
DMA mask which had to be removed as the DMA layer accepts this but
since there is no DMA32 memory the allocator then just fails.

I expect the above may need to be a separate discussion(s) of how to
default the DMA mask and how to stop the implicit acceptance of setting
a 32-bit DMA mask.
>>
>> However, by inspection it seems we do have a bug here as well, for which
>> the correct fix should be as below. The fireworks you're *supposed* to
>> get in that situation are considerably louder and more obvious than a
>> DEBUG_SPINLOCK complaint ;)
> 
> This looks sensible, I'll pick it up.

