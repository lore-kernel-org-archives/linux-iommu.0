Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F299EC47097
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 20:10:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E58961402
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 20:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E58961402
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5F3AB40234;
	Thu,  3 Jun 2021 20:10:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OkV5bBGe43tM; Thu,  3 Jun 2021 20:10:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1AC554010C;
	Thu,  3 Jun 2021 20:10:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8EC0C000D;
	Thu,  3 Jun 2021 20:10:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAD77C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 20:10:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D50F940609
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 20:10:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dWcZxHVEhrpk for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 20:10:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 545AE405FC
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 20:10:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0Ht2AkmLUg1eH0XmiIaB8d35CwLvMkh6ofJ4Q7xz9YqRUFqobk9p5VW2QpFofZ606tSqGwglCEqkTKXiINJoLcosCCdxFqAP9t4QC/PaQxenVlJrGoF0uVNzKMYkt0rr77o00eAUgc2Wgvd7SRt5fqYtWWe5eiz3QOxKpVePp1pCDmsKktSPl4nAN0/EGqJgqTWBzJNTVv3aM2MMpKq6yGv1ynJElDe//NuftYTOsp6XIWf/bpCjh8AqnNggbrb8IcXTY3UrqQG2FCoNH90AywAmIjoLw1TXkOsnE7yaUq8h0eVq9+Pkx21BdCv+Az6yeYM/LtHfUOC/eyf8BIXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLteV4s1ZZpIh4neiN5mqqa+7VvLbmDuzP04GGPk34c=;
 b=AXrIliiahH10XmvR6fkiP4EMW7+g39VUARV1sq78hlv7jyfCSUKHget6cbBLT+Nxr0cUPM9cWLymp1WKkbj3PF9AqfhltvptmXOiMLCGpA5brlKlxesg8JFMsyiip1DzVpVavhYgx2j5HoM27hK1KCwxWB1ZmoflSIMk4hJQNK6JqXoSoWngvq3+HbkueySgBIc3k2cw0Z1AwlDfhWcl94D1imTlw8A0/J1QV8Zbh3sPqzr3+ZntfIgsGaDOmvRCap4O8H1kGBMN+C9b1CmEUh9lhgHSKjU3uenqwkPeWb0cSrirX3bA4p8iMWmbSyBxScSSSZSiOpEj/YLdmZeiKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLteV4s1ZZpIh4neiN5mqqa+7VvLbmDuzP04GGPk34c=;
 b=oqvgJfB53kiyPggHgXyMg9jNolv8GZFbvSLs3VfO3PiqOdiLK87rLOQQ3EpcPupSXEf+43KIG9QQF97AnYr7yrfEUHOvDZocDDQphrtYc2lMjZKAL+ABQ5DkdcdAPq3Z5u3JErweTC+nmd4MTYMRePVMWVS9TF3XclmzxnQf7vLm7WnL17EddrAuAygImHGt4sxR1SnVA/QmbZ/sSjjhxZkhzRpk3av+B2BQyzEh+IoezgdMkS7Cj1Ly7lbWxlVEtWZizLdEQWeuF1BIUBLjgmLsoDFechKY9Ygdt1gqRJu84Kl7QMDZVUlwtl1OuoSLvAUCcgSfyh3RUclSQppRKA==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5096.namprd12.prod.outlook.com (2603:10b6:208:316::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Thu, 3 Jun
 2021 20:10:19 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.024; Thu, 3 Jun 2021
 20:10:19 +0000
Date: Thu, 3 Jun 2021 17:10:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210603201018.GF1002214@nvidia.com>
References: <20210602173510.GE1002214@nvidia.com>
 <20210602120111.5e5bcf93.alex.williamson@redhat.com>
 <20210602180925.GH1002214@nvidia.com>
 <20210602130053.615db578.alex.williamson@redhat.com>
 <20210602195404.GI1002214@nvidia.com>
 <20210602143734.72fb4fa4.alex.williamson@redhat.com>
 <20210602224536.GJ1002214@nvidia.com>
 <20210602205054.3505c9c3.alex.williamson@redhat.com>
 <20210603123401.GT1002214@nvidia.com>
 <20210603140146.5ce4f08a.alex.williamson@redhat.com>
Content-Disposition: inline
In-Reply-To: <20210603140146.5ce4f08a.alex.williamson@redhat.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR02CA0131.namprd02.prod.outlook.com
 (2603:10b6:208:35::36) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BL0PR02CA0131.namprd02.prod.outlook.com (2603:10b6:208:35::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 20:10:19 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lotfW-001NAT-Bn; Thu, 03 Jun 2021 17:10:18 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31778ca5-4c27-4006-cafb-08d926cb9c53
X-MS-TrafficTypeDiagnostic: BL1PR12MB5096:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5096CBDAF6FAC05FCE14B920C23C9@BL1PR12MB5096.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z8x8w/psuDNbvIiYXXRkdMvrPci++IPvyklzd9sgO/bv/7e9xeZeMRmfd4Kt+S6N+ILxB7xss/2CZx29ptgZ5aOlrjA8ndXoRrHpHdWDZwWQzAop/0GpMK5tLiDN2UoztPNR42r+kOSheolFU4UvOCneuGrYCEThKYyoqAQEyVzXyJP4ZS6S6rDsvMUpPJkGLeraw0hWi4G3+HKQmFx/9yzwsD+nno3VQP8xyjYDTKuMJEgzfQB8XmgTqwwkh1vKk+JQMMO3r2DYP/ODDOOhDfy9P7a0mrpt6eNwwS5EDwNaDaGih+VGoSCAjkFmmkMx83Yr5Hl2RnRyWqD9UBVj+cfOF6GxDD6z8O0Wnfya2a31X5sK6PBZOAsZnvPSDCfzVeQG7OMgmognl56aq2vkJNhzbhVZ2kXWMaYrj4oT1xaWDcdxO2LCKDLqLK7DaWHe7NX+bIlVi2elpLFRy+lXqoS/9MH6aKI0DBDPNjTXN1a3auSaFEZTNeTglsvWEu7P4E1VbXMx0gjC/Z9fi/NfrcBoUh97gmHQ0jMmkje6fbkFVA4xzlle4wP7UFFmO0kWkAMhQQDONHHdvznPqv12UEpUzJjsjTnpLUdyfuvhxDs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(426003)(8676002)(478600001)(186003)(1076003)(66556008)(26005)(5660300002)(8936002)(2616005)(2906002)(66476007)(6916009)(7416002)(36756003)(86362001)(66946007)(4326008)(9786002)(9746002)(38100700002)(316002)(33656002)(83380400001)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?rP65X3H3GnCSTqkJY8dQzyOWP/e/AjO0+O3WoF5PbuefpblKj6GLUk8Cj2DM?=
 =?us-ascii?Q?L7N1Ntd0HI7PceXFJzGjHSimAE/tEPIvXK2O/TftadfHfTKsDrHNkOvpLcyD?=
 =?us-ascii?Q?uTK+jEs0ODqL+jhFRKXVQp+ymHz8igd/Wp1JRxEPJ3iN/4Yxt7fjesk33uDz?=
 =?us-ascii?Q?6VyLUhmDN+odWXvQkRHYx8Q7Jx/OsDocMMgaSEHssviMtDvEai/yEIzpoOGb?=
 =?us-ascii?Q?tQ1fPL4pN8J6J4wWaaHd89Ik9npFoZ+LFhIADJMBCCqaT/NyLxVvNsiUTUKJ?=
 =?us-ascii?Q?t3BU2ikSQBk3hGVfH8urtAWjjrUAbWshE/jw3EO32l1gGFVJZQsbEmpAjv9D?=
 =?us-ascii?Q?TRTHWlIjww5G7J66Xx6cbQjYip7qkzrce6gOu+SztDzCyPigtRMPgMQEqx2j?=
 =?us-ascii?Q?KOWufZCaOF3ETu3n4cT/SARKvm56vipi58Rarpebk5ouk+zyPZXz3g3Uhf6y?=
 =?us-ascii?Q?pHzvNcl84v+JcxWtCcNAyguWsC0FexlpI9BrGeuH0RVODJSAjtvwSQx2QgEi?=
 =?us-ascii?Q?gi3e2Hrnx3EqMC0ffcUMcM8ql2T4v1z3csgqm5Awchwo/TTBPRcQg6eV4gZw?=
 =?us-ascii?Q?k0djkO4lq1ob2tMetyLSBxNIOgaFHOsyMLUzQz5czr7etCUPgwQ9PvhaW2kH?=
 =?us-ascii?Q?kTseZUGU1zzwTAOxj2Jw/rcQ0YWmcDDw2HVtMRhXZS+6pzUh5d827ELUtO/2?=
 =?us-ascii?Q?hpMyMfyj9m82jayP6wiL+R6pVZ4MDyLKJ4jTnQTSoyb4otNGJBkspj6ZYn7b?=
 =?us-ascii?Q?6g1DubR1XtW9OPILzqvx0l50+PvhySnoYeOb1G0STQSkdg07l6szbIChMB4U?=
 =?us-ascii?Q?y3RUrQUBhePHvYyvbciGP/PWWC83lZ5Y/k4UkS/weJDlIu9Lel/hXl7zun00?=
 =?us-ascii?Q?9iYgyhdMxdO6NDIzDHI6OD9Z6VMvvYM6gepIYhgcOQxiXHtYzromgVQ1E84y?=
 =?us-ascii?Q?z6Nw2SAZLrvF+PyV/xVw15iZZzhJFR//h3x5mzhY+OhER7wNp4bEf+zsBawg?=
 =?us-ascii?Q?fxakuH9kYR4Lq5/y8+2JJUP4vTfa8gb1TWr3GMoLhnf539DYz/a6TlzUmwU0?=
 =?us-ascii?Q?np8NkBUaLiCT4tyEsoqRf/PGsLrkV3aJ+CMbg2oaqkhMpXWJi4gBMNXNWVVg?=
 =?us-ascii?Q?sPjxowGMvU0NM9mji1E7QmNgRQqDSw35kxxRfuDwSkrVEqIlQxP9Bqg3ZzFk?=
 =?us-ascii?Q?z5L5lhESietKkLNw1Hgq8Tq7Gx7g3IpDszcvAPFiWrDYn7iBqjqO26CY9khw?=
 =?us-ascii?Q?pURKtwk8Z7nLzKFEDhTpGOtNsR7ijmI+4HXbSGrv+9xZKIxe5uWWR/z4iJxF?=
 =?us-ascii?Q?hNMkMDL908VLGxMKvQMUmb2V?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31778ca5-4c27-4006-cafb-08d926cb9c53
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 20:10:19.3794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8T5XfuaVbF1cHGDLIcPNn3LyRxSfKSBE6jX9Dl4UjGn/4Kkbi+XCad+Dtpvl8J9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5096
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
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

On Thu, Jun 03, 2021 at 02:01:46PM -0600, Alex Williamson wrote:

> > > > 1) Mixing IOMMU_CAP_CACHE_COHERENCY and !IOMMU_CAP_CACHE_COHERENCY
> > > >    domains.
> > > > 
> > > >    This doesn't actually matter. If you mix them together then kvm
> > > >    will turn on wbinvd anyhow, so we don't need to use the DMA_PTE_SNP
> > > >    anywhere in this VM.
> > > > 
> > > >    This if two IOMMU's are joined together into a single /dev/ioasid
> > > >    then we can just make them both pretend to be
> > > >    !IOMMU_CAP_CACHE_COHERENCY and both not set IOMMU_CACHE.  
> > > 
> > > Yes and no.  Yes, if any domain is !IOMMU_CAP_CACHE_COHERENCY then we
> > > need to emulate wbinvd, but no we'll use IOMMU_CACHE any time it's
> > > available based on the per domain support available.  That gives us the
> > > most consistent behavior, ie. we don't have VMs emulating wbinvd
> > > because they used to have a device attached where the domain required
> > > it and we can't atomically remap with new flags to perform the same as
> > > a VM that never had that device attached in the first place.  
> > 
> > I think we are saying the same thing..
> 
> Hrm?  I think I'm saying the opposite of your "both not set
> IOMMU_CACHE".  IOMMU_CACHE is the mapping flag that enables
> DMA_PTE_SNP.  Maybe you're using IOMMU_CACHE as the state reported to
> KVM?

I'm saying if we enable wbinvd in the guest then no IOASIDs used by
that guest need to set DMA_PTE_SNP. If we disable wbinvd in the guest
then all IOASIDs must enforce DMA_PTE_SNP (or we otherwise guarentee
no-snoop is not possible).

This is not what VFIO does today, but it is a reasonable choice.

Based on that observation we can say as soon as the user wants to use
an IOMMU that does not support DMA_PTE_SNP in the guest we can still
share the IO page table with IOMMUs that do support DMA_PTE_SNP.

> > It doesn't solve the problem to connect kvm to AP and kvmgt though
> 
> It does not, we'll probably need a vfio ioctl to gratuitously announce
> the KVM fd to each device.  I think some devices might currently fail
> their open callback if that linkage isn't already available though, so
> it's not clear when that should happen, ie. it can't currently be a
> VFIO_DEVICE ioctl as getting the device fd requires an open, but this
> proposal requires some availability of the vfio device fd without any
> setup, so presumably that won't yet call the driver open callback.
> Maybe that's part of the attach phase now... I'm not sure, it's not
> clear when the vfio device uAPI starts being available in the process
> of setting up the ioasid.  Thanks,

At a certain point we maybe just have to stick to backward compat, I
think. Though it is useful to think about green field alternates to
try to guide the backward compat design..

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
