Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793808481;
	b=lXhGfks4HK437zXbUbuopC56pl+2l3ed2SDeomzfD1IV1TbDaDUcW6GKl8bafa0fTwaW
	 w3fxj8KQ8Cl86oOLZcAxwH1KqF0cMBcOW1Y0QjdZkyEIhvFrtiGRbEpXZH4kOFirpSCNc
	 Z3XfiR9f7/e64VCdtmcoCtk2wz8dzp2XfTiPjzYaP8t66Kpx8AsgEeK/dB//PGasR1Mxd
	 W5o19+J7KywZlXu4Z8pgJ4RaJ1i/urj/7YYLZNVSFh0oGcqi0R2RBVanCN04CP9mTIk2w
	 9tsLpjQd+tR405p6BehILBTlcEN80aFI5wqGCTvlXnlZd2ygi9f/+7n85czo+B2lm0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808481;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Iv4RXwBNHOO2aggVuJYm+8Pj166cA39M0Lvmb9F3lJI=;
	b=A4Ew0WDTZ0/d1WDsU965zxWUfqYCraSnMFWZrcgcv6O02Tb5bt+TLaB+XuLDtH7BDzN0
	 LW3Ud2QoNgrT4k/Wqu+dvuPsZ+Fc+7RzT+/Lyf8EXzQXkati6hMun4Bz+S3fYqd1RekEO
	 gXqTYZrdbDxnwk2JRTJX7vU2CHO3RDCqDc0CBPxwKplMtJSa15Ba0CxZrzgSs+7jaIcaF
	 +AheaocSVdVw3flIDURNhGspvx/VfEwITo08VKcBGdqqjCZKUhNKV7dxcd0SU3CPN4d3a
	 SKHWLc4bEUZ7mf7gj3JAzrHRIo8zMszcgfPZcFt+UkwjIo171N6kgFOle5YT2psJf/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Pxijlgns;
	arc=none smtp.remote-ip=91.218.175.221
Received: from mta0.migadu.com (out-221.mta0.migadu.com [91.218.175.221])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2055606A330
	for <iommu@lists.linux.dev>; Wed,  4 Nov 2026 16:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2055606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Pxijlgns
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=SPSYp0yqavBrNqQ10V1mFie0J4jx+cxl1tKGwJPYS/8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793808478; v=1; x=1794413278;
 b=PxijlgnsdzuZ7F0s73KoYTZDQ/YUO2RwcxtpNH/Fdj+Bu//pvBviCM+dxN2XvRxZ4EhUIhrk
 Qhm2IAJpBhaCe1JrpxZErcrKSyHbWriAnIZN0hpyZQMOLgxf4WO00M4Jq+7uCEJsILC8452nqej
 pp7WKUbINI8e1FDjRemQXSmE=
X-Envelope-To: iommu@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 92d7f9eaf78d179f;
	Wed, 04 Nov 2026 16:07:58 +0000
X-Mizu-Trace-ID: 92d7f9eaf78d179f
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Vineet Gupta <vineet.gupta@linux.dev>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] iommupt: Make PT_SUPPORTED_FEATURE() return 0 or 1
Date: Wed,  4 Nov 2026 08:07:20 -0800
Message-ID: <20261104160722.1637541-4-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104160722.1637541-1-vineet.gupta@linux.dev>
References: <20261104160722.1637541-1-vineet.gupta@linux.dev>
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

GCC 17 adds -Wconstant-logical-operand to -Wall. It warns when an operand
of && or || folds to a constant other than 0 or 1. PT_SUPPORTED_FEATURE()
returns the raw feature bit, and the fvalog2_*() helpers use it as an &&
operand. The build fails with CONFIG_WERROR=y:

  drivers/iommu/generic_pt/fmt/../pt_defs.h:255:51: error: use of logical '&&' with constant operand '2' [-Werror=constant-logical-operand]

clang has the same warning, but it checks only a constant right operand.

Compare the masked value against 0. All users test the result as a truth
value, so the behaviour does not change.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 drivers/iommu/generic_pt/pt_defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/generic_pt/pt_defs.h b/drivers/iommu/generic_pt/pt_defs.h
index 707b3b0282fa..51a9c1c5fcc9 100644
--- a/drivers/iommu/generic_pt/pt_defs.h
+++ b/drivers/iommu/generic_pt/pt_defs.h
@@ -200,7 +200,7 @@ static inline bool pt_table_install32(struct pt_state *pts, u32 table_entry)
 	return ret;
 }
 
-#define PT_SUPPORTED_FEATURE(feature_nr) (PT_SUPPORTED_FEATURES & BIT(feature_nr))
+#define PT_SUPPORTED_FEATURE(feature_nr) ((PT_SUPPORTED_FEATURES & BIT(feature_nr)) != 0)
 
 static __always_inline bool pt_feature(const struct pt_common *common,
 			      unsigned int feature_nr)
-- 
2.53.0-Meta

