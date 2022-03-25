Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AD7C433F5
	for <iommu@archiver.kernel.org>; Fri, 25 Mar 2022 07:15:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55BF761076;
	Fri, 25 Mar 2022 07:15:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lftjSq5e81WU; Fri, 25 Mar 2022 07:15:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DD8B260AE8;
	Fri, 25 Mar 2022 07:15:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2CFFC002C;
	Fri, 25 Mar 2022 07:15:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C281AC0012
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 07:15:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B932541CF4
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 07:15:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jcjj3Z0wS7T8 for <iommu@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 07:15:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A2FBD41CF1
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 07:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648192516; x=1679728516;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Qc8PzrSbytiwzmApI7mqOwO5UO5a8SR4yVZ3kZa6pSo=;
 b=SJQ/L2ogMjUjmN/aDZggOYShY5H8lf04FIEv7AldbXwvZcHjpjdL3itO
 vXwcCdDdFvoZAuhCJ7uW6gJhe8GnmT5p6wQTUCkB+HYR4pFPpt8zBay1n
 jwTes5I5r3zqqdMga7/QSyBDlqCvZPMvpog9pv1Ii1G+LMaWpsY840JKn
 p9LKAoKvyVYQVMlad55szZXvW8niNHxKDHdNd8Hokv46xaC1Vwb4cWI3W
 crt0X9esvBBcuS7+JAP6ru0SS8d2sYYDdiv+fFYTGGiJnn3Q4AkAmUAg3
 Nf7KMeeFkTfInkW1I5yoM3iphaO0N6YoykSmeUKwApMOfFfX8b3GYrETK Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="345009959"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; d="scan'208";a="345009959"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2022 00:15:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; d="scan'208";a="601964850"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by fmsmga008.fm.intel.com with ESMTP; 25 Mar 2022 00:15:15 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 25 Mar 2022 00:15:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 25 Mar 2022 00:15:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 25 Mar 2022 00:15:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 25 Mar 2022 00:15:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUF28ktYTTIDhKbNcJXHoqCOdoKNr1xhLQzEBGdBmRgo0bGwihSKZo85LV8sGK/h5bAryvBKB7fbOO/u6TVvDm9gI4T7SWaJbLJ40EmqSHnxYZiRMJJ/3kn1FQIoJcLeXxQYdpQ1rwRVsBUqS8z8h5WXS0qwovnkb8xou7lLtbCkWAqW4Am0XsHMNhrBR4H/tew8DskgJnbZfjJ2u97tcGvsmjRiTC6AmbQbcndGU8cdpLNKBskIVwjLEaztzZ4sEy0QUvWMTyhOfx6e/BB2x/l2AUNi8IgdDEbUXeecMfH5qHjKqcPG1VzAuZKRTqhBKrd7yV3+9x12Ehf8UqurJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKs16/98XxrhBgWy/f6xhL283JwaAC1ag5veL3KEKq4=;
 b=OhZyzaTYp8LNmLJtyubdwLzsNJ/WmdNkPe1ONMV8zljRYdRuh5E1TF8+lV25G4SGh8a0PoVhq4NXAhWSQMHeo+DtsDILPL495KApEXfQKEruCm0QTu0ygd+nHX+VceKCjNqjeNWMADZ3+5hWpzJM/7pnx2zI8+l0yjgH0C5gIMQshyvjJLMRV1vhtDJj09+Uiy7xQumJpmkxTKYp2n1T0/impHQ1ccPm+6pTKNxsmSuPuFxRb0FHVXX/epbDurON3jMwW67ZKbNQ431tk+qvPB+jG4Q/HclsioGkTnPB04IuitNAcEb6eYDLsuv60FZhdlhSySElCxJiYOEPB0yqxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by BN9PR11MB5305.namprd11.prod.outlook.com (2603:10b6:408:136::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 25 Mar
 2022 07:15:12 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::a111:6656:1e4c:303e]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::a111:6656:1e4c:303e%4]) with mapi id 15.20.5081.022; Fri, 25 Mar 2022
 07:15:12 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, David Stevens
 <stevensd@chromium.org>, Lu Baolu <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v2] iommu/vt-d: calculate mask for non-aligned flushes
Thread-Topic: [PATCH v2] iommu/vt-d: calculate mask for non-aligned flushes
Thread-Index: AQHYPbc0IgBxJPf1AE2VaLrNBkFNvazPo4aAgAAO31A=
Date: Fri, 25 Mar 2022 07:15:12 +0000
Message-ID: <MW5PR11MB58814148CD05C8284C3BCB23891A9@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20220322063555.1422042-1-stevensd@google.com>
 <BN9PR11MB52761E41CAD28CFCB935688C8C1A9@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB52761E41CAD28CFCB935688C8C1A9@BN9PR11MB5276.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.401.20
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0abc14ab-1cbf-479c-cb41-08da0e2f3432
x-ms-traffictypediagnostic: BN9PR11MB5305:EE_
x-microsoft-antispam-prvs: <BN9PR11MB5305B1F241C4064838A6C798891A9@BN9PR11MB5305.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Srt0Ga024VpJVx585vH2ZtLIPO8eFKrjqeG4Xh9z8daVQURcMP/YHvHln7QDN/IhO/31113E5pxs9KqKIlUaVWFBv7tXOTSXOwCEU0gUG4GG5Mx0ULPdLtGQTxCEPL81rcCo9y7/O3sUsCOspBiGPgkmZe9PME4LClVAXS7F8vypg2fTtkKHiEeW9V+Lf40dWHHu/5Jqlr+FkpjEkleXiqLTnWjoXlCsryT/qOMHkSVo4BXtY4EtexZWbE4RwYJMfuBOFCYx04zcK5FioJ+Y60d6sZtdmS033kTrOzkqSsfzXJdK9MWBCFbr5eggq/bU6x0TfGcwFB/7Ku9PRk456vslYQNrqCgce4ZDsAaLsWILNCdwJBOLFVPNzNccBlB9xPrLaG/MunTnbo4n9qnb7Z1NlDsv6IehhPdNSZAeTFuOKsNRZKo/iU1n8Lg2YR9+k9r6x9J+95PXunggzVIeFHKWF2V/EzlMRVNJp7t4M93UIkEOqsqBa+S3iy4qAp4pU9QqtidYD74/K1VbDSbZFSQqFkT2hS/7KvwmQEFYmrOcIxEK3CekkwyeV3r5yL04yKzb35vu2K9INTydKzkVlnPXCnzjfcNynjqwKZOkQWPnULIDagyJvhEbyFkvCKYHQF5cTrxM8POidvFjz7u12s265so7LlMzjVb5r9sbMchu5N41eHHVAgNRoRNhxzEU2T6C42HZg7uHG/qOflPGafjgZ6D66FlC2PObdGXTLulI0b/hu1Qzslw4TXYzqFoafO8psmqPbyjweO8vCZneE/FS2dc0dcl/IGyDG+AUdXQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR11MB5881.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(8936002)(5660300002)(2906002)(186003)(8676002)(52536014)(53546011)(4326008)(66556008)(66476007)(66446008)(64756008)(66946007)(9686003)(7696005)(6506007)(83380400001)(76116006)(82960400001)(122000001)(26005)(966005)(55016003)(33656002)(38100700002)(71200400001)(54906003)(86362001)(110136005)(316002)(38070700005)(508600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h84z1JjujjsCqSVX6R0yPsDTpkyIYrI9A+NGwQHEEM8e2FTfKS64LKp1KQiu?=
 =?us-ascii?Q?Bcehsj8/nmQ19UN3PJve+liWoZ5BrmgjNCBEbg3c1m1rW9RLjMzBSrg9UBkV?=
 =?us-ascii?Q?08p0idVwJOEIakPeLM5n9yGlOYQ1eHW25TTXs8cFjMmvHeUqq/IxYHQSZina?=
 =?us-ascii?Q?/b0+UOE9GC6zXPfJALFUHjqgco5XeJiJ9IQnhY0FmCwSadhAECKk4VGSBQC0?=
 =?us-ascii?Q?gDGrZiIgIk4Ee+u2K0l2WSp66DukoA6pXgncXBNxf8cj0ZgEdHsz6biY2KM1?=
 =?us-ascii?Q?//jciN9GCQ6hHfF3PM1wjoqehSBbJidYdc0s+UlzhVoNdI7qLo7QqO2wncW2?=
 =?us-ascii?Q?bZZVTYt6ilVM4x/UNgvrbyAtskkhYMceqN1+23IVAiV6zqEu/8cyC94os2xg?=
 =?us-ascii?Q?qEdidHHihNycLHK/VDx3Qij7rjViqROTXUGl59LKer0uMvpudEWTSKHIbs5o?=
 =?us-ascii?Q?n6eG86nPhkTEaIootBoZs+l8dfXdml3921ZTJXCefvv1OK7YXWsB2IcDNpJq?=
 =?us-ascii?Q?nT3MAykeLKLqZZVfEP5GAWz6/q9k3HyLFVkElhTZ8F+ZdCQxhKlPVCBtcHD7?=
 =?us-ascii?Q?BbMtFKmmvRAUWIxpB7ItbsgAogzDM0y8CnJu/SfrboRs0DfGBOG20unRiziB?=
 =?us-ascii?Q?/uu7Jp1WQvoWEU77fbjTT4YAjYSUoM1M7YkjYaPhpBBb0JeJWyD5zAwHlUY0?=
 =?us-ascii?Q?aWMr9jheTO3PEs4j6AugOAeRTE/+ppnKAuFbFOi7LVZRSV4VmHjHtIiCMcmp?=
 =?us-ascii?Q?lpJRHAThvI7N1DsHt0LYOmLHehBKkZ9ee2hMJcEvL/DPdOL3V+0rBIe0MAYP?=
 =?us-ascii?Q?zp0Wx2ESZ3Ps7+lDFe1f5Tp8dDJ9sRLWZDCKujsoJup+VsD/7kE/h/XMN45v?=
 =?us-ascii?Q?kYig+JZALJjOM+qlLjnaDt0bT1N6n+mugzODzGMCk+8Dt8JKyu2v1j+5wOlz?=
 =?us-ascii?Q?ZZZ03dqmZxr9/igQ6ia2CihfjFgRZoCO7vrO7aA2NsgIRgAi+8z7o3KMTS6q?=
 =?us-ascii?Q?34IW0MThnXi0766ddSGw3TcekXSBXb+bAbihHY5n1E8/aBZGQyO5NLBzKA9r?=
 =?us-ascii?Q?1U+Ma9gzGvPcvfBZH9PtKtdUmivlC6gQKj+SPkDKd7Q6xPD/BT/RnRM52P9l?=
 =?us-ascii?Q?RCgV43wQcBRHP7l+V1hZtBdgPV/5Kjj+tEXIPPghBSmb5Cb8SnoA1P6Peu9e?=
 =?us-ascii?Q?eQT/sFDTrW2/BN6MwYXP5LIY9//PFZreBJapy5AGpA9sbRZ94S4GaKr1onPN?=
 =?us-ascii?Q?uiQ9mgp5VCCv/n4s18Fep37zXWTfjnyKSKzhWvoUpDdsqU8XC5tXnS2SXIJ1?=
 =?us-ascii?Q?hsLB9nXvQtmJv7OzqTrqnRP/ECiGlhGFw+YC76NJSl6sthvA5+TOPHGj7Hk4?=
 =?us-ascii?Q?/ILW9GN9S6iLSvxU8by6fujHJGH/yWdUlK0YWvSAqdtFewq4nX/NElOHYioS?=
 =?us-ascii?Q?mXE3dvhyk+xpBdIE6BEjmq+qf2+mZuB3?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0abc14ab-1cbf-479c-cb41-08da0e2f3432
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 07:15:12.7873 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B/k2OIKHvre+/KWVAIHV26cAmq8gWBTWMVirPd1522ZHOgx6Z6TBacsB8U6nNFEds82tlUDJ+8DCtm9dZHS3mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5305
X-OriginatorOrg: intel.com
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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



> -----Original Message-----
> From: iommu <iommu-bounces@lists.linux-foundation.org> On Behalf Of
> Tian, Kevin
> Sent: Friday, March 25, 2022 2:14 PM
> To: David Stevens <stevensd@chromium.org>; Lu Baolu
> <baolu.lu@linux.intel.com>
> Cc: iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH v2] iommu/vt-d: calculate mask for non-aligned flushes
> 
> > From: David Stevens
> > Sent: Tuesday, March 22, 2022 2:36 PM
> >
> > From: David Stevens <stevensd@chromium.org>
> >
> > Calculate the appropriate mask for non-size-aligned page selective
> > invalidation. Since psi uses the mask value to mask out the lower
> > order bits of the target address, properly flushing the iotlb requires
> > using a mask value such that [pfn, pfn+pages) all lie within the
> > flushed size-aligned region.  This is not normally an issue because
> > iova.c always allocates iovas that are aligned to their size. However,
> > iovas which come from other sources (e.g. userspace via VFIO) may not
> > be aligned.
> >
> > Signed-off-by: David Stevens <stevensd@chromium.org>
> > ---
> > v1 -> v2:
> >  - Calculate an appropriate mask for non-size-aligned iovas instead
> >    of falling back to domain selective flush.
> >
> >  drivers/iommu/intel/iommu.c | 27 ++++++++++++++++++++++++---
> >  1 file changed, 24 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 5b196cfe9ed2..ab2273300346 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -1717,7 +1717,8 @@ static void iommu_flush_iotlb_psi(struct
> > intel_iommu *iommu,
> >  				  unsigned long pfn, unsigned int pages,
> >  				  int ih, int map)
> >  {
> > -	unsigned int mask = ilog2(__roundup_pow_of_two(pages));
> > +	unsigned int aligned_pages = __roundup_pow_of_two(pages);
> > +	unsigned int mask = ilog2(aligned_pages);
> >  	uint64_t addr = (uint64_t)pfn << VTD_PAGE_SHIFT;
> >  	u16 did = domain->iommu_did[iommu->seq_id];
> >
> > @@ -1729,10 +1730,30 @@ static void iommu_flush_iotlb_psi(struct
> > intel_iommu *iommu,
> >  	if (domain_use_first_level(domain)) {
> >  		domain_flush_piotlb(iommu, domain, addr, pages, ih);
> >  	} else {
> > +		unsigned long bitmask = aligned_pages - 1;
> > +
> > +		/*
> > +		 * PSI masks the low order bits of the base address. If the
> > +		 * address isn't aligned to the mask, then compute a mask
> > value
> > +		 * needed to ensure the target range is flushed.
> > +		 */
> > +		if (unlikely(bitmask & pfn)) {
> > +			unsigned long end_pfn = pfn + pages - 1, shared_bits;
> > +
> > +			/*
> > +			 * Since end_pfn <= pfn + bitmask, the only way bits
> > +			 * higher than bitmask can differ in pfn and end_pfn
> > is
> > +			 * by carrying. This means after masking out bitmask,
> > +			 * high bits starting with the first set bit in
> > +			 * shared_bits are all equal in both pfn and end_pfn.
> > +			 */
> > +			shared_bits = ~(pfn ^ end_pfn) & ~bitmask;
> > +			mask = shared_bits ? __ffs(shared_bits) :
> > BITS_PER_LONG;
> > +		}
> 
> While it works I wonder whether below is simpler regarding to readability:
> 
> 	} else {
> +		/*
> +		 * PSI masks the low order bits of the base address. If the
> +		 * address isn't aligned to the mask and [pfn, pfn+pages)
> +		 * don't all lie within the flushed size-aligned region,
> +		 * simply increment the mask by one to cover the trailing
> pages.
> +		 */
> +		if (unlikely((pfn & (aligned_pages - 1)) &&
> +			     (pfn + pages - 1 >= ALIGN(pfn, aligned_pages))))
> +			mask++;

According to the vt-d spec, increasing mask means more bits of the pfn would be masked out. So simply increasing the mask number might not be correct. 
This second version does give more consideration on that.

BR,
Tina
> 
> Thanks
> Kevin
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
