Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9EB610B
	for <iommu@lists.linux.dev>; Tue, 30 Aug 2022 21:49:56 +0000 (UTC)
Received: by mail-yb1-f201.google.com with SMTP id w63-20020a25c742000000b006960ac89fedso720383ybe.18
        for <iommu@lists.linux.dev>; Tue, 30 Aug 2022 14:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=+dBCH/ZYeXKPl1XZC0y8jtwH0hgKGXE3JjJWq8gRM44=;
        b=AFaSMy8jXac7TuC+3zPxWUGJEoV6Xwt0zQp9MqDmFFlT9mWJtIdF7dkyLAZ2dlc2YA
         b9Gf5k0v2Zvts/DmzzZ5pyBGK4PvMyQtpd/jCDUfU7pbPfnKneDUuVfIqoh8xzC2EEXM
         ggO+9/ET/L3N7vFPV9TWkym8O3GXfgaPKOHQOvjujiuqNd9k0qGNIcoGl/dBIZk4zlFa
         QTsb0Fx654oBfwlYyCvPgpIbUnjCokKwOPL7A775wrhi+ShDtrR1D6bLCXYg9BBaYtDw
         bc4QILCqScR/90fRkJQtLt8mPydrXHAQRmui3zER0ZDrlUBSto4jKF/epnVV4Tt3A9sc
         lVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=+dBCH/ZYeXKPl1XZC0y8jtwH0hgKGXE3JjJWq8gRM44=;
        b=feCr0m2oKC5KSsbrbIONUlWwbfWdhAiT+EeXnZm1W3xLu09jciuPLqXgupPgOzT5L2
         n0L189GOiUhZYl4VUihhPr0qPN7WPYdPIAeyiVpPBl/kKwPWN3vmqaAp1cM6hjodUQo1
         bgwGOWHlenKk7CUpJ3hgItT/E6BMHIvTmFNcj/PopogwTZofr+Lo9B6LvKFO7iInvoo9
         vknYktIE/Gz86g1gXAlpTI4/6A/zmFnSaFgcmpBg9aKJVDLamQE7Um3Dx5yjGzMU9NaY
         zhlg9Wl03SIQ1kELQCjEEtk3x9Yk384bqFwISeRnnOhLXDDMN28mIaw2LPVvbhqABLHH
         x5Ow==
X-Gm-Message-State: ACgBeo2gKDOHD/O84mZU+BCLXF9CXkAMuXtk2sBfsmOfRVfravxU1hQT
	/iHAHPGjokxb7JCnTR8fTjpEaj0xEbk=
X-Google-Smtp-Source: AA6agR5IHyLOVpCYPsGCTl1WAh1PLHzSkOgAmQAkkvI/LDvSxkU9pCXJyMghFPF7B9PD/jn9WBQElFJpekI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:a005:55b3:6c26:b3e4])
 (user=surenb job=sendgmr) by 2002:a25:94b:0:b0:68f:4e05:e8f0 with SMTP id
 u11-20020a25094b000000b0068f4e05e8f0mr13319593ybm.115.1661896195289; Tue, 30
 Aug 2022 14:49:55 -0700 (PDT)
Date: Tue, 30 Aug 2022 14:49:01 -0700
In-Reply-To: <20220830214919.53220-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20220830214919.53220-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830214919.53220-13-surenb@google.com>
Subject: [RFC PATCH 12/30] mm: introduce __GFP_NO_OBJ_EXT flag to selectively
 prevent slabobj_ext creation
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com, 
	ldufour@linux.ibm.com, peterx@redhat.com, david@redhat.com, axboe@kernel.dk, 
	mcgrof@kernel.org, masahiroy@kernel.org, nathan@kernel.org, 
	changbin.du@intel.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, arnd@arndb.de, jbaron@akamai.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-mm@kvack.org, 
	iommu@lists.linux.dev, kasan-dev@googlegroups.com, io-uring@vger.kernel.org, 
	linux-arch@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-bcache@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce __GFP_NO_OBJ_EXT flag in order to prevent recursive allocations
when allocating slabobj_ext on a slab.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/gfp_types.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index d88c46ca82e1..a2cba1d20b86 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -55,8 +55,13 @@ typedef unsigned int __bitwise gfp_t;
 #define ___GFP_SKIP_KASAN_UNPOISON	0
 #define ___GFP_SKIP_KASAN_POISON	0
 #endif
+#ifdef CONFIG_SLAB_OBJ_EXT
+#define ___GFP_NO_OBJ_EXT       0x8000000u
+#else
+#define ___GFP_NO_OBJ_EXT       0
+#endif
 #ifdef CONFIG_LOCKDEP
-#define ___GFP_NOLOCKDEP	0x8000000u
+#define ___GFP_NOLOCKDEP	0x10000000u
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
@@ -101,12 +106,15 @@ typedef unsigned int __bitwise gfp_t;
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
@@ -256,7 +264,7 @@ typedef unsigned int __bitwise gfp_t;
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
 
 /* Room for N __GFP_FOO bits */
-#define __GFP_BITS_SHIFT (27 + IS_ENABLED(CONFIG_LOCKDEP))
+#define __GFP_BITS_SHIFT (28 + IS_ENABLED(CONFIG_LOCKDEP))
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
 /**
-- 
2.37.2.672.g94769d06f0-goog

