Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF832B759
	for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FCUMlMTv"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-da05b786f1dso176317276.2
        for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 06:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155248; x=1698760048; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zC2/AjWbzXkwFGJu5UOviuzr4L4X1GYNGPTyCuvFw8o=;
        b=FCUMlMTvqOCJuWQFAhxlLUlyOKYIgI8bVQ5PHtFDUurSHYRJAUriZuJcffMl8M51yF
         SuPYbjOrzmU/0B//FGXfYZ8VSSZd2hez0gMmAJvXzm58mtZn1IbhNsye0JOtbt/0kGDA
         +Gp9ttQ1pXF7nIwv9/1uh6VCJF003XJ/xPDhsr7S352EJqTXs2pfSQVV4xnb6+d0OoM/
         2keqoAHdmXp9WajMrF9es9DTMamN+y2wa3RfMzT81XRBXQZdV8EifDKxFRuPfv1FknYi
         KSNWbCRnvkUR1HIXnhk1V1ShkDM+2Ntz6dv9dvsFD14NADcrN2RJqClJUcFOogpvOrN1
         CJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155248; x=1698760048;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zC2/AjWbzXkwFGJu5UOviuzr4L4X1GYNGPTyCuvFw8o=;
        b=XJVnL4SuSf4RgI15qOultTwP1P/t6CiJGcxzL7U6RWvpmFbsEmOJrArvYmSHZGQGR1
         citdHOjAEr+cPPLGWf2PMBTZP1EfYp+fDXQZCgiY/9FjPydpFxlEA9aKXdW3VG7HQl9M
         t+Gfk3hsutTD/35kiftja+wJOxk0Cx1kUF2GlR7rzK80BrNb/HAYFay6XPWagChE3p7N
         7NWybnPPPyTisYuTWQi4PSoARynd3R71yDYqnNPZv/tbmhay4VbsQ+QoaXAQ1YCg1pKy
         yR43jEgEfurg/pLX82Wv36Vdp2eOW3h9U61UANPoTJ+e5LiKZt4QMObqxOfuioI54XQ6
         bZlg==
X-Gm-Message-State: AOJu0Yx1LapL6VgHVP4UmBez56OiC8eJ/xVcLufhnFwQeybVQJ0X8B3i
	boVdu9hthgaQrSNWoJXOt9NAiSjaS98=
X-Google-Smtp-Source: AGHT+IFtIla7jN3qQCOM5jBjQINYCYH8n10kTFpUDwIK13I4RwREYyTVERaiA7ZHusZIP5/hSujmrJfw8JM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a25:40c7:0:b0:da0:289e:c056 with SMTP id
 n190-20020a2540c7000000b00da0289ec056mr61156yba.8.1698155248287; Tue, 24 Oct
 2023 06:47:28 -0700 (PDT)
Date: Tue, 24 Oct 2023 06:46:18 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-22-surenb@google.com>
Subject: [PATCH v2 21/39] mm/page_ext: enable early_page_ext when CONFIG_MEM_ALLOC_PROFILING_DEBUG=y
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

For all page allocations to be tagged, page_ext has to be initialized
before the first page allocation. Early tasks allocate their stacks
using page allocator before alloc_node_page_ext() initializes page_ext
area, unless early_page_ext is enabled. Therefore these allocations will
generate a warning when CONFIG_MEM_ALLOC_PROFILING_DEBUG is enabled.
Enable early_page_ext whenever CONFIG_MEM_ALLOC_PROFILING_DEBUG=y to
ensure page_ext initialization prior to any page allocation. This will
have all the negative effects associated with early_page_ext, such as
possible longer boot time, therefore we enable it only when debugging
with CONFIG_MEM_ALLOC_PROFILING_DEBUG enabled and not universally for
CONFIG_MEM_ALLOC_PROFILING.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/page_ext.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/page_ext.c b/mm/page_ext.c
index 3c58fe8a24df..e7d8f1a5589e 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -95,7 +95,16 @@ unsigned long page_ext_size;
 
 static unsigned long total_usage;
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
+/*
+ * To ensure correct allocation tagging for pages, page_ext should be available
+ * before the first page allocation. Otherwise early task stacks will be
+ * allocated before page_ext initialization and missing tags will be flagged.
+ */
+bool early_page_ext __meminitdata = true;
+#else
 bool early_page_ext __meminitdata;
+#endif
 static int __init setup_early_page_ext(char *str)
 {
 	early_page_ext = true;
-- 
2.42.0.758.gaed0368e0e-goog

