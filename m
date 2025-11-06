Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B238A2BE638
	for <iommu@lists.linux.dev>; Thu,  6 Nov 2025 07:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762414739; cv=none; b=MHMrSil8TTSEF9LULvQajgi1b3wzDPU4zcl36lnx/wIq3xudX5JzgPiNMroCTBz3SwLQIrkHsDUzsoEz3LMQ0m/2KJZu14kZ6qdjKpdt+76kax8ekYUErrYTWNB4i5br31qGJu/NQNEqFjLLZ6WQ3SlXUOojf9tYVSV+3m+USbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762414739; c=relaxed/simple;
	bh=e/6TSSJQOJhHj68tFAxKU6w6UcIQwXM+cEaZaP7McA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnmVicQTy1tBaniiQRseZT7PBmXgi6JiAKlB7xUgll++Y8dcUFu6H2kHItP4/QYQttD6xcUbir2ZTxRnAAUddLIowG39MWfWBFx+hv6YuOFYL6lD1M2txxuWr1gyLJepGrrjVlHp1hQ2U6ZqSHzps+hcbqTjClyDhTHRn5tMT7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAtEn+8l; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAtEn+8l"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b67ae7e76abso371622a12.3
        for <iommu@lists.linux.dev>; Wed, 05 Nov 2025 23:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762414737; x=1763019537; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jf6KQbaWXXRW/TKl+9mZAaUOer2HLcjSLNcGRazOzGA=;
        b=jAtEn+8lKcoU0wWf51gS1d+OHxOdjsBLNcVFWuLg2HZ9OWW48ShibRAzfgu4vU+dVe
         PnxgXmPj4D3ZbXKwVDeZaIbFkkIBU7i51UM+1uqmKYsXqt+m0APL/+/9BL1+MeWL8dB9
         tm4exwpIope4TxumBkMQhkhs2IusJZlkvxOewgFVGAFriQ2iVeVC6c1QyoNmyXG7A3MC
         8IgONbrCc6L5md2JGam8ngtP055XcaQpy7Im60GE0f0RC1REstmzrk6Otv9DOnpt+uOO
         b0bsBHlLj8sqLlcIN+iLu71iIaL2j+EbfWr4hcKTmWQtVMP3AaxQlnUAprTKDvivrfJO
         ewVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762414737; x=1763019537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jf6KQbaWXXRW/TKl+9mZAaUOer2HLcjSLNcGRazOzGA=;
        b=kSe9/xXSmomrl0RRLWDtD/ZS6DSH94yP62xLEmPDQJNp4r9zyUyv5TcQ+DjeoQuoos
         j/qkxYtFnkNH9kqeyKIywpSVyjU6kODyD6SP2vOw6OWVFAGCK+kCDdI7I0JYKdpDL0s8
         tBB5q1CczAnx92dNyXG29QY9/KFrBqLTYqDWK+UGyK1Gwqbn39B5VWQALq8CgTECAUBz
         KlGrNcW6KVgufeEj8rPwJ50BA3mACw5EIx48sTSodxyXVmHlc7AjY6fVu7Avf4+RwiDg
         pOrk9NbIBTh1+9tqbur5ccJyTB1gWN0uel+PRUIhkD5Y8pK3GEAJumQWWCpmUkXzT5zE
         vywQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWd6+/2HR2GEho13GNOTFOhsuzcVY0B7NnyD+jAgiknycFYjw0T7lN+oqB+DxqzSUnvS5iHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9c9G+902YvS74gG9rLyW9IrboC+4TctHVRnfGx8vfCVkTZw9C
	XJB9BZALBevamo/ThHaqEy9LbpLKKY83dfXctHRmBY3mXyrSELRhgmsF
X-Gm-Gg: ASbGncvw+hVVswI7ZXxPY/j8irtsOMaZZOTjadZOwRjsCj2yyDtzMNmutmIIvNXTDTR
	CKBWza4TCOfYgPRhMBNQm/RK+w7v+Aiicc4IpmaQyjUQJW/kEx+j1wyQhHwNucSCaSTMzmPH+zq
	sV+cE4SJSC2f1GBgNKvLEVhDQkwU4rnIw0DthGOFQP0/E184f1s8RusL6SVsZul3suldP2kSvXU
	29bFIKqtIKr8xonv4l8h70Tk/fWlUfz+dh/uK66J0NRYzP0X+4aaXX7BNyjd527NGMvgOnF4EzM
	btufckDlBn0A4+D5erHtUsrm34sZEjF475CZc63T/oJqIyKjG0l7hFOQ0tePgDjJcar89DRkFoZ
	p+KnIzMmdygqQfAu0Wby/Jj/sY82RscNZChpIaiityE+g0xCOXj/fV8tMxIALe8nPQgDF0fahFv
	f4W6RvcRrDm8g=
X-Google-Smtp-Source: AGHT+IEviUEYxYzZKu0NJgXfavETj2BVNx3f+QV327vSZX9DqBgD79uVfXkQNhs/ljNyRMIF2MkK8g==
X-Received: by 2002:a05:6a21:9986:b0:34f:28f7:ed78 with SMTP id adf61e73a8af0-34f846fdf0dmr7897940637.25.1762414736633;
        Wed, 05 Nov 2025 23:38:56 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba902207232sm1399020a12.32.2025.11.05.23.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 23:38:55 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 10AFF420A6BB; Thu, 06 Nov 2025 14:38:52 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux.dev>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH 2/2] iommupt: Describe @bitnr parameter
Date: Thu,  6 Nov 2025 14:38:45 +0700
Message-ID: <20251106073845.36445-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251106073845.36445-1-bagasdotme@gmail.com>
References: <20251106073845.36445-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1530; i=bagasdotme@gmail.com; h=from:subject; bh=e/6TSSJQOJhHj68tFAxKU6w6UcIQwXM+cEaZaP7McA4=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJk8/q/yt4tPPxHKzCSWblzaovaGPbBt/c7YbVJp6/3ce tm37ffpKGVhEONikBVTZJmUyNd0epeRyIX2tY4wc1iZQIYwcHEKwERWajP802mtCl/7xFRZvtn4 1Jm+8M/S0tdK/63Q3jbFReLDhFeyWxj+l71+fN8o9uTki5wP2kvdDDZeF58pymBpxiOdw+t4cuF eVgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warnings when making htmldocs:

WARNING: ./drivers/iommu/generic_pt/pt_common.h:361 function parameter 'bitnr' not described in 'pt_test_sw_bit_acquire'
WARNING: ./drivers/iommu/generic_pt/pt_common.h:371 function parameter 'bitnr' not described in 'pt_set_sw_bit_release'

Describe @bitnr to squash them.

Fixes: bcc64b57b48e ("iommupt: Add basic support for SW bits in the page table")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/iommu/generic_pt/pt_common.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/generic_pt/pt_common.h b/drivers/iommu/generic_pt/pt_common.h
index b5628f47e0db40..54c16355be2842 100644
--- a/drivers/iommu/generic_pt/pt_common.h
+++ b/drivers/iommu/generic_pt/pt_common.h
@@ -354,6 +354,7 @@ static inline unsigned int pt_max_sw_bit(struct pt_common *common);
 /**
  * pt_test_sw_bit_acquire() - Read a software bit in an item
  * @pts: Entry to set
+ * @bitnr: Bit to set
  *
  * Software bits are ignored by HW and can be used for any purpose by the
  * software. This does a test bit and acquire operation.
@@ -364,6 +365,7 @@ static inline bool pt_test_sw_bit_acquire(struct pt_state *pts,
 /**
  * pt_set_sw_bit_release() - Set a software bit in an item
  * @pts: Entry to set
+ * @bitnr: Bit to set
  *
  * Software bits are ignored by HW and can be used for any purpose by the
  * software. This does a set bit and release operation.
-- 
An old man doll... just what I always wanted! - Clara

