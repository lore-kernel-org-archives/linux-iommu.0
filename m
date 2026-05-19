Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6429B23BD1B
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779195130; cv=none; b=XUeuZs3jVySav1VZYQtNTxBiuGEqx9Ew3J99fjmL80hJvYCVLpVeUg2CymmGNVeMpkcuC0y0fZML+UvXb12ShdxeFbDaLXc+y8Cx6yTH0hdmJ5/zbzm+4o3a/R4bJ18gwBfaETomG9Hio3qGM78p9eaQG/Pz78QvRoXpK6XwZfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779195130; c=relaxed/simple;
	bh=Cj+9AGLaj6N5gNCq9PN/+geG3jfXVteqrgLjuRvx6n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPpT09dCdoihZ2hnKVrseRXbNsF+fEI+hBlwZLPd97DyVfarOT3/h4pw+VN7yvgYcMh7DrrQ0g986oQr5TUxXpxfetJyjY5mxtNAvImtkyLcsciaSBFX/X/Y3AmpvJ512ICM8oqsOSkdNPnsUDPMyND3ozUR9UuFTItSuQ7mJ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=J20bYQ4v; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="J20bYQ4v"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-902deb2412fso451653485a.3
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779195127; x=1779799927; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DOCS522Pm9afH3DTI+hcdRgkcQjsqwF0dA1bA5ZkKZc=;
        b=J20bYQ4vdm3EYGte+K6UnXFfQU6Pu9InYjRhG431GcVEgObEc6vU0WrizWyNH8L6Fd
         UHyzLGF1E5eTOd74K8FGlmuOLOBw8Gl+p1YaUl+9dxXrvtKpV9+/ZRS1DAU004EGstPc
         6DbFRvnvgW77X6KNVbbYT/xa+U3mtSoogKwqws+C7UHNnZsy/59HyeK3Sh3Qese+VHyK
         wa+LBKYq3ZIu0K6M+FLFjybZKpS7hPcjtDyisRRDI9K/EO/SuCU/7zhKa53WThHbeywo
         CzGZF+oyJYZmbk7i9ysFgi3JGX92WSuLl5Nx6PvSBioAWKBySg7HqIi2ff+ypBC8z5HE
         7RmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779195127; x=1779799927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOCS522Pm9afH3DTI+hcdRgkcQjsqwF0dA1bA5ZkKZc=;
        b=QYrXK8767P6LMc0wdTNwYN2YAntGn4qaz8qiHdLs/fFYQqJDpW0mQSPr3AbwB/tnY+
         HD4MPs3oxrFfqlGca20cXVbr9YfM0NCtS5TY+SgStyPZFQQ15+NWD9aQvNVF+nFuCrlA
         tURhcOebh+PKNkq5XO4Ubgq6oedlOUzXvrUA0wdPV3RYypSAKXtzSm+PXCH/ajDKCu78
         RYyqGqQeOcnVXeNFT6QoLnm+pYKS7MxSOIY7msjikQ8wVoqtX9udLkCWab++glKzneU5
         Aqvm/KN5IT0BveKaIJsBAr0PtvsbE5Bs3llKRMstdzh5NQCh+bUr5ElpdmkvV9tlcy6h
         IBcQ==
X-Forwarded-Encrypted: i=1; AFNElJ+mCZzZEQtwApPncGTTseSEbg2C4ifyVPgX2LZTxzCIlekr2IJhpxymAGasGE+AyH6eZqUMjA==@lists.linux.dev
X-Gm-Message-State: AOJu0YynhcG7FwPcz2t3vVQVS5AROfbLE6wSOY1G5Csd4ytXRWXtqZMP
	ZPHzw/h6w0O5vxnvfTgp0WTNzbpJMa+J7Vg41spXCEvIEzhC3UjEtxhuFiz7hr7Pckw=
X-Gm-Gg: Acq92OGqj/NOsCtIWR0MtQsZUwUC5od/G7oBvBvUus4xc2iXV/BmP295H4XM1qN4hUT
	DDPANUHYh23zZS3Esccun8DNHmbglTEDIpqHUEBmqWZBQHe2eyh6dDqBEX7srbDHu+3h70oNdWR
	59FeRIuUNOpslwRn7pbSZYh4wakEsthebYI3ZbXBH7Dq25XQ9AVwX7nLajfqBc3syPPrkZD2ENf
	c5PjIqYeN/DHBclVYl/MJO8B2pEz6PQF82kmIjRTo2i0bjuFUFSH9euF8vcDiev+4C8B2BK52Bp
	+91G38B8Ol4pZX0CZkyiVqVtpsZhSNZAn0UBvp3vXSXkZ1BGv32wMyja5XmwVoZRiqQYPYrSqs+
	uYk5jd5A7CMnztpH2t6TcbqqSTDDR5J0UHN7kZBVxjET7VXGbm7uw1Aj9VQpPjvnYsWo/ZfZJ87
	7OYCwfyOtKairrf2rmpioef0f6oaucJm2lEN+tEojsz9weX3qJEebtcexygpCzqsLz1Dojk6jgi
	NX+yg==
X-Received: by 2002:a05:620a:170c:b0:910:5637:4bec with SMTP id af79cd13be357-911cd1752admr2935359485a.18.1779195127354;
        Tue, 19 May 2026 05:52:07 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910baf2236fsm1823801385a.20.2026.05.19.05.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 05:52:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPJva-0000000Eg2n-14zp;
	Tue, 19 May 2026 09:52:06 -0300
Date: Tue, 19 May 2026 09:52:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Mukesh R <mrathor@linux.microsoft.com>, hpa@zytor.com,
	robin.murphy@arm.com, robh@kernel.org, wei.liu@kernel.org,
	mhklinux@outlook.com, muislam@microsoft.com,
	namjain@linux.microsoft.com, magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com, tglx@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de
Subject: Re: [PATCH V3 09/11] x86/hyperv: Implement Hyper-V virtual IOMMU
Message-ID: <20260519125206.GY7702@ziepe.ca>
References: <20260512020259.1678627-1-mrathor@linux.microsoft.com>
 <20260512020259.1678627-10-mrathor@linux.microsoft.com>
 <20260515182322.GI7702@ziepe.ca>
 <20260518224136.0000403e@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518224136.0000403e@linux.microsoft.com>

On Mon, May 18, 2026 at 10:41:36PM -0700, Jacob Pan wrote:

> Just wondering what work is needed to support this "direct attach"? I
> felt this issue is due to trying to cram two distinct domain types
> (paging domain & direct attach) into the VFIO container model where
> only unmanaged paging domain is supported.

Xen has the same issue and you two need to come up with a uniform
solution.

VFIO container can't support it, that's out.

You should be focusing on a iommufd flow that accepts some FD
representing the VM (ie KVM FD) that can be converted by the driver
into a HWPT representing that FD's S2 translation.

> I am thinking if we were to switch to iommufd and let user(vmm) have
> direct control of HWPT, vmm will be able to selectively use a
> different domain type to handle direct attach. 

Yes

> IMHO, it is essentially the same as attaching nest parent domain
> without nested domain immediately attached. The unprivileged guest
> may attach nested domain directly with Hyper-V if nested translation
> is needed.

nest parent domain is really for supporting the viommu objects.. If
you don't have that flow you don't need to worry about that nest
parent stuff.

> From this driver POV, it will allocate a 2nd stage only domain with
> different domain ops (w/o map/unmap) for "direct attach" thus avoid this
> hack.

Yes, from a driver POV you need a unique iommu_domain allocator that
returns an iommu_domain without an ops.

It should probably work similarly to the viommu where the iommufd path
can send in a driver-specific tagged struct that can describe these
special domains.

But be mindful of the lifetime rules, whatever ID is used to describe
the VM at the hypercall boundary has to be bound into a linux FD and
become immutable. The driver has to hold that FD as long as the domain
exists.

Jason
