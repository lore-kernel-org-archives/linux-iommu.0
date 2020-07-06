Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504DCC433E2
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 15:58:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24C752073E
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 15:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLIW21h3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C752073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DD89E2322B;
	Mon,  6 Jul 2020 15:58:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fJa4M-ygawXm; Mon,  6 Jul 2020 15:58:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C50BA25E27;
	Mon,  6 Jul 2020 15:58:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A57BEC0893;
	Mon,  6 Jul 2020 15:58:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AB43C016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 15:58:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1553A88386
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 15:58:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BWBKZsGZwWbE for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 15:58:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8D3248837C
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 15:58:17 +0000 (UTC)
Received: from localhost (mobile-166-175-191-139.mycingular.net
 [166.175.191.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DF7CA20715;
 Mon,  6 Jul 2020 15:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594051097;
 bh=ZQn1vCbZnPD1V6Qxc3hTuBsfI7f6CYU9OMt+sq266xs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=qLIW21h3rjqd2fHfnfQ0qUPPd8NKpa8sR75xE1w1XCw075Ghf/qQm+aWF38BXWraK
 S0FdgLURulHGi/105HaUAEDo2gXySV+i7R4Cfa9ag2rMLTNHpO60E1xiEDlhFy9b4C
 aPHjyEZrQ4KCy28dZ+gme5FyQ2OjSEcI9el4Qsho=
Date: Mon, 6 Jul 2020 10:58:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v2 1/7] PCI: Keep the ACS capability offset in device
Message-ID: <20200706155815.GA119406@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200630044943.3425049-2-rajatja@google.com>
Cc: Todd Broch <tbroch@google.com>, linux-pci@vger.kernel.org,
 lalithambika.krishnakumar@intel.com,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Diego Rivas <diegorivas@google.com>,
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
 Bernie Keany <bernie.keany@intel.com>, Duncan Laurie <dlaurie@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
 oohall@gmail.com, Benson Leung <bleung@google.com>,
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

On Mon, Jun 29, 2020 at 09:49:37PM -0700, Rajat Jain wrote:
> Currently this is being looked up at a number of places. Read and store it
> once at bootup so that it can be used by all later.

Write the commit log so it is complete even without the subject.
Right now, you have to read the subject to know what "this" refers to.

The subject is like the title; the log is like the body of an article.
The title isn't *part* of the article, so the article has to make
sense all by itself.

> +static void pci_enable_acs(struct pci_dev *dev);

I don't think we need this forward declaration, do we?

> @@ -4653,7 +4653,7 @@ static int pci_quirk_intel_spt_pch_acs(struct pci_dev *dev, u16 acs_flags)
>  	if (!pci_quirk_intel_spt_pch_acs_match(dev))
>  		return -ENOTTY;
>  
> -	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
> +	pos = dev->acs_cap;

I assume you verified that all these quirks are FINAL quirks, since
pci_init_capabilities() is called after HEADER quirks.  I'll
double-check before applying this.

Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
