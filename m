Return-Path: <SRS0=8AL1=AI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C128DC433DF
	for <iommu@archiver.kernel.org>; Sat, 27 Jun 2020 05:02:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94693207FC
	for <iommu@archiver.kernel.org>; Sat, 27 Jun 2020 05:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqimtLyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94693207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 52343204BC;
	Sat, 27 Jun 2020 05:02:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qURl6aaBx1pp; Sat, 27 Jun 2020 05:02:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A60DA20338;
	Sat, 27 Jun 2020 05:02:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C40FC0863;
	Sat, 27 Jun 2020 05:02:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45C8BC016F
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 05:02:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 39A86856E9
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 05:02:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rCRflrwceGDh for <iommu@lists.linux-foundation.org>;
 Sat, 27 Jun 2020 05:02:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AE5868567A
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 05:02:28 +0000 (UTC)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E4F4A206C0;
 Sat, 27 Jun 2020 05:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593234148;
 bh=52mxIUaZLoVmxOKx2Gb5mRUH3pwu1njJu8Quot51mAQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qqimtLyZ8v0ZX6Q98SVgJ9b13idUWAU0lFfM9RXjq6+4AbY8ka6ooCu8eI1+N413a
 hLJZjfsxJQNVpvzt3xSNv9cLHlXpk6xrNQ7whNr2pO4QVz+c2EejPer90/rRMRjnTs
 GaSfg7F32eP4YGanottsIxPOehppWJUkWX6Xal1A=
Date: Sat, 27 Jun 2020 07:02:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH 2/2] pci: Add parameter to disable attaching untrusted
 devices
Message-ID: <20200627050225.GA226238@kroah.com>
References: <20200626002710.110200-1-rajatja@google.com>
 <20200626002710.110200-2-rajatja@google.com>
 <20200626141754.GB4141629@kroah.com>
 <CACK8Z6GSN5iOaCh-ZMaJSY4SgEhw=bCRDzaiPEBJbNNFhZZX6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACK8Z6GSN5iOaCh-ZMaJSY4SgEhw=bCRDzaiPEBJbNNFhZZX6Q@mail.gmail.com>
Cc: Todd Broch <tbroch@google.com>, linux-pci <linux-pci@vger.kernel.org>,
 "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
 Diego Rivas <diegorivas@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Furquan Shaikh <furquan@google.com>, Raj Ashok <ashok.raj@intel.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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

On Fri, Jun 26, 2020 at 11:53:34AM -0700, Rajat Jain wrote:
> a) I think what was decided was introducing a device core "location"
> property that can be exposed to userspace to help it to decide whether
> or not to attach a driver to a device. Yes, that is still the plan.

Great, but this patch ignores that and starts to add policy :(

> (Mild sidenote: userspace may not need to distinguish between internal
> and external devices if it can assume that no internal PCI devices
> will show up after "echo 0 > /sys/bus/pci/drivers_autoprobe". But
> nevertheless...)

It can not assume that.

> b) Note that even with (a) in place, we still need a parameter that
> can ensure that drivers are not bound to external devices at boot,
> *before* userspace gets a chance to disable "drivers_autoprobe".

Why do you think you need that?  I kind of doubt you really want this,
but ick, if you really do, make it a policy decision that you bake into
the kernel as a build option, so that no one else has to use it :)

> https://lkml.org/lkml/2020/6/15/1453

Ick, please use lore.kernel.org, we don't control lkml.org and it's not
all that reliable.

> Is it OK to add such a parameter in device core?

You don't have internal/external/wherever in the driver core yet, so
don't start adding policy before you get that...

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
