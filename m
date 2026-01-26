Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011018.outbound.protection.outlook.com [40.93.194.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22998332901
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769440925; cv=fail; b=oDqidIlxbmbujsTa0UA2rqX2wNS+0WvkTKg52CTtvK5npsTo7wp6GFRxmlySPxPwQv6fDRctJPvNyD1ropGkE+joR6Awv8xtNpgUNgEf3TLFyEfL3bbuuSRXdpqAzv0BHr+GuQBagkMGcRDgp9Oa3gtsmEp7tiJ5UAGfUbWg774=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769440925; c=relaxed/simple;
	bh=mdFYLopkm5/mi1yamOfanfUL6chas9DHxpAR6OW/Y6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s1QhgaD4wldZb0YJqCJjEsy+phKwGKV11ledDugolb7txyn2Gr3NWccMgsSDKOdCh8RUttAG3xLBp+6T+eMjUx1c7ObqHis10tNJwCSt15yRuC5uF2vUHTVVS+Enat6Bju89t0y88cbwmPWXVK12fhfOj5R+1ei3Wdy5GCbZi5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ARaojHpj; arc=fail smtp.client-ip=40.93.194.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ARaojHpj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dkFCf6/s+yQv1iO63/sR53P03LnhRRc0saVj5bMKO/lH5RPFbveaR++VU8nQP0+bTgHqx54pNY1SC8hqbPMl7JOS0VwTHMS+CWoXNSoClEFbXNpqIo8oX7Qr9MDHT/nWUvZkvG2zYGWnmFyDbuiRGGo4w5wl84POO7v9myPfims/GJp6l6fMAyP7jwVh57YKTeid4b/nv2iW/gNjg5S3Zn8F7e7QDCErkcKOAMRdfjk8z49kf4FKmGDxBU3DquGFWN7GnDwuz5ky8BhKvra1KSzZ/QNYF/btARk9X7ZsTM0oledyQi9V8WB7ZS/N2p/oJvvMBXKQ/fPTU3IH4v37TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyXLgeso/+R4cZvsQbu2qX5iqEF25kKRjC1GFy61Spc=;
 b=ZbgSM1llm4XTLvWA6GQaRqA5s26TqJprGrv8iDUxDrpGOc8pCV5pNJyzRWXAr/6qgpR34rhG5VRvLUuaSX0f7K1PcHKCF2OQVcT05OtnIdcXl4Z3IsITAxWyReNeefDntFUS/QDIjWwioJZvGMhbUlvXwsQvCJ6P1QZeiTuXdse6iMDeeawEE6KdYBmqIdUwTzym5EKMmTeJHzFaT4PidOH0NDC64u6l8z1tlM3+eBYI4lcrlsbiVr/sMUvscymMcJmn2FL1GXDfXFMV/1iydL5jX3eXjZX2WlnqIRRmTCp0J1GnZGdiSsxkf2SpPLrXggdD00PIGneST2dSyfKKXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyXLgeso/+R4cZvsQbu2qX5iqEF25kKRjC1GFy61Spc=;
 b=ARaojHpjo2v6/zfy+7uveFs4izHd0cNJRnTM20DFcpniSl/0bFp6m4yvGFOtBxc85rFkyYRnMWNM521xffJNioRHt3T7nZhyXsOWrHD1SFnNu/68euisvBWnQwCUXoT7e4gmDhzmnd/kvxweE69VRJ43I6e7iP/sCNKUqaLNLrm8SBBGE+TQasMH0mng74pDbUOUmNkanyfT68C5k6z/5bsve5KyT6hGz7e6SQPffzX4D3d3N4Ci9RfTyHfIsotvConbvszEYicBkpMhNxXoPbgUN1aoB4+sXXgH5IIBAt1j4PbNieyIvIVxqSFPZvyZW3/AqrEfFevMn0FR1W4iMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB7838.namprd12.prod.outlook.com (2603:10b6:510:287::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 15:22:00 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 15:22:00 +0000
Date: Mon, 26 Jan 2026 11:21:59 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, balbirs@nvidia.com,
	miko.lenczewski@arm.com, peterz@infradead.org, kevin.tian@intel.com,
	praan@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/7] iommu/arm-smmu-v3: Introduce a per-domain
 arm_smmu_invs array
Message-ID: <20260126152159.GL1134360@nvidia.com>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <8c94c5194871ee1a0f3a6b49e18818b88f51226d.1766174731.git.nicolinc@nvidia.com>
 <aXOpzjkAgODnh2HU@willie-the-truck>
 <aXOxfi8ZQAkr4zHU@Asurada-Nvidia>
 <aXO1OLrOsCkep3V8@willie-the-truck>
 <aXO2MY6gzs/lxT7S@Asurada-Nvidia>
 <20260123191654.GD1134360@nvidia.com>
 <aXeALpV1wcQk9tah@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXeALpV1wcQk9tah@willie-the-truck>
X-ClientProxiedBy: MN2PR19CA0035.namprd19.prod.outlook.com
 (2603:10b6:208:178::48) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: e50796e5-b870-4da7-f48a-08de5ceea6b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HKfGgtr0HB0cf5IvqiOHce67YM7Z/uZoAfx6R95k8l5OcpcvZnk1Jhw8FdDT?=
 =?us-ascii?Q?37BA17XG0ObwS4LO1H3N0Y+ktkr/fPaSlTUei6bif8K6Om5PfehuiQdhhqQJ?=
 =?us-ascii?Q?s1+UCa8ISu5tocbM7RT0P5Xqv8g2auAowsWBWhWupznOqTiHNjbGDVOS1mQp?=
 =?us-ascii?Q?LTYW/G7Y3H4lmC2ILRxTYIa1FYwuvFrNEGzWm3BmPM47d/BMA7ekbpBaYzHi?=
 =?us-ascii?Q?CLpsj+Hp35HYV662hcEgmpAY0BE/1/hHgKXLLHwutueY+O0QwLEfzDpQHFth?=
 =?us-ascii?Q?mD5ouc3M0Sg3iVv3EDBsnvfAGNCBFfWM6hVUJvNjGDr0dpjp3aB4Yg2Gav+U?=
 =?us-ascii?Q?tCn6XeWM8oY9qt8YOxejjYBucwPVyj0ma5ZtGFUeBJDDpRc+0q6UPDjExueQ?=
 =?us-ascii?Q?ebH70YP6LHdM3e5kzZj+YAaA5wbWoJVeNkn0JeRJePbAgNs15kLVJWyZRdA3?=
 =?us-ascii?Q?J2QuJX8vGeYylontnCyX/EeSX5dRbSajBnBZJv6kIYW+XQCthfeX9qcYojOZ?=
 =?us-ascii?Q?2N1t09eK8P89GszD5I+/qWmMitSjx/jD5bA9EQHVHRrwHtdW0gZZ7OYduj2M?=
 =?us-ascii?Q?tbc0uYZuA6aKioI3n22NDFuD2m2gHpvaSH4OE1tHl62/X1lJko0hFbKDc7/p?=
 =?us-ascii?Q?8fP872MI8SfFdmyYY2zSI52mFmvG/X1cSimfCY7zKVYMmK6mAVrfroamTnR+?=
 =?us-ascii?Q?S0afhsWxtijKAiZouhnQ4L46g4l/eyt68RgI/OeiXmYuFveYr2QGDuK4BAn+?=
 =?us-ascii?Q?8qt5f0OV7Inc87bTd0ZRUU6AfyeIgLbcaWHV++DcXo4cMTIzehjhVdOikAwZ?=
 =?us-ascii?Q?UtKNTypjCbMsMGnXz5aLf8WBNVxheMcVybiYPPcfWlVBypv0qPa5URFSBpx3?=
 =?us-ascii?Q?AXhBGXX3fGWe8IDidBEfyWu8eGqEs2h+F8R4h2GSQnLIJsjXmAo1Wz2NgJMe?=
 =?us-ascii?Q?5483VphedwNATAzTxMIpESXY+1sGlIBzx7qirwmXQcFahTA28xtCf3GJLeIA?=
 =?us-ascii?Q?jksiHxedbwlIW6XqykTwOT4rIZVM6UfW/io+ynCKDfl1b3LWCASOY6VTx9fx?=
 =?us-ascii?Q?jNMkX7aNmJz5EMl2o6alE6JzHt3FvikJ+BWaRYXYJCsopF8l7hhNxhVhvo6c?=
 =?us-ascii?Q?3zHBAk+6HwBPnmjoaG/GHHNPhxh4jhOT5BjHsEcFdAOTfe7P3C9RFz9PgoX3?=
 =?us-ascii?Q?95qMeRx/QiXLR+d17VjnF8pShxjVuheKhehUYLHoXi+FxOvukcSCVdJJDmTG?=
 =?us-ascii?Q?oWz444PNs9chTpGQ5uEa1DuMVucscqRCqfB8nUS1pbKyKpEZTmsbPxZX+Avn?=
 =?us-ascii?Q?G4WAH+SGLNes20GmZnBNARl+xlvju8jVZILc4igz2IvKI8MHjgTjqA/rljkL?=
 =?us-ascii?Q?N7ev9d00oYNXob9tdHUcO65lQICnasRz8IiEqTKMR75zIq1tw04crXk+azOH?=
 =?us-ascii?Q?TW7rKalFYBQoDjnsqKK3viPYfcaFRD1+8RSaYZmiLHhGkvpyl2DXkZPwpucu?=
 =?us-ascii?Q?G4Vy+YvR6y+Chz07z6K2Zue3VsTE6Y2BpX2t8nm9NZy/KckVuCQb9z5QjatY?=
 =?us-ascii?Q?USF9XsxrzUldGU5GZZw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QoARnM2Ap2p/Yn9zIE6Xcq6Gk4HYPk/w4W2lourNeXWMHSAk3bUPAZOh81u0?=
 =?us-ascii?Q?gb/529KsEk7m8+6l++3QHmFYhcTxdRi9fSE3lOD3/XMUcMr7ZG19uN1q8Uw+?=
 =?us-ascii?Q?m3hPxhbgdLTpqKZGalj+BdZey8dVsojWxR5FRJrTuYithRjYRMCyr8/OBfF/?=
 =?us-ascii?Q?VtcD09N8QX65ANxYyyeAyb7iHzjiIBRqW/T3JfC5EVhj6kPjXy4RYwnxUDLu?=
 =?us-ascii?Q?uxi5+EJB+7WM7Grz6kRB4xLpxrRB1CaSP0YTVh+9PFZntJ/STNYCRFrRL3Xg?=
 =?us-ascii?Q?RqEdefE++PG0Wxy6VxmwGl0Pgod/+pl0Xdo3OivsQSmW+C3PdUveKqamiSTA?=
 =?us-ascii?Q?T+I5DU1Q3IXCI4xRWDbj/w7gvorGKn3JGLm7wt+l3eGYxslx74blflJwHsrh?=
 =?us-ascii?Q?uaj9LtmuwiDt8PMM0Thp2y70pi6J+ggAQdvD5F7Rn5n4JIXJczcMWxk/2YiN?=
 =?us-ascii?Q?e+vDaCMXsULGK9tG7y1auMH0yp95lEEsv0cxyAihxSQtUbRiDlys5BwproAa?=
 =?us-ascii?Q?cN2GEFfs6E8GAiBFYCnNP46nrqZs6XWYEwX53s7uImHlVUks9WE3gNwMI0C1?=
 =?us-ascii?Q?t/NnC9mnpXrFzsIiLz2OZar+d9WFccWmGZ5apfQ8YZl4dx7Hc6Qoktp6mynv?=
 =?us-ascii?Q?K5WdH6SEp5jnUjzfcKW0Z3yAf+gGPjWC0F4ROv4WpArBwZbSv9ABe/+JVQH7?=
 =?us-ascii?Q?PuD3XufkQdar2fNjjWDZePHZ3vHF1juRMf1cl25i07+nHfgEomhi4Tw5SYn4?=
 =?us-ascii?Q?+ab0979ro/lEJKv+gf0e/a/RoGYaREnV9smG+vLxYMRMaDiDF0F9F2+oxSRc?=
 =?us-ascii?Q?MPLPmn+FYSUcQJpCkkLweiylSvP1lCZKaDlz6J7XsXDRMn8ugQlgcCNoNBwN?=
 =?us-ascii?Q?g4OzXuKbKQptvE2d7xg7P9RFgFULoiiPidu5HIdmfWOssH+SbUTI+2pXohdR?=
 =?us-ascii?Q?B+imau4j/EqmpdR3NfrvLT1gLJoDfjlk6jGIKrAw7e4iUXLMpGxMKE5PuFog?=
 =?us-ascii?Q?vUOcwRppDcPBvGq+a1myo8hpN6ckoMeZM6CMkBKtBHmuTB88l0lWmFAxDdPI?=
 =?us-ascii?Q?UkNIZY00F8uH6ubfTM6WLl7SJrgVdwaPcJ6wQVWSHmTJtBKC3J7bE0wRQ4qK?=
 =?us-ascii?Q?XMs49zswSZFLn5k2RJU1HG76HbXQUcnow42Q9CbG1zP9b2uGcgHW/Y64dcnB?=
 =?us-ascii?Q?fwVTZ70wtgISPW11DMNJrh/6I4nJWkMg6yGC8hDpa678X5Mxb6G7IIjqR59v?=
 =?us-ascii?Q?lhR9x4TxJSyEeIcheaW9oBXQwFogXDM0u3yhpUSV7RfNDnFYNXf3IkfEmqq5?=
 =?us-ascii?Q?jB55Rk5K5wGNC1hpbxYJHzV3Mbx+J09X7CjlYcqFuL4TAE9Jdtk0e9o6GHqk?=
 =?us-ascii?Q?rhLq2Ea385zJpbH+Aq9eZmGxaV5AeuAOyNqNAFX4UxEra3cR/icRmU8EYvH+?=
 =?us-ascii?Q?db27mdR9KAkaChmvjqvNgHGpFeSW4a7vc0dcFhLBJxr5HTmgWLEef/y2cIy1?=
 =?us-ascii?Q?cJwPtkILpzTrhmcFUHA5fMHcEn/VatWeoJ5SIIjPRHKxxqztFVnLGD+vX73W?=
 =?us-ascii?Q?8+wcvCnUFj8gUIP5rnx52BtsaitCfLzI7sEhIq8jalpBm/feJwykBKk7tqBH?=
 =?us-ascii?Q?oRKuaJngSpRGUXDPRRW5oRE32ykYWov0TIWo73Ro/COc+3UcDUuIH+w+gyN9?=
 =?us-ascii?Q?/dxAOnCuCAEaTzz+45KrzEA7rp++eXhpnRD/n00LKtIvZubdZsreMGQ5lpdO?=
 =?us-ascii?Q?ojk7PH3ifw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e50796e5-b870-4da7-f48a-08de5ceea6b0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 15:22:00.3018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxaaA4Eam8pIYj3j5c/xdV8k5f4M1pKF7CVKol5jcc0hQ0Wi4TEWT4/CshXGEHLL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7838

On Mon, Jan 26, 2026 at 02:54:38PM +0000, Will Deacon wrote:
> There's the usual scary ordering worries with this stuff, but they exist
> with refcount_read() too. We're ok because cur->users is address dependent
> on the read of the invalidation array pointer, which is RCU protected.
> 
> (I think!)

This has been my understanding at least :\

Jason
