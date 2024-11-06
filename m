Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECBF207218
	for <iommu@lists.linux.dev>; Wed,  6 Nov 2024 18:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916521; cv=fail; b=QUQd/NIKVaIVEIpMM6eH7PyXqILa2kioAmIPytcdToJYF8RfxhjJtFGyMmjLrBfCRYSK738EvHMLFKfTPDsdRuyKymM5e778+QgduIzK9pKoRji5XJsya5gQXU8WB577U00X22NvyhMwk/MKMtCOSHhyTJlUOcO01plavsx1+cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916521; c=relaxed/simple;
	bh=hsGOg1hxsc/R+bSKFS3ucZvJs9GWMRqkn4IoYLR689k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ClKiwEp23snlE5HVSe8xgn5tZTMAZMrj9kzjXF1l/GZLP2fR63057SYKCsKF2+2iDwoS+dwxQt+7nXBdu/95oMzUo6dXdgZDKWndXkdAlYrU6GbhrVvi6SpHfRJKNae1mASjnaFxAqlDiHZeORPTwd0vMmUFy688HYFB3hsjXQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NTUks90U; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NTUks90U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wzBr1XDXJiDXbMjFp9i7j6/g3Y9ZEoAuWXCXANUpkTqnmxFw82m1YqEXZzKz14w/YuMQeoZAwvvhBHGPZymGv9jDMkhncMA/OfxFdjhdPGgS1Fkar/FhsCC7emo/tyyO/XbTdl65qSmjP/Iex6ZnBxzGCQ5UcMU+nl/oBude0AurKQZSPu+l9mSaU+2twsWUbO2G+CwUNWJP0Pj/6JusYPKq34xtU5tI5NDvib8OJjvXQFTecDp3mXK5gUtlXGcpfSctsM/hRfJfmTDx7Zs6JV0XgG6y67RPHhsxav7xrpKH725NA5dJYvnSUbFdzDBiw58I5wUI3ShWr8gGILRWoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJUuxsHbfLbgy4u2q0NZD3PGqRl6b7yBGG1zgiyjlUU=;
 b=W5cGWNua4i1A4NqvAgy6B8dPhOpPrcdfebH6i9iPzearkWskKtRux1Ed1y2ohjTP+clxVDEaKviwuePGqbIU0H0O4nouEiyO/UWGz3Uxs9fSYAlEM1ehzBi+gwGyAjpqCHs7UT6tSGyg7s1yRTLfDcp68HWo/6FQsqsKypFBbbA3MDZQA9kLNelMOj3bUHTEFpI6k9YISkvXfaUSDTesqXGiuSihipzXZGP673kNQVbCIhDKeoJ3kMFXOgOxQjLuwKsmZzBdjb+FYv2ck+1DvNL7SlJr5yT51vMYDwS4szMiq9mGA6ddCDlHO/M/z6xIzoDimpXPughKJCs9uqF11w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJUuxsHbfLbgy4u2q0NZD3PGqRl6b7yBGG1zgiyjlUU=;
 b=NTUks90Uf/cGdbmzQZ9lglMKQk8cogUarWop1j39r4jSFY57awJ1VkF01f1aN7nhBL+9YG/9BsYpJnMkhFlGCA+tkrBwK2prL7RwOqf2FfpCi3Sut1Gfg/Y0PZxgEDirnuZG+cSmf8D+YGfz9Bwx7P3FkMOOsDqL/edCmADYn6E+1QHVuds2T/pIbauwWAII7sKlEmoNjbJy4QYDXwcouFg5IuFZHmnCpM0QvpJDMlLyQAWs4nIaIYYhTO0Oecvn5cIjPs0QY1WFfAHzAUwR9rN/kBs+55Dkf+pHajz87Ku6Ah+ZrRYragF6fbmY4zNLtmRShdMlGohLnf0V+WsW7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ0PR12MB6854.namprd12.prod.outlook.com (2603:10b6:a03:47c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.25; Wed, 6 Nov
 2024 18:08:31 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 18:08:31 +0000
Date: Wed, 6 Nov 2024 14:08:29 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V3 3/4] iommufd: Add IOMMU_IOAS_CHANGE_PROCESS
Message-ID: <20241106180829.GB520535@nvidia.com>
References: <1728321203-189608-1-git-send-email-steven.sistare@oracle.com>
 <1728321203-189608-4-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1728321203-189608-4-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: BN0PR02CA0038.namprd02.prod.outlook.com
 (2603:10b6:408:e5::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ0PR12MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: 909ade30-2b3a-40b9-18f7-08dcfe8e056b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Du84c/NFaAJgvo5mWZwLncc3o7sGpXOnog0twV9tNR+9Ke+H622qfkbFTa+h?=
 =?us-ascii?Q?fQiHkDyLuyk+KA7BT7p7bIUihIdga2TG4McGQlUSWsLTLYRTy5qqMRWvi4o8?=
 =?us-ascii?Q?14eB6nWLZi1N1XjXz2IFjj5JODe7hmuTo7oE+b9umrxMi86ZMuTJeY0SrJ1O?=
 =?us-ascii?Q?KcssIzTG6+IJfbXTRqGj+VQXSYlbZZkbU65BqWCCOwqpRn18cy+44no9ekCy?=
 =?us-ascii?Q?W3PXZsLxG2S/L7a6HLcB2w3FH7Ddq8R06Rw7tXTd85108v/jkdI3ryVrryLh?=
 =?us-ascii?Q?tPMAu8Hj0wGIsLz9HMD5tG3v3anOsUbJLx4jDXsS+Zwm/sH6Xes1760I2d7F?=
 =?us-ascii?Q?2nuCGSCWa3mKgONTtjcYtZGNzi2qtVlZAaQVbsYjIf71s82LVya5HXsV7ttk?=
 =?us-ascii?Q?EsDA6w2woEQOb06qCx1+eChnLRMf2UJVdri24UmoUvUFuRGMDy1fyUwIYoI/?=
 =?us-ascii?Q?kgu0GrIXMl82I5ylY2/puNnJIGczjghE2d3RpVgkA9shQVD3hxRAbeDCSkhc?=
 =?us-ascii?Q?W0bijiMYOFTegexhTK13QIOfKG0Ga40S/Gry6LBxXasFytGUjz8g9PHSDrqP?=
 =?us-ascii?Q?FmU9gHvfqBAhGQ/v8Y1tq21KnFpaHWFxqi/Kcsd/iWpNmnGFaqFedi3xmXM3?=
 =?us-ascii?Q?sPF/F6zOVQJPR/hzGjbArFisw9TvDYgvjrtvZ5ok625jYqsv5XudgNEJjIce?=
 =?us-ascii?Q?b6Qrh9ViwIwGY9M3CIHHwDDXAI9vI6VN3TXCG4wZPc1rLuMZOJpsUBT1YIrW?=
 =?us-ascii?Q?dmjXvACzFYEnAUMT4swSt5XpXwoyjzFHvCplSAIi9pdbg20RQexN/4i6IB4w?=
 =?us-ascii?Q?un5KFyi+vbZc3njYhhmIVJHmNQG9OeMA0bL/xNhcOAD2usgWMhKbScR54/og?=
 =?us-ascii?Q?XUboLu+OrMRycCCnp3Ng2g1H/RjfjR5AQkA2TUULvJvXk4eeP9luWYC/2Hj4?=
 =?us-ascii?Q?ol0qGIzWRXA4NVxyD9qNmUPPP5PNWwM8chyCJcWhaPTjOH5hTX2JlJ14rlP/?=
 =?us-ascii?Q?WOp8SGUcdGMFfNgqO1ZXkxMc35ndzq6cr1LXTvAYlL3e5TPknVy3wcGGaqit?=
 =?us-ascii?Q?xV8BuyuP7C/X9QhYiYTJyo53PgY+m1Bt5Ooc1LbjDS1AAjQFac9WcHsyLpyQ?=
 =?us-ascii?Q?biFM+nP4QExE1ovCevLw96tPQjnl9GWYMb9RMbtB2OPYRKw0/OdOd3UcIgBt?=
 =?us-ascii?Q?u4PzuTNGbnryMt7kQPnoMMrANR6wk+vsZe/FeFOI5PezG5GNGbfy6tK7ErjR?=
 =?us-ascii?Q?nYh0fZvOD4V2WQZ5RwatjLhkR2WQj47f7in5RBs8pBWaTdhJqgWqVxG0eTW3?=
 =?us-ascii?Q?29US6oWQDz3nrw63UFUG2QFk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F2iljf+6I+H/EbbYJPUjEbcMm9mCEFTk0SF1Qysc/KkRan2fkUOs+fji5sLr?=
 =?us-ascii?Q?GwRsw5anGH2aLhQcEBk7Yq0Km6qrAoKzBQ7KtnhcHiPlpqU5sh/OQzBz4Of7?=
 =?us-ascii?Q?Iw09hsQVCAE3+trqmVmz+dcQPf4Z7aNHhxh9PrJ8aTzjQZ6rsYUmrjM4kIO0?=
 =?us-ascii?Q?gc9z6nas45ltJx4Xgija5HLeh18aainUBgfFyWE3Io02mh2KUC4J4audlNmr?=
 =?us-ascii?Q?PocsjhYwc9nDHbhG6wzXQ6IN1B3mCx6VCFDax2IKdumPorm0d6+OsUQ1xT+g?=
 =?us-ascii?Q?C6HeONpGbEvvgKe9hYaaqKh3JvIlXeTrqrLYSWrmnyDeqOLCSccsjWztOzfe?=
 =?us-ascii?Q?mrCroFNcSwVSDfkrpCLP8GijTWf5I5SLhHSDO4nUTbEYlaeIACYk5Q4CmXJh?=
 =?us-ascii?Q?wGlxFpe2AszG9w1jUMGtf3I+529/LmMoAaSSJgCAQ1IT4GtVftKvM4n6Dj/Z?=
 =?us-ascii?Q?bQLlGa1ZB3ITk10c7yCJJvt2JXi6h/MOboP/M3qqn3cIQwAoixS6Ll6R4UqI?=
 =?us-ascii?Q?qjyOaiga1R7qveH3KjnBVoRTHAmql7vaQ6C6xQJfvydUz5U0+ddTfo1dgzIu?=
 =?us-ascii?Q?9SrTWwN2SSniqYG8R7Kj8OxttDXuF81vbz6WyJTK4pf+oMeLMRsDMtB5Gl8z?=
 =?us-ascii?Q?WtBMx0nfBtDZH1dztGjfJ/zHlYOcp2noBsUBzoOm0NnwnBsGPEld8Cc1QOWV?=
 =?us-ascii?Q?fJCOKmFTJw0GyfdB8ZRpANQFIhqOY72hO9I3rYmCQi2bpkI6Jhq353xr9IK1?=
 =?us-ascii?Q?hEpizbkJikb4tRvqls8wBWqW3hotryeJDsHKKMLICas/y0MWwMssKK5FXx03?=
 =?us-ascii?Q?k5oCsNpVpbb0m7OUVaidfn/j9yvXMVKWgp9wdVN8y9uchieYnJhEIfoihFZE?=
 =?us-ascii?Q?dX7hVwP8lzZMFIvNxY55wBUVI6SkRl893tod6NZH2lLfvO37ngKRiPqBhBnv?=
 =?us-ascii?Q?FCBRIg1C0l1tBbcYrpqzGL9hunlYT2kqIxBGKJ2i3OfV+rOwVsG9Ap7trVIn?=
 =?us-ascii?Q?KUFyjmfpubbkJUe1w0ySwslLXiC/8cnjphMqxoE4U/3W/lQ667acCEzUOMYB?=
 =?us-ascii?Q?NLQc3CLvFxu6CXI9RSxBuFR6pyMepgwgCbmAk926Yv1rFJOFz1PW4f+hc7YJ?=
 =?us-ascii?Q?OO1OhEALc0vio9SLMKqVTvV77Op7emV/+E6UkHRvYGvjR8noNg01jWsvu+HY?=
 =?us-ascii?Q?C47LtSlHY3CktgolJjWb4uVLVgYErRNsTqNI8R5hp99XIkda6xPupy5kbKdk?=
 =?us-ascii?Q?4H83ukC2KBEEwPN9hmcjigsmqnLzpAkb4KezHAi4rISdA+BBQ1NJjT3r3Z+S?=
 =?us-ascii?Q?iWxzjfwTtwpOieqzu1W/VtaTPpnK332shKrvhZViptkkeTZL3Hx8ycyxGfOK?=
 =?us-ascii?Q?qqNQ6JT41kZQTABUm+F++nIduEn4/m6934H+dTBaS7/eYpP1Sh5wgbHccd4M?=
 =?us-ascii?Q?8iL6nhLSKBehxwunX8o1axFN79q71QEBmI6tiSGQyRVo+7K82Dy0fUTkMMS/?=
 =?us-ascii?Q?cAeQ+9WTsTof0ixpj36mjjYVwDdWKs4gWxtz5fzzbEkVwFc3FvQXSJgb/6Xm?=
 =?us-ascii?Q?9tFfEytrYAX1DxnVPYlCKfeOQtsNM4GabwHNgf2D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 909ade30-2b3a-40b9-18f7-08dcfe8e056b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 18:08:31.1064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QAKYyuL82YvyH1fKk2Uo/VBbyLr29NBBsC6ytfzZyyFpHWDJ1hOYezMhTDno0Gp7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6854

On Mon, Oct 07, 2024 at 10:13:22AM -0700, Steve Sistare wrote:
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index c484981..523de8c 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -52,6 +52,7 @@ enum {
>  	IOMMUFD_CMD_HWPT_INVALIDATE = 0x8d,
>  	IOMMUFD_CMD_FAULT_QUEUE_ALLOC = 0x8e,
>  	IOMMUFD_CMD_IOAS_MAP_FILE = 0x8f,
> +	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x90,

I'm going to give 0x90 to the nesting series

	IOMMUFD_CMD_FAULT_QUEUE_ALLOC = 0x8e,
	IOMMUFD_CMD_IOAS_MAP_FILE = 0x8f,
	IOMMUFD_CMD_VIOMMU_ALLOC = 0x90,
	IOMMUFD_CMD_VDEVICE_ALLOC = 0x91,
};

Can you use

IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92 

?

Jason
