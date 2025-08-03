Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C0D2E36F0
	for <iommu@lists.linux.dev>; Sun,  3 Aug 2025 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754219969; cv=none; b=cMCurax/Fhw4cu3CixFzzdKMrdjUxnnN2zyEjekJ50fmEYV8tyAVzNeCa6Kq05Po+gjq4hRBMARKzZFMSxipFR4elPVXX/TVJiZXSOPPZeEwcE3JFxggcAh91f1n1jRxUVWsBjv5pO6+V/o5CEOGdofiPCUs45yPuVS3FKmLGKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754219969; c=relaxed/simple;
	bh=JEIqAaeSSTe4zb2P158wF7vNe9WridvvCtdLwz+gNKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=iHSt5heAYUyt+g2FKAaQdUBiAopGEi6alQaq0jsmjGVPktoT1U05BSHNLzgDrBmiH4Jbre7PMagKuGMHV0N2+JDdWCKJ1gS4NPD96RJq0GWuMGjOIYYRh0dx628YgCJ4Pbzm6RFE7SDPl3qh+s//1zDZo+jYaMSw1tNuRdaD38s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com; spf=pass smtp.mailfrom=infinidat.com; dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b=Y2BK0DH5; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinidat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b="Y2BK0DH5"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-70736b2ea12so12287276d6.1
        for <iommu@lists.linux.dev>; Sun, 03 Aug 2025 04:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infinidat.com; s=google; t=1754219967; x=1754824767; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Cqe+T/w1aqF8D4toCcW3enb5tvbSckuBh2Yh9OKkf4=;
        b=Y2BK0DH5aDfMc3Krm8oQS92F0Dbb7pHqIgLQMQgRIN4Uz9BAE5u3bmo3WDTXZf3xSW
         V2NS/wSPlQPfac1hZ3E7ODPNKFbgLOFkwnlweBpVcUv/zas4lNMwRU2DFzxJ6JIND5wM
         1Jv8Ah5+m+q/iUBSRtG6AcDiFjnLHBDB25p8kIW65rFHITmAZPi59pyGwZF9Ymczx+Oy
         Sxs1R43/+0p1dnNUBkyOOjYvmlZ0bm2ooTD4ISmZJdPU6o+wAVa/zMr2gM3BXykhfR4m
         Im/3wq6CbWmbijw5tncqMeVztCH4GKPIhUcTU+sloxM3daLdKzKq0HrsoOPUZxaDosWt
         uZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754219967; x=1754824767;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Cqe+T/w1aqF8D4toCcW3enb5tvbSckuBh2Yh9OKkf4=;
        b=s3t9zPjFZqTNwINRY1DlXu3tRsijupy9J8R3dJcbaHDPRzFBTzD7Y3xddOavhOlkUL
         4ckAW1OhCtLjAxjqgqBqPYJ+pZRTilaXAnsnGiYVy1u2tqzTfhtzmAwhwvZ69AfsZWaQ
         tHc7675HquHaMzD6HFYQTVbkyfibsBMBwt4AkrPd8eLEbRws6oQ41ipdtB2LjFjrp89T
         wd8rhbLSvz3cHdzkv7pu5GVviWsMxzh08GqqM3L5t1HB/48y4w7fgKA0ikW8cHsuFat8
         ayiGhl5fZ0ASBg5cU+7tg67YQtLPIfnv6hzczMYlX4DEgw4faERSdT96ULVVdpEBa1Xw
         +i7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAebtCM6IYVMfUR919qBzLCvMbmvaJ+6kDLnmaLs87heXI7IvdL3D8dF6s4Y/XY6CxuSpHYw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxL4Dj+pR9d15Ga/IEQg30Af0pyUckSR75bVo9tHmxwiZx+gfLq
	dLsHAV16LGzpThpZZMIjrrApFbiujNvK4IwXvtUJSBD/2A8Usogx1Cl4nXxfz/0tVNlh9GMmG/T
	didrEGoqMWnz3v5uftN8j9i7Pe0mNN77dbwklRZBBfw==
X-Gm-Gg: ASbGnctLIZYsOnPyo2gqfqDeS4CUUdOv8LbVFFPoQUaLIVz1A8x0jxSraYBYRIsktR1
	3tmYv9FMgcDBeQMCMbpFN33JNA+WNfGG7DK8gRYRtDRWsSEkA4V1h5vgYCwG5L3DxT+Dua7LIzv
	ixIKPVbZWOTYYw1nIlQS8RFayjS5XxV4nnRFxPZBntsob1TR/8VzN67fZDRwcr5kTZWLTSFI9i3
	GBX2FhuZQ==
X-Google-Smtp-Source: AGHT+IH79hbBNueSlF5JYIs0NnPGvu1eDl8QSOMF0wuYP7PZ6tZU7zZDhIxvohJOgZdaJoq7voHH1e53bSYfSP3+lt8=
X-Received: by 2002:a05:6214:d6a:b0:707:c63e:abf5 with SMTP id
 6a1803df08f44-70936346a27mr91242696d6.49.1754219966617; Sun, 03 Aug 2025
 04:19:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAEHaoC2BWe+0Ps2oU-0xPDLFYYKG-o9+_ynFgh7u3qqyRDtrTg@mail.gmail.com>
 <CAEHaoC22NDpHUWovJChCx_XqchkEvUPYrFFe_L1PH9Mw2e386A@mail.gmail.com>
 <CAEHaoC2bi3VUEuoWKgHbgUFfdxmACrhkjaQ9Jni-4-ByP5tYJg@mail.gmail.com>
 <CAEHaoC3ZMvHe7D-JX9bfM9hfSPs0QV-og=om5eKFFqSL=tpjcw@mail.gmail.com>
 <CAEHaoC0Au_0yLRKSnDg=_qjnmDMmbJ=Nff+W1feEBTib0Jb_gA@mail.gmail.com>
 <CAEHaoC2ZQAd+h=7mKPOuMfAMex-41soD8=kx2vR_em+i71oBRw@mail.gmail.com>
 <CAEHaoC3t8nFhR4MAYV1AaR5mjN4ndkkWrKUyBY_smbtpDykAEA@mail.gmail.com>
 <CAEHaoC1mHQp62GMBofGJwKBkjgf8rQr_tUxwESKa7Ehd6_3nWA@mail.gmail.com> <CAEHaoC2JjQ0k4B3T1eK=4OhwTE_JxwgZ5A=nBjheR5Ehspwj7Q@mail.gmail.com>
In-Reply-To: <CAEHaoC2JjQ0k4B3T1eK=4OhwTE_JxwgZ5A=nBjheR5Ehspwj7Q@mail.gmail.com>
From: Constantine Gavrilov <cgavrilov@infinidat.com>
Date: Sun, 3 Aug 2025 14:19:15 +0300
X-Gm-Features: Ac12FXxlBbV7sfM_8D5fHaGgujdshUelpXKeJxFm84ezztxpfxBfdMc4uiMweOM
Message-ID: <CAEHaoC1uCJ98JsYt4x2cHwOM6EvLotj5MTNi=1iGSfc3DOD3hA@mail.gmail.com>
Subject: [PATCH 8/8] Large DMA alloc/add min_dma_addr to device struct
To: linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

This is the ninth patch from the set of patches that enable large IOMMU
DMA registrations. Entire work is available at the master branch of the
master branch of git@github.com:cgavrilov/linux.git repo.

Some devices (like NTB or GPU) allow mapping of the system memory to PCIe bars,
allowing to implement PCIe interconnects when devices are connected to more
than one root complex. After one root complex does the mapping, an application
on another root complex can access the memory using the PCIe bar of the device.
Since a typical system memory mapping uses offset translation (between the
device bar address and the DMA address), the device driver needs to know which
contiguous DMA address range is available to satisfy the device needs before it
can set up the mapping offset. After querying the available range, the device
driver can set up the mapping translation and use the top and low DMA address
constraints to ensure that future DMA allocation APIs will allocate DMA
addresses within the selected range.

This patch adds min_dma_addr to the device structure and uses the added field
in alloc_iova_fast() API.

commit 0bebd4d0829b941fc38c1311efa7309c033968e4 (HEAD -> master, github/master)
Author: Constantine Gavrilov <cgavrilov@infinidat.com>
Date:   Tue Jul 1 15:29:40 2025 +0300

    Add min_dma_addr to the device structure and use it in
iommu_dma_alloc_iova().

    Devices that map memory windows to PCI bars (for example NTB devices)
    may need this change. This is because such devices may use very large
    memory windows (terabytes in size), and they cannot simply cap the top
    DMA address to the size of the window, since the range [0-window size]
    may not be available. Such devices can find an available DMA region by
    calling iommu_domain_get_lowest_free_address_range(), set up the memory
    window, and request DMA address allocations in the found range by calling
    dma_set_min_dma_addr() and dma_set_mask_and_coherent().

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 414d31347fc2..077d1cd0939d 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -810,7 +810,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct
iommu_domain *domain,
      * expected address bits are wired up between the device and the IOMMU.
      */
     if (dma_limit > DMA_BIT_MASK(32) && (size - 1) <=
DMA_BIT_MASK(32) && dev->iommu->pci_32bit_workaround) {
-        iova = alloc_iova_fast(iovad, iova_len, 0,
+        iova = alloc_iova_fast(iovad, iova_len, dev->min_dma_addr,
                        DMA_BIT_MASK(32) >> shift, false, align);
         if (iova)
             goto done;
@@ -819,7 +819,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct
iommu_domain *domain,
         dev_notice(dev, "Using %d-bit DMA addresses\n", bits_per(dma_limit));
     }

-    iova = alloc_iova_fast(iovad, iova_len, 0, dma_limit >> shift,
true, align);
+    iova = alloc_iova_fast(iovad, iova_len, dev->min_dma_addr,
dma_limit >> shift, true, align);
 done:
     return (dma_addr_t)iova << shift;
 }
diff --git a/include/linux/device.h b/include/linux/device.h
index 0470d19da7f2..339c9187b033 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -621,6 +621,7 @@ struct device {
                          64 bit addresses for consistent
                          allocations such descriptors. */
     u64        bus_dma_limit;    /* upstream dma constraint */
+    u64        min_dma_addr;    /* force minimal value for DMA address */
     const struct bus_dma_region *dma_range_map;

     struct device_dma_parameters *dma_parms;
@@ -690,6 +691,8 @@ struct device {
 #endif
 };

+#define dma_set_min_dma_addr(__dev__, __val__) __dev__->min_dma_addr = __val__
+
 /**
  * struct device_link - Device link representation.
  * @supplier: The device on the supplier end of the link.


-- 
----------------------------------------
Constantine Gavrilov
System Architect and Platform Engineer
Infinidat
----------------------------------------
