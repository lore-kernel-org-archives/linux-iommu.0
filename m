Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8348123D7EA
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 04:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765512318; cv=fail; b=QVVmf3sV6Gq8sWNyq6n7MGZj9D50QRnkOFBHTMedISGzwajiyFDhhwq81FMpPCT7s2Ah+FudLVPzcmtr3Gd1dlxpHDhTjokdwsT5t0y/9dnvoirG9QE5FMOF1g+PfnNvqeL9ln3jPkLbyEXYWgBY+LaRzOb4K3SOixFKeaDvf/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765512318; c=relaxed/simple;
	bh=8bWX9EVaslpso2rVj43hKR17ui5PmmX2hLIqLVr7bH0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uITL0HlfdB6he/HsZmAfSJBtiNYqf+hgvmTDag+dDcDKkcsV8CkB3Ge3gDTSNcyIiJM3GQoKDHWw5AYyjjH4sr5riLMkzeoUGYMr7QtsvW+UgCigONE5n1512N4bwljgrZ7eGJKRNAMqkGuXKKhcmF5HGlsNzcWs6hjS8zCOGEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TlyAkF/y; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TlyAkF/y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765512317; x=1797048317;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8bWX9EVaslpso2rVj43hKR17ui5PmmX2hLIqLVr7bH0=;
  b=TlyAkF/ycHrB4s+BXUm1JpZwGT4JWVgPC1plGaeJTpoZ4mcsXEhHvpxS
   2RkzVRbSrCk3s5adjEBob5Gh8GiU+jZhbXYlukrQjWugdxsW509ytopm4
   N8F7uQgW/YlRA+J10aBcImWYtNFzpoXTIQJS+graQ6VBvQEveAJ210QL5
   UCkhUOrqwoxpG8tsji5+n2bkTuaVWQhHz1xJzWOaKZlkoIw8JP91rkffi
   bfqxCrCVz0PkDWDon30WcBpKowhEwAXfaJq8MmqWzLHC832OBjhLOvIht
   5ziw3GdQBf0Lg1NbakwPVmSuQSeEIJkJFWVmN6+VcdgZRHvhHbj16JAqH
   Q==;
X-CSE-ConnectionGUID: zG+s/oKsQ5eebjy0XeKvOg==
X-CSE-MsgGUID: 8p34uJ53QMCMrsEFvssSDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="55055233"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="55055233"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 20:05:16 -0800
X-CSE-ConnectionGUID: g0dYIje9Qq6KJCRnTg232g==
X-CSE-MsgGUID: V8XJ4se6RwqScs+ooIsJjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="227623169"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 20:05:15 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 20:05:14 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 20:05:14 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.66) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 20:05:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxBi/9tApR9uinkYQ+rIZIesLGPUN8RVhKFLw0psPxge/+BpQV2NV/VFFNM/T7ZWUxchKHyebpSMuxhUrsPBJVFggAZ/KYq/GoQhAAed6OLUQ7ua704TMRb5Dc8RqzhMHXt0gpxQ/rmbIcBA5oPi1s+CzAfgFIWAp549qhzcytHzhy7JKarhti4PvKmmR6iRl59MounlX8vSBA90jV4rNZG55HjVhSbx2/WMdQ6HHwOBVV00MKlgxY3UTN0f0EjS4RHdXBdboL1SlOLB9CriOR3hlHM8KBFGYgnL9V3VHM1IcsDyV9IinUnhITlAM3Yu1mVkKez3SguFsYG3fBwcRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXDUeZgqjkMBGuuXLs3kyR4g6QBmGZTU/7e5imzrAGQ=;
 b=O5IF3st34ZiSS+XwKuumQvB8YJPlO7fEsNnK245Y25pZKCFunfLzt4bz7GUq9kYuqw9E+Ek6fNySBItL5mknjrrzqS0cPIqiFzwMka8cyYP7GckadjRDQ7P516VdChXIrYGqry9Exl/pP4kuvQ6hqX0KxmOyAD4hpeP/SfqzoCeNlxapT8feYOFbO8HGuCCwTCaOlAcXVEvHDS/m113TIRlqvOjvOntkmAN4rLUL/l0sYUm91VxSi5P6uez7fqN6dhgNMONDJ1A90/4UtQ1yeW2CgL2Rel6OHsD7tYxD7ZfxyW/ZkCobtEPni/koZ1Y+O/xMLVbrohUCeRj0S7fIAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY5PR11MB6533.namprd11.prod.outlook.com (2603:10b6:930:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 04:05:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 04:05:06 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
	<alex.williamson@redhat.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
	<nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC: "skhawaja@google.com" <skhawaja@google.com>, "pasha.tatashin@soleen.com"
	<pasha.tatashin@soleen.com>, Zhang Yu <zhangyu1@linux.microsoft.com>, "Jean
 Philippe-Brucker" <jean-philippe@linaro.org>, David Matlack
	<dmatlack@google.com>
Subject: RE: [RFC 5/8] vfio: IOMMUFD relax requirement for noiommu mode
Thread-Topic: [RFC 5/8] vfio: IOMMUFD relax requirement for noiommu mode
Thread-Index: AQHcYug360oWKblKBEqVvs7sHNET9rUdcsmg
Date: Fri, 12 Dec 2025 04:05:06 +0000
Message-ID: <BN9PR11MB5276070DF6AF7A94446417028CAEA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20251201173012.18371-1-jacob.pan@linux.microsoft.com>
 <20251201173012.18371-6-jacob.pan@linux.microsoft.com>
In-Reply-To: <20251201173012.18371-6-jacob.pan@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY5PR11MB6533:EE_
x-ms-office365-filtering-correlation-id: 35744de6-0a6c-4d82-9702-08de3933a257
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?4RQa70kA1UeQpve0ZJkJ1BT77QhDJXJcAEFepZwxSN8oDyP+Ro7L/aqyVqre?=
 =?us-ascii?Q?1dvtLIs91bCGqvldlxl9Ve11DiXvKiB7w3XAgKryksuXRr0Oz4q+S2QPDv5K?=
 =?us-ascii?Q?zeOXHOjRzwBkggyrgVJYtLHcwEhf4MfjLu+L3yxcENw8aE3da1oNQ9Vo7VQN?=
 =?us-ascii?Q?SA9XYvhywWD/oynYMeC4Xv21ar2i86g3ilNlaoG/ldUVSWRllhfZSKwxQfUH?=
 =?us-ascii?Q?UyfCvjB0073QF5yIZpvNGx66hGnvs2bWdAtZX0unsC8AlPJnbvmY0udK00Wo?=
 =?us-ascii?Q?badRg6aqA7xP/wfhgVKDnpHWzi5sempoild+5FcebjYI3tq4++Vfo4KQ1EO1?=
 =?us-ascii?Q?afWjRIFP7kFrik9KKLJ1o9lnsjRPka3aHeXSlNg536qLddLg4mhUzMOXYzzh?=
 =?us-ascii?Q?jb/S7u1v7pcS8FW+wCGWkoa9hq3GuNI+zq3ieMKtyZbRgJ/qeEcdgfKQH38j?=
 =?us-ascii?Q?CrXn/ICELxaKNwi3ZBbRvrOgd+RLu7d9CDuBeiaXGih8/Pg044rF63uOiepD?=
 =?us-ascii?Q?Nvhka/ajtOQStPR2xuwcgK3jxu9onk+By/Q+W+t0HIKWyvmZiCXFveSPYSa4?=
 =?us-ascii?Q?UZfkmxyJgvj7aUqOrfiFbKPjdEHcMpGEDekc0EENsTedq/AzC3YKkv5Uqyvh?=
 =?us-ascii?Q?dt2ZstZOS0Ww1mmJFrs3s5N/rojStdkZrpxfPratDXE/8zmjnKdD4yhwrNdk?=
 =?us-ascii?Q?BuBvridpvoQhGHvg6BvQ9jgB3pr6G68HbRhGSMi/TTJ1/6RxKVhvYg1xRT7I?=
 =?us-ascii?Q?6i7eykxPMhlvx89vtDHY75X18tasAs7TZssGERz86MQNipfchD7TU/8M87Cs?=
 =?us-ascii?Q?l8QfaD1fHvUiaFSTWvC96ndRREf2MyS4HVF2XMjwMFukhGZ6XEN9nc3XzuC8?=
 =?us-ascii?Q?P7+ul++z+1TWzmv4tylypsIruoVZ0HIsf3TQGrsq7AZIkhoGV46IzIvih5cj?=
 =?us-ascii?Q?KageWWHUdA13CWA+bRnjngWTg+p4VkF6iRt6WahLL5ne9MAyN+awFHex8OH6?=
 =?us-ascii?Q?yh/ErfYfz5tvxK1f0zhmgao3Z/YHmLoRRgr2XLHL+akAWrnaWtOABKc+twwy?=
 =?us-ascii?Q?94+xH72Hmy+nKBylQFdxgffv3eymXpy9a4QS372cEf5EH+4kVfJubqMzo+Xb?=
 =?us-ascii?Q?x24e0jA7KFnGA1QzEZYDzL+Qe0Ab/IYSOYAw9set7Qk6A45z/OWqKdMtUTsM?=
 =?us-ascii?Q?7mHmzL0yb+hfdP3qxq/um3/yDuB5bEjuU+rdFLk4J3w27YnhIrzuaw1JXfKM?=
 =?us-ascii?Q?0HCvz7hbfJViwHTqKez+KUdS8jfp2hoV6q+GAH8YRQQAStFN3DUMcdV4dr62?=
 =?us-ascii?Q?xlKQn0WVDy6mARikrGXC5G4jH0nAoZCVPlwUj8TkT9qwZ1D9rTGMwPwXKDy4?=
 =?us-ascii?Q?2otniDGIqjGmGgTSEJ1L2luMpkSgG3FRa1ndGbXVVm9FIbVKkddoxi41yaNp?=
 =?us-ascii?Q?jOF5WdYBYiEVzrWnf+a7iHW4mcVN6Jrv8wKCHiOm9ouIyqLZcn87A5gizYgN?=
 =?us-ascii?Q?aeH5XbrI/8ejkWJUBXBDGlrDdbgexesGSF04D9D0e4ZzX8EpNG8XJ0ixMQ?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?atEEddFh5FeDlUNsfWyamIIREokbk710oi/NGfCgQi2R6nt65qTWkBRPp3aF?=
 =?us-ascii?Q?in+bJWQtgO3FOG5lnE0XMj4rSvBUYrt/f9m3cBIDA8guCCvLYMqCEnqKnHBs?=
 =?us-ascii?Q?cUCXKwCIrtYbvb2sshVDbulgjSIHBRijnNj27p26PHgJ1dOlId/rv7KR+c59?=
 =?us-ascii?Q?0v5wzprz8nPNShKIDly0AiV2lQgEIYc6fWqVcn/ebDGRIji0q7Rh3wisRa0Q?=
 =?us-ascii?Q?3pq/6P/a0v2sqw5EKh17uf2A/rlcIK2WT+KxAU956AUbp0TFc6Qzhr0Ex1CX?=
 =?us-ascii?Q?VAZjVemT+Ul3Jop0Z8RkjWin94DSswNuoMpf+3Z167De47LVwXi+EguD9v4W?=
 =?us-ascii?Q?PyfCJqai/vjLuXZV26Jcb2RsAA7fRz6gmJj041eo5ZLmq77Qr5qd6N8MhsP+?=
 =?us-ascii?Q?TJRskgYWAbGmvRcw3WU95IqFvM0Hry0bTj02Cjoz8hWA5c5UdB6qrbmqeh/z?=
 =?us-ascii?Q?jG1VH7moRsXPbz1hBaDQ0s668nyqEnV3zeXYBiCMdTxD7ZBwjq9h5q/yFXEQ?=
 =?us-ascii?Q?w7+pkVgF6h3Fq+WfPr+6LXrYS4fi5GtMytKw+NGzty+nKwmAgE51SRwSl5jT?=
 =?us-ascii?Q?SlobowV6gkj9OoxhmsFIj7M/K6XlrkowWE6B2azkAoup0AqDY+ZAOAuV0SuX?=
 =?us-ascii?Q?p2kKQ0NHMq68AE/C+XVmRMS/XsVNxC1tU0glK/ZZmvgH9/l5JanvR3PIc2NT?=
 =?us-ascii?Q?fDa+a9GgPBs27l/lmJBo8xpyKEFmr85vUyqugAEdb9tI8mS5CYyvktG3Ey8o?=
 =?us-ascii?Q?B7d2e4BuSlOmnxjuMY5vccHPCCaE/7oOPfk00i243mdjKQnTXcmv9s1sz3Dh?=
 =?us-ascii?Q?Qfesl+AJDXmvcQR2+idufT774DJcEBRij8Lds57eaKfMCD6g7s8L2ytTw89+?=
 =?us-ascii?Q?CPCp1C0utCxwW79lSHdA1q6bGQ/EX/ItEnoKJabedbmMFLDVRjlj+4o7ruhN?=
 =?us-ascii?Q?atVo78Quuh5Sw871PiUDwqYnIxUXfH1jUfzaO6cO0oMAZfe1OXvlJdgEAjpH?=
 =?us-ascii?Q?lIbK0/PPrbRTdbF5LO0qTIiEI2i4j3FMCMHqDE1FyJOk0d1iwvGdYy8WIBH4?=
 =?us-ascii?Q?ox4paE//hJEHDq0RedbDKtFjTL2wjUTIpt4Q41K+c3/5TIUXLYMAnN+dMarp?=
 =?us-ascii?Q?6YvQxVjDkkMcee1w64P7bjTyKpbjr2bh31D6XlWm9zNCNkB8fpYSHAMgp0bo?=
 =?us-ascii?Q?MRe5WvvP5ZfSGmxDdiqVyJPYkMBq/uzyiJWP1KhPAiYm2RE3WeNgBoF182hh?=
 =?us-ascii?Q?ZR7R16HEszoCTJk4mYljRvcjBSKYskWANc8XcQsRDm0aKHEhqVgcXH2xr3JJ?=
 =?us-ascii?Q?QvtecQR9cYaNgCGki3tEBUJkG0s3AHDkt4wzRMJmdZSThOlo69BeomcPqrLv?=
 =?us-ascii?Q?N8JzMLBtMzX8kEJxs+kW0PcNabQjQZQ+4okv9U2znT6zFkx6vbS8DYrqS7SX?=
 =?us-ascii?Q?VmU/gDrKatt59jysQgUmEUWKf99lptrPRvzbpPFXQvweXV1om1eJGtj2YR4l?=
 =?us-ascii?Q?gGHmxvQXbJcDuTVjZYinCJoGR+/885qxM/L34/HW1+rxSctqXHVXO2xNgcWd?=
 =?us-ascii?Q?tewYB2/DEfwwNTpqCoQ6x8gyxIIdgFTooxjhqCpI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 35744de6-0a6c-4d82-9702-08de3933a257
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 04:05:06.2609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cPRD/ZEsQhA8yBC+tKgHKZsTmcSXMGet8R7RRNvgiiey0APZRb34Yk+qfcFiBE5fVY5Rj3AA/R7ZYPLhj/tAPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6533
X-OriginatorOrg: intel.com

> From: Jacob Pan <jacob.pan@linux.microsoft.com>
> Sent: Tuesday, December 2, 2025 1:30 AM
>=20
> noiommu device only has auto domain, does not need to attach to other ioa=
s.
>=20
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
>  drivers/vfio/vfio_main.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 38c8e9350a60..805d30b0b82f 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -317,9 +317,7 @@ static int __vfio_register_dev(struct vfio_device
> *device,
>=20
>  	if (WARN_ON(IS_ENABLED(CONFIG_IOMMUFD) &&
>  		    (!device->ops->bind_iommufd ||
> -		     !device->ops->unbind_iommufd ||
> -		     !device->ops->attach_ioas ||
> -		     !device->ops->detach_ioas)))
> +		     !device->ops->unbind_iommufd)))
>  		return -EINVAL;
>=20

the subject says to relax for noiommu, but above actually relax
the check for all configs...
