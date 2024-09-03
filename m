Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625E620011F
	for <iommu@lists.linux.dev>; Tue,  3 Sep 2024 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350464; cv=fail; b=Li5SXEyXPXHT1wJDGGTElQbBYj4JmQnoMOm5JWo3us3QDGwFFvApvWgW7kPiuyEdi5F1xx4wwwooDwDa9SVlS92XkGbMUrAGSnnOl3JF7LwpTKGwN2kSXP4YGjhWmMAZBmEsVDGT+Tc7Ep1NwYFsnUiwt1m1/lgeCrYq8yMm/Mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350464; c=relaxed/simple;
	bh=fuUUy1JCikoJ9bGvA+q8QKoqeVFE+L3mW/NvAYkNQVE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kGrwzxcQpw5lcUCtMQAtQRlY9R7YkaWxI6HQAn6oe7tEXKu4AsdtsayLQBOoyw5hB96I/K7c+H9u2hRsG+XSdjJfp/0M6SM+jiMx7sMFtrofqHT1R8c6l+kFEne84HVe3xfr4nSbtfIp7+RnZOwA9kXl6f8RTFqCkuYjmLQWJSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dlgCeorW; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dlgCeorW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725350463; x=1756886463;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fuUUy1JCikoJ9bGvA+q8QKoqeVFE+L3mW/NvAYkNQVE=;
  b=dlgCeorWmZ5oxMS6M1bIkcj/xnxJYWNDnYYwA0+s51pe8zBaOb6naQGT
   4lJm/fncnZEwIL3nvVbyq740vjrNCzGaDZ9Dd+c6p5y5njmh3Pi3QMFnU
   3ZRs0t+FTsjFelHM9lnzq9gST98YZ4R6QOxmEm079q+vGiyif05sI92MB
   5TYc3GFsF2muMs9eNxGBpd0iMzW8WI7Jq+Z/qJElxzWg1Tet4fWJAdq11
   avAoP/Wx6bAsz6sdRcEOsRG1+u9Kt+rQUnz3KAKwo4mKSqh46DaBvt4zg
   rw0rRK8ujeeedfCGn0nrWNg+JwUb/d3FNnbOvCRpJt62Galwu3D8TlLsS
   g==;
X-CSE-ConnectionGUID: KM4QPQpfSUqoRahfoId2EA==
X-CSE-MsgGUID: okQWrTGPQ0eAhK7bONAICw==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="24089080"
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="24089080"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 01:01:02 -0700
X-CSE-ConnectionGUID: f/A8BdmlRTq/g7O6i45qMA==
X-CSE-MsgGUID: CRAf3BDoQOajNdFiGaKWVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="69684878"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2024 01:01:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Sep 2024 01:01:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Sep 2024 01:01:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Sep 2024 01:01:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Sep 2024 01:01:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJQJjxDAjlq8eYFDfKpTq1aa15nQ+w7v+LrMFJfbHFHEEfNgck4V3s0bz/K7QuKhh+6gVXDkQ6rhU+WtoZLSyqCzipZQQD8InQr2K058SifOfA2T+Idgffwt9m90opT1xshgp5Kkhc6R2bLTsZv3qlL40PW24AlMw8Pp3julzE8Q2DFmfGKTEM9a5qXaJuFSKacIeI5PK2omnBhvRA3LtC9UNXmnd3uvWdxWmkyx9KfaoSLG6wPB+42FdikLLfnzpiInH30/qZvPoASIHfzzg7m5wa+Lg47UpNGiopQWnJVxEYjfI4OM5ttc+/+V/LYU+NBbnkBI/IH57qTGQD94MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJ+vBK07R61mHs6IpjfO3f/iDoKhtnm86WnaTc6UTms=;
 b=fBPBPRJ7OwPk9/ApSO35Ju8j3NKbGQK85xci7Scom8H0iRdH/pTxU9apZyOBHcgq0s+zKffCuhAMzxWcZCtaDmeFHBc7OloB4da4XcjGwfg28g6a8HsgDIHKiimgmWjJyIOEM+mAk268aKt7YCOGq5+hkti6QwP0+pOsic1uEirjSDI1pPvW9NJA+e/R3+SPCUotfMmSxksqPao8wFQCv1El5IH2s1hxByb40tji43boXuZzCUvC7YJ0HwmvsjG19WunC/64ag08dHEPBxAZIviGE84A7lgqNV5Z8LDCuha9+UjzYON8pWxxAGf0U9NbxIy1iSmr6qSHW+Ap5War9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CY8PR11MB7195.namprd11.prod.outlook.com (2603:10b6:930:93::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.24; Tue, 3 Sep 2024 08:00:58 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 08:00:58 +0000
Date: Tue, 3 Sep 2024 16:00:46 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Christoph Hellwig <hch@lst.de>
CC: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Baolu Lu <baolu.lu@intel.com>, Kevin Tian
	<kevin.tian@intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma-direct: fix the page free when it is not addressable
Message-ID: <ZtbCLmsIF3On+aEv@chenyu5-mobl2>
References: <20240831110119.200377-1-yu.c.chen@intel.com>
 <20240903073521.GA2269@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240903073521.GA2269@lst.de>
X-ClientProxiedBy: SG3P274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::29)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CY8PR11MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: 20447994-c9d1-45f4-58cc-08dccbee8b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B6Epyxbh4xkNJUn8JhCz+AktNChkID1LjkVdL2kv7S8sxNtwmZxglEPstYpI?=
 =?us-ascii?Q?gfpOt29ArL72xaAyfYflbwok5j2iEv7IuCCzYA/PD/mVO8q7fHQbu67+4Ds5?=
 =?us-ascii?Q?UGQuGXMXGGTO/3jJhKEI+gKJyZ9JCq/i5sJ4zqmvHLYyH7iGvGs1mNJvyHKK?=
 =?us-ascii?Q?kI2fOVVykO5A7XI07hVTZU8rSHRWNaB0IqpFsNqYed+jggpwEvdjyZ6uLQ5x?=
 =?us-ascii?Q?iJkBOkso8z5ZTCvx0X82CvZKxmQrggQe7bDHXPdHc47qLpW8FACthTEUoMzp?=
 =?us-ascii?Q?vOb4N07lS4NDD48UqcGk8PjRbXxhqON+DDpdBmwAdSzHezDyFeIHWTWUbfFS?=
 =?us-ascii?Q?fp1ist7c3iDoNoVVvvOipgP7WZPrhH+0wnxqLQAv+ypW5/+1JodeeZXb1Rqe?=
 =?us-ascii?Q?gahQsKAoLao0TunLcB/nl/eqRaxOYZQpaQfAFo7Irkx+eAsAF4UEy394/uUs?=
 =?us-ascii?Q?OYRmDOkCvFFE7AVLaQ9wDSaRfJMOWo5dliMI1RgW5bQJiqtYALmJdl4uKe+S?=
 =?us-ascii?Q?ljOTvcJTA6AoA8U0i9/K0y2QmnTPIoGgTAUgzu9gsH2e7RxtqlWOaYmJ03Tk?=
 =?us-ascii?Q?Fj7QfuMS1PCUW0hDjDumG90Aekk5VNyxCBD1lkWNrF2pf0xjv3RDrrThxFQg?=
 =?us-ascii?Q?L10lWBAQpFQUJIY0IZvWAcULuLCHfbUQfpCEEH9O4XyA7nyibCk4ooWgqkgy?=
 =?us-ascii?Q?RptT7sw3g11YTBrhYOkb6WsXakJEcsuA2B9JN9n8ICCGWz/Vg8W2Pb4vTpt4?=
 =?us-ascii?Q?16X1cgcVvpM46YcwwrYFzzIqyfazfdtB3IGt0FPSuf6WgRXSv9cP0K+TvFBu?=
 =?us-ascii?Q?6bcxSwvSiCNvENnnh6ZgixeFjqHkmzHTYGy52DSgXzlkUz0vwndkyRA1j//w?=
 =?us-ascii?Q?A8aV9w8LKVZa5A4NbcK5Dsx4NYLmArod2SAQnmQAg+DsF8DB5TAgDJnnIB/i?=
 =?us-ascii?Q?qydbOtzdiLHXBYA1nImMvt41H2xYm2Nwz5LdV/4eY2m8XqT8AWEHphwaQcBi?=
 =?us-ascii?Q?+sJlUJyrTMd8zEECVNy+C4g1BQf/WDRgaNVi95kl+rbEFSASYXTDh6GYxynM?=
 =?us-ascii?Q?20bazCHPXKylUAcW4FaZpcRkmbFGWh5U/TAVwEfR7UbnGwGDlpU1CYrV4Dwa?=
 =?us-ascii?Q?xPmiiKyv9GGJjkVYVTJb+rYmRdHzt1kevDfaCJu16TiRAlVttr9eYYYnqJ+0?=
 =?us-ascii?Q?ynnH5YUvBWCrfaqgoD0wL9PKCfbNsP0WiIuEGYXgPpPJVtzrLgiFgmyUjKbL?=
 =?us-ascii?Q?KYaqCZtbKtZPhyvu8PbtDaJrPuZHc4zOtwJJyk9qLb5uU8r0vyb5fr+I4hFJ?=
 =?us-ascii?Q?rHE2UsAxwudi8TCkgs5j2rx4/Jb3T0Nm3yLYagT3Zuhhyg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g59bSy/WWF+UDDwf0MyuK4SO3Udnc+QIicvBNFw8olRQquo3LZ785Jx/Qxa+?=
 =?us-ascii?Q?LXP+1IV/fMO+s1fyyQPJkAMdOdsYBQXjGoMJuzLKQ0zciR+tuFkmsLxsS/o0?=
 =?us-ascii?Q?DCUohLZ9h6LS59f0SmhwW4azXek3yKv0Zy2lwlpO5djlT4THd2y+jKLmE1HM?=
 =?us-ascii?Q?qQBnyoo/6eRtxCgI6R1pVEy/UjNWjuo481if00GUIf21fJgn5xbyWDs+DkVN?=
 =?us-ascii?Q?VoeUwv2SrKJerohWuuyJjE4z+Puboyf0mpvgeRFiITkv8ognQLfNz4sv0QRP?=
 =?us-ascii?Q?kQrZrpEZ5owzMkupDf2XZAEsfwCXgHrgrYHiilygKsHm3p25xkekoCKbXXRo?=
 =?us-ascii?Q?hHVpstnW9tNyjldi1STAC9hh2xPmxiNcaUXIP82KSllQ7VS/IteKz20gbYRq?=
 =?us-ascii?Q?5W8HDYp0OotTy8H5RBzPPCHp5YUIixjqxQRY4oftkf7aHZQneyEvoLKPTERt?=
 =?us-ascii?Q?tlreOqcYIVeod0/ptcNyMuqF+m0zQiGYYzs2mIjqZJiCFd+w6teGqtet9X08?=
 =?us-ascii?Q?qIr/MPb5gk7D/iftoWMld5eMuG/Tymw9DetXudwmrTywM3mExcfp0yaJwfRD?=
 =?us-ascii?Q?P4Q2HL01Wo9CRr8lnbO8qj9eBPETEJjhMYv1mE/FAnlrKr/B65WogpZM1uKP?=
 =?us-ascii?Q?dcmYteRyyPnWLm1Csxu3wKwa/bW/qIIHwtuqt6veuxs6ml/8PoEwkChIaGIo?=
 =?us-ascii?Q?eTDEfSPSyEG4HURayNlYzFgVmxTVb4asBa4Rbr3k8yYlKGOALTTaxM1kHSxe?=
 =?us-ascii?Q?IvHYd7Mb23opjP6zftJIqqQTXHzlGlrdHCiTHS3V2jqyfOOoOpA/KGw9Tig7?=
 =?us-ascii?Q?LlYs8/f84K5CEAL+IjB8NVVFH4yTJNW/FtB7SZaUwpiYXHvVBfzzK29XEOr5?=
 =?us-ascii?Q?zpXiWXSWnnNqnN2myCcSKnl14gwtZbgnBCq2azs+xgw0YHbs4gRxY56DsroP?=
 =?us-ascii?Q?Az1CoAbHBAL4sFqTPNfkL1U4YPpAkxIRnbOF7hzUPivNEQ4rduUNL1KXdZyX?=
 =?us-ascii?Q?pfTc0BM2mtZJWpid0miQAmIcr1iDk2lDqZ3r1XxDZu0dcu6jeRp+5SO5KvHt?=
 =?us-ascii?Q?j1Ib40zraO2AB1g0lYZiOv2qcbT+fS212/E50wAbMcV0v+Syh2XtoYHMiurj?=
 =?us-ascii?Q?dFLlP9HG9ZJCP/5eNT+t5rIm9Vspi4BD+Yn6dAOyJnmwibd8orwdjNKII+Ub?=
 =?us-ascii?Q?N6JIFwfxymF5qKwJFjBSRk4C5X+TuL/LPUe/+yiFIMCpC8VUUIjPGka3mALv?=
 =?us-ascii?Q?DibpgLfMRN4D/aARtsUFQjbebhxtxVGAoxb9KV/UdPBgRoaxT3e5i7HvhB/J?=
 =?us-ascii?Q?rWKb7/dWg1S20/YWnVlnv1ImclDVWmwewabADH7DVy5vnNqm3By+btgzxzEA?=
 =?us-ascii?Q?6wWmXWwva5yBK/o0hDknvGkilIZYOoCkA1RjdlXLbEU8poj4p8vB32mQvY2w?=
 =?us-ascii?Q?lvfJUh5E5dvvjtVVtkeXXT4hP4nBc85gusoR2Zmag6Klp/fthL/pXiev/YOZ?=
 =?us-ascii?Q?3PEbGfBrje0llIuqAJ8ErhfnHZRyuZrAft+SCiTqHE++DRxwRXPUYBVphW86?=
 =?us-ascii?Q?kAAZw6c3Z8D0qDEabJ3OYyPvqPXwVzgce5fVsrJr/ozlrwBEP2qdBw+MR7pw?=
 =?us-ascii?Q?6GjnTUKO4aJeV2oTYRMlmth+NbxwCmk3i9NjkyxxhcOr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20447994-c9d1-45f4-58cc-08dccbee8b71
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 08:00:58.3301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16zQMS/mnPtvPrM46s/V5hirWrzeJc+o+eglKiOY6MPCc67B/9pQuTBUo4LIGQLzwLmgMFtuuvKmYl1LNE/nkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7195
X-OriginatorOrg: intel.com

Hi Christoph,

On 2024-09-03 at 09:35:21 +0200, Christoph Hellwig wrote:
> On Sat, Aug 31, 2024 at 07:01:19PM +0800, Chen Yu wrote:
> > When the CMA allocation succeeds but isn't addressable, its
> > buffer has already been released and the page is set to NULL.
> > So later when the normal page allocation succeeds but isn't
> > addressable, __free_pages() should be used to free that normal
> > page rather than freeing continuous page(CMA).
> 
> So the patch is obviously correct and probably useful, but I don't think
> the existing code is buggy.
> 
> dma_free_contiguous calls into cma_release, which uses cma_pages_valid to
> check if the page belongs to the CMA pool and retuns early if not,
> letting dma_free_contiguous fall back to __free_pages eventually.
>
> What am I missing here?
> 
Thanks for taking a look. Your are right, the pfn will be checked in
cma_pages_valid() to see it is within the CMA range, if not, it prints
some messages and return false, finally falls into __free_pages(). From
the functional point of view, there is no bug. From the efficiency point
of view(extra checks/printed message), and from the code readability to
avoid confusing, maybe we can refine it?

thanks,
Chenyu
