Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E742DC07E94
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 12:28:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B926141A
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 12:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B926141A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F2524050E;
	Fri,  4 Jun 2021 12:28:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ehNpB7trjcfA; Fri,  4 Jun 2021 12:28:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 06806404FE;
	Fri,  4 Jun 2021 12:28:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2DC6C000E;
	Fri,  4 Jun 2021 12:28:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCF75C0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 12:28:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C3DC6606DF
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 12:28:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h2TLj_6kZHNJ for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 12:28:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2042.outbound.protection.outlook.com [40.107.100.42])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C05EF606AA
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 12:28:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bn+ZFZp7CReoIAToJHl2xXEcxuR4r8QbOEASWD6Td+VYnnHa3Ts2jzP06G89+MST//58ZKUaopGEIOXsbXm+TgAfnjxd+uVNAOms7o8vDnq6u/LYeVkq27DQHWGLjbj64s8gXwPp9+F3y+1GwP5W2Sj8qcS/nNDZ7erJWj9hu7EvOdYJi+xDe5qGdSWA7pS2T0x2wAboMpj4/DUwKEGm1S3T2S7moE8Vz40AQb5VZgxpW5Fv9I6X4yPvfU7/2DTnR3JMMc19kUmxS8bTPYeKxBHnIKyArh1VTVxUPa+6IOAq1atCaGtin7Fw3IqzcVfcocwyrrGKYmM1nDnODTFfHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fu5d3pGy38OfOTsMVCffQsQCIYJgDXX7D/gb9lT98us=;
 b=b/DcwQ48Zca6kxE4BTtNSfXMyn9msvrWzkRlk+rvk8n4qznWRibV90igxBpEG+paHXQpSqzy5hZawnNqbmospZ40IgbSrlG0RMNuVPBrgQXRsbepWmgnKsjgWl6xSWVVq1cbDjg0H/KF4KPHTIfQlM/95y/lAzCkMgjXLtFX1Drj4ERnHNMAe6W/RROEOdeh3cyhk+9D/nyJJYyd8t99eS5yZlLIVSUxyI54pAf8xogDlho4E05kcu05MTshOySuCkoaG8Edxitcu8duPXdwm/aTDeHyBcV0ltOFJx0dC60EtKefxARAs5psTlSbGW93ZquIEj2drc8ravHnLKQw/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fu5d3pGy38OfOTsMVCffQsQCIYJgDXX7D/gb9lT98us=;
 b=f8KQ+sc9WwAaoUxjIalccM/8gRCOdu7lkJJEC/C70ZP9I+ZWzIyDefmp/Mr3f8NMZHjDgr6UHQrFsA4r1avhan9t7XsDCWpYKQt9CIxuyNL14md4Q5Mohj45vfM9YnxpppfdRfT+0o+13txXuMCoOv418i3GIcSiyZXNE155+pD4k4ntlO9sQn9ogO3k6dhufAayl00HCDqNC/c/AgbMdAeuEFsrtOlx9kURXGLBN3e+KUkzHw+0rm0LwKo63gV9wYO3Nm8bhkZ455WbC52VveDnhNhTjC5OkXpZZrNe3aHGvyyapcgu+YHY0Xwht9D3tL/yUrj7CPHBvnXZVKhMEw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5351.namprd12.prod.outlook.com (2603:10b6:208:317::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Fri, 4 Jun
 2021 12:28:31 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 12:28:31 +0000
Date: Fri, 4 Jun 2021 09:28:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210604122830.GK1002214@nvidia.com>
References: <20210602130053.615db578.alex.williamson@redhat.com>
 <20210602195404.GI1002214@nvidia.com>
 <20210602143734.72fb4fa4.alex.williamson@redhat.com>
 <20210602224536.GJ1002214@nvidia.com>
 <20210602205054.3505c9c3.alex.williamson@redhat.com>
 <20210603123401.GT1002214@nvidia.com>
 <20210603140146.5ce4f08a.alex.williamson@redhat.com>
 <20210603201018.GF1002214@nvidia.com>
 <20210603154407.6fe33880.alex.williamson@redhat.com>
 <MWHPR11MB1886469C0136C6523AB158B68C3B9@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886469C0136C6523AB158B68C3B9@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:208:fc::20) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 MN2PR02CA0007.namprd02.prod.outlook.com (2603:10b6:208:fc::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.20 via Frontend Transport; Fri, 4 Jun 2021 12:28:31 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lp8wA-001dWb-Ic; Fri, 04 Jun 2021 09:28:30 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4321260a-a92d-4eaa-9f1b-08d927544384
X-MS-TrafficTypeDiagnostic: BL1PR12MB5351:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB53510B14AD2713E00ACEE909C23B9@BL1PR12MB5351.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sk/Ij179Lboy+GULYBnOSCgk7Ob/CsbJ7afwDabNz0dMbzhH0RQP7fqqGV0M1flJ/sbUHtkzRpT5YPSp0U263zwMqzULQrgwWn8AwTvgKbite3EMkpV8NOOEtRo9J/vvUdektY+oz9BIGiglFWsWohgyjrmwb+tqCzpkCRO3Jprjt2HiAEr29YuuiJwkb6uT5IAnp37FFrt+TIIqoSOUiyWtfk2ogWV1oT2Gqy4gOdSzoF7MrFoLIA7ZO5U6ca8oCU/JQnGOtK2ESg5odnW0QjP6iaMfBTBk/21Jkq2zYYYB+br4R8tfg+MZ7mm3QcX2r67Lt3iyxEVvu5kvZME6BXagwA+VQEO/K/qPXcFhjWh0FeReHdruY8JZ442/prJQRI9k+eKE4scwnyjWeCyRzSxos/KVqbsdCjPz/K2vafv1AAcXWkG23Q0uj9lHNa6igs0+vo9gnFeA9lBUM4yj9mJxiAP5twltPz4Mhcs0F9/HYG41J+LPim2rcp6v4OiSh0Ewz4GodNv0T9dpCeV3yt+ZtMAopgEGsLqW6MFOsuUt1JUlg4y0w33vfjFLCjmsJWJH+VF171pNtygTCShDoEIZH9wOqmGRiOqDJKnAO4A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(83380400001)(86362001)(7416002)(9786002)(186003)(9746002)(36756003)(66946007)(66556008)(2616005)(66476007)(33656002)(6916009)(478600001)(8676002)(38100700002)(8936002)(54906003)(1076003)(2906002)(5660300002)(426003)(4326008)(316002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2qJZSmTBBCK20/5PW8MY2pg38DXr5aRLHpD3GbG6l3S+kJTID9fg6xdmzPg+?=
 =?us-ascii?Q?1hBn7mlXCtd+IT5TfYjAbSTbVAXfq4+HEa71HGffhTO3ghA7y/AML6HQw/48?=
 =?us-ascii?Q?W5tTGlkbsnTUbQLjYUzbTWIwGvgihtcqDez+OVFpP4lSQwQiPQBZyCc8v4Kz?=
 =?us-ascii?Q?c1HidBqOAcT/6vZW0qcj9eWAuOztvcfTK6tDOBfrTlPrdZwkbwxsVzvu4yyF?=
 =?us-ascii?Q?x7CS/zBVy4piPlACFaqPNlPa6rhmD6C2PTTSThBYKqF/DgCK57rpM6rvCH1+?=
 =?us-ascii?Q?PtwTHrnHwQE8oW+CW6TJICJdV1inhY7Eny21pFODx54lM9ErPDs4fhQVxnrR?=
 =?us-ascii?Q?rChyuiwX+Vi73Fhbugd8GqK6hyqmK5D1tgPhkfNztLSyxVux8eAie4UVPaol?=
 =?us-ascii?Q?FNK8YD9Qtpkz7LRulT4So4Q0I1Mm5JV6WAvCnLcZvaNBjYjt9NU9Lk8FHhat?=
 =?us-ascii?Q?XAWFAk08ebTjgtEOrFMyEFQm5aU2NbLn8qcRNvSGx96hz/VceCh+YnbzDB2c?=
 =?us-ascii?Q?f+gk68LRhbxZeOZdLBP6P5Q4dz8cgj+YZMXwUJkZaXK1+ZEwKbBAkFHJSL6W?=
 =?us-ascii?Q?/H6WOQz/8G/NG242Ew2Nk4U951aoczOa1FVR49WGmWRc51RPmPEqH5GvBbs/?=
 =?us-ascii?Q?GxT6fCVe7phYTQSA1klPe9HZUqowbyCd3AiHCdrjRIyi5lHEgktFmPZ4yWkk?=
 =?us-ascii?Q?7JzfK1IMp45fz4Qc/cpCkOGX/zF3kgBvypGjfsTdEzpLpgpSzLfQdzQW4ksV?=
 =?us-ascii?Q?PYxkwg7j3mJc+7YGP3RKMR+s/HeMUwTZxt71ZbPTMjlqzCDtNTGFJv5bzePm?=
 =?us-ascii?Q?41lcarOwxSXgbu6rMyZ/BrE1BlsnsS96bUkVVdnbpUCv0iNkYCevYpYE2ST8?=
 =?us-ascii?Q?BEdqbilTIWkaCizyu7QppoWgsiif9UB2Oyj9SRgyT/f5wDOkmSdlcSDHXQlu?=
 =?us-ascii?Q?qSUlt7pg6jCcwcSjGQBuUuivGMiT1gr5E5aC51b0CDYO1r2bsGhvLy9vboF8?=
 =?us-ascii?Q?lITONcawUKbTSlg2rDOs4k3XVb/FT4uOTWxGdReaPUwGzLl6QEmacF3/zlr8?=
 =?us-ascii?Q?xYuwkVYnfL9xBipsbJIrkkX59vXEkwjAFfON5uqQTyBULOBv6bv58+k96fQQ?=
 =?us-ascii?Q?cibPLFmfs9o80wKc4ArtmpLtEIr6m0XPyOM7k8foRXDXufqdZcPS/rKmjR0X?=
 =?us-ascii?Q?RkVFgiURO8lBmWj+S9GTnJ5WVm3yyvMcecOl6vcZbLGJ+qxHjRtSS0eu1caL?=
 =?us-ascii?Q?mfLIlpQLwsllFvaq89nGocCiouJFvj80RFpaHo3LyxNhv/FH+qsmPneMqJ5s?=
 =?us-ascii?Q?o4UQoAo9ErKl0UnofN7yKTTB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4321260a-a92d-4eaa-9f1b-08d927544384
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 12:28:31.4570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovVMvenfegkQzasTOy3A+UqN+HQjfEHXKOt+IQpOePM4J/QltbET1rT0enRW3zXe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5351
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
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

On Fri, Jun 04, 2021 at 08:38:26AM +0000, Tian, Kevin wrote:
> > I think more to drive the replacement design; if we can't figure out
> > how to do something other than backwards compatibility trickery in the
> > kernel, it's probably going to bite us.  Thanks,
> 
> I'm a bit lost on the desired flow in your minds. Here is one flow based
> on my understanding of this discussion. Please comment whether it
> matches your thinking:
> 
> 0) ioasid_fd is created and registered to KVM via KVM_ADD_IOASID_FD;
> 
> 1) Qemu binds dev1 to ioasid_fd;
> 
> 2) Qemu calls IOASID_GET_DEV_INFO for dev1. This will carry IOMMU_
>      CACHE info i.e. whether underlying IOMMU can enforce snoop;
> 
> 3) Qemu plans to create a gpa_ioasid, and attach dev1 to it. Here Qemu
>     needs to figure out whether dev1 wants to do no-snoop. This might
>     be based a fixed vendor/class list or specified by user;
> 
> 4) gpa_ioasid = ioctl(ioasid_fd, IOASID_ALLOC); At this point a 'snoop'
>      flag is specified to decide the page table format, which is supposed
>      to match dev1;

> 5) Qemu attaches dev1 to gpa_ioasid via VFIO_ATTACH_IOASID. At this 
>      point, specify snoop/no-snoop again. If not supported by related 
>      iommu or different from what gpa_ioasid has, attach fails.

Why do we need to specify it again?

If the IOASID was created with the "block no-snoop" flag then it is
blocked in that IOASID, and that blocking sets the page table format.

The only question is if we can successfully attach a device to the
page table, or not.

The KVM interface is a bit tricky because Alex said this is partially
security, wbinvd is only enabled if someone has a FD to a device that
can support no-snoop. 

Personally I think this got way too complicated, the KVM interface
should simply be

ioctl(KVM_ALLOW_INCOHERENT_DMA, ioasidfd, device_label)
ioctl(KVM_DISALLOW_INCOHERENT_DMA, ioasidfd, device_label)

and let qemu sort it out based on command flags, detection, whatever.

'ioasidfd, device_label' is the security proof that Alex asked
for. This needs to be some device in the ioasidfd that declares it is
capabale of no-snoop. Eg vfio_pci would always declare it is capable
of no-snoop.

No kernel call backs, no kernel auto-sync/etc. If qemu mismatches the
IOASID block no-snoop flag with the KVM_x_INCOHERENT_DMA state then it
is just a kernel-harmless uerspace bug.

Then user space can decide which of the various axis's it wants to
optimize for.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
