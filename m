Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76716C433FE
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 17:18:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2176F60FAB;
	Tue, 15 Mar 2022 17:18:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M9OZE7dXLppJ; Tue, 15 Mar 2022 17:18:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E5A3260D4B;
	Tue, 15 Mar 2022 17:18:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF2E4C0012;
	Tue, 15 Mar 2022 17:18:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 613CCC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 17:18:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4AF6C4034F
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 17:18:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aRJ1LqYJpvTQ for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 17:18:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::60d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 787FD40273
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 17:18:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCqsVcI02p7qJ+6q6w6KPv3XfVcrsBFmMD333YDe/F6hjMQ1foZ0+eCnY8GYodm129ZntC1f2UIL/a5c/flocLG4uOOr2vkQB+avFVRPa9jHSGMdfMP/NVjpYR8AcsI80Yyl3LapZfPRNsJWe2RWo43/Fxrc2lOz6gF2H8QdrcnWdelgdTDdxD4X1yb7zT0eY49aUvhGHK2Ksw4/6KO+6yXbpR4IxjuQUUJYqewG9atphiPqhJ+SHIHI0wqijuAShHeCyqfyahKZubKu3DuOudcgvqMAh3dlufRmgG6otVQpEV1JHK4o1U+/kC7To6tt2/kLwpHMvXaev8zkGcVAlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pq5nJdt4gz96ip1zgPsWwzOzM7+/w1K8LCUv8bpVp4=;
 b=hLL+trxn5MpvdefL5Er644idf4aoqCTHkteFX1R+1bGTlmYLolu6+35YqctqiOA3alkYbcz6w3PzCv3EPaGKmNjdai/pI4BCLI9T/I0V/h8h6/iBDRkLaWKPQRfKEbf9Cfm7ToeOIEP/sRyOcFVwRFhr/NgE5JOnWZWQd4sPRW97n13lJFaE6P1UVQWZjgOHumgAdENdeXqA/dncaogNFmMKuQSRXhLE7umjv789sbKkNZ33/pANGPSaGrAaPx7AycjASVXDmaB1DwxsD2lFsiwbo7kljUOdbPajNIBvECcJHIekRDIvBM1e7SYLHQ15pjgHf0t0/WrMFaGSaKFvdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pq5nJdt4gz96ip1zgPsWwzOzM7+/w1K8LCUv8bpVp4=;
 b=NGr4+quGQOmvT+u3ENDlNGL5UKfhBeUvYxKowREI3R6PcrIDYItzruYNLsUBtXxy3dzPVXOql67u/Hc5kQFH9g7BPkz7RhDt9kUsm+pd5oAVapnFQo1kZa/ySPjUd5MJlkvqqKcePsq7B3+XBBU86iY+PQHgoRS6obhBmCSEcRFkOB76yhI4Drhd7UR5y/7YOza0uMnVyZUMU2xzoK6T3zhPB4TqkRFq3VcI/cFkmDkQhghemcHjSKFdPt4ymC08HaKHbap/rLGeayv3Oy1NvVgKBXJv1cPTvzInm4aFVOw6iNX5nsu+DqUIxbhkrzIhqIJFXDhaKWINO/6HtI7waA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN8PR12MB4594.namprd12.prod.outlook.com (2603:10b6:408:a2::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Tue, 15 Mar
 2022 17:18:23 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28%4]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 17:18:23 +0000
Date: Tue, 15 Mar 2022 14:18:22 -0300
To: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v4 15/32] vfio: introduce KVM-owned IOMMU type
Message-ID: <20220315171822.GI11336@nvidia.com>
References: <20220314194451.58266-1-mjrosato@linux.ibm.com>
 <20220314194451.58266-16-mjrosato@linux.ibm.com>
 <20220314165033.6d2291a5.alex.williamson@redhat.com>
 <20220314231801.GN11336@nvidia.com>
 <9618afae-2a91-6e4e-e8c3-cb83e2f5c3d9@linux.ibm.com>
 <20220315145520.GZ11336@nvidia.com>
 <dbe8488f-2539-f81a-b730-26e58b78856a@linux.ibm.com>
Content-Disposition: inline
In-Reply-To: <dbe8488f-2539-f81a-b730-26e58b78856a@linux.ibm.com>
X-ClientProxiedBy: MN2PR01CA0053.prod.exchangelabs.com (2603:10b6:208:23f::22)
 To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90d913ff-eb78-48a1-ccff-08da06a7cf44
X-MS-TrafficTypeDiagnostic: BN8PR12MB4594:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB4594438186EAB4041359A3E0C2109@BN8PR12MB4594.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wL4tQYnk7OE7jg7vHGFSZF+kDV3goB5Ft2QbIo9UANpoPfks3L6vQwdyoWPoGf589E896qmvz/Z3k3JrsuMR9V3d0S9vw7D1t+s4ifHwyojlIQ+MguMq1eSgvLAhUHLMEbnQuwUR7qg0s6faEiqlmhwcYVYddrbdlIw+x+8KcAZ9nGM0ORci7zDi6pibzZsCud8/If71QPwtXbvIOHDEk2zSXhHbaPPMcWTDJDkKf7lnuFJqB5wNRatWB6LZ0bs3FkADsGvpHiyeTqYlZVSPxmGIXJIK/JnnWKrCjRD0aTlApnk8sIcNgXsesGKxvcvxXKTwG+C3Qkg3pOmFIoT3f6IVSIwcg6uPRDxW/INRk3WoABoQKtrrHB0TFssatU0s0318fO+tXgFbpaK3L+iBqfO+w2q1/2bOlV+8crVEMVlruZ6R2gPf0BzLdSoGyPX1qugCLnimB7Iq55ANeCGDp9CdFmxkSYKY61Ndtrf0YitoROSEPrlUZHUocBcFwJDcc9j7xOWOGM5OwfBn0nrbJ7chIY6hIe21Qceb0n8opUANdqshLFDof1c4MBrWhW645zJW/cvcvcTzj3ew3hu3nXKcgdxR4f1jKicaRWOjfLAdLCgywy339nRxe3rewm8gTyqrE0x32zePVqWtC8+C4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(26005)(83380400001)(1076003)(8676002)(36756003)(508600001)(4326008)(66946007)(66476007)(6916009)(316002)(66556008)(6486002)(38100700002)(7416002)(5660300002)(8936002)(33656002)(2906002)(2616005)(6506007)(86362001)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zQ/9OOKFbh6Wuu6cYj1YJRjaMZmacasLdTK0Dg9+cFiXTR96QtTwH6yhdUGG?=
 =?us-ascii?Q?AeIzQBmjujTFC//iQ1JyXhRlEegAayLX5LPR9fKhnZXaimZAXDcGT0fBlN8b?=
 =?us-ascii?Q?Fdvl4pwFjvaqF8BGhDmdiCMkl+kiPv7CM2R1MEmD346wuW+RzdA3QLauk8zO?=
 =?us-ascii?Q?xPO2Ky1eQqRv2MYB+tt9Sd3TAxX5WCGGgGf8mj7+0TGReqD2gkKOZajIKjE0?=
 =?us-ascii?Q?K6FNKozoafMAlR31RlEBfnAGY4zVvIb5vt4s+mpBR/3+Ghrs77VnjS4Rz0Gz?=
 =?us-ascii?Q?++EjQvqbeyv5yrDDQzWORztkEacVMgn2QGRA6GUaX1+Fj7MZyPpMvaXDFlcS?=
 =?us-ascii?Q?wgSG2eKbMR+zSEn4+bzKmveiejnAUiFbocjBhCe4t9CJNdZNfdc1XbWer0wG?=
 =?us-ascii?Q?QoslGy2P49cuY/PWnQE/4Sx42qd1u2ieF5vmDkS53ejt+U7/nwE9naOaU9Dn?=
 =?us-ascii?Q?+ffkH7uPFKfvduzCcjAadfL+INh8OsplYcosWd5VqFV5KCyQta0FW2mxYMMC?=
 =?us-ascii?Q?R3IQjUbJ9Hbo6SAwGOQjMI6y/bk3txVd2rubI/hGJlUF110MxBpFngp2IPwH?=
 =?us-ascii?Q?Cs1rfdXp3/+Hsf+dcvFfybrDZdVPf18WrEHQqq2u0mMWa2qMNUqon/YrG1bk?=
 =?us-ascii?Q?LWZ7MBe2NsIEz9nfT7UwJfODjzxxamfhm1TU1L9ci5pGFPXOu/mmIjWmRdr3?=
 =?us-ascii?Q?mQ5GS/vcCvOSFIaiG80q5EDgyWh6B5xjt5bM0nszg3xC7ZdXE9bg9LHjC5Sq?=
 =?us-ascii?Q?hIrSGgf6181xTWMzUgxXAacXfNFfixsjzsC4ZhPo9AaPIiL3sRD1s7uwE8wv?=
 =?us-ascii?Q?/s54WRC8VI20fgtb4MzVwfSTzRXwMKMIcxp9QYnst3UwUyYobvIoDbPYwTQW?=
 =?us-ascii?Q?jRQ6xMchjox+nuGm38sZoYsca2jPY0daOFWwM4izsOTQVvO3POJzU4Mu40rv?=
 =?us-ascii?Q?ZGHOtlht6LR+sMy20zgWOPbA08Q3TGckOotQ2SfhLm8pJnWwEO8xrao6t1Ea?=
 =?us-ascii?Q?Q+GO2LJ8p9RHOhIAK+AE+A2oWDnElDYdS9JYSTDu0geZGK++SDvbTlwj0Fzf?=
 =?us-ascii?Q?qjC6UhyTfg3jYJzQNHAKM9M/LdwUIFvXViruaaJR04pltJcVvgl9g5E1xPDg?=
 =?us-ascii?Q?uMflloO7Nt4ok8wNWF1g+9SqR1mpBpKy4iCqm8snUOmNFSItxnEaeMMqtZnW?=
 =?us-ascii?Q?4SIc0R8ugKHXSxg9e5bApaucA0XetjOjRsOwj4FAIqxuxdf3+l4jMGjAll8Y?=
 =?us-ascii?Q?uu/UPLlpG8ZxNRM+o68ea1QqkrWxZbx3+OzBUk+U1+Qy3J1mXqVoKZpxKLUc?=
 =?us-ascii?Q?BIH6ivujIxIfv3XRqsNfI6kbyCfNFLcKS88bLZ88uwxSHe09D9h2JTq8BnHh?=
 =?us-ascii?Q?Vgg/tfrsXJxefdEsBmfQkVGT0G8l2hR89l+0neVIvY/p+fUaBTHRAwKFQJVW?=
 =?us-ascii?Q?LMpwAMawlJm4OWac4KXdUSXn7Iwmwd5e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d913ff-eb78-48a1-ccff-08da06a7cf44
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 17:18:23.4918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ma2Kx6CAsnrOiG1evmPh7/t1bTrv50q1RZuhQCfV6YSu9T+pS4yodg3ZOgPall2l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4594
Cc: kvm@vger.kernel.org, david@redhat.com, thuth@redhat.com,
 linux-kernel@vger.kernel.org, vneethv@linux.ibm.com, agordeev@linux.ibm.com,
 imbrenda@linux.ibm.com, will@kernel.org, linux-s390@vger.kernel.org,
 frankja@linux.ibm.com, corbet@lwn.net, linux-doc@vger.kernel.org,
 pasic@linux.ibm.com, gerald.schaefer@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, gor@linux.ibm.com, schnelle@linux.ibm.com,
 hca@linux.ibm.com, Alex Williamson <alex.williamson@redhat.com>,
 freude@linux.ibm.com, pmorel@linux.ibm.com, cohuck@redhat.com,
 oberpar@linux.ibm.com, iommu@lists.linux-foundation.org, svens@linux.ibm.com,
 pbonzini@redhat.com
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

On Tue, Mar 15, 2022 at 12:04:35PM -0400, Matthew Rosato wrote:

> > You can't pin/unpin in this path, there is no real way to handle error
> > and ulimit stuff here, plus it is really slow. I didn't notice any of
> > this in your patches, so what do you mean by 'pin' above?
> 
> patch 18 does some symbol_get for gfn_to_page (which will drive hva_to_pfn
> under the covers) and kvm_release_pfn_dirty and uses those symbols for
> pin/unpin.

To be very clear, this is quite wrong.

It does not account for the memory pinned by the guest and a hostile
VM could pin more memory than the KVM process is allowed to - which is
a security hole.

It also uses the wrong kind of pin, DMA pinned pages must be
pin_user_page'd not get_page'd and undone with unpin_user_page() and
not put_page(). This allows the guest to pin ZONE_MOVABALE memory and
other things which cannot be DMA'd to which will break the hypervisor
kernel. See David Hildenbrand's various series on COW bugs for an
overview why this is really security bad.

If you want to do dynamic pinning that is a different thing and
requires more CPU work in the shadowing operations. The modeling would
be similar except that the 1st stage iommu_domain would be this
'shared with KVM' domain people have been talking about - ie the page
table is not set with type 1 map/unmap but follows the KVM page table and
here it would be appropriate to use gfn_to_page/etc to access it.

However, if you do that then you do still have to take care of the
ulimit checks and you must teach kvm to use unpin_user_page/_dirty()
and related to be correct. This looks like a pretty big deal.

My advice is to start with the fully pinned case I described and
consider a KVM approach down the road.

[Also, I'm quite excited by this series you have, I think it shows
exactly how to fix POWER to work within the modern iommu framework,
they have the same basic problem]

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
