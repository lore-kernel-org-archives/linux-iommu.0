Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D35C433EF
	for <iommu@archiver.kernel.org>; Fri, 18 Mar 2022 05:33:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4401B80BE6;
	Fri, 18 Mar 2022 05:33:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3pj3ncmKsLBX; Fri, 18 Mar 2022 05:33:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1718080BCB;
	Fri, 18 Mar 2022 05:33:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB66DC0033;
	Fri, 18 Mar 2022 05:33:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9496C0012
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 05:33:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8547E40581
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 05:33:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LSNd1rUs1IUs for <iommu@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 05:33:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2FF3940566
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 05:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647581625; x=1679117625;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ezl1SmnvInuTOORoRSbLzF81mVA8V4pJ593lhHVCMqU=;
 b=KTWnROsJJbGBBYqlXilVpJFxTnl13+XyV6bHrypEnvCu5ykC/3rOPElI
 xS7dVi0d6oRO8W6dylq6hdsM3OEYNGxIl3XMiHqKifzFJF7UH2qheCN3Z
 /2Zn3r3nEWSDwqWpmmWJa5n2nFArB8SVBpkEdxtWBrZSd/ClmATB+ot9l
 UKAwSNenQ+YsShGzH20ps24tWYkOjjRx2k4S0+ULSxV0Uyq0ONMJsGtt5
 KfQWbyl7HALj8d/tr1GtlzXr12iT1hCFlYLJ0VrvbaipJeKEn2ibvDtX4
 ADfhi8ZpRsStO7Bj/3PRDQqrLFSee5U3S5YNrQlsi+9sD08H9mgYbG7J+ g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="255879783"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; d="scan'208";a="255879783"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2022 22:33:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; d="scan'208";a="784101095"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga006.fm.intel.com with ESMTP; 17 Mar 2022 22:33:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 22:33:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 17 Mar 2022 22:33:42 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 17 Mar 2022 22:33:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRoEkdrb5LXbJ3uRVmu9+nFC2qvBk3iVJpLJr0b1gPtDl4CTDhVH5rhJQuKF7oBbHcd43EgHgdPDFDWht0KQb0qEE1zeN+hSt9tZxet30bRjMjSgjLUv1VMBT5Gl90MCikpiLWrlGgasxb98LtcYNvwVKXoMkRffIIr1HWIIG8LrSUFirsA300vLJnrJkIIZVI5WRs9e53icb09W8w9hHEL0p+FxEmFBivHPAcVZ7YhMgtwlycDH9yTtqxqBWjKpOL05yzL5JT4rsulySET+57ZCnp4SJk2K2Gk8zKwhop0cup8l2Xsxb47LZV5dCl0xqmxqMxxi5RdnVMCqSwnodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ezl1SmnvInuTOORoRSbLzF81mVA8V4pJ593lhHVCMqU=;
 b=hU5m51CkcjFWp5cFhqOGsQL2iFaW0lTcMfqSqvK/UN+BnEwd2OHsfdP3R4KTX3bcMt6vbQ/TipLGa0yCkUMhbHEwLz5pYbU/XY5Nt5QHqrRMlbBGrdsNpKXNmOjq5ZhvJ2gLYHlh8kubHYneQYvC8eIJcRQ0oFi3CvdpW6uEqEG6yHyFOJgMlxmURQM1sFnBfvYFY2jM0VE155aPDscoYgnckntqBomdsGrojXVbLgDi4+DeTO3HMjp0l4hqnWZsH9BPHhyLs2lGNfZIx5o9s5PM6vmms8sjFg58FfLPhZdWKhMYWIdUy+UPQdMYJqVew9YVUVeyjRANWFKnUjT0pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BYAPR11MB3574.namprd11.prod.outlook.com (2603:10b6:a03:b1::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Fri, 18 Mar
 2022 05:33:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893%8]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 05:33:38 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Thread-Topic: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Thread-Index: AQHYOCoddoPAbs8qR0GMuSnaaH7P9KzAguoAgAEeqfCAAOApAIACIOCw
Date: Fri, 18 Mar 2022 05:33:38 +0000
Message-ID: <BN9PR11MB5276FF347A54098F469936978C139@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
 <20220315143322.GW11336@nvidia.com>
 <BN9PR11MB5276E98AE37EA912B01EB0B68C119@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220316140140.76bb24c6@jacob-builder>
In-Reply-To: <20220316140140.76bb24c6@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c40dc9c-763c-4dbb-77e1-08da08a0dac1
x-ms-traffictypediagnostic: BYAPR11MB3574:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <BYAPR11MB3574D80380FCFB4B6B0C26438C139@BYAPR11MB3574.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FNRaidmq4FnQUM4LE9CHSxMZVOfd0UFX9ocFbX7KjIcqmDiNkGtHWSgqXViN6xrJYu1HERgEHp87e+NKF0SPH4/Oad4x0iX8TzPyxT/FjQDMupjX/SYGR1Mi5oQULcXTmLHlWEBMjTH/TIEwJEe2jFq3Vh16ekrKHc4rbRvVZQvNf8HCStlUTEATpv1dINRB9De+RPyh8Tud6jgNoqH8WDeqmXdU801RrbK6547VWHexyY+iS1OrNRcw75XcRsiCcXTEb/RSdtlj9M9FsZxor6vwRC9C/22+FPJaPoJAbFyDM71vsKFQW6+3531Rd9a7MtkL1VYwcoWxUVRLoG/98gHro6shNpuCMeVgPYveJzJLlJesLMIbhxCIqa3JsIhRRR8FrEox1L0GPsASbJIb5+v4yPaUFQJsfx5nwpZFYuKjmcH2Zt4dY4VPZ1EZ6qST2E7IDK+0hlTITvlc4i2K7VzAK92dhVKfzKLB1yuA/VP31zSLoY9wCXGiuwky+Czo8HBVisWvwx5QC1VHKNhZqTlRIAn0b6FiJF+8M90wM5ezoZi9CylEIIH2FlhxTcfi0knyKDk3aL8rpn7c6gFPo0OH1mALVxZLSi1gFLQwEQeg7zEoqRvQFm4EAfwpjwaJHe8ACxcoCOeiQiU2pqHk240pDiV58U21vIhKch4cGRlcB4icSrMubpy5F5epjVWis6YLSKZBIKLmyUZ2SlOqVw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(316002)(38100700002)(71200400001)(33656002)(122000001)(54906003)(6916009)(55016003)(9686003)(66446008)(7696005)(508600001)(4326008)(8676002)(76116006)(82960400001)(66556008)(66476007)(66946007)(186003)(2906002)(5660300002)(8936002)(86362001)(52536014)(64756008)(6506007)(26005)(38070700005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTBUOFNIRFJPdWZQMmU2V2p3WHVET3VnVUhQVTVQdWpBQkNFd0s3Vlp4V0Rv?=
 =?utf-8?B?SHBBc2I3eGdGVDVRaDM4Y0FGOWc5Mm9rMVZFdks5dW1hZVE5cTc2MFZLMUw5?=
 =?utf-8?B?aWRoMEI5REEwN3pNT0lOc2ZHeEJ6cUtWZTNOQzBXUWRLcGlhSW9mZzJSVi9I?=
 =?utf-8?B?SXViT1BudDJSejNqdTJxeGtEQ2JaTGd1WnQweThESkZPQ3NQMXdka014eEdr?=
 =?utf-8?B?Z2hhbTk4clRuR0duQnA1YzVOWGRyZHEycWd0Qlo1eDh3SWJTbC9SeCtxU0Jw?=
 =?utf-8?B?dWVFVTM1YkZhMldFU25MekZOclpjY0dobHl5aEhDaFZBZ2h6UFArclFQeWFs?=
 =?utf-8?B?MDRvUm5yWWwvdHZTRHVFTEJDTm42ZjY1cnN2SE9oOFVZS0hkVkhOazdFbWs3?=
 =?utf-8?B?bHlYa3RzMG5HS0dlMTNhdXZZZjVWWEpyR0JmVTU4S05mOE9hbis0Q1NQblRa?=
 =?utf-8?B?R1NRSHltQld0WWNwZWNyRW1SaTFCenU0R2RMc3dWOGNFSEk1WC9nWjF1a00v?=
 =?utf-8?B?Q3JIR2h5OUtuSUlVLzZ4M0ZHYVEwYWpqVTdLQTJZNVJQdlExZUp1MFJOZmNz?=
 =?utf-8?B?eTcxYUtuK2tMR2xVNTJ1SjBmTGQyKzg4WS9oSDBaRUpieHdEV3B4alZhVVEy?=
 =?utf-8?B?RWh1M2IrWHpKN3lnSEE1cWZ1UVRTR3JEbnhmcWl6MEowd1U0QUdXeE9yend3?=
 =?utf-8?B?c2pzalpHSlNpUE82ZWtCVUxmNFg3TjhybjNwMVZ1aUY3MG1XVERRaTYrUk0x?=
 =?utf-8?B?emRocFkrL3RuUTJ5KzJlMjNrVFZMQ0Y5cGtrUldPMWJDZ1JuLzZkcUxwNGVD?=
 =?utf-8?B?Vm1ka2MyWDlOMjlWT2xVTUFUaUw5NDU1V0V3RExKWHZ2Z1cxM1lEcTIxck5o?=
 =?utf-8?B?QWlDTml5MEVGUy9qNkkzSWlXR2I5bnFwcWJRWlgrcHNZV1FPL1VSRmtNc1Jl?=
 =?utf-8?B?WDNXTGFNODNPZHlscWpWVjlMS0hVRzhEN0g5OUZXaGo1bDlkMStvVnFmbWpw?=
 =?utf-8?B?THcxc1lWc0tFWU4yL29aVldjblcwaDIwRVg5R2ZQb2VSb0ZXYXE1UmszTmNU?=
 =?utf-8?B?VTk3eGRHdTJkRjdreGdmZnA1aW1RUWlUVGIxTGRFOGlOa2I4OEFUWVhoQ1RC?=
 =?utf-8?B?cURJL3YwTEJpN1dnSVVqYWFGanFSUlJrTjNFMUg2VG9SRm1UZWh3b2E2SEky?=
 =?utf-8?B?SjkzSkN1Y1A0dlNzZ0xXVXRJYVRGMytWM0pJRlE0OTcxd2ttMzNsRmJ2Wjgz?=
 =?utf-8?B?UmVVUkNNdXVRRjZwQm40Y1ViMHM5U01vSHdhNmVkc1NBbEdqMExBZzM1SHh2?=
 =?utf-8?B?SkRhTXFWRW00ejUvMlVZK3cxajd6Z0V0N0JHb1RzeGJOZzZxSDd1Uy9Mb0tn?=
 =?utf-8?B?ZEJIampXY1RLVXhYeUV3c05oKzFlMGFST0NSTTV1NndsYlB1ZzBiemlGVDRu?=
 =?utf-8?B?T200WVJnc0c0ZFVSdnd3Qi9HOEdFNUtvS3U3VVI1ODJoTVNsMmo2cWorMk5P?=
 =?utf-8?B?cTcrekhqVGxVSWdZTHRvWUhjWnkzYmE1TjBMTzVHYjYrQUNwd1psVDVaanJw?=
 =?utf-8?B?Y3huaHVpUExsRGtodm9CS0hBN2YvVlh1K0lvU2FRc0NHVjlqZSt0WEFmaGt6?=
 =?utf-8?B?STZqZ296Q1RoUTFzN0h4dXlyclpXbStDQ1U4SUtQVlpzckJhSU0wVVBrNCtY?=
 =?utf-8?B?MWV4L3l5R3k4M2ZRNlRmSDVlZnl3Z2QzMHdCZFlVOERLOXE1VGRpL1JQYjBL?=
 =?utf-8?B?WHFPNXA3ZkM1Z3BzWDlvUGxxYnBrWnBEYUhzNWNSaG9xT2UxaXdHeW1ydmZ6?=
 =?utf-8?B?UC9NaTFuVCtZY2pvR29oRldwajJ4clVXYjNLbEhvMHBFdmxOYmlsTHMwdzM2?=
 =?utf-8?B?UllXUndFUjNnbkFOZ3owcHE2SnJEKzc4UFhtTjVWWjVUL25uTGRnaUhQc2RH?=
 =?utf-8?Q?Wf4zDii4TxZ087UF8Jxl8LF4GSDreoVE?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c40dc9c-763c-4dbb-77e1-08da08a0dac1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 05:33:38.2842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UAHNoVvDfvPkbWYGWnBNKgqV7vIB6snbPM5NUogROwN17Y2/mfU22ll1/ALvikqH/cHvAItgISPU3lECSagtoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3574
X-OriginatorOrg: intel.com
Cc: "Luck, Tony" <tony.luck@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan, 
 Jacob jun" <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

> From: Jacob Pan
> Sent: Thursday, March 17, 2022 5:02 AM
> 
> Hi Kevin,
> 
> On Wed, 16 Mar 2022 07:41:34 +0000, "Tian, Kevin" <kevin.tian@intel.com>
> wrote:
> 
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Tuesday, March 15, 2022 10:33 PM
> > >
> > > On Mon, Mar 14, 2022 at 10:07:07PM -0700, Jacob Pan wrote:
> > > > +	/*
> > > > +	 * Each domain could have multiple devices attached with
> > > > shared or
> > > per
> > > > +	 * device PASIDs. At the domain level, we keep track of
> > > > unique PASIDs
> > > and
> > > > +	 * device user count.
> > > > +	 * E.g. If a domain has two devices attached, device A has
> > > > PASID 0, 1;
> > > > +	 * device B has PASID 0, 2. Then the domain would have PASID
> > > > 0, 1, 2.
> > > > +	 */
> > >
> > > A 2d array of xarray's seems like a poor data structure for this task.
> >
> Perhaps i mis-presented here, I am not using 2D array. It is an 1D xarray
> for domain PASIDs only. Then I use the existing device list in each domain,
> adding another xa to track per-device-domain PASIDs.
> > besides that it also doesn't work when we support per-device PASID
> > allocation in the future. In that case merging device PASIDs together is
> > conceptually wrong.
> >
> Sorry, could you elaborate? If we do per-dev PASID allocation, we could use
> the ioasid_set for each pdev, right?

My point is simply about the comment above which says the domain
will have PASID 0, 1, 2 when there is [devA, PASID0] and [devB, PASID0].
You can maintain a single  PASID list only when it's globally allocated cross
devices. otherwise this has to be a tuple including device and PASID.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
