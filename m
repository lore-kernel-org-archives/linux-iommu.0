Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF9FC433F5
	for <iommu@archiver.kernel.org>; Fri, 18 Feb 2022 08:22:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D44F66076C;
	Fri, 18 Feb 2022 08:22:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q1Imhr_yldc4; Fri, 18 Feb 2022 08:22:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9F7E7607D6;
	Fri, 18 Feb 2022 08:22:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F4AFC0011;
	Fri, 18 Feb 2022 08:22:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15016C000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 08:22:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 02990607D6
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 08:22:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FaKwtckitkvx for <iommu@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 08:22:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 519476076C
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 08:22:07 +0000 (UTC)
Received: by mail-vs1-xe2b.google.com with SMTP id i27so9082743vsr.10
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 00:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eMllH6SqtmgTmAnOJGaH+RpoEMH0PN5Is8QhFl+6HxM=;
 b=HL0wvkvGe2eP4np3H58p9xh104v5TkTJEGcm2ZjEC8IxhSg9P85EuQemODe8R9Tte0
 qkvcUJdoLwgX4yY24qQB9GWFnVgumjIpIhQIhMEESf15ibGXNnSr8c3k5r3+akfxI1/q
 8YKI4SgITdEfG0fZZJgGMMvqFAIO/514sC/iXvoNojHOV8S30aCCjHMXawdsRNsnDPIR
 yBCWJAFuPbL0NS/r2wWaxWvXV8xM3fYGLgeKR54IqD6kk3hfgU84fDC+xfiaUNKO+15B
 lWjXVMyAfuQ4AQE9W29lJKd0DZL62Tc5YvksLasFXzg8R8tic3gM0t3DjM3EWeZqpkby
 O2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eMllH6SqtmgTmAnOJGaH+RpoEMH0PN5Is8QhFl+6HxM=;
 b=G932X9B3Hxc9LvzOjLbVyR0z4b0HOmzhq2Szy6GnYjvTBhVvGsDJt4Sgg1P+ur4RUj
 KoDaytEb8jwijm87I3KK4wzybykAAJsahVzqh6k+1+eSFxz9+lUMDLRhb0PPYyjIVAbu
 8fGgawXP2orI5X8ojFKzHLNODz0eyspm+bIDjQu45BgreeYgYS3xniPax83HJQC/zfM0
 SXuiGyp8vh3tnpyaKn+2ycp4sdFo9u1QJ0ZRfSKdd5Eg7i9RQZziMz5G2Rv7FgOYcF7b
 Y30deJ6m1eD91LifLOTzIzAXZpkayz6gHGwRwvX2HeWugKZlkMH7FDnV6+tFtPIiLMfs
 L7GQ==
X-Gm-Message-State: AOAM533YfKYSMVLJueixXQDq22SiNTXBD4PEausLhYAVFQSx/Hck1wyF
 3Cbc0tBDubg09as0f6ba4yC5TaWG5tO2Bhzi14E=
X-Google-Smtp-Source: ABdhPJyCzfXvNtee5NBtD8m4thIouz/upC6brVCpl5NMEty8kQbjo0ufFCmtxWrnRxqYd+vLzCwWxODQf/SH3xyxQoY=
X-Received: by 2002:a05:6102:38c9:b0:31b:e4b3:5106 with SMTP id
 k9-20020a05610238c900b0031be4b35106mr3080505vst.39.1645172525992; Fri, 18 Feb
 2022 00:22:05 -0800 (PST)
MIME-Version: 1.0
References: <20220216091307.703-1-adrianhuang0701@gmail.com>
 <989cf124-13d7-5601-a942-e515c81a72a9@linux.intel.com>
In-Reply-To: <989cf124-13d7-5601-a942-e515c81a72a9@linux.intel.com>
From: Huang Adrian <adrianhuang0701@gmail.com>
Date: Fri, 18 Feb 2022 16:21:54 +0800
Message-ID: <CAHKZfL0dx8HuuB1AqN3fkcHjPZDJMTfPqRgW4XnuFVE8Cw4iFQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Fix list_add double add when enabling
 VMD and scalable mode
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
 Nirmal Patel <nirmal.patel@linux.intel.com>, stable@vger.kernel.org,
 iommu@lists.linux-foundation.org, Adrian Huang <ahuang12@lenovo.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>,
 David Woodhouse <dwmw2@infradead.org>
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

On Fri, Feb 18, 2022 at 10:30 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> On 2/16/22 5:13 PM, Adrian Huang wrote:
> > pci_real_dma_dev() in pci_for_each_dma_alias() gets the real dma device
> > which is the VMD device 0000:59:00.5. However, pte of the VMD device
> > 0000:59:00.5 has been configured during this message "pci 0000:59:00.5:
> > Adding to iommu group 42". So, the status -EBUSY is returned when
> > configuring pasid entry for device 10000:80:01.0.
>
> So the VMD subdevice (pci 10000:80:01.0) is an alias device of the "pci
> 0000:59:00.5", and it uses the Source-ID of "pci 0000:59:00.5" for DMA
> transactions. Do I understand it right? If so, it makes sense to skip
> setting up pasid entry for VMD subdevices.

Yes, your understanding is correct.

> Another thing I am still concerned is about the context entry setup.
> What does the context entries look like for both VMD and subdevices
> after domain_context_mapping() being called?

pasid_table in struct device_domain_info is NULL because the field
pasid_table is configured in intel_pasid_alloc_table().

The following statement in domain_context_mapping_one() is true for
subdevices because the context is configured by the real VMD device
0000:59:00.5. So, domain_context_mapping() does nothing for
subdevices.
                if (context_present(context))
                              goto out_unlock;

Here is the log for your reference with pr_debug() enabled.

[   19.063445] pci 0000:59:00.5: Adding to iommu group 42
...
[   22.673502] DMAR: Set context mapping for 59:00.5
..
[   32.089696] vmd 0000:59:00.5: PCI host bridge to bus 10000:80
[   32.119452] pci 10000:80:01.0: [8086:352a] type 01 class 0x060400
[   32.126302] pci 10000:80:01.0: reg 0x10: [mem 0x00000000-0x0001ffff 64bit]
[   32.134023] pci 10000:80:01.0: enabling Extended Tags
[   32.139730] pci 10000:80:01.0: PME# supported from D0 D3hot D3cold
[   32.160526] DMAR: Set context mapping for 59:00.5
[   32.171090] pci 10000:80:01.0: Adding to iommu group 42
...

-- Adrian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
