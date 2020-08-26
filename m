Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E788BC433E1
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 15:01:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF5622074A
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 15:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="YOvYz9fm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF5622074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 88EFB865C1;
	Wed, 26 Aug 2020 15:01:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E0Kt7ydEyCeh; Wed, 26 Aug 2020 15:01:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E98EC861AA;
	Wed, 26 Aug 2020 15:01:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0776C016F;
	Wed, 26 Aug 2020 15:01:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06ADFC0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 15:01:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id F00AD87EB0
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 15:01:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8g66kBgOj2KQ for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 15:01:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail29.static.mailgun.info (mail29.static.mailgun.info
 [104.130.122.29])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5B8B487EAD
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 15:01:12 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1598454076; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Es/0pFaKnR2kzEaSjZ72M+ID+T80ab88lrWvsjkbJzY=;
 b=YOvYz9fmCj1lgOJF2gJNq3eCGLF55gYEiOc5j07wfqjjvPtAn3wtYxS0+I6t7AY8VWFBpaWa
 5B2WYYbQKXlwVbufNuUH3lKv+BMwzStg01m6oIUxHx0eAYPOSNIygCHF8S7sN5xRkiLZ0fxQ
 u9dVFUc/2We4EjbkKt9n3BQYjwI=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f4679315bce3a955fc57015 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 26 Aug 2020 15:01:05
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id F253EC433B1; Wed, 26 Aug 2020 15:01:04 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 73DB9C433A1;
 Wed, 26 Aug 2020 15:01:03 +0000 (UTC)
MIME-Version: 1.0
Date: Wed, 26 Aug 2020 20:31:03 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu: Add support to filter non-strict/lazy mode based
 on device names
In-Reply-To: <a03ce8f0-cab5-2782-ac50-930cf94b7dcd@arm.com>
References: <20200825154249.20011-1-saiprakash.ranjan@codeaurora.org>
 <e3e4da33-a44f-0a07-9e2e-0f806875ab0b@arm.com>
 <d9b1f1b614057d87279c26e13cbbb1f5@codeaurora.org>
 <a03ce8f0-cab5-2782-ac50-930cf94b7dcd@arm.com>
Message-ID: <f8ac8f57bcf10b2218b4795197efb854@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
 Stephen Boyd <swboyd@chromium.org>, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

On 2020-08-26 19:21, Robin Murphy wrote:
> On 2020-08-26 13:17, Sai Prakash Ranjan wrote:
>> On 2020-08-26 17:07, Robin Murphy wrote:
>>> On 2020-08-25 16:42, Sai Prakash Ranjan wrote:
>>>> Currently the non-strict or lazy mode of TLB invalidation can only 
>>>> be set
>>>> for all or no domains. This works well for development platforms 
>>>> where
>>>> setting to non-strict/lazy mode is fine for performance reasons but 
>>>> on
>>>> production devices, we need a more fine grained control to allow 
>>>> only
>>>> certain peripherals to support this mode where we can be sure that 
>>>> it is
>>>> safe. So add support to filter non-strict/lazy mode based on the 
>>>> device
>>>> names that are passed via cmdline parameter 
>>>> "iommu.nonstrict_device".
>>> 
>>> There seems to be considerable overlap here with both the existing
>>> patches for per-device default domain control [1], and the broader
>>> ongoing development on how to define, evaluate and handle "trusted"
>>> vs. "untrusted" devices (e.g. [2],[3]). I'd rather see work done to
>>> make sure those integrate properly together and work well for
>>> everyone's purposes, than add more disjoint mechanisms that only
>>> address small pieces of the overall issue.
>>> 
>>> Robin.
>>> 
>>> [1]
>>> https://lore.kernel.org/linux-iommu/20200824051726.7xaJRTTszJuzdFWGJ8YNsshCtfNR0BNeMrlILAyqt_0@z/ 
>>> [2]
>>> https://lore.kernel.org/linux-iommu/20200630044943.3425049-1-rajatja@google.com/ 
>>> [3]
>>> https://lore.kernel.org/linux-iommu/20200626002710.110200-2-rajatja@google.com/
>> 
>> Thanks for the links, [1] definitely sounds interesting, I was under 
>> the impression
>> that changing such via sysfs is late, but seems like other Sai has got 
>> it working
>> for the default domain type. So we can extend that and add a strict 
>> attribute as well,
>> we should be definitely OK with system booting with default strict 
>> mode for all
>> peripherals as long as we have an option to change that later, Doug?
> 
> Right, IIRC there was initially a proposal of a command line option
> there too, and it faced the same criticism around not being very
> generic or scalable. I believe sysfs works as a reasonable compromise
> since in many cases it can be tweaked relatively early from an initrd,
> and non-essential devices can effectively be switched at any time by
> removing and reprobing their driver.
> 

Ah I see, so the catch is that device must not be bound to the driver
and won't work for the internal devices or builtin drivers probed early.

-Sai

> As for a general approach for internal devices where you do believe
> the hardware is honest but don't necessarily trust whatever firmware
> it happens to be running, I'm pretty sure that's come up already, but
> I'll be sure to mention it at Rajat's imminent LPC talk if nobody else
> does.
> 
> Robin.


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
