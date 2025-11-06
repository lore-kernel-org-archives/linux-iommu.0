Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC5F28DB52
	for <iommu@lists.linux.dev>; Thu,  6 Nov 2025 07:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762414738; cv=none; b=JkVZCjZ0cahUz8GBQX8mhGviCMXV4K8oAH7i46iqqejDBEDVoYLUoaSdygaiT0p5JQk1hhEq1m0qsFKpIdNGSnFty9X8OVi2LEIXi55BeEP2kLP7YVZVjPFfiSS2kF5aeA02y70tSUUO0dOw0dAi4/p5KuDQX8yYodR65IW3YDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762414738; c=relaxed/simple;
	bh=fHpHqdj6evMaMAwbOPs89dx0SybJWtU+E52RFwbkzc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MDbHvuZ8W35i6XBvhVjr8MN1h4Yuo2ozGSIt9UwM6yLI/gqePmbwJ6UCDZ8wDs9cirCaBGHGHoLewbf/3VaMzmdx+BqB6SZpJxkbf6rM8MVhF5Pyis8M1BM6b1kD2MWdrb5xAQDH+da1DuNHtdHFVpgislqn+c2RO46movjXWCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnCBGHQu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnCBGHQu"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29586626fbeso7886865ad.0
        for <iommu@lists.linux.dev>; Wed, 05 Nov 2025 23:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762414736; x=1763019536; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W74SW9CUtH8YSGxvzwDmnorAFynOYsju91d1AAA1bkk=;
        b=ZnCBGHQuR80+6DALbLwoMEX/qwMBhi2xVOIfgFRLVLKwR8rMcy+05F0OB4FvQXv0FF
         CuWSS/x7J7QrQf0R64kDp9OvA6WXA//sbrvDq5qoyA00BFliolwvrgNwnDPQQqkFs3xK
         u9vjdubkhGACKL4lPepYDlpAR0Cq2CTXvPFjlm0sMJfqokYOhxlfOvyCuN2OYXSgPKc+
         Y6S/Bcc+N6j3gk0fRU9yInds3WCFT+x+ORtlpib0VX/kprX81ZOZt1vb3uvNhJ0L/58g
         FDJlP0nKcQlpIwMdEZI8cdbORkr1Z90ncSt3NNkm43kl1uvUKLl7L1lSiXtyIxQlnYWO
         YVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762414736; x=1763019536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W74SW9CUtH8YSGxvzwDmnorAFynOYsju91d1AAA1bkk=;
        b=MT2oMChuoDCcmW+gkwwT7aG5TXYuYQ+81kujJhAmdk64AgJyhWqkUaxHe8Il+1DEXH
         gVtRiT29nvCCdnbJyKeC/eux15CkpgEhFCipz9jWOWnJEjJAHNZiYYCn/7i+wKdZMUAY
         kUtbqpqMwbaHgHep0FHkUh9pVpekx96OoX1BvhPm16d4lI9lM2oi5wOn/ZUON+C3UpYX
         iM6iIDxNZOKDH4v37keoAFU/4XiQpuy7nRZEKOD/JXdQY51flWKfhv1BZ1IkH+t79sJL
         2JM+dy0ORtMjQ1yiTgfZhvvSXVdOZep98Q4BWuMYEii88IeEWgLQUZdIZZG9uZtVqALM
         1E2g==
X-Forwarded-Encrypted: i=1; AJvYcCVAr0ncr4oF/IMovxaqhatqVISAXWYkZVztJJm7rNm3+w28f+wBZuh4Cr2a51IdOf30+Wc5dQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZxHxYmtVQBSONpflfPgLIDNwi/8zuYydgblNMVERoUXZc2K4S
	C/sMA76Da0yh5A9ceJTfPk+0zhWVz30VZ/gQpBHXEiIvMZClliKhzNCg
X-Gm-Gg: ASbGncvuIspcIn5cO0tMnbvrydXwcwGO2+QPqg0BLr5RZxgEbD3+PP8Ur6EtzWKQEy+
	czSQ91nWX6lisGFG9umcUV8jankQcX8zi23tpumDcpKcvqLVIwSt5E/R1kybOupKBdys0GBbMHi
	tmABSe1iyGuyFMKCaxryl/XdLYtpMuiUPYoaoEfaNr11nqJH2ERKESM8KHPBTt4TLzRxhPdtsXn
	vyYcGIQo7yEWQhLx94iHZTXA5MRBKGtPDlgIOqsPnPdeqs+peZaEwy8RbgiSD4AenKT9CKL4Kfp
	DZfC0yruEn6HVBXA1Ghy0SyXorTEeVxpoV50jMFow0VkaWoNK2i41Ee+OdV736y/8S6VShe3zPq
	84xBM8U+0xwOpJXMyvIf7IcAYOK8u3sOEskerarILUgv/JXbjWHEVLtKaKY1owEa6kEf5/i1kgx
	gIwUTS+5fCpeU=
X-Google-Smtp-Source: AGHT+IH5By0meVnQ9qhOd0v1dNWouNpBeUnyg8cUDtnc/vnhavHu9EHhWNQzZaDdLMGKI0UHiqsGCA==
X-Received: by 2002:a17:902:e801:b0:295:2c8e:8e50 with SMTP id d9443c01a7336-2962ad88b6dmr93261795ad.31.1762414735847;
        Wed, 05 Nov 2025 23:38:55 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ca1eb7sm18451465ad.89.2025.11.05.23.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 23:38:55 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id A3801420A685; Thu, 06 Nov 2025 14:38:52 +0700 (WIB)
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
Subject: [PATCH 0/2] genpt documentation fixes
Date: Thu,  6 Nov 2025 14:38:43 +0700
Message-ID: <20251106073845.36445-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=746; i=bagasdotme@gmail.com; h=from:subject; bh=fHpHqdj6evMaMAwbOPs89dx0SybJWtU+E52RFwbkzc8=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJk8/o+fmyZ3n3i9oCBhSdKKY9OONbWdFd38cSPf8ewvV X7JCduOdpSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAizXsZGc6KqrfvqfxneLHS h1PwzMVJTDdqr3x2jHx979X7y1p/Nukz/OHQnqrrrBAvvqldJ7MxP3qWXrHerku+jWuXTYwItOk OZAQA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Here are fixes for two htmldocs warnings in generic radix page table
documentation. The first one is reported in linux-next [1], and the
second one is also found when making htmldocs locally to reproduce the
former.

Enjoy!

[1]: https://lore.kernel.org/linux-next/20251106143925.578e411b@canb.auug.org.au/

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

