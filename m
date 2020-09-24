Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9036C4363D
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 10:47:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 591192396E
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 10:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UWlZsb/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591192396E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D28A4874EE;
	Thu, 24 Sep 2020 10:47:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UE7nioCRbfLd; Thu, 24 Sep 2020 10:47:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1EF43870CE;
	Thu, 24 Sep 2020 10:47:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 040DEC0889;
	Thu, 24 Sep 2020 10:47:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2DB0C0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:47:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EBD2B874E8
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:47:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3l+aqWew4hyN for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 10:47:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 16F5F870CE
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:47:41 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200924104739euoutp01d95d7a51599b8bd5866cd793c95be36f~3soEB5uWL2248422484euoutp01T
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:47:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200924104739euoutp01d95d7a51599b8bd5866cd793c95be36f~3soEB5uWL2248422484euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1600944459;
 bh=WdiWUcj5OccQFrv4y8I7wpvlij9q9EFSK5IEGQ76WJY=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=UWlZsb/o1JNuEozPXDu4YP1Y4oT5NxCXcQE1pPyyis2u90lL0W3+xsq0oVLKaIYmZ
 lXSoyw6u9gQpBu4+8b5Hac4m63OdpLVB7Djo+ymRvvYKQB6oB85d7pYZ3pZJR8o+iP
 fQTt1NCqb7JdeJvRlnIn18W12P+E0gTvoocZS9e8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200924104739eucas1p20e7329b6e7fd68715032ecdac740ed88~3soDta42f2122221222eucas1p2Z;
 Thu, 24 Sep 2020 10:47:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id CF.D1.06456.B497C6F5; Thu, 24
 Sep 2020 11:47:39 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200924104739eucas1p24e8ee378a5da317390385d065260647c~3soDYp6EE2121421214eucas1p21;
 Thu, 24 Sep 2020 10:47:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200924104739eusmtrp24bf70cef52bb03aca65e774dcff0803e~3soDX4Rbo0630306303eusmtrp25;
 Thu, 24 Sep 2020 10:47:39 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-c2-5f6c794b2289
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 12.71.06017.A497C6F5; Thu, 24
 Sep 2020 11:47:38 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200924104738eusmtip189c79e7863fa953af3224720a37b90d4~3soCr8q_T1123011230eusmtip1M;
 Thu, 24 Sep 2020 10:47:38 +0000 (GMT)
Subject: Re: IOVA allocation dependency between firmware buffer and
 remaining buffers
To: Robin Murphy <robin.murphy@arm.com>, Thierry Reding
 <thierry.reding@gmail.com>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <832be601-c016-70b7-2b59-5f4915c53f85@samsung.com>
Date: Thu, 24 Sep 2020 12:47:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <bff57cbe-2247-05e1-9059-d9c66d64c407@arm.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTmt3u3XUeTn9PYwcpolGWkJhncsDRD6EL0AntQNFt6sWg+2lVT
 KVgPxI0Is5etmBnRQzebZr5RXOpYmpmFrVJLWZni0OyB62G5h+V/3/nOd875vh8/ipAM8AOp
 I6kZrCpVoZQJRGR1u/NZ6JYcZcLq3goJbRorIeiHFx4J6PtlbTz6ZnMUrS7r5tOa6yYhPWD4
 w6eHS6YIumXCzqdbBxuEdHldoZB21utJ+mzf2o1ixt6i5zEGvQExdbp+IVNZqhEwlZOFQqav
 t1HA6K07mYu2u4hpeK0WMOerStEO0T7R+iRWeSSLVYVHHxQd/v1yc3q7NNukn+CrkVOiRT4U
 4Eh4V9Io0CIRJcH3EPxsHuN7iq8Ipk02wlN8QeD8WCGcHXF06nmexl0EZd+NXtU4gsqp1pll
 FOWP94C58YALBuB4eGcMcUkI3M+Dwfdj7kUCHAFah9YtF+No0D5d4aJJvAw0psfIhedjObQ/
 GSJdWIz9wHrN7sY+OAq6PlwiXJjAi6HGccOLpfDGXuz2BvgUBbquGuQxHQfGt7e82B9GLVXe
 MAvhT93swBkEg11Goac4h+DF6SLvRBT0df1wOyVwCDyoD/fQsTD0uYZ00YB9webw85jwhcLq
 q4SHFkN+nvepg0FnKf93tqW7hyhAMt2caLo5cXRz4uj+372JyFIkZTO5lGSWi0hlj4dxihQu
 MzU5LDEtpRLN/LqOactkLfrWc8iMMIVk88RU6NEECV+RxeWkmBFQhCxAvOlph1wiTlLk5LKq
 tARVppLlzGgBRcqk4jW3Rg5IcLIigz3KsumsarbLo3wC1Ygq//qkrf7X5YHE5UsMUbFJQfJv
 d8hAR2BT3fAbtKq1J1d9uSBvd9/7jOpjGRdtkT4dppKYoGHN9hOd45vj4v0mdi2t+tS/bmV2
 7asN/PyT8t23O4uVA2GNVwwizf6A+9tslufBo7acvWXHXrU3jdzBRVsz663+2RJutXUo5sKi
 LEpGcocVESsJFaf4C06F8vpxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsVy+t/xu7pelTnxBntvWllseLOQ2WLzxK1s
 FitXH2WyWLDf2qJh9QVWi87ZG9gt7q35z2rxfOEPZouDH56wWhx5uJvdYt3OSewWP3fNY7Fo
 uWPqwOvx5OA8Jo8189YweuycdZfdY9OqTjaPTZ8msXvcubaHzWPeyUCPyTeWM3rsvtnA5tG3
 ZRVjAFeUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2C
 XsbfK+4Fx8QrNsz7wNrA+FOoi5GTQ0LAROLtmXlMXYxcHEICSxkl7i/dwQSRkJE4Oa2BFcIW
 lvhzrYsNougto8SRqxeYQRLCAuES2zbOASsSEQiROHDpLCtIEbPAXSaJF1+3skN0HGOR2DBh
 O1gVm4ChRNdbkFEcHLwCdhJdZzVAwiwCqhKdGw4zgtiiAnESZ3pesIHYvAKCEidnPmEBsTkF
 rCXOPZ0CtphZwExi3uaHULa8xPa3c6BscYlbT+YzTWAUmoWkfRaSlllIWmYhaVnAyLKKUSS1
 tDg3PbfYSK84Mbe4NC9dLzk/dxMjML63Hfu5ZQdj17vgQ4wCHIxKPLwcutnxQqyJZcWVuYcY
 JTiYlUR4nc6ejhPiTUmsrEotyo8vKs1JLT7EaAr03ERmKdHkfGDqySuJNzQ1NLewNDQ3Njc2
 s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwFjiNXH+UZbjR2cXRGtN3MhZvuxFe3j+a3d/
 AxW7tsyanozCS6G/Fh74Fx1oknNpd+L9HdG9BRtYjpmqbRAy2C9spixwWJfzf8mkO52LUz4y
 f8m2ufm60qdm4/Jlazpm5ChUXVhjcm6Ge15RZEOhv4yg3rRanyi12REO74rjnzGmxx1ZMCPh
 vRJLcUaioRZzUXEiAEVdtf0FAwAA
X-CMS-MailID: 20200924104739eucas1p24e8ee378a5da317390385d065260647c
X-Msg-Generator: CA
X-RootMTR: 20200424161534eucas1p29177cad5b4790d392acb69a335a3992e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200424161534eucas1p29177cad5b4790d392acb69a335a3992e
References: <CAEC9eQOX9BHX4v5aY2cfCT=T-ZHA7y0xF7aiZhW9xzG4fme36Q@mail.gmail.com>
 <CAEC9eQPaeF9=Li74x9RrSHyDgRZ6b653yBRu6EYsaU+eSj2wsQ@mail.gmail.com>
 <59cda41f-170c-a1ad-a345-bc38b9ed4d73@arm.com>
 <CGME20200424161534eucas1p29177cad5b4790d392acb69a335a3992e@eucas1p2.samsung.com>
 <CAOD6ATrWYLPT0ydz2vFhNwWhqHum_q_pyCe=oGJWOcEqjmNOqQ@mail.gmail.com>
 <11584d09-5995-6133-3bd3-8f7a0afd0e01@samsung.com>
 <20200924082830.GB27174@8bytes.org>
 <37e767b8-8ec4-ae80-ea0d-1caf3cdab8fa@samsung.com>
 <20200924101640.GE2483160@ulmo>
 <bff57cbe-2247-05e1-9059-d9c66d64c407@arm.com>
Cc: jean-philippe@linaro.org, linux-mm@kvack.org,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Ajay kumar <ajaynumb@gmail.com>, Shaik Ameer Basha <shaik.ameer@samsung.com>,
 will@kernel.org, hch@lst.de
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Robin,

On 24.09.2020 12:40, Robin Murphy wrote:
> On 2020-09-24 11:16, Thierry Reding wrote:
>> On Thu, Sep 24, 2020 at 10:46:46AM +0200, Marek Szyprowski wrote:
>>> On 24.09.2020 10:28, Joerg Roedel wrote:
>>>> On Wed, Sep 23, 2020 at 08:48:26AM +0200, Marek Szyprowski wrote:
>>>>> It allows to remap given buffer at the specific IOVA address, 
>>>>> although
>>>>> it doesn't guarantee that those specific addresses won't be later 
>>>>> used
>>>>> by the IOVA allocator. Probably it would make sense to add an API for
>>>>> generic IOMMU-DMA framework to mark the given IOVA range as
>>>>> reserved/unused to protect them.
>>>> There is an API for that, the IOMMU driver can return IOVA reserved
>>>> regions per device and the IOMMU core code will take care of mapping
>>>> these regions and reserving them in the IOVA allocator, so that
>>>> DMA-IOMMU code will not use it for allocations.
>>>>
>>>> Have a look at the iommu_ops->get_resv_regions() and
>>>> iommu_ops->put_resv_regions().
>>>
>>> I know about the reserved regions IOMMU API, but the main problem here,
>>> in case of Exynos, is that those reserved regions won't be created by
>>> the IOMMU driver but by the IOMMU client device. It is just a result 
>>> how
>>> the media drivers manages their IOVA space. They simply have to load
>>> firmware at the IOVA address lower than the any address of the used
>>> buffers.
>>
>> I've been working on adding a way to automatically add direct mappings
>> using reserved-memory regions parsed from device tree, see:
>>
>> https://lore.kernel.org/lkml/20200904130000.691933-1-thierry.reding@gmail.com/
>>
>> Perhaps this can be of use? With that you should be able to add a
>> reserved-memory region somewhere in the lower range that you need for
>> firmware images and have that automatically added as a direct mapping
>> so that it won't be reused later on for dynamic allocations.
>
> It can't easily be a *direct* mapping though - if the driver has to 
> use the DMA masks to ensure that everything stays within the 
> addressable range, then (as far as I'm aware) there's no physical 
> memory that low down to equal the DMA addresses.
>
> TBH I'm not convinced that this is a sufficiently common concern to 
> justify new APIs, or even to try to make overly generic. I think just 
> implementing a new DMA attribute to say "please allocate/map this 
> particular request at the lowest DMA address possible" would be good 
> enough. Such a thing could also serve PCI drivers that actually care 
> about SAC/DAC to give us more of a chance of removing the "try a 
> 32-bit mask first" trick from everyone's hotpath...

Hmm, I like the idea of such DMA attribute! It should make things really 
simple, especially in the drivers. Thanks for the great idea! I will try 
to implement it then instead of the workarounds I've proposed in 
s5p-mfc/exynos4-is drivers.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
