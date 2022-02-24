Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C208AC433EF
	for <iommu@archiver.kernel.org>; Thu, 24 Feb 2022 13:04:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 77D2A4044D;
	Thu, 24 Feb 2022 13:04:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OWINMwpD9Lai; Thu, 24 Feb 2022 13:04:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 29EEE40141;
	Thu, 24 Feb 2022 13:04:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEFC8C001A;
	Thu, 24 Feb 2022 13:04:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37556C0011
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 13:04:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1128C4163D
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 13:04:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NrfErDcmG_y5 for <iommu@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 13:04:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 446B94162F
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 13:04:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXxge798+u2laUxazW1AUd3GM4r4ykqssILeIiO+6bEmgdE6AZ9oT+u6NvFP+rR7nKKTkcGA9owA1ABWdt2x0x749nzLq44MBNBPETZ4o5I6Khyun20cVRZeQ1/qKtfwAcCOkc5Hdn0pUDFyOgm4JC0p6KjJKRu+bahDPmE0RdO6TVlHWBx9oBGsXH8N6LhJr4GSAx5p3sq7WmFrh+md88LgQi3QOcDiXEs4bHS+SehgIeVMTPLS6laChcgiJrFAATvci/sSGgVGkTAxvi+JX2e3TrF/lFZJeFf0ziUlLaBPacsufO1+eqU47mCcdt1lRigTMfsKGl+5Hx16ZqgwPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpYv0mDMa0aVPKZoFjszqWQz603uotNAjfEcP88BVVY=;
 b=ZROmKQyWnLdC9EqPG25gHijZJ8fISF4hGWlx150ST+jedGcK0dMrd0iPXv/I32VSobk1WxTCNAolutJXHc/EKNpqyEGacqh0aYQVmDWfRwalB7daGNKuRSVEyyvij4ULJ2OBSrgNKWabfQpiq0jiLpTGFrZc8pAYI/GQh3FqR011d5S9NXtF3p+WRl/w2wA0TFA6K2kkuOWv1Ka3OC3kchn/omDdYs5gLGpRF7bSe0WwATrkMqZXPEO1z5g1dFcx2a29SFTF3z59xhTaCvcrafc6Ei9ygyyg3hSbOvDPj1MQi7MgL3Ha9BnwD1tKKJZvN0n3MrLb+TTTtjdNkRdk5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpYv0mDMa0aVPKZoFjszqWQz603uotNAjfEcP88BVVY=;
 b=A+LKdWHDNARsujfZSc6+mga1WF0zG9c88s9rW5MMCdLoPbw5iDpqn3+rgx719WnQTYX49O6yhwScjcExLBInNv6TsE14CxnhMnVXusNp8BT1B2EVo1cHj1PVGB5e4zfnl95vLq6klLkRzV/B0CKXR/4g4PJwD7Z6KYO0JktIt44XvSo8sDaSkWp2qr3G76wnjRST4pO9xgxpe79GtjYZzs4eo7UCT22a8VEQfnGh47L9UgeKKODvI3nDfq8/TqFO3xy2oQL0eR3QQopQJcMAQb+uV8OHHdolEloRrJJ0vtOUbfKtEySfVyh8J7SXyYgVBpKzEBAl77G/steZPovUZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by DM5PR12MB1546.namprd12.prod.outlook.com (2603:10b6:4:8::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.24; Thu, 24 Feb 2022 13:04:24 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba%3]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 13:04:24 +0000
Date: Thu, 24 Feb 2022 09:04:23 -0400
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 05/11] iommu/vt-d: Remove DEFER_DEVICE_DOMAIN_INFO
Message-ID: <20220224130423.GH6413@nvidia.com>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
 <20220214025704.3184654-6-baolu.lu@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <20220214025704.3184654-6-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR10CA0036.namprd10.prod.outlook.com
 (2603:10b6:208:120::49) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acc81f2b-ff79-4f2e-f981-08d9f7962e7a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1546:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB15469D4B715CA68099A4D318C23D9@DM5PR12MB1546.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gE2Er5W4OQVqS+1XMBpCc9WtAlSw4hpGchVUczoJX8ewM8+wvzfhP+05YDtJfLuiwPgekG8hMLtgbVDJ/SggqKfVutFJjWfcDhZufUvwCblyaJaL+KxgwLE0JjWTcRtXiaNYlBuGjj7OKhLERXVTNHzSjYvLyU2rxIB9Cpqa3RVmXZmOZFVyrn6YzWw2kYp8ImU1nvv9exvp/pWma4M9ByRnhbHKnz0FWfxsgFEhumqT7tjpFe2vnrcngtMD8s+xD9VXBojeBX/70YDeakjVlWlGQC5qvdEoE4R89WWINjtMtcTXZFxy5c6ZnmcWH6jB7DmrRhFurscPu67veVLHePqE4Tpfpq4nsBiQLa+Ob5+09ENTdOFSWVFKddXRrXQK3JwafMY3eg6SMO5V46tlUy8B7c5wgUsoY+TR5k6WwNJwaRAkIFGrwhm+qshgIbSfuN/h6BpPCtGu6fC1+3z5mKVscWHJIZar3OQO5uya1pEkcLXyso9HVkbBpxQIKU4HiHdyNBND2uhp3Y14JdjX1TyqiMRp+Qu3HJkABCLKN2ybc2YjYZQo/oZYAm0ixdcgpZSGlo5S49ecH7gtw+N8IDDefUT6o47PGgLHncUvjWV0NE3OzzqPlakkUkRYqyugLX7qr1k37oTyZGkB3lqLSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(66946007)(2616005)(66556008)(186003)(26005)(66476007)(8676002)(6512007)(6916009)(6486002)(54906003)(1076003)(86362001)(508600001)(316002)(38100700002)(4326008)(5660300002)(36756003)(33656002)(8936002)(2906002)(4744005)(7416002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xutYdIwMmKwUjhs7gBqgzkTHsy6ankKqk4Rrjoia0Ob5UJLkFSDNg0Bm7ZpM?=
 =?us-ascii?Q?7dbYk21Pane753Ll41wxl95to48oYBgAGvzTv+CHY+32TmJ82KVqtt9qh/Wt?=
 =?us-ascii?Q?fn/EJQcW8RP/OUtG9NxKL31Qon9l6UOONWfPSanGm9hzyXF3e2hDh3z0B/TU?=
 =?us-ascii?Q?P5cmLM2XKlqL5kxXX//j9HQZe3Z/VeYx8kG4ywD/PtdAWwZHjp4jlU0GIJ2j?=
 =?us-ascii?Q?OaEKsLn0DWFy3UAxQPaqLMN55QH0nLHrERC7Gnm/x0tuR4MUi4dFvWGqpm5v?=
 =?us-ascii?Q?ytICWrGAKlSi9tJKbK6jq7E95gjWYe7c6zonE53rqFwp2j8Ke30bg+X/r04J?=
 =?us-ascii?Q?YB619qFDvOSGNZ1fTfFiCW3Lg9flA9Tq8hZKwkVjYTULESe+gPQVhafrYair?=
 =?us-ascii?Q?KRqO/GJb4xVJXnOPhvpc7sP9dtQffNmECIHWqKgp6IgoHmSgGqA9mF67d0yl?=
 =?us-ascii?Q?NkOppb2VeDR1wwf/QJweQiQiuB5sRgJP9dPZKQc4GsG8iuWF+owaSTEg/leX?=
 =?us-ascii?Q?nfCOHGkvkLuxqg1pcnl39BEUqYeRzxrnrCoYt66VRjlpQgeYrh2yYjyhgyM6?=
 =?us-ascii?Q?Xa7md6NJowpgfeGpL/5icahKr0DEVKWiUij/5rd9LNTjvqleSLjyQ0jEtQLL?=
 =?us-ascii?Q?Qnn6ToOXVhSm0nZR2BDcTaLOA2ijseY7jD3zCva3BawQDdsyBpoJCPXRbbjb?=
 =?us-ascii?Q?fJdnrxvZnstnr9gBG8NUvHn9j968GdEvkxVSvmrRUmkjELAMxR0EMN0O+/V9?=
 =?us-ascii?Q?vmErzdORnN9P38qwK1i4yt1ngLdfNVFx+ZQBdSg1RjLArUaJKPvcxAUEXZ/0?=
 =?us-ascii?Q?7fmadYUW4dSeQGvOlUhm8YWeny1w4zMrnYT2JIMGULum+j5KXm50NVXwlvo5?=
 =?us-ascii?Q?hxxGmUBZu+n51rXMC9UYc5hgHLi0xAJI96kHU1ei4OnifJHFiQu2h0J2hm2d?=
 =?us-ascii?Q?z+qhIOa3kKknKpmzsJbA3oAiIBZFNG22xHNX6w8QmVZ5CSlG2Pc+1vCf7Otv?=
 =?us-ascii?Q?PQHN80jMjvI/Jod04x1EFILV+pE8O8v6USs75BGsm3H/TdHX3NbiYDkAh9UK?=
 =?us-ascii?Q?D1wLod4rP23F/YIXZHmz+jeK+6fXnI7CFN6lYNQfhieOAVSoL8x/EAtJl5ir?=
 =?us-ascii?Q?P0fWrhawdCwzbLM2Gl7NpgNEq/aVwJBqWGw6EY0eXTeNSyHs6+HuY6R4w5KM?=
 =?us-ascii?Q?M1efauzsD/TLiwr8+rS9JTRqOAl4y/kCF5q79cL5Vc8NOzsgdNmrzGGFDsgV?=
 =?us-ascii?Q?JuCvKmQxe8pik/3f2mlCo2MtM/hpaPoSkJM7kV6fVbpJmwsIgO+IN2hKqlYZ?=
 =?us-ascii?Q?UpS+NWLyjF7+D1Ih6GOXY0jhGN7iXPW1+i8p7ZquP9BDxURUvL1Oa1Wh3rw2?=
 =?us-ascii?Q?474uxC070fnBeWyfNtXTni1GbkE9rZw3IhSa0CFF3JoIOpcBlSt4bO0LMjJi?=
 =?us-ascii?Q?JC3Vbr+C8wQ8fiO0wtFwZhl+0YPOx6BydZVzE09LB7UsPOXzywHloNg2Lw2g?=
 =?us-ascii?Q?iefw11GReNgNKA8f7iZ6UEdL3ApXv3XhR5etBU9fCdV7hhqDbtMCiZVVSwjl?=
 =?us-ascii?Q?qQJMiRuj55DCV5sTVVI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc81f2b-ff79-4f2e-f981-08d9f7962e7a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 13:04:24.7383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xXIXvRh8Sg1goaB12cmMOrYddVkMPLU/DuYpd/oo5MkLZ7w+6BNADI2OBjDGedSH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1546
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Mon, Feb 14, 2022 at 10:56:58AM +0800, Lu Baolu wrote:

> diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
> index db7a0ca73626..ed796eea4581 100644
> --- a/drivers/iommu/intel/debugfs.c
> +++ b/drivers/iommu/intel/debugfs.c
> @@ -344,7 +344,8 @@ static void pgtable_walk_level(struct seq_file *m, struct dma_pte *pde,
>  
>  static int show_device_domain_translation(struct device *dev, void *data)
>  {
> -	struct dmar_domain *domain = find_domain(dev);
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct dmar_domain *domain = info->domain;

It might be nice to someday call 'struct device_domain_info' something
clearer since it is now the dev_iommu_priv..

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
