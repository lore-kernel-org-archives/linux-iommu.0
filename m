Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A221FAC;
	Thu, 26 Jan 2023 09:26:49 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id h12so1082033wrv.10;
        Thu, 26 Jan 2023 01:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZYW30C/ykJ0dX6uEse/em3+bjaPFaeluNg8nm/RLldE=;
        b=Hj2CvZ0hy14M4aVKbMFPqyH3ehhERaVzMUn0fSLlPiHrZruMAA349DMvEW4Eh4PWfJ
         upttpxq9lkd4jEBPRxx2O3hDHyRpL6TjA60fK5YhxL57k57N4m9RO40vsj1dTZmYwwIF
         JNxMGikMccPxdKK5a1ohI0KWDs0ZEoCMWsKBH1vpOTelgGJZE4kRvGX9b+y0+epK8LpY
         B7+GdKEpM5xV/h0KftPrbwLA4aOvk0p1L/q1wKHIs/eL0PHfkROx+YRM2tFdN/tqMUez
         cn8j6e+CUgwNY3Swv5UTPSnHfWo6BYe+mJRvsLwuKIr4AB2Yxi8+CzGfaJF+RRuw+fOE
         Vt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYW30C/ykJ0dX6uEse/em3+bjaPFaeluNg8nm/RLldE=;
        b=BnxsFU6/goFSQAFdUzR8b/rfWxENI4mNLMK6YlmJl3R7dN99vNURPnjTebz23FZaaz
         0+tQqVajCt31CVAOwIehSkmV7df2g7eQ2rNtj6D/bP7X0tc6U3xmXZENiJ4cWKSWVJKy
         zVfypnovRWHVT/NMBXPqfSMafvDJ6mw95l1LzTQ59O77RVXZEqVzAYq4Od/KWkNy/Rdg
         jr1FwBChTRJSg5FiUBEmgAnnuygKJWYAt9qirWQJYYDDtBV31UNt/PUN8GC48kzsb1rN
         rm0lkhVriV+JF3iZ+hmuPucMw9NvkgHphswP1m1Upa4A6Drd6fgb9WoYbpYV5SF7xqcq
         ko0w==
X-Gm-Message-State: AFqh2kqGXohKNS2F2YQAp+Qt3GMANY+b/Ts8ChoLB7sP69+ur3bU3P42
	GSwjcxy/ek3u6hEZUI6Hcfg=
X-Google-Smtp-Source: AMrXdXvHRPqRfhcYIfrzoZZUQRgHWUh4L/wOYXRWwfi2Gp8jExVMSRDbG1IspRw2wroTSHHynNW06Q==
X-Received: by 2002:adf:edd1:0:b0:2bc:7d12:e736 with SMTP id v17-20020adfedd1000000b002bc7d12e736mr29910945wro.1.1674725207950;
        Thu, 26 Jan 2023 01:26:47 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n9-20020a5d67c9000000b00294176c2c01sm750797wrw.86.2023.01.26.01.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 01:26:47 -0800 (PST)
Date: Thu, 26 Jan 2023 12:26:44 +0300
From: Dan Carpenter <error27@gmail.com>
To: marcan@marcan.st
Cc: asahi@lists.linux.dev, iommu@lists.linux.dev
Subject: [bug report] iommu: dart: Add t8110 DART support
Message-ID: <Y9JHVN/lU6IHy7mB@kili>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Hector Martin,

The patch d8bcc870d99d: "iommu: dart: Add t8110 DART support" from
Jan 13, 2023, leads to the following Smatch static checker warning:

	drivers/iommu/apple-dart.c:991 apple_dart_t8110_irq()
	warn: duplicate check 'error_code == ((((1))) << (3))' (previous on line 989)

drivers/iommu/apple-dart.c
    972 static irqreturn_t apple_dart_t8110_irq(int irq, void *dev)
    973 {
    974         struct apple_dart *dart = dev;
    975         const char *fault_name = NULL;
    976         u32 error = readl(dart->regs + DART_T8110_ERROR);
    977         u32 error_code = FIELD_GET(DART_T8110_ERROR_CODE, error);
    978         u32 addr_lo = readl(dart->regs + DART_T8110_ERROR_ADDR_LO);
    979         u32 addr_hi = readl(dart->regs + DART_T8110_ERROR_ADDR_HI);
    980         u64 addr = addr_lo | (((u64)addr_hi) << 32);
    981         u8 stream_idx = FIELD_GET(DART_T8110_ERROR_STREAM, error);
    982 
    983         if (!(error & DART_T8110_ERROR_FLAG))
    984                 return IRQ_NONE;
    985 
    986         /* there should only be a single bit set but let's use == to be sure */
    987         if (error_code == DART_T8110_ERROR_READ_FAULT)
    988                 fault_name = "READ FAULT";
    989         else if (error_code == DART_T8110_ERROR_WRITE_FAULT)
    990                 fault_name = "WRITE FAULT";
--> 991         else if (error_code == DART_T8110_ERROR_NO_PTE)

DART_T8110_ERROR_NO_PTE and DART_T8110_ERROR_WRITE_FAULT are both BIT(3).

    992                 fault_name = "NO PTE FOR IOVA";
    993         else if (error_code == DART_T8110_ERROR_NO_PMD)
    994                 fault_name = "NO PMD FOR IOVA";
    995         else if (error_code == DART_T8110_ERROR_NO_PGD)
    996                 fault_name = "NO PGD FOR IOVA";
    997         else if (error_code == DART_T8110_ERROR_NO_TTBR)
    998                 fault_name = "NO TTBR FOR IOVA";
    999         else
    1000                 fault_name = "unknown";
    1001 
    1002         dev_err_ratelimited(
    1003                 dart->dev,
    1004                 "translation fault: status:0x%x stream:%d code:0x%x (%s) at 0x%llx",
    1005                 error, stream_idx, error_code, fault_name, addr);
    1006 
    1007         writel(error, dart->regs + DART_T8110_ERROR);
    1008         return IRQ_HANDLED;
    1009 }

regards,
dan carpenter
