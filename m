Return-Path: <SRS0=jIn/=7C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D761C433DF
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 12:44:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1674320758
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 12:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p4CUdE9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1674320758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 04A9E86D4D;
	Wed, 20 May 2020 12:44:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3BOKquhCB4Wi; Wed, 20 May 2020 12:44:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7CD8B86D3C;
	Wed, 20 May 2020 12:44:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69D91C088A;
	Wed, 20 May 2020 12:44:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 476CAC0176
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 12:44:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 31E7C203BD
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 12:44:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id faX6A0whbLo2 for <iommu@lists.linux-foundation.org>;
 Wed, 20 May 2020 12:44:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 926F120409
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 12:44:25 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id w7so2947096wre.13
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 05:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Y40jbkqIfFkUI7ZiRlmLevn335EVOReBHbhD7GbihLE=;
 b=p4CUdE9pepIc4FjeGaw9rpilpouxhHRYmar9hVV44lZrKVe+1UvqNOkup4LagMa4QY
 RSw6gueqOVQJLw3Ihf4HjnGEeqYzD16ihtmI8ApVBWKguVmOsC265K7DCs7q+vqeIrq+
 i4i8JEAY4h3MumABqT9u+m2g7eKxueVgu/DqX/HqbPCE4Fi86oBv7FB2KIANCp4kXlVI
 JkQ9CXs0K1fF2yEBMU8Lfzp8SkbKKr2TlFvGnz0aPsuaSG1JDeRuAkvscN6I8mzTx1Pd
 MS3Hp7jFjjGxifFKQRdYDTxDLynvYZ8erE6M/7KCG6b5jjfD+3/kcUU/0mg8OwuNWKDn
 ZKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Y40jbkqIfFkUI7ZiRlmLevn335EVOReBHbhD7GbihLE=;
 b=qhc4oUAUJhq5JLWInRPAcKr6WNaQ1JRCbEIwR2dYyKdt8OVNdwfZITGueeKhYNXMxA
 wNF2ECv3v47HeCxK/a0zNbgHe0o3lJoX2sJOlAUceRZqjLdT++Dtf4ZoMkohOtd0qg5r
 fnpEm06n/dvVCmZ+DG58bUh9ycWwvVUAlU8II+ltwoMntbHi52KLi/5rHdGHNy46w6BA
 NlJIME0nr4ZPdbOIRmxl34HllqS8cUyfzHd0LM9GevIk4l2mEsN3JoVWl2Hm5zRRMmgg
 LRBWmbGTZSBlDFInb/pOvCtUIlifL/HYMMwaWWL4GWQmKdHLOFq3gJEdfgwHllYdrB1e
 7tew==
X-Gm-Message-State: AOAM5314f9GG/KHeaQlsr42rg6dlRJiDzqjftsOSd05mpe+pywXrNyNb
 AVZdRayMOUOWnePYJqm/s8pkOg==
X-Google-Smtp-Source: ABdhPJxVz5Ef/g7gSSEvpWEQLOSp0LR9XsoCDxDK4+T7RPFKUq8EqywmmWzSB+P43U85QvHoiTf27A==
X-Received: by 2002:adf:f786:: with SMTP id q6mr3987549wrp.120.1589978663802; 
 Wed, 20 May 2020 05:44:23 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id q9sm2876323wmb.34.2020.05.20.05.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 05:44:23 -0700 (PDT)
Date: Wed, 20 May 2020 14:44:13 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH] perf/smmuv3: Allow sharing MMIO registers with the SMMU
 driver
Message-ID: <20200520124413.GA2512145@myrica>
References: <20200421155745.19815-1-jean-philippe@linaro.org>
 <20200520122453.GB25815@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200520122453.GB25815@willie-the-truck>
Cc: mark.rutland@arm.com, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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

On Wed, May 20, 2020 at 01:24:53PM +0100, Will Deacon wrote:
> On Tue, Apr 21, 2020 at 05:57:46PM +0200, Jean-Philippe Brucker wrote:
> > Some Arm SMMUv3 implementations, for example Arm CoreLink MMU-600, embed
> > the PMCG registers into the SMMU MMIO regions. It currently causes probe
> > failure because the PMU and SMMU drivers request overlapping resources.
> > 
> > Avoid the conflict by calling devm_ioremap() directly from the PMU
> > driver. We loose some sanity-checking of the memory map provided by
> > firmware, which doesn't seem catastrophic.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> > 
> > So this is the simplest solution, and I don't think we're missing much
> > by skipping the resource reservation. I've also been exploring a more
> > complex approach [1] which has the SMMU driver perform resource
> > reservation on behalf of the PMU driver, but I'm not sure it's
> > necessary.
> > 
> > Please test, I've only tried the RevC FastModel using devicetree so far.
> > 
> > [1] https://jpbrucker.net/git/linux/log/?h=smmu/pmu
> > ---
> >  drivers/perf/arm_smmuv3_pmu.c | 28 +++++++++++++++++++++-------
> >  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> Is this patch still needed? I can't quite follow from the discussion.

No, it is superseded by "[PATCH v2] iommu/arm-smmu-v3: Don't reserve
implementation defined register space" that you applied yesterday
(Thanks!)

Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
