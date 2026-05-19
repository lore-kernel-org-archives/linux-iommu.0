Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE39E3AFD0D
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 19:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217529; cv=none; b=VJe0xLQgZXIIgcUTta9Uo9n5OIe00/pf1iPuSGY8NrlT7PQYAe1SsfUCgEx5qVo4+r+dLF841tZJpZi84vW2DGGa0HPLdfkAp524sDReB3WZNMH7TF9mPuYxv1nafRT623fIOjKRw5j3IyfLe4bnvWjW3MMe54LGryf7Qdnwd0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217529; c=relaxed/simple;
	bh=NkbIuZmZbXDTd/Ba2Xv4PdtZcGFu2cbkqQ6Pohtib0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQbCmVDWK8NRSk2Q6Af1QT8tW74u+3uIBbJUcULi9Jn3T3K0dQifv/do4uws4XAYK3qtWQZdXC56wZ92kcLxoOc9Wxj9V/1HkoII1TslFgUVtwpOmzdhrc5MllbCMKlXtTfq9HF7f7kTrTjTkG/wmHrzRk/d8bvGCmrBoNDJ3pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BlrnecIP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BlrnecIP"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so1165ad.0
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 12:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779217527; x=1779822327; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T65OdPrETtNnBJjVw8yp6v3SGiXxDH7+GlMKU2MxhhE=;
        b=BlrnecIPfFZAf4SenIbciDyj9zPjFm5RRdTeV49HHdVspRrXSd8VaGNMsFQJVDsXO9
         gJr3Pcxtg8IVz2O+t684P/zhTA3k09i8gEitZzSv7vrP6TNkdhZaqlFJDOx4SnvgLLG6
         5dDq4S8f+i1OJN7DPSZKs+grkJvZ3AcTjMa7TJxs6m3iJKVzw+jTCtj2o9eQGkhuYXxE
         0VjR0+RZPOV49rE68YBH4nJUxEAmqQzfP9t8BAOOs/ikAl0ARiGYMW6238rrWJZvOcPY
         /3OJp4t0YFQMkDlHWDFZLjrLF7M3QSeKjs6az3iJqc3x8bYWNFURzY20Ji1tH2P0Pey/
         OLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779217527; x=1779822327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T65OdPrETtNnBJjVw8yp6v3SGiXxDH7+GlMKU2MxhhE=;
        b=sJOnbKoegvmhmWcHSpd/GKgFQMSmzJchMsErqpaplFuf0vRhuL0oG5syb9UnxC/WAc
         MLQyrZZSOXABwGiDBf3b2SdeNvRQtEkAZvToZ+aJm6QZL6BYxBffgAdxZ3dyXwAVDLOa
         RokxYnML1eKgQ+WIp6zcumdtl6lbEl+WySGBDtYMcRq41TdbBquD7687wF2kV//bQPRc
         dbM2IzXqrlOvnEDipncaTahmWvnVSf+RS2Oz4u9nBl9LxVqmW2HAtvrMvm2iIpgg1T2Y
         fcfy6j/UEKf3wCsYyGS7fBXURd5+AhaynF//ZxOqQTa/SZYJ4SI3utu0EhJNeJv4GVXc
         M9Gg==
X-Gm-Message-State: AOJu0Yw8AF7fh6Z3peCpO0YO/UdfADWgvflQOfrNGVi/9uK+W6yNOr1P
	2mtQiA/4TX/ld15YR+krI4+qrsj2OLu1Pd6wGK/adp4bn3dv7C7oMU6gtNGvPreIvw==
X-Gm-Gg: Acq92OG5epKX19ZsS9HJ6fshLHp8cBtoBMn5kn22T31t+zLQDR8ksQdBIZ0oWwAYRgv
	e7o637zr3RyYnC6jU4dThQ9h3UK/OkmCEDEjnkU/FuEQGNaR052lTxbG1HtXMhELOYFeywCqx0A
	cSDfHDLEveUuYI8LjT4q2883Ev5+mOagPmR3pUVKqFFCtrOssEAGz3LmOowpseEfp003Yjnimb0
	MZc1B3QHX7eu6u+Dd7ZarUbCGG/qxpapAdhwqGhAQsplp9xGPhjnCTV0kLc1+jfclpAVBYx1yUV
	sGzF1l6At8KJrJVPa6+QCbshtb6OztEAOCUnGy91BMFSzqEgQkI31C+alHKZqL3nrl995qrntnZ
	DPIXiLSJd7LQSadLtulTd4ojwIeDL0BJzEP1u4Uaj3TUJ/3WW06Bje0qE9tvWOQ9xVlFQcrrAI9
	f3xX5x/EXG1scocKLiCJHJpDsbl9cMpgFVsfb/cJAjdroSvFJ55Ap2KvoNgaOyS8FSecZzmg==
X-Received: by 2002:a17:903:3904:b0:2b0:b925:da98 with SMTP id d9443c01a7336-2bdb36b2cdbmr7145165ad.19.1779217526359;
        Tue, 19 May 2026 12:05:26 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c7809esm24056508b3a.44.2026.05.19.12.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 12:05:25 -0700 (PDT)
Date: Tue, 19 May 2026 19:05:22 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 2/3] PCI/ATS: Validate STU for VFs in pci_prepare_ats()
Message-ID: <agy0aNB-KJPsP3aa@google.com>
References: <20260519135323.1558777-1-praan@google.com>
 <20260519135323.1558777-3-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260519135323.1558777-3-praan@google.com>

On Tue, May 19, 2026 at 01:53:21PM +0000, Pranjal Shrivastava wrote:
>While every PCI Function that implements ATS has an independent ATS
>Extended Capability structure with a Read/Write Smallest Translation
>Unit (STU) field, the kernel manages SR-IOV ATS by requiring the IOMMU
>driver to configure the STU on the Physical Function (PF) before any
>any Virtual Functions (VFs) are created.
>
>Currently, pci_prepare_ats() bails out early for VFs, assuming that the
>PF has already been correctly prepared. However, this creates a potential
>mismatch if a VF is subsequently prepared with a different page shift.
>
>Update pci_prepare_ats() to validate that the requested page shift (ps)
>matches the STU already configured in the associated PF. This ensures
>early detection of incompatible configurations and maintains the kernel's
>policy of consistent STU sizing across all functions associated with a
>given SMMU.
>
>Signed-off-by: Pranjal Shrivastava <praan@google.com>
>---
> drivers/pci/ats.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>index a5fa7745bce8..54319854bfd8 100644
>--- a/drivers/pci/ats.c
>+++ b/drivers/pci/ats.c
>@@ -73,8 +73,13 @@ int pci_prepare_ats(struct pci_dev *dev, int ps)
> 	if (ps < PCI_ATS_MIN_STU)
> 		return -EINVAL;
>
>-	if (dev->is_virtfn)
>+	if (dev->is_virtfn) {
>+		struct pci_dev *pdev = pci_physfn(dev);
>+
>+		if (pdev->ats_stu != ps)
>+			return -EINVAL;
> 		return 0;
>+	}
>
> 	dev->ats_stu = ps;
> 	ctrl = PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
>-- 
>2.54.0.563.g4f69b47b94-goog
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
