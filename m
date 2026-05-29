Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAED3D904D
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780054459; cv=none; b=KLLnfh0HZuKeaG8bDzQ+NSqGgML5SW38qpRkmW4EojQym8dQ64jCTiu/UuR2n2pqjXgobzB6za7WHWmHpEn3zCHW2LOs9HwCcLRQ+zRJPH7rL9IJY8yWQBEwQ6WXZ3656Oese73cqnJiq7cQvK9QoizxmWb6cDnRS85tskC/Qr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780054459; c=relaxed/simple;
	bh=Ssnbun7VLxju8YaYsXt6eXq1OojTzRiQ6Ip5oWNtKQQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TKifulYMv/iLX414hGG3ncoU/ugbRUPJd2cosjL/LtYHetBKjjZXttgSw7+cxHuP9zHx51tsq5NmzZS7OumT8kybn5LM2d0eMbhJJlxYYL4tJ5jjw8nXAMsoX3nbDXKeFtsAmUyv0thTr+qptGFzyGcw+MDacVfdrg82oJyIdns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZCWTFVlo; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZCWTFVlo"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8386367b23cso9999787b3a.3
        for <iommu@lists.linux.dev>; Fri, 29 May 2026 04:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780054457; x=1780659257; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6HNBo5qpDi3ImLRDNA0LtSeSThXzOZoURBioR1Mctk=;
        b=ZCWTFVlo5vzbyOs4ePG0yWBP6PDZGSgPp5O9sXSi+exLiobZK/a9dHb/KFOO+iI9MW
         TzlaaZt8h0eeCABDY7roR1SovNPejM66BP0Ed9/zBPZStXhMvJnym3fb17zLAC6NB4+K
         a0yAG5Yvt4KtPJ2r58IPQ6jql3IU5EOFhoy8rrIVozcPRchnSydL7LZ4/qfEgHUxXaUv
         roksshYWCXbGXVuar5cJO5vgBPb3FCuNIKcFYlEgk2UqORxOHmvQ7RBEXagGBIQvq9jX
         lFyrVK8dSHtGorMySMSjvSaFnNl3VlHdy0i96oPvvVuseXmEgSsAr+dXaC8um6nqqhjH
         g2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780054457; x=1780659257;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6HNBo5qpDi3ImLRDNA0LtSeSThXzOZoURBioR1Mctk=;
        b=SAvj0DVraYvTu4wlimIep8bNPX7payxvtgEB8uEotX06rDWtBD4D+GQk+y254sGgRD
         qERvMYjGfLCODlUjCNH0U2sEB2DQMat6/+ikKkgce/zSAasXRDs443Vr0BGmmPwj6p2b
         d8V0araB+Pk/HFljb2A0ehowBiImFKSx9PJVgo7K70iisPQn1NSGAeD+M72Ym//+bMmQ
         J23s17kPqsRDM3XymMEOZvNcNCfsOJ8YebMyfFxMWabJ1pQeD1+FoolkR64nfA6i10AV
         zd7ylRrFUUyX/7ds+yr8NyzecdVJB8gCaPux3aphCVVgHGOdhdW5+YeOLXXvZG5b1OrV
         N33g==
X-Gm-Message-State: AOJu0YxyadMJyHAQIVuYAPvQK31AJHemt8Ce3qNyoP8hjXXOjVtn7u9f
	svj/kJjD5xL+8fpR6MJciyo6lUOJYHiZOuxT0+Voe9ZV7DRCRFAmlZ9SzR9n8hbURdOqlcV6zPk
	LgXWP1aayxbSsEGjDx9vGX/PM592IRWP+raYOuLSLOgKd2MKsQqsEhJ3CBp1sgDTm6TQCdFUzJz
	QkS5gDmQJ36zqMGlTaBfAM/6SSBbZjxw==
X-Received: from pghl22.prod.google.com ([2002:a63:f316:0:b0:c82:7df9:8c1d])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7a96:b0:3b3:bf95:f800
 with SMTP id adf61e73a8af0-3b411e711dbmr3065697637.44.1780054456528; Fri, 29
 May 2026 04:34:16 -0700 (PDT)
Date: Fri, 29 May 2026 11:34:10 +0000
In-Reply-To: <20260529113410.491538-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529113410.491538-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529113410.491538-3-praan@google.com>
Subject: [PATCH 2/2] iommu/vt-d: Fix Use-After-Free in probe error path
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Pranjal Shrivastava <praan@google.com>, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

When intel_iommu_probe_device() fails after the info structure has
been linked to the device via dev_iommu_priv_set(), the error path
calls kfree(info) but does not clear the pointer in the device
structure.

This results in a Use-After-Free regression if the pointer is accessed
by a subsequent IOMMU core call or a re-probe.

Fix this by ensuring dev_iommu_priv_set(dev, NULL) is called before
freeing the info structure in the error path.

Fixes: 89436f4f5412 ("iommu/vt-d: Fix WARN_ON in iommu probe path")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260525205628.CD4431F000E9@smtp.kernel.org/
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/intel/iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2702e9aa2241..6c718adf97ae 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3320,6 +3320,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 clear_rbtree:
 	device_rbtree_remove(info);
 free:
+	dev_iommu_priv_set(dev, NULL);
 	kfree(info);
 
 	return ERR_PTR(ret);
-- 
2.54.0.823.g6e5bcc1fc9-goog

