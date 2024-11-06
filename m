Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A435A13A26F
	for <iommu@lists.linux.dev>; Wed,  6 Nov 2024 19:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730920735; cv=none; b=ZDMYnA9SKWlPmrhgpINoYmxC87S7qUGP0C0DXlgGBx3EoD91vG9niuo9RfI3vPE7E6hN5ADRrCPk//0xpF4PrXkVHv/QiN+GqDcElCiISkhlGH0I+17nwloIzNqww1h8ZTOn1AYF9VagO1mEuE/yfiAHUPTasznM4JQtdoEwQdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730920735; c=relaxed/simple;
	bh=Ou+l3fSVssEMDncUOhgrcUyoeAk2ugDKrrGAONa/AiE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ml19wg2rxOE7Rdk6GiXbwxrFL3qYc+Dza1/m0WWT0if0n5V+fyHu+lolPs0jK45GUgknCTDiNbYpWuJgufM07ssRgqlbXEh4MDcXFuIZR8w8Wt0l3gtOLJCXpvyYLkDgUxBoE1l3MyD5zfGngOOrLgzDN0U1FX2J4cDmz7YWrHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mTE9yHU5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mTE9yHU5"
Received: from DESKTOP-0403QTC. (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0FF42212C7E0;
	Wed,  6 Nov 2024 11:18:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0FF42212C7E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1730920733;
	bh=rNzyWYfJCQD0LlT8+3XSt1D8NFOZPMLR98XqPQWHzu4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
	b=mTE9yHU5q4Ruwye8M/cyRhNjma7hAI6z5ESzssq2CTARZW97XNwavPqMmywM0Rgud
	 Nbvp81iJ4pfllV1MO9CVwdwC42QkkN+kMssGEqhfXm/IQgZJgvTj+hOhjowpV/qTGe
	 +9qvARFfnHla6Dv3nAFyM8gKT0y2At3zUJN2BP/I=
Date: Wed, 6 Nov 2024 11:18:50 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Gowans, James" <jgowans@amazon.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "jinankjain@linux.microsoft.com"
 <jinankjain@linux.microsoft.com>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "rppt@kernel.org" <rppt@kernel.org>, "kw@linux.com"
 <kw@linux.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "madvenka@linux.microsoft.com" <madvenka@linux.microsoft.com>,
 "anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "nh-open-source@amazon.com"
 <nh-open-source@amazon.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
 "Saenz Julienne, Nicolas" <nsaenz@amazon.es>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "ssengar@linux.microsoft.com"
 <ssengar@linux.microsoft.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "will@kernel.org" <will@kernel.org>, "Graf (AWS), Alexander"
 <graf@amazon.de>, "steven.sistare@oracle.com" <steven.sistare@oracle.com>,
 jacob.pan@linux.microsoft.com, "zhangyu1@microsoft.com"
 <zhangyu1@microsoft.com>
Subject: Re: [RFC PATCH 05/13] iommufd: Serialise persisted iommufds and
 ioas
Message-ID: <20241106111850.69904346@DESKTOP-0403QTC.>
In-Reply-To: <20241104130011.GD35848@ziepe.ca>
References: <20240916113102.710522-1-jgowans@amazon.com>
	<20240916113102.710522-6-jgowans@amazon.com>
	<20241016152047.2a604f08@DESKTOP-0403QTC.>
	<20241028090311.54bc537f@DESKTOP-0403QTC.>
	<1f50020d9bd74ab8315cec473d3e6285d0fc8259.camel@amazon.com>
	<20241104130011.GD35848@ziepe.ca>
Reply-To: jacob.pan@linux.microsoft.com
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jason,

On Mon, 4 Nov 2024 09:00:11 -0400
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Sat, Nov 02, 2024 at 10:22:54AM +0000, Gowans, James wrote:
> 
> > Yes, I think the guidance was to bind a device to iommufd in noiommu
> > mode. It does seem a bit weird to use iommufd with noiommu, but we
> > agreed it's the best/simplest way to get the functionality.   
> 
> noiommu should still have an ioas and still have kernel managed page
> pinning.
> 
> My remark to bring it to iommufd was to also make it a fully
> architected feature and stop relying on mprotect and /proc/ tricks.
> 
Just to clarify my tentative understanding with more details(please
correct):

1. create an iommufd access object for noiommu device when
binding to an iommufd ctx.

2. all user memory used by the device under noiommu mode should be
pinned by iommufd, i.e. iommufd_access_pin_pages().
I guess you meant stop doing mlock instead of mprotect trick? I think
openHCL is using /dev/mem trick.

3. ioas can be attched to the noiommu iommufd_access object, similar to
emulated device, mdev.

What kind/source of memory should be supported here?
e.g. device meory regions exposed by PCI BARs.


> > Then as you suggest below the IOMMUFD_OBJ_DEVICE would be serialised
> > too in some way, probably by iommufd telling the PCI layer that this
> > device must be persistent and hence not to re-probe it on kexec.  
> 
> Presumably VFIO would be doing some/most of this part since it is the
> driver that will be binding?
> 
Yes, it is the user mode driver that initiates the binding. I was
thinking since the granularity for persistency is per iommufd ctx, the
VFIO device flag to mark keep_alive can come from iommufd ctx.

> > It's all a bit hand wavy at the moment, but something along those
> > lines probably makes sense. I need to work on rev2 of this RFC as
> > per Jason's feedback in the other thread. Rev2 will make the
> > restore path more userspace driven, with fresh iommufd and pgtables
> > objects being created and then atomically swapped over too. I'll
> > also get the PCI layer involved with rev2. Once that's out (it'll
> > be a few weeks as I'm on leave) then let's take a look at how the
> > noiommu device persistence case would fit in.  
> 
> In a certain sense it would be nice to see the noiommu flow as it
> breaks apart the problem into the first dependency:
> 
>  How to get the device handed across the kexec and safely land back in
>  VFIO, and only VFIO's hands.
> 
> Preserving the iommu HW configuration is an incremental step built on
> that base line.
Makes sense, I need to catch up on the KHO series and hook up noiommu
at the first step.

> Also, FWIW, this needs to follow good open source practices - we need
> an open userspace for the feature and the kernel stuff should be
> merged in a logical order.
> 
Yes, we will have matching userspace in openHCL
https://github.com/microsoft/openvmm

Thanks,

Jacob
