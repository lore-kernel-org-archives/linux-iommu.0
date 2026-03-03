Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5978821B918
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 00:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772497768; cv=fail; b=N/9XoV5qKum2bm2Kh4JRAKHXUYKdejvRh/j3CTLW8VyXqWXStBAGrSZhaGJMEYmixXOnpFCO+n6yynQtO6UKV92FVAfLwqK3QH+3eLbf6BGw7IdvRWKkbvnJByL2JOdAcH5VS+of4AyvZiBbvnGhnlnZPdB+NryoHSATXEu+L2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772497768; c=relaxed/simple;
	bh=eKOyVQtjbGNeYvEFK+HSPfqKXMwCHs9m974BAO0h8MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bQdQrSWQ7k4lGj/U8FHBb2KsyOHWBGfxoYhOXLDiAnj/rVAJHOp8DI3NHhYXfInoUGzCJkM+Cf1Q2qMDAHO5R2x8KQFZgHVZCfoZibnUawGg9zWxlWXMaxlbJtvm/1fzXaA/AziWI9ighxGN107OBdbDcpOqnNEvKodRYU8Z/Uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PJlmgwB/; arc=fail smtp.client-ip=52.101.53.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PJlmgwB/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4RbYgf+9svS4nNBBPcpdZ2HbXY4ir8tdvnlYf5P8rtuvd8ujbIXD14pZQM7XrnBeGbxIry1eXuo+gogbyDBg6Y8t6xbVqSznqfhAuxBdbTWu1o9q+1osjPPtHjxW8A18OBtm+rO1upkYkVQjahm6usHFKJQ4iFwfIl7iNKCTJf4zaIlLalMjIoSCa/zPgIfgqxHeaF3vPku5USiWlPEHfXtSpSLVSEZ8LJwBxK8SsF/LFHodEPepfdF/EIkvSshfPsA7/JZqCKevh3BkMQpCeSJPykr2pjtPDK53kPDJ0ICpyDiLa7QMYhF9cGy4LQqSuduYunaRFeB1Bl3uXyUmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqY9OZbk/1cHIfEaUE7Ski4ESOrCZuS/a/BzdKr8qlA=;
 b=iodkVYVlhDFPYKBEwzdf008x8VgYNw4rNao4uvDYgXQ3mEZ0MvgoyjYnogYvR4Afe0ocDHALF/70o5wJfctzVeV8H6MdxBdrwMq/sMAddQrhxVivHDQuVlPHzg5WuM0EqAhX6io8ESGS38y08k3Ioftmz7qMJoCjKwLcQ7ap+MobFJr8INIV0gYBqM71jUsZE9JMxYLVbjYTY6OtPrp3Wscj+6DsuAysGDesdlfL+gw7kJCYPe6hi0Zc8dPbPJFiIWUhpABlOEaACeQ4T9sUzvaXpZ7S8WBSo57CFwCKP7KthQGPzzcBK1KogB24pHF2/dCJeGfA5vZKpx72t9mzjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqY9OZbk/1cHIfEaUE7Ski4ESOrCZuS/a/BzdKr8qlA=;
 b=PJlmgwB/pHM5JNUatQDCa7JOPyTd2ARBoospLypMvpbcTQFdGjEZqJStvT/eiE2kIsBM51MbKS3nhqRwpQl45fu/ukvpVKNWp1e8MaWVYo0z4esBcL+k1z6MQtzI7CrpHFGRJJK2qY6t/pvRNAxEiUyPUVtQp4EjSSV2ILspiH1HPH7Wcpkujyb6N8kDHmi00TjmH0GeSNU12h3/nAMwSYBJv65NxpuAY6IrPgVe6gtHigAa3zGP/3it958NJnqE3ENDDbK3DJYXcoaQNQkL/4JVX9NMpai36XwIFb3cA3R9DYo185CHPwcqKEjZ0srvcRV1BWCHDuZBm1GHXWz1bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7778.namprd12.prod.outlook.com (2603:10b6:8:151::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Tue, 3 Mar
 2026 00:29:23 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 00:29:23 +0000
Date: Mon, 2 Mar 2026 20:29:22 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH] iommufd: vfio compatibility extension check for noiommu
 mode
Message-ID: <20260303002922.GZ5933@nvidia.com>
References: <20260213183636.3340-1-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213183636.3340-1-jacob.pan@linux.microsoft.com>
X-ClientProxiedBy: BLAPR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:208:329::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: 32701200-d203-49c5-1068-08de78bbeaf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	NKEJDxa3h3ZOIi9fQm7WINDBdZPInXKtuRKiIAhkRIql7ew/EHk2WqhQEneu7tHAsvEATI4Y89v942CotzXOTNwhVz7hXvrHd2+oTDN/oaMZdcK2EYXVLSfs4iVu7Ylgks/D+DMaVjLrwFottFyL2qtigROBL3wogTcylwREDiyBNcBHF6FJlNWGyks0aEZyODm5m3q7YAp7CHPQZCKSjfi6qDAGIzXhupDt+Tyun86kidhHCiYJx5gDepEGvK2csg89Mr/4v+TWwQMd45uwiq2FVmh7lEjNrrHwbOyIJGXOBEN+kuKqHcBH0t0xf4lREmNQul6fY/X8Yc7rI0hkHs12qQwWFkNZuhi6IRx2GoiJsTxg5LY9MSjXqtJ16Y12pTEoce5ZsX1Rs8/vx9+GsVtAtnum8TnfIlC9TXcDCp5f/NLZB5RLFGQ93MenmjhnpviQFkZP6cOWnmrkkOLreh9PcRX+CqoPYRVMPkAAo1FaY9ulGsLWN2EewA9L5yZ/rFbFdJv6/3R709kiOlbr9+nFrG5InUue0u8XKTChHRKosmwtjh+miwvG+XW7rmdbh818FPbgMQDK3oKQvPIMr/L3r7BAhwighWVsKBUbBGza5ok2yYcs965F9x6klMfy1wMOXJ0KaZmGh4aWIdH+6wW8MgCkmLOtZCi0XXhIdQQCDJjZ6scYbMzswGq8nK7vczJmgdUYK2CD0W4mauYhWcsO3jGEAhs6oUbr4hXujQk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?puX0msQGnYBuc/0GMjVJUaBj0+g5yVMmfTJQYtZRU15B9SlZXPclTwl8QQE+?=
 =?us-ascii?Q?rcVX1eweB4JC1+4wFUlKFjF2gnPuvy0vMIV0dghB4/QMrpy19N+B4L/uNzW7?=
 =?us-ascii?Q?hUV05UW/3MotkTqQ7txeZKAOJmREHlBfqHa6moXC1gKEjJHgWoTza5SZeAK7?=
 =?us-ascii?Q?m+cU1g30hRLZumqtUUXYy2fUMpL7jtJu9h0Tg6UK5Tc6GUoH6Z4Lr4tw82o0?=
 =?us-ascii?Q?5X7/4vqkiQk5P35135xGxw30qgej4BZQcGfw+VCUa/tJNQzjooUe46vTQ9cC?=
 =?us-ascii?Q?9HRNNn5s1JylWVVS8WkIS5FPI4Vp04Z4wIbGvoH439quyhC/8vqvbgRyKJpb?=
 =?us-ascii?Q?8rJFu9xGXlgRYhoXphbSNAB+nMWdg4BfC/Um3AetJ0Pu45DCkfpUkPp+LR46?=
 =?us-ascii?Q?pn3mj9PXagmUXnGgbzw26EYvKTylRBSKYUOpIV7lvmq24hrjhCqxpDMmf0j5?=
 =?us-ascii?Q?8dkwptzMwrVNQ8whzTkYukIWJ1geVepAdrR7ItEcHY5xZHS+HNa66k1xOkJM?=
 =?us-ascii?Q?DbUJ6WdPTDPXE0X5CD6idg0gK9RjMbqkJfCXMvNT6L+CKPYnMHZoDsMFgizI?=
 =?us-ascii?Q?s1mysX24/EHurY2IdeCQQSGD8edD09LHo/jN17MLB6K8a0wVWbdXzIptEY6V?=
 =?us-ascii?Q?PcbFDNm4Rdw5vu8kpWOfp2B5ERgZ3uxTl1S25WHtstVicoq7ju6NloAA5tAT?=
 =?us-ascii?Q?GoDDHbFrWh99igVI6LGD06+Q4tGDtdFqZFiTRy2cCO6XLqEF+O9e1UMHhoWp?=
 =?us-ascii?Q?rcg5EHdi2Aq5NAbOSff4/KuUFtOgwZeoijIRLlrw+O4j5IGEzqdu/T+JytdE?=
 =?us-ascii?Q?jPaNTk0QMidQ18Zs8vQwxUyHwdFR5GwcABm4fMveJ5Q7e3NvxhHflyZ0tsyg?=
 =?us-ascii?Q?Sp2NJKRFB3iVIdIx+FVx9fjEGJKNC2zznmTtkGQ38DMGTyvNzw2UJ8Ll6dLy?=
 =?us-ascii?Q?2tJXd7gCq/JB8krm5zb+57EggpnPbXlEj6rXMxdJiH27ZE3oaZDGpfBdsRlU?=
 =?us-ascii?Q?ihfEgc6gA471id0+wVY6XztLZsbl7ogFRx+eJbmmC7HkMxSFxiasF2EKNFVA?=
 =?us-ascii?Q?OoC6oh9/hNhCl8JMlccLKcJRBsKx0/BZrlO9oZwDr1FqsLQAZVm3sbmfqWtU?=
 =?us-ascii?Q?YfvIMBqnxHTcnpRGqNBLN6HVWK4rHTdQF27/NAeEIXNGITF2ZqKjuGArtJKj?=
 =?us-ascii?Q?ZBuWvo+D2BihErukn1E93l65pdK2796ocvgCqW8M26o7h02uoR2xsuaywJKl?=
 =?us-ascii?Q?/VSlYUO4zSDGD7tPVal5HQrkv2m3o+u0RIpIlI9tjPHZBFg2yOZj9sFhxAeX?=
 =?us-ascii?Q?rlldP7JjxnKf3RrqlGZlySyuJZbWB0C6id4p97v11xWfbv/huWVK+8fDEtg6?=
 =?us-ascii?Q?2+PzK9WlpjJRzhjvfNgvvxzPf0IdEHJjmApe2S5HDV4x9/1UX0800g8GMS1r?=
 =?us-ascii?Q?ugBYXW6cddgwKVqTrV8/1/AGI6TfYNPwcm92CJIWBuKyg6rwkiHPpcJv0FcI?=
 =?us-ascii?Q?ojCwSCLgZdYziWaC+psoQhQhrb7mFth2Ow+5+kDqwVBgS4ra7YAjsHuRNH2k?=
 =?us-ascii?Q?wboQA+VxE8KDWrH4pIPNW4cR+5hLJXAuSJ81qWx42acmqWxjISm+W7ehJe/3?=
 =?us-ascii?Q?KXywNEICl+GTA+D1+hYfImJUCWOSCuXu4whngNDjcJMIIAXwQMLsaCFeF+KB?=
 =?us-ascii?Q?awgmsJEE5EYPIIjR1M4r1cJ7HcihhWbNU7SfBDWElhZoeTS2fvvR2LI9/pIj?=
 =?us-ascii?Q?XqCbhHc29w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32701200-d203-49c5-1068-08de78bbeaf2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 00:29:23.5805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKVhwAKB2cLjAjLxZ0uZY+f9QoIlOQh8/jQplF35EaUksGC0rX4FoGOvaLipTMhS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7778

On Fri, Feb 13, 2026 at 10:36:36AM -0800, Jacob Pan wrote:
> VFIO_CHECK_EXTENSION should return false for TYPE1_IOMMU variants when
> in NO-IOMMU mode and IOMMUFD compat container is set. This change makes
> the behavior match VFIO_CONTAINER in noiommu mode. It also prevents
> userspace from incorrectly attempting to use TYPE1 IOMMU operations
> in a no-iommu context.
> 
> Fixes: d624d6652a65 ("iommufd: vfio container FD ioctl compatibility")
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
>  drivers/iommu/iommufd/vfio_compat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

Jason
