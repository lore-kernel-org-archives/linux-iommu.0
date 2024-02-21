Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67CC14D443
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 19:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544505; cv=none; b=NKu3KwBtdOKFYfOiolNoC/b+C6EEGTq2sPah3uhErRUwbTGOXrgKdYhRQfeIwfW5uw17CymjbKcPwYdm7IrM1vb5IJo21uh+7g9bTZ4y1/IVyGHB1nhWOqT07YmK+dom/e0UM+7O7VT1tzBYThSykdyqyc34Y/uU43mx41D4J9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544505; c=relaxed/simple;
	bh=tyIikjJlrYyNLJoOHRGtPA/wKSTMkEiPDo19C/DYXH4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vBURD0SWB4FlsH2X4I6tsYiqU/c/Oc8Cu21+okoPUr/ZrBDTpI6a8RcIfIqwXoZXeli/3xZyZEzUL+cQkXDuiqwwYSU5U+ec9v7ZFFoWMy77fr8kfAf9vRxnfy+Wz53txba3XYuQE/HUsYPLEUp5eAhR3IMzu7Mvka5KgcLwHpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y0iETAzC; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y0iETAzC"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607e613a1baso116815057b3.1
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 11:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544503; x=1709149303; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4D2ym4tmaIuNf1w08quK73QR9EK/cyrgSXHS1sTLYhg=;
        b=Y0iETAzCfuUeQG15ErfWtos5Zm1lmwUi4RBOACUvWF7+Vm0bPuQ4BwUkpdtQXMCbIn
         lWNlovgYPgnAXdFCyawiRYMYtEoDPWS9s41XjMSC08BbvuIS1jJTuMn3O7+LYRpVEmq4
         pYuZRmbB6AbF61OkWW43o7JNOKpFd7HhBgxJ/pFEPcUQN6FLzIVByA5M99aRFylevd2b
         J5Scl+sdu/UJ87B7JHiblprNHmZriHWXTL9A7cRGraXVghwW/pXoDBP6WinP/mIoFbE7
         D/ECZYm4MB2iP0VtMgHA+xnOeJ/HsW+i2I7hFmvdQNtW1RYOck7brFNLm2kao5EeDCpq
         SUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544503; x=1709149303;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4D2ym4tmaIuNf1w08quK73QR9EK/cyrgSXHS1sTLYhg=;
        b=Vz+uH2B1CKAaox/Ehb7doJhfQWNbsyjHL9dWqWYALmuhXgdf9jP0D5eE5QzniatbjD
         gL5LRkmn9XtRnAzS3o+FEYIjnys1WIjwhNvMqDiqyeivSToFeCUNh0FmALyBdGA7Cz1T
         zuul/iJ5yt6MaheBUyMvvTYkMWIKZDHYZPHSlW9xWWq6Je7kmWBp2QkaokImR/swEwKQ
         aK7Tj9T7+EHeRQGZQ4MufEnvo63FqqjDs4xKmdrhoHP+h/aPV+g/R2Vt9DjW5AX8ogU0
         wC17tMtXzbgzQcXId+OjlmMrj8fk8MKNYK8hsqV8SMn03ZF8ijsk6InsO2WBgOdKYTLx
         vT0w==
X-Forwarded-Encrypted: i=1; AJvYcCWTR3hmix6A3rKrhUDvVxVVMp6bs700eZAN4BrkBYMMBmElvGzutC6IidvIbXvLhKUm87GEc4JxvQfGwp02c+HR918qiB0=
X-Gm-Message-State: AOJu0Yx/8RezRo4dMIkLtICVMzUsYrEjc0LiDqriCdHsHfDR34vpGzzA
	+SRv2xpTJdKI46m9cp6mYdTA33nBYe9wlq//HPDU8y1AGrFwCvsZWMXf8kDwVlQVYClkCs+/toc
	YwQ==
X-Google-Smtp-Source: AGHT+IHUFqe0R6lIIi9NA0qHx8ZRtyarym315AvQcyj6s2JvP2F2gSCMg1vFWmN120oFVZKD/Z/VCxMwQvI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a0d:e611:0:b0:607:9268:6665 with SMTP id
 p17-20020a0de611000000b0060792686665mr4677003ywe.10.1708544502298; Wed, 21
 Feb 2024 11:41:42 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:34 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-22-surenb@google.com>
Subject: [PATCH v4 21/36] lib: add codetag reference into slabobj_ext
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

To store code tag for every slab object, a codetag reference is embedded
into slabobj_ext when CONFIG_MEM_ALLOC_PROFILING=y.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/memcontrol.h | 5 +++++
 lib/Kconfig.debug          | 1 +
 2 files changed, 6 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index f3584e98b640..2b010316016c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1653,7 +1653,12 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
  * if MEMCG_DATA_OBJEXTS is set.
  */
 struct slabobj_ext {
+#ifdef CONFIG_MEMCG_KMEM
 	struct obj_cgroup *objcg;
+#endif
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+	union codetag_ref ref;
+#endif
 } __aligned(8);
 
 static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7bbdb0ddb011..9ecfcdb54417 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -979,6 +979,7 @@ config MEM_ALLOC_PROFILING
 	depends on !DEBUG_FORCE_WEAK_PER_CPU
 	select CODE_TAGGING
 	select PAGE_EXTENSION
+	select SLAB_OBJ_EXT
 	help
 	  Track allocation source code and record total allocation size
 	  initiated at that code location. The mechanism can be used to track
-- 
2.44.0.rc0.258.g7320e95886-goog

