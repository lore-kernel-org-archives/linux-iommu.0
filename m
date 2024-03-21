Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B727513792B
	for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 16:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039068; cv=none; b=Seunjz3SNvsWgOx2QsRPkpTQSHfjhx35JTMR+UjuvfJXUJxorGqHJmlVtMZVjnQDg64TEun/FHE3FwS7ArxeTAkXk9zolrBpkPqzh4tcEAm98mAqcb+MYGM8PvADaUTTWAr7P6t+n2Jnwb7sZ+GOJYliCxBl/Clxg7OwULsZ/4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039068; c=relaxed/simple;
	bh=z2eJy0t2bdkmakMZRyMHx8Zh+sPp3sJo51GJl0bffFg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jkGbzA7Br9qvw3vJOfJSATsDFiQosZVRSbHMkv8KHy5fsKTEcPEjQPMZ0qq3cODFUgIks4X6p1jN+q8LtUPmshvj1tuaTzxbaYqaQbyAqLsyNFf2yCKAOYvP+HKp3n9J/rFPsDZsH045a7lhOXL6mv9DflGDB5/NBfHR2ChR43c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CLdnc/Bd; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CLdnc/Bd"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60ab69a9e6fso28861587b3.0
        for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 09:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039065; x=1711643865; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=adETXft81L3mg8VeiLZhJ9Sn5YTIW37aD8rIZRQJCFY=;
        b=CLdnc/BdwhpJXp8+xufakHXuKlCzTppkt8jPASez/vkFE8lhtW597k/tTZZtOC/U6u
         /Ae5DF1xYQsHSbeCxKw1Oa3hV+dDFlXQgQdZ8WJI8I7DdkMHqtM83YhAZQiYnE/zWoX7
         MkF2sS1/cA6vBnmhPNJJAEca6HR8dw0gb7YgoQXMbo7ysZBXOQs6GkOorVZSCPUHL/mC
         lgFbGOqI6yspWxWfM7iBcml7tALKoGDuo9mccV8H9T9qRMmZknsX+zPAvMewzCNJ4bZJ
         SjGUKVdbqr1xR0UndbUN3EgP+sBvUBA5LX7uuNGhcApitwm7W/4dkb/mWfDWyKEUODQ1
         aN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039065; x=1711643865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=adETXft81L3mg8VeiLZhJ9Sn5YTIW37aD8rIZRQJCFY=;
        b=vPT4RUpzl7Ju0wjrrKQMSAZoDLkdYRmj5XFcgYp4QaiDcWsfthYKbuAbQUXib7V7LM
         elBvLvpXhKSQHFZBlIniB+M9il02h95t6I5AoTjVWnxa6qHH7uGcKMrcqHTrixd2BFze
         9olmh9Sq39EFjOVVd+CBoJzr6skpjSD7jKmhFyxUFU0332Wb02aKUgAvGL9dCwy6wNmf
         p50W5wwzuQZ/kXLVTa34lI641cWOhH2NT7Yce7aaZ+sZEs0lrM1xq3bL+X6IJ0vTsTJ0
         9NGM7db8lMnlSXs/trNNe9qt7NJL2K5bpi2J7oWTvy5yCvephN7Xei+XYRokySeR7Ton
         80SA==
X-Forwarded-Encrypted: i=1; AJvYcCUh2NNcG5cNg9KWsuC0NeWYv2CmeuyUktOqxh3MN3p6O5h9RDSM+MwREi9ez4X/aDrphkazSRoQOxv8zDQnY9wjKI5p7/w=
X-Gm-Message-State: AOJu0YyAUrNXKbKevEdcjFw3mjCFlh26ye4vWmjVj2IqbiUkOto/Ga3t
	Ao3P66mp0+NmY647pq0LQZLhx1BeT78tY6WKyrE9A1CVjBMkvaKuOmhj1ZJ16YHAD2EBCkahRfE
	z/A==
X-Google-Smtp-Source: AGHT+IEpbeHGmaH4ZP6HrzXLjRbRGOQFlxFrFvHpCJT+qt/SUASA+RVr+wlFFHpwWsqOIXtYDNaLSozJTUQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:690c:b06:b0:60c:cf91:53e0 with SMTP id
 cj6-20020a05690c0b0600b0060ccf9153e0mr3628ywb.1.1711039064823; Thu, 21 Mar
 2024 09:37:44 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:38 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-17-surenb@google.com>
Subject: [PATCH v6 16/37] mm: percpu: increase PERCPU_MODULE_RESERVE to
 accommodate allocation tags
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

As each allocation tag generates a per-cpu variable, more space is required
to store them. Increase PERCPU_MODULE_RESERVE to provide enough area. A
better long-term solution would be to allocate this memory dynamically.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
---
 include/linux/percpu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 8c677f185901..62b5eb45bd89 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -14,7 +14,11 @@
 
 /* enough to cover all DEFINE_PER_CPUs in modules */
 #ifdef CONFIG_MODULES
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+#define PERCPU_MODULE_RESERVE		(8 << 12)
+#else
 #define PERCPU_MODULE_RESERVE		(8 << 10)
+#endif
 #else
 #define PERCPU_MODULE_RESERVE		0
 #endif
-- 
2.44.0.291.gc1ea87d7ee-goog

