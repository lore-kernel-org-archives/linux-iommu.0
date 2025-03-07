Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8E1218AB4
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361543; cv=fail; b=Twl35gPKRVIREWk0McuGfX5wW8MhCO1f6ewohH6otYG12/rsderzno/WFr1OMZTewTfjfcrl/HrQ0LgeqGUQXGJfB10gYZe98ugQO9Th/QVBRL6L5c2T9mrDQMN3hV27t/Ltew/VgJXkbpYBuKw9ltbv/sM7BVav6C9+tmJfOg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361543; c=relaxed/simple;
	bh=sNOsZrybKjT/xK+w/rbO91AzanpB6MSJDBBowxqS4zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XJEPzDS3EVW0o9D5BZVB6mk3xvL3MiSd2PyJoJ04mK3sXpVq5wCXwqWrJrN6hSWncG+AzBHNzb739CHsE9ne/3oMs2QTfZI/IrI5QkpX7bQGeT6xxjvsMKSsGDhQwpMe1eZIoC1+/J7xHuiqPYAllxJQsbKuo4091/5wyejKzeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DsP3FUgb; arc=fail smtp.client-ip=40.107.102.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DsP3FUgb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vp9HlOMBkS0/FEjTYuwfEgs5en9Jt6aV4CQYTvevdmVmWf7L7do3AFAyWKgRnMWnmQdWbyMuuYcEREIjnNlB+HmoRmVhF9B+I+8C6ocihOAb78JLdPvvBz44cZvlaP4BxCVTjXUAIERsMBGgUeHtTn7FeVT2Pb0zg1jQry3wayrXgiyoiL30ddWvYTujqrkY+PcmeaCP+LeQIU8vPONCG5GutMK6vQIEr5I6HcwhffnFMopBxrHjuh0EL+F5wbwZQkbYZSNdtgN2MmpOW5xLhIFVtLYt3rR9iO17et/p7mh8hsIzhixZR7kKz1F2zmSh6ZM3BRQRH0pvQ5A6l5Zx7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTZiP37sQxjDaJF3J2WWmdn2Og/Mpb1DLf7rYncl1o8=;
 b=xCZW1Kzeqlmnkt+KAT01zywcsuXUVizcdKvBCkDiI65y7pjcPavvqJ8ML3O56lIuO+C0oUArdIpJszP756EI4ZJSJAPHrsPnjy4S6AiU1P4MuvdKvTRbQvJIDtBCJOUOoREhLLK0k22DsAnKRgAxpXWB+kMgLZ+5NycBhDWNGaonYh5NbeaT5nXB7SlSei0UM2Z2m5EyNse5bgbY5T0H/dGFliiFAqWeMdtMvzxbrCXEUQi7vm5dojbi+HhtkrwucKK/tnTzSwoLI53Nq/U1xtUg5OwvA5H6ShyMze++kugKhuRQr/w8mqbswal4gZ1wzdFlYYRWrFHKY4ja5WgHlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTZiP37sQxjDaJF3J2WWmdn2Og/Mpb1DLf7rYncl1o8=;
 b=DsP3FUgbKRxJP9yEwUYZzuw81eaODETmmr35ziAw7WOmwMRTGb8VpjzJVtjA0GgaPrQD1rlACwE8qcOcWshSlB6Wkx3tuRfydhWK9iyTzWDKJKzXEqlZRCX4/pM0Nb4UH6h44opgNBTFUK/odjqEEfzl4lhDOsLpaqTLmhNqF4gsu7zrg6bODWFWG5480gqSv458kXXvYdvZivf7lXjyBkuID65kPX+A7CY+h++K/PWkoZJrlEAvjvBSqyhZR5ICInP8Ym0SajwDJiY7LOX4DHzC2gNrkKWMqF+pcvACHF5fWH+j/KIZNbNwvmmfr38N+KTS9a40bt02CeY+ZH5B/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 15:32:19 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%2]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 15:32:18 +0000
Date: Fri, 7 Mar 2025 11:32:17 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
	kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] iommu: Sort out domain user data
Message-ID: <20250307153217.GS354511@nvidia.com>
References: <cover.1741294235.git.nicolinc@nvidia.com>
 <da7cc6d365ec6a77f6e6007f898eb3de2e581f80.1741294235.git.nicolinc@nvidia.com>
 <fabd6483-af48-4893-b539-2835640c5316@linux.intel.com>
 <Z8qKyvNyNU6dkN7V@Asurada-Nvidia>
 <16690409-1cb5-4b58-93fb-e5919ff1fc1f@linux.intel.com>
 <d9a6c611-2a19-4830-964d-44b711fffb08@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9a6c611-2a19-4830-964d-44b711fffb08@arm.com>
X-ClientProxiedBy: BN9PR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:408:fe::22) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: d66a29aa-711c-4753-e6c9-08dd5d8d3f1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qj286aW2kVWS+diHHJGwPi4u0h84b1qie3kfliV8ZUq48UEDVRBMqH2SnX9m?=
 =?us-ascii?Q?sgUSi+4bWKKu8V3LAaV/6QT4sSc8v5Tf1b5vZvMuwkDIVdTsVwVOv4OVzZK4?=
 =?us-ascii?Q?UHNfoGOyOq/yj6d+qEmJ0emOTQAXQAVCHDqaMDJJIarkbARIILP079x9a+p9?=
 =?us-ascii?Q?WGNiCzixLPpz08rf+bmVhkFpjOy84Y0jooYKlMZajQ+yH9XZSTPJtKoAgzid?=
 =?us-ascii?Q?HEPoPTjVePu8oIwwsUSMUqf4OMsE3j1ANlN2IWTD91YmfMCzJlep1Rz/febi?=
 =?us-ascii?Q?+SmoE9sXoP4VmwFQU2DM/Uoyo5S39okV0cfUO5EqkDOjju8c5Hc7KGM+3JQh?=
 =?us-ascii?Q?vPNu2r44m10kHEzTyE4PpWK5aWSMtO2RQmYV8zGry75arYzrw8kCggMhdMKM?=
 =?us-ascii?Q?2p3ik2IOg0ySA2ylYPLn2SMChbGFwlUY3It07WWw4Q57TdojA93yZgU1N68Q?=
 =?us-ascii?Q?uetVhrrC4JcqPc70S6GNicfcdL3JDBB2Xw+YOYBv1oOpHT0IaehY8RH/MHIP?=
 =?us-ascii?Q?IujinrSfDXZdJ7+kzquo8UyFi62kMrfaz2N/+nAp8eRRjM0LzpAPYE7udmQF?=
 =?us-ascii?Q?9vvrtq/2h53rmoGvo16H2ikScjkMPhWN656A+IANwpeyvsWn8N7F+LsOO0f9?=
 =?us-ascii?Q?MpU2QX+5W2+6v+zGGK9ho4W9bp+PPA59oF7uQ8Zbz0KX+9zV24kZSzr56u17?=
 =?us-ascii?Q?H3qgpuPorCTP7JCsNfTgRG3ZLqktUwWZNCIZGePWFje6RSZ2zY6a2rgNfG0I?=
 =?us-ascii?Q?ztPCKWdMTFWlKpFXamg/O1MPz/aBBLNbqoroP6PHKSohLUa9PNRraGoM0gPC?=
 =?us-ascii?Q?8j5u9O+TNUiYzBqMag9fvIRDLO38islLEuP/ZIgd9giWsfJLS/6thuux9YJe?=
 =?us-ascii?Q?fEj//ZeW1jxDHASSHDmlBeG8mpSB2h+PLRRKoh4mVR4aNKxXRWX8YXBQuDGB?=
 =?us-ascii?Q?KJDGx5CBSfE0bjIZIV+TUEC83TC8Lope/Y8oGhCqm90M3m72FAywjYvTklnx?=
 =?us-ascii?Q?mXsV0GChOeBAK4HiRcXz8dxUIk4ItV4gtTgHuRq5tD6z+zM70jU2DpCJsXwz?=
 =?us-ascii?Q?zRVzzwGyOa8qWJPU573JVDhDEbtiwATeiZ+JQJpK4H8R/pPWj+cU/JtVOYWw?=
 =?us-ascii?Q?GiAT7DFMZWf4vCXP29uuwYG6rqqZl2QsMyDx4uHMBaJ3PLoDFfx9gIFdX0tD?=
 =?us-ascii?Q?cp10HsKvjhWeSJ+zdg1VXK0cyHOH32YJdhCubN5wNAU79FRqM/dAzkQ4pqcC?=
 =?us-ascii?Q?byBf4iyCM7mI/ZGUC9pUvyJgVvJzKqYVO7dYCr17JJvnuw041XenI3CnrNfE?=
 =?us-ascii?Q?tS0DD/mtcAQ7d56ivRnwAztUIRgI7UoCULx4g/knnRndu7bURr0L7/xpY/qu?=
 =?us-ascii?Q?dVzAqxH14ZEVmIQGJ8TyaO52Nn7X?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v8MUJvx/WU5cEFjpRVGfzDnR/SMwrgp/Nun1fRGqSrmU0wEXpsUUwS0ryBgK?=
 =?us-ascii?Q?pKTaVZK5QW8Ml9nCLrPMFHHq9KPKCTzb7WiTuUJ/taPPy3dh8sVjmDnY8FAa?=
 =?us-ascii?Q?BQZ1OsGTi5EEcIZjNVTdmFnldhMg140dfsPFbslfjq1Zew/2YGwRcpctAnDg?=
 =?us-ascii?Q?iRKjIaLTh/wYECC6cBzZzq89rhC2EPwvX6Hw+cyDuzpjf2f/C7FiGxRAI7tu?=
 =?us-ascii?Q?yzwr22Sw+Lk7GhPdI3x0SnIQRnmpxrNMr4wzHka7EZ0uRzKm49Ri8atq3LMf?=
 =?us-ascii?Q?IPdh5YLGTXUDrEY85YjzP1S3Rf17aNx5/ZpXmewN8b3Svlfcj8G1puhmi7Zu?=
 =?us-ascii?Q?GE+f+or7ODLzPRmr8gRVB6toE7Z1JJdEQooiNWTP0yW6uVxARXkZrrYcZEJk?=
 =?us-ascii?Q?w/NNJNeWyo9ku3mwVqv4JG9xhXeQHuDFfUYLTskv99SOKQdW8mBhhBv2zPdh?=
 =?us-ascii?Q?oVnogmBH9wKUWLNkfQqbvyhdSjqhj1rLafQcduFFRUlPJ32H/LJi5evDuv0k?=
 =?us-ascii?Q?qX1e7tkk9RI0HYC65xXZkrqByo8qYntvMlrnKWAyuhc7Haabzpg4jaPcPmrN?=
 =?us-ascii?Q?Ac9C7yBBubTX4ZOFoekahT71qJE4kxwICQude8rpmLA8JqcRwJYe6tTo43N5?=
 =?us-ascii?Q?JfYfJSwP5pOL+Q9QnpTrRGENj9OnWXMfoTkBrvx0JMJyn7FKAmoIFc3Tf+Ew?=
 =?us-ascii?Q?3S9jZ3EcOOKzkNm0KblRsij3dDEhWXtF0Nje7LJK4vdUzOhk4mguLz2QmY73?=
 =?us-ascii?Q?zy4XyKxGz83yl15cVo8hIIWk4wjAyRi7XTIXKKRM9AmedE/8M6sKbSjnhg5R?=
 =?us-ascii?Q?09oVyXXIBJLwED9pslNDBcUGV6jY6f81y4EADj54orRpWGengsw6DVvTWxx1?=
 =?us-ascii?Q?6zjotSoVNTAZVAHUe/ShohWbaNnG0LB1ANTwIZT0hYaj8h4Ewy0lIanr23Hz?=
 =?us-ascii?Q?youKwGaMH/U24F0KhCRzXloMiFGO2/Wo34LVx+Pi7k3fWCZwslDMPXhLLNVv?=
 =?us-ascii?Q?E2DpDjlXpXaj28aPX/RYA2f2kLOehwGfjWJNFnP3hELeGiUn012W/kXbO/VG?=
 =?us-ascii?Q?wkOqE9SvZiuuQTnmhoCpjSMwDpZsHi6UlkMimgrAPZyrVztujFGRAGuq2AI3?=
 =?us-ascii?Q?FTjIVgJnns/4pLBvOKzQaB1Fxh8vknyxi7BsjDZmUGrAJSUel6/qZ7ifUXRy?=
 =?us-ascii?Q?92dM+juxo6R59SJNE4KQxe5DJqv8bYFhyBWakPLOB3tGrIcfwu6dn8Vhbhp0?=
 =?us-ascii?Q?FG44JqbouB7Q9puFFSaehxsreiK9z530dmwaPwxgkQagHy6SvKd3gPGI/1R4?=
 =?us-ascii?Q?Gf8Vs+ApLLG+SXc2Q8dXQ1munFJgZ1LjvY+m/79+CK4qwbVOPoHLo/kM8GoA?=
 =?us-ascii?Q?gZFlvEsbCOmGlg/4DgeAAXEzL/Iy6+OD8u9fLqA36k/THJFZ913nvplXUqL5?=
 =?us-ascii?Q?Aa43LVrrxYallTMEB+JcM1Qx1sBvHNcTBV5Nr8Ky1ZLSbTK4b7me3NZ8b/or?=
 =?us-ascii?Q?lvpWxg+lmmj330ro829MrIIipnZ0/yKKS+pbnQKtkWRLimT95t94/p/cPtnh?=
 =?us-ascii?Q?sGqy/y2zol5UODwmOPsSc6IdrzVh5J8FnhT9lZiO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d66a29aa-711c-4753-e6c9-08dd5d8d3f1b
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:32:18.8988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FuVwpIFI2pWnkoi9nXTnm8nK9twLNSW8aJZi3+zO5rcqTNGQFvLnx9V/uNYNdULO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388

On Fri, Mar 07, 2025 at 11:49:36AM +0000, Robin Murphy wrote:
 
> TBH at this point I view the fault_handler stuff as a legacy interface which
> we don't really want to encourage use of anyway - it's already proven not to
> be great for any true fault handling since many drivers can only call
> report_iommu_fault() in IRQ context. If some new case does come up in future
> where this mutual exclusion gets in the way, I would say that's the point
> where we then look at reworking the whole thing into a dedicated "fault
> notifier" mechanism instead, which could then logically be orthogonal to the
> IOVA-space-owner cookie.

I was under the impression we would go forward with the PRI focused
interface we already have:

	int (*iopf_handler)(struct iopf_group *group);

And this olld iommu_fault_handler_t is just because nobody wanted to
go in any update the old drivers and DRM to use the new scheme?

Is there something fundamental that would prevent iommu drivers from
using the new reporting path?

Jason
