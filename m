Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16402F5F
	for <iommu@lists.linux.dev>; Sun, 13 Nov 2022 20:34:12 +0000 (UTC)
Message-ID: <20221113202428.889624434@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1668371650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=YkMxMrabi+IajYRzCsrYeAzbu1EBQ4csF5+thdpPrds=;
	b=J+Ul5JWG32rrZBX71vu9MQW8iyU1A+9SCAkWtCfTKSPGDf20HxCFoECki/Hm9zpGUPSeAl
	aWzlBFkExgBh0YDjCpeZuar9sv8A5WFHtF3M20ntvQiLAK95EOEnaVVsFSoGWrr/M1/jCf
	YHe2STvK/Zdp7N50j90T6ZP27LeT6pqQf6hLWZZlqdiWKhtzdAWx4HKVzL9Vpa2bjw6AjC
	p3FEYRTnCQfgH5g/qPWRbZQFIr0/1y1HxptJg5haYwY50HncHEzkp/A0/YrJo+RrgCRAQ+
	bnlnQ+ogZFRroPm6cldgVJk6qTNS0k43PhaowzDYCrBJsRrNjCdTpGY/XL5h9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1668371650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=YkMxMrabi+IajYRzCsrYeAzbu1EBQ4csF5+thdpPrds=;
	b=gqQvycs9a0Zvj99YpeGgt7McPtJu5+1PmYs4bkA2uiefsEw+F5gfGn1pjCAQfnDlWVkTJ9
	YdoYaXQasjSXncAw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev
Subject: [patch 10/10] iommu/of: Remove linux/msi.h include
References: <20221113201935.776707081@linutronix.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun, 13 Nov 2022 21:34:10 +0100 (CET)

Nothing in this file needs anything from linux/msi.h

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev
---
 drivers/iommu/of_iommu.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -9,7 +9,6 @@
 #include <linux/iommu.h>
 #include <linux/limits.h>
 #include <linux/module.h>
-#include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_iommu.h>
 #include <linux/of_pci.h>

