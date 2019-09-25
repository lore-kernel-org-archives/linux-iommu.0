Return-Path: <SRS0=izs0=XU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE3AC432C1
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 07:22:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB9FB222CC
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 07:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9FB222CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DFC8FBA4;
	Wed, 25 Sep 2019 07:22:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E0C2FB3E
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 07:22:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BE2658D
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 07:21:54 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	25 Sep 2019 00:21:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,547,1559545200"; d="scan'208";a="183169136"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
	by orsmga008.jf.intel.com with ESMTP; 25 Sep 2019 00:21:54 -0700
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
	FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Wed, 25 Sep 2019 00:21:53 -0700
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
	fmsmsx118.amr.corp.intel.com (10.18.116.18) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Wed, 25 Sep 2019 00:21:53 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.32]) by
	SHSMSX153.ccr.corp.intel.com ([169.254.12.235]) with mapi id
	14.03.0439.000; Wed, 25 Sep 2019 15:21:51 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Peter Xu <peterx@redhat.com>, Lu Baolu <baolu.lu@linux.intel.com>
Subject: RE: [RFC PATCH 0/4] Use 1st-level for DMA remapping in guest
Thread-Topic: [RFC PATCH 0/4] Use 1st-level for DMA remapping in guest
Thread-Index: AQHVcgo/pYehEUSjBUSa7tc1tTv1E6c5H56AgAAQYQCAATS/kIAAyIAAgABFVACAAIvPkA==
Date: Wed, 25 Sep 2019 07:21:51 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D58F4A3@SHSMSX104.ccr.corp.intel.com>
References: <20190923122454.9888-1-baolu.lu@linux.intel.com>
	<20190923122715.53de79d0@jacob-builder>
	<20190923202552.GA21816@araj-mobl1.jf.intel.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D58D1F1@SHSMSX104.ccr.corp.intel.com>
	<dfd9b7a2-5553-328a-08eb-16c8a3a2644e@linux.intel.com>
	<20190925065640.GO28074@xz-x1>
In-Reply-To: <20190925065640.GO28074@xz-x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNWZmNjcyZDAtZDI5YS00ODVhLWI4ZWItMDVlMDgyZDQwNzRlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMkNVbEFZR3BSQ0ZsNUZ0bW8xYTI0RXllYllTZVZRQ3VRZ29SeHh5YkpVTytKdkd5ODZISW9TeFpDMlFsVllWRiJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
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

> From: Peter Xu [mailto:peterx@redhat.com]
> Sent: Wednesday, September 25, 2019 2:57 PM
> 
> On Wed, Sep 25, 2019 at 10:48:32AM +0800, Lu Baolu wrote:
> > Hi Kevin,
> >
> > On 9/24/19 3:00 PM, Tian, Kevin wrote:
> > > > > >       '-----------'
> > > > > >       '-----------'
> > > > > >
> > > > > > This patch series only aims to achieve the first goal, a.k.a using
> > > first goal? then what are other goals? I didn't spot such information.
> > >
> >
> > The overall goal is to use IOMMU nested mode to avoid shadow page
> table
> > and VMEXIT when map an gIOVA. This includes below 4 steps (maybe not
> > accurate, but you could get the point.)
> >
> > 1) GIOVA mappings over 1st-level page table;
> > 2) binding vIOMMU 1st level page table to the pIOMMU;
> > 3) using pIOMMU second level for GPA->HPA translation;
> > 4) enable nested (a.k.a. dual stage) translation in host.
> >
> > This patch set aims to achieve 1).
> 
> Would it make sense to use 1st level even for bare-metal to replace
> the 2nd level?
> 
> What I'm thinking is the DPDK apps - they have MMU page table already
> there for the huge pages, then if they can use 1st level as the
> default device page table then it even does not need to map, because
> it can simply bind the process root page table pointer to the 1st
> level page root pointer of the device contexts that it uses.
> 

Then you need bear with possible page faults from using CPU page
table, while most devices don't support it today. 

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
