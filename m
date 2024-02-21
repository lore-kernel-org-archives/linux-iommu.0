Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F5586659
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 19:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544464; cv=none; b=ueONxlNPVWbC0HF0VYn2fJ46oRSKoFPYxKiQUeoUlFbmXXZ9O5yv1sLZ/QNHkfoYRNCmhm97zNVG7W+09xMcGHOr3Vc/xk7kTwzir+7k9yKQg1RL3TpbL+ji+wCfgpQX/5WeDjDzq/ymLTlqjErtK6T0H+kQs0t996j5WoewP9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544464; c=relaxed/simple;
	bh=XvI76MSJf6n8ycfULIR+dpUzLDxxCd04CalcxvixqtQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XDIdNDGgDsg36FxFnL7nJ9EOyBn4L59YpTQTUB04OLF8wDRW960s4zyFqrBkJlOe+dwWVHnu4t2DgGUekm+7/pQaEIDYOfHPvMuvMQcn/z1nqgoV6ppcTm1H01DrtnlLQU+LE7SRwO2OnbJfUy4GbLQRLoYBugAYhZTglYdcUFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cxji7bS3; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cxji7bS3"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26eef6cso10348725276.3
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 11:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544461; x=1709149261; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eOix7cIZ9OpjtRmnOCb5oo8qhMGRBISTNpiHk2ice5Y=;
        b=cxji7bS3X98kuZ0XrvTT0YYAq6vOIEo7XAAe6VZa6gqIFUrZff4eyjFtco7/CzFSC9
         /s8X7n8fO2XsAPsXDGVJdVyWkQIZOk3/Qc7TJYrGDoglZHrCU1I/iLFVfpn98LjqDbZl
         yAcPAnT5paZ0XJlgvJrwI/hs7eYUdYdTXjARBaDn1kbHDJHJfFgO32d+JRBmcq8PihT2
         q08BzDC+p/f8B/Yl+dk5LWl4D4HrOl8eiOgsF6B0XhDAjyEutAmKHoXSuLV5PjMRZcSD
         TClVxiZY7IFgzq0pSwJhvtu69153d7h7HvjCNXZDjtDpzscGhFA6o3k0v4P9fc0VAcK8
         qxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544461; x=1709149261;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eOix7cIZ9OpjtRmnOCb5oo8qhMGRBISTNpiHk2ice5Y=;
        b=N8FLAEfm8Ksm4ft1lIXXqQsQ5BMC8oK9CQMMrZZ9idTbZ0u7Y69Y2shGuC4r9c2xaH
         tUXR4FyxUPJy23b0+RpmcBAW9VQTxZqijQjGPt0SRsVEqF4qe1Gi4+wrAva6Oi8lZx4S
         YL4Z3VE0O8It6CWohJH2dot15k70qr6IxLMMSE8Zp3oYkmulhNNyeYMWBCb0IxwH4Iv+
         Q1vyvfrLvz3zKQxfqG4ExfZ2hHVycNelI09VJv1zxOR9lB4SX2jcNcZKxTdrsLBaegNM
         P/shHPs02+EJj9//WvwVzNFkTpAHMvbRW920lG3o21423xV31UrEG+Oe6h5cN1sk5APP
         yJsw==
X-Forwarded-Encrypted: i=1; AJvYcCUNFCZo3rCGruxf9e8qaP79418NYm3LNQ5CKAlW1+kT0bCLVaOU1avPQqvI+WJ0lpo0x85qACXekonT/mugN4frSqJww3A=
X-Gm-Message-State: AOJu0Yz2ItM43mrRvDnX12JRFJVWNd6SgIoWyRPf5KW3JzFYfXqY2TJa
	wXmE1OAOrAvsNDP3u/D2Buk0Xox8zMI7RpOp4tB0pGVxJcFGoBHg1yNQHRPFBJ1DWCRmHRCpUDb
	iuA==
X-Google-Smtp-Source: AGHT+IFQED8r11XAmHCvTPIM6osrIYpquXv216eXmkF7EFZy4gkeT8fImMy3GTq6A3JUXD3VP8Bk7+J6aLM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a05:6902:120b:b0:dbe:d0a9:2be8 with SMTP id
 s11-20020a056902120b00b00dbed0a92be8mr7992ybu.0.1708544460699; Wed, 21 Feb
 2024 11:41:00 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:15 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-3-surenb@google.com>
Subject: [PATCH v4 02/36] asm-generic/io.h: Kill vmalloc.h dependency
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

From: Kent Overstreet <kent.overstreet@linux.dev>

Needed to avoid a new circular dependency with the memory allocation
profiling series.

Naturally, a whole bunch of files needed to include vmalloc.h that were
previously getting it implicitly.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/asm-generic/io.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index bac63e874c7b..c27313414a82 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -991,7 +991,6 @@ static inline void iowrite64_rep(volatile void __iomem *addr,
 
 #ifdef __KERNEL__
 
-#include <linux/vmalloc.h>
 #define __io_virt(x) ((void __force *)(x))
 
 /*
-- 
2.44.0.rc0.258.g7320e95886-goog

