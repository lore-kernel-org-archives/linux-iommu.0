Return-Path: <SRS0=aSVE=B3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75FDC433E3
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 07:50:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E565207FB
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 07:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iO7lGho8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E565207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5F71D20526;
	Mon, 17 Aug 2020 07:50:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xgPgDbkPNHt6; Mon, 17 Aug 2020 07:50:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 26B8B20378;
	Mon, 17 Aug 2020 07:50:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09FC7C07FF;
	Mon, 17 Aug 2020 07:50:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95FAAC0051
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 07:50:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 88D1A2046B
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 07:50:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DWCYAvaTR-rS for <iommu@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 07:50:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 2CCBA20392
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 07:50:20 +0000 (UTC)
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de
 [95.90.213.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CEB9D207DF;
 Mon, 17 Aug 2020 07:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597650620;
 bh=pEmZ0bJwP+2jy7JV6MazNJRUpimkMGqSRi6r/UUBXcE=;
 h=From:To:Cc:Subject:Date:From;
 b=iO7lGho8i1sBtrmzrfWbT3D8qOHg90bwGxSGDCjffji/8hjWZ805E7LsJ41smtHML
 YmMkrWO10hX92w47Sn53e6i9zgs85tWOyl5ZPn8xPMERnXY1CVRZ5O7ormvcXWfKzg
 txOZJrIUz1gnaQIhcenhYVN+YbW+sDs8Ty9Q1ezI=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
 (envelope-from <mchehab@kernel.org>)
 id 1k7ZuL-00Bfbr-OZ; Mon, 17 Aug 2020 09:50:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 00/16] IOMMU driver for Kirin 960/970
Date: Mon, 17 Aug 2020 09:49:59 +0200
Message-Id: <cover.1597650455.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Cc: devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
 Joerg Roedel <jroedel@suse.de>, Manivannan Sadhasivam <mani@kernel.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Chenfeng <puck.chen@hisilicon.com>, linuxarm@huawei.com,
 Wei Xu <xuwei5@hisilicon.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 John Stultz <john.stultz@linaro.org>, mauro.chehab@huawei.com,
 Suzhuangluan <suzhuangluan@hisilicon.com>,
 linux-arm-kernel@lists.infradead.org
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

Add a driver for the Kirin 960/970 iommu.

As on the past series, this starts from the original 4.9 driver from
the 96boards tree:

	https://github.com/96boards-hikey/linux/tree/hikey970-v4.9

The remaining patches add SPDX headers and make it build and run with
the upstream Kernel.

Chenfeng (1):
  iommu: add support for HiSilicon Kirin 960/970 iommu

Mauro Carvalho Chehab (15):
  iommu: hisilicon: remove default iommu_map_sg handler
  iommu: hisilicon: map and unmap ops gained new arguments
  iommu: hisi_smmu_lpae: rebase it to work with upstream
  iommu: hisi_smmu: remove linux/hisi/hisi-iommu.h
  iommu: hisilicon: cleanup its code style
  iommu: hisi_smmu_lpae: get rid of IOMMU_SEC and IOMMU_DEVICE
  iommu: get rid of map/unmap tile functions
  iommu: hisi_smmu_lpae: use the right code to get domain-priv data
  iommu: hisi_smmu_lpae: convert it to probe_device
  iommu: add Hisilicon Kirin970 iommu at the building system
  iommu: hisi_smmu_lpae: cleanup printk macros
  iommu: hisi_smmu_lpae: make OF compatible more standard
  dt: add an spec for the Kirin36x0 SMMU
  dt: hi3670-hikey970.dts: load the SMMU driver on Hikey970
  staging: hikey9xx: add an item about the iommu driver

 .../iommu/hisilicon,kirin36x0-smmu.yaml       |  55 ++
 .../boot/dts/hisilicon/hi3670-hikey970.dts    |   3 +
 drivers/staging/hikey9xx/Kconfig              |   9 +
 drivers/staging/hikey9xx/Makefile             |   1 +
 drivers/staging/hikey9xx/TODO                 |   1 +
 drivers/staging/hikey9xx/hisi_smmu.h          | 196 ++++++
 drivers/staging/hikey9xx/hisi_smmu_lpae.c     | 648 ++++++++++++++++++
 7 files changed, 913 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/hisilicon,kirin36x0-smmu.yaml
 create mode 100644 drivers/staging/hikey9xx/hisi_smmu.h
 create mode 100644 drivers/staging/hikey9xx/hisi_smmu_lpae.c

-- 
2.26.2


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
