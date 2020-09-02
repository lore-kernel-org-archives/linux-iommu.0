Return-Path: <SRS0=BMay=CL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02749C433E2
	for <iommu@archiver.kernel.org>; Wed,  2 Sep 2020 15:02:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F942087D
	for <iommu@archiver.kernel.org>; Wed,  2 Sep 2020 15:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Z8Lj3Tbq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F942087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 83F8E86955;
	Wed,  2 Sep 2020 15:02:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id raT5ecEb7KZh; Wed,  2 Sep 2020 15:02:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E900186937;
	Wed,  2 Sep 2020 15:02:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCD83C0052;
	Wed,  2 Sep 2020 15:02:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB17DC0051
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 15:02:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B8198871D1
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 15:02:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hiuh4zvZ+ukh for <iommu@lists.linux-foundation.org>;
 Wed,  2 Sep 2020 15:02:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DF0F7871C1
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 15:02:55 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id k15so5596694wrn.10
 for <iommu@lists.linux-foundation.org>; Wed, 02 Sep 2020 08:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZGIVv2/nKkKWqHnBVOyDTBWflj7dKm5Z1J/YDjsaUtE=;
 b=Z8Lj3TbqKgnf+Tg9Z0P832A14FJMQdIVQJkvmocdIbwtjttKsmDE4r9Qh2gQGw6NZU
 As25toD2CuCYv9eeG56/UbBx2y5/4HM22wP8iqo6rr8paXM5g8MG1OByan9PYMbZAEKD
 bMSSkhriycK9xJEs3VgMHxfmN359bRlL1LuGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZGIVv2/nKkKWqHnBVOyDTBWflj7dKm5Z1J/YDjsaUtE=;
 b=Hfib+7eh1/g5CAlLXshBoEKu0mv50cmyfSqGKSqwGKW7Bbbai9Puvyq4nSEZeCWayp
 Sg8mN0vKBroBxPeRhSt+It8zSsaAx3tRRPxX8Mah7hX7K/YEHnVNLCpKM3CY20Rh/n0Y
 lCPwYphkicZTmL+JR+MR4flppvKK3ZJxh/ua6NSZGn0uAGyhIMuWgo+Q3mk/tXbATFhs
 UiP6OnlGUe0JIV6aN7YAaNWyTv5nveX1DEuP4WVePaZ4otaT+V3ftB1PIiz/+GvAdOmF
 HqQkgPJJz4Fg83DCKHwtYslaxa3LV6EROpocgjhoYurbVvkPOpvYNCOoTnPwcj7EyYb6
 3jJA==
X-Gm-Message-State: AOAM530b9LX9EUgefFrTMoPjQ8DG6FLw6FfU0woQMiqmn4XeIn8EX6Tm
 Cpl3D8s/t8QRTUP2W20ymElV+4433aFNhG1j1aEXMw==
X-Google-Smtp-Source: ABdhPJwXlN3NHDVCqgynQUFgcYU8keK6MI5X2Io9fYXPD+Fsy3mNkxkFxRkwEAfYalcTpwO0KXeigTJj+lB1MzHkdrU=
X-Received: by 2002:adf:ba10:: with SMTP id o16mr7576162wrg.100.1599058974152; 
 Wed, 02 Sep 2020 08:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200824193036.6033-1-james.quinlan@broadcom.com>
 <20200824193036.6033-8-james.quinlan@broadcom.com>
 <20200901082429.GA1440@lst.de>
In-Reply-To: <20200901082429.GA1440@lst.de>
Date: Wed, 2 Sep 2020 11:02:42 -0400
Message-ID: <CA+-6iNw1rSJOjQDDEYdB3Y1S5KOjOULANbmsDVBM4Mr4Uifomw@mail.gmail.com>
Subject: Re: [PATCH v11 07/11] device-mapping: Introduce DMA range map,
 supplanting dma_pfn_offset
To: Christoph Hellwig <hch@lst.de>
Cc: Rich Felker <dalias@libc.org>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 "open list:REMOTE PROCESSOR \(REMOTEPROC\) SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Julien Grall <julien.grall@arm.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Will Deacon <will@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "open list:ACPI FOR ARM64 \(ACPI/arm64\)" <linux-acpi@vger.kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, Chen-Yu Tsai <wens@csie.org>,
 Ingo Molnar <mingo@redhat.com>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>,
 Alan Stern <stern@rowland.harvard.edu>, Len Brown <lenb@kernel.org>,
 Ohad Ben-Cohen <ohad@wizery.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Borislav Petkov <bp@alien8.de>,
 "open list:DRM DRIVERS FOR ALLWINNER A10" <dri-devel@lists.freedesktop.org>,
 Yong Deng <yong.deng@magewell.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 Felipe Balbi <balbi@kernel.org>, Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 open list <linux-kernel@vger.kernel.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
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

On Tue, Sep 1, 2020 at 4:24 AM Christoph Hellwig <hch@lst.de> wrote:
>
> I've applied this to the dma-mapping tree.
>
> I had to resolve a conflict in drivers/of/address.c with a recent
> mainline commit.  I also applied the minor tweaks Andy pointed out
> plus a few more style changes.  A real change is that I changed the
> prototype for dma_copy_dma_range_map to require less boilerplate code.
>
> The result is here:
>
>     http://git.infradead.org/users/hch/dma-mapping.git/commitdiff/eef520b232c60e74eb8b33a5a7863ad8f2b4a5c7
>
> please double check that everyting works as expected.
Tested-by: Jim Quinlan <james.quinlan@broadcom.com>

Thanks Christoph
Jim
>
> I can cut a stable branch with this if you need it for other trees, but
> I'd like to wait a few days to see if there is any fallout first.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
