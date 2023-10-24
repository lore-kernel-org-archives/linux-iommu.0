Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C1F2B5EC
	for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t78uKpYs"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-d9ab79816a9so5381130276.3
        for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 06:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155241; x=1698760041; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zb+0nW/ZZ6NW74eJtanLAYQ/ebma3WHtobF3vZ6u4HE=;
        b=t78uKpYsUUJ5AB7n6+frhg+K9gbOqP2ZMgIlnbAOtw39WYVxCpmmmu8YjUOz+QeTuk
         dxK5qjbXFwKsqOM3Jlc9nwjo95nqn9Zf4bpE6o0G3AvmZc60hhFf3uXiA/P4Ojjfg1/I
         tjE4S+72wfSFImckQZBojX5tmyPxoQ/h2YUVkfKFqvUh+jdWKO5pQHII1RI7CzkSS8iR
         ArhU8YoXkVK8LNs2uOKHhP7GiOCCDYKyxbts8Tx/3u8KDvA5887eJJ46tGfH/Ib87jhm
         7iHsjJgjg0Fp0A3ezZJtgOK+MiZKva7SV+1U+wy/bxEAOq18tfvWRjsChisoDt0pG8MU
         cnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155241; x=1698760041;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zb+0nW/ZZ6NW74eJtanLAYQ/ebma3WHtobF3vZ6u4HE=;
        b=agCh47MO0GxMOFRcFLXHQrAj92ERI/iw0sgDy8oGYVGY0X8iGiBdbCkV0id+aofEt3
         9mLTtVSJRNFOIgtGBc5OtiB9qQY7KROrdTgoOEsgj9Kqrzn5WGPapzxO5JEC4Tim5KYT
         Sbf54HbqfeQAxJjZmYlUksRq7QlUrYRy1JTKqbKsvREX0n9SndaLr82GGKk0zs/qwMDm
         uqGLUVHWi1mjMyLp6beKRiQlXGSLkaEPLZ6yj6e2ypiHvvoMZd6HWqrSUbPeZY4D0aVq
         YO3ObVcXn5Ichtov8m75ziJz+9O6aZjg6LWpDSpTMxoc+j3H73cJirTLNqUxsVyBblvA
         QraQ==
X-Gm-Message-State: AOJu0YxgLu29gF3sKSBkDyD0pDkGtKlqD2WYrB5End6zBvLkDmzIqbUf
	dB6Sl3fVqjJdjp2fk0PzXtNm/Q0xMvo=
X-Google-Smtp-Source: AGHT+IEpPcNXSaLopMEVj+acIv3rs50iHU0ea/y8V1UNdWnab+iEcPBoSFwF1WABxkknLPWrzIDF+i6tstI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a05:6902:544:b0:d13:856b:c10a with SMTP id
 z4-20020a056902054400b00d13856bc10amr261040ybs.3.1698155241467; Tue, 24 Oct
 2023 06:47:21 -0700 (PDT)
Date: Tue, 24 Oct 2023 06:46:15 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-19-surenb@google.com>
Subject: [PATCH v2 18/39] change alloc_pages name in ivpu_bo_ops to avoid conflicts
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

From: Kent Overstreet <kent.overstreet@linux.dev>

After redefining alloc_pages, all uses of that name are being replaced.
Change the conflicting names to prevent preprocessor from replacing them
when it's not intended.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 drivers/accel/ivpu/ivpu_gem.c | 8 ++++----
 drivers/accel/ivpu/ivpu_gem.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_gem.c b/drivers/accel/ivpu/ivpu_gem.c
index d09f13b35902..d324eaf5bbe3 100644
--- a/drivers/accel/ivpu/ivpu_gem.c
+++ b/drivers/accel/ivpu/ivpu_gem.c
@@ -61,7 +61,7 @@ static void prime_unmap_pages_locked(struct ivpu_bo *bo)
 static const struct ivpu_bo_ops prime_ops = {
 	.type = IVPU_BO_TYPE_PRIME,
 	.name = "prime",
-	.alloc_pages = prime_alloc_pages_locked,
+	.alloc_pages_op = prime_alloc_pages_locked,
 	.free_pages = prime_free_pages_locked,
 	.map_pages = prime_map_pages_locked,
 	.unmap_pages = prime_unmap_pages_locked,
@@ -134,7 +134,7 @@ static void ivpu_bo_unmap_pages_locked(struct ivpu_bo *bo)
 static const struct ivpu_bo_ops shmem_ops = {
 	.type = IVPU_BO_TYPE_SHMEM,
 	.name = "shmem",
-	.alloc_pages = shmem_alloc_pages_locked,
+	.alloc_pages_op = shmem_alloc_pages_locked,
 	.free_pages = shmem_free_pages_locked,
 	.map_pages = ivpu_bo_map_pages_locked,
 	.unmap_pages = ivpu_bo_unmap_pages_locked,
@@ -186,7 +186,7 @@ static void internal_free_pages_locked(struct ivpu_bo *bo)
 static const struct ivpu_bo_ops internal_ops = {
 	.type = IVPU_BO_TYPE_INTERNAL,
 	.name = "internal",
-	.alloc_pages = internal_alloc_pages_locked,
+	.alloc_pages_op = internal_alloc_pages_locked,
 	.free_pages = internal_free_pages_locked,
 	.map_pages = ivpu_bo_map_pages_locked,
 	.unmap_pages = ivpu_bo_unmap_pages_locked,
@@ -200,7 +200,7 @@ static int __must_check ivpu_bo_alloc_and_map_pages_locked(struct ivpu_bo *bo)
 	lockdep_assert_held(&bo->lock);
 	drm_WARN_ON(&vdev->drm, bo->sgt);
 
-	ret = bo->ops->alloc_pages(bo);
+	ret = bo->ops->alloc_pages_op(bo);
 	if (ret) {
 		ivpu_err(vdev, "Failed to allocate pages for BO: %d", ret);
 		return ret;
diff --git a/drivers/accel/ivpu/ivpu_gem.h b/drivers/accel/ivpu/ivpu_gem.h
index 6b0ceda5f253..b81cf2af0b2d 100644
--- a/drivers/accel/ivpu/ivpu_gem.h
+++ b/drivers/accel/ivpu/ivpu_gem.h
@@ -42,7 +42,7 @@ enum ivpu_bo_type {
 struct ivpu_bo_ops {
 	enum ivpu_bo_type type;
 	const char *name;
-	int (*alloc_pages)(struct ivpu_bo *bo);
+	int (*alloc_pages_op)(struct ivpu_bo *bo);
 	void (*free_pages)(struct ivpu_bo *bo);
 	int (*map_pages)(struct ivpu_bo *bo);
 	void (*unmap_pages)(struct ivpu_bo *bo);
-- 
2.42.0.758.gaed0368e0e-goog

