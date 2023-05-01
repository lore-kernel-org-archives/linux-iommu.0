Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DCE3C05
	for <iommu@lists.linux.dev>; Mon,  1 May 2023 16:55:12 +0000 (UTC)
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-52855ba7539so1413419a12.3
        for <iommu@lists.linux.dev>; Mon, 01 May 2023 09:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960112; x=1685552112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OgbhlQnm6N3CIqx+6EXURMMvow4S1KQvuNCpohSnl08=;
        b=ym8bWqOddRKLLCHNc+7Y2IQs+szb6DlXVMA8aGLldE3slVUGdWc6AeUaj2cctynpb7
         /42bu00/rNI9NmOjux118bETqQ9xSRBpI0DlCMlMXfD5dyA5fGqmz9wEGRomBF9wE3qi
         RRE1kSFRttrNPJ5gUqGivtomoZ/CkHpvdtT+8kMIwh52/Lg8aqiW8D9XXtWx1rDhFoLd
         bIJ0Jt1xQTF7bUEViJLE2KzQyVYsdDW/+ihFxINfhU+/Rq1Q5G2PY50HQQ7ppVzde88x
         xSaqGzF/rOMvs2lVTYEukIGUCSWj1ys72INhoG28un8pv0+7d++N9bkCwOHBDc2Mepzd
         xe8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960112; x=1685552112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OgbhlQnm6N3CIqx+6EXURMMvow4S1KQvuNCpohSnl08=;
        b=Itf+hzOzMQXch1D4cVDeCi7p2qkpTXCjjmT+zZ62dntMCcwzc7N5Vw0xRoDxnDFNbF
         a2n5wObBA5x86kaeyQk+CbHue9pCwHafUj2nGVRA5pHqLM/oBm7OhU/Ggcru5lYnqNBz
         bGJ4sXEdjMnJ43n514QLHoqIK8w6nCX+iyUH+pkIQCvAH7SJS8M12uPRdnlEIpD23L02
         4tYcJyo/dV7awwId8BArUrvdgcp7cp4t5zVLPGiCX2VGwQ70/yAgig5EvHTralTUevdd
         i3LZXnzSBwthwvBvzS5KEsPpsPUBjfN7efbpPDSnumevFKdDxKPTzYYhhu7ytTExkJmu
         iXZQ==
X-Gm-Message-State: AC+VfDzoRhl4LoYfNLk0qDgo5lOD/gZ/N1b/hJf4EGqnPZt8KluEBBtf
	1svSZsxdoNHxfbC3KE01vLz+djr+WMU=
X-Google-Smtp-Source: ACHHUZ5b/dFHDo+PuE3NWONWxlaUnbiu4qgjE2QFFJKcdOrghbUOD/toAldYYzf7QRUKjILKXa170Oj8yTI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a63:24f:0:b0:520:60ac:fb30 with SMTP id
 76-20020a63024f000000b0052060acfb30mr3551005pgc.1.1682960112196; Mon, 01 May
 2023 09:55:12 -0700 (PDT)
Date: Mon,  1 May 2023 09:54:12 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-3-surenb@google.com>
Subject: [PATCH 02/40] scripts/kallysms: Always include __start and __stop symbols
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
index 0d2db41177b2..7b7dbeb5bd6e 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -203,6 +203,11 @@ static int symbol_in_range(const struct sym_entry *s,
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
@@ -210,6 +215,14 @@ static int symbol_valid(const struct sym_entry *s)
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
2.40.1.495.gc816e09b53d-goog

