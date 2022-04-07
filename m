Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A39C433F5
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 14:57:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E29A4840D5;
	Thu,  7 Apr 2022 14:57:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mLzo77v2pJ9O; Thu,  7 Apr 2022 14:57:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8DFBA840CE;
	Thu,  7 Apr 2022 14:57:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51850C001D;
	Thu,  7 Apr 2022 14:57:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 626F7C0012;
 Thu,  7 Apr 2022 14:57:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 510F1840CC;
 Thu,  7 Apr 2022 14:57:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 88uBw10BYZXx; Thu,  7 Apr 2022 14:57:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::62e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 66C4D840CB;
 Thu,  7 Apr 2022 14:57:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiwaAMHwkzLeFnA3IdcdOvICosjKDxpbAtVIMj35AtWIfitbxMBSbTdnbBY2GB2tgm25tOCwU3DNnv90hh1smTAe/6TkFfEYuMvw5kheFPpLu0CRtBSZjESrYZ/DK+6nDjATNazcvBmFFUBTGWXLrQmHbBiWjP8InqMZ2QhNLO69SbqRO78uWtgGj12BBV7VGthSTMdooLqstW/fkjkMF08pkHAsagiCA5ky51K/ZCemdaVlDP56omEItVU4uyjTToPAYBSabij+9d/zUIAgo0fDiIZAkODn7ZwN93LnNTes107EtavxVVA0+cAAN/yX76QUCvLtZ2g/JHsazIUtaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ga2amJm/SH26LoUz5ph3C4uXE29EybRYp66fXjxyBB4=;
 b=HMvZWW3yXKEPTR4DJtdZDq019xz90XtPkWyPb/kG291iO/p5BOUh8Fv/eTUCfjqTz+BKbYDTgcHBl4dES7ZoesnIldcYQz41qZBkr8VYZq9y7rH5jsIyhJwZv1khvMZ50nWrvoxDrm/PEkJ4HRM8tHAc13tkRuUiPG+6PStE8Xl9TlxTyAFwsS+RrFeBpXmTEQABw1pAB0AINqMqnAsuKcFGp+F0xpPhgi5hkB9qOfNz+GhNL8sVEruSytoK4QCtUkNGZeCFZnUdVUThuewSajluA8mrRP4B7fiX/ZZXIVF5vV50iHZUNGD+LTA6fJOuZsAJO4H9mbwRTp+Zl2p7Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ga2amJm/SH26LoUz5ph3C4uXE29EybRYp66fXjxyBB4=;
 b=hTyXsbVPSKwoakJHOFp/fKamOHMhB8WhskiMMpORtRWnv3EZtrqvzTuYrzwRiRCHyNuUsa7dAVC9czk5d6ZJowcxLcuUYzcFfvh7uO+4jVFrOPNomsb84J17Hw1nmYZAS/n9aLVIJk2MUILKZGCSlXlsVWJki5GCnuxs6RYyT4Y6z1PQXBTsHKo3H6BjJ9SEMqWs4KyEpz+mF3h46XMmVKuE3iXLQS1MSoXzPFUekQmAPX3Fy/VDpd12pUAsnQATHTUL8NC1NF8Xac3P6CBhV4lxvnIOL77MTCwgpeCXj2b1wOHS2K57I0xfilb19DlgLHzOmYErSo/h4Se6e5rfMA==
Received: from BN8PR12MB3297.namprd12.prod.outlook.com (2603:10b6:408:9f::17)
 by CY4PR12MB1158.namprd12.prod.outlook.com (2603:10b6:903:40::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 14:56:57 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN8PR12MB3297.namprd12.prod.outlook.com (2603:10b6:408:9f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 14:56:56 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%6]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 14:56:56 +0000
Date: Thu, 7 Apr 2022 11:56:54 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH 0/5] Make the iommu driver no-snoop block feature
 consistent
Message-ID: <20220407145654.GB3397825@nvidia.com>
References: <0-v1-ef02c60ddb76+12ca2-intel_no_snoop_jgg@nvidia.com>
 <BN9PR11MB527679A12CF8298840D12B488CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527679A12CF8298840D12B488CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT1PR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::23) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 418e84e1-e7ab-4233-065f-08da18a6dc1d
X-MS-TrafficTypeDiagnostic: BN8PR12MB3297:EE_|CY4PR12MB1158:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3297AF0F0DE44C1B70BC2F7FC2E69@BN8PR12MB3297.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 18zaoUzwWOgR/PHYMgnX532W+UEKVYRoMRMa3Z7rUqkdfYXPc0QiVSVS9gKA5GpZo4pKJ9O6WPK6/bGitxnypOvVLi/29h0RvIaT0h8LWEhbUj966+vIQ5xnw8g00zYR+yHl5zjxvapF4qdvmNbbRGe0vEjEqkvz1BTZxblhP8dpySlpf+ilVmiGjfkqU6tv/u/Von4WA53XNJnRmkE3G/k4jW2VmbWCexWcAk3FEg+lDWot5RvjvmhlLcSPtHT+KWUQNIoXkVhSdco4cWVxCWsTNdyX0QU7q4PYjfBaU3l++674ToPzLoQfqnj6ADAXSACT4dTsfArqd9NVLs9xRFnDB1g8dcYLgz/vq6Oes+h01JlmqXk7OvfpAXOibK7OyPuBDvKSvLxrN+3o3vV4KuQx4GsP7JAGBYsUcnEgEdnt5HwCqkA+i3a0X12/HR+IyXPcfBvgfib7HYBxROj8z74b2iF0G2HbnC93KmNxP7yJymk4y8orVv4DZQ3LXReRAQ79USyUQLvgPvx7+jD/q0LB1yuHu7xNHe47/tgwSHgek17p521GkOqMXMpywZISnI1tgbQcUlMGhjo6HEXEpAxxLmkGSBCKRCHI5cDyQafJ0wGrTzV7ADw+OHQq92qQiAXqXFBTZmXhktYNG9RP/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3297.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(7416002)(316002)(2616005)(508600001)(5660300002)(1076003)(6512007)(8936002)(6486002)(2906002)(38100700002)(86362001)(6916009)(6506007)(54906003)(33656002)(36756003)(4326008)(66946007)(8676002)(66476007)(83380400001)(66556008)(186003)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BLPU9tYnoq+Gk7W4z89te09J1SP0DqdpvleNukVs/SFyU7RsS7ae/V3L3e6A?=
 =?us-ascii?Q?SEMGtt0dSMqnXpeCuKNtOyMeWWSzHzQ7DY74cugAQxX9Qr+PujSiMKurgsSt?=
 =?us-ascii?Q?BB6rgahaKZX3amm3YFdENrAUlQpVpd2iUtZ/lRatH2iRmov8/pUKKjzSD6d+?=
 =?us-ascii?Q?vTmBy8FgbHCdtJ0P8RdkAZvpZrBKHXf8r/NFS1yDHYbQhLPuviCH+J5aaS3S?=
 =?us-ascii?Q?0+tgvxRTJm5wehMvgeYxmhmGaN1ajVGP+OrnE5Oujk/mq+V3ZrjWu8KC9Q07?=
 =?us-ascii?Q?RPA8TkPwjt3ofIS1W1rJCWsORET6xXn8CVcUHF5INMa6ocQnrp9ySFkzpuhd?=
 =?us-ascii?Q?0XbNlaJJOvA+vAbW26CDySJsROYVttnewQGKOOmZUInw7i4tXzAqnfYj+yby?=
 =?us-ascii?Q?3ybasvVsZEtaGklGxsiSZbxDiyyCdmWRrnnt/h69lqhE7X9hWKyOdRkpuiBp?=
 =?us-ascii?Q?dPaSr0o2kLX1q21rqbO/HkedSZ6ac/q+GdGTBXyjmyjEmc4L9KT8c6SeXAE9?=
 =?us-ascii?Q?acVip71NqtGzPDHKwW5Ll4HFoS/ib/jPVnc26tXIaP5Sw9k4yjJBhZLn24WA?=
 =?us-ascii?Q?agIlnCAdvqhB7w5SDLGinmHIVcHaVdfQ+PK6YE46YgfPhgzAfIz+v3cQzC5z?=
 =?us-ascii?Q?oEskcy/KJ1Y5qb+A6CHEFFBEz9wLB/hW0++bmoFKFd485RV7G56D+0ZvblEy?=
 =?us-ascii?Q?70JkNPQwov/IX0o7j8dXi5UFhHJFjCrXwJPHn9ilfn8/t3wKug5BjlF3cC2u?=
 =?us-ascii?Q?YnrtdaBzVFc4RvnpDZuOB27AF5jB1eTSbBf2Qvqh+FSBAHfeQbD3OekOpNVW?=
 =?us-ascii?Q?u5yNHaEedMVOOAEkG7nYORE9cmdG6H0IP1s9jF+qeGIgcKlmgcdwn168UgA4?=
 =?us-ascii?Q?nZXesf6I4wG4/al3unN9296AbYDKqh8pDP6MFgazrQEt99OtyqFnjxP3aD8m?=
 =?us-ascii?Q?hBTTCbM5MTt5B614vTeAQfKOCDojw5RdrEAEiZhIKPXxTxta8aQV+dmIvBic?=
 =?us-ascii?Q?R/uikZ2eSHmqkqLD8j/y020PkELYLBOpyAeluEMzp5o4Ih3gsuaUclmEUESC?=
 =?us-ascii?Q?uvg/8C4MyDszyNQpCjcRplxS5AW867TouPOJwc64unUX/EwaSeKT7hDiv40q?=
 =?us-ascii?Q?urusDx6dJyHF6ph8Gw8EcGdMDu5QZ3mLWKaGO90oiMptPgth0jHHrHL/ooCO?=
 =?us-ascii?Q?ZZSrmnG31fftYdjKTktRznVEGDcfTsmYLviXUZ+2Cv90ajwI+y5jJavu9Uyf?=
 =?us-ascii?Q?tJGg+VMOZxUMx1P34Sk2fdN3QKj9Lnxy7l8Or25mbtaBFrVoj5IvdrpiS9Ju?=
 =?us-ascii?Q?pxlMHANRYA2RKtSeFdVfpwhfP+scdbLvggK1BJxs0jM5lhZbDuW/svhPBUUt?=
 =?us-ascii?Q?z/EYBnTO0nAqiMV/05CRi2zTWzkUbt4PV+xVw/gLGlAqJWpUJ5CNa/RvvV9u?=
 =?us-ascii?Q?LE5dIBbzPh00/TVDoqmEoftLviGPWfCpevXVfcu8l1gOcvATRHjepaqBPDOI?=
 =?us-ascii?Q?lQkiy8FEll7WxGLYgo+jAJ32pt7os70pNi5ggHbksxFWrrMB37m588QGcjx2?=
 =?us-ascii?Q?JqKwiVJ7U90ch7tic+IVclqd/2Vm52TiKA8z+klSIKfJdHdNu3CEJyln982x?=
 =?us-ascii?Q?0byyqRx7/t747OOCi9tAbDO07M9cp1Q9jX6jkM+AD7+vn7VIR8Sb3MeBy47B?=
 =?us-ascii?Q?m1pp4HWR8+Ex2ngkC+dQCK8VTP4h2a776wA1iwK1d6eN78F7RKGrCCzh9+JU?=
 =?us-ascii?Q?haLZYC4jBw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 418e84e1-e7ab-4233-065f-08da18a6dc1d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 14:56:56.3967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yF9YfLPD0fzfmiFf6iQX7Ef4OPhVomyKOf2hZRrVZqHbg/iT3q6/2nsYVVUPxwmj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1158
Cc: Nelson Escobar <neescoba@cisco.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 David Woodhouse <dwmw2@infradead.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Cornelia Huck <cohuck@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Christian Benvenuti <benve@cisco.com>, Robin Murphy <robin.murphy@arm.com>
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

On Wed, Apr 06, 2022 at 06:52:04AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, April 6, 2022 12:16 AM
> > 
> > PCIe defines a 'no-snoop' bit in each the TLP which is usually implemented
> > by a platform as bypassing elements in the DMA coherent CPU cache
> > hierarchy. A driver can command a device to set this bit on some of its
> > transactions as a micro-optimization.
> > 
> > However, the driver is now responsible to synchronize the CPU cache with
> > the DMA that bypassed it. On x86 this is done through the wbinvd
> > instruction, and the i915 GPU driver is the only Linux DMA driver that
> > calls it.
> 
> More accurately x86 supports both unprivileged clflush instructions
> to invalidate one cacheline and a privileged wbinvd instruction to
> invalidate the entire cache. Replacing 'this is done' with 'this may
> be done' is clearer.
> 
> > 
> > The problem comes that KVM on x86 will normally disable the wbinvd
> > instruction in the guest and render it a NOP. As the driver running in the
> > guest is not aware the wbinvd doesn't work it may still cause the device
> > to set the no-snoop bit and the platform will bypass the CPU cache.
> > Without a working wbinvd there is no way to re-synchronize the CPU cache
> > and the driver in the VM has data corruption.
> > 
> > Thus, we see a general direction on x86 that the IOMMU HW is able to block
> > the no-snoop bit in the TLP. This NOP's the optimization and allows KVM to
> > to NOP the wbinvd without causing any data corruption.
> > 
> > This control for Intel IOMMU was exposed by using IOMMU_CACHE and
> > IOMMU_CAP_CACHE_COHERENCY, however these two values now have
> > multiple
> > meanings and usages beyond blocking no-snoop and the whole thing has
> > become confused.
>
> Also point out your finding about AMD IOMMU?

Done, thanks

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
