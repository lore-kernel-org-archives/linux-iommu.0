Return-Path: <SRS0=GrUw=AH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36ACBC433DF
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 08:14:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1DEF207E8
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 08:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pi6qOR8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DEF207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DFF1F86C1E;
	Fri, 26 Jun 2020 08:14:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hvWaGsgsxFe9; Fri, 26 Jun 2020 08:14:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 58F4186B67;
	Fri, 26 Jun 2020 08:14:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 343BBC0863;
	Fri, 26 Jun 2020 08:14:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB328C016F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 07:53:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A23CE883CD
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 07:53:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pQzw4TQYryMr for <iommu@lists.linux-foundation.org>;
 Fri, 26 Jun 2020 07:53:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f195.google.com (mail-il1-f195.google.com
 [209.85.166.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 71F638837C
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 07:53:09 +0000 (UTC)
Received: by mail-il1-f195.google.com with SMTP id x18so7721197ilp.1
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 00:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Bny++tBIMk54Yvx2zfPmbf+0Ot1GMKL64TsxDOduJ60=;
 b=pi6qOR8sPj7wZ3XcK4gDbT3e2yS9IRpuNkEBpAAyS6vV2vySKo5Vm4MZOHf5dN9/n6
 rZDPHSot2GRbxX/1REKPttlo+Gzk75IZceDEaIfFmYI8QXZB1LQg8qHLSxJxDsLKnxml
 l0cwdUTYDBeOKmNiN4Q4pARW90E2EoDrX3YkT0CSSeeqdi8A0SGs3Dqcl9ovEFyfi1Yx
 sZGDoFNouIlleCmILazYchvNRfPX6sKs4K/xW6F/9FmIvA1+S+9jyKRggl7PqLJFkorf
 Tag+SsZRh2Zu+9n87emt6epFAkp6mqih/EHD8iJ4U29ckOKIHgwgJgpsK2LVXpMVVvS2
 lXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Bny++tBIMk54Yvx2zfPmbf+0Ot1GMKL64TsxDOduJ60=;
 b=J85yvYTaJV90Tv7rJEKGIDMuWx0adkjta4ZfrrBep6Hao4szjF85pvMyuv9vMS47BG
 l0Zct29TFLXrYOLUNWT0K6P90mAJR+8oVndMhvQa/kdL/hWjxG5bDTpwW+aL+Q9yxITi
 c0xcBS/GvT4sTSeIoD46YfqZKh9MK50lIJG762FgX4/sdLyyJPnBTgEGi5FP7wNtHcd6
 bjEDP6Ac599dLs6LhcRkJX93xhjx8ZxCvTv8tp4UokAovbRrlPyoJyyW01jED2ZktaBA
 JClCsQo3k6GK50zpHVA5+6oSNufgxf9TGIcsK28xwSUqmh83XQgCGxidtoq9NG8HckTH
 EvVA==
X-Gm-Message-State: AOAM531j78e7WPN5pe/M9VL7aHxbVty+cIAImfNL+Fx94Gp3dIZa4vyf
 yohjmH3MBi5Lf0IgaH2WfkTG79HG2Koijk5DdPc=
X-Google-Smtp-Source: ABdhPJxWukgYdKg85VYa/UxfpvGS2QookcbFIPNFv/QZkXY9QvIFnKJ30Qho5lEy3R+IADOlR2rMSdIe2qRRQsQNYrE=
X-Received: by 2002:a92:5e17:: with SMTP id s23mr1766973ilb.149.1593157988638; 
 Fri, 26 Jun 2020 00:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200626002710.110200-1-rajatja@google.com>
 <20200626002710.110200-2-rajatja@google.com>
In-Reply-To: <20200626002710.110200-2-rajatja@google.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Fri, 26 Jun 2020 17:52:57 +1000
Message-ID: <CAOSf1CHwj7qD6CdZ+AnY3s1JQXvO0eAG5CgoSHAUBGjtZ6+QfA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pci: Add parameter to disable attaching untrusted
 devices
To: Rajat Jain <rajatja@google.com>
X-Mailman-Approved-At: Fri, 26 Jun 2020 08:13:58 +0000
Cc: Todd Broch <tbroch@google.com>, linux-pci <linux-pci@vger.kernel.org>,
 "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
 Diego Rivas <diegorivas@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Furquan Shaikh <furquan@google.com>, Raj Ashok <ashok.raj@intel.com>,
 linux-acpi@vger.kernel.org, Christian Kellner <christian@kellner.me>,
 Mattias Nissler <mnissler@google.com>, Jesse Barnes <jsbarnes@google.com>,
 Len Brown <lenb@kernel.org>, Rajat Jain <rajatxjain@gmail.com>,
 Prashant Malani <pmalani@google.com>, Aaron Durbin <adurbin@google.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Bernie Keany <bernie.keany@intel.com>, Duncan Laurie <dlaurie@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Benson Leung <bleung@google.com>,
 David Woodhouse <dwmw2@infradead.org>, Alex Levin <levinale@google.com>
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

On Fri, Jun 26, 2020 at 10:27 AM Rajat Jain <rajatja@google.com> wrote:
>
> Introduce a PCI parameter that disables the automatic attachment of
> untrusted devices to their drivers.
>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> Context:
>
>   I set out to implement the approach outlined in
>     https://lkml.org/lkml/2020/6/9/1331
>     https://lkml.org/lkml/2020/6/15/1453
>
>   But to my surprise, I found that the new hotplugged PCI devices
>   were getting automatically attached to drivers even though
>   /sys/bus/pci/drivers_autoprobe was set to 0.
>
>   I realized that the device core's "drivers_autoprobe":
>
>   * only disables the *initial* probe of the device (i.e. from
>     device_add()). If a subsystem calls device_attach() explicitly
>     for its devices like PCI subsystem does, the drivers_autoprobe
>     setting does not matter. The core will attach device to the driver.
>     This looks like correct semantic behavior to me because PCI is
>     explicitly calling device_attach(), which is a way to explicitly
>     ask the core to find and attach a driver for a device.

Right, but we're doing using device_attach() largely because the
driver core doesn't provide any mechanism for deferring the initial
probe. I didn't think there was any deeper reason for it, but while
looking I noticed that the initial probe can be async and
device_attach() forces probing to be synchronous. That has the side
effect of serialising all PCI device probing which might be
intentional to avoid device renaming due to the change in probe order.
Userspace is better at dealing with device names changing now days,
but you might still get some people mad at you for changing it.

>   2) Make the drivers_autoprobe property available to PCI to use
>      (currently it is private to device core). The PCI could use this
>      to determine whether or not to call device_attach(). This still
>      leaves the other problem (of not being able to set
>      drivers_autoprobe via command line open).
>
>   3) I found the pci_dev->match_driver, which seemed similar to what I
>      am trying to do, but can't be controlled from userspace. I considered
>      populating that field based on drivers_autoprobe (still need (2)).
>      But the problem is that there is the AMD IOMMU driver which is setting
>      this independently, so setting the match_driver based on
>      drivers_autoprobe may not be a good idea.

Huh, that's pretty weird. Even with that hack you should be able
trigger the bug they're working around by removing the IOMMU device in
sysfs and doing a rescan. I wouldn't worry much about making
match_device user controllable since you would need to work pretty
hard for it to be an issue.

Oliver
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
