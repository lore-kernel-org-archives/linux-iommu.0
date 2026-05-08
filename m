Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5339E322DAF;
	Fri,  8 May 2026 04:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778213541; cv=none; b=DSZPPB0pXQ8Bls0K2LKo0VjCGSLNpci/erNy8PQNkDhe+ATu1PhsCp7Xf/MHlvHU/37IOiAs17Hkn6NwNmkJKZTQEs9XP3eM4eDdfNG7OrPdAumFMFOtEM0h8XTZaHmzgx39Sq0M76GMWtTtOA6YtY+rFYXpuMcC/w9iUd/RKeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778213541; c=relaxed/simple;
	bh=xGK13SXlZFMCZyBXHG1YIKcBmtpGcWGbIJ5WRiG2RwQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OFyv+e66ZBFG92E6+7h/UO6S0/4Lx5SdXLHo0By+0z1i1IWz5yb83z+EJtwQBjKE5MYxykrXgNqZRklkRROmjAc9AFSGlxjyrfibdRtW4lnMgWGLMnjaLpOTvixgXFNOJoeDlN9idCMqCW98xS4rUVPPdrFlegyP9w2vQd2fJLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1P2q12t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1P2q12t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21815C2BCB0;
	Fri,  8 May 2026 04:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778213540;
	bh=xGK13SXlZFMCZyBXHG1YIKcBmtpGcWGbIJ5WRiG2RwQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Y1P2q12t/0gddTnuxQOckoaIGYu3bjTZWgT2cmhUTDRKfFtUofqrjovX0ReQhNvYS
	 cU+HBMYS4tJPgjff35lLQGbSvpUGsFjApRQj6biGqyXmffizRSdgVn4BtXKOq/hMfL
	 fMDe9S01d42NqsL2sVvXgrzApATWeFMvUBvtRnX9NXuf9IzrmvVvtcG21UsR3g4brZ
	 mxKGSep3nuD5n/b9B0XBgb9XQIH3larj3PGzscn9I8wkgNzLxT/4HQ+1a53ILqT3B9
	 5Es5fwz+BN320sTmoaDDiDMtk2M03Z6361GYd9hsxOjLCky6GRWNRpIYbwZgs+lVvP
	 9PL9AatndrLEA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: "Tian, Kevin" <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	djbw@kernel.org
Subject: RE: [PATCH v4 4/4] iommufd/vdevice: add TSM guest request ioctl
In-Reply-To: <BN9PR11MB5276EA9139255EE49B56AD718C3D2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260427061005.901854-1-aneesh.kumar@kernel.org>
 <20260427061005.901854-5-aneesh.kumar@kernel.org>
 <20260427140539.GE740385@ziepe.ca> <yq5acxzj1dwu.fsf@kernel.org>
 <20260428124854.GA849557@ziepe.ca>
 <BN9PR11MB5276EA9139255EE49B56AD718C3D2@BN9PR11MB5276.namprd11.prod.outlook.com>
Date: Fri, 08 May 2026 09:42:11 +0530
Message-ID: <yq5alddutu90.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Tian, Kevin" <kevin.tian@intel.com> writes:

>> From: Jason Gunthorpe <jgg@ziepe.ca>
>> Sent: Tuesday, April 28, 2026 8:49 PM
>>=20
>> On Tue, Apr 28, 2026 at 05:43:05PM +0530, Aneesh Kumar K.V wrote:
>> > Jason Gunthorpe <jgg@ziepe.ca> writes:
>> >
>> > > On Mon, Apr 27, 2026 at 11:40:05AM +0530, Aneesh Kumar K.V (Arm)
>> wrote:
>> > >> +/**
>> > >> + * struct iommu_vdevice_tsm_guest_request -
>> ioctl(IOMMU_VDEVICE_TSM_GUEST_REQUEST)
>> > >> + * @size: sizeof(struct iommu_vdevice_tsm_guest_request)
>> > >> + * @vdevice_id: vDevice ID the guest request is for
>> > >> + * @scope: Bus-specific scope classification for the guest request
>> > >> + * @req_len: Size in bytes of the input payload at @req_uptr
>> > >> + * @resp_len: Size in bytes of the output buffer at @resp_uptr
>> > >> + * @__reserved: Must be 0
>> > >> + * @req_uptr: Userspace pointer to the guest-provided request
>> payload
>> > >> + * @resp_uptr: Userspace pointer to the guest response buffer
>> > >> + *
>> > >> + * Forward a guest request to the TSM bound vDevice. This is inten=
ded
>> for
>> > >> + * guest TSM/TDISP message transport where the host kernel only
>> marshals
>> > >> + * bytes between userspace and the TSM implementation.
>> > >> + *
>> > >> + * The meaning and valid values of @scope are defined by the TSM
>> backend for
>> > >> + * the device bus type.
>> > >
>> > > If you want to do this then you have to also provide a way to discov=
er
>> > > what the TSM backend is so userspace can form the correct numbers.
>> > >
>> >
>> > These guest-driven requests end up in the correct VMM backend, which
>> > should already be aware of the scope value to use. In the case of ARM
>> > CCA, the RHI calls include a device ID (vdev_id), which the VMM can use
>> > to determine the appropriate scope value.
>>=20
>> That seems kind of indirect, we technically support multiple TSMs in
>> the kernel, how does it all get reconciled?
>>=20
>> Passing overlapping numbers here without any way to tell them apart is
>> not a good uapi design.
>>=20
>
> Agree. another thing is, as I replied to last version, what about userspa=
ce
> providing a wrong scope value then what would be the consequence...


I will wait for Dan=E2=80=99s feedback on how we should handle the scope. W=
e may
have to move that to the generic headers as part of the TSM patchset.

Regarding what happens when an invalid scope is passed: tsm_guest_req()
currently only handles pci_device, and the backend driver=E2=80=99s
pci_tsm_guest_req() callback will reject unsupported scope values.

I understand that we may want to add some checks in the generic ioctl
handler once these scope values are moved out of PCI TSM.

-aneesh
