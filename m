Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB7A1C9EDC
	for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 08:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729844569; cv=fail; b=L4LDAx5wAUdfGDuYk7VKJZhWU5yd9ltg7GaB76kgSl62w/CZkk7cJcNMSEj9q/E6ziYhT18hGwawRojP/B40ZgMRyjyzLH9E3NTfZejtT3dPLQ9Cqdbu4jhXdVhandJjLxZPBhDxPpY3qVU3yRQf0431h8p/1CE1qjNYSfB5DyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729844569; c=relaxed/simple;
	bh=xA0JAg1xENX/BQU0C2S+oSsm5PzRJVh6KR05nNPMPGg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UMkUINr9X/QDGPweZ78Y7t1ghbH1fS1UapBBwJFSJDd4bEobpkJtJiE8ymkXPu49Im0HpDtHqEKs1MTTbM8FqY4ofbj1Grhs9YO7sa+1JLW4kxSY7n0yS6dydkFY15CRC8xWF+QZ1dWd+mJGg3U/RV9VFw0f1KDMABKsS7SwnHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kHaUigQt; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kHaUigQt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729844567; x=1761380567;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xA0JAg1xENX/BQU0C2S+oSsm5PzRJVh6KR05nNPMPGg=;
  b=kHaUigQtgLOV64rRmBiICrNAgZyE2chXt/NCZQIA0u0lxnnucFQQjHoa
   EpCx4Ssfqg6emp5GfqODhZnaDqqULPCaYiPVHqgI28S0EVLb3dCaKATqO
   xGH/zyCB7Pdn36vzXnYE5yF8IkniaFOwXWaMLt4hj15ltSaK7zqTRdSDo
   E9d+1crFYby2oNlgjBdFX7KmaVYRTzdaAz6GoJIn6hgjK0rSNM7JAmbSm
   +WCKAXw8IYdpKfWYnCnQ5bQ3HjaEHt8NWubH0IjaAd0QBq3je6/rKYFIl
   EGMMw3KHtigMvDPMh4DJHXUHuGQ0qm5a/zUUIL13efx+u3wZUATkYsveq
   A==;
X-CSE-ConnectionGUID: bV9j+1RKRvygjCtF0L9hdQ==
X-CSE-MsgGUID: rr/D1ULmRa+P8VzJDQS0HA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40880401"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="40880401"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 01:22:46 -0700
X-CSE-ConnectionGUID: RGlzmIGhRTuASo6LQOeKuA==
X-CSE-MsgGUID: 86gXmZrJSqaOmv141vwvCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="111664159"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 01:22:46 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 01:22:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 01:22:46 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 01:22:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wazMcJT2811l4hPZSd23Q573+3oDFY7t9vJWTbdisR5MaCdmqEgLliQYftOozDIcVZA2W+KeeqYRuu+vzrCnlnS9paGrONt3zvnyUeIuCXN+GsO7Gyaqx/hTzApahyaQ+5XVGGyl9vzmF26rbL2zyLqMlyrbHxZ7TJQHU/3PGm3TuuHYK0muK2nLOHMBrInuqYTwE1RB0Ra56ZybRlrgqgrIr+vETTtxU3c1LrQMvB/v8ejMvuxgzM/dBlLZkRXmeL9X8aw8cXC/cqNU1RK+eYHTS8T5/wMFd9PwYicckkO3lEWep3ujUE4HALUbocO6XSCoRMHkZLvnEEOUcXKfIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xA0JAg1xENX/BQU0C2S+oSsm5PzRJVh6KR05nNPMPGg=;
 b=QVvic2rgwPApVvgTc5W5RA34e1N5FsI1NzfM8/RzwJv1C2ZqMWGdElRiFbCTaNmM404ox2VGCAOKqS131DNP4qdgGFf6YElRRuM16xQIGIFM0Neql5AIsoX0htSncjLpCgspIVkxoV7tt3wM/DPGeiGKHIv8cohtt5h4Ov760rtpM3aVl/DaB3sOz4AyXdAGUge2dVbiMR6lUdLKShEtH2bPOhmoenbSzUL4hO4o0fsIaftn4+R+sntxiMW15qtiBMQKEDemLSFxDjVi5BKSLO5dPtlCKDsftYfCaBCvaMA0FJQc2Q4AEQYxYH+wajObVfNCHT6v+JD1lWrgAfPATg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5085.namprd11.prod.outlook.com (2603:10b6:a03:2db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 08:22:43 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 08:22:43 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Vasant Hegde <vasant.hegde@amd.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: RE: [PATCH v4 02/12] iommu: Introduce
 iommu_paging_domain_alloc_flags()
Thread-Topic: [PATCH v4 02/12] iommu: Introduce
 iommu_paging_domain_alloc_flags()
Thread-Index: AQHbJThhgqNBIc9l70q7mfRuY4ndCrKXI5jg
Date: Fri, 25 Oct 2024 08:22:43 +0000
Message-ID: <BN9PR11MB527676345CECC24E4A21CBC58C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241023104207.5894-1-vasant.hegde@amd.com>
 <20241023104207.5894-3-vasant.hegde@amd.com>
In-Reply-To: <20241023104207.5894-3-vasant.hegde@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5085:EE_
x-ms-office365-filtering-correlation-id: 08ff0dca-cc68-4474-bdc3-08dcf4ce32b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?5pXpDE6ERiH2sXEaVIqsYg5mRKDuu5+tSC1+clt6N6mOvMVGgfwJQUxvwZpX?=
 =?us-ascii?Q?Aq6jIGHyy/42F5AmeEZi6yicLefE+K4abcNLf5k5H3+13AOxzf2yDLGC8ARY?=
 =?us-ascii?Q?f7aV0mt95VVhzlVEEnwPEi/IVYDfvt+KJ1JiLRNzD76qzK4Hb0TtBpY53AOJ?=
 =?us-ascii?Q?TvkcQ2G/RHMAHuvbOauJRjkUtiuXVTQbmbItjRaPJFvQAFC4QQwdyWoH4mZ0?=
 =?us-ascii?Q?eC1kXnf/I4NPrjxWZtcITSJsq7e16mDRSoQgg6Gy585PIphK+/6ul61EFfOl?=
 =?us-ascii?Q?3dq/PkvRTEBeYFrL/LYpNJLCuUb+uCLiUvNZCKOBTx4/iqSi5oOJj0bUiU8s?=
 =?us-ascii?Q?BEDLJWunNPspa23enADwRkMjJKcfSf6PUS9dWPwsEeevDWF0iKb84iEmHwMi?=
 =?us-ascii?Q?4mzX5QsbPb9TgtOGNfW0nXgp+zEd+YsgQou8Uz742brC2mIfzk+1m6gsWbpV?=
 =?us-ascii?Q?gbSi6Xv+4a062qSLQKpeEIniOFVA7xFcMsgsbS1n8TzOkyw6oZDKj08eshIZ?=
 =?us-ascii?Q?LaDTY7KP+pOikDNyOxUV1riAGeiNYBSG5+o7++cuMEnyztfgZyxtsaYjoMCM?=
 =?us-ascii?Q?Uqg1y1UxVwEF6qcPmgxO4togph2GdUqhGoQOXgnOKL/TSDq7KTxo2T1l68nJ?=
 =?us-ascii?Q?L11B5gByurVlI/NFF2HA+gnPII6zZdSI/H7RwwzTP98Tlr+qyvUsV1nbUTuH?=
 =?us-ascii?Q?GcC/y65KhIVq+lbJJd8n9dzmNSREbwagEDd6Az4BVrpL16fcrbEApDR8aQXx?=
 =?us-ascii?Q?u5MWQ7oMSHcz7wtaV/X5BcoFiHzf0SbDZdaBtOmbG6ekt4vNHlz8uH6kXqc4?=
 =?us-ascii?Q?uacb2sA7zCP6lHTE4nLoDRa/FiZ2WK9zyPbAGSQBWUw1DK0AnFTUcFI7Xp6v?=
 =?us-ascii?Q?AlIBL9oLOeVyM63HpEa15AjSsbzeVhU6i4+zr5hVdg+Atz11HM/ibgEkTf6/?=
 =?us-ascii?Q?YoTMLwawAfP/AoeVRQ/9X/5g86xNQw+tvA3y7AsV0iSmC6AsiqQ4FtuO3D21?=
 =?us-ascii?Q?mZJajAV5bgaf8BTUx/YMSUUWG3P3kTUN/WuW+dMG5CjIM8LSp0VQaHcSc9cI?=
 =?us-ascii?Q?21Ap1IU85fsHIqc2vh5j0OSyk1rP650X1kwSYJDD/uiRD5ae9I1/9JIA+vl/?=
 =?us-ascii?Q?pUeL5VcgL3xc4AjG12xQecE+nZRFe+9sUuLnkHD81IY8OLPTx4e5/CnCKhgr?=
 =?us-ascii?Q?Mo0kw0JhVI/4Bavl1H3ZRjE7lXD3Y/GORTTGai+csjPtfTDBHvI00Zw8H2Dj?=
 =?us-ascii?Q?d5NP4P2+qW2N51DXZs7QMhX1y57FMdtnsPyUqDpA3KUnj+CJQDgeV/J+RrCI?=
 =?us-ascii?Q?KvoKX7+wyGtuHATqdAUMWXY2lGP8d6eY963gUNtH2yHn1XiSGHgDYTq/+URv?=
 =?us-ascii?Q?MXi8ix8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YgoY4niczZM6ha4lKzxCqe9QY5JBPy5XORs1fPGqSooL8/UWsu/TI1yugldh?=
 =?us-ascii?Q?lnkd6wmZ3IJVeZ4AMTdHlwqU5Y0J4j0eaAkKCLF6l/jv6rPS8bawXxeidbzp?=
 =?us-ascii?Q?f81otIaChPQjulZL2DILIc0NczfOy3gfGvoax01eyCa8PeWFnAcYWtyk0Q8z?=
 =?us-ascii?Q?tAJiVXUNzBT9SkhBcrmSKhov/rGL0icp5KRrVO5CdVmTjXHgY8w+fXg2byt0?=
 =?us-ascii?Q?pHbOnALJsoTrGSjK8pjReEb+zAkwP25/C2xams4A7IFZz6j7TwWFJU0Of8VX?=
 =?us-ascii?Q?2E04idXgp2IziRPokIPleMLKxe9gAxZLSPlZ+j4HzsKq6FAgTPYsWN6FdMSY?=
 =?us-ascii?Q?gXpo7E0WaxMqhDMAnOmZ6JgF+yYII9LZCFWNaP9WvRBHdjD0N2nnS5V2/1VF?=
 =?us-ascii?Q?AF2aN8KlyarbPWFiQsGf6gARRTeG/94hQhhTkTL+D5CDVSe6dHPuBGOgmBe0?=
 =?us-ascii?Q?v32c4t6rkVbj6UXmAzIcwD923ZKA0UWigmJna3oYCQ1CLr46JDcbLcw2AI0H?=
 =?us-ascii?Q?2wzO4fWtREiwjUQ7V7HKNpcHDmeAJdhmeEd0EwRFKDNuJfXdB7x+LtTdNKen?=
 =?us-ascii?Q?ShfRRww0eGvAdzx8KMQbtd8I4x6YaYYzxGBZCfmU4/5ha4t2D61mfT5OQxx8?=
 =?us-ascii?Q?wbltJVvMGVRmePr5Mt55yNnqB9q6Y/fehTdXzdzR8JJ/V0JHD6YAGtE3uYO7?=
 =?us-ascii?Q?W361KL3LuKlOtdYGc1Fgb5i/7uKiAfvpygW0OHbEjnqLA5tJsLOqIHUiRsdZ?=
 =?us-ascii?Q?FNaS6bMjetOJ5/pzjXShEKlYsPnCpTQSpCaEXO3kL7ealINREB7DR2XmCazE?=
 =?us-ascii?Q?RjxXx2xShES0y1hCWkhypHkj+QQGyZy8quTw6vQQh71avPbJxq6MjIvw4qu3?=
 =?us-ascii?Q?++I/K7pVfvIVZmWXhhfnFcvMyFHjl1F23vyYqKFJ1rQMpnjsKdXbb18RdwQu?=
 =?us-ascii?Q?BThrLiI+Z9QvZtlA3sWQi6h7CdOcoNF2R2xl1uM4gO5a+72WP9ma0M56kvtM?=
 =?us-ascii?Q?bTcKm5blVmE5anc1ZGskUPt2FygQnix/ImylQz34uAnYaheMP1yegqYS9zMS?=
 =?us-ascii?Q?17y2ljuAS0sxKR95Ix2IMgHSbfvYImcJ+BRqOay6js4VP9FtzJv/WePzx5Bo?=
 =?us-ascii?Q?+GPcpD0wUt0rAbSy2CHzCchh2cD3rKgNEpN1USEibCI0EL2v2bdTYwtHMkXy?=
 =?us-ascii?Q?X47BJukAPead6A1koLiwl/NKOUnzF5PU8B1TVjsUOjeOKLeZvu6bEAlk6HjC?=
 =?us-ascii?Q?2qtJMj7gYtncN09t+/7LvykWP2NCIW9qcJ1y3FBICR8lUKLfRw7MbR/GcRxT?=
 =?us-ascii?Q?zwo2GlCNugzzlA7HlGCm3VRrU7ZGMJ9SaRhrNBmc1dvlcAxmrDg6mGxFwlZO?=
 =?us-ascii?Q?gnzXgE7dP3zdkAG7LQ4E/ETc6C2UxO4VH2nMYi7nH13coyFNGhxnJKsaIN3I?=
 =?us-ascii?Q?vvMkWtLVHjRzvuF1d6bQriKClip/6L+ILiJnnJSjUg8pQCRlylIZYXIO5pUF?=
 =?us-ascii?Q?pfi4reYQIcPypBiPFGkefR8Dg8J6gbffcW/nDQNIZ6odjFImEvEoP/2Ia/Zq?=
 =?us-ascii?Q?7keZlASmgQuMFAxuf5Gi23MKEavHyI0IutcelZix?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ff0dca-cc68-4474-bdc3-08dcf4ce32b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 08:22:43.0443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 836O1ziX5XiTYimutvO7FdcTLldpdvLWVOmP0cnhX7GMZEsgOW9AETXmAeUiAW9ucKdvAmDwu7s/ThIpn41sLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5085
X-OriginatorOrg: intel.com

> From: Vasant Hegde <vasant.hegde@amd.com>
> Sent: Wednesday, October 23, 2024 6:42 PM
>=20
> From: Jason Gunthorpe <jgg@ziepe.ca>
>=20
> Currently drivers calls iommu_paging_domain_alloc(dev) to get an
> UNMANAGED domain. This is not sufficient to support PASID with
> UNMANAGED domain as some HW like AMD requires certain page table type
> to support PASIDs.
>=20
> Also the domain_alloc_paging op only passes device as param for domain
> allocation. This is not sufficient for AMD driver to decide the right
> page table.
>=20
> Instead of extending ops->domain_alloc_paging() it was decided to
> enhance ops->domain_alloc_user() so that caller can pass various
> additional flags.
>=20
> Hence add iommu_paging_domain_alloc_flags() API which takes flags as
> parameter. Caller can pass additional parameter to indicate type of
> domain required, etc. iommu_paging_domain_alloc_flags() internally calls
> appropriate callback function to allocate a domain.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
> [Added description - Vasant]
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
