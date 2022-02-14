Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B88CC43217
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 13:19:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 033B681BF5;
	Mon, 14 Feb 2022 13:19:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cAkIzYRourGn; Mon, 14 Feb 2022 13:19:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EE70B8188A;
	Mon, 14 Feb 2022 13:19:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2FA0C001A;
	Mon, 14 Feb 2022 13:19:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4D7EC000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 13:18:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A9236812F2
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 13:18:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZuB7wDMvLQqW for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 13:18:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 574A3812F0
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 13:18:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQW35npnfVAtOk1qoACyqv1/a9oey0w1+UvJscnMisQvGpvLKq9DwFIzggNu1TIaux9faC4LboIAoGGuT/IyaZFVnBxuDVtJzqI73n7TXC5DDbybNyFra4nU5qPC2SaFDtn0uUd3LdN9JRMl9eRzCxScgvx8owkMMWMxeJnDoogTnCU0hY8Da/gfeoNeEu4/++d+NhszuBG2yj8EZT7H7Aj+HxDXo/SbaTXpVtWA1Fgee8EOTFTRu0OM2u62t9TwqqMtsOx3JWzN6kurGlma6sbZuqfavcn4OmZdwzD4FsC0FJ9x9GV5mtsch0CATIynADFeLutI52r+vuPKM+tuBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TT5XBJ3cY/2m+zwOP+jTftkbAP+1h7MeEolixefMEOs=;
 b=l9qRjrlTLcjju2yuf1mIU5SUBRoqmHmNZIH4I1qkFyMmXSQyMvFMXdUeFqzHoz6MX8GspWf54HBiruOMmYdzMH9OcStfQqulLxmP0J1oPTvUyC2REQbNFBHHwp3D8TrvHeBhwGVYmwR0DLgxCyrLa9JEPHBh+7MsfQLRxrLo50xyKqWowcs5PJWIVsqdAX69cFK/dYI7Z1LS3FLvtVZ6drwvSa8eTNB6NtYyciu8JR0JiVenerkrsyOd5VF5Btup94kKgYQFaaHaP3hQk76cnefVqBCDiuC300Mk0Mxs3HVggI2+1iONCDpshsYVfew6RS+mkjrP/A9HSqVS6zV0wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TT5XBJ3cY/2m+zwOP+jTftkbAP+1h7MeEolixefMEOs=;
 b=nXL5ELbpcQt2nkg1lb0YYpALKiO3Hxg4xPccWTsdrOjuD8qC+xlTcK0t0VGA82FSD1kPrcaoZ4zc7EdpqJyAXv/STAMIWM9rh0UDrcJG7aJAd/GDbjO8lxvr/cq2pUvWc7mOCSsZKKu5X+5nUiDpDK77m0Uy7KmI/k0mc2MRXIzumP1s8WiTKej/2HA/gYfBod0yuFpfmYThsPgjNg/D81oIYlsZEcxnK0zBREqWkq5PjNuYY1VR44yzQnOGCndcYf1WTq0NAEziaMzRuAJkFCUO+HPR+lUIxuaDFrDJ/koNgfciL82Tl4ZXD5BtswK9TIc4oe56F3NGb1g1/rEEPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL1PR12MB5971.namprd12.prod.outlook.com (2603:10b6:208:39a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 13:18:54 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 13:18:54 +0000
Date: Mon, 14 Feb 2022 09:18:53 -0400
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 04/14] driver core: platform: Add driver dma ownership
 management
Message-ID: <20220214131853.GY4160@nvidia.com>
References: <20220104015644.2294354-1-baolu.lu@linux.intel.com>
 <20220104015644.2294354-5-baolu.lu@linux.intel.com>
 <YgooFjSWLTSapuIs@kroah.com>
Content-Disposition: inline
In-Reply-To: <YgooFjSWLTSapuIs@kroah.com>
X-ClientProxiedBy: BL0PR01CA0015.prod.exchangelabs.com (2603:10b6:208:71::28)
 To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bcf9f7d-ce89-4617-8028-08d9efbc8cd6
X-MS-TrafficTypeDiagnostic: BL1PR12MB5971:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5971F2951DC83F7EBDEE7521C2339@BL1PR12MB5971.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VkaAGP5r2WxgLNerXnT0GoAEiXJ56sVXSAXlVRSiPuQq6WVG+G0U4iTvS35nNJT1REa6JlPshlDfRi/XteU+nApt9FlqtvTnjuqV/o8WLcBVFLRQ0la1RXVaWNMAryL4dlTiMVaYFR9JlLtKiHbu/pu9JbW+V/IYBeiutPKIiI4z6+At5tgsR3cnDNR+JpgyA9f6tfnIhwIJE70lbAOuKhmMI7bQTng8Cq03X/sqCurh++IJ0NqNSWvQ3sFIR9hLTUMBW3Hy3Y0NWPfXUwIGoF+gblwvtnCRn+KK71JqD/tH4yX5sI+9nGDrQEtSTtk6SYOQBVrmFfBbOLkQjhS1cpsas34aoExOXMuj434nn6VYVkvW4xgEqFkR21bYJDXGwN2xRCD3SETdIXTvL1OgRY2o6+J/Ea+r1ILcgRgoQuFiKY5OFZ0ffzososayu0bHTvRKJX5+kxrj5ABjVJvcMAhEbdc1dFXlrzp1R0oOVd3FBRJbZaHVlWDkMzSbM6khkqAtOlV04w2xvPP8YiIRYSqEnc0v3JoeoKI1LiOs5jR/ZOIjDduAIz/3FWI5xrjYnjsg08p0TLn+F2BqmacmR5CPVwPDgwdOH1UM4/Ovw4EAew7uyEBf6kehMaCnyH6fBBRoz6nL2tUMYmohlA1VrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(6506007)(86362001)(4326008)(4744005)(1076003)(186003)(8936002)(83380400001)(66946007)(6512007)(33656002)(66476007)(66556008)(8676002)(26005)(316002)(5660300002)(7416002)(508600001)(2906002)(38100700002)(36756003)(6916009)(54906003)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TIlzLL90VWCGCWBrCIB25krCuNL6TDSeVLaU6nr/bceMID8s3MbZRE9wPDAg?=
 =?us-ascii?Q?BV0tD1587dtwEZTGZB5XYuRMYtFAnQJAs/ZmQCcQXCPO0drptFjuxaMzw/lX?=
 =?us-ascii?Q?mcaYAd+pCR+lAPgWG3NHbH/IRsJY+GzpkpjZVZlvTkfNtR/nre0nmZA8f4jG?=
 =?us-ascii?Q?6iO17QSNY4GZ747KUAJ+Xah+z3Yvs2q4dYuRs8FluFbUXhATqUuUCgfoHISx?=
 =?us-ascii?Q?wRuUriWbQdLNLEYmKorvgYsdcBO7f0/nwUTddrUNJhMMIGV+Vm79kurMwXQg?=
 =?us-ascii?Q?tizC571KiEKwUo3ongY6Vtmnp/WtiWnXIzWhtGqhH2awxPlclwvoLhXRkoxR?=
 =?us-ascii?Q?8g0m3IdwexqPLoSIRd90YxzoJEY/ZUXUcfEhPaYloafAAuh2Xxpl/qPPbq66?=
 =?us-ascii?Q?iwC8Fut5iWUuZHHQzF6pGOB28ufA0cKWoBq9nWzPNt5ARnK/+ov1qNBGqFsY?=
 =?us-ascii?Q?PWV5gQNxSlJ5txpszajuKXdKO0doGpqecyRUE9OUcwLxn+QBLlSytqUr7ceK?=
 =?us-ascii?Q?AHUg6aE6l6l+t15fS0OMc6nCtrNVHFFb5SCubigmgb2rCg+c+OZewEH7pafD?=
 =?us-ascii?Q?ajRuGXixhQSXv+A0CyNcFXv7QZweF2X+Ln9OaaiHaebyN2gpzGW+xekt223R?=
 =?us-ascii?Q?xgNVp7D7NjqZ9Gn8lxPyKIJ+WqkUSViDwQ+eBiz4BWsb3wYAth6tNu6u4dBN?=
 =?us-ascii?Q?cL+HFjil4Y8WWZgvuYUyJDZ91epw/qz0Nrp2IOLw3/gAZHGgra34/fx/h48q?=
 =?us-ascii?Q?FA4bcRCs8tE9jbAqryIXtipoynBUAlzf2rv9mHt39mc2yocfCApXheob7FtL?=
 =?us-ascii?Q?COzcQtBcimPpCwAsiMX+AKgJWzVG2/eHbcIErXtocoGO+9I1RwkqPnHthFL4?=
 =?us-ascii?Q?0UWXMVykADQv1G/b5TjTlovv7pwsO6DsurFiPfUS8eVGZKyWrUpd6F10zGlB?=
 =?us-ascii?Q?TYDkeMwwZ9LDQIGHNuMbUnjitTJwJYDM9rpp67s8qS5ZzpzpCF5Qv7DxQnIK?=
 =?us-ascii?Q?RK1Akm+cPG4Ct8GuJYQbwxANJX/x6IkE+4OLDEes+KT0mf+HwZ/7eyjut/AB?=
 =?us-ascii?Q?3sczHBlJCigzHH71hOxRSpJplpLt56gBx6pI3/1OAorX2Hq05/FlKeoW369U?=
 =?us-ascii?Q?f1mS3C3gKvha6ZGcyR32r0DsmjBRT3mb3N9LRiYhAhhZhSVYTjz13qfftTl3?=
 =?us-ascii?Q?YDwuBVAIiSOzkiwqt38kd6kN1mHx+B3wYRwLPEpIKq8w22QuVqkewZ473CEf?=
 =?us-ascii?Q?SX+ijnyqNYc804HSsmJH4OhCiB9EZlwEYb9CeI0yVoRXlbEgKDfOc8jQGcCd?=
 =?us-ascii?Q?ET1OTk3JOlIQpliHwNMazgXfAchifOHrBaYdokqa8aNrovOl0Ofis/G9eN7G?=
 =?us-ascii?Q?pHdJjSbYXnKmAfLAI0yBudFj0tDE/DKlJPZl1A/c7yJpIs/8/D05YDxiPT5a?=
 =?us-ascii?Q?abAdc+3Bn0UAmvn4qoHNCJ6/3rNyUzM8TsYIhxEmGrj3NobbquMwxB0K9zx6?=
 =?us-ascii?Q?Iimv/nc4qkEdXksVHjLAZE7YbMndo07VAZIcmwjBHcpymexdaalbonRavdyi?=
 =?us-ascii?Q?Go/SMCskCS0bEV7WN+U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bcf9f7d-ce89-4617-8028-08d9efbc8cd6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 13:18:54.7893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DnyNu40OFe9kc3MP1VLuPK+17XF4FA29IsrTo5y7/RuQEgzm0fR/FTM4dfgdVSlY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5971
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

On Mon, Feb 14, 2022 at 10:59:50AM +0100, Greg Kroah-Hartman wrote:

> > +	if (ret && !drv->no_kernel_api_dma)
> > +		iommu_device_unuse_dma_api(dev);
> 
> So you are now going to call this for every platform driver _unless_
> they set this flag?

Yes, it is necessary because VFIO supports platform devices as well
and needs to ensure security. Conflicting kernel driver attachements
must be blocked, just like for PCI.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
