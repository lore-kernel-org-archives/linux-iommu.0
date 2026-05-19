Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010044.outbound.protection.outlook.com [52.101.193.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40013438BA
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779213724; cv=fail; b=PWSeWg/gWZG35xzR085vt7B4OH3V6QW0IMZYILO7mXhED3dlaFGgoOIJEqIXDBKkkKGeBfhOjM5kLmW16IX2K6e1vHoNHVVjI5U6hYH5ADBOh60dIwcaEduzLdjw7dzkrEK4iSwkWaFastx4GgYqDsoODu0GOIB6kXph0f8vjdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779213724; c=relaxed/simple;
	bh=ZhDJ/cwL6KtYxkjCPGpSID54bVAjZy7p7mEr2grD72Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FmHJa1/zySgJaoz3OgVnk4vRauCenF/E8z7nOzsAovwTYJS2i1yqaa1T/VgPJJacg/Lh6LnmkKi7YZGvi820up464XEn5vZbHx8WL6xwcqHrqX7vP9uNnaNPdSw5P6z6qjNFDRkKWhAQX7XtmBtnaBvKw3udn/Tr+VifaoZsyLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZMmOA2t0; arc=fail smtp.client-ip=52.101.193.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZMmOA2t0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAclrWmPC+sRb11/szGDxHPlXoXw9W76Y6cUqJXnfzgCJXYwnIv2Rzz/cXAH8LlSo11eoHa01nitIGxwX3kzWdq8pP6HkLvF1L+dUz/96nfHZ+eg/pLGdw3NKfYETb7Lmk6AMNosJWOs9nGJNsFeZWLe0+Ni8fe8m+pSU4jo+3c9SSEYIVXJArsW5jK04h3+X91mGAy6bAx3C20ShRT9Lue8EbDBmbVrr73+h5c2bd0vafArXr5Z9cKXyyvc9S4ghtg27jYQ0qSzSfB4BpyytQB4LWBLExijfl0WOorqlEWh3QKEtGTo11zuIejphR/o0I1KYkzfaXEXh68bgg5Y3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhDJ/cwL6KtYxkjCPGpSID54bVAjZy7p7mEr2grD72Y=;
 b=n1eJ6XJhVUZn0zgqDDxT8HcejV0MsqxnIR4yqiSw6+2oWg/Vr0Jv9fmqBVfNLI7stxJpKPozsvzMGpySUVF1dEgVJ7X8u29hSLNpN70F+nPFdwknJVXRZxBgTXKw1VsTnsr93PZFNID0Khlgkc/KUomotV1obaPpu+K2NV23XaVvXbukSaKg8HAAFMVlXwa45auVuPof1CsQaEWTdqph6FjQuP7NqMbXLfyBVBUGU2wCcU88BFS8s+C0x9Anot7LdwgqpqxaLS3zBbcibJRvEargtpt+KVtS4+scoJ11vrm3CsOpGx9sIxzBfdEgGAvgUyHIJTahBpE5mTgGScdcmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhDJ/cwL6KtYxkjCPGpSID54bVAjZy7p7mEr2grD72Y=;
 b=ZMmOA2t0SnVrZV78PRuqN86WbHQvc8sB6rWBmime0Yp4thSjRnywY4G5ezw+5jYDduLXqAioe8isbPCjha/ScTBmxwESn0OzG73EOabKhC8xm/h2p8qb3/u7BKhNroU/SEHWEScSok2eG9sBV6yQOYPUzEyS0vqwzsynYbN4Z3bUQOQgV4fcJXFmTLciq/5jPT4szyOpiMYZDj/t1C17dDB+Mn2R/LyEBtEui7DcmqH7Ez3FpN0/LHEt8cMBgBHyfUJzaiYkN+ix4JpoClDRCQac0sAUyGizgPqyuneVoX/04Yh8FCjyrb4jR9NSj0JD841WbyyaFGF3V9L2cga/Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB6994.namprd12.prod.outlook.com (2603:10b6:806:24d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 18:01:58 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 18:01:57 +0000
Date: Tue, 19 May 2026 15:01:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>,
	Alex Williamson <alex@shazbot.org>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>, skhawaja@google.com,
	pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 0/9] iommufd: Enable noiommu mode for cdev
Message-ID: <20260519180156.GI3602937@nvidia.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
X-ClientProxiedBy: BN9P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: 576ff255-9116-49b6-b53a-08deb5d0b790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|11063799006|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SHXwo6PoZqzkW5MYLKjKwAUd7kLjp03vQxoYOCMasix+QRY2znhwNpyivnP2l0kB3pn7trsmjhOkXTPT4ZbGExb4uQRgQkrTl8mMIlxQM6hwTt19nxt37gABKGliK0uQLSAkc3gcnXzJgJWiFN967hdZl48QvaTy+/J+CQRbu39GrMwvCQ0+VgIdktW2SMupm13sSD7wb+JOwVNlCKuM0K7pzSgOr3HTKt4FKxtFSRpaBth45UreflOl9Gsdzfke1s3WIg+SNbncqZUx2DBvTD3pHZU5W3oCRo12S3Zxa3Ig3XsaNPrv+EPYSRHsKSeQ3xnUSIMfViXehSm+pCfXaUWSL6RTI5GXQ9SZWxE/q6+/09/t+VinU1dg6CZVm7SiduH/hpFy6nE+tvQ4jUcmlmsowLFZhyqIgSRbjEAzME1yH77xFcqsL0p7termmfYW1RD02pjlRk5f+SXJYAao/Fn6pO5sNvLIsYwFWgwFmspHShFXst4LpbzbqMUSwBhuF7VEb8V1qPveebpVVd1ZkjcLXDfo/B8op4d20ydPAIo69dAhIcZMSuAPgDm0sdoQ2WZwQZsm3NMkiy3ZGB11CyVjTfgFGc3mMpFCtT8Vov2SpPztU9CwMyChXOV8fnI8Zba1lCW9w5h4mTJtkAdoL9HXKvulN7ONUN8ZF9Ael219YRTtAD1bUVCwNY6IFF9+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(11063799006)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WUDInCk48zRCSOEhqgMHtZefV/2A6FLKuy9F/MdLFoJSmeBtLKmeF4QgOeHi?=
 =?us-ascii?Q?/JO5GIcCXu1DhtVXGGgXMMaUJLyxj5XJrqEXT+E+JJ+d8PzIqIiX3U8dOUES?=
 =?us-ascii?Q?+KF/mBvf5G3a/7cV6F2wa28Yi3BUOoWYSuqFljvmR80ybeOA2FCJbvwruwKD?=
 =?us-ascii?Q?qIJrab+OYldLLrOUBw3+88so9z1mmcZtc1WiWIl6ndjcW2lYC6cvh9psiYGm?=
 =?us-ascii?Q?c3J3JTtfAULGe+TQ3hEnYVN2aUn1AoM/+x5dj/WBt7Lbw+Eqp27M3VOdedUQ?=
 =?us-ascii?Q?9baGRskHVrF18SJzOWOzo59bp0eoKyQxe/8d/YAHk5UvPj5ep+y3UQ4wSd63?=
 =?us-ascii?Q?/sprPYu8/jUe24adRgPRBhRFGGtDXYmuRS3TZvlayTGcq58ovqKfYRL6MH0b?=
 =?us-ascii?Q?N/xfXnZcgMRq5s52QjjJYVjTwAsKndAyz/ZdcO49sJWydngMwYFfAZSG3pxi?=
 =?us-ascii?Q?k46LkuwQokU2FB8WMhbLsxgMiUtnpuENLufWZydHURknztwHivjUkAUm6qC4?=
 =?us-ascii?Q?oqTfn3DSqADFlBv2xLBbFRoLVgj8ck5XT4ExDu00ieymF19G5QQtgrSrKs3c?=
 =?us-ascii?Q?EIGumyf+vPWpbpqxaGKJyWLAKmG2a20NXrFbRkT5SsYUFKqIxWbfnYqhXwhQ?=
 =?us-ascii?Q?1PtClUBFVlJcaFADCkMb0DwbnHFNbNm3GWFxEF9vIMI9wwxmKM3eJy4WxLzQ?=
 =?us-ascii?Q?TtqgXrY2kCyyQ7beEZGpiVGUd1//sh42hwYE/xQiJnlRdCBH6wDgBrGyjGEM?=
 =?us-ascii?Q?IqNqkXDTKhryNEXVanNwcYGUSW7A5gifBtX8WT0VD7R14G2VSNqsBJsm3yDv?=
 =?us-ascii?Q?0wQ8m8uuRi/2s2P+Nvwr9Ic1JLZXoQSj5eWcpbYAzaZwsHJRnjX50qZCp+w7?=
 =?us-ascii?Q?QZOu68eSI7MfLSUeMEzOB7BWICwf9fugtwYJO+UqdnpVgHwYFHq52eFNXvFu?=
 =?us-ascii?Q?0HO0eBoR0k982k5SJvJj4Hfcsa02hx9ulGPReeuM/vk4d3c7ZxicJzvjciu9?=
 =?us-ascii?Q?OXdjHmsYWdq4kdMGeCMIPSDGIbJ6sYwrx8F2N4t4nqyObgW7lYDj6jf7fKSJ?=
 =?us-ascii?Q?qhpcruoGBpkkbVCE9p+RMhkFKkDZmTJvsTblpheWr0j1Ps8Q/GkVGe9fcMrU?=
 =?us-ascii?Q?Q6u1nhWEjtlXY13HMq5+jtsWh3u/uVWz2RwxDQKs51JnfSX/EqxfWnJwoUpQ?=
 =?us-ascii?Q?RWYrhuQICTHdoSbGyYPfuid9qwszZLyRl80GZPijydVDUeueRbE+ZZ6xz/KX?=
 =?us-ascii?Q?NJQ8CBtNLTXG7AJrTTDDOrj55LgdevaZJJ3ajuEG0/YfMdoOHcrvbecMtnaf?=
 =?us-ascii?Q?WiDnSs66B0xjO6QBwN/zkJktnMNsW+cm7+nTB+EnRXU0eNC5dvENIbRjfTeq?=
 =?us-ascii?Q?ckfNwvmdMWwNRyhGeDdBim3rfeV6ErXX3einRvTAD+R8hx8XXum/VL4RFP+I?=
 =?us-ascii?Q?giNN3gEjStDrB49feVpCP3QtMeTdK6HtRdI3qwdJ90XzA60D9Uqtmw4IotLP?=
 =?us-ascii?Q?3X5BhizaOE+WyLS+lMei5yrWGRh+qnF89DL+nHXyZYlIacnZbc9TVfF94W3j?=
 =?us-ascii?Q?1qnccpVNzJRJzPc7e4DKyNnZum7nv8YDT73+6gHgKvEetW8FlzQyyM2ZH0x4?=
 =?us-ascii?Q?GloNureYT8G2YAoCIbwZbKK+kyuBoc+5Lg089kspuZtwlK1DWCThzVGZwC3j?=
 =?us-ascii?Q?H/POYkC1fZYIm2NhZ95XmTrUmvbb+WGS2wpI5OWe8cB1wfwJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576ff255-9116-49b6-b53a-08deb5d0b790
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 18:01:57.2524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1zdVAm6s1uLCpeYRmba91QhnGtVLMMrc8VYVAeiO+RRUtEfGIL4WM6Juv/sDfrEj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6994

On Mon, May 11, 2026 at 11:41:05AM -0700, Jacob Pan wrote:
> VFIO's unsafe_noiommu_mode has long provided a way for userspace drivers
> to operate on platforms lacking a hardware IOMMU. Today, IOMMUFD also
> supports No-IOMMU mode for group-based devices under vfio_compat mode.
> However, IOMMUFD's native character device (cdev) does not yet support
> No-IOMMU mode, which is the purpose of this patch.

I would like to try to take this for this cycle, how are we doing for
a v6?

Alex, did you have any remarks?

Thanks,
Jason
