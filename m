Return-Path: <SRS0=MPmd=TK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A021C04A6B
	for <iommu@archiver.kernel.org>; Fri, 10 May 2019 06:46:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 597E5217D6
	for <iommu@archiver.kernel.org>; Fri, 10 May 2019 06:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597E5217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 13CFEC3F;
	Fri, 10 May 2019 06:46:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 27CF4BE7
	for <iommu@lists.linux-foundation.org>;
	Fri, 10 May 2019 06:46:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C75E31FB
	for <iommu@lists.linux-foundation.org>;
	Fri, 10 May 2019 06:46:24 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	09 May 2019 23:46:23 -0700
X-ExtLoop1: 1
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
	by fmsmga006.fm.intel.com with ESMTP; 09 May 2019 23:46:23 -0700
Received: from orsmsx123.amr.corp.intel.com (10.22.240.116) by
	ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Thu, 9 May 2019 23:46:22 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.50]) by
	ORSMSX123.amr.corp.intel.com ([169.254.1.141]) with mapi id
	14.03.0415.000; Thu, 9 May 2019 23:46:22 -0700
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "iommu@lists.linux-foundation.org"
	<iommu@lists.linux-foundation.org>
Subject: RE: [PATCH 0/3] Add debugfs support to show scalable mode DMAR table
Thread-Topic: [PATCH 0/3] Add debugfs support to show scalable mode DMAR table
Thread-Index: AQHVBtlNmWzCin5rpU2V9DOnJYfKn6Zj6gww
Date: Fri, 10 May 2019 06:46:22 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F48BEB2E1@ORSMSX114.amr.corp.intel.com>
References: <cover.1556762845.git.sai.praneeth.prakhya@intel.com>
	<fa685d9b-eab3-4411-0e1c-79a3fb4087fd@linux.intel.com>
In-Reply-To: <fa685d9b-eab3-4411-0e1c-79a3fb4087fd@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiY2YwMDU4MmMtMjk3NC00OWI4LWI3YzUtYTg4N2FjZDJmN2VjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZzU1Q0ZZemRHUk8rK2o0WThiK0RpZWc4UFBSUEpHaHNtYWdvMWZmQU1VaElJbzVUN1wvbVo1XC9sZ0dwcFBJTkNOIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Andy
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

> Hi Sai,
> 
> On 5/10/19 2:41 AM, Sai Praneeth Prakhya wrote:
> > From: Sai Praneeth <sai.praneeth.prakhya@intel.com>
> >
> > Presently, "/sys/kernel/debug/iommu/intel/dmar_translation_struct"
> > file dumps only legacy DMAR table which consists of root table and
> > context table. Scalable mode DMAR table adds PASID directory and PASID
> > table. Hence, add support to dump these tables as well.
> >
> > Directly extending the present dumping format for PASID tables will
> > make the output look clumsy. Hence, the first patch modifies the
> > present format to a tabular format. The second patch introduces macros
> > that are used during PASID table walk and the third patch actually
> > adds support to dump scalable mode DMAR table.
> >
> > Sai Praneeth (3):
> >    iommu/vt-d: Modify the format of intel DMAR tables dump
> >    iommu/vt-d: Introduce macros useful for dumping DMAR table
> >    iommu/vt-d: Add debugfs support to show scalable mode DMAR table
> >      internals
> 
> This patch set looks good to me in general. One minor suggestion is that the
> author name and signed-of-by name should be consistent for all patches.

Thanks for the suggestion. Sorry! that I missed it.
Will quickly send a V2 fixing it.

Regards,
Sai
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
