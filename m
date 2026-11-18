Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794986234;
	b=GtcMJ//GXKf3nHRP7ju7aPkSiTp7hKtewbKFIl+fuu6oU+6AD+/x89bfynlMrRYcvhyj
	 YN0ruMzQb8EabAN8chUBokWkiigI1NdnVj8EyxvIaYQOkV3CuyfZ+BCYpunjUHkpeAdC8
	 pKdbMoCYwdZYMMSd/hkmX8N/JuQP+FZGQdSq2+YodqecaHM1aojZS0fi2roJvTJzhj6KQ
	 xaAc0Opkq0EPnDk0LgkK9zAzlR4a+ztIQN3E3xUMm0X0F4BMkFh6pxtIJ0m2cgyo4d0kq
	 8TS/NiLGo7zSKd4Cb9UiacTMPRzAz3tZHlIxojn11wqPyYNn5b1wXCVpK2Bac8cdNPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794986234;
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
	bh=H9ILnwOp/IC9MY4nD9AREHxO3WpFvX4B+toldnjeBGY=;
	b=HJJXGaQjjhVRlmOLesDzsETTE3WKSjpxDh1Bd/IbumyQaIm34Q8EnBHb5pEm6RWlBQDD
	 Uk5QYkRUIKfAtJuCC/2BDPELpg573ZFEY1Ga3hRNTRyJzlXnnYyEesQSV4YgYhMzvYnQX
	 IqX052PDsKydQ+2tQGdh4OlEy8s5xkwG3o7QIhdUERapQkuqGgWmsVk8lp3U4p/6aoXc0
	 njoEBfLCvV5/LGRlkyXQ1a4gdZNtdpOLDBM8TtZhpCGR7yIlD+e0U5SCa1l9sZZW3C4sM
	 X2MUcMLU3O/tfttWMe5OBzjsqwH30uJ+IhJSSOeVysOoqEMW5dLWlFgFwmLmsZyS6HQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g60zQTgC;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=b5OgPo9p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA16606A31C;
	Wed, 18 Nov 2026 07:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDA16606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g60zQTgC;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=b5OgPo9p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794986232; x=1826522232;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WOdHe95YWhNwIsprROwZXgg9R7KRhzqRYe08kCkTQos=;
  b=g60zQTgCS+Osax1kqWsEelw55ATxZO2a5izgc49StgbIm5AeO/RoVnyX
   tSyQAz3ZNWWKaebE6AdP93eV69E1XfPRoNqMhg4ILccupb+6uiMH/oF8i
   oo311SzQnYU2h5GNGAl8c7xNeTjXyz8vKL/UTrF4xfGgswTmoZWdSvS6q
   oN+U13gw5jMk76JzYwR136el6ynI5abD2OxY6qp6ngBXyosZDpAjk9jdz
   bN7Md2TUl0FIfwtq1EwakfUmhq4V+aCK5kUjo36K4Hff/FUgDtWlqRC96
   71JZ3OwtztLSGPelZSguZ6pcdh6MbhHTJR3Z01ZEMe7org98K1ksIbFB6
   g==;
X-CSE-ConnectionGUID: 9MCHTmuRS1aH+06ID/DciA==
X-CSE-MsgGUID: Y1MSDUPlQ6+Z+zrgWiO8Jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3776908"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3776908"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 23:17:12 -0800
X-CSE-ConnectionGUID: 5MRaHwJUQxWtcgpakOjsqw==
X-CSE-MsgGUID: qR/nd/btTV+qvkgmTsVOyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10133688"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 23:17:12 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 23:17:11 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 17 Nov 2026 23:17:11 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.21) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 23:17:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=au5OXORYco+5T/8mKWycz6I8bDoZ7N42t6TXVvxALhYQcn1O/iLQVFV8LiCAVvs8ma3e03fzS0kixEnrovz1CjOfECpeG4T659wnch6GisDw5VbLo4MdWPrtnxrlQRl1mMEEYBHuoxgQX0Kz/EQu3N/dfJQj5hlxvOw0bSXTRTEvaXFBZRtDLrK7sf4Su13a9KlfabotVe8EYDbjT0ZEmoKOQi2KkMUjWeBOE1T4gCj71W7DuRp/sjHfs+K53CIYNN3HK+Db0H6QTDO7D7I8nCOnNn1gJbsmHqjszhwcZDGO9IuJcjZ5nfXuXUhCL4abIGaJLT5+nbuzXPHrYULspw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9ILnwOp/IC9MY4nD9AREHxO3WpFvX4B+toldnjeBGY=;
 b=v8DuMuTBciOgEupUMJea8hHFGhw7PSWGeAbTsZfZ1wfYk9LM/3yYPZsVoqG53L9lyCKM3IgSv4MW7KZ9H3XtZrRI7NjBaLWPiwoAHT073OzZTtBdFTf3KyP7TuIhCCX/Hs/Td4davHr5wObCQCZJC5QNjKZPn9Qyv22w8oRTiMacLU1a6w81IKHwS4nBCWT4sitviIV2yPbVbrnh/m2yHrb/4yuSClbEp4BTU+nxBwomIrekxjqrYRBtNHn9ejgJ0N9CqmxP3A/JGjwCYXxaEG+KqD3C7lk6/+xiimRtwJbAEKjQiel/v7xvNAKd21Rlg/XMXAaQPXyhgwKErbqY8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9ILnwOp/IC9MY4nD9AREHxO3WpFvX4B+toldnjeBGY=;
 b=b5OgPo9pNceq10bvsW6qZMZaoH9rLs1NHtJW31PCQsJgyPg8fdpgtVBTuTDFVoAR9MYCl0wBCXgWyZrhCIV4IK3FODceFZjZk3Dpr5gioBP4fRCkG3E0zkWeOuGz1nD33EEumJurbD4lca4uxgq3OJRUWKskQPoQC/SIskom3Mo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by SJ2PR11MB7647.namprd11.prod.outlook.com (2603:10b6:a03:4c3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 07:16:33 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%5]) with mapi id 15.21.0615.009; Wed, 18 Nov 2026
 07:16:32 +0000
Date: Wed, 18 Nov 2026 15:16:21 +0800
From: Chao Gao <chao.gao@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
CC: <iommu@lists.linux.dev>, <x86@kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
	<kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 7/9] coco/tdx-host: Add skeleton to support PCI link
 encryption
Message-ID: <av1QxRYY9sXtC--P@intel.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-8-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112043054.2664857-8-baolu.lu@linux.intel.com>
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To IA0PR11MB8380.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|SJ2PR11MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: f3becb24-264c-4674-e1e7-08df4543df6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|7416014|1800799024|10067099003|56012099006|261026140227099003|4143699003|11063799006|261028144727099003|261021121427099003|261022105027099003|261022075727099003|261026121527099003|261021123027099003|261102123227099003|261009223027099003|22082099003|6133799003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: dVMx1qcAfEjW/2gY+vNVs2gS6/dp4yWJvUrrXTOb96GFs/wi4YDBPqq8j6S1LAEohXcKR7NzFm1/G31VzutVQoiC/HuoTn+QALHif+0DrTUxnSY7ZFeqlL74aLMln4r3jKbHZIs2jdMzmP5TS62Aim9JDqlGu7vgYMJ8APi77okRQNlT0r5/RlnJHcu7ARPjbJq3Cxed0SRvlnCPqsOsqaijOtD+REGL561qjrzl42qOCeiY5PNWGlzAaMykcgC/z606cRe/3A4pmsoZ93eHtRyCyUJKtDVl6wNiAS6+CbFKIdLAVnK6oDenoTvR6RqcH9PbscS8cBVL1Dn4XIVU4j3n7NCc8kIScOkC6e8XNiOfnjPv6Byg1Jv029UC6FYh/mUc6Mqf473F3+ZAnF3ZGuUvxp9IiX+bPROvVi977triv1nQ504SOolOIXpYwrCgpbHjzvyXEPe9hXP1EWO+jW4/okPAz+y5B1v9vQSMX8J4lMfJyy0HA79HYDpUOsKCQvwmakqq7dHIqppOk1lLRe9giBTlRgSiMg/Nads1iKcZfkc7hU32PR56Ji+QAQU0Eo67u48n+StGv/1bSK0FEOle2+N09/6WGU1ldiBBYtM5kaGqc/0umZsc9uMxgw6A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(7416014)(1800799024)(10067099003)(56012099006)(261026140227099003)(4143699003)(11063799006)(261028144727099003)(261021121427099003)(261022105027099003)(261022075727099003)(261026121527099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(6133799003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qcRwfEnnZucuwhn7JtXCktDld+WlsAwlLuzLcWjH3hUP6ZQBWWVb7u6wP5/P?=
 =?us-ascii?Q?VOiG+j8ciy/hYj6IdIqvqNY0q3T6kxqTpSNnGleavGLfpzSHYpJrXGNNk29w?=
 =?us-ascii?Q?atuUcVCaA5URJdUpBsCoXTw0px9//Dz430FHIfZGKCQjFRFqbEB+03xeRqRJ?=
 =?us-ascii?Q?BNNK7m0q8Bgxs/EdQr65UhGIsuhJHkaQxNQofUCRvxqXzujnx/PH8M3zALmx?=
 =?us-ascii?Q?OHo2Phn9zKAEPNqYvRs4qf6Al8rdqXVH3D0iEszvowEk3YHD6bQTU7HSVwQL?=
 =?us-ascii?Q?9/l69maPwrksJJ6fA7LA4hlhkkdkdzcz217VPDFhLHVz30d+MATuNXc8RL+m?=
 =?us-ascii?Q?o6PSBRqkvaEQBp3Jr7R6oq3SoQJMQxuvEWJQtHlwHRPwPpIi4JpMYl8Yii5R?=
 =?us-ascii?Q?cZvbDJDZgKlOlAaKYHGAXfXmwCQRWZmy7rG3atGw8rYbUbZoW+QdKfPMcAWi?=
 =?us-ascii?Q?nD5wMFf0R1hxLNR2qWj70NxE1MLiir6iccNJju+Bgli2ROEuP/r97fEKlzCV?=
 =?us-ascii?Q?GmPOSBBRE9Pvl/ORRSwOiN6hs2GqebDES+pq3T0PG33nWR5+iNB7NC9cVm8X?=
 =?us-ascii?Q?MTU9Y0c4lIVTC0ivSJZOyEydnTscxB7JpR1k8GcMJHIeCL0z0HcclRyuONPr?=
 =?us-ascii?Q?4pJ90XjRtwqyHavruGtso+li8/0iE9K5OWn5VmmXzAPB9PB8g6PA+Wevjv7a?=
 =?us-ascii?Q?wE48ijCGA0r9QfABZl5dvU+IJPdw5YEX5QaD95HUlQa/0Bs6gD0V6+C0ayud?=
 =?us-ascii?Q?WKq2i9rWcvjZDOhrNt9i8wdVSKsErLenzn+eBJjLzkmDdGLRlXNUFWfi25oe?=
 =?us-ascii?Q?GmZEHxDbvo/rdr9rmLP+ZGVe2w4YR4uCPlwLUJDh4FBTs2qrtArAZpLh4v13?=
 =?us-ascii?Q?H3GfdzQgb5WMCNXY2YUz86kXxOC4/BCEWec7FwLUqApUJb5RTYXRkDW2Q8cQ?=
 =?us-ascii?Q?qL1/+htTXJmQG9y+OcW5xsuU9bi/necYSVc1XL2VOqtoyxHzWGt+Es6AKJa/?=
 =?us-ascii?Q?zzpapfMv/3Ouono9ZUGE6XQ5a+trIrFjTvDhaT0yYAbFwMiD7WjdbBK5+ne+?=
 =?us-ascii?Q?mR+ZHof84DGgwINXvKOiLtny23jV3uCGczr8cH+HY6wFukdBUVXwZFR6+9y6?=
 =?us-ascii?Q?TCpZ057gRRrsMxidNdzIU1eqZXy2UZiWTzIEi2s9r0O450vdhU2XvyA98l6D?=
 =?us-ascii?Q?4LuxClIM12qm6/nyxQbOaA2QUVzsfIktWIOwnTQ/Le8pXjkRCpxUIBYz7eFT?=
 =?us-ascii?Q?EGe/HO/8LPvUlRQ45s4c1lyRYNl4WMjdB9gx5FTSijKG1B9Bbyp/WTMlF0HH?=
 =?us-ascii?Q?lWg8jxfcXyupJYV8QwEvG3KDWkjOrfFOH6UIybbLYPqXozwDOPsM9RXjNbYy?=
 =?us-ascii?Q?XyHBI0tl5HYBHjWFwMTx7TU6hMHv0vd64u/hwFiz96Oj8of2LwtfFqVaU+bu?=
 =?us-ascii?Q?m+3x69+tvp0APzK0ma8nb9/SVi2BnyDNQO6hxelGeO4wmCah/Qc/BMSGVa9n?=
 =?us-ascii?Q?XKHWdMH9Fp6cpJLme/NEdVdYU5UoNCDlsgF5ksJAcnt1M0XX47mghvkQ9EHE?=
 =?us-ascii?Q?wttuxCPAwRbObKASQ3NRzJZS6wwN5Cgw08ZwTJMPD3Ri0v0SohkCeyh39uWs?=
 =?us-ascii?Q?fb8tILgJA5pZ5K5RikT3JNLl8h4J1t32hpxrjGGpwsvOZDpfkKAqwN72cQ0E?=
 =?us-ascii?Q?ggfYvnMBvBQFfi43k2YW/foWwf2+uHhLZEVnHaqJNSBXlw7lP22KmPUP4OXn?=
 =?us-ascii?Q?qiMp3ch00A=3D=3D?=
X-Exchange-RoutingPolicyChecked: 0bDNT0KcW9jG6RUyPHih0BYt5oYVaGTb2fEsOjXZqmrffOk8cnJQpGz65VFg3RTxmy0OmCioB9IyZ+5EAxG34X/Ryzw4C8TaJRaYbuorR+np5TSoo6F5dy+7VyvneQ34ZlU9323948aGmcuxfo1DnL8Z7RiYxfv4j8R9dwOFEmHeq9WjF0/uUEdJILkBbGq4BkhUocLWnbRiH3AYWixnB2zqO/it76haYPZOJBfge2nT/MIocOhRVEiSPmH7vlq2hNyz5vDLWjQiG0hB0YoBp/1ir0yCLvJWuXCasn8WznsSF5J5GfEVlIpJm+zp9Ok8zprxYU086gkAU/n8+/ZiiQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f3becb24-264c-4674-e1e7-08df4543df6b
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 07:16:32.6172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUiWlEzMu5yIvA3eWHIxCirFPTz91ELXgqUkq7UqixF3nviyWDmc6/v+gnYj18MGWaskW0AJNCjlebWO0Ppaiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7647
X-OriginatorOrg: intel.com

On Thu, Nov 12, 2026 at 12:30:52PM +0800, Lu Baolu wrote:
>Register a Link TSM instance to support host side TSM operations for
>TDISP, when the TDX Connect support bit is set by TDX Module in
>tdx_feature0.

s/TDX Module/TDX module for the whole patch. Existing code and docs mostly
use "TDX module".

Also s/tdx_feature0/tdx_features0.

>
>This is the main purpose of an independent tdx-host module out of TDX
>core. Recall that a TEE Security Manager (TSM) is a platform agent that
>speaks the TEE Device Interface Security Protocol (TDISP) to PCIe
>devices and manages private memory resources for the platform. An
>independent tdx-host module allows for device-security enumeration and
>initialization flows to be deferred from other TDX Module initialization
>requirements. Crucially, when / if TDX Module init moves earlier in x86
>initialization flow this driver is still guaranteed to run after IOMMU
>and PCI init (i.e. subsys_initcall() vs device_initcall()).

This changelog is outdated. TDX module initialization has already moved
earlier in x86 initialization.

>
>The ability to unload the module, or unbind the driver is also useful
>for debug and coarse grained transitioning between PCI TSM operation and
>PCI CMA operation (native kernel PCI device authentication).
>
>For now only check for TDX Connect support in the TDX Module and
>register the Link TSM. The TSM support is basic boilerplate with
>operation flows to be added later.
>
>Based on work by Yilun and Dan.
>
>Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>---
> drivers/virt/coco/tdx-host/Kconfig    |   2 +
> arch/x86/include/asm/tdx.h            |   8 ++
> drivers/virt/coco/tdx-host/tdx-host.c | 118 +++++++++++++++++++++++++-
> 3 files changed, 127 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/virt/coco/tdx-host/Kconfig b/drivers/virt/coco/tdx-host/Kconfig
>index 57d0c01a4357..f8c8cc29d46c 100644
>--- a/drivers/virt/coco/tdx-host/Kconfig
>+++ b/drivers/virt/coco/tdx-host/Kconfig
>@@ -1,6 +1,8 @@
> config TDX_HOST_SERVICES
> 	tristate
> 	depends on INTEL_TDX_HOST
>+	depends on PCI
> 	select FW_LOADER
> 	select FW_UPLOAD
>+	select PCI_TSM
> 	default m
>diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
>index 0ed0062c9b0a..fc284a555984 100644
>--- a/arch/x86/include/asm/tdx.h
>+++ b/arch/x86/include/asm/tdx.h
>@@ -142,6 +142,14 @@ int tdx_topup_pamt_cache(struct tdx_pamt_cache *cache, unsigned long npages);
> int tdx_pamt_get(kvm_pfn_t pfn, struct tdx_pamt_cache *cache);
> void tdx_pamt_put(kvm_pfn_t pfn);
> 
>+static inline bool tdx_supports_tdisp(const struct tdx_sys_info *sysinfo)
>+{
>+	if (!(sysinfo->features.tdx_features0 & TDX_FEATURES0_TDXCONNECT))
>+		return false;
>+
>+	return false; /* To be enabled when kernel is ready */
>+}

Patch 2 open-codes the same TDX_FEATURES0_TDXCONNECT check. Can this
helper be moved to patch 2 and used there?

>+
> int tdx_guest_keyid_alloc(void);
> u32 tdx_get_nr_guest_keyids(void);
> void tdx_guest_keyid_free(unsigned int keyid);
>diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
>index e8ed8dfa526e..0908aaaa28ac 100644
>--- a/drivers/virt/coco/tdx-host/tdx-host.c
>+++ b/drivers/virt/coco/tdx-host/tdx-host.c
>@@ -9,10 +9,14 @@
> #include <linux/firmware.h>
> #include <linux/module.h>
> #include <linux/sysfs.h>
>+#include <linux/pci.h>
>+#include <linux/pci-tsm.h>
>+#include <linux/tsm.h>
> 
> #include <asm/cpu_device_id.h>
> #include <asm/seamldr.h>
> #include <asm/tdx.h>
>+#include <asm/tdx_global_metadata.h>
> 
> static const struct x86_cpu_id tdx_host_ids[] = {
> 	X86_MATCH_FEATURE(X86_FEATURE_TDX_HOST_PLATFORM, NULL),
>@@ -20,6 +24,112 @@ static const struct x86_cpu_id tdx_host_ids[] = {
> };
> MODULE_DEVICE_TABLE(x86cpu, tdx_host_ids);
> 
>+struct tdx_tsm_link {
>+	struct pci_tsm_pf0 pci;
>+};
>+
>+static struct tdx_tsm_link *to_tdx_tsm_link(struct pci_tsm *tsm)
>+{
>+	return container_of(tsm, struct tdx_tsm_link, pci.base_tsm);
>+}
>+
>+static int tdx_tsm_link_connect(struct pci_dev *pdev)
>+{
>+	return -ENXIO;
>+}
>+
>+static void tdx_tsm_link_disconnect(struct pci_dev *pdev)
>+{
>+}
>+
>+static struct pci_tsm *tdx_tsm_link_pf0_probe(struct tsm_dev *tsm_dev,
>+					      struct pci_dev *pdev)
>+{
>+	int rc;
>+
>+	struct tdx_tsm_link *tlink __free(kfree) = kzalloc_obj(*tlink);

tdx-host goes through the tip tree. It looks like Dave prefers plain
error handling over __free() [*]. I think we should drop __free() for
tdx-host code. Same for tdx_tsm_link_fn_probe() below.

*: https://lore.kernel.org/kvm/691e16318f5ea_1eb85100ce@dwillia2-mobl4.notmuch/

>+	if (!tlink)
>+		return NULL;
>+
>+	rc = pci_tsm_pf0_constructor(pdev, &tlink->pci, tsm_dev);
>+	if (rc)
>+		return NULL;
>+
>+	return &no_free_ptr(tlink)->pci.base_tsm;
>+}
>+
>+static void tdx_tsm_link_pf0_remove(struct pci_tsm *tsm)
>+{
>+	struct tdx_tsm_link *tlink = to_tdx_tsm_link(tsm);
>+
>+	pci_tsm_pf0_destructor(&tlink->pci);
>+	kfree(tlink);
>+}
>+
>+static struct pci_tsm *tdx_tsm_link_fn_probe(struct tsm_dev *tsm_dev,
>+					     struct pci_dev *pdev)
>+{
>+	int rc;
>+
>+	struct pci_tsm *pci_tsm __free(kfree) = kzalloc_obj(*pci_tsm);
>+	if (!pci_tsm)
>+		return NULL;
>+
>+	rc = pci_tsm_link_constructor(pdev, pci_tsm, tsm_dev);
>+	if (rc)
>+		return NULL;
>+
>+	return no_free_ptr(pci_tsm);
>+}
