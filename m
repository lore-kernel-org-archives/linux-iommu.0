Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E0A6A328
	for <iommu@lists.linux.dev>; Thu,  8 Feb 2024 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707380471; cv=fail; b=SQrIfnrbg/Z3PhSpbYguOoRBDKHhsXwPpni2ZoA3SW9c1jyNfKVnMgvUOR+WwF0a661cn+hNb4DymWwDtdWDbLeu/Re++pYTQVpGLrjAu1Afda2nGLKk8nAC0JqPdXzqc43/j6PJ/3JLKSrEbbm7VOAn9nY6TZzDp/hT8I/CHKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707380471; c=relaxed/simple;
	bh=bCm1VzSEq+X+x38I6RsryvcML66keejJi9oQ4aW+j7E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HyU4hPt2XW1KFP7kMFw5XP8qitWiR6qkpoUKGOuMBi//YJvOiaJEV7Z8MKwqX08Zcb4IHPGHp6ZAc+cKdAennjez96cXrih0N6gEy2JU/nlS7+ntcSeNbyjMLjGGexQRtcQaxSg/2mUxl8xxFbx4tN2B45j2TtsufVQQbIhqw1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NzW6NckC; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NzW6NckC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707380466; x=1738916466;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bCm1VzSEq+X+x38I6RsryvcML66keejJi9oQ4aW+j7E=;
  b=NzW6NckCiTOz00H21FM606ZrwTvxtim49tvDCV5kxptgJL4ZZEealcoa
   trmPPdk3rs3gljd0me9L34P6O2i1G0uGHj5CzlrlwdinmA6k1Tnemjik4
   E9RxRG/iPJL9Yg9L8r9jqXtzHaMCz4KPovu18Nd59F1RnrbWZMoM/b/2t
   PfXF7oonPuntaV5IiXCoYeZtdegRredxjmMBOuyLEE52TSdeyqYdfVJUZ
   7f5MwBvvzuDCfZE2oyuR+xomd2uLy9fqSuHykO4JXp8JE7jIQKNUBU2Lm
   CDvpdem1+82kRzFuIzfUJg/COuvkbgYRVRIUOzGl+sgsmovPvJ3AuspQ4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="4953045"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="4953045"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:21:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="39014311"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 00:21:04 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 00:21:03 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 00:21:03 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 00:21:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1twFpHNc2t1yN1r1copxPtLTeFOwzexRLA7Bqk/s96cWezFGyZff4vEXkFSnYMoVMV0Q499+sT0BPd74g8URhev0LKzS6IKO0hOzZqiGvTUGMDarnbQxT1MA0BmXmP6nts1+0x/DKFUU4RbHzv/kjLosqSPGvGTYG2RRqzj7IqxdcuomX6T9N8Lj0m3DDy6C73ZfHqy+lwH0qQN0+Vi1sRyyW/Rj1Vr79E0B275Nk4+MbY8yaGpX9UO8bazs1nhJMW89BSl1NiYgNRXvCgh1Dv9Uy0KecjqJeRrsarPdKWl+e783Z5XJe10AUhZOVIJwHJBPiAnLV/1ULNU3ryjhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCm1VzSEq+X+x38I6RsryvcML66keejJi9oQ4aW+j7E=;
 b=hlaKvI7VZT/DcvmqT5gchs0P+UtLfHNCFSkoHJusZEmuGFlPkR//M05QRqYa3OvL51D/39mQU02TtfW7pu+NqxjgOvP9DcqPfrTJpyLrySfPchPJLI8mEEz6CzJwzBlcuQrRkLY4lzxq80byCdgR6QT0GeVt3lBUkc/mltQ7/TWvKaUO9D8zfL48IJSFGF8ELDisgbB5ejNckfhGMQfKdHL72tCsdaes8V7D0cQOOtsadUARpsHqYT0iGr8A453HjLT4765wxbYyuylRbtZ4g/yDszrkbd64cd4+mStaBMIlwgvXi836M37fAHhPvf4E+BNMe+/Qtu/LV3dCmNgDCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL1PR11MB5493.namprd11.prod.outlook.com (2603:10b6:208:31f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Thu, 8 Feb
 2024 08:21:01 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7249.038; Thu, 8 Feb 2024
 08:21:01 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Lu Baolu <baolu.lu@linux.intel.com>, "Avihai
 Horon" <avihaih@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH v1 0/9] iommufd/iova_bitmap: Bug fixes for IOMMU dirty
 tracking
Thread-Topic: [PATCH v1 0/9] iommufd/iova_bitmap: Bug fixes for IOMMU dirty
 tracking
Thread-Index: AQHaVdylW2H+WWhhK0WtuACwzLIjnLD9pKqAgAAFMICAAOtPEIAAHpiAgAFt5xA=
Date: Thu, 8 Feb 2024 08:21:01 +0000
Message-ID: <BN9PR11MB5276EE3DE0C5A923C9C077E68C442@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240202133415.23819-1-joao.m.martins@oracle.com>
 <20240206181333.GE10476@nvidia.com>
 <91aee5f5-82ce-476a-bb53-cc65c369db2c@oracle.com>
 <BN9PR11MB52760A86CB0672C0A646B6BD8C452@BN9PR11MB5276.namprd11.prod.outlook.com>
 <b17fbaab-8d35-4084-947a-c955e9f1a541@oracle.com>
In-Reply-To: <b17fbaab-8d35-4084-947a-c955e9f1a541@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL1PR11MB5493:EE_
x-ms-office365-filtering-correlation-id: a1939ce4-3b77-4d8f-d69e-08dc287ee2e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5BGFvytKwmqw6bxoBMzFsxzVp1wOHVMYoXu3KpB8Dfb6dipZI9P/nFRn+TmwwMP/kaEG0dWb/9e0sHdegFSrzzY6cM+dkfd/zQv72l30VP1LIWMIW9zVWP5HLeHAJ22S8Fh37yz0tVE8OZSo5MUjBxEXKOPhaqBpD8V2w5ynmwVSBK5ciQngIvGKtaQNd4PZ4ZEMQB2jOxoz50HZrDpxqGfR0Z087rA2RR2+XvC/ckhDBJkAC+5Wd3PPhxPtfn4HS0+mkZ2C5CHQek5j47M8ORDTERnvJ5ORhKo6TrIdpJ6KQy+NTKCPPsDzrWt9pT6TRibbmFmnFwyrrqDqRbveTYWtXRneyRLPKNV9BFZNKmavRS+8TzKWG2W4FtIZNWY+mHamdS3ZJfPJzEaMGLhXoP+KEWT7n2/UFGK0eiz4knTI5DewlYQx2SOinoVIp0tc4vgw+vaNqITEiCBRkV+jYp8N02rgKBSwrn0WXiopqjVFjIDxdamTExBM6Yxpr77p3GZaLMo8hDsnRiYO6rJjYSHXZquBA763Hm4wo62n4f+nyQ1UbKJps/5Apoe4j/P4MqV8XhK7f2bFTlpu/L4+H4G11tLLRY00nRjFISJ7vq6GAdRq3Tcfz1k/rIBv24gN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(55016003)(41300700001)(53546011)(6506007)(7696005)(71200400001)(478600001)(76116006)(5660300002)(52536014)(2906002)(316002)(54906003)(64756008)(66946007)(66556008)(66476007)(66446008)(110136005)(26005)(9686003)(33656002)(38070700009)(38100700002)(66899024)(86362001)(4326008)(8676002)(8936002)(122000001)(82960400001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UCsyTXoxb2RjQWg5MVFtUU8yNEdSb0wwQldRRGF6dVFTMTNFQjNObG90d2dH?=
 =?utf-8?B?T1VIOFBNQkw5aW0waXhxMlc0djl2cmM5a2JpV3dCTnphM1VFRm9nYkRJZVpF?=
 =?utf-8?B?dGk4RzkxVzRrRkwxdlJyRE10TmJoSEJRVEJxbkpJdDN5c0hEOHVSOWE1VnpT?=
 =?utf-8?B?SnZRaFBUaXBGa09QeFVXeUQwN1dadlFVOVlIVnV2VDdYQ21Vc3N2eEhvS3FP?=
 =?utf-8?B?WE1GL0NneTZXdnQzemZ0YkZuZEhwTmgxbVpyejZ4ejcwTTdRK0p2ZGlhRThK?=
 =?utf-8?B?OFJQYnlnV3Y4UXZXaTVqcUFFMGw3Q0FQY2RjbEkrRk1TMUZjUXkyb2hTWTNa?=
 =?utf-8?B?QS9KWGhUN0hld0NWalhrQTRkYjY0SEVQRkQ4RHppRW91Vk1mUWRMbURmQ293?=
 =?utf-8?B?SXE2UkFGTDc1SEE2SDU2d0xhTjUrNmFxWkp1ZGZ2QWt3WDVSeW9qMHJLb0lF?=
 =?utf-8?B?RnN1RzJoRThSQ0NGbmpsR0dVMjFQVGZ4cUxyeVJ6dnhuSXp3am84Qlk0Yk50?=
 =?utf-8?B?eE1KZEtvL1doeFFzMmFsNHY0cmdDcXMzRkFhdVp1Q1VuWEh4NE1DNHZ6c083?=
 =?utf-8?B?SlJJejBvOHI5bTFMTWdlL2RBN29GcTNqYmdiTjZGYzdKNExTS0x3R1NwcS9T?=
 =?utf-8?B?L3ordkNNa1A3Um1RVDNUMUNUa1lONTIzeS8rMlUrcUtteXhGQUxuRWxxWVVN?=
 =?utf-8?B?TUliL0JPUmdhM3oxMm51dSt2UERldlJPcHVFTlVrOE5TNE9HbmFvUi9xZ2E0?=
 =?utf-8?B?cUFHeDFjcnNhN3JFb1F6bHFHUGxYVU9YNkVWbDllZGlnbVJZcTF3eldnZkZa?=
 =?utf-8?B?ZGlSUDRoTGdTY3oyWGhyQmFjZjdFVDhrSUpPaUVxVGRYaWQ5L3VFTDFHVFFS?=
 =?utf-8?B?VUlWLy9VdFFIMUoxTUM4T3Z6SkltOTRDQld2eDR5ZGM1UXR5Wk5zOVY0cjdV?=
 =?utf-8?B?WDN1UGcvemd4NUNpc0M1RTI3MXdaYWpKUkJ2bHl5U0VuTzZPbzB1Mys3aHlj?=
 =?utf-8?B?SXJhRWFGazBOeWtKOXd5VjBlWXFXTnNaZmorUTN5bFdzYzhHcHUvWU1jaElI?=
 =?utf-8?B?ampBQU1Wb0l2czFaTmpvZWVobjhHTjV1WlVGSGk3UXgzT2FwazF5a0l5NzE3?=
 =?utf-8?B?aG51OEdRRWdLVjhNd1g4UVJGa2NzRFg5TXFrYTVhU1lXVmJBK1NtNTdBcGRP?=
 =?utf-8?B?dmxKUkd0UWxKSW5zeWJQVENwL2pUckYwVTNYSXFOVWFhQ01pTjVyOHhjQStO?=
 =?utf-8?B?YXdxM1puSWlZbW5KNXhMSTRNbnoyMGozMkVOUkRZclRkSVZiY3dHT2hPMWpy?=
 =?utf-8?B?d1dXWDh3SmRtZCtNTkcvVi9TaGpyeW5EUGF2VlIrdi9qVzJHMW1Qak5HVHds?=
 =?utf-8?B?dG1IQXp0VWFOUTQ4ODRsbHBJV2JxbVIzek5SbHVaeHNIcnJ5K21FbWtoTTN1?=
 =?utf-8?B?Tk1ZWWVzaE40TjFwUVdxZ3Q1TmdRNjFRdGgzV1d2bUhjek1CcmtiU1JKSWNv?=
 =?utf-8?B?bTNKWkh1cUgwVVBVN2d1L1FWNW8wR3U0RkJZYWpnVXR3eGxlaXkrcWZtMGEx?=
 =?utf-8?B?clZoSmZBSS9xcUl2dmFsY0h6K3J5V3oxSkVTUERyZW85NlQ5OFFhMEZMbmNX?=
 =?utf-8?B?UVhYaUhEc29oVjE0eFlycmQ4eklxVjJHUGVPNG1DU0d5NnpLU1o3bUZJTnZx?=
 =?utf-8?B?WVVOcit4WUFpT3ZXMmhxZEd0Z3liSXhsNnZyRDhQcTlIa3RYUHhoQ1VPckNK?=
 =?utf-8?B?SGFWdlBRRU5IUmVSTWNwaHFHN0w0eCtpSm5vQU9Bd01jbCtBQVp0RHpnWUxH?=
 =?utf-8?B?c3UrWk9ydlZCQVZmbVJaZ1g0bklLRzAzM28ybWV5a0R4b2ZheVlaNExqd0l4?=
 =?utf-8?B?K2pLcUNpZHovdnhuZUs0WVdrWWxnUDNiZWFzNGxFWlZuN1JJQ05MRVQ4Qm9D?=
 =?utf-8?B?MXR6RVZFQ001Ri9IWG1FdllwWnlOdkZDRmJNOGRNWXArelBPRkNHQXR5MnlT?=
 =?utf-8?B?UmUrVkNwYS9TSi9pK21tN2tjSjFjRzZmUGJ5OEh1c0VoMmRmUDhwbmNVVmtp?=
 =?utf-8?B?Ukxob3ZjbnF0QU4zOXpOMHcvOXlqL1BVZG5pQlJtRVVkMXFnU0d1YjFxWHc3?=
 =?utf-8?Q?Hbar+n6z+pJJnwTaoExXTjjA3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1939ce4-3b77-4d8f-d69e-08dc287ee2e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 08:21:01.7364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4PBtFfrVGq3jI5aGnGPG1xut5PVTPSZe0ixnVRVSvuqNRp2m5YzAqUYu+cMMJgzRmreTTH9NyTK4pzdMHwlqWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5493
X-OriginatorOrg: intel.com

PiBGcm9tOiBKb2FvIE1hcnRpbnMgPGpvYW8ubS5tYXJ0aW5zQG9yYWNsZS5jb20+DQo+IFNlbnQ6
IFdlZG5lc2RheSwgRmVicnVhcnkgNywgMjAyNCA2OjI0IFBNDQo+IA0KPiBPbiAwNy8wMi8yMDI0
IDA4OjQxLCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogSm9hbyBNYXJ0aW5zIDxqb2Fv
Lm0ubWFydGluc0BvcmFjbGUuY29tPg0KPiA+PiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDcs
IDIwMjQgMjozMiBBTQ0KPiA+Pg0KPiA+PiBPbiAwNi8wMi8yMDI0IDE4OjEzLCBKYXNvbiBHdW50
aG9ycGUgd3JvdGU6DQo+ID4+PiBPbiBGcmksIEZlYiAwMiwgMjAyNCBhdCAwMTozNDowNlBNICsw
MDAwLCBKb2FvIE1hcnRpbnMgd3JvdGU6DQo+ID4+Pg0KPiA+Pj4+IEkgaGF2ZSBhIHNlcGFyYXRl
IHNldCBvZiBjaGFuZ2VzLCB0aGF0IHByb3ZlZCBhbHNvIGluc3RydW1lbnRhbCBpbg0KPiA+Pj4+
IHJlcHJvZHVjaW5nIHNvbWUgb2YgdGhlc2UgY29ybmVyIGNhc2VzIGluIGEgbW9yZSBwcmVkaWN0
YWJsZSBtYW5uZXINCj4gYnV0DQo+ID4+Pj4gd2l0aCBJT01NVSBkcml2ZXJzIGluc3RlYWQsIHJh
dGhlciB0aGFuIElPTU1VRkQgbW9jayBJT01NVQ0KPiBkcml2ZXIuLi4NCj4gPj4+PiB3aXRob3V0
IHJlbHlpbmcgb24gVkYgc3BlY2lmaWMgYmVoYXZpb3VyLiBUaG91Z2gsIGl0IHJlbGllcyBvbiBi
ZWluZw0KPiA+Pj4+IGFibGUgdG8gbWFwIElPVkFzIGFzIGRpcnR5LiBUaGlzIGlzIG5vdCBpbmNs
dWRlZCBpbiB0aGlzIHNlcmllcywgYXMgSQ0KPiA+Pj4+IGFtIG5vdCBzdXJlIHlldCBpZiBzdWNo
IGRpcmVjdGlvbiB3b3VsZCBtYWtlIHNlbnNlIChvdXRzaWRlIG9mIHRlc3RpbmcpLg0KPiA+Pj4+
IENvbW1lbnRzLCBhcHByZWNpYXRlZC4NCj4gPj4+DQo+ID4+PiBJIHdvdWxkIGxvdmUgdG8gaGF2
ZSBhIHRlc3Qgc3VpdGUgdGhhdCBjb3VsZCBkcml2ZSByZWFsIEhXLiBJIHRoaW5rDQo+ID4+PiB0
aGF0IHdvdWxkIG1ha2UgYSBiaWcgaW1wcm92ZW1lbnQgdG8gaW9tbXUgZHJpdmVyIHF1YWxpdHku
DQo+ID4+Pg0KPiA+Pg0KPiA+PiBJZGVhbGx5IHdlIHdvdWxkIG1lcmdlIHRoZSBzZWxmdGVzdHMg
dG8gdXNlIHJlYWwgaHcgZG9tYWluIHJhdGhlciB0aGFuDQo+IG1vY2sNCj4gPj4gZG9tYWluLCBh
bmQgc2tpcCB3aGF0J3Mgbm90IHN1cHBvcnRlZCB3aGVuIGhhcmR3YXJlIGxhY2tzLiBTcGVjaWFs
bHkgYXMNCj4gd2UNCj4gPj4gYWRkDQo+ID4+IG1vcmUgYW5kIG1vcmUgZmVhdHVyZXMgKElPUEYs
IERQVCwgbmVzdGluZykgYW5kIHVuZGVybHlpbmcgdGVzdGluZywgaXQNCj4gc2VlbXMNCj4gPj4g
dGhlDQo+ID4+IG1vc3QgbmF0dXJhbCBwb2ludCBvZiBjb25zb2xpZGF0aW9uLg0KPiA+Pg0KPiA+
PiBEaXJ0eSB0cmFja2luZyBpcyBhIGxpdHRsZSBzdHJhbmdlIGJlY2F1c2Ugb25lIG5lZWRzIHNv
bWUgc29ydCBvZg0KPiBibG9jay9wYWNrZXQNCj4gPj4gSS9PIGRvbmUgdG8gaGl0IHRoZSBwYXRo
IG9mIGhhdmluZyBzb21ldGhpbmcgYWxsb2NhdGVkLCB3aGljaCB1c3VhbGx5DQo+ID4NCj4gPiBz
YW1lIGZvciBpb3BmDQo+ID4NCj4gPj4gcmVxdWlyZXMNCj4gPj4gc29tZSBkcml2ZXIgb3BlcmF0
aW5nIHRvIG1hcmsgdGhpbmdzIGRpcnR5IHBsdXMgcGFnZSBhbGxvY2F0b3IgbHVjayBpbg0KPiBw
aWNraW5nDQo+ID4+IHRoZSByaWdodCBwYWdlcy4gU28gdGhlIHN0cmFpZ2h0Zm9yd2FyZCB3YXkg
dG8gbWFuaXB1bGF0ZSBhbGwgdGhpcyB3aXRob3V0DQo+IGFueQ0KPiA+PiBvZiB0aGlzIGNvbXBs
ZXhpdHkgb24gcmVhbCBoYXJkd2FyZSBpcyB0aGlzIGlzIHRvICJtYXAgYXMgZGlydHkiIGFuZCBj
aGVjayBpZg0KPiA+PiBzb21ldGhpbmcgaXMgbWlzc2luZy4gSXQgcHJvdmVkIHVzZWZ1bCBpbiB0
aGVzZSBidWdzIGFzIEkgY291bGRuJ3QNCj4gcmVwcm9kdWNlDQo+ID4+IHRoaXMgYnkganVzdCB1
c2luZyB0aGUgdGhpbmcgKGV2ZW4gc2hhcmluZyB0aGUgc2FtZSB0ZXN0IGFzIEF2aWhhaSkuIElu
IGFueQ0KPiA+PiBjYXNlLCB0aGUgZ290Y2hhIGlzIGNvbnN1bWluZyBhIG5ldyBwZXJtIGJpdC4N
Cj4gPj4NCj4gPg0KPiA+IGlzIHRoaXMgc29tZXRoaW5nIHdoaWNoIHZpcnRpby1pb21tdSBtYXkg
Y29tZSB0byBoZWxwPyBlLmcuIHZpcnRpby1pb21tdQ0KPiA+IGJhY2tlbmQgbWF5IGJlIGluc3Ry
dW1lbnRlZCB0byBmYWtlIERNQSByZXF1ZXN0cyB3L28gcmVseWluZyBvbiBhDQo+IHNwZWNpZmlj
DQo+ID4gZGV2aWNlIHRvIGFjdHVhbGx5IHRvdWNoIG1lbW9yeS4uLg0KPiANCj4gSSB3b3VsZCB0
aGluayB0aGF0IHlvdSBkb24ndCBuZWVkIGEgc3BlY2lmaWMgSU9NTVUgbW9kZWwgdG8gaGF2ZSBW
TU0gZG8NCj4gZmFrZSBETUENCj4gKGFueSBtb2RlbCBzaG91bGQgZG8gSSB0aGluayB3aXRoIHRo
ZSByaWdodCBWTU0gY29kZSkuIEJ1dCB3ZWxsIGJ1dCB0aGVuIHRoaXMNCj4gYXNzdW1lcyBndWVz
dHMsIG5vdCBhcHBsaWNhYmxlIHRvIGJhcmVtZXRhbC4gVGhlIGlzc3VlIHdpdGggZG9pbmcgc3Bl
Y2lmaWMNCj4gSU9NTVUNCj4gbW9kZWxzIChiZXNpZGVzIGluY29tcGxldGUgZnVuY3Rpb25hbGl0
eSBpbiB2aXJ0aW8taW9tbXUgdnMgYXJjaCBvbmUpIGlzIHRoYXQNCj4gaXQNCj4gaXMgdGllZCB0
byBhIHNwZWNpZmljIElPTU1VIGRyaXZlciByYXRoZXIuDQoNCnllcywgdGhhdCdzIHRoZSBsaW1p
dGF0aW9uLg0KDQo+IA0KPiBJbml0aWFsbHkgSSB3YXMgdGhpbmtpbmcgYSBzbWFsbCBrdm0gZ3Vl
c3QgY3JlYXRlZCBhbmQgaW5zdHJ1bWVudCB0aGUgVkYuDQo+IFRob3VnaA0KPiB0aGVuIHRoZSBs
YXR0ZXIgd291bGQgbGlrZSB0YWtlIHRoZSBtYWpvcml0eSBvZiBjb2RlIGluIGdldHRpbmcgdGhl
cmUuIEFuZCBpdA0KPiB3b3VsZG4ndCBsb29rIGxpa2UgYSB0ZXN0IHN1aXRlIGFuZCB3b3VsZCBs
aWtlbHkgYmUgYmV0dGVyIGFjcXVhaW50ZWQgZm9yDQo+IHNwZWNpZmljIGNhc2VzLg0KDQpyaWdo
dC4gYW55dGhpbmcgcmVxdWlyaW5nIGEgZnVuY3Rpb25hbCBndWVzdCBpbmNsdWRpbmcgZHJpdmVy
IGFuZCBzcGVjaWZpYw0KVkYgaHcgY2Fubm90IGJlIGEgZ2VuZXJpYyB0ZXN0IHN1aXRlLg0KDQo+
IA0KPiBGb3IgdGhlIHB1cnBvc2Ugb2YgY29kZSBjb3ZlcmFnZSAob2YgaW9tbXUgZHJpdmVycykg
d2UgY291bGQgcG9zc2libHkgaGF2ZQ0KPiB0ZXN0DQo+IG9wcyB0aGF0IGluc3RydW1lbnQgdGhl
IG1pc3NpbmcgaGFyZHdhcmUgaS9vIHBhdGggdGhhdCBhIHJlYWwgUENJIGRldmljZQ0KPiB3b3Vs
ZA0KPiBkbywgdGhvdWdoIGRvbmUgaW4gYSByZWFsIGh3IGRvbWFpbiwgbXVjaCBsaWtlIGhvdyB3
ZSBkbyB3aXRoIG1vY2sgdGVzdA0KPiBvcHMuIEkNCj4gZ2F2ZSB0aGUgZXhhbXBsZSBmb3IgTUFQ
IGFzIGRpcnR5ICh3aGljaCBJIGd1ZXNzIHdlIGNvdWxkIHJlc3RyaWN0IGl0IHRvDQo+IElPTU1V
RkRfU0VMRlRFU1Qga2NvbmZpZyksIEkgZ3Vlc3MgZm9yIElPUEYgb25lIHdvdWxkIGZpeHVwIHRo
ZSB1c2VyIGZhdWx0DQo+IChtdWNoDQo+IGxpa2UgaG93IHdlIGZhdWx0IHdoZW4gd2UgcGluIHBh
Z2VzKS4gSSBoYXZlIHNvbWUgaG9wZXMgdGhhdCB0aGUgc2VsZnRlc3QNCj4gbW9jaw0KPiBkb21h
aW4gYWRhcHRhdGlvbiBpbnRvIHJlYWwgaHcgZG9tYWluIGNvdWxkIGJlIGRvbmUgKGJ1dCBzdGls
bCBuZWVkIHRvDQo+IGF0dGVtcHQNCj4gYXQgaXQgb25jZSBoYXZlIHNwYXJlIGN5Y2xlcykuLi4g
dGhhdCB3b3VsZCBjb3ZlciBhIGh1Z2UgcG9ydGlvbiBpbiB0ZXJtcyBvZg0KPiBjb3ZlcmFnZS4g
QW5kIHBlcmhhcHMgaGF2ZSBhIHRvb2wgZm9yIHRoZSBzdWJzZXQgb2YgdGVzdCBjYXNlcyB0aGF0
IHJlcXVpcmUNCj4gc3BlY2lhbCBoYW5kbGluZyAoZGlydHktdHJhY2tpbmcsIElPUEZzLCB3aGF0
IGVsc2U/KS4NCg0KY291bGQgYmUgYSBmcmFtZXdvcmsgaW4gaW9tbXUgY29yZSB3aGljaCBjYWxs
cyBAZG9fZG1hIGNhbGxiYWNrDQpwcm92aWRlZCBieSBpb21tdSBkcml2ZXJzLiBXaXRoaW4gdGhl
IGNhbGxiYWNrIHRoZSBkcml2ZXIgc3BlY2lmaWMNCmNvZGUgY2FuIHdhbGsgdGhlIHBhZ2UgdGFi
bGUsIHNldCBkaXJ0eSBiaXQsIG9yIHRyaWdnZXIgSU9QRiwgZXRjLiBLaW5kDQpvZiBhIHN3IHBh
Z2Ugd2Fsa2VyLg0KDQppdCByZXF1aXJlcyBzb21lIGZpeHVwIHRvIGFzc29jaWF0ZSBhIG1vY2sg
ZGV2aWNlIHdpdGggcmVhbCBodyBkb21haW4uDQpPbmNlIGl0J3MgZG9uZSB0aGVuIHRoZSBzZWxm
dGVzdCBzdWl0ZSBjYW4gY2FsbCBub3JtYWwgaW9tbXUgQVBJIHRvIGdldA0KZG9tYWluIHByZXBh
cmVkIGFuZCB0aGVuIHRyaWdnZXIgQGRvX2RtYSB2aWEgbW9jayBkZXZpY2UgdG8gDQpleGVyY2lz
ZSB2YXJpb3VzIGRtYSBwYXR0ZXJucy4NCg==
