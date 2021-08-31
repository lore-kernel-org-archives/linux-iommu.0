Return-Path: <SRS0=eAvY=NW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBEEC432BE
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 10:37:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E9F960C3E
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 10:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3E9F960C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E17D840493;
	Tue, 31 Aug 2021 10:37:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ahyzmBsyu7t7; Tue, 31 Aug 2021 10:37:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B2B6840485;
	Tue, 31 Aug 2021 10:37:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91A85C001A;
	Tue, 31 Aug 2021 10:37:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FB14C000E
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 10:37:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C09B2404F9
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 10:37:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xUP6QXjSdsMW for <iommu@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 10:37:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 538864051B
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 10:37:05 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id x16so8693091pll.2
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 03:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8dQdwJ6iC5itnTtMlKSyQHwu/Qk1rv1msQ0z62kLU9M=;
 b=Fzi+Lgss3ZurgkLBW2ayaOGUUrnL4WOcNoEEk18yA41A53K5j4I8OKpwahC4+JhMr6
 xg/BFE0hxXXPtZn1arWCFiOzmgcreBz/OztVMJAxuW1AN+RXQWaidM8LFRtVsBi7eK/q
 H3pUkVcsRPamTuuKa3sC329vYRY/x8iXJS2Zwl1zBKexRjJ0bYM/6NdNaWYk8kIE3gNs
 +koI9rBrDpcnHO9RKHRt3QLeF0y2LocSE8i7p0CvWMjsAlVwcnWNGY0HDvoRAzo2K7/t
 vh3A2vt2qQJqixjfBtOxjX5IIJ6OZFPIWu0uW577Gv/ibTMr7fo+9Tx/DUix5n/Mn1xY
 f73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8dQdwJ6iC5itnTtMlKSyQHwu/Qk1rv1msQ0z62kLU9M=;
 b=QRi5FSM4nAOwCJ+MmU+ZyOaEmxdAFUPvTKmhmOmBzfB8/1F/l6tjJSAXXUNbHp+KqR
 aQv439fNf94erHL01fyNs/BlJWYT8aly1DWHtQs1VzCPmnDmIXWDmPZLtfLsyezlrBsV
 e7BqgSDnJFNy/D8noBXhEu43y7tfgDg4NFiSUKigUjERGFHYSx10jhlI94P0GUjuX+KR
 plYcyGYViH0FLbaj5bFGUa3CbEPAYw0XS7WLnAmGXSJMyn1d2OOFC7BC9uwEqB8v1BXA
 mmhDgPS3E1BNb3Ye68QvN+eQmCehTPK1DFI8QZ28gv7bAJTHpeyQekZx/4+eJawxF9PE
 cS4w==
X-Gm-Message-State: AOAM532edEhhiuxHKXjZcLr3K5BuoNEVah5lC5bdIudKvfD1KyQt+DUu
 Gt08mJZ7wsXNHO4HUfLukEmT
X-Google-Smtp-Source: ABdhPJw4oNnCOMs5Y9HR/D63FbL9urL6s8bSvkyCRjyqy4l8W/bJ9JvEOLec5yDa66G2lv5YAOzxaA==
X-Received: by 2002:a17:902:6b8a:b029:12d:3f99:9e5e with SMTP id
 p10-20020a1709026b8ab029012d3f999e5emr4123749plk.66.1630406224521; 
 Tue, 31 Aug 2021 03:37:04 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id r13sm21083888pgl.90.2021.08.31.03.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Aug 2021 03:37:03 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com,
 robin.murphy@arm.com, will@kernel.org, john.garry@huawei.com
Subject: [PATCH v13 00/13] Introduce VDUSE - vDPA Device in Userspace
Date: Tue, 31 Aug 2021 18:36:21 +0800
Message-Id: <20210831103634.33-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 songmuchun@bytedance.com, linux-fsdevel@vger.kernel.org
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

This series introduces a framework that makes it possible to implement
software-emulated vDPA devices in userspace. And to make the device
emulation more secure, the emulated vDPA device's control path is handled
in the kernel and only the data path is implemented in the userspace.

Since the emuldated vDPA device's control path is handled in the kernel,
a message mechnism is introduced to make userspace be aware of the data
path related changes. Userspace can use read()/write() to receive/reply
the control messages.

In the data path, the core is mapping dma buffer into VDUSE daemon's
address space, which can be implemented in different ways depending on
the vdpa bus to which the vDPA device is attached.

In virtio-vdpa case, we implements a MMU-based software IOTLB with
bounce-buffering mechanism to achieve that. And in vhost-vdpa case, the dma
buffer is reside in a userspace memory region which can be shared to the
VDUSE userspace processs via transferring the shmfd.

The details and our user case is shown below:

------------------------    -------------------------   ----------------------------------------------
|            Container |    |              QEMU(VM) |   |                               VDUSE daemon |
|       ---------      |    |  -------------------  |   | ------------------------- ---------------- |
|       |dev/vdx|      |    |  |/dev/vhost-vdpa-x|  |   | | vDPA device emulation | | block driver | |
------------+-----------     -----------+------------   -------------+----------------------+---------
            |                           |                            |                      |
            |                           |                            |                      |
------------+---------------------------+----------------------------+----------------------+---------
|    | block device |           |  vhost device |            | vduse driver |          | TCP/IP |    |
|    -------+--------           --------+--------            -------+--------          -----+----    |
|           |                           |                           |                       |        |
| ----------+----------       ----------+-----------         -------+-------                |        |
| | virtio-blk driver |       |  vhost-vdpa driver |         | vdpa device |                |        |
| ----------+----------       ----------+-----------         -------+-------                |        |
|           |      virtio bus           |                           |                       |        |
|   --------+----+-----------           |                           |                       |        |
|                |                      |                           |                       |        |
|      ----------+----------            |                           |                       |        |
|      | virtio-blk device |            |                           |                       |        |
|      ----------+----------            |                           |                       |        |
|                |                      |                           |                       |        |
|     -----------+-----------           |                           |                       |        |
|     |  virtio-vdpa driver |           |                           |                       |        |
|     -----------+-----------           |                           |                       |        |
|                |                      |                           |    vdpa bus           |        |
|     -----------+----------------------+---------------------------+------------           |        |
|                                                                                        ---+---     |
-----------------------------------------------------------------------------------------| NIC |------
                                                                                         ---+---
                                                                                            |
                                                                                   ---------+---------
                                                                                   | Remote Storages |
                                                                                   -------------------

We make use of it to implement a block device connecting to
our distributed storage, which can be used both in containers and
VMs. Thus, we can have an unified technology stack in this two cases.

To test it with null-blk:

  $ qemu-storage-daemon \
      --chardev socket,id=charmonitor,path=/tmp/qmp.sock,server,nowait \
      --monitor chardev=charmonitor \
      --blockdev driver=host_device,cache.direct=on,aio=native,filename=/dev/nullb0,node-name=disk0 \
      --export type=vduse-blk,id=test,node-name=disk0,writable=on,name=vduse-null,num-queues=16,queue-size=128

The qemu-storage-daemon can be found at https://github.com/bytedance/qemu/tree/vduse

To make the userspace VDUSE processes such as qemu-storage-daemon able
to be run by an unprivileged user. We limit the supported device type
to virtio block device currently. The support for other device types
can be added after the security issue of corresponding device driver
is clarified or fixed in the future.

Future work:
  - Improve performance
  - Userspace library (find a way to reuse device emulation code in qemu/rust-vmm)
  - Support more device types

V12 to V13:
- Fix building error

V11 to V12:
- Rebased to vhost.git
- Add reset support for all vdpa drivers
- Remove the dependency on other patches
- Export eventfd_wake_count
- Use workqueue for virtqueue kicking in some cases

V10 to V11:
- Rebased to newest kernel tree
- Add a device attribute for message timeout
- Add check for the reserved field of some structures
- Add a reset callback in vdpa_config_ops and handle it in VDUSE case
- Remove the patches that handle virtio-vdpa reset failure
- Document the structures in include/uapi/linux/vduse.h using kernel doc
- Add the reserved field for struct vduse_vq_config

V9 to V10:
- Forbid some userspace operations after a timeout
- Rename VDUSE_DEV_INJECT_IRQ to VDUSE_DEV_INJECT_CONFIG_IRQ
- Use fixed bounce buffer size
- Fix more code indentation issues in include/linux/vdpa.h
- Remove the section describing bounce-buffer mechanism in documentation
- Fix some commit logs and documentation

V8 to V9:
- Add VDUSE_SET_STATUS message to replace VDUSE_START/STOP_DATAPLANE messages
- Support packed virtqueue state
- Handle the reset failure in both virtio-vdpa and vhost-vdpa cases
- Add more details in documentation
- Remove VDUSE_REQ_FLAGS_NO_REPLY flag
- Add VDUSE_VQ_SETUP ioctl to support per-vq configuration
- Separate config interrupt injecting out of config update
- Flush kworker for interrupt inject during resetting
- Validate the config_size in .get_config()

V7 to V8:
- Rebased to newest kernel tree
- Rework VDUSE driver to handle the device's control path in kernel
- Limit the supported device type to virtio block device
- Export free_iova_fast()
- Remove the virtio-blk and virtio-scsi patches (will send them alone)
- Remove all module parameters
- Use the same MAJOR for both control device and VDUSE devices
- Avoid eventfd cleanup in vduse_dev_release()

V6 to V7:
- Export alloc_iova_fast()
- Add get_config_size() callback
- Add some patches to avoid trusting virtio devices
- Add limited device emulation
- Add some documents
- Use workqueue to inject config irq
- Add parameter on vq irq injecting
- Rename vduse_domain_get_mapping_page() to vduse_domain_get_coherent_page()
- Add WARN_ON() to catch message failure
- Add some padding/reserved fields to uAPI structure
- Fix some bugs
- Rebase to vhost.git

V5 to V6:
- Export receive_fd() instead of __receive_fd()
- Factor out the unmapping logic of pa and va separatedly
- Remove the logic of bounce page allocation in page fault handler
- Use PAGE_SIZE as IOVA allocation granule
- Add EPOLLOUT support
- Enable setting API version in userspace
- Fix some bugs

V4 to V5:
- Remove the patch for irq binding
- Use a single IOTLB for all types of mapping
- Factor out vhost_vdpa_pa_map()
- Add some sample codes in document
- Use receice_fd_user() to pass file descriptor
- Fix some bugs

V3 to V4:
- Rebase to vhost.git
- Split some patches
- Add some documents
- Use ioctl to inject interrupt rather than eventfd
- Enable config interrupt support
- Support binding irq to the specified cpu
- Add two module parameter to limit bounce/iova size
- Create char device rather than anon inode per vduse
- Reuse vhost IOTLB for iova domain
- Rework the message mechnism in control path

V2 to V3:
- Rework the MMU-based IOMMU driver
- Use the iova domain as iova allocator instead of genpool
- Support transferring vma->vm_file in vhost-vdpa
- Add SVA support in vhost-vdpa
- Remove the patches on bounce pages reclaim

V1 to V2:
- Add vhost-vdpa support
- Add some documents
- Based on the vdpa management tool
- Introduce a workqueue for irq injection
- Replace interval tree with array map to store the iova_map

Xie Yongji (13):
  iova: Export alloc_iova_fast() and free_iova_fast()
  eventfd: Export eventfd_wake_count to modules
  file: Export receive_fd() to modules
  vdpa: Fix some coding style issues
  vdpa: Add reset callback in vdpa_config_ops
  vhost-vdpa: Handle the failure of vdpa_reset()
  vhost-iotlb: Add an opaque pointer for vhost IOTLB
  vdpa: Add an opaque pointer for vdpa_config_ops.dma_map()
  vdpa: factor out vhost_vdpa_pa_map() and vhost_vdpa_pa_unmap()
  vdpa: Support transferring virtual addressing during DMA mapping
  vduse: Implement an MMU-based software IOTLB
  vduse: Introduce VDUSE - vDPA Device in Userspace
  Documentation: Add documentation for VDUSE

 Documentation/userspace-api/index.rst              |    1 +
 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 +
 Documentation/userspace-api/vduse.rst              |  233 +++
 drivers/iommu/iova.c                               |    2 +
 drivers/vdpa/Kconfig                               |   10 +
 drivers/vdpa/Makefile                              |    1 +
 drivers/vdpa/ifcvf/ifcvf_main.c                    |   37 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c                  |   42 +-
 drivers/vdpa/vdpa.c                                |    9 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c                   |   26 +-
 drivers/vdpa/vdpa_user/Makefile                    |    5 +
 drivers/vdpa/vdpa_user/iova_domain.c               |  545 +++++++
 drivers/vdpa/vdpa_user/iova_domain.h               |   73 +
 drivers/vdpa/vdpa_user/vduse_dev.c                 | 1641 ++++++++++++++++++++
 drivers/vdpa/virtio_pci/vp_vdpa.c                  |   17 +-
 drivers/vhost/iotlb.c                              |   20 +-
 drivers/vhost/vdpa.c                               |  168 +-
 fs/eventfd.c                                       |    1 +
 fs/file.c                                          |    6 +
 include/linux/file.h                               |    7 +-
 include/linux/vdpa.h                               |   62 +-
 include/linux/vhost_iotlb.h                        |    3 +
 include/uapi/linux/vduse.h                         |  306 ++++
 23 files changed, 3112 insertions(+), 104 deletions(-)
 create mode 100644 Documentation/userspace-api/vduse.rst
 create mode 100644 drivers/vdpa/vdpa_user/Makefile
 create mode 100644 drivers/vdpa/vdpa_user/iova_domain.c
 create mode 100644 drivers/vdpa/vdpa_user/iova_domain.h
 create mode 100644 drivers/vdpa/vdpa_user/vduse_dev.c
 create mode 100644 include/uapi/linux/vduse.h

-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
