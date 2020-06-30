Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A14C433DF
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 22:47:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AE1D2073E
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 22:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="bnaUo6no"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE1D2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E687088748;
	Tue, 30 Jun 2020 22:47:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4IdQu4gH2Ots; Tue, 30 Jun 2020 22:47:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4F44188725;
	Tue, 30 Jun 2020 22:47:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3150EC088F;
	Tue, 30 Jun 2020 22:47:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50718C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 22:47:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 46136886F8
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 22:47:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GP0teNObupXU for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 22:47:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com
 [207.171.190.10])
 by whitealder.osuosl.org (Postfix) with ESMTPS id ACAB2886E9
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 22:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1593557225; x=1625093225;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=0Do7vUmgoy54v+IiKTJI+r7k90ygbB1/pii95TT6L7M=;
 b=bnaUo6noB1S2L56AbF8HBebxgfY5ct3UfOQuP6OgtC3k6xb5P9aBRVfE
 TiP2d0ExEln+vkEFfgGAYoRUnqLhrPKTh7i2Mh0nbGYtowoYKy4Gpznp9
 9r72zw03wVXP5XVtEfSfGGKjCMs3U6ksc7CbSmc+CVw103Yxo1APwtbXT 8=;
IronPort-SDR: YrWocArTXcR+dXxKI8kJuJWP5Bw9SOgjHZZtZwk25S75rhlPrNUSEputA4u6XUZGrHgAlxwdWi
 JrMseJO3DzAQ==
X-IronPort-AV: E=Sophos;i="5.75,298,1589241600"; d="scan'208";a="55152157"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP;
 30 Jun 2020 22:47:05 +0000
Received: from EX13MTAUWA001.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
 by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS
 id C5B0BC07EE; Tue, 30 Jun 2020 22:47:04 +0000 (UTC)
Received: from EX13D29UWA004.ant.amazon.com (10.43.160.33) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 30 Jun 2020 22:47:03 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D29UWA004.ant.amazon.com (10.43.160.33) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 30 Jun 2020 22:47:03 +0000
Received: from uc7682112f22859.ant.amazon.com (10.1.213.20) by
 mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 30 Jun 2020 22:47:01 +0000
To: Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 0/3] iommu/amd: I/O VA address limits
Date: Wed, 1 Jul 2020 00:46:31 +0200
Message-ID: <20200630224634.319-1-sebott@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200630093039.GC28824@8bytes.org>
References: <20200630093039.GC28824@8bytes.org>
MIME-Version: 1.0
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

Changes for V2:
 - use limits in iommu_setup_dma_ops()
 - rebased to current upstream

Sebastian Ott (3):
  iommu/amd: Parse supported address sizes from IVRS
  iommu/amd: Restrict aperture for domains to conform with IVRS
  iommu/amd: Actually enforce geometry aperture

 drivers/iommu/amd/amd_iommu_types.h |  3 +++
 drivers/iommu/amd/init.c            | 26 ++++++++++++++++++++++++++
 drivers/iommu/amd/iommu.c           | 12 ++++++++++--
 3 files changed, 39 insertions(+), 2 deletions(-)

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
