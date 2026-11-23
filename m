Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795413867;
	b=tNcnSdeBm4QH5V+KxnP1wN2iZ+LN6Zje0L09iABUyAMN94CFFsBJqvwV4TUw4sbcghfC
	 uyVlH1/g6G75z+ow/R5mMdXBz8E84Br6Gl1UTNMXTPKjheY11YBdzNM0ntE3cMajyeKRg
	 xrbNFtkkssYRe4XcuO1tsB6/bvDFKySTyd6ovgk6vF6poVzfmMBhg8YQ1grpX5ZX7OSjJ
	 k1NxLmsTzreOSdR76Q94gPkVtnrIx2PYm2qTbizvX0w0OFzfITFLlK0JkiBhluxmZMjs4
	 Or0Za5Bo/DQldsCynP+nSA68/jO30K9F1Q2lmNIUTciG8iqvWLpZeGl9/2z3/GM2Z2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795413867;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jsXyhz1mAQcwd9IrBSuTqhPASB08uhszosgJWkzp21o=;
	b=rwHJxY1KWdagY80BDvnXrORKUde2hvRLjRvu3GHkmdr8Fug5l/oyloyNKZQ/fATsIjhy
	 l+C1cAluTtXdc+rQC6mhVxQ2bmH+84u9zt6bUW1BDPy5LUeK/Qu+6G7jUgRSicGWxhiwg
	 W7viWG7YKAZCimVMjpX+cDSQuJG3iDJ4rm7lxIqrCLXchQI1pZHY+RzqlbWAn+WdVylOe
	 kGS81nn8cXALrdfLsFSv0RwBRGx0lQP4nGteqvkB31OcevGqeTizPWyXDm+ibuMsPB7z4
	 tIWVACwXgbWKaRmCVYlAvYyRpy7z/UyoK9vSAukgjXlsD4j3zidEh2pcaDtDS4P263A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EFYr6Q0W;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3619B606A31E
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 06:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3619B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EFYr6Q0W
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-8629c7cc36eso1697503a34.3
        for <iommu@lists.linux.dev>; Sun, 22 Nov 2026 22:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795413866; x=1796018666; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jsXyhz1mAQcwd9IrBSuTqhPASB08uhszosgJWkzp21o=;
        b=EFYr6Q0W75v1h3Lf/S2W0Zs2abpxU5oUr/YyedIYrWg6svEl29v5EqqN5X40t/PCD4
         qeiXnfvMlW1s0BHOsHl/6sskKlLkrhxObBVLSUuJF7fuunZSEgNN/WVdTGqqq25G6aZs
         z7o/Nj5VshCeDGtyCyZZ2/Baf/tBLpQ/BImHY4r0smbLmYjPbZRoYPLGrn1ZIypVUt2m
         mfuy0yvNLi7en6k7kOIvciQQGky0nxKoU1RB41hDXiaMoofFMEg+S5anX/EmHogMZZTB
         Lq3IgcgRDG/pmgOhtdB4S/8c9M4Sj2vhNI5lp3McYFaak5uS91ues4AuWyIPkcvvJy8r
         LqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795413866; x=1796018666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jsXyhz1mAQcwd9IrBSuTqhPASB08uhszosgJWkzp21o=;
        b=jhzDT7i3oOAKOejYbN7U4OrCP7S11iRygKhe3FzDaYbz1fqb8bJ98Xx1e9OJVZl9eH
         /MwGfrUMZpMNtl+ud0pqgPhDZunE8g/mqNBC+wzSdej1Y+tag/Zm/rCh/a4sLq2/FJTC
         12I2mWpMLNwUC+bXYU+wCXuXiV1aPGW98gNqzjJW2cpe4KOoafJgBo+3xkxOHNAvmOzg
         fNGI9tEv4ZgAplV7pqCjIgxC3X5H5tva4pDcCXMSC2bA5+BdOBaz13AZwAE20GfXuiKf
         AacOik4IT3DCT+/J/NWoBNmJs7MEeZT19fry5WLc9/YlV7/dHrfzUU2WK0T0rDwIPhZK
         pqOQ==
X-Forwarded-Encrypted: i=1; AL+hErGFKqHwmg2eLeqtMrBVgOg9q0vmn7c+95oEozn6WqYXLTO7Wex4J3htUwGQ0eUlLjV69Uwr4Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z/g0SE1v+6A8bXVVXBcuCouWhb60TNNj3YXVNdVHkzz0pX5ywJ8
	5VmEDbm9ad0ZejrdrzvSi5xF2GnFAjsAZW0ToSyobHhGmbHhoueKMYXI
X-Gm-Gg: AZFdTZcEGIIGePuOnkRfm+9iYJy80SzoiVS7P5Vq6KCoEiTgTteIgCHWXQvg40L3hFR
	HHU2b7clGEkoc4oG3d8aQwPxuatN7IWwqYSz4GrEWJD3tIol0kCJ3iaKHDXFh4Ba58EEEfsZTK7
	Y4vGBIpnMUJH/VD4/Ushf9VNmgcYzl3sNVtLto9FWYhnXXgaeQu34TWRExinakkGXFUSGH1qPeU
	eoghKd46++F5+EprW7KKfBe6+S3oMly0kB0pqIAFDQpghs77akERl/N4P8LYwmlUVq1OijC2Izg
	1YqUwCt8pq1p71KdA2daz27sH8iWeQ/V4QpaP4n4oRLWMRplXSdq6Aic9juZ0OIT3INKY51FAFn
	+iXvbaPII5hHb4UlKUzY9yWbiIM4147ucdv01Q9076+oKK5FVAktsHJXFiQKLL8/aQ5/jmx0s1M
	qe2+6Lh77Eewjtz7BnK+mwA5jb35U+/CTm4Hp5u2B/bdkhF96czv02IZ3+9vvNmWiHZEeZZtYlG
	tbxWVBrk6Wez/+fMpFXK0zxcsKvqEDhk6vUiq48dE7I/5wWB/iK2EoPdryZEXz5DTkJrb9jtMdn
	kAQe6Sxze/boYwHCEbIkJ7CAcnBOT90YC/mHxAtOULOMLcEKQzHIJJD3CqU84wYAJmIBVgIJU/r
	xUkV6z3m6ikPPjX0hMo1TiEHM7rjC87AVm+MSMBy/yk9MNfJmJBUM9EGEVKuTCKseqFHkKyDAHE
	iTCSJUOHi+kIC/
X-Received: by 2002:a05:6830:2696:b0:862:c9e8:5788 with SMTP id 46e09a7af769-86314febd1cmr11692365a34.0.1795413866122;
        Sun, 22 Nov 2026 22:04:26 -0800 (PST)
Received: from tempest-testimage-cc-centos9-stream-server-1191361818 (chi-dyn-129-114-108-164.tacc.chameleoncloud.org. [129.114.108.164])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8631681f30asm7644864a34.1.2026.11.22.22.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:04:25 -0800 (PST)
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
Subject: [PATCH v3 0/2] iommu/hyperv: Don't free a paging domain the hypervisor did not delete
Date: Mon, 23 Nov 2026 06:01:54 +0000
Message-ID: <20261123060419.119078-4-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.56.1
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

The Hyper-V IOMMU driver frees a paging domain's page tables even when
HVCALL_DELETE_DEVICE_DOMAIN fails and the hypervisor still has the
domain. Patch 1 fixes this when a domain is freed. Patch 2 handles the
same failure when the allocation of a new domain fails after the domain
has been created. As Yu pointed out, the current Hyper-V implementation
does not adopt the page table root in that case, so patch 2 is
defensive.

Changes since v2:
- Patch 1: Added Yu's Reviewed-by. No other change.
- Patch 2: Reworded the commit message and the comment to say that the
  current Hyper-V implementation does not adopt the page table root
  when HVCALL_CONFIGURE_DEVICE_DOMAIN fails, and that the change is
  defensive (Yu). Dropped the Fixes tag for the same reason. Added the
  Reviewed-by tags from Jason and Easwar. No code change other than
  the comment.
- Rebased on current mainline (8dac6df92a2e).

Both are compile-tested only (x86_64 with HYPERV and HYPERV_PVIOMMU,
W=1). I have no Hyper-V guest with the para-virtualized IOMMU to test
them on.

v2: https://lore.kernel.org/all/20261112195710.1417744-4-oss.patchbox@gmail.com/
v1: https://lore.kernel.org/all/20261105192738.70664-2-oss.patchbox@gmail.com/

Yuho Choi (2):
  iommu/hyperv: Don't free a paging domain the hypervisor did not delete
  iommu/hyperv: Keep a new domain's page tables if it cannot be deleted

 drivers/iommu/hyperv/hv-iommu-guest.c | 34 ++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 6 deletions(-)


base-commit: 8dac6df92a2e66e2098bbc69061964cfe7e8375b
-- 
2.56.1

