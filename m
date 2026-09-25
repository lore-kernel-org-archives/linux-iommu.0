Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAA54E8DF8
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 16:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790352730; cv=none; b=nr4piPGjKFawrR/CFKSIAPBpNfaEGs38lYlKagAZfq+ndp7c0Hmb43tjWSuk3st9HE+MwIhyhXGQ6yWD6oI25jlx7at9Dg2T4l/ovnIzAoILSYK8PyJg2gHoI2ZtvX7u7V8J24oFem3n0KXp/mkuh6R03IH+n1FHVDwe1djfhPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790352730; c=relaxed/simple;
	bh=HUOnEjhv9fKfLJ0A1Oqzk39EMDsr2o/axxVNv8d3j7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U56q3w5V/ajuyhexM0677S0dFHu89ISaaB2iVH+BJEEtHhw9ZrQUHzRuy1Kbpfz49JHmxoj4VBORfGc31zU05n0UsqWYWm6bgGq8ShkYdMGjnDOIeX2t5xeoezhu0Muwt+2WGENRn3Tu+jTeVj73BRTSwNz0QMznKE+6/sFnQ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcwK7UPq; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcwK7UPq"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843f22dcb8so855488f8f.0
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 09:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790352726; x=1790957526; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CwRzATKx4Uz1l0MN7TD0eqrZoKpNRRbzLuIcmEq8eCI=;
        b=XcwK7UPqAQEku76114zcH7fRBzspCtdo27Jf7MF0KUbXB4Ku+kBl2trHqrBrvDdD3I
         SkmQGAqnB2pS8AgLOaegi4Mr2T2BvQg2WBtmxBZ6AkBdHkL7MxQX3bkErxOXADisYH23
         ecS8H4y6uza8BmtEpBzNoBPjvgdfw7NFgbWDnT9bGR8wkGrcHc+7Bcp9cj2ps6xqCDgr
         rKtHHggU/r1X6kKuiSHY/JvTeQ2BarrcEB3L1OHDInwM1+uDYRAVhhoxBrif0ITQLwnp
         ponowJsHEGD/a2FZOORnatEusOPT7TKYsBETTnMbyY3jWxGSOZ5XDGUQj70D4yiSPnAg
         MCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790352726; x=1790957526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CwRzATKx4Uz1l0MN7TD0eqrZoKpNRRbzLuIcmEq8eCI=;
        b=l0pL6kDNkm60Z0vHBKyDsQjEgV5yVVF8pyIx7Cpe7yyJwFRTE2CKXj70YKFsEbzB5Q
         16qj7C68tUu1xLJ2HF3be2uoqQD2IcJ7Eq0YEA97bCDgHHiFlQvoSatb/Np04/h1VXV2
         b3h05EZCYY80j/vTM+z+aRjs8SWvRNM87Ns1uKqbXueQLlZOO2DhRyaizha3q4YWmYpD
         YvAWzQFCcchN62NTQEjUAb5u6y+dJYNyVUyKiodV3P8qNwH8M2VPC1r+0iPL7TYBDBrQ
         Er3+tfQiQR6VT6FVivSUFtdwN3+kdxwpcjmISUoLDCv7GArAmRu8Jdrlq1p1xR2wIdMy
         w1gg==
X-Forwarded-Encrypted: i=1; AKwUvBzwPbcxw8l8CcCAPWqeU2l7koZ1IRT98JoM1zi5mIUe/ULKLF2DZcQnCE8NgYboAPJDZ7u0Tw==@lists.linux.dev
X-Gm-Message-State: AFuF++laM2317MZ+ARMR5HDgwqV3vWWX3q5h/xyHmBqu2sw6gnnyXvZi
	qf/YxPYSQYz5aU/b47vzlgd24GQNAVrgAiIH65hzSrglV/mnfWArA5tW
X-Gm-Gg: AYBFou2kKqzOhim0gLb07YK9DkB3tFyKWSFsCnleW2yqMaU6C5oPXdPvEYJJCQOQYy+
	Ol+9TbCkYk7aHVS/LBYlMOJ2mQsT1GgUx/BHxJATHUz3WMx9jTS9DM0AqZBzy8aUS5dt+/gugzw
	wp7Z5ShYY8xXbdO89s9w1cl/5Lg2I2ufSQlIh/uOj94in4S/GLHuF+Py5WZBO5W3gmQYVHHcrmY
	6QXnO+W0zjyyqhc+Eg2+crpr/GthHxBcdz8eigpmUyrZZMKOGX2SkplkAFOO1VvgO5sKwLRHqAB
	xsaKPdPsJUoAqlQLFYwI6pj7mtWe9hKxKLZ/D58ohHZWp9sEXfht7kwCYzOPB5qRqOsbhUiDkHE
	4u2tOQJSVUHiIAtt1bXwx7dOXFsFjE9iePTVtSNbq6VUnnMFvAmfehswhrCabzWHYqyxGjvn3ZB
	jPT1qveWeGb9mecEp/+eBKihv2+DkLwnw2hyUzMTpLM6YT2dFwswzP45ArWqBpmTLFoBGDK1dy7
	jM/Lb/PlIOy0lJkPZQ7LtwoxrU/WoDry9bmiadHW7yG
X-Received: by 2002:a05:600c:4f12:b0:49f:e194:a062 with SMTP id 5b1f17b1804b1-49fe66fc6b7mr130556485e9.32.1790352725963;
        Fri, 25 Sep 2026 09:12:05 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.116.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff0658747sm81238665e9.1.2026.09.25.09.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 09:12:05 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Joao Martins <joao.m.martins@oracle.com>,
	Alex Williamson <alex@shazbot.org>,
	Yishai Hadas <yishaih@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/4] iommufd: Reject a zero-length dirty bitmap request
Date: Fri, 25 Sep 2026 18:11:39 +0200
Message-ID: <20260925161142.189813-4-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925161142.189813-1-parri.andrea@gmail.com>
References: <20260925161142.189813-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommufd_check_iova_range() subtracts one from bitmap->length before it
checks the length, so a zero-length request wraps to SIZE_MAX.  With
iova = 0 the wrapped value passes the overflow and alignment checks, and
the request reaches iova_bitmap_alloc() with length 0.

iova_bitmap_alloc() then sizes the bitmap from a length - 1 of SIZE_MAX,
so mapped_total_index is effectively unbounded.  The scan uses
last_iova = ULONG_MAX, which spans the whole IOAS when an area is mapped
at IOVA 0.  Reject a zero length before the subtraction.

Fixes: b9a60d6f850e ("iommufd: Add IOMMU_HWPT_GET_DIRTY_BITMAP")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 drivers/iommu/iommufd/io_pagetable.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 4e447ce74cf6c..283ab372e8da8 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -605,6 +605,9 @@ int iommufd_check_iova_range(struct io_pagetable *iopt,
 	size_t iommu_pgsize = iopt->iova_alignment;
 	u64 last_iova;
 
+	if (!bitmap->length)
+		return -EINVAL;
+
 	if (check_add_overflow(bitmap->iova, bitmap->length - 1, &last_iova))
 		return -EOVERFLOW;
 
-- 
2.53.0

