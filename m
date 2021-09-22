Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D65EC433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 13:45:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCB94611C9
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 13:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BCB94611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93E9D80E3B;
	Wed, 22 Sep 2021 13:45:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EAjd3HALuBKb; Wed, 22 Sep 2021 13:45:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6717280E33;
	Wed, 22 Sep 2021 13:45:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 526ACC000F;
	Wed, 22 Sep 2021 13:45:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD32BC000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 13:45:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B810D404FE
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 13:45:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TMgCh41HiBGb for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 13:45:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 891C640480
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 13:45:33 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id t8so7039047wrq.4
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 06:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=OqATTE/BrEowQNUew/i6t2ee/2HGj0S7vXDfrjI49UE=;
 b=DiFDtXnK5X1h8sM3UZZQRitNG46c4VhNndlN1Odh528nj4uqe1rhaiY9GrzMcSViJ1
 rdpmjBv5rgcIxCztX0ZC6gUzb0g7Av9IlCsKTuW5/TJ0I1n0JfVcD6Bti2sizUZdoN/Q
 Hajavq/eLRHSvRS+MW3GxTtRFbIXdSCyG75s1XxJjIv2L8HOSapwFmOAHtN0JmiQKrSS
 8kQV/YWauMZ9YmXgzL0VI14g/jBN6zXaVWoXggUZUtrSNRRWbyDPHlDFXNlSPomnOTYC
 nlbbobY5tGo0sKEALZSpdtpxH5Ep1jqzvBp8MH2fyzTf7VMYYYrkKbG6sdJXK1aHboA/
 oflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OqATTE/BrEowQNUew/i6t2ee/2HGj0S7vXDfrjI49UE=;
 b=I9Amyr7ni1pBU0ZY197uxhvlLBTHZBokOh5TIPEx4sL+SPO41O/FRWKXJMk2lsxo98
 g3mOUTReHWnu/i2uORNMf9yPC+8taTde9oLuRfC4DbTEcHcj7V6yFgq/Zg8dV9D4ox3V
 9l0gHEqTFdZjuCM3pRY9JmcmF/y5P3O/1PYZU1Lh54M7nhoJSdFSpbKQKNMKmkeI/eOL
 u+2f5acFJ2Bbe8d5oPEfaDRihGKhweyWHw0J0jMcvpNCQ9kpcYGI6vOhMwEFZH77ercp
 yWf6G/FsDtYaKks/5i9/pi/Gfeg+Pc0FloAuR3O9P007mGG8l/mJLq7NPQmcfPKp8gWE
 DDPA==
X-Gm-Message-State: AOAM532Gtq1ttS8MkL4WuvpFqkyDBXYS8AGFmqJVbrWG76Gj0HiYJ0Es
 EIYzFnCxfeopDqNAfHcKlQHa3g==
X-Google-Smtp-Source: ABdhPJxBzcwQu66fWHD0pP9MO/Sy42U55J8u2Jc1kFiULK7OUlEvJjbPdmOm0qWW1UWefraskQ1WQw==
X-Received: by 2002:a05:6000:1081:: with SMTP id
 y1mr42132164wrw.14.1632318331658; 
 Wed, 22 Sep 2021 06:45:31 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id i2sm2158226wrq.78.2021.09.22.06.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Sep 2021 06:45:31 -0700 (PDT)
Date: Wed, 22 Sep 2021 14:45:09 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Message-ID: <YUszZRk1vZOgVvFF@myrica>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-12-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210919063848.1476776-12-yi.l.liu@intel.com>
Cc: kvm@vger.kernel.org, jasowang@redhat.com, kwankhede@nvidia.com, hch@lst.de,
 dave.jiang@intel.com, ashok.raj@intel.com, corbet@lwn.net, jgg@nvidia.com,
 kevin.tian@intel.com, parav@mellanox.com, alex.williamson@redhat.com,
 lkml@metux.net, david@gibson.dropbear.id.au, dwmw2@infradead.org,
 jun.j.tian@intel.com, linux-kernel@vger.kernel.org, lushenming@huawei.com,
 iommu@lists.linux-foundation.org, pbonzini@redhat.com, robin.murphy@arm.com
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

On Sun, Sep 19, 2021 at 02:38:39PM +0800, Liu Yi L wrote:
> This patch adds IOASID allocation/free interface per iommufd. When
> allocating an IOASID, userspace is expected to specify the type and
> format information for the target I/O page table.
> 
> This RFC supports only one type (IOMMU_IOASID_TYPE_KERNEL_TYPE1V2),
> implying a kernel-managed I/O page table with vfio type1v2 mapping
> semantics. For this type the user should specify the addr_width of
> the I/O address space and whether the I/O page table is created in
> an iommu enfore_snoop format. enforce_snoop must be true at this point,
> as the false setting requires additional contract with KVM on handling
> WBINVD emulation, which can be added later.
> 
> Userspace is expected to call IOMMU_CHECK_EXTENSION (see next patch)
> for what formats can be specified when allocating an IOASID.
> 
> Open:
> - Devices on PPC platform currently use a different iommu driver in vfio.
>   Per previous discussion they can also use vfio type1v2 as long as there
>   is a way to claim a specific iova range from a system-wide address space.

Is this the reason for passing addr_width to IOASID_ALLOC?  I didn't get
what it's used for or why it's mandatory. But for PPC it sounds like it
should be an address range instead of an upper limit?

Thanks,
Jean

>   This requirement doesn't sound PPC specific, as addr_width for pci devices
>   can be also represented by a range [0, 2^addr_width-1]. This RFC hasn't
>   adopted this design yet. We hope to have formal alignment in v1 discussion
>   and then decide how to incorporate it in v2.
> 
> - Currently ioasid term has already been used in the kernel (drivers/iommu/
>   ioasid.c) to represent the hardware I/O address space ID in the wire. It
>   covers both PCI PASID (Process Address Space ID) and ARM SSID (Sub-Stream
>   ID). We need find a way to resolve the naming conflict between the hardware
>   ID and software handle. One option is to rename the existing ioasid to be
>   pasid or ssid, given their full names still sound generic. Appreciate more
>   thoughts on this open!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
