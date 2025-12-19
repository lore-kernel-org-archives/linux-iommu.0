Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C92D35F8A1
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766159520; cv=fail; b=RyBhngMNpmDzRQO52bcfwZiL4GtWvIUBq0S/4LvdVKNsKA+4ccUi9LaTxXnmDKXu9Paz0i6X4zZtLdsxFs3OkggmgdHA91+Bh0caV1Tj+y7631cKsCLioPNQpyGxt9fQX++8FjC9Sedcp2XFBPAMqWwNm2NWYTEXAU8uVLG33yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766159520; c=relaxed/simple;
	bh=Mn/z4skF+RtTGoIckrUK533tdQ9qnGDgxb3y1WIZsBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mMmKs5jqNDbnXtEQyThV+gNSnQpz7MvUSVgEWvU3uw2vpYBVThg5dNcbdfQgLdnEFDJ8L7I7FQavBXROw4vva41mPh6M7IRqDtrA1uT9fS0r1Z7BkSo1RA8qxM8RiTf2xWbjhXDm88zlnP97daXTPvzIZKR47JFAERDFv+ziSrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WImCysXn; arc=fail smtp.client-ip=52.101.53.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WImCysXn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGgOSGspCGmj7OuQlWs58+qIDrzRKO650K5X510VUtjCss1gPYj+Y+fL7+pjTYNYrMC16LcMPJpYaEhF6UZHqt1W0anIQzGa1O+jVhhLeYZDx/50afHoEBg89EyhBAvHAS3LycXyd7L0bRemUIlyEtS9M9CXclcjbwUZrP0rW13REt0jV38NZFyT3f7yBPiN0aNWN46hdNoXP48Nym7dZWCTZ/gcSeX+BHP3AzufxlQHHwk/gKxqx+ZP8p30OP+VVxY4675FU2zl9JgdQfzTIuw4+ZqzU4xycYzd5DIuNRK3cSxn5OLmE/cCortpV9EhXIVfKd4TmK+fzRbbnQYMSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYrPKQey86tXjaVK8dYzyj9PL+ssBx6pXjEDiMFEuLA=;
 b=Mc3bSYbpVKp72+RxDNT4V2Y5Sn1icR92kxKDtuVbsdDxtGlBJKsO1GtitbTXj92I9Dai6cUXNj7HUdSgwWYy6bKZOgbDnvnWyqJA2HlyMhA+LYEFH/LMm8myihrwQfdvoskmr0GlhDeqba6ehLTaDYwGf2MQeUyBjsT4Cze6HJzvMXcwvmz7vO1fme7+nZWLmR0YrWZNrR3djVo82F0wCetZ2xTMW9Ok693a/xD/vHa7tdQvStVh16oINDuYW0mCVxfHsDER3A2fhM+li0ZBCJZWBJ+5q24q7ukAURFQV8ZaHX8W626doCn6D7rPHYS4t5Jda6hWH0QA5I2jpyK9mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYrPKQey86tXjaVK8dYzyj9PL+ssBx6pXjEDiMFEuLA=;
 b=WImCysXnsh0seHcdo+Qt876NjXD0DiH+M18JWum4niozO/eCOgHN0FDOMAFBo2q0IvZ2JUd3mvZe6yLvNz63+qDSYlnQcupioD00McUgn1QrSFaWFC7dqYkMF92VLA2fPOcp5+4rMJMcjK9NqbXIqd8LJfRWCn0nJDPmhB8C+f3Od4dDo4tvHysTikdkUiNvWRC7ZBPgUzlxGsMqg36mOpqNAKywryTkip4Ieq4WALR8E7ILG8oGCKPk82oZEiKBWz6GFnPhBOBlY4FwFHIyiz2UNWlEKrxtLc40POvmPBNss2Bsv0h6KNFqnv2q2TMTTp3w2ayHVPWtIXVP9IG01A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8746.namprd12.prod.outlook.com (2603:10b6:208:490::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 15:51:52 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 15:51:52 +0000
Date: Fri, 19 Dec 2025 11:51:51 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, jean-philippe@linaro.org, robin.murphy@arm.com,
	joro@8bytes.org, balbirs@nvidia.com, miko.lenczewski@arm.com,
	peterz@infradead.org, kevin.tian@intel.com, praan@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/7] iommu/arm-smmu-v3: Populate smmu_domain->invs
 when attaching masters
Message-ID: <20251219155151.GA373575@nvidia.com>
References: <cover.1766013662.git.nicolinc@nvidia.com>
 <79cd18a1a959ee2e54683e8c465b799d49ec48b5.1766013662.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79cd18a1a959ee2e54683e8c465b799d49ec48b5.1766013662.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:208:fc::41) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8746:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb76921-528f-47f5-259d-08de3f168737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D9fdvmya4/SSf2pnIN/+wIZZI6j1x+CufB5441U1jeSm/+UYwchvqkh885Gb?=
 =?us-ascii?Q?4VR5bjuBQtODPCGbQQwv6c4OICOwyNdNMdMqxfH6vqqNv3NPPRX/xjZYbZBx?=
 =?us-ascii?Q?GXj30V1ngQx1sWykjMBNhbeinW5fHGIY+ApW9Z+i9Ewq5j9FPVPXhBdhKs8z?=
 =?us-ascii?Q?6WbtK6BoFzjAMKyefUB92QFMHqHFCjdWm8/Cj6HDzBuAHBxGtea6Z5U7zLyO?=
 =?us-ascii?Q?D0jeYxNbxnCOO3YG+ffbvC3FGoClLZ5KtOppuGhRDwwyZohVILtkH+nl7E1C?=
 =?us-ascii?Q?i2rO//mulie/5Fa7xR+LFLr4IfTsH5p+HHDlhq8+kfJ808ewBTkAlNXvfAZy?=
 =?us-ascii?Q?dfJAvNWprO4Fw49vSQfOMxC5TW42ZA9WpZsFn+3AKSn2EQKIlZjksy1cUs91?=
 =?us-ascii?Q?oFOozvReaPwAy4PaFmGG8F0o947Gt+/Q2dzbues8iB5+IDxUaG2WkSh+ITT6?=
 =?us-ascii?Q?OjFlKptm7KXNiKzaLFgiviPYhfsxitUSOVpvnwZX4y6WhxI7jav1a4USMaNd?=
 =?us-ascii?Q?b4on8ebCts/jcYiGU3TM4hROM0B/rb39shNkCfgPzssY/KPKRi1PAymP9iLh?=
 =?us-ascii?Q?xrcPK+kMvBVh3sEUDFUZj8jQon/3KHRFQqgYUDYASMTbAAZ9DofVHNk1z2pl?=
 =?us-ascii?Q?825pjDh1p/8/W33C1qhVY1126kKwbmPAPHkCrZpDJgBy90Jn8F3rFLN4ytn/?=
 =?us-ascii?Q?Zd1pkSPUyCWXkkWEVkifOah4GRt1Uyvfyyz+qvix8nzVxouGqXFI/O1fjpIZ?=
 =?us-ascii?Q?7xNP6wXiqBO1cXz7e5KulhS2sUzgRRDd/iR0Mlj0Z9z0H12OD3yiHEuen3Z6?=
 =?us-ascii?Q?UBF/pOEGMx3NxkpIFnEwzR/LS1mOdNeDuFKSg21Zq7Yq1lgrsH7l0vtPNWv7?=
 =?us-ascii?Q?MO8Qs4bvYavHUIoK6CeBZC/8sc6q2s/kSpHP0C8ZleV1id2CIGDvzoqGuo13?=
 =?us-ascii?Q?k946faJf3LUx2pJEmoAXkPZ4SOQd1IiHyCCf07yK1TQKWhKlGakJUf/dxe0p?=
 =?us-ascii?Q?/L04zkx6vktecXdFqxuUx+z4TLQ5w+f8twMKDofioLM/CHvSWN6bBCrWLb3H?=
 =?us-ascii?Q?1TARNRcalXO8Zqkl6e/a3MxrkEOQl0rGF+dm88sdqeSS+8+cQ9suZ/pZ+/4t?=
 =?us-ascii?Q?H6WtklO3kkQ83bX6gTM3n8nXqAj0+AYj658PCOj1KkuR83FzVXbuEw++Stm7?=
 =?us-ascii?Q?uM0HjkPb4v6UFVn0cuW8Aa1spLTEdHeX3VSCdn6aJu4nTF06cWYVXmD4iiCR?=
 =?us-ascii?Q?ua+DENPFqPDFynrDRXC52gLgHSTFJ9lURRPQUsTK5hkZLwtqzUuZaKfJw8g/?=
 =?us-ascii?Q?8O2mKANri4kKTE/6mkA9P+x/mpVIEtKXUQAdevNYXshNvAD5eT1baFzb+qnu?=
 =?us-ascii?Q?hmbqg3fkfLK/zF+swHLLTUEcYwKyACW2i+JJ7sM2foVDYvzvw4y5O5AjFknT?=
 =?us-ascii?Q?lUezo8aRYgxplcVjTz+OS32HvSS7CmHw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BRvMTjzNcjCI15xWeqB+lbyGQkaxiLXg1wRc2g+DeGUowYhsozIkpiFWhh2B?=
 =?us-ascii?Q?dyh8bq5J83Cto+P8Rac3ev45KVEhBWotcokzKwmvR20dm/hZzHxSiqNd8eK4?=
 =?us-ascii?Q?i+bcTy9byDpBV/c7Gq7daUxXa7iDfHL3ygAj4xMyYGxEMXoNfvCOxokS2fPo?=
 =?us-ascii?Q?0Fux8cYrpyUwF37sKpWU2dxPXkCPsofwsO3JYcltfkgtWB+w4By908VFL6jp?=
 =?us-ascii?Q?PRTQovA9qlYo6D5T974Ebj5SuPDnLIiI6360ETOdxlPVCFld6J3F2LqEMPU9?=
 =?us-ascii?Q?qZ2l2eH2urHnIlC5ufMQInwyrdkZiWc2lhTzx84qd6aV286GVH0U9XzT8k/1?=
 =?us-ascii?Q?ATC/oo7Zu/Mnga4tsbxXp90XIBTWzsNVEttdn2NHuGjS6MO7nvw9TewUDOC1?=
 =?us-ascii?Q?CdBFhEbzi+hheYtb6Iu4ynP7YdOvoNNmYmsV5pWW715VVar2Oe66X7itOhyt?=
 =?us-ascii?Q?uaT1/PmJ9scnJ/hyIspsVHzZvN1NOqTUHsp/ePw9NX5gMQ9b7Yon5FEfiYjB?=
 =?us-ascii?Q?p13ZRMjfAAIXR03XUr4xPQVyKGPaSG5Dr88En9zPnakDktvNfNLz+VZgw7i3?=
 =?us-ascii?Q?4liwK9D8QcctuTjDVrxZ190N/lZBT5KRnq5EO42lm5fASurDgKkG72ZO4Z1+?=
 =?us-ascii?Q?dYouPqtJHRi34u2T04EasR4YK9qgGxfLtm08162BG53ODqjeuND3c4oTCIm0?=
 =?us-ascii?Q?e/wFesuauPgp++TQtBxapIa1eR7iCswDuCqff/ut6YGfjmWtIBYUjfnyNZCJ?=
 =?us-ascii?Q?hXEKWGwJSaTgvv11UDtBuZDtzvPw0sDtLo3imTb+GE7tISWWiD6VYnL0aNsT?=
 =?us-ascii?Q?mqayCSR/u6HyKqKoQ686+d7dC/tGOgoHj9UwpavbevYjQV2QBAEa/LofEbK7?=
 =?us-ascii?Q?ZbN8VZZb/NUVa0aiS+XD/Nbcqfgbzv/F+Q3WnDNIunH4GJdYClgJWJYaBw+c?=
 =?us-ascii?Q?WzuAQDvjFv56s+xYUMfRTGlwpel9nrkxDsN0j1UM3dPGkeFjO4nFWiva/x32?=
 =?us-ascii?Q?f/K+lkAzE3u5QZ1wdheQv/xtwqhnp31p9D1kyTOXsoL0q/Kod9DdagwCjNYT?=
 =?us-ascii?Q?aNwR66caeg4cb1V4purkuM7SnQtHy+3UMCZCyyOVdf0omRO4cwqOJDXMyfec?=
 =?us-ascii?Q?bvyBxRt4P9EQrMsHVl1CWheUq1ijUJPJ0n29q45NNSdAkneN//+uKJPax5nW?=
 =?us-ascii?Q?b3/0jhXRVDC7Cq4XXMLIw6/krOyH8XzvwubC24CZNR5G/vV35WSljXj17NES?=
 =?us-ascii?Q?u48iFBlX6yaRYsZI4gizcHL96lZRK3guaCY4wd8zUSlQm8DG/A+MLX24umJL?=
 =?us-ascii?Q?FvNyEZi2mQS/XfF2shq4MeNX0bTslAHfHuotOeKYFktJ+LFjZ1+8F+JR5ab+?=
 =?us-ascii?Q?IJ1QWVRNRY9crg6CmwHoPa0i3byHsYk7qQzcOWSrzZ/tkuX/rTPagSxZhy+c?=
 =?us-ascii?Q?wlOBqyKH6qzTOrEf0161Q2SDLIpxH2D1Q60BCSoj22YXVycE3DgOgaJuT6NK?=
 =?us-ascii?Q?CoeXlbOoDCd31XNH9QbUiSeBbLr1s23pYakGb4ozeOhTpKOOOSAg8VrvUICp?=
 =?us-ascii?Q?hB4Ei/k9htr5iaDjjpyjdSXf34Aficsty/6/a41IP7bCiqrwVdeM0np1NtoK?=
 =?us-ascii?Q?8qsJmAMfPmAZljCvdeJEgSSa4LfpfhgzaNfj5dy965aVvpik2ib9czSB8nq/?=
 =?us-ascii?Q?x1XpdBTKDfKqBgYb/CYWqzgvKmlQmqD/K8Stfn86qMd6///a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb76921-528f-47f5-259d-08de3f168737
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 15:51:52.5361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+ffINoHKW2yMllGAtro9nc2d+eZ2aL0mNb1AGUBzhYVNn7aQa6tUh1lSwnD+TIT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8746

On Wed, Dec 17, 2025 at 03:24:30PM -0800, Nicolin Chen wrote:
> +	*cur = inv;
> +	switch (type) {
> +	case INV_TYPE_S1_ASID:
> +		if (master->smmu->features & ARM_SMMU_FEAT_E2H) {
> +			cur->size_opcode = CMDQ_OP_TLBI_EL2_VA;
> +			cur->nsize_opcode = CMDQ_OP_TLBI_EL2_ASID;
> +		} else {
> +			cur->size_opcode = CMDQ_OP_TLBI_NH_VA;
> +			cur->nsize_opcode = CMDQ_OP_TLBI_NH_ASID;

There is a tricky little gotcha here that probably requires a comment.

NH_VA and NH_ASID both take (VMID,ASID) as input since the ASID is
always scoped to a single VMID.

In this case the invalidation logic always wires the VMID to zero,
which is also the VMID the driver uses for S1 tables when the S2 is in
bypass.

Which is fine, we don't support an actual S1 table on top of a S2
table where we issue invalidations through the invs array.

So maybe:

 For S1 page tables the driver always uses VMID=0, and the
 invalidation logic for this type will set it as well.

Jason
