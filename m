Return-Path: <SRS0=Qw1r=KC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E3AC433ED
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 17:10:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85CB76147F
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 17:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CB76147F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2304E40150;
	Fri,  7 May 2021 17:10:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jN5_PiYTkSl7; Fri,  7 May 2021 17:10:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 039914019B;
	Fri,  7 May 2021 17:10:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8B21C000E;
	Fri,  7 May 2021 17:10:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 861B3C0001
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 17:10:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5EC2A404B6
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 17:10:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lj2rpT1L7nrO for <iommu@lists.linux-foundation.org>;
 Fri,  7 May 2021 17:10:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::621])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ECD9D40399
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 17:10:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCScQYkHLB/8Y2iWxXYi9vInw1iBpLEvT2DE08ed/3Xk6Aw9jKZ82HmhRv81KsMbXbaxaZR/WSODP58+Ip12fUTqG2QqnsNmtDUGMzlkSzeoeAHCUVmK9WBrCLztQWQ38HqbpVgq161gPdptfPRcLnWe3AvSMC22dXZq/h7iIbBVFri/z6Tm7WyhXFa89iBrq/3K731zOoa2dGn+N8hITsN0w8t8/ZJC+F7i+iBY4w6LKG7GluKJfNhdLiUgBMVpr/+wIx/ieEWTIktD9S4Ec6nDcHcFfCzx1AeUjC5NKUVtgu8KEg75YwlBE3V/uYkqw0cTd1BZduG+gSVtrIxQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0MLvbZBevsyhRA6EvN0IFIo7lI5yPAeclzQDtJqH28=;
 b=g5mtJJYfyHxisWNOKqhCuZ5fZ8j5dnTEucXX8p609ttxpmZsPgA9RH7L/Vq4ENfIZ8Hq0FdnI6ZVklSkgoiR7YP1Dc4zm0cRD0/WRhNDSUQAoAvqQ6eTq5avrR4GimMU879c3fvVk8sGw3NDzp/nqRI/z7gsIjfCF48i3ro7ek3n5k4QBvoFxF2bwORaZqOqViUJ32grAjh3gK1o4VXLHfR8t899i++HSsBejhE9veXqlCShDyXNq+N6ZiEcqAfzimb4FizLwK7GTWlVMtoIS1BAK5coTMps213qXp43xU+pu1LLyRZo0IDWNFrG7cCwk1NY10nDC7b1R89ICvfUsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0MLvbZBevsyhRA6EvN0IFIo7lI5yPAeclzQDtJqH28=;
 b=Ivs88zu21G2JnEM1a7qfGSMjdOynDrACqWCDOh0WSfiQMwQybGgE4iBH2jGuw2z7VP0MibFxOUVJB2xivbgOnG6qdBMV5neroDXfKi+FODxjcCLI47cT1mSn7+V/RsOnYBBrpSJkK/rjVEN6x+aDVdbadoVhCVqgpWpclx7XRyQeJDjSPjTPOPB4VMAXwLqcEwZNSNLc9RCnICOPtj9EctWBCExpWfB/qR+x6mmNn0isNeDeM/cQRb7PsgWF5UPtM+NzYCh4bIwQwQmn/QxnDklVsyiwi/jzN7MBoa6dZNR1eDHVzIn7AAmVJ+z9ts1jVSu18xvroB1siJNcdmqMLA==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3594.namprd12.prod.outlook.com (2603:10b6:5:11f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Fri, 7 May
 2021 17:10:51 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.030; Fri, 7 May 2021
 17:10:51 +0000
Date: Fri, 7 May 2021 14:10:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210507171050.GV1370958@nvidia.com>
References: <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210422121020.GT1370958@nvidia.com>
 <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210423114944.GF1370958@nvidia.com>
 <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210426123817.GQ1370958@nvidia.com>
 <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210428090625.5a05dae8@redhat.com>
 <MWHPR11MB1886E0A7897758AA7BE509058C579@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210507110614.7b8e6998@redhat.com>
Content-Disposition: inline
In-Reply-To: <20210507110614.7b8e6998@redhat.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR0102CA0025.prod.exchangelabs.com
 (2603:10b6:207:18::38) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BL0PR0102CA0025.prod.exchangelabs.com (2603:10b6:207:18::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 17:10:51 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lf402-002vKA-4N; Fri, 07 May 2021 14:10:50 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89240622-d73e-4007-d3ce-08d9117b1121
X-MS-TrafficTypeDiagnostic: DM6PR12MB3594:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3594957CC8341AD2FD0FA890C2579@DM6PR12MB3594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5u23vss7Xf2rZSGF/K9gJ2rvAV+b20nA7QlrwdqoPWHYuJiMcOlT9/74JvTjSFyfEqfYri5fybYibUnVIeNAJiWtNaNLY53PPWLQRx0uIMkrMqLz6C+X0zcHJ8fO25skCdS2JS72sODOYSRNakZbtkzm2ukXMq0Oef8jbchH5th7h0G4Q0+ZL2Fu6Q6YlsHGaOxGHKRfWoge1MQyQCuxD9+1BDUjYyHDr3/Slmaxnal1cN7Nis0k7gsne17axvlheFehOZK2LrsyAp08hwkz9Lkk9jXrnlgmYnKYgC2Ejc1sMnd1lGur8WE5u0fBSowSQJ2IWer+/VlO0rV346A8yehsVa7F4Ppbkj8D+P9+NApAvLEINIQJX2T5QlZxEdr1nlfpqJ1n2Pm3LIwg50CkptToNUpQfj3lfsZ/06QTFGdExIHOcNaUQOVN+2ToaisxRfivjYyeNoMDj5uFkS427/o8PJD63o26mqE72xHp9a04fl93utnYc1u2ZzbX+4JCtQ8DJutQzWSEiI56ShrbQxF6TfmtEvxGCWsDFsL8bV7mIcPi4g28S1nAxdd8bpVvuu1VoOa31Q4Ot5QIeV4z10ettV6iH8RY9XD2EZyEnoM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(316002)(26005)(6916009)(54906003)(426003)(1076003)(5660300002)(38100700002)(36756003)(33656002)(4326008)(9786002)(7416002)(83380400001)(9746002)(4744005)(2906002)(478600001)(86362001)(66556008)(66476007)(66946007)(2616005)(8936002)(186003)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7RMKailXr7+XT2Oy5CZkNfmkQbWDRdyI9qg9VFQfXg61LlkWvyyops4vFM81?=
 =?us-ascii?Q?I+ir8gX6zINq+3aQw4aE4nGkW6UChVRPr8zTLBdrEe36Kk8jcYJ30AsD5OrN?=
 =?us-ascii?Q?ewQoEAMr25XGVo1YJJbdMJf3j5HZLZkNFJDKdWBlA8kjw4yqBACKjQHuEPve?=
 =?us-ascii?Q?7ygXj6/NmDZETmVzEjPheFaUNRJn8s6pwaL9rCkdvnAG4gztL4n2YVxJpvLS?=
 =?us-ascii?Q?6TjgFu9gGnEpvbIpVpWcyr1xykbiDzNUpRYtVr+tG0oNHR/zdfBtIIiVnlJf?=
 =?us-ascii?Q?S5Phc+7CObIHy3bDKDPBMT8LVZbGMZ1xr/BCG6IrCZscm1s0tLJ0Xtcyefk4?=
 =?us-ascii?Q?ig5haYjtO2V4G+T9BQ5wCHQFQhc1GyHrQ/wb6A43o0oONFolgpHH//O0R2tR?=
 =?us-ascii?Q?le+IscUpaOgI4ZpmZBSf1niTq7llRZ6KJTcZNpkSXvq9HRq9Teexe7Gnehf4?=
 =?us-ascii?Q?8IRDNtqTvTv8LCW/yxEhU8kH1abMygsWRNE1lCcXHxIA3zX1t9cvmE5cfl+B?=
 =?us-ascii?Q?Enox4CWCJEpZ6L7VYYboXCQ7H3yFE+cJg6Clr5FeKu/S37gkIIXWmV1ciddC?=
 =?us-ascii?Q?RnyI1vtUHqfpzBMqTIMm0ETWdaYr4JFcsNJS3cqNcY2ppxpWqj+mI8L/W3Nh?=
 =?us-ascii?Q?7wWsCqCooAIvHUDmil0kMDq1OESCr8dIUXQ99nOfDFrQbFENgSt7DGEMP+4a?=
 =?us-ascii?Q?f2SPMAMiV18/zaQEQv38wOFpqG4mMP9yIAAFLV4K3iGHsJHtmdyMOshCJFyU?=
 =?us-ascii?Q?gLDIDsbWalS9HZCbQXYnhLUGvn+G1vgefx95jlgVPBkSZhFJ1jotmdxl1pgc?=
 =?us-ascii?Q?mNXc80rieh/uZ1GIiMwOkAPFEsKZ8+nv2K+6SAvFkKmtW7an6f8iaOWpQ/GY?=
 =?us-ascii?Q?KC2GuaJdiubhH1bwN/bI8alKbUgNlCdF4Qi6adouusMufST4HJQ8f0D0Fk+6?=
 =?us-ascii?Q?BvkFHKNuhdtTRDrl9hV2uoqVSNnctIfjSFKBNnuN5bbg9vVDx0nv0wVLTVVn?=
 =?us-ascii?Q?h+bqN0hJXF7V+sbgWPshOdOOOQYxJ1ldpwP0HF4yrHiGbPPIqpZ545XdFJxm?=
 =?us-ascii?Q?cFBPwCha5keY4ZvnlVm3QLUbjjFqZVtMowId1T3sj/YygFIasY6s5MQyvJ3e?=
 =?us-ascii?Q?xXlLBV9zzP/5yHqNkL2TkC2B+p/MmZpOvg4putOPhq//e3SPNF5caZ5akg/n?=
 =?us-ascii?Q?9y+8MGBm+2STTh8W7kTvfxvrKbCqW20L+iJu5nevAZag82mJWj/xL6IfaxCI?=
 =?us-ascii?Q?4fX6vNThcAyv4fHsTDqlnU6C+2QNH3YIfn/jCugFnPuNJDL8Q4Pd5PeReOyJ?=
 =?us-ascii?Q?hI4MZ6x6BPCkU0gKlD4Qf3VL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89240622-d73e-4007-d3ce-08d9117b1121
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 17:10:51.8463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZzmAhj5hdxGgs3Vr1eUpKx6QCGNfODnPwLh1rLFW8gQ1VAYEaYPgiiPQL0xqAp7M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3594
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Li Zefan <lizefan@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu,
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, May 07, 2021 at 11:06:14AM -0600, Alex Williamson wrote:

> We had tossed around an idea of a super-container with vfio, it's maybe
> something we'd want to incorporate into this design.  For instance, if
> memory could be pre-registered with a super container, which would
> handle the locked memory accounting for that memory, then
> sub-containers could all handle the IOMMU context of their sets of
> devices relative to that common memory pool.

This is where I suggested to David to use nesting of IOASIDs.

Without HW support for nesting a SW nest is really just re-using the
memory registration information stored in the parent when constructing
the children

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
