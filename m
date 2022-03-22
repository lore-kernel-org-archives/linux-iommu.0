Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832DAC433EF
	for <iommu@archiver.kernel.org>; Tue, 22 Mar 2022 11:12:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E8E040214;
	Tue, 22 Mar 2022 11:12:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R9pqD1EIQYnz; Tue, 22 Mar 2022 11:12:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2F230401ED;
	Tue, 22 Mar 2022 11:12:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0696C0012;
	Tue, 22 Mar 2022 11:12:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9B97C000B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 11:12:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E54BB611DC
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 11:12:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eGVziDlnjDx6 for <iommu@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 11:12:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com
 [209.85.219.172])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B2883600C4
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 11:12:07 +0000 (UTC)
Received: by mail-yb1-f172.google.com with SMTP id j2so33093536ybu.0
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 04:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eAEB4EkYiyDLjCGXztqi5rjXvrVzYwYiLfT7TEzd0Gg=;
 b=8DaFBnp9IqFrb5f/5Z7fRcbjZgDuU7bBmjgOJwfKt5xDIZC5tKcPHV0+aHUxauupwv
 V6l8JLXP9fozHDQap/y12ooZqAs0BqE/nnMcsUxPm9pX9o4ShXAJfrLB5ov5TxQ+HJWk
 hITTx0kyZ8n32MDDzU2udoGBZH73pMsQZDdV8vpM//v/PCTqVOsfuOTCHag01uo5gD2y
 M4ScI4ky6QayZceM6Vtxx/QA999l+NY5dUDbEobpW7FYxp1L18/PylKJqq6TMPIbdm5H
 MOQvNRrXA1a5M/SNiA4wM3ZUCotu2gqaYLQGOyIzMKLG0cj8sFWX4zZ9zcfaAGHM78ye
 dxyQ==
X-Gm-Message-State: AOAM533YSAhab+W/SirLhWaCzxC4QUhCcaBgY+GMjVajzAPJ9QNteZne
 OVwoVmZ+w7FurS7F9GrPp8RpI4S08pSX5nWffUI=
X-Google-Smtp-Source: ABdhPJy7J3kPzMh3zGdCCagbfKmYuXjzWcE8v2f7kXswi1R/nTTBK/UC4hqgkaKir+RL0Wu6Iy0fT3HByLTjqEq1cT8=
X-Received: by 2002:a25:fe10:0:b0:625:262f:e792 with SMTP id
 k16-20020a25fe10000000b00625262fe792mr25846281ybe.365.1647947526731; Tue, 22
 Mar 2022 04:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220320062907.3272903-1-rajatja@google.com>
 <YjmQq1DvWnJwUh6R@infradead.org>
In-Reply-To: <YjmQq1DvWnJwUh6R@infradead.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 22 Mar 2022 12:11:54 +0100
Message-ID: <CAJZ5v0h9TnUELahzkO59Vqoio1QRHfixk58Yxgffa72rmEBgOA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] PCI: Rename "pci_dev->untrusted" to
 "pci_dev->poses_dma_risk"
To: Christoph Hellwig <hch@infradead.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Rajat Jain <rajatxjain@gmail.com>, Will Deacon <will@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Pavel Machek <pavel@denx.de>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Oliver O'Halloran <oohall@gmail.com>,
 Rajat Jain <rajatja@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jesse Barnes <jsbarnes@google.com>, Dmitry Torokhov <dtor@google.com>,
 Len Brown <lenb@kernel.org>
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

On Tue, Mar 22, 2022 at 10:02 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, Mar 19, 2022 at 11:29:05PM -0700, Rajat Jain wrote:
> > Rename the field to make it more clear, that the device can execute DMA
> > attacks on the system, and thus the system may need protection from
> > such attacks from this device.
> >
> > No functional change intended.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> > v4: Initial version, created based on comments on other patch
>
> What a horrible name.  Why not untrusted_dma which captures the
> intent much better?

FWIW, I like this one much better too.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
