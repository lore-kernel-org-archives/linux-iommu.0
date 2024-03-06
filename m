Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDAD1482EA
	for <iommu@lists.linux.dev>; Wed,  6 Mar 2024 18:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749522; cv=none; b=FdoUffd9zxta4Hr0/8hFH/1PZrDolKO11jQ5ziMCDx9+aAvwZz242aN021wBm88hFTJBX1RVYXEgjt+fvSj99J/XeX0cTzx3QtpvIx+5Y0hY5T/VQJO2+1nhPlT+7IjwYrsjdkwWVq5X8x9ToSws3KkMNbQLrNDUMY2pHidZT0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749522; c=relaxed/simple;
	bh=LlSWfVWs0H6gxkcBojSTETeqB1brvmDhPGR9FQrCvgY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MB69hHEbT/UPYqI6H/x1q9n3uqeY7taPlT+OIIASDEX0L957ZKPQysH9OeXy2H2f0UGAXTM9uxWBCu2VurCMe13ihGHUdyktYF1RoxKsHa1nGIPATonNJJf5/gHJx9pkibbuI8qipMMm/9r5D+8+Aj81edA2MvVkZ4qI5h756HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YMSllxgz; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YMSllxgz"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60832a48684so461137b3.1
        for <iommu@lists.linux.dev>; Wed, 06 Mar 2024 10:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749519; x=1710354319; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OEAYBW3Z4VXc6aDoxC6XGC2RO1GGkHEsC5P6UG5rRTs=;
        b=YMSllxgzAVtZsgDOJ+ZlbBJiyGZzQAktbuM6afC4JQIjzgRlQSuJu352FSxil+rHSt
         ssuYDA5vo9vLj7Nmym5yQXegXYQ7ejo6e9m/+rZwHGE+D4CLBGLpKMQpBu7fGkkKpOlQ
         XI1ceNHAzi8qABi6p0kAgnUqOBi2RcHVBGaq+GM4Kr3iQ6aMK3dfAcPXSsY+xu+O/UWI
         5/EEOs2ehWedPj0pypxYQY2fO+jxAFUShCoh1BmdvrAGq1cb4DBrFr5HJt45oS+/aH65
         Ae7c/y6ybSQ3l6IlVwx6CmWrTAuJ9kkfXNXsw0ulKFuqnfLAICrxsgiLtzR3aG3IPfWG
         v/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749519; x=1710354319;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OEAYBW3Z4VXc6aDoxC6XGC2RO1GGkHEsC5P6UG5rRTs=;
        b=GGrfy+OZP+hEqeiCl1fTN5Tn/jfuvodqC5YnfQ87HcDn7QSrBNuxAKpV/3qACbicXs
         aDOhGYpEbVsoNzzJIMbzoyXvITsuWUyB5YzP/uRdc54B8JAo6PZ0alDkZdUnDRATU2HK
         fVdcfX9whhFww79eDScWZ5GiXxIr3ldQQZA77PIUdwDT1bUs4Y5Qchd3OO8Ww05hh1+n
         cCt2HUazjNSZ/6sOo3629E0RCbeD0qG+h24uDH61chXdqv8UthdwmhZAk3G7bPBtPhRA
         VE+xJmo4fB8UPfSquTjOx//hNARRJi86pXb+O5kP2bRcj2WC+yQAKHZ5pvGeNsaNW03W
         ENYw==
X-Forwarded-Encrypted: i=1; AJvYcCVtOzBbIHzv91rON1bmU0pNBDXTuoijNt3vc+4AAcGZp0iT0swvjK/qCLNEGKlJLMBt8BNuQR30dfb+O409+996e2PgiCw=
X-Gm-Message-State: AOJu0YxqfH4zCQbDD06blkfezZem6lKf0ko8/Mkc/Yr9Mruv1zhbTZ8L
	Qc/SSvUW/3r7F0OUUZgpPZSUOHCr4dcam8w5yf4k7Grg6FwK8B5wIBu1lDQI1o8MiewM/guBlAg
	/3w==
X-Google-Smtp-Source: AGHT+IGRA5aw0Cx2t1JPgn1w/V3cVE9EShRxIkrJJQcyCjV/1XkZdkPnLkct9rPYqab5CU3NhvDSCALRADo=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a81:9950:0:b0:609:4d6f:7c0b with SMTP id
 q77-20020a819950000000b006094d6f7c0bmr3566046ywg.4.1709749519078; Wed, 06 Mar
 2024 10:25:19 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:14 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-17-surenb@google.com>
Subject: [PATCH v5 16/37] mm: percpu: increase PERCPU_MODULE_RESERVE to
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
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
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
2.44.0.278.ge034bb2e1d-goog

