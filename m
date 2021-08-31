Return-Path: <SRS0=eAvY=NW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC605C432BE
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 16:16:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5C82610C9
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 16:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D5C82610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93867406E8;
	Tue, 31 Aug 2021 16:16:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K2JkEspqllqe; Tue, 31 Aug 2021 16:15:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 80A4C406F2;
	Tue, 31 Aug 2021 16:15:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6202AC001A;
	Tue, 31 Aug 2021 16:15:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0302EC000E
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 16:15:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E441140483
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 16:15:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cPUNoyj2dO1E for <iommu@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 16:15:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 871EA400C9
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 16:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630426555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iC/vqrnC8agefEfcK8F2l8XU9S2U0FJkOrhS5FcGFpE=;
 b=aSvAww/6BKbX1a9UE5sPHXFH6C8bZR9Ki4sTE2Kj0n5hCPt4ctnfF2jaE7WKVAZCRjTmaN
 MzoAYg1QZzSw7PBRQZnKj/FNadiOhQks4LHVGGLSSHH5SK+bwrxbn+hoOWTzVq5Mb/jeRi
 rYETwzx6VGCgOmfehvr9msH12IzOjec=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-HER3mXE9OB2tHBHNvYzj_A-1; Tue, 31 Aug 2021 12:15:52 -0400
X-MC-Unique: HER3mXE9OB2tHBHNvYzj_A-1
Received: by mail-il1-f197.google.com with SMTP id
 c16-20020a92cf500000b02902243aec7e27so845199ilr.22
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 09:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=iC/vqrnC8agefEfcK8F2l8XU9S2U0FJkOrhS5FcGFpE=;
 b=Y6TsLWoe+//KLHVYDCKonFJ5sEEQu7sVwAz9VnQ1teDaEM4kqg3RC/7gfx8s1bAsxX
 G2kQMD5EbEkl7M1Z85f9SCmQNN10jATrzGr1+Mcqoj4cbAOg1XWRYuhKadIQQD4FvAdN
 nHxmznX9glEWwmRae4f4eg8C9RF/ylL5jv8VP5hVZ5NP7wSzFXwGOgk1YjK08RiCARsQ
 EdJZdSuvmnvnwiCJGUZALH326pFxj+NeRh7KHD6zWNWVqGIDVFL6ihgw/TS+cCR3v88a
 NDAkk1+CTp6gLrSk/K/9n0/22fdSSJpnGB/Foa7W3cXeF55SQ7O2HsQs1tZpr+sZxU5b
 /EVQ==
X-Gm-Message-State: AOAM532QOgOc4P+4WKb1Z/BQ6KnVCki14H32GpN67+ncgQ939OXSHipW
 lRGcaMC4Kg2tga7OacZJUk6XVADrNpowWQxz/3U4l63DLKtQ4JEOtkGWfuMZvDRFmghwLIHXnVz
 9XRJQuOwdFKXAB8z+jcKIOkj2dG2a4g==
X-Received: by 2002:a92:1306:: with SMTP id 6mr10977677ilt.183.1630426552023; 
 Tue, 31 Aug 2021 09:15:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyU8Gm8fnWRjCaSBCl5W6DLLHCeLpBofrbxoK/jTZqCPsDHAV1I8o6zW03fTiw16wfuaHsuSQ==
X-Received: by 2002:a92:1306:: with SMTP id 6mr10977660ilt.183.1630426551786; 
 Tue, 31 Aug 2021 09:15:51 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id u13sm9685406iot.29.2021.08.31.09.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Aug 2021 09:15:51 -0700 (PDT)
Date: Tue, 31 Aug 2021 10:15:49 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [RFC][PATCH v2 00/13] iommu/arm-smmu-v3: Add NVIDIA implementation
Message-ID: <20210831101549.237151fa.alex.williamson@redhat.com>
In-Reply-To: <20210831025923.15812-1-nicolinc@nvidia.com>
References: <20210831025923.15812-1-nicolinc@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, thierry.reding@gmail.com,
 will@kernel.org, jean-philippe@linaro.org, corbet@lwn.net,
 Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 cohuck@redhat.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com
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

On Mon, 30 Aug 2021 19:59:10 -0700
Nicolin Chen <nicolinc@nvidia.com> wrote:

> The SMMUv3 devices implemented in the Grace SoC support NVIDIA's custom
> CMDQ-Virtualization (CMDQV) hardware. Like the new ECMDQ feature first
> introduced in the ARM SMMUv3.3 specification, CMDQV adds multiple VCMDQ
> interfaces to supplement the single architected SMMU_CMDQ in an effort
> to reduce contention.
> 
> This series of patches add CMDQV support with its preparational changes:
> 
> * PATCH-1 to PATCH-8 are related to shared VMID feature: they are used
>   first to improve TLB utilization, second to bind a shared VMID with a
>   VCMDQ interface for hardware configuring requirement.

The vfio changes would need to be implemented in alignment with the
/dev/iommu proposals[1].  AIUI, the VMID is essentially binding
multiple containers together for TLB invalidation, which I expect in
the proposal below is largely already taken care of in that a single
iommu-fd can support multiple I/O address spaces and it's largely
expected that a hypervisor would use a single iommu-fd so this explicit
connection by userspace across containers wouldn't be necessary.

We're expecting to talk more about the /dev/iommu approach at Plumbers
in few weeks.  Thanks,

Alex

[1]https://lore.kernel.org/kvm/BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com/

 
> * PATCH-9 and PATCH-10 are to accommodate the NVIDIA implementation with
>   the existing arm-smmu-v3 driver.
> 
> * PATCH-11 borrows the "implementation infrastructure" from the arm-smmu
>   driver so later change can build upon it.
> 
> * PATCH-12 adds an initial NVIDIA implementation related to host feature,
>   and also adds implementation specific ->device_reset() and ->get_cmdq()
>   callback functions.
> 
> * PATCH-13 adds virtualization features using VFIO mdev interface, which
>   allows user space hypervisor to map and get access to one of the VCMDQ
>   interfaces of CMDQV module.
> 
> ( Thinking that reviewers can get a better view of this implementation,
>   I am attaching QEMU changes here for reference purpose:
>       https://github.com/nicolinc/qemu/commits/dev/cmdqv_v6.0.0-rc2
>   The branch has all preparational changes, while I'm still integrating
>   device model and ARM-VIRT changes, and will push them these two days,
>   although they might not be in a good shape of being sent to review yet )
> 
> Above all, I marked RFC for this series, as I feel that we may come up
> some better solution. So please kindly share your reviews and insights.
> 
> Thank you!
> 
> Changelog
> v1->v2:
>  * Added mdev interface support for hypervisor and VMs.
>  * Added preparational changes for mdev interface implementation.
>  * PATCH-12 Changed ->issue_cmdlist() to ->get_cmdq() for a better
>    integration with recently merged ECMDQ-related changes.
> 
> Nate Watterson (3):
>   iommu/arm-smmu-v3: Add implementation infrastructure
>   iommu/arm-smmu-v3: Add support for NVIDIA CMDQ-Virtualization hw
>   iommu/nvidia-smmu-v3: Add mdev interface support
> 
> Nicolin Chen (10):
>   iommu: Add set_nesting_vmid/get_nesting_vmid functions
>   vfio: add VFIO_IOMMU_GET_VMID and VFIO_IOMMU_SET_VMID
>   vfio: Document VMID control for IOMMU Virtualization
>   vfio: add set_vmid and get_vmid for vfio_iommu_type1
>   vfio/type1: Implement set_vmid and get_vmid
>   vfio/type1: Set/get VMID to/from iommu driver
>   iommu/arm-smmu-v3: Add shared VMID support for NESTING
>   iommu/arm-smmu-v3: Add VMID alloc/free helpers
>   iommu/arm-smmu-v3: Pass dev pointer to arm_smmu_detach_dev
>   iommu/arm-smmu-v3: Pass cmdq pointer in arm_smmu_cmdq_issue_cmdlist()
> 
>  Documentation/driver-api/vfio.rst             |   34 +
>  MAINTAINERS                                   |    2 +
>  drivers/iommu/arm/arm-smmu-v3/Makefile        |    2 +-
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-impl.c  |   15 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  121 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   18 +
>  .../iommu/arm/arm-smmu-v3/nvidia-smmu-v3.c    | 1249 +++++++++++++++++
>  drivers/iommu/iommu.c                         |   20 +
>  drivers/vfio/vfio.c                           |   25 +
>  drivers/vfio/vfio_iommu_type1.c               |   37 +
>  include/linux/iommu.h                         |    5 +
>  include/linux/vfio.h                          |    2 +
>  include/uapi/linux/vfio.h                     |   26 +
>  13 files changed, 1537 insertions(+), 19 deletions(-)
>  create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-impl.c
>  create mode 100644 drivers/iommu/arm/arm-smmu-v3/nvidia-smmu-v3.c
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
