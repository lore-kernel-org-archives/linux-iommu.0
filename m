Return-Path: <SRS0=GPww=FV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A5BC4361B
	for <iommu@archiver.kernel.org>; Thu, 17 Dec 2020 23:17:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 645B52336F
	for <iommu@archiver.kernel.org>; Thu, 17 Dec 2020 23:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645B52336F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 02127203FE;
	Thu, 17 Dec 2020 23:17:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RrFIbjE+Pm-A; Thu, 17 Dec 2020 23:17:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 04C78203F7;
	Thu, 17 Dec 2020 23:17:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D78DCC088E;
	Thu, 17 Dec 2020 23:17:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CCA3C013B;
 Thu, 17 Dec 2020 23:17:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9113D87728;
 Thu, 17 Dec 2020 23:17:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a0kuaTH4flpN; Thu, 17 Dec 2020 23:17:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 060A78771F;
 Thu, 17 Dec 2020 23:17:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkU2C5P3StRUfYjyPJFcfl/G5w4+52Oaos29fzl9mjRfDpwZaSMjsKSJ2j3MDDS1e7ISfKY+QJ9w3HLEb6DClBq0c8vPaFw1RxDFH40eRwzAb5fMTrSXCYva1yG5gKrULyV03rDQR0s8BcgUvnmTQwFnYklyJKXSWYij+mP7xfpYY6gnRMB6rg6TuVc0fELyyfiSFmD18Acn32mZOnsn78cCSDi6Cu6EdDll5ejU2tcdCNi8y5DFPf74XNraIYn3MoaG7dwhPM7bXSpL0vT0KZjoYDwx+wTQhwL0dD4HUyaZzvqKy23aez9QKsxMhCL6E8fK3b03dtQRI0msLSWKoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8xbKhYrrW4KdcYZdAOR2IuHN8Gz6WY4wGg6akBcGQw=;
 b=OIJEMW80zkbGeY4EZ5/QKCGj6EF+ycOcWAn627DfBVl3Ewk2i2vmeurR1YlA47Fp4b8uDTxxvQtMUneUbrBch8wj8qvTKtwGnCpDf9DZp7ADinDZtQsau2aRKk9U1bX4L3lZBI5nFvsd5CA0qR9kh2BUM6syse5ZFhcfUwA/TFQMdlpv5urKSoZ/nkWYiXAVqkF4wxU7GXojbscXdbqJGrMWZTmPwjQlrl2Lj/Q+D7IWkMy+249VE4+0eHjRINtrOIkTZ2BX1x5/PNiM2OkVt1azTv1IYM13RPmvrUeX3+9fm6Z2ET2zqeys29yJBtMddCZ2jKRP4dr6CV9XnOHkyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8xbKhYrrW4KdcYZdAOR2IuHN8Gz6WY4wGg6akBcGQw=;
 b=WLnuwm2oXfa85Uj7GxuJdtu9IvxZKTsRAC+2Rb3E6tspcggVMuWnQmTzLbbN4zJEmeAOkaKIqnwfXmgEg1zdd3zjhOKdWnmYj2lCbkoWFWzwb+tD8oDH/QpAYyznHnioYja61EwOkrimXB/eWKP4dJQpj2rVYoDob2wb6H5bsEg=
Authentication-Results: aisec.fraunhofer.de; dkim=none (message not signed)
 header.d=none;aisec.fraunhofer.de; dmarc=none action=none
 header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.20; Thu, 17 Dec
 2020 23:17:21 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec%3]) with mapi id 15.20.3654.024; Thu, 17 Dec 2020
 23:17:21 +0000
Date: Thu, 17 Dec 2020 23:17:17 +0000
From: Ashish Kalra <ashish.kalra@amd.com>
To: "Radev, Martin" <martin.radev@aisec.fraunhofer.de>
Subject: Re: swiotlb/virtio: unchecked device dma address and length
Message-ID: <20201217231717.GB14861@ashkalra_ubuntu_server>
References: <d2ae0b1d-332b-42a1-87bf-7da2b749cac2@sect.tu-berlin.de>
 <20201214214950.GC18103@char.us.oracle.com>
 <c3629a27-3590-1d9f-211b-c0b7be152b32@redhat.com>
 <20201215074427-mutt-send-email-mst@kernel.org>
 <DBDBA8B6-6CC3-47B5-A20E-6D5DD29DB47E@oracle.com>
 <AM7P194MB0900948E02C21FB13B722CD5D9C50@AM7P194MB0900.EURP194.PROD.OUTLOOK.COM>
Content-Disposition: inline
In-Reply-To: <AM7P194MB0900948E02C21FB13B722CD5D9C50@AM7P194MB0900.EURP194.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DS7PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::11) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by
 DS7PR03CA0036.namprd03.prod.outlook.com (2603:10b6:5:3b5::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Thu, 17 Dec 2020 23:17:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 41856ef5-6995-4bab-ceda-08d8a2e1e802
X-MS-TrafficTypeDiagnostic: SA0PR12MB4430:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44309AD8443B9D395AD52F678EC40@SA0PR12MB4430.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WCpZPskPFw47euG8XPs/ij6Av9kT2b/GHEqEYHMahPj4TBe+DhOoFoZ2ES4GSPcIwJE0RSsLw5pZx+2swwNSPqz4quny8plPgcYtmBH8NQW3hrBJCg91CDEChfmsKUuyXf2LXyp6I27HmZAm+SkKnLsqXpK/gzIvZiVILhECccm8i6jeYj0yjk5uufZ1dNVtMBymHCamsiJ9XTqGlnDxPJh3WOikEdzTnqVadAY6lUVL8WicSToBWy+V5CY6u77vr/N86imkuxKaqJG8eBrZkEj67FIgM0RDAwIs2WD5fKCpgC8tOjr2CFb7rwBT0u+zoIWPax8SJ9c+rjDP1R1hhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(8676002)(26005)(33656002)(9686003)(52116002)(6916009)(66946007)(6666004)(83380400001)(16526019)(5660300002)(956004)(4326008)(55016002)(186003)(54906003)(86362001)(478600001)(66476007)(44832011)(66556008)(6496006)(8936002)(2906002)(1076003)(316002)(33716001)(7416002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Vcwtt1Ls5NVIfFFDN3GmQ7R7dtE5+QuVLcpVDdyrhn6MxIaqv2qhPIyUWQE+?=
 =?us-ascii?Q?ylPKA28sJlWo1hYNc94EiJiC2B+sszoGJcc+kAo/lTwTDyn3nc+g5prXs1gK?=
 =?us-ascii?Q?v52+A6Wj4VyaVxI1L/kbktNabVYjGwtep59nFls2d7lnT1ECcje/XebX2EJe?=
 =?us-ascii?Q?ZhpE9G/agQ7RUrY2HKcevcwfu6JwuK/GhyiYBTPpB32TqSDgY+q6WYmYnbVN?=
 =?us-ascii?Q?d+nK+o9Tg4cq4f3kaYhbPC6kBaTPVWKz2oTGdkg7ZvC0vsCwlM+kRGDOBT8v?=
 =?us-ascii?Q?WM9ZdEEgRXhz8Ozx7X341bdPMYCecg5/tlD8iLPmg7uotZGi+1fTcAUPXh6w?=
 =?us-ascii?Q?ZwkNhc0ohcpaxFIXF3ah6YX8HZSdfOuqsIsRnV42oprBycRGewbWN0SwwsI6?=
 =?us-ascii?Q?vJOgZMDyHRTvCAUdc86nvI+xNjayAgiCm+cUsXdaFdHaAtoQESVVysI3Lubj?=
 =?us-ascii?Q?8KxjZew2CT9cbb4CG3UbETx0vYEQp4vh/Gtj/Q0jPr0WgwSv22kd5ynB9b1d?=
 =?us-ascii?Q?7uue16XvlccCOejuhgI1zUjh8+TvnDW/3UWjvMLmDPOwcIyh6ztdTtJVjEfW?=
 =?us-ascii?Q?2sYp5EvbUjP4l5RrCUNbaTOqfxFQFcp7d8kfLWZd7eeVtJlAb2l4Xhbgd42R?=
 =?us-ascii?Q?z19aiBG9iUY/Xo/ScVwp/GN4NUk2sIhBZK1milPTVLMdUlsEursFoE8dWhRF?=
 =?us-ascii?Q?+Fdos5tPZIC6hPxAovF+dXy0xX7t5VRR8gQbuk1KzzbB8hvJyx+oF9LxmRVc?=
 =?us-ascii?Q?zkKH6NrsWcyx4AhS/RDc+xBP1Qu3+5F7y2kjYHimJjOb3ZhEjeS7vtTWfrnk?=
 =?us-ascii?Q?SJtlmRBYVoGIFYSkDwnBc14UJv5ftjiI+LzFsjAb8h1scU4PR1R4xRffO99z?=
 =?us-ascii?Q?WxFTSQWP2F8sFSKC2FaE/ZXFHyIJIpacoYcrlzk3i2G0B5jR+Dh8Trw2sBC8?=
 =?us-ascii?Q?LYx6xBQCjDqJmw2ovgXulrnMrRX1V0322HtzZ+5qT6Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2020 23:17:21.5395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 41856ef5-6995-4bab-ceda-08d8a2e1e802
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckGP/DlcS9qiC0wU6ouPwa6m36FlAitns3aO49KocxiES4uAiaitK3Bra2Fyd2i5Gggg6pqim3p4GJ7s8Y6EMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430
Cc: Thomas.Lendacky@amd.com, Jon.Grimm@amd.com,
 Felicitas Hetzelt <file@sect.tu-berlin.de>,
 "david.kaplan@amd.com" <david.kaplan@amd.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Robert Buhren <robert@sect.tu-berlin.de>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 brijesh.singh@amd.com, "Morbitzer,
 Mathias" <mathias.morbitzer@aisec.fraunhofer.de>, "hch@lst.de" <hch@lst.de>
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

On Wed, Dec 16, 2020 at 10:07:31PM +0000, Radev, Martin wrote:
> Hello everybody,
> 
> I will try help clarify some things.
> 
> > On a DMA unmap SWIOTLB (when force is used) it trusts the driver from providing
> > the correct DMA address and length which SWIOTLB uses to match to its associated
> > original PA address.
> > The length is not checked so the attacker can modify that to say a huge number
> > and cause SWIOTLB bounce code to write or read data from non SWIOTLB PA into the
> > SWIOTLB PA pool.
> 
> This is true.
> As an example, I attached to the QEMU process, set a BP to `virtqueue_split_fill`
> and modified the length field from 0x40 to 0x10000, and filled the corresponding
> buffer in the swiotlb region with As (0x41).
> 
> Immediately after resuming execution, the kernel would crash:
> [  122.154142] general protection fault, probably for non-canonical address 0x4141414141414141: 0000 [#1] PREEMPT SMP NOPTI
> [  122.156088] CPU: 0 PID: 917 Comm: kworker/0:6 Kdump: loaded Tainted: G        W   E     5.6.12-sevault+ #28
> [  122.157855] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> [  122.159079] Workqueue: events_freezable_power_ disk_events_workfn
> [  122.160040] RIP: 0010:scsi_queue_rq+0x5af/0xa70 [scsi_mod]
> [  122.160916] Code: 01 89 83 9c 02 00 00 41 80 7f 08 00 74 07 83 8b 9c 02 00 00 08 48 8b 83 40 02 00 00 c7 83 3c 01 00 00 00 00 00 00 48 8d 78 08 <48>
>                      c7 00 00 00 00 00 48 c7 40 58 00 00 00 00 48 83 e7 f8 48 29 f8
> [  122.163821] RSP: 0018:ffffc900002efb08 EFLAGS: 00010202
> [  122.164637] RAX: 4141414141414141 RBX: ffff888035b89c00 RCX: ffff888035b89ed0
> [  122.165775] RDX: 0000000000000008 RSI: 0000000000000000 RDI: 4141414141414149
> [  122.166891] RBP: ffff888035946000 R08: ffff888035a79860 R09: 0000000000000000
> [  122.168016] R10: ffffea0001287280 R11: 0000000000000008 R12: ffff888035b89d18
> [  122.169159] R13: ffff888035945000 R14: ffff888035946000 R15: ffffc900002efba0
> [  122.170287] FS:  0000000000000000(0000) GS:ffff88807f800000(0000) knlGS:0000000000000000
> [  122.171564] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  122.172470] CR2: 0000560e654b77b8 CR3: 000000004dd38000 CR4: 00000000003406f0
> 

I believe the above example is without a SEV guest enabled/active, as SEV
guest debugging can only be done with SEV Debug patches applied.

> What and where gets overwritten entirely depends on what virtio driver is being
> targeted. All manage their memory for the descriptor buffers differently so the overwrite
> may require to be large.
> 
> In the context of VirtIO and SWIOTLB, there are also these three fields other than the length:
> dma_addr, flags, next
> 
> I had a look around a little bit, so my take is the following:
> 
> 1) There's already validation for dma_addr before doing the unmap with a call
>    to is_swiotlb_buffer (1). I think this check is sufficient.
> 
> 2) flags
>    Before doing the unmap, the virtio implementation would check the flag and based on it
>    would select a DMA direction (TO/FROM DEVICE). Still, it seems that this would not
>    trick the driver to copy data to the device since only a `sync for CPU` may be performed
>    in the unmap path.

That seems to be true. 

Thanks,
Ashish

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
