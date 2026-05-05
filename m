Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3D12FBDFD
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 21:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778016741; cv=none; b=hsWd67oFicohb57vjxePSFcDxqqMSjp/bz+rMEB0g1EOUhH/iBqCt5oxumOZxxUfzBeEUM9If2L5opVm5ywskmCipbZPbZ8c06LPIML4EwEiv4p3mD41YznnS2ebOGmKC2q/VCQP3glNCrbjLWBA8iQggomNvhnReOPIzVJOm5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778016741; c=relaxed/simple;
	bh=fuw/fNnStS2bmmH9Sb1UtPzfbETK2c2LelEflFxPoFk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TioCC3felOed46o3vEhEe7BAFcZvKUC5VUbwiRzFLYR+aIfokMcQhPWFvfygWp3Lrd4LVlUaOibPdcEhz6Ap5+YdPnrpmNLFtRM1WO2Ct8pISfVIMlAOFSbTHofEMGYwgEIki1u6qA/gU9L2CUBrJTg3lMKQv7KBhD1bHcDFZCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=s0pmKe+B; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="s0pmKe+B"
Received: from localhost (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id A5BB120B7168;
	Tue,  5 May 2026 14:32:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A5BB120B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778016737;
	bh=g7R5PXR3x5jKKNWg6zW1flLeHMLxjwhh/ziGStyhNPI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s0pmKe+B9C+x5WzSFp6sPUJpqhMqgH+sZDee0nTUhrfkXd3XQBm61m2+U5L6q4Ep2
	 bpO0qyCgzjgKoAUMtP/B1k0QX5l6rFArN27MV/V6xlA0a5MtwBzFVv5r4NMiYk6BeB
	 aiRhX+ZQHLTYrgdnbk8rnoMDFLlLv9pyIuS+c/kI=
Date: Tue, 5 May 2026 14:32:17 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jason Gunthorpe
 <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "skhawaja@google.com" <skhawaja@google.com>, "pasha.tatashin@soleen.com"
 <pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>, Baolu Lu
 <baolu.lu@linux.intel.com>, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH V4 02/10] iommufd: Move igroup allocation to a function
Message-ID: <20260505143217.0000704e@linux.microsoft.com>
In-Reply-To: <BL1PR11MB527178A84DEE234931CF6B268C232@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
	<20260414211412.2729-3-jacob.pan@linux.microsoft.com>
	<BL1PR11MB527178A84DEE234931CF6B268C232@BL1PR11MB5271.namprd11.prod.outlook.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Kevin,

On Thu, 16 Apr 2026 07:48:27 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan <jacob.pan@linux.microsoft.com>
> > Sent: Wednesday, April 15, 2026 5:14 AM
> > 
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > So it can be reused in the next patch which allows binding to
> > noiommu device.
> > 
> > Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>  
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 
> with a nit:
> 
> > +
> > +	/*
> > +	 * The ictx is not additionally refcounted here becase all
> > objects using
> > +	 * an igroup must put it before their destroy completes.
> > +	 */  
> 
> s/becase/because/, though it's not added by this patch
will do.

Thanks,
