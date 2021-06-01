Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7052C4708F
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 17:36:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81DB9613DB
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 17:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81DB9613DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5005740294;
	Tue,  1 Jun 2021 17:36:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NNwPbht9aAUv; Tue,  1 Jun 2021 17:36:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2FAB340270;
	Tue,  1 Jun 2021 17:36:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05579C000E;
	Tue,  1 Jun 2021 17:36:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF375C0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 17:36:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F938605DE
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 17:36:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PKi4qIB7Yl7I for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 17:36:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D50BA605C9
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 17:36:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iqjuax/6nTp2WJOPnCjYVlNI5VQVoe+r5l0LWifZPofL9EalWKixHbteWWD5KsMG0M7880bBprZGXtBr/hkMydaIUVV9OoDBs+kYw7qoPdXiXa5qsgnqm0vsHmwOeJ2ZWi0Uj6UJqXLJdOBsX6H2WTWyIASVRW/ssmuDrova7KGJ60e13UhREKHL1fbsalBaMupzo8dIHODPnjKL4VYz6gLvnoyS0JzTsyC2W+3Tx4j+EgU6f1AlRcGApSs5iqfNL0axTJz/ngiZdZEif26RSclBdXe+YLMK5OQ0zQyBr5/vlZVlItpuMYfQrc3Z7Wtjga08DjC6CsY9H7lgtMAEFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9M0VCahuU0rRd1OozjLd7E9Vr7n2r0+Rw+efD6JCW8c=;
 b=BY+VN0pJPIiFfCgnTop4y8FzPkAtQ7GmR6MJuIRrdlSW8KszSAjVSBJUOHmPXhWlNqOooFKNFMirxYmU2SLB/aa/VBkj0C937mvwJmMGo85vPWvyIM/TqXxY//8VREFrI6K78cNUIiDtLcUb2kUang56U1bCIoIaJ3soZGm7ztw/NicEd29pO1+m3XywUnyS5Cy6n8fJVLvvj0WmuWZET8Zap2Cq2o28TEXzijsPdcYRq2rP4n6sD6UwYbMMgUBvZAiroMxdKSqlVLJyQftIiOdb/f4ygA6obulBstCxbKFwHM34bnFVtOmYCmH3efWn8f1gpqujJCp0Mu55kx4EpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9M0VCahuU0rRd1OozjLd7E9Vr7n2r0+Rw+efD6JCW8c=;
 b=MRPGnx9S4pznn77X+65+ZtQhSjW3CvMr/r53UmZgrUQS12HGuG9Bp5wbIluwYWnrdL+gsN45rAKFtP1Arcgj2lcrGyCQk50UZ7MCiQXsOyvA+sRXIpuKaTo6roS5XEOeFUL6WoJMvY8MxzxVHTHI8t3rN/ewtGlgGU1lloHm/XYDGotiMGVj+T47CgFlq0SioXkT2OQ1L6MBTDVouYc3tC/SRp+VDaw4vMNbETRVnnp796C4zvICypRjRBOgW6v2sotAlCJpjLhQOevThz/5jyrBJuCxogsSnSgDqVOKSAG4hqM8gYwm5JbFDie+vTA/P4Q7Umgd6whNYMZhvucwQQ==
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5377.namprd12.prod.outlook.com (2603:10b6:208:31f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Tue, 1 Jun
 2021 17:36:35 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 17:36:34 +0000
Date: Tue, 1 Jun 2021 14:36:33 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210601173633.GO1002214@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <PH0PR12MB5481C1B2249615257A461EEDDC3F9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20210531181243.GY1002214@nvidia.com>
 <PH0PR12MB548177CF2193BF5AD12B493EDC3E9@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <PH0PR12MB548177CF2193BF5AD12B493EDC3E9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR16CA0007.namprd16.prod.outlook.com
 (2603:10b6:208:134::20) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 MN2PR16CA0007.namprd16.prod.outlook.com (2603:10b6:208:134::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 17:36:34 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lo8Jd-00HXib-QW; Tue, 01 Jun 2021 14:36:33 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46ba1881-6878-4eab-9a59-08d92523cd37
X-MS-TrafficTypeDiagnostic: BL1PR12MB5377:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB53772F1399C09B727ECEEC59C23E9@BL1PR12MB5377.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: emOwnqPppflLBfrZrdWnADOCDuYbrLKzm2Q11vBgd0K1rWNGsF+Yd8dV0VJ9rnBQ7hX0wLuCdI/vtVH7gJNmKr5lk92ot4/WE/CmYKJ2ZM3OwCLbTzpcwuuIdPC6gNigcmXPktk6c7sjcvlahtUd5AkfY+2YE4XEyiDfsGpaMKbobY9J6EZZmePw/H1oCIz2WB1+IbfmuAiEkmdqDL5xeA9u5wdjqzMWGXDzOvxvYb4q+qKtnwuR4mH5zvwJFAtU9cqlwMcLHvbzptNqo2lcK2bAYc8MmZBVbWhejwT91lobnbeC+ngJ9Sk+WytvaV6zggVVW/bQdgk5XEQVTC+TwLTrOEm2F/FErKerukuycCq4+gNOHu0dL/oN4ZyCjWS+p6RE9YfZlHHRbrLX2mUevRbIqer9eUtxY7NmSDo/GjdY2D19B5hk8B94JO4a8uf96V6j8ccSSqNb6wtQ4aVX013n74LlxENI1WTQgcM/34pz3657FHZf8+vNIWaVQJfA+I9056tXC9Hqaj0uHuCeE+lgEQafGdglJWuWQCuBLm5lbNnTmGuZhFLDsTPVhPSNd9SLQpvvNucyREPCYUFbrI5y+xFFmRgXhvNYuUSJNao=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(6636002)(9786002)(5660300002)(186003)(33656002)(9746002)(4326008)(316002)(54906003)(37006003)(26005)(6862004)(7416002)(86362001)(83380400001)(2616005)(1076003)(426003)(66476007)(66946007)(66556008)(478600001)(2906002)(36756003)(38100700002)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VumFSDISCm/yIvvKSvjRHM1pk85yDBemZTmH3tsfqbRj4M2P5LHJpOYl4u+N?=
 =?us-ascii?Q?B/pDFc24Iuo7VpRbEpOvg8Yahn+2OgNYO0exffWKZ6M1L5rmfo00T8ADJuQg?=
 =?us-ascii?Q?xytDaO5l6fADK1HNcP9X6Ju3717QfD2msLlUhyG+qDgEMEQeaYiNZP0oNn9v?=
 =?us-ascii?Q?9/RriwELQNVwzkSC5xfjgzw1nS+0IunKYi3/PDyLiPYe1PuljIm9AkfXUdkj?=
 =?us-ascii?Q?N2VBncfFTScFKLeuom0g7cBaHI5lzd+S72vLvXxLpprQRy7ZeqwsZ5+esbcj?=
 =?us-ascii?Q?vD0PQsx8LI6hxgT+NIDeDYahyKqaZdAuDT++4ZiJE4hSk9zJGoUH4GIertb6?=
 =?us-ascii?Q?YtaLHi9h6F3DvnYt7IuDlpPDdryvn9vKGGNbtBtQz1a8JaCn8gzySoW4ghad?=
 =?us-ascii?Q?zAABQoI1r8iKs6Yp8ZPysQtGsY2AahqzcnmhjdCvmxrzKO2u7yuyavqrMFFS?=
 =?us-ascii?Q?BFwSbSTXDiETSv9NZqXAcbrwiLnJZconX4JOUrTTIaCvsKQBbJO0ASUxdcSI?=
 =?us-ascii?Q?F6OIL7K8LWeZlLkQuSMkwGPA8C//H2wXYFtUoEf07T1Bcykg03abmYI4ysGA?=
 =?us-ascii?Q?fv1NMZzIEOnqCiRwZFkaV9dj5Bb5IvO28y/5mlH9EGaBL92u1Rh3h//UF0gn?=
 =?us-ascii?Q?fSJwbq6e1qNumLeB1XkbSV33r60ltOgL58kyj1ncWIN6hIs/+n3dFligve/n?=
 =?us-ascii?Q?J36SKoAGKw0xAMqFfl4LHeOrzVXnewlG0O2OxjFkd7cuD1ARPAMDBuBRg7Ui?=
 =?us-ascii?Q?2p7fqU5MkZObr/lyH7rW+mUSJdqWoSWxFHiSGlgvkqdy/yKVaEJ+TZ2antFF?=
 =?us-ascii?Q?IaMtYa2iMhGT7g27gSRdaMyHJNkDrGQ/wZA5O0IToXzRArr/sQlpWryETHEQ?=
 =?us-ascii?Q?6FUoR7yNMhqxEaIPxzL5oC/MPHkoMp8fNgJ3Av6isfPdzXnMuc9sY9uIbMZb?=
 =?us-ascii?Q?oTmLlLqYUX5RhInkM/qAJwcp9TPmAAB3p0HMO7+2XJH3xEwF4eNgG54KApps?=
 =?us-ascii?Q?y4u6IBNdHVjaPr0mvy2gkzCbRWHQSP2cA7S3gvx/H3trrhEkQSrRv4GAX2pD?=
 =?us-ascii?Q?WxmZ0pAaGMM3NsQquzdVLj3a1nDv9CTmxXFnJ41CRdj0IOegOEFUUdWmt2sP?=
 =?us-ascii?Q?xNx5W995cw7XzICxZ6RDfIpwW+EoMtYBX/vuYJu387umM4xghlb4AAuWXMGP?=
 =?us-ascii?Q?B2WH2meBvpGn5u4UqHKzfvsy0W7NHnAEHlzn4Eezjc/Qim9I3qL5Mm6lCsX3?=
 =?us-ascii?Q?dWB930tVE89FKC3JPMXFhEszZxn99kvpL4kAuESFbvscGvei54wS7GUKzn5A?=
 =?us-ascii?Q?Q/LqIZusUKc7omS1HmODi/UO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ba1881-6878-4eab-9a59-08d92523cd37
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 17:36:34.8753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: keFu5SD0W1ZvhBD4Xt1vgLJanO/dOySO/R7pUB8ePCW5Q8Yr5WCYYncJrMBgZvFg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5377
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Gibson <david@gibson.dropbear.id.au>, "Jiang,
 Dave" <dave.jiang@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>
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

On Tue, Jun 01, 2021 at 12:04:00PM +0000, Parav Pandit wrote:
> 
> 
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Monday, May 31, 2021 11:43 PM
> > 
> > On Mon, May 31, 2021 at 05:37:35PM +0000, Parav Pandit wrote:
> > 
> > > In that case, can it be a new system call? Why does it have to be under
> > /dev/ioasid?
> > > For example few years back such system call mpin() thought was proposed
> > in [1].
> > 
> > Reference counting of the overall pins are required
> > 
> > So when a pinned pages is incorporated into an IOASID page table in a later
> > IOCTL it means it cannot be unpinned while the IOASID page table is using it.
> Ok. but cant it use the same refcount of that mmu uses?

Manipulating that refcount is part of the overhead that is trying to
be avoided here, plus ensuring that the pinned pages accounting
doesn't get out of sync with the actual account of pinned pages!

> > Then the ioasid's interval tree would be mapped into a page table tree in HW
> > format.

> Does it mean in simple use case [1], second level page table copy is
> maintained in the IOMMU side via map interface?  I hope not. It
> should use the same as what mmu uses, right?

Not a full page by page copy, but some interval reference.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
