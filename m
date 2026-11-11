Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425064;
	b=YZ6qgsc1BaDrOMOGhzaiu/DP+v+a/DNr6Trs70gSgs2T7+Np23NZ6cqRY2JHalhtEDy3
	 qTndlaWWDWe9dbKH6S9O/+vleO9WmNL7W32SeGlQ+Qb1hwH6h0Pe+i+QurN4Ax5ltU6cn
	 jSzNR5Ihu52IrZUxpUZYEcozmper+s2qAD3xBSWP730adFQ5b+xNifo46Fkgb+m7ANxUU
	 Cy6VffvCjZ3AMase1XTk77oNO052H/6g/WiUgElQKfmHCeYDvV/781M3fXuvWzaqmdA3b
	 WDD/UciePCHGr/IF55mb66ieZIrjwOd7r9OWqvTpQDNKAttVfNJ87yXe3hUJNH7yPMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=S4+DQ/5hS2/5UfXO0mi1ZgFeMRsr05x8y1FYZlBsi/k=;
	b=Kq0cDpM1EZdY74qPfDA25vQc299VLmLCJUlgoCHvNXcOf2i3o8lTPmUW72hVp2VN4MiR
	 oqSXl2WgI/c36iAD/vwmreoXICMfnk/6OCsV6fr1K2zBHioS/X6fWozeOKlYOnns5ZOJ0
	 xH4Ds4ZVMJ9Yz3Lc/Aa4W6pbl3HIhrxVn8RdvXIl6HObxoh9/qGBeWbKCjIpquJcYA5Ps
	 sxQykyJF9Jps1Qp1lecJPrm/N2822c6sLjuW3YqC7q35zy/PFADLTb8erYcl9Ygtt/60k
	 pyY0A8yNA3TmdMNKT0YUZ+MnJ4ao/shERnAPWGFVdQDAFuMWq6PxWFc0zXPzjdqmncA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FB42xkwO;
	arc=none smtp.remote-ip=209.85.210.69
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F92606B5FE
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 19:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95F92606B5FE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FB42xkwO
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-8520e83f715so3842602a34.2
        for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 11:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794425063; x=1795029863; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S4+DQ/5hS2/5UfXO0mi1ZgFeMRsr05x8y1FYZlBsi/k=;
        b=FB42xkwOHgqTHSJrq4Gf2xVLBCdnmRoqnHKdxzDu4qwzVvyFOPcDCjKiquR44c9QXb
         GTfabm6El8Oi60ijPKP5i3Pd+o/63ypvQh2E9gqQcngzoEsR2pFWNW8NzuNcg/gRSpsD
         TWfwvoDWTaB2gMwXxvkIOxfEeGpiGLuY2SnjStr/4jpKhfpwOy4jhxKqK/wFwoA/y9uZ
         Xy7bjfxxdtb4pHSuDvQ3cCZyBnaw5HCxzpXuG5CPG7OR6hdbNMhqla35jzBOEELJQiMD
         CiMfLSx+hFAoNdOYthGUwSH5Hj6MnUBqU2Tq5GOwA0DPXgF3IVWOjFgVndjhFmwSlmJq
         Z7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794425063; x=1795029863;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S4+DQ/5hS2/5UfXO0mi1ZgFeMRsr05x8y1FYZlBsi/k=;
        b=U5duVUzuFYO391LeFXBn5ddzK6MxKug1lcaJIiJvlpaaFUzaOWbucl1yEt29a4q9hE
         4trdS7yomkxOQM9QGQElxYlKyJO0b8MGSVmweeS4bykqJfWtpZ/LJyTdRrqBtWkrPPvp
         dUYwqHTMKTEBWAT+Rn2fDsJX/ShNyFmmLhTqDgB5GuQMknuW511mqkwiUVDjjV+mObls
         u4UQfCAjsiamliM3up62eK1qBO2/g1VhSwSjzM5VKPbxB49INaSgh2gRXOjK65AbbYo1
         FJgJT5nye/EZHtM55jXLotk6f0oUHQJeHxTEdIkfnQDljlBBwrV/0HXspTkP9yEnOApY
         UhLw==
X-Forwarded-Encrypted: i=1; AL+hErEZ4tM1z4dKwiyUMJrywMADmK7fTNa9Xe5fXFmgYVI8lUCHeZIlterRFAV++jrqz7Aqx2GJSw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9tSgXnKYKvyW8CXxkX+YdLOiYBy3B7mkQH/h8MIUsyNnc60l3y
	G0WVYcn6+JKdZQBYKRPdKP5AZKtOuLV9P7OG8hnf6KFo8QEQgbdaZlc0t7CXpL315na3Liha9nP
	VcdkRcRcnh9Jm5w==
X-Received: from jabll4.prod.google.com ([2002:a05:6638:9804:b0:61f:e4cd:8716])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:318a:b0:4af:5d69:1cb4 with SMTP id 5614622812f47-56b96ad0615mr3028788b6e.15.1794425063307;
 Wed, 11 Nov 2026 11:24:23 -0800 (PST)
Date: Wed, 11 Nov 2026 19:24:10 +0000
In-Reply-To: <20261111192411.4133780-1-dmatlack@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261111192411.4133780-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111192411.4133780-7-dmatlack@google.com>
Subject: [RFC PATCH 6/7] vfio: selftests: Add vfio_pci_find_p2p_pair() helper
From: David Matlack <dmatlack@google.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Matt Evans <mattev@meta.com>, 
	Matt Evans <matt@ozlabs.org>, Mina Almasry <almasrymina@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add vfio_pci_find_p2p_pair() to locate an initiator device with memcpy
driver support and a distinct target device with a memory BAR of at
least min_bar_size bytes from an array of VFIO PCI devices.

Factor out vfio_pci_has_p2p_path() as the central place to validate PCI
topology and P2P DMA reachability between the two devices in the future.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../lib/include/libvfio/vfio_pci_device.h     |  8 ++++
 .../selftests/vfio/lib/vfio_pci_device.c      | 48 +++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index fd130f680a2d..9bda93712859 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -42,6 +42,12 @@ struct vfio_pci_device {
 	struct vfio_pci_driver driver;
 };
 
+struct vfio_pci_p2p_pair {
+	struct vfio_pci_device *initiator;
+	struct vfio_pci_device *target;
+	struct vfio_pci_mem_bar mem_bar;
+};
+
 #define dev_info(_dev, _fmt, ...) printf("%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
 #define dev_err(_dev, _fmt, ...) fprintf(stderr, "%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
 
@@ -171,6 +177,8 @@ static inline bool vfio_pci_device_match(struct vfio_pci_device *device,
 
 bool vfio_pci_find_mem_bar(struct vfio_pci_device *device, u64 min_size,
 			   struct vfio_pci_mem_bar *mem_bar);
+bool vfio_pci_find_p2p_pair(struct vfio_pci_device **devices, int nr_devices,
+			    u64 min_bar_size, struct vfio_pci_p2p_pair *pair);
 
 int __vfio_pci_dmabuf_create(struct vfio_pci_device *device, u32 region_index,
 			     u64 offset, u64 length, u32 open_flags);
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index eca6eb13d7f0..16fc98ed170b 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -378,6 +378,54 @@ bool vfio_pci_find_mem_bar(struct vfio_pci_device *device, u64 min_size,
 	return false;
 }
 
+static bool vfio_pci_has_p2p_path(struct vfio_pci_device *initiator,
+				  struct vfio_pci_device *target)
+{
+	/*
+	 * TODO: Check PCI topology / ACS / host bridge support to verify that
+	 * P2P DMA transactions from @initiator can reach @target.
+	 */
+	return initiator != target;
+}
+
+bool vfio_pci_find_p2p_pair(struct vfio_pci_device **devices, int nr_devices,
+			    u64 min_bar_size, struct vfio_pci_p2p_pair *pair)
+{
+	struct vfio_pci_mem_bar mem_bar;
+	int i, j;
+
+	for (i = 0; i < nr_devices; i++) {
+		struct vfio_pci_device *initiator = devices[i];
+		const struct vfio_pci_driver_ops *ops = initiator->driver.ops;
+
+		if (!ops || !ops->memcpy_start || !ops->memcpy_wait)
+			continue;
+
+		for (j = 0; j < nr_devices; j++) {
+			struct vfio_pci_device *target = devices[j];
+
+			if (i == j)
+				continue;
+
+			if (!vfio_pci_has_p2p_path(initiator, target))
+				continue;
+
+			if (!vfio_pci_find_mem_bar(target, min_bar_size,
+						   &mem_bar))
+				continue;
+
+			*pair = (struct vfio_pci_p2p_pair){
+				.initiator = initiator,
+				.target = target,
+				.mem_bar = mem_bar,
+			};
+			return true;
+		}
+	}
+
+	return false;
+}
+
 void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
 			    size_t config, size_t size, void *data)
 {
-- 
2.56.0.567.gdb80ae8cd5-goog

