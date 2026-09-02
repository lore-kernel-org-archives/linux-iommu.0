Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDE53F23C0
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788344143; cv=none; b=d90kOo4+Pqgz2OmkE+hXWV63+ZuC12Q8ptCexECqpHndR00UxZkXPIET/zO7UXSPH9OlQnIe2QpPLZK2BzgEJHs6BbbtHjepUQ1i3/xXk2fERcklh/P05kyn0eJNmQ6XX9EQDtYTRCpDQ+oZGnyTH6Z9obs0NVzCGBw16xzAhOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788344143; c=relaxed/simple;
	bh=ABJG18rDzFEuD5O5Wz470eo2LZFzwAdwdXYa8E/eCf0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eykG8WezBasoAr1PRSoTHQydCSJ10TrBGH4PK9Sw2ssakA1SzQ7qVKAS1JxZR3TI/tN4JeLe2/FO1Yxr6q27tflNK5avgD/n1Ox3RrpbrUU1XIOTiJ8Huok4+E61mXqCesLM6WgoQpaS7/FrF+hdpT+5KJ3Zxh5x/2gDdoVzRO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8eDMk7G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8eDMk7G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF541F000E9;
	Wed,  2 Sep 2026 10:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788344141;
	bh=U19QuPyZLBnqiOID1HXqevng5+1vhtDIZSxvmgq51/8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=E8eDMk7Gi7M+OPapwTLZYgJCB5YIj0jR6+Av9Zfcv3nJHNfLI5v0pnOwFrvwsKEiG
	 cW3q8YtytSIfEvlvZnaxWMua4URAfdEUkCMZra98WoH1rFpKCMfDHL9hnWxx9DJyLF
	 52RcCQ9tIQXwoELxXBZjzM1WxvlcEDqHutTPdNZX9flxdQiOS6Xj8p02rKOYCjJwZn
	 L/EGAOEtEwxbPue3hlW6VDupSFzy3DS8J40KHVjS8P0/DTeFLehh3qI2ehj39rTgOq
	 H82hJedHl1xX8mgAlhUeSCSJHnTeA0gpIxc41bBZsTqbE49zUG4khMrgsfGbqoo10S
	 RTayvAROcfiPw==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Timo Witte <timo.witte@gmail.com>, iommu@lists.linux.dev
Cc: m.szyprowski@samsung.com,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, joro@8bytes.org,
	"alexander.deucher@amd.com" <alexander.deucher@amd.com>
Subject: Re: [BUG] iommu/dma: "Not yet supported" CC_SHARED rejection
 regresses dma_alloc_attrs() on SME hosts with IOMMU-attached GPUs (commit
 8277a12d0d60)
In-Reply-To: <CANB4YXR7h8V5Xp=MXVZeSdvw9UiriSagp=E+ju5RRDNghoPHLQ@mail.gmail.com>
References: <CANB4YXR7h8V5Xp=MXVZeSdvw9UiriSagp=E+ju5RRDNghoPHLQ@mail.gmail.com>
Date: Wed, 02 Sep 2026 15:45:36 +0530
Message-ID: <yq5ao6egyn5j.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Timo Witte <timo.witte@gmail.com> writes:

> Commit 8277a12d0d60 ("dma-pool: track decrypted atomic pools and select
> them via attrs") added to iommu_dma_alloc():
>
>     /* Not yet supported */
>     if (is_alloc_cc_shared)
>         return NULL;
>
> dma_alloc_attrs() auto-sets __DMA_ATTR_ALLOC_CC_SHARED whenever
> force_dma_unencrypted() is true. On an SME host (mem_encrypt=on) an AMD
> GPU with a 44-bit DMA mask hits that condition, so every GTT (system-RAM)
> allocation fails with NULL/-ENOMEM, amdgpu init aborts and the system
> boots without a display.
> IOMMU in Translated/DMA-FQ mode (iommu group 29).
>
> Before the mentioned patch it worked: the IOMMU PTE carries the SME C-bit,
> so the memory controller transparently decrypts for the device while pages
> stay
> encrypted at rest. For IOMMU-backed devices force_dma_unencrypted() is a
> false positive - the device DMA mask does not limit addressing once the
> IOMMU translates, so CC_SHARED should not be auto-set for them.
>


This means that, with host memory encryption, DMA does not need to be
forced unencrypted when the device uses the IOMMU?

modified   arch/x86/mm/mem_encrypt.c
@@ -13,6 +13,7 @@
 #include <linux/cc_platform.h>
 #include <linux/mem_encrypt.h>
 #include <linux/virtio_anchor.h>
+#include <linux/iommu-dma.h>
 
 #include <asm/sev.h>
 
@@ -30,7 +31,7 @@ bool force_dma_unencrypted(struct device *dev)
 	 * device does not support DMA to addresses that include the
 	 * encryption mask.
 	 */
-	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) && !use_dma_iommu(dev)) {
 		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
 		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
 						dev->bus_dma_limit);


-aneesh
