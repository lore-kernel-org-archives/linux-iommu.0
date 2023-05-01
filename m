Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70013D99
	for <iommu@lists.linux.dev>; Mon,  1 May 2023 16:55:41 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-b9a6f15287eso27706168276.1
        for <iommu@lists.linux.dev>; Mon, 01 May 2023 09:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960140; x=1685552140;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fsyg89/vfc29JJa9GS5YhCGnLnEPc8LoOfUR2xEk3nU=;
        b=XugZDvU8R0/s4xSWeFHluE62boWwkQ9CTbOENMFYQbMS3l2tyzUCtbQcKbwHigUJIJ
         OtnAHKBuBjvsP9/stYM2LN0tvR5v6TsP4w8c4UexO5Utfx0bFwgsYC7skVlENgpnJL9H
         sIxP6b1pDy/fBiWqF/8EcNcaUPUXV9QISrg+weQ/AP/7B06TvSpoas2EJfqmlc3VmYeD
         jr4T+ZByYleQx4KEZl+bfKD1sOEa1DJKK+WO7dY/hFTgLUuurZ1db5fCtz0miigMUxwU
         tm4S2IZOyKuiQL4O2pCNIbqdvFVKgmVq6GGIhg+Gt6k3Cilb/R8U19yQnyV0xS5Bv4tA
         iA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960140; x=1685552140;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fsyg89/vfc29JJa9GS5YhCGnLnEPc8LoOfUR2xEk3nU=;
        b=cWtJ4IEq7vkblFaPtYhOS5ZplbSi3GPiM3yRCNIm7lRaVrDBrcijQLzwvKPsxYEZaA
         lyyGK5ZiorjQwLxTrKQYZoHGNFzZI8dS/luaE3xAlEconmEypYnu+MA05bU11AS/73ky
         tpsn3Rv2iMGYWWoWD8eWFrpy95zJtZgU0SW4BluWqU0BW82N7ZSZTvsyn6Ej0zA5hbK3
         atmJ1mYUI0ecaCQcDFVJMrVVhMCIBlfNwQxxcAf6FZVgoX2L3/MZxmN5ipBWdYqlFA7e
         tGu6iatFPUQX0+JffL/ZT/kd8zExnZB/RLm0zibHd0OC3dWoMEiAiUneHt2TTWXW81jv
         Yq+Q==
X-Gm-Message-State: AC+VfDzzZ8TfYQZBWNrI0z7YUJVCr+2Y9TSq2FMhCO8W1fi64MQvnhSs
	lfbvLyYbtIbF8NlQvqGSXLQPtj9SVws=
X-Google-Smtp-Source: ACHHUZ75lgdLL8vnL0XbIs5yVvuJ1AQE8jmtL55GeRq4GA52aLYGF4UgqLBdCAr7mljybUtkaGeonaYDcH4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a25:8087:0:b0:b8b:f5fb:598d with SMTP id
 n7-20020a258087000000b00b8bf5fb598dmr8714623ybk.6.1682960140703; Mon, 01 May
 2023 09:55:40 -0700 (PDT)
Date: Mon,  1 May 2023 09:54:24 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-15-surenb@google.com>
Subject: [PATCH 14/40] lib: code tagging module support
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, ldufour@linux.ibm.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, gregkh@linuxfoundation.org, ebiggers@google.com, 
	ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com, 
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 
	42.hyeyoo@gmail.com, glider@google.com, elver@google.com, dvyukov@google.com, 
	shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add support for code tagging from dynamically loaded modules.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/codetag.h | 12 +++++++++
 kernel/module/main.c    |  4 +++
 lib/codetag.c           | 58 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/include/linux/codetag.h b/include/linux/codetag.h
index a9d7adecc2a5..386733e89b31 100644
--- a/include/linux/codetag.h
+++ b/include/linux/codetag.h
@@ -42,6 +42,10 @@ struct codetag_module {
 struct codetag_type_desc {
 	const char *section;
 	size_t tag_size;
+	void (*module_load)(struct codetag_type *cttype,
+			    struct codetag_module *cmod);
+	void (*module_unload)(struct codetag_type *cttype,
+			      struct codetag_module *cmod);
 };
 
 struct codetag_iterator {
@@ -68,4 +72,12 @@ void codetag_to_text(struct seq_buf *out, struct codetag *ct);
 struct codetag_type *
 codetag_register_type(const struct codetag_type_desc *desc);
 
+#ifdef CONFIG_CODE_TAGGING
+void codetag_load_module(struct module *mod);
+void codetag_unload_module(struct module *mod);
+#else
+static inline void codetag_load_module(struct module *mod) {}
+static inline void codetag_unload_module(struct module *mod) {}
+#endif
+
 #endif /* _LINUX_CODETAG_H */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 044aa2c9e3cb..4232e7bff549 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -56,6 +56,7 @@
 #include <linux/dynamic_debug.h>
 #include <linux/audit.h>
 #include <linux/cfi.h>
+#include <linux/codetag.h>
 #include <linux/debugfs.h>
 #include <uapi/linux/module.h>
 #include "internal.h"
@@ -1249,6 +1250,7 @@ static void free_module(struct module *mod)
 {
 	trace_module_free(mod);
 
+	codetag_unload_module(mod);
 	mod_sysfs_teardown(mod);
 
 	/*
@@ -2974,6 +2976,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	/* Get rid of temporary copy. */
 	free_copy(info, flags);
 
+	codetag_load_module(mod);
+
 	/* Done! */
 	trace_module_load(mod);
 
diff --git a/lib/codetag.c b/lib/codetag.c
index 7708f8388e55..4ea57fb37346 100644
--- a/lib/codetag.c
+++ b/lib/codetag.c
@@ -108,15 +108,20 @@ static inline size_t range_size(const struct codetag_type *cttype,
 static void *get_symbol(struct module *mod, const char *prefix, const char *name)
 {
 	char buf[64];
+	void *ret;
 	int res;
 
 	res = snprintf(buf, sizeof(buf), "%s%s", prefix, name);
 	if (WARN_ON(res < 1 || res > sizeof(buf)))
 		return NULL;
 
-	return mod ?
+	preempt_disable();
+	ret = mod ?
 		(void *)find_kallsyms_symbol_value(mod, buf) :
 		(void *)kallsyms_lookup_name(buf);
+	preempt_enable();
+
+	return ret;
 }
 
 static struct codetag_range get_section_range(struct module *mod,
@@ -157,8 +162,11 @@ static int codetag_module_init(struct codetag_type *cttype, struct module *mod)
 
 	down_write(&cttype->mod_lock);
 	err = idr_alloc(&cttype->mod_idr, cmod, 0, 0, GFP_KERNEL);
-	if (err >= 0)
+	if (err >= 0) {
 		cttype->count += range_size(cttype, &range);
+		if (cttype->desc.module_load)
+			cttype->desc.module_load(cttype, cmod);
+	}
 	up_write(&cttype->mod_lock);
 
 	if (err < 0) {
@@ -197,3 +205,49 @@ codetag_register_type(const struct codetag_type_desc *desc)
 
 	return cttype;
 }
+
+void codetag_load_module(struct module *mod)
+{
+	struct codetag_type *cttype;
+
+	if (!mod)
+		return;
+
+	mutex_lock(&codetag_lock);
+	list_for_each_entry(cttype, &codetag_types, link)
+		codetag_module_init(cttype, mod);
+	mutex_unlock(&codetag_lock);
+}
+
+void codetag_unload_module(struct module *mod)
+{
+	struct codetag_type *cttype;
+
+	if (!mod)
+		return;
+
+	mutex_lock(&codetag_lock);
+	list_for_each_entry(cttype, &codetag_types, link) {
+		struct codetag_module *found = NULL;
+		struct codetag_module *cmod;
+		unsigned long mod_id, tmp;
+
+		down_write(&cttype->mod_lock);
+		idr_for_each_entry_ul(&cttype->mod_idr, cmod, tmp, mod_id) {
+			if (cmod->mod && cmod->mod == mod) {
+				found = cmod;
+				break;
+			}
+		}
+		if (found) {
+			if (cttype->desc.module_unload)
+				cttype->desc.module_unload(cttype, cmod);
+
+			cttype->count -= range_size(cttype, &cmod->range);
+			idr_remove(&cttype->mod_idr, mod_id);
+			kfree(cmod);
+		}
+		up_write(&cttype->mod_lock);
+	}
+	mutex_unlock(&codetag_lock);
+}
-- 
2.40.1.495.gc816e09b53d-goog

