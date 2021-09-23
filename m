Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E24C433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 11:36:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EDE361214
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 11:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6EDE361214
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D9D984391;
	Thu, 23 Sep 2021 11:36:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dOvY9mCNCBxn; Thu, 23 Sep 2021 11:36:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 43B6F8438F;
	Thu, 23 Sep 2021 11:36:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1AB9DC0011;
	Thu, 23 Sep 2021 11:36:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7877FC000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 11:36:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 53B6A40206
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 11:36:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mZMebMc2kBqa for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 11:36:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::611])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 52127401BC
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 11:36:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKuf1RyhiSFAr254woQT8PkPWY3sdENxRqtXkWbycvmy76NOtfOUy7Ci4pnlYtbDQTC9K46oIA5BfJz0Ez6wq/Z4ctpItJ9Q0LQWt7yelESUb+Z7zcQoEIffI9ofhda5Zpx8TCxzxbPkq0DHFZoy34+jTk/RRbCCUDawJ2whJUnVTAihfqMMXgRe7hKMqkcovguTcClk1v/suDQQcJch4jwjR0hNkIclm2bAfoOnrj+RZ+Tn4B9h+16pfBD0FlHnlLEocMEZNpp3dcL3Aku+dLK2ISgk0Jip1L73IjYmebYEExincvdpkIvqOzNIy+eW/pkenA5es+oPSs+lewSPWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=kEhNweG+2rb0XCTGkVOR76u9OpQi+HWVIaM1AwLVqRY=;
 b=nEq/KluAOyrIaavMLpW/gLNtyR/PUtjAwgNM6I+vs6Liiq52QsLwxz6mykcGkAfhIxPKjcwc8KcNGZdXsqYw0rtY0Lq8K8bNYrSE9aEQEc8L54wXNfO22aIsQQvVgMn3HbZB6laAB3XYb9vBvi68mUggUh5Po56VumhpmHP1T+p/4h0hoGa5eXlQ7CjEDwHkDwZ03IQp1ySA1i13L1eyYVcZFM/GgFnaP418DfnXzC7ICQ3teS0xajht/0TWV7SC576D+z0QCY8lwKrCzUqWQCGCTw90FNyjb+4kjOMAmhQMF9D6+7YdWsVUJ+G41RAWStmEByX7EtHprXQP8EpNLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEhNweG+2rb0XCTGkVOR76u9OpQi+HWVIaM1AwLVqRY=;
 b=f2faKEfOjcCCV7QeEmd83YgTDc6sV6be0XapmTsb0E1PPT+DAW8mJLttrPimXpXSJQfmg6w3itXv5nMu9Q+UyfGrOEtoazaOMZSQK2WM1TnhvSGEqDa2EfCEQtX/UfmZVh0TFWVDCXjgHpzMyQMLetnu69VPm0Nm6YREwuuDVWBcXFmx3Ow0vaLgsK+lh9f/mII2OfJlZ0yIShlKOoVVuSWpsH+ohs9kRnrAjwwzmMHiUeWvahapDsA+9jOHBsX8G4x5tD/uZZ9NonAN1NqeiHsqCpPnM/mAy+ubZbeyzn26b2EM79OA4f7eZwwZcxlJ0s2JArwFzcUagKg3HBdJRw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5160.namprd12.prod.outlook.com (2603:10b6:208:311::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Thu, 23 Sep
 2021 11:36:02 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 11:36:02 +0000
Date: Thu, 23 Sep 2021 08:36:01 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC 10/20] iommu/iommufd: Add IOMMU_DEVICE_GET_INFO
Message-ID: <20210923113601.GF964074@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-11-yi.l.liu@intel.com>
 <20210922152407.1bfa6ff7.alex.williamson@redhat.com>
 <20210922234954.GB964074@nvidia.com>
 <BN9PR11MB543333AD3C81312115686AAA8CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB543333AD3C81312115686AAA8CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:208:2d::15) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 BL0PR03CA0002.namprd03.prod.outlook.com (2603:10b6:208:2d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.14 via Frontend Transport; Thu, 23 Sep 2021 11:36:02 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mTN1F-004OI7-JG; Thu, 23 Sep 2021 08:36:01 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1a9049b-219b-4180-7b9a-08d97e865263
X-MS-TrafficTypeDiagnostic: BL1PR12MB5160:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5160E0692D5D184E7F27D56DC2A39@BL1PR12MB5160.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H23AJgynycVbhia4AByy9Rxwfo+PF+CEXOL5zT+xiQSZY4lM5GiVNz6JUylr0lepiqRK/usG1mhJ2QpnFPegwf6USVtPCFePhvXzu+HlNPzRLgD8wBrqLM5h/8yZU0SJu6nZj8XhkWuik+TX+HGm5+W9rqqhhD0yaSCtWa4yjm0BCdUN0O4NV16zl+8okP4uRAKBGEWST6eziS8RcrUosCm+WW8MpWOVG3gbrGSaKvocD4VRWg+gX5LOotMY/ZdVfoyyt620fqB0jAwkVl+u14zkBRQ/Tx8r+bH2YlTCq7L2DGHfnNy5amtXY9OSgHycfCu9Cf/UBf1RSkknSWgQsaQtfjurjXEhSq2nsvmy8ygfpVZVE3v6UNg7oLflAA7wmEDqlGen5TBwr9KRAZCOUD0pKBjJQ+Kb06gMJdpceRQe8W7r/3oIQJqIthjmZdIc75kR8cC3qjtj+SMYQiWlcLcab7X5guLkjEY/XZ3rcIS7EyYCN49QhhOSvK1RfbNyA1LChx9QXpm5AwefMVIt2358MfrRJJVu/mm3WNg2iQ0I1IRX0q3Q/HZoqAX2ApRtJh7tgdh6HUVQmJ0OFWjxhnJFyadF6aCaUhtG1+6sb6byjsCBvqOwqdC5QoexGPwzW+mMC3H3itk5sfeOSVCdzHgDsx/9KajxlMoeeUcwxotPZkLABWyxlLbrgLvlL/Nx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(186003)(8936002)(5660300002)(86362001)(33656002)(36756003)(1076003)(26005)(38100700002)(4326008)(4744005)(6916009)(107886003)(2906002)(508600001)(7416002)(66946007)(9746002)(2616005)(9786002)(426003)(66556008)(66476007)(316002)(83380400001)(8676002)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J/xhyjLs32z6UM36q51AYOmsUFKXgBt553AZihg1Fdk65fqahuA2mT+wrP8G?=
 =?us-ascii?Q?jmzrGcIeEMNLgIxSFNKqmnSABsLHe1NUTFugSUs+JFejgl4YcMPmxPmqbp/m?=
 =?us-ascii?Q?PKb3DMZsZvsHG8xbd3hx6M3YF5l8Kfr5UnyDU0WJ6uzJ2cQGhuoqlulIZbE2?=
 =?us-ascii?Q?TNugVKsbXfact53VCcBMaYTljhkxTWFxHmQA6xu/tLPWsHor7lS/0z/U02/7?=
 =?us-ascii?Q?Wg3pHPyTzbsKpPbuOk967WnxQVZo+FWEULND2fOHvGqfdjZaGb/TX8X3w+hQ?=
 =?us-ascii?Q?iV8G//8RgArJK0umIfg8K/vTPply1Jxp3FjUP1/LqeSZbw0lQMCn4gUGye5b?=
 =?us-ascii?Q?+vWmU5nKye5OcOiB2kvbl52KyjCXZTHdrY2LnPcLy6E/Zb4rp/W5nNI/rxWV?=
 =?us-ascii?Q?8+6W4wp4Gqc+NnrGhW1b8yaSBUXT/fhJz8tBg8/Va4Su2r86CjkyQMFjCVy9?=
 =?us-ascii?Q?kHb7MmH+/3Uj4YECgHO2VQlHo8Qur29c/MYgQ0oYB7xYkoIKu0O+S2jvBfyK?=
 =?us-ascii?Q?2N9hI6TzYuPky4sVJ51ck6JNS3WtiChBjtlaRWptHTvsYrYYV8XV0H/eEBzn?=
 =?us-ascii?Q?zRh9SB7mFetkF9zCACqyNZbm9neMhSsOPL1vIi/3n0rbUOstZ1FfjM1eYDix?=
 =?us-ascii?Q?FV/chLlmzAO0fqNeUVf7YH9vbrkp3ot4ztJK5UQ5wc28CSOEYNqHkSr3Llkx?=
 =?us-ascii?Q?WNovmB3BmFU9ztOnkPETwWITE+HBeuu2VZ79Yn10klfQZwB/YA+N8v5z1DbZ?=
 =?us-ascii?Q?3mZMLvF93asGrC2UM5/R1jxRaOTcFHgbuFmUT4IDPbXgaWv/3k528PaqLIle?=
 =?us-ascii?Q?c3aRRNz23sW+VnMozWJU0CbaVQ5eeV+o3RiOPh9kkQdzbUTPoSR++kQtFjTp?=
 =?us-ascii?Q?u0jSqP3FoAvlqJ/c0odd4+aFwwExxLQ4jAJ4qsAi0UlybLgEyB/tyC1VVv39?=
 =?us-ascii?Q?ytz8Xmc46qp5UYvpzwxFPIofr9LyWlwYZqBTBRzEaOhtgegOvgHjLcRDCDII?=
 =?us-ascii?Q?ChWPCKQ67eKJgc9Wgxj9o1qHz9GjqIVfFyIVs0t4yJcBclBdHP24dYqpMq9P?=
 =?us-ascii?Q?4HP0o696zVt0hei0oRnPVIuf36gwDPBCiEq3w50dASWgzXVrSI2anDqL9oaF?=
 =?us-ascii?Q?1oDRze+v/0x5HdcnQ1zZg8wB42A9yFMqfoYWqHd/e0dUekSvFrfPeco1LyFA?=
 =?us-ascii?Q?OD8FMRPa8y/49m/WkMsHnMW2aUf61ih3KI3+td4RdinY/6HQFmYQ7QxEs9Rw?=
 =?us-ascii?Q?nwBu4jmoQik7KkyL5DuNwxXXksagolAKsiob9XHOCS5G4R/WHUh4YD5y7OFU?=
 =?us-ascii?Q?0md5PLY9A1v990XzqcZsRgke?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a9049b-219b-4180-7b9a-08d97e865263
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 11:36:02.4755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xq7olsuS3cpWd3WsEAJjopj1b0qNuCNAKn9jWhxW6gXMQxOHwCFqaALgi6zUX+SA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
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

On Thu, Sep 23, 2021 at 03:10:47AM +0000, Tian, Kevin wrote:

> Disabling wbinvd is one purpose. imo the more important intention
> is that iommu vendor uses different PTE formats between snoop and
> !snoop. 

The PTE format for userspace is communicated through the format input,
not through random flags. If Intel has two different PTE formats then
userspace must negotiate which to use via the format input.

If the kernel controls the PTE then the format doesn't matter and the
kernel should configure things to match the requested behavior

> When creating an ioas there could be three snoop modes:
> 
> 1) snoop for all attached devices;
> 2) non-snoop for all attached devices;
> 3) device-selected snoop;

I'd express the three cases like this:

 0 
    ARM can avoid cache shooping, must use arch cache flush helpers
 IOMMU_CACHE
     Normal DMAs get cache coherence, do not need arch cache flush helpers
 IOMMU_CACHE | IOMMU_BLOCK_NO_SNOOP 
     All DMAs get cache coherence, not supported on ARM

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
