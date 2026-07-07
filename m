Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480A13314DE
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 18:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449895; cv=none; b=dHkQIlkejroXnZ+DFK0cxDxWoUoQdDVY4Qt+uJ8kn0K7GajltugQJTyj+6GlRdF1q1t1FmAz6MFQhh6D7PkntgVhpVOyl9X3tslRk6eGUtLxWBT18B1Ty9C7Iji4wBRh/LPcVyBIh4cFP3+k/Fhw6PHrIT9rp3ZS6/XPhTZ7SUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449895; c=relaxed/simple;
	bh=CkVZ/0XPE+bIVKyCdwPpgl2tMcHUC1i7vOB1gYSHBPg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uBEXJdTogm4ArmfvNCpwZnSeFSIoTZM1dWy93RvziTioflpUeSkjHYgWYwOKxl4NGAWMQLbWUPYb/EOGc3wmESiUTzbRP2t2Gr6tTn542ibB+mwDWrPKom3W/oWUBlZXcegib/T2oHCVP05YjSO2UuNpEvhx8udQs2RHUfLzAvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=drDLup0h; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="drDLup0h"
Received: from localhost (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id BD82D20B7166;
	Tue,  7 Jul 2026 11:44:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BD82D20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783449889;
	bh=hYsF9fUYRzHOqW4P/ixXAA5wqkAncxqN68ERJ1eOWG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=drDLup0hnmZBXr1UOc6AUizKOaxigcI5uDtg+RemsYZxnUIZaT8T0kbA7KX/FMp/i
	 TvAT2cRAmDlwd/GujJ4N7HsXUREF62ZnNcB49Gq9gWCRxNFeX756QWwgjlyNMdDDNG
	 phLa3H4rCZ3d19L/8mI5My8ngTA6OHCKafpE/dqE=
Date: Tue, 7 Jul 2026 11:44:52 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>, skhawaja@google.com,
 pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v10 0/6] iommufd: Enable noiommu mode for cdev
Message-ID: <20260707114452.00003517@linux.microsoft.com>
In-Reply-To: <20260706155124.15b2456c@shazbot.org>
References: <cover.1783360051.git.jacob.pan@linux.microsoft.com>
	<20260706195403.GE118313@nvidia.com>
	<20260706155124.15b2456c@shazbot.org>
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

On Mon, 6 Jul 2026 15:51:24 -0600
Alex Williamson <alex@shazbot.org> wrote:

> On Mon, 6 Jul 2026 16:54:03 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Mon, Jul 06, 2026 at 11:48:28AM -0700, Jacob Pan wrote:  
> > > VFIO's unsafe_noiommu_mode has long provided a way for userspace
> > > drivers to operate on platforms lacking a hardware IOMMU. Today,
> > > IOMMUFD also supports No-IOMMU mode for group-based devices under
> > > vfio_compat mode. However, IOMMUFD's native character device
> > > (cdev) does not yet support No-IOMMU mode, which is the purpose
> > > of this patch.
> > > 
> > > In summary, we have:
> > > 
> > > |-------------------------+------+---------------|
> > > | Device access mode      | VFIO | IOMMUFD       |
> > > |-------------------------+------+---------------|
> > > | group /dev/vfio/$GROUP  | Yes  | Yes           |
> > > |-------------------------+------+---------------|
> > > | cdev /dev/vfio/devices/ | No   | This patch    |
> > > |-------------------------+------+---------------|
> > > 
> > > Beyond enabling cdev for IOMMUFD, this patch also addresses the
> > > following deficiencies in the current No-IOMMU mode suggested by
> > > Jason[1]:
> > > - Devices operating under No-IOMMU mode are limited to
> > > device-level UAPI access, without container or IOAS-level
> > > capabilities. Consequently, user-space drivers lack structured
> > > mechanisms for page pinning and often resort to mlock(), which is
> > > less robust than pin_user_pages() used for devices backed by a
> > > physical IOMMU. For example, mlock() does not prevent page
> > > migration.
> > > - There is no architectural mechanism for obtaining physical
> > > addresses for DMA. As a workaround, user-space drivers frequently
> > > rely on /proc/pagemap tricks or hardcoded values.
> > > 
> > > By allowing noiommu device access to IOMMUFD IOAS and HWPT
> > > objects, this patch brings No-IOMMU mode closer to full
> > > citizenship within the IOMMU subsystem. In addition to addressing
> > > the two deficiencies mentioned above, the expectation is that it
> > > will also enable No-IOMMU devices to seamlessly participate in
> > > live update sessions via KHO [2].
> > > 
> > > Furthermore, these devices will use the IOMMUFD-based ownership
> > > checking model for VFIO_DEVICE_PCI_HOT_RESET, eliminating the
> > > need for an iommufd_access object as required in a previous
> > > attempt [3].
> > > 
> > > ChangeLog:
> > > v10:
> > >   - Rebased to v7.2-rc2, no intended code change    
> > 
> > My impression is we are good on this now, right? I would like to
> > pick it up?  
> 
> There are a couple Sashiko findings.  The PAGE_SIZE issue seems like a
> false positive.  The AMD based page tables necessarily expose 4K, but
> pinning is obviously at PAGE_SIZE, so returning multiples of PAGE_SIZE
> is arguably correct.
> 
> The PASID issue seems more like a uAPI hygiene question, and it might
> be the correct answer to return error for values other than
> IOMMU_NO_PASID.  Your call.
> 
> Fine otherwise from a vfio perspective.  Thanks,
> 
> Alex
I agree this is worth rejecting explicitly.

No-IOMMU only supports allocating paging domain and cannot allocate a
PASID-capable domain. The practical path I found is
VFIO_DEVICE_ATTACH_IOMMUFD_PT with VFIO_DEVICE_ATTACH_PASID set, where
userspace supplies the PASID at attach time.

Jason, I tested the change below. If you are okay with it, could you fold it
in? Otherwise I can spin v11.


Date: Tue, 7 Jul 2026 11:33:26 -0700 Subject: [PATCH]
iommufd: Validate HWPT compatibility before noiommu attach

Fixes: 2c6cf6ab1564 ("iommufd: Allow binding to a noiommu device")

Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/iommu/iommufd/device.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index d7060b3b4676..c230ab8dc8f5 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -574,9 +574,6 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
        struct iommufd_attach_handle *handle;
        int rc;
 
-       if (iommufd_device_is_noiommu(idev))
-               return 0;
-
        if (!iommufd_hwpt_compatible_device(hwpt, idev))
                return -EINVAL;
 
@@ -584,6 +581,9 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
        if (rc)
                return rc;
 
+       if (iommufd_device_is_noiommu(idev))
+               return 0;
+
        handle = kzalloc_obj(*handle);
        if (!handle)
                return -ENOMEM;
@@ -645,9 +645,6 @@ static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
        struct iommufd_attach_handle *handle, *old_handle;
        int rc;
 
-       if (iommufd_device_is_noiommu(idev))
-               return 0;
-
        if (!iommufd_hwpt_compatible_device(hwpt, idev))
                return -EINVAL;
 
@@ -655,6 +652,9 @@ static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
        if (rc)
                return rc;
 
+       if (iommufd_device_is_noiommu(idev))
+               return 0;
+
        old_handle = iommufd_device_get_attach_handle(idev, pasid);
 
        handle = kzalloc_obj(*handle);
