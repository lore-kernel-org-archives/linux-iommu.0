Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDE93AE6F6
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772562962; cv=none; b=XaV2T0fESV8MAII1UvRBDXMS9ulNZSszT6sVpV63I3zeBCJ8FRiAI3/5KN2zAVADvZSCGhaQ3cKKET3oFdL+NWZsPqjJ5Kbn+jQFGebgamwBlYtlsURRwaaxVkI4jVD5tPef7hN7oW+ol4TlTIexU2B1MSs2ys0mwzBHVFxa0/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772562962; c=relaxed/simple;
	bh=wcbTJ+dxtc43pshEWpYW4YZDVIGTHhabXjI58Bwu58I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+7+YDoApdM6cmFq6k6tf7nVcM0IfFZLUcfS3W4ibd6SQnsxK6DJ2xpAFs/+osFcZdg+7t+7q7mxmrTJlaaqFCcj0otfKBQ4c46jhnY+yOGEAfy4WJoESP4+b6qTOqHgAbRBVBNWUduZ1XomvseWbHfz043QtGD4LjDvYvfIdZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0lEs+DDE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0lEs+DDE"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ae523d54d2so99905ad.1
        for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 10:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772562959; x=1773167759; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=trHHJ83pdpjgNSAR80l6JTOyQ+mJmW3s5tLBspjTXe4=;
        b=0lEs+DDEqwdD9HG4DLN7pK0pGLiOfa09mRuicOqVAwDKje346/xOzcQ1sNs1frC+po
         NUcyro9c0PXhiVQEVdcQpb2x7IZacpvoe861+OnJxBaQ3dkmSt/b88fudzGOq1yoCGcY
         J5lnrZov0Kdkno2rYimjIWKY9jbZHX0LR5bJg4oLQwif8M7rBUUwuPeqe0oqQOk4kVBe
         6goDXtRAsg7cFxS/DJPLnHypsq+eopgdQMUmPs0KoeP9YcJ6dLtIX9/2CN0GBagsxibs
         KbFlso+CBf/QNlp92Cqer2SxulDezy5yrFgTufBR0yHDaukAkhJuS2XUlH7yVmqFckvd
         zYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772562959; x=1773167759;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=trHHJ83pdpjgNSAR80l6JTOyQ+mJmW3s5tLBspjTXe4=;
        b=NpXCHK215EDxm3hElPKnCW4lJgss8Wkn3Thd59gIk53ERtsDYpwTF4l9YDD9c1ZtbV
         0tvFlHWyo352yzVLhmj9uSwrVmE3Z3sc8XRoloQ2WjFFBsaIFqBRekyYBI1E2gg/lpO1
         WA1MifGdExeZz761eKjJ6TfCmvpfokTiZVjANx1r80DwnIRhSG9aMbGq5gHnwiqooaR0
         wUeYmrSH/SxAx4RcZAkfiDMWpY+2borzfArXQ5hL198XIF8pH25gP0oIeb19E+itzvRG
         0+YMJjO9j+PkQIYlSPcxi7bGZNNVUsRAqUGK93e+QuGPAfWVlSm1by+EIHOjcMXwNrqr
         Ea4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKo4ovOfMFBLDj1bUnMptQvMFg9ptwz6SbMgs7q2AG37kfSd8Bz5QoFYeAQL0lUJzWVbhFJw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzw7FLVTW/+VT5jhM2luAVpbhoTPMpHNyoSbqHE8fmYGUAGdp6R
	CrVDf6DjhB9ooNk3pEEHBZpG0L9nA4UYj/Wxdl9UTvi+GupZFNhs3nMT2eej41R3YA==
X-Gm-Gg: ATEYQzwBOk+DokDcl/aOwizeGdsbfFL8UlozJGOtniG8GH7A2UUZ52ZgmVyduVcx0q3
	vst0p8yYo2qrF87pc/FJulGQYyRcSw0KP3WODa1coDm5ZwnvoHMmANDU+e/gdkctX030fyvEORK
	r0wCuCcZ0VnGC3OKavdcrBTsjC7dX6Qnuezc55p/7qs+YRt8DkdPRZGTEbk/Eb9Wia95je8qjBb
	t/1zqYuJWpo2QanOASUP3N7ONsMkra+Rm+qKdv6wmcIS2L23oa3Q7yKPsLGWZXo2vMxNzYxZD8D
	xGmhISsCKofSze+u/eYmKIIrQXyZ4ocnr2zck70457iq3Kk9+EH8mXFY7n4T4GOrjBu4XxndZjA
	EO8UzhVEdCNyatcv8dTAlwxHRTZgM1UP4WqgRfnlI5duMApUfqZu1MKtfi7u0htn9vK/fQDRLmf
	27Pq5JxJULtySnyYs2MXXd4Jq0atB7INIVnbA9xTZxUMxI+wC2yL3iL3VZoyBsYw==
X-Received: by 2002:a17:902:f712:b0:2ae:4f95:df55 with SMTP id d9443c01a7336-2ae4f95e48dmr4767015ad.25.1772562958685;
        Tue, 03 Mar 2026 10:35:58 -0800 (PST)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae5229cd5esm80423705ad.21.2026.03.03.10.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 10:35:58 -0800 (PST)
Date: Tue, 3 Mar 2026 18:35:54 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 13/14] vfio/pci: Preserve the iommufd state of the vfio
 cdev
Message-ID: <mxemy34aaxtwly3ugve5kfy5is3dsgnnrmjzvrmnxq2nvhcmgw@ghnjvhgdodth>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-14-skhawaja@google.com>
 <idfs4bm5tib5nfe7i6rrm7hxsvhybbidfxtxl4jx3pamkisdon@zaljkqd66cwq>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <idfs4bm5tib5nfe7i6rrm7hxsvhybbidfxtxl4jx3pamkisdon@zaljkqd66cwq>

On Tue, Feb 17, 2026 at 04:18:08AM +0000, Ankit Soni wrote:
>On Tue, Feb 03, 2026 at 10:09:47PM +0000, Samiullah Khawaja wrote:
>> If the vfio cdev is attached to an iommufd, preserve the state of the
>> attached iommufd also. Basically preserve the iommu state of the device
>> and also the attached domain. The token returned by the preservation API
>> will be used to restore/rebind to the iommufd state after liveupdate.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/vfio/pci/vfio_pci_liveupdate.c | 28 +++++++++++++++++++++++++-
>>  include/linux/kho/abi/vfio_pci.h       | 10 +++++++++
>>  2 files changed, 37 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
>> index c52d6bdb455f..af6fbfb7a65c 100644
>> --- a/drivers/vfio/pci/vfio_pci_liveupdate.c
>> +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/liveupdate.h>
>>  #include <linux/errno.h>
>>  #include <linux/vfio.h>
>> +#include <linux/iommufd.h>
>>
>>  #include "vfio_pci_priv.h"
>>
>> @@ -39,6 +40,7 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>>  	struct vfio_pci_core_device_ser *ser;
>>  	struct vfio_pci_core_device *vdev;
>>  	struct pci_dev *pdev;
>> +	u64 token = 0;
>>
>>  	vdev = container_of(device, struct vfio_pci_core_device, vdev);
>>  	pdev = vdev->pdev;
>> @@ -49,15 +51,32 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>>  	if (vfio_pci_is_intel_display(pdev))
>>  		return -EINVAL;
>>
>> +#if CONFIG_IOMMU_LIVEUPDATE
>> +	/* If iommufd is attached, preserve the underlying domain */
>> +	if (device->iommufd_attached) {
>> +		int err = iommufd_device_preserve(args->session,
>> +						  device->iommufd_device,
>> +						  &token);
>> +		if (err < 0)
>> +			return err;
>> +	}
>> +#endif
>> +
>>  	ser = kho_alloc_preserve(sizeof(*ser));
>> -	if (IS_ERR(ser))
>> +	if (IS_ERR(ser)) {
>> +		if (device->iommufd_attached)
>> +			iommufd_device_unpreserve(args->session,
>> +						  device->iommufd_device, token);
>> +
>
>To use iommufd_device_preserve()/iommufd_device_unpreserve(),
>looks like the IOMMUFD namespace import is missing here —  MODULE_IMPORT_NS("IOMMUFD");
>
>-Ankit

Agreed, I will add it to this file in v2.
>
>>  		return PTR_ERR(ser);
>> +	}
>>
>>  	pci_liveupdate_outgoing_preserve(pdev);
>>
>>  	ser->bdf = pci_dev_id(pdev);
>>  	ser->domain = pci_domain_nr(pdev->bus);
>>  	ser->reset_works = vdev->reset_works;
>> +	ser->iommufd_ser.token = token;
>>
>>  	args->serialized_data = virt_to_phys(ser);
>>  	return 0;
>> @@ -66,6 +85,13 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>>  static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
>>  {
>>  	struct vfio_device *device = vfio_device_from_file(args->file);
>> +	struct vfio_pci_core_device_ser *ser;
>> +
>> +	ser = phys_to_virt(args->serialized_data);
>> +	if (device->iommufd_attached)
>> +		iommufd_device_unpreserve(args->session,
>> +					  device->iommufd_device,
>> +					  ser->iommufd_ser.token);
>>
>>  	pci_liveupdate_outgoing_unpreserve(to_pci_dev(device->dev));
>>  	kho_unpreserve_free(phys_to_virt(args->serialized_data));
>> diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_pci.h
>> index 6c3d3c6dfc09..d01bd58711c2 100644
>> --- a/include/linux/kho/abi/vfio_pci.h
>> +++ b/include/linux/kho/abi/vfio_pci.h
>> @@ -28,6 +28,15 @@
>>
>>  #define VFIO_PCI_LUO_FH_COMPATIBLE "vfio-pci-v1"
>>
>> +/**
>> + * struct vfio_iommufd_ser - Serialized state of the attached iommufd.
>> + *
>> + * @token: The token of the bound iommufd state.
>> + */
>> +struct vfio_iommufd_ser {
>> +	u32 token;
>> +} __packed;
>> +
>>  /**
>>   * struct vfio_pci_core_device_ser - Serialized state of a single VFIO PCI
>>   * device.
>> @@ -40,6 +49,7 @@ struct vfio_pci_core_device_ser {
>>  	u16 bdf;
>>  	u16 domain;
>>  	u8 reset_works;
>> +	struct vfio_iommufd_ser iommufd_ser;
>>  } __packed;
>>
>>  #endif /* _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H */
>> --
>> 2.53.0.rc2.204.g2597b5adb4-goog
>>

Thanks for looking at this.

Sami
