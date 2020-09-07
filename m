Return-Path: <SRS0=ylBP=CQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CB7C2BB84
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 17:44:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDF2E206E7
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 17:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="A0Stn/cy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF2E206E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9E62885FC9;
	Mon,  7 Sep 2020 17:44:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XwhPXFG3q7FH; Mon,  7 Sep 2020 17:44:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5719386054;
	Mon,  7 Sep 2020 17:44:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C83EC0859;
	Mon,  7 Sep 2020 17:44:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8877C0051
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 17:44:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CD2C8867D4
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 17:44:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zBb2weHfJVu7 for <iommu@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 17:44:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E5F3185736
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 17:44:03 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id x23so5124552wmi.3
 for <iommu@lists.linux-foundation.org>; Mon, 07 Sep 2020 10:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TtLg9Y4dgEBmAcytToxU0LrQsMgfNF7OgoEHJZ2Q+vw=;
 b=A0Stn/cyvojbDX7w3lzbvMIO7gTwe43sZAGbFpuAEdS5sHSClH8/IZ2AifZ+YY+VOX
 UVwM/aA+6tWtgJSEoCDO1PW617SUSIQB8k6b0bPqqeB7dxfGKJQUxNBeFtcQo9e3Ascw
 6zhcNnrpuccjT086HR4puL61ghnrcI3EOoQm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TtLg9Y4dgEBmAcytToxU0LrQsMgfNF7OgoEHJZ2Q+vw=;
 b=B8u00krXoyMELKrYsXSedqqx2PEEBDPQ4guzK58VN0kKeZG8GaKTdGATiTWwtHzjlF
 GWpymEZVPwfN1szAa6CUxeHNrMLCO2Qe7hm0zvRSvCCDjY1K6yv0byBUg6b1/I4mUMdv
 UuqSz5HI0rC1VsUoUH0PLsDvswtdStPpAKdTHhahRkCIQ+bs/H28LZ67b+x0aDZxpgnS
 7MG936mB8RBg83jFwZN1jErHjrPRH1CQQCOf6PdEikIgHU57u6qYFgdmHRFiEDzmVNiB
 +OubgPsh1hyluIPS3+Njijs1uUN5VUHHwiI4sGVNascHCk+bP9cebvWHWWtQNWQppM8+
 /jWQ==
X-Gm-Message-State: AOAM530anQNkwzfZi65DEHFxb4a0pMj+tKvYUoON4LmN6aAKPPTIxIZN
 gbivv0UNu7BG38stRaJRcye6Ebmb9zTKwIveZNh82w==
X-Google-Smtp-Source: ABdhPJyNQsBm1Y3/ieHSfjO664M9CBhnY/ZnuJjayy1tYR+ob0ku/Wpd26F5nf8H2/xl9/84D4TcAGvzrj4IPjrxwfU=
X-Received: by 2002:a1c:bad5:: with SMTP id k204mr408820wmf.111.1599500642170; 
 Mon, 07 Sep 2020 10:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200824193036.6033-1-james.quinlan@broadcom.com>
 <b19bc982-a0c4-c6ff-d8f5-650f2b3a83c8@gmail.com>
 <20200827063517.GA4637@lst.de>
 <CA+-6iNy3U9pO0Bykzgvb9n9fcsBi6FiatLdpA1s0HgQNWZ49mg@mail.gmail.com>
 <20200907091649.GA6428@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200907091649.GA6428@e121166-lin.cambridge.arm.com>
Date: Mon, 7 Sep 2020 13:43:23 -0400
Message-ID: <CA+-6iNzoz3pM2pJksXogeuou6wB9W-59rN-amCLERFLuY5zLMg@mail.gmail.com>
Subject: Re: [PATCH v11 00/11] PCI: brcmstb: enable PCIe for STB chips
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "open list:SUPERH" <linux-sh@vger.kernel.org>,
 "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>,
 "open list:REMOTE PROCESSOR \(REMOTEPROC\) SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>,
 "open list:DRM DRIVERS FOR ALLWINNER A10" <dri-devel@lists.freedesktop.org>,
 Julien Grall <julien.grall@arm.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Christoph Hellwig <hch@lst.de>,
 "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Saravana Kannan <saravanak@google.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "open list:ACPI FOR ARM64 \(ACPI/arm64\)" <linux-acpi@vger.kernel.org>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 "open list:ALLWINNER A10 CSI DRIVER" <linux-media@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
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
From: Jim Quinlan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jim Quinlan <james.quinlan@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Sep 7, 2020 at 5:16 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Thu, Aug 27, 2020 at 09:29:59AM -0400, Jim Quinlan wrote:
> > On Thu, Aug 27, 2020 at 2:35 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Tue, Aug 25, 2020 at 10:40:27AM -0700, Florian Fainelli wrote:
> > > > Hi,
> > > >
> > > > On 8/24/2020 12:30 PM, Jim Quinlan wrote:
> > > >>
> > > >> Patchset Summary:
> > > >>    Enhance a PCIe host controller driver.  Because of its unusual design
> > > >>    we are foced to change dev->dma_pfn_offset into a more general role
> > > >>    allowing multiple offsets.  See the 'v1' notes below for more info.
> > > >
> > > > We are version 11 and counting, and it is not clear to me whether there is
> > > > any chance of getting these patches reviewed and hopefully merged for the
> > > > 5.10 merge window.
> > > >
> > > > There are a lot of different files being touched, so what would be the
> > > > ideal way of routing those changes towards inclusion?
> > >
> > > FYI, I offered to take the dma-mapping bits through the dma-mapping tree.
> > > I have a bit of a backlog, but plan to review and if Jim is ok with that
> > > apply the current version.
> > Sounds good to me.
>
> Hi Jim,
>
> is the dependency now solved ? Should we review/take this series as
> is for v5.10 through the PCI tree ?
Hello Lorenzo,

We are still working out a regression with the DMA offset commit on
the RaspberryPi.  Nicolas has found the root cause and we are now
devising a solution.

Thanks,
Jim Quinlan
Broadcom STB

>
> Thanks,
> Lorenzo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
