Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDF6383C94
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 23:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778886356; cv=none; b=BdCjK2zN5mRXraW4l2lsKvkLIQZTF5kFbHPXEvGbCSSVLz8WOK1cwSdIIDpHeeS7kJZm9qqq+lOcwP7s279PvhRHQt2+je3JedKURR61nfuYv6vK0G+mwbGRTHm2cW4OcmKjeJS85ArGwZ9F8P8kXuQNoKQiDfOmfdg24MPcfVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778886356; c=relaxed/simple;
	bh=Efl9eGRUvRUSMKgeJbT5viBCvrEY9UH6Bmru0k/SItc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqo0jC0Qw4nGsfa7zO+ia/Ylgcc+jxD5ZQpNmQin+5O+hqhu/ObieWZ4LURM4pDL+Ob+qNlPJGGQvY1NXykmxisBb/6ns0/bq8+aWTsnEXWY4vsetdawpXLVIQopS6HB87nMTL3mET8lnUrnbFdBuSEJPLEvezyP1t95zvJ8zf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lLppuz6o; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lLppuz6o"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8b62ca1d28eso5086976d6.2
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 16:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778886354; x=1779491154; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D7nklUCScqv2NitQOcHmOlp1LpHmTXVfX8MzcU0yUSA=;
        b=lLppuz6o886fqhxJH9TnwAT6IxwKQYZt9Uv/KN2ED9FI7H43fL+QwRkXd3gPuZfFcU
         C83cDtkOrN1jDT5vMBLKCo0y2yynFgHJ2TooJ+RUUz2vnHfIgrOj0N1B/RW3l6RP5si1
         Nq/Z5NUU3WdIajHZTvPJhEXwT+lLpT1AqGA807NSRa8hWXTgPWnltZuknzQB7IZhxbUc
         j/xMTevcPnM8Y6Dl5/2IHzE+m3Hl068JeXanVaQqcdTSyuDIWIXKwK3SbAezvI2EVEIX
         4EzNFm83yhMVUWOUgIZJT3FirvPg8vumPeck4XUmFkCBRJhnN+XDq1sztpIyBbxSzOEv
         NvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778886354; x=1779491154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7nklUCScqv2NitQOcHmOlp1LpHmTXVfX8MzcU0yUSA=;
        b=CIWU/+0U/z248hdFyYG7LT6zSXPLYRTYpqW0LOs+NHqeNuQMFn9lG7zeujgX5W9080
         W7bkZ0cKPIfkukmwvlx91yE5GccjJbXKEgBO57g1A180tLdq2hG8t3n7Uu3JfvGGFTgf
         RskCUYGWyItksHtYM+CbP/xMu3LIQn3oJHmnISAvK61ursGGeDA42yLGCqwXpExPpro2
         /c9OanIYa4uJ6NkWqL5AdIEznJchMFAipK/4A+cmDozk1l4aziV4ZC2r9AU454V/TLPY
         TOtZNVQe6a0iTzZCA3lkbUoGtOQnOKDAecAN8V84FFJMc0jvDAfJ5Yi9wsemFccz2heT
         UyYA==
X-Forwarded-Encrypted: i=1; AFNElJ9uXFhzhSFWxp+JCOazjtfQHLKaOzlXoMqqFkJ2BvV/go/ByfuoH/LhAT6ojQOzzNuDww2iig==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCfjrCDRnk9Zia3HsbnLREtUTXyVullmmEuKfK+AJd416zwtzh
	nZcOQ7NqBWcKtPpnMEdZa0//OMcazOVj2cPmXHYg6DxKhfNl7J/MoS9erTdBWdVMX6k=
X-Gm-Gg: Acq92OFf7Cdn5gmKuboDUxjod9N0siD09YpgfaMaS3/O/0AMzNzF6YG7GkXGx3jzPHI
	X499hyvMT629tjtQcBmDbeuBu6yF7FProk9pEAKVSRZ2Nx2Yr2ME4bZ7Z4yARnD75ApDfxMIsBl
	JyFMTr6Yubar0CRO9eUk1TH1WprJM7AhHVHc0xKg47eGHrUGUviU/gwin0fyv8JvSbLYOAr2++Z
	npS7EHZEkxp0LnufS2CyAze6xA4xa5sgkEoq6kZPoA5o5bAyBnD2LU/ZoCxyRW/zyct0pbRKSCC
	DGKdAmAtUi9fIrn/b+QRJ7+WOSGGT9xBa0DJA3my5ZwI07Gj9NbCNvajW7xHcWAgbDyTUqK6b+u
	efpJpkw6YXUlolkax5wWAJL93ZIkboblz8T9RVspTquvrH8hi+kvmg+gj/xROXl1fxiIoi3NW2/
	uzisX5tQCHPaAX8QBfuZAGOmWJGAf3OUWrNa7LnO3gkkZe84LXZo4LiDYxZBoIHxnUIuZ/e51Yi
	+tycg==
X-Received: by 2002:a05:6214:1c82:b0:8c2:b36d:4fc1 with SMTP id 6a1803df08f44-8ca0f66afc4mr87385476d6.14.1778886354080;
        Fri, 15 May 2026 16:05:54 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90c374469sm64030376d6.49.2026.05.15.16.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 16:05:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wO1bN-00000008GrB-0jOE;
	Fri, 15 May 2026 20:05:53 -0300
Date: Fri, 15 May 2026 20:05:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Ross Philipson <ross.philipson@gmail.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	iommu@lists.linux.dev, dpsmith@apertussolutions.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com, andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v16 01/38] tpm: Initial step to reorganize TPM public
 headers
Message-ID: <20260515230553.GO7702@ziepe.ca>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
 <20260515211410.31440-2-ross.philipson@gmail.com>
 <agemXwxVb9jvAbYM@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agemXwxVb9jvAbYM@kernel.org>

On Sat, May 16, 2026 at 02:03:59AM +0300, Jarkko Sakkinen wrote:

> LGTM
> 
> I'll hold on from actual tags up until there is some consensus with the
> patch set.

This patch set is huge, and I know there is alot of interest now in
DRTM.

Can we please split out and progress the TPM reorg mini-series at the
front?

Jason
