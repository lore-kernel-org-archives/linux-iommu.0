Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C8D78F2F
	for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 16:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758644357; cv=none; b=WKRhPXhVYpjInM+38GUGh2zUJYNVzylF6PEZaniG2aL/fRkeYzVqxHwzOWamjIU5H+/TRd5IaTA1/VUKao38XGfrK6VgYd2+sEtYjZmWOHMLIog+agrLIDIT7pFe/foWM1d+0I9MvN2tWkJFvX8GQn0RlIvPMf04yF+wFqHRqFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758644357; c=relaxed/simple;
	bh=QkKOS+cKXEg7Fh/n2Mposi0sIPirZ5RMkl5yEj5Yt9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsYsKnikf5Wn/kOqLoU4ydmrilnNIBN1U+Y4Vka2287/jZsNtu7I0r1hjlmjuU2kVkX/KkdO2wUO7S18pm0jq0dyTNy+XRsR8K8xFCCI1iu6iC64t3uIojOAOiBfrsjL4detBqc5nmhxCCHeXYjhwF2hv24CRnnvUVKW379Uovo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Mq9XWfPk; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Mq9XWfPk"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8276e579242so501389985a.0
        for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 09:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758644354; x=1759249154; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xKb7tsSmZ0H6Wdl04tAiaIQVZQbhBUd7k5adJ7pyr5g=;
        b=Mq9XWfPkeq9eTtf0yN3TH2rDiCmXH93VT4zDrvkgle+F4wRaSQz6mgIrJwzyWwyRBM
         UZInqMlocAZxWuvgG32MKDiKC0Mc81sBWldbohdLCi/aFDiBjtuDyPJ3wHAfE6MPSCAz
         MWs/KODRkIbHIooyD5enxQV3q8Ry1Gu7xZ1iX98wjKQZVB6Q99tKPqVaGIQVddy/Rdd1
         z/2HF/l+a3dP2w36ugqrb2m0bZ/Iy6zxhTCidaiUJI1e8UgDZUlX4kQ/1/fyrNmcIJI4
         9u5FkrBRDMsQ7tBYBi2fGSmIfOXhQDFV5zLeCwkokYGgSGev4OlT8LlYRoADsoTwKGqt
         8i8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758644354; x=1759249154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKb7tsSmZ0H6Wdl04tAiaIQVZQbhBUd7k5adJ7pyr5g=;
        b=wTOByctO+DxQVNr7yXv3wT+FFhYeguT26m2YAb82xVtmN8HoFb6keBooq0HyBnVxXu
         xnCc2ELM9zH4YsUhOqiNoUNkkHi16RDuutzCfPMmbvVnqt4lTZPoxGT+8dVl+JztDqDC
         axO0cCVuoZn+0oUBsnbE0ToUJ3YLlDEyQOAhnpat+ye2QBcunkTcUjvwoHZRaK2v8/v6
         JEd+VX/gz24hv2YhmaZMQ6fTP62yIfx/4lDBZ30mxlY1zn+DgEEeJVfenHMzwmg893HN
         u6RTj5jQesKDsZ6prrm1SsEZbUF2QcibXOhcm9on5cUH3+UpBCXUg6tNb3Z4ERPgNdG9
         fBqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNO1aQB2tF463daIRGxy2IJ4Qe7/oW30CzEqiRw+Vw1M1HlkmhI2s56GJxBwT/OUGmByHKig==@lists.linux.dev
X-Gm-Message-State: AOJu0YynWyZKRwvO1WrbTObbmM1evN79lFnI4Z/nOwqSfIwCZa4AGhBf
	Vs6XwU1c6xGk0KqiiRN/rKyG5/sZI4rT5ksEsDXKIlobWG1Kas6C5K0e9/x8qSaIZgU=
X-Gm-Gg: ASbGncvkaP7L9jBHe2FtCzlOVm9qpgBUWGWjKi667PxZkhWsx8H27YZ/n+Q4rUOjQad
	HBpeUGnHBiM/0Wc4CX6PcUBq2l4+ZBfMGT18Yp9HVMs0WAz8FlcK3FUnj3XormEDc0hjam8adva
	zX8deSu26wS97so2Cn5cPtDW3sRAadkTOEi+3r6jXE6Kc9D+OaiUDrUQZwhSZXpQDAgbO8A78JE
	4mxa0JBcSBEuN5N3DncvGnrm/hWcBSGpODi/wMG1rEK+0ZNqfPUnjmoEVfpLPCU55GKC/72aWox
	6XsNcR4ucEbR0UoStNLmEcQgiXV0UvvOAHor3wAeuIryMOnVduRruVVHPjEztH2jdD5EspMN
X-Google-Smtp-Source: AGHT+IFknn95PHhsPs7zw84kBzlaAQkMLHRCQnMY3jCMzKXPkKXu2wtZSYWkgGZ0B6Tp/B1GZcGGDg==
X-Received: by 2002:a05:620a:1a20:b0:827:e9b0:2752 with SMTP id af79cd13be357-851777634a2mr367039185a.80.1758644353963;
        Tue, 23 Sep 2025 09:19:13 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-852847b70f4sm117567585a.15.2025.09.23.09.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 09:19:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v15jU-0000000Axa9-0WlS;
	Tue, 23 Sep 2025 13:19:12 -0300
Date: Tue, 23 Sep 2025 13:19:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: Will Deacon <will@kernel.org>, thierry.reding@gmail.com,
	robin.murphy@arm.com, robh@kernel.org, joro@8bytes.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, virtualization@lists.linux.dev,
	jacob.pan@linux.microsoft.com, eric.auger@redhat.com,
	code@tyhicks.com, eahariha@linux.microsoft.com,
	vijayb@linux.microsoft.com, bboscaccy@linux.microsoft.com,
	saravanak@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	lizhi.hou@amd.com, clement.leger@bootlin.com
Subject: Re: [PATCH v4 3/4] arm-smmu: select suitable MSI IOVA
Message-ID: <20250923161912.GB2547959@ziepe.ca>
References: <20250909154600.910110-1-shyamsaini@linux.microsoft.com>
 <20250909154600.910110-4-shyamsaini@linux.microsoft.com>
 <aMw4I0AjKNPY6SOw@willie-the-truck>
 <20250918224322.GR1326709@ziepe.ca>
 <aM0HQ51DelZW_Rt8@willie-the-truck>
 <20250919120839.GV1326709@ziepe.ca>
 <20250923155647.GA22010@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923155647.GA22010@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Tue, Sep 23, 2025 at 08:56:47AM -0700, Shyam Saini wrote:
> Hi Jason, Will,
> 
> On 19 Sep 2025 09:08, Jason Gunthorpe wrote:
> > On Fri, Sep 19, 2025 at 08:33:23AM +0100, Will Deacon wrote:
> > > pieces and will need to work on the userspace side. It's not like
> > > MSI_IOVA2 is magically going to work (and I bet it won't be tested).
> > 
> > It could, if someone checks the default memory map a second constant
> > could be selected that works.
> > 
> > > > Nicolin has some patches on the iommufd side to let userspace select
> > > > the MSI address instead, but they are not done yet.
> > > 
> > > Maybe we should just wait for that? Carrying a temporary hack with ABI
> > > implications to support broken hardware isn't particularly compelling
> > > to me.
> > 
> > This patch would still be needed for kernel users.
> > 
> > Arguably the kernel users should just be using the iova allocator from
> > dma-iommu.c. This whole hard coded constant/sneaky uapi is just a hack
> > to make vfio work..
> > 
> > So maybe if the single constant doesn't work we could set some
> > indication that the caller must allocate the MSI iova, the kernel can
> > use the dma-iommu allocator and VFIO can just refuse to use the device
> > for now.
> 
> So, are we settling on having two predefined MSI IOVA base constants,
> and if both of those conflict with reserved regions on a given platform,
> falling back to dynamic allocation via the IOVA allocator? Just checking
> if that's the consensus we're reaching.

I think Will is arguing against introducing a new constant..

Yesterday I was looking at the SW_MSI code again.. What specific
problem is it you have?

It looks to me like dma-iommu.c is already allocating MSI addresses
using its built in IOVA allocator. So if your DT is marking that space
reserved then it should Just Work right now as dma-iommu.c already
processes the reserved ranges and will allocate MSI addresses around
them?

The base value of the SW_MSI is only used by VFIO - are you trying to
use VFIO with this device, or have I misunderstood the dma-iommu.c
logic?

If it is only VFIO at issue then perhaps we should solve this by
completing the work Nicolin started to allow VFIO userspace to specify
the MSI Aperture?

Jason
