Return-Path: <SRS0=6oxg=MB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97028C07E99
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 21:51:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C67F613BE
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 21:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C67F613BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B058240249;
	Fri,  9 Jul 2021 21:51:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VHWhMp38ttQy; Fri,  9 Jul 2021 21:51:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AD9914015F;
	Fri,  9 Jul 2021 21:51:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 851CEC001A;
	Fri,  9 Jul 2021 21:51:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A92D2C000E
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 21:51:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9089283BB2
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 21:51:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pZ8alV_Hduae for <iommu@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 21:51:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 503A983BAE
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 21:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625867458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cYFRJYtkCRYSwbBeuspb80ScbjnAcRth61HuqIcGc/M=;
 b=SKWkbegf1xj0khthghnLaNHxxbiSqZs5DJZPOLPh2OS9Ea8olK25/lbsqcKj8vJlCIvhyG
 VenulfIE/efG+zi8H3QA8+na3j5CNqDKEI6IF7oShmQrx8bPvWuzqBtKouejZwMgULU1WC
 YhDX3wzSXkcxkG1pPLF4iQqbFXZHqZA=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-lVcmeJ3lM7KKPbOshVam1g-1; Fri, 09 Jul 2021 17:50:55 -0400
X-MC-Unique: lVcmeJ3lM7KKPbOshVam1g-1
Received: by mail-oi1-f198.google.com with SMTP id
 w18-20020a0568080d52b029023e3c1124c9so7476533oik.11
 for <iommu@lists.linux-foundation.org>; Fri, 09 Jul 2021 14:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=cYFRJYtkCRYSwbBeuspb80ScbjnAcRth61HuqIcGc/M=;
 b=ZAl5nknp0UN1mnTA7M1cbYLIfpJ216Mi+SOTL1B68YAyUynG1d0/0mWsNVj9eBby4T
 S4brJ61IH1YI2fwISTWtO1Wo3X22s/vQZURAyRe+RWzNkijMkhTA9GG3Xsda2eE/o5PI
 jno055UkajsD+pFePpH63WJgKdp+K32OlAYzt9a1Ztz2d+JPUm1/bAcBnPBD2JqjQQLM
 JUmB5WEJOIBpKNsF2f9fQGEiLaM70CnpTZT7o403k1/AAIVerSGJc4uwkg3RbQYkxRJA
 dD6+FVj+eAdf+CMpUx/qV8NGp5x+ymZlqNDCb6JqBCNmXkhfATHJ9Y1r6TrY+rLCJIHq
 vjww==
X-Gm-Message-State: AOAM533KI5q4Gco/i2a29QQ1TSh5de9apBWVLd1XJroIf24+nUj56F+G
 6E5JMJPU3DEieh8soqWUI45bDHyACI3dFXPDv2ozziWXImoKIH9tnG5oM3MsOvr9dNy1QxsqEK+
 GLeHqb1himpUQn9RoE/YNl0Nmkq5EFQ==
X-Received: by 2002:a9d:6c07:: with SMTP id f7mr24277014otq.50.1625867454972; 
 Fri, 09 Jul 2021 14:50:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+FH/VKC81T3oJHpy4CfTZrogqZcbjZ5kiSX2v2Sq28gDIrDnUNTIBqPRDiCXLbKtbcCZA7w==
X-Received: by 2002:a9d:6c07:: with SMTP id f7mr24276979otq.50.1625867454680; 
 Fri, 09 Jul 2021 14:50:54 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id f3sm1490493otc.49.2021.07.09.14.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jul 2021 14:50:54 -0700 (PDT)
Date: Fri, 9 Jul 2021 15:50:52 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC v2] /dev/iommu uAPI proposal
Message-ID: <20210709155052.2881f561.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@nvidia.com>,
 "parav@mellanox.com" <parav@mellanox.com>, "Enrico Weigelt,
 metux IT consult" <lkml@metux.net>, David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Kevin,

A couple first pass comments...

On Fri, 9 Jul 2021 07:48:44 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:
> 2.2. /dev/vfio device uAPI
> ++++++++++++++++++++++++++
> 
> /*
>   * Bind a vfio_device to the specified IOMMU fd
>   *
>   * The user should provide a device cookie when calling this ioctl. The 
>   * cookie is later used in IOMMU fd for capability query, iotlb invalidation
>   * and I/O fault handling.
>   *
>   * User is not allowed to access the device before the binding operation
>   * is completed.
>   *
>   * Unbind is automatically conducted when device fd is closed.
>   *
>   * Input parameters:
>   *	- iommu_fd;
>   *	- cookie;
>   *
>   * Return: 0 on success, -errno on failure.
>   */
> #define VFIO_BIND_IOMMU_FD	_IO(VFIO_TYPE, VFIO_BASE + 22)

I believe this is an ioctl on the device fd, therefore it should be
named VFIO_DEVICE_BIND_IOMMU_FD.

> 
> 
> /*
>   * Report vPASID info to userspace via VFIO_DEVICE_GET_INFO
>   *
>   * Add a new device capability. The presence indicates that the user
>   * is allowed to create multiple I/O address spaces on this device. The
>   * capability further includes following flags:
>   *
>   *	- PASID_DELEGATED, if clear every vPASID must be registered to 
>   *	  the kernel;
>   *	- PASID_CPU, if set vPASID is allowed to be carried in the CPU 
>   *	  instructions (e.g. ENQCMD);
>   *	- PASID_CPU_VIRT, if set require vPASID translation in the CPU; 
>   * 
>   * The user must check that all devices with PASID_CPU set have the 
>   * same setting on PASID_CPU_VIRT. If mismatching, it should enable 
>   * vPASID only in one category (all set, or all clear).
>   *
>   * When the user enables vPASID on the device with PASID_CPU_VIRT
>   * set, it must enable vPASID CPU translation via kvm fd before attempting
>   * to use ENQCMD to submit work items. The command portal is blocked 
>   * by the kernel until the CPU translation is enabled.
>   */
> #define VFIO_DEVICE_INFO_CAP_PASID		5
> 
> 
> /*
>   * Attach a vfio device to the specified IOASID
>   *
>   * Multiple vfio devices can be attached to the same IOASID, and vice 
>   * versa. 
>   *
>   * User may optionally provide a "virtual PASID" to mark an I/O page 
>   * table on this vfio device, if PASID_DELEGATED is not set in device info. 
>   * Whether the virtual PASID is physically used or converted to another 
>   * kernel-allocated PASID is a policy in the kernel.
>   *
>   * Because one device is allowed to bind to multiple IOMMU fd's, the
>   * user should provide both iommu_fd and ioasid for this attach operation.
>   *
>   * Input parameter:
>   *	- iommu_fd;
>   *	- ioasid;
>   *	- flag;
>   *	- vpasid (if specified);
>   * 
>   * Return: 0 on success, -errno on failure.
>   */
> #define VFIO_ATTACH_IOASID		_IO(VFIO_TYPE, VFIO_BASE + 23)
> #define VFIO_DETACH_IOASID		_IO(VFIO_TYPE, VFIO_BASE + 24)

Likewise, VFIO_DEVICE_{ATTACH,DETACH}_IOASID

...
> 3. Sample structures and helper functions
> --------------------------------------------------------
> 
> Three helper functions are provided to support VFIO_BIND_IOMMU_FD:
> 
> 	struct iommu_ctx *iommu_ctx_fdget(int fd);
> 	struct iommu_dev *iommu_register_device(struct iommu_ctx *ctx,
> 		struct device *device, u64 cookie);
> 	int iommu_unregister_device(struct iommu_dev *dev);
> 
> An iommu_ctx is created for each fd:
> 
> 	struct iommu_ctx {
> 		// a list of allocated IOASID data's
> 		struct xarray		ioasid_xa;
> 
> 		// a list of registered devices
> 		struct xarray		dev_xa;
> 	};
> 
> Later some group-tracking fields will be also introduced to support 
> multi-devices group.
> 
> Each registered device is represented by iommu_dev:
> 
> 	struct iommu_dev {
> 		struct iommu_ctx	*ctx;
> 		// always be the physical device
> 		struct device 		*device;
> 		u64			cookie;
> 		struct kref		kref;
> 	};
> 
> A successful binding establishes a security context for the bound
> device and returns struct iommu_dev pointer to the caller. After this
> point, the user is allowed to query device capabilities via IOMMU_
> DEVICE_GET_INFO.

If we have an initial singleton group only restriction, I assume that
both iommu_register_device() would fail for any devices that are not in
a singleton group and vfio would only expose direct device files for
the devices in singleton groups.  The latter implementation could
change when multi-device group support is added so that userspace can
assume that if the vfio device file exists, this interface is available.
I think this is confirmed further below.

> For mdev the struct device should be the pointer to the parent device. 

I don't get how iommu_register_device() differentiates an mdev from a
pdev in this case.

...
> 4.3. IOASID nesting (software)
> ++++++++++++++++++++++++++++++
> 
> Same usage scenario as 4.2, with software-based IOASID nesting 
> available. In this mode it is the kernel instead of user to create the
> shadow mapping.
> 
> The flow before guest boots is same as 4.2, except one point. Because 
> giova_ioasid is nested on gpa_ioasid, locked accounting is only 
> conducted for gpa_ioasid which becomes the only root.
> 
> There could be a case where different gpa_ioasids are created due
> to incompatible format between dev1/dev2 (e.g. about IOMMU 
> enforce-snoop). In such case the user could further created a dummy
> IOASID (HVA->HVA) as the root parent for two gpa_ioasids to avoid 
> duplicated accounting. But this scenario is not covered in following 
> flows.

This use case has been noted several times in the proposal, it probably
deserves an example.

> 
> To save space we only list the steps after boots (i.e. both dev1/dev2
> have been attached to gpa_ioasid before guest boots):
> 
> 	/* After boots */
> 	/* Create GIOVA space nested on GPA space
> 	 * Both page tables are managed by the kernel
> 	 */
> 	alloc_data = {.user_pgtable = false; .parent = gpa_ioasid};
> 	giova_ioasid = ioctl(iommu_fd, IOMMU_IOASID_ALLOC, &alloc_data);

So the user would use IOMMU_DEVICE_GET_INFO on the iommu_fd with device
cookie2 after the VFIO_DEVICE_BIND_IOMMU_FD to learn that software
nesting is supported before proceeding down this path?

> 
> 	/* Attach dev2 to the new address space (child)
> 	 * Note dev2 is still attached to gpa_ioasid (parent)
> 	 */
> 	at_data = { .fd = iommu_fd; .ioasid = giova_ioasid};
> 	ioctl(device_fd2, VFIO_ATTACH_IOASID, &at_data);
> 
> 	/* Setup a GIOVA [0x2000] ->GPA [0x1000] mapping for giova_ioasid, 
> 	 * based on the vIOMMU page table. The kernel is responsible for
> 	 * creating the shadow mapping GIOVA [0x2000] -> HVA [0x40001000]
> 	 * by walking the parent's I/O page table to find out GPA [0x1000] ->
> 	 * HVA [0x40001000].
> 	 */
> 	dma_map = {
> 		.ioasid	= giova_ioasid;
> 		.iova	= 0x2000;	// GIOVA
> 		.vaddr	= 0x1000;	// GPA
> 		.size	= 4KB;
> 	};
> 	ioctl(iommu_fd, IOMMU_MAP_DMA, &dma_map);
> 
> 4.4. IOASID nesting (hardware)
> ++++++++++++++++++++++++++++++
> 
> Same usage scenario as 4.2, with hardware-based IOASID nesting
> available. In this mode the I/O page table is managed by userspace
> thus an invalidation interface is used for the user to request iotlb
> invalidation.
> 
> 	/* After boots */
> 	/* Create GIOVA space nested on GPA space.
> 	 * Claim it's an user-managed I/O page table.
> 	 */
> 	alloc_data = {
> 		.user_pgtable	= true;
> 		.parent		= gpa_ioasid;
> 		.addr		= giova_pgtable;
> 		// and format information;
> 	};
> 	giova_ioasid = ioctl(iommu_fd, IOMMU_IOASID_ALLOC, &alloc_data);
> 
> 	/* Attach dev2 to the new address space (child)
> 	 * Note dev2 is still attached to gpa_ioasid (parent)
> 	 */
> 	at_data = { .fd = iommu_fd; .ioasid = giova_ioasid};
> 	ioctl(device_fd2, VFIO_ATTACH_IOASID, &at_data);
> 
> 	/* Invalidate IOTLB when required */
> 	inv_data = {
> 		.ioasid	= giova_ioasid;
> 		// granular/cache type information
> 	};
> 	ioctl(iommu_fd, IOMMU_INVALIDATE_CACHE, &inv_data);
> 
> 	/* See 4.6 for I/O page fault handling */
> 	
> 4.5. Guest SVA (vSVA)
> +++++++++++++++++++++
> 
> After boots the guest further creates a GVA address spaces (vpasid1) on 
> dev1. Dev2 is not affected (still attached to giova_ioasid).
> 
> As explained in section 1.4, the user should check the PASID capability
> exposed via VFIO_DEVICE_GET_INFO and follow the required uAPI
> semantics when doing the attaching call:

And this characteristic lives in VFIO_DEVICE_GET_INFO rather than
IOMMU_DEVICE_GET_INFO because this is a characteristic known by the
vfio device driver rather than the system IOMMU, right?  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
