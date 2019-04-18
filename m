Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FCDC282DF
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 09:07:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D4DA2183F
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 09:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4DA2183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 68F9714F6;
	Thu, 18 Apr 2019 09:06:41 +0000 (UTC)
Received: from smtp2.linuxfoundation.org (smtp2.linux-foundation.org
	[172.17.192.36])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0A3A514ED
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 09:06:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [146.0.238.70])
	by smtp2.linuxfoundation.org (Postfix) with ESMTPS id 8275E1DCEE;
	Thu, 18 Apr 2019 09:06:39 +0000 (UTC)
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
	by Galois.linutronix.de with esmtp (Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1hH303-0001rK-1g; Thu, 18 Apr 2019 11:06:31 +0200
Message-Id: <20190418084254.459090858@linutronix.de>
User-Agent: quilt/0.65
Date: Thu, 18 Apr 2019 10:41:34 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 15/29] dm persistent data: Simplify stack trace handling
References: <20190418084119.056416939@linutronix.de>
MIME-Version: 1.0
Cc: Mike Snitzer <snitzer@redhat.com>, David Airlie <airlied@linux.ie>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
	dm-devel@redhat.com, Alexander Potapenko <glider@google.com>,
	Christoph Lameter <cl@linux.com>, Christoph Hellwig <hch@lst.de>,
	Alasdair Kergon <agk@redhat.com>, linux-arch@vger.kernel.org,
	x86@kernel.org, kasan-dev@googlegroups.com,
	David Rientjes <rientjes@google.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alexey Dobriyan <adobriyan@gmail.com>, intel-gfx@lists.freedesktop.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, Josef Bacik <josef@toxicpanda.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	David Sterba <dsterba@suse.com>,
	Dmitry Vyukov <dvyukov@google.com>, Chris Mason <clm@fb.com>,
	Pekka Enberg <penberg@kernel.org>, iommu@lists.linux-foundation.org,
	Daniel Vetter <daniel@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-btrfs@vger.kernel.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190418084134.tX-A7NRaUGMqt03Y1tF9Y3zUyFbGU45Sv5PaEEmUt5Y@z>

Replace the indirection through struct stack_trace with an invocation of
the storage array based interface. This results in less storage space and
indirection.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: dm-devel@redhat.com
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>
---
 drivers/md/persistent-data/dm-block-manager.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

--- a/drivers/md/persistent-data/dm-block-manager.c
+++ b/drivers/md/persistent-data/dm-block-manager.c
@@ -35,7 +35,10 @@
 #define MAX_HOLDERS 4
 #define MAX_STACK 10
 
-typedef unsigned long stack_entries[MAX_STACK];
+struct stack_store {
+	unsigned int	nr_entries;
+	unsigned long	entries[MAX_STACK];
+};
 
 struct block_lock {
 	spinlock_t lock;
@@ -44,8 +47,7 @@ struct block_lock {
 	struct task_struct *holders[MAX_HOLDERS];
 
 #ifdef CONFIG_DM_DEBUG_BLOCK_STACK_TRACING
-	struct stack_trace traces[MAX_HOLDERS];
-	stack_entries entries[MAX_HOLDERS];
+	struct stack_store traces[MAX_HOLDERS];
 #endif
 };
 
@@ -73,7 +75,7 @@ static void __add_holder(struct block_lo
 {
 	unsigned h = __find_holder(lock, NULL);
 #ifdef CONFIG_DM_DEBUG_BLOCK_STACK_TRACING
-	struct stack_trace *t;
+	struct stack_store *t;
 #endif
 
 	get_task_struct(task);
@@ -81,11 +83,7 @@ static void __add_holder(struct block_lo
 
 #ifdef CONFIG_DM_DEBUG_BLOCK_STACK_TRACING
 	t = lock->traces + h;
-	t->nr_entries = 0;
-	t->max_entries = MAX_STACK;
-	t->entries = lock->entries[h];
-	t->skip = 2;
-	save_stack_trace(t);
+	t->nr_entries = stack_trace_save(t->entries, MAX_STACK, 2);
 #endif
 }
 
@@ -106,7 +104,8 @@ static int __check_holder(struct block_l
 			DMERR("recursive lock detected in metadata");
 #ifdef CONFIG_DM_DEBUG_BLOCK_STACK_TRACING
 			DMERR("previously held here:");
-			print_stack_trace(lock->traces + i, 4);
+			stack_trace_print(lock->traces[i].entries,
+					  lock->traces[i].nr_entries, 4);
 
 			DMERR("subsequent acquisition attempted here:");
 			dump_stack();


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
