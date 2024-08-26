Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225B413AD1D
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 07:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656625; cv=none; b=abBhZhwRkJKEk1IaoeBVcN471qv940o3kLCtFfoVkxOwRx+GMCafaZ7g/lymAcVtSQNfGSG7g+/SOCxBwgR7N8dKih6xw2FT7dOUsVu6PsOMmeSd3vahPJhDCzBoiP+0lHpCOWC9vRCOh7PjPmpbBUpbnyPIIPhM859SH+w6ifU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656625; c=relaxed/simple;
	bh=FwDerl9XfOepzosKt3JEHoXPHsvu6Cl6My4q4umLuAQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JepUPkoV53vkJbKrW+rbVLj5T7qe5eD+7dUSQfvvzqh0GZEmUxgqIjIBf9xgzVmDgjemktS/wf9n5HbvZ8tw0vtL0rVdOKsoiY/H9th1xszQ7pcc+RzYIJacznj3NMg7Am/BgLv1dXn/yjkhrHgocpsp5gOwnrWsTHrX7P8oATE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nHZpODCM; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nHZpODCM"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6886cd07673so89960167b3.3
        for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 00:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724656623; x=1725261423; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UlAkpThGXQLvVPx+k8dqLCpxi8en9zSnxpsu3M8WXYc=;
        b=nHZpODCMkF95D2VzeQgLse6Ab4c8yIt7vGBy29/3UqZxNR4h1V5Qjl7CpN2esshLR7
         cU4kkW6MgPl/WBGgwci/vLId9JDvQX7xExJ9j0XvyF5bvYMsdAeN6r9iFJ432yraDrAX
         Iihjn6NxeDjBfiOHpq3Wo/Gp5bsF+SiahnKYzHp72jELOqAFy8PggFYEp6+W8KJ/PxYu
         Gk3X4zeUw2EnlhxFYNJGitbmOsc90w2uDF3zvJtuH95j1ENmOzw481xYiFBn3yufvX5E
         tDfYnpnQjI3qC9JvvBcDstFysHqG5aSurgHriz1Px9qXL53N5gJzZS9QRm7IkYtxT8R/
         RjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724656623; x=1725261423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UlAkpThGXQLvVPx+k8dqLCpxi8en9zSnxpsu3M8WXYc=;
        b=uk5vN3ohnHI5oCykwLgKamHZ+8NjmpMoYcDR5gUPZRvHcN7njV15TyoV3CRoWkidhL
         zNhFa4lLjIpK7JicbZsM0Ux8RYZunZrUn8e/00v+EH4rxns9kAjlSlLk0hgK4084l0Hl
         HONZyudPwSm3k2HZpGPsah/1yTrEa8iFXX0NT/XQWqfNNEdyNyF9fmZZo3Vxxa755ybY
         riTdMOXqSHqg1VPZvz4a7mZBSbQV6uAaqFiT0XLVVQcJHU26WCECShLpGw9++78KTLIQ
         zPztlo1giycMNWnIB9yatWJp6i/EvcCp/tFj5jnPeXMVoHI7I0lOUi8rhO8IXOVYWCp5
         bIFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRmP4H1GgZXUVr24rcW4Y3DP7I3K8AnpHLbLfhLLYj7EfdXyDrMH6LY9f8VmCHTWnFE4svIw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7NRwm0WsyC90FrTqh+WhxGUkjQcOzdDlCO0KQEXtgk5MkngV+
	LBUISghzR/t2rcOZtLyTRdK3eHdn3z6APf2ARqP3+Hi9j+9ep6rQpZhlqolJsd1XHfiYj2/WaEC
	y28f90hBwpgBPiqdsag==
X-Google-Smtp-Source: AGHT+IGTv9O5nWsMNvAuvREulYcA7bXvWQ9CujjRqJDianvCbgB7Y8UFv1A0WfQ112BR7wvtStav+ASLkpwyAOMW
X-Received: from manojvishy.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:413f])
 (user=manojvishy job=sendgmr) by 2002:a81:dc07:0:b0:691:41f5:7f3d with SMTP
 id 00721157ae682-6c627f0b1e1mr463277b3.4.1724656623018; Mon, 26 Aug 2024
 00:17:03 -0700 (PDT)
Date: Mon, 26 Aug 2024 07:16:40 +0000
In-Reply-To: <20240826071641.2691374-1-manojvishy@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240826071641.2691374-1-manojvishy@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240826071641.2691374-4-manojvishy@google.com>
Subject: [PATCH v1 3/4] vfio: Add VFIO_DMA_MAP_FLAG_SYS_CACHE to control
 device access to system cache
From: Manoj Vishwanathan <manojvishy@google.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Alex Williamson <alex.williamson@redhat.com>, 
	linux-arm-kernel@lists.infradead.org
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	David Dillow <dillow@google.com>, Manoj Vishwanathan <manojvishy@google.com>
Content-Type: text/plain; charset="UTF-8"

This new flag allows controlling whether a device buffers should be mapped to
sys cache for mapped DMA regions.

Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
---
 include/uapi/linux/vfio.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 2b68e6cdf190..494611a046d3 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1560,6 +1560,7 @@ struct vfio_iommu_type1_dma_map {
 #define VFIO_DMA_MAP_FLAG_READ (1 << 0)		/* readable from device */
 #define VFIO_DMA_MAP_FLAG_WRITE (1 << 1)	/* writable from device */
 #define VFIO_DMA_MAP_FLAG_VADDR (1 << 2)
+#define VFIO_DMA_MAP_FLAG_SYS_CACHE (1 << 6)	/* Sys Cache able from device */
 	__u64	vaddr;				/* Process virtual address */
 	__u64	iova;				/* IO virtual address */
 	__u64	size;				/* Size of mapping (bytes) */
-- 
2.46.0.295.g3b9ea8a38a-goog

