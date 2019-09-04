Return-Path: <SRS0=42j6=W7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE36EC3A5A9
	for <iommu@archiver.kernel.org>; Wed,  4 Sep 2019 16:19:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F902053B
	for <iommu@archiver.kernel.org>; Wed,  4 Sep 2019 16:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F902053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 52A141974;
	Wed,  4 Sep 2019 16:19:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 075A7F74
	for <iommu@lists.linux-foundation.org>;
	Wed,  4 Sep 2019 16:18:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B0A517DB
	for <iommu@lists.linux-foundation.org>;
	Wed,  4 Sep 2019 16:18:25 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	04 Sep 2019 09:18:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; d="scan'208";a="190217980"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
	by FMSMGA003.fm.intel.com with ESMTP; 04 Sep 2019 09:18:24 -0700
Received: from orsmsx115.amr.corp.intel.com (10.22.240.11) by
	ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Wed, 4 Sep 2019 09:18:24 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.225]) by
	ORSMSX115.amr.corp.intel.com ([169.254.4.103]) with mapi id
	14.03.0439.000; Wed, 4 Sep 2019 09:18:24 -0700
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH 3/4] iommu: Add support to change default domain of an
	iommu_group
Thread-Topic: [PATCH 3/4] iommu: Add support to change default domain of an
	iommu_group
Thread-Index: AQHVV8qWE2w4hNV0n0iqYRgWzGAzZacacisAgABxZ7CAAIDWAIAAZDyw
Date: Wed, 4 Sep 2019 16:18:23 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F4FBF7E4B@ORSMSX114.amr.corp.intel.com>
References: <cover.1566353521.git.sai.praneeth.prakhya@intel.com>
	<03cbec8c95b13d417dd1c44f545241d01e7b9654.1566353521.git.sai.praneeth.prakhya@intel.com>
	<20190903125046.GA11530@8bytes.org>
	<FFF73D592F13FD46B8700F0A279B802F4FBECD3E@ORSMSX114.amr.corp.intel.com>
	<a8dff600-b945-6357-f17e-ea46aaa67077@linux.intel.com>
In-Reply-To: <a8dff600-b945-6357-f17e-ea46aaa67077@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTk3OGE2MjItMzVlNi00N2Y2LTk2ZjYtN2QxYzFlYThiYmQ4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSlZveGFpN1JcL3JoMEdLVEMzb2hyWFwvc0ozXC9qZnV2TytFb0hMSXZHSGdiODRyblwvOVJRRjM5SWJXODliWHZhU00ifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

> >>> +free_prev_domain:
> >>> +	/*
> >>> +	 * Free the existing default domain and replace it with the newly
> >>> +	 * created default domain. No need to set group->domain because
> >>> +	 * __iommu_attach_group() already does it on success.
> >>> +	 */
> >>> +	iommu_domain_free(prev_domain);
> >>> +	group->default_domain = new_domain;
> >>> +	return 0;
> >>
> >> It isn't obvious to me from this patch, how to are the dma_ops
> >> updated when the default domain changes between identity and dma?
> >
> > Thanks for raising this.
> > For intel_iommu, dma_map_ops is defined at drivers/iommu/intel-iommu.c
> > and all the callbacks like alloc(), map_sg() and map_page(), check if
> > the device needs DMA mapping or not by calling iommu_need_mapping(). The
> callbacks inherently do the right thing based on the outcome.
> > So, essentially the dma_ops are same for dma/identity domain.
> 
> This isn't always true as we are considering per-device dma ops.

Ahh.. I see. I wasn't aware that per-device dma ops might change this.
Thanks for letting me know. I will take this into consideration as well for V2.

Regards,
Sai
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
