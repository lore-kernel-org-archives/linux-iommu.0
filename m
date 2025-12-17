Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D24D33A9C1
	for <iommu@lists.linux.dev>; Wed, 17 Dec 2025 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984797; cv=none; b=JCqsqTpYxKtfyu6DO2Djci0GL5k2XhdX1Cjx8hbSFUFFYaAQ8GhYmlTYhaE+UEHaLwdeO8l0O0ealDlrn0fO65zE5uTjJd6ZT8o5YqBd5ymmEdGPTyiQrRNcPFY2pTu5gY1xBhN57wLoRRBVk4X1NqKiCZFT/FDvHP1sBCNcMTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984797; c=relaxed/simple;
	bh=w09mEle/83MrqdWuYBx70gmLmKQyKlIHpYyvZMInlts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAlbXpa1khjl2svMHKZ+uFHm7FLHDzUnyA2Y386f8HDXeoAazOfzvANlBfiTj4IeC9uMVUwP1HIKW7yrEsbPhN6mUDgNGIagvsRMaazBBfyNAltYbX1ZYYLi7k0EsnHHSUUghOlkUmK0cQOGjZ6q1BGE85kdf4MeIbyMiAh2EKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=U4CnDJmg; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="U4CnDJmg"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88a3bba9fd4so29246456d6.2
        for <iommu@lists.linux.dev>; Wed, 17 Dec 2025 07:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1765984794; x=1766589594; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vxrhj48Q2FAUnhlUyBprvMI5hH+9ez7d9ool74khOYc=;
        b=U4CnDJmgw3rXDVJ6YD8LOzQbE0TgTiUgifhN+ApyMZIXOE0/teSN9Ttk1QM0uehupV
         RCzq0Grvq6ye/ymOnXXOZn6QgL/+mrouAdxTgztEJkIGuGQB3GMAiMMmwkeF4727tlT5
         nG3xkZWndB8vG0uX+EfxWoC1k8O0ebHm4NtmRQGRqpebedPTgscxNZCga/AEGiYuPopn
         4EtdRYvUrAAvlHo1uFa0tm7I4WmvCRj8NV34uG2xMuaNvqRbdbqnepRIR832TZTpGPMJ
         GX4zarypwxVyIiLrJd+ze1MfzR6uvsPwj0x3ggof9xKokqL5uhM74TI1asCGDgLJl+sU
         7NeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765984794; x=1766589594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxrhj48Q2FAUnhlUyBprvMI5hH+9ez7d9ool74khOYc=;
        b=gufIAenNbvGSgn0FFuKT9byj0d8MqrNRNGGDktTxTMYAQJUJhtiFelR03XVhd75Et9
         RR1P1gCgD6CyCaO/HcEL+PVCLooODPmDnJESSyOGFqct40hpzTf9jhP5D7FxJAnHO1M0
         XGEXLXXsKofK6dXh8HrdPbsf5yZ2wvhIrYlw+ZGJgpBSc5eqDlT4suFNa082XF3PO+cd
         GxodtN7HfaPEQV+L38VndNCZLwxfiX8MAJRWb/p8uF+J3qr9uY/fIMOlBkmNXR8EqdiX
         cCpCjnT6jpEySDZTyLNa8EiTC9vyfSHeTV1hKie8b+wMCCcNYDir2Uwthgd4ANKug0Pk
         m6HA==
X-Forwarded-Encrypted: i=1; AJvYcCV/jYhsSIqlTl9jae766u+GqZ6tNDN/GBklxpGBUxYJFk8edxCR3OsmHovQJyKEQ0/QzB2GPg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyu+iKEqp679NuD4X36AnLuc8MQ6rl3ofgCLMLsgVz7wA7DP/zZ
	IWkFye7n5nOqmGcfNeXssMmXcmMUVAxGB0NGfM8G858pks56IAHbXHZ+s55DCvPZaX0=
X-Gm-Gg: AY/fxX4lLK13bQucvvdpcwa90e9cqkg7qyyG8MUhXrI781RQnhLC3ZDDuYqpOChV2uM
	mcHq7ElrAO0hQjorkPouIQiH+X9HxeTpfYPmKi8lSJMSyA5AGY0MfoXYWYqGfymdFjClC/Wd0m4
	P/CsFrUpv7HAyS/gEtWuJl4j/TB6alurd705vRs6TUM744ACk6yL5+HvGPAIdzIQQZltJyu1K90
	HjMwu2VxNd+CuIrxLh4v0qIijE34/Ss/gnFilLbfbaO7nWA6U8lTAh19J7CqXIZ4z2X1LCSV7L6
	As7xEiR2H99rXu+asUMvh60bc4TsVj4OGP5AjpFJ8AXwmoJ2LisVpt0r0xwahoL2NhLTJC0c2QX
	SVV3zHe2R8hZyGOHXwawAcR/xB+MkjojGtmIoguCV1uhxiUfwbNKnVDBRGNb+bcfp3g0xVdyEj8
	ToVypUvx/TjIgLDaHhtOpjGAXOHy5duBVQDr6VD5lZjUSW2O+J+ukLjhCb
X-Google-Smtp-Source: AGHT+IEeo4DfupIp4K/iDP3a2ivWiR3/Wwq/tP1+vTPnDZ7ZmGlvxllQ8uMMWjnMBj8/Zu8fu6Z/FQ==
X-Received: by 2002:a05:6214:4601:b0:88a:2fb5:a085 with SMTP id 6a1803df08f44-88a2fb5a22dmr183537496d6.63.1765984793976;
        Wed, 17 Dec 2025 07:19:53 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8899e7598c7sm96636706d6.28.2025.12.17.07.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 07:19:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vVtJg-00000000jxk-3jhU;
	Wed, 17 Dec 2025 11:19:52 -0400
Date: Wed, 17 Dec 2025 11:19:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
	Xingang Wang <wangxingang5@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 3/4] PCI: Disable ACS SV capability for the broken IDT
 switches
Message-ID: <20251217151952.GG31492@ziepe.ca>
References: <20251202-pci_acs-v2-0-5d2759a71489@oss.qualcomm.com>
 <20251202-pci_acs-v2-3-5d2759a71489@oss.qualcomm.com>
 <20251202191533.GI812105@ziepe.ca>
 <4d3asssmv5xkttasl2xl2f6q3l5ki4jxmsrbyy6hvrd7djgsnj@y7drlazpwzi3>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d3asssmv5xkttasl2xl2f6q3l5ki4jxmsrbyy6hvrd7djgsnj@y7drlazpwzi3>

On Tue, Dec 09, 2025 at 08:20:39PM +0900, Manivannan Sadhasivam wrote:
> On Tue, Dec 02, 2025 at 03:15:33PM -0400, Jason Gunthorpe wrote:
> > On Tue, Dec 02, 2025 at 07:52:50PM +0530, Manivannan Sadhasivam wrote:
> > > @@ -544,6 +544,7 @@ struct pci_dev {
> > >  #endif
> > >  	u16		acs_cap;	/* ACS Capability offset */
> > >  	u16		acs_capabilities; /* ACS Capabilities */
> > > +	u16		acs_broken_cap; /* Broken ACS Capabilities */
> > 
> > Why do we need this? Have the quirk function accep tthe
> > acs_capabilities from the register and return the value to program
> > into struct pci_dev ?
> > 
> 
> We dont have any quirk levels between pci_acs_init() and pci_acs_enable() that
> will allow us to modify pci_dev::acs_capabilities in the quirk function. Hence,
> I came up with one more member to pass the broken caps.

Call the quirk function directly from the ACS path? We have things
like that already for ACS?

Jason
