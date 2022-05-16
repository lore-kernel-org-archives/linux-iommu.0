Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7956C433FE
	for <iommu@archiver.kernel.org>; Mon, 16 May 2022 13:57:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8215182538;
	Mon, 16 May 2022 13:57:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NeIHxQ0WWvFM; Mon, 16 May 2022 13:57:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 417C081D9F;
	Mon, 16 May 2022 13:57:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17C75C0039;
	Mon, 16 May 2022 13:57:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 632EDC002D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 13:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D4F34160D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 13:57:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 18OTRr9BavoN for <iommu@lists.linux-foundation.org>;
 Mon, 16 May 2022 13:57:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::617])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C246941596
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 13:57:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3gEotI/TXuJAfA98sODQ70r81ieEvZdeido2l86JzzCoyr3Sc75m0VLTCAETV2xgoDLD+dydsB2CRJ2AbL07CvnAZyKm5ETbDQx1WFkIDuQ1xi/XvLm/4xIvwzo1Ja+GLJN5oXdTO8ZTThGYl0Qpm5jwtp/r8jOp+jQhBXgVriSN/V9eIZ+NAbPmuhnd8EFp1SBraVNKeFnSZ9W9dW1W21K02V4qnkKOZx5vUReLj07D4XydPdTq9TA1e9R2o/RZ1BQOiZ0FcxbBwcI1gTDUE/U5imneEyRPmXw4ZYfWkItjLCI9mD7AqfU9UsE2gT1EAAiKOdmttQHAcxD97Z4zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyzbf5Srst20Ph1P7tvjZjUvTeGnczC8+FU3A+VB69g=;
 b=Ef3Z2XiOEY44JwFoAW46L3LjZKsJ5IgbPkFzjawwAq37gss71zzdf0ay4Yj+P234BUQ2+LVSuXAjl1U0N4Rnj3QcXyBJtFZtv80JC8LD3/1KslhZR54BpMCogKIlAFIUcWUuHiMOZFa3SWWKUQrUAvOBQxb58+i5uFrxdc1Ub+sdsqzCA8Ssf2Q7xMxA/RKRS0Sm1zVJV5C5roTvzMClCRpa3ei1V42kQ67BdXSMZoXqlFp7GSX1oB93ip67DLm/6BCXuPVmkH1CMzVWvtZ7a7q4iNDAsSgWrSJCO+iMy3Qv5icSl4oMZdyr0vR4qPdbVhPGATRSFboGG3QD/ojgWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyzbf5Srst20Ph1P7tvjZjUvTeGnczC8+FU3A+VB69g=;
 b=XxD/DGNJ/Ri7QEtaemPbHDikLiFrNduqxz9wzgFKaiTLT20hrpk49xF95AIc9BHJjAgFkBAWniZr6LjTulMLq/l39HDffhrneTDT317/bXBRxLO0qHQeW23fyD1+zKnnnfGXreeKOVdjkNdzGlgwlm13GbOqc9JkdyhA0tyz6b8rEKYsWCbOl7pKvCOO4Tqlx9H5IP5M314Vi1rQq87aGdis+lxjw4l2DjQW4/EY2WJOa7BZkZ0rpx4U0kyZTQAwbNDbFwXMYY7mQEtnhnShMkehwqDOsxnMHJ+32qyMoQcvi5pFixMVHSQO1ZMxYAcvQ+1seF4Jpshe5PTr/ha5/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB2839.namprd12.prod.outlook.com (2603:10b6:a03:72::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Mon, 16 May
 2022 13:57:43 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 13:57:42 +0000
Date: Mon, 16 May 2022 10:57:41 -0300
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/5] iommu: Add blocking_domain_ops field in iommu_ops
Message-ID: <20220516135741.GV1343366@nvidia.com>
References: <20220516015759.2952771-1-baolu.lu@linux.intel.com>
 <20220516015759.2952771-3-baolu.lu@linux.intel.com>
 <8a0fc6cf-f46e-f17e-2b76-099ada1683c3@arm.com>
Content-Disposition: inline
In-Reply-To: <8a0fc6cf-f46e-f17e-2b76-099ada1683c3@arm.com>
X-ClientProxiedBy: MN2PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:208:236::14) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79d89509-280f-4e2f-f990-08da37440c18
X-MS-TrafficTypeDiagnostic: BYAPR12MB2839:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB28394CB65834C923D03BBC35C2CF9@BYAPR12MB2839.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hj7nZMZ5XMoWpcZr2MmIyjJxVeLXqES282XFAX72aRxF55/dsNilYWwxiXljiYxkKkzk2866/5lfo7b423jXBOSQRUgy4223WSOcrgiqPWfxtF3Sy2vM8vn+RW5nsoiTWxUQkK6gBHTh0/Z9qrHlac0cKbAUbDmYRQfMLfl7ZeeAbQk4xVxawx1vbAK7DmqdyaO7ivzhoE97HpXVSccmlR3JzzwdBkmuUK8OoF/x5p79xMfLCIdzxhxDYahVLEDnhEtSNWeha4Ay0RYE2R6fzNzq5ljCyOWb16dI862UMiAMuyyb9twczVoHsVTt02ZrFTVrMkLSL8ZiMjILyaQVXOCv7WhfZB2d4vuIkI8Vlu2+Bmh1gj87ncbVDRj2K7ESg0mOtoVt1fXb0FdGRlH+OMNfjz6HA6CMI1dgI2qGTtI2hSYEUxaYuruvS6BSmXw11I1FaezG8ebyT5DJJynL5CCj7izCw2yUcvVcvHuQxyPJXqB0CF+Uvjti39AGLksGEOVp8gvNbEZWgdsR2l8mbaKCjCoL5tmievHANgWCQ8twMsqdKBB84/T64yBMXZ1RKKs64YLQjii/cTPmAlVeKsEZQPgt/U1QZozghXsLvAn4O/GEi8eA/bQDe6bnKHI2a/Flnd9kwnofym2NHakYQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(6916009)(36756003)(86362001)(8676002)(66476007)(4326008)(53546011)(66946007)(66556008)(54906003)(33656002)(6506007)(1076003)(316002)(26005)(5660300002)(508600001)(2616005)(6512007)(38100700002)(7416002)(2906002)(6486002)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SFSmsdRuXsnKV7GnL3Kz0IamvxHofmDar0tK8uNQX35sUvM7acJb0DSNHBAk?=
 =?us-ascii?Q?fsRIwDKitfz6Vxk7RUnbTYLUy5e6rBGuKlqGRSh/m8VYm99CKTCMPPHu/aA+?=
 =?us-ascii?Q?TqTMMk727U3KBzL8ANqGWbU7nDcE+CLeOEoWSUk+IYLwavCIIlmU59876mVa?=
 =?us-ascii?Q?tlKbHtVgJcGfIb+TKQ83AzbTJqJCtMWRxLsCSAPb2bwIYCrP4mNVqT8n5iBX?=
 =?us-ascii?Q?zmxz4L9t2jNGYMmkbdbu4RjoOCiDtDE+Vg2/A3v6KIWS/hnBtdidfV3Go3f0?=
 =?us-ascii?Q?if4S4B3fNDEgpan+46Zrppm4oWptMUa/p/15Y0KdR8DkD9q4gcMso5MuAe/x?=
 =?us-ascii?Q?U6z4pZsBpiKuP5sNDpNDCPcrBQEewTBOcbFfPKwBN3YvZLlDwzPSZv6LjJOj?=
 =?us-ascii?Q?mZPpjKNc60f/40WcHPHVRyBakHTYFl3cgbPDXQD1/ZoZ/rOzSrSln2XZwcYy?=
 =?us-ascii?Q?6FjlHtT+6YzUAAym+O1hIpwMlozJudPAixHQrJ+N2zyDBy+nCwjSlI+XV59r?=
 =?us-ascii?Q?bRVH1yOt92gUdDIdVSnfeLXZW9kENykD2wzy9359cmdKjKo3i+kUtCQLFUK+?=
 =?us-ascii?Q?5O+uCj9v1vk+2hUWyYMco+Fz6fjuNNVIQoyF4UtQTKbbQv3mZhAGLw1+1ZYg?=
 =?us-ascii?Q?lNfxHYRJa3Yq+D/H7Lxy3Uk59dsmXw//vmvxUKjClL8BSzD9DO/rty9vh/Yk?=
 =?us-ascii?Q?pSup+vS2XHl13aQsBn3DOdENuiSphr2fkUh4KjC0kVG3322NwdDVwnkAkNMf?=
 =?us-ascii?Q?vZS1QolrIVMmu5c98hQhK7y+er8C7Axh2kAW3B7bgkthLd62dlu3D3MvsnFR?=
 =?us-ascii?Q?1dX61t+Pb+erjE2rXn+rlj06/pY73iWV1866cZFvGbFMaZb1/TIpnkOVvN02?=
 =?us-ascii?Q?FJRdbULP/G/ZpJvej5q1ypUqqjQIpRAR3Bv82YH2BFOWOnljH/SXfmuC5Kft?=
 =?us-ascii?Q?k9mJEdG0EYYag6jfVQRxK39LsZwEMWX2W5X4p4wKejenWSc1r58SzaXvGPPC?=
 =?us-ascii?Q?QnnUnwdH55yBRnEt4HxupwR1lCP1Pp0FIgle1tojUKxV5KAxd+xWlMvyIM9y?=
 =?us-ascii?Q?RFY0rfe8VUMLjrrkT5blvD6zwmi7ku5K60OXRgTuxJlZixdnBNLXUgEinLys?=
 =?us-ascii?Q?3kUasciw20AzkH15Cn2/I4n3ATEZ2pq482X7/x1DTq0opamLNDEseCxvKLLE?=
 =?us-ascii?Q?WZJH4RIwQcRSHOHNXOpYPss0nWRIp8kxs2zZqbed9FxRYZUqDd+1g9ESXQu6?=
 =?us-ascii?Q?RKl8jEgyOQ4LD6gbXBdG4njdKWZzZsFvKzwBZKxM2z1hioqiiG0OA3YQha80?=
 =?us-ascii?Q?GyG7LolwuSDR8gBfTjnQGdrx0t9WeLryaaLWLk4CVOB0chHYK8JFBYeii9E7?=
 =?us-ascii?Q?K6A4tkWlVUYSss4MGSMgT/m6EKJRaqyXvjb41W/w2+1/rX/P8giz2XF2keZq?=
 =?us-ascii?Q?X822u/tich8fPb2peVL0ax9enb/gCbBO/Hu9ivrYeTqVLATdpehaR1/ItI4i?=
 =?us-ascii?Q?SOyBTZ2pl29D66Bm5Q4RJHXogLPupv4aDzEN9QRSZFaHaoSZh9vmGx1z3wE5?=
 =?us-ascii?Q?0qqB+4XsIhGCvKxmP0ufgWnJ/Vhes9dqsqXkQZZqSH2D8j2XjtCywTuADT65?=
 =?us-ascii?Q?KpDEd9AzHAq7TQuwx98kDFHZzg5FSHTQrMTQDPKmFHbhW3FEQ1oh3N0gxBBq?=
 =?us-ascii?Q?ZPSpDIG4XLtk9SEcMjEkvqIo2czqJpGmgSPHTa6D+uZ1as0Ft1S5x9luIW4k?=
 =?us-ascii?Q?qluheJCEAQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d89509-280f-4e2f-f990-08da37440c18
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 13:57:42.8488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPaAnEXXN4yMi4aLeM1IZH1BwU31hSPlhbis3OYspc400GtCb/H86gAm5nGKLc6Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2839
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Will Deacon <will@kernel.org>
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

On Mon, May 16, 2022 at 12:22:08PM +0100, Robin Murphy wrote:
> On 2022-05-16 02:57, Lu Baolu wrote:
> > Each IOMMU driver must provide a blocking domain ops. If the hardware
> > supports detaching domain from device, setting blocking domain equals
> > detaching the existing domain from the deivce. Otherwise, an UNMANAGED
> > domain without any mapping will be used instead.
> 
> Unfortunately that's backwards - most of the implementations of .detach_dev
> are disabling translation entirely, meaning the device ends up effectively
> in passthrough rather than blocked.

Ideally we'd convert the detach_dev of every driver into either
a blocking or identity domain. The trick is knowing which is which..

Guessing going down the list:
 apple dart - blocking, detach_dev calls apple_dart_hw_disable_dma() same as
              IOMMU_DOMAIN_BLOCKED
	      [I wonder if this drive ris wrong in other ways though because
               I dont see a remove_streams in attach_dev]
 exynos - this seems to disable the 'sysmmu' so I'm guessing this is
          identity
 iommu-vmsa - Comment says 'disable mmu translaction' so I'm guessing
              this is idenity
 mkt_v1 - Code looks similar to mkt, which is probably identity.
 rkt - No idea
 sprd - No idea
 sun50i - This driver confusingly treats identity the same as
          unmanaged, seems wrong, no idea.
 amd - Not sure, clear_dte_entry() seems to set translation on but points
       the PTE to 0 ? Based on the spec table 8 I would have expected
       TV to be clear which would be blocking. Maybe a bug??
 arm smmu qcomm - not sure
 intel - blocking

These doesn't support default domains, so detach_dev should return 
back to DMA API ownership, which is either identity or something weird:
 fsl_pamu - identity due to the PPC use of dma direct
 msm
 mkt
 omap
 s390 - platform DMA ops
 terga-gart - Usually something called a GART would be 0 length once
              disabled, guessing blocking?
 tegra-smmu

So, the approach here should be to go driver by driver and convert
detach_dev to either identity, blocking or just delete it entirely,
excluding the above 7 that don't support default domains. And get acks
from the driver owners.

> Conversely, at least arm-smmu and arm-smmu-v3 could implement
> IOMMU_DOMAIN_BLOCKED properly with fault-type S2CRs and STEs
> respectively, it just needs a bit of wiring up.

Given that vfio now uses them it seems worthwhile to do..

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
