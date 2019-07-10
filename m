Return-Path: <SRS0=bDbm=VH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0549C73C7C
	for <iommu@archiver.kernel.org>; Wed, 10 Jul 2019 10:12:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 840B720838
	for <iommu@archiver.kernel.org>; Wed, 10 Jul 2019 10:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840B720838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7245843C8;
	Wed, 10 Jul 2019 10:12:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0C7C043BF
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Jul 2019 10:03:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 9EE5E883
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Jul 2019 10:03:31 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 081DD344;
	Wed, 10 Jul 2019 03:03:31 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C23F63F246;
	Wed, 10 Jul 2019 03:03:29 -0700 (PDT)
Date: Wed, 10 Jul 2019 11:03:24 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: VFIO/IOMMU/PCI Linux Plumbers 2019 MC - Call for Topics
Message-ID: <20190710100324.GA1397@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Derrick <jonathan.derrick@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi,

following the official LPC19 VFIO/IOMMU/PCI microconference acceptance
notification:

https://www.linuxplumbersconf.org/blog/2019/vfio-iommu-pci-microconference-accepted-into-2019-linux-plumbers-conference/

I am sending out a call for sessions proposals open to all developers
interested/involved in Linux kernel VFIO/IOMMU/PCI development.

The LPC19 blog page provides a list of topics that we put forward for
the microconference submission:

https://www.linuxplumbersconf.org/blog/2019/vfio-iommu-pci-microconference-accepted-into-2019-linux-plumbers-conference/

The blog page is there to provide a list of topics that we considered key
and it should not be considered final, actually it is a starting point to
define a possible schedule structure.

Session proposals for the LPC19 VFIO/IOMMU/PCI microconference are warmly
encouraged and can be submitted here through the common Call for Proposals
LPC19 web page (please choose VFIO/IOMMU/PCI MC topic in the "Track" submenu):

https://www.linuxplumbersconf.org/event/4/abstracts/

Anyone involved in VFIO/IOMMU/PCI kernel development, if you wish to add
sessions and attend the microconference consider yourself welcome, for any
questions just reply to this thread or drop me a line.

Looking forward to meeting you all in Lisbon for this interesting track !

Lorenzo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
