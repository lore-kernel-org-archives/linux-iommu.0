Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49D7352002
	for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 23:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782170874; cv=none; b=YrIhurdlFMN4b8Ts+lwfJSWXYKHrAGoGH0IQFRnj79uTWG8z9ohhsb++WYXR0H7jPcqGJ6fWwCW4fOsCIFOVzR+e50q9JBlQU6H3E2WmV4EEdYryXgy39dPVw7tBOAdFr0mhNBc8v0Xa/129XYjZ1TbBNYqZkgUctdR/7fEPbuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782170874; c=relaxed/simple;
	bh=lwVDuCan41sfTJTnrOrdE1tC3q2gBSoCWyBPW5RUdWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjjRg0yjDstbPKMaQPjJ/YiN61hoUdmamppyqarUIPs0xM8eHn+NvyL78TUZ7rM3edSoXVOrCHqDXigGFyjU/PWqYLvxGWLH7+pV8RVWtx1TnhhNcjgOYq0r2M3NO4mELl/4olj3Zv2YwqScYE2u/+yR/wzXkt3pswxPYYw21yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F0YRrSye; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F0YRrSye"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c6b7bd4e8dso18355ad.0
        for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 16:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782170872; x=1782775672; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wp+dObOPQcCrEViDJa1TZgNuuO73gOCATlytODnl2CU=;
        b=F0YRrSyeuk8H3MQ5+2clF0UFrAH92vbfKov3IkKVWdpmuI3WNJ/KB2EZDdd0RQqJ03
         WTTgLcjpnts2XkNswQO0owVyMIz4g219wCA1ZspBOUzWfySLzF/k7xZsHPqgL9sxrcuC
         BiZyCMcNAdyqWpe4c6qsOOuVIrsPT1ZcaTZHk90PhHY4JX5Tkp0tyNOly+GMxctnOAv2
         L0DVG34JW29Fg3eqwJEAl5s9RKCDJWea3D9LKheOpaUqtpLNJbkEiCWeQCjXwlcNt4oO
         HBXReyS73XvbU3gNmrQSmkKdDMObvZUzPdrzs/S1Id8cTnBdqSdO8l50AB5Y54Q6V064
         LXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782170872; x=1782775672;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wp+dObOPQcCrEViDJa1TZgNuuO73gOCATlytODnl2CU=;
        b=YPG1Lq2nWlajltWOEV0Xh9GRu8gG+pzYYUXAIVR3DJysHbtJoRkxI2z5XYDcjFUy6u
         Ush8D5GJ/+IB8wRg3LU9X7lqMLcTp4fwAm+HgqaRaa0rNE34LBY/EzQ1orYxdD+dkwOC
         BKZfFiThh7+uRg4WFTWEyWVVZAzghlkasU0yCipaHCo/rUrjyOBJ8//FgNIcRV1FaPla
         wFdZp5OXFKsy82AB1MXQhJt8bqH7C27Mpb42Efte7YRDWZF+etZ8fNyt8VNc/uOkLSti
         ICNmHRySXyTQPEAI3pCNo1EVXL6gQibQ9kH5W2hLTGgWV8YGhOsQ+DlbLU2ktRAJosuj
         50zQ==
X-Forwarded-Encrypted: i=1; AHgh+RpF/raTKsrCTfu3PLwe/v0dxL9zEFbL6EcOurjL4ipageB3IQn82tg7hjT/B20kqmlgtTbqng==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2KpBqptdLJSv17mC1hVR3EvZkch9l+By2zUR03xICBavm1k2j
	LD+kD4uO0sRblTKl7fncPnW2amW01anZFJLjpn8/QXUdEIVHpnBfl33Ckz/V+U9Ypg==
X-Gm-Gg: AfdE7cmrtKSyxNwXY6kNUOF7GZRbdJh6esSsihcDoZanLXT/MLiQ8PapO2IlByAM+X4
	2fb9fiSR9C7Q0lFOjAk2wAcVI21JViqtwc4+/Tk6oOdiYiPIIlk9vPLQr3IKdpwKHFpAdoa0hww
	clOkjlq24I8uJetae/wTOJ7Tq//6YoI200nmS8Tc7ypA2aGQLoxRM7NN1w2dhCg0aNoQZSmZqdu
	8e1urZPlbY8JHipv19ANfjbGattxzA+KkwIJBtIUWMci++bMvh7C80i+XuGbDPSSld5LWPRZCZ/
	oYYGF1dTze0SFqzUSM/ApsivaYnI5pK2VN6fxxPAMh8m/155wHdxYkdG+u9xuxxUQRae4RfZjAr
	Tgc16MrQOY1bbaBq13WtAVM1bXpUBlIQZAeCjDOpa1qcMJu7GYigb3vw84pVjleZKfGaL3sYyPn
	Szmns4aI5o7ORzbVrfxveJhdu3ARlYWqGrvt2ecirOaYklLCwzbwMlQxoEp8157U0mdWI8r7yfS
	qUPO6Lp2Vai9X/tWrQ=
X-Received: by 2002:a17:902:ec83:b0:2b4:641a:6b7c with SMTP id d9443c01a7336-2c7c70ec5damr540285ad.13.1782170871493;
        Mon, 22 Jun 2026 16:27:51 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436af57asm97554325ad.13.2026.06.22.16.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 16:27:50 -0700 (PDT)
Date: Mon, 22 Jun 2026 23:27:47 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v3 09/18] iommu: Add APIs to get iommu and device
 preserved state
Message-ID: <ajnAcPp13wXSiw8l@google.com>
References: <20260614233728.2212104-1-skhawaja@google.com>
 <20260614233728.2212104-10-skhawaja@google.com>
 <ce3f6eb2-99c4-4582-a11b-a5578b62d401@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ce3f6eb2-99c4-4582-a11b-a5578b62d401@linux.intel.com>

On Mon, Jun 22, 2026 at 11:10:55AM +0800, Baolu Lu wrote:
>On 6/15/26 07:37, Samiullah Khawaja wrote:
>>The preserved state of the device and IOMMU needs to be fetched during
>>shutdown and boot in the next kernel. Add APIs that can be used to fetch
>>the preserved state of a device and IOMMU. The APIs will only be used
>>during shutdown and after liveupdate so no locking needed.
>>
>>Reviewed-by: Pranjal Shrivastava <praan@google.com>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  drivers/iommu/liveupdate.c       | 75 ++++++++++++++++++++++++++++++++
>>  include/linux/iommu-liveupdate.h | 31 +++++++++++++
>>  2 files changed, 106 insertions(+)
>>
>>diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
>>index 2d782023407d..90750e78cd2a 100644
>>--- a/drivers/iommu/liveupdate.c
>>+++ b/drivers/iommu/liveupdate.c
>>@@ -18,6 +18,17 @@
>>  #define iommu_max_objs_per_page(_array) \
>>  	((PAGE_SIZE - sizeof(struct iommu_array_hdr_ser)) / sizeof((_array)->objects[0]))
>>+#define iommu_liveupdate_for_each_obj(_arr, _obj, _idx)			\
>>+	for ((_idx) = 0, (_obj) = (_arr)->objects;			\
>>+	     (_idx) < (_arr)->hdr.nr_objects; (_idx)++, (_obj)++)	\
>>+		if (((_obj)->hdr.flags & IOMMU_SER_FLAG_DELETED))	\
>>+			continue;					\
>>+		else
>>+
>>+#define iommu_liveupdate_for_each_arr(_arr)				\
>>+	for (; (_arr); (_arr) = (_arr)->hdr.next_array_phys ?		\
>>+	     phys_to_virt((_arr)->hdr.next_array_phys) : NULL)
>>+
>>  struct iommu_flb_obj {
>>  	struct mutex lock;
>>  	struct iommu_flb_ser *ser;
>>@@ -216,6 +227,70 @@ void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
>>  }
>>  EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
>>+int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
>>+				    void *arg)
>>+{
>>+	struct iommu_flb_obj *flb_obj;
>>+	struct iommu_device_array_ser *array;
>>+	struct iommu_device_ser *device_ser;
>>+	int ret, idx;
>>+
>>+	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&flb_obj);
>>+	if (ret)
>>+		return -ENOENT;
>>+
>>+	if (!flb_obj->ser->device_array_phys)
>>+		return -ENOENT;
>>+
>>+	array = phys_to_virt(flb_obj->ser->device_array_phys);
>>+	iommu_liveupdate_for_each_arr(array) {
>>+		iommu_liveupdate_for_each_obj(array, device_ser, idx) {
>>+			ret = fn(device_ser, arg);
>>+			if (ret)
>>+				goto out;
>>+		}
>>+	}
>>+
>>+out:
>>+	liveupdate_flb_put_incoming(&iommu_flb);
>>+	return ret;
>>+}
>>+EXPORT_SYMBOL(iommu_for_each_preserved_device);
>>+
>>+struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type)
>>+{
>>+	struct iommu_hw_ser *iommu_ser = NULL;
>>+	struct iommu_hw_array_ser *array;
>>+	struct iommu_flb_obj *flb_obj;
>>+	int ret, idx;
>>+
>>+	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&flb_obj);
>>+	if (ret == -ENODATA || ret == -ENOENT)
>>+		return NULL;
>>+
>>+	if (ret)
>>+		return ERR_PTR(ret);
>
>Why does this helper return both NULL and an ERR_PTR()? Is NULL
>considered an error case here? Also, why are -ENODATA and -ENOENT
>treated differently?

NULL indicates that no preserved state exists for this iommu HW, so
setup normally as cold boot. ERR_PTR() indicates a fatal parsing or
corruption error in the KHO tree that the driver needs to explicitly
handle or abort on.

liveupdate_flb_get_incoming() returns two different errors for two
different missing-data scenarios:

-ENODATA: The system did not perform a live update.
-ENOENT: The system did perform a live update, but no data was preserved
for this specific FLB.

 From the IOMMU driver's perspective, both scenarios simply mean "proceed
with a normal cold boot," which is why we intercept them and return
NULL.

But as you suggested later, I will add kdocs for these to document all
these things.
>
>>+
>>+	if (!flb_obj->ser->iommu_array_phys) {
>>+		iommu_ser = ERR_PTR(-EINVAL);
>>+		goto out;
>>+	}
>>+
>>+	array = phys_to_virt(flb_obj->ser->iommu_array_phys);
>>+	iommu_liveupdate_for_each_arr(array) {
>>+		iommu_liveupdate_for_each_obj(array, iommu_ser, idx) {
>>+			if (iommu_ser->token == token && iommu_ser->type == type)
>>+				goto out;
>>+		}
>>+	}
>>+
>>+	iommu_ser = NULL;
>>+out:
>>+	liveupdate_flb_put_incoming(&iommu_flb);
>>+	return iommu_ser;
>>+}
>>+EXPORT_SYMBOL(iommu_get_preserved_data);
>
>These two helpers are intended for use by IOMMU drivers, correct? If so,
>please add kernel-doc style comments to document their usage and guide
>how drivers should use them.

Agreed. Will do.
>
>>+
>>  static int alloc_object_ser(void **curr_array_ptr, u64 max_objs)
>>  {
>>  	struct iommu_array_hdr_ser *curr_array = *curr_array_ptr;
>>diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
>>index f9528c94979d..5ad006892cbd 100644
>>--- a/include/linux/iommu-liveupdate.h
>>+++ b/include/linux/iommu-liveupdate.h
>>@@ -13,6 +13,8 @@
>>  #include <linux/liveupdate.h>
>>  #include <linux/kho/abi/iommu.h>
>>+typedef int (*iommu_preserved_device_iter_fn)(struct iommu_device_ser *ser,
>>+					      void *arg);
>>  #ifdef CONFIG_IOMMU_LIVEUPDATE
>>  static inline void *dev_iommu_preserved_state(struct device *dev)
>>  {
>>@@ -28,6 +30,20 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
>>  	return NULL;
>>  }
>>+static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
>>+{
>>+	struct iommu_domain_ser *ser;
>>+
>>+	ser = domain->preserved_state;
>>+	if (ser && (ser->hdr.flags & IOMMU_SER_FLAG_INCOMING))
>>+		return ser;
>>+
>>+	return NULL;
>>+}
>>+
>>+int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
>>+				    void *arg);
>>+struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type);
>>  int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser);
>>  void iommu_unpreserve_domain(struct iommu_domain *domain);
>>  int iommu_preserve_device(struct iommu_domain *domain,
>>@@ -44,6 +60,21 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
>>  	return NULL;
>>  }
>>+static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
>>+{
>>+	return NULL;
>>+}
>>+
>>+static inline int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn, void *arg)
>>+{
>>+	return -EOPNOTSUPP;
>>+}
>>+
>>+static inline struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type)
>>+{
>>+	return NULL;
>>+}
>>+
>>  static inline int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser)
>>  {
>>  	return -EOPNOTSUPP;
>
>Thanks,
>baolu
>

Thanks,
Sami
