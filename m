Return-Path: <SRS0=QAIZ=3T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A655C2D0DB
	for <iommu@archiver.kernel.org>; Thu, 30 Jan 2020 20:12:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02DF320CC7
	for <iommu@archiver.kernel.org>; Thu, 30 Jan 2020 20:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="TTBz3D2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DF320CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D26B0227DB;
	Thu, 30 Jan 2020 20:12:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wxI5f92Ijb1j; Thu, 30 Jan 2020 20:11:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CC353203B4;
	Thu, 30 Jan 2020 20:11:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B21D8C1796;
	Thu, 30 Jan 2020 20:11:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5285FC0171
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jan 2020 20:11:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 38D648448F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jan 2020 20:11:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vJIf8AqH_wZb for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jan 2020 20:11:57 +0000 (UTC)
X-Greylist: delayed 00:33:36 by SQLgrey-1.7.6
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com
 [209.85.214.201])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 96ECB835C4
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jan 2020 20:11:57 +0000 (UTC)
Received: by mail-pl1-f201.google.com with SMTP id v24so2375377plo.2
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jan 2020 12:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=8yPZBT02dhU6sVfnDKBlA+jOWpq/2cl2umK0tzNJVBE=;
 b=TTBz3D2SGElhO3Fat076p/PKpoM+esnw2RoZZW7IqnERaNC+LsOCoxl31VSMOECq/7
 NUO5iU/QQFsDkrtOpYjFklMq84NOoKkZwkX53/sV00n9evs5wUOQTCulXCSDe5d0eGRT
 OUIhteEFVGvAUjQlQ6EtFR9LXbt11CV99hkGAufgoUB2OGl2dIU+B6D+p5UNqbdbNqEY
 6bhDCbQd9D/408RXf1hYN2xzKvx0RIkSSW85qYG3SQmN7NwhQZDkRTFQU24NQTjCXIl4
 igUwW6YLZ2zUdfPTDK/uLP4U5aUWukO83hKoGZECLTeMk6pDzuM6h5F2xwv9CumTO/Xf
 Lj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=8yPZBT02dhU6sVfnDKBlA+jOWpq/2cl2umK0tzNJVBE=;
 b=DMU1plg8iFi5wyzc2f5mjgw6aQljcnpv8XfjfnSCA+2pg4YCkFxkRYNA+iVOcbKPl1
 bDaOm9qQBXKYWLgsrCqNCFt2F4YufsC18QwV9OnV2lXDBefGgadbv7/YZdZ/EfH5SIcE
 KWyMRRsq8wXywX2MYHicSqRtUpIOVhjvJvTy/exOki8nqR0AFDXviuoLUbJ10PrtizVj
 1vVyXMxxxJdVnS3Y3qeDVh+P60ZRJ4CzUKwBCmkp2/5mnxbhC6FiEjjXo8vXdEEgZKT9
 rjfMCIpE8eOM/f/0WeTq/GToYGKe7MOue+OWt3wdZUeYI3/I4edgQcFEUYGOPGvqqUya
 3Gww==
X-Gm-Message-State: APjAAAUs429IuSeZpjvoIyIUPi7nKTaG2nbWx9N2RxC0Mo8bm6H6XyOU
 Mj2ctcP85k2nFjIyX+U+kbc7lnNo5Tevgw==
X-Google-Smtp-Source: APXvYqwShCG6mlMAlaWy7deIQZEwnVXA0kx4PMo46X5AynA4dIPnFzFn6FXwUhqm5k8wHgwEal0unptfi6FFow==
X-Received: by 2002:a63:f5c:: with SMTP id 28mr6397451pgp.348.1580411453063;
 Thu, 30 Jan 2020 11:10:53 -0800 (PST)
Date: Thu, 30 Jan 2020 11:10:49 -0800
Message-Id: <20200130191049.190569-1-edumazet@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] dma-debug: dynamic allocation of hash table
To: Christoph Hellwig <hch@lst.de>, Joerg Roedel <jroedel@suse.de>
Cc: iommu@lists.linux-foundation.org, Eric Dumazet <eric.dumazet@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>
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
From: Eric Dumazet via iommu <iommu@lists.linux-foundation.org>
Reply-To: Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Increasing the size of dma_entry_hash size by 327680 bytes
has reached some bootloaders limitations.

Simply use dynamic allocations instead, and take
this opportunity to increase the hash table to 65536
buckets. Finally my 40Gbit mlx4 NIC can sustain
line rate with CONFIG_DMA_API_DEBUG=y.

Fixes: 5e76f564572b ("dma-debug: increase HASH_SIZE")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/debug.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 2031ed1ad7fa109bb8a8c290bbbc5f825362baba..a310dbb1515e92c081f8f3f9a7290dd5e53fc889 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -27,7 +27,7 @@
 
 #include <asm/sections.h>
 
-#define HASH_SIZE       16384ULL
+#define HASH_SIZE       65536ULL
 #define HASH_FN_SHIFT   13
 #define HASH_FN_MASK    (HASH_SIZE - 1)
 
@@ -90,7 +90,8 @@ struct hash_bucket {
 };
 
 /* Hash list to save the allocated dma addresses */
-static struct hash_bucket dma_entry_hash[HASH_SIZE];
+static struct hash_bucket *dma_entry_hash __read_mostly;
+
 /* List of pre-allocated dma_debug_entry's */
 static LIST_HEAD(free_entries);
 /* Lock for the list above */
@@ -934,6 +935,10 @@ static int dma_debug_init(void)
 	if (global_disable)
 		return 0;
 
+	dma_entry_hash = vmalloc(HASH_SIZE * sizeof(*dma_entry_hash));
+	if (!dma_entry_hash)
+		goto err;
+
 	for (i = 0; i < HASH_SIZE; ++i) {
 		INIT_LIST_HEAD(&dma_entry_hash[i].list);
 		spin_lock_init(&dma_entry_hash[i].lock);
@@ -950,6 +955,7 @@ static int dma_debug_init(void)
 		pr_warn("%d debug entries requested but only %d allocated\n",
 			nr_prealloc_entries, nr_total_entries);
 	} else {
+err:
 		pr_err("debugging out of memory error - disabled\n");
 		global_disable = true;
 
-- 
2.25.0.341.g760bfbb309-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
