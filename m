Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1E9C433FE
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 23:21:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AB570404C8;
	Tue, 10 May 2022 23:21:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id auj9XUSlh2q4; Tue, 10 May 2022 23:21:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 773AD40232;
	Tue, 10 May 2022 23:21:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4070FC0039;
	Tue, 10 May 2022 23:21:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10202C002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 23:21:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EAD3A404C8
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 23:21:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2g4u32AyOkzo for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 23:21:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0AB9740232
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 23:21:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSUvssRVlpw4UIngzOzspP47/DeKvQysgQ+BeOLzEaiFCIudky/8lGI63hmHzARGXvCyK2ogivNeXncYrpQ4LLPPHeJOqU3uZZtSGlgeO3vMmrV40coePCG3CF2LFZAB1tzusfQeD03qENe9OjN3ph+QNfueZ7FMbCWEbRQPGlQSDfg7lz2g7KPYvbfgkYeve8i2jqBpePGV1sngUjYD9ZGr0rqds9c2I3O35fkwG8BA5vrUnaJI6OWvRKcJdtQ/um2xoPAPn7RbW2Ni+Tj/nKV8wNat9m0WfghGMCbKD6KYhYvmNT3VYrx2Neg6VDMaA0X5nleMriIfHI04oU2Iiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBE6JiSpJ6PQ8Nk3cXhPWMECQV8M9VrHPsAHMj7/ALw=;
 b=JJPBpQR+Vttnx8+mGBKeybXb48rB5bxepb+wBhN+EntJ+MRFgZLYnd1MG22zHR6cxJjaNcCWXrpgHMhQBgbp1kocaDrX2htcsSC+D+SXnHELeZ00m8xEEy/yl4MBN5yOHbsK9I1/ayLVcP8kA6ijScl0Y9/H6jkvKF1oKQLbxrWZWqgpmn4Gk3HKts8cuITJqe8D1QZkJFRlDrBObmaGKHhTmDbIU1B7pxLfBMP295/WNfzZd3YdU6L4kLCWb3Etu+1DnOa0k9MGSjts+6dcwP3AuJttkcH2NkPZhXmzaoZ1ORonsNitNZPLu6Kw8HfXOamFthT1jQUy2AsNutqpgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBE6JiSpJ6PQ8Nk3cXhPWMECQV8M9VrHPsAHMj7/ALw=;
 b=XYmTxFNKJYOUcu0OvKFS7qY2hTewq2ldp2g68VgWOzmY/6miKVFTyeJk7B20nfHzpXOPQuwCrVGQCbp/UmkmfZYP0ucxspwWG9IPpCozrMHa5XVypBkRW/i7LHLBoF9+1/afczpvZPp+2qTGVTkSl1djr+vNdCiIoDKna+xW5ByWIgB6GROw+D0D+hglTcA2XYzHNGgMbwz+Ej1BmJYouKwmIA8TTOlo+i6QOkLfJ45dCsAOu8Zldjp+XuBx2fi3nEGY3cCxcTEc5rozsaS5Auur4ER4DC31wZ2qroP9AOSDqWuqo7sqk9uB0kRn1fIQW9EYprZCNWJkaX4BunTVDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 23:21:22 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 23:21:22 +0000
Date: Tue, 10 May 2022 20:21:21 -0300
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v3 1/4] iommu/vt-d: Implement domain ops for
 attach_dev_pasid
Message-ID: <20220510232121.GP49344@nvidia.com>
References: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
 <20220510210704.3539577-2-jacob.jun.pan@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <20220510210704.3539577-2-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: MN2PR01CA0031.prod.exchangelabs.com (2603:10b6:208:10c::44)
 To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3be22a04-16bb-47e4-e661-08da32dbcbaf
X-MS-TrafficTypeDiagnostic: BY5PR12MB5544:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB5544DC80824B4241A0E0D3EDC2C99@BY5PR12MB5544.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c1PlJ5GP9CeUiMi8h6QsYbK0U5sT5BLAC2vKg+y4EjATM0KZAlSwvryan0E4TgLpkVkL9RvwenRTzIggirOXeuTxKX0Vyx1F7WM2MEyMd645xt0kSpL0gYoVAHJ2cxHIr/PefocjdQimP6NtefMi8OXqr9y41N0HLhx2wgVpb+JbxawPlMt5LsU2PLZ8S3IE1d+H+tr/sKKTJr7MXLxHtbghFHDAPDqi1gKFkFAL/6HZV7PiLQCnXUozu5/o9vCLKsyGmoua4YGSCgvKV7/4bZ+Ez3N8ysDWBO2Cqe8Z7Ox12B9Mj/TdYWWkyvY0GKhvsOnFX68pG4pMoOuq8MlsBglZrWdaUOp1C9h+bUvfdDcwhE3+PJniAomc8ah+8hvwKktEc7SPbzoBHcAGmD55D8q2t4cwO9nKCMvUjfaLujz333NscXi31cmNLEG5Cex1Bl7BSP9EyKHM/gf3FeyBx+Igd+s1BXIcEZKGw8mfMvzvFAh/YGull6lVqZUydWVNv+FjUrF064dJSgA7lPXT1THcqaBrzB/8XkytmwpOgEBrZhWWzBgwIKA9wpbxwoXLlvpBGsHpYubtdQO+DzRj9M6glTbshwI8Eze3qEe/fdaFZzcZhw8fMtGV1M2p9IlE5l20FKzJqzyf1znTPTwOdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(316002)(83380400001)(33656002)(8936002)(6916009)(8676002)(66476007)(54906003)(66946007)(4326008)(66556008)(38100700002)(6486002)(6512007)(26005)(508600001)(2616005)(2906002)(7416002)(5660300002)(186003)(6506007)(86362001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1x8LfKAS4jmHpcj6H1f1iIxABKOmE4vpgTL68MR5lWYsSVZ+LvDABViSS5H7?=
 =?us-ascii?Q?8UxI65sozFj6qO5KafF5LXqw+VBYpDs1VE5dGiv8MqOQim9YK2R/3fvUh7E+?=
 =?us-ascii?Q?DIv9/IvQRAAHM+7f8xwKGUuDhds+qX0hdLyizxAVbc7NSlLfzLx2ToNra5i5?=
 =?us-ascii?Q?wFHrxFdFKl2g7hxEz9h5lmg498KsAWZ0dVU3e+PuA2Ba6+BukIiXYGH+Jimp?=
 =?us-ascii?Q?T/B86cp+ZTyuj275Tt4rW7d6BoCmGmOuB2REoS5K8h/6nlDjaGVuUfb8pvPF?=
 =?us-ascii?Q?6R24N5LBy8bZNxxZI8fVxqA0NUVjcVASjeuiwZz39vTHWSpEDJFgWp2dKcwz?=
 =?us-ascii?Q?fG/rQtBTNylZbyv1IOgP65vO6Pgh7+byxKecNQZ0Sys7Dc3UKFBs0xtygFvY?=
 =?us-ascii?Q?3AuGbsNwq+nQwhN80uZ3/aDBaS8ZeHIKyB1euGRtr0+URhViRMSPAy52YiCr?=
 =?us-ascii?Q?jCRGGFu4AfFyHL1k8KKWKt2mArY6/CTdEm1Y/fzLsgbw4PFJwVeAEh0RPi8M?=
 =?us-ascii?Q?tIa49qPhzacSCuZRVA9eozgVmi4b8wbmPbwdV0/aFzNKY+pkZwm7cKD/82ee?=
 =?us-ascii?Q?8f6jFs6c0LOzUYJuLgLtxTyL4ClqKoWmWXrnj5zurTiQ1SK2vWm3pnh4HIo/?=
 =?us-ascii?Q?M45mIG8BEXC+VUyUS9cDW9MJnscfCZ8WbU2FhHcQf7YbcIZbRWUUKIvToUNH?=
 =?us-ascii?Q?l8c6aXYGrQnVLbdsY7uIps0qMulwTdIGAa3ATfu6u5vavAsMkh0XTc4DAN+t?=
 =?us-ascii?Q?KUrjPeOL8gn75jmPA6Pn1op1tlA6kyU04FQBYq+fa6szfI0bnATYWwKv6eBQ?=
 =?us-ascii?Q?hr9oRm3s3uOCGva2KWARFDdbSLAqSHil5n3pgTNOaUNmKns4hPYtO3TLriRf?=
 =?us-ascii?Q?P40sote6c7LxzLiqQ2K/dsWsJLVRS7qatNpwbyP8KbodEF/7lMT2AtcnSODw?=
 =?us-ascii?Q?avUD9v6+qsAGv+9PRw50tAA6uBmjuBHgj2n6Fpp2hycQBRCd1HSlZ2W/Vrne?=
 =?us-ascii?Q?8v031301BNMtLayITkvI3yLOfwJGpmDbxvCXuLi0dw7bBut1g5+Sej4nJD92?=
 =?us-ascii?Q?rZK3oVilc2qrNFxyGtbeDgx2ZlGJbjEnuVB7RYwdmPozp5MegxnMIkerG17d?=
 =?us-ascii?Q?xxUiOlYXUc63fz74Vpm2+w57qYTs39TqnsS/hQXPZnnQ1u/chfbxoPyeMlCD?=
 =?us-ascii?Q?uyBXjqhpOzzcPeWjakR8oClcFo8xg1ELzZvcfQQw9tvr5y5NMfdWOGVl+wvq?=
 =?us-ascii?Q?MGSR2tlGKlhGVhyudJPPlL3kds1248tRByY6znJd9EGnI1bgzudNuDJucFXG?=
 =?us-ascii?Q?RHv9o7nW+BXdlJN08RjLlR6Srmc7w04WFwSPlgECih66xkNXtwvdqMtyQAAu?=
 =?us-ascii?Q?3pFxouUTjEZzQt9UgA3rg2Jg4mQmBxPhNeI2nlaNRnAGlvB5AN62dynFlptw?=
 =?us-ascii?Q?eurrIjzo1rytUzM/BHOiLngbcLrRIbyJQ2XohPJwSnxqg0BTwjYxwwZ5nJU+?=
 =?us-ascii?Q?ePnMfyst0rS2ULxTSZsi3S0ztF+jNl2JSKDF0q5v1degxz4BDSc2XaFdoMOx?=
 =?us-ascii?Q?cJHu4YF420le/RsZ+ip7RL+ynORMelyzxE2DhSa75q3JQLdzMMP4YC4GzHHO?=
 =?us-ascii?Q?lo2dvDouXl5DYSvDdFlGJrG6C22Jls/zy4hKO9cNWVVPrXn08GPxV9x6LmZJ?=
 =?us-ascii?Q?F/fkrD7nsdeXH4FEFCoO+rB1inTJnfWk/bs0XOtyFF0dU9Q8LUEOKT7r4dbo?=
 =?us-ascii?Q?noPH2hRd2A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be22a04-16bb-47e4-e661-08da32dbcbaf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 23:21:22.4594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwYBuoBgNRbtM8UaYugO06Ktcxdwq1z1CRmqbGrzM7EzCflved8gVHt3IqBgfl0d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5544
Cc: vkoul@kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 will@kernel.org, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 dmaengine@vger.kernel.org, robin.murphy@arm.com,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, May 10, 2022 at 02:07:01PM -0700, Jacob Pan wrote:
> +static int intel_iommu_attach_dev_pasid(struct iommu_domain *domain,
> +					struct device *dev,
> +					ioasid_t pasid)
> +{
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> +	struct intel_iommu *iommu = info->iommu;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	if (!sm_supported(iommu) || !info)
> +		return -ENODEV;
> +
> +	spin_lock_irqsave(&device_domain_lock, flags);
> +	/*
> +	 * If the same device already has a PASID attached, just return.
> +	 * DMA layer will return the PASID value to the caller.
> +	 */
> +	if (pasid != PASID_RID2PASID && info->pasid) {

Why check for PASID == 0 like this? Shouldn't pasid == 0 be rejected
as an invalid argument?

> +		if (info->pasid == pasid)
> +			ret = 0;

Doesn't this need to check that the current domain is the requested
domain as well? How can this happen anyhow - isn't it an error to
double attach?

> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 5af24befc9f1..55845a8c4f4d 100644
> +++ b/include/linux/intel-iommu.h
> @@ -627,6 +627,7 @@ struct device_domain_info {
>  	struct intel_iommu *iommu; /* IOMMU used by this device */
>  	struct dmar_domain *domain; /* pointer to domain */
>  	struct pasid_table *pasid_table; /* pasid table */
> +	ioasid_t pasid; /* DMA request with PASID */

And this seems wrong - the DMA API is not the only user of
attach_dev_pasid, so there should not be any global pasid for the
device.

I suspect this should be a counter of # of pasid domains attached so
that the special flush logic triggers

And rely on the core code to worry about assigning only one domain per
pasid - this should really be a 'set' function.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
