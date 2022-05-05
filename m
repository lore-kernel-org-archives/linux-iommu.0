Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33898C433F5
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 15:33:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C363084098;
	Thu,  5 May 2022 15:33:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MJlsIVcJokVx; Thu,  5 May 2022 15:33:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8BAF684085;
	Thu,  5 May 2022 15:33:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D52EC0032;
	Thu,  5 May 2022 15:33:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32036C002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 15:33:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 119E740399
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 15:33:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b7XAp3bKesqI for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 15:33:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::607])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BC827400CE
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 15:33:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVmntZu09IsAeFtukB/iBacvbzXw+gLJ9rmxEY1Wvv+Se/MfUyOFTTn9Lztr/MuXgkl4gFYTDdI+Jb3nYfLa1bY+xoETASoRTXiBOS1gLXpwKHnEmT2s8CME4D+oXuqEpMFm2lrOfS5c/uBKjfZNo6NDBDnVusYP1nEp+66NAOvS0GsYSdsPDxhDW1zIL13YzghF/i76SEgc16H3rrM+qaIIgChFiUtdT45KazBck3AfgzrRy7CUqQuRhGVMFnNyUaKETDdlRVRmQVW+peYAzTn+E8IYmMQ8P6srYazgg9SWBfv/9VHWWUm3yfQytb/Gnzzif2XiyHopME8yFvhyzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rL3FO7BgtagDxVRHmOQkW4CAIa6B7PCfSDkXHty7GcU=;
 b=UqZvBNa0nUpS0tkwh3ZHifkM/c3leE0Kko+rJHySrieIkkjTWWklYpqk2/J2I8b1uHDUYhjSTdhZFoIP1BciQn+gjk/y+bDPDK8Gk+l3Rm/aJSiIVPPRCAJaA1HHm89/K2wjJjF+wHYMajQRS++ltkpF7rb47U7X615VSODa0yIAeY5U2qC7+gNQDoxZUFPoSL7lsM3PKhVuuFw0gKdBL6ZRSGdNtTDRbX8W8AhGXLkCrqanUNariJm4AV9utHo9xr45vnXCmLOFANKu0ZUsbyDT/BpOZtCPbTLlyHVmBR2NdV49B3nfGBjK2GdQFztQU7frLwuzoGSbydeSzBIX/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rL3FO7BgtagDxVRHmOQkW4CAIa6B7PCfSDkXHty7GcU=;
 b=Wv70ozmXuwKbcLKPuNpwt30LRBh83RRSTQay5P8amBC3l1c9Nv076xs4gHmE+JAb4mJEVP7lgc6/a4Mo/l7d3YxShEgLnwMn9Jdpw2SSf8wF0gf4hDG3Q2BUKgYv1JCrhmK8f4DsP3yK7iDtU1CzXaUt8BvR77FCA6DKdJTaowKsPBdU5atdyqoAQl94/3E4W8K8f6bC+DYaXr6e97CvtgcBjN5GrZTX1wcmHhzYzxaL6FvxGkjUIGPYalHRG8+cckDQ6q2NwO5PrUNZvgKmrPJUN5lg9TiBTCrexYmc9+YXW5wFk+50q1I1okFgN7flpBaWLOq61DXafVD2FkLpBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR12MB1225.namprd12.prod.outlook.com (2603:10b6:3:7a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27; Thu, 5 May
 2022 15:33:21 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 15:33:21 +0000
Date: Thu, 5 May 2022 12:33:20 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v2] iommu: iommu_group_claim_dma_owner() must always
 assign a domain
Message-ID: <20220505153320.GS49344@nvidia.com>
References: <0-v2-f62259511ac0+6-iommu_dma_block_jgg@nvidia.com>
 <BN9PR11MB5276504B448C715527AD5F3F8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276504B448C715527AD5F3F8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR12CA0025.namprd12.prod.outlook.com
 (2603:10b6:208:a8::38) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6201339f-b8e0-4a87-706e-08da2eac960e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1225:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB12259652919ECA731915928BC2C29@DM5PR12MB1225.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zE+IzcYB8RcHkDqcQxB5tnrdvBS3+BRJBOcjwnz6AZwSNQFdWj9GO39aryBe51Ik6VAspDO9ePzPOOY/d4pnDjISITvlL1PoPbnQCKXSC46kSBmjTui9nhxJTU+0spezS22kCVXETfrX8VYZMP8nEtEoJpvq+wkOJFRqwovUYGpVbdcTxSXObYZOCB4FN0S7VaVfU/LGHjWfBN4+zbYkqM9noud7e60vzUZ1ddi+ObGh4ySO6ykagLLR+VkVZmbyJ6MTrFrnuEhXjtCWIwhowf17wH4ehlF+bQj6QWbpUAWIjiPKzDlRanHgCux4pLCyWx4BJCPi+fxRaWAxWthbzz9CrN90ahjsod8jv2oGphq2ev+BS0IrDeAuIMJNw/z7wTL+fR/CNHhMO6fdCcF8gqXJOYT3pdKszj0rzx95z9DUkyoNHtyshRgpLJolHs+SxJw+6cn+fSjJmAmZtnIzhzvX3feRT+ELoq718jj8HsZWmtc2NNlydpDc0nYBUD8y4Z9oWdnl890icrqiH4ftxqnXFmlsD3+IdMOhiUVlxlA1a9mdATNxoIAW7eJJxD5Il6rkYxFMqrqZu/+aFnIGYYho6AFsDRadlMEg/XVlEUhQDMA9b0pAP0qorB9LNSYWQEsGSrKD3dVTuf2WBkpgvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(36756003)(83380400001)(2906002)(66946007)(66476007)(4326008)(66556008)(33656002)(186003)(8676002)(26005)(1076003)(86362001)(6512007)(316002)(8936002)(6486002)(508600001)(38100700002)(2616005)(6916009)(54906003)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HWAfU2bfn6SyrBTY9ImouK/c9ZaJ+EKI3F1zA6whdxudWCmAAi3Fj7KTwyTo?=
 =?us-ascii?Q?a7d7N68COaSTIDKKBYyGqaEuT3Q7H32mE1v04+s2hOZdE0gSuoKpNxgg3WTd?=
 =?us-ascii?Q?edwaOeCSxQpD+UQxowYTbpmDUT23BJxHakrI6Jh9BW9bppg1ZnPIMQWpz6Yj?=
 =?us-ascii?Q?ylmdYoYEHJ4kTAJpFivDNPLMRBOLMmogun70RggjUzHVyIyAa7/ma65KGg9S?=
 =?us-ascii?Q?9bTIp1foiU2GE6XH8tyYQnktGKRMIjPC0uoqufSXBoQazzU9WHidMcmpQXX6?=
 =?us-ascii?Q?KgDyZMhASHT99pSzIn34Ams5k51BnXs/sZT34MYJmkK+KLdUwpTMS0WS+SQo?=
 =?us-ascii?Q?HnRiRPWcLWSH8whadAamWAJevvynNLvaWyXE7FUXF+H9JjZq89JL4kSiJD6S?=
 =?us-ascii?Q?WaNNtaumhUzeGRaSqzMrI88oPZAV95kzMQgreMM4RzUdfFSbL/w8+GL6pDmK?=
 =?us-ascii?Q?+q4YIuQPCxvGN8mhIL3eWEUu0DmMcVXf7ZSNIII1L1/UIXjpcJfFYx/FktkO?=
 =?us-ascii?Q?kTcvHw4Xe/Ze+hpyGDlFKUZ4xbMfDCFrOhs8WK9cahxj7KDminM+pCnOMHMj?=
 =?us-ascii?Q?LZxy3ChqaUHqK0ac7VCK61k9wEEMqexXwnAQ/Wasia2CnNUoe38xfBXLeSRe?=
 =?us-ascii?Q?aq5o4Kb1bFUdRGyewr73nRkr3XYU16mKw+BU0nJoQFccVIqXDGvIidWu/VWR?=
 =?us-ascii?Q?EJ4Q9R0IEMILeLZP+wv1+UuDVyL6PAyxSBC4CUEnTRBgEH9X+6C377DgjD2l?=
 =?us-ascii?Q?BDCe6Cd/Ulv7VxqdutLtQhqSv9RH3ZXbxqU/r4gr86YzCSFfBLGUCXTZQGnm?=
 =?us-ascii?Q?XbT4jgnyJZnZoviuBzf/e1A6sDrTT3S7zS+vLH/w/EGJabMFu0nWcmK+n+Dk?=
 =?us-ascii?Q?qAJ4HiHwbhj4EbcRLLU5mFrAX6RwgsWAp5etwhJHgigA1qYI4Fej5kOE+lDR?=
 =?us-ascii?Q?JhtCxoThTvEOxmZS7KNT61kEi84f8Sra4CNgs9TelBLY1gZq+3bra7kZJuId?=
 =?us-ascii?Q?FbwFijuP7fcu6BTPwiC0d9UqaGqEcXLgkalMO3OpM4BpJWTsvBU5b2nFxCYz?=
 =?us-ascii?Q?CI8dXgIkOAr5GP5Dr4gsb+sDXlReniiND9+poU46tzZiBw5eJuJw/Xdv4S5Z?=
 =?us-ascii?Q?vI6EhPQco//2HbY2xfgM/5qvohm7w5o79TxUxh7IJd2xwxlY58iQSXucyZy7?=
 =?us-ascii?Q?YUTzLaQBAS4FM8g42yK7dSKjADwdmULsIYGK9TnCBFThTLYNmQmSru0B7S4P?=
 =?us-ascii?Q?KiJlqJZygSWd6tMbtTNd4AidbmAzqKMLmAj0OPb1pLvH1puDD3Sf7K6+feyo?=
 =?us-ascii?Q?vSKmD33kTJdyPzPhcAVOgTFJpOT+JGR2KYjZjsq4yNP5fpHcMhjFRSBmgYl5?=
 =?us-ascii?Q?ITpu5dTYtXXRt7mLCR4UTAIkpRZOHIeNGSQJQ/Mr1eWumETe1Uuj+lfSqPu3?=
 =?us-ascii?Q?qKwSIvZRBhMP1N7tUaqLYPn4vRTuizmQkPJhuq5Xz0WrdNyp1mF0kNQtfZ1q?=
 =?us-ascii?Q?TFsVD0+JGEarEFdPiWlwAEgRNZHmJypJEDK6Waw1XjR9pV2sQ/9jdmHSmvSU?=
 =?us-ascii?Q?TfEOwAkK4ndFp1bTYY/AOp5dDs9xC+t+2DUoM0u2OSjNqf6pxk4fDy6romrs?=
 =?us-ascii?Q?iNWa1qWTQcnBRe0Fwpgl72K1U50hYUA3vz2+BznXTq3DCmXQDF/sZaAqfaNx?=
 =?us-ascii?Q?3a5UyLihVgzxTzC98H7o5/Z9TSkK5zZKXaFy1sNzyKrnsYbu4Sj8Ky34yq7f?=
 =?us-ascii?Q?/yIzEyMC5g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6201339f-b8e0-4a87-706e-08da2eac960e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 15:33:21.5783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2j3PJVwMVqTWE18bCVsbHaSIMls2/4RFNb6NsKH6kxYHTp8p7P/2WR+a3H0Mp0f/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1225
Cc: "Rodel, Jorg" <jroedel@suse.de>, Robin Murphy <robin.murphy@arm.com>,
 Qian Cai <quic_qiancai@quicinc.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Will Deacon <will@kernel.org>
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

On Thu, May 05, 2022 at 10:56:28AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, May 5, 2022 3:09 AM
> > 
> > Once the group enters 'owned' mode it can never be assigned back to the
> > default_domain or to a NULL domain. It must always be actively assigned to
> 
> worth pointing out that a NULL domain is not always translated to DMA
> blocked on all platforms. That was a wrong assumption before this patch.

This is described in a comment blow

> > @@ -2040,7 +2037,8 @@ static int __iommu_attach_group(struct
> > iommu_domain *domain,
> >  {
> >  	int ret;
> > 
> > -	if (group->domain && group->domain != group->default_domain)
> > +	if (group->domain && group->domain != group->default_domain &&
> > +	    group->domain != group->blocking_domain)
> >  		return -EBUSY;
> > 
> >  	ret = __iommu_group_for_each_dev(group, domain,
> 
> Suppose this can be also replaced by __iommu_group_attach_domain()? 

It can, but lets do this as a follow patching since it is a bit big

> > @@ -2072,38 +2070,68 @@ static int
> > iommu_group_do_detach_device(struct device *dev, void *data)
> >  	return 0;
> >  }
> > 
> > -static void __iommu_detach_group(struct iommu_domain *domain,
> > -				 struct iommu_group *group)
> > +static int __iommu_group_attach_domain(struct iommu_group *group,
> > +				       struct iommu_domain *new_domain)
> >  {
> >  	int ret;
> > 
> > +	if (group->domain == new_domain)
> > +		return 0;
> > +
> >  	/*
> > -	 * If the group has been claimed already, do not re-attach the default
> > -	 * domain.
> > +	 * New drivers should support default domains and so the
> > detach_dev() op
> > +	 * will never be called. Otherwise the NULL domain indicates the
> > +	 * translation for the group should be set so it will work with the
> 
> translation should be 'blocked'?

No, not blocked.

> > +	 * platform DMA ops.
> 
> I didn't get the meaning of the last sentence.

It is as discussed with Robin, NULL means to return the group back to
some platform defined translation, and in some cases this means
returning back to work with the platform's DMA ops - presumably if it
isn't using the dma api.

> > +	/*
> > +	 * Changing the domain is done by calling attach on the new domain.
> > +	 * Drivers should implement this so that DMA is always translated by
>
> what does 'this' mean?

The code below - attach_dev called in a loop for each dev in the group.

> > +	 * either the new, old, or a blocking domain. DMA should never
> 
> isn't the blocking domain passed in as the new domain?

Soemtimes. This is a statement about the required
atomicity. New/old/block are all valid translations during the
operation. Identity is not.
 
> > +	 * untranslated.
> > +	 *
> > +	 * Note that this is called in error unwind paths, attaching to a
> > +	 * domain that has already been attached cannot fail.
> 
> this is called in the normal path. Where does error unwind happen?

Any place that checks the return and does WARN_ON

Also the loop over each dev doesn't error unwind so it assumes that if
the first dev succeeds then all subsequent devs will succeed.
> >  /**
> >   * iommu_group_claim_dma_owner() - Set DMA ownership of a group
> >   * @group: The group.
> > @@ -3111,9 +3162,15 @@ int iommu_group_claim_dma_owner(struct
> > iommu_group *group, void *owner)
> >  			goto unlock_out;
> >  		}
> > 
> > +		ret = __iommu_group_alloc_blocking_domain(group);
> > +		if (ret)
> > +			goto unlock_out;
> > +
> > +		ret = __iommu_group_attach_domain(group,
> > +						  group->blocking_domain);
> > +		if (ret)
> > +			goto unlock_out;
> >  		group->owner = owner;
> 
> Here can use __iommu_group_attach_core_domain() if calling it after
> setting group->owner.

That is obfuscating. This function must always and only attach the
blocking_domain.

So, I'm going to leave this patch as-is since it has been tested now
and we need to get the series back into iommu-next ASAP.

Thanks,
Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
