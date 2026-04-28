Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18703F23CA;
	Tue, 28 Apr 2026 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777377674; cv=none; b=r9iDuzEwfZl9k+iEFZPQXk506h4RsgM5gAI1Xer0EynhZk4mnVXLs9xuoOWrCeRb7sgP8IekbN7IoqgK2xQjGWYiwpeQixAzjK62iQFm7Sax4EHW9E12VkenDR6zl5lHitpv8+Wh8IuB08Q2VJNj0w2oBDnWNBLiQ3Y/pxNPtNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777377674; c=relaxed/simple;
	bh=UcCOVkMN4JL4k89WNPchdU3awG8p4R5z0Rj7iRH/tqs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BcSJcJeCUp2nDFssq3dnQU92MctTT/UUnOIzClUHnRb9XaiBqRM8YLfDG2DPQlhB6TowH+YNe14NceWvgKirSQQuMuF2fJE08vwYgeco5U/MNyavNFHOZUpnhZoyF2cTN5Fz+N7nmgR25PksJXs/Gb1uLIjiRxtRNkjtVcXCM3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aROiHYbs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aROiHYbs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E3FC2BCB7;
	Tue, 28 Apr 2026 12:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777377673;
	bh=UcCOVkMN4JL4k89WNPchdU3awG8p4R5z0Rj7iRH/tqs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aROiHYbsJyey+ljdKZG0mzWHT1OUBbqSF6NIDs3j0LwdEA93eWVF/dwViPiDiOh/7
	 v/bB3K1MyNHZpAQxa0o4NHSoSyDKmcT1WtpPwr4g0L9Alit9oLapgNjnPUNLLkWrvP
	 yc9n6jSfc+ELN+lN9bpYbooQZ0/Sb+5P2hJ0Y7LJgCvEeuPJ9E8h4VoCESpE92Wlsz
	 Wd1eNXvilKHGz8qlO4sQBAHsshPEjHJTQwgSS1SQ+EJmLtRHL44xuNfiZTNPHQ/Mh/
	 qWppW10bwDzO4PoFizLPPwgr/U9Ojy0+1uDZAIymiwSmQmr0yWhF7W6B05SI9AzsZG
	 UYv2OuRsHD0tQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
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
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 1/4] iommufd/device: Associate a kvm pointer to
 iommufd_device
In-Reply-To: <20260427135906.GB740385@ziepe.ca>
References: <20260427061005.901854-1-aneesh.kumar@kernel.org>
 <20260427061005.901854-2-aneesh.kumar@kernel.org>
 <20260427135906.GB740385@ziepe.ca>
Date: Tue, 28 Apr 2026 17:31:04 +0530
Message-ID: <yq5afr4f1egv.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Mon, Apr 27, 2026 at 11:40:02AM +0530, Aneesh Kumar K.V (Arm) wrote:
>> From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>> 
>> Add a struct kvm * to iommufd_device_bind() fn and associate it
>> with idev if bind is successful.
>> 
>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> [nicolinc: fix build error in iommufd_test_mock_domain()]
>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> ---
>>  drivers/iommu/iommufd/device.c          | 5 ++++-
>>  drivers/iommu/iommufd/iommufd_private.h | 2 ++
>>  drivers/iommu/iommufd/selftest.c        | 2 +-
>>  drivers/vfio/iommufd.c                  | 2 +-
>>  include/linux/iommufd.h                 | 4 +++-
>>  5 files changed, 11 insertions(+), 4 deletions(-)
>
>> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
>> index 344d620cdecc..453fbceb9219 100644
>> --- a/drivers/iommu/iommufd/device.c
>> +++ b/drivers/iommu/iommufd/device.c
>> @@ -203,6 +203,7 @@ void iommufd_device_destroy(struct iommufd_object *obj)
>>   * iommufd_device_bind - Bind a physical device to an iommu fd
>>   * @ictx: iommufd file descriptor
>>   * @dev: Pointer to a physical device struct
>> + * @kvm: Pointer to struct kvm if device belongs to a KVM VM
>>   * @id: Output ID number to return to userspace for this device
>>   *
>>   * A successful bind establishes an ownership over the device and returns
>> @@ -216,7 +217,8 @@ void iommufd_device_destroy(struct iommufd_object *obj)
>>   * The caller must undo this with iommufd_device_unbind()
>>   */
>>  struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
>> -					   struct device *dev, u32 *id)
>> +					   struct device *dev, struct kvm *kvm,
>> +					   u32 *id)
>
> I thought we were trying to get away from struct kvm?
>
> https://lore.kernel.org/all/adf29Rn7q9Db0hxc@google.com/
>
> Ie this should be a 'struct file *kvm_fd'
>
> ?
>
> Though I am wondering how practical it is to do this at this moment :\
>

Should we also switch 

modified   drivers/vfio/vfio.h
@@ -22,8 +22,8 @@ struct vfio_device_file {
 
 	u8 access_granted;
 	u32 devid; /* only valid when iommufd is valid */
-	spinlock_t kvm_ref_lock; /* protect kvm field */
-	struct kvm *kvm;
+	spinlock_t kvm_ref_lock; /* protect kvm_file */
+	struct file *kvm_file;
 	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock */
 };
 
@@ -88,7 +88,7 @@ struct vfio_group {
 #endif
 	enum vfio_group_type		type;
 	struct mutex			group_lock;
-	struct kvm			*kvm;
+	struct file			*kvm_file;
 	struct file			*opened_file;
 	struct blocking_notifier_head	notifier;
 	struct iommufd_ctx		*iommufd;

ie,
KVM_CREATE_DEVICE with KVM_DEV_TYPE_VFIO still use kvm->users_count,
KVM_DEV_VFIO_FILE_ADD -> will switch to get_file(kvm->_file);
and VFIO_DEVICE_BIND_IOMMUFD -> will switch to get_file(df->kvm_file)

> Maybe ask Paolo how his series is going?
>
>>  {
>>  	struct iommufd_device *idev;
>>  	struct iommufd_group *igroup;
>> @@ -266,6 +268,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
>>  	if (!iommufd_selftest_is_mock_dev(dev))
>>  		iommufd_ctx_get(ictx);
>>  	idev->dev = dev;
>> +	idev->kvm = kvm;
>
> If we do that then I'd take a file refcount here ^^^
>
> And then put it back when the idev is freed
>
> That makes the lifecycle robust.
>
> Jason

-aneesh
