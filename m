Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79608C433F5
	for <iommu@archiver.kernel.org>; Fri,  8 Apr 2022 17:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1489C40190;
	Fri,  8 Apr 2022 17:22:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Iuao6xvAeYJp; Fri,  8 Apr 2022 17:22:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E865540125;
	Fri,  8 Apr 2022 17:22:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BCE40C0084;
	Fri,  8 Apr 2022 17:22:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01B87C002C
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 17:22:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DC69C84499
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 17:22:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S7gd6GqFPLH0 for <iommu@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 17:22:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::613])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B877284491
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 17:22:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjUzQU4uW850DesTbQhTPea6+cOILAHFigOR9SJEeRhcspqWy9ORpV6nK210FfQOigSr0uXx1cdc/6Ebj2LLyM5HQ0ftjSercPeItXI0hf1J+Eav8TtEZSao86xnPRiKOemN0BXZ7YQKH1jnn43aWaE259w9Re5Zvwrda6YpDd5rbkdTLIOETNliYtsA5qMP3t3CrNrZz0bQg5KutVWmorHlkg4vfDYL95j5HsQ5vlDAxrsql0pyjGSkvriLb3YDKUcjas5DWzyixSfjGpYMxlJVhQORDj+ptkIqmHidw3fXYbs0SrC2qIPNqSNn0RuBa8l1NvSa7kkPynuoFrAp/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARWzIUxwu81P7+HZV1SUhII8HRib34Ml+zwYs4hDxqo=;
 b=MBTP1/Y5l1OqBSZq3GWTIl6Ybutrax8404B3nwyY8qQ6Hc1XXZ56No5SIJnV2WMtaOpXgPJJFw54VI/eChIX3EdmxWokyA3qF0MRchzca3KrYHrFC+NoSjJRM8UtR6t76c2pQlDL8rfnHCAYW1y5jvHzrKWZF7cjWU/0mQ1Az1YOEi2LM4uZ49TzbA06LFb3Qz1j+HLyFcpFt8D6jGgorZodW1xME8t00cuW3cSdnxClaDa5ACqobT+OwTRwXKk2jN1aEdtKbNVvD9jIn7mjxjXR/byCAsILl5pEPNvjpBjvu0rK83HkjKTu6/14Y7yFChbVQawzBiS/9sNexLF68A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARWzIUxwu81P7+HZV1SUhII8HRib34Ml+zwYs4hDxqo=;
 b=WJksQvcf3WykRthVfT/qHkP020zXPOj/t0FzA87aWJLXyJOTabGcv8PhxwAlAJMPShKWP4VXa4HYE7MDtG4SrN414GMBBK75tKC/ZgNy0senjZmhFdntow7ZxUs6ThRb2nqFXgWnxhtGFrrWtYlyWlHPpPG88sYKPATqq2a3+jcB3ufZ/8j3IwYMorLDLTUXRHC2QT8/6WVAE3Q6g8asZZzKs52LkJFK5Ftcp33gztR4mm78vd4Y4F/I/eHtzDcHIudYg12YtfLGl0u4hs4V5xBQpCCLQKdw7tu84WHItZP994OQShDMEUw5f/TMB+5lkubAW5YPPjQvAq2PdI7YXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB2952.namprd12.prod.outlook.com (2603:10b6:a03:13b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.23; Fri, 8 Apr
 2022 17:22:17 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%6]) with mapi id 15.20.5144.026; Fri, 8 Apr 2022
 17:22:17 +0000
Date: Fri, 8 Apr 2022 14:22:16 -0300
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] RDMA/usnic: Stop using iommu_present()
Message-ID: <20220408172216.GB3637956@nvidia.com>
References: <f707b4248e1d33b6d2c7f1d7c94febb802cf9890.1649161199.git.robin.murphy@arm.com>
Content-Disposition: inline
In-Reply-To: <f707b4248e1d33b6d2c7f1d7c94febb802cf9890.1649161199.git.robin.murphy@arm.com>
X-ClientProxiedBy: MN2PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:208:160::46) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c19ae8ab-2188-478d-03d1-08da198454cd
X-MS-TrafficTypeDiagnostic: BYAPR12MB2952:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2952A976F68CF1E9D3AC4691C2E99@BYAPR12MB2952.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oI1PYtwYrkKrTi38/jjG5t+QvnblZFChenjSVWpyiIzKCq7AL3JVobdRqwpr+Wmc+0JpwmMq+cWm3Fvh6+OWNZZa6tKcVMdOF5EwaITqWSZRK9NbwSCrvHcZT0vWdrHhAQaDdBSoVp6stdWQ/O02I87Ifng3/DNlFO0m/p+VQ9cYqyWjZ4ZHK6y2U+IAtvVma+IECysOIv7AnvRwdZlpQ8vhl1F3UjOihaSSwm/tyJOPHn0UyCcfIr06KtgEKZ38hWg88TJQChf2W9lHZ3gdTujHNRRi0nsfo9wvBb4vhg0Sb+P5OgEBf2QFpku/T9tqswvYBcP/LqtUMAI8tQLkMRuVFT2nxRGBjSxo03FB1oo/WcTl1wEGM4twlmFzVrpmccdiSuFphqenyTG6MoYaaERUFo1NVRjSLe6Z8Qr8XcQbhBvldfHjkcjtCBYzBy/qYbiXOnIU4l49L/PzL/rrkT3uM4XbW/bBIzZP2FHR6GYYO3adQxgcRLc4X0+fuEoZEsji46+IS1FyVQ9iKr1rgeZfkxv4oWJQpah/Rtx6dwdKS0qALREzLigaD1HLgj0qnrrznjg5syzFqqLmNyhDgQXZcclxkkisFrL3dKSKN9Kn5p9Qmqz2VWIJ8z3Xr/Lc9wysIlq0n+DzpoGRZpEM/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(2616005)(36756003)(26005)(4326008)(6512007)(2906002)(83380400001)(508600001)(8936002)(8676002)(38100700002)(4744005)(86362001)(66476007)(66946007)(316002)(66556008)(6506007)(33656002)(1076003)(186003)(6916009)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PFABgn3MbDdegX5tNB+sFhhoxLL6S+RSaXXSd5VlzQxbfmYEvYvDvMbHtF0p?=
 =?us-ascii?Q?+hCsxhkYu4Un9Qqn00TKdP7sWNGwGoaz8Z7Qkrtc2hD0CNTbqjuaE69dyxQe?=
 =?us-ascii?Q?mkPVD4e4FylpmvJG5+L1iV7a0r1nqzvLrx2QPg+xBmHQs21wwk/vZD+xQN+/?=
 =?us-ascii?Q?Hs/at7b9PcJFm3KNIt/f1z4vxPqm7gkQHe65YMldlMEMpBOjEa5XnZ9rBfqC?=
 =?us-ascii?Q?i9RPoTl1wu4HQxovxdXf0LDXSKGPN4R5eSUtiWcjs9NQrrgXBKKS8hyRJqIM?=
 =?us-ascii?Q?1WRYMJVjgyC1t9rdty7BKlfTdCY62JOY14gu/t2mEyj44Rk0MnEKMDXTFwyE?=
 =?us-ascii?Q?0ck4saAEzRNf37iijljswKHcDDobX+z0YsaitPr5zojItOV8chF8LRVF8lZM?=
 =?us-ascii?Q?uYv3avT5fPib3ZFsPh4jZCALL8EHw/CAqviCqtwWgpEV4cdEDyFRG/EF6l1f?=
 =?us-ascii?Q?kbnyCzDL0ph/ng/qKKTBbxeCSW49zXjpVFiWUVbEjbWbVwGac6tPSSdAoSbT?=
 =?us-ascii?Q?HkilGZVIBzvhVO11DLL2tnSjgNvguDwt5T5rmKtwKAhHk1xTPxom0yNwxhhG?=
 =?us-ascii?Q?oQrEl85s/N1bLXY7O/pvStPor3H/wH6rxdkYh3MJb8aeqQqTgZI9Xbql4oSB?=
 =?us-ascii?Q?Z2iyrHxQqKaqwLU6ee/RGOZ8TXc8RtXT0uV7UqVhmEAwO/CRlvf7mqecrl8r?=
 =?us-ascii?Q?rR9jGnZD20B2lmc6IlnLmb2xPUwr7e6jr+I2A7/gNctwMTr4MRa/iffMEYbD?=
 =?us-ascii?Q?AqLmFeSt+fqnkRC7heftlp9ZP6ipPZ6zv1I9L53Jgmx2R6Uqp5ELTTK94bIl?=
 =?us-ascii?Q?ZBUb3gOIRH0mmrRX7c17fXMphIURlukc2fgZ93i37jTLHwwsn44ADGb3B3lr?=
 =?us-ascii?Q?pgVSEYJU9clIA7++ntm16TESg+TrFGBMJfuwX7HDgSc//0VGQTLrILy2e5EA?=
 =?us-ascii?Q?IrmQi3rDa8bd48TBKBRRuBaNDOIhMf5n+4APGaKqAsI0AqcbMS17titwifPQ?=
 =?us-ascii?Q?5gBgQ3n16egUTlVakVIiEftCxuxxf9RmC88+7TY2h5J9koYczJc4ORtEiA6i?=
 =?us-ascii?Q?O/T0/DmBQLEjGhpFKOJHGoCni1GEkzcAcozt15ZBYx5byKfJg/caO7SzPN54?=
 =?us-ascii?Q?itw7ppT8RwhTnHZpcDiTwjcrnpbI77cPj4PbkGeSNwF/EP4eyINuvVz5X1EW?=
 =?us-ascii?Q?TQW4iTjh4ubtsnYG9P/9wjpTCfP4n25BM+LsYHbLdrS7G/D/BXlVae2cuumk?=
 =?us-ascii?Q?5ECQabXbX/OfceYsqBMeYxW6DoSAdifW0hpIljPOQV3rW+eJlI1ye0i+qfxh?=
 =?us-ascii?Q?9DhwXa1jcKz+XMG3RxdjN8Jal3versy2ymjM+/Y5XLJl/WWsNYoaaoBtCAlG?=
 =?us-ascii?Q?G6Xc9CDEJoATj3p/fpVREbHVGOt+/125NSYXjZkfj0S9N79A0+RbvVhBrFxs?=
 =?us-ascii?Q?nsMGSTY/LE+eafPyGSXxfWG9shnR3bLtNjuG5XubOECQBNqRe9EY7xbtVQy0?=
 =?us-ascii?Q?HzU/1PpKV3DaSWsqLeJQNk1jjs50j+VA30Cvmp646fkdKZPhdJNl62te8l+b?=
 =?us-ascii?Q?wyfpBwHM7QgqYAz0MBxW1JhpIB1DGfJyW2yN8KiRZOGOf4NGg4GmXiiBb0Oi?=
 =?us-ascii?Q?r6XidDSc247ukxRB43CdnvLHVTU1gH/DDGSO3ZU+RLpUZmtHfwSbOXr9+X9h?=
 =?us-ascii?Q?W2QgVQKQRxyuU4hmwvRyl4yujhacHOVPaIQpcbbz5fSgJAZsnZKgCK9U7jwh?=
 =?us-ascii?Q?npEUnHcl5Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c19ae8ab-2188-478d-03d1-08da198454cd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 17:22:17.7476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uAZl28oQ88uGPkPOS4Qh7NlQeRylubUCnfNqlYC3fXY/SoueUUeujEoTLnNj4ELb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2952
Cc: neescoba@cisco.com, linux-rdma@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 benve@cisco.com
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

On Tue, Apr 05, 2022 at 01:19:59PM +0100, Robin Murphy wrote:
> Even if an IOMMU might be present for some PCI segment in the system,
> that doesn't necessarily mean it provides translation for the device(s)
> we care about. Replace iommu_present() with a more appropriate check at
> probe time, and garbage-collect the resulting empty init function.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/infiniband/hw/usnic/usnic_ib_main.c | 11 +++++------
>  drivers/infiniband/hw/usnic/usnic_uiom.c    | 10 ----------
>  drivers/infiniband/hw/usnic/usnic_uiom.h    |  1 -
>  3 files changed, 5 insertions(+), 17 deletions(-)

Applied to for-next, thanks

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
