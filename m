Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687D921171D
	for <iommu@lists.linux.dev>; Tue,  3 Jun 2025 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748977456; cv=none; b=OkcoXE0Jln8wSMXLYOf3OES24F7dDGR2BEOmYulu3588iaOZCzO/MJRaz2AGr6gLdJmkertuMUmrk+wT+nMVYRayq2T2q2sA03OhqSlwBmssY7muXlyLPsM0n2JrLFgF+O3sapT+FJYR6IzeOldTNRTui6bdtTCchBgZwU97qcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748977456; c=relaxed/simple;
	bh=1iE7kyMiiAkOz5s4QzZFSu3p3d86/ZBJI/5t8DJhip0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeXM1DMZLRXlp3IB1tmLfXLftxinIyb6U3zITLLugB7xHhDMUeJEBBt+VKT5vZ/9TbSc3ss+BTQPysqzNb3m7dF9A6ESOB4PY9Fs4RVGUAXFNIRGQYOTy58qR+oQM1qYHcwYBgJcdzEB4mUKlZj4FycN/U3kWecMuFQSKyV9WBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=b4Y7B+eU; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="b4Y7B+eU"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6face367320so45239376d6.3
        for <iommu@lists.linux.dev>; Tue, 03 Jun 2025 12:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748977453; x=1749582253; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UXYCmwjnaG+anreKggrejlGyUaUlc7DjriLRrlaOB2k=;
        b=b4Y7B+eUg+SAEwNr+omILMOVSh6Kir5H/aT58NbDt3oDIGvadI2fe9cYQPmWTqbqo9
         pyzivh3+LIGkUJlrfht37Zx+1nbZ1YMBsDHIiaxWi/XQ7Kh2Wm59sJURYDqyiveHND5p
         +ISbuyzq3zjvoyWyFhJdZ6cj/AQeGZSRvTyDwxEnpDppr2cSW9vq46DvUS2p2mv5LzC4
         xhZMoZyefibsYMwzQBSmhwRagQYX0SCMmrpjJ4sA4Ede9v9EVmRwzz/OO/EXV8uEHHC3
         qzUwh/ijsiWH3DzpGX2ENGN6B9giatCUtdzeqWozdt/cnQSxo7tpW7Nt1PLZprbLrWnF
         zi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748977453; x=1749582253;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UXYCmwjnaG+anreKggrejlGyUaUlc7DjriLRrlaOB2k=;
        b=ozCoGWY27sfjqmke55O1ndcujX/GjZ7MNbDf7pQJjE3mY9iO2J4p1j4O8hMhH3fNl0
         nP2+earoHqTFx2o7xGSHikoleqxWcdbzW92rMmitZJ5lS2bGxu9liKt9cHtnSo0gVG7X
         3SOw4xgEPYTLy28upTsuT+WaroQKisoDODTy7YmDRBe5ieyMeqyTJJFsA9mAoGsS4kkS
         I8ezn2zEGWlbPXU/T9HNC/+djBNByqsBVDtm5pAWQ+SJycG4ZSR3fxfa8iotMQqgXCOR
         uWFiCYUr28IBmBdKbr0vca8jK81ngakkWPcEDNuq2UQIgIgrVy4KJAIuZQR2pkmISLGl
         X3sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe4UFRMQqqk1Fk7s4QJVMBZPe24gRvVpWrT/5LFvCaF7XCKBW6136VhOVUSoPwq0RqgOfsAg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNswzH9gX5zRtuU7sMaOF/hJF+ecvvOHka7DF3KM37DjMhAXd9
	Ri5iPG4OOwltL5D93e7KiKR0CzHvX6XpQz+OtdhxSm2SjlSIjSRSrHehPG5/rEwFwmU=
X-Gm-Gg: ASbGncudAg6HEMV1AT6D2QU3iM3EY1By0g4NIP4HRgcmpuQHEMrc+TG7QtJAQys/IAU
	xYASFLXp7tOyYwhbWiENE63HNwHXriAmwdLjBqUPq1TPOBTJTBiG6RpTXdn/XUR69O/u75zMKrx
	RnQq253MJtnFDZz8i2Z42B3FBlQ5QLgZtAfiDgG5nnv1SNJNVeVFGhCGs0c1U1vZ3xw4TgZwdq6
	90iApGfxsI0KIZGB7M+13LMvIHCIgI11iFKV3QhJBkZEjnqF7tkLUY/tltFl0EPZTwQoSsH4CQX
	PxxxFnP+6sa6CT5XpEvNxSZWugaouu6x7mHvh9pPVgXVLm/qBxIc8iYVZy4X5XiX6/PJnRbDO08
	6LgrGI3S+kR0GcB1B6HwTQ7MQWqqOOfjH6Y1wrg==
X-Google-Smtp-Source: AGHT+IFFUZuPO+81N5QFepQ+p15xv6hiwM8o2n1pMfqmwA6DzUC9YiQS3MCF40Hc6U9DxrLtLQtJxw==
X-Received: by 2002:a05:6214:21c4:b0:6fa:c512:c401 with SMTP id 6a1803df08f44-6fad1aad547mr291202096d6.37.1748977453083;
        Tue, 03 Jun 2025 12:04:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6e1c7b2sm85288206d6.111.2025.06.03.12.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 12:04:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uMWvj-00000001ogI-3gkJ;
	Tue, 03 Jun 2025 16:04:11 -0300
Date: Tue, 3 Jun 2025 16:04:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>, thierry.reding@gmail.com,
	vdumpa@nvidia.com, joro@8bytes.org, will@kernel.org,
	jonathanh@nvidia.com, baolu.lu@linux.intel.com, jsnitsel@redhat.com,
	jroedel@suse.de, regressions@lists.linux.dev,
	linux-tegra@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [REGRESSION] EMEM address decode error when using Tegra210 media
 engines
Message-ID: <20250603190411.GC407166@ziepe.ca>
References: <62e7f7fe-6200-4e4f-ad42-d58ad272baa6@tecnico.ulisboa.pt>
 <20250603153257.GB407166@ziepe.ca>
 <46ef896e-9b73-437f-bfa9-4dcae5089028@tecnico.ulisboa.pt>
 <ef7c8bf7-d6b1-4486-bb8c-04d24488ecdc@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef7c8bf7-d6b1-4486-bb8c-04d24488ecdc@arm.com>

On Tue, Jun 03, 2025 at 06:43:49PM +0100, Robin Murphy wrote:
> On 2025-06-03 5:52 pm, Diogo Ivo wrote:
> > 
> > On 6/3/25 4:32 PM, Jason Gunthorpe wrote:
> > > On Tue, Jun 03, 2025 at 04:06:47PM +0100, Diogo Ivo wrote:
> > > > Hello,
> > > > 
> > > > Commit 50568f87d1e233e introduced a regression when trying to
> > > > use the media
> > > > accelerators present on the Tegra X1 SoC.
> > > > 
> > > > I came across this regression when testing the branch [1] that leverages
> > > > the NVJPG engine in the Tegra X1 for decoding a JPEG file. After commit
> > > > 50568f87d1e233e we see the following error messages after
> > > > submitting a job
> > > > through the TEGRA_CHANNEL_SUBMIT IOCTL:
> > > 
> > > Maybe this?
> > > 
> > > @@ -567,7 +567,7 @@ static void tegra_smmu_set_pde(struct
> > > tegra_smmu_as *as, unsigned long iova,
> > >          /* The flush the page directory entry from caches */
> > >          dma_sync_single_range_for_device(smmu->dev, as->pd_dma, offset,
> > > -                                        sizeof(*pd), DMA_TO_DEVICE);
> > > +                                        sizeof(pd->val[0]),
> > > DMA_TO_DEVICE);
> > >          /* And flush the iommu */
> > >          smmu_flush_ptc(smmu, as->pd_dma, offset);
> > > 
> > > It is the only mistake I was able to notice.
> > > 
> > > But I'd be puzzled - I'd expect bigger sizeof would make it slower not
> > > broken.. Though your crash sure looks like either missing cache
> > > coherency or a bad PTE construction.
> 
> I reckon the "unsigned long offset = pd_index * sizeof(*pd);" a few lines
> above is probably more impactful ;)

Oh yes, almost certainly. Very good of you to notice it!

Diogo how about this:

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 61897d50162dd7..72a400f7ae0c20 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -560,14 +560,14 @@ static void tegra_smmu_set_pde(struct tegra_smmu_as *as, unsigned long iova,
        unsigned int pd_index = iova_pd_index(iova);
        struct tegra_smmu *smmu = as->smmu;
        struct tegra_pd *pd = as->pd;
-       unsigned long offset = pd_index * sizeof(*pd);
+       unsigned long offset = pd_index * sizeof(pd->val[0]);
 
        /* Set the page directory entry first */
        pd->val[pd_index] = value;
 
        /* The flush the page directory entry from caches */
        dma_sync_single_range_for_device(smmu->dev, as->pd_dma, offset,
-                                        sizeof(*pd), DMA_TO_DEVICE);
+                                        sizeof(pd->val[0]), DMA_TO_DEVICE);
 
        /* And flush the iommu */
        smmu_flush_ptc(smmu, as->pd_dma, offset);
