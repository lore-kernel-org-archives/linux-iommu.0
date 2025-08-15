Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D201A9FB0
	for <iommu@lists.linux.dev>; Fri, 15 Aug 2025 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755255090; cv=none; b=nVDxhD8kXr5nO3uSq00tfCpnG1nZ2VS2tfv+y7gQlzVfcmJrIDE14wuzX7P6bBhKE2rw0UFWl3ysv1wRrNJJ+9XOE6liIn6hCBokY2LA1BLHJmvD1iu7oHz51WKLWwVdxcxkErxC/YAyflw6FZjGB08SWPV9XqoNLMi732GGm/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755255090; c=relaxed/simple;
	bh=5856zXIPk9IgqnEkrq9a7ikopP8h2OIrgLDCAzSSICg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSaW7p9oCipU+dlYrTqdWcdjLAfZ7Ysf0vwMLQkix8N88su/4aSWsHs7DiljqlWOHOOg/SuV98dkdgugSJh6jp0S6w4oKQRp8qo5ezg/4iffEFC3tHQSXXaL2Ryeg/OfrA1Nfoh6IWA4ex0SOW0ni10EjiVQ7HavJ25DMEubK0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=lRYo+RP1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="lRYo+RP1"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2430c3684d1so23346245ad.0
        for <iommu@lists.linux.dev>; Fri, 15 Aug 2025 03:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755255088; x=1755859888; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dix/CPpSMGWXSWO0Y4aNEfoYpWHiRGQqO96WVTnVXQ0=;
        b=lRYo+RP1HzYNNRdf/4U6veN8Oq7bkSyJUsCGWbho8BmjRb5mlH4RhhjbKT1ld6DVyB
         3QVitJm+MT29/uzKSuXDU6OR/HBQLtDPDysrFKoQ6jC1Lik4/nc5oFT2xapJ1gwdXfqt
         o2hXwkvnRE7wRto646ESpSz/edtYFVfXF233C7oyXWx85B+Sebl342X/7wpeh+OCpJFt
         rCau70ZMrcGOvIYhJbQKN91BzrAXhI0vXb4Nbp5tU100Y/5JZWNJnzIqGZAS74ZWbQp3
         wERkX9UJgDM0B1ZSB7zMCVD8af9h/sbCI/U0Gyesl6O1tRTAioSdg47lWw6sLRmH7d+a
         5n8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755255088; x=1755859888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dix/CPpSMGWXSWO0Y4aNEfoYpWHiRGQqO96WVTnVXQ0=;
        b=tiqguBjKp1//vXk7EFCtE/PofaiBC4+ZyI1P9Zf4X8f+cbnu1K1Ng5n9+DNu6Boq27
         uRH9LXgVBVCISlrvDoqbjqtnzYLxBoTMD9iM2eZNA7CA+hFGD/Fta1a6PyZr44cJ8npK
         0le7Y50f6VeRlaIeYtd1Io6ky+FKq3ZccLy3eNp1BJrQAUGE4bxCJDYTMvSxG8eCqv+S
         eBYSemOhVis+ycboRrkLURp57SUMjQtYT+glx0GwoXQF3s3qgUt23vro8fUJg2DuMSyu
         Bm5t8SLtlByNbwBjMJJRbALndHq6Rno2H6Sm4KouxNHPlMJHmESlakVjps0dXpiKwQWI
         6S0w==
X-Forwarded-Encrypted: i=1; AJvYcCXcgJVvVJNf9u6T8RSPH/4QTRrUV25g5f0ejLq+JBc93HXko/MFC7FpZRqjlTxR2M1528Y2Mw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyP5/qCytZiEIGU77nBLRu92rgLJL3THsxIHZGCArUThD1pJqNo
	1T0TZCMuB4oCNGW93cnearwA2/tZ1xv46M0Mxpkv8ZffW+jJcdbtKV61Pxs4zONsW4k=
X-Gm-Gg: ASbGncvQlAcWOX9AXS84K/KAM/IuSrBJMNnH+ZmFHdXT22EuwrOyLFbrVQ18IvokCeL
	kyrreE3aXfoEXLtp3FCzUg/cbFjWmDsesBCQuoIqmREwpfIwcJeQbacwCYAeI+X4cUgirMPlqWL
	mSAl9Rl632rWSclFUHp4AttOmG8mNOpinz0HqlAbA5ecXgnYXwoPeMF/QgMdONulV4X88UQdryF
	JQw1u+RkIBS+vbNKpoPnaJ7ZR9QgdZJDIc6uUa9lriZmE3Dsgrxvz+snN2W58Z+30d0JlIUownB
	H3gaVAQ7DA8F1GPE6Y3WF1eomxjRPV/HduRSYl80B7qom6dDaOfspilZnbj5kuggt0+j1aSqBqR
	7iy5XKyx2ry81xfpV4Dz+ZXLd1+I=
X-Google-Smtp-Source: AGHT+IEmNprlP3EyYzXw2mJxg75wrJzN+aQ6IJA3e06q3ZiRiLLueRHZsG1qP8n+zVyH+f5AwDAHpw==
X-Received: by 2002:a17:903:1252:b0:240:1ed3:fc28 with SMTP id d9443c01a7336-2446bd2d05fmr30011465ad.12.1755255088359;
        Fri, 15 Aug 2025 03:51:28 -0700 (PDT)
Received: from sunil-laptop ([106.51.199.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446ca9ee0esm11563455ad.8.2025.08.15.03.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 03:51:27 -0700 (PDT)
Date: Fri, 15 Aug 2025 16:21:16 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: XianLiang Huang <huangxianliang@lanxincomputing.com>
Cc: ajones@ventanamicro.com, alex@ghiti.fr, anup@brainfault.org,
	apatel@ventanamicro.com, atishp@rivosinc.com, iommu@lists.linux.dev,
	joro@8bytes.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	palmer@dabbelt.com, paul.walmsley@sifive.com, rafael@kernel.org,
	robin.murphy@arm.com, tjeznach@rivosinc.com, will@kernel.org
Subject: Re: [PATCH v5 1/3] ACPI: RISC-V: Add support for RIMT
Message-ID: <aJ8RJCFM8p_GrFXk@sunil-laptop>
References: <20250716104059.3539482-2-sunilvl@ventanamicro.com>
 <20250815075541.29941-1-huangxianliang@lanxincomputing.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815075541.29941-1-huangxianliang@lanxincomputing.com>

On Fri, Aug 15, 2025 at 03:55:41PM +0800, XianLiang Huang wrote:
> Hi Sunil,
> 
> On Wed, 16 Jul 2025 16:10:57 +0530, Sunil V L wrote:
> > +	parent = ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table, map->dest_offset);
> > +
> > +	if (node->type == ACPI_RIMT_NODE_TYPE_PLAT_DEVICE ||
> > +	    node->type == ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLEX) {
> > +		*id_out = map->dest_offset;
> > +		return parent;
> > +	}
> 
> Why do we assign dest_offset to id_out? The dest_offset is the iommu offset, not
> a valid deviceid required for platform device in rimt_plat_iommu_map?
> 
Good catch!. Thanks!. It should be dest_id_base. Let me fix it in next
revision.

Thanks!
Sunil
