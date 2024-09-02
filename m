Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E68144D0A
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 05:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725255860; cv=fail; b=k5bZdrpeoymDmiFq9ZbAAyYzR7GM2UPQx7zNJA1XhY+JKW+ZlrX80Hvk+b80FKNZSnhNbhTwyf9rtXihCQEZ/Fv1iI9lBrx2UvFmW/Y3jGbwnUDc7k9lPc9bD11HgV4sq8aJp9azqq0FmFS9IFtstK8j1Dct7NhsP5LZ+iyh9YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725255860; c=relaxed/simple;
	bh=G7hx0MqSa8wwSo1kLIYd7m6EoiYM4hvicyGcVpVOmRw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ChIdB6NVwk4O8A8OH4TJCKjh2+ZmZH0LvxGyi4WgVTlqE3MJzNoh4osBkVOFJoGDFMyIPVGkA1x18zWFXiLfaP1co/KxRLaKyQyGta5fZ4b9y6ZH9RVRpvGTEfYLXvgmH5/HwwHfnCC7oR+y8B5uEXXN7vvrP3lZ4Th8rC1sdLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LFEk1Jlp; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LFEk1Jlp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725255858; x=1756791858;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G7hx0MqSa8wwSo1kLIYd7m6EoiYM4hvicyGcVpVOmRw=;
  b=LFEk1Jlpqe49YHkXiy507JwPoiACTyJhOgTbxfFZXTASn2A+jlh2f6JT
   5AzZdjzeewaYOvSIv5CrcMMfkPuKUmTkQwPkRUF2+10p6FeELk4oblbuG
   S99T/G5iIEmIVU0vm8F3zmRg6f+s42ICdFKAZt0lZMqP5PdU4M1VqTfOy
   hoyNKffDQv6AmXp4HcC4XrPIHy8m0V9i2UZl8rWUZjCAXpxHxAavckedN
   QdZzVq+OUpsamhNmGL0FK4Wy7eg+d6S57c0WAakz00ahpG7KCz4lXf+fL
   iG7dGT9z6KzpKAZuWRovuvtQe8Fc+ek8JnAS0LdmGRxoc+3ch0PEKfX4E
   w==;
X-CSE-ConnectionGUID: go1Zs4IEShixtrdcfHaCpw==
X-CSE-MsgGUID: KsIseMBQRLWLbvWziC3RDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="24004037"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="24004037"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 22:44:17 -0700
X-CSE-ConnectionGUID: PXVPKjbiSy2OssKelVo+yA==
X-CSE-MsgGUID: Sn6wlFReT82078RZjZVJeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="68902968"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2024 22:44:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 1 Sep 2024 22:44:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 1 Sep 2024 22:44:16 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 1 Sep 2024 22:44:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uu07u90UKqOu4bvQd5S0P+8YWSeN8/uEQMt4TxJjbEVOvhFjVJqhYz1tQECOcLJx/4B0D8SJiIkO6r1fOeswwRqJrSOAmU1d8qsrxmU5Q0qgVKZBWlHPssZVjvptlQcGGsQJ8zZx6Y0N0ENzIH+AbOrGBuQ4P+v6o8jkPvPuqxx6osRcis/3c3Rboe1p68+e+RJKtT62QfHFS9yIg5wl99h0C71myBxCzmKmTPxTiCAuhkx+7NtLAVo5BlEFOZ76nf62yRPI6h5EVW/wt4OMZ0XFxr5NHqgFmj0FtzyIrBINcCT+j/hMSMIqR6oW93Z0pp4U/C2sedjDZEQuanbx2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41WFbkM2dNX6DfdcZ9MTQ8d7rMjr72ODE4UOSft26qY=;
 b=uy5sBNXl6Ee6/4skGZgGUwQth53pCAEZHTCn0ypbKcB6psKCi+LfCmOGW5sCBHjniFjKYWNWmap0NkcQzcOubzGceaSdtAo2nwdlNEQvL3/JYZlVAySqj45rsu2ezGg1fiisykh+vK9oCnasILj+YsEkQ/yoG/lRL4THiobsa5xEmfht9hOIKatZhAyqii1YcVRj2Zm05eXDEXKSpVP1OSc093a/GktJIeC2KIV/aWu8+dSPAsNN4fjUyGPxQ/qJ8srD0qAxCbSoU3vMLT3f9bv0FQNCHjW6rUtDmNj08ANV3eLW0JABTA7CoQXfJTOunHFg4Z2ECgJ3cvKPnV1Z8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5275.namprd11.prod.outlook.com (2603:10b6:408:134::24)
 by SJ0PR11MB6742.namprd11.prod.outlook.com (2603:10b6:a03:47b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 05:44:12 +0000
Received: from BN9PR11MB5275.namprd11.prod.outlook.com
 ([fe80::d113:e69e:54bf:3fea]) by BN9PR11MB5275.namprd11.prod.outlook.com
 ([fe80::d113:e69e:54bf:3fea%3]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 05:44:12 +0000
From: "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, "Tian, Kevin"
	<kevin.tian@intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, LKML
	<linux-kernel@vger.kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Zhang, Tina" <tina.zhang@intel.com>
Subject: RE: [PATCH] iommu/vt-d: Fix potential soft lockup due to reclaim
Thread-Topic: [PATCH] iommu/vt-d: Fix potential soft lockup due to reclaim
Thread-Index: AQHa2gc92sMgifw/PU2hpZyfn6cIbbIFhW+AgACSwQCAAItBgIABVtmAgAA0QoCAACgrgIA76dNA
Date: Mon, 2 Sep 2024 05:44:12 +0000
Message-ID: <BN9PR11MB52757A48BE716BECB20FB240CA922@BN9PR11MB5275.namprd11.prod.outlook.com>
References: <20240719181725.1446021-1-jacob.jun.pan@linux.intel.com>
	<BN9PR11MB527638BC2FD50C4D90508D578CAA2@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240724092540.6ef4d28a@jacob-builder>
	<BL1PR11MB5271D3D84F93BA16852233F98CAB2@BL1PR11MB5271.namprd11.prod.outlook.com>
	<20240725141111.6889dd62@jacob-builder>
	<BN9PR11MB52766AC7AEFA103E5B1D067B8CB42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240725194159.41192480@jacob-builder>
In-Reply-To: <20240725194159.41192480@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5275:EE_|SJ0PR11MB6742:EE_
x-ms-office365-filtering-correlation-id: 2c4e3664-4ea5-4037-e8d4-08dccb1245d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?sjuiebC5FXAb6rBNC/5b6b6K+xdDf5iQGDq4UhnoiUxAkcTHVV9FY0JmoHE0?=
 =?us-ascii?Q?iH5LNWvoNq+IotfAv3AHdBQeRkrdQkHmT1WyClx4tizJ2351uCw/LZ+TdX45?=
 =?us-ascii?Q?BQmRRyjl7Vd7UXlHVBt3Qoz/FpL68QHXkjLSrzE+77poL7hYiQvodeF3Lon9?=
 =?us-ascii?Q?+PcEJwrwt7aX3g7pjTjPJrDqN4OTDiXE09En5lQ5cLdrHs2TxLBZp+jq7EGh?=
 =?us-ascii?Q?auA852BqLFumb6ldZwvlCQagLVKj5G8vLYvfUGcVet7Vf+3CRRPG1+IQkNH2?=
 =?us-ascii?Q?XQaHkl6FcQVXe+K5SwR9UEYo5KSS+UbxJz5U5fB55gE4P0bCfuNL6/6+eGBg?=
 =?us-ascii?Q?LPzn3AEOV28cXS4EiKbIDPfu4wHo3DyyeeOYqc4udwuyh1cw9e6gPAzPwVLA?=
 =?us-ascii?Q?xGlE74FOBzqzYnsMSSrtuO27Udxp+W/d9EqSS1vU0vYnCkh3LKyxHmSEN638?=
 =?us-ascii?Q?cO5t4rBpX9/uMjmdWfXMdDZA0hsc9eufGCBeLYLFzuDQEBdcskh4r61awYkN?=
 =?us-ascii?Q?0uBnUeslpSSCkNUJvlEiTMVJPOtjtitMF9SCJtMixQckVveWJeSi+RUDo48r?=
 =?us-ascii?Q?55rrmeSWw6ZdZDgyFhLbvaQOuI0AgmwgL6WFdwsPvfCnrsTi2DTldtjzbTxY?=
 =?us-ascii?Q?tS9Cd8B6irglbYYxx+nRgA3SS+pdqf973pI/b0wA0DiNl67V8uG3WVTZI5m0?=
 =?us-ascii?Q?JCbEeSQo7mu5mcgGtFpe81F5TIVYnPU1Z7uLYAnrPIzw1VkWyy9dIWgwhxsV?=
 =?us-ascii?Q?GMQzBG2UkCCoMKQ6ibDMCzIOGvAQwLKpNNYkCi0FGhgeqamWyFyaBmc29AU7?=
 =?us-ascii?Q?vG8mD7cyGj51YQAnDVpv+wwEQLf7HhlEH3DrH0NMvYOEJlAMDmI0xCTrtj11?=
 =?us-ascii?Q?gU1sR8OOjHWwI80C6LPSmz7rUm28BFHNLCYBjJkuyHsnHyNhJ2+PIzsMxpU1?=
 =?us-ascii?Q?mxn1kZk5NhkT+3UPCIe7kYTQTa+Q6OTazm1+HUriRtAEbJqnos1u+HLSuf5L?=
 =?us-ascii?Q?GKNzJd2xQO5guYzQuQ8ZRd27Et/UdaWuCIXl4nMJ1QHGRwZv/ZDH+elk9MCN?=
 =?us-ascii?Q?/7ovak4TwRfBRSdSE78D6+JfxmqWweNG+RNAcYZo04na/bhotlr3yn8ehbXv?=
 =?us-ascii?Q?IHmVcpizctk5RrzBAmen8mjlfMP5wnGG1IkHUf2/pdKtQrOAbaxYJ0CTXdPB?=
 =?us-ascii?Q?CR9fRAC2NNFHE+Lt3vq3RqEWQFc5PcJzrpCasxcuDChbc+d1CCpb+LcLmbPk?=
 =?us-ascii?Q?QX0D00rm2IwYumPD0qQWFv1CDTiWA66/npO+wOTz4Lx9U3MxNC5I6h5cH4Dm?=
 =?us-ascii?Q?cihncrjczL8KcMQtIFRwNwU2koYzUysc9qQ9RLVU0Nzax02YwY43DOhsImxx?=
 =?us-ascii?Q?Cy1sMvmkBm5e5oO9meEhOtTPQYwI9HedDLef4Duu2uvfRCj+Lw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5275.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yAEoQYBmScJVE0NQtVZDfD6CgVIizRqhqHJTSyVcrBrdz0ERkPo3mqqONrp8?=
 =?us-ascii?Q?u4TlhQcDFaDD4qTiXPjFmLV4jROG9x0k7U+9ouNMUmQYgdSVF3qE3/2ADOBq?=
 =?us-ascii?Q?MzcmQIeq9eeB8BlMrNPS6KfhdJ4OmZrj7IEuDOBMZmoVx2GVB77lxvUTuJ6N?=
 =?us-ascii?Q?4Y1THVhBcDk+mUzqETXnLYDn4xb6gZYXmpY9kOsrmEWoSSprHylI4N+9eiIt?=
 =?us-ascii?Q?qcBAet43qhOaFAq1ZPELhKHADz+v9JRtruF60AXVz5olnRH3776P0Q9DFcxl?=
 =?us-ascii?Q?aqu/0tIXHI7lMqxckrtfBzJTsaKWwJJxgt7HaNiMu0oKPh5GZzQKv/DgAK1v?=
 =?us-ascii?Q?zmpSmEI8pOCyi7fAQa+zukpRCy6YU8qTGSDPzS0J77auv89u9fYlpm3ijNzj?=
 =?us-ascii?Q?nqqsDDcARAM3iSV776DKbCH2z7EqUtBrfrEazy6PV5X9MHZdRKnaVjQVEyJY?=
 =?us-ascii?Q?2YCdBgqjVdHmiBdJgUa9Z8UYUjwEuwH8mUr9kye9qQhgzVR/ndWnoVr/erJr?=
 =?us-ascii?Q?CFile50eAaVRm6MrCfUDk2ZSDQt6ILzmcansnoxOPRh63j/3xAoLyWsYVEFb?=
 =?us-ascii?Q?TdNTMxh1LY4iXBJNrktl786sNagYfMgt3V+eVkhBT5E7nzfBeRxGaOygyJmb?=
 =?us-ascii?Q?R4Oa7I2jRf7TxIkz0V9kQTFdl18h5Zc2qP9l4M9OB36B4YKKEkdaSsnC+JDC?=
 =?us-ascii?Q?i5EbgvBtLjFEdqIuWIdv6bhPvEocmvDFtRTZSs5TF2W/m5WQcnnpvvO0zjMa?=
 =?us-ascii?Q?c6gz3oFLqer/xL9dcSNrqGzQDoRoOQA0ZttbL6t9UBzQevTnbnv3N8Jm6Upy?=
 =?us-ascii?Q?/CcgMWfFRXv0mf3BzC9vZBegUQ+UdDRcd8aXnE+P1DW00vjnkjp4s5hDXCFV?=
 =?us-ascii?Q?ifenbcUHlRkWAQpCdzkqz+M36gTQl7Pc3mCLQ3vGMbtqnf46RDMzL86udrMQ?=
 =?us-ascii?Q?HTPVIyZQj6alt72918SZDbGpvcfcp/VeuSH+LgPvvmPk3mHjUdtPHynPBmXx?=
 =?us-ascii?Q?2JLZqyyx+G5E1ZTKGdgEVrFjw/Rs1eCgiGcfUTHsK83W/eS3Gndfaf5jEwXu?=
 =?us-ascii?Q?KsuydL2Xkv2GChmPC0aL65vcLJ8SY8uxt0EX9+sjSK8wLwYi1ClsLeWpRERK?=
 =?us-ascii?Q?TyreHSL+ijLhzuvuKrIKqZWMdHeSeVwM4qt0MQ8736dKp5vGojyDZLFrPWhG?=
 =?us-ascii?Q?/JH1s3/qYfDUurZNFglYjJGJzeMYe+vJHZ+kFLj8PeQDBcAPRS0ko+dWZ2+n?=
 =?us-ascii?Q?DQ4Q/Zc6qApLfjlgkSQhHvFCi0MGYN/U0lrNXzDcgktQqeMtg+Fa4xHZOqUI?=
 =?us-ascii?Q?SQpshb5zupNuKQQX7zF640H/o0EOIuW/kE/MNSzrOVYjqPjPVZ3I5pTsdYWx?=
 =?us-ascii?Q?9MRApYiOoMgTb87sWb9fMYshDtw/kWykxxLLXHCEJcAeGxRcv97g8kTFB9Lu?=
 =?us-ascii?Q?9b5/r7Rbvvu9JdzNymof7TtR5+ldmNgnYdp1vQNswCINz4/I2hqNd/DSoJ7L?=
 =?us-ascii?Q?331cjqSL8zwWjigVdclApJ6GFmwrDREjioGQgD/QO+QZeLp5kIyX0VLC6ziu?=
 =?us-ascii?Q?i/LxePLzzk6NkXl2RsypdsBf+PonC+DkuPl08GYT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5275.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4e3664-4ea5-4037-e8d4-08dccb1245d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 05:44:12.0736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5g7E9yllhssRcNJKIjZwqHsbdC430FdLIjB5l3NBmf8HaJiTAX5ZzW/SvEziBwNaFeAqiG4BIWIYbcXgndn8Geft2GT+XxGPs7u+IPLjfrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6742
X-OriginatorOrg: intel.com

Sorry, just catching up with emails.
I noticed another thing.=20
In qi_submit_sync() input parameters, when the count is 0, the expectation =
should be that desc should be NULL right?
In that case, the below code will cause a problem.

type =3D desc->qw0 & GENMASK_ULL(3, 0);

The above line requires caller (when calling with count =3D 0) to pass a fa=
ke non-NULL desc pointer. Should we fix this as well? Alternatively, we can=
 fix it whenever we create the use case of caller calling with count=3D0.

Thanks,
Sanjay

-----Original Message-----
From: Jacob Pan <jacob.jun.pan@linux.intel.com>=20
Sent: Thursday, July 25, 2024 7:42 PM
To: Tian, Kevin <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev; LKML <linux-kernel@vger.kernel.org>; Lu Baolu <b=
aolu.lu@linux.intel.com>; Liu, Yi L <yi.l.liu@intel.com>; Zhang, Tina <tina=
.zhang@intel.com>; Kumar, Sanjay K <sanjay.k.kumar@intel.com>; jacob.jun.pa=
n@linux.intel.com
Subject: Re: [PATCH] iommu/vt-d: Fix potential soft lockup due to reclaim


On Fri, 26 Jul 2024 00:18:13 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Friday, July 26, 2024 5:11 AM
> > > > > > @@ -1463,8 +1462,14 @@ int qi_submit_sync(struct intel_iommu
> > > > *iommu,
> > > > > > struct qi_desc *desc,
> > > > > >  		raw_spin_lock(&qi->q_lock);
> > > > > >  	}
> > > > > >
> > > > > > -	for (i =3D 0; i < count; i++)
> > > > > > -		qi->desc_status[(index + i) % QI_LENGTH] =3D
> > > > > > QI_DONE;
> > > > > > +	/*
> > > > > > +	 * The reclaim code can free descriptors from multiple
> > > > > > submissions
> > > > > > +	 * starting from the tail of the queue. When count =3D=3D
> > > > > > 0, the
> > > > > > +	 * status of the standalone wait descriptor at the
> > > > > > tail of the queue
> > > > > > +	 * must be set to QI_TO_BE_FREED to allow the reclaim
> > > > > > code to proceed.
> > > > > > +	 */
> > > > > > +	for (i =3D 0; i <=3D count; i++)
> > > > > > +		qi->desc_status[(index + i) % QI_LENGTH] =3D
> > > > > > QI_TO_BE_FREED;
> > > > >
> > > > > We don't really need a new flag. Just set them to QI_FREE and=20
> > > > > then reclaim QI_FREE slots until hitting qi->head in=20
> > > > > reclaim_free_desc().
> > > > We do need to have a separate state for descriptors pending to=20
> > > > be freed. Otherwise, reclaim code will advance pass the intended ra=
nge.
> > > > =20
> > >
> > > The commit msg said that QI_DONE is currently used for conflicting=20
> > > purpose.
> > >
> > > Using QI_FREE keeps it only for signaling that a wait desc is=20
> > > completed.
> > >
> > > The key is that reclaim() should not change a desc's state before=20
> > > it's consumed by the owner. Instead we always let the owner to=20
> > > change the state and reclaim() only does scan and adjust the=20
> > > tracking fields then such race condition disappears.
> > >
> > > In this example T2's slots are changed to QI_FREE by T2 after it=20
> > > completes all the checks. Only at this point those slots can be=20
> > > reclaimed.
> >=20
> > The problem is that without the TO_BE_FREED state, the reclaim code=20
> > would have no way of knowing which ones are to be reclaimed and=20
> > which ones are currently free. Therefore, it cannot track free_cnt.
> >=20
> > The current reclaim code is not aware of owners nor how many to reclaim=
.
> >=20
> > If I make the following changes and run, free_cnt will keep going up=20
> > and system cannot boot. Perhaps you meant another way?
> >=20
> > --- a/drivers/iommu/intel/dmar.c
> > +++ b/drivers/iommu/intel/dmar.c
> > @@ -1204,8 +1204,7 @@ static void free_iommu(struct intel_iommu
> > *iommu)
> >   */
> >  static inline void reclaim_free_desc(struct q_inval *qi)  {
> > -       while (qi->desc_status[qi->free_tail] =3D=3D QI_TO_BE_FREED) {
> > -               qi->desc_status[qi->free_tail] =3D QI_FREE;
> > +       while (qi->desc_status[qi->free_tail] =3D=3D QI_FREE) {
> >                 qi->free_tail =3D (qi->free_tail + 1) % QI_LENGTH;
> >                 qi->free_cnt++;
>=20
> Here miss a check to prevent reclaiming unused slots:
>=20
> 		if (qi->free_tail =3D=3D qi->free_head)
> 			break;
>=20
> In the example flow reclaim_free_desc() in T1 will only reclaim slots=20
> used by T1 as slots of T2 are either QI_IN_USE or QI_DONE. T2 slots=20
> will be reclaimed when T2 calls reclaim_free_desc() after setting them=20
> to QI_FREE, and reclaim will stop at qi->free_head.
>=20
> If for some reason T2 completes earlier than T1. reclaim_free_desc()=20
> in T2 does nothing as the first slot qi->free_tail belongs to T1 still=20
> IN_USE. T2's slots will then wait until reclaim is triggered by T1 later.
>=20
This makes sense. Unlike the original code, we now only allow freeing the s=
ubmitter's own descriptors.

> >         }
> > @@ -1466,10 +1465,10 @@ int qi_submit_sync(struct intel_iommu=20
> > *iommu, struct qi_desc *desc,
> >          * The reclaim code can free descriptors from multiple=20
> > submissions
> >          * starting from the tail of the queue. When count =3D=3D 0, th=
e
> >          * status of the standalone wait descriptor at the tail of=20
> > the queue
> > -        * must be set to QI_TO_BE_FREED to allow the reclaim code to
> > proceed.
> > +        * must be set to QI_FREE to allow the reclaim code to proceed.
> >          */
> >         for (i =3D 0; i <=3D count; i++)
> > -               qi->desc_status[(index + i) % QI_LENGTH] =3D
> > QI_TO_BE_FREED;
> > +               qi->desc_status[(index + i) % QI_LENGTH] =3D QI_FREE;
> >=20
> >         reclaim_free_desc(qi);
> >         raw_spin_unlock_irqrestore(&qi->q_lock, flags); diff --git=20
> > a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h index=20
> > 1ab39f9145f2..eaf015b4353b 100644
> > --- a/drivers/iommu/intel/iommu.h
> > +++ b/drivers/iommu/intel/iommu.h
> > @@ -382,8 +382,7 @@ enum {
> >         QI_FREE,
> >         QI_IN_USE,
> >         QI_DONE,
> > -       QI_ABORT,
> > -       QI_TO_BE_FREED
> > +       QI_ABORT
> >  };
> >=20
> > Thanks,
> >=20
> > Jacob
>=20


Thanks,

Jacob
