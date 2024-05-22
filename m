Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F7C2233A
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 07:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716362193; cv=fail; b=tDQmKhJs0FO9QAw1Tva//g5lS3oWMH7+p40N4w/ez5tgRZQXVpOa0FynEbz5TSCiVxti/STebFTpRB8wrJH6X9H+cgYQh3dGygLdLm4pk4G1SAmddRg8IySPl8+6ksN0K0Mbt8RPf1fD1GYw6wTWSS6FvxoVoJnrjK4LfYNunXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716362193; c=relaxed/simple;
	bh=XppeeIo9mNtQCnfxDNK9IKaXzEPOlOuTObRjfSshQAU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oS76pxKx39J0jWonnycawG9PBcgYQ1ZJsEtgdtR1hD8dC2oEq3Q9CUBG961qyRIFOWl1EjpXcHFSfdtgKB3G1z7wVF4B7hXaKf0xarQ7GfX81lpw26LB8LUGME1SuHJIbhS6mHT+dLWy2nbUu4+PuwEceSyoEc7bSecdL+gdAmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V1PCiTet; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V1PCiTet"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716362191; x=1747898191;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XppeeIo9mNtQCnfxDNK9IKaXzEPOlOuTObRjfSshQAU=;
  b=V1PCiTetKP7qPdvsqIVw1wdA1bc+rTBfBylqx6VlfPhqMXyUxNmXV+Rz
   R0CwHQjJJlh7k6D/t6BCK9xHiRHFFKUAj9+pPS+Eh3SvkDgrXyV/8m2/0
   7+NPh4kpfth3VxxbSToK1sAaAtRJ6r/2vV82UGXKSXKf0C5JnCneeu5Bj
   6TvG3bb2XPxPQ0otPqKvTWMjNPFcVHXTmqLrvmMsqX8G0rH2Dmx9ZkA+v
   XqIT0ZBiYylr/y3fe7TaYZuAK4cVD9GjmlP51xApoaPfT/l+XgaOcSHyE
   J+Yo7TQmp63mozuu5nrkIBIQ8xzeeUAKvMGqWR6ZVJPDcHDJVZ9K40J/g
   A==;
X-CSE-ConnectionGUID: befn6HkET+G0YaDtXub/yg==
X-CSE-MsgGUID: +SlnLz2JSz6DxMHVbkVtqw==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12466213"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="12466213"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 00:16:29 -0700
X-CSE-ConnectionGUID: bQiYIzj2SXebHxJVSKNP8A==
X-CSE-MsgGUID: D4WUFsz0RNGoWe3dnH6bUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="37584760"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 00:16:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 00:16:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 00:16:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 00:16:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4VD0uqQhLaVs/Fc9/PtYx9ADm7hFFaUwgAIFWOr2T8jhxPp06X8LV9k4r3mihgu4TFmIwVZD5IiPYQNLTwD80XjKlw9EIZsQkQ2eheiVvUj6ogPxm/mhHFvj/EGGtV3vbccUmwFRllIRo00REriUED8myQNwuRoPr4aAtn6YB52znXHDbFfL/C4w6bDQGnDAO08ZU8HpULqhVuWDeoxyzKYCj43Jbxt6A4SnYZVY/QwSMg6XnfIcqA6tzjzZ/fbmOAlwxXXea103kJN1fA3MAkx55+qfPu1QV35UxJTN7BtBY+GEbLMlj2yPJWKvZ1gVsAeUAzSBB/uBboK2kI2Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UH/ql+OnjTzvb49ySISXSorG3aMUn/DyaSyMxGm4kXQ=;
 b=QEMJ4taGKy/xB8SAijk7mdRhX3K9H/zC5wXx8pugsds+F3lMj8iSArNkfyCqLZ/jNUzqeqR2Lw+uwiYzSZu1j9aNmwFRDMsI/0GGXDElQBGfvQpU8KWqQ+A7jRBrjITrXLeXP6Qj8gFkjjpJuO2kBBgAgXIH+HuuvORBhP2EAQiwvIxDXhKcAZGQqFpr8C39giCIef7QgWleModDSRqdRqnLhMm4odhcWpJBidjJmdWaFixtWipDAhjko0gCWj5mZb6jd4rvE0xelLAGxPXnHjplaDWp+cfde+fzq3UeXWfvTvyqHB05C4aMjhdcQJTBVyn2ZAbZy+ZR6Kb4stdo0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5981.namprd11.prod.outlook.com (2603:10b6:510:1e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 22 May
 2024 07:16:27 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 07:16:27 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "will@kernel.org"
	<will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "mshavit@google.com"
	<mshavit@google.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, "zhukeqian1@huawei.com"
	<zhukeqian1@huawei.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: RE: [PATCH v3 3/4] iommu/arm-smmu-v3: Add support for dirty tracking
 in domain alloc
Thread-Topic: [PATCH v3 3/4] iommu/arm-smmu-v3: Add support for dirty tracking
 in domain alloc
Thread-Index: AQHamwTEg+Pdwp5qm0CVG/YUDoVRsrGi+Pcw
Date: Wed, 22 May 2024 07:16:27 +0000
Message-ID: <BN9PR11MB52765EF502C246B4C344CE888CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
 <20240430134308.1604-4-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20240430134308.1604-4-shameerali.kolothum.thodi@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5981:EE_
x-ms-office365-filtering-correlation-id: 43a80ca2-2ff0-4578-55df-08dc7a2f1873
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?ravgbrpT+ewYXhOJDfMwNcNNQdmteG2jOk7UkT1QVQPs2aK+DQTxZ8houm30?=
 =?us-ascii?Q?TvCaoHfXx4x/fZ2S0bRdgiZz74oOP5iRa+MqU0WvuxxVprjqPmjtkZuC4RzH?=
 =?us-ascii?Q?V8wxug3eh78/6xmjSdOSPO9btWD0JT4nOXeesz5XjMjuRdIEWc9jrGFxKiVV?=
 =?us-ascii?Q?jq6oUo5PlUXYDSG+WDw9Ql5LaMPLrt0dHCchWLktle9rWDY3F/kbw8FV2A/2?=
 =?us-ascii?Q?L6UiGlrVGWBr3I6nyLeHJ1eKPBWn7hDpJcX27pd6e0ooc4SUGKvAviXVhqX+?=
 =?us-ascii?Q?LEZSR6yOe/jytj4/yfk2dFmFQtd+GRj9SykuUpw4C9be2US8dL6i/SNIU0wQ?=
 =?us-ascii?Q?hR2lVSW6NbnDWNXsFNBJnfGWuE3iUlp7O9ln9fKrniT451LfoTX08UchUHTU?=
 =?us-ascii?Q?RUGeTfGx5oX12J+Cg0FnAiZVd31UAEWMPBri2wGfTPqjG/itXcjTOZ4B+UMw?=
 =?us-ascii?Q?8EnGSPLGp2GpOrvMHMSWAuzTr29ksfdIK4nnkdy3W9o4Is+hqmleTEtc5VuT?=
 =?us-ascii?Q?ayAZVa+2nKWDZljf9sWZiXD2evadSMZDxWbxfZLbYKFWptBi03Fasx03lohu?=
 =?us-ascii?Q?HLCy//Xq9xyyF4U1thBVN0xtWfHPHYf4z0EP6h6HScoL4EyY62fH2ir8td11?=
 =?us-ascii?Q?SaHDgf8P6OXr42h+7ovmMed4VSYSDKe0TpBqciz5XKpzEH+oNh6kPHbUe6eI?=
 =?us-ascii?Q?m0IG1YtCQJ1V94xsNyWLX32e3Yt7DF+02VOi5Z9L325bvA/gUgo0/YxyMZTF?=
 =?us-ascii?Q?pWeRt09J6Hub/qIXBrFrWRalpBRqzd5T9SopzEglL4EyBuXfdk9snxyNXiz2?=
 =?us-ascii?Q?hkCNZdrTrv6CbSHktBGMR3u9os5gOE2joQWe756fPL/5adEoNm2XCACPDDNj?=
 =?us-ascii?Q?aw/IdZqLJTVYi1cQR8zMTgeNcgJcU0dlTNiJCzX3OgHB7bQfPco444nQ9H3t?=
 =?us-ascii?Q?R7xGczwbWpgcrEsgBL6KiHr/IL7l8SvHu+bRFaMdtKkUnMNOJHqEoOJ/CubY?=
 =?us-ascii?Q?wFyG1bccG6uiBXtjEHVVBniVT4ihr9ECRrE9KKy1YhHwmQzAJKax/XLAqOoh?=
 =?us-ascii?Q?fX1dNQsMBMuWQu2LfbL+xxzTFzabpjKV489N1wm5su8OBOEcXXEmhpxSnRRQ?=
 =?us-ascii?Q?0DIHecphFsllE7Z7/PRVYsAbTqor0PjwgEwFO+o5xDIVmzvtlJq+zm5VlTkY?=
 =?us-ascii?Q?zDIFBxVXwvDyF7b6lGK4OHuPCD45RSeE0alSSfoPdda8TcNQzqGhLjfAFmvG?=
 =?us-ascii?Q?6G+TxjzNmkkl36IOTybUwfgHvfzdqBWlxR3XXo0xmiv+8UfIGJf/WsBGqVwM?=
 =?us-ascii?Q?k6kVa+l0d20B+AJPwIe7WR+x/ZCp7nG8UiS37bA2Tk53uA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HUEE7Y/5n+3Ev5CQ/7vMOe7SFu0vvkQSRXa4bHJ3PcEniHSPa/rR23RWGpoV?=
 =?us-ascii?Q?Po+tqsv0cWeBuuDXljTTP0BbD+pHAp4JbyiDSyvbScLE4apOvmwRsHMSt+dT?=
 =?us-ascii?Q?fsJf7X1+v8F5dUnEgyvExcrvM0DhYwKO4GhPSPnOKsYZf/WwOa3qq2ofsVKF?=
 =?us-ascii?Q?Oix+AkJhNsB52MQXUsLlB9xh/FUyQaSp2F62JAsbwhB3NTe0uGAXpuXwvJtS?=
 =?us-ascii?Q?N1DagKHRy49b3DqvmS7AEIg3v/2yR4fOxVCBXppysVuSSiGRzXdta0QO8hpf?=
 =?us-ascii?Q?BLtBtdkE+Dta7DszT81Ey6/FWIjSznFRJzJiim5Zo6FDeO9xszKxFlRUBg+g?=
 =?us-ascii?Q?vOc+5L4MYS4yb5tLFGuKoLO9EbVjsR+89PdhkHlq8HoFjpFWwDJ0AEP6VK96?=
 =?us-ascii?Q?th226513cihOKft+WbiJcTc4MCX/kSc9WHeGJlLYjcnwZlblkr/LN2QH33Da?=
 =?us-ascii?Q?M69opFumdBh5mn25+mneegk6ZHAQVOrpUnN/LTBZIvduH9Da0mzj6bwaXfVY?=
 =?us-ascii?Q?Q/lb/0fPbv1av/GhSso8elZXk4oNDbrDGXBx/VFjBzMT81ng41dJk1K6/Cc0?=
 =?us-ascii?Q?4M4PEaKjkZIYTIrDS0RKBIMB2Krjw31W+6WC0OarQLDbNvYnv/4YmUdJXLLd?=
 =?us-ascii?Q?nkfqg50g9AxGh0/7/npu23d1VrVWxNUzRAdI//FUmZyOIOjV0o9/Dzgzx9pp?=
 =?us-ascii?Q?Il4mROuYk9mMAqBkaCwV0fewnWq/7nchhdqFfm+GEDD363B3gvSaixn9QogJ?=
 =?us-ascii?Q?EIYJuQlxMqs9/owl4hRTiDGbgSJk+DFIVM4rTClcneA98YUqS2h7ZZoILs1q?=
 =?us-ascii?Q?yK9/5wSieaFD1iaPQQLi/EMOSKeHmb4ayS6TcXZWUgzVCC3RJiIW3KiWqyoA?=
 =?us-ascii?Q?tctnxj442euDQD6yMXKn8DIwBxX0/tpnP3KinwigtBmKe6ie5on6xT9J9tVS?=
 =?us-ascii?Q?93om1Hp1U3/h0QGE6X75PpZDjNTnKWJMozOYf6dt7WFbnCR8RJ8eznYuhQIz?=
 =?us-ascii?Q?MMCfos1LoReKSvxr3fRvWDHXHkNI/CzDKc78s6CSsnuCX7NwIg4wMRhlsBEU?=
 =?us-ascii?Q?bdT9qNGRWI8fDFnLTlKQabXV0K1d1FFT/HyA5z4txAgD/Y9MGT1JRShcaw1o?=
 =?us-ascii?Q?7BBacNxmpmhb+j+kwTxS3HHQTlE05JIRE6j1uN/D/fW30kTKOliW1QiQd9OW?=
 =?us-ascii?Q?aLQsPYRmU7zpJRpt0mzqKGhr3aUUGoTTNctba4Lt0AOsrML2tVxDFVuUhNrL?=
 =?us-ascii?Q?HsAbD+XZTBeZgoWDLKOU9+xX0kBcQA8FwkPrcwzqNiQwpKq3IjyE0xux+c2P?=
 =?us-ascii?Q?orXSau3E79r5Tw16inJRxpItFeBPK2B96gqjvpF/oslJfK9q0xpkExULshEV?=
 =?us-ascii?Q?ypt5HHclavwth8JCEOAk7JGrwWu4UeYGyLkHSjG3UL7wBhh/X4ZtifZcag2H?=
 =?us-ascii?Q?cSz7f5nUpRNdNHp1LsIwhFFJgLkiSav504S42BklovJSMrAJBsNTyxMQKSq/?=
 =?us-ascii?Q?DTUvoqbONW5Kl0lNvJyNLYeqhDMAG2ADIRR++dRm5ZcqIZALSCNF0BCuRDGm?=
 =?us-ascii?Q?KI5c2FdyJAHS+V5hXZB9mGNF9+uhnwkukffRMPDH?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a80ca2-2ff0-4578-55df-08dc7a2f1873
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 07:16:27.1447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IuMO7LNTmOTZo+w0I0j4qZ5fy+eVgxmzk3ldZtz+44FKeuKlfJoxKKa1/APAOF+82Kd2jOIs6Qgs+PdWhE/kwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5981
X-OriginatorOrg: intel.com

> From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Sent: Tuesday, April 30, 2024 9:43 PM
>=20
> @@ -2422,31 +2425,32 @@ static int arm_smmu_domain_finalise(struct
> arm_smmu_domain *smmu_domain,
>  	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S2))
>  		smmu_domain->stage =3D ARM_SMMU_DOMAIN_S1;
>=20
> +	pgtbl_cfg =3D (struct io_pgtable_cfg) {
> +		.pgsize_bitmap	=3D smmu->pgsize_bitmap,
> +		.coherent_walk	=3D smmu->features &
> ARM_SMMU_FEAT_COHERENCY,
> +		.tlb		=3D &arm_smmu_flush_ops,
> +		.iommu_dev	=3D smmu->dev,
> +	};
> +
>  	switch (smmu_domain->stage) {
>  	case ARM_SMMU_DOMAIN_S1:
> -		ias =3D (smmu->features & ARM_SMMU_FEAT_VAX) ? 52 : 48;
> -		ias =3D min_t(unsigned long, ias, VA_BITS);
> -		oas =3D smmu->ias;
> +		unsigned long ias =3D (smmu->features &
> +				     ARM_SMMU_FEAT_VAX) ? 52 : 48;
> +		pgtbl_cfg.ias =3D min_t(unsigned long, ias, VA_BITS);
> +		pgtbl_cfg.oas =3D smmu->ias;
> +		if (enable_dirty)
> +			pgtbl_cfg.quirks |=3D IO_PGTABLE_QUIRK_ARM_HD;

why is dirty tracking considered as a quirk?

>  		fmt =3D ARM_64_LPAE_S1;
>  		break;
>  	case ARM_SMMU_DOMAIN_S2:
> -		ias =3D smmu->ias;
> -		oas =3D smmu->oas;
> +		pgtbl_cfg.ias =3D smmu->ias;
> +		pgtbl_cfg.oas =3D smmu->oas;
>  		fmt =3D ARM_64_LPAE_S2;
>  		break;

so dirty-tracking is not supported by s2? what about nesting?

if this is desired then attempting to set dirty_tracking on a s2 domain
should be rejected with an error.
