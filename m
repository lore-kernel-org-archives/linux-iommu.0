Return-Path: <SRS0=zE+z=V2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3881EC7618B
	for <iommu@archiver.kernel.org>; Mon, 29 Jul 2019 18:29:39 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 094BD2073F
	for <iommu@archiver.kernel.org>; Mon, 29 Jul 2019 18:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DF5eQiR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 094BD2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C5E561D03;
	Mon, 29 Jul 2019 18:29:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B567818FE
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Jul 2019 15:13:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
	[209.85.215.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 76F872C6
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Jul 2019 15:13:44 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id t132so28409532pgb.9
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Jul 2019 08:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=CReZX3ZIW9UVm3F381oja+qdURlLghUskZk6mGhexL4=;
	b=DF5eQiR/9iQxp/I05TpQxh96+yZz7SV9RG6uhl8zm5tQDkywRpo7tBrHo6+JYi9DMP
	aIHtjuXNygQy++dokdfX3GdSr9dlSz9bgGKf6DU4b9xcRtUDPafirv5OFFt7xntBUlZn
	j9XvmuoU2MOmMqnoKS+Lf5IRijAZXLO3YL5YivUqg9npFcmjI7ffrnyM4bxclXLs+p3V
	89IiySx2lv/p3CIxLGE/Lan/Kj6cJbPLYkh7Npa85VJ89wVuDve2mibdyFGFJyGUsvSq
	UdQYN969Ua7dgZYoTV74bAdwxPJ56h4tOpoaX8SKamq34W+W1tIrFUBiMsFps7A/3pBX
	3Y5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=CReZX3ZIW9UVm3F381oja+qdURlLghUskZk6mGhexL4=;
	b=QiP6MZhFlDRcx2yhR9kU5mqF8eRHZERDQuKgenN+EfoljdWuZ+gsNVrtrwJeUfjKeZ
	FDbQCicIQqCCAXoBR8j0osfNM/jnDHF2IzWUmGAt8Ir+j/1Qoccn+yEpS8jOjcbms8th
	Exnkozqd770du/eIamOyYhxZ6OCmqPXkhiFSBqip2pxQVFksOGQ79+UicldGLceHlk5v
	XlR3VTnbh038piNjBS6jbr/jSuTITMYBZH5aOTInCuhTK/aZdODGByzxFaua8ZcigKll
	S4HBoAp0aRWHa/X0m76OjG6rus8qN5WpJFhyguqfgdKglrdxe15xuVvZSzvSkr4b6p1w
	sQKg==
X-Gm-Message-State: APjAAAWno0QaFUtv3Kz2yAXU0kdIiiFgNAOQ5964cK/7jmyAISKvU2Jr
	d52k+PI+lsKIfGrxUTXHwzw=
X-Google-Smtp-Source: APXvYqxycRdMpLgXrpeUG1h0C8XXmc1sTfWKOqLpMdVBbrO+ryHMITBy2w3gpaZ3FHBwmuORXJgyLw==
X-Received: by 2002:a63:6056:: with SMTP id
	u83mr100397059pgb.181.1564413223953; 
	Mon, 29 Jul 2019 08:13:43 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
	by smtp.gmail.com with ESMTPSA id
	v184sm57845951pgd.34.2019.07.29.08.13.37
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 29 Jul 2019 08:13:43 -0700 (PDT)
From: Chuhong Yuan <hslester96@gmail.com>
To: 
Subject: [PATCH 00/12] Replace strncmp with str_has_prefix
Date: Mon, 29 Jul 2019 23:13:23 +0800
Message-Id: <20190729151323.9226-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 29 Jul 2019 18:26:30 +0000
Cc: Petr Mladek <pmladek@suse.com>, Peter Zijlstra <peterz@infradead.org>,
	kgdb-bugreport@lists.sourceforge.net,
	Pavel Machek <pavel@ucw.cz>, Christoph Hellwig <hch@lst.de>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Ingo Molnar <mingo@redhat.com>, Jason Wessel <jason.wessel@windriver.com>,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>, Chuhong Yuan <hslester96@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, cgroups@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	iommu@lists.linux-foundation.org, Li Zefan <lizefan@huawei.com>,
	Jessica Yu <jeyu@kernel.org>, Tejun Heo <tj@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
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

The commit 72921427d46b
("string.h: Add str_has_prefix() helper function")
introduced str_has_prefix() to substitute error-prone
strncmp(str, const, len).

The commit b6b2735514bc
("tracing: Use str_has_prefix() instead of using fixed sizes")
has fixed some codes.

These patches use str_has_prefix to replace
such pattern of strncmp usages.

Chuhong Yuan (12):
  rdmacg: Replace strncmp with str_has_prefix
  kdb: Replace strncmp with str_has_prefix
  dma-debug: Replace strncmp with str_has_prefix
  gcov: Replace strncmp with str_has_prefix
  genirq/debugfs: Replace strncmp with str_has_prefix
  module: Replace strncmp with str_has_prefix
  power: Replace strncmp with str_has_prefix
  printk: Replace strncmp with str_has_prefix
  reboot: Replace strncmp with str_has_prefix
  sched: Replace strncmp with str_has_prefix
  userns: Replace strncmp with str_has_prefix
  watchdog: Replace strncmp with str_has_prefix

 kernel/cgroup/rdma.c        | 2 +-
 kernel/debug/kdb/kdb_main.c | 2 +-
 kernel/dma/debug.c          | 2 +-
 kernel/gcov/fs.c            | 2 +-
 kernel/irq/debugfs.c        | 2 +-
 kernel/module.c             | 2 +-
 kernel/power/hibernate.c    | 8 ++++----
 kernel/power/main.c         | 2 +-
 kernel/printk/braille.c     | 4 ++--
 kernel/printk/printk.c      | 6 +++---
 kernel/reboot.c             | 2 +-
 kernel/sched/debug.c        | 2 +-
 kernel/sched/isolation.c    | 4 ++--
 kernel/user_namespace.c     | 4 ++--
 kernel/watchdog.c           | 8 ++++----
 15 files changed, 26 insertions(+), 26 deletions(-)

-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
