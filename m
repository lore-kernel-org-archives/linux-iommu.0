Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D51EEB3
	for <iommu@lists.linux.dev>; Thu,  1 Aug 2024 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722499887; cv=fail; b=YAyRjWh/qJo+Y7NQ2uoSogPKPoNf9CjIDbu1OQXqeL22lhVWvwKx0BEf7ybObOl8Wvo4ersAiWEc00VtwA198U3gpR6KJUpjcHuLhUWk+30R58nvR7uW7gVjJ4FdMOU74TLd0dPNav017qMaj1uiwv3bDXlQ33qRNf40lGeyFnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722499887; c=relaxed/simple;
	bh=g5CrualSpNHVha+egnJ8oiYrWKgiXbI5viGzGm88NkI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k3iUx7+tGpwoUP/A2SfK5WM3i0tjyQYnx676yK8VizXVFAW9sMhRbb12nKWcdZyGpZdQ07FsdjD8azqMQH2XFSRilHjGSzedQcjphNsIvtfDT8VdrN99c0JumMyRwzCkk1TpTVfr7d7ajgmiJDYSxo/v4t6JwCckIbNf3rdAZVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NPSEo5Hg; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NPSEo5Hg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722499886; x=1754035886;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g5CrualSpNHVha+egnJ8oiYrWKgiXbI5viGzGm88NkI=;
  b=NPSEo5HgC4kgWQwtb9hI8DfHHcbV2StpXQ3JZWr9yYUFhVl0EhQqP1FP
   9pFPGDD/8BesI/0K+jhWkqJtMzwX+K4Wzpw85ZHzcAB6AAPReoGPH6ad0
   qEhyxLxEqwaWFP3t6TXWIrlzXBXHGkS1URkF90BaHyaWnT8RQNn4qR9zS
   ysOVbXKkewet2DuNv9ltYvTPVGYCtV3XT2SApc/29PaGNSy5hguPVM5BR
   va0Qnu195ytl5ZMPfZXDFuh2yKdYImwpGu90mksswgL35IULORvTtEL40
   CM+VGzCPkHZbVFuIuMfhF9z9pcmVcuVX7wceulV5RPQ5YYOJGykzrJirm
   Q==;
X-CSE-ConnectionGUID: nOJiScLpRgyHXr1rcY4jrw==
X-CSE-MsgGUID: IyXsbqXoS+SJ6A48DimSuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="31067115"
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="31067115"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 01:11:20 -0700
X-CSE-ConnectionGUID: enp6sANWQ7elxWiIu0i1Ww==
X-CSE-MsgGUID: B8THcZSeSX+VxP6JjfClFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="59277233"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Aug 2024 01:11:10 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 01:11:05 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 1 Aug 2024 01:11:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 01:11:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wgXghggxylSnLJCRt4O1rQxo4hm6TQekeJIBCbsmzCws0jm1utHBVidOBk3MyIF83ChYNPKWYFJXRIGqDnM0Jr+OQfjY2PK4KAFUFMOxAU+gxbHX6EEOp1M5s+7BdSH73oRODcX+6Q5Iq6A96gfn3Bqon49SVWZMeCWpFqsDOBZraJlX8i9MRQuvy5SLnHMzFPKqFwj3pWjLg4boFyEtTbEItsGgGLBSU5s9NPOQ1YQ0eac3cmhHi2OEC97hDnKm7TnEv5VFsguYEiY1MC36Bj/NLWNLFX1Bjb2bMvuwDI9U4keRajwCHkdPaj5qbh0VFJwn71KDjGZUbXrgnkhjsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwcR/LzZbO+ahB7nu2IxHAqYRPQnnowoO0RgLo2rpt0=;
 b=ZpJb4WHsb6rLoAdakcC3PjzvleDBP03UFHejn9DzepgT1J5WP/SriZoAVcFHLUHJQmoLWB7pcWURECl1VwANCNrPZA4+eC+grpxo7dE5KVfowGI+8Kd8e6ThKl2DYhjd8FdS1M34Ul97AhLt5QmgIrQOrwMmas8nIfotqeOxK3FUDjTFjoVlfUlQHb75DF6daerVivawAFOWa4MjSU6gYDDNXZI04IQesoEI5afWfEHhK+qqHEaAnXcQilR36hMt62ZgFVv2PmwwORcr1OxJnEju1hfP8gOrEKCZom79yKyODNIub672uh24hvuOowimbixuSXgNU+Bo0GzMBOsutg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5916.namprd11.prod.outlook.com (2603:10b6:510:13d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.20; Thu, 1 Aug
 2024 08:10:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 08:10:57 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iommufd: Enforce IOMMU_RESV_SW_MSI upon hwpt_paging
 allocation
Thread-Topic: [PATCH] iommufd: Enforce IOMMU_RESV_SW_MSI upon hwpt_paging
 allocation
Thread-Index: AQHa4UkZdMuTQ3BgnUqTgvFTxUSDHrIQcNjwgAC3KgCAADSvAIAAtNHQ
Date: Thu, 1 Aug 2024 08:10:57 +0000
Message-ID: <BN9PR11MB5276F7ACEBCDAB8C0FF5390E8CB22@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240728235106.2435208-1-nicolinc@nvidia.com>
 <BN9PR11MB5276497781C96415272E6FED8CB12@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Zqp+sssdo80B7MaB@Asurada-Nvidia> <Zqqq5JYFswS49z2L@Asurada-Nvidia>
In-Reply-To: <Zqqq5JYFswS49z2L@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5916:EE_
x-ms-office365-filtering-correlation-id: 61543feb-2f77-4c28-3beb-08dcb2017910
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?pIbMhn5/Vsz9arHFG/nw9c0rfNETTIwjniq24dpp/5EolKDlsbJW3NJNKXaE?=
 =?us-ascii?Q?GaP03xqWsN+oA+gYEjt2X648UEqVSewPZGwM/i5v2fW44p8CL5uToOptGxEr?=
 =?us-ascii?Q?zqxHrW7WA15Sdjup0Fziy4kgy0jQYiYSNfTdFIr6C6vdqXCmg4LqUDlRjFnE?=
 =?us-ascii?Q?KF7/zDlwTImLRAPOYlaJu21/QajbIOPm0RhYMizt2bBnUXKvb1p7uSbCNdx+?=
 =?us-ascii?Q?2Abpe3KATLx3IHoPFeRSOjLZrpDo8TaKNKpObKo+GkIsObhpS9kZMPWJFO9R?=
 =?us-ascii?Q?MG8mYtc71e08/+0ms39bwsWxUzcB3ek1mZIt6ayciRApE+v3oZEZstjtBNkr?=
 =?us-ascii?Q?MUw5+aIMgxLVZdUd5Aw5HIFllb9aJKQx4VPm+X1ol+aYj2IdCKxkZ1qcy2gr?=
 =?us-ascii?Q?Uaau3//hUrqLhMVEhw5+8zRt0YzRtIghTo6EESzuWsJGzeviFPzBDa0oypRG?=
 =?us-ascii?Q?5PY3p5izEpnTiKLfM2B+sQdGE7S4SZabpTMNwNs/oQYJK1OMpXL+XWFPWhd+?=
 =?us-ascii?Q?Kxz0uyV+cUYeaikR+TAdk2cxzwht1+1t2OvmyG0OF6Bb0HhafhMjZzbGTFX5?=
 =?us-ascii?Q?XzXBARizz/RapUexFYdm06eSurAf595CCctXJjvWU3ysV++stryOgn1KssrL?=
 =?us-ascii?Q?ELHAlv076CtpYEkXEmAJUfIRcYMK8dvruSKdN/EGW+BzB+oOiwtFcf2y1AxL?=
 =?us-ascii?Q?hiaMvvDSFDzk2yAEJV2ZEovx64j/wSt7ZUdP1dUb9ddC3blHbsW8hJ0+tmDQ?=
 =?us-ascii?Q?oFAFIBtLwctgfovB7MB3gkj9Bu+5lq+C67Qmo44prWAdnoYxZWqA/M8hTj/i?=
 =?us-ascii?Q?LcW9PTDiBdLNapwL3GqTOZIRb0XmvkDXIgNtXXbKD7ouo/YyCoEX4JrthPyg?=
 =?us-ascii?Q?3fAfg7NuzcTv+hRTYxlxzGOGa8JTRTHzg56rFlguEe7cIDGnYAuv4oJqh8R4?=
 =?us-ascii?Q?ZqGaMAbp/s+wHa0RPs0NQIY63X1Pr0Woo8QvI2u2WU4t3Xk2kr1rBO93QhQK?=
 =?us-ascii?Q?e6TQ+yZCGkDObWSqRKj3LeYqeiDMaI0go0Eer3kfD79riuwFiY5rOdfUmPqP?=
 =?us-ascii?Q?l4jLk4+KYNW0kuwHhwQc3dVGiJ9aEDtJ7v6sd3IiS6BYNNWwbSOZjJKjoxsc?=
 =?us-ascii?Q?3TdASCY+j29/v5wctlE6cUwr1UnQiK5s5UcuOWLfgrrr0kkU2Pp29/FYiPsy?=
 =?us-ascii?Q?/iQZ3skJ2+NQQMGJuu9l/ute/lI7jhI5FvENsyrG1tJ+aDfGrXQmpYfRcBi7?=
 =?us-ascii?Q?6bF/1w6Tls2pfh5KvLRx6zlSReEhHpUjf/1N/ZT1iOgceR/DNLzZVGzbGnPY?=
 =?us-ascii?Q?0ICy+hHkptpE393cd+kzc2ZILeoecm2SBTyTUZhno+Wkv1mVuDgTk2pQfFlr?=
 =?us-ascii?Q?6da+9SUTW2ztYMFB6a/U75EIbtQsUW94DhCsZvaFA1+bgwkO4Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v7NEnW7t/Z8yOt6ZD+0eEvMkGTfChFbfFek4pu6/cHxgshpBZNaFMcFhibM3?=
 =?us-ascii?Q?6VXzK7G7YmV/bGtB+C0dj/NIH1noh79VCQ28Yx6GKjeL5i6v8wIk7UC7jf8W?=
 =?us-ascii?Q?E9360+mMq6PeKdA5uXMCfPiA5pOofAkeXbGVGyvuBbX0vTO4MQU0C7AaeUkg?=
 =?us-ascii?Q?bjd1crfnXIPW0rO2a0TWzz+hyjlKsGPvZ43LY/dKDQv0ZoZ5jXRyBF/m0qm2?=
 =?us-ascii?Q?pAKvP6OOH8Bxb6fEa5GpecMxKmX4UzSktvPmYvs+speTnyBF9PTUvVxa4xYy?=
 =?us-ascii?Q?Y6bEN0JpdAg/kI+C5HwMX3K3IZtj1Uk6HjhIR357RA2Q2g/o+at8wtj0VBqH?=
 =?us-ascii?Q?y0C1G37ahXU+lBOg51Zti22qVkr1n6fcOeVMy5PkovmBY4mfUhaFkY8q1agi?=
 =?us-ascii?Q?eRdGmmY+3Bv37Rk2K8bTVBcHRFYLByxYb/eGc4nA/BAsq5q3TWgoKQdsvVCE?=
 =?us-ascii?Q?8XZ+vAhW9AY5TLvWxSUuLuldfJIfa7V/Pyo3y7hrTv9MBUSAZaumC0wIiHfH?=
 =?us-ascii?Q?3QuX4rdqjLJnr4QFtmtXmgxr6qkhMuz8rBetAjP1hkslNaXcMXqPI7vK0XXO?=
 =?us-ascii?Q?N7MZfZscTnhX6O3PV9rcf2GlErG5e4FDmV2gGxx6n0s7HviH/zrA0FvzGKof?=
 =?us-ascii?Q?BOGfcsF1Bg5B7TlPsKfMcOd2E68EKhP5fPQQzzMbo1rmIDqFVEz1BydHT3t/?=
 =?us-ascii?Q?Hv0IHGNTQFnE9lHH3ctBMTihg9Qu/59DUSoITSywb6AB//fXBtd5cW9y8Ub5?=
 =?us-ascii?Q?rTuvWUA151rL75YA/p+1g/ZhInV3emeedN2ycWs8ofrsWCKts3dsBokx5EdR?=
 =?us-ascii?Q?vHFiFw1dpFhzCWQfmyYzsErx+QRu9VhOqH2lPAqd8kxicPXCt4s/GyL8TcWJ?=
 =?us-ascii?Q?wAJ6lj31jUW0IJPXe5RFfh/3KY9XSm3Ww4z2c7L160MZ9G9w2PZl1xFL61Ld?=
 =?us-ascii?Q?XDJ6ZPc0nCwBFNDIK6W2hqRSXIvgs2jbvckB10WkpWOx1NFKW69aSk5Xjsc2?=
 =?us-ascii?Q?6cxSiS+zRe2qpFepGFUbgg2dk6iAG3DAL4BkSMS9cTJbk/0mToRFtR4zPOQH?=
 =?us-ascii?Q?Zt/drJC6wwgccr19TgyqGafmrZySRparUYj5GtxGTWy7H2Xjx4XutDttwUPH?=
 =?us-ascii?Q?sPb98RvykHU9VHJ7YfbgkeJ7gJcSZbfwbY+FOaI3gkrlHKPbMaRs7ClGoRpw?=
 =?us-ascii?Q?LAlwONHO0d1eJKi8gYVcL649zWRPbAGfuFPVbjElgEFE/XZv7sZ6xeQyBZQ0?=
 =?us-ascii?Q?aYKvp9BFPfsLkBJqLXlX7q197w+asSvz49M40qB2O0KqOsMq0sJspYtLfwhx?=
 =?us-ascii?Q?wlIrI3LnhY7aZzEajk2qZuPySboSK+AVtl6PdTlAD9Vwk8XdhBMuOw6ft7N5?=
 =?us-ascii?Q?1CBX4+VgRenQt7TpW4DScFQ9xzXjMmvgxDRQsLnJYBpVPcsgxcki8qaFf5nM?=
 =?us-ascii?Q?58xYfR2FxDEAogf5gXB4p29zCe+BnXPUUrnKb9GVG1cT67PDw5h7evY4l5dU?=
 =?us-ascii?Q?6SHvKFo+HgN5oVr6nnT7Qr2Iqu69MXGZ6amcBA6LH71jnN/1Jiasm7yQM/xy?=
 =?us-ascii?Q?aVY+p4AUALDSP5sBLXI/tURnIwOtiuAEOjArllyI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 61543feb-2f77-4c28-3beb-08dcb2017910
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 08:10:57.5048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HElICQ1I/+p7vAdPzPrdrKA2ecnyqRfugxinTV+ecHwW4Uvfo35aN+MMUukLlj7yXxCJhbNF4tVYd0pjeCbfKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5916
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, August 1, 2024 5:22 AM
>=20
> @@ -316,7 +316,9 @@ static inline bool hwpt_is_paging(struct
> iommufd_hw_pagetable *hwpt)
>  static inline struct iommufd_hwpt_paging *
>  to_hwpt_paging(struct iommufd_hw_pagetable *hwpt)
>  {
> -	return container_of(hwpt, struct iommufd_hwpt_paging, common);
> +	if (hwpt_is_paging(hwpt))
> +		return container_of(hwpt, struct iommufd_hwpt_paging,
> common);
> +	return container_of(hwpt, struct iommufd_hwpt_nested, common)-
> >parent;
>  }
>=20

hmm this doesn't work with future new hwpt types.

It's clearer to pass hwpt into earlier helpers and then do the type check
insided and make it a nop for types other than paging/nesting.
