Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBCCC433F5
	for <iommu@archiver.kernel.org>; Wed,  6 Apr 2022 23:56:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 352984027A;
	Wed,  6 Apr 2022 23:56:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id McX7yBT-Qs5q; Wed,  6 Apr 2022 23:56:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BADCE40111;
	Wed,  6 Apr 2022 23:56:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A4B1C001D;
	Wed,  6 Apr 2022 23:56:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D290EC0012
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 23:56:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BA9E9418A5
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 23:56:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aDTxxmk3MRVz for <iommu@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 23:56:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 818AA41702
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 23:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649289394; x=1680825394;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6pogIEWcprVMn2iQ7JwaH7NWkHtW2Pz01V0euW/3K4k=;
 b=HdoVhW3unA7Uv3O8rAcJLcZoEtRmyu5gm+zNqR/cD1GYdBz+HD9PWQ10
 MuA4vBzBIO0nsWL5r4smc93spJ7sihD9+FI7JeFnNUBU7cbtrBRtfc4YB
 BE8MZ7MnELVCAy0PvMHKNZdjUvXXOVY23BCZ8AIf5ndiWfZKkc7BAp3Dr
 iqsyjenIs32wZqaE3Cz1klSECs1gsr2a2l6b4xH+BMX/uzg9Q2iW6k0zZ
 +9MH28scauQOYIU5+H0o4fHSoNCjJ5wCCnBxZtfdKpg3RDadomIrkAsuC
 j+3PDZwEx45y/j7o/2+qFl43u3a2OU/4uvGVMMw14L/jqvBwlTjZO4LHw w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="248712019"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; d="scan'208";a="248712019"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2022 16:56:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; d="scan'208";a="557158441"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga007.fm.intel.com with ESMTP; 06 Apr 2022 16:56:32 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Apr 2022 16:56:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Apr 2022 16:56:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Apr 2022 16:56:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOqGaKQ6fftlYe98ZmcsxbfqpXEEiqTktlX+ZBJunxHlvnLY5AtPZKfuG5YzKshp2SCQoSauc/3zp6cCf3uERk3kdc3vmarIHUlAFgOS8q5kBZ+dWWhQZRi9nG+hNR8yZYYrKSKlbAUypVl7uRnzOc/Y3w0szOSY3fM43XKntvIvkd4LLvahcAW2V/C8Hgjvg5beVE4YIH4IU0Zc0LcbXzZZhgZjj7i3XVKfgxrTU/y+P2iwMUL0j+beoI6LJxhzKp5AAKKofbAW8w+5dOlrDlyK16UGbQcam8NL0d2w7DY7VQTaWXE1hc+DGWAJXSMp7cBYk5gcpjKpu45VrfSK5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pogIEWcprVMn2iQ7JwaH7NWkHtW2Pz01V0euW/3K4k=;
 b=Z2WvISB1N4GEnoDAzkNYUKDfEJpDRsf4h1l6mkmpW6hUMF3R5QDx0C4clCEeAyKyPfXScquWmFYEfa0Vcj+AzkSZ9YFr0hJf7xVAyBskFV1kXula5eYjvgMMrWcT5BaCH7TLLLIF/U+X0RLQ0Ngr3LKIJjRikTONda5rQT5B4lqoec5tA4z9QLDeH8jZ6enhWnpz8bc4Dkxk+ozo7Oh4KT1odw3BPObEYdQdJ3GsKeYiajqipxvJ+9vaqkraizRwc+2cTldB3bU8ExVmiz73s24DW+lhjYYCuLihRobARNA+zatI+TIqDp9IDwW5Yl/Km+ttuI0cIAJL9BzInyx7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW5PR11MB5761.namprd11.prod.outlook.com (2603:10b6:303:195::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 23:56:25 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%9]) with mapi id 15.20.5144.022; Wed, 6 Apr 2022
 23:56:24 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Thread-Topic: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Thread-Index: AQHYQy+FyOvFomDYNUS+m4eyrODKe6zWBZTwgAA4VICAASjOcIAAbdAAgAAjg7CAAAbnAIAELxCggAaGagCAAAkkMIAAB+MAgADXqPA=
Date: Wed, 6 Apr 2022 23:56:24 +0000
Message-ID: <BN9PR11MB5276CD0EB0222283DA885D858CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220329114259.GB1716663@nvidia.com>
 <BN9PR11MB5276239993592FF808726EF68C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220330115820.GE1716663@nvidia.com>
 <BN9PR11MB527691E38BAC4F89FB17BDB98C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220330143008.GB2111031@nvidia.com>
 <BL1PR11MB52718E663EF48C45D97FEEF38CE39@BL1PR11MB5271.namprd11.prod.outlook.com>
 <821dc298-47fb-6d06-ba75-de5d62a97b7a@linux.intel.com>
 <BN9PR11MB527646AB4F3FE8E9F97ECB8D8CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <a5542ef5-bacc-f527-0295-ffdedefcbdd9@linux.intel.com>
In-Reply-To: <a5542ef5-bacc-f527-0295-ffdedefcbdd9@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ab70909-67e8-437a-d0de-08da18290edf
x-ms-traffictypediagnostic: MW5PR11MB5761:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MW5PR11MB57616CF7928A207E9FBE54828CE79@MW5PR11MB5761.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vJyyn1DP23zFYe1bIqLoAgQ8mbBrAkgul0bBf+J6uXucpTK/0gpmejo+6GZxCw1+DyaW6XZ+gRxxmU+sqkmA2KHaW3YF5tF2HnzAwm5Cda0LVKbwpEINnfVhxd35hoTUMPJGS39lnPMYMhVSzKOwYjEGyVBhbXLHlMw4cmIOOa5CoXmYd8zW5FM5HUFH1xcapPlopC7SSarrE4ysiI8j2NbTyp1ME21AqjYJ63XA86iGCV1IUfyxungnZp9E6LO2wXGcGb8skBpfq1zElUxWUIRdkqqo9x0AUSxAhuvvpkEYQBRFvjFPPoSm+pXl4PfUZ8iWLTyQhIghARBnKxVU6gMWQLcHThd3jgcR9a1KjUn7O6EuVbjDmKC/FwVhGunudTVIrVBlT9x/ETDI2Y4enEetk+FfVPBpmozD8PVZ8dmkXJU9CtpC7eOjWyBGcrxsb88eKPII2hLHBFu3LtloKK3lVZOHN1aW+nMIFf3Zdfm52z+sMmOm7DTJ75svLRUsYrn2y3ajLgUwfCqFvYT+FNLDNpNCc3YlFF+DDltUCRDBy+aAHwMepa3lKlw3I9ZSvJDAe5dMSvhHNONyAHEYb41ZpGe4moyiePIWeG9feS7NZDkOkcGBJ47lbXjb9HRgonsPxv2XkBqmo0/2MGJ6oOX0u8roz+YkX/ERZbqB/I6G/GWBESccBj3BtaotjmvAbNqxuJAOJuBw3AX/ib2gEOq0B3NuTMep3dtn0KFgPNyXRcCrhA5TBiiWp5E6wDFj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(55016003)(508600001)(53546011)(86362001)(9686003)(7696005)(52536014)(5660300002)(8936002)(26005)(186003)(71200400001)(38070700005)(64756008)(4326008)(6506007)(316002)(76116006)(33656002)(8676002)(66946007)(66446008)(66476007)(66556008)(38100700002)(82960400001)(110136005)(122000001)(54906003)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDVNYXVUeUtzOEFRdmU5Z2JicUd3NzZmVkJQRjhUUkNYbDhQSDBsTFh2aXJh?=
 =?utf-8?B?dmlkR0hERkU2bnlIOWZuWDNPU2E5Z21jTGRnOEcvUVdRd3cwTndLOGcrNmI0?=
 =?utf-8?B?N2h3OE9XZkJuVHBubk5tMWxadUV3S3lKMzlRZE1Qa3hvUVk4dkl6NGxXTVBv?=
 =?utf-8?B?czlmTWlrckFrcWR1N0w1VWZVL3B5SS9leWtnL25Nbzc4MGVMZjNqTDZ5WGRz?=
 =?utf-8?B?QkJzSG1telFodHljZStwUDVtb0tYelZjczZacHgxeXk2NUMzeFkxNWw3RUgz?=
 =?utf-8?B?ZldTbkFqcmNoRDNSekZBSTJhdTZmQ3pySzNKNkdTcmYvVi9XVytHWUs1V0Rr?=
 =?utf-8?B?YUcxZlBTKzlScG5uUDlTQi9FUkNXZUE5NnRDVllpcU5ZSWdYOG82VW5FdWtU?=
 =?utf-8?B?NGJHYmhEYndTaWIzRHVRRDg1OFVhVTlkMnErWUtPOVk0VzhBMmVSOWNIeWZS?=
 =?utf-8?B?cWY5REtoY1pYcXhNTENmTUl3c09uK1ZySUgxZTUxZjB0cGZvWnd4U0hISjEz?=
 =?utf-8?B?RzFvRVAxUUZLeXk0NzF1MDlnV2dRY2dMcXJYTXc2cW1PdmdRc1dzdWJJRnFO?=
 =?utf-8?B?VDk4WVgzVzhmMnY3VW1uTitXaGpkUE5MSXBseEdLNE5uRVdEYkdMRFVTZ2dv?=
 =?utf-8?B?Vi9vamZSVktRa1p1dm5sM29vNDZHdktiYWdHV2c3UGVWcmo2RkhlTG1uZ2tD?=
 =?utf-8?B?WlZuUGhZZnlJd0Mxcmx6aTh6NUg3aVkwYUh1ZDZRZURMS1NKOEhpU3dIcFdJ?=
 =?utf-8?B?WUdTeFdONzQvR1VNTVVBQjJmRmFWZk4xaWk0Qy9wVW5JSUdOSEJFNEJhVjkz?=
 =?utf-8?B?OUMvRkVkZitGdEZObmp5VWh1RGRTeExETkhXYlV5aTR6RGg1akZqT2NueUto?=
 =?utf-8?B?S0JLa3ZMNXdRd29JTlBocTdySXFiQkNoamJJZjhrN2NSaktzU1lNWFNYaDdU?=
 =?utf-8?B?SHNJVkZHbHVkSGhtTFFLL09HUU9JR3g1b1lhZ2trb0JFMUEzVE5zUVZqR2FN?=
 =?utf-8?B?N3oySG1aTG15b2RmRTR3eUhPZG80QkFQYzQ5THphcTAyY0RubjB5TVlBTDVP?=
 =?utf-8?B?TDRCRnJVczZVdFZndStzQjQvVjA4ZjRDMGFKMjdtMCtXVXVIYkRPTWFIVkp0?=
 =?utf-8?B?OWo2aUxMVXEwYjRGdEZYMElzT3pzeUhxNHBCcWdYR0JWUVowYVFrYldodk1p?=
 =?utf-8?B?Y2JWOGRGdEFBeVR0K1ZId1dlZWtQZXQzdjI3bUo3NmdtSnpGa0FRSUx6OE1h?=
 =?utf-8?B?SHA0RnFkRm5iRnVBempSL0VzUE1ydkJnSzJkTElNRUhHTDh3TStCb3dIRmZS?=
 =?utf-8?B?SGdzMjdTWFA3ZFhWU3RqNWgvQnJ4NmNSV2JSSEUweWE3eTJTeE1ROXBUWWE5?=
 =?utf-8?B?WkF4ZDcvVFNwd29UZm5MQUFnd1JOSk5JL1ROTGs3bEVuaWZXZUl4Ykh2QnVj?=
 =?utf-8?B?Y21GeWRGNjdmZUk2bDY0M1FoL2JQQnpweHVzMDMxcDJtbDJla0gzUWU5aHYz?=
 =?utf-8?B?VHU5WGRtRll2Z3R6R2xTczdadi9QWk8vT2dnWXdwRkpXS2ovVzlla3FuTFV5?=
 =?utf-8?B?U3RNckp3SGdBWHM5Mm9RSGNkZWQ0d0ZxS2NrY1ptZjJ0Zm5rUHBEWWZoUXBU?=
 =?utf-8?B?dnRaU1hFOG9pK2hSd0VhdU9sQys0SGtlTVZtSjRZM044NDJvbDZIMWIzS1J0?=
 =?utf-8?B?S1I1NmtnZUdwRERIMXArNjN0Qm1wNmFvSTZGTGhSbzlkSFhJeGNEK05OTklK?=
 =?utf-8?B?YzZUZnZrSWU3RTQxMlg5bjlvelozNGVXWXgrU1Mvd0QxQkZiTzFRaWtMMXV1?=
 =?utf-8?B?ZGhMdkJWS1d2TXNvVHQwTDRCRitoOWJDZjcyUmdySy9aWkhCOXVlSkxZL05w?=
 =?utf-8?B?RGtKWnlLdklydkUyZlZOaGU0bTdPK05mdzFBZkk5QjNRVXRWeFgycTFkNXdC?=
 =?utf-8?B?ZVlUVnBvS0w3U3hFS0RkVm1vbEhLUlczSysyZEpDZnBUNEt1TUxzM1ZJa2kr?=
 =?utf-8?B?UUZYZnlOaFZLRXFrT0VnbExOUG5qdDIwQmZQZytrdFFvdmxRVVhETnJTUnVy?=
 =?utf-8?B?TVQvZDVGK05RSkxnUU1ZMlRyT0M4aHJ6NU5OdnJEbTlZN1JCdFFmcmtEVDVq?=
 =?utf-8?B?Z1pocnFENzBkalI5dmFQUzJVYytwcW83RlJwTWw2VXBFSlBlQS85L1Y3SVdw?=
 =?utf-8?B?SmZ1djlOL0gvazkxYWMwUnBGOHV0Q1VmYzdwS3VyYzRXM0lzNGs0dVkzeURx?=
 =?utf-8?B?cjAwcDE3bmZYZXkyTVo1aExKUTBscXVDUFFxeXFsYm9OSkVHYWQ0U2ZUY0Z1?=
 =?utf-8?B?U0tmMjlDNktUVmlrQ0hkb3NWeFpoQ2JnV2QzTzBWR0J0WnJ6TktuUT09?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab70909-67e8-437a-d0de-08da18290edf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 23:56:24.7371 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z6jBGcZ75yS5F2bRMIfoDDFwlDZQD5AVKTQDbIOFAP7jbLcfdhRZnmh1OBEXLNLY0Kin8qMf3pyuak1tfqH3mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5761
X-OriginatorOrg: intel.com
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph
 Hellwig <hch@infradead.org>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Robin Murphy <robin.murphy@arm.com>
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

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, April 6, 2022 7:03 PM
> 
> On 2022/4/6 18:44, Tian, Kevin wrote:
> >> From: Lu Baolu <baolu.lu@linux.intel.com>
> >> Sent: Wednesday, April 6, 2022 6:02 PM
> >>
> >> Hi Kevin,
> >>
> >> On 2022/4/2 15:12, Tian, Kevin wrote:
> >>>>>> Add a flag to the group that positively indicates the group can never
> >>>>>> have more than one member, even after hot plug. eg because it is
> >>>>>> impossible due to ACS, or lack of bridges, and so on.
> >>>>> OK, I see your point. It essentially refers to a singleton group which
> >>>>> is immutable to hotplug.
> >>>> Yes, known at creation time, not retroactively enforced because
> >>>> someone used SVA
> >>>>
> >>> We may check following conditions to set the immutable flag when
> >>> a new group is created for a device in pci_device_group():
> >>>
> >>> 1) ACS is enabled in the upstream path of the device;
> >>> 2) the device is single function or ACS is enabled on a multi-function
> device;
> >>> 3) the device type is PCI_EXP_TYPE_ENDPOINT (thus no hotplug);
> >>> 4) no 'dma aliasing' on this device;
> >>>
> >>> The last one is a bit conservative as it also precludes a device which
> aliasing
> >>> dma due to quirks from being treated as a singleton group. But doing so
> >>> saves the effort on trying to separate different aliasing scenarios as
> defined
> >>> in pci_for_each_dma_alias(). Probably we can go this way as the first
> step.
> >>>
> >>> Once the flag is set on a group no other event can change it. If a new
> >>> identified device hits an existing singleton group in pci_device_group()
> >>> then it's a bug.
> >>
> >> How about below implementation?
> >>
> >> /* callback for pci_for_each_dma_alias() */
> >> static int has_pci_alias(struct pci_dev *pdev, u16 alias, void *opaque)
> >> {
> >> 	return -EEXIST;
> >> }
> >>
> >> static bool pci_dev_is_immutably_isolated(struct pci_dev *pdev)
> >> {
> >> 	/* Skip bridges. */
> >> 	if (pci_is_bridge(pdev))
> >> 		return false;
> >>
> >> 	/* Either connect to root bridge or the ACS-enabled bridge. */
> >> 	if (!pci_is_root_bus(pdev->bus) &&
> >> 	    !pci_acs_enabled(pdev->bus->self, REQ_ACS_FLAGS))
> >> 		return false;
> >
> > it's not sufficient to just check the non-root bridge itself. This needs to
> > cover the entire path from the bridge to the root port, as pci_device_group()
> > does.
> 
> Yes! You are right.
> 
> >
> >>
> >> 	/* ACS is required for MFD. */
> >> 	if (pdev->multifunction && !pci_acs_enabled(pdev, REQ_ACS_FLAGS))
> >> 		return false;
> >
> > Above two checks be replaced by a simple check as below:
> >
> > 	if (!pci_acs_path_enabled(pdev, NULL, REQ_ACS_FLAGS))
> > 		return false;
> 
> If !pdev->multifunction, do we still need to start from the device
> itself? ACS is only for MFDs and bridges, do I understand it right?
> Do we need to consider the SRIOV case?

SRIOV is same as MFD. and all those tricks are already considered
properly in pci_acs_enabled().

> 
> >
> >>
> >> 	/* Make sure no PCI alias. */
> >> 	if (pci_for_each_dma_alias(pdev, has_pci_alias, NULL))
> >> 		return false;
> >>
> >> 	return true;
> >> }
> >>
> >> I didn't get why do we need to check the PCI_EXP_TYPE_ENDPOINT device
> >> type. Can you please elaborate a bit more?
> >>
> >
> > I didn't know there is a pci_is_bridge() facility thus be conservative
> > to restrict it to only endpoint device. If checking pci_is_bridge() alone
> > excludes any hotplug possibility, then it's definitely better.
> 
> Okay! Thanks!
> 
> > Thanks
> > Kevin
> 
> Best regards,
> baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
