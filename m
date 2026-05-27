Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CC0380FFA
	for <iommu@lists.linux.dev>; Wed, 27 May 2026 03:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779852615; cv=none; b=e/k2qfQ/B+7ApjdEeZSp/3eg1j5f731IwjAofPumPW+excYiYAjHUg1N24a5zFroKaD5rmr5b06tDL+399qGkoyWplS+/slAGUyqnYdRMa8ijLWfO4Y/3BK7udpBbIfXt3GluBgLUw/xySPMuxgPIUmpf1FwaeVdypMrmLgtNkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779852615; c=relaxed/simple;
	bh=0GF77B/l7C6m3TWqquzykyeLEm1mct+rjQ45uWrXXdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rg5nmcGG5iMlt5AAinaGRcKlDAROzom0MVKpSSpcwWIu0a0snx+N9t3CCMTMAKAb0ckLVMMOaEJgJs0OWnMZNwamkLh4GzqjRv6ubKqMpzGHnCpqtS2IPQ6JBUdB0NY9uPdyVISvN51dHy5zy65S0Mn6cP2CElTmOU04q/1k8FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9ajCoNv; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9ajCoNv"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-82fa8d6425bso5126334b3a.0
        for <iommu@lists.linux.dev>; Tue, 26 May 2026 20:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779852613; x=1780457413; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmAA5z5t6XdNPHFYJxkTDYvo5Zq4DgJyNWi+6SrmBDo=;
        b=P9ajCoNvqNa00lzzEVmUG7MBoy9aq8/B5V1KtM0zBSqE7jrIxYqAhTDAZsS7bz5wzX
         BLbq/aTOevPbw/MpO/rV2z9aIQQZWPqwNFAV6IdT7BWreDiyj3afD4FHcSh/l1+46F2A
         HcVFVwZxB+bcLTqeA8RTzuMCtlHUKzRfcpY/9RtJMenaiOFQ22AaeTgvQjxkMzLldtXH
         2SNx4B/elgSlHx+YFgFuVl5d/Bm21vS5p+ts/1ZXKpKn7AQH/YfyD1hO2byspONSlWYv
         nXEiTYM8TTix9GcMXqTxE3C3Ejvds8HOmXRjtZlz+OqrgVdApFhmeIQ07PZel8mDkPoC
         z/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779852613; x=1780457413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PmAA5z5t6XdNPHFYJxkTDYvo5Zq4DgJyNWi+6SrmBDo=;
        b=leBYMtlVBxQYlGahRKfptMFzFT+O684xP92dcv1LfF/QNyWg9Eh8kaQkLsO3bCo2kh
         CZxICzurLEJrMeBeH5LxurixaIv1kHFlhxuD4aPfLYy255Tk9vW2/FTypgboDdwQioFU
         76etp5Tls91kn1oJbT+0eRsRKSFMrYU/bH+VMWmPfdcQZfJd0qsMiSMw5/kXHWIATpGN
         7Po2A6N08RFgAoKjrG9rNDhIH+RnFEyygkXxDTHbSLi9O9usP+TiiyX5pSLV8seaa1Of
         +g+nWk39y0yQV6kEGhBrw2oM6m6t3QYat+mYCBRPYrr/+P4TexVFuposLbMNwpY18Q7+
         STAg==
X-Forwarded-Encrypted: i=1; AFNElJ8mHGahzrH46FMbivc9XWW2yA9IhbUjId8Qf1Rmr+eWaw1NABrBwy+016amffHa9TNB0v/G4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxuZKOqEeu65tNBTL/EHG2ynls2lRT2YLgbnmMAPkmxHAULbsPp
	Mv63T35g9VURLUOo9waIW6/s7036yUGzW+i8FewTnSsNrPi9nHOy/Gbt
X-Gm-Gg: Acq92OGbSM1aR4Fnq/pYTZHlFtla2HJw5yyG4MXeUF1yPwJGDNlM0M1hUPMg7QAYB2J
	Fhu8B1yvsjaSprePfSo8xpYycDBdbeZK8+HzFyTwevqsRdEKmcA8gNQiwPrsj/vf5xvD6k6eFsp
	MCX84NQVQz78XPj4Saw/xIIt1JlGW+/ufnetJeZmntnqgwrGmasnybx5XJpnl6b6V283NoQwIE8
	pp0bH9ShpupIt+2tbKzvqMtdLaGBp4fgveQ5zyUfNqt1zlTzPqJXAdwPpxywQkGFoDCmGrC9XkO
	ZoWL4qGr5StpUTZyS7H9mNXuLDIZdWYjfoL9FtXBQDkbCd2ivAwDhqVQoH9hjfjhvcGi5LRUW7H
	6XEUA77QLi6d/l2hBVAQwcP79htN2biwCNTDnDTHrbLJ4mRSHSdFa/zHL+i8Yp/f5lCQiahR28L
	OM8vj/l6Hq5J0AjHLwmVv2MXNYDPF4/gwIu71BXt5td8GN6O8=
X-Received: by 2002:a05:6a00:1407:b0:838:c01a:7a50 with SMTP id d2e1a72fcca58-8415f406e6emr20083726b3a.30.1779852612592;
        Tue, 26 May 2026 20:30:12 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d7307596sm749688b3a.59.2026.05.26.20.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 20:30:12 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev,
	zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	quic_obabatun@quicinc.com
Subject: [PATCH v3 04/11] of: reserved_mem: zero total_reserved_mem_cnt if no valid /reserved-memory entry
Date: Wed, 27 May 2026 11:29:10 +0800
Message-ID: <20260527032917.3385849-5-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527032917.3385849-1-chenwandun1@gmail.com>
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

Prepare for storing /memreserve/ entries in the reserved_mem array.
Zero total_reserved_mem_cnt if no valid /reserved-memory entry,
instead of keeping it's initial value of MAX_RESERVED_REGIONS, this
allows accounting /memreserve entries based on total_reserved_mem_cnt
in a follow-up patch.

No functional change.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
---
 drivers/of/of_reserved_mem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 6d479381ff1f..05defc91e901 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -329,11 +329,14 @@ int __init fdt_scan_reserved_mem(void)
 	const void *fdt = initial_boot_params;
 
 	node = fdt_path_offset(fdt, "/reserved-memory");
-	if (node < 0)
+	if (node < 0) {
+		total_reserved_mem_cnt = 0;
 		return -ENODEV;
+	}
 
 	if (__reserved_mem_check_root(node) != 0) {
 		pr_err("Reserved memory: unsupported node format, ignoring\n");
+		total_reserved_mem_cnt = 0;
 		return -EINVAL;
 	}
 
-- 
2.43.0

