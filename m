Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96211C433DF
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 12:52:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC8A20774
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 12:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cco5bmoE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC8A20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2F6F622613;
	Tue, 30 Jun 2020 12:52:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KOh5KIpTevvb; Tue, 30 Jun 2020 12:52:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 936332049D;
	Tue, 30 Jun 2020 12:52:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 855BCC088F;
	Tue, 30 Jun 2020 12:52:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60847C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 12:52:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4F1F587D46
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 12:52:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y+4iRWZNk-6i for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 12:52:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B6C5687D45
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 12:52:28 +0000 (UTC)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BEE7F2068F;
 Tue, 30 Jun 2020 12:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593521548;
 bh=amRiArINE+WmUf9ax03q1U0lMCq5RfbQ8ZbzfLKtgBg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Cco5bmoE3CYrLezNHfqq54eRM1tMJ5en4y7SfP5cJBqVoWy+6hyFiZoMrl5If688Q
 iHXnPPiWjE71DMWEPgc/X55d6wcP3bFRxgl/rA8Bgdd6OcGvEgtjZrriH+yojQTv2N
 lIpeYVA0bUibyUSq9F9UorQk1+FI/P3N3dvYQ+DU=
Date: Tue, 30 Jun 2020 14:52:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 5/7] driver core: Add device location to "struct
 device" and expose it in sysfs
Message-ID: <20200630125216.GA1109228@kroah.com>
References: <20200630044943.3425049-1-rajatja@google.com>
 <20200630044943.3425049-6-rajatja@google.com>
 <20200630104948.GC856968@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200630104948.GC856968@kuha.fi.intel.com>
Cc: Todd Broch <tbroch@google.com>, linux-pci@vger.kernel.org,
 lalithambika.krishnakumar@intel.com, Diego Rivas <diegorivas@google.com>,
 Rajat Jain <rajatja@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Furquan Shaikh <furquan@google.com>, Raj Ashok <ashok.raj@intel.com>,
 Saravana Kannan <saravanak@google.com>, linux-acpi@vger.kernel.org,
 Christian Kellner <christian@kellner.me>,
 Mattias Nissler <mnissler@google.com>, Jesse Barnes <jsbarnes@google.com>,
 Len Brown <lenb@kernel.org>, Rajat Jain <rajatxjain@gmail.com>,
 Prashant Malani <pmalani@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Aaron Durbin <adurbin@google.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Benson Leung <bleung@google.com>, Duncan Laurie <dlaurie@google.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
 oohall@gmail.com, Bernie Keany <bernie.keany@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Alex Levin <levinale@google.com>
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

On Tue, Jun 30, 2020 at 01:49:48PM +0300, Heikki Krogerus wrote:
> On Mon, Jun 29, 2020 at 09:49:41PM -0700, Rajat Jain wrote:
> > Add a new (optional) field to denote the physical location of a device
> > in the system, and expose it in sysfs. This was discussed here:
> > https://lore.kernel.org/linux-acpi/20200618184621.GA446639@kroah.com/
> > 
> > (The primary choice for attribute name i.e. "location" is already
> > exposed as an ABI elsewhere, so settled for "site"). Individual buses
> > that want to support this new attribute can opt-in by setting a flag in
> > bus_type, and then populating the location of device while enumerating
> > it.
> 
> So why not just call it "physical_location"?

That's better, and will allow us to put "3rd blue plug from the left,
4th row down" in there someday :)

All of this is "relative" to the CPU, right?  But what CPU?  Again, how
are the systems with drawers of PCI and CPUs and memory that can be
added/removed at any point in time being handled here?  What is
"internal" and "external" for them?

What exactly is the physical boundry here that is attempting to be
described?

thanks,

greg "not all the world is your laptop" k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
