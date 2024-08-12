Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E443C17A584
	for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723488012; cv=fail; b=gXkZVOy0O+CFn9dK90TQc0/rKaO/ToMiqb6mmmjhTBRJ5Obw+JnwqSBMRuBrYLwMvh9/ZeUpxCLEhb5CIXPPcr6iz8kgfVBagikwk2nwkH53sRtWOJsByHxmjsDETmOBggtuN2wrnitWjA2fgvdIG9S+Brc++31Bf75ftQ5ROyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723488012; c=relaxed/simple;
	bh=v9+zt2BEVRETG+IB5/inLYPicsoCUfRiJtFLAvl2Og8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cP3lIHKGPOcJuL22NBGGwEv7XJldfi8Lq1dF4y/g1gNTxBK4MegYioYJZmWDL9Kbm0u/hapPZG83ygE+3GXajwIARng1Euf1RNWYpTDHAluF4Rn9X5kJvjtWvgj56a9s0C8sHFMeb8Lb+V2xy8GxFyCMUPVGnlHlRgJ1eCvdSqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sEIDnv+b; arc=fail smtp.client-ip=40.107.96.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sEIDnv+b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHe1tYspg+bQd+9SFWsqYnu4ppxx8t7XpfplJ3tmXy+9AMh95otSKo4EnBgw4dufu+BBNVGU2V2ln0G8JvqfHobe+twybu1tG7COvKNe1azG6fCyw+GSaBMwV9ghY72ZM1C3XdjNunCqEHq9uLHZ/Vz0ByO7z4HvfH8swMvFfCUMrcTi5AvcoMdoX62XPqJsaTzMRBwqz9RJWRP969+bqgJzTNwW2o+EYPRv16nRGLa/RE4epxBC61hYx4BaqcxiJMM5DrDrSMxq+cSjN9kYm0Y4iRbcxk5NS/+YSZjQpZWY4y00iFTEoTbYGSsD8XI/fxaJXq556OsV92VF7Lz8IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZxlQSqTCND/ICCMaFEj/cRPent3Hu7vaWrvx43rQOE=;
 b=L0LyZLC0drMOW82D3Eammqr/DF1sG8RT80BBndngkrsNnj+gh/0r2vWCEOS53pfh+wWDfNBqI0MSFUBibKXF9OuIzzJ/kPrGBy8Ur0KAnELQdD36aRT8DNPIkCtFuEDYYjaYYqjYN9XnYdmGrhkNrSCvhhQv48nNTbFQZ8+kvLbr3KMDS0xI4NO4ltvEdzy1EcWA9WlqtmnP513VUeZJi+TqSzFrT7BKcgAgu7m5+xEKfh9pWFaukg+zAZQFN3dYJOIbNOixHIeWOpTi2nqaZu2r8FPabnK8AV1Nihna6xesPlYwn0yRc7mgu8l8aLbpHsYP3Grlj63pRlVvhClG7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZxlQSqTCND/ICCMaFEj/cRPent3Hu7vaWrvx43rQOE=;
 b=sEIDnv+bBTA48IIS3rvJeffkVi0JShmCBbckb8I6d3RKH1CXql7MiZg0WX3pf8O/4Zp1sF3qJHWKK+K4R8S86p53PxVsyur+VjsLizkxPrRHt+NLi6UO8r0LODYdHi0ytnJcduOLIZJIZJCxRy1GMWJUNTxuI158o4wPOIpdhyoMUUvL3UnUnbp4HHvq1MGbmRebrFhMrw/vV75mAzDT9nD62WfiurTRZareeNbd+xP70QeHMfP5f1uPrCAaPwVup7Vc7w/a8+oSwfvGtoC66meCYn8Ti1bErpZOus69CgqVu9ULvD5RFulyOCNp5pM/qF634T5jVz3/BQvu0bmXNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by LV8PR12MB9263.namprd12.prod.outlook.com (2603:10b6:408:1e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 18:40:07 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7849.021; Mon, 12 Aug 2024
 18:40:07 +0000
Date: Mon, 12 Aug 2024 15:40:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux.dev
Subject: Re: mapping files for iommufd
Message-ID: <20240812184005.GQ8378@nvidia.com>
References: <a745cabd-5e38-4242-b3b1-da02c1e670a8@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a745cabd-5e38-4242-b3b1-da02c1e670a8@oracle.com>
X-ClientProxiedBy: MN0P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::8) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|LV8PR12MB9263:EE_
X-MS-Office365-Filtering-Correlation-Id: 86340bf2-e64d-469e-5c65-08dcbafe2fe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R2kooXwM0tIiFpBDoobP85yavwMwCWHuCR/OhDWfVrdePN+5zxcbUbs/3MDD?=
 =?us-ascii?Q?qAmKJcC5HXwmkcqt9yAVtZixm5OyF7cYU9PF+jPQH2yYMIHnzlq5ZXQD1Jf7?=
 =?us-ascii?Q?h5HbvDBrTmFoEzRciVzci8YtKBoftho5X0765T9hC83g4bh5RCdTQ1tF0DA5?=
 =?us-ascii?Q?uNd5Y8qHnD0gmRpWC5HpoMV+5y9lKsevHrUPwMKrOeEis+rbYtZKhJ69ZyBV?=
 =?us-ascii?Q?8pHZ0jFF9lgmhJ5R0PJlCAL1nX83QW+UrNAL2t3k0myj72PmGXMIthNDP5ZN?=
 =?us-ascii?Q?VL+AuU0ZoVlhBNKqqYVAewEiHlbAw0nj74LlIyEIbrJJetmzLctJkeJDBo71?=
 =?us-ascii?Q?mZIlBX4KuCqR1pFpmaBN4Zc3Kl1/5eeTfOSBk8tkcDbmgBFDKgcG7J/ErvFQ?=
 =?us-ascii?Q?X2mNcPy4YJccaM8W1p/bqi2C6er/GZkSXLH3RxuS/CJUtucRTRvDL5N1jBG/?=
 =?us-ascii?Q?jKzN85f8HGy4lMB9aRxdv13F50LsyAknTXwQmH8tBzPUA8dY+LVV07avp5Q3?=
 =?us-ascii?Q?7oSasL8IZgnWJO8XNva3TYKiHsbwkgHBA8Cj5v9mEX9MDRfABRD4MAVKUfub?=
 =?us-ascii?Q?yjh0CRjSxZ34QfGlXKzrU74QXdHhk/d25LKWlRmIgaOkI6uQp82Ppfn+xnwU?=
 =?us-ascii?Q?NiCow+df2+jamAXDDtodB57uCEtz3TnrQ/DZLKHcwOb1WupQoQqy2MAGC0un?=
 =?us-ascii?Q?cxujEpz/GfJ1i3/D2vPQg5bTm81wfSnARQ4oh73Bk29TG7kDN7ln8YaOoq+3?=
 =?us-ascii?Q?htoXf5vs0DE9Sx5mhElqAiCxPc/4flPoGA13twS6mS5iIm4dqql2aIIGEujB?=
 =?us-ascii?Q?qtYjDiPd8ehm05TGCYkGRuA1K6WY0V2ITNE5aywTO98/xvkx/QAV5/Gzxg7k?=
 =?us-ascii?Q?flnVbHsE63hxnkwie9YHwMxQTN7lm7ggy6kM+DCC6rjBGw9mxuGu6x+NiBto?=
 =?us-ascii?Q?cf3gEe3ZRvkMkjufjglBIsjhhiL18muvWUbMpuC15gIluNQJ5kEvc+mruEpt?=
 =?us-ascii?Q?Z99tErkvy4NnxJhQH4DXQsV57d8CsIeGnytN6z1UpuCWpfUhNLp/M0dcNNGX?=
 =?us-ascii?Q?4uGS+VeyGbEvMBg2VJ9QFSVl6M6DgHBHdpgmKmpxsr5rvNaH2iKWLsFZW+rn?=
 =?us-ascii?Q?/uGL9eKXKHM3UTd7jOqFV/v6dAb+4Zo8PWeJyXUM62kKHiJ3tnZUUpNIRu/9?=
 =?us-ascii?Q?y3rjLmn1cVcz9HYR5nl2N7uO+VQAhAfBMhK+EmQShEJAZgYMf4rIUj6gdbaW?=
 =?us-ascii?Q?u80hov4GiULGp/Ly/9LtFESI8T9EvY8ummLTNqLvYdHAsqn4rGwlZ8GDdKUa?=
 =?us-ascii?Q?YbpfethZcJWx2bJaqpvfUUdrmsiLGuEdacLlWfzgaZhqSw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1e2k4Lvc570u6wfRFgPc0c7uCCzEn2dxMuWkeny3Tl3IfMPJFhehTwuPVpM5?=
 =?us-ascii?Q?Vjsk9/dgHTvrgtcXXehFk0pWfXkKmdkcLZ+nEo6PXIChCBxf//FFl9yePjKG?=
 =?us-ascii?Q?XiTIixrmYfkDhfX+LC37t//YoDR/o+DeTLkzPkR48gerkm9mp8iL7+QraR/Y?=
 =?us-ascii?Q?z+LoQSa2EjT66EuRQPnDM24scrxfSvLMFRRmJUNT5zttbyUreODNRU4fD1ns?=
 =?us-ascii?Q?RJCjisMeZ1Gq5vCamX7RklvyruOPccLgKVh5FQlkO+NDFPDkzPti/XOHnrku?=
 =?us-ascii?Q?8n90MqktgsrhSyX9meHxKHBzg8qYX3kQXegxzHNjyq1wysgSrog7thNZcMsw?=
 =?us-ascii?Q?OOgx4aSnzTRXG55sXKfHjnpqII0ZLfAqGQnLjlCxo/sJrH+P6G18q0jtT+lj?=
 =?us-ascii?Q?+JW/9HOiAz2Nw6vd85LDH5ZlFmUGydody3yLgcdkZk1oJHVmCvFM1cvrT+Dv?=
 =?us-ascii?Q?fxHia/EY8H9dRquniPB6jrnL3M5GVWa5GLTFvthBTwk/faXOfJnoLAGzoNR7?=
 =?us-ascii?Q?SUS5R4E5DJFw7iZB3+H9jh9b+eQfrglX8zuVIgCAof+PR5WLrIJ90727YtiQ?=
 =?us-ascii?Q?/ZBqjk+28HDhFOinNLLHtej1iwV3LoySy7MxW7i/RZXnb5m5HpY7qOgCZoYg?=
 =?us-ascii?Q?NgWujYwvIRxo847VTfmkWy3t8BioGkIxcX45Eea9D8C7NwP9UGEuegLXfsT5?=
 =?us-ascii?Q?6cNHx2gS4eBh8qfTlXryM6hOHsELi6bfPlajFDm1wvrrAPNzf+q5DJ3f/uLv?=
 =?us-ascii?Q?FopRIbZPu6S9jgvrjaCyToFla0RcOsf9w8D0teP9q+TmYuow4hCkrEv4EkSk?=
 =?us-ascii?Q?60w4uYCiA+2sBxPdfooHmhuNrcGt18jiTUy1n/96wztL5fwmLqO67pfgSK/0?=
 =?us-ascii?Q?kJ3GjeOMxtLejlk7DNcBhqu+l+fqcxf/ZhytMAFbCP3B0+q0O5o13txMZDVQ?=
 =?us-ascii?Q?plSaHQWL5lTaabAyMohN3miGOI3quCp1WersRFYUmTt/G33XWieRAC6Y2EL9?=
 =?us-ascii?Q?Ugq4UTGbCAu87kmlDdxlRrUje1uwc92CcDN4eJHWnL4Bdew2Hwr3w/SgQuaG?=
 =?us-ascii?Q?M7fFZOC9XaUZUBeUoymr4DNumfKjcWs8u4PlxEaJX1cFaao42EWGF1YDTgIF?=
 =?us-ascii?Q?g3EQzHFl2N4WUTbSTHfTExAmDcZFWTZI+HDVqvRq+sIgBC1v41FOfKD43II1?=
 =?us-ascii?Q?BjB+vDH7Eao3t3E+PabvqjvXUg5U807vjdEeY32L5NTspj9reomO7Jb3jP+F?=
 =?us-ascii?Q?dGObCyyBNLJZQLGCceXqv3I5GhPkkNenoq8xq0VojxGqcBKuXJWbu+hUixFR?=
 =?us-ascii?Q?LK8qvS6/T+ppOruxgyuovNw5TzGQxkTBBYX2Tzl6MDZqWXcwE5xFTu0kDaUL?=
 =?us-ascii?Q?20btJxjhMF+XXBk4VDZZcHqNfqKr8sQluZbJljS0Uw4vcceCFf926jTUM/kW?=
 =?us-ascii?Q?VYQ4d3Z/5p789hxkYaByG+pumByBiFQYXRgSJK8lhvNy8ZPhm4i1nyd+Dc1g?=
 =?us-ascii?Q?k/Hc2gyjf7xK/QrvQV5lApjcGPn5xH9B/SGi/Pu1xhGqjQe6FT6TL7Ndxpik?=
 =?us-ascii?Q?N44oavQGGSwwEuQJAPQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86340bf2-e64d-469e-5c65-08dcbafe2fe2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 18:40:06.9831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPiXep83fvZ7NrzqLbNuaIuJQSjvkaL+5KdC2JIFgE882TPubhu/yZUfgt5+yHBk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9263

On Mon, Aug 12, 2024 at 02:09:11PM -0400, Steven Sistare wrote:
> I have been using QEMU to test legacy vfio vs iommufd compatibility vfio.
> I find that backing guest memory with an ext4 file /root/guest.ram
> succeeds for legacy but fails for iommufd, with EFAULT in
> IOMMU_IOAS_MAP -> ... __get_user_pages -> check_vma_flags.  Ditto for a
> hugetlbfs file.  This is with unmodified kernels, no live update changes.
> 
> Is this expected?

Yes - I'm surprised that VFIO is not failing though?

/*
 * Writing to file-backed mappings which require folio dirty tracking using GUP
 * is a fundamentally broken operation, as kernel write access to GUP mappings
 * do not adhere to the semantics expected by a file system.
 *
 * Consider the following scenario:-
 *
 * 1. A folio is written to via GUP which write-faults the memory, notifying
 *    the file system and dirtying the folio.
 * 2. Later, writeback is triggered, resulting in the folio being cleaned and
 *    the PTE being marked read-only.
 * 3. The GUP caller writes to the folio, as it is mapped read/write via the
 *    direct mapping.
 * 4. The GUP caller, now done with the page, unpins it and sets it dirty
 *    (though it does not have to).
 *
 * This results in both data being written to a folio without writenotify, and
 * the folio being dirtied unexpectedly (if the caller decides to do so).
 */
static bool writable_file_mapping_allowed(struct vm_area_struct *vma,
					  unsigned long gup_flags)
{

Why doesn't that fail in the VFIO case? I didn't notice anything
special there that would make it work???

I recall we talked about allowing old stuff to keep working but I
don't see any implementation of that?

Jason
