Return-Path: <SRS0=rmn6=DF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39EEC4741F
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 06:53:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2473323119
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 06:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BDS2XQiM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2473323119
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B4B2086FA2;
	Mon, 28 Sep 2020 06:53:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qNimMXLivGwt; Mon, 28 Sep 2020 06:52:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 971E485D00;
	Mon, 28 Sep 2020 06:52:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7884AC0889;
	Mon, 28 Sep 2020 06:52:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3891C0051
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 06:52:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9BD108622A
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 06:52:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NeEdEWorn+Fn for <iommu@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 06:52:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E9A3686225
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 06:52:53 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200928065250euoutp024338c2c4e84c788f8ac693854a130269~44AL5oyhb1342513425euoutp02m
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 06:52:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200928065250euoutp024338c2c4e84c788f8ac693854a130269~44AL5oyhb1342513425euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1601275970;
 bh=2+5hUU0KTysPUrzXufSnqVwM4KR2JJ3ePlaeYYPHMrE=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=BDS2XQiM1usbf4Lr3rHyzpV1CxgJ7BdBpoclPH+fD0SZGR8kttokpSo8cQt/YWcyL
 MtE3+xgxaQmCeoYqjprazEVSHD64m9IWOW2bdCEw4LXqPpShtNX2JXfJDdtRavqtQ0
 bZUnqe+YF7fUJvTGBKu4SOpBcL23ZwmQCfU0Xw7A=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200928065250eucas1p2616080a771ceddbabd0e10f506749af0~44ALpeMFf1212212122eucas1p26;
 Mon, 28 Sep 2020 06:52:50 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 59.96.06456.248817F5; Mon, 28
 Sep 2020 07:52:50 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200928065250eucas1p2dfcd485796bb9ff6ad9e9a1288528a74~44ALQ-wpJ1243512435eucas1p28;
 Mon, 28 Sep 2020 06:52:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200928065250eusmtrp1a9c82761cb6bd95254e86f13be26b340~44ALQTFQK3155131551eusmtrp1b;
 Mon, 28 Sep 2020 06:52:50 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-83-5f718842ccb8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id CC.7E.06314.248817F5; Mon, 28
 Sep 2020 07:52:50 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200928065249eusmtip1ab4bd0fe4ebb9691d6c2a4c6ef14fb9b~44AKeImp93172531725eusmtip18;
 Mon, 28 Sep 2020 06:52:49 +0000 (GMT)
Subject: Re: IOVA allocation dependency between firmware buffer and
 remaining buffers
To: Robin Murphy <robin.murphy@arm.com>, Thierry Reding
 <thierry.reding@gmail.com>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <96a8ecfb-ab53-5d8c-6424-dbcf5602454a@samsung.com>
Date: Mon, 28 Sep 2020 08:52:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <46f10f99-5da5-257a-4a02-984ff8ed8c6f@arm.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH++3e7d6NJtdp7WCJNLEy8EVZFwwpK7r/FD2ERPAx7aKSm7ap
 pf80MkJnWWlhLpsPDN+vWdpUSkc5zdJhlCbmC+dQlFIzsshyXi3/+5xzvud8z4FDYpIxvgsZ
 p0xiVUp5vEwgwps6l/u8gjIuR/guWj3o+tlijG6890xAV1S95tFFLwNoTZWFT2c+qifokeo/
 fNpW/AOjO75O8ulX460EXWvMIejlFj1O3xj2PyJmJjv0PKZaX40Yo+4zwRgqMwWMYSGHYIY/
 tgkYffdZJnewDDGtnzQCJvtpJTojChUdvsjGx6WwKp/ASFGsvnwGJZa4Xn2s+4Bp0JRUi4Qk
 UAegz1aHa5GIlFDlCAYsL/hc8A3BHU3pemURgeaZVbDRMtIyi3GFMgTTXY3rqi8I6qtvE1pE
 kk7UBTC1hdnRmQqG0RpPuwSjPvNgfGyWsA8SUH6gndOuDRVTgTDwKQfZGac8oODBhzXNNioc
 Ot9M4JzGEbrzJ9dYSAXAo/LSNcYoN2ieK8A4lsLQZCHPbgbUbwIKpn6ub30czFoDj2MnmDE/
 JTjeCT25t3CuIR3BeG8NwQW3ELy//hBxqgAY7rVPIlctPKGuxYdLH4WJ+WbcngbKAQbnHLkl
 HCCnKQ/j0mLIuCnh1LtBZ679Z9th6cfuIplu02m6TefoNp2j++9bhPBKJGWT1YoYVu2nZK94
 q+UKdbIyxjs6QWFAq3/Xs2JeeI6W+qNMiCKRbKs4xJgYIeHLU9SpChMCEpM5i4Pe9YRLxBfl
 qWmsKiFClRzPqk1oB4nLpOL9JdNhEipGnsReYtlEVrVR5ZFCFw1Kn99uyM0vHNIIFe3UivcT
 J1uIl2ok49zdrF9Ztq68a9uWa6xbIwmLy7yHtWFXf0Lf2xsVpzOKRt1NB7+74r1ukUMzhxqk
 zsri9sB7tafSIGok2B34zSm9Rofo4i2pe131ts4wf99jS77WkyeUoQ/PVJ3PDrbcZ1525Tdk
 7nFbkeHqWLnfPkyllv8FQfWpZHMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsVy+t/xu7pOHYXxBsfvcVtseLOQ2WLzxK1s
 FitXH2WyWLDf2qJh9QVWi87ZG9gt7q35z2rxfOEPZouDH56wWhx5uJvdYt3OSewWP3fNY7Fo
 uWPqwOvx5OA8Jo8189YweuycdZfdY9OqTjaPTZ8msXvcubaHzWPeyUCPyTeWM3rsvtnA5tG3
 ZRVjAFeUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2C
 Xsa8Fa8YCxbJVsyddZW5gfGZeBcjJ4eEgInEvV1vmLsYuTiEBJYySvxe/IcdIiEjcXJaAyuE
 LSzx51oXG4gtJPAWqGihMIgtLBAusW3jHLAaEYEQiQOXzrKCDGIWuMsk8eLrVnaIqWtYJU50
 v2QBqWITMJToegsxiVfATuL6zUmMIDaLgKrEnKlXwTaLCsRJnOl5AVUjKHFy5hOwXk4Ba4nZ
 K5aA2cwCZhLzNj9khrDlJba/nQNli0vcejKfaQKj0Cwk7bOQtMxC0jILScsCRpZVjCKppcW5
 6bnFhnrFibnFpXnpesn5uZsYgRG+7djPzTsYL20MPsQowMGoxMMbsbMgXog1say4MvcQowQH
 s5IIr9PZ03FCvCmJlVWpRfnxRaU5qcWHGE2BnpvILCWanA9MPnkl8YamhuYWlobmxubGZhZK
 4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhh1al92B/eJda5ZpMr1gO1zqtIs0/QTG9kUL2i4
 GsTUui9feajU/9jxLv5FMWb5CX+l1J/pTLohpyjO8+NnfcvFSatsmOZZuLq9mOXmtV8vyeU3
 6xFDB4+4SXfe3bzU8ORrTECHuWPPrg4vsT7Dn6JTbnWzmbhYck/jvl3Kmy5XJT5v6rwrrUos
 xRmJhlrMRcWJAGGxXFgGAwAA
X-CMS-MailID: 20200928065250eucas1p2dfcd485796bb9ff6ad9e9a1288528a74
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
 <832be601-c016-70b7-2b59-5f4915c53f85@samsung.com>
 <46f10f99-5da5-257a-4a02-984ff8ed8c6f@arm.com>
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

On 24.09.2020 13:06, Robin Murphy wrote:
> On 2020-09-24 11:47, Marek Szyprowski wrote:
>> On 24.09.2020 12:40, Robin Murphy wrote:
>>> On 2020-09-24 11:16, Thierry Reding wrote:
>>>> On Thu, Sep 24, 2020 at 10:46:46AM +0200, Marek Szyprowski wrote:
>>>>> On 24.09.2020 10:28, Joerg Roedel wrote:
>>>>>> On Wed, Sep 23, 2020 at 08:48:26AM +0200, Marek Szyprowski wrote:
>>>>>>> It allows to remap given buffer at the specific IOVA address,
>>>>>>> although
>>>>>>> it doesn't guarantee that those specific addresses won't be later
>>>>>>> used
>>>>>>> by the IOVA allocator. Probably it would make sense to add an 
>>>>>>> API for
>>>>>>> generic IOMMU-DMA framework to mark the given IOVA range as
>>>>>>> reserved/unused to protect them.
>>>>>> There is an API for that, the IOMMU driver can return IOVA reserved
>>>>>> regions per device and the IOMMU core code will take care of mapping
>>>>>> these regions and reserving them in the IOVA allocator, so that
>>>>>> DMA-IOMMU code will not use it for allocations.
>>>>>>
>>>>>> Have a look at the iommu_ops->get_resv_regions() and
>>>>>> iommu_ops->put_resv_regions().
>>>>>
>>>>> I know about the reserved regions IOMMU API, but the main problem 
>>>>> here,
>>>>> in case of Exynos, is that those reserved regions won't be created by
>>>>> the IOMMU driver but by the IOMMU client device. It is just a result
>>>>> how
>>>>> the media drivers manages their IOVA space. They simply have to load
>>>>> firmware at the IOVA address lower than the any address of the used
>>>>> buffers.
>>>>
>>>> I've been working on adding a way to automatically add direct mappings
>>>> using reserved-memory regions parsed from device tree, see:
>>>>
>>>> https://lore.kernel.org/lkml/20200904130000.691933-1-thierry.reding@gmail.com/ 
>>>>
>>>>
>>>> Perhaps this can be of use? With that you should be able to add a
>>>> reserved-memory region somewhere in the lower range that you need for
>>>> firmware images and have that automatically added as a direct mapping
>>>> so that it won't be reused later on for dynamic allocations.
>>>
>>> It can't easily be a *direct* mapping though - if the driver has to
>>> use the DMA masks to ensure that everything stays within the
>>> addressable range, then (as far as I'm aware) there's no physical
>>> memory that low down to equal the DMA addresses.
>>>
>>> TBH I'm not convinced that this is a sufficiently common concern to
>>> justify new APIs, or even to try to make overly generic. I think just
>>> implementing a new DMA attribute to say "please allocate/map this
>>> particular request at the lowest DMA address possible" would be good
>>> enough. Such a thing could also serve PCI drivers that actually care
>>> about SAC/DAC to give us more of a chance of removing the "try a
>>> 32-bit mask first" trick from everyone's hotpath...
>>
>> Hmm, I like the idea of such DMA attribute! It should make things really
>> simple, especially in the drivers. Thanks for the great idea! I will try
>> to implement it then instead of the workarounds I've proposed in
>> s5p-mfc/exynos4-is drivers.
>
> Right, I think it's fair to draw a line and say that anyone who wants 
> a *specific* address needs to manage their own IOMMU domain.
>
> In the backend I suspect it's going to be cleanest to implement a 
> dedicated iova_alloc_low() (or similar) function in the IOVA API that 
> sidesteps all of the existing allocation paths and goes straight to 
> the rbtree.

Just for the record - I've implemented this approach here: 
https://lore.kernel.org/lkml/20200925141218.13550-1-m.szyprowski@samsung.com/

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
