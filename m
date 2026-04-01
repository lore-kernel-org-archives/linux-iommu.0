Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5632F5337
	for <iommu@lists.linux.dev>; Wed,  1 Apr 2026 22:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775081846; cv=none; b=hC/B4k+9PHW3Q+8hyPmma19ewqgNbyry8WTEppq4hikCypGkvbqXUQ2VU36reT78xB+SG8/DjdqihBaBPJooD22Mrz8xU0Hhj6jADZmPzNyp8rwj3K8OoetkVv8Iju4YhlOkb018JoZZnD5sZ261cz2oSZo7GeGIW+RFE2J+sow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775081846; c=relaxed/simple;
	bh=6vQfUmV5OzbVBiX3ZizG+KV5njVJAbXAZglQRd28UU8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GOD+DgqzN4MuzxyFSf+vER7OzgvxKVIp52hoHZ9OTrmwI29GwNZ8NsdFWeWb8Lj3bePdJ2MAylbLbE9gbEZQLvrVk+qUHqWLNqbL1eaeShQu4m38vrxxOTVUiZ70WdU8koWMgWfBg0Ag7kqLLtImcVCwVSUjFOKi12pBGrMc8jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lwcej/yy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lwcej/yy"
Received: from localhost (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id 64BC220B710C;
	Wed,  1 Apr 2026 15:17:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 64BC220B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775081845;
	bh=nnuG3H44tpXaLVq66f7koFUd85UcpULY8qNe88SzwEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lwcej/yybQ1bOdxQPOtINUKpa7jSEGr3F29FP5g/WTgs1jzOfzuryWwo31gfZHnDM
	 wcO84nAS1yr3/S8cKsG2Ucb5uQQ/wF12mC3Gza/OaFzVg4QjOf6Rsm/AlEpnAx1VOp
	 2xg+52EYeV6ERbmHjnsSLb+T0mGqyJwVwmMEeGXg=
Date: Wed, 1 Apr 2026 15:17:23 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, skhawaja@google.com, pasha.tatashin@soleen.com, Will
 Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V2 07/11] vfio: Update noiommu device detection logic
 for cdev
Message-ID: <20260401151723.00006610@linux.microsoft.com>
In-Reply-To: <ab--s13iPc6X8jIx@google.com>
References: <20260312155637.376854-1-jacob.pan@linux.microsoft.com>
	<20260312155637.376854-8-jacob.pan@linux.microsoft.com>
	<ab--s13iPc6X8jIx@google.com>
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

On Sun, 22 Mar 2026 10:04:35 +0000
Mostafa Saleh <smostafa@google.com> wrote:

> On Thu, Mar 12, 2026 at 08:56:33AM -0700, Jacob Pan wrote:
> > Rework vfio_device_is_noiommu() to derive noiommu mode based on
> > device, group type, and configurations.
> > 
> > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > ---
> >  drivers/vfio/vfio.h | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> > index 838c08077ce2..c5541967ef9b 100644
> > --- a/drivers/vfio/vfio.h
> > +++ b/drivers/vfio/vfio.h
> > @@ -127,8 +127,13 @@ static inline bool
> > vfio_null_group_allowed(void) 
> >  static inline bool vfio_device_is_noiommu(struct vfio_device *vdev)
> >  {
> > -	return IS_ENABLED(CONFIG_VFIO_NOIOMMU) &&
> > -	       vdev->group->type == VFIO_NO_IOMMU;
> > +	if (!IS_ENABLED(CONFIG_VFIO_NOIOMMU))
> > +		return false;
> > +
> > +	if (vfio_null_group_allowed())
> > +		return vdev->noiommu;
> > +
> > +	return vdev->group->type == VFIO_NO_IOMMU;  
> 
> I see that noiommu is set for both, can this just be simplified to:
> 
> 	return IS_ENABLED(CONFIG_VFIO_NOIOMMU) && vdev->noiommu;
> 
Good point, no need to check group now. will do.

Sorry for the late response.

Thanks,

Jacob

