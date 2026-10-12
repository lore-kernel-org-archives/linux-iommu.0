Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D9243DA53;
	Mon, 12 Oct 2026 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794000; cv=none; b=a2063VkuZokYg0uq3a77H/EuxfKZh+7Y+TuFLizH198nHPli+s7rtTZtKeS7IJjudsuGJqkshP5rX2c3+GnZ4Nxye5H18aNslFbmK8C5HLeabyoXhc33Y5md+kKlkOb1V9nXG9N85dPVKcy1kebMCp+IKqFRPiEcpPh9keFNMTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794000; c=relaxed/simple;
	bh=d24JUMEgq/L4Pu19uiMCeWUmaAqyRlnqjGMteRDvmNA=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aSccAJs/AwWhHbJrFg22zMeL/hefhzhOyf8UY0f/8byZQ0/CMdynfuT6dojaorbv7BbZFicCPKQUp3AdzwDJinkEJ7uka3H8SjrAJSHVpCVPLSiBZNrXffwScVkHcf72XKMooK74na42CTp6rJ+bCciU/JPGadHzM/Q3aOYwFu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqR8atw5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqR8atw5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308981F0089B;
	Mon, 12 Oct 2026 08:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791793998;
	bh=54DUM2oKjZAclxAxVUj2EX0vltXxqlpAry0veMiF1aA=;
	h=From:To:Subject:In-Reply-To:References:Date;
	b=CqR8atw5Xs7/N/SDbpLDf0ojYxTSK85Gl0xM5AWq8EuA5ieRYqCDaf/Ii3Ydra7sS
	 fmHlSyQV8e4WH03nDAygFO9f4Zmmh0QtYZdxieTepC+fpclV+4K63o2waDhNUZOpkT
	 TPRQbp3slcnqdpd5KnrLcgj4tJDQ9djsmQvHEKF0h29ymoI+J4Th8YUgGlEYTiPxwS
	 jiExllP2vWHbI2MXS6WUOYAWKuKjdugrD3u509vxIhzCPbtLXqEP6DfadftcHO3fT4
	 uIE0Ad3G/U7sQrX7ZD/lbb8xgnSGHWpcLtx5UmyWOBp7PVtb1CUBYR0QcPz+6LFSRc
	 mQGJ7rzF2Xi4A==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: sashiko-reviews@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
	iommu@lists.linux.dev
Subject: Re: [PATCH v7 07/16] iommufd/device: Associate KVM file pointer
 with iommufd_device
In-Reply-To: <sashiko-outbox-163681@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-8-aneesh.kumar@kernel.org>
 <sashiko-outbox-163681@kernel.org>
Date: Mon, 12 Oct 2026 14:03:13 +0530
Message-ID: <yq5a5wz75nee.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] iommufd: UAF of kvm_file due to iommufd_device outliving VFIO unbind
> --
>
> commit ddde31c06624779bad69fb77ae7b9503b553dacc
> Author: Shameer Kolothum <skolothumtho@nvidia.com>
>
> iommufd/device: Associate KVM file pointer with iommufd_device
>
> TSM vDevice support needs access to the KVM associated with a VFIO device
> after the device has been bound to iommufd. Extend iommufd_device_bind() to
> accept the device's KVM file and store it in the iommufd_device.
>
>> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
>> index a664c70a6fe73..f99f7bee2e774 100644
>> --- a/drivers/iommu/iommufd/device.c
>> +++ b/drivers/iommu/iommufd/device.c
> [ ... ]
>> @@ -308,7 +309,9 @@ static int iommufd_bind_noiommu(struct iommufd_device *idev)
>>   * The caller must undo this with iommufd_device_unbind()
>>   */
>>  struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
>> -					   struct device *dev, u32 *id)
>> +					   struct device *dev,
>> +					   struct file *kvm_file,
>> +					   u32 *id)
>>  {
>>  	struct iommufd_device *idev;
>>  	int rc;
>> @@ -319,6 +322,8 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
>>  
>>  	idev->ictx = ictx;
>>  	idev->dev = dev;
>> +	/* VFIO holds the file reference while the device is open. */
>> +	idev->kvm_file = kvm_file;
>
> [Severity: High]
> Does this code introduce a use-after-free regression for kvm_file when a
> concurrent ioctl is accessing the device?
>
> If an untrusted user thread executes an ioctl that calls iommufd_get_device(),
> it will increment idev->obj.users to 2.
>
> If another thread concurrently closes the VFIO device fd, it calls
> vfio_df_unbind_iommufd() which leads to iommufd_device_unbind() and then
> iommufd_object_destroy_user().
>
> Because users is 2, iommufd_object_remove() will return -EBUSY:
>
> drivers/iommu/iommufd/main.c:iommufd_object_remove() {
>         ...
>         if (!refcount_dec_if_one(&obj->users)) {
>                 ret = -EBUSY;
>                 goto err_xa;
>         }
>         ...
> }
>
> The unbind operation ignores this error, leaving the idev alive:
>
> drivers/iommu/iommufd/iommufd_private.h:iommufd_object_destroy_user() {
>         ...
>         ret = iommufd_object_remove(ictx, obj, obj->id, REMOVE_WAIT);
>         WARN_ON(ret);
> }
>
> The VFIO device then drops its KVM reference during the close process, freeing
> the kvm_file. When the first thread resumes, will it access the freed kvm_file
> stored here?
>

This is the VFIO device fd close stack:

  vfio_device_fops_release()
    vfio_df_unbind_iommufd()
      vfio_df_close()
        vfio_df_device_last_close()
          vfio_df_iommufd_unbind()
            vfio_iommufd_physical_unbind()
              iommufd_device_unbind()
                iommufd_object_destroy_user()
                  iommufd_object_remove(..., REMOVE_WAIT)
                    iommufd_object_dec_wait() /* timeout: -EBUSY */
                  WARN_ON(ret)
      vfio_device_put_kvm()
        fput(device->kvm)

IIUC, this is a real issue: in this case, we neither remove the idev
object from the xarray nor invoke its destroy callback. Is that correct?


After the REMOVE_WAIT timeout, unbind returns without removing the
device from the xarray. VFIO close then continues, but the final ioctl
put by the thread that called iommufd_get_device() only decrements
users and wait_cnt; it does not retry destruction. The surviving idev
also holds an iommufd file reference, so closing the userspace iommufd
descriptor cannot complete the cleanup.

-aneesh
