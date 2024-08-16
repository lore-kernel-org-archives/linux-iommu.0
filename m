Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271E21B86DE
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815163; cv=none; b=FVaOH3jZrteSa72hmNMbxQNGyg0AEg/p+E7W6pJZKBeLZLSHkpaLN9CNCXJ3Cwhc1MWkPdxqONMsfQiBLXGQISTN1a0u1hhjli96zRhbtaY7HERenPjtiNkRv2vQcoPft2RkHd67P+cLsx1eSOwoXPg3DXdXiaTCAxIbs/tFso8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815163; c=relaxed/simple;
	bh=qcTAVK6EItOoSO1Q3tgK65Y7zRc5MBErrU82rC1VqJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxZu5EfDtA9YkVsF6tL/EDT6Yihj4mwFJKujFNRzW/G7eDZpeEwWofwReqsE3vcWJP/DXGMZlqYHTCRpRB8af+0pZ8sJLkWGCrdmkBR5lAG/LV+0AilpcjpSNqv4HTzyKviRvfp+eDEfGr4yGT5qurhH2b3UEq0bBTITJPFsCdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LMRrhpv1; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LMRrhpv1"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a50313f785so98231985a.3
        for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 06:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723815161; x=1724419961; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hcNVKD9ArkalzemGS28H2A8RRoS7UHu4ogyyEqaz7QQ=;
        b=LMRrhpv1jEfx8DWfvCyoXHQg+KJU3JBEjiYS2OzJc4rFJ+h9PqQ8V+opDjxYpWoFdR
         uUDuiXvSLXblVolkrOPc8Bx/e6bNhXyhwrNaqo8fp3mkmteN5ov9CPRlQtH9lQAJ25As
         crIQEVZrGEIn7rOkgfi54BebNRguKWaB2Xkv1PB0WZvfGQdq3eTDFRtlrTd4iEt4ylb3
         UVXTZywVMffWNwfOLt3pmc+mGM25pUHg8mziW+QjbrRVwzWnCIX5BItWn6cejudYCRzY
         po903B6UXyQ+Ikhf7tb2phblTwxG/B3FMr2ymJgIxd8qO7tOVuLofdWReq+k55UMMaZR
         Sm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723815161; x=1724419961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcNVKD9ArkalzemGS28H2A8RRoS7UHu4ogyyEqaz7QQ=;
        b=xHOY4NQLhpkFvisFaAv1mB4MaLTSwPLCNrhC555nNStKcf4t5A/RKjHslUqjksuCdm
         e4EKzvLgCmThSjyMCyzxvaPjaDnmhblla5yK97eJmWmkpf6R6QDoiEVbYcyRbmdNY616
         p87As8PkpJciHZuqcsDbN3uoQ+KMF6d1KXNnr6LIGdeo/fYoOvRjrpj23tmMeyiXy/fJ
         QGzU4W2weakk0rufuGqzulpUBiLu/d/niQws5thBbVzgVi9wJRws4kYUQIvzvK29XjcW
         tSTo9fY3qMx3TpvlYRlv7feC/qxRaNd7npt1uHEH+TGZ5VNiFjE5BOgDsU6EqixaKMmz
         cAEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPSwpbF8SgTxj9gAJkvrHtqoFrd41J4R0If9OKj5fCujnY26xWzy/FTCaEHs/VCSMbQyfXVlxq2GUoN/osJGo6SFtwsrc=
X-Gm-Message-State: AOJu0YzYwUk3hdl/gMKbHjUu9bXoe58mCeiVX92ZW0udrB2sLMslvtbr
	H21rJ8U8SipMZpWQhWdrIkziMr8PKcR9OvaVHCs+5eIG/KBjEKJyNJpBl0su2yUQByosd/V5jUk
	ULIw=
X-Google-Smtp-Source: AGHT+IFWZiZFILtEO3eQGWudldVtkY+zYk/91TK19t9S7myPrK6cUMb0pkmDP2UYPZcLYzFykUvR3g==
X-Received: by 2002:a05:6214:4893:b0:6bd:6f1e:3303 with SMTP id 6a1803df08f44-6bf7cd9dff9mr33711496d6.13.1723815160843;
        Fri, 16 Aug 2024 06:32:40 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fe2748csm17322026d6.63.2024.08.16.06.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 06:32:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sex3a-009kPY-NK;
	Fri, 16 Aug 2024 10:31:54 -0300
Date: Fri, 16 Aug 2024 10:31:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Move PCI PASID enablement to probe path
Message-ID: <20240816133154.GQ3468552@ziepe.ca>
References: <20240816104945.97160-1-baolu.lu@linux.intel.com>
 <6650ce02-ac85-4cb6-941c-cc7e8b6effc4@amd.com>
 <92b55591-e106-4366-ba5b-0588af50770f@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92b55591-e106-4366-ba5b-0588af50770f@linux.intel.com>

On Fri, Aug 16, 2024 at 09:09:04PM +0800, Baolu Lu wrote:
> On 2024/8/16 20:16, Vasant Hegde wrote:
> > On 8/16/2024 4:19 PM, Lu Baolu wrote:
> > > Currently, PCI PASID is enabled alongside PCI ATS when an iommu domain is
> > > attached to the device and disabled when the device transitions to block
> > > translation mode. This approach is inappropriate as PCI PASID is a device
> > > feature independent of the type of the attached domain.
> > Reading through other thread, I thought we want to enable both PASID and PRI in
> > device probe path. Did I miss something?
> 
> PRI is different. PRI should be enabled when the first iopf-capable
> domain is attached to device or its PASID, and disabled when the last
> such domain is detached.

+1

Jason
