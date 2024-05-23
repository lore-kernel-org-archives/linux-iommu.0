Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3F926AC5
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 07:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716447946; cv=fail; b=A/wsvXVRoGEd2gZRAGK78851NchsWLmCBJgdZ36WcyfmW1cJHDrRbSBowDrnIrPvkicShFwDbDkroa4RMX2Ql2pufKY5mBavjt9gYEaYspKWgBDIIcXOyglNBeG7R3Or+JAtd2FVaNG3P7Tcz2cIEbRVbQzwDulxAss0O06h2bQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716447946; c=relaxed/simple;
	bh=L0zHpDrP3h4mB/yFqb0ej7cZ6eiwGGVU2uUpdHbBluE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BuDzyDTX+bBHl/XzTOI2cDQ0E31fQDzd1mwl1dIzwC6N6WrhCeE+rNKOWyEY6gDbAWA1v9x1IHHnkyHp7KwMax3gBl91qiZSy9lWoxLZr95p2gUVXHOG9sGXSokenRGEygR9jIRFm4XhZynPq5R9O0OAdE+y2dtlAOvKzRvotXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VvFd+te7; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VvFd+te7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716447945; x=1747983945;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L0zHpDrP3h4mB/yFqb0ej7cZ6eiwGGVU2uUpdHbBluE=;
  b=VvFd+te7xNycDnjM2tA7mXPmURpLmNLkV0JCmhS7Z3+Rq9MPRBb8BTyF
   W/oOFEGRbVfuM5K1tB71WlEZ0RM132GIc8gsCvjc9wqA2Q+akRNxK+WQI
   Yf5ziqd+xh8wHur81mZ+dvCIQXy71/1WErBpvG05aPMzMR5rLo9AM5hJb
   SuSNAoFLB0NVw9UESsvOWc3QC2mhs6nJO1qhJOSDFEegxZwiBNK9ZMARp
   OGZsyJHxHh5OAv9f5hDk46kYf+LnoJVHc98SIfT6aM8fvwDl4rXTNQ5tM
   iO/5Hz3wdhHLYYlOP1s9+WtyITiMmIbLbtmoFfPsi+kYml32U8MdQ16oR
   Q==;
X-CSE-ConnectionGUID: p8dwlfiTTAim3Ay/AnSHpg==
X-CSE-MsgGUID: Y26yOqXGRxmY844fp728hQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="23315808"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="23315808"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 00:05:32 -0700
X-CSE-ConnectionGUID: KSwrZnpNRUSBw9+xN2AAbA==
X-CSE-MsgGUID: 8DUk1Jn+SPWs6Frxbd2/cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="64792295"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 May 2024 00:05:31 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 00:05:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 00:05:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 00:05:30 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 00:05:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4sP0oRFNSV7uclog7S9M8cfHD8rIsv/sxn7hgDkteONJnKnNhrancKvoSdmB1KmrdW5g+B1pZWnIjj1bsmwmyFNSCAzzftDS8x1JrLPvc5JTvm0d9znp5wdK77tRTiMEYqzmGWrwG4Bq2E7IHcyEUwgJWLvSVDC9aGUG8nVWqeGVlFUi8Py13nMXmAKj6iAwO/q62XyM/033APUyA4aBPxEJn/UX9Azv5VT6vuvXpBv9n0RIseqStVbMqvab4b5JIyrT20L6c/9zKmGve8FJ4bDtksvKSaSyAk4SxN+tSeBXrOToBYVHB5shojqwhqbnUCT0PZz3yCu7gMNRUhJnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7F8Gkv9IOvaki99mYY08hVPD2Ro+oUTNV8O+gH32tA=;
 b=h/6b7XsbO6avR474x0+/uxd/AbLhIz5uSeD1uaU5uHX5Ekw5SzE40+Dp5oicAd56FU7ymjlPyHpu2uWbGktYKhH9PPXSH46179tzkui0nzlxfw2Kcw/NKcIq7R5uwTpqJy0JCXBEuUEqLQCz89e+y40dCOcrca/VS65kwTt5MYw/dAly9+ejGXBzi5DMvCUqAmzXi/Y/aIPPTaqp/qJpkvF1Q57ZzcBTPXMpEwnbFJgEm0+NHZods9fMaeGQsJ5A/2bqNNOoO+Rafv2f/vBjL3AxRBLd7zrqT60347dtSKbELz5GqkZ/I1q/pSP9lq76KIIP/HhZ581y/raffbw88A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB4827.namprd11.prod.outlook.com (2603:10b6:806:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 07:05:28 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 07:05:28 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>, "Dhaval.Giani@amd.com"
	<Dhaval.Giani@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH RFCv1 12/14] iommufd: Add IOMMUFD_OBJ_VQUEUE and
 IOMMUFD_CMD_VQUEUE_ALLOC
Thread-Topic: [PATCH RFCv1 12/14] iommufd: Add IOMMUFD_OBJ_VQUEUE and
 IOMMUFD_CMD_VQUEUE_ALLOC
Thread-Index: AQHajVVtTIyOrzFsYEOvw2C4tndA2rGkop0Q
Date: Thu, 23 May 2024 07:05:28 +0000
Message-ID: <BN9PR11MB52763ECACBD6EFDFB6BF7F0E8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <b0ee53af3f59602834e67ddf86c748ca304da175.1712978213.git.nicolinc@nvidia.com>
In-Reply-To: <b0ee53af3f59602834e67ddf86c748ca304da175.1712978213.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB4827:EE_
x-ms-office365-filtering-correlation-id: 965d35d6-b0db-4a24-1bac-08dc7af6ba19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?F9SedGA4xqavpmdf1b9THN71mTsG01JkGHwtUX1lwPrBqNuZnLtvaKS01vAV?=
 =?us-ascii?Q?gjYLubvmf6QTbZWUvQ31iFRhiNRAaikqwZebQy324XKMTL0m5FxfHQh62P8y?=
 =?us-ascii?Q?nrc4KLOxFKzZw5SXgiiJ84wxpMhU4Ztp5HKH3Is520GRvTlQP/+ag7yUe4l5?=
 =?us-ascii?Q?yW9KK1/b6Ty5kQTbWnRu/0jHzou9tGGJLX40MMcwvD1iIYP9OZGbWK93IXVK?=
 =?us-ascii?Q?AqtelwevpoNl0HZzyyh1Z9ll4Q5n0gi3PDfio4xuk3lpbaK3jneJuIAk11nK?=
 =?us-ascii?Q?XLSQ4pj2K8XSGD3HZB+yhUaQrLnLxFHNFV64Rt3RnVW2V/p5z8tFbd0L1VsP?=
 =?us-ascii?Q?xQ7PgNalSf3O9sKk+zYfCamQN35EfRHiRWgzh5J/Sj19r3ruj3CzZO11c1x2?=
 =?us-ascii?Q?jPxOADqwrUJ8USiSJCQoA323mgOvsxG9okfLAcJncyqxCgGjmL9Lz2gMLnNQ?=
 =?us-ascii?Q?x6btDVMFK95TKMhlZ5gjWkCJ4jHuRa/8u/aIVrNf5PE4Jg04Xj6z9SWz1DM/?=
 =?us-ascii?Q?dNG3JbdRyop33Q6zviZg5220rqLky4ocZJ8Ih0eq92dp7WHjPiYyQ5ScqUuv?=
 =?us-ascii?Q?fTqCzPM2xD4RYqAI9ZGL8DKsG0K2tzoykSfJfGr1tx3zOxe1I1WcuGrjRXfB?=
 =?us-ascii?Q?nG5Y5iYDWa6WbztyTwI1IKTmEA7yo/rhJD0oF03AV6M5pzcg7Y4Z+iFX8TSw?=
 =?us-ascii?Q?8SPioXUn/QRm9yaYbUckX0m1GvUo2AOpg045erEZx+912PSrsor6gaYZnZ2h?=
 =?us-ascii?Q?+xJpUBLE8bhGbPDOuE76HoRd8qpCb8QlANXCNs2xIWkBUDspYIJDfWG25Fc3?=
 =?us-ascii?Q?L9B4O7uZFTYWv+y0G2+TZVu3EXAmnMRoDyZrHrc4E3nAnsN0NHdjZWawLqxV?=
 =?us-ascii?Q?Vv6azGa3ghl2pDcDvlQ+fYVM4KuWXeYnNBgi6XOa601YT5qN+O2+CviY5dqj?=
 =?us-ascii?Q?giHk9QSY62tdPWu/9UNz9P54lg3W3arwBzzDRtoBbo4XiB44mV6o69UPktc+?=
 =?us-ascii?Q?JFKtqZm9MjfoV32Ea++INTO53gwbBBIF1RPlZIW4/SCYnx2I22ViI5MJjhm9?=
 =?us-ascii?Q?ZGrf5OqW5Qs8cCMOk1ZfZ/xXLDfgfATypbwzFzAbXz8mT1DNHVOe8+NLcMWJ?=
 =?us-ascii?Q?k2nCTq7DIO5tlZNSL5uRn1Phuz6aaauuoQY2kSQFWQY/JX2h01SZ/d9PtTnm?=
 =?us-ascii?Q?2idtbTzJtzNIggvnAR3LSUtqg3z/tmYMxE588S+pIzs/ZyAFDcLa8Re0O8UA?=
 =?us-ascii?Q?cw7weCNPNBF+W6XtEd9KaQE6HxWxH7oOSp6sIRDPQ0q9SUq6GlIymfjtf/22?=
 =?us-ascii?Q?vQZ43/Y6rLZz00nbWUkDhwOURSE/N+ITpPp9bDrOlV0PVg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B7v0S3anpRQ2FsHYpMsWfqGNEdeq6uC+Nqz/mk/vjtWjoqsRvyovUfOU8gfu?=
 =?us-ascii?Q?tqYxNQzrvhT7eCdLkBgi60r7+rpEZ7H0B9kgQlaw3IFdJ0hgVnBmdK9dfoko?=
 =?us-ascii?Q?dDJ59eEuMSU6gbQxjHbjFXmuLF8YiCyE5FOs5O1YGWbZbgI6oIG60m4utOdE?=
 =?us-ascii?Q?FmUr9BcztHZ0iesFAhlrpKoGNMmVUpNhiJ0YL5W+JyFvIJJRNNwrVPLnP1RG?=
 =?us-ascii?Q?w7n9UXW4TM6sjjuLg1rtR4hauHt6nrRGMmdO4z83TvEU8hTW8A81Vmd5/h5m?=
 =?us-ascii?Q?o4RnPtvTph5BACjoeZ474s+5lC12b98jyhMI2m1PG8nygGG0/yL8Eb6B6nSW?=
 =?us-ascii?Q?vPe2BusmR36Pf5VrE/4i5kKFyeFRn7Ce3jhUE6QW0ps76OUzkaSbyyJ+qvNv?=
 =?us-ascii?Q?giAzVXgUbubRWIzz8d6ASBj0etpZYvV8c/qlDVDZqMz5kpVRvpCstrO0e0SD?=
 =?us-ascii?Q?GdSHyQEulVlhvQ+PhpvxsSk6FWk4ccI6DQokiJUvfndiUi6oZhaKqa5TGhX3?=
 =?us-ascii?Q?cS+/LlT5NSvyas9DrtuZBzpnVtzSPL9mkd60ZnnSpyd9EPlVe9KaQZykg+b+?=
 =?us-ascii?Q?ab+MynToTQwGEoeF7MaC0QsFR0fyadu+mIdf41Fa34l9aDK+6+WOhiTGIb3u?=
 =?us-ascii?Q?Q7zcQciNxfAowoMYFJSJy8V6/lG+qtFLLbwRAbFEQqf39AQNG/I86m70x6Dz?=
 =?us-ascii?Q?fWgUNa8u1zJ+9dBo4KKYBgRLrTeFE3XxSmYwW8Dh5HdbAaxxP0FU6cLXgihR?=
 =?us-ascii?Q?igB/nGvN6HHmZJh6g3F1qJo/7mkCUHyPXqhZwk0IrafApRNJ0YeJKLt+vsni?=
 =?us-ascii?Q?IVc8PH0OgtKCL8tK31m6CXNlbRKWznclPM4nm2B290b+lmHU1Vf35mgwxoQF?=
 =?us-ascii?Q?fg9eAqXw1xvjMRoqEvgwrLXtlGENpWISCGBQsoO33cLBPl0rC09VwaYifsyY?=
 =?us-ascii?Q?sMcR/5Nc0uOz85gvaIBstJ5jqUOC3lOfywqfD9Nb1vTsORsWunLB262+G6H/?=
 =?us-ascii?Q?KDLREzks8U50rahTrj1unWvNqwrjNXnT1ImyvfRzWwk5TzD6vjFAA8Y55RlL?=
 =?us-ascii?Q?cZl3yt9olmwYNoHMGAnVvKQ9KNjshKWfCYodjfJmFU9/CX1AjGSZJU+1IG79?=
 =?us-ascii?Q?13oeZT04XdYbBOXDUKPXO14+NAE2DzBBu2Pf58dM3exOJh592P/TDGaGC/+O?=
 =?us-ascii?Q?zFNI6iWjJcvfgSDdW7RHM8Zqz9Ca91QI8kW4FROLHAt6uBNoeR1XNbw/EANV?=
 =?us-ascii?Q?JKhKqqw8ha5IoFDorrzRU3ygqiCo9owtDWE78JylS02t+mwxBSSNP4NvexhY?=
 =?us-ascii?Q?VlZHnuKNqxZv0r4OZ/qSw55HyXIA/FuZMzAUHUHrLnFH65ZZG4OJYJRCrmC7?=
 =?us-ascii?Q?WK7MrT458cbPif1zXrrX3faMEGEL4xWRsEta5AnEQy+IDjyDKL5dGoZzXbmY?=
 =?us-ascii?Q?Lx/F0wjGv2dTmOVDIBkZWiC5WbvglcyKmbyAxR5t8NdnnpTLM/YlpOu8RQxW?=
 =?us-ascii?Q?UYjulSGq4pMFVFcTGYxTGloBrNV8nhn283VRQu1GaE8BZr06dXpHLMluXHYQ?=
 =?us-ascii?Q?J94MugA7SkmeLVBamdk5oHXQ/y3aVYamIUyJSXgX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 965d35d6-b0db-4a24-1bac-08dc7af6ba19
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 07:05:28.2481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/kPTTrsGR0plIHu4jxZSQ5T+jwr+5AyM5JNp+1blKAbPGBCpOOhj/JWo/oNuTimAz6cwwDIw2nkdav9irUfIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4827
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, April 13, 2024 11:47 AM
> +
> +/**
> + * struct iommu_vqueue_tegra241_cmdqv - NVIDIA Tegra241's Virtual
> Command Queue
> + *                                      for its CMDQV Extension for ARM =
SMMUv3
> + *                                      (IOMMU_VQUEUE_DATA_TEGRA241_CMDQ=
V)
> + * @vcmdq_id: logical ID of a virtual command queue in the VIOMMU
> instance
> + * @vcmdq_log2size: (1 << @vcmdq_log2size) will be the size of the vcmdq
> + * @vcmdq_base: guest physical address (IPA) to the vcmdq base address
> + */
> +struct iommu_vqueue_tegra241_cmdqv {
> +	__u32 vcmdq_id;
> +	__u32 vcmdq_log2size;
> +	__aligned_u64 vcmdq_base;
> +};

Is there restriction that log2size cannot exceed 12?

According to patch14:

+	q_base =3D arm_smmu_domain_ipa_to_pa(vintf->s2_domain, arg.vcmdq_base);
+	vcmdq->cmdq.q.q_base  =3D q_base & VCMDQ_ADDR;
+	vcmdq->cmdq.q.q_base |=3D	arg.vcmdq_log2size;

It only converts the IPA to HPA for the starting page, assuming
continuous host pages backing a guest cmd queue including
multiple pages. but what guarantees it?
