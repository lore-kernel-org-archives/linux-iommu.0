Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382B61361
	for <iommu@lists.linux.dev>; Mon,  8 May 2023 14:29:10 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-64359d9c531so3371270b3a.3
        for <iommu@lists.linux.dev>; Mon, 08 May 2023 07:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683556149; x=1686148149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1nY2tFDgGEcA5BPTW/qPM4ksEcua9dIFA1MwwOUg+w=;
        b=Y4KeKeEH2HyNjQj1MvzsAagGgVRUdpfCpDFHN+2mKM/yIL5V4lC3/r8BWTBVPv8mr8
         crG2m3zs5hnPIFNLt92hug/24EbFLZl8MHqF6s0UAd9n57VO1wIMukU5t9t3dDPg2PRO
         sO9zoJNKGTBkOC3klDG6HaL02odtnyoCMZY6HzIpeP2+t3qrT/fC9nsHjjuQ7NCuBZj+
         aq2dtuWODDaoxaCpgUoNZGGP1z628C7yRSBp+4ZUOT0oExNHPCeb8h1cRwyar7P0p+2V
         wseYx1vo0wkd9RoXyot8Efac9RcekQ3hmC2u3e4HorVZQmu9AI0obr74p9qEtJZc0r2+
         fkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683556149; x=1686148149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1nY2tFDgGEcA5BPTW/qPM4ksEcua9dIFA1MwwOUg+w=;
        b=SoSXjAw1qjTHNytDBifiK9MnFAesuaRD2K6Z4l9lRXBtey45miyNNw5icCCGPjxHKW
         RzHyL08SHs6NGCLJifXUrhVHvFRrICLGEhupEAH/5qVbqo9pQvnVi+EfEidTRMaNa1UE
         xMgfOh8PBR1fI5DgDCfdO2HPhSE4cv9ICXTeitHoR2bsxmN1mHmKJPEZj2YQvCBzTfsI
         ZVFd9x0oCveHA1seF8NE/cOkVvN63T6nFnxO3SbD4owLlVXMu613pQPmhAMJB1xVPe0f
         BvTtIz6yy9xb7ufXAyS97iI1G15jaCjEwa0r5ApbGpMP5Iapnr6XsqWcX1K4Z7hz9Wr1
         yNTg==
X-Gm-Message-State: AC+VfDw4gSecI5ep8HzXAs+rGO99+aw/U2L1BZD/kKGshl7qPJtnmZ3t
	XAGP7iqFdjF4ft2k0sTFpR7Q8w==
X-Google-Smtp-Source: ACHHUZ7gDrZ3JRghPX//cMrvwquC37PoOqjAFZxHaVQQxUAxuCDyhmWrefaoupApJJIMGX/LlXhLUA==
X-Received: by 2002:a05:6a00:1503:b0:643:96e:666b with SMTP id q3-20020a056a00150300b00643096e666bmr13783594pfu.34.1683556149506;
        Mon, 08 May 2023 07:29:09 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.84.206])
        by smtp.gmail.com with ESMTPSA id k3-20020aa790c3000000b0063d46ec5777sm6082pfk.158.2023.05.08.07.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 07:29:09 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>
Cc: Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v3 02/11] of/irq: Set FWNODE_FLAG_BEST_EFFORT for the interrupt controller DT nodes
Date: Mon,  8 May 2023 19:58:33 +0530
Message-Id: <20230508142842.854564-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230508142842.854564-1-apatel@ventanamicro.com>
References: <20230508142842.854564-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RISC-V APLIC interrupt controller driver is a regular platform
driver so we need to ensure that it is probed as soon as possible.
To achieve this, we mark the interrupt controller device nodes with
FWNODE_FLAG_BEST_EFFORT (just like console DT node).

Fixes: 8f486cab263c ("driver core: fw_devlink: Allow firmware to mark devices as best effort")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/of/irq.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 174900072c18..94e1d9245cff 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -535,6 +535,16 @@ void __init of_irq_init(const struct of_device_id *matches)
 	INIT_LIST_HEAD(&intc_desc_list);
 	INIT_LIST_HEAD(&intc_parent_list);
 
+	/*
+	 * We need interrupt controller platform drivers to work as soon
+	 * as possible so mark the interrupt controller device nodes with
+	 * FWNODE_FLAG_BEST_EFFORT so that fw_delink knows not to delay
+	 * the probe of the interrupt controller device for suppliers
+	 * without drivers.
+	 */
+	for_each_node_with_property(np, "interrupt-controller")
+		np->fwnode.flags |= FWNODE_FLAG_BEST_EFFORT;
+
 	for_each_matching_node_and_match(np, matches, &match) {
 		if (!of_property_read_bool(np, "interrupt-controller") ||
 				!of_device_is_available(np))
-- 
2.34.1

