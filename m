Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C12BE49;
	Mon, 16 Jun 2025 04:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750049182; cv=none; b=RMQ1d30taYr36xAsZFtBvwxKSby7UXSzlHHdqI3rOYCDZNztwVm0qwBwsWAX8K9/PnlRkf9wG1QWx3NGFmTYmD3TNzXcWtCeS29WWgZtB1RthkFrWDbFmxS/CU7w2jBUsCG7nJ5fcfUcAvEB07eMTVCGjPfkzyhmrAgw2XILK0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750049182; c=relaxed/simple;
	bh=VxeE5b495HPYIW1v9NA5NUalr5gn/cyjD63eiAtKrLg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cR48yKV0yzUI/AV4abdc24eLxxZo15ms22gw3huK811xT1B5d5H+P0+xfQLihbRxq/sdrmfS1w1P2U6A5oOwBkxbeX1bdoJNVO9NmBNVQWGnBSv7gU7wZf+OV9mpU/LMrA5qoaxs88nEtJN8MWU29nu1WeVspW/w4HgBnhmM3ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBLX+0XY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBLX+0XY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AAEC4CEEA;
	Mon, 16 Jun 2025 04:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750049180;
	bh=VxeE5b495HPYIW1v9NA5NUalr5gn/cyjD63eiAtKrLg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mBLX+0XYXbGsWRonxQ1wzcwK7aEYnbbNpAdlOnQ23z12S4GGwuU/OhGXpnh+Vdw4A
	 TvxX3KhAwPWWJGvRz5TAF+SB6eKGIvNu4BRg0FoR3QoLr/zqUGReMWKnQ0Uv+9l66Y
	 dvjutIbxSCMcpNgNivCC5l0oC4/xr/KgVKkTa37PuWCJD9HhdiVPMOHJkjeZwoyLrx
	 DZbdbLxUwtzDCvcDkYDKG26njwGWny2leF/TfNb4cdr37YYXQfWbUAbDsHnzAeJJx/
	 2LLocnYeGQJ6lgLMh8qcot8V7HaMDWQV1BjxpWxdlkw0MHLnXu5T2nTkQi2mUpdGh6
	 hVhZxx2+ZAVRg==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: "Tian, Kevin" <kevin.tian@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: RE: [RFC PATCH] iommufd: Destroy vdevice on device unbind
In-Reply-To: <BN9PR11MB527606182417BB7A35349F598C74A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250610065146.1321816-1-aneesh.kumar@kernel.org>
 <BN9PR11MB527606182417BB7A35349F598C74A@BN9PR11MB5276.namprd11.prod.outlook.com>
Date: Mon, 16 Jun 2025 10:16:14 +0530
Message-ID: <yq5a8qlstht5.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Tian, Kevin" <kevin.tian@intel.com> writes:

>> From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> Sent: Tuesday, June 10, 2025 2:52 PM
>>=20
>> The iommufd subsystem uses the VFIO character device descriptor to bind
>
> it's the 'user' or 'vmm' initiating that operation, not the subsystem its=
elf.
>
>> a device file to an iommufd context via the VFIO_DEVICE_BIND_IOMMUFD
>> ioctl. This binding returns a bind_id, which is then used in subsequent
>
> there is no 'bind_id' in any uAPI. let's stick to 'devid'.
>
>> iommufd ioctls such as IOMMU_HWPT_ALLOC, IOMMU_VIOMMU_ALLOC,
>> and
>> IOMMU_VDEVICE_ALLOC.
>>=20
>> Among these, IOMMU_VDEVICE_ALLOC is special=E2=80=94the lifetime of a vi=
rtual
>> device (vdevice) should be tied to the bound state of its physical
>> device.
>>=20
>> In the current kernel, there is no enforced dependency between
>> iommufd_device and iommufd_vdevice. This patch introduces such a
>> dependency: when the device is unbound, the associated vdevice is now
>> automatically destroyed.
>
> This went backward.
>
> The initial v5 patch [1] from Nicolin was similar to what this
> patch does. Jason explained [2] why it's unsafe to destroy "userspace
> created" objects behind the scene. And a general rule in iommufd is
> to not take long term references on kernel owned objects.
>
> [1] https://lore.kernel.org/all/53025c827c44d68edb6469bfd940a8e8bc6147a5.=
1729897278.git.nicolinc@nvidia.com/
> [2] https://lore.kernel.org/all/20241029184801.GW6956@nvidia.com/
>
>>=20
>> Although there is already an implicit dependency=E2=80=94vdevices can on=
ly be
>> destroyed after the iommufd_device is unbound due to the VFIO cdev file
>> descriptor holding a reference to the iommu file descriptor=E2=80=94this=
 patch
>
> I didn't get this part. The user owns the life cycle of its created objec=
ts.
> We don't have such restriction that a vdevice object can be destroyed
> only after device is unbound...
>

What I described above explains how the kernel manages destruction of
these objects.

The vfio subsystem retains a reference to the iommufd file descriptor
through:

    vfio_df_ioctl_bind_iommufd() =E2=86=92 iommufd_ctx_from_fd()

This reference prevents the associated vdevice from being destroyed when
the iommufd file descriptor is closed, as long as the idevice remains
bound. While vdevice objects can still be explicitly destroyed using
iommufd_destroy(), with this patch, if the idevice is still bound,
attempting to destroy the vdevice will return EBUSY.

In effect, the change ensures that once a vdevice is created, its
lifecycle is tied to that of the idevice.

From other emails in this thread, I understand that beyond the the
changes in this patch, we want to prevent the reuse of the vdevice
object ID. We also need to ensure that any userspace-initiated operation
on this vdevice object ID results in an error after the idevice is
unbound?

-aneesh
