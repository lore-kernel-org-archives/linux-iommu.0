Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65351C433F5
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 12:36:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03712613D1
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 12:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 03712613D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C5D33403E0;
	Wed, 29 Sep 2021 12:36:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pBgVsEPS2TMB; Wed, 29 Sep 2021 12:36:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7EF3140012;
	Wed, 29 Sep 2021 12:36:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62285C000F;
	Wed, 29 Sep 2021 12:36:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1D94C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 12:36:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BC16760BC6
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 12:36:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8xnhpcz1S4za for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 12:36:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 99D0060BBB
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 12:36:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1cWYwXyLYitO594W/B7Is1W1TCWMSuAt+qBSaKrqmVId/LnnNDzeTZs4UAMDqxqNF866XMUM7wExDFOcCH0EuHzmMQ9CieE2qebSAf9+bctSo8xCD6/5lCD+2dXh1eDwUfJnDrHlV/FN2J0R8j3oNk/TxSambpp1/HRh0Reo7xvNoFPNPo58kx5x+lmiGdgmi8H3kpM9XXgQRNMzuxDwl3xyJRV0PMkHsQOvI0s9ngyADmJRRBiN8CUvWGQ6jZYPOs9ulwIzd1Dq/P7cNEx3ICDdVVRY6fvhh3H8avwWgoRNaOUflENpvXyMlSx6z7isSX4vipewncWrZ1834NurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=JN6Tk5td2lELhMxpIl3HP+nlNCorx3rXpx4DDhaujmE=;
 b=hDfDPMiNYxKiahfv77WCIEUKxeTfLJyMMk2uvGI0kAbLn7MQ5vj44Fck3+bIm+GP+sZyvJ5vRB5Lx/fT1RWJsupsG4yttjg+c+iXAQ4IdwiILgnz5MOb0tk/XJCwAzU+XrhOKlZjbeK2S5pztfPccBF+LzVb102Fx2IbH7SI1n2bMI3QgRO1mYRrgbNMig7AylojfaB/BRNLRldBwT3oUIEX3vLmFPsJIfwtsQVTgxU9RGkkV0BCBwLYjn+9ujpaad4rMzPeltU8ajNRzuzZYcDchCGEm8XhenXCtzK+QAY2LXpEwYkcgBK9fF07rvWHFbyKzj6Wx6FB7vyEA03Bbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JN6Tk5td2lELhMxpIl3HP+nlNCorx3rXpx4DDhaujmE=;
 b=qEklV87csCBpa8K6uDTXV4exiPPHglQQv/wQI0FuOIDCAwt1VDwmDlwLOX9MDqff3PauKbWEGscwLtoEKJdLEahUbetWQBeQSQwQQFCLgDARuLqsyuKSRRINPh3fVEcy6HSc9ECEY0O6HUKm6/Rzl62KX0U7TtpKi+AawioNJQq6UUF79NhGHFeNQX78dsEz3DFp+j6aXBDIwtkv4UK4KeQ8wsnXJvS1LnS457YnDzDgScHw86uG3p5PLn+7zi7G++qnL6tMkq7UKyoymR6jTa138aeg1XqEE+R27hHcY6KSZ3nW0c1Ecxfg0Ke8rblF8ML3pb63I2AOwi4BKr4Z1Q==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5361.namprd12.prod.outlook.com (2603:10b6:208:31f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 29 Sep
 2021 12:36:33 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4566.015; Wed, 29 Sep 2021
 12:36:33 +0000
Date: Wed, 29 Sep 2021 09:36:30 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC 10/20] iommu/iommufd: Add IOMMU_DEVICE_GET_INFO
Message-ID: <20210929123630.GS964074@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-11-yi.l.liu@intel.com>
 <20210922152407.1bfa6ff7.alex.williamson@redhat.com>
 <20210922234954.GB964074@nvidia.com>
 <BN9PR11MB543333AD3C81312115686AAA8CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YUxTvCt1mYDntO8z@myrica> <20210923112716.GE964074@nvidia.com>
 <BN9PR11MB5433BCFCF3B0CB657E9BFE898CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210923122220.GL964074@nvidia.com>
 <BN9PR11MB5433D75C09C6FDA01C2B7CF48CA99@BN9PR11MB5433.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5433D75C09C6FDA01C2B7CF48CA99@BN9PR11MB5433.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR02CA0083.namprd02.prod.outlook.com
 (2603:10b6:208:51::24) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 BL0PR02CA0083.namprd02.prod.outlook.com (2603:10b6:208:51::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 12:36:33 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mVYp4-007Yrq-F1; Wed, 29 Sep 2021 09:36:30 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99713c66-2496-4e2d-b383-08d98345c519
X-MS-TrafficTypeDiagnostic: BL1PR12MB5361:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB53615FC9BA46B7BD1850DA8EC2A99@BL1PR12MB5361.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KWRZpLvQD3aTySOGTBoluUrrdoZIaE+3uxtpy/CW9n0qvQ1th4GDEcAQRc5H1lU3GPUVVyrDaN1D8SK1zXQ85UuoyrrYYU5Bn2SJ+rH4/r7VFscxsCaaF+r2nqixA6Lg3TnwR83B30YGrcJryDnUQu3rwVsqVUM1p3oqCcpx9GZ1mRlPmUttAi/1/7/P8/61Jn9OQo8fyNLIIgNjZwd/ouHJBAkm84zyDsIpNKRxRUcpnbzSF+iBKlyY2Qz0FA4dlQaOn1oYlA8+Z2JupPNZWhtOG4NdPRouuDKkTVcmtiva019Olt0V578sv9dB7eoR4laXvLdxj2Uf7bSexdVugIcIvcFfUcSb/BJi7ZSURGTQ3ZzQngSyVl0vFnMUeQ8NV7ZaJubP67n+UyZnaVstlxhtreydWZqy/G/R3EoVyFMq6sitSP2iQoq1BRS8a65RS6e5ZAbUBrvV7ElHu5ufzHNdDwjaVV0HQFsOyQhYpCYQFFvBZ77JNfKMqrNYUX2psP0yrVkQddperWqtIHkZU7UvmX2Q7chBxbqRPMwoYsxzLZb87+9alyfgn0ZmBxjgWsx6TI8N0OVuj0X5wc9XZ1Ap7IdCCx7Sf3Ph5TakmSMX8J+PcyVYjrj5DrrujdEaNI/h3Z6dZq6xaJmhndRHnMMAXhw8tNaYaCsrj7jj+qPZEJBtlbzQpKZlVDFtTLrXWkLDB/O7E6syDrOw1DVd3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(5660300002)(508600001)(316002)(38100700002)(36756003)(66946007)(1076003)(86362001)(54906003)(6916009)(107886003)(186003)(7416002)(4326008)(426003)(66556008)(66476007)(83380400001)(8676002)(8936002)(9746002)(9786002)(2616005)(2906002)(33656002)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1ltVQi/7HrfGlpt9iohhNY7Lj2mktRs/xuz08e9CK6+WcxQfY8LKUyAr/sZM?=
 =?us-ascii?Q?TJG79U3ybOWxkBSAtO2EclK71WrQtYwovmE4SvhelsQv4cKrBCVgXC9uEQxj?=
 =?us-ascii?Q?dyXpUGjqEl81rKGhzVfLgCzLzJZ3lANzEwY1cuJ1BTEFGOI7nbdZ4562vsOG?=
 =?us-ascii?Q?CetsBbpMrFWKPmNa3YrDMqfQ9R2sWvHRR1lO/FYDAuUhAjpjf6lWixy0rfnL?=
 =?us-ascii?Q?A5aCDoVH11mnEwwFhJkMq9eiaLBEcfN3UUSHGEiTzsJBKkuAmZE0oWTNCKdX?=
 =?us-ascii?Q?Als+j2Jm15dFnGa8tMvQFj2i+sSjdqfA5Nlt124oeHa3iK0jje8cDgvaxrvk?=
 =?us-ascii?Q?zioP6cNJjP3pyKr4aVTz7sOJfz7ncuM8Z9r8rTpd2bQP0QrVPYOI9zBqZirS?=
 =?us-ascii?Q?xufioGmxw54NaH4UA2suk+oP5qfEA9x0Gki3p136WDBs1E9sUC05Vau4TOoF?=
 =?us-ascii?Q?LPpG2zzOyHoWt5BNA3v5BhavWCCcYgQhTtkYs0T4eeOE9mQDF6uzMKAuFznf?=
 =?us-ascii?Q?HVfa2P88oBO5Zyl/FDTK/xLq71nDmHY8QRxG5aZ9WG6aYwxXfk7w2hl3s8mB?=
 =?us-ascii?Q?cGi1nOPgLGHYMatKg3FdW2ueN2VTs0g/y0kFvL07av8uIbAxmMEQrHqpIFH7?=
 =?us-ascii?Q?Lfnk0rHDy7rsO6ZTG2TvOsHiECFallJpv1qE4oH3GZObEI1LDrsLZkaEc5kL?=
 =?us-ascii?Q?zf2UEzj/rbiJCIJehhZckKYpEDzLQwKizIly94wweR6VWvfitqO+qk8FyC4s?=
 =?us-ascii?Q?OK5cXdOEJykXkeWFHkq+WNC5qVkHqyFCiX3wPo5Mnx5RFwiSqaM8xW7RwThP?=
 =?us-ascii?Q?e+zZ73PMxT2XV8axgZPlhR2viU0/37dCMbHzGfzJMo5EU7khpxCy8ufdCpB+?=
 =?us-ascii?Q?ZGcwIqSPKbp+sBhvwMrEIqyixPUwzt4EPsAX3r4Avdjbr+Szz9ae2qblxgPr?=
 =?us-ascii?Q?0mdq0/8eyquFnFEBPhs5y3YIQsTsvqh2rd6GvQM3lTMc961qbT+dEJR249yf?=
 =?us-ascii?Q?vHNx1kx+vhemg5fyXfC3cDVgGpAajPtphz0uvzstN+MbMa9WIHpPk05fy117?=
 =?us-ascii?Q?9VQc1MAQgBagiSZazsoIE2UMYdq/b4PDsuuJnP/q6BcMgQJMep8eEBaDR0mr?=
 =?us-ascii?Q?cuKWGOhJmmzPm8bG2BSlMDAqsTu5YhEP9AUhDYkLUCEZR5PCUKCVMwljYqMQ?=
 =?us-ascii?Q?pPUM+mA6cIJAzhtgEgnGao/+qca/bKW1qtKMb8OkJFTMWzev04rroPqiQ4zG?=
 =?us-ascii?Q?bKfrFRedpedMBfEZIKGMdGKusZxsW0thhEqyYyBRinAT+huoIB6lxSqeG8FN?=
 =?us-ascii?Q?c9bjqX0ZHESBgGQcSH91cygp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99713c66-2496-4e2d-b383-08d98345c519
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 12:36:33.4534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kqzQuS6ojnJD+XPGcJO6vdmRDBRavTl2DIUYV8AxM8VxUsIllRyaT6wfNi4zf7dR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5361
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

On Wed, Sep 29, 2021 at 08:48:28AM +0000, Tian, Kevin wrote:

> ARM:
>     - set to snoop format if IOMMU_CACHE
>     - set to nonsnoop format if !IOMMU_CACHE
> (in both cases TLP snoop bit is ignored?)

Where do you see this? I couldn't even find this functionality in the
ARM HW manual??
 
What I saw is ARM linking the IOMMU_CACHE to a IO PTE bit that causes
the cache coherence to be disabled, which is not ignoring no snoop.

> I didn't identify the exact commit for above meaning change.
> 
> Robin, could you help share some thoughts here?

It is this:

static int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
		     unsigned long attrs)
{
	int prot = coherent ? IOMMU_CACHE : 0;

Which sets IOMMU_CACHE based on:

static void *iommu_dma_alloc(struct device *dev, size_t size,
		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
{
	bool coherent = dev_is_dma_coherent(dev);
	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs); 

Driving IOMMU_CACHE from dev_is_dma_coherent() has *NOTHING* to do
with no-snoop TLPs and everything to do with the arch cache
maintenance API

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
