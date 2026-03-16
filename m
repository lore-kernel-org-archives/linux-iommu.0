Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4666B78F4A;
	Mon, 16 Mar 2026 05:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773640067; cv=none; b=miSOYz3nxXcEF8eU2btu2CM2sGKl3LVi7ft5mj9VcgS1lV+aDm+Mnr1V+4Dvn3o3UWOBkoTyLl5HYUFPKdYsWolQczOysLE5+8u2+yTtrWh+EJGGt3dMK6KiLuCTA8XgIXJAXV8INPDXSUX/87Wr9dZx7CokNQFCIDX+PyCyUtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773640067; c=relaxed/simple;
	bh=+BbWevT0Swja6eb2FmIWQ32cxIjaS3zQmKU+0N869yU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FgTYmChsmPEOxiRX2N5TpFFEnOZjDySC5ZUFZ4lpIS2lK6FtbMXtLDRBuyEiGqbmY9PgN1lnvJtNBHquiAMVEAKbrufRuSsxc7cQNXxXIx0qHpxYM126owD/oh0VgdfSNdSR7YoPwv9YjSSPcWeLxfqw9e0ZAIEfzyBJxeoUg6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRAZ+9S2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRAZ+9S2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39C5C19425;
	Mon, 16 Mar 2026 05:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773640066;
	bh=+BbWevT0Swja6eb2FmIWQ32cxIjaS3zQmKU+0N869yU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QRAZ+9S2ToIhD4En/rF/Fav+iFK0Gqf7O41v2eKfD6R6JhNM0/fsyMo9wiQxpfuqP
	 6u+UOBsbpaS9LIPlDF7HEI3LB1HBgxAsNzpPM8j94DvdySmc3/YgupF6x1xqXhR8G6
	 v6wq0Ds+vY0I4E3Zc+c5wONPJg8wocVg5r9CjojN9XwbTHO5L3KrwzYtsK+vvmELWy
	 ADkVF0EOK9axLrx4iNl5LRByS5vxPmWx7VVw3/Hw412e4hX9tyMuWsWIYSA+DZGQu8
	 qDK3kF+j3JZRY5kXRWDai3DG4t2CFgy0y6n4+dL1oyqLhPISIoN8JGpAAYxyN5Bl/b
	 VDmIaqi5RCFsg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 3/3] iommufd/vdevice: add TSM guest request ioctl
In-Reply-To: <20260313184957.GP1704121@ziepe.ca>
References: <20260309111704.2330479-1-aneesh.kumar@kernel.org>
 <20260309111704.2330479-4-aneesh.kumar@kernel.org>
 <20260313184957.GP1704121@ziepe.ca>
Date: Mon, 16 Mar 2026 11:17:37 +0530
Message-ID: <yq5a4img8gw6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Mon, Mar 09, 2026 at 04:47:04PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> +/**
>> + * struct iommu_vdevice_tsm_guest_request - ioctl(IOMMU_VDEVICE_TSM_GUEST_REQUEST)
>> + * @size: sizeof(struct iommu_vdevice_tsm_guest_request)
>> + * @vdevice_id: vDevice ID the guest request is for
>> + * @scope: scope of tsm guest request
>> + * @req_len: the blob size for @req_uptr, filled by guest
>> + * @resp_len: the blob size for @resp_uptr, filled by guest
>> + * @req_uptr: request data buffer filled by guest
>> + * @resp_uptr: response data buffer
>> + */
>
> This needs a much better kdoc.
>
> Refer to specs that define this.
>
> Explain WTF scope is
>
>> +struct iommu_vdevice_tsm_guest_request {
>> +	__u32 size;
>> +	__u32 vdevice_id;
>> +	__u32 scope;
>> +	__u32 req_len;
>> +	__u32 resp_len;
>
> do not leave implicit padding, add a reserved, and check it is 0
>
> Jason
 
How about this change?

modified   drivers/iommu/iommufd/tsm.c
@@ -94,6 +94,9 @@ int iommufd_vdevice_tsm_guest_request_ioctl(struct iommufd_ucmd *ucmd)
 		.resp_len = cmd->resp_len,
 	};
 
+	if (cmd->__reserved)
+		return -EOPNOTSUPP;
+
 	vdev = iommufd_get_vdevice(ucmd->ictx, cmd->vdevice_id);
 	if (IS_ERR(vdev))
 		return PTR_ERR(vdev);
modified   include/uapi/linux/iommufd.h
@@ -1370,11 +1370,27 @@ struct iommu_hw_queue_alloc {
  * struct iommu_vdevice_tsm_guest_request - ioctl(IOMMU_VDEVICE_TSM_GUEST_REQUEST)
  * @size: sizeof(struct iommu_vdevice_tsm_guest_request)
  * @vdevice_id: vDevice ID the guest request is for
- * @scope: scope of tsm guest request
- * @req_len: the blob size for @req_uptr, filled by guest
- * @resp_len: the blob size for @resp_uptr, filled by guest
- * @req_uptr: request data buffer filled by guest
- * @resp_uptr: response data buffer
+ * @scope: Scope classification of the guest request, one of enum
+ *         pci_tsm_req_scope values accepted by pci_tsm_guest_req()
+ * @req_len: Size in bytes of the input payload at @req_uptr
+ * @resp_len: Size in bytes of the output buffer at @resp_uptr
+ * @__reserved: Must be 0
+ * @req_uptr: Userspace pointer to the guest-provided request payload
+ * @resp_uptr: Userspace pointer to the guest response buffer
+ *
+ * Forward a guest request to the TSM bound vDevice. This is intended for
+ * guest TSM/TDISP message transport where the host kernel only marshals
+ * bytes between userspace and the TSM implementation.
+ *
+ * @scope limits requests to TDISP state management, or limited debug.
+ * Requests outside the allowed scope are rejected.
+ *
+ * The request payload is read from @req_uptr/@req_len. If a response is
+ * expected, userspace provides @resp_uptr/@resp_len as writable storage for
+ * response bytes returned by the TSM path.
+ *
+ * The ioctl is only suitable for commands and results that the host kernel
+ * has no use, the host is only facilitating guest to TSM communication.
  */
 struct iommu_vdevice_tsm_guest_request {
 	__u32 size;
@@ -1382,6 +1398,7 @@ struct iommu_vdevice_tsm_guest_request {
 	__u32 scope;
 	__u32 req_len;
 	__u32 resp_len;
+	__u32 __reserved;
 	__aligned_u64 req_uptr;
 	__aligned_u64 resp_uptr;
 };
