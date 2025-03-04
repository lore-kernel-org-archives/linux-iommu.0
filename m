Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116101FBCA7
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 07:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074261; cv=fail; b=AlBaXrX+QQdQFG5XEfu1m7bKcf/uILaktcJEJxR0DIvWv4t2YLdxH2ilCJTHqsazZyQK9u6/HU9v868RrzBUg81JK1JBPCISIc1k5Ab+iM4U160cmIWFtwI97A/xvH7X4nypZgFjLFggAgh4+Y3DssJjBXvOuxCImXwr+Ey3ERY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074261; c=relaxed/simple;
	bh=GrLaokJu8qf0cVqESM7WWVjPcVBSCaPnbmzkfUdNqgM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RgKhc4pYvZvVfhb9o68LmQBNvBDc4RJi6D+LlbPuH7ONy/aDsYqSlQD3cq1Lf8o2L3c1v2pk3AKMb3OPyoKSvZBP7DxP1jTlYLKPPePHutsx/0LVYfz9cWXNWVM3DVHQ3ehQBmNT+q3c01MYFoncABGrSKzhBlhAxCWelcboiD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iy8z7Z97; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iy8z7Z97"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741074260; x=1772610260;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GrLaokJu8qf0cVqESM7WWVjPcVBSCaPnbmzkfUdNqgM=;
  b=iy8z7Z977NLW41OFtoe7SUHNSUtbhvGaRgyG2BXPRPi1bhjxhr81v1VQ
   V0mBZhYdoHbZNe7Mj0Z2ZOWV8RAG+FWylWFnhWs6+07BQp9dUec2E9P2T
   NUR0ELuNUJXVmoA7hO3Lm42kGWB4QgeTf7ndYa40gG7eOtFs/30Hps8jO
   uNXakrPEaLgPw5ycfJ9JHCTnlCqwjo0Ae/TRUgNqtzNsFWI25abIT+fM/
   YZh9uiDc5HS0cBjsUVc+3xxSoV0G4hYtGZ9tuRAHvxz5o/1cZ+M51EHw7
   8xovZwGCRz4+9oQfOjgzKBQMaR/ozWKD6v5+2XImoRGO4wICl4MgbUcyu
   Q==;
X-CSE-ConnectionGUID: 6A+9ElLNTiyEMEH150D6jQ==
X-CSE-MsgGUID: JNfVCJ0wQ0+ecXrzZyLWMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="52959584"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="52959584"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:44:20 -0800
X-CSE-ConnectionGUID: GPwSqWXvQ1a9GlUzRYKuLw==
X-CSE-MsgGUID: wd+W9T7eQKe32Topx9mBzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="122911052"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:44:19 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 3 Mar 2025 23:44:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 23:44:18 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 23:44:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljhZyqxPa3FqPW8dVBg6GFNJYHVTgnu7nfuOKJIrWyWpg5eUxVcQ9GI8W8JE9tEOVQ4Ry6aOO9DQg5VcBZsnJOclRTlY6EDN7jgMRDxIEkywt17Us5BHWVZY3EeVwnNh1QLcU77GAkKdb6Ro6ISvgZV00Yinv8Qa6Ygz7yzZWpIHtFAChQa8e+3wpjIS7pyUr3QBPwl/bxNsV8MN8Z9vLbigyon6O+8wj7Aab20FoimGgdisHhJWc+1+lpIeuRccm7Or5qroqLVMpI251vCwyTdms30kuBsHuaNLeI9DiWnsMiGPGN0QYfEi4WgghQAGI/ummzWU2q6/yHmrTD30qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrLaokJu8qf0cVqESM7WWVjPcVBSCaPnbmzkfUdNqgM=;
 b=kujscavETwOYmURZc6tEnhqUUjOaRhdjHEoIHmIfXzCmwfyQF/sS3ygpMmMGJNaMKNnPkANft1fp6Q82ArUvc0biuiiDaqm7pdqtAiB6xderETGOiH7rtxQCi9aUc0QCorL3wDrd8jd7hhsQlAegHW6lR5OsdZK9aUfBfzCPmSusGuxOsyjbqOjOeQ8vDZDFXqZTEXwGfVV+hsn/y+WyYZItLqrUKdy+JOLjFPLh6Uc0eBMsNu74IjDJRAKtaqOADrMYtFsagOTYwsZb2mx5+sEtDhsMkQNR/0mf6sC/6XDK0UrqOuBCyQRDcSaDm3k9EbZ3dlKCVIRAqgv6GNR6Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by MW3PR11MB4618.namprd11.prod.outlook.com (2603:10b6:303:5f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 07:43:48 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%4]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 07:43:48 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>
Subject: RE: [PATCH v8 04/12] iommufd/device: Only add reserved_iova in
 non-pasid path
Thread-Topic: [PATCH v8 04/12] iommufd/device: Only add reserved_iova in
 non-pasid path
Thread-Index: AQHbiENJu5J70/S8kUW2g5KDlIuTsbNioaTw
Date: Tue, 4 Mar 2025 07:43:48 +0000
Message-ID: <BL1PR11MB527113E9F6159EC133A4340B8CC82@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-5-yi.l.liu@intel.com>
In-Reply-To: <20250226114032.4591-5-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|MW3PR11MB4618:EE_
x-ms-office365-filtering-correlation-id: e9c1ed7c-074e-438e-d373-08dd5af04d18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?+Qjf9lgqAGIQju9AqYCE14b1+4/+i+MHLRJuOrc3VsgEAWAzolE/s9to4iUS?=
 =?us-ascii?Q?qnwPbXr0VvjBpuxp4GPU9Ub5U9D8kBy0uhm4KLl2hSIce2ieCM+2gWWvOeNK?=
 =?us-ascii?Q?YaEKXor9vPDGrvQ+CrAQClkjGQfgq3ObD7ma+xoDY543aiRm9y4fVRdYytCr?=
 =?us-ascii?Q?cFqvqkhF4ZhxFBadMVUvkE6QcEhYQxKQLOR2YK3j6n8R2Bck9GbndF4AeUY3?=
 =?us-ascii?Q?KvTymiRJVPOmoyNF9P0ryEm8YTRttQ9NmSXCNqqbs+nM5r1a6e2G2RtIVbjy?=
 =?us-ascii?Q?wjnUotseidkLMmBELD/Vl4kRbPLkHA+8XMLys4UPWj+2+a95XWUdO5tTDvE5?=
 =?us-ascii?Q?RaTDlUAjUBvhqmLUF6QAPwv2e4xXdr3UdSVBX/XODlnZedasnL+YniI8FyG2?=
 =?us-ascii?Q?4NeeEn2xqpkTCX2D7ZqaxP7BEUOauhoZ3tGuckaGt4cyyhM7kKEuONHau2YQ?=
 =?us-ascii?Q?li5qPfRsgC2m1b5h06iBaTyNk+kFhDpZipXYDNagLbp44NKapM8oKpZGhid6?=
 =?us-ascii?Q?GRc28Chw2/e03hhssUuMgYhcian4ytAKWN/WcgFNoDFe4AQ1jmzmFdjgBFGD?=
 =?us-ascii?Q?hTBEX9xTvzI1Jxn68GuHtQWvTnTVscPsKkocH8NAyQ2GGnWO4nHI80JkZ3yQ?=
 =?us-ascii?Q?ua3c+aS4EkzcPPM7+iwnI61DCJpmE+cRY4H32RcbYcmv3htoLNumnSkkn7lk?=
 =?us-ascii?Q?2TVwm0nZoq7fN+u/bV4A8b1h/at3Ng4neIsxcZP/RwG7nlXKvrS+mES/pZZO?=
 =?us-ascii?Q?6JFWdstjqS4QpIrL+qnq30ORc3Ih8o3Mk+07UONof6k6I2AFzBFhu320EOv/?=
 =?us-ascii?Q?EubqaT+7s72IET6XX98ha54WvjIebyBJHBqA6MJCke0PbT6ERGZcn64K0PP4?=
 =?us-ascii?Q?7TKE6Bo49AdTjXlTLcwxO3+tO/gpb5CRdLkwJ3twx2kbj4AuJwJx/X1pKsgr?=
 =?us-ascii?Q?FfLLeLnhb/BbsiTO75DFCbsc1Z/BEuDxmbOwvAKPdK65/6a5+deJMq0wcagw?=
 =?us-ascii?Q?EiCTbmVspE7z1tOqwC+U7BUoYjP+nnM4mqB3N1fKDAi+VOCqSy/3nlFWxEyf?=
 =?us-ascii?Q?nxTDEnK8r08UJKOo2CCY/WEf18PAY9GE/55dMDjzyk9D/dk6HSFYc7NjeG7/?=
 =?us-ascii?Q?/aspDpqgxGxMeYF0TCd+OEGj69fjTsE2C1S+8e5nFreJh1XnFKsubbilkqlv?=
 =?us-ascii?Q?DhCrord5Ty1jpFWmdhZaTC67atV3X3IsSB5JydHWuOh4VFpxgH6Aha2OMVOr?=
 =?us-ascii?Q?UNz5OTA3Us4rBKoVJtI7xtca0f0z2DwwNFf/MfKJPBqUsANhyGHLJQ4SGI5M?=
 =?us-ascii?Q?QEr7XHU3Xv537Unp1387H6Lsd4dPDr08VK52rhVJKuIz/x7t1GTjfY/MkJiW?=
 =?us-ascii?Q?XYZIBge3oC/9pC3x3bVCLud5XA66c2qS+TzscCmgRvqWoeRbW8zCi3RnXoHG?=
 =?us-ascii?Q?r4rKFG/YsFigWg6/E3z2qSf/kOxPRu6C?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Iex1vyAnzixEipaiMZG+y0tT/W20eMob9Q9neUZ3+uadAyK2fpq4K4RmCmro?=
 =?us-ascii?Q?lD8sTiOybUBUuxc2PaT8GWxvrf5eA/qZLz9zqa5qDkeNsQFI3EYOkD7y6T/C?=
 =?us-ascii?Q?9q1fpa1Poi8JbaKZ1iymPX1UlpKm/mDiOYFPjwz+WnP5HNpyLbNuNjm9aqnA?=
 =?us-ascii?Q?4fc5TTULtDAnNGw8jf9LUxXwlMLN48GdCvnPNjZFZwUGZCcatmN170jjNR/e?=
 =?us-ascii?Q?gVVwJKkce6/YQcE1bCGLOOBuEE3LEpPEH04YFZuesZSyeJ8nJfaiP9OiyJbx?=
 =?us-ascii?Q?Y02EG9s2dXQAz+cuYLpLUeTSJ6rs34Fpc539v0cFWEK2mtxdd7vxNiONBfNV?=
 =?us-ascii?Q?9jH7vMdWbfWnxG2+95CaUBxXyAnW4tjur3Xr2jTIFYuM96WTWgGV6VC33Bv2?=
 =?us-ascii?Q?022zvqfMxk2XWnRs42rbaD+duUoivoi+nbPbLA+bI1p97M03uzMROcn2++dY?=
 =?us-ascii?Q?eBOrjhjIU8uBg5nZ44fROKp19plhW+elFFKN1fWkPZEpVsb3e+ttjw+qfAF3?=
 =?us-ascii?Q?jZiBWdmAnyLTNo8jpuEClMTGA4MZStVAZnaO5/i80YcU3sLsV7DbrFGWBdpC?=
 =?us-ascii?Q?uLO5uu24kqDIH0k3os7ZMOok9qb+kBTLIGGdQSpWvkxqvOKpVYsoKjZLXGic?=
 =?us-ascii?Q?k9b5W1DiudX5N+yw6k5qCYd7eBzYp17G6aqYwL1bMYLXvlHYbtngXeYreyfx?=
 =?us-ascii?Q?lFdhzmjUeiGZo5Yz5NLAhr8fI/bfin9S3c5MmFsj18993rxs1UrBovols9Vz?=
 =?us-ascii?Q?BgS0E1PIK+38j5MvoBqIB4N556uXhevcpyRJmXyAu+wcMIDWp8f6JQ/axqRk?=
 =?us-ascii?Q?03ZatmolW/Qcvp/kavvv0LmuMxNOAYcVlAqyhIgUui39ggfmwGlm3bOaZLE4?=
 =?us-ascii?Q?TcxYs2qxoCzp9h1S5ah//bsCngNnJGYA1e3JXlvfGDORtflGdew7wBE8YHqK?=
 =?us-ascii?Q?eq7kkHAUJM2qp7Yf2eI0GgI6dmUwm/Yg8AE1PWjf1Rz538zjdqN0o7r49BzO?=
 =?us-ascii?Q?hQLlapHGCUQGRbKoDzgzvq/Fh9rMNtmC+5Tr14uCFp0OGh20lpdB4XrCrT65?=
 =?us-ascii?Q?bNe/VVc4wYs70SHDHHq94q0aiOynIZlG201237pthChpMnEQ4+SBPFhJk3D2?=
 =?us-ascii?Q?qlhOsQ20YtgMA1xRrq1EZVS7wMYxNQNI++t71u+Wb6N9IABONSJIxFs7mqN5?=
 =?us-ascii?Q?iY7MXpb4YCqVwY4+X+0ESbtYGBMcGPr92Bex9oP96vai6zaCfhcyhvbS4LL0?=
 =?us-ascii?Q?jTLMFBoKauaoc/6a7X7LG5GzbHpv7cYLcqcyzTovtNZEiIwg3mkEGKTmw6is?=
 =?us-ascii?Q?DJxFz7bxLdXdOCFVfBoxJgORxlXz4kUSjJMKIt7lxE1abEEIFw9MG38bDfVS?=
 =?us-ascii?Q?2EKzYKyekeFnVUOleBclKkYaqUA7f282OT19pC3RJQU1DBNLmzHPYXV2bi19?=
 =?us-ascii?Q?v/HoLNjWksBSiivMGjQb6jcu+UbFbTGyUot4t3F/hxQNqGHs2Xhn9bpahyJW?=
 =?us-ascii?Q?PaktLyBpf+A1/81l+i58kmOfFaXFQ+p4ios4peGRmazuE5XKQDUMHMiHeGEl?=
 =?us-ascii?Q?0+28iqvtaDHpPtHd26zfCdUJsL9rENW6NH63zmIf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c1ed7c-074e-438e-d373-08dd5af04d18
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 07:43:48.8337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZRvW1WbHopViD4l7rI/1N5xAo5fglvSXYDxZX2TaquABQAVs/cWO1VjozvgkCiOXR3+LzlNjW7i9HcIzgGRCnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4618
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Wednesday, February 26, 2025 7:40 PM
>=20
> As the pasid is passed through the attach/replace/detach helpers, it is
> necessary to ensure only the non-pasid path adds reserved_iova.
>=20
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

with other comments fixed:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
