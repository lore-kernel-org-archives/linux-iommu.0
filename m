Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178B3C433EF
	for <iommu@archiver.kernel.org>; Mon, 30 May 2022 12:14:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CD3C41A12;
	Mon, 30 May 2022 12:14:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y1OpUKQkx_eh; Mon, 30 May 2022 12:14:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1B47941A09;
	Mon, 30 May 2022 12:14:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB998C0032;
	Mon, 30 May 2022 12:14:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CB8BC002D
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 12:14:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0D6BA840F0
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 12:14:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i72DHp7AOwYJ for <iommu@lists.linux-foundation.org>;
 Mon, 30 May 2022 12:14:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::625])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C20938406E
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 12:14:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KW/aUmz87dCjSkX0S8Rw/aqM8nNWJxV0Lw/fgZLU5x4YGpn4xmpXXyOQiqL+J1Mw8d7/q0kFRA85DlSIJJNwQlEp075zSa/48lyJK7xZEO/e6dFvVXNGb5lR9bmvwYrcJxxU3QEh3iO55CjSTL3o8TqIQdSJ9rRQ8HwoPLGOvbCqU+4WV2ZgP4OB/naRSALk4HCkdTz58CuD9aVwc/9y7rr4CCJymhpM6JVuedB38nG+PAUmexpeWqlhc7UDpvhRlmy6u05XjvvV1bj6y1atwSkaVLwwYefRvNPDvUAd5kG431gMNBCSLo26NGTTQjK0I2iIGmkqAdUxq1RlfYnZow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGJ3ng0hbibU+AEE3erA0ggYe9huuI1cL8aqEQ+XAZI=;
 b=hyslwuckkxmhO8zu8ohykAT66I9uoCj4Lq0KzqO+fMlwHNKZ5Rw4nO3P7k5Ak0vrKfQtZ6MbhiIFsmh73gHVSqC7eM4VSy1PB/Y54u9ECYYxYq1yO/ay2qEFaiok+a8lmY8lFS7O+x2EI+131eTES2mE5yyRTcNAx/7usL0oSASWvTCSccLOZixRsDdShrGzdz3diB963NpcxqfaZpuyrDdGPiM0Nywf65cR/nGia6R5Os59Nc9o2IYuWMS5jGq1Icke4rrlmnsJQoU9Wy71npXLTokHQ13MUzSTyMynU5BHd4WvGQ2gmgqDdCXUB9TYWPUXiF43yGvVc+Y/alqJug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGJ3ng0hbibU+AEE3erA0ggYe9huuI1cL8aqEQ+XAZI=;
 b=gARooUJPQ4zGcjQwehnhZtwtrNIAuQCbiLyJdFJeORJJOqeM5o1y0XBb3PHvvoEgzY88DtYLNPNDCGeTnKK+mCJaSRX+IpiuKXbh2QjRi5JFBQXgu+Jyix4dkEf8GtcsU63i7Vbp1hvNNIZ5EhvR5MZxwc5ib0FtTsjiBB3EgAb5M81F9AzLBV4uf7rnfiyNT86kFVDBmWKfOwVoHooxBctr+hcMgubxVRg+y2LyqdHsWmyrOWPgKH1enhGznVkSw8gbPPza0e8BB8kSEOwnt54pMvTfwS9iQw0uuX9Msv9KQG2HbwMBC+VuDaVMN+/9/ekEvPP5Kp0+7eM04UyxaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR12MB1638.namprd12.prod.outlook.com (2603:10b6:910:10::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 12:14:13 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 12:14:13 +0000
Date: Mon, 30 May 2022 09:14:12 -0300
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Message-ID: <20220530121412.GX1343366@nvidia.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-2-baolu.lu@linux.intel.com>
 <20220527145910.GQ1343366@nvidia.com>
 <eda4d688-257b-d12a-56c0-0f9d3a10ef8c@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <eda4d688-257b-d12a-56c0-0f9d3a10ef8c@linux.intel.com>
X-ClientProxiedBy: MN2PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:208:e8::36) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32f83a35-d452-4e9d-b9f6-08da4235e8ed
X-MS-TrafficTypeDiagnostic: CY4PR12MB1638:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB163897AB10926478C8BAB406C2DD9@CY4PR12MB1638.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K4HAMLs9ve4CgG1i8ez2gbGdBku8gegGYyK2NoFA97P939oSgjXd7vuVkh+IMvHCI4yCwjRVDUN0ddj+8G0w2TdKCNRKlFkc3a1AUluM456QzKxw2vdUVg3fqJLcQHkvuZQRFlA9eggs30PZ1TAm5E/inwPRqBDD40/81mZAYqMNPOhJNxHeCv12gkPR6/0a8xYheHYe1dgxf2O9UVTowSBfXmIVXtlrDSEJwCtu6OJZU+6UFlFhxYer2wz0GmOWEF9Y+lSctTjYHFb7eLYztLqMWD3vnraT7K3lRg/fihJ0hG3owTfhrb1f0Eqw/9G8fPyx8SYuP3RbKifVwq+4gofTsAIjyXzhNR8RChNekZ4h0i47VdkgIRXNk+gJyK9N0DkIunFffkqrW8PU+4ajXEKp0EA6lwRKMAI44Ve9R6gmHLJQNQr8yEiFzrm39UVl46VZnWfxBlKwq+qSEsd5gLG22RV8XYepzLNreT85MerY22DDpfxZZS2zJyDzKuvBVjdW82hRaCvbPk4vsUbqyFgb2ek8UaA2PAJ4fnSBAe8qh0RUALEzq4H5hIFfUhMIHmr2IHDiFjxRX3e77il2llwCv3d5IyxjhLNV5unudiP108LkLTNkwGcDWT69gmnO7JKNIVm9PFttSL3yb6v49g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(2616005)(8936002)(6916009)(26005)(33656002)(508600001)(6486002)(8676002)(66946007)(66556008)(66476007)(4326008)(83380400001)(7416002)(5660300002)(1076003)(186003)(4744005)(86362001)(38100700002)(2906002)(53546011)(54906003)(36756003)(6506007)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4LrqHoyQCBk0GndY58rVskbGEfwGtTbRNA4cveUjgslJEx7GDadJ3VaciCYz?=
 =?us-ascii?Q?eHZmfCEzsT7nU7hK419OKqJRbfkugOp4mFiaMu9Phf1EQlg4bF1JMldRSE18?=
 =?us-ascii?Q?+6n+cgdMTo3ifCvudygrRnG6Wy/bu1WcqC3Dbvw2C80LBCP9KOkaKnWATSSy?=
 =?us-ascii?Q?9onQr0JeZsqhRxcndzPmZEKestk/heVqn/v7DDUEAWovmI4N2dWOwMVRvv+F?=
 =?us-ascii?Q?rJ5aFpQKbnCbh9fwDLHjCWgy9i8PjCOikvL8jj9DZkT5lHJsC7gz8Pxu21vI?=
 =?us-ascii?Q?5aFkI8qV6/NHIUEYqtYQUVc3wEMyZwNf+yNihdKOenMMzq3VBm2GoHF39XJM?=
 =?us-ascii?Q?5IY/Jk713zaAidtfwgun37CaSEGR61DpF5Tb+FxLtYp1xDxHqifYFovP6x9u?=
 =?us-ascii?Q?gOVY1PK5xUNzL8XQBUeGaDTTLLh9kIxf0xOXWrndINk7mi416ieb0RLdPFwk?=
 =?us-ascii?Q?vJ+V72LexK4dVwxaq7gQP2SAt9X2cylB2S9WSg0NkzGS5QlHFRZjf3bV8LHR?=
 =?us-ascii?Q?FxHEVsIMg3LumsWINpY3qTb6Bh0FCwC8489ZAnUEqmwCB08kbJBfxMGl13xE?=
 =?us-ascii?Q?6UDlrTsBAzQ79Gaau7HEaUACXo0GzFYBLMZkjOvcUm/MkyjrIetujoR3NqwT?=
 =?us-ascii?Q?rwpt5Fr847XF2lf8HjG5mJ6T0ksgZMYwhgfeFkv8RbOrFBCdn0fMt18qL9H+?=
 =?us-ascii?Q?TV8tkHAq9OFY7Jgn62VV2ts6WFN9LP7ybBlR4QgEn+7mx3uf+wKKi4ce1xg2?=
 =?us-ascii?Q?tkNmFD0K6BYjZxtAU8qKqJHAkRlraZ3wxEdbNMXy1X73Udkgs2X4o2dKH5Va?=
 =?us-ascii?Q?9g7cwX+wzyZwp+F41X6/c3pxfI0R6wlBgP6NiM13r+MKQPXTimhsBfZMUQFF?=
 =?us-ascii?Q?0O9eQHqNh8XOnYlpSy4NXrP5MedVwWUCqYrPZ2ZVOJOS7f8DNbsnkYBxKFyM?=
 =?us-ascii?Q?LaFuXY2MdlNK4V85/8bfmVvq9+ZMjin0WVIoknmYe9a8kh/d6OLcWrYxjVC1?=
 =?us-ascii?Q?7EoYjVFRcgn4h/moxFzcZue7vJwn2R6Z6UJGYY+9IcDXpnfeJuUDmcGiuOH5?=
 =?us-ascii?Q?ntSUPmU9lmNLaB3Qo5+W0Usmqcc46M2aoi5yPzmZi8IzLquofYROWdkGQc8P?=
 =?us-ascii?Q?vFyAsZ00pKE1kdlobI+VQG0q21Kb9zMJMzybBzdkA5IdRYxqNOHNe1z7vmDM?=
 =?us-ascii?Q?zQdxW15603OOsHX4P96Spx3Qi2oFbgUkkenmCpwNUxlAVZhh76kcCYvHK+o2?=
 =?us-ascii?Q?UWOLaNHC2bzUmmojVJKUpQyF+EQdwUnGwkaYKVyd3EqMQd9GEkVvjU7H6Lj7?=
 =?us-ascii?Q?eOjql7SZaF3dgs96wtmSHm0I7TJ9Ir3V6FiliUc+obEayuTrjONB/tpinzjR?=
 =?us-ascii?Q?MyebPeblRLp++7MXZeacKtWx9ddOdBXc4X/YJVlTeQNXCkq0Uv215NwzykNT?=
 =?us-ascii?Q?RbqqMEA/t2gbpB1adi4qEazXqFaUk0X09SUoinfT9G5Jf5OlLiGRrBgTLbgM?=
 =?us-ascii?Q?iAaomO03CdgbWRWnKWkgN/C0VGFtiSm/nN9lFzINh/m9tbAZTi1pufkQQnjI?=
 =?us-ascii?Q?GPTh1hwWszKP5VxY+1ZueCMsqopKzA4ZtRw3PkCdzob2GXBgGcPQjpIL3mwQ?=
 =?us-ascii?Q?gWcLNxLiVJspEUl70ow8v9RCmSqZyRyyPcHk1mgfABKLPuxlKESFRGRqQYYe?=
 =?us-ascii?Q?n8lg3vhKl4SJNCuReT3CJvCtPAet+oOdySQyQ7D+jDZR9xn1+PVYzSAdO0S1?=
 =?us-ascii?Q?q0TEU2ahMg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f83a35-d452-4e9d-b9f6-08da4235e8ed
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 12:14:13.6658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oN/gcnrXpG1bVN0XSZ5UGBIYabJ1ptYcTPc4vpl6Q/CTzFcxdzLMzLKfJynGAwnc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1638
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Robin Murphy <robin.murphy@arm.com>
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

On Sun, May 29, 2022 at 01:14:46PM +0800, Baolu Lu wrote:

> From 1e87b5df40c6ce9414cdd03988c3b52bfb17af5f Mon Sep 17 00:00:00 2001
> From: Lu Baolu <baolu.lu@linux.intel.com>
> Date: Sun, 29 May 2022 10:18:56 +0800
> Subject: [PATCH 1/1] iommu/vt-d: debugfs: Remove device_domain_lock usage
> 
> The domain_translation_struct debugfs node is used to dump static
> mappings of PCI devices. It potentially races with setting new
> domains to devices and the iommu_map/unmap() interfaces. The existing
> code tries to use the global spinlock device_domain_lock to avoid the
> races, but this is problematical as this lock is only used to protect
> the device tracking lists of the domains.
> 
> Instead of using an immature lock to cover up the problem, it's better
> to explicitly restrict the use of this debugfs node. This also makes
> device_domain_lock static.

What does "explicitly restrict" mean?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
