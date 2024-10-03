Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C838003F
	for <iommu@lists.linux.dev>; Thu,  3 Oct 2024 03:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727927659; cv=none; b=tg6RiBc7smN98q42bw9Honq0SBftxkvjR/5cS0h47nSTlZBRSd2aaENdJO/QsNOQg96qBYzbjgysewntiv/R3PSttElAi/YxUunV2oDLlKUHujP4NFEU63s0cZUB99rlRflHr7035oSFssBVcEHlp/hXtujs9mlUl5aoCWhiYpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727927659; c=relaxed/simple;
	bh=x6Zn7HjTzGMYc9FJ3+apAp57nj/OHxiWOSQMFh0tXkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tz5xhfQdxw25OIO9pai9tBrngx8qr3owHjxdKoSP/J2u8ATZmCSGbU6qjUqS8PpSW4JiZFVXIIflrrsXaz35Im7E1VtRbHf+K4cRBUHlTgSSdXt4E1lhlmcYsKZTQ37o3Hs2Cqpo9+fpuOa3htqtgBTFCL9NqbOElZAsJRYcnNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRfaZtFV; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRfaZtFV"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b58f2e1f4so2693045ad.2
        for <iommu@lists.linux.dev>; Wed, 02 Oct 2024 20:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727927657; x=1728532457; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DIVjY9QXcz2STFKs3TT5rFa2kP9kKUnHMheJi7enQS4=;
        b=BRfaZtFVJPp0RbFbSrpiCENkkOhNg4pVU/bQQhpg+Ve8uyuyMhRhsaPMxsRuLMzvpH
         81xL6HuFjo98CdkbRq575Oauai8+8jDUe+Uq53kT5itTgAj+PLtFHMixUOZY5ssHR6Xe
         5bTyONMDzZ+kb8cGm3VG3x/KEv5xqPUMXD1JrQZaYdx+Ebsq7cG7TBW1Snc5qV2XqcX3
         7deHf06L+DddjCsThCTDKX8w/kCO1wx/fz9ToQcBmyMNiYcJbpP/eSaZXuLWZuLGzXlm
         ssNj/ryEHERl1aqDhXPQ0urmae8KhKJXfogcMhC1onCrB99QqDop/pxKGeJjiOUxZ36Q
         lbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727927657; x=1728532457;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DIVjY9QXcz2STFKs3TT5rFa2kP9kKUnHMheJi7enQS4=;
        b=umqGClVq227DtCMBMTHvw7XwnHtUq0IUfHXejwJVqRtQgkPysmkiui1E2ycDXvAXkU
         RFtqw61UJ8lX4mj7xj0Hth8V7Mb4Yc84PD3471E1fxng3QfA06CM5te3VdFu8YLv0RSm
         CHJ0XoAJyWSJWNAtGtdguaOpm6YQt4h08pks4F3+GklC3Nm8okQC1VPw1C6p8W8icfpr
         kKA+q8p9fwIeFuPoOYG662aGSJdQ1PVth1sIqvkzeNaY5rKspp2XJKyDgsef7kMdFVix
         lcWNwRW99dIhsXniR/A5WZUZTvVoJVssn73jkhHO3Gdl65eK3xYHpBxMgV9Yef7T2rsB
         mXpg==
X-Gm-Message-State: AOJu0YyriDbV2e9EnP2ZmcONyRyWJaG54k8vCLTh6plc4nT/1i/CAizK
	muzHeMWgr3M1oGXi7vpt8M5+WXKUkBc11GeYbVYxpTY0MP6Cw2pb
X-Google-Smtp-Source: AGHT+IGYAsSvN1ppKu/WfTnxiRO2Z7TJtHRQQ6nzYxEJteJVC5HlpEBwNUkwvfBEkQqK2Sk6/i2hLw==
X-Received: by 2002:a17:902:d2c5:b0:206:ba20:dd40 with SMTP id d9443c01a7336-20bc59f4da9mr80367265ad.27.1727927656951;
        Wed, 02 Oct 2024 20:54:16 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beead8dc2sm906115ad.44.2024.10.02.20.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 20:54:16 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com
Cc: iommu@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 4/5] scsi: storvsc: Don't assume cpu_possible_mask is dense
Date: Wed,  2 Oct 2024 20:53:32 -0700
Message-Id: <20241003035333.49261-5-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003035333.49261-1-mhklinux@outlook.com>
References: <20241003035333.49261-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Current code allocates the stor_chns array with size num_possible_cpus().
This code assumes cpu_possible_mask is dense, which is not true in
the general case per [1]. If cpu_possible_mask is sparse, the array
might be indexed by a value beyond the size of the array.

However, the configurations that Hyper-V provides to guest VMs on x86
and ARM64 hardware, in combination with how architecture specific code
assigns Linux CPU numbers, *does* always produce a dense cpu_possible_mask.
So the dense assumption is not currently causing failures. But for
robustness against future changes in how cpu_possible_mask is populated,
update the code to no longer assume dense.

The correct approach is to allocate and initialize the array using size
"nr_cpu_ids". While this leaves unused array entries corresponding to
holes in cpu_possible_mask, the holes are assumed to be minimal and hence
the amount of memory wasted by unused entries is minimal.

[1] https://lore.kernel.org/lkml/SN6PR02MB4157210CC36B2593F8572E5ED4692@SN6PR02MB4157.namprd02.prod.outlook.com/

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/scsi/storvsc_drv.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 11b3fc3b24c9..f2beb6b23284 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -917,14 +917,13 @@ static int storvsc_channel_init(struct hv_device *device, bool is_fc)
 
 	/*
 	 * Allocate state to manage the sub-channels.
-	 * We allocate an array based on the numbers of possible CPUs
-	 * (Hyper-V does not support cpu online/offline).
-	 * This Array will be sparseley populated with unique
-	 * channels - primary + sub-channels.
-	 * We will however populate all the slots to evenly distribute
-	 * the load.
+	 * We allocate an array based on the number of CPU ids. This array
+	 * is initially sparsely populated for the CPUs assigned to channels:
+	 * primary + sub-channels. As I/Os are initiated by different CPUs,
+	 * the slots for all online CPUs are populated to evenly distribute
+	 * the load across all channels.
 	 */
-	stor_device->stor_chns = kcalloc(num_possible_cpus(), sizeof(void *),
+	stor_device->stor_chns = kcalloc(nr_cpu_ids, sizeof(void *),
 					 GFP_KERNEL);
 	if (stor_device->stor_chns == NULL)
 		return -ENOMEM;
-- 
2.25.1

