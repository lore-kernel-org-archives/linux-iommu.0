Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058CB30F939
	for <iommu@lists.linux.dev>; Fri,  7 Nov 2025 08:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762503205; cv=none; b=JBZwu1j3PHyv5FitfO6LuTgT4GpuTwINhLVo/mVvvqMyAgSCOO9QxOck/lekgdlZibdf7cC5WLQ3VV5KyRhaS80rlW9PQel/+NTwx3HKSuSsY2d8jGam6/xEztA8oCYGQd4hVvY5aIIDDmJnf9PVXmdnVZGnr0n1vSeXAIDAj+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762503205; c=relaxed/simple;
	bh=l70ZHuFXGxCuiZ9UWHRnDufmsHg5/+S7082Atj+1UWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcw4fjEJdIjep9xSCKKiEX6WzCZzY6YutbglfmVBwbsQBfBSvuZUGFaQi0oeokTySJFpA/gAyzWy/dJKKxnoG+vH5pgpQ7jHhJ1IEnwmRuCIzAnUVUzGEdyWW+ZXLR3DIyjg30+lHYB69EEwp1xUNBFVrpkAg39NJfQq1KWBeYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRYEU52r; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRYEU52r"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-640b2a51750so992068a12.0
        for <iommu@lists.linux.dev>; Fri, 07 Nov 2025 00:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762503201; x=1763108001; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/S84Bq0H+5Q5GEwboYARmckBLSU9dA4Cuq2qpko4lg=;
        b=fRYEU52rLharR5Vua96qAttUNAyoMXsgZU/Lux1oXo7sZdhX7dagVszHR1+ubtKRTe
         jRvE4r7eMy85IVTGt+oh/qCf0sd4VviYwtMpNBgJCxURuwrNKo2MqWbkMZDUZJx13KFv
         SKM9cG8Qg1ANa8XWZ/NNlk/3Nh8qEqh4jRTvBrURfeKvQ+hnXzekNp68MT4s68GJfBxJ
         xogf6ky5Mbnw9495w93sccdpt0PH6Je6oYG/Hf5mzyXo88F5796y19opke5qg8Xv95dl
         zbc7kGuBsg4pXW+61eqQEd2t0qNUdhPsZFz3ike9hhEwZ+aJ2k8lLQRDnGpp4Wxg+2/N
         zbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762503201; x=1763108001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s/S84Bq0H+5Q5GEwboYARmckBLSU9dA4Cuq2qpko4lg=;
        b=touWcyRYvIX3psA9dasirKZwA8B2Q81MegFLpnMSV75lFkNmWhpzlnKGb0Lxp+XqpJ
         u6IR/oSc/C0zKlzAK6HsMKl5PT/ynzI2M3BiM7QCppr3bEg/uBEI7Wae/ytGZab0rrl9
         6LWlDOv48yQUj1pIhCSBVgaUJi2BVdT0R+D8maQIITUw5eZYOejgypkGBuV5d/4k6TUr
         TthpnD5bvn2EtJER3KMsvYsstSrEmjaQJ4lvJGJdpSSqrxKCV4OEeN3Qp95h/XWSVKYX
         cHZ21h/ttWVfaW0BgAqPhgjAppKMWyvCO1fgBCicE6nnjHzubsqGe0+J4lyvif0WHIyF
         ISDg==
X-Forwarded-Encrypted: i=1; AJvYcCVMaMVJ23nOiSiYB/lSX1NoXTGOZj1OToOCkEx35jX75cA0wskATI2y5mYSFnGQs1KTJGymMw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQZHjvHEKUGlyo/5+2qtSQtxrLTVJ/2ERKPtld3nL5fSUgey2U
	ll+VHnmo6GqF8vktzT3xtK4mA23Ed8DC5GN8xNZHymBC/Qmd+7qAzXRF
X-Gm-Gg: ASbGnctD2cYGNjL/SJJX15bi2Dc0sphpG1nkmmy6Y2GP+gn0hRgsweOjEvWTd7Ks+0X
	9fAwm+jzxWimHsU2e4Q5wTZY2t686sOnsggzBrfvNxalp//ieN5fZnTqXRK+XVs7pQSudAMmbwO
	JJ+4Opfstv4TQHWAp/YVywrGWAlDXncUaCRVyIhGZV9adkW/PZDWoPq9Wb89V53a0H52cQP8pgz
	vHc9jB8jap3Jj7byUFniwHjwV5XnAtYf/dGbK7HEcK6xGmDWkdxI3Rxrj4i28yaE715ucCM5xAu
	U6HQQzYAm9JL2/UBKI9bFsLmqJ0sFRf5Do1Zy/TYEEuk1nQFUBFjACOp1B8r8V43eY7VmeFuTRG
	x7dWiEar4rwTZm8OWK/60RsObbWcOGmRnQg5A7RjEKwyXWhk3s5dKdZznrtKmcRZkznEmBLdaIO
	M4AtWkeg3Ai1U=
X-Google-Smtp-Source: AGHT+IGeKtv44GcSyZP8wA09Y2J6Plyg1nStPrUzCk/QO5GDH6nrlZ7OMpI0TvErsPPE6Q92rFcohw==
X-Received: by 2002:a17:907:3d45:b0:b70:e15b:286a with SMTP id a640c23a62f3a-b72c0d9438emr243107866b.57.1762503201240;
        Fri, 07 Nov 2025 00:13:21 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf4fbda2sm177442166b.28.2025.11.07.00.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:13:20 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 41826424DA71; Fri, 07 Nov 2025 15:13:12 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux.dev>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 2/2] iommupt: Describe @bitnr parameter
Date: Fri,  7 Nov 2025 15:13:01 +0700
Message-ID: <20251107081300.13033-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251107081300.13033-2-bagasdotme@gmail.com>
References: <20251107081300.13033-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1579; i=bagasdotme@gmail.com; h=from:subject; bh=l70ZHuFXGxCuiZ9UWHRnDufmsHg5/+S7082Atj+1UWA=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJm8K/Q0zOYGTDgr9jri977z+QzvRDbO6GgTcj+x49BOS S0H9z8VHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZiI13lGhk6LMFHd7FuyC1Id DvPLM+1jsX2t9/75qszetQw2Nvs8NjP8jyxeuf3fy8Vh786WbToquy7djy97wZXeWOOsmF2Opiv OcQIA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warnings when making htmldocs:

WARNING: ./drivers/iommu/generic_pt/pt_common.h:361 function parameter 'bitnr' not described in 'pt_test_sw_bit_acquire'
WARNING: ./drivers/iommu/generic_pt/pt_common.h:371 function parameter 'bitnr' not described in 'pt_set_sw_bit_release'

Describe @bitnr to squash them.

Fixes: bcc64b57b48e ("iommupt: Add basic support for SW bits in the page table")
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/iommu/generic_pt/pt_common.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/generic_pt/pt_common.h b/drivers/iommu/generic_pt/pt_common.h
index b5628f47e0db40..3b4e371089140a 100644
--- a/drivers/iommu/generic_pt/pt_common.h
+++ b/drivers/iommu/generic_pt/pt_common.h
@@ -354,6 +354,7 @@ static inline unsigned int pt_max_sw_bit(struct pt_common *common);
 /**
  * pt_test_sw_bit_acquire() - Read a software bit in an item
  * @pts: Entry to set
+ * @bitnr: Bit to read
  *
  * Software bits are ignored by HW and can be used for any purpose by the
  * software. This does a test bit and acquire operation.
@@ -364,6 +365,7 @@ static inline bool pt_test_sw_bit_acquire(struct pt_state *pts,
 /**
  * pt_set_sw_bit_release() - Set a software bit in an item
  * @pts: Entry to set
+ * @bitnr: Bit to read
  *
  * Software bits are ignored by HW and can be used for any purpose by the
  * software. This does a set bit and release operation.
-- 
An old man doll... just what I always wanted! - Clara

