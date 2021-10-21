Return-Path: <SRS0=0R9D=PJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C05CC433FE
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 23:22:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B018E60F6E
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 23:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B018E60F6E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5775740865;
	Thu, 21 Oct 2021 23:22:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xm_zFjQK4H5z; Thu, 21 Oct 2021 23:22:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 05F024062C;
	Thu, 21 Oct 2021 23:22:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C45A6C001C;
	Thu, 21 Oct 2021 23:22:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AD34C0011
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 23:22:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 01FA6400C9
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 23:22:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G5VchcMrjEE9 for <iommu@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 23:22:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B9675400C1
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 23:22:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VP/PL3Z65NZQ8rAOvDjUBehkp/FusTA/I4BdeNClDftdooP21vSqYIEz9mJIU7rFVoacwePUw+LKRmUG3Ltgc/DdSMhh0dkwxrjBzmMf4Q2In+wBMQKc6uuqgOEhsDsYhsdzB2ha9/POyRrVP1MazCYgoZNQw4+lsol7s5hC9M3BW9af+vIlpuUunKAdEpEv1danIQqPNVQJus6PH4FD3VDDaD1B3fB4Qp9alRUHLDu4ijTw5UT1ZwPsjA0OO2UUYh1OshM9FmOWF0HsEqTBVTkbPLtRR7MjSy4t35SGWaoXscBER6/+7gBXgAUQSZbg3UL/I+vsW7jdb5h+mUod3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtjxwK4z6yUHp7IrYPYJKoJWDJH0s1LqAnZhGGy7Rwc=;
 b=TN8Lr/LM/RXpuxb5CgPQ/AFb0AySfH6jdEpy1IYhBBrzfOttT4tOI+G/23QoNjAADKo/xZ4LaXcYkJOW1KwKOTajdko7oKS/KFTDPfC6ucTRNYnW5vWlcoMDRyssEtQjee5s+7HT/Rj3qi1WpmUSWv3G3jzne8OGYzE3pZSCJPFm0e/CQgXXhTUIQYmVXiV6h6VKLW7LRJoHyFtHrzK9rWWOc+ngi/NtstAoQ/CjFAVAWC7UVYrBhiLKs5+AeBa0xeMRGnD3/1/zeua55oJO07XgOr2ZIkgC/mYW/isiaE91w6YXvDRdtQvOsVvoOA49EtldX7Yvsn6CezqDwZLvDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtjxwK4z6yUHp7IrYPYJKoJWDJH0s1LqAnZhGGy7Rwc=;
 b=qHJDWgNxMtAwBlDp7kajE2rMPb3y8fE8O6fvv+AEWvesOBvl0rXaBUBQzaMlXddO5LQnzzRgt4hZjcF30FjJjqCCHYCENC82V6jhj17q17kQBXMyOep5HpBMW97H46CM65c+0z8apYmZaw0JXuKk4obkcUz6brAkMgWEZDFAvhuptILSPBYd/1uL5Z7+5cOHiMba1e0xszRsIP2jJ3gIPkxtumXu94ljmqPGn+I1VfX5fuiHLvQDvLVulsM51HWwoSDIHxxbZL/9gk+33ZAYZtlYQcxVzgr0YbaAspvDXvmkFdHKG4YMViGYKSsi7pC8/9U4/J5kLGjwMF3ay029TA==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5270.namprd12.prod.outlook.com (2603:10b6:208:31e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Thu, 21 Oct
 2021 23:22:24 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 23:22:24 +0000
Date: Thu, 21 Oct 2021 20:22:23 -0300
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [RFC 10/20] iommu/iommufd: Add IOMMU_DEVICE_GET_INFO
Message-ID: <20211021232223.GM2744544@nvidia.com>
References: <BN9PR11MB5433409DF766AAEF1BB2CF258CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <BN9PR11MB54333BDB1E58387FD9999DF18CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210923114219.GG964074@nvidia.com>
 <BN9PR11MB5433519229319BA951CA97638CAA9@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210930222355.GH964074@nvidia.com>
 <BN9PR11MB5433530032DC8400B71FCB788CB89@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20211014154259.GT2744544@nvidia.com>
 <BN9PR11MB543327BB6D58AEF91AD2C9D18CB99@BN9PR11MB5433.namprd11.prod.outlook.com>
 <BL1PR11MB5429973588E4FBCEC8F519A88CBF9@BL1PR11MB5429.namprd11.prod.outlook.com>
 <YXF/+jxRtjnlXU7w@myrica>
Content-Disposition: inline
In-Reply-To: <YXF/+jxRtjnlXU7w@myrica>
X-ClientProxiedBy: BL1P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::33) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 BL1P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 23:22:24 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mdhOB-000SXY-DN; Thu, 21 Oct 2021 20:22:23 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4130df2-3dfe-4c79-0008-08d994e9a3a8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5270:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5270ABA70ACD0E1C636D7929C2BF9@BL1PR12MB5270.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l9X6k11BCqsLC50Pg9q8e72tLQllRkfWU2HZZRk1CtZ6mhzewptffe+RUr+KPsLEd+YNU9rsQwUnoTrHbXFWNFNpYF90J6i95j4bHSkf7qlhcR5tsjQaZEcM5+RLL8EV/+9r2BG/O7fPvpJYROHFLXxp1aI2hWh9Pt3cjkgU71jYR0COg80WprR1JpWDgwqpO9ICrofGmD21h/BHKTwvi3iqox8z4P62b/stTKAS49Z/uj5k4XWorhC1XA/ODBZzSdtRuj59ozOAqVX5T1mohtIxBxtI2SFdTlguUTg/iokbiC5puqmFCuR0inhqInR4Yp4VKV2epIhB1VPvFpacFywpsD8ixIetGw7gEmsSeFcXjNnZ12WxOT6EUsnqSX6uDEBBWqBhPbP5IVupzkSsXt85LVfjApDxCoCLngpTAUC40FwNsvMQKtox6rCzyQrLZGe6/FpFJGPxtoHnvnh+Rjx2JkxSOA+SRq9sCuq7ZHpEPOgZxghFKz3zNUSR86bLK/y2eKw89AvtpusTRN6Euye0IaRrUqvz7HU/gkyMennP1iSHoAqFisVY6BDktsPHeGxCVLXi0RjzN8bvFRGwhHs6agqC3ydO+YQQQIK5+2CDTcbl9qcOlhmhzma2VLjaLx7q/92SGZ/DuNs42ErE4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(508600001)(54906003)(107886003)(86362001)(9786002)(66556008)(6916009)(66476007)(7416002)(83380400001)(66946007)(5660300002)(36756003)(38100700002)(4326008)(9746002)(26005)(2906002)(8936002)(1076003)(186003)(316002)(2616005)(426003)(33656002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9coxqaLZbZb5NuYeAI4Xrmv7sKPg/OW3E/gEphAfbFOYJiIWwXlFzfNRogVf?=
 =?us-ascii?Q?gSRjgmNY2FD9Qo28DhBGslgJuieOqi5sjdNCbrE99Y3yh8KZJ8wURqJRS7nO?=
 =?us-ascii?Q?xDbd3g24FBybUwpB5uv8reAc1nTRFVdfqqFL9sdnSdWXcpMDa+MooQE/qR4x?=
 =?us-ascii?Q?b6fUUeq+PWGWzHOr5BKvk5SfjSZZOv9Id6CEs1nfyMGPmtOvYRm9lPnw8OSu?=
 =?us-ascii?Q?TJcETbC/3qPQ+1R3blFRw4pmcjdnoa7KqpxkevxIwev1JSjUPo8bCedLE3gh?=
 =?us-ascii?Q?NicoZt1sqaFeS2Pw6JVdGhpvFmcKHA3vNrFg1kytEr9jSKVJFMoN5nVFs4bA?=
 =?us-ascii?Q?1iwAeEQiJR4NTt74z1k2ezpLDuuo4Yi6TX4sPQSgxYbvvJyEROfnPTbSDWQr?=
 =?us-ascii?Q?qmu3FldR+GkLYGl7L4xuSxaxzrPHdcTl60O6TkI1F76YXOxQMC3OKzxPiOQx?=
 =?us-ascii?Q?GzUCQWpTBMYnUUsLPKLPZXBZEgSrRnfqF6ApzymybBYno+fUziz8hz2qV6Ct?=
 =?us-ascii?Q?581Z29SDRb4b+TPuRCKsZ4MzYmrRjnANlwul3lMbzFrQokLfSe16EtxxNGHc?=
 =?us-ascii?Q?xzZuyWkV9gmiFYzruXrjxKix3RiXmr3YZ/PObpPFygalSqVFBQeeyrD4TcZ8?=
 =?us-ascii?Q?WbkSCe5zKlstrTccr/saz/syvpwqFafiXg/XklQAdC/INnV6icKMJBKVEI6d?=
 =?us-ascii?Q?wRDQOC6C66/KQXWzB2VnraAd9Vjm2XRDCQv2oPbqJoRNF0KF+005qh8Rxsb1?=
 =?us-ascii?Q?2OrEOAHQN3ERPFA1S94XDVL6RsQxcd8MC3kaTbPQysnhax6BAdqyzM4Zl9/H?=
 =?us-ascii?Q?I0cielrP55SydRNbxsLu3THDT+h43vUFUhA0uSLtGvpdF/0lC8niBep+cAId?=
 =?us-ascii?Q?7OSEn5PGhTttHgkXd0wL+H78b5JfpzWH1WUDiXYFUC18g32BksN8hcpFuU74?=
 =?us-ascii?Q?lD7iMNwXiG9+kPVpimRVlVHZQC5oUnJEYsnQzcxgCmet0+c3OdcPutgeXyNh?=
 =?us-ascii?Q?VoqqkGujEeuAU1yS9yWxJntIiwTRX/KJa1C6gfXSJ5nJmcd6JfDE//fed+91?=
 =?us-ascii?Q?cViaHhx/hhCQgofVsMLYD2AT9wwgOh7Hx38Vev7KQ7IYwy+D1sl7/NsKX9Kb?=
 =?us-ascii?Q?yqsA3XhS3a0ft3bgatjFUJwCtlvXe+/BOCFPuAmADGOZ8siNEKiZCsDKRhiE?=
 =?us-ascii?Q?y3IeQcy9kng/tORuNpapIjELe8smjFPgQFTsfhx67tVy/9o5UwJjhnS+//Ba?=
 =?us-ascii?Q?c8wuxButLNDYh/oet22J4cENxx4hVdZUFkK97BLuDMS0HHBaLtbhQXLOu2ad?=
 =?us-ascii?Q?jvhmkkgF0iHjDmohIUGncsQjIIP213ALdgVZC3K79Of/cDZ+EujNS0GJXF72?=
 =?us-ascii?Q?NAyekj2Z0h9ZHjt8BmO/n2mB0DA44s2Co7SAmlbnzoZLLOSgTP+0x0Rv9n8F?=
 =?us-ascii?Q?XeCpXOvz89A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4130df2-3dfe-4c79-0008-08d994e9a3a8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 23:22:24.7466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgg@nvidia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5270
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

On Thu, Oct 21, 2021 at 03:58:02PM +0100, Jean-Philippe Brucker wrote:
> On Thu, Oct 21, 2021 at 02:26:00AM +0000, Tian, Kevin wrote:
> > > I'll leave it to Jean to confirm. If only coherent DMA can be used in
> > > the guest on other platforms, suppose VFIO should not blindly set
> > > IOMMU_CACHE and in concept it should deny assigning a non-coherent
> > > device since no co-ordination with guest exists today.
> > 
> > Jean, what's your opinion?
> 
> Yes a sanity check to prevent assigning non-coherent devices would be
> good, though I'm not particularly worried about non-coherent devices. PCIe
> on Arm should be coherent (according to the Base System Architecture). So
> vfio-pci devices should be coherent, but vfio-platform and mdev are
> case-by-case (hopefully all coherent since it concerns newer platforms).
> 
> More worrying, I thought we disabled No-Snoop for VFIO but I was wrong,
> it's left enabled. On Arm I don't think userspace can perform the right
> cache maintenance operations to maintain coherency with a device that
> issues No-Snoop writes. Userspace can issue clean+invalidate but not
> invalidate alone, so there is no equivalent to
> arch_sync_dma_for_cpu().

So what happens in a VM? Does a VM know that arch_sync_dma_for_cpu()
is not available?

And how does this work with the nested IOMMU translation? I thought I
read in the SMMU spec that the io page table entries could control
cachability including in nesting cases?

> I think the worse that can happen is the device owner shooting itself in
> the foot by using No-Snoop, but would it hurt to disable it?

No, the worst is the same as Intel - a driver running in the guest VM
assumes it can use arch_sync_dma_for_cpu() and acts accordingly,
resulting in a broken VM.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
