Return-Path: <SRS0=ZfVm=T6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5657DC28CC0
	for <iommu@archiver.kernel.org>; Thu, 30 May 2019 14:32:28 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33E4B25117
	for <iommu@archiver.kernel.org>; Thu, 30 May 2019 14:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E4B25117
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9B3C03BDC;
	Thu, 30 May 2019 14:32:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5764C3BA4
	for <iommu@lists.linux-foundation.org>;
	Thu, 30 May 2019 14:19:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 386A05F4
	for <iommu@lists.linux-foundation.org>;
	Thu, 30 May 2019 14:19:55 +0000 (UTC)
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 85AE61A064E;
	Thu, 30 May 2019 16:19:53 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
	[134.27.226.22])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 790631A0179;
	Thu, 30 May 2019 16:19:53 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net
	(fsr-ub1864-101.ea.freescale.net [10.171.82.13])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id E3D262026B;
	Thu, 30 May 2019 16:19:52 +0200 (CEST)
From: laurentiu.tudor@nxp.com
To: netdev@vger.kernel.org, madalin.bucur@nxp.com, roy.pledge@nxp.com,
	camelia.groza@nxp.com, leoyang.li@nxp.com
Subject: [PATCH v3 0/6] Prerequisites for NXP LS104xA SMMU enablement
Date: Thu, 30 May 2019 17:19:45 +0300
Message-Id: <20190530141951.6704-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: linux-kernel@vger.kernel.org, Joakim.Tjernlund@infinera.com,
	iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
	davem@davemloft.net, linux-arm-kernel@lists.infradead.org
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

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

This patch series contains several fixes in preparation for SMMU
support on NXP LS1043A and LS1046A chips. Once these get picked up,
I'll submit the actual SMMU enablement patches consisting in the
required device tree changes.

This patch series contains only part of the previously submitted one,
(including also the device tree changes) available here:

 https://patchwork.kernel.org/cover/10634443/

There are a couple of changes/fixes since then:
 - for consistency, renamed mmu node to smmu
 - new patch page aligning the sizes of the qbman reserved memory
 - rebased on 5.1.0-rc2

Depends on this pull request:

 http://lists.infradead.org/pipermail/linux-arm-kernel/2019-May/653554.html

Changes in v3:
 - cache iommu domain in driver's private data
 - rebased on v5.2.0-rc2
 - rework to get rid of #ifdef spaghetti (David)

Changes in v2:
 - dropped patches dealing with mapping reserved memory in iommu
 - changed logic for qman portal probe status (Leo)
 - moved "#ifdef CONFIG_PAMU" in header file (Leo)
 - rebased on v5.1.0-rc5

Laurentiu Tudor (6):
  fsl/fman: don't touch liodn base regs reserved on non-PAMU SoCs
  fsl/fman: add API to get the device behind a fman port
  dpaa_eth: defer probing after qbman
  dpaa_eth: base dma mappings on the fman rx port
  dpaa_eth: fix iova handling for contiguous frames
  dpaa_eth: fix iova handling for sg frames

 .../net/ethernet/freescale/dpaa/dpaa_eth.c    | 131 ++++++++++++------
 .../net/ethernet/freescale/dpaa/dpaa_eth.h    |   2 +
 drivers/net/ethernet/freescale/fman/fman.c    |   6 +-
 .../net/ethernet/freescale/fman/fman_port.c   |  14 ++
 .../net/ethernet/freescale/fman/fman_port.h   |   2 +
 5 files changed, 108 insertions(+), 47 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
