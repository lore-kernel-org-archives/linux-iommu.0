Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D498A1C3C
	for <iommu@lists.linux.dev>; Sun,  8 Jan 2023 06:53:44 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso9544607pjp.4
        for <iommu@lists.linux.dev>; Sat, 07 Jan 2023 22:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H/VDmG0gdlZJvoOOCR9LZEjMINUvMdkeoZNcXYasXMA=;
        b=JjaV7/CZSpMtpB3/NAfRJ+GfwUFPa4n//oyxermfR/6ymk6fOKZQOkWjwbWBTodJfs
         Ehz6QSs2o6hEbzmur/eIpG8xZeP9J8p0QOZwymPDQLCLFAJATffQKbQoVb+2Wqhc99lU
         xUFxaXmXTnAOZjBuTS6el5rZfCjGFLAyREl99UE/qGPF1In0HuQxPxddOfDk/A+P1040
         clMlIrxQraDTb6dEqGCBo/LCZu5kmViFGB5MSG9YFIJwcnypqA5Pe0bCkvNz8dDDoW+P
         6icPZPehUO+CVCsX6cRPFnSZWBQ9n+oSXo7KbosF55J+N2KnjLc6zVFlgqPWagmcbwso
         xD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/VDmG0gdlZJvoOOCR9LZEjMINUvMdkeoZNcXYasXMA=;
        b=sTFzxmA5wfroYUEq8DCQpcqmTXxrxaLr7x3WwmJoWARAwp5o66Q2dbOjaLTBASZ1gM
         j8yBAtRlTcfvCBTdleeQ0CkIUwDxLCPdtTFjR0xYD0LaQPc4B08AElR72uACF0s6S1JB
         /HKAHlaXajwgMdoqs76/sDVnSzAqGyzyhEIJrJ1Gaf8EBeVU8ZKabsq9eF4V9UZESUiW
         AApkajXwZ7EzfJmhB7EI9wbpmXGX7+cAuc+THL5OCdjKC+GVk1RZ5ThB+AUVHIK/jtWp
         fBrL+BmA/ZWYQQ+0MSTeP6QZGkxatLyO8TBuZNxzojayjt2WOBGdS3z+Kv+wZWMlKzji
         bvQw==
X-Gm-Message-State: AFqh2kqBZYvoNiTJn83eatqp09a4idd/gnUWaewgTtYVU9mfyligCYEL
	NgRGsAdsdJxx/5qC1H80ges=
X-Google-Smtp-Source: AMrXdXvj7pJXlDVac5JQM7nClMOZFKZor6ueZeav4eRhzDnnC6YB0QW8FLdOLL/5H3YB5z+tf3OUjg==
X-Received: by 2002:a17:902:7688:b0:192:ce01:7d82 with SMTP id m8-20020a170902768800b00192ce017d82mr22054178pll.52.1673160824313;
        Sat, 07 Jan 2023 22:53:44 -0800 (PST)
Received: from morpheus.lan (106-69-189-37.dyn.iinet.net.au. [106.69.189.37])
        by smtp.googlemail.com with ESMTPSA id t1-20020a170902d14100b00186b3c3e2dasm3685296plt.155.2023.01.07.22.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 22:53:43 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] iommu: dart: depend on ARCH_APPLE rather than ARM64
Date: Sun,  8 Jan 2023 06:53:34 +0000
Message-Id: <20230108065334.397200-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's a better fit for the Apple DART driver to depend
on ARCH_APPLE than just the ARM64 architecture.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 79707685d54a..6fa22f29d884 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -70,7 +70,7 @@ config IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
 config IOMMU_IO_PGTABLE_DART
 	bool "Apple DART Formats"
 	select IOMMU_IO_PGTABLE
-	depends on ARM64 || (COMPILE_TEST && !GENERIC_ATOMIC64)
+	depends on ARCH_APPLE || (COMPILE_TEST && !GENERIC_ATOMIC64)
 	help
 	  Enable support for the Apple DART pagetable formats. These include
 	  the t8020 and t6000/t8110 DART formats used in Apple M1/M2 family
-- 
2.39.0

