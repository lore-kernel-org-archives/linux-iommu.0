Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F744582FF
	for <iommu@lists.linux.dev>; Tue, 15 Sep 2026 07:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789458222; cv=fail; b=cnUi6KDvLWKCMIkxORW37AvTcKLcqIjR8kPPzSkckuRftUmq+TsyHFyzPwVO7rYkA1xpB8+mnTJlHfWxROp2qv6JWoCBvw0Xqy/AMHUDP4l3ByoOFLwNCjghkz99huLHdeJsn447HdZQH5J9KBfzXjFRrNmANQ15G/IIOoFqe10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789458222; c=relaxed/simple;
	bh=ls2A/+BRR3rl3l92FMzpRYzwwcK/XRaIouuQ0YNILTI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kvmDZ+038U1eAWkVMR8Vm5qc7uPjitbOgbX3eMocT42/BXbCMAd+LMeelAg/EqcIhrA28Svy8RYIwCNgLENFPWSvpLHoa4i4SiUF09z9BXNVN7xG5lrZOa1QtuJMINInMtiue8jtLdbgoYsK3SVc+5mrazuq/3cRn9P8OkRvFhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GsmYRjLo; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GsmYRjLo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789458222; x=1820994222;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ls2A/+BRR3rl3l92FMzpRYzwwcK/XRaIouuQ0YNILTI=;
  b=GsmYRjLoun86Hi0L+lJo/qj8S5GHWqZ+tztRVFH6s68T6cHlSEwNI4Tr
   tz+kD4aG3IeP9sIewJBn/dOSyqI8TuRnjRsrf8vw3WBP3ukaKMe0E+dzc
   OSsHHtvyZPTkifFsTBY1sPXhPDvo7kDc65JEp0qituyxodHyR17l6fLWY
   WgoqIZ9jTcg2C9JyyfWW7x07sVr0rPUjhjY9QGbtspni5N9PLLsQ0MKhY
   KGubR2osVAk/Z/Ot9hr8r71IZYhFougNXE8qtaDMi/hrURmmcNweiQQaB
   f9xGJpJcIikVho7HD1A1gz6ryVKdaMmucLGqDbkHjSMsAjcNeoelQO3xL
   g==;
X-CSE-ConnectionGUID: OQ1JhRaEQPaxP8/buC0vtg==
X-CSE-MsgGUID: 2ODP+FSoRJq58BUxfSTuOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89656419"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89656419"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 00:43:42 -0700
X-CSE-ConnectionGUID: HM5aAq9xSf+7FRiRRTsW3g==
X-CSE-MsgGUID: oTqhnT2CT9qJ39341YhaMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="277026927"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 00:43:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 00:43:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 00:43:40 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.27) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 00:43:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aU7ESYftg9yyygEMbm9sXfwFUdBDC7Fk8hrsW9J0BBgDRRgfgo6I2MNysYS2aFcv4Vf0U1vtEwhQDTMYIlcCK+pIzm15uxePqb/X5kvzif3ET3Nck6nZsXIsvGmsFBhHlNcnWWD5AU2J6mVTPe40mG7W87HkZ9ndpLU7BGBGS9qV/s+HABM6AcTdEnSrl8SXGGpGXCEVtYi2vA1TmfLqL8rV3v5qyjwkiPXj3FfZNtxC2AKyRL8RGLnaUQy954w0KQVkfGmFLEMC8tUW8q9n9fNdSX5n/cMT8Hrl7YZoHp0IQhLSIbESHNCmn07jfnnJNsabWnG97DU4VKvsaUlYig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5nuBbvars8XyS+WueZJ4msNZ2yMxZ4/d9Wlm6SqvAg=;
 b=D+ficT1wG9JAHkva8AJGPb2CVR90HxVsqVJ7mrIufeBkb6q0GV+m4CcxrV5X92dqKFuALpLtnBnBf9ib5mMK2byuEaXugHv5KyZ2NJcmqWR3VtTNTuPQksnO5NL+6TS71f+qZtd6IqCfyb2QFu/jv2irmuUzqjqaLD5/jbWmOjInMUMBFZzVkWYdYCJlPfg61ZT97wfzFHDXBykdtNqP6MKJTWaY6eWUBjIXfSa8thqVquq9XjqKIRYvgCp3MgGOZt/u7HDSEFRU2FcIza1AKKVtBvTXLdYecMb1qraZ0u5IHVV5UlLg9m9A3/l1WAoXFnEjGnNg76/GVtYzt50Zew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by SAWPR11MB9924.namprd11.prod.outlook.com (2603:10b6:806:54d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 07:43:32 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 07:43:32 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/7] iommu/vt-d: Fix issues reported by Sashiko
Thread-Topic: [PATCH 0/7] iommu/vt-d: Fix issues reported by Sashiko
Thread-Index: AQHdQDGsev1nHuREKEWUX5mg+qjWJbbPS0NA
Date: Tue, 15 Sep 2026 07:43:32 +0000
Message-ID: <CO1PR11MB4835387F3093C710BDAF6AF98CBA2@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20260909075106.738691-1-baolu.lu@linux.intel.com>
In-Reply-To: <20260909075106.738691-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|SAWPR11MB9924:EE_
x-ms-office365-filtering-correlation-id: adaa03c0-aca2-4059-be25-08df12fd0a6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|38070700021|7136999003|10067099003|56012099006|11063799006|22082099003|18002099003|11062099010;
x-microsoft-antispam-message-info: debriF4oM/8FSdHdirVN70j9puTJSAQTDmC6YqGskuluIIM18O55OjArgBet96pjQXLOLfVVTdCLHcfVXACSdxyxpnaNsvslFY23x+jf3dSpKx/Gmg7ts494mI5aHm3CLmrTAabglieiE69sUnV5/+HCX8aRAotHdoaewAOyw5gUxLy7Bo04G784/AFQWObd6ElX8KulpQUANDf+CfVzGnTjIp2pUHfV9WdhIHEqLa1QmMbekqOSxaH0zc40Ll+8cOOJQy5Dv2y3e6hUGuJ+g72Kb1qhz/CP3jb4f5bgY5CNUkWtI/w4LRs/MzX7iMrvWxrZdjYV8djfPslKdT1Wir9jiMIyjMC3v06vNbMylYGIrNABHy7N2Ot7sh6OYZ+VhxuPju5RCKctIkok1U5tlbR+EEQTENCNvwyWKz3pt2D6f1G/ZtJDeWt/z2qd1kP73hArZHBL80Zj5DgcwnH12ywfXd7Co8/zf25gJuOWOZSw3CIc+lr/DdSwbhP2JbYOrS1pTykITwcGvvgrL4c3EvlwprHKHreuffezPqaB3khIm/lIpOmayv149lEYsjxkWPxMTZWGKCw4o2WuWqHbLcL+JHlhJM7iJOHSVP+GbsHCE3gQA5S/MurvRkZRM1MGQlaVng58aBS5Xl2X5mUsQE/ofY/fCwGRclyErRB3OOWjSGQfqE5r9IAMptXcN/Z2OACch4a7ViufpcJLV+Jc5X8lDT0KjAXEL42VzcL0Azw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(7136999003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(11062099010);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5yWtfSNBHTaVx52Wyjnp9s6103lXhR8BHArspF0Wpj7FSpEdPn8UqGP3krwQ?=
 =?us-ascii?Q?0ne+dPChHzEuxZLkUDVfE1/ypRNPfhj7qGHpsd0QrZGdcKjf8z/Q0svPY3Th?=
 =?us-ascii?Q?A11/vDTt/ViGtMkzX3GxGqKkU678o7iWDONNjy06PbZKtnFlUCzY99hRTfiw?=
 =?us-ascii?Q?F2IGy6rxnV+gPVwMApQ7tq4hIyunItOCWHU6vKntU0BGURdaYbEyQKpA8Pds?=
 =?us-ascii?Q?Oh6Bz/QRG4s2Cjns6I5YHjsG8IvbPzm73WS7As5s1hJZhmX+UlE496HBhEke?=
 =?us-ascii?Q?1dzG7yxu5XYU89OsLjT5Q86db0v6Q+TdapSDEoQwHxl4DafZejYKBUos+2Ax?=
 =?us-ascii?Q?lxDmGCtH36h/DYeePH2oFGJLjHuKJiBc2IN/tkCCoUHgW6QsQT6EfkMlZNRN?=
 =?us-ascii?Q?NVLFZOKseKfGBzHnGNoOp/GspXN91DgRhfmVrHvsCWep7n+PMf/Iu9B5WtuO?=
 =?us-ascii?Q?O29J56XHUeOWgCovUCtQuTO/b9VzmBFAy29ZBiuyT2gsHsyiFNo2wyj9AEsk?=
 =?us-ascii?Q?XgRzB45+bw6qolt3ZIOM6/1OGONR+ZnQInyEp7gBCTuoN4NHxKXSQv8P76US?=
 =?us-ascii?Q?An+XqJdouvo0N5Uwnn/VLM9yHevGVSKU7nolqTKph61e9kiwsfjBR6tHyMQ2?=
 =?us-ascii?Q?b0QCAEIngILWvh1lrKtUHeymsk76tJINL3po9+iOqLCUdBj3G5GOFLlgcArD?=
 =?us-ascii?Q?NeSl1hcMwB8cQTiWKm42otDef5DEAXY8P4vTXcgATJhcwhcj4oBSlt9lS/4n?=
 =?us-ascii?Q?qLXPwqCoS/HPD3WUJ+7PX4p08xSOe/kfHlGzmKCOa6+NCuI/qXYJp332zI8E?=
 =?us-ascii?Q?m3v2fvOmztFak5h61E5kxaCnuC3zd/U7Vrr+EyRLPmdl8+KPdnmu+4qQAVgN?=
 =?us-ascii?Q?alAEaSc+jq+iaOL73dlmf3do6IGaVvJcSrATxWmIqsFmwTtyeNuzQ3sodbjd?=
 =?us-ascii?Q?aWooQw3wLxA0UMUlIb4i0XijOzwqZn0edsGWwdmY2j+WHLLI4oGzm4A2uUBG?=
 =?us-ascii?Q?5DK6GHeUA5vWGYjGdMemBJv5lZQ5+a5Hfg9f+5CHqPJJ/AYTRkIW7VZPV/B/?=
 =?us-ascii?Q?c9vf6MF3Fg5MxbkqcdkXEhJOuY4ceiFZSIdNLCRn6sxGeLjjiDYITaBM7c2h?=
 =?us-ascii?Q?2MjBNIRlMrhBInUhHfLdOCSZFJy/xNbMXPEGABAdkDpzVZ0yEcMsyHpjQ3zP?=
 =?us-ascii?Q?q2kr/aNgG3+vtXXQtkbzy4dTuFkwIt4IoqVeL4WY3DA5KHnS14VnS+ZBs0UU?=
 =?us-ascii?Q?G9TF9ZF10534hMvtq2DMVR39g0ACcFOUFEqoeir9udavvOuCpYKTBNWw4lqG?=
 =?us-ascii?Q?zdW+OLQVixyVN8euVy0nzl+DAuwZXgeIPq141xTyYn5TICsoIFACeMI4TLQ1?=
 =?us-ascii?Q?hnATgE+oeyPbfcIn6NXNcu9IbKVVyshU3z7zkG2TES8n3b2F7jdLvK3CRakm?=
 =?us-ascii?Q?+OpbdtSiT1wo7rd1aY7+Zag7/DzHyZbWZ+pVkrdfgiCQnIlkqUffCxhkBkl+?=
 =?us-ascii?Q?Tp6TbXbfB0P2BEqrANHCQu4sOLyHCm/GI8W/twouxA9EUgRdCcp0882x9fzZ?=
 =?us-ascii?Q?BKL/7v06qEmA5HEQ/6HpRA50EBee1NqdFkWeqk25FtYbSeqyQtCRd/2iJn39?=
 =?us-ascii?Q?nR3Tr40CPsATIfWrc5/NTAm6GkOcN1PZSUSdomFzlbvuky0XuIAttVmepAUM?=
 =?us-ascii?Q?Kklrg6NIJAqZM/PA9ivWh/H0n02qAqOlrTzUrjmaceNDMana?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sQFgd8BbSeEu7JvotXGYDf5zrPZqxFrQPxQoGL2EacopYT+MqtnT6nfHOixgteNYDsP2pVP8legiCQBJ4CPUo56ssjgsannGhk3XGcYDCV2sBpFGEGgIlR0wZ5ZPZCl8H4kBX8cQ0XnrGlXIxd9i8vFshYhPDWA4r1o+VqiCJhLgNzvh94RuQD2z/wQAl6bXAy3rwfFo0c3kwoFdzmAFG1TRFX/yPgajZeK8aEif6X4zbP3ilg1kCsDh5dXs91UBLSKa0lhYgnTu29SpWkNjyiP7CBk2dFwr+VDeEGzvW2tlb405HM7dbFtf+uQeckzINikdeYx31IJVVipbsYwkMA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adaa03c0-aca2-4059-be25-08df12fd0a6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 07:43:32.0327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0XC9zbFwcOLNG+LLm8OsNCYoUtdaHHrKuQbq7BJztClUT4C+bhdGkKccax9B6C8lR5J3HwbLJ+RYjfPPcLu1kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9924
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, September 9, 2026 3:51 PM
>=20
> Hi,
>=20
> This collects a number of pre-existing issues that were reported by
> Sashiko while reviewing recent VT-d patches. None of them are
> regressions from the patches under review; they are latent problems in
> code those patches happened to touch.
>=20
> Thanks,
> baolu
>=20
> Lu Baolu (7):
>   iommu/vt-d: Avoid out-of-range shift in qi_desc_dev_iotlb_pasid()
>   iommu/vt-d: Do not ignore context table copy failures
>   iommu/vt-d: Handle DID reservation errors when copying context tables
>   iommu/vt-d: Reserve scalable-mode DIDs from PASID entries during copy
>   iommu/vt-d: Use old domain parameter when attaching the blocking
>     domain
>   iommu/vt-d: Fix iopf refcount leak in nested attach
>   iommu/vt-d: Drop old iopf ref only after attach succeeds
>=20
>  drivers/iommu/intel/iommu.h  |  17 +++-
>  drivers/iommu/intel/iommu.c  | 152 ++++++++++++++++++++++++++++++-----
>  drivers/iommu/intel/nested.c |   2 +
>  3 files changed, 149 insertions(+), 22 deletions(-)
>=20

for entire series:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
