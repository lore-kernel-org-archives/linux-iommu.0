Return-Path: <SRS0=szPT=AU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF86C433E0
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 13:28:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0004E207BC
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 13:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CSHkHm9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0004E207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BE6FC86248;
	Thu,  9 Jul 2020 13:27:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o1Wj_VVz2mTd; Thu,  9 Jul 2020 13:27:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4627A860F9;
	Thu,  9 Jul 2020 13:27:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29242C077B;
	Thu,  9 Jul 2020 13:27:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4180DC016F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 13:27:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2ADCC20433
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 13:27:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hg0lacON3EIM for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jul 2020 13:27:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by silver.osuosl.org (Postfix) with ESMTPS id D953420337
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 13:27:20 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id f7so2381732wrw.1
 for <iommu@lists.linux-foundation.org>; Thu, 09 Jul 2020 06:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mWaS66ErLv63ISCBUv8Nr9+dmGgRCUtKHJMxssgE/AI=;
 b=CSHkHm9+F0ACxplsmgNYxr1myHYkKAn1Lpbiz/LCkZ9AKuceusLCQCIn83wvXUXLa2
 FURtCNllrVje+9rih8o1RYY4qf8+GSnJN2VDH2inYDambwg35p0jpUpsJ8UFZPweg3Zz
 VkoegZsvt0AfQk1WDxeI9lxqIFwVtoc6An0vA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mWaS66ErLv63ISCBUv8Nr9+dmGgRCUtKHJMxssgE/AI=;
 b=IBadv4Yfhj54pEmNlYrPjMmlAqOUVxa1ogCYBv4+jpo5Z6zW5k+zJrMy7f85FZ1tmg
 gVi+w8hNwa5DYBvd5KM33KRy9dW3JGf44zJ2rLyo6SjzhXfZ/XWT/iZc2vDDnu1DozzP
 V928WT32jwn+M8WlpqSApO1wXObQVlFqAVbjIe1jflJWN0a4hwWF0HPjzzn63Ett1Qgv
 tJTaAFHHEDYsXyVIr6ODSBWjnu6vo3eeIGRrmz0GyO2aUUV+aLChbIIBhjA3y0X+50K+
 QfV2FwiAGmcMlCMynQJM6nulEoreenbh1yCW0DYnQa0euHGB5hZa1MvNHjFzfp7+hYQe
 nzSg==
X-Gm-Message-State: AOAM531IVH+TGmj1lQup4C4UprHm+jbWCo6yKNqNgVDHNKgO+/Ca7fta
 RodvL2kyqug1bV0ud1ae6EIcqqjqCGsDw1ICVCtjIw==
X-Google-Smtp-Source: ABdhPJyteHtv7vdDEbgqKCKSc6w9IMCW96FtUoZOjYuTSNpsCwUREsQgtMax8Ea9/qQOrx7ySkJfRSX5QGPcwUqrJm8=
X-Received: by 2002:a5d:4a4f:: with SMTP id v15mr60437347wrs.87.1594301239133; 
 Thu, 09 Jul 2020 06:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200708193219.47134-1-james.quinlan@broadcom.com>
 <20200708193219.47134-9-james.quinlan@broadcom.com>
 <20200709103108.GA20255@lst.de>
In-Reply-To: <20200709103108.GA20255@lst.de>
Date: Thu, 9 Jul 2020 09:27:06 -0400
Message-ID: <CA+-6iNz8NWuBR=PMiiuROneXY_YhMHCkSzy1qZLfNcHH5B2KQg@mail.gmail.com>
Subject: Re: [PATCH v7 08/12] device core: Introduce DMA range map,
 supplanting dma_pfn_offset
To: Christoph Hellwig <hch@lst.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rich Felker <dalias@libc.org>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 "open list:REMOTE PROCESSOR \(REMOTEPROC\) SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Julien Grall <julien.grall@arm.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Frank Rowand <frowand.list@gmail.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 "open list:ACPI FOR ARM64 \(ACPI/arm64\)" <linux-acpi@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Ingo Molnar <mingo@redhat.com>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>,
 Alan Stern <stern@rowland.harvard.edu>, Len Brown <lenb@kernel.org>,
 Ohad Ben-Cohen <ohad@wizery.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Maxime Ripard <mripard@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Borislav Petkov <bp@alien8.de>,
 "open list:DRM DRIVERS FOR ALLWINNER A10" <dri-devel@lists.freedesktop.org>,
 Yong Deng <yong.deng@magewell.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oliver Neukum <oneukum@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 open list <linux-kernel@vger.kernel.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Sudeep Holla <sudeep.holla@arm.com>,
 "open list:ALLWINNER A10 CSI DRIVER" <linux-media@vger.kernel.org>,
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

Hi Christoph,

I'm sending all commits to <linux-pci@vger.kernel.org> since most of
them are PCI related.  I don't send all patches to
linux-kernel@vger.kernel.org since I've read it is overused.  The --cc
list is generated by get_maintainer.pl.

IIRC, in a previous discussion you said you preferred NOT to get the
entire patchset by "--to Christoph"  but instead you would pick it off
from one of the "-to " kernel list sites.  It appears that  all
commits made it to the PCI list
(https://www.spinics.net/lists/linux-pci/).

Let me know what you want and I'll make it so.

Regards,
Jim


On Thu, Jul 9, 2020 at 6:31 AM Christoph Hellwig <hch@lst.de> wrote:
>
> I someone seem to get just this patch instead of the full series for
> review again..
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
