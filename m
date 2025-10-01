Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1391228642E
	for <iommu@lists.linux.dev>; Wed,  1 Oct 2025 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334336; cv=none; b=Zrjt8bUMmboCUHDyuLMXcFPWzltQ3p0hjiOK4tNaRup7xMB6r5i9sP5yuOt04aCVOvaOroAk29rTfsK/vr9xRLGW1mvg9x6Jv9n8Q7pXQojJ9wTiHAyvpnEhyoRbFAPBZUDjjW76I9g1UA0GBGAh3HELqaF5beXpElRIhA0f0hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334336; c=relaxed/simple;
	bh=pdz8Fuw7xeerW7PMZ/xqhVUHiIjhMYLhhkVWLjrs8Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/TK9Zr0Zk/FLxmP71Oetw/AFdJNtXaXduidIds2ZEz8oqLK6srJfndr3OqlBIuYVNbWqq8XWtzAKendkSlSXODqXZWNF1GWS99cnigpDrIy4ZQeX688ClY46Tt5bKqFK9YKwlDcLPval946V2b3VAJusOO47J9BypXvgSKmPZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=e1yVqqBD; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="e1yVqqBD"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-782bfd0a977so70719b3a.3
        for <iommu@lists.linux.dev>; Wed, 01 Oct 2025 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759334333; x=1759939133; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N4HyuyQkoHBvYzsGa6aoQI9vTUKAsw5OI/i9bKDk1gM=;
        b=e1yVqqBDFor4cyj2kSlAHH6nf6D9G2N7Dhx45mdCxH6MKBN0gv+mRuBw9363p1Bq7h
         8/mwVZ/IAyiu8c9apXWs3x9biZlF3mQBKPo8Vu80fR4H5UTauVwewQ9kwZaRn5rTJo3z
         78wyfUcGIzYp+KTXgEUgZjYvcGTe8t7rNxgxx4Zim0XROQYIxZVjp31npnTjj9/hUFg2
         vkhupc4Dbc5mn+xLvdHRGPlnKx3uHtIutoL3ycUOZiMiDoxjoeomTaYwTxlwIj+FH9Q2
         tnQ5o8Edi593ZRrOpS10Ex8ZyvHkjc6Rl5xAbpO/PP9Bj8PUp6+sHkasXJgZTGxff10q
         ERJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759334333; x=1759939133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4HyuyQkoHBvYzsGa6aoQI9vTUKAsw5OI/i9bKDk1gM=;
        b=KT5fzYWYnCcnm+xvk7kGg/WjBWegBzq3ynmQ8o8uiRnvnggKG7sfJiKAUGAiMmiAsA
         uDA/xztWFluA1KPJoobTV7lvcylWWbzfXTOpQQsgx/8K+qtsXz0qOlGFPlfd5QlBYXVt
         5UqpSjZu/qienJst+NWC0GUmnoJZToR4R8FG0z1oslvUhHYQAsVqxpkVq8+5QdRQXxEO
         Sbc+7OoxKOyFvX0+inydNoYfxfgEW37XjhbxRfEM2DTtL8tOTWfFHbXKTrZjIOLWSxwr
         esnpqlc65HFG6v+AVbN47noYycaP9kxwiFcWy+k6tgocuoi4GJDfPHp62gYg5GOXvGW+
         c94A==
X-Forwarded-Encrypted: i=1; AJvYcCX+SZzOurVkTfIshyyN/vS+B2M+F3BJER7tO0KkQuNPCiyfyREn8FOsVSu0Q85OcOCdTM9/3A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVv+ckAayfW88HLpud3Bdt13qcxofuolZfOfw5RJjplAtfW96b
	oGzlbM0tHMepu2wEQJUR5b6+G7um3oPWexK5GCjLd/QAxEAPciSr5lopb21Fn4SkvS4=
X-Gm-Gg: ASbGncu/i9X1p007h73WuH40fsuugCfaL6lS0VJ37YwEfrN1fWnFT5XP+dECfqeAPvo
	oE1OGILPDTHc4Bbic3Sh/FokDY7/LqaCOSOJcVmdIw2txu5Wm7WOiCnR3UKO5u+AanvUk6mWsSl
	WR+grRxbQdH94A8uG1P9nYKvAa+pfTnGM/RpvQi89QCWKLUoGTLwymu6iUoBBoENS5rxIk/TXbQ
	M675X4oZypRUbJ90pEbP2GOjfL5eXrgYSFYVfMFkP5+qxgQnxiLdHSBl2QEi0CNVuz/ndExlWXh
	aFxIijgF9qwFrZJHNX2vXbz8lGcoJERnGocrc8xcJSNyfxGfsHWeWwdy8kk/gkM4GVMbtBr3974
	eCuZhugp2i3f+GMRhm0e9rjaJqe/VuoI=
X-Google-Smtp-Source: AGHT+IG9UPo6cxHRJt4pSeinOZAd23m8t66DoVx2m4sPdAYJV7/Vd4Ao/dqW0fHs4d80dy+cLnFnxg==
X-Received: by 2002:a05:6a20:3946:b0:24c:dd96:5500 with SMTP id adf61e73a8af0-321d8452e58mr4960078637.11.1759334333229;
        Wed, 01 Oct 2025 08:58:53 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b020537ebsm90602b3a.47.2025.10.01.08.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 08:58:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3zEB-0000000D4OH-1Yy4;
	Wed, 01 Oct 2025 12:58:51 -0300
Date: Wed, 1 Oct 2025 12:58:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Johan Hovold <johan@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] iommu: fix device leaks
Message-ID: <20251001155851.GW2695987@ziepe.ca>
References: <20250925122756.10910-1-johan@kernel.org>
 <20250930182158.GS2695987@ziepe.ca>
 <0d5d4d02-eb78-43dc-8784-83c0760099f7@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d5d4d02-eb78-43dc-8784-83c0760099f7@arm.com>

On Tue, Sep 30, 2025 at 08:35:01PM +0100, Robin Murphy wrote:
> On 2025-09-30 7:21 pm, Jason Gunthorpe wrote:
> > On Thu, Sep 25, 2025 at 02:27:42PM +0200, Johan Hovold wrote:
> > > This series fixes device leaks in the iommu drivers, which pretty
> > > consistently failed to drop the reference taken by
> > > of_find_device_by_node() when looking up iommu platform devices.
> > 
> > Yes, they are mis-designed in many ways :\
> 
> Historically they weren't really leaks either, just spare references on a
> device which at that point could definitely never go away. I suppose now
> that we finally have the .of_xlate calls in IOMMU registration, it would be
> possible for some error during probe to cause the IOMMU driver to fail to
> bind, at which point the references could rightly be considered leaked,
> however these are all embedded platforms with essentially zero chance of
> platform device hotplug, especially not of IOMMU devices, so realistically
> those references still don't matter to anything other than code checkers.
> 
> In summary; meh.

Yeah, it isn't a real practical bug, but it still ugly and no doubt
upsets static tools.

> > IDK if it is worth fixing like this, or if more effort should be put
> > to make the drivers use of_xlate properly - the arm smmu drivers show
> > the only way to use it..
> 
> The SMMU drivers are really doing the same thing, they just defer that
> lookup operation to .probe_device time (largely for historical reasons, I
> think), and they use bus_find_device_by_node() 

However the SMMU drivers are doing this under the
iommu_probe_device_lock and not stashing the pointer into a drvdata
where there is no locking protecting it. 

> It's not racy; if we're calling the .of_xlate op (or really any op for that
> matter), it's because an IOMMU driver has registered (or is registering) for
> the given fwnode, which means it is bound to the corresponding struct
> device.

It is not racy if you make the very practical assumption there is no
iommu driver unplug.

Anyhow, I drafted a nice fix for all of this. After all the rework it
is trivial for the core code to pass in the struct iommu_device * to
probe and then most of the drivers just drop this ugly code
completely.

https://github.com/jgunthorpe/linux/commits/iommu-fwspec/

Jason

commit cca42a9b5325b96bfd3d74e24628511f537afbe9
Author: Jason Gunthorpe <jgg@ziepe.ca>
Date:   Wed Oct 1 09:18:13 2025 -0300

    iommu: Add a probe_device_fwspec() op
    
    For fwspec using drivers the core code has already determined which struct
    iommu_device instance the fwspec is linked to. It can trivially pass that
    instance pointer into the driver.
    
    This frees fwspec drivers from having to repeat the work of trying to find
    the struct iommu_device for the fwspec.
    
    Non-fwspec drivers (x86/etc) continue to use the old probe function which
    is called on the first non-fwspec iommu driver registered.
    
    This is only usable by drivers that support a single iommu instance per
    device. There are some drivers (msm, exynos, dart) that do have an iommus
    property that list multiple iommu_devices with multiple IDs. They cannot
    use this simplified mechanism.
    
    Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 060ebe330ee163..718a1da8f54710 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -142,6 +142,8 @@ static void __iommu_group_free_device(struct iommu_group *group,
 				      struct group_device *grp_dev);
 static void iommu_domain_init(struct iommu_domain *domain, unsigned int type,
 			      const struct iommu_ops *ops);
+static struct iommu_device *
+iommu_from_fwnode(const struct fwnode_handle *fwnode);
 
 #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
 struct iommu_group_attribute iommu_group_attr_##_name =		\
@@ -406,13 +408,75 @@ void dev_iommu_priv_set(struct device *dev, void *priv)
 }
 EXPORT_SYMBOL_GPL(dev_iommu_priv_set);
 
+static int iommu_do_probe_device(struct device *dev)
+{
+	struct iommu_device *iommu;
+	int ret;
+
+	lockdep_assert_held(&iommu_probe_device_lock);
+
+	if (dev->iommu->fwspec) {
+		struct iommu_device *fwspec_iommu;
+
+		fwspec_iommu =
+			iommu_from_fwnode(dev->iommu->fwspec->iommu_fwnode);
+		if (!fwspec_iommu)
+			return -ENODEV;
+
+		if (fwspec_iommu->ops->probe_device_fwspec) {
+			ret = fwspec_iommu->ops->probe_device_fwspec(
+				fwspec_iommu, dev);
+			if (ret)
+				return ret;
+			iommu = fwspec_iommu;
+		} else {
+			iommu = fwspec_iommu->ops->probe_device(dev);
+			if (IS_ERR(iommu))
+				return PTR_ERR(iommu);
+			if (WARN_ON(iommu != fwspec_iommu)) {
+				ret = -EINVAL;
+				goto err_release;
+			}
+		}
+	} else {
+		/*
+		 * At this point, relevant devices either now have a fwspec
+		 * which will match ops registered with a non-NULL fwnode, or we
+		 * can reasonably assume that only one of Intel, AMD, s390, PAMU
+		 * or legacy SMMUv2 can be present, and that any of their
+		 * registered instances has suitable ops for probing, and thus
+		 * cheekily co-opt the same mechanism.
+		 */
+		iommu = iommu_from_fwnode(NULL);
+		if (!iommu)
+			return -ENODEV;
+		/* Non fwspec drivers must identify their instance internally */
+		if (WARN_ON(!iommu->ops->probe_device))
+			return -EINVAL;
+		iommu = iommu->ops->probe_device(dev);
+		if (IS_ERR(iommu))
+			return PTR_ERR(iommu);
+	}
+
+	if (!try_module_get(iommu->ops->owner)) {
+		ret = -EINVAL;
+		goto err_release;
+	}
+
+	dev->iommu->iommu_dev = iommu;
+
+err_release:
+	if (iommu->ops->release_device)
+		iommu->ops->release_device(dev);
+	return ret;
+}
+
 /*
  * Init the dev->iommu and dev->iommu_group in the struct device and get the
  * driver probed
  */
 static int iommu_init_device(struct device *dev)
 {
-	const struct iommu_ops *ops;
 	struct iommu_device *iommu_dev;
 	struct iommu_group *group;
 	int ret;
@@ -434,36 +498,17 @@ static int iommu_init_device(struct device *dev)
 		if (!dev->iommu || dev->iommu_group)
 			return -ENODEV;
 	}
-	/*
-	 * At this point, relevant devices either now have a fwspec which will
-	 * match ops registered with a non-NULL fwnode, or we can reasonably
-	 * assume that only one of Intel, AMD, s390, PAMU or legacy SMMUv2 can
-	 * be present, and that any of their registered instances has suitable
-	 * ops for probing, and thus cheekily co-opt the same mechanism.
-	 */
-	ops = iommu_fwspec_ops(dev->iommu->fwspec);
-	if (!ops) {
-		ret = -ENODEV;
-		goto err_free;
-	}
 
-	if (!try_module_get(ops->owner)) {
-		ret = -EINVAL;
+	ret = iommu_do_probe_device(dev);
+	if (ret)
 		goto err_free;
-	}
-
-	iommu_dev = ops->probe_device(dev);
-	if (IS_ERR(iommu_dev)) {
-		ret = PTR_ERR(iommu_dev);
-		goto err_module_put;
-	}
-	dev->iommu->iommu_dev = iommu_dev;
+	iommu_dev = dev->iommu->iommu_dev;
 
 	ret = iommu_device_link(iommu_dev, dev);
 	if (ret)
 		goto err_release;
 
-	group = ops->device_group(dev);
+	group = iommu_dev->ops->device_group(dev);
 	if (WARN_ON_ONCE(group == NULL))
 		group = ERR_PTR(-EINVAL);
 	if (IS_ERR(group)) {
@@ -473,17 +518,17 @@ static int iommu_init_device(struct device *dev)
 	dev->iommu_group = group;
 
 	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
-	if (ops->is_attach_deferred)
-		dev->iommu->attach_deferred = ops->is_attach_deferred(dev);
+	if (iommu_dev->ops->is_attach_deferred)
+		dev->iommu->attach_deferred =
+			iommu_dev->ops->is_attach_deferred(dev);
 	return 0;
 
 err_unlink:
 	iommu_device_unlink(iommu_dev, dev);
 err_release:
-	if (ops->release_device)
-		ops->release_device(dev);
-err_module_put:
-	module_put(ops->owner);
+	if (iommu_dev->ops->release_device)
+		iommu_dev->ops->release_device(dev);
+	module_put(iommu_dev->ops->owner);
 err_free:
 	dev->iommu->iommu_dev = NULL;
 	dev_iommu_free(dev);
@@ -2855,9 +2900,10 @@ bool iommu_default_passthrough(void)
 }
 EXPORT_SYMBOL_GPL(iommu_default_passthrough);
 
-static const struct iommu_device *iommu_from_fwnode(const struct fwnode_handle *fwnode)
+static struct iommu_device *iommu_from_fwnode(
+	const struct fwnode_handle *fwnode)
 {
-	const struct iommu_device *iommu, *ret = NULL;
+	struct iommu_device *iommu, *ret = NULL;
 
 	spin_lock(&iommu_device_lock);
 	list_for_each_entry(iommu, &iommu_device_list, list)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c30d12e16473df..52e74ccdb4dc79 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -48,6 +48,7 @@ struct iommufd_ctx;
 struct iommufd_viommu;
 struct msi_desc;
 struct msi_msg;
+struct iommu_device;
 
 #define IOMMU_FAULT_PERM_READ	(1 << 0) /* read */
 #define IOMMU_FAULT_PERM_WRITE	(1 << 1) /* write */
@@ -680,6 +681,8 @@ struct iommu_ops {
 		struct device *dev, struct iommu_domain *parent, u32 flags,
 		const struct iommu_user_data *user_data);
 
+	int (*probe_device_fwspec)(struct iommu_device *iommu,
+				   struct device *dev);
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
 	void (*probe_finalize)(struct device *dev);
