Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CB939281D
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654370; cv=none; b=XxwwKdBr1PVp2VXrorNZT8ZLdbNeeVZWS9Cyfb5dE2YfXfgEh/vtVvLLOsmm8JiODUvEZiJ2elHaPAUqC6RJqXRGt7qQU6yQaXG+6c7ux6UtGJpbOiYdMNISZ6GT7IPzr4r87vMGzkasVNGsSVnC1kvjTZcuIb6T41K5r0r3RIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654370; c=relaxed/simple;
	bh=UPQA1z6+4XvOvRe3oYbBw3Hq/r/87REpuY65l1PTnWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrttHkqa1ZqDVz7NantKIWNF6PmBqNOLXyecuYLwW0PKXp4QJbC2t9r0fcpUa1c1MlDL/TFKONEmSAOqjR+XyNHJOoCMh6NQExaiZJe3PMRpFQ78zZWlQq/GIbehLWDFiKA4rybcqP/BtbCwZZ/5Kjt+dcm+ecNO4lmldVsD0x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lA8DJedq; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lA8DJedq"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ccdf36f63dso102405ad.0
        for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 03:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787654368; x=1788259168; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fQimmvEugRdggoTJdTzrA2wAibwk9qnzvD9RGapkzMQ=;
        b=lA8DJedqIoUmOY+uAOsPUvfv651OqzxCET06coD0ECLHj3ibWG77gmaKGkaHyP8Mhm
         SPW8AhRv8xwNfElASMb6f9THucnetZL8P6EgYfmYi7Q9CO9rLAzinUmIUkR00+9uk6WY
         cMCOxqrQdNQOLTcq2X6xvKdZlZs7Q4QgXcZQesqt8VNdLIqlXV0Y00vFJRGsKaFknnGZ
         fkI4apho724Y4nKWQp3cV4k1DQDkEq4QXhavD6U5QRnqZnurAOZRVTCxtOSl8aEqX6U5
         QtFXR8AoEJW0ffFRWgcuPnjYlYgWMF+0jVa2AKocZsr9qOQpFeUTgxkB/SZRq9si5BhL
         74DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787654368; x=1788259168;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fQimmvEugRdggoTJdTzrA2wAibwk9qnzvD9RGapkzMQ=;
        b=DlvSHjYbpecHQVo/nzKviBpnxps7i3ZSiTRovply70ID9TvVNiWR9bk8n7edP9iexe
         RBax55BHpewQie0ENAmrZbW+LQUJ+NTwqJC/IoYMVEobDqYmhCdZC7XHsLtZR7zJLkDe
         zlhehpB/nkWudY9Z5OEbnYIdeWRl/Qrs2r28NRghXvisuPbFXGc2XlSoSdSQ7dU8u1r0
         PjlZxK5LE3Gph6Na+IUDJXXB0zUMygkYCoq8KsuZnyQ9ZfStc+59o21OfiCekmN4voGJ
         3ylxR6j5XN7YD0/NiMltCGrT+gFYixf+jw259a5A2YzxxR4EFx7xGpxTolVrcakjoD0D
         uCGg==
X-Gm-Message-State: AFuF++mKu2yVtLHvdn/C/s5kcROGguV5r1baiHTomf3FoT8HZ0y0nmS5
	zZFMCq34//Zx84o7ibL7XgsuJpZEi6JccDi1meLvem9XWThDQXWMuEJXFEglHy/V3Q==
X-Gm-Gg: AR+sD11jqz+HB+Jb9gmsG6SEbXOxlZ00A/oWSUmaEwJ1oosv6trH4O1fCbuLiTk3/D2
	Mcj9PxKC+WriMMvkdwkxLJ2bVdJpv8d0um5DbmtyBzGNRAUVzynTs08KXin+dAIaxvFBewLkm8U
	w6UjF6t5TV+rf4TvjWpuThiaaXkYfD5xwF/Rv9UzycXHm1bBL5SGmr10fS38XSFnQwslFG4ufv0
	xsPKGgzYSXhjrBsTw4tf5+0GaWEbJBanf8BfKm10Y+5awy065CJ1dHCpWgCOg17+4hgLHNPx3Np
	Llvbeso7SnE9+EqD6IFG3Of/bVoXsJB21RJ3N+4vbrPTlIvedu4JaEUHlyg8v56rj6BLDGubGyT
	upB/84S7+M0TdHKnP6GFNqCQU8ET6sxjO+gv/oICiaYBIe/jwREROEAXmd0XkIbcXpv17tMWQJf
	oQZZi5z8so0xone9YoUEVE5lsrmUzRctE6nz3x+Xot0/CXtTNKZ06Lel5vNwmftsZRWINI/MN/2
	jrLIvdWYCcqQujJZIN5Qk+huA==
X-Received: by 2002:a17:903:2b0b:b0:2d3:153d:acae with SMTP id d9443c01a7336-2d6e036b7bdmr6964335ad.0.1787654367869;
        Tue, 25 Aug 2026 03:39:27 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645c06e02sm3307145a91.17.2026.08.25.03.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:39:27 -0700 (PDT)
Date: Tue, 25 Aug 2026 10:39:21 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Ankit Soni <ankit.soni@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v3 0/5] iommu/amd: Refactors for ATS robustness
Message-ID: <ao1w2dzzsSHOzvhT@google.com>
References: <20260824122347.1588592-1-praan@google.com>
 <178759520115.3131778.12333086025639368747.b4-review@b4>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178759520115.3131778.12333086025639368747.b4-review@b4>

On Mon, Aug 24, 2026 at 03:13:21PM -0300, Jason Gunthorpe wrote:
> > [ ... 41 lines skipped ... ]
> > Pranjal Shrivastava (5):
> >   iommu/amd: Refactor device probe and capability initialization
> >   iommu/amd: Fix DTE clearing and rename iommu_ignore_device()
> >   iommu/amd: Split probe error paths to preserve IRQ remapping
> >   iommu/amd: Fail probe on ATS configuration failure
> >   PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()
> > 
> >  drivers/iommu/amd/iommu.c | 199 +++++++++++++++++++++++---------------
> >  drivers/pci/ats.c         |   6 +-
> >  2 files changed, 126 insertions(+), 79 deletions(-)
> 
> FWIW something about this series is mangled, the first patch was
> changed before it made it to lore. Maybe whitespace damage..
> 

I see. I generally use checkpatch with --fix-inplace before sending and
it seems like it tried fixing something. I'd drop that arg now on.

Thanks,
Praan
