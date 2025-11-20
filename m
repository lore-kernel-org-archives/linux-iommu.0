Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1550343D9E
	for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763646464; cv=none; b=OPtEAYNJY1FmUHSL/odwbBzO8ZCVp1o6GxRr0r3CtZauBJUwuj3OGJbcGMStCLu5ST+yvM/vvJK9RIAuhgUsgqHXuTYuOOq1JU6po9/WeF15WV22VFkXTFXVT/rQ+xDJiE1T+XLzAy1K1qk58phuaarIDyiXgNKWUDVBDvVAick=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763646464; c=relaxed/simple;
	bh=FOST2SIH8KNu5sFPdASitTj88z2weYmpfxU0ADa/Ut4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ouYaSSZ3+mwJFW9rj+QsgYngFLybrgHe3xELbNj/Viu1RAHm6Pk4jzmUfporxWHfkhFKFZGieNm8a5atslOWVWUJaT1fh91FssKSylaGMfz1IwhLwpGRDgDOmiqzsSYHF6fFOy02ovWa+hpeyaBkSd1OFQ31dBh51wt3wMY+HM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YDf1LxIY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YDf1LxIY"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso8846545e9.3
        for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 05:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763646458; x=1764251258; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A948czYa/5mtbIsBZpYcXkd9XJ+jdzzvonGe4csxiCM=;
        b=YDf1LxIY5vote8/75+nVsj+aVP4HSuPbBdweSE/1nifabdc26UaoAJ2s0EVZi/8b0Y
         W0l4KVr/6o5F9oDvYtgykyrc99xkfUDKmWpusDFO51olYAC8f/M5juAiaLBHoS1bi9NH
         vv+0LFUIa/EAaUS0+KW6x6r/z/zKxFlbHNoKsNFgAu8xkSgH2FPyq0kq1BGwHCY47/uE
         NkrElza9pWx95/+yH8oO1QOh8JkqVjU4mdsWiBVuELJNLixSN2N/L84G8GvxTtn7wO5W
         Tcuie8jjYqJDKPNTCtsxAIL7saEcH1BoNRSLZxYl/YbXf9iJeiUkG+vl+Xm8Xz0Ug50p
         K79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763646458; x=1764251258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A948czYa/5mtbIsBZpYcXkd9XJ+jdzzvonGe4csxiCM=;
        b=jLoEq/Nqx6xfGS3ss6/x2E9zLstHGccOWskJ25c+5aeSTQ9g77cLn+bwqQYBSWp1LS
         FMW5VDzjYAqncwNWuMMAi0tOd2ajdn2P7td+lsA8SIPCXliBRK/++NMP0cG/A59ue3Vc
         mB3Y8AyooBTYg31dXgQox8GJJg1kZlREmJnvwDNgn8kWpcvB+dQzWFD1PJ9XK/gCZ7ha
         RxLKXrtrjeb5b9CqymvCQ4Ej7bnRzw4rPz/hJzfw3BPBJW539MOad2yqLfSgWP2VCXEL
         U140rxr9o+wOvwnDJyDXVhElCcfLxKeUBziKiwFnbZYW2rb8zdjbKMJUf0dJKrQeeXDT
         YCeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS1OazbbN/J77UFZ0Di/sDsLenICQ2ea+J4F+NiZmws0jxs6W2BOz7HR6F+6ObTz52uK7kBA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFikXftxk2sERRT4sLresiSrOPtPBDTpgCbNp/xl5e1LWHXJZa
	3hkDk0yzqsdJCvri+ziJXECWWyrfd8/+VWO/54Xa5sJ1UYs/mq+jo5M8wbUQGNZn9j0=
X-Gm-Gg: ASbGnctjDgHhOUg3nT+atl8N9TvjhJA+aicb+RePENkmZV3tzqmmr48RpqAnf4hmM8c
	0oXAf3wxsMusmgoTPXqhdzMbmXdG89YXHERvBYQ8MVdWeh3Yf3qRu1gSRNFaSJx3UqHOU//Jbvv
	DfyXN1JCZxFm9e5ew8jzCwXtb17/GaESFfLpJAJmO/kLEbffSSg60NO3B+Ja2GzGnI7ARWcBEwE
	8EB6ER1Qit4kJNBOvJlH7gIr/wqvL6W9QhlKEEXzq4dF+ELIjMkOPz86mct29NrNoDTZp+MUsCG
	iWQNM9zQBH/WaD9K46WhmihSoju2zjIPslKIOUL0hiPQq6NkZ1nIRNFXaG3e9yyrpj1kAwcbTYR
	Y3bVx4SzmXXn0UMSsgUueJs3MyD4fne24Z+OdxadrqCeGGUSvJGYBVH6o3ZUoKy/FnVFmI9/2Wq
	IL9bPa8+rd11pIDOCqal39SOvb0NHNRyGuWNlFZydgDEgUxIYdXes=
X-Google-Smtp-Source: AGHT+IHIFwwhuCDej7n/kiB10UzGUUQ69SdWa1m4LkYqLOz7xqjt7Vge2BzyTTaTh7YeRH8lFH7akg==
X-Received: by 2002:a05:600c:3b98:b0:477:bb0:7528 with SMTP id 5b1f17b1804b1-477b9e1a4a4mr30099085e9.22.1763646457798;
        Thu, 20 Nov 2025 05:47:37 -0800 (PST)
Received: from myrica.home (233.226.6.51.dyn.plus.net. [51.6.226.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a973dbabsm67690775e9.3.2025.11.20.05.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 05:47:37 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Cc: rafael@kernel.org,
	iommu@lists.linux.dev,
	virtualization@lists.linux.dev,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Jean-Philippe Brucker <jpb@kernel.org>
Subject: [PATCH] MAINTAINERS: Update my email address
Date: Thu, 20 Nov 2025 13:46:22 +0000
Message-ID: <20251120134621.277272-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use jpb@kernel.org as my main address.

Signed-off-by: Jean-Philippe Brucker <jpb@kernel.org>
---
 .mailmap    | 3 ++-
 MAINTAINERS | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index b5e240f78b8c2..71df089720b38 100644
--- a/.mailmap
+++ b/.mailmap
@@ -344,7 +344,8 @@ Jayachandran C <c.jayachandran@gmail.com> <jayachandranc@netlogicmicro.com>
 Jayachandran C <c.jayachandran@gmail.com> <jchandra@broadcom.com>
 Jayachandran C <c.jayachandran@gmail.com> <jchandra@digeo.com>
 Jayachandran C <c.jayachandran@gmail.com> <jnair@caviumnetworks.com>
-<jean-philippe@linaro.org> <jean-philippe.brucker@arm.com>
+Jean-Philippe Brucker <jpb@kernel.org> <jean-philippe.brucker@arm.com>
+Jean-Philippe Brucker <jpb@kernel.org> <jean-philippe@linaro.org>
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> <jeanmichel.hautbois@ideasonboard.com>
 Jean Tourrilhes <jt@hpl.hp.com>
 Jeevan Shriram <quic_jshriram@quicinc.com> <jshriram@codeaurora.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index ea8194ac8970d..4c398e6cfd24a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -388,7 +388,7 @@ B:	https://bugzilla.kernel.org
 F:	drivers/acpi/*thermal*
 
 ACPI VIOT DRIVER
-M:	Jean-Philippe Brucker <jean-philippe@linaro.org>
+M:	Jean-Philippe Brucker <jpb@kernel.org>
 L:	linux-acpi@vger.kernel.org
 L:	iommu@lists.linux.dev
 S:	Maintained
@@ -2244,7 +2244,7 @@ F:	drivers/iommu/arm/
 F:	drivers/iommu/io-pgtable-arm*
 
 ARM SMMU SVA SUPPORT
-R:	Jean-Philippe Brucker <jean-philippe@linaro.org>
+R:	Jean-Philippe Brucker <jpb@kernel.org>
 F:	drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
 
 ARM SUB-ARCHITECTURES
@@ -27242,7 +27242,7 @@ F:	drivers/virtio/virtio_input.c
 F:	include/uapi/linux/virtio_input.h
 
 VIRTIO IOMMU DRIVER
-M:	Jean-Philippe Brucker <jean-philippe@linaro.org>
+M:	Jean-Philippe Brucker <jpb@kernel.org>
 L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	drivers/iommu/virtio-iommu.c

base-commit: 23cb64fb76257309e396ea4cec8396d4a1dbae68
-- 
2.51.0

