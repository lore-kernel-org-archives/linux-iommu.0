Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04843E0C67
	for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 12:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893993; cv=none; b=JzmOqLanDgTPeV8Dk/7NCbEHi+EQojGUPzv6AYe+/WAzb7IXLYDDyfdj2gsjRs8SzP8Zo/BKxQdTtrTWiCA/EyGSwAG7lfKMuKf6NhhCsgBRXN+pon1nI+pXfKmAf/NHjhfakoMXYkNrubAU7yjFFdCu05gbE5VZpHGaYo3AJ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893993; c=relaxed/simple;
	bh=y4qpe0tgvGpYrTTX2TUZf8EY0t68Wbod8QGn65cyHK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UHuimgrgoPQtji/ChrT+eZYdxAPXTwNA0KcRXNHs88fDdJQd7drIhKJlPR6aZq7wfQF8t7b+B1q3QQo1/rKYRz/6jlTJTFu+zh6b8hWQsgVuCCtajZ3f82qRUVJ5stj78pOQ5NuFxkh+VIB5eQqiBEW/T5IbFAkvv+Fhd5oZeDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=FKdySRCI; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="FKdySRCI"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso1688606f8f.1
        for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 05:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1791893989; x=1792498789; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7OLEATEFg9EwTB6dtGbWTtK5m6qNSnDgXdqZaAx1bWM=;
        b=FKdySRCIaJAJ3j5s9ViJ3/EjObovRtJlZSK1pIa91+AN1+UbKrjhzoFCNspuPWlWVg
         7y8P2zeu5KZD/so2+HcGaDVCCtpX8T9iMd6HrJC5ZlkTQQ69bvBle2VT4b43j/+Pj8H/
         g8wzO2zLgktQC3bohAmGduo68wkEp7b9CDE83FdxjZ7U3MT2BF3duI+6drIiftbHtgv/
         C0r+yeplvS1Qpd1McwtHaO3ob6AHE5Q/2YuOi9dP0asAEf0LTpTTMYVnNwwLFONKUevK
         JvTWaJYhf5HSbE8MktcwmoOFV6i91/AXVwjvPHhWTODPwaFE+SOrGaSZlwPxaiKb7Dca
         yrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791893989; x=1792498789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7OLEATEFg9EwTB6dtGbWTtK5m6qNSnDgXdqZaAx1bWM=;
        b=KHaKwb3DKzP9jzN2vgQUC6ieFqKD6vQxfjO0zGR++WbrlEg3Vcxi10RsxyYqPO4+oS
         Oh3VpM8/rcsbM7d6ub/NgH1cjEgQfaXpu0tjqdM7UtX3+Uv2LjUFiATZgMF1FCpUNCMW
         cUin43452ojoCzDfDGWQ7fA/C1ZLpkGuQ+CHLx+d+HBvhM8ozpmdpPdG1bOFsbIbi3em
         /SOrkBOSyoKMeUxoidoIDSxIvNvhpV5uQPfXeVlG+h5mjpZc6MhtysRZtcRc76UYZiS7
         sNQU4j8lZoyYXWstUGe2jthRuj5qjtdGT5fBcYI+IiARotO6nGGotL58LuEUoxucunkR
         8tRg==
X-Forwarded-Encrypted: i=1; AKwUvBxvvOgmD94mqatnD4AIHuHEFjIb9yQf5kPE/eCu70pyau3MI6jMI/67bs/VODKMj+9lgCS3ug==@lists.linux.dev
X-Gm-Message-State: AFq9FYJLTc4W7HvnSVT5Hdg3p/UXKzqHOZIusmIxmh8+u0+F4KgBJfU/
	1uul3VPjTc00U5X4ccMm8HIryBtr+/8SqJd9tXopdr0YSQgieJ0SpsXknTsLJD6FwXo=
X-Gm-Gg: AYBFou0TAnC3FD/3STDIGS+zQXeDq8M/UJzzl4MCdEnuPcsupzOyjOJA+PviefF1Cdw
	3DV6eBZK3DCkOiRdJ3grtNpGlbn16NkJy55kAwtRaH5TBA7A/tzCKcuZ11r7g46eiFae8ufQVSl
	Lmxqcb0jD56Kl9ixghcZEBn9D7qbHdgCDWXzGeoGf9VX+wpTAV2duExrb9q39mZCyH4TnkQ+qY5
	jPi+5Mggq2cqcuajxfM/fOmXx5eLZHUEGPlFO+F0ZFs/JawZd+O4ijkFvcukCqd1S4tksGpEWO2
	MwJPYIJVYlGiVxBDaBuh+0P9Iv6jfcjkjOopSXGa5Z+Jl9XxLJaOPo6PTGlg2f8+U1O+feOpmkJ
	epBvbohVr7LNzS6kJwFs0p9qpdiVtdZ8CaC0byEOD2wRZP4wuVxAay8bntIofEWBnASqdMVJ6pv
	ZQx3ibZXYlHMJ4aS1dzuYCCdix0hWHLvUFyoQdrmgNWF5y1291McjuQYvAE4bTeQoMjAO+S8PF
X-Received: by 2002:a5d:44cd:0:b0:488:89e4:c3af with SMTP id ffacd0b85a97d-48dbaae4869mr18341163f8f.45.1791893988877;
        Tue, 13 Oct 2026 05:19:48 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:26c8::3dd:3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc5e0asm4806155f8f.50.2026.10.13.05.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 05:19:48 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Sairaj Kodilkar <sarunkod@amd.com>,
	Ankit Soni <Ankit.Soni@amd.com>,
	Baoquan He <bhe@redhat.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [PATCH v2 0/2] iommu/amd: Fix device table setup in kdump kernels
Date: Tue, 13 Oct 2026 13:19:42 +0100
Message-ID: <20261013121944.4060097-1-matt@readmodwrite.com>
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
and the dump was written over the network. The reuse-failure path in
patch 1 was found by code inspection, not exercised by this test.

---
Changes in v2:
- Explain the split base-register write and DMA32 requirement in patch 2.
- Limit patch 2's stable backports to 6.18.x and later, which contain
  38e5f33ee359.
- Add Ashish Kalra's and Ankit Soni's Reviewed-by tags to both patches,
  and Vasant Hegde's Reviewed-by tag to patch 1.
- No code changes from v1.

v1: https://lore.kernel.org/r/20261002133143.3628181-1-matt@readmodwrite.com

Matt Fleming (2):
  iommu/amd: Program device table when kdump reuse fails
  iommu/amd: Don't allocate kdump device table from DMA32

 drivers/iommu/amd/init.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

-- 
2.43.0

