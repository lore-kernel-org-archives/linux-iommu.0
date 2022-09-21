Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DA310F2
	for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 00:14:18 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id mi14so3216779qvb.12
        for <iommu@lists.linux.dev>; Tue, 20 Sep 2022 17:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=aCeri+hfbuGIwO2XasovhLElcJko/KHACF2kQywU+Xo=;
        b=If+MVDYKpBHxaIB4RO733GlHC9AgB/S8wxARAO0Yu2x2ErGE/GTuzjpMe/QwUZDVF1
         uV3wYZAIs/u+DWdmd5Eg9oeeEm/zkDhrYJiV1DMf11R1+XMFVdouH94UTJTJ1AU+1F2w
         JvNYoLkM/hZib8AmNtBbO36q0cebSyl9RwqZbpY51U8N/LzbrP2RoLrAcBSfJxs5Wui9
         OALJvQT/N7+i1h9110SVAn1y6YAF+yl3tVZLVbV5Qh2R7mlg4KESqxb80iG5Ar2FUGbA
         AJEWSnjqeLw15ho8ajVl2KcEsGOpD9Z8R1JDika36I9ZDQaqIB0Ujv5L9FVlX7a/r2gE
         o/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=aCeri+hfbuGIwO2XasovhLElcJko/KHACF2kQywU+Xo=;
        b=6sYkSJf9MTFalQGO7NM9v+Y4f39IUl9m5c4J217dm504fvLfkaOvjE+PY+bUuG2LsZ
         pt2Jh+GuZxY7okbT+pv9rXh05OEssWfuZ1wt/PbNFwBrabSwZRa8HWUP5/XGxSxIS6xU
         e0ll+D8bd7Pq3NR7Y6FYOiYngwv2JjggKyVLDhwji4W5jIXPOtiGXG6AYhgK2wcsg3Fs
         fZz5fNiyPqqxwI4zEJStimKlYsooZ+Ho3+mX/e0T2i+SUjd+PBOB5KRuMsPwzux80N/4
         RptDv01F6xM8uHDy8l47sFgvYMSHAlA6D3FJSrZXmilnpukQMhc9KX+c1J1jFC6spwOE
         xuzg==
X-Gm-Message-State: ACrzQf3J0Aosg1ji6orxEXoJh1XKY8x91oxglDTh0hUfqcmqofqhu0jE
	M/RTccotSl8Bhs52mJMY6YI=
X-Google-Smtp-Source: AMsMyM4yJjD9o+sPy3v2K+4TcuVVy4EpwjBtKAMhyaVtVP75OBiUCMqy8r/0cLTedgfz/WMFr2GlDQ==
X-Received: by 2002:a05:6214:21ae:b0:4ad:16b9:9133 with SMTP id t14-20020a05621421ae00b004ad16b99133mr18624990qvc.46.1663719257679;
        Tue, 20 Sep 2022 17:14:17 -0700 (PDT)
Received: from [10.69.40.226] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y6-20020ae9f406000000b006ce51b541dfsm848139qkl.36.2022.09.20.17.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 17:14:16 -0700 (PDT)
Message-ID: <92a2cf9f-c371-fb7d-11ff-90cdc09dcae6@gmail.com>
Date: Tue, 20 Sep 2022 17:14:12 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 16/21] dt-bindings: reserved-memory: introduce
 designated-movable-block
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>
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
 Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux.dev
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <20220913195508.3511038-17-opendmb@gmail.com>
 <20220914145506.GA2149379-robh@kernel.org>
 <57f19774-39a1-03a6-fe68-83d7e4b16521@gmail.com>
 <07d87203-6fe1-c612-cb79-9080e1988454@linaro.org>
 <b4b2b4c6-52b6-80f0-5db3-7f7b751989c3@gmail.com>
 <e0e043aa-0f79-59a8-05ab-e48046860524@linaro.org>
From: Doug Berger <opendmb@gmail.com>
In-Reply-To: <e0e043aa-0f79-59a8-05ab-e48046860524@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/2022 4:03 AM, Krzysztof Kozlowski wrote:
> On 19/09/2022 01:12, Doug Berger wrote:
>> On 9/18/2022 3:31 AM, Krzysztof Kozlowski wrote:
>>> On 14/09/2022 18:13, Doug Berger wrote:
>>>> On 9/14/2022 7:55 AM, Rob Herring wrote:
>>>>> On Tue, Sep 13, 2022 at 12:55:03PM -0700, Doug Berger wrote:
>>>>>> Introduce designated-movable-block.yaml to document the
>>>>>> devicetree binding for Designated Movable Block children of the
>>>>>> reserved-memory node.
>>>>>
>>>>> What is a Designated Movable Block? This patch needs to stand on its
>>>>> own.
>>>> As noted in my reply to your [PATCH 00/21] comment, my intention in
>>>> submitting the entire patch set (and specifically PATCH 00/21]) was to
>>>> communicate this context. Now that I believe I understand that only this
>>>> patch should have been submitted to the devicetree-spec mailing list, I
>>>> will strive harder to make it more self contained.
>>>
>>> The submission of entire thread was ok. What is missing is the
>>> explanation in this commit. This commit must be self-explanatory (e.g.
>>> in explaining "Why are you doing it?"), not rely on other commits for
>>> such explanation.
>>>
>>>>
>>>>>
>>>>> Why does this belong or need to be in DT?
>>>> While my preferred method of declaring Designated Movable Blocks is
>>>> through the movablecore kernel parameter, I can conceive that others may
>>>> wish to take advantage of the reserved-memory DT nodes. In particular,
>>>> it has the advantage that a device can claim ownership of the
>>>> reserved-memory via device tree, which is something that has yet to be
>>>> implemented for DMBs defined with movablecore.
>>>
>>> Rephrasing the question: why OS memory layout and OS behavior is a
>>> property of hardware (DTS)?
>> I would say the premise is fundamentally the same as the existing
>> reserved-memory child node.
> 
> I don't think it is fundamentally the same.
> 
> The existing reserved-memory node describes memory used by hardware - by
> other devices. The OS way of handling this memory - movable, reclaimable
> etc - is not part of it.
> 
> So no, it is not the same.
> 
>>
>> I've been rethinking how this should be specified. I am now thinking
>> that it may be better to introduce a new Reserved Memory property that
>> serves as a modifier to the 'reusable' property. The 'reusable' property
>> allows the OS to use memory that has been reserved for a device and
>> therefore requires the device driver to reclaim the memory prior to its
>> use. However, an OS may have multiple ways of implementing such reuse
>> and reclamation.
> 
> ... and I repeat the question - why OS way of implementing reuse and
> reclamation is relevant to DT?
> 
>> I am considering introducing the vendor specific 'linux,dmb' property
>> that is dependent on the 'reusable' property to allow both the OS and
>> the device driver to identify the method used by the Linux OS to support
>> reuse and reclamation of the reserved-memory child node.
> 
> Sure, but why? Why OS and Linux driver specific pieces should be in DT?
>> Such a property would remove any need for new compatible strings to the
>> device tree. Does that approach seem reasonable to you?
> 
> No, because you did not explain original question. At all.
I apologize if I have somehow offended you, but please recognize that my 
apparent inability to answer your question does not come from an 
unwillingness to do so.

I believe an example of the reserved-memory node being used the way you 
indicate (though there are other uses) can be expressed with device tree 
nodes like these:

reserved-memory {
	#address-cells = <0x1>;
	#size-cells = <0x1>;
	ranges;

	multimedia_reserved: multimedia@80000000 {
		reg = <0x80000000 0x10000000>;
	};
};

decoder@8012000 {
	memory-region = <&multimedia_reserved>;
	/* ... */
};

Here a 256MB chunk of memory is reserved for use by a hardware decoder 
as part of rendering a video stream. In this case the memory is reserved 
for the exclusive use of the decoder device and its associated device 
driver.

The Devicetree Specification includes a property named 'reusable' that 
could be applied to the multimedia node to allow the OS to "use the 
memory in this region with the limitation that the device driver(s) 
owning the region need to be able to reclaim it back". This is a good 
idea, because this memory could probably be put to good use when the 
decoder is not active. Unfortunately, the methods for reusing this 
memory are not defined for Linux so the multimedia reserved memory would 
not be reused even though the devicetree indicates that it is allowed.

The notion behind this commit was to introduce the 
'designated-movable-block' compatible string that could be added to the 
multimedia node to allow the Client Program (i.e. Linux) to select a 
device driver that knows how to reclaim reserved memory back from the OS 
when it is needed by the decoder device and release it back to the OS 
when the decoder no longer needs it. In this way, the purpose of the 
multimedia node remains the same (i.e. to reserve memory for use by a 
device), but a new compatible string is defined to allow for selection 
of an appropriate device driver and allow successful reuse of the memory 
for the benefit of the system.

 From Rob's feedback it is clear that 'designated-movable-block' is not 
an appropriate name, but maybe 'linux,dmb' might have been. However, it 
would be more flexible if a 'linux,dmb' property could be introduced as 
a modifier to the existing 'reusable' property to provide a general 
mechanism for clarifying how 'reusable' should be supported by the 
Client Software and its device drivers.

Such a property is not directly relevant to hardware, but the devicetree 
is not wholly concerned with hardware. Reserved memory node children 
include support for 'linux,cma-default' and 'linux,dma-default' 
properties that signal behavioral intent to the Linux OS. Some aspects 
of the devicetree (e.g. the /chosen node and 'reusable' property) are 
for the benefit of the Client Program.

> 
> Best regards,
> Krzysztof
I hope this is closer to the answer you seek, but I may simply not 
understand the question being asked,
-Doug
