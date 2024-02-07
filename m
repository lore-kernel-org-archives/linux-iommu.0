Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D837A713
	for <iommu@lists.linux.dev>; Wed,  7 Feb 2024 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316713; cv=none; b=n0sdV3On0gfi7RqIMyP5HBdto6ckH9cvNMe3wfrBv1qhyFxtJzSYlta88VKgGdnRf/Z/PJqHf8/s/ZwZgl34zucHeSv4ATMSDJ+NIrrN+ZoM3PB3HH1ZQigkIthReIX7MqKHe8jVFNBL165azROVHxsPvHzppdKtPPKKHVR4ooE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316713; c=relaxed/simple;
	bh=Y42qZrTeT1zrticJCI2eB78hvcGQgoC9z0KtHukNgEk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Gu5nnZwBWdaT1wE0dSkSShDAvED+04Bu880XNlVq67iB9TQ53T6xSrLa35hRvZxs6t7ACOsuHeWBguXtx/cGnX3BZ5Cd3h2CSOnJnB0oXoBZzqaQL6DF4Wim1KoNG0zWZROXNmq48Y25mRr4JyEGtIaojk2gEIqPeb57+cTMpE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgRvyHMQ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgRvyHMQ"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2a17f3217aso86098366b.2
        for <iommu@lists.linux.dev>; Wed, 07 Feb 2024 06:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707316709; x=1707921509; darn=lists.linux.dev;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lE++2qVcHW+CEBtsbdN8eH8qiiSu+9Mbj56gyVDwMac=;
        b=ZgRvyHMQy+0eVARmsLZs3g2LApjXozy2TVrautuWL6umzmMl/qvyPxa+NrFInWrebv
         C15Oe4RJXZbsXIQqDv6GhKoS/qFQFPELtTMpv2NywhstWfhdxEJw01nY4b+rRJxk9JWW
         p8+Eu0+yxbjTJO3Rk+9WhvMFNWP7VASsC6N970gEeNIWHJGUOYnbNJnwaIE2evnEksQ4
         0k+eaLmdjo6KhRY5KQInIbuqrNF+rzoOIFrI6wqfDUtyMBVS+GpjQxgbDiGV5KKcAqQG
         kNaI2jfSUgymYI9XB12Wc4wfGBH6Za+jiNUH4rCswOHzkK7UwCHeNB+oIluREFs61onX
         Rqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707316709; x=1707921509;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lE++2qVcHW+CEBtsbdN8eH8qiiSu+9Mbj56gyVDwMac=;
        b=kTKbZp4Z/vhEt81A337Xvy033t+edel5CcpZGget9KcFV704Pa/cRek7mvliI7Kpy3
         1UIKIP3qu+/DoKD0iJHvBXAUUGCLrE1amY4PUwzBDpgBppfk2deUBkxBO9aKDVC4B49A
         z4CGtyGy7lpe6UwCKCJ7YYx+CjYCvhdh4Rt8Eaj3Tqh16QkGP0ttwxhky6A6aOqBYrer
         KdJ+kDcMKyqFeIy4y+lASRjeV3TdHVG/2TuSMFSr+NIi/gCRgcvyCQbhFML3m+GiRkZv
         bdIaQdwu/FCLQOEJjdecgtziYfeRpmKVJdDmSEzeWPAMc8FesiQBrURdgVU4YxeiZz1n
         E2Eg==
X-Gm-Message-State: AOJu0YzCzTu5PGziJuWY6ac28PqbdIrC0ylbxsDbqhWrCd1C70HwggJg
	SH9LnUzRsQyMJGGxYz31tVQblgCOf9g3Cj8uO0iipOFq79UF61Rb
X-Google-Smtp-Source: AGHT+IHZ/o2nyrH1w9/WKrRaDNSV5U88ds7/ilsdYSb4FQ5tw2TG25fyjXJ5DGd3biDOaR4ubXWj8Q==
X-Received: by 2002:a17:906:1c5:b0:a35:103e:3614 with SMTP id 5-20020a17090601c500b00a35103e3614mr3841031ejj.52.1707316708889;
        Wed, 07 Feb 2024 06:38:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV1SGCkbFbH5np12iRMTSf3C23VaNyd1pFuBYbaAmdRdkAf7nHEAwZSaqxOWBF+hPrdUQunP/Th/RSqYO6stTgL9/XL6PoB08KvQruhpOOGgEDUM4vK/OtGz/ebYpuGnLUW4K432aGsSTX3ADljRzcFogfQUNj8mzlxV39Szh2T3A9bDoJAI1M2vAxWNRzR/JHpfnREjymvB0B/VuhOLvpEN9uB8IHL48zDAqxlFAfM4baOKxYFfMYmtnXECNQqGBNCpVgxOWeAepvc+Regj52iX2ez
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:81be:a476:88e2:db23])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090699cc00b00a35200615d7sm820909ejn.1.2024.02.07.06.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 06:38:28 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] dma-contiguous: remove debug code to removed CONFIG_CMA_DEBUG
Date: Wed,  7 Feb 2024 15:38:25 +0100
Message-Id: <20240207143825.986-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Commit acc2f3e42d4a ("mm/cma: drop CONFIG_CMA_DEBUG") removes the config
CMA_DEBUG and the debug code in cma.c, but misses debug code in
kernel/dma/contiguous.c.

Remove this dead code from this removed config option.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Andrew, please pick this minor clean-up patch of top of the commit above.

 kernel/dma/contiguous.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index f005c66f378c..055da410ac71 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -37,12 +37,6 @@
 
 #define pr_fmt(fmt) "cma: " fmt
 
-#ifdef CONFIG_CMA_DEBUG
-#ifndef DEBUG
-#  define DEBUG
-#endif
-#endif
-
 #include <asm/page.h>
 
 #include <linux/memblock.h>
-- 
2.17.1

