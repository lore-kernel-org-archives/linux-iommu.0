Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA729320B
	for <iommu@lists.linux.dev>; Wed,  1 Feb 2023 12:59:30 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id q5so17271674wrv.0
        for <iommu@lists.linux.dev>; Wed, 01 Feb 2023 04:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qy+b5xpgUFjRrLFCzYf6p/yqNIUOSZiLBkXfaz/rSx4=;
        b=YJ7fGLhkbBxulYluP+1fv39JA5l0528cZV53/Txw5z0tGfVSkCZtFGijGYa2TEcL6r
         baAPyHxvwBdaKiFrHgLIhJpA+imisi8kE9BZPKdlVscUiCeuRTiCj/vAc9EUOX3wAc6m
         8cSJ++clWuf1NXz5qyFRpqahy3xbF7yVuR78qz/gnZYM6KkJLz1FuwqVll9FWiZzOhuU
         hBp4fFODpwyDfZ3l3CmLBBQjf5DsSrtp0tGs+m8kwqYgrkrwXOfWl2XS0JUKIRGnvPR8
         S5rnd8Yx4IyVQB6RW2EMrNVxuAywHqx/6EqE0YseVmErLkBpyKNEc/AOzqpJZvgr2lAM
         3r6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qy+b5xpgUFjRrLFCzYf6p/yqNIUOSZiLBkXfaz/rSx4=;
        b=oZAuuNks+C0kjCQJzMoQSvPRi2lQLM45pqmunzIBNJ7db/jjzbmsPFpcQEITMk2rSF
         74M+gYMDEJv+0xBHMnQqhPzs6x5DM3nFFlj/1zVkylbW0AzMWXPTGWngQX+SVF0uyU9U
         NsvEs8oZXxvSVva+fce25m6rzyEuPsMlINYgAy197ofF2IP51/KUg5uoZCQr7yJvaYBF
         VpOQkCO/AzUmJotOHn08ZbVglsfTxZ2DoHd+OZj1ChxH6xe8kWgfjvfY4u/4rWIy5EbY
         LmEQ8y1c7/xz+D6Sfumux37PY10QjElDZP69/kub5gXdW+hVbAUq5mKPWg013KcaDIwp
         iB4w==
X-Gm-Message-State: AO0yUKUjps/jN0grMgRGxFEXYUdIookLW1UTfZ9Tq1S1jcR8AnYSGg0U
	piUidmsoufZiNuBuk3yg8qe//+6p+DhsMwx3
X-Google-Smtp-Source: AK7set9FM4aaT3DiyolDQn9oGyxggfW62I5aRvlYUGsF2z4FeLPxOTWcxwy/9PLJAOejzAnBnuWMGg==
X-Received: by 2002:a5d:4810:0:b0:2bf:c09a:c60e with SMTP id l16-20020a5d4810000000b002bfc09ac60emr2385342wrq.2.1675256370318;
        Wed, 01 Feb 2023 04:59:30 -0800 (PST)
Received: from localhost.localdomain (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id m15-20020a056000024f00b002bfae16ee2fsm17972811wrz.111.2023.02.01.04.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 04:59:29 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: maz@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	joro@8bytes.org
Cc: robin.murphy@arm.com,
	james.morse@arm.com,
	suzuki.poulose@arm.com,
	oliver.upton@linux.dev,
	yuzenghui@huawei.com,
	smostafa@google.com,
	dbrazdil@google.com,
	ryan.roberts@arm.com,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	iommu@lists.linux.dev,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [RFC PATCH 14/45] KVM: arm64: pkvm: Prevent host donation of device memory
Date: Wed,  1 Feb 2023 12:52:58 +0000
Message-Id: <20230201125328.2186498-15-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230201125328.2186498-1-jean-philippe@linaro.org>
References: <20230201125328.2186498-1-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the moment donating device memory cannot be supported. IOMMU support
requires tracking host-owned pages that are mapped in the IOMMU, but the
vmemmap portion of MMIO is not backed by physical pages, and ownership
information in the host stage-2 page tables is not kept by
host_stage2_try().

__check_page_state_visitor() already ensures that MMIO pages present in
the host stage-2 are not donated, so we're just extending that check to
pages that haven't been accessed by the host yet (typical of an MSI
doorbell), or that have been recycled by host_stage2_try().

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index cad5736026d5..856673291d70 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -719,6 +719,10 @@ static int host_request_owned_transition(u64 *completer_addr,
 	u64 size = tx->nr_pages * PAGE_SIZE;
 	u64 addr = tx->initiator.addr;
 
+	/* We don't support donating device memory at the moment */
+	if (!range_is_memory(addr, addr + size))
+		return -EINVAL;
+
 	*completer_addr = tx->initiator.host.completer_addr;
 	return __host_check_page_state_range(addr, size, PKVM_PAGE_OWNED);
 }
-- 
2.39.0

