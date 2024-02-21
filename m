Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F17D1419A2
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544494; cv=none; b=CgGywF/iYWBWG/x/1xyD3ZZWoIdK+yMaGnuIqiTdAfyPJtCmxPF5Wr05Qn8LnlGjhAjnODgJtS94/U4GsVhHP1/F82NRChmrJO3Ckqdedu1XlX+NXLqQ6m/Ijko2kEpw52yklBfwlEKzMe9cDc3MlMd4oCgfHcXWZGKKUr4m7/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544494; c=relaxed/simple;
	bh=V79ceBwKz2YCfA8gxo6SKRHzpt3BUXzSbfgGLHuE1lE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RTneG/iL+/TT3bHpA8mY2W0jiJ3e6H5HUjS7LnWRgp8oXUG6E0k3aQGDS/GVQzUiwv+SSpkk+EwOmPT5o07c8wIwOOE9pLZh84XUJbJzmKrb1xRdp0CShV4Hcg2H3YFY4TsBKywpmvc7gwKIIXYz7dN0IMhA0IXybuHa85kgQ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yN6DfX3z; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yN6DfX3z"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608749ea095so2232727b3.0
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 11:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544491; x=1709149291; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GoE6bGSaoBD7i3pA8lR/Run1pysn6CP5hI9CoxzKmn4=;
        b=yN6DfX3zY8XsrxwTYGEECy/gP1s53m+jtfNZsO00UutrJbaaSljshDkwfIS3xgOrp3
         mf+uUCgaA6hYpJw5wPHE8Mt97CBa3Z6bXe2PtW079rv/BLAZd8OjqozyrA8ES7hEpVAn
         RcRCWu7uPHHycaIJWRj3PgyG6YvNOpDeN6x3mHSImIPKJygW8LizuGXnqHHckGuMtAFh
         MbWt0bdoRyG/aqKIsv81BXfogDzZbVH2CNLQiHxgvYceAwrgdTeJ60pXQbC6p5f3pbmJ
         x/+nNfEw2agHZJI269d02RxkwVY80JOLdCY7XTj5PS9CuYAZvCUsWXoJBt1i6tV0ORUp
         7h9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544491; x=1709149291;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GoE6bGSaoBD7i3pA8lR/Run1pysn6CP5hI9CoxzKmn4=;
        b=ZGgAlDhDP4e1gAA8peF9q7Yn2cvrAlJEjK/SJ70vv2x3GGy4a4xsJKFz1wLhWI97jH
         6jQJiWyAHiGijCd7qhkiP+L72lpxa1zkC1SnH43AcC6S8+ux/XL2eJF9weTbxjbNDTfw
         Z7JeodNyYMfgwR9Jo1O/QqOSunsqMI5qT+mtwFBUX+vlyFQWViiVJJ/7xGUVNJoQmGnE
         Dn2AMI85h74RF++pHBwZfCsoZ7Mlj253vHjUVUXUK9pqp4Y7Wrl2iLs5b1Jojwlp40gy
         8UnJechbULXL8P/EjxkTlD4V+uqTDGCUqOHNo70fWmHHA8ygtD0YxLwH9X42PyeDkFiR
         Mq1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUI2SV+1VSBKq0JBO5mAi0GDb3wnertQj+2RklLZewtLCSE3l3rMx7mgq4WwmchK/OGvwndmhHO3TOTUfKsg0bGH+WM1c4=
X-Gm-Message-State: AOJu0YzEpsQm07EvJfImO5bFaqgvZDz6tVjuRG2i5rMKl8XioL7XV7aX
	8rZWCbidnowmCvz4DofdL7oMohU7QtkxBCmAhBITkrUwYsz9W98pW9yrkiVVq2yQIVtOgN2X1Mc
	k2A==
X-Google-Smtp-Source: AGHT+IG2dizM99WzNXjXCm4NRVCQCOVTKSh+Pv+zsrsy5Io1Fqept1ZOsQ0OERnmDAPF2nVohKm6aRgWd5Q=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a05:690c:fce:b0:608:7c19:c009 with SMTP id
 dg14-20020a05690c0fce00b006087c19c009mr105006ywb.0.1708544491160; Wed, 21 Feb
 2024 11:41:31 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:29 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-17-surenb@google.com>
Subject: [PATCH v4 16/36] mm: percpu: increase PERCPU_MODULE_RESERVE to
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
2.44.0.rc0.258.g7320e95886-goog

