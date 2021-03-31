Return-Path: <SRS0=WBHG=I5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51624C433C1
	for <iommu@archiver.kernel.org>; Wed, 31 Mar 2021 10:04:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF4E761969
	for <iommu@archiver.kernel.org>; Wed, 31 Mar 2021 10:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4E761969
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 94D784023D;
	Wed, 31 Mar 2021 10:04:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cW2h3SS6ZuFT; Wed, 31 Mar 2021 10:04:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 85E5840141;
	Wed, 31 Mar 2021 10:04:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4EAD4C000C;
	Wed, 31 Mar 2021 10:04:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A785DC000A
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 10:04:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 80C1240230
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 10:04:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3NizpxqrJ3UL for <iommu@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 10:04:52 +0000 (UTC)
X-Greylist: delayed 00:05:01 by SQLgrey-1.8.0
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:13])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A77DF40141
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 10:04:51 +0000 (UTC)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:ada2:b4da:6568:5ad5])
 by baptiste.telenet-ops.be with bizsmtp
 id mxzd240015W9KJv01xzdKe; Wed, 31 Mar 2021 11:59:48 +0200
Received: from rox.of.borg ([192.168.97.57])
 by ramsan.of.borg with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1lRXdQ-00BseR-73; Wed, 31 Mar 2021 11:59:36 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1lRXBt-001bpo-DX; Wed, 31 Mar 2021 11:31:09 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 Petr Mladek <pmladek@suse.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH 3/3] lib/vsprintf: Use pr_crit() instead of long fancy messages
Date: Wed, 31 Mar 2021 11:31:04 +0200
Message-Id: <20210331093104.383705-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210331093104.383705-1-geert+renesas@glider.be>
References: <20210331093104.383705-1-geert+renesas@glider.be>
MIME-Version: 1.0
Cc: Marco Elver <elver@google.com>, linux-embedded@vger.kernel.org,
 John Ogness <john.ogness@linutronix.de>, Gary R Hook <gary.hook@amd.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>
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

While long fancy messages have a higher probability of being seen than
small messages, they may scroll of the screen fast, if visible at all,
and may still be missed.  In addition, they increase boot time and
kernel size.

The correct mechanism to increase importance of a kernel message is not
to draw fancy boxes with more text, but to shout louder, i.e. increase
the message's reporting level.  Making sure the administrator of the
system is aware of such a message is a system policy, and is the
responsability of a user-space log daemon.

Fix this by increasing the reporting level from KERN_WARNING to
KERN_CRIT, and removing irrelevant text and graphics.

This reduces kernel size by ca. 0.5 KiB.

Fixes: 5ead723a20e0447b ("lib/vsprintf: no_hash_pointers prints all addresses as unhashed")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 lib/vsprintf.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 9b423359bb6433d3..0293f1b89064b287 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2193,20 +2193,9 @@ static int __init no_hash_pointers_enable(char *str)
 
 	no_hash_pointers = true;
 
-	pr_warn("**********************************************************\n");
-	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
-	pr_warn("**                                                      **\n");
-	pr_warn("** This system shows unhashed kernel memory addresses   **\n");
-	pr_warn("** via the console, logs, and other interfaces. This    **\n");
-	pr_warn("** might reduce the security of your system.            **\n");
-	pr_warn("**                                                      **\n");
-	pr_warn("** If you see this message and you are not debugging    **\n");
-	pr_warn("** the kernel, report this immediately to your system   **\n");
-	pr_warn("** administrator!                                       **\n");
-	pr_warn("**                                                      **\n");
-	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
-	pr_warn("**********************************************************\n");
-
+	pr_crit("This system shows unhashed kernel memory addresses\n");
+	pr_crit("via the console, logs, and other interfaces. This\n");
+	pr_crit("might reduce the security of your system.\n");
 	return 0;
 }
 early_param("no_hash_pointers", no_hash_pointers_enable);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
