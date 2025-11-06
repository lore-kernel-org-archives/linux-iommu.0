Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD7F29B8DB
	for <iommu@lists.linux.dev>; Thu,  6 Nov 2025 07:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762414739; cv=none; b=MUc4DNIiIl0mxWsW1moqL1KcV1kd72ABg3MJhf9iWoB9tDVriDwcwfgDYY8YeUg3+oeDy11KrAO2BRuJx/1K+cCj7ot2pMIfbE5O4T+P55f3ZZcdJCyj4kMxekifRqBrv5aIb1xJOThjLCRSs+b3Mn1eJSKoyjpRLfV7K8RPthI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762414739; c=relaxed/simple;
	bh=9WY8TkOVRVvU0etW8GXaJ6y6IJMbzV/8HNDNoXC63/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhcPQf2wygUFMILDvA7YgVy4VMQerI0r1V9L8zKFgMVLK/u2A0tfWeQDPC4TWWUcfU2rMhBCBvbfBJiVLmQ/1lFgoJ3StarlY6974jqDY0bTUZRuz2ExM8bPfo3YYo6JJbrjHnYxFeT8+sirrsoS7crFuxyCSwnQnW6KTXKvq8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=El2OfpwO; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="El2OfpwO"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b553412a19bso356437a12.1
        for <iommu@lists.linux.dev>; Wed, 05 Nov 2025 23:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762414736; x=1763019536; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EwyKXogPaS7V5uYOqhOp9kneyXDbmoOn+o0TDUIGVY=;
        b=El2OfpwONBWzLmcszECNAmncfKp9U5ewL15hZvCktc7XfcRFeTvOEqBCgP7CuiZfCi
         27QjbIYjIdld/9HiElNyzSvMFWfnBuGF8/URfuSE5igpjAYrtghq4tDClhErk5Bp1C3l
         A8glXUXpunRzj0GYoNJS+GtrTzGM6ebGqTEelIaWtOKIWqVRLcKbwPBRTSiGYoLovgV7
         KF1LchPRLtaOVA1zAfJaWJyec2MrLq3ur6pVFuFlYQsOyRFMuLf24i3RTnT44JpjetnE
         JdRMozMsKzyXDLVyFfjKlq7Bd80eNpZJQIH0ueUJwR75XZIrQLGBIfrkXiNl5GNpc9cX
         tPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762414736; x=1763019536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6EwyKXogPaS7V5uYOqhOp9kneyXDbmoOn+o0TDUIGVY=;
        b=gungyTyqF71bo4LNHiG+hNfTv8ZZ8vpZxMGtE4Ur0zgIAuD5ObCPtx35MKECrRLrNd
         uLfmqiEgnhy7G2uUdZeIjXXqhHWEiCVOvwPIdmmrV+EyQdnVN7cnIW+EmM+GJwrY+xfK
         o83UVVPE31I+99CBO0ER4PAkpQs7mMYhd9gltARcPo6PVFfIt+c5b9Nm5Udrzsj0qUmP
         x5wvQj7aWpQzJIitGzB5Ha3OWA9s91HWC56t+EitZDG5CtqNhBtJhb4qvsLqPGU2e7pK
         KVTNZyg2Brem9KDPWMC8pHMX2NPWOXBZzUo/RvzWRK1W7ci6cltOD5+Fcx9pfQDYpcHG
         Y8Lw==
X-Forwarded-Encrypted: i=1; AJvYcCXwxFa8lqc1q9E7a+nKQIph2vLUxoJ5OGzh6dDc16idZThfi23KEUP8JBVJWtGHfbztk3qdSg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxl2FuT9nfBub485WT4yG2SqjO0wxbRsJ9ttIGwW8W/0SNbMVoN
	rNkNrTW73Fyec4aFW9mXjYV/ipB833UUNq8737rALNGfOfLFm66NNCUi
X-Gm-Gg: ASbGncsLYHuBLa49p4hxOq6Pxdc0AyQnPG+v0SQ7GUPDdCV8VD0Mp+9eLf53k9SPt3B
	63AoRY22tU5xWIwy0m/PdkRQZtgQQE0Ud5hZYmu9COFXWiEqH/8J839A+vBjasTFcnHivVzjuYg
	X7v9ZcCCjV+oIP5GCEMaLd7XvvYiAMTZDg1bgd41zyPTYfla4xfpv6PymctC3HrpUnURD2aje+D
	MwDkBqqRGt1rwkKfXjjXLJn0Bj2/tfqpHYXANGSX1/TVNOnyTwatwAuNKqgnQ0pPCc0+yrqpAsw
	A1eQ7mNJdRU+5BO63Sjph0YCQCW3u0Yl+05OFWkOL8SvYEtC3drreGCzj8xwjenDMOeU6c1hEPG
	w0Zl9fB7nXIkZtVc744K2iuZdDE4iamG8VL0yO4luHBgHFaSAG+we7R/X6WAjB6n3mVSeX4ULU8
	ObI89k8BXg99o=
X-Google-Smtp-Source: AGHT+IGcetcHDEJ2pWdGp2wrehN+ji6EM3hz8DX0d/sJvq5qjS4UHY5JTdyluUbtQuWersYXiD1kdw==
X-Received: by 2002:a17:903:2a8f:b0:295:62d:503c with SMTP id d9443c01a7336-2962ad193f6mr95598365ad.16.1762414736274;
        Wed, 05 Nov 2025 23:38:56 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cce763sm17981055ad.103.2025.11.05.23.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 23:38:55 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id DF1F0420A6B3; Thu, 06 Nov 2025 14:38:52 +0700 (WIB)
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
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 1/2] Documentation: genpt: Don't use code block marker before iommu_amdv1.c include listing
Date: Thu,  6 Nov 2025 14:38:44 +0700
Message-ID: <20251106073845.36445-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251106073845.36445-1-bagasdotme@gmail.com>
References: <20251106073845.36445-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1487; i=bagasdotme@gmail.com; h=from:subject; bh=9WY8TkOVRVvU0etW8GXaJ6y6IJMbzV/8HNDNoXC63/M=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJk8/i9Tl93VuN2yjltXa/2B/umzNayvaO7tDs2cw/vnY MOf+f6pHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZgIeyEjwwqBny6GKi7OLBqh V5S0c69YW8UdbAyt063teJb7RO+jGyPD4g/ef74fvxpyufhan2n4Q/PaUwsLs7Ts9dyavtctf9z PCwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Stephen Rothwell reports htmldocs warning when merging iommu tree:

Documentation/driver-api/generic_pt.rst:32: WARNING: Literal block expected; none found. [docutils]

This is because of duplicate double colon code block markers: one after
generic_pt/fmt/iommu_amdv1.c and the one in its preceding paragraph. The
resulting htmldocs, however, only marks the include listing (after the
former) up as it should be.

Drop the latter to fix the warning.

Fixes: ab0b572847ac ("genpt: Add Documentation/ files")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20251106143925.578e411b@canb.auug.org.au/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/driver-api/generic_pt.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/generic_pt.rst b/Documentation/driver-api/generic_pt.rst
index 210d1229aa1c1f..7a9ca9f2878d4f 100644
--- a/Documentation/driver-api/generic_pt.rst
+++ b/Documentation/driver-api/generic_pt.rst
@@ -27,7 +27,7 @@ compiled into a per-format IOMMU operations kernel module.
 For this to work the .c file for each compilation unit will include both the
 format headers and the generic code for the implementation. For instance in an
 implementation compilation unit the headers would normally be included as
-follows::
+follows:
 
 generic_pt/fmt/iommu_amdv1.c::
 
-- 
An old man doll... just what I always wanted! - Clara

