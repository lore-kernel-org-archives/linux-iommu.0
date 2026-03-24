Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271CC3A3E79
	for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 19:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379606; cv=none; b=DMPiChZ50O0U0pzM767Qu+AjrxFO3GwMW2Vv6nST3565/edKwek5DCxyF5e92we+0KknGqJz+OFyK+EBQohdZVje2Go/O4MrYPTu2dn+BKYj6yASd/t8rhGPrLVHFEZqCkd18c364JFHJqkasIHnkG3bU7fmZ2IS1a9Cgi/TwVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379606; c=relaxed/simple;
	bh=KfiJUxCI0cz9DUBqec4VI4d3OiwWjiKvThaNI6AECC4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lOmL+B4mIPsWAZ9gaMDtkLePVAW9Db41fewYkZ6I6oxH03ERS0Idr4wbGBbp9h1AAtPYdYu6TlNOstri1wHARtMOzr+gBIDWRX503+qrdcWvSLK7sZyKh2vgjoQ6ZKxDyF3CrPQnCSp/FR/mYvNhv0d+drRBiEmXecJLsYPWto4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZQ30H48w; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZQ30H48w"
Received: from localhost (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 29AD020B710C;
	Tue, 24 Mar 2026 12:13:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 29AD020B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774379603;
	bh=rsJElF3XXsc54m38bggJLggm3FV/QNTeRq/FySScniI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZQ30H48wyjH8tWAWcUNr9TghLgB8cBJNYp63RM3bL7tnQZh5SkYp9HryF8eOmx97I
	 D0QiPIauGWAl5y8HbjlsoPHYc9Nt69AMGOrkJa0WuX7/bEOlqwOssbdcl5gJZ0rJ6v
	 hDGHks5gQjJwrYu1tbx7ghkHdHQEW6cTu5ivt0V0=
Date: Tue, 24 Mar 2026 12:13:21 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, skhawaja@google.com, pasha.tatashin@soleen.com, Will
 Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V2 03/11] iommufd: Allow binding to a noiommu device
Message-ID: <20260324121321.000027c5@linux.microsoft.com>
In-Reply-To: <ab-8R5Vww5Fs2Zp8@google.com>
References: <20260312155637.376854-1-jacob.pan@linux.microsoft.com>
	<20260312155637.376854-4-jacob.pan@linux.microsoft.com>
	<ab-8R5Vww5Fs2Zp8@google.com>
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

Hi Mostafa,

On Sun, 22 Mar 2026 09:54:15 +0000
Mostafa Saleh <smostafa@google.com> wrote:

> From: Mostafa Saleh <smostafa@google.com>
> To: Jacob Pan <jacob.pan@linux.microsoft.com>
> Cc: linux-kernel@vger.kernel.org,  "iommu@lists.linux.dev"
> <iommu@lists.linux.dev>,  Jason Gunthorpe <jgg@nvidia.com>,  Alex
> Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,  David
> Matlack <dmatlack@google.com>,  Robin Murphy <robin.murphy@arm.com>,
> Nicolin Chen <nicolinc@nvidia.com>,  "Tian, Kevin"
> <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
> skhawaja@google.com, pasha.tatashin@soleen.com,  Will Deacon
> <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com> Subject: Re:
> [PATCH V2 03/11] iommufd: Allow binding to a noiommu device Date:
> Sun, 22 Mar 2026 09:54:15 +0000
> 
> On Thu, Mar 12, 2026 at 08:56:29AM -0700, Jacob Pan wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > Allow iommufd to bind devices without an IOMMU (noiommu mode) by
> > creating a dummy IOMMU group for such devices and skipping hwpt
> > operations.
> > 
> > This enables noiommu devices to operate through the same iommufd
> > API as IOMMU- capable devices.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > ---
> >  drivers/iommu/iommufd/device.c | 113
> > ++++++++++++++++++++++----------- 1 file changed, 76 insertions(+),
> > 37 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommufd/device.c
> > b/drivers/iommu/iommufd/device.c index 54d73016468f..c38d3efa3d6f
> > 100644 --- a/drivers/iommu/iommufd/device.c
> > +++ b/drivers/iommu/iommufd/device.c
> > @@ -23,6 +23,11 @@ struct iommufd_attach {
> >  	struct xarray device_array;
> >  };
> >  
> > +static bool is_vfio_noiommu(struct iommufd_device *idev)
> > +{
> > +	return !device_iommu_mapped(idev->dev) ||
> > !idev->dev->iommu;  
> 
> Do this need to check for CONFIG_VFIO_NOIOMMU and maybe the module
> param enable_unsafe_noiommu_mode similar to the legacy implemenation?
> 
Checking for CONFIG_VFIO_NOIOMMU is not needed since all the conditions
are not restricted by CONFIG_VFIO_NOIOMMU. I felt it is cleaner this
way by not tying iommufd private code with vfio.

I guess we could do something like below but not necessary IMHO.
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -23,11 +23,6 @@ struct iommufd_attach {
        struct xarray device_array;
 };
 
-static bool is_vfio_noiommu(struct iommufd_device *idev)
-{
-       return !device_iommu_mapped(idev->dev) || !idev->dev->iommu;
-}
-
 static void iommufd_group_release(struct kref *kref)
 {
        struct iommufd_group *igroup =
diff --git a/drivers/iommu/iommufd/iommufd_private.h
b/drivers/iommu/iommufd/iommufd_private.h index
3302c6a1f99e..cba5550e3f2b 100644 ---
a/drivers/iommu/iommufd/iommufd_private.h +++
b/drivers/iommu/iommufd/iommufd_private.h @@ -711,6 +711,18 @@
iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id) struct
iommufd_vdevice, obj); }
 
+#ifdef CONFIG_VFIO_NOIOMMU
+static inline bool is_vfio_noiommu(struct iommufd_device *idev)
+{
+       return !device_iommu_mapped(idev->dev) || !idev->dev->iommu;
+}
+#else
+static inline bool is_vfio_noiommu(struct iommufd_device *idev)
+{
+       return false;
+}
+#endif
+

