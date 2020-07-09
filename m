Return-Path: <SRS0=szPT=AU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CDAC433E0
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 21:50:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7876720774
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 21:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="npT9p+MK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7876720774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 35D9F2D0E9;
	Thu,  9 Jul 2020 21:50:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qNTlMD3i+ovx; Thu,  9 Jul 2020 21:50:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F0D1F26FB8;
	Thu,  9 Jul 2020 21:50:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8179C077B;
	Thu,  9 Jul 2020 21:50:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29DBAC016F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 21:50:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C5DF8883AF
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 21:49:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A0suAs7SesPb for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jul 2020 21:49:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0EA3588CD5
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 21:49:39 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id x9so1371116plr.2
 for <iommu@lists.linux-foundation.org>; Thu, 09 Jul 2020 14:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=hFr4sv4HqUSHsiMLFrScOT9Ngpz9Cto5b81cd6f0i7M=;
 b=npT9p+MKNUWXQYWnllvP0dSbLmAXzhuZ/YaLbF3/8MW4bc+uhAX1qaA89d9JVJxBR6
 PbUgRXSVwJZeFnp0E9X5JZoApnSJT0NfL23ffg22fwzr5sxzXEzHcL/uaMA6f5Ni2Acd
 zT37F2Hko+N8k9JdOa4Txvp0uVcibFkV+cndLptq13d8npFhI8UlM2fR2zoAjgawPoTi
 eTPoxLFxZ3n/VbBci5vXHlMUlSvVgr/66p04oUNOMaidVbaLVmcpnaoKHdWCcCCq+jkA
 qtaAbzyPWkqMl390vWaIOCRnfftDYD1rUZt8xxobcI7XIrplNI2Xvy5x6HaBo4NjhGMZ
 L3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=hFr4sv4HqUSHsiMLFrScOT9Ngpz9Cto5b81cd6f0i7M=;
 b=ehIWrmefu5WExAe9PjDrNw/uT++n8IJRB9UlXZUDIN+ZlwERUWDqZSYWYXVF7WIrQ7
 YnaTWLrcsmtTKxvFrsxKQKeoYIHi3VGa1aicPmuSkb9gu/qsuWsuX6gbxNgiFubaj39t
 b4PChNqalkollsY3lxCTiDbYyQk+8v3J6llZRTCWhruHy7iHdXsFdtLDvMNZXjt8NStT
 QhBug4I154knfX8d4cG3c97ZaVoJ2hD1o7c68kf5gvUgPeNe6Du/qiJBiS3aNqIsMpkI
 PEGiIuTOyEms0SXwxxNaE2z93natbBns+jxzOAbSaCmuf64XQqn7vYcg3Uwsp8ItMeeH
 sZhw==
X-Gm-Message-State: AOAM532Jo4q1GA7VHJlil+IdFa1CTpRJCY/i5y/V3Nlxr386BFrrfNhP
 V/0HwnQHnBH+i/+6n7L62Lhx/w==
X-Google-Smtp-Source: ABdhPJxifzME9k8oQf7I8/PrwyXLawsOmZkDIwApjP8xedu3YYKr6okgkKrdw3W2Hz9t2cE8c+Pk6Q==
X-Received: by 2002:a17:90b:3c1:: with SMTP id
 go1mr2110948pjb.129.1594331378329; 
 Thu, 09 Jul 2020 14:49:38 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667]
 ([2620:15c:17:3:4a0f:cfff:fe51:6667])
 by smtp.gmail.com with ESMTPSA id u74sm3454482pgc.58.2020.07.09.14.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 14:49:37 -0700 (PDT)
Date: Thu, 9 Jul 2020 14:49:37 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] dma-pool: use single atomic pool for both DMA zones
In-Reply-To: <20200708161010.GA30184@lst.de>
Message-ID: <alpine.DEB.2.23.453.2007091448550.972523@chino.kir.corp.google.com>
References: <20200707122804.21262-1-nsaenzjulienne@suse.de>
 <20200708153509.GA26743@lst.de>
 <e81db35628a22a0d1635699d1e87bacde706ad25.camel@suse.de>
 <20200708161010.GA30184@lst.de>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
 iommu@lists.linux-foundation.org, linux-rpi-kernel@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>
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
From: David Rientjes via iommu <iommu@lists.linux-foundation.org>
Reply-To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, 8 Jul 2020, Christoph Hellwig wrote:

> On Wed, Jul 08, 2020 at 06:00:35PM +0200, Nicolas Saenz Julienne wrote:
> > On Wed, 2020-07-08 at 17:35 +0200, Christoph Hellwig wrote:
> > > On Tue, Jul 07, 2020 at 02:28:04PM +0200, Nicolas Saenz Julienne wrote:
> > > > When allocating atomic DMA memory for a device, the dma-pool core
> > > > queries __dma_direct_optimal_gfp_mask() to check which atomic pool to
> > > > use. It turns out the GFP flag returned is only an optimistic guess.
> > > > The pool selected might sometimes live in a zone higher than the
> > > > device's view of memory.
> > > > 
> > > > As there isn't a way to grantee a mapping between a device's DMA
> > > > constraints and correct GFP flags this unifies both DMA atomic pools.
> > > > The resulting pool is allocated in the lower DMA zone available, if any,
> > > > so as for devices to always get accessible memory while having the
> > > > flexibility of using dma_pool_kernel for the non constrained ones.
> > > > 
> > > > Fixes: c84dc6e68a1d ("dma-pool: add additional coherent pools to map to gfp
> > > > mask")
> > > > Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> > > > Suggested-by: Robin Murphy <robin.murphy@arm.com>
> > > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > 
> > > Hmm, this is not what I expected from the previous thread.  I thought
> > > we'd just use one dma pool based on runtime available of the zones..
> > 
> > I may be misunderstanding you, but isn't that going back to how things used to
> > be before pulling in David Rientjes' work? The benefit of having a GFP_KERNEL
> > pool is that non-address-constrained devices can get their atomic memory there,
> > instead of consuming somewhat scarcer low memory.
> 
> Yes, I think we are misunderstanding each other.  I don't want to remove
> any pool, just make better runtime decisions when to use them.
> 

Just to be extra explicit for the record and for my own understanding: 
Nicolas, your patch series "dma-pool: Fix atomic pool selection" obsoletes 
this patch, right? :)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
