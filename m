Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2005A142E7C
	for <iommu@lists.linux.dev>; Sat, 17 May 2025 10:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747479035; cv=none; b=EpvoM81uBfFzG/9Bdc3LzssPb+iWPrOPOqo+CuokXvTO1CjVBFF9juWgxl1oRvBOvZJ/GutOAJsv1N7+W9tiQ+sUW1Rm2m3OEgcRBSdLc04FNl/tN9DXYztSaDWFgrpCnFxCIM9/0HvYzOsDSLMfldKbylGIUUBrV3YPdqbdS0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747479035; c=relaxed/simple;
	bh=k+CMuWETIWwkqw1qINaTIZnTP1ci7VFjRGzRVLKnMK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aqq0b23t7RrHqDRftcGEAOcan2TPjao4htA1h5qtps2k0Bo9HcRTu0SjxAUFkIef2+vGrGuH3XuFBbXp+x18egCH5r0th0EpSxSBdGSckvI8+2xN/K9bCoKB+FAfXU+kuPE7gU5++uB7FTKd+NX8yTy1T3kPXN8u0DItm9GFYt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4b00M92B0Wz9sbr;
	Sat, 17 May 2025 12:20:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id klZbKNPdRbl2; Sat, 17 May 2025 12:20:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4b00M91Vfwz9sbF;
	Sat, 17 May 2025 12:20:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2E90A8B767;
	Sat, 17 May 2025 12:20:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id lRU_1UESIp_b; Sat, 17 May 2025 12:20:21 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 010048B763;
	Sat, 17 May 2025 12:20:20 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
	by PO20335.IDSI0.si.c-s.fr (8.18.1/8.17.1) with ESMTPS id 54HAKDeU013328
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 17 May 2025 12:20:13 +0200
Received: (from chleroy@localhost)
	by PO20335.IDSI0.si.c-s.fr (8.18.1/8.18.1/Submit) id 54HAKCZa013327;
	Sat, 17 May 2025 12:20:12 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: joro@8bytes.org, will@kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Will McVicker <willmcvicker@google.com>
Subject: Re: [PATCH] bus: fsl_mc: Fix driver_managed_dma check
Date: Sat, 17 May 2025 12:19:38 +0200
Message-ID: <174747706458.12970.14926241943300392052.b4-ty@csgroup.eu>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250425133929.646493-3-robin.murphy@arm.com>
References: <20250425133929.646493-3-robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747477178; l=776; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=qVOoIrTsoZcWCm+U3VKSICm/zw2sUZWZNpODf/MkZBk=; b=hcgFMiXEXjwpytNmOoTfd2InNdVfJslU9f4biTG/D/UIE0NQCxLGxC3d2He2BGQXZaIvjCHZj F/2J+wZIwSHCm2cWa3rAdnSdYIVe9HqSD/LwdqJGijLc21KbUBD+RyQ
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit


On Fri, 25 Apr 2025 14:39:28 +0100, Robin Murphy wrote:
> Since it's not currently safe to take device_lock() in the IOMMU probe
> path, that can race against really_probe() setting dev->driver before
> attempting to bind. The race itself isn't so bad, since we're only
> concerned with dereferencing dev->driver itself anyway, but sadly my
> attempt to implement the check with minimal churn leads to a kind of
> TOCTOU issue, where dev->driver becomes valid after to_fsl_mc_driver(NULL)
> is already computed, and thus the check fails to work as intended.
> 
> [...]

Applied, thanks!

[1/1] bus: fsl_mc: Fix driver_managed_dma check
      commit: 152f33ee30ee6a7f4c15bedd7529dc5945315547

Best regards,
-- 
Christophe Leroy <christophe.leroy@csgroup.eu>
