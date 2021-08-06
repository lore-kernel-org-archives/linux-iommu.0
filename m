Return-Path: <SRS0=o7oR=M5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132F4C4338F
	for <iommu@archiver.kernel.org>; Fri,  6 Aug 2021 12:32:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E2961163
	for <iommu@archiver.kernel.org>; Fri,  6 Aug 2021 12:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A9E2961163
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69CB583A8D;
	Fri,  6 Aug 2021 12:32:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gCpgFZr8UmIo; Fri,  6 Aug 2021 12:32:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 67AD183A1C;
	Fri,  6 Aug 2021 12:32:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28FCAC001A;
	Fri,  6 Aug 2021 12:32:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67694C000E
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 12:32:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 405DA607B9
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 12:32:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KdTREyKAEelu for <iommu@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 12:32:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2C1BC607B5
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 12:32:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=at5Y6MJ6WB9pLEfeBQyUVsuMjVD82Cg3iwUwRZ7AQMA1Akgy2cvvg4i9n/ULsacDp20/O8JSw10H7XXFQATs27+zN0xK0/fNxEXKVoura+BVod1CwAgCvdNRNycvHAHsxB4u26rlvi4X7A6Ftmo/X8mE+6BcM85BCINSOLX77R0MnTSIuJxlbSB6llgXXGTTQUfqHzEQFcb1o8Ld+CYk9YV9l180vYSYHokdMrlzDQXiuRM7StPKiTZKd990KoRkq7+c1lG4jSt2/LYiBOoNaTagUC4Qo5UFEG+YRUWAUbrIFc6gPCkor0NbACZ7an5aYQekEBB0NXw3pEBHbUoMnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxgcBaozIY21A72wPLO3n8YHDQ9KpNXJwOe+l1yDXcE=;
 b=cvcpfVIVppnca4DqPJjfMCcwdSuyOt07OoZAFt3h4v65bFxjBQoISpJbVRs7DltjYH4Oar6f7fpERVc+gYItETGcbEz5gvScBPv1dTFfw54zw3XVXsfYh9vbiZ6o17ScqCGmuY5dR1rWrNEH1u8n++Qr68Pi31yqbe9Y/3kvkYekoxDNkid6+wzZNxsx9kdlFjzBPRv+9lHN1iGfjMTBQ3iTdaSOOsDlTAYX/YAa7pmzToNLEJ1V4iTFBGTuMFrLv1dtQvcjqis2wIwKtkLNqLT6E2l41YY7+2RhmeZE7O2axqz4QYGnwxd/2AwBFiwNjMUuVf/j4hCaA7aUpGLdgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxgcBaozIY21A72wPLO3n8YHDQ9KpNXJwOe+l1yDXcE=;
 b=dQ2Z1BpXVwG6/8dktf2hTI0XcMTZKH+qs0zkWT2fGGDsX/63UXVLzPxBXlKVSMTEX9jjVUyT/pjxymYr1Y0tnlu652PxKDBEAoGGqOa13gNO0jWZ8YKzuwRbnSq04t/PfEwVu5MJdf3pWOCZmiu0e9lsbXrYJYE04j1dH5n7VIiYgJEmzTakP2xMiEwBdWLMssNyS6NVjqOWXMLDEAqhVnB6uNrLuG8009isneyTEKi21Hi1RkuohsTeEJiXM5dSZnNHYrMq1QuTNos64x1lumpeCXzMKxxDqqQZxN/o/1dm+2ymwk70bgMmHEv13C7f2hK+A/XzOKARTDjZ5dh4FA==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5523.namprd12.prod.outlook.com (2603:10b6:208:1ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Fri, 6 Aug
 2021 12:32:13 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%7]) with mapi id 15.20.4394.020; Fri, 6 Aug 2021
 12:32:13 +0000
Date: Fri, 6 Aug 2021 09:32:11 -0300
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC v2] /dev/iommu uAPI proposal
Message-ID: <20210806123211.GR1721383@nvidia.com>
References: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YP4/KJoYfbaf5U94@yekko>
 <BN9PR11MB54332594B1B4003AE4B9238C8CEA9@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YQig7EIVMAuzSgH4@yekko>
 <BN9PR11MB54338C2863EA94145710A1BA8CF09@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YQy+ZsCab6Ni/sN7@yekko>
Content-Disposition: inline
In-Reply-To: <YQy+ZsCab6Ni/sN7@yekko>
X-ClientProxiedBy: MN2PR01CA0004.prod.exchangelabs.com (2603:10b6:208:10c::17)
 To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by
 MN2PR01CA0004.prod.exchangelabs.com (2603:10b6:208:10c::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.15 via Frontend Transport; Fri, 6 Aug 2021 12:32:12 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mBz1H-00EEeK-Ji; Fri, 06 Aug 2021 09:32:11 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a47022c9-3eff-47a2-0309-08d958d6376f
X-MS-TrafficTypeDiagnostic: BL0PR12MB5523:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB55236317659F16D1465E96EEC2F39@BL0PR12MB5523.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fS/26FeFwFUDhMvwB/Qabo58Ph2TKoSkriRWE4viLxS/7lT7dWfMLi59cBm7SgqrXL2yACuX1wrAlcbiRZoyqCKeUwCN2uNqCIByTJNlKXe9jVH50xdnGVusP2kkk0BZdBfpV5gH2cB0RMcMvfgalZTfvsjU/dklpbf8DQqV70/Gf0mVJ4bdAk/IDIK6AhSWDMIWZAZwYRXvXB4TYrCcjIPn8pFjQqJg3xIZF5v08Bb9dKNFm5kq/K9/tFvQR8QD0+BiJm+rQNOvGlXNwJKaq2AwQ9KFq+Fwlf/Pk/37TKip2n7yGD5VPLccRYZboE4JpG6YuuQNqy4GgdTB7KWHyfH6NPI3XT8J3qw934GnW4ODlCbok06lCkjOuyUqr63NuR6Xpt7ww5KVbqCpCrCioLhqMhSDf8CQYrzotNlgTPlcfo47/Petfr75ga/thbMz9P4UMa2FL/CLthp0iBTKNNXb09/Sx/wBIv/nyrxxelEidsRZy1b3OBdgmk4NtK2cDgu/Qpo4aIvDWxYT7NkWUQEApl9aK4uX7iEMeYiQdgsVt06cSIG8aGuSIqDSXTzHJKSbh/o3666TKwns+aJvCEetKl4R4uZdOXr+jPz80vwfSaQsbiYvy1M3PZljfn/Vqz8zqskOihxEAgHoZMu91g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(8676002)(66946007)(66476007)(478600001)(36756003)(66556008)(8936002)(33656002)(316002)(4326008)(54906003)(9786002)(9746002)(1076003)(38100700002)(86362001)(6916009)(7416002)(2616005)(186003)(5660300002)(26005)(2906002)(426003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZoGtCKWDGSeqMtMB9E0TCF3Cjuy+PBjPK3UBXOYtBPT1My5dqmVDSJZD2TFe?=
 =?us-ascii?Q?HuQabW8keUIHciVPO+CTEW0YjOB51DuW6esffOU4nIVTrD1vUmSyGcBpKUmZ?=
 =?us-ascii?Q?BHqFRoAFjoHnbN+ho13KqGFmfyhgPjqvEm7cQ98cZ5th5sW024CUhTo+FCkL?=
 =?us-ascii?Q?XcVrwfl4FCpG97IME8rqZHNnmfMWAVtSbZOoLvgghR1TlK2azna3oqY39S7r?=
 =?us-ascii?Q?9vvVSAbq9uL4BXzVfKJLHzhNjEZeG0TpuvQPQPYcnByCMldSHw8QbVjze8AC?=
 =?us-ascii?Q?GN7qlKvQF63cjerIMOiXuIvwisqa4sCFHl1fGkn0hh8xb1bs5JHkPRxC8+Mv?=
 =?us-ascii?Q?3mFO00aDc9vwj5ykR/LQi3TuU6BfJGJAjcTj8D5yynqf5VrYjMVGqFuWP/gP?=
 =?us-ascii?Q?O2SD6ADEsUxK5ZfliKxjzbZzASlYtgBpr5zwflz1tBtUyZ0ZMRwyubrYDZCQ?=
 =?us-ascii?Q?dktphfGRc1HyjDb9t5YiPONCBfvDzU00vsNIkdkM5eGRm3WPWempNSvVAVgF?=
 =?us-ascii?Q?szfT33LKOcyh2eh4PJ3uFftN+TkohySoEIe40IkCPtaWN12JssCv79fRn6cI?=
 =?us-ascii?Q?1phQEmAlxQwtIao1zit2ewJX62xwjrqtAh6sbYHYp7lLM8jLa9e3WbNXSMp0?=
 =?us-ascii?Q?XpM1vlp/xGAE4dIevAyl/2PntlryjFdA+QmopSbmhGUnFtzEQjha3ZY/pL7M?=
 =?us-ascii?Q?J2G7pdeUJGbwbLLyMt829LZRo/LMc5CbTWyqcb6Gc2rY5aDWNfAH1wf9KeAC?=
 =?us-ascii?Q?MF6/+3M/4hamOTfaUF9YKNinfCThtC4sJFWkYlqmTRy8S5cYefpuKByFKjcW?=
 =?us-ascii?Q?p85rwS3FQQjn8b9nyk3iJqIQVAVdo8AoxIQlnxISzK31/KEGq+1Bj406GTBc?=
 =?us-ascii?Q?hB1OzI9J/9ofxZ12WmkFk+sLemu4ZqzrnYNC4VZcmZnSnqiT/fxul1Zo1ckQ?=
 =?us-ascii?Q?JmaBUkfimidSRC0hsMaseJB5n11jW3HicOKSwe4LOznerlSxbnpNMtwtsFW/?=
 =?us-ascii?Q?DzmvwgVpTKN5mRnlGdADAWwzjBjVD0G00K9j2bW8VOdE4twNb0A0yC3AG8eD?=
 =?us-ascii?Q?X91U0W3EvTPQdyiVn88s1us8NdVTHXhequJgPSmZyWFFrYjIlbxp6QYSEhzC?=
 =?us-ascii?Q?WGbgBHw5zxh7mB8qZ9GaITlqIrM17XaV5dds0GvkKaREIPc3/Zfh1VelMkIj?=
 =?us-ascii?Q?/fSW5HnKOw1fVUEXAVoGtke474h26DKuQjfRrFhWExEumERrSq0Kuj6xcAN9?=
 =?us-ascii?Q?3zeRo25V+0NFXfyIV9+9M8ZbmyuEeHkaeN13488EV57XKTOuyMn6hWyfM69r?=
 =?us-ascii?Q?kfR++YQGJoUyflLJrRDeo3yH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a47022c9-3eff-47a2-0309-08d958d6376f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 12:32:12.8462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ml2Rrj4ELvmAtFBWP/8H65+5m3xSzGMcNTFvQ2UQA+d2STujQiMtDdVE47CypcL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5523
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
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
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, Aug 06, 2021 at 02:45:26PM +1000, David Gibson wrote:

> Well, that's kind of what I'm doing.  PCI currently has the notion of
> "default" address space for a RID, but there's no guarantee that other
> buses (or even future PCI extensions) will.  The idea is that
> "endpoint" means exactly the (RID, PASID) or (SID, SSID) or whatever
> future variations are on that.

This is already happening in this proposal, it is why I insisted that
the driver facing API has to be very explicit. That API specifies
exactly what the device silicon is doing.

However, that is placed at the IOASID level. There is no reason to
create endpoint objects that are 1:1 with IOASID objects, eg for
PASID.

We need to have clear software layers and responsibilities, I think
this is where the VFIO container design has fallen behind.

The device driver is responsible to delcare what TLPs the device it
controls will issue

The system layer is responsible to determine how those TLPs can be
matched to IO page tables, if at all

The IO page table layer is responsible to map the TLPs to physical
memory.

Each must stay in its box and we should not create objects that smush
together, say, the device and system layers because it will only make
a mess of the software design.

Since the system layer doesn't have any concrete objects in our
environment (which is based on devices and IO page tables) it has to
exist as metadata attached to the other two objects.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
