Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669E850271
	for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 21:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773988; cv=none; b=tcsuzPbCLDbqIaAJLiq2crYicB7VWvc0JSACuurI1MB0EwhK2foqYgNQRH8aH6FIZKdEZ8IJqjgHVdd2fJnYPnmn0o7bVfDCARhcm2i/yuil0QuQFmzdYPkRdHQDJ5KsppOlpCrP6POcKzPw/z+z2hZx39xwUOGElCul7c3KfVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773988; c=relaxed/simple;
	bh=INdaAeCu0vMsonNtDmCDKN4gcPdyIDjKBJoc+g+d2cY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qyt2S8on+OKgTRYMhBrfnjjFggE+HEa4/wwiIzJN5qb0TX9jV6TLAswUDTDU8UMqY37sF4ZYmJGyzxHOXZSZvvzWzvVa+oI01Rut4H/d1ucBbeefxzUHruEgWhc7iyNBr+C0PEfGLCTzFU/chur2xHIloEHPA32RuTsJo1jaZ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vtLFDuhX; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vtLFDuhX"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60779e8f67fso4372317b3.0
        for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 13:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707773985; x=1708378785; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NFEoAydGNCIakLM+oYHcpcvSKcGKjy30qzf4+mOY1ag=;
        b=vtLFDuhXj+a1l5T/rsOpwQ5WXmTsptkh/XbbmI/US5ufUFa8BzdrchkMyHrG4fvoAV
         FvMMbIy8Hx4hpJs3wg93RxgMkSRYPAF4Yenwu59sdCrCdpYR1T1l6gISD0kViRvsJUnk
         /SRDy58pSQeGgwCWx9nVPvvCd7exUWc8jnG5sOoKgAOywT9b+5V2L8GcTZfLgDBgO3L7
         k0skTsi3s15kD9yFZW0H2PA30tGOq3UrtS+ZpfkTSYRHbA3W1IFQgirDeqE1tG8taiGH
         /5x1nFzkVW/XrAjq9QuMKUVJ+eNFJbCQSX8eNfzcOfjGXu3fZKQvJXJ5d7ilw0o5XmGL
         MCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707773985; x=1708378785;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFEoAydGNCIakLM+oYHcpcvSKcGKjy30qzf4+mOY1ag=;
        b=bj6hir5YdCLA8BeLHYexCgYXc6+5w5KW1aE3vZzSKpkWwIyurnVpdAUMeN3Cd5rcGk
         b1GgEDOwP3n4iW7OPNd3LYT2k/CWOxF62U+fiHuSPTWGfvB6ToU2keb5lDQPZWpg7DNP
         JRO5FV2KY/7DKDL25FG9SKK9G8vq1mUzUAvuEExKyFHG+gRJzd1wVhc6zSHpjEDloCOV
         QJhlP1Ms6vQBh+sM3LXAn4tLN6RuGBOr1xhgWBdr56T4t5bWTacMEe22blauZSA8Clys
         PSwczP6zR0BUGeXZJ1jZtDpTiI4Ml6V5Jw5tzteul6IJkmSrxibAMlYX8JXEBd8vB5gt
         d7JQ==
X-Gm-Message-State: AOJu0YxeJ98X+Opj/naxJXJ+kV9dqvzDXu3WwYkwqcACN0BebFsoqiaE
	XNJ/ziIeLbK+oU+1bfXX+Zg1Qj5YE7Yyg3Nlq571dDDjXrf1r1tdK92kQSNYIb+868rQTQLsoZY
	/ZQ==
X-Google-Smtp-Source: AGHT+IHWeYeSfs9VSWCME9Zm5O2fUep/uRibBNlRqA9VaQU1CvkyHMwI5g7LZivFcfiaDsVBzBtyLk+b/OQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a81:a003:0:b0:607:8294:7631 with SMTP id
 x3-20020a81a003000000b0060782947631mr42744ywg.10.1707773985395; Mon, 12 Feb
 2024 13:39:45 -0800 (PST)
Date: Mon, 12 Feb 2024 13:38:52 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-7-surenb@google.com>
Subject: [PATCH v3 06/35] mm: introduce __GFP_NO_OBJ_EXT flag to selectively
 prevent slabobj_ext creation
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce __GFP_NO_OBJ_EXT flag in order to prevent recursive allocations
when allocating slabobj_ext on a slab.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/gfp_types.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 868c8fb1bbc1..e36e168d8cfd 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -52,6 +52,9 @@ enum {
 #endif
 #ifdef CONFIG_LOCKDEP
 	___GFP_NOLOCKDEP_BIT,
+#endif
+#ifdef CONFIG_SLAB_OBJ_EXT
+	___GFP_NO_OBJ_EXT_BIT,
 #endif
 	___GFP_LAST_BIT
 };
@@ -93,6 +96,11 @@ enum {
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
+#ifdef CONFIG_SLAB_OBJ_EXT
+#define ___GFP_NO_OBJ_EXT       BIT(___GFP_NO_OBJ_EXT_BIT)
+#else
+#define ___GFP_NO_OBJ_EXT       0
+#endif
 
 /*
  * Physical address zone modifiers (see linux/mmzone.h - low four bits)
@@ -133,12 +141,15 @@ enum {
  * node with no fallbacks or placement policy enforcements.
  *
  * %__GFP_ACCOUNT causes the allocation to be accounted to kmemcg.
+ *
+ * %__GFP_NO_OBJ_EXT causes slab allocation to have no object extension.
  */
 #define __GFP_RECLAIMABLE ((__force gfp_t)___GFP_RECLAIMABLE)
 #define __GFP_WRITE	((__force gfp_t)___GFP_WRITE)
 #define __GFP_HARDWALL   ((__force gfp_t)___GFP_HARDWALL)
 #define __GFP_THISNODE	((__force gfp_t)___GFP_THISNODE)
 #define __GFP_ACCOUNT	((__force gfp_t)___GFP_ACCOUNT)
+#define __GFP_NO_OBJ_EXT   ((__force gfp_t)___GFP_NO_OBJ_EXT)
 
 /**
  * DOC: Watermark modifiers
-- 
2.43.0.687.g38aa6559b0-goog

