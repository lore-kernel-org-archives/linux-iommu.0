Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACDB2C9C;
	Thu, 13 Apr 2023 18:39:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K55rAtYn1ZdECw88a7G70vUNfLYjtdx76/atFm88B1U3gVWI9SlzNJ/fsfdk5dSYIIa8lNOUaw1ICp8jKiuVrMA8M8CJpUSQ0Ht6sOP+iMevjuwnXwoQqfolSQ2MvEhrYvui9CooEDquS1/vhC8SBRNVRFWkx3Sb2Jk95VT4gJ2k5/fYj/L1itsDFxeisocWwEFcQ9+PHPCS1pwglmOL+sN4g+sG6Oncx6Nj53e1/uFhYP71TSnZwITLOagp8iPKorYcQNJWwU+B8/EpaDXI/raCwZMR3xgGuJqxzBW/HRcXyO5PhILxjs5vGhtLndZ/6mwVpDatAJBcBnHx7NSCKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZoN45rWh5d7VbltX81xcFCXmfmktUZ0wHscXeam2PkU=;
 b=YySwwq39OfRPz0dRRED8WuuENcLDNr4ayjA2igcUL9RqCch7xgEKj854AdEQcnlpX6x58j1+1PjUt9UrJ7Gu38It/knIr8v6/m8uX/xtaScVWmdkhrYwcjZkTCBGBNHuvuUpOuvn0ECi97J8zWyti9fCp5PZamt6xQR9QCi0OjhBrQjtjjozdSOMRQksNS/W4Y4k6QihtNsnUe6TpWVI75TBQKxs9K6sc63y8lh31sbP7mvCMhxSdf/9tftBd+tnnK9H8GRr2+fIZjx6fmVQmPOXZyo9MdA/hCI7e8VfaCoWPCV8bG6Did1PlVKpdUfMhxCoZYrr2FbpxuYmtzfJQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoN45rWh5d7VbltX81xcFCXmfmktUZ0wHscXeam2PkU=;
 b=BnptC1rBvVK9BlHwutYmbHhZvY1kfdDge9sWkwRJXnZlGg9Lbmakdyr5reTYQX0+R7vEdQzsYE9OG/4PNodGg/GPbxk/H/sKnjp+IpZqGST0fxng+7L/ATsZxUWhN+dd0XcXl2t87jiws8GET2N6Dl81SfY8Jv9g/8q/CwRbM2PRJH4xLayPYrdS2I43wTMAJj/kfMPDkUF2kQA3wY3n3z/GEaXk44nf/QbLPYnKPSjTZIj0Qm3QfvQM7IztWI5T6+13H8Z+Ymy3eCm1ysm2FjSxYWAonINcAgR67sQ2FAlK1iAmkIUGMBCVIn3JtcDLYuHd1gr3V0uG/3G/m5kaRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB8418.namprd12.prod.outlook.com (2603:10b6:8:e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 18:39:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 18:39:56 +0000
Date: Thu, 13 Apr 2023 15:39:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v3 03/17] iommu: Make __iommu_group_set_domain() handle
 error unwind
Message-ID: <ZDhMed+RDDcvmNle@nvidia.com>
References: <3-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
 <26039535-5f78-74f1-7864-978ad6c2810d@arm.com>
 <ZC8Y7g99aAQURbtj@nvidia.com>
 <eb151466-1357-846a-a365-1517508fea1c@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb151466-1357-846a-a365-1517508fea1c@arm.com>
X-ClientProxiedBy: SJ0PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB8418:EE_
X-MS-Office365-Filtering-Correlation-Id: cb292012-c8d4-41f3-f061-08db3c4e7a6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/2I/ojYUGFIklTzkLSIoDfxi9kZElXRpk3Emr0pRQPjMOOl/+kxDrtzc/peMLfZXCvEGTILNFvdtcmWywklOio2c98wEGVrkNRWmnXGKvrl3HCAQeQsrrWy8x8tuJ5jzawClR0nPIg6gYgbnMSZU/nhuPl+4IRQY3y0gnUxStwni8GtAui+t/8Z7uex9w1tuGx8414QXBjBR7YfOsDVu72l440JWORmbHneHx8ZyHE5p/Nyhs3+sfXWNeqzyWOgVAGB+BsombMGaY7c5bvEdG4pi1t+5/98xpg02C9Tw24Zm9TFDpeW0moaWW7BtelTK1pcFk+DP0YF1Bn3YR+N4+8YX3YxZOy5YgDFI0x7Ja3ptAWnE8UCmbArl1VaUFi+ZaiyuloAJnXximPLPaRyah54SD2Rr69W6W+/udocH6sfghgdF72dGe65m0bBG1cNpz1CdxAXbgDoS+2lY+W/WZqfQmF0Xotqa25haS1KreaQXvhW37vGReaaThtC5Ec1I//MIsSXQ5eMM9JruZ/BePInnuF/dvas7rP2dTzyrxWRKgMHZHQ/7Utug9g7P7KdX+BtudS3xZZxPKwUvunkDHPpmUV0mRaOfEb/RWpxWtx4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199021)(6666004)(6486002)(6916009)(66476007)(66556008)(66946007)(4326008)(36756003)(2906002)(7416002)(86362001)(41300700001)(5660300002)(8676002)(8936002)(316002)(38100700002)(478600001)(54906003)(53546011)(6512007)(6506007)(26005)(2616005)(186003)(107886003)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V6ymm/5e8GNgI+gsfQQ9gBaI4W9+w/Ay+o268NzgwJmrsIkRWWqpCs2XV15H?=
 =?us-ascii?Q?FMlnqZ8BF7n88ZQXYWWx+SNPDi7O9yQ10ObyKOG7Jo0XopW/hXPaFFD+/OjG?=
 =?us-ascii?Q?3codECvWd1m7RjQCMk/R9TqDQb8aCDao5OoygGPsiyGCg1rRvvQzMm5rhOwM?=
 =?us-ascii?Q?PGrSAvy6ks5dPAzmLHuKg83ojlmqPc6fYGM2c+CdmKJWuYzs9Y/RTrrrt1PQ?=
 =?us-ascii?Q?LKMNqjALK/BP7FIAJ9fCTzet8aOJmXAAL1pC4Zt+YfHDI7YwshDx/UTq91M6?=
 =?us-ascii?Q?1524oD/KInYd3uQLmwXwjHuPQCRhrdO23HvVyoiw88cwAqZmXNI2u1heJYcu?=
 =?us-ascii?Q?YDJ/qPzU1S81cQ5d8b2nMGoqOclJBUgpynoWaSaY0F/8FlZ6IH7AdC2BrZK2?=
 =?us-ascii?Q?jPdPsnns+52tmYmTAcF1ch+8PZIa1JiPCXxOyXSRd2pn7HyrfWmJS3TRXljw?=
 =?us-ascii?Q?RN3SVUOvAO8wwycr99v+VoOKKgnVcagnzlk1Y8iCI/0NwAbV0/Mpm7WMVUCO?=
 =?us-ascii?Q?bqxfW80rwZI7BzsPsI6F+DtIF6x9LZhzk2K6Lp7LN2bTJ+OzIcQZtvlp87rL?=
 =?us-ascii?Q?GwLLaHi7duOvALkHRsGV2dTfZIV6T41qYHb2Rr7+Sbpb6ozBmX7o1k6/M6ik?=
 =?us-ascii?Q?vtflApAXZh9fFR+hOiZfq8LBENqFiX6AnNGdBY8CDSel7O9j+i0zKq4ktQ9M?=
 =?us-ascii?Q?IiR27/vOSOh2Ci/ldr43ZDGBeo46gLEOeucPnilOm/EnaCWEdPoZNt5tTwbU?=
 =?us-ascii?Q?nFdgPBIUhxRcjbalX1SK7SU0KwwChTydI9BxNxXJLWlg9Pg+YoKyjItBdbCv?=
 =?us-ascii?Q?iusXhoy86bBxs4TGjEa4hn4DBES6RV7BNt5wlkRm6Gna2HC3mem1L2YLnuG3?=
 =?us-ascii?Q?vDdLMHxkiUy+m9VSNfpLtOys8Rv+n3jCSe/xP3dXOR8l+LH4441RBov2mvnB?=
 =?us-ascii?Q?lRT5HcNWcQgKBF4Ah1tZ0+NHfQZn3YYvJik/nQ2K7mpy8pz6F3X3OaNnBlfE?=
 =?us-ascii?Q?ar/f6QLRn2xlWuiAPosa71AU5nygziF6uLp97HbVLTpyAL3fM8htxL21OnuE?=
 =?us-ascii?Q?56Qlw53/c41SfJwVTyAGnxMCfysiGv0/Sxwa6Tmi9EwsVG3WOOwKQpH0SDO/?=
 =?us-ascii?Q?NDxXRmA/4Ns5IX01sny6wDyGz5tlifwJigNpP2Aqfb5E07DFM9sHvbeE0SSy?=
 =?us-ascii?Q?iasnY1vPPPTuvIUI11sib/9rFSpZwncsxV5RIT9ueGn7vRhlBagj8LjfEtYy?=
 =?us-ascii?Q?N9YOAWF9Mw1rtBGy4xrYz325vvimMMob6bziz0ulA4kGC6qDFPe/5vltqLpv?=
 =?us-ascii?Q?8411DIl0RuGJYFq/I5/odjZko9lCJMWyLCSN6EdxbCidcDxnk2Ua0PeWlcgh?=
 =?us-ascii?Q?I9R6lH/bjUQQTCYYwSQrjEDLr8Rz1NWcvoPztkV+sAcVzRVAF+s8jLYpbzQY?=
 =?us-ascii?Q?q8Gl1dqRjCAf4G+Fdsdvw0vRsKf+xhMtUSDdxifIepGhngcKXqn/cjeOkrxW?=
 =?us-ascii?Q?1g9XdbtQ/FfhHfAd3fMcx0Yq0fPUNjEKZNWzygRU9ZPv0n7W7+pydElQMOBZ?=
 =?us-ascii?Q?riuIUfurx0PjpShNMkXwMnNNAzaqacy4Q96bnu4y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb292012-c8d4-41f3-f061-08db3c4e7a6e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 18:39:56.3927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YDadJawCjbyVeyQbjSjbrZCslh6V/EgbQUiEJZYnPs/0lAX02iPItSoROe0JNV/c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8418

On Thu, Apr 13, 2023 at 05:47:14PM +0100, Robin Murphy wrote:
> On 06/04/2023 8:09 pm, Jason Gunthorpe wrote:
> > On Thu, Apr 06, 2023 at 07:08:59PM +0100, Robin Murphy wrote:
> > 
> > > > +		if (ret) {
> > > > +			result = ret;
> > > > +			/*
> > > > +			 * Keep trying the other devices in the group. If a
> > > > +			 * driver fails attach to an otherwise good domain, and
> > > > +			 * does not support blocking domains, it should at least
> > > > +			 * drop its reference on the current domain so we don't
> > > > +			 * UAF.
> > > > +			 */
> > > > +			if (flags & IOMMU_SET_DOMAIN_MUST_SUCCEED)
> > > > +				continue;
> > > 
> > > I know it's called out above, but my brain truly can't cope with a flag
> > > named "MUST_SUCCEED" which actually means "can fail, but you can't reason
> > > about the state after failure". As before, I think the actual flag itself
> > > can go away, but the behaviour itself will still be no nicer for being
> > > implicit :/
> > 
> > What I saw is that a bunch of drivers tend to implement attach_dev
> > with first some kind of detach, which often cannot fail, and then can
> > fail the new attach.
> > 
> > So, this is intended to go along with that design pattern. We call
> > every device's attach and hope that the outcome is either to release
> > the current iommu_domain or to attach to the new one.
> 
> It's that design pattern which is most of the problem, though.

Yes, this is definately true

> It's a left-over from the old pre-default-domain era (quite
> literally, in most cases, where drivers were just minimally bodged
> to simulate the previous core call of ops->detach_dev). In the
> modern always-attached-to-something paradigm, drivers should
> absolutely be able to figure out if an attach will fail *before*
> they throw away any existing device state.

That is fine

I think I muddled the description I gave last time.

The loop is doing this:

	for_each_group_device(group, gdev) {
		ret = __iommu_device_set_domain(group, gdev->dev, new_domain,
						flags);
		if (ret) {
			result = ret;
			/*
			 * Keep trying the other devices in the group. If a
			 * driver fails attach to an otherwise good domain, and
			 * does not support blocking domains, it should at least
			 * drop its reference on the current domain so we don't
			 * UAF.
			 */
			if (flags & IOMMU_SET_DOMAIN_MUST_SUCCEED)
				continue;
			goto err_revert;

And then in __iommu_device_set_domain:

	ret = __iommu_attach_device(new_domain, dev);
	if (ret) {
		/*
		 * If we have a blocking domain then try to attach that in hopes
		 * of avoiding a UAF. Modern drivers should implement blocking
		 * domains as global statics that cannot fail.
		 */
		if ((flags & IOMMU_SET_DOMAIN_MUST_SUCCEED) &&
		    group->blocking_domain &&
		    group->blocking_domain != new_domain)
			__iommu_attach_device(group->blocking_domain, dev);

So, for "old" drivers the ops->attach_dev will disconnect the domain while
it fails.

"new" drivers will leave the domain attached and the above will then
go on an explicitly use the blocking_domain.

So the purpose of the loop is to go over every device and detach the
domain. Either with the sketchy old driver implicit detach or the new
driver explicit blocking domain attach.

The blocking domain part isn't 100% finished yet, as
group->blocking_domain is often NULL, and might be an UNMANAGED
domain, but from a failure management perspecitive this is what I am
proposing.

> If we reach the point of adding core code that only serves to help drivers
> emulate the new API using the old API because we'd rather undermine the new
> API design than fix the drivers, then frankly that seems like an argument
> for just reverting back to the old API.

I don't see it as undermining, what a new high quality driver should
implement is:

 - Do all attach checks before changing any state. Once state changing
   happens it should succeed

 - Thus leave the old domain in place on attach failure

 - Provide a blocking domain with an attach_dev that cannot fail

 - If attach must fail and cannot go back to the old domain, it must
   go to a blocking domain

 - Re-attach of a previously attached domain should succeed

 - [missing] provide the blocking domain pointer through the device
   ops so it is always available.

 - Do not fail when attaching the blocking domain

Effectively the blocking domain is filling the error handling role
left by detach_dev. What we are doing is unmuddling the mixture of
detach_dev behaviors where some drivers set IDENTITY and some drivers
set BLOCKING.

> > The primary purpose of the MUST_SUCCEED flag is to prevent the code
> > from trying to go back to the old domain. This really should only
> > depend on the caller's context and ability to handle errors, so I
> > don't see what would make it implicit?
> 
> It could be implicit *because* it's contextual; the domain types already
> carry as much information as the flag would. Attaching to a non-core
> (unmanaged or SVA) domain type is the one case where core code has clear
> reason to unwind if an attach fails mid-group. 

It is not universal, eg the "change default domain" flow looks like this:

	/* We must set default_domain early for __iommu_device_set_domain */
	group->default_domain = dom;
	if (!group->domain) {
          ..
	} else {
		ret = __iommu_group_set_domain(group, dom);
		if (ret) {

In this case even though we are attaching the (new) default domain
what we want is to unroll back to group->domain and leave the old
default_domain in place.

I find it much clearer to directly specify the error unwind expecation
of the caller based on the caller's logic and ability to handle the
returned error than to try an infer it.

> Attaching from non-core to core should represent a repeat of something which
> previously succeeded for the given device+domain combination, so whether we
> permit that to fail-to-limbo or mandate that drivers must be able to repeat
> a previous success mostly depends on what we think is a reasonable
> expectation of how to design a driver

I think most drivers are OK to repeat, but some like s390 have FW
interfaces that are not reliable, so repeat can fail there. I would
say a drivers should strive for a design that repeat should work.

The repeat safe drivers never hit these error cases anyhow..

When thinking about this error handling I was looking at cases like
s390. For their flow the first thing attach does is a FW call to set a
blocking behavior, if they have a failure from that point they can
leave the device blocking. When the core code asks for blocking during
the error handling it is NOP.

Jason
