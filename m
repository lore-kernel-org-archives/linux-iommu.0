Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793420732;
	b=Q9TZhilV36ACUhWCW3mkH8TqBnTClWwpnOl5KItEoeYFJ/wDfe8yLb5uYz39Yf2fOgtz
	 vjyMAgnsJwu7G3lj+z6hfU9jeMwnidsnUEIEY70b7yIkpWIo28KDY+/+I9EXrAGpvTFhW
	 sOH+H1vEP12d3Qk/zx+OAXv1VDYOEC3kcGODNX9P8JO1zuntZTgtNo1UqJPG8bMNi5ceM
	 EFS1m9aB9pvAYr031uZoavENP5HeDiGTZv+q9WrhqUcuGPRNl2UOLShRAAizdkd0wLaXV
	 XDDzirH+fAb8E8T8b6+eAeh5DJNo/2HsrAmhdcOxgG/MPkPzABSpPcPKlEolzWvdyIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793420732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HBqVKgD/J3O3UsdCswiaBpwuPrR9DAwLVOA8ARw7ulc=;
	b=DFCoxhLBkXJvDO/rZPr6dK6RTrSrRGmQNGXuJVJEd309Vuts3DPpC6F+oWyKGnrjFQ+1
	 YVteX/teHQjgtPmodnnO+AcsytmBRNSJjV6sfHmH7EGXPxN8B5FK9eCQqgMgTduTH7aiJ
	 2yPyoAJoDWRrA1ffB6TM8TZ8U8NKTcOFoNDD6JfIs357aEFT1dcMAV4G2hP14X+nnE85W
	 bTbHyd0WIAC1yzZ7bDTyhbw2/CcAgB+JnnT8bOzjghQvDPBV0XP9Rbcnim/kpstT09ncb
	 zHXcUwwpju8cSSGF+iNNM+VIzxrN3P1005y/70VTlVGfj/99PhuwnOntH7K8MYOKpYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=FRA7yMG0;
	arc=none smtp.remote-ip=209.85.167.182
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DC4606A321
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 04:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7DC4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=FRA7yMG0
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-53a448f86e0so908741b6e.1
        for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 21:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793420731; x=1794025531; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HBqVKgD/J3O3UsdCswiaBpwuPrR9DAwLVOA8ARw7ulc=;
        b=FRA7yMG0PyEpEVoR9K1qq7X5wodFl9yh1Jz/KYbOsS3oHmZsCj0JHuhXPxG0Y7rqTx
         D/kQK0Q/e5MGqBNAI5yec8eGUr16z1hkcYh3ema5KPkn55g4khM9xwTWTzWkEU5w9ADr
         x+kKyQkVXOFi6KdEzu2R1ZdR+m15PlHcXnPk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793420731; x=1794025531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HBqVKgD/J3O3UsdCswiaBpwuPrR9DAwLVOA8ARw7ulc=;
        b=gaUXiu1uV7x6gu0YFdKLI+GnboMZos5aHFodmEidIZp4ublju8rVRKY5A4ux7s9W0Z
         pmyDeFWs27qYA0WxcY9vybN/+6EX30GGstI4q6UpjMdooVJZ1UzYXozUNNqHo2++eNun
         Ukw/k/etoBoGQnFMpXZnwPgqJzRPR/6pT+C9AEYVBX402vCIONwzyu1Zmp6HxaN+l6co
         kWRRYFyqeGE3Xou263fQAme3aCxhiA7Ug1MDiGodPoBHOPVNLG1t+bzUXc01YWenfPq8
         yIQmMg14xgF83NaBkIkUZZChd7sS/sWX0r0VdAwY01zw+dSQLBwaGzUQi07ujTFsYwCt
         f2dA==
X-Gm-Message-State: AFq9FYIuk3k4OQdpz5++P3e+SlOK0hjWcCUkD2WL3jQki83sF41UcL4/
	kyMiYrDSSpZx5xIZ+/c0+kGJQDEINgscic0xS5PLVMyAPL6o6TIu7XTt9qem+xFCHeNwJWNMYXG
	6Asf5RTI=
X-Gm-Gg: AYBFou30lSUsd0QOkDROWs3W4iB3A33K+89C2NPwKqE7meQRJyxTPrA716z4ZPaf8gh
	p+qurbKH5317X4ycgIIVR0SwLxcBPiaeRNU1Fgj2UEyMSAoDHnY5X2spMHnEFCQ0uP7BpDa2v6X
	crLGu7gqoFfQ1SnRzjg1luSg8wTJBa9y0Ki9rKogvhnFBVX56okm+LfJ8N5JE/u3V3/7Fo4o6Ho
	u6Y91GwamtWajq2Gkuk/S/eH/N5CBiTfQY6/UVX+mvrDE21exwiUgqHknZARJpJUuLPXktWtE4x
	il1WfozVpSYpMr/LgLGBvSRiGM2qwl0jXX3wAvLQ8PGfY50DSYfEkj9At8YRV1cCgROxn/GYkP/
	J+D+QePIDu642R0Y2DWeHt1Os/9QV+EOHF63dxZW+5JpfbvDz3Pp/a4wP+58Er8P+f3zYkCckPp
	uUcKlpWUXjsLk7/kFt7IZmpfaa6Dog9OpLVJWP7Nbx6U2EXtuRj916p+8z0SRz9yi2+bnT83mlV
	YHA3WxyJgJP2IYtTBhLyj1qltmrDjobE096j6aAizcdyHOwaLxNGI0H32BiZzJaclAgD/HAOWoW
	ruo+elwo0WCOPwkCZ/c4nPb6DSnps54EIrQ5SaWAuL7zWdNOsjgGe7SUFDe7j/cMv6Rwa+M2zXp
	xfvN16HAV5CJm1VBjdiXsnVKaRDiMa5vWECoBxFav1HjtEdi3VIs=
X-Received: by 2002:a05:6808:16a7:b0:4b9:e88f:89dd with SMTP id 5614622812f47-5640de8da6emr3144357b6e.43.1793420730742;
        Fri, 30 Oct 2026 21:25:30 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd93451sm3000260b6e.3.2026.10.30.21.25.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 21:25:30 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	outbounddisclosures@openai.com
Subject: [PATCH 2/2] iommufd: Reject opens until module initialization succeeds
Date: Fri, 30 Oct 2026 21:25:27 -0700
Message-ID: <20261031042527.6418-2-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261031042527.6418-1-kylebot@openai.com>
References: <20261031042527.6418-1-kylebot@openai.com>
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
-- 
2.53.0

