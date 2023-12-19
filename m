Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6822D1426D
	for <iommu@lists.linux.dev>; Tue, 19 Dec 2023 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Muvxi0ic"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e23c620e8so4073086e87.1
        for <iommu@lists.linux.dev>; Tue, 19 Dec 2023 01:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702979821; x=1703584621; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UDfnExpJZu5lDtrGL4NOnG533YvholurjpF0JSG0JHA=;
        b=Muvxi0icT5VlQAb1SE8SxizO3FXt2G0c9GSSv07IoxJW7sZKZvWr8GV4KmEa8r4gNP
         JfXzWIbCmI13ArpBoNNbUZhJkw+ImHHV3qofDGZcgvL0GvvozT2ZwCrL4WGUKYqz88br
         u1LcQXt0CWxhzU0bVUCO5xCI3Iaq9WVp7x9iOxJg1IwoemwWQvhr0GnlVEi2Xlr+nnoo
         +L+T4ctIkmKZ9vA6vO7rjqoPOQfZKx+8SDfB27MJp6SW4JVFHFsuAtCOTMJthfOn+8g+
         udftOQRARy83cWCFRlgUxEfYh6rVqtUB+Wdlo4dHbk4W+fnioko30jGPdSO5gsLzphYg
         vNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702979821; x=1703584621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDfnExpJZu5lDtrGL4NOnG533YvholurjpF0JSG0JHA=;
        b=R3nj3MNGzdjc+lM7IsdHr+zzs193gy4xDlA9pR+BxVZI4GoVrZiHRJVctnJyp17XPV
         UYDLkozBibg/SLupUAfaUC6ecsWLbpy0WPYjLn6sbA3IcgjHN/enCyPFhKmzAlbeZas7
         EeU/gvcEuCpyDd0rpoh3kktYAfG8Nixq5tm0CAGzwyGXnGclmEp6ugtjo6IZOFP29BFT
         +z14BCu/8oQH8o5egqTBumXASkhr7HUSyKgGKwwVLhQQfnVOFMNevNX395rc0YrV1qv7
         CbLGfy1f3sTJLP/0e7FXoZ4UhxkC3670lAA0esIBlPYygRRknBqILrDbBVWz8CYpH+9O
         nuvQ==
X-Gm-Message-State: AOJu0YwwS2v+mYfB7tH7bI2h+qipZl/gepK67CRW9V83ckxGAhTkLylO
	0UhcTxPgESyE4JYyTSDZxzc=
X-Google-Smtp-Source: AGHT+IGmH6tQaWng9DmUEo7tJ+H2ieWBpq+2KSusC/Wh+epp/uLa0Ak8oJA7k9P12ScuED1BDdKDBA==
X-Received: by 2002:a05:6512:508:b0:50e:3b86:bf6a with SMTP id o8-20020a056512050800b0050e3b86bf6amr1212955lfb.43.1702979821250;
        Tue, 19 Dec 2023 01:57:01 -0800 (PST)
Received: from alsp.netis.cc ([2a02:2168:8a0b:bd00:ec0a:381e:719d:789d])
        by smtp.googlemail.com with ESMTPSA id eq24-20020a056512489800b0050e233d2533sm991151lfb.159.2023.12.19.01.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 01:57:00 -0800 (PST)
From: Alexander Sapozhnikov <alsp705@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	ToWill Deacon <will@kernel.org>
Cc: Alexander Sapozhnikov <alsp705@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: amd: NULL value may be dereferenced
Date: Tue, 19 Dec 2023 12:56:34 +0300
Message-Id: <20231219095636.17203-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pointer 'dom' which was dereferenced at iommu.c:1993 
is compared to NULL value at iommu.c:1998.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexander Sapozhnikov <alsp705@gmail.com>
---
 drivers/iommu/amd/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a0924144bac8..64a88e67be9c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1985,6 +1985,9 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
 {
 	struct protection_domain *domain;
 
+	if (!dom)
+		return;
+
 	domain = to_pdomain(dom);
 
 	if (domain->dev_cnt > 0)
-- 
2.40.1

