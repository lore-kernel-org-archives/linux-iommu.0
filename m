Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A255C3546D6
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201883; cv=none; b=ZBEw5uKCdwUAjNf/fXGQDJt3QcIBFGyZYdsusR/a4wgnKA+NOt3x5+ShZo0X9yp7BfeTmfx75XBdSFo2puL+oII/9Kiyae6Ng4sfd8T7fEMlRv7jp97Pv3US3vEqi4DeRfxHR5eKyQs4Kq1RzsEk3ztVukDGa5NYkCahO+hmd34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201883; c=relaxed/simple;
	bh=ababuGkYXc1kwBB4VAaU12lszAJn+bUQOtY++53c6VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dky44y7WeZLh3kFC0kAmZkFuIo1vMKKLLwCF8UvnGOdTsJW1rDBRPyEIu8Lo+XA5Fc0SsEsv1uC5IBatLtgFogJgbbp+4rK9iA7cjNVGdFsv8MC51K4MzaAR+AxjllVvXMKjXJPOc9sThhm4i+SLqvF6xN9ZXMxJbi6ypAMbg2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WdFGf1Ox; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WdFGf1Ox"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-912475287a5so400763985a.2
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 07:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779201871; x=1779806671; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wk5x+E6XSA8178Vrjl/Xpe+vTMcrSAIJSeHPv64RB8s=;
        b=WdFGf1OxPpwJyj6BHr33d558W9zD8BS/grcOBFrMnNr2yWRSP9otjGZKu74H94NPj+
         zX1CO/tVLHBXTCMQDw/L7+VAGZdWowSsJAG/yRBfF6vjJ4YsOxSXVV1RvERdrbhNjuub
         SkZtwQ140L6xuBkUwPO9XmM1Kd/u0odjIwe433+I5HSHVb7VQTXfc5VSoPal43jXcIN1
         voQDHaLjFPcjXJLQnb3ZWaGwbJ6st0txnYk3bPF6QK994Mp5WjPruW96GW1ENT8RGXZv
         qbbVMEjdMTZz5mR8KpB2+hNN+vuWaVC7Zoe4eEj5BnkBBlzTzrhSHj8owdyEVs8qY8pe
         Aq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201871; x=1779806671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wk5x+E6XSA8178Vrjl/Xpe+vTMcrSAIJSeHPv64RB8s=;
        b=lzIbOnVJiQsIWnvLjGrI/wqhVTiJxpEYxwCnD1cQmczY5LKFci/Z9SOZ9a00zNCGX0
         IQXr51h91Ja5WEO549QZQLE3aP2JoAb+QDHxYmU8ey1LNe9WfinXz+LKngjdVARVimXj
         1GCdxnBJuLt4P+EDu5C9HW2kLgmrYWi/9INP5NzpmjuRhtw/6sUAlcFOH2Cm/uKirbGy
         2wtrVQmBXU+lPxbPPqyWUtFi4Sv73vmT80TRAUAEXs8QC9ts0121U7mcoKZ4G68iqTCz
         a1HNlTM5YhW7fkf3V6hycjrHDo5q47T6bx8lz7JaViMaCHPBmtdQenRp2Igs0BSvjA/P
         g8qA==
X-Gm-Message-State: AOJu0YyZZTRE8nMRQfWBhqORdqsznDBphcHvSjvSVCUrdy7vTI/SQXoR
	5evsvuEuL1nCdBMtu0/DiqErHsHpz9F1SjWfteEiIxo1aw1HPgX0JTrkjQ8cgS2+cO0=
X-Gm-Gg: Acq92OF7Zcvb7cxv4T3hbopn6UgkScZzAPJbJzNd3qESIXpHObHitDEJrd4HS8ZPrs7
	Gz81QS7RVzboTpImau5ZI8e1/Dyq0hXjYA4CT5zobinLXPkNnm6pOp9ddw0CdRUFjLJkeiUcHrf
	swo8jmMpAfBwbD5ndrzg4iYyQWpS7eus7ol1EsxwcD5+9r476qWSBovdYlhDb2CQSdtWoVsftEX
	WskOpdAojSrcsStvldNCdnMXMNlilgb3kZNYC6Xuma8rDFrAzTh+sAWk7F9BNNQEtAeUEayaQXO
	ztmRTwfBhUfJH5BJzlBUuuSrL2TeCDFfMSgWNwHlN3rwT/cQVRw4xhUYDGpjpw/AtV2M7uqXLgm
	Iq8JRU9dIteFWXMFK2S9v6gJUhR2hPVbxKfxwf23uhwnyL3uhADS3qU4XXY+HcRoMVNhCx1XJGS
	oqqkEh1UbwjD9B1Ty+lp3zAhRle1Ys77TM7Of6MVKU3xNLTYpbsBQ+03i2t72BZwN+v22WUhxzo
	7i3lw==
X-Received: by 2002:a05:6214:21ef:b0:8ca:7f:89b2 with SMTP id 6a1803df08f44-8ca0f651b22mr304560826d6.12.1779201871273;
        Tue, 19 May 2026 07:44:31 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca3618fdd7sm92678956d6.27.2026.05.19.07.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:44:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPLgM-0000000F8gK-06mQ;
	Tue, 19 May 2026 11:44:30 -0300
Date: Tue, 19 May 2026 11:44:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Fix ATS state tracking via
 ats_prepared gate
Message-ID: <20260519144430.GI7702@ziepe.ca>
References: <20260519135323.1558777-1-praan@google.com>
 <20260519135323.1558777-4-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519135323.1558777-4-praan@google.com>

On Tue, May 19, 2026 at 01:53:22PM +0000, Pranjal Shrivastava wrote:
> @@ -4450,7 +4450,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>  	if (dev_is_pci(dev)) {
>  		unsigned int stu = __ffs(smmu->pgsize_bitmap);
>  
> -		pci_prepare_ats(to_pci_dev(dev), stu);
> +		if (!pci_prepare_ats(to_pci_dev(dev), stu))
> +			master->ats_prepared = true;
>  	}

This should fail not keep going, it is a kernel bug if
pci_prepare_ats() fails.

Jason
