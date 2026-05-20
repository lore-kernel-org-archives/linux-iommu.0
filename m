Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCEE3D88FC
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296898; cv=none; b=f/gZbkQrRELJ2V4O0YCcwrFRWrz0wlvS9/4WgaGWjYAH9ZIzb0Hwi47f1X8Y16KifaY2k8jK78IHkxzJFUKTDWmWB1GuOpBaKNQoK4ikweyvYPQophfsQH+KcWNXPTDX6S+QCNvdQtpOxxC3Y/9SkDbsMbctI4v9aSzimrz6Ak0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296898; c=relaxed/simple;
	bh=gxWuj3chdIni4H4oKVCeMD0nWw+Lg3ynzheyT+6sDxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IyQBNNqmGIIKcyHoVcQm3eBOAxExiAzpztGbT6Rkcf4rf3CIZeQsnirUJ1xRZJ57es+OBS7PjdugLdolxlhnFl04cyHtNpITukrgpprswzQF2H555S1PDb9NoRxYwxFe2R1p2tcj1K2K6oTJD+H5fmqroTrHPJz+wnm1dHWJDOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SddCBwjc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SddCBwjc"
Received: from localhost (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0DC3820B7167;
	Wed, 20 May 2026 10:08:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0DC3820B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779296889;
	bh=Sd8tnndFDu8/yhKIGq60a4VOaiM12H3FycKKGrg7VTU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SddCBwjcrkSYPdDw4iPncnZvy8bqRQ5+Gij/DvADBGp2z5m1KvtcX+mI76WmvCjmr
	 L+cuzJp53W1XuuJeLQDc9pZYSYHCIHfNtP3RjySRZ1aHwtvSsQ0RRll/XNLD91L9Oh
	 kKVRDuL8H9Eqd3lHGF/4oUz47M4vh7j5Jww6qJ0Y=
Date: Wed, 20 May 2026 10:08:13 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Alex Williamson <alex@shazbot.org>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
 skhawaja@google.com, pasha.tatashin@soleen.com, Will Deacon
 <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v5 6/9] vfio/group: Add VFIO_CDEV_NOIOMMU Kconfig and
 tolerate NULL group
Message-ID: <20260520100813.00000471@linux.microsoft.com>
In-Reply-To: <20260519214516.20864d3e@shazbot.org>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
	<20260511184116.3687392-7-jacob.pan@linux.microsoft.com>
	<20260519214516.20864d3e@shazbot.org>
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

Hi Alex,

On Tue, 19 May 2026 21:45:16 -0600
Alex Williamson <alex@shazbot.org> wrote:

> On Mon, 11 May 2026 11:41:11 -0700
> Jacob Pan <jacob.pan@linux.microsoft.com> wrote:
> 
> > Add a new CONFIG_VFIO_CDEV_NOIOMMU option, independent of
> > CONFIG_VFIO_GROUP, to support noiommu mode via the cdev interface.
> > 
> > Since CONFIG_VFIO_GROUP can be enabled while
> > CONFIG_VFIO_GROUP_NOIOMMU is not, guard the noiommu group
> > allocation in vfio_group_find_or_alloc() with
> > IS_ENABLED(CONFIG_VFIO_GROUP_NOIOMMU) to prevent creating spurious
> > /dev/vfio/noiommu-N group files when only cdev noiommu is
> > configured.
> > 
> > For cdev noiommu devices that have no group, let
> > vfio_device_set_group() return success with a NULL group pointer
> > and add null guards in group functions that may be called during
> > device lifecycle. These guards are contained within group.c and are
> > dead code for IOMMU-enabled devices where device->group is always
> > non-NULL.
> > 
> > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > ---
> >  drivers/vfio/Kconfig | 17 +++++++++++++++++
> >  drivers/vfio/group.c | 31 +++++++++++++++++++++++++++++--
> >  2 files changed, 46 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> > index 39939be2908e..b1b1633412a9 100644
> > --- a/drivers/vfio/Kconfig
> > +++ b/drivers/vfio/Kconfig
> > @@ -75,6 +75,23 @@ config VFIO_GROUP_NOIOMMU
> >  
> >  	  If you don't know what to do here, say N.
> >  
> > +config VFIO_CDEV_NOIOMMU
> > +	bool "VFIO cdev No-IOMMU support"
> > +	depends on VFIO_DEVICE_CDEV
> > +	select IOMMUFD_NOIOMMU  
> 
> AIUI, config would warn but allow this to select IOMMUFD_NOIOMMU
> even if the dependency on !GENERIC_ATOMIC64 in the Kconfig is unmet.
> This should include that dependency as well.  Thanks,
> 
Yes, will add
       depends on !GENERIC_ATOMIC64
