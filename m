Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F0BC433EF
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 18:20:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3AED81B70;
	Wed,  4 May 2022 18:20:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p0wnOzD_LTc8; Wed,  4 May 2022 18:20:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 89039827A9;
	Wed,  4 May 2022 18:20:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F9A0C0039;
	Wed,  4 May 2022 18:20:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC008C0032
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 18:20:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B1CEB418C2
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 18:20:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zW5Uegu5N3c0 for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 18:20:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::628])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5C43240448
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 18:20:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwpExf7i3dU5yjK69hwFZkzzhXdlOqA3ekSMySrD3cuNZORc3y4e3GwwIadNY1bB9Bez25/aiR/bdsqfNgq+cWE6lcwvXMaV/quO+Aqaau7UPZMHl/ExyWNUsXz5UWvyngRM6kIAITWarp1EcGwiqeeKb7KH+E/9mW/rBHTHM3Of4kRC9R0jRqA8XqZ44jVIwET8PB2BxpTxZ9blnuS/HXiWP8fLGsFwmf1ZbungIzTCU0/MvTRbMPcC/65SDhHVEoeTviBJWYOYGYwA6AUA4VbKIixsWp/GxqKELaOz8C7IfVcPwpRG6km33ikB84rmSgLDQuMNaXulXV+MBhBqTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1x8UydrxxiQulhUse0+R2JJh7UGzPkqtzNpIFALzczU=;
 b=eiSdfOmK/VNfwkZjWzmgaW+RqxxgVGtl73GVeZqFO7d8dEjeIEcpj9x/bxOWPy6rMe2Vs43PBgycoDRNgQ910buctUU0az7PcKke9XihvlSkgOYxz2a8CkP73nkwTf1ZXACn5NuLTY7geXINBd11viipnlxCWRJV6g4ZV4giv9BSSkZFA9T850UJsfrsYq6TwVmFezvdskZI7PqpslEO7a8+nWl0wONYMFt7H2R1Zr4m7YlQuBQbVWBNde9MhCuYCKDs5wPMgP3YaUIwGUX1nA1NQmJaUZOqnqZlPNjGgYLZyrO57ryyffttY9dLReUamhTqHOrmPTktKKW3cY/VnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1x8UydrxxiQulhUse0+R2JJh7UGzPkqtzNpIFALzczU=;
 b=jHgYJpyvDc0gZ5VtSaAv4Gmm6hqe+JvdIWpJ2tnUbc7E9Qla5DXgHVroViaxiDcDwwbOgyRnnItfn2zHxJGsgv/KTl/WRi6Y4GuzQ0fMrsNmhdM21knFzvE22GZR8+4a6vBQRx/CeHR8RSX5UQMOePNHIK/z9G6FCYQ/OHKfwyHuA9Pd4YyAxEmtgXLgKLkAvl6bpvDlLCOojlV03hw1d4mgAV4MwfjEGcY9rMB+k7wIc9VbTXHLletumS4+AGyYO6qLAOJJL9D0XF1EQgzWaR9tWarDxpcKeTD9yEdavMzrkDHetql0dIVlmlHfnnojA5QmdZ3/2mq0rNRFv7YAUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 18:20:14 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 18:20:13 +0000
Date: Wed, 4 May 2022 15:20:12 -0300
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu: iommu_group_claim_dma_owner() must always assign
 a domain
Message-ID: <20220504182012.GA88647@nvidia.com>
References: <0-v1-6e9d2d0a759d+11b-iommu_dma_block_jgg@nvidia.com>
 <0a8cdb2a-91a3-9953-b7a1-8517ffcadb75@arm.com>
 <20220504145454.GI49344@nvidia.com>
 <b3e79abf-646b-fa98-5a4d-26fdf5e550a9@arm.com>
Content-Disposition: inline
In-Reply-To: <b3e79abf-646b-fa98-5a4d-26fdf5e550a9@arm.com>
X-ClientProxiedBy: BL0PR02CA0130.namprd02.prod.outlook.com
 (2603:10b6:208:35::35) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a64c4c7-083a-415e-27fc-08da2dfabb5b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5111:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5111459FCA4B49B26C277DDAC2C39@BL1PR12MB5111.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0f7Hz/Lond+JJeMlS+Qs6WW7t7DA7zH4GI2cEcBXumYUj3Udphsb+oxExe3tJ6ZL6EsYt+2yCPAhdJUq6IXw2ydm7NmYj/MVbrOkfQnHRb14w5F4xOaNjBj2ZNpvN6fG81b1LkN5T0xcSQ2YCjju6IZxNQMOeajFWYAfVK0gUd1/AGwN5Mw/sjFCzfq+SipDpoSXOGNUDKkhoFMbe1nYomg+DeXomRKGHxLUG904IP08xVtfld0s5gzOoxrgrAUMWRVhABjXg6RbqZiXZwfh2TuKZ/8wHiUOTxAn9vU/CIjqxosmuRnTHPNQxCjHKxXEYMxwJtX/4TMhpw1XFFygvPtzBlEbmHxVNqYMyPbLsPH5LkcpSmZHxTz0AX0NqxGUCt11nQ066UxKtrWZ1OEG1wiW/0s3OAWpsLFZiWtzAWhpeYsaHT458yXU3ULwM/yVgwKIezC0mmihj8A4P8APE4GPn0AYnb4suTHrbJXCcutwXBINtOEPZZqrPAN16NfDL47fvaTdX+aA5bIAY/XDX/X1gZoUzQo+cBoKIBaVmuDZmzQK8ONZMIAr/QmlyMnniQOzPkRF/WCfcWSZU3Qt5Z+8W/eW4y6oDleOcVLtTiDr1gQGxSrzySzU9TYraAKy4kteZUm18rhCl8qExqob7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(5660300002)(6506007)(186003)(53546011)(316002)(6486002)(36756003)(508600001)(8936002)(2906002)(1076003)(6916009)(38100700002)(86362001)(54906003)(66946007)(66556008)(4326008)(8676002)(66476007)(6512007)(2616005)(26005)(33656002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gm5cpCojwaVRZduz7xDd0JW79rwNKdolZuOtpzX+wQlUTB8eO/3C7GXdd+S+?=
 =?us-ascii?Q?1S0LBYulBpGfMRaFtt1l08zD4RnqvPxo7xw9sWNsRkDKdf+zjVNU33yr+K0E?=
 =?us-ascii?Q?2H9sVXdSVUPP83t/IgBXsVjtcAae+tmMyYZDqNl1SS9svhmWCXxUzu7+Otd2?=
 =?us-ascii?Q?bC+ogXYJv9qmIlgMjlCntBWCI8XnBfI0HITOg0U3fLfsEgTpSLVRjukxZQ+b?=
 =?us-ascii?Q?NS8srul0zDcaXt3o/uTNV25sDcirAhdrvKYXDb2feSqWQtlEiC1ZQ442BBew?=
 =?us-ascii?Q?IPZpnUEE49yj5sF4Lp5I58if2C7xKhciE52jI5o4TxpZ0wTF5QugiwWvdhLS?=
 =?us-ascii?Q?JwlZv9LiiVoCv0xjKV+3IBtHOxML9v+0eDweQOkJZyRjAN1btfrUefX95WW/?=
 =?us-ascii?Q?7yLkZzylLE1gfNq9hsByo3T9XhpuJnqIU7QOvtBECqbiqY/u/1VPlowSkqOc?=
 =?us-ascii?Q?tpIyBhHVBrTOMKPZki/WVmXJ9ApBfk9ZaSYQFgN7jugJ+eUmwBdSjEdkT9+R?=
 =?us-ascii?Q?zUzIkIvzYYGK95wQl/anicy+MQkdgk6aXUOnIbrPUt9rCvZkO2BgXq48S3P7?=
 =?us-ascii?Q?H1tekMOlk2TcZ/KkgPwc42nQJEfp6hMSuit5D2j++6CxQP+adN9KpYVaAXvc?=
 =?us-ascii?Q?sLpZCD4WQS4KNjuxJSB3Zztz9yF/wilIO7ATQarGYYcRLhAS9JUT64wK93a4?=
 =?us-ascii?Q?UXbjUlpUhLvA6yrPE2Jshwyq6DrD94TfVh/TYNLFQdGevV5vfG6htv3WjRJH?=
 =?us-ascii?Q?Y0Ml9rr5GUXvwgUg8M0TKMhO+ClOfVYUnuKf3fCwnR+B4z/X0RiC5Zqw7bme?=
 =?us-ascii?Q?A9urkA8zWlau+617FV4+InfE1RR9TrmEF2+ef+GdDV6KYG7UcIwVP8k2oVPq?=
 =?us-ascii?Q?VuHGo0Y945a1WCs6Z0yBMowg112HiWd44NOFbUf+TkSHPDDmsLz0LCDNJ8KT?=
 =?us-ascii?Q?56OcF/i8P7okZxw01Obv1urN7Z6dQD8N3FlwxrOIXJmJLfed9JM4bkweg15z?=
 =?us-ascii?Q?ot74ke7z7R49J9uz7K0X/j1w6qER+PSQeImKUvu0lrILSasjUuAfhDbG+9Bs?=
 =?us-ascii?Q?jvp5u7b+twc7LlTM/Wvwkt8th4kSX2bn1kcGODVTTujlIVbD01XLNdWVayXj?=
 =?us-ascii?Q?YUG1A82qIlTw6zZMNvjP6xQxTOMHrmCWWpTSpMSSsZAm7j0431eZnQasCJTC?=
 =?us-ascii?Q?5iw4LT+ACX/40CQO0OOJQlBuExUd4frGH+MUPa59r9EOX39ty5BR4/5MS6QL?=
 =?us-ascii?Q?ZiqgCKL0eb1TVqje06gKtUqYsPAT5qrTPkmlgR+buRYMeyN0p5307mxJ73kO?=
 =?us-ascii?Q?YOy9J47PumfmBas7TIEEajNUvQMUK0l9rpx2RN57Ecquo4BVaDXmN34Fobzw?=
 =?us-ascii?Q?xm+kajPHKFKP0Y2X94m2aNqqLlaRoU5oQQ1jYWt9hqpMpYOMNx60XVXOICvG?=
 =?us-ascii?Q?aKl6ESOqUnp3X60Qom/m9ptAyeJEFMl45aljaGOeP5dJDxrT3ZwYfjZtFQjF?=
 =?us-ascii?Q?iw8zs1y3Z3O3M/npS11nExkmWEOTE1c86h/cP4p/DKFiPrVM4XCm/ff01ECf?=
 =?us-ascii?Q?dV1YC3M8HvGjkOe6jnOVBjI6YzEae1KmEDZJN92Qwv7N8PVO+sPXFqlTiGgN?=
 =?us-ascii?Q?VySXylzAYW5HUic8FmMjlBSsUba9ibJifkkEjqmIji0ezVd5KDYEUicvMZOa?=
 =?us-ascii?Q?lf6ebhtn+jcN/6LVBQIdGocff6j+ZMjVTLSL/IEWyOiI2SBC2gaXrPpbP4wq?=
 =?us-ascii?Q?4l1fZyUDsA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a64c4c7-083a-415e-27fc-08da2dfabb5b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 18:20:13.8339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fh4yr0purkRz6dZ8pM3+sq8b+SGoZTp/tcHLg8/jvxC7Usnp9fcPyC+IWGwguEUS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
Cc: Kevin Tian <kevin.tian@intel.com>, Qian Cai <quic_qiancai@quicinc.com>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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

On Wed, May 04, 2022 at 04:29:24PM +0100, Robin Murphy wrote:
> On 2022-05-04 15:54, Jason Gunthorpe wrote:
> > On Wed, May 04, 2022 at 03:42:09PM +0100, Robin Murphy wrote:
> > 
> > > > This fixes an oops with VFIO and SMMUv3 because VFIO will call
> > > > iommu_detach_group() and then immediately iommu_domain_free(), but
> > > > SMMUv3 has no way to know that the domain it is holding a pointer to
> > > > has been freed. Now the iommu_detach_group() will assign the blocking
> > > > domain and SMMUv3 will no longer hold a stale domain reference.
> > > 
> > > Thanks for taking this on! I do like the overall structure and naming much
> > > more than my initial sketch :)
> > 
> > Thanks, no problem!
> > > >    	/*
> > > > -	 * If the group has been claimed already, do not re-attach the default
> > > > -	 * domain.
> > > > +	 * A NULL domain means to call the detach_dev() op. New drivers should
> > > > +	 * use a IOMMU_DOMAIN_IDENTITY domain instead of a NULL default_domain
> > > 
> > > Nit: IOMMU_DOMAIN_DMA is the baseline of default domain support, passthrough
> > > is more of an optional extra.
> > 
> > Can you elaborate on this a bit more for the comment, I'm not sure I
> > understand all the historical stuff here.
> 
> Well, the comment could effectively just be "New drivers should support
> default domains."

I made it this:

	/*
	 * New drivers should support default domains and so the detach_dev() op
	 * will never be called. Otheriwse the NULL domain indicates the
	 * translation for the group should be set so it will work with the
	 * platform DMA ops.
	 */

It also seems clear to me we should delete a bunch of detach_dev ops
from drivers?

I naively see that these drivers have the word IOMMU_DOMAIN_DMA in
them and also define detach_dev:
 amd iommu
 apple-dart
 qcom_iommu
 exynos-iommu
 intel iommu
 ipmmu-vmsa
 mtk_iommu
 rockchip-iommu
 sprd-iommu
 sun50i-iommu

These ones have IOMMU_DOMAIN_DMA but don't define detach_dev:
 arm-smmuv3
 arm-smmu
 virtio-iommu

And I suppose these are the 'old' drivers:
 fsl_pamu
 omap-iommu
 tegra-gart
 tegra-smmu

I can get a patch for this as well, I think it will be clarifying to
remove this cruft.

Thanks
Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
