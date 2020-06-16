Return-Path: <SRS0=6LHv=75=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA41C433E0
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 16:09:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C15222071A
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 16:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XT/uDfKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15222071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 78F1286A42;
	Tue, 16 Jun 2020 16:09:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id phAzsbOa261K; Tue, 16 Jun 2020 16:09:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EDB36879BB;
	Tue, 16 Jun 2020 16:09:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E212BC0888;
	Tue, 16 Jun 2020 16:09:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FC76C016E
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 16:09:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7CD7A20430
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 16:09:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q8jZOCQ7S4Br for <iommu@lists.linux-foundation.org>;
 Tue, 16 Jun 2020 16:09:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 95DB82039E
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 16:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592323761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2y8KD7xWbYjXU/cEL7LgtQkBTECAhlAA76XR+Aplj6k=;
 b=XT/uDfKZ+Nz+aKowO4BAdx/H5jwyTOnD34TZbFaDITYa3rC14T/bPWPFfbjAviz+qNEVP3
 /9Ud2KhGIkL69nuh+nUNSnQr461W94Pmov/gsP9vJJWr2UfsgNpBXI/AHKi02EPH75JhTd
 bXS6KQdqzryLGWRMALwusGgaUlBg/dQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-jOHdpFSPO6WydHLphIqszQ-1; Tue, 16 Jun 2020 12:09:19 -0400
X-MC-Unique: jOHdpFSPO6WydHLphIqszQ-1
Received: by mail-qv1-f72.google.com with SMTP id o1so15892283qvq.14
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 09:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2y8KD7xWbYjXU/cEL7LgtQkBTECAhlAA76XR+Aplj6k=;
 b=ckOiX+i2WYlE0DTup3oQ1faQxPBr07yIVQtS4xsvV0d9V4T8lzf3F01GLsGUvRyhAz
 OvcZiQh62v/jz0rEqRCOWUNY5CDP1hyZLnIrmN2M2GYAmBv4eqW30lIiXjG8Hkdafs24
 7xZcSNjwx6iz/B/AcR3FcTeI7wvZmhwjxe7P2FUevpuqC5rlSfbNuhsEA+lVOIUtN2UW
 w779l/8HpLHSFeqNhX5AgoLPy2kLE96twcGmVjPW5yuOnOnkYUeZJCWQnGh3GvEFq56l
 K2SSy2a4ey4u+M8lk9CCScMSule+TyhKfEHttDu6TXkX5K2/h3lIRQ5jcNIX0Xk3A0fu
 tLWw==
X-Gm-Message-State: AOAM532zwt4DwAkQ0GGdsbSBnPAH8BJ06+IDlKi3nygg2A3brB3mPKFi
 7RNajNnG+UhogWolm5Zdvmi45eL8eiFRgfDXIbPkhp8D+TmD0WTJGausyb3ZAl625rQFQ/ZfpB/
 h61bm6Yi0E86IzVKfmsvlaPNOMlTzSA==
X-Received: by 2002:ad4:54ea:: with SMTP id k10mr3112699qvx.66.1592323758932; 
 Tue, 16 Jun 2020 09:09:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoN5ZsEbH2t5hBW9WW5hOk33D7AAL34ncw5O7fmuB3JLmLE9egHSi0toqNT8A+dCzhofL/5Q==
X-Received: by 2002:ad4:54ea:: with SMTP id k10mr3112676qvx.66.1592323758723; 
 Tue, 16 Jun 2020 09:09:18 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id y1sm15552040qta.82.2020.06.16.09.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 09:09:17 -0700 (PDT)
Date: Tue, 16 Jun 2020 12:09:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v2 00/15] vfio: expose virtual Shared Virtual Addressing
 to VMs
Message-ID: <20200616160916.GC11838@xz-x1>
References: <1591877734-66527-1-git-send-email-yi.l.liu@intel.com>
 <20200615100214.GC1491454@stefanha-x1.localdomain>
 <MWHPR11MB16451F1E4748DF97D6A1DDD48C9D0@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20200616154928.GF1491454@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200616154928.GF1491454@stefanha-x1.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Wu,
 Hao" <hao.wu@intel.com>, "Tian, Jun J" <jun.j.tian@intel.com>
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

On Tue, Jun 16, 2020 at 04:49:28PM +0100, Stefan Hajnoczi wrote:
> Isolation between applications is preserved but there is no isolation
> between the device and the application itself. The application needs to
> trust the device.
> 
> Examples:
> 
> 1. The device can snoop secret data from readable pages in the
>    application's virtual memory space.
> 
> 2. The device can gain arbitrary execution on the CPU by overwriting
>    control flow addresses (e.g. function pointers, stack return
>    addresses) in writable pages.

To me, SVA seems to be that "middle layer" of secure where it's not as safe as
VFIO_IOMMU_MAP_DMA which has buffer level granularity of control (but of course
we pay overhead on buffer setups and on-the-fly translations), however it's far
better than DMA with no IOMMU which can ruin the whole host/guest, because
after all we do a lot of isolations as process based.

IMHO it's the same as when we see a VM (or the QEMU process) as a whole along
with the guest code.  In some cases we don't care if the guest did some bad
things to mess up with its own QEMU process.  It is still ideal if we can even
stop the guest from doing so, but when it's not easy to do it the ideal way, we
just lower the requirement to not spread the influence to the host and other
VMs.

Thanks,

-- 
Peter Xu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
