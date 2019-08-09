Return-Path: <SRS0=HAoA=WF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1CAC31E40
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 07:10:13 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 209B3208C4
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 07:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VD+Ar1DI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209B3208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CA43EC4E;
	Fri,  9 Aug 2019 07:10:12 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 78317BE4
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 07:10:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
	[209.85.215.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CB8ED76F
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 07:10:08 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id d1so12579706pgp.4
	for <iommu@lists.linux-foundation.org>;
	Fri, 09 Aug 2019 00:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=HPwG7pkcc5DZ98Mz2Gg0sM/TpTfIkaOBCUuZftqf1/w=;
	b=VD+Ar1DIRNtDCEqE2Yx4SwfjH51ak++dbdeaIqAr4Dwa/udxcfurZPOEeYFRIVL0qL
	ol6/odHAXtRsHeVmgEfNubI3Tckewc6r6ZaiGry0fgOC72HS0pNdgQRabl+xjYJAXS/7
	AXmRHh72D4ZVst+BzEQfkfihNv+Z1J/QKZvpPylay0xtN3VGzhqeRCuTs+bZjoC5VGNl
	ShkKFVAYMe5BOIBXtriMkuNzF3iU5pQo/SFNiJoKZLxmlD2TT4EpWevxvtQTUJ8szD69
	mBBjrAfRenCRvuk/iZHlaS9y/lGDRIgxrJH14vbALQD0jZiTvA7YjUtRy9vdAqZvfV6H
	qjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=HPwG7pkcc5DZ98Mz2Gg0sM/TpTfIkaOBCUuZftqf1/w=;
	b=pYCINJOxF+o9Uo2XQCelNLd7KYzrgcm2VjTrzvtzkC12sb/8KbMornk13RISzz8qWa
	NHWLL8rhgrkTiqolWHKoI40XNw/g73xg1cp6HAncAYiM5tYJbAMN18LFkKEqsHX3Luuy
	zVKZBWjrMORRVrmzscRRACjtwpOlLeZ2BRPm615iAKpcMk9YAonh7isk9MovuPhgrH/l
	Sn7sjNEg5H9cuCoNddvaoWseo6gtDJ2ajP8E4L9oL5iS97pXs64P+dyzDDhG9bvtdB0l
	UviceFae97C32tE0HAFgP70tTu+9peSerJxq/B6owHrlh6/c6WhxZ5D6E1DKEo6bv8S3
	J0OA==
X-Gm-Message-State: APjAAAURJRjLEN/JTIqkKK6V0CihPOkG5CulFx9SHcT6KrpejfKA0BY2
	C5i49LWCjU7JSYWXZyP8fq0=
X-Google-Smtp-Source: APXvYqx8b9QDL7gRE+a7XxAMhAJCg1WcAncDZoI70N/8WLtTRd1kO2iLQoNjxiNy3Te275dWnJSgTA==
X-Received: by 2002:a17:90a:1c17:: with SMTP id
	s23mr8029916pjs.108.1565334608346; 
	Fri, 09 Aug 2019 00:10:08 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
	by smtp.gmail.com with ESMTPSA id e7sm215529pfn.72.2019.08.09.00.10.03
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 09 Aug 2019 00:10:07 -0700 (PDT)
From: Chuhong Yuan <hslester96@gmail.com>
To: 
Subject: [PATCH v4 0/8] Replace strncmp with str_has_prefix
Date: Fri,  9 Aug 2019 15:10:00 +0800
Message-Id: <20190809071000.17059-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Len Brown <len.brown@intel.com>, Petr Mladek <pmladek@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Chuhong Yuan <hslester96@gmail.com>, linux-pm@vger.kernel.org,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
	Pavel Machek <pavel@ucw.cz>, Jessica Yu <jeyu@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

strncmp(str, const, len) is easy to have error in len
because of counting error or sizeof(const) without - 1.

These patches replace such pattern with str_has_prefix()
to avoid hard coded constant length and sizeof.

Besides, str_has_prefix() returns the length of prefix
when the comparison returns true.
We can use this return value to substitute some hard-coding.

Changelog:

v1 -> v2:
  - Revise the description.
  - Use the return value of str_has_prefix() to eliminate
    hard coding.
  - Remove possible false positives and add newly detected
    one in upstream.

v2 -> v3:
  - Revise the description.
  - Remove else uses in printk.c.

v3 -> v4:
  - Eliminate assignments in if conditions.

Chuhong Yuan (8):
  dma: debug: Replace strncmp with str_has_prefix
  module: Replace strncmp with str_has_prefix
  PM/sleep: Replace strncmp with str_has_prefix
  printk: Replace strncmp with str_has_prefix
  reboot: Replace strncmp with str_has_prefix
  sched: Replace strncmp with str_has_prefix
  userns: Replace strncmp with str_has_prefix
  watchdog: Replace strncmp with str_has_prefix

 kernel/dma/debug.c       |  2 +-
 kernel/module.c          |  2 +-
 kernel/power/main.c      |  2 +-
 kernel/printk/braille.c  | 15 +++++++++++----
 kernel/printk/printk.c   | 22 ++++++++++++++++------
 kernel/reboot.c          |  7 +++++--
 kernel/sched/debug.c     |  6 ++++--
 kernel/sched/isolation.c | 11 +++++++----
 kernel/user_namespace.c  | 20 ++++++++++++--------
 kernel/watchdog.c        |  8 ++++----
 10 files changed, 62 insertions(+), 33 deletions(-)

-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
