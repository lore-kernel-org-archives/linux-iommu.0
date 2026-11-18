Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794989514;
	b=KcWaHPZD0xpl6JWn/CT2c6cRt6erZFsV0hUVz+P5zogOU/vM3Osd+Yvtkdoa83hvAlJn
	 wNJoLhV8WaueJwz8CG0VF1dmym7TdblieK/6JfNRUxGPISyrE5gbhmj4LWZZD3i19CDY6
	 pkrDwbDIslg09SWjEAAcbGucMZ/so4+JUMgKvfAqvk/9SAvUTYNA59AzqEZK/E2dlYfdU
	 lE/Q6rKfDgxrYjh8TUiPW5ern8Cts6JBrCqOxWstZy6xnc0JrMJETmhLSb6y2S802Z3V6
	 q9zJ6VckAwZ49dz+hSuI8g3Jekp9LIYEGDGOj4G/JWKn9AvL2I2Fq17ldJuXRYp+lmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794989514;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=yi3SvxapV2LeMeWO5UM0xtaKJ3ZIeZ+48/iE9WGp9W0=;
	b=tobdVflDfS26Jq/cij126q3f/fbGA71jYqc5qNCkOFZ0r+DrfvwAubBxjAjDuESAU3zK
	 l2fGGCZq1frF3OjKyhz7Thxi1qSjEt24hIFDHpbjaRL3amXUn2mNXGLq6NMY2bflEfW0r
	 VW8xgsTPzHetyKRX3XtrYraALWFGtV8JbTKR/+IWjTvNKHYkNZH91B+LeGg6K0gqv1Cof
	 WAiDtTmazyAZdRieCKjJCtRZpviZfydcB8/fFpb6j2k89W0Y+addgQUmi9eZOI3ZtSpCZ
	 LvS7mPEVx/jLNX58Ztaab0b2qpXp+x149GaAzOfavZ3B6f8omOYK72/4ViExcJybHHQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UaV8udqg;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b="BdD+F0/J";
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112AC606A325;
	Wed, 18 Nov 2026 08:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 112AC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UaV8udqg;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=BdD+F0/J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794989513; x=1826525513;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6KxL+/C1M2JEvKQnxV+ea6QBPyQqwjRR71hktmixYBQ=;
  b=UaV8udqgd6ThEeFIuuKyYoKjE0NmhVcJkrF1ca/RSaKDw/SPP+mYYyRV
   KZy5ctsfMSFoaryyVFd2w64OubxQDK8dfQ1F645BBhinwlqDftyK+OFtp
   WZnurg5GZXzWMS16mXEGGfE/5kxzvjGdqiSEhQZgXYI6VVP6IgVN8h/Jl
   1smwVWi+l6Lb6UoviOZ9TN++xsn0x8sux7Ur1w0vCa8S42aejU7d8/Cty
   bBl9NV1QjQbNmxTv2RiP9bapXGmQQH9wn4/a7aR5O/LwyiAkZMr7vXkmy
   LbBHbiTbP2hBrWYsXjNcPYa9ESl4L2JET2MuwiVC3f1oe39UMoB+0RLGG
   A==;
X-CSE-ConnectionGUID: qr/zmsxaRRy0eGGjtVR8gg==
X-CSE-MsgGUID: Vjm1ajZbQYWdgU2sRIo6vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3813564"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3813564"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 00:11:44 -0800
X-CSE-ConnectionGUID: H4OHLX3dQ6OVLiJ0KIi//A==
X-CSE-MsgGUID: ITn4oZ/xRRSKOOuc/1uJ7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10479170"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 00:11:43 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 00:11:42 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 00:11:42 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.64) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 00:11:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBrusRSDljYEK07oIHTOf+aNLb/RETOPl2BrM12XhOFwVR7jjQfPxf+WqCxyGdqmQSW1+Xh1nwaGSmhnbGqHapIsJgpr7N+IPS3tg+60QIijHA8NRPqKef2jpdLJPb5K797oFQ2IzaFey3LvU4A1pYWhn4rYLD+1GR+S8oVUhJTLMZ8mSpFYXMp4oVzIXZYmn7ACy37z1QkwPeT1XBMwJFT6cmP4BAmWT01uTrkcCFuW/u+B5DEjS308Ev0IfZWyGajYQxwWQTf6+ng1X7RMDSOmnPJwyU85mNCjnLX5zWYJ3/LJCwh8qF0thqDKETcMfvmx7pgrx/++FeNL5lw8OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yi3SvxapV2LeMeWO5UM0xtaKJ3ZIeZ+48/iE9WGp9W0=;
 b=JXvsqwh1oSbNFxG9Q2BF0JdizEmkiumHuSvpXBL/vdSoLU+zuZjLY/G9FRXm85sjGuah61yYzptH2opbu4Corzp3UXd5jv96xcunN0Nb+b0IXbjKDbsypoiQyJY5YLYGrRaU2pAX1gqBfb5nhxpiHGfk20yNtL+xLq3s/haskQ8Y9rsK/a96+JysEILcqT7ryzoHWP/+/TiVGhW/xQ306USc84OCWwZAX6gE9DrlYi8uci5h/NHG3RfHozO9QvIPjjl3q+92Se8qmIHTD5WT2ivLb4zalihPqB6j/IWxJ21iQXICyHKZbwZr0U01qy+2NKWVxcG6s2b0e+tmr3kwCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yi3SvxapV2LeMeWO5UM0xtaKJ3ZIeZ+48/iE9WGp9W0=;
 b=BdD+F0/J4qKPtxSDszQPozOZfKEvg3KPNJiKWENnzeW2p3PLxSXl54bQtMTcyH3gz+FAAKWFfxce2pFft1hqS3lKeLGVwbU+2C6ZrAR/g7gZgt29xEB9FPZ2GlnSJ3fwjDVT+i9+fnGrvRwV6QwdEXx6rmrE20nX/rPPebwkoDE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by PH7PR11MB7001.namprd11.prod.outlook.com (2603:10b6:510:208::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 08:11:39 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%5]) with mapi id 15.21.0615.009; Wed, 18 Nov 2026
 08:11:39 +0000
Date: Wed, 18 Nov 2026 16:11:27 +0800
From: Chao Gao <chao.gao@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
CC: <iommu@lists.linux.dev>, <x86@kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
	<kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 9/9] coco/tdx-host: Enable trusted DMA on IOMMUs on
 device connect
Message-ID: <av1dr3IGMqWA1-7r@intel.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-10-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112043054.2664857-10-baolu.lu@linux.intel.com>
X-ClientProxiedBy: SG2PR04CA0207.apcprd04.prod.outlook.com
 (2603:1096:4:187::9) To IA0PR11MB8380.namprd11.prod.outlook.com
 (2603:10b6:208:485::21)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|PH7PR11MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: c24ff29b-5408-4349-775e-08df454b9292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|22082099003|18002099003|6133799003|261009223027099003|11063799006|5023799004|56012099006|4143699003|10067099003|261026121527099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261022075727099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: FK+JF9Ftqkg75M98P7PP1UKpTJ3bBkrEsXtKt6RoBHkxy8Q6mE1LPAsswErAPVX0AaZVqYywKLCnsoTeE7FBIKTKrM9CRNrvk6JCilnQ1OEO6mUDjYDPmiKpvLM/w8E85VnayAfLNinivP4H/CfAsqDMaYYye2jW7ayga0hRBQMOtDsMJ/0n+954zDeBg64hylq7qwWYF59dVVqAfJtInvRX0zx0Sz1Afe3Kx5DyBflkQjIDFc/X9qqQFbbNWy2v7s6Ffz9vzHnPgRfBSDVDPe52HgRmumJrtdu8k5yS/Z1tgtcYf9trnIoJ4kMlfwO6ULffVf4dDjB2LlYWqOC82TG4WPepibwn4Z/aAd5B9eaa7ADZJfrpEc/BsV67u5cvY86P+cZU/wGchtIjhQdKIQt5wF23T1V312sTAcGnTNBTYzTXjlrxizEYIyJ85Rm+rMYOfE4GbSn4RE0jmTGdVrMmRjSj44ospg9zM+m0qlhfQwQwjYMQvdm31oNx7FmK2zjeham1SZaGyMr/41v5h/wFqregjt0rNkJ2HhrqMmkkbDd1z5Hkz3TnQoXZJFX5M/i15RW1DR5CJWoqQsRsg+gFjGaktBPCuLiZo9gTcGCpKqZO8abneoBv91RoSdJVTsNvmZEFik9Iro7Az6luU4PGuaoXx6tHO10n+qlpdVA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(22082099003)(18002099003)(6133799003)(261009223027099003)(11063799006)(5023799004)(56012099006)(4143699003)(10067099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P0p+wOFVUPb/Nv/f++rqebAe/2QmWXUq3/nD/iryYVyH2VSt4/0sSnEOf4i1?=
 =?us-ascii?Q?QGj/P0tz01f5KYYL51qUhH268c2ZPkZ37P4Ztap4rY8XxqdsIDDAWkkSoaBv?=
 =?us-ascii?Q?BUoLPjHUeIlK5S8Ls9C2BRdraHPn5aFE15I5BQwdBR2zec5uhX89ZwiUDXLt?=
 =?us-ascii?Q?yr6hxZJ9s5U6MOj6TtcJxcYeT4pPj5AwUSFtmF8tj9Rvnq3tGyjQEZuIpKuP?=
 =?us-ascii?Q?GTr6pxL1K99tAwZZMEo5k6NWMEF3i7b7ot1v3sqmzigqUmuOi1V7bCAqI5Zb?=
 =?us-ascii?Q?qbfZ8LxOhZZT/xFUhfmcy/KUV1vTv9dT4D2s7W0HxU06h5jWlujgB8HFYhEJ?=
 =?us-ascii?Q?bgStfwHhV2XmDaPI+/u6HM3bF9AD1ExmWNt8pxCwzLkfviq6BQ276+vd4GQf?=
 =?us-ascii?Q?h1Gd//8AOaD1GcbAf2wuO+p/ob7gjobq4QphgwvnqncaTd0dLP+MXjAO0Y1Y?=
 =?us-ascii?Q?VJ49wK0X9qmDJc34Vp6TUyyWMJepUOp8N2WlBnOd9W0Cj+sgKWIrX5hYKoZ1?=
 =?us-ascii?Q?ul4xew+nW7c2+uR1baCB2Mq6z2bzXv/fGu4NOrp7pKTk7mKJRLc9CK4LSnfw?=
 =?us-ascii?Q?e9sTS4f9nYIHve4fJDATWlfnN/NbfLrnRgqJ6GQynJCKuLMuS5SF5IxMJFby?=
 =?us-ascii?Q?9gGGQuaz33+S1A5N3Gbzg06m2cb+9knzTtmnFiHr29qjdWvG5lCFO9sX4CGE?=
 =?us-ascii?Q?bSqrvLcazrNUNfH4Z9eDPckWykC3ml0fuOIrNaj68vxIPChhp/F0T8HpRELF?=
 =?us-ascii?Q?HFVQoAGQSvnwmroZ6XDAmp0xhpYCS9KeRqoiLFa8SOfJEvWO22MVrFJvdmJM?=
 =?us-ascii?Q?OBCUO+reRJGxUGWajTPOs8gHy/bHq9CBLu+NHc2v7mgWuMIJh1mSQaGXQ+fQ?=
 =?us-ascii?Q?9m4cQiyB/VLx7e1bVINmKfkhBrgiW0NRoywObBUgyFXYqZndOJGUDWm9hO8V?=
 =?us-ascii?Q?5+AE3nqd+JIcF65Il+bOt8BSeQLGgy7vx+mdUT4j335xLZJKLK/YWXyoRhor?=
 =?us-ascii?Q?Xj71WMhN1ujbgpkoTdAIiuwzXG3v3e4H6U9bSPbwVNFWpUYQU7xzw70lIFkM?=
 =?us-ascii?Q?NLU5hcX+hlvAPg5CLt6vIBToTPUfiHdJzGH/oslYoQuNbuIl90+Zj97n/BMf?=
 =?us-ascii?Q?vHL2Sp3uxD5KoGSyll939pMHAQZuOhOr7lLp1WMTVZVyd+NSBML7XMMFZ+5R?=
 =?us-ascii?Q?e514toSO7Wn5H3HWXz5zlNp47Dq4mUlMvVscHrzH+tKWVECoY8GsrEiyxqIJ?=
 =?us-ascii?Q?P53RC7cDznYjrfRBuv8WDlHQUFlXfMcHrE+wleqczov2D1+soz7H9U4eEJKI?=
 =?us-ascii?Q?n3zTNu7On5kEwbzG5YQghxW2JOgSoesGV1m+P/zgzwdCcyyDA2+ySdXdt917?=
 =?us-ascii?Q?bsl/olhZ0QAOWcDDxGBeDAAiBfJi/4sw2BDsbH9XL7L1YsDhVa4OlQD5rgwt?=
 =?us-ascii?Q?wlpjI8/iRH0AkZGq/yCsdnteMY8afd7BmsZsSDobMEPKNfmK1D2HtosruCpF?=
 =?us-ascii?Q?6xKpd2bYQBFV1vdG5x3h/QfIhOIozzGyTLtlgRq89OfK4B8L+4iFe4akzTW8?=
 =?us-ascii?Q?gvFYq+w2K2GZKv1L7oQnMCZyqcZYhwFg7CEbT/EC/ehMQodpqKPh3LwJUt2I?=
 =?us-ascii?Q?Xgmbs9bOghvM+O2vNfbnKQRpLOOlK9Tuk3MEdy3HqqxsVX6MOxu560TkhPQw?=
 =?us-ascii?Q?g675gp9MMslW9uBbaJNUE023puO6olffsu7HZRwaOb3HuB+tE8CmTmurE6Km?=
 =?us-ascii?Q?4d28fO94zw=3D=3D?=
X-Exchange-RoutingPolicyChecked: l/+2UQdir7tQScw+LDYbG4GYZ1DhFKm9u33YNzAymfnsW5k8D7xOMSm65IPlkSzQvWtCpqZevUaV6P2gs7Mv39Hm+lUVzXY8TY0Mb6rGZ/yfoBY+ZztwV8LT5jTvMuUwI/qcjkVKCr5IZqVvzV4tVltGFydsxSYDl5wiodA+R4+43WlHegF0UnkkCe7jmhYSn3be5bjsfJnXNF7Ls0UoGn13W8fcYUDTuxjcfOE595Jt9ADpOauAAi83AU1HS9xaf/TPcx5ivDxvXwZr8cEqc7RIWeI7uwg1OTTz/7Vl+A1HwGvKSNGCGMsVIRJ2cUfSMOLZpDZnoSXndoykmuQKKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c24ff29b-5408-4349-775e-08df454b9292
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 08:11:39.6601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1UmC8YSoCQtK4JucPQeBpeNMRmkKjkEsvzpnBkhvIjz1iRswd/WLnS0ykvBImJJM5lcgASiXvWz7dObjziYdPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7001
X-OriginatorOrg: intel.com

On Thu, Nov 12, 2026 at 12:30:54PM +0800, Lu Baolu wrote:
>Assigning a device to a TD for private memory access requires that DMA
>from that device be translated by structures the TDX module controls.
>An Intel IOMMU that implements the trusted DMA extension provides a
>parallel set of translation and invalidation resources for this purpose.
>They become usable once TDH.IOMMU.SETUP puts the IOMMU into Secure TDX
>Mode and the TDX module initializes them. The host keeps the regular
>translation path.
>
>Issue TDH.IOMMU.SETUP on demand, when the first device behind an IOMMU
>is connected through the TSM, rather than for every capable IOMMU at
>probe time. Secure TDX Mode costs host resources: the TDX module's
>metadata pages and half of the IOMMU's domain ID space. That cost should
>only be paid for IOMMUs that actually serve such devices.
>
>tdx_iommu_get() and tdx_iommu_put() keep a per-IOMMU refcount. The first
>get() issues TDH.IOMMU.SETUP and the last put() issues TDH.IOMMU.CLEAR.
>A single mutex covers both the refcount and the SEAMCALL that follows,
>so a device cannot join an IOMMU that is being cleared or whose setup
>has not finished. The refcount lives here rather than in the VT-d
>driver because tdx-host already owns the per-IOMMU state that must
>outlive TDH.IOMMU.SETUP: the IOMMU_MT pages and the TDX IOMMU ID.
>
>The IOMMU_MT parameter page lists two contiguous buffers for the
>trusted invalidation queue, followed by the metadata pages. The TDX
>module reports how many metadata pages it needs in its global metadata.
>
>With Dynamic PAMT, every 4K page given to the TDX module needs PAMT
>backing first. Take it for each page of the invalidation queue buffers
>and the metadata pages before TDH.IOMMU.SETUP, and drop it if setup
>fails or once TDH.IOMMU.CLEAR succeeds. The parameter page itself only
>carries the page list into the SEAMCALL and needs no backing.
>
>If TDH.IOMMU.CLEAR fails, the TDX module may still reference the
>IOMMU_MT pages, so they are leaked together with their PAMT backing,
>and the IOMMU is marked unusable. Later get() calls for that IOMMU fail
>with -EBUSY rather than reuse an IOMMU in an unknown state. tdx-host
>pins itself while such an IOMMU exists, so unloading can't lose track
>of it. If the failure happens during unload itself, only the tracking
>entry is freed; the VT-d driver still has the IOMMU acquired and keeps
>rejecting it.

If the pin can fail anyway, what's the point of taking it at all?

If tdx-host is reloaded, we can rely on the VT-d driver or the TDX module
to reject transitioning the IOMMU to secure mode.

>
>Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>---
> drivers/virt/coco/tdx-host/Kconfig   |   5 +
> drivers/virt/coco/tdx-host/Makefile  |   1 +
> drivers/virt/coco/tdx-host/private.h |  21 ++
> drivers/virt/coco/tdx-host/main.c    |  11 +
> drivers/virt/coco/tdx-host/viommu.c  | 401 +++++++++++++++++++++++++++
> 5 files changed, 439 insertions(+)
> create mode 100644 drivers/virt/coco/tdx-host/private.h
> create mode 100644 drivers/virt/coco/tdx-host/viommu.c
>
>diff --git a/drivers/virt/coco/tdx-host/Kconfig b/drivers/virt/coco/tdx-host/Kconfig
>index f8c8cc29d46c..1395929f05bb 100644
>--- a/drivers/virt/coco/tdx-host/Kconfig
>+++ b/drivers/virt/coco/tdx-host/Kconfig
>@@ -6,3 +6,8 @@ config TDX_HOST_SERVICES
> 	select FW_UPLOAD
> 	select PCI_TSM
> 	default m
>+
>+config TDX_CONNECT
>+	def_bool y
>+	depends on TDX_HOST_SERVICES
>+	depends on INTEL_IOMMU

Do we need this TDX_CONNECT config? We can just add "depends on
INTEL_IOMMU" to TDX_HOST_SERVICES, and then drop the stub functions
in private.h. Patch 7 already makes TDX_HOST_SERVICES depend on PCI
in the same way.

The cost is that without INTEL_IOMMU, none of the tdx-host services
are available, including TDX module updates. But I doubt anyone would
want to launch CoCo VMs while compiling out INTEL_IOMMU entirely.

We can always add this option back if such a configuration turns out
to be practical.

>+/*
>+ * Serializes the refcounts together with TDH.IOMMU.SETUP and
>+ * TDH.IOMMU.CLEAR, so a device can't join an IOMMU that is being
>+ * cleared, or one whose setup hasn't finished.
>+ */
>+static DEFINE_MUTEX(tdx_iommu_lock);
>+static LIST_HEAD(tdx_iommu_list);
>+
>+static void *tdx_iommu_alloc_pages(int node, size_t size)
>+{
>+	struct folio *folio;
>+
>+	if (node == NUMA_NO_NODE)
>+		node = numa_mem_id();
>+
>+	folio = __folio_alloc_node(GFP_KERNEL | __GFP_ZERO, get_order(size), node);

Would kzalloc_node() work here? kzalloc_node() handles NUMA_NO_NODE
itself, and there's no need to convert between folios and void *.


>+	if (!folio)
>+		return NULL;
>+
>+	return folio_address(folio);
>+}
>+
>+static void tdx_iommu_free_pages(void *virt)
>+{
>+	if (!virt)
>+		return;
>+
>+	folio_put(virt_to_folio(virt));
>+}
>+
>+/* Number of 4K pages backing IOMMU_MT entry @i. */
>+static unsigned int mt_entry_nr_pages(unsigned int i)
>+{
>+	return i < TDX_IOMMU_MT_IQ_NR ? IQ_BUFFER_SIZE >> PAGE_SHIFT : 1;
>+}
>+
>+/*
>+ * Drop the PAMT backing of the first @nr 4K pages handed to the TDX
>+ * module, in the order mt_pamt_get() took it. Pass UINT_MAX for all.
>+ */
>+static void mt_pamt_put(struct tdx_iommu_pages *mt, unsigned int nr)
>+{
>+	unsigned int i, j;
>+
>+	for (i = 0; i < mt->nr_entries && nr; i++) {
>+		unsigned long pfn = PHYS_PFN(__pa(mt->pages[i]));
>+
>+		for (j = 0; j < mt_entry_nr_pages(i) && nr; j++, nr--)
>+			tdx_pamt_put(pfn + j);
>+	}
>+}
>+
>+/*
>+ * With Dynamic PAMT, every 4K page handed to the TDX module needs PAMT
>+ * backing first. This covers the IQ buffers and the metadata pages, not
>+ * the root page, which only carries the list of pages into the
>+ * SEAMCALL. tdx_pamt_get() is a no-op without Dynamic PAMT.
>+ */
>+static int mt_pamt_get(struct tdx_iommu_pages *mt)
>+{
>+	unsigned int i, j, nr = 0;
>+	int ret;
>+
>+	for (i = 0; i < mt->nr_entries; i++) {
>+		unsigned long pfn = PHYS_PFN(__pa(mt->pages[i]));
>+
>+		for (j = 0; j < mt_entry_nr_pages(i); j++) {
>+			ret = tdx_pamt_get(pfn + j, NULL);
>+			if (ret) {
>+				mt_pamt_put(mt, nr);
>+				return ret;
>+			}
>+			nr++;
>+		}
>+	}
>+
>+	return 0;
>+}
>+
>+static void free_mt_pages(struct tdx_iommu_pages *array)
>+{
>+	unsigned int i;
>+
>+	if (IS_ERR_OR_NULL(array))
>+		return;
>+
>+	mt_pamt_put(array, UINT_MAX);
>+
>+	for (i = 0; i < array->nr_entries; i++)
>+		tdx_iommu_free_pages(array->pages[i]);
>+
>+	tdx_iommu_free_pages(array->root);
>+	kfree(array->pages);
>+	kfree(array);
>+}
>+
>+DEFINE_FREE(free_mt_pages, struct tdx_iommu_pages *, free_mt_pages(_T))
>+
>+static void **alloc_mt_pages(unsigned int nr_entries, int node)
>+{
>+	unsigned int i;
>+	void **pages;
>+	void *vaddr;
>+
>+	pages = kzalloc_objs(*pages, nr_entries);
>+	if (!pages)
>+		return NULL;
>+
>+	/* Allocate two contiguous buffers for the invalidation queue. */
>+	pages[0] = tdx_iommu_alloc_pages(node, IQ_BUFFER_SIZE);
>+	if (!pages[0])
>+		goto free_pages;
>+
>+	pages[1] = tdx_iommu_alloc_pages(node, IQ_BUFFER_SIZE);
>+	if (!pages[1])
>+		goto free_pages;

You can use mt_entry_nr_pages() to fold the two IQ buffer allocations
into the loop below.

>+
>+	/* Allocate the required number of pages for the IOMMU metadata. */
>+	for (i = TDX_IOMMU_MT_IQ_NR; i < nr_entries; i++) {
>+		vaddr = tdx_iommu_alloc_pages(node, SZ_4K);
>+		if (!vaddr)
>+			goto free_pages;
>+		pages[i] = vaddr;
>+	}
>+
>+	return pages;
>+
>+free_pages:
>+	for (i = 0; i < nr_entries; i++)
>+		tdx_iommu_free_pages(pages[i]);
>+	kfree(pages);
>+
>+	return NULL;
>+}
