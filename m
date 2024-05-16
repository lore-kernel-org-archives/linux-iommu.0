Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9802EAF5
	for <iommu@lists.linux.dev>; Thu, 16 May 2024 07:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715844905; cv=none; b=eIKH8HyTY5r8bVcr1qvcv5xY08d0Uqxad+R4Bwuy83/8p2+i5CqY60epM7hW9ZwCB5wFCGL5GjA+nPiNX9irCfm/bc6bk7BrOAr43L6Kb9CxdsnbGYY4WNsHgydlhUoZvKyAa4z31xGqJY3gyrke8V269LhnWuSBjsn5g2J9Tqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715844905; c=relaxed/simple;
	bh=ZMACuTR3vRKSoU4pHT19THsZk5hrQ3AyoJYvIvgJUUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeb5ix9nuNpNH45rMqxGQMV5NxxKPEtc+jkyLV1gyD5BjV9jqKNOJiy40hSP6Be8ZIz9HUQ3haGiYmQaPtRAPbTEVaBJdm5/ZiMTXQJPqxJzY7tndyIXHvFwD+vylHUzFOjKw8Vp/CYMmo6JajqdzftYFHyuXEnte0g3U2DxI60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rv86DIv0; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rv86DIv0"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34db9a38755so7266844f8f.1
        for <iommu@lists.linux.dev>; Thu, 16 May 2024 00:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715844902; x=1716449702; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RosNd3B/hfPPJgEd8do/IrHkaPKjQ1tjjKxBt5s2vzw=;
        b=rv86DIv0SLf8njLqhRUcSUbrmdEIVkQ4Lt8CMgQ5UmV21+bIQbLHDNDsMp3PRgLwAo
         lJ9fos92Y/zmtVPNO6+w6N/h8Km/sP6a+xPzUip5NTSYoy/yoXejNK2x8Vo7TeVUFYjK
         VkLGq19XOaA24gfbG8zJr9spV8g9R3Jx6Fh/ahPX7hHFLWC3J7Mrm6x+M6gaamMvze3D
         KhUY7b1T5CbU0diylru/MwzkkMJeJ+lCOgcx1mo/32CnP595/ymxoS/INxgj6OuEdgs7
         /x6pCqWJZXMjhVVWa7OUZkHmpmHuPZnAYDRxSKsnzfHhEth+HRBw5mPBStLUrSOaj9kr
         lYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715844902; x=1716449702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RosNd3B/hfPPJgEd8do/IrHkaPKjQ1tjjKxBt5s2vzw=;
        b=haABGuEHdgHHz2+fdirtJvzEUhaMfVGuEP+DWm3ceYYeoYhP436ogXStarrK9H12Jk
         bYhvGCGSKS3Uwwq2AjZeGV2ziCWaUPpBBIJwZ716HOS+XMEugdnq87bF2Qt78dwJsTMn
         JnXqPqHyfiXM/K0NMbtAtoXxwdHYe8cEaa7l3pYpzg3WZP0uIk22nRfD1BjmaNK1PI7l
         OXula0Y4JoJBnQ53EqG6jVxX1BjkvkTJ1eWlA5D2C0TDpn9tmBT3IVUg++J//8fHQc5s
         cwEARDqekdCtpyMWQYRrKWcpnRIk7SGxeKW9JadpPYrONwMW1ehno0JneeguQfdlmwdL
         ynIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrri/U5D1m3wFpiYhe6/kOiDflJbIkNtKkefbL3TZ9+GCpJTs/qQvsSQjsSuwIqJxwcB+91XpT0i3fskUu+4vuEWA62rk=
X-Gm-Message-State: AOJu0Yxg08XjkKalpvxjH7jHr+vdvDSvpzmRciamOycUhdpP6EAKt+TR
	lCgINfXtkXKerurJq8j3kKsH3E0r2lC/F3nCU1gMOMSXiBRL2xS9mrXM4+lNBOU=
X-Google-Smtp-Source: AGHT+IFyT+2cX3CUvKGm2EXv4WIaX+r6Q5SkjvFFmDYOtCk8+G42oZ2PPreRy/IsRw9tSFPb0TzkOw==
X-Received: by 2002:a05:6000:a88:b0:34c:e62a:db70 with SMTP id ffacd0b85a97d-3504aa63447mr17873757f8f.67.1715844901762;
        Thu, 16 May 2024 00:35:01 -0700 (PDT)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fe004eae9sm244071795e9.1.2024.05.16.00.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 00:35:01 -0700 (PDT)
Date: Thu, 16 May 2024 08:35:00 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Vidya Sagar <vidyas@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"liviu.dudau@arm.com" <liviu.dudau@arm.com>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Ketan Patil <ketanp@nvidia.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/3] Enable PCIe ATS for devicetree boot
Message-ID: <20240516073500.GA3563602@myrica>
References: <PH8PR12MB6674391D5067B469B0400C26B8EC2@PH8PR12MB6674.namprd12.prod.outlook.com>
 <20240515185241.GA2131384@bhelgaas>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515185241.GA2131384@bhelgaas>

Hi,

On Wed, May 15, 2024 at 01:52:41PM -0500, Bjorn Helgaas wrote:
> On Wed, May 15, 2024 at 06:28:15PM +0000, Vidya Sagar wrote:
> > Thanks, Jean for this series.
> > May I know the current status of it?
> > Although it was actively reviewed, I see that its current status is set to 
> > 'Handled Elsewhere' in https://patchwork.kernel.org/project/linux-pci/list/?series=848836&state=*
> > What is the plan to get this series accepted?
> 
> I probably marked it "handled elsewhere" in the PCI patchwork because
> it doesn't touch PCI files (the binding has already been reviewed by
> Rob and Liviu), so I assumed the iommu folks would take the series.
> I don't know how they track patches.

Yes I think this can go through the IOMMU tree. Since patch 3 is still
missing an Ack, I'm resendng the series next cycle.

Thanks,
Jean

> 
> The merge window is open now, so likely they would wait until the next
> cycle so it would have some time in linux-next, but that's up to them.
