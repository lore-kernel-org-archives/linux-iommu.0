Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C315386C39
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779255; cv=none; b=r92RNIXtN8nlDzOFK/jJZVfM2w9u5ny+lq9z0dD5y/fNQhKh7mN6avEqiN48CrAHfCZX5AGTjm93YTsXezKC3auoWgzs9ells6o7PEBJKUS0RCIkCLRlM0c8cDSNH5Vid97o+vEXU0Crl9Z7SBc+rYtTnBYWyfufNNn8M/q11OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779255; c=relaxed/simple;
	bh=s15RL/I1MS/3imuLtkC2xq7uTBGavm8FT9td9CFmlIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U6DDRACaM2RIiAMypw+n5PeQBZAgn8EQyqE+LJAvYurm9N/5NCoOO21pZJMCatJXvE7rze38CwpgrbLYxZ62u6vdWUnq05vRWDdmVV2kWm0hGU8NxHl4GKN3qolOBlDti+duVZgNBYnqyLmJENovnYLH21Av1WvBYfJrHq8OuFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+0RhbPp; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+0RhbPp"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-35d965648a2so3634052a91.0
        for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 06:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779253; x=1777384053; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ks2vHMRh0my4MpDz0dclabjbLc7A4OosqiA6OhNyWHQ=;
        b=J+0RhbPpoer4WIAC7e1RiPZ+1Cd7SDgNQZjvFYkbwmDIZiTaWzHWSg1uIZSaFq0LKi
         MgOp/a0WTyjJ+yUuwBGxBq3CZE5Bxf6DpI1SX3uPTurPLgD+whyGTpU0wwj1RjHGxz4W
         5PPTKfh74PXE2/nw+GtpeLbQL4Gz3ZWU7Qc6rUkUogMrJikEWBbwB5MOXs37YbV3Ad8z
         zLlVhnCLsrRkL8nAE13+TzKAhXlsNiOrCxpq8L9eZFj7XFhbHyEjkbhr2KalwycOF0na
         Xu68QegUiB0nFknFUu9d6waHhLzwhg17uDb+8vkr/RRicyb5rbAQL8Seg0mT19IXOFR2
         NWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779253; x=1777384053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ks2vHMRh0my4MpDz0dclabjbLc7A4OosqiA6OhNyWHQ=;
        b=dRipNhFE4LtO5xOJhzmX1z9fmDiw3jcwhq+h5BTQRgMDqrSTmBk1EXBnZ/HE/SV00c
         orQs4ok5MDO35yKM6IjQwmkMfyO1j118R0KXXUKHwqR5fjeSm0QjqrzpnzO083tpYwwK
         MYkCfK66p7+UBnK2fUWBAuQDWMhI7F1OhCK1EnQZGdIYA215F319yldZ1bE3SqtfllhT
         J2rlEqJ6zvqtUsCBQnA8fmrmoiszuIetqLu7vrzvcoB8qGoz6urY+ly6OYXm3H12V2VI
         8MgOcGQQUpqiGDU/0Hh19U64PNKyOH+Q1ZkcEXXNwND/VxFHyVB85E9vILWwdlJDtSC3
         WGDg==
X-Forwarded-Encrypted: i=1; AFNElJ8tk2mKp04n/yyyxs8mfEbIhGQ3a8n3ixqbK+SubH9Z0E1ubgbCGux34VUxydz3Bklm+dqjXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxF2//6uhoUO/hRws56N2gtz23jX0+6Gp+/3svcgU9E1vI3BKT3
	0sdiYG/L1LhkF8z316FiaqAZo+QSxHIvCNGvCreC4koe2qyZP7GW/DKp
X-Gm-Gg: AeBDieusPS9OS3uoNiSP2EkmB9A1HEma7vRwh2vwL9Xdb1YpAMlXf3wvtCt1BkYdH3u
	zKM3djIIo+TM5q+WPaZjfJ9n0lCLyMWeJFZ/q+kxqrqAYWBdoJTa5sGaZCh/HYPtjyuEaqdFMQ3
	g5JL46Ehf2BnnpXwlPbV4HYNkfu3Y0xG/zDUIrs4XNBJIhE91145zu78xJmTUT73BFGNagEJurm
	g/QJ0nhtjlHNthQoFE++JMIkf8Uu0+VbTqAYvixBOdYd/0591e7mZIec5virkJUi7w2nCuCYmMw
	YLCSNYF0Vz17FJzJr7wgb1xAmw6tftPuoOw4DxYQEhDnhg6RB+tap1aze/0NZkgWFjgAxqaArqm
	wJ/VgOP3Zv5qcNiN8+1pDIi2N8G2Cvw6bW0AJukr3QY7p3p5/04JL1ETxBghuJ8up1AaDu00Zh2
	5StzceGoK7r1j/+NQEavt4fQR+y2baAfyDk+WlUl72Cpm9t+J3XyjCjOc=
X-Received: by 2002:a17:90b:2e41:b0:35d:aeb2:25b2 with SMTP id 98e67ed59e1d1-361404aeddcmr19957529a91.27.1776779252761;
        Tue, 21 Apr 2026 06:47:32 -0700 (PDT)
Received: from LAPTOP-1HUHJV8R.localdomain ([2408:8642:893:d2da:c016:592:ddae:fe0d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-362bbf963c9sm3630056a91.16.2026.04.21.06.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:47:32 -0700 (PDT)
From: l1za0.sec@gmail.com
To: jgg@ziepe.ca,
	kevin.tian@intel.com
Cc: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommufd: fix slab-use-after-free read in iommufd_ioas_unmap
Date: Tue, 21 Apr 2026 21:47:05 +0800
Message-ID: <20260421134719.33801-1-l1za0.sec@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haocheng Yu <l1za0.sec@gmail.com>

A KASAN: slab-use-after-free read in iommufd_ioas_unmap is reported
by a modified Syzkaller-based kernel fuzzing tool we developed.

This issue is caused by a race condition between iommufd_destroy()
and iommufd_put_object(). Thread A first enters iommufd_put_object(),
which is called by iommufd_ioas_umap(), and executes
`refcount_dec(&obj->users);`, but before executing
`up_read(&obj->destroy_rwsem);`, thread B happens to enter
iommufd_destroy() and destroy the object. Later, when A wants to
release the lock, it accesses this already destroyed object,
causing a use-after-free error.

To fix this issue, before executing the destroy statement in
iommufd_destroy(), a write lock is acquired using down_write() to
ensure that up_read() has finished executing before destroy,
thus avoiding the UAF problem.

Signed-off-by: Haocheng Yu <l1za0.sec@gmail.com>
---
 drivers/iommu/iommufd/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index e71523cbd0de..a1f0b591c412 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -212,6 +212,8 @@ static int iommufd_destroy(struct iommufd_ucmd *ucmd)
 	obj = iommufd_object_remove(ucmd->ictx, cmd->id, false);
 	if (IS_ERR(obj))
 		return PTR_ERR(obj);
+	down_write(&obj->destroy_rwsem);
+	up_write(&obj->destroy_rwsem);
 	iommufd_object_ops[obj->type].destroy(obj);
 	kfree(obj);
 	return 0;

base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
-- 
2.51.0

