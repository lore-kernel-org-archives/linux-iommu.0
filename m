Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C1B21770B
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787921657; cv=none; b=LnBdEikGLiqindPQPQmH0z577ZVdiGJlZGuuqM5H4wHg3fPcM9qXhq0wNTv3DnfuhMxu34CkQQ3lDzae2ohTRK5FUTWKUge/+4LRznCSHNNuT4zG4QRsEL4keuQJWQbIMx0pSnFkW3v53RcMGhFI/PtgaBPzo0h726fnQ1I5Yc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787921657; c=relaxed/simple;
	bh=3LghuCz6pycXbnP85DgU8ufPyn28FgBL9yBgmwQvaVk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=p3tBUAoD3HLEtus+lRmLZjZ9BXwej2v7oU/NU6p54ynYNF7YWUipeHsE8/EKBIFtxPxeva77e6qyp061OdPyoNA13KxfZjEhDbekN+9vnZyvhuCiOa63978kPZafKtL/IDM1e6jfdhWUEQpGBCll+9Jk1ILgQrbuYK5CExpaxRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lvOqxetI; arc=none smtp.client-ip=209.85.221.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lvOqxetI"
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f81362fb1so560272f8f.1
        for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 05:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787921654; x=1788526454; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DRGIXLcHuELZx1Qe/K3lDAq7MZx3TuN6UHTja/wh6Zo=;
        b=lvOqxetIGyttK8GezL6tXky/4j4dUNlVtuICPM9Z/fJXk5zvnQNdUSClD6pFQneQZW
         xFmyNNpZmjtcMnHnleBQe+NQlU2qkJiy8QBhAZiVyNG0bjZUW6Gny/7o/K8MwGTflmcp
         dqz0vYL5nJT7+F8uEYYDCw1GfiYiCi/xvTuNMImZUCkyzzyvWALoJ6ycKHejZ0vUWFMF
         IU0ZkUOS+RZCzRlvpKfkcpSsyJ/Jj6uyFsdGJYmFzuuhvYjB3TGvEPUPAIhwkApuDnEp
         oNuzMUVuej41VJQ4+nS+moUILwCR50EuIrCyRGi3poanaaiVgZeJEQ+K4JxpX+8ySp3f
         LvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787921654; x=1788526454;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DRGIXLcHuELZx1Qe/K3lDAq7MZx3TuN6UHTja/wh6Zo=;
        b=gwDPzn9xk+KHhzibap7/QLQcvsVrFvO10B0osDAJPcm1vyr+sl2VHwI9nUxBDwyIt2
         mRRyXC7HYoWX7UgsrTmzYyxQCkGNGnP9H8Ap+jpwwCwhr58jU2fw6XgFSaQ3ycImm6Yo
         Hf3j+Jc8N697W1lzgq4C6gNQnptbJlEN59J3wc5oO/YaVaOmV3yYihta1HFGrZm6Db13
         HOfp2QAT34uGKKLQg506lykiHZt3HbECxaQSjzbnOg//lYxXMtmSFz4PE1ixO4xDRDJp
         04OxQ2IJc0ZOV2maoqUj6G1wwVM0wUcgsPjp2ukVMgpL3BL9jKYWfPwy5FbqrhjCD53j
         WIjg==
X-Forwarded-Encrypted: i=1; AHgh+RomnEEemaKHQUtF7FCINu4TiDZfjNsFonkuCTwX2rh6RrPacKQ+2knk0Ap532PHZD4rDNr37A==@lists.linux.dev
X-Gm-Message-State: AFuF++mub0k89AiF7jR+9Az7s7XQKQGFbgqymHVdfEstC/BOTBygYMN7
	g+2UGOiNY50nRGxxxoIVUZYd9jTxpHRilXkXiQUD0DqXMNdgkIRJbSIgMyLzT0UKLLvanQQMY3G
	oDVD8V5x7ln9AQA==
X-Received: from wmsm23.prod.google.com ([2002:a05:600c:3b17:b0:495:6261:8954])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b21:b0:498:952:e276 with SMTP id 5b1f17b1804b1-49b91c3f643mr99111705e9.8.1787921654019;
 Fri, 28 Aug 2026 05:54:14 -0700 (PDT)
Date: Fri, 28 Aug 2026 12:53:35 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260828125409.1921538-1-smostafa@google.com>
Subject: [PATCH 0/7] iommu/arm-smmu-v3: Fixes reported by Sashiko
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

While running sashiko locally on the pKVM SMMUv3 driver patches, it
reported some pre-existing issues in the SMMUv3 driver (the RB tree
corruption and a missing NULL check) and given that this is not the
first time a pre-existing issue appears in the driver from sashiko,
I went ahead and passed the whole driver to Sashiko which reported a
dozen of other issues(except the last one in this series), I included
fixes for bugs I believe are true or worth fixing (others were mostly
missing NULL checks or bizarre HW/FW configs I don=E2=80=99t think are need=
ed).

I also sorted the patches based on severity from the most critical to
the least, so it is easier to apply a prefix if some bugs are too
theoretical

Mostafa Saleh (7):
  iommu/arm-smmu-v3: Ensure L2 tables are visible before L1 ptrs
  iommu/arm-smmu-v3: Prevent rbtree corruption from duplicate streams
  iommu/arm-smmu-v3-iommufd: Fix error path in
    arm_vsmmu_cache_invalidate()
  iommu/arm-smmu-v3-test: Fix arm_smmu_v3_test_debug_print_used_bits()
  iommu/arm-smmu-v3-test: Add missing error checks for inv array
  iommu/arm-smmu-v3-test: Fix OOB in arm_smmu_v3_invs_test_verify()
  iommu/arm-smmu-v3-test: Fix UBSAN error

 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 12 +++++-----
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 19 +++++++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 22 ++++++++++++++-----
 3 files changed, 39 insertions(+), 14 deletions(-)

--=20
2.55.0.897.gb25b4bd76c-goog

