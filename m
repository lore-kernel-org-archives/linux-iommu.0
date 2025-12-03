Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46612E2840
	for <iommu@lists.linux.dev>; Wed,  3 Dec 2025 22:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764800920; cv=none; b=SOWwdKC537oJbJAJKPhqSUN1s1xgTsFdrq6wI9JuJSueRE1LzbxKp9Nu9NLp4z7HFFYPo2Rd2ce+b1F30pIHeJu7P4hVXyFVz9257Cu6N3wB5defpES91uUknW45t1lHiZxCOzn/u8OU1UtYbG8cDqf+uyyLxLTcsjQuQrPCtTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764800920; c=relaxed/simple;
	bh=Xjsx+tx4LdYFR6x2XAELkIhrHwC0m2sO4ynVzdW06qI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y8qRchlPxJFN1iZIYZjS+6wkpttHCi+cvCTqREcRiNZpFUR5BN/sfj6RpIxvxQZWrW2oYsl8+VnYFN01f6+H4XY2B0kObcIoDG39NqaDBItQkOwRlF/CEFLD4HEYEaTxkJQ8m0JztIT+VpXgZuhV9yIZWZcAuVmiLZv5pI1e+Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=E8eIifG4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="E8eIifG4"
Received: from localhost (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5ED4E2120E87;
	Wed,  3 Dec 2025 14:28:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5ED4E2120E87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764800917;
	bh=GeiyuPq9Q0SV4v0fSzhCHsGuIA+jsyPfYs0jyZ9T8SI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E8eIifG4/Vhr4RizS45mxKHLotS8j6xUZvfTDxA8VMU7t+NOA1T1ORBZQ7XTFxIj6
	 xqBIcLGxxQM/fwAZZH48Rv0yeFieQMNaHw10++flwt8KBiZtDWdT+P2XNOJxm2CXTp
	 rMUr7jyEOVWEsR6ERGXuJNAbCEM/PVi38wRO5kpw=
Date: Wed, 3 Dec 2025 14:28:35 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex.williamson@redhat.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, skhawaja@google.com, pasha.tatashin@soleen.com, Zhang
 Yu <zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
 <jean-philippe@linaro.org>, David Matlack <dmatlack@google.com>, Alex
 Williamson <alex@shazbot.org>
Subject: Re: [RFC 2/8] iommu: Add a helper to check if any iommu device is
 registered
Message-ID: <20251203142835.00002a0c@linux.microsoft.com>
In-Reply-To: <64a01f42-9231-481a-b8f7-5c5dfed4b095@linux.intel.com>
References: <20251201173012.18371-1-jacob.pan@linux.microsoft.com>
	<20251201173012.18371-3-jacob.pan@linux.microsoft.com>
	<f88707d4-bd04-4e9b-8d4b-ccb679d70dae@linux.intel.com>
	<20251202160635.0000433e@linux.microsoft.com>
	<64a01f42-9231-481a-b8f7-5c5dfed4b095@linux.intel.com>
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

Hi Baolu,

On Wed, 3 Dec 2025 11:31:27 +0800
Baolu Lu <baolu.lu@linux.intel.com> wrote:

> On 12/3/25 08:06, Jacob Pan wrote:
> > Hi Baolu,
> > 
> > On Tue, 2 Dec 2025 10:17:34 +0800
> > Baolu Lu <baolu.lu@linux.intel.com> wrote:
> >   
> >> Hi Jacob,
> >>
> >> On 12/2/25 01:30, Jacob Pan wrote:  
> >>> The dummy IOMMU driver for No-IOMMU mode should only be active
> >>> when no real IOMMU devices are present in the system. Introduce a
> >>> helper to check this condition, ensuring that the dummy driver
> >>> does not interfere when hardware-backed IOMMU support is
> >>> available.
> >>>
> >>> Signed-off-by: Jacob Pan<jacob.pan@linux.microsoft.com>
> >>> ---
> >>>    drivers/iommu/iommu.c | 10 ++++++++++
> >>>    include/linux/iommu.h |  1 +
> >>>    2 files changed, 11 insertions(+)
> >>>
> >>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> >>> index 0df914a04064..958f612bf176 100644
> >>> --- a/drivers/iommu/iommu.c
> >>> +++ b/drivers/iommu/iommu.c
> >>> @@ -2895,6 +2895,16 @@ static const struct iommu_device
> >>> *iommu_from_fwnode(const struct fwnode_handle * return ret;
> >>>    }
> >>>    
> >>> +bool iommu_is_registered(void)
> >>> +{
> >>> +	bool registered;
> >>> +
> >>> +	spin_lock(&iommu_device_lock);
> >>> +	registered = !list_empty(&iommu_device_list);
> >>> +	spin_unlock(&iommu_device_lock);
> >>> +	return registered;
> >>> +}  
> >>
> >> IOMMU devices might be added by calling iommu_device_register() at
> >> any time. Therefore, an empty iommu_device_list does not
> >> necessarily mean that "no real IOMMU devices are present in the
> >> system."  
> > Good point. My intention was that the noiommu dummy driver should
> > register only after all hardware IOMMU drivers have completed
> > registration during boot. Any subsequent registration attempt, such
> > as a hot-added IOMMU, should fail if noiommu mode is already active.
> > 
> > We could enforce this by introducing a global flag that prevents any
> > iommu_device from being registered after the noiommu driver has been
> > initialized.
> > 
> > However, as you pointed out there seems to be no standard ordering
> > for iommu device registration across platforms. e.g. VT-d hooks up
> > with x86_init, smmuv3 does that in platform driver probe. This
> > patchset puts dummy driver under early_initcall which is after both
> > but not a guarantee for all platforms. Any suggestions?  
> 
> Could we add a helper call inside the IOMMU detection path (e.g.,
> within pci_iommu_alloc()) to set a flag, such as
> platform_iommu_present, after successful hardware detection?
> 
> void __init pci_iommu_alloc(void)
> {
>          if (xen_pv_domain()) {
>                  pci_xen_swiotlb_init();
>                  return;
>          }
>          pci_swiotlb_detect();
>          gart_iommu_hole_init();
>          amd_iommu_detect();
>          detect_intel_iommu();
>          swiotlb_init(x86_swiotlb_enable, x86_swiotlb_flags);
> }
I think this would only work for x86.

