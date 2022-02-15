Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E77DC433F5
	for <iommu@archiver.kernel.org>; Tue, 15 Feb 2022 14:38:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8E3B54038B;
	Tue, 15 Feb 2022 14:38:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id po8nr3o-bVSp; Tue, 15 Feb 2022 14:38:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E221D4016A;
	Tue, 15 Feb 2022 14:38:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE523C001A;
	Tue, 15 Feb 2022 14:38:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 180F2C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 14:37:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DCC6E40364
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 14:37:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 21rIDzo6vMTL for <iommu@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 14:37:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 562EE4016A
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 14:37:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GI6dk2TVv8y0hx6d7+9QwRT9KRd3T5TqfctF5GPDkHmBlwYJ2Aen87hglVsK6xYCOxZ6OGutzSZMiEhoYQn4MV8U+BTbDOG9eeN9B5Cusoqw4wNKnDOluC6bIhN1NVADNqJkprcKHJ6p+rNJxGL/NU9NRlQkduNhCTsi2hBONqWytMgDuXBeNsPMDsK6VMnXz0alVKDzksJd3vp2VtccDmoLDGY3o9YOtkq04L9xaqglB4tx/ar3o0hBO+vvhH+W+BxtjkoDzRFOr2KdQYUzeI7AGX6NfVYxiDIytNpHkXwVgGAwLQ2dKwc85IDM5c4jZUyAfWByGFC/GW86yOW46A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvVcpiqWZFh56sm6SmZk4b62/PGF+HDhidgH2/YVziw=;
 b=BM9qnzc1Pi0drjG+GEB1ZSChjWmHvOC0up6Y+1/4TsVFeIoviXXE6JZWeXpvYtM2M10T5+96JdhXRnV0qc2yqh6GvnD5GdJ/3vgv7W8zs66TqZrVdBDsMi93Wy4Oq3xu3ifaiATUOW3Sp3MbT8AIZZOpad7h4zxAAQVawkyIcK1a2gzsJc4YF4apmTaW5p31lcgzBNE9SSmb4gbhxNXg2sOOJpvHxaYh6r41Ku5MhRoHnwdZdYY1xjRPqnJHLLeR8z1SgtjLRarruIP6TWy1rN8j86479xpB/DDfcX1TDXdH3Dx8vz+mDZgCc8nQ+cOGQx3BacjcbrG79/mF3aceog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvVcpiqWZFh56sm6SmZk4b62/PGF+HDhidgH2/YVziw=;
 b=nO/4XIgdVU2Bi7htpacZC6cep1jw+x6sHYcy/aHnJz6IhPKFhkJSxwbOu/sgdIdOBvqQJ4x5DHxSXCHadfSrGB7BzxgFWel4DGMxnK6vfTexpDg/F4tIJEYEOgF2w+83sAOTBeKqWBN8IsLLzOK1sYoQmreHEwhra+m2LaQcL39NIKlnqUrsIehltdfYKP7V+d/gCe3HZGnfn0L12xejxaULuHcySG9V/6o69Cwz0R187/asrHtiEefWuBKWoYL8reZKP2iXphxbI1fZG7l25QItAm1Bh28FggBSzgi6jtw/YxUE13L5Oa3Koe61EQQ1ovoM6TA1d461ZAcujuNCjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 14:37:55 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:37:55 +0000
Date: Tue, 15 Feb 2022 10:37:53 -0400
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v1 5/8] iommu/amd: Use iommu_attach/detach_device()
Message-ID: <20220215143753.GP4160@nvidia.com>
References: <20220106022053.2406748-1-baolu.lu@linux.intel.com>
 <20220106022053.2406748-6-baolu.lu@linux.intel.com>
 <20220106143345.GC2328285@nvidia.com> <Ygo8iek2CwtPp2hj@8bytes.org>
 <20220214131544.GX4160@nvidia.com> <Ygpb6CxmTdUHiN50@8bytes.org>
 <20220214140236.GC929467@nvidia.com> <YgplyyjofwlM+1tc@8bytes.org>
 <20220214150059.GE4160@nvidia.com> <YgtuJQhY8SNlv9/6@8bytes.org>
Content-Disposition: inline
In-Reply-To: <YgtuJQhY8SNlv9/6@8bytes.org>
X-ClientProxiedBy: BLAPR03CA0147.namprd03.prod.outlook.com
 (2603:10b6:208:32e::32) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07fe0ad0-8db8-41a3-9646-08d9f090c09e
X-MS-TrafficTypeDiagnostic: CH2PR12MB4088:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4088C3C03ED84939439C3D36C2349@CH2PR12MB4088.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PVKPawFv5Chg8o+xp220ENA3geoRDPBHgcV4CJ19ZdxuSxviIhjFZYZtCIHTNRJeli+AKNrRQR08c/XxtnNjUHEwJF8mKfbH1as7rqN8tDvZs/b7fhZSxtSEGoGre/9T4L44MQPX+gHcY1O6uWo9+R4XWWtyMmbvCvaUgZ7l11ppXOqeShHzqECheKBPs7XmWFtmVIElg3MGbojcrPUjFKHhaEeYtdgchFTTFlTENpcAdgN3jbl/k5YbEe326kwPcDe/1vnHFLKmxdsbzkJl2qSQLUsMVKIRUs+W3ydw0Xd0+85meOkYnZraDGfS/ukHnRzs+YWyaqKLfgJPbHhLC2mugj5cPX4UUSXKrEBUvENtU0Ro6BApm+aYODKYfQhUAIuyFMGWvIrQ9VAJPkyJq1DxQB6YSrH/9mK5raltOyAF6tBMYEomOJyR17Kz1JjTvx/CdDIPkz+rJc+IK6Md8zXJBSuUl8rNwD2zn9zHYBNfvaHrSpPXxbFx6Vc/xoBCZhS60bS2iRy8/pKL7LPrrQwi4mtJscgMovhB4FzW9cmbEM41MY6QXgw8jPuWfxBU1tykaDj/tUEwofjXC0q5ZMmcKbo3SNR3oq19V8GkkPl07erXcWb8NdE+8Nw2UT5fAH763LMCDnbTr4YJnD88iQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(38100700002)(36756003)(83380400001)(8936002)(186003)(7416002)(33656002)(5660300002)(2906002)(66946007)(508600001)(2616005)(86362001)(6486002)(316002)(6506007)(8676002)(1076003)(66556008)(6512007)(26005)(54906003)(66476007)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PoyHepkDkk3owaktEwqy2hjcHPDQAJMzJyvG4RpiQcCv5LWq8OZnIs4BeOfx?=
 =?us-ascii?Q?tNYDu0cxodcXPHBS73eJ/VWO39OW2OsS15k9T7ZOeQ9Fi1bamfSuzEuQIxRu?=
 =?us-ascii?Q?XZdc38H831zkum91to9/UI/KnJcPLZD7W80V9pzK2xZVSTjisGQHK5GtOQTi?=
 =?us-ascii?Q?6i9Bdzchx+76niGMginzA+eXwg7ON/Jdl9MZHg2pFgHnt2m2+cJzErOiTFG2?=
 =?us-ascii?Q?xRExr7AI+S2VuoVi6uyZAyeYlqqbZA1c5RwlE3t9g4L1mhBXfBdQz8gqcrZ/?=
 =?us-ascii?Q?X732ddA+3hAZbKlAeloQnMavSTomRlxxpcN9GmpkcOHf+lD1VkP5zn9fcWBW?=
 =?us-ascii?Q?Z9EJ0h1yRRSqL7jKx4KFhk2HEcTArKglkgin9P25YssKE6rgbEidWSudrgT7?=
 =?us-ascii?Q?lgjma3tRBrr26Y9fX6WtxutNKnfKOiJ+gUFH1j+h5VPcTV1DzXlf82gAnIIx?=
 =?us-ascii?Q?N/VKMGO13cNhdHPnJFAyCAddOZSQbCHJA+3ziSAXG/uFnt6UGccMJVnWcbg3?=
 =?us-ascii?Q?cQRpCvNOO8cNfBBdBSJrtx+MkIaAIKdsscipMJF+Gu98nXblGKHAOUT03KSn?=
 =?us-ascii?Q?20VEp2oxB1cd0NhKKnBjgrl8lwON6D5l+kfMAWK67bUKNQWn8OiAFxRgS+QO?=
 =?us-ascii?Q?hjxapsQxIy1D+3g7MYARtVZh5SPE16zgwiTDVrIffJlRnsLkPvVZLRJ2C9CQ?=
 =?us-ascii?Q?x5HVw/sDGEXAG7QI16biNLV+Snk+cw4pKDks+dN28xULmrvo+iZeY9LeeLFW?=
 =?us-ascii?Q?oe83u8jOtE2cMCGB1tXIkkefT/PU/DhCm2qGaUdKuJbkzQF+tMvBri4jt2k7?=
 =?us-ascii?Q?38irCH407wetd9NQCNvKXEK5TtvJn66VEnxpWuB42A2mHN4XMnhQXdY0l6Vm?=
 =?us-ascii?Q?lwmyzNQ9LugCMaxZxNvAKAEqFfynBBBJa/A0crAYsDS8qGLBn+OHvKzU1wtn?=
 =?us-ascii?Q?dlj9Adiv0kCHm1SRLegMKoKtb5kZXau2Q+uOs4m+0HD6IanJ3ECLwIcL4Z+2?=
 =?us-ascii?Q?2eMWIqEvixP/cJOz5zZCWLTsFsXZeDtUlmWMs6rM5kWdrzi96A07SO9Isq0d?=
 =?us-ascii?Q?HosdnlXiupSFNUzV0RHRaYzLgI+z+c8ldluvrDiXaxcjRBLnzkniLF4Icawa?=
 =?us-ascii?Q?xCHBh6A8mNsznLmqvxw+F9eEcfZWDsJ6/FNTQFXEm3ErYK2xcM3FhLwK99JW?=
 =?us-ascii?Q?txY7w1s4cKPf3Dkx8zEq63FZBtY1rfZfakGGkkDktXMlgjkDwmkkXccEiYyl?=
 =?us-ascii?Q?FxpCxEUSWVdwzaE/O52PXHVSdmTViOFJ5SlE3835GdCa7yTdbawhk5jkQkdV?=
 =?us-ascii?Q?P3c4ozO/RpSS/596KChphbzW2Dnp96RZbjD5g7/Ae+q4tV9fJKSD69tedxKh?=
 =?us-ascii?Q?be/ZdX7KP+jMl+i/FRtlPUd4swps18Fn1FzIlIci+EfRnH60KqQY85hcQ4LW?=
 =?us-ascii?Q?pNKVhV2aGroz1YqfDgBlL40zPaqIRAAHIdS4imX7jmczSQJIz8R5r1AkGgMt?=
 =?us-ascii?Q?9veg1v+S/DlO+ZHvFg/dplqm56eLtjq2azSL6xKxyPGiSHeeDrn4LkWnBI0K?=
 =?us-ascii?Q?nyw3jl4zaP4qhKAMyfU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07fe0ad0-8db8-41a3-9646-08d9f090c09e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 14:37:54.9710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOfld8/rBgUHzeg/KIxqv9biqBzTFS1szVfJ93pTt/GgzQpwWNejOdodFrfJ7vrE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

On Tue, Feb 15, 2022 at 10:11:01AM +0100, Joerg Roedel wrote:

> > But, then, the requirement is that nobody is using the dma API when we
> > make this change?
> 
> That is the tricky part. DMA-API keeps working after the change is made,
> because the new domain is also direct mapped. The new domain just has
> the ability to assign host page-tables to device PASIDs, so that DMA
> requests with a PASID TLP will be remapped.

From, what you've described this is also a good use case for the
replace_group idea..

Using Lu's series we'd:
 - Require the group to be in DMA-API mode. We know this is the case
   because of how we got here from probe()
 - Use the 'replace group's domain' API to switch the group from one
   identity translation domain to another identity translation domain
 - Rely on the DMA-API refcount to block VFIO/etc instead of checking
   for the default domain
 - Restore the default domain when all the DMA-API mode drivers unprobe

That is, if Robin's idea to just get the right domain in the first
place doesn't work.

Anyhow, given all this I think this patch is not OK as is.

Thanks,
Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
