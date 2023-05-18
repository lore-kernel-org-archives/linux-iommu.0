Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9657E
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 01:51:49 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-561a80d872dso23176737b3.3
        for <iommu@lists.linux.dev>; Wed, 17 May 2023 18:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684374708; x=1686966708;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zXh/O/V/WptHcvZP+JCdTYTDP4LQ9st6a4OKh85bxLg=;
        b=IfmQuyHqbPtqNnhVieMu9NzCq4te8XLyLb/DhJuRmnprCTKiLUdOcW6g3y2jB1dgkw
         YFNcIF+OSbv5phj/j2mXjZK1mFlyvAe2aq1crDGN0RreDGx/deLCWh8WLU8nvJ4Gpn0x
         ochjMURbmABoRK5v6ctPRm/1GCnTeHPXmZ6bpCP4+Il3DO8AmNxg0xbQHm0/ZovoBPe+
         pA6kO/hvzAML1E0cPRlo4hwhaSAM0ELQy2CxzL/77SQq/Dko6cvu5yudJ7m4L03nAFUQ
         dXAFgjMf4adYvGjw99XcYjUepdrxgpym8kGLufrd3hhSNPGeUvt8xanCRGPdyEEyPAFX
         lNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684374708; x=1686966708;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zXh/O/V/WptHcvZP+JCdTYTDP4LQ9st6a4OKh85bxLg=;
        b=jqJcCKm8/b+vQtpYLUsOZVOO8Kzhx/dIMz2b3hF0WQP/UondtbMvdCTv9V5ELtCMen
         X+WKzZvyvOMEfvVfuRrWadubZolmGRt+IA5Hwr8LZoOrU7MF5GxsqehGJXwy4r65x/O2
         gx3oPbXZlgzWDNzzWj/jlKm2oPQHmOGW2/IaGeYXyaj7961JMQygiTY7R0pYKnm+sYE6
         w5ZLHQdHf7SlPF6EZYmn06dWc8+xTlVq/YA1z8hx88EtCRY/0qWaaPPvNWajJ9N7J1ZI
         xxlKRsBhJOw8J2e9efLqNpmjlEIvNMGoXJtedaoji6cbtZ33fgaN/NLL7eYwYdPD4+iF
         65yA==
X-Gm-Message-State: AC+VfDxGavu87+O8cjEvD9YNTlnNm19752Z7Ve7NbQ+GCC6WTXvWuiGh
	q1DZPM4hl1CGeRnJarwR8FVuJi2Bgyo=
X-Google-Smtp-Source: ACHHUZ5YR3a7R9JsHjBo5Xw0oxDMRKd1Rw9K1kdyGq6xvpeMZdMrKgm1WLSCiFPT5VQPXfLP5Z5nDA2kPAA=
X-Received: from pandoh.svl.corp.google.com ([2620:15c:2c5:11:2f7e:7405:7496:cdec])
 (user=pandoh job=sendgmr) by 2002:a0d:ec09:0:b0:54c:2409:c306 with SMTP id
 q9-20020a0dec09000000b0054c2409c306mr93492ywn.6.1684374708680; Wed, 17 May
 2023 18:51:48 -0700 (PDT)
Date: Wed, 17 May 2023 18:50:54 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230518015054.2223833-1-pandoh@google.com>
Subject: [PATCH RESEND] iommu/amd: Fix domain flush size when syncing iotlb
From: Jon Pan-Doh <pandoh@google.com>
To: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>, stable@vger.kernel.org, 
	Gary Zibrat <gzibrat@google.com>, Sudheer Dantuluri <dantuluris@google.com>, 
	Nadav Amit <namit@vmware.com>, Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="UTF-8"

When running on an AMD vIOMMU, we observed multiple invalidations (of
decreasing power of 2 aligned sizes) when unmapping a single page.

Domain flush takes gather bounds (end-start) as size param. However,
gather->end is defined as the last inclusive address (start + size - 1).
This leads to an off by 1 error.

With this patch, verified that 1 invalidation occurs when unmapping a
single page.

Fixes: a270be1b3fdf ("iommu/amd: Use only natural aligned flushes in a VM")
Cc: <stable@vger.kernel.org> # 5.15.x
Suggested-by: Gary Zibrat <gzibrat@google.com>
Tested-by: Sudheer Dantuluri <dantuluris@google.com>
Acked-by: Nadav Amit <namit@vmware.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Jon Pan-Doh <pandoh@google.com>
---
 drivers/iommu/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5a505ba5467e..da45b1ab042d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2378,7 +2378,7 @@ static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
 	unsigned long flags;
 
 	spin_lock_irqsave(&dom->lock, flags);
-	domain_flush_pages(dom, gather->start, gather->end - gather->start, 1);
+	domain_flush_pages(dom, gather->start, gather->end - gather->start + 1, 1);
 	amd_iommu_domain_flush_complete(dom);
 	spin_unlock_irqrestore(&dom->lock, flags);
 }
-- 
2.40.0.634.g4ca3ef3211-goog

