Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1162AC433EF
	for <iommu@archiver.kernel.org>; Thu, 10 Mar 2022 09:47:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1C19611C2;
	Thu, 10 Mar 2022 09:47:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PQfasOuJ74EH; Thu, 10 Mar 2022 09:47:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 39D7860FBF;
	Thu, 10 Mar 2022 09:47:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E74FC001D;
	Thu, 10 Mar 2022 09:47:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 076CFC000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Mar 2022 09:47:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D0E7B40A2F
 for <iommu@lists.linux-foundation.org>; Thu, 10 Mar 2022 09:47:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kU_fY0MhDVZD for <iommu@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 09:47:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 53A19400C9
 for <iommu@lists.linux-foundation.org>; Thu, 10 Mar 2022 09:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646905619;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BJj1yH1VXfhLvRJ8+zGrbpkPmlf5E1ndVM90qQ671Jg=;
 b=IwK/r9iSevY9Rv2K0Q3zT68I2jpmN8D1vGBZL1DCpRCPj6wNRUxcxJBzWQuVeEKH/6Ytf4
 uLUD3AERhwtzIw1muSsn3Jdqd7TrCI2My8XF4njvCwTKky+VYESnGHTCkj/kHyBiD88BJK
 OWcc3i91yBNwDpRi3Ch/A7EoNNvE1tY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-xJXJfkY6Nh-EUCEkrdvztQ-1; Thu, 10 Mar 2022 04:46:56 -0500
X-MC-Unique: xJXJfkY6Nh-EUCEkrdvztQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 a26-20020a7bc1da000000b003857205ec7cso2083185wmj.2
 for <iommu@lists.linux-foundation.org>; Thu, 10 Mar 2022 01:46:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=BJj1yH1VXfhLvRJ8+zGrbpkPmlf5E1ndVM90qQ671Jg=;
 b=cKTW513QIXQo1AZk5Flq7Wk6iHo4ldsXf+w/xvgfn0MevubOajUWEYqQ778QD+CISn
 Tc9AgwYtNeH8qprxCKsbjP2FuOCD4B04xgdFyCxfY6Fu8NKNTar3bEpMX7zS+l0EG/2S
 +sTWT5/ph7KV84sjd4km5fjagQ1eFcnxhwnsf8Tn1LbGhblg3bnlcBfIxLVols1Mus/Y
 LNppi0vZwR/yRiiGG5yf+tLu1Eds8QtX86UIse6nYFLB69gG4sPEMFUJI/JsGbizKT7x
 sf1cCqeDJgvVS9w19S5dhi/P9NCx+PxLwXWVg8CIjA6pw54RE6y0hrjdU7ZRmxka8wh0
 wTzQ==
X-Gm-Message-State: AOAM530RWbK2UCP2mZKrWzK5sHHXndh3nZXlLDmUl+BSd/R3yUYXPC2y
 pIvBnvpDmblStrXsAqd04sJkfEbFkQJW7TK97R8YJ9BtjpBOC76NXITm7i8xk/+OoWKl70C1nZe
 RofoZjbcPA2rPY3SgUmBezfz4JaODXg==
X-Received: by 2002:a5d:5009:0:b0:1f1:f87e:2e26 with SMTP id
 e9-20020a5d5009000000b001f1f87e2e26mr2912954wrt.404.1646905614783; 
 Thu, 10 Mar 2022 01:46:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz7wzT+XTVpeEzBUmQvpXc+eICuFzdxvcvXTNLQwGJIuVjVygEpg34U15LBeet6UiFJhxQ4/g==
X-Received: by 2002:a5d:5009:0:b0:1f1:f87e:2e26 with SMTP id
 e9-20020a5d5009000000b001f1f87e2e26mr2912935wrt.404.1646905614477; 
 Thu, 10 Mar 2022 01:46:54 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a056000018c00b001f079518150sm3776956wrx.93.2022.03.10.01.46.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Mar 2022 01:46:53 -0800 (PST)
Subject: Re: [PATCH v8 00/11] Fix BUG_ON in vfio_iommu_group_notifier()
To: Lu Baolu <baolu.lu@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, Alex Williamson
 <alex.williamson@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>
References: <20220308054421.847385-1-baolu.lu@linux.intel.com>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <fb386c59-2359-0230-6340-3f8c8710b0f1@redhat.com>
Date: Thu, 10 Mar 2022 10:46:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220308054421.847385-1-baolu.lu@linux.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Chaitanya Kulkarni <kch@nvidia.com>, kvm@vger.kernel.org,
 Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, Will Deacon <will@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
 iommu@lists.linux-foundation.org, Thierry Reding <thierry.reding@gmail.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Diana Craciun <diana.craciun@oss.nxp.com>,
 Dan Williams <dan.j.williams@intel.com>, Li Yang <leoyang.li@nxp.com>,
 Robin Murphy <robin.murphy@arm.com>, Dmitry Osipenko <digetx@gmail.com>
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

Hi Lu,

On 3/8/22 6:44 AM, Lu Baolu wrote:
> Hi folks,
>
> The iommu group is the minimal isolation boundary for DMA. Devices in
> a group can access each other's MMIO registers via peer to peer DMA
> and also need share the same I/O address space.
>
> Once the I/O address space is assigned to user control it is no longer
> available to the dma_map* API, which effectively makes the DMA API
> non-working.
>
> Second, userspace can use DMA initiated by a device that it controls
> to access the MMIO spaces of other devices in the group. This allows
> userspace to indirectly attack any kernel owned device and it's driver.
>
> Therefore groups must either be entirely under kernel control or
> userspace control, never a mixture. Unfortunately some systems have
> problems with the granularity of groups and there are a couple of
> important exceptions:
>
>  - pci_stub allows the admin to block driver binding on a device and
>    make it permanently shared with userspace. Since PCI stub does not
>    do DMA it is safe, however the admin must understand that using
>    pci_stub allows userspace to attack whatever device it was bound
>    it.
>
>  - PCI bridges are sometimes included in groups. Typically PCI bridges
>    do not use DMA, and generally do not have MMIO regions.
>
> Generally any device that does not have any MMIO registers is a
> possible candidate for an exception.
>
> Currently vfio adopts a workaround to detect violations of the above
> restrictions by monitoring the driver core BOUND event, and hardwiring
> the above exceptions. Since there is no way for vfio to reject driver
> binding at this point, BUG_ON() is triggered if a violation is
> captured (kernel driver BOUND event on a group which already has some
> devices assigned to userspace). Aside from the bad user experience
> this opens a way for root userspace to crash the kernel, even in high
> integrity configurations, by manipulating the module binding and
> triggering the BUG_ON.
>
> This series solves this problem by making the user/kernel ownership a
> core concept at the IOMMU layer. The driver core enforces kernel
> ownership while drivers are bound and violations now result in a error
> codes during probe, not BUG_ON failures.
>
> Patch partitions:
>   [PATCH 1-4]: Detect DMA ownership conflicts during driver binding;
>   [PATCH 5-7]: Add security context management for assigned devices;
>   [PATCH 8-11]: Various cleanups.
>
> This is also part one of three initial series for IOMMUFD:
>  * Move IOMMU Group security into the iommu layer
>  - Generic IOMMUFD implementation
>  - VFIO ability to consume IOMMUFD
>
> Change log:
> v1: initial post
>   - https://lore.kernel.org/linux-iommu/20211115020552.2378167-1-baolu.lu@linux.intel.com/
>
> v2:
>   - https://lore.kernel.org/linux-iommu/20211128025051.355578-1-baolu.lu@linux.intel.com/
>
>   - Move kernel dma ownership auto-claiming from driver core to bus
>     callback. [Greg/Christoph/Robin/Jason]
>     https://lore.kernel.org/linux-iommu/20211115020552.2378167-1-baolu.lu@linux.intel.com/T/#m153706912b770682cb12e3c28f57e171aa1f9d0c
>
>   - Code and interface refactoring for iommu_set/release_dma_owner()
>     interfaces. [Jason]
>     https://lore.kernel.org/linux-iommu/20211115020552.2378167-1-baolu.lu@linux.intel.com/T/#mea70ed8e4e3665aedf32a5a0a7db095bf680325e
>
>   - [NEW]Add new iommu_attach/detach_device_shared() interfaces for
>     multiple devices group. [Robin/Jason]
>     https://lore.kernel.org/linux-iommu/20211115020552.2378167-1-baolu.lu@linux.intel.com/T/#mea70ed8e4e3665aedf32a5a0a7db095bf680325e
>
>   - [NEW]Use iommu_attach/detach_device_shared() in drm/tegra drivers.
>
>   - Refactoring and description refinement.
>
> v3:
>   - https://lore.kernel.org/linux-iommu/20211206015903.88687-1-baolu.lu@linux.intel.com/
>
>   - Rename bus_type::dma_unconfigure to bus_type::dma_cleanup. [Greg]
>     https://lore.kernel.org/linux-iommu/c3230ace-c878-39db-1663-2b752ff5384e@linux.intel.com/T/#m6711e041e47cb0cbe3964fad0a3466f5ae4b3b9b
>
>   - Avoid _platform_dma_configure for platform_bus_type::dma_configure.
>     [Greg]
>     https://lore.kernel.org/linux-iommu/c3230ace-c878-39db-1663-2b752ff5384e@linux.intel.com/T/#m43fc46286611aa56a5c0eeaad99d539e5519f3f6
>
>   - Patch "0012-iommu-Add-iommu_at-de-tach_device_shared-for-mult.patch"
>     and "0018-drm-tegra-Use-the-iommu-dma_owner-mechanism.patch" have
>     been tested by Dmitry Osipenko <digetx@gmail.com>.
>
> v4:
>   - https://lore.kernel.org/linux-iommu/20211217063708.1740334-1-baolu.lu@linux.intel.com/
>   - Remove unnecessary tegra->domain chech in the tegra patch. (Jason)
>   - Remove DMA_OWNER_NONE. (Joerg)
>   - Change refcount to unsigned int. (Christoph)
>   - Move mutex lock into group set_dma_owner functions. (Christoph)
>   - Add kernel doc for iommu_attach/detach_domain_shared(). (Christoph)
>   - Move dma auto-claim into driver core. (Jason/Christoph)
>
> v5:
>   - https://lore.kernel.org/linux-iommu/20220104015644.2294354-1-baolu.lu@linux.intel.com/
>   - Move kernel dma ownership auto-claiming from driver core to bus
>     callback. (Greg)
>   - Refactor the iommu interfaces to make them more specific.
>     (Jason/Robin)
>   - Simplify the dma ownership implementation by removing the owner
>     type. (Jason)
>   - Commit message refactoring for PCI drivers. (Bjorn)
>   - Move iommu_attach/detach_device() improvement patches into another
>     series as there are a lot of code refactoring and cleanup staffs
>     in various device drivers.
>
> v6:
>   - https://lore.kernel.org/linux-iommu/20220218005521.172832-1-baolu.lu@linux.intel.com/
>   - Refine comments and commit mesages.
>   - Rename iommu_group_set_dma_owner() to iommu_group_claim_dma_owner().
>   - Rename iommu_device_use/unuse_kernel_dma() to
>     iommu_device_use/unuse_default_domain().
>   - Remove unnecessary EXPORT_SYMBOL_GPL.
>   - Change flag name from no_kernel_api_dma to driver_managed_dma.
>   - Merge 4 "Add driver dma ownership management" patches into single
>     one.
>
> v7:
>   - We discussed about adding some fields in driver structure and
>     intercepting it in the bus notifier for driver unbinding. We agreed
>     that the driver structure should not be used out of the driver core.
>   - As iommu_group_claim/release_dma_owner() are only used by the VFIO,
>     there're no use cases for multiple calls for a single group.
>   - Add some commit messages in "vfio: Set DMA ownership for
>     VFIO" to describe the intentional enhancement of unsafe bridge
>     drivers.
>   - Comments refinement.
>
> v8:
>   - Move iommu_use_default_domain() to the end of .dma_configure
>     callback to avoid firmware-data-ordering thing.
>     Link: https://lore.kernel.org/linux-iommu/e2698dbe-18e2-1a82-8a12-fe45bc9be534@arm.com/

Feel free to add my T-b
Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
>   - Add Acked-by from PCI and VFIO maintainers.
>
> This is based on next branch of linux-iommu tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
> and also available on github:
> https://github.com/LuBaolu/intel-iommu/commits/iommu-dma-ownership-v8
>
> Best regards,
> baolu
>
> Jason Gunthorpe (1):
>   vfio: Delete the unbound_list
>
> Lu Baolu (10):
>   iommu: Add DMA ownership management interfaces
>   driver core: Add dma_cleanup callback in bus_type
>   amba: Stop sharing platform_dma_configure()
>   bus: platform,amba,fsl-mc,PCI: Add device DMA ownership management
>   PCI: pci_stub: Set driver_managed_dma
>   PCI: portdrv: Set driver_managed_dma
>   vfio: Set DMA ownership for VFIO devices
>   vfio: Remove use of vfio_group_viable()
>   vfio: Remove iommu group notifier
>   iommu: Remove iommu group changes notifier
>
>  include/linux/amba/bus.h              |   8 +
>  include/linux/device/bus.h            |   3 +
>  include/linux/fsl/mc.h                |   8 +
>  include/linux/iommu.h                 |  54 +++---
>  include/linux/pci.h                   |   8 +
>  include/linux/platform_device.h       |  10 +-
>  drivers/amba/bus.c                    |  37 +++-
>  drivers/base/dd.c                     |   5 +
>  drivers/base/platform.c               |  21 ++-
>  drivers/bus/fsl-mc/fsl-mc-bus.c       |  24 ++-
>  drivers/iommu/iommu.c                 | 228 ++++++++++++++++--------
>  drivers/pci/pci-driver.c              |  18 ++
>  drivers/pci/pci-stub.c                |   1 +
>  drivers/pci/pcie/portdrv_pci.c        |   2 +
>  drivers/vfio/fsl-mc/vfio_fsl_mc.c     |   1 +
>  drivers/vfio/pci/vfio_pci.c           |   1 +
>  drivers/vfio/platform/vfio_amba.c     |   1 +
>  drivers/vfio/platform/vfio_platform.c |   1 +
>  drivers/vfio/vfio.c                   | 245 ++------------------------
>  19 files changed, 338 insertions(+), 338 deletions(-)
>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
