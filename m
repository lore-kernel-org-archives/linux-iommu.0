Return-Path: <SRS0=Qw1r=KC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BA7C433B4
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 07:37:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B7CF61431
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 07:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7CF61431
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1549840F2C;
	Fri,  7 May 2021 07:37:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id utv2frJNYeFh; Fri,  7 May 2021 07:37:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66EEB40F30;
	Fri,  7 May 2021 07:37:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AD4DC000E;
	Fri,  7 May 2021 07:37:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 264F2C0001
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 07:37:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 06C6D843E0
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 07:37:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3biVD-1VloeV for <iommu@lists.linux-foundation.org>;
 Fri,  7 May 2021 07:37:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 06C6A843CE
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 07:37:34 +0000 (UTC)
IronPort-SDR: jF2+tFojjYWHRFQgwSec7RYZgIU4rcTA9vIkZqLlir/2pxQofCOQaSPKq68v2FV64z2AtFc8nT
 UUf4/zGSIDZA==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="178912646"
X-IronPort-AV: E=Sophos;i="5.82,280,1613462400"; d="scan'208";a="178912646"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2021 00:37:29 -0700
IronPort-SDR: LAcYDeiM/W7mGs0UuJPozfU2fjcmLUy+s8LQza8uZANnvQBhTNd4J+VW/uUHm+WDPV7mRhYIyG
 Tx74o2D5/wSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,280,1613462400"; d="scan'208";a="391002708"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga006.jf.intel.com with ESMTP; 07 May 2021 00:37:28 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 7 May 2021 00:37:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 7 May 2021 00:37:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 7 May 2021 00:37:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgYpa968KfU0tQgWuhuQ+OxZBJ0suvdBEVfoKQ7Ua3GGbwQWL9RS6AlgSQDxGJEkU/odVju9ly6GBFvGhI19GUsvPwz3ZLQ7LBrWs/whZbdE33DuhuJWT7ZVrmra+yKykY54gXnfvoxArcH0f3jba7Zlsl0mRPBecOEf76nVy1kcNuCiLYruLWOJ/0AnzCKIYfVwyMkS9rvxA/m1xmtHT8dpBA+80G6Wx4hpG7J7DsQRmNByqRo3SQMzkSz2DJ3N0aWbS61RCBwIgzTItwZE6iJztbdHzqf9MIyPRiyW4ES7wvsC4boVGZ6uhHduGYj52D9WS6hKNWPhiTmqdGpdlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zL/NA+Gue/OgPDL2Qphm0KKhLO3t/v9HHZCpdf36x3U=;
 b=b47tgtzKOXfWONzSeoQH5ZOovVymIqVCedxBi4zgzcZjIqhTC6HoklhadC/lHePrRzwziP/usrq7g8Hu42JItv+8zcWUqPcGEgM3nLuk85jUrVZEWSr43CZrdDRpDOKJLS8SB2pVE2pxpi4DsRFfEAM3kqlNLnKhsXoO0BcqnzugL5GWZ0gCeAAdXb3+oRWKY43PII6KAR5BPE8lxhCX12zYalVjH2bUKWnYlpIx4Gb63rhjALpmIcpcIdMZa0241l/geCg5iKvEpUngqZpmMJvU5npzgMqTIFqZDTKXSM0fNMrnb6BSqidYZYiA6iJFLAZ7BgEnJ56kcrU2gKGO9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zL/NA+Gue/OgPDL2Qphm0KKhLO3t/v9HHZCpdf36x3U=;
 b=xHxFMAEjMNm3LqCI6PwqDigzknSzOLAfbOe5/U2TsqsuPio57zYHWuMgrvm8imLqpH7TS8FngLtL/UefJD68xAQAUwmLzRFmLqauj7X7LhIFFSQ1tbW3UL/8hpAkFujHtzq6EX2Lbfe0T3pUAQMlzFZPQgY60DS2b0tdlfa15yw=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by CO1PR11MB5139.namprd11.prod.outlook.com (2603:10b6:303:95::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 7 May
 2021 07:36:50 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.4108.027; Fri, 7 May 2021
 07:36:50 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACAATCSAIAAVGMAgAELsQCAACiXgIAAVBgAgAAaMwCAAAESAIAABy2AgAAgOYCAFdCAgIAAppUAgADsNgCAACqygIAHsmaAgAAzsYCAAAjdgIAAD/yAgAAcQgCAADqggIAAk6nQgABIUACAASsnkIAAYWwAgALs9qCAAdeZgIACip7wgADDb4CADZr84A==
Date: Fri, 7 May 2021 07:36:49 +0000
Message-ID: <MWHPR11MB1886E0A7897758AA7BE509058C579@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210421162307.GM1370958@nvidia.com>
 <20210421105451.56d3670a@redhat.com>	<20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com>	<20210421230301.GP1370958@nvidia.com>
 <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210422121020.GT1370958@nvidia.com>
 <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210423114944.GF1370958@nvidia.com>
 <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210426123817.GQ1370958@nvidia.com>
 <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210428090625.5a05dae8@redhat.com>
In-Reply-To: <20210428090625.5a05dae8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fffe26d9-203d-48cb-06a7-08d9112ae071
x-ms-traffictypediagnostic: CO1PR11MB5139:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB51393FBBC3B9FDE2B70B89058C579@CO1PR11MB5139.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +6igDq2UX4mcACZMRhKq9910L25qleHIX2m08Hry3phopEaO6fSn8vLSHJAD3veGtHLuJgO+EDCx1OgcRWRSHIz8MS58PBoATBcLc+MnxoBUjsSgNwYITCOvn0CwWQ54tzQkC98kGTE63xsrciZsqu11vx7owA9nBoeyDLt5G2IbYzkJUUQuwjx4w8RHisc1kbQmisVyhWzZ37mLqaSvsOz+VM+c2EXG04in+pOWx9E4e+5t6G19y8fLuhnKCrbiMuku2Ux/lhRE8i2A9tUhCO/94Bb66NhgLb3eatrj2ss+mEoaU3YbodmS3zo8i3QIpV2jeDdYFCQGLSxVHbSPkGWuYBvr0b35zTp915tDsPcoXnLcwEDdaKQlHsHJIXGgnHElXkSkF3WGiYfsx63RmG3ouguGt9kLJYoXddCU2SDJVmcPapvJVHcKm6K8BLGK+D+MkV6GTUqeKuWZ8uaPp6XbYlz800730HAUgPwJrffpnBgwCmxpFma1s26LBAXZ1IsQE5jfAS00fZqQv8i/pvbg+dRYdKTPySp1QjxSdcnb0YdnD+h1iX7bghHWBddXiq3AP1iQmdkaoVn8ERlyIkGPR5nZPtrxR5QHUPUli7s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(376002)(39860400002)(136003)(366004)(346002)(76116006)(52536014)(66476007)(66556008)(64756008)(66446008)(66946007)(7696005)(6506007)(33656002)(54906003)(316002)(6916009)(8676002)(478600001)(7416002)(8936002)(26005)(186003)(83380400001)(71200400001)(38100700002)(122000001)(5660300002)(86362001)(2906002)(4326008)(55016002)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?JvbiVSK2MoAyXnDZxc9FX9lnnTxKXl0Ai3WhFexNd6TXVT5JPWrcPBxnuh43?=
 =?us-ascii?Q?FjcPHqpQnvP4bMHN+OKH+UpZvl7tCxKa3bQDXzuNGYc9JKqC8Cvk3zey93+7?=
 =?us-ascii?Q?BTLGbr8Ezy5h3ZBd9nzikE6r4yGQhMKPEVWB3AR87Jxe81Po/KrkectjdeZ/?=
 =?us-ascii?Q?TDEMrMtkfUOZUBgIFiPFRgy8DcYyIZeaYrpc83EFeixK5XsuOdmQd9qHirCL?=
 =?us-ascii?Q?lx8D6ZjSyqBaZ4hOxZWVzvVOfT1f2wcoxws8WZwXzndXESNtPLtBVDjv9KoL?=
 =?us-ascii?Q?kwmb40y/qTwW38r2KrZKC+L5pF6DwYx3Bs23HFjP94rNBRNE8B6JAUaIoPjn?=
 =?us-ascii?Q?3pDNzfbHSYbfCIeS1gxKzRSI1yL0u/AdahVpPhPdV4RodyoWJSHvBlR8Jrea?=
 =?us-ascii?Q?TupN0d9ol62DDaeMK43G0mtr9BR+/XT/nvEwhg9Tgx/fuCZZjZSUvPPTmFnf?=
 =?us-ascii?Q?vyTcwYNR6eqdQfQDsb4uAjR83GP44l/NKl6iRLTaKyEn5w4E2dXLm3lkzp6f?=
 =?us-ascii?Q?FK+Cx2uk5ehYwXbyK8rav8ExMuf/qj1+5fg7+B2LNBqRFbqzFLofAmJSlsVL?=
 =?us-ascii?Q?yw9nkxVB2wyfbfSJBdO7lyJtHtBxwwcqyoQr7ucnIOD3dNHImL3H40AX7+sV?=
 =?us-ascii?Q?i8/7WYXUWgyOFvIgUizJvDl5O4c5Znc/cSWn0Ha73tpyI6aoSZVV4d6kKcww?=
 =?us-ascii?Q?+GjGMLQHPfO76vgvKNZYRnwmRKJue69SK0UEOo7cSP1IrI7yb45Cwppt5sjf?=
 =?us-ascii?Q?yF1WhhXjZiLCWKbAJHEsndtQ5w+MldLmoYieNsI8M+PnWGPBdVerFCWBcvay?=
 =?us-ascii?Q?pe56x+ZOt0lhEmuk8zOK1l489KfkKRFSeXmgF1PxsMrpTLbeB/mSeBHcJW5S?=
 =?us-ascii?Q?EHo3c4e1iVFZasWwtsfDzQwPocDQ8pZh9bHwwZkvCPwX41OGCdezvtdyS+hK?=
 =?us-ascii?Q?lJ1MCAoRVBtc1E6MmIOD33vDGySUqTqvPQi6x8Y7R8G4RLG68y9HnLfaoWzD?=
 =?us-ascii?Q?xKhbOfvCdDl5kcSzZFUKfdRzXKmzAr5W/RvL5/HtbDx+xK+3FpC6/As56hts?=
 =?us-ascii?Q?jH7WShWwSfpedkidZknxFDaYXVQgIyPJdH+RpYPLHppGldeToy7g0RYOWg7k?=
 =?us-ascii?Q?Tpe+nsPTCid7Eb3mbu6x19GnlndHxEQZ2IAEbgvccjFkTkwzcLHqK0gEh9AN?=
 =?us-ascii?Q?9CtmRhLLvt1aob8h6753DzSRSmQEnSszsfgJGTUdB/vPORW5hSsUNSOoEcdi?=
 =?us-ascii?Q?+KZ6ffmvAnV/vwcOeoAnvX+/mv+D20ifNQUMdfIjgGJgsVUWh2ZzOXoD+1pn?=
 =?us-ascii?Q?Qxpdf+xW6lMZUabfquk0WONt?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffe26d9-203d-48cb-06a7-08d9112ae071
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2021 07:36:49.7379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FlhWM2ycs4jbyChPy4lQxHY7n+doMV5nqV2IL11bvm2DOUUXTEtEpSo93qT3bqBKGJIwVyCQ/GWCN5jdTmLwGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5139
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Li Zefan <lizefan@huawei.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "Wu, Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Wednesday, April 28, 2021 11:06 PM
> 
> On Wed, 28 Apr 2021 06:34:11 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Monday, April 26, 2021 8:38 PM
> > >
> > [...]
> > > > Want to hear your opinion for one open here. There is no doubt that
> > > > an ioasid represents a HW page table when the table is constructed by
> > > > userspace and then linked to the IOMMU through the bind/unbind
> > > > API. But I'm not very sure about whether an ioasid should represent
> > > > the exact pgtable or the mapping metadata when the underlying
> > > > pgtable is indirectly constructed through map/unmap API. VFIO does
> > > > the latter way, which is why it allows multiple incompatible domains
> > > > in a single container which all share the same mapping metadata.
> > >
> > > I think VFIO's map/unmap is way too complex and we know it has bad
> > > performance problems.
> >
> > Can you or Alex elaborate where the complexity and performance problem
> > locate in VFIO map/umap? We'd like to understand more detail and see
> how
> > to avoid it in the new interface.
> 
> 
> The map/unmap interface is really only good for long lived mappings,
> the overhead is too high for things like vIOMMU use cases or any case
> where the mapping is intended to be dynamic.  Userspace drivers must
> make use of a long lived buffer mapping in order to achieve performance.

This is not a limitation of VFIO map/unmap. It's the limitation of any
map/unmap semantics since the fact of long-lived vs. short-lived is 
imposed by userspace. Nested translation is the only viable optimization
allowing 2nd-level to be a long-lived mapping even w/ vIOMMU. From 
this angle I'm not sure how a new map/unmap implementation could 
address this perf limitation alone.

> 
> The mapping and unmapping granularity has been a problem as well,
> type1v1 allowed arbitrary unmaps to bisect the original mapping, with
> the massive caveat that the caller relies on the return value of the
> unmap to determine what was actually unmapped because the IOMMU use
> of
> superpages is transparent to the caller.  This led to type1v2 that
> simply restricts the user to avoid ever bisecting mappings.  That still
> leaves us with problems for things like virtio-mem support where we
> need to create initial mappings with a granularity that allows us to
> later remove entries, which can prevent effective use of IOMMU
> superpages.

We could start with a semantics similar to type1v2. 

btw why does virtio-mem require a smaller granularity? Can we split
superpages in-the-fly when removal actually happens (just similar
to page split in VM live migration for efficient dirty page tracking)?

and isn't it another problem imposed by userspace? How could a new
map/unmap implementation mitigate this problem if the userspace 
insists on a smaller granularity for initial mappings?

> 
> Locked page accounting has been another constant issue.  We perform
> locked page accounting at the container level, where each container
> accounts independently.  A user may require multiple containers, the
> containers may pin the same physical memory, but be accounted against
> the user once per container.

for /dev/ioasid there is still an open whether an process is allowed to
open /dev/ioasid once or multiple times. If there is only one ioasid_fd
per process, the accounting can be made accurately. otherwise the
same problem still exists as each ioasid_fd is akin to the container, then
we need find a better solution.

> 
> Those are the main ones I can think of.  It is nice to have a simple
> map/unmap interface, I'd hope that a new /dev/ioasid interface wouldn't
> raise the barrier to entry too high, but the user needs to have the
> ability to have more control of their mappings and locked page
> accounting should probably be offloaded somewhere.  Thanks,
> 

Based on your feedbacks I feel it's probably reasonable to start with
a type1v2 semantics for the new interface. Locked accounting could
also start with the same VFIO restriction and then improve it
incrementally, if a cleaner way is intrusive (if not affecting uAPI).
But I didn't get the suggestion on "more control of their mappings".
Can you elaborate?

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
