Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E336350A
	for <iommu@lists.linux.dev>; Sun, 18 Feb 2024 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708261783; cv=fail; b=i1XhLEnSy/oBuBS8tJZtCDjBP1PM5DYNen8Yubi2ghou3WtTzxdREZncJQjUQtbzX9WeNP4P9fR95K4pU9oMGik7JQuv4SCXaWAzy5MXYnlcnIFSPwrYG2OLOkr7/ZSuELckPy+B9Ox91HeEdwjjDhDOy7kgSKsdoNFnqMvBITs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708261783; c=relaxed/simple;
	bh=bhPvRHKusY8owKiRavhPABwImS0PNBKUhXgBGwxnSLI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YYir9DyLzKSbgISr60D/7gBl63wQwUPyq6INkdAkkgIgDBDSVv/iETxs9YXXLov2zNNauv5FzE4vW2vPjVW0UIxK+K2sDwV/l/E3VB2BQaUxGa4kaXgxf/s+sw20yIDcb4Q0bJpbmtks4SMlDBVZwAA92UXqyTFMRHkIwLA2sKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KGYrKU44; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KGYrKU44"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708261782; x=1739797782;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bhPvRHKusY8owKiRavhPABwImS0PNBKUhXgBGwxnSLI=;
  b=KGYrKU448cdA2uYFFHf1fufKFPNAfjB/0Up8ItBrMJUDwOwQ+sRCXYlT
   jETpvlGQatxWmqyBd20uATpbardbaMkHtioVaQWHrqyftE07d5mvYpPSB
   eL8WsUqogi4LgwWNzkczxGKl6s3NLTkIp+Fp4MrCi5FzWt2wSXCwmDtyZ
   N5PT1KJ70wTWs830PzLMTlzi7XAl+79qWhXxR5+AFns+UzuaCv263m3Dw
   6Stx7dLGuC/fD/kOe1DPK0iD9St/ngsFW+An/pnsGbh3DODp2/rb3yzM1
   I7E3wxEPlIa4AEkxbOmTouFuT3HAYmJZRnN8f8HvM9LoO0W4FvWo4STAK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="5304890"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="5304890"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 05:09:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="4530402"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2024 05:09:41 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 05:09:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 05:09:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 18 Feb 2024 05:09:39 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 18 Feb 2024 05:09:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/OSPavgV1Gresma+22l/GLcFnbiq+rlVOIfLTJFc8QWSrt9FZvfC+uXnHrR4X/XLH4wVLjltGd1mTu+Z1zD5KqilcfsBhvQCE1cnEVhyOR76WF0/GIP73PBar6YS0Ymke2Vx1PgCd8ueuKeMmW/Z2I/gB+0cZdoY7RW1Stv2OaWe1TTIVxfJDYZw9wN9qzD7/cNs+/SAb/rZnnV/f+2+dEkU61h9slyuZTBg3xCcGDw5UxkJE7isTqftZxomuNxE3+Honb2YgcRV3wEBJAnS5WyKIlSFQZtpGygi/gYHC0k7cDXV7z4QtVsWgM2xh/4H2kR//kr82XN65oXB85Kog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhPvRHKusY8owKiRavhPABwImS0PNBKUhXgBGwxnSLI=;
 b=odL2QjtesLVgaKLEud9Vyh/LDhPTcMxfPeQsF5cZLTzjWOn3RuQCwTcruW27BkSII3K/kGg6lJmL9OdssOqVH2US4R1wgNkDNRkxi3KQZf5XmGjTGuw0dNF9A4LM98y/hjvUJLuPzu9e9jmA92iOT+8mHRLQGwcUeALs2tTMw+t+sYbflij7+sGLBSIDERHnIiTAuDxQ7ahsfQ3gJaSKvN8FbToIDNFc1r+aehnUXHaCEvJzeFcyI4llfZeeswAapp1PN4HxWZ0UbB20LknptN+TaykCcLYc9cZhpLU/hM/qCjdmNbkj4aKA1IinDC5bOxuYsw+NKPOLHarbDdDWlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by BL3PR11MB6411.namprd11.prod.outlook.com (2603:10b6:208:3ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Sun, 18 Feb
 2024 13:09:37 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::2e1e:4cf0:f8ea:a9c7]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::2e1e:4cf0:f8ea:a9c7%4]) with mapi id 15.20.7292.029; Sun, 18 Feb 2024
 13:09:37 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [PATCH 11/11] iommu/vt-d: Remove superfluous IOMMU IOTLB
 invalidations
Thread-Topic: [PATCH 11/11] iommu/vt-d: Remove superfluous IOMMU IOTLB
 invalidations
Thread-Index: AQHaSBk2kfWQiW6erkedFcmmn80UVLDdpgwAgC75T6CAA2eAgIAANIDA
Date: Sun, 18 Feb 2024 13:09:37 +0000
Message-ID: <MW5PR11MB5881CAEF50914A8661C25C2B89522@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20240116011146.18645-1-tina.zhang@intel.com>
 <20240116011146.18645-12-tina.zhang@intel.com>
 <a68120c9-9114-4312-b260-6b82303f2ef5@linux.intel.com>
 <MW5PR11MB5881721113BCB56830201188894C2@MW5PR11MB5881.namprd11.prod.outlook.com>
 <7afa0043-5230-42f7-947a-ee0e88358edf@linux.intel.com>
In-Reply-To: <7afa0043-5230-42f7-947a-ee0e88358edf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|BL3PR11MB6411:EE_
x-ms-office365-filtering-correlation-id: 8ff1e126-cefa-4b87-f049-08dc3082dc25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x9VXTRWSrOk4R9PnHWJfMZZ5oy0jX/fdIbyRV3uhgb2IEOf6/nvEZ1PdbG3z9NNe6rx77JyjYxq7XG6H+sS7KifsrbHjEaxhGweB1IZwpRJDgIbFBGStakAMLJbffqqleHIhQCl9TDeUj09Qx2I0h3u7tm0fya3tuL7/KlB7MxIDqPQf90TMQuO1f14zbI969AL1InMqnTjxhS3DkmiLzXK3xy+Hgpad+hDMR8RcrGoXM/A1DJaW29KBYz3FSA1FIUxbCAOBy/b72IO0jT0XwuGVa3M3IzKnXBlWj2AW/myRmJMELPdYrR0Q6J/0iYi7ggBJmqv5a/ujqCp2HQuvm56slmDtNckwFIviT08EWq+DHXKCoUbGdDnRGgzCMPwwVKQKH41L669nzlbI14GLm2bWBpS5ehh6XXrk86zu+pndiWsTCMMlOBk7M2NJSNWX8AFlpeK49OpoHgW8DTnDbYmAcxkzktdug6u2UBDY+fA0z1Oc3E5R6G2IwYgSJc/kav38UKfT+n2plllxX9+wLbVhtlRDnfYQOFLfpb9dXv6KwSgws2O1F3x1dQDx5zLB8qcBK62jh9vYD0pFA4yZ4uQLyrdTxIJbmRHqSTazs8k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(110136005)(316002)(71200400001)(55016003)(5660300002)(2906002)(76116006)(4326008)(8676002)(8936002)(86362001)(66946007)(41300700001)(66446008)(66476007)(66556008)(52536014)(64756008)(9686003)(53546011)(966005)(6506007)(478600001)(7696005)(38070700009)(26005)(83380400001)(122000001)(33656002)(82960400001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXV3VDdMMmhuTjl4Z3ZuaGFiNHVtN0hkeFl3ZndsR3FmbjNkMWRjRm5jY3BV?=
 =?utf-8?B?QmVCa0NNSGVFTktwSUVjTUJWZGFxdEFOaG9vTVNaWXB6V2wwU2MrR0V2V1cy?=
 =?utf-8?B?YitUdGFDT3FNb3Jjd0lwU09ENWlIZUU0RmpuYUtUa0pwb3VJSU1xU0JRNFl1?=
 =?utf-8?B?Q0srNFJOc2lpVGJ5YnpZUUtFVWpkQW53OTZab3FhR29DS3lQK24vM3dXK3k3?=
 =?utf-8?B?cStwRjRBd0kweVFqK0tHZjh6VXZVV2lZYmVWTThOQzlqTVdoYUR3Y0RRMmxY?=
 =?utf-8?B?aHpqcW5oN08reUFFdlRwR2RWeUwzbFF1VzZSL0wvbm5JMDQ1ZnRVR3FBZHB5?=
 =?utf-8?B?S3ZWbElqZExxSG5NVW1vb2NkYlZwODFCVGxlaU1PQWp2ZENvMHdQZGt0OXd1?=
 =?utf-8?B?TU1kN0p2Ym1ta2lzZDI5NWd2Z2hMQ0R5VFNiYjd6ZGxwOEE3bFRyaysrZ0V0?=
 =?utf-8?B?a2VlakU5NFIreFZaTTV2Q1JiVUFUdVNNS3pUTE96UWxWbXA1QVRLSDZxT3F3?=
 =?utf-8?B?bTZ6UWZHQnl1Tm4zUnBneXJweDhWa3h0YnNhSS80cGYwVmNOMzZGZ1JyZEt4?=
 =?utf-8?B?QzM2SHZRVlZEMkE0RC9tMVRhYTFMcFBUaGhpeTgrQXhFRnQweU9wYlZvajBp?=
 =?utf-8?B?M05YRFBia1pwU3phY25rVUNxRW1OZm9xc1pEdkxrQ2tpcUhnbzM1Zk91citE?=
 =?utf-8?B?ZGFwZkg3cGU3WWNzWmxneUpZdVBKM3J6UEdHTUV6TWhMclJGV2RVT3pmZTBx?=
 =?utf-8?B?a0xsYmQ2d3Rrd3BXYTJkU3NoRGgzdUpvU0pxZFEvZzdYdW0rWWxrK0NvNTQz?=
 =?utf-8?B?dDRrQytJTGtrNDh3dVFDendtaXRzb3BiVmNmM0laRnR0NCtyS0M0aTFnOEZX?=
 =?utf-8?B?bzZCOWJlK01kUTNrQ0l2TTdpOCtrS2x0ZGZyQlFDWnJxSkdhWG40OFBSam5I?=
 =?utf-8?B?akJ2U0s1Y0IwZURkNzJreU0xWVk4Q2podlRVUjV3cE50c1lmT2U4R04vZWEx?=
 =?utf-8?B?WWluRUQyWlF1SE5zVUJZTzU5VjUwU2hpd25hcG9UellZYUhienJVVFFXamkx?=
 =?utf-8?B?d0J1dzBnaHA4L2JvTjJrNXhsRGJINTNPUXZ3d2tlenlMWHBOVUVBbW1VZ3RY?=
 =?utf-8?B?b0RwNXhJZGhGY1g3UmNOQ3dDd1ZrY0x3dEtZVkxYYWJ2RkVyeHFBMDdORy9i?=
 =?utf-8?B?bHh3ZDlOOWM0Z0pEa0pwbWhUM3RKZUMzdSsrYldhVmFxaEtWQUpQdzI0Vmk0?=
 =?utf-8?B?TFB0enViRzBVQnVFTytha0o1bnJraHJ1a0MrYUVmdFh5S1R6Q0NmZDZPNXBU?=
 =?utf-8?B?amRKK3JHckdHYUtaVk00MDBtWlVOSVJmeXFwQ3M2UzczVjRrMTJXd1pzWlcv?=
 =?utf-8?B?TU11WHY0bjJmY2QxM3NJTTNybWliL3BnUzkvbHdVUGdjQUtNNjBSMnVrekU3?=
 =?utf-8?B?QjFJODl3cXFFZ1VXU28ybFNWbWNaUzdaNXpFUHFjV1FnT1lGUWhnUkExUDk3?=
 =?utf-8?B?d0NycFlIeGRyZFZnNHVSSFN5UURSTjcvRFBBMHp3WVI5eTdGTHhBaW5vOHdr?=
 =?utf-8?B?Z1BIaUJyVnFzZ0ZpeVpNOVZhcVFPZEg2NENsQVA2enhqaGk4ZEZmYkZjOTF2?=
 =?utf-8?B?UUVRWlV6WEduQnhpVEJwWXhlcUdlMHd3WlE3eHM1WFJ0OWtCdWVNSXdyR1dl?=
 =?utf-8?B?UDV3L3lkU3JabEdvRmdxcmkvTnF4VTg2WS9RZ2lYVVp0UG9GN0U1c0hGbGNU?=
 =?utf-8?B?NU5ZVE9mcXcvRlpaT1lla3VBRjBBMXZraTVKQ0RhOTFROHk1VTI3SDN4bmV2?=
 =?utf-8?B?K0MrNTFPNUpUb1M0azJYTVVOWHo2TWxSZ1RWUHRPR05YL0lvNEpWeEN1eDhL?=
 =?utf-8?B?cjl2NUU0RVBQdDFKSUVzTWxNNmNQaUh5WVFzcDI3c1k1WTZ6ZnRuTHozRHBk?=
 =?utf-8?B?dTBtZDEwNWpseHZERHZqK2JMOTAyZmJwcnhMZ0ZQS3J5eGxJbjJvazUyOG5J?=
 =?utf-8?B?Q04xTDhwTUpxOC8vTjZvWlVNM0hRY0VVNTU4RnczbmoxdEtlSzRZU0hQMzZi?=
 =?utf-8?B?aHdHbWVISG53T01QV25GZDlaWUVIMW0rL2I0VEliWS9MVkxFek95RC8vYmZX?=
 =?utf-8?Q?sMF4UA0wVpTDklAr60dzu8Al+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff1e126-cefa-4b87-f049-08dc3082dc25
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2024 13:09:37.6547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gcf1qSr/djc6PSnkHo5OGZ36a0vQRyqbfVfuRdgNZ/iFXO62NF6tc0xE7kX1Dhz+9PyqShmrogg5jBrVCM9oSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6411
X-OriginatorOrg: intel.com

SGkgQmFvbHUsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFvbHUg
THUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogU3VuZGF5LCBGZWJydWFyeSAx
OCwgMjAyNCA1OjE5IFBNDQo+IFRvOiBaaGFuZywgVGluYSA8dGluYS56aGFuZ0BpbnRlbC5jb20+
OyBpb21tdUBsaXN0cy5saW51eC5kZXYNCj4gQ2M6IGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbTsg
VGlhbiwgS2V2aW4gPGtldmluLnRpYW5AaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IDExLzExXSBpb21tdS92dC1kOiBSZW1vdmUgc3VwZXJmbHVvdXMgSU9NTVUgSU9UTEINCj4gaW52
YWxpZGF0aW9ucw0KPiANCj4gT24gMjAyNC8yLzE2IDEzOjM4LCBaaGFuZywgVGluYSB3cm90ZToN
Cj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL3N2bS5jIGIvZHJpdmVycy9p
b21tdS9pbnRlbC9zdm0uYw0KPiA+Pj4gaW5kZXggNzlkMWYzMTA3ODQ3Li5iZjQ5NjJlYjIyOWMg
MTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL3N2bS5jDQo+ID4+PiArKysg
Yi9kcml2ZXJzL2lvbW11L2ludGVsL3N2bS5jDQo+ID4+PiBAQCAtMTM0LDMxICsxMzQsMzkgQEAg
dm9pZCBpbnRlbF9zdm1fY2hlY2soc3RydWN0IGludGVsX2lvbW11DQo+ICppb21tdSkNCj4gPj4+
ICAgIAlpb21tdS0+ZmxhZ3MgfD0gVlREX0ZMQUdfU1ZNX0NBUEFCTEU7DQo+ID4+PiAgICB9DQo+
ID4+Pg0KPiA+Pj4gLXN0YXRpYyB2b2lkIF9fZmx1c2hfc3ZtX3JhbmdlX2RldihzdHJ1Y3QgZG1h
cl9kb21haW4gKmRvbWFpbiwNCj4gPj4+IC0JCQkJICBzdHJ1Y3QgZGV2X3Bhc2lkX2luZm8gKmRl
dl9wYXNpZCwNCj4gPj4+ICtzdGF0aWMgdm9pZCBfX2ZsdXNoX3N2bV9yYW5nZShzdHJ1Y3QgaW9t
bXVfZG9tYWluICpkb21haW4sDQo+ID4+PiAgICAJCQkJICB1bnNpZ25lZCBsb25nIGFkZHJlc3Ms
DQo+ID4+PiAgICAJCQkJICB1bnNpZ25lZCBsb25nIHBhZ2VzLCBpbnQgaWgpDQo+ID4+PiAgICB7
DQo+ID4+PiAtCXN0cnVjdCBkZXZpY2VfZG9tYWluX2luZm8gKmluZm8gPSBkZXZfaW9tbXVfcHJp
dl9nZXQoZGV2X3Bhc2lkLQ0KPiA+Pj4gZGV2KTsNCj4gPj4+IC0JdTMyIHBhc2lkID0gbW1fZ2V0
X2VucWNtZF9wYXNpZChkb21haW4tPmRvbWFpbi5tbSk7DQo+ID4+PiArCXUzMiBwYXNpZCA9IG1t
X2dldF9lbnFjbWRfcGFzaWQoZG9tYWluLT5tbSk7DQo+ID4+PiArCXN0cnVjdCBkZXZpY2VfZG9t
YWluX2luZm8gKmRldl9pbmZvOw0KPiA+Pj4gKwlzdHJ1Y3QgaW9tbXVfZG9tYWluX2luZm8gKmlv
bW11X2luZm87DQo+ID4+PiArCXN0cnVjdCBkZXZfcGFzaWRfaW5mbyAqZGV2X3Bhc2lkOw0KPiA+
Pj4gKwl1bnNpZ25lZCBsb25nIGlkeDsNCj4gPj4+DQo+ID4+PiAgICAJaWYgKFdBUk5fT04oIXBh
Z2VzKSkNCj4gPj4+ICAgIAkJcmV0dXJuOw0KPiA+Pj4NCj4gPj4+IC0JcWlfZmx1c2hfcGlvdGxi
KGluZm8tPmlvbW11LCBkZXZfcGFzaWQtPmRpZCwgcGFzaWQsIGFkZHJlc3MsIHBhZ2VzLA0KPiBp
aCk7DQo+ID4+PiAtCWlmIChpbmZvLT5hdHNfZW5hYmxlZCkgew0KPiA+Pj4gLQkJcWlfZmx1c2hf
ZGV2X2lvdGxiX3Bhc2lkKGluZm8tPmlvbW11LCBkZXZfcGFzaWQtPnNpZCwgaW5mby0NCj4gPj4+
IHBmc2lkLA0KPiA+Pj4gLQkJCQkJIHBhc2lkLCBkZXZfcGFzaWQtPnFkZXAsIGFkZHJlc3MsDQo+
ID4+PiAtCQkJCQkgb3JkZXJfYmFzZV8yKHBhZ2VzKSk7DQo+ID4+PiAtCQlxdWlya19leHRyYV9k
ZXZfdGxiX2ZsdXNoKGluZm8sIGFkZHJlc3MsDQo+IG9yZGVyX2Jhc2VfMihwYWdlcyksDQo+ID4+
PiAtCQkJCQkgIHBhc2lkLCBkZXZfcGFzaWQtPnFkZXApOw0KPiA+Pj4gKwlyY3VfcmVhZF9sb2Nr
KCk7DQo+ID4+PiArCXhhX2Zvcl9lYWNoKCZ0b19kbWFyX2RvbWFpbihkb21haW4pLT5pb21tdV9h
cnJheSwgaWR4LA0KPiA+PiBpb21tdV9pbmZvKQ0KPiA+Pj4gKwkJcWlfZmx1c2hfcGlvdGxiKGlv
bW11X2luZm8tPmlvbW11LCBkZXZfcGFzaWQtPmRpZCwNCj4gPj4+ICsJCQkJcGFzaWQsIGFkZHJl
c3MsIHBhZ2VzLCBpaCk7DQo+ID4+IFRoZSB4YV9hcnJheSBmb3IgaW9tbXUgaXMgYWxyZWFkeSBi
cm9rZW4uIFdlIHNob3VsZCBmaXggaXQgYmVmb3JlIGZ1cnRoZXINCj4gdXNlLg0KPiA+Pg0KPiA+
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC0NCj4gaW9tbXUvMjAyNDAxMDMxMjQ0MDMu
R001MDQwNkBudmlkaWEuY29tDQo+ID4+IC8NCj4gPiBBZ3JlZSB0aGF0IGRvbWFpbi0+aW9tbXVf
YXJyYXkgbmVlZHMgdG8gcHJvdGVjdCB0aGUgZWxlbWVudCAoc3RydWN0DQo+IGlvbW11X2RvbWFp
bl9pbmZvKSBmcm9tIFVBRiBhcyB3ZWxsLiBUaGlzIGNvdWxkIGJlIGFub3RoZXIgdG9waWMuDQo+
ID4NCj4gPiBJIHJlYWxpemUgdGhhdCB3ZSBkb24ndCBuZWVkIHRvIHVzZSBkb21haW4tPmlvbW11
X2FycmF5IGhlcmUuIFdoYXQgd2UNCj4gd2FudCBoZXJlIGlzIGEgcG9pbnRlciBwb2ludGluZyB0
byBhIHN0cnVjdCBpbnRlbF9pb21tdS4gV2UgY2FuIGdldCB0aGUgaW5mbw0KPiBmcm9tIGRldmlj
ZSB1c2luZyBkZXZfaW9tbXVfcHJpdl9nZXQoKSwgaW5zdGVhZCBvZiBnZXR0aW5nIHRoZSBpbmZv
IGZyb20NCj4gaW9tbXVfYXJyYXkuDQo+ID4NCj4gPiBCZXNpZGVzLCBJJ20gdGhpbmtpbmcgYWJv
dXQgc29ydGluZyB0aGUgZG9tYWluLT5kZXZfcGFzaWRzIGluDQo+IGludGVsX2lvbW11X3NldF9k
ZXZfcGFzaWQoKSB0byBtYWtlIHN0cnVjdCBkZXZfcGFzaWRfaW5mbyBvZiB0aGUgZGV2aWNlcw0K
PiBiZWhpbmQgdGhlIHNhbWUgSU9NTVUgc3RheSB0b2dldGhlci4gSXQgY2FuIGJlIGhlbHBmdWwg
dG8gcmVkdWNlIHRoZQ0KPiByZWR1bmRhbnQgSU9NTVUgSU9UTEIgaW52YWxpZGF0aW9ucy4NCj4g
DQo+IEkgdGhpbmsgd2hhdCB5b3Ugd2FudCBoZXJlIGFyZSB0aGUge2RvbWFpbl9pZCwgcGFzaWR9
IHBhaXJzIHRvIGZsdXNoIHRoZSBJT1RMQg0KV2VsbCwgZm9yIHRoaXMgc3ZhIGNhc2Ugd2UgbmVl
ZCB0byBrbm93IHRoZSBwb2ludGVycyBvZiBzdHJ1Y3QgaW50ZWxfaW9tbXUgaW5zdGFuY2VzLg0K
DQpGb3IgZXhhbXBsZSwgdGhlcmUgYXJlIGZvdXIgZGV2aWNlcyAoZGV2aWNlMSwgZGV2aWNlMiwg
ZGV2aWNlMywgZGV2aWNlNCkgYW5kIHR3byBJT01NVXMgKElPTU1VMSBhbmQgSU9NTVUyKS4gRGV2
aWNlMSBhbmQgZGV2aWNlMiBhcmUgYmVoaW5kIElPTU1VMSwgd2hpbGUgZGV2aWNlMyBhbmQgZGV2
aWNlNCBhcmUgYmVoaW5kIElPTU1VMi4gSWYgYWxsIHRoZSBmb3VyIGRldmljZXMgYXJlIGJvdW5k
IHRvIGEgc3ZhIGRvbWFpbiwgdGhlIGRvbWFpbi0+ZGV2X3Bhc2lkcyB3aWxsIGxpc3QgdGhvc2Ug
Zm91ciBkZXZpY2VzLiBXZSBleHBlY3Qgd2hlbiBhcmNoX2ludmFsaWRhdGVfc2Vjb25kYXJ5X3Rs
YnMoKSBjYWxsYmFjayBpcyBpbnZva2VkLCB0aGVyZSB3aWxsIGJlIDIgcWlfZmx1c2hfcGlvdGxi
KCkgKyA0IHFpX2ZsdXNoX2Rldl9pb3RsYl9wYXNpZCgpLiBIb3dldmVyLCBjdXJyZW50bHksIHdp
dGhvdXQgdGhpcyBwYXRoLXNldCwgdGhlcmUgd2lsbCBiZSA0IHFpX2ZsdXNoX3Bpb3RsYigpICsg
NCBxaV9mbHVzaF9kZXZfaW90bGJfcGFzaWQoKS4gVGhlIHJlYXNvbiB3aHkgdGhlcmUgYXJlIDIg
bW9yZSByZWR1bmRhbnQgcWlfZmx1c2hfcGlvdGxiKCkgaXMgYmVjYXVzZSBkb21haW4tPmRldl9w
YXNpZHMgbGlzdCBvbmx5IGhhcyB0aGUgYXR0YWNoZWQgZGV2aWNlIGluZm8gKG5vIElPTU1VIGlu
Zm8pLiBCdXQgSU9NTVUgaW5mbyBjYW4gYmUgZ290IGZyb20gZGV2aWNlLg0KDQpTbywgaWYgd2Ug
Y2FuIHNvcnQgdGhlIGRvbWFpbi0+ZGV2X3Bhc2lkcyBhbmQgbWFrZSB0aGUgZGV2aWNlcyBiZWhp
bmQgb25lIElPTU1VIHN0YXkgdG9nZXRoZXIsIHRoZW4gd2hlbiBpdGVyYXRpbmcgdGhlIGRvbWFp
bi0+ZGV2X3Bhc2lkcywgd2UgY2FuIHNraXAgY2FsbGluZyByZWR1bmRhbnQgcWlfZmx1c2hfcGlv
dGxiKCkgYnkgY2hlY2tpbmcgaWYgdGhlIGRldmljZSdzIElPTU1VIGlzIHRoZSBzYW1lIGFzIHRo
ZSBwZXJ2aW91cyBvbmUgKGlmIGl0J3Mgc2FtZSwgdGhlbiBubyBuZWVkIHRvIGNhbGwgcWlfZmx1
c2hfcGlvdGxiKCkgYWdhaW4pLg0KDQpJIHBsYW4gdG8gc3VibWl0IHRoZSBuZXcgdmVyc2lvbiBv
ZiB0aGUgcGF0Y2gtc2V0IHNvb24uIEFsc28sIEknbSBsb29raW5nIGZvcndhcmQgdG8gc2VlaW5n
IHlvdXIgcHJvcG9zYWwuIExldCdzIGRpc2N1c3MgbGF0ZXIuIFRoYW5rcy4NCg0KUmVnYXJkcywN
Ci1UaW5hDQoNCj4gY2FjaGUgaW4gdGhlIElPTU1VLCByaWdodD8gUGVyaGFwcyB3ZSBjb3VsZCBy
ZWZpbmUgdGhpcyBjb2RlIGZ1cnRoZXIgYnkNCj4gaW50cm9kdWNpbmcgYSBzdHJ1Y3R1cmUgb2Yg
Y2FjaGUgdGFnLiBUaGUgY2FjaGUgdGFncyBjYW4gYmUgc3RvcmVkIGluIHRoZQ0KPiBkb21haW4n
cyBJT01NVSBhcnJheS4gSSdtIHdvcmtpbmcgb24gYSBzb2x1dGlvbiBhbmQgSSBjYW4gcG9zdCBp
dCBmb3INCj4gZGlzY3Vzc2lvbiBsYXRlci4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gYmFvbHUN
Cg==
