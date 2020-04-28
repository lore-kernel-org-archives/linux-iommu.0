Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82355C83004
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 12:05:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45250206D6
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 12:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="VND2zoOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45250206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 17A4286F87;
	Tue, 28 Apr 2020 12:05:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vhskij9BRTvX; Tue, 28 Apr 2020 12:05:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 942B584BCF;
	Tue, 28 Apr 2020 12:05:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 890D6C0864;
	Tue, 28 Apr 2020 12:05:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCA90C0172
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 11:39:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BB02888047
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 11:39:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0p9WvRrVGl0k for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 11:39:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3DF9288045
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 11:39:44 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1588073989; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ooRoECL6kaq+8wAP+LaRpKy9DgdaIYNJI/EUtMplfHU=;
 b=VND2zoOx5/YJigO5MGrQbIWRt/MqT72ltNDoUGsXegjFRCoA8DiAXZAdnowJMOEyVtL38Xz3
 VchMNJWU78LKtFN6EX2GpI3QrHEWFS/8i2W1W2OuJq1cS6PfSKOFb3OMxf8bCZ7P4J/zImNz
 81q5to4Yh5roSyVaKuLBnQf/2Xs=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea815f3.7f97a7021298-smtp-out-n03;
 Tue, 28 Apr 2020 11:39:31 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 9E9E8C433D2; Tue, 28 Apr 2020 11:39:29 +0000 (UTC)
Received: from blr-ubuntu-31.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: svaddagi)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 92CB9C433CB;
 Tue, 28 Apr 2020 11:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92CB9C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=vatsa@codeaurora.org
From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
To: konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com,
 jan.kiszka@siemens.com, will@kernel.org, stefano.stabellini@xilinx.com
Subject: [PATCH 0/5] virtio on Type-1 hypervisor
Date: Tue, 28 Apr 2020 17:09:13 +0530
Message-Id: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
X-Mailer: git-send-email 2.7.4
X-Mailman-Approved-At: Tue, 28 Apr 2020 12:05:44 +0000
Cc: tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org,
 alex.bennee@linaro.org, vatsa@codeaurora.org, christoffer.dall@arm.com,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 pratikp@codeaurora.org, linux-kernel@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

We ran into several problems in using virtio for IO paravirtualization on a
Type-1 hypervisor with these characteristics:

* By default, all of a guests's memory is private to it (no other guest can
  access its memory).

* One of the VM is considered as primary and has access to most IO devices. This
  is similar to dom0 VM in case of Xen. All other VMs are considered as
  secondary VMs

* virtio-backend drivers for all secondary VMs need to be hosted in primary VM

* Since secondary VM's memory is not accessible to primary VM, to make virtio
  backend driver work, instead an additional piece of memory is provisioned 
  by the hypervisor that is shared between primary and secondary VMs. This
  shared memory can be used, for example, to host virtio-ring structures
  and also to bounce IO buffers of secondary VM.

* Message-queue and doorbell interfaces available in hypervisor to support
  inter-VM communication. Messge-queue API (send/recv) allows one VM to send
  short messages to another VM. Doorbell interface allows a VM to inject
  an interrupt into another VM.

* No support for MMIO transport i.e hypervisor does not support trapping MMIO
  config space access by front-end driver and having it handled in backend
  drivers.

Few problem statements arising out of this:

1) How can we make use of the shared memory region effectively to make virtio
work in this scenario?

What is proposed in the patch series for this problem is a virtio bounce driver
that recognizes a shared memory region (shared between VMs) and makes use of
swiotlb driver interfaces to bounce IO buffers between private and shared space.
Some changes are proposed to swiotlb driver in this regard, that can let us
reuse swiotlb functions to work with the shared memory pool. swiotlb driver can
now recognize more than one pool of memory and extend its functions
(allocate/free/bounce memory chunks) for each pool.

2) What transport mechanism works best in this case? 

I realize that ivshmem2-virtio proposal has discussed the possibility of using
shared memory + doorbell as a virtio transport option. We can consider using
that as a transport in case it will be acceptable upstream. Other option we had
considered was to modify virtio_mmio.c itself to use message_queue send/recv
hypercall interface (in place of readl/writel). That could be abstracted via
'mmio_ops' structure providing suitable implementation of readl/writel. Another
option suggested by Christopher Dall is to unmap the config space from kernel
address space and as part of the fault handler, use hypervisor specific APIs to
achieve config space IO.

3) Which virtio backend drivers to leverage?

We realized there are multiple implementations of virtio backend drivers,
bundled as part of separate projects (Qemu, lkvm etc). We think it would be nice
if we had some consolidation in that regard so that we can make use of the
backend drivers that are not tightly coupled with a VMM. In our case, we need to
be able to run virtio backend drivers as standalone programs (and not coupled
with any VMM).


Srivatsa Vaddagiri (5):
  swiotlb: Introduce concept of swiotlb_pool
  swiotlb: Allow for non-linear mapping between paddr and vaddr
  swiotlb: Add alloc and free APIs
  swiotlb: Add API to register new pool
  virtio: Add bounce DMA ops

 drivers/virtio/Makefile        |   2 +-
 drivers/virtio/virtio.c        |   2 +
 drivers/virtio/virtio_bounce.c | 150 +++++++++++
 drivers/xen/swiotlb-xen.c      |   4 +-
 include/linux/swiotlb.h        | 157 +++++++++++-
 include/linux/virtio.h         |   4 +
 kernel/dma/swiotlb.c           | 556 ++++++++++++++++++++++++-----------------
 7 files changed, 638 insertions(+), 237 deletions(-)
 create mode 100644 drivers/virtio/virtio_bounce.c

-- 
2.7.4

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
