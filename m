Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3031D13BC12
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 07:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656628; cv=none; b=Lw7Gjl92/X/V9L3/3uDbHOJ8RcF7r3Yx+HBxmrle2c6snGnP4TK2NVUuHf/MHWFWOJpyGQZoBTp9fRBi5MpXDVj/3EbVGKN1tX6edPS/Gh6Q2DP6LTKtsNVjuUMS23DqIQD/NIruFZOPy7GGpEMh6LXAnx+9EAz5UxJp/gyXE8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656628; c=relaxed/simple;
	bh=MZZj2SAvpagdGOtXPGGnDmJg+RAzKw+H3OQrffzD+8w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ee4GhZduI6CXyM+zGUzqe6hoTATFiGmD7r5Ksi6ukkF5jlcdx/8MNmo89BNDX+jGyO/j5rJJQ/JYOiydQkhdjaXXhdDDk6vR2ddFwrmWoviQau9c6HHIru39p4ypS3K7oLzf73aClh8/+sEdUsASn/Xv54kDdHeNWUbWH2J2hs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U4wCAAnH; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U4wCAAnH"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b0f068833bso72985527b3.0
        for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 00:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724656626; x=1725261426; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=glhE4wUH8upwh3h840zUvzyaLndPAI9WWeySK76KAe4=;
        b=U4wCAAnHqcVwNqv7EyJuEuSpd9YqjOsgvdL7bxPY41b2OKEovglMh+pyOaavYGCJGJ
         y+znJUWLYHNM1XjRBKYw8YvYe6+eaVYDUwNx8eYwlEwwy8v9dIWWM3XPCfvxkUmRuMpg
         ejAiaqr2XyhFJLYmX/Cx7Pwa/zXk5pnOEAZkgucZPwT85sAYdwTWGzxEirvVkugKCJxk
         3EoH9YO/tjscmeijiDBZr9dh+9XWafz0MKAbEl2fEAvTGVl0i8IT7IkRHIDm7HDRpgIC
         KbH/9ehpRUebYCuNdfEMzVGJ9j7AAGLCSTkVt3+FkYkLKRyQSxWdi4yW6o6wwCbqvVaJ
         qE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724656626; x=1725261426;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=glhE4wUH8upwh3h840zUvzyaLndPAI9WWeySK76KAe4=;
        b=RZBN9iRVRK0GeJDQDFNznLIY/Oq+UzFs4pNNk2M+ZR7aYjCaVB/thREVpSc0AbSbuL
         iZO5RDmgzp6hB4vdlPWn4hgAzuyTv60/u6We7okYH8R6nyE4qRxib5NspYXF0X3pKPqJ
         eYxncIISY4uUXdHq9pv9pZXr5UkQnd9poAu0r4aVbNjqdk/sscVowFGu5Yiy+8dKRl+3
         iF2r9E0SEx8F562Ke9GA/myiDG2Q4qxMrDvpXFOkk5hwptdniFM/upVP58HRyFU3zh+G
         lonXNHVBWMOtiOZTfbNP0GfZo/Dld0Oy4IXKXk17u3a6LkXxHVLTRG//1qjnVtAVrFId
         7GBA==
X-Forwarded-Encrypted: i=1; AJvYcCX7sb6pYYioG+m2tFvwJxLQjjrLrzXbHN2HOYbn46yKakEYDfI7BMj+cPEnnPhaUduOZ7Oupw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgB6Fo3KdeInzEH9RXUo6unC0Lh39o0RJP0n6EJ+eD3EJ2xjHH
	F/Su3Sn9I5fNDr3XM/awKyb9CAw/O4qOuJGxbCCxKC6epmNYReT+WGWn5DLTa+Zjg61gYKSHagJ
	0uLuc7meEfJ+T6AQxNQ==
X-Google-Smtp-Source: AGHT+IHNO2NOT8z5pjPX4FeBdIeAVLHmjqUYd3PJJUwIcYAFNDV3F2bzyhnKkfV2wlyMcU549dbh9KtZHmBsNHWt
X-Received: from manojvishy.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:413f])
 (user=manojvishy job=sendgmr) by 2002:a25:aa85:0:b0:e11:593b:b8e7 with SMTP
 id 3f1490d57ef6-e17a7a6905amr147799276.3.1724656626199; Mon, 26 Aug 2024
 00:17:06 -0700 (PDT)
Date: Mon, 26 Aug 2024 07:16:41 +0000
In-Reply-To: <20240826071641.2691374-1-manojvishy@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240826071641.2691374-1-manojvishy@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240826071641.2691374-5-manojvishy@google.com>
Subject: [PATCH v1 4/4] vfio/type1: Add support for VFIO_DMA_MAP_FLAG_SYS_CACHE
From: Manoj Vishwanathan <manojvishy@google.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Alex Williamson <alex.williamson@redhat.com>, 
	linux-arm-kernel@lists.infradead.org
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	David Dillow <dillow@google.com>, Manoj Vishwanathan <manojvishy@google.com>
Content-Type: text/plain; charset="UTF-8"

Introducing the VFIO_DMA_MAP_FLAG_SYS_CACHE flag to control
whether mapped DMA regions are cached in the system cache.

Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
---
 drivers/vfio/vfio_iommu_type1.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 0960699e7554..c84bb6c8b12f 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1562,7 +1562,8 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
 		prot |= IOMMU_WRITE;
 	if (map->flags & VFIO_DMA_MAP_FLAG_READ)
 		prot |= IOMMU_READ;
-
+	if (map->flags & VFIO_DMA_MAP_FLAG_SYS_CACHE)
+		prot |= IOMMU_SYS_CACHE;
 	if ((prot && set_vaddr) || (!prot && !set_vaddr))
 		return -EINVAL;
 
@@ -2815,7 +2816,7 @@ static int vfio_iommu_type1_map_dma(struct vfio_iommu *iommu,
 	struct vfio_iommu_type1_dma_map map;
 	unsigned long minsz;
 	uint32_t mask = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE |
-			VFIO_DMA_MAP_FLAG_VADDR;
+			VFIO_DMA_MAP_FLAG_SYS_CACHE | VFIO_DMA_MAP_FLAG_VADDR;
 
 	minsz = offsetofend(struct vfio_iommu_type1_dma_map, size);
 
-- 
2.46.0.295.g3b9ea8a38a-goog

