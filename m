Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBE325C6FA
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 08:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740470557; cv=fail; b=MLavQ3Dx/+5Y1vsleS5ink1mfX3Y5g6Hs6X3bCKMGeU6+dhopzSWAojfHUX1805FK0rKh+Q7/eLqTflMCI2ekcoXDe7XwRIQ8xe+gUBxtuHZxwCkokxTt1aoPZZcNlzYSPYxgGPAVfTpYZSPXYbYq3NWszRAjIztA99S4ceWITk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740470557; c=relaxed/simple;
	bh=zyfG1pA+YfYHv3EhtH5yuQiKn33MvDuXSfeH5DZSRas=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JVk1CTBs+N3pycDE85cFSYlXKjRAjSsNUCUNyBBQMi6MOr7zD0k373vNGRhDzt5MUoNlw3rd11ofMXWqayYL30eZXhno0rOF1dJxqFpQPT+5Gycy4TtRuXjx9vsTjriUXV7MekDTdO4LSf3hO9L6jQOcfVcwDUmosRt0QuilZ8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GuMz0m3t; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GuMz0m3t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740470556; x=1772006556;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zyfG1pA+YfYHv3EhtH5yuQiKn33MvDuXSfeH5DZSRas=;
  b=GuMz0m3tV5KBlH7AY7QfoMUZbG0fsveEzqRPzY3QFEh5MkEgY3nuIg5W
   18luxPVaSuZrlfG+t3FLZLFHQQ79MQBRGlkzW2XQEbAYTA5HROdJ33NUU
   kfqbyEcdQ6QP7sPQMwQPHFwJW2/wAup+XwtCUHJ+c3nE/p8cRfjRqLu84
   6RTEu1Z7p8hZddRZqJt48+tkcLOEkKh1VeMGDt1zzzi7yA86QX84wW+M1
   6DiqpmsZkwgQNIz/LlsiSVZupnzwjus6KryKgeWhBdymO8WUFnWOc6vPA
   QrJWe7MRhTriyxUmKW2xm9WtbKb0l8SuN8yHr814XZh3NxvmrjDhza0Zw
   Q==;
X-CSE-ConnectionGUID: rjUiEqfnR1a0YBMYvEE2AA==
X-CSE-MsgGUID: 2WD1Rkg6QqSoxQroAHj1Dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="66633461"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="66633461"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 00:02:35 -0800
X-CSE-ConnectionGUID: N1quOYTdSG2GkkxdcHVnxQ==
X-CSE-MsgGUID: V2TRDNE+TDuaXCa8T+MeFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="116516301"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Feb 2025 00:02:34 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Feb 2025 00:02:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 00:02:33 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 00:02:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tc49u2SoJsKHBSsS/fwou5NBYUGLtNxpk0D0M9Zugi5ze/EznCKwT1IfF9VwWDUP59fr44yHCnAnAL2UH0RmYGgDdSUw2YohLjz4g2WeBJeHT2Ah1SgogzYwhFh1UVO/1gi9/qQeYwhy2/nPtojNdn6lzhNeqD75ob24djO4A0q5aSWvU5uZVwp4xpIeIVwoFBsJsttiyfXls1ezdXXETWEMDsbqcUldgfWhydW5LCTfBgwYiCkF9SiZZJOJeUhijiwB8csyTNwxc9unKdO++bt2cIy+HAjOVniTpVXAmVBl7kk7Gzog5uGBarAki4SKyv6LwefMt3pUAetozQi7NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyfG1pA+YfYHv3EhtH5yuQiKn33MvDuXSfeH5DZSRas=;
 b=oNNjA42451KK6mp79ZG6WYmuoORqfxyeKRa+BQwKQxnJmOmGMhIu1dIEngrJ4nG3ewdkSXXeTqmHyPZzviV9Dst2ccRvZcYly30XJPIH0pLGot+rZdbcCjtu32zS+VLHVtepfwWtcQssQHh3hxfi5nWPiQPqCSWSY9qy4PNzJcu1WIVTNLtvcwawALSEXzYIcFj5OMBVCapI2cjqtGdNkWauvPLNkdQQuNlibocOef+6SNlomVRr0rqoUQJpiSGPMYQ2WgxB4aTUR2SCJdnlAzr4RPymV7lg088/5YmAGOA1tFoLgEh+eVTmw0WZ3gInk5BrZ2XwV4csXu+J1eh0Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB7721.namprd11.prod.outlook.com (2603:10b6:610:12b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 08:02:26 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 08:02:26 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 07/12] iommu/vt-d: Put iopf enablement in domain attach
 path
Thread-Topic: [PATCH v2 07/12] iommu/vt-d: Put iopf enablement in domain
 attach path
Thread-Index: AQHbhntN7Oo1cfGE80+F16YGgB56D7NXqimg
Date: Tue, 25 Feb 2025 08:02:26 +0000
Message-ID: <BN9PR11MB527621531383D5AA5824D3358CC32@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
 <20250224051627.2956304-8-baolu.lu@linux.intel.com>
In-Reply-To: <20250224051627.2956304-8-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB7721:EE_
x-ms-office365-filtering-correlation-id: e8986246-8728-4d6f-e6bd-08dd5572be1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3CeYzFE5zwTQOoMBJIuLxyiBZNorY+fvr8TViCnF+r5qjdHl1BWfPjGUcYly?=
 =?us-ascii?Q?hvnNLfc6mEayHRZRtVblhkQowgRtGmYYP8fk9Xdrq2Dkvg0EXXb0/Ekko13V?=
 =?us-ascii?Q?73LNiBiNHJ7/ZDY8BCJ2644IyLxlYqE/07lTVQMmbErDysJtXGUXqJThoNHK?=
 =?us-ascii?Q?QpFPnRihDmahI17NAcHqIx8wWt3gs+Aj+FTHFIII2pYbM5ypaW4upqMBx+oN?=
 =?us-ascii?Q?8eBn1E3hG+tgfOz+X/7f0E7g+uCa+b+99nnNP33HJc3idBwFRRea/SCO5iI7?=
 =?us-ascii?Q?/jMeyMOBmSXb8xOV6m2TibhXeLWwFyGy8OpxvKyoMJhgMKS2Y5caROjNBJh0?=
 =?us-ascii?Q?kB5Ka4cIx8pymj0rjDZ0aoDkcZd1qTHbH0lVIvebmTJpWf10s0PH5IaNoDBD?=
 =?us-ascii?Q?QHUEB4NZoEensL40HqB2qBOyJ9OOpbD2RXzrU2x7YzehvsZpl0+OjRL62U4e?=
 =?us-ascii?Q?OQ5/xi3qaaTL8OfRI/0wEzxwTo76mGBkGaNi6aksoiFx1ggs6Ffz7xt3/yXP?=
 =?us-ascii?Q?CXOUM/LQEquvQ8dZgdZ3dSnKKDawQxcxUHRf6RPCT2tk1X1LHzZhkhOQEGcX?=
 =?us-ascii?Q?M73SAvWzr2K9AYopK1iyKKvHvYXZBr3mxMBAGiipz13tCe75iqK6go49WV8C?=
 =?us-ascii?Q?dHlHr/BlCCrJtjjeF8WFxCs0exkn7ESkiLgzGe6itMwI+nb7eWXw1DxDf1hu?=
 =?us-ascii?Q?8XZbq34k1RLUO8+u4Gwrx2hiyDNMF0bKB/9b4lmO6R84ftYaON563no3AArd?=
 =?us-ascii?Q?kizLk5biLRT/aWDHW1YVBqiw51twNxIYoYtwdKWC6ysQmOrNCLzCDKh+N/II?=
 =?us-ascii?Q?oWsWqWAKVxy9WPuKY3qjIn4h2ljf7mV3AP6hR9wt6ntf1qLndXj1VGimIzCu?=
 =?us-ascii?Q?/NejWikpxmB/Ndtc4644aPCN7v1Ili618L90tSDUkbq0o96g1e6xu4Dozgio?=
 =?us-ascii?Q?xdvUCiZK8xi6BqivsvpG8mJxKJbnzvuIDXTX6VKjphAjKFtyj9f6zToQ21ek?=
 =?us-ascii?Q?B150Mn1AgJDN8xcgcZ58iYzTsyviSLanCrdg0TWVwokkbHJu5SKVnt+MXQjT?=
 =?us-ascii?Q?kOzUP90Q8rlmobRqVEjHPxPltnLkyAYzOdMvPn7buyoauor8eJVlIkLHhfSX?=
 =?us-ascii?Q?etfXF9ThLE+M1K8QoFz0w2nH6CWyD57jR8LOxaGjHYenSPtIH+FY3tbhKGm5?=
 =?us-ascii?Q?1g7Mlw1Ai2S+CSeZDVa0vmMixuKNgvvuDsKEHztsyO+peHweiGYlpijguwvF?=
 =?us-ascii?Q?FsgLqWMR1i0Sog7FzEtWFc7fBmy0lTzZru0ltmV0ttdgoFODP6ligC8qBujH?=
 =?us-ascii?Q?XmYp5P+Bb3NzU61/w7aRUi9NAZDt4mCr4H0DCnkCvpgGKmpkTKQ6cNRDXHYu?=
 =?us-ascii?Q?BlGkvdw2ggetAs8ckqxhD66Tge4hH+MNKJi2xiQOp0j+FNQ8Ih6Ss6lVHSgm?=
 =?us-ascii?Q?h3XgkMDnPxHhrAtrkQlsu4n2+Jw7XVfG?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ge/JfY9Ng+lQQiGGTVeLOfXypdEQHmPVMgw06HSKf+C67Cz8e5ikJr2dn6Op?=
 =?us-ascii?Q?j+zPokS+RNOHMhbYVjWsS8evOM43x7AmXmcXTLNVZ3iOTV8bcq2wLxtrs6+s?=
 =?us-ascii?Q?u2dc/qteLt8i1q563QfJpH7bwnCdwgFasY9DD4Uyg+HfGMHb4sQxPptL1jVt?=
 =?us-ascii?Q?3jiVutDkbN6E8YPYpA7Wm2jgWeCdLXvy2dR3/38iU7ghWzGfqcJeKeMUAa5b?=
 =?us-ascii?Q?NpQujMyDO1zFDCCfO4KNTh2U1JOC4cE9a5uNz7FywLtaR40Jm08hL/NCwXJ7?=
 =?us-ascii?Q?6RfWElpanLQkITYebD7F39ruaIDoqgfe7t8dQZhra0zovejnwflSYUegGRGJ?=
 =?us-ascii?Q?mhEBTJEMJjb2EXJaokBGdS97+425gklxZXZ1noWYgVPVCfrqpqU3iIQ2Wo/+?=
 =?us-ascii?Q?jknW7BK21O0CMXq5jLOYXzU/T92NjEE/wuJqT/FiGBZsdDJeuCQXZdsYb5yi?=
 =?us-ascii?Q?KPmjHW7fpoD5+ZNmTTlVqqGKv6Dtn89JyxM1Vv0p74MgDGvTsGHJWrjQ52f0?=
 =?us-ascii?Q?d9QwmXv6VUlAFykpovTo3vIHAtAsKYhMZP/ox4KBP58UtnU3FxAkdz/TxWpl?=
 =?us-ascii?Q?gBNJPoazJ+kHf8LH2P1He+TvtyxqHanYeqFI1m/m+WBQ+OT5KUg8JxfdkW7K?=
 =?us-ascii?Q?YgsmAhciiFJj6Hz/cTWyo9dxvCtEUG9z+4gWJ+MlhQDhkH/Up7gEFYG8zGah?=
 =?us-ascii?Q?MUdZWNLOu38cy5EhNdDzuJhMaCbXfShXgsjVex3sIemWxlSA5nj3INq6pF2W?=
 =?us-ascii?Q?f45Id1t0csmvqk1ev/QVi9JM1mf+TOaK/zc2eSW1gwKqPIsfANglGjIFviw5?=
 =?us-ascii?Q?hQz8U6o51gLxFcJG9l3MivfXYPKMS5UKFTIG0THsIzRw7yNpHINccdMZWRiX?=
 =?us-ascii?Q?zy2HemWWX4cWcYfvlTpHkuMxPw/gkzb0zq4c+MOKRZkoAV9WAeEV0mPyXzrm?=
 =?us-ascii?Q?BQQr8HACR2AkxicLLIHyu6/yM+5BplbeL2tV2wZvho48sLfFxDIvALnB6r25?=
 =?us-ascii?Q?FqPrRFP+/QIYLIENrv7zsWllgqFAOYqeaQE1k9+dIbhnl5AFtWUE6b5BhXdH?=
 =?us-ascii?Q?QyLJnS1ZvH/vDyP1FQRmEZc1ApwNBxfIzhEeHVsJG6ROF9XJx9TqdeJD7pFw?=
 =?us-ascii?Q?MoCcCL3cMoAbZKAN/gQoYlJ89nep1yJeBrA9YfmIRv9yvbIykkaUtAYkqVVS?=
 =?us-ascii?Q?aDT8aeiATyuYSkrlWVXjJJRYImY1ifGAJDq6c+0XoABE9h31RQv44KfxCl/Q?=
 =?us-ascii?Q?N5H5CLMcJ00fmkT83mwVrI4W4wvbMbjUvcE9cuz7DBB5SjYXhHXvQje7PzL+?=
 =?us-ascii?Q?PupA5KoOHD0tP8JVaKl82SAi1fOapB34P240x2nMajLS4CHtULJB74h0E2z0?=
 =?us-ascii?Q?lOiup1fLH+I3LMfonmCbhtBXzy27EXgCxGP9zZpRbXt4bw6vg6rYukRvr3UM?=
 =?us-ascii?Q?SxFn2XponeO5cWfxkRSL4Y2uyX8ARhMP7NA+4FP+gh8rU3duG3y27f/lQaeI?=
 =?us-ascii?Q?OXIORlue3eXx/7HlD/nolmWra0JDvAMvIpYTROc5VR1MIg3dv7vpqeLh3ZNQ?=
 =?us-ascii?Q?l1aGJujnm3kl/ZassAa8sJyErJ71lUZWVFB2YOuM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e8986246-8728-4d6f-e6bd-08dd5572be1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 08:02:26.0462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a7cPB04M86BQudHvHTqRilspgdu75SAVin2gbdh8RX2mg0qz7T5qbIRKwPQwVqZJIC8ZZKVF0TGplkSwI0zpWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7721
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, February 24, 2025 1:16 PM
>=20
> Update iopf enablement in the driver to use the new method, similar to
> the arm-smmu-v3 driver. Enable iopf support when any domain with an
> iopf_handler is attached, and disable it when the domain is removed.
>=20
> Place all the logic for controlling the PRI and iopf queue in the domain
> set/remove/replace paths. Keep track of the number of domains set to the
> device and PASIDs that require iopf. When the first domain requiring iopf
> is attached, add the device to the iopf queue and enable PRI. When the
> last domain is removed, remove it from the iopf queue and disable PRI.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
