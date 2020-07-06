Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8091BC433E1
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 16:41:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54C7C206DF
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 16:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fT19NkTl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C7C206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3036688B68;
	Mon,  6 Jul 2020 16:41:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UdsGsPZQKe-C; Mon,  6 Jul 2020 16:41:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9F14588A96;
	Mon,  6 Jul 2020 16:41:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8338DC0891;
	Mon,  6 Jul 2020 16:41:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA7E7C016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 16:41:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C0DCA88A96
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 16:41:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hDJYwOy2pyZ9 for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 16:41:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3259A88B66
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 16:41:28 +0000 (UTC)
Received: from localhost (mobile-166-175-191-139.mycingular.net
 [166.175.191.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8947B206CD;
 Mon,  6 Jul 2020 16:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594053688;
 bh=GgON5CyUmdCh9gM1yE2zg5keUKFUHjT+R0XZmnw2GG0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=fT19NkTlPcN7uq4ojyq9w156sXu6RUldP7nJRC3jaxSHLfSzffA928AFQyWOk5Pc7
 IN5sYZathQ3apDu4R+LMjyfml+EflfEl1CVumw8gedIZLqoynzdjgY4oeIICPEk8CO
 SKh8CAuVEivlDQW5jVKkf9ADr2S9hsjabqwMxi3E=
Date: Mon, 6 Jul 2020 11:41:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/7] PCI: Set "untrusted" flag for truly external
 devices only
Message-ID: <20200706164126.GA124329@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200630075554.GA619174@kroah.com>
Cc: Todd Broch <tbroch@google.com>, linux-pci@vger.kernel.org,
 lalithambika.krishnakumar@intel.com,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Diego Rivas <diegorivas@google.com>, Rajat Jain <rajatja@google.com>,
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

On Tue, Jun 30, 2020 at 09:55:54AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jun 29, 2020 at 09:49:38PM -0700, Rajat Jain wrote:
> > The "ExternalFacing" devices (root ports) are still internal devices that
> > sit on the internal system fabric and thus trusted. Currently they were
> > being marked untrusted.
> > 
> > This patch uses the platform flag to identify the external facing devices
> > and then use it to mark any downstream devices as "untrusted". The
> > external-facing devices themselves are left as "trusted". This was
> > discussed here: https://lkml.org/lkml/2020/6/10/1049
> 
> {sigh}
> 
> First off, please use lore.kernel.org links, we don't control lkml.org
> and it often times has been down.
> 
> Also, you need to put all of the information in the changelog, referring
> to another place isn't always the best thing, considering you will be
> looking this up in 20+ years to try to figure out why people came up
> with such a crazy design.
> 
> But, the main point is, no, we did not decide on this.  "trust" is a
> policy decision to make by userspace, it is independant of "location",
> while you are tieing it directly here, which is what I explicitly said
> NOT to do.
> 
> So again, no, I will NAK this patch as-is, sorry, you are mixing things
> together in a way that it should not do at this point in time.

What do you see being mixed together here?  I acknowledge that the
name of "pdev->untrusted" is probably a mistake.  But this patch
doesn't change anything there.  It only changes the treatment of the
edge case of the "ExternalFacing" ports.  Previously we treated them
as being external themselves, which does seem wrong.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
