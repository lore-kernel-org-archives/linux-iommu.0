Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766513F1AA8
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 13:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781530989; cv=fail; b=fkaJcHRv1CPouCUCNGC5Nndyk50tZDVt9gb540lPMF+31xvGxbyfDLjRA9GxIn4lZrvhuUGXPQ1yqpvw1zIqL6MUmZswmPkpIX+2rB6tzuS46Mzebe1o/kXLPJLue48SYWWTeaqGTOZMQKeeCnIUBzD+4rAHmkRUJJ/7Ngvtr8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781530989; c=relaxed/simple;
	bh=ZtS3JsUJE+m+HIr72yV0Z+Jd0YFVbSfIMbvM69lRvZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K3xg9nHplmbhJqf6+ShwBYXcXFsgwazeoUCztwSuPOYw1gAP9GDWNVZ+vKHvnWH835yzR1g9sX9fWIrVfUKQB3y1bK1jJF2ixcBhxIBKb0ViQmibLnSfEghBCWBG65YxqYAanWnoGzIWW4/XPUj4I/hVLhEVWjzfVt7u8qdyyME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k0qdat6u; arc=fail smtp.client-ip=52.101.53.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k0qdat6u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vtrGo+hRdEpAQwMp6XmOrN23zPj2D2emZWdGpCx9gJFl0ALVtNWFEig9/EG/WgTCcUOFw5T4RyYWmvyJmjxXP68rksvs957c2gp9AJ6VzSCh3Vvg2IMbBaCLbNhI5krtQs5U/RKHUuKgDGAZHeJXRjU3FlHQeQRf+Dz4/nQUPFMbn5ZM25xbJ97oKQbPiU0dsdDcmKEkPn45+J+xTD6Q5GLYOGdcBgf0qYYp1RD47WrOM/vcaRDEBJqXv/+MZXPizDZ8eF5QtVekK2ISxYvEdu+dMGCZhru6DJfJdmonfHWHG1flGJmTnWBohHGa8zsmIp4mSjvIoc94zKLEmp2CWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtS3JsUJE+m+HIr72yV0Z+Jd0YFVbSfIMbvM69lRvZ8=;
 b=MdkHIvTZGPMgoB0l62ZMwzgENESl0SwSCQNSAnPcsN9NGeFYGDIR9PUR3gcxbs9yFTDxHeVBHeDnCEeRAQS8wCfL9iLCGgzlfxpk2Xa87Af04/Re+dQ4gyKg/LkVgzq3a0y3L+b3Y0G/JxYti3+YRm6J3MEs2w5M0/z8fhzlb8yTsPFnyD9v7IXEqyWdEt2rJwghPFS3zO9zQjzr6aMnWtYnr4OqTr2ND6Y+9Q/gTRefEyu2AnFz4wL99Vg5cKQpFTxheUdDsbiqCSvktr7nDEUFhSujCh+SoapcO/zmMWQCuVxK/2oHlLJqyrRvh6cPnS3muEE1jlJ040zKyOD5+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtS3JsUJE+m+HIr72yV0Z+Jd0YFVbSfIMbvM69lRvZ8=;
 b=k0qdat6umlr/yz3KzDYTRu8+V1IphjA0QbXpYfMS8ctsu4qXDe5gCVbK2gwxFf7vm80VcUquNUU0APHaALgJAs08GyJatm3hFF62hnuewpLr2ZrkjGdGt0PrpEdvaRr1qj8ukb2QqikkyQzIKlxh00ks9aS2VgXQeHwyhTdyWNfD7IvQEbBHEIMFyx6VeFqtvgi/g2ZJLtLuA2K5AoIeEZqbNoxSNuJ7+2BiMrXWH0OzKOQWHpid0PTKdYGEWSIK2bpIPJXgt4oyC9rYeGW86FFyXDBZKgfNa2yg5EV54f+xqnPA3gXV0cxJznMDpJ8Xsfd1b7SMLnZ6r0mjL6sWlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7116.namprd12.prod.outlook.com (2603:10b6:510:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Mon, 15 Jun
 2026 13:43:03 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 13:43:03 +0000
Date: Mon, 15 Jun 2026 10:43:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Shuah Khan <shuah@kernel.org>,
	Pranjal Shrivastava <praan@google.com>, Kees Cook <kees@kernel.org>,
	Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 4/4] iommu/arm-smmu-v3: Process vIOMMU invalidations
 in batches
Message-ID: <20260615134301.GL1962447@nvidia.com>
References: <cover.1780521606.git.nicolinc@nvidia.com>
 <00748c5cbea95a938d032269001a598203b06bbc.1780521606.git.nicolinc@nvidia.com>
 <20260612135409.GI1962447@nvidia.com>
 <aixZzvVWmAFEDQZI@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aixZzvVWmAFEDQZI@nvidia.com>
X-ClientProxiedBy: YT3PR01CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: 832ca6d8-f57b-4f4b-243a-08decae4059b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|18002099003|22082099003|4143699003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	CErIk05n8bIfzNXEaVfmufHGPiEdvKrEGZnuvCy9jCVaESzr5v82jDD+rnecdRjPrWdWdr49fjz1iPWy85Gvb21K4uSbAOxUv+j8/n56aP/eGDmzB6RcbFdtc1DkymwwtCcHMXffMAipBGK5hm9vPqhgdGPMJnFBJ5n30DTP2NB1HFv8WG+ZFQaTSrzs2uQcsGah4119/S11WGfrJcV0NPzp5wdHgXkajTii36bfCi92VXz+iTS5XBobo8UUbI5bbFfnCmXCBm7K1oR8cUew6vUiZ/SbnIWjQFvUXEjr12yyUTSANVrnsmyb8SEYE/sMohKc5eCkvi5ZAHNSKyiYcOnu8G53sS/uGa+bd82DnUWonpxZM0IGozb+4Aft0Eoo9xXjtnj1UKCtJ9q0hGs/urrl+1JtCukUfgEJler0fhWklJ8ApdDd1B7wyEeTtJk2wuDFcy1OAscUQkUWc7rmCBnKIHNE5utVNkmAD935LrbHZIFK4HbW7MTFVQNxHhbQASqdrcLeFbjj3u73juyqZo07jgVCRCOr1a4N8AJnSjtQFf1Y3RIsvDUcFfjownPc1NxrjOvheHeBjMiSebta5TMd89sjzotQRidgCEAAIAWxQgDTsc6LUUX6iGSqr3Wuoj1+2OVRl/hOh5I/58L+zTYsHs5VciGJjVrVzmrbzIPXbtdpvIT+zjKDcNKtRRGZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uwKQ+W+xLKVFwKgIgiJqtRUqEDZMoLWDoetnhHRfN/M4R0I1z3qMZMuln7h+?=
 =?us-ascii?Q?aFtvxWCj8BM/aeDKJKWHsHgqEOKPidZgpekQmriKNjs3N8avuMv8Pc/eTbgQ?=
 =?us-ascii?Q?CgBSjynJ9cAROC8vlsznW7glLEQwemqKteopQpUDquEtkU1/jjiopfH7ju3c?=
 =?us-ascii?Q?/onOOFRUuXhdphLWXW+c0cl+6i0nIpDc5KYOEuNxlRbfWYyFCVJ0O68n6Oeg?=
 =?us-ascii?Q?w7sOZR/30TGtFRJ9ZuWug7We9PpA1nL01Mt05kEc8iFZtd643N43U8QYA4OH?=
 =?us-ascii?Q?R7BQcIRkFqcZeeQkSuD2/22CQ22wQWwx7Lpem2vk7OPW/dzkLQW73aENEs2Q?=
 =?us-ascii?Q?LjhYBklgr8XLjlNcuF0TcOPVvPtsOPEMcJbxa+FORJG/xhhhgWQpMJf44UbX?=
 =?us-ascii?Q?jDEWp2p432N/1po5f1ehJmCNtMLPpy/35Yj07DEQSKq7FYDlQkcKNerctlvm?=
 =?us-ascii?Q?bVyzzEll5nWtBqTAfABB2KWVl0m9xyy9thtHoHaBmrrQ24VavbUz38jQ6rN3?=
 =?us-ascii?Q?cvH6tBZzrAOTYf/3QqajEeEP+PI4nUL0m0rJ7qu/F+r1DToFeAMXjDflhjsi?=
 =?us-ascii?Q?VtSbSW8eV9SAY4qbimkPNrmoA2HE8lFtQY6Y86V6Ryz2f7q1Mq/I1FlqwgMe?=
 =?us-ascii?Q?j7waG+kWf9uk0q7bbagZMpIaltQ0ErAJirztGOBGFKY8LbC+fLNChJgPJgF9?=
 =?us-ascii?Q?b12M0wP4CYdHsJoK3ml4cLBf/2gEy5YVj5JbKnOHXIa+r7yG/7jEmCZ5tPwj?=
 =?us-ascii?Q?Uo55Mybie4ZSseJJEm7nyFHKzy7cNxPEEg8jmRx3uvTOAwFB8bru0o9Boazv?=
 =?us-ascii?Q?AwPwOxtEyp2RY7/BONtDKQrql2+w92QV5h3q8ewO+ZbW5I0t7C1dBWDWJ8Nf?=
 =?us-ascii?Q?ShcQMhXBFTxm06Lf1wEDqOdRkeWUQ/vTC9seaEpBeyuFMAyCMJ0iDtPwa0tO?=
 =?us-ascii?Q?okXTyCZOvLnxauKXaXBdDocH4/PBd1iOUXjYAlzPBPMJ59QHQKGoBHYZRgiL?=
 =?us-ascii?Q?4fzk6+EdiyxpB6uZCYgijMD4nd6jnNpfVcMBdoNvJ+w1jfjKRU+ZOo7Yh+Tp?=
 =?us-ascii?Q?zHeXvVKrMP+qpabkV2gRGISH4oOkY5wLzgbUozgn8HZGHNH7NzQyJzrn5D8c?=
 =?us-ascii?Q?wGE4MfxQ96VuyrRsE+ejtcFZnp8iYAH6urCFK+8M6skfCya712qayfnaGfQ5?=
 =?us-ascii?Q?lTEXiF6klt7kMVTJNHaArYLTtKbeV2l5st+9Ur7O6Ki+qbjMyVRUaXRg9/Ar?=
 =?us-ascii?Q?wpUuUzM81gq8O00srC8Ds46eTKCag1X0dKT6Qt+9ECBaL9RzC2SHJd6VAbPP?=
 =?us-ascii?Q?NptkYdtJFH9v0KG0YyZSukYEuRZra360YAGYYiEnEWk0LH8PFGANPkgQ4MG2?=
 =?us-ascii?Q?bC093rG0VF8ZAHq3dSN8IAceuYT+pzITx/kCk8QJg+lokQXWRKkH4xzhiy9B?=
 =?us-ascii?Q?dSXmAbSHVuh6ylp/PlbA7La74nF6q/0r6AwGEQvNUS7QWY21XRlHD1qjuNu4?=
 =?us-ascii?Q?GMxJTKC2gML8CbTPtc1YmJDHk4FtliA/geRBJeJhOwrr8NPlFNBWIqAG40wA?=
 =?us-ascii?Q?IK+4GN8buhMBomQChu1ET5dBIngk+u9E52rDan4l76PleKmC89saaLRAILjU?=
 =?us-ascii?Q?dtqLb61LOIqBfae9vSM3zaiVpC8ufjrcBIs29dyrl7Tdl/57kY9nS6mlWiWt?=
 =?us-ascii?Q?eSwu/MXbLVL2eOu8vY736NoI9CW5D0sXjkCaBnWtsH76wkzk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 832ca6d8-f57b-4f4b-243a-08decae4059b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 13:43:03.0790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MC8lAcnGrQvzIeks79apW2Ua7J9OzULsi3xFHDWdtHgbYpw3TIr0xoLEYcXNz9Zp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7116

On Fri, Jun 12, 2026 at 12:11:10PM -0700, Nicolin Chen wrote:

> VMM would have to know which command failed, to flag it in the CONS
> register, indicating: a) commands prior to the CONS are issued, and
> b) command pointed by the CONS is illegal.

It is a VMM bug to send a malformed command into the kernel in the
first place.

Jason
