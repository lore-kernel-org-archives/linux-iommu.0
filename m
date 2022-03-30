Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FB8C433EF
	for <iommu@archiver.kernel.org>; Wed, 30 Mar 2022 19:10:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06E6784752;
	Wed, 30 Mar 2022 19:10:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7K0EWaCXLMHg; Wed, 30 Mar 2022 19:10:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C0A558454C;
	Wed, 30 Mar 2022 19:10:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F819C001D;
	Wed, 30 Mar 2022 19:10:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31FA4C0012
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 19:10:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2061F84752
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 19:10:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kcE5eL70Cyql for <iommu@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 19:10:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::620])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EAF438454C
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 19:10:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BA7T4pLzeK1pT8uD2LN8C8xDtYUW39qAEyyqL9RV38BGoLsJ3n4IQg+uACUIni+dYEStW0U7wCNmeGcxUn9v6aThOZFNXy6zRbASYTRgRDB/JH2sVZ4mqRB1yPCQZerIQyTTOKNB5IIsImz0gbg+BG7hy+I2mfHXLP9os68vspEmNWGpLFCqzxEpYhi9SYDjJtO2z++fpYCDiz76VLXALCuYcBu6Fz2Z1jiKhDKdLylz/4WR6X7HxlYJ3FmCU7GEsZdHmH6k8lgSOSaL5p8LQAGWDVrPC7j4xxRcgnppZKC/6Oijvqy0z49glzM+NXAOY8rP6KdxPWYHFCnEjyDkcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9NWUqlz1Wum6EvmBudafLjXyo7VLyS6hE+iiw7zAgA=;
 b=BZ1PRjUQA94RwEmvmV/xuzpq0323wTqOeASUOPMpWw2XzW8M3BtxN5r92a6hsRnNiBNT0u4puVsyRih+omdgC7gLfJ0jA9SUWAoDChcB4+QD3W5ddhOzTRSgFYXSBRYKK8QdF1bqKLzqBq1+q1Fzm3Lqu/zWJTdkIPmOBfesX3vkNyJYnIh735Am665OKyWZIfYiHLIR7DhbUQTH5IAjb3bNETnHW76J29ZHOj4qUUNZCjBH+bpC5R7WYxh/ryTN9vjA6tGV4/U4bpuxY/4SOnuzVH7FLoPD0uGHwL98YCVV7lB1SUzHjbvrP/ARhl4QHOjvi0UH0kndlVmva4KR6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9NWUqlz1Wum6EvmBudafLjXyo7VLyS6hE+iiw7zAgA=;
 b=JY2ovFHXJq75cnstyCq/nokbEN67L4aaKoWW/JiVp9yDS/RzrtjsKwFg+RIZypbdu2oxEwifCZgHBx5s1BzxQb4/xyTU9ATSP5gM6+rYw92ieQIuL7UYeYnt88l+DFhC7IlUsFL7R8xE4ZlYt7hKiEI54NVSGUTKPPEZUDYROrHSpg5wbqg76Bbr/jVlPp3VpN//Yur69RIwGXdXsdbH5atoBUN5dL/EX8Fhqkla2s7mmuxMH1ClrTSwejvnZosB968n3gH7+JfPNO7LWTJM8y2I1G83gJCxjOPr3OnszyvcKivk9jQLW71tuXUnIo44fPrmlk3PFdsWLlSBoS2nAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Wed, 30 Mar
 2022 19:09:58 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%6]) with mapi id 15.20.5102.027; Wed, 30 Mar 2022
 19:09:57 +0000
Date: Wed, 30 Mar 2022 16:09:56 -0300
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC v2 06/11] iommu/vt-d: Add SVA domain support
Message-ID: <20220330190956.GD2120790@nvidia.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-7-baolu.lu@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <20220329053800.3049561-7-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL0PR02CA0101.namprd02.prod.outlook.com
 (2603:10b6:208:51::42) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 746b199b-96f4-4407-41c3-08da1280e1a1
X-MS-TrafficTypeDiagnostic: DM6PR12MB4283:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4283C6DB705D6A1C4B3104CDC21F9@DM6PR12MB4283.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o0XJIz3BdpChpqsigK+F8yDjwpRYE7Gifsu8aWQfdo/jSaRdBczPe7KqQYgylnIrLn6G940Na60+ZA2YfzJriC3/wqVLcLODw4hQ/uFrDsN54WdBJw5i1LqZZF5IoKZl+PeUfBSm0MYVlqngCOAYU2yDPsBXiTw7tW6pjKFjUtP0zhHgKE18c+xOz5tqoqJVMIGkEo9mhzkd65g9cE9y42f3Lt5TW+r3oHz0dJTs4fvKNhvPStUs1TL5fh3NPqtA5L+0p7ZrEfpamCZA0ykTCVRUAtgAkuZWYCPjZDn2dCSGlUbavJKa/UM9Sqqv86RfDpTJmlWef+2fBtov36K+gEBIh9eAhOvsJAluEl6tQb9Jc37UVFHFLx4HdB0hZ4DOO30acESDwxGyZoL4F26lEu3jlbArLKCorzv7RVraOnO3d8Pi+H6iPvViEUzaI9h4Fa3qx0bEn+16Uif3RpfpZ8gIC1ywo3IeQ64tLi/w2zJCHXbBWC04tnR7bcnpn5YziPOLthF+SAh6QyDtd6GTf7bXrI2cISl3fDSOgVeJcTONisWPi8PQtOnmQmjdhL1KY19Dy3xYWrGaTSPF/74+v7ZLO7SfV23iEUPr5ZAg3rvDRzbF5+Wq/6gekiNKdR25UxF6/UKEcj7R3xjqyyVdHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(1076003)(86362001)(6512007)(316002)(6506007)(2616005)(6486002)(186003)(6916009)(508600001)(54906003)(38100700002)(26005)(66476007)(8936002)(66556008)(66946007)(4326008)(33656002)(2906002)(7416002)(5660300002)(8676002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hDs1h0VaWZclaq5qv286zr97qNLwc/qD+UrHJ5S8mvCwFD3H4W0RKt+3y0j9?=
 =?us-ascii?Q?eXBriV2cEmwE9mK4qkLBdJtJWMntLIbNK0GYB7nl5W1EK61Xe3j8C+WbvK7t?=
 =?us-ascii?Q?ebLJZ3+N0ucaHDeyFzMIeR+jp6zAZW0zVwhSGjexB9uvbUVLhuLl6C9+9R2p?=
 =?us-ascii?Q?eylBpq2ygxdt9EYwlwSVwOgQjYt9UKDX9xohkop3DYCY6vrIxIum4yhDT3WM?=
 =?us-ascii?Q?NYf1+ObNWMTR9Maq+y8rMZx+VvKGX//Pl6uo0O6ZsX8cXT977AgfwvLXCiGg?=
 =?us-ascii?Q?cZkHMBeaG6rQTpjGZBknTAzuh+oQ0NOvwc5zy7teZWrnrx3KzxWi6yk3G0D0?=
 =?us-ascii?Q?8UDtYE0pZB7zJMTVQ56cUcDqKejjQ8aeXczTnX4c3icEowyBZmTC/PLUAQtN?=
 =?us-ascii?Q?LBLSyF+3mbV26Bm66ZMA1TH+rdOKdgXs5Tbvps/k6RP1ggiB173hfomzBr5h?=
 =?us-ascii?Q?UIhKIRwbqivwSHUMpWaO0a9ArrGxr3yXUREEGfsUKssw5utfFGx1YfuEbcu0?=
 =?us-ascii?Q?RTIHx+OqcGH+pB95/cNombVl3RZsRbxKIh42i/Ne4uCZsvIEmOsyTw375GMh?=
 =?us-ascii?Q?TrPhBMH/uK6vWDSSgWqYjaFrxjeoJZ61o2ZWvnNIRzYwKql2EBtQ9j6Oz1kB?=
 =?us-ascii?Q?FEhcavMxCu6HnoqxPniY+4jRLr+3rTxo9Dy/8Hy3GYDSCVSArHgxRKsbNCpx?=
 =?us-ascii?Q?NJNPqYoUOTpSh82gd7GTzJn4u3e9G8RkdRG36y385CtjjNJcdg2fiLjQFcE6?=
 =?us-ascii?Q?Suzx59YS1aEe76ybeRi+KoR04Ghn40irbDhNYvz5zSp5/Nf7wMFvbc+gaiZS?=
 =?us-ascii?Q?aAVXsXU9Dzpx83bwdzDRsMZL6ba+e8IY4pc0aS+3kZnM9PNNi7/yGUmA80rm?=
 =?us-ascii?Q?1jFBvyo5/HqMhveqIRgaOgjZghSO0WA9DLo3MkX8F7qqOfLdflbzkbDKOKhg?=
 =?us-ascii?Q?IHpPzn4v52Yhb43p3wQKnTyTCyGtu/0QsEHNwVAyQ009lqgapqcCHGsMCpO3?=
 =?us-ascii?Q?haOYgM2wej0kcWRdXwKVkdW/7CUltp/VSM7IxPtJKgoi8RKY1W1+8gQ5S0La?=
 =?us-ascii?Q?PltSDLB+A2serE+pxJqh7m549fNNR4VSWuzJW3ynpi3a7O9ByIZrDIsu57AH?=
 =?us-ascii?Q?zNIxkBhHBJQWkLZyF8BBgrLT0aPI/MN+ZII/RoLcQz8Njy9oMzUoKsohXVeU?=
 =?us-ascii?Q?0LXp7yK0No5mDAfTU6KIOz4xvBdwpe5dkfMsAsiYA+wEOeSRawGRXywgMRrn?=
 =?us-ascii?Q?DWrWIkkgnZmvPQmT0pDoBxQVb5+xXiDTfbXImno/NujzUcJzr10HlyHWgnM/?=
 =?us-ascii?Q?YqPgqt+MPSnbqJxNI9J24JpbqaCxt0augJ8Qig1iowCblutEuhOebvQngmwQ?=
 =?us-ascii?Q?9devh1pzHZcNDWSW8p8emNE8nESHW85KDqSpKDWSwbiruGBYRxLTffU0IpyB?=
 =?us-ascii?Q?+IHs1k0MKlX7tCp6LoCFbRW6A/DMwrQJLiudXErvGdwkOV8x1I0GNkSflZ9M?=
 =?us-ascii?Q?fJPead25g43eUmvwl8cIHzLSmSawL5SEN4UQwPzpGCWVM/pr6Bwidzk/NUj5?=
 =?us-ascii?Q?xo0lug0KZ8spgdhPpY3Fpmg9T9OWwB9lS5QWr8lBP+f4QZZhhJdPg7zDej1P?=
 =?us-ascii?Q?gxyUgsL0hwwqHA8H30hT30nsGCcpmkugzu52dTm9EPYER4Lun4B6Vz5H+Itm?=
 =?us-ascii?Q?VgYin6m7VUGl5+fp+KsGRXhNl6kuYfv24JT9gR34YPi6rVPaTfkPQjp3yDUV?=
 =?us-ascii?Q?okwqq6e9qA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 746b199b-96f4-4407-41c3-08da1280e1a1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 19:09:57.8464 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rM4aXFcORYTkC9OW5zqfpYtIyANI2ylJ2fnXugXWQEOvZJ96E6NObRkB4HGrOMui
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4283
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Robin Murphy <robin.murphy@arm.com>
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

On Tue, Mar 29, 2022 at 01:37:55PM +0800, Lu Baolu wrote:
> Add support for SVA domain allocation and provide an SVA-specific
> iommu_domain_ops.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>  include/linux/intel-iommu.h |  1 +
>  drivers/iommu/intel/iommu.c | 10 ++++++++++
>  drivers/iommu/intel/svm.c   | 37 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 48 insertions(+)
> 
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 2f9891cb3d00..c14283137fb5 100644
> +++ b/include/linux/intel-iommu.h
> @@ -744,6 +744,7 @@ void intel_svm_unbind(struct iommu_sva *handle);
>  u32 intel_svm_get_pasid(struct iommu_sva *handle);
>  int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
>  			    struct iommu_page_response *msg);
> +extern const struct iommu_domain_ops intel_svm_domain_ops;
>  
>  struct intel_svm_dev {
>  	struct list_head list;
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index c1b91bce1530..5eae7cf9bee5 100644
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4318,6 +4318,16 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
>  		return domain;
>  	case IOMMU_DOMAIN_IDENTITY:
>  		return &si_domain->domain;
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +	case IOMMU_DOMAIN_SVA:
> +		dmar_domain = alloc_domain(type);
> +		if (!dmar_domain)
> +			return NULL;
> +		domain = &dmar_domain->domain;
> +		domain->ops = &intel_svm_domain_ops;
> +
> +		return domain;
> +#endif /* CONFIG_INTEL_IOMMU_SVM */

If this is the usual pattern for drivers I would prefer to see an
alloc_sva op instead of more and more types.

Multiplexing functions is often not a great idea...

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
