Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319D712C475
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716560689; cv=none; b=eIJ6KhoQEbsGR0OlNC+GyDn7UjGULJDM2fcfIgm6xpD9a3Ebffzqr3zefax7LlGKUcWs6sE2jz9JBdOUF25ASpI/LdR0NH95DBTsFdxcENEncfZ4R1qT9n6sGfkFul/ZfISSZ1Ar6KGX14dNw1z2kTvYHS1HoOmk9T1fxflp84A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716560689; c=relaxed/simple;
	bh=GAKoyrn5jaPJBZhMvzIPnR163kOxc9TRWI2BEHr/EOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOiZIGmtICLNKolBkghSV8Zk/hgly6V2ufa1LgnD+uT4yFc8Fr7MRWum60sf1jN3mSLlf1CiZnV9RSTHHM/YDk53vpR4giVrzRIPF6tst+X1QiOJ30Svwc7Hpluho05243XhqNcAIpJS5FbtAQzV+HJL9VXA91hveVjdY60sGoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VykpIWF3; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VykpIWF3"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-43df751b5b8so23450921cf.0
        for <iommu@lists.linux.dev>; Fri, 24 May 2024 07:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1716560687; x=1717165487; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8hYkOeLY4QiEED8wXU9jSl5gIYmutzD/WSLBujMKTRo=;
        b=VykpIWF3y2EzBp5IiiIqWWFt7dlqO+yPEGBU0jSBN1ujxQiOSnag5mfJZdM7yftmCb
         zwlH8uVuiw+3qC1E0HLh91LW8eBd6TiY+MmEAFXmpfaraoEWL3YEx7R80B3bO7J3Kr1U
         TgFAlv53UJ9NLwLQ/H1bLKXw0QyM3y4vB30R/8k/P1t8cc2oWpGce/aQ4PQwbhSJIpol
         5ynU/LaSvHAXObSEJX61fnbPBWPbLdhfkWicrTG4t59dVMRkHOJ/fX6SV67wq/6K1MTr
         /ta6d5huHcnepG1IideWLEeENeUolbVcLiH3ILgg4veqDm4t2HMLhb3H0UkK1JALNT1w
         LFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716560687; x=1717165487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hYkOeLY4QiEED8wXU9jSl5gIYmutzD/WSLBujMKTRo=;
        b=A/c+S6nxwLV6Hog4ACUgGrcRCpnxvWnviArWtZHUQFXJum0HswNTbupTxjPn/pCDoH
         Uv9190nNXdHAIFFSGRmo9iLMkPCZq5yx4xkL+4BXYCAuXf3q+yz+8YVedpJc6B33W4Ri
         drlrfnxi8CUvTAKQfFT7kqQaL580zj/ybB22PqZaA8kXXrYVnmCpmg1E4z2IPRtTiYa1
         MtEqIjO2VFSHKqgAN7FPqMMiWFuQCikQSV4Ga1AMmTbfK13BinCUBgMKo21Sfzxwb8Yn
         JIJ42NnqqVZFg8aYGfwWujBCzKSqYeoR43d170NaHx1sOgMOPFrmrzGMLJ90tj7oYwHQ
         o/5A==
X-Forwarded-Encrypted: i=1; AJvYcCXUy6SZBqGSBMWdqayuytF/iQGrw/qlM/SSMHQPWCl4w0uo1zmjBOAz3uec1QIaNsNyCLYm7ikeDHq1gK+pfOhXKlUbJmo=
X-Gm-Message-State: AOJu0Yw3+gPXURMesfT7pOzKkLYhhz6X9R+Rdi1pT6sG0zhFc9Jj0Pj3
	a/wvnOEApwBf5YrLD1r8G7B43wx9juPtLixceGODVmc1aDAEGhxZPjoEg1uiqCs=
X-Google-Smtp-Source: AGHT+IHQjREFVeKjhgG/zBc9srfJFpq4/cK6ER06u+9Acna36n0WAlHDtLFo5xXKXDhG9YwoKONBbQ==
X-Received: by 2002:ac8:7d81:0:b0:439:d07d:e25f with SMTP id d75a77b69052e-43fafb16fa4mr46187801cf.16.1716560687135;
        Fri, 24 May 2024 07:24:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb183507asm8326431cf.56.2024.05.24.07.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 07:24:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sAVqg-001KtA-6F;
	Fri, 24 May 2024 11:24:46 -0300
Date: Fri, 24 May 2024 11:24:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 7/9] iommufd: Associate fault object with
 iommufd_hw_pgtable
Message-ID: <20240524142446.GP69273@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-8-baolu.lu@linux.intel.com>
 <BN9PR11MB5276A8E898983310B83C399E8CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <b09f96db-8451-4de9-81c5-312cffdfd4fc@linux.intel.com>
 <BN9PR11MB5276F07A130CD617777A3AAD8CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276F07A130CD617777A3AAD8CE92@BN9PR11MB5276.namprd11.prod.outlook.com>

On Mon, May 20, 2024 at 03:39:54AM +0000, Tian, Kevin wrote:
> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Monday, May 20, 2024 10:19 AM
> > 
> > On 5/15/24 4:50 PM, Tian, Kevin wrote:
> > >> From: Lu Baolu <baolu.lu@linux.intel.com>
> > >> Sent: Tuesday, April 30, 2024 10:57 PM
> > >>
> > >> @@ -308,6 +314,19 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd
> > >> *ucmd)
> > >>   		goto out_put_pt;
> > >>   	}
> > >>
> > >> +	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
> > >> +		struct iommufd_fault *fault;
> > >> +
> > >> +		fault = iommufd_get_fault(ucmd, cmd->fault_id);
> > >> +		if (IS_ERR(fault)) {
> > >> +			rc = PTR_ERR(fault);
> > >> +			goto out_hwpt;
> > >> +		}
> > >> +		hwpt->fault = fault;
> > >> +		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
> > >> +		hwpt->domain->fault_data = hwpt;
> > >> +	}
> > >
> > > this is nesting specific. why not moving it to the nested_alloc()?
> > 
> > Nesting is currently a use case for userspace I/O page faults, but this
> > design should be general enough to support other scenarios as well.
> 
> Do we allow user page table w/o nesting?
> 
> What would be a scenario in which the user doesn't manage the
> page table but still want to handle the I/O page fault? The fault
> should always be delivered to the owner managing the page table...

userspace always manages the page table, either it updates the IOPTE
directly in a nest or it calls iommufd map operations.

Ideally the driver will allow PRI on normal cases, although it will
probably never be used.

Jason
