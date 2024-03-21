Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DEF1332A7
	for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039042; cv=none; b=sFpYcxJP07o01iBsARnZVBqDSDvm5Ycum4W6Ojns01+1rT+dKcXYq9rSeZgOE7n6hW8zNaU3H0b5w2rf0mWui0vxHNuxaEunkVkMk9MvUWti8qzPkuTEu5j3187IvLCklocH/gbP0KzvqpSnRh/oi1ehC3cigf93LzJcb/pG2MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039042; c=relaxed/simple;
	bh=ir6xyZtmAUC+Ybm5fW49pWbbkzfCfz5BPQNom35E7HQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B/Rhl3nbwdY/qxATW/cvZoCI4CPCYImHu1aGcB+ptxjhSYxrliEaCkBz9r25AaTQgk9kYe6fDuEFCMClup7XLAX0J/dYvqgPtXyGdKprYtbsFBVNGvSWJ59ap08phTDnmQR1y3fURV3X/MWCP2b0rapjRqwlINUIHYQUbpb9wuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vWvIJrTI; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vWvIJrTI"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-610fe0406e9so18733997b3.2
        for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039039; x=1711643839; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FcsF8xuW3B4rJ7bvWaC3URPqDGHFVTOJU/Md9c+vki8=;
        b=vWvIJrTINGibqbL4g1oMehmEFe0E+oCfarvhBO9ASr7xZUt1v9jChZPoMMY6FyeMdz
         Vbtpp6LqSDFGF0awV1wavCv45eZAP4t0TFp3sogfaRzN39PvdmNykpklGjHzb8PMTgsN
         mp8nIfAJoTCx2lZf7tAcMpoV2GgLxisYhHGuhi/nVBq3yEhKFDs3ziqLPC/ILkcqBW04
         kLpvk9ejC5PtJaQiTQnTBnJl7/1g9OWiEbqKwz6CAHdamriXwPOfZRxxQAnz+i39el1/
         /U9KyV8khI4BVNyIy8w5FzQMbZMCnSHtvaffJZzDIHiMIATM46SZfDR2ZPL5KjeIOG9f
         MM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039039; x=1711643839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FcsF8xuW3B4rJ7bvWaC3URPqDGHFVTOJU/Md9c+vki8=;
        b=r8w43apr6skmzMVrT6BNvaqRR5OG0O3mcfpRgJPEa1Vu3cSvPiUGwEkkRKIDOvolE0
         jeSJ/QszzM45PXbELp5DEIEEDAhkWbFasatG39QrwT0oExo/bMGZea73TCNQMmPK5gN3
         gDR4sjfeXc6GAfu2o3VtVfja8ItwGEiLIEmGFeheqgdi3ruzh3nQcX1Lml7UxWU/wveZ
         xjLFh3woohne4am/qbusu4Grl4y8FmMFVDrVIAWNOE5pXMyOwaTSfgUI73/c6I+5vuQx
         6aO4MsiMBytqm4PO1pkN2glc1AMkjNaxYTYN4y0SE4+g+73g3QpGs5oX3TWfBnSpMAnd
         0mCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqzsxFtr/EDKoqIpboQgXw+6B5l4+At/7FIkBimELES4LN3UylGcbawC3lR6HlDaYU1n3AJm/RtyasOGr23wb82Sh8yQY=
X-Gm-Message-State: AOJu0YxH8q6NEB1xC8VrVl/sbFjW07jeWb6M46zbxwgFRdZLIoexXn5i
	FrqOnV3DtWt3MYiJhwZ8ccORQe546zImYs5trE8Of0pBdKQ1UPx6nsex/CZdDdpM2pq2UwHJISv
	thw==
X-Google-Smtp-Source: AGHT+IGrkFj5aE/qI6dA3cr3f2zIJD/myHIxBhs84G4EmxlJsslBgaCO9HAP/2XOVSrMpqDkAxdrZ+lOSbY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:6902:1207:b0:dc6:b982:cfa2 with SMTP id
 s7-20020a056902120700b00dc6b982cfa2mr1182860ybu.8.1711039038760; Thu, 21 Mar
 2024 09:37:18 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:26 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-5-surenb@google.com>
Subject: [PATCH v6 04/37] scripts/kallysms: Always include __start and __stop symbols
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
2.44.0.291.gc1ea87d7ee-goog

