Return-Path: <SRS0=+nyt=54=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21D8C2D0EC
	for <iommu@archiver.kernel.org>; Sun, 12 Apr 2020 03:56:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 868E520737
	for <iommu@archiver.kernel.org>; Sun, 12 Apr 2020 03:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="wLCfbz64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868E520737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E0B88855EF;
	Sun, 12 Apr 2020 03:56:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Fdzt5-HgrNe; Sun, 12 Apr 2020 03:56:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 143B484B80;
	Sun, 12 Apr 2020 03:56:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDB57C1D74;
	Sun, 12 Apr 2020 03:56:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD312C0177
 for <iommu@lists.linux-foundation.org>; Sun, 12 Apr 2020 03:56:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 972F286418
 for <iommu@lists.linux-foundation.org>; Sun, 12 Apr 2020 03:56:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MHqu16652Y9I for <iommu@lists.linux-foundation.org>;
 Sun, 12 Apr 2020 03:56:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CEC71840C2
 for <iommu@lists.linux-foundation.org>; Sun, 12 Apr 2020 03:56:11 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id y25so719977pfn.5
 for <iommu@lists.linux-foundation.org>; Sat, 11 Apr 2020 20:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=endlessm-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zhoRhZDp08/Quy9bCcHgtDQxeTieG6fo0BmAZCUWVT0=;
 b=wLCfbz64y+8kPiY0+va7itbGbEkr9OiPxqNpPlyD19X7zcskbzPg+3TG4gR26frwtI
 Ty3K7iiNK/as921hvyJeGC7dDDXKgS+V7UsP34ZFPt1LqkpWmtTCc/3GPOWZtVaPET7m
 rXU2n3JmL/VisI/TYM6QT+xrNb+7kpzAlIEQ7rsXyogDxbsh0PmdsoUtLJ8hkdJ13Uqz
 2Uxl+dDBnVwOaPvEHayPxS5+nF7CWu33rz4QWdA9kbGSc31KE37TYvpa9CTbYXYL/e1Z
 kdCQwfvvOQPRTjI62pwH+lK9FiCQ9YrS/pXmLuh9XY41pWNZiGu50EEAYk5o2lEnTGWE
 uG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zhoRhZDp08/Quy9bCcHgtDQxeTieG6fo0BmAZCUWVT0=;
 b=dcCGMfTdpEARZxZ+tcwz17+P+LQjy4FzYX7QCQsigW2i7LPgeYdKAhqU1zSxK4OYNf
 uHESittrY0Ux9JzfZyc2oPs2FCeoNC76J2RiF3P5FlhYTqTrP5voBtmnh+CcJzlHNsg1
 wURhPWeBCjgSRch+00YnmCU6XVLqjRfN0xnitu6alOUspnMMslYYnfJYRkaY81pYm1BX
 kUWyJI2Lub1OYTYCjKArZE6aWJNfBT6STS76LDdMxnEjSL3kbKPiTkgiK3dIcgMq77aL
 NuPP6AeAfs5gU3ZI5YnwjcaKuMOnAwsX1toeHOfbw+N75YXM/zHkUToexhWXeLmDlfq3
 /uog==
X-Gm-Message-State: AGi0Pua24OeUEpUPvniLB408dnEklS/4qTBidils/INrEHeM2ecuks/x
 mWjp1Yu8ftSyeWLCRD7J+QCXz26DUzHBqiI/bP5uE6MssIA=
X-Google-Smtp-Source: APiQypIPtGp+Rk2/ThEt56ejQs/3C9hKMliJgxzSeMLEWQqrnotFIgltyl8Zm3S3qvJdGxZ/XTZeHCqFOn4SYHNPH+Q=
X-Received: by 2002:a05:6214:1781:: with SMTP id
 ct1mr11957162qvb.87.1586663420608; 
 Sat, 11 Apr 2020 20:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200409191736.6233-1-jonathan.derrick@intel.com>
 <20200409191736.6233-2-jonathan.derrick@intel.com>
In-Reply-To: <20200409191736.6233-2-jonathan.derrick@intel.com>
From: Daniel Drake <drake@endlessm.com>
Date: Sun, 12 Apr 2020 11:50:09 +0800
Message-ID: <CAD8Lp442LO1Sq5xpKOaRUKLsEyGbou4TiHQrDdnMbCOV-TG0+g@mail.gmail.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: use DMA domain for real DMA devices and
 subdevices
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Bjorn Helgaas <helgaas@kernel.org>,
 Linux Upstreaming Team <linux@endlessm.com>
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

Hi Jon,

Thanks for picking this up. Apologies for my absence here - I wasn't
able to work on this recently, but I'm back again now.

On Fri, Apr 10, 2020 at 3:32 AM Jon Derrick <jonathan.derrick@intel.com> wrote:
> This becomes problematic if the real DMA device and the subdevices have
> different addressing capabilities and some require translation. Instead we can
> put the real DMA dev and any subdevices on the DMA domain. This change assigns
> subdevices to the DMA domain, and moves the real DMA device to the DMA domain
> if necessary.

Have you tested this with the real DMA device in identity mode?
It is not quite working for me. (Again, I'm not using VMD here, but
have looked closely and believe we're working under the same
constraints)

First, the real DMA device gets added to the group:
 pci 0000:00:17.0: Adding to iommu group 9
(it's in IDENTITY mode here)

Then later, the first subdevice comes along, and these are the results:
 pci 10000:00:00.0: [8086:02d7] type 00 class 0x010601
 pci 10000:00:00.0: reg 0x10: [mem 0xae1a0000-0xae1a7fff]
 pci 10000:00:00.0: reg 0x14: [mem 0xae1a8000-0xae1a80ff]
 pci 10000:00:00.0: reg 0x18: [io  0x3090-0x3097]
 pci 10000:00:00.0: reg 0x1c: [io  0x3080-0x3083]
 pci 10000:00:00.0: reg 0x20: [io  0x3060-0x307f]
 pci 10000:00:00.0: reg 0x24: [mem 0xae100000-0xae103fff]
 pci 10000:00:00.0: PME# supported from D3hot
 pci 10000:00:00.0: Adding to iommu group 9
 pci 10000:00:00.0: DMAR: Failed to get a private domain.

That final message is added by your patch and indicates that it's not working.

This is because the subdevice got added to the iommu group before the
code you added tried to change to the DMA domain.

It first gets added to the group through this call path:
    intel_iommu_add_device
-> iommu_group_get_for_dev
-> iommu_group_add_device

Then, continuing within intel_iommu_add_device we get to the code you
added, which tries to move the real DMA dev to DMA mode instead. It
calls:

   intel_iommu_request_dma_domain_for_dev
-> iommu_request_dma_domain_for_dev
-> request_default_domain_for_dev

Which fails here:
    /* Don't change mappings of existing devices */
    ret = -EBUSY;
    if (iommu_group_device_count(group) != 1)
        goto out;

because we already have 2 devices in the group (the real DMA dev, plus
the subdevice we're in the process of handling now).

Next I'll look into the iommu group rework that Baolu mentioned.

Thanks,
Daniel
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
