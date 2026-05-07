Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E5D346FBC
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141726; cv=fail; b=DSQujD9HZMjekU+Xesi45DuPgr/cmv/Eap3cpGNN0QyoprRHZtEYDAfq4DhBDqJJhuRCFtD+g+cdv+XszIfGw161Qk+pa4hr8ESxPkEWxxtMXD0VZl0V1YBuRfigzC0rxyzqyiMtr60buSKwwwzihLjeyjjWK7OKAEjms9AFrw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141726; c=relaxed/simple;
	bh=Hs2l0+rYcQ6xCrHZ925yzOVmlnCGgA8lEGk1WHb+PFI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tiVbHa4L8O7akl638DwPpYwWR5EmbTB3Dj17MJUTu/8yhrtY4lm6hb3JlV+5wCYWT4XnRpxdkhlOLxC8sUVroSD9hJbNpM2eXWC2H5gCMH5HUuCfBiWIl/ZZDKKNLlW4FGnNP+Z7H0wzcW1eP1etuzPDsSd0iF4swxlpb2yESNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hyTaKudV; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hyTaKudV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778141725; x=1809677725;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hs2l0+rYcQ6xCrHZ925yzOVmlnCGgA8lEGk1WHb+PFI=;
  b=hyTaKudVdZozuBOLesSZRH7DelgnlylYL0+5JDnfs7fJ2fd2/V2MsZZ7
   hqoxDY1ml20X2TZF15Sy382N4aqpD12Q0P/jBNnoSYfk39dXXQityNmx9
   +Q+WA9HLii0t5GYOI+k81tMRUQDwNrebvgT1vUG9NuPYRus5XzGuOgsfh
   gFu09s9elGH6jlAaXAMAVRX1uB4cD0jsyQZP8BAYOdfBpWQnGc58EcpVX
   6GJ/7ihTSwNk9lLCdUyj7dI5S+ixEOEt9N2hQ+ujZ4qrDEDOKe8tnOoZT
   ndVliUXuZgZf9bif/rFs9C5ycVJSWP5HKEKrgoHtF2itIze+R8sSVzeWM
   g==;
X-CSE-ConnectionGUID: YjQ9Z3WHRBW6m7Bw/hupoQ==
X-CSE-MsgGUID: fLe5aBtAQQ6Qf0KzwXew/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="82709319"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="82709319"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 01:15:25 -0700
X-CSE-ConnectionGUID: CnCg71j0SqGM4fH0j9Yojw==
X-CSE-MsgGUID: hW7mK+DvRMW1gKZEtMEKiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="240726207"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 01:15:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 01:15:24 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 01:15:24 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.20) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 01:15:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CeFcXn5yprxXYPfiMz/QXt2JJlwxiUyX7Anmkj+wncLdCi/L1slRvhuK11gIvyrfmxbA8jFLXuZb4JrrTEjFLB10k/1UurPBE9s5lxAYqqnMJqW8aoh53ZBHQrHmBpf4igapx52vvrYGDcrDjWh4rczZMHKAcG2KNrJ4OUgefK3DLbmbXCH0c4N3kvgzYSyedoJ/gfqr/a6slnMJRWfxc13WCU+8KEmBzDcuyW3MrL7AtLnZpMXu1Qtcbix+iLDxm8RsexD3UaK40QIMjps69jQNVH5HNsuwFptr0Jm9sZ/VHhfwRnQOcB/xtmVZgZvL6r/8xKcwUFmGF56EMHlbZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCCJ3WD0XRJefs6CFtktA21OMHhNfXgeFUFwVL5AjPk=;
 b=PVZtyRpNkCagSrpI4nvdb5Zlti/zWqRwgq/AFgwhQlRxVTEch9oevXVCoeiuV2wn9lEELlkD+tTUNkunsynfOH1uHnT9X69nXkoRrizEjYgLz7iF57zP7nqRhOlGXbwPPnRPBfsGmgibGLP5AW76WfzJuDrVpYKddobo+9ArD8B24zM1vSmJ/NoCkPphqOrrzDjcSpTIfMr/cDR1Snzl2yeAiwRbrrLiT860CJGCKKBfeQNIOTV5MRvk+9+wKr745UES1bTCdopgctjzSQMBpA0zIc+zKB9Gb/NWDjEC7Svj5Je4tjuS/Y3qEIl9+Mp1SFtfvmxqUeQultj7aKhLrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB6894.namprd11.prod.outlook.com (2603:10b6:806:2b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 7 May
 2026 08:15:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9891.017; Thu, 7 May 2026
 08:15:21 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Joonwon Kang <joonwonkang@google.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, "jpb@kernel.org"
	<jpb@kernel.org>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"praan@google.com" <praan@google.com>, "kees@kernel.org" <kees@kernel.org>,
	"amhetre@nvidia.com" <amhetre@nvidia.com>, "Alexander.Grest@microsoft.com"
	<Alexander.Grest@microsoft.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "smostafa@google.com" <smostafa@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC] iommu: Enable per-device SSID space for SVA
Thread-Topic: [PATCH RFC] iommu: Enable per-device SSID space for SVA
Thread-Index: AQHc08flq+VZwzTmIU+htlLOaFupobXuOBmAgBQSqNA=
Date: Thu, 7 May 2026 08:15:21 +0000
Message-ID: <BN9PR11MB5276E9D968D3738CCE7125248C3C2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260424085339.3503582-1-joonwonkang@google.com>
 <20260424133953.GY3611611@ziepe.ca>
In-Reply-To: <20260424133953.GY3611611@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB6894:EE_
x-ms-office365-filtering-correlation-id: 7ebed20b-1de4-4329-a2d5-08deac10c844
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|3023799003|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: UKLg4l3tMWbkLg5OpVHTsRk0vt65/S8q5h3BFShaNU86jNExlGcdbPWFhnbgwHReV+zkAJfvvoOEqNygE7lnAXd/4PXn4pfM0sKYYBu5fNWX56+iMbmuONlwCXkL261RZrGzYm06XAa1ojaK1Y3qoeLcAjGcKB3kHFiwNy7RH9Yedx2Qk4plyF8pXybZBKZ4sMUm4kC0Q/KnsAgCV09DBms0hQiMS+pGaTRDeeuk5fSzdXrE0srKNSRYQSqs1lqA/+YKYf6IyXaoDJzkVCj++k2acUmwGMgcI/SscDTtXIk+AzD6uIbfln8k9Tmd/tFnufAtGqnEdq9I2VQeRfDioRXecVa0sy3i8TDbdAxYMV9E2m/t7UGU9OAP9bqqWu3P8c69XjpqgMlsAxBBDcHmaeO3xJh5dYfV6NA724eNNAya8SpJ7jYgxfGbBsK8iGrJdoP2jIAqWN3tPSxm7xBiiZw9yN5zrSTjV/adr8MCZuHK1AK472C0kTQYTbN1WUIWaDcBrIB/GergN/zwTHj7hnO364fdAgftQIoieVMraor/oteJKNGhnw0qSOh61hggXwoH6wy/6wWcejlmFlaTwatah5Q0gvf0vTTpMJ2kmytmTC8dKyuDw2CO7x/R+/ITPIJC/28Wpx7VTbri5eC64bgLNWe+k1AViM1CEZ+Xa2+FUKlF1eEc/CSDgmLDyAY3FivnSyLrzCxzLKiLHDWGKFPFqgBtp9/8cV/8rzRrTWzBp9z6bA39Wftp5pgSUprZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(3023799003)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IdRXpshFp2kuHFlzn0WQu8Gjaap4VrRYIdXkY/5dEcBRsJjgq6BAq0fErOZd?=
 =?us-ascii?Q?7yazPKCcrWP5zuj6rnSmNXJQTxPEUzsDN4yUC3fm6Hl5+OVHHWRrg9AUT6ah?=
 =?us-ascii?Q?ZguchFolu3ZP2R+5aDw7tgjEmwr+IouD57dj1Y9FekEw8Jz67iEqcBRmxIo+?=
 =?us-ascii?Q?cbLZQMJVjxiRZEtRzmgeNAgSd2NgJo3Nt8qQ8W/f00I7vpk0Ikbiji5hA3r8?=
 =?us-ascii?Q?VMW5mgCrMFngtzxBV4aadotRmsify4iZqBsDqtwa96DXydKT5/MYq+QwBTOG?=
 =?us-ascii?Q?87sYTloHIhAui5EJrCw2ami1zmg681q3kRT91mbZ6y/J6/rflocgHYNMgNjS?=
 =?us-ascii?Q?q0oCows/6rGW8IqaM74+pVYuoltOq9zYRmZqa1P5MUleYA9eoZNivyOiRvG2?=
 =?us-ascii?Q?RoPsxXvhSKXvIaXYzBn6mw1+ivxDRNE8QhtNMvKyWrlgYr+ApeGqZM0/iln8?=
 =?us-ascii?Q?reblMRPt7S3tGiaF9lqUv7lsox4z2OYEWDmY+fCDeuNcnvksZCg83ThNxAtH?=
 =?us-ascii?Q?KtA6Wbno2vUc92eUmimzoFfbU6rmzrXy42w0a//RbGXHvYhIHBm6MKRoGmd5?=
 =?us-ascii?Q?C9lLw+MV9ORcTcm1Om0Wuxzrq3Jha4TyCgBGymf68fICZfyWwErVtvmvylNI?=
 =?us-ascii?Q?+aMkM4zpoNmmoH+kiX5Hqp7O2JvOXpdSzUilHoniR92eE0BCEI2C3Zqt0wuc?=
 =?us-ascii?Q?SqGtaihJucVRf/P8wMcsjjnIj4/VuxgMRKiEPBRAKAKnRkh1Trf6Buqnimhu?=
 =?us-ascii?Q?2ZBy1lGB7ZgexXPhNhnDGLECVM/AbPZ9Uqac+ZnetLje1t2bGWQHUDbWBxWN?=
 =?us-ascii?Q?3WDMqcVTU82YlS88H71cPNf8S0XpG4pOPpSI/0gIzQevownUKhVbX3N8W1lL?=
 =?us-ascii?Q?A5rQYsZU5rVjAzpZDMxr/kQVybwQVSlgiw4PpyriTfgjimSCvURTz3m6l+F8?=
 =?us-ascii?Q?OU3I9WXep3NGALb7HnujOCKY/i/WqOJfFNOLd/0cyqie2J7saiei2X1BJI7g?=
 =?us-ascii?Q?qp31LfNMg7Qd7chsdjqvNNIygN6aJ94MauqILjeMiVhCXKYqcO+v42t4XP54?=
 =?us-ascii?Q?V31T/3STwTXeQPeIUdEJ58HVWtCXGVrkdqeV2s+Qq3jnfd36dppOmSzwzJDm?=
 =?us-ascii?Q?QMUVYh6L66qmR13wc2mIf0iRbkr1gFcwRo+35wdqFoe0KuGrAz5UwxNFd0c3?=
 =?us-ascii?Q?1t5gQS+Rb2iqutOrx4LNwaa2gcMSSP9MHYVh3YmSGWtz1/S0x46GqLMsw+hw?=
 =?us-ascii?Q?HAXsBZgczK5sv+XKkhVP8Hk9oVYYqqf0efn/0ItjRdS3XaN2Y/9IjOiE4IJr?=
 =?us-ascii?Q?U776+Urhse2vs1C2q6ZD6MY/R5Rh2nFeLH+tlzquoUPp6DNoKqVeNbbvfhiG?=
 =?us-ascii?Q?RrlAFaOGk4t6ftaoBKqdVEq3BFj0fslYNzPBNg0E/eGbg8nlTaAyNEFgDPU9?=
 =?us-ascii?Q?jBN5+q0FnUiH32lpfolCwv0s/vdehF7J+6oz36ZK0r2LrPisQay/n+6a1fcC?=
 =?us-ascii?Q?jUmAYVI+VTWa1xxzjmmhWXKp+AVnKNL5vWAHp8UiOjxdp1aXE6dF+ibS5F5h?=
 =?us-ascii?Q?nw2Q6liNjHubqutU2mga6CQzI86OQCv790REek9puI6GESL0xu7Ic4mkOztJ?=
 =?us-ascii?Q?o7pxq+7o+KfteIvgcHKD5PPDifsSW9rsjKRluqACb5WQt/KrEYMt0vfm71/l?=
 =?us-ascii?Q?pJMzZ1UUfa/whzN7zFS9Vb6d1a0r9mNW5oilAzAdPWgjHzUDVsaCw3dzwSNY?=
 =?us-ascii?Q?gEyn3Np/Jg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NTtYruKHDYfZn/q3X1eEA1GKPLl63iC64JBoGWkc/JMWdvUL3UJX9I6qJba/yVzuUwlMZXrInEOyG1WqR75u35sfKAhj7huAXvOkkNmQ9tvlekANzrana5wMIJuV6vg/iTfHw6YHGOZp5g4kwSesk3ZfQOoDNk0eWn5d7uLIhAvczdQPQqLrwFxX/pYCj8G/L2hU0i1tB5BkXTnkPaf2m+fLzQWZuAppjuK0ip05aqf1zIbrWyOWHEeF6URdaouHhmvJNn3r0pO8D/ecKqFyW5W/gBlfebNW+/4aoy6xCO3bSL2G2fNFwVB0/h1MDvwGfDhGAII2a5N3naLrEVhrmw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ebed20b-1de4-4329-a2d5-08deac10c844
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 08:15:21.2484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3lSYdtZwyHwOlrTXE5+FVh9YUTWaehDQJMqMLE11++TqJ+on0qxkP9yLX9nSx705YUOm0HXl1k811nsgd6H25Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6894
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Friday, April 24, 2026 9:40 PM
>=20
> On Fri, Apr 24, 2026 at 08:53:39AM +0000, Joonwon Kang wrote:
> > For SVA, the IOMMU core always allocates PASID from the global PASID
> > space. The use of this global PASID space comes from the limitation of
> > the ENQCMD instruction in Intel CPUs that it fetches its PASID operand
> > from IA32_PASID, which is per-task.
>=20
> That's right, and all the iommu drivers should have no issue with
> per-device pasid or they are not following the API contract..  I
> believe that has been taking care of already.
>=20
> So, I don't think this is an iommu driver capability.
>=20
> Instead, you have to decide if the PASID is per device or not based on
> if the system will use ENQCMD or any similar instruction.  I
> understand ARM has introduced a similar instruction.
>=20
> So you may be better off with some kind of 'arch has enqcmd like
> instruction' to control this instead of involving the iommu driver.
>=20

if both arch and device support enqcmd-like insn...

I recalled this was discussed years ago. For devices like this, just
let driver manage its own pasid space then have a new interface
e.g. iommu_sva_bind_device_pasid(dev, mm, pasid) to use the
specified pasid.
