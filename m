Return-Path: <SRS0=izs0=XU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04332C432C1
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 07:45:32 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8CEE2054F
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 07:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CEE2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A9D88BB3;
	Wed, 25 Sep 2019 07:45:31 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 11631B9E
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 07:45:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EBCC28A0
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 07:45:20 +0000 (UTC)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
	[209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 61D6C80F91
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 07:45:20 +0000 (UTC)
Received: by mail-pf1-f198.google.com with SMTP id v6so3390200pfm.1
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 00:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=lGlfVebe14dEyAwlNX/fOfUXOsimPZPypK8xTf2N4Zk=;
	b=ZeD10WSUsiy2wd2j7XCu9Xm6NGhgYNJvG2qRFSnOwsn6tRxTBd3c/KkbDG3HiBY0cS
	1EcQHUuu9J5pf0J1aufmjZ3Vwvkdu6AMyHfl/6wwyKYHFhSllYa8Yq4WB9UT1XKHf+kM
	cSyF78BBbkpiSDUH5h6QcBXPWFMfaO/TCWd22LZjO5vQQAuRwiAiu+WyivP8mOlRLIBl
	hbT0ZYMkGl8sDG5bn0+ilpRrB2QZvAgUg2j7pE3ltnRB1eADCMmn4y9eHB5xJw6u1DnR
	I1uhLoIj1qhyQD8Oo0t3aZe0+G76d2yyeA75RMjVieF/9WvjgMW0bItI0/xGNmEdBs9b
	jhsQ==
X-Gm-Message-State: APjAAAVsRyB6tiV/ypfd7XDg7N2KHgL7aETZOqia2/mK/7FFQxJOVNAk
	gPLT+mp5nivCJCJ0MDAi/PJqSEmKx+f0eitUrI4+nBRKoqXGOJMPJk+j3P9DtJTKwLw2KpqYKTj
	abNqGbxtFRjoaOzWyu1CoZPO36yVLvQ==
X-Received: by 2002:a17:902:7c94:: with SMTP id
	y20mr7255439pll.229.1569397519932; 
	Wed, 25 Sep 2019 00:45:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwCHx/3JAR/6+/InK/am42O9UXzLwb84IAvlRe5LPMfo5VvBXJdpQbI+cKfEX19uVulZcYtcw==
X-Received: by 2002:a17:902:7c94:: with SMTP id
	y20mr7255402pll.229.1569397519622; 
	Wed, 25 Sep 2019 00:45:19 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80]) by smtp.gmail.com with ESMTPSA id
	p17sm5670841pfn.50.2019.09.25.00.45.14
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 25 Sep 2019 00:45:18 -0700 (PDT)
Date: Wed, 25 Sep 2019 15:45:07 +0800
From: Peter Xu <peterx@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC PATCH 0/4] Use 1st-level for DMA remapping in guest
Message-ID: <20190925074507.GP28074@xz-x1>
References: <20190923122454.9888-1-baolu.lu@linux.intel.com>
	<20190923122715.53de79d0@jacob-builder>
	<20190923202552.GA21816@araj-mobl1.jf.intel.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D58D1F1@SHSMSX104.ccr.corp.intel.com>
	<dfd9b7a2-5553-328a-08eb-16c8a3a2644e@linux.intel.com>
	<20190925065640.GO28074@xz-x1>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D58F4A3@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D58F4A3@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Cc: Alex Williamson <alex.williamson@redhat.com>, "Raj,
	Ashok" <ashok.raj@intel.com>,
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

On Wed, Sep 25, 2019 at 07:21:51AM +0000, Tian, Kevin wrote:
> > From: Peter Xu [mailto:peterx@redhat.com]
> > Sent: Wednesday, September 25, 2019 2:57 PM
> > 
> > On Wed, Sep 25, 2019 at 10:48:32AM +0800, Lu Baolu wrote:
> > > Hi Kevin,
> > >
> > > On 9/24/19 3:00 PM, Tian, Kevin wrote:
> > > > > > >       '-----------'
> > > > > > >       '-----------'
> > > > > > >
> > > > > > > This patch series only aims to achieve the first goal, a.k.a using
> > > > first goal? then what are other goals? I didn't spot such information.
> > > >
> > >
> > > The overall goal is to use IOMMU nested mode to avoid shadow page
> > table
> > > and VMEXIT when map an gIOVA. This includes below 4 steps (maybe not
> > > accurate, but you could get the point.)
> > >
> > > 1) GIOVA mappings over 1st-level page table;
> > > 2) binding vIOMMU 1st level page table to the pIOMMU;
> > > 3) using pIOMMU second level for GPA->HPA translation;
> > > 4) enable nested (a.k.a. dual stage) translation in host.
> > >
> > > This patch set aims to achieve 1).
> > 
> > Would it make sense to use 1st level even for bare-metal to replace
> > the 2nd level?
> > 
> > What I'm thinking is the DPDK apps - they have MMU page table already
> > there for the huge pages, then if they can use 1st level as the
> > default device page table then it even does not need to map, because
> > it can simply bind the process root page table pointer to the 1st
> > level page root pointer of the device contexts that it uses.
> > 
> 
> Then you need bear with possible page faults from using CPU page
> table, while most devices don't support it today. 

Right, I was just thinking aloud.  After all neither do we have IOMMU
hardware to support 1st level (or am I wrong?)...  It's just that when
the 1st level is ready it should sound doable because IIUC PRI should
be always with the 1st level support no matter on IOMMU side or the
device side?

I'm actually not sure about whether my understanding here is
correct... I thought the pasid binding previously was only for some
vendor kernel drivers but not a general thing to userspace.  I feel
like that should be doable in the future once we've got some new
syscall interface ready to deliver 1st level page table (e.g., via
vfio?) then applications like DPDK seems to be able to use that too
even directly via bare metal.

Regards,

-- 
Peter Xu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
