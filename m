Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B2D141981
	for <iommu@lists.linux.dev>; Wed,  6 Mar 2024 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749497; cv=none; b=fOKpMzPBtORsXtIOb5CkO8aCEIgM+YeNIOuoOo8KX49FhH1jJHRCPJNd8YBT+yWEB+/ycY8Tisc6gijHzEKyd/uqreF8JgLRWLgOKHTJqDiung0nOiqF8mwhELUDBGT1ZXZb2M7PJDO9gN0mOloI04UaVzQ2z76Zw9+MZb8cG3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749497; c=relaxed/simple;
	bh=ZqsbHPLTqR5vr2hfJmCxnAF/y893b7KN4UH1mJR1TTs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UvmF5gwGz5/k9YFB/1TdUB0Zenx9zC49aSq8jSpmaljU2tv5hGoCvghOuRxU3DT7nYQN9995KQJhYqRXtivFr0bWyu/UsvjqYLrDlDDoBXWQyiUVyUBgy48JTsP9jdzn9S00NJxYbecPX1QAFOFysFBln4PM+23EgNWkGeDNi38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZmsjmJaB; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZmsjmJaB"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b267bf11so8285452276.2
        for <iommu@lists.linux.dev>; Wed, 06 Mar 2024 10:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749493; x=1710354293; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5nTBv3DNXNZIxIc1ZBoC1bDpLfB6IB4LOR7eT5PZErs=;
        b=ZmsjmJaBuh7VsvjgOZuTAGeESJrwSk4tQkw25Mz69G5Ljt/v7b8fO5Rc+KMZM9GOlU
         yaql20Cgoe8YPMJOp6c4icJ5+6T4rWNW5FnnTsApoD5RdE/e/2aNV97YYLmjSWXQS5KR
         /VlODnGxE5jC2eFIPGdS6O8z8cGO1+5CPiIrGL7LfvVL8802LZlpWd8/1vhCqht14lkj
         HnUVNoxxMUdLeGfyeq0skgNRq+LePv/p7jkR5x745RVMkA9F356L4w/bI7z5zhhxSbJY
         NQIDPvSC+vLZcOFCC3usu//htp2GzFKecp4A5mwjRod2ZK6Pl33eofA5JL8LLq8MWo92
         ENHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749493; x=1710354293;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5nTBv3DNXNZIxIc1ZBoC1bDpLfB6IB4LOR7eT5PZErs=;
        b=nA67ZzBfGGNa/oieebSeuJBwCbZ3k87JaaG5hCRqG5O1ChX3Vlo8Izz9SudntSRG2k
         1BcMefQxcrSGW+xKqgq5wnKxRw9o+bw8Qo9IkU0MIctJCJ0dRvTcDsSfKelyLht0/1ET
         su43M1So/NJzTPqczyKfpA+hYbju90CgrxRtMPuNw6KxBDoMzmJu4ik95tnFlo+mexF5
         4EJ9d3fKX+AKVCJbiutZ7nk1XO5XmBybN8v3XAIBmBzKBX8KHIoz2XW6v/3Sea3XnZle
         WfHXLzVy0ZJOEUEehswjNKRo32CVzDGIOTkhH69KqdxoXK5HlTgHtVciX7eBmtMWWheo
         SljQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOjnMdNZm7HnXNXA2amXxDeOhCg2XPq5GYvl++BwAhsoQ4c0gH5eGYrlCkOFZ57XF5g0hpxbdTA/sSR2muSMT4zgudcKw=
X-Gm-Message-State: AOJu0Yxwpb+ydGxWZvYbkBpVllHjQBsaH1VKft8JqmM0F0d4QPn1yRhz
	LCIT46YTdsVpYoXzrGl5DAfYJnroksnMbLSm8AHIhtrxurKSoJYrTB0h9WY0M4wKAR8f9B3+VgH
	iSg==
X-Google-Smtp-Source: AGHT+IG5gxx5etlJS8XEklM9jb6RXbjr2MBzNYyK3K6zvzjzbtTe9XCBybhsxXG5rBRlQj+HJ+M1RmTOlz4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a05:6902:1009:b0:dbe:387d:a8ef with SMTP id
 w9-20020a056902100900b00dbe387da8efmr534074ybt.1.1709749493516; Wed, 06 Mar
 2024 10:24:53 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:02 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-5-surenb@google.com>
Subject: [PATCH v5 04/37] scripts/kallysms: Always include __start and __stop symbols
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

From: Kent Overstreet <kent.overstreet@linux.dev>

These symbols are used to denote section boundaries: by always including
them we can unify loading sections from modules with loading built-in
sections, which leads to some significant cleanup.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 scripts/kallsyms.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 653b92f6d4c8..47978efe4797 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -204,6 +204,11 @@ static int symbol_in_range(const struct sym_entry *s,
 	return 0;
 }
 
+static bool string_starts_with(const char *s, const char *prefix)
+{
+	return strncmp(s, prefix, strlen(prefix)) == 0;
+}
+
 static int symbol_valid(const struct sym_entry *s)
 {
 	const char *name = sym_name(s);
@@ -211,6 +216,14 @@ static int symbol_valid(const struct sym_entry *s)
 	/* if --all-symbols is not specified, then symbols outside the text
 	 * and inittext sections are discarded */
 	if (!all_symbols) {
+		/*
+		 * Symbols starting with __start and __stop are used to denote
+		 * section boundaries, and should always be included:
+		 */
+		if (string_starts_with(name, "__start_") ||
+		    string_starts_with(name, "__stop_"))
+			return 1;
+
 		if (symbol_in_range(s, text_ranges,
 				    ARRAY_SIZE(text_ranges)) == 0)
 			return 0;
-- 
2.44.0.278.ge034bb2e1d-goog

