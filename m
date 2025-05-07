Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D214C289815
	for <iommu@lists.linux.dev>; Wed,  7 May 2025 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746633443; cv=none; b=npUPmreEVIUhcaIy7Ks+VHO9Xb1e2WT3Zut7aWvEykR/h8fTPG3azJcv7OXlAitBUX5eU5/Ti2X43P0iQNPXQ7nO+6byEAqnVWn/f9pHv09LctuVIRdzk56yM9OA4w399pjWHTgzwmKb5UPxlQXKw3dGoc6nPoDmc4g9cviy7fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746633443; c=relaxed/simple;
	bh=9eQK4QAEow732KG9bEcHB4AIdULBpH4BjFf16UDvexI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZETkUiiu4Ei3kuAU/fHTyo/DyalUnS0C22EWU01v1wIaj+/OLn6DUb424CSBhF9zGibiAFZ4zRX4EpHumX00ZtthR0i873paCCsHY/Cc9vyQWVcbyWcRNU8VPBbkgnrvEvMs0kIuiVcQWs8kTC/Hfk/uBvhjGCflbAXMP3pUgi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=K1t1FAYW; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K1t1FAYW"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4769aef457bso95266151cf.2
        for <iommu@lists.linux.dev>; Wed, 07 May 2025 08:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1746633438; x=1747238238; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oMpiX2oAeFJGOcPhonwGxFO2XwnOZnyIjVcioz4mPT0=;
        b=K1t1FAYWUkNWy4dGBRjtkmwDXpUjG0dJ1yllP+CPG2ba16V4qJPt+0N/QrEP6IfGWs
         7gjBL9KUb6hFV2wWUYPhjWf3Lbem2VQtrozOH+V+U60mjeaRZm2AW/zDfxHpuF/HUWal
         lWH683oE5EKEG8WN70hYYg4OU9AXIJMBvw9X1z0O/JO7SEJUSGtANmLpx6zN8KZhTKT9
         z4XJoy2Qas4BFmdYkT94dstEPl/kZbHCf3kNi8j8GY3eN9iMUElCYVaUKcAQ1exM9UJf
         s+7LIrWSWxqIlmzeK4o0GP0cYeVgdttHPNI7TsvZVdOQQrIyE9bh6sahRj5TWPITvVAn
         RxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746633439; x=1747238239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMpiX2oAeFJGOcPhonwGxFO2XwnOZnyIjVcioz4mPT0=;
        b=NZB4BQa7av8gwCx7+XFGLl2xYQwdiTkLTbcoGG1y72xhD2FkR1evKhvbtBzCUc435s
         O6+DPdu4O620IN9U9Rp5H7FPSSE+0grAkoNM/4e+jaFJi/lQebkj+yHNgv4eLkweWztR
         7GbCZG6i64XaOQiMsHwd5zCXN/BIHsQBqcQZtzbTrubVst1XiKDvGzq9VOTbsuzNpTWR
         5OkFuzCbDLpRy9h2rC21N+viEx2iPyinzoMVunNwItmEqoc7HvGfOFgn3nB3njV/b81d
         Mm8ai0ZrKnkzuHROBKPUPnV2hYN3Amuk6c1jcS8G0JOOKTO82JzX28XNcQRi40i2m0Yg
         UI6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCc07dp5vg/PpvEqXOrgDR6t8kc5VqQqOBPZHnKoR+4YomDFTwVzx3FTE1z19IQUVs95ABlw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGDc2J0aaw91ZjjVDAQT+0Gnna6BYYKUfimjbosjIW171sS3KE
	HUvJkcqUngY5WQyVho7UqEx9M1M0zVbeDqsqq82F8f90qPsvMAcOMzJENAgW/lU=
X-Gm-Gg: ASbGncuj9xqgYBhlVMmh+j2KFBA9CvGbeRtc3cMnQCnoWUATEdU2LqAxfNyO1o/jOwO
	HZyL/d7yvvC5KC5b1RkBQG9A8srqjy3Z1GvU6RG1wCD71RUq33gYS0Qpae0lmRxzIQGC/pNAdl8
	06VQJF245x3yyJr+CeT/4zTAmNGM531KQX4WWFYdMMc+5gncmcROVK/gA2e+JfD138qOaVcMbBI
	ZJYcSjZk14m+vgweCuKHokWSUm1XXGz94zrOOoMIDLBzvG9g0oF0042bhfBjmaVZCJsOPkvduqk
	RzxGbta5T3wC+E3frTrVL7+p6sO1nv+PbPu18BfCH7zZQmMTYbQDuARJmqvzq+HGVP2nlXrDBnq
	qI4h9PCdvnqMTdhi93AHH2S6pJk+tqg==
X-Google-Smtp-Source: AGHT+IGY3INDtooQYmwyNQCIEwpt7xooKZ7sy3RzrPyXtK9PFRJuzWNKcBsIXTsgY0x3k40zEUppng==
X-Received: by 2002:a05:6214:e49:b0:6f5:106a:271e with SMTP id 6a1803df08f44-6f542b03fd6mr64088116d6.38.1746633438616;
        Wed, 07 May 2025 08:57:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f5427b31a0sm15299126d6.113.2025.05.07.08.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 08:57:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uCh93-00000001CGI-2d0i;
	Wed, 07 May 2025 12:57:17 -0300
Date: Wed, 7 May 2025 12:57:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Rob Clark <robdclark@gmail.com>, iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
	Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iommu/io-pgtable-arm: Add quirk to quiet WARN_ON()
Message-ID: <20250507155717.GD33739@ziepe.ca>
References: <20250507142953.269300-1-robdclark@gmail.com>
 <20250507144038.GC33739@ziepe.ca>
 <8965ec0a-97d4-423b-97b9-7848454045d0@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8965ec0a-97d4-423b-97b9-7848454045d0@arm.com>

On Wed, May 07, 2025 at 04:09:47PM +0100, Robin Murphy wrote:
> On 07/05/2025 3:40 pm, Jason Gunthorpe wrote:
> > On Wed, May 07, 2025 at 07:29:51AM -0700, Rob Clark wrote:
> > > From: Rob Clark <robdclark@chromium.org>
> > > 
> > > In situations where mapping/unmapping sequence can be controlled by
> > > userspace, attempting to map over a region that has not yet been
> > > unmapped is an error.  But not something that should spam dmesg.
> > > 
> > > Now that there is a quirk, we can also drop the selftest_running
> > > flag, and use the quirk instead for selftests.
> > > 
> > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > ---
> > > Sending v2 stand-alone, since I'm not quite ready to send a new
> > > iteration of the full VM_BIND series.  And with selftest_running
> > > removed, I think this patch stands on it's own.  (And maybe there
> > > is still time to sneak this in for v6.16, removing an iommu dep
> > > for the VM_BIND series in v6.17?)
> > 
> > You should just remove the warn on completely, no other driver does this.
> 
> What do you mean "no other driver"?

The server drivers.
 
> From a quick look, these IOMMU drivers have some sort of visible warning
> related to the state of an existing PTE during map/unmap:

Many of them are just using this code.

> while these IOMMU drivers do not:
> 
> amd
> intel
> mtk_iommu_v1
> omap-iommu
> riscv
> sprd-iommu
> tegra-smmu
> virtio-iommu

Which I think proves we don't need it and shouldn't have it.

Jason
