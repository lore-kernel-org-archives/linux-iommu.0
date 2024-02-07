Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B0420337
	for <iommu@lists.linux.dev>; Wed,  7 Feb 2024 08:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295284; cv=fail; b=IArpRDmui4pEgBD4vtFrjzu280FX5Yo1dUGe2pJqdQy6C6CoPXpqw2QAbPtbDXtb5ad3PZ8NYw8ALO5yAiYx6TDStXonSmTf5SskQrvayXVWyEqfgnObk9ZltvvmeaKitKSEw3bO1X5AiE5gsqkMEuqGCC1++Q2XhwcXhJjd4V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295284; c=relaxed/simple;
	bh=eGhxf+u12mqgp6Jdk4cNtC3/iGm1zbUG4mU/wN34xu4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kG8i7ij/eEj7fCgr5pfF4nabBp8Vn5PYerPW3sPIsWM1D1jL4F9lOlsTyoHvQ8TsCXJt7JAwNBSjL2i0N0iiU/GCgVsRFunzgk1lwKy6oXBc41/vIYSIZh2ZfYBCLaquoDfqipMwLhmO8h0XWfMdAmJJPK0se9tHWpCNBtm1uvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hlGsW38W; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hlGsW38W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707295282; x=1738831282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eGhxf+u12mqgp6Jdk4cNtC3/iGm1zbUG4mU/wN34xu4=;
  b=hlGsW38WVBbZNDrY7kNu3ad8Xi46n2YHk0/LIU+XjmsXq5u4Vu2HyREa
   7jSEf0FVw1gbdI7UOnF1D3S1MClKP11XWNb547HWUPXHfSW+YfyF9BAXY
   iwyWBNqyphrU4dI8MYUz+7/CHcpCyjKL2LxRfbCRK9XUlutg5bz6OJB+z
   b3Bv3N/eybdkR7Unc5CweYdmjnRlxCKdbh0s+d1sH/H3pL9ip9ZZeXqXG
   tngi4pF2wZkM4qoltFqpPhHeCfSd8QGvF9t7lhaVBT0WseFGkHqMp9n+Y
   33yNsmpd9YdwHQOKwMLzWddlhF0iiXR8nP1JjpXzmnxLtxgEVxl3Uz5wF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="4756139"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="4756139"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 00:41:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="5888220"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2024 00:41:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 00:41:16 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 7 Feb 2024 00:41:16 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 7 Feb 2024 00:41:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXrjAQLS2rTH6qh8XObMcJQuBZocap0cP/Vj6DoUOEe4TV3c8sM1c1uk//1DzfEiq2kLRLaT6DeeFVSjsK3BjRBLX6V6h1sTPHmsrIGIcg62QAl7xq65/PlNk4l8VYqWjnYwhFcjEhWAq9Fi04klrdf6kisBJiB4dsHK4tkMMoZoW7GzMQXvoQI0o0L4ExkrDqDCXBH5gKcO1ItM7HLvY5Q0urM/U2YWUIiBRtaiZiG60kGZrOcOox00UfgARrnRM7OI8C06Ag8KQPWlGSjrjH9fnbsSSQvLqLpNwehZC0OH1hSLVWDMiKl4KSNAPFNZmOIwtc33pV6t/YykPC2hGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGhxf+u12mqgp6Jdk4cNtC3/iGm1zbUG4mU/wN34xu4=;
 b=VLRJoPxneYagAnNN/oE+3nJdmHMSlYRuolCsYPquKPU1jAfKCcg/pkT3QEH1xYZKeyZjH5km5F7Jds0NOe+msqPpwJ5x2VMhEpGeApgi7dWwNCN8w1NJZQmDqPPg8n35+KrSvNTBydnxRzpBGZkDrHJt0i/bKuaJbiX/fV46tVnUhUe45EKQKVsKKROWcUj+Ks7X/j5CIR+35KfFc0Qt7zoNz3s1F+cU19S2mJbVVAWMJG24y61wrQpFOehbKlBfAZuRAp28GyVafSbjAGxE6wrPNQpX/pNWzu0oI3yRs3LcDD601cCqpJkHARjx00zQ8un1+TNtlJwGWn8YF2lsaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB7345.namprd11.prod.outlook.com (2603:10b6:610:14a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Wed, 7 Feb
 2024 08:41:09 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 08:41:09 +0000
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
Thread-Index: AQHaVdylW2H+WWhhK0WtuACwzLIjnLD9pKqAgAAFMICAAOtPEA==
Date: Wed, 7 Feb 2024 08:41:08 +0000
Message-ID: <BN9PR11MB52760A86CB0672C0A646B6BD8C452@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240202133415.23819-1-joao.m.martins@oracle.com>
 <20240206181333.GE10476@nvidia.com>
 <91aee5f5-82ce-476a-bb53-cc65c369db2c@oracle.com>
In-Reply-To: <91aee5f5-82ce-476a-bb53-cc65c369db2c@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB7345:EE_
x-ms-office365-filtering-correlation-id: b1fcfcdd-7dbb-4a71-2238-08dc27b88814
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JW/51HXVfjBNiRVwalWZA0tppK3fKKm8xT1CoXHTJqegOw1WZHKMXll/cPZeTIeHnT7wL+6F3YIFl8PmKc6wR/w1NYO/NMt2gNyNxNVwfU67e9iyCbdyeduQMTM38TeQ1pDVGXfde/VDvSPMYL33wh/35XeG3XqYgZuvgq70EeZcKI6dRNfKY9MVudvLGQhmOaC51vbaaWmMHW7UFsVWrbf+3zeXz/XkUiS9aGY5yRK/lAvhf4JXrkA2N+yeeqN1635l7kMvbSGNCQtuHTOfXt1/G6CFv5YOV39MeUlRvaniaR6boZ3M15sjJCSvCH3Zs5RAwpSiUJAsYjjpnm3cflgIVstT+Fh8oNDeTNz78zLDdwnvYSS/GtaWdN6NaaAPbvniPvJFhMHx1Gws7FSML7ENRUvr7Uv7Tiz4w2kWYKq5r+lDrubYAphsnjnvJwQ8BOJEn2kU4+t/+9e92q4U8NNiR/WaOyFeO4QBr/xmjV5qDivfoOfffzv3Z9+Yz8SgSlKE2btkxhlRrsODZwvAfR7iRa0FafOzvXXARzOD7s2Sacxrt9wH+g7K3JkZW1RWkZLgrdvBau71aaNyeqZoxC/21V8oyxu2jNO8ossxogEYr6o/pyyAVfwaUFl6Fw+v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(39860400002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(66899024)(41300700001)(66476007)(76116006)(66946007)(66556008)(64756008)(478600001)(66446008)(110136005)(316002)(53546011)(7696005)(6506007)(9686003)(33656002)(54906003)(71200400001)(8936002)(8676002)(4326008)(38070700009)(122000001)(82960400001)(38100700002)(26005)(86362001)(83380400001)(5660300002)(52536014)(2906002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmtrWElWaDNhNWJoeklGL0RCWXpDQnhXNzF2U1g1ejR6UkJUSGdEazJ5WjJo?=
 =?utf-8?B?Z2g5bGl4MU1EZTBmUWhyOGw0eCtrVDBha216Q1AzcVhnTm5keXlKdmF4eU53?=
 =?utf-8?B?OWJHS1lHelNaWU15VVl0WGZWUXczb1E4a09yM1VUcDBNSC9GTW0zSlQ2ZE1K?=
 =?utf-8?B?MWt2QlA4VFlFejE4eGVJWmVHcUU3a3ZydFJVdVcwQ2UxRkoyMk1na0tGNVNs?=
 =?utf-8?B?TWxzVnRWdm4xU1E4akc0c3ozbXYyN3VGeDE4TmZubDE2cFZXUWNEZS9GeE9E?=
 =?utf-8?B?bVRYeWRkRzVYSDhkTDJwQzFiTDZDS0lNUTltUWRQZTlXaTZjK3dheVl0UEp6?=
 =?utf-8?B?dHBxVW9haTJMSmp0d3JsOXdqbzRZekVIZ3ZzWHNVYmN3bnJ1dGsrQ1BuVjZX?=
 =?utf-8?B?UjIyTEtuMytrYnRlZ2xFbjlCT0s1dmxkRy9YdlBpSFg0S2JubTNlbWllVlZC?=
 =?utf-8?B?Ty8wSDBjb2NOb3hDTHM0RUxJNjRtemhlN05jWXJOY01Dd0FIbmVBK2oySEtS?=
 =?utf-8?B?QkdSbTlwZVdkY1ZYcVF0d0EweHF1UDFjS1BqcFpWWWRqN2RWR3IreTA2N0p4?=
 =?utf-8?B?MkNrd3p3TlQ5YWNkdFlUT0h4RW5reXNRQ1haYlprVCtidUNZMFJ5TUxYMW84?=
 =?utf-8?B?aTdBU25adUVsbG9MamxIUHgvTnFmTTVyVm9tMmJoaXBkUERZakJwZW13blZR?=
 =?utf-8?B?NDdxWnpkallOeVpHS3IvUEtsR2JoeEVCR1NNa0xUa0dObWNtbEhobGI1bWpj?=
 =?utf-8?B?Q3E3OXhJcHpzWG5MWkpGOU5WbGpjeEZlUkVGMy9PWDNqVWJ4L0Q5VGc2Y2FN?=
 =?utf-8?B?V3N5TnJ1V0hFNmxFcFY0SUFrSytqdit5NUZyc0g4VythNHBtVmFYT2N1R2hh?=
 =?utf-8?B?WjFndFNxSWg3Mmg1V2kzVzB3Vmx4Rk9aVFpuU09VSytnV0cydCtoS3Nodlpa?=
 =?utf-8?B?cGtxZWhoMWJNNE1UaGRUZDlPaDFjMkNHd0NvdUthbSsxSGFDUUVmNlg5NWJs?=
 =?utf-8?B?UWcwTXAyajZSNStWbzRUb1hjTHVSanIxdG5Rb0dzWEdJVVFjeDJrVk5yVGJl?=
 =?utf-8?B?YU56RnlQMFlHSlVFbkIrYWsvR3d6N3AzTWV1TFhpNk9nRUljeHgxck9XOGFK?=
 =?utf-8?B?Qkp3cGtRZlNoYnpyZy9haDdHd0dENE1zQStjVENMR1Uvcm1lNVgzUWwxaEcw?=
 =?utf-8?B?Z3Z4STlXSmMzaXpUemV0NC9oVnJJUTU2aW95QXoxKzNJdlhtTWhjUHBGRjUx?=
 =?utf-8?B?Q212ZW5lcFhvOTRIdFBSMFlrUVp0T0VUQXhVUUxuNkU0MWZhaU8zVkVQYTNC?=
 =?utf-8?B?REpYRlVMVlF2YmJRVUt5WjRwR2gvL1Bha1dEQStWMFJrNUVrWFNZNlFxYWVU?=
 =?utf-8?B?Z3pDZUs1aDRQU3ZxWVdvQXVQNmpXTjR1eW5FM252S2ZHTmhUWTZwK216WEdr?=
 =?utf-8?B?YzhqVW1uNVUrSFp0VUdRS2liYko4WmFXZE1YRlJSamNVVE5Rb3lTYWRxNUJW?=
 =?utf-8?B?R1JRNmF3TndXNDl3MVlhcGJweVU3WmR3TUMrdTRDWEVwenFOMkowTXNpWUR2?=
 =?utf-8?B?SHVjT0txa3l6T2JtOE5YRHF0R2V6ZVFWYWprb25Fa0RyVXlZSTgzajBZL01l?=
 =?utf-8?B?L2NWcmNWeXRTMnJVT3NaSnVWY3BFUUowSHZubE4yaTN5K3hVRUo5MkM1VG1l?=
 =?utf-8?B?MTdGbGZqbVpmZnA0L3Jud3lLMXZRYmRQWldUcXM1S0RrVi8vUjhNMTZHQ1Vt?=
 =?utf-8?B?MUFCU29ra1A3Z0QvY0xlQWMxVjB4VDRtajJERGx3RFpTWkFMLzkvK1cyRXNt?=
 =?utf-8?B?M3BCUlRHR0RPdGF6Z1Z1dmRKVXppS3lNcUJDdmR4a0U4WXdZUG5ZY0k3Q24w?=
 =?utf-8?B?c0ViNXdiNVh3SXhkNmU5SGFIdVhrdWwvMVNtSXZ0U21RMTAxODBmM2NIZkRq?=
 =?utf-8?B?Q2tuZnBzNVZub3FzcHJZSFZSYmdvVk96MXhhQmFGcjZIZVkvMEFpZUdoamRj?=
 =?utf-8?B?aTg5SWFaYlZnS3FveXZFQUdVdzRPcytVY2NyOXViVVlqVmhjSlZBaHVMdXUv?=
 =?utf-8?B?eU0yd0FEcjBFWHZlM1ZEQk9wUWZGc1FKdWJ5NXhIMFdsUitXQzBMcnFaZkw0?=
 =?utf-8?Q?xmq2i1+Gixwx+6nfJukeTcb4v?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b1fcfcdd-7dbb-4a71-2238-08dc27b88814
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 08:41:08.9654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k276xuI1Dwwq9oIqmDunHIaw8v/nbBckgKzFMJBK0b9qA63vEWEVa51Yle8pN+ABRF9yMv2Gcx+4R7Z3NpRpSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7345
X-OriginatorOrg: intel.com

PiBGcm9tOiBKb2FvIE1hcnRpbnMgPGpvYW8ubS5tYXJ0aW5zQG9yYWNsZS5jb20+DQo+IFNlbnQ6
IFdlZG5lc2RheSwgRmVicnVhcnkgNywgMjAyNCAyOjMyIEFNDQo+IA0KPiBPbiAwNi8wMi8yMDI0
IDE4OjEzLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4gT24gRnJpLCBGZWIgMDIsIDIwMjQg
YXQgMDE6MzQ6MDZQTSArMDAwMCwgSm9hbyBNYXJ0aW5zIHdyb3RlOg0KPiA+DQo+ID4+IEkgaGF2
ZSBhIHNlcGFyYXRlIHNldCBvZiBjaGFuZ2VzLCB0aGF0IHByb3ZlZCBhbHNvIGluc3RydW1lbnRh
bCBpbg0KPiA+PiByZXByb2R1Y2luZyBzb21lIG9mIHRoZXNlIGNvcm5lciBjYXNlcyBpbiBhIG1v
cmUgcHJlZGljdGFibGUgbWFubmVyIGJ1dA0KPiA+PiB3aXRoIElPTU1VIGRyaXZlcnMgaW5zdGVh
ZCwgcmF0aGVyIHRoYW4gSU9NTVVGRCBtb2NrIElPTU1VIGRyaXZlci4uLg0KPiA+PiB3aXRob3V0
IHJlbHlpbmcgb24gVkYgc3BlY2lmaWMgYmVoYXZpb3VyLiBUaG91Z2gsIGl0IHJlbGllcyBvbiBi
ZWluZw0KPiA+PiBhYmxlIHRvIG1hcCBJT1ZBcyBhcyBkaXJ0eS4gVGhpcyBpcyBub3QgaW5jbHVk
ZWQgaW4gdGhpcyBzZXJpZXMsIGFzIEkNCj4gPj4gYW0gbm90IHN1cmUgeWV0IGlmIHN1Y2ggZGly
ZWN0aW9uIHdvdWxkIG1ha2Ugc2Vuc2UgKG91dHNpZGUgb2YgdGVzdGluZykuDQo+ID4+IENvbW1l
bnRzLCBhcHByZWNpYXRlZC4NCj4gPg0KPiA+IEkgd291bGQgbG92ZSB0byBoYXZlIGEgdGVzdCBz
dWl0ZSB0aGF0IGNvdWxkIGRyaXZlIHJlYWwgSFcuIEkgdGhpbmsNCj4gPiB0aGF0IHdvdWxkIG1h
a2UgYSBiaWcgaW1wcm92ZW1lbnQgdG8gaW9tbXUgZHJpdmVyIHF1YWxpdHkuDQo+ID4NCj4gDQo+
IElkZWFsbHkgd2Ugd291bGQgbWVyZ2UgdGhlIHNlbGZ0ZXN0cyB0byB1c2UgcmVhbCBodyBkb21h
aW4gcmF0aGVyIHRoYW4gbW9jaw0KPiBkb21haW4sIGFuZCBza2lwIHdoYXQncyBub3Qgc3VwcG9y
dGVkIHdoZW4gaGFyZHdhcmUgbGFja3MuIFNwZWNpYWxseSBhcyB3ZQ0KPiBhZGQNCj4gbW9yZSBh
bmQgbW9yZSBmZWF0dXJlcyAoSU9QRiwgRFBULCBuZXN0aW5nKSBhbmQgdW5kZXJseWluZyB0ZXN0
aW5nLCBpdCBzZWVtcw0KPiB0aGUNCj4gbW9zdCBuYXR1cmFsIHBvaW50IG9mIGNvbnNvbGlkYXRp
b24uDQo+IA0KPiBEaXJ0eSB0cmFja2luZyBpcyBhIGxpdHRsZSBzdHJhbmdlIGJlY2F1c2Ugb25l
IG5lZWRzIHNvbWUgc29ydCBvZiBibG9jay9wYWNrZXQNCj4gSS9PIGRvbmUgdG8gaGl0IHRoZSBw
YXRoIG9mIGhhdmluZyBzb21ldGhpbmcgYWxsb2NhdGVkLCB3aGljaCB1c3VhbGx5DQoNCnNhbWUg
Zm9yIGlvcGYNCg0KPiByZXF1aXJlcw0KPiBzb21lIGRyaXZlciBvcGVyYXRpbmcgdG8gbWFyayB0
aGluZ3MgZGlydHkgcGx1cyBwYWdlIGFsbG9jYXRvciBsdWNrIGluIHBpY2tpbmcNCj4gdGhlIHJp
Z2h0IHBhZ2VzLiBTbyB0aGUgc3RyYWlnaHRmb3J3YXJkIHdheSB0byBtYW5pcHVsYXRlIGFsbCB0
aGlzIHdpdGhvdXQgYW55DQo+IG9mIHRoaXMgY29tcGxleGl0eSBvbiByZWFsIGhhcmR3YXJlIGlz
IHRoaXMgaXMgdG8gIm1hcCBhcyBkaXJ0eSIgYW5kIGNoZWNrIGlmDQo+IHNvbWV0aGluZyBpcyBt
aXNzaW5nLiBJdCBwcm92ZWQgdXNlZnVsIGluIHRoZXNlIGJ1Z3MgYXMgSSBjb3VsZG4ndCByZXBy
b2R1Y2UNCj4gdGhpcyBieSBqdXN0IHVzaW5nIHRoZSB0aGluZyAoZXZlbiBzaGFyaW5nIHRoZSBz
YW1lIHRlc3QgYXMgQXZpaGFpKS4gSW4gYW55DQo+IGNhc2UsIHRoZSBnb3RjaGEgaXMgY29uc3Vt
aW5nIGEgbmV3IHBlcm0gYml0Lg0KPiANCg0KaXMgdGhpcyBzb21ldGhpbmcgd2hpY2ggdmlydGlv
LWlvbW11IG1heSBjb21lIHRvIGhlbHA/IGUuZy4gdmlydGlvLWlvbW11IA0KYmFja2VuZCBtYXkg
YmUgaW5zdHJ1bWVudGVkIHRvIGZha2UgRE1BIHJlcXVlc3RzIHcvbyByZWx5aW5nIG9uIGEgc3Bl
Y2lmaWMNCmRldmljZSB0byBhY3R1YWxseSB0b3VjaCBtZW1vcnkuLi4NCg==
