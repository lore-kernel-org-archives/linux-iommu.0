Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE4537F015
	for <iommu@lists.linux.dev>; Wed, 27 May 2026 03:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779852583; cv=none; b=BNAyaAMmBs++/xHUHYqruQTkMNgJtlAp1bd4jAhfweA6MBftn3Sm7wG+4FgjU5F79R/ki4YPpbk64NAZaacOyEUSJlQ8mLjwdnjgxR2bmkdgwS3EMLj+HbB4z1M46fNc5i/52o3h/1rEGG6MgXfx5d+xHylVfGL0n+NpJPcl/FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779852583; c=relaxed/simple;
	bh=OetecSVWSHSGXKbVApct5VtDpZdb+yRma6A6pwugszA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkjhDmUzdDb26LSsw1yMJTC6nhn4Lr7TwZIBbH984A+28454TdZiRz1anpaEKmFZCtDK2Y6nWLO4jcAo0bNtcfG81ZDhFDFy79jVX2Y8zCWlC81zaaEgki2RE9KCy0EdsgF1cCYke5r8dhRbbqJdhnXi5+cSb5iVBynbBewWntA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oQ5niEaa; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQ5niEaa"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-83f674f978fso4362012b3a.3
        for <iommu@lists.linux.dev>; Tue, 26 May 2026 20:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779852581; x=1780457381; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osub7jqB1KkbojdE6IP/r6iEAlyJyU/eaCe2RQB9Q9c=;
        b=oQ5niEaaIoTK4Eq8IjGuddauRoTJ+Vmm2g4fhE6ebPfUKId768vxuFMvBsQpLzkm3c
         ksEyAWVXQWB6H77yhhLH6SFOM8dvcNv++HaF1kCvWh1SegF7Q3SJSoqj+NI7+jT0NVRZ
         fwV1ay9oRSWxz2RiiYevTThAmOVxkHGQowvWS+RLrzK1j402S9uGArbt6izcp9zn0bDI
         6XuOjU52ETHS6jV851Bg6fCsC0E6/lLEnO5i5ba+DesewjrwDPJk2VhVI5WxnGB7K2sI
         rbaj3Ti1WuGMOUq2L34Jo3RKV2sY2v0xSltcZ1Lslw+cgy+Mk+bKPN3DEF20wgj/UoFn
         UatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779852581; x=1780457381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=osub7jqB1KkbojdE6IP/r6iEAlyJyU/eaCe2RQB9Q9c=;
        b=K+Bf3nuBp0K16GHAeGrhfQHp6D0rgxEmgIMMFRvQ6N4MBANG6/Vyosa2mzChy6zvYx
         erBcVJN0Zfx+7GOaZzlyNRNqjiHk/0r2Q6Z0ODnLiO5mWDgsnBHMRmfS3tAHd19CPZWJ
         kANMD8Y9myTkGqed4Q5n8yDaezV1F4l43JfcX8T6dEPjaUHfu4mlgL0rL4fEj+5FlLOu
         VzsIUKU92ozRt8LIMRGwdiZpSjIpGHr+VpvYOGwcKG5Qjz/n13ZTEy5T9Ljjc2PzNH4c
         3C9YDfbx/SUpDqvLuL1tN0C/tAHtbTWt26fmfFOE74nb6QeV8R+2aa5c/i1kC5YmJjY6
         p8Fw==
X-Forwarded-Encrypted: i=1; AFNElJ+7RN39W4MYagPhNjRBOjgaNBAEZ5XDwry197xASWysXS+HPgK2FajkDH6O0DuM2K3RFrOsUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAV3eMiHhZa3xzFXADDkzQE+xpm113QIhIr5wxTreWh09KwXIh
	0Eq+2RYKOiuQTev4M04Z96K3ZRnKdMR12T//kwzL/B5YJXPZBWfs0UiuymYCnEak8amY4g==
X-Gm-Gg: Acq92OHmSo+rDr8nFN/pDzH822FUH1Uxp9A/4ybDXlZISuK/+7CEiQxQYWQ6mnV9OZU
	2opEPyVW9YTv3Na0P3y0R4Xj5kFRiW75kxnKhUXa+ijsWl5pNd8Hnh5Fs4MvYiKR24/prHgBuJq
	Iv152nq5gQ2jEYZd2fFGCXnEYmVc9cqOUhoD3A/y1ZqlrOyiPgKBqPC8dk8HL7/iNlTHivF9yjO
	gVYHtKOoaI5x0n81ycdZpPycxeXnRRHtj6Ogv/NNyny48s/rzfeK1XJkfvdERvJmJkFP0Xmr8E3
	VhCGkGbfvW5FlAuDiAFNtI/pam39Kf+Hn0ck/XnDZRVQIqAN+9PbqEreXleuKSQxNDl+yduCzO3
	V/Ml6YpgiQKWbezDsskF3WiY1KwrCLD5KKXvK+m36KHICSRZhnwstogd5yjcLqNIUQ7N1qipnZf
	qiQs8nm1i/Fdh8rsz4Zj9w2awcjvbQt5HPiKXM
X-Received: by 2002:a05:6a00:7702:b0:841:dc7d:306a with SMTP id d2e1a72fcca58-841dc7d511cmr264256b3a.25.1779852581229;
        Tue, 26 May 2026 20:29:41 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d7307596sm749688b3a.59.2026.05.26.20.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 20:29:40 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev,
	zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	quic_obabatun@quicinc.com
Subject: [PATCH v3 01/11] of: reserved_mem: handle NULL name in of_reserved_mem_lookup()
Date: Wed, 27 May 2026 11:29:07 +0800
Message-ID: <20260527032917.3385849-2-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527032917.3385849-1-chenwandun1@gmail.com>
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

Prepare for an upcoming change that appends /memreserve/ entries to
reserved_mem[]; such entries have no name.

No functional change.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
---
 drivers/of/of_reserved_mem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 8d5777cb5d1b..313cbc57aa45 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -788,7 +788,8 @@ struct reserved_mem *of_reserved_mem_lookup(struct device_node *np)
 
 	name = kbasename(np->full_name);
 	for (i = 0; i < reserved_mem_count; i++)
-		if (!strcmp(reserved_mem[i].name, name))
+		if (reserved_mem[i].name &&
+		    !strcmp(reserved_mem[i].name, name))
 			return &reserved_mem[i];
 
 	return NULL;
-- 
2.43.0

