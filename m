Return-Path: <SRS0=Z7Xn=ZO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77D0C432C3
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 13:01:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F62C20715
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 13:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WveYlPr+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F62C20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 17D8B261D0;
	Fri, 22 Nov 2019 13:01:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R7AuDHBlXsGh; Fri, 22 Nov 2019 13:01:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9429520384;
	Fri, 22 Nov 2019 13:01:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89E1FC1DD8;
	Fri, 22 Nov 2019 13:01:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96D9DC18DA
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 13:01:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 83CD0873B5
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 13:01:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EQ66aGcaT7Tk for <iommu@lists.linux-foundation.org>;
 Fri, 22 Nov 2019 13:01:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9FE218735C
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 13:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574427660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hDtTiFZGGo/1StAmtVfrkUJ+PjYMYzK9DUhNQHwqZlg=;
 b=WveYlPr+r80JpPGtiw8L4LuItcwudw119xJ2EJjC1CEhR9t/t/HxBGvm8rkREtEBlVLKGx
 vYejcyupLkLPdNaA5X7HEyeTkaaBJE2s9uN0/MKZx9oUMYxGc1pFSKY6ceuZwp4AkOPQxz
 D4w09bA6q/IPiZS73XBgK6vVDuBsoe8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-urpNdKp2PnCfQNZVqmIx4A-1; Fri, 22 Nov 2019 08:00:58 -0500
Received: by mail-qk1-f199.google.com with SMTP id d144so4225044qke.16
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 05:00:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1fR3x/2WLw68dp/9JUT3DJdPEJVC8+NEY0FO9GcZY1o=;
 b=qcQ5rOanvy/n6xQIinw9ZrK5gqlF/CRtfRNfcC2TwTT/oBf/KjxjVAahSab9MD7Ja+
 Tt2o73FJJmyLoQiHtAv/7JrTzcD7d30ozy6yj5TD2s3JCD9QNWlkJcqPxGtiv51O2na2
 tNtgMebYrGcAC832tXnMmSpkoBFQKKQUENNjE1QxI9b7mvLETn8fSK/oSIOVtq8Az5GI
 fz73kuLRXPsiHdfJBr9jxbiIJ4DDNd2Htf+fjhvo+AhohDJL8p3RnO0fAttWivV+8bKm
 iH1wtjIgD30W0gHJ+n4U0Qd81E0+zZyrRxJy4Y70SBTt1ayWIybHAkUEExJJi8VY4+Z7
 +6MA==
X-Gm-Message-State: APjAAAXeuvbS3L0i77tctJ0fgwf7R27He1IiS/Wmxwz4tEPE1186iGII
 omEWl8N5mVkhJR0EBlrCR+uMmCH+C8lpVudXqgjBqmqT72lSQVm0s+nB/co/b+aM6l0i9W7tXHR
 5u/FeDXbcYsf90F7QKg6/ibA255YJCg==
X-Received: by 2002:a05:620a:208f:: with SMTP id
 e15mr3450540qka.351.1574427656433; 
 Fri, 22 Nov 2019 05:00:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqwq6MxrIGacf2ffzy2/2UvK2qmsTNmCKrzyfncS0NUTLAuxeKcMdMPDyh/8Vn1ehS0K2ecivQ==
X-Received: by 2002:a05:620a:208f:: with SMTP id
 e15mr3450483qka.351.1574427656023; 
 Fri, 22 Nov 2019 05:00:56 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id r36sm3397016qta.27.2019.11.22.05.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 05:00:55 -0800 (PST)
Date: Fri, 22 Nov 2019 08:00:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [RFC 00/13] virtio-iommu on non-devicetree platforms
Message-ID: <20191122075438-mutt-send-email-mst@kernel.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
X-MC-Unique: urpNdKp2PnCfQNZVqmIx4A-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
Cc: virtio-dev@lists.oasis-open.org, kevin.tian@intel.com,
 gregkh@linuxfoundation.org, linux-pci@vger.kernel.org, sudeep.holla@arm.com,
 rjw@rjwysocki.net, virtualization@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, jacob.jun.pan@intel.com, guohanjun@huawei.com,
 bhelgaas@google.com, jasowang@redhat.com, linux-arm-kernel@lists.infradead.org,
 lenb@kernel.org
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

On Fri, Nov 22, 2019 at 11:49:47AM +0100, Jean-Philippe Brucker wrote:
> I'm seeking feedback on multi-platform support for virtio-iommu. At the
> moment only devicetree (DT) is supported and we don't have a pleasant
> solution for other platforms. Once we figure out the topology
> description, x86 support is trivial.
> 
> Since the IOMMU manages memory accesses from other devices, the guest
> kernel needs to initialize the IOMMU before endpoints start issuing DMA.
> It's a solved problem: firmware or hypervisor describes through DT or
> ACPI tables the device dependencies, and probe of endpoints is deferred
> until the IOMMU is probed. But:
> 
> (1) ACPI has one table per vendor (DMAR for Intel, IVRS for AMD and IORT
>     for Arm). From my point of view IORT is easier to extend, since we
>     just need to introduce a new node type. There are no dependencies to
>     Arm in the Linux IORT driver, so it works well with CONFIG_X86.
> 
>     However, there are concerns about other OS vendors feeling obligated
>     to implement this new node, so Arm proposed introducing another ACPI
>     table, that can wrap any of DMAR, IVRS and IORT to extend it with
>     new virtual nodes. A draft of this VIOT table specification is
>     available at http://jpbrucker.net/virtio-iommu/viot/viot-v5.pdf
> 
>     I'm afraid this could increase fragmentation as guests would need to
>     implement or modify their support for all of DMAR, IVRS and IORT. If
>     we end up doing VIOT, I suggest limiting it to IORT.
> 
> (2) In addition, there are some concerns about having virtio depend on
>     ACPI or DT. Some hypervisors (Firecracker, QEMU microvm, kvmtool x86
>     [1])

power?

> don't currently implement those methods.
> 
>     It was suggested to embed the topology description into the device.
>     It can work, as demonstrated at the end of this RFC, with the
>     following limitations:
> 
>     - The topology description must be read before any endpoint managed
>       by the IOMMU is probed, and even before the virtio module is
>       loaded. This RFC uses a PCI quirk to manually parse the virtio
>       configuration. It assumes that all endpoints managed by the IOMMU
>       are under this same PCI host.
> 
>     - I don't have a solution for the virtio-mmio transport at the
>       moment, because I haven't had time to modify a host to test it. I
>       think it could either use a notifier on the platform bus, or
>       better, a new 'iommu' command-line argument to the virtio-mmio
>       driver.

	A notifier seems easier for users. What are the disadvantages of
	that?

>	So the current prototype doesn't work for firecracker and
>       microvm, which rely on virtio-mmio.
> 
>     - For Arm, if the platform has an ITS, the hypervisor needs IORT or
>       DT to describe it anyway. More generally, not using either ACPI or
>       DT might prevent from supporting other features as well. I suspect
>       the above users will have to implement a standard method sooner or
>       later.
> 
>     - Even when reusing as much existing code as possible, guest support
>       is still going to be around a few hundred lines since we can't
>       rely on the normal virtio infrastructure to be loaded at that
>       point. As you can see below, the diffstat for the incomplete
>       topology implementation is already bigger than the exhaustive IORT
>       support, even when jumping through the VIOT hoop.
> 
>     So it's a lightweight solution for very specific use-cases, and we
>     should still support ACPI for the general case. Multi-platform
>     guests such as Linux will then need to support three topology
>     descriptions instead of two.
> 
> In this RFC I present both solutions, but I'd rather not keep all of it.
> Please see the individual patches for details:
> 
> (1) Patches 1, 3-10 add support for virtio-iommu to the Linux IORT
>     driver and patches 2, 11 add the VIOT glue.
> 
> (2) Patch 12 adds the built-in topology description to the virtio-iommu
>     specification. Patch 13 is a partial implementation for the Linux
>     virtio-iommu driver. It only supports PCI, not platform devices.
> 
> You can find Linux and QEMU code on my virtio-iommu/devel branches at
> http://jpbrucker.net/git/linux and http://jpbrucker.net/git/qemu
> 
> 
> I split the diffstat since there are two independent features. The first
> one is for patches 1-11, and the second one for patch 13.
> 
> Jean-Philippe Brucker (11):
>   ACPI/IORT: Move IORT to the ACPI folder
>   ACPI: Add VIOT definitions
>   ACPI/IORT: Allow registration of external tables
>   ACPI/IORT: Add node categories
>   ACPI/IORT: Support VIOT virtio-mmio node
>   ACPI/IORT: Support VIOT virtio-pci node
>   ACPI/IORT: Defer probe until virtio-iommu-pci has registered a fwnode
>   ACPI/IORT: Add callback to update a device's fwnode
>   iommu/virtio: Create fwnode if necessary
>   iommu/virtio: Update IORT fwnode
>   ACPI: Add VIOT table
> 
>  MAINTAINERS                     |   9 +
>  drivers/acpi/Kconfig            |   7 +
>  drivers/acpi/Makefile           |   2 +
>  drivers/acpi/arm64/Kconfig      |   3 -
>  drivers/acpi/arm64/Makefile     |   1 -
>  drivers/acpi/bus.c              |   2 +
>  drivers/acpi/{arm64 => }/iort.c | 317 ++++++++++++++++++++++++++------
>  drivers/acpi/tables.c           |   2 +-
>  drivers/acpi/viot.c             |  44 +++++
>  drivers/iommu/Kconfig           |   1 +
>  drivers/iommu/virtio-iommu.c    |  61 +++++-
>  include/acpi/actbl2.h           |  31 ++++
>  include/linux/acpi_iort.h       |  14 ++
>  include/linux/acpi_viot.h       |  20 ++
>  14 files changed, 448 insertions(+), 66 deletions(-)
>  rename drivers/acpi/{arm64 => }/iort.c (86%)
>  create mode 100644 drivers/acpi/viot.c
>  create mode 100644 include/linux/acpi_viot.h
> 
> Jean-Philippe Brucker (1):
>   iommu/virtio: Add topology description to virtio-iommu config space
> 
>  drivers/base/platform.c               |   3 +
>  drivers/iommu/Kconfig                 |   9 +
>  drivers/iommu/Makefile                |   1 +
>  drivers/iommu/virtio-iommu-topology.c | 410 ++++++++++++++++++++++++++
>  drivers/iommu/virtio-iommu.c          |   3 +
>  drivers/pci/pci-driver.c              |   3 +
>  include/linux/virtio_iommu.h          |  18 ++
>  include/uapi/linux/virtio_iommu.h     |  26 ++
>  8 files changed, 473 insertions(+)
>  create mode 100644 drivers/iommu/virtio-iommu-topology.c
>  create mode 100644 include/linux/virtio_iommu.h
> 
> 
> [1] firecracker: https://github.com/firecracker-microvm/firecracker
>     microvm: https://github.com/qemu/qemu/blob/master/docs/microvm.rst
>     kvmtool: https://git.kernel.org/pub/scm/linux/kernel/git/will/kvmtool.git/
> -- 
> 2.24.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
