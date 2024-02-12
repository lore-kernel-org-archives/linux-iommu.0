Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43314D59E
	for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773979; cv=none; b=TBDGx5vVX3sLjqmoiASoMvq4kPKzwvwZJPuZ3fXAXZCQdWLixDmGdQLXEvo3GQR3kLgvCcvqFfh2XhWWhLA0mDVX1o5BpjyvlULbKGVeh7ne+IAiuF1DImCapRem167YzS4a3zDi3Zg70Jk+9JHSZibjog5lc7d0wAoCsHtLskA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773979; c=relaxed/simple;
	bh=xFlCSB2BhnykCmQeRsN0j73C4UQlJIZav61x4g1IDdg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r5/QTFO3g1h3iqHKedjUWYlsIIbBUMt5xcswxCtuLent90CWsR8N5XZSReK0nl9JNomVtjO/oPckh64mwvG5wPyJ+6O+FAw3oSkssykU2EcI3NA4ybHfKarK+3sCk62ztmBdNkuYZQG6iKbqlhVBcZu45qKwBSVapzSYbN3ifIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kBZx+7Mm; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kBZx+7Mm"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6077ca6e1e1so4672117b3.2
        for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 13:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707773977; x=1708378777; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G9b+4SdACUtX02zckFp4W9j//70BE65Et6Qs8xfY7vk=;
        b=kBZx+7MmnlmnZkRuBbF2VbcwTF2b+oRQsC5vvxQepK78tDq9y9esZdC4wZyzn4rseE
         0mTv6D7m1QgHkq2MKCYyF6VWT5RINQCYrdvqVx6uYzNlp40vj+5TCktaICOfhx5uzc9p
         UC+dDCNZjTwz0qRZpMeCnb1IWS3EYSauKG/6nVcUAH9V+anDp/5EMFdhNWUgaVqRS3IA
         QK1YAp3eVm4xVDqrLObUFIVaXrhZqTKHUoWl517+0oAtT2ZmH8199HUmNOWv6t/sRNs7
         W2ltYgLGrTxWSJkgdqlSNJsU1Jt9+u8aW5UhsMrJnKPbu4BTzMilc0KvkuTjyq6tCW8N
         1SPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707773977; x=1708378777;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9b+4SdACUtX02zckFp4W9j//70BE65Et6Qs8xfY7vk=;
        b=vj1zUvfcUFTzLF4Ac7zZj7n7RSZg0g+slGdEYy7Du24qK1wYwn2W02TwoEQJXQRDzq
         tawORwClgiSSHmFXrLk10L9utMrIr8ZDrIHt5GhFEXTQ+9Y/J8Ot3PfA731HWNuP906Z
         UpUygvtVmhdSl+tIK23GTlmoX2sSPulkvFdxZla61AmEnVwMeklJkXV93HKcqpxXnH0t
         hDAxLT2NwjBfwZKBVnWHLeQx/1ZydCF3F09I9JyYMiFhcUSfnoo2zcAW2GrJhxHOqQeF
         PR9JIeK2csHvCif0rw3r4Jzs/yrcrz1V05TOsLam3AklY0BL16EcwPoEmyl1c5J3csYh
         R/Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVYMNvGdD4rTSlQfE5baD57Z/2BzxmljYkEiFLU+5KUxDaoy8pMO6FepIFmTDuO0KcUiQaVYRIZkXilniJWfBCTQT+cU+4=
X-Gm-Message-State: AOJu0Yw4iPLg9CC6l/5ABlcfygO9Kk+41SDCRT7/007CVVIa41KcAmyk
	fO3kRurUgulR+zcUhmhuUF91M5fzvv7q2G3fu3YJY/Gys7nx94L3j5aV5uNEnCFvN/6SX5AtLUQ
	F8g==
X-Google-Smtp-Source: AGHT+IEGxw+pumepe2rycJxKPCLRRtMyemZOKJSP2HsBcIOyAk76oq0qhFPUoU2Rl7QOiTv7xvjwgacHnLI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a0d:d495:0:b0:607:7f86:dc24 with SMTP id
 w143-20020a0dd495000000b006077f86dc24mr109272ywd.3.1707773976926; Mon, 12 Feb
 2024 13:39:36 -0800 (PST)
Date: Mon, 12 Feb 2024 13:38:48 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-3-surenb@google.com>
Subject: [PATCH v3 02/35] scripts/kallysms: Always include __start and __stop symbols
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
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

These symbols are used to denote section boundaries: by always including
them we can unify loading sections from modules with loading built-in
sections, which leads to some significant cleanup.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
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
2.43.0.687.g38aa6559b0-goog

