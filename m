Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF494C433F5
	for <iommu@archiver.kernel.org>; Fri, 25 Mar 2022 22:10:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88AEC60BD2;
	Fri, 25 Mar 2022 22:10:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2NVxQFYgPcwQ; Fri, 25 Mar 2022 22:10:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 38D8D60AD2;
	Fri, 25 Mar 2022 22:10:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 070C1C002C;
	Fri, 25 Mar 2022 22:10:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44B79C0012
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 22:10:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 259AA41C44
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 22:10:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DCHecMpyV1LR for <iommu@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 22:10:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2D57941C42
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 22:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648246226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VyaXfFZWYnH0nTgXGHqLHY4ZQDZWOehm+59/v0lzINo=;
 b=L1nAhnsk1OQ9mKDhHhd8sRUpszTmA3+C0YSlwE5iFTjiSYl+B24FbO0QbsByQO8FVPyplr
 OV2l1huASXvQEGphCPYZ9Ui3oh4GNl1tmi8WZoXtzqbrTcgKwtrMkLosNblAQH3FcCMul7
 G/3grK2/2D5H9QPX+hPZPNE07JJw8es=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-RZjECL3SPam3wF1GiFPq7A-1; Fri, 25 Mar 2022 18:10:25 -0400
X-MC-Unique: RZjECL3SPam3wF1GiFPq7A-1
Received: by mail-oi1-f199.google.com with SMTP id
 11-20020a54418b000000b002d9ef5ace5dso5000574oiy.13
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 15:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=MYxUHXO0VN8cAzsLjh14XB9FWmK16dnEZICYv5j/0hQ=;
 b=EpE6z+tS6yvaYvIdI6r1sxyvS3cGmPsX4a1zuPeKQL9mUVpJn8Jhk0HAKfFKacuq0l
 egAj0iKzddbCv4gOHByT0Fz9hz3FqPbH+HTkdN1fXEH8RBUMsYDr1TtLTPh64c9qmKzN
 dHptCqlPXfJK9Gr9Vci4kiS03NBG10IRvE65Vpwhmwno6Wv9tdcG6hZg7G9vfdXdqD5I
 EZsb/6A6L0/bvr6bPZ0N/+TQiuDo3YhwYRHBU0uEN2EfITxHXsepfn/5Q3TelsTzzM2a
 KHvZgfpeO3OJPk5+Bha/bAavhs0Mt3yzw3pJh2buP/VcDQDQZFIjYXndWJnrgzRKu6fy
 Sbog==
X-Gm-Message-State: AOAM530GL3BXvy86F1UdlldrSwGWBWOJ9cy6kAKiJmpFAVvH0lrB2sbZ
 vt3hA5JGRHMzblhEJ4ta01n3nVWf/iKriw31tNKxpro7TJB6e8xx6o82Tr9XfT69a9y+Fmm9J3Z
 1IAUVLb2GaQR73wJgi7LRcPZCwlvS4Q==
X-Received: by 2002:a05:6808:8c7:b0:2ee:f75b:bc20 with SMTP id
 k7-20020a05680808c700b002eef75bbc20mr6568538oij.44.1648246224326; 
 Fri, 25 Mar 2022 15:10:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9F3W34Mbp+dFTpptvzmDqU5fvpFhxK1p2w9dnHZXvNhOeDPaCs4O3sVj7xC3sJpgFekAEBg==
X-Received: by 2002:a05:6808:8c7:b0:2ee:f75b:bc20 with SMTP id
 k7-20020a05680808c700b002eef75bbc20mr6568526oij.44.1648246223992; 
 Fri, 25 Mar 2022 15:10:23 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 bm51-20020a0568081ab300b002da5c44e0bdsm3307583oib.28.2022.03.25.15.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Mar 2022 15:10:23 -0700 (PDT)
Date: Fri, 25 Mar 2022 16:10:22 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Daniel F. Smith" <dfsmith@us.ibm.com>
Subject: Re: Bug report: VFIO map/unmep mem subject to race and DMA data
 goes to incorrect page (4.18.0)
Message-ID: <20220325161022.00ab43ff.alex.williamson@redhat.com>
In-Reply-To: <20220325200640.GA29990@porter.almaden.ibm.com>
References: <20220325200640.GA29990@porter.almaden.ibm.com>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: iommu@lists.linux-foundation.org
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

Hi Daniel,

On Fri, 25 Mar 2022 13:06:40 -0700
"Daniel F. Smith" <dfsmith@us.ibm.com> wrote:

> This email is to document an insidious (incorrect data, no error or warning)
> VFIO bug found when using the Intel IOMMU to perform DMA transfers; and the
> associated workaround.
> 
> There may be security implications (unsure).
> 
> /sys/devices/virtual/iommu/dmar0/intel-iommu/version: 1:0
> /sys/devices/virtual/iommu/dmar0/intel-iommu/cap: d2008c40660462
> Linux xxxxx.ibm.com 4.18.0-348.20.1.el8_5.x86_64 #1 SMP Tue Mar 8 12:56:54 EST 2022 x86_64 x86_64 x86_64 GNU/Linux
> Red Hat Enterprise Linux release 8.5 (Ootpa)
> 
> In our testing of VFIO DMA to an FPGA card in rootless mode, we discovered a
> glitch where DMA data are transferred to/from the incorrect page.  It
> appears timing based.  Under some specific conditions the test could trigger
> the bug every loop.  Sometimes the bug would only emerge after 20+ minutes
> of testing.
> 
> Basics of test:
> 	Get memory with mmap(anonymous): size can change.
> 	VFIO_IOMMU_MAP_DMA with a block of memory, fixed IOVA.
> 	Fill memory with pattern.
> 	Do DMA transfer to FPGA from memory at IOVA.
> 	Do DMA transfer from FPGA to memory at IOVA+offset.
> 	Compare memory to ensure match.  Miscompare is bug.
> 	VFIO_IOMMU_UNMAP_DMA 
> 	unmap()
> 	Repeat.
> 
> Using the fixed IOVA address* caused sporadic memory miscompares.  The
> nature of the miscompares is that the received data was mixed with pages
> that had been returned by mmap in a *previous* loop.
> 
> Workaround: Randomizing the IOVA eliminated the memory miscompares.
> 
> Hypothesis/conjecture: Possible race condition in UNMAP_DMA such that pages
> can be released/munlocked *after* the MAP_DMA with the same IOVA has
> occurred.

Coherency possibly.

There's a possible coherency issue at the compare depending on the
IOMMU capabilities which could affect whether DMA is coherent to memory
or requires an explicit flush.  I'm a little suspicious whether dmar0
is really the IOMMU controlling this device since you mention a 39bit
IOVA space, which is more typical of Intel client platforms which can
also have integrated graphics which often have a dedicated IOMMU at
dmar0 that isn't necessarily representative of the other IOMMUs in the
system, especially with regard to snoop-control.  Each dmar lists the
managed devices under it in sysfs to verify.  Support for snoop-control
would be identified in the ecap register rather than the cap register.
VFIO can also report coherency via the VFIO_DMA_CC_IOMMU extension
reported by VFIO_CHECK_EXTENSION ioctl.

However, CPU coherency might lead to a miscompare, but not necessarily a
miscompare matching the previous iteration.  Still, for completeness
let's make sure this isn't a gap in the test programming making invalid
assumptions about CPU/DMA coherency.

The fact that randomizing the IOVA provides a workaround though might
suggest something relative to the IOMMU page table coherency.  But for
the new mmap target to have the data from the previous iteration, the
IOMMU PTE would need to be stale on read, but correct on write in order
to land back in your new mmap.  That seems peculiar.  Are we sure the
FPGA device isn't caching the value at the IOVA or using any sort of
IOTLB caching such as ATS that might not be working correctly?

> Suggestion: Document issue when using fixed IOVA, or fix if security
> is a concern.

I don't know that there's enough information here to make any
conclusions.  Here are some further questions:

 * What size mappings are being used, both for the mmap and the VFIO
   MAP/UNMAP operations.

 * If the above is venturing into super page support (2MB), does the
   vfio_iommu_type1 module option disable_hugepages=1 affect the
   results.

 * Along the same lines, does the kernel command line option
   intel_iommu=sp_off produce different results.

 * Does this behavior also occur on upstream kernels (ie. v5.17)?

 * Do additional CPU cache flushes in the test program produce different
   results?

 * Is this a consumer available FPGA device that others might be able
   to reproduce this issue?  I've always wanted such a device for
   testing, but also we can't rule out that the FPGA itself or its
   programming is the source of the miscompare.

From the vfio perspective, UNMAP_DMA should first unmap the pages at
the IOMMU to prevent device access before unpinning the pages.  We do
make use of batch unmapping to reduce iotlb flushing, but the result is
expected to be that the IOMMU PTE entries are invalidated before the
UNMAP_DMA operation completes.  A stale IOVA would not be expected or
correct operation.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
