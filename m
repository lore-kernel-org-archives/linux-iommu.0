Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BFC18BBA2
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981728; cv=fail; b=P4lS2kuBQcMRYNKeiInAToMEo7pBJ42+CbrlC26s9gQ2MNBqbH6hPJ3OCMmiNEx6Ngv0MSkBFpuo1Wj5my7sXm5Qz6fNSaIh7YsX7PBnk38Y98+4TcfsJPR19GU44nOcbxiBT/C1C2zziJ1A7+YEL9hYUJiGkwjANdZCdaC0XdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981728; c=relaxed/simple;
	bh=C6KByRFmNC+H8lZW0LOSDodMFt1IBOaVfhMV4gBOe48=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EEDvHnmYPNGbnc0WuMrLJNHq2CAEnWVUDIM/PYLI7myNaagi1jeaP5dApZWdE9640vVcdze71uvbfysmSMUjVFlMb7mc+Ik1mvwS31/abkOxo1R+DaYonyn7xYKaetRsOe10cX0PZH4dMfx+37zoDKaqC1p5Vymn2bqYP8kRZTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iC1KbNW2; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iC1KbNW2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728981727; x=1760517727;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C6KByRFmNC+H8lZW0LOSDodMFt1IBOaVfhMV4gBOe48=;
  b=iC1KbNW2vdr2XZ6W8EeOBq6cyO/UGRRLnkkGCSsB5KNH6Qd3S7b2VAoU
   JmqiwIjTUxZAmbZBj+QkGQ9lY3f4ah1ugmKoOf+Q8u2ZS8lB2quuqebdv
   n+R+loZRchFfwSUzilNlHEBYySJCf/h51NwTz4kew8OzJ/cIxeEKZNmGW
   1KOBz5D8VbgtEdk5EgUakmwV+Gvty/tp+9/IAFOCyb2V3mG83olFS7igV
   rPjzARL96obXT364773RuKmqEXBUpS9WqM0ZrM7hc3oTJdK/HdoB/je8U
   JCz165oPWPMo1i+6W1gQrko7Hft2aJUn5L/0c9LmwzxgHlE+pXgNLVAvQ
   A==;
X-CSE-ConnectionGUID: XvgPzVfMQAWjL9EczP4PPw==
X-CSE-MsgGUID: aH0N+hRBS2mjtbFQ5/e0Gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="45864352"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="45864352"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 01:41:53 -0700
X-CSE-ConnectionGUID: OX7uBC8HT+mf2rVbIu7Yfg==
X-CSE-MsgGUID: 9u4ZyJ3UQyKQu1MfvrPIoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="77696446"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 01:41:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 01:41:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 01:41:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 01:41:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7S57FAlC3BFCM2zDEkS8yKgLAJUAwsel6O6y32DmPYjCHxaOE7L28/egwVqOe1UTgVL25IFUgN14uUJAqa3ywBK5Tx80FdgFyNTfx5HMppkvxsBBCQPKRrxKkmCFi8Lnptu2+9xIunRGF80rf4p4SPXWU4AC8Bhhj+jocHwgj43/PptYXm7a6eDgMjWfmEda6m3P5Jdihmmqckevghp017PHYdP8ry3HqJxpy7vOjQEfI7P6GB7uP4Dj5sv1kYO96+GMccw1+xElmcxI9z0tuapg0nr/rSK1S/G5BY2O4c84AagmyObR0o6NH+OOH3rbhHoPQfCI6C3zGtz7H6LVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHHuViqTpzC+oJDg+EwdSRsU8Mswer5eIG9yRYKUQ6g=;
 b=L92qOv8PWOZvvuPCri9Y27uRtl4b5gUE5dCG7krmycU5pcqJMONmj1A+jkxrZ7qnXkNtBRJGVUwVT1K39XreF+aXuiSh0mPE4ZTKmsJqIrsXbQWn2J6JAEpalAjOGf/5hXJngSK8nH6Rib0bqpyRArEuaou887AOjK/SX+HTDJ8G91IDYep2Wy53gBZQLN2Jtv9aQ4zIMQydH5XC+UoNdHCSWPqVphAjKpYhDes4RgrX+1lidTDqzHqcsg+7iOjp/qM9kvBGKcXAQV1IEcYeBHcjORvte8zB7l+LyrEEhxCznYVIGWFA7Nmuv9T8M6GylcJhzp7HlsFBARYQeU9YgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5913.namprd11.prod.outlook.com (2603:10b6:510:137::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 08:41:48 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 08:41:48 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Vasant Hegde <vasant.hegde@amd.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>
Subject: RE: [PATCH v2 6/8] iommu/amd: Enhance domain_alloc_user() to allocate
 PASID capable domain
Thread-Topic: [PATCH v2 6/8] iommu/amd: Enhance domain_alloc_user() to
 allocate PASID capable domain
Thread-Index: AQHbBDRtoHcOryrM5kW9RdA/OpHZ/rKHsUPw
Date: Tue, 15 Oct 2024 08:41:48 +0000
Message-ID: <BN9PR11MB5276124F430867613D7117E88C452@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-7-vasant.hegde@amd.com>
In-Reply-To: <20240911101911.6269-7-vasant.hegde@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5913:EE_
x-ms-office365-filtering-correlation-id: a5e67259-9f13-491a-a87b-08dcecf5352a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?f/E1RU2F9zPHtk6sm5n+RSOQ5sxOopBd1CMGb1wsnThELwlqQT5Hrb2wfQIm?=
 =?us-ascii?Q?Vg1mhlLd5WrHtLDFvPmGRDG09UEfdsJLFWtGjZKOC8bzqX0fYU2CqEYOOgEe?=
 =?us-ascii?Q?BN7dRovNdUYI17WS1GTY2rqrUMzhoXOEn9nSj/6p5ju2SprWXsgmDclwr6rA?=
 =?us-ascii?Q?6z//VY/CjMFUyJcKHUSiasP7/XXam9l61FbUypQ7doMk2UiBVLVCOz1wwbOe?=
 =?us-ascii?Q?ii5OXZwJBBqgOIpdAYog1/ekg3KYaUyxi5x9G5HrM0jCBHMY/OZORKCZViLS?=
 =?us-ascii?Q?emZrm3fSBG2RHDxPJ/nzo+oSzD5ITzqVr8drMH57OQSv9owQIITPhglzjQUl?=
 =?us-ascii?Q?+gFqiBLnwGy5nbQ0XJuOlUlSuw9j6F9juiUe/aXmBEDgqSUq+Jcv/i06SAHu?=
 =?us-ascii?Q?iNdeR+No6FKgOranAivxlVRW288NAbf4jZAGwhBCMd6cuSfyR5iUebETNXAv?=
 =?us-ascii?Q?27KOpqenjOcA48k7uKbvr+fc/BAfMZFVnWuiacsscE+qqyLx6j7z4KA+XKzD?=
 =?us-ascii?Q?OQEBtBdu7t21jceTYjYkSX7/zwH7s9uwLk00JqVobmdXN1nwaOtzaksV/1A5?=
 =?us-ascii?Q?pecgtMFO3x3lOKNTUspLEUzZQPlJy8f5R3PXccScfyI5ufkzHT1YJvOpUMMT?=
 =?us-ascii?Q?rto2885/8wPDnpUiIBlEeZRmc/jg+amYnnZLm8kL/z8sboUKBm/A8KfHIXwR?=
 =?us-ascii?Q?R+yD2MdkpUQabs66n662owVKBEUVkMlL4y+zhEyP9X49ZsrMHjiKn8xDEUHr?=
 =?us-ascii?Q?35Z7jag0HweBGW6ECwEgB+m2DcYOsPYDJ2E9TUyfO3tmwniP7I9q5zkHVyXz?=
 =?us-ascii?Q?PoJIpHzJ6aKrjPnbSIGbs3icw2lfQKfPY2O9pO9Aiv06vUh7DMQ+m/G89wI9?=
 =?us-ascii?Q?9VTz4fa9oyXjHJjzuvh8XZ7jp4sAk6RBtpj80KRDQJ3ikl6J7IfuujWq8yae?=
 =?us-ascii?Q?rhSTvU8sDoPpEEplG/fYxs1FlFQ+LU+mpPuPPxgxDZP+ixRzewZRWts+rULt?=
 =?us-ascii?Q?9dOjknG8uRIhHjOgHWhEijKZ+RQ7nu8477+yN+qHUJbtKCGNVgwAIQFewznW?=
 =?us-ascii?Q?4IGDryBR/gpJl+zN+yg2NB6GezzzLK7xQ2Do+CGvqsFp0vSxXkpjNMdLKctQ?=
 =?us-ascii?Q?mf3ZhBLW4ENX0mTq9wo+xFdFyNjv2eZ2N3a5setcETSqdlwLVm2pq3iDelAF?=
 =?us-ascii?Q?EponGfDInBasH8PTpIy/qxzmkmwlhB4eMaxWT777fRQsfIyXmLFHnQfuG3Bc?=
 =?us-ascii?Q?iHWq1KMnbTP5gM+KuFSDDAumd3M9RCMSjuoN1/gVjkAtZpaWNXioOOph+QC8?=
 =?us-ascii?Q?i9DwQM2Hx+fL8eRC3isgypJlxwJai2BugG83esWQsdPHsA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QDNTN+bURMuh3PCmOGjWL8ZMlSshtniOejLKxZWR5wX+9awI5btWbmND0ytF?=
 =?us-ascii?Q?kuavQWU5z/RdUZPgQDjjQ7UVPfxEsG6pJlAeGklQaHBCBLwRFB1oxggt9kGy?=
 =?us-ascii?Q?i7PZGgEw72Nh364jf1hifoSzGC6Gzq+TKoRxLp2D2YLGVWWl08dYEeYcZpk6?=
 =?us-ascii?Q?1yWSx1+odZdH1zuPR0A5GJe4L923Xi0P2+oBiWJdAjNYH+mS1kL3Boolsiva?=
 =?us-ascii?Q?4fptQfu2kIYnV9hL31JqIBpzspmnYTpeCzqgA4v5pIeQPJbLLsULiKk51NVC?=
 =?us-ascii?Q?E8b2EP2mPvvtMlEhL3iN5sjPIgiAvQB9wvM5zFYo/YYS5L51YCinUmYa16EA?=
 =?us-ascii?Q?NG3tdyRP2RISctzLay2tXBRURNMmlaY7Cl19l+aW4alwtJcLALuXQJRc2Zdv?=
 =?us-ascii?Q?DqrV4lUQf605ZQiwtHyoECyJr2/+sNr17IAsftjXoSGwuyOG8ACh6YKsn+CC?=
 =?us-ascii?Q?WNlYnxcPsk3fkZwygnZ6bHH8SjGMDc8UoPEt4uYrhY+kcl/7wGEya7SuiRgj?=
 =?us-ascii?Q?CbdoJX4XuI18rZi11RcGA0PI3T1UnY2aUD2nU4PXU9NH9KSP0Ay71vZTeNNA?=
 =?us-ascii?Q?mShdjZxD3sL7Bk5TCWL1xYV/VtVlJAuH+vd6cQYPRPF9hLgmD2pxU3X3T0mS?=
 =?us-ascii?Q?uw4sCuz0AaezPlu/FpUdqfX2ltzO4aMRKKKBM+5tKPBUYxkNAw8HX/Rv7+79?=
 =?us-ascii?Q?YRp2OgL6VTRKuWmrdjkDKh9X+CjzqOyABpNkQZgnmtZdYQsamNrIykn6/dXN?=
 =?us-ascii?Q?lbje/Wye3UMmhktqBuhF56JSb/lTu/ZogNHv7hCQPUO7MPJNQPeR47KUwZqH?=
 =?us-ascii?Q?5FepuN4k3bEuAHwhuf1Q41NaFC5e+L0bQFrj+gU1f+vlx5MI/uh/F3ga0IZw?=
 =?us-ascii?Q?Wtz4Wb++bQiECInRe6YT7t+lkucBeoBMuzgNfEoWTw5czL71ZMFficgPS5LS?=
 =?us-ascii?Q?O3hEvqs4JR+J9wFdPEc9pRFEK1JOvBIUzUipArwPK0wW+ACUdlDCFA/Yi+RQ?=
 =?us-ascii?Q?Xviq20tcvIukhbCP6QqAWPYwHLU+EmVB9HUedJPGkR+2a9VxQaU/GxyWf0mP?=
 =?us-ascii?Q?llYRuBhbxxF/qv3dmdk+QqmWZsogODla2wcuiQrnkxCcZllg5qcfm7o4ZvT8?=
 =?us-ascii?Q?FcOSlw8zebo02CowRhLfdmU82BGPcnUAovMMCOhMwPep0OUX+mc3kBv8Gsj+?=
 =?us-ascii?Q?DfetI+gsuSWC0vfFMEdlJu47ilqcY4CTkMULmCx8GyB391cCRppdciENLApL?=
 =?us-ascii?Q?GTaKR/m67Miw5CURitfcOCCX52h2GtD4V9fqEpBSxbO8M2Os1mx0OnVVKWF/?=
 =?us-ascii?Q?ck4Txnc/0SD0kIMzdSbdcS4l8hzE9F38m7SxBToRveA/H4Ctr8EWkUxzaDq8?=
 =?us-ascii?Q?UtrbgN5ar/5Bpl8HAQZtljOS6oZmoeoKCyMnCiPORHNtNUeCUbpb/kYuJhsS?=
 =?us-ascii?Q?q7M8tZ936T/67EhePisyDwhP8hwJjbOVGdgQgLP6oqxSSX3Q/q3mcqsNOYNl?=
 =?us-ascii?Q?noUKdWJa/EhDCgks0C7nMazKko9yrN6vsQbH6DXLo094E+JeVWrSHHXoBHds?=
 =?us-ascii?Q?nZP/guXYh0nMZSsxejtHymdk6hPARcJT9/pscTpp?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e67259-9f13-491a-a87b-08dcecf5352a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 08:41:48.2510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2UCH0lrDiXH+HSxjLO19LXK3kVOkXVMSuBAeEc7m0HbogbVQRmLrqP9mP7jXKtRn5Ox42WBzxtZEv/IuKMqCgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5913
X-OriginatorOrg: intel.com

> From: Vasant Hegde <vasant.hegde@amd.com>
> Sent: Wednesday, September 11, 2024 6:19 PM
>=20
> Allocate domain with v2 page table if IOMMU_HWPT_ALLOC_PASID flag is
> passed to ops->domain_alloc_user().
>=20
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index cfeb3202ceee..1c9e539f15a7 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2401,12 +2401,23 @@ amd_iommu_domain_alloc_user(struct device
> *dev, u32 flags,
>  			    const struct iommu_user_data *user_data)
>=20
>  {
> +	struct iommu_dev_data *dev_data =3D dev_iommu_priv_get(dev);
>  	unsigned int type =3D IOMMU_DOMAIN_UNMANAGED;
> +	int pgtable =3D AMD_IOMMU_V1;
>=20
>  	if ((flags & ~IOMMU_HWPT_ALLOC_DIRTY_TRACKING) || parent ||
> user_data)
>  		return ERR_PTR(-EOPNOTSUPP);

Hmm is this series actually tested? Above check rejects the new
PASID flag...

>=20
> -	return do_iommu_domain_alloc(type, dev, flags, AMD_IOMMU_V1);
> +	/* Allocate v2 page table if IOMMU and device supports PASID. */
> +	if (flags & IOMMU_HWPT_ALLOC_PASID) {
> +		if (!amd_iommu_pasid_supported() ||
> +		    !pdev_pasid_supported(dev_data))
> +			return ERR_PTR(-EINVAL);

Just check the iommu capability here? IMHO it's a sane case to first
create a PASID-compatible domain for a device which doesn't support
PASID and then attach the domain to a PASID-capable device later.

IIUC the v2 format can be attached to any RID.

> +
> +		pgtable =3D AMD_IOMMU_V2;
> +	}
> +
> +	return do_iommu_domain_alloc(type, dev, flags, pgtable);
>  }
>=20
>  void amd_iommu_domain_free(struct iommu_domain *dom)
> --
> 2.31.1

