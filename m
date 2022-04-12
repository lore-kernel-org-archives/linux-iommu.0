Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57C6C433F5
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 20:13:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6488F8195C;
	Tue, 12 Apr 2022 20:13:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ipV7OZ3q3kDe; Tue, 12 Apr 2022 20:13:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EAD4681801;
	Tue, 12 Apr 2022 20:13:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3841C0033;
	Tue, 12 Apr 2022 20:13:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 926AAC002C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 20:13:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7918340328
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 20:13:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CCiXQwqZavaC for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 20:13:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 48C3040123
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 20:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649794420;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EoTkodGmTU1+tJZgbXkA3tP7XKzNOjOQ2bLCDimVkQA=;
 b=XCfkiyiJ47Ii9FDpTqHnrtIf6ZlVZAqSZxyqo946DVMEwXrDoK1BzN3mmDlFCjWiuFCtWR
 zciwkSkdwEqWSHyt/n+CjMgj78UiXlMDsYrCrqSF34OJgybK7dmRkUmi2b4+rYZgVdjrKK
 qRkHoglq9x0Yqpqh8yuCQuhplSipCT0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-Zl3MuQs4OaSU3RW6gBGdnQ-1; Tue, 12 Apr 2022 16:13:36 -0400
X-MC-Unique: Zl3MuQs4OaSU3RW6gBGdnQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 h126-20020a1c2184000000b0038ec2634900so116856wmh.6
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 13:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=EoTkodGmTU1+tJZgbXkA3tP7XKzNOjOQ2bLCDimVkQA=;
 b=jQd/2kAU+bf5BPTRRp1YEw91CxuW/KAXEiSqAqiHtT9NxrD1uyRtitX6Og0+X/YAiQ
 YRfTnl3BEvRRPOOYdbJrJo/D743hKH5zpBryBVdrlJjEDvyAzEtZ2lsBIKsKBCAqPJ+7
 dRjXoUEigyhMC/I/Q7AFNUef8Fa5tn9tzDEwqmzcmxR9CAOG7OEqhrIXCJ/1YW0htJpj
 55CMjwYWbONZk8KMtREZ7U5qjhFzuhrOoiZxuW7W5GhxjKu/wGzYRuQs+kGHuoHHJyEB
 JG0h3q3EHfL3CLb6c1baofSTI1IZ3mo+7D2LFA8AXMKXNXPxeS8HXe9YIxFxgzseIanR
 G7MA==
X-Gm-Message-State: AOAM5328MWSogjWdVdXtLkQgQV/vgI3peghIYtknkYs6g8+IBXUCxzhT
 BE9vx/ufqrZ5KxSa1CSIGMH1Z3I2GWwxO9qu0BFuC53+hG2umfIqlGM7gCe9A6KHeOqfgeobVut
 UOo+m0OE1SCf+zVLTBKkn/QeAw01HnQ==
X-Received: by 2002:a05:600c:1e17:b0:38e:ba41:2465 with SMTP id
 ay23-20020a05600c1e1700b0038eba412465mr5500748wmb.132.1649794415685; 
 Tue, 12 Apr 2022 13:13:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuvpIudWqzfkPLFtrREp/V1SPbwn+OxDh3VdDXo20THEqWm9qcIEf5Ptz3Ekw3WUtH4dHkGw==
X-Received: by 2002:a05:600c:1e17:b0:38e:ba41:2465 with SMTP id
 ay23-20020a05600c1e1700b0038eba412465mr5500722wmb.132.1649794415455; 
 Tue, 12 Apr 2022 13:13:35 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a05600c4f5200b0038e8f9d7b57sm395024wmq.42.2022.04.12.13.13.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Apr 2022 13:13:34 -0700 (PDT)
Subject: Re: [PATCH RFC 00/12] IOMMUFD Generic interface
To: Jason Gunthorpe <jgg@nvidia.com>
References: <0-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <17084696-4b85-8fe7-47e0-b15d4c56d403@redhat.com>
Date: Tue, 12 Apr 2022 22:13:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <0-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 iommu@lists.linux-foundation.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 David Gibson <david@gibson.dropbear.id.au>
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
Reply-To: eric.auger@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

On 3/18/22 6:27 PM, Jason Gunthorpe wrote:
> iommufd is the user API to control the IOMMU subsystem as it relates to
> managing IO page tables that point at user space memory.
>
> It takes over from drivers/vfio/vfio_iommu_type1.c (aka the VFIO
> container) which is the VFIO specific interface for a similar idea.
>
> We see a broad need for extended features, some being highly IOMMU device
> specific:
>  - Binding iommu_domain's to PASID/SSID
>  - Userspace page tables, for ARM, x86 and S390
>  - Kernel bypass'd invalidation of user page tables
>  - Re-use of the KVM page table in the IOMMU
>  - Dirty page tracking in the IOMMU
>  - Runtime Increase/Decrease of IOPTE size
>  - PRI support with faults resolved in userspace

This series does not have any concept of group fds anymore and the API
is device oriented.
I have a question wrt pci bus reset capability.

8b27ee60bfd6 ("vfio-pci: PCI hot reset interface")
introduced VFIO_DEVICE_PCI_GET_HOT_RESET_INFO and VFIO_DEVICE_PCI_HOT_RESET

Maybe we can reuse VFIO_DEVICE_GET_PCI_HOT_RESET_INFO to retrieve the devices and iommu groups that need to be checked and involved in the bus reset. If I understand correctly we now need to make sure the devices are handled in the same security context (bound to the same iommufd)

however VFIO_DEVICE_PCI_HOT_RESET operate on a collection of group fds.

How do you see the porting of this functionality onto /dev/iommu?

Thanks

Eric




>
> As well as a need to access these features beyond just VFIO, VDPA for
> instance, but other classes of accelerator HW are touching on these areas
> now too.
>
> The v1 series proposed re-using the VFIO type 1 data structure, however it
> was suggested that if we are doing this big update then we should also
> come with a data structure that solves the limitations that VFIO type1
> has. Notably this addresses:
>
>  - Multiple IOAS/'containers' and multiple domains inside a single FD
>
>  - Single-pin operation no matter how many domains and containers use
>    a page
>
>  - A fine grained locking scheme supporting user managed concurrency for
>    multi-threaded map/unmap
>
>  - A pre-registration mechanism to optimize vIOMMU use cases by
>    pre-pinning pages
>
>  - Extended ioctl API that can manage these new objects and exposes
>    domains directly to user space
>
>  - domains are sharable between subsystems, eg VFIO and VDPA
>
> The bulk of this code is a new data structure design to track how the
> IOVAs are mapped to PFNs.
>
> iommufd intends to be general and consumable by any driver that wants to
> DMA to userspace. From a driver perspective it can largely be dropped in
> in-place of iommu_attach_device() and provides a uniform full feature set
> to all consumers.
>
> As this is a larger project this series is the first step. This series
> provides the iommfd "generic interface" which is designed to be suitable
> for applications like DPDK and VMM flows that are not optimized to
> specific HW scenarios. It is close to being a drop in replacement for the
> existing VFIO type 1.
>
> This is part two of three for an initial sequence:
>  - Move IOMMU Group security into the iommu layer
>    https://lore.kernel.org/linux-iommu/20220218005521.172832-1-baolu.lu@linux.intel.com/
>  * Generic IOMMUFD implementation
>  - VFIO ability to consume IOMMUFD
>    An early exploration of this is available here:
>     https://github.com/luxis1999/iommufd/commits/iommufd-v5.17-rc6
>
> Various parts of the above extended features are in WIP stages currently
> to define how their IOCTL interface should work.
>
> At this point, using the draft VFIO series, unmodified qemu has been
> tested to operate using iommufd on x86 and ARM systems.
>
> Several people have contributed directly to this work: Eric Auger, Kevin
> Tian, Lu Baolu, Nicolin Chen, Yi L Liu. Many more have participated in the
> discussions that lead here, and provided ideas. Thanks to all!
>
> This is on github: https://github.com/jgunthorpe/linux/commits/iommufd
>
> # S390 in-kernel page table walker
> Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
> # AMD Dirty page tracking
> Cc: Joao Martins <joao.m.martins@oracle.com>
> # ARM SMMU Dirty page tracking
> Cc: Keqian Zhu <zhukeqian1@huawei.com>
> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> # ARM SMMU nesting
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> # Map/unmap performance
> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> # VDPA
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> # Power
> Cc: David Gibson <david@gibson.dropbear.id.au>
> # vfio
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: kvm@vger.kernel.org
> # iommu
> Cc: iommu@lists.linux-foundation.org
> # Collaborators
> Cc: "Chaitanya Kulkarni" <chaitanyak@nvidia.com>
> Cc: Nicolin Chen <nicolinc@nvidia.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>
> Jason Gunthorpe (11):
>   interval-tree: Add a utility to iterate over spans in an interval tree
>   iommufd: File descriptor, context, kconfig and makefiles
>   kernel/user: Allow user::locked_vm to be usable for iommufd
>   iommufd: PFN handling for iopt_pages
>   iommufd: Algorithms for PFN storage
>   iommufd: Data structure to provide IOVA to PFN mapping
>   iommufd: IOCTLs for the io_pagetable
>   iommufd: Add a HW pagetable object
>   iommufd: Add kAPI toward external drivers
>   iommufd: vfio container FD ioctl compatibility
>   iommufd: Add a selftest
>
> Kevin Tian (1):
>   iommufd: Overview documentation
>
>  Documentation/userspace-api/index.rst         |    1 +
>  .../userspace-api/ioctl/ioctl-number.rst      |    1 +
>  Documentation/userspace-api/iommufd.rst       |  224 +++
>  MAINTAINERS                                   |   10 +
>  drivers/iommu/Kconfig                         |    1 +
>  drivers/iommu/Makefile                        |    2 +-
>  drivers/iommu/iommufd/Kconfig                 |   22 +
>  drivers/iommu/iommufd/Makefile                |   13 +
>  drivers/iommu/iommufd/device.c                |  274 ++++
>  drivers/iommu/iommufd/hw_pagetable.c          |  142 ++
>  drivers/iommu/iommufd/io_pagetable.c          |  890 +++++++++++
>  drivers/iommu/iommufd/io_pagetable.h          |  170 +++
>  drivers/iommu/iommufd/ioas.c                  |  252 ++++
>  drivers/iommu/iommufd/iommufd_private.h       |  231 +++
>  drivers/iommu/iommufd/iommufd_test.h          |   65 +
>  drivers/iommu/iommufd/main.c                  |  346 +++++
>  drivers/iommu/iommufd/pages.c                 | 1321 +++++++++++++++++
>  drivers/iommu/iommufd/selftest.c              |  495 ++++++
>  drivers/iommu/iommufd/vfio_compat.c           |  401 +++++
>  include/linux/interval_tree.h                 |   41 +
>  include/linux/iommufd.h                       |   50 +
>  include/linux/sched/user.h                    |    2 +-
>  include/uapi/linux/iommufd.h                  |  223 +++
>  kernel/user.c                                 |    1 +
>  lib/interval_tree.c                           |   98 ++
>  tools/testing/selftests/Makefile              |    1 +
>  tools/testing/selftests/iommu/.gitignore      |    2 +
>  tools/testing/selftests/iommu/Makefile        |   11 +
>  tools/testing/selftests/iommu/config          |    2 +
>  tools/testing/selftests/iommu/iommufd.c       | 1225 +++++++++++++++
>  30 files changed, 6515 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/userspace-api/iommufd.rst
>  create mode 100644 drivers/iommu/iommufd/Kconfig
>  create mode 100644 drivers/iommu/iommufd/Makefile
>  create mode 100644 drivers/iommu/iommufd/device.c
>  create mode 100644 drivers/iommu/iommufd/hw_pagetable.c
>  create mode 100644 drivers/iommu/iommufd/io_pagetable.c
>  create mode 100644 drivers/iommu/iommufd/io_pagetable.h
>  create mode 100644 drivers/iommu/iommufd/ioas.c
>  create mode 100644 drivers/iommu/iommufd/iommufd_private.h
>  create mode 100644 drivers/iommu/iommufd/iommufd_test.h
>  create mode 100644 drivers/iommu/iommufd/main.c
>  create mode 100644 drivers/iommu/iommufd/pages.c
>  create mode 100644 drivers/iommu/iommufd/selftest.c
>  create mode 100644 drivers/iommu/iommufd/vfio_compat.c
>  create mode 100644 include/linux/iommufd.h
>  create mode 100644 include/uapi/linux/iommufd.h
>  create mode 100644 tools/testing/selftests/iommu/.gitignore
>  create mode 100644 tools/testing/selftests/iommu/Makefile
>  create mode 100644 tools/testing/selftests/iommu/config
>  create mode 100644 tools/testing/selftests/iommu/iommufd.c
>
>
> base-commit: d1c716ed82a6bf4c35ba7be3741b9362e84cd722

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
