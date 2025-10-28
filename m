Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C815E285CBC
	for <iommu@lists.linux.dev>; Tue, 28 Oct 2025 06:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761633378; cv=none; b=nWtLWLqozV+icG3yQ0Htwpu/ckZ8HYbHj6k8QcMbV0SKwyCOoXkXCDVp37S6LB0cjrcFFajhSwkTOdBKaIdzfqbWcQvhcZWD7DmwGLPsYzhkQZ9g5+MBa/FCnk3oC6BbGQ89DbyDmJgRannBtKje0OdhiD+umgAOGUbDGBSPtlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761633378; c=relaxed/simple;
	bh=fIpLWlJZgNMVBNwv1Qi28QT9txbaMkE9WZofpeGLL44=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P8NJvGJbtsgm9zH8041o6oBukKre+hYVmjktgzVIH5xLcv6iNvmg3JyjN2W0ykgs8llHvtFgkYw7DFJ0IILA2DW4bEf+DYnB2ls2kqVs70Rb8lMznTBGD0+pa15rkB0se7spzl9muj2zRJyrZwts6oe8g+DRSFuKkvPapaHTDyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxGlQOJj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxGlQOJj"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-290ab379d48so51839845ad.2
        for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 23:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761633376; x=1762238176; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eHCzvaSzIfjxLqqlWg+9YqHl2rYFybHFRYREuApfQng=;
        b=bxGlQOJjiu2pqOfSctQfEX4MRJxTjWJTTygehWjppVHwyuNAjl/aa2R0e93im713E1
         sO5XkBvXeRwiJlGvWl/1mZPAqpReGeBQeQbjfKms/Mel2579CjR4ku0Nj5zzfEQvFcfv
         uU9XqbsOEptHlAjC9v9j96HUu5qngtHjqanwFNxrW+MeE1JBF3qd+iZ8C9y9uNC+LD5X
         SslFEMUQupjhxo0FDohczivb54g4rRBQr2zBXKIouUFjiZxrTwAqRWc0ufnoD/UEZTsS
         C8oXvjOxEHp7fK803rdQ/dTzQk2lTXUswsILWXk7DgQPnoYmRTXg5Xon3mhHAtBDdEDT
         Na1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761633376; x=1762238176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eHCzvaSzIfjxLqqlWg+9YqHl2rYFybHFRYREuApfQng=;
        b=PZrhvNK3YkOn9yklJa36IIaahn0CRbvK9Hhk2q2DdxOf8y+0kxiiXb71nM5mcGQ5EY
         gHwQTyy64rYzwaLH5VTv09S0xf7uGaq5HypIV+N9KbwFSsP3Y7wIUmrVtPHdb9cER2Ru
         7FUioshS+WGk6saW9qz/boqPVmmcPbHgBESAuNc/0eATLHKnqXvvWwEPRy1DcU9bNd+z
         C+m7aPZ1nzVI7evcBFtJVPm4KS22CQDBCD3ypZgK1O2YxnXTD88aL23xkedEWWXMaqHx
         wsmIrWLZRKIz8yRmaHCztbvcGIIu6TytMDGCb428aOgcY0HIob/EGt7ACvWUGJvE4i1W
         5z1g==
X-Forwarded-Encrypted: i=1; AJvYcCVBoO13jxwDigjUpGZbF79EpuzNcyRrszhJ0QUTojvgx6qqhFzy9X01kJ/oC61/PzM0HnTKiQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywecvmp6rt+adkbEfFOQTtIu3FaGc5ThtPUI859pM9jkQmQF9Sj
	bCka9jm4m/5OXyTbrrjUnwI2Ur3oTclkim06g3U0B6wXMWaBC+ozdppG
X-Gm-Gg: ASbGncv6OL6kETqdaIW7UhAGIQ1zeIN4ieZfc2ONOfLRKjBMmCAg3lZaNPacXfLLdZN
	Nl+6rW+Qmb+ctbcD02yTD9rtEuPsnnRnYO2RChQC3W8BZDWgj/+MUHrEBQuclC5a3VXeRPHC1z7
	gZPJSYTYuwHsDm8b5vRTpq6jLQtt6lxZeEQ4+FFlf75rLICeLoehbWZte+HN3eKC0EiWbAwk9mT
	ts3WjwV3Hy+REtYJdiqJJuVOy/q+PfH94revMs1zJnnpDeuMbTDSBq3iX2Un/QOH+RcWY4DLULS
	30g9D2cTIEUO0gyWZvFI0MW/RihYAHsVOp0lxG6xBQP+D9pSjFJK+JQch/qoXSKmR38SpDXmOjT
	FzO7UseaaOKUWXlTx2g8vZXVloHOExwzRexuWWSuASYTAripWxFA2qKfFl3jXAXGJwbKOR0ZpJD
	EKE18EuBN5FnGVHlOkJqreOQ==
X-Google-Smtp-Source: AGHT+IH2v3C/umCB14OlrxNqF3tzlUkDCN89YW3HVw9JkHJXqPm2mOQ48IiDSJJGHTDX9O7MPiIkwg==
X-Received: by 2002:a17:903:b50:b0:264:a34c:c6d with SMTP id d9443c01a7336-294cb3ecbc3mr28327115ad.37.1761633375933;
        Mon, 27 Oct 2025 23:36:15 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498cf4a53sm105914585ad.6.2025.10.27.23.36.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 23:36:15 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Thierry Reding <treding@nvidia.com>,
	Rob Herring <robh@kernel.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] iommu/of: Fix device node reference leak in of_iommu_get_resv_regions
Date: Tue, 28 Oct 2025 14:36:01 +0800
Message-Id: <20251028063601.71934-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In of_iommu_get_resv_regions(), of_find_node_by_phandle() returns a device
node with its reference count incremented. The caller is responsible for
releasing this reference when the node is no longer needed.

Add a call to of_node_put() to release the reference after the usage.

Found via static analysis.

Fixes: a5bf3cfce8cb ("iommu: Implement of_iommu_get_resv_regions()")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/iommu/of_iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 6b989a62def2..02448da8ff90 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -256,6 +256,7 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 				maps = of_translate_dma_region(np, maps, &iova, &length);
 				if (length == 0) {
 					dev_warn(dev, "Cannot reserve IOVA region of 0 size\n");
+					of_node_put(np);
 					continue;
 				}
 				type = iommu_resv_region_get_type(dev, &phys, iova, length);
@@ -265,6 +266,7 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 				if (region)
 					list_add_tail(&region->list, list);
 			}
+			of_node_put(np);
 		}
 	}
 #endif
-- 
2.39.5 (Apple Git-154)

