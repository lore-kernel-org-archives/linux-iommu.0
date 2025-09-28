Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A8454918
	for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 07:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759044418; cv=none; b=WLpCs6r4HRyurAZCwTB3w3AlCOgBvCHyKJmOwNCGU64t5RkhVSCplhqnADR8qU0vymD4SY2FhTYVnQTbv9QZqyY4zwrZ/GzhWz57DFcwtafUzpz2jXGhMV07gaE60ANTz/cchFZzNFqh3Uku5UknO0+yx4ol2TFKLUlRlaS1tlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759044418; c=relaxed/simple;
	bh=/SdbOeTbQpmJeBG/7uKnsxaZCMB9be//TsCeMES2BBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aid0TnSqd8TFN9bDaJ5q/BSLWgz4pREB2QYQkkNep8LcUbnJWM8pBxTjOd89uxXxPtOa/RuhdgM7sGSJ1ZoqFSe6zzTdAvwMExdMFc+gYQ6I8jyuh7JK0NHwy/9afNkKvcQGKCoOkZD+xrXftrj4V8QBdxTcbB5TH0c9o4yrLiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VCMWSFK4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VCMWSFK4"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27ee41e074dso30410195ad.1
        for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 00:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759044416; x=1759649216; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UAaSdOVkV1NKdeMiOYB6QGMYFLsTHfIsFJ3zeJzXSPE=;
        b=VCMWSFK4kfJhRHskYWEqKP0GrPXl+vP1WFEGL5WUQbnPt92CC2/8PhuJ9C3MhJezCY
         qdY7UCzT6pyLt+U3b3zyjVMHHBU0BNOiQjkZFD8AcxxpRA3nEkZSQ9e8EEhg1xOHwYf0
         QRUXu0LcSOzcfIf0ChnBvV1zjS7tU375FL+kLVjS1d8vL/ko26AdvkiIqIoGctr25Qp+
         SMBbRUQZjxSk9NM+OsG0ha2tEhHbzyqMBDMqlyUUBe+eIL8M+nHNaxWQAOSvwv9XW4SB
         okIVJC2sWud27s2Lptgfce4eRXWgXGhGzSIkl6VLaACnRHv9g/pOuDvl2Vo9HgAarafD
         gAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759044416; x=1759649216;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UAaSdOVkV1NKdeMiOYB6QGMYFLsTHfIsFJ3zeJzXSPE=;
        b=RrapmRCUTErfYyFXVMM13/LoLzLZgI+ANrcVrZYvX7VFexbz/j5wQ5ZMHqr0RIauWF
         jP2C2gMYytOgU18WqwjrkZ6w9pi7ZU/qVq3X6nh/HNehhGIQH3Qqa7lvtHg7OPFKkbhQ
         i4O+1eHlz7Lxkr1PcZlfbrPyQCdT5eNsUWUxvTArOMMH0rRoP+6tm85tV/HZ6K8cw8Y+
         LT+kP+wXQUyeItJVmgWWRrwY3UTmB+yVx8IfTUHWur4lhvoZ2AEPxce9g/1SzmEU3H9o
         Xas+Yco6+deiLBa5eohUp6KN604I0RPVLIng3nIpTEe+2/0dtiZD16U8AYCzWV97bEiN
         J/Ow==
X-Forwarded-Encrypted: i=1; AJvYcCV/8IkyNoBq1OXY6oQerVkT+iWBVzlxQjw/D3EsA0UWA+0YJHTEHgbD99nNDUm9qTCSzbnTdw==@lists.linux.dev
X-Gm-Message-State: AOJu0YymA7MShsjolhxEGevF691I0z7RGvjnKNZWSZIml2g+h7y5Zx5P
	cSA0lxVrRDhiZZw8t1BKdc/VRkxTn34kCJluCQ3Z8EQUnynu1wuzI+x33uDQ0D2o9b0=
X-Gm-Gg: ASbGncs3Wzh7M9fcvK03eCcWsdocyBtEe0pjTZsYGuoUG3qZncoIGv4UsCaGFRdzywe
	/X7BBvwQOGXstASCV/HlOvo1JVSooRfJhQFIb1Bhmq/TXryPTkxw4yLcgTdK+x6F2RstA2VdA6V
	kUgC2a4JNuVwBEqilj53ViIsTgjzzHsMRA0C0W0auAqZljFd5LmuVZvtBcHUZClEu2ZXzacaizW
	K5ydbiCkxG4Kqg+1R7dgFi+GbvsTl9W0bVl6rM/LZwgybAAf21PzdvLvCWu4De5RzYeIQjk6o5S
	/BLZTb4t7spLDFyxMvL6iEqRiSCPtJchEkUkGgWme09T7iXeWxbDjfoMtKbeRSEzWtH36gx+zu5
	6i/dnC+P7Svm3G5G2fsViix9S2XEjNwnVfLxlxYRIoN12Euh5hk0NSl1NT4X7woOFWto=
X-Google-Smtp-Source: AGHT+IFHxe1rBHtIpqSjLfdUIUmkMST8JmIBra2PbaznOWAXLh3kC1g/w85xIIVUn0jBe/mif/ikOQ==
X-Received: by 2002:a17:903:17cc:b0:275:3ff9:ab89 with SMTP id d9443c01a7336-27ed4a319a1mr130543335ad.27.1759044416495;
        Sun, 28 Sep 2025 00:26:56 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d32dasm98492675ad.27.2025.09.28.00.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 00:26:55 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com
Cc: guojinhui.liam@bytedance.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/amd: Enable PCIe ACS once AMD IOMMU initialization succeeds
Date: Sun, 28 Sep 2025 15:26:50 +0800
Message-Id: <20250928072650.1419-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250928065817.1279-1-guojinhui.liam@bytedance.com>
References: <20250928065817.1279-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Date: Sun, 28 Sep 2025 14:58:17 +0800, Jinhui Guo wrote:
>@@ -3212,9 +3212,6 @@ static bool __init detect_ivrs(void)
> 	}
> 
>out:
>-	/* Make sure ACS will be enabled during PCI probe */
>-	pci_request_acs();
>-
>	return true;
>}
> 
>@@ -3284,6 +3281,10 @@ static int __init state_next(void)
> 			ret = -EINVAL;
> 		} else {
> 			ret = early_amd_iommu_init();
>+			if (!ret) {
>+				/* Make sure ACS will be enabled during PCI probe */
>+				pci_request_acs();
>+			}
> 			init_state = ret ? IOMMU_INIT_ERROR : IOMMU_ACPI_FINISHED;
> 		}
> 		break;

Please discard this patch. It breaks when interrupt remapping is off.
