Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F8330F959
	for <iommu@lists.linux.dev>; Fri,  7 Nov 2025 08:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762503206; cv=none; b=j+fsszd8yYQAhMpQRjTW0qRHbF2CyQpHIV+DjmRDtYfKBFoglkEZFURmteRGWNFpCZ19kYw5vTmiJJeb6MLQbUZ3YAlQFcTL/iFPDg+G52D3qYvJ8fjsLazH7OlBjem33shGiDI3zIDgI/tjpvYvJ9i8HUw99X6b8K+O673JcQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762503206; c=relaxed/simple;
	bh=L2WkKVq1YkpsdiT6yHvKw0l7RT+zYDKnfrxQFfdUrw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BZCRyQVZXcabdId57fIroEZQOcwASUP9EWCd3QUtdcd3zxwV1j2k9uctpBHbj4k/41ShzIDvdLwz8qIPJ0zfzAWn6rxSrzPh7RNxyArdHcUBFBItIUpazIyWXP93VeYCoZ+U4VPQDguIO/qbuGnrlQAIqZ2PU0q63Lmmk3pQhS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnpPanLA; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnpPanLA"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-641458f71ffso520410a12.3
        for <iommu@lists.linux.dev>; Fri, 07 Nov 2025 00:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762503203; x=1763108003; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iOIIVZmEuR4lMVP1407hIBpNtWT/l6DfS/U3dPctlwM=;
        b=BnpPanLAusDJj/E+994ktOeEvXXzmy/MPq9aRnbThCSZfaQlscwl26nSCzDwzd1BE5
         Aua5NvTkNmSOsWODHq6nGTV0ndKlbJ95jnpMJVH/28c+7MupLWsr8GZjvPrdhj3KdSGi
         FIvk4WSL4sol4xiLaF8YKxp5bFzwxETFY4oMXZ72DgVv8clxFtbkH9fNJw+V5Oi5NDO5
         GR9U7FlR12wgSW4R5Mu0LFhjuoVDYB89FQJQvma8qmjJgPblg7xhrhiel8JrPzAPBfbI
         GIFWs/PZKpglrnmcXEGYxMvkMyhtFFuT+4vrUBimETKDqH0a1GrOIJrohlkP4iyjJ5bL
         fjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762503203; x=1763108003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOIIVZmEuR4lMVP1407hIBpNtWT/l6DfS/U3dPctlwM=;
        b=AvaxXECYOKrsSj9jI/nF/NK8D7zz06OixzJkL2EZjOKi8HBhKVWfMgOC0IWGFZDLTn
         VeZDSmbM3ICe0OVLMn1CgYCBSRAIXrk8H55zcIv+eZATuL8lyipqQn3SQLP8ImqNLBV4
         sltBU80aSvTgK1LPZNuAv1sf81/+wl5NQVaL8mKluVHr4IM7XQ8lmOSGiUygcXe6vGdW
         ++A7bH2LMX6/xyICUq1SA1Zw+8UxqZCxn+Dw71vgTLbX+QpRFHZjrL88LxC2wBrUJiT/
         8Vct+56YBZITl7U+pvAi9lSKQv3Vw3acgRBhGrCzc64yNd4dcbU1OVIcZFWHTq80i93s
         bbOg==
X-Forwarded-Encrypted: i=1; AJvYcCVHF2xYzU9ZBuDMWJGPVXn3093mHukq7k8zohFoh3zpm01ZAWS87Wyf7XeRshXeZY+CnUNbmA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTuh/lOWdpu1/kIYC/VgMmY38usKHsU4KNhq+7nZv0YQ4gow+7
	n4G8klkyHiqY2ENgBq1XU876mnzemMPd5Y3Na7AiI10wabB3ATxtKGND
X-Gm-Gg: ASbGncv2Pghw3e90mvHan5kay3+YO0a+3ym92fXkkdPX733nxYqxHeO0jrbkV2KZGCC
	OVPfI7xH17wEJave4aEzzktCOS2gXULJCy4pLg85xCQN2i6LkbU80rKWoHOxKg9hZ7QekP2TE0F
	eMl6wHoYIo+aBI/Fy5jZ1X9TE8v4jXMS47Op1hKjphaC1pv+QDyjjJPfLHRkgW3e4Gjel+jj6/6
	q+HKqLh+WpAHCNultDvXqtwCrtaCaReipmXpMo4KkAa6FbbPHk2FKHB4xysMdkszC9XHVtdETMA
	kPCB5undVO4XLuc/H/LJIRqx3T8WPx2dhJzrlq4o0B/uAFFP3ENvVLwlxoFnmsD2feqUXz2CRoo
	VNHrjZSO2cqK3L46EmXNz5q27T4EqSBtQ4iQbJGVQdSCJGYmi38MLdBlbGCBwEAV0Xz6Pjuj5Fu
	b/
X-Google-Smtp-Source: AGHT+IG665bW/Iuh/8EXmRznhqf6ur9YSSabWYQHPQ8dXHHX+fgwFkGMvxLWdfgY4F29RVykMMnqWg==
X-Received: by 2002:a05:6402:3045:10b0:640:af04:d718 with SMTP id 4fb4d7f45d1cf-6413f0771b9mr1621773a12.30.1762503202832;
        Fri, 07 Nov 2025 00:13:22 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f6780b7sm3665313a12.0.2025.11.07.00.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:13:20 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id A7E38420A6A8; Fri, 07 Nov 2025 15:13:12 +0700 (WIB)
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
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/2] genpt documentation fixes
Date: Fri,  7 Nov 2025 15:12:59 +0700
Message-ID: <20251107081300.13033-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=889; i=bagasdotme@gmail.com; h=from:subject; bh=L2WkKVq1YkpsdiT6yHvKw0l7RT+zYDKnfrxQFfdUrw0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJm8K7T8b25LFBZc/qP+aoJmfOcx7kTmCJe83VsDpX+uN d+yY1psRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACZy5x/DH77TBhliqz7NbmQx erzRocQuhy3w6CX2Uk7Xmf11j67zH2L4zf6sR97r3uS+rqjU1Sw3pm3KOpwp5Jn5YL/WF979yQI XeAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Here are fixes for two htmldocs warnings in generic radix page table
documentation. The first one is reported in linux-next [1], and the
second one is also found when making htmldocs locally to reproduce the
former.

Enjoy!

Changes since v1 [2]:

  - s/to set/to read/ (Randy)

[1]: https://lore.kernel.org/linux-next/20251106143925.578e411b@canb.auug.org.au/
[2]: https://lore.kernel.org/linux-doc/20251106073845.36445-1-bagasdotme@gmail.com/

Bagas Sanjaya (2):
  Documentation: genpt: Don't use code block marker before iommu_amdv1.c
    include listing
  iommupt: Describe @bitnr parameter

 Documentation/driver-api/generic_pt.rst | 2 +-
 drivers/iommu/generic_pt/pt_common.h    | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)


base-commit: 75d9ef7cf1e694e5c0fb387be99f04acc7f864a4
-- 
An old man doll... just what I always wanted! - Clara

