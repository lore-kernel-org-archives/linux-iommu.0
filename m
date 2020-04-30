Return-Path: <SRS0=XdCg=6O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40041C47247
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 19:34:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0688920656
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 19:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nx/SPKJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0688920656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A59AE204D5;
	Thu, 30 Apr 2020 19:34:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u7zJ1hyw0XXg; Thu, 30 Apr 2020 19:34:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A5A1A20465;
	Thu, 30 Apr 2020 19:34:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 786D2C0889;
	Thu, 30 Apr 2020 19:34:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16347C016F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 19:34:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E26EB204AD
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 19:34:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G6nwazNt2tbE for <iommu@lists.linux-foundation.org>;
 Thu, 30 Apr 2020 19:34:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by silver.osuosl.org (Postfix) with ESMTPS id B7BFE20465
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 19:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588275271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sS8AddF4WlY4FM3AJEU8Vr5dd3INR3Y9YVDuw7T/d9Y=;
 b=Nx/SPKJc966HF0Nvun8X9o49ex3kFrtReHyeUHX/DpadYOYO5NQeJKvRub5Z4uuWldQ/Ku
 lnPyWsTFw6EAPfB3o0j5VMIlmZHlSZerr1HraWm4qnV4h7zpyxRQalq/pEtqAJO+cCui4E
 16whihZa6Dwviw6VzBxQz/SY0JCY8pM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-425PqBcLNvC4UN3ztSq8gQ-1; Thu, 30 Apr 2020 15:34:29 -0400
X-MC-Unique: 425PqBcLNvC4UN3ztSq8gQ-1
Received: by mail-wr1-f70.google.com with SMTP id j16so4379686wrw.20
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 12:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sS8AddF4WlY4FM3AJEU8Vr5dd3INR3Y9YVDuw7T/d9Y=;
 b=JE+040OSo59TlMxmvY44/9cyCSGPiddr53E/6LX078H1sxOxpogV6F07X+zuQKL+vg
 ssv/YeeWoZ5RbyizrboEZDHFX6OF3Dr7pPwd+oB/PwloLZ9HoAKOAFSGovO8Eh2VIPJN
 Qwc+IcDO3hLSUKI5WKA1zgZC2fNzfO6lJBCdLRtrolsYyI+6EvbFPDro+GNtsgj8E7rR
 +6ttwIIIjgTSjMP/sDYcylQmj5fETNW+COR6Fg4NzkH9NZLJ41tlsBlDYDEsRVRugZVD
 tDcGndN5E4vzh2R2lFe9dXj1lVhKWyDU6SLsyb1uRbRRqYpKSJ9GMMlwLlNnWpVJ18bJ
 UJmg==
X-Gm-Message-State: AGi0Pub+H0iUWlF50d7bMJS4L0RUOeG3ZSn0UKY+I7jAtEsMRLerHY9O
 H80lEyIhSG2iBiLE3Xt0YtLxQ6BeDiOPgg6bgGu6yljofgZ/Iixk06Y0Yt0xciqLNyr+i1czyj6
 qFUfPbAAOipQ2adXFNx+cuQOVqPAqlA==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr147554wmh.47.1588275268441;
 Thu, 30 Apr 2020 12:34:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypIErEi2OKs7eqnsETBaKuMVCIu+8B3dc0io3m7kIhj79uNOeJtHgco9xaP2TdUr4Pnz00osWA==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr147527wmh.47.1588275268199;
 Thu, 30 Apr 2020 12:34:28 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 n6sm831929wmc.28.2020.04.30.12.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 12:34:27 -0700 (PDT)
Date: Thu, 30 Apr 2020 15:34:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Subject: Re: [RFC/PATCH 1/1] virtio: Introduce MMIO ops
Message-ID: <20200430152808-mutt-send-email-mst@kernel.org>
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
 <1588240976-10213-2-git-send-email-vatsa@codeaurora.org>
 <20200430101431.GD19932@willie-the-truck>
 <20200430103446.GH5097@quicinc.com>
 <20200430104149.GG19932@willie-the-truck>
 <20200430111156.GI5097@quicinc.com>
 <7bf8bffe-267b-6c66-86c9-40017d3ca4c2@siemens.com>
 <20200430133321.GC3204@quicinc.com>
MIME-Version: 1.0
In-Reply-To: <20200430133321.GC3204@quicinc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org,
 konrad.wilk@oracle.com, Jan Kiszka <jan.kiszka@siemens.com>,
 jasowang@redhat.com, christoffer.dall@arm.com,
 virtualization@lists.linux-foundation.org, alex.bennee@linaro.org,
 iommu@lists.linux-foundation.org, stefano.stabellini@xilinx.com,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 pratikp@codeaurora.org
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

On Thu, Apr 30, 2020 at 07:03:21PM +0530, Srivatsa Vaddagiri wrote:
> * Jan Kiszka <jan.kiszka@siemens.com> [2020-04-30 14:59:50]:
> 
> > >I believe ivshmem2_virtio requires hypervisor to support PCI device emulation
> > >(for life-cycle management of VMs), which our hypervisor may not support.

PCI is mostly just 2 registers. One sets the affected device, one the data to read/write.

> A
> > >simple shared memory and doorbell or message-queue based transport will work for
> > >us.
> > 
> > As written in our private conversation, a mapping of the ivshmem2 device
> > discovery to platform mechanism (device tree etc.) and maybe even the
> > register access for doorbell and life-cycle management to something
> > hypercall-like would be imaginable. What would count more from virtio
> > perspective is a common mapping on a shared memory transport.
> 
> Yes that sounds simpler for us.
> 
> > That said, I also warned about all the features that PCI already defined
> > (such as message-based interrupts) which you may have to add when going a
> > different way for the shared memory device.
> 
> Is it really required to present this shared memory as belonging to a PCI
> device?

But then you will go on and add MSI, and NUMA, and security, and and and ...

> I would expect the device-tree to indicate the presence of this shared
> memory region, which we should be able to present to ivshmem2 as shared memory
> region to use (along with some handles for doorbell or message queue use).
> 
> I understand the usefulness of modeling the shared memory as part of device so
> that hypervisor can send events related to peers going down or coming up. In our
> case, there will be other means to discover those events and avoiding this
> requirement on hypervisor (to emulate PCI) will simplify the solution for us.
> 
> Any idea when we can expect virtio over ivshmem2 to become available?!

Check out the virtio spec. Right at the beginning it states:

	These devices are
	found in virtual environments, yet by design they look like physical devices to the guest within
	the virtual machine - and this document treats them as such. This similarity allows the guest to
	use standard drivers and discovery mechanisms


> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
