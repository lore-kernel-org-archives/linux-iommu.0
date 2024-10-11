Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621FC1CDFD6
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728646747; cv=none; b=BIEG9h/huFKOOtp2T/tXzuL0flrPyn0ATUk4zJEU3K6mUHr6AsxXG3IyiBUg678dcbubmDaCgtRFaUmy6jWXNr67uA1KtOBGMc9n9S/IrvIrh/Ro4rfgh2Oo5n53R9P+RIzGsH7jXkl629uJLFpWYIF3ZlCUDV1D68GxdiDyq9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728646747; c=relaxed/simple;
	bh=WsqHm/0r0+oXa6weNrRag/QgQnVsVPVcIYswd/vqVbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFAPOIQPn/Kk93dFnTT81CE5LbeMqkgqqZzZ/zAFXnbgawipJb2hh9LJj3yNzRwVkgRt5lgatL3AwiU3RLQV0bCOrT74JJ68LW/2fXAmhI+8ztW1XkkgB0QGmGSxalTt+gmfToov6EVKSNAJEhW966FMHfvK6feE3QXrdV8Nllk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AhuR2b0w; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AhuR2b0w"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7afc658810fso171359585a.3
        for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 04:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728646744; x=1729251544; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iaqtey/jQOlAcUETadu7OBKpspBBzET/YWWquf+3thE=;
        b=AhuR2b0w0q+XtDqZfLvZCK/qDYMVxRUeN79Ga6i5drEdnJpD9UsSNHfu0rPyleLLWc
         zOdhrLH1x95dxok6xX+U6XjeuPMnuwhoNKTN57EMy3k21KXzdG5DA2wM3MntccowFlp8
         zvj2klCMtFUzgSz9QX35gdFsDh+gB01mCFJRasqDWy1YXy2iUASX6BlIkJcH4gPzHo/2
         wcG7gt9eqshYyutyNHzklbJ6WMVhOd11KTUWs8RBsiSHCD/Rddw6X3C8ZX145qBwt+F8
         Z4nCBRCjSo64QuzvG0cu23zF8vOPHVqINJft0yLeOW+Ahyz3zxlyXtCyiIl+6xhZWGHF
         M4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728646744; x=1729251544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaqtey/jQOlAcUETadu7OBKpspBBzET/YWWquf+3thE=;
        b=uMloAZmlB5tYHyZj3I149agFl/4lXQ++bSE/zLzoGlHAKgRNXyfdA9lwvaOM4OHVcY
         NyKbbdI1ZjPlAPNTSDnPHTAPQ68+Fl661PDldnY3lJeIHTZ6XPKY+PoSsn4JIXow44ss
         lQkyWc/N2JryklSIJHX1saojMrtbTGMmT96eHYZwiK/+l7/dCZUE6Q9Wd1VBp1a8fa5Y
         YSDAJH6H0GhQhi3luTHgNs8Yh3DyyA1dd6G2ZvIFK7KjIQyiOJzMdrHAVMYNjJrQcUdn
         /bKaH956YqVu9IKpC6sTlpRhf9LhlLt6xFxY9xjbRHgeYxvaBcxTsROva/ceWOHh6f2U
         d4EA==
X-Forwarded-Encrypted: i=1; AJvYcCVy1qgXgdGebXH6/blN8GUsQvCeQjsrbg48y8Guy2Vh8kikz7dkJkhLFu7PXc7b6oW9HPLt2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVe678rZcSvgxOX8PIzYiCBXSA8pkPHWvcYb0TkcXrZTFYAwoz
	7fCraT4Z9MQj8HWhKCCeAdrDR37jkc8gXz6XigyzuC1eMKEmYi7A/ocla5LNbcc=
X-Google-Smtp-Source: AGHT+IFiVynBZBW9C5D5cQJ11b01S+pWhx+CMLkhsb+k3Jp5hcawekvUb5AgdmGp8yD1Zoc63hiwkg==
X-Received: by 2002:a05:6214:3f86:b0:6c5:73d3:2316 with SMTP id 6a1803df08f44-6cbf0009a1emr31226776d6.36.1728646744176;
        Fri, 11 Oct 2024 04:39:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85bc16dsm14621626d6.58.2024.10.11.04.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 04:39:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1szDz3-006PyH-Mm;
	Fri, 11 Oct 2024 08:39:01 -0300
Date: Fri, 11 Oct 2024 08:39:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>
Subject: Re: [PATCH v2 0/8] iommu: Domain allocation enhancements
Message-ID: <20241011113901.GI762027@ziepe.ca>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <970c6058-9e02-4cf6-bcb9-cfb8afb4eac1@amd.com>
 <71d20ff3-0a85-4670-8559-70ca5e6543c0@linux.intel.com>
 <9d0101b4-af13-4bf6-94a5-43a79f4d9989@amd.com>
 <20241009121548.GE762027@ziepe.ca>
 <BN9PR11MB52765C7FB8A106FCC7E944E98C792@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52765C7FB8A106FCC7E944E98C792@BN9PR11MB5276.namprd11.prod.outlook.com>

On Fri, Oct 11, 2024 at 05:06:29AM +0000, Tian, Kevin wrote:

> > It is a bug in the implementation in the intel driver.
> > 
> > intel_iommu_domain_alloc_user() should always allocate a page table
> > that works, if you are in a guest context it must allocate a first
> > level/guest page table otherwise nested VFIO will be broken.
> 
> I don't think it's a bug. If nested is broken then VMM can fall back
> to the shadowing approach. If the VMM only supports nested
> then the only way to guarantee it is to not advertise 2nd-level
> capability on the vIOMMU.

Right, which is the bug, the alloc function isn't checking the
capabilities of the HW before going ahead to allocate a table format.

So it can choose a table format the HW doesn't advertise support
for. Whoops.

Jason
