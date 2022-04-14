Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C2FC433EF
	for <iommu@archiver.kernel.org>; Thu, 14 Apr 2022 03:45:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BDE878299E;
	Thu, 14 Apr 2022 03:45:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FjKbaYi6Zg7X; Thu, 14 Apr 2022 03:45:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 94706824DC;
	Thu, 14 Apr 2022 03:45:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6162AC0033;
	Thu, 14 Apr 2022 03:45:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 894B1C002C
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 03:44:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 60791405D4
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 03:44:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G25ResNC0ZcS for <iommu@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 03:44:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7E77640104
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 03:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649907897; x=1681443897;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=r+YPeABx/Ixqi23bt/lLKauQenXgMKzaiSAsXqUeK0I=;
 b=nZKHeuOaqmdnWf6VbkZcrc2grbmcYzcsrBRqEUzxX38J8mcb5r0YxDpz
 ke+krwoPBfbfjhZTYk+E+1s0VfuJKGwyedq/W3636apHHBnttgvgQRu5w
 eBGM0O7s1FwmOIIi+eAZfri9nOL67e4aJ3ioO9TMYHgPN22yrAr5ranSM
 v2J3VdaGVOKcPGSa/oW6g4TS3rUzcJDkHpV2od1LtFqYsv+zykrjbuMl0
 XJLjYY6QMywROhrvHGGPnOKLCRUDwk1A0IZiAlAzUKLBFq+4FOOL7me3g
 dGXTQmY+21rl40mlMmg4wawW3xBOeEWVlgN2AxdseNf6Whmiq6h0n6dEH w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="244722571"
X-IronPort-AV: E=Sophos;i="5.90,258,1643702400"; d="scan'208";a="244722571"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2022 20:44:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,258,1643702400"; d="scan'208";a="612161284"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga008.fm.intel.com with ESMTP; 13 Apr 2022 20:44:56 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 13 Apr 2022 20:44:55 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 13 Apr 2022 20:44:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 13 Apr 2022 20:44:55 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 13 Apr 2022 20:44:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fww/3hNivcDsxW2bZcL4nvdX+q7RGa6RBPEyBql405l5H1+YjqSGdlMyXg3c5JNfcWdYFi8GUkSHqFt7OM63KPlviJV58mR8qlFbyjJb4Z3pezbdikJvr3tsUMqlDYyOUzs0lSXMxULtd12d7D2P7cB2ucDSdGY9QJDcGqzKZuUUxUwiyZt2e2lseaOqFE7XhrgrRpo6oqgpeDschwjDSleEFotB70eEnt0+p1LUrAzp15/O+bc271U7tC7AApiisCmSFdluXls9SmNXQ/YIG9GnBlnO7oYDuRwe2EPaC9OoUTUQhLrEHcid5+0IDFW53VIKEbKwEoH88uuP9Ncmow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+YPeABx/Ixqi23bt/lLKauQenXgMKzaiSAsXqUeK0I=;
 b=YlFGEt4W2q85Bjzj4jgBPUbtIldz2oOyi8XFvYGTuefplBdmsbNG+nZtJkL+5mJKACzy/m9N/SRhsrp/l1sCTBxY5W66AJFOxoO3oep87bfWXCqKOju0ozuRHgHbiinTx2qYOgsY75lXxFF2SkSS3W1x1bpIky6ZgfWXEPE4XBtfotYKd+vT3R0Ot+RZqU+GRi9Xy3Fk9GNxkrciFRcM/E24/em4PnH5pQSGmfwapsXUr2aj73I12EpbuZj4hRaufH+ZZhRfb3gHYX9IXaJ1FtwPIMgihBYFN3nKAejh3agCx4kd0PooZREoY78tMhLIYiL5Y68ToGX2HQhNsvpA4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB1380.namprd11.prod.outlook.com (2603:10b6:404:3c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Thu, 14 Apr
 2022 03:44:48 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%8]) with mapi id 15.20.5164.018; Thu, 14 Apr 2022
 03:44:48 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 "Jason Gunthorpe" <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.com>
Subject: RE: [PATCH RFC v3 08/12] iommu/sva: Use attach/detach_pasid_dev in
 SVA interfaces
Thread-Topic: [PATCH RFC v3 08/12] iommu/sva: Use attach/detach_pasid_dev in
 SVA interfaces
Thread-Index: AQHYTMWeRZaN3+doq02z8waSkl9xz6zr2plggABkY4CAALKlsIAA0CWAgAEINfA=
Date: Thu, 14 Apr 2022 03:44:48 +0000
Message-ID: <BN9PR11MB52769F0A0A4C1B8DBCA586DC8CEF9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220410102443.294128-1-baolu.lu@linux.intel.com>
 <20220410102443.294128-9-baolu.lu@linux.intel.com>
 <BN9PR11MB5276BCAA64597FE400DF15CF8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <1289f780-143e-004c-41ac-d95b6f18d63c@linux.intel.com>
 <BN9PR11MB5276BE861CF22DDC11D9D8038CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c92d014a-9332-27d2-688b-48fc07efdebb@linux.intel.com>
In-Reply-To: <c92d014a-9332-27d2-688b-48fc07efdebb@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3debc5d2-d031-4a1e-4785-08da1dc91f9d
x-ms-traffictypediagnostic: BN6PR11MB1380:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB1380535F30687187ECFF7ED78CEF9@BN6PR11MB1380.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RFm+bHDLmtGfleEFC7e8I6xR3n3kB1F53tqazKN9asqapMHXo+C2jOow1EysnM45OhfJLUBaP4StYf0fsF+JuWVo1p0IRYKwYJFPKK6ZfgXLg+Rimw3N3jx7MqPtygRarL1pPJbkMwN4u6RjDpuCJbYrd/1VrjpK8RRErGT2uXep2ivys1LhiIEdy9qIC2y4fFxeU+VbKPR5JVhmTklijxeESx+cmuHZ2paN9xSdK4JtCTas2kXnuRBmQS7Y2Efc8M9W6FBqUjIA7KZvB+/1go1n0RuGxnTkkENW/tFpIzy96HQbr2aEvUf1GqRKX2lr+QMc0DoStz2UmZSZQ0awpuraZysQo9o1YppjRh0+BNsd/Aa+KeStFPABSeNSAoce84ArDjKJ5nPJXfR3Al70ui88ZcER0iniCrda0eHqhnw3LCq6x+A5z/YNJ3xkhfy6uSmSTRxFLG3yt27PNoUkTiNMQzKnOZEpu10Kci1ZbQShCS6ZER55geJ04WJ6GKXk11geC6Zsl1+rFDBADwOyFVtyfuz7LTt47pJJh5SPp3MDDK7jWULMpBSqW/AHYt3wZ/ZjVA0910fw0PCP1JvloyiIaaq8/DovU3by69Vmg0q7l5b7HZPKe+HLWyhugZZQmZMPbZE2SkNVESSe5HaA+dAFdK4IMkRSylG1BjAms+YlMtWxAG7p+EQ4Uz3EGQdeis6prWrJSnDuCVro0S5xmQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(316002)(76116006)(64756008)(8676002)(4326008)(66446008)(7416002)(54906003)(66946007)(110136005)(122000001)(6506007)(86362001)(7696005)(53546011)(55016003)(66476007)(66556008)(5660300002)(2906002)(9686003)(26005)(82960400001)(52536014)(508600001)(38070700005)(8936002)(186003)(71200400001)(33656002)(38100700002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmRMVWUwUnJlWTFBVmZ0T04vOHNCdkNkc3pLRU52cWR2ZTh1amkzaDBFeUdm?=
 =?utf-8?B?NDh6TzdlT3hsRGNaNzd0NGtpSk5BU1BvTVRWQTNLcDBTMlFObDlzTXQ5K1k3?=
 =?utf-8?B?KzdRNDZxbUpHUkdTZ3U2cWhZOFVIV0Vlc0tlNHMrWjdUYnkzbVlmMUxweFdh?=
 =?utf-8?B?eUtpRmx6aVVPWTU2Y0NBQWpBbWZCMGliK1IyZ1NuTjNOak5mYjZNWEpvczA4?=
 =?utf-8?B?d3kzU3lDTlQwT2VaSXE0UE0wQzNISGVXa2VCK3pzampPVlFCdkpkNWNPSXgz?=
 =?utf-8?B?dEw1eGw3WVZ5Z1d1eVJoNzU3V1RYcUtSeUk1ZTFwQXdwY3F6OXMydkdlU3gy?=
 =?utf-8?B?Uy9meFhQckhKaFd6a2xEOFN4dEJDTzdTWFJBVFIrV2VmVEtWV2JvYlJZaldq?=
 =?utf-8?B?TlZOTmppM1pSckZPVTNqc0Y1TDRveWVuNXBCbEZBamdUUjNVNDF3dFd0elZi?=
 =?utf-8?B?RS9QZ0x2RERRVkUwMmNtaU9KeG9rZWs5VktJZUJ4T3Zibm9yNnkybEVBWXBT?=
 =?utf-8?B?alNlMWpIN3ovajF5RVBkTkFFMzZNZ1Rla2VEMWdMNytvSWY4dEw5QnNQajl5?=
 =?utf-8?B?TUZOT2YreFhqQkFXOWhRUEVTdWJ0TWt2QmJKeGRwVXE1cWY4NWt4eUlqMTdq?=
 =?utf-8?B?MVhmL3R1WDRzcTlnQkw5bjdOa2UrWDRNY0wvKzg4eTlBTCtxQXRMbGszem44?=
 =?utf-8?B?MEZjOGtYZlZMTUZDUlRlNHRvTzJ4VVRkMzZ4ek9yRWllcnFmYXN5akZ1RkJ2?=
 =?utf-8?B?UVAzajhTblhQVnplODI3bHVZZWswT1BKS2xiL3gzWWdpZmNLZFBkUTF2QVcy?=
 =?utf-8?B?aVR4NmRTUjdRUXAvQlVKWW9rMXZaekpaUEloaWlnbklIVmVoV1o5NVJid2tY?=
 =?utf-8?B?OGhjWmlnZmtHc2Y0WGE0WEZlZ0pYWFluYlYzR0YvN1V3dEtzMm5aZ1hrQWN3?=
 =?utf-8?B?OU5qTEJqUWRsNlZMRDUvYXM4S293Zis2YytQSW5FU1NvNjBkRGJTM29BQUh3?=
 =?utf-8?B?WHIzMkhkNHhpWEd0N3h6YTdEY0JvaVJLWEphbzh6czB5SVZwN3pBdDIrSjdq?=
 =?utf-8?B?akcrQm5ycjZDV0V4ZU1nN1lmcWZ1anRWTlhBMXg4UXFDdDNHbUdNbkdqRnRI?=
 =?utf-8?B?Y3dsdnBYaVFPN0NpSGVRT2tZenBhd2tpTHFXQnRhSndWamVlSlM3bGxpNmFa?=
 =?utf-8?B?NTlicEp2NStDN0p3UFlrVU0xdG9CTk0ySWMydGVZeDFOdStULytXTFQ5Uk1M?=
 =?utf-8?B?QzFtMnpTa081R1ZqTzhITkFLTkdIVlRUZEZUVHBYTzF6azRNM3pIcHVzUm55?=
 =?utf-8?B?R2NjN3k2UDlmNC85OE5XTmlwdzd3dzJKUGs3Z3kraG54NjIwanRBbzBDSkhI?=
 =?utf-8?B?MjUweWhLTjk4UlljNkdtejFsenNTQjhFbTExQmI0ekNxczRvUDcwTzBsVk5C?=
 =?utf-8?B?VWx5a2FmZURBRmhOazlyRXhvYnNicTlsWGJPRVdRWEVXQU1NTXNaU0RnREk4?=
 =?utf-8?B?bnI0RFYxME0wR1BlanhPdEtnWWZYekJZODFPM3lyTFozZzVIdjluR3hEcHlY?=
 =?utf-8?B?cVE1WkZTWk5oQk4ydkhGQzdlWkFQNkU0RW5WZmJGODVnWmdvS1d0MGJnVzNV?=
 =?utf-8?B?OGpzUm8rN2dnUWhyMG1CSzhrM1QxSEx0aUo5QTNOc1ozaXB0V1JWME1FU1g0?=
 =?utf-8?B?NkY3L3dNZ0hFWjcwc1V3ZC9YdnNPMEI1ajdyUzN2cHpFNTNxV2xJUFVJYnJ2?=
 =?utf-8?B?ZE9OUmpGUkI1L2hqM3p5NTNsU29DVVdSYnovOFBvdWpJVm5uNWJxdGdlY0Fo?=
 =?utf-8?B?djVsbjBGbXAyeHZJNjZka1ZrK040U0VVNXdDL25NYThlZ3hLVVR2TDhSOHV3?=
 =?utf-8?B?U3NHazRSd1NZN2ZSclI4RWVtY1JKMEEydVA4WS9GeitCRVlxbk1NWmlYTURw?=
 =?utf-8?B?eXh5VVFJd3VWNmV4VFlvU0ZIcXZMRHV1LzBMTGVCMEVQa1dMa0dhbkRiYTFP?=
 =?utf-8?B?UktSUE1aMEpKMyt5YnlHZUxTaEVsMjAvRDJrcDFSRGJKYktkY0w5ZnJLWHor?=
 =?utf-8?B?MVQwdkhwN1lVNDA5UnprU2tINmJMR2tPNTYxbzgycjlYU1NheFYxck1GWjdp?=
 =?utf-8?B?MnRLams4MXdYOW9xZExMYjlTOFBrQnNyazhKZm5CNGlwMzFuR0xJVWN6Umhn?=
 =?utf-8?B?QTNnbVhLQ0p6VlVXTzhnc2p4V3BCdjRBdU1LUE0xSnhqYS94M3g3eVVCNmlH?=
 =?utf-8?B?dU0wL25ERHppcVZ3WCttQ0Y4amR4QjlRTmlDVXQ1cytBaksvWjU0aGNhSEhx?=
 =?utf-8?B?YjQ1RWdlUGhuVlZJUWRHOGVXRk9uUFpBNStDZUFSUFYrOVpER3R1QT09?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3debc5d2-d031-4a1e-4785-08da1dc91f9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 03:44:48.1286 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DVxQYacQE1f8/c2Gfg4P+rLFBiD+kVrDd2uTZzS3ZDz1ba99L/XHe1Yx74s51JiGcb6SmW5cLFIbhBV9I2ywHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1380
X-OriginatorOrg: intel.com
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>,
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

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, April 13, 2022 7:58 PM
> On 2022/4/13 7:36, Tian, Kevin wrote:
> >> From: Lu Baolu <baolu.lu@linux.intel.com>
> >> Sent: Tuesday, April 12, 2022 8:53 PM
> >>
> >>>
> >>>> +	if (!handle) {
> >>>> +		ret = -ENOMEM;
> >>>> +		goto out_put_ioas;
> >>>> +	}
> >>>> +
> >>>> +	/* The reference to ioas will be kept until domain free. */
> >>>> +	domain = iommu_sva_alloc_domain(dev, ioas);
> >>>
> >>> Shouldn't we first try whether existing domains are compatible to this
> >>> device?
> >>
> >> If we think that here domain represents a hardware pagetable actually
> >> used by IOMMU for a {device, pasid}, we are able to use per-{device,
> >> pasid} domain without checking compatibility. Sharing a domain among
> >> devices under the same IOMMU may be an optimization. That could be
> done
> >> in the IOMMU driver just like what vt-d driver is doing for pass-through
> >> DMA domains.
> >>
> >
> > there is only one hardware page table per mm in this case. Multiple
> domains
> > are required only due to compatibility reason as Jason/Robin pointed out
> > in SMMU case. Given all other places create multiple domains per ioas only
> > upon incompatibility, probably it's more consistent to doing so in this path
> > too...
> 
> Sharing domain for compatible devices is valuable when the domain
> supports map/unmap operations. That can reduce the number of
> map/unmap
> calls and the resulting synchronization of IOTLB. But for SVA case, it's
> a dumb domain which only provides attach/detach operations.
> 
> A similar case could be found on pass-through DMA domains. The iommu
> core allocates a default domain for each group although all the domains
> represent a same page table for the compatible devices. The VT-d driver
> optimizes this by exporting a static identity domain.
> 
> Anyway, I am open for this. I can add a compatible domain list if most
> of you like that way. :-)
> 

This is probably fine as long as such domain is purely dumb. Let's see
whether others have different opinions.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
