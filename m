Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9113B1BB3D
	for <iommu@lists.linux.dev>; Wed, 19 Jul 2023 19:34:29 +0000 (UTC)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3461163c0b6so474395ab.2
        for <iommu@lists.linux.dev>; Wed, 19 Jul 2023 12:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689795268; x=1690400068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsGoT51dWJmzQKPxb3tGZnxKgH62aNnVUMM3GK3B70I=;
        b=25R+yCvMKbfvQR87JPugzrtI45C63mU3sviX8G0Vy3Wvo5ueLJ6LoiuXaMFt1wKE/9
         J2h7M7wC9mw8pp112AUlWRQnBXuQYeNqWCUrHT4s/bSKKKVibQt5pMn4JpFlbK212NTU
         Sh9aDJz8I0G32u8J5s8SbpYs7u5AYuv0KdPzsQzp4A4tsU6FfR5KRmDtU19hydphE8fS
         Dvwd2miaFaVXcHQq7Pao/6dE0JkI4ofWpL3JzgHPGwqTAgtKWllYKsvDJSJBHZ4k4ptP
         KcOM7qqQwWLW6QhyEFO3/HD64siCzcAvSJ8/yq3MiSdTk8+aGW6aGukJ4KThrK/kYnKa
         PovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689795268; x=1690400068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsGoT51dWJmzQKPxb3tGZnxKgH62aNnVUMM3GK3B70I=;
        b=IjvEZSFyb2tW1R1RkRJ8tTt8rooP9AluiGTYRYFhFz9fBzzHAkBD1gSfz4bmW6Omf6
         X7FZKz1iizWMsHsY6QeEfkiVo0Xzlh7WwwEtmw7QhvwetzuR8QedF2zZpdBrQ/CIL3Bv
         hwvhASyfNG2Mb43Il3iDSFaqgaHHHplbRdxZ2gahQd0vyu25YOj2iML/mdoooS0raz/4
         7fE7tAKdVLWOSNveTxza+U5WY5J0Ybh9SQb03VziyNWloTK2ptHPQJIqGsQnBQoowae0
         igKx6i78npZbQ4uRtC1VW+n+G6UOM327PidxHAbe06mf/mpdH3lyUyqabbPQQtCQ5eM5
         32TA==
X-Gm-Message-State: ABy/qLb1s7B6guxAz8xhTnldV3P7PVEq8Dwj4F5pZCP7gUJF3gV8B0C0
	3YMFs0/cE9gcUHopcQ3GSvQ3VA==
X-Google-Smtp-Source: APBJJlG+MFbJEKkJ1B9LQsQ5MgT1jSSRYuMm6X1iFGTwoFDCvk/QYGkIlda8SXG94SgiZ9wVyGnQjg==
X-Received: by 2002:a05:6e02:1c49:b0:346:e850:6cc8 with SMTP id d9-20020a056e021c4900b00346e8506cc8mr3677361ilg.9.1689795268696;
        Wed, 19 Jul 2023 12:34:28 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a031700b00264040322desm1591053pje.40.2023.07.19.12.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 12:34:28 -0700 (PDT)
From: Tomasz Jeznach <tjeznach@rivosinc.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@rivosinc.com,
	Tomasz Jeznach <tjeznach@rivosinc.com>
Subject: [PATCH 04/11] MAINTAINERS: Add myself for RISC-V IOMMU driver
Date: Wed, 19 Jul 2023 12:33:48 -0700
Message-Id: <e1578b96b9c75433d8c49b6a173ff47a64675c2b.1689792825.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689792825.git.tjeznach@rivosinc.com>
References: <cover.1689792825.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aee340630eca..d28b1b99f4c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18270,6 +18270,13 @@ F:	arch/riscv/
 N:	riscv
 K:	riscv
 
+RISC-V IOMMU
+M:	Tomasz Jeznach <tjeznach@rivosinc.com>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
+F:	drivers/iommu/riscv/
+
 RISC-V MICROCHIP FPGA SUPPORT
 M:	Conor Dooley <conor.dooley@microchip.com>
 M:	Daire McNamara <daire.mcnamara@microchip.com>
-- 
2.34.1

