Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E988854665
	for <iommu@lists.linux.dev>; Fri,  8 Mar 2024 09:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709891671; cv=none; b=RfXPPraR1kkRLpEGkodJ+pNw8p37e76e+shWXsxRJDaXjx85RGlVrdyC7Pg9mr5EdP9+um4lQSQCTgF77+FPAMr82M995zlLxa93a4eJk9TwPLXLSTmBvoWkXCXRsjbsyWtCccl56WUcNPdDarxZQpaAIIxMJ5DMs5V/zqD23xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709891671; c=relaxed/simple;
	bh=2J7Nzqccs+PocVsE1rrOfFtZ8ba354puPJU+yD5FDSI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bX6f8PEVTMGNp4vtjzoZfXoeckR671QD0zpH0o8rtzqZ5LaD4+kGNfLEKCFfOOcByXPvpjk93ev4aecN6sYSCCvlYdYIJVXgfje/r3mSxl6BvvybqMJD6kbsMMiTdzlZARhfZoGvSUW2rPBw1/w4/r84qr4NmV0SWdV94aDNekM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--howardyen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SBuyWRpG; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--howardyen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SBuyWRpG"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26ce0bbso4037163276.1
        for <iommu@lists.linux.dev>; Fri, 08 Mar 2024 01:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709891669; x=1710496469; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DCte3zDfFDpzFxFJ3x2DLLBJKe5cc/Nrxxv7q0fm6Fk=;
        b=SBuyWRpGxDxK+A0Gn3DxVzya51c11/WpXiINxkmkvmcrq3H79N73c918WzTwWQ/Uv4
         0Rqw2sI+2tzkGRrJU3h23W584/nQRBmCR7VHPNGOim8vRK5PbGxggR+HaPnvcwpGd2dH
         njFoDNvxl0vnuY5cKTwmJFG11QNGsXUfCs/T6rkcHvkIYSPBO0boZfcQ5JGPuU7NiBgA
         fugXKd7EdEQQ5RD7tOOQXbVGXq5P2RlFseJ0QdYZY6o1NCdcJQYaPM4LJPR8jNEtkoZU
         DZP2NdEitjAShZ5LzF4RTDXvEjKt0L0+fv/qXEWRfofNmEgtgVrlvaGTpxEyXgaPPNJA
         tVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709891669; x=1710496469;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCte3zDfFDpzFxFJ3x2DLLBJKe5cc/Nrxxv7q0fm6Fk=;
        b=D2udNZoww3/oYdSwtb6qpQ84wbCfkjS8TedjXfdCVIlDwUIcPdTb8xR4dLxgfJaphy
         /ugLwzFVSiwEAmIhHNaj9wiEwb3zXeASnqJ9VVq8KgJNrbfy4qvqTPkl5LWvW/8WTAbN
         Y7fpSeHK+ZPBJqYYeNLOdwtU847YUNvIxebX4srQezSMa/RgZtRaN44T+0pTerJ05ogo
         7DecKk7sazvXoBhCdRP+nlMELL5868hsNKmoh3P0bJqy2u/ReSORoaOJ0Piy/ym9khWe
         u3JlkorZN4OKUSkqfZGdBMsbM6StVOB1AzsKrFKEQ6nxNd2RIif8gi+ReUQr/BvCIa8p
         Gl/w==
X-Forwarded-Encrypted: i=1; AJvYcCUgzgBY9/iF1WN9Qib000MNsLNPaAhXcYxDXMSfbH/B2zdopGItGt4EKwPl9J8um1Q0H0aLXiV/VlCRbE9E55yT9fulJPA=
X-Gm-Message-State: AOJu0Yy+j2rG2Un1lMhB4WoAwdoRs+Dop8u30RxuVfbkLJD0tRIgOjtD
	xszIrksl0Mr/tiJDvKSe1Vd42AttIFrxR1N2CfHpM6CFb/uOAyN9fGxVQwFGbJgG3RJ6kINb2w9
	g7iereYVJiCJyPg==
X-Google-Smtp-Source: AGHT+IHvpLjAs9VWFhYi5i6yfYYbG4bZhXBRHRVlH/JfJzYRNMcsMntGozCSfEkyWoEyyvObEjmG4PLuMEM4p2U=
X-Received: from howardyen2.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:16f7])
 (user=howardyen job=sendgmr) by 2002:a05:6902:722:b0:dcd:875:4c40 with SMTP
 id l2-20020a056902072200b00dcd08754c40mr5533087ybt.10.1709891669006; Fri, 08
 Mar 2024 01:54:29 -0800 (PST)
Date: Fri,  8 Mar 2024 09:53:20 +0000
In-Reply-To: <20240308095320.1961469-1-howardyen@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240308095320.1961469-1-howardyen@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240308095320.1961469-3-howardyen@google.com>
Subject: [PATCH v4 2/2] usb: host: xhci-plat: add support for multi memory regions
From: Howard Yen <howardyen@google.com>
To: gregkh@linuxfoundation.org, rafael@kernel.org, mathias.nyman@intel.com, 
	hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	andriy.shevchenko@linux.intel.com, petr.tesarik.ext@huawei.com, 
	broonie@kernel.org, james@equiv.tech, james.clark@arm.com, 
	masahiroy@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	iommu@lists.linux.dev, Howard Yen <howardyen@google.com>
Content-Type: text/plain; charset="UTF-8"

The reason why it needs multiple regions is that in my system there is
an always-on subsystem which includes a small size memory, and several
functions need to run and occupy the memory from the small memory if
they need to run on the always-on subsystem. These functions must
allocate the memory from the small memory region, so that they can get
benefit from the always-on subsystem. So the small memory is split for
multiple functions which are satisfied with their generic use cases.
But in specific use cases, like USB3 devices which support the stream
trasnsfer or multiple devices connect to the host, they required more
memory than their pre-allocated memory region, so I tried to propose
this patch to give it the ability to get the memory from the other
larger memory to solve the issue.

Signed-off-by: Howard Yen <howardyen@google.com>
---
 drivers/usb/host/xhci-plat.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 3d071b875308..79e743aab62e 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -149,7 +149,7 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 	struct xhci_hcd		*xhci;
 	struct resource         *res;
 	struct usb_hcd		*hcd, *usb3_hcd;
-	int			ret;
+	int			i, count, ret;
 	int			irq;
 	struct xhci_plat_priv	*priv = NULL;
 	bool			of_match;
@@ -194,6 +194,20 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 
 	xhci->allow_single_roothub = 1;
 
+	count = of_property_count_elems_of_size(sysdev->of_node, "memory-region",
+						sizeof(u32));
+
+	for (i = 0; i < count; i++) {
+		ret = of_reserved_mem_device_init_by_idx(sysdev, sysdev->of_node, i);
+		if (ret) {
+			dev_err(sysdev, "Could not get reserved memory\n");
+			if (i > 0)
+				of_reserved_mem_device_release(sysdev);
+
+			return ret;
+		}
+	}
+
 	/*
 	 * Not all platforms have clks so it is not an error if the
 	 * clock do not exist.
@@ -431,6 +445,9 @@ void xhci_plat_remove(struct platform_device *dev)
 	clk_disable_unprepare(clk);
 	clk_disable_unprepare(reg_clk);
 	reset_control_assert(xhci->reset);
+
+	of_reserved_mem_device_release(hcd->self.sysdev);
+
 	usb_put_hcd(hcd);
 
 	pm_runtime_disable(&dev->dev);
-- 
2.44.0.278.ge034bb2e1d-goog

