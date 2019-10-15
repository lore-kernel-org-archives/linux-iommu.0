Return-Path: <SRS0=BRyA=YI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9DCC10F14
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 15:12:53 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 576B320854
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 15:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="UYp+To/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576B320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0A8B6E38;
	Tue, 15 Oct 2019 15:12:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A6B37E22
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 15:11:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from smtp-fw-4101.amazon.com (smtp-fw-4101.amazon.com [72.21.198.25])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 25BB98A0
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 15:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
	t=1571152317; x=1602688317;
	h=from:to:cc:subject:date:message-id:mime-version:
	content-transfer-encoding;
	bh=u+I3dMwQI/KSkSqrBp+39zdAeGJeYw2xPhZwcNW/iQ0=;
	b=UYp+To/Qt/LVq/K5XCZUOexcTNXvYrAcTSdTp9VCHBetf7wW4iw5kOqh
	kEa1eRdTfmOGHEkvYTGphVOBQAwf8t4Cc8zslJ4OOO+TCLUO2nFnnMEGt
	Q3FK5D9Gx+0J2bB2zo09gngIHOLTTIAJTsFSXRJgtUQRKQdrIDIluqPxr I=;
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; d="scan'208";a="793097327"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO
	email-inbound-relay-2b-81e76b79.us-west-2.amazon.com)
	([10.124.125.6])
	by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP;
	15 Oct 2019 15:11:55 +0000
Received: from EX13MTAUEA001.ant.amazon.com
	(pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
	by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (Postfix) with
	ESMTPS id 86ABDA182D; Tue, 15 Oct 2019 15:11:54 +0000 (UTC)
Received: from EX13D13EUA004.ant.amazon.com (10.43.165.22) by
	EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server
	(TLS) id 15.0.1367.3; Tue, 15 Oct 2019 15:11:53 +0000
Received: from localhost (10.43.160.180) by EX13D13EUA004.ant.amazon.com
	(10.43.165.22) with Microsoft SMTP Server (TLS) id 15.0.1367.3;
	Tue, 15 Oct 2019 15:11:51 +0000
To: <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH 0/2] iommu/dmar: expose fault counters via sysfs
Date: Tue, 15 Oct 2019 17:11:10 +0200
Message-ID: <20191015151112.17225-1-volchkov@amazon.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Originating-IP: [10.43.160.180]
X-ClientProxiedBy: EX13D13UWA004.ant.amazon.com (10.43.160.251) To
	EX13D13EUA004.ant.amazon.com (10.43.165.22)
X-Mailman-Approved-At: Tue, 15 Oct 2019 15:12:52 +0000
Cc: bhelgaas@google.com, dwmw2@infradead.org, neugebar@amazon.co.uk,
	Yuri Volchkov <volchkov@amazon.de>
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
From: Yuri Volchkov via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yuri Volchkov <volchkov@amazon.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

For health monitoring, it can be useful to know if iommu is behaving as
expected. DMAR faults can be an indicator that a device:
 - has been misconfigured, or
 - has experienced a hardware hiccup and replacement should
   be considered, or
 - has been issuing faults due to malicious activity

Currently the only way to check if there were any DMAR faults on the
host is to scan the dmesg output. However this approach is not very
elegant. The information we are looking for can be wrapped out of the
buffer, or masked (since it is a rate-limited print) by another
device.

The series adds counters for DMAR faults and exposes them via sysfs.

Yuri Volchkov (2):
  iommu/dmar: collect fault statistics
  iommu/dmar: catch early fault occurrences

 drivers/iommu/dmar.c        | 182 ++++++++++++++++++++++++++++++++----
 drivers/iommu/intel-iommu.c |   1 +
 drivers/pci/pci-sysfs.c     |  20 ++++
 include/linux/intel-iommu.h |   4 +
 include/linux/pci.h         |  11 +++
 5 files changed, 201 insertions(+), 17 deletions(-)

-- 
2.23.0




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Ralf Herbrich
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
