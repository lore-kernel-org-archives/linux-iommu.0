Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D14C568C
	for <iommu@lists.linux.dev>; Mon,  1 May 2023 16:55:57 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-b9a8075bd7cso4836941276.1
        for <iommu@lists.linux.dev>; Mon, 01 May 2023 09:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960156; x=1685552156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ia0f0ycGZD+jM5YS+jW1bQxvUpAwQcUQoxrBuJXYMcE=;
        b=5JJhV76m95/YBoZ/xZu42cKOJXhgJORCHh7GQ1vgchybA9Jz2W8JB87J32lzEHqVAD
         5MpwShEQTLsgetTJKB81Ya9oYfauOk73A+wkcp3YnAqkuYR2uGLglMtljDk1oXUFeXUF
         eg/dqf1WTTeod1mNhPnzcjxqEJmrvwX1WQABkeXqhDWaPCFp/KOIQdT6Kd/lNmNqK8uA
         jO52yQ6iu7pCgMF+oglZnvEtlqmI75FROfYcJYL0lGgLhZXRGGNj8gM5KHULwpV7DXj0
         IQGmZzm/JuCCa0BNo8vc+UrvY2fi7yQcbqUa8T0x4PnakvTfaxlxsiA9vMtpl/EDSZYr
         7ZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960156; x=1685552156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ia0f0ycGZD+jM5YS+jW1bQxvUpAwQcUQoxrBuJXYMcE=;
        b=PzEiRlXpBiXdTJ7lWSy9glWejOjnNQminlLJTBRGl5d+U+gS9LgDCCwTBRikROwhfN
         mlTsAxRCoCFPIezBP94qmFJlHgPRE7vlPOyrDkr+Q/imeVjAGLh/6wPL87fXK4i8IvlT
         /ntrRmtqVr0koKhtvTWahCNX7BBBsAqGM2aAEQEFl1Zkz3fgJeiTZnyFgVQMy3HkfCly
         EVUK13xPSgx9c0rSBHvwri/kjtgx9LqeTBD4pdrSajaAS23NcF3veUQuK/n68w8+BH14
         WfK+wbX4vTmqQuLL64FTkQrm+ZnvA/i6BIPFjiYMwiaeXg89HfK484pt649/AYcljgSU
         me2Q==
X-Gm-Message-State: AC+VfDzII2XwnBc0Vhe5a6XuGzg6NvhhgsEfQGAkbio+kpM3/cbuoeq8
	wZQyAb9cKiZx11F58UlFHNY/8k/5Wg0=
X-Google-Smtp-Source: ACHHUZ7AZgI8CesVN/W1kPgcDGVmfHbMCJ0zKZ8nFHzmTASKNb7LK9gLjq8w5luIVN/1afaizYlyRnGrI6c=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a25:5d1:0:b0:b9d:52cf:4a6b with SMTP id
 200-20020a2505d1000000b00b9d52cf4a6bmr4308920ybf.1.1682960156135; Mon, 01 May
 2023 09:55:56 -0700 (PDT)
Date: Mon,  1 May 2023 09:54:31 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-22-surenb@google.com>
Subject: [PATCH 21/40] mm/page_ext: enable early_page_ext when CONFIG_MEM_ALLOC_PROFILING_DEBUG=y
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
index eaf054ec276c..55ba797f8881 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -96,7 +96,16 @@ unsigned long page_ext_size;
 static unsigned long total_usage;
 struct page_ext *lookup_page_ext(const struct page *page);
 
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
2.40.1.495.gc816e09b53d-goog

