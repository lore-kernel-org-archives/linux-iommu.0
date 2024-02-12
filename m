Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C913E50273
	for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 21:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773992; cv=none; b=BQHpYY2GCtEf8mo8sa4IcjR9t+CfW1SdUHVQsXvoQXBR08JBIOstI3tlUxtgsEMa4NpGclwUjG3GUFJ0adjUaDGsKjoswxnVSd8t/df8FggG/1NYiO4pAA2/kBtpt4OmmAU3b+tWuM63TDFBNwvV4cIFdXwgbQFB2gnVvTm6xVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773992; c=relaxed/simple;
	bh=YHyqeuHvUrbxaU4ktRueMrpYAdLsayJ8KqWKnRsL9Bc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pv+B9HS5gxzGzzGifIqDj8yty3yk7VFaHjmQjLQCirVNrpkEw7ZbOA1FLPbBGMRV4YddfN0QHzRqK/6SM9xtOuw3Iwmk2rluXobedGp0fLLj1TUdjE65FTobC07Jul/D04k2FKqH+TiLrdWCPYFS/YGNKzwzjE8C+nJFGI9EKJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nmcy1zsY; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nmcy1zsY"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6047a047f58so66769527b3.3
        for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 13:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707773988; x=1708378788; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QPRNF15NS/yHs+nflQ9JCJcKpeGLPrq2C4Bm4JvXiOY=;
        b=nmcy1zsYv6Q3n/nKFIJljUIbZGJXYesGPGY5Km2tLB802h4iMRWrewlk1/KC0FiMkc
         Hg2B1aW9oXonTqMBri461sKTx2OJEM4PZejYMpQADDxuSaeWkONqBNCfEZRcTU5PEBKY
         nTidP7H3Y5v0kXx0UwmY0IWqOkZkfjITtTxDyVzGhmhqqyykSDiuwJM5u8HawiOCSDct
         4Zu/m4XSCZ0I5LYYq6DqMnKPbuF0On2RzNVRmM8pk01cjwpII0ptTwbKSNg/L1Du6RpD
         PWWeYDI/26/ygDQYiFfBcSe32OvWBSuFfVk9oNmtS8fYQnZHAD2X8o0nCZLGAVYeChBt
         mSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707773988; x=1708378788;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QPRNF15NS/yHs+nflQ9JCJcKpeGLPrq2C4Bm4JvXiOY=;
        b=Dmwlo59X1CX6N0vDYZQF08sPYTG34qsCHJGucdqNzQpWq8oAz32SbOGysF6EmAqI/A
         1NsuhvuSiEL/XjlGHIjwaHNq03/WMrl2+lPe5ppdiWhola003jeO39IKbh82bOwwJtKJ
         II4nGCqVbl+j9Vvz8k8VeLu4/L3t/3BbOIRoQs3lkNa3ocsZDEN9M/SEfpNRrzftWwV1
         2c/Mj95sQbp84UV024ubienqlyng1B9EoJv0axUxt8BS8qybzDq+HhPCDxxY5x8DA3uV
         cJR//i6l+OdiD3zInJ5gzuATCAIFPn75DwsS6gcuxJHyywkMUW/L8YHd7s+3bRevVlWl
         o2ag==
X-Forwarded-Encrypted: i=1; AJvYcCW7qkaE0ZtAGV8s+qxsY8OzaYilvUj/FJ6azeRn7LE98qOWoiYi/dCr4K3AiEnYoz0myuWrK00sPIpERrAv7sweZoLd2O8=
X-Gm-Message-State: AOJu0Yz2ajzfSfRrLD0D5+wZC/Da4YuxhoDPwuDk24dak1YKszm8VZMD
	0L94mRfh2843xaLNLrHN3a2eyJydwffh4AyDAsgaNppKHGUDQEoTnSwMDWWtVTz3YBSSzqKOKZq
	6/Q==
X-Google-Smtp-Source: AGHT+IFIMBcV3x/W8fhRczbwea2w1q1gcT3ETfM1GWq+zDEkeIxrI9ytOpFdbEX8EDgRr+EtsMkcZCh6eRk=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a25:53c3:0:b0:dcb:c4d3:6e07 with SMTP id
 h186-20020a2553c3000000b00dcbc4d36e07mr382686ybb.5.1707773987608; Mon, 12 Feb
 2024 13:39:47 -0800 (PST)
Date: Mon, 12 Feb 2024 13:38:53 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-8-surenb@google.com>
Subject: [PATCH v3 07/35] mm/slab: introduce SLAB_NO_OBJ_EXT to avoid obj_ext creation
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

Slab extension objects can't be allocated before slab infrastructure is
initialized. Some caches, like kmem_cache and kmem_cache_node, are created
before slab infrastructure is initialized. Objects from these caches can't
have extension objects. Introduce SLAB_NO_OBJ_EXT slab flag to mark these
caches and avoid creating extensions for objects allocated from these
slabs.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/slab.h | 7 +++++++
 mm/slub.c            | 5 +++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index b5f5ee8308d0..3ac2fc830f0f 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -164,6 +164,13 @@
 #endif
 #define SLAB_TEMPORARY		SLAB_RECLAIM_ACCOUNT	/* Objects are short-lived */
 
+#ifdef CONFIG_SLAB_OBJ_EXT
+/* Slab created using create_boot_cache */
+#define SLAB_NO_OBJ_EXT         ((slab_flags_t __force)0x20000000U)
+#else
+#define SLAB_NO_OBJ_EXT         0
+#endif
+
 /*
  * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
  *
diff --git a/mm/slub.c b/mm/slub.c
index 1eb1050814aa..9fd96238ed39 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5650,7 +5650,8 @@ void __init kmem_cache_init(void)
 		node_set(node, slab_nodes);
 
 	create_boot_cache(kmem_cache_node, "kmem_cache_node",
-		sizeof(struct kmem_cache_node), SLAB_HWCACHE_ALIGN, 0, 0);
+			sizeof(struct kmem_cache_node),
+			SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
 
 	hotplug_memory_notifier(slab_memory_callback, SLAB_CALLBACK_PRI);
 
@@ -5660,7 +5661,7 @@ void __init kmem_cache_init(void)
 	create_boot_cache(kmem_cache, "kmem_cache",
 			offsetof(struct kmem_cache, node) +
 				nr_node_ids * sizeof(struct kmem_cache_node *),
-		       SLAB_HWCACHE_ALIGN, 0, 0);
+			SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
 
 	kmem_cache = bootstrap(&boot_kmem_cache);
 	kmem_cache_node = bootstrap(&boot_kmem_cache_node);
-- 
2.43.0.687.g38aa6559b0-goog

