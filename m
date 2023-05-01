Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E553C29
	for <iommu@lists.linux.dev>; Mon,  1 May 2023 16:55:33 +0000 (UTC)
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ab0669d9c5so868575ad.2
        for <iommu@lists.linux.dev>; Mon, 01 May 2023 09:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960133; x=1685552133;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AxHF9zQp9trScXtaAl0tt4NG3XQrBAxJQ/ayq1tkXak=;
        b=tJm7WR8AdSF6O5qWHaKU1D/ysKeRzFc3FiZT54ezTvTsHezyhXNB2hdIvEgmyHbI2P
         coE7FK11G2KLLdp82iDrBRtaK1XJdqiYBBu7Bzgc0CjbScOB1xMrdceY1iUR8li4Lunu
         QxqPry7kkIxD8xjnoCiSp2i1c6RgrlFShVMk73jBCUlai0Pj6tzx2wQKCiGt42ycRlUY
         Q6iiOWoraxytw320styP6cKZ8CPR54fhZHUXwBTe18PxhhkTB2K2EgrVvGyA9dqorw8v
         3z+UXLp0f4HuyIt3egDvW6I8g1tJRbXw06CphA32uVzlUNPHB3VM7B/5KkyjlKHh6bO/
         vApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960133; x=1685552133;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AxHF9zQp9trScXtaAl0tt4NG3XQrBAxJQ/ayq1tkXak=;
        b=b4Lm+SAnbScBq1xoZS5bhiwedTS5EiXxC82Ybjf+wNNTmSGiJfN3iHwxV+Jch8FFJl
         UcJFpn6zT2QhxlIK8j/knTciNun7R444ebtrcup9BIeEsZaqCkfluVOsAM8fQEUIiI1Y
         6EaIb+PisltDWSsNNO0p7aBa8pEQCYnIZ4cgui1Oion8j5Lx17TBHc1CAcnip5C2R74o
         s2KaCc6Nlb4Enz3O6AUFNctmuIWQicDzL+f24a9WVMEWT7u7hgDgukZvRySYzr8QBHL+
         0Tcjr103e+OFu3MdbZzvR2yQU296NRteJa5TuJ89ShVBpQ8dHKr+Qbe51GWh+B5XmhNR
         aVvw==
X-Gm-Message-State: AC+VfDyx3issH2kYI8e5xG4527DFfdRgojq/XVAA9rLYNC1GFx70KpEZ
	TqdM9+XL9C+NGrw4gWZeQLT+L0IK+Z8=
X-Google-Smtp-Source: ACHHUZ40vYgpSBKgnsqUKG4z7dBiWLR/NY4OPgzSeG2TkOgPzabfXY1XoiHkCzsuVnUnxnzRXGzvUa1mMg8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a17:902:ecc5:b0:1a6:6bdb:b542 with SMTP id
 a5-20020a170902ecc500b001a66bdbb542mr4742101plh.9.1682960133566; Mon, 01 May
 2023 09:55:33 -0700 (PDT)
Date: Mon,  1 May 2023 09:54:21 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-12-surenb@google.com>
Subject: [PATCH 11/40] mm: prevent slabobj_ext allocations for slabobj_ext and
 kmem_cache objects
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

Use __GFP_NO_OBJ_EXT to prevent recursions when allocating slabobj_ext
objects. Also prevent slabobj_ext allocations for kmem_cache objects.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/slab.h        | 6 ++++++
 mm/slab_common.c | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/mm/slab.h b/mm/slab.h
index 25d14b3a7280..b1c22dc87047 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -450,6 +450,12 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
 	if (!need_slab_obj_ext())
 		return NULL;
 
+	if (s->flags & SLAB_NO_OBJ_EXT)
+		return NULL;
+
+	if (flags & __GFP_NO_OBJ_EXT)
+		return NULL;
+
 	slab = virt_to_slab(p);
 	if (!slab_obj_exts(slab) &&
 	    WARN(alloc_slab_obj_exts(slab, s, flags, false),
diff --git a/mm/slab_common.c b/mm/slab_common.c
index f11cc072b01e..42777d66d0e3 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -220,6 +220,8 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 	void *vec;
 
 	gfp &= ~OBJCGS_CLEAR_MASK;
+	/* Prevent recursive extension vector allocation */
+	gfp |= __GFP_NO_OBJ_EXT;
 	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
 			   slab_nid(slab));
 	if (!vec)
-- 
2.40.1.495.gc816e09b53d-goog

