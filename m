Return-Path: <SRS0=urD1=5S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5370DC43331
	for <iommu@archiver.kernel.org>; Thu,  2 Apr 2020 17:31:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AFB520737
	for <iommu@archiver.kernel.org>; Thu,  2 Apr 2020 17:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gB9z3S6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFB520737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CCFE92634A;
	Thu,  2 Apr 2020 17:30:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QcI+9nQGjzHa; Thu,  2 Apr 2020 17:30:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 62DAA20406;
	Thu,  2 Apr 2020 17:30:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41568C1AE2;
	Thu,  2 Apr 2020 17:30:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CA09C07FF
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 17:30:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1348C87567
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 17:30:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KGxA2ttL64Xz for <iommu@lists.linux-foundation.org>;
 Thu,  2 Apr 2020 17:30:56 +0000 (UTC)
X-Greylist: delayed 00:05:39 by SQLgrey-1.7.6
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 493CA87561
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 17:30:56 +0000 (UTC)
Received: by mail-ot1-f66.google.com with SMTP id l23so4311824otf.3
 for <iommu@lists.linux-foundation.org>; Thu, 02 Apr 2020 10:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LmdhmlzF1awyNvgI8DSIF40xEnxKcPlPBIva59dgFRc=;
 b=gB9z3S6U8yPzVvzHJqOYA+/pgRoORRtIeBPmqtTNy2Im5pkDobU/hyg0SWw5n/CkZg
 bdv3Epc67zhDaNsJKk94F59sFCCjo5nXJAYHDmPcaVcwA1t3zA/1cjSJKsoukTyEYh4H
 yOhfAxRYkhXROdlOCqT9QDi5hSi7zFg2CAkq0zaJoCHtBBw4YWBvkqR/o8QsKrBiicAB
 YpAQUZwukGF+Mx98hiEqJ1LrqZBuc2Ueqd/LSjU3spfVKTkcq4WBCz+Nd7gqLSI6LK0e
 ZJYRn6opAIP+nz8LUqCdjI4D0m1lF1gObX+zf/VRrH+mj94gU6qFRYtoarRtVsisA8aP
 5UHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LmdhmlzF1awyNvgI8DSIF40xEnxKcPlPBIva59dgFRc=;
 b=REeC3DJJKnf+FGPlM5LYPGM0bs2nqfUoh3ShCbYWEeVTJP6XEFEy85ZudwySkUzyQo
 g5zeyHxuY2tc+lk7YyjZNOqqS+uuc3JbmYRLebLfNc4UscnfmhoiEqQvbWJ5A+arZZ3Q
 bBf8xzijpcuEn4gWiAvlfMniJ3KnUqmGcuGQwpZOdRazkvacvqaKQpPwGfZIayM0xFvN
 pu9bCrJohsuzlP2xrOoH3O8yGI4tNeAJfmhx8FzxiUXcCK5ejXiaHRxaCKUpsehdiV+n
 A1GLH6luh8eqP77yB99PjaaAwjoIf37/s0iQH0dAHX0lzS0ZQNRff4pNaxUVdPgDMixZ
 G3dw==
X-Gm-Message-State: AGi0PubiGkthQip2BpktHYpxK1qEQKE6ipAvAupBpoFrfbivu2pMH/z8
 GhOH7GcmkCw9pZ71I9qpAvIUwQo26/e8+KK18+I/Pe4v3Zg=
X-Google-Smtp-Source: APiQypLanmT1yHgkvL9VMdPGJyPqdbGag32XXaBkghgppBRQanGxtbbuBPenVD5CjGuiuzBeknvhcPnGmgNJSFPJ6gw=
X-Received: by 2002:a9d:344:: with SMTP id 62mr3486852otv.102.1585848316842;
 Thu, 02 Apr 2020 10:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <TYAPR01MB45443DF63B9EF29054F7C41FD8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB45443DF63B9EF29054F7C41FD8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
From: John Stultz <john.stultz@linaro.org>
Date: Thu, 2 Apr 2020 10:25:05 -0700
Message-ID: <CALAqxLWopjCkiM=NR868DTcX-apPc1MPnONJMppm1jzCboAheg@mail.gmail.com>
Subject: Re: How to fix WARN from drivers/base/dd.c in next-20200401 if
 CONFIG_MODULES=y?
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, "rafael@kernel.org" <rafael@kernel.org>
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

On Thu, Apr 2, 2020 at 3:17 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>
> I found an issue after applied the following patches:
> ---
> 64c775f driver core: Rename deferred_probe_timeout and make it global
> 0e9f8d0 driver core: Remove driver_deferred_probe_check_state_continue()
> bec6c0e pinctrl: Remove use of driver_deferred_probe_check_state_continue()
> e2cec7d driver core: Set deferred_probe_timeout to a longer default if CONFIG_MODULES is set
> c8c43ce driver core: Fix driver_deferred_probe_check_state() logic
> ---
>
> Before these patches, on my environment [1], some device drivers
> which has iommus property output the following message when probing:
>
> [    3.222205] ravb e6800000.ethernet: ignoring dependency for device, assuming no driver
> [    3.257174] ravb e6800000.ethernet eth0: Base address at 0xe6800000, 2e:09:0a:02:eb:2d, IRQ 117.
>
> So, since ravb driver is probed within 4 seconds, we can use NFS rootfs correctly.
>
> However, after these patches are applied, since the patches are always waiting for 30 seconds
> for of_iommu_configure() when IOMMU hardware is disabled, drivers/base/dd.c output WARN.
> Also, since ravb cannot be probed for 30 seconds, we cannot use NFS rootfs anymore.
> JFYI, I copied the kernel log to the end of this email.

Hey,
  Terribly sorry for the trouble. So as Robin mentioned I have a patch
to remove the WARN messages, but I'm a bit more concerned about why
after the 30 second delay, the ethernet driver loads:
  [   36.218666] ravb e6800000.ethernet eth0: Base address at
0xe6800000, 2e:09:0a:02:eb:2d, IRQ 117.
but NFS fails.

Is it just that the 30 second delay is too long and NFS gives up?

Does booting with deferred_probe_timeout=0 work?

thanks
-john
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
