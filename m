Return-Path: <SRS0=4E9V=2A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CC0C43603
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 19:58:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A155207FF
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 19:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A155207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3D6AE86BD0;
	Tue, 10 Dec 2019 19:58:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4kHfDcvb6_km; Tue, 10 Dec 2019 19:58:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A453E86BE1;
	Tue, 10 Dec 2019 19:58:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A03B5C1797;
	Tue, 10 Dec 2019 19:58:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1179BC0881
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 19:58:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F273486BF9
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 19:58:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hWkzUFYF7Csz for <iommu@lists.linux-foundation.org>;
 Tue, 10 Dec 2019 19:58:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1419584EB9
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 19:58:14 +0000 (UTC)
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M3lHZ-1idwhK3twp-000urC; Tue, 10 Dec 2019 20:58:06 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH] iommu: fix min_not_zero() type mismatch warning
Date: Tue, 10 Dec 2019 20:57:56 +0100
Message-Id: <20191210195803.866126-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:V0PTrzRDmYv2osv56dZM7Vo+oE2UI7e/kklN8s5/0zdjDkWO6PK
 Syr2cpC870aQUfBxI/LQKX9UnQ52eZYLqOSd2qvQkBpN//NCWo0iM81Nxw+2YBrXdGcQ4RB
 pg0vsdCSmVp9qll1ByW2hslofn4NGZNapb5tmHEmAu28G2OCyKJQ2/VNjecSBSVvQ+huvVa
 bOG58DgSx5dcelzI2jpqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NXJLDdAXMEU=:NSSpjT2T1r5c0ziBNCNW/r
 5vnGk8xhvaVmVr+eAbSykEY0l8MXV0Wx2rALNBcOoWZLDtTbils0slf3We/yHQ0rs7OGAsgYf
 5BlmvFI+7ar5wj3br9ulKnVBH1vDniBmMjOmeTjw5BF/n83OaZw/FTW/VPkUBnGpCiYQwa1Bm
 TtbQRFXz1pB9U8xQASCg9cMF+tXDUpiL+wvTbvcLYmhg8FbgQbTcAmTx8R19l3DW4foPflf2J
 7m+PywNID43s/9dvT18yzrYBJImDKwLg7zWCAgC0/dIgW7X2Xfl8TwuMZZti4aROTSOj5TbzL
 V//i43puiGW4XEntyk/qJzHB62ulXThNiQeIYgzwOJWK+0INVtjJoa7GYtf6I1Tt4cmA8Fc9z
 xf17zZt2tyfoPl6Sl/YzBTxoUMIOlnNwjYOSHmv/s8bmFg1glL7zuRxFtSdkwDuTzHKKLxk4P
 OVnL+x7WQUXg48TuZhF4KXwo2uD7dLYZf/gZZdq8KfjhgIt+T8NrPi3mydPt2+kHY2D/zqAu8
 QN4FGFLqeKLlce1sU0SrUWhrhOPeBH06pkZR8YBLrnvBdR9exwt/T2okQ2SmxBG0/KZiAEwdt
 ODgDVfocrwulKZkzpuWKllnc7mpI8nJFeejNINauyVZVxqwjbSfLEqXxpTCOIlAgDEG91gpA5
 pXgdP8WGTsOK2C4wPIF4wgFDaXpmPX3JdJ/IPRv9sJ2Wtysigw43HPuRfwR7vf6LFykoeABW7
 HqP1mV1W5NEmJ08yjYYay3e8yVEpVCGDEx/Ra6f9NTK4FiRNRaOxRupAJsPwWjHncFdRIrG/r
 ZEH8CT6uQv3PclquS/i8WgYVHUM/WAVkYqVNjSsA+aV3RNVBXjAhyVc9C3JQskKFCHOpdvtef
 m75EGNB98XOtH3nYdf4Q==
Cc: Julien Grall <julien.grall@arm.com>, iommu@lists.linux-foundation.org,
 Tom Murphy <murphyt7@tcd.ie>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org
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

min()/max() require the arguments to be of the same type.

When dma_addr_t is not compatible with __u64, this causes
a warning:

In file included from include/linux/list.h:9,
                 from include/linux/kobject.h:19,
                 from include/linux/of.h:17,
                 from include/linux/irqdomain.h:35,
                 from include/linux/acpi.h:13,
                 from include/linux/acpi_iort.h:10,
                 from drivers/iommu/dma-iommu.c:11:
drivers/iommu/dma-iommu.c: In function 'iommu_dma_alloc_iova':
include/linux/kernel.h:844:29: error: comparison of distinct pointer types lacks a cast [-Werror]
   (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                             ^~
include/linux/kernel.h:858:4: note: in expansion of macro '__typecheck'
   (__typecheck(x, y) && __no_side_effects(x, y))
    ^~~~~~~~~~~
include/linux/kernel.h:868:24: note: in expansion of macro '__safe_cmp'
  __builtin_choose_expr(__safe_cmp(x, y), \
                        ^~~~~~~~~~
include/linux/kernel.h:877:19: note: in expansion of macro '__careful_cmp'
 #define min(x, y) __careful_cmp(x, y, <)
                   ^~~~~~~~~~~~~
include/linux/kernel.h:910:39: note: in expansion of macro 'min'
  __x == 0 ? __y : ((__y == 0) ? __x : min(__x, __y)); })
                                       ^~~
drivers/iommu/dma-iommu.c:424:14: note: in expansion of macro 'min_not_zero'
  dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
              ^~~~~~~~~~~~

Add an explicit cast to work around it, as there is no min_not_zero_t()
equivalent of min_t().

Fixes: a7ba70f1787f ("dma-mapping: treat dev->bus_dma_mask as a DMA limit")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/dma-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 0cc702a70a96..6fa32231dc9f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -421,7 +421,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
 		iova_len = roundup_pow_of_two(iova_len);
 
-	dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
+	dma_limit = min_not_zero((u64)dma_limit, dev->bus_dma_limit);
 
 	if (domain->geometry.force_aperture)
 		dma_limit = min(dma_limit, domain->geometry.aperture_end);
-- 
2.20.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
