Return-Path: <SRS0=izs0=XU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4213DC432C1
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 04:38:45 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C0D720665
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 04:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0D720665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B4D04B50;
	Wed, 25 Sep 2019 04:38:44 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 91D878BF
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 04:38:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 36F1D8A
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 04:38:35 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	24 Sep 2019 21:38:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,546,1559545200"; d="scan'208";a="218860750"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
	by fmsmga002.fm.intel.com with ESMTP; 24 Sep 2019 21:38:34 -0700
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
	fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Tue, 24 Sep 2019 21:38:34 -0700
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
	fmsmsx120.amr.corp.intel.com (10.18.124.208) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Tue, 24 Sep 2019 21:38:33 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.32]) by
	SHSMSX105.ccr.corp.intel.com ([169.254.11.23]) with mapi id
	14.03.0439.000; Wed, 25 Sep 2019 12:38:32 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Peter Xu <peterx@redhat.com>, Lu Baolu <baolu.lu@linux.intel.com>
Subject: RE: [RFC PATCH 2/4] iommu/vt-d: Add first level page table interfaces
Thread-Topic: [RFC PATCH 2/4] iommu/vt-d: Add first level page table interfaces
Thread-Index: AQHVcgpDf16VDDZMQk6x5RWfK5mI2qc5MXAAgABWBICAAcJfAIAAh6Ig
Date: Wed, 25 Sep 2019 04:38:31 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D58F018@SHSMSX104.ccr.corp.intel.com>
References: <20190923122454.9888-1-baolu.lu@linux.intel.com>
	<20190923122454.9888-3-baolu.lu@linux.intel.com>
	<20190923203102.GB21816@araj-mobl1.jf.intel.com>
	<9cfe6042-f0fb-ea5e-e134-f6f5bb9eb7b0@linux.intel.com>
	<20190925043050.GK28074@xz-x1>
In-Reply-To: <20190925043050.GK28074@xz-x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzQ2YjFmYTQtN2U3ZS00MGI3LThiZjAtMTllNDY5ZWQ3NDk4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicDZcL3hYOGtZT3JCSEMzcERMQ3VHWnlLM09aRlZXS1BhM3dmbE14MmxrY2xBYzZcL3hKeHBEYjRUeEtXbGE2Q29wIn0=
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

> From: Peter Xu [mailto:peterx@redhat.com]
> Sent: Wednesday, September 25, 2019 12:31 PM
> 
> On Tue, Sep 24, 2019 at 09:38:53AM +0800, Lu Baolu wrote:
> > > > intel_mmmap_range(domain, addr, end, phys_addr, prot)
> > >
> > > Maybe think of a different name..? mmmap seems a bit weird :-)
> >
> > Yes. I don't like it either. I've thought about it and haven't
> > figured out a satisfied one. Do you have any suggestions?
> 
> How about at least split the word using "_"?  Like "mm_map", then
> apply it to all the "mmm*" prefixes.  Otherwise it'll be easily
> misread as mmap() which is totally irrelevant to this...
> 

what is the point of keeping 'mm' here? replace it with 'iommu'?

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
