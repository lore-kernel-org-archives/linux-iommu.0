Return-Path: <SRS0=gbr8=VX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CC4C7618B
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 17:17:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3A021734
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 17:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3A021734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7E6F9E35;
	Fri, 26 Jul 2019 17:17:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 96D92D13
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 17:17:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 42FB48A7
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 17:17:23 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	26 Jul 2019 10:17:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; d="scan'208";a="189684198"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
	by fmsmga001.fm.intel.com with ESMTP; 26 Jul 2019 10:17:22 -0700
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
	ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Fri, 26 Jul 2019 10:17:22 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.96]) by
	ORSMSX112.amr.corp.intel.com ([169.254.3.253]) with mapi id
	14.03.0439.000; Fri, 26 Jul 2019 10:17:21 -0700
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, David
	Woodhouse <dwmw2@infradead.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Correctly check format of page table in
	debugfs
Thread-Topic: [PATCH 1/1] iommu/vt-d: Correctly check format of page table
	in debugfs
Thread-Index: AQHVPp8ipwYNQGhYs0KyxJ8SpXgi1qbWGSVggATyvwCAAiH/MA==
Date: Fri, 26 Jul 2019 17:17:20 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F4F975DF0@ORSMSX114.amr.corp.intel.com>
References: <20190720020126.9974-1-baolu.lu@linux.intel.com>
	<FFF73D592F13FD46B8700F0A279B802F4F9354AF@ORSMSX114.amr.corp.intel.com>
	<8d09da43-d0dd-9dff-0cb3-aa93448a7e60@linux.intel.com>
In-Reply-To: <8d09da43-d0dd-9dff-0cb3-aa93448a7e60@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzI0ZDYzYmMtMTU2OC00OWZiLWIyODQtMTYxNzRhNWUyYTg0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiOWJBaDI5dGtsQmgyMHg5K1QyRkZNVW9YNzkzNVdKXC9wMkhxRjZzQlBRcGhYZnZkWEowNEt4bStSb0hMYlRFajgifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"Pan, Jacob jun" <jacob.jun.pan@intel.com>
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

> On 7/22/19 1:21 PM, Prakhya, Sai Praneeth wrote:
> > Hi Allen,
> >
> >> diff --git a/drivers/iommu/intel-iommu-debugfs.c
> >> b/drivers/iommu/intel- iommu-debugfs.c index
> >> 73a552914455..e31c3b416351 100644
> >> --- a/drivers/iommu/intel-iommu-debugfs.c
> >> +++ b/drivers/iommu/intel-iommu-debugfs.c
> >> @@ -235,7 +235,7 @@ static void ctx_tbl_walk(struct seq_file *m,
> >> struct intel_iommu *iommu, u16 bus)
> >>   		tbl_wlk.ctx_entry = context;
> >>   		m->private = &tbl_wlk;
> >>
> >> -		if (pasid_supported(iommu) && is_pasid_enabled(context)) {
> >> +		if (dmar_readq(iommu->reg + DMAR_RTADDR_REG) &
> >> DMA_RTADDR_SMT) {
> >
> > Thanks for adding this, I do believe this is a good addition but I
> > also think that we might need "is_pasid_enabled()" as well. It checks if PASIDE
> bit in context entry is enabled or not.
> >
> > I am thinking that even though DMAR might be using scalable root and
> > context table, the entry itself should have PASIDE bit set. Did I miss something
> here?
> 
> No matter the PASIDE bit set or not, IOMMU always uses the scalable mode
> page table if scalable mode is enabled. If PASIDE is set, requests with PASID will
> be handled. Otherwise, requests with PASID will be blocked (but request without
> PASID will always be handled).
> 
> We are dumpling the page table of the IOMMU, so we only care about what
> page table format it is using. Do I understand it right>

Thanks! Baolu, for the explanation. Yes, it makes sense and I agree that we don't need the extra check for PASIDE bit.

I have tested this change on scalable/legacy DMAR's with/without iommu=pt and it works :)

Regards,
Sai
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
