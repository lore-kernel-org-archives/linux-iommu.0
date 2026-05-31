Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C465E391E59
	for <iommu@lists.linux.dev>; Sun, 31 May 2026 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780246985; cv=none; b=YLZ1Y3NLB/6M93PO5S7abcCOIDIFYktqVFqSNvNy+hXiJLYcVXRnheZrGjJBvCjYibYjwi5NFCnyCKdHod9mxfPwZN1AnaL8tRwFrQgRNlaNiRZWOgMYyBKsNY326qgPgR+lzpcn9zd0Ol4aAVC2WIGdP/VyD7Nzo/+1XZqagrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780246985; c=relaxed/simple;
	bh=YgLJf47j2rvL5UzJW0CWIyQNsMhK13ggWUOSMGN3lnI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xg1HmD/OfBqztYAa0jO7VNHAuHkXxz3B9qeljEFslIJUy49pZt5L++E3mLKZGVQTmxuNBjZ1KfgkcK1S+W1t4r+a5dUJjkHRMs6NpvzKY8vh7FbBFYLeKnwMX+eNoQfJ/flKBBk2FHdjigF/iCzzQ0U6vKcVzXiXQvSZozDiaII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aichMPkt; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aichMPkt"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bfdd99f6b7so23675165ad.0
        for <iommu@lists.linux.dev>; Sun, 31 May 2026 10:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780246984; x=1780851784; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=61nUYKvRFkNmEacFmLV+B7OCu4lQy5aTJXNSuY6+Mt4=;
        b=aichMPkt9nZrUKSfSbhbtl6rb1YMbSCcl/PpIplxNcxSKiOwvOSMp1d0QKJ1VhQx2X
         6ZT83bfGzUgo8tq8SAWgE0n/u9KcU5GZVvxAiqHzSy88geWOAGtwjWv4xtr/i0RMOERd
         JmBYT1uXLwllh6fqqrbJVa4dWHac9NqjYc8Fq2Wv35tGCDPd2pFVIi+i4p524TopoM08
         V7VzQrzIv7i8JqkvSim0uaZM992BLX/QGdmNJa8DseUmkUGIXVDd5+cfXdMy/QLBRe9x
         zyxpP8G5v+/CFz54+FvyqnK2PNPjqNPISnI8hiyu3Nlzp6GN11LyAvb0P3gwgLHJa+1t
         qZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780246984; x=1780851784;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=61nUYKvRFkNmEacFmLV+B7OCu4lQy5aTJXNSuY6+Mt4=;
        b=XAJl7ddDbHfVfLOZI8zq2k7P/G/ndoQsdt0XE11JPsytjhUrQTLZG8+odDxr2fDQti
         akRyx6I5EbbfMRJqTKJKAvp+VyAJh6Ii8H4IUN9Ox90PL40zihq4AuqMFD7ObLASKoSd
         RTKW+RpzzX0HQuYCOFPHBXIkyLXhsYgzkFrQy/5Q83SC1QpvawkmYAh7mq65paPJgnvr
         VvLx1iBNErOKBG+V2gxtLfaOWtwgEWnBWI2UmOXNkEt+Wb0m+UNaSaVQM2S4hbuTYn2C
         hS/3XHfFo+/QwezxyLNebaosxWUNyHgT5+GEjDj52065tf24l3U8VJQIIjSuEg7zY3Iw
         hJIw==
X-Gm-Message-State: AOJu0YybugHLTLJC2K0tV8SOalxmkxJbRizQjlowkuQmoOH3qmnwiTd5
	9ehmYhHoRoHgHrRexSbfoDvkLQr2nrmeZgMZ/5UmyfWmVrTQ5ESlgsKGcy+N6KDBOVdJ3emYxKH
	TGgukFTZY2q8CxdyFa6vFpAl9mJ9LaQKG67sR+C372xJnY/CGJYrwaoGiyczNC1PVFWK0vt97Cj
	VozJDRJOIYDtERl88ugkBnjuvkOpQyWQ==
X-Received: from plxj16.prod.google.com ([2002:a17:902:da90:b0:2bf:2cd5:1d4a])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b4d:b0:2bf:2015:5b93
 with SMTP id d9443c01a7336-2bf367d9879mr94331165ad.11.1780246983783; Sun, 31
 May 2026 10:03:03 -0700 (PDT)
Date: Sun, 31 May 2026 17:02:54 +0000
In-Reply-To: <20260531170254.60493-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260531170254.60493-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531170254.60493-3-praan@google.com>
Subject: [PATCH v2 2/2] iommu/vt-d: Fix Use-After-Free in probe error path
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

Fixes: eda1a94caf6b ("iommu: Mark dev_iommu_priv_set() with a lockdep")
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

