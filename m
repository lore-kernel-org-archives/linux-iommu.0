Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5154E26AA93
	for <iommu@lists.linux.dev>; Fri, 12 Sep 2025 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665202; cv=fail; b=p1t2egNLfhVfHqT0RPqKncaBMGLO8ltgj/DTBRA06NyU0SN++rIJv0MagqCSJnzbCciE8LdGdhJ/eGmhJxGd1d0kxBKtL22rytBp35nmM9+z04bm52VMG92KuFT/l7yoHmW4VIBh6HU8uHqcrxg/62VXKzzPSKXgNIx5h+ActNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665202; c=relaxed/simple;
	bh=ZAx4wjD19U/zKhuwfFZQFy3qzjOlBFMHvVskI0k3bvE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zw/FIjJRePl/fnk4TlpSnQyS/4Lu98CKMY/hJjp+KRZhwk6r54pdTfqzfHUFVGOFaz1bOcdmnfAfpsqESvNF2Kb7aRCWEJdv51tTG3YHSGsZIRbzJMYpx+xy6Q8GHJOdk+vsLrmQMmzjnJbIKqJDcA+rZquPHbo9eEoGWTTlrOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zg7bfVmI; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zg7bfVmI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757665201; x=1789201201;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZAx4wjD19U/zKhuwfFZQFy3qzjOlBFMHvVskI0k3bvE=;
  b=Zg7bfVmIw/DrynOndfvpCRbsO9nHjH6ZaovnTWHqlOCSlCf3dLJcNUXK
   8h6jJ7dommuUVOel/3kcuTu9ZvxYMpum4Swc/9xPzusfc0CS5ZT9zaTNq
   mhnE5Vt5jOVHXxYM7qytQaELq77cRCZskUz7A0zGffA+XEpmnFytvRsLu
   si22vemoEcfg1Mvl4R2EL7lHL84I4OhApLtm1dl9O0MeNx4sJiibTcGun
   g9sCikjLa1QDsNtHhkAaGvwpBXeSallxVrUCmU8JshRe2B3uocq5AtqOm
   eozXg+HUJCVIvrVvR1THnyxG4+NU+j56oY4SN7dI3llFORX/hgfIhKSbj
   Q==;
X-CSE-ConnectionGUID: FXJVbadWSqukxmzJnnZ17w==
X-CSE-MsgGUID: 9GDhwA20Qi6RC00ArDvZ0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="77617964"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="77617964"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 01:20:00 -0700
X-CSE-ConnectionGUID: 5eVvt5teTGyZT+74GLRrBg==
X-CSE-MsgGUID: zsBcVoJ5SJeaSEUuhx6z4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="173457883"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 01:20:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 01:20:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 12 Sep 2025 01:20:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.40) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 01:19:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C88A4NinrmJpKx8ZuDr5qBn62qI2oAglAelIq+wXNo9Kfc3P8E0OeolvPaObKmz9Nk9rwmJbR7BDnEsNgUyS3jUlkpOq2s1dxbxE5ZIT36z7STPpckA5pPDqN3AzCXossfN+NWxegv82/qyAZv/Bi6rfrmjHKCgi6AzIFFUWHTgP/XBnIbi9Mbsb7slJ5cs9wyTp0T7j789Abi1Og9R3hm6tdJSzPeB75a07X4Mlch2nKr+LWmG2JIGZTh64HxRmuJ2E96tV7bgWDKCJhQ4KyBO160mByRoy0H99T0WiCwHp84ftDLUi5zaJFDJLgL/2xnb4hWD0dDDW46Rl0ckk/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOE0Buwl+gprMw4w3T74dkK5GuNmIXKiiR5umHHC/Ns=;
 b=bdA9EfnDQtNxrNpgsX7yKfjbjd7vMPE4+Un3svB03eMEtCh8NYBTu8LTOMdXIX/tyox5agmMgn7XZJyIcxekTcldEt2MH1Zrbdaqc1YXWb7UyOkb44CFSJvWOD49Jbx+q8biYtOUGx4XIW+2ZYnnzSbdZmabYDWpgs3V3FLLPA82pOePbYM/fasyhje2f6LXhXLPtwcA5IjOFOA1cnw1nCcqcG+d7HyBSUvpa5u/9s1CAyPZM2iBK/4BmHxsOMK3O56PVXxI6yl+7LdfU+Ha39D/6irJ97sAnTv01ExJwJXH3F+x5d1Pq9d+42FxQU6eBvglzHpExll0WKUB/lD37w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by BL4PR11MB8870.namprd11.prod.outlook.com (2603:10b6:208:5a8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 08:19:57 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%3]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 08:19:57 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Jann Horn <jannh@google.com>, Vasant Hegde
	<vasant.hegde@amd.com>, "Hansen, Dave" <dave.hansen@intel.com>, "Alistair
 Popple" <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>, Andy Lutomirski <luto@kernel.org>, "Lai, Yi1"
	<yi1.lai@intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "security@kernel.org"
	<security@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: RE: [PATCH v4 7/8] mm: Hook up Kconfig options for async page table
 freeing
Thread-Topic: [PATCH v4 7/8] mm: Hook up Kconfig options for async page table
 freeing
Thread-Index: AQHcHil0hxscIG1OlEG+8vxJrhaD8bSPPxbw
Date: Fri, 12 Sep 2025 08:19:57 +0000
Message-ID: <BL1PR11MB527130DBD1D596894EF709BE8C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
 <20250905055103.3821518-8-baolu.lu@linux.intel.com>
In-Reply-To: <20250905055103.3821518-8-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|BL4PR11MB8870:EE_
x-ms-office365-filtering-correlation-id: 96975d1d-7702-4b00-694d-08ddf1d528e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?PlbLNKM4pF92pfBrzWWL2rbQ3l4I02cAONnz9s//iGx6SbIXxpSReTqquguM?=
 =?us-ascii?Q?IA7n3IJsUeNTn7T/kasAVhsF8APIRsUBGdDT3gxfR8so81LMGpbtKU9YkfMd?=
 =?us-ascii?Q?n8sb+a7UwMezIETxv6o2KpkNHmohWLjGTbEwm1wadW+jDy00k3AL+HtcGI9R?=
 =?us-ascii?Q?ws8JtZQjZ9my75DJvKe8EwxTVd34sxY6iw7NWtHpBpHVrcYxHlSih0jew4DF?=
 =?us-ascii?Q?eXdIJ5qiGNdqBip9QwMS/imzL3wJdW7ufkn/a/Kua6bf8DsehzkCSdNNOh7x?=
 =?us-ascii?Q?gbKeOnj/EygphJ7XLB+Qe0FO2Agn4MvdbYsqz3im7UyB2rkQ2nHGjcx0o4N+?=
 =?us-ascii?Q?nDQlhPgQYT80XRxS+R0Gj7i/Kyg8qgYDksPGC6zJeiztJVNKYy4XL7BdbGrA?=
 =?us-ascii?Q?W7z+CBASohNXVTEt4Y9YQEKSkrEwMnbBP8rrgiYv4rd0KT9wlhM4OmL5Q5Zy?=
 =?us-ascii?Q?TMIjo/HgXPNn0YN8TVyClzPn7U0FyiZhcrcetD3HJdaIA37gmaASO/whdkEH?=
 =?us-ascii?Q?NBTvu1vnLi95Ofw+TV1q7/qCewr3p33CdxLw+NS/QQIRq+rQHF7qQrHGQY5Z?=
 =?us-ascii?Q?QyNktNvCOTb4xJUrac2Qb4vprHKMz92bD+Z8EOSY/0ZEpyg87uNaorWpYxKY?=
 =?us-ascii?Q?TSN+fR64TV786S9fqclZ3e+qbDr3X5+zruXOrz50vn0pZwUBO/ykiUUmctEz?=
 =?us-ascii?Q?PbOE0tSblo1+oUGXW0GDKa8mgMxIQ63twTYIx92DSqb2RZwKOhvVEglx7+Eo?=
 =?us-ascii?Q?QoqnJFalQxGLq1EQB1BJQqtKbPt2s67ElELreSu7QBGvLbkehDtZkv9OcpEt?=
 =?us-ascii?Q?WnG0WfPeUlj76AdCSVshACBkVLwe2InZhFv5pKGd/075miI9I9RKTAT5YaZq?=
 =?us-ascii?Q?DezAx1NvdbIK4318LbJ6dhN2oK+G1H5Xj6JguK64d3OCkLWYpRTzYVoonw/H?=
 =?us-ascii?Q?kY5swkuOGSa6rmuLsYypVPE5TlxppOTql3g6bbF5t+3Mc+vYCEpTYZ1Eovg4?=
 =?us-ascii?Q?oc9TPLHhwZQ3drdyMA22Zkrn2EWX6e2TWCC1jOrw/O1ABUmwDWfThB+rKB0J?=
 =?us-ascii?Q?G+AkgnK+ljK06xDtU8FfRugaNrX/m2PlX+8dsqit0Mh3GGDPoonJ4Eqs2qob?=
 =?us-ascii?Q?5K1VWLz8ivnq1pW6D//mv4OeziNzbUZD5JzQ45pa5RWczEdmYNli4WtIn5Mh?=
 =?us-ascii?Q?6GZ6eRSWKnq/LvOiKzMlbqqUh/87FDMaMv8eS+c4HoAE5iFVAn7ec+LUWVFR?=
 =?us-ascii?Q?DI3vd3vxZysEXygfezyl7w9oSK7jFBGcdBd892dP+TA8AmAsLUxOygPLZC6i?=
 =?us-ascii?Q?8KctYySM/vdNVZvSC6rEXxGn+lEPYRG11ecXYB0HrVhttZNi2viEZGGgYPWE?=
 =?us-ascii?Q?01jJFssoyplNrJrZWp2mGXXDAMwdq2Y84hzmVmkQ/bU12MbScKPUrzVybREI?=
 =?us-ascii?Q?fAQKedK29SoRdiI81RO5Xw01quvb2bL1ME49umZTES9Ac/TOfcKglSFKRjsU?=
 =?us-ascii?Q?DdL4XSPh7gUa7Xo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Dz3xiCHjgKrMZHxKq7BnCp3cjXBnxAmt0ZFre9l9bSV0AXer3zWWj/+s2NbR?=
 =?us-ascii?Q?xiQQj8dvoF7S8bAlMn6EEZ6SjELP4cDbadzkLu6jjVcUcFW1M7x486/NWKjR?=
 =?us-ascii?Q?Zrdu9klZWR++w4TUNEAIkzFhGDMdNePP3FKdYfipaaSVHR759OthfVAxf3LR?=
 =?us-ascii?Q?A711IyTtvX4J6Y6lCgv7i5DT2UfsjR0JFA89BHd5t3oYOURmzJXOyBMRVMtr?=
 =?us-ascii?Q?uZCVYqQkQeU/WQ9auFJoF79SR7WZzAPrCHpXUURDOE74VTeLWDnHMjNDcBqT?=
 =?us-ascii?Q?/MSMNHdEKDnFB8IZs/d2VvFVvB7XtGxAnAqAZpyFLvZz4troKHWuK3bOdMBS?=
 =?us-ascii?Q?sr+4OQuHI3vLGFET/wkbW8HgV2/jM5GWt03D6NjyIJbXILP2ZpitMqTQ/rS0?=
 =?us-ascii?Q?rO1QvXqDqRGZ/lUtMaDPvbA0kcNE+q8vaf0TYRBRU6NY021vzosI2ArIKkC4?=
 =?us-ascii?Q?H0LWM8gWoj3pRWbag/aTo0VwnSRYh3mX3qBjGKH2Kf1eK8UprRDVIMTGEsa8?=
 =?us-ascii?Q?ed8LV8F6AfydQnXuXvD2M2vAU8XsAdXJ9Cigip8Wn7BmCjIjhKEL6Neulbln?=
 =?us-ascii?Q?GJn5XKPv2jdY8D5yZc+YQVyLItHyRzUWKbpQVhVKwFz1LW2bhYBOf14WHACz?=
 =?us-ascii?Q?TO6xqFLPm6EUR9g42vvnfJyePthdZUI6ggN0eeodFi564vNprOdhUqO148df?=
 =?us-ascii?Q?C4+P9Bo37NTvELSjN1vaAkyWOa+NjDviygDHGeJt/Z60jeC+uOHs3Me8exWL?=
 =?us-ascii?Q?IJJEop2bwTLFuxXk8sZKzEWirrtOD0GscItCw74txG/gpDJPVjUliUZKXuKl?=
 =?us-ascii?Q?Z8QUg+BDYEP1lP8kvL62fdG1fcXSMESvSG2kvQvhgHeOJG3ictMdET9BGUsD?=
 =?us-ascii?Q?lmUSsPpauJUNc6aQI50RRKc90Sbtuf7Tj2F9+jWtk4UGpWiBxY1lpouBgq8V?=
 =?us-ascii?Q?EvyF8ewBDbBVv45E22xiw1UDt0jD3TDT5EMLvAK5jN7Cj+G55qozio+CZEeV?=
 =?us-ascii?Q?K8KZ8OeTP1eSxWeF52wnjVgRk5/xa8We0L6+eGzG+uXL+u5rvasWUUieQuW4?=
 =?us-ascii?Q?M57PgETM1BCcvFiRStO5YI20LQ++l53e7tj5HqXvGUc/ThpnbLqhtB5sqOrt?=
 =?us-ascii?Q?USseayQ/qR7cGpz6w85UlDWGGD+1POIZD9/vo/s5cqD/CZAtabh9Zsyzsblz?=
 =?us-ascii?Q?xjrTaL7OUAoWcoOJpFoMESEaRxsTyCLKI2mesZjTNN6rTnlPA7qh9l/kYG/w?=
 =?us-ascii?Q?yKJGqWT119aJhSqPaOfvN9DTdKpTWzsM1EA8yw7H7fsCx+y7kvTs05WJI3fv?=
 =?us-ascii?Q?ymXOCqD+mztNv+q6Kj9+I9w8gfFqDsdoYPdCAuuEKL6edOE5LoAy7aiVrkHe?=
 =?us-ascii?Q?rT7ru9fb0fowS//lOSvhxRPah5d2Wpv9rHE8q9MoOaaUhjBPJvB5pc5m7d5f?=
 =?us-ascii?Q?8D0KDIXwoHYW1JDk+UxDWIIFXhjldIscEAsUj4KgGmG5x5St49CoY10jPF58?=
 =?us-ascii?Q?tvFH+Wyd4DFs1akmMD5IHPeCwdRtn/VAsZfLB257hTj+gs4/r+UBHut0nwjZ?=
 =?us-ascii?Q?wkmE4uuFgQ5h3HbrnjunX5QNsGBP1yAaLc6z1hXA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 96975d1d-7702-4b00-694d-08ddf1d528e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 08:19:57.1993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zrmTAxmckWgPzH9FM/j6K7p4CRx4/MfFmIIan6BIQ+llhYTVglzic1eWu55bJVQ1+Hor+6tf5riqpgAst+k/EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8870
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, September 5, 2025 1:51 PM
>=20
> From: Dave Hansen <dave.hansen@linux.intel.com>
>=20
> The CONFIG_ASYNC_PGTABLE_FREE option controls whether an architecture
> requires asynchronous page table freeing. On x86, this is selected if
> IOMMU_SVA is enabled, because both Intel and AMD IOMMU architectures
> could potentially cache kernel page table entries in their paging
> structure cache, regardless of the permission.
>=20
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  arch/x86/Kconfig | 1 +
>  mm/Kconfig       | 3 +++
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 58d890fe2100..1b2326d81681 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -281,6 +281,7 @@ config X86
>  	select HAVE_PCI
>  	select HAVE_PERF_REGS
>  	select HAVE_PERF_USER_STACK_DUMP
> +	select ASYNC_PGTABLE_FREE		if IOMMU_SVA
>  	select MMU_GATHER_RCU_TABLE_FREE
>  	select MMU_GATHER_MERGE_VMAS
>  	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
> diff --git a/mm/Kconfig b/mm/Kconfig
> index e443fe8cd6cf..1576409cec03 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -920,6 +920,9 @@ config PAGE_MAPCOUNT
>  config PGTABLE_HAS_HUGE_LEAVES
>  	def_bool TRANSPARENT_HUGEPAGE || HUGETLB_PAGE
>=20
> +config ASYNC_PGTABLE_FREE
> +	def_bool n
> +

be more accurate as ASYNC_KERN_PGTABLE_FREE? not a strong
opinion but doing so avoids giving one the impression that it's
a generic async mechanism for all pgtable pages.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
