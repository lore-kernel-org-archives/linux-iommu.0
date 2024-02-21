Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564981586D8
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 19:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544528; cv=none; b=jzK3QidEqu3hMSFz31TOlIuX8A0g4rHPNJug6tjoOWAPrpP58s44alBRmtHact569CQ8sBoR6rEHWus/ip3XxAENhVTJ5vbSsJo3lhMM8fhycV6ErwjMOFXhb6BjM/TGA2JpVcK5n7H5x+MH+xMh9cBsIuWK4M37XDBCpDkagiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544528; c=relaxed/simple;
	bh=P/l83L7DEb0X0XM29YB6WUnPfeb/2u056JWdsmbZtHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KobrfFOJkxEMATtKIYCYZp9Ua2d+v88cfZYhlKVCRmGTyW7qARACj1nRDtESnUSTDanbanWEzLkLRGpexZOeJIZ9tS3ZbscVgo8aUnmnBcshfHNp+FsRb0WKl2+wlljVoQICYt90gtSYPSGjebEBdmPdbKMEsqCE/7t2pEvTNtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KITovlpg; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KITovlpg"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607e613a1baso116831537b3.1
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 11:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544525; x=1709149325; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LC7kagHHnwmHwKr3BMy6MtJI28X2XJIX7s9nejqSpcw=;
        b=KITovlpgbC8XRCccjLVMdLdyxT7KaJ93+8t2ZSymBW4yzREPch9gTPhiOZKXzhqRuD
         881mXcyUmS2KOUN8v87M3A8Fi+bH4++GxfB9CESbepZEzWCYSzWcCTfMfsl9b5BdqR3D
         1fjkdMRsQOrgIAS8aOjoT0uZoLMeZjaJgQJy9qyd/uUbfTFUB0ZvUqrFXTLFOTWEEi0y
         r06z8KtDr+Kl9eSPuCsfrYP47eOudlEka5wt0n/HgKM7VgFCcA1/VTXAJAIZlP0uF1KI
         Bcp7tQa6jeJh7NFPanVBCy6DytzTmr6/rCXpJjElOMxMrlGkdEpI/Ic1pxY3m0jkIrc2
         nyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544525; x=1709149325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LC7kagHHnwmHwKr3BMy6MtJI28X2XJIX7s9nejqSpcw=;
        b=rlKLZphAbffFP94zUcJaU3X8wWuU58DriQWe6wHtEkgGxU2G4EfhU+kyaprqX9HdQQ
         iDqsB0n9GZvfBaEfwTzQlFTQtpIg2/tUqUbwh82cLMKM1uxNX/Hu8prBcV4VXTKLe4hC
         13yU0IJ+W7FVBfDOeL9UPWYLyBECSjggjQjqH+P2cZEBEwU7No7yLZFPHoO2EzQ0jnl0
         SHKZ0mOsreCoqxhl8wRZsFHJ7YjhAvTnSLdbsfrLE70/s7Hykusnhm8rTg1pSJbzJWZU
         HFM59rhnDUxByb022YeeGdSYhPZOLiP/Ho3FFrpogOlB/VTIoTk5Q6uQZ8HYrChXUnhb
         1rxw==
X-Forwarded-Encrypted: i=1; AJvYcCVW9OOE2Fp5QZcbHC77zo2FqGwcEqtgV0+EKKlG4ntc9DQn0HlDiAqU8shEzo5ql9276/rvsyFWeUJc2mL1M64iMOEwt/o=
X-Gm-Message-State: AOJu0YwXiQ+zzln1e6lQEzpSoPqfakWnqbW+sG7fSHi/yxfDvXdHyZUH
	ZwBjxxfgK4nlsaxH6B1PjMgG9VcolB58NafMz9EuFslYEU84iq52SYZggU4/H+bLckEXJ+/KZ8N
	Nbw==
X-Google-Smtp-Source: AGHT+IF/fw4+k0W9YQaAhd8X5D2pflUjenW5K2EydUoGfLHK5w3QTNH4iYX84WllsVXa/U8r+txZWwizBxc=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a0d:e611:0:b0:607:9268:6665 with SMTP id
 p17-20020a0de611000000b0060792686665mr4677189ywe.10.1708544525062; Wed, 21
 Feb 2024 11:42:05 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:44 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-32-surenb@google.com>
Subject: [PATCH v4 31/36] lib: add memory allocations report in show_mem()
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

Include allocations in show_mem reports.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/alloc_tag.h |  7 +++++++
 include/linux/codetag.h   |  1 +
 lib/alloc_tag.c           | 38 ++++++++++++++++++++++++++++++++++++++
 lib/codetag.c             |  5 +++++
 mm/show_mem.c             | 26 ++++++++++++++++++++++++++
 5 files changed, 77 insertions(+)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 29636719b276..85a24a027403 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -30,6 +30,13 @@ struct alloc_tag {
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING
 
+struct codetag_bytes {
+	struct codetag *ct;
+	s64 bytes;
+};
+
+size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sleep);
+
 static inline struct alloc_tag *ct_to_alloc_tag(struct codetag *ct)
 {
 	return container_of(ct, struct alloc_tag, ct);
diff --git a/include/linux/codetag.h b/include/linux/codetag.h
index bfd0ba5c4185..c2a579ccd455 100644
--- a/include/linux/codetag.h
+++ b/include/linux/codetag.h
@@ -61,6 +61,7 @@ struct codetag_iterator {
 }
 
 void codetag_lock_module_list(struct codetag_type *cttype, bool lock);
+bool codetag_trylock_module_list(struct codetag_type *cttype);
 struct codetag_iterator codetag_get_ct_iter(struct codetag_type *cttype);
 struct codetag *codetag_next_ct(struct codetag_iterator *iter);
 
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index cb5adec4b2e2..ec54f29482dc 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -86,6 +86,44 @@ static const struct seq_operations allocinfo_seq_op = {
 	.show	= allocinfo_show,
 };
 
+size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sleep)
+{
+	struct codetag_iterator iter;
+	struct codetag *ct;
+	struct codetag_bytes n;
+	unsigned int i, nr = 0;
+
+	if (can_sleep)
+		codetag_lock_module_list(alloc_tag_cttype, true);
+	else if (!codetag_trylock_module_list(alloc_tag_cttype))
+		return 0;
+
+	iter = codetag_get_ct_iter(alloc_tag_cttype);
+	while ((ct = codetag_next_ct(&iter))) {
+		struct alloc_tag_counters counter = alloc_tag_read(ct_to_alloc_tag(ct));
+
+		n.ct	= ct;
+		n.bytes = counter.bytes;
+
+		for (i = 0; i < nr; i++)
+			if (n.bytes > tags[i].bytes)
+				break;
+
+		if (i < count) {
+			nr -= nr == count;
+			memmove(&tags[i + 1],
+				&tags[i],
+				sizeof(tags[0]) * (nr - i));
+			nr++;
+			tags[i] = n;
+		}
+	}
+
+	codetag_lock_module_list(alloc_tag_cttype, false);
+
+	return nr;
+}
+
 static void __init procfs_init(void)
 {
 	proc_create_seq("allocinfo", 0444, NULL, &allocinfo_seq_op);
diff --git a/lib/codetag.c b/lib/codetag.c
index b13412ca57cc..7b39cec9648a 100644
--- a/lib/codetag.c
+++ b/lib/codetag.c
@@ -36,6 +36,11 @@ void codetag_lock_module_list(struct codetag_type *cttype, bool lock)
 		up_read(&cttype->mod_lock);
 }
 
+bool codetag_trylock_module_list(struct codetag_type *cttype)
+{
+	return down_read_trylock(&cttype->mod_lock) != 0;
+}
+
 struct codetag_iterator codetag_get_ct_iter(struct codetag_type *cttype)
 {
 	struct codetag_iterator iter = {
diff --git a/mm/show_mem.c b/mm/show_mem.c
index 8dcfafbd283c..1e41f8d6e297 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -423,4 +423,30 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 #ifdef CONFIG_MEMORY_FAILURE
 	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
 #endif
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+	{
+		struct codetag_bytes tags[10];
+		size_t i, nr;
+
+		nr = alloc_tag_top_users(tags, ARRAY_SIZE(tags), false);
+		if (nr) {
+			printk(KERN_NOTICE "Memory allocations:\n");
+			for (i = 0; i < nr; i++) {
+				struct codetag *ct = tags[i].ct;
+				struct alloc_tag *tag = ct_to_alloc_tag(ct);
+				struct alloc_tag_counters counter = alloc_tag_read(tag);
+
+				/* Same as alloc_tag_to_text() but w/o intermediate buffer */
+				if (ct->modname)
+					printk(KERN_NOTICE "%12lli %8llu %s:%u [%s] func:%s\n",
+					       counter.bytes, counter.calls, ct->filename,
+					       ct->lineno, ct->modname, ct->function);
+				else
+					printk(KERN_NOTICE "%12lli %8llu %s:%u func:%s\n",
+					       counter.bytes, counter.calls, ct->filename,
+					       ct->lineno, ct->function);
+			}
+		}
+	}
+#endif
 }
-- 
2.44.0.rc0.258.g7320e95886-goog

