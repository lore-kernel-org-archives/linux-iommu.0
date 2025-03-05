Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1509D2B9A6
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 02:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741142194; cv=fail; b=swfmaz/8mChei6aEZr17FUrRuA7hSZlEl4uZa1j26DKQjgXK/PZ5sZp4i4DrW85oa5k+QRHcAEVorJGEJaN8kluFU5gzvNTP3AjsOyq3f0yibjO3NFwI1lNzNKsA5WCb3Jy1rWMeWG2KX/Ode9HTmCSRKc8ubrIS29WcQQSHIAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741142194; c=relaxed/simple;
	bh=3U5ia6sQoCNuabCvQgig/xFqLrqvzynzWWnXtOY22VE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fT9pHit2sG70ZvXSAQft5Ry+9ggBDeNGHKknxhcGI1GVjGchMgYQtfGpv/dymbHsA3Vp7rlPs8tjrihJpHd4JPCLj+0TL976+qo5TrVHIH3RXiQz1dE4+pE4u+xAuSSM7qfTJYX8w8en/zGTOcv7ObkOJ7efsFbPYl94sbJ9H44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NXL+eNjB; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NXL+eNjB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741142193; x=1772678193;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3U5ia6sQoCNuabCvQgig/xFqLrqvzynzWWnXtOY22VE=;
  b=NXL+eNjBKbmXzB7fg6BY1cIcbHGGXmHuoMBWpqlzVfjNz0HfGHOCP1FN
   aCK6Dz1hM3TioCZIH/M86eQjUbR7H4jPryZhxmFEBAC3K8koRA9ZqBkh2
   Q0l8Bi3ZwY/GzAMbXR1LpNHlD80hl69sK3dmluldazS6LzkrVGG1jkYai
   /E0aYLFOoYVg/59DknZJLRtxN2rySS5yrRTFadayAhFEjFQGyiPDlX6AB
   QJm08ovdwMjTuY118qwMFTX9FGrZyHgNbYNZfRqE+58Fy44YeFku2+eQk
   nvwDqXv6hOMO9Z1UooVQgsKyhSPdU54wQxUYKn3smOHM+6lkiRFxrZb0B
   g==;
X-CSE-ConnectionGUID: /iL3zKUvSsmln0GUCM15vg==
X-CSE-MsgGUID: Mdt8CWv/QTix7wqCGGqXgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53487718"
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="53487718"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 18:36:32 -0800
X-CSE-ConnectionGUID: m6AFedenRWG1UeuQ1k4d3Q==
X-CSE-MsgGUID: o8dYmZjvQz6MQAOw5G9tuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="141801507"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2025 18:36:32 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Mar 2025 18:36:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 18:36:31 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 18:36:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTjfpj2ZiI86iY1471n/7o3JHAVOttZaZhQuawYw2mTYlqU1CQpckw/FB0fuSsnsVLu4b5WI9nEQBFplALrHU72df4qcz9idW5AS2GPJo6NKAyT2MXVer/G1BGqqT4bEYRoe45eXE5o+An6h8oiXDuvRWu1MYaf/oIk5eoHz+t65Ny3P1F0oPNxpPP2E/FpadAWxgLl4i/NBBobXVUjMlRXsOSsxSFQhtxUBlEmxi9LrEx4D08Q18u79Mc65Z6R4NpahlKKVeyQoaTUqM5EfptQcCu3aJh9YqDfGjqvQCb4HWAPx1u+nKerh+UAd1oac5UhOZHyvLfUbf1ywP+qu5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmweNOZW7HyhHqN9wwPQs4x/GKRLKLWTsOe2QeBtr5E=;
 b=rW1cW69nZKtOSDwnLF/hz2lIqygCmjT6ABPBz6DidV2FQWOybzX8bRf/v747AEyOombd3iBZ2BJMkXF0FSzacC3wiDhbBp7qAKe/arldFgU2vSKVRiRc8NbnXr9YtZUUNmJdcc3Xr3awnrjUbctZWrzJ+7VsgFWaipT3HPkJ1Uz3HauZQ+y3PlZnG74rLu40fH3OOsWfHzi2J7594Q7pD3r02+428cyK9HSsKH88NC0WhNg5Zxd7X4J6Kiuo35/XRlXiOYQWQF8WT5BAjv/AL0JjdRXZZKdqOcbbdsvKwAVDYbaoVqzjXyApGm/lRvmfxFxyj71EQut+8Z+pQoPAqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7410.namprd11.prod.outlook.com (2603:10b6:8:151::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 02:36:22 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 02:36:22 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>
Subject: RE: [PATCH v8 02/12] iommu: Introduce a replace API for device pasid
Thread-Topic: [PATCH v8 02/12] iommu: Introduce a replace API for device pasid
Thread-Index: AQHbiENI0uKMj4a/aUCaCEmKzzgKvrNinyxQgAAU44CAASkQsA==
Date: Wed, 5 Mar 2025 02:36:22 +0000
Message-ID: <BN9PR11MB5276F2ED0CAF0C47BA8125D68CCB2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-3-yi.l.liu@intel.com>
 <BL1PR11MB52717ECA943E3A2D5D1FB6E58CC82@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ce7010f5-57a5-4b16-9448-d2407ef8961d@intel.com>
In-Reply-To: <ce7010f5-57a5-4b16-9448-d2407ef8961d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7410:EE_
x-ms-office365-filtering-correlation-id: 45f5cc0d-2f7c-429a-a68e-08dd5b8e84d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?aZsKumehsh/8RR3diZZVQ4Ca45EAElohSvo5Xnp5UF7RFhAd48Tpel4uPjMl?=
 =?us-ascii?Q?El+iyVUEFtxZgdMl7e5qbmRK0yWV0/M5s6QYeCedyfd+IhXtWM7gvbqcxNeP?=
 =?us-ascii?Q?vUCSufGd3xZjNzhF+w9h4g1FOo5S47hO5E0U0xRdrp8Q7liCasAKCAxwjubz?=
 =?us-ascii?Q?1tFW2jRFkKwLgKtmO48o0rhUk8df7gOZ2fO4ohVDYZNv5i9pVgri6QyFz97l?=
 =?us-ascii?Q?3gqNs9CxYyjDDYd4St4tlB3x5S4haEd8UUS+WqFnTM/nCt5D22zvv/pgt658?=
 =?us-ascii?Q?jPEtMV02xKi5ydemJO+a3LCkGu1N5NVr6ahD2rQTx0V6wiE7ftau99RleQPm?=
 =?us-ascii?Q?3BrxpFN4mkFo6Uduim1fsoEVgf/KSNrWmPLngzUeeiS+fDdDKTPwZ5AH8c2E?=
 =?us-ascii?Q?KFZCqqvTFaeE/z+HQUXQkSy6aR9dgS3PzRzcAOJiRon+M6gUButIydutUvaA?=
 =?us-ascii?Q?VGEaO+WnWIirNHuRk1fcftoPjRMst3t4uVorG6FPpw4hh7vZoISnhHUQXtcm?=
 =?us-ascii?Q?+oK2oIWJumFDQMki2KEXuaYjsqiDSrBrf5Sql4wHQGbzb+i5+NDbpuUFdp09?=
 =?us-ascii?Q?7Dqua0d2fsksMu/UQqw2+4qtJ3KfgEOCCaohJpMpIiM9K0mgShc8Z+ABslae?=
 =?us-ascii?Q?X7mr/Y7FvnDcUAsEOKNdY5G8SauOqt7cdNZ9dvHEhip6izf7e2xpi9o5pPKT?=
 =?us-ascii?Q?/JFFeH3cAOgWHtdHQsl2Ud6t9Brb0Lg6fr0OltpnoCV8K0q7mHAsUZ80/yBQ?=
 =?us-ascii?Q?CSRTcIL7d+RLLrN7YLARCfXXmrlVNuBI/DLxzWjh4zv9X+nAxrUP4JIrMKi6?=
 =?us-ascii?Q?clGuPxrETcJ8wd2g7M590YItteAqqtLvCcEO/Ojs/ehB1rxuAEFXANRqI6JD?=
 =?us-ascii?Q?JX4psEbGK/W7Bsnc37WhAx4NFSwdzLMbPlr40yECoz5vW6g5rAkmcnsZLT7i?=
 =?us-ascii?Q?3bDFj0heI7bT/2vRRCbE7aOQ1z8uq8CjOmd1oMn0HXCu6pHSQWslduqPHpV+?=
 =?us-ascii?Q?7zyxTETz/kBJQHjCUsdYljOVhOxjfyJvtGri1EUDZaxqrp4iT61hgoma6jXF?=
 =?us-ascii?Q?Rcv6Z3Hn/pIkZv/cCxMUrlXlbnEIAkvaD09SAIp+qbhJulvuClTrrfeT/exA?=
 =?us-ascii?Q?zynQdN/7iOhP7osp7/2lp9qr+5Ji5T4rYuyCrMkf5H4gdMprHob579+Moz04?=
 =?us-ascii?Q?A//uBN2VrMBGn4yvsMxxJPxsGVV3orVtGK6gGrQE4SmEI/6GBWK8iquh4F1o?=
 =?us-ascii?Q?RNiTAoX779gv6GJuU1JVTrlGX15nBqfSzFkTKlrjPhTsepVfP1UatU0B7e7J?=
 =?us-ascii?Q?TMYztAqXpvwdPoa3k4BS/0TkO636WDML0vlmvl4ZWxBQVWJpQS/7DVIiNV6z?=
 =?us-ascii?Q?q28vrW/YzOKwVcSNGHMNr8biphpjRlf3q60LR7Ma2Gc7K4Fc1GSLvZeNJkh8?=
 =?us-ascii?Q?psAaZxpnucmO/Tq5ZB3qGvpgcMFURPYc?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GT2iOTNGpgMLorcLuRs0YTG1QnTiEOCdu4PtrcdKqbzWQNC3LiYhbiuJpjLn?=
 =?us-ascii?Q?upQv+EPfcG1NWUYSxOuR0taUviQaKPvj6MblRG8doLzMcVbwMSxx5q9HBdE8?=
 =?us-ascii?Q?olyqO8BPqHHuPdDV60v/UrrDDrlXHE6O1CPGznWa6O/qpU8y5Ura+S6qsg4+?=
 =?us-ascii?Q?rGaNaL6jo6FvFQnDhbVk74iUpYfzDHVSjiWR3OvOh195bnz7ol6j3E2il7hH?=
 =?us-ascii?Q?6f1dI4ajnmup2iEYdEWETe6F5y8FwyR4FvpYx0aDkl/tZocT9duhgaUQbFgf?=
 =?us-ascii?Q?HBFLvo0dlizoqnG5PtbKhZPDSrjg/YwKJuSX576E9fVWE1Ry/PZnlQR5LEx/?=
 =?us-ascii?Q?QEjOmTfZEpQfeKkPl24Lktz0pbl8PUpPHxb10zcL6PsW9qhzZVk6Uz2MZj4u?=
 =?us-ascii?Q?ymjjwuoPeqQWB1e6cK3xL7huuwqhEqI3Qp5QMaz26tLqfcxLBvZcmWmdyBK1?=
 =?us-ascii?Q?LzjemX9KQBm0ko9sMoQJ1JtLGiM5bM5MP38NDMkdJekPQ/KjG2Uip4caXSRn?=
 =?us-ascii?Q?BLgP//CGeXb6B7fK1JtKcYoSUbJZN2e856gwK/nobJPZ3Fm8kgEryhzdihZo?=
 =?us-ascii?Q?pCwD0S6X1t3/Vu8n0PuEmlsIdJ+uEZjYWimf0QDxzxoTbSEbPlSR8gd4/fUP?=
 =?us-ascii?Q?LeeG1jE9gh6XEiozFUc5KTlGEbP1u7/VU66QnDwxqExHkM99h23Bvplw6FsF?=
 =?us-ascii?Q?enmHF4YiufGAsyX+XfMxV8exMSXiOHBVgAl751ZnxA5aTxSV0qOAcoU0khgK?=
 =?us-ascii?Q?BbAfKrl/48EGvkm3xJow1cKDdnmTa1NDV6gH5ZDstf45DWTN2Zbczmd/Byjc?=
 =?us-ascii?Q?8b24xPlYT+9/lWUpIZflt/1ZaiChW+223lK9ZJtgHF0snuGPGxmdFne/lOQw?=
 =?us-ascii?Q?E8B/5UE6grg3Wt6LkVS8br4K3d1wuAI3xmT8fFpIiPBJXh0wSB8s7tCmcgv6?=
 =?us-ascii?Q?+ivwFeTELJwy0DCRYwEo16I0ulDfTUvKb3+FhBLGfxY1BfG9rpAKtjsnAUKK?=
 =?us-ascii?Q?mjBNphWftd58lm+JfUHfJYuV79fXMkXDcC7xFS0A5kim1ShyrRaVM7V1+i7u?=
 =?us-ascii?Q?1GU5FSp1T1ZerI49vkXB+TlR4nZSkpBKBIQF8j9tWO+B1WGTiZ+4adUXkjHd?=
 =?us-ascii?Q?TkGcW/+u5xw3dL7IWXcMTabqjzm0BLe/ODzwRVE6Rq0gTcETueDVc/fpSZ7A?=
 =?us-ascii?Q?LbVhdI+T6V6/REs7xbU41vOPoQcv0a7gDOCtyD3+qZi9XAug7c//2KbqO3Vd?=
 =?us-ascii?Q?S3+3++jm3UIqRp2vbqqf1epAAUsPjAnZolHDQ1ND8JV4Fikfw0dMypo33VEx?=
 =?us-ascii?Q?0kuS9MB5c+Gt1eWitn5r2PA4tI8sMHuW7AV1vHB9fzVFRvCJaARp+WdC0eyZ?=
 =?us-ascii?Q?eahMPhKeY33FXab6E21gkftP55Jhf6VzifEADZ8RxetEZeFR9OmOVpvl+/1K?=
 =?us-ascii?Q?vib3dCLBwwKpgEx/sdBR94Q3F/EsIgj/Bq4aB+5YPjyedJcdb3wEY5qMsf32?=
 =?us-ascii?Q?QpNwNPwDRgzH88+bAsxovrwumaXtscqtGpZwW18ovo0DnXXlDDe6d1j9/oIt?=
 =?us-ascii?Q?ZyHqdqXjd9q7Ti0uDIw3xhbE6qwz1l7Gj+kK3sqm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f5cc0d-2f7c-429a-a68e-08dd5b8e84d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 02:36:22.8072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 24K8cAT34cm2pJsKK7zyQDNrDutT9oUA/Cxf/8sJzwnUawdFI7b6aDW+FEY0iaYENVxPeZBNrruqQFHAPyV2NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7410
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Tuesday, March 4, 2025 4:49 PM
>=20
> On 2025/3/4 15:42, Tian, Kevin wrote:
> >> From: Liu, Yi L <yi.l.liu@intel.com>
> >> Sent: Wednesday, February 26, 2025 7:40 PM
> >>
> >> -		iommu_remove_dev_pasid(device->dev, pasid, domain);
> >> +		/* If no old domain, undo the succeeded devices/pasid */
> >> +		if (!old) {
> >> +			iommu_remove_dev_pasid(device->dev, pasid,
> >> domain);
> >> +			continue;
> >> +		}
> >> +
> >> +		/*
> >> +		 * Rollback the succeeded devices/pasid to the old domain.
> >> +		 * And it is a driver bug to fail attaching with a previously
> >> +		 * good domain.
> >> +		 */
> >> +		if (WARN_ON(old->ops->set_dev_pasid(old, device->dev,
> >> +						    pasid, domain)))
> >> +			iommu_remove_dev_pasid(device->dev, pasid,
> >> domain);
> >>   	}
> >
> > My comment to v7 was not fixed. Above trunks can be merged into
> > one call.
>=20
> oops. yeah. it's missed.
>=20
> I'm also thinking about if it is necessary to call iommu_remove_dev_pasid=
()
> when WARN_ON happened. Ideally, we don't expect it to happen. If so,
> should
> we just drop the iommu_remove_dev_pasid()?
>=20

keeping it avoids any undefined state left by a failed @set_dev_pasid().
attaching to blocking domain cannot fail.
