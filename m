Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2712F296BAF
	for <iommu@lists.linux.dev>; Mon,  3 Nov 2025 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195228; cv=none; b=Ec0k0hi2f47Am3WhVDNsQ1tWy7f5CcEqvKbVDnfaTQ5CBKV+qUCaIe5KgpFrvcI3Fn5si1flJ1frJ8RdUFVOIPAVCXpQ0ikhYSZdxYOe5JRDV5hvPZSiRwPpyLHRylgi/j+uKNdVafWlWfRyxuxspS80++8iJfPc/w14dWN4s0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195228; c=relaxed/simple;
	bh=M6kSq7zhpxnw+0M5zL9/Kp1ZAyzM1iKpIk7f+nKH9yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/XvXCn9ZLw4R5dmJ/Oqoj5tRvxcC053c4yOLpR/VoqRMOPt5XBs4p+aReASNsDDQ4o8e0YzL0TO+MMGtGKTMLU2nm9dJgu9/rXNXkoWwhVbliqGvv0VhEIAB7L0Nh0scZdiUuJvHZc+7W6epHZEF/8frNzj3/InS42oQUsmUcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bFW6C575; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bFW6C575"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8804a4235edso23105356d6.1
        for <iommu@lists.linux.dev>; Mon, 03 Nov 2025 10:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762195224; x=1762800024; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xdu9914nxmx9HVrzeaXCiD/M6gjOdAMYdjxCy9Nn1IE=;
        b=bFW6C575eclgADR8R7DVWpbY2eSwMVkA9HMu+LzVNa1p8EJhlO4+dsf80TgyrWGaKD
         KPIAG4/opOgkolzoqOUkOLsQtZSY95c8AYCP2eTrz7eqkaCH2kGFEYoum1uOKoBD1spz
         uI9/1SQCU3xB3S2m+iB8Km0V/ZRM+4VdcfGWhfiso+mhxMH/7RMRU25AKsCqa29aNOOH
         RFt4Pv3W6ItFiOhwiMoWXqZjd3sigvclO5qv7M3uSwn5vPDIRTk5kCOUBrVij/zF/eMf
         TxlJvUyy4shkM/WYC91vPLlF2q3wmGtX4dLvihJTdeT5177XbmXTBFjtqbDZR5Dv1vHG
         mSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762195224; x=1762800024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xdu9914nxmx9HVrzeaXCiD/M6gjOdAMYdjxCy9Nn1IE=;
        b=Pqrq6Vnp3QEjp9zR+qYS0hCjO7DyP+sBuINz1TcK36DhEdIY160OpUdJrY92LryUai
         P6neT70zYs/jfJYuMJcLy+RFSTzxfog30TryJxiwsidt+eCiBX+RD4dcA7zOT2KrULyJ
         kC07UKrqUGptBR5SQmNT+DlBscuAUEab7jyWupvkUC/dyEZPOjC/L7sYorl+zbwkyUYT
         e5Lf5azzvxHToJLUIkgp1k/bVIOkNNqwnzLrK+zMlsVrzLtRd7Jr9njYQeaqfxoAUypQ
         PDBHuMIUvk6pYl7E+7hzXpOk2AGt7cHswVZbQccdStZCSFKSQDbqjTm9MEyYYNZcK9C8
         fuRA==
X-Gm-Message-State: AOJu0Yyk6mciNyTqIxYsZ8awiGG+b3gWkj8ELym0rfgfft/3/vud6qBm
	xo+5RdOJiyVbWSRORQAPWtEtZcjodwzEsqri/TfbrpFSqoNl8PSX/lJ+rxv9v1JPBzg=
X-Gm-Gg: ASbGncsONvSSgRdSr9rCll+0qRro75UYD5ISS9qxm3Kg/Aa9UIDgn2q8WY90ziOGZTL
	a9/s313ppGRaFJ8gaSRbTeCYhCvHXh3oGFffNRdsrrZL0RRek0ZIecaf3JioshnO+I1XLpkIxP4
	Nup+PLGRd491YoCqrpOwSsXqnDYyOzg1edE11dP6HuCniZ8dpOXspg/3yTM3kcbRGy/rKO+x/Sd
	C5Oa2TjJCGrqV3D/uO258u6oEXYm11oe7YuzU1GTd1txzeD9PfMRie5yPyS/hvUxOvt+DNOz5i8
	bUwk/s9c19RA3fQ2QMx2AmI6KehSr3KQlLYQ/OXwfZR1l5el11h2yNa1zGViVcBDbwANtupXihG
	R55prsEgG9abN8rjZ/KixtOploMGmPENVwWJCYaz7m4FBFTwi3l038aQR/B72YA9qayXzDXO0gV
	MFRoVagObcasiDOD51Q0c6KsE1zb74VQ5S7yeyW2injXA68B8SzQDegeON
X-Google-Smtp-Source: AGHT+IGemSUm2ni8Ue1hNioLIE6R3qX4KpAYbxriXdHXzmoYn8PHCrwIpoEc+FJpyECmaBuxF5TAMA==
X-Received: by 2002:ad4:5f8a:0:b0:880:5042:e38c with SMTP id 6a1803df08f44-8805042e868mr88058206d6.2.1762195223911;
        Mon, 03 Nov 2025 10:40:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88060db32acsm6812126d6.3.2025.11.03.10.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 10:40:23 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vFzTa-00000006S0U-2tWz;
	Mon, 03 Nov 2025 14:40:22 -0400
Date: Mon, 3 Nov 2025 14:40:22 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v6 1/4] iommu/io-pgtable-arm: Remove arm_lpae_dump_ops()
Message-ID: <20251103184022.GF1204670@ziepe.ca>
References: <20251103123355.1769093-1-smostafa@google.com>
 <20251103123355.1769093-2-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103123355.1769093-2-smostafa@google.com>

On Mon, Nov 03, 2025 at 12:33:49PM +0000, Mostafa Saleh wrote:
> At the moment, if the selftest fails it prints a lot of information
> about the page table (size, levels...) this requires access to many
> internals, which has to be exposed in the next patch moving the
> tests out.
> 
> Instead, we can simplify the print to only print the fmt and
> for each test ias, oas and pgsize_bitmap are already printed.
> That is enough to identify the failed case, and the rest can
> be deduced from the code.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 41 ++++++++++++----------------------
>  1 file changed, 14 insertions(+), 27 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
