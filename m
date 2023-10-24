Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAB52B5ED
	for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1whbu6fc"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5a7d261a84bso61822337b3.3
        for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 06:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155212; x=1698760012; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r9ZaCKU38kmyhI7VEwX4KjtHXLgRMjapTHFgQ9SG6t0=;
        b=1whbu6fcQ/CXKMQpms1/ze+jte+DVtY7HpD10s/xz4pl+mjPj80vAZBQp0WhvvMZ1m
         528VoCd/vxdsRjKRsxosTsd6Hpf2Bw5nKjseKoJMfu9rc7AqB5S0U+5f6tn0W5OED8YM
         MdR/jN2OweIJXbdgkWOFd5zsPPbMzFVhnSsC8Djmvsf5GqeTkjXwiv83PDaw+iUGmjZ2
         YFfeTzfX4N/30DsiLsL8QEW59YIoSSTkp9zJkR190akQlbovPkuU0AxjqZfkIXlE8fGC
         IhlsaC8bUFf9K0sJZbQ3WrzGa4JCa4BfOihe2jAUnvMAVmDZzHwpb2aPz67trrbE+akf
         vmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155212; x=1698760012;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r9ZaCKU38kmyhI7VEwX4KjtHXLgRMjapTHFgQ9SG6t0=;
        b=OjNPy9JY5McztIG6URbtvnmoeu7kZl7kzUG3x4t7+TcLcH5oLvJQS+gvQ5Mvpx8SM3
         Xl5LVpyDeJW+Ddgi/fJcw483xgrq82yna6KGl5tMMkC4HXbMHKRMGJOvN13wG7SqHXFP
         TP/nLkHf6PJVF41zQHBGE7NF05eszDZPXi6CmnH8sX/DLtnPZdyVycVCm9YtVPz3Q4TJ
         2bv/m0GpjRzg8uQKvNsWhaccas30td++4GVT86FcsD97TeCSHQcrTnNBpLaCRY0RNQuj
         4aCDh7W9Fwqi5+LPCiHvSRhLtfIt52b/XOFy5eugBALyxf1RD1BW/d4u8e/sSkqA/LKJ
         KxtA==
X-Gm-Message-State: AOJu0YzHCM2PwaA5MiykdPycWKfzyKCkkDnYlQ+ucCKdSuPnXQzV2i9h
	D3RTPE0V3REZvxS2vuEXbYKTo2DOHKg=
X-Google-Smtp-Source: AGHT+IFUpFLBsDMNDQVhWCjHvEp+oEK06bmA8hZB4NpLCdYe9bJ3XL90v8R51rmnjDRHAZifNxDo+IuLmGU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a0d:dfd0:0:b0:5a7:ad67:b4b6 with SMTP id
 i199-20020a0ddfd0000000b005a7ad67b4b6mr254303ywe.2.1698155212529; Tue, 24 Oct
 2023 06:46:52 -0700 (PDT)
Date: Tue, 24 Oct 2023 06:46:02 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-6-surenb@google.com>
Subject: [PATCH v2 05/39] prandom: Remove unused include
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

prandom.h doesn't use percpu.h - this fixes some circular header issues.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/prandom.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/prandom.h b/include/linux/prandom.h
index f2ed5b72b3d6..f7f1e5251c67 100644
--- a/include/linux/prandom.h
+++ b/include/linux/prandom.h
@@ -10,7 +10,6 @@
 
 #include <linux/types.h>
 #include <linux/once.h>
-#include <linux/percpu.h>
 #include <linux/random.h>
 
 struct rnd_state {
-- 
2.42.0.758.gaed0368e0e-goog

