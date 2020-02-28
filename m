Return-Path: <SRS0=BxgK=4Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C130EC3F2CD
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 14:57:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 888A1246A0
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 14:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fx3F0RVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888A1246A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 58C39860F2;
	Fri, 28 Feb 2020 14:57:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BVN3N4Ufmm9J; Fri, 28 Feb 2020 14:57:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D9D3D85F9C;
	Fri, 28 Feb 2020 14:57:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9C98C08A0;
	Fri, 28 Feb 2020 14:57:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B767C0177
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 14:57:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 296792041A
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 14:57:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R6R6WsFv+1M0 for <iommu@lists.linux-foundation.org>;
 Fri, 28 Feb 2020 14:57:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
 [209.85.160.194])
 by silver.osuosl.org (Postfix) with ESMTPS id 4AD68203D9
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 14:57:21 +0000 (UTC)
Received: by mail-qt1-f194.google.com with SMTP id l21so2181260qtr.8
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 06:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=aXNQ0NABVZ/Zc8fXXYZpSz3dqh4Ns6QlhvK6/kwYM2k=;
 b=fx3F0RVJpvuGR0vU2fusOG/NqXxNQdLCppTq9XL99VJF79clWgcp5+agQ8Bkdn764W
 /6H4SP43zfEgHKiNsbn3EkZXEI5eftR/AZNv5GJYTZnxTXZRyq9aw7ICgIKMn8l0jnUx
 9LorGB67BgZ2aphSqsGjJO2u/nt3IEPqyy6blQp30BdEWnEUxTjjCoo7zwPmwtZJlkI3
 e+qGqpZDRkSLznZ8x2vUdH6CsaxJ2HRW27+fCzEtPp5EqdbjknklIN9PHhf1PYIBAg+F
 PuUEX6g64YI1DZfAu0ym87ZYgi2PkqOOc/+5zxlIRaH10PX0tdO8PBQJ2rqvbzBeuTgk
 IVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=aXNQ0NABVZ/Zc8fXXYZpSz3dqh4Ns6QlhvK6/kwYM2k=;
 b=iXI/DP9IFo/QqpiApcHJVxpE2eb8mSBxOZbO6u+h34ZzNjXwCZD7JtHguvoDbQzb0+
 Uz/9tUAKE8J+pQeYxj/gHGNVUJQXNybG1U1f6BbkyFGqpGPEMWdSYAGLx71GmGN3NTBs
 QCSnSB5SU2CBamAsgvGwIErBX+epXJ4PG5sKgaSstNd7ewXG10P2xFsrUyOnQq3J3QEh
 /30jr22qRffNmBI7HG1Wk2/TikiPR/gBute9jixXjKGki4WA95Gt5pE9JyuGBb5hALMX
 FAxfQGoN3ckqe4A76TYofImAz2gkL33MWZvMZUo+614MpVHNKAbLCjJ0BaJCIWIwKEIR
 NxjQ==
X-Gm-Message-State: APjAAAUtRi8qF9BSuYc9qQFlLamwIl7A7Ef5MsXUYhrHpUtGitiUrOsb
 HxATvUYdidi0KPPHf6HPYgL/VA==
X-Google-Smtp-Source: APXvYqxZGwk4KQ+YAY4GsyBgYKpbiHklk+KncMw+8qgpUr+ys9QfMTdjm4TizVQ6yPrtfGJb79x/jw==
X-Received: by 2002:ac8:2939:: with SMTP id y54mr4410279qty.109.1582901840269; 
 Fri, 28 Feb 2020 06:57:20 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id f7sm5133445qtj.92.2020.02.28.06.57.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 28 Feb 2020 06:57:19 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1j7h4p-00034R-0q; Fri, 28 Feb 2020 10:57:19 -0400
Date: Fri, 28 Feb 2020 10:57:19 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 02/26] iommu/sva: Manage process address spaces
Message-ID: <20200228145718.GR31668@ziepe.ca>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-3-jean-philippe@linaro.org>
 <20200226111320.3b6e6d3d@jacob-builder>
 <20200228144007.GB2156@myrica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200228144007.GB2156@myrica>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, kevin.tian@intel.com,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 linux-pci@vger.kernel.org, robin.murphy@arm.com, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, catalin.marinas@arm.com,
 zhangfei.gao@linaro.org, will@kernel.org, christian.koenig@amd.com,
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

On Fri, Feb 28, 2020 at 03:40:07PM +0100, Jean-Philippe Brucker wrote:
> > > Device
> > > + * 00:00.0 accesses address spaces X and Y, each corresponding to an
> > > mm_struct.
> > > + * Devices 00:01.* only access address space Y. In addition each
> > > + * IOMMU_DOMAIN_DMA domain has a private address space, io_pgtable,
> > > that is
> > > + * managed with iommu_map()/iommu_unmap(), and isn't shared with the
> > > CPU MMU.
> > So this would allow IOVA and SVA co-exist in the same address space?
> 
> Hmm, not in the same address space, but they can co-exist in a device. In
> fact the endpoint I'm testing (hisi zip accelerator) already needs normal
> DMA alongside SVA for queue management. This one is integrated on an
> Arm-based platform so shouldn't be a concern for VT-d at the moment, but
> I suspect we might see more of this kind of device with mixed DMA.

Probably the most interesting usecases for PASID definately require
this, so this is more than a "suspect we might see"

We want to see the privileged kernel control the general behavior of
the PCI function and delegate only some DMAs to PASIDs associated with
the user mm_struct. The device is always trusted the label its DMA
properly.

These programming models are already being used for years now with the
opencapi implementation.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
