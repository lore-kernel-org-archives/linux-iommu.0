Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795770552;
	b=GP8ekISY6gBIIXC+OfHmdE3yQ0LA1TCXiUXYv4OMacTcI1PifmtDy7v20pX0HDMCfPtd
	 ihJIh4luSeoZK86BplR+Ng0zrYSg13dFjb41krrhvEj82MQDdKV1+/0jxOQiOfJc4MotZ
	 oad3v5q+TEpnRpUysg+tGwdBvVKYIWc7pblnWTmUIq3GKzNbAU9x6oIRDcW8D48C1f8Ud
	 /UWJbEo20TQwAnuhCQx11CF2igx6JMAAJQyKrwvq6XAk/RKAnurbFDRmgJ+29vw4ZX+MJ
	 0wv+5qShIcb7jGdRlSPisX1FzZqZdeNDtWkdZOBE/COA83deVO4L85ZnCql5hmx/2xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770552;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vXO/Y/CYrpQIxWyPESy68yxl237JHlY56bkJQSv87LI=;
	b=tuJ9m6DWiH1lsl+iZJV0JD2G/jFdFCvPzPRtG52rfF0cmaqoHri+tee9XVDzrrqUQlGC
	 0bUdeHfH3MAMq+RmKXLgx6Wvguy1r1SOLPzpspRdCsSO87oiZlaNZh/LgmsNfoiLSNcNI
	 E06uiiJwEqTfEh79zREhmzJdjLDpUu5KWw3iC/Np7wvGKWZPeugx13/bcsFPYFolS8q4R
	 rAYdkVBLw5ZpxJmKcZUCLwxjphgl5G7mFgUHPD1cCzFhOtr+eVGW4jSRed8Gy9BopbOBt
	 ZvxMYqxoCCqolgVv6dJVyp3rtfELdLT1keibm2xF9YrCFfKKnGsmFuwDmABYbU86jQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EY5dwwOx;
	arc=none smtp.remote-ip=74.125.227.131
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D315606A31C
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 09:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D315606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EY5dwwOx
Received: by mail-pj2-f3.google.com with SMTP id 98e67ed59e1d1-3b509dc9d79so363117a91.1
        for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 01:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795770551; x=1796375351; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vXO/Y/CYrpQIxWyPESy68yxl237JHlY56bkJQSv87LI=;
        b=EY5dwwOxKYxD5Lb50uivPMjLpRhpwXzWg+rZCxWgCDLqgFryFdprsTKltuUQdje0jE
         6hzUCyHS4kcs9NU+h9mGJoEl6FL/6MG29QCMAP2vgjA5+DWbD8GuqX/umeZZyJ6xp59/
         3wVd+4MUv4H+hlo7LKEUNNgoYXZ9dA6GyUI9nE4FTun3cAXX02dD9sv1FquS6lq5NZY4
         qBCt4MZrVefGBhAjjCg1Btl/9yo+n0gFNGnabc8fYxYEXpeuYQ0fikU1Y9XJTVvt3u5a
         nGqOeJU2bmM1OMDlu+sNw+XwJofKg3UdDP1QVGuam0fVEDD+4EULpDAPmVYd6/987v+B
         HC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795770551; x=1796375351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vXO/Y/CYrpQIxWyPESy68yxl237JHlY56bkJQSv87LI=;
        b=gvjL4rAScZKp6PBH8o1bRJJBg0HGgeSzJvjLzoEFvs3Ge4/XnkXhz/1BeLIR97poZN
         xPaULGHPI0Shf5N/K3tHtJX+4WTb1UJJgclQNZhVs8JsMm0+PMAXmFW+O/oqTVu9L4NM
         dr9Yp3Fyf21nNVS2pGn1RuP3REORR/wWSPlfETGfYDt7hsbdAKMzOVZz1nJwhshtJmtv
         +FmsgxmDrinOyi93ewFFmK68w9kytnZ9WOqlwdbBaPm96WC+AS8I9SMowgMAsk1Seicd
         h8SlnkwigZ22J7S4uwLMbCc1EmfFibKREq0TjzsjqZd39kUEL9mMcoHIkhhQFDgQM20w
         UUrg==
X-Forwarded-Encrypted: i=1; AL+hErFvSuJq+9imHQTOVE17DvHdvAAOtxKE3PpsKivzP8Be8wCfRGgAbyeUttg712buvt3U+YQ0zA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/FZ5hvFeOrsyjEm1Sca/RYvmxubEEkvpLwCYTAVKtmdslPcsd3
	8HQjYUKeiUo5EJJeZO7RiOY8CmM9evvY6aiHxM6Z9M0mlpOeCvaWb4YO
X-Gm-Gg: AZFdTZdNEwbBUvsWIvUd5laWUJrMyu6K8vvGkHDP6UjWVCgu2UTEngI/vExBKfPGyxe
	u8/eoNzin8xsfo8FU0tg/74QCvKpPEdXFREz7N8lxqi8wOTFfeixzPROmLaSpRa1ROxmb4r1Tlf
	6IW4d2tMaOqHNjLMy9Fp/XvxSZIkVWNy0Ymm+t3gUTJTOcU9ciXzp7nEgix4wupP6Z3ifewSRiM
	fdW7QOsvaecJfE6KaNtsFqacK8XhLl1hvwNMcKV1/MaDpwEpwiXzhJwx3QfwlSUs2KiKihixMcz
	hJST6Z/eZhEMlwYbCuIVPiRmYL5hfyfDGH54cuJ/B3UbmYv0qoFdYzTq0j2f+Lf/MKVmfyCAVWC
	I9KKTTQja9ZD6Bm74LTx3veKgl7rPh+uO0KTTQtP06n7/Fe0H4pmtHxF1IMxZTI7QWbmrmHmDzp
	mop0MnP+N/EqrqdIe1zf46RzGO36MnUI3pyy1Ef6aplNWobMrgui8tsLt/c04tkYrxtQA9/OFw4
	imhRvLsRDOJr8omg9picXlJczR8b3B2lGYbUSvwmOjCcvtAobP8jhcfxDNJSomjyqWdYwFdgMTl
	+zgLvSHcbBMY2CEaiZvCjdyWkhCDIVXTzT6RCIi8ws8=
X-Received: by 2002:a17:90b:5907:b0:3b5:29e:11b4 with SMTP id 98e67ed59e1d1-3b5029e1464mr6516552a91.44.1795770551516;
        Fri, 27 Nov 2026 01:09:11 -0800 (PST)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d06ee37sm11718725a12.28.2026.11.27.01.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 01:09:10 -0800 (PST)
From: Wandun Chen <chenwandun1@gmail.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	robin.murphy@arm.com,
	ruanjinjie@huawei.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [PATCH v10 7/8] of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP
Date: Fri, 27 Nov 2026 17:07:22 +0800
Message-ID: <20261127090723.741253-8-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127090723.741253-1-chenwandun1@gmail.com>
References: <20261127090723.741253-1-chenwandun1@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

Mark non-dumpable reserved-memory regions with MEMBLOCK_NODUMP so
kdump can omit them from the vmcore.

The marking is guarded by CONFIG_CRASH_DUMP and either CONFIG_KEXEC_FILE
or CONFIG_CRASH_HOTPLUG, so kernels that do not build or update crash
ELF headers do not pay the cost of splitting memblock.memory entries
at NODUMP boundaries.

Clamp the marked range to page boundaries, since a sub-page split
would leave fragments that cannot be represented as valid System
RAM resources [1].

Link: https://sashiko.dev/#/message/sashiko-outbox-181183@kernel.org [1]
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/of/fdt.c             |  2 ++
 drivers/of/of_private.h      |  1 +
 drivers/of/of_reserved_mem.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index a58efdcbac7f..f3a766310d11 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1283,6 +1283,8 @@ void __init unflatten_device_tree(void)
 {
 	void *fdt = initial_boot_params;
 
+	fdt_mark_reserve_mem_nodump();
+
 	/* Populate an empty root node when bootloader doesn't provide one */
 	if (!fdt) {
 		fdt = (void *) __dtb_empty_root_begin;
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 895f868b4cfa..00f776819dab 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -185,6 +185,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 #endif
 
 int fdt_scan_reserved_mem(void);
+void __init fdt_mark_reserve_mem_nodump(void);
 
 bool of_fdt_device_is_available(const void *blob, unsigned long node);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index a5cd8c2fffc3..cef444d4c1a3 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -610,6 +610,36 @@ static void __init fdt_init_reserved_mem_node(unsigned long node, const char *un
 	reserved_mem_count++;
 }
 
+void __init fdt_mark_reserve_mem_nodump(void)
+{
+	struct reserved_mem *rmem;
+	int i;
+
+	if (!IS_ENABLED(CONFIG_CRASH_DUMP))
+		return;
+
+	if (!IS_ENABLED(CONFIG_KEXEC_FILE) && !IS_ENABLED(CONFIG_CRASH_HOTPLUG))
+		return;
+
+	if (reserved_mem_reserve_failed)
+		return;
+
+	for (i = 0; i < reserved_mem_count; i++) {
+		phys_addr_t base, end;
+
+		rmem = &reserved_mem[i];
+		if (!rmem->size || rmem->dumpable)
+			continue;
+
+		base = round_up(rmem->base, PAGE_SIZE);
+		end = round_down(rmem->base + rmem->size, PAGE_SIZE);
+		if (base >= end)
+			continue;
+
+		memblock_mark_nodump(base, end - base);
+	}
+}
+
 struct rmem_assigned_device {
 	struct device *dev;
 	struct reserved_mem *rmem;
-- 
2.43.0

