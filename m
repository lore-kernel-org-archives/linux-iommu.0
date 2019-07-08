Return-Path: <SRS0=EbOf=VF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EDCC606BD
	for <iommu@archiver.kernel.org>; Mon,  8 Jul 2019 18:18:50 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 214D5217D6
	for <iommu@archiver.kernel.org>; Mon,  8 Jul 2019 18:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nzo2HGF3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ad8kI3O0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214D5217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6FE4A2A8C;
	Mon,  8 Jul 2019 18:18:47 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9AAEA23D8
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Jul 2019 18:10:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 458FF882
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Jul 2019 18:10:25 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 12D1460FEB; Mon,  8 Jul 2019 18:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1562609425;
	bh=RYakAtzfd68XjS32CGKsM0PJUck7IxLNDzXB/YezXpk=;
	h=From:To:Cc:Subject:Date:From;
	b=nzo2HGF31VxQFTF3dOkr3lAawdIBm572BTtiysNdUUrDlfsnj7MgSOZSCr2qYJZyu
	WTzxV9tpJKAmoWRFcBRJAMo/6k27R/u4ZCGaByfef0HdwP4bFuJtzIkIOYdQoEvdO0
	YOOzk22d7pEeBHVs3/rQVTY1jDYrPhzSPGSsz9tM=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
	[199.106.103.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: jcrouse@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id D16A0602F0;
	Mon,  8 Jul 2019 18:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1562609424;
	bh=RYakAtzfd68XjS32CGKsM0PJUck7IxLNDzXB/YezXpk=;
	h=From:To:Cc:Subject:Date:From;
	b=Ad8kI3O0+s4YwlFbID8kBOAt4b+HDkQfXy2QX0s0abp4uoLt2JeVkl/JMoUFDReJx
	QcUmPJrxrh2tq5JHtIuKztBpxSxPNlycZqPUsd7JE2ThrlOES8O+KGPYSfOAjdK2/g
	eM6KtmEGxjI1Fjn3YPRMS2eXN4+9Rr+RgTxFDfmk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D16A0602F0
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: freedreno@lists.freedesktop.org
Subject: [PATCH v2 0/3] iommu/arm-smmu: Split pagetable support
Date: Mon,  8 Jul 2019 12:10:15 -0600
Message-Id: <1562609418-25446-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Cc: Rob Herring <robh@kernel.org>, jean-philippe.brucker@arm.com,
	linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	dianders@chromimum.org, hoegsberg@google.com,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

This series implements split pagetable support for arm-smmu-v2 devices. You have
seen this code before as part of [1] but I split it from the other features
to make it easier to review / merge.

This series adds a new format type to io-pgtable-arm to enable TTBR0 and
TTBR1. Because of the way that the registers are mixed up it makes the most
sense to enable them together instead of trying to create two different
pagetables and merge them together later in the arm-smmu drive.

This will be used later by the drm/msm driver to enable split pagetables
as part of the effort to implement per-context pagetables [2].

Thanks,
Jordan

[1] https://patchwork.freedesktop.org/series/57441/
[2] https://patchwork.freedesktop.org/patch/307616/?series=57441&rev=3

Jordan Crouse (3):
  iommu: Add DOMAIN_ATTR_SPLIT_TABLES
  iommu/io-pgtable-arm: Add support for AARCH64 split pagetables
  iommu/arm-smmu: Add support for DOMAIN_ATTR_SPLIT_TABLES

 drivers/iommu/arm-smmu.c       |  16 ++-
 drivers/iommu/io-pgtable-arm.c | 261 +++++++++++++++++++++++++++++++++++++----
 drivers/iommu/io-pgtable.c     |   1 +
 include/linux/io-pgtable.h     |   2 +
 include/linux/iommu.h          |   1 +
 5 files changed, 256 insertions(+), 25 deletions(-)

-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
