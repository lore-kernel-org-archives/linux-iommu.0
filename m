Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AC8C43334
	for <iommu@archiver.kernel.org>; Mon,  6 Jun 2022 16:51:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 48E6260A6A;
	Mon,  6 Jun 2022 16:51:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l1GZbWkWCHCB; Mon,  6 Jun 2022 16:51:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6BD7E60760;
	Mon,  6 Jun 2022 16:51:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30FA4C0039;
	Mon,  6 Jun 2022 16:51:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4AF0C002D;
 Mon,  6 Jun 2022 16:51:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8B8A5404CA;
 Mon,  6 Jun 2022 16:51:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j5yu21DYoQYo; Mon,  6 Jun 2022 16:51:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::626])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 780654013A;
 Mon,  6 Jun 2022 16:51:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtCVqcRIucmWe+mEk+B3YnXBnrlz+9qnSrH8iVZTDtvd0VTCn4XBS16Jj4i+CC0Ib0UlDpPUqznN4xqTvgcjiKzrPcf8OW+jf0FDIsOfVU4S3HoXcGN5YxKzZf9oL5wtXA16PPoDdXREussQMUuLV9VGdCiwh2h4Zpn3wJwbgM9s+REx9ZU94EvW8FObem6+yE8gC3GztMWco/qWT+YiupyTgNu8RXlG4JYafewoba58waiRBgA7EzM0C6UyERPOF88tMZWnlKjD3J03AaMNmuP2mKiN8+Rc+o+oHxOZXJ4evkmCQzbgVBsJJPK6/jQvy1WjP3a6d7BVz6xK1yLqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Hdvzb/DdjhHYGSNy9UQ2o7bsQj6hNcDtAAubHjVpQM=;
 b=aIVy/0SEWiKvqh7NZ1beFDMKXxakSWNdsDvrtFm3mVrK6YrY03IphbTFebujbQVZBwhlVa89tNUXeiO22PabjsbT3SUiOHdXUgCjnKDhN+tciKrbQrOLVUatqbcPgXjRRYvwo+7E9fs7WPBZpjljDxv3EzBZvubi6zFmQ+NEWGCo8ZOA6qS2/Z1S5AOj0okZqCKLkojNleS2DNd+r7OpHgESqB0vxRSvjm+XMj7NaWtFWd0PDQ8IXDvzNDoURoBR/Ct63S3/mVb1OhYeBRfhLu4c7DV7Hm1syRqBfMlcFbntraraFL0gahLoO6z0nali78ZYDtFcDIAsB07TEVXBVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=samsung.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Hdvzb/DdjhHYGSNy9UQ2o7bsQj6hNcDtAAubHjVpQM=;
 b=JqjHf+zW8Wx5v048GenopBuqJQY0XhFW5XtPUZlM2SQqZzd695+e+afR9Vp7DWp/ltsIfHwivK1FwvejtYEE7ayW0uhcTInnzXIu1l+3j0BwMEdKvIO4zXnFJz5oR0AlSSVFWp7s4wMNGJrYpGZ7cOkxLDZbqLFzZAIZRb9kIhBIkrv961StBfkDrDZQ9mXACBwpGrssWL4YCqBdCXGwhI0mKtIaKLbadiv5+8BUoMFfegHsDEsf0hYjLHu7EwcoSPmqeupzS++fTr9d7JBJD9yCQT/f1B2OpgL3quodGO9RBlS3Er6RUiqiQbW/0v5rnGNzGUue0+v+DXhitc9xqw==
Received: from DM5PR19CA0059.namprd19.prod.outlook.com (2603:10b6:3:116::21)
 by CH2PR12MB5530.namprd12.prod.outlook.com (2603:10b6:610:35::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Mon, 6 Jun
 2022 16:51:25 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::e1) by DM5PR19CA0059.outlook.office365.com
 (2603:10b6:3:116::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19 via Frontend
 Transport; Mon, 6 Jun 2022 16:51:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5314.12 via Frontend Transport; Mon, 6 Jun 2022 16:51:24 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Mon, 6 Jun 2022 16:51:23 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 6 Jun 2022 09:51:23 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22 via Frontend
 Transport; Mon, 6 Jun 2022 09:51:21 -0700
Date: Mon, 6 Jun 2022 09:51:20 -0700
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/5] iommu: Ensure device has the same iommu_ops as the
 domain
Message-ID: <Yp4wiJZWxoCLY8tm@Asurada-Nvidia>
References: <20220606061927.26049-1-nicolinc@nvidia.com>
 <20220606061927.26049-3-nicolinc@nvidia.com>
 <1e0e5403-1e65-db9a-c8e7-34e316bfda8e@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1e0e5403-1e65-db9a-c8e7-34e316bfda8e@arm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a451f386-62ff-4630-c883-08da47dccab5
X-MS-TrafficTypeDiagnostic: CH2PR12MB5530:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB5530383D1535572BE22B389BABA29@CH2PR12MB5530.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pZiq+ND8CO2amXmNIxVaMtKaraIW4f8vTJiY9NgKkJZULPQnAn0NN9dDhRfW4kJ7TbWHwmqIS1l8JpoBweBdDwTxB4OmTkH31biKB1MsIsCGDS1+df29XGZSdNh9kFTIZulZJkONV88r3aUljC6cKCgXN+dWEp2n6cZQuYOQGzqJjMrLEdZe6x8i1d3BaU+pqMWdgRdvfAlJ0CF3lXU+ZoNH37t+N6Ih+7G617MvEwTU7DQijmGcuJSVC7HC4IA8skZgfk9NCut7ZA1JqChuITMXcKHw0sncB1dOOz3rwdGYulhmqAY/CCEoRxsgjDJppllnOEtc0Aj0GRvlbyz+PFisVwJGiw7YJ2cJLUN3qJDXQrqPtlQzC5hkIYjl+CNRrzwt0EMrzqrBBcrbitaT4YErGYYj9lVfcVL34LHkgA2VIwoWyKy+z6l0W//UjdUWCpPBsWfGO2DdeuEVtvZkCFvyTzyNbE1tre3z2Ot0MlqFsO8MuLeQWdsoLtZSL3cVTyJ1kYQUkX/Lj6mk82MaV5Gqp4l2A0CfeopHBKHsknX/F4uuK18v6KaJlqVNTq/pfxx5qRGx7Tw0SVYDEw4ig/Sq9Er0kOBb3rJTLro4bxcTD4WHZq2a8XTazHVCPws847GwkiNJ3MTCUUFZqrR4ZRmOyo0+ChwLcq38gQ5tpaKbSg9SvzNvnq+n6/YkcCRM0aKY2uJaDBHFvQvnVWCatQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(356005)(26005)(55016003)(2906002)(6916009)(40460700003)(81166007)(426003)(47076005)(9686003)(54906003)(53546011)(316002)(86362001)(36860700001)(83380400001)(336012)(7406005)(8676002)(4326008)(7416002)(33716001)(70586007)(70206006)(5660300002)(186003)(508600001)(82310400005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 16:51:24.4541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a451f386-62ff-4630-c883-08da47dccab5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.238];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5530
Cc: cohuck@redhat.com, heiko@sntech.de, linux-tegra@vger.kernel.org,
 thierry.reding@gmail.com, alim.akhtar@samsung.com, will@kernel.org,
 alyssa@rosenzweig.io, jean-philippe@linaro.org,
 linux-samsung-soc@vger.kernel.org, kvm@vger.kernel.org, samuel@sholland.org,
 zhang.lyra@gmail.com, jernej.skrabec@gmail.com, jonathanh@nvidia.com,
 linux-rockchip@lists.infradead.org, wens@csie.org, agross@kernel.org,
 linux-arm-kernel@lists.infradead.org, jgg@nvidia.com, orsonzhai@gmail.com,
 gerald.schaefer@linux.ibm.com, linux-sunxi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, alex.williamson@redhat.com,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com, virtualization@lists.linux-foundation.org,
 linux-s390@vger.kernel.org, marcan@marcan.st, linux-kernel@vger.kernel.org,
 krzysztof.kozlowski@linaro.org, baolin.wang7@gmail.com, dwmw2@infradead.org
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
From: Nicolin Chen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Robin,

On Mon, Jun 06, 2022 at 03:33:42PM +0100, Robin Murphy wrote:
> On 2022-06-06 07:19, Nicolin Chen wrote:
> > The core code should not call an iommu driver op with a struct device
> > parameter unless it knows that the dev_iommu_priv_get() for that struct
> > device was setup by the same driver. Otherwise in a mixed driver system
> > the iommu_priv could be casted to the wrong type.
> 
> We don't have mixed-driver systems, and there are plenty more
> significant problems than this one to solve before we can (but thanks
> for pointing it out - I hadn't got as far as auditing the public
> interfaces yet). Once domains are allocated via a particular device's
> IOMMU instance in the first place, there will be ample opportunity for
> the core to stash suitable identifying information in the domain for
> itself. TBH even the current code could do it without needing the
> weirdly invasive changes here.

Do you have an alternative and less invasive solution in mind?

> > Store the iommu_ops pointer in the iommu_domain and use it as a check to
> > validate that the struct device is correct before invoking any domain op
> > that accepts a struct device.
> 
> In fact this even describes exactly that - "Store the iommu_ops pointer
> in the iommu_domain", vs. the "Store the iommu_ops pointer in the
> iommu_domain_ops" which the patch is actually doing :/

Will fix that.

> [...]
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 19cf28d40ebe..8a1f437a51f2 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1963,6 +1963,10 @@ static int __iommu_attach_device(struct iommu_domain *domain,
> >   {
> >       int ret;
> > 
> > +     /* Ensure the device was probe'd onto the same driver as the domain */
> > +     if (dev->bus->iommu_ops != domain->ops->iommu_ops)
> 
> Nope, dev_iommu_ops(dev) please. Furthermore I think the logical place
> to put this is in iommu_group_do_attach_device(), since that's the
> gateway for the public interfaces - we shouldn't need to second-guess
> ourselves for internal default-domain-related calls.

Will move to iommu_group_do_attach_device and change to dev_iommu_ops.

Thanks!
Nic
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
