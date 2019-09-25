Return-Path: <SRS0=izs0=XU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1A2C432C1
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 07:33:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E162217F4
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 07:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E162217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 43365B43;
	Wed, 25 Sep 2019 07:33:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BF6BBAF3
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 07:33:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A62F08A0
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 07:32:52 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	25 Sep 2019 00:32:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,547,1559545200"; d="scan'208";a="364246016"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
	by orsmga005.jf.intel.com with ESMTP; 25 Sep 2019 00:32:51 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
	FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Wed, 25 Sep 2019 00:32:51 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.32]) by
	SHSMSX103.ccr.corp.intel.com ([169.254.4.140]) with mapi id
	14.03.0439.000; Wed, 25 Sep 2019 15:32:49 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Peter Xu <peterx@redhat.com>
Subject: RE: [RFC PATCH 2/4] iommu/vt-d: Add first level page table interfaces
Thread-Topic: [RFC PATCH 2/4] iommu/vt-d: Add first level page table interfaces
Thread-Index: AQHVcgpDf16VDDZMQk6x5RWfK5mI2qc5MXAAgABWBICAAcJfAIAAh6Ig//+HOwCAABizAIAAjr3w
Date: Wed, 25 Sep 2019 07:32:48 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D58F4EA@SHSMSX104.ccr.corp.intel.com>
References: <20190923122454.9888-1-baolu.lu@linux.intel.com>
	<20190923122454.9888-3-baolu.lu@linux.intel.com>
	<20190923203102.GB21816@araj-mobl1.jf.intel.com>
	<9cfe6042-f0fb-ea5e-e134-f6f5bb9eb7b0@linux.intel.com>
	<20190925043050.GK28074@xz-x1>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D58F018@SHSMSX104.ccr.corp.intel.com>
	<20190925052402.GM28074@xz-x1>
	<1713f03c-4d47-34ad-f36d-882645c36389@linux.intel.com>
In-Reply-To: <1713f03c-4d47-34ad-f36d-882645c36389@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiY2U4YmU0ZmUtZDYzZS00ZjE4LWExZjctMTJkMzE0OTI5ZWIwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQjAzc0c5Y3ZcL01KUnQ3QmQyR2hyUUdDVkVaY3J4TEUzcGJTZjZoYzM4MDdzcGVnXC9Kcm5MZ1RYbXNHcDZGNGVuIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
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

> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> Sent: Wednesday, September 25, 2019 2:52 PM
> 
> Hi Peter and Kevin,
> 
> On 9/25/19 1:24 PM, Peter Xu wrote:
> > On Wed, Sep 25, 2019 at 04:38:31AM +0000, Tian, Kevin wrote:
> >>> From: Peter Xu [mailto:peterx@redhat.com]
> >>> Sent: Wednesday, September 25, 2019 12:31 PM
> >>>
> >>> On Tue, Sep 24, 2019 at 09:38:53AM +0800, Lu Baolu wrote:
> >>>>>> intel_mmmap_range(domain, addr, end, phys_addr, prot)
> >>>>>
> >>>>> Maybe think of a different name..? mmmap seems a bit weird :-)
> >>>>
> >>>> Yes. I don't like it either. I've thought about it and haven't
> >>>> figured out a satisfied one. Do you have any suggestions?
> >>>
> >>> How about at least split the word using "_"?  Like "mm_map", then
> >>> apply it to all the "mmm*" prefixes.  Otherwise it'll be easily
> >>> misread as mmap() which is totally irrelevant to this...
> >>>
> >>
> >> what is the point of keeping 'mm' here? replace it with 'iommu'?
> >
> > I'm not sure of what Baolu thought, but to me "mm" makes sense itself
> > to identify this from real IOMMU page tables (because IIUC these will
> > be MMU page tables).  We can come up with better names, but IMHO
> > "iommu" can be a bit misleading to let people refer to the 2nd level
> > page table.
> 
> "mm" represents a CPU (first level) page table;
> 
> vs.
> 
> "io" represents an IOMMU (second level) page table.
> 

IOMMU first level is not equivalent to CPU page table, though you can
use the latter as the first level (e.g. in SVA). Especially here you are
making IOVA->GPA as the first level, which is not CPU page table.

btw both levels are for "io" i.e. DMA purposes from VT-d p.o.v. They
are just hierarchical structures implemented by VT-d, with slightly
different format. The specification doesn't limit how you use them for.
In a hypothetical case, an IOMMU may implement exactly same CPU-page-
table format and support page faults for both levels. Then you can even
link the CPU page table to the 2nd level for sure.

Maybe we just name it from VT-d context, e.g. intel_map_first_level_range,
Intel_map_second_level_range, and then register them as dmar domain
callback as you replied in another mail.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
