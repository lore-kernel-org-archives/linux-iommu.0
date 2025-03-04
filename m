Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D5D1F7911
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 07:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074138; cv=fail; b=pAyRkXDZMwmfpfu87vibRVdd12JgN08P+vycMoXHeIbPSX7HxRL+ZLt+4Znx9Mis7GoW1MPaHx+u4kWdxNImPRJnbKUFdjDZACXfH+WVG1ZeU4eFgt7gGCquy0KvXEz+r/FW/4VuqqzRuUTpDJQrlK/IEe+lqpvr9fboKEN1y6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074138; c=relaxed/simple;
	bh=FPJKtmx6A1x1twaRqhVWduiquBgNtKioz3qX6iPDu9Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=chh5wHfOQ0leXaJe9wSD9IhjOyur7YRt7HpNyL/S8WDeAUaJxi6Eqv90QJb6yZwvjwy5ofEdknspN/VgsoyuiemQ3JUSR22ta3F0eupeUuviSxfciFKkTzwy8JQWIXtXx4G61p2rAh+cBXUy90zxvTxT2T847TikBFVrM7rYY88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UsJ4SJNf; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UsJ4SJNf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741074137; x=1772610137;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FPJKtmx6A1x1twaRqhVWduiquBgNtKioz3qX6iPDu9Y=;
  b=UsJ4SJNfeHDW8ZvLcJjgzYUK0a9d0rrU2TJ+EuXyMAnU4hAidRkDjF1d
   BsqgNaBlsAIDcGo7l0EMjf0K475SHDWz+yJcqKtPcmlPm7y3GX27J46uK
   Q4vEdekMqRwV8uSjgbcR/0+pddI74CDRBeLtsZsykfUrjXTzSBqK9/oOm
   6lMmmM9Fg6sI88pcnzlQrXVgbzVje1yiw8a6yYGfuUfJd4SceYgPw+BFf
   qgeTbFmB54HUcF3s87Z3GuGGsrNTVVgcKYgfMfG6dbKFz9/1ocM0CbJf/
   /BAOhVPmgoMDZfncKSzu8NX7prS76U/D5L+5zoUaiVuVBeroxPTdoP1ST
   w==;
X-CSE-ConnectionGUID: nf9mw9JwQPGhsF+rgGRC6w==
X-CSE-MsgGUID: fY+gvMB+Qz60fPImQMdUog==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="59391017"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="59391017"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:42:16 -0800
X-CSE-ConnectionGUID: hivewcGqTGymbcTtKjJpUA==
X-CSE-MsgGUID: tv6bU6/fRnGiAwzoHyKH4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="123414481"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Mar 2025 23:42:15 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 3 Mar 2025 23:42:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 23:42:14 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 23:42:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGod1GC2QyUUnpKRrHwxgF0IxmVvQHVI6Y5fkmEs7lxmo/RbQ0lEREe2Zxei1x7xAWbqAO4n3K9sVuYjObZxbrLb+MNyNBopytbljAGdkJiiBUCuzXqbGLwB3vOqkLxtkkM2gc6UknWuW/G7viL7opa8pzakB1vPrsQKnnB7Rgux9nuM361bbblD9/J7i+/7l32/XDPzB3QKT/wKS4s4OA+n97H9t8qqvsb3a7dl5412QDdNADbBpS72sJZ1dGwAR2GNPphIhFxITEDFKALeAvXNnDmSVUSBnPNDcPyEFoBmF9WFOWmTNAeIA3j0n1CKji3aGJdDuIEHWk4vy5syTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6yDTZguQLVzsS26p8eUl7jboElzp3gE+PMQZdFstG8=;
 b=XaqbvzE/j0+tYK/Omg9gL+rKUqzx+qiWqQ/NkCv/llLLwiQRPiWAsCCg8TNiS6pVxJMN9oMtCc2LpWN6c0Rfh0/j2DLaPCc5gMe0KV5QHL6uEZXDOa9IcDq/qdC9xUCbkRSkcqYcQL9I/0HVEj7TcgTwShKAc2D6DyrxGIZO1ErRLPsEAOHS7Y7OQQWrhf2Z7TSn6NUA9xFcD22mEj6k4eCYJbHz4rfuQHKXwjRXzGzaRmI1B7Ty6lZzFpk08IgS/0VZjOjxLBXg6XcSGFfIWjDIqFe/GGOkctCU/vXcDC1S7vmAIUyAqhUaLRf29Pb78YR8TF1zvABM6+Y4amB6ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by MW3PR11MB4618.namprd11.prod.outlook.com (2603:10b6:303:5f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 07:42:12 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%4]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 07:42:11 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>
Subject: RE: [PATCH v8 02/12] iommu: Introduce a replace API for device pasid
Thread-Topic: [PATCH v8 02/12] iommu: Introduce a replace API for device pasid
Thread-Index: AQHbiENI0uKMj4a/aUCaCEmKzzgKvrNinyxQ
Date: Tue, 4 Mar 2025 07:42:11 +0000
Message-ID: <BL1PR11MB52717ECA943E3A2D5D1FB6E58CC82@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-3-yi.l.liu@intel.com>
In-Reply-To: <20250226114032.4591-3-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|MW3PR11MB4618:EE_
x-ms-office365-filtering-correlation-id: f9500f5d-a603-463d-2a43-08dd5af01336
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?KT5lngB1gOCWN+t7HtoXAoLGV3Mo7j/JWn2Vm8vVaG+w/e+y3QPiniSLAvjG?=
 =?us-ascii?Q?h0LYLl/YuzdE1Ngl4uPyzMaW7tRxlPiu90K80bHqomsQ4C8Fp4/6A2GvugMz?=
 =?us-ascii?Q?6alUKyN1N9BAMGu0/I6p2RdMjmvhY3MofcxHFX6zqh9XJdi9HTfuGw084A4+?=
 =?us-ascii?Q?QPgxgpnM3FX7h/04kipt5DIpGnPTcIIgj5crYWpkD7iQy7ZmGNTotK7eY/gD?=
 =?us-ascii?Q?KtGWvHBJRUcJJGbGN7LABMWkfc2N+hQwZzJuJw8doGYCGF1CjEofZh8EqUNL?=
 =?us-ascii?Q?KZEzZ7qduyb6FUTrpH78qJBmeGOTM88URj+9dNY3Ztm5Wvv1v0ZT6JyHzFkQ?=
 =?us-ascii?Q?5aD7y0Gwh0gnNqf/krSsxmfjkZ/PNYijX6MjCpuVxEOUcIyo4DySgkWBqFvN?=
 =?us-ascii?Q?KdFH01pQ4GWQnHvee7EGyyPJEsCG+jCEX0Fc6k1Lr2fINk0xZuOq16XJN0fp?=
 =?us-ascii?Q?Egb/KuApZ2ppT+1pOEGL6w7B4xsmjXOVyTMqNVUp+bNK/Fbx2pQCb630zgPO?=
 =?us-ascii?Q?isdjec+nn+115OfpkiIAWa/Uk2Cr2/nGn6zEJvG/xb+OPmxHDxVChgUaZYKl?=
 =?us-ascii?Q?kfzxwcroqiFg2Mx77uuX/21vInMw0tuBxG8My2nSLbuoLGT09vXmm+pwb4Jg?=
 =?us-ascii?Q?MYocdmIuAeuBJrWQYSCcbFr1RELMywyZbga9t5POZlQ3+i5uCbCqrkrKb2ZN?=
 =?us-ascii?Q?nnajQOkaL42Nf/78ZSvE0C5iSo2q+1cjlUuMImg+TYye5p48dws2904MICfX?=
 =?us-ascii?Q?/akhJ0pZTWtZwFkpa44HuQP9JTimuzCJi0ExENTtxwcTnGwT7xAnzRvERLRV?=
 =?us-ascii?Q?pzMSrKJZdNL4UHMUUEtlmRhQfDZ55m8Ivq/g7g/ObsRh7rKZ2yUw3LLSgefn?=
 =?us-ascii?Q?ypHA7HfSZ2G0/9l+GYRX2QsJxXWVhERcEr85TPCrG1kbtRj2XsoyzoxW75Kk?=
 =?us-ascii?Q?cvL7igVAFClEtBegF1nt7Z7nzUJzPcPTomsvdz+XPHCLgOlf3lYAOT75utzq?=
 =?us-ascii?Q?GmflgDVjH9JMKzKK1jOg6kw4R8cRX2NgFCSOAPRruV8aT+k3BBBu+LAwlxji?=
 =?us-ascii?Q?VybiGVC/exhtNUh0aYXoCXtV40f5rKpX2PqB/pR+9PM/9585KV4kZRDdqfQZ?=
 =?us-ascii?Q?pPwRiA4a+ex2pnKCeTa5DFs2f8k4Ul5ZTOGnEOglvvXBLi77LHHAdp2Qnpdj?=
 =?us-ascii?Q?BdV3xLNY/OKgUAWGqLItYd669XODTABbQmxvoLPMvEwNjvfyB5MwXTkLDlLg?=
 =?us-ascii?Q?q+q1kMQM6SB9VSztIMrV7ZtXnIBVhyzyOziUzi5gSyxFWFUVcEwGcOziNJET?=
 =?us-ascii?Q?Wjk1jtuhAQEmxVX1Cs2rCcpUIdgXV0SAOdQnUpWvIvImIJSKooZkmhg5manE?=
 =?us-ascii?Q?Fcki0S1kHb1jo0osvEgcJ8ZsLtAIWyN8TSfrPoCMgM1oKCxOUJwx4ByKNChu?=
 =?us-ascii?Q?avqVtuBoy9BwHx0B4iUlNJRQ++Zd5HeX?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GuSPk/DwfXVZeNYh9DTqeBlV63YnBsbzfoWkBhwtnMcpMGYQDkTvh6Q1oOpJ?=
 =?us-ascii?Q?M330qICvytFFSrKK/c44YhMCf7v/cGuVsRv9EfGTWOAvHcSa0ipJLjz0CLSF?=
 =?us-ascii?Q?2iaLTqJhHL4QVfcMKApdQA8iGjlwrbhiSHX2oqBSaOZNhRPpVQBVGuZ2fgPv?=
 =?us-ascii?Q?U/+Xya8vKR1FUCPHT5Qkc3DhYSwCR0u28xdfPWywFqaCBhVzlJrueGXwbnIV?=
 =?us-ascii?Q?xwZ6D/uABrWuOEhzSPEShNae/2E1xXi/35pWPmgy84abkN+/fB7VsCWrlOfL?=
 =?us-ascii?Q?IMGrY4Hxn65Oivffz0L8VD/RF2O72n+gW5kkveYjsCSzRSYcxw7pqluvnk7n?=
 =?us-ascii?Q?SKysKxEtdA19c+3mpx5PL+KZ31jBtbaG+8I3DYYE87JR7iS0u4yaGD8OK03j?=
 =?us-ascii?Q?QBjEaciW2tH35v/3KEIhymP7kWp0mVE5hAJX6eVJXVHZE/AdRyCA6+59bxjR?=
 =?us-ascii?Q?hFGIttRtkhe0EuLAsWQWN5QMMaRfVfi+s+vFcbB0b5IKQWwwCaVoknw6l1wY?=
 =?us-ascii?Q?I2GL11PXgC9RhpH2KTtNHQAd+d5O75NOSAs8cDIIjpx4m0NwXKaTxTqfUNGd?=
 =?us-ascii?Q?qq2FV7CESQhXjOK0sX0Nowya6/Hj41b0CItJVi3psb7r7gvlcciPvx0ncAxT?=
 =?us-ascii?Q?Xq3DB8uYquL59v4MDd+Ha6yqQMPGhxt6zLfoqdy2+SfG2PEJoENrU+v0MNQc?=
 =?us-ascii?Q?+hW4BPCYeV+Q1TOexIlGYYVjEih7JUmVPH0t01+9X0rBfodPEUwZj6ZiwDPT?=
 =?us-ascii?Q?N52lskRXoCtK1AI+Ar6ujhn/+HiM3tEOwpnYW5cow2jH23kLWIPGK2Q2JQE8?=
 =?us-ascii?Q?Ry7eq+s6OYxzE3W+QWHdF+FV/MTJ3OsNpjiQmPC/O0Ez34bk0ZyV3j7sMlDk?=
 =?us-ascii?Q?9XnljLwhmD4mpJC2Gr8N1FViqef0ogFdEzn5sSEeC63MUsgVVOkWKz7Ru5Gs?=
 =?us-ascii?Q?KzUbzd+yNNTNVRWMbZy+zFG21bbfvRAC2qYL9XvOuu8DMORAQJ8wYPmyXbjj?=
 =?us-ascii?Q?MOjjDLiJjPLaHg77d+REltjuE/BBfrKF1peu+YvHFGwsSQtT7fSFLnMg5zdS?=
 =?us-ascii?Q?7gTpsjIYPktda4DZfrCfOymJ9QmwUxmi0xKpxlIYEWoprRbnpanmCVClgeHh?=
 =?us-ascii?Q?8JTJQ4ODdxj/vYUzLB3v4yjfeggTNwCsSDCuxKBQf5joW2mhFe3wL4YhaSDm?=
 =?us-ascii?Q?1pupBQpEswJeX6yJk2EN/U+M8Fa3OQfa4TR0Ftf8z6d3I6KVZMgwJNJZR1po?=
 =?us-ascii?Q?sjU3iAeM4zTEp8xU7lKoBHrwVQhH2Rpz4DrRz0dONT7dhbEUUqG4MLZ/cyyx?=
 =?us-ascii?Q?rt9h9MQNwK1pgT0qghzPU/1Nr+rP4i4a/7PXN60C9a1QaLtKSfZsnMMz3P9v?=
 =?us-ascii?Q?8VqqkCSkTOkSq3S1HDs+ImAdoPAIwjaR2Y9KaEHGg2aASlx8k2bXOi5AAFk/?=
 =?us-ascii?Q?X+W4udgeBrW51BbfBONPV9xQzw0gjQqzP+z/YKmCnRl4G1tD8Dye5l3mKTT/?=
 =?us-ascii?Q?lz6uuL4/LWT7CgT5L1qOfrIoxhx5WRFvqn1SuTo3WlS3ggaxjitE8lZdOAYn?=
 =?us-ascii?Q?YCQOyqgrwH0qOuk5UcwpnfSy+bPWX2DFKoRrl5KL?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f9500f5d-a603-463d-2a43-08dd5af01336
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 07:42:11.6851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AaMtlSyW/Dj+pUTlAaDM15jwv0GHuoRyv9HOcf5BWl7+73v2f9rMPBOQtd85sMC4phv4rykyOGVrmVYAUc/rBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4618
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Wednesday, February 26, 2025 7:40 PM
>=20
> -		iommu_remove_dev_pasid(device->dev, pasid, domain);
> +		/* If no old domain, undo the succeeded devices/pasid */
> +		if (!old) {
> +			iommu_remove_dev_pasid(device->dev, pasid,
> domain);
> +			continue;
> +		}
> +
> +		/*
> +		 * Rollback the succeeded devices/pasid to the old domain.
> +		 * And it is a driver bug to fail attaching with a previously
> +		 * good domain.
> +		 */
> +		if (WARN_ON(old->ops->set_dev_pasid(old, device->dev,
> +						    pasid, domain)))
> +			iommu_remove_dev_pasid(device->dev, pasid,
> domain);
>  	}

My comment to v7 was not fixed. Above trunks can be merged into
one call.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
