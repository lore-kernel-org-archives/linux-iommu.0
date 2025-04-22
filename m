Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2DA2153CE
	for <iommu@lists.linux.dev>; Tue, 22 Apr 2025 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745365317; cv=none; b=G2ULCa5Sr/ZaibUBL0l8RIfNeW+o0NgEJi4Vcp72H3MwVJm+SHo8CpAvC9EMu3Uy8jzxkiEx50ycfNBkWO7/QCBEOjFEgehzImXpN4rzSt7DgV+Bi4D/B3qqWK/WxbQtr2F4O81KG2Ta0i6G5tR20OnmFlbuOkQHRJ2tzkWIPpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745365317; c=relaxed/simple;
	bh=d7gFECswBR82rOuJZXYrMO6x34hzdB9wF7yn3yimsy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPXU/QmZx8iu2tU0hUc1FMNtGM7x1lAztaN+UoooeKMtbBb3ACy/RXvJQfMGhPGkX5ozh/XqC8/qwDN84MfcZ4FM052IESXu0YCkPMEs+x8Esv8vo2VRhZ/sqxz+879Cf1n8EDzyC0kxQrRUjKExyDeLN1ASP4m4ifTN3aAllrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dO5xxyQo; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dO5xxyQo"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4774193fdffso80955801cf.1
        for <iommu@lists.linux.dev>; Tue, 22 Apr 2025 16:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745365314; x=1745970114; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d7gFECswBR82rOuJZXYrMO6x34hzdB9wF7yn3yimsy0=;
        b=dO5xxyQoqN8PR+m6kCOQShIzVizuEVALxxXSYuRdsBABG3N/NQwhxRAdplUbvZ2Zg8
         SeIUNM9cqL2ySVbDbUtFSyPpmrHDBbylD8nOUNm+YgQQiCHxCP+7VwwsXNHJUTOx3wF1
         MVCH0OWJkP9kJjgpDzJd0IQP5dQRufpv4t1BO6El4befvvDSuf1ctrx5uBakmEz5QTVQ
         lKpOz+kgrS6P4bLJ7haEy+t8EIofr6G86Kx+iQR+lu/rzwM7V3dtkG3+S83tqGlf5Nf5
         CsF1Cily3+HQCvW+ByM8GSw9qlocpyELV9VeKogO1ZHmhPzuMYRMG5whRvgOFaJ2oL5c
         1Jsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745365314; x=1745970114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7gFECswBR82rOuJZXYrMO6x34hzdB9wF7yn3yimsy0=;
        b=R4Vc3l63szC6+MUd0DfOMupfi3y1BkSDs8nBhce+OhrxEHtffUAm4Bf+pf2xwuIUT+
         jnF5FY+dR0XDJNdOpAD3BN+7x6BCchU5SWaOmvwnEnVSTpBE4eYeNvTcM9zs8l4gQ2kQ
         BLUunoZhy19h82DCFg87RofO9fsvqIixLKlVkVWAfpkMc601+G8ZM5rxPaEd0cINFxfI
         p1KCxj4xw1cgPllZ/EOJ2b/0Y6H+T4FT+2hqxcozIfR689qZ613VtYdOvTDYUgVnN58V
         d/IACBMXOgl/D6DQZuQYWnfNl2uhOaeRbpRxD9PuVtlPC9qDuNVXK13uMGKwlfhknVf3
         z5hA==
X-Forwarded-Encrypted: i=1; AJvYcCU/YV1fxPnJ7k+ASWdszuFgbHo3rKxxs6KX4uS/gC0Gup9eDcgrfbmXM/YZDA4jaLje7hHGEw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMGrqGIdYc/Y//FbS0rcj+E3j9cfN4D9uQ/vB4+8w2eWSdcff0
	Lfu3Dr6ZKo6vxcO/Gx7JaRk8a5FOrBOksRvcRL+Pv69CWP/FY8RvsFsUtS8Y/Zw=
X-Gm-Gg: ASbGncvXn8mI+LB3cKQlXVrISD+xaKc6tP/ykzzC+yL6JAi6zcmtNlBMQt1L56wDkNB
	ObabrYCt+ErJzOanUoAk/LTSRinStr1O+Nn8++jX0TapCLTd1XoK2/tPJWwoXPqoTuDuAZ5gwpY
	rd73/ouJxk1irDZ0dWRTKz5qZGHyCXkSFNaScux3M5aJ2WQFuGnKNGYeDQTyTpfWzwpLrelnyna
	pqLSn/tBq2+eBJ0QibV7Ivgiy/Tu97TlG5U1Up+mkEV26MRsUjKacb3KHVVwA294eXytq1vS4Xl
	b0YmdR4MjQ3pRdokctQFvXyDvryQjihLTS8KWiyoWC2z9e+hcyQ4rU/mVkbVBZ2jO26cGjjVMhd
	/gCbZNhHy8i37j2GLeXA=
X-Google-Smtp-Source: AGHT+IHMJVzBS9ofe/pFhoyhF1nSXR0nkPPB8mnB6Kmq2s/kk2ojN9lhj/BWknemUlGIDrPDFrdQpA==
X-Received: by 2002:a05:622a:255:b0:476:6189:4f30 with SMTP id d75a77b69052e-47aec4b5239mr303709741cf.36.1745365314381;
        Tue, 22 Apr 2025 16:41:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9c4d68csm62754761cf.47.2025.04.22.16.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 16:41:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7NFR-00000006xuY-19ey;
	Tue, 22 Apr 2025 20:41:53 -0300
Date: Tue, 22 Apr 2025 20:41:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: William McVicker <willmcvicker@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
Message-ID: <20250422234153.GD1213339@ziepe.ca>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
 <aAa2Zx86yUfayPSG@google.com>
 <20250422190036.GA1213339@ziepe.ca>
 <aAgQUMbsf0ADRRNc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAgQUMbsf0ADRRNc@google.com>

On Tue, Apr 22, 2025 at 02:55:28PM -0700, William McVicker wrote:

> On this note, I was looking through `of_dma_configure_id()` and am also
> wondering if we may hit other race conditions if the device is still being
> probed and the dma properties (like the coherent dma mask) haven't been fully
> populated? Just checking if the driver is bound, doesn't seem like enough to
> start configuring the DMA when async probing can happen.

I think the reasoning at work here is that the plugin path for a
struct device should synchronously setup the iommu.

There is enough locking there that the iommu code won't allow the
device plugin to continue until the iommu is fully setup under the
global lock.

The trick of using dev->driver is only a way to tell if this function
is being called from the driver plugin path just before starting the
driver, or from the iommu code just before configuring the iommu.

Given that explanation can you see issues with of_dma_configure_id() ?

Jason
