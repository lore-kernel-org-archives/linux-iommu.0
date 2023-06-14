Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF08C7F
	for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 14:46:02 +0000 (UTC)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-62fe192f7d3so6855686d6.3
        for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 07:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1686753961; x=1689345961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XCPI5ZcRcUuga+hwGvL6zbC51EZUbGkp50/wT3gC0jw=;
        b=bxe8uVF1FEFSaF8JRbza9nJxP5K4Z2yuCd6J5OgmRschaBVxVJWJfmR+Ixcf6XsCRD
         VQGIikKxvftgKxlPbwVUcIOeW1ItnaXi0L9T24RrWyFWyUKgAKRwPeOhpH7hFh6F8sut
         jfeVokjQBWaGawD+ng6KqGLNS2xBnH9Qsjz03TyIdT94ubbeK/TtqLGXGf4t+RIxSQWO
         52o0vVvPYfTfR984Gy3/51k9fZpw+606eog4fRYT1dwqqc3HBjtl9YL8GXmCIy0qAkT0
         H8izUvIjCjOVtOI+9wUZ1aCs2HTvUtIXN+RsHs0mvBD8QwW+edk74Aq/Rv2f8Vb1W63i
         QpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686753961; x=1689345961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCPI5ZcRcUuga+hwGvL6zbC51EZUbGkp50/wT3gC0jw=;
        b=NGS3dYNPFui/e3feII/Y0Lkje/GsM4/HQoKszQiHqEr3Q099gvrZVw5W97BOywdKcT
         i6rM3g+DAjvFTdindrj0YBu8GtzUzec6C1jdS9q6b9Kz4g0mT6ZIoysFugUlxFMuFwcY
         KJWHT95wAQqimg29Bm9JPJOEyF/ua8RePCxQAYfxNbbObumkXjb7ITrll5nUj69BrklP
         zTtPhEPH0fFdfEgo6igTJfQHzvQw9d4vln8Xn4eBKfs0Qejn9oClvYhuq7JwMrtW9lS9
         1pZbLrl3ETsOBMN3UgJXT1D6wb2kwraiHEa8/tGPSbNBdEatb7E+K+K4kAUDk8IQ9z2C
         1Zzg==
X-Gm-Message-State: AC+VfDzVOdYgZ6cD9KimheoGIfHoll/faTLIFV9+SkKd7gyYu2Mp/pnc
	8bmr22jCK3wxAGnSkSVnZFB3yg==
X-Google-Smtp-Source: ACHHUZ6YaaB5KAvmXloQoWaGZZvdtx8GavR+DcReFGFHeE3s5pRaCqmulS8858ZysFsR+JLXe8ovLQ==
X-Received: by 2002:a05:6214:d0b:b0:5ef:46a9:15d2 with SMTP id 11-20020a0562140d0b00b005ef46a915d2mr16973858qvh.7.1686753961443;
        Wed, 14 Jun 2023 07:46:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id e21-20020a0caa55000000b00626330a39ecsm4785870qvb.9.2023.06.14.07.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 07:46:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1q9Rl2-0058qB-9u;
	Wed, 14 Jun 2023 11:46:00 -0300
Date: Wed, 14 Jun 2023 11:46:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, Vincent Chen <vincent.chen@sifive.com>
Subject: Re: [PATCH v4 06/10] irqchip/riscv-imsic: Improve IOMMU DMA support
Message-ID: <ZInSqC6b7RPD1nzX@ziepe.ca>
References: <20230613153415.350528-1-apatel@ventanamicro.com>
 <20230613153415.350528-7-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613153415.350528-7-apatel@ventanamicro.com>

On Tue, Jun 13, 2023 at 09:04:11PM +0530, Anup Patel wrote:
> We have a separate RISC-V IMSIC MSI address for each CPU so changing
> MSI (or IRQ) affinity results in re-programming of MSI address in
> the PCIe (or platform) device.
> 
> Currently, the iommu_dma_prepare_msi() is called only once at the
> time of IRQ allocation so IOMMU DMA domain will only have mapping
> for one MSI page. This means iommu_dma_compose_msi_msg() called
> by imsic_irq_compose_msi_msg() will always use the same MSI page
> irrespective to target CPU MSI address. In other words, changing
> MSI (or IRQ) affinity for device using IOMMU DMA domain will not
> work.

You didn't answer my question from last time - there seems to be no
iommu driver here so why are you messing with iommu_dma_prepare_msi()?

This path is only for platforms that have IOMMU drivers that translate
the MSI window. You should add this code to link the interrupt
controller to the iommu driver when you introduce the iommu driver,
not in this series?

And, as I said before, I'd like to NOT see new users of
iommu_dma_prepare_msi() since it is a very problematic API.

This hacking of it here is not making it better :(

Jason
