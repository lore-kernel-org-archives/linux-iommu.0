Return-Path: <SRS0=U3VV=7Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED993C433E1
	for <iommu@archiver.kernel.org>; Wed,  3 Jun 2020 13:04:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B078E206C3
	for <iommu@archiver.kernel.org>; Wed,  3 Jun 2020 13:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="lhWE4ojU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B078E206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 83F9D86BB9;
	Wed,  3 Jun 2020 13:04:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nKqILg-O1D62; Wed,  3 Jun 2020 13:04:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1C1E086BB1;
	Wed,  3 Jun 2020 13:04:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFDEEC0178;
	Wed,  3 Jun 2020 13:04:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F16E5C016E
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 13:04:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id ECE5286BB9
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 13:04:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wF1lSpZp0uIx for <iommu@lists.linux-foundation.org>;
 Wed,  3 Jun 2020 13:04:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
 [209.85.167.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 23E9E86BB1
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 13:04:34 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id 82so1274702lfh.2
 for <iommu@lists.linux-foundation.org>; Wed, 03 Jun 2020 06:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AYWB9Zc3GNDA4PRS107hK9DQMWjbBQkU88I58XoczKY=;
 b=lhWE4ojUzpHFe0O0OFM1+zVIveUHYY38pcA0z39T4ZeQiTaWDq06IUxMPk46J1Br/4
 0gXS6KKVZIt3ZexlCUdiSXGQ8gI7mOjAN4zALqktUyBFC7rrQ2JtAAkBOKKXwbwVsQ39
 WuUSMocOxHGEB6QTcB/EJHqm2AERLgmkHs3UFfuzACevExI187V+6o4dPvJIKBTIk3Fh
 p+F1WHJmzDTb2tzBc9BQ7wjUOFeP2HQk4LEBQkX7MNUXl6aSCQaxswFD8tnyk3Tr52+Z
 iEx/Hg4xqaEExhLUMj02mO6HcOKD2lqz0tgebuT3V7G/MUt3aR0agCByDAlsp8E0n9wD
 Fjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AYWB9Zc3GNDA4PRS107hK9DQMWjbBQkU88I58XoczKY=;
 b=sSlgQmYDduzrRJ6ymbbfqLCQZHKr4VslSpoFiCXSN657WkHKz2tAp2FG1VruTNyDjJ
 Z4sW8awjivP66CEZhpRW+bwdkFZQG/qQANDPT9F3vLoKywEksKqVm8NVqKIgcK67PJaI
 u8JOKetSBArV69WZAk+otyFQe6AbZal5AwXPf/pHqI9+xHd9nuv+Yc2EbJdVqT2tj96q
 JWAT5A1n4xnVpEeBcYVEfqDpc2zL7CZ3xrHiPyq1T+NqlxfI85NGxxWVJnv7BthJuuw7
 Sa1wR9ev3xqPirUSYxYnWjWBYEY3h1aBnd/Z2NJud3VMzVFnf8WQ1ndxq9TVqj6MQ/Ux
 ncSQ==
X-Gm-Message-State: AOAM533IerffWg0Ci5KsyVTQYzg7WjN2LspY35Az2iBz7lagmGbDblYt
 CJjdt5LtQAV5RRWPSMpXXzHbzNpPIfk8xdkFUOHpUg==
X-Google-Smtp-Source: ABdhPJx/SFywugEqHpP1CjXoO4eyWzcQB1nCnB+lfviUAqy+jN9TG4KQexDUYMcx860SBT8bJ0bto+LzPC4vG0wngHA=
X-Received: by 2002:a05:6512:2027:: with SMTP id
 s7mr2389351lfs.15.1591189471737; 
 Wed, 03 Jun 2020 06:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200602232602.156049-1-rajatja@google.com>
 <20200603053008.GR247495@lahna.fi.intel.com>
In-Reply-To: <20200603053008.GR247495@lahna.fi.intel.com>
Date: Wed, 3 Jun 2020 06:03:55 -0700
Message-ID: <CACK8Z6GmUBwRV0=DFLdRDWR7vVTCvX8zAGzP8Xpu+hb+YPD2fA@mail.gmail.com>
Subject: Re: [PATCH v3] iommu/vt-d: Don't apply gfx quirks to untrusted devices
To: Mika Westerberg <mika.westerberg@intel.com>
Cc: Todd Broch <tbroch@google.com>, Prashant Malani <pmalani@google.com>,
 Ashok Raj <ashok.raj@intel.com>, Rajat Jain <rajatxjain@gmail.com>,
 Zubin Mithra <zsm@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Krishnakumar,
 Lalithambika" <lalithambika.krishnakumar@intel.com>,
 iommu@lists.linux-foundation.org, Mattias Nissler <mnissler@google.com>,
 Benson Leung <bleung@google.com>, Alex Levin <levinale@google.com>,
 David Woodhouse <dwmw2@infradead.org>
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
From: Rajat Jain via iommu <iommu@lists.linux-foundation.org>
Reply-To: Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Jun 2, 2020 at 10:30 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Tue, Jun 02, 2020 at 04:26:02PM -0700, Rajat Jain wrote:
> > +static bool risky_device(struct pci_dev *pdev)
> > +{
> > +     if (pdev->untrusted) {
> > +             pci_warn(pdev,
> > +                      "Skipping IOMMU quirk for dev (%04X:%04X) on untrusted"
> > +                      " PCI link. Please check with your BIOS/Platform"
> > +                      " vendor about this\n", pdev->vendor, pdev->device);
>
> You should not break user visible strings like this. It makes grepping
> for them harder (see also CodingStyle). You can write it like this instead:
>
>         pci_info(pdev, "Skipping IOMMU quirk for dev (%04X:%04X) on untrusted PCI link\n",
>                  pdev->vendor, pdev->device);
>         pci_info(pdev, "Please check with your BIOS/Platform vendor about this\n");
>
> Also I guess pci_info() might be better here after all. Your call :)

Done, sent the updated patch.

Thanks,

Rajat

>
> Rest of the patch looks good to me.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
