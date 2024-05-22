Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099F67FBC8
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 08:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716366458; cv=none; b=sPzOESR/Vjk6ViykEJGMhJYourTAi9HRp45RiwJTs6DKSEesF7zAjHAqKOXOpYWRBcVH/nvLzWY993AAP/HCp3GbhcRO7pGSJ7qtsOBwPQGO3whXNYGbfGUywHAzJns3XvRy2vN0TkCI5pAm4NmmmKmNxgvlIbs4cjwZXLuykkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716366458; c=relaxed/simple;
	bh=y3VxHR/Yb4X/Ib/4X02OEJsh/+G/11i5weZ0MaiR8kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3/qstYcXEJBp7VhHTaPqMVMQzGzyJaoJHByGTiewON4yW0EwSExGuK/HMvb/4vRAo/4e7mKP1lFfHVfhz12LO9aknVLID44UQ2AjjlPz7LWcjV2M9gwjqU9nKV/rPNIV4fBExAxBF+HgSXA8HwjgUl1cfAw84EKj02lNwKD+/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUl2tMDL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUl2tMDL"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4202959b060so39065575e9.2
        for <iommu@lists.linux.dev>; Wed, 22 May 2024 01:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716366454; x=1716971254; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yc4M1An1SVE3VhBwugQSFEPj2HdsFrg3eqR9/azRDhc=;
        b=IUl2tMDLCnKl0yxDm1wAI3ggJp8xJkwoh7hretAb0IwsUb8yi62S56viGc6ZTASHjx
         im4iOjR3WCa8HIjFxBTR1uMQBzzhnDXgdtI7QH4xOdu8JCjvMNuJpQOkXni588PNQ+rE
         Kf5CT68PRJosTUyToGzu8gSFrruP96RbNsUKNvgKvvjAd8oih4VZfE8nJNppKHqwjamR
         /HPKN1dE2bkkF4HnH0VQjX8cQ0kPa/3pwZrQfnwdoxTACqn2XfANDf2YUNC4e04tQ8om
         PD+8VanfzokMGdUWENAOoLNxg2phYHtZYbjFKAfRaqufA8hcBkhMNq4/JaJQ9DYvgfnA
         TnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716366454; x=1716971254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yc4M1An1SVE3VhBwugQSFEPj2HdsFrg3eqR9/azRDhc=;
        b=sB5UBf6eqkQF2SrbAZcYNoZI3nslBb9uAK6Exjm47k/PHRTjPiWUrP8omX7JSYE0kR
         IK0WxwwaWb+laZlMDwfNbRpnq01fKSoadja6TyWWVqtnRF1Zf6bIiUi/8nKPDrDQcxh0
         4PTiCvyQvWaCGJFnJkHo+bR72Y6vd2moeNThQELn2gBuBeHjiLJhOySzAzWgpMzEnZeS
         SDbIhXcXbsiHFNFAdOD4+W0SoVb/n/Tzav+rHItoNZVoS59hfWhXUgssBsbWl0h5Cj64
         FyTWZXBv/Zxnq7HpkVwIbt+yranUGPEUyys4KBg+3n6dqET58uEgK2IFamiFuPHmCcV8
         kWgg==
X-Gm-Message-State: AOJu0Yz8q5rmlWxnr6BqcP5TKPY6ZcyVFmaYKgsQjJIsG09mPzBzHsGA
	ZW286ibihaASvYkpsZ3SH7wHUR2RED1JZCgmxbk+cxntvl1tLHiVyEvZQ3oDSZM=
X-Google-Smtp-Source: AGHT+IERf8nHrVQJQciNF+/AH93iydxOXg4s7DAjqXpHChiioJxblNiO3nCQrgigc6+DScksJIpPOg==
X-Received: by 2002:a7b:c449:0:b0:420:1db0:53c1 with SMTP id 5b1f17b1804b1-420fd355961mr8286005e9.41.1716366454344;
        Wed, 22 May 2024 01:27:34 -0700 (PDT)
Received: from fedora.iskraemeco.si (84-255-245-182.static.t-2.net. [84.255.245.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bc0asm33964495f8f.1.2024.05.22.01.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 01:27:33 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 3/3] iommufd: Use atomic_long_try_cmpxchg() in incr_user_locked_vm()
Date: Wed, 22 May 2024 10:26:49 +0200
Message-ID: <20240522082729.971123-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522082729.971123-1-ubizjak@gmail.com>
References: <20240522082729.971123-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use atomic_long_try_cmpxchg() instead of
atomic_long_cmpxchg (*ptr, old, new) != old in incr_user_locked_vm().
cmpxchg returns success in ZF flag, so this change saves a compare
after cmpxchg (and related move instruction in front of cmpxchg).

Also, atomic_long_try_cmpxchg() implicitly assigns old *ptr
value to "old" when cmpxchg fails. There is no need to re-read
the value in the loop.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommufd/pages.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 528f356238b3..117f644a0c5b 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -809,13 +809,14 @@ static int incr_user_locked_vm(struct iopt_pages *pages, unsigned long npages)
 
 	lock_limit = task_rlimit(pages->source_task, RLIMIT_MEMLOCK) >>
 		     PAGE_SHIFT;
+
+	cur_pages = atomic_long_read(&pages->source_user->locked_vm);
 	do {
-		cur_pages = atomic_long_read(&pages->source_user->locked_vm);
 		new_pages = cur_pages + npages;
 		if (new_pages > lock_limit)
 			return -ENOMEM;
-	} while (atomic_long_cmpxchg(&pages->source_user->locked_vm, cur_pages,
-				     new_pages) != cur_pages);
+	} while (!atomic_long_try_cmpxchg(&pages->source_user->locked_vm,
+					  &cur_pages, new_pages));
 	return 0;
 }
 
-- 
2.45.1

