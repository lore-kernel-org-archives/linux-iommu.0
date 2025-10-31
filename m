Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010067.outbound.protection.outlook.com [40.93.198.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01878194A73
	for <iommu@lists.linux.dev>; Fri, 31 Oct 2025 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761876028; cv=fail; b=PX/6OLDxngxfMKFt4oL+eZ7ZZv2Pm5HKn/tVoh7hXxHGDMAz6p+cSJ1Mhyw2JyOSGTydL0FuCVxCs/qgQZ1/Fl7W5mSqxX4uKqGYnqB8rIIGso1BQdNBDi9luKWE8oTCNEXDfdtJPRr4PXwddA+//KfIgCzgI9NPoQtyfIhRbXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761876028; c=relaxed/simple;
	bh=2PNZsfFWi/jPxixwYp3CbSej95NdtCALopup8iEwXQQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsyMbDBPbHkSwkv20I49cQHimkzTXIz1oGs6vcV/i6jdhWOLMtl17sPxJ6xZQNC5W4ZKGxTssTo0zIJhwNIpAj79ZscuOzoNDi8bvLv8R6QipHrKV8X4Y5H++5fWfljgyS4VYd/IuNXG+DGG7OmScwilOnjidkAmSrROWcE0muA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kitULnyE; arc=fail smtp.client-ip=40.93.198.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kitULnyE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzx1FIdE/AhWSd+FpmmpHFnT3Uz00g6aYcMF+hEkEk+N6Hj0+fuv9oQO7YS2uyEiFIVrgX9gwcLMLeSB4sHKwnS4fsJj0qGoEU85sceRr3/S8RhiM0F0yMtAEpQMgW21qIF6LAGZPYvjVFGPWd2OIiEuY55mXEEZYPgt3iViujF67oTScO28qyuN7q0G5vndbwhKkbjyKeEu9SsHEvb0xh1sSPO28fzsFAaBab+KyqSs1+JGY/B8QhQF5GVr6vUqqJzbzxutWA7KE/zBuEpJKIA6lgQZzaeu0CQtQ3zdeyau7FrG1WlAlTVVsoashZTl4/heJj079GURSGZEmvc64w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aijq0x58ki+hOIw2kA9obFH2zF5v3qVcjUbQN9PZVBw=;
 b=S1IephVnM7dJ11IJSIp8POQhZ3pgR2kLEPjzoBi6y1enghX1eNaHqo4Kg+/3+PHSCM3iAs+lbi5tOnqbJt0vXGVhQKH73nQOgD7TaEF6rlGE8KaJXxgnpaHwoUFwcCn+FyBPtCOJ9OvZFNBGGiR/8flxo0Qmvu7SbRkexGh6Qh7zH3HKmzp3WQzsMsgqSU69IB0SXm1aEIB1Oi9WGOVg/K42YziUyAr5mZI8rc1VSrViB1T6xgmz6e4mIOk/L2jKI5O3Wt75KdVuFWZSdhLjSFmeaGw6xzkQhrQPD/jT3UlbjbiFVLN5YTVH+5Cgm2uw/QH/8Deaj3DeFAW4+3/5Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.microsoft.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aijq0x58ki+hOIw2kA9obFH2zF5v3qVcjUbQN9PZVBw=;
 b=kitULnyEDzUsjKaD1dPLnKJlKGtEEELG2zrKGXn3wxMWI9d+kk/ftdCk8mOLV6ZV3sxOoAemRERXkmE96oawUf3RECRYYlmi7VR4Qq1/I5/Xy6uTCV3ygWELNPZ4I/79kbV9TUyuxrBxb5kc7XQarvI73Uzb2p+f/YbuBLqYUMFArSzK5PXJPWF6DqdLHs1pvGRClBuDxjKlWfvzNKTEdDE9cNPiBhY0ocDsJJVJnUvF/Ou2a8qqRNHNraNZo/9JZ1eoB+5XzeJ4fG7+YHakbC2oiMbQy4IRaSWWZeJAtq7V06lm+YYiNlfeV1IRnI0Nd8DrWFLOtVNfQlwImPyOPA==
Received: from MN2PR15CA0016.namprd15.prod.outlook.com (2603:10b6:208:1b4::29)
 by DS7PR12MB8251.namprd12.prod.outlook.com (2603:10b6:8:e3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.12; Fri, 31 Oct 2025 02:00:20 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::e6) by MN2PR15CA0016.outlook.office365.com
 (2603:10b6:208:1b4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 02:00:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 31 Oct 2025 02:00:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 30 Oct
 2025 19:00:07 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 19:00:05 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Oct 2025 19:00:04 -0700
Date: Thu, 30 Oct 2025 19:00:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
CC: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, Zhang Yu
	<zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
	<jean-philippe@linaro.org>, Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3: Improve CMDQ lock fairness and
 efficiency
Message-ID: <aQQYIkC9lmQnd27S@Asurada-Nvidia>
References: <20251020224353.1408-1-jacob.pan@linux.microsoft.com>
 <20251020224353.1408-3-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251020224353.1408-3-jacob.pan@linux.microsoft.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|DS7PR12MB8251:EE_
X-MS-Office365-Filtering-Correlation-Id: 5faea740-ca67-428d-37a3-08de18213f10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gLiRCgI793ob4P/4gw0xqtEewTvbOeez/P+CoHjVDj3SY6gEBLq6GqTJryGM?=
 =?us-ascii?Q?j2rd/l8eYH6DD+Mh5CW0RS6m2euUNYh77An9m3ZAusu8Fcg9QOYAt3kcCLNW?=
 =?us-ascii?Q?R9PNwY4gi5TJEGUhs3lMsNVG/w78cBmH8i7vdGSc644/CYujW4ax3GsiMdaz?=
 =?us-ascii?Q?k0JmBG3hQAgwOYgn1r7Ic6Cirg2RluTpooxO9Qw3be1fc/Vh6AfYla+C6D16?=
 =?us-ascii?Q?0y+Ocj+r6YS5O+m8Bro1srROXUwlg/v/Qu7V77Ux8pN8QLK3zRH5tAvxPtCI?=
 =?us-ascii?Q?j9mxUbdh7YW+E1/BXX6bd0Suyb36v2Rtz1FuSyXKKeXxGuPCEe2VgGXSnAoO?=
 =?us-ascii?Q?kg7VgsKxTmA5YR35fd++UJ8Q+ScWhqlUMrNHZP6KC5zTsxHigIuhJSTYzTtr?=
 =?us-ascii?Q?3/9m8z6LDVNGY8bmUCfZY+MffW0ptEfFKIg8c5dKSIAXNsam4MDoogsr0tQO?=
 =?us-ascii?Q?UgRpnvbGPtRxqKhLygLFouSqzRFaCQsQTebAC9ymFL9zUsLO+USH6r7AQqUC?=
 =?us-ascii?Q?SXN5KXZtUtuWcZoqoTiYKOlN27BehLq2izXyQ11fEzqTd3AycO5f47UBcLeP?=
 =?us-ascii?Q?Go3068qu8wBYURfD+oPkzpXZetSKXzxK7mPOu0+g5WieW9Fis3W6VG+B6kGw?=
 =?us-ascii?Q?jpMOqlpiPHvaezBlRFY5dwqbsWlvNB/YGWMn7hcfiy5g3YUPnmZBLwT+kvTb?=
 =?us-ascii?Q?hn7EYwNXyHgsDN1OGpmkBFoJf2x5u6KCZVLrtDsXXMKOMhp48yoB3Fu1Mg6E?=
 =?us-ascii?Q?ldFgRSBX8JsxaejzPpyKtBirDtMqKr0O7Bfk2SO48OEmMRKkYm/H6/cWUHBc?=
 =?us-ascii?Q?vn7fpSTfNh8S9S5EEpq3tUwigM1QEnWhOPq6ODPhXhZhrZUvOTbKMc/jZps+?=
 =?us-ascii?Q?WTvDEwFFNTNuUQuuYms0q3QM8O+vB/VgVD3GuTxQ+0N0FbRP0ZAbl5nxbjgZ?=
 =?us-ascii?Q?U9wDz+y40NizonApBlDolVI+YuqNWlEG+6xy59cxVWtkgyDwkypAFzAV/PKS?=
 =?us-ascii?Q?Z9WHKulv+LQAJfi4fFn9rZ2HEX8eIUU+nGAQkVLnjlafVFP/3RHpBKprKocb?=
 =?us-ascii?Q?ZZWWqK0Quf/i7eDlOH2yNl5QBT4ODUzD194v9HTTNDBRszYa5WrICP4PUh05?=
 =?us-ascii?Q?Bq3Gx8IXtM5jaa0NYtpDZHNonKB1h+c+qBrhmPOip6c8aGIpcLOEnG9hSZ3/?=
 =?us-ascii?Q?OYv8+mfsFggDdPzk4k7AO1/K1XpHNRhfwfWHUSMcaJe9vhVSMJk8mmvkMJ8U?=
 =?us-ascii?Q?5PCQEJ1yKYxYtAyCxaQFXMYXOgp/n83Y13nU7QB8IIemInxGUXhxO4/Eexrb?=
 =?us-ascii?Q?g+uj89FKyWm5pPUtgL4Kx/NMn4zZF00OKKHDPpKg9T7/17Djj3ltMfLUCTJv?=
 =?us-ascii?Q?phkM6aHyQuMoMbt6O0xOO53ACobmUsoaKVbib/V44ayFy4HwXAvusyqU0EmA?=
 =?us-ascii?Q?2dXF4SvTkajtO7MMM1OpzhVMpG+R+eAQdxEMpaI6Pjbi+bhUd91bGqlMDFWL?=
 =?us-ascii?Q?Zr4uqeCbX7+PQQSf03oVv6q61NEAS2VzqfzOdieQstQtsihqhlTwhXZt/+9G?=
 =?us-ascii?Q?huMsQTBVPzoDX+VDNcs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 02:00:20.2920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5faea740-ca67-428d-37a3-08de18213f10
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8251

On Mon, Oct 20, 2025 at 03:43:53PM -0700, Jacob Pan wrote:
> From: Alexander Grest <Alexander.Grest@microsoft.com>
> 
> The SMMU CMDQ lock is highly contentious when there are multiple CPUs
> issuing commands on an architecture with small queue sizes e.g 256
> entries.

As Robin pointed out that 256 entry itself is not quite normal,
the justification here might still not be very convincing..

I'd suggest to avoid saying "an architecture with a small queue
sizes, but to focus on the issue itself -- potential starvation.
"256-entry" can be used a testing setup to reproduce the issue.

> The lock has the following states:
>  - 0:		Unlocked
>  - >0:		Shared lock held with count
>  - INT_MIN+N:	Exclusive lock held, where N is the # of shared waiters
>  - INT_MIN:	Exclusive lock held, no shared waiters
> 
> When multiple CPUs are polling for space in the queue, they attempt to
> grab the exclusive lock to update the cons pointer from the hardware. If
> they fail to get the lock, they will spin until either the cons pointer
> is updated by another CPU.
> 
> The current code allows the possibility of shared lock starvation
> if there is a constant stream of CPUs trying to grab the exclusive lock.
> This leads to severe latency issues and soft lockups.

It'd be nicer to have a graph to show how the starvation might
happen due to a race:

CPU0 (exclusive)  | CPU1 (shared)     | CPU2 (exclusive)    | `cmdq->lock`
--------------------------------------------------------------------------
trylock() //takes |                   |                     | 0
                  | shared_lock()     |                     | INT_MIN
                  | fetch_inc()       |                     | INT_MIN
                  | no return         |                     | INT_MIN + 1
                  | spins // VAL >= 0 |                     | INT_MIN + 1
unlock()          | spins...          |                     | INT_MIN + 1
set_release(0)    | spins...          |                     | 0  <-- BUG?
(done)            | (sees 0)          | trylock() // takes  | 0
                  | *exits loop*      | cmpxchg(0, INT_MIN) | 0
                  |                   | *cuts in*           | INT_MIN
                  | cmpxchg(0, 1)     |                     | INT_MIN
                  | fails // != 0     |                     | INT_MIN
                  | spins // VAL >= 0 |                     | INT_MIN
                  | *starved*         |                     | INT_MIN

And point it out that it should have reserved the "+1" from CPU1
instead of nuking the entire cmdq->lock to 0.

> In a staged test where 32 CPUs issue SVA invalidations simultaneously on
> a system with a 256 entry queue, the madvise (MADV_DONTNEED) latency
> dropped by 50% with this patch and without soft lockups.

This might not be very useful per Robin's remarks. I'd drop it.

> Reviewed-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Alexander Grest <Alexander.Grest@microsoft.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

> @@ -500,9 +506,14 @@ static bool arm_smmu_cmdq_shared_tryunlock(struct arm_smmu_cmdq *cmdq)
>  	__ret;								\
>  })
>  
> +/*
> + * Only clear the sign bit when releasing the exclusive lock this will
> + * allow any shared_lock() waiters to proceed without the possibility
> + * of entering the exclusive lock in a tight loop.
> + */
>  #define arm_smmu_cmdq_exclusive_unlock_irqrestore(cmdq, flags)		\
>  ({									\
> -	atomic_set_release(&cmdq->lock, 0);				\
> +	atomic_fetch_and_release(~INT_MIN, &cmdq->lock);				\

Align the tailing spacing with other lines please.

Nicolin
