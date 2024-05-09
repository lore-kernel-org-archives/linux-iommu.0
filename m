Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E132199A1
	for <iommu@lists.linux.dev>; Thu,  9 May 2024 00:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715215358; cv=none; b=WYScoZ4l87vc6OaWaFUZzDNddA8Yzsnh+vdQ6Sj98PGZHO3psTqOhEQFeQsCdsVe7QBrK2yySvDji4Q6V/wL0atsXo9ZxnU51YblGJVdXqU6Ird8x7Dln16Zw6gM5u6fX9dFQVa5FXa7ACTmhQjphA2oNuMxOxma9SQlrWVh9YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715215358; c=relaxed/simple;
	bh=TPb2KrzVa/M4U4qQEv+XPFeb6ImczDK45yEo2LsRBEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZmKVJd1NiPk2u7M0396afJKp6wmQ3PsjL6K1KfBDTzhbYmE3SVq/49Dhq1qALohhE6wb4kx53WkfgUwrXoZJ7lIz/m6+CyJXOZ0jWfDXvy5lkozuvd9AjeHwih+u5aYZ5qARCIGQ/AMJLoQQflOpa/mx4OW9oJRkzRFMHiWzPgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mvCEtvgR; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mvCEtvgR"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715215354; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wVO/HJhR3CVVe/+QfkVvjqCqjwnhqXmuIyFXGYZw6CA=;
	b=mvCEtvgRQFCYAFTlLsMpzG2KXYC018f6LqBVLy11mQ0Hc35Y8Vl0mm3L7L1YI3hmxW3sLOGeZXTGApcEW3H0UPNlpTj9tbiLJ7yNJKNKybid5JeohSs2qBaUaAjAERFaCtH++8lSxznzYKXzfsvMdrmsy1pzEfoqJxC+POa7kmk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=llfl@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W64weoP_1715215351;
Received: from localhost(mailfrom:llfl@linux.alibaba.com fp:SMTPD_---0W64weoP_1715215351)
          by smtp.aliyun-inc.com;
          Thu, 09 May 2024 08:42:32 +0800
From: "Kun(llfl)" <llfl@linux.alibaba.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] iommu/amd: Fix sysfs leak in iommu init
Date: Thu,  9 May 2024 08:42:20 +0800
Message-ID: <c8e0d11c6ab1ee48299c288009cf9c5dae07b42d.1715215003.git.llfl@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During the iommu initialization, iommu_init_pci() adds sysfs nodes.
However, these nodes aren't remove in free_iommu_resources() subsequently.

Fixes: 39ab9555c241 ("iommu: Add sysfs bindings for struct iommu_device")
Signed-off-by: Kun(llfl) <llfl@linux.alibaba.com>
---
 drivers/iommu/amd/init.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index ac6754a85f35..82a54898194a 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1678,8 +1678,17 @@ static void __init free_pci_segments(void)
 	}
 }
 
+static void __init free_sysfs(struct amd_iommu *iommu)
+{
+	if (iommu->iommu.dev) {
+		iommu_device_unregister(&iommu->iommu);
+		iommu_device_sysfs_remove(&iommu->iommu);
+	}
+}
+
 static void __init free_iommu_one(struct amd_iommu *iommu)
 {
+	free_sysfs(iommu);
 	free_cwwb_sem(iommu);
 	free_command_buffer(iommu);
 	free_event_buffer(iommu);
-- 
2.43.0

