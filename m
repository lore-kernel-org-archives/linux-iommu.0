Return-Path: <SRS0=f5WA=E6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270F5C2D0E4
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 04:03:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D15B2068D
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 04:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="oMt4QV/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D15B2068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C031F85E9F;
	Tue, 24 Nov 2020 04:03:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id un2nI6MxrIYZ; Tue, 24 Nov 2020 04:03:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0F71E85C95;
	Tue, 24 Nov 2020 04:03:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6690C0891;
	Tue, 24 Nov 2020 04:03:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AEE8AC0052
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 04:03:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8AA188710B
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 04:03:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kDXoGC4J8WnR for <iommu@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 04:03:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from z5.mailgun.us (z5.mailgun.us [104.130.96.5])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C9064870EE
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 04:03:00 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1606190583; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=FoFdssz2mmWQah99fW3jkhC1o+yA5snIRe1I3agQdNA=;
 b=oMt4QV/6GdjWv/zSB19e7nYz+RvI8afFtQjYG4TkYh+ypiwMdBA1+DLo9kGvb4/qh3gENZob
 k/vXCQVmN6yM1wN9v1YtJ3qYLDblPsM1FDrRaw0U/r7B/Qmzo5kEl427bzb2V13Xv0xYKtKi
 R/n00PSBHNJaUMHo35Att/jLeA0=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5fbc85f0e9b70886228ae0df (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 24 Nov 2020 04:02:56
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 2EC81C43466; Tue, 24 Nov 2020 04:02:55 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 19B4BC433ED;
 Tue, 24 Nov 2020 04:02:54 +0000 (UTC)
MIME-Version: 1.0
Date: Tue, 24 Nov 2020 09:32:54 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCHv8 0/8] System Cache support for GPU and required SMMU
 support
In-Reply-To: <CAF6AEGse=WBAC1WbTi6aD5_m1_NBg91f=veYm-7V=Uds7NA0Lw@mail.gmail.com>
References: <cover.1605621785.git.saiprakash.ranjan@codeaurora.org>
 <20201123152146.GE11033@willie-the-truck>
 <50b68f2bdf9413b896fbe816ba4ddbc9@codeaurora.org>
 <CAF6AEGse=WBAC1WbTi6aD5_m1_NBg91f=veYm-7V=Uds7NA0Lw@mail.gmail.com>
Message-ID: <1c665e33d1d27263fb5056c16d30b827@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: Robin Murphy <robin.murphy@arm.com>,
 Akhil P Oommen <akhilpo@codeaurora.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS , Joerg
 Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 "Kristian H . Kristensen" <hoegsberg@google.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 freedreno <freedreno@lists.freedesktop.org>, "moderated
 list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2020-11-24 00:52, Rob Clark wrote:
> On Mon, Nov 23, 2020 at 9:01 AM Sai Prakash Ranjan
> <saiprakash.ranjan@codeaurora.org> wrote:
>> 
>> On 2020-11-23 20:51, Will Deacon wrote:
>> > On Tue, Nov 17, 2020 at 08:00:39PM +0530, Sai Prakash Ranjan wrote:
>> >> Some hardware variants contain a system cache or the last level
>> >> cache(llc). This cache is typically a large block which is shared
>> >> by multiple clients on the SOC. GPU uses the system cache to cache
>> >> both the GPU data buffers(like textures) as well the SMMU pagetables.
>> >> This helps with improved render performance as well as lower power
>> >> consumption by reducing the bus traffic to the system memory.
>> >>
>> >> The system cache architecture allows the cache to be split into slices
>> >> which then be used by multiple SOC clients. This patch series is an
>> >> effort to enable and use two of those slices preallocated for the GPU,
>> >> one for the GPU data buffers and another for the GPU SMMU hardware
>> >> pagetables.
>> >>
>> >> Patch 1 - Patch 6 adds system cache support in SMMU and GPU driver.
>> >> Patch 7 and 8 are minor cleanups for arm-smmu impl.
>> >>
>> >> Changes in v8:
>> >>  * Introduce a generic domain attribute for pagetable config (Will)
>> >>  * Rename quirk to more generic IO_PGTABLE_QUIRK_ARM_OUTER_WBWA (Will)
>> >>  * Move non-strict mode to use new struct domain_attr_io_pgtbl_config
>> >> (Will)
>> >
>> > Modulo some minor comments I've made, this looks good to me. What is
>> > the
>> > plan for merging it? I can take the IOMMU parts, but patches 4-6 touch
>> > the
>> > MSM GPU driver and I'd like to avoid conflicts with that.
>> >
>> 
>> SMMU bits are pretty much independent and GPU relies on the domain
>> attribute
>> and the quirk exposed, so as long as SMMU changes go in first it 
>> should
>> be good.
>> Rob?
> 
> I suppose one option would be to split out the patch that adds the
> attribute into it's own patch, and merge that both thru drm and iommu?
> 

Ok I can split out domain attr and quirk into its own patch if Will is
fine with that approach.

> If Will/Robin dislike that approach, I'll pick up the parts of the drm
> patches which don't depend on the new attribute for v5.11 and the rest
> for v5.12.. or possibly a second late v5.11 pull req if airlied
> doesn't hate me too much for it.
> 
> Going forward, I think we will have one or two more co-dependent
> series, like the smmu iova fault handler improvements that Jordan
> posted.  So I would like to hear how Will and Robin prefer to handle
> those.
> 
> BR,
> -R
> 

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
