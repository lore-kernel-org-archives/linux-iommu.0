Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDCC4A68B8
	for <iommu@lists.linux.dev>; Fri,  2 Oct 2026 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790947916; cv=none; b=jEjvPhkZx1RTrGptFtT1BIb8VIHamqNTM4whKnCWAKDoMp+B4+TXmyw00C1+BbKdzoX+hvAn7c0RSwsfQ2585hm7qRFme3ayQ1pBNPIIEGZ0wdRFI5IHuKJizzwzBS4akUp92Xq6yW7OcVl0ih1Aoqq38Z9XqYxLVnvC732Dd7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790947916; c=relaxed/simple;
	bh=lxd6po6fgSciMb1Ro4LbKXumzbF23PPies3d62RHoUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bt4eDw0t0Eze8l5TJX1rMpQnoyQBdTBTNTKCZlBVqAQcO3nwO8yB/t81EkSF1QN01QnJ81WQMRS6940TrLwW5fFE0+g4JfMRzexBdQiupRtuXDxASfLUQkaPvqzf2T9/bKrUS00OjbTrbF9V4dzU5TPgCFVv7qighFb9+CNrbjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=oDUCGnOJ; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="oDUCGnOJ"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48af9f88c95so1291988f8f.0
        for <iommu@lists.linux.dev>; Fri, 02 Oct 2026 06:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1790947911; x=1791552711; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b5IXHgAtL8/tcae5bQMBJzUP97M7snujo3DcDARBgYc=;
        b=oDUCGnOJHlQNRV+b4Rg7SDVFRadF3BeDqvmNb+/SC2z+f3GurwlsImT1pZMQS/cZad
         MW9IBvgi1lKxWF+67YzWvpVkTg5wERjU2gJvXyQoQeRmeNuX7PXcO2kxmKmMo8MVdaDw
         6HS4RbavqMseD44KtMWbDF4XW2eT+FK0Mw6/PPRlp4/gL1c5fs6HMCFaL/0+Aws/IWqA
         XdMA9SEy+zCnLLanvwNaGUaCEIcSa3ynJ5ZkxGrygvWZV3hUKMiystI8kC9e2A5wjN3C
         vkV2hsJLJBDPwnmqMPx9pEh+czS4tQpc9d2LNJjF543jKLzO/il8YKlJJ73g879csocq
         cQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790947911; x=1791552711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b5IXHgAtL8/tcae5bQMBJzUP97M7snujo3DcDARBgYc=;
        b=TzLwpRLZNpmNsQzrThpPmeyWQsRhlmNyTXi/q3zbjjm2DjPId9jBya4v8vZQl3T+1W
         PWiwqxoBz7aVtiH/5zaaiGp1YLU+wQdZxTYpgJcMbeDSXZKp+DbuOJyIBT5DpLeoN5N0
         5K7f479VD1sHj6dUjqFsbDxU5WpIMS4EqTvIUSxbM36SzIjN2hMO8POpr5tceXExwRCw
         THL/eokUmw2mbM0DWD9vz6JCa4Ai7Z3J3P4DQqxM9pBc+shi3YtJnJ1zBA6nGp0uXu2j
         Y+G0LPN71V7gjDHTFJQiLSZAqqljCtfJHB+emvdz60+6129gTVCAI2A7KtO4G860qaXz
         rVyg==
X-Forwarded-Encrypted: i=1; AKwUvBx7Xhodr3T4WH+5c/uyOkWklHkwDB0PAC1+I/XYUV4w/zfDAnBTg4FgdDXSOm6VVH/xL3IlXg==@lists.linux.dev
X-Gm-Message-State: AFuF++l1An+5vD52HOxyB0eXhuzXVnt+EkrCqrUExCCLCRnVIs/HqKCO
	BHHcRMmqNxFDJtclL1yUm0rRCBh3s3T3XUHvBByT0anFU99hU3fNH4p4fJrHJI4aS+s=
X-Gm-Gg: AYBFou3dNUg6FAF8beNKK0LBPz6qZCxFN4QRfEjVA1LcTwUvlGT6tFdyp4gZ7Cq0548
	iqnZpcvqx6EuM2i+QEU5RzJ/lLChAhsb4TYNYRhoayIIVNIHM3VBqUGfgtEQJpGH2FgMkN/kGez
	bI+ewpS7TRUUIjLbFnXUjQoH5vtnpjEMZGiE8xsQhSYfHc9Mb8u5XXaO3AW1mM0wgv1Im+jkhIp
	pWlFn8HZ1DhRHzWx9HH64lBhBSXL0UHjHUETUyLyBSh5O/XUNqOBICJUTKasyY9hNs1JI9kye3i
	CuZq/UrzOxF0+IokLPqzBO+dp5fHZlkdDqMTJpJazsBejiEMO1QbgZ+PX1brUTeSPX50Ls+1J6Z
	vsdd0X7f5AI0rpAuwfw7AQNvpYGMMdGebjHGK1F2uzbSYzjGU+gfkus+Lu1T0u82TTbC2ThBbnx
	uQFgu6qgW/+NXXxv8AcUbXqrSRrtQxuixwq5hHwDU7DytB1EsO7K6HW5YQ6z7RYOYMVclG7iPvF
	zQl18VrNeI=
X-Received: by 2002:a05:600c:3b05:b0:49e:715d:95ca with SMTP id 5b1f17b1804b1-4a027561e0fmr48312725e9.13.1790947910026;
        Fri, 02 Oct 2026 06:31:50 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:ebe::178:143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0394e6c5asm60543205e9.2.2026.10.02.06.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 06:31:49 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Sairaj Kodilkar <sarunkod@amd.com>,
	Baoquan He <bhe@redhat.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [PATCH 0/2] iommu/amd: Fix device table setup in kdump kernels
Date: Fri,  2 Oct 2026 14:31:41 +0100
Message-ID: <20261002133143.3628181-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Fleming <mfleming@cloudflare.com>

An AMD kdump kernel booted with crashkernel=512M,high and
crashkernel=0,low fails to allocate its device table because there's no
memory below 4G. IOMMU init fails and, on our systems with an Intel
E810 NIC, the ice driver's TX queues time out, so the dump never gets
sent.

Since commit 38e5f33ee359 ("iommu/amd: Reuse device table for kdump"), a
kdump kernel normally reuses the previous kernel's table. Patch 1
programs the new table if reuse fails. Patch 2 drops GFP_DMA32 for
kdump kernels. Normal kernels still allocate below 4G, because that's
what the kdump kernel checks before reusing the table.

On an AMD EPYC system with an E810 NIC, the kdump kernel without these
patches failed the order-9 GFP_DMA32 allocation and its TX queues timed
out. With these patches, the kdump kernel reused the old device table
and the dump was written over the network.

Matt Fleming (2):
  iommu/amd: Program device table when kdump reuse fails
  iommu/amd: Don't allocate kdump device table from DMA32

 drivers/iommu/amd/init.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

-- 
2.43.0

