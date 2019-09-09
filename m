Return-Path: <SRS0=3FO/=XE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B00DC4740A
	for <iommu@archiver.kernel.org>; Mon,  9 Sep 2019 20:46:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 156A62086D
	for <iommu@archiver.kernel.org>; Mon,  9 Sep 2019 20:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156A62086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 370E1CB7;
	Mon,  9 Sep 2019 20:46:16 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8B22EB7D
	for <iommu@lists.linux-foundation.org>;
	Mon,  9 Sep 2019 20:27:04 +0000 (UTC)
X-Greylist: delayed 00:07:36 by SQLgrey-1.7.6
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr
	[80.12.242.128])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id BB1A0EC
	for <iommu@lists.linux-foundation.org>;
	Mon,  9 Sep 2019 20:27:03 +0000 (UTC)
Received: from localhost.localdomain ([90.126.97.183]) by mwinf5d12 with ME
	id zYKM2000H3xPcdm03YKMxP; Mon, 09 Sep 2019 22:19:24 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 09 Sep 2019 22:19:24 +0200
X-ME-IP: 90.126.97.183
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org
Subject: [PATCH] iommu/io-pgtable: Move some initialization data to
	.init.rodata
Date: Mon,  9 Sep 2019 22:19:19 +0200
Message-Id: <20190909201919.5841-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 09 Sep 2019 20:46:14 +0000
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	iommu@lists.linux-foundation.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
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

The memory used by '__init' functions can be freed once the initialization
phase has been performed.

Mark some 'static const' array defined and used within some '__init'
functions as '__initconst', so that the corresponding data can also be
discarded.

Without '__initconst', the data are put in the .rodata section.
With the qualifier, they are put in the .init.rodata section.

With gcc 8.3.0, the following changes have been measured:

Without '__initconst':
   section      size
  .rodata       00000720
  .init.rodata  00000018

With '__initconst':
   section      size
  .rodata       00000660
  .init.rodata  00000058

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Adding __initconst "within" a function is not in line with kernel/include/init.h
which states that:
 * Don't forget to initialize data not at file scope, i.e. within a function,
 * as gcc otherwise puts the data into the bss section and not into the init
 * section.
However, having the array within the function or out-side the function
seems to have no impact in the generated code and in the section used.
According to my test, both put the data in .init.rodata.

Maybe the comment is outdated or related to some older vesion of gcc.
---
 drivers/iommu/io-pgtable-arm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 161a7d56264d..24076f0560c6 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -1109,7 +1109,7 @@ static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
 
 static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 {
-	static const enum io_pgtable_fmt fmts[] = {
+	static const enum io_pgtable_fmt fmts[] __initconst = {
 		ARM_64_LPAE_S1,
 		ARM_64_LPAE_S2,
 	};
@@ -1208,13 +1208,13 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 
 static int __init arm_lpae_do_selftests(void)
 {
-	static const unsigned long pgsize[] = {
+	static const unsigned long pgsize[] __initconst = {
 		SZ_4K | SZ_2M | SZ_1G,
 		SZ_16K | SZ_32M,
 		SZ_64K | SZ_512M,
 	};
 
-	static const unsigned int ias[] = {
+	static const unsigned int ias[] __initconst = {
 		32, 36, 40, 42, 44, 48,
 	};
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
