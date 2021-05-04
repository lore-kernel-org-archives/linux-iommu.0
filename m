Return-Path: <SRS0=4008=J7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7079FC43460
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 17:12:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00782600D4
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 17:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00782600D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA5A141844;
	Tue,  4 May 2021 17:12:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G161wq0zvGPb; Tue,  4 May 2021 17:12:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 373BA41841;
	Tue,  4 May 2021 17:12:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F89BC000E;
	Tue,  4 May 2021 17:12:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 027D8C0001
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 17:12:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DE1C3843EB
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 17:12:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hFKSXTao5wMY for <iommu@lists.linux-foundation.org>;
 Tue,  4 May 2021 17:12:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::62a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6AC01843E4
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 17:12:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAJvT0XhxdIFrouPw4ncDYIO6OhWBJ+AVOcXxhgX78GfLXTrrLlj+dX/ZNTOALByqLefzUfjpwBWNYJwVK+1uLpx50wLpuWeRBq6M2OhXHNhZDukJVDnuQwq5+si/7SaCoLfNUTabFqkZAcyR07lITM9GIyvCQvccvS3B1LT4x35gkxz3hjahbOlkkZ1dRkX6InICDHo5mmzsqAma4pksq7X9hRer73d2Id7WBZdI6QvNJhMpHOkmrz+9MivgH8tvLW/pMBIm/zR5FR3M1rtt4XfyuD5Bz2YQ6UZmwkK8zntEA8gfTNLfgAQmCIAKnSoY3uf+WY2e06D9BWRadXOXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSN88xX3Q2gZJBWMT5TmWuPPEFp8pVrPLrRXRc5cYjY=;
 b=R4rtGbXued6IwNcrxVC62mVSi+1cMaAKwVIyzuE3PqsnhXn27uTy5VJQzY6xnG7qkbucHN566jlMMC75qJ8OESvI33ySnxztTt93F6quWo8wkufVITSUdPoeRbhFEuW6xvRm2met86LFi0mFHJ7DTVnYG7K9xNXhjYJ+2To9PsEGxHEtVpYnl1tdnxFXhq2vMAMLHgx5+5LfhFYzXWJXERlR6MlFbNGdW7v3TKpGXdrRjFzfPEAMH0+msc6AviYMIo10jD3Ylhva8c67Z1265nQ/DQMa0TQxuuUpP1SvDvOj4bAXoW3cG9Y+Zjm7D6zJw3vyUYkJyhstQlkdaPgvyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSN88xX3Q2gZJBWMT5TmWuPPEFp8pVrPLrRXRc5cYjY=;
 b=UQH54ZmBFbgVuE3S29LjyLeixlh1mOvD7ZoTE9uO0av480uA+fYkQ3X8Mb6a1WnjtmQd5XPjDrDJ10efDXbSRPonlJI62k+TxvSwUL4Vqka3hRki9uJ5T6rPnWCfTeCtpZJaHMdG9J7ZsjPYtqRDo2I5YVz9mnQ2gMhtzNLTzfQ5ASSQK3qeaV614a4tF8VMXxddp3MI0KzJcAnGIEPE0X4Qi9r+J2cJj9NIgq2hmWE6SBznbNKO6CoR5OdoUq9mMzcm1ZBb8noOWRa4d0vhboDTOH1YPlZMDPAMwPsEqxklLGIx/kbcz3E5YIdoaXJZbySUcHqceMC+uU9f27qUlA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Tue, 4 May
 2021 17:12:48 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::81ef:d824:43ae:aef5]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::81ef:d824:43ae:aef5%4]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 17:12:48 +0000
Date: Tue, 4 May 2021 14:12:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210504171246.GZ1370958@nvidia.com>
References: <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com>
 <20210422175715.GA1370958@nvidia.com>
 <20210422133747.23322269@redhat.com>
 <20210422200024.GC1370958@nvidia.com>
 <20210422163808.2d173225@redhat.com>
 <20210422233950.GD1370958@nvidia.com>
 <YIecXkaEGNgICePO@yekko.fritz.box>
 <20210427171212.GD1370958@nvidia.com>
 <MWHPR11MB1886F0818D30329172C420758C409@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886F0818D30329172C420758C409@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:208:120::30) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 MN2PR10CA0017.namprd10.prod.outlook.com (2603:10b6:208:120::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Tue, 4 May 2021 17:12:48 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1ldybG-000URZ-LO; Tue, 04 May 2021 14:12:46 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd8c98e3-5e4f-4de0-17d8-08d90f1fd76c
X-MS-TrafficTypeDiagnostic: BY5PR12MB4033:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4033E6C37C28FA0FAEFB0627C25A9@BY5PR12MB4033.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dkn5RTC4t1kMuXM+36rt6QLW4jHPIjLVN+meovfjWfEY1O1dAtccx54tEa8xDVvfYqH16tSLsD+3VZbUVrow1j/oO5p1M4/JYo7YI31/d30AINiCFMZCa26RyU7dCJUaQVd84X6U1UH45Pb2PkqxZKEo0I6JnnkYeON/YpYzscOA9KpSBTHSJhwGF0fn0sCRLGusgp7E93UAq+pABDRSEymdzA/vKOSwfWafr2BPBAGJRCDPB3HHesgKxFWg6SM53DNmHmTxN79Ty4ZKrAeBkG5n64ZLcFPCp32ut5WTldZ3icwiHcwCKXs6UM2GEdKXOLIzaooT1gBYlL8VkPJICZ+nNC7vH6LiW2Q+w/8HJ2m6+x/3Iv38kQWsSrigSmVLRbyXuun25edqK1cqSrF24J/0qys1fzpBAca5gOq4HHA2j7cBH4LgT2/aGSy589z+aOKDG6DgRcSTtZRhM/etO6tEE3CDxotXbvEDxcXV1w7w284QXtZIGl27TLtnJhaeEkUjnQCVdPE7dirs8w+yPosrhD5CDPLgomx12VJXhhu2wWAT+g5trs08h7HwjOCo9VcMw6KlC4Kjxm/rcjSgkS77+r6O+r8r0LiP/tTdNdB7Wp/OS4RDDCzxVKe3Yd4q+UQEXIRP3ephfM3pdjk16w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3827.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(2906002)(6916009)(4326008)(66556008)(186003)(7416002)(8936002)(1076003)(2616005)(86362001)(36756003)(26005)(426003)(54906003)(8676002)(66476007)(33656002)(478600001)(9746002)(9786002)(316002)(38100700002)(5660300002)(66946007)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YHQwH98q+c9gLafb8f6tHdF2NNbJV0V9MxfL1LykRBq3Pt/W6TOfKK9iTz5B?=
 =?us-ascii?Q?REGlt3woz9vQBJqmh60sQ7XGcV86/LDUDw8q6RM3jJypCj6jjfxubGRqjkrF?=
 =?us-ascii?Q?hIKo6hYzQlgQgmiOzY7mcrAeo4g3gBmZlfKpoPYc2+Dwk+vUQ2dOrLsOpYU8?=
 =?us-ascii?Q?iNC9hJnJmHuZgGAT93IrfD+DM5UwfHqPf46CzduJUtuxoIe6GMiw6tRZQeY8?=
 =?us-ascii?Q?8C7f3LMyBVVsIiEYrvzOkhjgR+Hsnga7jD8XiIjDEiK0Ywhj38s/Npa0CZTq?=
 =?us-ascii?Q?UlDIu62SsZfXa9CCZcn+XYczTT6q/mgystttT1tIkPrMUtCJFY10ukgHQpu/?=
 =?us-ascii?Q?E/3U098iVmKHs++m/8FC51iNPWJj8+sPUWoNJzMqBbgjnktSO7nZjPyat9q4?=
 =?us-ascii?Q?0nN0h6H4WnjPbafxxIkEANDrg2Ge1vTqvQf7agYuX9pIsJm2NwVBRHHz3j9e?=
 =?us-ascii?Q?pWNVL7OivyFzFcaPWtxU1JeCs0NyrpoXQO4erHpEkVDSEVRjYk1oxdo4vTrv?=
 =?us-ascii?Q?QB4iDQyD5LX1FNimTk4ABOyw5zTTFuxEMZdccmMNlaZ7x1CQ9Jr4aAxq9hAi?=
 =?us-ascii?Q?TyHgFkNRt4dpf0OBHr60tFeQRsnZjNtUd4tmO0zdE2c1vS/C8EzgbMFgC0S2?=
 =?us-ascii?Q?rV26huv93zgM9hX5vmxLPP7trxBqWmFzWufLSrbVCiSeDviWj+M7ox4/9+EU?=
 =?us-ascii?Q?jBTUHJCiFA3TAczYEMCgp992SqTSRS/Mb30oAPJEDTUQDiL7L3IEgLiqmMj9?=
 =?us-ascii?Q?fSHdTE1sIiiQHOjemnxHPKgy+iNDKb/WxQf332MoFJ0T+queMlgOZlURK/dQ?=
 =?us-ascii?Q?OURMvDYIay3HKwQTFyfcXVQCAwA4a+Yp9XeZRMAI5+2nsv+MdBLYaVNnO98c?=
 =?us-ascii?Q?JuktXU8XngryGtKswSv6WPEbd82RJVVqHs8s5fF4d/SEHqfl2MW49J0LpWZY?=
 =?us-ascii?Q?Hgak22KbMuyyTNGi8Zd0nTLiik0uQwTjg7ajTVzR0Uencq2j+5ytg1eANLWJ?=
 =?us-ascii?Q?NesVsuEot5g9uZtA0pI+OHTPzT1E/Pt0JjCTc83tdAJw6aWiBuUAMYHAYJ99?=
 =?us-ascii?Q?x5KQ02SyDPWbCsXSTShWNiYHh24GGrcJX8wWNlBbKD8ENQ8G+HQjyd1t655o?=
 =?us-ascii?Q?RxXHDTW11biKTuUKBWIAingOYbQb2YWIyfLgNZYsACBLolRH33sLmnYRvtzQ?=
 =?us-ascii?Q?VAx9i4kJonPj0PiNrmgr+W2WbX+PiX5lUeCyJ2oszbNNRT2Go5oDXSMdsHpW?=
 =?us-ascii?Q?NHgnQ8AjtWoC+EaD8Z3mfvG2Lzt0z/Pgcsz7YRMY2tUKaHVFjyNf7zAgBZkI?=
 =?us-ascii?Q?5/jXjT5XsBL0KhZDiL4GGhYR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8c98e3-5e4f-4de0-17d8-08d90f1fd76c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 17:12:48.4882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aaNVvhyjwnneGeQyz/PVMbbT0mZP/yKdac88I9etK9sgwvaW/iCFfR8PlQ4fZH1U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Li Zefan <lizefan@huawei.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, "Wu, Hao" <hao.wu@intel.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

On Wed, Apr 28, 2021 at 06:58:19AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, April 28, 2021 1:12 AM
> > 
> [...] 
> > > As Alex says, if this line fails because of the group restrictions,
> > > that's not great because it's not very obvious what's gone wrong.
> > 
> > Okay, that is fair, but let's solve that problem directly. For
> > instance netlink has been going in the direction of adding a "extack"
> > from the kernel which is a descriptive error string. If the failing
> > ioctl returned the string:
> > 
> >   "cannot join this device to the IOASID because device XXX in the
> >    same group #10 is in use"
> > 
> > Would you agree it is now obvious what has gone wrong? In fact would
> > you agree this is a lot better user experience than what applications
> > do today even though they have the group FD?
> > 
> 
> Currently all the discussions are around implicit vs. explicit uAPI semantics
> on the group restriction. However if we look beyond group the implicit 
> semantics might be inevitable when dealing with incompatible iommu
> domains. An existing example of iommu incompatibility is IOMMU_
> CACHE. 

I still think we need to get rid of these incompatibilities
somehow. Having multiple HW incompatible IOASID in the same platform
is just bad all around.

When modeling in userspace IOMMU_CACHE sounds like it is a property of
each individual IOASID, not an attribute that requires a new domain.

People that want to create cache bypass IOASID's should just ask for
that that directly.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
