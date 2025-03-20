Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4233F2147ED
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479689; cv=none; b=Gh10guM/NBadrRNjMitmn2rMQ3Chi9gPOw6+zovJcSvDPJvkJ+IsFlGABLsMRrE5AQdui377swGsKW5En131WjsH5Qv+ljeZ6I78afp/8zjGDPab2vMuIkbyRqAeXgdIDWfh/GWoBv/1jFw1UW8lKzKhp46aS9xGXDZXAj1YfHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479689; c=relaxed/simple;
	bh=L0Ns8xc3Q3br2dzt9w3k8ad2LcmDXSY7pM/vbS+5JgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WH2kS8h8UmA5NakQx5Af98Cv/jH7UrRQoPox2cVR9sS0Mn4n0koX2xzA+VCqvmik8avtCnuZjN4uG7js6IPwbQfCPsJm6uSluaTj8GkToo6R1pKW6oEqmOSUkvAJkfHHa84IYsgc2+XwXilm+3GFfHSroUeZ/QfDadz4oZW6A+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dnRdsE6E; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dnRdsE6E"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5499c8fa0f3so1043737e87.2
        for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 07:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742479685; x=1743084485; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GW+AIfrfnZlEZ1i2OuNqT9lfOEs4AghqG0/GPy1/W3c=;
        b=dnRdsE6E6IdnfzD3QFsEYHYR+Je/acY5Txz3QetpVHsHulN9N10pTS54mS4o9PfIyY
         A+w9qH3bqq+8O4eXT0iN6iL2rhk+kmz2LtU1lCWSJ89aUaXYVoO4qxzhpMFT/p2YUuPW
         i83Paexa3Qpjn9czI3wgVnoRKEcjaQKoiV0Mq1JwO5+RBnKtbD781iDbb0Tww/McXmey
         A03/HItnrJxNPHLeJ5It7pDfD7Nbevvzq83tR/74pJ07SD17azh4YoDyrx97iP2YX380
         PwJ1gg8Hk1QSHjHe6TEWkdoZw1jDo8tgSN0wMAfrHaIcwAKRGeVdOea7Bglxq2wzQY7a
         DFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742479685; x=1743084485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GW+AIfrfnZlEZ1i2OuNqT9lfOEs4AghqG0/GPy1/W3c=;
        b=QN8PCX++MGA1TOd7jQRvw9WL0bBxGAGoQ8LwdDTSlAbK5xnWmsWJzaBVWqjae1rfwx
         T5RKfDneDnMXcGsoC/ijFsztgm1KVuqctGDfWdzF2RzW4QhXSeeLzwwI+ZuqQVzGa+p7
         mx/Q9O1lfHPQ0r1Qa07gtPmk3llZnps8YxnFrtaLFaLOSPdDFWHqS3P+bhhxFPca+o/p
         rAHCGeWtfem0QcTYIzH5RZxMThpMN98Gfq0o05uUxf2/xoM9l8O8svjj2ZeeCQd3aJYn
         mA/w/iaHLKHnCa9YX/nMr4+qh0pq2OQ3voidaRlsCyPxQCzeIg++qruDC9nlmpn1oBEq
         Uvlw==
X-Gm-Message-State: AOJu0YwpE4mpGRzycGoGsfx+BnwADXMbpydfa34F1fSoM4dOikE3ET14
	stLiK3JO1I4ylWCEnwMBwnCsZz1xZA//Cb0hmB+p78uepEsZ2DIemYBk0ky/vVDOmY+HJSlbLkG
	O1mocqoG+O0snTFSvpyGqXGpJynfRZezofN5dCw==
X-Gm-Gg: ASbGncslAZ3dxN6sOn5HB67R6KUeDm727KC5lIgq1PGQS0DMORYNQC/9hmUbPph87Hq
	Y76vxtyeEK6I7EGurZHXCgnPyc1G2jbJjzV9VDbpe5IzBwiOqHMD077PBwwdhI2bjOT8vkvUHOr
	blpRTqu/wifhRYgu7JfaNW2vbofjy5XKM=
X-Google-Smtp-Source: AGHT+IE0nZc36emahZKbVDAnCMDyH/ywSdu+VkMSO0TuJrJF/3VJxt+BWvKKWZTm/hV640C6sCQwdH4kYd9L7GQ0dLg=
X-Received: by 2002:a05:6512:238f:b0:549:b0f3:439b with SMTP id
 2adb3069b0e04-54ad062afbbmr1432242e87.16.1742479684999; Thu, 20 Mar 2025
 07:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250315101032.5152-1-zhangfei.gao@linaro.org> <20250317011352.5806-1-zhangfei.gao@linaro.org>
In-Reply-To: <20250317011352.5806-1-zhangfei.gao@linaro.org>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 20 Mar 2025 22:07:52 +0800
X-Gm-Features: AQ5f1JpZtpDjBufurDoU0Dm8aec8lXWg1YWzfL8ksZ4Km8I3bD8mNe2JhE6E6Y0
Message-ID: <CABQgh9H3POdKGsphA42C+i2_z9xCHHfSm4ULkMVmFyKBm9bWtA@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: Declare quirk_huawei_pcie_sva() as pci_fixup_header
To: Bjorn Helgaas <bhelgaas@google.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, Joerg

On Mon, 17 Mar 2025 at 09:14, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
> The commit bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper
> probe path") fixed the iommu_probe_device() flow to correctly initialize
> firmware operations, allowing arm_smmu_probe_device() to be invoked
> earlier. This changes the invocation timing of arm_smmu_probe_device
> from the final fixup phase to the header fixup phase.
>
> pci_iov_add_virtfn
>     pci_device_add
>       pci_fixup_device(pci_fixup_header)      <--
>       device_add
>         bus_notify
>           iommu_bus_notifier
>   +         iommu_probe_device
>   +           arm_smmu_probe_device
>     pci_bus_add_device
>       pci_fixup_device(pci_fixup_final)       <--
>       device_attach
>         driver_probe_device
>           really_probe
>             pci_dma_configure
>               acpi_dma_configure_id
>   -             iommu_probe_device
>   -               arm_smmu_probe_device
>
> This is the pci_iov_add_virtfn().  The non-SR-IOV case is similar in
> that pci_device_add() is called from pci_scan_single_device() in the
> generic enumeration path, and pci_bus_add_device() is called later,
> after all a host bridge has been enumerated.
>
> Declare the fixup as pci_fixup_header to ensure the configuration
> happens before arm_smmu_probe_device.
>
> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Would you mind take a look at this patch

Bjorn suggested
"I think there's some value in keeping fixes close to whatever needs to
be fixed, so since bcb81ac6ae3c came via the iommu tree, I would tend
to merge the fix the same way."

Thanks


> ---
> v3: modify commit msg, add Acked-by
> v2: modify commit msg
>
>  drivers/pci/quirks.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f840d611c450..a9759889ff5e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1991,12 +1991,12 @@ static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
>             device_create_managed_software_node(&pdev->dev, properties, NULL))
>                 pci_warn(pdev, "could not add stall property");
>  }
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa251, quirk_huawei_pcie_sva);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa255, quirk_huawei_pcie_sva);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa256, quirk_huawei_pcie_sva);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa258, quirk_huawei_pcie_sva);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa259, quirk_huawei_pcie_sva);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa251, quirk_huawei_pcie_sva);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa255, quirk_huawei_pcie_sva);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa256, quirk_huawei_pcie_sva);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa258, quirk_huawei_pcie_sva);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa259, quirk_huawei_pcie_sva);
>
>  /*
>   * It's possible for the MSI to get corrupted if SHPC and ACPI are used
> --
> 2.25.1
>
