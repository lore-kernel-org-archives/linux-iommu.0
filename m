Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1569840879
	for <iommu@lists.linux.dev>; Thu,  3 Oct 2024 03:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727927656; cv=none; b=FnHrTHnHEaxoceVG8hmD3vwU3N2A21DwEW/4He+jEHiIbrCCh0uRvT59HgNwrMJ/TWhZqKujlC3kSYtCkD/Sxj1uy8eKyo2fHQOQB3W5d8/BFF/WoPyWDMIwd4pZNfF/6HjN6il+5KOIS4hul9urj36vktN9GS+wE+hqAFv8IbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727927656; c=relaxed/simple;
	bh=pneaunq42UDCs3Bs1TW/8ZciN54md0YfS4FpuQiIs44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b6lUd3SoLsbvsh7c7IGpHC5o9vl+A2BPRNRDdP9LkfJbGYPlj8qZEpBdkkUTpxWr4XiL07C1kBkE5S93uz7U1EBsXZfgM/Xry+rMMjqFjK23QIQQ8JCSWFg2v4w3fqgxTiToM+9G+VmjzKHDfcow1LqA+BaQPIuipL7WQVUGRfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKmev3C5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKmev3C5"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-207115e3056so3450395ad.2
        for <iommu@lists.linux.dev>; Wed, 02 Oct 2024 20:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727927654; x=1728532454; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cq0XjbGrpMlRn53fkSkj2ZE6QfO3xJ5aVKsySHlaSk8=;
        b=fKmev3C5z0m9hV8fc1xWWgNMZIMmb+MF9CYRIs0xkix9ImlvoUqekdo1ezay4oBmhY
         VBheMeHLCvi0nYKwfOXylhjLNpbXcq2Ooh4A8eiXv/O7F6YPeFlDU9j+AmgngqtjSmIT
         +wr/hHrKSMmtDKDpN8DrEm3nfNuuFnZtnMvlW1qrKJY90zk+L/dtoCLYmNXwSYVdcOdp
         xNOlu3t1j1FE36buwOT8Y87FpAQMZS7ZZB3GlwoYKlQcDgyphg9MLJH+js3LDWjytxYi
         EK+z7OIf1pW9CdwDfmw/S6QQI25QDhjuJVL6oSJoe22OvvEnlBWGXTifbvr/LxyLy4xF
         4qXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727927654; x=1728532454;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cq0XjbGrpMlRn53fkSkj2ZE6QfO3xJ5aVKsySHlaSk8=;
        b=IjuukxQ2Rcp2tFlG7zhG1usavmxbTSZDRt+qAS3BHQZhvrajy08f20XmdPble7okte
         sCAOQ+6bfkAtcCOY3mfphK2x99cyHMKCbIp2PlW/xbKXYDq0X2840OG+Fwd6rHlEv6+9
         FsBTGQXjbZ6Ons9LE14VV7nK64GBbXINeq2PqxAUGd+mgIAw6KSKrA3dUx3Jg6g+a/IU
         rifd7Yjh8Z1dfv7s5koCM/YCNbRBODLxwBwI9pa+RMkninE7VtQweIOgQru/RT/DmTwC
         jKyM1NVCqzfOolP+86Mq5S8LbijFXTHPKYUnBHsYHr/oT384d/afWMefrYNyZhvzeK1O
         Cslg==
X-Gm-Message-State: AOJu0YwiBTJoEH+yiPGho7qn0pNfj0sXaG7sUOYqlCMFblp/pYu98ArR
	DBLNTs4vSi7TfuFp0x1LXzkXqrVkxD4WwrBTutByiJqN3JkGuLBm
X-Google-Smtp-Source: AGHT+IHQarg1wLyg3MVulXjHU7XNbDYC9jQJBTn5bjTS6CS6tyLfUuDFFuLBjAX11JvWqCMk5JvUAg==
X-Received: by 2002:a17:902:d4cd:b0:20b:c264:fde8 with SMTP id d9443c01a7336-20bc59f9fcfmr79593655ad.22.1727927654255;
        Wed, 02 Oct 2024 20:54:14 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beead8dc2sm906115ad.44.2024.10.02.20.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 20:54:13 -0700 (PDT)
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
Subject: [PATCH 2/5] Drivers: hv: Don't assume cpu_possible_mask is dense
Date: Wed,  2 Oct 2024 20:53:30 -0700
Message-Id: <20241003035333.49261-3-mhklinux@outlook.com>
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

Current code allocates the hv_vp_index array with size
num_possible_cpus(). This code assumes cpu_possible_mask is dense,
which is not true in the general case per [1]. If cpu_possible_mask
is sparse, the array might be indexed by a value beyond the size of
the array.

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

Using nr_cpu_ids also reduces initialization time, in that the loop to
initialize the array currently rescans cpu_possible_mask on each
iteration. This is n-squared in the number of CPUs, which could be
significant for large CPU counts.

[1] https://lore.kernel.org/lkml/SN6PR02MB4157210CC36B2593F8572E5ED4692@SN6PR02MB4157.namprd02.prod.outlook.com/

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/hv_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index d50caf0d723d..8c44938cb084 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -345,14 +345,14 @@ int __init hv_common_init(void)
 		BUG_ON(!hyperv_pcpu_output_arg);
 	}
 
-	hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
+	hv_vp_index = kmalloc_array(nr_cpu_ids, sizeof(*hv_vp_index),
 				    GFP_KERNEL);
 	if (!hv_vp_index) {
 		hv_common_free();
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < num_possible_cpus(); i++)
+	for (i = 0; i < nr_cpu_ids; i++)
 		hv_vp_index[i] = VP_INVAL;
 
 	return 0;
-- 
2.25.1

