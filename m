Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF399C433E0
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:04:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A8842075E
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="QIP0WJ0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A8842075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 59CF187B9A;
	Thu, 18 Jun 2020 15:04:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f4Sj7xqV3y5w; Thu, 18 Jun 2020 15:04:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C36FC87B88;
	Thu, 18 Jun 2020 15:04:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF3EBC07FF;
	Thu, 18 Jun 2020 15:04:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC390C016E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:04:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9A54487580
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:04:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OoNF5Wwzq119 for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 15:04:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0835C876C6
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:04:28 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id x18so7657922lji.1
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 08:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e3AaxzkJKvuJF6KN/5uB+HjzXUCfsnMRb9K1Yv0qPEs=;
 b=QIP0WJ0pNtpLo2KJbUw4+wbBhH7Nnk4+ZwOpPnliesoYCCasWqpMx0mMvynxG60m+Z
 u9PE+P5aKkxeVIOwcEMeLon6Vxu0ScvNx/Niy7Yn8ML9ty8p1K5Wm8ci57YEPFHfrR4P
 nuNnTB8kCWrogjZzQY7mXYIRdfoRzg01usyn60SP5OxOh7iWQEaYWfIvSZ3N8Zte4yZC
 Rmwzx1CddNdJNUqFG/N0Uke9o/ae2SSRn86wCciYZsKbVFC/U3vXdqP1N9vMXMDCRKEZ
 nivk6Tb2mzWBW2DcZpP2cyo8FA3tGarbAyFlHjAkABu/Oq6U36aYxnJ+PE3wuHAxS/BG
 aYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e3AaxzkJKvuJF6KN/5uB+HjzXUCfsnMRb9K1Yv0qPEs=;
 b=E9kAonYu0vEfqwhRw7ss+Bjd6NZuvmi2qkGaxjLiQFI0VCVnrXx2Tn+7sKuxyAbEIt
 5xbYIncOhRt6TWHsSJdmJyDQoKAyO6a/W0wNFrB+SVf68QOAeH5OyxLzq1uwQZ9ahrSX
 kwbE+4FaajXgPDQXBuXcj6a+ic8W7grZYLWfvcm3vYHUvy6PA2Mdnef3oDk5PK5p3wTh
 Bp1gl/RxL3BElMCZoKUT9AuG2TQOAYbKyTMnaecN9BRkw+jZtNWqMqvXVdnUZZLvFnzR
 zIf3usez5ygkbWPy0v3mlsFxg83dgAlbRBw8DXbXZ/mv0hb3gNJ7ZQcUgsBsyAhZ0DFA
 dujw==
X-Gm-Message-State: AOAM532Ui4JnLHy9U/QwHYaPuAjhVY3jP2Xla3/br5QaRle9EUkPLKGG
 8qCc6bh6RMRB3/mTU6xlG7QzwUlJLFc1FJpZADeg7Q==
X-Google-Smtp-Source: ABdhPJwvN0DsAWY3KYiObhTJs8ezFwVTnlVqyM1Aw6aFgxEL3CC4+lrTUDtkDUUgYpMKr67ZSTWxedjAX6xltpaE9DI=
X-Received: by 2002:a2e:908f:: with SMTP id l15mr2330895ljg.307.1592492665864; 
 Thu, 18 Jun 2020 08:04:25 -0700 (PDT)
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
In-Reply-To: <CAHp75Vf71f2s6yipHJ4Ys1oe1v7L4PiqBCEbo0uBcG7Wpcs5dQ@mail.gmail.com>
Date: Thu, 18 Jun 2020 08:03:49 -0700
Message-ID: <CACK8Z6F2Ssj=EqhR2DZ114ETgQ-3PhzVi2rm2xxenCNOVH=60g@mail.gmail.com>
Subject: Re: [PATCH 4/4] pci: export untrusted attribute in sysfs
To: Andy Shevchenko <andy.shevchenko@gmail.com>
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
From: Rajat Jain via iommu <iommu@lists.linux-foundation.org>
Reply-To: Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hello,

On Thu, Jun 18, 2020 at 2:14 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Jun 18, 2020 at 11:36 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jun 18, 2020 at 11:12:56AM +0300, Andy Shevchenko wrote:
> > > On Wed, Jun 17, 2020 at 10:56 PM Rajat Jain <rajatja@google.com> wrote:
> > > > On Wed, Jun 17, 2020 at 12:31 AM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > ...
> > >
> > > > (and likely call it "external" instead of "untrusted".
> > >
> > > Which is not okay. 'External' to what? 'untrusted' has been carefully
> > > chosen by the meaning of it.
> > > What external does mean for M.2. WWAN card in my laptop? It's in ACPI
> > > tables, but I can replace it.
> >
> > Then your ACPI tables should show this, there is an attribute for it,
> > right?
>
> There is a _PLD() method, but it's for the USB devices (or optional
> for others, I don't remember by heart). So, most of the ACPI tables,
> alas, don't show this.
>
> > > This is only one example. Or if firmware of some device is altered,
> > > and it's internal (whatever it means) is it trusted or not?
> >
> > That is what people are using policy for today, if you object to this,
> > please bring it up to those developers :)
>
> > > So, please leave it as is (I mean name).
> >
> > firmware today exports this attribute, why do you not want userspace to
> > also know it?

To clarify, the attribute exposed by the firmware today is
"ExternalFacingPort" and "external-facing" respectively:

617654aae50e ("PCI / ACPI: Identify untrusted PCI devices")
9cb30a71ac45d("PCI: OF: Support "external-facing" property")

The kernel flag was named "untrusted" though, hence the assumption
that "external=untrusted" is currently baked into the kernel today.
IMHO, using "external" would fix that (The assumption can thus be
contained in the IOMMU drivers) and at the same time allow more use of
this attribute.

> >
> > Trust is different, yes, don't get the two mixed up please.  That should
> > be a different sysfs attribute for obvious reasons.
>
> Yes, as a bottom line that's what I meant as well.

So what is the consensus here? I don't have a strong opinion - but it
seemed to me Greg is saying "external" and Andy is saying "untrusted"?

Thanks,
Rajat

>
> --
> With Best Regards,
> Andy Shevchenko
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
