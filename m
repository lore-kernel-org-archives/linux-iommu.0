Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4FF7DA9E
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729662; cv=none; b=Ikco4xhun+8vs0dbTiF5DMRSR/gHK9Z99OaI877pJuyr16U7hxxqEwFxarh+QQ3CSHwwbBkE/j/h63krlqxp3mMRPCKA3J8S17dIgSZQ0CphDsGTZXYSGy5yRCz+o9nY/OEuldF1uslt+e4aVx1XjqQ4ElOLzs0rz28/W7mWvL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729662; c=relaxed/simple;
	bh=r6VsstRMrT5syvZUZae6rwGhopent4gI6U1kktcOCMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTislcTlsVy+TPa8E0V7oVQNGqRC3QiMy8HJHrN70PXIa8Lp3zfN73WCULJHFnCixLljd75Q3g5+hFb/KF3ueSAeV+7DDNDSyI+PjwMfrqODfJU4XylZP5CPeIUyh5LvOq9yg3idfvRbBcX245/xp5Flv1pTYF3oYKswUa1F1r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hA9aiqQq; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hA9aiqQq"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6bf7ba05f75so8806d6.0
        for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 06:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723729659; x=1724334459; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j8+ZnkDmWlql4KNTK0vB0RBkvVNTOOTwpEr2tIvVp8I=;
        b=hA9aiqQqAG/UPpYb+DjNej0ZT7goQs75EI18u3cVwP4qtPN1TmozRG6E6nNc0oiORp
         rA92wWvmKrplMMV4FXvqQkYMrAzGV/qAIWA4M+GXL54GsmLRK4rUjwQjofehYVyhmrc8
         jhhAez18x2vco6jCfGtk4MM+fLPyDMD3ka9aVTzj6KWq4+MSOTTJsmUtxnAVjymo1M/Y
         66qoswhCLYoNElGvtEqzJNkxerDjSloVOkytdYk9t83nwtLNBXtpt0+u1IxERISDjTNd
         nqbACpTaXWvO9DEOxIvZxk34+aNiHhZecFWZc7TXDUPhwQHH/Cx5AHd1ddc67LihB60f
         gfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723729659; x=1724334459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8+ZnkDmWlql4KNTK0vB0RBkvVNTOOTwpEr2tIvVp8I=;
        b=Mu80UNwelszhvMwHAN2VjfcVpFHp0Ocsiy9SVMBw3iJjoepbq34tdrV9rfag+B71p+
         6TVq82JBfacPUwCgGV9qinjrqA6R82mWHFgQQ7Z4cmxVrRHPHJuLQnxG9eTaA+6CYt3c
         ijCjfrTNIEeaLCEStn8YSntrZorr0F/ZtuT1oM0LEcikoChyqDbb7sk6cVF45iEwT4E3
         71dD9WgdVeZ8HK/vRWM1jeOe+GfzI/Yr6L4DQseKk9br1zcMwCcS9Mn3MNeUhxPl7J4H
         +e9rjhCMM8U7M1SxI1e8B8/lHG5Aa5dsLIWpVYdvsFlKgZLF/2r7ZlMqzBbPv6sUz2dA
         8H1A==
X-Forwarded-Encrypted: i=1; AJvYcCVM8DepQX6hSnruGLjCGL47ZajQLzpsGROy/N+Xtqygt+M1sBGU6E3LQaE3vT7R1aKVxc6hGf2FZEEy1DOogPzZEVlUcQw=
X-Gm-Message-State: AOJu0YzzCWMT+Ey7jCItsKPRU2BJo/hJKonc8A+4cK01OcQJh97P1a/7
	Fm+nA9DZP2Zb4vLgKk0imiYS7A4lJfjM8y2h2X9ZnDbPVQmXaWrycR6xpD6HFrU=
X-Google-Smtp-Source: AGHT+IEPHMnEKGKKzX1EyMh2R54vqhE5bzcb0SU22bkaq/r5NAlS7DkSXtfGfH3UPHJwYcYoTr1tug==
X-Received: by 2002:a05:6214:2026:b0:6b5:d90d:ea4f with SMTP id 6a1803df08f44-6bf6ddd2a8dmr53712556d6.15.1723729658959;
        Thu, 15 Aug 2024 06:47:38 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fef3124sm6441676d6.123.2024.08.15.06.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 06:47:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1seapF-003EVS-7Y;
	Thu, 15 Aug 2024 10:47:37 -0300
Date: Thu, 15 Aug 2024 10:47:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
Message-ID: <20240815134737.GK3468552@ziepe.ca>
References: <bbe564b6-5079-4973-8678-1068a53ddf70@amd.com>
 <20240807135915.GF8473@ziepe.ca>
 <e5da0709-86d3-4b45-82cc-d995a2686afa@amd.com>
 <20240807182947.GI8473@ziepe.ca>
 <BN9PR11MB52765C37F5401E9AA7113D748C862@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240813162044.GI1985367@ziepe.ca>
 <BN9PR11MB527654EBEFE7CBDD37B7B4068C872@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240814224045.GC3468552@ziepe.ca>
 <ad009d03-9a38-4b0e-ac90-13bd8ea0b191@amd.com>
 <60778628-2b2c-4671-b1c6-276db3cd42ea@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60778628-2b2c-4671-b1c6-276db3cd42ea@linux.intel.com>

On Thu, Aug 15, 2024 at 12:59:13PM +0800, Baolu Lu wrote:
> I suppose that this also includes converting paging domain to user
> domain allocation in VFIO (ideally vhost-vdpa as well), right?

Another thought is to add a flag to iommu_paging_domain_alloc()..

Maybe like the below. The small duplication with
__iommu_domain_alloc() would go away when iommu_domain_alloc() finally
goes, then we'd be able to directly call iommu_paging_domain_alloc().

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ed6c5cb60c5aee..7c028d036e8a1a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1934,6 +1934,22 @@ void iommu_set_fault_handler(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_set_fault_handler);
 
+static void iommu_domain_init(struct iommu_domain *domain, unsigned int type,
+			      const struct iommu_ops *ops)
+{
+	domain->type = type;
+	domain->owner = ops;
+	if (!domain->ops)
+		domain->ops = ops->default_domain_ops;
+
+	/*
+	 * If not already set, assume all sizes by default; the driver
+	 * may override this later
+	 */
+	if (!domain->pgsize_bitmap)
+		domain->pgsize_bitmap = ops->pgsize_bitmap;
+}
+
 static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
 						 struct device *dev,
 						 unsigned int type)
@@ -1962,27 +1978,7 @@ static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
-	domain->type = type;
-	domain->owner = ops;
-	/*
-	 * If not already set, assume all sizes by default; the driver
-	 * may override this later
-	 */
-	if (!domain->pgsize_bitmap)
-		domain->pgsize_bitmap = ops->pgsize_bitmap;
-
-	if (!domain->ops)
-		domain->ops = ops->default_domain_ops;
-
-	if (iommu_is_dma_domain(domain)) {
-		int rc;
-
-		rc = iommu_get_dma_cookie(domain);
-		if (rc) {
-			iommu_domain_free(domain);
-			return ERR_PTR(rc);
-		}
-	}
+	iommu_domain_init(domain, type, ops);
 	return domain;
 }
 
@@ -2031,20 +2027,40 @@ struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
 EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 
 /**
- * iommu_paging_domain_alloc() - Allocate a paging domain
+ * iommu_paging_domain_alloc_flags() - Allocate a paging domain
  * @dev: device for which the domain is allocated
+ * @flags: Bitmap of iommufd_hwpt_alloc_flags
  *
  * Allocate a paging domain which will be managed by a kernel driver. Return
  * allocated domain if successful, or a ERR pointer for failure.
  */
-struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
+struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
+						     unsigned int flags)
 {
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+	struct iommu_domain *domain;
+
 	if (!dev_has_iommu(dev))
 		return ERR_PTR(-ENODEV);
 
-	return __iommu_domain_alloc(dev_iommu_ops(dev), dev, IOMMU_DOMAIN_UNMANAGED);
+	if (ops->domain_alloc_paging && !flags)
+		domain = ops->domain_alloc_paging(dev);
+	else if (ops->domain_alloc_user)
+		domain = ops->domain_alloc_user(dev, flags, NULL, NULL);
+	else if (ops->domain_alloc && !flags)
+		domain = ops->domain_alloc(IOMMU_DOMAIN_UNMANAGED);
+	else
+		return ERR_PTR(-EOPNOTSUPP);
+
+	if (IS_ERR(domain))
+		return domain;
+	if (!domain)
+		return ERR_PTR(-ENOMEM);
+
+	iommu_domain_init(domain, IOMMU_DOMAIN_UNMANAGED, ops);
+	return domain;
 }
-EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc);
+EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc_flags);
 
 void iommu_domain_free(struct iommu_domain *domain)
 {
@@ -2965,6 +2981,14 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 	if (group->default_domain == dom)
 		return 0;
 
+	if (iommu_is_dma_domain(dom)) {
+		ret = iommu_get_dma_cookie(dom);
+		if (ret) {
+			iommu_domain_free(dom);
+			return ret;
+		}
+	}
+
 	/*
 	 * IOMMU_RESV_DIRECT and IOMMU_RESV_DIRECT_RELAXABLE regions must be
 	 * mapped before their device is attached, in order to guarantee
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 4d47f2c3331185..8648be89834014 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -511,8 +511,8 @@ static inline int __iommu_copy_struct_from_user_array(
  *                the caller iommu_domain_alloc() returns.
  * @domain_alloc_user: Allocate an iommu domain corresponding to the input
  *                     parameters as defined in include/uapi/linux/iommufd.h.
- *                     Unlike @domain_alloc, it is called only by IOMMUFD and
- *                     must fully initialize the new domain before return.
+ *                     Unlike @domain_alloc, it must fully initialize the new
+ *                     domain before return.
  *                     Upon success, if the @user_data is valid and the @parent
  *                     points to a kernel-managed domain, the new domain must be
  *                     IOMMU_DOMAIN_NESTED type; otherwise, the @parent must be
@@ -789,7 +789,11 @@ extern bool iommu_present(const struct bus_type *bus);
 extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
 extern bool iommu_group_has_isolated_msi(struct iommu_group *group);
 extern struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus);
-struct iommu_domain *iommu_paging_domain_alloc(struct device *dev);
+struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev, unsigned int flags);
+static inline struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
+{
+	return iommu_paging_domain_alloc_flags(dev, 0);
+}
 extern void iommu_domain_free(struct iommu_domain *domain);
 extern int iommu_attach_device(struct iommu_domain *domain,
 			       struct device *dev);
@@ -1098,6 +1102,12 @@ static inline struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus
 	return NULL;
 }
 
+struct inline iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
+							    unsigned int flags)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
 {
 	return ERR_PTR(-ENODEV);
