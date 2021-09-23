Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD2FC43217
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 12:22:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0959F61248
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 12:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0959F61248
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BE88340192;
	Thu, 23 Sep 2021 12:22:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8a05amGbQUhn; Thu, 23 Sep 2021 12:22:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4C946400C5;
	Thu, 23 Sep 2021 12:22:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0508DC000F;
	Thu, 23 Sep 2021 12:22:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C2E9C000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 12:22:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A6FD41626
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 12:22:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CM91EKHNiqwn for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 12:22:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::613])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A4DE04161E
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 12:22:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbI6dFkWVOzztyqdo7vus7sEhDf6clsylPtjgu+aYd1065Gt/Gpq+kQgEFJvqIob2g5DMo35dRzWl1riQwCgwL8uvno8/6N9rW9HgO7o90NUFh45N+tfO/ETaRTzsVR96opHiMQRmzUf8Shba5UUvTVy2OI6a/yjcZnac/WfLFAa4p2vn27lEdYaT3PZ9zEUZMwHw5uo2qvjSYkoXdd4ClKAv7dTidiCkLg6vkkokmcV9jWRAQfOX4ks2yF+AZfLjUTlLsJwkCnqCSBAfT2zw4AD2YDKNgQIERY6BjTYVoaeeI7X8M1e9XOajsb9Difv8x3O22DxyDxDsQyEscV2cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=z/H2NYiPQXwuPFSxyE1ppiVA5Bs6esw8zJB3fU0EvoE=;
 b=ETLfVInPdq1/NzN7lZ7VTVU1K3ucfNp8mtV1+8t+aPaylRDIEfIuZCjCmbTdQ+pcAK2JDmzkMA6dSbwyWxUt+Wp0b1MP543FQxjsXPprJkkrELuHT9P2gWcTUsl9BXBGQtI0pPMcCRNVBpOERa57pJQvYC1rFXnVj2iyB36jwD4k2a38OWckpzGDX410TLnTKu8yE/RxOgJi4RBIx9B2mGi0p+AGPe62mV4ZArTs8SE/C9fDXCjRWIV8zGWl6dLUNsfaJU/EARb71NKiZ16NukPq81xtbJhwVqAvMklCnE/GDrfonX+M6KTtjaWI45PGLhIE13lFMrhcAYk8nJFZ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/H2NYiPQXwuPFSxyE1ppiVA5Bs6esw8zJB3fU0EvoE=;
 b=Zh0EEa9fHhmPddG2bunAoITgpFXVk3ntbcmvdgKfI/ribdgOgm8CitzLrfAlk3lpbyN2yICxJHJzLoz8zLTLtdS27w37Hng+sswms7dKguBt3I3E92mOwNi4Cdh4fe//+tgZvE/4QeYj8y9Nxxw5FCzvNwzZUPjrFjrJ9qi7ZxjlFXm2+Z/WE3rs2liXsfHpsNLJS3zGgSs7MsAseYEqwteOhZO2O8O5xrYZ18ehRrGh50ia0luwOzA2I/rD2lZWwOt0Gw9zMBzp10P8nEbOqEkVFPY4Fap5PaHm9OG7S0oORJuBXpz3z0DSZ+Zwxx/i+yj9hf7rQYXsxCUoJDIsKw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5175.namprd12.prod.outlook.com (2603:10b6:208:318::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Thu, 23 Sep
 2021 12:22:21 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 12:22:21 +0000
Date: Thu, 23 Sep 2021 09:22:20 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC 10/20] iommu/iommufd: Add IOMMU_DEVICE_GET_INFO
Message-ID: <20210923122220.GL964074@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-11-yi.l.liu@intel.com>
 <20210922152407.1bfa6ff7.alex.williamson@redhat.com>
 <20210922234954.GB964074@nvidia.com>
 <BN9PR11MB543333AD3C81312115686AAA8CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YUxTvCt1mYDntO8z@myrica> <20210923112716.GE964074@nvidia.com>
 <BN9PR11MB5433BCFCF3B0CB657E9BFE898CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5433BCFCF3B0CB657E9BFE898CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR20CA0008.namprd20.prod.outlook.com
 (2603:10b6:208:e8::21) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 MN2PR20CA0008.namprd20.prod.outlook.com (2603:10b6:208:e8::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 12:22:21 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mTNk4-004P16-DV; Thu, 23 Sep 2021 09:22:20 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d519358-5f63-40c9-bc2d-08d97e8ccafb
X-MS-TrafficTypeDiagnostic: BL1PR12MB5175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB51750F4E0F92213ABD5146E8C2A39@BL1PR12MB5175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PlMRxdqtD5Xohyj3vih7IdYD8IU16Ruzw7Kky6XkOuDR+Qfc1LrS35rYFz4xRhsa3D9nVSKTI3BzIMOxrD5C2txlCFZBf5GnbmquQ8Tis1rA6Z0nbFmiphfGm7NH2kfbhCy91PMpVrCvzuj/VyWKHjH0PCe/0IsqO0W1AXo+2yQGIhBbarpxh9Ghq4fh1+YAFcwrRVKJKQzrHS2orkcCy/ThzWhCeDLvN9Vyr5mDeLsybVZeWjff6P+6YJ7+QYiPLmxAarLj5/AtBiATg6mo+eRPsC53aeXXTh2/BDTggyne5f9ZMU6vdMDeBvtazGkqxwUUUHp79SQAnYTnQVCmXzgnfpvU8Ba3O2fy8fYYKD8uXtJlGpE+bNcFpHnQtc01Kqz1BpUOOwVFyx98kmdIl7j+8BuZyWT3v6yO/uENSrT0fPDPJrx2fiLqofG8DElJvZRJgfNwSbqPjLOImZjXyr1xkjy81ynkzCeERotI/ZlHvTCg4qeJXtCITPCHxTPToVAMbpxmjlGIgUCaYy/kU8O1tP8UO+ThxLV/JIaLPDrAKlNRUrcZrkh/SCBfZzBIveu5TGn/s3/Ha8G4nqoQ0wWfbDSHmJT8pWOObbphb9icKny/rIMHboy2jUTJ1c6xsDPzcISznVmova8Jwbxslt+9Th0o7pab3lcCFe4yIEJTdjE1viEkoeNhXVx5mgoI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6916009)(5660300002)(9746002)(9786002)(316002)(66946007)(66476007)(4326008)(66556008)(8676002)(107886003)(2906002)(54906003)(8936002)(7416002)(426003)(38100700002)(86362001)(508600001)(36756003)(2616005)(186003)(1076003)(33656002)(83380400001)(26005)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YpBHkV/516CuvBSxxB8EcTLDhLzvKpf2gI7aYPeApv6GjLHTZOZZ9iPqBWpV?=
 =?us-ascii?Q?HBQDYIfXcjk04h0lu3CON82f/LZcuyQPENFdyZZNM/8l29ZFnKH9RqkIAZTN?=
 =?us-ascii?Q?0oeqzYJ0qwmYMllp9YbJHs3LjTrBF+dzv14ibgmPh132g3PVsSpqWCXZWDUQ?=
 =?us-ascii?Q?sOPJYtwZ6rfc/6HaqEPtCyIRiyjinfpklQREVNB1fgH/QOqnepYpoTYjogEF?=
 =?us-ascii?Q?TaTLlXgX6CpbPJ/FI2nJWiceIp/QPQl1sq9XnyPX/2hywaGpKlsUtemh/hZ8?=
 =?us-ascii?Q?SiC2kKWOvmWvKE5T9CEYtyHQ+//Ujm6rIE/jHVM49HpV7g0krByoP/knGjKA?=
 =?us-ascii?Q?txo5snf8NWuqsFsKGi9jlzdHGnkA2/SWqu04IQcSgLsOniVaSPd23ESHgHP8?=
 =?us-ascii?Q?9dZ3ytzZk/6TPWLUqYDfRuwi6BoBhx1xLX6MhLEdFc4pX4NYjz9ayZMIvh98?=
 =?us-ascii?Q?/Clm6wzOaOZs/oNRcnvrOuLP3Fr/dq9TN2xz2jVE9xDHDXv2HYTGyBrimchj?=
 =?us-ascii?Q?HYIyMePD4B8oHaqtuBG98oeG52Lg0dxIhYh1+kRpSNL4F6nfHmmsbnCclA2g?=
 =?us-ascii?Q?iB4x1fJWWCnuI1fRfHSz/6zE5JHnWFPvVywIPI6qh9kEc5b+zZhk7zPWEAkv?=
 =?us-ascii?Q?2PdE+zXjMyYxmiBHXosnYIRqtOKoz8f+65PHieZxWIMNDW9p8Eh0TuLQtWsA?=
 =?us-ascii?Q?TV/HPDUV5ehIpWPlk/3cNnxI2t9g0Itt9vB1tM0wo2wb9VJHwMv+Ncz4YEx9?=
 =?us-ascii?Q?RuX3Yl63PCI36WydFfkj8/fzNtNg9WERH9rmMxEEd1griNbTPvXxL49vMzQI?=
 =?us-ascii?Q?YaGFOvF/UUxz5bazkaf8xHbPWDdN/aV1y7fODZ0gon9wihNlYcugin2gCroQ?=
 =?us-ascii?Q?fCvTEi6ztrBqRXhNzsPjfs6q3iq2DEjDKnu2aehRpUrvCP4Nuao//E0sfitq?=
 =?us-ascii?Q?kI68OIg5h/opp19d8Gif4ZlFQH0kpzd35XI58MI3Esls0PP7pfyaGOUKEB6E?=
 =?us-ascii?Q?VfpK2ZHt4Kz2FquDQ0dvH5iPJy5UKgFyQucZNs2iwsZpDcLQMTBoiCC7et8+?=
 =?us-ascii?Q?Ny8ozDowUkELUb7jn8RlBHeZRgcHAXwyguoA9kYN6yfe2HDBTpBmXeHaT7WM?=
 =?us-ascii?Q?9yjJqunfLguFP2H9UMwyUDue0yoHRnLVuITpgPJyPeiYo/uYEe6sKkcu8/0X?=
 =?us-ascii?Q?zz78BuqgI8PMOgCHhW3xsMNi14rE/3vEu1NGbULtY/geQDsHydNd/QPrEGqn?=
 =?us-ascii?Q?QKXK1DNiihVbnvpqIzRIJNNrWUtu7j1RzFcGslnbQVMMhv9MkAyM2PcRylx0?=
 =?us-ascii?Q?O8Jr88jB84XXfZumdxxs38zF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d519358-5f63-40c9-bc2d-08d97e8ccafb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 12:22:21.7424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EV4YMlrPCmTfkOypTurFnYqAoUYBQRPvpw3d/Vj8Wl00/1erctgsX0+SYqt/SgTe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5175
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
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

On Thu, Sep 23, 2021 at 12:05:29PM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, September 23, 2021 7:27 PM
> > 
> > On Thu, Sep 23, 2021 at 11:15:24AM +0100, Jean-Philippe Brucker wrote:
> > 
> > > So we can only tell userspace "No_snoop is not supported" (provided we
> > > even want to allow them to enable No_snoop). Users in control of stage-1
> > > tables can create non-cacheable mappings through MAIR attributes.
> > 
> > My point is that ARM is using IOMMU_CACHE to control the overall
> > cachability of the DMA
> > 
> > ie not specifying IOMMU_CACHE requires using the arch specific DMA
> > cache flushers.
> > 
> > Intel never uses arch specifc DMA cache flushers, and instead is
> > abusing IOMMU_CACHE to mean IOMMU_BLOCK_NO_SNOOP on DMA that
> > is always
> > cachable.
> 
> it uses IOMMU_CACHE to force all DMAs to snoop, including those which
> has non_snoop flag and wouldn't snoop cache if iommu is disabled. Nothing
> is blocked.

I see it differently, on Intel the only way to bypass the cache with
DMA is to specify the no-snoop bit in the TLP. The IOMMU PTE flag we
are talking about tells the IOMMU to ignore the no snoop bit.

Again, Intel arch in the kernel does not support the DMA cache flush
arch API and *DOES NOT* support incoherent DMA at all.

ARM *does* implement the DMA cache flush arch API and is using
IOMMU_CACHE to control if the caller will, or will not call the cache
flushes.

This is fundamentally different from what Intel is using it for.

> but why do you call it abuse? IOMMU_CACHE was first introduced for
> Intel platform:

IMHO ARM changed the meaning when Robin linked IOMMU_CACHE to
dma_is_coherent stuff. At that point it became linked to 'do I need to
call arch cache flushers or not'.

> > These are different things and need different bits. Since the ARM path
> > has a lot more code supporting it, I'd suggest Intel should change
> > their code to use IOMMU_BLOCK_NO_SNOOP and abandon IOMMU_CACHE.
> 
> I didn't fully get this point. The end result is same, i.e. making the DMA
> cache-coherent when IOMMU_CACHE is set. Or if you help define the
> behavior of IOMMU_CACHE, what will you define now?

It is clearly specifying how the kernel API works:

 !IOMMU_CACHE
   must call arch cache flushers
 IOMMU_CACHE -
   do not call arch cache flushers
 IOMMU_CACHE|IOMMU_BLOCK_NO_SNOOP - 
   dot not arch cache flushers, and ignore the no snoop bit.

On Intel it should refuse to create a !IOMMU_CACHE since the HW can't
do that. All IOMMU formats can support IOMMU_CACHE. Only the special
no-snoop IOPTE format can support the final one, and it is only useful
for iommufd/vfio users that are interacting with VMs and wbvind.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
