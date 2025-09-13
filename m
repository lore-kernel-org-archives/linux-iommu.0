Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181072DC790
	for <iommu@lists.linux.dev>; Sat, 13 Sep 2025 01:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757728228; cv=none; b=Biv7yCwUIFONTfc62qbE8lrITf3r6DG65tcITzWLzSJzuR80f2PvzmHTz4RSy7AjEfqkHQh9c8YQL6dV6x7emy1mZwEvAE7y1VUDYDbMHBI38Ltp8GTfY4W4tjs/pdvhmhQwb3TGCGocfvzyoL4nOd6zPC4oHyc+QYzWTY1F9Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757728228; c=relaxed/simple;
	bh=2pke5B/p5bVW7/W1MvtdA/qNec59UAGg1/Stpd9ULMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R+qlsDsFbt2eHlZHnOW+ksZ0MRsziXoavB4I356riA6ufg4/MhpE57O+s9bnr9cr2pY8ySSsNRlFYU1/VsVkR83mfV8Sg72NrI9B0/6Ekcy5TTKGoljO+S4nALkouVTiKeE0iJuH+A8RqdQPG5vxIHGGpSBbsrtgx+MyHVruqqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJ7citVl; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJ7citVl"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-724b9ba77d5so25493137b3.3
        for <iommu@lists.linux.dev>; Fri, 12 Sep 2025 18:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757728226; x=1758333026; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FCdKJTmqPYMwrtPghr4e9bj7Z7fRlbmOYuwXpg8nHMo=;
        b=ZJ7citVlon6a4pUZDkboR0sSxRyK9LS8LsDEIu6yb04QSHeEIFhtok+ZrDi2oFtHGp
         f1sYM/zWH2UiJc49ATffEWS9Ryq1GwGTyPybxp9RaVWJgcPTJ9d4KAvrIWz/Hx/LgltQ
         pqm3fxm4inZPZjMoeUeEICEvR6gvmCPfX1nBg6FXxsmKnaXkM52eV+9S8Ci9vRk1fp04
         8wyYUwfmeFNbHHP7qPmBTvZOvnIX9pQj7eO+4VJnZWjy2xgyZwoVGb/N8A8w37xPRv+s
         UXMc8Rbkn0Mx1vEO34HgOty0CfPi2VBRfWUHz79bxnJwDaDnn/FCPJa5fHyos86tyyIp
         Hw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757728226; x=1758333026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCdKJTmqPYMwrtPghr4e9bj7Z7fRlbmOYuwXpg8nHMo=;
        b=Ziz2R3En1JgbunULq8YjVW1oGC1XJreLh1h5B/d2KFpBHDMphy/JyiWQFedQss2NoS
         AhVeqhn5r6p9fb7gUePSceQzZEElPPf3aelPqOryH4p+19vnJjZMb9nc4s8OOJhQXgjt
         wLRiLGJuZbzecbi3Zo6np9Z5GdOrt2qpDlEEXYvoHApiX2nADA3M/XX3bL7qB05b3eoe
         2DRoeJ18ZeOIv8XJO/Vk7F/DDeleBU6/Z373PJ/wqhWt5MC8tMZ7ciefpHBuld97eq/3
         Xu/GmfKCP6ijeHEVp0Wi64v2qNJ3iy5Q0fjyWSe/56L9XFQFVYNZGkcJ08/zWNAq/sCR
         5TSg==
X-Forwarded-Encrypted: i=1; AJvYcCVjDGTk9xfTU+B9cukcA6NPHk+6Pw7aKSXurlMzeIkm32X5/dlOhdq+yHMo95EF49JvnYfGug==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQp1Eo4Dj7Rkl8vctmYZTz6neDbyw/g12ItqUUX8JrqLkFMRdU
	yh6NINhpGOlJFf2iCEZKMZ7IozXSCw0EMbcEy/geK13kEaEPNGK1AX1q
X-Gm-Gg: ASbGncsQ1mKKj60KBLJpOHlqOCB+SiGB/iKmibAuG3NQ3NiXeLTCMcFKLdFIFSXpRzu
	+NLVbSja8KHPJaMCw2a8pRdGQ4thxjqTP4NhXfrgx2XFO5KhLeoHrpdwe7s978ZvLTDL+0G6QmK
	86fSAxsgStMGyhHAw/IvvJKwXx1HU0eQbcOqy063Luro+corAWa5+9sjgG1qArvCCyC5DgCp8zw
	H+GuZ12+aecvXOWDloI9QPTQqs2D7U3yI2qDa5ReLWI4e+rq8ZoGnt02nTyPWrgJifjeslfLWyh
	nl6y67kot0I9PthYU5Edlx/msVWuzD30OA256k402h3vuRwQh+v2Rsq58aH5R4wUzb1xUwo/hDr
	Yjw6H9gM3HsPwE62fpzqLlFH3HNLyyxESBBKYk7CFX8lUd33YWldxGG1kQQsV+VwnOc2I
X-Google-Smtp-Source: AGHT+IHehtPMabakdBlT4r4MpAz+SoWip48LOcYZTX3KzIq+FCBVwHZSUk7DZZyPa3li/g16NWNY8g==
X-Received: by 2002:a05:690c:630c:b0:730:5445:4b48 with SMTP id 00721157ae682-73063191249mr38954027b3.7.1757728225919;
        Fri, 12 Sep 2025 18:50:25 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-73088a76fabsm9987867b3.26.2025.09.12.18.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 18:50:25 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH] iommu/vt-d: drop unused cap_super_offset()
Date: Fri, 12 Sep 2025 21:50:23 -0400
Message-ID: <20250913015024.81186-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macro is unused. Drop the dead code.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 drivers/iommu/intel/iommu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index d09b92871659..7da1cf88ce80 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -173,8 +173,6 @@
 #define cap_pgsel_inv(c)	(((c) >> 39) & 1)
 
 #define cap_super_page_val(c)	(((c) >> 34) & 0xf)
-#define cap_super_offset(c)	(((find_first_bit(&cap_super_page_val(c), 4)) \
-					* OFFSET_STRIDE) + 21)
 
 #define cap_fault_reg_offset(c)	((((c) >> 24) & 0x3ff) * 16)
 #define cap_max_fault_reg_offset(c) \
-- 
2.43.0

