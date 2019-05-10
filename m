Return-Path: <SRS0=MPmd=TK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE12C04A6B
	for <iommu@archiver.kernel.org>; Fri, 10 May 2019 06:50:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9C6217D6
	for <iommu@archiver.kernel.org>; Fri, 10 May 2019 06:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9C6217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A2FDFD3B;
	Fri, 10 May 2019 06:50:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 083D8CE5
	for <iommu@lists.linux-foundation.org>;
	Fri, 10 May 2019 06:50:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B671B1FB
	for <iommu@lists.linux-foundation.org>;
	Fri, 10 May 2019 06:50:10 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	09 May 2019 23:50:10 -0700
X-ExtLoop1: 1
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
	by orsmga003.jf.intel.com with ESMTP; 09 May 2019 23:50:10 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.50]) by
	ORSMSX107.amr.corp.intel.com ([169.254.1.17]) with mapi id
	14.03.0415.000; Thu, 9 May 2019 23:50:09 -0700
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "iommu@lists.linux-foundation.org"
	<iommu@lists.linux-foundation.org>
Subject: RE: [PATCH 3/3] iommu/vt-d: Add debugfs support to show scalable
	mode DMAR table internals
Thread-Topic: [PATCH 3/3] iommu/vt-d: Add debugfs support to show scalable
	mode DMAR table internals
Thread-Index: AQHVBty8EHQtwBS7EU6VQG5ewmv/AqZj6nvw
Date: Fri, 10 May 2019 06:50:09 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F48BEB2F1@ORSMSX114.amr.corp.intel.com>
References: <cover.1556762845.git.sai.praneeth.prakhya@intel.com>
	<79a765a7c29a9effb553360004b9b7d829096314.1556762845.git.sai.praneeth.prakhya@intel.com>
	<644e72f7-b450-b30b-b1eb-b697c1cca1cf@linux.intel.com>
In-Reply-To: <644e72f7-b450-b30b-b1eb-b697c1cca1cf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjNhNDM2MmItZDM1Zi00MjUyLWJjYjEtNzU1ZDY2ODk3ZWNkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRU9zR3JJY20wYURqeU5DUmZCYzZhQnRQZnZkdVMxNElnZDlpcEtSVUlRQjJPaWNFeHhVcXdaa2dnQU9hMTBQMCJ9
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

> >   static void ctx_tbl_walk(struct seq_file *m, struct intel_iommu *iommu, u16
> bus)
> >   {
> >   	struct context_entry *context;
> > -	u16 devfn;
> > +	u16 devfn, pasid_dir_size;
> > +	u64 pasid_dir_ptr;
> >
> >   	for (devfn = 0; devfn < 256; devfn++) {
> >   		struct tbl_walk tbl_wlk = {0};
> >
> > +		/*
> > +		 * Scalable mode root entry points to upper context table and
> > +		 * lower context table. Each scalable mode context table has
> > +		 * 128 context entries where as legacy mode context table has
> > +		 * 256 context entries. So for scalable mode, devfn > 127 is
> > +		 * invalid. But, iommu_context_addr() inherently handles this by
> 
> This comment is a bit misleading. :-)
> 
> devfn > 127 is also valid for scalable mode. The context entries for former 128
> devices are in the lower scalable-mode context-table, while the latter 128
> devices in upper scalable-mode context-table.
> This has been handled in iommu_context_addr(), so the caller don't need to
> worry about this.

Yes.. that makes sense. Will correct it in V2.

Regards,
Sai
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
