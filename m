Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334228;
	b=sA0aqjeIYhQu0NjYffLQAzzhlGcAv0z+i/yGHfSICX7KVHuOhIwFbAjVBo6yQkIFUqLb
	 UAwfXjlKb9r9FW8IKJkh9GG8wD8b6CIJNktflbWyIlltCxlW1d2g7ssJxr5OSwPYCoFfF
	 D7zDHHT562SEemk5g6BkmjULrG1bscgkHxbh/LaqDpxv4P94ysYCrZ7axiZnJleMKbZZl
	 /K8196pk9GjbEpYGZUW16YDJ2PrGHDod2Wu628hY5kNRskBR9Xz19054Smb3TnNbgKVd0
	 3VMK2MCSbpND75g6/yISLVWZWf9ik182Ec7LD7/7RCTGXvUw4oCJZUkxKdmuHV+9lfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=U33PwnQchcmiu/3DoDRSizdfuZPUsYa8ijDdkFvBI70=;
	b=QeE5O3/C04jcnOjw6uRosuaG4nLWc62Cdi3boG+Mm3MmCeOSLQG2WQTUX5gHrYqThC/P
	 aOQy4TEVC6bOs7+ZOm5Y/AKsTMxfabQlzMhtucOB2cVhJrKE6qdtJ7b6fREKRgfDtzU2E
	 ZYulVORpLRVT7MFXMhVwzMmDaOEtY0B49o+8b5u8hMzX1ctU/3E4QY/GIc7xXpXfQYY1R
	 O68URmeWaGb27tHXMvxX1w7LufFC1/WYAFvNJv01J6cC8iP2deMb9ZmefArNCYO9sDOUK
	 MntWQGpxzLFbK7FpESaqFp53Zr+qeEfUXu8QSnvgZ0ptSs4yCpU4Dx0mth9DDF+E7rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=ARpBkHPs;
	arc=none smtp.remote-ip=209.85.167.182
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899EE606A32E
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 04:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 899EE606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=ARpBkHPs
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-54cd7de2d42so213334b6e.0
        for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 21:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793334227; x=1793939027; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U33PwnQchcmiu/3DoDRSizdfuZPUsYa8ijDdkFvBI70=;
        b=ARpBkHPs8HD5YPxd8rtVE9Xohb3oHFVxCjMKoHtMqHurXGLrUYr0EbfWx39jYc6AkH
         YlGnI5d1EYjSqdI0Q/AGSIV6lq27V7+eXqriDVKUjzIqh29xd9aF1ick4ZYXxcLgNLjr
         Aw/UDXSk1r4BydUTr2MToCUg4v6DRXq/lvGhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334227; x=1793939027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U33PwnQchcmiu/3DoDRSizdfuZPUsYa8ijDdkFvBI70=;
        b=EiMEQ8BBcsIWme8mdx1otcpvzd5dDzgNp6C8Pw3AnX2SlB3icbeQT1uUA6jhfyOf0r
         ZjajLfwUjHSJRFE3Ye+/jhwl8TLBi9cgdxHERvWd3tkP/PbndUQq5fbrR2m3wD4Go3dF
         1YScKHw4rjd3PB+Fr5AM3zKrJKhY71pCb58lAjyJs/5OcS7xPY/MNUHUx2cQVTKaKcVB
         HsaXD4uytU2lLxcw5qMbpzgkWHp2WuLOb1YRIV4QcJTyi/Sxd8q4UxQn/UxBgnOWQp7E
         /hGHZi0STGRi6Jw9aVtonZvVCN7X6A7yQMVD5jV7UeO//VXfJgI9l/vXHg/U/MWOWORg
         BCSw==
X-Gm-Message-State: AFq9FYLb+DMRIIrA4nsvW04bo4xxadGJa0QcsaI025Efiq5Oe+bYJGZR
	f/DW5C+7c9o/8vv7hqvEgU6Bz+qZv9ipjFVumpMl1BrXzWlsx4NAREExnH41V79AsH86QSwFVmR
	4Azju3ng=
X-Gm-Gg: AYBFou04QCqVl0KrrXyWHp+3D8jEbgcfKkfZtu2Ux108nT93fsp4URjQ5cosd1A2ERv
	PcF2+WY+eWQ/lr63lZGX5mmnzJo2SXAXkKV6/4OlRTNjuMHYvcTegb8D4rToYyBMK54A5ETyAcd
	AMlD2XMbqTneAvVEJUix8VbLFiwqedRhI3tQm8ivhf+SkVLP4rxRy33cGHu1IU1NClrIrEEqJ/d
	sq4Vim0q11SBMN7qoLTmn6u6ag8R3fuSOa09PzVdwqZpZd1l+U8gu2gcbyyCCghxhUMngn8fg2Z
	Ve5WZJetnAVe5ix6VvcEpiPQZCbv47yD2GIXOvQyxMbVOuzmsl+/XnKNALkDPpoy5zcQvFqtCM+
	8uhPbq+dfz2Y2oipXmFV8BEfx6AyVr4YX7+lQ9yqF3IfYVC3wLJNe3cxL2jnbzbFEcEKxiQoWb8
	WOwCY1Xgphn09SVaj09P1R645EAOzQTsZ+4zIdWudQdbBGIiTHB0xr4fz1/W5K/bjKKy0Ezugr6
	RT+w54YQLhEFwgy7X/bfebQ/HKnezYd6sqr5bd6gteM3TTypdaHpqMBfmTlYL47MmqAFbkFAo38
	WgNvHTUHTyFdWbYgqY4FL8/yXa4jBegPznQoKa93LuywZfr8a4TmNklwqQX/iAXQop3psQnQybw
	nKKnm5dDZivbLFbnE58kpLsud/hTxyA==
X-Received: by 2002:a05:6808:c125:b0:4b9:a829:f015 with SMTP id 5614622812f47-5640de7bd0fmr906110b6e.33.1793334227478;
        Thu, 29 Oct 2026 21:23:47 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fe423fasm747960b6e.16.2026.10.29.21.23.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 21:23:47 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-kernel@vger.kernel.org,
	outbounddisclosures@openai.com
Subject: [PATCH] iommufd: Reject opens until module initialization succeeds
Date: Thu, 29 Oct 2026 21:23:45 -0700
Message-ID: <20261030042345.74537-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommufd_init() publishes /dev/iommu before registering the optional
/dev/vfio/vfio compatibility node and running the optional self-test
initialization. Either later operation can fail. Since file operations
can acquire a reference to a COMING module, an already-open file can
survive the failed initialization and refer to freed iommufd module
memory.

Gate the shared open callback until all fallible initialization has
completed. Publish the ready flag with release semantics and read it
with acquire semantics so successful opens see the initialized state.

An early rejected open also needs to drop its module-backed operations
table. misc_open() holds misc_mtx across the callback, so deregistration
waits for it, but the VFS's fops_put() on the failed open happens later.
Restore the inode's core character-device operations before returning
-ENODEV, avoiding that remaining reference to the failed module.

Fixes: 01f70cbb26ea ("iommufd: Allow iommufd to supply /dev/vfio/vfio")
Fixes: 23a1b46f15d5 ("iommufd/selftest: Make the mock iommu driver into a real driver")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
I have a reproducer for this issue and can share via DM

 drivers/iommu/iommufd/main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 9a921b153162..781a8d63dda9 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/smp.h>
 #include <uapi/linux/iommufd.h>
 
 #include "io_pagetable.h"
@@ -30,6 +31,7 @@ struct iommufd_object_ops {
 };
 static const struct iommufd_object_ops iommufd_object_ops[];
 static struct miscdevice vfio_misc_dev;
+static bool iommufd_ready;
 
 struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 					     size_t size,
@@ -316,6 +318,17 @@ static int iommufd_fops_open(struct inode *inode, struct file *filp)
 {
 	struct iommufd_ctx *ictx;
 
+	/* Pairs with the ready publication at the end of iommufd_init(). */
+	if (!smp_load_acquire(&iommufd_ready)) {
+		/*
+		 * misc_deregister() waits for this callback, but not the
+		 * VFS's fops_put() after a failed open. Restore the core
+		 * character-device operations before dropping misc_mtx.
+		 */
+		replace_fops(filp, fops_get(inode->i_fop));
+		return -ENODEV;
+	}
+
 	ictx = kzalloc_obj(*ictx, GFP_KERNEL_ACCOUNT);
 	if (!ictx)
 		return -ENOMEM;
@@ -799,6 +812,8 @@ static int __init iommufd_init(void)
 	ret = iommufd_test_init();
 	if (ret)
 		goto err_vfio_misc;
+	/* Pairs with iommufd_fops_open(); no fallible setup may follow. */
+	smp_store_release(&iommufd_ready, true);
 	return 0;
 
 err_vfio_misc:

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.56.0
