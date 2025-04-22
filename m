Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB0323A995;
	Tue, 22 Apr 2025 07:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745306768; cv=none; b=uXyvlg2Mjvx7MvH8EVx3ffmlyEWb7eoD/7X/bS9SRAgda9jqLGhMfW8D6e3wOuuwEWgXXt6G8cXyDRjKzla/vrqnfwtfuq64M+lEtaPbwF3Axtpm09z94DQJ7/95WxPD0FNVq57Fujc88dEFT4fP/0TlwQMjBqgVO6KZcyFYwqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745306768; c=relaxed/simple;
	bh=mjbINT0KsAFvhuiRigryB3e0nhTCEbBFT15MJOvL+/c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MigzSf7ufl3++MC9Tz/0xklJVw7g5IfxfP+rcALk6syrdJk6A3KZjXL+A5OQgCoFPwEtam2DQxX6waKUqetKXS4jISXrXW3obhknQ0sKD/08S3wTmi2u1l9Xovknscb3MvJ0YrrjNUq13IbDWuhZBcWH84A4XMwpsqrHE7RUj5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowADXezh6RAdoZOAVCw--.18178S2;
	Tue, 22 Apr 2025 15:25:47 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: sven@svenpeter.dev,
	j@jannau.net,
	alyssa@rosenzweig.io,
	neal@gompa.dev,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] iommu: apple-dart: Remove unnecessary NULL check before free_io_pgtable_ops()
Date: Tue, 22 Apr 2025 15:25:11 +0800
Message-Id: <20250422072511.1334243-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADXezh6RAdoZOAVCw--.18178S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw18ZF4DKw1xZry7ZrWfAFb_yoW3WwcEkr
	18CFn3G3Wjyrs8Aw1jyF13Zryv9as8Zws2qa4DK343Jr95Zw18C3s5ZrWxZrs7J3yUCF17
	Aas8Ar1fCrWfZjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbf8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1eWlPUUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

free_io_pgtable_ops() checks for NULL pointers internally.
Remove unneeded NULL check here.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/iommu/apple-dart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index e13501541fdd..757d24f67ad4 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -776,8 +776,7 @@ static void apple_dart_domain_free(struct iommu_domain *domain)
 {
 	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
 
-	if (dart_domain->pgtbl_ops)
-		free_io_pgtable_ops(dart_domain->pgtbl_ops);
+	free_io_pgtable_ops(dart_domain->pgtbl_ops);
 
 	kfree(dart_domain);
 }
-- 
2.25.1

