Return-Path: <SRS0=DRkM=JE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBB8C433ED
	for <iommu@archiver.kernel.org>; Wed,  7 Apr 2021 12:20:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 106F161245
	for <iommu@archiver.kernel.org>; Wed,  7 Apr 2021 12:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106F161245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C60984040E;
	Wed,  7 Apr 2021 12:20:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dhosdbh0ms3d; Wed,  7 Apr 2021 12:20:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8E23D405D0;
	Wed,  7 Apr 2021 12:20:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B705C000B;
	Wed,  7 Apr 2021 12:20:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 455DEC000A
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 12:20:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2717460A7B
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 12:20:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n3YHPbnVLBCS for <iommu@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 12:20:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9FA2C60A47
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 12:20:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9gdyAyx6nMWyhfcQBIPqEe8nEZDeuT9XnunJ1stals6PZ3N1Fk4lUa9cvXvsQ9apPan8p/nSGnWwJzh9M+Q1o+jGVNLdzp+nPnhFwJsJ1Cz+kAJTKdb9inPPEKdnivKqSM+2l4XxDoChHqYFrXWaCLWk68StHrWf+mgC72lL0uJ6v4PTHqBAaM2DOkAurRGvJPvgIjhyqZbrrOz8D84HcmFv4FLA/fO0sioDuPTsgBwOpwhso4HJtKogKowSi0Tp+7iM3RNvHaF5I40qyHFOxF+Mk/0KzAyMGTHK40fEkoowfUrS6igyqGKNmTYKtyRgVDhzY/dEVQyzAnEBL/f4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+EaUTINRKnm9T9DTyulX+UCeIXY3iZPhGqqGXHeVcQ=;
 b=npG+OcIAJz4iPBbHAlH8VGvXlGq0Rvgn/Y+r3eQ2yH0TWKXSGp+YfAYW69QrG+iDX0Jzy3MiuW7EH7x7JwoGjpjAqKQoidBXOySsvaLa/igWF0wsNpNp9mW5JFNxjTxtb3I4qCXhZwKdKcRaRj/Rys7mnDsYLjNp8VS2r+v5pSUSuxPi/tDlKekj1fcZU6iWCmzJouNq8DvAZr9cXV40u2zfCVhi/qhGXZgjS0OhdqUJIwrWZz3IpWIPzJvPrIB6fruY4oLzbN5M0CHnkQlwgNW370gTsFYXr+PvWTRs60ZNbYtJQQS5LKGWrUgxFMI6vqQbuW0IAdOT8mAR7GCOWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+EaUTINRKnm9T9DTyulX+UCeIXY3iZPhGqqGXHeVcQ=;
 b=MJyAg4fy00qxK3oKqZR3mJ3vyzAmC+0IqekYn2jZbwe8lrXTgEc6onXQ1nU8iO+HPsnI6wk92uKH5g2r/lkzE+ez1IamweaLgfo4J2MAnTgurejobZq6WX9Ufs9KNJAA94jdOrIjmDvQlZlldyrDWX8xkdRAOfdHEMo4EfS8J6OLLNg7gs50vO5PbSNIPdlNVe2ftm8r8CGD66SOaVn7uf+QimEUVHXYoQ25HROT1YW6Bc18Aj9CkFRe8knlOqkGLyGhaogyRFU6JrQakcm1bGhwaUdsUEif4faQLQWEp2kObRcKN3XGfk1aOzGbqev+auRKGe8fyCIXTpaHyGSDlw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Wed, 7 Apr
 2021 12:20:44 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 12:20:44 +0000
Date: Wed, 7 Apr 2021 09:20:42 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210407122042.GF7405@nvidia.com>
References: <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <MWHPR11MB1886CAD48AFC156BFC7C1D398C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210405234230.GF7405@nvidia.com>
 <MWHPR11MB1886CF7C11ECE0396A0215078C769@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210406123451.GN7405@nvidia.com>
 <MWHPR11MB1886CB8F558C6C17F921F77F8C759@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886CB8F558C6C17F921F77F8C759@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR17CA0008.namprd17.prod.outlook.com
 (2603:10b6:208:15e::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 MN2PR17CA0008.namprd17.prod.outlook.com (2603:10b6:208:15e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Wed, 7 Apr 2021 12:20:44 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lU7Ao-0020R1-UW; Wed, 07 Apr 2021 09:20:42 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3096b027-fc51-4b14-a134-08d8f9bf9109
X-MS-TrafficTypeDiagnostic: DM6PR12MB3212:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3212836BB16B7F9D08337634C2759@DM6PR12MB3212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VxxbNzUz5+TKlkGRlaMQSi64Aobzj8peAznLSYhOyKlnE/5vPFXc/+DeDcY5k83pksZI4mR5colylH0Zc/ShV6c4ajrn1rUhTZwIuFjs/yRUdQQstSyg3Pc9SwuRXGV39ofX7JrYoBkTSUekvVeY6geC9hb4OOq7eVWGsHJ03nnKZk1iGB+VkmwGJ9B9EzdsSyEze4aXDJPKajqCSov2lnSwXh2jaKNSbkQLRKgxbZimeXKtoH9GchWa45V039fOduTDgMKw/DY/8J94M336DsIQiAdjKWGVXVQlWO3UQVa+ye4u+jhHv2GVG+P69fo45jOGqc+HuGIDEjy0PxcFwbXCAmwq2kqJVRFjyG1WLyiWya1AAUw+b0kLJJFCLq+slTtqqTDl0Jb8QOvtJEXnIw9OQ5xUvBT4XK1GKj31TYkI8V8WxmiFaTvBzKAnsWGuPD4IPYItoHIBxhwXLqLxgLiAb2N3aM2LGFSfMcqfKFWOWT+7cWEQHyx/ftkhQm4ygAw2nHfoLTBhvKtDc33oS/4bAPLWMTCelKoCX+qVPg9n8DCkrMSO6mKaFZP7KVmP+q/HfJhZc4EhBi02YU4LSGCemXz5MndMx9pldoeqghtstEcR/xQYwAUFAiNZ7DK3x2HYOenj6fsoiLNz4rpSK8HDTgUJH7kfL6zwcNoE5qE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(36756003)(33656002)(478600001)(38100700001)(86362001)(83380400001)(66556008)(66476007)(66946007)(4326008)(54906003)(186003)(1076003)(26005)(9746002)(8676002)(316002)(2616005)(7416002)(8936002)(5660300002)(2906002)(9786002)(426003)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WXFGoxtWDOZXmzruktIsVIqFgzQK0Vr3WmXF/gna70plCylLrJU1ayybDdoP?=
 =?us-ascii?Q?X8xHyxU5zUDEwi3SDZa+GMQ+sbwK4rOVigrFmP4cO+XV6SFvAc3OYscYvKhS?=
 =?us-ascii?Q?VWd3+Y9ebfbUXRYhxW2YQT2P8+pvqGSb1ZaDdJWmA14xc8J8kmtO2Hw3eAwR?=
 =?us-ascii?Q?+IMYP+fkQ9UwsyvNJ7nbGFQ6spypHq5n34h6+IthfjAjsXyJEoXlBjsmbX/D?=
 =?us-ascii?Q?+R2cLXfWOEpDCThnFKQyKbv0nVf4lFpjV0Snt70mGwCkdR7pE04Ebu63ZmAm?=
 =?us-ascii?Q?FIkrB8WmSOuFVuXqyXGQFE+J9TqqWnNG17L9Umhf4qMPmqrfLG3uW9tOVqrI?=
 =?us-ascii?Q?YjpPNcMxBtitUVUx53nIciGKmT/FY7iCLR0zNdG7d8eh989QUrmuD0V+pM22?=
 =?us-ascii?Q?f+rjmJv0YAdKiDVugdaaQ749d1BIi6lqGZkfM4Ik7cXXC0w8FptYnzkmUS+p?=
 =?us-ascii?Q?l8hXpvnGfpFLl/n+qCl3C1ANV8+E4o9Hb05fS0czhbd5gO2bXM3YZGSxFhCo?=
 =?us-ascii?Q?1gAzn+tvzBZKhoIp+gvOu498y6dJ7DPt6FskjZLJzyKF7pB7d1zUAlTDtdnL?=
 =?us-ascii?Q?3TfSB61D0y9Z63hWL6YcmDjkd+oCACvXtP+Wh39TYbp6krP2E10i5QrM+AtK?=
 =?us-ascii?Q?/NbxApd7ebCA5nVN1tCgUq4alQzYYAE4m4BpeCBzemN19UAGVYHs+NV6dtZw?=
 =?us-ascii?Q?gISTKW+h17OnVjGfp5IqsRJK1OqkpdbPDLb4SYwsghopj5W60EWhVTZZ4HAt?=
 =?us-ascii?Q?0MvKtC9np/075U7xUfX9xsA1q+nvkXFJoTCljUIeUYuSHDik53jZTG/+czH/?=
 =?us-ascii?Q?bkMqVjUOkozl/T9+41uq8L7eQ/wB+UxRG4hT3h8Hq0U3NBocozM2GTVEYbT0?=
 =?us-ascii?Q?TfQ3oCP0CpVF4cizm293VraiNHF4p9MJnBm1P8MMgJehjwQmcmtVZwP0fzTN?=
 =?us-ascii?Q?UDkoQAcpvGz+QvyUw+MIrmg6IrIbrFMqM9ddj9QrHyAIurJV7gM0NsO16JCn?=
 =?us-ascii?Q?oWA8ANr0KHw4vnK8LB+r90jZIO1JOxZNVP6UKn0MIANxqFBda2RZ8hoMRTYb?=
 =?us-ascii?Q?7nGVWzEHzJHEquXVqoRp8hbgNXlk+Ptr/Gr/LyRorU1cGLB7a7N3will1vMM?=
 =?us-ascii?Q?ryncvenKrRM5fzJEMhNA6DHEEtFTohgN1FS92LcstyNbZwJ4v2lbmWz/3wWu?=
 =?us-ascii?Q?w9VRgAMMfbOwKKXE7JwVdXVvdtp1iHIcG0fXg1oeXTnR7LEe95keX7tAWc3t?=
 =?us-ascii?Q?7TjLKxnXBaZRowFYxgq8nQQhqqL+2/cekwEpmrXfuje7wR40STyPzyAGqcA/?=
 =?us-ascii?Q?FZefuctyvRU0CoJqLg1T00mP0nIhcvE8u0DKheUaIrCcGw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3096b027-fc51-4b14-a134-08d8f9bf9109
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 12:20:44.2331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFzY9piEZD8zuMcFJUjjFUNTYNqjw/oN0xjfU+WsLWnMZ285rkvRVqWAxynHdDMq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>, Li Zefan <lizefan@huawei.com>,
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

On Wed, Apr 07, 2021 at 02:08:33AM +0000, Tian, Kevin wrote:

> > Because if you don't then we enter insane world where a PASID is being
> > created under /dev/ioasid but its translation path flows through setup
> > done by VFIO and the whole user API becomes an incomprehensible mess.
> > 
> > How will you even associate the PASID with the other translation??
> 
> PASID is attached to a specific iommu domain (created by VFIO/VDPA), which
> has GPA->HPA mappings already configured. If we view that mapping as an
> attribute of the iommu domain, it's reasonable to have the userspace-bound
> pgtable through /dev/ioasid to nest on it.

A user controlled page table should absolutely not be an attribute of
a hidden kernel object, nor should two parts of the kernel silently
connect to each other via a hidden internal objects like this.

Security is important - the kind of connection must use some explicit
FD authorization to access shared objects, not be made implicit!

IMHO this direction is a dead end for this reason.

> > The entire translation path for any ioasid or PASID should be defined
> > only by /dev/ioasid. Everything else is a legacy API.
> > 
> > > If following your suggestion then VFIO must deny VFIO MAP operations
> > > on sva1 (assume userspace should not mix sva1 and sva2 in the same
> > > container and instead use /dev/ioasid to map for sva1)?
> > 
> > No, userspace creates an iosaid for the guest physical mapping and
> > passes this ioasid to VFIO PCI which will assign it as the first layer
> > mapping on the RID
> 
> Is it an dummy ioasid just for providing GPA mappings for nesting purpose
> of other IOASIDs? Then we waste one per VM?

Generic ioasid's are "free" they are just software constructs in the
kernel.

> > When PASIDs are allocated the uAPI will be told to logically nested
> > under the first ioasid. When VFIO authorizes a PASID for a RID it
> > checks that all the HW rules are being followed.
> 
> As I explained above, why cannot we just use iommu domain to connect 
> the dots? 

Security.

> Every passthrough framework needs to create an iommu domain
> first. and It needs to support both devices w/ PASID and devices w/o
> PASID.  For devices w/o PASID it needs to invent its own MAP
> interface anyway.  

No, it should consume a ioasid from /dev/ioasid, use a common ioasid
map interface and assign that ioasid to a RID.

Don't get so fixated on PASID as a special case

> Then why do we bother creating another MAP interface through
> /dev/ioasid which not only duplicates but also creating transition
> burden between two set of MAP interfaces when the guest turns on/off
> the pasid capability on the device?

Don't transition. Always use the new interface. qemu detects the
kernel supports /dev/ioasid and *all iommu page table configuration*
goes through there. VFIO and VDPA APIs become unused for iommu
configuration.

> 'universally' upon from which angle you look at this problem. From IOASID
> p.o.v possibly yes, but from device passthrough p.o.v. it's the opposite
> since the passthrough framework needs to handle devices w/o PASID anyway
> (or even for device w/ PASID it could send traffic w/o PASID) thus 'universally'
> makes more sense if the passthrough framework can use one interface of its
> own to manage GPA mappings for all consumers (apply to the case when a
> PASID is allowed/authorized).

You correctly named it /dev/ioasid, it is a generic way to allocate,
manage and assign IOMMU page tables, which when generalized, only some
of which may consume a limited PASID.

RID and RID,PASID are the same thing, just a small difference in how
they match TLPs.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
