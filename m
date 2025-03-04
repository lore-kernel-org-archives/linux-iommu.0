Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A611FA854
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077581; cv=fail; b=LnQQnjLtkxZ2cJ5auaoDLH3duCANfFMlKFz+6jlzswNWGBWFUOuw2THD8IhLmA/floK4CAMeafsu6j0kpNFpJt9ilOLKOtRo75AhOdXlP5BSf60Wv2LhrpXzPwKhGeWKyFXsTYgDhGnhMcE6ydhc1pZEqqWW6Lg6LgZtK2Sr+rE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077581; c=relaxed/simple;
	bh=kg+6XdVkn+hkzj7MJIQbQPXlfWHAoMsouBtqWNPRn0k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p2p46i32L3H3hUz3UIAC/UnJHU6JrxdUvkdN6wMcWLFlMxwzuNch8W3rHKg+D3RLNjQ9FGqY1YpjUm0fptWxceRpqmdCwB364Zj6/b/t5a7mcviPK6ASllPoDrrApZigCGBLdfgdAzZiRPzlxS7lG0KbrXmenefdPCzS/r+q/Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OOhxAitJ; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OOhxAitJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741077580; x=1772613580;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kg+6XdVkn+hkzj7MJIQbQPXlfWHAoMsouBtqWNPRn0k=;
  b=OOhxAitJGXibniCQuz/F1crsBWynyj9FlPC9oSFgtD1vKeqe5zQWi7kL
   X8PT2EunkbjLmlP3jjz16l23Vy4dTSUlXD3XyfuOUQIg9XoEJYexJ1FER
   3JTA0cZjOwNp59OsghZv0nm2UMWYwKStDFepIjXUnxPRldzowHrCyNCMr
   EyfqHfo6vooOxIZjBKvDkYRUnxfYEAlVOYry8MhXWycgsDnPAxFeazoF0
   K3+DI/K85uLfxnOaPtWVVxkZXlL3I03zyFW3RfcTVxeCrE4wqKdyfryQ+
   QiXYMCIyY1rjj73UlDbOw0YFQk8iwNlRYZswVHnCUs96Lu9peoIeXORDd
   w==;
X-CSE-ConnectionGUID: mga7tioWRp+xGCgO945QHw==
X-CSE-MsgGUID: pqlGfJRLTACvZOu2pcIFsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41161273"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="41161273"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:39:39 -0800
X-CSE-ConnectionGUID: 2Xinsi3sRpyGZBkFvEEb0Q==
X-CSE-MsgGUID: Fe4n+ckBQEevlzl2Yn9epw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123517647"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2025 00:39:38 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Mar 2025 00:39:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 00:39:38 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 00:39:38 -0800
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB7006.namprd11.prod.outlook.com (2603:10b6:303:22f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 08:39:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 08:39:33 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>, "joro@8bytes.org"
	<joro@8bytes.org>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>
Subject: RE: [PATCH] iommufd: Disallow allocating nested parent domain with
 fault ID
Thread-Topic: [PATCH] iommufd: Disallow allocating nested parent domain with
 fault ID
Thread-Index: AQHbiDreyjCkiU5jcUioamQDJyDkNbNisV1Q
Date: Tue, 4 Mar 2025 08:39:33 +0000
Message-ID: <BN9PR11MB52760EE31B0D138EEBBE031C8CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250226104012.82079-1-yi.l.liu@intel.com>
In-Reply-To: <20250226104012.82079-1-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB7006:EE_
x-ms-office365-filtering-correlation-id: d6fbca43-f621-4043-8ab3-08dd5af816aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?tHtKZrnolNkRgRrte/0bRkY89+QlcOg/eePXzMC26jffc2fk09xAbL+jI4iY?=
 =?us-ascii?Q?f5RW7QtRbmLL02PhOkMvzbJ0VD0PTbo5ytAgu7bG4ljaUuATQiZdgfEus3tL?=
 =?us-ascii?Q?kToaZylL6lDE6Ta3XcFITnpqCvkVHgivJqmIrWbNnkFycLBvqVXxgnbeNOAd?=
 =?us-ascii?Q?PIicniy+2yOF0AklX/FxxBDtNMRrGq3z9kQjWLATh6Mmq57PPMlbDiS1fSyJ?=
 =?us-ascii?Q?5/HljKqWUJrMynNSNHtPAYtiCklIM20u0qFUe2RuCBZopEuu287gcZ/vmzNj?=
 =?us-ascii?Q?5YqGUAqahISEBg/9jCWti3fLdvyWYiV2ayocqiqp0QtRYCpiB+XU6Ss2Ry7Y?=
 =?us-ascii?Q?Pf4DiYfZQbKtMRpz0UhB1qg66L+y31M8+KICBr0XASJ7tOf6xG2RSlMIFBuM?=
 =?us-ascii?Q?3K0Zldpr9tTrBx5RYFXX6zZgS5H/HXpxhfkmPvUU56t3z5vXLzTh1S1UqCd+?=
 =?us-ascii?Q?pcThtaCYGgdrpJaEV10nKiGR/03k09gpsXp/rha0aCZZcSe8yiLj+VbIEc2u?=
 =?us-ascii?Q?Fp+zAi8V5tiD0VJz+j1VV8C0eiwPsINu9HdtRBmcuFqa0o5V9Lg29/Y5Y2jW?=
 =?us-ascii?Q?6L7Dm9EHFq/3M8QRgCco4wy0VfJxZ+qt8aBx3bGFewpIGE0oBlcDRycTF1aT?=
 =?us-ascii?Q?jCpv2kDZZC24Dz5wTel9eQeygeRm+2alW56kc+0+IEJDNymkyiymnbHE75Qa?=
 =?us-ascii?Q?kucegvNKBXeb43yf5lmYfx0PlegjnE8hPS9ujlKl0frzRF58OB9rIv68S7mh?=
 =?us-ascii?Q?FiMaG31lE4vo6GWKCGP6egkyPJcBsd4A+gAQrTGbxPGEHIXFx/xu7UZt+jy9?=
 =?us-ascii?Q?NCBMsHWz8BljCetxoHMkQSBIGMIaxRGmE6AJcYBKpOcfpEeL3TVt4DbgKqnj?=
 =?us-ascii?Q?6tKvsFcbyhFi8MrsJDt/WjE3npGDw1ztbQGyV1pqgi9XxL9SptZo80myBCg7?=
 =?us-ascii?Q?HoPwrdfF4JGBnDIvOYSYH+U0FZ4468Oda/+NSwrcUwOvBzt/5ZZKKlUv9OXo?=
 =?us-ascii?Q?ikVabmRUkyPe8Fh4RQUt9BYFsoeI0SRBaokHSHI4jVFbiF5m6dLekA8J5NN7?=
 =?us-ascii?Q?kS49lhT/MmHQBisfIeIi1ad99SFHumUnpebyMmQclP2kWqgSL0Wzka9H2yRT?=
 =?us-ascii?Q?nB5t2OL1RfOYVYwnebcdudhlSxdxcJb7UE4/bF/QWeFOn061VgFEEe8wxIXx?=
 =?us-ascii?Q?QfWTi1uc5agdClQ9b5r9WIiDAWFSGD/yRMLKLwRBFcwU283FP/iGnF8cv/ez?=
 =?us-ascii?Q?e447JJm2rB19vMrBq1k64EzJXnTBN8Srw/IO68Ez4ajhkWMX1Ev4abBBI2cp?=
 =?us-ascii?Q?+w6CZEEcQQvSSRlyE1k/VKdMsdNUQMEUgVeR6e+dZ7DF3oP3rZTfUBLYvD+O?=
 =?us-ascii?Q?tyJQuTKGbeyXyqWr/oAF1zuJbUSWsWiczvZ5IokDJah4Vxy1aQlcI3XrONDf?=
 =?us-ascii?Q?3aEnsy7wKzKavbj/ZaxKsWS+IMHJGdXb?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6kOGsFxv0W3y9QmawTmdaj8ku6+Nyp23i9TXaV2wxQ6F0fvGZJAUU64IyOiT?=
 =?us-ascii?Q?iUTbysxfUsgntFQc1vOEjYR9Vpx7DwJrQzUKvEkjZUj8GReEHExNPYYGDFVF?=
 =?us-ascii?Q?kGwk0SpSxi8h7c5f7Sux7qz78jHUZEyf9779s5w81trk/ZrtDiDVuSNOnPi8?=
 =?us-ascii?Q?ruEdimwn/UbnLQrBAGlN2UiaReDnVNzGKvXnLrJP5jEKJCBAE8eOrH31YDvL?=
 =?us-ascii?Q?eAToLigJDVr7hdi18ARri2OQO+6CQwsEXyN5bzh6evK2GaKQm48K8wNYEHt7?=
 =?us-ascii?Q?eM/k5fu/zvZIiulEaj2x5vDEHypK+hShv1aSWoeq3U99FDcq42tP4MYY+pCg?=
 =?us-ascii?Q?cSf/3B07Jce3LKJUn5xdgsaMVmaTBqGhsjZ/RWTg8Rw1EJiUq4xJwYV1ACSs?=
 =?us-ascii?Q?rrJtAbAKn/WnhCFbi6GYBlo6nsArD3kbQXP3Rw6q+e/BsFxCXL4mOePG+2kn?=
 =?us-ascii?Q?tXml+Kax/NRvqCq2EcQWl5gVHyhziDq3X7pXX7P3yLM2kmRIsGNYuAS+TUOx?=
 =?us-ascii?Q?UOldABQHzGljRKwG8wmk6yX55FICHoZQ6/TxuT+f0RrncprUHneabzI9yqaK?=
 =?us-ascii?Q?OLsGDcyGPQuxFzduNci/obcG+hWYmwETTZPeeJh2ABbjII1Vd6vUkIqqeByy?=
 =?us-ascii?Q?nXQXW20N9penSXZ5N2miFwKk6F+eXPlNS6515q0BjQYPnZcu6/d8rb7G0TyJ?=
 =?us-ascii?Q?4+6B88Tx+mN4oogTOMQzF4iDJhAgb7ODxJHYQg3gbJToRsPjvdhOZGp9Cybj?=
 =?us-ascii?Q?pzBWiXPLQZNyTV250g+Y2oGd2k1jNZguldNxobJeVwhTgroys+xxICQhWI5H?=
 =?us-ascii?Q?d6AjJYwWfG27TOqQWxz8bV4dLlvBI8qqUtRzefVtpMnA0KF5UkKKhJQCYwvj?=
 =?us-ascii?Q?LEFqWXiQ2l4ndqqB1yH4DtJdlKhue8uTbr/SBruc2PxZ++50SSoDnHgB/F9J?=
 =?us-ascii?Q?FlDpqrOdYT9NGhjRAa2mPuf3Lxxl067wN9JBu4b/oB23D5BdDCjBHIO/XM0P?=
 =?us-ascii?Q?qxbpYHNRyHrRxP2rcgFrJcAe+CXJ9m2fuXJ9cXsPrHZUZ+tM7f/0+bPvNZnM?=
 =?us-ascii?Q?ww14Tv5a+pXflQlUPb86iCN99fii7cYY6VjQB3z1Y/fWISviXl5caCl+Omqg?=
 =?us-ascii?Q?/WRCRWUk44wVH+IHxquIsZFGDYhFeSiWbJ+UY94JwdrjY8JAleytyu9vGYjV?=
 =?us-ascii?Q?i84VMdoSk2Dbfal0BFyas7CabsEahDmfXAmdLNUoWUO2rgfbf67QvdkK8Yeb?=
 =?us-ascii?Q?/ojnqJk3Mobp0lDVJUcGUV11g2H1Kb+kk8wOhZOuZVQJV+s31pfIoK6vtwrh?=
 =?us-ascii?Q?jCJWu4eOLyDNHqq2HF4R/BAP7kH9QymWo46c2AoQy7vQUSYmZmGZoKe9WspT?=
 =?us-ascii?Q?rcDlGJr74rnCyw0a7nzoI1rTtWp7TZnPebcV9PtvMXGdL0DWiKMczyFMVyDz?=
 =?us-ascii?Q?aozpUk5xWtRfzhxWXXB69/Z2B8LSp2nTd/IBNmkhIKrZSuI3WmPQiZoAyHwb?=
 =?us-ascii?Q?FixGl0+HdzggEFaL6pDXv4OwfDspk1K5lFmzPqHjU6cQwglkQ6MXzjW1SSUW?=
 =?us-ascii?Q?WOzLSTWsfEgn0va1MEp5MZ653aX2jTssvX3M3ngF?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7yWgAtJyHoNZTmvyZ747pvv8of/5evRO6inMVP1Jv4WjvlohwinP8wEKBHCI3dUoKOHJfNPUTSaY1DdaqC3oTevldz1+bgzeoTPCMQX7DI/EKqZiuJpUJpGqvNhwTXp8MEsjIn+s9DzfLboOkBt3oTzjbsoPSrghfssAeMf+oHgZDHuMGMhZNpeljsP5ub7Z2lw0vyZQjz1QlW8+clcJfS76PzGhV0OkxIFjoBtO+EOx4UqOxqqpzJ7KSomvqxhd7fhjF5xMyRdspVt4rQuJkrcEVHUCmROigA015doXdFB5YM49uPpgKo/dtrBlDd4SnLm0sTaxL+IX/Z2jTeyGA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqYmARMuD/5Anl8AiROjomnt7XtEUTf9ZHHGYrJ1BB0=;
 b=WN3QT6wYcZrvi7NK/1m28t7YdsIuaNzjpxGDLMdw3+IQzGfUAc0nRXgMry1usVlogxUoiTxfftP8Uf/9rOXu0mq9t1hjJ5QhtptZUOEFY8ylPBoqgvCqrdK/kMEQOx4sEBANoPPSSjNaJRTeTzdYxYUOfQRtqrIQwbEjO+1yaq/xbfm1bbxYmLitvK+/QLo9mKZAisbGo/fSQS8UfMU1tjLusS9rERc9+b6pWgE2M8kAID52V3lAcuYKLe+8dCKZ+5XTmzeBa2uXEwzMIE97QVtDfxqbJ35OZ2nZEmNviC191mfoqEf1yrMi7IfzRQ84WW3FyEKF9oO+rw4oGqirSQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BN9PR11MB5276.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: d6fbca43-f621-4043-8ab3-08dd5af816aa
x-ms-exchange-crosstenant-originalarrivaltime: 04 Mar 2025 08:39:33.4638 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 5wFBm7/br+etsk35vnoqBkys7IiQR7I9xg3TmVTuUdHF/3iTJpYraqfISxFyei0cRJDM5P3u4RUf5V3m5Q0B7g==
x-ms-exchange-transport-crosstenantheadersstamped: MW4PR11MB7006
x-originatororg: intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

> From: Yi Liu <yi.l.liu@intel.com>
> Sent: Wednesday, February 26, 2025 6:40 PM
>
> Allocating a domain with a fault ID indicates that the domain is faultabl=
e.
> However, there is a gap for the nested parent domain to support PRI. Some
> hardware lacks the capability to distinguish whether PRI occurs at stage =
1
> or stage 2. This limitation may require software-based page table walking
> to resolve. Since no in-tree IOMMU driver currently supports this
> functionality, it is disallowed. For more details, refer to the related
> discussion at [1].
>
> [1] https://lore.kernel.org/linux-iommu/bd1655c6-8b2f-4cfa-adb1-
> badc00d01811@intel.com/
>
> Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
