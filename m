Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794593046;
	b=usb5EWelA1DS38H+L/tBJb9pEBOxP4W8CWB/BT9yuESzfAUr1NRsDqlibMVlksIrRreZ
	 v4qtM5gvPbgqJo9axrlJej+WeMswP/BIMzTaqYYHMMrDkcJzxt6UrXhPVoSFBdNeLgK3V
	 IbToRc9bTe69gQjZa2E8ENsgBn6RH0XsKvAthpKKA/EXFN7w5Nw4pLVk62GFjI1hLDCgA
	 HQmplyJ5rz/5B0UihWigejYByFP0Tn+2TjdNikmMCO60Mz0SyvkZjlzm3VrNJN2JTMMNw
	 nk6XUZtcH9acRlztNH/Viwax/ryyX6YM1E9pqPZtu9Y9JGkTvVmzpamLJ80NTgAcITQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794593046;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=AvuG6GtWMhvBrr/UfnDRgGS1baAdJ+zbVL6VkOkdJWI=;
	b=QD1q2k10gLp2dtf9nKe82bi5Sq9uk3u7jLlj/ozgMfuRUuiFY+0f5Hck7FueDgX0FdM5
	 GL0lQlm6sotsykIAluce1ou/H12GCiSnuRCn0yYAonxuvEVgyXZ1hbEgvHxP95Q3nqWuo
	 P+izw6JdEwZIhGyUdGJqalLfVzQkkEvun4YtvLkw8NScOSsIo3PpZKQGKGL7ZniDOeIww
	 hhXKu57z/+7Ohz+n7gxdQZcYSyjWmDy8Rjhb/FKi4aZR3U2pepgPkhTJDkOiTIvDRez1/
	 vIVdKWnoHjhu+PRkQwRb/FDrWCaSWZyIiIsaf5fIKs84ZzXqMrhzB4ZY8wfobfK8iwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iu0w5xvd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.42
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F28606A891
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 18:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27F28606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iu0w5xvd
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5c00b0866b0so128945e87.0
        for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 10:04:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794593044; cv=none;
        d=google.com; s=arc-20260327;
        b=jBq96MobMiwY8xZP+obyN9NizeYS6CsUGh4rcGhJDqAil+U5R4TLkIp8+53ZjFy28K
         mj3NuAq4YUZ5nSKLvtIesGemuhpgcQ2q3NQZrTLX5T4uFm3Fcl9E2tab+CLwYfJUUPvV
         vWOwqubRjXk7oKi9V3SfLobJVMdZCfYI3E0YSPVBs7Xq1zlqNN97aDAV5jI9mgdcFCpH
         BoZ0qfy1g5KUC5d9nPAxsmRrsZZMV+6+sbPuVknxvPoyOVaz+Z+msPi5l7jmfV7desaN
         OSAxpV9y+pvLSE3TWl785ZySgr2SdbcZUq0jIWeeCF3EIzPn5drjicsTSwEIwzrcGM2e
         PSlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=AvuG6GtWMhvBrr/UfnDRgGS1baAdJ+zbVL6VkOkdJWI=;
        fh=aTksfhXudPaU578VWs1aV68OC+rpWVk6prVOTaWf8j8=;
        b=kUSXlSBmPRCgb+OF12FtExTyKL/mjGQseCW63egISUcWMn8flHPjO0PAKMQywxDy3n
         YZlTAW50wvtJ+V54iyv5jWJB5rQoEHNV8NeJkp9DHSsUP2ojBpUWTtmwFrEOW2aRpZQu
         mrCHTi2SignaYyA+tRIw5JPSoBSBP8NUJN3+wv+HiY6EFjU2I3EEnwpad6XedtqXvGLv
         BspYOYsJ4DeiE55f/G17zdUOEJ+OC94yxw85bZEDGpM4kATjTF/UAJjcebqCgBKLlGHB
         UuB0Tcie2gIC+RzfiN6ho3yQUADln27ari688UerqrKJsqRsLePRXyEgzCOYvzvB749J
         /Y0A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794593044; x=1795197844; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AvuG6GtWMhvBrr/UfnDRgGS1baAdJ+zbVL6VkOkdJWI=;
        b=iu0w5xvd6UNaogw3Dswvv9kqKi5By+0/CsBnnsknmOG8rH+N1njvG+TXWivi4gfDWr
         028Y8bCEntHR2XQoZMujsW5cYuyT8WMeZbOjo/9Qxcdo4o77gSO28mmFX1qXkrBXerzm
         fTo2wzbY64kb6SkEFLEicv6nEsgXURqWo1ItlAKWpgDHT3MxFT+fxR35LmbBbO0e9HEx
         Vmt63Q7yBhjkhOk+L9uHYRy9t9AJXTi0+uFkGBYe2DR17H4NNdIPQCvg1X5eKbuqkAX2
         WoB2NsD4IfaaM29AGhYaoh3GaEakF93CwE1JVcTSKig5IuKjnPHQ8rJ0cU98SaU8ZCVB
         Wz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794593044; x=1795197844;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AvuG6GtWMhvBrr/UfnDRgGS1baAdJ+zbVL6VkOkdJWI=;
        b=jfTGDfNcglCqi2ysDKKC2wxqxv4r6Y8IJBtobMQMpQ/q8giDM7DI1PrdMLY3FkqNnh
         r1txOO0hp+P3KhJyuWqjPv90+vxc8jQpaUCO36+tul7Uq3f6mHSiySJa+wpaC8eQyu4/
         CUDHjw5i1Fuzc5iDeOQ4UtedEue425u3PSzZyYQetZ38q/ZmEG3R9GTSLl1VMA7nS09j
         hlF88BN5982C8GLDWxs3+HKy1sFBkG+bkYsjaN5I5r8IumE/QlhyiRJTdCBYZcCs8o24
         VZRI4Hqg8QnHErsHQYS5eAVCZ2CQ6gy8qHLgWPe4bPy4LObWahFWWXikPYHJco995jyW
         yseQ==
X-Gm-Message-State: APuU4Z/vKAYeTVgXsPZtSAFhHKDwabfAIvWDNJS4KFx9WGeLXRK+fI8l
	hlKyHv868AHyhyLFYRK27T2ZG3XOWdUlTNpmigOqIYJEdIxN/YSzIVX04iwzebJ8AP1rqJmIlIz
	TrID26iZHmdlgvYUqw5odCN0ExWesG/g=
X-Gm-Gg: AYBFou05uPr/q/8CE4/2Ho8gwT4+L20JlwTA+d5kieXY7KEvu2pWnS5HDf81tFypljK
	sr24MXFba9y/ko3F4h6gbOcnli2pAB1NwLCcEFcPTRLAfKPz1081N4k86qKjmVQC060/61K/de/
	yxmj20j5S7Uco9zcx6gtrITsXj+uaHmyr4FqhKis8HqJj2t5Zp5OF2XFby4z0O2PWRboy5CEdCO
	Oi0Hjhf5YPyPIm8/4BEMOJibPSoJCtsg4uthC+u+ZNm/mvZZVFrfvbdaFa9H+RFunfaiUrYJ+Lc
	89/3GUUyChp5P4hoZqcL3h2v1Uo2xfWz89VQEKN2BrzcRdvZpxoG1pQxy+s+ZuGxRqybx4eHgKn
	rc+IYqzJUDoZ2GINAjJBzu/U8O6e1TKZhofK1+EJVuCO6tBbAD0CNxYzTTLdx
X-Received: by 2002:a05:6512:1326:b0:5bf:d00a:b6c0 with SMTP id
 2adb3069b0e04-5c17076e20cmr1662922e87.3.1794593043926; Fri, 13 Nov 2026
 10:04:03 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
From: Nathan Blomquist <nblomquist@gmail.com>
Date: Fri, 13 Nov 2026 13:03:53 -0500
X-Gm-Features: AclHuK_exSUOWus1xIZ4L7KKPBQE0Tcdq0rZid8M3XVe6gy4ouyQmR7N23pJ8g0
Message-ID: <CACOV87VBwH+R3eSBEOuz8hk7OaT63+A9m6ipPSW5wt1VhHMFPg@mail.gmail.com>
Subject: [REGRESSION] AMD IOMMU v2 failures on Cezanne; page-table flushing helps
To: joro@8bytes.org, vasant.hegde@amd.com
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com
Content-Type: text/plain; charset="UTF-8"

Hi,

Resending in plain text because my earlier email included HTML.
Apologies if you receive this twice.

Could you take a look at this AMD IOMMU regression? Since 7.4-rc1, my Ryzen
5 5600G systems fail to initialize Navi GPUs under v2 translation. Identity
mapping works.

The bisect points to bf5bdfd1f8d4 ("iommu/amd: Force identity mode for
selected GPUs only").

I've attached a small experimental patch and logs to this comment on the
AMDGPU bug tracker:
https://gitlab.freedesktop.org/drm/amd/-/work_items/6081#note_3782405

I found that my dGPU stopped working when trying 7.4-rc1 for a different
issue.

The patch enables the existing guest-page-table cache-flush handling
through PT_FEAT_DMA_INCOHERENT. Pristine 7.4-rc2 plus those three lines
initializes both an RX 6600 and RX 5500 XT, with no IOMMU faults or PSP
errors. DTEs confirm both still use translated v2 DMA-FQ domains.

I also tested whether the flush's barriers alone were enough. Using one
unchanged kernel/initramfs, both GPUs gave these results:

- Cache flushing: pass
- No flushing or barriers: fail
- Two MFENCEs without flushing: fail
- No flushing or barriers again: fail
- Cache flushing again: pass

The feature's other effects were retained in every mode. Failures had IOMMU
page faults followed by PSP KDB-load failure and probe -22. GCR3-only
flushing also failed in an earlier test.

So two MFENCEs alone didn't help, but I haven't ruled out the extra delay
from flushing. This is a diagnostic patch, not a proposed final fix;
performance is untested.

Is there a known Cezanne coherency erratum or something in the v2
table-update path we should check? Full logs, DTEs and diagnostic patches
are available.

AI assistance was used for the diagnostic code, testing and write-up.

Thanks,
Nathan

Subject: [RFC PATCH] iommu/amd: Enable cache flushing for v2 page tables

On a Ryzen 5 5600G (Cezanne) test system, an RX 6600 and RX 5500 XT
fail AMDGPU initialization with translated v2 DMA-FQ domains on v7.4-rc2.
IOMMU page faults precede PSP firmware loading failures and probe -22.

Enable the existing generic page-table incoherent-memory handling for
AMD v2 domains and provide its required IOMMU device pointer. On x86,
the existing flush implementation calls clflush_cache_range().

This is an experimental extraction for review, not a proposed final
platform policy. It enables this handling for all AMD v2 paging domains,
not just the affected platform. Cache visibility versus flush-induced
ordering/timing remains unresolved, and performance is unmeasured.
The feature also disables a single-page fast path and sets an ignored
AVL bit in non-leaf entries.

AI assistance (OpenCode) was used for the diagnostic implementation,
test automation, evidence analysis, and this extracted patch and text.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/6081
---
Base: pristine v7.4-rc2, before applying the c1diag diagnostic patch.
This three-line extraction was separately built and boot-tested once,
without diagnostic logging, mode selection or GCR3 modifications.
No GPU workload, performance, cold-boot or other-platform validation yet.

 drivers/iommu/amd/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2810,6 +2810,9 @@ static struct iommu_domain
*amd_iommu_domain_alloc_paging_v2(struct device *dev,
        domain->iommu.nid = dev_to_node(dev);

        cfg.common.features = BIT(PT_FEAT_X86_64_AMD_ENCRYPT_TABLES);
+       domain->iommu.iommu_device =
+               &get_amd_iommu_from_dev(dev)->dev->dev;
+       cfg.common.features |= BIT(PT_FEAT_DMA_INCOHERENT);
        if (amd_iommu_np_cache)
                cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE_NO_GAPS);
        else

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
