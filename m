Return-Path: <SRS0=QvS0=3F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4979EC33CAF
	for <iommu@archiver.kernel.org>; Thu, 16 Jan 2020 21:23:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0995320748
	for <iommu@archiver.kernel.org>; Thu, 16 Jan 2020 21:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtqKuT0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0995320748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C828F2038A;
	Thu, 16 Jan 2020 21:23:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c0A8AMZsjnYd; Thu, 16 Jan 2020 21:23:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D4A8121FAD;
	Thu, 16 Jan 2020 21:23:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C69B4C1D82;
	Thu, 16 Jan 2020 21:23:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D08AC077D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jan 2020 21:23:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5B8358651D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jan 2020 21:23:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ymvqBv-4aISD for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jan 2020 21:23:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0C1FE85F98
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jan 2020 21:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579209809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KO9+uw/hq0OkXeKJuZfGCr+At+A43QGZAYlRPTwNi6Y=;
 b=TtqKuT0ciN077gVnHzW/DsbfuHq2w4/ni83ZdTlh44tkJQNLH3Qw1Z4uB2x8RO1CWuEOZA
 arShEITcEeqApHQy8fQGPgdS5XSdgey66DtJORkXCKmEGzKIGNEES37Gu6F4A6jekv04/O
 oHklZsCZs1QySZf+kois9Fygfsx9g9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-U-uhHCL1M0-Z0rRLKVDtnQ-1; Thu, 16 Jan 2020 16:23:23 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DBC210054E3;
 Thu, 16 Jan 2020 21:23:22 +0000 (UTC)
Received: from [10.36.117.108] (ovpn-117-108.ams2.redhat.com [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BC1988867;
 Thu, 16 Jan 2020 21:23:20 +0000 (UTC)
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add SMMUv3.2 range invalidation support
To: Rob Herring <robh@kernel.org>
References: <20200113143924.11576-1-robh@kernel.org>
 <2ee87a12-1a0e-bd48-0209-b5e205342d44@redhat.com>
 <CAL_JsqKrh0nLuoRgi1-bKyEErwCFpWPRPNVDuoeJrbFMCz60KQ@mail.gmail.com>
 <bc72f4c5-de47-8684-c7d5-0e60a4a78ee2@redhat.com>
 <CAL_Jsq+fwdLfxgW=aoMNySrKunSgtC+i5ttsn1vCdR2p4BMPfA@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <4e56aa27-37f0-d8d9-46fd-871055abcb49@redhat.com>
Date: Thu, 16 Jan 2020 22:23:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+fwdLfxgW=aoMNySrKunSgtC+i5ttsn1vCdR2p4BMPfA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: U-uhHCL1M0-Z0rRLKVDtnQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>, Will Deacon <will@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

Hi Rob,

On 1/16/20 5:57 PM, Rob Herring wrote:
> On Wed, Jan 15, 2020 at 10:33 AM Auger Eric <eric.auger@redhat.com> wrote:
>>
>> Hi Rob,
>>
>> On 1/15/20 3:02 PM, Rob Herring wrote:
>>> On Wed, Jan 15, 2020 at 3:21 AM Auger Eric <eric.auger@redhat.com> wrote:
>>>>
>>>> Hi Rob,
>>>>
>>>> On 1/13/20 3:39 PM, Rob Herring wrote:
>>>>> Arm SMMUv3.2 adds support for TLB range invalidate operations.
>>>>> Support for range invalidate is determined by the RIL bit in the IDR3
>>>>> register.
>>>>>
>>>>> The range invalidate is in units of the leaf page size and operates on
>>>>> 1-32 chunks of a power of 2 multiple pages. First we determine from the
>>>>> size what power of 2 multiple we can use and then adjust the granule to
>>>>> 32x that size.
> 
>>>>> @@ -2022,12 +2043,39 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
>>>>>               cmd.tlbi.vmid   = smmu_domain->s2_cfg.vmid;
>>>>>       }
>>>>>
>>>>> +     if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
>>>>> +             unsigned long tg, scale;
>>>>> +
>>>>> +             /* Get the leaf page size */
>>>>> +             tg = __ffs(smmu_domain->domain.pgsize_bitmap);
>>>> it is unclear to me why you can't set tg with the granule parameter.
>>>
>>> granule could be 2MB sections if THP is enabled, right?
>>
>> Ah OK I thought it was a page size and not a block size.
>>
>> I requested this feature a long time ago for virtual SMMUv3. With
>> DPDK/VFIO the guest was sending page TLB invalidation for each page
>> (granule=4K or 64K) part of the hugepage buffer and those were trapped
>> by the VMM. This stalled qemu.
> 
> I did some more testing to make sure THP is enabled, but haven't been
> able to get granule to be anything but 4K. I only have the Fast Model
> with AHCI on PCI to test this with. Maybe I'm hitting some place where
> THPs aren't supported yet.
> 
>>>>> +             /* Determine the power of 2 multiple number of pages */
>>>>> +             scale = __ffs(size / (1UL << tg));
>>>>> +             cmd.tlbi.scale = scale;
>>>>> +
>>>>> +             cmd.tlbi.num = CMDQ_TLBI_RANGE_NUM_MAX - 1;
>>>> Also could you explain why you use CMDQ_TLBI_RANGE_NUM_MAX.
>>>
>>> How's this:
>>> /* The invalidation loop defaults to the maximum range */
>> I would have expected num=0 directly. Don't we invalidate the &size in
>> one shot as 2^scale * pages of granularity @tg? I fail to understand
>> when NUM > 0.
> 
> NUM is > 0 anytime size is not a power of 2. For example, if size is
> 33 pages, then it takes 2 loops doing 32 pages and then 1 page. If
> size is 34 pages, then NUM is (17-1) and SCALE is 1.
OK I get it now. I misread the scale computation as log2() :-(.

I still have a doubt about the scale choice. What if you invalidate a
large number of pages such as 1025 pages. scale is 0 and you end up with
32 * 32 * 2^0 + 1 * 2 * 2^0  invalidations (33). Whereas you could
invalidate the whole range with 2 invalidation commands: 1 x 2^10 +
1*1^1 (packing the invalidations by largest scale). Am I correct or do I
still miss something?

Besides in the patch I think in the while loop the iova should be
incremented with the actual number of invalidated bytes and not the max
sized granule variable.

Thanks

Eric







> 
> Rob
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
