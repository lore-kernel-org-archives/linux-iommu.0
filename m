Return-Path: <SRS0=NBt+=KO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859CAC433ED
	for <iommu@archiver.kernel.org>; Wed, 19 May 2021 23:25:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD5B1611BD
	for <iommu@archiver.kernel.org>; Wed, 19 May 2021 23:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD5B1611BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 94B7A60605;
	Wed, 19 May 2021 23:25:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kZjSC5KiaaoW; Wed, 19 May 2021 23:25:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 76449605D1;
	Wed, 19 May 2021 23:25:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A4F0C000E;
	Wed, 19 May 2021 23:25:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BC91C0001
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 23:25:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D9B0740166
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 23:25:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lWyCy2SWdTRj for <iommu@lists.linux-foundation.org>;
 Wed, 19 May 2021 23:25:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 12194400D2
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 23:25:01 +0000 (UTC)
Received: by mail-qk1-x729.google.com with SMTP id 82so3117509qki.8
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 16:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=jofypBmuNK78helxp/ax3lvvaD1SSYgX9AHCXeb2JyI=;
 b=N+FIikMxArUHq1byG1kV6q6NKiH1yzdaJ73QnFvU7gnei0NcXatMYjDQ/ysJWeBJUz
 HU+0NNBklt3GiG1WqihmEZDLgrsaMez/pjd1gK+nq1yfEAl4wKARzYJcQ9YvICi1PbfJ
 YmKCfYOaNFRsx04nfwkEcco4XkSA5EJzUpFfr7AW5h4ojV2pmxtrP0yLMHPB89Npr6MC
 cYvKGOLX7tUJB9fr5WHNwIUnrPHLmMT3XH1oZkYwxMdMuAS8LI+qL0xR0NfXu2XozXzX
 mnVR8EYQcltbwycZy/8FNlwePUV7aMDd/SY0pRucP8XY2ZQWC41lv4cyNLN79dAK3X8D
 3g1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jofypBmuNK78helxp/ax3lvvaD1SSYgX9AHCXeb2JyI=;
 b=MRXVWiFNDKn0lJgCRUPsFvd/ksbPNDRv6vv5ogcCKQ8wJsEOJ6umtQYJLbn6YeBPi2
 vSIzMPhUR8KMrj9pWLM4FznhEzQhdEjVPK1WFq7YfNTojFyG/wilTuqB99O/FKqDzBWA
 87cVRL9m6ZgZ5SsaZLktlwi3T3aIH64opAnAEc+B5/LfDciokqPyqBAvmARfQQgkfDe4
 3pk47bHfPTEakAod0F3wjrkP9++dD34wGdWscTUq8Y//38W5jTX3NRBRk90G8/uCGj7c
 aPj48IKplg2eCw6P3HbYmgReytnm7rBLgVB1j6x5jl1rXh1tFzcUv1QV8ZvILoWzzM99
 v0qw==
X-Gm-Message-State: AOAM532wgwk/ZifAOPl+2TPait4KQ74XJ/6zTLMkXkKKsqB+UFUb5UXB
 8bs2Cps6D9LPkFWvO8ujDXTcfA==
X-Google-Smtp-Source: ABdhPJwacQNrdgaaDkGD5jqXNtEa9dtPcTdGRZpUC1+HOzqirLQtKg5p7syqrmkzIKN+BpViLEFW6Q==
X-Received: by 2002:a05:620a:21c5:: with SMTP id
 h5mr1932597qka.395.1621466700858; 
 Wed, 19 May 2021 16:25:00 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [47.55.113.94])
 by smtp.gmail.com with ESMTPSA id u186sm918257qkd.30.2021.05.19.16.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 May 2021 16:25:00 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1ljVYh-00AxO2-BM; Wed, 19 May 2021 20:24:59 -0300
Date: Wed, 19 May 2021 20:24:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH 3/6] vfio: remove the unused mdev iommu hook
Message-ID: <20210519232459.GV1096940@ziepe.ca>
References: <MWHPR11MB18866205125E566FE05867A78C509@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210514133143.GK1096940@ziepe.ca> <YKJf7mphTHZoi7Qr@8bytes.org>
 <20210517123010.GO1096940@ziepe.ca> <YKJnPGonR+d8rbu/@8bytes.org>
 <20210517133500.GP1096940@ziepe.ca> <YKKNLrdQ4QjhLrKX@8bytes.org>
 <131327e3-5066-7a88-5b3c-07013585eb01@arm.com>
 <20210519180635.GT1096940@ziepe.ca>
 <MWHPR11MB1886C64EAEB752DE9E1633358C2B9@MWHPR11MB1886.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886C64EAEB752DE9E1633358C2B9@MWHPR11MB1886.namprd11.prod.outlook.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Christoph Hellwig <hch@lst.de>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On Wed, May 19, 2021 at 11:12:46PM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Thursday, May 20, 2021 2:07 AM
> > 
> > On Wed, May 19, 2021 at 04:23:21PM +0100, Robin Murphy wrote:
> > > On 2021-05-17 16:35, Joerg Roedel wrote:
> > > > On Mon, May 17, 2021 at 10:35:00AM -0300, Jason Gunthorpe wrote:
> > > > > Well, I'm sorry, but there is a huge other thread talking about the
> > > > > IOASID design in great detail and why this is all needed. Jumping into
> > > > > this thread without context and basically rejecting all the
> > > > > conclusions that were reached over the last several weeks is really
> > > > > not helpful - especially since your objection is not technical.
> > > > >
> > > > > I think you should wait for Intel to put together the /dev/ioasid uAPI
> > > > > proposal and the example use cases it should address then you can give
> > > > > feedback there, with proper context.
> > > >
> > > > Yes, I think the next step is that someone who read the whole thread
> > > > writes up the conclusions and a rough /dev/ioasid API proposal, also
> > > > mentioning the use-cases it addresses. Based on that we can discuss the
> > > > implications this needs to have for IOMMU-API and code.
> > > >
> > > >  From the use-cases I know the mdev concept is just fine. But if there is
> > > > a more generic one we can talk about it.
> > >
> > > Just to add another voice here, I have some colleagues working on drivers
> > > where they want to use SMMU Substream IDs for a single hardware block
> > to
> > > operate on multiple iommu_domains managed entirely within the
> > > kernel.
> > 
> > If it is entirely within the kernel I'm confused how mdev gets
> > involved? mdev is only for vfio which is userspace.
> > 
> 
> Just add some background. aux domain is used to support mdev but they
> are not tied together. Literally aux domain just implies that there could be 
> multiple domains attached to a device then when one of them becomes
> the primary all the remaining are deemed as auxiliary. From this angle it
> doesn't matter whether the requirement of multiple domains come from
> user or kernel.

You can't entirely use aux domain from inside the kernel because you
can't compose it with the DMA API unless you also attach it to some
struct device, and where will the struct device come from?

We already talked about this on the "how to use PASID from the kernel"
thread.

If Robin just wants to use a stream ID from a kernel driver then that
API to make a PASID == RID seems like a better answer for kernel DMA
than aux domains is.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
