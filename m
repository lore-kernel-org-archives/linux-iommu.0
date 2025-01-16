Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1294C81
	for <iommu@lists.linux.dev>; Thu, 16 Jan 2025 05:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737006511; cv=fail; b=CpgfKwU3Y9FyCL+0KfoouHWmVafL6VmPC4dbsDuO8hgK+BSd8ramTe6yqRot1YVt74vpJ0kChliSb4a+QfYpcuTr/5sCq0GX/STETbBo9QIZiHeKoCiOI85HtMHL5/D55QesuIEIcYgH3dJj/CBRDh6k//65zANF7L92/LBl+o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737006511; c=relaxed/simple;
	bh=LK8TAsURc+TAc1XzpyC1wxQJNk/h3253Pz0I8tn/eyM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mXVJCluMqcpLqo/X4RmLRFyraO06tf+TCmSpexRGjUNIHigGV8Mzx60c8j9uCmAX3ke6V10ArnBDcHRLNLq62grKk/bm/aVegqsUt15SavqTl+8RZkUK8v22wGOeakbtVbo2osB++iBxF5WAV9y91DSkNI8C7zM/kk2He4R8sVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jW3OGSXX; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jW3OGSXX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737006509; x=1768542509;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LK8TAsURc+TAc1XzpyC1wxQJNk/h3253Pz0I8tn/eyM=;
  b=jW3OGSXXLAMjm88V0wWpXM8c5pr3ZK6ilC4E+cdwozTKpbWRH6vP8Tn1
   N8Ov2ei5eJSY/piChgiN0YdRiRGT6FYu+17EOM4e3yMPyzDytkwy3rIEA
   gPGwscIon/cVnPrLiVoK1OAG4UarB0cnOKJPPIYNcz4E4VH9Wbp+QQB2V
   4hRBMS4oDhc6UaGfZzuAf++dNXejSQUbSQQAmiCOEVbbqEtZ2rQbR1Lrl
   K1LnG6R4gk2siGikNdjvnODCw3Q7IewQ/bHCnmcHtKYq3suC/BsBKfGGC
   uApf1tr72/ZSTTFOyCR+wSpNDzm9CASF0NmjjRtlEXg9ZOF85Th8h9LKM
   g==;
X-CSE-ConnectionGUID: YAmzC9rUR7aPSzRbETIYCQ==
X-CSE-MsgGUID: dT4X51q2R0O8Qp+FfFsSsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="36585126"
X-IronPort-AV: E=Sophos;i="6.13,208,1732608000"; 
   d="scan'208";a="36585126"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 21:48:29 -0800
X-CSE-ConnectionGUID: tXuGRskrRnew1owo5NIRpg==
X-CSE-MsgGUID: yoFHbpwCQ9a+bhowc0w2Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105227830"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2025 21:48:29 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 15 Jan 2025 21:48:28 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 15 Jan 2025 21:48:28 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 15 Jan 2025 21:48:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFo/KjoZvQaEC6E5F+yKM+JU6rE7zLUWb5MBrsPw/UdOuxPpkGDvIpPnXqz4pJ8xFwosc7H5kJriXimTjTyznfnP+4NDPE4zTVksSQJOgD8M7DAi8rtbS4bZbQKA4Zu44rGDOd/8xjPDQGiM0lcfpRgD+PQU42XAVv6y5FGat/5CUujnXT/26EvH9RaqUeEeGB/BA6kC/xFZ99pjorPE5rhWJ/pKYKPDmoD7YIMcXGbKOUp2iHZGrx/yJ5Iex5OzJmO837b8FGynR/rHPq8cJwT8gwsgUTphJkqHjNlZwyKsRRlJnca9CQO4a5Ws1+Fh+LGJVqQsybN8nxQbm9w/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRWKXjD9V3deV030S7CJYpfWfkdR25KB5GyEdKprvbE=;
 b=SI8nthxZhhOV9yIUSYEwsGX54IDG6bFb3M1cj2jG7TmpwfUuwfhPEii8HJZNy86SCYJvLD+qVnil+9jBBt+808Lw+7fBjIHSZJGDs4azDGIqI3BMMuqXRmFGXr66ALIT6TFTSFbnJyiPmgqi8yZo2jFde/6c7KFgMmlNA/2SZYW0VtODy2kT+mxwgwpbe/wslrj1mo6ZHNwVpl2RjSQG5OWKeqmg3IYCIiii9HLQvdwhrhWxgPXyl/Tcd0+2XVUBp+Q6gl3sV/+dYL+7z64d2zkpbm28/Xjsd7oaFiNhHZYOmlO+TuESwGwzty8JG5X3kPUORj+RvLIib/eMlRUD0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA0PR11MB4766.namprd11.prod.outlook.com (2603:10b6:806:92::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 05:48:25 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 05:48:19 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v6 01/14] iommu: Introduce a replace API for device pasid
Thread-Topic: [PATCH v6 01/14] iommu: Introduce a replace API for device pasid
Thread-Index: AQHbUhnUNnXzHh2m/02CvPrIPwhbUrMVTUYAgADFh2CAAF4lAIAA+EowgACqXACAAM+5QA==
Date: Thu, 16 Jan 2025 05:48:19 +0000
Message-ID: <BN9PR11MB52764E8C5599134A211DB3428C1A2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-2-yi.l.liu@intel.com>
 <20250113202134.GX5556@nvidia.com>
 <BN9PR11MB5276A7F34F2B4206AF4233228C182@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250114134530.GD5556@nvidia.com>
 <BN9PR11MB5276D2FD6D1006B1C14087BD8C192@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250115144354.GR5556@nvidia.com>
In-Reply-To: <20250115144354.GR5556@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA0PR11MB4766:EE_
x-ms-office365-filtering-correlation-id: 516e9ca5-eff3-4fda-467a-08dd35f1612f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?dkK07p4W7K3VhtOzQyQGUZxjryYaTU5uDqeYeIDWBxUdTV3AbBRa7/N/TRtB?=
 =?us-ascii?Q?oTlkBSJq3tLOdLVE3X+Ua/EyvhwIl7UUfGkLEGefZpvUFgQQzvx7c0krRSVR?=
 =?us-ascii?Q?w9blCvDkLuMItjOeVqKmvjMLDfio6nausEwWymO20tCAshG1uFWeB3rT/Nkl?=
 =?us-ascii?Q?+g42FVKuq4XA8h0AX/JOiCJU3/4xz4hwNagoxGb0OLeMDmNsW/kIr9Ew87/p?=
 =?us-ascii?Q?9h4EMjEeNsK5QnTorfVF2jv3cAqYbIwE4wa9S/ET2+MSVBnzdM6vlHLbSuOX?=
 =?us-ascii?Q?ze/WHuN3Oh+24fMTfJKjpYY/cA3TuT/sT6rggqjtdA2Ws+biTK7Bf8ulEIUE?=
 =?us-ascii?Q?NE49PF6+47SBB0ncTbTw85eVTTWLax2Pu3odjiYERExwokvH4YaPvTSEX9VR?=
 =?us-ascii?Q?XcMhwMHUtXT2W+ffF5MCOn4Cfax5V0TDTxX2ZVSbZrmNE4EMHJqjeOQxQyn0?=
 =?us-ascii?Q?cPma4XFRhLo19mIsKczf5N5MMLZzyfMwMyspc17JpEBuFJsbZh+V5H8H2GKY?=
 =?us-ascii?Q?0kuE7RfiqBEY8sk0LChCDpekK3Al/kOCxUXGglgAn6Cmaztuz3SPEldvVIVH?=
 =?us-ascii?Q?yosvWN+eGjrfUF48T4bO/R1OAB9TfvTaD2HaRwiLlntEUrlikpqS1mbnsoB7?=
 =?us-ascii?Q?5vpuG9Xdy8J72fPNR3woZWnK6kWaDkBIqr8QfeYywE/5eQOw2nhp5MLstLA9?=
 =?us-ascii?Q?yOXRr0fCdUNTGGYlJgZPUJiQdrhZe8w0deYBPhpAF2XAZDeavqNvrmR9l5Rp?=
 =?us-ascii?Q?g5m2VpUziqgb7oI4exfst0YQNpQRvpITCI95mEdUmJ6zk88+cmTqmbk+Fcrh?=
 =?us-ascii?Q?1gnIUqfPYP+COQ028NlMabmMj/Paz7WG9bmwcmyurFib8Niqi7v/duTve7ij?=
 =?us-ascii?Q?mkfq4QThGYFxXLm0W4sZiUUOgErbwsuavsz7/vHySBVxOfm4695RL5gfXtn9?=
 =?us-ascii?Q?/VfuNJGGykr+1+/K7AknxxbOj0cSrWai8MTnYQaeVZG4shHorwF1CDMVRjWd?=
 =?us-ascii?Q?YiK2D3GtvZ+a8f9uqiSHdhZW6PDBhdeZKWctJwfKN3YUUEjsLCBLhSiLZTbX?=
 =?us-ascii?Q?vu1FG1s1AdD77lmf+EulanQ3+17tIiXvSl2R4SYvr5quYGg8eiJ9W/S9VK5K?=
 =?us-ascii?Q?z6P5hTMbKjvEHVehcsHJKva1cqOH8jI3VlX3CV5o5y7VJfcdSrn+STUV6m0k?=
 =?us-ascii?Q?aeA8AysTj7JQUXK/RNyssS7s2XaEDWy/ODQgNvAvQy7z/hIGzbCiU0fNwmQA?=
 =?us-ascii?Q?490WrwMqSi4Nxc+C1F0mk/RMoqcARRtTdh6q0XowXu/XzsdQ9jTETPWaiI4L?=
 =?us-ascii?Q?JSrbSEokSp1SsoK6Sl3g1/c8hNNhz9eu8mbgmlYONuhV8ubv2fP2CRYEDmiz?=
 =?us-ascii?Q?lsTHysXz/W0VPlWJGFV389E7Te77EB0jFCRvFpsrxuLMRgV2GLDH8w2h+LnC?=
 =?us-ascii?Q?IvRDaTRxGQBRRxFuhufxdSpJX1maY/wK?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LVHVbvbzqcMSPTRPINdrYmQD1HlpNFwoEOrtbMuaV0rPgZOZgeGKDdsE9ENm?=
 =?us-ascii?Q?JFC2FYnCoy7uVyXIFmVAsHFUs+pzWuCdIWOxpR1TxiiuAETvLB7HnBBGXNFs?=
 =?us-ascii?Q?448Qale3JJLiVq918GfHqOpo4WaPSjFjwZdkPEfcGNUomJJw4F44A/EzwfDY?=
 =?us-ascii?Q?ESJFikGUE2TX24S8w8vR/oVvSN5gHv1XINw0X/IZLL0cmri4pJt6IToqNSB9?=
 =?us-ascii?Q?MrTzwPdsIRnTdh4WNQ/nsBLFamc4W1rOekTTmJ0GbgSEimdIUmR7Ivp4ZMUu?=
 =?us-ascii?Q?iooKaM1I53x/7ATDAx6WXEYDNjJb/k2ypOEQDqfsVLdxMMX48W+gY2h3rTSH?=
 =?us-ascii?Q?/XG4H36TS3a7rd/59yZJmRue1r8u24vI8dodCWovk4rfbtcRVOmag+OaAsxn?=
 =?us-ascii?Q?zm+4IrM4vHXeOxE99eLpinwlHrs+iOIMNZgR5Nzgfhmgm0yOq9PWuM+5+TGE?=
 =?us-ascii?Q?4GRNtXIkF4veKV3xgsbvPkoZVKMHWSQ00eIxXb18NSBte4oAWBiNwzaXu/Rx?=
 =?us-ascii?Q?x6q6ZKI0WQxMpStzazQtEDcyFoZqYL/sZXIKi2G20LPGG7QqbBOM3Z6M83HT?=
 =?us-ascii?Q?tlHuyN0b11oXXLnS7FlB9coJ8eDBph58pnAWdSezD/xjaPNV5sIeTZQmGqWF?=
 =?us-ascii?Q?0pZ1CNFFby2E5wqWzcT3q4lkyZHYTveqHv5CRnJmUwTW91S6KW/SSLzSHAjx?=
 =?us-ascii?Q?Htu5EdU37WYA8sui85dY5YuZbNoX0SPt3Sl3GCiyJLqLrlgckyN+HJWtkL8Q?=
 =?us-ascii?Q?i9ywrQwzuR00f1o+TX7AJ9v6sQI0vkRkI2ZY+5QUjOr92CtqpxxBdhve86qn?=
 =?us-ascii?Q?RQcEOhUB3qFYGUEFHGqoBSJQbRFxZ7VhYPsZqGWcPNE+0Pn3LF7aRSjijzl/?=
 =?us-ascii?Q?5ke13ZucPdIi8EmQKVkvdMQg+scMr7ID3B1JoO9P8W8Kiq2RCxjG/SODibyZ?=
 =?us-ascii?Q?ra9dp32A/hRPrXLSSsWhIABOxEfVRp8scWJxBmdojGS2yoBEF00heBOJbQe2?=
 =?us-ascii?Q?S1POWbC5w7TamGXEhKm+4YOoT02FqYV0pdSuN3RS4ZE+lY3/2Wv6Qou1e8Up?=
 =?us-ascii?Q?1OoUn/kvlF6w2t/I1YWTvFfIb7JoL/4E6CPYCX6pf+oA5CcAFij4PrBi/dcU?=
 =?us-ascii?Q?Gq+nP5tiAHFt+lFU0bW3Ms/S22aOOz8mo4qslAyA6fDisTED2Uwnxz0WPJ9n?=
 =?us-ascii?Q?KeiRCcnaPim5+2K15E7b8WUj3OP64BMOfCFeKf/9ThzHdmPLo+5aW4Hobpq3?=
 =?us-ascii?Q?nIz6PYFVvSzlrk5KQibbw8SJQfCGlBWVSUwVTJyeUlPRFmCcXLgHLKw10fKh?=
 =?us-ascii?Q?MvMU//08DMyIzXHkbIs78NirOi8TM+JKG1/WC5c40pgnk2twz79O3eyd0bzw?=
 =?us-ascii?Q?L8CzgVfS8K3F/MuE3efs/AIyScMq7TgiE20/yv+Kpgv/vs/KEd79emEkmW/c?=
 =?us-ascii?Q?bdYXLhl2WVZhbxYbAE+irJx1RFeqbJM4d2I7A4SC7sFN7fW3zdIM6w15OcP0?=
 =?us-ascii?Q?1fFG12G4AfBoxc1tDa4pSj0bR0wrOTgUfNJ8g3sWSeGW2Xija+HxpEHjd96F?=
 =?us-ascii?Q?84BtCJfC+PzTZtG+RxgU9c8uPPLkPwR9g9rrdJSK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 516e9ca5-eff3-4fda-467a-08dd35f1612f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2025 05:48:19.0201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QMsgY+fKggDzpqsn9L0kyNtWCBuJIQVXAxD+tHd6OCw2RGEnhycZjSY4aDhOxTr+fKzg92k4uh4VncCDeHk9gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4766
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, January 15, 2025 10:44 PM
>=20
> On Wed, Jan 15, 2025 at 04:43:41AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Tuesday, January 14, 2025 9:46 PM
> > >
> > > On Tue, Jan 14, 2025 at 08:10:41AM +0000, Tian, Kevin wrote:
> > >
> > > > > > +	ret =3D __iommu_set_group_pasid(domain, group, pasid, curr-
> > > > > >domain);
> > > > > > +	if (ret)
> > > > > > +		WARN_ON(handle !=3D xa_store(&group->pasid_array,
> pasid,
> > > > > > +					   curr, GFP_KERNEL));
> > > > >
> > > > > I wonder about the ordering here, is it OK to have PRIs being
> > > > > delivered to a domain that failed to attach? What cleans up that =
race
> > > > > condition with domain free?
> > > > >
> > > > > Should we replace the domain then set the xarray? (and same
> ordering
> > > > > question for normal attach)
> > > >
> > > > That makes sense to me.
> > > >
> > > > But I don't think there is a problem with attach. xa_insert() will
> > > > return error if an entry already exists. So there won't be any
> > > > PRI being delivered at __iommu_set_group_pasid(), no matter
> > > > it succeeds or not.
> > >
> > > It has the same issue:
> > >
> > > 	ret =3D xa_insert(&group->pasid_array, pasid, handle, GFP_KERNEL);
> > > 	if (ret)
> > > 		goto out_unlock;
> > >
> > > 	ret =3D __iommu_set_group_pasid(domain, group, pasid);
> > >         .. Concurrently a PRI event is pushed to the domain ..
> > > 	if (ret)
> > > 		xa_erase(&group->pasid_array, pasid);
> > >
> > >         .. Now what? Who fences the PRI event thread before the calle=
r
> > > 	   frees the domain ..?
> > >
> > > We arranged things so that detatch would fence the PRI, if detach is
> > > not called then there is no fence..
> > >
> >
> > Though I'm fine to change the order in attach too as it looks more
> > reasonable logically, I'm trying to understand the actual impact of
> > the original order (e.g. is the change worth of a Fix tag?)
> >
> > If there is no detach happened before then it's the 1st attach to
> > a faultable domain and PRI will be enabled right before this function
> > hence no fence required.
> >
> > Would a sane device trigger PRI in this window?
>=20
> I would say this is not a "sane" scenario, this is a theoretical race
> triggerable by the device. Perhaps a VFIO user can force the device to
> trigger this race and exploit the kernel.
>=20
> > If it's a detach-then-attach flow, detach will do the fence anyway
> > before the attach.
>=20
> The issue is the error, once we do the xa_insert() then any faults will
> get routed to our domain and the fault path threads will hold pointers
> to the domain. Once the xa_insert() is done we must flush the fault
> path threads before allowing the domain to be freed.
>=20
> If __iommu_set_group_pasid() fails then we do an xa_erase() but
> nothing will flush the fault threads.
>=20

If __iommu_set_group_pasid() fails iommufd will attempt to disable
PRI which reaches iopf_queue_remove_device(). The latter auto
responds to the list of pending faults.

But this is not a reliable assumption e.g. when multiple functions
(VFs and PF) share a single PRI entity.

So I agree it's conceptually clearer to swap the order of updating
xarray and doing attach.

btw in reality this won't trigger any issue on VT-d. The spec says
that PRI upon a non-present PASID entry (the state before attach
succeeds) is auto-responded by HW as 'Invalid Request'. So the
entire software faulting path won't triggered at all but this might
be a vendor specific behavior...


