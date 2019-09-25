Return-Path: <SRS0=izs0=XU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D852C432C1
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 08:35:41 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE7520872
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 08:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE7520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A6C5BC37;
	Wed, 25 Sep 2019 08:35:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id ABA65B43
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 08:35:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3D3C27C
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 08:35:30 +0000 (UTC)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
	[209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A276E11A23
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 08:35:29 +0000 (UTC)
Received: by mail-pf1-f198.google.com with SMTP id a2so3459943pfo.12
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 01:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=CBc45OeQcvvswm6VllW/DcLsxnRal5m6t5OBDsogK1c=;
	b=V1Bo01rvrNMi3nqBar0l/anE4+0582tzLgr1GiK5WmEJMR9zl4XncJcPe5szGtU4kv
	knP8UJ0thrzq4rLvPZU1zjr9cdltMHfAA6IbAFKZi5PQ8U9t64r86Ron69vQAgv/zJtL
	Cu5oSF8l8RXKCNT+FQWpe6JtYV+/bqjWAOcI20bh3hhPO+X+4Nrl0GpGnplFmsOq8/ST
	tDX6n/uo5+bHrStX06DXcKsATC8BDB/EhguedZJFqlEv3cIYE1wJ40WHD8CIvxqhUDuE
	oB8Fssjrb4ktPcz3Igd38x+TXozyVIlKfnzunfsANPofuGA9VfbVQtYOIb0rysuTJ3iR
	nT7w==
X-Gm-Message-State: APjAAAWhBx1BPqcBHPmFBVFLBD9kjKVmbpFO6s/z02mp5Ned1LsKSaFB
	1uSch2YrSd28C+9sxfVI9j7ivh/BZV3v5fmZvtEzaUJ25F+qpwdDmgjxS7vyGupWZtDGC7z4byp
	9OONANNPffrxhp0+lgV4htSzOL1dFFw==
X-Received: by 2002:a17:90a:a613:: with SMTP id
	c19mr5107218pjq.11.1569400529149; 
	Wed, 25 Sep 2019 01:35:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwTwI2GBx3mYJA7q4j7DwyuCNyNYODVb5K7FYMon6YtcWvF63UgXcbRm5MG2PYtVak+7eQfkA==
X-Received: by 2002:a17:90a:a613:: with SMTP id
	c19mr5107183pjq.11.1569400528844; 
	Wed, 25 Sep 2019 01:35:28 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
	by smtp.gmail.com with ESMTPSA id x6sm9264648pfd.53.2019.09.25.01.35.23
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 25 Sep 2019 01:35:27 -0700 (PDT)
Date: Wed, 25 Sep 2019 16:35:16 +0800
From: Peter Xu <peterx@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC PATCH 2/4] iommu/vt-d: Add first level page table interfaces
Message-ID: <20190925083516.GQ28074@xz-x1>
References: <20190923122454.9888-1-baolu.lu@linux.intel.com>
	<20190923122454.9888-3-baolu.lu@linux.intel.com>
	<20190923203102.GB21816@araj-mobl1.jf.intel.com>
	<9cfe6042-f0fb-ea5e-e134-f6f5bb9eb7b0@linux.intel.com>
	<20190925043050.GK28074@xz-x1>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D58F018@SHSMSX104.ccr.corp.intel.com>
	<20190925052402.GM28074@xz-x1>
	<1713f03c-4d47-34ad-f36d-882645c36389@linux.intel.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D58F4EA@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D58F4EA@SHSMSX104.ccr.corp.intel.com>
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

On Wed, Sep 25, 2019 at 07:32:48AM +0000, Tian, Kevin wrote:
> > From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> > Sent: Wednesday, September 25, 2019 2:52 PM
> > 
> > Hi Peter and Kevin,
> > 
> > On 9/25/19 1:24 PM, Peter Xu wrote:
> > > On Wed, Sep 25, 2019 at 04:38:31AM +0000, Tian, Kevin wrote:
> > >>> From: Peter Xu [mailto:peterx@redhat.com]
> > >>> Sent: Wednesday, September 25, 2019 12:31 PM
> > >>>
> > >>> On Tue, Sep 24, 2019 at 09:38:53AM +0800, Lu Baolu wrote:
> > >>>>>> intel_mmmap_range(domain, addr, end, phys_addr, prot)
> > >>>>>
> > >>>>> Maybe think of a different name..? mmmap seems a bit weird :-)
> > >>>>
> > >>>> Yes. I don't like it either. I've thought about it and haven't
> > >>>> figured out a satisfied one. Do you have any suggestions?
> > >>>
> > >>> How about at least split the word using "_"?  Like "mm_map", then
> > >>> apply it to all the "mmm*" prefixes.  Otherwise it'll be easily
> > >>> misread as mmap() which is totally irrelevant to this...
> > >>>
> > >>
> > >> what is the point of keeping 'mm' here? replace it with 'iommu'?
> > >
> > > I'm not sure of what Baolu thought, but to me "mm" makes sense itself
> > > to identify this from real IOMMU page tables (because IIUC these will
> > > be MMU page tables).  We can come up with better names, but IMHO
> > > "iommu" can be a bit misleading to let people refer to the 2nd level
> > > page table.
> > 
> > "mm" represents a CPU (first level) page table;
> > 
> > vs.
> > 
> > "io" represents an IOMMU (second level) page table.
> > 
> 
> IOMMU first level is not equivalent to CPU page table, though you can
> use the latter as the first level (e.g. in SVA). Especially here you are
> making IOVA->GPA as the first level, which is not CPU page table.
> 
> btw both levels are for "io" i.e. DMA purposes from VT-d p.o.v. They
> are just hierarchical structures implemented by VT-d, with slightly
> different format.

Regarding to the "slightly different format", do you mean the
extended-accessed bit?

Even if there are differences, they do look very similar.  If you see
the same chap 9.7 table, the elements are exactly called PTE, PDE,
PDPE, and so on - they're named exactly the same as MMU page tables.
With that, IMHO it still sounds reasonable if we want to relate this
"1st level iommu page table" with the existing MMU page table using
the "mm" prefix...

Regards,

-- 
Peter Xu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
