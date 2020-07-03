Return-Path: <SRS0=r5As=AO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E13EC433E0
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 16:59:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62A8D208C7
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 16:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="fDmiVC3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A8D208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 335EF235BE;
	Fri,  3 Jul 2020 16:59:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fuf5iPhMiOLt; Fri,  3 Jul 2020 16:59:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 744B4204D7;
	Fri,  3 Jul 2020 16:59:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62AAFC0888;
	Fri,  3 Jul 2020 16:59:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 086F4C0733
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 16:59:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C84F62333F
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 16:59:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xVQOee9JINom for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jul 2020 16:59:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail29.static.mailgun.info (mail29.static.mailgun.info
 [104.130.122.29])
 by silver.osuosl.org (Postfix) with ESMTPS id DAD79204D7
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 16:59:19 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1593795559; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=+gnWJZLQFOi3Y3xgbq+Jj83g8jf7HMQgZHy7FN5ldrA=;
 b=fDmiVC3/UUDh81x2fPLdbadyxJH4jm5fhdKF2HrnItzWXJY8XBT/Ox7Y7x+ggbt4KMtzRE6P
 pHfnmM8MegU/7n+BxWqEJBhkf2K8SfULnDHzyQ4zgSLw/DK+ABSYaCPL35oT1uQehqPrZqSH
 S0c/d1A8odRb5I4O+O31CZbeTVA=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5eff63e7567385e8e7257732 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 03 Jul 2020 16:59:19
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 45A5AC433CA; Fri,  3 Jul 2020 16:59:18 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 6CB36C433C6;
 Fri,  3 Jul 2020 16:59:16 +0000 (UTC)
MIME-Version: 1.0
Date: Fri, 03 Jul 2020 22:29:16 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCHv3 7/7] drm/msm/a6xx: Add support for using system
 cache(LLC)
In-Reply-To: <CAF6AEGsCROVTsi2R7_aUkmH9Luoc_guMR0w0KUJc2cEgpfj79w@mail.gmail.com>
References: <cover.1593344119.git.saiprakash.ranjan@codeaurora.org>
 <449a6544b10f0035d191ac52283198343187c153.1593344120.git.saiprakash.ranjan@codeaurora.org>
 <20200703133732.GD18953@willie-the-truck>
 <ecfda7ca80f6d7b4ff3d89b8758f4dc9@codeaurora.org>
 <CAF6AEGsCROVTsi2R7_aUkmH9Luoc_guMR0w0KUJc2cEgpfj79w@mail.gmail.com>
Message-ID: <c925406446bb2f6c7aead8e047672cae@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: Will Deacon <will@kernel.org>, David Airlie <airlied@linux.ie>,
 Sean Paul <sean@poorly.run>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>,
 Emil Velikov <emil.velikov@collabora.com>, "list@263.net:IOMMU DRIVERS ,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Matthias Kaehlcke <mka@chromium.org>,
 "Kristian H . Kristensen" <hoegsberg@google.com>,
 Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Stephen Boyd <swboyd@chromium.org>,
 freedreno <freedreno@lists.freedesktop.org>,
 Sharat Masetty <smasetty@codeaurora.org>, "moderated
 list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>
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

On 2020-07-03 21:34, Rob Clark wrote:
> On Fri, Jul 3, 2020 at 7:53 AM Sai Prakash Ranjan
> <saiprakash.ranjan@codeaurora.org> wrote:
>> 
>> Hi Will,
>> 
>> On 2020-07-03 19:07, Will Deacon wrote:
>> > On Mon, Jun 29, 2020 at 09:22:50PM +0530, Sai Prakash Ranjan wrote:
>> >> diff --git a/drivers/gpu/drm/msm/msm_iommu.c
>> >> b/drivers/gpu/drm/msm/msm_iommu.c
>> >> index f455c597f76d..bd1d58229cc2 100644
>> >> --- a/drivers/gpu/drm/msm/msm_iommu.c
>> >> +++ b/drivers/gpu/drm/msm/msm_iommu.c
>> >> @@ -218,6 +218,9 @@ static int msm_iommu_map(struct msm_mmu *mmu,
>> >> uint64_t iova,
>> >>              iova |= GENMASK_ULL(63, 49);
>> >>
>> >>
>> >> +    if (mmu->features & MMU_FEATURE_USE_SYSTEM_CACHE)
>> >> +            prot |= IOMMU_SYS_CACHE_ONLY;
>> >
>> > Given that I think this is the only user of IOMMU_SYS_CACHE_ONLY, then
>> > it
>> > looks like it should actually be a property on the domain because we
>> > never
>> > need to configure it on a per-mapping basis within a domain, and
>> > therefore
>> > it shouldn't be exposed by the IOMMU API as a prot flag.
>> >
>> > Do you agree?
>> >
>> 
>> GPU being the only user is for now, but there are other clients which
>> can use this.
>> Plus how do we set the memory attributes if we do not expose this as
>> prot flag?
> 
> It does appear that the downstream kgsl driver sets this for basically
> all mappings.. well there is some conditional stuff around
> DOMAIN_ATTR_USE_LLC_NWA but it seems based on the property of the
> domain.  (Jordan may know more about what that is about.)  But looks
> like there are a lot of different paths into iommu_map in kgsl so I
> might have missed something.
> 
> Assuming there isn't some case where we specifically don't want to use
> the system cache for some mapping, I think it could be a domain
> attribute that sets an io_pgtable_cfg::quirks flag
> 

Ok then we are good to remove unused sys cache prot flag which Will has 
posted.

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
