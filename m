Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012045.outbound.protection.outlook.com [40.93.195.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84D42BE62E
	for <iommu@lists.linux.dev>; Tue,  4 Nov 2025 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762263451; cv=fail; b=KxP7vDsm74hkhGlDrubXSbtP0gTONtfFiWvyRBWy/OPuuOdqlD42MAFNJYNJETvWUAQ4yCqobHre3gMSEA5eiXhaJofu9BqC/uC9kOEqcAJ9HbWQ1Bf+ZOd5myrifUYcLxcvnLEO4XpOGFGdHMRk/dQJTA/fdgUoBhgDCKNGxU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762263451; c=relaxed/simple;
	bh=8slYFgRcoMestedD9TYL3wd+P5OXDjDAnshbcNPXZDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Kk+8kMt3fvBCHeMeR++tp6WSFKqNnO4FlyD5MV2JVSmdtJzO4CL8WdygmUYjOgAQEA+xQVNB2+D0DL/5HI2RrpvPM8Dt3AKLOT+5klXXK/2BWL7jsUbSlhyHP3+PTTNu1u4C5DnJEx/OxtaKnonhkbXRftrHjWd1Oo74ZX91iPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IDmsxaGf; arc=fail smtp.client-ip=40.93.195.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IDmsxaGf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbcCmH0W3Gsk9KRhP5WqimbpYPytvtShaSqihxV99kHxd4shj8E9ptJD0Ig+4gEHw1sijiY3l2MJYrIX1FzvGC85wWDUgumN78EVhCx0nhHEAiVwBCITBQoqU1HBhdKhHyd5ZMA6LC4XN7v7Y5Q3Y5X2Hba/rorqb6WdlaBFBuwLkmqvbXlt99R7lXHkJ+YZGBnH08ajEDTJZZvyUjvGFbw1YmMf9jZG69FYJkSdG8WeAMF3PGWChTrcfPv6j+dtFLZZKKvJPLMjQrn0B3RC4TAucMyu6jcoGmzvu9J28pi27/sqDiuPk14zJTJAAC7gI58PlqlxPCROxupQwe7LGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8slYFgRcoMestedD9TYL3wd+P5OXDjDAnshbcNPXZDM=;
 b=P4SAZvoddeTOoTRKL/kVqE0cuCTXR635lCbW+rMrW3zrXCjR0QEZUNhlYUUZHnlvyCbnL/ID8W53czRPU70waXUjhh099LH9ugPwrbfmrRr38u6fsaNZA2+1fQquVCzI6Bs81kj+GgtpHW5bb04if32U0lgSo81cOFASLkwQgyjAuX9Q/Vn2W01smdPecdULX5eCDeUgyGUZzIUQePRETl2yVn2ejt8qot4ds4Y4zgnCqT3DSBBRQ/mDRK767X8L1x4FHjuEoHW2kAFElr38Tss1TTZBo2giaQ07wjo7NHZa5BZGLMvxR9W4nQjbTEqjfr3M5j8K1Gry4DHhjXyDCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8slYFgRcoMestedD9TYL3wd+P5OXDjDAnshbcNPXZDM=;
 b=IDmsxaGfGvWd2nGhPCuGTyZ5cArbyRFHCauEUlxReGAbZjrvXNWfL++gbUPBU8JdXZQwUydgquM+YtmPGb2O+Q37tngqEQ3XcX7425Rs3PBH0M7D36GpTDytyKVQ3vKLGWpL6zv0D8dEz7zu1/Zrp2IWAgJEsjwnnA8MuIZYd7l5Y8IIOMBSfcuu6O/pL3myMFQp/9Nr1t5b0K+GgCSHnyH9d292g3oBHcezcZAmKy/rlAo/Nlnah7RkCphomj9smfR3GZzHC433YANptFujpoZixtOXkdHF/AogeCVXw8EhvLkg8Rcc6pgXb7h7Ad3PnO4BtL4B1XclGvCiLcDoTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 13:37:27 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 13:37:25 +0000
Date: Tue, 4 Nov 2025 09:37:24 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pranjal Shrivastava <praan@google.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] iommu/io-pgtable-arm: Implement .iotlb_sync_map
 callback
Message-ID: <20251104133724.GC1537560@nvidia.com>
References: <20250927223953.936562-1-danielmentz@google.com>
 <aNp5sS7VpPirrRGE@google.com>
 <CAE2F3rB6TYjy0a9yecW4zwBLraaj75YBafEz3DUh8zrLChnuCg@mail.gmail.com>
 <aNuelC9K24z_Ph_G@google.com>
 <aQn_g85KI_uuYpJh@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQn_g85KI_uuYpJh@willie-the-truck>
X-ClientProxiedBy: BN0PR02CA0041.namprd02.prod.outlook.com
 (2603:10b6:408:e5::16) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 15fc9499-f0d5-415d-4bee-08de1ba74a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qdVTaRW7mfw6lEAkZ4tv77K9v50No94aqepewvDK8PpKworoRsCgJxJvlUVZ?=
 =?us-ascii?Q?HPEdTLvWw5p02eTwdKibw2KBccACz+oUMH5GCJKh99b/LWC8Zp2f3ahUKagi?=
 =?us-ascii?Q?xxtj0O4y4vrMh6x68Uv77waaYwuLogkpvUlznkRlyEwqg1rgum3CiwTdbLg0?=
 =?us-ascii?Q?N3AiS29jkQ7YL1M5GfXlOMBCSnH9iBtJGr5G24nEH4EHyhEg3m/rntPEilJd?=
 =?us-ascii?Q?T2Uyhq2bdX1r/k5SPZMI9jEHVpkF/1tiUZpkkE0CK/X/8z818emx7k4z2JMh?=
 =?us-ascii?Q?v7TmKy/K4Jk/rJmpmxGZfL+SdRSZujeV2sSdIMAviU1ueWGnzCygSUE+DjBg?=
 =?us-ascii?Q?zM3ddZOIcXsxWPSWWkShVHmgUhKDw1eRnk4FbBLTGLYCRA7c5hKqkYAtPBDh?=
 =?us-ascii?Q?ttWInTcm88GsYyB1R9MBD0Ekg4bgTwpMXo1zQKGXDwAj+uHGYvm6SWcHO25F?=
 =?us-ascii?Q?PHP23ekskdTFEj9ZVi/xdI1cHXgISf7IMZ4V7kXhMkkT6ChUhIAxZjxzHUNI?=
 =?us-ascii?Q?wHTa0wHd03JC9AfLzk7uwcNsA6yIMnbK8yFSt09Algae3tku0RcVCobttGL6?=
 =?us-ascii?Q?NUknjH5yxk/y6WzbOWRgN4xumeivtGrNDIIsY5X2gLhQT3Hv2HK+rO2Xi1Rf?=
 =?us-ascii?Q?kijLXcXSoyEdtqfzRUS5nYXZUWyL+Y4cbEWeq9ILSppAfiO8bFpFVgulcRRL?=
 =?us-ascii?Q?6M4LQ19eRjAQbCbj6F/XQXdemJLIweD2EH097eQk0ysR1euxwk14VRV9YfmD?=
 =?us-ascii?Q?fXKv9c98ILrc+duc8QXP7YckH9cJ/+O4flX/eHdY1WhWQfB7oPzc9D4OwmwP?=
 =?us-ascii?Q?g3v/v1PxI25+9pQ1cIYqRygxOhkaXFoArjb/NBzauhn+La4LsRCgIYNnBrVP?=
 =?us-ascii?Q?bhMMbMoLauCyer115NSbt4QBEJeAV11GnzzohSxPLxNPCNVGLhkjWOMv9y3U?=
 =?us-ascii?Q?J2O7mE8tt8qwochjPObQ2akpVYjHu5f7JvudxhIQTp3fMeaHYwnTjXBhXT+y?=
 =?us-ascii?Q?YI3ltir4s8RSTVKGIIhL9oLdQiY44bhLIia+fNHp2fXN5Nji4dhi0iqcf2CV?=
 =?us-ascii?Q?zzQ4l+O62NWIJ0y8+EZj8qPMSSn+O1h+MT5cxx8UZukSxKheAbpcWed4jK4J?=
 =?us-ascii?Q?pOR3/ErXy8nG21bxpq6NiQnvLAC4t2KFBD5ZPb1mapATTN7GdkE/4B7MOa0m?=
 =?us-ascii?Q?RacF3P7IKuzaP2y24Wkwn82kzsoRbmkFm6bAJPZNWQqeNCnUOxgXaaRZUG+P?=
 =?us-ascii?Q?1hNyR1v2TsYOJpLaMdZtng8YQwYR/IlcFeB1WhvOP7tAarjNjlrM3HhrQa9k?=
 =?us-ascii?Q?6Ku+J3qV9xwEmwInFFhsFKHSJdRi7YDhsgDhIQEni7uIB8dWif8iXnAZPTew?=
 =?us-ascii?Q?zzHSEzBgDoCQjJYM4b7gawwBriPaXQWG3/sxW6oM5CTby4vdqHXsfTgwECoq?=
 =?us-ascii?Q?TBlk/4mwK0DzNTALhcDnf+hnqzMtfPy2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bG4eEBvTDhaCafp9VlHV7V+eUuCAU+ihtOArRhfFAKbg+GavzzIE/eTFupJt?=
 =?us-ascii?Q?ofedG+dpNXMFv1j5ezefBzNmTKdoWLGg/JRgyiZSTKjYw870KDuHS1RomeUw?=
 =?us-ascii?Q?kxqunCxsS6pRV+4XixFsRcUtGL5BfLpZpYnLUj5p7TiByEc63aMgcSVi7ps+?=
 =?us-ascii?Q?32QvidcmVaMh5iz822hPuYXhjlXXyk7VQNm1RhDpig+RHlKklFApn0inZ3rt?=
 =?us-ascii?Q?QxRAoV3YHIKmhoTXV9jLIKsTfwy2TOYQihcA6Q/nIwisb6cfZKvrnFjSUOdb?=
 =?us-ascii?Q?SMMio/sRC3KK2gCcLWS9PcPQAp2QjEiKpo/k/bx3eeZ1fboFzPMH49wfOgCf?=
 =?us-ascii?Q?TU8TXeGd3vLvsx9U+oiXUAagmyVcsoD7oPBsdpkNOcVPz/2zdQB/4ofuS6iT?=
 =?us-ascii?Q?HXdtZqTR8kfoQT5KwIglLeEIrGjfeg4eS5d3msKnQVnFYXJdowDXOMU0aFDa?=
 =?us-ascii?Q?s5Tn7GXeG27P41cl4ZpHph6V21hyp/+O/xu1E+jLT8XzffRyUAv1lVEaUhw4?=
 =?us-ascii?Q?Sg4dvm+Caha3RGNPmGIhWOzlZ0xF7zb8g07uFN9HHVd67EqQGrhO2bdonIHl?=
 =?us-ascii?Q?Yq2I9Y99h3U/UuPquMMTDwbebeltGrnBOyVu81yOJ+u7ORalhl2oI2uQxFgZ?=
 =?us-ascii?Q?K4ryxsWGUJ/glB97d3CmRMxRmjWs53J+2QQsibG4u8IFCKQyfs+VqHnAcQGm?=
 =?us-ascii?Q?rYaMhCtenu6eeLaroa/uJWLvE3Nw9aBA8irA0fiiEAdDPLkD18/bnXxXO4Aq?=
 =?us-ascii?Q?LjPKKgTWX9BL2dMaLgKZyvN8jwNYA9xPm8QSprf1vzrq4xC0ON85sIBstT1O?=
 =?us-ascii?Q?A6vXfSkH40yvJ6aGlFtAaPDVxNong7yoDnuFyrSSCXM2ElKm5oBXH5sZhzB0?=
 =?us-ascii?Q?xjJsT7EJkEFJzn9zkcplW/xFJAzJjSfZHbw/E7G05oQKbkebtJvvixI0rGfP?=
 =?us-ascii?Q?8wQsREsNTF9i7RiR8U5IIkaroiQZJSJBNUpXToH4UyMuU3ZgXpn4xcXjk7em?=
 =?us-ascii?Q?Fd9daaVd0UaUfYaR241aOcJ1Berrg3/kjku+7iEfhLYGJSuCnOtHFrVlf+Tp?=
 =?us-ascii?Q?msD77f1qQ4RYqMSdjypHov+gt5W7fhkwWnT4ZHaA8yvAWIev+fKgESMn+gGa?=
 =?us-ascii?Q?5UadK/9wro8RHHxL9CMBL+vgqjbXe5DzcVN0sOQGYyD8fRQCh8hTcNY4iWSP?=
 =?us-ascii?Q?eBKfOTteBN2zJZ+G+RZQE7bSfltvdg6qyYo5k+UKFPEe69zfSggKNIiok76B?=
 =?us-ascii?Q?243ndVZUbuExvfoWyEeq4v5rIZ+F47EYjb+oY0JGT6EOaNHwUzY+j0t+tKkQ?=
 =?us-ascii?Q?NynS8IcEbCgxo6ajxNgr6B1bIg/pTPeMQ1Uy1e2kwZTtD4elELu9lzuhJrwH?=
 =?us-ascii?Q?quzHco2HSu+FdfmpCRU7PYK25/1PFnl67xwvJUSv4v6SwTrD4TNI9vLB5I4M?=
 =?us-ascii?Q?ajosbmZMuLJ1vYssjW+D/fv8DdwGc+GEJpdpJnnSegw2788VvPWZutolAPXZ?=
 =?us-ascii?Q?ngI/h8PxuZjHY44/FwN49xf076Mrz7dW7Jy9f7g0ZuD373tBtuAWvat/L/oA?=
 =?us-ascii?Q?aLphoVu5Ggw63MexCpI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fc9499-f0d5-415d-4bee-08de1ba74a6b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 13:37:25.6122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rsq8Q+AXDI+h+22c7zntHal5feaMzG5eF5Co12QAZpSJQUuM8OIZS1g2sx37k48W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326

On Tue, Nov 04, 2025 at 01:28:35PM +0000, Will Deacon wrote:
> If that's not workable (due to Daniel's performance worries), another
> option is to bring back the ->map_sg() hook (removed by d88e61faad52
> ("iommu: Remove the ->map_sg indirection")) and implement an optimised
> version of that, preferably sharing as much code as possible with the
> existing map path.

I've been broadly thinking of doing this. The benchmarks I've run
suggest there are decent gains in avoiding the re-walks, so we can
speed up the map_sg operation by working directly on the scatterlist
without rewalking every next sgent. That cleanly solves the CMO issue
as well.

I think the page table rework will land this cycle, that would be the
right time to attempt it as we should not be trying to make the
duplicated page table code any more complicated.

Jason
