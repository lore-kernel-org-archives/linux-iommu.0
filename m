Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DACD2EE29F;
	Wed, 18 Jun 2025 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258370; cv=none; b=EgXTfCt1pswfNEeyJa322AN1gnSW+6mT8nCU8AmXKsehNREnlK9t+3vuohB5v+ajJpk0solPrmmjIT6jVID1Ly6WaPmTHsaSFSbR71+JF86cvoySKo5kH+mxkZuVl8l7CRHOZ/pAW+cg1se/ZSmzmh3Dpa5X0mQnJX2LO9tRwxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258370; c=relaxed/simple;
	bh=ye78XrBhba2NCOf8Ds0qrV+SBvGxX0SwyeRI8MNfe8Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=epMM0bQ/c+P4ZAd7QwrL7dC1NhYXhhnUPSwoyubAGfCAs/Y4MqB+6e2KSlol/QVIoc+Z4aghrPmdVz3YWCncEj8ZWzYSMqI4fjD277y+3oXuhret/+QqcuqNBg8F7MrLdswvJ3WDWUWqcSBXGdSGETYxQhzfQ1sXdvCSRF7q3Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqRDzYq3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqRDzYq3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCFBC4CEE7;
	Wed, 18 Jun 2025 14:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750258370;
	bh=ye78XrBhba2NCOf8Ds0qrV+SBvGxX0SwyeRI8MNfe8Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JqRDzYq3DkVxbaDGh9geE+oDXGDw7Zdv6AHy5U/23LUdul3ykT4P0Ou5l21dwmTm2
	 OIxB3KGT2DFJmAVIhDqFtQW6bgxvCOn4boPqfxUA7gvikT4tNkJimn6Nt4CIlRfjyH
	 OkxtOCROvP3OAgie/etjZusvorj/cldUZCaRjUJ7gCUzbxtqDBfxZlNLbjlnLOIuRh
	 TJgae0rhzXOzZnxf8ePDCU07BEYQKyUGSTkBKdekEHPIK+dbq+EHJiGGceKDCxMuMQ
	 a3y4cOOv8Gur+eqh5c5wiCzzobN7Jo7ILOVrBSoyiyMeXv+920HKfqytr79TQ9dM65
	 VOro/7vvjw5OA==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH] iommufd: Destroy vdevice on device unbind
In-Reply-To: <20250618133527.GQ1376515@ziepe.ca>
References: <BN9PR11MB527606182417BB7A35349F598C74A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250612172645.GA1011960@ziepe.ca>
 <BN9PR11MB5276B467ADCC57BC6571CA458C77A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250613124202.GD1130869@ziepe.ca> <yq5abjqotim7.fsf@kernel.org>
 <BN9PR11MB527633CA2F698E83E12BFBD68C70A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250616164941.GA1373692@ziepe.ca> <yq5azfe6ssev.fsf@kernel.org>
 <20250617183452.GG1376515@ziepe.ca> <yq5awm99sjmr.fsf@kernel.org>
 <20250618133527.GQ1376515@ziepe.ca>
Date: Wed, 18 Jun 2025 20:22:44 +0530
Message-ID: <yq5att4drtj7.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Wed, Jun 18, 2025 at 10:59:00AM +0530, Aneesh Kumar K.V wrote:
>> Jason Gunthorpe <jgg@ziepe.ca> writes:
>>=20
>> > On Tue, Jun 17, 2025 at 01:37:04PM +0530, Aneesh Kumar K.V wrote:
>> >=20=20
>> >> How do we reclaim that object id for further reuse?=20
>> >
>> > Maybe just don't? Userspace did something it shouldn't, it now leaked
>> > 8 bytes of kernel memory until the FD is closed.
>> >
>>=20
>> Between the two sequences below, Sequence 1 is the correct one, since we
>> want the object ID to be released after calling ioctl(DESTROY,
>> vdevice_id), right?
>>=20
>> Sequence 1 (Correct):
>>=20
>> close(vfio_cdev)          =E2=86=92 triggers vdevice destruction=20=20
>> ioctl(DESTROY, vdevice_id) =E2=86=92 reclaims vdevice object ID=20=20
>> close(iommufd)=20=20
>
> This is wrong, the vdevice has outlived the idevice
>
>> Sequence 2:
>>=20
>> ioctl(DESTROY, vdevice_id) =E2=86=92 returns EBUSY
>
> It should not return EBUSY, it should destry the vdevice.
>
> The full sequence I would expect a sane userspace to do is:
>
> open(vfio_cdev)
> ioctl(vfio_cdev, VFIO_DEVICE_BIND_IOMMUFD, iommufd)
> ioctl(iommufd, IOMMUFD_CMD_VIOMMU_ALLOC)
> ioctl(iommufd, IOMMUFD_CMD_VDEVICE_ALLOC)
> ioctl(iommufd, IOMMUFD_CMD_VDEVICE_DEALLOC)
> ioctl(iommufd, IOMMUFD_CMD_VIOMMU_DEALLOC)
> close(vfio_cdev);
>

And if the user does

open(vfio_cdev)
ioctl(vfio_cdev, VFIO_DEVICE_BIND_IOMMUFD, iommufd)
ioctl(iommufd, IOMMUFD_CMD_VIOMMU_ALLOC)
ioctl(iommufd, IOMMUFD_CMD_VDEVICE_ALLOC)
close(vfio_cdev);   -> this should call vdevice_destroy because idevice is =
getting destroyed here (we will put XA_ZERO_ENTRY here).
ioctl(iommufd, IOMMUFD_CMD_VDEVICE_DEALLOC) -> No error, we convert the XA_=
ZERO_ENTRY to NULL here?
ioctl(iommufd, IOMMUFD_CMD_VIOMMU_DEALLOC)

-aneesh
