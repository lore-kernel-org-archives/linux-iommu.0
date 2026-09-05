Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4783BF684
	for <iommu@lists.linux.dev>; Sat,  5 Sep 2026 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788594453; cv=none; b=ZEMJk0wqbI3ZII1FBd4dUxLe+5ieatvgNjupERRbebfqfyu4D8Tp8F3bBeyO05CZBPuVnwtfGQU1X4bHJFj3ZC/nzZdCOTr3JYTOlFLoXcyOklMWDAb6OB58EELZabqJT+dXWlkKLS52FTGY4hpGLWMlozHwZWkWA0aRcE3eVF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788594453; c=relaxed/simple;
	bh=/DUmFgUshaIxy2hcef3/zwHcOL5WrkX2I9pNOXhsYB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZPpS277nba9jyy8xFm7P5awqi0meKB5cLA7WhVWuYI9pkJ0AhrG3FF+RSEuG9ekQpREDVxVkfZhP7nN5K2fhfEVgMeYFn6KTSnVsmFifTuiZ3iagRsEHK9df/IaFkXa7sM9x/0qB8/0lnmfnYOKWiP2HNu24+w8yBu61tHbNFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Py2/olQe; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Py2/olQe"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d7200b2e15so20314835ad.3
        for <iommu@lists.linux.dev>; Sat, 05 Sep 2026 00:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788594451; x=1789199251; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=py7XZS9hG76KDb+4aP7Vck11HgV2PvXOdVNmCjDkqo0=;
        b=Py2/olQeiGCoZI0jAidllGzLNKgC+ui23rlTZehtGmgawJDtVvxeah39MSkpexj6QC
         619uTdn0kdyxMEjbvALYOArbIXsZMoB46ZGRDObYhOMJxrPBtw6VREj2rKow1b8d244s
         KUY72UE3jvxGxfrL1xHLKT8Z/DOsMhkJCJOwouURTbx1teEZyxnXl9pPyuK+8psFqNw6
         cDWfTrI7rQpaoFYbtkO2ZqUy9+0tEvdAJTgb8OTC8H8ZTpMAHjWTH0GjXAvbb1QFbJZb
         qW6pFSw4zofE0kE71VgtGKLCmw5SEQ8hWftW19hcnSRJxJfo0qB6pAa0kRDvRHrrs1Fz
         b+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788594451; x=1789199251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=py7XZS9hG76KDb+4aP7Vck11HgV2PvXOdVNmCjDkqo0=;
        b=DrKEL9+xacb23twrttN5eja2j4vY8rab1xAjFmewEo8eQ5TYdIL8/WopXgx66pZ41B
         XADZaKum0IpUmYwFyngH41Xq2QNij2+7RRhsouh/FhsPZmBkra1krnQOh89zsauIG6Hm
         EX21JPLroHHrOvLKy1+kPdlZI97tZSINynaBvT5+4S/5CMmlvB/pjxt0V4IRSvkaBbqF
         Rqtg3aLJlOTlVIpr2wDKd+JFWpSPIezkC/Q9yrPhB21ndePrk8Qvk7/UlwdiIQGxseBL
         nxrtcSSiWMls80nmh+Uob9l6JBCJ9zCBNKjHJNGFDU73v1XJBfJL+Aa10YzebsC4cZyW
         m4NQ==
X-Forwarded-Encrypted: i=1; AKwUvBzQ6x5Okwp7VTvy+fsk0ujq8vHaiuOGif5Wrg4TqwulJGtjpw/mLu7AAbw+CLkDEYgNdUdcaQ==@lists.linux.dev
X-Gm-Message-State: AFuF++mctSiap2TSuBZKIudRPsqHTNpyB1i3bre0eje+MP4vFJe2r+SF
	yV68h4MMKCY+qQRTWAtHMYGKfAap5/7Y0nVH4QFXPCfWHx+9ojw/noI=
X-Gm-Gg: AYBFou2rwIkoSdedNbdDHsRZIZr9ZlclVmDmONcjhkLx+QS7IL1vuYSr2I33sE3XgAj
	37OaTRdzcQD8Zi52C4MwBaz4PpZvXSGRPbDvpJtO6mAdaStdyPd10H8JxtBqXTFn4f5wPIuMJ+P
	VaUfkxj06l953xbWub9SwvRMKhYB916Ai18doqEbEglkpe3ufb5J+zKtyAegL8jhtMd3hcVFOvb
	1/SBknp5WeuE8gY6YwI6g7Oo2C/28koBVnrYJxb0ZNk6gSs9ea5Sf7dtp1XvKz/T80NPUo3SfKX
	hCW+khEjqc9mFls/bDvJlBL1y7bTVbKzpMVZeJZeHRHhkG44FSRXkqeyGpM+WseymhoeS4oKxZK
	3HPqKzwAN7+0whvlYQYmYxvV1cMQgxAdFCDUC6yqqmk00YA+X7eHuYUNLekI7KCQFBk32yS84yp
	rjATwa9G7AKzLwCWFnohRt2AWudboqhT7wW6nCohvnlBrOu0pQU3drqKrtaXuB18niH07wzGlgW
	ruI9HN/ObZPFu0=
X-Received: by 2002:a17:90b:1343:b0:38e:9eb2:9d43 with SMTP id 98e67ed59e1d1-39b261b1bcfmr19773477a91.16.1788594451255;
        Sat, 05 Sep 2026 00:47:31 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([211.230.25.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08bcc060sm16677217a91.3.2026.09.05.00.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 00:47:30 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH] dma-coherent: report a failed reserved memory assignment
Date: Sat,  5 Sep 2026 16:47:27 +0900
Message-ID: <20260905074727.108029-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rmem_dma_device_init() drops the return value of
dma_assign_coherent_memory() and always reports success. That call fails
with -EBUSY when the device already has a coherent pool, and the file
allows only "*one* such region of memory" per device.

of_reserved_mem_device_init_by_idx() reads the zero as success. It logs
"assigned reserved memory node" for a region that was not assigned and
records the pairing, so of_reserved_mem_device_release() later runs
rmem_dma_device_release() for it. That clears dev->dma_mem without
looking at which region it was called for, dropping the pool the device
did get and leaving it on ordinary memory.

dma_declare_coherent_memory() checks the same call and releases the
memory on failure, and rmem_swiotlb_device_init() propagates its own
errors. Return the error here as well, so a device tree that assigns two
pools to one device fails the probe instead of half working.

Fixes: 7bfa5ab6fa1b ("drivers: dma-coherent: add initialization from device tree")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
Compile-tested only, with CONFIG_DMA_DECLARE_COHERENT=y and
CONFIG_OF_RESERVED_MEM=y. I do not have a board that assigns two
shared-dma-pool regions to one device; the release path was traced
through of_reserved_mem_device_release() and rmem_dma_device_release()
rather than observed.

 kernel/dma/coherent.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 45bbae947f4b..4d0266893bcc 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -352,8 +352,7 @@ static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
 	    min_not_zero(dev->coherent_dma_mask, dev->bus_dma_limit))
 		dev_warn(dev, "reserved memory is beyond device's set DMA address range\n");
 
-	dma_assign_coherent_memory(dev, mem);
-	return 0;
+	return dma_assign_coherent_memory(dev, mem);
 }
 
 static void rmem_dma_device_release(struct reserved_mem *rmem,
-- 
2.53.0

