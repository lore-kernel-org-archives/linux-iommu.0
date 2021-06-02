Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0841AC47092
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 16:01:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B19B861585
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 16:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19B861585
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7BBDB83CA3;
	Wed,  2 Jun 2021 16:01:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aIPmZQYYosCg; Wed,  2 Jun 2021 16:01:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 41FCC83C8A;
	Wed,  2 Jun 2021 16:01:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FA72C000D;
	Wed,  2 Jun 2021 16:01:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6FB1C0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 16:01:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9656A404E7
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 16:01:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JVVJLiQWvKOY for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 16:01:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::619])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E6EA7404E6
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 16:01:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9yS7Xa2hCh3g9SobAJqz1lfD7Z1AhSuunOSmE1UgBNDd+QNTB4qhnkXO3hjlyvDuv+caGvLQuXAk1F6lvw58m3bgYL+ls06Qe96H8wU06QJzY+ggl2uf2uwBcAV5m73WTjmZbZrqX/gYL3ATE10QFdal7PEYvMh+IZyOO2zfFZKVaw2N4ZXicYK88zo6+rwJqlecfKZdCIyNsvvPU0glY8oitNh4vX3BnQhYge0NgsoR/4il2Ef7ejqI3q5PrDvEjdc2OWKQsyjpDg2UHbjf82Zd1n5u1xc0fdRzr58inXQFuw9FIlhfGImLbY4CB0guytVRJgMybfCWDXhw5neAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nk4qTEL+5PUXPrpm+8hRMmz0vr1Mv018I5sfGeKFakA=;
 b=LugJaaPugmv0FHzf+a242OjzQroanPwGzU3HfA8ltpjojZU/GwLD1otET+PoFpDZX3yYkEp4de4Vj7fqFo/PN9x7BbAFaHm46ZMDScIiL1c0UHsua3HQZXTvP0XeeUVA5pz7lyoc3uKao585DLCTn1eIYw7isSaOsb7cA2oEAyO/7NtqgDCcEQmQQX4glcwKLb8fqr/urkeZTy6+m16/SzdPDnMIWMQQ9xLNEnqUaJbE9tnO+XEOns26I+nQsAQFWLO7Cal3/N6ZJyCKj8v2tSIAygPo69ZZpNqzUqe3ieEGNra16IwN46UPTDGh/bf2eqIOm5NXkaTG+9PyhZYOag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nk4qTEL+5PUXPrpm+8hRMmz0vr1Mv018I5sfGeKFakA=;
 b=mdl1yV7BZD6CFdZqDbUBYNrylLlQt3nNE4G+BRz7ZTaU8jcWErhmV1uHnsrDkuZ2U7cl4g1xQ1HfFECkWyT1HWzRWB+OWiA3NXJmLOAcZqvUZ6wGbXN7yK9j0cqWeU9T5QmvNQTXkj+uXKpuiT8e5sDHiVQxdAKo5hX2dAgNu8HNqBG2JEwL4JcX9tT8qQjm6KkfC4SWa12vGRSWcewQKBRATqc7KAkDF+LtIbPHp5Ol3Xo673XqEpFZMAR8QQ0Y6HgoD/awj7ZWdNTeF4oQgblli8zDCG3udOupnLYZ9p6LWq3DeLA9O6Fpq26UbtvSTj0s05SHUrxd8rFPmxIAww==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5521.namprd12.prod.outlook.com (2603:10b6:208:1c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:01:42 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.020; Wed, 2 Jun 2021
 16:01:41 +0000
Date: Wed, 2 Jun 2021 13:01:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210602160140.GV1002214@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528200311.GP1002214@nvidia.com>
 <MWHPR11MB188685D57653827B566BF9B38C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210601162225.259923bc.alex.williamson@redhat.com>
 <MWHPR11MB1886E8454A58661DC2CDBA678C3D9@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886E8454A58661DC2CDBA678C3D9@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR11CA0009.namprd11.prod.outlook.com
 (2603:10b6:208:23b::14) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 MN2PR11CA0009.namprd11.prod.outlook.com (2603:10b6:208:23b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Wed, 2 Jun 2021 16:01:41 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1loTJM-000HFT-PY; Wed, 02 Jun 2021 13:01:40 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0e23691-f9dc-4cbc-4b02-08d925dfb652
X-MS-TrafficTypeDiagnostic: BL0PR12MB5521:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB552196EEBB8C956A109A58FFC23D9@BL0PR12MB5521.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O6wJbI3J+JZpctomcMQP6jvnltGlfvZHUT5dz/fbFaE8yBURYw2YKP4qTTPd95Yvrvo56l6Agly/G1bkbuF1x/cOHk8jUTj11IzE6c1JLrzwa7XHTrflLfYp2+uLzG6EerUaiX84PExKdK6aKC/o1inlq1BkZaNFEfbBg/s5iURK2gzkgiUrIxTuZMDIEX0EiDcMPOz1kfdcTDx8DOisGUE0MeMx1+imNpKSPz72FgRAhM69+xo2zYXVDrvClJWE0IafYws9XXkpq3HSzYP7Afdv7KcjtuV2KcZ1HsFDNTQWE5tfo4cd2hl8243v2CvlbUUfb9ze0FFhMJDuYJcoJmhWAMevLeGr5FlUIdpzihVQDUn+jKBBLGNOmShpJYEhLWxDSKKDU/bmI1pg8Q32O0e8IVCFB59Cvs2apVk05NqSgPcoAn6olFJBduwAhGg2A/2Pia55z/vR9Zrc+9OB4u1jOv7m1MZFuR70RLL2oKlEWPo+FbRRcq39zNA8WHnXpH8sRKhhcuKDiOsQnV2jU6oIGFTDI8DE9R3LNr0jrmIszkyc2X1s928XDFzvaIiITtn7nQ+zf+2XdsBcLHfXMljx6RDXMqTzyLwXqMeUhg8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39850400004)(366004)(346002)(2616005)(5660300002)(66946007)(1076003)(66556008)(426003)(38100700002)(186003)(6916009)(36756003)(66476007)(8676002)(8936002)(33656002)(9746002)(478600001)(2906002)(26005)(4326008)(54906003)(86362001)(316002)(7416002)(9786002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fjoe2rb5RoMuwgd0sfLVNiUDBYamZxdS6bT1aJaNjm3TMEn9rT+j9jXhgnGS?=
 =?us-ascii?Q?xOSEpNfE0Q8E/5wn4R/P9Nz+ZK9OjKtUBlxBxJQ50yvTvVRD2+1ec7VlrMjq?=
 =?us-ascii?Q?XqrTZfv6lv5OAPXuyybMfgDNRxkjQFOhGtz4td4hXC6yt+Qv3m5mQo9eGWlG?=
 =?us-ascii?Q?+enyKV2dJpRFIf4lA+Yt93t/vbD9FElO/5z6a2mqNndO9GC3P2VG0j88xuOW?=
 =?us-ascii?Q?q1JkXGYbg7ow+R91xkEkkUiGZ7tvLMOmXU+S8ZWdQRQYIy3FiO1DZ5tK3sWy?=
 =?us-ascii?Q?BypNp1/lDkDlRCu16MMNaLPev+a/hKzfhoBv4Cbw6qezMVztqTBC5J6E3d4o?=
 =?us-ascii?Q?+mlkLEMvEXl4jhGUsSeXzN7LcPEhXvB8JMagzLuSAVFYqYunHM6neF4s958Z?=
 =?us-ascii?Q?4gVRVO47f3rDqplMmnDSreNj7eKs738QXfVMjJ61ev2uFemRO4sTOMp6an/W?=
 =?us-ascii?Q?jyQ7+UG903mUwciM7iiegCTY+Owrx6oG9SAP8kIAL6Xichidt5DGFb3yBi1/?=
 =?us-ascii?Q?+EMiS9+QlyUXNnU0zPebE2jV9ttMoa4+MQGfCMSUn6/EpisoIJp7JPcNa7nq?=
 =?us-ascii?Q?Oi5NaexTuhGV86Rx1X6Qxglt5OQjLf7lsMYWhdUckibe2FKh+3mr/Kz3GGte?=
 =?us-ascii?Q?Jiu7YwkzzruDYbJTZVTgWCMfgIHb7xtOt589HVACPdfmGRvZMATLrVrxbVSu?=
 =?us-ascii?Q?oYBRCDDde8B7BvXInGExwbM2ihTrzacvMi8clEPZYbQVdIyG6oAKLk1e85Dr?=
 =?us-ascii?Q?+lvX+qhLbzEnDHkkPm97A5li8EvgJeL0W8ACobm+4OmFDKAxWn/goVX8paWq?=
 =?us-ascii?Q?ESdhfCNarFAgyfzjpQ5D8YRpT52kMiS6K5i30gWSZ/pKKuW7YPmuOGSflSi/?=
 =?us-ascii?Q?xf83ENt+qFKt3OEjgd9JljomsAcWGupSNJylpl/9klAGolnOkpciIuZ8c+Yf?=
 =?us-ascii?Q?Gzgy7nRlAr5rU+tYAsppWQRSFm+Vh4ATJvpKePiUu7MZJ4P8p4HhzwGPyOB9?=
 =?us-ascii?Q?ZPYXTdua1O9QJSIciTklJ8hxvxBssap0KPq5Rx1M+WHbGtxHwPd7BCkZFMrF?=
 =?us-ascii?Q?fGrapB5UNATRdYBMY1eAl5GEI8LTu5ueQGK/0TU2+8QZHtgBviIdj7ST3n1S?=
 =?us-ascii?Q?S0dNoDmn1o8c/fZHjy8hoMp6MbagpMF+De3QcDeJRVlgpf8neR0FGpiCMo+h?=
 =?us-ascii?Q?lDL5TckfxJDWMxwEhSXpaWMwDHgCU0xiUAj96ax4rPB0N/I8rw1MEAEmBfGf?=
 =?us-ascii?Q?rHZ4Zd2WRNB2zBl685bcjQdqcFuoovf9hqAwEIA7LL3OEhX4EeCB+k389AqF?=
 =?us-ascii?Q?6iRR+gPjnK+xwrGcDuSxouOZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e23691-f9dc-4cbc-4b02-08d925dfb652
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:01:41.8936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0RKPJraCSZke0g5lhr7ewA0fwqn/i9XSLFJTGMSQpCDnUF0SJf4EsnkTT2Vv1L8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5521
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Kirti Wankhede <kwankhede@nvidia.com>, David Woodhouse <dwmw2@infradead.org>,
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

On Wed, Jun 02, 2021 at 02:20:15AM +0000, Tian, Kevin wrote:
> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Wednesday, June 2, 2021 6:22 AM
> > 
> > On Tue, 1 Jun 2021 07:01:57 +0000
> > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > >
> > > I summarized five opens here, about:
> > >
> > > 1)  Finalizing the name to replace /dev/ioasid;
> > > 2)  Whether one device is allowed to bind to multiple IOASID fd's;
> > > 3)  Carry device information in invalidation/fault reporting uAPI;
> > > 4)  What should/could be specified when allocating an IOASID;
> > > 5)  The protocol between vfio group and kvm;
> > >
> > ...
> > >
> > > For 5), I'd expect Alex to chime in. Per my understanding looks the
> > > original purpose of this protocol is not about I/O address space. It's
> > > for KVM to know whether any device is assigned to this VM and then
> > > do something special (e.g. posted interrupt, EPT cache attribute, etc.).
> > 
> > Right, the original use case was for KVM to determine whether it needs
> > to emulate invlpg, so it needs to be aware when an assigned device is
> 
> invlpg -> wbinvd :)
> 
> > present and be able to test if DMA for that device is cache
> > coherent.

Why is this such a strong linkage to VFIO and not just a 'hey kvm
emulate wbinvd' flag from qemu?

I briefly didn't see any obvios linkage in the arch code, just some
dead code:

$ git grep iommu_noncoherent
arch/x86/include/asm/kvm_host.h:	bool iommu_noncoherent;
$ git grep iommu_domain arch/x86
arch/x86/include/asm/kvm_host.h:        struct iommu_domain *iommu_domain;

Huh?

It kind of looks like the other main point is to generate the
VFIO_GROUP_NOTIFY_SET_KVM which is being used by two VFIO drivers to
connect back to the kvm data

But that seems like it would have been better handled with some IOCTL
on the vfio_device fd to import the KVM to the driver not this
roundabout way?

> > The user, QEMU, creates a KVM "pseudo" device representing the vfio
> > group, providing the file descriptor of that group to show ownership.
> > The ugly symbol_get code is to avoid hard module dependencies, ie. the
> > kvm module should not pull in or require the vfio module, but vfio will
> > be present if attempting to register this device.
> 
> so the symbol_get thing is not about the protocol itself. Whatever protocol
> is defined, as long as kvm needs to call vfio or ioasid helper function, we 
> need define a proper way to do it. Jason, what's your opinion of alternative 
> option since you dislike symbol_get?

The symbol_get was to avoid module dependencies because bringing in
vfio along with kvm is not nice.

The symbol get is not nice here, but unless things can be truely moved
to lower levels of code where module dependencies are not a problem (eg
kvm to iommu is a non-issue) I don't see much of a solution.

Other cases like kvmgt or AP would be similarly fine to have had a
kvmgt to kvm module dependency.

> > All of these use cases are related to the IOMMU, whether DMA is
> > coherent, translating device IOVA to GPA, and an acceleration path to
> > emulate IOMMU programming in kernel... they seem pretty relevant.
> 
> One open is whether kvm should hold a device reference or IOASID
> reference. For DMA coherence, it only matters whether assigned 
> devices are coherent or not (not for a specific address space). For kvmgt, 
> it is for recoding kvm pointer in mdev driver to do write protection. For 
> ppc, it does relate to a specific I/O page table.
> 
> Then I feel only a part of the protocol will be moved to /dev/ioasid and
> something will still remain between kvm and vfio?

Honestly I would try not to touch this too much :\

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
