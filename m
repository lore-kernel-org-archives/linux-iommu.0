Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FCB189525
	for <iommu@lists.linux.dev>; Thu, 12 Sep 2024 08:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726129524; cv=none; b=T+z6j56Lbrhg6Ww5qOoBYqUDg6jfPD8wGIMfZBeATgvWx0dw+yAOQ35YMMIlMOfVzaO9MEaLBpnTjKTXWXMXoex8rd31BZk6JZBdNvn1LLyYXGGHsAqUwAPhkAYzs0fFP+pw9xmnpujtvLs8ou3y2/zknT5WADjS32Sy6/7HJS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726129524; c=relaxed/simple;
	bh=MKy/9tghYKa19Qryp4SxU/qnpAH3k2uZkEgWRU4oCAQ=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=h9tR1R5ddbG3cJdOcEtMeghXtYojAJb+mD7iTMj1PtqWymJko8Ynd20q92ZjyMW0oE/+cqjODiwL/Ia/hg74C2pYr8BglHPlPbc6uZX/rjPVCjx6TcPeVCNtvokiEZlNec2B/9BcA9ERKQee+styoxeE4eA4EqFVBfqJ7UdkbXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LZ1Ju8vj; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LZ1Ju8vj"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240912082518euoutp0239d46338a5f30d631ddba6e9bf674f08~0cabkzCGe2710927109euoutp02k
	for <iommu@lists.linux.dev>; Thu, 12 Sep 2024 08:25:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240912082518euoutp0239d46338a5f30d631ddba6e9bf674f08~0cabkzCGe2710927109euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726129518;
	bh=5gP0HL0ZgmHvRmsDVrWRCzhrW97FfQ2q5HSxCEk8Vm4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=LZ1Ju8vj+oJiQR1lnPrjx094zhnvn4+WBbb4sYjjfM7LcJ3VFBqvgcwtHeMjgvIRK
	 XkGYEJqgXaQcB34jREHQA+hjp119+SuMM+u5AA2Y69Nu6x2PsPMr9WGVfBmDnmREMu
	 DPuGxiJehWeOJXxqnWHmSbW8QOAksMXb2Hl479Ao=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240912082518eucas1p2835505abbd20f8d69c1616fabac4e682~0cabSDvUH2861728617eucas1p2p;
	Thu, 12 Sep 2024 08:25:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 51.D0.09620.E65A2E66; Thu, 12
	Sep 2024 09:25:18 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240912082517eucas1p243ac7848411b0a8a202783941d2b6246~0caas5QRj2863828638eucas1p2m;
	Thu, 12 Sep 2024 08:25:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240912082517eusmtrp16dc3541ee8fa3482f29f1980be1c0f3b~0caar86__3085630856eusmtrp15;
	Thu, 12 Sep 2024 08:25:17 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-de-66e2a56e46ff
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 72.38.19096.D65A2E66; Thu, 12
	Sep 2024 09:25:17 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240912082517eusmtip19a1b6a9358973d02c3b417768b52464c~0caaXtpUR1562015620eusmtip1H;
	Thu, 12 Sep 2024 08:25:17 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 12 Sep 2024 09:25:16 +0100
Date: Thu, 12 Sep 2024 10:25:12 +0200
From: Joel Granados <j.granados@samsung.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jason
	Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Klaus Jensen
	<its@irrelevant.dk>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH 5/6] iommu: init pasid array while doing domain_replace
 and iopf is active
Message-ID: <20240912082512.ydzmmlwpvkcukbt2@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b7a68539-3a3c-4cd9-922b-bfb9db8e7e0b@linux.intel.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djP87p5Sx+lGUydIWixeeJWNouJKycz
	W/z6YmGx/+A3VouZM04wWnTO3sBusfTtVnaLy7vmsFkc/PCE1aLljqkDl8eTg/OYPNbMW8Po
	sXmFlsfiPS+ZPM7tOM/usWlVJ5vHvJOBHi82z2T0+LxJzmPr59ssAVxRXDYpqTmZZalF+nYJ
	XBlXFu9kLVimV/HrtVcD41S1LkZODgkBE4n/vU+Zuhi5OIQEVjBKPJr5nhHC+cIoMeHlFxYI
	5zOjxLOlF5lgWrbteMAOkVjOKLFkyXM2uKqPG5cwQzibGSVaPiwFGsbBwSKgKrF/iyBIN5uA
	jsT5N3eYQWwRAXWJpsa9YM3MAhuZJOb+OwyWEBZIkJj59wwTSC+vgIPE6+NWIGFeAUGJkzOf
	sIDYzEBzFuz+xAZSwiwgLbH8HweIySngLLHsTBrEnYoSXxffY4GwayVObbkF9qaEwHxOifv3
	ZzFDJFwkdizZywphC0u8Or6FHcKWkTg9uYcFomEyo8T+fx/YIZzVjBLLGr9Cg8JaouXKE6gO
	R4m+z91gN0sI8EnceCsIcSefxKRt05khwrwSHW1CENVqEqvvvWGZwKg8C8lns5B8NgvhswWM
	zKsYxVNLi3PTU4uN81LL9YoTc4tL89L1kvNzNzECU9bpf8e/7mBc8eqj3iFGJg7GQ4wSHMxK
	IryT2B6lCfGmJFZWpRblxxeV5qQWH2KU5mBREudVTZFPFRJITyxJzU5NLUgtgskycXBKNTB5
	JDxUWH98onCp+f//PV++xLwIfvrxw78XX82vzAnNnsj1q0XD/43M0r6qb9u4Dj++YBSVz5Mx
	89D2yzvOPRS1vbTFcuHLHr7tK9l3vr2l9zBbvULtsHa29deuX1YN16/NuVB3Pd1aXzNQU2Ma
	x4Mz4UoPpm2QXrPtzP3ff0NvR7OUd+tmv8iTrt8tEfR7M9vHMEerFmf29uarUzN4s8691hK+
	9CLlQ436fyW7pkd5s3mjk87u9++8YW0q098bEKlaEiTrx5jywsPoRGKR5NJv+bUMTFNYWcTW
	qO3k2s6dFKJ7T6i2452gcEf//TtecUzbgzfNzWnk59kg+Hzy5NBFrHcVtDbeT158Qt+weosS
	S3FGoqEWc1FxIgBv+ZNiyAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t/xu7q5Sx+lGZy/qGGxeeJWNouJKycz
	W/z6YmGx/+A3VouZM04wWnTO3sBusfTtVnaLy7vmsFkc/PCE1aLljqkDl8eTg/OYPNbMW8Po
	sXmFlsfiPS+ZPM7tOM/usWlVJ5vHvJOBHi82z2T0+LxJzmPr59ssAVxRejZF+aUlqQoZ+cUl
	tkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehlXFu9kLVimV/HrtVcD41S1
	LkZODgkBE4ltOx6wdzFycQgJLGWUmLTlKStEQkZi45erULawxJ9rXWwQRR8ZJVa8/MIM4Wxm
	lHj/6glLFyMHB4uAqsT+LYIgDWwCOhLn39xhBrFFBNQlmhr3gjUzC2xkkrhxrokJJCEskCAx
	8+8ZJpBeXgEHidfHrSBmfmKSuP70DRtIDa+AoMTJmSDzOYGadSQW7P7EBlLPLCAtsfwfB4jJ
	KeAssexMGsSdihJfF99jgbBrJT7/fcY4gVF4FpJBs5AMmoUwaAEj8ypGkdTS4tz03GIjveLE
	3OLSvHS95PzcTYzAuN127OeWHYwrX33UO8TIxMF4iFGCg1lJhHcS26M0Id6UxMqq1KL8+KLS
	nNTiQ4ymwICYyCwlmpwPTBx5JfGGZgamhiZmlgamlmbGSuK8bFfOpwkJpCeWpGanphakFsH0
	MXFwSjUwuQe7PM++dvGKycdFBtGd93yeBP+MD2jfnG4w1+NMfUj5iqcTLHa+Sbdql7DbenTZ
	3Smfk7b6ukbcqJDapsK1PsFG32q1rVNJYnJPzocEfSuRrybLVZbtY17x5RujWuvJl/tPMf8S
	sZsvuuK91iROH68VPQuS9NXadz5bG9CmtoJrLdfCEBOBX+tut2/fm2Pw1WrzNs87SZ4Lv4u9
	mv9l49HOixPzfTznP+C405i5T3nzj9cvdip2Ft7t3/gq2syYPWHbbT/Ovr1/8qU//H//PHiK
	2bVS+Zvczw/nHPK9xfo3YLHAqd/nf+dW7w8Or2tMi3Do2PU1uM+mNm1r+O107zRdH1nuWc/v
	uF0PVeO+qMRSnJFoqMVcVJwIACsqfYFkAwAA
X-CMS-MailID: 20240912082517eucas1p243ac7848411b0a8a202783941d2b6246
X-Msg-Generator: CA
X-RootMTR: 20240905033408eucas1p2ad508d4f3377f4daa38f28bf6c3d1118
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240905033408eucas1p2ad508d4f3377f4daa38f28bf6c3d1118
References: <20240904-jag-iopfv8-v1-0-e3549920adf3@samsung.com>
	<20240904-jag-iopfv8-v1-5-e3549920adf3@samsung.com>
	<CGME20240905033408eucas1p2ad508d4f3377f4daa38f28bf6c3d1118@eucas1p2.samsung.com>
	<c2e765a8-d935-42db-bd22-c12e7960f2f0@linux.intel.com>
	<20240911105657.iesajd4d5va3wc5y@joelS2.panther.com>
	<b7a68539-3a3c-4cd9-922b-bfb9db8e7e0b@linux.intel.com>

On Thu, Sep 12, 2024 at 12:21:53PM +0800, Baolu Lu wrote:
> On 9/11/24 6:56 PM, Joel Granados wrote:
> > On Thu, Sep 05, 2024 at 11:30:05AM +0800, Baolu Lu wrote:
> >> On 9/4/24 9:17 PM, Joel Granados via B4 Relay wrote:
> >>> From: Joel Granados<j.granados@samsung.com>
> >>>
> >>> iommu_report_device_fault expects a pasid array to have an
> >>> iommu_attach_handle when a fault is detected.
> >> The iommu_attach_handle is expected only when an iopf-capable domain is
> >> attached to the device or PASID. The iommu_report_device_fault() treats
> >> it as a fault when a fault occurs, but no iopf-capable domain is
> >> attached.
> >>
> >>> Add this handle when the
> >>> replacing hwpt has a valid iommufd fault object. Remove it when we
> >>> release ownership of the group.
> >> The iommu_attach_handle is managed by the caller (iommufd here for
> >> example). Therefore, before iommu_attach_handle tries to attach a domain
> >> to an iopf-capable device or pasid, it should allocate the handle and
> >> pass it to the domain attachment interfaces.
> > What do you mean here?
> > 1. Do you want to move the iommufd_init_pasid_array call up to
> > iommufd_hwpt_replace_device?
> > 2. Do you want to move it further up to iommufd_device_do_replace?
> 
> I'm having trouble understanding the need for iommu_init_pasid_array()
> in the core.

The iommu_init_pasid_array function is there because I needed to access
struct iommu_group->pasid_array. The struct declaration for iommu_group
is in the core (drivers/iommu/iommu.c), so I thought that the function
to modify a member of that struct would go in core also.

To move all the logic into iommufd_init_pasid_array in iommufd, we would
need to move the iommu_group struct (include/linux/iommu.h?). Here is a
proposed patch that would make that happen (and removes
iommu_init_pasid_array). What do you think?


diff --git i/drivers/iommu/iommu-priv.h w/drivers/iommu/iommu-priv.h
index 493e501badc7..de5b54eaa8bf 100644
--- i/drivers/iommu/iommu-priv.h
+++ w/drivers/iommu/iommu-priv.h
@@ -38,9 +38,6 @@ void iommu_device_unregister_bus(struct iommu_device *iommu,
 struct iommu_attach_handle *iommu_attach_handle_get(struct iommu_group *group,
 						    ioasid_t pasid,
 						    unsigned int type);
-int iommu_init_pasid_array(struct iommu_domain *domain,
-			   struct iommu_group *group,
-			   struct iommu_attach_handle *handle);
 int iommu_attach_group_handle(struct iommu_domain *domain,
 			      struct iommu_group *group,
 			      struct iommu_attach_handle *handle);
diff --git i/drivers/iommu/iommu.c w/drivers/iommu/iommu.c
index 64ae1cf571aa..83bc0bfd7bb0 100644
--- i/drivers/iommu/iommu.c
+++ w/drivers/iommu/iommu.c
@@ -44,24 +44,6 @@ static unsigned int iommu_def_domain_type __read_mostly;
 static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
 static u32 iommu_cmd_line __read_mostly;
 
-struct iommu_group {
-	struct kobject kobj;
-	struct kobject *devices_kobj;
-	struct list_head devices;
-	struct xarray pasid_array;
-	struct mutex mutex;
-	void *iommu_data;
-	void (*iommu_data_release)(void *iommu_data);
-	char *name;
-	int id;
-	struct iommu_domain *default_domain;
-	struct iommu_domain *blocking_domain;
-	struct iommu_domain *domain;
-	struct list_head entry;
-	unsigned int owner_cnt;
-	void *owner;
-};
-
 struct group_device {
 	struct list_head list;
 	struct device *dev;
@@ -3498,33 +3480,6 @@ iommu_attach_handle_get(struct iommu_group *group, ioasid_t pasid, unsigned int
 }
 EXPORT_SYMBOL_NS_GPL(iommu_attach_handle_get, IOMMUFD_INTERNAL);
 
-/**
- * iommu_init_pasid_array - Initialize pasid array in the domain group
- *
- * Returns 0 on success. Error code on failure
- *
- * An IOMMU_NO_PASID element is *NOT* replaced if there is one already there.
- */
-int iommu_init_pasid_array(struct iommu_domain *domain,
-			   struct iommu_group *group,
-			   struct iommu_attach_handle *handle)
-{
-	int ret;
-
-	if (handle)
-		handle->domain = domain;
-
-	mutex_lock(&group->mutex);
-	ret = xa_insert(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
-	mutex_unlock(&group->mutex);
-
-	if (ret == -EBUSY)
-		ret = 0;
-
-	return ret;
-}
-EXPORT_SYMBOL_NS_GPL(iommu_init_pasid_array, IOMMUFD_INTERNAL);
-
 /**
  * iommu_attach_group_handle - Attach an IOMMU domain to an IOMMU group
  * @domain: IOMMU domain to attach
diff --git i/drivers/iommu/iommufd/fault.c w/drivers/iommu/iommufd/fault.c
index ea7f1bf64892..51cb70465b87 100644
--- i/drivers/iommu/iommufd/fault.c
+++ w/drivers/iommu/iommufd/fault.c
@@ -189,8 +189,15 @@ static int iommufd_init_pasid_array(struct iommu_domain *domain,
 	if (!handle)
 		return -ENOMEM;
 	handle->idev = idev;
+	handle->handle.domain = domain;
+
+	mutex_lock(&group->mutex);
+	ret = xa_insert(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
+	mutex_unlock(&group->mutex);
+
+	if (ret == -EBUSY)
+		ret = 0;
 
-	ret = iommu_init_pasid_array(domain, group, &handle->handle);
 	if (ret)
 		kfree(handle);
 
diff --git i/include/linux/iommu.h w/include/linux/iommu.h
index bd722f473635..c34aa737aeb2 100644
--- i/include/linux/iommu.h
+++ w/include/linux/iommu.h
@@ -31,8 +31,25 @@
  */
 #define IOMMU_PRIV	(1 << 5)
 
+struct iommu_group {
+	struct kobject kobj;
+	struct kobject *devices_kobj;
+	struct list_head devices;
+	struct xarray pasid_array;
+	struct mutex mutex;
+	void *iommu_data;
+	void (*iommu_data_release)(void *iommu_data);
+	char *name;
+	int id;
+	struct iommu_domain *default_domain;
+	struct iommu_domain *blocking_domain;
+	struct iommu_domain *domain;
+	struct list_head entry;
+	unsigned int owner_cnt;
+	void *owner;
+};
+
 struct iommu_ops;
-struct iommu_group;
 struct bus_type;
 struct device;
 struct iommu_domain;



-- 

Joel Granados
