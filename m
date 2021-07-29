Return-Path: <SRS0=dGrv=MV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635F3C432BE
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 07:36:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC0C760241
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 07:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DC0C760241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9CA794032B;
	Thu, 29 Jul 2021 07:36:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8s-SUVnB1rja; Thu, 29 Jul 2021 07:36:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A3AB84019B;
	Thu, 29 Jul 2021 07:36:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5590AC0010;
	Thu, 29 Jul 2021 07:36:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91736C0010
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 07:36:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 76BB6606BF
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 07:36:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UFJ78Kvfw-Kf for <iommu@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 07:35:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AF7B36063E
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 07:35:58 +0000 (UTC)
Received: by mail-pl1-x634.google.com with SMTP id t3so3844115plg.9
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 00:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YU0cJxY5iFvBzwOHXbedtBUSHcEXZt/4lUbbw7g3Dyk=;
 b=z1jZ07Pqr7Q0J9VdJrC/IGeDT2TweaKznPc4LqogGEuRw+x5mhtvG9tpGqRUI9gKe2
 53T1pwXqlRzL38gaFJhZcaKH13BVlMeZ+hhMvlMc2lY9+sTFi5kPt5cdC3+wPjraVfDo
 rvHoKeKUOk/XCr99oV0qQRbn9KTT70Sgc/DcpIrDdyn2uipLufjUOxL35X5hmtTMXuQg
 24CruS+HK4ydUKSJyWtDuR6nfvjx5TUFm1uqe475fp8hfMH4us6N6bUWSqgWvsl/621w
 omsp7Or7wqGFUqNorj1qg7RrZtg6TswjgzBtmm3qsZ6z9I6+X42Pzk2QwwA9mw2IjXZP
 i2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YU0cJxY5iFvBzwOHXbedtBUSHcEXZt/4lUbbw7g3Dyk=;
 b=nh1ZnwRRpzbmHxyD0mMyDpDQ7qHZud+JE1m08UZBTGgbECMdTe69aS55mV7cJC2w4o
 tjSul/kKOjQDYhJScHqi479zvTSJr0xabYuPPaQaxNpriVLtsAL5BSt+ZKxXPDglibld
 GGyWI58ZY9x8DgWN8CUDhRM4NSxadYJeyqwkuymmYwF51OUoSZ2BwZV/tLRlAyc2MmPs
 i62rfwMs8Ef/sLla54ZCrg+w4szB1nErRQsMq9MHteVwo6tw3NFDS2upLLbWQLX12t3T
 KZIEOPpd5qiaC+7ThaL4iiSDtbUa9aGo1uieaRLz9t2gcJ9Ja2kYzm5PvF4Z8kNde0Fn
 QRaA==
X-Gm-Message-State: AOAM532X2F8WsNSs8FUFZ3YxUonl3o7GEJyDC0vDYwazO4+CUjDBZjMI
 dBd5SEGKwysEXMfO+vmw4f8U
X-Google-Smtp-Source: ABdhPJy1AIf8Cwl+eWgEhVRAcKaJrlqHfGOzJwBNkPxmQgiHHUa+tkRA9a+TZnW4FKyk2tInov12AQ==
X-Received: by 2002:a17:90a:ca14:: with SMTP id
 x20mr3914285pjt.89.1627544157832; 
 Thu, 29 Jul 2021 00:35:57 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id x10sm2438068pfr.150.2021.07.29.00.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jul 2021 00:35:57 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com
Subject: [PATCH v10 00/17] Introduce VDUSE - vDPA Device in Userspace
Date: Thu, 29 Jul 2021 15:34:46 +0800
Message-Id: <20210729073503.187-1-xieyongji@bytedance.com>
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

This series is now based on:

https://lore.kernel.org/lkml/20210618084412.18257-1-zhe.he@windriver.com/
https://lore.kernel.org/lkml/20210705071910.31965-1-jasowang@redhat.com/
https://lore.kernel.org/lkml/20210728130756.97-1-xieyongji@bytedance.com/

Future work:
  - Improve performance
  - Userspace library (find a way to reuse device emulation code in qemu/rust-vmm)
  - Support more device types

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

Xie Yongji (17):
  iova: Export alloc_iova_fast() and free_iova_fast()
  file: Export receive_fd() to modules
  vdpa: Fix code indentation
  vdpa: Fail the vdpa_reset() if fail to set device status to zero
  vhost-vdpa: Fail the vhost_vdpa_set_status() on reset failure
  vhost-vdpa: Handle the failure of vdpa_reset()
  virtio: Don't set FAILED status bit on device index allocation failure
  virtio_config: Add a return value to reset function
  virtio-vdpa: Handle the failure of vdpa_reset()
  virtio: Handle device reset failure in register_virtio_device()
  vhost-iotlb: Add an opaque pointer for vhost IOTLB
  vdpa: Add an opaque pointer for vdpa_config_ops.dma_map()
  vdpa: factor out vhost_vdpa_pa_map() and vhost_vdpa_pa_unmap()
  vdpa: Support transferring virtual addressing during DMA mapping
  vduse: Implement an MMU-based software IOTLB
  vduse: Introduce VDUSE - vDPA Device in Userspace
  Documentation: Add documentation for VDUSE

 Documentation/userspace-api/index.rst              |    1 +
 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 +
 Documentation/userspace-api/vduse.rst              |  232 +++
 arch/um/drivers/virtio_uml.c                       |    4 +-
 drivers/iommu/iova.c                               |    2 +
 drivers/platform/mellanox/mlxbf-tmfifo.c           |    4 +-
 drivers/remoteproc/remoteproc_virtio.c             |    4 +-
 drivers/s390/virtio/virtio_ccw.c                   |    6 +-
 drivers/vdpa/Kconfig                               |   10 +
 drivers/vdpa/Makefile                              |    1 +
 drivers/vdpa/ifcvf/ifcvf_main.c                    |    2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c                  |    2 +-
 drivers/vdpa/vdpa.c                                |    9 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c                   |    8 +-
 drivers/vdpa/vdpa_user/Makefile                    |    5 +
 drivers/vdpa/vdpa_user/iova_domain.c               |  545 +++++++
 drivers/vdpa/vdpa_user/iova_domain.h               |   73 +
 drivers/vdpa/vdpa_user/vduse_dev.c                 | 1541 ++++++++++++++++++++
 drivers/vdpa/virtio_pci/vp_vdpa.c                  |    2 +-
 drivers/vhost/iotlb.c                              |   20 +-
 drivers/vhost/vdpa.c                               |  170 ++-
 drivers/virtio/virtio.c                            |   17 +-
 drivers/virtio/virtio_mmio.c                       |    4 +-
 drivers/virtio/virtio_pci_legacy.c                 |    4 +-
 drivers/virtio/virtio_pci_modern.c                 |    4 +-
 drivers/virtio/virtio_vdpa.c                       |    4 +-
 fs/file.c                                          |    6 +
 include/linux/file.h                               |    7 +-
 include/linux/vdpa.h                               |   65 +-
 include/linux/vhost_iotlb.h                        |    3 +
 include/linux/virtio_config.h                      |    3 +-
 include/uapi/linux/vduse.h                         |  220 +++
 32 files changed, 2893 insertions(+), 86 deletions(-)
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
