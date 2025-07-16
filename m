Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE00021C192
	for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675144; cv=fail; b=KuEzPa6i7z0rwLEbPfLBEGlFj2FfMgoCcMAxe2BS+35c7NlW3caBB+BH5MrK3T1oQoGPPqskL7c6D2vjcRTtHFW5cBH8XDZttKoCbc3NareSSydONHUkCQH9itPLnn6wOxd7eiTIH5vnZdX23ZS+gMErx0NYlIvzfTUiBJbqjeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675144; c=relaxed/simple;
	bh=QmUHhc4qKQiEIZpWEe2GHlaJ3f1Ypb+FsqMOE3koDng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T/jrPoHBwJvSLMO3yXkz57YPl/chCUeikFpQeZlE9mFFTtMSyapp5MOVdTBxtUsGNNnQKV/5SSQ4HK/iuAKq6pGQWsHUMvw3kS94iaX5ZGMG+sLLZHKKIVzs6YRi3U5hkxVGN+2/ydQEk4u7OBtto4OtQxvQT++c/mvK68ltBAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KXxnrMwB; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KXxnrMwB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pas4KXwSKH1bjF940R9A3TkYglaygbeaOzHqslGlZWpNcohObEql7j7ptvhbSsMYmdsszIOjAHFvo0qh/xvd4PjOx0so1NC4B8pkmU/6MdFERJZE9SZ2cJ3iGOzGSN/oJuBPPdVqF2YRBEASRCNqxG4bMnhpUbqtI8X/d/wM8dnq4pwBolIeD3/utB/9i8wkDrBV76mZY7YZ5vhNxYmjP9LNwUFBArGA2cLjvN+vuBAbDefAwYemqrb1Rq1XQhE+zgSn0jRTYfWnoUAsnqJ8EQYI/AZqoB4SFlVHMTbu89GWOu94ZN81STh9WQXFbIZD0F9VG+GIeZ5pwkkEy7503A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMiZ4N1TsorR5rxAE5yfdFtZcWmW9YgzjiCQKTQYDk0=;
 b=WaShH287UHB7X/zhgCbkkINvLGZ0C/zhhdgtKZWpDYgQ1+FX323QbAOH05wAPVhG1BOoAoUuHzx+j6FY+6K+5udw6n5JwWKLGklG+3ZOt5RGVY2PG5cdj36WcBsS0xS6UxMab22v4ZZQQKNseMxGTam2pQOYTJmznQHAHpVxS+4W718w7t+QEWESGodb4OOMl+9eNzA2xGYT7CZ1MS/aYjnRCxbnFC+j5NFHMZyhV9Jo3Qt4LqA9rZ2Q3wEdF5Dvs6BBo5RGM1WgJbb6130ysiaV0fQ4n0+UQDYONFqJxsqThtucycXiTWpdacc9F3ejVKQTB+dTVJFKDV7orpezPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMiZ4N1TsorR5rxAE5yfdFtZcWmW9YgzjiCQKTQYDk0=;
 b=KXxnrMwB01CBpipMKQJZOenSJmPU97pkvIlyNl5szyEqD0ZOfI5tDMZWhapxf6OqmSHMMDolXas2GmtGP9PhC9b36mZI78mSI4zgl0E26hBbelrNGTXsMXDtvnCt+1aXp9bmpbd3s/sOPI5S/k/pXykfmL0ycc2inLfF20nwaefsxgZ/vHOyjG5O2UU+Uo5bATUO7UeAV6oHWdzGrakUk6m+9oGiLCubuf4M0nNLmQHLOmVrOQR/BachaxhvD7k2pGYgu886sFaY/Ql8ZirH/lw7lWENNi/RZIT2P+nyxXTlyz2X9J8f/E3CuPbF0y68/36DN1jDNmpVzDz7akB2ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 16 Jul
 2025 14:12:20 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Wed, 16 Jul 2025
 14:12:20 +0000
Date: Wed, 16 Jul 2025 11:12:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] iommu/vt-d: Optimize iotlb_sync_map for
 non-caching/non-RWBF modes
Message-ID: <20250716141218.GA2166806@nvidia.com>
References: <20250714045028.958850-1-baolu.lu@linux.intel.com>
 <20250714045028.958850-3-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714045028.958850-3-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR18CA0003.namprd18.prod.outlook.com
 (2603:10b6:208:23c::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH2PR12MB4133:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cfbfbad-a6e4-4d68-cb63-08ddc472c6d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JywyGufDURmkFzdL9jI1U84Il7lw9qGhSvEUxdXDGmmL48Mtfa05YN5KHx4O?=
 =?us-ascii?Q?nl6nSIIIt6JqFc5bGO8+g8y5sWwObppBNo3+hMrsJIKE9EZkvoqffsKPKm2l?=
 =?us-ascii?Q?ODiDte3FATTrraVXpPg1jYt0dYTvWD6CKC/1sKHTvT5q3UB9yaV8fC7UEBpC?=
 =?us-ascii?Q?qFq6kK+vQKtZ/sphh4gOACuEK/rWfdRyhLu6YOoaX15EDaPxnUzJOAPSplZu?=
 =?us-ascii?Q?KOKuA4aVrNZN2AuaD66F42F/MRNdGso1D8ZUWzja5FauFc9mKUSHo7dWE1V1?=
 =?us-ascii?Q?pa8GzLrx/+pXoSN+RS5TAgpIZUqDaACMwr4qAkxX9lGBMvkggviRIVVFun1T?=
 =?us-ascii?Q?4tomYSSIO6ZV3mjpCcizZYB3TXXjooWY1eqYmZ8ZnFc4WuHwIQgpIY7ELAAP?=
 =?us-ascii?Q?Mq+YZ9F7B+MAEK7auZiewd7V8LUnIdcezxGzNlEDs2LEj+nRw0ASamYK6mPM?=
 =?us-ascii?Q?VGM2Xfhfl1AdRRzvR3UuBoheodE+oPGTGIdtI4eQz2OE+0DfiSrZM4KnQ0E4?=
 =?us-ascii?Q?TelJTIIujGjw4qHTG97QdWD7MmwnLlA5jGbtpWtyqg5Nz5miDIQIdNcGOT0G?=
 =?us-ascii?Q?UaVc40wuL6COUXvmPDEhHAUlC/2bc5k6mqLKae5Yupptk34aYuFYAiZHOhyP?=
 =?us-ascii?Q?Sw7NSWqeZVxu64Z806ORiLqUawQfemnVeCNVfxkRaBrQGkqEtpID3jGvhfxo?=
 =?us-ascii?Q?du7l67FwBKPSYRKyTX0ETwu5VYvh5KzE8NGY8fErM1HF3kNhAN9jothkmZtv?=
 =?us-ascii?Q?qT2/NPvliJicX6Ak0iWuouOD+GAKWK+IuoXUI6pIyhwn2NTyJzgqA2hdgFCN?=
 =?us-ascii?Q?Pj8kMm0QvfcEgcl7lm+CeuxQsE3k3w9YO09haLveBLhPCJNTpEzM8Ch0GiZr?=
 =?us-ascii?Q?zVxxyo+Vdif2V4qQ+oOxhHMEtQO8uo2szd5er/wbQl8sMOeSg5/uU1/37XxW?=
 =?us-ascii?Q?T/iRcaI4OoShg4zuhRU8ObjyIv0hPrqafmEFc5x7SrOYFKOXDoH7xmAJXxgP?=
 =?us-ascii?Q?P7U95m4onvzBaMBN3m0oUJmzzelZ+tCj2XGaCKAhsKM6jduWJ5tL5PvJ1D6I?=
 =?us-ascii?Q?gA+GSXoxg/Kv0JhgUsw2jKz6cr4F/1f9QlUVOJML43yS8tI6RkiQZTpIZcgQ?=
 =?us-ascii?Q?CZo/UMmnLph3fJuM7tBByaaDmse2eAZevdDPivVglQ4OHJeLcY4Vl3u+VZEH?=
 =?us-ascii?Q?WxNDi1Gt0SoFR+Ct7Hgamm2nMDSYJxnfVLfgyps81406Uq7EBV6yRF0MKfDp?=
 =?us-ascii?Q?4sfQn9maTL50faMxckoF72mbV2xs1qbWU/pskpQ8h/N6JlDGlYwvb13kFhWK?=
 =?us-ascii?Q?Alz09dcbIkFuqF7mvsE+JPzVJx27UzeND4CzeZXG6KJvn7HbvSEtVWaiNjDK?=
 =?us-ascii?Q?GsWQ3tirwEL/OGSOf/XWuJBEpv7CNHgAzTQjiyxi068o4+c8Jl5yjgCHfVuz?=
 =?us-ascii?Q?Xcjbeh0HqX4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iTTD69HA+w9c+9gBnTUO/SRkwHFJYO8rlHfdDursoQbksXK7ruWDGSNISflq?=
 =?us-ascii?Q?0TuL8CiZPnUVvBjhSUlsu0r/bszdBO+BaF4EHkT6UQr0+Dnrq8JyyYzmZ+Gp?=
 =?us-ascii?Q?b7eJo2NttvKO/ZbyaV8m7nCGf+wNXty5Q/MWB993kpBOtdKrh9EjnzMhlxq0?=
 =?us-ascii?Q?g2xYZx86SPKSefOeZZFoDiT2f8S2qvmhC1VkR7QWywOaO8vWp7zdz9HRqiPx?=
 =?us-ascii?Q?Uj4CsDYY8Tn7Uy4J/4nLrcG6ONlhNjz963Umke4WCTmd3eoU+8+jyUSVUkRZ?=
 =?us-ascii?Q?HrV2zlXXrVYkCCHPUcUzsar0jcnD/TKD1k3cSx0U84Ul7w/u8AAGrZI4oQ/g?=
 =?us-ascii?Q?lmnlMeFXrH2OJR3LLEntRaQ+aY4nXOxqv3xJcfdL8K+HbP+BwHM4pkwKl1ng?=
 =?us-ascii?Q?MfakHklsTWKTtjtlMpD1xZ39ZQmWNYWX22yHZgbndaZTDbkKQ9OVvHpD0yiA?=
 =?us-ascii?Q?3yPKjMT3FV82TI17FfTupHXqHJcjefGmvmQUb5sjaomPnqT+LPqKGszV8bPA?=
 =?us-ascii?Q?H4J2JFt3q5y6EoWIXAuyr6YceBj6lnWotfTJUhmyPyCAUIplgV6VFfcdtKUY?=
 =?us-ascii?Q?omIP5P5f6O92rK8uKU4gX2/aXKMAZGVO++CIt27WA5DqiRRp9h7d0Os7uV0i?=
 =?us-ascii?Q?nxzze/fbJkwadg/hpSNFxRNAjFQuj1L3LhlcF8vF4ZyLH9kfxuxMCC3+HpgX?=
 =?us-ascii?Q?sVErzTy3g9fQNSV2DF46Ynps+0qtR60jVpYrn9CFth9IT3iMOV/2QHO/c/1c?=
 =?us-ascii?Q?Zbjoc+fYeuDyAbbZAZsD7KZ7ZJgXaWVPxFGyfh6zCtf5B/4Ao643jioEfcil?=
 =?us-ascii?Q?7QhjITwRrby0MjYL30hJY+9gerimk5l01fJydQbt8TkCzcRbnSZjpw+bl7T9?=
 =?us-ascii?Q?ko4XJUY4aqug/7E0xLOC6fjtPdv1WF6gsz8Hfq3DpRbbiUr+rokwhGagy6LU?=
 =?us-ascii?Q?O9XPAh0qeqW6A4w8f3ecp5q4SNRzxEAUQJ8xbh8PZdT+zGktLD+nuceyhyzy?=
 =?us-ascii?Q?ukIqPq1RCcb9EpZ1Dzb2pxQfVaQfdQX+1eppYqwAaBeitAOo+JvVrsd9z/hT?=
 =?us-ascii?Q?xN/gLfpicKj4hkAmnq2bi0pBerYO3kuMkpsKlVzMS549Ox01z/3H/4DaJneR?=
 =?us-ascii?Q?iabR5KQqgGxzPyUm9H7V+mHDGYxOVDEBTl6yAucAQOcz2TQlVwZb8vOyHZze?=
 =?us-ascii?Q?1S8iXenBArQgDtsJVeY1yQ1AZgFO9TKFyfIzf73MwvhR4n73fXdxPGtD97Q/?=
 =?us-ascii?Q?6Z3j+SBMxcEfBTUt3VnVjDdFln2/nruA2a+72JGNwLWOm8TGq2KnuBcfP/fb?=
 =?us-ascii?Q?oZgds/n1OXflGZ6/ZiDfh1pN3SKvax5UEtgZ+fpnlmuM6hOuw0dR+cEqjOo3?=
 =?us-ascii?Q?WPRUO/8QDOpIk9t4yHV7k3eh1pUSXKN/MEUWpLi/2eZf2+/3yD1SDSkCj/X2?=
 =?us-ascii?Q?Tg1bl8WVgHSn9pwQFXJNTNqg1sEmfQS+430n9SrKc42rK4JAgamHEl0sleZc?=
 =?us-ascii?Q?rJJz5K/S5r4uMwSy4q1yiH4zH8kbdDcOmZM0cKAaCsqvlrh3gClSk0CkdFg8?=
 =?us-ascii?Q?xV4KEFgS2CmhG13Fx3MGM16H0BNm/uFo7aWpY8rk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfbfbad-a6e4-4d68-cb63-08ddc472c6d5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 14:12:20.0608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkDh8IIcmvi+6tW/M14zRSVXdGq08yk/ZoaNQF0j5Upab0QeHER2BbRRiJQBxNuo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4133

On Mon, Jul 14, 2025 at 12:50:19PM +0800, Lu Baolu wrote:
> @@ -1833,6 +1845,8 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>  	if (ret)
>  		goto out_block_translation;
>  
> +	domain->iotlb_sync_map |= domain_need_iotlb_sync_map(domain, iommu);

This has no locking and is in the wrong order anyhow :(

Any change to how invalidation works has to be done before attaching
the HW so that the required invalidations are already happening before
the HW can walk the page table.

And you need to serialize somehow with concurrent map/unmap as iommufd
doesn't prevent userspace from racing attach with map/unmap.

The cache_tag_assign_domain() looks similarly wrong too, it needs to
start invalidating the cache tag of the new domain, then change the
context then stop invalidating the cache tag of the old
domain. Otherwise there are invalidation races.

Finally, if the HW needs RWBF then this also needs to do the buffer
flush in this thread before installing the context to prevent a race.

Overall this dynamic behavior may just be a bad idea, and perhaps you
can live with domains having the domain->iotlb_sync_map as a static
property set once during paging domain allocation.

If the iommu requires iotlb_sync_map but the domain does not have it
then the attach is rejected. This reduces domain sharing
possibilities, but maybe that is just fine??

Jason
