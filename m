Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD3A221F25
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744027028; cv=none; b=amhyHSpyzzm/dssajpNSVtKTdHSxoxXSQAUN1SODy5tTUmdUShLrsMTj0hZbYJb2BRK7YGvR3ur48peqF7wb91OwBUgKeZx2Ros47niyEv2gieokUaFbVpsn1p22LA5sODstEgsZb4JBoh6SbW6Au4LBw0QSSWI3KbuTEW4roe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744027028; c=relaxed/simple;
	bh=PbdMhMfjBduUwZfF5rKVVOOwgvHETSCbxx9ro5sIPQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgqILdkG3aXvfE3asq6JnFs0I3HnHS7tW/ngUbeQHuCKHi4SlcvC+LhXSjJpfR4HjgYcJCGQYq4gpPFo96JbPyMFZytM431zCw5yJ3yzPIza1b5mZ1OhF1h28dT/UBXV5Sh3hcmj6eHrURMoIEK5ut96guqMe0MrnYnCaVJds2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hX79KQ4t; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hX79KQ4t"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30db1bc464dso38674601fa.0
        for <iommu@lists.linux.dev>; Mon, 07 Apr 2025 04:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744027025; x=1744631825; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VuEAK7onIXipyZd1ca+l7EoIcSYMPQnsm7F6wcaYXKE=;
        b=hX79KQ4t4J93wWMVnc5q5Y420Zjavi2XLEkH/XC+U5CQe19sI8xWl6iFbKBSbHnsjk
         LgRFL4LqpWMj6M09AokxPpzf/pGYm2slBvOCslwjoKtTdWLyx+VdTx8YYkSQKk4+nmbW
         TsEhqKju/GtkanaHn0vfqyes7M0oEL2BurVdR10M+0g/JBUTjAqH271gtCwEMAGIPhXh
         fWokrW0R5uwgH5m1lehf+BMydVJ7/Cz5K1OVRr8E4aN7GT6+sSyr53Tw2LYMB6gcH11B
         I15nER9FxsvMJskyim1oQyOyXDUVdB/sxUpsEz4gthpGC+CnM7iwHG17uHc2Ye0hjRDB
         nGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744027025; x=1744631825;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VuEAK7onIXipyZd1ca+l7EoIcSYMPQnsm7F6wcaYXKE=;
        b=JEvaRdMVN/6OOc0t9QHPgRXIM2ljkMcrahYYVLzFuwuAYpFYuXkYfPOtsKkvMgInU9
         bm+MDL8IPpO3Ok3kt706HKGHDUXPC/hvg216sgOrujTv3scM6p3vbjqsGiWiq4d+Amka
         8Q67DkcI8oFMMxlOJVb5Iwn8PhZy+PvBGp1iygRY+eGFCdQ1sVjLiPAG1r8nnnbWB1rb
         3voaSgz4XzFkjNu6p/2HVo3kuEkeFNRYxb61cQWodlIMmHQI9SANLOOWV9gNrFBulVA0
         Mz6b3vJ0eeY3M1foBws53F3mMDV+jzFA65eN1Cg3bGlcECgnfhZdPzw9We8GFePqpM9F
         UGPw==
X-Gm-Message-State: AOJu0YxJfdZEy2OrU6PX9nvwgR31O6LcFRQ/+VWnJwgsgLr2PJaeY1zS
	UQWdmph2uC1W5UFsSnyrck3/D7qtBWWt/4om3d+3BseUyzqQzqwfcydyP72dwGrYuWWggSssnOe
	zmMp4RacUkWIbgRHxjzGGKsg82g8co3KtChPsIA==
X-Gm-Gg: ASbGncscN70UlBw6hf4M2ifL9p4z1zRvR8BdigmnFLlTVXEvk8wPjevmr9ZHaWy2rZL
	ju2lDFxoansn7BL/JBv7fK+Txb70eaeKpHU1RIf5S54G9Hp2UltjVHmZk4Oz6c5fZwOMTVRnt5M
	hyGVgx+CEQt0Lrwbbd59J5+WOVOexMS1g=
X-Google-Smtp-Source: AGHT+IGvd9l6oHOLE9fnxfE684zOBfeLzMgdLUIP7Dlo/5MmH56BWMQ4SvzpvsYGq7X+B76XwXqLUfBxwBV44JNMIjY=
X-Received: by 2002:a05:651c:150e:b0:30b:c328:3c9a with SMTP id
 38308e7fff4ca-30f165907d5mr25336491fa.29.1744027024752; Mon, 07 Apr 2025
 04:57:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250315101032.5152-1-zhangfei.gao@linaro.org> <20250317011352.5806-1-zhangfei.gao@linaro.org>
In-Reply-To: <20250317011352.5806-1-zhangfei.gao@linaro.org>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 7 Apr 2025 19:56:53 +0800
X-Gm-Features: ATxdqUHUra-Tho__TVApIyf-WrBs147BbLBYcTvf1B00xAmjRluVy3FNIE4M4m4
Message-ID: <CABQgh9H9JTQz5V=O1MYCX=WqH-bz3oFfSzU-pLXVL4+xyqH72Q@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: Declare quirk_huawei_pcie_sva() as pci_fixup_header
To: Bjorn Helgaas <bhelgaas@google.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, Bjorn

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
> ---

As  the commit bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper
probe path") already merged in 6.15-rc1, would you mind taking this
patch for rc?

Now 6.15-rc1 can not work without this patch.

Thanks
