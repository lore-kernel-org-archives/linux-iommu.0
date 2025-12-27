Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6152325499
	for <iommu@lists.linux.dev>; Sat, 27 Dec 2025 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766858267; cv=none; b=BFYckT8HTyBbcdEEbIY7Pq5fwqPMr4iWszxVgMIc63EQ5XCEjK0UaGwHzvK5bVK45qUZ1r5iQrrFwCg/WWfB3mBRu8RWRFkdYW1ON09D0oSyoZz3vNtdsaY+yKkieIU6oPqqE0f9i5w32J8ZrFZTPmumFKGXbs/BwWPYNJ6SqZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766858267; c=relaxed/simple;
	bh=eD3iYXdURVU7ivpnp8kzkrUW6V98XdXk1NBDNcEtLoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7bzMKRYpYU7Ikres6gLzMaqM2iZPnLnCmKTEncBFSZi8nBm4dgeCKKFgv+7/JXYqKRUTpXzOyp+L7YnAYO6wBYDjGc5SP+oAmPTXhGpENsJgjfrF86C6gKvBOhC6ntJc4+T4RENS8ehPE9wsDUYssqVgzSeUDMoU/cWIOcxcnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L3u03/Iu; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L3u03/Iu"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64d2c50f0d6so8422539a12.3
        for <iommu@lists.linux.dev>; Sat, 27 Dec 2025 09:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1766858264; x=1767463064; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBvbnMf2C0DYY1/cX5j0uTa214DW3xpPw14cAygrVR8=;
        b=L3u03/IujGOOeCfM43lBbuP51V9G3Bx+FHAcFbKSIfFhFEMyO2Cc1FfrtF9E55ah3U
         VMKxzenFJoHrXAFAO2IC9KuEaEhXJrub4h7WhOW7ZQmsQbZ1Pnx+Yhhyr7BL+7AkiAjJ
         +/FS+yVhWURTKKBOKkbN5IOEc9pHK6f5ieskg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766858264; x=1767463064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QBvbnMf2C0DYY1/cX5j0uTa214DW3xpPw14cAygrVR8=;
        b=WWrUkNMcdkgmOxs32xt7m8zkAYcb/ObcU+uukgI1ruVns+pTasjvUDMHReKugF2RWT
         VynJPinAbLkzUtCN/wO/wWTtmJyxY4JnB6YZfVYnpJIW33xMWWFxXx6+VGvFScSIPMXf
         sIfG5QukOTW/7uUzaPvPDEqsCczaA/MtSdod/bX1AWBx2s2/rJ9W5D/gd7sIErKrnkCI
         kmyoPbZ4qtM25/bFahW785Mp5R5CTe58eOHtei4dXOohid25xZsMDC/t1EdxnQmoFKl2
         Kt7BE5wl5kMK6Igm2S7KJI+bcjzzHim0JDkigv7h6sWY88hX4v6O6qFEFXrtaeVmiwK0
         GSsA==
X-Forwarded-Encrypted: i=1; AJvYcCUlsdClQAm8zOV76Tz4IPpx73XIq00oyrVNUAkCD6p0cmOGc6qACbwOIxN6lo7g4Z9WUmeGWw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXPky0ArSuXqyn7X2/UaGgUCcA5d11Hv9j9rb6W11Uy91FpqM8
	91tbeRNO5csCldEh/SKaDGw2z/sGpR2lpSqfmxkPalleTg+4kYJKsWvrJNuzAIpryQ==
X-Gm-Gg: AY/fxX6dubO3ZUxm46Lq8ia9rmjdtdPprgJdQdV4eXAeATLUMii+MxoUy9COghuRJxt
	oYFI9mE3njRAwKDuBIPvzb96VAXwB97eiPcrpbZ6xuzlyRF7VtI2aa0ePF97ezuyEhGpT4kO100
	X8X6wObL/7PRpUg0vSvEnaGk6m4HGjhOs5ZvXcKhdQY8IYcoEKkQIoDh40byzrnzhYGKmaCbMST
	nqgirfcpWp6rp30XUWg+4wO1+i8GNMaVLp8hVzzOqc1uxNdvU7zv3yc0uMtKNGHYosfCBlOorhk
	3upZeN3T4EQoIqs3MT/nBcBsJ74XACkmioct0S2fvdOb4zHjr3DuUGMkkkCfI8mXbj+UVzh6qSv
	XOzachoqtEYPSgRe/073izxF/13p52+scPzZJ5P/w1vrzsUlc6anmCbdu+1W5kpiViduI2xs+vF
	Ek1EqsWdyiTzi36VpDyiNFpPVfX+HgtA==
X-Google-Smtp-Source: AGHT+IGih0ULV/W8bSFAr4ZprCfSTSgG5TpGBRvvZCuEG5crHzxOQGocD6/MwueeriHoqHyk+ZYInA==
X-Received: by 2002:a17:907:7f20:b0:b73:6e0d:4f6b with SMTP id a640c23a62f3a-b80371538f3mr2505874866b.36.1766858264120;
        Sat, 27 Dec 2025 09:57:44 -0800 (PST)
Received: from localhost.localdomain ([2a02:a31b:20c3:6680:3d12:d2ea:4ee0:347a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de1421sm2793889166b.41.2025.12.27.09.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 09:57:43 -0800 (PST)
From: Dmytro Maluka <dmaluka@chromium.org>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Chuanxiao Dong <chuanxiao.dong@intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmytro Maluka <dmaluka@chromium.org>
Subject: [PATCH v2 4/5] iommu/vt-d: Use smp_wmb() before setting context/pasid present bit
Date: Sat, 27 Dec 2025 18:57:27 +0100
Message-ID: <20251227175728.4358-5-dmaluka@chromium.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251227175728.4358-1-dmaluka@chromium.org>
References: <20251227175728.4358-1-dmaluka@chromium.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the previous patch we already ensure that the present bit in
context or PASID entries is not set earlier than setting/clearing other
needed bits (assuming that setting/clearing any bits in them is always
done via WRITE_ONCE, which is enough to ensure ordering between them on
x86).

However, it also doesn't hurt to add an explicit smp_wmb() barrier
(which on x86 is merely a compiler barrier) before setting the present
bit, as an extra safety measure in case we still forget to use
WRITE_ONCE when updating any other bits in context/PASID entries in the
future, plus for documentation purposes.

Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
---
 drivers/iommu/intel/iommu.h | 10 ++++++++++
 drivers/iommu/intel/pasid.h |  6 ++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 5bc69ffc7c8e..75576885314b 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -909,6 +909,16 @@ static inline void entry_set_bits(u64 *ptr, u64 mask, u64 bits)
 
 static inline void context_set_present(struct context_entry *context)
 {
+	/*
+	 * Make sure to not set the present bit earlier than updating other
+	 * bits.
+	 *
+	 * This barrier may be redundant, but only as long as any context
+	 * entry modifications use WRITE_ONCE(), which is enough to ensure
+	 * ordering between them on x86 hardware.
+	 */
+	smp_wmb();
+
 	entry_set_bits(&context->lo, 1ULL << 0, 1ULL);
 }
 
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index f8fc73676192..0d50959a0495 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -228,6 +228,12 @@ static inline void pasid_set_wpe(struct pasid_entry *pe)
  */
 static inline void pasid_set_present(struct pasid_entry *pe)
 {
+	/*
+	 * Make sure to not set the present bit earlier than updating other
+	 * bits. See also the comment in context_set_present().
+	 */
+	smp_wmb();
+
 	entry_set_bits(&pe->val[0], 1 << 0, 1);
 }
 
-- 
2.47.3

