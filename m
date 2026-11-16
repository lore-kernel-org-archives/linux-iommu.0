Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854580;
	b=1EO5kkH+r1kJDzIvY45A3ZB8iVlqkUWemZ4hdM3Ynsl676yZhr5y5dnOLVzhTfYOvCQH
	 h5sldHwPu91niV3PXa6Bj5ZPRpGzTfKQc5SFUuq5gr+nzWyj+I2iDnLpc/iwZBvr2KJBN
	 aotQ/sz43KjQwhWLXmGfQb1oiz+Vt8UrMefKjg+1py12alBJSFTj5LHxujDxmvH4JODVU
	 Nnx8usUAmBc0RE3EYqM7IBhZ+0gtorSuOYjjdbRtR6PfgcIQEWwz51tAEwPLWk31Cc+fw
	 616ublml9JmcpcaI5gVry2jWFT04PEgMvpZZIdSHHFPdBSRcyYy400BciPdI9RfUmRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854580;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=kjMr3AIwgDt4kWmPjLUo+CbR6vTX24G//bvOLGHgweI=;
	b=TKSHmkHfxyz9M98mdIl1PjHtaF2jvUXzauP1jv7wW2+elwi9es5PRO64Rb/ESuxhhRcc
	 zA1B+rlHzaCX7sKjNLLf/kVp2ElEXLZlOxWUW9v1Z2bl4Y+IvbaLJVMBxqFXLexILzFIt
	 XBRrFMI6Ge7pv2LZWBI5voGoPTYaCcSauMRHki4J2W5753/Aw//gUDtXAqDy1ei9s1POE
	 1c/xpGCPClJJDkFIEPqwHeKocM6qIrReaOVPNFJBIgnC9ksJINeU7IKQxG+x+7l8n8hEH
	 X/PWZMw1pO7ttBBKp6fvxjtuOmJjP+OJhS2CYzoEmL88i1YfjJecw0Yg2oKYEqrB/Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BuExOvCV;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E293606A331
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 18:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E293606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BuExOvCV
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2efc4a84e75so5355ad.1
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 10:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794854579; x=1795459379; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kjMr3AIwgDt4kWmPjLUo+CbR6vTX24G//bvOLGHgweI=;
        b=BuExOvCVcX1iQS8NY/XDe5sdsk7OMCPvxTjbg3mhfay4e0IC/+zLdrY7O7iSqYO40f
         eHM1+4pysELcDVyww3JufPBNOgNXrmLErtamvHTkijKHVqtoXZWnUtrLDHO895ApDl7K
         hRRTwqguo200fUXSXnsFhZF0Cxy8qkK25euy+C6i0J+QhXP09UbMMOsrTOHXBzZhG0Bi
         zf5WChufFpiapNHOkg/gNkQNPMG5vcxVJgADhmFoX17D1lkfJanK5lqqpCMbY3gyXmQ2
         L/wYnzNBSadeTUYnnxfdm1yzD8EaPYsOfqpjYpRyiMbQYqEzSSsH6wRM9Ytyh5KIZczU
         RD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794854579; x=1795459379;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kjMr3AIwgDt4kWmPjLUo+CbR6vTX24G//bvOLGHgweI=;
        b=yCnHSg7Ymlwcran3y/acmDvBVsFGQdKHtVb37PSq96G+Jsh9jv22VZdUJqAiHcUb9D
         fdg7DGtizb2vrTCrHRxMnLf2PROa5jnVJTn+hJr+0uHQRLDDyw6/gJd0b3bAYXYVcfi/
         ZAwReeu/k4xrlz0wFB5iIlx2o6fVESU/dCQ5WIqO++hQ0F6RMNiQ2+XUG4fFCJaNNZa2
         R1t1QgW3U+d0iY60EncbKjnLoBS+I3OFi5/y66x7ntl7eI5+DxlnGO6owgc5OhoEgNul
         9vA/fQfFkfW33KIkxjfnL9QrbHaQvyIlysEB/beXnxEA799zw0k/zDOF2nzLYkEOcjjN
         b8Tw==
X-Forwarded-Encrypted: i=1; AL+hErEC3BL5u84HDodFmz6Xdx59+k+OUVTj8Hfh35O+1Gn2DXp++aqxA0jzLtPP+Vqp3L0rvlYOyA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+1LxVK/zhoU7RfVwmKJ+V2kuyNyIf45hF3a36BkcmAdA9BrQUA
	KAG+1/DjUmkN3N4ihDR/O5ZPy7BtxwdFcBeQNfXj/RamJAwY8ofi7+9dBWw2PQSKTg==
X-Gm-Gg: AZFdTZc6PlAuullUi2WhcUfeWrwYb07hSSfRTtgfBMf4JwkLKejFkqhEwgaF7PkXgwh
	3v1yoz+hrFCTB/Xs420a2Yi6xBeXuNhxMZ8LN4hyqZFrnRXajyrsCaqCfAeUjahfXb69lrkzUC1
	5tYFPeKEIPZyaSoiDQT/X6mROgV8ZZlmokul8XVKubAREGkRDABuszz8ei1yxmbz+pH58jSZA43
	i2C/9SA+yjO+vbKMsaDdkZCvlGY7ehatJwJEIaGdrgcLzF1IdKYNpprYIYFNjJSSxV3duy+4RlS
	Ua2gM/na2etAyrfQMIVoPhndDPEAL3va+Z1yMwvPvwpQSbdQM7OtZHBdTxWO9QNaQlSaQ4qGRcb
	H1wfOs77EIyAuPwOV+qaRljeaNA8ZMUkw5RP77j+TpW0Az5xpIARCTvoPhUBB9HZOQ8TpgzdDb+
	moJj/cM6Tw83xhCBATTm0qHcQBIbT9Bot/DVhaxhjVcLmhuiFs68n1Xp2lwO37NIxqEae0fTdg8
	yoQ5kVcYqeewD8CDc+YAEvbWmpjBwhKfLQdS3eV51QDfNKhvhKpiUl2D7AjnDn1ihrmh6GLGxHT
	wCsy+Eyn5O4gatpgWSm9cbpcJnD9huGCnzcEkYmeklKoEuDKqfK4AdD5rx+bJTgVu8BQrBiUvzb
	lnPwglF0CF0ypcroNml0xHZtZiOas1F3GGuSA5X0eWYg=
X-Received: by 2002:a17:903:46c6:b0:2cf:9ec1:ea6e with SMTP id d9443c01a7336-2efda91f564mr483475ad.8.1794854578745;
        Mon, 16 Nov 2026 10:42:58 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b245f0c3sm9315847a91.0.2026.11.16.10.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:42:57 -0800 (PST)
Date: Mon, 16 Nov 2026 18:42:54 +0000
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
Subject: Re: [PATCH v7 05/18] iommu: Implement device and IOMMU HW
 preservation
Message-ID: <avtMVRYk59ilQMlG@google.com>
References: <20261110040828.1774343-1-skhawaja@google.com>
 <20261110040828.1774343-6-skhawaja@google.com>
 <5dc1b3a3-8e9d-4771-b70a-ace7d5b919df@linux.intel.com>
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
In-Reply-To: <5dc1b3a3-8e9d-4771-b70a-ace7d5b919df@linux.intel.com>

On Mon, Nov 16, 2026 at 06:19:11PM +0800, Baolu Lu wrote:
>On 11/10/2026 12:08 PM, Samiullah Khawaja wrote:
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
>>  drivers/iommu/iommu.c            |  32 +++++-
>>  drivers/iommu/liveupdate.c       | 191 +++++++++++++++++++++++++++++++
>>  include/linux/iommu-liveupdate.h |  76 ++++++++++++
>>  include/linux/iommu.h            |  21 ++++
>>  5 files changed, 321 insertions(+), 1 deletion(-)
>>
>>diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
>>index 1f9f886b2c10..8a14d38a3e70 100644
>>--- a/drivers/iommu/iommu-priv.h
>>+++ b/drivers/iommu/iommu-priv.h
>>@@ -21,6 +21,8 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
>>  void dev_iommu_free(struct device *dev);
>>+size_t iommu_group_device_count(struct iommu_group *group);
>>+
>>  const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode);
>>  static inline const struct iommu_ops *iommu_fwspec_ops(struct iommu_fwspec *fwspec)
>>diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>index b486b8bbd1fc..932325e0af41 100644
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
>>@@ -626,8 +627,8 @@ DEFINE_MUTEX(iommu_probe_device_lock);
>>  static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
>>  {
>>+	struct group_device *gdev, *gdev2;
>>  	struct iommu_group *group;
>>-	struct group_device *gdev;
>>  	int ret;
>>  	/*
>>@@ -661,6 +662,13 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
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
>>@@ -697,6 +705,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>>  err_remove_gdev:
>>  	list_del(&gdev->list);
>>+err_free_gdev:
>>  	__iommu_group_free_device(group, gdev);
>>  err_put_group:
>>  	iommu_deinit_device(dev);
>>@@ -3543,6 +3552,27 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>>  }
>>  EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
>>+/**
>>+ * iommu_group_device_count() - Get the number of devices in a group
>>+ * @group: The group.
>>+ *
>>+ * The device count may change after this function returns, as devices can
>>+ * be added to or removed from the group. The caller must recheck it if it
>>+ * needs the count to stay the same.
>>+ *
>>+ * Return: the number of devices in the group.
>>+ */
>>+size_t iommu_group_device_count(struct iommu_group *group)
>>+{
>>+	size_t count;
>>+
>>+	mutex_lock(&group->mutex);
>>+	count = list_count_nodes(&group->devices);
>>+	mutex_unlock(&group->mutex);
>>+
>>+	return count;
>>+}
>>+
>>  static void iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
>>  				   struct iommu_domain *domain)
>>  {
>
>[...]
>
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
>>+	if (iommu_group_device_count(dev->iommu_group) != 1)
>>+		return -EOPNOTSUPP;
>>+
>>+	if (iommu_get_domain_for_dev(dev) != domain)
>>+		return -EINVAL;
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
>>+		if (iommu_group_device_count(dev->iommu_group) != 1) {
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
>Only devices in singleton iommu groups can be preserved, and no other
>device may join the group while preservation is in progress or the
>device remains preserved.
>
>Could we simplify this by adding a flag to struct iommu_group, protected
>by group->mutex? For example:
>
>@@ -72,6 +72,9 @@ struct iommu_group {
>         */
>        unsigned int recovery_cnt;
>        void *owner;
>+#ifdef CONFIG_IOMMU_LIVEUPDATE
>+       bool liveupdate_reserved;
>+#endif
> };
>
>A helper could check that the group contains exactly one device and set
>the flag atomically under group->mutex. Device probing would reject an
>addition if the flag is set.
>
>#ifdef CONFIG_IOMMU_LIVEUPDATE
>int iommu_group_reserve_liveupdate(struct iommu_group *group)
>{
>        int ret = 0;
>
>        mutex_lock(&group->mutex);
>        if (group->liveupdate_reserved)
>                ret = -EBUSY;
>        else if (list_count_nodes(&group->devices) != 1)
>                ret = -EOPNOTSUPP;
>        else
>                group->liveupdate_reserved = true;
>        mutex_unlock(&group->mutex);
>
>        return ret;
>}
>
>void iommu_group_unreserve_liveupdate(struct iommu_group *group)
>{
>        mutex_lock(&group->mutex);
>        group->liveupdate_reserved = false;
>        mutex_unlock(&group->mutex);
>}
>#endif
>
>The reservation could be taken before calling the driver's preserve
>callback and cleared on every failure path and after unpreservation.
>This would avoid the second device-count check.
>
>Any thoughts?

This looks good. I will use it in the next revision, and use the same
flag on the restore side as well.

Thanks,
Sami
