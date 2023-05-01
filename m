Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A6B5698
	for <iommu@lists.linux.dev>; Mon,  1 May 2023 16:56:13 +0000 (UTC)
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-b9a7550dca3so4767457276.0
        for <iommu@lists.linux.dev>; Mon, 01 May 2023 09:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960172; x=1685552172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jz3+CZtZwJ9/tSYfHBM/2MHA9DEGGjB4zlxzO096/9Q=;
        b=Glr4JSHsTmaAPI0AWP0PWNaIttgzeyDzPQx4tjZhzhm0zZ4p+1GCcCC3c3r4aXKXSp
         WIW7l4ONjqrOBXvjUIVll03e3w9s+YRWlCSxmsKNK9xzzAcM54D0O3+CWQoKF/ytzIvC
         kOX+0OA2rpltLDjWT1I86SdUtJ7gM1/iT7nXNjbfE5eIm0GIboQlBljhXdjDloTQNmLw
         70IARjApWsmBCF7eSF3LKPA2bTZVurXLcycCJn2u8FXoQc4EQGTI1K+d32OJcow714/u
         3R8ajXD58HPiHypeEQaSKmOGWRsxZiDT+trPafMrQwqkk9Lr9LEGmo4kscoUpmICusqi
         Lbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960172; x=1685552172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jz3+CZtZwJ9/tSYfHBM/2MHA9DEGGjB4zlxzO096/9Q=;
        b=L3b+gTx2ftb+uxaFqqIaRIZwotF9QZ9aH1sqm/GogzkSOpsOINfdiBkcDY7xykg3w7
         YuenhgelOPwQwDIfq42n+K4pRn6Pkxh+Nc78L0T6cGzEcPymneuxmM//cB9ZCjpH/q2o
         Mn3x0mlkZf3A5rDcfvLS2emkjBTXljTSWx2woryeVYRmXcUboFvoGaHE9f5jq5wrUimN
         hSzBtLRAM+CLzj61VS6ZC/3LvsGcu8e73f6EDPmO4SWEp9BUvyVWu1NqJOMZS4AbK4By
         c/JCFOooD9p8b7/AtP8FGSJWRKLQnoDjyUbJ03Aya9KImrlSHMaFSaPsCdRrZvoZNUjD
         yJpg==
X-Gm-Message-State: AC+VfDwS5IAXj/UwVut62DxBEn8pnLgEzpmWCM0WvVuo7sOCD7AJyomX
	RDjvr2n2LYbVx1c/j+JwNxo/yD4G70A=
X-Google-Smtp-Source: ACHHUZ6QTE71DtRYGwVPEik8Avnxkjne4lD1OdWVt1RsKvPsz461K/ZnyuUPS3XSYPpuvwa5uVYwtV8n9po=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a25:1388:0:b0:b95:ecc5:5796 with SMTP id
 130-20020a251388000000b00b95ecc55796mr5071137ybt.12.1682960171977; Mon, 01
 May 2023 09:56:11 -0700 (PDT)
Date: Mon,  1 May 2023 09:54:38 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-29-surenb@google.com>
Subject: [PATCH 28/40] timekeeping: Fix a circular include dependency
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

From: Kent Overstreet <kent.overstreet@linux.dev>

This avoids a circular header dependency in an upcoming patch by only
making hrtimer.h depend on percpu-defs.h

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/hrtimer.h        | 2 +-
 include/linux/time_namespace.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 0ee140176f10..e67349e84364 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -16,7 +16,7 @@
 #include <linux/rbtree.h>
 #include <linux/init.h>
 #include <linux/list.h>
-#include <linux/percpu.h>
+#include <linux/percpu-defs.h>
 #include <linux/seqlock.h>
 #include <linux/timer.h>
 #include <linux/timerqueue.h>
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index bb9d3f5542f8..d8e0cacfcae5 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -11,6 +11,8 @@
 struct user_namespace;
 extern struct user_namespace init_user_ns;
 
+struct vm_area_struct;
+
 struct timens_offsets {
 	struct timespec64 monotonic;
 	struct timespec64 boottime;
-- 
2.40.1.495.gc816e09b53d-goog

