Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A290C433E1
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 04:49:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC6892067D
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 04:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="eJkYImkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC6892067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AC76D203EF;
	Tue, 30 Jun 2020 04:49:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lhFsMqj7ieDl; Tue, 30 Jun 2020 04:49:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A554C20385;
	Tue, 30 Jun 2020 04:49:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 893F0C0865;
	Tue, 30 Jun 2020 04:49:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A326C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 04:49:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3619887B61
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 04:49:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gIKlR9It1nsV for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 04:49:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com
 [209.85.219.202])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 734F787AB1
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 04:49:48 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id p22so21185355ybg.21
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 21:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=7hLDfRQH9BxeLi4te4CqBue6K7HzO3HL8RSU93kt7FA=;
 b=eJkYImkbmfnxFDU8hfMSme7dtbktJO+dptPEHM9OdfQSJquqzQ2Dunh2RSfdHPb0QW
 Lflu+V+rxJDuJGJNEgAH0tTRKH7f5MqQgf3QW0Z2ck//h43mrzeqbqh0e7nLTIf71cEH
 ++LvFFqJ1jHJpzirL6NEoOQneAUQd9UDn/9Spdl5TObv/Xs3i5rNr1sGPXs3mjGImXnq
 Kqz+FLWa8DEnSdugcjdmJbcrAcQ6bjdXvXnMTyP98VaJ0b09I/lArhactOpdnppimtGy
 AjBG7WoCDugm9DNdgy5doLCdISe0m1Y97+ZJQvrFb3QKqABKPpqA8fRzSHUUaoDHsOeL
 RDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=7hLDfRQH9BxeLi4te4CqBue6K7HzO3HL8RSU93kt7FA=;
 b=IA+tbG6UEC875zkv77nDjx33KhgKQJhV06lNwC73TEdfUbE4tJ7FKsU1JDdCWQYTGQ
 rzJgE6AeHBi8TK+Pb0rqBD7cpm1qGsk1RQXzMjS+DpCS0uHAn64rhsHyg2pTFg8VFCB7
 9dWwVROxHsTZkAlq+xmiGOdOQnj76kiO2O1AsxYsThCPApgMy8wK09JGNIiaHEi0NzfB
 zbGmG1jwbANXhbbbgEPn5LgaWmFYtPojPtnbKzNbX15rK3eyMS1oZkCM4h9O4CucimCe
 He7CWS4jewYpF3klU1GnHiN25NAWvfEdofea8IWka9HQkrgkkmuo3J+rsLT16chDGHlb
 u5TA==
X-Gm-Message-State: AOAM532Y+48mjVZqIT9KpMwN7SrIfb1p+LICMqj3tQW5mX8U9EeYNuJe
 6Uk8XEic866AS0H1ZByWg9Qs8pfhn5uD
X-Google-Smtp-Source: ABdhPJxrD07NSjDpYr9t7nKiVps1AKnSwgUbfmBRtxm6cbXEYEj7w22JAGn9Re24HqxAzu0RSiaZt3/6TOEw
X-Received: by 2002:a25:a2d1:: with SMTP id c17mr32028859ybn.192.1593492587468; 
 Mon, 29 Jun 2020 21:49:47 -0700 (PDT)
Date: Mon, 29 Jun 2020 21:49:36 -0700
Message-Id: <20200630044943.3425049-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2 0/7] Tighten PCI security, expose dev location in sysfs
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
 iommu@lists.linux-foundation.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>, 
 lalithambika.krishnakumar@intel.com, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Prashant Malani <pmalani@google.com>, 
 Benson Leung <bleung@google.com>, Todd Broch <tbroch@google.com>,
 Alex Levin <levinale@google.com>, 
 Mattias Nissler <mnissler@google.com>, Rajat Jain <rajatxjain@gmail.com>, 
 Bernie Keany <bernie.keany@intel.com>, Aaron Durbin <adurbin@google.com>, 
 Diego Rivas <diegorivas@google.com>, Duncan Laurie <dlaurie@google.com>, 
 Furquan Shaikh <furquan@google.com>, Jesse Barnes <jsbarnes@google.com>, 
 Christian Kellner <christian@kellner.me>,
 Alex Williamson <alex.williamson@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, oohall@gmail.com, 
 Saravana Kannan <saravanak@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Rajat Jain <rajatja@google.com>
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

This is a set of loosely related patches most of whom emerged out of
discussion in the following threads. In a nutshell the goal was to allow
an administrator to specify which driver he wants to allow on external
ports, and a strategy was chalked out:
https://lore.kernel.org/linux-pci/20200609210400.GA1461839@bjorn-Precision-5520/
https://lore.kernel.org/linux-pci/20200618184621.GA446639@kroah.com/
https://lore.kernel.org/linux-pci/20200627050225.GA226238@kroah.com/

* The first 3 patches tighten the PCI security using ACS, and take care
  of a border case.
* The 4th patch takes care of PCI bug.
* 5th and 6th patches expose a device's location into the sysfs to allow
  admin to make decision based on that.
* 7th patch is to ensure that the external devices don't bind to drivers
  during boot.

Rajat Jain (7):
  PCI: Keep the ACS capability offset in device
  PCI: Set "untrusted" flag for truly external devices only
  PCI/ACS: Enable PCI_ACS_TB for untrusted/external-facing devices
  PCI: Add device even if driver attach failed
  driver core: Add device location to "struct device" and expose it in
    sysfs
  PCI: Move pci_dev->untrusted logic to use device location instead
  PCI: Add parameter to disable attaching external devices

 drivers/base/core.c         | 35 +++++++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.c | 31 ++++++++++++++++++---------
 drivers/pci/ats.c           |  2 +-
 drivers/pci/bus.c           | 13 ++++++------
 drivers/pci/of.c            |  2 +-
 drivers/pci/p2pdma.c        |  2 +-
 drivers/pci/pci-acpi.c      | 13 ++++++------
 drivers/pci/pci-driver.c    |  1 +
 drivers/pci/pci.c           | 34 ++++++++++++++++++++++++++----
 drivers/pci/pci.h           |  3 ++-
 drivers/pci/probe.c         | 20 +++++++++++-------
 drivers/pci/quirks.c        | 19 +++++++++++++----
 include/linux/device.h      | 42 +++++++++++++++++++++++++++++++++++++
 include/linux/device/bus.h  |  8 +++++++
 include/linux/pci.h         | 13 ++++++------
 15 files changed, 191 insertions(+), 47 deletions(-)

-- 
2.27.0.212.ge8ba1cc988-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
