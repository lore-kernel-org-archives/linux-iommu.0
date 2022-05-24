Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7E4C433FE
	for <iommu@archiver.kernel.org>; Tue, 24 May 2022 13:38:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DEF1B60A8B;
	Tue, 24 May 2022 13:38:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eaLrfVujlSHE; Tue, 24 May 2022 13:38:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 962C360EBF;
	Tue, 24 May 2022 13:38:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 775CEC0039;
	Tue, 24 May 2022 13:38:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3830C002D
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 13:38:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ACC8860EF2
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 13:38:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id glvNuntwNgU0 for <iommu@lists.linux-foundation.org>;
 Tue, 24 May 2022 13:38:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::602])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6E6E260EBF
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 13:38:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGEck5x2FDCEhoAhYOaIpEjZP8bYHNPIoVh1hXLEsmYkl6yNGUeP3RGszIdr0Bp7qp+8uk3OtjzBenvO3I0G0qcoy/ZRlE/Aq7ZsEjQghD2VFf/2/vLIL/V3PIum3/unZWvh2Y/8vB3BiEQQ3bXitkNq1CYRrn1n3QUDAsnIc71apVmAi8Oy3Pm3WcZ6fALLwBKERLER9Xwy1Na5oNPqRWbZXSe+ezjeNLuIHp8vMno86loGHCr8C9G6wXVyhmkzlIdUlUsUiNoodMTWXnoey64s2f2C1dgch7XIaBCbrBXH0MEFPy8sX2bAo/4DP5qm7OwTFJ/WEwcuUy9cYileQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEGQWmjdgORBiQUUcg0CPAJmLgcuS5SHhuGF720v9I0=;
 b=IAuvsQcP1FpXlelgNyz0lCJeTVFCfuMncnYw2+n3WPmI3yKHydd3NnesFS4oRJhYKocbg8sbGOvpv386RyHqgx8pnpkg0ioiShRzDs4QodA9iBtf4WNS4ZYnHDn53h8q4n20jk/AiZR+PC+qoRxC/TSYfwhlJM7yKOp2+DqcpUjh9PA4EY68YdBqlti5n1rGHI6SPbK5bf+JWlw1qRXTS2SQbX0LHUvD4lRAh+FM4Gvzlhh4EPCncZReBNXtEzHJ1MAStaCzdRyU1CwIoRIxu++Jbn5jmCuoYjy5rZTRgtIecFTKVobqhNTKBBjS49A/tMTcuC4BF72JwtySZJ94Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEGQWmjdgORBiQUUcg0CPAJmLgcuS5SHhuGF720v9I0=;
 b=NjvZyGMP0sYFF8d+K1WT5Ulo7IhrddbILuChWSaadDCLNkQIh8D82rQ2tqHwewPbhVy5Onxwqnd2x/3z/fL+f4cokT44saoWB2p8b9DElGpQ0uTo3DnB9Kh4lUrgPPoOBcM/f8UEXx20x+jB+zKU2QziItgQQQzfHth7ns9ZKKJjGFbFhK4I7yLA1V2O9A82sCJWR7qelKYdvmqVhX3y4jLwguR+NUTq2s1mEseZctQy8IQxkiO1qUo9Ksr+2+Ng34ZEKxbfRK8TUFcdq9HYtrvsbYQl+vO2y6Qhk5UHISJJEj6pLeyjBhK26OW7vNHCb3PzWTN+rF0BYxMcoX0wvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR12MB2438.namprd12.prod.outlook.com (2603:10b6:4:b5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Tue, 24 May
 2022 13:38:41 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 13:38:40 +0000
Date: Tue, 24 May 2022 10:38:39 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Message-ID: <20220524133839.GS1343366@nvidia.com>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
 <BN9PR11MB5276982C37DFF0FEFC45BDD68CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276982C37DFF0FEFC45BDD68CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR22CA0003.namprd22.prod.outlook.com
 (2603:10b6:208:238::8) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c06cc69f-9952-46d2-d87a-08da3d8ab6cd
X-MS-TrafficTypeDiagnostic: DM5PR12MB2438:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2438337B7FF44B2756233B9BC2D79@DM5PR12MB2438.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CbCCvk39C0GlEsSEyubfI3EqKEcOpOknU06IiWEn1ueT+UCvF0OmnN4gaQbdihpxH6P6R9+L+orIjNGOZZqThiLjtWrGm4w1HZcqw0uT0mwpY+GSRSCHxhqojJjb/w+SI0bv3eBjElEZhzu/MV8l3092J9RTiECbgIyS1N5bBB3L9ROS9iT2wcsrNCap17//xPkub9wh1NIMTLZAaCrpEn2nrbrBe1/jLniydS5msyhRKQgg1moOXlDpubU0sQGfaLpjv4lsXb6d9AAUuilhnbs8wMVrdSOJ3WhiAFL61Rjo7WVW8Sb5qa1vdRJDnqj7KonHqHr7+sAdp5nM0dPAzI3qeWs06VgSZHfmyK93B1Bt7yiCL4mlpzF5y0UswaK13E3S2lYopDwDxQm8OCrGH4lw+4H/OMMl/h4FJJD+SCRzyYSjWQGtWQFTlIk2p5nst7sMgQhsef7PfwB4GTQoAR1YSp3fHODOKjK8lwy3pg/WiaHf0WiegNej7cgSiyfQIhKt1VSJYAa0OUcZZPYwgLeo2OqirUytRGLCfqWQBKczpiZHyGR5z9isZdfrHtUqDYpeR7we3EHva6mqfPDx33iWRbqHe+V629s3ruK4lNChXeNecQmf5vu912SVkxijeKunR3PftvJRGvg2pXeYoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(316002)(66946007)(54906003)(66556008)(33656002)(38100700002)(2616005)(6916009)(66476007)(6486002)(186003)(1076003)(6512007)(26005)(6506007)(8676002)(7416002)(36756003)(8936002)(86362001)(83380400001)(508600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2QsxhHaBdKBPTwR9sESsZJC8nVn452LUjnKgAMWr3RLE8dg1rAo3IJaJvvXP?=
 =?us-ascii?Q?DevS4VoJyApieGSq189l6Nio0jf6TqQQ3mF8byiLREQxDiULvAphb9kIzA3F?=
 =?us-ascii?Q?EMwos0xutpKq+8YP+a7Iyd59+qtT+4HrlCXNIOR1CuA2unHAQD1i//DVhkAE?=
 =?us-ascii?Q?UrSoXzW1cN39e1+yxuqc4Gs/NqPWJkxN7yxnwMDQZEruxbfRpK5wNDfz9kFW?=
 =?us-ascii?Q?9nkWsbEfQJ+znJ2ijE/iB0f9ozmSiNa9EYhyS9C1Eye6pNVzeAs8NYrXeu8D?=
 =?us-ascii?Q?EYFXuMFF7CxAxVTUnltjp/KHVMJGNabsskfENwSFNtl0quxXjldrb+i19kcx?=
 =?us-ascii?Q?WMLOdcWCe5k0C7Ih4BvdW3V7Eii7pTghRvTtksICCLNHYy6dyMkR88kk+gma?=
 =?us-ascii?Q?8DDsTKOQ7PYgp0pYE8vMwUyPnBGL7mtp9OLL8XYneZKguozgPu7WB0VnP44h?=
 =?us-ascii?Q?zhYQtFqpciWRGZvVlCBALCX5Zt1naLemKbdIQ/injCBx8W3muIFGLP5nzxy6?=
 =?us-ascii?Q?3gytYzAs7TEBcJhhDLJOnorwpgtonpGSS1GFRl17WJP7rmPfMUbdW6+/NIIH?=
 =?us-ascii?Q?YQ1PwM0KpSnwJ69TugCTKdGGaMkuO5qNSp/Ace+/cuPu0ygLgQNbJbVDtU+y?=
 =?us-ascii?Q?RfANHl5ZkFyIqnqCZ0jHU70ktyAhoKSlxHzka2x15VxfSwdhh6Mq5HN6psA2?=
 =?us-ascii?Q?hedVeDfPCJcjJH9cY/jNFCXFgOi34DHTRvIzQH8HeTqJR4i5kXV1xeEaPe2d?=
 =?us-ascii?Q?J6z+8VW4KivsOijTmNFsq5il2sfExLFO0acfgjEbEkChQQKYS5IKi6MCkqob?=
 =?us-ascii?Q?iI8IkeULImKxqoUqoxQTnNC+EWTfV3U+YmKCkaN0v3/rRyqTkPDCv8MMubi3?=
 =?us-ascii?Q?tHBs3/NqHLTQqV7sDJGMvbeupgZrlQ0JVh8EzK2R/IEbdEqKGN4e6Xcoovnu?=
 =?us-ascii?Q?unQ/fTmoI5omXp0vIB9j01/vCECl/M+lVTbdELccShMjp3TcV/kh1qtT52I+?=
 =?us-ascii?Q?3HJodujSLQsbkUn6dHuV+KexgSFrNfginaeSqDffwWK350zLyW3QWyGhpX9f?=
 =?us-ascii?Q?jOPIRNMYunCEA6hs3WcN6QvGg5fdJLE/eUG4sPDFELD8N5HIS2uddqmanNpP?=
 =?us-ascii?Q?raZK2xegS6Ed4CinrN3ZfV4sY3Ne5OsaT1q43bvPMWcRpJjStJWo4txmwVdo?=
 =?us-ascii?Q?+GCoMf4mv7nMrET9ugRENfKdGFl0X+WWqnhS9yHFlND6a0hdqsUcKtIcqVzP?=
 =?us-ascii?Q?Z2DkG+8JggUZo79Nbuwnw/yv5LlFXmRcxVfxYfLyI8aTLdcfoj/ZByq3yu+u?=
 =?us-ascii?Q?lGpQ7WrhBZO2UIL+VWdjqAgZ6JVaguQ+KR0OTrGNKaWwqxUh/WWr4RDLyaVj?=
 =?us-ascii?Q?eCQqJcIIJgAbeDtheQ19FWRO2T5dLCVhtwQxRn3H4kGbgOtLDsRMqrtIhx5c?=
 =?us-ascii?Q?tgLNJHRZ927xyosSMk+r5wnaVUkfA3DOAeVLpXMbukEoqZ3KNvOgzYXLaUSF?=
 =?us-ascii?Q?ihJoRBMBg0bYiytA0o2yXP2vlUxK0TNs0Q9NUUFhk8nyUOECYlzANI80FYDB?=
 =?us-ascii?Q?rKUl6/7Ws5mUWO8MnVhfMEnh24OiR1lKONGnSoZgzbZIpx2UYA35Podliipp?=
 =?us-ascii?Q?mNqqFK8Lgg9DlAGSnN2+LKlorR+vPEvA6z5Mh/0Vd+U3v+rxlCvSwneHOzHI?=
 =?us-ascii?Q?9rgXLzWJFmBXGGoFNpe99ONdIbHrZ+JlOUyHqoXuXDu+DhfQw6sRymPSb4cg?=
 =?us-ascii?Q?daOlVGaipA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c06cc69f-9952-46d2-d87a-08da3d8ab6cd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 13:38:40.9164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phH/bdk3jj6gQ1J2aPf64kkhBe7t1SP+EGhuPWW57dNzAQ5KGvlKq6Hu64TXGUh0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2438
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
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

On Tue, May 24, 2022 at 09:39:52AM +0000, Tian, Kevin wrote:
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > Sent: Thursday, May 19, 2022 3:21 PM
> > 
> > The iommu_sva_domain represents a hardware pagetable that the IOMMU
> > hardware could use for SVA translation. This adds some infrastructure
> > to support SVA domain in the iommu common layer. It includes:
> > 
> > - Add a new struct iommu_sva_domain and new IOMMU_DOMAIN_SVA
> > domain
> >   type.
> > - Add a new domain ops pointer in iommu_ops. The IOMMU drivers that
> >   support SVA should provide the callbacks.
> > - Add helpers to allocate and free an SVA domain.
> > - Add helpers to set an SVA domain to a device and the reverse
> >   operation.
> > 
> > Some buses, like PCI, route packets without considering the PASID value.
> > Thus a DMA target address with PASID might be treated as P2P if the
> > address falls into the MMIO BAR of other devices in the group. To make
> > things simple, the attach/detach interfaces only apply to devices
> > belonging to the singleton groups, and the singleton is immutable in
> > fabric i.e. not affected by hotplug.
> > 
> > The iommu_set/block_device_pasid() can be used for other purposes,
> > such as kernel DMA with pasid, mediation device, etc. Hence, it is put
> > in the iommu.c.
> 
> usually we have 'set/clear' pair or 'allow/block'. Having 'set' paired
> with 'block' doesn't read very clearly.

I thought we agreed we'd use the blocking domain for this? Why did it
go back to an op?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
