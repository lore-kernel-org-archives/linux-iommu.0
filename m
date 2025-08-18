Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE6935A2B5
	for <iommu@lists.linux.dev>; Mon, 18 Aug 2025 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526476; cv=fail; b=Njq/hZAg74c05XSAFbQSrh32H7JNpkArYNngAWYiwGvhX96YRRctrHzfVeBC608ygTYJd/KJIKnUbydMJ/gE3AhsmCHBGpGaiKYeJ+SuMwxF8bJCqJlkIanPVMxbVTMZ4/eCKseC+XN4aCIdGas27+EsIcV2SFImeUmY0Nw4BB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526476; c=relaxed/simple;
	bh=acFrVBpJIx2sgWd5KONyLu3iA7F4JNNXphalxs/DErc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YlBvMQG0Xrg7hgG0tbYFQ+q7LQoQQmuQLMqthHmONUYaE1++iy5Me5RxeBc9gO2zftfwoSSUmnKTPTl4uEsnHaMgMHrTCjjmaPl6zzu4bAZiJHA0JHmdKDfJ+K1iFNl78MQJJTC9pkcJNX1bs4bhOXB5DFZc5MFDJUzRJS+REhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M3EPYf9Y; arc=fail smtp.client-ip=40.107.101.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M3EPYf9Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDZ/v3dFvD5STae9YBQd/XyZ3JDJWEfvk1YJcQibkq/T8zq5Z3UXmLxscoh/V8gdfDSNzIomP2rbzRs2fsSf26ygAV1DyECldIlnB9AmhHxoheWr+rtxFQeWEd94t6r7Lo/YQ+c2+up3Bf3BOyQNWy0D2PvcPV5NXqAYMz8z3eL3YrBY3y5EHXnQhhI9fGw//pVzDW6NQCc/ySUIhzqaLeQ3uS1Sjotf4UOjyxCKMs6sLz40IyyW/NkR3ZVe4DC6KMGTmKYSfl3dvL1HFqW/rsHHKRwX2DAuSzqVcOqZn0WPZzaBPQE8W1YUHFhB4VCS8IF0oYaj7AL5nZFagB1pzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPxVw4JsH1NBqzd6Lc1Qus+ECwnubAj8CjUDvVfdgI0=;
 b=LNTm5isxU+xrYZXvLSQRh3K1LbaQHfa4JT10EljuQY3/nUHJP+lZznCNbiD9UQ5OqBf6hCMdXZgXtC+UzMV2owhLLy5uaZc0rq62YwjQp2UabcIM1ho3hjhBznRRMbDulQu+i2Dmh4jOVjYSvPzBHss1H7m5Y0qgSzof3/6b+KOnwvSF5SWYqNt8RyncuqhnukqzEBTzjdu8eZnJTypvcy5ZJbTnwGFpO6Tb1nX5pTp2pVRy1VEeaPGhn/d4J3VhP73fziaUwfsPCEtwxjRXsjsAv9h0sdNvVk/XjHqE8UQM1Z1057EP95vzluRn2obIcQ9PIK4nSODpwm3M8sByqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPxVw4JsH1NBqzd6Lc1Qus+ECwnubAj8CjUDvVfdgI0=;
 b=M3EPYf9Y8e5/6ED7IYbKtMqbEdFca9WekOylyV6EAY0meDkHxpau1DwOcOAYG/ShwlAbWKx/MNEweT6TdbBy5lsihSPzqatqgESKRKrsZpFvCr0QzeCAXbdJxwuYtq9ak+O+6G6ZkT5oZaaDZDPUf/jWePVQJlvr1ViGuPSZu7+7y+hsa4oUe4hP7TJJh7QdXZY+iZSytQy32/xRZiiQKBLAMuWEmaFzl10rL8nD9QyM2OwE/nBKaVV92pi2HWwRcsP5zkiGOnUDaIdVd+U25Q2hHY33WECQJJZmYYNmuMNIeEEtUWpLwFd0BqG3Q5kJckI7HFwzRevRouc1lGb/Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY5PR12MB6430.namprd12.prod.outlook.com (2603:10b6:930:3a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Mon, 18 Aug
 2025 14:14:32 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 14:14:31 +0000
Date: Mon, 18 Aug 2025 11:14:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, praan@google.com, baolu.lu@linux.intel.com,
	nicolinc@nvidia.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] iommufd: viommu: free memory allocated by kvcalloc()
 using kvfree()
Message-ID: <20250818141429.GM802098@nvidia.com>
References: <aJifyVV2PL6WGEs6@bhairav-test.ee.iitb.ac.in>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJifyVV2PL6WGEs6@bhairav-test.ee.iitb.ac.in>
X-ClientProxiedBy: SN7PR04CA0058.namprd04.prod.outlook.com
 (2603:10b6:806:120::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY5PR12MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: 382feff7-89cb-4a5e-942d-08ddde618cac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bdb4Fg3nbV55dL4Ay/RIQi7w1GQME7QYmqcazdGcLoOj5qV2/GxxA1MKu302?=
 =?us-ascii?Q?3wkaOQtX3MX1Zr6ooxu5W/FsJwiH3VAc1g2wTrFzAmcywm6OCaTLDI74r6gY?=
 =?us-ascii?Q?dvhOVZXsDHJkUXEa8JbU8m/z571PoPK6YIc9DOLa3fGu/HiNr/TLy77ZSj61?=
 =?us-ascii?Q?/9cQPRZ54msKPH6ztoCy9f6RW/fvNMYVkN/70HBIZFVnplaR+GhmqrY+D+L9?=
 =?us-ascii?Q?riyKofRqpUeg6gxCKxdDDBjpoeLsdQE0GFZ8D3T6pxY1fcbyRjRXrnRiQRSM?=
 =?us-ascii?Q?oADT+D5/V7L8nbNyV1Ry40ZouOlf1xghbfMNGw0mXphXPBrzAxUcQylzvKll?=
 =?us-ascii?Q?M/GE5LQE7LgZ71T9SB7l9CtrjnsSiGU1/YWIlPXvxwbLgBNVrXHf6WbJjWvL?=
 =?us-ascii?Q?rL/TpCfQzH/BEG7DGqwTGYVMecyDNQzdR/9N0g97VDtKwqicswMVIYu7xuJT?=
 =?us-ascii?Q?/IXV0kAlJk4p/YGqJde5wyztEQ4Ih1gaKZ8f+F1BlWhWdnbhOCtwdVSOLY/0?=
 =?us-ascii?Q?+E5zkkZrHtWSdLoh3aGOxHWtvl3DIJryEkmGe6ySwodYHfyS+IB38umLgxAP?=
 =?us-ascii?Q?l+stmYutyq16gv1ZkS9rM5PZn8CLbccRPZyQ3jB0t+gz/S0MFAnpBldIbfto?=
 =?us-ascii?Q?GvbR6LOx8cSgIj/X6SfT7Qk9GDenDbj9fdG16HLu2F1vDrV+6UlFzsRNOExf?=
 =?us-ascii?Q?F7ekArOn9LDdzBRDNOaSI1mekaczy1f85iF5i4NsymhbQtFirISjKy8M3mk2?=
 =?us-ascii?Q?nWQGX7/MF6DeT2PnWJCoZIxdiJR5mgBI0xRDqC67vF2oi59mt77ttd+NCuYB?=
 =?us-ascii?Q?ZQa8Hpu6sAsnqdrIGgqWZBJt5AelgGxPud7Qu1ySlz6BCs2vh+qDXV7Ev23B?=
 =?us-ascii?Q?f8AkLT9Z+zO4qQE69qtbRDsCDzd9bcv+4rNBWX6NjHC10fA6WD/33pArXczE?=
 =?us-ascii?Q?KcY7TMBAYi9y4IPscFnUb2kS5VV60vV52cl4wRpWNJseYfUsZCLtdY2q+tjM?=
 =?us-ascii?Q?rbRgcKHaW2DxK5LbTSKYWWscSfkTZcZiVA5Wux7fAPF2dhWZXI+Ew09Av/34?=
 =?us-ascii?Q?dN8oK+f3srsKJllQQfn7ZOXgzgWX8Dkmicbz7sFXoUpOfCwuPNu/wMU58ZQ8?=
 =?us-ascii?Q?CIJerdGHm4YZZuxpQFk2smF08hkwHc/wnM98FfILepzjDQc919tevkC5eQMT?=
 =?us-ascii?Q?obqxzcxU43GpCeu5SxnL8FD5tWzkAkmr0eEI+hJDP36lrpCU0PUPdmWDH7Kk?=
 =?us-ascii?Q?StiXLgRal1upym5onei4J2eVD5TUJZVyQzi47wejcSU8+GW5H+DWKyrcUeAf?=
 =?us-ascii?Q?1hh5XMdJ/nZ/QxDQs8vZz/u4rKgE1tUxbI6zLT9i1NivcnPMEjdhyB16Khzv?=
 =?us-ascii?Q?1EE7oDdpixag6KM3Hufhv+GVpNzYL3xgXyVyKS7fcZ/qDef2zulXER5c9AwC?=
 =?us-ascii?Q?+M9ZaIjw9/E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vCw6SvYlAAjLd5GfvNE7IQq+KhNrwqHPLvH9Lc/Vd29LlfoSzLwqDpLJRxpQ?=
 =?us-ascii?Q?Cx5Yfn6uNUQMNvox3rsRV9J2ohMrd2aZ4D6mUDzUlRF5KFozdPRxfev4OTKf?=
 =?us-ascii?Q?1HW+UuywryOKs59VtNxfHLTbXCKgllf5YlVZOsj17CLr5Cf4uu0P/E1cSKr5?=
 =?us-ascii?Q?3ZsZONL+6Yq5XoSRzm6SxfZghnm40HaPPnC2JueLxwsr1Bxlm74kgxhUsBy6?=
 =?us-ascii?Q?uroKUoXeF16EN3nBx9KqPLjYGDISBAD6eOiRrKrf9Lw/9RKE8SkX/lcTm7dH?=
 =?us-ascii?Q?HzH9yopUkSmKNaFk8gXcAUqjQN4gxVAUWKFs6vYmGem2xKG/juFUzINuSThk?=
 =?us-ascii?Q?bUN5iK0gBqQiI0KXL3y0Bxjeq/wViYn8Ndf0fBKrAbyJoJlnkJrvSH2lYZtF?=
 =?us-ascii?Q?3mHE/lBE8jFs1Xp+X5ZK1bcusw9JlnsBEEi2Mfus07JGmEmV/nNMlJ7KV3wy?=
 =?us-ascii?Q?+nP5U1ZVXfIMb0u85C6M3mJPl+/o6l/KLuhOwDrC1WDXoe07It4KNMQEfgwN?=
 =?us-ascii?Q?nJEwA1oyK7A0f8qHnTdTen41MXoZb+VWVKHRTZgvJ6NNY3tcI2la91BUBqqR?=
 =?us-ascii?Q?Q0n9FOuNo/QjSYX1GH61AqfeKeBiZW1n/YizPItC3xBsqURcdKPbLPSDUwPZ?=
 =?us-ascii?Q?fgBHqBpr8SRvYlx4yhowgKqUFTOgQElDn3liGI27VsOTOVSrNKHLpkrAToXZ?=
 =?us-ascii?Q?iygay5yN8OHc60FWPxnCVGMFGB9kMVlxSdKHyaoZbrb0tW56By/Bc8sbkLS8?=
 =?us-ascii?Q?0sQF8VFQp0EShvbYEYpsRvmVLizJtpVxD1SMIki/XkEDXvtsadBO2bdhoL+o?=
 =?us-ascii?Q?gf1jPBL7D3uXA5H1NWHoqfDpD1wYjWeglwaMfwcleNhVjZIW8v71NLKE2OAD?=
 =?us-ascii?Q?9pIbL3csqC+a1IFfYFK1bMyvbZtlghUhfVv/fyfeqxkZ+mg3Pqm6rno6IVRY?=
 =?us-ascii?Q?a7cuTh1+pM2fBL/CYgEVLyihr2w72ews/pa0bDSwbR+xtGOHbI/3nTfwT6LQ?=
 =?us-ascii?Q?c+F3K//KqRxaDyeorUFzSiaBYVQmno/jz2Nq6sebpaovxA9HuzqlT1DlRXzw?=
 =?us-ascii?Q?BfCWLrODVdmbCXkxwmdceBq38MWC0Gb8lEmf6Wwm6jq6IWbeqxKd9DjgPT4m?=
 =?us-ascii?Q?y5p3xRhebC7s1T+IueWlb9A0CAHkPZIp1vDYLAXueMdi6DBvl3djg+i7jXp2?=
 =?us-ascii?Q?bx0iRKM2bpKRIYpSkqLFr+GvDYROdifOR2s5utIO35gzTcs9wUKji0vh3AiC?=
 =?us-ascii?Q?dIaX2ONIk3csHiT52IQo8SPBz/gdO9aFitBxQTexB1nr11xe77/lPQVpaSFL?=
 =?us-ascii?Q?zImriPzhkAEhS+CxNXR8BLbsmsChf839mJQKE7aajXXZg/r9JCxyW2zaXPDZ?=
 =?us-ascii?Q?tgQRtR8ZfvIN20DG71BgA/HLSSmuc2s3nkl0Os1mG3CEPsivXT1JVsFBCiIW?=
 =?us-ascii?Q?rY8t3Ks5k+tXl3C1vFtw7Ic8xA40xzRwZxRorXHgmGcBfyKDEIRvlmw4w/pY?=
 =?us-ascii?Q?/7AknfcKa+x5buNibaNM60ehx/gr0wRbudanxbXeQ95rLkro7FRT3FYVXG3E?=
 =?us-ascii?Q?4HObgBcdC0F5L1TWUnTiJiATikY2HlzDmCskBv0k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 382feff7-89cb-4a5e-942d-08ddde618cac
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 14:14:31.1988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2I4F+ekcyKXvNeXs70Gkd9ZgOmU6O7cQkpoaLt4v6JF/cbBO9vM+v/M4KxmVCAYK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6430

On Sun, Aug 10, 2025 at 07:04:01PM +0530, Akhilesh Patil wrote:
> Use kvfree() instead of kfree() to free pages allocated by kvcalloc()
> in iommufs_hw_queue_alloc_phys() to fix potential memory corruption.
> Ensure the memory is properly freed, as kvcalloc may internally use
> vmalloc or kmalloc depending on available memory in the system.
> 
> Fixes: 2238ddc2b056 ("iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC ioctl")
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> ---
>  drivers/iommu/iommufd/viommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-rc

Thanks,
Jason
