Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A9C1361
	for <iommu@lists.linux.dev>; Mon,  8 May 2023 14:29:05 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-64395e741fcso4616953b3a.2
        for <iommu@lists.linux.dev>; Mon, 08 May 2023 07:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683556145; x=1686148145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCnijZqZqbTFwmvqbOqYG9D3eO4SsXuxft0NUX8zz8A=;
        b=nsRbPLksBMxCFlI4Dk5W+JxUo5zwuNx1VEvGmsPZxoLBxbf7fhQP9i9unfigIlTOGz
         yBuJmPoM8nOnC5hnhATZOfDLAyouQ2Q7WduLsqd07D9e35BWU5kpZVAKtyHp/i3vATYz
         rjmsbzldIuJctLEnJmHxe0Ab8RabRHamwkH1Y2UGs20FDaQ+aPapOVNTV11A/sf8VxTF
         C1uahOKpgwutooogbk3seey0VKk8V0YhVIHz4k77bIvMfaA+CDPWhyz7WP87x4LYfU2u
         94KStMnCfY6REGFJu8024uIkI9tQIuItHRT+VxNw3MnYO7oXswuE1gHKFDBl/FPRvUqX
         wy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683556145; x=1686148145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCnijZqZqbTFwmvqbOqYG9D3eO4SsXuxft0NUX8zz8A=;
        b=ZeQgDOrCkXaCr5TB7CMSDjgWVdocSuQLGjRWR+a8SVXtYw4iErea/Cup35u43UHM4i
         A5uw6Hun8DY8VUJ5Cxe04qia81S8bOD91YwTXjdAZfGs3sn8A+75FecasCSVCJP/QEFc
         CO9Ha5J7NsxDvGb7cnHmR/A0EvFwVieEgUFiwgfryxzaf8PTizG4sUdrgVQEvEiiyEW4
         TXdGxEz0YV8zVBk0TTBXMV076vualACe0BJGqkHUTC7KuLr4bQKIYt0+6yo8CpDfR3iv
         U+g2yDZ+465IOb0LLsDd0PPauY8aHdtt/iY5BKF7JoPWWiUWgh9rGfG0mlduu64iNyD7
         UGtA==
X-Gm-Message-State: AC+VfDxfAalrKk+o3atZvvhidA56JZlSimhQHAr/DmEHpUDputqegKDQ
	Fov8QVvK8554DZML7Xi3KqjyAQ==
X-Google-Smtp-Source: ACHHUZ5kRlrVSUMiHnzrjpy2wrojD8fr8xn1cSzxwM+Vk7Xk0AkQUAUDShOnn3rSFg9njNf6VATOLQ==
X-Received: by 2002:a05:6a00:a21:b0:62a:d752:acc5 with SMTP id p33-20020a056a000a2100b0062ad752acc5mr14331891pfh.32.1683556144804;
        Mon, 08 May 2023 07:29:04 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.84.206])
        by smtp.gmail.com with ESMTPSA id k3-20020aa790c3000000b0063d46ec5777sm6082pfk.158.2023.05.08.07.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 07:29:04 -0700 (PDT)
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
Subject: [PATCH v3 01/11] RISC-V: Add riscv_fw_parent_hartid() function
Date: Mon,  8 May 2023 19:58:32 +0530
Message-Id: <20230508142842.854564-2-apatel@ventanamicro.com>
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

We add common riscv_fw_parent_hartid() which help device drivers
to get parent hartid of the INTC (i.e. local interrupt controller)
fwnode. Currently, this new function only supports device tree
but it can be extended to support ACPI as well.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/processor.h |  3 +++
 arch/riscv/kernel/cpu.c            | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 94a0590c6971..6fb8bbec8459 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -77,6 +77,9 @@ struct device_node;
 int riscv_of_processor_hartid(struct device_node *node, unsigned long *hartid);
 int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid);
 
+struct fwnode_handle;
+int riscv_fw_parent_hartid(struct fwnode_handle *node, unsigned long *hartid);
+
 extern void riscv_fill_hwcap(void);
 extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 5de6fb703cc2..1adbe48b2b58 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -73,6 +73,18 @@ int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid)
 	return -1;
 }
 
+/* Find hart ID of the CPU fwnode under which given fwnode falls. */
+int riscv_fw_parent_hartid(struct fwnode_handle *node, unsigned long *hartid)
+{
+	/*
+	 * Currently, this function only supports DT but it can be
+	 * extended to support ACPI as well.
+	 */
+	if (!is_of_node(node))
+		return -EINVAL;
+	return riscv_of_parent_hartid(to_of_node(node), hartid);
+}
+
 DEFINE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
 
 unsigned long riscv_cached_mvendorid(unsigned int cpu_id)
-- 
2.34.1

