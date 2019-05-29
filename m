Return-Path: <SRS0=Uk+I=T5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD95C28CC0
	for <iommu@archiver.kernel.org>; Wed, 29 May 2019 16:24:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E329C23D28
	for <iommu@archiver.kernel.org>; Wed, 29 May 2019 16:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E329C23D28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9FD7F25A2;
	Wed, 29 May 2019 16:24:25 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E4CC72509
	for <iommu@lists.linux-foundation.org>;
	Wed, 29 May 2019 16:19:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6385E619
	for <iommu@lists.linux-foundation.org>;
	Wed, 29 May 2019 16:19:39 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	29 May 2019 09:19:39 -0700
X-ExtLoop1: 1
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
	by orsmga004.jf.intel.com with ESMTP; 29 May 2019 09:19:38 -0700
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
	ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Wed, 29 May 2019 09:19:38 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.116]) by
	ORSMSX112.amr.corp.intel.com ([169.254.3.79]) with mapi id
	14.03.0415.000; Wed, 29 May 2019 09:19:38 -0700
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH V3 0/3] Add debugfs support to show scalable mode DMAR
	table
Thread-Topic: [PATCH V3 0/3] Add debugfs support to show scalable mode DMAR
	table
Thread-Index: AQHVEopvhR0pc+uoWkCCoR484yi7/aZ/feaAgALRU9A=
Date: Wed, 29 May 2019 16:19:37 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F48D2F8A6@ORSMSX114.amr.corp.intel.com>
References: <cover.1558735674.git.sai.praneeth.prakhya@intel.com>
	<20190527141647.GG8420@8bytes.org>
In-Reply-To: <20190527141647.GG8420@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZGM3ZWQxMGQtNjQ5MC00MjU1LWE5MDAtZGY1MGQ1ZmRiNGEyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiXC9TcWVOWW9TNnNwSkJLcnVVY1ZDNHVmUVozTFByMWorYTZJdzc2TFdjUXZnblJwZlkzNjZCbWRONWpOQ3p1S2UifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Andy
	Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>
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

> > Changes from V2 to V3:
> > ----------------------
> > Presently, for V2 patches if kernel command line argument "iommu=pt"
> > is passed, dumping DMAR table seg faults. This happens because in pass
> > through mode (for non-scalable DMAR's) 3rd bit of context entry is set
> > and it is misinterpreted as PASID enabled by debugfs code and hence
> > tries to dereference PASID directory pointer which leads to seg fault
> > (PASID directory pointer is undefined for non-scalable DMAR's). To fix
> > this, dereference PASID directory pointer only when 1. PASID is
> > supported and 2. PASID is enabled.
> >
> > This patch is tested on
> > 1. Non-scalable DMAR with and without iommu=pt 2. Scalable DMAR with
> > and without iommu=pt
> 
> Sorry, missed this patch-set. Applied this one instead of V2.

Thanks! This is the right patch set. I have also checked IOMMU tree and it looks good :)

Regards,
Sai
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
