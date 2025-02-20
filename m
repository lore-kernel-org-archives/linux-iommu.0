Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937541F03E5
	for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740046540; cv=none; b=hR602Z5oXWqRa2qdJmpN28x38BFlrSzPA06K6HAmibdcx7o1riq5NIFldZ7PNu7HwoFL9jxCPuHN/V3uEXnOQCptcTO3U/6/gjCKgPpfg9hl/Gp9Os7BzRwqSyUg5Tnr+RPXV7t9TlUDxrxuL4JsWgmCnumxUgn1k32UmleddoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740046540; c=relaxed/simple;
	bh=AwGIoFXUjlmwWgvEOb+I3Dk1NKxMqMQORiC+Kje6l6g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PLlJ1dAi7YKdGHGRAV6zsUZwlQUJg0nvz/RCQQU1dHpH3X2gEIP8nW9Oddiqfg8KBdOBHlT+gTerrNjxpjJWxzg3WIPs7DLTf8xEC9hsX3k6xR1TbCMhdfHqL7xm7gKczcOgpOELDPB49tdgY5AKMLoyYnfXqQzEetQK6ntbbx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bPG+3Bt0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bPG+3Bt0"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2211cd4463cso12976165ad.2
        for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 02:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740046537; x=1740651337; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fi6x8ig5ZwKEmhmgwjg3TF1oaUzfpPBZi49wWEG256o=;
        b=bPG+3Bt0USv3gCMQQ28ZwJBon3hlAdPGCLUfWZdn2tJNNJnmqHU5jdUIDpwt8R8gZJ
         G8gFP7MIQTPDYc6Hw+mwoMM7nH1CROKpjjCKfOUTCR4+nDlhz2F7uGh176qohrDhimpO
         dLCJn7sXBldSjL4lgQB7zNHVQFUUgTufCG6JLz2GeEKP2FzePTg6+fZgW5qM1wJs18j3
         VVQ2o6xfK+YOOqH53AErNJOnu1wVaZZlAh6ueFxXQKPZ6rUVm9wItUMah7tYEYJ/0Afl
         ftY7ysMKKLdsc9ia3glMoG9t8ARuSsam9Fw/TbBn4dNNzpCax2LXjozLUVj7BOpo4G0O
         pHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740046537; x=1740651337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fi6x8ig5ZwKEmhmgwjg3TF1oaUzfpPBZi49wWEG256o=;
        b=G9eofKe6rVe9fkWS5jBNd87WheYCSgH8RuuMa5EzyVByTPSssxRRiF43mBDn6ERFtH
         czckuGSCzILDAiMJN2QrxyHtGs2HAp7xpJukdXeKwQ+CeY0ls3KrVg0Kg0l7gX/zUhQx
         cBIzAHx2C4LCK2Kdh+VVsZn+/4qjOZv7tl5nlcvnJbgANJxF+U01qOJQi9nD4kpbeGbQ
         EGtjBwquxTvMb2zhpOnw/Ca6hDNhvwzG73kPZnP1czjblFdE4Yv+SeM6EYb3fZ+mwO5g
         bBA9jsK/WDgONaVHorMVxKigxSW7Sc2ggt+I1PG/QkeMYjDZkxa7ZIAUF2WVrCIR7Dpj
         JTcw==
X-Forwarded-Encrypted: i=1; AJvYcCXIBs2smWBkpSOsRdprT8O/k62X7qw3awg9IGn+pxaNFplOtNUr5990tB5lsuTnB/wlojIQwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQzHhd37MKSWRLRB5wZVilrRJhRRKp3FSAc8/fw5R0P5+zKGvU
	2awC8qkFDSUA/f8+7HMpkIlCsfc8QkHIRoLmfaWBVY0rHInzZ19G6MGF9RJPCq8=
X-Gm-Gg: ASbGncuutTKvbd9dGqZWAWlTK2k1SN7bfMQJDSTZgKRETxMFOViPdr90VreWQuZ4yqs
	ECqQ8wRiZOENexUlxZZwwT+YAV8wqN3uVmysNEElIFhxnynG/jhsaz9fLcVCkYsef0XDq8nmDNV
	12VKyk9tvNcnPdPLONO88mamhBp7DVpv3lsQqP1V10Mr8bjTA/lxI6qITaUdA4X8lVMWuCk6pdy
	fEzRnQCB8AJnAiStz+WLYz7ysCA8CrLEBsQpfXE6+Ee2agwT11qTVt0UVCxK7a0ZSW3EGcnkwQU
	nRMy+0UkjBZKTAP/4/XJXqy2NEcRlbNAoRGwnmoVI8wtKxVOgg==
X-Google-Smtp-Source: AGHT+IGr555DXR3ZVGi1n2qebDlBxN4jaHy47hIUyefBd3dK1itx6GoA15111YZSfPrtvWchGl6xUw==
X-Received: by 2002:a05:6a00:124f:b0:732:5935:c219 with SMTP id d2e1a72fcca58-7326177d652mr37845583b3a.3.1740046537505;
        Thu, 20 Feb 2025 02:15:37 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73271a02648sm8707518b3a.107.2025.02.20.02.15.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 20 Feb 2025 02:15:37 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH] iommu/vt-d: fix system hang on reboot -f
Date: Thu, 20 Feb 2025 18:15:11 +0800
Message-Id: <20250220101511.37602-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When entering intel_iommu_shutdown, system interrupts are disabled,
and the reboot process might be scheduled out by down_write(). If the
scheduled process does not yield (e.g., while(1)), the system will hang.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/iommu/intel/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cc46098f875b..76a1d83b46bf 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2871,7 +2871,8 @@ void intel_iommu_shutdown(void)
 	if (no_iommu || dmar_disabled)
 		return;
 
-	down_write(&dmar_global_lock);
+	if (!down_write_trylock(&dmar_global_lock))
+		return;
 
 	/* Disable PMRs explicitly here. */
 	for_each_iommu(iommu, drhd)
-- 
2.39.2

