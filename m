Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FB328373
	for <iommu@lists.linux.dev>; Thu,  3 Oct 2024 03:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727927655; cv=none; b=MalTs82hMBs4dHfEx558JbVBur9UNlcdFfYNFNFEnE3++7DzfYJrsX+iIJic9QLpWxHTmoNPpPA8WyUQpoC7ukhiEy5hjNAo4HXEs2Vi7GCQEoGKQXRjRINDPEEAFmD0VtkapZYDPtwjZa9VXQ72DzV21WaZPH65Z79I7MdiVWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727927655; c=relaxed/simple;
	bh=Ls1umv3AoV9OAW7lcwxqmR9VNmxVlUZafJfEKvveDpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=de+F3V1dKtp4j2+y64Bn0/r2fTa8K+PuNREgDyim2hE9TKlxQnzsWOthKKVcYuhzFAauJ1UPwxkg3VBjmyfTPO1TcgkEQk+2qk9NmzShXxynKpadYHjvZebvrCV8KueMdFVnXkVEk8rgMkBupb3sWQqi+2euQ9zkDg24qhoGdCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwQhaqJ4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwQhaqJ4"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20bc2970df5so3155095ad.3
        for <iommu@lists.linux.dev>; Wed, 02 Oct 2024 20:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727927653; x=1728532453; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rl3DJj69ip2vtdwvZRZRwJS0N9IcEuELubliNXpPJz0=;
        b=MwQhaqJ40tTxiL4gDPlHokvBrAT2yD45yhIqJNJ7he0idHqhdCdghkL+SEZD2nxHWL
         Z4bRTGIYl+r0aSoDoQunwZaCEu5uj/Nw9BgjwDvRgIWpguF9+nPi2nTR970XsR9Qbpzn
         dh13FyV9eQdedvvE3XRwVm7mYIdTQ97WD4Bqvrc5Iodbw46vhFBqkPzPqI+R6Nc7xGn7
         xHXpeHbjfHvJfZKKj9qHpLYEd0/GUge3+Okl0wGn2t4aG9DZe/5TaHagvaGb1WlpRPJk
         q2qDiVDPE293CtqHvH/RGgpcRg04pMx3JOQJMf0mF3bCKZp8y7uE4MzxdlBS2z2EV6wq
         3xPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727927653; x=1728532453;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rl3DJj69ip2vtdwvZRZRwJS0N9IcEuELubliNXpPJz0=;
        b=fXGcIFjO8yvTngdLfcvEPi7MXR/rFjTg1UsbhqbC6Tgch1EwKD1lt3wnLhuqRz7Zof
         E7KCBklLU4t+E5FiFoB2D/1Ss7BKGDS2r7qPfXZwA7ppSXDkN4MGZSAZrB47eBMydhHA
         PHIcN6nntbqQDll9tVC0hTU8lZRNjHjXR4F879Iz2Yj/m9y1s6pn4YJ5xv0No8sjiMiZ
         XnJIspc7V3TOo147EOrkb5N0W2LR1V0XGjgRejkBDTTn5w4Z5+vkRxw+wau6sj5iFkOv
         JR9Eez86v3PPn/M8iQFYR91QeV0jCqWIhFLyiIBnS+zoCDM8neqqp/AQ+iT63N2VrVQ+
         xTPw==
X-Gm-Message-State: AOJu0Yw7NDaycjwDn6z5nINAkltyrpLWpe0Vbm9gBzvKdryjdk0cmMGg
	o6rEfSTq8UYIhMweRAYPCEfIqUc0QFl3Y+dB5shyw1EHs4OQ0lzJ
X-Google-Smtp-Source: AGHT+IHU9fSIrpIZr2B/Cle3Jn+UyUSHLNjXtriJssD67baJWW1ZC7PtSkc/R6T/Z0ZRvy1RrGfrSw==
X-Received: by 2002:a17:903:944:b0:207:6e8:1d84 with SMTP id d9443c01a7336-20bc5a4e9d2mr68426335ad.42.1727927652878;
        Wed, 02 Oct 2024 20:54:12 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beead8dc2sm906115ad.44.2024.10.02.20.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 20:54:12 -0700 (PDT)
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
Subject: [PATCH 1/5] x86/hyperv: Don't assume cpu_possible_mask is dense
Date: Wed,  2 Oct 2024 20:53:29 -0700
Message-Id: <20241003035333.49261-2-mhklinux@outlook.com>
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

Current code allocates the hv_vp_assist_page array with size
num_possible_cpus(). This code assumes cpu_possible_mask is dense,
which is not true in the general case per [1]. If cpu_possible_mask
is sparse, the array might be indexed by a value beyond the size of
the array.

However, the configurations that Hyper-V provides to guest VMs on x86
hardware, in combination with how x86 code assigns Linux CPU numbers,
*does* always produce a dense cpu_possible_mask. So the dense assumption
is not currently causing failures. But for robustness against future
changes in how cpu_possible_mask is populated, update the code to no
longer assume dense.

The correct approach is to allocate the array with size "nr_cpu_ids".
While this leaves unused array entries corresponding to holes in
cpu_possible_mask, the holes are assumed to be minimal and hence the
amount of memory wasted by unused entries is minimal.

[1] https://lore.kernel.org/lkml/SN6PR02MB4157210CC36B2593F8572E5ED4692@SN6PR02MB4157.namprd02.prod.outlook.com/

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/hyperv/hv_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 95eada2994e1..2cec4dfec165 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -473,7 +473,7 @@ void __init hyperv_init(void)
 	if (hv_isolation_type_tdx())
 		hv_vp_assist_page = NULL;
 	else
-		hv_vp_assist_page = kcalloc(num_possible_cpus(),
+		hv_vp_assist_page = kcalloc(nr_cpu_ids,
 					    sizeof(*hv_vp_assist_page),
 					    GFP_KERNEL);
 	if (!hv_vp_assist_page) {
-- 
2.25.1

