Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3682610785;
	Mon, 16 Jun 2025 04:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750048138; cv=none; b=ZaCTJG8LLJ5zva2ANlZT9uO2A0f0KIQ7TiQv8aBrU8k9ZJKjCuV7ixMv8ruYymhZkrckZgwtAaBlZys+LV3XFvg160zBPy5cs74gBLmjK1iPbeA8jQA5L9ACx20bUOK4Ad31Rb8AhdPl/iRhTo6f+LJ4lyv9tsYYJDKAuvmOntg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750048138; c=relaxed/simple;
	bh=awP1xc//mTc2pj+5moZpYL+zfaPvMNLOmWiF5mIrl30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=klDi03YwcUDFG8jyRqT3z1DtNiTuEMZY12MpUf4PkXMiEJM9OIvDlx3NH3GSo04+obDQAxrr+PKnIxrO1jXomQJqm6ImNVO8PjKV7eTVdy+hq5xVgf7jfjR/7KyCyg9ofua5Ac6Ht0zSC9NnG6aSkNoLzPUnOnJ1cM4me6HwREA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLg23R5J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLg23R5J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A68DC4CEEA;
	Mon, 16 Jun 2025 04:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750048136;
	bh=awP1xc//mTc2pj+5moZpYL+zfaPvMNLOmWiF5mIrl30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hLg23R5JLAruv7400Ij/HnexVCE3PWo8bDo+v6Wlr53TtfyjLcKwKQG2e4YxbdMdT
	 zkZIwoo/E3hfO4hw1uKE67FdkP4oX3I1qPB5qrtJuH6mcPzYvO+H+ciJbA7XUHGRkh
	 juyvJVJ2WszkIOAzW2XbZcgG3TT33sRl4+AYvbbsbjBW7+d8aHcll+08GN7Ww1f691
	 leFlMvyohJqIJI8K1DU/X36bPfRCcrvd/p6ybhYPvSuM6KzRVn+MyfAGj4Fx5799Ji
	 V9F1uPrxQmBEs7bcP0afiqMFwcJsYZBQT6YhO3k+FnrMuFTcw+swe/8b3ckO4h31Ak
	 +xtmlm7NLoJcw==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, "Tian, Kevin" <kevin.tian@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH] iommufd: Destroy vdevice on device unbind
In-Reply-To: <20250613124202.GD1130869@ziepe.ca>
References: <20250610065146.1321816-1-aneesh.kumar@kernel.org>
 <BN9PR11MB527606182417BB7A35349F598C74A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250612172645.GA1011960@ziepe.ca>
 <BN9PR11MB5276B467ADCC57BC6571CA458C77A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250613124202.GD1130869@ziepe.ca>
Date: Mon, 16 Jun 2025 09:58:48 +0530
Message-ID: <yq5abjqotim7.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Fri, Jun 13, 2025 at 07:31:48AM +0000, Tian, Kevin wrote:
>> yeah that seems to be the option if the said life-cycle dependency
>> cannot be removed...
>>=20
>> conceptually it's still a bit unclean as the user needs to know that
>> the vdevice object is special after idevice is unbound i.e. it can only
>> be destroyed instead of supporting any other kind of operations.
>
> I would say userspace is somewhat malfunctioning if it destroys vfio
> before the vdevice. So the main aim here should be to contain the
> resulting mess, but still expect userspace to destroy the vdevice
> without a failure.
>

The destruction of the vdevice is triggered by the .release method of
the iommufd file operations(iommufd_fops_release())

and the destruction of the idevice is driven by the .release method of
vfio cdev.

    vfio_device_fops_release()
    =E2=86=92 vfio_df_device_last_close()
    =E2=86=92 vfio_iommufd_physical_unbind()
    =E2=86=92 iommufd_device_unbind()

The vfio subsystem also retains a reference to the iommufd file descriptor =
through:

    vfio_df_ioctl_bind_iommufd()
    =E2=86=92 iommufd_ctx_from_fd()

This reference prevents the vdevice from being destroyed while the idevice =
remains bound.

So, IIUC, the current destruction flow is: first destroy vfio, and then des=
troy the vdevice?

>
>> hmm if the user needs to build certain knowledge anyway can we=20
>> go one step further to state that the vdevice will be destroyed
>> automatically once its idevice is unbound so the user shouldn't
>> attempt to explicitly destroy it again after unbind?
>
> I would assume a malfunctioning userspace is probably going to destroy
> the vdevice explicitly. If it had proper knowledge it wouldn't have
> done this in the first place :)
>
> Jason

-aneesh
