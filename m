Return-Path: <SRS0=nHvM=OY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCC5C433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Oct 2021 18:21:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB106138B
	for <iommu@archiver.kernel.org>; Mon,  4 Oct 2021 18:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BFB106138B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9305E405FE;
	Mon,  4 Oct 2021 18:21:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f5vRdzdfJYso; Mon,  4 Oct 2021 18:21:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CEAE6405FA;
	Mon,  4 Oct 2021 18:21:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BFA3C000F;
	Mon,  4 Oct 2021 18:21:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D697C000D
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 18:21:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8B42A405FC
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 18:21:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QwNdoX9dQEHq for <iommu@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 18:21:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2055.outbound.protection.outlook.com [40.107.95.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 50BF7405FA
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 18:21:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsV/l/r6m1jVvkuILTszfUV4bFd2Cq3zLzbSPkwXOcRLoZRoQzPzX9whYZEIrJHWG62jp0HgR5PwMJpRvaniWcwg7MIUAe+PFZfomza4uKtmakuP/kYRKLFz9FlorEnJ/0NMv693z0D4M1ZQ5hhPLKWkrgnOqa6aMsXDjA02zQfOLQzlvRsfo/4zlZZ200F6Y8I5Je8gw4BnNe1B+1KmfPgBdcLvrSOffOkc+z35xvc2990OsiTO2MQr4cDsSOWbG7BTIi5LL/rFS1d3tic09OrGfp3N9+iXv3Gx7mg49aPHiFcy3tXf6hgeN0Q9E7FPfnNHbCFOfMBV49SyhJiJOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFS3rEME5CBuNnH5EIMOLij37qNMlyRfrug03ISptBE=;
 b=HvXCJ+agZLMy/RyLkz8SLU9hSo0eZU+zpiVpegm5YsT+gbX/3kz4//hdpQCt229cp3jzDV+iuVqL8EIj2RMfqMTXpsyR1C++/tjB7CoMyTanPFkuJTKly0Dxjbnw4HiMZeHg1PSFLMN296SBWbWiDQbnThMDyct17IIshw6d99kXtWiQaVol6RQXgeD/XrR0XS6ZnIzGlXk1mziqpQv1QR9MFadBbPPYEQg7+i97blLJUJ6WtWooCaOBzyGbnWPzLf+PcDuScixNiibZUmqkYPRlFhRhuyLvGyHkyOzlukNX4W3Aze3DvNh3ly8Vq8SymBYUpGZnpl08pI4BnyuRnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFS3rEME5CBuNnH5EIMOLij37qNMlyRfrug03ISptBE=;
 b=AXKxfTaQrfOlwhdlV7zd2dEWj++EpsL+PgQnXL7bjspwoNwV9F6MYl1PIMh33+NEHPUe350LW+0VXzEjhCvz6j0cVUHn13UeQ4P4vt4b8oLp143Dglt/wosTCTF+2AbieFKG/srriHWChLp6GWsulIzcF7VgGHObiO1iiTRqA7KOYecWLjNj9213b3DZLd+B4EmFPiMbCCj0CgcE/0xsTUMvY6XVKQVNDPSQmIuHmruNsC8MzkhyEzr4qIJFybXt4TspVXQUZadh3RaDJZWgRVcJxzjbIkGC7Xp6W0q5IpkcMJGAiQ9NW/Nc691nUSnri4iFyVWnAdYlYz88LYI6iQ==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=nvidia.com; 
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5064.namprd12.prod.outlook.com (2603:10b6:208:30a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Mon, 4 Oct
 2021 18:21:43 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 18:21:43 +0000
Date: Mon, 4 Oct 2021 15:21:42 -0300
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [RFC 0/7] Support in-kernel DMA with PASID and SVA
Message-ID: <20211004182142.GM964074@nvidia.com>
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <CAGsJ_4z=2y2nVStXP-aAPnQrJJbMmv78mjaMwNc9P9Ec+gCtGw@mail.gmail.com>
 <20211001123623.GM964074@nvidia.com>
 <CAGsJ_4wfkrJp-eFKiXsLdiZCb3eS_zqZtJvXQTBafoTWY2yWKQ@mail.gmail.com>
 <20211004094003.527222e5@jacob-builder>
Content-Disposition: inline
In-Reply-To: <20211004094003.527222e5@jacob-builder>
X-ClientProxiedBy: BL0PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:208:2d::39) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 BL0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:208:2d::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.17 via Frontend Transport; Mon, 4 Oct 2021 18:21:43 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mXSas-00AZBI-IE; Mon, 04 Oct 2021 15:21:42 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f47e43e-5c0c-4f89-c38e-08d98763d179
X-MS-TrafficTypeDiagnostic: BL1PR12MB5064:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5064E6D3A23C96E85E31FD6CC2AE9@BL1PR12MB5064.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4nZy6YRyuSdeBFu74QtVNfOvR/Uonle7SJIydv9aj37n1PsU6KKuU+I14VBoq733efoBOoZ5P+uMk54IQkvUTmbU7HU4QLF8WboM91d7HXzaOVXPWTpCpbMHXa29A3dYrpdyGM/+L4ORSdlXRk7NJqkxkJ43IOSCIvRs2P/JbzrqwCbM5qAXAyUdJJoskWBGWuazjkI/zR3fZMVPQ4+dSs0nRFNf7l6LbV8acgU8wDXHpu7OMyXoSwSUo+EI+OkxJXW32WujVrue8/SXOCsUcjgEYx2jDG4wvMCqG2iheGQKpKUbKsWAo0ffdMm3+9AiPlpzUMJxPxbjJw30t33YyK2QkxvlFXGkmGfOxvg6FBl0tromu7zP/5iYyQZEGj6dcFslVoHNLg7++rI6LL4m6rKe95nk/CriAor33p+ORGf+X3BW3ORDLDjW3H4yvWQfzeLjCzY39sPrDrvFlsbdxY3reitZfKTERoxaw7vthB12jJwGP04/V5hzzdOsMgVdKymz5TVj6IAUX1nAiIC4YaGOSArvYZRElx52QUcpKbnQR5bGvv0zIPZ+uDxuJkq2RhGlszebwDXYIVLzRwHjvMEB4KXbpvwrPP8yaFRsSVSvgUmy65qqFeFDhff4FyLEAHVwbvwfRhZuEEV3jjv7uJetqt+FbZ8YQy8A5N8LccboSj8DU5g8ubsvFN6AQH56aLvjXX4QqZ1mjAmdvBLS+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(9746002)(6916009)(8676002)(54906003)(9786002)(1076003)(36756003)(86362001)(4326008)(26005)(38100700002)(7416002)(83380400001)(66946007)(2616005)(5660300002)(426003)(66556008)(8936002)(33656002)(316002)(66476007)(508600001)(186003)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g0x4PdhNbxK466WSy6lEzpWGsD2enYR2XW9lGQ8ar8MOhYKDLYZWX/KpMpg6?=
 =?us-ascii?Q?YhP5Zcd/QYtMpDga9y6urR6RDd0FkCw5RirGpdJb5L1wAvkFdq2bbraNl9YJ?=
 =?us-ascii?Q?ojLR0ecig4whs5DEcSCqMINxk6JSagGDScWkzQOYav4la3FysMwPxvxXnxBe?=
 =?us-ascii?Q?ZDMQaV6CMEhAvZozVy36GsO5wROQmRpKBbm72kMJzhxt+Ge0sinChgqulmh0?=
 =?us-ascii?Q?r/bd11wAFiXNbZ6yn7Vgt5mixcj1ulDbenwXZeYcR4+7O+UlPc1ZalCWKXa4?=
 =?us-ascii?Q?PrB0Ag4snYCc9/SPxgPHe+cIdk3oXnvhxdQvZ1XoGHkpyywa4eHHVsKfAzVx?=
 =?us-ascii?Q?tclTLDUYvHcs+bu0n9sA3t/KO0D6Ldqv8+AoduWRu8iTNSPfjrwzKJPlraK9?=
 =?us-ascii?Q?62KWcwWJh4ujniBsY5rjJrntBop5VcwDfuK51kZS65WKu3dJkHl47EWtC6wl?=
 =?us-ascii?Q?Q4z6v2UhUkC4x6hASq/hYGJMebu3DhHzXv+9QFg5Ivy/O+7jWc13zHBPJTQi?=
 =?us-ascii?Q?kgmtaL/AMtHHtZqSAe2105dIULzXyaJXQpmpf7EY7M4XXEfPphgA5g9ysz1G?=
 =?us-ascii?Q?tPNP4EVyNcJOuUMcNco+JBikgAmKPW9zPPii9Xt+NO3CSLjdglTDFY7VP7aM?=
 =?us-ascii?Q?L3nvBxfU0xQgLxhF7xvorjtOF+8bvhKhaOORnpE85RVudetFwd6gJCDOH2sJ?=
 =?us-ascii?Q?C9VYaXvZYWFy0x690efnNHBe69RXVkQaxpn5oKRWW1QuPuIGesawGz5fXTBI?=
 =?us-ascii?Q?NzX5VhqLejdkNJnoAkCI2985lW9qGKCsaBfvzf77KsDSliffcVgKTXL4VrBY?=
 =?us-ascii?Q?hIMF1Rpvwsrcdu7NPBK3TbN7oCuNBhTb3d1+Afv5VArzj/rlLiORYp0j+ddd?=
 =?us-ascii?Q?GQWDKzuC5jFib6/Cq1ERdL8Ng2oHtwfzVpLTVJ2cv+yIfOiAxaSLkZJJFnc8?=
 =?us-ascii?Q?SP5/imx41+DynrqncIBv9GPUuiOiu+FDTnImgFVBQhb9BF3rUi/P0xA0A+HO?=
 =?us-ascii?Q?XtAQvDeJs8FzurSC+DWCVdpfKNgqVm86XIPqSEf1yvR5OvbGxgX36M/XKNc1?=
 =?us-ascii?Q?u37JpXY4UdkLzeb4D5goXUdcF9Oy76vHF2sZUYuyMi8bz4ZIrHPOqkJ8vKo4?=
 =?us-ascii?Q?WqiuYKzfh5NcjpbgQ57MewERpfp/OkkvQax7Qrs0T9ps3OplY0Tc5Eql4KqO?=
 =?us-ascii?Q?O2WBCZXHSSf6SOa0u3KVNJemYIjjwkpHI20awsNENONVxw/dyVOJt4zIuGFW?=
 =?us-ascii?Q?YXkWfJgCC6F3GHjktx+PVZLrx/LsZhbCDyZxc2vt4bhRuCWy9a6NZ+bk1CUt?=
 =?us-ascii?Q?j6gpB9k4oKGhIIa7oTqlQtmN6gDhapfl9ddR7bZofP3G/Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f47e43e-5c0c-4f89-c38e-08d98763d179
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 18:21:43.7208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OF8LpIkgKVgrylBDvOP5PItQRBVePhmHkxgbQST5ysYOjYCpVbhnpWNxOTKzrANd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5064
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, Barry Song <21cnbao@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, mike.campin@intel.com
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

On Mon, Oct 04, 2021 at 09:40:03AM -0700, Jacob Pan wrote:
> Hi Barry,
> 
> On Sat, 2 Oct 2021 01:45:59 +1300, Barry Song <21cnbao@gmail.com> wrote:
> 
> > >  
> > > > I assume KVA mode can avoid this iotlb flush as the device is using
> > > > the page table of the kernel and sharing the whole kernel space. But
> > > > will users be glad to accept this mode?  
> > >
> > > You can avoid the lock be identity mapping the physical address space
> > > of the kernel and maping map/unmap a NOP.
> > >
> > > KVA is just a different way to achive this identity map with slightly
> > > different security properties than the normal way, but it doesn't
> > > reach to the same security level as proper map/unmap.
> > >
> > > I'm not sure anyone who cares about DMA security would see value in
> > > the slight difference between KVA and a normal identity map.  
> > 
> > yes. This is an important question. if users want a high security level,
> > kva might not their choice; if users don't want the security, they are
> > using iommu passthrough. So when will users choose KVA?
> Right, KVAs sit in the middle in terms of performance and security.
> Performance is better than IOVA due to IOTLB flush as you mentioned. Also
> not too far behind of pass-through.

The IOTLB flush is not on a DMA path but on a vmap path, so it is very
hard to compare the two things.. Maybe vmap can be made to do lazy
IOTLB flush or something and it could be closer

> Security-wise, KVA respects kernel mapping. So permissions are better
> enforced than pass-through and identity mapping.

Is this meaningful? Isn't the entire physical map still in the KVA and
isn't it entirely RW ?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
