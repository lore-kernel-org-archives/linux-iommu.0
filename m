Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67BE5DF0A
	for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 21:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774042; cv=none; b=oWYI07DaIC+1znx2NDP3e0Eh4AU/qEuAn3H6gcTCNajrUDlYOE84anVmYmM3nEsdO25qZ/7l0sY561M4zPdBYrGJHPQoauaqZYuOgwIB8thgRBtZETgNRUe6wKKJdS1mMh+mpZdaGbsq8mXDTis39k7t0ZRErjnE4P8Eh1Rg4cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774042; c=relaxed/simple;
	bh=MrsgVd/Qc298kApLcMr0fYQLGuQi40dU4EQGVe/x6w4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sr661dhCBq8Ex9CfknHH1JcvnJ5yyVJN+RWbZYpcY1DWx9UdSVWLocz1uV0bZ5O8QvraxcwHNQVGNdOl44nt47ER7BZj5LbmnPNqP0b38Lrnl8foY7IwttBHVzVq0LYNtyfu3+a0K1jYwrl7AaziwiQLn8Rw/yv2O4rSV4bzLz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=22B/3BJt; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="22B/3BJt"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-604ad18981eso84789367b3.2
        for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 13:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707774040; x=1708378840; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hFi0jScQsczt4c2Plav2pAvubIeyjPFOX5wIUH8AZHM=;
        b=22B/3BJt5eiiYe1yKoDllM7YIEMEdpEY4B+2LWLw+GkgW5OHS3qubsS/R23l1FjlTF
         Tf4kWUaGUPaDSX7Dd3aZyjNUriHg/vDXX8JXxL/LTU4cLq45wk5MdSuNmvjEqMU9Fot3
         AJ9cvSw0q+x+vQDRmOab9DGWPzuKm//5VUivM3wNSWtuI3ocdGkvRxE39FHBKazc7kBA
         9ULkyCNaNeqj2IF7Dgak1OvYEYc0o4d8+I+akCJhQkAq2uJ67QqMhlRHsNz5NdkYTEDf
         Dnd58PUzCFuPsnkKRv/I8vsySKTuKH9qxyajTxp3YXDIigVtG0/yaXzYAOxD6UaozUgi
         0S1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707774040; x=1708378840;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFi0jScQsczt4c2Plav2pAvubIeyjPFOX5wIUH8AZHM=;
        b=TqpEcgiDQWbH8DbddX624WIJxxPJqOHg2RBhi3DxS9oOkDOQmRB69OFK7YqOoxuDiE
         4YLZ4zw2fJ3xy+dCVlx4MMo92TCgdOD6iFU8nabmf5CHEvpPyWEoaLXk/ccWjxijOlgx
         wIZCMXX5e+hrbfkgNMhL4rXntjDkMmgG7dzvtr5u7so2Sizz1e3sJRwijKJKIct8/imB
         XFS3YBxsufvXeC+7msvjf0benJMlQlzyqy2zWJ5Q86avUyoHtEetvttWMELem6YsMGjs
         Lp7ZNRdwIclOktfEysqWNeqnIij/ynIOAdptBW0gbFPCMcLMfA69U3Wppw/73ndKF+1g
         N8Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXQthR+csimR/ylMrFQmFDltUWT+xC/Ft957sC+WnbmyISd6m2px+43e0CUkBJyW5pXQYEWYMEGkBIJ9IAP0j6nIXLvLjA=
X-Gm-Message-State: AOJu0YxuTwhfDS5VpCmVDPw4GxOEB7bBYA3kmDxpwkiK+JFeBNXzY5ql
	snzql3+9d8f9+2SXT+pce72oxkxmYBuE+ykgToxZJHb37lG+Zh0Z7ize01Va4aS/kfH2SI0MBSJ
	GIw==
X-Google-Smtp-Source: AGHT+IG01ZIdCxyG6doWIwi6F85UI5DWfcKo01/n0teetJJReA8rQ10tG50Lh8eu7adVmXuhCLeMmXOg6Mg=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a05:690c:b8b:b0:5ff:96b6:8ee1 with SMTP id
 ck11-20020a05690c0b8b00b005ff96b68ee1mr2134418ywb.7.1707774039644; Mon, 12
 Feb 2024 13:40:39 -0800 (PST)
Date: Mon, 12 Feb 2024 13:39:17 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-32-surenb@google.com>
Subject: [PATCH v3 31/35] lib: add memory allocations report in show_mem()
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

Include allocations in show_mem reports.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/alloc_tag.h |  2 ++
 lib/alloc_tag.c           | 38 ++++++++++++++++++++++++++++++++++++++
 mm/show_mem.c             | 15 +++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 3fe51e67e231..0a5973c4ad77 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -30,6 +30,8 @@ struct alloc_tag {
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING
 
+void alloc_tags_show_mem_report(struct seq_buf *s);
+
 static inline struct alloc_tag *ct_to_alloc_tag(struct codetag *ct)
 {
 	return container_of(ct, struct alloc_tag, ct);
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 2d5226d9262d..54312c213860 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -96,6 +96,44 @@ static const struct seq_operations allocinfo_seq_op = {
 	.show	= allocinfo_show,
 };
 
+void alloc_tags_show_mem_report(struct seq_buf *s)
+{
+	struct codetag_iterator iter;
+	struct codetag *ct;
+	struct {
+		struct codetag		*tag;
+		size_t			bytes;
+	} tags[10], n;
+	unsigned int i, nr = 0;
+
+	codetag_lock_module_list(alloc_tag_cttype, true);
+	iter = codetag_get_ct_iter(alloc_tag_cttype);
+	while ((ct = codetag_next_ct(&iter))) {
+		struct alloc_tag_counters counter = alloc_tag_read(ct_to_alloc_tag(ct));
+
+		n.tag	= ct;
+		n.bytes = counter.bytes;
+
+		for (i = 0; i < nr; i++)
+			if (n.bytes > tags[i].bytes)
+				break;
+
+		if (i < ARRAY_SIZE(tags)) {
+			nr -= nr == ARRAY_SIZE(tags);
+			memmove(&tags[i + 1],
+				&tags[i],
+				sizeof(tags[0]) * (nr - i));
+			nr++;
+			tags[i] = n;
+		}
+	}
+
+	for (i = 0; i < nr; i++)
+		alloc_tag_to_text(s, tags[i].tag);
+
+	codetag_lock_module_list(alloc_tag_cttype, false);
+}
+
 static void __init procfs_init(void)
 {
 	proc_create_seq("allocinfo", 0444, NULL, &allocinfo_seq_op);
diff --git a/mm/show_mem.c b/mm/show_mem.c
index 8dcfafbd283c..d514c15ca076 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -12,6 +12,7 @@
 #include <linux/hugetlb.h>
 #include <linux/mm.h>
 #include <linux/mmzone.h>
+#include <linux/seq_buf.h>
 #include <linux/swap.h>
 #include <linux/vmstat.h>
 
@@ -423,4 +424,18 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 #ifdef CONFIG_MEMORY_FAILURE
 	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
 #endif
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+	{
+		struct seq_buf s;
+		char *buf = kmalloc(4096, GFP_ATOMIC);
+
+		if (buf) {
+			printk("Memory allocations:\n");
+			seq_buf_init(&s, buf, 4096);
+			alloc_tags_show_mem_report(&s);
+			printk("%s", buf);
+			kfree(buf);
+		}
+	}
+#endif
 }
-- 
2.43.0.687.g38aa6559b0-goog

