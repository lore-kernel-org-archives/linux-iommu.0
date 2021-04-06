Return-Path: <SRS0=NW7i=JD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27CFC433B4
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 20:00:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56628613CC
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 20:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56628613CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0460E40589;
	Tue,  6 Apr 2021 20:00:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7nEwBJi2l5nf; Tue,  6 Apr 2021 20:00:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id BFB01401A4;
	Tue,  6 Apr 2021 20:00:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 823D8C000B;
	Tue,  6 Apr 2021 20:00:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04A1BC000A
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 20:00:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DCAEA40F05
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 20:00:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dUJdEj6vZVqA for <iommu@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 20:00:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::62c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3E3A740ECF
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 20:00:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BE+al2DV0x1QtmmfFSd+TBjzH85K5k3ZkkwZa2DzUf4Fgs5uim/R5NU4XXfSeboavSvfTw8ZS0RJjI0OfXkXQWUhvB4s8pP1TPD+Nd314+0lW2pUaZr/k85Qis3GfxaUCUyfHtcqY414W9sso77qKobm05UR3AnxhXt3uHZAHGrPdA8bxrlhfNifJUB+cdhPu1Bgo3FBpX9o6h/gdl+EMDvHFnWL3hQ6RNR8TuKr0DSZsI0EFZfN4tUG4wNevUf/TVXFlb64szvPa8BHCGePR2UAE3g79JCzVw+Qqd3AiUR1Whu+d5U5q9UkQGMjz0NoILu8czUBMlpaxpZbaATjMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAhhI0AlgfOf+lYL6Fj1t+n3uktHpBB3px/4TInVL3o=;
 b=JmoOjSGA6h6kjAjzgtUQp9dUltAMulq4/ZTvc3qgY8QkZV2MF771Pqm8Rtu5AsJ6fwg4quH287ylrYNsSbl1rUdmzJnLdmNu+hrxShW7mqR+6IoXZDTuOwAq3nmyd9GtOxlKDxQQm5NxcPxFERfybJNopFNuv+DvfHFdcd12r+xL8ApxY4bIlwuquM6rrHMfX77j4qtPaesDRXjULI4eEEXX5debOFi6vAzlmSKUijyUtaWULxCUokyES2MmJMnuS97hTm94GOI0XBXCIG4/hZc4XaFE0a4vI1xkeZau5ndJHYAYtYjnA+j1gGXDm5M1Q54DZYGlaZOolFE4U70Gvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAhhI0AlgfOf+lYL6Fj1t+n3uktHpBB3px/4TInVL3o=;
 b=fOb6pl2ukCcjLq1QDjaq22F+ZHlOl4lDAM+UI9HZ24UXG1neTATm/rYy2NICyK2JrUwB0FJ+zaqa46LQhwtUPlYvh5zZgg1Y1DCrdBMTTt103JZutsEXyImLAnphFEiidxWxumBefvlQIxywYI387i6hGA2aD5TWBOhUFtHQWw4RK5o2cbj28RFLTdA90eYkyEssyQmgOonaAmt0MPPN1UQPT2qbF6l0btKmP6H4ZKeYpLXnr6HCCajgnRoMUX8kjgaNzAax3Sq0MatNnrxBQZdlj1JAltX5DPC0K2uCQ77ohlqRo+2aymkdw3IzzT9pb3u6Sjj0xaAkgh956t/dqQ==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=nvidia.com; 
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3740.namprd12.prod.outlook.com (2603:10b6:5:1c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 20:00:32 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 20:00:32 +0000
Date: Tue, 6 Apr 2021 17:00:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 7/9] vfio/mdev: Add iommu related member in mdev_device
Message-ID: <20210406200030.GA425310@nvidia.com>
References: <20190325013036.18400-1-baolu.lu@linux.intel.com>
 <20190325013036.18400-8-baolu.lu@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <20190325013036.18400-8-baolu.lu@linux.intel.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR16CA0033.namprd16.prod.outlook.com
 (2603:10b6:208:134::46) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 MN2PR16CA0033.namprd16.prod.outlook.com (2603:10b6:208:134::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Tue, 6 Apr 2021 20:00:31 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lTrsE-001mtI-Bl; Tue, 06 Apr 2021 17:00:30 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 887a6884-3b9e-4124-1f53-08d8f936a210
X-MS-TrafficTypeDiagnostic: DM6PR12MB3740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB37408214ACE2B02C32F00F99C2769@DM6PR12MB3740.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TcEzag4ulTpVBMG1PKz34KwYPnYAEpIATku5HmBnEe/SE4R77hpA2RuR5EvrGk9QwRbpO7Zre89/o/rLVJdlxLlSFJ+Mo78xxPEXnExlEc8KJ3o6mJMurDZ85dqYx8QGHnkOqE9C8+7KvB7+wPDDDzGmijr9tNO1tuyiVvhTGnpNLdRrlhN8rEZvSDRcyOjGwmyyqQ2acnDMmzMQblEeaf/HQcShMx0XH+MwUK5BXeMKb9iFAkMZMGcmjAn0GGp5470mH9pPjUIuVokEzIknmfkpDNJLswEGOi+aRKu3xM5GsTPFGpCrZu3qRmnK3m7oi7AUK1ZjFiPe44IJGP/UowiZMQBOYSA19n6Q68CmBznMcXoIXidHOVr6ItO7rCY1rbjkfelDYfCZypbuZb5+Etc1YB0qao4oD6aCOftMjoMlWu8AtYjzqoC3sNolFtqcAS13oqQ0EPC8s52usgJr8yFAk4pqxdS7+6gGJTY0bmNBYKZhbZ7Ba8oxxT8t1t3Sqi+QXr/v8apyaoSu+e0U9+iEh9bazuy8WbKp3QguTHvXiEfolOaavOkeSca5X1Njzzr7AWiGdCrja5J/DuQ1RVwd1VKIYv0Sco0799lcXqZA9VEaHH++VykHUsl5jEk5hVHx5XFXclkqof9W+79ExAu7DURoRM8EOpQhHRWFfImduCIGUiaMBVZ0+8DKv7Ks
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(38100700001)(66556008)(83380400001)(426003)(8676002)(66476007)(5660300002)(86362001)(2616005)(4326008)(316002)(9786002)(54906003)(9746002)(66946007)(8936002)(2906002)(110136005)(478600001)(33656002)(26005)(7416002)(36756003)(186003)(1076003)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?yDkRkvt9jaaZn58bJhrMkUbrZ62pvqUVKiecccGhSR8bCWyt7106qrkJlVn1?=
 =?us-ascii?Q?47eFMd0JfCz9Ky7Ve0FwODG3pL9Gg7a/y8lmV9T9lU7E4Y6NO36deitPsv8j?=
 =?us-ascii?Q?+gAdFKNE5Sruc9fHZmT9s/es1dOSzObWT0PgwKP7qWPY3DIVGRScW0m6UbY7?=
 =?us-ascii?Q?AkR0JkQWWloZJw/n0rBtS6E3CeCjqy2K2LoRN3HiHMK1eaIrgTjMBJbhcc5J?=
 =?us-ascii?Q?B1LU9nih59cb04oSsnzuNnAry9Ojw1MDGoYO41ACdrgnLivPWdpQF6MTwmoG?=
 =?us-ascii?Q?V+SdUQWWrw0i8AemDcys7SaEwll7Cvg7IjgNQkVjPG/ooPMe3du44MxCYsH+?=
 =?us-ascii?Q?yl42otenNzswa8v2w4wptirYUQhjoOX2g/rPEGEx1ojloyvxTuSZcPrxbhI5?=
 =?us-ascii?Q?C4AKoIz/Hi8I+egkk5FQPGsqkEvgbPunVdeYSg3qlKrcgD1gnv3RaZVol4T8?=
 =?us-ascii?Q?+022YVUlLmI23nLk1iLpeNCfTPV24KbWvrOimedyS8FQNlvU2smHfVsmpZ0v?=
 =?us-ascii?Q?GvO623No3iXmZOZgKBF9dL4D2dGj2Gyym2jEIGVYHDGeLJ2SZwADD2mYoDay?=
 =?us-ascii?Q?S5Bf4JOXT523wEMiIA+oE9dndNTHz8ZrKEvAXws95TBmaCdjNNd/JQe2KgZu?=
 =?us-ascii?Q?25DQMLKZG3NTkW2Hm0aPE/OnPRFG1wrZh3zfTkL/kznRjqejlEM+HPujOj9J?=
 =?us-ascii?Q?q8JowYFyKUgJUxmyyRqVJis3W9JiKftzuZ3e+Qg8svg1SOmzqb4P6BJISRSa?=
 =?us-ascii?Q?FAxWzpUd5zv9DJbYu1qOzbB3MlQwDtRntnHErNPZDD5zHayErs7yRNDo0mSt?=
 =?us-ascii?Q?E6GVTHVLaGg0PsMIzehgMSyxOT+wddiWEciCt+jokm4PK5g3dUXcetGGZzw9?=
 =?us-ascii?Q?MxrjAUO3H6n6lJbVX65fmilZLtepe2fO0FRAgSkTF8HopArbgL074GE46nsi?=
 =?us-ascii?Q?EeajAv6SkSS92p/WVQUEn/rXYHprWKzyOUkV5GKZiNx3A0vyag7oVMRV2f88?=
 =?us-ascii?Q?uvGMq8y71H53t7SeiEy2ti7/+3bBXTpX3w51z31dYm+S2dtfnnwXz7bRyXsU?=
 =?us-ascii?Q?Qj94UlUAWQhZZ9RMjmgczn6WaB7FnZaD62hae3rj9S8ft+LqAdRBEg5/6msJ?=
 =?us-ascii?Q?e4JYhNIQQ1UMG/yczz3QB3AR25joc584lR9J1TghbdAf/Q/jYZ50FJpvlaoL?=
 =?us-ascii?Q?+3NkWkLuNLD+Wr3rKw5Zplf8UNqd1AyOo01ZrpQna0as2ykcZ4jTWKTuj8X4?=
 =?us-ascii?Q?WcsE8+61nhY9hvLMIQZie1NO8gSmWvnVkEWTKahXLEITnpap1werL3TC8x1e?=
 =?us-ascii?Q?d4m+FRRGItDxRAV7jiGugVEkrJUiVvfr7LG3l4vaS5Nyvg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 887a6884-3b9e-4124-1f53-08d8f936a210
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 20:00:31.8958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPr/AWIRdlDTuHX2kN4rOM0KuFhlOaTTuWjms2xq3I9i8xp6XR1Rt02d5DLm9/aL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3740
Cc: kevin.tian@intel.com, ashok.raj@intel.com, tiwei.bie@intel.com,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 sanjay.k.kumar@intel.com, Kirti Wankhede <kwankhede@nvidia.com>,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com, kvm@vger.kernel.org,
 David Woodhouse <dwmw2@infradead.org>, yi.y.sun@intel.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Mar 25, 2019 at 09:30:34AM +0800, Lu Baolu wrote:
> A parent device might create different types of mediated
> devices. For example, a mediated device could be created
> by the parent device with full isolation and protection
> provided by the IOMMU. One usage case could be found on
> Intel platforms where a mediated device is an assignable
> subset of a PCI, the DMA requests on behalf of it are all
> tagged with a PASID. Since IOMMU supports PASID-granular
> translations (scalable mode in VT-d 3.0), this mediated
> device could be individually protected and isolated by an
> IOMMU.
> 
> This patch adds a new member in the struct mdev_device to
> indicate that the mediated device represented by mdev could
> be isolated and protected by attaching a domain to a device
> represented by mdev->iommu_device. It also adds a helper to
> add or set the iommu device.
> 
> * mdev_device->iommu_device
>   - This, if set, indicates that the mediated device could
>     be fully isolated and protected by IOMMU via attaching
>     an iommu domain to this device. If empty, it indicates
>     using vendor defined isolation, hence bypass IOMMU.
> 
> * mdev_set/get_iommu_device(dev, iommu_device)
>   - Set or get the iommu device which represents this mdev
>     in IOMMU's device scope. Drivers don't need to set the
>     iommu device if it uses vendor defined isolation.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> --- 
>  drivers/vfio/mdev/mdev_core.c    | 18 ++++++++++++++++++
>  drivers/vfio/mdev/mdev_private.h |  1 +
>  include/linux/mdev.h             | 14 ++++++++++++++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
> index b96fedc77ee5..1b6435529166 100644
> +++ b/drivers/vfio/mdev/mdev_core.c
> @@ -390,6 +390,24 @@ int mdev_device_remove(struct device *dev, bool force_remove)
>  	return 0;
>  }
>  
> +int mdev_set_iommu_device(struct device *dev, struct device *iommu_device)
> +{
> +	struct mdev_device *mdev = to_mdev_device(dev);
> +
> +	mdev->iommu_device = iommu_device;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(mdev_set_iommu_device);

I was looking at these functions when touching the mdev stuff and I
have some concerns.

1) Please don't merge dead code. It is a year later and there is still
   no in-tree user for any of this. This is not our process. Even
   worse it was exported so it looks like this dead code is supporting
   out of tree modules.

2) Why is this like this? Every struct device already has a connection
   to the iommu layer and every mdev has a struct device all its own.

   Why did we need to add special 'if (mdev)' stuff all over the
   place? This smells like the same abuse Thomas
   and I pointed out for the interrupt domains.

   After my next series the mdev drivers will have direct access to
   the vfio_device. So an alternative to using the struct device, or
   adding 'if mdev' is to add an API to the vfio_device world to
   inject what iommu configuration is needed from that direction
   instead of trying to discover it from a struct device.

3) The vfio_bus_is_mdev() and related symbol_get() nonsense in
   drivers/vfio/vfio_iommu_type1.c has to go, for the same reasons
   it was not acceptable to do this for the interrupt side either.

4) It seems pretty clear to me this will be heavily impacted by the
   /dev/ioasid discussion. Please consider removing the dead code now.

Basically, please fix this before trying to get idxd mdev merged as
the first user.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
