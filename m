Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCA4C433E0
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 17:24:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10B49217D9
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 17:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="VwqXe+SC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B49217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C2EDD877D4;
	Thu, 18 Jun 2020 17:24:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DpUPXW-aE3ql; Thu, 18 Jun 2020 17:24:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 900E587742;
	Thu, 18 Jun 2020 17:24:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77602C088C;
	Thu, 18 Jun 2020 17:24:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26B70C016E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 17:24:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1572B87B86
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 17:24:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ICSV-dnK4WfF for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 17:24:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E14D487B7C
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 17:24:19 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id i27so8179907ljb.12
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 10:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IYlmzlXm+VrJo7JYODsM8cd9UWnB3bZArKAUI6t3sVA=;
 b=VwqXe+SC9JBUUohRt1aVE6bPQXlMwSRhAaTu+S1Nde6pinRGw/JacoeMqkVAyD0Tm9
 TVYeNmo71/8OpIBMvakVOTRQ4qdt7N2gWHl0KoBND9b2yGBmLhGD9FHUXmMmGj7k6Chk
 EFs44/ZeAbBAcrTdN3aT8D2KnyrTPPfhfClu/0sofjIVcmRQS81JNj13Xca9teYGGKKi
 YkjuuIbBrIBIAhlln8dD6OXGjyPAs6J8c5Ghh9XfRl6Q19hGHUNKRtIjJ84FHV4kXucZ
 IIob5LqKzd2fyEMF5BjzUJjc3R+oQE1aN9N3sqafgghbekZ01vHrvykL8xbIXG1NPZQs
 Q8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IYlmzlXm+VrJo7JYODsM8cd9UWnB3bZArKAUI6t3sVA=;
 b=FWxS6PDCCCKKPWwyUSGko0Pg3B3PPqyZf4vvZ4oOvJbyJAlaGTa/mVghMc1OEpRc17
 224ubE7xa+LaOWtlZw0mfMKrXzECy3CnKGFdyTrVXevfGbIq8qWirnLBA1JvpI6UvZP/
 as6JbWvtxtVQQetvev0T0BAASZp8b2VHrd+ipHKD4OXTjsoKE46kjr6mVYbmVJGUK4yN
 ZNSFWJgtsxLgNH/HTsGi5THTCy5fSVxOFiUvn8AcI3p23t9CO9xZlcJqSaGmIaHlZiWl
 1MG0BPnBOnzwAOG+LLZVAjRuzFFFHcV7Dbv6v0HAaaWq2Yz+rWAsYF263XMHqchCYtwP
 0Pdg==
X-Gm-Message-State: AOAM5315t1dERZ9PuAs9o3R2R5EKX6nz9r/uqMxiynESB/quczM7Jj3J
 kG/60GyQY7PNfKzouXyWFJ7sCSN6yCi7mRwlZahUUw==
X-Google-Smtp-Source: ABdhPJyCAdMN0uphyaz9XQHN+YjMSKmZ98XA0/imPSKpbF7ImtJk9dhI7N6nTJB9E4MY2U8MoJdqhVK4c1KFSjUwvcA=
X-Received: by 2002:a2e:8e8d:: with SMTP id z13mr2640858ljk.461.1592501057300; 
 Thu, 18 Jun 2020 10:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200616011742.138975-4-rajatja@google.com>
 <20200616073249.GB30385@infradead.org>
 <CACK8Z6ELaM8KxbwPor=BUquWN7pALQmmHu5geSOc71P3KoJ1QA@mail.gmail.com>
 <20200617073100.GA14424@infradead.org>
 <CACK8Z6FecYkAYQh4sm4RbAQ1iwb9gexqgY9ExD9BH2p-5Usj=g@mail.gmail.com>
 <CAHp75Vc6eA33cyAQH-m+yixTuHqiobg6fo7nzbbb-J6vN6qFcA@mail.gmail.com>
 <20200618083646.GA1066967@kroah.com>
 <CAHp75Vf71f2s6yipHJ4Ys1oe1v7L4PiqBCEbo0uBcG7Wpcs5dQ@mail.gmail.com>
 <CACK8Z6F2Ssj=EqhR2DZ114ETgQ-3PhzVi2rm2xxenCNOVH=60g@mail.gmail.com>
 <20200618160212.GB3076467@kroah.com> <20200618162322.GI34820@otc-nc-03>
In-Reply-To: <20200618162322.GI34820@otc-nc-03>
Date: Thu, 18 Jun 2020 10:23:38 -0700
Message-ID: <CACK8Z6EnqmJtSqPPz2ARk0jwFLR_yCTS0vSLQ0v4C9QF-6BQ1w@mail.gmail.com>
Subject: Re: [PATCH 4/4] pci: export untrusted attribute in sysfs
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: Todd Broch <tbroch@google.com>, linux-pci <linux-pci@vger.kernel.org>,
 "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
 Diego Rivas <diegorivas@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Furquan Shaikh <furquan@google.com>,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 Christoph Hellwig <hch@infradead.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
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

Thanks Greg and Andy for your continued inputs, and thanks Ashok for chiming in.

On Thu, Jun 18, 2020 at 9:23 AM Raj, Ashok <ashok.raj@intel.com> wrote:
>
> Hi Greg,
>
>
> On Thu, Jun 18, 2020 at 06:02:12PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Jun 18, 2020 at 08:03:49AM -0700, Rajat Jain wrote:
> > > Hello,
> > >
> > > On Thu, Jun 18, 2020 at 2:14 AM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > >
> > > > On Thu, Jun 18, 2020 at 11:36 AM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Thu, Jun 18, 2020 at 11:12:56AM +0300, Andy Shevchenko wrote:
> > > > > > On Wed, Jun 17, 2020 at 10:56 PM Rajat Jain <rajatja@google.com> wrote:
> > > > > > > On Wed, Jun 17, 2020 at 12:31 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > > (and likely call it "external" instead of "untrusted".
> > > > > >
> > > > > > Which is not okay. 'External' to what? 'untrusted' has been carefully
> > > > > > chosen by the meaning of it.
> > > > > > What external does mean for M.2. WWAN card in my laptop? It's in ACPI
> > > > > > tables, but I can replace it.
> > > > >
> > > > > Then your ACPI tables should show this, there is an attribute for it,
> > > > > right?
> > > >
> > > > There is a _PLD() method, but it's for the USB devices (or optional
> > > > for others, I don't remember by heart). So, most of the ACPI tables,
> > > > alas, don't show this.
> > > >
> > > > > > This is only one example. Or if firmware of some device is altered,
> > > > > > and it's internal (whatever it means) is it trusted or not?
> > > > >
> > > > > That is what people are using policy for today, if you object to this,
> > > > > please bring it up to those developers :)
> > > >
> > > > > > So, please leave it as is (I mean name).
> > > > >
> > > > > firmware today exports this attribute, why do you not want userspace to
> > > > > also know it?
> > >
> > > To clarify, the attribute exposed by the firmware today is
> > > "ExternalFacingPort" and "external-facing" respectively:
> > >
> > > 617654aae50e ("PCI / ACPI: Identify untrusted PCI devices")
> > > 9cb30a71ac45d("PCI: OF: Support "external-facing" property")
> > >
> > > The kernel flag was named "untrusted" though, hence the assumption
> > > that "external=untrusted" is currently baked into the kernel today.
> > > IMHO, using "external" would fix that (The assumption can thus be
> > > contained in the IOMMU drivers) and at the same time allow more use of
> > > this attribute.
> > >
> > > > >
> > > > > Trust is different, yes, don't get the two mixed up please.  That should
> > > > > be a different sysfs attribute for obvious reasons.
> > > >
> > > > Yes, as a bottom line that's what I meant as well.
> > >
> > > So what is the consensus here? I don't have a strong opinion - but it
> > > seemed to me Greg is saying "external" and Andy is saying "untrusted"?
> >
> > Those two things are totally separate things when it comes to a device.
>
> Agree that these are two separate attributes, and better not mixed.

+1.

>
> >
> > One (external) describes the location of the device in the system.
> >
> > The other (untrusted) describes what you want the kernel to do with this
> > device (trust or not trust it).
> >
> > One you can change (from trust to untrusted or back), the other you can
> > not, it is a fixed read-only property that describes the hardware device
> > as defined by the firmware.

Correct. I believe what is being described by the firmware is a fixed
read-only property describing the location of the device ("external")
- not what to do with it ("untrusted").

>
> The genesis is due to lack of a mechanism to establish if the device
> is trusted or not was the due lack of some specs and implementation around
> Component Measurement And Authentication (CMA). Treating external as
> untrusted was the best first effort. i.e trust internal
> devices and don't trust external devices for enabling ATS.
>
> But that said external is just describing topology, and if Linux wants to
> use that in the policy that's different. Some day external device may also
> use CMA to estabilish trust. FWIW even internal devices aren't trust
> worthy, except maybe RCIEP's.

Correct. Since the firmware is actually describing the unchangeable
topology (and not the policy), the takeaway I am taking from this
discussion is that the flag should be called "external".

Like I said, I don't have any hard opinions on this. So if you feel
that my conclusion is wrong and consensus was the other way around
("untrusted"), let me know and I'll be happy to change this.

Thanks,

Rajat

>
> >
> > Depending on the policy you wish to define, you can use the location of
> > the device to determine if you want to trust the device or not.
> >
>
> Cheers,
> Ashok
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
