Return-Path: <SRS0=1g3H=7S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF76C433E0
	for <iommu@archiver.kernel.org>; Fri,  5 Jun 2020 18:00:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DFFA2074B
	for <iommu@archiver.kernel.org>; Fri,  5 Jun 2020 18:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="SG9gsyt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DFFA2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D76EE24C39;
	Fri,  5 Jun 2020 18:00:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zYxcmhM9lkyS; Fri,  5 Jun 2020 18:00:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 70A2020411;
	Fri,  5 Jun 2020 18:00:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 526C1C0888;
	Fri,  5 Jun 2020 18:00:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A9D7C016E
 for <iommu@lists.linux-foundation.org>; Fri,  5 Jun 2020 14:57:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4095D8848A
 for <iommu@lists.linux-foundation.org>; Fri,  5 Jun 2020 14:57:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CioOY6z+op5d for <iommu@lists.linux-foundation.org>;
 Fri,  5 Jun 2020 14:57:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com
 [207.171.184.29])
 by whitealder.osuosl.org (Postfix) with ESMTPS id ABD8C87D60
 for <iommu@lists.linux-foundation.org>; Fri,  5 Jun 2020 14:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1591369028; x=1622905028;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=SS5aFtrhpqN+38XgjGMl5QYpWNqbfKbcQoWOKyK53g8=;
 b=SG9gsyt/OaYhU/kquVLMn548+ZBUFxaqz75tJ95uAwYPVvbLmh5DRjkX
 N8ePOVC6Io6DlasQPm1DJlytBu5gLx9ySIVY7qvMfjX3ZD3B7IoU8nwB+
 YIc0+rvkLAirre7gxRyJWkgaoZMapmApqhKoZPSpTIJnxE4s0S68d1cX8 I=;
IronPort-SDR: +j93OMhb+P1BlRArVsSsNN9ZOtGt6i9dx9uLOemODOvYNNZU1lDhWN7U+K7hLNtRL8mwgqLFHc
 8+w4LwS8XzHQ==
X-IronPort-AV: E=Sophos;i="5.73,476,1583193600"; d="scan'208";a="50101884"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-1d-98acfc19.us-east-1.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP;
 05 Jun 2020 14:57:04 +0000
Received: from EX13MTAUWC001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
 by email-inbound-relay-1d-98acfc19.us-east-1.amazon.com (Postfix) with ESMTPS
 id E5459A18D0; Fri,  5 Jun 2020 14:57:02 +0000 (UTC)
Received: from EX13D29UWC004.ant.amazon.com (10.43.162.25) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 5 Jun 2020 14:57:02 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D29UWC004.ant.amazon.com (10.43.162.25) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 5 Jun 2020 14:57:01 +0000
Received: from uc7682112f22859.ant.amazon.com (10.1.213.30) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 5 Jun 2020 14:57:00 +0000
To: Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH 0/3] iommu/amd: I/O VA address limits
Date: Fri, 5 Jun 2020 16:56:52 +0200
Message-ID: <20200605145655.13639-1-sebott@amazon.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 05 Jun 2020 18:00:35 +0000
Cc: Benjamin Serebrin <serebrin@amazon.com>, Filippo Sironi <sironi@amazon.de>,
 Sebastian Ott <sebott@amazon.de>
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
From: Sebastian Ott via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sebastian Ott <sebott@amazon.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The IVRS ACPI table specifies maximum address sizes for I/O virtual
addresses that can be handled by the IOMMUs in the system. Parse that
data from the IVRS header to provide aperture information for DMA
mappings and users of the iommu API.

Sebastian Ott (3):
  iommu/amd: Parse supported address sizes from IVRS
  iommu/amd: Restrict aperture for domains to conform with IVRS
  iommu/amd: Actually enforce geometry aperture

 drivers/iommu/amd_iommu.c       | 16 +++++++++++-----
 drivers/iommu/amd_iommu_init.c  | 26 ++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_types.h |  3 +++
 3 files changed, 40 insertions(+), 5 deletions(-)

-- 
2.17.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
