Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29805C433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 23:43:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE83461269
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 23:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BE83461269
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 83F4D4234D;
	Wed, 29 Sep 2021 23:43:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vOwLk-HGF3El; Wed, 29 Sep 2021 23:43:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5A818422B6;
	Wed, 29 Sep 2021 23:43:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E80CC0011;
	Wed, 29 Sep 2021 23:43:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07FD3C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 23:43:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 007984234D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 23:43:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WKh-z8hok3q5 for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 23:43:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 41282422B6
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 23:43:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWkaN6d21O0/L/nd8QtTZ9H4EbRUc5eCCxm0TWtdmAo2TWt/rTiUTFFcqM6ljTLUwwQfY3to1QsVhivzlfiXuEq5idwZcl3CNWLSzXlGJZjjBHYMM5PS4oDgqEme95wm9/R+582ZSV9RKeTTrXIjLAi7NmUvM0snlEtDsXfBabLnUtfQF4QwSY5fag04U5N3jJndyX2SauWKsi5X3uCe5FGbCCncdtySctWodMegOPF7jmMQhHY7HIdMgeR2yMjVegLjmMtc1Cw7LATwt/N/FGFBprUtc2kmt2MERMOoi+N+y+aRHfHO2XaGX1uOJgZvpQsbJsXxQ2fmOqgYfwvGVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=kgjGCU56B0+8WS67PLC5VKE+pR92w1LToo/nSdQqknM=;
 b=dXAkNyYcAF8OgwRlfzuJO4uDvEqlI8DJUZhHf//Fl2JKCKI4nIliojHt8aJS3W7i/nLwkggabzzTvtKl/b0khCwcLz6tjVs6VVQ8Uc6ygkVdCKY0nTnKc8uyV/mZLPtE3Kob7zPQFjwYBISPWCpyisFHpptpeogJe7F6w5xXXkZk/WVXiriM/utnw5JyZXnB8XRoGgdkwP4WjFbuLYMV+ru66SZ2vn3sOawrpMrIPWHTFAxe3W4/HFaQYkiHSfPKRQ44WU/gFwUJURy6RE++HIdgwWpzuvGeXw2bKKmz791Ho0MT6s9hHmuKnNQe6rAaKYphP9puLF2Dfz11VHHXmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgjGCU56B0+8WS67PLC5VKE+pR92w1LToo/nSdQqknM=;
 b=PbRb0z3W/VYJgqSdi1fd+6FEuR5+ZvQ0VE1pIaMYrUuY5czqveTgEZw175dXGSe3+V/2nT2I/JtjWkSVJLVNb6voTWa8osoHoKY2054qVWU7mDXEUZH8oihGcu5U9WO3DQ6LgnkTqKJGfDLCZwXwxt0kEJL5P+5MJcqR0L1TXnZipNf+Gbn+I0XwW4wc+7ZDrgTumoFbBHdLjM5UhmjK5Fc+MqhkKKC1GtSihI2gaWKFeRmC9eLLbY9q5iPCggpXbOiQDphAdFPCog+RKAOvqPfCEfDot0rXNm3JUvDI+gmW4166TkjSyCfGKTpbfKbwDm+v10CLUGJyakqoeop9Mw==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=nvidia.com; 
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5304.namprd12.prod.outlook.com (2603:10b6:208:314::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 29 Sep
 2021 23:43:03 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4566.015; Wed, 29 Sep 2021
 23:43:02 +0000
Date: Wed, 29 Sep 2021 20:43:01 -0300
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [RFC 0/7] Support in-kernel DMA with PASID and SVA
Message-ID: <20210929234301.GC964074@nvidia.com>
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210929123437.721991dc@jacob-builder>
 <20210929193953.GX964074@nvidia.com>
 <20210929155720.794b6e65@jacob-builder>
Content-Disposition: inline
In-Reply-To: <20210929155720.794b6e65@jacob-builder>
X-ClientProxiedBy: MN2PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:208:23a::28) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 MN2PR03CA0023.namprd03.prod.outlook.com (2603:10b6:208:23a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Wed, 29 Sep 2021 23:43:02 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mVjE5-007j3v-OK; Wed, 29 Sep 2021 20:43:01 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfe212be-0a15-4344-8462-08d983a2e099
X-MS-TrafficTypeDiagnostic: BL1PR12MB5304:
X-Microsoft-Antispam-PRVS: <BL1PR12MB530404D74951DB5CDDD81DC5C2A99@BL1PR12MB5304.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q6Y6H6k95kROPh42f8XXqk/OEWbSdaVPyr2XB5/r39NjzzMouh2ca50zEKd6LMp9KIsU/bhFcNAhlzQOqfyP7Ch7fDwkI1qFFE6sgOx+MfS92zgA049acnPUXLPajr761UmzdUVAA1ci/lNpfz58s767NKYR+eq8U40KlNWGKDy9ukIIS9dclOupA6rntnP4wbQVLSOGGXgMeCsRISYR4DP5dK1CzPuQ/+sJwIJxc4qc/vVdK/Npi4NCcTklXXfQG/Ch2Xe4enuqnm9c86BcIM4TY5K3NDFjNsFasYBHyym+KM1r/ld7qIQrN8wM8Did21nCxlX4ozAS+VZljXz9QsGPhFO2DsM/LgJSCqyplb+4aeIkGqo0RrS2fUwFCsACe6SI/zkl9f5MuWjq3okFJpxTSz0539kYUg+Wm5eRpYSDLJNnS5+0UUzEsxU2ZFVR7LzpaxN0XpmIapWVYvSHXQzeUsnDXcxD2w+bzhCx3/3vG6a4EZi7Hsbipbly71h1hE1Sy0WlJVyTkkLzgQ3ngULTIZSXJYjAC/DwTQ0Txs0VSbi77jEk6NLRX0IIyHCyJkbvbYIFvDxRUxR13AufQE2YSmXXv2eGTl+zG9OlUzVtKUhXCTbxfHpqxBtaOI5ZO7yHRFb5wm4Ps5EDTo6tfblk7Uhdkl5MWK34aqOHef4Ch71doibDYhWcp8Z5krE3o8tkTpF2U3jnWw19yumn1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(426003)(2616005)(38100700002)(4326008)(9786002)(33656002)(6916009)(9746002)(83380400001)(316002)(26005)(508600001)(1076003)(66476007)(66946007)(2906002)(54906003)(7416002)(8936002)(8676002)(5660300002)(66556008)(86362001)(186003)(36756003)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WbygjqyeN/b4bPWrzZ/srA3HONc6MS9432jIGYCYfOIzkM8uzRJ87CCCiUJF?=
 =?us-ascii?Q?yiN0PyZDS7SimkS9uettSNgwp5N3KVnvuZ5qmofDXqMKZj0hlZR15GmIaRtp?=
 =?us-ascii?Q?nY7XXGt83f7oZk5CD3wZO9eie5G6PHAmb6VaY4WGs4/zO1M5Y+pXRaEb18UA?=
 =?us-ascii?Q?3WZec+IoNCmCfOfW+rx2RpZw6ZKk6XBb3wN3NeEUKEslYjz1ukQ19jI70RtY?=
 =?us-ascii?Q?FOq+RjlPfJFGY8QEX589/xsTXZjED9WFBOqu/5STqJprqmjuCtA28bKsdcqj?=
 =?us-ascii?Q?OsGKkkMaDPjwqx3TajJsxBHbH/rpsSNIA8dI1W+TmH4v1gepVVBWdjpwHbpB?=
 =?us-ascii?Q?pK0gIT8cdOqG6YC+miwmtJmCx5wufyqa4C4UTy/A30rZwssGDhj8FF1MXLM3?=
 =?us-ascii?Q?AYUORku4xP64H7X+VYadcD0Rsn6ZOslAUZoe7fFQrUSfsmjmeBKVfs4eUgOC?=
 =?us-ascii?Q?nvxcuitCtp57ORlUUXoe4d2aynI9ybfrxrqDNyHFzUzfLWjm6vOLCVfM+4p3?=
 =?us-ascii?Q?+93+TEfqXiwysC5CDO8z+6q7seieXT4Rv4HGI0IKHra0tDTMl36gV4nKZwgn?=
 =?us-ascii?Q?FT5jNsYtoM6GEPWesh0K57PdRb8LyAZLYt3ksl/PpkjmI854xz9E3eLzGtyd?=
 =?us-ascii?Q?iKc74dOQAlFE2DQTCaDJ6pwWJFoq2fnLwCW9CDyByWxwhWfQkHVQ76jM81Is?=
 =?us-ascii?Q?PcHf2Ir4vjdpDvbMDOgOiI7+9ciOC5yNOiOj8v5eilEK3PhCqUov1/lGBQuv?=
 =?us-ascii?Q?PwKhmkqEvQ2j8+preXRa/9gnm2wNU5DX6qMDkYY1+8tc4wAUHcOoL2rph2+4?=
 =?us-ascii?Q?KpbUpvaasN1a2J0yYAXhDh6It1NLmosRlg0lxTF75vNI/HzMc5nkGef5YZ/B?=
 =?us-ascii?Q?hk0alyU8aHVSc+rFzE68i1oRzJhzHtv3BcqbxO+IjS/YVfconFBF35qMjDBg?=
 =?us-ascii?Q?LjMJop3wfnNuG/4XxHLrNGIlf0/6Dp5nbGsj/V8s290nTzApGBSAuAmrR236?=
 =?us-ascii?Q?6o14vbRpDJxAKt0plg7G7J5tm5z1Eq2H9XrvCKd4+XZ1Eg5BAGDqGaOcIEBT?=
 =?us-ascii?Q?Ux6MlJptbkQlQYph8G33fT6a/qiCT7U0IG8blFF+iMuzRIUUnwaLSJYJFnlt?=
 =?us-ascii?Q?zJzU4jLEdkRAuS2grzCOS5dFmO+2f1pOvShwCyx++N7HNjoCvQDCUiVww96w?=
 =?us-ascii?Q?Rzq1K79wmOuJgsBS5QQmT58oEfjAqAgtYV+4nHmMJwEmc6l0D8V72kRk94he?=
 =?us-ascii?Q?wJbFcX96CmvNEOKM/V67Pw7qqBFqR8y1Y0ujx4vk25Y3gwabKanQjIGcNuUZ?=
 =?us-ascii?Q?wIodKlQ0Fht0wqL07y3y3INW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe212be-0a15-4344-8462-08d983a2e099
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 23:43:02.6520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRQzZ9hEpEGcUDM8WYzHSBsZpNCk2WgArOtM1osS+CX+IA9ZqlUpEoA85O9EXPDG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5304
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 mike.campin@intel.com, Thomas Gleixner <tglx@linutronix.de>
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

On Wed, Sep 29, 2021 at 03:57:20PM -0700, Jacob Pan wrote:
> Hi Jason,
> 
> On Wed, 29 Sep 2021 16:39:53 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Wed, Sep 29, 2021 at 12:37:19PM -0700, Jacob Pan wrote:
> >  
> > > For #2, it seems we can store the kernel PASID in struct device. This
> > > will preserve the DMA API interface while making it PASID capable.
> > > Essentially, each PASID capable device would have two special global
> > > PASIDs: 
> > > 	- PASID 0 for DMA request w/o PASID, aka RID2PASID
> > > 	- PASID 1 (randomly selected) for in-kernel DMA request w/
> > > PASID  
> > 
> > This seems reasonable, I had the same thought. Basically just have the
> > driver issue some trivial call:
> >   pci_enable_pasid_dma(pdev, &pasid)
> That would work, but I guess it needs to be an iommu_ call instead of pci_?

Which ever makes sense..  The API should take in a struct pci_device
and return a PCI PASID - at least as a wrapper around a more generic
immu api.

> I think your suggestion is more precise, in case the driver does not want
> to do DMA w/ PASID, we can do less IOTLB flush (PASID 0 only).

Since it is odd, and it may create overhead, I would do it only when
asked to do it

> > Having multiple RID's pointing at the same IO page table is something
> > we expect iommufd to require so the whole thing should ideally fall
> > out naturally.

> That would be the equivalent of attaching multiple devices to the same
> IOMMU domain. right?

Effectively..

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
