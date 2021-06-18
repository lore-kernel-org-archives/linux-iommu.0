Return-Path: <SRS0=sMz+=LM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3469CC2B9F4
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 00:11:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B79F3613BD
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 00:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79F3613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 72654400C0;
	Fri, 18 Jun 2021 00:11:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HJADgg2l7UXI; Fri, 18 Jun 2021 00:11:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 30B9440003;
	Fri, 18 Jun 2021 00:11:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0881AC000D;
	Fri, 18 Jun 2021 00:11:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F33D2C000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 00:11:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CC2C46064C
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 00:11:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B3YG8sabrgzf for <iommu@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 00:11:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::604])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 730AC60641
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 00:11:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRwnr70ZdsLBOJd7FZfzlm87pn/0GPANWM9bbj88ROKRiX0F0vVQo6Ja7WuY54Hrh13d8Vb0ch2i5abILM7GDgr9T5kJPQ6loQtklR/s5dqKzL96xpU8ihYUTn9Z3iG/oW6/UX0D86rfPvwaNHKS6ipbsox48J6MizESEHoG95c1RkQ1F9WCd5sBzQj/REtqoy1C6Es/FOaK9CKur9fWKknwH6Ch2yzf+DOukGvydb04P1c7DrrrKkGP+MrYEgZbjjdAvESUvNuEnUhqKYgbEwlJnm5TbUY/I7IeldSg0mMN2zO6z1VJbUdl0dx+030jCr7iaGHctQP8QesDXULTMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NJTwr3QfULOMHB2SffB+qqbmhbkV8aHkx8RIgJWBXw=;
 b=kAZmte2AaTMWAccywhuGUs8+B61DjdE8zaGFwnftCKBvC7vNB6YUMdnN6TZjEBvbMqETorZ8aRdFXriNb87Yo0f1KpDvq9maTfmoY2sYRDJJN24xJjVgrNDRmTZStJyDNpL16g83eq9zfTqJ+HdUWp+mswz11SOtVoNbVBmmT95WatgCk7BVgtqobc01KeouKNL8X71BCQpFFKlOZor9MMhXd5Nra6XCtiv5HrE4JG6W+dADJKoQsQFizXyUGPpN04PESl9Ewbks9NDRZgNZ6Ah+MOlHskBVXD6VCAKv5khVEmi5JHq4Vz40VGmuwVhlSuzgJV7CPNesQdNwQlnuAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NJTwr3QfULOMHB2SffB+qqbmhbkV8aHkx8RIgJWBXw=;
 b=o3zOvU06kt978HX9UZYsy1JX+0C4k105v4A/xrZbeTWA/bkEuErej3L3QZ+HHA6bwiod3jq2TdxuiddxAxhJZVLj2gc1D/k0xAwELkK+FS4HsNzNNbwU4sLOxXfFMVhkBBg6F6A3GAUjFl1rC8lWqv0+/+9SYYzP6NWYEhj28gP2kKyWlTR0aSHHGAm4ukgA+ciwAwv8ctHlNmM9//wE3/J9Im5saamUXKBpb6bOSmJkaOIhwbECQh4Uv8P1eKRWGxhp5p6Hk9GU/HvfAT0l7sao780vl93KI5JbNPtrqecrY+pkVUkFbzhmNpoAoV11xQlhhKwFN/tPmFEEnVFLSA==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5521.namprd12.prod.outlook.com (2603:10b6:208:1c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Fri, 18 Jun
 2021 00:10:58 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 00:10:58 +0000
Date: Thu, 17 Jun 2021 21:10:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: Plan for /dev/ioasid RFC v2
Message-ID: <20210618001056.GB1002214@nvidia.com>
References: <20210609184940.GH1002214@nvidia.com>
 <20210610093842.6b9a4e5b.alex.williamson@redhat.com>
 <20210611164529.GR1002214@nvidia.com>
 <20210611133828.6c6e8b29.alex.williamson@redhat.com>
 <20210612012846.GC1002214@nvidia.com>
 <20210612105711.7ac68c83.alex.williamson@redhat.com>
 <20210614140711.GI1002214@nvidia.com>
 <20210614102814.43ada8df.alex.williamson@redhat.com>
 <MWHPR11MB1886239C82D6B66A732830B88C309@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210615101215.4ba67c86.alex.williamson@redhat.com>
Content-Disposition: inline
In-Reply-To: <20210615101215.4ba67c86.alex.williamson@redhat.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR15CA0006.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 MN2PR15CA0006.namprd15.prod.outlook.com (2603:10b6:208:1b4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend
 Transport; Fri, 18 Jun 2021 00:10:57 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lu264-008L1O-IQ; Thu, 17 Jun 2021 21:10:56 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cad01430-a874-44df-ef50-08d931ed8c09
X-MS-TrafficTypeDiagnostic: BL0PR12MB5521:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB552147877A13904E1D862E46C20D9@BL0PR12MB5521.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lRdqpWAsmQb3i90WvyuhuZqip61r2kTRSV3gP7rEXvb49IHXh37sIHrTPukM2WztntV8Ydry/9yxbEY6uoyap+h8CwulXq486OesWfkYtw0cDIiYIP7pczUy7o2e94JZpO3bWzxcDBvuTt4HjyXiXXwBU0ySNmCnbb1nnEx6zALgYvXn2N9x3zjR1+z1qXP176AYezdUhyWkVEyEP5/f+r5ZGn+wmkDJ8v3LuvBwswQNvq/0o0ZTPQDffKNrkWM5hoyWLcj0uDIK1LjHOIWE3oErqF+Z6tHYFNiS+WdAKPlCegqiQ5MAsKRnjx20TfyYb6e0v1XfsMJMXRwHjtojU2ERbPYj6+zGgtvicGesrzbONgq6gSKYwIP1A0Pmw48DtqG6QjT32SQELpw2xwGpIC5vKqbtGfxzD9qJbxTR3N+ZuQklFJyrk1MRPo+jntHK6oT64BFmHxPk/cy0eEV3+Z6Jdebi6J3xV1RnF9iNIuFi8jHrx2G0IGwA7aX8BI9BbAMgHccFN+9ZAoZrgm/UQTrwz/rEFeMfGz3Ztg7g3ST0hrN71bOlF8mXwoAZjbpaQ/ErjirlVDxQ5NrvO2TWWKhLBr4UWdWUB1rKfLPoH74=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(86362001)(426003)(7416002)(33656002)(478600001)(8676002)(66946007)(26005)(9746002)(36756003)(316002)(9786002)(66476007)(66556008)(6916009)(186003)(5660300002)(4326008)(2616005)(1076003)(83380400001)(2906002)(38100700002)(8936002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Cwf903D4fqkzYn6Wk3ivb5bTxk8WRHZh6l9NtPAo6V4YqXAk/+Q5FM47e8w?=
 =?us-ascii?Q?rfVzs7agTy7g3EgePvdIvi6J4meHXSsa4GMyE4pBbYxssvIcvsBLDd9TXN9V?=
 =?us-ascii?Q?ouoD/reU6eEbLOwFoh7mh5JovogtGPSDrv7zxEcORVlVjpovgrQhYuov0pvE?=
 =?us-ascii?Q?1DBEPaHWxoYZEskO9E2sr2rwwZ6U96U7NNXWmaMPB/PKAxlbbTws18F2nHz1?=
 =?us-ascii?Q?wnjfn5xnPXGMQHbkES6WUyZSGpQ7Dou3rh8MgquynnY+JrFogbqmZwcT8w8H?=
 =?us-ascii?Q?RnOW3BKJ8p4UnJ+PwAodq29qaQTtmcZrWDGvCIoL5G4gFrQo394ILmGod3EC?=
 =?us-ascii?Q?81J9te+hCOEzqaO2Gq7CffbELdYG2qwtFg76M3IoW6QPqJ66r5G3xTaeCSDR?=
 =?us-ascii?Q?mvair9dfyBeWPZhFI/OuVZbm2kxQwZ9NlTtmk9s1bHGPqzmuLnvTiiISxKxE?=
 =?us-ascii?Q?mtMtt5MBx7AYHfC5JbiLLK9pgsQNUEneseRSTZ7PkG6WYZYT9BKm1KHgaZrO?=
 =?us-ascii?Q?VGyE7zN40wFzSvpoZIz9wccZrla78dv01jWFqYgZmurhjVNK1JHqm9yM1RsC?=
 =?us-ascii?Q?pUk3Pl26EQ0OSNSX65yix7wD5sLY84Awq++LpusD+CZ8jciY0kb5+bBVQp9M?=
 =?us-ascii?Q?X9FosESY8Trl08thiFnCIBFlUjV8FpuOjCgw1TGk1IIRcV6QD1nFRcOJwBQe?=
 =?us-ascii?Q?miP1LvgE6MLKQA0HMANsdEDq3xnLdR2By4Xnp6nfYHExWhIUaqSs+fgIAo1i?=
 =?us-ascii?Q?deTJo+PawL18Bvb0aCL2eZHv9wO+Qpc2Tpx8EYTu2z5Cf++Wel9ac1k130rg?=
 =?us-ascii?Q?Km3sYb//jRRhNrzTuS/WJTrrCHP7eEVfY4rx5HyyMZzyq90GxzyLC5tpn2Jo?=
 =?us-ascii?Q?XhwAe9333pIhT5QukdbKRTaI75c1ECU7c1BpCz0y9m93rn9eLh+Sum0Y8RD6?=
 =?us-ascii?Q?5vmW+v2cFzjdZQXyM10dQll9T7V1qZ61iCmMEOJRwt4/YrcOoJDag2kJu0rl?=
 =?us-ascii?Q?Eo+I1AQMtueHfs5cezgrkCsEVw2SaazNKgj2Ybw3Zrjl2/it05bK1i01l+o/?=
 =?us-ascii?Q?UVQVqaqb9RuGm9e01om0HqGdWDrgIfpipVrzDsP9Yv5mR7xNjM82hQh3Kx4b?=
 =?us-ascii?Q?IvlldBKpbAsJAFdEFH6dTQYJM3k/E6v9UwqlsE8BzrnBlOA6Oln2Wk5LDBXG?=
 =?us-ascii?Q?L2fxVVyUEdUKN9QvN4BWNPEsLVBKB7u7BoRhU6g53IJVz50wiZoh3kubyZUG?=
 =?us-ascii?Q?NjdvT4lm8Mg2Xo5EvsDcA3T/XTsk1+bWPcGQBCWDz7WEpCov98pV5bB3l/Hl?=
 =?us-ascii?Q?2VnM76U+25TxOt/gWDdTARl9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad01430-a874-44df-ef50-08d931ed8c09
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 00:10:58.0826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y55zyGeAi/mgS1YdgC3qNgF2hKImzZ+UFizgCC/yyWET+3FYOYD8SCYA99XKyc9Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5521
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
 "parav@mellanox.com" <parav@mellanox.com>, "Enrico Weigelt,
 metux IT consult" <lkml@metux.net>, David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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

On Tue, Jun 15, 2021 at 10:12:15AM -0600, Alex Williamson wrote:
> 
> 1) A dual-function PCIe e1000e NIC where the functions are grouped
>    together due to ACS isolation issues.
> 
>    a) Initial state: functions 0 & 1 are both bound to e1000e driver.
> 
>    b) Admin uses driverctl to bind function 1 to vfio-pci, creating
>       vfio device file, which is chmod'd to grant to a user.
> 
>    c) User opens vfio function 1 device file and an iommu_fd, binds
>    device_fd to iommu_fd.
> 
>    Does this succeed?
>      - if no, specifically where does it fail?

No, the e1000e driver is still connected to the device.

It fails during the VFIO_BIND_IOASID_FD call because the iommu common
code checks the group membership for consistency.

We detect it basically the same way things work today, just moved to
the iommu code.

>    d) Repeat b) for function 0.
>    e) Repeat c), still using function 1, is it different?  Where?  Why?

Succeeds because all group device members are now bound to vfio

It is hard to predict the nicest way to do all of this, but I would
start by imagining that iommu_fd using drivers (like vfio) will call
some kind of iommu_fd_allow_dma_blocking() call during their probe()
which organizes the machinery to drive this.

> 2) The same NIC as 1)
> 
>    a) Initial state: functions 0 & 1 bound to vfio-pci, vfio device
>       files granted to user, user has bound both device_fds to the same
>       iommu_fd.
> 
>    AIUI, even though not bound to an IOASID, vfio can now enable access
>    through the device_fds, right?

Yes

>    What specific entity has placed these
>    devices into a block DMA state, when, and how?

To keep all the semantics the same it must be done as part of
VFIO_BIND_IOASID_FD. 

This will have to go over every device in the group and put it in the
dma blocked state. Riffing on the above this is possible if there is
no attached device driver, or the device driver that is attached has
called iommu_fd_allow_dma_blocking() during its probe()

I haven't gone through all of Kevins notes about how this could be
sorted out directly in the iomumu code though..

>    b) Both devices are attached to the same IOASID.
>
>    Are we assuming that each device was atomically moved to the new
>    IOMMU context by the IOASID code?  What if the IOMMU cannot change
>    the domain atomically?

What does "atomically" mean here? I assume all IOMMU HW can
change IOASIDs without accidentally leaking traffic
through.

Otherwise that is a major design restriction..

> c) The device_fd for function 1 is detached from the IOASID.
> 
>    Are we assuming the reverse of b) performed by the IOASID code?

Yes, the IOMMU will change from the active IOASID to the "block DMA"
ioasid in a way that is secure.

>    d) The device_fd for function 1 is unbound from the iommu_fd.
> 
>    Does this succeed?

Yes

>      - if yes, what is the resulting IOMMU context of the device and
>        who owns it?

device_fd for function 1 remains set to the "block DMA"
ioasid.

Attempting to attach a kernel driver triggers bug_on as today

Attempting to open it again and use it with a different iommu_fd fails

>    e) Function 1 is unbound from vfio-pci.
> 
>    Does this work or is it blocked?  If blocked, by what entity
>    specifically?

As today, it is allowed. The IOASID would have to remain at the "block
all dma" until the implicit connection to the group in the iommu_fd is
released.

>    f) Function 1 is bound to e1000e driver.

As today bug_on is triggered via the same maze of notifiers (gross,
but where we are for now). The notifiers would be done by the iommu_fd
instead of vfio

> 3) A dual-function conventional PCI e1000 NIC where the functions are
>    grouped together due to shared RID.

This operates effectively the same as today. Manipulating a device
implicitly manipulates the group. Instead of doing dma block the
devices track the IOASID the group is using. 

We model it by demanding that all devices attach to the same IOASID
and instead of doing the DMA block step the device remains attached to
the group's IOASID.  Today this is such an uncommon configuration (a
PCI bridge!) we shouldn't design the entire API around it.

> If vfio gets to offload all of it's group management to IOASID code,
> that's great, but I'm afraid that IOASID is so focused on a
> device-level API that we're instead just ignoring the group dynamics
> and vfio will be forced to provide oversight to maintain secure
> userspace access.

I think it would be a major design failure if VFIO is required to
provide additional security on top of the iommu code. This is
basically the refactoring excercise - to move the VFIO code that is
only about iommu concerns to the iommu layer and VFIO becomes thinner.

Otherwise we still can't properly share this code - why should VDPA
and VFIO have different isolation models? Is it just because we expect
that everything except VFIO has 1:1 groups or not group at all? Feels
wonky.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
