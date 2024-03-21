Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEADA13A86A
	for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039080; cv=none; b=I/9yWWlK5uCwtmWasTMuf1KDOTK6Fg2f7KXNqXnf9qyoo9mX3w+IAyN8Se2U/zkJoJKTtJ9n+V3+9Pkiqlmqtyt1rTM9aZYIFS8Qpa7o+wMkzNiU6AhM/0GJuQta+WZxZmDjRXM8n/vs/JCBlEsblDnvO5qQJH/75EpIxJM2j8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039080; c=relaxed/simple;
	bh=VIDk2cVbRQo+R3GXDZfOMDAjJplBMheLQJqibMpEc1M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OJJ0hAu+oJkg+YmzRSjx5u+BWEpZzmVsQjmEWsZXj0Vh6W3WnfM9LzmH4nzJB/FlLs8VZq+OOJP7P8Mh+K9b32M3cqseqyn8doo2lOYJ/l1Q/N0Uzx4Y79kAPdehVteR8AwkYTFw4qMRX1Ps4rYCbAvoZ4/bqu1ttNR0BY7hr6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xKmxM/fv; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xKmxM/fv"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf216080f5so1808630276.1
        for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 09:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039078; x=1711643878; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pOwNrbZCC43nJVxac3Uw9hAvg9K+bdh2+QxQ9H95ZLk=;
        b=xKmxM/fvy/C0WukWYrEkLM10pjPh2pTz6CDlCfhFBW3ef4BaYnNxNU9RMB39VYB8qC
         sjehPF8sFObNuxB2s1m8ITmj3fQIX75GbTGUi4+hHTfGNDWDiJJpuOlIjW1ZE9gDS1DC
         y3AN7g+e3Js33EuqjVaHI7S/7ihWBVq2dxV8zbpDC4Qy4eRkEuuy44z7vJBo9PyY/emU
         /MEyDcOs41L0HmwArbx6wYv+0wrGEjnlMXVxIrAmSQT+cQVRbryZYACSsrz0Jxn9wh1j
         Q6Kitlc+3kIYUzHBCDx8zHeMEUvVBEAIEeJpa5SiO14KGGC/R47fjmM3pdTgpTAYsePN
         OPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039078; x=1711643878;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pOwNrbZCC43nJVxac3Uw9hAvg9K+bdh2+QxQ9H95ZLk=;
        b=FexWBVXdW9Ar2gNV6MqW1WiIrxVA4iAP2OEktQBqOBe43UlazUhusiaFmtltwxYX1p
         wCqe85JzH+93j74BiAJm7Pbw5y91t4zykQWQGitJq9NYGO68x2xhVDENiS4POWPACb/M
         aI4IdGBkPTJdustHUVohhLOaVscz8941b7Ukyh246SsS6/55Cu4nn77wGFQHerbfIGRK
         bNlDP9RfnYQg0Xv/qxe3TgK8R5mAsYbRa+2AdjEpWWmAzIjGkWszjhlCi2r2zab3iOe+
         fl2cqeihcIm89tnqKyI/Bwj+GJonzFCbotV8QDeTZ9yScAFaCj0NRnsZER3yYBdtYE22
         Kwhw==
X-Forwarded-Encrypted: i=1; AJvYcCXJFpZSxp4rQBIawAIYyPkNAbLOkqZy2/gAOSm8xN5bpSKcgDPP1B3d0owyvzI/xtRr9drlsNkitgtUmfEuXdiFBTDgOz8=
X-Gm-Message-State: AOJu0YxTjfWSCIn1Bb4TB3GpmrnS2HV5ezs5fka+oDSo2Tbm1CY4TAFq
	KOYT4FS0lPcMORDvMaXt6sZ3ZPT3NyAjh2NqzdclOmBtbiZBNuyERrrIclZfKnOHiqiE9vKTmIJ
	0fA==
X-Google-Smtp-Source: AGHT+IEW+wzJaTFBqhE05AsZZeHucxp+/bXHicD4m92IkMS+am09AVJUNTX8XqOhkKHJop6Lzvm1ThHm3tA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:6902:1004:b0:dc7:5aad:8965 with SMTP id
 w4-20020a056902100400b00dc75aad8965mr5894352ybt.0.1711039077542; Thu, 21 Mar
 2024 09:37:57 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:44 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-23-surenb@google.com>
Subject: [PATCH v6 22/37] lib: add codetag reference into slabobj_ext
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
	glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
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
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/memcontrol.h | 5 +++++
 lib/Kconfig.debug          | 1 +
 2 files changed, 6 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 12afc2647cf0..24a6df30be49 100644
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
index ca2c466056d5..dd44118e7337 100644
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
2.44.0.291.gc1ea87d7ee-goog

