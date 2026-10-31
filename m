Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793420731;
	b=CtWwwckTwH92ODnJBrZaI5GxMMw/rGx0dGxlbAMGeZpeJodb1+ofenzWKOud51/Ypg2X
	 l2wBna/WdhEHMx3E6f/7zEUN0iXY3p6/AJlmRpQAathdFT3uixpFMW6ngBBesUwMFKF+9
	 CmcQoMXo9UOV1HPntGI0x6/fZEgfoHtfjcXC/voWXphCRGWlUcFFhja9qqp5Wk7/XSljO
	 +ZJus4v79Kiurh911dPgav0BfvdJcSpVHOu7lQN0/C9a737m4fFle5/r+zc34915s2Q3J
	 kJNBD+xlERtL93SBZMcg2K0gcj0BGawbTAYTunTrRLZCa181EdplyZs3CfhTkJNWT5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793420731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Ytn1aoCXRBTnTF0UFBaz0xL8UpYoU0vm5ll32XMj224=;
	b=q6Q1meZttCubrr3xZ2T18mTcSEd+Z8RcadOo1yMlITT2dVhriRNj86HPPIuAZOW3hmPO
	 sKYDXBtJhEPpSel0iXg/x7YiD/YSGMYtuLqrWHuboPc9piezweaoum9E40LmXi1jCzhvQ
	 n1F2D7p6n482+YVOWqnqnqUWoGNFyrcqbM91PU8w2LP9drNJ6nYk8oewNdYiZBfsyQiSS
	 q6Sk+ILqyTGkWP6Pq6yb+H8xeX1GP1cYACcI/3AFgTIDIwHw5g9Y3YhV1O3+F8MOGm1sJ
	 00/L1lquh21q/ey93iZQzlRoOItZ5D21v0iHC1YkrOj2JgV9uSvzoHg62auDS32sR7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=OVf5jgUb;
	arc=none smtp.remote-ip=209.85.167.180
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C17606A31C
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 04:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6C17606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=OVf5jgUb
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4f48d91ba7dso871844b6e.2
        for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 21:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793420730; x=1794025530; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ytn1aoCXRBTnTF0UFBaz0xL8UpYoU0vm5ll32XMj224=;
        b=OVf5jgUbqMwchrENBTrnjuGLQktasbslVNWDRXLAXxeH9O8UEoXlOnzMUjYqGkcKJy
         UFvI/cd91zXD0orANeYlL5BPmw7w4hpkjbTOzFNF1tWHaVSqqsxfEG7ePT6Skwnw66Ai
         kGE0efUq6V1OwnOudQ5bK/U1jqNp6gYsB8HwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793420730; x=1794025530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ytn1aoCXRBTnTF0UFBaz0xL8UpYoU0vm5ll32XMj224=;
        b=IS/Tx5id4aWXmi/N1L421JG39WluBKmO+Bj9AnODUmaqz7fg8zXCZ9JplnMZsKaGDW
         /xcNHuMZ6/9fR+JGR05IU6jC3nWmlL8BqbZHaXlwZxuf+PnR56b7Vm/M3ukptjw+dsw8
         M/uk3U5V5Gc2kImPP5bc3a00Hhe8JsWext2fB2RBhEXlr2jvhQfWYAGqPcynZuzUr50e
         UdVB6W469IB+oFNGa022bNCKvt4YGirjLqRAe97NHHj1KNug0VPeEpNM1HuSJm2q+e+3
         hdpppkqKQZA/mr1d27HVddYtLwXOdcc7usX89CMskq3JRzyJ9r0Dz/qK1oiVyIagcWkz
         X0zw==
X-Gm-Message-State: AFq9FYJ/h0urtjWORkXvteUm7UuOrKSTEcB1ayGtpV3uYikrTypcxcb0
	Fi+CmY0Qmu+5dbVKVEqPRZ99azjcI6LBc8mviPYHcOhn1LpG7i3cpSW6JUWuzZR4rYwzJG/JTX1
	zNEyqgIs=
X-Gm-Gg: AYBFou266keDHCoyykvfbtlpO9xKdI6rvUWJbhPScUHQ+bj6z+QihVyZ6wzpRdSDX5d
	5+XYMl5k++3aCES7gCIHpqFOyCvcqj/U28+kVq0lqvdsdC2QLiUDc2XRA80Gif/848uFD/Ufa9T
	OYLmVA7xL8G3qHHXg/0Fah9qsUGXfovOCsn1YUNKU53O4RKEnWiVlgeeSOyy33NflcGdMiwWc1T
	aj4ppKBBAPaJAT3NhTgc4FHBMXAvYvNcmK6/4EOuvP7LMFzMEigwjYKAFQwcham1p8Ze6PUR6sw
	u/fzvDw3RPAl7yGzkGxEvlRLjjQmb7QjIXTp4BqdgxhPLYMufzv2p8X4BFL6c6imqOc8bbgeuL/
	9zkjJoAFe4WtMF61wHCB+vkgM02NtVh8T3E5wpP6KVQfB27yZy9yqNCpKFYj9wK/PykyTzmqzrr
	UlbXxwBpoY9RI23MFFZai7HozbLFllXeUEnO7aNQiyx93cjpzotWyTPc6wBDL++j/hN5kujuIgb
	DgSsJ5wviDx3zjvXpk2FimjMOveTWKums4jy8I9CrX8LnJ02PLXv0Yh4i+PLAoBI3mZjs5DzPy6
	aQMXnyBQ0tk0Ftoonr2TpQhALwWI1JTTD9MmMxfAjKK8eNFSomlfQvfSJfpM9Hm2CGpploSMhT1
	v1GGwV/oaXw9bRIrYJWp2VtUIMx8+uA==
X-Received: by 2002:a05:6808:c3d5:b0:53d:c86f:d332 with SMTP id 5614622812f47-5640ddf9e52mr3176595b6e.22.1793420729703;
        Fri, 30 Oct 2026 21:25:29 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd93451sm3000260b6e.3.2026.10.30.21.25.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 21:25:29 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	outbounddisclosures@openai.com
Subject: [PATCH 1/2] vfio: Publish the container after all fallible initialization
Date: Fri, 30 Oct 2026 21:25:26 -0700
Message-ID: <20261031042527.6418-1-kylebot@openai.com>
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

vfio_group_init() publishes /dev/vfio/vfio before vfio_init() has
finished. The optional no-IOMMU backend is also registered after the
misc device. A concurrent open can therefore obtain a container while
the module is still COMING, even if a later initialization step fails.

The failed-module-init path frees the module without waiting for these
open files. misc_deregister() prevents new opens, but does not revoke
existing files, leaving their vfio_fops and callbacks in freed module
memory. An unprivileged first-autoload race can trigger this by exhausting
the global task limit before the IRQFD workqueue creates its rescuer.
A subsequent VFIO_GET_API_VERSION ioctl reports:

  BUG: KASAN: vmalloc-out-of-bounds in __se_sys_ioctl+0xaf/0x120
  Read of size 8 at addr ffffffffc089df70 by task vfio_race/1484

Move container initialization out of vfio_group_init() and make it the
last fallible step in vfio_init(). Register the no-IOMMU backend before
the misc device, and unwind both resources in reverse order. Once an
open can reach vfio_fops, module initialization can no longer fail.

Fixes: cba3345cc494 ("vfio: VFIO core")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 drivers/vfio/container.c | 22 +++++++++++++---------
 drivers/vfio/group.c     |  9 +--------
 drivers/vfio/vfio_main.c |  8 ++++++++
 3 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/vfio/container.c b/drivers/vfio/container.c
index 003281dbf8bc..bd245e23a55d 100644
--- a/drivers/vfio/container.c
+++ b/drivers/vfio/container.c
@@ -577,29 +577,33 @@ int __init vfio_container_init(void)
 	mutex_init(&vfio.iommu_drivers_lock);
 	INIT_LIST_HEAD(&vfio.iommu_drivers_list);
 
+	if (IS_ENABLED(CONFIG_VFIO_NOIOMMU)) {
+		ret = vfio_register_iommu_driver(&vfio_noiommu_ops);
+		if (ret)
+			goto err_mutex;
+	}
+
 	ret = misc_register(&vfio_dev);
 	if (ret) {
 		pr_err("vfio: misc device register failed\n");
-		return ret;
+		goto err_noiommu;
 	}
 
-	if (IS_ENABLED(CONFIG_VFIO_NOIOMMU)) {
-		ret = vfio_register_iommu_driver(&vfio_noiommu_ops);
-		if (ret)
-			goto err_misc;
-	}
 	return 0;
 
-err_misc:
-	misc_deregister(&vfio_dev);
+err_noiommu:
+	if (IS_ENABLED(CONFIG_VFIO_NOIOMMU))
+		vfio_unregister_iommu_driver(&vfio_noiommu_ops);
+err_mutex:
+	mutex_destroy(&vfio.iommu_drivers_lock);
 	return ret;
 }
 
 void vfio_container_cleanup(void)
 {
+	misc_deregister(&vfio_dev);
 	if (IS_ENABLED(CONFIG_VFIO_NOIOMMU))
 		vfio_unregister_iommu_driver(&vfio_noiommu_ops);
-	misc_deregister(&vfio_dev);
 	mutex_destroy(&vfio.iommu_drivers_lock);
 }
 
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index b2299e5bc6df..dc8f8a38723f 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -898,14 +898,10 @@ int __init vfio_group_init(void)
 	mutex_init(&vfio.group_lock);
 	INIT_LIST_HEAD(&vfio.group_list);
 
-	ret = vfio_container_init();
-	if (ret)
-		return ret;
-
 	/* /dev/vfio/$GROUP */
 	ret = class_register(&vfio_class);
 	if (ret)
-		goto err_group_class;
+		return ret;
 
 	ret = alloc_chrdev_region(&vfio.group_devt, 0, MINORMASK + 1, "vfio");
 	if (ret)
@@ -914,8 +910,6 @@ int __init vfio_group_init(void)
 
 err_alloc_chrdev:
 	class_unregister(&vfio_class);
-err_group_class:
-	vfio_container_cleanup();
 	return ret;
 }
 
@@ -925,5 +919,4 @@ void vfio_group_cleanup(void)
 	ida_destroy(&vfio.group_ida);
 	unregister_chrdev_region(vfio.group_devt, MINORMASK + 1);
 	class_unregister(&vfio_class);
-	vfio_container_cleanup();
 }
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 423ead48aafe..dfc48a9e0fe6 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1852,10 +1852,17 @@ static int __init vfio_init(void)
 	if (ret)
 		goto err_alloc_dev_chrdev;
 
+	/* Publish /dev/vfio/vfio only after all other fallible setup. */
+	ret = vfio_container_init();
+	if (ret)
+		goto err_container;
+
 	vfio_debugfs_create_root();
 	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
 	return 0;
 
+err_container:
+	vfio_cdev_cleanup();
 err_alloc_dev_chrdev:
 	class_unregister(&vfio_device_class);
 err_dev_class:
@@ -1868,6 +1875,7 @@ static int __init vfio_init(void)
 static void __exit vfio_cleanup(void)
 {
 	vfio_debugfs_remove_root();
+	vfio_container_cleanup();
 	ida_destroy(&vfio.device_ida);
 	vfio_cdev_cleanup();
 	class_unregister(&vfio_device_class);

base-commit: 70dd4ee72eb2d5793c62e71c14e3aba78e5a4e56
-- 
2.53.0


