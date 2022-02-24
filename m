Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE66C433EF
	for <iommu@archiver.kernel.org>; Thu, 24 Feb 2022 13:01:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 155A64014A;
	Thu, 24 Feb 2022 13:01:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YuHLhfsG_zDD; Thu, 24 Feb 2022 13:01:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 90A4C40122;
	Thu, 24 Feb 2022 13:01:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56E03C001A;
	Thu, 24 Feb 2022 13:01:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7810C0011
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 13:01:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A4BFD40141
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 13:01:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7upKSO2Ezplm for <iommu@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 13:01:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::628])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A5A2A40122
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 13:01:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNMXPdni2PeF0U9A+QpLqi0oifWAlrw9p/qF2wEHpDtUZqNMUS9+K76e2kLg7p5ECv2SeaMhGVTKtNWOnFoagJgUuqFoO4CHcXRfguya2zyw03GevA4FJn/YS2sfT5ij1OmFTleoIz4HnBrIIsVQ4pNp3zSfOWVhqFdKPVmOM7/wPpJ/pNSE9DuTQvBbs4rsDGFRrUFQXx762wY6lbvQO7KWorjcTgoY7ft5Ir3c38H1W11zqLkZG2UWsM3yDy3nDHljSn0Z2jT25gUrfBZDzzV4gAtQWu4OThK0j5TSeksY6p73m27dKtZmENa5Ep4l2PNBaCMn1b4KrVVC5PSYMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxg+kJisE0gnERB6XhncONJnNuz+Bl0HwV+3i1jiGDA=;
 b=JKrqgt0RU2DpBzpsAnQLThg0aganQ+E5A8rw5URnyCtdVMgidSn/B9pk/Fd1voz9581ALSFGSOs/flX/vxjmn1D8EWk7d5mtwcA914PvbA+2qHW5uwOGM8Ek/HEv4sRYbiKmOnjte1vFa2S7wV+JnWOAbUZQrCh09c8GJXstmTmGaa26F7lJMCKPcmsq/OdgecyKrIIiiRc8IxXCSNDotaOwkjmABTqWlktHnv1Z95B5SBrRD4X4O7IhcZIStaCZb/vpI2ntZg/OMSLzhQLgo/d442tEHNdF466I2cVMryI6VS63uj7xrde9lOzlEPnApOn+znobQdaphFMt9FVrEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxg+kJisE0gnERB6XhncONJnNuz+Bl0HwV+3i1jiGDA=;
 b=N85k4uHur3AG51W5x3QYON7X7ONtxtbWYQGR7a/0s/na6VbNp7fkWFAs9Bq7NXcXJL4ZKPYdD5idQiHHeiBvvC5WT8cdXbNPv8esx8r/bg0vAXeiqtMcISVq1MQ7WeYfKAJkw00zPyQhTsGYzFU/JGJa65OSCQ7UkJnvMgTYbObDsyPM3+0jHSkhHZBifo93jNL0qsunGojcUeBL80O7jfxejXJTCsgix0ezX+E8AjanPBwXV8bPxGIqvdNn75HdwvosGSkc+pMKt/Nx9rXy1I25LInyktpa+Sl9QFEWQ9IQ+8laQXGqxztubtObapMA6VQIpK5/JM3al1LUv+/kWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by MW2PR12MB2364.namprd12.prod.outlook.com (2603:10b6:907:b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 13:01:11 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba%3]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 13:01:11 +0000
Date: Thu, 24 Feb 2022 09:01:10 -0400
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 04/11] iommu/vt-d: Remove domain and devinfo mempool
Message-ID: <20220224130110.GG6413@nvidia.com>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
 <20220214025704.3184654-5-baolu.lu@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <20220214025704.3184654-5-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR11CA0020.namprd11.prod.outlook.com
 (2603:10b6:208:23b::25) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 965c8d91-b4fd-4a61-067d-08d9f795bb60
X-MS-TrafficTypeDiagnostic: MW2PR12MB2364:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB23643C60B3A23981F440CA6DC23D9@MW2PR12MB2364.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B2x2zbd3bGdJQIBRih9VZnPywdA5m39SQZrgj3K/cGPDMv4XKHjTYNZhJcGlevitML+fadFrDNYvbtFBYftLRuvZcV2wwsiO5NToJ4/CC81F9ON8YGvDCDvpuKLrdb22MMS44uuG1ZZ8xh9zu4038kvIupuzXNZgUnjVvbAoDZScU/gL1r9QnpP/CcndVdE9CsdDRK6j8znY5yDNJiPJJUEkSapR92kr/lygwpaOy+uhNow/37GC7lSq9k6U+cOZ/NWvBeQ+8W7pY957RoRYsVSXVolRxKSbxVZu28e34iypn76zoncESAadVt9ZDQE93Y9NDgTX31RmDSVjZaYDKE4rcV1s5BgO8VfFryKK5sptdtIxFI8jRCbgLD3A+oKogbDfBJ8VCPRlW1ZJ55jSdyiz9gxDFCbfkYQ7hA7Wc4EEqg3Z+JioZleZVquk19kvmstIk8UfSv1LS+zDtH/N53svv79J3ygzBxRgcHuOmP3/E0aV1rgSFkk7PY06synfi2uVBRgx0Yt0zww8NFGkV3QAQXvtqnuIeLx62ZAv2SqlTk/vvMW5tbMN1spVh/mE4xGOQkBK2eLX1/dLkTctRTjeP8dDq21wWPw2tNB9kEwD3pRLFyZlTRQdcc1QxEzsZ2CWNpWzx/hmvutTstp/Yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(4744005)(33656002)(6512007)(54906003)(86362001)(7416002)(6506007)(316002)(2906002)(508600001)(6916009)(6486002)(186003)(38100700002)(2616005)(26005)(83380400001)(66946007)(66556008)(4326008)(36756003)(5660300002)(8676002)(66476007)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SYP6xNhv8HNZDv6PyBT3F18A2MgciczurGJT42xOSbkb3Gpgx6Nroid6xQnc?=
 =?us-ascii?Q?1rh5XzL/inf2eldP+YtLpRK4WAu4WYGauxJXlOsH9qT+Xeau/vCFEn8X/uD4?=
 =?us-ascii?Q?HG3aH6ekcXNOeVCcmNYvwdMe2RR7TiGqNnKtQY1xC6N34XZJSXbdNHH8Mexo?=
 =?us-ascii?Q?MkyUbQQSlyHiqz0R619pcfq3EwH//W2e+0D5gV1GM2Yaqd2pw5QaQKtC3pEV?=
 =?us-ascii?Q?X54qc60g1mg7eEE7+dEFc59/Vd1YuVfV7ZlXLfT/lVZRQ4UMrYSEOYExh0Eb?=
 =?us-ascii?Q?JkHmlTRiPNYBAwh7mOAttQF3/stPCS9WCIjO4O3ngbiP3jxY8liC3bUiSnt5?=
 =?us-ascii?Q?yl7D60XdX2fkuT2H0zHZb1QZdUltuMpPHKUX+HX3M4dDXJXqqgGEgQiZFn07?=
 =?us-ascii?Q?a9YoB57IkOJd14rvCDvUlQbFzQbHLGqwfYqctnhBzwU98X1C6w4UDTnEDn4d?=
 =?us-ascii?Q?rVDePQjOVMcaFaduOW7KQcxXPnC0I1n3xTOB1Ji2Vlispj2JV1lV2fR/i5lA?=
 =?us-ascii?Q?WXX5/w2sSRsYJKzJOVfEzWucNHaWM1EeYJiy0sip4BkCR6goHfgUB14GHUsq?=
 =?us-ascii?Q?mFcARfmmMSGxBGU/SemNEZ6dhA4fQ92U6bzwHnLF2kTQlMinnEzDcgAP1sj4?=
 =?us-ascii?Q?GXNuiSSDD6PRaaoHeidSt4786doiiN429DusTyBo0BVKa2IZITPwoa7kaoCN?=
 =?us-ascii?Q?T6Ktuqis8fg7ebHxqIhB24xLyaZ4v4vrK39wMvtEW7kPBXAaEIAGD3YjQ6Ky?=
 =?us-ascii?Q?nAa7cy8+6L/joazo5zOk+6JGR+v8oQMZR61SPpc6MvhEOWaGpnf2udfh8aso?=
 =?us-ascii?Q?auhl0mkihG+DQwZFOzKFFNVy3L004MAyUt7UWEjVthlsWx05lZxeFEEIekYV?=
 =?us-ascii?Q?Z6EuATphZuH4/6xH/udB2NKmMwlNxMix3pgSGP11aLtZbojklbdh9rVgNvsA?=
 =?us-ascii?Q?jDKqn4zjf58W9AuBWlnv1FyFvuMDPCst3rwLjjuOHxw8tje+VXqDLEE75ie+?=
 =?us-ascii?Q?C2ceRAJ/hvdWLbMV6od/5Y4XdAK0oEcxVLXPSbfZsUlWMrV6gTeO3PU9Aiqt?=
 =?us-ascii?Q?g/YOYq225/hEU8Iryy0eQemPYc4Q2rKrRPcg+S4KWUy6Zli8y3uQU1Ek53Bv?=
 =?us-ascii?Q?0GxBj2VTRKbL3ROVvarYamJE+M651D6+HTnafYmcx/+eRF8NoLx4PmcWe0hU?=
 =?us-ascii?Q?ZPfqPmXKASqEUn8vNCLPqQbuhW5FIFF5q41IQxXKRfpOl4wCwEl+ekFPZ7VY?=
 =?us-ascii?Q?IepmcqAw+9JHkpTRl3vM3LRmfzmoSY77dhD7J4D73Aultp4IsIf4+FytqB/e?=
 =?us-ascii?Q?cUOydc6C1g2cQ9Lu8lHv2OcPgSRCkQ2HRLay+NiyDuQRuSHaNAOKuWnU5wlb?=
 =?us-ascii?Q?YuttnhaEI9NH6tA4txHKh4OdQyVQXIAvS1M8hG84qHjPjErn4QpV66NwvnzU?=
 =?us-ascii?Q?/oKxirxUBL3V0bWTTeynq3wvLUqRtm+FhTKm7CoiKXqbgUTjqiGVtSHFEKZS?=
 =?us-ascii?Q?Mo6EbHshuuxZWow90YntX5mlUJpUhq974GERKG4laghWEQwsc5difwgT1YyH?=
 =?us-ascii?Q?AvGKI1upYVsEinY+2q4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 965c8d91-b4fd-4a61-067d-08d9f795bb60
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 13:01:11.6549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZyKSiCnfm0pYPEMYEvcrG8hd7sCLCZtKapoUmVKofF1GdRukqhhZ8Ee2Mq5bJYG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2364
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Mon, Feb 14, 2022 at 10:56:57AM +0800, Lu Baolu wrote:
> The domain and devinfo memory blocks are only allocated during device
> probe and released during remove. There's no hot-path context, hence
> no need for memory pools.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/iommu/intel/iommu.c | 104 ++----------------------------------
>  1 file changed, 5 insertions(+), 99 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
