Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5462C2B5C0
	for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dISgpoBC"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-da03390793fso1012316276.3
        for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 06:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155206; x=1698760006; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fObhDXE+DfK48fbfXMStFHtHAmn90M4M91A2l4CxzLM=;
        b=dISgpoBCqZ/Y8A/MF/yZJzKqIws78gQA2htGGxpagmouk0Hl9O69sLMNEtdxV4fe29
         6b7nEhx5Adi6In5oAWe/Aymc7Zp2qQx3ymz5eJdfpERwH4mujvixhRv5/svPrhUu4Gmp
         8owKJojw3EYJQT0WDABA0uMIcxOrcUNIeB1UCjGRD+5TEDDffrpU8TrvMgTSbwaBRHAS
         lbm2Sn9bBarLcADUafVNO14RoNIY0gZxn82iu9hjwjcv9eWSH/+5eU6d0W+1QkX9T+4Y
         xIAFU1PoOwyWFhji3simAY3wmSv9IO3OiCncVBaxUtG3bLxYaGsTIAZ5xm/HF0/I2zBK
         tcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155206; x=1698760006;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fObhDXE+DfK48fbfXMStFHtHAmn90M4M91A2l4CxzLM=;
        b=atdS3QYCvtysRMFHJJYfqNk45XaAIhqYihRZkQQN5Qvn6rDK15jJEkXoDiWQkarqTK
         yHjykXKpP9BT1NME7j3myCRFubejM16gyY+zy6oSE+64xoLlMTlC5PUwwK3rxsBX0mOp
         mnuXVNtqQgr1lvDAlaV8REDL/PmTigYP6fePYI2CXqNl9T4BQFVkylPra/0nFlWOTCWb
         3QX6DLUR1+qOSnmiRJZPHr/mHRO/zsMlHUIYJD0GWEC3Yt8d9I4JUt9Fi1dd9Uo/wY/S
         FDTtYw8eGNgKlAJrHklzMtQluA4zO9ayPDO4ylkrRfow4M7dAqZTvriie21K5pjGAi3/
         IGTg==
X-Gm-Message-State: AOJu0YwcJ+vCDtiQPpQjh40CRCgYV4FSvatM1H7k1SnDDcfqY28UepN8
	WYO9MkZTNS1xXPj0Hsw6ZkV/e6fLsaY=
X-Google-Smtp-Source: AGHT+IGzqDmmVKWAX0qOLCG4zSSOu2XUUgzUKaIXDvA8+3j+t9o+p5RCbsfa+aQ1r6gMSAIrcYIsUr6/0f0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a25:5008:0:b0:da0:2b01:7215 with SMTP id
 e8-20020a255008000000b00da02b017215mr55818ybb.10.1698155205957; Tue, 24 Oct
 2023 06:46:45 -0700 (PDT)
Date: Tue, 24 Oct 2023 06:45:59 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-3-surenb@google.com>
Subject: [PATCH v2 02/39] scripts/kallysms: Always include __start and __stop symbols
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
2.42.0.758.gaed0368e0e-goog

