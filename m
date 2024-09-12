Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF4B18BBAF
	for <iommu@lists.linux.dev>; Thu, 12 Sep 2024 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135274; cv=none; b=GxFyG8HRMIEee3ExTSWIC/fIFVyhXzvd3TWoKo8l2K7+cPuuC/+4Fbed928kGexOFnZJe1U80KAzkXbs1FCGO5om+p77Td6OmYxKBNuniOhGlsFB+22c/On1x5FU4nail5xSPH9ItPI/xOF7Q0YxOO6bQefR4IrCg8Cz3/JfnQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135274; c=relaxed/simple;
	bh=ZJbpese5RZT8YL1u8KtGYTsz4zXxz+MqpuybLonvrHI=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=oIKDurTOByWMJKNzoRT1GsWNysNKR001TpZ7JOc1r43+VtiUL9OoLzVKv7wqynpRuF2JCaJkaKKrO4fe9hc7wJVV9T2cSzlNWBiRs6j9P6qGybAaHS1NByjk/+Kd5kIJls34yeN9RWjsJ8S0Vlb6GxbPLkmOGTR0dGdlAqH9Xeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oEyH99Il; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oEyH99Il"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240912100104euoutp0108b8337c430e77b577b716b55233b165~0duCpnfjN1431714317euoutp013
	for <iommu@lists.linux.dev>; Thu, 12 Sep 2024 10:01:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240912100104euoutp0108b8337c430e77b577b716b55233b165~0duCpnfjN1431714317euoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726135264;
	bh=3SM6XCwkhoPIiqGRlmU90zlGgBibxjG4qVHDIdzFxMg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=oEyH99IlYO65MEfqxSSH2rZ8o4iV9FUvHD+K/aXG89B+j0a3qkNcVxd4MNpC+oqiM
	 qHL6yKx5BmoDk+aFruTEb0xVCmQjj84OZmvbGlYaOs7qdxlo3ZTBUSsKWwZMbzJkDy
	 BKQ7DLajpcBnxkHixErVV3Cy91ch6akGJ3j+scN8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240912100104eucas1p29c2d20c13c46ef55d9f7fb7e2f5c5af0~0duCSJKM-1249412494eucas1p2o;
	Thu, 12 Sep 2024 10:01:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 22.F1.09624.FDBB2E66; Thu, 12
	Sep 2024 11:01:03 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240912100103eucas1p18874d5b8478f49be488672c830f85aa6~0duBveOnT2672626726eucas1p1R;
	Thu, 12 Sep 2024 10:01:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240912100103eusmtrp26159b1c98b975d4c9dcf9a783a105a59~0duBupyJk0753107531eusmtrp2G;
	Thu, 12 Sep 2024 10:01:03 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-e8-66e2bbdfce55
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id A0.E9.19096.FDBB2E66; Thu, 12
	Sep 2024 11:01:03 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240912100103eusmtip2645ce8b54654d24a3e29a3d1aaa0abb4~0duBg58OW2944229442eusmtip28;
	Thu, 12 Sep 2024 10:01:03 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 12 Sep 2024 11:01:02 +0100
Date: Thu, 12 Sep 2024 12:00:58 +0200
From: Joel Granados <j.granados@samsung.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jason
	Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Klaus Jensen
	<its@irrelevant.dk>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH 5/6] iommu: init pasid array while doing domain_replace
 and iopf is active
Message-ID: <20240912100058.gnu2bzytexhdfq7e@joelS2.panther.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7djPc7r3dz9KM3j4y9Ji88StbBYTV05m
	tvj1xcJi/8FvrBYzZ5xgtOicvYHdYunbrewWl3fNYbM4+OEJq0XLHVMHLo8nB+cxeayZt4bR
	Y/MKLY/Fe14yeZzbcZ7dY9OqTjaPeScDPV5snsno8XmTnMfWz7dZAriiuGxSUnMyy1KL9O0S
	uDL2HJ7DWjBBpOLFvldsDYzP+LsYOTkkBEwkNraeYe1i5OIQEljBKNGxbgs7hPOFUWLjxJdQ
	zmdGiceXL7DAtExfMYkFIrGcUeL68W+McFW/fj9ihnA2M0o8OzONDaSFRUBVYvb1E0wgNpuA
	jsT5N3eYQWwRAXWJpsa9bCANzAIbmSTm/jsMlhAWSJCY+fcMWAOvgIPEv1Wd7BC2oMTJmU/A
	7mAGGrRg9yegZg4gW1pi+T8OEJNTwFli2Zk0iEsVJb4uvgd1da3EqS23mEBWSQjM5pS4sm4/
	E0TCRWLJqYvsELawxKvjW6BsGYn/O+dDNUxmlNj/7wM7hLOaUWJZ41eobmuJlitPoDocJfo+
	dzOBXCEhwCdx460gxJ18EpO2TWeGCPNKdLQJQVSrSay+94ZlAqPyLCSfzULy2SyEzxYwMq9i
	FE8tLc5NTy02zEst1ytOzC0uzUvXS87P3cQITFyn/x3/tINx7quPeocYmTgYDzFKcDArifBO
	YnuUJsSbklhZlVqUH19UmpNafIhRmoNFSZxXNUU+VUggPbEkNTs1tSC1CCbLxMEp1cDUXPG6
	0l/59f1/dxhldtoH3tk1Pbzoueiyljl25tVV/ZVWVu59PO6ti3jeMfyWEz8s88w9YZmq47sn
	6rHOn3ifsiknqMlcn/fj0J074oe6+lzPuu/v3p3vz/Gv+of6iXfcU3murHmZXpK4XC5iqvtf
	3l/zrN+k66ZkL+PgCsiU2rywPpDZ3iSlP/b9V1d+gYZG7f0zf779FH9X+JTV/WD1f4ezcmwc
	eR5GuSyNtnRLl11faPvK9dDyCxldll9mpEnu4uibkCn0QKqR52vjPE+/lRN1/L6b5a7urquR
	vrS2+raNymnfSZbhRYXhBov2N0+anvLkUvSSypUZtloPItUvbDyuLWRjvejsxssfzJRYijMS
	DbWYi4oTAd7j6tbLAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7r3dz9KM9h6Ttxi88StbBYTV05m
	tvj1xcJi/8FvrBYzZ5xgtOicvYHdYunbrewWl3fNYbM4+OEJq0XLHVMHLo8nB+cxeayZt4bR
	Y/MKLY/Fe14yeZzbcZ7dY9OqTjaPeScDPV5snsno8XmTnMfWz7dZArii9GyK8ktLUhUy8otL
	bJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DL2HJ7DWjBBpOLFvldsDYzP
	+LsYOTkkBEwkpq+YxNLFyMUhJLCUUWLbzFusEAkZiY1frkLZwhJ/rnWxQRR9ZJSYdmU7K4Sz
	mVHi6cZpYFUsAqoSs6+fYAKx2QR0JM6/ucMMYosIqEs0Ne4F62YW2MgkceNcE1iRsECCxMy/
	Z8BsXgEHiX+rOtkhpn5ikrj+9A0bREJQ4uTMJywgNjPQ1AW7PwHFOYBsaYnl/zhATE4BZ4ll
	Z9IgLlWU+Lr4HguEXSvx+e8zxgmMwrOQDJqFZNAshEELGJlXMYqklhbnpucWG+kVJ+YWl+al
	6yXn525iBEbvtmM/t+xgXPnqo94hRiYOxkOMEhzMSiK8k9gepQnxpiRWVqUW5ccXleakFh9i
	NAUGxURmKdHkfGD6yCuJNzQzMDU0MbM0MLU0M1YS52W7cj5NSCA9sSQ1OzW1ILUIpo+Jg1Oq
	gcnZaLVgNf/qFTXvMs4v2f9Mm2/NgbuKQf6f+g0vM5QvdVWVney9TvXWS81SCbUP639/fep5
	a0/4XPXlDP+OfxK/Oml2QtCSl7P/qT+oif1wZ/114Y+TDvc08qxP3mUv98NnxYzFsQHyRXwv
	DNZG8Z90fn3i0pxNf0RbpM9e39/96ErpdoWVKX/qfIzPes9ydxF5EKHrXvVXrG9/xL0FXBfW
	G9U/mjXxrtnOFUesT4cIm0yxd97QWFbLwfr29IoN1h2N9p3MFpU5p29Mv3/ZikGtgi0557FL
	VI6/iRZnqrZ2ec0HTW/ep3X/16turQ9+w2J88t16h1wPHqYnz3NkfibcaPiwUVDCYRv36jVR
	rkVKLMUZiYZazEXFiQDFg3CuZwMAAA==
X-CMS-MailID: 20240912100103eucas1p18874d5b8478f49be488672c830f85aa6
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
> 
> > 
> > Note that all this implemented on a call to replace HWPT. So a
> > non-iopf-capable VFIO_DEVICE_ATTACH_IOMMUFD_PT ioctl has already been
> > completed before the one that calls iommufd_device_do_replace.
> > 
> >> Conversely, the handle can
> >> only be freed after the domain is detached.
> > Do you have a function in specific where you would put the free handle
> > logic?
> 
> drivers/iommu/iommufd/fault.c
> 
> void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
>                                       struct iommufd_device *idev)
> {
>          struct iommufd_attach_handle *handle;
> 
>          handle = iommufd_device_get_attach_handle(idev);
>          iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
>          iommufd_auto_response_faults(hwpt, handle);
>          iommufd_fault_iopf_disable(idev);
>          kfree(handle);
> }
Actually there is no need to add the xa_erase call in
__iommu_release_dma_ownership because it is *already* handled here.
Sorry about this, I think this was left from a previous version of the
patch. I'll remove the superfluous xa_erase call.

Thx for the review

-- 

Joel Granados
