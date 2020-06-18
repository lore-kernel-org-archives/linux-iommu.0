Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429C0C433DF
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 06:18:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A2B2186A
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 06:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGFnZH/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A2B2186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8C8A020387;
	Thu, 18 Jun 2020 06:18:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6F9z0oL8VG3u; Thu, 18 Jun 2020 06:18:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B5FCB20357;
	Thu, 18 Jun 2020 06:18:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98EF2C0863;
	Thu, 18 Jun 2020 06:18:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C04B1C016E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 06:18:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A3F4A8843B
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 06:18:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kxs1Ajusbveo for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 06:18:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A1EAA8842D
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 06:18:24 +0000 (UTC)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8CB11217A0;
 Thu, 18 Jun 2020 06:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592461104;
 bh=HAlp2tDJH3cJiBHUwxJhNgGAK1kQ1E4yMCcXlEeqs78=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YGFnZH/qxGeZiY//+LODKLj7bcSwyB7/m8jtc3u4vRh6hm3/Se2lEeMHSsRhqMOJq
 /c5mpTUoL6eUZry163d8kI073YDaCdpQKq0e7SAgbAI5FQfmWumi7umOoc+tT0NSYA
 zWsw0Q9eJPDd6ogQRSC4Le/4nYn7+NncYHshtZIs=
Date: Thu, 18 Jun 2020 08:18:21 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH 4/4] pci: export untrusted attribute in sysfs
Message-ID: <20200618061821.GB49383@kroah.com>
References: <20200616011742.138975-1-rajatja@google.com>
 <20200616011742.138975-4-rajatja@google.com>
 <20200616073249.GB30385@infradead.org>
 <CACK8Z6ELaM8KxbwPor=BUquWN7pALQmmHu5geSOc71P3KoJ1QA@mail.gmail.com>
 <20200617073100.GA14424@infradead.org>
 <CACK8Z6FecYkAYQh4sm4RbAQ1iwb9gexqgY9ExD9BH2p-5Usj=g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACK8Z6FecYkAYQh4sm4RbAQ1iwb9gexqgY9ExD9BH2p-5Usj=g@mail.gmail.com>
Cc: Todd Broch <tbroch@google.com>, linux-pci <linux-pci@vger.kernel.org>,
 "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
 Diego Rivas <diegorivas@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Furquan Shaikh <furquan@google.com>, Raj Ashok <ashok.raj@intel.com>,
 Christoph Hellwig <hch@infradead.org>, linux-acpi@vger.kernel.org,
 Christian Kellner <christian@kellner.me>,
 Mattias Nissler <mnissler@google.com>, Jesse Barnes <jsbarnes@google.com>,
 Len Brown <lenb@kernel.org>, Rajat Jain <rajatxjain@gmail.com>,
 Prashant Malani <pmalani@google.com>, Aaron Durbin <adurbin@google.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Bernie Keany <bernie.keany@intel.com>, Duncan Laurie <dlaurie@google.com>,
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

On Wed, Jun 17, 2020 at 12:53:03PM -0700, Rajat Jain wrote:
> Hi Greg, Christoph,
> 
> On Wed, Jun 17, 2020 at 12:31 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Tue, Jun 16, 2020 at 12:27:35PM -0700, Rajat Jain wrote:
> > > Need clarification. The flag "untrusted" is currently a part of
> > > pci_dev struct, and is populated within the PCI subsystem.
> >
> > Yes, and that is the problem.
> >
> > >
> > > 1) Is your suggestion to move this flag as well as the attribute to
> > > device core (in "struct device")? This would allow other buses to
> > > populate/use this flag if they want. By default it'll be set to 0 for
> > > all devices (PCI subsystem will populate it based on platform info,
> > > like it does today).
> > >
> > > OR
> > >
> > > 2) Are you suggesting to keep the "untrusted" flag within PCI, but
> > > attach the sysfs attribute to the base device? (&pci_dev->dev)?
> >
> > (1).  As for IOMMUs and userspace policy it really should not matter
> > what bus a device is on if it is external and not trustworthy.
> 
> Sure. I can move the flag to the "struct device" (and likely call
> it "external" instead of "untrusted" so as to make it suitable for
> more use cases later).  The buses can fill this up if they know which
> devices are external and which ones are not (otherwise it will be 0 by
> default). The PCI can fill this up like it does today, from platform
> info (ACPI / Device tree). Greg, how does this sound?

That's fine, convert USB over to use it at the same time if you get the
chance :)

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
