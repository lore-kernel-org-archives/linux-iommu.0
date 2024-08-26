Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4296C524C
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724680313; cv=none; b=mTmD1CQi0gG2Z2InKC0btS36qXX0h84woyimDiiPkS9F9suV21S3VdZW+mR46aaGd+gQqDepvyJrR3nupmG6RpkZJXHom4neUqRJwc+QFrau8c83OdoE8Rag/R+3t6HKPhADk2ihp47J/9qCOLhrc3yK0qmYiX+QLFcOGCLcreA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724680313; c=relaxed/simple;
	bh=T4uELtTz0h2hbDKsPlKWGyHFluDRTZCsFCpkHcCXFVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BU3PiUbxwtHgMaLa6H2InfkDaOFYWRJIWpYp+rekJg5nO6HEO+w6OtKaOY6ly4C1j4pGY0p+YCns3UvR0gyqHKxbbd+LD9J3yOBBh/wn5mRpmNh7L4eolcMpCxiAYg8/tA8kKmxBsXUqm/kYANNcpPFadxcfALd2FkKeSxVlnsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NOT0eEUT; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NOT0eEUT"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-45327512c3eso23830481cf.3
        for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 06:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724680310; x=1725285110; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tSpzCKPZUFQObO6ywqEN9gbk2zxaTV5pz/cmk++58oo=;
        b=NOT0eEUTeapTSjiTlMO2rl+IY4fhJDTRU6yvPRhbN8Ms5+zi2kOKi/xmjHOPNwNv89
         7GF2+k7wbwSPDhrRNsF+zUVzY2+5KpV+G5m3mXUls8V66nfQFXZJa7hPjjkCYzm/ahgR
         6ZvQ8jyqNkAhpjNS2dZW1jrgWutCa96QzUAff/ygdmdU/8VFEENOj7a+bgTimfOW84oA
         nGIK09SgX2fOfnVQz9KuyH/kmbK3hv1L6Xthmgvci9X88AtnNrbAbIlmcKd4ZeJJW8Ly
         AcEGRQf7GtACPfm+sbYH6ISasmRe9XxwA6nUy7bwkrUiCnfve/2gJmPLJ0JvMb8JeR+z
         i3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724680310; x=1725285110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSpzCKPZUFQObO6ywqEN9gbk2zxaTV5pz/cmk++58oo=;
        b=Z/p/ywkd2Ni23veRFgdEqW8ecQF4NslMimN4mx+75HmJXFSegyoDF8VksSTwBySqDP
         Xvh3U/Rc3n0d5pXI2GdmVuRwzYKdNXcjApsjEmsED+KkDIfMrqZIf3/hXYuF3OWrv5or
         wvSCYjlbeB59b5F0jpycdvL2CSVWV4yoFtIzUcX4MXKv3K3lbteNadr54UaobC6XVssK
         CCKCeA4fw8gNjC7xhIQVcZdw4KZCDW9Xv3D02js63JE/HuuUSpdkoqG4hQf3vrcjx9SN
         MB5RN3vx4gZsMvCZjl+a2k3zLRgxGThDwPoHqgItGlB452nyAUkrPYs36rAaZygRpbEi
         48MA==
X-Forwarded-Encrypted: i=1; AJvYcCUgQVqbO6bVzA8WpikwSZj+MFx+eS4pXsHHZHSKh8a4h4ZJsyC6/FbJYMnnDBRoIvglhPzQ2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+QiLJdbaMNWG2w/hjMN9gjcoCyflmQGzB8JzqSsvFFaylAvcO
	EsAGYAPMuwZ3Kp3W/zL4Keb0bx8xy/BOScce+CdEKirl7wWxMsgzEuy28Zm0kAU=
X-Google-Smtp-Source: AGHT+IFjp0KeB1I9BWAJVBsDkK9r8BEUosQQ+yD56qxboDp8NbIfh4m624VL/8qJg6uW0oRdGaa3zA==
X-Received: by 2002:a05:622a:5199:b0:453:75c0:d169 with SMTP id d75a77b69052e-45509c1b4b9mr176683131cf.19.1724680310031;
        Mon, 26 Aug 2024 06:51:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fda0d474sm43437701cf.0.2024.08.26.06.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 06:51:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sia8K-00BuxS-OT;
	Mon, 26 Aug 2024 10:51:48 -0300
Date: Mon, 26 Aug 2024 10:51:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
Message-ID: <20240826135148.GG3468552@ziepe.ca>
References: <20240821133554.7405-1-vasant.hegde@amd.com>
 <20240821133554.7405-2-vasant.hegde@amd.com>
 <20240821163147.GZ3468552@ziepe.ca>
 <689eee1c-4b84-454b-8dc5-a5f35abe1631@linux.intel.com>
 <20240822124307.GC3468552@ziepe.ca>
 <ec556b8e-4a8c-45ed-a3d2-319ef9fdd04f@linux.intel.com>
 <BN9PR11MB5276296DD7C9503378C9227B8C8B2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7ca97716-fe84-426e-bc73-808f8182ddbf@linux.intel.com>
 <BN9PR11MB52760A298E3000770D2FF6F38C8B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52760A298E3000770D2FF6F38C8B2@BN9PR11MB5276.namprd11.prod.outlook.com>

On Mon, Aug 26, 2024 at 08:59:47AM +0000, Tian, Kevin wrote:
> > First-stage has some limitations for an UNMANAGED domain. For example,

If these are important then they need their own flags for iommufd to
request them.

> > - No separate controls for the Access/Dirty page tracking;
> 
> You can do sw control upon whether to pre-set the a/d bit? 

The VMM can specify

IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING

If this is important?

> > - No Write-only permission support;
> 
> What is the actual usage? What about a vIOMMU which
> only supports stage-1?

Is there some usage for this?

> > - No page-level control for forcing snoop.
> 
> again we don't have such page-granular snoop usage now and
> in scalable mode we always set PGSNP field in the PASID entry
> which makes the PTE snoop bit unused.

Right no-snoop is expected to be domain global.

> iirc arm smmu is using this policy too. Jason, is there any
> similar limitations between stage-1 vs. stage-2 as above ?

There are some difference, but more around performance. I think ARM
would prefer to use the S2 in many cases because it may decrease the
table depth by 1.

AMD prefers to use their S2 for performance because it has more page
size options.

Jason
