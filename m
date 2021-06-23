Return-Path: <SRS0=khdJ=LR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFE4C4743C
	for <iommu@archiver.kernel.org>; Wed, 23 Jun 2021 09:07:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E80006128A
	for <iommu@archiver.kernel.org>; Wed, 23 Jun 2021 09:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80006128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B921D82FCE;
	Wed, 23 Jun 2021 09:07:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QYVkxJ4uYRUJ; Wed, 23 Jun 2021 09:07:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A408B8300C;
	Wed, 23 Jun 2021 09:07:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57A57C001A;
	Wed, 23 Jun 2021 09:07:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15CF2C000E
 for <iommu@lists.linux-foundation.org>; Wed, 23 Jun 2021 09:07:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E43E6606A6
 for <iommu@lists.linux-foundation.org>; Wed, 23 Jun 2021 09:07:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M-yc3RSs2UKK for <iommu@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 09:07:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8EB6C6067D
 for <iommu@lists.linux-foundation.org>; Wed, 23 Jun 2021 09:07:45 +0000 (UTC)
Received: by mail-qt1-x833.google.com with SMTP id x21so1508839qtq.9
 for <iommu@lists.linux-foundation.org>; Wed, 23 Jun 2021 02:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=13Gr0i1MTKRVJOLYjbaQS0t+sJQavN2HZYVSf9igv0I=;
 b=SA9G17LOrb34DyVZWPMTTHIONdcJ/5ZbZWqssqBb4aWqa4vseTx3+V6CkFU4RvePBr
 YNNS8jqCGxfTDXRduKfQQMwLt3JL1m3nr4PNVWIksCr6YiJm78aGWUxZDo4V4hXGS1bN
 zAH4ZuRlx4WIbGetsYgzQvT1yucBC3KtrF3U0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=13Gr0i1MTKRVJOLYjbaQS0t+sJQavN2HZYVSf9igv0I=;
 b=VFjNdeHuEIQZWGZJX1YzHFdPbN95X0/IvhqiUy5hnz8bK6RK5yyqmkALpmF6yxZF/p
 DglB4nbc6WuDUG8t8wpialRxLX/P0kvBtiC4AsOwdHxYUXy14YVWCUGZdcRi7YtW7V2L
 phcqYHII+zP+Le8jTqc82Wz390Sye/nlYuarv7+Gpl7ikqEtl5RBApsMFKHUZ/RTSHqq
 c8GgSzQXEfJjqfJOkxrxJ9bdCzkan+/kynzuBDsioOyZVvhgatlxN61ehk9Zym+/NSl5
 5zFpeXHunIyrzxduPMxpi6/2XWBlgcDmAQsT07E6CteenlJUG+R8RJrrUIojCt5XTcoJ
 Bccw==
X-Gm-Message-State: AOAM533wEZqQ22OSm/xMDx9zQnd0UGk1p6BjTyN2NY03gYQKQc+cS/Ke
 hSQTh+xoT10h4NfsFCFvFDotFip1LnquSA==
X-Google-Smtp-Source: ABdhPJw0yQ/x+RZ7v+wttacmfAMl64TjyRBMblby+w7RZCD3HJYRRhEdYDNDlssK+D32aRwv5uGpLA==
X-Received: by 2002:ac8:1008:: with SMTP id z8mr2837432qti.232.1624439264270; 
 Wed, 23 Jun 2021 02:07:44 -0700 (PDT)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com.
 [209.85.222.175])
 by smtp.gmail.com with ESMTPSA id u18sm3331511qta.38.2021.06.23.02.07.43
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jun 2021 02:07:44 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id c23so3300502qkc.10
 for <iommu@lists.linux-foundation.org>; Wed, 23 Jun 2021 02:07:43 -0700 (PDT)
X-Received: by 2002:a02:4b46:: with SMTP id q67mr7991027jaa.84.1624438886886; 
 Wed, 23 Jun 2021 02:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210619034043.199220-1-tientzu@chromium.org>
 <YNLy7z0Zq1AXKLng@char.us.oracle.com>
In-Reply-To: <YNLy7z0Zq1AXKLng@char.us.oracle.com>
From: Claire Chang <tientzu@chromium.org>
Date: Wed, 23 Jun 2021 17:01:16 +0800
X-Gmail-Original-Message-ID: <CALiNf28U9xaqth99u=hB45b=qWMYaSoe2DGgNVFrHXze6wNmdQ@mail.gmail.com>
Message-ID: <CALiNf28U9xaqth99u=hB45b=qWMYaSoe2DGgNVFrHXze6wNmdQ@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] Restricted DMA
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
 peterz@infradead.org, benh@kernel.crashing.org,
 joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
 chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
 Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Saravana Kannan <saravanak@google.com>, mpe@ellerman.id.au,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, intel-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, linux-devicetree <devicetree@vger.kernel.org>,
 Jianxiong Gao <jxgao@google.com>, Daniel Vetter <daniel@ffwll.ch>,
 Will Deacon <will@kernel.org>, maarten.lankhorst@linux.intel.com,
 airlied@linux.ie, Dan Williams <dan.j.williams@intel.com>,
 linuxppc-dev@lists.ozlabs.org, jani.nikula@linux.intel.com,
 Rob Herring <robh+dt@kernel.org>, rodrigo.vivi@intel.com,
 Bjorn Helgaas <bhelgaas@google.com>, boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 Nicolas Boichat <drinkcat@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, xypron.glpk@gmx.de,
 Tom Lendacky <thomas.lendacky@amd.com>, Robin Murphy <robin.murphy@arm.com>,
 bauerman@linux.ibm.com
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

On Wed, Jun 23, 2021 at 4:38 PM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>
> On Sat, Jun 19, 2021 at 11:40:31AM +0800, Claire Chang wrote:
> > This series implements mitigations for lack of DMA access control on
> > systems without an IOMMU, which could result in the DMA accessing the
> > system memory at unexpected times and/or unexpected addresses, possibly
> > leading to data leakage or corruption.
> >
> > For example, we plan to use the PCI-e bus for Wi-Fi and that PCI-e bus is
> > not behind an IOMMU. As PCI-e, by design, gives the device full access to
> > system memory, a vulnerability in the Wi-Fi firmware could easily escalate
> > to a full system exploit (remote wifi exploits: [1a], [1b] that shows a
> > full chain of exploits; [2], [3]).
> >
> > To mitigate the security concerns, we introduce restricted DMA. Restricted
> > DMA utilizes the existing swiotlb to bounce streaming DMA in and out of a
> > specially allocated region and does memory allocation from the same region.
> > The feature on its own provides a basic level of protection against the DMA
> > overwriting buffer contents at unexpected times. However, to protect
> > against general data leakage and system memory corruption, the system needs
> > to provide a way to restrict the DMA to a predefined memory region (this is
> > usually done at firmware level, e.g. MPU in ATF on some ARM platforms [4]).
> >
> > [1a] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_4.html
> > [1b] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_11.html
> > [2] https://blade.tencent.com/en/advisories/qualpwn/
> > [3] https://www.bleepingcomputer.com/news/security/vulnerabilities-found-in-highly-popular-firmware-for-wifi-chips/
> > [4] https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/mediatek/mt8183/drivers/emi_mpu/emi_mpu.c#L132
>
> Heya Claire,
>
> I put all your patches on
> https://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git/log/?h=devel/for-linus-5.14
>
> Please double-check that they all look ok.
>
> Thank you!

They look fine. Thank you!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
