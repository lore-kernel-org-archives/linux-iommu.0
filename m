Return-Path: <SRS0=izs0=XU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50D2C432C1
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 05:24:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2661217F4
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 05:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2661217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 76393B9E;
	Wed, 25 Sep 2019 05:24:25 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E58437F6
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 05:24:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8A5AE8A
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 05:24:15 +0000 (UTC)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
	[209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1B063882EA
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 05:24:15 +0000 (UTC)
Received: by mail-pl1-f198.google.com with SMTP id y13so1270454plr.17
	for <iommu@lists.linux-foundation.org>;
	Tue, 24 Sep 2019 22:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=/HNMfngrL2dVAv5oEf18q1bL4tnGnZHoARTtclw/zOQ=;
	b=ThkA3PaFiFrDqpN0fOKzd96oFy4RkN9OaedP3QN8Xf7kQFZR/Y0AGyjr0OYCAZnBDv
	YYdmrG8FfY0EVBYrPguOePEZ4tueaQfMJCzSGIXxCoEj9DAUmhFkwXjGpG62fMMnq5VO
	ePsweYwZG1paG1/N+On5Va5pOVfpQStycbVXn4qC41u9DoPE8XwFidjTs9KVdnJJfv63
	FdJABO27XI8m9XFGIq3V6iG3lys8G3NvvGoT/z8Ey2lFxsduGlU8jNOW/vZm3pMomrqO
	rcVdZMhnBXG0pbJmRJv2DXCzd1VW/7ANlseG4N0CZA+3TOWWyAl9fxkTLl20qcThJCCD
	0W2Q==
X-Gm-Message-State: APjAAAVA1WBVnhs1qhQPlB0vCaNkLGjCzU6t4VA+1YF0md4hNP4eM+gW
	pD2mP/N4t8Q3CQhjSmHTjWKHNDjh7/UIboV2OIfnGNSkInv/SM30G4svE8PlW7fut9XldJD0Iwc
	pjFx3X3y1b8kHWGPUpekUbWm8rNLUBA==
X-Received: by 2002:a62:5e42:: with SMTP id s63mr6745440pfb.96.1569389054616; 
	Tue, 24 Sep 2019 22:24:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxwAC3wXoJ2PHgPRN3g8rZaANg2eV6wPnk6cDT4cSKrtUcaQ5efDKrefQ8BuOVG39h90nRsFQ==
X-Received: by 2002:a62:5e42:: with SMTP id s63mr6745421pfb.96.1569389054455; 
	Tue, 24 Sep 2019 22:24:14 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80]) by smtp.gmail.com with ESMTPSA id
	d76sm9015810pga.80.2019.09.24.22.24.09
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 24 Sep 2019 22:24:13 -0700 (PDT)
Date: Wed, 25 Sep 2019 13:24:02 +0800
From: Peter Xu <peterx@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC PATCH 2/4] iommu/vt-d: Add first level page table interfaces
Message-ID: <20190925052402.GM28074@xz-x1>
References: <20190923122454.9888-1-baolu.lu@linux.intel.com>
	<20190923122454.9888-3-baolu.lu@linux.intel.com>
	<20190923203102.GB21816@araj-mobl1.jf.intel.com>
	<9cfe6042-f0fb-ea5e-e134-f6f5bb9eb7b0@linux.intel.com>
	<20190925043050.GK28074@xz-x1>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D58F018@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D58F018@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Yi Sun <yi.y.sun@linux.intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Kumar,
	Sanjay K" <sanjay.k.kumar@intel.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Sun, Yi Y" <yi.y.sun@intel.com>, David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Wed, Sep 25, 2019 at 04:38:31AM +0000, Tian, Kevin wrote:
> > From: Peter Xu [mailto:peterx@redhat.com]
> > Sent: Wednesday, September 25, 2019 12:31 PM
> > 
> > On Tue, Sep 24, 2019 at 09:38:53AM +0800, Lu Baolu wrote:
> > > > > intel_mmmap_range(domain, addr, end, phys_addr, prot)
> > > >
> > > > Maybe think of a different name..? mmmap seems a bit weird :-)
> > >
> > > Yes. I don't like it either. I've thought about it and haven't
> > > figured out a satisfied one. Do you have any suggestions?
> > 
> > How about at least split the word using "_"?  Like "mm_map", then
> > apply it to all the "mmm*" prefixes.  Otherwise it'll be easily
> > misread as mmap() which is totally irrelevant to this...
> > 
> 
> what is the point of keeping 'mm' here? replace it with 'iommu'?

I'm not sure of what Baolu thought, but to me "mm" makes sense itself
to identify this from real IOMMU page tables (because IIUC these will
be MMU page tables).  We can come up with better names, but IMHO
"iommu" can be a bit misleading to let people refer to the 2nd level
page table.

Regards,

-- 
Peter Xu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
