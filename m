Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD483C05
	for <iommu@lists.linux.dev>; Mon,  1 May 2023 16:55:15 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-559f48c530eso34075967b3.0
        for <iommu@lists.linux.dev>; Mon, 01 May 2023 09:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960114; x=1685552114;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bGdFaZ9yLSvpkzL04e/VHNU0a1vWusSmGZaxEHf2wm8=;
        b=kNURb9oRoWKMv7g0yo2L8rW1EcO17+d5GcAx/UcGQY6Nq04eWDbD4SbdCNOLXgOYzq
         iIefzjvXI4Snk9VN4a44AHM12D0iuNdtL0q3JhvnQXzZtf429k8SdHQyNq1DhIH3u3D/
         vgRvJtIdIGprvSKRamhSV8bn0NWTicrhYnvBvcVO6D5qUdO+wBWr5u0wD0Nu7LbQQb+M
         IIs2pzxiZlPELIg9+H7fv7z/PKPu/SB3zB+CWnrv1/57UJqzRl/3C3lgPuiSCXQkCpOG
         4JQ2sAFEorBhte2EmAzube4SlGlrch2L/NYmCg7/2eMQe55a1P+zlu78IrB4haHDMTMn
         h3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960114; x=1685552114;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bGdFaZ9yLSvpkzL04e/VHNU0a1vWusSmGZaxEHf2wm8=;
        b=e3VVRZCbEBTpEQYi5kpRmAXdufShWJ4fDs/1IHTO8R8zYuNM7v7GLp05OLJb2pTwhS
         SAb8GznM2UgNX4Q3VW4KL1u9XUHE/DaihlSaUlyWkv4KO1WBsaFBGmWYoOtQG8loUBoy
         1sGiWEWzXQWpNpbhnTfQxNdYAZUo2qJRnTWzbVytBCbTUIwQz6AKA9+kyvnU5rhCxZij
         5VsbPCvQQyaubr/32TeV+XbM2Fgt6aGoL94p4TonHr2llK+c6MRD5MwiQ6a/GD+1J8O9
         OCw0D5kxo0M2gSLp8eL5Hf3XGDykFT4LWiCGUuKwql/eKG9s+W/tHssmZ4zHO2qYd6GD
         yCqg==
X-Gm-Message-State: AC+VfDyQG1quQxrAWHKd5jrHExol4KEQR4wXfvMshwKIfF9Jh9dxV49w
	dZJBmXQxERHBsP+fy8KmhbMbY9mreWI=
X-Google-Smtp-Source: ACHHUZ54ReoLXFk1oTaYjmLVtkkNt2jRchxoRiCx8rxY23YjrphJueyeWWbM6qC2nW3CU7hKMZM9JkpwZiA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a05:690c:723:b0:54f:68a1:b406 with SMTP id
 bt3-20020a05690c072300b0054f68a1b406mr8285886ywb.2.1682960114403; Mon, 01 May
 2023 09:55:14 -0700 (PDT)
Date: Mon,  1 May 2023 09:54:13 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-4-surenb@google.com>
Subject: [PATCH 03/40] fs: Convert alloc_inode_sb() to a macro
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
	cgroups@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

From: Kent Overstreet <kent.overstreet@linux.dev>

We're introducing alloc tagging, which tracks memory allocations by
callsite. Converting alloc_inode_sb() to a macro means allocations will
be tracked by its caller, which is a bit more useful.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
---
 include/linux/fs.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 21a981680856..4905ce14db0b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2699,11 +2699,7 @@ int setattr_should_drop_sgid(struct mnt_idmap *idmap,
  * This must be used for allocating filesystems specific inodes to set
  * up the inode reclaim context correctly.
  */
-static inline void *
-alloc_inode_sb(struct super_block *sb, struct kmem_cache *cache, gfp_t gfp)
-{
-	return kmem_cache_alloc_lru(cache, &sb->s_inode_lru, gfp);
-}
+#define alloc_inode_sb(_sb, _cache, _gfp) kmem_cache_alloc_lru(_cache, &_sb->s_inode_lru, _gfp)
 
 extern void __insert_inode_hash(struct inode *, unsigned long hashval);
 static inline void insert_inode_hash(struct inode *inode)
-- 
2.40.1.495.gc816e09b53d-goog

