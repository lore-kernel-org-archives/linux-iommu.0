Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03D7C433EF
	for <iommu@archiver.kernel.org>; Fri, 18 Mar 2022 13:48:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 78C3A40C11;
	Fri, 18 Mar 2022 13:48:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aK06KE1noPvT; Fri, 18 Mar 2022 13:48:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 045DD4013E;
	Fri, 18 Mar 2022 13:48:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFF85C0033;
	Fri, 18 Mar 2022 13:48:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E54DC0012
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 13:48:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7AF116070A
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 13:48:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kczR_6e-ciqk for <iommu@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 13:48:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::624])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4562260706
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 13:48:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ivt9HxYhDj6SjBGbrgWUuu5HMqME7Jt2rf079WVqGC040YxUd3Ktpmkq2QvDJcYdaoph5dZVD499hXqTt7nvu1/iQ1TEfviLZMylg8IjPM9XGecE5HAF1Z0oDFfuqre8ACUto+m+MdQsyE5koXpRXQFPIPolqscE7qcagtjuIbu0JDYwJMQB3fPZgdtIUAc7/TfsM/Mjrqpb68qzPnHzQ/qSvqK+zb4g3C3XaTQuSpdi4nR+ocbyfYhrJfshujzDRCh8LbV6ROkp/LYeMCHx+jUpIIgVqvB5oukM+XV278oCsWBQTlgMBHN5fQTgLQu0jb/LLWt+B3rxRBAAgWsz0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTD7bbgHy6yug/JW7rJs5GcfDTGb3eof6YuKLCSiIT0=;
 b=U7wkn1/hNhi8cOk82suLjt46yrTjKy/lWw7Xkc62dcxwlMmegqaK+kPlysGADlg6F4Gcl7Jkol6TwGO1DQQOIa8iKZGgoDAUoiXw6JoTdHiW1Rnee3+LQLxiq3n4pSJtlWxWnRJVOlmE/mPhMfrQc27GRbfOUn1+4GxAoQet1RCL48R7IIlC/+TQiq1JSfhxNm7JVJYrMXmBgg91Me6BE/JZ99E0LJ6HA4Ya4oHTDOscDO26sK8hzt/GRGCdMEB1RTipQuew7loMIs9HoSHizvOCokJzaDUl/nh8doFmaGOsgNohFKcVNYJ4NQWTABnEkKyQ9a7D0k0ynyp6zIcXYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTD7bbgHy6yug/JW7rJs5GcfDTGb3eof6YuKLCSiIT0=;
 b=nVA/qM2AomKs0bERh7j+kLtR1UKGn27pYwx0IgK4/hO6nkimtgU4F9HPeEKH6nzaP4gOOMDKlx8+9U0km4DFkc8ulF96Urb0AIDGlmaWsHwZUpCDAqXuKAXNCbp2Hod4uOMS9CJoSUpzuFcTcV8r7XAUbiRc2UfOaJ5da6OHm+F681vCpy6UNPSe65dLHPV17ygGZIGi7dRlztPZctCS5UGS/jZmxdkcFUYQ2wEuiHxb/xmGNGLQ0aZRqCtoxA8l73MLUYae4ATPaOGIaypKkjB3I3HA6nx4sJlrEvhchBlEEQcQNcBTK17LJzLfAnLlOL/A/CHb5AkaFZ0NckX3Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR12MB1783.namprd12.prod.outlook.com (2603:10b6:903:121::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Fri, 18 Mar
 2022 13:48:30 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 13:48:30 +0000
Date: Fri, 18 Mar 2022 10:48:28 -0300
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 2/8] iommu: Add attach/detach_dev_pasid domain ops
Message-ID: <20220318134828.GL11336@nvidia.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-3-jacob.jun.pan@linux.intel.com>
 <51f6a64a-194b-0aca-bd2b-64737bd2140e@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <51f6a64a-194b-0aca-bd2b-64737bd2140e@linux.intel.com>
X-ClientProxiedBy: MN2PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:208:c0::43) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 310b9e9b-61b3-4fd6-0511-08da08e5fc69
X-MS-TrafficTypeDiagnostic: CY4PR12MB1783:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB17839957838DD5C9A4A0C7C8C2139@CY4PR12MB1783.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T/OumOgISYl4O0vIDZo3l3PoX4M3KQl3VS1RypPQdReuy5P6UgOFj2PYLnXoC4pcubgg/LqH6cMa0+4I7pk5iGxek3TzFXmi6v/zmbJom7YmPpyvV6QkLxzX9+BM+u3Z6ThtQVzpklox03THQAQXJuha1pNFul9P2YU0RXkvxLzsPCLePZVuIgxYUbwie+JXkbvVYRyVHA1Un3jqCxzeaSIbUXclmmN+IJi11SPWlg/Ku8ddIAkHZ18BwM97rzfJ5klJ5ayOvmgJyqTHteQxrBuMskR00wOb39jLHK4OyUw9M9mly/w3/WlIbiGXLxO33JhNwGYQ9Z2e9jUzqGFcDXaA1B37l8OO+GvQwkAFuFkl9r1y/dNwxNhfyfW7TkgBVNSW1Yjg4dUnv66Mi3WjoiIoFisgQRTQkxfIA3UEH3S2OtDrSUkUpIagHWbsHGoHKAp0WIxTv9ioiE9r23gk7J1rzY6DFlLbuUafRJob+zU9t2XbAqnoq18aOLOQr7S4kONLYp5vVyNN3FsceZGl4e6zq6bD7DQoHwOaKR3FH5YKEuevyMiFfkqrz7RlLKis3UnXPaRPXLDdpLYw2ML/qhGcqd80jliV1W6zF+i1tOpAl7wX8PfWxTGjEDb3IL6L7YhXg47TtCJBY8wIsM5E/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(316002)(54906003)(2616005)(1076003)(186003)(26005)(2906002)(38100700002)(4326008)(6506007)(66476007)(66556008)(53546011)(6916009)(66946007)(5660300002)(8676002)(7416002)(86362001)(83380400001)(508600001)(33656002)(8936002)(36756003)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zigp0v9sEoX99MgWKdwOy58+bMaOrLKKubXpjJjL1/9J3tkTAhP6l4doBzQR?=
 =?us-ascii?Q?GXAzBwbLNRpZARd4P/dj1KOXUylnz6k+Y2ATKpzEcvd90K/evmRYYh7KV7XF?=
 =?us-ascii?Q?RkZIAdlU72Zb0KBdngZMeVqzcBSk/6KNADjxAtwm8fQtUwCZzqHuF7EJ9PxT?=
 =?us-ascii?Q?tGNgonM6eyiO9YF3boF3jcyUb1Irr1i0DT8NjaWlAF0EugKJfV2C6ogEPvDu?=
 =?us-ascii?Q?CElfZvxS0fv+/BrUs27jjIYdebFOK0DqYKSPSJO/te6bLKN5xe1jNb6wq9OC?=
 =?us-ascii?Q?4AR5o/VjM2tGv12Xsy5+4KQJRAq7vJh0Ty49FPxyGCRVZlQch1+bnfTPdEl/?=
 =?us-ascii?Q?67PbzFkB4K/YDJYAEjMUWwtUG/7q62nwTt50z5vFx94xinjo/hIJ2sTUdKIA?=
 =?us-ascii?Q?m+vvp4uR2cn7m9mryPuXGRgct6P4khSnc3ZQBfn9CHJmmN82NxYwL1KJP5AC?=
 =?us-ascii?Q?bekW3dH5gShX/p9KS4DOBa9g4QWTGbmsNmbk9TAtPatEScAXOMSrTQ6c5amb?=
 =?us-ascii?Q?9iKPK485QrRGuYRWMYtWXnM0zt3zW8umcTPSqswN+DbLcJ6ol47q0OQUkhZf?=
 =?us-ascii?Q?RV0MyYD2roRPC+JGTw8G5CvryswEo0oxfXK+Jg6T/j9gjomxNP3AVubnUEpw?=
 =?us-ascii?Q?UK0FKBkJ+60mZk6jpomEsSZ+OA/DouOpuM6m/rCs/fnMNfg1d5XRqI20kJCq?=
 =?us-ascii?Q?URhgNufGE0NdJEByWVWZE8hm9AFRo0vEXuIIHGuKE+Dt73DhVTgDRfQv/g/h?=
 =?us-ascii?Q?afbd9DH1Cpwh2/QbaJGFCSIs7ujYUWmSb8qRQQQFc31KR9RT4r5iRdz5fSQF?=
 =?us-ascii?Q?QRiGI/nya90RVKm0gRybYh1eVGd7ZVguiPvdGGIbGtujuxvdhqBi/tX6LEAt?=
 =?us-ascii?Q?vDL9vJB/PvqzK5uK+0ICXAHqdmZ3/eZ7TF4Ln2XiIaGSclI+zxGMzpCiJas7?=
 =?us-ascii?Q?BzvgIcn4Rn+SiXvv+w6UiJvDHyeIuTo0LkT+g5air87wglrUq/mbBme0lF1n?=
 =?us-ascii?Q?KQl2Q45kGpMKZ2pCr6uI5PTVQ5f0P4czXITvH+ZuOiHnCoHuXFb5UKhYnnJy?=
 =?us-ascii?Q?UDEdOKylJ5yy4iMM4/To1swMagDm02lh1Du0fVAxcZzOfoNKHb5guR7WcEv2?=
 =?us-ascii?Q?Kk2Th23XTsNQtevlbOo23lzvoF7WvgVQNvChUgj5HFvoqHpsYCo/Pufy73Ep?=
 =?us-ascii?Q?SF1Bv/1D7bNbwNCsKQ4yCB5bhEZ8tYoUV74nv31thOe12RU/z3HIXdhLzrfN?=
 =?us-ascii?Q?wi+6exLvGsEhWSH/ylMKzMT0qLrBDOmp13O9npu9qKeAYUdQQz+9p+wTAfXD?=
 =?us-ascii?Q?Ql2laBCJcUMYPqQ3i6ElAj8IiavzHs2oMFOEIoUNxm3E+J4dqHrsiIOxC8KP?=
 =?us-ascii?Q?D9JFLt4mgW4a8LtmX+WZtVrKVf7UfoUg6eu/rmlTIbJTMohIWfefUOn48Enp?=
 =?us-ascii?Q?Gi4Rp3/8Q62y5UA+huAD9/sSXufMJ3lg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310b9e9b-61b3-4fd6-0511-08da08e5fc69
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 13:48:30.2401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPqZdBnplDFHjOw8mRRClAkoNwXVpO2k67vOSD1JsvQnwlvwPvhMg/mFfWclmeIY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1783
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, Tony Luck <tony.luck@intel.com>,
 Jacob Pan <jacob.jun.pan@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

On Fri, Mar 18, 2022 at 07:52:33PM +0800, Lu Baolu wrote:
> On 2022/3/15 13:07, Jacob Pan wrote:
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > 
> > An IOMMU domain represents an address space which can be attached by
> > devices that perform DMA within a domain. However, for platforms with
> > PASID capability the domain attachment needs be handled at device+PASID
> > level. There can be multiple PASIDs within a device and multiple devices
> > attached to a given domain.
> > This patch introduces a new IOMMU op which support device, PASID, and
> > IOMMU domain attachment. The immediate use case is for PASID capable
> > devices to perform DMA under DMA APIs.
> > 
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >   include/linux/iommu.h | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 369f05c2a4e2..fde5b933dbe3 100644
> > +++ b/include/linux/iommu.h
> > @@ -227,6 +227,8 @@ struct iommu_iotlb_gather {
> >    * @aux_get_pasid: get the pasid given an aux-domain
> >    * @sva_bind: Bind process address space to device
> >    * @sva_unbind: Unbind process address space from device
> > + * @attach_dev_pasid: attach an iommu domain to a pasid of device
> > + * @detach_dev_pasid: detach an iommu domain from a pasid of device
> >    * @sva_get_pasid: Get PASID associated to a SVA handle
> >    * @page_response: handle page request response
> >    * @cache_invalidate: invalidate translation caches
> > @@ -296,6 +298,10 @@ struct iommu_ops {
> >   	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm,
> >   				      void *drvdata);
> >   	void (*sva_unbind)(struct iommu_sva *handle);
> > +	int (*attach_dev_pasid)(struct iommu_domain *domain,
> > +				struct device *dev, ioasid_t id);
> > +	void (*detach_dev_pasid)(struct iommu_domain *domain,
> > +				 struct device *dev, ioasid_t id);
> 
> As we have introduced iommu_domain_ops, these callbacks should be part
> of the domain ops.

+1

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
