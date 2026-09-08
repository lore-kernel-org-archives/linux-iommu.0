Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69007566C43
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887852; cv=none; b=Knf2ngTSEyPp2OTjHH+qspCEtjNj1YBtaJJpMyNwPbgrr7bBvScAZ2Bl9OPGymXhtNHBBa8JZItj14u/tGdbt1vQT11K6sIcBnujF8lKy1WGQZhkY1z1EATrRQbHOnUNgbOEiLk6R/lLjgce325vPXt/gCjBeDVbe8WMZYePHr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887852; c=relaxed/simple;
	bh=vMT/cJ3zaoQMUvK8SnLuLj7FZMK4HGZ4xexVkc4OlV4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VmIPfdR86Fn6xPT9rzaCo8G/vipiqDnydCnyubJLooO7uaXseksDQ/WHevNjxiZjE7p//gvOujCmfGCaYJbr7k4w62uhC7OZgauW2wwsiYhP75PbDdMSFdqsAx2gnR5j3HDoF7vIjjptyCFNwuaphgbRfUiJyN4RwhL63icrhjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uwxRGIVE; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uwxRGIVE"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so6021807a91.3
        for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 10:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788887850; x=1789492650; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0XsMPvOE3afXsZVMyFMwLpKgTSpBthouLl9Pg3MA9sM=;
        b=uwxRGIVED5UYvqZ7OTfBdQdFf1MxEUP0+6Mzz3nCxnxDlb+sYqAoxFnXnxluyFUdgG
         TXaR8zddFwHzigrIrJ0WTxD+EeaKtyDwfubNZ6gj0jtEATLr6kUTVhMkQuAsnbwqgRAs
         YYTr5FsS9S8wC+u9IUlboYtkk96oRl9BF8VIHASBzs/dgnCTzj7QEk5pbrOIMD0pcbBB
         bTLG3rnaSvktcfQwguNhE1BKfw4rdbe8hGO+gahpeMB4tW2h0+hnNcPoIJQ03cr+4cAE
         hDsuVfcEDEQk500Z+3/V9MA8+GxuF/z9MJul6CPwxP9L7D0z/YbAuYIi1W7Fz6T9xRec
         KWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887850; x=1789492650;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0XsMPvOE3afXsZVMyFMwLpKgTSpBthouLl9Pg3MA9sM=;
        b=YV1dzSPSkIFp3HSQVfUo1hBS6MxZfHgFHJiZZ1cR1fcS/LBqMRJQLiE/npIahqLe8B
         X5r+ocBMtDzR4uRoVozsyyjGQvSaidb+ARY2PafRBXaAWHd4/oVMEWaxO5bRV7PsBNKa
         pktcR9Q2TckXvIZ3ixUWAGHFXgueuMAxnPxAERlmW6J18AWv/AfvBM+5u7qoMuKiKh5c
         B+or88UB9J/LipM59Gf+ffH1wOjx7kXAWUY2O9Y0faGG9RSVbgvOXK5ihsUB7GnBNkUN
         Gx4sLOkPpFRCEA1VzGKgmYV8PYopNY71uIOJGurEqNw1bVIO6Q8EnuGJF+P28kChJ3xc
         suiw==
X-Gm-Message-State: AFuF++mevtTyyAO62NIFA5joPjzvm8WxeRrGfIoy1hjXysh5K8faeJ8Q
	HYNV+++UOXBaCdi0oowJ86u94QD3Mjj1ICBeAU1MBildW+R+66ZqSC7kMqc2EHyczem6CHeLSQ0
	rflvGZzuUzCFHQkr3fH6TrbPJQc0N/qVFpIyAthHlBJ6Fbq0/f+ZOd/H01k5zFZU3F1y3eqoxYl
	QncW6HV3IUipUFDqjX0nn1pWcrxbXU7w==
X-Received: from pjbmv24.prod.google.com ([2002:a17:90b:1998:b0:39b:4485:d746])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:528e:b0:38e:ad9d:1161
 with SMTP id 98e67ed59e1d1-39b25ee67f0mr45919989a91.0.1788887849350; Tue, 08
 Sep 2026 10:17:29 -0700 (PDT)
Date: Tue,  8 Sep 2026 17:17:02 +0000
In-Reply-To: <20260908171712.356645-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260908171712.356645-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260908171712.356645-7-praan@google.com>
Subject: [PATCH v10 06/15] iommu/tegra241-cmdqv: Restore PROD and CONS after resume
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Thomas Gleixner <tglx@kernel.org>, driver-core@lists.linux.dev, 
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
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index a394bf0f487f..c7989fcd2c62 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -567,6 +567,16 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 	/* Configure and enable VCMDQ */
 	writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
 
+	/*
+	 * HW Registers reset to 0 when power-cycled. Restore them from their
+	 * SW copies to prevent executing stale/ghost commands after resume.
+	 * Note on RPM: Power-cycles can never happen when VCMDQs are assigned
+	 * to the Guests since the relevant frameworks (IOMMUFD / VFIO) hold
+	 * active PM references preventing suspend while VMs are active.
+	 */
+	writel_relaxed(vcmdq->cmdq.q.llq.prod, REG_VCMDQ_PAGE0(vcmdq, PROD));
+	writel_relaxed(vcmdq->cmdq.q.llq.cons, REG_VCMDQ_PAGE0(vcmdq, CONS));
+
 	ret = vcmdq_write_config(vcmdq, VCMDQ_EN);
 	if (ret) {
 		dev_err(vcmdq->cmdqv->dev,
-- 
2.55.0.979.g7e5102b832-goog

