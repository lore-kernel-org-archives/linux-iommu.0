Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0821FC433EF
	for <iommu@archiver.kernel.org>; Tue, 24 May 2022 13:50:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A6E9982AF8;
	Tue, 24 May 2022 13:50:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ina9vK_U_LbU; Tue, 24 May 2022 13:50:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 91589828DF;
	Tue, 24 May 2022 13:50:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71836C0039;
	Tue, 24 May 2022 13:50:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A782C002D
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 13:50:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 17FEC41855
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 13:50:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7wMiaRJ8GLIb for <iommu@lists.linux-foundation.org>;
 Tue, 24 May 2022 13:50:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::604])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1E6F5410E3
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 13:50:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2P/1MbU9IZRbaXcevruaidYAdClzqz8MdK2a/uXaPfyolvuvH01dm7bF707YMAcYrvvpSPESYgiwvbEvZsSdRgVcpNMMOGPTTxoudzxJEsIIQqRf4O+1V94raSIn06SHKEnbyQGWipr7b+Jfp+BGDVnLrLBOaL6P+7NoyhFQMjdLg5oSubaSLKkPRv/vlr0dA2H1Ry6AospoXE1Kg/0KINmuX8o4aBo0+sfRLCcq7hcREmpOB24JN/5nr3FzM2fHFpNgQmz2RSibQNB8Cpb3elFBfzz95koWsuEZqoENPp8h5OnKwn5LytVYECJPy91bS0xV2DhVLiyK3cOnkDZ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zNw/79ZZCAjMskAJk5IsIuvL8TRaN6TS93AEOMf4BU=;
 b=B+5uNgv3P0H31ztWWCpOY7NLPM3vzsI2gT9xB2HiN0Mv/WISunUg7B2K/VfDSPMeK0vsTj3VxzUncnMHVP7URZZmiO1TwWQCqzzhtHh5IDgF/zC5IakWGmQIHaQAcxk2X/UbBkAmY05L8+4LJ6jYZ2iXPRUXZwRJVzrrE+apoa15OkeGV2xUioiYD8ByBwQu5K22xwk1qnPPVWsJ+x4+0lFFooYyZ4DsiwZg3+DHRKGipsxvSn1jCfx3vYU1WJ6Gc3SIZjIpUcCPaSiWcjq4x5uSjnXBI379Igplivl1XVtMy8YX6IzVrxdbiHywSxa9T8klNMvhJIdjmIJQwg+lyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zNw/79ZZCAjMskAJk5IsIuvL8TRaN6TS93AEOMf4BU=;
 b=gMPcinGlywEpvqdLvauWt2e5/mVm+U3zmu8K4r7jbOG6VvKflcI+OFKb7746HzrChAPYMge8r5QA99SrkkZnqwS49tPEq9jzOVzJpDyRTZWwCze7LzKwT7VKy683oVCMUG7HBRuqSyXAiXP3EU16Eb4Jw8hkpf44L2QuY0Wh6xvV/NptCPmscczJyanAGL77oW8wJdvumer1M9OwY9We0DtV0Li4Teg1eYiP5UoqB2uEf5z2PPsA+RPRkzwfppuXOo7h/lBzPfbVfkZrJ5DMlixqLmRlRI7uHcrP2JL80EDRxVZoDxw20ytXudLnE5vGZKPK/q+3Jf5KoW//hJP9aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN0PR12MB6270.namprd12.prod.outlook.com (2603:10b6:208:3c2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 13:50:35 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 13:50:35 +0000
Date: Tue, 24 May 2022 10:50:34 -0300
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 1/6] iommu: Add a per domain PASID for DMA API
Message-ID: <20220524135034.GU1343366@nvidia.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-2-jacob.jun.pan@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <20220518182120.1136715-2-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: MN2PR20CA0037.namprd20.prod.outlook.com
 (2603:10b6:208:235::6) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bac18a73-171b-491b-19b1-08da3d8c60ba
X-MS-TrafficTypeDiagnostic: MN0PR12MB6270:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB627006C81B01289AFEAD4E9BC2D79@MN0PR12MB6270.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QtVAaglkhxZ5gb3HHzvN3v4OxJ9CFRJePFXfnEdH1EpJoH3bfM+o11fOaHC8zmLV38DH3wwWv1HW6LndbGoCAEmh1RJLVxM/x9qaWntjoxj8JfVS0ka2121PQ/FMCFBkEAhcG9iXqrxZy1xbbD9sPibuHwGFn92XHNsWfRWf5YC5dP2c1hkw1ewQASL66KpFFJfUk22Rrn77WOQ4Yb6fHo5jmTbQSxgbM530sMPO1ZxWao0ldpPJxRxPclXGvV8e417qz9MJ5cqKGxxxyzigCGHBqeA18VkvH7nQjPkC5JEe+xB89vJ3Al3f6Y3XcYHbC0kmRqnh6XQ9niBK+sVeu5EJydrkdaA0l0mzDapv5WwFycRetErTEV09rFes0KHmOfZ4eA4UTOdSKFXVYw9JWWISa0fcsUEOVv6nWKR87C/8wZGZYKkvu/Iu5sl31LSWMjtGArahIARpvfRWdVjZTO9S02wjifILUiyN2C5rlXFX9HDOW7kezWU5RXptIQvZFzRj4U5WP/FaJms6Z7Bo5imRVLgJ/HC81Vy1NrPLnQEiQaDFg+V2NWpX2Tt/8y/sL0qqVUcyvBS222dPagLcawkonUy1G/2KjgSPHvoyBg/PkgroSfQpA/sk72AThuUoYRhW7Rn95nm8wSO2d3HNOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(4744005)(5660300002)(86362001)(7416002)(38100700002)(8936002)(6506007)(316002)(54906003)(6916009)(83380400001)(6512007)(508600001)(6486002)(26005)(66476007)(4326008)(1076003)(8676002)(66946007)(186003)(2616005)(66556008)(33656002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H3qYpZTCiDesTxxGhSe/NubcHJfjfZRmuWUDUs1xtbxJYtdp2/k2/XSAFojm?=
 =?us-ascii?Q?ayDooaKsV3WkGo98nlhiwPLQF8pkGQhAQEAx3CZZuKBtDG+4k16OMsDPlXr4?=
 =?us-ascii?Q?poL5TcKBtE10XxOnhMdUJz7jhhFKX/3BPdXmc6CcqANaLAbip7JBAAqC4d54?=
 =?us-ascii?Q?hTqDwwJrdgMoZ3Qwweo9PfcIPond0IFEAZMNgNFHBJhh5XxceQBkTXgGHsd5?=
 =?us-ascii?Q?kvBe9kZrv5+zKIqybM+wEOWxV3E9wVOcjHuC6Vm86puHv/BHm9dHlA2FWJui?=
 =?us-ascii?Q?rm/rKq7CDs/4yfRbZKKSVPU10dGaDO9zoNHUIN852wl9paK6PBjykWu/Zw9Y?=
 =?us-ascii?Q?LTgjzEIGMI3KKUWJWDhL8TNrXY15XVArxXt3KpKgBqYCoFxbF3gNbB5Wp8WO?=
 =?us-ascii?Q?gLwQg+CsYfzBfqoeh1SqK+R9soTiR7txpE0NydlV07zI/JdlMVM1LqlqUpMR?=
 =?us-ascii?Q?QsVx+Dmg/NX/rFyXL6QUZbLmO7iuFnKMAemnpw3IuZvHF8yrhEBH50Cwr7e/?=
 =?us-ascii?Q?9lMEs/PLfKNWgmfEH7SrFLDQKQ1gvrFfzBB8jPZgMt5t7HSUPhFUZm03ukBv?=
 =?us-ascii?Q?roEI+OUQ2/EoF9vG1GZSDNVPa1PV1AGoVax4yESi0qL1eoKF1afx21znsSaU?=
 =?us-ascii?Q?J+IYsUVmGiVnrg+2dj41voakc8neInYClpcODVdZWiVUpTAxDoYxIymmYvRu?=
 =?us-ascii?Q?js8Q+OTHlynUgMEmCKfXrDHRwSHeeByZZNw80nc0YZEY4KDszCkpFeBMR7LP?=
 =?us-ascii?Q?UzziAgZ8z991cTMKwXpRqiRgtaXiuKMQ07yYUXbuHlwKnQsMhhg3oxZAc1XH?=
 =?us-ascii?Q?c+/Eq3TQfvfbXfNG1IOf7GWV7nmv3WNlIlXKmadRS/WirW2tRfHsEEyD+QZw?=
 =?us-ascii?Q?XOklXt6cLhZMb/2I8Fb7KvoUZs4vQU2Yu6q2icuzvP1FAiOPwnOGHaO4UGPE?=
 =?us-ascii?Q?yIy/3yW7wX30Cd3NnZfOrLf9Q8DnskbkxchpnDUW6mkOQ45mrrxtiatFBFw0?=
 =?us-ascii?Q?Wz5JXAjKtMuHQaOQPhS4KUghxu4lTkKeAOYmfs33gfhm96Ka7t+wqfc83hGW?=
 =?us-ascii?Q?Q8tt/sQx4pKY+kCimn8weGA5ZaIQIEgtqNT6mKsXsGs5XTAIdEcc0yiRakVM?=
 =?us-ascii?Q?Jjqqiy23EjhYqvYBDCIGvJ1FjBZY7G5H5/K1KcwKMejApSsk7hq10aHtJCM2?=
 =?us-ascii?Q?O9CM0k4Tnwo9rKIEGggROFFIw0jQXYPYVio6wRe0m5gwlpgYHhihpeKDoWB9?=
 =?us-ascii?Q?ip+7roLDJQOPGkZFcxYLnKZ2l4Jv/S0CeXHm+roOcr9ysIREr+Th8gVm5MX1?=
 =?us-ascii?Q?DROhgqwhIoAhev1RUlGiK8xynlbOBuqHzgBQp3Cc2Yc21c0ZjjmpASm/U5uE?=
 =?us-ascii?Q?IxzRplDgShXiJQBkrvL7N3gq4oLcIEPfKt8B3qSoQv5ax+HUuoiaH/esB9Pk?=
 =?us-ascii?Q?DJu88Cl5DN6gzwKwhG/Jq4Z0gIntcQm0OX3ELa39HYFlXhyJjz2WQlLryRqW?=
 =?us-ascii?Q?h9BuO4XeUhkupCPaJFInNPcMf5Y0GkFZRKW2h7vUVJ0MRWMzVx0oPMlUFZz+?=
 =?us-ascii?Q?uX0SPoCItDG3vtu69QcrIYEhh5y3r9WOTmAJAlpv6gntbW1gliUo5a9xZqEg?=
 =?us-ascii?Q?PAfX0Fs1bYTB3c0kImRVFNKPN6uWlYpdU72wQKXyNFGaP9wxPMz9nZrMikO7?=
 =?us-ascii?Q?a3jpDwYN5t5EgruJG8gQUgnaLerBZOMskRX8w/LiYmhUgWRagkGBczz3XGK9?=
 =?us-ascii?Q?N7K3GklCCg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac18a73-171b-491b-19b1-08da3d8c60ba
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 13:50:35.4964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqWOhuk9UWY1iStJKlvIz3YNx6Y5W3SLwXBt5iIuiqZ5IZ2zqX4YIQ5MYLVinbVW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6270
Cc: vkoul@kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 will@kernel.org, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
 robin.murphy@arm.com, Jean-Philippe Brucker <jean-philippe@linaro.com>
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

On Wed, May 18, 2022 at 11:21:15AM -0700, Jacob Pan wrote:
> DMA requests tagged with PASID can target individual IOMMU domains.
> Introduce a domain-wide PASID for DMA API, it will be used on the same
> mapping as legacy DMA without PASID. Let it be IOVA or PA in case of
> identity domain.

Huh? I can't understand what this is trying to say or why this patch
makes sense.

We really should not have pasid's like this attached to the domains..

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
