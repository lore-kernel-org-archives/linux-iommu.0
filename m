Return-Path: <SRS0=6oxg=MB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0FBC07E99
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 14:21:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F9B1613BD
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 14:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9B1613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19D38423D0;
	Fri,  9 Jul 2021 14:21:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j2hvDn-t4gRs; Fri,  9 Jul 2021 14:21:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E91D7423C1;
	Fri,  9 Jul 2021 14:21:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0C8EC0010;
	Fri,  9 Jul 2021 14:21:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DBEDC000E;
 Fri,  9 Jul 2021 14:21:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ED3D56072A;
 Fri,  9 Jul 2021 14:21:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BDI2UXnKaTcW; Fri,  9 Jul 2021 14:21:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B876560677;
 Fri,  9 Jul 2021 14:21:17 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id a13so12358713wrf.10;
 Fri, 09 Jul 2021 07:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=27l4Uz/+uYVwD8O7yGXhjHeXe9a3hQtGW17m68tCa8g=;
 b=bIMbbu1UX9jjkfAsM8FJbbjQblv9KdSTZr1eoRZyMRK+PIYYlioiQVP2qEeuf85D6q
 5epCeBKkgtifIPWIJC+UnXbIdC6YmKWYIEuOQZVeyLR+WPwRTTbW9QrCle0ocYwyCZum
 /mX2eaHkbtpNOEODrrYUtFGVqM01QOjk1eiWqAUNK93dvAWDpEgRaEpZHzW4fGS+POpB
 mMGTqXdaveCjJB1mbv/VM54Pd8JMeHM7MWEJ2ObkyLbVBo4LpgPBy68QmfIR/wnIld8p
 M2jEl5WQJdD4FmGz6bPnqIXcC+S3E1XlZ4uYk1xKN0Akar7ciE04Ef1Joc6sabLbWh7l
 gsSQ==
X-Gm-Message-State: AOAM5336RPHvxwBWhqvOp6yo/B3ArM+3Ob/XwNFQ4rDigSoXG0Ok5YWv
 0dHJwrgn6x78ykbKnFJqFBc=
X-Google-Smtp-Source: ABdhPJwU8kQSV9vDkCxcapU34T3qNg4eLb3XB3zA3/6ahpSdfxcMnEegnlP/Bp0xLs8nfBCCunDgOA==
X-Received: by 2002:adf:facf:: with SMTP id a15mr20539330wrs.39.1625840476073; 
 Fri, 09 Jul 2021 07:21:16 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
 by smtp.gmail.com with ESMTPSA id i12sm5625277wrp.57.2021.07.09.07.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jul 2021 07:21:15 -0700 (PDT)
Date: Fri, 9 Jul 2021 14:21:14 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC v1 4/8] intel/vt-d: export intel_iommu_get_resv_regions
Message-ID: <20210709142114.r5vhxmmp6mzq3vjl@liuwe-devbox-debian-v2>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-5-wei.liu@kernel.org>
 <f32e17d4-e435-cd50-8afc-68f6133fd1a0@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f32e17d4-e435-cd50-8afc-68f6133fd1a0@linux.intel.com>
Cc: Wei Liu <wei.liu@kernel.org>, pasha.tatashin@soleen.com,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 kumarpraveen@linux.microsoft.com, David Woodhouse <dwmw2@infradead.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 "open list:INTEL IOMMU \(VT-d\)" <iommu@lists.linux-foundation.org>,
 Michael Kelley <mikelley@microsoft.com>, Will Deacon <will@kernel.org>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 virtualization@lists.linux-foundation.org,
 Vineeth Pillai <viremana@linux.microsoft.com>
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

On Fri, Jul 09, 2021 at 10:17:25PM +0800, Lu Baolu wrote:
> On 2021/7/9 19:43, Wei Liu wrote:
> > When Microsoft Hypervisor runs on Intel platforms it needs to know the
> > reserved regions to program devices correctly. There is no reason to
> > duplicate intel_iommu_get_resv_regions. Export it.
> 
> Why not using iommu_get_resv_regions()?

That calls into ops->get_resv_regions.

In this patch series, get_resv_regions is hv_iommu_resv_regions, which
wants to use intel_iommu_get_resv_regions when it detects the underlying
hardware platform is from Intel.

Wei.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
