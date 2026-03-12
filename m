Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2495738D015;
	Thu, 12 Mar 2026 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773333226; cv=none; b=V+41QnEQoNgvGW9H39nuQb+5XbyzqD8/lAJ1iNe5mYZwXtif5RFJpFEyiIB4+I8PUxEMAhUcddCajWZ2VDQjosKiwdre/mb/KMN+LjmotUIIG6GLTy8yjXA1go/ZaT2gZNUqqpmKfaHAz5rpSlPjnSCzNwGvhFzBtpDzetI//4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773333226; c=relaxed/simple;
	bh=VWx/GkNL5qY83k/fHQxD0qBcYVCLhi3H3CO//Lkw7NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bdjatr/RWjt5ImU+pyFSnkaAdvEzu3Ea4bNV73wx2iZjCL203EFn4gPqWumai4Ku+nfvDlN9lOn4dzrgkOVQilX9OGTa1dyQkUtPONT/mHcEJ7PhlVmE5Bk2Sx0elC2T9DaV/IkmbpteaNDkfiEoi6cE/h4syZuqkcEnMy9Jue8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=APS+fFBI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="APS+fFBI"
Received: from localhost (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 28BE420B710C;
	Thu, 12 Mar 2026 09:33:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 28BE420B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773333224;
	bh=gFyhd1inkRGvHCHTJXBXEkAolUHlzFV8VtgF5KKhDx4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=APS+fFBIZ3aOpUUohO6ukWPlf2YktCsH5JtbKweAAf29ZpB/5tpelUyw68FRidGte
	 9VwhPQ01ZQ+CqnwiuUYUaeQecen4pE+v7HnSCYpKWVQObG6fh/CNZOJ4u1tCmlK+3X
	 nw/Pb///xqzVCAvfsICSwzsXPpB+OSrWp2xkrPG8=
Date: Thu, 12 Mar 2026 09:33:45 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Alex Williamson
 <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, David Matlack
 <dmatlack@google.com>, Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>, Baolu Lu
 <baolu.lu@linux.intel.com>, oe-kbuild-all@lists.linux.dev,
 skhawaja@google.com, pasha.tatashin@soleen.com, Jean Philippe-Brucker
 <jean-philippe@linaro.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 08/11] vfio: Enable cdev noiommu mode under iommufd
Message-ID: <20260312093345.00007f60@linux.microsoft.com>
In-Reply-To: <20260305233827.GA1651202@nvidia.com>
References: <20260227175247.26103-9-jacob.pan@linux.microsoft.com>
	<202602280855.WxyIHCy5-lkp@intel.com>
	<20260228003540.GN5933@nvidia.com>
	<20260305152614.00001a0f@linux.microsoft.com>
	<20260305233827.GA1651202@nvidia.com>
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

Hi Jason,

On Thu, 5 Mar 2026 19:38:27 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Mar 05, 2026 at 03:26:14PM -0800, Jacob Pan wrote:
> > Hi Jason,
> > 
> > On Fri, 27 Feb 2026 20:35:40 -0400
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > On Sat, Feb 28, 2026 at 08:18:41AM +0800, kernel test robot
> > > wrote:  
> > > > Kconfig warnings: (for reference only)
> > > >    WARNING: unmet direct dependencies detected for
> > > > IOMMU_PT_AMDV1 Depends on [n]: GENERIC_PT [=y] && IOMMU_PT [=y]
> > > > && !GENERIC_ATOMIC64 [=y] Selected by [y]:
> > > >    - VFIO_NOIOMMU [=y] && VFIO [=y] && VFIO_GROUP [=y]    
> > > 
> > > Some kconfig stuff is missing, the iommufd IOMMU would only work
> > > with GENERIC_ATOMIC64  
> > I don't quite understand this dependency on GENERIC_ATOMIC64, or you
> > mean the opposite? since we currently have:  
> 
> Oh, right the inverse.
> 
> > config IOMMU_PT_AMDV1
> > 	tristate "IOMMU page table for 64-bit AMD IOMMU v1"
> > 	depends on !GENERIC_ATOMIC64 # for cmpxchg64
> > 
> > And I already have noiommu depends on AMDV1 for mock page tables.  
> 
> I think it is kconfig not being really transitive with select
> dependencies. So things like !GENERIC_ATOMIC64 have to be in the
> parent that uses select too.
> 
> You could also possibly use depends to avoid this, IIRC.
I have tried to use "depends on" instead of select but it made
VFIO_NOIOMMU impossible to enable if COMPILE_TEST is not set. I think
it is because:
menuconfig GENERIC_PT                                  
        bool "Generic Radix Page Table" if COMPILE_TEST

> > Anyway, this particular build issue can be fixed by adding
> > IOMMU_SUPPORT. i.e.  
> 
> That feels indirect, but maybe it is needed too..
Yeah, it does feel a bit counterintuitive that noiommu depends on IOMMU
support, but as noiommu mode is made to behave increasingly like full
IOMMU support, this may be unavoidable.

I just sent out v2.

Thanks,

Jacob
