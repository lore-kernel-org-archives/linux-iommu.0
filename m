Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E34B43B6C1;
	Fri, 25 Sep 2026 05:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790315404; cv=none; b=RhT5r2NWWZnHLgeFmAy6tTrQ8OdlDfk62VAf22HUbagU77rXuz5Z1cO5yPgJL4SE+9ywKy0hD5p6bmhenLi5u12CYvIpMSP9wa3XNJ3YL6bdttMbK+7BMrEXwYtzPzM6VxEymkjnMUcwei7KgulEhFXCUncpSzuVdezBkBmIO8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790315404; c=relaxed/simple;
	bh=KyxvyflDAvHFnwAmHvQz8sED4l9OKQADvuTa5jIm/hY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U0c7leiCtLCcBDdygufJwwWaasXQ1Gy+Sq5KB8qQhTqM0/Hndc4i4cTJDFqnhbongN5wwyJqP4zf+xZoVQn7dpwwL70SH9Onxc6FG3ya7lIZFxEEee/KxotyLAs5HC9ZnGlF7/Xisg34BFd/W9Gs+EJeJsHJHbsQSDXhcPEDWmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6wYyQv3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6wYyQv3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2AC1F000FF;
	Fri, 25 Sep 2026 05:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790315403;
	bh=0VGNRtAzo+DnQT+W8D5ggxSnqtP33s8TLxLi6quFHLo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Q6wYyQv3lDAKok3ZxNqfOo+ep3YGVqCwZXv6On0tpax8ax8tQVv0DutXxACRjfbF0
	 Yq6pp3YhmdMapesa65ErD2O9gbpLc9rQ+wwVhV0XZdEUhlrMvgodvj2LfobsxWHua6
	 NHh1yHkGjFaOgtnD5O4rJQPoealu2/SZ6HNIh1/rONsM0P6LdIiU13dXJiCC4wONpA
	 pIm8E8qcHz0X7HbJa0AIX0xGcL6dZ/wO22gvU02/L5nVkxpwf4gyVglsB+HdL7YCGc
	 /PfHhexbRDQKchru3mcqbqdsrn/VJLUhHQOSKFON4lRtZ54WzduXZ9UNsrEefvwSwu
	 4Y/VHJcC062rg==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: "Tian, Kevin" <kevin.tian@intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: RE: [RFC PATCH v6 02/11] vfio: cdev: Reject duplicate bind before
 updating KVM file
In-Reply-To: <CO1PR11MB483540981ADED57ABF6EB4878C812@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-3-aneesh.kumar@kernel.org>
 <CO1PR11MB483540981ADED57ABF6EB4878C812@CO1PR11MB4835.namprd11.prod.outlook.com>
Date: Fri, 25 Sep 2026 11:19:54 +0530
Message-ID: <yq5aik3tkhh9.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Tian, Kevin" <kevin.tian@intel.com> writes:

>> From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> Sent: Thursday, September 17, 2026 10:02 PM
>> 
>> The cdev path only supports one bound/open device fd, but
>> VFIO_DEVICE_BIND_IOMMUFD only checked the per-file access_granted flag
>> before capturing the KVM file reference. A second fd for the same device
>> could therefore replace device->kvm_file, fail later in vfio_df_open()
>> because open_count is already nonzero, and then clear the active KVM
>> association during error cleanup.
>> 
>> Reject the bind while holding dev_set->lock if the device is already
>> open, matching the existing cdev single-open rule before touching the
>> device-wide KVM state.
>> 
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>
> could you send it out as a separate fix?
>

Sure, I'll send it as a separate fix.

-aneesh
