Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A80133F8C5
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 23:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773100363; cv=none; b=FOZfeyd+XW3MUCKzUficu++BYN0kUYP8yeXxGk2JLOeAnWGT8tolKpy+havSf/AYt1upi/siJST4hvdnql4V29z3EEQw0oamGs3hl5mZyqYikw2gkNou2veQ8k7sn7Wh3QfHXgIZUd8a3qaNp24nxzTZiJWXBwnH8H72dKB9tls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773100363; c=relaxed/simple;
	bh=mtzjGFsLgrT5E1Z+qJblFm43sZn4UO1lYBR5VIlWW7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AwWTHb9ujKC/pDNHgYZNCWrT6SuyjDG54qrRBt1PWy8LtSLLAu6p858MGr14idHEnsKcie/WUU6tEG/4rugEdez+/3vQaWSWzTv6Y1tOmx4SrzAfor1o8RihEZHi3lFesINkd9bqtJujCYqDlvni0VHNPExEJsjnqzGArmTa0Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=RqhF4d2t; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="RqhF4d2t"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-829a27414a3so1971074b3a.3
        for <iommu@lists.linux.dev>; Mon, 09 Mar 2026 16:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773100361; x=1773705161; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DM71VgvO3clFL330YEhFl+G5lnrrrbTwagG8j57LbrM=;
        b=RqhF4d2tiXHQLqAthJqcCZ37haDNc4Q65Mv50ZCvZHvsfIHFbw/r1QWPklg7hNu+Hb
         uiK+wccl3qpUef9ScNxS0xgLPTf23ItoTHfuLG0jOVkc7/fIbjeD8phK3sl++6C8RJWT
         ax06N3SXs+Pkao4il2sOSeiyggE/F7yA3r41Jx1OvdspFMxh4JNgdBvCKOQIJFn+NerE
         /rGrEcm7wNAhYoeo+2R70Y99YDUp1YG24O9IfyE+gmHjI7bSsrt7Jj2kS5OUZh7h4Tiu
         GQEJ5ii64aEqmwsMWASaf9Vsl0E+6E3UhXFw/8fzBlTUg5CINXlW+GZ6TGnDZBny9uoJ
         f8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773100361; x=1773705161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DM71VgvO3clFL330YEhFl+G5lnrrrbTwagG8j57LbrM=;
        b=foPKcOrY6vYu77WLYmAGLiGtiVD7ke9WVM+v59J6ONYeb4T/VCLiF0w2hamnXv0RKl
         nopy0MbImUn3vU05hsBsiMD0Kc7Y1/75NUnVYoWlNhxsEHz3+1IT8cyLFvYSQuFLcd51
         yRUoO3qxZwDn+7yZtgosm5khIbbTa/fT1VpIvQKjU8LPdzjl23QpKUwCmaLIRtdiRgvQ
         wmfRSO27sQmrhjAuonAuZDcMh0dcgMlzneF+3TGOjSajeweRrTKgs6NrOy2maYXghOLn
         UKGHxSdsB4kN44epTJoSbL4b2WPu4HpqwZvPwShbbI/ApEG55Tt6Y5qWVoitOdOgQgDP
         gNFg==
X-Gm-Message-State: AOJu0Yz+skmMKIkfEOproDqVJzqVNPxsWP5Z8V/bU0FdmCUBq2tBt5YU
	sJvgkvvWgPFVZS0nAO4+obEHVufXO68g0zGTgeG0v0SO0z144IOmFH5XWVOQbTnFWRm61jJbhxi
	UA0fpKFw=
X-Gm-Gg: ATEYQzx1RdQ7ksRpY2xSpEMnDq1bq2LUUqY2E5phvNXsiuVRvSyAUp6jh4Ty1v3P3ZM
	uqVojEwYhh28LUMNSMVc47jNtA1UoqxipDwCJ5E8QJIShN0PpZzXEV6OkeSkGLYnQzdNMfwdZ3E
	ESfQr2DmIhY3pYihaI0ignIP8LBj7EuI5otwpzn6J8bftd6HZ5k/jK+6Sh8jnsij+oY0KdbaFjf
	gjZ76e9EBSIpJoRsAzqhpMtH7wyD8G/uVj0A8UpHy6r4fYeOZYnb14djlbVpxAwXNHI9sp8AJth
	7GDakWbScNr5TMqqg/hvDmAu7NFwKMFJTeTdbZOBT9ZjeHShpbVCfkjQghsceVPmaLdhn7RcGCp
	Xq9rVFQkNTB/CJPkDJOC7AAo+EC7ku+qh7iIzPVdL8YCYGyPTjvDJisR1UvTUKYwt/KnY+SU9bS
	gW/ok=
X-Received: by 2002:a05:6a00:4511:b0:81c:96b7:7faa with SMTP id d2e1a72fcca58-829a2f4fa0amr12118981b3a.41.1773100361343;
        Mon, 09 Mar 2026 16:52:41 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4676187sm13651515b3a.27.2026.03.09.16.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 16:52:40 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>,
	Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] iommu/amd: Block identity domain when SNP enabled
Date: Mon,  9 Mar 2026 16:52:33 -0700
Message-ID: <20260309235234.3367768-1-joe@dama.to>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, commit 8388f7df936b ("iommu/amd: Do not support
IOMMU_DOMAIN_IDENTITY after SNP is enabled") prevented users from
changing the IOMMU domain to identity if SNP was enabled.

This resulted in an error when writing to sysfs:

  # echo "identity" > /sys/kernel/iommu_groups/50/type
  -bash: echo: write error: Cannot allocate memory

However, commit 4402f2627d30 ("iommu/amd: Implement global identity
domain") changed the flow of the code, skipping the SNP guard and
allowing users to change the IOMMU domain to identity after a machine
has booted.

Once the user does that, they will probably try to bind and the
device/driver will start to do DMA which will trigger errors:

  iommu ivhd3: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:43:00.0 pasid=0x00000 address=0x3737b01000 flags=0x0020]
  iommu ivhd3: AMD-Vi: Control Reg : 0xc22000142148d
  AMD-Vi: DTE[0]: 6000000000000003
  AMD-Vi: DTE[1]: 0000000000000001
  AMD-Vi: DTE[2]: 2000003088b3e013
  AMD-Vi: DTE[3]: 0000000000000000
  bnxt_en 0000:43:00.0 (unnamed net_device) (uninitialized): Error (timeout: 500015) msg {0x0 0x0} len:0
  iommu ivhd3: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:43:00.0 pasid=0x00000 address=0x3737b01000 flags=0x0020]
  iommu ivhd3: AMD-Vi: Control Reg : 0xc22000142148d
  AMD-Vi: DTE[0]: 6000000000000003
  AMD-Vi: DTE[1]: 0000000000000001
  AMD-Vi: DTE[2]: 2000003088b3e013
  AMD-Vi: DTE[3]: 0000000000000000
  bnxt_en 0000:43:00.0: probe with driver bnxt_en failed with error -16

To prevent this from happening, create an attach wrapper for
identity_domain_ops which returns EINVAL if amd_iommu_snp_en is true.

With this commit applied:

  # echo "identity" > /sys/kernel/iommu_groups/62/type
  -bash: echo: write error: Invalid argument

Fixes: 4402f2627d30 ("iommu/amd: Implement global identity domain")
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/iommu/amd/iommu.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 81c4d7733872..760d5f4623b5 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2909,8 +2909,21 @@ static struct iommu_domain blocked_domain = {
 
 static struct protection_domain identity_domain;
 
+static int amd_iommu_identity_attach(struct iommu_domain *dom, struct device *dev,
+				     struct iommu_domain *old)
+{
+	/*
+	 * Don't allow attaching a device to the identity domain if SNP is
+	 * enabled.
+	 */
+	if (amd_iommu_snp_en)
+		return -EINVAL;
+
+	return amd_iommu_attach_device(dom, dev, old);
+}
+
 static const struct iommu_domain_ops identity_domain_ops = {
-	.attach_dev = amd_iommu_attach_device,
+	.attach_dev = amd_iommu_identity_attach,
 };
 
 void amd_iommu_init_identity_domain(void)
-- 
2.52.0

