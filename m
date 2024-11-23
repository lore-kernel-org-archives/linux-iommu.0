Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7B217C2
	for <iommu@lists.linux.dev>; Sat, 23 Nov 2024 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732391957; cv=none; b=G/BDVG/A1PAgaFyr+JW0Lh33j7d75hdU9c3KHXKYFcQWzEIzDhxccBg3cjrxeXptSB9/3n1mFXBWOZPlChsAeqFW0x52RmCPq8SltLj5w2fAUrXDxXzhOHUDSO1+bXGyHmCao4mvTeOvhzqt91J6bGCb9orlvXFVtSTbKBc5mZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732391957; c=relaxed/simple;
	bh=ppk6dUlKVq4vTfFNQ5pLZlqXaoNf/7pJprtxbyvpKfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z3Wsl/E5kjstEGi93zWLCw4pcIQuSEZnRA7H9Fn6s2utJJUgYJhNqxjVBJIINOMswOWL/FWIcZ9bmmf/sfy8MDtZGANaBRtU4jTahXVMVTowYrH3hjvX+46p874Layu+a1iw+/tbfjFGPQDev9FdaYQ7y4aaYibIMNPrWBU9xz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqEoQMt9; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqEoQMt9"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-724e1b08fc7so1635695b3a.0
        for <iommu@lists.linux.dev>; Sat, 23 Nov 2024 11:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732391956; x=1732996756; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iTd40TlAxinzrp4LL6DZMdpsXul9ShE3mjiH7jh5bSo=;
        b=iqEoQMt98AOFLplWWALDGl5A1Onx8/I/DWWyjxAQHQZYdzfO9HKtorPONUICJYZW8e
         XV+5dMisFk+yrwOsDukEoAcrDyYubKOTPg5ysfenzk4JPkky8E0mI8KT8hqoHEVM5WzC
         5Q6316PYVV8htqHkbMBFliBQvy+Gw+4QTvbYUdW5NubLjaw6YQm7NojvhYDTcRsAs4lD
         Sr1UrNEem5z4VCWEO4axRyqSIQ887BkT6odGXO+IAa0y4odANAtCP+t4Ui+9XIf8H6cV
         g7OSnprejOhukACJWwvyyXCTo/j2xjkDJITHMxJoU21jdsUi8qNdG8+tDB/j0aSUERwh
         yQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732391956; x=1732996756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iTd40TlAxinzrp4LL6DZMdpsXul9ShE3mjiH7jh5bSo=;
        b=s8Wbx8k1ffRXJxOCqvZ+OGGDY5fFW+PgnDGr0NycKymZWalVhCJTOlCopAVYetvU/m
         bg0DH1Cf2HG4tGwXwaBSoeS+T7E97Uz2C71IFHrmCIf5TkyxVKVRbMsFm6l3S65CH6hH
         kZ47ugSRn1eDGX98ouAE1w0o1QuZ1u0VpjC5MIF9oFKkw/XGnuiWMDsvXiSwJdlTZ+j0
         B49PtmLSyaPwY6BT2CK3Rk6x/V8FrKkg8rRdEhYw5Kc0svYvlKEGKo6QP2frndxULt43
         v9c/B4Xyg6VPZz/pQajYEiwseSmGRzMTuzNyfwTbbPNUgLfOXJ6xV8ExBo56xJGJCQVu
         TMKw==
X-Gm-Message-State: AOJu0YzWIsqy/Qdv84Hy8mXJWZIyhF0dkIaQv/MYUgszetgCcCqytKtR
	XGW1JAuUF8TFlW3gLXzhcr28kVgdx9JhdAXgHTtFw0KeuoU2bJyt
X-Gm-Gg: ASbGncu2bqfY35LzgVHBsRnflIqDij9tbpvhVodn1c9zQobVBqwZkfxRkvA6TcrX+NR
	/5V1hp3ur+DQWvl6xXXLpikiOvFJjt5WPxvi9ns62X80o/i+T8AhoM9q5DbSPZAexVWX9XTeI9m
	+6bYmXV1qtkGSopYH55fNxEHqVpb9is8IoLJ/M9ooR9qYBSK0Xn8ONNw6j3k1mWs65LDOvs43Zt
	kQ30e3LM3uOZD/eJPFHhP84gFynRyCPJBhS15j+fgYn+8INuMjSzQOM4OIB0K5UvGwAfFUxb3lC
	pTiPCBNDft1BAA==
X-Google-Smtp-Source: AGHT+IHmDjBvRFPJEqiINap153R0Kmft+Rw5KDn0MqKLa8tYfUTc2qMbUniCnDGG7L3zgGwso85yxg==
X-Received: by 2002:a17:903:1c6:b0:211:f52d:4e03 with SMTP id d9443c01a7336-2129f799e5bmr84412135ad.27.1732391955525;
        Sat, 23 Nov 2024 11:59:15 -0800 (PST)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:40c0:103e:6828:c968:a0b4:c749:4c7a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de454b5asm3738085b3a.27.2024.11.23.11.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 11:59:15 -0800 (PST)
From: Suraj Sonawane <surajsonawane0215@gmail.com>
To: jgg@ziepe.ca,
	kevin.tian@intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Suraj Sonawane <surajsonawane0215@gmail.com>,
	syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com
Subject: [PATCH] iommu: iommufd: fix WARNING in iommufd_device_unbind
Date: Sun, 24 Nov 2024 01:29:00 +0530
Message-Id: <20241123195900.3176-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an issue detected by syzbot:
WARNING in iommufd_device_unbind
iommufd: Time out waiting for iommufd object to become free

Resolve a warning in iommufd_device_unbind caused by a
timeout while waiting for the shortterm_users reference
count to reach zero. The existing 10-second timeout is
insufficient in some scenarios, resulting in failures
and the following warning:

WARNING in iommufd_device_unbind
iommufd: Time out waiting for iommufd object to become free

Increase the timeout in iommufd_object_dec_wait_shortterm
from 10 seconds to 12 seconds (msecs_to_jiffies(12000))
to allow sufficient time for the reference count to drop
to zero. This change prevents premature timeouts and reduces
the likelihood of warnings during iommufd_device_unbind.

The fix has been tested and validated by syzbot. This patch
closes the bug reported at the following syzkaller link.


Reported-by: syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com 
Closes: https://syzkaller.appspot.com/bug?extid=c92878e123785b1fa2db 
Tested-by: syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com 
Fixes: 6f9c4d8c468c ("iommufd: Do not UAF during iommufd_put_object") 
Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
---
 drivers/iommu/iommufd/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index d2683ad82..954c021e9 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -104,7 +104,7 @@ static int iommufd_object_dec_wait_shortterm(struct iommufd_ctx *ictx,
 	if (wait_event_timeout(ictx->destroy_wait,
 				refcount_read(&to_destroy->shortterm_users) ==
 					0,
-				msecs_to_jiffies(10000)))
+				msecs_to_jiffies(12000)))
 		return 0;
 
 	pr_crit("Time out waiting for iommufd object to become free\n");
-- 
2.34.1

