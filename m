Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFA128B7F3
	for <iommu@lists.linux.dev>; Mon, 30 Jun 2025 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295060; cv=fail; b=owMLGuikYHEwYo2DoPXqp2p/xGN2YTBgCdgd6sQnXvgta0IbwNAAb8v4xzJmtZotwOmVYWAnnascnM5ejek44I4UNCNw+wAQzDEs2Z+kzyYgBUX1Y8O5H0XDhDk8kiidTU8UbH/NhGXQjrTzZ0CP4/Iup8lOcgoOV54EjLPbnOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295060; c=relaxed/simple;
	bh=8P6ncbJdt6MVG0rIshjb2zEGMNl8X01BX1XYzwBCddU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sqa96KxVG30nNDA1AYf3GaYtVE8AFeWEdf8q2VG6W/QucVa5gh0mQRO6Qb1bIeqMaPz2ZcrWLLRXx1ozQ/f8vUt7OnolsVooHa2a4LzCHqSMVDPykLJ2HcWu9rRywjfROiuh96KINH2q+n+OAP2fpVnldAW0trANY3cmoPvJQl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LIvyUoxq; arc=fail smtp.client-ip=40.107.237.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LIvyUoxq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIeVYA+b7nNUhZQbQXwZF/e8slReR1a0glcl/VIiWUlJOOVgjWOIE9rjIXDjvNCuVpUHLzPKFR0LO7hEELiCOjN+5aGDiuHrYC8a4WLsgjtPg5dxQ+CFW0B1o9KGSnxOeoOa3WACPccfPmxNVEriioPvvnVc46NKWkgxAhzBhbXMjAO1/n0X7TBAtZ7GjZtDefIM0ihMDPMayaupvgKBtIcTVHFOBh92z4Wtu/XWODG5xyw0VmJW2DelDif+5y0SyEXccAExhNFFK1goLEp28GbvgFwDHuBmsHFES+YsIwdC2Q2uVQie0DCWS2aqLTUonS33ydj65VyztsXeN8lNBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8P6ncbJdt6MVG0rIshjb2zEGMNl8X01BX1XYzwBCddU=;
 b=IFIBAQM8vazy62l9MTBdZ4a4H6Pe34AEV8sOkCjVGhKpLa0WDkAi6lA6N2CnmTdl5UAdjKnYT5UYdZHe3h4k71t6SFXJiFFI0TaTLTIAwuaFCM7ZD8eYuxBgkJZy7WVVb/vpBm2sNNqSgbynlxU2fgz8EK9qSCJcVxNJrdWT7YpoO7JbC6esSy+8yfyitMb9giaQcIYLeQW/FIKfqkbbBm+eeSFyWSJpSqpJ1FM/DH2A5XUndfmub2XEu4SV1kojcHLv5r8N2sogtR30nBTxiaYW7NQXiXbf30ayHO7ebfuhbtLzVLB43B0IyZxPAPVkH96np9LahN4BVMNi5F7qkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8P6ncbJdt6MVG0rIshjb2zEGMNl8X01BX1XYzwBCddU=;
 b=LIvyUoxq6SuMpPoiBHi67CWw63sfFdCQ0qEc+tV22192tZSndhJgoaphHjuKiRbRgl1kDoa2lYW+zdKz3w/bSCYcXIF+14JkqjIOswzjKo93V8nSuGAfo0UIIxiPhOwgx4Ep9mc5UM6hxxEhyIe/Mp9MiIWH9xtvd4Lgglmkl/ImrgzblwLZQcBQIwYbWeN+CNSOe2fPjQMKoW8Thr3j/TFFd5CCVCZu1Nn4WSnceWvfu93SY8OSBkKTwZrsf3AnccEk3PCY7Grxd9l4Prf6Epjr1fbDkz1u0N91em1wZuCNCQreibggMjVmtBvIL/nPulFnmayym4VC7GyzcydEkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 14:50:54 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8880.030; Mon, 30 Jun 2025
 14:50:54 +0000
Date: Mon, 30 Jun 2025 11:50:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"will@kernel.org" <will@kernel.org>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"aik@amd.com" <aik@amd.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Xu, Yilun" <yilun.xu@intel.com>
Subject: Re: [PATCH v3 2/5] iommufd: Destroy vdevice on idevice destroy
Message-ID: <20250630145051.GY167785@nvidia.com>
References: <20250627033809.1730752-1-yilun.xu@linux.intel.com>
 <20250627033809.1730752-3-yilun.xu@linux.intel.com>
 <BL1PR11MB52712CE938B57E41C34580908C46A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <aGJkitx6wjfQ888t@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGJkitx6wjfQ888t@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: SN7PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:806:f2::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: c49d7724-d37a-4ffe-7ae1-08ddb7e583b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TZqA1VcaS3fxvMiVz8B1GVmkbRRtbNBTkpEYiOc9fSe8x9VR3MPp8+Dom8VC?=
 =?us-ascii?Q?HO3KRADRJ9oMPMFWQR80ZdQFt6uKwBVrHmhmnx7t/+Ts2QbfWdoHM+ga5KiF?=
 =?us-ascii?Q?fvxZ5OuhK+kK/wAoaJePsVxn08GyySu8Vb+Yw7Duyuh2hDrnU/nDpzqj4VY2?=
 =?us-ascii?Q?f3TygCH8io0PptX+PCGezqFMriZ22jYuaI16I+YqUw55DIXDkRZpeo7eokcS?=
 =?us-ascii?Q?XuAX9ITDzQvoz3YOTL4fBgo1DzfO4wprerG27K01fgBIY3DiX5kYI6jVAk8J?=
 =?us-ascii?Q?v9DMRiqXSvrSxjlKH9G6nzdjslyyjNWUuIVi9Mig7OQL2+NkcnuElcBsfMss?=
 =?us-ascii?Q?xhzM2szqqUSle6Lls9PWVcjAwG4NnLSjnNR39Aq6lYsCVqziNWOvy3tXwjI5?=
 =?us-ascii?Q?aXy31100xHiJhUoKi/L+yhAHyj8/e4cN4cl4+5TD0VxDmPn9UNObKrmApoO4?=
 =?us-ascii?Q?+hrxBid0XPnqZIRXQYHcK/XgDsx9NXfAUcpu5r+urKGy/kCjadqZR8/3qNwg?=
 =?us-ascii?Q?mx4Kxaq5dOEejHzLG27Y5BTkApS4XbmTFD1Fd7/y1BoiYC3SZvvuBbJoAwFQ?=
 =?us-ascii?Q?BHOucE8szEbM0xUB7C1tsPKfpwRS5L54OGLKBn56pzMKYXWuwKUyOfysFIB0?=
 =?us-ascii?Q?7s2wl3AY1TkGogS+6B+0aGTPju3eQt1OOq9PQ4jID+6/ea1HomveYuu3FTls?=
 =?us-ascii?Q?NaIdSi/Fw5n5qj5bWyEJRU/i6ks1IXctWIYCXR5uIWFP3bZ7yRFrSrz/YEh1?=
 =?us-ascii?Q?dR8UnfNOPy8jJEskIFkCMEqT2omqwtw+C9DpLDEsi7Lx0+4GxAX7AGfQqCsL?=
 =?us-ascii?Q?hvCl80IRzil6kbfwCCUe5jFw+oWHiqltFrfcTOz8hClcXHBdzmVktINLEvzO?=
 =?us-ascii?Q?cNnMS4kR652CcizCvlGNXEtxes7yM4MQiW2koPqZCUHPQGsjhWx/jGDqtpXY?=
 =?us-ascii?Q?ln3avCI6g8gzRs2ksFjQXdZRamNRPUDLAUsDEz9j5VZhmN2Cu5Cjt35o3Epw?=
 =?us-ascii?Q?25gO5K2RPXqX/8RtGvBVYH937+iI9gvpusOC+ZEuaCXV2Rqrfzr/seHycq0V?=
 =?us-ascii?Q?DPA2d6PB4Nsjiqty/HDJgMhCxgF1MmsLnUm/6wJSbdCAHQpxd8VJ+Mt4v9s5?=
 =?us-ascii?Q?HtXJng08gzQBopI3NUNjXwcVBbWnvL2IaMhdZJBdn9vLoxzG8voel5vzQQVb?=
 =?us-ascii?Q?RDhC4UeLSPhSCR47uKZJj/CnROqWoiMksOH8G0y0n+YXKtnU+3T8vu7Ig+9i?=
 =?us-ascii?Q?uRgEu5P94GJ3f6OR4ah8vDCH7Ycyf4H+mZQ9M8mn/2feECGVhJqCCdqV6RhI?=
 =?us-ascii?Q?3TdkGm2jIPptaZKpUg/jCqfHW7lwScx3pNsVPVHKPwlscrXKAZsOEpQId6ps?=
 =?us-ascii?Q?JWrYX099SM14DFqnlPgcBnxMiNifU7uyIjILyh9YPPQynMC8gj1S2g4Q/4k8?=
 =?us-ascii?Q?gKx2YzyC6Nk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5vu0r/rdEZ2pqstSTjOap0rqmQh44QNRZJnwFbWTkKYPrSoPPpSRVEGRhxec?=
 =?us-ascii?Q?+FI0zZyBdERIx4vz8HE4ONkIQwRBZ8C1bWy7RXTN3obdwzYY1MkMYpguGfAK?=
 =?us-ascii?Q?NhEOhyQ1cAbqV7PtvbdbR1of41QJnzeN1UbB+Mbek8G78sjtvG+rE47DNczI?=
 =?us-ascii?Q?CFeSMnK6F2OP20swR2fAxdv9jOrpsmgdhZhGhlQ1Ze73e66AslVzwTChbf7B?=
 =?us-ascii?Q?8bYz+WzSgLI6WtNQMzdFtN/i7CX8dXveA06e1/sX7QcnbXGETsPM7gyDsExc?=
 =?us-ascii?Q?t1y02tX+YlGPWpeEFDOjrGZ9+KeSWYFvWwPf9rp7fTPWtnSGBntV52p+SnPM?=
 =?us-ascii?Q?JHHiiVofgijtZdRQoJASHnwcRPQH17bcDa1rxh4JMpkAfLShpJAB9rb4dHAC?=
 =?us-ascii?Q?nnvv4dpVPkE8DW0Y4zE8o4k9RZmEclKWHYbcIkfjbQ80374CBiouVtaaDSuJ?=
 =?us-ascii?Q?A/fi/hQvrJostuuwBcVd9zbUzIg41cNV8hM3JM8GjOosyGdD11FVuwc46nM5?=
 =?us-ascii?Q?ldTO+MnzzhCGk4o+NuM7BbVzGqaGVUy7UbnGbIm1IOw7w++NAaRgD7wtRFWz?=
 =?us-ascii?Q?WcZFAIXFA3nXE6Qtq6Ge4ZsfYtz1eXyHc7UfN60TVaEmGfRc2sVBgCmVGVoG?=
 =?us-ascii?Q?MjBl35MJnZcTED85j5veSfwKl0iCgVg++685jtPW9yRo3+SFM9GjMTzCogP+?=
 =?us-ascii?Q?9HCLi+V3MGOZ3tNUdKFgWRFEPQwtXS2vwd4L5pgC49/bQCZmigwXZrVMzd1s?=
 =?us-ascii?Q?Ept+8QAPLwlMbbl740wEHc6TRj5YLBWeYyUkD9TipSgvaYqoJJSgO+AxGfUk?=
 =?us-ascii?Q?RjAe03kAXFyP0Xvlse1K2/Qsbol+b9cNqPye+lDB6DEZMckUkSxR/r0AhIwW?=
 =?us-ascii?Q?JzDaj4qfrXDCcQQH4rIMFtdRlv1ZF7zsj50owXo1ZnIZIuIsy6KNOQYkOuUh?=
 =?us-ascii?Q?vMU4xEBxkYuUniH46Ujowqy6cHtoIPeVPCpz1e+GnNchdEnGCFYJuopAVGUK?=
 =?us-ascii?Q?LxOpNItSDbs7ik4vepbKbIxlN0XkyaZ+2BiZlscQqbTEfDprSPnJbr/ui5Qt?=
 =?us-ascii?Q?fl2KgphrgggbN88bnlmoJyrPnozTVigZskSr3e5l86l+va4hTJKpoaQrogF9?=
 =?us-ascii?Q?45d2SVO+tv0/4hKyuENajf7h1qXSxlVqKEUaAtAeupqn5GRoZDlx1ydX9VB2?=
 =?us-ascii?Q?x+oQWSxv2GMPX5UTpdRAYa4eaGJIAbs61hcRlfH332eUz8ul1iIaw1rbwP6r?=
 =?us-ascii?Q?JRY9N7cbP+DA6yWD6dZpeYJatItNCfodHDYJkF91nVN/cWo532RC3SwvWc5Q?=
 =?us-ascii?Q?h3bbIviv3qdkVWgKq61VPLv6p+ES2kPEQ5ftjpp8XcGFt8h/eZ2GPnpaYHRh?=
 =?us-ascii?Q?iUXZnL3UhkvMUpeH2Ux1qmYzTDo1bq+bUFJ8w5yTRepRKi2fGA/PhDov26fL?=
 =?us-ascii?Q?rEKOL+oMOeW/3kIlqlaXowPTARomccdu01ZIBMnFnFiq3Vmv5FsJSkqY3Xvp?=
 =?us-ascii?Q?hVpsVqj1FgF8y9/Xdqtr3suwvRZZDUlMraFms2v80wcXyQXS1KD/tFIhhPS3?=
 =?us-ascii?Q?wi6ITZfhRGrJ0bc/B14nw3hkgb9BvaHbst8x+kFX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c49d7724-d37a-4ffe-7ae1-08ddb7e583b5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 14:50:54.5220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKeJaZoPZK+Wbp9SQcbh7a6D/oAQha0SOlwSZZiPaQDuGQNlA7edKk5ft56EW6jk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655

On Mon, Jun 30, 2025 at 06:18:50PM +0800, Xu Yilun wrote:

> I need to reconsider this, seems we need a dedicated vdev lock to
> synchronize concurrent vdev abort/destroy.

It is not possible to be concurrent

destroy is only called once after it is no longer possible to call
abort.

Jason
