Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A16110940
	for <iommu@lists.linux.dev>; Sun,  5 Nov 2023 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JcW1nu1m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiIwNyx2m7+n1qUR4bHwZtfPOgzQ8nIw2BBOeeLs1GjxWJLQZov6bNSb0M7JXZkVEZw4m+4LQle9ZgPLz2a1r830B6+RyfAvionAmxEqkA+1KRXxEGhmdshdwk3qhuIweA2z3h54ivoLBxJ+xKrjp1pe2bJ1PlCbqh1lT9Op8DM1Z8d+bws4NWhPlpROTNvTvLNJ0pgzitu53SqOrZyCpEK8GSxIdd/VYCEI8lmMxhWHziWqGg2ES6BkD2SrG0HJzouLMUpcCinIBiE7uRJsiJpSvSTLLKZ7XVcDFkmjF3q+K0c+JLRMerT9M51p05EwnUYh1SRI2zPDsAhQbKJHLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfovNvBhN4Ys+U0Ebg0yGgjbFKHzcwp+Buzl0CpDa4w=;
 b=b/cfTIgdqLD96DzCPzx/ty13k085xoYzWd8QcJiQeKw7GwBkXMUzWJadDn2dKYW0Z5HkqEEu0RHXMPDD7Q2geJHmGUpdXSmYfKkgnPuB3j1JDrxWBqL5Xv2DlkD9Rlzd6WtPQvBsVie01Xk86dzhe2YnwjqX+04xvJHlxvGvqI8EB+6VnR/DLm7jMyfu5proNr+O9h1BvTqWcujQ/LL5Oz904ruaLbrjgG2011pEiYJati2KrAmd1TdkZ5TcbfJIyXXw76Dal5htILz9Ynx+QO9/n/QlF/6TgiDrnBHfBGU8IP6xqVDHM1GQYtJjLM8fvWc5mRo+IB6UIMi0XR6vQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfovNvBhN4Ys+U0Ebg0yGgjbFKHzcwp+Buzl0CpDa4w=;
 b=JcW1nu1m+V3oOLFCt4RjOvDDW9+A8P7u1n09TGgbIWlbduyzmUpj1Ij44TEWS7n6iVVzb7qqPFeEqKUgyl3Hb/eRhGw84dl3aN8TeZt5diQmYAAJJUG8z6NGfPG/4VwCDfsmgC7gxnBCajDKb86Cq6bknRVDZHWFnSyaBracwJinI3v6O4hmLPftBYpKgdBDBDPZMoDiMMGlcYKAtZSxm2NMHxFP5QuLyuc8YpN/pnVXREX+IdOafJvyNptbLSa0ShwgPqkqin7M+vUDetf8maC/ligReP4tjlWKfoz+XUIL+LfNu3PSFsIJ77u1xGC9BLczZ8/hdaRX4xD2JZCbKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7219.namprd12.prod.outlook.com (2603:10b6:930:59::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Sun, 5 Nov
 2023 17:56:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%5]) with mapi id 15.20.6954.027; Sun, 5 Nov 2023
 17:56:00 +0000
Date: Sun, 5 Nov 2023 13:55:59 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v1 10/13] iommu/amd: Consolidate domain flush logic
Message-ID: <20231105175559.GJ223197@nvidia.com>
References: <20231006101624.5912-1-vasant.hegde@amd.com>
 <20231006101624.5912-11-vasant.hegde@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006101624.5912-11-vasant.hegde@amd.com>
X-ClientProxiedBy: MN2PR15CA0005.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7219:EE_
X-MS-Office365-Filtering-Correlation-Id: fddd2538-2964-4644-ed83-08dbde28789b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IUPDDYGbyIyPTipP4s8RyHHWiJ1fcOlcd9e+Gg3RL1JVUVV4Wl3W6VwMR0ZJitElu2mDrvcgjX9ikgRyFXwhP3Y9RcM9veTiDf9Lu6NDG9XarmdBsy/cR3ObzWwsxJsvRxrj+4OU1BcCQf3Ka51vlNmdwJKgxQVm6HQYkksUCRthXlLPUE5n5MCTi+4EQOS2cSdDurpapqd7yFc+G33VP0jxtnJAE/3hqodEYLUYYJYu0YO46osb9v+st9wozR9kRBrPqg8fCHmgAX2OTaY9R7zszfD6hyPF82NR0ObWXK1zW9vdkwvLw4taCwym6vxb3eKd3RzjIOUE+ez0gqvqtF9Qm3pUSu5fvt6t1K6j7OVg35YXWjJboUCsBVkEX4SbW+aS9FpDh9vQlNZhIFxrTIV2Gsx2UDsq6o//J54x2YBMV73/15ar2M3k91SGi0jOqTYl8/ZClaZugSWCsrLiofAXb7t9T4Rtoo/4xKnSabplzh/VoLogfeohPqiWX35ND8zm2rP/9RGGX0WWgSzI4IFrD+rK7yEpgZuAI/I/k1NCmQ1Hzzq61kWvzySuZO7T8NE0XpGSy+IEITksgmrKeBfHdarWvZ+uM6mA2cv0wTsWyJM01C9+ejp9RZ70asWY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(26005)(2906002)(86362001)(36756003)(33656002)(41300700001)(38100700002)(8936002)(8676002)(4326008)(6506007)(6486002)(478600001)(316002)(66946007)(6916009)(66556008)(66476007)(1076003)(5660300002)(2616005)(6512007)(4744005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?COBm2XSbBXld+1fqL/qOElutHhw4E0qSbiXAFe4mcy98aUsnag+XfRxj8UR3?=
 =?us-ascii?Q?evQ68m45b9FDYEsoz/aqBQTL9+4SNvg6tmSx8vm5YNTSXuHbZQXlcoa002wP?=
 =?us-ascii?Q?6zW9ZSsPB7SeOCWyThl8dmDD2WfSoGIkZJHWliahnj9Pj8Ht3KKNgzlOV77F?=
 =?us-ascii?Q?5tkMEfkVclCuvAOVNMwO3G1j8pxDvoWthxEyjZYXPg4v5xI9AoAuHjn93FUD?=
 =?us-ascii?Q?nrYx1COCHRS/AUCOVx3mDd72VZ3gBknz+LGnQ2rpioOyfHLSPqpCb9c8WjQ1?=
 =?us-ascii?Q?gxtgLUFg5WOZKGNLkJlUBd+l+HWNf7UbmuS/WuXD7h2HLNpXYO4ppPii6mLp?=
 =?us-ascii?Q?Ki7+YbhQzaNK2TGtBSG+i7BJ/pq5UgNfJKIT9IBME9LxMFXkm/+WHiK80EZE?=
 =?us-ascii?Q?Ftl2EoegJwn30tfRuZhQ0YUY6qPtxC4tn/07nVhD4SXw8bEyke8q8lEAsZB0?=
 =?us-ascii?Q?SEOKRmybzvH9UeTCmVmPs6ZT+WEL5MffYbkEyB18tZfIjJrwOCTmNdqxwgaW?=
 =?us-ascii?Q?scbyXn6RcE4/34PmQaFI6bi9gKctm6BO2/I76HIIfJmRXyhVg7aqeVnnuLgv?=
 =?us-ascii?Q?F6C++myHF1ZntdPNVvV+YObSK/ps6lvoCce2urmVefhfuWobuWhFRTp6aq2O?=
 =?us-ascii?Q?fD6Hx1xlmuER1Z6tgYR2RKf0+lGvR/5auseCNBwiIHtUJGFi/zZU3PH3K9yd?=
 =?us-ascii?Q?dxsKi8NbFlJqTDSOsoStZgAiJLPOAYV+apLVX6vWSS47ruz5YchgBfV50gxn?=
 =?us-ascii?Q?fhBrdioOWave82eKlMDAFbESEWvV5ANif/RRQMZuWzwhYyuFrS3zZmeYOKH3?=
 =?us-ascii?Q?MNHLi+aMubEOerW7FM8iHajXk+T4dTo3NEIxex3tz0uRkwklCBkEpW5D6hwl?=
 =?us-ascii?Q?TZYoD9mKJDzII22MozcvIaUIZpmhi6SNZ6KYKmzO20KmQkvpybgQDiNLBw0R?=
 =?us-ascii?Q?DcP6oKixtJdxvlDnnd0KqxUdDFLOxkqklBxLOksG6g3wX4ygkdXBYRQQ/Kg1?=
 =?us-ascii?Q?0bGB/ua5VzOmSHPxGrAgD4SZUHHlwHioMMOzQ6qZe10lQ/+7UWGBi9291tQX?=
 =?us-ascii?Q?G3vrddoeDuo0XwUIxCiBMIv9bUOE5p8KuNUnVQ5fVc3HN7bsKBkePqL4lGrt?=
 =?us-ascii?Q?8jQLBB9VH9DJjOSlR/BJEvo+RhPTjsOgXVOz/wfyTto3nclU4h3lvvmuLIh8?=
 =?us-ascii?Q?kQTmWHc/7Rokj/AkFWKpMszbuyub/E1CN76Mw/DPdnrEVIH8sVIX6y9DMG74?=
 =?us-ascii?Q?9kmzfnJprX6Hai5rTDJg3E0krkrxbeS+0gTnzpexSbxeF27jtNVhS4ybtzaV?=
 =?us-ascii?Q?iCasyCeeltqfBbbBHeTHLvRbxuPAWnLwe3ZFjx78C9cFY8Jf3hp2od7z1C4N?=
 =?us-ascii?Q?83BV/0Zge7mlGh8AQaAO2TB+gxw/cDHGlOSNdghIu+g7Q/XM3Bdn4iOMaL8j?=
 =?us-ascii?Q?7mGkuB7+it3vlslU7vzNMXkRTgkGKIV/gBWvd2smznhySW2CiunU69Fc+mEp?=
 =?us-ascii?Q?gHdjAQqFwnTeNKrCploGPe5pyWLPocqT/ehRhwgPdJ5zQMs30+w8PfZO0RIr?=
 =?us-ascii?Q?DqdeVWZxQmNhR40on0s=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fddd2538-2964-4644-ed83-08dbde28789b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2023 17:56:00.7655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1vGgBCF/OLGFPBqcImmzH9CZy2e8r9w0bKk5iNX/2y55yLqcnenOXYpH5QpGlOJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7219

On Fri, Oct 06, 2023 at 10:16:21AM +0000, Vasant Hegde wrote:

> @@ -1557,7 +1583,9 @@ static void domain_flush_pages(struct protection_domain *domain,
>  void amd_iommu_domain_flush_pages(struct protection_domain *pdom,
>  				  u64 address, size_t size)
>  {
> -	return domain_flush_pages(pdom, address, size);
> +	ioasid_t pasid = pdom_get_default_pasid(pdom);
> +
> +	return domain_flush_pages(pdom, pasid, address, size);
>  }

There should be no such thing as a pasid for a domain. There should
not be an api called pdom_get_default_pasid(), it is nonsensical.

The callers know they are being called on a RID because they are RID
ops. They can invoke the actual flusher with the RID PASID directly.

Jason
