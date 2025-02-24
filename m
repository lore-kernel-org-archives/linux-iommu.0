Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC989157A5C
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 03:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740366292; cv=fail; b=t5GZyqBi/VMz7TIyEacAR3fv4oDfy8qFJu3PKcbjMAcU8+383E9oq8jqZTEgE0vMH81lAJnYmviEVMgr+FpmXUJEbyR0oYrErQGwMUgrS+wE/wELlFIT/HKPmkL3cf9zw2sbCH3CAcUDIfJMqyr3GkJp8rkkl8JdpwtnyxXJN0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740366292; c=relaxed/simple;
	bh=wXgpCdyI5/9NEWZuIkWLDAIxjFkc1dtVjupEXckfP0o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bO0xL/HW6RW8cczFSpfNnxRAX7gzn9UXgnLhesxOmqlsbS3U28o4F6H0zZxB7BGQDfMavlco3W5cFr2bNyJYzH2Iv/KCmIflluXQqBfGid9D10MlHXKz3wymrfFuVQ2sNNDCYeP8btFx9X5A9sEyfYzK6Pxf78I8tQFl+VgUlyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=doidExba; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="doidExba"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740366287; x=1771902287;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wXgpCdyI5/9NEWZuIkWLDAIxjFkc1dtVjupEXckfP0o=;
  b=doidExba9WDDfG8GGi749bFDmhzEjueRmc7nQkPS1zhSIFnzKbzRyOHp
   Rypbrh0QmkUhYQJSxLHamTXYa5vk29l9nP1usEJ+XG28ZOQTO8BLBLC/M
   2zsTwg+bfqmHYSGW+kW0KSTZ8id9704GZg/tiJGUhNavO0ACicdve+9lU
   LaUxHdqIYVgRTSUj/eYWPUmww6NhWAkvLoqpp/84F9XrvgvSEK6udCf+x
   GXxwdhYWerbfMk3qh2gPiuW8TpPi61Gye0rMAHmvGWzSMXI+2U5R0KRL2
   y7Fw7wSjZnfpgAxYrOpPvLnC8fV0Af36CZT4qLyuoWPlCMbGxOoYs9CIG
   w==;
X-CSE-ConnectionGUID: KdgqNikwSAKxJaSbNsxjiw==
X-CSE-MsgGUID: Twidgp/1QrqSs7O91TxHFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="51325023"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="51325023"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 19:04:41 -0800
X-CSE-ConnectionGUID: aGhedMFgRSyhmmbRBTyORw==
X-CSE-MsgGUID: Q/YeEjhSTHOy38MB2DasXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116410365"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 19:04:38 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 23 Feb 2025 19:04:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 23 Feb 2025 19:04:37 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 23 Feb 2025 19:04:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4S/DRilKFsHdXSl8S0GODHdYg8eqz5VFRfxeFaBm4UWC7FCKSbFkw2vW5Srl/6XA2FUoyMwM3bL5BJ3jpX1vY7PbCUJQsvp/nVo1q00ieAEjDCOjmff9KIf4AbXG3izGi02E30mPw4epc1A9OuUC86HWgy7IC2t8E8jq6bPQitKUBCEX+PIzB8hxIttfCscV9g5RbPZTHtt5cTxp6he/HqCBrasACgC9/uJEe4uNvEgnp0ST7ljcqJcIR/e6SuPYVW4TOMgZ2GmtZDoMRDT9eW22OfRa91KhRfh5FN4URAwaObQ/+a0gnQLlCGNjKbX6Wwmq6TH3sX9RuweD+jbZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXgpCdyI5/9NEWZuIkWLDAIxjFkc1dtVjupEXckfP0o=;
 b=EvOfmwYaNxqS39PyUQqtO/N9IL1iP26hLD9oPEVaK/VyQaWkHKn6educeOnWxFRiwS2kqKxV2jcfTiWRgFXVpyt93mOohmnkiJ4uE5WRMNCdL0mo5VzQJAWb7GWfBfpc2EQo2TxHPZY85dL70E9JRYQ/exQKXm2TN3BwTQ/sgjMqjpri5JEYHXpABa0SS9y1uCTM2lq+gTazExu47h5ECR1p8xO9vL9L2arpMAJiDgDNz/Nd/wziUigT0NX76d0G/XGIuIr0tEpT45Ch6MVbyCZ5dLQNqKNFaKdLGc4hNS80d4Dop5ck2W1HeuRpkIYmzekvIFF+n8GLdzDs8vZksQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY5PR11MB6343.namprd11.prod.outlook.com (2603:10b6:930:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Mon, 24 Feb
 2025 03:04:00 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 03:04:00 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v2 3/4] iommu: Store either domain or handle in
 group->pasid_array
Thread-Topic: [PATCH v2 3/4] iommu: Store either domain or handle in
 group->pasid_array
Thread-Index: AQHbhG2dqKQgcpHGIEKNqrStlyVpILNU4ygAgADeL2CAAAWZgIAAAZnA
Date: Mon, 24 Feb 2025 03:04:00 +0000
Message-ID: <BN9PR11MB52768A3DA2D4961F9732EAD68CC02@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250221143335.49874-1-yi.l.liu@intel.com>
 <20250221143335.49874-4-yi.l.liu@intel.com>
 <a4a1e65e-3614-419c-a5e3-6ff2aa4f1369@linux.intel.com>
 <BN9PR11MB52764D5D3DFA97B187DAACE38CC02@BN9PR11MB5276.namprd11.prod.outlook.com>
 <6555deb7-17a5-4e0b-b167-fef6785a9961@linux.intel.com>
In-Reply-To: <6555deb7-17a5-4e0b-b167-fef6785a9961@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY5PR11MB6343:EE_
x-ms-office365-filtering-correlation-id: 9bfb9761-d341-44d9-b199-08dd547fe2f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UlFpYy9TbEZJRzVWZzNPaTV1Y1ZUMGdocllkN0ZibFVidCtycE5ydnNIYytL?=
 =?utf-8?B?MU5RajJFVVFPTGE1eVY0c2dhY05BVjk1RDhza3YvQlROeUFoWjdQRzFKa25L?=
 =?utf-8?B?S2pKNjlzL0swRDBTSEE0MEVrWW83Zks2WTZTelFGMVMwMUdaY1JoZjZrRjlx?=
 =?utf-8?B?MkovWFVrY1NpNiszdm1GTmNmUTFqcU8rMWl1QjNDMlU3cnZSS1R4UFVIa3E1?=
 =?utf-8?B?SkIwL2M1UW9jUWtER1FBMWI1Ly8zWmpTUkdqQk5TUDY3YVhSNlVCMTI1cVoy?=
 =?utf-8?B?SjRsaklrTHFJKzE0d2dPb3ZmRS94M2RJL0ZkdHdlb01mZm91VXpXWFNsb1Fm?=
 =?utf-8?B?WlJVMzU2STUwU0Q2VHpodDRjM29jdWVNMHhxM0VZT2crTjVUYXBmSGJhL2Zx?=
 =?utf-8?B?VzA4VWRYMWdqeG9kSS83UXErOWNuTW8xNTZZTU1PeDJjMnFTUnJ6YzkwaE9r?=
 =?utf-8?B?azhTdUF2VDg1K2kxN3c1cnFSMmZWTHZIcE03TDlzand6VXF5eUdkWlh2NHhX?=
 =?utf-8?B?WUFJdHJRTTFIcVVGd3VyRDZFYVpkZkFtenJOQmJJMk9QS0RzU0l6ZzRLcTZS?=
 =?utf-8?B?Umd4QW84ZTMwZ0VFZHBWeXQ3VkJ6TWlONFJUMlZXc1FBbXJZV0VuZ1gvYmov?=
 =?utf-8?B?N2lOVXFIZ25adTd1MmFtdjNyZUE4VGFnUlRvZytBcTBzVVZNbnpvT3hCbTBl?=
 =?utf-8?B?SFUwOWlsazREUFJ4NWtxKzdrRWFSS0I0bE9VN2M4dmdPaWR5bTBkWk9JbDM2?=
 =?utf-8?B?ZmJDQWZXK2tEdC9jTjJOaG10U21Kc0ZRMTRJb3ZCZ25MaE4rbXFzRzRiMXdz?=
 =?utf-8?B?U3FHcGQ2bTBDamtORGVIdzFka3YxTnJUc0gzTU1vOW5sNkZLalIzR0dBalRw?=
 =?utf-8?B?dVFyNHZxWlRLNlRxZ1BNYkhCT2E0cldVcEo5SXdDbHZjaFJpZ0FDMXBhMUdO?=
 =?utf-8?B?dXJWNWdTeERKNjVXVTYzRXgvL0ZwV0Q0Yys5NnZyWk40RHFBdTJPcGxYRGVL?=
 =?utf-8?B?TWwzMFZTMkw4TEtTTmZpWWVOQjAvdEl1VHRyaG5oWkRDcWVGb1RROEpaS1hR?=
 =?utf-8?B?WkdPVzZ3MW9vQVZwWlh2T1M0TFdoSWFxdnhadldINFBpTHF1c2Fsa2JLanV4?=
 =?utf-8?B?ZDlETVd5WkxpMVdiMExyUUVRUWxOV0FZeDlyQzhoKytDNU5xWGZOR2k5Nmsw?=
 =?utf-8?B?dTR1S2ZCS1IwaTY1VTVQTE83M25aZkZPVE1vVW02SEZwMStTZE1IMy9pa3R6?=
 =?utf-8?B?ZzVTYUw5dUtKUndoWnZ0eStWRjVYWHJQSjMxeE9Rcm9hczhaM3I3eUxJZ2pT?=
 =?utf-8?B?SmNqNzA2UWZjT2RKNXVaWkRtZGtBNXhxQThGR085U09NNXRwckZLL0c3Vmxu?=
 =?utf-8?B?VDBNODZodzk4UG5oNDB4TGNJUWZMVFVQYnpQbzQzWkJ5WG00R2x5MkNTbkow?=
 =?utf-8?B?d1RuNjNKWEw4K3pBbFUzcmlIT1RIWmxOUFpYRDBoNWVtQ3RvbkU5RWVWSmRO?=
 =?utf-8?B?RC8zQ05aR3pNNHEvWWZ0blEvamF1ZldDVnIwRW15MkFZOXFjWVRiT1pMQzYy?=
 =?utf-8?B?bEUwYXVvSkN1OXgrWExUSzJlQ1h6bGc4a1YvdUdTeXFmajY1ZE8xTlFOSHI2?=
 =?utf-8?B?Z0JOTDRRaDUyekhydlpMdXNMbjhlMVhadTY3VlpoeHExdE8wVFVnRXVESy9B?=
 =?utf-8?B?bVB3enBoOUo3TmhVdkpMTHJWNlBCSCtCQk95cElKUndnaHhwNENGaTgveThM?=
 =?utf-8?B?YWlLYUhBVjBUZW1BZS9uNFRVVi8ya0FrRzlVVGRSUituSG9hbTUvZ0NpdEU2?=
 =?utf-8?B?dGpJRnYzZFRtT25kVk41V1J4QU1ERndTMkg4VXdKV0UvSFhESFRPenpQV2pm?=
 =?utf-8?B?cVk2M2hkSWN0cHBrdlBYeGcwY1JqNTk1cGdCQy82VW9zSkJjL2Y0VVpvTWkw?=
 =?utf-8?Q?iTdSXKpqQLkWG7C6j4RqzjCrYDQYQ8yZ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3ltQm9WQk1nZi9KK1dHQ0JKKzlucFdLcnppT1pncUtrbktBcG1zQnBaRS8v?=
 =?utf-8?B?cS9jc3dCUXRBcHhOQ09keEFRT3B5bVdmZDk3N3NUYTR6N1BFOG5wSU50aDlo?=
 =?utf-8?B?YU1iTWFWazBIU1FtajJoNGpQUmhYODNXd0U4RDl1QTVLdEVLS21sYVBRRnc4?=
 =?utf-8?B?cngxM1lWdS9wV3BoRGpGSFJLZitrdnFPbHJGaDNIcC9VbllDRHhoZU9Ua1M1?=
 =?utf-8?B?L1hXYy9ZbHlpV2NHVk1yWDAySkllNzVtNHA4a25uNkhmTUhDY1dXWGpLY2Vr?=
 =?utf-8?B?Vk0zeFE4bGVWOEtKK1dWRkUvT21NYWtqQXd3QTc3T1U1NDZXVzVTU05iNkJ1?=
 =?utf-8?B?c3lDUVFpWXEvNU9DQ2NBZUdXVit6T2xvc3hLTnpzZkFUclBWajdVZ3piS1Qw?=
 =?utf-8?B?YVMrdjJRam9SWTVadHZBbGVrMC9QQzZCdDgrZmV1YlhNT1JRc0E4VWNYUmlK?=
 =?utf-8?B?QTBhNmoranIvWUFOdEFRcTU1cWlBWmF6eHZkby9OSjJKOFJZcjBiU2VaT3VX?=
 =?utf-8?B?L3p1N1Z2UzZqMDVHZ2djR2xRMVo2K2M0ZHJTeTNadVYxUHRHSnc5YldKZVVv?=
 =?utf-8?B?aG92ODFHbWtvY05vZm1teE1PZ09wdWFYWE9LTHgxM0lyTHN1UDhHVDJ3MmZK?=
 =?utf-8?B?VFUzTGRrZTVENGIrM0FFUkJTZVJaRWVNYVY0bWlORTF5U2dRakMxVTRUOXBZ?=
 =?utf-8?B?M3dnVmtJcGJxSlhtenZ0Tkhpd3lIN3hJektJd1ZQUzBUQUplaWtabTRPc2ZL?=
 =?utf-8?B?dWhobG9oMitITWt4VTgvcWFSSEpOMSt2VjZJQzdOSWdFbER6T2t6TWdxd3Z0?=
 =?utf-8?B?ankxK1pYMEhNSDFLY1BDemdRaTZPODdmWlRlUVVEUEdrbXRHUlpOa2doM3Bu?=
 =?utf-8?B?cmJZWnhCQmI5VmpZYUJ0Vm5lSWducm8ySDcrbXlHTGxyaGlLL0hHdDdmcWRo?=
 =?utf-8?B?ZUVaQ2d5NUd6UVJSWUVXOG5VVW9ERVVOOXBWZzloWVBIVnJMZVNaTmhIMVkz?=
 =?utf-8?B?b3RDdmViRWxXRDFaODJraDBobUlwV01oMTRXMk9EcUhETXNTZ1V4YWloMkJq?=
 =?utf-8?B?UHluUmZjTXVyeTlqcWV3VWhtM1lxSFkvaXp0L2o0VG9HNTBleVM5MlNxdGw3?=
 =?utf-8?B?L085OGNGN1BQaEM4eEpZTmdvVk1zOFJMRExJUHpLdTcyQlJqZ3lyT1RKdkFU?=
 =?utf-8?B?OVJLc1hsUC8xbVlRMlFaWlV4NndzclRVMUE5ZGc4MFk3cXJhRGNwZ2tXN2d2?=
 =?utf-8?B?VFJ3QmJLS09zeUxpb1Y2UENyaWJDMEJNY0NLdDl3ZFBHbytxWXlBb0hWS1h2?=
 =?utf-8?B?Sm8zS3MwNmJiYU51RDVLTVJKT0ZTa1B5d1IyZGpkanRLYnRqbEtydEtwVVp2?=
 =?utf-8?B?djRDdHR6bDJoSk1lZCtxSldUY3FQUldZRWZPdWJQNDhZcVFhVXZoR216UUxG?=
 =?utf-8?B?VGNSb2tzc3JQNzJZcjhGMnVnTTZ2UTQwbjd2ZEt3SExEbER5VjlqQS9tSDFt?=
 =?utf-8?B?RmdRMkhKenZWeW5GamZEaHJoMWFodDVhdFhYT21aaGdmUFQxZXAvOXgrVlVh?=
 =?utf-8?B?TCtSZCs1YTdMSW84bW0xSnRlTDBicUNJOWNWSUN1TmJZZWZJZmRmMmsrcnRq?=
 =?utf-8?B?Wk1KTXZyb3lMbnZZbStkUFZ4cEV0Q1dKMEt4dkwzc2YvbEVoN21PRlo1YWIz?=
 =?utf-8?B?eURXMERQeEFsWjJyZTFkKzJxZHVXbUc2b085NGJSVkNUZWd4L1JqYW53R3ZR?=
 =?utf-8?B?bGpySEJEVS92bHIrSTBaOHhKSXlQdHpqajZ2ancxMTJtUmN5ZE9SM3I2V3F3?=
 =?utf-8?B?djF6ZHVPUkhYOXBCcW9sQ3UyZC9taVpQeFJJb2RzK0RnTVo2UjMxQ0ZZa2Zj?=
 =?utf-8?B?RndBakR6bWhCWnZ5Z2dIVHJRR0J1RU5GclpsZUhUZDRhbTdJdnJoVmVOWWhm?=
 =?utf-8?B?RnFVZGxEK0U4MEpDS2xzbG11YWxhZUljbEUyMnczZU5Yb0JjYWcxQ0hvSXAv?=
 =?utf-8?B?MjVqZ2NCK3lTSWI1T0huMFJKYkNFNzBzTk9wY2EydFV3UlFsb0FnRW9XNUcz?=
 =?utf-8?B?MTVtVE13YlRkTFY1SHhZQUgvZDNtOU9FNHBwVTRJMFB2S0pINkY3RUZKRXJI?=
 =?utf-8?Q?XrX2JUZYzqxwH/w/NP6l9kfGX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfb9761-d341-44d9-b199-08dd547fe2f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 03:04:00.1730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O8YkNIO2QZndvazyhAItxWpKIVjMjt1clQErgHd8eqQTXbvP7ftKB4IgtcnlgeZyR8Cikf18FwXN0zwnAChWKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6343
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBNb25k
YXksIEZlYnJ1YXJ5IDI0LCAyMDI1IDEwOjU4IEFNDQo+IA0KPiBPbiAyLzI0LzI1IDEwOjM4LCBU
aWFuLCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogQmFvbHUgTHU8YmFvbHUubHVAbGludXguaW50
ZWwuY29tPg0KPiA+PiBTZW50OiBTdW5kYXksIEZlYnJ1YXJ5IDIzLCAyMDI1IDk6MjMgUE0NCj4g
Pj4NCj4gPj4gT24gMjAyNS8yLzIxIDIyOjMzLCBZaSBMaXUgd3JvdGU6DQo+ID4+PiBAQCAtMzQ1
NCwxMyArMzQ2OCwxNyBAQCBzdHJ1Y3QgaW9tbXVfYXR0YWNoX2hhbmRsZSAqDQo+ID4+PiAgICBp
b21tdV9hdHRhY2hfaGFuZGxlX2dldChzdHJ1Y3QgaW9tbXVfZ3JvdXAgKmdyb3VwLCBpb2FzaWRf
dCBwYXNpZCwNCj4gPj4gdW5zaWduZWQgaW50IHR5cGUpDQo+ID4+PiAgICB7DQo+ID4+PiAgICAJ
c3RydWN0IGlvbW11X2F0dGFjaF9oYW5kbGUgKmhhbmRsZTsNCj4gPj4+ICsJdm9pZCAqZW50cnk7
DQo+ID4+Pg0KPiA+Pj4gICAgCXhhX2xvY2soJmdyb3VwLT5wYXNpZF9hcnJheSk7DQo+ID4+PiAt
CWhhbmRsZSA9IHhhX2xvYWQoJmdyb3VwLT5wYXNpZF9hcnJheSwgcGFzaWQpOw0KPiA+Pj4gLQlp
ZiAoIWhhbmRsZSkNCj4gPj4+ICsJZW50cnkgPSB4YV9sb2FkKCZncm91cC0+cGFzaWRfYXJyYXks
IHBhc2lkKTsNCj4gPj4gQ291bGQgZW50cnkgYmUgTlVMTD8gSWYgc28sIGEgbnVsbCBjaGVjayBt
aWdodCBiZSBuZWVkZWQgaGVyZS4NCj4gPiBhIE5VTEwgZW50cnkgd2lsbCBnbyB0byB0aGUgZWxz
ZSBicmFuY2ggaW4gZm9sbG93aW5nIGNoZWNrIGhlbmNlDQo+ID4gZ2V0IGFuIC1FTk9FTlQgZXJy
b3IuDQo+IA0KPiB4YV9wb2ludGVyX3RhZygpIGltcGxpY2l0bHkgcmV0dXJucyAwIHdoZW4gdGhl
IGVudHJ5IGlzIGEgTlVMTC4gSQ0KPiBiZWxpZXZlIHRoaXMgYmVoYXZpb3IgaXMgdW5pbnRlbmRl
ZC4gVGhlIGNvbW1lbnRzIG9mIHRoaXMgaGVscGVyIHNheXMsDQo+IA0KPiAgICogSWYgeW91IGhh
dmUgc3RvcmVkIGEgdGFnZ2VkIHBvaW50ZXIgaW4gdGhlIFhBcnJheSwgY2FsbCB0aGlzIGZ1bmN0
aW9uDQo+ICAgKiB0byBnZXQgdGhlIHRhZyBvZiB0aGF0IHBvaW50ZXIuDQo+IA0KPiBTbyBJIGZl
ZWwgdGhhdCBpdCdzIGEgYmV0dGVyIGNvZGUgc3R5bGUgaWYgd2UgY2hlY2sgZW50cnkgYmVmb3Jl
IGNhbGxpbmcNCj4geGFfcG9pbnRlcl90YWcoKSB0byBtYWtlIHRoZSBsb2dpYyBleHBsaWNpdC4N
Cj4gDQoNCk9rYXkgdGhhdCBtYWtlcyBzZW5zZS4NCg==
