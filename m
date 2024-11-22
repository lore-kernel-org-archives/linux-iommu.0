Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F7770823
	for <iommu@lists.linux.dev>; Fri, 22 Nov 2024 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732302790; cv=none; b=V0althvzoGULd8E3xTYqWjm5gbnBsqFF+hAPYsz9YhX+loMqUi6LI1BUFFGz/rxC4mVcejNDbNvpqJ+MYsOP3lVTE4k3DVFJeNz2DfDV8tFgIxEOpqwS7Swr8TiVaDSJY3M9xVfDaAlFC9XdT/SiX2aUWCc7JnJ1Brc3OOSdUOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732302790; c=relaxed/simple;
	bh=oakw8+XY4AN7yNYYnecM37ro/z2XazBxuuT0b1kIHGg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NxafKtRYpRjYHdy1764qCd52r5rZ1e9QR8WO0ZdkxnYEVG4b/KfD/Rtj1iidDUeCWghFX2G85aT3J5RyYGLFSaWjRrBZ1I6utipWxYzp8OCTyPdAacVLhk6Gm4ZXgu6EJBp0x/yMiotFT6pHbdy+FAooYkkb0wqHqM0XpCZpv0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKz0kxVd; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKz0kxVd"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb388e64b0so30313041fa.0
        for <iommu@lists.linux.dev>; Fri, 22 Nov 2024 11:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732302787; x=1732907587; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MmhAPFg8VWswXC5OFRdt2CqQSVXzZpyoAGzuccpRgd0=;
        b=OKz0kxVdngkmaOe/bA9c+x6GyMEc/tm/gj5g3Exwsgx8g+lcov4L+aJErG3LWLsPM8
         wNWp2OlVdT1Alv0pm8EohyHP0ciIiymjhde6M2g1j0hED70yPYCRlDIxihFiJFWTf9D6
         DG7B4alq/psdyBb/OzWEz7r5oLjp2QACTxxa1GmVaZR2D4Fag9ooia4/6BShSWN85xF2
         /ChmsCQNZr6/mH0Mng9DqXKSZoJcJXk0l4Q4QCZlNtu0Qfz9SWHyLKbbS9ctaE51rc/c
         5n4035N4u4mJS1/2DZPVkPiqxMJ+Kmmok1qRKWDUsSTNGVtWbbbPqLlTB4ywGZJX3Ega
         G+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732302787; x=1732907587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MmhAPFg8VWswXC5OFRdt2CqQSVXzZpyoAGzuccpRgd0=;
        b=whmnA5l2qG71sUom/p3SjygHVkrfXLNk3vWOlXGtuH8y1vRg1/JdfFUGQnPZ0NB9Kg
         a+qFwcbHsWvQ9CuqHeHa0w6QrJ8xAEOmVPuXbl+DYItJrmb+5rVvpzmnbz8agp0BeE+I
         U0QmX8BW/ysesohdErSyzrWJiTnZWqjPfEz1DaPrBNn2bnyIJJdvArBzqPshSrqHYSGp
         g1PFV6UQG7nZ+NZKa5zoUv2IECLDxO24Xc0OhgscKwa+kmIBi2NfRnCpxFWvFdPvMuV1
         mm7wekthMPrmhFvIzLU8l42ojX5yomMwI23ROCrbgz9C+7ObQe4bSDZ124bio3pUM4DA
         FowQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlSA1gbT1I0BpnFaE6JEMHOVhrtkuHkYuEzWtkxazqTZrIubcKLps8P0qx//bMx2TsTReJ5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YygUpdhkJWNsG61CIIApEvSxhm2U1sSUvmfxvcVRDpdhKh1cuBG
	VwBxTigRhXYX0vwFoKEH1L5z8RhSjZ+Lh9KVw/t0yyue0EnBRYCZ
X-Gm-Gg: ASbGncuWuvh05ytiK2jeMmAF9hy8pEeXj+hxjskoKGf2UtaVGyIVNigFKL/5DupCqpH
	UiBLXSHk1uSk481rAuy3M24tVquqoDkA9jm4f7fUthVEd9jz5jQps/ezYoMELPFTjdbykl/UeCF
	peJoFmfgXK+NgECG1hZLL3KvYWT+u0rHJyPCWBqcSFCJO79GqCH2DBuNJAlDscdygUn7DpOTsfc
	F3uH/hBRFhYhGk+ZMBg0LOYgktc1Ig5lByJZOZqj8+neI/GU5yvqV8nKPnxTcFWr5Nj6ZgoDV5F
	iGk=
X-Google-Smtp-Source: AGHT+IEJnnz2ws7578AwFzClNuJMA6lqwaqtty2dfYSabcM3lmWruFaTYyaxwsksR6t6QiHU95JFQg==
X-Received: by 2002:a2e:a58d:0:b0:2fa:d978:a6a2 with SMTP id 38308e7fff4ca-2ffa716cecamr27950521fa.27.1732302786448;
        Fri, 22 Nov 2024 11:13:06 -0800 (PST)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d41af2esm1196320a12.84.2024.11.22.11.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 11:13:06 -0800 (PST)
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Tianyu Lan <Tianyu.Lan@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	Raphael Isemann <teemperor@gmail.com>,
	Cristiano Giuffrida <giuffrida@cs.vu.nl>,
	Herbert Bos <h.j.bos@vu.nl>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: [RFC 0/1] swiotlb: Mitigate potential DoS caused by BUG_ON()
Date: Fri, 22 Nov 2024 20:13:03 +0100
Message-Id: <20241122191304.4182642-1-bjohannesmeyer@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We identified a security issue in the swiotlb unmapping operation, stemming
from the way some drivers save streaming DMA addresses. This issue can
potentially be exploited by a malicious peripheral device to cause a
denial-of-service (DoS) via a kernel panic.

**Disclosure Context**
We previously reported a similar issue to the Linux kernel security team.
However, they advised submitting such cases directly to the relevant
subsystem maintainers and the hardening mailing list, because Linux
implicitly assumes hardware can be trusted.

**Threat Model**
While Linux drivers typically trust their hardware, there may be specific
drivers that do not operate under this assumption. Hence, we consider a
malicious peripheral device that corrupts DMA data to exploit the kernel.
In this scenario, the device manipulates driver-initialized data (similar
to the attack described in the Thunderclap paper [0]) to achieve a DoS.

**Background**
Streaming DMA is often used as follows:
(1) A driver maps a buffer to DMA using dma_map_single(), which returns a
DMA address. This address is then saved by the driver for later use.
(2) When the buffer is no longer needed, the driver unmaps it using
dma_unmap_single(), passing the previously saved DMA address.
(3) Under certain conditions---such as the driver using direct mapping
operations, and the mapped buffer requiring a swiotlb
buffer---dma_unmap_single() calls swiotlb_release_slots(). Here, the saved
DMA address is passed as its tlb_addr argument.

**Vulnerability**
It is common for drivers to store the DMA address returned by
dma_map_single() into a coherent DMA region, which can be manipulated by a
malicious device. For example, the E100 driver and RealTek 8139C+ driver
map socket buffers into streaming DMA and save their DMA addresses to
coherent DMA data. While these drivers might assume trusted hardware, this
behavior is not necessarily unique to them.

If an untrusted device corrupts the DMA address, it can influence the
tlb_addr argument passed to swiotlb_release_slots(). Inside this function,
tlb_addr is used to calculate aindex, which is validated via BUG_ON(aindex
>= mem->nareas). By manipulating the DMA address, an attacker can trigger
this assertion, resulting in a kernel panic and DoS.

I have a PDF document that illustrates how these steps work. Please let me
know if you would like me to share it with you.

**Proposed mitigation**
To address this issue, two potential approaches are possible:

(1) Mitigating the *initialization* of attacker data: Prevent drivers from
saving critical data, such as DMA addresses, in attacker-controllable
regions.
(2) Mitigating the *use* of attacker data: Modify the handling of critical
data, such as in the BUG_ON() statement, to not result in catastrophic
outcomes like kernel panics.

While approach (1) is more complete, it is more challenging to deploy
universally. Hence, we propose mitigating this issue with approach (2):
i.e., replacing the BUG_ON() assertion with more graceful error handling.
The attached patch implements this change, ensuring the kernel can handle
the condition safely without triggering a panic.

**Request for Feedback**
I am not deeply familiar with the swiotlb internals, so I would appreciate
any feedback on the patch. In particular, is there a more graceful way to
handle the error than returning?

Thanks,

Brian Johannesmeyer

[0] Link: https://www.csl.sri.com/~neumann/ndss-iommu.pdf

Brian Johannesmeyer (1):
  swiotlb: Replace BUG_ON() with graceful error handling

 kernel/dma/swiotlb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.34.1

