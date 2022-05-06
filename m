Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E028C433F5
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 13:11:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02A7A84024;
	Fri,  6 May 2022 13:11:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FQqAWTyE5xWi; Fri,  6 May 2022 13:11:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C20EB83FBB;
	Fri,  6 May 2022 13:11:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E1F5C0032;
	Fri,  6 May 2022 13:11:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2790FC002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 13:10:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1337141881
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 13:10:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ukLE9u5Dacqm for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 13:10:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B6C324187F
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 13:10:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ua7T6qeYBrd9Q0iojlR3WtSdPTLdGNxjIkIKky5Oh/Z95SCjR55Uzp3ufFtxsYe0Zd+MpMcFIfMY3lA0wzsQEGFcr8eW65c1MziVH/avP3rHXWKW7xdRa70DrFZAqA0Hqm2r0M2RWo8VxCZF86x1hkpU3zoJFBFaJYM+RqEiJHOywgfdbHJV4H9F6ySP2NVktBeu4aLM+cuYWOYn+gAYP3VUMI2nj8dofg7Irb/GJbNIpIWUhAdgxjNXN+hW+s/T1UmkBvvUb+hDwENPVXx/4FYN2eQuFB0z1WthJ2B0g++mQmw7hQAhSvDtnAKI6tNfgLv0Z3TTbiYN2/qibrusAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDP3bmqafsBPSMiPsCXW4wR2YGseE48Dgp8EZapCGyI=;
 b=Ek2+hpXT/gkx468rLxtHkBgFp3cO1LxZT5shyZJsHik22mIDJQogEqjPoNov921/6YuN0iRykhHsGGPtXQvEIBDgjAzBwYwxI84louLUe2qfIisTcssQ9BW54yjS8Zk4jhgz5CpQkO4b+z5D1uuQtVA52oPCn2BubNTNdk6Dl5snr8cQT1R6fPOQxD2c3ATaD+C45G99gtvjR5WQzwoFVRZ7nUCQmirmKr/M4YP4oBWD+zWlIZlqX92jXXG62RAZiGDjaJXeF2z0t4E31GwfZV6U7PhmDNtdQkRaC8yK21sE4ahpAWNwMHgCs9FrvQTT1iXR8vohXteSOUWLXEXFFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDP3bmqafsBPSMiPsCXW4wR2YGseE48Dgp8EZapCGyI=;
 b=g8ApwwBF24MT6ta3p8oZ4KUKUodLqHZp/xC8d5Ds8/i41E/CYP9PY0NlGYdbgiCm4jymEcY8IjvJ0PhlgVQp7LcgpLIy9wg6MzBDzguo+GKp5mQcVi7txaP/ieotXpTV4SZcbNZSKWFwUxZZkwiHtT77Lpg3/af2OcmQYWf2P1ehBfubC3n7Gvvw3jRsIp08gmZbFK5UY1VSI7xoKdr+5TsXscQUYE29U4qYGuKwaJpxuyt9TaR4XBDATGwJGZbYgxJS/46StSH6dnT4Vs1TZlmn4CFwwByEydGAeRXhwDMv4SJTip3tm+Wjn9iTqTlkYrqghb4cutFZzWDVcOjwVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Fri, 6 May
 2022 13:10:54 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.028; Fri, 6 May 2022
 13:10:54 +0000
Date: Fri, 6 May 2022 10:10:53 -0300
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2] iommu: iommu_group_claim_dma_owner() must always
 assign a domain
Message-ID: <20220506131053.GA522325@nvidia.com>
References: <0-v2-f62259511ac0+6-iommu_dma_block_jgg@nvidia.com>
 <BN9PR11MB5276504B448C715527AD5F3F8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220505153320.GS49344@nvidia.com>
 <BN9PR11MB5276476BB203D8D61CA8849C8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <9f6680ed-77b6-8440-078c-623406c823aa@arm.com>
Content-Disposition: inline
In-Reply-To: <9f6680ed-77b6-8440-078c-623406c823aa@arm.com>
X-ClientProxiedBy: BL1PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:208:256::8) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b04fdf43-c57d-4a66-97b7-08da2f61da39
X-MS-TrafficTypeDiagnostic: DM6PR12MB4074:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4074D0A6E35A5E1912517F3FC2C59@DM6PR12MB4074.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2bO3qGUnseSpn7fYVHaODfOfn8myVnO+YISU8E3my592PR4uDaoUuPOXauaXGtKLdDJsO+vjrw34M2JsspAl3PgJhAbmq5ewdGPzdCxIni2dZmJpsyztJs4f6ZMS2lefBqHz7RIM5orasTyirEyOve/o/VnvkbECPrwdaUmTS/Ub2WKvth6AQkiWpx0hIn+MhNxbHVdNHWCJzMMyfpxipJjUjpfqTn3EH1nW0vd/t3aFsVRd4dqpxMo6/jRAxMg7eZNuOKn2/7gjkIGvi/GN9JuiaCX3hkfMCbhWDceKwpj05gz73p8NoKNaDNQp0cK7aWkr87G8NCOwew6wAMarFXLs91KvVB8uBnq8R2TciJ3TzRYtIoVmBfzcM854AFtVHvtqonrpe1YHrV8Clc0mrc6LhJ32HJv473rdGG+3nPlJ+ScVNOcnkCC95WPOUUqz/RXbejBm9bv80wBWSg+GzL27riBfafMCt2WsOQUaqB49A16haduowtrCC+2gxro0pV3bU/OtfBTuZNEthRGrCs9q35aicQDr22Gbekg6O4PQIIhEu5G8UBYHjadVNEzKMO/OZyFlS+uJn/G7dNI36I9T49SNoSOkUWYjwJA8Zh3yHV+MF/67jws9z21Q4vb+hlwbmdt3q0ABylmwUuPiW0VxCEhFKYsaZWzCJ+1WJ3nhzy4zTWFuJnXDn3IcNikcRKWRsG/84apvzDz3dFvXYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(33656002)(6512007)(66476007)(66556008)(2906002)(66946007)(83380400001)(2616005)(4326008)(8676002)(36756003)(1076003)(54906003)(6916009)(38100700002)(186003)(26005)(6506007)(8936002)(6486002)(5660300002)(508600001)(316002)(86362001)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d+38kYVV0kApKiBGOCFh6d7u+xBJcQwv9bT/d1KeMHQt9RdME2vOmHofxpe/?=
 =?us-ascii?Q?UxuGiOIn1ZnUFbOYiwKFCwTgNUFwBhsoXYgi3tEuIfFXLxJiO8nQ1kkLm3pP?=
 =?us-ascii?Q?1XFSwmpGTHFgUrQcBtoypcWjhDORr/m9KRc7Yvfk13IApxUy0rU9u3vxdzPY?=
 =?us-ascii?Q?ERYMU2SPQYG5F5sbbXekw8rx4IGpyWT135s689FGP65mfgD6/nvcYYraNfKr?=
 =?us-ascii?Q?K67xdb3D14YbSDi/wE2iLmONoFW5qqJX2HJXxItmoDr5rdc1OjP4xHx4vt9k?=
 =?us-ascii?Q?K7wAkfB209j0ppwuc+UDFnKd5kp2c0rnwQkekS37VxsWL7cY0pUVd25Bn3WX?=
 =?us-ascii?Q?9lPL58LwBqch70EWFTaephHT0ZFbv5eePpEfQIHJNhVgQrhZxY4fo0h9I7hY?=
 =?us-ascii?Q?ml++oqglMccJown4UVmPATDJ3G3nQM5XAieZaAQMvbYYlZF7q8NBBn692r9L?=
 =?us-ascii?Q?sbSTWbU2KQlyUJQISGDQQByCyqhhCQ9NA9PpwZXFNjgT2UfZYePuUo+bIZGy?=
 =?us-ascii?Q?Rs2dRFik3c67nUb4gs35++X/c6iPY2+5RW8ho6JHCTmI9rIkReAJKlqr718/?=
 =?us-ascii?Q?KGjMLsQZm5jtvDetxxWRC2ANKGDngyCScK+Vhyk4t5h9T6wQetLa0EEp8bLu?=
 =?us-ascii?Q?neLFJyvzElD/i8ShDnsCKQketP4j0hRTe06qayWAJDrgK0Dqe9uKZ09pxyhb?=
 =?us-ascii?Q?ubDF1f06JfTrrqYx+cGW3LbGiMJZp7AIfD5Yn0ssAf3h/tL4SzsJVVkV6wX5?=
 =?us-ascii?Q?kRAOSV5+yHVZs5jVDTsfc5G0Y2b9Z8cflcCHWmO/hNFD7RJJPdJfcE2yz4e7?=
 =?us-ascii?Q?WZVTQbduLDxSEEqQ5apsckMn/FFy31kMzxztFZTEV/hmX5/Vd/K5g8f1JEv4?=
 =?us-ascii?Q?xmyw+H0YJbDuSwAttdGfkmnyMvaqlFWKiaehCSKOe51bYAJJOXH6EacUgs2J?=
 =?us-ascii?Q?jpBPVwkbj0Ltml2J4ycwnhCcE8T2gdxmvhFiXbFWEZxeEUob7X58fR2SMWpe?=
 =?us-ascii?Q?5ldjXCHJ8GMzN7ryzApGQuhU1/EqhCpN5aNf8YGljztB+pcQyRNyY7T1ZMUE?=
 =?us-ascii?Q?hjYBYkZAS2FbyRORq/L38u+0TEMsTDN66RIuiQupEEx6auANB/n8uxIHCLx0?=
 =?us-ascii?Q?ojwbOE8G8jfsCegAsL/3Kn9gx9Oko5e4jA9dyJNV6jVFxzEujXf2/qR3GvPZ?=
 =?us-ascii?Q?SUc2QbPuLy1pGo61ewIkwmyTw4rw9NSiUhwvL2MSyiz2gkNvrIEeYgwvI6LY?=
 =?us-ascii?Q?PLXwjAK8lUCEHQT9UVcATRlJgJ6SlCA9ggLsufVxXIYlI6StSYGtFqH9HJXT?=
 =?us-ascii?Q?XPqirC+M6l0L+3aP7tAHeo3xiuU+TZhruvt+BZIoe2OVldtC63VQBQ5y/uDS?=
 =?us-ascii?Q?18yPxmBTU1P28l2LfFl+6G3Yref+DDqDhW8UvI6SPX3aApijperygb22+i+A?=
 =?us-ascii?Q?wQ6xUfvaL9GKIM58BAE+ve6Jdl4DZIQfG0Dppo/VUgXHx8bhVL9dydJTOglU?=
 =?us-ascii?Q?UQF2sWXArmWT9WzuywsCYv05OiNYOk0fJb5sS8TH+VBeNWWSfvCJDDG6HSlV?=
 =?us-ascii?Q?s4YMg+yGl+Xr+wCqV8oaLamfqBUMWd3jNpe+m3fmXuxfAJcnqcYC/8iGplMS?=
 =?us-ascii?Q?G91kgtPAUxmfYJi9TFxROzir5p2XX0YN7Wbft7WuBOJjpu+TYR3hRcq4UhDC?=
 =?us-ascii?Q?G4ieflO423vRYlEK+7v/dFffiwZgUCeJJCuUvoRPIIwCglDLCdIsm2toyUpG?=
 =?us-ascii?Q?dfffFy31pg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b04fdf43-c57d-4a66-97b7-08da2f61da39
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 13:10:54.7461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/0BJEj785YdM7HOUzKqPjFmTY64z0YGIlwhpnjSMzEQkrvQ1YipMi+y/wUCRfZl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074
Cc: Will Deacon <will@kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>, "Rodel,
 Jorg" <jroedel@suse.de>, Qian Cai <quic_qiancai@quicinc.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

On Fri, May 06, 2022 at 10:32:50AM +0100, Robin Murphy wrote:

> > > It is as discussed with Robin, NULL means to return the group back to
> > > some platform defined translation, and in some cases this means
> > > returning back to work with the platform's DMA ops - presumably if it
> > > isn't using the dma api.
> > 
> > This is clearer than the original text.
> 
> Perhaps we could just leave that sentence as "Otherwise the NULL domain
> represents platform-specific behaviour."

Sure, there are only three drivers that use this call path and who
knows what they do I guess..

> > > Soemtimes. This is a statement about the required
> > > atomicity. New/old/block are all valid translations during the
> > > operation. Identity is not.
> > 
> > but new/old/block are not the same type of classifications. A group
> > has an old domain and a new domain at this transition point, and
> > both old/new domains have a domain type (dma, unmanged, block,
> > identity, etc.). Mixing them together only increases confusion here.

Block refers to the global concept of blocking - not to a type.

> Good point - in particular I think the "DMA is always translated" part would
> be more accurately said as "DMA is always managed". 

So you want to say "DMA is always managed" when attaching a domain of
type IOMMU_DOMAIN_UNMANAGED? :)

Lets just clarify a bit that blocking isn't talking about a domain
type:

	/*
	 * Changing the domain is done by calling attach_dev() on the new
	 * domain. This switch does not have to be atomic and DMA can be
	 * discarded during the transition. DMA must always be translated by
	 * either new_domain or group->domain, never something else.
	 *
	 * Note that this is called in error unwind paths, attaching to a
	 * domain that has already been attached cannot fail.
	 */

(aside, I expect down the road we will have some domain capability
'attach is atomic' meaning if new and old have the same translation
then there is no disruption to DMA)

Thanks,
Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
