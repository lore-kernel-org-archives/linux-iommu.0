Return-Path: <SRS0=MJs7=WM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89465C3A59D
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 19:44:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C9A4206C1
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 19:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C9A4206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 129ECB2F;
	Fri, 16 Aug 2019 19:44:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A303E2F
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 19:43:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 19803786
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 19:43:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4B8428;
	Fri, 16 Aug 2019 12:43:57 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60F9C3F706;
	Fri, 16 Aug 2019 12:43:55 -0700 (PDT)
Subject: Re: [Freedreno] [PATCH v3 0/2] iommu/arm-smmu: Split pagetable support
To: Rob Clark <robdclark@gmail.com>, Jordan Crouse <jcrouse@codeaurora.org>
References: <1565216500-28506-1-git-send-email-jcrouse@codeaurora.org>
	<20190815153304.GD28465@jcrouse1-lnx.qualcomm.com>
	<ac248f33-2528-c1d4-17ed-17e92e6ed5ad@arm.com>
	<CAF6AEGujjF+MQFw45g799i+2QE4X=eRZdDSsD_F3y3mfbc6UPw@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3ea2755f-6d4d-736d-bebd-455a7967e381@arm.com>
Date: Fri, 16 Aug 2019 20:43:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAF6AEGujjF+MQFw45g799i+2QE4X=eRZdDSsD_F3y3mfbc6UPw@mail.gmail.com>
Content-Language: en-GB
Cc: Rob Herring <robh@kernel.org>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Will Deacon <will@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	iommu@lists.linux-foundation.org,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	freedreno <freedreno@lists.freedesktop.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 16/08/2019 19:12, Rob Clark wrote:
> On Fri, Aug 16, 2019 at 9:58 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> Hi Jordan,
>>
>> On 15/08/2019 16:33, Jordan Crouse wrote:
>>> On Wed, Aug 07, 2019 at 04:21:38PM -0600, Jordan Crouse wrote:
>>>> (Sigh, resend. I freaked out my SMTP server)
>>>>
>>>> This is part of an ongoing evolution for enabling split pagetable support for
>>>> arm-smmu. Previous versions can be found [1].
>>>>
>>>> In the discussion for v2 Robin pointed out that this is a very Adreno specific
>>>> use case and that is exactly true. Not only do we want to configure and use a
>>>> pagetable in the TTBR1 space, we also want to configure the TTBR0 region but
>>>> not allocate a pagetable for it or touch it until the GPU hardware does so. As
>>>> much as I want it to be a generic concept it really isn't.
>>>>
>>>> This revision leans into that idea. Most of the same io-pgtable code is there
>>>> but now it is wrapped as an Adreno GPU specific format that is selected by the
>>>> compatible string in the arm-smmu device.
>>>>
>>>> Additionally, per Robin's suggestion we are skipping creating a TTBR0 pagetable
>>>> to save on wasted memory.
>>>>
>>>> This isn't as clean as I would like it to be but I think that this is a better
>>>> direction than trying to pretend that the generic format would work.
>>>>
>>>> I'm tempting fate by posting this and then taking some time off, but I wanted
>>>> to try to kick off a conversation or at least get some flames so I can try to
>>>> refine this again next week. Please take a look and give some advice on the
>>>> direction.
>>>
>>> Will, Robin -
>>>
>>> Modulo the impl changes from Robin, do you think that using a dedicated
>>> pagetable format is the right approach for supporting split pagetables for the
>>> Adreno GPU?
>>
>> How many different Adreno drivers would benefit from sharing it?
> 
> Hypothetically everything back to a3xx, so I *could* see usefulness of
> this in qcom_iommu (or maybe even msm-iommu).  OTOH maybe with
> "modularizing" arm-smmu we could re-combine qcom_iommu and arm-smmu.

Indeed, that's certainly something I'm planning to investigate as a 
future refactoring step.

> And as a practical matter, I'm not sure if anyone will get around to
> backporting per-context pagetables as far back as a3xx.
> 
> BR,
> -R
> 
>> The more I come back to this, the more I'm convinced that io-pgtable
>> should focus on the heavy lifting of pagetable management - the code
>> that nobody wants to have to write at all, let alone more than once -
>> and any subtleties which aren't essential to that should be pushed back
>> into whichever callers actually care. Consider that already, literally
>> no caller actually uses an unmodified stage 1 TCR value as provided in
>> the io_pgtable_cfg.
>>
>> I feel it would be most productive to elaborate further in the form of
>> patches, so let me get right on that and try to bash something out
>> before I go home tonight...

...and now there's a rough WIP branch here:

http://linux-arm.org/git?p=linux-rm.git;a=shortlog;h=refs/heads/iommu/pgtable

I'll finish testing and polishing those patches at some point next week, 
probably, but hopefully they're sufficiently illustrative for the moment.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
