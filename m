Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38580C433F5
	for <iommu@archiver.kernel.org>; Wed, 25 May 2022 03:05:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D50D3612B9;
	Wed, 25 May 2022 03:05:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Be-88-ugybyE; Wed, 25 May 2022 03:05:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A30956059A;
	Wed, 25 May 2022 03:05:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 198C7C007F;
	Wed, 25 May 2022 03:05:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C3FAC002D
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 02:09:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 57038612AC
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 02:09:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DKklT8bv50So for <iommu@lists.linux-foundation.org>;
 Wed, 25 May 2022 02:09:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1515.securemx.jp
 [210.130.202.171])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6EFE660E4A
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 02:09:54 +0000 (UTC)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1515) id 24P1Web4013852;
 Wed, 25 May 2022 10:32:40 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 24P1WIja007424;
 Wed, 25 May 2022 10:32:18 +0900
X-Iguazu-Qid: 34trLtFNCcr2hTNsYq
X-Iguazu-QSIG: v=2; s=0; t=1653442338; q=34trLtFNCcr2hTNsYq;
 m=6I5Zp9SHxPfpIAHDdJthesAiltPbzyvTI/Q27BPBxWM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
 by relay.securemx.jp (mx-mr1512) id 24P1WHkF020508
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 25 May 2022 10:32:17 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 0/3] Add Visconti5 IOMMU driver
Date: Wed, 25 May 2022 10:31:44 +0900
X-TSB-HOP2: ON
Message-Id: <20220525013147.2215355-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 25 May 2022 03:05:51 +0000
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org
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

Hi,

This series is the IOMMU driver for Toshiba's ARM SoC, Visconti5[0].
This provides DT binding documentation, device driver and MAINTAINER files.

Best regards,
  Nobuhiro

[0]: https://toshiba.semicon-storage.com/ap-en/semiconductor/product/image-recognition-processors-visconti.html

Nobuhiro Iwamatsu (3):
  iommu: Add Visconti5 IOMMU driver
  iommu: bindings: Add binding documentation for Toshiba Visconti5 IOMMU
    device
  MAINTAINERS: Add entries for Toshiba Visconti5 IOMMU

 .../bindings/iommu/toshiba,visconti-atu.yaml  |  62 +++
 MAINTAINERS                                   |   2 +
 drivers/iommu/Kconfig                         |   7 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/visconti-atu.c                  | 426 ++++++++++++++++++
 5 files changed, 498 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/toshiba,visconti-atu.yaml
 create mode 100644 drivers/iommu/visconti-atu.c

-- 
2.36.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
