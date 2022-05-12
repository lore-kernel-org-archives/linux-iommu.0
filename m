Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE48C433EF
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 05:01:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0FED60757;
	Thu, 12 May 2022 05:01:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jJA99dl_DuH1; Thu, 12 May 2022 05:01:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AA0AB60AA8;
	Thu, 12 May 2022 05:01:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D85BC0039;
	Thu, 12 May 2022 05:01:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B032CC002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 05:01:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8913B40B6E
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 05:01:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bkUnE9xXp7h0 for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 05:01:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C7C4E400B8
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 05:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652331676; x=1683867676;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9UmPzthUswKbZLlMLLZR9ev+K/RnGwFkuUVq8Nct4zk=;
 b=UPp5wultQ2vwSq+dI7j5QbWoeWU7Me+hBKGwnq0XLb9zlHQqL2uOYkPF
 mFFMVS8+UtdhRbsNHOcgACv1r4NXrYx51xoUgDF0g1LoD9QwjDT3SZRge
 gAfsK3AlCegvkdfHREIcs7DlxOaj+UccDcehy6VxldAREvPnmPRU66Nlp
 I9aLmJr8eSN4w1KvV0+Xipjrs2qn9eDF7yV0H9j+vCyoKdgavBGU3K0KT
 rTQp3Zx5LAokl1S4I5UNZUJx4A/hURW24Yl387NV4bj36xTUORvahHNMK
 a6cwknsRW9tAshH1Ord2vlBe7VcZt0Fkyd2DfxWxs7rZwR/Bz0z9EkAF7 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="249785292"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; d="scan'208";a="249785292"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2022 22:01:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; d="scan'208";a="697874655"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
 by orsmga004.jf.intel.com with ESMTP; 11 May 2022 22:01:15 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 11 May 2022 22:01:15 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 11 May 2022 22:01:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 11 May 2022 22:01:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 11 May 2022 22:01:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fse2FDdTzZegNyJG/KE+ulp3L5JDVldx0iCyN1SntPxNVWWpXOAnBvvo3XMI+k1NSVIyPjQpcyArnAHgGHVeHt7vWhnMdoPkRqyrpKRwzeoxB53nvB7iNXjNrZZBedJJ6UWoEno/QWyTxxdW40vE/KrTmP2BvVklrPglvu4xbqh4gt0MsT7nhe/H+glz496mfN+l8f3qm6VzG+aQ4Elc4jFmEzT0u37S6Lgpb0zbgssrcG/j4EnjGQt7rGvyKkOGlCENrVhyoFdzk9lOQXMT+uzCo7nvarfa5XQjj2o4qNVGz16290CCUPOT/VpVdCSjSD7il6KIHmXV3LPyh7ExLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UmPzthUswKbZLlMLLZR9ev+K/RnGwFkuUVq8Nct4zk=;
 b=ZyZkY0GhN2p5n+cKVyypTGz6KJzWyulTdQ4n3A1z8fsXr5+fQyQbK3OhsCIG8xM0/6gZa3Wn3FYbJq1biOxQ/cS0UlP9D68jNnExu3vuyUr10owSjx7QI6DoxSLMm3pCC7pjqbCjYaMRfPlpmxInXNwnh+eNmcWhwcAo/CaTTBsKEAPN3+0bVKLFyQH2BsuwVNF7y7BPI6SXllIkCUXgBh2bX+pQqCD9EPpYP2KIo5y3xsdOjIIsoVLYHAY9VdEv6tn+le5tSGHr522UBJFoUZLQ1Y44WE/07b41+RnIdG7O4nNHOAq9dv2Sevwq94iMeIfbLCIqL7mRqMf4JEEbMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN0PR11MB6034.namprd11.prod.outlook.com (2603:10b6:208:375::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 05:01:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 05:01:12 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH v6 08/12] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Thread-Topic: [PATCH v6 08/12] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Thread-Index: AQHYZDYuY5mdau8gXkqO6XGUIK16Ua0YO2IAgAELqoCAAH48gIAAy8WAgAAf/TA=
Date: Thu, 12 May 2022 05:01:12 +0000
Message-ID: <BN9PR11MB5276C03134A898CA9EFEE9258CCB9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-9-baolu.lu@linux.intel.com>
 <20220510152330.GG49344@nvidia.com>
 <749a7d62-3e6c-ef5c-beaf-6b7add495740@linux.intel.com>
 <20220511145319.GZ49344@nvidia.com>
 <05a68e1e-8e18-5914-ebe7-d7b1a4aaa2ec@linux.intel.com>
In-Reply-To: <05a68e1e-8e18-5914-ebe7-d7b1a4aaa2ec@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7915fe28-29cf-4d68-4a20-08da33d46fc3
x-ms-traffictypediagnostic: MN0PR11MB6034:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN0PR11MB603496F3E6D06D0875D71C818CCB9@MN0PR11MB6034.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8KqPeFGIhT0mCmAzUbTG9UxT6mrgU0gkRj9J5gCibjewQ/v7sCv9JQT1GbasaDxUHE7KRaFh9M+hgjaUiAQkT0B853IpYVhX9rwFVk2RULJ4NAbF+AsT8YBTxf5hmMO0CjeRhvcz9vTi0HDAChV0elBC9rLk4qHMXyM2JlPbQXt96i/BpKfRVCbwp9FybusnXMsLL2PgJkR+Nt/goPcqTKsbT9CyXBWHVJILnyHZxYjNb9HGzBgShcSqdmesLjoLEOeQfEdcpCRkxIJ2OaS5czBfgEViMxGdJh9vM4HpaCSQf3CKr4BKcnaCMbEvdOuU6in9UrYVTalf/GDIAqH2hZYs89O/rVuWfnQnPIBHKZfK5mBTTZcTGk9ffJH4BJY8LxoKxw9HS0r2WVd4Hx5qSfPOO6eQ5oJDjrrZWRgtM5deCRhnNjpJV6Cnqc3I8rv6/+3Dc1EccPUhCp7d4dzuLfTCpLiv5eU3a86JXApUZdu3kAZYE2WGp6etVWpY81WAsWFW1GxaIALMWuOF8EO4n8l0A8o89p3Gp08D2vv4cm/8K17eKXTwnx5w/nQw0xitw4376bP9jGg7rpJDajLhI6DBch/86iimrHwnFZHtPhbuCkTOCHEuSKh7muxoWHPdB1RVu1XfeA7cPmUfaNKhduWVe8dl+2Hlin01XAphq1R8ZC2gVrFfKKmFPuwKuKog1ywV+mtzAKRr7pW/CCvg7g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(2906002)(7416002)(122000001)(7696005)(6506007)(9686003)(26005)(5660300002)(110136005)(54906003)(55016003)(186003)(71200400001)(8936002)(82960400001)(53546011)(316002)(4744005)(38100700002)(38070700005)(76116006)(33656002)(508600001)(64756008)(66946007)(66556008)(66446008)(66476007)(52536014)(4326008)(8676002)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmVWTlFOZFRiRytUc0owbk9XV21jaTRtVnhNSkdNeWo0bFFkWWZNMXNlVjM1?=
 =?utf-8?B?V3I0dytITTJGdlZWMldGcUJqNllwSGFzT1JrRU5NS1VJSkd6Q3NIaDdhOHNY?=
 =?utf-8?B?dURlM1B1RnB6aGlhcjBoNGlMN3NWL0RERGFNRGJsY0hmd2tURk5UOXhtR1BT?=
 =?utf-8?B?bHhPdWtzWmxDWlZwYUVCY0pyejM5TXFhUmVnY1YzdGRqMnA3TXgwTTh3MGVO?=
 =?utf-8?B?S2krSEdzczE0V01WbTJRamhIRVE2K1F0VWVXelVEQVJ3ZlBkUWl2Z3JrcEtI?=
 =?utf-8?B?dmQ2VVNMUy8wemY1cklPSVo5ZGZNTUNqVXQva3FTOUZQeVBsMmcxZTduZXBr?=
 =?utf-8?B?SlRxQXVKOVVBWi93dDNwK2V3ZG1PVkZiUmc5b3c4U2tWZHdmTkdSNDFsdURN?=
 =?utf-8?B?NEJmUS85Y3V6d2czQ1ZBT0lmajZnajNIN0dmemVDeXozaTBqR0hpSXpBd2dv?=
 =?utf-8?B?a3p1ZHBiU0d3ZVFGNWg0NG1IV2kyVEEzb2k1Y056WkMzVUJobnA5Y1ZmWjJQ?=
 =?utf-8?B?YXFvbE1GeUhtaHlJZ3l5YXVsRzVJL0xCa0Z2a3ZrSDYyMlZwVENDRDZScEl0?=
 =?utf-8?B?MlNILzdUQ2g3dWJEdWo3RjlTM2xObEhQV2x4V2luOGNyeVFKZGhZR0VhSWNq?=
 =?utf-8?B?TzFMUlRmcjFPd1ZKK2RWd29BM3FDUG9BcjY1di8zUE5PUmFkK1Y4MmJEdHR0?=
 =?utf-8?B?Wmx3eURmL1VrWVRqM2hBQVBuamZ3dERCNHRHL2pBWUVrREZVZDNhQWIzcHoz?=
 =?utf-8?B?S0d6NFI5YWU4L0gybFJ2TThMMzlLS05Ba0ZSMndSZnFXRVVYVlpQei9nRkJO?=
 =?utf-8?B?VVhmWUJrWHdUajRGa3EvbXJNU1k3ZmlMMGQvOVQ5QzBwMVVkc05HVVRjOFBN?=
 =?utf-8?B?NXdxdWpBUTAyQXJ5ekdGYlYzYTFvMXZaaUFMNHFCZ2ZBTW9sTEVhNzRwcC80?=
 =?utf-8?B?RXVoV2VieU9ydnRpakRURnU5Y0hDTEJPbStmUTcvV0pOb1pDdVhMa3JRWjdz?=
 =?utf-8?B?c2svWTEwakVGbmc2bmI4bFlKYUdWYkd6UUJZL3M0NEVNN1VWMTZPYUF0Rk0w?=
 =?utf-8?B?bFU1S2RIUEl5N1RVN1FCRkRWZUxVY09QdFA2c1VKU1hkbmlDMVhJdG9NVmVB?=
 =?utf-8?B?QkcvaS9CZWFFcVVaeFdpQmxWb2ozMGNPRU50RmhnNGpwWnhVbHV6TGJ3bWtO?=
 =?utf-8?B?cDVjclluaFUvRHd5SVFTbkR4QUxWVk1sOURIZkF6NDhBK1JERVJJTnRmbStT?=
 =?utf-8?B?L3BSZUpoZHhjeU4xZmgwZEZ1V2Z1bzlvUFdlTjdiZ1BveDRMRlBYMGxPeHE0?=
 =?utf-8?B?dTd4bEpzVHFYbURhTnMwWi9mci9mbkNhaDVnSWJnd0o0dG5hbXhlWWtBMDFn?=
 =?utf-8?B?M2JoVTVMR1N0N1ZsR3duMXcvdU8vK1dNMzVXNnR2c0JWTjhvSFo1US9NNFNL?=
 =?utf-8?B?ODYrTkpzM0hyb0ZVeVRDU3NFOFN5ZE82ZEFGRlNEZkppc2FjQ2FhdzN0Y3Jy?=
 =?utf-8?B?RkFPODNjMWh4TFluRndWaGRhWlNiYW1QdWhSQldHUWdRdkdlRkFPMStGRmdB?=
 =?utf-8?B?UTlIS0F3WlM3WkRESzU5QU9aWmxuS2ZWY1FvelVMWlgyRHlNT2pmRlZYWlRK?=
 =?utf-8?B?VHZkUzY4RVR3Y3BtdjNjdUFBWjcxSTQvd2hVazhyQ0VXQzlTYTl3bEhXU04w?=
 =?utf-8?B?a3hyblA4Y0hyTW9Zd1dQblJyMkhkV0FVTXNhYVNRbGtQQWNicGQrK3JSVlh3?=
 =?utf-8?B?VXVESFZGZFAvSUttWUpnTTAzMTREYXNBcE05bEpldFJuVmU1Q05iOXIya3pB?=
 =?utf-8?B?cldoUm1mMkxNTFJhS2FBaTh0cTBiTUdsYmpLU3VDcW92UWxDaEJhNVM2dms5?=
 =?utf-8?B?NEhIV0h1cUtIZmNVZjZsdjZPQzR3dEltOVJZMTlBZ0NGTWN0Y3R4aUh0bHJD?=
 =?utf-8?B?ZTFGOVBKWUY1bzNLckV3L0NDWUs0bjZvNFhTL09rcGFBczg5cjhRaytWRThv?=
 =?utf-8?B?MjVDK1lERmFvVmpCMmc4SkJ2ekd3MThCa2FtbUNyaVhRTkIveWdXbEV3QVls?=
 =?utf-8?B?aEtKTW53QzBxQmcxQU5ERDc3MFp6dGorcVlsLzYyNlVEVEZYWHF1NTlSTVJa?=
 =?utf-8?B?Z1JuQ0RwSENTa0ZQZCsyUERvWjZrbzZFM1VyVlNkNXNQVG9sb2ptZGNHVE1W?=
 =?utf-8?B?VDd4dkJjeU5Jano1N25oczF5Ny82djNQMTcwVlBTQzBhNUJNWnUwVnhqT1FQ?=
 =?utf-8?B?ZzRWeG9OczRZUnF3eGJiT1NGd1VRVkNIcXgvb2NkUTRmSDlNaE5WY2tOTjMr?=
 =?utf-8?B?UUc2WUlqeUZTQW9QZXNNcWxoQitzWFVxUW8ybHIyUk1rMUxWVHFBZz09?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7915fe28-29cf-4d68-4a20-08da33d46fc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 05:01:12.3907 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ju834FY5TFeoD1D7N2LJzTRSiWNLmPQ85DNadJ8qBrelSnYKcz4A87Jo04dlnZKcIVEIuGQltqrgq7RQB0n24w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6034
X-OriginatorOrg: intel.com
Cc: "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Vinod Koul <vkoul@kernel.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Robin Murphy <robin.murphy@arm.com>
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

> From: Baolu Lu <baolu.lu@linux.intel.com>
> Sent: Thursday, May 12, 2022 11:03 AM
> 
> On 2022/5/11 22:53, Jason Gunthorpe wrote:
> >>> Also, given the current arrangement it might make sense to have a
> >>> struct iommu_domain_sva given that no driver is wrappering this in
> >>> something else.
> >> Fair enough. How about below wrapper?
> >>
> >> +struct iommu_sva_domain {
> >> +       /*
> >> +        * Common iommu domain header,*must*  be put at the top
> >> +        * of the structure.
> >> +        */
> >> +       struct iommu_domain domain;
> >> +       struct mm_struct *mm;
> >> +       struct iommu_sva bond;
> >> +}
> >>
> >> The refcount is wrapped in bond.
> > I'm still not sure that bond is necessary
> 
> "bond" is the sva handle that the device drivers get through calling
> iommu_sva_bind().
> 

'bond' was required before because we didn't have a domain to wrap
the page table at that time.

Now we have a domain and it is 1:1 associated to bond. Probably
make sense now by just returning the domain as the sva handle
instead?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
