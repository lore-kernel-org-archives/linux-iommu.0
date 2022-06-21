Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01EDC43334
	for <iommu@archiver.kernel.org>; Tue, 21 Jun 2022 07:18:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5BAEC418E1;
	Tue, 21 Jun 2022 07:18:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5BAEC418E1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9QgsP0_An_sB; Tue, 21 Jun 2022 07:18:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CDF31418D9;
	Tue, 21 Jun 2022 07:18:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CDF31418D9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95899C0032;
	Tue, 21 Jun 2022 07:18:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FBEBC002D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 07:18:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 72FBD82D0C
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 07:18:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 72FBD82D0C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zho5uEOggT0G for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 07:18:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8884E8242D
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8884E8242D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 07:18:51 +0000 (UTC)
Received: from coburn.home.jannau.net (p579ad988.dip0.t-ipconnect.de
 [87.154.217.136])
 by soltyk.jannau.net (Postfix) with ESMTPSA id A803826ED15;
 Tue, 21 Jun 2022 09:18:48 +0200 (CEST)
From: Janne Grunau <j@jannau.net>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v3 0/5] iommu: M1 Pro/Max DART support
Date: Tue, 21 Jun 2022 09:18:43 +0200
Message-Id: <20220621071848.14834-1-j@jannau.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
 Hector Martin <marcan@marcan.st>, Konrad Dybcio <konrad.dybcio@somainline.org>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 asahi@lists.linux.dev, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Mark Kettenis <mark.kettenis@xs4all.nl>
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

Hej,

this is the next attempt adding support for the DART found in Apple's
M1 Pro/Max/Ultra. This adds a separate io-pgtable implementation for
DART. As already mentioned in v2 the pte format is not fully compatible
with io-pgtable-arm. Especially the 2nd least significant bit is used
and is not available to tag tables/pages.
io-pgtable-dart.c is copied from io-pgtable-arm.c and support for
unused features is removed. Support for 4k IO pages is left for A7 to
A11 SoCs as there's work underway to run Linux on them.

The incompatibilities between both Apple DART pte seems manageable in
their own io-pgtable implementation. A short list of the known
differences:

 - the physical addresses are shifted left by 4 bits and and have 2 more
   bits inside the PTE entries
 - the read/write protection flags are at a different position
 - the subpage protection feature is now mandatory. For Linux we can
   just configure it to always allow access to the entire page.
 - BIT(1) tags "uncached" mappings (used for the display controller)

There is second type of DART (t8110) present on M1 Pro/Max SoCs which
uses the same PTE format as t6000.

Changes in v3:
- move APPLE_DART to its own io-pgtable implementation, copied from
  io-pgtable-arm and simplified

Changes in v2:
- added Rob's Acked-by:
- add APPLE_DART2 io-pgtable format

Janne Grunau (1):
  iommu/io-pgtable: Move Apple DART support to its own file

Sven Peter (4):
  dt-bindings: iommu: dart: add t6000 compatible
  iommu/io-pgtable: Add DART subpage protection support
  iommu/io-pgtable-dart: Add DART PTE support for t6000
  iommu: dart: Support t6000 variant

 .../devicetree/bindings/iommu/apple,dart.yaml |   4 +-
 MAINTAINERS                                   |   1 +
 drivers/iommu/Kconfig                         |   1 -
 drivers/iommu/Makefile                        |   2 +-
 drivers/iommu/apple-dart.c                    |  24 +-
 drivers/iommu/io-pgtable-arm.c                |  63 --
 drivers/iommu/io-pgtable-dart.c               | 623 ++++++++++++++++++
 drivers/iommu/io-pgtable.c                    |   3 +
 include/linux/io-pgtable.h                    |   1 +
 9 files changed, 653 insertions(+), 69 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-dart.c

-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
