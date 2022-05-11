Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47958C433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 11:54:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E5B7D4184B;
	Wed, 11 May 2022 11:54:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WOFL6aRkR8Ps; Wed, 11 May 2022 11:54:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 45EF241832;
	Wed, 11 May 2022 11:54:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9BDAC0032;
	Wed, 11 May 2022 11:54:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB1C3C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 11:54:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A45E38328E
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 11:54:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zSGuV75DeNSG for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 11:54:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::61c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E8AA783279
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 11:54:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrUCAmgzJfSBA8zbSpl+lXBu1Qu3c2vZ1u1OEu3Au1yJCfu5raMVeUSHAl15AHU/5iZNnbRUvO1A6A2WKd+icoKWIAAf8HEOvZpQ3WhYzBXuuF4VwWUGP3fIADIiSW7DI27ALGZsflIIZxZVLwMCDbcXP6qoYXFyhlqDTRniQ4egZQVSBKlAEklSTl8yAvFw5i2dRyJgwYjwaBjG11c/hA/nAZ6UocKyu4wpQ+D9xsSzwwTNvwaeERF3iV/x8HlKdc6jQ9a/EoxB8jABN+5H0jgCmvAt8Mf9G8PawvfrUgfPBnt47zev/VPbD5657ajNC0TpINiypDm4ldsjSN10Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1geSO7qKDz2YpRmkoQy+DxDjcakFLPMogzipwPXhYBw=;
 b=eNcRPiFIfPyRZSMwQQ1Lpv+VDXeaQhTDXMauTGeczGvOq2k+LNWTIf3nZoLZlPM7OtBo00O2gwhLGrrTO72cCv201RrYP5WdhgYFHp9EIPXhPBJAHGn4crtBFh0AG9EUAKDudJWQxHDj9XyCpPp9VMvi3iDOdAU1lcyfPbeOB5CZn5LriXWzUdjF8HTXN3TRPsfwS/TeGxkkUCNXYdHGtjgIi8jMn2Dbduc3ryN1gFXKrI0q3jUoMuq6d0crO1gV/KmP7oRc4RoEsmHTj110vaFLTPmY/ugzuTBjibzhMcVsXW2OlmQ1+GzgFct73/tWF2uqQToeKkEv6/W7chaKgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1geSO7qKDz2YpRmkoQy+DxDjcakFLPMogzipwPXhYBw=;
 b=K3wjAEv4JKlbT3Uq51VX2J9XVOcR2kIW/2SZpaaziClnmvvjBvLqruiK5fTrhNjYM2yJlVAP2z2VUZ5Vr0RF0093mMhwEilmhXF9hb6YZJRMhe4vIhBnxGjEyjwFCBxObgQypx+4uvCeHzOW9hCKwUAlc5dCukbQiCsOD33kQegqygum03X5w4GpPjG7CyJbrwcDrmyG7AHV6CA0HFI8gIgXnpky3UMzJCZ7mc1XoesM//1ZEamwGrYWk08Fzg6WHW3usQ6JpDoYUq8RulvqwQpksLKd2e1JhTIsuzp12Jhfmhv5Ulp/lh5NCxTHjQUjK694RX8VxrKOcMCk6kYBrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB3287.namprd12.prod.outlook.com (2603:10b6:a03:131::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 11:54:29 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 11:54:29 +0000
Date: Wed, 11 May 2022 08:54:27 -0300
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v3 1/4] iommu/vt-d: Implement domain ops for
 attach_dev_pasid
Message-ID: <20220511115427.GU49344@nvidia.com>
References: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
 <20220510210704.3539577-2-jacob.jun.pan@linux.intel.com>
 <20220510232121.GP49344@nvidia.com>
 <20220510172309.3c4e7512@jacob-builder>
Content-Disposition: inline
In-Reply-To: <20220510172309.3c4e7512@jacob-builder>
X-ClientProxiedBy: MN2PR19CA0011.namprd19.prod.outlook.com
 (2603:10b6:208:178::24) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f01b4469-afb8-4dcf-0d6f-08da33450125
X-MS-TrafficTypeDiagnostic: BYAPR12MB3287:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB328779E705A14C287ECD7979C2C89@BYAPR12MB3287.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z5/WMTgJsxljveFZd6Ryy5AXtqu7gkJZLhzZR/KJB/UTIChvAsYbnYm2Tngamgw3nzyar+QYas/NxA63s9zwm64PhMm4wOTytO6BDsymFEkr/otUcRSe1Crt/ubNH2Bthr1fVtx/v+dFIUleY5H3IOMWsOGg01AdhoWzLUCtKcMSBo5v/OXFFm7S1GKtZRPls0avhE2MtWyNiSA7QrJX/oop6zWN1JAP+kkF4AxGTh+1RDUhBtGUKfuAwrYRs5MWW/I59nJrTmM54vkppxESl3xDVIDkI8JHlwtXItpkpn3Y7knfbzte6VqRZKZx/yiUTmme4OOO8BS6J4uflRnCFpv1ga8YhlxIehlvk62M4DqrVKxOVNInm9sMbaplY/Loqi3aRFQ7tpj9yypZ3qfPmNLhd7SQ0kRcGmZoVH1NmIgb/hhAFYud8HIW0hiv6Ds123GpjkXiKsAIW3EDhKPrAhnAHiwT/XP1mS8hSsT+80jNixg5wyolLEz49YMcfauv4kwM3nXDsOC+eIKEfuVm+rWwpou3eUDAytqwe+RVkROE2xsUbF4rsjDaOCB5PACsEiewx9Jm9q96/q9mKb8w2mxp30cb3WM3e9cQT7yjUIZhBk5mzhb0BTgWpvZ6NGk0eFf0DpA6DX2LdbscPBm40g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(6916009)(54906003)(38100700002)(83380400001)(186003)(1076003)(2616005)(8936002)(316002)(5660300002)(7416002)(66946007)(66476007)(66556008)(2906002)(6512007)(26005)(4326008)(8676002)(33656002)(6486002)(508600001)(36756003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5OvVKOUatu59D9q7isnP0l4O+BRgB9CRLOJbQrEI7f0jjykpBf3Fi4avPqBg?=
 =?us-ascii?Q?nbI/gPIuK2qINULxTvtfVjH+xJI1Vpx+p3/NQRD8KGZWHQY4+OiVilw8zzE8?=
 =?us-ascii?Q?5SPEhS6D+X8j3a6KMJAtam6yVRjRx8/lq6yIBazX3VhkL+i9TllxCtfwliwd?=
 =?us-ascii?Q?+0/PsARJQYT2hpzpv3t1oHNqnwgpYQrCxFDTXkzeld/cHJUnVrRUx/TBo859?=
 =?us-ascii?Q?2l55VaNzYfUI9kPQCIR9c8S/qYwvsAu6UFSl4wX00lFABBPUUZt8DUjJqWhs?=
 =?us-ascii?Q?U0zKyCCysNhN1H6JihG7ps18SpfvPM3VcNAEL2vl4e1WvfQh9bvJVS/vBvts?=
 =?us-ascii?Q?jl4sZ1WSSGuQmEiQwSM0OGzxt0BHlDSoBVvZoaPXCFlIEv45oqtard3ygM31?=
 =?us-ascii?Q?OS5Dmyn5WPepKrdstncoksmgrQxdRPF4gKgcQP2JFtC/KPyUDDKuj8d6qVcu?=
 =?us-ascii?Q?sS+6kwpA/0x0N63WT28d/eQ7ODzw/NQWKILaV+gPSz8IOUUbvKUannlMvQtV?=
 =?us-ascii?Q?SBWTQzOE6htDieOAj93AUrsf3pxcOyUsQAfA9LBRM15f5q+RdsNj9J0nHbPF?=
 =?us-ascii?Q?ECyZxQi7YKCGsvxaWMqVFoGRV9OAfWsNimf3FUD5EG8XBkRBK70vPOWurt5u?=
 =?us-ascii?Q?cm53fZUuM/BSwHj2yZqOxgQIP0o1EKlV8nTH0jO2XX5B17+PAFa+j67rsuv9?=
 =?us-ascii?Q?uULIoj9F94ltUgXq+91pU0LLTV8XGNFD1hEDhYgsjPMZ/rF0BPOXBc48Jrxf?=
 =?us-ascii?Q?SbFT/hdDa3MGxSBOrR5LCMX1tueD+zkij3rgUvr7UeqyBlKuhe64/htPJPIr?=
 =?us-ascii?Q?UhGjv9kai99RpTV/3S/uFuWMiVFVCxx1W5SYIejHJHitBTEAlNJpkc7iZUX9?=
 =?us-ascii?Q?xRQaz7NJSksiG6JLrXKw6gsG7xvUzCZvhF829+aG3eFfnZA6EZItw/XSg+0u?=
 =?us-ascii?Q?mMqI8575fTMHVO+FZMFyzGOMBl/zsy/s1IPQe3gs739HdJysDLAHzB4d6jtL?=
 =?us-ascii?Q?eunXzxZOHCh/+ePN1VvJvNQos2ahJLQc2Q87vkVgELiWJJNoKZEC8ZVhVpDr?=
 =?us-ascii?Q?xTlZEDgThTbre8auApnGPSI6qz4uhHsnuVYTDPBUM0L4uHCvg2bqzNXd2v/x?=
 =?us-ascii?Q?X7zZ4sSkXopUYDMAT4q01EKmG+33aL2vkSlz50tbYqT0riPyVaP5e4wRyPaa?=
 =?us-ascii?Q?7U8MVi6/J+trt8NdRAfqD2lNHmUuZE5SA3uUevv1MdoBBLu3bv11thZh2fT/?=
 =?us-ascii?Q?dC744S6nQCZsX76cD+u31Yao0uXiYkYFRgEfyWj35nnOKVN25XbOESFrWg+8?=
 =?us-ascii?Q?lE3VZTiE/jcw9vZ/E9E2BlFce4of+qWAiW+hSWVCfF+HcNuVNMSoJVaHtcZP?=
 =?us-ascii?Q?YvC6fJhT72AGVAQ+m35bEic24pJehNf5OKrOYAsi7O6IcqnuzI1wIMN/PETe?=
 =?us-ascii?Q?1pyaFlKes1SMgPNuqyuuEDsCZqbEFPFmduqw7LhFOzcOJqB7E4yCIYsCWUfH?=
 =?us-ascii?Q?n5/hgiarn9AYmtb98UZjCt7Oaju1Nc/4aE63eezy9EVN8VYvF+s+lNBpLZlH?=
 =?us-ascii?Q?4K2JDyMvbGWWD9yjI/uV+iFetzkJGAeUn2E4LG1JpI9jRQYsKjvxcFfjCp2c?=
 =?us-ascii?Q?R2qG8TWbgqlfOywp9fmNlnYULbNiS2ZpOkFGg3oprhPszBuNiYYCWb5PQmK1?=
 =?us-ascii?Q?a9zRXlCCsAlJ81R7KsJsXpV8nhlWgBtXiJQQF1zNdl9H7Rx1vvYTe3sY+JrK?=
 =?us-ascii?Q?MbWo3taOSg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f01b4469-afb8-4dcf-0d6f-08da33450125
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 11:54:29.5116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4Er7kd3RrfV11QhGFQQZADWx6XHAN7D/GhoqQ6wnyzeSIGYJmifKNlzyA54KME3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3287
Cc: vkoul@kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 will@kernel.org, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 dmaengine@vger.kernel.org, robin.murphy@arm.com,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

On Tue, May 10, 2022 at 05:23:09PM -0700, Jacob Pan wrote:

> > > diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> > > index 5af24befc9f1..55845a8c4f4d 100644
> > > +++ b/include/linux/intel-iommu.h
> > > @@ -627,6 +627,7 @@ struct device_domain_info {
> > >  	struct intel_iommu *iommu; /* IOMMU used by this device */
> > >  	struct dmar_domain *domain; /* pointer to domain */
> > >  	struct pasid_table *pasid_table; /* pasid table */
> > > +	ioasid_t pasid; /* DMA request with PASID */  
> > 
> > And this seems wrong - the DMA API is not the only user of
> > attach_dev_pasid, so there should not be any global pasid for the
> > device.
> > 
> True but the attach_dev_pasid() op is domain type specific. i.e. DMA API
> has its own attach_dev_pasid which is different than sva domain
> attach_dev_pasid().

Huh? The intel driver shares the same ops between UNMANAGED and DMA -
and in general I do not think we should be putting special knowledge
about the DMA domains in the drivers. Drivers should continue to treat
them identically to UNMANAGED.

> device_domain_info is only used by DMA API.

Huh?
 
> > I suspect this should be a counter of # of pasid domains attached so
> > that the special flush logic triggers
> > 
> This field is only used for devTLB, so it is per domain-device. struct
> device_domain_info is allocated per device-domain as well. Sorry, I might
> have totally missed your point.

You can't store a single pasid in the driver like this, since the only
thing it does is trigger the flush logic just count how many pasids
are used by the device-domain and trigger pasid flush if any pasids
are attached

> > And rely on the core code to worry about assigning only one domain per
> > pasid - this should really be a 'set' function.
>
> Yes, in this set the core code (in dma-iommu.c) only assign one PASID per
> DMA domain type.
> 
> Are you suggesting the dma-iommu API should be called
> iommu_set_dma_pasid instead of iommu_attach_dma_pasid?

No that API is Ok - the driver ops API should be 'set' not attach/detach

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
