Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D5D200113
	for <iommu@lists.linux.dev>; Mon,  4 Aug 2025 10:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754302192; cv=none; b=PwD/Qc2fOH3mfYfkTit8l3mqVSFvi5gm1HOD/HuqtYnVjNxRqCqWE6rRpsahek9QB9IttnhUIfJrvEPmQdBrEqZh0NH1MWO0OGrSsqay3bIceSjf6tTn0TGqs4Q+ctrpIPLIYAAlt1n+zUWuM04JVltNYlK2MWTYbKWfrpoNww8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754302192; c=relaxed/simple;
	bh=4GCPXyKgWGKqlKeh0U9YoeBD18Ih6Bw7wyMasOok6Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E84070QeqkWlqOIbHo1MO+wehb6u70i+QhHAjFyT9XELklLSo1DMty6swSwNlIf+D3Ia/H6cFzcyt0gsfdjPtM7dsiHYTB6HSlKL0KNkGdQ2MnCoPYQh5OdIlN5Cz2qGNju6tIrVvLxegBIjVdEZU5IJ+8otU3CTG1Eu3Wr1ZaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISyfruDZ; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISyfruDZ"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-23dc5bcf49eso63379435ad.2
        for <iommu@lists.linux.dev>; Mon, 04 Aug 2025 03:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754302190; x=1754906990; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/xZ2clLQ8Tor/ZPaoA5UoS3xbLGZ0fiRCjTctgQgOgM=;
        b=ISyfruDZQW543E0UtmhAQeLzE3WNHRK8AS07I+xk0CcyDwtLeGbJ1BRJzcOR2yyL2o
         QyDZUgPqsKqDA/sUXmXI+nsZLt4Tj0T/zq1x9SLqOZ+ADb5kT24XmQl0b6WiE//VLnH3
         H03mmK9ZqWkhHZE4B4cO/yuwqE+atOQuMoKehlbC3Y3ZoLiig29lfUL/U9NhNq8xCWFQ
         B+3wQkny6pRnIWbeJPNeDXqBFH0TzemuzVqE1bhfp4xBc0ykSZEIKhi9XjVRYe7Vhyez
         W3bNka9katfGpaRa2jeHpTrnP6dPk0ZwcOQjfZw0znl9OFqPQ7LsuWa9JoUybduFVDGe
         gKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754302190; x=1754906990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/xZ2clLQ8Tor/ZPaoA5UoS3xbLGZ0fiRCjTctgQgOgM=;
        b=oviIabo3s27zBQM5jmxUPIGBUwmKnipEMg+fyrqvuAZ58kTevglomY8nYikvMN5gDT
         Uz9oYp6TB+hDFM6bI2aBdKKX+re4Zpn8IPKQo6EWbQsQw822pYgYQiZ/L+aSCGEeflKg
         N9pspinK2sMfGb6YZtbKYKryDoE9+9D+KVlSW9Ap35ozkHBrUzINU55Xs4X7ajMcyffb
         iCJGOpLXRCmZQ7a0S7fsi4r4it2gFHL/6LxwnqgqS+pGjpsqXf7rDFYgqA+ph7cxnzlx
         RLMA51dDF7E0m84q9q2IaDn+Yb86wubz4jZy7VpOVqCHqgCccU/ZfNEUROhcB0HHSDAw
         ZAyA==
X-Gm-Message-State: AOJu0YyS7wfk6L9SwjPuiDvlH+kI6QRoXVJw+HOelIXv9iV8lq7a9vr0
	kFFPaCQjOo7sDPuwcxOtlslfVMkyVVh1eLfPTrqUyz/o6Xkonw3TIzRk
X-Gm-Gg: ASbGncvL0auFpUVAcjY5L3Jdfz4SOMKHBNXoDba1cvobPOCwHmwL/VbWBZho1OvFoJs
	lusD+CmeEL9P3zbJzQV+5mFs8fIcGxfWm1B26veuqZQTGTOhhCHtyBF/mMfptHfpylUc+hTCnmt
	SPFqi+6bmk6axtNCAUtM759rBs+98oE+s/oEyTTu6O1kROGbWEtUQse4nKN/VnH5XBG8l2FN3Qd
	dAYhl3RvQOf2UirveboXwtM/uui+Hep/1s6ToeUVsJTx52yKefZa2x6pc+94jMFT+xG7SJgFxP0
	voqoQ6D4PecvrYvlxWksNihW0TL/g98LagJJmT+Vk6te85s9G0ilRYj8IUvEqhVMZ7h6vkDtVZ5
	tRcwbCYDNXRiNKzgosC/1Kl5CRhtY6DE0/ZJ7Lc3HXVLHnpY=
X-Google-Smtp-Source: AGHT+IHdBPumQdYcxqHQH04YWHhRpWXYejBExyx8Eh3pYaqbyiCkO79DoykqJwfFediJmttWvSEw1w==
X-Received: by 2002:a17:903:181:b0:235:ed01:18cd with SMTP id d9443c01a7336-24247042660mr118274545ad.44.1754302189649;
        Mon, 04 Aug 2025 03:09:49 -0700 (PDT)
Received: from DESKTOP-F9EGSNU.localdomain ([58.250.172.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0fb4asm105113325ad.60.2025.08.04.03.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 03:09:49 -0700 (PDT)
From: Richard Gemego <richardgemego@gmail.com>
To: nicolinc@nvidia.com,
	baolu.lu@linux.intel.com,
	kevin.tian@intel.com,
	jgg@ziepe.ca
Cc: iommu@lists.linux.dev,
	Richard Gemego <richardgemego@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH] iommufd: fix returns ENOENT in iommufd_viommu_get_vdev_id()
Date: Mon,  4 Aug 2025 18:08:59 +0800
Message-ID: <20250804100859.3462571-1-richardgemego@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In iommufd_viommu_get_vdev_id(), if viommu does not have any vdevs, fix
this func to return 0 instead of ENOENT.

Fixes: ea94b211c548 ("iommufd/viommu: Add iommufd_viommu_get_vdev_id helper")
Signed-off-by: Richard Gemego <richardgemego@gmail.com>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
---
 drivers/iommu/iommufd/driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 922cd1fe7ec2..ad635af8555b 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -68,6 +68,7 @@ int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
 			break;
 		}
 	}
+	if (!index) 
+		rc = 0;
 	xa_unlock(&viommu->vdevs);
 	return rc;
 }
-- 
2.43.0

