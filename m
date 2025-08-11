Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63271EF39F;
	Mon, 11 Aug 2025 13:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920293; cv=none; b=PEyFfQA/NargjJ45cDtgFQB9m/HxMamCpqp6EVJIryJwF8svR3sWWbNZPFqsn7rxDXyH9FEpBTRuyuHolYhOUvgSUJwbyCbKgEV+b6v6d1OQPMm30LQzlPpoiCt36PzfBkeWlWge38GUiAxCXgoTpQEsefPUJCEj2xa+qpP2KcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920293; c=relaxed/simple;
	bh=rwyfTWY33eH9/JkH2R41w9Wvs6PBkQcZY8fhDT+IUjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mkEWkGGA3Sze4goITAU3mqKCJt7zbWl9SXJ9Hw8MStIu6frmDMa+FYsZF0dl/GQ7qrzg66UGagq7/auKFUEBTYRZxJXS9Ft4SJP79P9ojF9mbvWj57/qoUpwOCS8QEiJpvB1wCwltgSRhnrSBX3Lyn307jTcEhvs3w+Yy12pyMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCEp5htY; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCEp5htY"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76bfd457607so4229771b3a.0;
        Mon, 11 Aug 2025 06:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920291; x=1755525091; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+4DQ9gFfqWg9bYh04jDrMGb2bGde9Og3BcDQZ7GXzI=;
        b=NCEp5htYxHe6NN92bg+lwllpWBaDJGLILuG1QkCBFk5n3JbhkpkEqzvYLDFc/Zi55T
         usvtXQHeXGvxAZdm9vRZ/+BVfvdnv2QM7Mw9i9lVKDmSPEQP+T8+5lhhEcm7+hzEhKSE
         yv1PjbKCXk98fXIZKaJHUDusAgpYVhIlLjjZd9ztA0g9oqonpC11BVjQ5q1kpRoCBI0N
         P1/NxEQrt7EFsqcaE0CJP5BJ9zIVZtS4DZrtsqVhJhovx2LJPyX9Txgn+xD1+xzzyMCs
         GaKAYsm2qbfTmWtE+YfMSiwm3V0WV/QT6fhVTaBn52W9uMIQQli6ru2AxQt2bfkkgVOW
         Bvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920291; x=1755525091;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+4DQ9gFfqWg9bYh04jDrMGb2bGde9Og3BcDQZ7GXzI=;
        b=UgM/6pz+0bhVoMijZreZZG5RQsVhkcCtONjoh+/y3abJViPGgoeIpFjfuAEHghTzwq
         xEEACRi+dAe75b9m4SMSMlXM7QkyO7dbfee/ok7t1n3zLonJF7fPF4lwmMaw8AzqmABh
         glCbjCmdRVTm8zsFx2A7YXZCdjryc+h05KDTIr8zhZzc2kH21P0w2ZxwrfzPP+mODXoS
         r7Rq1xmbGem4eJjIxFKFDxVqeKkO//7+rjj3R0qcZbonTxw0hL4cCm8a422gZpgwc/DC
         PJqUKrwkstKSpcEjy17nfzOa5kb/IvvKekusoWDzgyq2rMGhDvB+o/mjahLOUdfvCB5/
         y5RA==
X-Forwarded-Encrypted: i=1; AJvYcCUkucA1mZpKzCZ+eDQ18D+3wBHOV57A/mgi1kCkfiTwGYq0oQthVZbfxYsBKSdjqxmlNPmJzg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy20cEITpMbax2tkMIxra0L00uzZmrIe0tZt6BbiqT0+EhTMwFO
	UASyDZOTAI6cCBboiWAXerknhuDdqhp0xEkU8QWe2ekky7C0rJTDMRjL
X-Gm-Gg: ASbGnctkeNIecyM0cqIL1gVrFwY8M2lpEPQ1IsBuw9XcMIpkUUHYcu+0C6YX0ypEBpW
	Qlf69HdcHSKpwGa+ZC1P7YhdQarczjxsH8zBWCrqT5I1WxchEhtZpvlBNLxMDCJUgVgD8eg+CJT
	79GIJq8cVkPGgVO4wSTcsB/sqv8ovUMW5u6jW430OxhLBwEp3//RM1l3d/U2eAUYVpGsF/mf9io
	f/GU/3i1XjWkrgdUNT7pVgpBGZdHzBVbnpJwQzTrNP7CzARd5ZxXYyblXE9nCeFCzBnX1Gtqy83
	blobm8+u7hhWckpmXQ/JX1n7ZkqcwDuPfA+lsIlKXYNDM2vbYutwafQMpt8g9rJPlxO/DAjO0fD
	aaTeruQMwCBa6XkCyr/JWWXghxI3oRIsMnX6JP+6B7w0VbjwX9+IC8Ae73Q==
X-Google-Smtp-Source: AGHT+IHza1fW4UR+ZAa981Mk//ah0psUmGmnKePPNhzQLBjiW4IikcyFLH89QSp4rbQ69Ase7x7TcA==
X-Received: by 2002:a05:6a20:7f8a:b0:240:43e9:6cb7 with SMTP id adf61e73a8af0-240551fb001mr18843076637.45.1754920291256;
        Mon, 11 Aug 2025 06:51:31 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422b7b2700sm23504993a12.15.2025.08.11.06.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:51:30 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:50:54 +0800
Subject: [PATCH 2/9] soc: apple: mailbox: Add Apple A11 and T2 mailbox
 support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-t8015-nvme-v1-2-ef9c200e74a7@gmail.com>
References: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
In-Reply-To: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1891; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=rwyfTWY33eH9/JkH2R41w9Wvs6PBkQcZY8fhDT+IUjE=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfVQudOR+VSigIgYYBjen/pSrND3fNHu5gx3t
 v0Alm1eGAyJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn1UAAKCRABygi3psUI
 JKYXEACymLu/6TH8J0+/T0V91LKlcavy6HnXo0LFirBif/9o5t1dfJ5yjxGlBO6Z1Z/Vgcmckmy
 icO9lENZrFE3D78uNj+Qwk6QbNnKKWPg/dlUKoRj5bKFmJWvnvQ4aLkXVzArxKPqgmNasnh86XB
 9iP+k3huSCfnNor5IAFCeHwSbBnpH4V3pW8CEL7glJDGRJwyK1xOjJFk09RBev/ej/MWNRfQCbw
 oTGGGzhVBoZ36hfc/lTrx8lOytQC01PyEnmN82HS1ASgVCz42/VuTgjm+NNX/ghzm6PuPv6IA61
 spstvz84jxbigjK2czdXEIQdACdyIXk9g0BcRh7nEe1A1bQkRE1EJ0vH8ND9I40mf6qZjBMmebg
 NUMEZh+6qXpFejhVyGXAFbyH7CQQyje5S7qkKXBwu9Yl9YGRVQ3by1B66o5AQMoOGZ1c9cV6AD5
 z89XG5JXa7l/oO9te7Cs75Wlm2kC1qq1jT9lrWFh3XRcLFzsGJTl97nr6auM3KAoxmJ3zCCFMmm
 FHDWC8QUDeJxCAKsQedw13eiUcGkMaBhJHb5ByQe4HwF8ErM6kMjXDLMVRQ3YWYT0VBg0G9ZBpa
 bw4YB1AEURxDCOFjyUFoutlTMrBgTbXqE6njnA0T4JOW5AXp2QInJNBrUTC9uEn9ws9+bWi8aDe
 8FayRVsJAt+R/Zg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add ASC mailbox support for Apple A11 and T2 SoCs, which is used for
coprocessors in the system.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/soc/apple/mailbox.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/soc/apple/mailbox.c b/drivers/soc/apple/mailbox.c
index 49a0955e82d6cf5eef83e5f63ba8d31194c65324..8f29108dc69ac964236121d439e86c923a441265 100644
--- a/drivers/soc/apple/mailbox.c
+++ b/drivers/soc/apple/mailbox.c
@@ -47,6 +47,9 @@
 #define APPLE_ASC_MBOX_I2A_RECV0 0x830
 #define APPLE_ASC_MBOX_I2A_RECV1 0x838
 
+#define APPLE_T8015_MBOX_A2I_CONTROL	0x108
+#define APPLE_T8015_MBOX_I2A_CONTROL	0x10c
+
 #define APPLE_M3_MBOX_CONTROL_FULL BIT(16)
 #define APPLE_M3_MBOX_CONTROL_EMPTY BIT(17)
 
@@ -382,6 +385,21 @@ static int apple_mbox_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct apple_mbox_hw apple_mbox_t8015_hw = {
+	.control_full = APPLE_ASC_MBOX_CONTROL_FULL,
+	.control_empty = APPLE_ASC_MBOX_CONTROL_EMPTY,
+
+	.a2i_control = APPLE_T8015_MBOX_A2I_CONTROL,
+	.a2i_send0 = APPLE_ASC_MBOX_A2I_SEND0,
+	.a2i_send1 = APPLE_ASC_MBOX_A2I_SEND1,
+
+	.i2a_control = APPLE_T8015_MBOX_I2A_CONTROL,
+	.i2a_recv0 = APPLE_ASC_MBOX_I2A_RECV0,
+	.i2a_recv1 = APPLE_ASC_MBOX_I2A_RECV1,
+
+	.has_irq_controls = false,
+};
+
 static const struct apple_mbox_hw apple_mbox_asc_hw = {
 	.control_full = APPLE_ASC_MBOX_CONTROL_FULL,
 	.control_empty = APPLE_ASC_MBOX_CONTROL_EMPTY,
@@ -418,6 +436,7 @@ static const struct apple_mbox_hw apple_mbox_m3_hw = {
 
 static const struct of_device_id apple_mbox_of_match[] = {
 	{ .compatible = "apple,asc-mailbox-v4", .data = &apple_mbox_asc_hw },
+	{ .compatible = "apple,t8015-asc-mailbox", .data = &apple_mbox_t8015_hw },
 	{ .compatible = "apple,m3-mailbox-v2", .data = &apple_mbox_m3_hw },
 	{}
 };

-- 
2.50.1

