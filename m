Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69C0EA1
	for <iommu@lists.linux.dev>; Fri,  2 Jun 2023 02:37:04 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6af7d6f6f41so1371513a34.1
        for <iommu@lists.linux.dev>; Thu, 01 Jun 2023 19:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685673423; x=1688265423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LXwgrW6DKw2plF7VxCjq4/ru2uHcnK+tu+yh3zrOeTY=;
        b=in7WBOvbRFeLYhzoyEnjc0NmpLNR+pDdmIF2oyzzxAROmYEh9hICuInw4PktqlI26Y
         Z/+50dZzzn5lhLtq17q0A5DWwOU6igOEBL9Dxqd391FmHmE0j8YnNu9hLguP4gCxAUED
         kOYGC+/Qgk7ye8ZrqJ/Z7c13JPX7na+qcpRGuqV4cN3HTL16i2nSSae3Wx8ZaiXS0oPd
         cRNAE1u4R440+qR9bomPI9E4P7OjG4dZKM//RqzP8GFy36S97EoShjU4AKQBVwekAcqB
         GUB5xnOmdilndu0KxLMb7PN/t2tKEJWntI6Xr/2AMh3NVX4ckv7PjO1L1bvAyeLhuXxz
         CdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685673423; x=1688265423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LXwgrW6DKw2plF7VxCjq4/ru2uHcnK+tu+yh3zrOeTY=;
        b=fo18UqTzFjnQXeVP5R9RMXjQVtmD930WBaZC+zgx/nWmLX/ZzvOgE83O4+KpcDb5uw
         75raJZB6UCkq1d0Dgy//A58A3yiIBxsnkQZ/Ju96kvibR92YpteE+BVt0K93Pi/V7QbI
         nkhpgycuqI82lGKtoLMN/o8rKp5C4ve8RsWsAayJo5++XmYZ/JvYOA1V2XIY2ywVDXG0
         DNzHtf4/ZS7ehLjHYwP3clWZheLRE/JCXQA082Bd211S5v3BHQp4FkbcwPJ6GLw6MOQp
         JBpIDesLlnTE3QJJhbXoGGReAQCXpajXWWUcbZqy+NoyUGyB7Bletxry5u427PL56rOU
         IRJQ==
X-Gm-Message-State: AC+VfDxKBK/X0iTn+m+SBDoDOtAKCfcbu/cVYXgFjXJ+pKBjjX2kaHAi
	Pp+RdR10dDVpScAG2H/F/lY=
X-Google-Smtp-Source: ACHHUZ5e2xjY/pWlC1yCbF2hFFUb+JVjYiWUEKe+IX0ueBPZ1c+FbCebobeiNpKJi3bhpj0Mvc+SjQ==
X-Received: by 2002:a05:6358:2812:b0:123:52c7:d5b3 with SMTP id k18-20020a056358281200b0012352c7d5b3mr6762226rwb.12.1685673423334;
        Thu, 01 Jun 2023 19:37:03 -0700 (PDT)
Received: from Yee-680G4.lan (ec2-18-167-41-203.ap-east-1.compute.amazonaws.com. [18.167.41.203])
        by smtp.gmail.com with ESMTPSA id cl9-20020a17090af68900b0025643e5da99sm2046109pjb.37.2023.06.01.19.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 19:37:02 -0700 (PDT)
From: YeeLi <seven.yi.lee@gmail.com>
To: baolu.lu@linux.intel.com,
	dwmw2@infradead.org
Cc: joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev,
	YeeLi <seven.yi.lee@gmail.com>
Subject: [PATCH] iommu/vt-d: add tips on dmar_perf_latency
Date: Fri,  2 Jun 2023 10:36:39 +0800
Message-Id: <20230602023639.2606382-1-seven.yi.lee@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tips can make debugfs dmar_perf_latency user-friendly.

Signed-off-by: YeeLi <seven.yi.lee@gmail.com>
---
 drivers/iommu/intel/debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 1f925285104e..195416acd2f2 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -580,6 +580,9 @@ static int latency_show(struct seq_file *m, void *v)
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
 
+	seq_puts(m, "Write 1 IOTLB, 2 devTLB, 3 intr entry cache");
+	seq_puts(m, ", 4 prq handling, 0 disabled\n");
+
 	rcu_read_lock();
 	for_each_active_iommu(iommu, drhd)
 		latency_show_one(m, iommu, drhd);
-- 
2.25.1

