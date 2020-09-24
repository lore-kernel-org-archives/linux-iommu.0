Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56321C4363D
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 10:41:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8902D23772
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 10:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kBbub8Ep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8902D23772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 31BE986A7F;
	Thu, 24 Sep 2020 10:41:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wDYYWzCu0AFg; Thu, 24 Sep 2020 10:41:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 48F6586A75;
	Thu, 24 Sep 2020 10:41:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31198C0889;
	Thu, 24 Sep 2020 10:41:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20B6DC0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:41:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0E90A86BAC
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:41:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7gwmjCk-1z7k for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 10:41:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7E0BE86BA5
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:41:33 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200924104131euoutp024f9fcd76204e53bee92ae63ba738b6f0~3sisx4Dtz0239902399euoutp02e
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:41:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200924104131euoutp024f9fcd76204e53bee92ae63ba738b6f0~3sisx4Dtz0239902399euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1600944091;
 bh=QxLVIOo1lmMxtUQfpKeeC52N82Riy1iZztGICavi0zU=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=kBbub8Epu+yYoD+UBmbM0EmMuWUFpgq+8ivOjbQcQUKhyPrnJa0C70EP8CRLmNOkv
 wnLZonko4tMAKXXoazSK1GZfwNmInUfhaxf4zQlP/29Wxrz9Qfhd92JJfuLpvgoQdm
 J+g6i3i/cT9rEej/bhblswXg7zazeVgbNRHZ0d2g=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200924104130eucas1p1cae4050ef605bf5d6728c6d696022cf0~3sisi6nyZ0648306483eucas1p1b;
 Thu, 24 Sep 2020 10:41:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 84.11.06318.AD77C6F5; Thu, 24
 Sep 2020 11:41:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200924104130eucas1p1f80a59356e33650812b88915603a95bf~3sisNceHx0653206532eucas1p1T;
 Thu, 24 Sep 2020 10:41:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200924104130eusmtrp19920ae6ecb5ac9047625f0912799507b~3sisMkrJp2829628296eusmtrp1z;
 Thu, 24 Sep 2020 10:41:30 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-09-5f6c77da0c10
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id DD.90.06017.AD77C6F5; Thu, 24
 Sep 2020 11:41:30 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200924104129eusmtip19ddf8afe8dd5a470d19c40e8a5b48428~3sirfFS4t1011410114eusmtip1Y;
 Thu, 24 Sep 2020 10:41:29 +0000 (GMT)
Subject: Re: IOVA allocation dependency between firmware buffer and
 remaining buffers
To: Thierry Reding <thierry.reding@gmail.com>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <1451f2dc-b64f-e7df-f0fa-f4107e18ee35@samsung.com>
Date: Thu, 24 Sep 2020 12:41:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200924101640.GE2483160@ulmo>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUhTYRTGe3fv3a6jyXVantKMRklfpmLBJZeURFykP5KCoFJbdTFxW7Kp
 pQWtWdamlh9RusSPoJZzfmSaaaZsmGajJRqlorFkEIkffSjTSM15tfzv95xznvecB14SEzuI
 9WSCMplVKWVyCV+IP++YsQcNXJTHhWiNu+na0XKMfpbXwKcrKl/z6LK2cFpT2U3Quge1Avqz
 eZ6gv5ZPY7Tlu5Og27+8FNDVTfkCeqa5BKevD+7ZL2KclhIeYy4xI6bJMCRg6kw6PlP3M1/A
 DH5s4TMlXdFMQZ8RMS/7NXzmdr0JHRGeEErPsfKEVFYVHHFaeD5DX0ckZYkvPZrS4Rpk99Qj
 DxKo3WApMvL0SEiKqScIPpvGCU5MImhw9CyJXwhaXHPYssX4aQLnGkYEA6YXS2ICQfW1NwtT
 JOlNHQdrS4zb4EMFwbxtFHczRmkxKNSEuJlPhYJ+TM93s4iKgOKae8jNOLUFhm5OEG5eQ8VC
 x9thnJvxgq4i5yJ7UDtBn12x9OZGaBwrxjj2hQFn6WIeoGYF0GodR9zVB8HVoyM49oaRznoB
 x/5gK8jGOUMGgi/2KgEnshH0aguX3OEwaP/NdyfDqG1Q0xzMlQ/A8I9G3F0GyhP6xry4Izwh
 //l9jCuL4FammJsOBENn9b+1lu4eLBdJDCuiGVbEMayIY/i/twzhJuTLpqgV8aw6TMle3KWW
 KdQpyvhdZy8o6tDCv7PNdU69QK1/zlgRRSLJahEZlBgnJmSp6jSFFQGJSXxEke9ssWLROVla
 Oqu6EKdKkbNqK/IjcYmvKOzhtxgxFS9LZhNZNolVLXd5pMd6DbKV5gW0bbbr+n/Pagyvmrpt
 TxVHS6XoZNq8Ofpqrn9zn+N9Ro7ysKVqsiUrPdfLeUeUdHmHg70bUBpcNK3xPlY8c6hPy6jW
 nRr2c0U+lpv79zJRsrScgtn2y1F7Avs3fOiNxaWvpY2jo+HaG4lX9m0dKeiZzGxOGMfWbjKt
 cpVLcPV5Weh2TKWW/QWrokNlcwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsVy+t/xu7q3ynPiDY5/krXY8GYhs8XmiVvZ
 LFauPspksWC/tUXD6gusFp2zN7Bb3Fvzn9Xi+cIfzBYHPzxhtTjycDe7xbqdk9gtfu6ax2LR
 csfUgdfjycF5TB5r5q1h9Ng56y67x6ZVnWwemz5NYve4c20Pm8e8k4Eek28sZ/TYfbOBzaNv
 yyrGAK4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsE
 vYzmrk2sBd1CFUu/drI0MJ7j62Lk5JAQMJFYfv09SxcjF4eQwFJGibbD6xkhEjISJ6c1sELY
 whJ/rnWxQRS9ZZQ43bWZBSQhLBAusW3jHLAiEQFdif+n34BNYhZoYZZYfqWBEaJjKovEmR23
 2UCq2AQMJbredoHZvAJ2EnPWTwNbxyKgKnG3/T3YJFGBOIkzPS+gagQlTs58AraNU0BHoqtn
 JZjNLGAmMW/zQ2YIW15i+9s5ULa4xK0n85kmMArNQtI+C0nLLCQts5C0LGBkWcUoklpanJue
 W2ykV5yYW1yal66XnJ+7iREY49uO/dyyg7HrXfAhRgEORiUeXg7d7Hgh1sSy4srcQ4wSHMxK
 IrxOZ0/HCfGmJFZWpRblxxeV5qQWH2I0BXpuIrOUaHI+MP3klcQbmhqaW1gamhubG5tZKInz
 dggcjBESSE8sSc1OTS1ILYLpY+LglGpgTNnzwaY69JDx5yIPprcJvabHmr4t2MLI9nLi1ZJl
 TKHtUpZKXpsDd37+q7T8oJGC+N6U39c/5ZeoZGgdqUp+uaEyaP/tpgdsNdofgm4p7t/X1Kxp
 8e71A6EMi475IvKsyyVLxX12coROM+w6URL08sBk/1un+L0bTDQSfsnP+GV5VybFYrmAEktx
 RqKhFnNRcSIAm9fM9QcDAAA=
X-CMS-MailID: 20200924104130eucas1p1f80a59356e33650812b88915603a95bf
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
Cc: jean-philippe@linaro.org, will@kernel.org, linux-mm@kvack.org,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Ajay kumar <ajaynumb@gmail.com>, Shaik Ameer Basha <shaik.ameer@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, hch@lst.de
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

Hi Thierry,

On 24.09.2020 12:16, Thierry Reding wrote:
> On Thu, Sep 24, 2020 at 10:46:46AM +0200, Marek Szyprowski wrote:
>> On 24.09.2020 10:28, Joerg Roedel wrote:
>>> On Wed, Sep 23, 2020 at 08:48:26AM +0200, Marek Szyprowski wrote:
>>>> It allows to remap given buffer at the specific IOVA address, although
>>>> it doesn't guarantee that those specific addresses won't be later used
>>>> by the IOVA allocator. Probably it would make sense to add an API for
>>>> generic IOMMU-DMA framework to mark the given IOVA range as
>>>> reserved/unused to protect them.
>>> There is an API for that, the IOMMU driver can return IOVA reserved
>>> regions per device and the IOMMU core code will take care of mapping
>>> these regions and reserving them in the IOVA allocator, so that
>>> DMA-IOMMU code will not use it for allocations.
>>>
>>> Have a look at the iommu_ops->get_resv_regions() and
>>> iommu_ops->put_resv_regions().
>> I know about the reserved regions IOMMU API, but the main problem here,
>> in case of Exynos, is that those reserved regions won't be created by
>> the IOMMU driver but by the IOMMU client device. It is just a result how
>> the media drivers manages their IOVA space. They simply have to load
>> firmware at the IOVA address lower than the any address of the used
>> buffers.
> I've been working on adding a way to automatically add direct mappings
> using reserved-memory regions parsed from device tree, see:
>
>      https://lore.kernel.org/lkml/20200904130000.691933-1-thierry.reding@gmail.com/
>
> Perhaps this can be of use? With that you should be able to add a
> reserved-memory region somewhere in the lower range that you need for
> firmware images and have that automatically added as a direct mapping
> so that it won't be reused later on for dynamic allocations.

Frankly, using that would be even bigger hack than what I've proposed in 
my workaround. I see no point polluting DT with such artificial regions 
just to ensure specific IOVA space layout.

I just looking for a nice way of reusing most of the IOMMU DMA-mapping 
code with a small addition of manual IOVA space management (just to 
remap the firmware buffer at the specific IOVA address).

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
