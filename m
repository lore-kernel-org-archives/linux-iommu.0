Return-Path: <SRS0=l6pd=55=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA61FC2BBC7
	for <iommu@archiver.kernel.org>; Mon, 13 Apr 2020 02:25:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B216C20678
	for <iommu@archiver.kernel.org>; Mon, 13 Apr 2020 02:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="w0uIf91F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B216C20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 87BF184E34;
	Mon, 13 Apr 2020 02:25:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V6gEqyN5pFup; Mon, 13 Apr 2020 02:25:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CEDEE84E74;
	Mon, 13 Apr 2020 02:25:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4F41C1D74;
	Mon, 13 Apr 2020 02:25:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BEDF9C0172
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 02:25:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B654485C45
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 02:25:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W9C9QSHqMpJo for <iommu@lists.linux-foundation.org>;
 Mon, 13 Apr 2020 02:25:51 +0000 (UTC)
X-Greylist: delayed 22:35:29 by SQLgrey-1.7.6
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com
 [209.85.219.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DA51085BCE
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 02:25:50 +0000 (UTC)
Received: by mail-qv1-f68.google.com with SMTP id q73so3790887qvq.2
 for <iommu@lists.linux-foundation.org>; Sun, 12 Apr 2020 19:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=endlessm-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SLj+x96byFyffDU0A8lFpsAuuOuYHgw1Wo0DJ3Rmb4U=;
 b=w0uIf91FCNWhHbh3UiiEIqU5GLIN4KjeF1LtobS4ivZf0c5u0rTsY6ZPgyZ+zzilev
 ImMd68NwGmDUEWq4All40aBR4/xJJGA9PlKMNqUVOC+1Gfzh25zTSfBBFFRl2F3dhOp1
 zgbK9EXVMGFYKuVDfnlm2HJHg2TDaeW2jFccQE3F9YISm9hIo77w4PSvW8tNgkETuP1z
 J6RGGE8ibnlJErxMtLDQCI+kif9GUh67xDIVeO3q6ZVUXKg51Mg2IXQvxBY0MQSSKV3y
 Ct3p8yqbBHt6Mj3qpzqgPC0EaYAZjyB0Goz14QaueOnocm6KsQLj0rR1EXut8geDBV6M
 OJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SLj+x96byFyffDU0A8lFpsAuuOuYHgw1Wo0DJ3Rmb4U=;
 b=I+NXupV1xFXRWXFChOzeH2mqiK7E0OHkfhQOovIqjofMetUvnlbt9zesRnEkbexNkD
 Mkvtv13vDAM29flbK1iWTJ7/mEM0TcGZNqJ7wTELbbXOADW9kTG8YQM49JhSHyE4ubRL
 1NR9+JNF0v2yxCGYlRIbKzC32efLTeBFdVaAo/xCyAjePutjd7ff8ZIiR7Yb7YfdlPwY
 2Y2LtLDMIQsaNGNe5Lmr8d+ciiTojwUrmTtEJYgji7VMipyX3CZn1oKXwHwFMoJS8vxn
 GzdG4phOVgwH+oFAO0yKaSwESp/ZVrzK4XNyQ+1jXaLUUVl+Td1LqRcEHp87n50z2lb9
 EsFw==
X-Gm-Message-State: AGi0PuYtjPYY2okTN9uHFMUC3vw3HJPH/UZ7+z0neBNhD7z8mBuaYvyO
 iYS1fAxGz5IxC2RdK11o1/95pHWD1oYjbOSf/Iji2Q==
X-Google-Smtp-Source: APiQypJzdEeNNOJxxgr6xQPpqVjrJhaSOfNK2J8Jm5/TVivdr6+qIY/g1gw4IAS1B7nE4RWo2VoSjNfXilf/zd22O/4=
X-Received: by 2002:a05:6214:1781:: with SMTP id
 ct1mr15551512qvb.87.1586744749755; 
 Sun, 12 Apr 2020 19:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200409191736.6233-1-jonathan.derrick@intel.com>
 <20200409191736.6233-2-jonathan.derrick@intel.com>
 <09c98569-ed22-8886-3372-f5752334f8af@linux.intel.com>
In-Reply-To: <09c98569-ed22-8886-3372-f5752334f8af@linux.intel.com>
From: Daniel Drake <drake@endlessm.com>
Date: Mon, 13 Apr 2020 10:25:38 +0800
Message-ID: <CAD8Lp45dJ3-t6qqctiP1a=c44PEWZ-L04yv0r0=1Nrvwfouz1w@mail.gmail.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: use DMA domain for real DMA devices and
 subdevices
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Bjorn Helgaas <helgaas@kernel.org>,
 Linux Upstreaming Team <linux@endlessm.com>,
 Jon Derrick <jonathan.derrick@intel.com>
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

On Fri, Apr 10, 2020 at 9:22 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
> This is caused by the fragile private domain implementation. We are in
> process of removing it by enhancing the iommu subsystem with per-group
> default domain.
>
> https://www.spinics.net/lists/iommu/msg42976.html
>
> So ultimately VMD subdevices should have their own per-device iommu data
> and support per-device dma ops.

Interesting. There's also this patchset you posted:
[PATCH 00/19] [PULL REQUEST] iommu/vt-d: patches for v5.7
https://lists.linuxfoundation.org/pipermail/iommu/2020-April/042967.html
(to be pushed out to 5.8)

In there you have:
> iommu/vt-d: Don't force 32bit devices to uses DMA domain
which seems to clash with the approach being explored in this thread.

And:
> iommu/vt-d: Apply per-device dma_ops
This effectively solves the trip point that caused me to open these
discussions, where intel_map_page() -> iommu_need_mapping() would
incorrectly determine that a intel-iommu DMA mapping was needed for a
PCI subdevice running in identity mode. After this patch, a PCI
subdevice in identity mode uses the default system dma_ops and
completely avoids intel-iommu.

So that solves the issues I was looking at. Jon, you might want to
check if the problems you see are likewise solved for you by these
patches.

I didn't try Joerg's iommu group rework yet as it conflicts with those
patches above.

Daniel
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
