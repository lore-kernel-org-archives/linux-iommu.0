Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5837DC433DF
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 13:17:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B8092070C
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 13:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="PgKUoXJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8092070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D8A05888DA;
	Mon,  6 Jul 2020 13:17:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wCUBGR4v9JNB; Mon,  6 Jul 2020 13:17:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CDD77888D0;
	Mon,  6 Jul 2020 13:17:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3B28C0893;
	Mon,  6 Jul 2020 13:17:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B28AC016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 13:17:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7895488B3D
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 13:17:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Su0opPvTlmLM for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 13:17:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8A00288874
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 13:17:09 +0000 (UTC)
IronPort-SDR: sRioZpMg5dzEo2A94cYjWV1NbnYGO+OM160vR9zk8TyWXLCcJlK5nfaA6bk8icG+wuAcdJei+9
 m2gi6KeELkjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="232260114"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; d="scan'208";a="232260114"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 06:17:09 -0700
IronPort-SDR: HSYZbkTYNzvbnHRMrkSbA1lrcoARCfPEw45YwWrwyXIL558POjBmtwxahtF9FAY7sC2Qrldy7R
 CFUWDoq6oPaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; d="scan'208";a="283034653"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
 by orsmga006.jf.intel.com with ESMTP; 06 Jul 2020 06:17:08 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Jul 2020 06:17:08 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX111.amr.corp.intel.com (10.22.240.12) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Jul 2020 06:17:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Jul 2020 06:17:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbKD/sC8HiVM0sj+gA1EP6N6iMTfUWaTLRn+kfAu+3WGHSgwsiFIBLI4+SVaTBK77z6BaePwYxmN+LG2XzBQ+VHCp3kDWM8fSpaTblsMFUa1i0VbYKAUfmpHJpnoAT69gBAoyCkzda/OYOBGWkiQc/7YaiNW15Nd+hyFpmpmYEP83qLyQHzGuwkZtsT8i4GyYtVW2WXgCCRok2JjHcCxvPTRgqJK8risd0BBt1wLPRrUoYNZXnJHOTnR/adm32jdLbZcljqlGXT3KpZ9QqiUWtQKMdLHueq/fXzHm5liZqqky5kTN4qN9kabAqL1VHsEX0eRe4pNKnL4Uw645a7c9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyhqMkw+14CKz0MVrNIJyT7ZwzcY4nEQ6EfqL/E9Iok=;
 b=gketOvCEEuzgrmDUNd2FDlqUaM1eQMWV/yCYuWK+4w3QCB5jvFgrPeKqyExeHznnHVgocvOKMogUreScKvu/B0qvwKLKavpI+TcfMb1G3/tCBMI1vtfUP3uBRbLYgEvqrZOr5gukzwOPqgLljk8U6cQRZEW5LFfCBb1py3SgkViivBno6ts3cYG3qSkQmopgp7eFZOg7u11bez31TwkRzC3RoRLCQuF4gfmah8p5Fd3cWeYt59YYhN/6omksiRM1PYPHeMFjJRXCrgBSYFp6fqiLuR4viAk0YF4pK1uXv08CC2hvn0wyFv/B2wber7vstiLrFJZEy1mL7Dc6yp6H1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyhqMkw+14CKz0MVrNIJyT7ZwzcY4nEQ6EfqL/E9Iok=;
 b=PgKUoXJqTWH3A5THSz/IkgByOyE1+oUt15LQXe5w/UAJltQ397TWR49U45+meo4yJF/dbtfIQrICObw+EDg4Ndc+gYP96urorWRdZ9Sbp754mvze0VV/EdkQJcP9nz2AGdqj88ZXV3YxR/306jWUFPItXViK+vehlhtuKF96Fk8=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM5PR11MB0027.namprd11.prod.outlook.com (2603:10b6:4:6b::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20; Mon, 6 Jul 2020 13:17:05 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 13:17:05 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v4 02/15] iommu: Report domain nesting info
Thread-Topic: [PATCH v4 02/15] iommu: Report domain nesting info
Thread-Index: AQHWUfUZPmXy4q2mvk6wmPCF23Zkz6j6TVgAgAArcYCAAA43AIAAA19A
Date: Mon, 6 Jul 2020 13:17:05 +0000
Message-ID: <DM5PR11MB1435362511CAADBDBF6CCF7FC3690@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1593861989-35920-1-git-send-email-yi.l.liu@intel.com>
 <1593861989-35920-3-git-send-email-yi.l.liu@intel.com>
 <b9479f61-7f9e-e0ae-5125-ab15f59b1ece@redhat.com>
 <DM5PR11MB14352CBCB1966C0B9E418C7CC3690@DM5PR11MB1435.namprd11.prod.outlook.com>
 <b1d361f3-b0ca-7fef-ba31-1bdcdadea96f@redhat.com>
In-Reply-To: <b1d361f3-b0ca-7fef-ba31-1bdcdadea96f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afbd4a37-59d3-4908-0eb6-08d821aee100
x-ms-traffictypediagnostic: DM5PR11MB0027:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB0027C8BC0262D614EBB59063C3690@DM5PR11MB0027.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XAyPENPZTixedPWaPi2orHBjJvPbpyqcx6OhHW/F4PP2URwjlCmWfvJ1rJ7eRKh576YcmWUIiEFMsBGfUDTEK+uqqQcwn30cruCGAC3qEhLvwp/4zR5C20G3Bn/Qx4cVAmNN4pm0KCRLTP4SpytlSEJkK4U8cE81R/ecSvUiY70jAsSVe7J/6d1VWGjGhg3fEAyPk528h56hhI4r4RxnvGYyYEHppBASh4o89wEHlg3HYnTKjmQob3I3xp5SxAcjMRWcbkLubCBmudF+yWJRMaQlewL0fRebPDGV1lMsj091aCh0jKk5SesVfPJqYjN5U3eIMnlIY/xFnyV40DVBQOZlFONnjBaGEDo/b/m7VY6gXfhrueCxy+QTAxa05N4W8xQU670huWmoXbHtF/t6Rw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(66946007)(9686003)(64756008)(66556008)(66476007)(66446008)(4326008)(26005)(186003)(71200400001)(7416002)(8676002)(55016002)(83380400001)(966005)(478600001)(45080400002)(52536014)(86362001)(110136005)(5660300002)(33656002)(53546011)(6506007)(54906003)(8936002)(316002)(2906002)(7696005)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: fzhBaoqBZuJLoNQLItCJQkhEDbnCIrzJBxWUvaF9k2JHFHShMLcyEFKKjVP+VtowrggDMByV8ev5dkriGxARP7O+nflkcI5bRJNEg12QBIT2fR+soLtFjcSjTg/0Yz+EoOkdGxjq/y/7pdQPoAIr1cewvpXH/z2N9cKBGCRlguxZFnDHu5g6qYLnge/cciUykoV3jdMTU9Y0PaDNmIc+l0CaYAK4Iry60DzrE96Fl0zEBNc5qkDOa+XSJvihqCLectEm6sh66vfDFia+8I9Arj7w0HzJqa5BEBDzsL93iSsPj9snUOsPnOG68Skdl5elggLycegC4WmslJDJD7RyiIqDWsDKmiJEkg8gVH4yYhrp9qxRf2+wheJSIxcm7sGAI94nzcF8X5lwAwo2vnYDsvaBrX9z/Ntyng3UhmEB986id70Dz3xz/NPHyBna3JBrqgZHTCFBFHgOkbOU3gvftkrP0+QBTiVO3YXJtqJIwIl2S/7G3Yfes46SSLJNwzB/
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afbd4a37-59d3-4908-0eb6-08d821aee100
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 13:17:05.4549 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S/uF95fIGxH/snh9VKiWJYJQVHWqVNeJNVm2M21kRPl8+3EGZ5nmXtHZy9m6vBrg+YnQoydJAG2cej4luF+BFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0027
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, "Tian, 
 Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> From: Auger Eric <eric.auger@redhat.com>
> Sent: Monday, July 6, 2020 9:01 PM
>
> On 7/6/20 2:20 PM, Liu, Yi L wrote:
> > Hi Eric,
> >
> >> From: Auger Eric <eric.auger@redhat.com>
> >> Sent: Monday, July 6, 2020 5:34 PM
> >>
> >> On 7/4/20 1:26 PM, Liu Yi L wrote:
> >>> IOMMUs that support nesting translation needs report the capability
> >>> info
> >> need to report
> >>> to userspace, e.g. the format of first level/stage paging structures.
> >>>
> >>> This patch reports nesting info by DOMAIN_ATTR_NESTING. Caller can
> >>> get nesting info after setting DOMAIN_ATTR_NESTING.
> >>>
> >>> Cc: Kevin Tian <kevin.tian@intel.com>
> >>> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >>> Cc: Alex Williamson <alex.williamson@redhat.com>
> >>> Cc: Eric Auger <eric.auger@redhat.com>
> >>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >>> Cc: Joerg Roedel <joro@8bytes.org>
> >>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> >>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> >>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >>> ---
> >>> v3 -> v4:
> >>> *) split the SMMU driver changes to be a separate patch
> >>> *) move the @addr_width and @pasid_bits from vendor specific
> >>>    part to generic part.
> >>> *) tweak the description for the @features field of struct
> >>>    iommu_nesting_info.
> >>> *) add description on the @data[] field of struct iommu_nesting_info
> >>>
> >>> v2 -> v3:
> >>> *) remvoe cap/ecap_mask in iommu_nesting_info.
> >>> *) reuse DOMAIN_ATTR_NESTING to get nesting info.
> >>> *) return an empty iommu_nesting_info for SMMU drivers per Jean'
> >>>    suggestion.
> >>> ---
> >>>  include/uapi/linux/iommu.h | 78
> >> ++++++++++++++++++++++++++++++++++++++++++++++
> >>>  1 file changed, 78 insertions(+)
> >>>
> >>> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> >>> index 1afc661..1bfc032 100644
> >>> --- a/include/uapi/linux/iommu.h
> >>> +++ b/include/uapi/linux/iommu.h
> >>> @@ -332,4 +332,82 @@ struct iommu_gpasid_bind_data {
> >>>  	} vendor;
> >>>  };
> >>>
> >>> +/*
> >>> + * struct iommu_nesting_info - Information for nesting-capable IOMMU.
> >>> + *				user space should check it before using
> >>> + *				nesting capability.
> >> alignment?
> >
> > oh, yes, will do it.
> >
> >>> + *
> >>> + * @size:	size of the whole structure
> >>> + * @format:	PASID table entry format, the same definition with
> >>> + *		@format of struct iommu_gpasid_bind_data.
> >> the same definition as struct iommu_gpasid_bind_data @format?
> >
> > right. yours is much better.
> >
> >>> + * @features:	supported nesting features.
> >>> + * @flags:	currently reserved for future extension.
> >>> + * @addr_width:	The output addr width of first level/stage translation
> >>> + * @pasid_bits:	Maximum supported PASID bits, 0 represents no PASID
> >>> + *		support.
> >>> + * @data:	vendor specific cap info. data[] structure type can be deduced
> >>> + *		from @format field.
> >>> + *
> >>> + *
> >>
> +===============+===================================================
> >> ===+
> >>> + * | feature       |  Notes                                               |
> >>> + *
> >>
> +===============+===================================================
> >> ===+
> >>> + * | SYSWIDE_PASID |  PASIDs are managed in system-wide, instead of per   |
> >>> + * |               |  device. When a device is assigned to userspace or   |
> >>> + * |               |  VM, proper uAPI (userspace driver framework uAPI,   |
> >>> + * |               |  e.g. VFIO) must be used to allocate/free PASIDs for |
> >>> + * |               |  the assigned device.                                |
> >>> + * +---------------+------------------------------------------------------+
> >>> + * | BIND_PGTBL    |  The owner of the first level/stage page table must  |
> >>> + * |               |  explicitly bind the page table to associated PASID  |
> >>> + * |               |  (either the one specified in bind request or the    |
> >>> + * |               |  default PASID of iommu domain), through userspace   |
> >>> + * |               |  driver framework uAPI (e.g. VFIO_IOMMU_NESTING_OP). |
> >>> + * +---------------+------------------------------------------------------+
> >>> + * | CACHE_INVLD   |  The owner of the first level/stage page table must  |
> >>> + * |               |  explicitly invalidate the IOMMU cache through uAPI  |
> >>> + * |               |  provided by userspace driver framework (e.g. VFIO)  |
> >>> + * |               |  according to vendor-specific requirement when       |
> >>> + * |               |  changing the page table.                            |
> >>> + *
> >>> + +---------------+-------------------------------------------------
> >>> + -----+
> >> Do you foresee cases where BIND_PGTBL and CACHE_INVLD shouldn't be
> >> exposed as features?
> >
> > sorry, I didn't quite get it. could you explain a little bit more. :-)
> For SYSWIDE_PASID I understand SMMU won't advertise it. But do you foresee any
> nested implementation not requesting the owner of the tables to bind and invalidate
> caches. So I understand those 2 features would always be supported?

I think BIND_PGTBL is optional as ARM will bind guest pasid table to host. As for
CACHE_INVLD, per current nesting implementations, looks all stage-1/level-1
owner should issue cache invalidation when stage-1/level-1 changed. But still
added it here per the comments from Kevin. :-)

"So far this assumption is correct but it may not be true when thinking forward.
For example, a vendor might find a way to allow the owner of 1st-level page
table to directly invalidate cache w/o going through host IOMMU driver. From
this angle I feel explicitly reporting this capability is more robust."

https://lore.kernel.org/linux-iommu/MWHPR11MB1645B09EBDC76514ADC897A68C6F0@MWHPR11MB1645.namprd11.prod.outlook.com/

Regards,
Yi Liu

> >
> >>> + *
> >>> + * @data[] types defined for @format:
> >>> + *
> >>
> +================================+==================================
> >> ===+
> >>> + * | @format                        | @data[]                             |
> >>> + *
> >>
> +================================+==================================
> >> ===+
> >>> + * | IOMMU_PASID_FORMAT_INTEL_VTD   | struct iommu_nesting_info_vtd
> |
> >>> + *
> >>> ++--------------------------------+---------------------------------
> >>> +----+
> >>> + *
> >>> + */
> >>> +struct iommu_nesting_info {
> >>> +	__u32	size;
> >>> +	__u32	format;
> >>> +	__u32	features;
> >>> +#define IOMMU_NESTING_FEAT_SYSWIDE_PASID	(1 << 0)
> >>> +#define IOMMU_NESTING_FEAT_BIND_PGTBL		(1 << 1)
> >>> +#define IOMMU_NESTING_FEAT_CACHE_INVLD		(1 << 2)
> >> In other structs the values seem to be defined before the field
> >
> > not sure. :-) I mimics the below struct from uapi/vfio.h
> Yep I noticed that afterwards. In IOMMU uapi it looks the opposite though. So I
> would alignto the style in the same file but that's not a big deal.

I see, may align with other iommu uapi. :-)

Regards,
Yi Liu

> >
> > struct vfio_iommu_type1_dma_map {
> >         __u32   argsz;
> >         __u32   flags;
> > #define VFIO_DMA_MAP_FLAG_READ (1 << 0)         /* readable from device */
> > #define VFIO_DMA_MAP_FLAG_WRITE (1 << 1)        /* writable from device */
> >         __u64   vaddr;                          /* Process virtual address */
> >         __u64   iova;                           /* IO virtual address */
> >         __u64   size;                           /* Size of mapping (bytes) */
> > };
> >
> >>> +	__u32	flags;
> >>> +	__u16	addr_width;
> >>> +	__u16	pasid_bits;
> >>> +	__u32	padding;
> >>> +	__u8	data[];
> >>> +};
> >>> +
> >>> +/*
> >>> + * struct iommu_nesting_info_vtd - Intel VT-d specific nesting info
> >>> + *
> >> spurious line
> >
> > yes, will remove this line.
> >
> > Regards,
> > Yi Liu
> >
> >>> + *
> >>> + * @flags:	VT-d specific flags. Currently reserved for future
> >>> + *		extension.
> >>> + * @cap_reg:	Describe basic capabilities as defined in VT-d capability
> >>> + *		register.
> >>> + * @ecap_reg:	Describe the extended capabilities as defined in VT-d
> >>> + *		extended capability register.
> >>> + */
> >>> +struct iommu_nesting_info_vtd {
> >>> +	__u32	flags;
> >>> +	__u32	padding;
> >>> +	__u64	cap_reg;
> >>> +	__u64	ecap_reg;
> >>> +};
> >>> +
> >>>  #endif /* _UAPI_IOMMU_H */
> >>>
> >> Thanks
> >>
> >> Eric
> >
> 
> Thanks
> 
> Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
