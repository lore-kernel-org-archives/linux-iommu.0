Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851B4C433EF
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 13:21:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2742F40AC3;
	Tue, 12 Apr 2022 13:21:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PimpPdA8-t3P; Tue, 12 Apr 2022 13:21:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0ACC640189;
	Tue, 12 Apr 2022 13:21:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC080C002F;
	Tue, 12 Apr 2022 13:21:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F119C002C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 13:21:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 56F4740469
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 13:21:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V4UhmezmfroW for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 13:21:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::628])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4A15140189
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 13:21:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhx/7PVpiJB1aaOmqoocahOA6J3M0Var/K+ILbJMMGCjrCSl0lRrn8mHNA+lUeml94a4YQxHZ9OIclqAI/rDCpDmJ+SI8nkoXhKwwUmcit/ckqZ4yyNqXJcx6ai5yophAKcU3vMsvxYWGXhQES/hQPUiTLBvBTAfKxtgnOGnf2IaFGPRwFaElHNjlb0x5QspMScyCublBUg3v/R71meZ6u5Icv6pEP7fg3maAoHVozXzaGIIKWU4Mbn+RBi0mozXx5Lw/MS/lRVePnk17hWMRpktQdnyNxc7QoOFDarZ0VKsLT/oKmNMDDVcbf+JoupNoO6vtIoT5YUwjNG1HNKWww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mopgk0dHDEdqpCXnTtW7b5s0qd6QZVGSxsk4JKSUV4A=;
 b=AZKlenbOyx1RsN5nSj7ff3KvaN8PfihsTjfEOhrP8hE0R2iMaNve5mcT1q7B/TsBt6iq6LkMaBsnPJKFSfIA9UkcFvfHrbzLTWOlFEUcdrE/ygVgoULnHdIGwU7UP0LsyrEiSS1cpEX1AqMuDG1jzDjjn8VlCZ02DRSt/McQe+o136PJhhwg8nwjb5pL7A5XbiL2STJVfULvzogLGujAtZxX/VnKPbiMr7dGQQvBhjt3Gmf0OHWKDWIYDYxJ7hv9k0QQ5I0tmO/rgpvgfM4Y48PA9KGT1IT68dmmLnOH8SCddE1CqjU2VBFWcKpXKN8TryAjnzGeaP7/KvAVyTkfig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mopgk0dHDEdqpCXnTtW7b5s0qd6QZVGSxsk4JKSUV4A=;
 b=mwmHXty0HiaVOBp468q79ySTMEhkU8H8+GojCZlntfMBl5q7mrPS3Mz05OOICNGRsG6oG+GRYjRJJJGITCaLWMXiapVUTeiWGvFCtCnEBndYlBFv4AYSW/3g/0EbbbyvVTxzVVV+evhMI2YNLAFLA9JgkrhmDBBcr71S/bltBEUyKakYOapJi4nQtl4MADjOzU9dYyRTpN203IFDt5xUzbgHS8LhtWriT//Q5d4HWVD28taS29FYmWs+8Vm3+ykL13S2b2sMHhPCMCBmIdh/gpeDYN0MoOHpmNc4sK5Z4GMZobJSvwqwGIiwtj44rGCYnLjScnkzIyNIYIxosi1p7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by MWHPR12MB1501.namprd12.prod.outlook.com (2603:10b6:301:f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 13:21:01 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c911:71b5:78e6:3a38]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c911:71b5:78e6:3a38%8]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 13:21:01 +0000
Date: Tue, 12 Apr 2022 10:20:59 -0300
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 2/4] vfio: Move the Intel no-snoop control off of
 IOMMU_CACHE
Message-ID: <20220412132059.GG2120790@nvidia.com>
References: <0-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
 <2-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
 <BN9PR11MB5276796235136C1E6C50A5AF8CE99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <8df77a0f-55ee-bbc3-8ada-ab109d9323eb@linux.intel.com>
 <BN9PR11MB5276FD53286C0181B4987C958CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <a3b9d7f0-b7b9-ffdf-90c3-b216e1e19b35@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <a3b9d7f0-b7b9-ffdf-90c3-b216e1e19b35@linux.intel.com>
X-ClientProxiedBy: MN2PR20CA0053.namprd20.prod.outlook.com
 (2603:10b6:208:235::22) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f15fa594-5bb9-4192-5654-08da1c8749d5
X-MS-TrafficTypeDiagnostic: MWHPR12MB1501:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1501C26BDC39D6D14489DFF2C2ED9@MWHPR12MB1501.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OULX4gVFV21AZ6SSQPU55eO4iESmqS0SI3c2Lgxtoz2ExAGJgoO6bPMx59aFWOUzNf/TrkhbImY/t5rkNScOtoDCzHDrTEAmNmJYwuEYwBw08YQkHwpBxoU7ael4VRvMxDS2ACTEb4MoypDc4pWUp6gSVb92/jJAqqvMJA/PweJ/82Z7CSDWU2xESeKS2F0El2IzxsBvLQVvzlJVhi2wwwh77RIqPgkGtt3ICrjtkfdzgqzXeSGgU1gxs9kU98g4ui5D+WUh+IlkbXjCHwYrEap+hMf53dioWkUxDrEnXz21GDAx5do0Q3KLjHsPwWHGkNyjuC0Lww4BUr6taj3XCHfDior/fN/mKIA8o5Kknd1cuXRKiyeMQ8VrqyPDozpcJW9+ZUahiFmzA+pnC0y80KIUEufYaizA0pqvxBYUi8XuzhujwxeR0N/Bi+iOrZpbJT/d0P1djWjjtolezt2jFl064vh1mB1ZUQtO8/Z9B4P6aNUJQAUyNWAxZNs9ixXgWhrWX0n8F/b8qYyPrb+LCmKvJFH6qwP067Jm5LhXa4J5Bk7bK75LCbEtLYTKqaFQQuLgntIN04kIWnvH1HpVB5Ue3bYVWVktCKaxLGUeh3ob8m4oeARW9YVdaNzprg2a/QEWm7KOVO2nMCrgm1YKLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(508600001)(6512007)(36756003)(6506007)(6486002)(5660300002)(86362001)(38100700002)(4326008)(8676002)(316002)(8936002)(2616005)(33656002)(7416002)(66946007)(66476007)(66556008)(6916009)(54906003)(186003)(26005)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R21RaOqYCxh6uJSoRzwM8ZkquJUrKbYJr0CRoCl71iuniuiRKSsDjiMZu7R1?=
 =?us-ascii?Q?WwNHJI/bMGWWfs/r/cPaqz6sjWFrwx01Fm/KGUkxXNiwxZ5bj9+cqBhMSRYI?=
 =?us-ascii?Q?Te5SsHEqsLP0YrtQPaegIcD2YuGdYqIyghJG1SRH14UzieIBr875nUatGAvr?=
 =?us-ascii?Q?YlHkGXJMrT3rj/S+O4Hu6PYIpZzddyTu3lPi6sqhWEej9Bos5oVthV5fZfo2?=
 =?us-ascii?Q?htcuHVUkbAhStMrgruhojrCDP33Yq1qmBAJbI1bin3i/148YL5DFOKF6u6DT?=
 =?us-ascii?Q?p79lByrD7nK5zCBe7bf0DRtX8nDuNIeXt06kwA+kboS7SzR5IoBoR86s7JJF?=
 =?us-ascii?Q?nRTqWxHDSwdSkhUSXkci1THhniioeml/OjZyoRa7nl31a44ANTHqNQGNGq3y?=
 =?us-ascii?Q?8aBZpAwbd0zC788+cIieIL8anAa8/e4aqZnMvXkdEG6duAKgnGe1p+ej13dx?=
 =?us-ascii?Q?AuaquA4VV/+MnSdXqwHKXK2p8Ug/Tr53N/qxLiYAiPvf71a25kecmIX+eFkl?=
 =?us-ascii?Q?R9y016X0AiCqoo5YePK///2HDPm0LrC+/pqENTRh7RQjsUwnfKpmBrkQPpFq?=
 =?us-ascii?Q?3CAYWRiOfMClLlyOVbL7zuYP0xikuw2ooqY3PcGJZVEdTlfeePX65ditVBlI?=
 =?us-ascii?Q?nuF0ARmgl7dQwyXBm8FU7MrzSfgu4+0BdliO4OytzGNGwMLEGML6Nd0p+GaJ?=
 =?us-ascii?Q?RDt7IRDvQeRfIqCQIsivqopPq2LLI5z4yysV3DZkx+r1e4SrZp+Qr6/GmIS3?=
 =?us-ascii?Q?eHGKTZweKg2GuJ4qakxu5iLtWepVs2BGdlsJ63DVHVIOUiYXzZWhPvI2dTRn?=
 =?us-ascii?Q?TjRT5LCjEET+7mggqoPQhrdAYUcxsNqOaxU078vr/IUnqihGZeMxle2l8yce?=
 =?us-ascii?Q?rah99tyBdX6bkQaoe862hBgWppo95OLdn/gAjFL1naEBWom1YscgIbZ91vXt?=
 =?us-ascii?Q?Amf540E0FCwVurom3+2hyS4vMLyZ3ZJuw4t3TzWX5ydVzeuAPQGAxrFbRFzl?=
 =?us-ascii?Q?Qpek+lVzHYB7Q0iel3PtNkbQ/OOa/LYmdWmHhDc56PoT2vE2uldKD55hD/pJ?=
 =?us-ascii?Q?lo7BiTmGaIlfJ6WG9UWjRuG6nmPqIYuIVpcA1SZuExzFArUhWrHkNHH+gXKp?=
 =?us-ascii?Q?DJZwnNvMGpyg5aCdlUuo77rh59xH1e2+0WMNjS5OwKuIZjU4D9yQbOndNAsw?=
 =?us-ascii?Q?sCIRJVbWj/9fob2UKpEUa56KVt3Tfbp54KPUyt4k/7x2Y0ekrVW0cgDbOpYh?=
 =?us-ascii?Q?Be2g1sjx1duNkYC2SoMN1baigr5s/a4IK/aMgQjkI8crFLfxR5f4ryROAwBN?=
 =?us-ascii?Q?axAUmyT+h2CNlFJOiBTwsIxf14VhRiVL6oyvnNaxJSyhjTWFH1i5w/wHV9VA?=
 =?us-ascii?Q?SLZwZFVkiQ+V94geVKFXjROcX9NpHIT+RkKiFuP6KZm2CtIZjUwYMfRpsdlC?=
 =?us-ascii?Q?xQF/zl3illSU/WWu5scD59GnDJzGqcBMRSChOjTfCGQTkB9DYiBCJbIe3kAl?=
 =?us-ascii?Q?3SMQDJtKApppNBRqDwLv+Yirbvz/6uPjA+xLb0zzVImuSGK61tWzZV86mpFZ?=
 =?us-ascii?Q?lE0ok2mtug4BrSLNd9mJbP/+nl8iGom1Jj75hASzXBhqowFkSOZFqJN9Iq/j?=
 =?us-ascii?Q?99z8fT8R0BA71/RNJ0/JuJcqzVW02MZffM8ORGFLQHCgppcywGBi6CP1nsyL?=
 =?us-ascii?Q?N+3LBU3xoePxNhCLonVf9QCOi17DANR9XZpg2uSBk7nDQyDNLFxd7jrgXPgB?=
 =?us-ascii?Q?LQ/G5G6F2g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f15fa594-5bb9-4192-5654-08da1c8749d5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 13:21:01.2633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmwnMIZ8C7YZpadp6CWOJnSZcqB02Ttu9iOZlZwtvEZd5pnawnK3hasJCqDuawjw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1501
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>,
 Robin Murphy <robin.murphy@arm.com>
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

On Tue, Apr 12, 2022 at 09:13:27PM +0800, Lu Baolu wrote:

> > > > btw as discussed in last version it is not necessarily to recalculate
> > > > snoop control globally with this new approach. Will follow up to
> > > > clean it up after this series is merged.
> > > Agreed. But it also requires the enforce_cache_coherency() to be called
> > > only after domain being attached to a device just as VFIO is doing.
> > that actually makes sense, right? w/o device attached it's pointless to
> > call that interface on a domain...
> 
> Agreed. Return -EOPNOTSUPP or -EINVAL to tell the caller that this
> operation is invalid before any device attachment.

That is backwards. enforce_cache_coherency() succeeds on an empty
domain and attach of an incompatible device must fail.

Meaning you check the force_snoop flag in the domain when attaching
and refuse to attach the device if it cannot support it. This will
trigger vfio to create a new iommu_domain for that device and then
enforce_cache_coherency() will fail on that domain due to the
incompatible attached device.

Same scenario if it is the Nth device to be attached to a domain.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
