Return-Path: <SRS0=+9ml=PN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F25C433EF
	for <iommu@archiver.kernel.org>; Mon, 25 Oct 2021 16:51:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ABA160F92
	for <iommu@archiver.kernel.org>; Mon, 25 Oct 2021 16:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4ABA160F92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 02696403A8;
	Mon, 25 Oct 2021 16:51:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zoRxn2_Em7JN; Mon, 25 Oct 2021 16:51:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8F9274011B;
	Mon, 25 Oct 2021 16:51:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 611E5C0019;
	Mon, 25 Oct 2021 16:51:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60051C000E
 for <iommu@lists.linux-foundation.org>; Mon, 25 Oct 2021 16:51:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3F288403F9
 for <iommu@lists.linux-foundation.org>; Mon, 25 Oct 2021 16:51:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HaIkjHO87d5l for <iommu@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 16:51:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::618])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1983B403D6
 for <iommu@lists.linux-foundation.org>; Mon, 25 Oct 2021 16:51:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGzCd1tZ2/B45ADuJ1AYPxTSy2UYDjNcRTPgY9G0Ecc9jCVdRHsBqCGiF6+vT2gBVeol0ZkOuTul1UFaeA+4SuR2ThBfDTO+j54juUZcYhxdbqBzms9zUclagrRhCMXix2d5DXMLkm3VMZBOGOjutyVOZ4uoqUbduZkmA9rTA5sm21r2fwMvItLwaB3rUcep7fE222Uxu4Mq0HjXg259RWdwr3QLTzSd3cG6qmnvTyMcFrPx+Pxfcy/yL0A8HMJs+N4RNvH8JXBIPYbmnyxSemHsa6PKZzI5O13QEXfAwlj47i6p9Tgt4XEigynAsAahhDgMgJEj6pbA+L5j0K0b/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GS5IDDRzGOK4hqmU8v2jmfQC6iZliX5ExT4pZQx88Q=;
 b=bIaifYSxt770KmLCq5rFYRUD2jDRt34BdJCDCt+g1FNyTPEpnJzEjNBCDeP/44G+tw/JgF7Hl5BbADlgx7OTEEL+Fb36bGQ6z709Zpq5gE7disPwVRYhsEKB3MmVSxLflBnYnfX/bdPktwLW4t4LC4e5IyazuqyOWRAfzpNDOfzWm98SpC4t18o7ifxp3UctYNVtTsuSxaN+W0DmGsoqtSEr9twpVi+Yxz+T/uFzAyXboLDPUq1/hcAVoyJmCFARghIPzfpZtZsP9zvMiMIvXdoKGmncv3GuMAy6LgnOV7JPIn+wjXo3yPkFNmCfR77SOcgtLUkpzSsoPP48pF4eJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GS5IDDRzGOK4hqmU8v2jmfQC6iZliX5ExT4pZQx88Q=;
 b=HTUvOqpp9wupoFiliftx3jqvUqKclq7AtJE01DcNzz91sWhFbDV5NoCZru2Wxh5nOE/8hERq06lbPRjdlUkeMoCUyQfEyZlP+8+ohFrYpbqDxWMJjtXyciNFN06XaU2KLxwzQv6Vb/NypwQZG8xv+UO6DFlSnrYaNw/9smhFdMTtb1+KU00pbG/BnYRfyZ5qUxlNsVGcWtFdGGf3g2iIuQ9NOwmPVW3SlFXx8ubVzz0HxAD1CCntXDEsSUwHWFFqldl4GaCsQSdQ4Dsm93unlCgaqhaQinlRaLRAn5kqqmuDg8DtXVYq46owEibIuyWO/MOigjNX4EXjZYeMFYBC2w==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5380.namprd12.prod.outlook.com (2603:10b6:208:314::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 16:51:22 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 16:51:22 +0000
Date: Mon, 25 Oct 2021 13:51:19 -0300
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [RFC 10/20] iommu/iommufd: Add IOMMU_DEVICE_GET_INFO
Message-ID: <20211025165119.GA2744544@nvidia.com>
References: <20210923114219.GG964074@nvidia.com>
 <BN9PR11MB5433519229319BA951CA97638CAA9@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210930222355.GH964074@nvidia.com>
 <BN9PR11MB5433530032DC8400B71FCB788CB89@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20211014154259.GT2744544@nvidia.com>
 <BN9PR11MB543327BB6D58AEF91AD2C9D18CB99@BN9PR11MB5433.namprd11.prod.outlook.com>
 <BL1PR11MB5429973588E4FBCEC8F519A88CBF9@BL1PR11MB5429.namprd11.prod.outlook.com>
 <YXF/+jxRtjnlXU7w@myrica> <20211021232223.GM2744544@nvidia.com>
 <YXJs7+nQJ++EKIyT@myrica>
Content-Disposition: inline
In-Reply-To: <YXJs7+nQJ++EKIyT@myrica>
X-ClientProxiedBy: BYAPR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::24) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by
 BYAPR07CA0011.namprd07.prod.outlook.com (2603:10b6:a02:bc::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 16:51:21 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mf3Bv-001ejZ-H5; Mon, 25 Oct 2021 13:51:19 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78019065-b8b4-45ea-346b-08d997d7ac8b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5380:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5380D8A4069703E16F7DEB3AC2839@BL1PR12MB5380.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gTIognCs2Xc1qAsa5WrGR9sqzoudcUuX+Sw9CT9YD4z6tDUvU9aC/dXevkw94tV5Z3pFwEdCQUV+mrTgx11HGKvnlUfrN1COuLATCFgG8iafKxy8uFwyxLcv1R91ZHE/VH2j6vTMOvKuC4MgDn9nRnkVXfEqP7xe3UqzvgJ7NRyaZmhAy6S3KzGRbthjVDe8uojYy6WDNGGFSLJr2F5/By+xoqs13bCCUi4FPtrdb2Zpv8WEtzBqjzScDIDrto5ROWu0qm7KtQRPH9L76oW/essDNA4DhFFE7wQSZ/ZhfuYbpc+rp/ssXhbVdEFBNLUog2Whyz2EQWkKGlie7AJxJ3HSFOVe7+IH6oH/SVhfhvYduuh9gfXfb1QOD9nN1Y79yZRSOFgQGsrWRh88DxYHDAPNw1AIzRxZzFDzsn6PcFbe+PNNc+H7YqSSwnd00VoCS6rZmToj6lys9XdrvdgBdWX5vClvGlsjEhGAE8z0yRSGxXksoUfV4hGYW8160IrNeHkwUz4p69hiqIkBX7x2qsanXhitXAgLzZAKhw5zKNsrS+PpxOGNLaGqp8C1DExBpUNPKA2L+SSBosDQZ/IfOD70MLL16EW+1ARC5lHPSHjRIGFeQkRDWF85n/cQGWJ/y6UWx66Oqmf5OuWYo4qd/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(38100700002)(54906003)(1076003)(66556008)(66946007)(83380400001)(7416002)(86362001)(2616005)(426003)(8936002)(9786002)(5660300002)(316002)(186003)(508600001)(9746002)(4326008)(2906002)(107886003)(6916009)(26005)(8676002)(36756003)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2AWuWXX5+/nE17iKFxsFA/RXI7P5TDNV1xwyJomgIG1NLuXUQ5kb4R3ifjri?=
 =?us-ascii?Q?ST2v/nPtRwweCHFpTuzOK2n6Sc8lGBQ84brdgLBMIpylHks/B6uqE49Xcprf?=
 =?us-ascii?Q?ww07pewm5e7YElg0teTKxJ6j+/CtrS8yCCRnGv47JWo0bP1LJVvFS/HCv8P4?=
 =?us-ascii?Q?tiUsVZfws90+3SpkISj6/ZcnAmlq/63C421Xmd8nwiKUzCf3iCRiM9TzAThU?=
 =?us-ascii?Q?PKvm18keP2rMYsujnBOjxRTxiUblJc5NIf//h8BHuDfK2UT3MsTammZQ/Wte?=
 =?us-ascii?Q?oyKPQ5+ohGBIHOhnDsAYDfy+/FD4DrXicuwpwnXSGT3zMy3Qad2LwPeqL5j/?=
 =?us-ascii?Q?up3LR5df7/uMBos6K2qcZU6K/IohHiD7dfrZf6bBIzL2vVd1zqNpEp+6ToOD?=
 =?us-ascii?Q?28cS/3s64lJI+km5wXavkb30+4/rrUOAoI4fUxY2nZau0TqCsL6lt877m0L4?=
 =?us-ascii?Q?Oo46csK3FlnKBbC+ED5Olh5jdzK0bU8fcSsGcxPm+rLM4oQuHoDGu3+1lxP+?=
 =?us-ascii?Q?ZLuBaK6Tj46kl9pC9AJAkzi6n3O2P8eC4DSxjUVop1egKvpwm4m64LsSjfEU?=
 =?us-ascii?Q?RMr5BSXxwln9a7pm4ieYk83dnVSDJJQcdDa4hLAS356MGkljFxSDt4GGx6j7?=
 =?us-ascii?Q?U9MpK10UL/8qdY36PJSU3uNivqBERoaYo4LeCsPfbdlxhjgRQRlDezqLuNca?=
 =?us-ascii?Q?FBr25hqbdHs8jRr5qxPDZykX+06mWXBvOlFWSkJoysVNk3OFSZdM5EFf0/hk?=
 =?us-ascii?Q?rupQkfXv+h/D9ETnhgVwEeA7c/ixwZIRpxahRf44B2GaJ52j5lvJsLoUnssQ?=
 =?us-ascii?Q?VLAVwRlM2BSSAyKYWIYcKJopt9HiSQoNvJjzGohZAtaM5P9pXRvWYg2GqJfF?=
 =?us-ascii?Q?08smwzh5pVtwC1v+MCghV1+EwJam+v74nG7RINaMrP5atRGNUHXGUQ/LZHZ5?=
 =?us-ascii?Q?5qnUbgBjOsVg63hh0YKUO4J2LTJADw58q5tcmr50zEBe1Rf7XQ8NFd/SsZeN?=
 =?us-ascii?Q?489tCucgejuMehsBj9dK5hhgSM8qQgInHzzt5AO375Gu8Dl5aNEz8RUnw6wt?=
 =?us-ascii?Q?vunSMu1520rHR9J9mnNw7OXo+W4tAhRkpk9bn5obitD01lUSo9sx4/wJYRp+?=
 =?us-ascii?Q?qD490BwloorZzAzjyrMzDVJ/79nCPGWozmT9bg4adGBn6P58USWdHPXQzvJB?=
 =?us-ascii?Q?yWeUGSGrsWKCa/IEV0lFXGjxv5QCjF3Jy+HoNN4DkRL3ZzOQNZpqjehO0UCc?=
 =?us-ascii?Q?Fhys1ox7FmDRLo2x85hK7VAaCkoCST4b8fOymq9qyEf7i9qbR6m0YOnfAfzs?=
 =?us-ascii?Q?OX1C/sWF7yEMtjzy3KOVsopfPNj/G5hsPc/CRlNqys19knQldZ0mWCO8VVuC?=
 =?us-ascii?Q?lO9WC05z49ESBnKw2udQqtfGLx/b2CMQkZV5+rpfdZIjsYKeXFMn29p7KZVo?=
 =?us-ascii?Q?u4VTWVlbfCZoWAeYhFq1rdE615iV2exOfyjeY2mTYfQ8ygUmxTYVMX/Cu1Ey?=
 =?us-ascii?Q?PnRD5LVuDvZlSsykS1P+36NCkbBv+IiYvQWc6ZIyP0sbDFCv0AvT7fB0uJpj?=
 =?us-ascii?Q?RdQFZvxYgnhNoabfOMI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78019065-b8b4-45ea-346b-08d997d7ac8b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 16:51:22.1229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q8t9I6+gAvQsU9b9BnjibjC8+x0hWtILjJ0AF+QNWtUitfX8JnhmTfCkmS/vrsIW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5380
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

On Fri, Oct 22, 2021 at 08:49:03AM +0100, Jean-Philippe Brucker wrote:
> On Thu, Oct 21, 2021 at 08:22:23PM -0300, Jason Gunthorpe wrote:
> > On Thu, Oct 21, 2021 at 03:58:02PM +0100, Jean-Philippe Brucker wrote:
> > > On Thu, Oct 21, 2021 at 02:26:00AM +0000, Tian, Kevin wrote:
> > > > > I'll leave it to Jean to confirm. If only coherent DMA can be used in
> > > > > the guest on other platforms, suppose VFIO should not blindly set
> > > > > IOMMU_CACHE and in concept it should deny assigning a non-coherent
> > > > > device since no co-ordination with guest exists today.
> > > > 
> > > > Jean, what's your opinion?
> > > 
> > > Yes a sanity check to prevent assigning non-coherent devices would be
> > > good, though I'm not particularly worried about non-coherent devices. PCIe
> > > on Arm should be coherent (according to the Base System Architecture). So
> > > vfio-pci devices should be coherent, but vfio-platform and mdev are
> > > case-by-case (hopefully all coherent since it concerns newer platforms).
> > > 
> > > More worrying, I thought we disabled No-Snoop for VFIO but I was wrong,
> > > it's left enabled. On Arm I don't think userspace can perform the right
> > > cache maintenance operations to maintain coherency with a device that
> > > issues No-Snoop writes. Userspace can issue clean+invalidate but not
> > > invalidate alone, so there is no equivalent to
> > > arch_sync_dma_for_cpu().
> > 
> > So what happens in a VM? Does a VM know that arch_sync_dma_for_cpu()
> > is not available?
> 
> This would only affect userspace drivers, it's only host or guest
> userspace that cannot issue the maintenance operations. The VM can do
> arch_sync_dma_for_cpu()

This seems out of sync with what the KVM people asked for - any
operation a VM can do should be doable inside a normal process as
well?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
