Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425060;
	b=MSdVqW4YjzVDtalcZKYkuOwreHmpM7NrX168lm5UgMxSja+OWLT6BF/MAyT+XJ0udVOX
	 k4QjR0XR/NPqL/eFC9DrG7EMQW2i+djpByLkeIgPv8H6uVxFkDkOEm8drZD8uRb4LV2fZ
	 z7xJPeWFqHA9F/R9Ha4La20ikh3kWI7+d4IxYTSCb6oX2xifSONjhKXHs9zkh7nPLKExw
	 QC/B/+0RFhMhXk4u509Q8Fs/PFqz0xCOeOBkutwRoRno8y/RGG480zyL9box15A/dF5rW
	 qqUCq5EhbTHdMzftgieb0o4g9ZR5sCoVr5xupqItWL67nhwLp1nyS1sUPfiv/up+2/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=jeGS53i3H2ZA/AB75TkRMSZsgx42pQ2yxXWF/NRY1NA=;
	b=YXicJG3QZwIWft16NHlnJwmRLQKgdOuMOHWsknVjObI24/h1VP3p8pjP87lMG32QAkTS
	 TuO7TfmFGE1syy1BovEzBsJ1RkIRb2cHFnhN6ypD7IvIvHOr187sQq3QEkOEUPToT/ELX
	 CKrIC2ZjjHzDaxMjx3ILHseS/8fzSzJbyFWCnvAnrhVfDXRYILuk07W2jYwcEZBEJHcsW
	 +tcRSFZi5QSklE2KDIxStM6FgTOTnsI4vlY291jD0TKcAkxVnydW0J8ZYZOUvag5tun+7
	 RzUSOqxedyj6GGziv0r1DmG4GmqdxjnUIg9nWslKC0/psIBkKl4cSjVGhSaYHJqs3mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iGF1Mm2d;
	arc=none smtp.remote-ip=209.85.160.70
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6377160A260F
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 19:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6377160A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iGF1Mm2d
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-4adae323d5fso2095387fac.3
        for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 11:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794425059; x=1795029859; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jeGS53i3H2ZA/AB75TkRMSZsgx42pQ2yxXWF/NRY1NA=;
        b=iGF1Mm2dZRR/XPbM74vymmqvId3HcS6J9XkfGrO0GeoZAe3N8hQ/kJe8NW7Wbi6ktg
         7Txn1MUzxXB/y6SPi75XqhRtV8olza2Lxk3aUv9dZbabArwkf/9kAw8co54azz6CSZdo
         BPlKnpScaBbv+XCuk3s6SgRjSWQLJ1K+jn/T5g6in+8GVqn4Fvuy6WZ/C1GorS1/+PCY
         5MtI3GvYJecYf8IwqDmsVG5F3i3aXfphaQgy7i2Zb8I1hSc5OohMJQgZ1itSXy5XwAP6
         OxO0BXyClEr1TGXs2wlKTeBv6fweeEBA/0/p67wFbNPYdd685990CMSnFCcXqc/4E4RC
         nMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794425059; x=1795029859;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jeGS53i3H2ZA/AB75TkRMSZsgx42pQ2yxXWF/NRY1NA=;
        b=bAt38u99kFkW2o1K7vP2WOs4VWG0hn6bliNZicGOHJhqR5fw6yG1vaLur4Iwfd0Dta
         q4U+Kk30IxHZk/c1cYE+AhkHZz+5pbCEMPTTpbAFzs0BJrhtGtl6PJyeRjF7tCAGVqNI
         OyeojuzIAc2NpPGAoYqWDPPbpX+RKaNfqEDlT9wu9Qriq4SISLsk5Dxoq8MO4PGmoF/v
         CdGlCWfMvX3GmqgEHaonkw4ihw4EBFwS3DAM+RQYT6Jj/ml8mmtuXUz3Q+UOJqcRrffS
         JsUlQeyMpHOt9x/ThVhIADyS3noxWexH7TiSqG1Z+QCCuo4zaw5zHYgVT4oNJyfXTgVI
         DIIw==
X-Forwarded-Encrypted: i=1; AL+hErFaDrAeNE9j0Klnjj79LzMVSRCglZj8V6J750dC0/dpy9QROfm/ZML/Wc8XktQmfevbZg5L8g==@lists.linux.dev
X-Gm-Message-State: APuU4Z8+ZylZIEa5hCoyzNkJO6TMwGMmlxo6Wso51HAmdn8hiBVyr23u
	Q3eImdn++P7df5UjS1ZbasSU0Zn2avF/JAHhTv6tXkY6gVsoQY1/pmwoin6x4OTmj9fuMPtzk2H
	2YQlr4UtRwhAROg==
X-Received: from jagm2.prod.google.com ([2002:a05:6638:40c2:b0:620:1989:fc1c])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6809:19:20b0:567:cbf5:bb96 with SMTP id 5614622812f47-56cc533e313mr527002b6e.44.1794425059253;
 Wed, 11 Nov 2026 11:24:19 -0800 (PST)
Date: Wed, 11 Nov 2026 19:24:07 +0000
In-Reply-To: <20261111192411.4133780-1-dmatlack@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261111192411.4133780-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111192411.4133780-4-dmatlack@google.com>
Subject: [RFC PATCH 3/7] vfio: selftests: Allow multiple BDFs in VFIO_SELFTESTS_BDF
From: David Matlack <dmatlack@google.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Matt Evans <mattev@meta.com>, 
	Matt Evans <matt@ozlabs.org>, Mina Almasry <almasrymina@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Parse whitespace-separated PCI BDFs from VFIO_SELFTESTS_BDF in
vfio_selftests_get_bdfs() instead of requiring a single BDF.

Multi-device tests such as P2P DMA tests need two or more devices even
when invoked through run_kselftest.sh without command-line arguments.
Single-device callers using vfio_selftests_get_bdf() continue to receive
the first BDF.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/libvfio.c | 53 ++++++++++++++++------
 1 file changed, 39 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/libvfio.c b/tools/testing/selftests/vfio/lib/libvfio.c
index 3a3d1ed635c1..448d11442b53 100644
--- a/tools/testing/selftests/vfio/lib/libvfio.c
+++ b/tools/testing/selftests/vfio/lib/libvfio.c
@@ -2,6 +2,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <sys/mman.h>
 
 #include <linux/align.h>
@@ -32,38 +33,62 @@ static char **get_bdfs_cmdline(int *argc, char *argv[], int *nr_bdfs)
 	return *nr_bdfs ? &argv[i] : NULL;
 }
 
-static char *get_bdf_env(void)
+static char **get_bdfs_env(int *nr_bdfs)
 {
-	char *bdf;
+	static char **bdfs;
+	static int count;
+	char *env, *tok, *saveptr;
+	int cap = 0;
 
-	bdf = getenv("VFIO_SELFTESTS_BDF");
-	if (!bdf)
+	if (bdfs) {
+		*nr_bdfs = count;
+		return bdfs;
+	}
+
+	env = getenv("VFIO_SELFTESTS_BDF");
+	if (!env)
 		return NULL;
 
-	VFIO_ASSERT_TRUE(is_bdf(bdf), "Invalid BDF: %s\n", bdf);
-	return bdf;
+	env = strdup(env);
+	VFIO_ASSERT_NOT_NULL(env);
+
+	for (tok = strtok_r(env, " \t\n", &saveptr); tok;
+	     tok = strtok_r(NULL, " \t\n", &saveptr)) {
+		VFIO_ASSERT_TRUE(is_bdf(tok), "Invalid BDF: %s\n", tok);
+		if (count == cap) {
+			cap = cap ? cap * 2 : 4;
+			bdfs = realloc(bdfs, cap * sizeof(*bdfs));
+			VFIO_ASSERT_NOT_NULL(bdfs);
+		}
+		bdfs[count++] = tok;
+	}
+
+	if (!count) {
+		free(env);
+		return NULL;
+	}
+
+	*nr_bdfs = count;
+	return bdfs;
 }
 
 char **vfio_selftests_get_bdfs(int *argc, char *argv[], int *nr_bdfs)
 {
-	static char *env_bdf;
 	char **bdfs;
 
 	bdfs = get_bdfs_cmdline(argc, argv, nr_bdfs);
 	if (bdfs)
 		return bdfs;
 
-	env_bdf = get_bdf_env();
-	if (env_bdf) {
-		*nr_bdfs = 1;
-		return &env_bdf;
-	}
+	bdfs = get_bdfs_env(nr_bdfs);
+	if (bdfs)
+		return bdfs;
 
 	fprintf(stderr, "Unable to determine which device(s) to use, skipping test.\n");
 	fprintf(stderr, "\n");
-	fprintf(stderr, "To pass the device address via environment variable:\n");
+	fprintf(stderr, "To pass the device address(es) via environment variable:\n");
 	fprintf(stderr, "\n");
-	fprintf(stderr, "    export VFIO_SELFTESTS_BDF=\"segment:bus:device.function\"\n");
+	fprintf(stderr, "    export VFIO_SELFTESTS_BDF=\"segment:bus:device.function ...\"\n");
 	fprintf(stderr, "    %s [options]\n", argv[0]);
 	fprintf(stderr, "\n");
 	fprintf(stderr, "To pass the device address(es) via argv:\n");
-- 
2.56.0.567.gdb80ae8cd5-goog

