Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE6F342526
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 21:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780351162; cv=none; b=hmrbuxpLiI2quUujsbVmEzD6XIjyXs/bacKSP/HYb5Lh3eCdyK3Fstyal07l/ne7jbMi6ejexMhtlPNQAedIUwW5Rrjw3g9qakCbVYzoMyLMXlncoobOhSSWuBdrPWW5fv06VXpx61bYQLDMxIyD/T7kMcN0H5hYSnE6qCpusaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780351162; c=relaxed/simple;
	bh=xWe5lrAka48SsNsq+rRDJlkZ9YwBUh8wW8cee+515d0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=It8M1FLbVz+jSfcEnUM/j8yLxkQr7ySd7nNWVbRuRVNSVotGqNltZrItwdAqGdwpRCpUSd70w+CFyI/bSYPrv4lxV2DcVUeyvU6eLtU5oNyCRk+GMJu8YueIhc+UQhCYRqXUzuFBK6rn/WQlG2oD7F0kx0A4jvYAya+03xK1rrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Scc0s81s; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Scc0s81s"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d99333358so1689807a91.3
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 14:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780351161; x=1780955961; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bXqkopj6Oh5WtyGQaum1YKVEZGGYYtaMkCtOohru3Bs=;
        b=Scc0s81sApLr9mYNvF3bDrH5s1ze5yQo+FnduH4yVybN9faa7RopXp8epjFQj3K98Z
         uJGF9OcLWfvNtwZf3YdD++K98bE0aHlf+HVHnLB9avN6jF3pesu17Iu13glxGKSKB5cI
         xmpfXrj80TRZ39xjUZq1xzgUUpcRnxM1WX5H/Mtc9smCr1x+ACdDyS2qojyotyL5lIps
         DHh9yHZBVbp49hF+s3ciQTBpECMrEtNAj79fUhLoN9ZT+ezduPMeOJZcg2IMWA6S/4of
         NTKkOuiHx4i00I6BrTsFmYTo4zGcbhMqH9+VfUvQDOwfhfTD70w/e85BrsnYnnE6xIML
         zLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780351161; x=1780955961;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bXqkopj6Oh5WtyGQaum1YKVEZGGYYtaMkCtOohru3Bs=;
        b=NbrcNncBr2E6hjkml3Qc+nVeQiSXEiTCbpNFUYWs0gg5MX1iLWDG2xqm42+rWonrlX
         4XbzrnpCJsRgnuJy0eZVxT2pq5dAnoq4Sgpt6ZqWnl6eRY1VFPYlMGyIbyvwmXRmn4hv
         pqM3KShLItn/Bk08DGnDkquNnG0kbYfoUe98yo3nbP6Zr9zozlrc0l3lKXWiZWymhLwz
         vysyXrIo6G3whpMuR5p9IsnOf14cfHdZdvPaNsN3BiUlmpcgnwbhbxHKb0NqN7uoxQWM
         c7DvH17RHCEyclonoGYwaxQdHiktKcPGLelfK+BqIidLbHbASILR1mJmmG6qkHMOeoJr
         5jfg==
X-Gm-Message-State: AOJu0YzoDfMqjEiIW9K5SuslfgiQZAvyA6pbqj/t/eZHb8t3BrE/mhdD
	mQzuyEPmiwWshjY8UMD2dmNEmc7Evk2CyS6NMbDnD0pnC+4LzB3wBVJm7vR5XVvc1V4J7A7TRgh
	OMyqrWYCjnqcnjKNr6DTYjk26q3ZnxGYHfLLOyze3YX1FKQG6DZ5bKeXjFgwT8z7Zejoe39ksw+
	441HUhxXFWSVVuI6mtrxyae6WMzoIPog==
X-Received: from pgbct3.prod.google.com ([2002:a05:6a02:2103:b0:c73:fc44:8baf])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:264e:b0:369:7433:2fe
 with SMTP id 98e67ed59e1d1-36c4ff25853mr12026633a91.6.1780351160239; Mon, 01
 Jun 2026 14:59:20 -0700 (PDT)
Date: Mon,  1 Jun 2026 21:59:01 +0000
In-Reply-To: <20260601215909.3958732-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260601215909.3958732-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260601215909.3958732-5-praan@google.com>
Subject: [PATCH v8 04/12] iommu/tegra241-cmdqv: Restore PROD and CONS after resume
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ashish Mhetre <amhetre@nvidia.com>

PROD and CONS indices for vcmdqs are getting set to 0 after resume.
Because of this the vcmdq is not consuming commands after resume.
Fix this by restoring PROD and CONS indices after resume from
saved pointers.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index cb1e75e4ee91..866cae7b73e5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -511,6 +511,8 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 
 	/* Configure and enable VCMDQ */
 	writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
+	writel_relaxed(vcmdq->cmdq.q.llq.prod, REG_VCMDQ_PAGE0(vcmdq, PROD));
+	writel_relaxed(vcmdq->cmdq.q.llq.cons, REG_VCMDQ_PAGE0(vcmdq, CONS));
 
 	ret = vcmdq_write_config(vcmdq, VCMDQ_EN);
 	if (ret) {
-- 
2.54.0.1013.g208068f2d8-goog

