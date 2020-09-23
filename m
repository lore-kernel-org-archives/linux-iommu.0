Return-Path: <SRS0=5N08=DA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E43C4363D
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 06:48:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E9620739
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 06:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="g/la0xmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E9620739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 97E8B872E8;
	Wed, 23 Sep 2020 06:48:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 687Cv1MgHjqn; Wed, 23 Sep 2020 06:48:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0C71B872DC;
	Wed, 23 Sep 2020 06:48:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0A5DC0859;
	Wed, 23 Sep 2020 06:48:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6BFBC0051
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 06:48:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CC634844C3
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 06:48:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ds0JytIwKpTG for <iommu@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 06:48:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 23E3F84462
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 06:48:29 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200923064827euoutp0149c189048a65ee2f4dc8f20a2d4f5639~3Vt7Oj_Ut1986819868euoutp013
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 06:48:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200923064827euoutp0149c189048a65ee2f4dc8f20a2d4f5639~3Vt7Oj_Ut1986819868euoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1600843707;
 bh=yB1tKFwj0A7s+sPO2VaXo8lXDNLfSNHdVyrRiAAlppg=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=g/la0xmEQd4AkJtRFRYLanc9NJGwjS8+jd/62sHs3hjHW4HbvI15a/Bc5CCHGrU05
 s3XmaVs7+z+SMz5JIyRALBeXDrflyl3qQVX6mzcURtYn2j3SexYZW7ubsudRP3GmU3
 LSIKMuJ8nkStTRvlLuByhXs+mCpN7Vi5lert/rkw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200923064827eucas1p10e77f8092b1865ce34088cb5088d21eb~3Vt7Ayrns0040900409eucas1p1X;
 Wed, 23 Sep 2020 06:48:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 02.9B.05997.BBFEA6F5; Wed, 23
 Sep 2020 07:48:27 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200923064826eucas1p18f8efef87368e17507917395cd8de2f0~3Vt6b6R6c0638106381eucas1p1j;
 Wed, 23 Sep 2020 06:48:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200923064826eusmtrp1e860d84a24743ce7b22161d866bb3298~3Vt6bFNl02652226522eusmtrp19;
 Wed, 23 Sep 2020 06:48:26 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-a5-5f6aefbb1a35
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id CA.85.06314.ABFEA6F5; Wed, 23
 Sep 2020 07:48:26 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200923064825eusmtip1142893c22cca95c33e54574ee2abab87~3Vt5prRVN1891418914eusmtip1N;
 Wed, 23 Sep 2020 06:48:25 +0000 (GMT)
Subject: Re: IOVA allocation dependency between firmware buffer and
 remaining buffers
To: Shaik Ameer Basha <shaik.samsung@gmail.com>, Robin Murphy
 <robin.murphy@arm.com>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <11584d09-5995-6133-3bd3-8f7a0afd0e01@samsung.com>
Date: Wed, 23 Sep 2020 08:48:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAOD6ATrWYLPT0ydz2vFhNwWhqHum_q_pyCe=oGJWOcEqjmNOqQ@mail.gmail.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0yNcRjH9zvvtcPJzynrUcYcZbF1ofBOuWfezT+ajU1TDl6JzqmdtyL+
 KbdVq1BGjkQ1o9MFFV1ORkmtzjprFOk2tTOVOZNKk0v09hb99/k9z+fZ83y3H0uoP1CubIQ+
 RjDotZEaWkk+bZiwepm/nAjz/fhyHvfocy7BlV19QnMFha8U3N3nAVxCYSvFJd96xHC9RX8o
 biD3O8HVDtsorr7PzHAlVRkMN1GdQ3IXutdtVfG22hwFX5RThPgqYw/Dl5qSab50JIPhu9/W
 0HxOUzCf2XEf8eb3CTSfXm5Ce5QHlIFHhciIOMHgs/mQ8vjv/h9MdMfy01eTxqgElOeWghxY
 wP6QaE9kUpCSVeMHCBrK8in5MYbgem7eTGcUQe9lKzM70t5URkmsxvcRtFk8ZekLgpFsy5TE
 sk54P9TVHJQcZ7wPrnVnEJJD4C4FvJ6snx6m8RpIsafQEqvwZqhJaiMkJrEHWKt/TzuLcCg0
 NPeTsrMQmm7aptkBB0OzpU8hMYGXQYU9m5DZBTptdxTSMsAXWRh5ZlLIVwdBdvEQLbMTfGos
 n0mzBCyZqaQ8cB5Bn7WYkR+pCN6cy0KyFQDd1h+0FI3Aq+BhtY9c3gb9XytIqQzYETrsC+Uj
 HCHj6Q1CLqsg6ZJatleCsbHk39ra1tfEFaQxzolmnBPHOCeO8f/eu4g0IRchVtSFC+JavXDK
 W9TqxFh9uPeRKF0pmvp3lsnGsUpU/etwHcIs0sxXDdoiwtSUNk6M19UhYAmNs2p7iyVUrTqq
 jT8jGKLCDLGRgliH3FhS46Lyyxs6qMbh2hjhpCBEC4bZroJ1cE1AprTdPSGVDv0e1yZ3mQp3
 e7X7b1pqHg8I2TGe9uoEtbh4JH9Her7+mCYk8ufOjUNtTQv8wh+0v6u46azNGywROofP3Pvm
 fjbQkt/63RDNrNjwoq95b5s4MODuvSTudmgBsj/39DKGfnuCxs124/qsrtHTW7dsTAxa+a7F
 V0jWPe4K0JDice2a1YRB1P4FI/VimXMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsVy+t/xu7q73mfFG6w9p2Kx4c1CZovNE7ey
 WaxcfZTJYsF+a4uG1RdYLTpnb2C3uLfmP6vF84U/mC0OfnjCanHk4W52i3U7J7Fb/Nw1j8Wi
 5Y6pA6/Hk4PzmDzWzFvD6LFz1l12j02rOtk8Nn2axO5x59oeNo95JwM9Jt9Yzuix+2YDm0ff
 llWMAVxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJ
 ehl/H/1iL7ihWDGx4wtrA+Mi6S5GTg4JAROJqyc3s3YxcnEICSxllPjc94wZIiEjcXJaAyuE
 LSzx51oXG4gtJPCWUWLSTT8QW1ggXGLbxjlgNSICYRJn2yawgwxiFrjNJLFmwSImiKmPmST2
 fm9iBKliEzCU6HoLMYlXwE5iT8cVsG0sAqoS53b9BZskKhAncabnBVSNoMTJmU9YQGxOgUCJ
 U6cfMoHYzAJmEvM2P2SGsOUltr+dA2WLS9x6Mp9pAqPQLCTts5C0zELSMgtJywJGllWMIqml
 xbnpucWGesWJucWleel6yfm5mxiBEb7t2M/NOxgvbQw+xCjAwajEw/viSWa8EGtiWXFl7iFG
 CQ5mJRFep7On44R4UxIrq1KL8uOLSnNSiw8xmgI9N5FZSjQ5H5h88kriDU0NzS0sDc2NzY3N
 LJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MHKZPN6afkHz+u9nDWc/FF3t+PRiqe7seQrF
 JfO7xJUTd6mn/o2vSeay2xqqZ1fSxsGtceTU57nS/ZLRsqvCbk/zlDs+9/JMe4bfuRKtd0q/
 /nK9GZ5cum6x/qXnLLyebyarL7mhGt2/3WRV+IYl3AbJDD8W9m1z3Xf3/eEaPotZVhPaj0pL
 9yuxFGckGmoxFxUnAgCcm3LHBgMAAA==
X-CMS-MailID: 20200923064826eucas1p18f8efef87368e17507917395cd8de2f0
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
Cc: jean-philippe@linaro.org, Shaik Ameer Basha <shaik.ameer@samsung.com>,
 linux-mm@kvack.org, Linux IOMMU <iommu@lists.linux-foundation.org>,
 Thierry Reding <thierry.reding@gmail.com>, Ajay kumar <ajaynumb@gmail.com>,
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

Hi Shaik,

I've run into similar problem while adapting S5P-MFC and Exynos4-IS 
drivers for generic IOMMU-DMA framework. Here is my first solution: 
https://lore.kernel.org/linux-samsung-soc/20200918144833.14618-1-m.szyprowski@samsung.com/T/ 


It allows to remap given buffer at the specific IOVA address, although 
it doesn't guarantee that those specific addresses won't be later used 
by the IOVA allocator. Probably it would make sense to add an API for 
generic IOMMU-DMA framework to mark the given IOVA range as 
reserved/unused to protect them.

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland

On 24.04.2020 18:15, Shaik Ameer Basha wrote:
> On Fri, Apr 24, 2020 at 8:59 PM Robin Murphy <robin.murphy@arm.com> wrote:
>> On 2020-04-24 4:04 pm, Ajay kumar wrote:
>>> Can someone check this?
>>>
>>> On Mon, Apr 20, 2020 at 9:24 PM Ajay kumar <ajaynumb@gmail.com> wrote:
>>>> Hi All,
>>>>
>>>> I have an IOMMU master which has limitations as mentioned below:
>>>> 1) The IOMMU master internally executes a firmware, and the firmware memory
>>>> is allocated by the same master driver.
>>>> The firmware buffer address should be of the lowest range than other address
>>>> allocated by the device, or in other words, all the remaining buffer addresses
>>>> should always be in a higher range than the firmware address.
>>>> 2) None of the buffer addresses should go beyond 0xC000_0000
>> That particular constraint could (and perhaps should) be expressed as a
>> DMA mask/limit for the device, but if you have specific requirements to
> Yes Robin. We do use 0xC000_0000 address to set the DMA mask in our driver.
>
>> place buffers at particular addresses then you might be better off
>> managing your own IOMMU domain like some other (mostly DRM) drivers do.
> If you remember any of such drivers can you please point the driver path ?
>
>> The DMA APIs don't offer any guarantees about what addresses you'll get
>> other than that they won't exceed the appropriate mask.
> True, we have gone through most of the APIs and didn't find any way to match our
> requirements with the existing DMA APIs
>
>>>> example:
>>>> If firmware buffer address is buf_fw = 0x8000_5000;
>>>> All other addresses given to the device should be greater than
>>>> (0x8000_5000 + firmware size) and less than 0xC000_0000
>> Out of curiosity, how do you control that in the no-IOMMU or IOMMU
>> passthrough cases?
> We manage the no-IOMMU or pass through cases using the reserved-memory.
>
>> Robin.
>>
>>>> Currently, this is being handled with one of the below hacks:
>>>> 1) By keeping dma_mask in lower range while allocating firmware buffer,
>>>> and then increasing the dma_mask to higher range for other buffers.
>>>> 2) By reserving IOVA for firmware at the lowest range and creating direct mappings for the same.
>>>>
>>>> I want to know if there is a better way this can be handled with current framework,
>>>> or if anybody is facing similar problems with their devices,
>>>> please share how it is taken care.
>>>>
>>>> I also think there should be some way the masters can specify the IOVA
>>>> range they want to limit to for current allocation.
>>>> Something like a new iommu_ops callback like below:
>>>> limit_iova_alloc_range(dev, iova_start, iova_end)
>>>>
>>>> And, in my driver, the sequence will be:
>>>> limit_iova_alloc_range(dev, 0x0000_0000, 0x1000_0000); /* via helpers */
>>>> alloc( ) firmware buffer using DMA API
>>>> limit_iova_alloc_range(dev, 0x1000_0000, 0xC000_0000); /* via helpers */
>>>> alloc( ) other buffers using DMA API
>>>>
> Just want to understand more from you, on the new iommu_ops we suggested.
> Shouldn't device have that flexibility to allocate IOVA as per it's requirement?
> If you see our device as example, we need to have control on the
> allocated IOVA region
> based on where device is using this buffer.
>
> If we have these callbacks in place, then the low level IOMMU driver
> can implement and
> manage such requests when needed.
>
> If this can't be taken forward for some right reasons, then we will
> definitely try to understand
> on how to manage the IOMMU domain from our driver as per your suggestion
>
> - Shaik.
>
>>>> Thanks,
>>>> Ajay Kumar

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
