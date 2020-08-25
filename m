Return-Path: <SRS0=rFPO=CD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE70C433E1
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 16:10:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2545520782
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 16:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bFps5sAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2545520782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D4E9F22D55;
	Tue, 25 Aug 2020 16:10:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p9-jeCGUU7u4; Tue, 25 Aug 2020 16:10:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2E53E1FFFE;
	Tue, 25 Aug 2020 16:10:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13E5BC016F;
	Tue, 25 Aug 2020 16:10:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30BB2C0051
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 16:10:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1EB6F8758A
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 16:10:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JFW32tmjbYgZ for <iommu@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 16:10:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ua1-f66.google.com (mail-ua1-f66.google.com
 [209.85.222.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4222B86FD1
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 16:10:55 +0000 (UTC)
Received: by mail-ua1-f66.google.com with SMTP id x17so3896617uao.5
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 09:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WgWByWGvguKIeIoz2+159dX6x4UuEkDuTZbs4BUSmnA=;
 b=bFps5sAmhdTDJhNVxL1nFnSKSn5gg1ysP1pQuHcF2HYjtCQl+LECrZqH7IHlUmNWY7
 k42yemoAfbjbGsQdB3VL4GU1eGJDvTb0Lf5BCj305ARzwvSADE3QxswOOxOFEAvUeynp
 pGEol79S1Wfm/yaUHQYpiWmto96jvLx6UpnVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WgWByWGvguKIeIoz2+159dX6x4UuEkDuTZbs4BUSmnA=;
 b=P1SxHSxHBDHdIsuSPfUNvNUUPVQKRrSu0xHntI7bRGVj9k3kiUVHfJv/EIT1TConBX
 HTzMSdF4Rp+83Sw2HOxbqIZWQmxhuRqOu7GkuHhEYr1TTltnGlVC689zJjjWjt4N71WD
 1AjceDcnsRzKEWF3LRFkPtX+1KCWENtDe/eQ3RqSCrZAqk46Kr64s7fPdopeHg3aNVXY
 HxyJvET5uBHKAzxsZTx082KhA24G1jtkC3QfDC2uIIWBstb/t641h5z+XI0ASjR5GevI
 Z3lsFtKvbho3ejlbw1itlRElS0E1JUDspZoQGpzHOw0/o4SKzWqlRsmYybJ0kSoEinS+
 H8YA==
X-Gm-Message-State: AOAM530Gzith1SlYBfZmFnyjHZmewEfqCM3D/eCNZ36amI9xF8KvQKxs
 2Wv9i/J0SMCRgqwuwn9VZrRuHr7fYrvy0A==
X-Google-Smtp-Source: ABdhPJz5aLrr+YQLpZfI4yvpbmoNd0TmItwt4xkUz93Qhy2+RH/7C73KKpM38XwJKN8f8DS0B7P45w==
X-Received: by 2002:ab0:3791:: with SMTP id d17mr5812366uav.28.1598371853818; 
 Tue, 25 Aug 2020 09:10:53 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com.
 [209.85.217.50])
 by smtp.gmail.com with ESMTPSA id b21sm2073391uap.15.2020.08.25.09.10.52
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 09:10:52 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id r7so6642432vsq.5
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 09:10:52 -0700 (PDT)
X-Received: by 2002:a67:fbcc:: with SMTP id o12mr6262613vsr.213.1598371852357; 
 Tue, 25 Aug 2020 09:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200825154249.20011-1-saiprakash.ranjan@codeaurora.org>
In-Reply-To: <20200825154249.20011-1-saiprakash.ranjan@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 25 Aug 2020 09:10:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XK3Xa3rRWvuSA_jA+5_1XYBmHEX2B2XSb8h3oOe1PHLw@mail.gmail.com>
Message-ID: <CAD=FV=XK3Xa3rRWvuSA_jA+5_1XYBmHEX2B2XSb8h3oOe1PHLw@mail.gmail.com>
Subject: Re: [PATCH] iommu: Add support to filter non-strict/lazy mode based
 on device names
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Stephen Boyd <swboyd@chromium.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

Hi,

On Tue, Aug 25, 2020 at 8:43 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Currently the non-strict or lazy mode of TLB invalidation can only be set
> for all or no domains. This works well for development platforms where
> setting to non-strict/lazy mode is fine for performance reasons but on
> production devices, we need a more fine grained control to allow only
> certain peripherals to support this mode where we can be sure that it is
> safe. So add support to filter non-strict/lazy mode based on the device
> names that are passed via cmdline parameter "iommu.nonstrict_device".
>
> Example: iommu.nonstrict_device="7c4000.sdhci,a600000.dwc3,6048000.etr"

I have an inherent dislike of jamming things like this onto the
command line.  IMHO the command line is the last resort for specifying
configuration and generally should be limited to some specialized
debug options and cases where the person running the kernel needs to
override a config that was set by the person (or company) compiling
the kernel.  Specifically, having a long/unwieldy command line makes
it harder to use for the case when an end user actually wants to use
it to override something.  It's also just another place to look for
config.

The other problem is that this doesn't necessarily scale very well.
While it works OK for embedded cases it doesn't work terribly well for
distributions.  I know that in an out-of-band thread you indicated
that it doesn't break anything that's not already broken (AKA this
doesn't fix the distro case but it doesn't make it worse), it would be
better to come up with a more universal solution.

Ideally it feels like we should figure out how to tag devices in a
generic manner automatically (hardcode at the driver or in the device
tree).  I think the out-of-band discussions talked about "external
facing" and the like.  We could also, perhaps, tag devices that have
"binary blob" firmware if we wanted.  Then we'd have a policy (set by
Kconfig, perhaps overridable via commandline) that indicated the
strictness level for the various classes of devices.  So policy would
be decided by KConfig and/or command line.

-Doug
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
