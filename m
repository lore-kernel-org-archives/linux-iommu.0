Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775A15589A
	for <iommu@lists.linux.dev>; Mon,  9 Sep 2024 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725895007; cv=none; b=uMWMoitmdm1ym1sWkLnyY6baSUsR3X0AciQoAZCRiocSOix1q/DqIPys6eWFEMoJ1azVpddzTr7xidLU7d9A16T5onXPBrqA9CoQ8UliOfVJ2ekXodiYNNqt1aJv3cfVTMXses8OFlnppVV0+UvjzryuOjLQVWdctSBx8359yDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725895007; c=relaxed/simple;
	bh=NigwiX9GPkklY+FWgvafDxLI2iZ5t043LZM4XHkFuzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UINWHpd5wP8V5c/0cnUnYY0+C5HmuJed+UT6zDTQKbvhzFPqEHBkV7T+TmWOOt7sh8nALcyj9fEJwbrmHgtVA3vwxY1EXUafFfbNfd8SOw7DWDG3rMJwDODU1JL5lSkAUp47bye6u1Qes7bs0UClIUjfbmMfjg5iYcU04NIO3Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XMe1rbqA; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XMe1rbqA"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6c51d1df755so24377096d6.1
        for <iommu@lists.linux.dev>; Mon, 09 Sep 2024 08:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1725895004; x=1726499804; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tv9PZXsGeVNEOOgsoLAol6p/TXegiJsqpqgXCEhA5Lk=;
        b=XMe1rbqAG2Ru+/Ssy7NzvssaaqB8TjxIZdtBHyxfR+7lBuThgPSudjttoouY46rn/P
         Rx2qrUWBQTZIzmVHykU3gCZy5Omowbw38Qq2bhslmSVY5v+C8wgdeaMVIAZVV4wvP4J4
         VDfc4oleOlNh6JTqCj+q0y1Hrw4+VCv179+2w9QhRROG8ChSO1Q1vhElwe8Hx6vcl0Ii
         DcTOOaRnJu3xjpBs92uzf3j7Bff+q3zjJ9bl/hkcT5/yBfg0vsN8iGjQLeWJHTIf7ZAe
         coabmsSI2Rr4hgQBeQJIroC3R72lK5xKJZsM16BVs1DHcFVJmP33zTqBVbCspruNqNtS
         ONhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725895004; x=1726499804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tv9PZXsGeVNEOOgsoLAol6p/TXegiJsqpqgXCEhA5Lk=;
        b=A1zes/ZkTeTn6Jv7JsEo9Htjxml9JJGHoiA0NMtUC/UBtYMq/F7n1R0ko4M4u4Ogo4
         5qyOl9AVSzgEI8gyLoTaybXd4/ZafI3FfypE5HpufV+nbNSK/7tRJd+P4KxsYeWrilbw
         ArJx2RCLTMP+lGbQETu/7PoAeKGVAQb1Rl7gebQByxssuydIbq2QTDqFCwVFZhGZKqbM
         kAmC0MLsQhXUNLhbcR1Slf9fQL59yCYLZSQohyzWeIPqReQlpZ6vxCQHp7+uOy6x3vIq
         svbO/mfeTZtKTEDDYi0JcbbIZVeAnBgO3ZKCza5r0LQ7JBpMb1lIawqDNj1mgbb+voTX
         bPVg==
X-Forwarded-Encrypted: i=1; AJvYcCXRm9uEDSyfgVOH9be9jXdNdaVswaqXOyOX7EogISM2+LKpXs61EzIrtSxQdkQrK1YFekpchg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTjkLDrfQWSY22w5MJQVzex67Xmm4xfQY0RCySPgRcstAbs5dz
	aqbOXfV/85rqXogQFX9RVgsdrXi25NCfjUfxIJIfsbZjbz8TsX1GMiV0kL6u7lI=
X-Google-Smtp-Source: AGHT+IFNb27YabbKzeMBlTUDF4KAD/i6OpwMBhHui1bFORvetJYA7EwypW+iYf68E8PeXFUVr8hOGQ==
X-Received: by 2002:a05:6214:3381:b0:6c5:18ad:b47f with SMTP id 6a1803df08f44-6c52850dcc6mr142805316d6.36.1725895004346;
        Mon, 09 Sep 2024 08:16:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53477c27dsm21509746d6.129.2024.09.09.08.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 08:16:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sng89-000jZU-Qg;
	Mon, 09 Sep 2024 12:16:41 -0300
Date: Mon, 9 Sep 2024 12:16:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, ubizjak@gmail.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v3 1/5] iommu/amd: Disable AMD IOMMU if CMPXCHG16B
 feature is not supported
Message-ID: <20240909151641.GC105117@ziepe.ca>
References: <20240906121308.5013-1-suravee.suthikulpanit@amd.com>
 <20240906121308.5013-2-suravee.suthikulpanit@amd.com>
 <20240906163818.GK1358970@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906163818.GK1358970@nvidia.com>

On Fri, Sep 06, 2024 at 01:38:18PM -0300, Jason Gunthorpe wrote:
> On Fri, Sep 06, 2024 at 12:13:04PM +0000, Suravee Suthikulpanit wrote:
> > According to the AMD IOMMU spec, the IOMMU reads the entire DTE either
> > in two 128-bit transactions or a single 256-bit transaction. 
> 
> .. if two 128-bit transaction on the read side is possible then you
> need flushing! :(
> 
> For instance this:
> 
>   IOMMU         CPU
> Read [0]    
>               Write [0]
>               Write [1]
> Read [1]
> 
> Will result in the iommu seeing torn incorrect data - the Guest paging
> mode may not match the page table pointer, or the VIOMMU data may
> become mismatched to the host translation.
> 
> Avoiding flushing is only possible if the full 256 bits are read
> atomically.

Also, please think about what qemu does when paravirtualizing
this. qemu will read the DTE entry using the CPU.

For your above remark it should be reading using two 128 bit loads.

However, it doesn't seem to be doing that:

static bool amdvi_get_dte(AMDVIState *s, int devid, uint64_t *entry)
{
    uint32_t offset = devid * AMDVI_DEVTAB_ENTRY_SIZE;

    if (dma_memory_read(&address_space_memory, s->devtab + offset, entry,
                        AMDVI_DEVTAB_ENTRY_SIZE, MEMTXATTRS_UNSPECIFIED)) {


The dma_memory_read eventually boils down to memcpy()

So qemu looks wrong to me.

Jason
