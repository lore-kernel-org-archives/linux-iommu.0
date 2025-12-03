Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E0436D4F1
	for <iommu@lists.linux.dev>; Wed,  3 Dec 2025 00:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764720399; cv=none; b=a6S0dQQ63Qk5o+HlnRwHRxJHjuTxA+lh5U/oAg0yfc/2wyHh1GsVjKPucHaVupCXyZJKZyKidUFFZtkUVy2pZ2jwxQ6yJLrbcs1TytYqUyE5JMR6ozAkvmhNp52V7Rwl6hWDpbncQWkHxPEtDOG/HUKn1QBFUcf1ukrNp1hvuw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764720399; c=relaxed/simple;
	bh=/uYonTBBJ+hMkreqlVmaaI1ZVo7vYfDfedUT6ptMmrg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dTh15YtfR1XMJjMO9SEfO/GxGv4MJ6sAgXOrNMaumKXK2DmU7LxHpjKmKOqjwqgxOblZBWtd+R9emlRdmWyeX899/zzehH4xyM8Dg4wBXL1TO8WvHipLLqWoSZEMjnOPV3++VKVS+FlGetdE3OeNJLngIziuRz8GAOReSKgk22g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VvxPIeX4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VvxPIeX4"
Received: from localhost (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8EF862120E9E;
	Tue,  2 Dec 2025 16:06:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8EF862120E9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764720397;
	bh=1u0FPaFVEb0xQqeKnEz3s6WwGLHZzMWAgry0Pc+UPHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VvxPIeX4ram7e4Yz35HoZBsujo868Vv+d3MnsdNg7kK1LYiEEPvchNQnmuOTIApJ/
	 7TKUL7ogCbfHfLEW+DeUG/9TAONBISqjvjOmVS77M7xXT0ahU3MX1fQLDailDzuEFb
	 5eK8GuSCQBGaWUC97g/nt9nPQl7xY2viS+6CSdp4=
Date: Tue, 2 Dec 2025 16:06:35 -0800
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
Message-ID: <20251202160635.0000433e@linux.microsoft.com>
In-Reply-To: <f88707d4-bd04-4e9b-8d4b-ccb679d70dae@linux.intel.com>
References: <20251201173012.18371-1-jacob.pan@linux.microsoft.com>
	<20251201173012.18371-3-jacob.pan@linux.microsoft.com>
	<f88707d4-bd04-4e9b-8d4b-ccb679d70dae@linux.intel.com>
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

On Tue, 2 Dec 2025 10:17:34 +0800
Baolu Lu <baolu.lu@linux.intel.com> wrote:

> Hi Jacob,
> 
> On 12/2/25 01:30, Jacob Pan wrote:
> > The dummy IOMMU driver for No-IOMMU mode should only be active when
> > no real IOMMU devices are present in the system. Introduce a helper
> > to check this condition, ensuring that the dummy driver does not
> > interfere when hardware-backed IOMMU support is available.
> > 
> > Signed-off-by: Jacob Pan<jacob.pan@linux.microsoft.com>
> > ---
> >   drivers/iommu/iommu.c | 10 ++++++++++
> >   include/linux/iommu.h |  1 +
> >   2 files changed, 11 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 0df914a04064..958f612bf176 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -2895,6 +2895,16 @@ static const struct iommu_device
> > *iommu_from_fwnode(const struct fwnode_handle * return ret;
> >   }
> >   
> > +bool iommu_is_registered(void)
> > +{
> > +	bool registered;
> > +
> > +	spin_lock(&iommu_device_lock);
> > +	registered = !list_empty(&iommu_device_list);
> > +	spin_unlock(&iommu_device_lock);
> > +	return registered;
> > +}  
> 
> IOMMU devices might be added by calling iommu_device_register() at any
> time. Therefore, an empty iommu_device_list does not necessarily mean
> that "no real IOMMU devices are present in the system."
Good point. My intention was that the noiommu dummy driver should
register only after all hardware IOMMU drivers have completed
registration during boot. Any subsequent registration attempt, such as a
hot-added IOMMU, should fail if noiommu mode is already active.

We could enforce this by introducing a global flag that prevents any
iommu_device from being registered after the noiommu driver has been
initialized.

However, as you pointed out there seems to be no standard ordering
for iommu device registration across platforms. e.g. VT-d hooks up with
x86_init, smmuv3 does that in platform driver probe. This patchset puts
dummy driver under early_initcall which is after both but not a
guarantee for all platforms. Any suggestions?

