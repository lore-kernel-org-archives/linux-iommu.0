Return-Path: <SRS0=dgoC=IK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6AEC433DB
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 15:12:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CB8564FDC
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 15:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB8564FDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4565E4ED33;
	Fri, 12 Mar 2021 15:12:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5v92dIgIgco0; Fri, 12 Mar 2021 15:12:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id D61F24ED30;
	Fri, 12 Mar 2021 15:12:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B042CC000B;
	Fri, 12 Mar 2021 15:12:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B70F9C0001
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 15:12:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 98508844D3
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 15:12:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gb50xbdOIhjN for <iommu@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 15:12:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 445A7844C2
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 15:12:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/Cg3uEH6M7VOqkn3tPyXQTA8hgo+3jiY6FQVgvPcuN0LS61yRXfsLoZNY9Sfqdl7x3r9ewij7c6ZgYGXTuD9ONac7psR+W+AT+3Aop2Zlx43gwJioDegnDhknzszUrHarNBT6x6cdN5gA3h8UFg1c26FrvwaL24etciLDm4QgN7RWSRDwVY23UV88zzukkUPx7SqRjcDco6uYW9H6N8/9wVqhDxIrMiXrtuJMbYOsYgNDWCnZFtOrx7tdye3HeKyl6v+Qb4jnbiob6Su7QoAVLF/FkBKU5Ln+S9ACsDExcW7IRfVyiYpkRGV91GpCX17p3x5T/ukDW+l8vMRA5W9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrKz109+QtTaiqMToTFOgc22uC4OAicGA0DKsvjRXMY=;
 b=IR7ryu6LQyX1vmCBW4xmOCorzaqCBg+TIexQTr7gzFH/WYfWhLYU04NIy7qPWa50kBMIGp3+38//8c226Nm3e2CyD7AgEZiwADnJhiABrkioAliPC3f8aSKr3LrIxjRhcLyBaGUxbAZfo0tF5SNgd9NCrf57rAok1Sy/4+lDunQe9oZ2263W+RhobowCn9vNUUpQm8D66TK92Ri0+tVhVU8acagEQu0pBJy3KYlRj/BQ8l28J/k2Idl/EiIUnSafysI+ZlupbuMy9CTQjb1oWEisaxshvwK19iylpvjyK+reHgq3rj4/w+o3PLhqA/TysDEma02Iv/sty1bQXM3S2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrKz109+QtTaiqMToTFOgc22uC4OAicGA0DKsvjRXMY=;
 b=MI8se11LehMz4nD8CW+Fe1EtXtt4c2b4iNfnNwP0vEKXlEtBv5JuMqiLBd+S5nq1fx4CKudRZzUBzu1F5v2syyushNA7k6rQd+4QDqZIHJd4wAi9u3vbVJMRq4hsNPoagXSMUs32rpns/1o1b3Kow++aJMRMxrQQQS34S84atRstbgPpA58S1vv3QCqujaZ0Uo8vUi++CTf+yIiJie4wCu8X05adN5vDnfz0N7HvFYWD+AtXzZDjCZAnBWJVCurO0QeG13mYO6o/1R9okVqHzOwS0+txC5JoNCZ1igDxsN9uTrFkV8Tk7DCp2rLCWq5Zzcw/95WhAK6gotNX+wbEaw==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=nvidia.com; 
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2938.namprd12.prod.outlook.com (2603:10b6:5:18a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Fri, 12 Mar
 2021 14:54:42 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 14:54:42 +0000
Date: Fri, 12 Mar 2021 10:54:39 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [RFC PATCH 18/18] ioasid: Add /dev/ioasid for userspace
Message-ID: <20210312145439.GD2356281@nvidia.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-19-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210310192301.GC2356281@nvidia.com>
 <20210311145534.6fe9bb9a@jacob-builder>
Content-Disposition: inline
In-Reply-To: <20210311145534.6fe9bb9a@jacob-builder>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0305.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::10) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 BL1PR13CA0305.namprd13.prod.outlook.com (2603:10b6:208:2c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.10 via Frontend
 Transport; Fri, 12 Mar 2021 14:54:41 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lKjBX-00BwIz-Sw; Fri, 12 Mar 2021 10:54:39 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 668dc24c-10f7-42bd-7822-08d8e566c43c
X-MS-TrafficTypeDiagnostic: DM6PR12MB2938:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2938F43958F2B51C2C8C6908C26F9@DM6PR12MB2938.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JAqJAS6YzxfhMnw4Y7DJqZNsU3b77EKHxsr3JIJrnvU27ElbKnzXPfEGpN06+zIfyjgEyLwKMmKLajWmChKGVsHnOedRLGCTLg1MCUFzCETpbNKwzUGGIopqy235vbgJvPvYPqVcPh5fDmKHsmWNz4p1nyNcUyOjU1ozcVXh5M9LGouComOTQw5u+fHuYu1bzrA5BWxgT7JxT7kvftVarKvR/Q/90Dtf+N/YzLoXnCO8KwCzk1DVE0dtpUKeKQY4QFwEgcCuFKy6G/0dGTOhdKCY6km/3pUhi2B8NnZR9wz0kmUEIx7G46o2nbDloKgmEr+MFe8v7xtgqXTO+Atw4u5/2sScQAJ2q3S/vPehTpd+Urrs2el2ppJkxpllTvi9jJk1fLQG3nuUUwkPjC99+dX57/jzoz/55xDM3cHh3odYAqMD4Rp1NpUden/EDbGDUVlzfiYzrfLoev2XzgolmxiTQip7/AX/bPFaB9FtQmd3j6dE8/ApzgxI1K8DVS1FcFjEYBRaPpvhxjGQ5V0DL/N7uu8Q5BQ9tYgbah7eHjzPgnhJX7TNUV76WnFQuVFy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(5660300002)(1076003)(7416002)(316002)(2906002)(9786002)(478600001)(186003)(6916009)(54906003)(8936002)(9746002)(426003)(26005)(2616005)(86362001)(4326008)(8676002)(33656002)(36756003)(66556008)(66946007)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aXrpdGF12x73C3geqdd9IUXB4zCmFm3irTTmtVD6uRYkSUQlYJB6GjoluwPm?=
 =?us-ascii?Q?bK/KoxIdma99mD9lm11vafRffvqUyoAOEdNqWXWdvQAzU6alt9s4Luf8ff1O?=
 =?us-ascii?Q?RxrtYw5BefUxNt2KQa4femYB04LI+k2e0UEraqhmhb4usrCiwGBGOHHBnDZx?=
 =?us-ascii?Q?zvf3ktZoBPUgki8C2K6BfoMQGBwUp/cnEQdbDcgMKpTg7rsAPEit/qKdzw4p?=
 =?us-ascii?Q?y6WUtfMDoWd+QwrULpnqmAmtGkXy7qUWlReEIPcHO0ROBKqdNz68wBGdeFdV?=
 =?us-ascii?Q?qwoNgmk4KkVSt+Nc9zZFp0lXdwJ8ug35oTEyztmxKtRKAoSBI80QIM51E3cF?=
 =?us-ascii?Q?0E12PTIZf06jV/+/Sb3l/8OXYa19fAA9k0X1vp0DBnfuey+59KiSUvVUyPSy?=
 =?us-ascii?Q?eIDCzvxgBpAtfKnaXmh/JHDvU3Ctv451joiWiHanq74Rq8pRIZ3GCYW/JJof?=
 =?us-ascii?Q?Yf0QLy5GvVU9xiJU3ISfQzMje6JwhBGbpLrJWpFXq/lxWI5weRMJPrjYosz3?=
 =?us-ascii?Q?5aa2Bkgfovl1nu5berg0uKduDlFu6ssF/Q/+NJhhLavCUyB2jPwtkVZVI3GN?=
 =?us-ascii?Q?Ztqd/H69oCJuW1iENQp3mvXz8hfape2WjyMyc3/Gy8tK5CNtGlRZ7z0TxFYt?=
 =?us-ascii?Q?LCdTdlJjxm005YbkCVgKMlCPGnLnZXMqm2dWbFigoaEnuI3xiffcso4gBQe4?=
 =?us-ascii?Q?CSbKjexuR0QN8nwa6Q588cqalWYkBsbekZVeW5X7u7vdmQLFTFIYjgs6k1/3?=
 =?us-ascii?Q?JO7m6GqEJjJtZBJI8ZmKtWB1i1TMPo2UCSQxrDPcEAcL33pehRnGMBQ8CqGt?=
 =?us-ascii?Q?T+dZDXRcGnwh9ZF09PaJATGGzWfUIv8Bd+eaWtJ++P49Y1wUQKMxwHW6HYS2?=
 =?us-ascii?Q?EWdZur4lZ/QvkB9twTrnrz0Coq+Kugf5ipZJu1A/tS8VcNo1owqupYIgHn5H?=
 =?us-ascii?Q?7UmS/KKkltKfB8p04WW6nTr8QE471mwNNjtpOnhKTPS1HI2GECbWZGwlTMgQ?=
 =?us-ascii?Q?FiFEsRh8jq4sGtzC9By3K5wXX2c1pHMcH6jxGrlUVs6AVj2VOCaOZ7VQ0RDU?=
 =?us-ascii?Q?zA/0oJVgIqaNF8BIuIuK48uwY6CxhXqz2eS03sIpnBchvaQ1HbPvqdNKdi0z?=
 =?us-ascii?Q?7bvhLTYKOuGUx0EfpCNERjdJ9pK7w/5aiJtDWBjHb/+8POi/Aoo6QlPaw72I?=
 =?us-ascii?Q?0Qy3FS/ynhGn/ui0EMUa+FRJjWF3AB+Nssf0+uMEB2f2CBLYlieKQX9a4D9h?=
 =?us-ascii?Q?tUprYDhnI8iYmmd9tepSwLMS7h71k+PEeh0utxO2IIb2AH0tBRJjUETF/6eE?=
 =?us-ascii?Q?chFFee+0xXhvUcHtGffqgMuW1JDNrgwIy2+ZkiRyKNykLw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 668dc24c-10f7-42bd-7822-08d8e566c43c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 14:54:42.0194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nf2h16lYqkvpmjqLkygwbxNYbCASjNFp3fy/D/zcJd3Sff0qI3JXigSUqwGkoyRH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2938
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 iommu@lists.linux-foundation.org, Li Zefan <lizefan@huawei.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 cgroups@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>
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

On Thu, Mar 11, 2021 at 02:55:34PM -0800, Jacob Pan wrote:
> Hi Jason,
> 
> Thanks for the review.
> 
> On Wed, 10 Mar 2021 15:23:01 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Sat, Feb 27, 2021 at 02:01:26PM -0800, Jacob Pan wrote:
> > 
> > > +/* -------- IOCTLs for IOASID file descriptor (/dev/ioasid) -------- */
> > > +
> > > +/**
> > > + * IOASID_GET_API_VERSION - _IO(IOASID_TYPE, IOASID_BASE + 0)
> > > + *
> > > + * Report the version of the IOASID API.  This allows us to bump the
> > > entire
> > > + * API version should we later need to add or change features in
> > > incompatible
> > > + * ways.
> > > + * Return: IOASID_API_VERSION
> > > + * Availability: Always
> > > + */
> > > +#define IOASID_GET_API_VERSION		_IO(IOASID_TYPE,
> > > IOASID_BASE + 0)  
> > 
> > I think this is generally a bad idea, if you change the API later then
> > also change the ioctl numbers and everything should work out
> > 
> > eg use the 4th argument to IOC to specify something about the ABI
> > 
> Let me try to understand the idea, do you mean something like this?
> #define IOASID_GET_INFO _IOC(_IOC_NONE, IOASID_TYPE, IOASID_BASE + 1,
> sizeof(struct ioasid_info))
> 
> If we later change the size of struct ioasid_info, IOASID_GET_INFO would be
> a different ioctl number. Then we will break the existing user space that
> uses the old number. So I am guessing you meant we need to have a different
> name also. i.e.

Something like that is more appropriate. Generally we should not be
planning to 'remove' IOCTLs. The kernel must always have backwards
compat, so any new format you introduce down the road has to have new
IOCTL number so the old format can continue to be supported.

Negotiation of support can usually by done by probing for ENOIOCTLCMD
or similar on the new ioctls, not an API version

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
