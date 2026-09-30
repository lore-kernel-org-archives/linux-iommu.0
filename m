Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AA145D918;
	Wed, 30 Sep 2026 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752811; cv=none; b=AeCYtR/Gd7CXaDfngPkUNVH/e1XpkMNJNMg5srOyWWu+Ix+0BDmYoN356UKMJtdeTMfxxbFAssKDn00hhrxbbybPsNyVdXRyww70fWLtStr44532xH2xnikQbaTvpzA+0WlgmJrQWG+0EptO7MGVI2hgZIhIBPVRybCDjToeMJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752811; c=relaxed/simple;
	bh=egjbfAklu+VRqBXjxrxcsmzn0NRep85lbIRvHaOg7u0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GnDQa3ccON0u/s9q+IP6nc2zivUu/4MrYGxvKWpaoKEL6yBZ6EXSFZYj0UI+iNQ9QSfCCQX+GQ5QcSp4ys4Ta7+Mv2dOcRWQCaEY/mNw1btXtVazS7MsM2Gskuzaq58qJETxndiU9INb1GQEngjrudYVHoC9EW6g5NZVwz/+UTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3tNyKcm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3tNyKcm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDDD1F00898;
	Wed, 30 Sep 2026 07:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790752809;
	bh=aiHKTf8uhlLWd+EaENHzJiUgoWD9yWMgBgu9wtpsmg8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=K3tNyKcmwFqjSCVEPOy659wcqcNlhClI6c/5zo7jZtvC6DVlM7sxOd2DYx+8L6NyP
	 YBvC+0X5tBB6R9mPiF77hgPQwTG64fcNy/qmwmUVFvrWbmpJusOpYD4ACcihZrXoW7
	 arKI/PyyJPgvXVUptN3kFefvcRVYf1N0nTfhLT8K7GkSJRJ3mUqZpQrMKSS0itIPnp
	 fy8gX/qRh0c+9vif5mpqjUkyhhCYmkitrSQ/GIHDhS9zj3rmLpK/1Y7/9FbSZs5+82
	 AJfUBPVH/IJ/ELEMahz0NCE9IED1P8XXIoouSQdrE4kLZeROEBMdIUS+COdkJv8frj
	 Pn8Y0/zDu5nuw==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-coco@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Anthony Krowiak <akrowiak@linxux.ibm.com>
Subject: Re: [RFC PATCH v6 01/11] vfio: cache KVM VM file references instead
 of raw struct kvm pointers
In-Reply-To: <179027891416.104879.7094081421035070060.b4-review@b4>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-2-aneesh.kumar@kernel.org>
 <179027891416.104879.7094081421035070060.b4-review@b4>
Date: Wed, 30 Sep 2026 12:49:59 +0530
Message-ID: <yq5aa4ozurxc.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@nvidia.com> writes:

>> VFIO currently records struct kvm pointers on vfio_group, vfio_device_file
>> and the opened vfio_device. Switch VFIO to track the VM's struct file
>> instead, so VFIO and iommufd can use normal file references for VM lifetime
>> instead of depending on KVM's internal struct kvm refcounting.
>
> Are these few patches the same as:
>  https://lore.kernel.org/all/20260924-vfio-v3-0-4a294307797b@linux.ibm.com/
>
> Can we align on that series or is there something else here?
>

Yes. I will use v4 of that series as the basis for this patch series.

-aneesh
