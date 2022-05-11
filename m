Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002CEC433EF
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 16:12:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8EAD8829EE;
	Wed, 11 May 2022 16:12:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CsdC4iisl6oh; Wed, 11 May 2022 16:12:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 62EB481379;
	Wed, 11 May 2022 16:12:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B8EFC0032;
	Wed, 11 May 2022 16:12:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CD74C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 16:12:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7D066408BB
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 16:12:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IuBrCxD6PmOg for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 16:12:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::619])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 026A74043A
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 16:12:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bztrhIAe4sn+Yurlda8G4UV8rHKnVrmJmptJcp+PDOJ64+LJZZNC7ToAArbQRWai38iR1Wka/rLhiAp3O7db5Y+eX6Rfada65kbj9aAHuGzKUBde4lLMIiHTZ/9RVuB2nldBmQ/FY/eYGqrKxW1YIfbJDAldimO0L48CFik9X1zx8NgkCLoT2g3cSgSxLHrRkXi1pLGLeUt620gFPjaWf9j56JdMPopyNiALTr+mrVOn8o9IZCYih5PVHKB6qplJ/acJ3gALSQrw8J2a8mYi825JK0zqBmlMKwxwKmzpashOaEIjSufK1yL4xxvPeHxtOgp9IQdc/yZOnyPqvxxEmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+jMeiUP7qX77aBqnAFoo25JJIKWOzwn2FrWpswdM8o=;
 b=AAZ2jJuZ1Nd7ko4hGbd970GG1qzO7wH++p5muE289oZZQXkUk37qaEgUZ+mm8fJihEXLFMEsK2gHcviecKdYZAaXCOPAAxntL3+A8TLkgamXyVKNlcD7UwLsReSssjPcW62ibLmj0byDxfEAGmrVghDbzcSmCWCBLJrhuzcTtjSjiKVVxfyeyC4quKBJdkgdq0DQJjTOuYN8qSa7kaO/DqhmVJL9eYesQFb9+WXIheZv+OC056nVM9o/L5AWTUapNqtCHn1YZ0WBeJrdMMkB/KOnPC9PRqUgc7NJGPUBpV7AkyyAOW2PV9C4UIxDA5MjYwvSxKz0GmGppfSW201qRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+jMeiUP7qX77aBqnAFoo25JJIKWOzwn2FrWpswdM8o=;
 b=O02Wg5K+9tCXTpPsWSw9AHSoTvZ6VCV6mRKYaLPuQZPJTpyfvm73AksYigH7NVO9JN7hseNohjKzKbri6sdsRRaQ71PIS/P8XoF41+DvX53HFRH9T7oIMX1wlT8T9vr/qgEunD2lnUBiE2gIVlmOkG8vmIVuYBtL+0vHYWD0b7JXLoh3qzzjQDTCfWM5dbHvwtGM+FzuUk7DSFg6eGiRRFVbC5XDn3YRvOOHdqf9MWNyQIbzrMJLBLbV0ABThxF7JjijyMPxyunhjrzUa56ZXru9QLoAE9gK0+yZCsbJLRsZcJtef3H3nOSYO6MsQTBwtA5kPlBCrqObadl5HdzBzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN8PR12MB3122.namprd12.prod.outlook.com (2603:10b6:408:44::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 11 May
 2022 16:12:38 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 16:12:38 +0000
Date: Wed, 11 May 2022 13:12:37 -0300
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v3 1/4] iommu/vt-d: Implement domain ops for
 attach_dev_pasid
Message-ID: <20220511161237.GB49344@nvidia.com>
References: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
 <20220510210704.3539577-2-jacob.jun.pan@linux.intel.com>
 <20220510232121.GP49344@nvidia.com>
 <20220510172309.3c4e7512@jacob-builder>
 <20220511115427.GU49344@nvidia.com>
 <20220511082958.79d5d8ee@jacob-builder>
Content-Disposition: inline
In-Reply-To: <20220511082958.79d5d8ee@jacob-builder>
X-ClientProxiedBy: BL1PR13CA0316.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::21) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b483bd0-a050-4d8e-d757-08da336911a2
X-MS-TrafficTypeDiagnostic: BN8PR12MB3122:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3122C0DE4DEE20CCC0E84163C2C89@BN8PR12MB3122.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2IMDNX8wDXkxvbUSnLi/fphCdYnWjEtjRV26Hs9DGAEu7hzZEbUQitKc5aUBa+N8Z3eKdBrQHpgRvuOALQoceGjLyG46MRalU1+OEYKcaGLSUHXJQy1eOT2I+baZ2bHjVFGRRwXEaxYYDpWe3ebDFr+dfVtTrubflTXO0/R6tXKvWDT/1ochvi6X21MHB3Tfa6rscNBYTlm/fkjHzgjNR6X9td5c+ovkKfwW5S73hmReewWuMHLni4m4lRwwU0apLkku+FVVGT4Z+U6rr11wunJyuxms1EITxNLM87Mh5bfI+WJyU4sWjOzXrSWxhy7Zhw+biIKMtuqxEm4sgd9BKC/r8S67/y4zrel06whAdY7hnKkIUBOuWRbTp7/MbUFcLBnho9RnNtyQIoyOrCwtwIRKcScolO5UQaCoDCM0xZ5ADov4DUoEF3mQY5ZdwpR60676ZgE+q17sng/8VgiRq0BbBce3jEktstgNww+NddWIJDOiIu9EU6Y+czs8EUbasS6ZgkG/fXkI+vpteKI4XiCves/RVhp/qAyskF1Tv5nCc2a7j+sCJGjvW5+wtiZb+O6D7RF1w/zBaamalASjl2YSA6iqAQ+okbk1SuoWGz7ymRukbLJQbDSgkTLiwcxFLQSmDRsLQMO5qYnuKd66VA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(4326008)(8676002)(7416002)(66476007)(66556008)(316002)(6916009)(8936002)(6486002)(36756003)(5660300002)(54906003)(66946007)(6506007)(6512007)(1076003)(2616005)(186003)(33656002)(26005)(508600001)(2906002)(86362001)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X4KTjr1Tua1p6e9YeCHaIUjtwugB0/SypHHWt4oTs3HY6rE8H8SRixCF2sIz?=
 =?us-ascii?Q?V8SvmT5LdF4XKHfelnBgb6lBgN0ftdX7b0HrO8IxskS9FrHf6dAaNahSYTiB?=
 =?us-ascii?Q?6xAT47nN69vgmQlpNPPSj7oM+EwK9hHdGvQWZG5MFv7X1zOdI2kEpY+UuqU2?=
 =?us-ascii?Q?mtGvvP+zqkUI9AoHC5GVbj1wVRxobNlg2b3ZfECIe2zLGfOUMWyOenLAXZXF?=
 =?us-ascii?Q?aL6Hd3U9UvuyPHBP+otHyFeC58MEcTKgr5AeIsIeamL/76OkL2cCSOyxx5K8?=
 =?us-ascii?Q?4DRYTRXfMdxGcdOgL+7/6iAHiNkrkw/9A140bYFrI/T3BIFywEPR4nRZytWe?=
 =?us-ascii?Q?3JKVo644/iIaMYxofJzq75vvDL5fcZFZ9bg+t+w2PthesQsV8/OuGBMokxu+?=
 =?us-ascii?Q?zOrwTCWBLRJWpwUneXDSFw0tOvuAOi9A9mmwmMRnTN7qrWnOXAcv/XPSWwh2?=
 =?us-ascii?Q?F0J4Xm4nG8DZlMV85Yd/B54oflgvqcS0iymsASAQlQfy7MG8enmCfz5xKExz?=
 =?us-ascii?Q?v2W6faI6U7nXdRXSalDhjY6WZBjWJm8q/CF/vltuabJ7gpnLkaCqhRddmng4?=
 =?us-ascii?Q?F478N61XVi140n6FCyyXb1vgk4cT+34rmtvJyDQdohOD0NLDorSxLzKCBz6I?=
 =?us-ascii?Q?hSpjlWzE1+U86742kCrv5NF4Yrgbu1jhvu2wLnXcgWTmGYrPb/5aPUAEuqq1?=
 =?us-ascii?Q?hkrMJs5SfCG+xX/sCTcNIAEl7X+t1qC/66OlWyTPwpeH1iVXLAtQDrqxjP3d?=
 =?us-ascii?Q?7SFjW7ijj1XOPbQk2U1iBvQkA1xI72gzxlWtpysWq0OFzDyVeDnikR1a+Cv3?=
 =?us-ascii?Q?Mb/DCw44CVaCZF2ydaZPeDKubgSNNvpbaWQ/LoV+o9g/9nTDCqhL1tgRWtrN?=
 =?us-ascii?Q?tcADWkNosxO1RCl8CTi2iFREFaiyIYj/FwLvcCabew9u0nzEO/tx26cz8MXJ?=
 =?us-ascii?Q?dp8HL196F4Qwa97fSAi37FB2N6g9HAIOA5QywSB0MHXGQzGZic7R6ecVbypC?=
 =?us-ascii?Q?JrwWfV1Wbb3qbLIhmnVDn6hUzQ7RANgCvBAKpIRjHKG6KO5j3ON8JxCsAzBR?=
 =?us-ascii?Q?SzvYOHW1knKohhdsM9hkNmxIaPqIbtcVf6ExyR8y/kUNmyXyR74ZpJKIAsh3?=
 =?us-ascii?Q?2YtTXbdWkca94ha+nuZUMrSUG1EtPg0Y28O++BgaxrgAU7Nzv0deW0bTOWQK?=
 =?us-ascii?Q?JOh9EJJQilIJb8GNpJEwpFdLbF1sxcS362dICbarKMANqJBIGVOYWLpD8FvW?=
 =?us-ascii?Q?uCRYrrUTb6hpHWk/U9lXbImG/cxFb21vXRnOI/6J5yb/u6JjZ+114ZzAe8Zg?=
 =?us-ascii?Q?+6yrIFl6z2O20/kZ6Itc1dXbXtrt1RiOFNqCPFdM+JJ7tS8Dccp1nUmCsyqM?=
 =?us-ascii?Q?0ohSsrYFtihMUOZVQlxjP2G+rSmQ1u7JiWtGUjkNVV979Cb/DSN2FBNfsdMU?=
 =?us-ascii?Q?9pzHVHnylFXmiY+cY+Kn4ZRzngrdRcox0J/S33ZG08/2pVsrWejIkym8BlEB?=
 =?us-ascii?Q?/qCwtwT9pqgMSbruxxs1gyGIxbhBju0XYS7D3VsYa+SaWQFogLQX7SIWbjj9?=
 =?us-ascii?Q?PhOOUoJSRPt7jRks/hhFxZGc9StwCqQyJYYu1haEzDqx5g59Jpzcdi9VjzEr?=
 =?us-ascii?Q?VUraiKuXy63tLB8eXhUeJJbEXQEQ/nPdCro4Pemh2A3OKi7oVb06mPI76o0k?=
 =?us-ascii?Q?2cCK29tEMrgdfOXq/nm/J6WBN2E5Thk+KRqYpi1WF/5R98ckxMXJLPNSVUak?=
 =?us-ascii?Q?lNLNjh5k0A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b483bd0-a050-4d8e-d757-08da336911a2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 16:12:38.7907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXub7wTM6PPKcLBTIwmO78uINNXbKyVfQI6UfOqRusW1k7z3BJtnitrq9D9fuayN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3122
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

On Wed, May 11, 2022 at 08:35:18AM -0700, Jacob Pan wrote:

> > Huh? The intel driver shares the same ops between UNMANAGED and DMA -
> > and in general I do not think we should be putting special knowledge
> > about the DMA domains in the drivers. Drivers should continue to treat
> > them identically to UNMANAGED.
> > 
> OK, other than SVA domain, the rest domain types share the same default ops.
> I agree that the default ops should be the same for UNMANAGED, IDENTITY, and
> DMA domain types. Minor detail is that we need to treat IDENTITY domain
> slightly different when it comes down to PASID entry programming.

I would be happy if IDENTITY had its own ops, if that makes sense

> If not global, perhaps we could have a list of pasids (e.g. xarray) attached
> to the device_domain_info. The TLB flush logic would just go through the
> list w/o caring what the PASIDs are for. Does it make sense to you?

Sort of, but we shouldn't duplicate xarrays - the group already has
this xarray - need to find some way to allow access to it from the
driver.

> > > Are you suggesting the dma-iommu API should be called
> > > iommu_set_dma_pasid instead of iommu_attach_dma_pasid?  
> > 
> > No that API is Ok - the driver ops API should be 'set' not attach/detach
> > 
> Sounds good, this operation has little in common with
> domain_ops.dev_attach_pasid() used by SVA domain. So I will add a new
> domain_ops.dev_set_pasid()

What? No, their should only be one operation, 'dev_set_pasid' and it
is exactly the same as the SVA operation. It configures things so that
any existing translation on the PASID is removed and the PASID
translates according to the given domain.

SVA given domain or UNMANAGED given domain doesn't matter to the
higher level code. The driver should implement per-domain ops as
required to get the different behaviors.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
