Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E1CC433EF
	for <iommu@archiver.kernel.org>; Wed,  8 Jun 2022 17:46:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CDBBB40002;
	Wed,  8 Jun 2022 17:46:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sTW74f8fldXz; Wed,  8 Jun 2022 17:46:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9B7AD4063F;
	Wed,  8 Jun 2022 17:46:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 605E7C0032;
	Wed,  8 Jun 2022 17:46:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58296C002D;
 Wed,  8 Jun 2022 17:46:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 32D4383E25;
 Wed,  8 Jun 2022 17:46:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1yUCQPV0COQp; Wed,  8 Jun 2022 17:46:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DA24E83E2A;
 Wed,  8 Jun 2022 17:46:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHqn5PAP+jbe8Zs5DgorTAGXOCPOVhFXbYoYTJCHxFuoObzdit2lC4O9O1vivWhNiY+zDYZBIVasc/Aho9bjIjD7fDt1GqD+gg+dP/ddBsrnCVCKzIecUdca+WLJy9sebrabWuE5b5WP0NUGqMKynwjr6jsr/KABnoMoQbtgzX2HDJbLLwmnEwD7oc4JrRxQ6vncGo7kkEdM9nk2PNTj3RjuSo1KVDyFC3ckW3XGLlLz6pTm4/N1GuIYVPtlDsymbUm5Q4SmFW671AkPnxOgpKj3LiRQlRFSbsIq49rdxiSNZ1RDW+j4pW4chFq2HCD4qipoEqgXpbp/dP4z/yRSnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFeNMwak6IcWIfXn3ck/l0OoBncuvs3yDZ+On/hvF3w=;
 b=FZN7npI2c4Y6/FzlggObdZDGWKmeW1ze3nbyVSLHjKCRM/TJuUEKFLpjg+dHYHPwdclNK1SczwySFeQ0t5t6caG2h/c+3JFEieaq4HVQpxS+cBkJ4HXYubTTasnc875wk8w3T92nZWXIVgNPwbDwBBJ2j/tYkub3XCj3RdubsFgb/ItmmGkndwvVXLX0rfo+LMa0xToXGYN/NjWpGAMQ+up0Ia5wa2wSOG12uohIwTkZa4NxA6Ia4F1+QCpu/i4hrQ5C8YeEApE6BO1W4t4KWUHwDp/ar0dbs/bUykPAQF1cMB22xvKF/+P7BXR3alD4nUzSghf2wmH6ikDVALsqVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFeNMwak6IcWIfXn3ck/l0OoBncuvs3yDZ+On/hvF3w=;
 b=pj314MFZvyxbk0ZQs3c3QVIyiIVQvNRFWeljCaisw0svE3icciaLryu3SwB0ZrJruRPwCHycdF4wqAtPteGog6x6WVjlLESH6hvPeDrZrnR+RPyF39amcDN+uB9Vh7M8HNgVfpKFtMIPwxZD6OLG39vMVYxzMWC8fr6QDrGq6pHplKhKAzvo+3RQJasA72tXTPMmIYOac4j55a3VSKOkN5kGsFhdpTybvsc45awQKNkhJb+xIkvCjZlgTlBCzAKRScyZvB2f2v72w18BTuucGDIWT74YwdOeMTT88dbwNkPiNdDw6pXiRsR87KEhizzHi+VNUl9o+dBa+9XHhl5/uw==
Received: from BN8PR04CA0048.namprd04.prod.outlook.com (2603:10b6:408:d4::22)
 by BL1PR12MB5109.namprd12.prod.outlook.com (2603:10b6:208:309::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 8 Jun
 2022 17:46:36 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::74) by BN8PR04CA0048.outlook.office365.com
 (2603:10b6:408:d4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12 via Frontend
 Transport; Wed, 8 Jun 2022 17:46:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5332.12 via Frontend Transport; Wed, 8 Jun 2022 17:46:35 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Wed, 8 Jun 2022 17:46:35 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 8 Jun 2022
 10:46:34 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22 via Frontend
 Transport; Wed, 8 Jun 2022 10:46:31 -0700
Date: Wed, 8 Jun 2022 10:46:30 -0700
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH 4/5] vfio/iommu_type1: Clean up update_dirty_scope in
 detach_group()
Message-ID: <YqDgdqVIEwWF1Lku@Asurada-Nvidia>
References: <20220606061927.26049-1-nicolinc@nvidia.com>
 <20220606061927.26049-5-nicolinc@nvidia.com>
 <BN9PR11MB5276FD77A2780C97BB82CBA88CA49@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276FD77A2780C97BB82CBA88CA49@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1587681b-17e6-42e3-05b6-08da4976d555
X-MS-TrafficTypeDiagnostic: BL1PR12MB5109:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5109163184F6942DE7D0E27DABA49@BL1PR12MB5109.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VlWwurAOdfoGgoI16h8tVUGa0DMWObSVow2a+oqBe2GTFnExd/q6V80KUoAhwGlN9yTiFYxYW6jVjBzap0lqYoeVA4tHrBHMrOGcX5zZBeMejX3y7boGTlEAy8viOhvea4Lc5edPDt9f1gM3Yz4yshhtJU834DNuWSaDl8ncPyiQpyTRLuBvHJQBfduDGAfTgNfVbzHCJWrjAXpEGCRPTCGf7mTDAGh5679B46vrSg97YEDPFcMD43BwIItZvesFk4Zy64H93Dwary+5LvOOu343wysK9GxUMsJt9ESj5btIlqPdywHT8vmD67YvGPAoF/x3yZG3LHh7dZG8q/gtWy/b19cPhlo8nNnXnqEF0h7nE/ltWdup6DdvlH4HcoFYaMfD8+KZMV6Nv5XXpmSmcgQ94fjbq6RpxSQwnzq7UXarKD8LjmvWxl+5vaxdtSLl+vQBoPAlz1+dg+ILTz84VtisIYiw0ad3EIuQhQbcbYSsDfl9yL3rUkx2qO+yEb2NtCkQ2Fm3IO17nJB9KrPPm+T/qEgXoGVHlivYgejJEd9lU5sCIz0CwKdDurelw2XGvaY0nI7xYOBc6QrkGfSXmL4RbKqj3ZJ2PIJhnpEDGJMm+/XmrxCm1GA9pgdb3fgW8qWWDVkr+09ib2mFcHFvH7pgUIS1zo/GUOR2uhAkDta/7zYxFcm6pSERA8WykStTkWHbbfBM3IVe36tTA8CCypUdjIbGAWMJQSylTJFpr+k=
X-Forefront-Antispam-Report: CIP:12.22.5.235; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(316002)(47076005)(426003)(8676002)(81166007)(36860700001)(55016003)(82310400005)(6916009)(70206006)(4326008)(70586007)(356005)(2906002)(54906003)(508600001)(336012)(8936002)(9686003)(33716001)(4744005)(186003)(5660300002)(83380400001)(40460700003)(86362001)(7416002)(7406005)(26005)(14143004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 17:46:35.8559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1587681b-17e6-42e3-05b6-08da4976d555
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.235];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5109
Cc: "cohuck@redhat.com" <cohuck@redhat.com>,
 "heiko@sntech.de" <heiko@sntech.de>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
 "will@kernel.org" <will@kernel.org>,
 "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 "samuel@sholland.org" <samuel@sholland.org>,
 "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
 "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
 "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "wens@csie.org" <wens@csie.org>, "agross@kernel.org" <agross@kernel.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
 "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
 "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "marcan@marcan.st" <marcan@marcan.st>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
 "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
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
From: Nicolin Chen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Jun 08, 2022 at 08:35:47AM +0000, Tian, Kevin wrote:

> > @@ -2519,7 +2515,17 @@ static void vfio_iommu_type1_detach_group(void
> > *iommu_data,
> >                       kfree(domain);
> >                       vfio_iommu_aper_expand(iommu, &iova_copy);
> >                       vfio_update_pgsize_bitmap(iommu);
> > +                     /*
> > +                      * Removal of a group without dirty tracking may
> > allow
> > +                      * the iommu scope to be promoted.
> > +                      */
> > +                     if (!group->pinned_page_dirty_scope) {
> > +                             iommu->num_non_pinned_groups--;
> > +                             if (iommu->dirty_page_tracking)
> > +
> >       vfio_iommu_populate_bitmap_full(iommu);
> 
> This doesn't look correct. The old code decrements
> num_non_pinned_groups for every detach group without dirty
> tracking. But now it's only done when the domain is about to
> be released...

Hmm..you are right. It should be placed outside:
		if (list_empty(&domain->group_list)) {
			...
		}
+		if (!group->pinned_page_dirty_scope) {
+			...
+		}

Will fix this and the same problem in PATCH-5 too.

Thanks!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
