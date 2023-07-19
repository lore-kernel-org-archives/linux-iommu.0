Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A66A1BB3D
	for <iommu@lists.linux.dev>; Wed, 19 Jul 2023 19:34:27 +0000 (UTC)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-565f8e359b8so52636eaf.2
        for <iommu@lists.linux.dev>; Wed, 19 Jul 2023 12:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689795266; x=1690400066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKs32IhtjLCxiTXuNk8Uk4pJZW2VlUAJQXvCnEO8tTw=;
        b=ttEo92CKB+yR7JU7SvNGV8Atfkln1N918fvtYmF+Wgf2jy4/UvkxLvZRx27dLz5xpa
         MK28QZNyj3okLeYSDgB53bNVDZxBUGsJIzl7b0oHpt1mjYQlvG742DV2OfZqfp/toq6S
         cqv66fUUijUqZgzvJveQtk6qJyo4+Its4OkrqFa3ow6PzmvaLPj3RDllFbjds40oEybI
         2GhbBCEJRA/5XrGCEgfKz/bCXBbANcUZY6dwuHG8oPTtVgjEK2yl85TLej5y5liOEynz
         +B83Dx+fGKsqspEcpyTw+uOBVovf/8uysb74AEM26+yzu0N1vlrrsUTsxZJlKdR5cWqB
         AE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689795266; x=1690400066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKs32IhtjLCxiTXuNk8Uk4pJZW2VlUAJQXvCnEO8tTw=;
        b=X8qWFNJ2hScOUKZvfyksiXJQc3ceDZf96xQrVXXdcDrL/p5bGOaUDsCxKlD4aZt89o
         zGG2uE9qUQmSPYr+KMMvXrgiVpoNuDOX9+zl4bahuyFsn5jNZ3l+v2yjiquAO9Pzbuc+
         hb3TIdthha61G3UjJX9DI+1d0/surqx8zI3zogD2mbU10ec7/+JEhJ94Gg4G4gqU9dm5
         vHF57RJaeRZqe4eeeX2hzYQ5qkLsZ+RcQuxdC4EwA/EUEV+P0GbsiatAChgvpQuQhk1p
         qj/SApOMotvZhMoDsxow2VwEUOAZDBfnsGqbYhMYNiWUJoi+mdG0MaWY0WMUN6xJ3Lu9
         WOlg==
X-Gm-Message-State: ABy/qLaRtl/fgoTU9J3hHO00xcY6VRlg9BdVjK4/Ios1tr4VLKBkToyV
	MlJT7ET83dLjtjSGc+PoJr5x3Q==
X-Google-Smtp-Source: APBJJlF46NxrjlcdpKJudq/OXjPgbmDMiFkMVyFxOnpopja4waUL727ujepZ1ywnk72M22OszAadog==
X-Received: by 2002:a05:6808:30a4:b0:3a4:f7b:4490 with SMTP id bl36-20020a05680830a400b003a40f7b4490mr21501434oib.57.1689795266359;
        Wed, 19 Jul 2023 12:34:26 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a031700b00264040322desm1591053pje.40.2023.07.19.12.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 12:34:26 -0700 (PDT)
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
Subject: [PATCH 02/11] RISC-V: arch/riscv/config: enable RISC-V IOMMU support
Date: Wed, 19 Jul 2023 12:33:46 -0700
Message-Id: <961d125558137f7cb960de65e5f71da5d299d3bc.1689792825.git.tjeznach@rivosinc.com>
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

---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 0a0107460a5c..1a0c3b24329f 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -178,6 +178,7 @@ CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y
 CONFIG_VIRTIO_MMIO=y
+CONFIG_RISCV_IOMMU=y
 CONFIG_SUN8I_DE2_CCU=m
 CONFIG_SUN50I_IOMMU=y
 CONFIG_RPMSG_CHAR=y
-- 
2.34.1

