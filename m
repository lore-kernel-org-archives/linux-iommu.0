Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 561C7C433F5
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 11:52:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0647A83EF1;
	Thu, 12 May 2022 11:52:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fNyzXMdGGN4u; Thu, 12 May 2022 11:52:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DA624832B0;
	Thu, 12 May 2022 11:52:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0405C0039;
	Thu, 12 May 2022 11:52:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF24AC002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 11:52:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9CE2941638
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 11:52:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9uGJTI6ZkP1p for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:52:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B942F41600
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 11:52:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inRrpvzRgyeArmJ1VhyEFCqhjnu31j4IlbhqM7h1UHvRkzBoTEsd51xEg69hxN+ZnKj58q2QwbCLIUnuUYOaZ9kmwoY7v3PCq2+4g7WwwBR8/bUa7p2H60Je9unq6Ogy6qG7sYvX11/x+W8omDvMxbcyuXa4QwYjVsIBaq9LjU6WEVC7/hrD6S13GXPM+eZmYY/yTmW1uQw4mQj+/8Il4eJEqSRV91+gJDI68I69vu8Hiqt2+z4qOvwAg6Q4HwGt6dGwPBE9/xAJBoKmMTlJyKisTGucSiJPoGxVmloT8j3RkG1GAnZ8jrxOimt5/qigeqjVn0R2BvLB7sF/U668ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbAnduvHdcQu+s5gw1mHTSWBgcrHChyr9kzAo2rmwnI=;
 b=QSHo371pKgwbEJpGmJkpEY7kwySDi+K605gAviTi9v53tJjViDn7oDEw+cF03yOOp4UsbZeFT9OcBERwjZLq1cSqzdcDQJ+turIT3fEfD/qBiO58M1AzNWfdGTmDPB3fuwogwgJOOApkeKErQO2P+f1iVoTtjZikYlAPeQJzxtRX4nqhjFN2+W8EKwf1AI0sn3K8/QzMX6hh1wpqpF8j+vZfQFv9Un9GcyClhh74ndDbbxi5GNtigKKUgVBAYmYeJrwfJKXXMm/jIzBXOPEn5rqm0Uc8mQIUAilYVpq8jd0eAUSK6i6qdkt+lJMlbN8RNSwtbrw6tn3l4FC3eCxtDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbAnduvHdcQu+s5gw1mHTSWBgcrHChyr9kzAo2rmwnI=;
 b=etpEmI10hYdVecJDN8CupYwMAL7jUnCc0dVYDvlkgTdUInKcswJdR2p1moiVlllI2NHMb9c4/dDUyDiV2NSiiUOczVlj1WWA0XM9/Lxcy8WB4JlqOVil0eoAAR0rRMPZW/NyU2PZJCuHBNDcP9hFH30V6Ttkj7XhWh6qi33bigcgOAIokOT2K/QclHzPfekfMGTwVZNQuNXpmxq1sp+3mz+06tVaazDXfmdWXezZbtmrw3+B0FEzaCT5sX4SySugx44Y/8RjRHvjbYvP3+E5uPf+tV6IU4p6SwJ4T0YPN/JZrPEDir0H5TijZRfHjY+ZIDsSkvb32kjQL+CPeDEu4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4893.namprd12.prod.outlook.com (2603:10b6:5:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 11:52:11 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 11:52:11 +0000
Date: Thu, 12 May 2022 08:52:09 -0300
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 1/4] iommu/vt-d: Implement domain ops for
 attach_dev_pasid
Message-ID: <20220512115209.GW49344@nvidia.com>
References: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
 <20220510210704.3539577-2-jacob.jun.pan@linux.intel.com>
 <20220510232121.GP49344@nvidia.com>
 <20220510172309.3c4e7512@jacob-builder>
 <20220511115427.GU49344@nvidia.com>
 <20220511082958.79d5d8ee@jacob-builder>
 <20220511161237.GB49344@nvidia.com>
 <20220511100216.7615e288@jacob-builder>
 <20220511170025.GF49344@nvidia.com>
 <c75a03db-69c2-0833-d853-b766c4561be4@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <c75a03db-69c2-0833-d853-b766c4561be4@linux.intel.com>
X-ClientProxiedBy: BL0PR02CA0035.namprd02.prod.outlook.com
 (2603:10b6:207:3c::48) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfdfce4a-b2c8-4c2f-504b-08da340dd953
X-MS-TrafficTypeDiagnostic: DM6PR12MB4893:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4893B87507C8C7D16E4570ECC2CB9@DM6PR12MB4893.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CMeO+BoYgA5deeXkhK+OJOzVdXmHemnwGqU3XnQjXf6DB8nMraOx4jnO83mp09E3ElAhhJb2qo9S6v1SFYmaeSz3iNJAXhzMTIv1sHlJlGir9Fwh7jfVjbew3mqAURGMVOEqqcoxUGLEhsO3qmHOiwT3JfGY1aEsv0Iw/N9uzuaVyiF+CrB3vLxvYiCpBviqQYxjW6prjBUavfVxf4dlT/A9EzHM6LItxzd5MVKYqYDluIaqTrM/VgvmoKAXZ1voeiyeldXUp9njHD7Vf9qt3BCE7Lw/pRDGs/0kZKzmOawj8kolF5Y0ii0iFgOv17yhjIYO1nsSlt/4Q5c6tvVjh1+DgXKm8ZBxrLIGKdZlUZCBA2fxthF6XHe3z4nmR1prBY/b5R7hwWrKJ6+z6mR1DNu6yf5dj0lepmMTTJvAWxEySsVKpWKGgLi/0mGlcyNokUh8sWQeO71IJ1MextmSKeupowRwGe+IbDSO3Ghs8zafmFUXLhyl4hHDjCyv0xbBF41oMcAuSUkjJXSZvtOX5dvzAHlKGjh4AkTPIu9MmEQTtqxfROO9Mdm9PhehbU02rw1k4ikShC214qdbHbZbOU2SvqjYOSFY86N33N81Irbsy/qxJBfGqZ7o78IWsSxMl64fut7p+F+LSk94nuN9Iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(4326008)(66946007)(6486002)(6916009)(508600001)(2906002)(36756003)(8676002)(8936002)(33656002)(6512007)(1076003)(316002)(7416002)(26005)(66476007)(186003)(5660300002)(2616005)(38100700002)(6506007)(86362001)(53546011)(4744005)(54906003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1tpAmSKBB5sMhE5QwOEZbTuWLGtPJgMTHpn9Gd39RthQixEDUsFo5YJqx6dR?=
 =?us-ascii?Q?p70INC35W8tH9emadDFLpVDKUPZP3zpAso7SN2VtSbLCypplwae+WYQoZ2K1?=
 =?us-ascii?Q?l636DcTjGRXvFZ4OgntwDtJqIq6/UIF9hidMaEyFX0klZPEPMFhIutR4+U5i?=
 =?us-ascii?Q?CMv9MEWQv7KI9R2QgHCioSd7KKAyPvMo1fDC5+qRj6IoFostyQ2Aq2mqZhhh?=
 =?us-ascii?Q?HbHNiJnYJKnEDAYMm136H7w57qa2iWvQGMGlFBh76D8rF8moyYKIxiGpROSH?=
 =?us-ascii?Q?jqFCaFejpaMN0MzqJdYsVJxDZ0tV3qlO5eiRqOuFGb8yDyZ15F5fkoDAnHil?=
 =?us-ascii?Q?cj5r0EwCBblCPJ0hPUY6S4krFfNJzbefvhiRCUc4fu+7VEJWKF3EXAGVydDE?=
 =?us-ascii?Q?MgZwCzux7Tf8uzQO63kElgliKy/GNqzo+q4KYPds+MeNcEDamCqBRhb9eYME?=
 =?us-ascii?Q?FuTNr/hM8dfLbU9R5muuaLyR/xqEoa41VYgljSrEvV60uINUhwwuRY3/pkVR?=
 =?us-ascii?Q?Q9rRNnxtdKWX7jZYVFg+qsjaclp/A6pwCIgWJo9GUiKXMpoTzBf79fvc26Rp?=
 =?us-ascii?Q?na0M7aDZGzB+uuBa99nWu8wpBXmekRf2b/BN0/j4mMAjfEoywbvj1C59EvG7?=
 =?us-ascii?Q?z26+7lB/+IT4f9hK1kTqduveh7UCd7ATTV0/CARJLam2oOJEA+e59yTlCURD?=
 =?us-ascii?Q?TZmsQtvcN4IS0km2qAwAwDfniDqGeiULgBnb+RE3y/EKk6m95ue/GdtKAZTp?=
 =?us-ascii?Q?AYSsBs/2Wf9IZgmJkMbBd2NP3K4mqpcC0fkeKrUoxoACALOX+1TvlxtQS7PN?=
 =?us-ascii?Q?IdXkyRcZr/fw/MoERMrpCwmytXIVvYgt2h29+8wMT4Vuu5S/9ezaOi2QOIf/?=
 =?us-ascii?Q?IpajHa0PKga/nL5HTeKNeeDDA4ONaqsNijEUC4FLW/SFWHagsdVQpSggWP5D?=
 =?us-ascii?Q?xaShglg8XQRNUESXwt4AKp6uw88RtEOQ+mYuIOoZ5Atsl+UGMV3nlUQiL7mt?=
 =?us-ascii?Q?4UnZaO3wRltKpM7dewxQYwUlnhnwekcn1DGO8xPU9pROxWQ3+IzXfSmUeqUe?=
 =?us-ascii?Q?FRkeNzmjR4d1q3+s0zkazts7dpC95L2PBykxPOtQ6tfBlQyeP1XV1he2ISFZ?=
 =?us-ascii?Q?ZnO377ge6Dagpzb6fnAYBLEICfeF8WYJoGH0iFgLEZAAqBBD9Eh2CKewG3Yu?=
 =?us-ascii?Q?0kcRRd92qtByHu8YUIlKmo6u6uludBR0eYCUv7AqrqqPWMqRIZuIBo54qUES?=
 =?us-ascii?Q?vqGB6A9yWoXe3CHhjQjnUyoTbB24J/K3dfYg9yq4houby/2VbXqjynY6LEij?=
 =?us-ascii?Q?vm3GPAw41EAOWJay9O0SAw/ZpkZ/mTycYeNyzQPK6uPGDRaZ69rTUDrPBHcy?=
 =?us-ascii?Q?dprPM48wU5brdKcSiYp2L0cExinYpwcBSSf7ejkDlfZcm7wWPss75TlSx10o?=
 =?us-ascii?Q?GTbMaYUV4Mr0orD8plo+L+H+b3BA3Yd6+dolnhVP/hguHqluLw4G/ZgWkYj4?=
 =?us-ascii?Q?s15okel1vqrUgLr04xThw8rmmPUOWxN3HW4mFuV74o8bt15TuMlLPjRBk7so?=
 =?us-ascii?Q?zxxK0pN5JpPnpKTxczjinjOxmGrXy2DaACycSJGqEm16gmt9mPLCmD3k8nKg?=
 =?us-ascii?Q?JMCW6lLp8//Scx8S+ZuSZGVYeJOIk3XqxsCo+Uu+QihIXs0Hj+kqYm4z7Muy?=
 =?us-ascii?Q?J1ogXgyVR8grXIIMqUaLEKmTmu5jItfm48mDpH9IC3qW5VGyzhtm3sG022V3?=
 =?us-ascii?Q?y4CNRE4g5Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfdfce4a-b2c8-4c2f-504b-08da340dd953
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 11:52:11.2775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkT4a9wwuZQyr0UhkeMmGA8CW69LWTVYKwEy7UmzsQDHZUBUDFSoFPzIp3baiq9V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4893
Cc: vkoul@kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 will@kernel.org, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 dmaengine@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 robin.murphy@arm.com
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

On Thu, May 12, 2022 at 02:22:03PM +0800, Baolu Lu wrote:
> Hi Jason,
> 
> On 2022/5/12 01:00, Jason Gunthorpe wrote:
> > > Consolidate pasid programming into dev_set_pasid() then called by both
> > > intel_svm_attach_dev_pasid() and intel_iommu_attach_dev_pasid(), right?
> > I was only suggesting that really dev_attach_pasid() op is misnamed,
> > it should be called set_dev_pasid() and act like a set, not a paired
> > attach/detach - same as the non-PASID ops.
> 
> So,
> 
>   "set_dev_pasid(domain, device, pasid)" equals to dev_attach_pasid()
> 
> and
> 
>   "set_dev_pasid(NULL, device, pasid)" equals to dev_detach_pasid()?
> 
> do I understand it right?

blocking_domain should be passed, not null

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
