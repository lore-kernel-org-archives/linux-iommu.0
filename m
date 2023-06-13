Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B211423DB
	for <iommu@lists.linux.dev>; Tue, 13 Jun 2023 15:34:41 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6b2d356530eso2527298a34.0
        for <iommu@lists.linux.dev>; Tue, 13 Jun 2023 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686670480; x=1689262480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaKztkphf6Bxk7epVR1Wqf3vysiYNPTt+hK5SRnwDA8=;
        b=oeYO7hapZBlaFPJX1SWGXlckvFpmgvdEQoR7Hdm+8KE+HpXFwmSrfNfkCAR9rHgKHk
         tT3q3cYy257vFWErU6BWhttTkFNTnmi39WE5TJXcJ8/IuT2xmK2orgTRvmsiJXVcIXnB
         /HRCq16h0pKYGI01r/NNH+vtdIEBQiPOof4pXJVqdaQkw/86ifq5mKgtffxZHwdPVE7k
         UoYfVnqTiE5i8yAeJe8QWotssx5NiHuyq13oMHjW8lubXHGzxkvTgfeK9aiP79UaZQtE
         5emH1jKV9m0myuqPez+BXC+6wvubfxpN7p3PF/54FyqRj3hLSVh3gdp2gFDTxdyBvUpl
         egWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686670480; x=1689262480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SaKztkphf6Bxk7epVR1Wqf3vysiYNPTt+hK5SRnwDA8=;
        b=jH0Iopj0i6P3oj//kVKRNGXmVOqzb4bjArIBNrAYdR1pYyAjOMJag3GcJMLPc0YBum
         YHwZEquejfkmR2DHQPnGgl1bxY3CdZ8xR7LhB/VyW5i2RXJwClfl/NqXrFlxuyceEzre
         VF1IB+T6TGOdY434/+AZaeLMA0W4lRpUQiYUBr9mxkoMUg/G/s+5s6GLjDEMx3+jWP09
         4hbnceCtJLtfZ+9IvNRo1N1XgwKCF5nXq6jZcD+Yl0Yd0D4K3lk3LXbqEheATXUxh1P1
         jteJn7y6Uv08Z7wxepon++eCOpfUdG0ZshVmcPgT1dRcUhss2crK4G/ifRAUp9Hk8xnv
         95TQ==
X-Gm-Message-State: AC+VfDzumpjP6VDqrfeJmDedK4aDH6NV7w25dnvfld8VyeloQz4EWJ3B
	2ufobwqtkY8Dh7IWpYqwPhHlCg==
X-Google-Smtp-Source: ACHHUZ5bFvT8beTRSpq/IpBy8h5mVYBspjf+Wsvpe0B+YtIFMJxpp8SFXQt2G2tf2Mp5NyW2jc9/NA==
X-Received: by 2002:a05:6808:87:b0:398:f48:eb4 with SMTP id s7-20020a056808008700b003980f480eb4mr6986593oic.36.1686670480558;
        Tue, 13 Jun 2023 08:34:40 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id n2-20020acabd02000000b0039ce305ea4fsm1630807oif.14.2023.06.13.08.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 08:34:40 -0700 (PDT)
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
	Conor Dooley <conor@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v4 01/10] RISC-V: Add riscv_fw_parent_hartid() function
Date: Tue, 13 Jun 2023 21:04:06 +0530
Message-Id: <20230613153415.350528-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613153415.350528-1-apatel@ventanamicro.com>
References: <20230613153415.350528-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We add common riscv_fw_parent_hartid() which help device drivers
to get parent hartid of the INTC (i.e. local interrupt controller)
fwnode. This should work for both DT and ACPI.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/processor.h |  3 +++
 arch/riscv/kernel/cpu.c            | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

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
index 5de6fb703cc2..67b335789b22 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -73,6 +73,22 @@ int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid)
 	return -1;
 }
 
+/* Find hart ID of the CPU fwnode under which given fwnode falls. */
+int riscv_fw_parent_hartid(struct fwnode_handle *node, unsigned long *hartid)
+{
+	int rc;
+	u64 temp;
+
+	if (!is_of_node(node)) {
+		rc = fwnode_property_read_u64_array(node, "hartid", &temp, 1);
+		if (!rc)
+			*hartid = temp;
+	} else
+		rc = riscv_of_parent_hartid(to_of_node(node), hartid);
+
+	return rc;
+}
+
 DEFINE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
 
 unsigned long riscv_cached_mvendorid(unsigned int cpu_id)
-- 
2.34.1

