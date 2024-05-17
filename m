Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F4A9441
	for <iommu@lists.linux.dev>; Fri, 17 May 2024 03:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715915569; cv=fail; b=YkA/0J3V5wgNcajRAbalYKGpD17sH8E5MZtz3+sTXbYjfLNsbFw/Nrbqz/D7LkId6up/LKPdgoqZkFTwLA2+9udr/Vbo7I69AoKCu+n9fvw3/9u0bEuUgeAwuOEAepa5v9Dt3/jVP3qIAhGftxrZLIui1uygpfZ5xZLozzi9EFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715915569; c=relaxed/simple;
	bh=GnMxz4xvs07lTugaJmuMZ5Y/P9nnKTDl00HlFgvnGfQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cQOf77lmWvZ31NL9DyMrlMi4fkws35emlckvpyOmIplKynJOy6GQv6exZEmJ6CoLFjy/Q9ZVDhkcAA7PysfE2Mf0xo+rMmL5sMCtp7n8bDrKrXqKPiy6F3s2BhYnToxmPc8oFWoTVScMmMx4jSOsZ/7F1umitQ8EVchmKlvvA4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bKh94nXW; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bKh94nXW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715915566; x=1747451566;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=GnMxz4xvs07lTugaJmuMZ5Y/P9nnKTDl00HlFgvnGfQ=;
  b=bKh94nXW0dFw2W1BFFZrksAqAe2lVB54+WJoklqh1VHX40OsRB/Q9OnM
   uuDHkJIUETxQ5Hb5S7LxpNMWPhhvtewtkUtofwOvOxHroiARnHe1A0Oc7
   y83e6H738j+9pWh61z00+n3KlP9k3GcAjuDUKlLgdN4RFWVHG7+36bNBJ
   uL0DNYeqjVxPuRCX+UlWLBE5aupJT9DwwALdKt0i70XUr9ctfLdmOkuU7
   hY+zdw35OzRTV9owCrypxxJqNKsmftvja2SM4ZOmc86naxJjl+V59c15h
   wjc9AArXtwiJLc/rle8Gj8nOppcn+sNN6OxGUpcKq8DPVhqMq8bcOmw9r
   Q==;
X-CSE-ConnectionGUID: tL9a9/ueRTOvDsxzTPsbaA==
X-CSE-MsgGUID: ED6qrmzMQpKYM/TXB0leNA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11567041"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="11567041"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 20:12:46 -0700
X-CSE-ConnectionGUID: HaPZ1OgaQsG9WWpiSLGfnA==
X-CSE-MsgGUID: AyunJZ4gTS+u8I5uWvxrUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="31582916"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 May 2024 20:12:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 20:12:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 16 May 2024 20:12:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 16 May 2024 20:12:45 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 May 2024 20:12:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnCt6IZr5E118ONee5GwyJMNB/yLnkgcSiBM5CMiYZwuuXQ1U0wDjiZuz2W4lKQ/fGv2wV1ystzG0ImX0WBaWYUdUbbKY8tRwN3aK8oN6Wnz4+clHWYQEfg5O4SC0r2Jdvb3rmXmv1Azka8YkD+MLhB1KYU+40D9sCRF4yQkpsCB55WYStZc7s/ORPjEQHh3lw1EBCSO46BMuxrjKezghoa9nMTwwUi8YUGAJWO4qEP9y7U3pic7mIUkcrM9l4hlR9w07q1bFMmZKgemEA2lwKlWup47c7QNyouJARF6qQipD81FBDgxU/FzpEW8Zp3nP+C1nm187JOLXZYBGgUHnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxAJIcjVWsRdjFS9tVx7nakKlnK4kX6hJqnLnDR/D4k=;
 b=XvcZACg/pYhNlFHRUjkbEK/wwTthZ3DsdW1UPhwedBtdimyd3gfKlX+UQhlktIvRiqfNeTW4ZN6AlHmUihzgrMr1LG099CQi7dKHrkEsjcCvk3AhwuvQE5yzdnY5udijoKjkL0fX/jW4IvGZgxoXmLGJKMTxNE2n0DXHkGc9jEYIATRAAlMpydLER/VoqfMioj0P06IYLsZCHOQEO3MY8n+boG0t2YOz4l4YQ0r1F8DM9NarFNtXgJJFqzbPAulXLzCoK9v6jHOKXQYx2b7icbQpmRx/dvJh9fey4PzI8ZdT0adeeetswfIYZTq6vGwcnhaUaAU46OMAEi677PKV+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 SA1PR11MB6893.namprd11.prod.outlook.com (2603:10b6:806:2b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Fri, 17 May
 2024 03:12:38 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%6]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 03:12:38 +0000
Date: Fri, 17 May 2024 11:11:48 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <iommu@lists.linux.dev>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <dave.hansen@linux.intel.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>, <corbet@lwn.net>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>
Subject: Re: [PATCH 4/5] vfio/type1: Flush CPU caches on DMA pages in
 non-coherent domains
Message-ID: <ZkbK9CzmcxgqhSuR@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20240507061802.20184-1-yan.y.zhao@intel.com>
 <20240507062138.20465-1-yan.y.zhao@intel.com>
 <20240509121049.58238a6f.alex.williamson@redhat.com>
 <Zj33cUe7HYOIfj5N@yzhao56-desk.sh.intel.com>
 <20240510105728.76d97bbb.alex.williamson@redhat.com>
 <ZkG9IEQwi7HG3YBk@yzhao56-desk.sh.intel.com>
 <20240516145009.3bcd3d0c.alex.williamson@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240516145009.3bcd3d0c.alex.williamson@redhat.com>
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|SA1PR11MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: b8456bdb-f310-41ac-95bf-08dc761f34dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g7zT/GdjquSDyXYrSM5dMpkovOI++h6VPVVKcL9AOKqCmZ9ApL8+5LiXDA/U?=
 =?us-ascii?Q?SLEq8Iwb84eC4qoV3dHruVz//C7hpZVWaFITr81qJwheSMi933JG9pM7eZsL?=
 =?us-ascii?Q?ttLM6m4aiJGT1Xwy7c6Cw/Wrd5rV0cHaII36J/0FTNDQSnWUbU8sk7XO86K8?=
 =?us-ascii?Q?rA4kNU2Rr/laXeStlccNG3SoHlu/DwTWAwjYDp3RDPJ3tQth4zEavkn/u5DN?=
 =?us-ascii?Q?lZqVX+ht5zoiX9x+pCZwCBnJBIK3R0PwCO6Eg2/mda7O/VXTN1Kr7Y/+deaw?=
 =?us-ascii?Q?Jbk+vKJhxniGWB8NQgrSNsDxvNPUeC5OYiHDXEDsQId9LeR8jg5p1H9fFNip?=
 =?us-ascii?Q?0jcdr0892TlNHUKcmzN+RXpLzSeva95JaU/96mwz6chfyN6uY/OR8y9Wvot6?=
 =?us-ascii?Q?dcB1ZhiBTz8OyH6g1vImWx+HuJoXo+ZU9+PtzZbvLgHiZyWLarpk7Prp72uD?=
 =?us-ascii?Q?syXPV/mkoCYN0Z8FM2lcHyrdJOdFkM861rCM6/f4BL7exc3E8v3/LnIZPeyo?=
 =?us-ascii?Q?6nnQMptbAsr0hGblJAwcGIRsgY3xqPNTrw3bPomfDCkqe2Clw+l3O9eDzELW?=
 =?us-ascii?Q?o8116xxC2Fo2goovEIbL9d6kIXa7md42gFEIjCUPe7rQXxPKQ3QvvS4xwYtZ?=
 =?us-ascii?Q?AhdvAWJredZcbTNGGYVEO/spk17gmfs9sD9eIvabgWq0UNl1i6M3/sUYwf+6?=
 =?us-ascii?Q?fLNUVlax2jxMsMCvHUDGjjUrSMH9/CzgpBJeIukfY4jLIaZaZ+IEk634GlYK?=
 =?us-ascii?Q?K2K5kMrXf7jsHkutre1MIuJMMNnhtt+tSJ2ak0AodWcG2eRVrJnE8ZYk30KX?=
 =?us-ascii?Q?tRzHWoYH69aN7vQSRlwYRBmm96JDXOJHtd9XCOAb/bMmqLZXaSq74Rwpro7C?=
 =?us-ascii?Q?GkNw7lZ7xLXDi0zI/Rb3lgTAS1rUD193zeskB8jN0HR6QaLes0ygFfwu06aR?=
 =?us-ascii?Q?HcnLH5N9A7tDu/se3oVK3HHhY2iZPgzq++sufP7YvbzoXfL8IbdXQGaUqqHq?=
 =?us-ascii?Q?h1gfEJOG3SNWvvTr7FQAywgID8KRYQ5/CRTeBcR+GJRg+/a6BC8rE/NlWD3K?=
 =?us-ascii?Q?2xQ6ftyoPi6gAil/xFWm7jSfT2I/J7ZlyImKjerLw8nP2eCRh1O40c5kufm9?=
 =?us-ascii?Q?fxIjBSK7PFLckng0ki7gRUzETqH3Pjzj1b0alzduzIzD1m0baObjhmGRw5jp?=
 =?us-ascii?Q?n/5IdyU6izYz9z8CRKwLtlF2RCjVUNuNrJz5zpK5UCGX1DqsXGtFEciaBCli?=
 =?us-ascii?Q?RrtIzA7lTVnnTwHXlMahvdQydj46QKS7ifbGfR7npg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CSBBb6vE3jFb5NYDBDlVUbewG5Zjem7z5M1Ibel6SVAOdvkYY5J8d6ySMjcC?=
 =?us-ascii?Q?M+M9PAbvMxGWhqWQe0o+vSOqBnYJLo4irCaJVSovC1JDJsy7yPHLRtdAO051?=
 =?us-ascii?Q?+nXCM52XwZougq6BFtrZnQK9UScZRijVWz7xSJvfRi1un5EZzfpMxPKGkyUh?=
 =?us-ascii?Q?LuOfIxNhdpW5IDC6Pb7tQyyaVnIM0cQ7ttgNz+gubv/GzkM0WXL+Qt0OO1GK?=
 =?us-ascii?Q?T4sdNjjGR2D187CCTvks2//5xXoDYjM/3YcHYWsWqOQ/1SYzPu/1JFHyrwvc?=
 =?us-ascii?Q?b0n3EZpOD5Eqs7Pq0/VykFs2Og2Q5kYIwia+1VKLVz240yY9Heg0VGT/DzZ9?=
 =?us-ascii?Q?rzEYG/4g3XGrPxfuN0EkX8ZvJMnzVFdkEGCNeYU17Ls2WI3EiZM03DBqsUw/?=
 =?us-ascii?Q?IKza2jd7tvNdcXRHSkWneY2fF/sOLwpU4F8VWJlJXMFtdGqwhAhhwF/Z66qK?=
 =?us-ascii?Q?SO/4hahEdvFHsaYGggH1eIexrzNR1+flov9e80kxncp1WmzVfbgAeEHVNk6X?=
 =?us-ascii?Q?wYVsc87K2XGeFIJkDpelxbMGIBzun9D/WVQ2u6U9TBDEq1vXA5MWnXhl9uKy?=
 =?us-ascii?Q?m20TgWPsl4V8SbcTEmOmJ4+tkeEnrDpboQYIP/eW+mgUxRb7+zEO6NYb7tbS?=
 =?us-ascii?Q?s2SJBV3lDIaC44220gunLnnP8lor0wDkT97CXBHODrPzeCw6AoyeczL3tEWA?=
 =?us-ascii?Q?vU9oI6zapOo17sWX+xmjcrPPAuKIk7r6OykrcRQcuZQBG+ztRNKDGpOfGZrs?=
 =?us-ascii?Q?bC58LK0MR0XJ7JjCrrZNyf9B+dV/W1mF316ZUrYPktcW6X+oYFA+KDTyyjFy?=
 =?us-ascii?Q?fY/9jCEvOdKq4ocfu+Weex/vfPrOwzLGXqQ4PVXiDeFfMY8e4PvBgmJ2QV6E?=
 =?us-ascii?Q?ejENaFrcF2ifGauC8jZ6Kug5EEUEzDnva9hyCD1l1qBU9kzqNX90fT4k6NhK?=
 =?us-ascii?Q?sR60whGz0dB7a+g7do/1Cii9yEwIbu30lFTZhG8eJyE2/UOvKLvIpleMOTLk?=
 =?us-ascii?Q?2rx1iujhUuuvc28Nu/QKZ8UyVnwclgiFc1iFfX7sIYpCrFjdndAkIzmUdN+C?=
 =?us-ascii?Q?kVcUALmtRTOXR5cvwHM7pg4b12kNaQFfJh8tQRI7jdXsQzNgUmccdI+XyPnR?=
 =?us-ascii?Q?8gTuLRBv4qNvySIh1n6O8Cs7xZ3S/SCXABsumLVeZRZM2R8BJi1tCR2AjwmK?=
 =?us-ascii?Q?7KCt6GhnCprmiaM5Hc/CpgLmqcq1DQEDka/nKSDHVfyGJf1dB/aowgFD0YzE?=
 =?us-ascii?Q?e2B3O+OcoMPQ0+3MLZIoxvOt5SwVVi65rLUn3Qw0xBhYFRm/xsdTUNVlrOmn?=
 =?us-ascii?Q?rUaNslkEM+MOrokBavYZQF2KIUtlsbmip9vtwvRhysfJ6nt/cjtIso47K217?=
 =?us-ascii?Q?Ziid5Nfaz/yKByPgc2l8dFPYXyprEEL70XNTF65+LFKrpOFA9yJbsvfhLwnL?=
 =?us-ascii?Q?QzR0V4CwG+t9BjKrl9f2kwgKxe25h52jxy14gEm3p3gnv6qxI8abKyMPLfbZ?=
 =?us-ascii?Q?6W787KMH5LsnebK3Odc21fYV+anRpwIUvQrn5sq3foUbYVjfLQsSnTyk6CYf?=
 =?us-ascii?Q?J0STlmQZCqQCqPDgm6//OyoNQOTrFSRkjdAzPxwP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8456bdb-f310-41ac-95bf-08dc761f34dd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 03:12:38.4121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /v3FTOPghRFDYequsXZO+iAjupjiZHhRTjZeD+M8opzrFn5byAt09fPI/4uZlLbynTRrlOvMKv00uGnQOmMnCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6893
X-OriginatorOrg: intel.com

On Thu, May 16, 2024 at 02:50:09PM -0600, Alex Williamson wrote:
> On Mon, 13 May 2024 15:11:28 +0800
> Yan Zhao <yan.y.zhao@intel.com> wrote:
> 
> > On Fri, May 10, 2024 at 10:57:28AM -0600, Alex Williamson wrote:
> > > On Fri, 10 May 2024 18:31:13 +0800
> > > Yan Zhao <yan.y.zhao@intel.com> wrote:
> > >   
> > > > On Thu, May 09, 2024 at 12:10:49PM -0600, Alex Williamson wrote:  
> > > > > On Tue,  7 May 2024 14:21:38 +0800
> > > > > Yan Zhao <yan.y.zhao@intel.com> wrote:    
...   
> > > > > > @@ -1683,9 +1715,14 @@ static int vfio_iommu_replay(struct vfio_iommu *iommu,
> > > > > >  	for (; n; n = rb_next(n)) {
> > > > > >  		struct vfio_dma *dma;
> > > > > >  		dma_addr_t iova;
> > > > > > +		bool cache_flush_required;
> > > > > >  
> > > > > >  		dma = rb_entry(n, struct vfio_dma, node);
> > > > > >  		iova = dma->iova;
> > > > > > +		cache_flush_required = !domain->enforce_cache_coherency &&
> > > > > > +				       !dma->cache_flush_required;
> > > > > > +		if (cache_flush_required)
> > > > > > +			dma->cache_flush_required = true;    
> > > > > 
> > > > > The variable name here isn't accurate and the logic is confusing.  If
> > > > > the domain does not enforce coherency and the mapping is not tagged as
> > > > > requiring a cache flush, then we need to mark the mapping as requiring
> > > > > a cache flush.  So the variable state is something more akin to
> > > > > set_cache_flush_required.  But all we're saving with this is a
> > > > > redundant set if the mapping is already tagged as requiring a cache
> > > > > flush, so it could really be simplified to:
> > > > > 
> > > > > 		dma->cache_flush_required = !domain->enforce_cache_coherency;    
> > > > Sorry about the confusion.
> > > > 
> > > > If dma->cache_flush_required is set to true by a domain not enforcing cache
> > > > coherency, we hope it will not be reset to false by a later attaching to domain 
> > > > enforcing cache coherency due to the lazily flushing design.  
> > > 
> > > Right, ok, the vfio_dma objects are shared between domains so we never
> > > want to set 'dma->cache_flush_required = false' due to the addition of a
> > > 'domain->enforce_cache_coherent == true'.  So this could be:
> > > 
> > > 	if (!dma->cache_flush_required)
> > > 		dma->cache_flush_required = !domain->enforce_cache_coherency;  
> > 
> > Though this code is easier for understanding, it leads to unnecessary setting of
> > dma->cache_flush_required to false, given domain->enforce_cache_coherency is
> > true at the most time.
> 
> I don't really see that as an issue, but the variable name originally
> chosen above, cache_flush_required, also doesn't convey that it's only
> attempting to set the value if it wasn't previously set and is now
> required by a noncoherent domain.
Agreed, the old name is too vague.
What about update_to_noncoherent_required?
Then in vfio_iommu_replay(), it's like

update_to_noncoherent_required = !domain->enforce_cache_coherency && !dma->is_noncoherent;
if (update_to_noncoherent_required)
         dma->is_noncoherent = true;

...
if (update_to_noncoherent_required)
	arch_flush_cache_phys((phys, size);
> 
> > > > > It might add more clarity to just name the mapping flag
> > > > > dma->mapped_noncoherent.    
> > > > 
> > > > The dma->cache_flush_required is to mark whether pages in a vfio_dma requires
> > > > cache flush in the subsequence mapping into the first non-coherent domain
> > > > and page unpinning.  
> > > 
> > > How do we arrive at a sequence where we have dma->cache_flush_required
> > > that isn't the result of being mapped into a domain with
> > > !domain->enforce_cache_coherency?  
> > Hmm, dma->cache_flush_required IS the result of being mapped into a domain with
> > !domain->enforce_cache_coherency.
> > My concern only arrives from the actual code sequence, i.e.
> > dma->cache_flush_required is set to true before the actual mapping.
> > 
> > If we rename it to dma->mapped_noncoherent and only set it to true after the
> > actual successful mapping, it would lead to more code to handle flushing for the
> > unwind case.
> > Currently, flush for unwind is handled centrally in vfio_unpin_pages_remote()
> > by checking dma->cache_flush_required, which is true even before a full
> > successful mapping, so we won't miss flush on any pages that are mapped into a
> > non-coherent domain in a short window.
> 
> I don't think we need to be so literal that "mapped_noncoherent" can
> only be set after the vfio_dma is fully mapped to a noncoherent domain,
> but also we can come up with other names for the flag.  Perhaps
> "is_noncoherent".  My suggestion was more from the perspective of what
> does the flag represent rather than what we intend to do as a result of
> the flag being set.  Thanks, 
Makes sense!
I like the name "is_noncoherent" :)
