Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1896C48BE6
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 12:40:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D71460249
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 12:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D71460249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 016E94047D;
	Wed, 16 Jun 2021 12:40:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 111w8e71RyDm; Wed, 16 Jun 2021 12:40:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3164340254;
	Wed, 16 Jun 2021 12:40:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEA39C000E;
	Wed, 16 Jun 2021 12:40:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C2CEC000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 12:40:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 55F97606EE
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 12:40:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dPQjpgeczlhp for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 12:40:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 52D596058B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 12:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623847210;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ubsBv6f8Gfa2qgRyhsGa5AFvRPZ+U40JlVZfwTYe0kE=;
 b=UfZ0d5EjyCFf65YNZvY44SJNcVIHL5fVARRL1i85wthOhaIx7zfE2vuIFasQdln1ZaPvsK
 XywCis6OUBLOX2AYVJRe+Mpo5VKk0BP9kf8X/rV3m82DtNOZHP7GzCjrVKOI5yXLF2df5q
 QM6bODhOEYTBnrIfhfyY3Mr6c0WdbGs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-LwiP2UMoO4W7NnkTILVQ_Q-1; Wed, 16 Jun 2021 08:40:06 -0400
X-MC-Unique: LwiP2UMoO4W7NnkTILVQ_Q-1
Received: by mail-wr1-f70.google.com with SMTP id
 k25-20020a5d52590000b0290114dee5b660so1073622wrc.16
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 05:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=ubsBv6f8Gfa2qgRyhsGa5AFvRPZ+U40JlVZfwTYe0kE=;
 b=ELNgJ8QUNSWCi4WA4esDeYcdx0oiSqXu9HVZdMafEeOVmLbREMvWBL6h19L8VNWBIm
 hralo5DDllMD00PQZhrtcE3vfgVVXzuWZ1qN7GHw0VKZAdA8zIX25V1UQiMS2hBSdD1M
 AHRhcI/YRavVMeYWok5oNUm4zBh3SWs9scc2h0if4IKSo7Eg0OoKXO7X+Cz4GL2hJ63I
 Q9VWMYBx810ZeHruSlV8nM05JEtNgXqfgJmrbavd9uV6xydWzTSjsq+I2bP9qi/7BNXp
 N1ipy2lWWWkInyDr+aoIE1ATgpLcshW6QC+O8p/MTAM6zwIIYMkUxbCkcalxRi7qkAOs
 EBHg==
X-Gm-Message-State: AOAM531OyC9QpKn2epfhV5pJCPR6q4ZWaPIVeCpT6BJLKXbj4m4ZJGCI
 2HJSu3+yNy5/j6yRFnlJeJASMF0KCcdGx1vfz8YaaiB+TRy0no74GBtcl78nhBSoPlLz6c+TjuL
 rzyYJa5Xydv3uBwd1Bt0v9xinAw73+w==
X-Received: by 2002:a5d:59af:: with SMTP id p15mr5235716wrr.292.1623847205678; 
 Wed, 16 Jun 2021 05:40:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5WQBLU4IKG9p3xxW0FVoOol8q9XU19Rj2M+rLCk3pLwV7dw9cSLzoXZeV3mgmVA67Soicyw==
X-Received: by 2002:a5d:59af:: with SMTP id p15mr5235693wrr.292.1623847205520; 
 Wed, 16 Jun 2021 05:40:05 -0700 (PDT)
Received: from [192.168.43.95] ([37.172.247.238])
 by smtp.gmail.com with ESMTPSA id v15sm4914297wmj.39.2021.06.16.05.40.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jun 2021 05:40:04 -0700 (PDT)
Subject: Re: [PATCH v4 0/6] Add support for ACPI VIOT
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, rjw@rjwysocki.net,
 lenb@kernel.org, joro@8bytes.org, mst@redhat.com
References: <20210610075130.67517-1-jean-philippe@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <883de842-d50a-53f9-7589-a6d20e913f2d@redhat.com>
Date: Wed, 16 Jun 2021 14:40:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210610075130.67517-1-jean-philippe@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kevin.tian@intel.com, catalin.marinas@arm.com, sudeep.holla@arm.com,
 robin.murphy@arm.com, virtualization@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, guohanjun@huawei.com, will@kernel.org,
 dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org
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

Hi Jean,

On 6/10/21 9:51 AM, Jean-Philippe Brucker wrote:
> Add a driver for the ACPI VIOT table, which provides topology
> information for para-virtual IOMMUs. Enable virtio-iommu on
> non-devicetree platforms, including x86.
>
> Since v3 [1] I fixed a build bug for !CONFIG_IOMMU_API. Joerg offered to
> take this series through the IOMMU tree, which requires Acks for patches
> 1-3.
>
> You can find a QEMU implementation at [2], with extra support for
> testing all VIOT nodes including MMIO-based endpoints and IOMMU.
> This series is at [3].
>
> [1] https://lore.kernel.org/linux-iommu/20210602154444.1077006-1-jean-philippe@linaro.org/
> [2] https://jpbrucker.net/git/qemu/log/?h=virtio-iommu/acpi
> [3] https://jpbrucker.net/git/linux/log/?h=virtio-iommu/acpi

I tested the series on both aarch64 and x86_64 with qemu. It works for me.
Feel free to add my T-b.

Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

>
>
> Jean-Philippe Brucker (6):
>   ACPI: arm64: Move DMA setup operations out of IORT
>   ACPI: Move IOMMU setup code out of IORT
>   ACPI: Add driver for the VIOT table
>   iommu/dma: Pass address limit rather than size to
>     iommu_setup_dma_ops()
>   iommu/dma: Simplify calls to iommu_setup_dma_ops()
>   iommu/virtio: Enable x86 support
>
>  drivers/acpi/Kconfig         |   3 +
>  drivers/iommu/Kconfig        |   4 +-
>  drivers/acpi/Makefile        |   2 +
>  drivers/acpi/arm64/Makefile  |   1 +
>  include/acpi/acpi_bus.h      |   3 +
>  include/linux/acpi.h         |   3 +
>  include/linux/acpi_iort.h    |  14 +-
>  include/linux/acpi_viot.h    |  19 ++
>  include/linux/dma-iommu.h    |   4 +-
>  arch/arm64/mm/dma-mapping.c  |   2 +-
>  drivers/acpi/arm64/dma.c     |  50 +++++
>  drivers/acpi/arm64/iort.c    | 129 ++-----------
>  drivers/acpi/bus.c           |   2 +
>  drivers/acpi/scan.c          |  78 +++++++-
>  drivers/acpi/viot.c          | 364 +++++++++++++++++++++++++++++++++++
>  drivers/iommu/amd/iommu.c    |   9 +-
>  drivers/iommu/dma-iommu.c    |  17 +-
>  drivers/iommu/intel/iommu.c  |  10 +-
>  drivers/iommu/virtio-iommu.c |   8 +
>  MAINTAINERS                  |   8 +
>  20 files changed, 580 insertions(+), 150 deletions(-)
>  create mode 100644 include/linux/acpi_viot.h
>  create mode 100644 drivers/acpi/arm64/dma.c
>  create mode 100644 drivers/acpi/viot.c
>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
