Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3ADC433E1
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:39:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE58420890
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOpCbbD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE58420890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 787B389438;
	Thu, 18 Jun 2020 15:39:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HBebUoHWFCGN; Thu, 18 Jun 2020 15:39:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F386F892A2;
	Thu, 18 Jun 2020 15:39:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3782C088C;
	Thu, 18 Jun 2020 15:39:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2992C016E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:39:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7D6D120502
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:39:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mXpYLrqlr8eO for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 15:39:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com
 [209.85.216.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 9F0AB204C1
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:39:38 +0000 (UTC)
Received: by mail-pj1-f67.google.com with SMTP id jz3so2716345pjb.0
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 08:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GZJ6zrh+Y1Vsbn8ruHOrvITbkoXuvzfrfxu58pe7Zzk=;
 b=nOpCbbD6xUCyUz1YyRFpYFHK9LWD7cjvIZxDiH+RHDIqnZOql6/HyXntIMdZRBmh6W
 qpWKCdPmcmhXmDldMKpyNVRtvcF65untSTh7b5p1WI9usEorDqyqWi+2CMlzv8bzHvnL
 dqwHRgzMvBKGZNXW3AWDlFOGQE2zB0mmd0nG8fJ7sq2Mbb/5W1+6ARarXpTXZ/T5Z7Fh
 NNczurvr+OGHWixUQ43EDkmzuyUQu7NgUxXcjGQunTlZxsMEkwffmiWHpAJiBmVQMQ+O
 PL8u/pNkmfjNg6/x1GGhte/FJXNgJRRoFUgl+zVauVs2zGcOpfx5XpLN7dEWqdjkSM8K
 B3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GZJ6zrh+Y1Vsbn8ruHOrvITbkoXuvzfrfxu58pe7Zzk=;
 b=XVEqUQ1CQB7Ndhwt2odlr4wXZLLDSqAWMhNd1dxzThVas2DWK9o9Ad9pMPRGq5FYUf
 JEAGpSXMN5VaoA6JxMZ/oB2N1ptBdLbtGjDIIApDEG2NvPPoxjx/Y4lj5M10YPOaNAkX
 RAIOuflpfkd2zTm5FcVwFzVD89OlhgJhMKTF8mHpg4rLpYt+2KRv/hsNTdivARICGDnq
 zbMth3ui3vXAXlhIvmxH75NU8dwct1aXVgWIVClP3tzng2SPKAHNkuY4XBKoUDbHJs45
 slsN5jaqS/U1LfkP54BiTb/ULABfiFR8OCJw6sXAAwQTrIJuCbWeKVs9Jyq18ypAv+li
 45/g==
X-Gm-Message-State: AOAM533iFPQL6AKJruVR56QW9zSjCxOaemOv41VJ+5w4hbfo8QOmeHS7
 auRXM3+9QvjVaX4GSJKS9xaHw85zfrVnuzMg1do=
X-Google-Smtp-Source: ABdhPJxoaHYDZlEj8QJ3QkP/ek5K5pisD5wHKUkE1aXeH10OjnRC6dr0cGbGHcW/Er3YFyoGris7X1yJzT3Uyu0wy+o=
X-Received: by 2002:a17:90a:ac05:: with SMTP id
 o5mr5004682pjq.228.1592494778159; 
 Thu, 18 Jun 2020 08:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200616011742.138975-1-rajatja@google.com>
 <20200616011742.138975-4-rajatja@google.com>
 <20200616073249.GB30385@infradead.org>
 <CACK8Z6ELaM8KxbwPor=BUquWN7pALQmmHu5geSOc71P3KoJ1QA@mail.gmail.com>
 <20200617073100.GA14424@infradead.org>
 <CACK8Z6FecYkAYQh4sm4RbAQ1iwb9gexqgY9ExD9BH2p-5Usj=g@mail.gmail.com>
 <CAHp75Vc6eA33cyAQH-m+yixTuHqiobg6fo7nzbbb-J6vN6qFcA@mail.gmail.com>
 <20200618083646.GA1066967@kroah.com>
 <CAHp75Vf71f2s6yipHJ4Ys1oe1v7L4PiqBCEbo0uBcG7Wpcs5dQ@mail.gmail.com>
 <CACK8Z6F2Ssj=EqhR2DZ114ETgQ-3PhzVi2rm2xxenCNOVH=60g@mail.gmail.com>
In-Reply-To: <CACK8Z6F2Ssj=EqhR2DZ114ETgQ-3PhzVi2rm2xxenCNOVH=60g@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 18 Jun 2020 18:39:25 +0300
Message-ID: <CAHp75Vf_gheXBZh-Mm7ME_eVWc5gPcwY98oCH1-QD920mK7gZw@mail.gmail.com>
Subject: Re: [PATCH 4/4] pci: export untrusted attribute in sysfs
To: Rajat Jain <rajatja@google.com>
Cc: Todd Broch <tbroch@google.com>, linux-pci <linux-pci@vger.kernel.org>,
 "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
 Diego Rivas <diegorivas@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Furquan Shaikh <furquan@google.com>, Raj Ashok <ashok.raj@intel.com>,
 Christoph Hellwig <hch@infradead.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Christian Kellner <christian@kellner.me>,
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
 iommu@lists.linux-foundation.org, Oliver O'Halloran <oohall@gmail.com>,
 Benson Leung <bleung@google.com>, David Woodhouse <dwmw2@infradead.org>,
 Alex Levin <levinale@google.com>
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

On Thu, Jun 18, 2020 at 6:04 PM Rajat Jain <rajatja@google.com> wrote:
> On Thu, Jun 18, 2020 at 2:14 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:

...

> To clarify, the attribute exposed by the firmware today is
> "ExternalFacingPort" and "external-facing" respectively:
>
> 617654aae50e ("PCI / ACPI: Identify untrusted PCI devices")
> 9cb30a71ac45d("PCI: OF: Support "external-facing" property")
>
> The kernel flag was named "untrusted" though, hence the assumption
> that "external=untrusted" is currently baked into the kernel today.
> IMHO, using "external" would fix that (The assumption can thus be
> contained in the IOMMU drivers) and at the same time allow more use of
> this attribute.

That discussion had been held, IIRC, during introduction of the
untrusted member in struct pci_dev...

> > > Trust is different, yes, don't get the two mixed up please.  That should
> > > be a different sysfs attribute for obvious reasons.
> >
> > Yes, as a bottom line that's what I meant as well.
>
> So what is the consensus here? I don't have a strong opinion - but it
> seemed to me Greg is saying "external" and Andy is saying "untrusted"?

...and a conclusion has been made as you may see. So, I would highly
recommend to speak to the author(s) of the patch that introduced /
adopted 'untrusted' member.

-- 
With Best Regards,
Andy Shevchenko
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
