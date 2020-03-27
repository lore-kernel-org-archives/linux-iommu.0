Return-Path: <SRS0=HkIk=5M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A14C43331
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 16:17:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE0A820675
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 16:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9zjbZDu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0A820675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F1B7787B92;
	Fri, 27 Mar 2020 16:17:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sd9p3Mjtejj7; Fri, 27 Mar 2020 16:17:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5F31C87893;
	Fri, 27 Mar 2020 16:17:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39DEDC18DA;
	Fri, 27 Mar 2020 16:17:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B941C0177
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 16:17:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7FC7B20400
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 16:17:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GCkp26dn05r3 for <iommu@lists.linux-foundation.org>;
 Fri, 27 Mar 2020 16:17:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 65BA12078C
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 16:17:07 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id a20so11927960edj.2
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 09:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bhwCLD99THloN8dCbGNfgSTq5wDx5PYUGJHnnh+sr0s=;
 b=W9zjbZDuHcCXzsT5Gpy0NgsGp0UPXuI9jopRCIueqai8LTcuZTMbscs1+ZYXCOUB9S
 unaTG6d5+l3w6zwUaepGSZM5//sy9Ml8qbaXMKCzw3Bvuy/wvdIxVr7VkLM2ny96mfew
 BX++H56uAmBxEwDft7uV6q/rqC6yDL8IAQ6xXWsmSrnzvNwn7lUzLTSTtH1iyRBCyD98
 WUMqiAFJ32jiI6omQok5qXuXsoUnoQwdY9OUFu0RVdlRga7r1A9o6duNRTBz4MVZWuds
 iHEgEd1n5a13NUE48zkaZtQo8ggUv691sYn2u53dJmNmrldzWKN47s7pD9oq3jvCr3Gz
 Jl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bhwCLD99THloN8dCbGNfgSTq5wDx5PYUGJHnnh+sr0s=;
 b=e2eEJzs0aUrP7Kb7c/ktFGiT4Da4Bz4ynnlJGD9848cXd1aFYbnFFbi808bSdEYlGi
 q2+WAV/1BrgM2yaOSPXtCblmk/IEgv+QFKhKcgSQOaDCiljfI0riVGRWd9UiMMdGj986
 cBft7pkbnu6T3qcoGMe3J7t4mfL6VfHX7DiZ6KmVOLgOmlla6iBkVAUtrdQFvO4KeG0l
 BzW5HVKMlL/P5xyMILTPhKOy+4AJmGsGL2QUFo4kcULXwE8qol6Sar27d0IFoKZ3fqJD
 ZkrMExJZ3yi/CnYKTupYmy5uily7IODRINodSf80UGxd7C7UaGogqUFWVaF6k10o6WkO
 0x8g==
X-Gm-Message-State: ANhLgQ2tkt75zudBoCiDOCz+R2EPqGmWhD2thzYo59dr1MrtUYmSRUXQ
 KPRIXr7cPRp38lPmf+Pb6c8IYzXcsP0hAI3YSbg=
X-Google-Smtp-Source: ADFU+vvZ+s+3+GJf+hwaZ3hW3JamirY1OAA+vKuZrKrhYuxc/pgFwbRhyyFNqRxoAKf7w6JsLpe+Tfrb428/As9gqC0=
X-Received: by 2002:a50:d712:: with SMTP id t18mr13743363edi.151.1585325825642; 
 Fri, 27 Mar 2020 09:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200327132852.10352-1-saiprakash.ranjan@codeaurora.org>
 <0023bc68-45fb-4e80-00c8-01fd0369243f@arm.com>
 <37db9a4d524aa4d7529ae47a8065c9e0@codeaurora.org>
In-Reply-To: <37db9a4d524aa4d7529ae47a8065c9e0@codeaurora.org>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 27 Mar 2020 09:17:03 -0700
Message-ID: <CAF6AEGtWqaGf1m_ew=iSQG2cX0_tV=W_7DwKRkTJUWJaParsvw@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu: Demote error messages to debug in
 shutdown callback
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: Will Deacon <will@kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>
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

On Fri, Mar 27, 2020 at 8:10 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Hi Robin,
>
> Thanks for taking a look at this.
>
> On 2020-03-27 19:42, Robin Murphy wrote:
> > On 2020-03-27 1:28 pm, Sai Prakash Ranjan wrote:
> >> Currently on reboot/shutdown, the following messages are
> >> displayed on the console as error messages before the
> >> system reboots/shutdown.
> >>
> >> On SC7180:
> >>
> >>    arm-smmu 15000000.iommu: removing device with active domains!
> >>    arm-smmu 5040000.iommu: removing device with active domains!
> >>
> >> Demote the log level to debug since it does not offer much
> >> help in identifying/fixing any issue as the system is anyways
> >> going down and reduce spamming the kernel log.
> >
> > I've gone back and forth on this pretty much ever since we added the
> > shutdown hook - on the other hand, if any devices *are* still running
> > in those domains at this point, then once we turn off the SMMU and let
> > those IOVAs go out on the bus as physical addresses, all manner of
> > weirdness may ensue. Thus there is an argument for *some* indication
> > that this may happen, although IMO it could be downgraded to at least
> > dev_warn().
> >
>
> Any pointers to the weirdness here after SMMU is turned off?
> Because if we look at the call sites, device_shutdown is called
> from kernel_restart_prepare or kernel_shutdown_prepare which would
> mean system is going down anyways, so do we really care about these
> error messages or warnings from SMMU?
>
>   arm_smmu_device_shutdown
>    platform_drv_shutdown
>     device_shutdown
>      kernel_restart_prepare
>       kernel_restart
>

I'd guess that drm/msm is not detaching all of it's UNMANAGED domains
in shutdown.  Although *presumably* the device_link stuff would
prevent the SMMU from shutting down while gpu/display is still active?
 If not I think we have bigger problems.

I hadn't really noticed the error msgs before, not sure if that is
just because the screen is off by the time they happen or if they are
a new warning..

BR,
-R
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
