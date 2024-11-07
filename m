Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B960E20CCD1
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988510; cv=fail; b=r9gp0NRtHivO6S7q9LohO2V58a9nXTvGmgcvHdSpcvXetvhCfXjnqnjRa0GIoBmC6UAsUYXxuX4sqbb/38JhixU1GeX1pILuS/Lrln/fxUmMG747H/YlwvQN5OtYX/UsBgvQQCHRaoadrfi4kC0fUwGEVVNc73RZRaEBNhZ0vSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988510; c=relaxed/simple;
	bh=dkpEXZpttcB+lemh1PqUcKWhzLEYF4kQmmA02OS98kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YurwCGAlOerQmMxTLGUDj+ZB1oKs9im5z/Ef76V9BtVRoVpLX1/p4EgUgt9jTG7u3Y/t52RHor7r+5+6CA7B6sVdjVUZIJ3zLU9hVYseKn9qpzXOVVTRBuetw2aweR6kkb197wonlLpqDJArAUbx9NI91PjN47b/R2KdCaApxsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mg2PExck; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mg2PExck"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ir8kbaOtF7lLGTKobMOqARpalWJaus7Un21b5lCnTYZHy9NeifLyl5rO4+Z/+k6OBeeoLB+LuvxuclEiBlQlfbAlIkwEbpjZUCFLrDjflNnlv401sirIyuPS3XOoMiehEKkHjlFLvnKxj2BF+X7SsjaKmCzesK55pO+I0f58bvDZ/Zxs+pMT8axM0re8Bw3mDWKZCcQ7VbXMDkPOLPY4NafjLHTxRGswyvUWGREFruRszd93n5ZEVkntYi3WScQ9YWV1ZtT/Kptca/SCkpxnSJBLZMTKK97Qju5pqzgNfK9wZnP831AzBF926hEWp8BUkuoBEUzIDm/MCCdFe0LGKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkpEXZpttcB+lemh1PqUcKWhzLEYF4kQmmA02OS98kc=;
 b=KGb4n/3Lh3v3V0zJba4GSGdAo1JZeubBDE1SgHHc4HihBrW6s1qHE/MHUHnuMBh7iRNNzTz6XwDJ1frzcl9ZhdzOELRb64wCWNVUl6Erl6BqncIdjlPM0vBye6kF3A8CxZ7iCLzrC0eWR+k/nxKrFCMpXCUe/uPZvDrKNSTQyK8dj7GzN5Wg9/7MYAYc9pxLsxXBDhHx6OxES35R8uWK+ErmExzgjaHSZ9D06EIXZjQpStRZyEdzmR1KLlKIBjFIq/y2e+C/iS0Afv6mO14tYJU8MWJ8BrDMF1xoHmKNBFlZBL9A5aPt9WSj1ZzzbJlmdXbdilt7A/tSCnawZiXpAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkpEXZpttcB+lemh1PqUcKWhzLEYF4kQmmA02OS98kc=;
 b=mg2PExckVnA6OakHMAVgx7SNEmEH9xJ+JtnUwRvC6mRXF5LY9mfK/qNaW1AhtncbZmVepKzuG2q0+9xHUqiRK+Wu9ZxPM/qiARxy5eDfY8+V0/1w3vVwZ1ez/CX31Ni+uYPWAyOUb7USSorzu9qNWTOxP+13ATHQN3/bJY3Lc05O+n1nFgemrJ2UEXig5qvKPGjdtjxmzzjoiQbrlcAaCdR5a7NFe60Rt0xnszxpIwFEX4xDyb2PGT69RMKbWD2mGOGPHjA++abzeRUzHYwajOtrjsVPgKhNVeA0Hs+jnGAdP4cmzaDGd8VxIdIN4/w4EVL8c10C0TK7rRWTrbxHKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB5950.namprd12.prod.outlook.com (2603:10b6:510:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 14:08:23 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 14:08:22 +0000
Date: Thu, 7 Nov 2024 10:08:21 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, iommu@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V7 6/9] iommufd: pfn reader for file mappings
Message-ID: <20241107140821.GE520535@nvidia.com>
References: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
 <1729861919-234514-7-git-send-email-steven.sistare@oracle.com>
 <8f2fadc0-1872-49db-83aa-314352adbb6a@amd.com>
 <7788773d-471d-48ad-9f9c-ddd5671b26e5@amd.com>
 <2bbfb5fa-20e5-4935-b52d-73b5186c6123@oracle.com>
 <5ff5b402-95c4-408a-99f0-2f6ea4e617b8@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ff5b402-95c4-408a-99f0-2f6ea4e617b8@amd.com>
X-ClientProxiedBy: MN0P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ee6042-ffd4-4c06-5a24-08dcff35a3c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qc3Xi1p059i7WpAxQKxhi2MdZJOKwtBXPQKIbPjeiVx7cdDjSxLD/+eMs8pe?=
 =?us-ascii?Q?0DEOaXvcg49+rbde0gAazYDjiTzFf+21JIsBTrRHVOz6plWgDZcnYDjEf8b5?=
 =?us-ascii?Q?Xg150ZtP7DIQMwWeL45Bcn9Ja70wk/c2ElItSfsvOiVudlYvhJX4rxDUM+IE?=
 =?us-ascii?Q?Wpz6AJVBLKTZOrCCfIxezlblLCgaJLOz/i+0nWszgEoC90SM3Qr7iku6n6Sy?=
 =?us-ascii?Q?ZWmRPhCEGhSRWxbybv5u5WdyXqB9NQWjgj/vcYYfDC9HD3FjocL93n1LxR65?=
 =?us-ascii?Q?iiADQen1deYnJB6232qgVI/UuXW08knDngtm2k9VmpDqPAYVktDBx1cFfnZ3?=
 =?us-ascii?Q?wm7j5CC/Lqs97oDYvNol4Owj70y7zLNtNtPh7QgPVzTAYeqI1rchPx81JiW1?=
 =?us-ascii?Q?CMGckBxPL7tpoTTIwuo7jiW4wBcAo5rqbAk/0qILkxeiBOpQgRvblFc1rRsB?=
 =?us-ascii?Q?IK35ZH9YAyzP4itHwwc3Kde1zulQGEwx8z10s8JTqB5uz7b/ujTry+7aaC1b?=
 =?us-ascii?Q?Q/Wlrle9fw1LmpNwC4Sj90YeZGbMiJafgsJfpDozDQaPlyyVoj5WqJHg1k5B?=
 =?us-ascii?Q?H7aQA5Yhqwigl2b1810cROWD5D1qRLE8m67GuQXndsZVovfHHCQXn3lOkq55?=
 =?us-ascii?Q?uedLT5LCjR57OHCw6TLvrNpKVrwXUBk9s8ck1Tq5akADiiqTmDBtCeBZ3jCO?=
 =?us-ascii?Q?LCBHNf/g0Gs7xvwwv3K3MzOxamBlfaRpR3yFeX1X3Udm8NBgPOwTo41bMTyn?=
 =?us-ascii?Q?A1/BOQwT75XuuvB9H3aCquUMsuh5TVpWjjQnrReUU95FvxE5HG+fQX9UUXbI?=
 =?us-ascii?Q?1zPbwQ5b2oOvLAK4CvpH2mHpiJJWRisuYjhwo/XlqoYdWiyRT2MEJdgfCiPC?=
 =?us-ascii?Q?5FTAKH3ypLJhkQm7BCKovSxNgOYZcnAHg5mpAg4EC9iMS0H8ybJs1XnkCOKU?=
 =?us-ascii?Q?Ta2Djb/nL5rxBDJPxAyyE4+JpoInww1Y65UjtFcsQe/PoxqMxxae/sOGd5Pd?=
 =?us-ascii?Q?mgaYoeGi5gWPq1Xf0AKXgqAzX0eT6BdYeLxm/WKwQC3Yk0aMqtFyXx51ekZn?=
 =?us-ascii?Q?ECIfSRav/0a3ol3hrBVkUZBp5YG4Nzhv1BPvSmAmTSu35hEyy7kt7u2IZovS?=
 =?us-ascii?Q?ft/Q/KxiGzuBbFmLAP5uzWpbikcKMgTEmG4tmtT9V6F8ZmVq+fZuCxBx4MBC?=
 =?us-ascii?Q?wqRi0Bmx+BRcVMd3GydK4QrrgLd+N6oFr1q8fzNVEMBDuZgMhciZ71PLLuDP?=
 =?us-ascii?Q?ojqPhlqn16JFrDCiCj95qRnT7wXf3vh19OlAqtFYIvfTowvQTEMANeri/Bnf?=
 =?us-ascii?Q?0lM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ggdrXiMWUfidAS5yCh4VByNlzR4p5VeIT9A5cxyDfd2ueBUGYTxUTXh5EPdJ?=
 =?us-ascii?Q?9Lq/jFuEPdN9i9MJLAfHkeqvFrYqfldbSF62tgHaeyMEb8BTbyyMgF+BxDBo?=
 =?us-ascii?Q?LCJ3mIwOC5V+1mJWcZ+b4MKHmVohSUltC1ibDa+ADJHY9JhdHJUVWShA+Lqd?=
 =?us-ascii?Q?EZnzJotDIPIHt0CPXHYbLyFIYfH9TPaRBvO8jVspXEeVmqnV6AV27ov30/4h?=
 =?us-ascii?Q?N1zOT+ypS6QPFQKrrN7dXmeUveJNILDycugD7g/LQ3bdUBu48BIsg4qBVH+8?=
 =?us-ascii?Q?cjXqK9Q1h4YUoxs2yaq92vD9bjjs/4PJNcC7046vXHDb6+0KJ+2d4fpRLWH1?=
 =?us-ascii?Q?hf+5WMbwbAFU6L1Cn1Nu9+KGavZOlVSy6if3FQBzLauR2fUS+/aCxk9p8fs/?=
 =?us-ascii?Q?PcI539FS8RLMzwlT9el0yofTi0UcK2AUaqBlhCniiYlp7npdva2cj2Y7KoRW?=
 =?us-ascii?Q?TBR6iq55t65NKBx3O8BXTVCCdD6h6cwBKmHM7rq5Fq/LpBEcZQdE+munrQ0r?=
 =?us-ascii?Q?eEeVR5BYs2BOp9vX2DWSHtc+pMl8y/aOriYHW5W4Yn5fNz3WxstZGNiSChL2?=
 =?us-ascii?Q?NbvPsZi+bKMtCZdkNjVH2sMgABMfuWC2Bc4v0Vns4NdvrFImlUBfvfSKcJI+?=
 =?us-ascii?Q?ya1U7zI6mq+XEYUpur/rgiYGTvI71hViIDDY2xC7tsCZQF8gToRv7ng7gsOU?=
 =?us-ascii?Q?bUvkbc5LUBmrV8mhVmq8hrTDgSv2E3G/ecbvvpMa+u3hEUrI7qvu/r+PK9HP?=
 =?us-ascii?Q?I6uA6xH1z0y8HCl7LKo+7+QHOkVMnWyms/9RQE83wu7InykkfqkEz33LULh0?=
 =?us-ascii?Q?EyFLr8hWaTWbqQ93xBmvL4VpCKgxryeUkmeFi94PP8HnjaX6y+DLmgszUkUX?=
 =?us-ascii?Q?p6OC7PkD/DLxf5j3hzZutRVpRF19BPhzdP4foeeKAd+d8zrExYMkNXdHtOGg?=
 =?us-ascii?Q?5HY6FuKhmWByxQoVMezz4Mukg3T6dV9iQbpTiBqIJYYZCpgXE4Qq7FiSALWi?=
 =?us-ascii?Q?8SlvTefM7UCwqLQK963kK0F9WhV1PdP+TLvhR0Y+X+FmpODgU7MNR12HR/6L?=
 =?us-ascii?Q?dNQAztVAIUn3dXeKM1irgQrWVMJwtzCvKH7i/6kui6NveLDqLxyrDKCZRZO8?=
 =?us-ascii?Q?TesSuXblAb2pFHj5vi86322HdnGLJfs/g/opgeRaWvd2lCB8bS75/3auTYjR?=
 =?us-ascii?Q?Bvo0PPolhhamnnteIbz4/7D86d6hyAJfST4t37QZRefuT7/8vKZLorS0jX4h?=
 =?us-ascii?Q?EI6XmhKBvfI1jKjyvOooPK3i3NRg74NYaLOMMwqMG4Y7KbBsiKTV63fSw/TD?=
 =?us-ascii?Q?7tuqs1QHdI49bD8KP/SbuFleQR2YAR0w2fk2vq+23WYDYrW5tqI+PiMX7D/r?=
 =?us-ascii?Q?jqdBJ70aXalqoO26Jh3Y940EV55Ikwn2QIoW+bY92QH80NvPS5QL9jBedtRk?=
 =?us-ascii?Q?irih5PGNqLZCgsTd65/TgLLGwYVv4RJ3oHjMOWRQVWBFeySvWSZ32wH/7T5p?=
 =?us-ascii?Q?Dl61q2JWVRbZ0o8cyEkLf7TaSwtkZ8EHpRAGuDCMPN9TwiSB3GbY6JXh2LLi?=
 =?us-ascii?Q?752wr55D2R0lE9YhiZg626qJiVaGn2tCrBXaD71r?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ee6042-ffd4-4c06-5a24-08dcff35a3c7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 14:08:22.7357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFPD9jcfX/4VGOY9YkdzxGXmdwljeHubj6HCW2vkiXq0suEJgTUmbw6RKY+rkdzs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5950

On Thu, Nov 07, 2024 at 09:00:50PM +1100, Alexey Kardashevskiy wrote:
> I was initially pointed at this patchset as an example of how my guest_memfd
> pinning of private memory (CoCo VM) should look like. And so far it's been
> good except the actual pinning part - memfd_pin_folios() - expects the file
> to be shmem or hugetlbfs and guest_memfd is neither (well, last couple of
> months). Is there any plan to add those? If none, I will then, just wanted
> to check. At the moment I do what KVM does which is calling
> filemap_grab_folio(). Thanks,

I understood that the guestmemfd folks really don't want typical
pinning behavior, you'll probably have to negotiate with them on
exactly what the interface is?

I though KVM had its own private interface to guestmemfd?

Jason
