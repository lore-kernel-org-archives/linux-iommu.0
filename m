Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA9E22F767
	for <iommu@lists.linux.dev>; Tue,  3 Jun 2025 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748967953; cv=none; b=kUtpcUYgU1g+7e1ZBnVftC3OtZZLHqQwtn/NNUILJ5JuFY9KEJgLBJWf43fr9Dqz379eudXzyXWvNeAkFLsNr9V2iHWtOUMryJA3LeQew4Pu3beuq4C+5dY29JzNBSlRzf4sxecrx0BKe0IazhBuBv64pg2+ec9ZaAxW08v24C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748967953; c=relaxed/simple;
	bh=nC+Bv9/NganYljGeVVxYnBz8mf2/6tXL3NetE9KkmX8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H6Jy2kLRoIge7hQSCnvoX+lMR99ybEFNMbT9b1HyflZBycV/PQjU75Af3nk1y92il416f8eJmrxKeK7ujnQZmiKMTDpNAB1QUcuQpvgoWX8N2oSXz03JkFSyGK6CkS9NNLfNGmRAhe9+wu7rs2cbu+9tLuhXkfNawpuDiFyP0MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kBvTA5PD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kBvTA5PD"
Received: from DESKTOP-0403QTC. (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id 51C682027DF7;
	Tue,  3 Jun 2025 09:25:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 51C682027DF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748967950;
	bh=yspkoK5rLJ1JmlLuXQ45Xhp8lcZ/b0jUx0Pk7pIVba8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
	b=kBvTA5PDLq2cs2KZRWSwjcKiE+yEw7jfIJqulV/pF3mhXtcnN+cIHvFUC8kb1j1Rw
	 njX433D6VM0ZfnHM+Xn+SXXwu8Tn0+lXdkry1M05GPOg5E/sFzPkAKJH4r2ZPNGZ40
	 kGXsNXDL8gYJTm2Ow3dRVrAenfjv9RpeFb78A/44=
Date: Tue, 3 Jun 2025 09:25:49 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Alex Williamson
 <alex.williamson@redhat.com>, "Zhang Yu" <zhangyu1@microsoft.com>, Easwar
 Hariharan <eahariha@linux.microsoft.com>, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH 1/2] vfio: Fix unbalanced vfio_df_close call in no-iommu
 mode
Message-ID: <20250603092549.4fbbed92@DESKTOP-0403QTC.>
In-Reply-To: <dcd0cf4b-1907-4c27-a8f6-3dddf8313f6b@intel.com>
References: <20250516164522.51905-1-jacob.pan@linux.microsoft.com>
	<20250527000511.GK61950@nvidia.com>
	<dcd0cf4b-1907-4c27-a8f6-3dddf8313f6b@intel.com>
Reply-To: jacob.pan@linux.microsoft.com, Saurabh Sengar
 <ssengar@linux.microsoft.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Yi,

On Wed, 28 May 2025 15:16:57 +0800
Yi Liu <yi.l.liu@intel.com> wrote:

> On 2025/5/27 08:05, Jason Gunthorpe wrote:
> > On Fri, May 16, 2025 at 09:45:21AM -0700, Jacob Pan wrote:  
> >> For no-iommu enabled devices working under IOMMUFD VFIO compat
> >> mode, the group open path does not call vfio_df_open() and the
> >> open_count is 0. So calling vfio_df_close() in the group close
> >> path will trigger warning in vfio_assert_device_open(device);
> >>
> >> E.g. The following warning can be seen by running VFIO test.
> >> https://github.com/awilliam/tests/blob/master/vfio-noiommu-pci-device-open.c
> >> CONFIG_VFIO_CONTAINER = n
> >> [   29.094781] vfio-pci 0000:02:01.0: vfio-noiommu device opened
> >> by user (vfio-noiommu-pc:164) Failed to get device info
> >> [   29.096540] ------------[ cut here ]------------
> >> [   29.096616] WARNING: CPU: 1 PID: 164 at
> >> drivers/vfio/vfio_main.c:487 vfio_df_close+0xac/0xb4
> >>
> >> This patch adds checks for no-iommu mode and open_count to skip
> >> calling vfio_df_close.  
> 
> thanks for catching it. :)
> 
> >> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> >> ---
> >>   drivers/vfio/group.c | 7 ++++---
> >>   1 file changed, 4 insertions(+), 3 deletions(-)  
> > 
> > Sorry, this should have a fixes line:
> > 
> > I think it is probably
> > 
> > Fixes: 6086efe73498 ("vfio-iommufd: Move noiommu compat validation
> > out of vfio_iommufd_bind()")
> > 
> > By the look of it, since that is what started skipping the
> > vfio_df_open()
> > 
> > But after looking at that patch I'm now doubting that this is the
> > right fix.
> > 
> > Previously we'd still do vfio_df_device_first_open(), just the
> > vfio_df_iommufd_bind() was skipped.
> > 
> > Now we skip all of vfio_df_device_first_open() which also means we
> > skip:
> > 
> > 	if (!try_module_get(device->dev->driver->owner))
> > 		return -ENODEV;
> > 
> > and
> > 	if (device->ops->open_device) {
> > 		ret = device->ops->open_device(device);
> > 
> > Which seems wrong to me?? We only want to skip the bind, we should
> > still do open_device! At least that is how it was before 6086e
> > 
> > So.. This may not be the right fix.  
> 
> yes. this makes sense. If not opened, userspace is not able to use the
> device.
> 
Put this bug aside for now, I'm still unclear on why we do not allow
bind for no-IOMMU devices. Per my understanding, no-IOMMU only means no
translation. But since device still has been granted access, we should
be able to allow binding device in no-IOMMU mode with IOMMU-FD
context while simply disallowing IOAS attachment?

The reason I am asking is that I am working on enabling cdev with
noiommu mode based on Yi's patch
(https://lore.kernel.org/kvm/20230601082413.22a55ac4.alex.williamson@redhat.com/),
it seems having iommufd implicit ownership model is key to enable PCI
HOT RESET. Our goal is to leverage persistent iommufd context for kexec
handle off (KHO) usage, we currently have noiommu mode. This requires
binding of device with iommufd ctx (can be marked as persistent) AFAIK,
any suggestions?"


Thanks,

Jacob
