Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FB614BD55
	for <iommu@lists.linux.dev>; Wed,  6 Mar 2024 18:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749532; cv=none; b=iPEZ4b7cCz75Kued4Mf+IXR7wlp0Kwr/df6xLEl5zz83mQN6SaeT6WnBxAOl443QWivVLWMHS/loWQt2uuNDVuImFKUU8CRt+FciFVRbhg1W9kRDxp0lSQPYKV/MlrmGNWCnQHr+EmKwYe7UHP8MigyNAtnvUBNQAJIVmKWpkbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749532; c=relaxed/simple;
	bh=hIMAOlcJzFPaDudolR/SgVF/OtepzRNxoHk4FDHPmto=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NFxqQZd5yKecqvJjfZWpc5kzMvhiO9ly7gpMQLN41DYXSHx3HCAXSep+fpHodVG4TQTNll+JU5n6sMXYUBemEqL/+U9jW++tJTjIOymKDvSdjMgial1IXPH6Cz2sPe5BxzfN+xmCxFU0jXOtG7kejJkIGB5E4ytyOryqRMkAi3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U3/m6hCX; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U3/m6hCX"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60971264c48so592007b3.0
        for <iommu@lists.linux.dev>; Wed, 06 Mar 2024 10:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749530; x=1710354330; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r962bvR5LCwoMgFXL0pngYYUaEUVgmlMd//tXW54EfM=;
        b=U3/m6hCXHV6mOL7HBmPKxR37018gMJ17m4MryOE3/EA1B3TCMQKMdYWY6MqPrDV9rS
         FcJHmrlfIMrFcvtefqvl23whhUQQYf/ery90igioYuj26gcG0ru2j06cpqo4LSgiBrVM
         76sx4dpEM/V55QScnKkyH6+sr4l7j8WxC7WGlgnBvFkMRuOcOGRj4Tossj9BlkCimpgU
         doSTOE34JgIehtQ/2wZwZMJciSxpEHPOGgJYhaWmQRdWBEJWSV1ViWJ7Sl3EejuprYQP
         EGYLLDxok6GjVFPvu+Vzztz7gxvuaHVqxlv+QZYmJg+zAPKEDClH0STvnCDeHExQ9gtU
         lBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749530; x=1710354330;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r962bvR5LCwoMgFXL0pngYYUaEUVgmlMd//tXW54EfM=;
        b=NRVmxAzsg1aTh5BljyjpcKKCgheLL0g7sxIOdIryYLj9b9nmDEgK4aCbIRqULvNEyc
         D/u37d1e0wbHPEg1gsscdOHQBj1gnUphcly6GJvCQHcM3PqkVe+pDlsArq76BuXM9nM5
         7DN6M+WmCxIs6/ronKa0uJibDwNXZf8CZUsJB+rjqBlb7NpJc2EFpmobsguhGzj8avyy
         6Dx45MxU9UsmDWgcIiMYxBPeORqdt2r6hsGIXrlSiYh3er0pCioZDZBQptMBb9HwYCIr
         JehITWDV0WiVfvlGSgXRtHkajJheiYho4iQQw5TRyeFZeeQRTbeK7OcN3XXS210jyWhS
         BQpg==
X-Forwarded-Encrypted: i=1; AJvYcCU7mIpHOPLN5A5cUGmguQUxsguVrbfQt83M6Pf0+YPIhk3AoU3vzD0/8EtOay1009pPaiVFFbKiBHIm8d76UsaT++PT8YQ=
X-Gm-Message-State: AOJu0Yye2Gfv3B/AiVTM/j7kW+mWOL4s6j6w928rU5U7i8GzdQqpAqy8
	+LcIC8F+YVpo3XlMhvdaW70m/6yPTPHogHsfryrtb5ahPtKIZBYC/MpwGDsg4knC1QCd5rnN6KW
	W5w==
X-Google-Smtp-Source: AGHT+IGe7t6LCx7ntWuuN0pG3BUD23g3ZHCgKcqafT1luEHOL8Lf4ydoGId/CWh1jbpa65530MO9Fdk68K8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a05:690c:82:b0:5e6:1e40:e2e3 with SMTP id
 be2-20020a05690c008200b005e61e40e2e3mr3383691ywb.5.1709749529862; Wed, 06 Mar
 2024 10:25:29 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:19 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-22-surenb@google.com>
Subject: [PATCH v5 21/37] mm/page_ext: enable early_page_ext when CONFIG_MEM_ALLOC_PROFILING_DEBUG=y
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For all page allocations to be tagged, page_ext has to be initialized
before the first page allocation. Early tasks allocate their stacks
using page allocator before alloc_node_page_ext() initializes page_ext
area, unless early_page_ext is enabled. Therefore these allocations will
generate a warning when CONFIG_MEM_ALLOC_PROFILING_DEBUG is enabled.
Enable early_page_ext whenever CONFIG_MEM_ALLOC_PROFILING_DEBUG=y to
ensure page_ext initialization prior to any page allocation. This will
have all the negative effects associated with early_page_ext, such as
possible longer boot time, therefore we enable it only when debugging
with CONFIG_MEM_ALLOC_PROFILING_DEBUG enabled and not universally for
CONFIG_MEM_ALLOC_PROFILING.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_ext.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/page_ext.c b/mm/page_ext.c
index 3c58fe8a24df..e7d8f1a5589e 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -95,7 +95,16 @@ unsigned long page_ext_size;
 
 static unsigned long total_usage;
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
+/*
+ * To ensure correct allocation tagging for pages, page_ext should be available
+ * before the first page allocation. Otherwise early task stacks will be
+ * allocated before page_ext initialization and missing tags will be flagged.
+ */
+bool early_page_ext __meminitdata = true;
+#else
 bool early_page_ext __meminitdata;
+#endif
 static int __init setup_early_page_ext(char *str)
 {
 	early_page_ext = true;
-- 
2.44.0.278.ge034bb2e1d-goog

