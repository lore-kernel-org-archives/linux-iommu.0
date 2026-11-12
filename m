Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513441;
	b=zxtaAVd10N2rbe4qdV/SSFq0mcnEH2bKolbgLwbwOddzg9D44Lad8NXq23B1V6JrMB4G
	 tktdAwbWMejzqHqY1QUKiKHRUMu9HZVXfCi0lj9RW8JkLLqF4s6uKwDhNWvTFRU/foCiR
	 LfMriMWeqTo+NPCocjuqYhB9gGZZdsi+K5Drc0nNe/uhSmi1I4ez3z4I8+Rum2KAXrOeQ
	 H5Jz+WmQyaYLpZYPiYZTeLKemyii9Pr1kqHbO10FcXcaNjYTU5yYhc1QRHgdFAVJPpFG1
	 R5FEaMLqxqJzw5ELevOQ+pdLrhqxxUmX/pxc4IvXvB36WcT8n2228lp4xRhmYI+YW8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=q+1maoVYXsme0lgtuSeqWJeLS/nWjgJUmUKBjOiIOqU=;
	b=zSxnpih4NkZwBydtwhGFSpLHP0lb/zdy93U33im5+sX4vkXuN796+vHZSzGbo9jV+LWF
	 FLLH7YI75QL6wK7Hu+JWaH4px3C51x6NOB/UYR0BkuwvzNADdA+Jssv3QUPcSdpogPv7r
	 2JSWJL6fbWaLojLXnuQrG2EN1EvTp39zKFQuQZc0hZ4Y6hSCvUTYj2y5QZEFW/Qs6cXWx
	 EMtN4mghukxlYmrkO75dwFN9T/7hSSqZl8061O5JTXjMZ8C/6RAJBJO29bFNXpRLNbRqj
	 UsCUnAUzvmHLNbhQjtU20JjWff+anuvmih+fSy10pq90RnTj5qcep7gJPX0T/GDdTDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DoeQ0Oqf;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659F9606A88C
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 19:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 659F9606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DoeQ0Oqf
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5364d86f7f0so1743221cf.1
        for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 11:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794513440; x=1795118240; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q+1maoVYXsme0lgtuSeqWJeLS/nWjgJUmUKBjOiIOqU=;
        b=DoeQ0Oqfm0yfAF38ciHFzGBMp2AjBaiqxnH3ue2+0unfQRB8xnppTAKtsj7VEOH2TK
         U1UouzM8y3cXwxtSeixoXGvFRI5BlW6eu+3kEaDCcnhrd20/7+iiSuVO0U8os4lA57aO
         5Vi7Rxduo3ZIdwj3h4FHsNP6BA8P/+9ycZkm3O2GFd3ymY2XIBWPfNBzsjnkyJn6O0X7
         nM8S3w1KX9zFNruer6pRuFvsLLnTfNmPU1ZbtNTDCoyEnaH2TdHGurbLTNkWb0z/pj+X
         Xp4i/8qgnbTXnp9qHzj5/UODyt6zuIGPfLX/x17eEjW4ttOtwYALg8ZKFD5566aj5ALK
         pU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513440; x=1795118240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q+1maoVYXsme0lgtuSeqWJeLS/nWjgJUmUKBjOiIOqU=;
        b=CaD4EOmchhkOnEdQneCUESjuJoqCfKOK6zKDT244Vtz27dbYFK94jVqCCnDAreQ0wa
         z5NgmG5Hf/JqVE1X/7UTn1jGdmGbOVoshM+0jgXmQZ9swvy9MyIuQiGlA8LB301yTFWP
         PBpMEITMen1x2wbm31gW/vrhV2tOd64vOUY4lYVTzAmXJjzcrcoo4iv2iJ2da1wOWlt2
         ovE2tn6wbyyDFEyXUgx78HdEhyjddKIUE8ImqymFEmn/6mn7ejUEaJJcGem9MjuCYMv2
         tfTbN1N5ccZQ5jzBCHJfsEOmjxODPGMiSauLzCGSlpwUDl8gOI7Qzriz1px3MpuRoFkN
         Wl0g==
X-Forwarded-Encrypted: i=1; AL+hErEV2TJyIccFHhITFVgAeE5SGOBMGD5lvCunOBhmVyqKSYybNw5DR5McBvcHl2UV0S2rV4sDsA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8mwc6K5ZADNoALI0YYlU/2PCoc6sA7XO7qCo6t/ehsxDFvN27g
	Lu/SsXHaefTexnzi2iYjZQTFhWuRQoqRsemEuoTC0xhT5/YhFfVQDwjW
X-Gm-Gg: AYBFou38XP5P8Vw4gQeRcossJe8VvFwrbO+2bX9JBwm/x4anQmFb1OTgk780q1rssYb
	0S8iRYhbcTNoZ/90+avojj2G6wR1nvwzpnk3nXlyVhrT45yOmG7ClGu/pQRQwkIjFznWI0QvXl4
	Fx8GbTIowOgpBKcVQllbGMDWhSD9R4YmCsQYAutDZo3PtZ9zcrogzGi5wrQy8R7WzDxjZpH6ulw
	YZBDaA1f9bHAkujoB95YfYI16z3jfkvSqYLHdavs26pwUcHYXjqj1QYNL1zilshroDCe2S/NR7v
	h1GmOsYhUFmAWacaKfIhD6fl2ILy26UTqZFGac8FgJk0Nu1TZUmviZH+QWbKY5qi4P3doLoIf9O
	e6cTpDSOGkg5wMs5FwbkKPhnIA2rqvyP5Whlybf+2g5mztcWNwhEBEi906VMp5REst0AQ/5eBy3
	D+RrtUAjZEXHNxbE6pReHYpHhM4E1o11gkgRobREM++jzU/bh72gUwSskk/HJVXWsv0LJ9SVvpx
	0UY7ycasPw5QDIlbYlg5YjZf4yb+WpYN0E8TVyxPomDS7rj/iJtVhpKM9dRr/OwJex7RJ4yJ41a
	yZl2ozZEzA4xHpzJLBAkz2Jj6/fRyUOrZK9coZ9sz+BFYwH5YbVbeBxgL0NJe06LDw6zKBINll8
	=
X-Received: by 2002:ac8:5c92:0:b0:535:8607:d2e2 with SMTP id d75a77b69052e-55ac8b905f0mr8030011cf.56.1794513440241;
        Thu, 12 Nov 2026 11:57:20 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad034918fsm2504851cf.4.2026.11.12.11.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 11:57:19 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Wei Liu <wei.liu@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Yu Zhang <zhangyu1@linux.microsoft.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	iommu@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v2 2/2] iommu/hyperv: Keep a new domain's page tables if it cannot be deleted
Date: Thu, 12 Nov 2026 14:57:00 -0500
Message-ID: <20261112195710.1417744-6-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112195710.1417744-4-oss.patchbox@gmail.com>
References: <20261112195710.1417744-4-oss.patchbox@gmail.com>
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

When hv_iommu_domain_alloc_paging() fails to configure a new device
domain, hv_create_configure_device_domain() deletes the domain again,
and the caller then frees the page tables with pt_iommu_deinit(). If
the delete fails as well, the hypervisor still has the domain, which
may already point at the page tables, and they are freed anyway.

Create and configure the domain in hv_iommu_domain_alloc_paging()
itself, and leak the page tables and the domain when the delete fails,
as hv_iommu_paging_domain_free() does.

Fixes: 2690d4156b51 ("iommu/hyperv: Add para-virtualized IOMMU support for Hyper-V guest")
Reported-by: Jacob Pan <jacob.pan@linux.microsoft.com>
Closes: https://lore.kernel.org/all/20261105141427.00005946@linux.microsoft.com/
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 drivers/iommu/hyperv/hv-iommu-guest.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/hyperv/hv-iommu-guest.c b/drivers/iommu/hyperv/hv-iommu-guest.c
index aa1db9db1e97..ef486ffa0be4 100644
--- a/drivers/iommu/hyperv/hv-iommu-guest.c
+++ b/drivers/iommu/hyperv/hv-iommu-guest.c
@@ -540,10 +540,18 @@ static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *dev)
 	settings.page_table_root = pt_info.gcr3_pt;
 	settings.flags.first_stage_paging_mode = pt_info.levels == 5;
 
-	ret = hv_create_configure_device_domain(hv_domain, &settings);
+	ret = hv_create_device_domain(hv_domain);
 	if (ret)
 		goto err_pt_deinit;
 
+	ret = hv_configure_device_domain(hv_domain, &settings);
+	if (ret) {
+		/* See hv_iommu_paging_domain_free() */
+		if (hv_delete_device_domain(hv_domain))
+			return ERR_PTR(ret);
+		goto err_pt_deinit;
+	}
+
 	return &hv_domain->domain;
 
 err_pt_deinit:
-- 
2.43.0

