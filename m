Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4865C433F5
	for <iommu@archiver.kernel.org>; Mon,  9 May 2022 17:27:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 506FD813A6;
	Mon,  9 May 2022 17:27:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yYLUygA13ER9; Mon,  9 May 2022 17:27:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1AE72813A3;
	Mon,  9 May 2022 17:27:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5232C0032;
	Mon,  9 May 2022 17:27:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8191FC002D
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 17:27:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6FC3A60596
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 17:27:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TA9k83WqxB4h for <iommu@lists.linux-foundation.org>;
 Mon,  9 May 2022 17:27:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::623])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1915760595
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 17:27:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCgQK5gDFki6f/C/rD9+vE7bFQMeyiFBGDYoYAB0jRnXdLzkYzh+yqkucWHlZ6HUH7h9u5ayIJpVPVQ3wBgPzu3P8YhGiq3Z5SE4cBQW6/Zko/U97X5AV3StlJXcEgTz1W+lUsIVB/YEEZVCBtY1R3Pki71HjUPTvcY1gj6DVgdQVviEJhbRgJq4p8qv+NGypgGHaCYS/EvQj6/PC1fHcXuEUpkwYWpxK5RDY2fMkg65QJiwT1el5LzIqOkUf5KISFRnqy8P16zY2bf8/BK+Y4ohNMF9Y22wLlALxlRHSLbHRVI+dHQVvknco+SFZVtDQfodJxeYWuQqgRpFA7yEpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdpM7f7SMjM2fYFztpIkmucMKo/353zL0s+78cALG1w=;
 b=YRfAGobuxTCA4+XoabYJf2faXE26j4vmrnucZCKl0aTMDh4sKyzAND+nS6dFALNdE8oBokGrXMgySHfFFaCix3gPi776gz0gmNP6a82m2bb/zm/zBg0VEP0Ule1qmp3tEvW42wLZxnzAZpMGQnlDH86ZYFkaVo2C5fsg3ANjpNT0l9Ym7WBtwdWN3eeLjXUhGUmqvxTlSmiyINTwtsSngPIkafKHYxdRoaN2uRfi5fVLkFNibktRYRcxlDiCXG0ka//S+jk4MqWsgUdwfqIb+Buij/z3JquEOrNXHEs5xd7+KRSrCMGJkQerxd7YfoXcEaewyy+QZKjooC7kx0IC4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdpM7f7SMjM2fYFztpIkmucMKo/353zL0s+78cALG1w=;
 b=pGnumUN5fpaTPFXjexHt4upACg9gyROEo2rk1VRbh3/hXPHF1RRBVEROJwG5s/ylXnuRdI5QMm7spUj7XW67GWhHhuz45x3E6RGXuLVZ1CcvqoAct5zyNuaGcZkslxl09gY/hf6og1kcHt8qSwqcYt5gJ0QcYVIDfBfn4tFwc8tMPTh9Y5FS5uF7Xnzy46qxwQqkOVnBlM52N4xWISbDHdCzyxxmiMHptQ+vgzrzS1jaHy57o3/YJhLMfdjxJ6O9eC8A7cZ3YQ0tkaBByj91h5n3NCrqs60fhPhigsje/8GyVlVaKh5/LIuPRw+AcueOfTKxjNGkVJbM3dH5bAixHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL1PR12MB5062.namprd12.prod.outlook.com (2603:10b6:208:313::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 17:26:56 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 17:26:56 +0000
Date: Mon, 9 May 2022 14:26:54 -0300
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2] iommu: iommu_group_claim_dma_owner() must always
 assign a domain
Message-ID: <20220509172654.GP49344@nvidia.com>
References: <0-v2-f62259511ac0+6-iommu_dma_block_jgg@nvidia.com>
 <BN9PR11MB5276504B448C715527AD5F3F8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220505153320.GS49344@nvidia.com>
 <BN9PR11MB5276476BB203D8D61CA8849C8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <9f6680ed-77b6-8440-078c-623406c823aa@arm.com>
 <20220506131053.GA522325@nvidia.com>
 <27088ae5-05d6-122a-d9de-80e10eecac38@arm.com>
 <20220506135431.GC49344@nvidia.com>
 <0f838b34-460c-ed83-7b98-6cda444b10c2@arm.com>
Content-Disposition: inline
In-Reply-To: <0f838b34-460c-ed83-7b98-6cda444b10c2@arm.com>
X-ClientProxiedBy: BYAPR05CA0065.namprd05.prod.outlook.com
 (2603:10b6:a03:74::42) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51cf5698-bd49-445a-cea5-08da31e11df4
X-MS-TrafficTypeDiagnostic: BL1PR12MB5062:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB506276BEF03B2D1390AC5F43C2C69@BL1PR12MB5062.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: osbDs5TtDlQlURCLgXsVrQ0vf+KgUPZgMzJyjacwEDGNH8+MbX++BFwVAf2SRAfUhQTAm7xhp3EBS/0rNWUAjVMqi6W0wLT2uIznfOGU4jk0RcuqdM2nfc4nQYjTZYHs8QCqOne16ocqRMEgO7lkaI+BcQ6wO7KHCZteb3d9xuP0DPWiXFro0ZZK7nykSrEDHU5AbrTu26Ou0cTxIYbvCWIBKCiis/T1xV9LNbeU6YwaYNdPfp+F9JaIX7YvyqvZds2zGdRrPVOETfxYjkXTzkwlnMbrDo+A9esYjJ198dMCShKckf1Zt8ZB8i6gwCMsgDP6wcmLzW6bxceSd6Dx3YbsJCvZhlxI+T8i8Kxcoj9jAE3Ozehf8JumvAq8jImQvSeh/jKfUdpaOm1RXPFb8dM+8mXWD8icpm3BSTXv1mjXNj79BvjTMU2j4OUSBOL2V+QFAw/oStKzkhpU5wekkIPolPXT1xKVoeCRyouSXc175hCDhJczGLuHkI2S0t1KRH7yk5A/s9FcMjkQtK9rgzwPFkUwjOY0ziNZ3lATrbBhrgJSXAjlIYyF+Zi1xYAyMUVbPF1FadGy8gdseOesYonkwg7ueG3o8TTlVeez5nnQrqvcFGEVAKDdRU00WSlgChuB2hPdqWM7G0X/v5L8kA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(6506007)(6486002)(8936002)(2616005)(6916009)(54906003)(83380400001)(316002)(1076003)(36756003)(186003)(66556008)(8676002)(4326008)(5660300002)(66946007)(2906002)(66476007)(6512007)(86362001)(508600001)(33656002)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?St4ZabE7YvFOV3F1Nz6+M2UqL7A0sc1zEiz+vvIdoHzZco4aKbQrgk6dfwDo?=
 =?us-ascii?Q?o+418tVIzwQLmRNJKrm6yZWy+iurkB46qM1NWws8VQ0X+WqjZ0NZoVq4gg/u?=
 =?us-ascii?Q?Z9LAo8lsCi1mCJAFE8BzM/v9uQV4be1TU6tVgUljHre8vV6YkLlIBx89XyC6?=
 =?us-ascii?Q?YQfgQO0Tyf3e9vZo2+2Ao98J35sBO3Xof9SkBDTQDKfUsNbA12VK1ORD+xQS?=
 =?us-ascii?Q?ZEd76nFUDFFzCwOXCWsFC3rvPDYXRPPEHKY+8rxlbh5uWmZeOXsXTRJ90PFb?=
 =?us-ascii?Q?Z+gBFL3nTw5Bv92zqsZfTXUQL+0sG4wLgqlauwBVX6UQymk4cr38b0yJu/PQ?=
 =?us-ascii?Q?UcxWANHtnrWlQlzICemKgiwc4zwSlm9SNq73CPASjNHJojuTtYPi5IWWIQ2p?=
 =?us-ascii?Q?xhWu2kGtcEK4nFmVO85kAe/nD9Vm6M1QFauzoJEFbCOIoHdod6HW1pozATz8?=
 =?us-ascii?Q?Al/TlEmdLMuppPvtmIbKyb6MVumOlTpMkojqkP7TKONQLT8kkkgpn5Fdth5q?=
 =?us-ascii?Q?19UaWW0EfEtvVWft2yk7bDyXnxRDBiBf/yf5gWfuJiRcgYADLZznWjcevGMA?=
 =?us-ascii?Q?gdBZIm+780ni43x97bU3aT9VP3sXTIJBLY5+XRYoIFHUr9b6XJTA2bQgoRnC?=
 =?us-ascii?Q?jAM8n2o65oP6kxx00lZHUC/gBc5QFvTfDJ4x9KFNpfgLo9NNvnPtBKKJQqf8?=
 =?us-ascii?Q?NL4kxm8SH54lQfDtIDa3YYt3OpwpSpn8o0S+2gA/YeuBw3FjPcdhCpYRrkHq?=
 =?us-ascii?Q?XpLKaG7T5Qyv4TqJ7Dm3bKZkLfUIAHeLZBeOQbuZpEY7EeInHWwuMVgnwGzt?=
 =?us-ascii?Q?GJJJIAcXsHeIGWkYs23vTLCK+Od9baBi0dhjKhRbcKQkoDJKlfQQ4ksUwR8v?=
 =?us-ascii?Q?QwnRJDytrOj7qDSaXT3tz6LP1zPoU7dILp9UY8oujS538tJrBpRn0ydzQ2B/?=
 =?us-ascii?Q?dBW+TmGZID5Wr9CkOlSzR4zLb5J5+TnEBqCX/AGDGIEpJkNz3nJCdjD3rwA4?=
 =?us-ascii?Q?qCxS/HR45XgOAAuCg4eSM46keZuyx3onskI2HVpIYvv8ksDq7DgEjv7IcE8f?=
 =?us-ascii?Q?tVqveKMkY8uDXjiedeIM32ochqvPnD4RlaqJIrdCzyDg+b9CNoyyFbYUtzfn?=
 =?us-ascii?Q?PDOqWk3wabQNFeGYSedphfiJea+55HprfumjBqxjgpNmcHMS2u72KSdXTYhx?=
 =?us-ascii?Q?7j3fgW3OiqLNTwslh3DABZ++jCAnJH0t2GgcZPo+NPKMiZvkXBE2DmtSYEaV?=
 =?us-ascii?Q?zRkL0nkga8klHoEpyzIqwYcKW9RENiLvoefACI9n25PJHoKp8EY1Hf6OVQpE?=
 =?us-ascii?Q?mkbfWgU0NUL71LNFaDvEsF0ZyF5jO1EpqiessqIO4ztvvrGa27lRxTJODOFI?=
 =?us-ascii?Q?8sa+dEee2QGYA9WBjt6Mmi9w6z1iSOPCCHX4F3xFOoMRtb2nrIV1Z3cuySHh?=
 =?us-ascii?Q?tC52Vp6zqs2QsIW/82SmRC7/m+Jq9IBxgx0jKD3TBuVI1wD4g1NSO/O2U9Q9?=
 =?us-ascii?Q?6D1xslKKpGQU1kz2SW8m81gMwvHPh+bQLSyC2URo3tP0c4u9AZlzuQ8dNZL2?=
 =?us-ascii?Q?e3i+ZFndSP84mM0liIEmbENWDPdgBVMMDhGvEY7QakUmgN93or5RDFXbs65i?=
 =?us-ascii?Q?4JWHglZn/1WW0AHtKJr9xcP66GNUglaRU+rWWiZ4apO3P/MKMmekitZuxjYE?=
 =?us-ascii?Q?UPkvu6mCgbXIe8fV2skcIVwdl3F0VSPmWseafl+07PMgwLSSBRF5+2JTgInc?=
 =?us-ascii?Q?Emg+G0xFrg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51cf5698-bd49-445a-cea5-08da31e11df4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 17:26:56.8831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5w+M3yMB6mOPK5JkSeXF/uGPXqOsypwoK3foehrhEhRi5EaIgNKCnez+u8mgKKQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5062
Cc: Will Deacon <will@kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>, "Rodel,
 Jorg" <jroedel@suse.de>, Qian Cai <quic_qiancai@quicinc.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

On Mon, May 09, 2022 at 10:59:11AM +0100, Robin Murphy wrote:

> IOMMU_DOMAIN_DMA_FQ now effectively takes over the original
> semantics of IOMMU_DOMAIN_DMA as the one that depends on
> driver-specific functionality.

If I grasp the FQ stuff right, it seems that this only requires the
driver to implement ops->flush_iotlb_all()? I don't see anything
obvious in any driver that is specifically _FQ related?

If yes, it makes me wonder why I see drivers implementing
ops->flush_iotlb_all() but not supporting the _FQ domain during alloc?

Further, if yes, wouldn't it make sense to just trigger FQ based on
domain->op->flush_iotlb_all being set?

It seems like there is some confusion here, because I see the sysfs
default domain store path just does this:

	/* We can bring up a flush queue without tearing down the domain */
	if (type == IOMMU_DOMAIN_DMA_FQ && prev_dom->type == IOMMU_DOMAIN_DMA) {
		ret = iommu_dma_init_fq(prev_dom);
		if (!ret)
			prev_dom->type = IOMMU_DOMAIN_DMA_FQ;
		goto out;
	}

Which will allow a driver that rejected creating DMA_FQ during alloc
to end up with DMA_FQ anyhow???

> FWIW, mtk-iommu doesn't really have any need to reject
> IOMMU_DOMAIN_UNMANAGED, they just don't have any relevant client drivers
> that want it;

Ok..

> however arm-smmu definitely does need to continue rejecting
> IOMMU_DOMAIN_DMA when it can't rely on the DT code ensuring the
> correct probe ordering with the old DT binding (otherwise client
> drivers are liable to get broken DMA ops).

I saw this code and wondered what it does?

smmu alloc_domain returns NULL, which if I read everything right
causes NULL to become the default_domain.

But then what happens? This driver has no detach_dev so after, say
VFIO does stuff, how do we get back into whatever boot-time state NULL
represents?

Is it OK because dev_iommu_priv_get() in arm_smmu_attach_dev() will
always fail if legacy? If that is the case then why allow allocating
any domain at all?

It feels like this really wants a 'IOMMU_DOMAIN_PLATFORM_DMA_OPS' set
as the default_domain meaning that when that domain is assigned, the
platform's DMA ops are handling the iommu? If I get it right..

Anyhow, thanks, this sort of helps confirm my feeling that the domain
types are a little crufty..

Thanks,
Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
