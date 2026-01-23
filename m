Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C6C26AAAB
	for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185664; cv=fail; b=czSSPatSBvFsLsCvj1R+2icrK6vdJY0wOJFzKzrH+rxW9VuiXgB5aM15nU5vXSTPOA33s2dGNpFwSXl6skfotoz2CiJmgLk0CGV1+QQoU8A0+jlKz0L6hi+aRdY3xTfJYyXXh6Kc5G9NYp5IkSGQhTiT8lH6rl507rd5HmRDxpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185664; c=relaxed/simple;
	bh=dmgSPU4Z3zCT8c74Gwf1z+HBe0Gtifa6oey7G0UC4/4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DFeKqAXEssb5ytX/8QjgolczTVknCQ2ZbTCXfKfhJ4cJargnotYTyHwjbsM7n7O5XQQJtFgsjgsuNdFbQ3G/b0JItxx9C6Z2mEeAXglZ3vQpOWaN3P6Kepj4csxBzFoPW43ShSiHwybk+swgrYI0LdGMB4K8WtKMqhFKPSTjzl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KJGhLwou; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KJGhLwou"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769185662; x=1800721662;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dmgSPU4Z3zCT8c74Gwf1z+HBe0Gtifa6oey7G0UC4/4=;
  b=KJGhLwoubdkuZa38jsXD6dF9fJ5WZoGXuBKT3h+nO+Nhnfyhped00+jZ
   VvV5ClQELfj6oRhCOOFXk1EYJJgAKjs/SVf7fT8jLQhF71wF9JhOtvv7K
   YEKiEGMv0PIQoiitBwzz+KeDOwvxJ31d5qCNZ4evDp1PRzzPeD9vU8UQT
   bs6hD2Xq5WFPXX3zShWkLLVSMgWazBKI/Gzf9952774GwVKuioWBZtVJp
   pRBew4FL8KLh2ha3v1dRJutuRPqyhz365ygrEZmF4j+RoacxLAfP6nWhF
   tQyXu7jXBCCAsoXLGetEU2rs7Mz1PXN9LwasD22X4EUiwDfRqWkeQmZaZ
   w==;
X-CSE-ConnectionGUID: j2CyOtS6R0GohAPFEKA+jg==
X-CSE-MsgGUID: HUCCqqA7Tam6lZ1cE9UAew==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="70415395"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="70415395"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 08:27:41 -0800
X-CSE-ConnectionGUID: ae/LGKusRc6dvX+I3fy3jA==
X-CSE-MsgGUID: gV/zKMjSSzWePUFhLkwXKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="207482205"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 08:27:40 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 08:27:39 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 23 Jan 2026 08:27:39 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.7) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 08:27:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEn7kH1WRben4luuf271o2wNwENmFssmoh2eL4btk8Hv6wViRqzSNwEYhpwfYQhemSZjhI4a6a4UWNI9K7SyUu5pPekAZ9S7BS2D/dBl+kj4cWkv6SzlOWeEPZRScdKlGcwDnRQ7qOgS+4ERp3s8PBlhwrD8q/D8E5aQ4zMQJttnIFNXswF7KcRb8n48PNgMaRByeRobQfI7RkOFc4Hlta3gx4JZSoFtmnkPprSeIxPfCUlUVrSKlowVEeYUGRX1Jtg734HP4Rh0lnPtyrkvCjqVtae3+nstXo6dsveF5J1aYHVZ7SIJPaJ0cq8ONYEnKoloNxAR/X3AWWsQRV1NjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jViB9Qqw7Mo/MUXi5qxGq/0fO0X7pERZCLcezTy4EEM=;
 b=vWDfDAQLA+8YlnY2gdjx6nu7D01b7PQge9gxnGUElnKfiRb960AxCibw8B9A+AH+QHCuOCYEyWk0KdskoKFaD29GVkBkg40jG7vA1SV4k/6O+1FwG6L7tPMqWG0iF41APOh5SwVSwdTTDA19i6q+DJ0jd9wOhan6mh2NWkpb0OfUvGckOrft2vpWxDbcR2r9WLhqtzhIctLrIdoQpilO1P61+3m4iMk6Y2ibX//6Dn8O+gABefXo85IqbxITPKpOz43TrwAewaUZ8YFMEzUW6IZA87j+SarlLHDIiER9rrwUF3btu6u1tc/ke0iXf5dRFEU8mmvIu/b+kFxHCi6aSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7828.namprd11.prod.outlook.com (2603:10b6:930:78::8)
 by MW6PR11MB8437.namprd11.prod.outlook.com (2603:10b6:303:249::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 16:27:36 +0000
Received: from CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::1171:db4d:d6ad:3277]) by CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::1171:db4d:d6ad:3277%3]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 16:27:36 +0000
Date: Fri, 23 Jan 2026 17:27:24 +0100
From: Francois Dugast <francois.dugast@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Matthew Brost <matthew.brost@intel.com>, <iommu@lists.linux.dev>,
	<intel-xe@lists.freedesktop.org>, Joerg Roedel <joerg.roedel@amd.com>,
	"Calvin Owens" <calvin@wbinvd.org>, David Woodhouse <dwmw2@infradead.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Samiullah
 Khawaja <skhawaja@google.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>, Tina Zhang <tina.zhang@intel.com>, "Lu
 Baolu" <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>
Subject: Re: Xe performance regression with recent IOMMU changes
Message-ID: <aXOhbK6Ed9WPbz0u@fdugast-desk>
References: <20260121130233.257428-1-francois.dugast@intel.com>
 <20260121131135.GF1134360@nvidia.com>
 <20260121180449.GA1490142@nvidia.com>
 <aXHAcibp/4pUB8f0@lstrano-desk.jf.intel.com>
 <20260122133131.GL1134360@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260122133131.GL1134360@nvidia.com>
Organization: Intel Corporation
X-ClientProxiedBy: DU7P190CA0025.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::32) To CY8PR11MB7828.namprd11.prod.outlook.com
 (2603:10b6:930:78::8)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7828:EE_|MW6PR11MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: ec0a386e-00de-41d5-0434-08de5a9c51c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T25H/y7UgFLqKyfA59GIjzt5+1EifqhFSriv3jWqiKTC9ANaJ5Gl6oaZPYn7?=
 =?us-ascii?Q?axTw78KUQIHpB24gTbrBkNW3Dmpco9oWMiQ9Jm6ekBAO4JC0QDlOUt4N3Pxv?=
 =?us-ascii?Q?14JxRlEFH7/b6AdGB9lRCoQUdSWc2zeb0zPu2d98ieVPfaZ+BR5q+Vw8GXcF?=
 =?us-ascii?Q?wUAfFK+3FJ/Jb+CXcOkKxu6Ms8XuoA2GZ5FDezc+Yq5mIrwwhE5joP3fupe1?=
 =?us-ascii?Q?JW/4vgwfOdNAlFjNUGbhcM/PtEr4gRMkGigrAIqAdGa354btM9UWwAqqMDsI?=
 =?us-ascii?Q?1V6FETaveQ9lMaXildFjEimSlx+v2B+Ufck8qnUiXnHbffV/Hcoz+wENr3up?=
 =?us-ascii?Q?E0wxbAfaNaXKEjEWgH4Vr0vG1DjbQHWLf/9gyQcqqAkfHBB9PbsoELCOgqlo?=
 =?us-ascii?Q?sejc3VByZGMPz81MWwOuCL2Nktj3WmGZjtMjBNlBwniYJLDvsX5bf/Y5qJ6w?=
 =?us-ascii?Q?wt8Y9T6Xed1r9UXofS2afnVI8cfGHiYYwnmS7vIESLscUlP9gAov73Nlexii?=
 =?us-ascii?Q?j145+bWaZlJL7gBThv8jM0jBfbrVEUMnR/1tB3g7qJw8fqP7tzrQu+cXyJYE?=
 =?us-ascii?Q?xX8H+u+1xb7xSfxUCOiLbmPXB1mz/eSzhewgz3M/GhoywfPhxCHg64AxqiCv?=
 =?us-ascii?Q?/x38VWTpkxRtR8+FnySWuDsOQAAwV4ltCfTo2Y0yjmaAAicvsr4yOsQd1GXX?=
 =?us-ascii?Q?Wo0cjJXDekM1eZYy8i56sDTSxuNXa9uFDnvGy/mbkiO1ap31GlXJ5imC/xO3?=
 =?us-ascii?Q?wzzLVbkEoUiDVC100WZFcRPbtev+aGz7ZcP2TjLKTpS+jmiXtF3wAFJQ+BOw?=
 =?us-ascii?Q?dK7b6N/BURU2SAop7X+K8sXq4BZ8zeWU2Cxo19aE6Cui0p7r5qRPzHgZpY5+?=
 =?us-ascii?Q?WphIqA7UHqvFjozWVh9WJXsK72fNF9lxj+1AnJGxuszFsxJlkHYa8jd9mkIS?=
 =?us-ascii?Q?EzSVDkjbBcJMcbnwla4eioa5ZamxTBhbXdc9y+hh3V1C/FXqLpOnW55gqdMW?=
 =?us-ascii?Q?IY/iCLPcXq8Wp4rmZGq56hA755S8WtGQ0VWTEcdLwnWM5Fw7RDBMT4DzQJ5s?=
 =?us-ascii?Q?5o6/ckFivP3FkvaHdXeArp20pjmWs14BqW5JBnEW4mD1f1hIrEDzZW3JvaFs?=
 =?us-ascii?Q?GpLe9AWOELTrukHylflb+KRYY9LkFbUneLNKScQBdRueATBgVysDDi9JwEaz?=
 =?us-ascii?Q?Q5qYZkxpR2uIM+eRDVeBkj5Wu8kX9+167+iEpYz9IcdcNP0CLpkPv1I0/kgp?=
 =?us-ascii?Q?LlaIIfYdVXUERouRnEeD9mQbm66Tsbq/cMUF0K9ewAlqSp4fVi7+H4vLCG28?=
 =?us-ascii?Q?KC6YuWA9jf+tFwgieYT15ixoyewQlVZuEXjJ781I3mXKASnb3DZmHXVd2rhQ?=
 =?us-ascii?Q?jE6XEOfckFHpVgvPMmSG2t+UAtN10Fo2WpjB9trcOO8JQ/wBr6XGIfNpCbPy?=
 =?us-ascii?Q?uXy37nS3Vhja/X/ejgbb5Rywovv9qvRVWwxqsCrq6w4/BMPsyTUKW8tr9kTa?=
 =?us-ascii?Q?4lYRrReH1ZCPi37kE0SGkA5D04HobkqOAryXvD2SEYnN6Uq3tINPSAkPUp4F?=
 =?us-ascii?Q?QtMuLvG8iV9cEiURBMk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7828.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TJmeptNJpzq7i6Uulo4yJo2/BCAMSCQGLHQq2H9pAT3mCjUAi9sb/Gl29v/w?=
 =?us-ascii?Q?BYTZYpjhLH6Sl4ll0DzJanooShoBxl3o8qIKWBziDcjl6JTxwKIEcFm5sefx?=
 =?us-ascii?Q?2u5FPk6rXJ4X0l65UKQ5zqv6stPOvgCZLb90zf0KTdfXjV7BXwGS/Iel/xIG?=
 =?us-ascii?Q?+ulLpWXKSgiRJZ1l2UtvJULH3KUlCo7gd+gDBoNyX2rNo8IO3Iqicknbk7m6?=
 =?us-ascii?Q?WySavTwgGC/3ZGJjL8DRIZoLYwb/jcHUy71mOzvQc5Q/seMIvKTqvbvJ/GYq?=
 =?us-ascii?Q?xJA3ecTqZ800V1IJD1zJ7FCpgkUIdNb4o2cLDQ5BnrLHrBrJLtq1Q6topVoE?=
 =?us-ascii?Q?qM802DrQ5Bw2X0kmP5KdkYz9y0ZSCdAIChQmyGGlrXqrDUUA6pAnJQJNz3jp?=
 =?us-ascii?Q?XRU7Chd8BpgqsyadPgHOh0sVuusq3HhKBYTb+fr90n8Z+cnMEgsiuVm+nkei?=
 =?us-ascii?Q?sEksxM56YWu43MF/oKxscrsXUQX9R6Bm2UUwf7+4nSGoF5dkIgZubmZm8RuO?=
 =?us-ascii?Q?CFtr0noC38kfCr0+01Jit8nQT37LQgiK18bSx3rWthxz/hOS1+lK1QuwYvx2?=
 =?us-ascii?Q?gVvLDbsL3yWoR1JW2YA1DM5m1i6SUvj+IcDBATgqOgNDTSL7PhxCKO1RrHk2?=
 =?us-ascii?Q?xiJpq3nbreuIy25lJFYuAP6OfynIoBIJrrL8yBrzCQt+P0UXTdg6+K06WoCg?=
 =?us-ascii?Q?wWvGTqHfXU3s6XGyKZqhwWG7ablkvvnNjKSOXrrYy+ktXyZFx//w4NQhWGlV?=
 =?us-ascii?Q?yKuDo9PYeMjnn5C5+lZSAb5jf6uinpVDh8SL+Blu7hFD6GF1N+i0Yr/qFGmq?=
 =?us-ascii?Q?4plHFN4CBXQIKA9W43eH+fg9PPkQkMkFYViaVEqzWBNjmQjLX9JC3mpZGywO?=
 =?us-ascii?Q?u7EMPFqA2gtxMtbYiUu6yXGbNaQ/leSIQsO6C8FmQCBifPe4tNF9cerjVY2v?=
 =?us-ascii?Q?Ys/bT+3kOFRCSfOquNUtEm9LWin2oKyA0IZIfSxnbx/+FvylBZxg7HxQE6o6?=
 =?us-ascii?Q?rZtXbCTh7ZNxT6Pe+8lLhiIRdVd774K7k1bVKc4xTOvoiabjCrMQs6j6ZKqA?=
 =?us-ascii?Q?y2L4yUc1hRMoZX4BWfyLmN3kROQmZQuKW/nYC85oi5yHBGTdZ9ZdczTpUi9G?=
 =?us-ascii?Q?bUm1DFbeZ+HesdYdg/O63ka6KttDeZgt297fp5uZd4AVTCuZ74PcG7OJBGHC?=
 =?us-ascii?Q?TqrIGr4KmDAf5vMIdTENeJnwxm4LYK0a3M9p74pdVbEjo09eA7+oJFoU+UBK?=
 =?us-ascii?Q?qAJ1dPOA7fnkPgNeFuZgbAcah3yhlAFTgOAPWQTdNpRO+Y/FHrINv2gUL7/N?=
 =?us-ascii?Q?3sb4GkHugBeUFZxVTLnzJladlrK6HmosLlb6YqKdUc3DzATdMOqkJ9RcvB2B?=
 =?us-ascii?Q?N2I8BXdN6SsYZBhE1BauQDxpeJZSvQ47MnWF9WF3DogZPbAQLWisVWgLHmAC?=
 =?us-ascii?Q?19/2aupnPgATsac+A+ln+gd20ZeDau6zhbLKfm53v6vuiGmpd1Mnl9HABXnv?=
 =?us-ascii?Q?zdnZHbqpcvkO1Jj+ve0NILcwA3XLsX0IXnGpCZggicMFjVV+1hBfvjeD16T+?=
 =?us-ascii?Q?kOKfoLsddIROuffI7UbSsxE7mFvSUu1N7uo2M5Mw4gpi5ewFqwfZD0RuL3iQ?=
 =?us-ascii?Q?AnD9x5AdOqwsja45mBxiWQ619br0AIIlkULTIU57IxOquErpuP2aHHDBZ/aE?=
 =?us-ascii?Q?VVHfvXa5pD6Ix4YYzeauuGE7ISASM01rTGrQrziP/BzoN25+vhK16mWWviiw?=
 =?us-ascii?Q?EQAm6nAWfDFPQtEDg0ZT4Yu8NHv/8GU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0a386e-00de-41d5-0434-08de5a9c51c6
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7828.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 16:27:36.7773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wojJRlATRPxqBtz3sMMHH9JCtXRuBQxPOqhm6KXhc66dj2j/t1CzcGXOlXnhE46MBZJDyTXcZ+7j3GOb6f1W7dSqhYFYJ2QnVnwxfG5cOdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8437
X-OriginatorOrg: intel.com

On Thu, Jan 22, 2026 at 09:31:31AM -0400, Jason Gunthorpe wrote:
> Try the patches, give me the new numbers,

Thanks for the suggestion but they do not seem to help, see new
execution times below in ns, collected this time without kprobe
to reduce variation:

# iommu-tip + https://patch.msgid.link/r/0-v2-973a6bdc820f+693-iommpt_map_direct_jgg@nvidia.com
+-----------------------------------+--------+--------+--------+
|                                   | 4KB    | 64KB   | 2MB    |
+-----------------------------------+--------+--------+--------+
| drm_pagemap_migrate_map_pages()   | 660    | 3951   | 113813 |
+-----------------------------------+--------+--------+--------+
| drm_pagemap_migrate_unmap_pages() | 610    | 11136  | 322802 |
+-----------------------------------+--------+--------+--------+

# drm-tip
+-----------------------------------+--------+--------+--------+
|                                   | 4KB    | 64KB   | 2MB    |
+-----------------------------------+--------+--------+--------+
| drm_pagemap_migrate_map_pages()   | 687    | 3890   | 114749 |
+-----------------------------------+--------+--------+--------+
| drm_pagemap_migrate_unmap_pages() | 621    | 11180  | 334472 |
+-----------------------------------+--------+--------+--------+

# drm-tip + revert of IOMMU changes
+-----------------------------------+--------+--------+--------+
|                                   | 4KB    | 64KB   | 2MB    |
+-----------------------------------+--------+--------+--------+
| drm_pagemap_migrate_map_pages()   | 355    | 3545   | 102706 |
+-----------------------------------+--------+--------+--------+
| drm_pagemap_migrate_unmap_pages() | 305    | 4341   | 125919 |
+-----------------------------------+--------+--------+--------+

> tell me if you have the non-cache iommu

The setup used in this test has non-cache coherent IOMMU.

> and I will give you another one to try.

Sure, please do.

Francois
