Return-Path: <SRS0=OemM=6S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7AFC47258
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 15:09:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14FD3206D7
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 15:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QNbwqk4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FD3206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DBFC7888BC;
	Mon,  4 May 2020 15:09:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JHdhYbBImAU7; Mon,  4 May 2020 15:09:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 448A688891;
	Mon,  4 May 2020 15:09:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E176C088A;
	Mon,  4 May 2020 15:09:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F04A6C0175
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 15:09:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DF630863E0
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 15:09:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tBbC4sglrS4u for <iommu@lists.linux-foundation.org>;
 Mon,  4 May 2020 15:09:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D7FAF85D78
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 15:09:37 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id k1so21404347wrx.4
 for <iommu@lists.linux-foundation.org>; Mon, 04 May 2020 08:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ymxZ/AHKc54MsFnFnjiy487/cd2cO0lIerw33LQLJwg=;
 b=QNbwqk4D1MPIi3P7kInzB1wd9Nwnz4c2VQo9LuhJOdRLdMrPzNMgpvKqTLZMK1uPi+
 P2pe+v2OCrrPEexPYdYwl192CIA5G6xYliglrRqqtdaIAR+usOr6a/3cJuAgWCIrlSe1
 OdskZIteDeuDIgetVe9zuT/oEpmFwh99LEyLr+Zq8PUuCUTWaKKGaTmfFvbQ2/+u5d3b
 tftW1WWsJsddoYK8llhhdNTtirX5vLRtjEeFAIEdNjNGfsIxaS1xLDMsskU7xZaWG3ng
 uBZkgyMKL71WDmOBvkjPrl5x7RLtobyGsphgAfOHe28m7ebcN/qz+Xrs9em6Jezxz6jQ
 4Kkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ymxZ/AHKc54MsFnFnjiy487/cd2cO0lIerw33LQLJwg=;
 b=R5Asaxzl6/rRf5xzi1jvQ6+8BmxMLpb5dpwaHqvG/paK4n0/hH+A+ThE/Cadzk0SGE
 sLdfSzY0Y4pLOMyv8RhAL0Ohg5mT5AIaioc0Z2jaFO6rquc0L3UAqY7m05ac+zkvMeb8
 PxWAL5QlB/Ob43x4keDIIt1L5CeZwP+umpiWgU+P6rFDfxP2O77C4QJrA1S8h07bTOby
 oWycgqobgRBZP1rmDyRoLFakHnTAdaN6EDjgP1KSbyqzHZRYLe5tDTFOf61TaYt+85IZ
 m3+6DO9QzBgP7/fvoDvecn31Biy2xjY48npIA9zhwu0L9llmw35HJ/cKZ3dZ4R0etHfM
 2qcg==
X-Gm-Message-State: AGi0PubuNmY4Ia8J8FPri88zdCcnEsy95r3zp33YToUHJUCe7mfsFMPN
 boZNjqPYHolItHMdAhSYzNLR9g==
X-Google-Smtp-Source: APiQypIDrGUvuteScMrJ9fLWEogSG6ijt2/PYwyFrJ0NSjLGFvyO34VY4LnIIaZoFl/ctKT+r9PVxQ==
X-Received: by 2002:adf:ee86:: with SMTP id b6mr56993wro.419.1588604976411;
 Mon, 04 May 2020 08:09:36 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id w83sm14711145wmb.37.2020.05.04.08.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 08:09:35 -0700 (PDT)
Date: Mon, 4 May 2020 17:09:26 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v6 00/25] iommu: Shared Virtual Addressing for SMMUv3
Message-ID: <20200504150926.GA176594@myrica>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430141816.595b758f@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200430141816.595b758f@jacob-builder>
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com, jgg@ziepe.ca,
 linux-pci@vger.kernel.org, robin.murphy@arm.com, fenghua.yu@intel.com,
 hch@infradead.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, catalin.marinas@arm.com, felix.kuehling@amd.com,
 will@kernel.org, christian.koenig@amd.com,
 linux-arm-kernel@lists.infradead.org
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

On Thu, Apr 30, 2020 at 02:18:16PM -0700, Jacob Pan wrote:
> On Thu, 30 Apr 2020 16:33:59 +0200
> Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> 
> > Shared Virtual Addressing (SVA) allows to share process page tables
> > with devices using the IOMMU, PASIDs and I/O page faults. Add SVA
> > support to the Arm SMMUv3 driver.
> > 
> > Since v5 [1]:
> > 
> > * Added patches 1-3. Patch 1 adds a PASID field to mm_struct as
> >   discussed in [1] and [2]. This is also needed for Intel ENQCMD.
> > Patch 2 adds refcounts to IOASID and patch 3 adds a couple of helpers
> > to allocate the PASID.
> > 
> > * Dropped most of iommu-sva.c. After getting rid of io_mm following
> >   review of v5, there wasn't enough generic code left to justify the
> >   indirect branch overhead of io_mm_ops in the MMU notifiers. I ended
> > up with more glue than useful code, and couldn't find an easy way to
> > deal with domains in the SMMU driver (we keep PASID tables per domain,
> >   while x86 keeps them per device). The direct approach in patch 17 is
> >   nicer and a little easier to read. The SMMU driver only gained 160
> >   lines, while iommu-sva lost 470 lines.
> > 
> >   As a result I dropped the MMU notifier patch.
> > 
> >   Jacob, one upside of this rework is that we now free ioasids in
> >   blocking context, which might help with your addition of notifiers
> > to ioasid.c
> > 
> Thanks for the note. It does make notifier much easier, plus the
> refcount can alleviate the constraint on ordering.
> 
> I guess we don't share mmu notifier code for now :)

I think it's more efficient for each IOMMU driver to at least implement
their own invalidate_range() callback and avoid indirect branches. For the
rest I couldn't find a lot of code to share, most of it is writing PASID
tables and invalidating. We can revisit later, as long as we agree on the
bind() API the implementations should be similar enough.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
