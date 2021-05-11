Return-Path: <SRS0=AxcK=KG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B868C433B4
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 23:40:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE4EE617C9
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 23:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE4EE617C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E2F340354;
	Tue, 11 May 2021 23:39:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wyKbjAwJ6ZnZ; Tue, 11 May 2021 23:39:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0657140349;
	Tue, 11 May 2021 23:39:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB471C000D;
	Tue, 11 May 2021 23:39:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1DDAC0001
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 23:39:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D0D178455C
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 23:39:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f3qKBrNy1J1H for <iommu@lists.linux-foundation.org>;
 Tue, 11 May 2021 23:39:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AF66F84556
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 23:39:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuT7G+DLt/pkGOuNcceTGDQzkn1xqZ6WJOpSDhh3fWE/M4Cej50lTz966/xM6joyHSzJVA+ptDJKOmuionp6Afc/8cgT/7e44HtQC2Dm1WJO8DrS+3nFc5agt4V4c5McVT9E6PfGS8GKKFD7Fo2LskKWiUe2tT9ZHP1aZUaQa9dbOke2T83D+VrcTywBjPZXjE4w4nT/K4B+qvUBM7g/vOnp93Cg3aqIB5T8xQVahZ/ZMYUNoljDYiyMezEE/Vu/whtz2I6J4zRQpAZr8WO5mk7BQg+lPZ+5Qmeff821PsX+HHkamJAtvtVLVknyqyQ0J1djqdQr11fXF5+4QZaoAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yFf9oBiF+IfeQtTwhzHIGoSytVOO+uNqoNQSTPubAo=;
 b=PY9PkQlJC5j7O3VPoajqqLlUcWtvbtWEV4bRoK3VKiPQArfGumlaQPiSBxCpWrmzsnpJv8MQHmcpv48+S5EOolZa0QDrNh3WPvT4Ce610H6vDM89knP+DoQq+YtScxJmm91T6/cfaBTKIwKkxlAL4VLuoMxJ5FY0BwDOLxuXbH1XKJaKi/2uVWGq43UA23ZIB78Xj5aBWVZMDWqcnJh6K5WKLep5w+NkOeEul0elA5mgUdvhfmV8y43ZYGjg+OfHQMgY8uRe2F0NROAYOAfcI85PzKUbUxjoElWv29/mtDU/iVhVACwT/H7eT6HcU/PUm8pFzOw3ADSt+94HRaw7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yFf9oBiF+IfeQtTwhzHIGoSytVOO+uNqoNQSTPubAo=;
 b=ZXKiuUMn9Afmbx0SEf4DdoBUcgj6Uh+kqktECMqUFL8nDOYHAzXTdBlSsj4FSXztevfyA9lsw1qfkm5MUrld7mq1zdVzjo5gQoMijiBdgybCF1r2ynBID/wTRwrqqPk6GH6KJaxxZeN+EncreNh1xLdwyxXOERc2mmEHCpiPJdVCSNkIZKwv1ugTxCs3DHqG+dAf84b8JsbBhCkyHZck/rQb0YjOPCCGr9fpf/2Vvxe2uBQkVzrD6D/cp+h2s/J9XHuAhjRDisYkn4sKE5ztsgqX+FVx4WNt7rxz3dPU8Y8mMM8lHO/dStquRdZULbT/wk6PxTJiz5JEqSctLYvvCQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1660.namprd12.prod.outlook.com (2603:10b6:4:9::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Tue, 11 May 2021 23:39:52 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 23:39:52 +0000
Date: Tue, 11 May 2021 20:39:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210511233950.GQ1002214@nvidia.com>
References: <20210505180023.GJ1370958@nvidia.com>
 <20210505130446.3ee2fccd@jacob-builder> <YJOZhPGheTSlHtQc@myrica>
 <20210506122730.GQ1370958@nvidia.com>
 <20210506163240.GA9058@otc-nc-03>
 <MWHPR11MB188698FBEE62AF1313E0F7AC8C569@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210510123729.GA1002214@nvidia.com>
 <MWHPR11MB1886E22D03B14EE0D5725CE08C539@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210511143840.GL1002214@nvidia.com>
 <MWHPR11MB188601321993CA43E3058C4D8C539@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB188601321993CA43E3058C4D8C539@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:208:256::13) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BL1PR13CA0008.namprd13.prod.outlook.com (2603:10b6:208:256::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.11 via Frontend
 Transport; Tue, 11 May 2021 23:39:51 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lgbyg-005cBd-Ao; Tue, 11 May 2021 20:39:50 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3413b0e7-24d0-4b04-a6f8-08d914d6129b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1660:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1660768DFFE5D24C9D1D1EE6C2539@DM5PR12MB1660.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NPogXDylVhdhuUY03M6jtizBgiC653NM04fCNW1F6UB5YNiMDOj2b7ZIou3nZmk/oofBTbFoTgzEYMqRNxl6UA8mfj+Ezs1pMyyitkS4YsyrgNApHtytgfyZ3/nCkH6+SJYV4TmMH+y0aKSfU55Gx4iyI4QMQ0uSIG/mAybwJJvcKynejEjCJWf4LdCOeH42fv04TNMoy11Gm1GqPopM1mEAPte1lSOsKGdgeZQpSvW2Emy41wlaO7auihYDNx6k9dF8EJJbCWVVokLxailOri3GbC3R43LIjEnQGKpsVXuFpdM3MW0wOh5B90rJ4t3i8UEWflm7Lh93PD6iaB2McXq3V6Dnmpj2Zt0IGQDkX8NZ/dudkL2o/gBHLiEW+OIqOFsrEvmq4vW0Szw1wFLbLwQ0Cednc6QAMDceDgUpaC6NeDd/acCRHb5tq2JOyO3wU58ySPopLMb+JJFz/jBkl9LvnBVTZsE3KTjwKKNg69p1EqzPUL+jT7CWqdXjQsu7xzE6d9HTLL978KFTmlB7+Qr2roCkeFqYtjT0R7Pf8syNM76zAVz1iaR+y998KTR+kCmkaEopqGSCR1qHbajrpO85MKfHYgLMVdoKIEwYE1g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(186003)(54906003)(9786002)(36756003)(5660300002)(86362001)(316002)(478600001)(7416002)(9746002)(33656002)(66556008)(2906002)(8936002)(6916009)(8676002)(38100700002)(426003)(26005)(66946007)(2616005)(4326008)(1076003)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?41O70AiSH3N84LgbHBxhwz0h20c8C8bhZjTyNPEmvBDaqEo6SlKj/v6pz9JM?=
 =?us-ascii?Q?zvxpAsJtPojmdtT4jD2ohNXeAQnmF7EmXH7WQGvAp03hS624KPnjpxq5kGXy?=
 =?us-ascii?Q?1awyaHXXzhMlte0BwP3M/WbMPhYy/gjycaWpqDdxTKHXlPuhKLbdhexWIyIW?=
 =?us-ascii?Q?PixRonaUfWbUDfpmelJDCdhXu6fKZgcwwMlL2vdMe9anBhfN7jLIpktKAYWM?=
 =?us-ascii?Q?Mdw1kBTsOgPB8/CP+0Hb5n1H7FZBukkE/FTF/urneCpvOr+3akgv1yH2P6iX?=
 =?us-ascii?Q?8TFey3+35wWLUMc/VC7fPc5O+dlsJRG4OmumR9+UrGlQuzv40QVdWiuszJg4?=
 =?us-ascii?Q?jt+ha7v8xI7IPO+7V9ZHXSKdCZ2ppnBKbuRdAIJdoYTd2Lko+8G79Vi1c2ML?=
 =?us-ascii?Q?SaaJqVTB0D7thQ48S2vK8LaurVQQHQlxaM1rluprX7FEo8Ypamrdc6L7oguv?=
 =?us-ascii?Q?qs/mNGjk6ra4itdZYZsC4vfhdJktXu/I0olJki10nCLxUw3hHN2V63Prne2V?=
 =?us-ascii?Q?ofSqvrKd2mjrf5FcLZVbsARAUkYsKmVJYjPPuhjCSBIQsFxNWX8a/h+iczMY?=
 =?us-ascii?Q?X/ejPjO+PJIRvxLS7UwlsIkk6499696ImStBcqwT211gRfSrjww4KK1mv9CS?=
 =?us-ascii?Q?ckq2EFGUdXv08r1jL3t4fBbI+BkMKOkx0UP5WKzzMgCbEmt3vGKRbj2zhc7c?=
 =?us-ascii?Q?J8kdUBeWl8i0q2qa4bB54nu34gl6sODGs2JZqDe1yhOQTF8dsh+1pdJK8C14?=
 =?us-ascii?Q?5HfB2SnKwcPDnjoL0jZDevw8/h2DNaQ0WoywG5r8C3WBRNXGn4yUTi6WQtyv?=
 =?us-ascii?Q?QvQcFiPDkEKdnpM89qDuxF5hPdeRM+OIth1T0GuWze7rGYVREDl4xETcZV04?=
 =?us-ascii?Q?X0aEtmGaO/9ThM6AyrpLCSKGaIUFhxeBunCahn64aWQ4JoSWHMxEDkNy3dNf?=
 =?us-ascii?Q?Q0VPz4rBMW9FZJsq+ALuiai5QPvlj5BsGIfVpUWt2pmtbXfQjkT6s2iHVSuc?=
 =?us-ascii?Q?ShvhpwWuLYYAa496cY7+dX7xzQwyZ95w7mhIi17RNxKC6T7EPwhR6CZcSFR+?=
 =?us-ascii?Q?Fy+fUZMd8fWgCZZXppYKugq/EDWefM5u6dYehThaIE9u6gqTL7a3w4D78v3h?=
 =?us-ascii?Q?TGRTXS3hHrUNKwZmsyVyvzqbdsQOKzMIns8nVOzI2K4o9z7Fa+uY/y3pCkxS?=
 =?us-ascii?Q?/K3r49pfIwTYUPHWL21Gq0nhZsWTtjAnUOdO3o9Xu92ibgEOyjCuPatjDOrW?=
 =?us-ascii?Q?UG+DBM8mFJl51ey5jQWhGMnCvmiQjQpXMfsKPGmPyCk+lfejzDhCsvYUcNr/?=
 =?us-ascii?Q?DGi/Duz3fb+QGlaYGjqHHNnb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3413b0e7-24d0-4b04-a6f8-08d914d6129b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 23:39:52.1151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ox0kEkNqVpj0+ATBmFwIltQlV3NSOVkHpjA7OMt5jGJpi+ellz6iN6iP/cj4wbg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1660
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Li Zefan <lizefan@huawei.com>, Alex Williamson <alex.williamson@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, "Wu, Hao" <hao.wu@intel.com>
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

On Tue, May 11, 2021 at 10:51:40PM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, May 11, 2021 10:39 PM
> > 
> > On Tue, May 11, 2021 at 09:10:03AM +0000, Tian, Kevin wrote:
> > 
> > > 3) SRIOV, ENQCMD (Intel):
> > > 	- "PASID global" with host-allocated PASIDs;
> > > 	- PASID table managed by host (in HPA space);
> > > 	- all RIDs bound to this ioasid_fd use the global pool;
> > > 	- however, exposing global PASID into guest breaks migration;
> > > 	- hybrid scheme: split local PASID range and global PASID range;
> > > 	- force guest to use only local PASID range (through vIOMMU);
> > > 	- for ENQCMD, configure CPU to translate local->global;
> > > 	- for non-ENQCMD, setup both local/global pasid entries;
> > > 	- uAPI for range split and CPU pasid mapping:
> > >
> > >     // set to "PASID global"
> > >     ioctl(ioasid_fd, IOASID_SET_HWID_MODE, IOASID_HWID_GLOBAL);
> > >
> > >     // split local/global range, applying to all RIDs in this fd
> > >     // Example: local [0, 1024), global [1024, max)
> > >     // local PASID range is managed by guest and migrated as VM state
> > >     // global PASIDs are re-allocated and mapped to local PASIDs post
> > migration
> > >     ioctl(ioasid_fd, IOASID_HWID_SET_GLOBAL_MIN, 1024);
> > 
> > I'm still not sold that ranges are the best idea here, it just adds
> > more state that has to match during migration. Keeping the
> > global/local split per RID seems much cleaner to me
> 
> With ENQCMD the PASID is kept in CPU MSR, making it a process
> context within the guest. When a guest process is bound to two
> devices, the same local PASID must be usable on both devices.
> Having per RID split cannot guarantee it.

That is only for ENQCMD. All drivers know if they are ENQCMD
compatible drivers and can ensure they use the global allocator
consistently for their RIDs.

Basically each RID knows based on its kernel drivers if it is a local
or global RID and the ioasid knob can further fine tune this for any
other specialty cases.

> > It does need some user visible difference because SIOV/mdev is not
> > migratable. Only the kernel can select a PASID, userspace (and hence
> > the guest) shouldn't have the option to force a specific PASID as the
> > PASID space is shared across the entire RID to all VMs using the mdev.
> 
> not migratable only when you choose exposing host-allocated PASID
> into guest. However in the entire this proposal we actually virtualize
> PASIDs, letting the guest manage its own PASID space in all
> scenarios

PASID cannot be virtualized without also using ENQCMD.

A mdev that is using PASID without ENQCMD is non-migratable and this
needs to be make visiable in the uAPI.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
