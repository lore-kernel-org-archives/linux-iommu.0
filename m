Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795770539;
	b=cuii0o0oP1BfSiMqHwPo1VyaRD/dBxjZ0EV54xb75Ws1W1/gtN/InZZTAtvHzXoPFO+c
	 NDD3WPv1CDWpvQJuSPxv/SLeRYyXpNjyYB3+tgVEvhQmKS9nmKVf0xBcxrJ6eVGisS6wc
	 cRexXg6fehuGBJMVzbE68dp3O++V3PvLwyppN3sj9df+UWIciVilpjrAyv8KwSOTaiGU9
	 asdmrSd36vZT9P9GASbZn85fgi23XMaECUHdb5SKcuIvbhQW+ZTQMcBYGamsR0Ue+Opl5
	 ulwrS4cOjTwEWB5vYryfKikueJcC624KmZN8qa1Fm51Jhf2nGZ1LZcAOQQ2zEViIKUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dYWYab/i6KswA9jBoR7n0gUVHNmGP1kEM/igKErB1/4=;
	b=OpV/skcQyfL6xoq0F9UuisgPy4Wp7adtii9+bb1mHe9w71WuxbxlIE3CJpyRNhUP3hoc
	 3lVYeEhL5Hz8nEVutw3PBvyPzX3mEA9ybuGOj7+hDNttm4djHHaJaluzX3Oyb4aynvajO
	 pM+f+kSs2BQvMSoW6GXSYP97ybRSztJ2w9914gJqQjrP7PK9UMISSn8M6qAUANy1PX9hQ
	 +ExY9UrCCkrwwNRKnPnHbKsZb+TNoshEV2e+DHOR6a5TkV+qIwdg6G6J22vDhBwQFqp71
	 M6mXsTQUE7ZtxUwTFvs8+2DgzKBdnlsi1oPDSCgINIuUbvm9UDWk3HezzWVw9AeztkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="n/3zwDtn";
	arc=none smtp.remote-ip=74.125.227.128
Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BD1606A321
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 09:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2BD1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n/3zwDtn
Received: by mail-pj2-f0.google.com with SMTP id 98e67ed59e1d1-3b094d5f1b4so1403137a91.0
        for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 01:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795770538; x=1796375338; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dYWYab/i6KswA9jBoR7n0gUVHNmGP1kEM/igKErB1/4=;
        b=n/3zwDtn11fbmIgvIxMkuNd5QeutSYqyB7isxJctZG3reX8wnRW1KBuNvpSGSO4GtG
         yO+xy26o6UozfnOdvnykiQPswO8Kvpsmk+OKOCdsb9PUkicIUfC5z0O3wty1ff/ZeXUR
         YBLvnSdJLIg1vBeNqhI3dmKSfhxooLdClkxTtNxF60lae/8cKVOmnU383ZPKlFxrDjDU
         PBtYXInqNjTyNomzIGR3GzhEK6ZYLCpJid9Weasfvu/i8K5kiQu5uRikEcFKm53m6+cL
         l9ADlErz+mzwWa5ZiyhCc5ULFZH6264qZbpfNU7Nj6BFiTBwNCNu1M9VAgb++v68sgqx
         ec+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795770538; x=1796375338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dYWYab/i6KswA9jBoR7n0gUVHNmGP1kEM/igKErB1/4=;
        b=XgvTxu/svVUDjEpZcLLWMS0T437aBQ+XvV8rNu6h+rGfNgKkuurL6imYgcMQ8nhhVl
         BqiGFkSn8NMGreNwHQ4DE0ecVt3/qwX54QmSmxUzxUaV/obosGJzNRbj2x7Z1bvkmNBm
         pTc7cxLD+WZKTwHDNt8M8ZDYmGuXIMz3qMasy8o6rfrbulw1mg22p/Cp/nN017TJpkWN
         TH7B3l90GWnCb1Q91BJtJwOaAPjm0jwuoYBoE/n0oyd1FTZevDFXAz0pyvWOmqkGJ+/i
         Xpniq/88VdFpM96lRlsBrXBNY3/7PipPlZ6KUTB09Rk2pjGfGYHELCBtnoS3CgPec+w3
         Cang==
X-Forwarded-Encrypted: i=1; AL+hErFGkVfh9iD/8Y1pBdMXruaaizocjjPuQw2brW8WstLCbRRyy+k3tR0pQJnmfffaI7x0/TzQCA==@lists.linux.dev
X-Gm-Message-State: APuU4Z90nn5DXFIWBrCoxaL+TVTRAAQKybaAnrZ6lYBrKZ9gzONGSY7b
	goIyBFFVTElnYjqY27o78g7zk535JA8tAaD7xp/ctuhnMcpwGSSE7G0L
X-Gm-Gg: AZFdTZdBl/vRXLGmDFNWgAtSZ/0pfqlCnB/5ZQyMyVJPedYHiZ+Iz4QZ1A+JfUhBNnt
	zru8FMcwcQIO0Ravs13/MZ+6AhTznpDI+8Si22OQj/5F2i4un3IYuds6WMG6/B/dSvbcfUfckk0
	2vyDj1OelOHA5VKkEtgQ7BXVUJ5vYSgyk3Kxbi+m/9UYShNM2v9deRQR8h+72dTPQb21NKP7Vnm
	2Y5D1SPaqPnI2sVdcoJm3jTi/NE3ESkaJ3M+G4Md+Scz+HvGVN1V5IB5AFalLlA449qGjzTSqdo
	nnCAf0oBgYmqt1EuC2G+BdoKwUdGOJM8991W+AGc3Ja6e3Xk0g2iJwtkLFP8MarTWjJfkjVWDBt
	sfUlzqkZZoH2x0uiAQ3OPwqJ5QIxj4yF2iGvpS04kW9JqjgkpUPkJhpd/U79/27UBIWg6oPrJja
	xhpOfxCw813Z2gfFTmJvC4pAN1+GELjJwGmhK5n5p/VrZbWo0Am6c0IvWR/pHT6G55bkcObNA8L
	EwLCwjC+gfmexFvjY117IDCEe1P+06iDOC6RwydULGvZ5nkcyqAaOn2M8EL1j6mKToKNWvRgxkU
	1DhUeZ8Bdy95PxHWXVPFrC5mcRjvXwK0tzwvKJbQNZE=
X-Received: by 2002:a17:90b:3d92:b0:3b0:91ce:672e with SMTP id 98e67ed59e1d1-3b41c8dc8a3mr20396792a91.17.1795770538277;
        Fri, 27 Nov 2026 01:08:58 -0800 (PST)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d06ee37sm11718725a12.28.2026.11.27.01.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 01:08:57 -0800 (PST)
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
Subject: [PATCH v10 6/8] of: reserved_mem: add dumpable flag to opt-in vmcore
Date: Fri, 27 Nov 2026 17:07:21 +0800
Message-ID: <20261127090723.741253-7-chenwandun1@gmail.com>
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

Add a 'dumpable' flag to struct reserved_mem to decide whether a
reserved area should be included in the kdump vmcore. Non-dumpable
regions are later marked MEMBLOCK_NODUMP; the filtering itself happens
in memblock, keeping the arch kdump code independent of the DT API.

Most reserved regions are owned by devices and do not contain data
useful for kernel crash analysis, so dumpable default to false.
Reusable CMA regions are different: their pages are handed back to the
buddy allocator and may contain key data for crash analysis, so set
dumpable to true in rmem_cma_setup().

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 include/linux/of_reserved_mem.h | 1 +
 kernel/dma/contiguous.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 7a940d1815b6..caac366bcb66 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -15,6 +15,7 @@ struct reserved_mem {
 	phys_addr_t			base;
 	phys_addr_t			size;
 	void				*priv;
+	bool				dumpable;
 };
 
 struct reserved_mem_ops {
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 865d7cd2f0e1..ff92dfb09649 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -555,6 +555,7 @@ static int __init rmem_cma_setup(unsigned long node, struct reserved_mem *rmem)
 		dma_contiguous_default_area = cma;
 
 	rmem->priv = cma;
+	rmem->dumpable = true;
 
 	pr_info("Reserved memory: created CMA memory pool at %pa, size %ld MiB\n",
 		&rmem->base, (unsigned long)rmem->size / SZ_1M);
-- 
2.43.0

