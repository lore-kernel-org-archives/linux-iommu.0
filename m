Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793570103;
	b=kwVNV2XpnS3n+8zTGA2KNwCCZJrWvC0gzH2eYwfgsC6M8y2XY08J6hr/SVGVW88XEAn+
	 S7vXIIBr3s/SKc+zo1jOJXUtr+Pp6fgPbZccJOBeyivOI/nbNumbgEYvHetByKxMJTktv
	 6u6AqCJQ6naf53kzEXXFci8x3+CWzv4AEu3sgNwxf09n8lAHM7d2xIoEzuOVTxeE4fyRv
	 XqHA2PN79NpwEvvpkeEYgMMO3Rr2G/CQVLQLvGKfOP7ALiCJDM+g4IjvqCCep1J1UShpt
	 FPv/NoUCGQaLey1jY5yt1ybpOqfEBkHxPYameM89dfjeEZAmLkiqwBMOHYA720iGXVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793570103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=pH9FDk8PhOZqTZYMJF9VQ6qq2IvSDAE/glr1M5Bsspg=;
	b=5L+f/AIwl2ED393kCyvcNzM5641mxjDNGRiOgrqUVkoEFZdGoBvumf0bbQg0GAAZnQX7
	 SCOF2TLZJze9ptuDDmXTx0uzxFwnGnIJiRwQZu2rbCmuOFefZ1v+DmLIChQRb/v8CKHof
	 iH/Mo6e187F7ER3SPiGxqahtZNEI3o69fqa8UIl9cdMuwymhnBNJJ3sXgMpY4WVES78+D
	 nKMEcM+ciBI95TaXGDQjA2LXKGzrWC1YEeM6FnUNMb7s/0pBTa8pSh8D8U6JtfUnkki2G
	 xvW+0kFG81sArn40KsIJeg1auOlGA7pkbxsk+HWjSF/mOMNgk5PereUFnZAkCux9cKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gnuzhMsL;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC59606A327
	for <iommu@lists.linux.dev>; Sun,  1 Nov 2026 21:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DC59606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gnuzhMsL
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e9f6a16afcso49905ad.1
        for <iommu@lists.linux.dev>; Sun, 01 Nov 2026 13:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793570103; x=1794174903; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pH9FDk8PhOZqTZYMJF9VQ6qq2IvSDAE/glr1M5Bsspg=;
        b=gnuzhMsLTz9dMMGheHTBUZAkZPitAvXrhojr/F+3656Kn/TLbXUWHMtKdzyUnpqqdz
         dw2AI0ot2hiU7KAPcBCAlsRXrKSsw8FhAfwELziOFgOVrhrkAoAcWMjBq2ZsWq4/pTia
         ceG98gXoqgLt5A0/mFvb5xi6E7vI3wXCNdx8RUNxAzrPFv4IT6O63eTAlMR4R1wgINYT
         G8wds3Au+Vp1rQAOBkKiWFaHYPePZ6e+njyf6S2sJgEfo4xKihTyAqT8C10+kW8zj9nA
         0nlwHPv6TSpDxdEXbDwNFCloIsXivXx0FBn75FCEaS+X5QkNLPhkz3+TECdteQ97cjF0
         3Qfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793570103; x=1794174903;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pH9FDk8PhOZqTZYMJF9VQ6qq2IvSDAE/glr1M5Bsspg=;
        b=lR5vYxrw/mAQEq3Wt91yNLRd/Wt5YY9DHdtsIAfBqtHsrIWkGu6JaAltgeWJqwdt3O
         fJaeA+6oKVqMdI3Fd9KrOQLL0bEb6H+BihlJuv3DKibj5F+mGYgXGFs1PvRnrfkPCCwd
         KzI4L4B6grIwsGAEsJUDRK6pQV0q8mkKe1xXtofhMrpguabTzY3Z+GJslv86brLDLkQy
         YEjvFdna7XGIMflCEuC34UmpESzkj22xBygo8VD/IY5Akc+mNk17+O/yuRQqz3qsVzsd
         vKQoZKCX3DI0JL9uYC22ScbVLhoD9g3IACXGGspVgDUs7iOtHba91miyTTwxGpLC0Z4e
         J1+w==
X-Forwarded-Encrypted: i=1; AKwUvBxEI6SyEYCJEi4/ivYViomEgNDhD+4pHSPgOoUrPIP8/1+LyR6wmqCpFALSiCvHYI87EeRNMA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9tJCE/1nDxzmIuzOuMGxCvYmrsZzTyAnQbbZV+bRINdolc+aDG
	yStiZdv9Ztbr3CXiTz71fB75W6RSkQSslFXjJOPzPfjKJFm4pDAZ2MhwPIKMnDeu8A==
X-Gm-Gg: AYBFou13uvI92U8752kwGy7uTqbGwIA26YqcF1eqhg5zMEPGuoUdbSi2J1mhzkbRBui
	nSkhJ85Bi6E1eMkb86CM5rG8vrWySKZpgmx/18qALCgT0lykhdcLpHVDi6H9s6lKx6PBIUU6BtX
	EyIupqJiFZ8v2KCtc1rGOXZxpxhfOEYlNndZD0JWgjhiYqdka3lvFHQDnvW1Yqp/f1vUspOHD4g
	23EqzbnBzFozav7wriXthVS+8KoAw0ez8cOVylwD+Trg8Onihhq4ZKyGfCvIpHRw56wn2Q2Axr+
	Z39zEpvcW9H4mzY4f3X1ecvCY5616dJTC4CcLnTrd+nnKg9Miz1N/gxlW5EGE9HHPhXVD7/98ej
	QvKc1qyzaaLUuGTraHwS8mlOHzzk62Ydf0ZXQPfM/O2YoIfUUSMaSyG8Z8k+aIHcnhUizmm28uq
	491j9v/LlDu7egeqbNu2D7o3YUbfMXqctdzB22K5FtZrjnd6Yvkq6GX5ElfAZpWdhN0DwcHK2W6
	9j/Q7E6ZIZl3YfvocAx0unYlXzXgnrQi8/17bv9yHHN5l01uzKkhDgQWtpguXEY4bjMjf6oHCec
	hCfaudbW6i55lRmyRltX+51DDbVWmXFADm+QJA00K4hS8TWjyJgQ85qKU0HbWBZDtRZqBoUHGp2
	svhvS4tfOMMco+a6MtHwAcZcMQiS8hJmsvkEeof0G5Q==
X-Received: by 2002:a17:902:e5cb:b0:2ea:1fa0:8068 with SMTP id d9443c01a7336-2eb1ecbd412mr17712775ad.16.1793570101892;
        Sun, 01 Nov 2026 13:55:01 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9bc6f7sm15137855a91.16.2026.11.01.13.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 13:55:00 -0800 (PST)
Date: Sun, 1 Nov 2026 21:54:57 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>, 
	Pranjal Shrivastava <praan@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Ankit Soni <Ankit.Soni@amd.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 17/18] vfio/pci: Preserve the iommufd state of the
 vfio cdev
Message-ID: <aubO8llyTiUc38u2@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-18-skhawaja@google.com>
 <2574cbc8-8c2b-4458-9fcd-b077190084a3@linux.intel.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2574cbc8-8c2b-4458-9fcd-b077190084a3@linux.intel.com>

On Sat, Oct 31, 2026 at 01:56:12PM +0800, Baolu Lu wrote:
>On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
>>If the vfio cdev is attached to an iommufd, preserve the state of the
>>attached iommufd also. Basically preserve the iommu specific state of
>>the device and also the attach iommu HW unit.
>>
>>Once the device and its iommufd attachment is preserved, it cannot be
>>detached or attached to another IOAS until it is unpreserved.
>>
>>Reviewed-by: Pranjal Shrivastava <praan@google.com>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  drivers/vfio/device_cdev.c             | 10 +++++++++
>>  drivers/vfio/pci/vfio_pci_liveupdate.c | 28 ++++++++++++++++++++++++--
>>  2 files changed, 36 insertions(+), 2 deletions(-)
>>
>>diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
>>index b818aab92f76..4eb7ffd489bd 100644
>>--- a/drivers/vfio/device_cdev.c
>>+++ b/drivers/vfio/device_cdev.c
>>@@ -284,6 +284,11 @@ int vfio_df_ioctl_attach_pt(struct vfio_device_file *df,
>>  	}
>>  	mutex_lock(&device->dev_set->lock);
>>+	if (iommufd_device_is_preserved(device->iommufd_device)) {
>>+		ret = -EBUSY;
>>+		goto out_unlock;
>>+	}
>>+
>>  	if (attach.flags & VFIO_DEVICE_ATTACH_PASID)
>>  		ret = device->ops->pasid_attach_ioas(device,
>>  						     attach.pasid,
>>@@ -342,6 +347,11 @@ int vfio_df_ioctl_detach_pt(struct vfio_device_file *df,
>>  	}
>>  	mutex_lock(&device->dev_set->lock);
>>+	if (iommufd_device_is_preserved(device->iommufd_device)) {
>>+		mutex_unlock(&device->dev_set->lock);
>>+		return -EBUSY;
>>+	}
>>+
>>  	if (detach.flags & VFIO_DEVICE_DETACH_PASID)
>>  		device->ops->pasid_detach_ioas(device, detach.pasid);
>>  	else
>>diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
>>index f0ea37d98696..fb2141ee8942 100644
>>--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
>>+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
>>@@ -106,6 +106,7 @@
>>  #include <linux/errno.h>
>>  #include <linux/file.h>
>>+#include <linux/iommufd.h>
>>  #include <linux/kexec_handover.h>
>>  #include <linux/kho/abi/vfio_pci.h>
>>  #include <linux/liveupdate.h>
>>@@ -114,6 +115,8 @@
>>  #include "vfio_pci_priv.h"
>>+MODULE_IMPORT_NS("IOMMUFD");
>>+
>>  static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
>>  					     struct file *file)
>>  {
>>@@ -154,15 +157,25 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>>  	struct vfio_pci_core_device_ser *ser;
>>  	struct vfio_pci_core_device *vdev;
>>  	struct pci_dev *pdev;
>>-	int ret;
>>+	u64 iommufd_token;
>>+	int ret = 0;
>
>nit: no need to initialize ret.

I will fix this.
>
>>  	vdev = container_of(device, struct vfio_pci_core_device, vdev);
>>  	pdev = vdev->pdev;
>>-	ret = pci_liveupdate_preserve(pdev);
>>+	mutex_lock(&device->dev_set->lock);
>>+	ret = iommufd_device_preserve(args->session,
>>+				      device->iommufd_device,
>>+				      &iommufd_token);
>>+	mutex_unlock(&device->dev_set->lock);
>>+
>>  	if (ret)
>>  		return ret;
>>+	ret = pci_liveupdate_preserve(pdev);
>>+	if (ret)
>>+		goto err_iommufd_unpreserve;
>>+
>>  	ser = kho_alloc_preserve(sizeof(*ser));
>>  	if (IS_ERR(ser)) {
>>  		ret = PTR_ERR(ser);
>>@@ -177,6 +190,12 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>>  err_unpreserve:
>>  	pci_liveupdate_unpreserve(pdev);
>>+
>>+err_iommufd_unpreserve:
>>+	mutex_lock(&device->dev_set->lock);
>>+	iommufd_device_unpreserve(args->session,
>>+				  device->iommufd_device);
>>+	mutex_unlock(&device->dev_set->lock);
>>  	return ret;
>>  }
>>@@ -184,6 +203,11 @@ static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
>>  {
>>  	struct vfio_device *device = vfio_device_from_file(args->file);
>>+	mutex_lock(&device->dev_set->lock);
>>+	iommufd_device_unpreserve(args->session,
>>+				  device->iommufd_device);
>>+	mutex_unlock(&device->dev_set->lock);
>>+
>>  	pci_liveupdate_unpreserve(to_pci_dev(device->dev));
>>  	kho_unpreserve_free(phys_to_virt(args->serialized_data));
>>  }
>
>Unpreservation isn't the exact reverse of preservation. Anything special
>here?

Nothing special. I will make it the exact reverse of preserve.

>
>Otherwise, this patch looks good to me,
>
>Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks for the review,
Sami
