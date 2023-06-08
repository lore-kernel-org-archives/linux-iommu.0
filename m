Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFBDC2DA
	for <iommu@lists.linux.dev>; Thu,  8 Jun 2023 15:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686238827; x=1717774827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=76q0pz9uYJGQjyuhbeXuJKxSn4Jgx8OqTCzaDPYghZk=;
  b=L+VGi2ei+q3D1ptZFozoZjycWeVSDkxh0M/gJsVAFbTf74dWAXLSAW0y
   D9f7rfDb4J19H86f109kuRdgnpVkliugKxYf15HUl44LWKuzWHOOS+HpC
   hf2SoqEAQurt5rCz97YDs9FO2q8CSAqIBGe/P34euWS3nXGLL+6jhCr36
   e4cjRMulBxnAZPZrlY8fU+V5zDG0I/DcBM3ssBOK3zHiHRyS35kqDg5/B
   jAAip2vtmhtTJ4AjI3kgjMuACGLCIJHvvYuFIf40h5p9jgX1nE4IeNrnP
   zYE78mJHIShSAKyUIRUqLBIgTfFvrHd7FDhD+9hD75qtRLgaSu8rZyR14
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="354830427"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="354830427"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 08:40:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="884244181"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="884244181"
Received: from araj-dh-work.jf.intel.com (HELO araj-dh-work) ([10.165.157.158])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 08:40:08 -0700
Date: Thu, 8 Jun 2023 08:38:37 -0700
From: Ashok Raj <ashok_raj@linux.intel.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>, iommu@lists.linux.dev,
	Ashok Raj <ashok.raj@intel.com>
Subject: Re: Question about reserved_regions w/ Intel IOMMU
Message-ID: <ZIH1/e2OcCuD7DEi@araj-dh-work>
References: <CAKgT0UezciLjHacOx372+v8MZkDf22D5Thn82n-07xxKy_0FTQ@mail.gmail.com>
 <CAKgT0UfMeVOz6AOqSvVvzpsedGDiXCNQrjM+4KDv7qJJ1orpsw@mail.gmail.com>
 <a1cff65b-b390-3872-25b5-dd6bbfb3524c@linux.intel.com>
 <CAKgT0UcE5bUe7ChytSyUWEkyqdwnNR1k_rcfyykPPWJ=ZzsdRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UcE5bUe7ChytSyUWEkyqdwnNR1k_rcfyykPPWJ=ZzsdRg@mail.gmail.com>

On Thu, Jun 08, 2023 at 07:33:31AM -0700, Alexander Duyck wrote:
> On Wed, Jun 7, 2023 at 8:05 PM Baolu Lu <baolu.lu@linux.intel.com> wrote:
> >
> > On 6/8/23 7:03 AM, Alexander Duyck wrote:
> > > On Wed, Jun 7, 2023 at 3:40 PM Alexander Duyck
> > > <alexander.duyck@gmail.com> wrote:
> > >>
> > >> I am running into a DMA issue that appears to be a conflict between
> > >> ACS and IOMMU. As per the documentation I can find, the IOMMU is
> > >> supposed to create reserved regions for MSI and the memory window
> > >> behind the root port. However looking at reserved_regions I am not
> > >> seeing that. I only see the reservation for the MSI.
> > >>
> > >> So for example with an enabled NIC and iommu enabled w/o passthru I am seeing:
> > >> # cat /sys/bus/pci/devices/0000\:83\:00.0/iommu_group/reserved_regions
> > >> 0x00000000fee00000 0x00000000feefffff msi
> > >>
> > >> Shouldn't there also be a memory window for the region behind the root
> > >> port to prevent any possible peer-to-peer access?
> > >
> > > Since the iommu portion of the email bounced I figured I would fix
> > > that and provide some additional info.
> > >
> > > I added some instrumentation to the kernel to dump the resources found
> > > in iova_reserve_pci_windows. From what I can tell it is finding the
> > > correct resources for the Memory and Prefetchable regions behind the
> > > root port. It seems to be calling reserve_iova which is successfully
> > > allocating an iova to reserve the region.
> > >
> > > However still no luck on why it isn't showing up in reserved_regions.
> >
> > Perhaps I can ask the opposite question, why it should show up in
> > reserve_regions? Why does the iommu subsystem block any possible peer-
> > to-peer DMA access? Isn't that a decision of the device driver.
> >
> > The iova_reserve_pci_windows() you've seen is for kernel DMA interfaces
> > which is not related to peer-to-peer accesses.
> 
> The problem is if the IOVA overlaps with the physical addresses of
> other devices that can be routed to via ACS redirect. As such if ACS
> redirect is enabled a host IOVA could be directed to another device on
> the switch instead. To prevent that we need to reserve those addresses
> to avoid address space collisions.

Any untranslated address from a device must be forwarded to the IOMMU when
ACS is enabled correct? I guess if you want true p2p, then you would need
to map so that the hpa turns into the peer address.. but its always a round
trip to IOMMU. 

> 
> From what I can tell it looks like the IOVA should be reserved, but I
> don't see it showing up anywhere in reserved_regions. What I am
> wondering is if iova_reserve_pci_windows() should be taking some steps
> so that it will appear, or if  intel_iommu_get_resv_regions() needs to
> have some code similar to iova_reserve_pci_windows() to get the ranges
> and verify they are reserved in the IOVA.
> 
