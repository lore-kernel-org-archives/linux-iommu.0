Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784622D2488
	for <iommu@lists.linux.dev>; Wed, 27 May 2026 22:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779921281; cv=none; b=rYbtvdLNnG5rHi8NUIyFjpqmUez3jpIBntJYKCBjRb8mXk7iGFvVqH2Rmsql19PYjMpJQw/unCrYxIHVI1vF01s3Cz+o9rnoY24hrhTP9vdfHexIBostuq0EN1CQq/cJew/tTf23+nSn57iA/ZVO2HUG5wChpKEBHZMceOtsLrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779921281; c=relaxed/simple;
	bh=I7sUU0CrvDHVShsHZ2ZUGiCnZ904P37469uqXo2Ssuw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F+Uf+wqxsAeRD24qaZsHIx1d7qXjzR7n+mOBa0MAGGO97OlBddqNL2XFngOiE2qLh8yqFeBvrwalXP5i/dOcJiUIVXWoaTZ+8JTA7C+MYtXJ6olA4TXQEv6nf/b69ScxzC7dn8+g+ECArVbjvtLATiOOXcTGkmIiqgjb1MmHxtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=H9HbnA42; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="H9HbnA42"
Received: from localhost (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id B985620B7167;
	Wed, 27 May 2026 15:34:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B985620B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779921269;
	bh=EGNzJh9AuLyEweCtmpQGDEojek1qc2oN5vhszzwvK9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H9HbnA42fbhcMHyWVyfs+A/8Tn5On4vP0Axro3LeP4TfFtjdOAOeSjD/oWjuHoFDg
	 85hQ2P45mPhqexvZ4oAy+tJYMhFfR90VnW1SINeWggehfi6CgvzUW8XTNGDpZvUFDN
	 G1gyh60vOeQssXCrPwxSBuzEJdTI4FhxHI2T3PI8=
Date: Wed, 27 May 2026 15:34:38 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Alex Williamson <alex@shazbot.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Baolu Lu
 <baolu.lu@linux.intel.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
 "skhawaja@google.com" <skhawaja@google.com>, "pasha.tatashin@soleen.com"
 <pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v6 0/7] iommufd: Enable noiommu mode for cdev
Message-ID: <20260527153438.0000377a@linux.microsoft.com>
In-Reply-To: <20260526115709.5344f00f@shazbot.org>
References: <20260521221155.1375144-1-jacob.pan@linux.microsoft.com>
	<BL1PR11MB52717A74E37BDED067EA45018C0A2@BL1PR11MB5271.namprd11.prod.outlook.com>
	<20260526083237.00006a6c@linux.microsoft.com>
	<20260526115709.5344f00f@shazbot.org>
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

On Tue, 26 May 2026 11:57:09 -0600
Alex Williamson <alex@shazbot.org> wrote:

> On Tue, 26 May 2026 08:32:37 -0700
> Jacob Pan <jacob.pan@linux.microsoft.com> wrote:
> 
> > Hi Kevin,
> > 
> > On Mon, 25 May 2026 08:30:12 +0000
> > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> >   
> > > Could you address the findings from Sashiko?
> > > 
> > > https://sashiko.dev/#/patchset/20260521221155.1375144-1-jacob.pan%40linux.microsoft.com
> > >     
> > I have go over my Sashiko review setup, but there are lots of
> > false positives, like this one below we already discussed in earlier
> > version. Is there a specific concern?
> > 
> > e.g.  
> > > +static bool iommufd_device_is_noiommu(struct iommufd_device
> > > *idev) +{
> > > +	return IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) &&
> > > !idev->dev->iommu; +}    
> > Does dynamically evaluating dev->iommu here allow the noiommu state
> > to flip during the device's lifetime?  
> 
> Yes, that one is at best a theoretical issue, but the next two NULL
> pointer dereference if user passes noiommu device fd through an
> unexpected iommufd interface appear quite real.
> 
> We're also still struggling with the Kconfig in patch 5, this Sashiko
> comment is valid:
> 
> >> @@ -62,7 +61,10 @@ endif
> >>  
> >>  config VFIO_NOIOMMU
> >>  	bool "VFIO No-IOMMU support"
> >> -	depends on VFIO_GROUP
> >> +	depends on VFIO_GROUP || VFIO_DEVICE_CDEV
> >> +	depends on !VFIO_GROUP || VFIO_CONTAINER ||
> >> IOMMUFD_VFIO_CONTAINER
> >> +	depends on !VFIO_DEVICE_CDEV || !GENERIC_ATOMIC64  
> >
> > Does this disable VFIO_NOIOMMU completely for legacy group users on
> > architectures using generic atomic64 implementations?
> >
> > On architectures like 32-bit ARM or x86, !GENERIC_ATOMIC64 evaluates
> > to false.  If a distribution enables VFIO_DEVICE_CDEV, this
> > dependency resolves to false, silently breaking backwards
> > compatibility and depriving legacy group-based users of noiommu
> > support.  
> 
> That's true, the question is do we care (I'd prefer to) and if so,
> should we block the relevant interfaces from working though iommufd
> rather than disallowing the Kconfig option.
> 
Yes, I think we should preserve the legacy VFIO_GROUP/VFIO_CONTAINER
noiommu path and only disable the IOMMUFD/cdev noiommu support on
GENERIC_ATOMIC64 platforms.
How about:
diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index d3d8fef2855c..b9d6e1c22aed 100644
--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@ -61,10 +61,9 @@ endif
 
 config VFIO_NOIOMMU
        bool "VFIO No-IOMMU support"
-       depends on VFIO_GROUP || VFIO_DEVICE_CDEV
+       depends on VFIO_GROUP || (VFIO_DEVICE_CDEV && !GENERIC_ATOMIC64)
        depends on !VFIO_GROUP || VFIO_CONTAINER || IOMMUFD_VFIO_CONTAINER
-       depends on !VFIO_DEVICE_CDEV || !GENERIC_ATOMIC64
-       select IOMMUFD_NOIOMMU if VFIO_DEVICE_CDEV
+       select IOMMUFD_NOIOMMU if VFIO_DEVICE_CDEV && !GENERIC_ATOMIC64

With this, VFIO_NOIOMMU remains selectable for legacy group/container users
on GENERIC_ATOMIC64 architectures, e.g. on ARM I can have
CONFIG_VFIO_DEVICE_CDEV=y
CONFIG_VFIO_GROUP=y
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=y
CONFIG_VFIO_NOIOMMU=y
CONFIG_GENERIC_ATOMIC64=y

Also, gate this on iommufd:
 static int vfio_device_set_noiommu_and_name(struct vfio_device *device, enum vfio_group_type type)
 {
-       if (IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV) && vfio_noiommu &&
+       if (IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) && vfio_noiommu &&

> The next issue regarding classifying emulated IOMMU devices as
> no-iommu also appears valid, mdev devices like kvmgt for example.
> 
I will fix this by adding vfio_group_type check.
-static int vfio_device_set_noiommu_and_name(struct vfio_device *device)
+static int vfio_device_set_noiommu_and_name(struct vfio_device *device, enum vfio_group_type type)
 {
-       if (IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV) && vfio_noiommu && !device->dev->iommu) {
+       if (IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV) && vfio_noiommu &&
+           !device->dev->iommu && type == VFIO_IOMMU) {

> The next issue raises a valid concern whether the dev_warn() should be
> a dev_warn_once().
> 
I think dev_warn() is appropriate here, matching the existing group
path. The warning is per device per path. Using dev_warn_once() would
suppress warnings for later devices at the same callsite, which would
hide which devices were exposed through the unsafe noiommu path.
 
For example, with both group and cdev enabled today we get:
 
vfio-pci 0000:01:00.0: Adding kernel taint for vfio-noiommu group on
device
vfio-pci 0000:01:00.0: Adding kernel taint for vfio-noiommu cdev
on device

> The sysfs naming comment is invalid, we intentionally name noiommu
> devices uniquely to force userspace opt-in.
> 
> In patch 6, adding dead code is a valid comment, the unchecked
> asprintf does seem to be an outlier in selftest code, the unmap
> comment may be a false positive, as is the hugepage size, but the
> masked return comments could arguably be skips or asserts.  There are
> potentially a couple remaining nits and style issues noted.
> 
yeah, I will fix the test code, bsed on David's feedback also.

> Overall, more signal than noise afaict.  Thanks,
> 
> Alex

