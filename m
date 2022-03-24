Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB77C433EF
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 13:46:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66EA7842F0;
	Thu, 24 Mar 2022 13:46:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T16ABdYA_RjO; Thu, 24 Mar 2022 13:46:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 89B1B842CE;
	Thu, 24 Mar 2022 13:46:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72658C0012;
	Thu, 24 Mar 2022 13:46:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4510C000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 13:46:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A5716842D6
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 13:46:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B-9o3PR6IYzF for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 13:46:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::62b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 23F85842CE
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 13:46:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuMTCLuv8ZigCGbC9NdIQwm3valLZcddOvDJZbzL/MAAQqC9usscosZd7KOUzhUaDwl8XE8wcjyMqFYjZZBrLpEEBqH+DqPwtl+WCV5EpOYB4D0KAf3iaQED6YLV7dWsOpnlyN6ZGe8iKXLrSoiUTR/uWPuo98OUQcu/NizMTHA2vG+QFnbc1KKl7T8uVbR61/6uPRH0ImVTcKCNUr6QLziOBw4ns8Sm9x5BQbcPQ/4WIpn/BOoHoLo7Yb6tYMru8uNdeLEVNc2BBRXH9fFK2IXP8ltfpJwNs9ooXOp6MWChQfPzHQGhVZEs7LxyL1wD4LwKtG8N6obM+c9OQpXoEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNbf00Qbyiq5Wb+/2J03ft1DPMHGW/EVrDNMKJiCz/s=;
 b=bcZTASKUYoNOs078p3AyWIMrOPGYAQeJvwEgI7Qkl5G4DBhQ66bKc5dgWTaclEJ41seT3uwzCqVRQVzqgOUJ3lazQYORkZe/QU0pDnjmnzvURVLgPARxXoByda3gs0LzXtlsyyHbngZFq1CkOb73ssNYyFkVEnoTbY4ELzdrN89W1FjhBoTaGfyh90O3AO7fGEC7lYzxmLnHTDv+IznJrvAlh5SinVsq1bkHpEGCTZ/wkxHvjDjMpViykj4xWO1U/Tb1XD/xPFdBW3XeDjCl5XHsAO5D1aoUjgLPBfOJtV04pX7/XdZMRphFlFDWJMarsQO+GJ3T0OQVZYhq1oUNww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNbf00Qbyiq5Wb+/2J03ft1DPMHGW/EVrDNMKJiCz/s=;
 b=CSOtBHimpKHQ/RGvYdnnx0QhgVGgOYJei46OPttc17UE7nsFSZJAzYejSTF4YtvaxFiXxRrojPimbtRs90jTXE3tTWmTHPdwEbqEGScrttQdN4R4PlL61Kw6Qapwxcq9GxopGE5+TnL4cisYN1mvqQjEoVcoVHLhWnHE2H1cjWy6/nt4Z+Vbwf45RZorBUPbfTzK5/VU2yc9ULyzq96e9Sv28i8e5i1vHkQstFmzSb8bVrPKaw0DNzHFBpwaT0mQT1UjRo0afLPkjXNQcrZYn3fhhth8ARev10ytlq6Z8MEVFclTFWCaO+tXy+uW6/yZ+ITazuX3iFMRjyDmR6vPcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 24 Mar
 2022 13:46:23 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%6]) with mapi id 15.20.5102.019; Thu, 24 Mar 2022
 13:46:23 +0000
Date: Thu, 24 Mar 2022 10:46:22 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH RFC 08/12] iommufd: IOCTLs for the io_pagetable
Message-ID: <20220324134622.GB1184709@nvidia.com>
References: <0-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <8-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <20220323131038.3b5cb95b.alex.williamson@redhat.com>
 <20220323193439.GS11336@nvidia.com>
 <20220323140446.097fd8cc.alex.williamson@redhat.com>
 <20220323203418.GT11336@nvidia.com>
 <20220323225438.GA1228113@nvidia.com>
 <BN9PR11MB5276EB80AFCC3003955A46248C199@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276EB80AFCC3003955A46248C199@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR19CA0056.namprd19.prod.outlook.com
 (2603:10b6:208:19b::33) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a716c61-36d9-4226-005a-08da0d9caf3d
X-MS-TrafficTypeDiagnostic: SA0PR12MB4382:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB43821B34CC5AB62699C6B5F1C2199@SA0PR12MB4382.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yJwjDe4W2li55jm+fzSMqy2G4Z8o9LmGYF2pLTZKxS3JbBfBW6J7ydyiE1djMvknj0a7CjqP8M2+sjORWX7y3Y/gUWo8GPffv/m7L22/whyt+ZrWkpaakUO2hpRQqWcVy84GZ90PfoXnttN+dkgbPR49zKJ0ECrX/E7D6Ei3Z020GEyy+e2Rpeh8zBsPSDlIUG40OpsX4+ZZHMx943A/4WABMOMDyULYY98zT3c8XeJr7xhr2M7rD4in0ANjUzVSmXi8fJug5vJX1NvIZzwd8ZH2IwG/bGhD2IGZJK83ZCuFkMnxbw2g0rWvvjGNvhQCxYAPACARdyrGq+xFV/YmMSwhzFOtnN76+nnSACxHf73mchij1Ap9r3tTPv0PVdtzSluSUbC5sxpMDh4Ga80K8b4eijJgSFWuA0lg6P6t3+7HHKN86eYFJPXRFyPpelbqdSCq3ni9sGveHE0z5uX3g11/cXQx6tBAFIhCryontK+RYw88R1t4ws50lQH8RP1LYDs5iUfIU2BzF3b6THsBuFXd57ZcsuwTy3fSF0hxa8KLJV/t8gzH4DY0Hmc6kHqZpR7bt7ArfXygx7+879CqsY4O53o03K6brv23DUVyidPNB+Kxab4qR4jXPneaualXR/biZraXNa1mwcpPXxOOSmbAyakYIfBY+n8C4CJIwByeEnB10BsFaYNcFl4yJWDI0nvJ03V9cnU9Y13mCBe/dewbo7qw32C2lKwEAa3R9g4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(7416002)(5660300002)(508600001)(2906002)(316002)(33656002)(8676002)(38100700002)(4326008)(83380400001)(4744005)(6486002)(1076003)(6506007)(54906003)(66946007)(8936002)(26005)(2616005)(6916009)(66476007)(186003)(86362001)(66556008)(966005)(6512007)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7cs5MgiYrdx5BnJfaGACELmlophr0FSxtEmBJQjW/G3jlHCpPsYd4OEWsC1i?=
 =?us-ascii?Q?MARwKy/zQt9KU8FM4imz6R79qQrJVW9xQY3/oOaeD70zcHnm1FyD6OBUB74r?=
 =?us-ascii?Q?+cksxnBkbfBN2NveyeL/msdULSzCGYJrX1hgL8CqIAbdraq6z+nEupVZ7ILH?=
 =?us-ascii?Q?q/XQOJV2/Qnp34cWL0VY0zr15jZZtc1K8BQDfCTMzHe3RBRELgKClGxi/s6E?=
 =?us-ascii?Q?R2OJUHFCVCiokaI7sqqhL/bNSjzomr2AHRywScAo7XRPX9rnEcYrRwEh2F0l?=
 =?us-ascii?Q?XhNmgUlWM2aWOpVWnpeocgzm20dihlrTCB2pIoDsLIFUhgBbFzGm0qkpYygu?=
 =?us-ascii?Q?NcB0EWwPOQDvkzUJUZIUIgpZHZojRlK5n0t1YrTQA6jSddiNR32Pt5nNbT+O?=
 =?us-ascii?Q?fuoBB5Y7MDa2vxQ6f7MF6iItKPIBTuWpiXPlg6Pwt3HXhD+JF1qbAuuTPVUp?=
 =?us-ascii?Q?YqQqEkDo7b8m6XTLREZ+oBPA10imRULXbiqH49M0OoCviGlMXAC3JjnWdqud?=
 =?us-ascii?Q?BXz8c1orCOvhc12sIBNCUW1NJj5RqzWd3DlHRD8oi/qkngOxxSNH43tRAJ0u?=
 =?us-ascii?Q?dnir33Wee44rWv8rNygUwpqDrHbwweQReqisjaJLry1bnuOodag+HYKxpnU6?=
 =?us-ascii?Q?0Iz56WZDY0KW5HEb8low8r4NBsTWt0k97robGSM5HvVNuMvdSuzRr/u8RUUz?=
 =?us-ascii?Q?kun7INay2wu7mQ7SVSI/iTP6FFtO41SrS3pP8wHj/kxVS/c4MiAYOkzlZrX6?=
 =?us-ascii?Q?BAX5j3myyEWSXisIixwZ9gYT0KEZQyGpmUo+P2TRE7Y62NoAIFLEc8cmnFFX?=
 =?us-ascii?Q?79GP8y4tbZ4SyWYlHf8U5Ph9YViZ4wupCO+457HSsC0wdo77i8wBX6EU+tYX?=
 =?us-ascii?Q?DTam2Kcnhpwv3tkP6I1z/WB3OjWoJQf3kCdAUQUojeyDTHKwxt3+nOWg1q40?=
 =?us-ascii?Q?nxfTPlSwpIZtLM/OznSDw0znhCwmaFj/XQl71TmfAgqypUJlac/F9a3dHmCh?=
 =?us-ascii?Q?txejQDUfBvrKFBkQPjgut90b+4hL+fhC7I04bT79MEmjd0CpkCZXYP/k3Y7u?=
 =?us-ascii?Q?CYipmkRB6zlF4fcaQdF6s66USJWoVOnuPvNVdHfpEzg3++1LoHj/NXOQTjac?=
 =?us-ascii?Q?5omcKspaMs3tnLz6zftAMLsGtL9qVyZObMjAGvJpSUtsRrIdXC7uDBOqw8dm?=
 =?us-ascii?Q?BboE2fGaovSv2DrlzmsaClTV0W8frtgZ+ebZ52nTv+oaNCgBK6cwGcdRs8Uc?=
 =?us-ascii?Q?lgQCrpsBuM1IxmTrS8mM/YD13fOx8g/clMKZGLrGvC7dAaywNamxTWZ+soJW?=
 =?us-ascii?Q?bMP3ZysisTC405UELcsrnex0ZCuylwu+KYs4zmlxk2IorVoMiRXgd6ooJcNr?=
 =?us-ascii?Q?HvbS50XV3WIjkv5nY/xnTf8brN9K9RRXTGv9oxc5QqMWQRq6LWC2raoD+Z+Z?=
 =?us-ascii?Q?21froFDI6oSxGyQm354m5FSUZgKZht8Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a716c61-36d9-4226-005a-08da0d9caf3d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 13:46:23.5697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qu/ASwAzMD82hJQPT8TjcSBf/LhPdkBlgjx/ShSvVDAuUN1j5tddkrbnKYGtVcIW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>, "Martins,
 Joao" <joao.m.martins@oracle.com>, David Gibson <david@gibson.dropbear.id.au>
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

On Thu, Mar 24, 2022 at 07:25:03AM +0000, Tian, Kevin wrote:

> Based on that here is a quick tweak of the force-snoop part (not compiled).

I liked your previous idea better, that IOMMU_CAP_CACHE_COHERENCY
started out OK but got weird. So lets fix it back to the way it was.

How about this:

https://github.com/jgunthorpe/linux/commits/intel_no_snoop

b11c19a4b34c2a iommu: Move the Intel no-snoop control off of IOMMU_CACHE
5263947f9d5f36 vfio: Require that device support DMA cache coherence
eab4b381c64a30 iommu: Restore IOMMU_CAP_CACHE_COHERENCY to its original meaning
2752e12bed48f6 iommu: Replace uses of IOMMU_CAP_CACHE_COHERENCY with dev_is_dma_coherent()

If you like it could you take it from here?

Thanks,
Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
