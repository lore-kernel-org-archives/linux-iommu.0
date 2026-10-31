Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793411145;
	b=UyNyDWRaH6YJytfZPM+HEttv7OnLL9/34kN83EgEtHXaeDThp+hnVNBsTMrOVGt4bW8y
	 XsM+FiKBkVdbmEu9t1GPaAcCmqeGKzxlXfry7xvkiuUwABtBx5sTK9H26r0NRJVWmpTuL
	 bgZNgk/mqCBV6+7+sjAc1+YsZVdFtB4ZCwBj/Kh9XJsKw/1KC0Ha3dMb55A/8KTuFF5lR
	 pW9ijLYXKokuxvVSRSxkPe5dNePdQzmcDxHsGuenYJpkV1p6Td0wR+V+5kdbP9UaG49P+
	 KBp1OqTC9APjK5pH7KE6n0h3Xn85jkWR8eATUGS+rDvLjywK+zuRJZ7I9Y/Hbv++80A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793411145;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=SJp1eLkCUWhFyh78MuF96niBaNXUH72k2K0ZQ6kq9pU=;
	b=mN+qZJydBz1p6c7SNl01iIYJKxWLrYVluRhBE0AcMDcR2nlqD3/xN2w3HqcCe5ZFOcnu
	 wDGD4Xr9enED2PGgrfkHNAk4qlbQSeLTZv/p+e+rNE4Ba/e4xV9woKxtYQT4x5QboLy87
	 quUNlazpVZ/7iJOX5Enuum9PSDY/0WpUHJN7r0JOL3HXCDMa5wdSzrHyIuYplVk7cgpUw
	 FbRZTVWnop6mTULZhTHREmwpiWGjWkUUJYF6HQVnLNTFmAeemvhsyge2g/5NSmSoDt1ag
	 StsxKPldYXVQYMU6XxXo6/XIOcXRjPMFcPa2FdtUW1zXCN8bje1FArgwSH+XhztW2BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ens7MgvX;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC11606A326
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 01:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEC11606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ens7MgvX
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e9f6a16afcso16905ad.1
        for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 18:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793411143; x=1794015943; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SJp1eLkCUWhFyh78MuF96niBaNXUH72k2K0ZQ6kq9pU=;
        b=ens7MgvXtO5SqiGw927Ch3oS7Cq/QhIGEfPGtTst5KS0EGaefc6EJjIkJcQ5j7npua
         O+3axxPybwu4HwTi8ph0wkYUgyOqbmXqDntHxqIiQptITSqHx2OyA9TOklv616Dzg6LY
         KaGyN4/RAwOvK2FQYTCS0NimgZQ33ODH2q/5J+E+Q/d73kvltc5zc04AblsDbdDTUS+/
         pOvrKwysWHmWR/dKph5DketBR3+72gYYPVgmAEMzdXO9dXa3mWrETHv0gkOGezhdtUp2
         +zN4NsN3o2LIZxIl6FVFsQHqqiO1XPQzmyXIYzdkodaTVYzZPVBDSkaOUfMdN0E4fkZz
         8Xhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793411143; x=1794015943;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SJp1eLkCUWhFyh78MuF96niBaNXUH72k2K0ZQ6kq9pU=;
        b=I+8Y+uc/PhRsex6l4xPJdpZrbs4lddtj/S9zvdYA+KEeZaCAlov9x33r917l8a/Vn8
         uHdAmFEaXsRM8vDYaAPZ32NvPTvTXMMIwAkWIDQ+SXvWVPKxgEVVqnUmx8i55J5xTJOa
         NEvf7kQ1gU0CXjYrmdAm5La52mM5dHwDNyScywc0VJxPuUHGFvyCzOJ5EwB0BnqYqs6W
         osOHoJm/CRHslocJcxPwgd8gPRGielEsxJTlGDk46ojkqBSqk25Z1dGmxAgWfjHpy+Ot
         97xnylmtYyPpoAdSwKd9x3841ONfO3AXTup6Lj5eOq82Kew6hF8WhSqnfxbjUDb972Zc
         /0mA==
X-Forwarded-Encrypted: i=1; AKwUvBy+GC69dE5BVSF/5bXUuv0D8cU64abWAvTYnqykTXtr1Hg0pB8kYCNUaeVHdDXrJe+qPGC2og==@lists.linux.dev
X-Gm-Message-State: AFq9FYKCF0Un5aOUk1FoyYL5Htdg4A8VbdjorgTHrbHTNdG1F2KAoDwd
	2u5Hk8UZJVqCycmv0vxoVOHgqhiekm6p7Arhvh5Zcc5dRa+opzr300W4ph01W2Vz2w==
X-Gm-Gg: AYBFou0aAiISxvuVh+nFYsQBir5SLfr/pKIRK80PPYcJegJcjZhogKdyarF0aNXRldZ
	CjuF+Kfz5ssHUd5MZiXjvNB0kryeSyBz8vlqlLRV8dDKOwptBmjeBuhkBFwCHUWXZeTHzMwm+7d
	ST6LCQ1waQCVdV5pbGMsSdNZ0vDHOJr/TAVpw5vzFvxVA8K3dvz6D65TlMeFdJIm0hJUvscn+QF
	16YD1nyHX8Ke9Sh6W4mLWwYqVrmcSo+6R46/QXofPd48cnHwLsAsm3HcLNhkwiCMOouRNOXrrmy
	UvfyUWQygD87tsNHqfUdjwS31ccDQXjohQin7F03FQOfUSlSQgR2+FkwHedGXYAVYu3rH32sRCQ
	vRzzvqzWkupjxbTa2jGzsayRk4ChfTDNaSyVWoU5j8AaJYxz7f1cu9JDnWOJFO7AekTbX1hbpaw
	EwWQ3kUOmU4jqFJs8YbDjoX/XU+GBF9kQSRm/kxrK1+SssboQSiPvN1aVjstU0FvvtKEqTsFdqk
	XuIY/2NStWG5MxlQTb8WgXwHCuDyXx0/2c8XYJPS3wBJa1DY7HVUqGUS3XISsDhU9Xo02bJP6RQ
	sGA1yyBCHnFVnyGgpk9Jc+9YsW6z7XYksthj5O3theCKUskjEMglCZFaedS9wWdcpH3KBorJKI0
	mY2QcceQX7zAZeDPjAcSzlg==
X-Received: by 2002:a17:902:ecca:b0:2e6:344:7bb4 with SMTP id d9443c01a7336-2eb1ec78372mr13509425ad.11.1793411142587;
        Fri, 30 Oct 2026 18:45:42 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e944ba9sm10342720a91.8.2026.10.30.18.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 18:45:40 -0700 (PDT)
Date: Sat, 31 Oct 2026 01:45:36 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 05/18] iommu: Implement device and IOMMU HW
 preservation
Message-ID: <auTzN4NWuKsBvIZU@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-6-skhawaja@google.com>
 <df75f891-05a0-4d47-8705-d6a00c81ff97@linux.intel.com>
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
In-Reply-To: <df75f891-05a0-4d47-8705-d6a00c81ff97@linux.intel.com>

On Fri, Oct 30, 2026 at 01:12:31PM +0800, Baolu Lu wrote:
>On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
>>Add IOMMU ops to preserve/unpreserve the device state handled by the
>>IOMMU driver. This is IOMMU specific state of the device that needs to
>>be preserved for liveupdate. These ops can be implemented by the IOMMU
>>drivers that support preservation of devices that have their IOMMU
>>domains preserved. During device preservation the state of the
>>associated IOMMU is also preserved as dependency.
>>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  drivers/iommu/iommu-priv.h       |   2 +
>>  drivers/iommu/iommu.c            |  72 +++++++++++-
>>  drivers/iommu/liveupdate.c       | 189 +++++++++++++++++++++++++++++++
>>  include/linux/iommu-liveupdate.h |  76 +++++++++++++
>>  include/linux/iommu.h            |  33 ++++++
>>  5 files changed, 371 insertions(+), 1 deletion(-)
>>
>>diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
>>index 1f9f886b2c10..6b0ef210b32f 100644
>>--- a/drivers/iommu/iommu-priv.h
>>+++ b/drivers/iommu/iommu-priv.h
>>@@ -21,6 +21,8 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
>>  void dev_iommu_free(struct device *dev);
>>+bool iommu_group_is_singleton(struct iommu_group *group);
>>+
>>  const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode);
>>  static inline const struct iommu_ops *iommu_fwspec_ops(struct iommu_fwspec *fwspec)
>>diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>index b486b8bbd1fc..a66363789ca9 100644
>>--- a/drivers/iommu/iommu.c
>>+++ b/drivers/iommu/iommu.c
>>@@ -18,6 +18,7 @@
>>  #include <linux/errno.h>
>>  #include <linux/host1x_context_bus.h>
>>  #include <linux/iommu.h>
>>+#include <linux/iommu-liveupdate.h>
>>  #include <linux/iommufd.h>
>>  #include <linux/idr.h>
>>  #include <linux/err.h>
>>@@ -328,6 +329,47 @@ void iommu_device_unregister(struct iommu_device *iommu)
>>  }
>>  EXPORT_SYMBOL_GPL(iommu_device_unregister);
>>+struct iommu_dev_iter {
>>+	struct iommu_device *iommu;
>>+	iommu_dev_iter_fn fn;
>>+};
>>+
>>+static int _iommu_for_each_dev_cb(struct device *dev, void *data)
>>+{
>>+	struct iommu_dev_iter *iter = data;
>>+
>>+	if (dev->iommu && dev->iommu->iommu_dev == iter->iommu)
>>+		return iter->fn(dev, iter->iommu);
>>+
>>+	return 0;
>>+}
>>+
>>+/**
>>+ * iommu_for_each_dev() - Iterate over all devices attached to an IOMMU
>>+ * @iommu: IOMMU instance
>>+ * @fn: Callback to call for each device attached to @iommu
>>+ *
>>+ * Return: 0 on success, or negative error code.
>>+ */
>>+int iommu_for_each_dev(struct iommu_device *iommu, iommu_dev_iter_fn fn)
>>+{
>>+	struct iommu_dev_iter iter = {
>>+		.iommu = iommu,
>>+		.fn = fn,
>>+	};
>>+	int ret;
>>+
>>+	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
>>+		ret = bus_for_each_dev(iommu_buses[i], NULL, &iter,
>>+				       _iommu_for_each_dev_cb);
>>+		if (ret)
>>+			return ret;
>>+	}
>>+
>>+	return 0;
>>+}
>>+EXPORT_SYMBOL_GPL(iommu_for_each_dev);
>
>The function has no locking against iommu probe or release, so the
>callback can read dev->iommu while it is being freed or before it is
>fully set up.

It is only called from intel_iommu_shutdown(), which runs after the
other CPUs are stopped and interrupts are disabled, so probe and release
can't run. I will rename it to iommu_for_each_dev_unsafe(), document
that it must only be called at shutdown and drop the export, since the
only user is built in.

>
>>+
>>  #if IS_ENABLED(CONFIG_IOMMUFD_TEST)
>>  void iommu_device_unregister_bus(struct iommu_device *iommu,
>>  				 const struct bus_type *bus,
>>@@ -626,8 +668,8 @@ DEFINE_MUTEX(iommu_probe_device_lock);
>>  static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
>>  {
>>+	struct group_device *gdev, *gdev2;
>>  	struct iommu_group *group;
>>-	struct group_device *gdev;
>>  	int ret;
>>  	/*
>>@@ -661,6 +703,13 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>>  		goto err_put_group;
>>  	}
>>+	for_each_group_device(group, gdev2) {
>>+		if (dev_iommu_has_preserved_state(gdev2->dev)) {
>>+			ret = -EBUSY;
>>+			goto err_free_gdev;
>>+		}
>>+	}
>>+
>>  	/*
>>  	 * The gdev must be in the list before calling
>>  	 * iommu_setup_default_domain()
>>@@ -697,6 +746,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>>  err_remove_gdev:
>>  	list_del(&gdev->list);
>>+err_free_gdev:
>>  	__iommu_group_free_device(group, gdev);
>>  err_put_group:
>>  	iommu_deinit_device(dev);
>>@@ -3543,6 +3593,26 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>>  }
>>  EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
>>+/**
>>+ * iommu_group_is_singleton() - Query if group contains exactly one device
>>+ * @group: The group.
>>+ *
>>+ * Return: true if group contains exactly 1 device, false otherwise.
>>+ */
>
>We discussed this interface before, and the consensus was that such an
>interface is not feasible, because the membership of an iommu_group is
>not fixed, given the hot-plug support of buses like PCI.
>
>I am fine with the usage model of ensuring the iommu group of a
>preserved device to be a singleton, but I don't think we even need such
>a kAPI. It should be handled case by case.

The iommu_group membership can change, this is why we check it in two
places, both under group->mutex:

- During preservation we check that the group is a singleton, and check
   again after setting device_ser.
- During probe we refuse to add a device to a group that has a preserved
   device.

So if a device is added to the group while we are preserving, either the
probe fails because the group already has a preserved device, or the
preservation fails because the group is no longer a singleton. Could you
please elaborate what you mean by handling it case by case?

>>+bool iommu_group_is_singleton(struct iommu_group *group)
>>+{
>>+	bool ret;
>>+
>>+	if (!group)
>>+		return false;
>>+
>>+	mutex_lock(&group->mutex);
>>+	ret = (list_count_nodes(&group->devices) == 1);
>>+	mutex_unlock(&group->mutex);
>>+
>>+	return ret;
>>+}
>>+
>>  static void iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
>>  				   struct iommu_domain *domain)
>>  {
>>diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
>>index b7eda5615189..d1d11b28ae79 100644
>>--- a/drivers/iommu/liveupdate.c
>>+++ b/drivers/iommu/liveupdate.c
>>@@ -43,6 +43,9 @@
>>  #include <linux/kexec_handover.h>
>>  #include <linux/kho_block.h>
>>  #include <linux/liveupdate.h>
>>+#include <linux/pci.h>
>>+
>>+#include "iommu-priv.h"
>>  /**
>>   * struct iommu_ser_set - Set of serialized objects of one type
>>@@ -358,3 +361,189 @@ void iommu_unpreserve_domain(struct iommu_domain *domain)
>>  	liveupdate_flb_put_outgoing(&iommu_flb);
>>  }
>>  EXPORT_SYMBOL_GPL(iommu_unpreserve_domain);
>>+
>>+static int iommu_preserve_locked(struct iommu_device *iommu,
>>+				 struct iommu_flb_obj *flb_obj)
>>+{
>>+	struct iommu_hw_ser *iommu_hw_ser;
>>+	int ret;
>>+
>>+	if (!iommu->ops->preserve || !iommu->ops->unpreserve)
>>+		return -EOPNOTSUPP;
>>+
>>+	lockdep_assert_held(&flb_obj->lock);
>>+	if (iommu->iommu_ser) {
>>+		iommu->iommu_ser->hdr.ref_count++;
>>+		return 0;
>>+	}
>>+
>>+	iommu_hw_ser = iommu_ser_set_alloc(&flb_obj->iommu_set);
>>+	if (IS_ERR(iommu_hw_ser))
>>+		return PTR_ERR(iommu_hw_ser);
>>+
>>+	ret = iommu->ops->preserve(iommu, iommu_hw_ser);
>>+	if (ret) {
>>+		iommu_hw_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
>>+		return ret;
>>+	}
>>+
>>+	iommu->iommu_ser = iommu_hw_ser;
>>+	return ret;
>>+}
>>+
>>+static void iommu_unpreserve_locked(struct iommu_device *iommu,
>>+				    struct iommu_flb_obj *flb_obj)
>>+{
>>+	struct iommu_hw_ser *iommu_hw_ser = iommu->iommu_ser;
>>+
>>+	lockdep_assert_held(&flb_obj->lock);
>>+	if (WARN_ON(!iommu_hw_ser))
>>+		return;
>>+
>>+	if (WARN_ON_ONCE(!iommu->ops->preserve ||
>>+			 !iommu->ops->unpreserve))
>>+		return;
>>+
>>+	iommu_hw_ser->hdr.ref_count--;
>>+	if (iommu_hw_ser->hdr.ref_count)
>>+		return;
>>+
>>+	iommu->iommu_ser = NULL;
>>+	iommu->ops->unpreserve(iommu, iommu_hw_ser);
>>+	iommu_hw_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
>>+}
>>+
>>+/**
>>+ * iommu_preserve_device() - Preserve device state across live update
>>+ * @domain: Associated IOMMU domain
>>+ * @dev: Device to preserve
>>+ * @dma_owner_token: Token to identify DMA owner of this device
>>+ *
>>+ * Return: 0 on success, or negative error code.
>>+ */
>>+int iommu_preserve_device(struct iommu_domain *domain,
>>+			  struct device *dev, u64 dma_owner_token)
>>+{
>>+	struct iommu_device_ser *device_ser;
>>+	struct iommu_flb_obj *flb_obj;
>>+	struct dev_iommu *iommu;
>>+	struct pci_dev *pdev;
>>+	int ret;
>>+
>>+	if (!dev_is_pci(dev))
>>+		return -EOPNOTSUPP;
>>+
>>+	if (!iommu_group_dma_owner_claimed(dev->iommu_group))
>>+		return -EINVAL;
>>+
>>+	if (!iommu_group_is_singleton(dev->iommu_group))
>>+		return -EOPNOTSUPP;
>>+
>>+	pdev = to_pci_dev(dev);
>>+	iommu = dev->iommu;
>>+	if (!iommu->iommu_dev->ops->preserve_device ||
>>+	    !iommu->iommu_dev->ops->unpreserve_device ||
>>+	    !iommu->iommu_dev->ops->preserve ||
>>+	    !iommu->iommu_dev->ops->unpreserve)
>>+		return -EOPNOTSUPP;
>>+
>>+	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
>>+	if (ret)
>>+		return ret;
>>+
>>+	mutex_lock(&flb_obj->lock);
>>+	if (!domain->domain_ser) {
>>+		ret = -EINVAL;
>>+		goto out_unlock;
>>+	}
>
>Should we check that @domain is actually attached to the device? The
>iommu core tracks the device's domain attachment, so what happens if
>the caller's @domain doesn't match what the iommu core has recorded?

The caller of this API does that check before calling
iommu_preserve_device. But I agree and I will add a check here.
>
>>+
>>+	if (dev_iommu_preserved_state(dev)) {
>>+		ret = -EBUSY;
>>+		goto out_unlock;
>>+	}
>>+
>>+	device_ser = iommu_ser_set_alloc(&flb_obj->device_set);
>>+	if (IS_ERR(device_ser)) {
>>+		ret = PTR_ERR(device_ser);
>>+		goto out_unlock;
>>+	}
>>+
>>+	ret = iommu_preserve_locked(iommu->iommu_dev, flb_obj);
>>+	if (ret) {
>>+		device_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
>>+		goto out_unlock;
>>+	}
>>+
>>+	device_ser->attachment.domain_phys = virt_to_phys(domain->domain_ser);
>>+	device_ser->iommu_phys = virt_to_phys(iommu->iommu_dev->iommu_ser);
>>+	device_ser->devid = pci_dev_id(pdev);
>>+	device_ser->pci_domain_nr = pci_domain_nr(pdev->bus);
>>+	device_ser->dma_owner_token = dma_owner_token;
>>+
>>+	ret = iommu->iommu_dev->ops->preserve_device(dev, device_ser);
>>+	if (!ret) {
>>+		WRITE_ONCE(dev->iommu->device_ser, device_ser);
>>+
>>+		/* Validate that no sibling device was added concurrently */
>>+		if (!iommu_group_is_singleton(dev->iommu_group)) {
>>+			iommu->iommu_dev->ops->unpreserve_device(dev, device_ser);
>>+			WRITE_ONCE(dev->iommu->device_ser, NULL);
>>+			ret = -EOPNOTSUPP;
>>+		}
>>+	}
>>+
>>+	if (ret) {
>>+		device_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
>>+		iommu_unpreserve_locked(iommu->iommu_dev, flb_obj);
>>+		goto out_unlock;
>>+	}
>>+
>>+out_unlock:
>>+	mutex_unlock(&flb_obj->lock);
>>+	liveupdate_flb_put_outgoing(&iommu_flb);
>>+	return ret;
>>+}
>>+EXPORT_SYMBOL_GPL(iommu_preserve_device);
>>+
>>+/**
>>+ * iommu_unpreserve_device() - Unpreserve device state
>>+ * @domain: Associated IOMMU domain
>
>@domain is not used anywhere in this function. Why is it needed?

Agreed. I will remove this.
>
>>+ * @dev: Device to unpreserve
>>+ */
>>+void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
>>+{
>>+	struct iommu_device_ser *iommu_device_ser;
>>+	struct iommu_flb_obj *flb_obj;
>>+	struct dev_iommu *iommu;
>>+	int ret;
>>+
>>+	if (!dev_is_pci(dev))
>>+		return;
>>+
>>+	if (!iommu_group_dma_owner_claimed(dev->iommu_group))
>>+		return;
>>+
>>+	iommu = dev->iommu;
>>+	if (WARN_ON(!iommu->iommu_dev->ops->unpreserve_device ||
>>+		    !iommu->iommu_dev->ops->unpreserve))
>>+		return;
>>+
>>+	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
>>+	if (WARN_ON(ret))
>>+		return;
>>+
>>+	mutex_lock(&flb_obj->lock);
>>+	iommu_device_ser = dev_iommu_preserved_state(dev);
>>+	if (WARN_ON(!iommu_device_ser))
>>+		goto out_unlock;
>>+
>>+	iommu_device_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
>>+	iommu->iommu_dev->ops->unpreserve_device(dev, iommu_device_ser);
>>+	WRITE_ONCE(dev->iommu->device_ser, NULL);
>>+
>>+	iommu_unpreserve_locked(iommu->iommu_dev, flb_obj);
>>+out_unlock:
>>+	mutex_unlock(&flb_obj->lock);
>>+	liveupdate_flb_put_outgoing(&iommu_flb);
>>+}
>>+EXPORT_SYMBOL_GPL(iommu_unpreserve_device);
>>diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
>>index caa9778eee2d..cdf8a82b7f1d 100644
>>--- a/include/linux/iommu-liveupdate.h
>>+++ b/include/linux/iommu-liveupdate.h
>>@@ -8,6 +8,7 @@
>>  #ifndef _LINUX_IOMMU_LIVEUPDATE_H
>>  #define _LINUX_IOMMU_LIVEUPDATE_H
>>+#include <linux/device.h>
>>  #include <linux/iommu.h>
>>  #include <linux/liveupdate.h>
>>  #include <linux/kho/abi/iommu.h>
>>@@ -15,8 +16,58 @@
>>  #ifdef CONFIG_IOMMU_LIVEUPDATE
>>  int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
>>  void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler);
>>+
>>+/**
>>+ * dev_iommu_has_preserved_state() - Check if a device has live update state
>>+ * @dev: Target device
>>+ *
>>+ * Unlike dev_iommu_preserved_state() and dev_iommu_restored_state(), this does
>>+ * not dereference the serialized state, so it is safe to call without holding
>>+ * a reference on the live update FLB.
>>+ *
>>+ * Return: true if @dev has preserved (outgoing) or restored (incoming) state.
>>+ */
>>+static inline bool dev_iommu_has_preserved_state(struct device *dev)
>>+{
>>+	return dev->iommu && READ_ONCE(dev->iommu->device_ser);
>>+}
>>+
>>+/**
>>+ * dev_iommu_preserved_state() - Get preserved state of a device
>>+ * @dev: Target device
>>+ *
>>+ * Return: Pointer to preserved device state, or NULL if not preserved.
>>+ */
>>+static inline void *dev_iommu_preserved_state(struct device *dev)
>>+{
>>+	struct iommu_device_ser *ser;
>>+
>>+	if (!dev->iommu)
>>+		return NULL;
>>+
>>+	ser = READ_ONCE(dev->iommu->device_ser);
>>+	if (ser && !(ser->hdr.flags & IOMMU_SER_FLAG_INCOMING))
>>+		return ser;
>>+
>>+	return NULL;
>>+}
>>+
>>  int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser);
>>  void iommu_unpreserve_domain(struct iommu_domain *domain);
>>+int iommu_preserve_device(struct iommu_domain *domain,
>>+			  struct device *dev, u64 dma_owner_token);
>>+void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev);
>>+
>>+/**
>>+ * iommu_preserved_state() - Get preserved state of an IOMMU instance
>>+ * @iommu: IOMMU hardware instance
>>+ *
>>+ * Return: Pointer to preserved state, or NULL if not preserved.
>>+ */
>>+static inline void *iommu_preserved_state(struct iommu_device *iommu)
>>+{
>>+	return iommu->iommu_ser;
>>+}
>>  #else
>>  static inline int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler)
>>  {
>>@@ -27,6 +78,16 @@ static inline void iommu_liveupdate_unregister_flb(struct liveupdate_file_handle
>>  {
>>  }
>>+static inline bool dev_iommu_has_preserved_state(struct device *dev)
>>+{
>>+	return false;
>>+}
>>+
>>+static inline void *dev_iommu_preserved_state(struct device *dev)
>>+{
>>+	return NULL;
>>+}
>>+
>>  static inline int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser)
>>  {
>>  	return -EOPNOTSUPP;
>>@@ -35,5 +96,20 @@ static inline int iommu_preserve_domain(struct iommu_domain *domain, struct iomm
>>  static inline void iommu_unpreserve_domain(struct iommu_domain *domain)
>>  {
>>  }
>>+
>>+static inline int iommu_preserve_device(struct iommu_domain *domain,
>>+					struct device *dev, u64 dma_owner_token)
>>+{
>>+	return -EOPNOTSUPP;
>>+}
>>+
>>+static inline void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
>>+{
>>+}
>>+
>>+static inline void *iommu_preserved_state(struct iommu_device *iommu)
>>+{
>>+	return NULL;
>>+}
>>  #endif
>>  #endif /* _LINUX_IOMMU_LIVEUPDATE_H */
>>diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>>index 71e73c5181b5..35d028fe7126 100644
>>--- a/include/linux/iommu.h
>>+++ b/include/linux/iommu.h
>>@@ -684,6 +684,10 @@ __iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
>>   *               resources shared/passed to user space IOMMU instance. Associate
>>   *               it with a nesting @parent_domain. It is required for driver to
>>   *               set @viommu->ops pointing to its own viommu_ops
>>+ * @preserve_device: Preserve state of a device for liveupdate.
>>+ * @unpreserve_device: Unpreserve state that was preserved earlier.
>>+ * @preserve: Preserve state of iommu translation hardware for liveupdate.
>>+ * @unpreserve: Unpreserve state of iommu that was preserved earlier.
>>   * @owner: Driver module providing these ops
>>   * @identity_domain: An always available, always attachable identity
>>   *                   translation.
>>@@ -740,6 +744,13 @@ struct iommu_ops {
>>  			   struct iommu_domain *parent_domain,
>>  			   const struct iommu_user_data *user_data);
>>+#ifdef CONFIG_IOMMU_LIVEUPDATE
>>+	int (*preserve_device)(struct device *dev, struct iommu_device_ser *device_ser);
>>+	void (*unpreserve_device)(struct device *dev, struct iommu_device_ser *device_ser);
>>+	int (*preserve)(struct iommu_device *iommu, struct iommu_hw_ser *iommu_ser);
>>+	void (*unpreserve)(struct iommu_device *iommu, struct iommu_hw_ser *iommu_ser);
>>+#endif
>>+
>>  	const struct iommu_domain_ops *default_domain_ops;
>>  	struct module *owner;
>>  	struct iommu_domain *identity_domain;
>>@@ -827,6 +838,7 @@ struct iommu_domain_ops {
>>   * @singleton_group: Used internally for drivers that have only one group
>>   * @max_pasids: number of supported PASIDs
>>   * @ready: set once iommu_device_register() has completed successfully
>>+ * @iommu_ser: preserved iommu state of outgoing kernel for liveupdate.
>>   */
>>  struct iommu_device {
>>  	struct list_head list;
>>@@ -836,6 +848,10 @@ struct iommu_device {
>>  	struct iommu_group *singleton_group;
>>  	u32 max_pasids;
>>  	bool ready;
>>+
>>+#ifdef CONFIG_IOMMU_LIVEUPDATE
>>+	struct iommu_hw_ser *iommu_ser;
>>+#endif
>>  };
>>  /**
>>@@ -875,6 +891,8 @@ struct iommu_fault_param {
>>   * @pci_32bit_workaround: Limit DMA allocations to 32-bit IOVAs
>>   * @require_direct: device requires IOMMU_RESV_DIRECT regions
>>   * @shadow_on_flush: IOTLB flushes are used to sync shadow tables
>>+ * @device_ser: preserved (outgoing) or restored (incoming) liveupdate state
>>+ *		of this device
>>   *
>>   * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
>>   *	struct iommu_group	*iommu_group;
>>@@ -890,6 +908,9 @@ struct dev_iommu {
>>  	u32				pci_32bit_workaround:1;
>>  	u32				require_direct:1;
>>  	u32				shadow_on_flush:1;
>>+#ifdef CONFIG_IOMMU_LIVEUPDATE
>>+	struct iommu_device_ser		*device_ser;
>>+#endif
>>  };
>>  int iommu_device_register(struct iommu_device *iommu,
>>@@ -1204,6 +1225,18 @@ static inline void *dev_iommu_priv_get(struct device *dev)
>>  void dev_iommu_priv_set(struct device *dev, void *priv);
>>+/**
>>+ * typedef iommu_dev_iter_fn - Callback for iterating IOMMU attached devices
>>+ * @dev: Attached device
>>+ * @iommu: IOMMU instance
>>+ *
>>+ * Return: 0 on success, or negative error code.
>>+ */
>>+typedef int (*iommu_dev_iter_fn)(struct device *dev,
>>+				 struct iommu_device *iommu);
>>+
>>+int iommu_for_each_dev(struct iommu_device *iommu, iommu_dev_iter_fn fn);
>>+
>>  extern struct mutex iommu_probe_device_lock;
>>  int iommu_probe_device(struct device *dev);
>
>Thanks,
>baolu

Thanks,
Sami
