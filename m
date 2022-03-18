Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F055EC433EF
	for <iommu@archiver.kernel.org>; Fri, 18 Mar 2022 13:50:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A02E140930;
	Fri, 18 Mar 2022 13:50:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PUOf9rqlUKXw; Fri, 18 Mar 2022 13:50:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 87368409A7;
	Fri, 18 Mar 2022 13:50:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B4CFC0033;
	Fri, 18 Mar 2022 13:50:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B00FC0012
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 13:50:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6559B40C19
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 13:50:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nMKdnqIUAxQS for <iommu@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 13:50:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1967C40510
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 13:50:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnWrkR+rQ1DrhvScoe7h3UB4+LLLHwSpW6oyr1yTuX2ACr3/Fx3mvy39ZG54SYSZWROhvLto4+mXUSAhkVMNwXN8JXE7pG82a6wNLWXqGbJyNUAy/3kiZZMAm30GX6/n0BVZ7RSappWAft8Ca4LDoh0z5N75nVyqMh9UvgIpjOKPJDfx7pAw6oGCJ33etlC+Kg4eDUMnYRH/7N6WyszYx3wthF6noueyy0v3x3WSbMUjvLukZmKE9dTAi9tFOSDe3InAHY0jzUEx3Lyg7ENBTG8s8tSBsZ7mx4fmg2R6jtjrBJis686Qg3bdUSF8xTKctHLvUKrTtP+y01yn0rBGCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9w/1SJOx0qRWQGhfqGCQee1pOI7uIk7nwKFcS6C8w5E=;
 b=L8FRFwlecunGTbdxT/qCpfw+hIZcyE0xze5rDQ/zx9IE/X3sK5J4gOPjdsd6O1QdFYYI+VYDGuBWE0M6rp0l5lmESWkgF8a8J6axXNbxuQJix1C8J6svEHcur2wuGjuoOZrKWgxjBd51zNkelGCs7pnLqXcwz00/NC0otNE7JKYD0XA5y3a66QVWJpNITf45EZOqVu7fFwsCIkDp4L2JNTMXl94CgfPDJ19/oohFCFPiiuOzSlGlSo4SaTwubKK0q1bCJWxeFv+ztGPcBdkKMl9qr1qOs0IZF30v0aU2JyYBRRO2blOHsJRmrvE29YiVIum9AkiRQkfsm6qzwe/PrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9w/1SJOx0qRWQGhfqGCQee1pOI7uIk7nwKFcS6C8w5E=;
 b=E8u1aSQ3z9zsl5FG6315D9IskkbkWkZGPjH2V3fq+DpsTeeZDyJfykgZeHLOZ78pd86lCE+ESucWkI7UIdBCNqniwU/vLWZwTK7rp1jOEoPWSWgmezFDg6ZnrM5WoqQZ7EajNbSYdcndWtv19qFjnQc5WiQFaLh+oy5uHk1wQlcs7DmZaQwJDEkChBXAkEEfHB6SmewQfnssAR13EfZX0JsHcjOI1ukP8ofDuDc8s/sfTj/Vn2kWtqGW4WHfyOoQH1YnPYtZThdlaQnMX1wO+TwLl9fFHt4IeLAqQ/IfTKJ84YkRGsZ8P0lytIOgDO3JTX6J/G2BDm2BZSAT1my2ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM4PR12MB5102.namprd12.prod.outlook.com (2603:10b6:5:391::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 13:50:04 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 13:50:04 +0000
Date: Fri, 18 Mar 2022 10:50:03 -0300
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 2/8] iommu: Add attach/detach_dev_pasid domain ops
Message-ID: <20220318135003.GM11336@nvidia.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-3-jacob.jun.pan@linux.intel.com>
 <YjB4AyrgsnbUrlLe@myrica>
 <BN9PR11MB5276D5B88C05B509C2C790A98C109@BN9PR11MB5276.namprd11.prod.outlook.com>
 <a10f3fcc-9e31-913d-853e-b6da5fcb36a0@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <a10f3fcc-9e31-913d-853e-b6da5fcb36a0@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0378.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::23) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 360a625f-e594-4ea9-0221-08da08e63446
X-MS-TrafficTypeDiagnostic: DM4PR12MB5102:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5102D673D2C2964BD902B65BC2139@DM4PR12MB5102.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /vC1wVRV3LDIvG/cuWtaaygLr7z4qYk5H9SlX9OhEgkP5/22OagVcr8wxSHFonTY/qOKRPmTK8eNIDq64CHr2fD84aoA9m8IYlc/Jc5VxifOiAs6E2hwfR7AxbaXdkJ2wAEaJlDm3zlkLJP8AHhOBu36ZEVQYF1AUodisiiJa0g7WABjFIr3H3MNZaaW0usoVLpey6/vSSGel1N/tviNeL6ZxQp2NgVDW41dkcrJtudQ68/X0evwhOUxwfmQRm68pRDuX4gXTZ2f1qPHKAHB4Iu7XPvw5xmPZt8TI1Uu/3NbpDizPtoTdss9AnjhWKOeyoidr7ol/QtbUp0LG88TCKI03W/bAK4I2sEV6ikZtNGCMQJBd6IdckpApgBJbfG6gf96SbP+AkEqX7VGEVgbda7WdEf8nL28Q0TzqdpYM3oXeTSqSM+hx00j5vbpE1xWriELXcCpiou9kH9g/JJ2/1jEDDRjz5Qy0++TIDZuhgfR7qty1ons2pCU0zBo8IApGww8GmUuyav5jdnqgqLeqcRrNAhg42fWEB4aKAZVo6Zdi/QOsqzXTrgSNchM92pa5HuA+VawKlagNkHpXpOJSxO4n1a3qN8C7lFHklIWoTiL/cdZK+s+QKtX2Ye3aURhfLi4BrFL4tTwduezENRDCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(8936002)(7416002)(5660300002)(83380400001)(4326008)(38100700002)(33656002)(508600001)(2616005)(6486002)(66946007)(186003)(26005)(1076003)(8676002)(66476007)(86362001)(53546011)(6506007)(2906002)(6512007)(54906003)(316002)(6916009)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u+B6yhfNPh8Kfk5woqgJcJE1p4sdDFKJQ1ZQCJXLZdkxcw3tMvkF5tfQrPuz?=
 =?us-ascii?Q?9Ykoa8jdRN6Kg6LNzqIaavuT21ocH9zwNLgUDM/5CdmgVT42r+QID4JERadf?=
 =?us-ascii?Q?U5J0WS21ipJiq8kgX4J2am4F4vzyWPFHYWm56HVfnGC3UpUc4iwd0Ptllt4V?=
 =?us-ascii?Q?WYyhDn5vBBlsksK3mqACXIJGQmqp9kIChtfJ9GOsLi4EFT5CnxVVZQOIM3g3?=
 =?us-ascii?Q?dMQmVYi1lDSWh2iO7S6YE03tWXQFmSRI5MBJyJB7rcAk3dJJwmD2G1SVBPqN?=
 =?us-ascii?Q?jgGt2FsNZU3l4oxEzdo4huGj7OJ6PuRG4D8Bfxlf60YvUs/SV6oJT1O+lzcx?=
 =?us-ascii?Q?agVN6ApszxVoDp4NCXel9pk6hCmQ2yHpMNBkkIgZxoRK8JkSp3aK81Lakg1r?=
 =?us-ascii?Q?qGvuYLB7lBl6b2YaCluqOcxKZw1ajDCQMlPWPA2NUx+CpKh8w+Eu9bhRU9HP?=
 =?us-ascii?Q?hz6R38OyneDe2sQL/Zv8+2D/k8pQufOr1+8KZa0KS9llBimT9liApHBiRFFK?=
 =?us-ascii?Q?TFiGSeCeJPIM/er0RhyfgpVrdb80cQjh30j4y6oqNgIhQN2iI/OXFllgriwM?=
 =?us-ascii?Q?sutzbzaYxGidqKFgBYh1S20irNfJ0owtrmslMIHVSAEczXPzf1PweVht6mO+?=
 =?us-ascii?Q?oK+N7e1Dony6Pv/HEkgo3jLYkUjkGl7T5ZX2zgrF9yXyVhH8rDoeMeZX3Q1v?=
 =?us-ascii?Q?C+Oh1tiWh8SP4sxcFfQmW0yKKiBXHwwTCRzHTD52md0O/uJNk27RVn9Qz+UZ?=
 =?us-ascii?Q?0Xo41FEjAtsaxy3uDpLdclPNr7w/EAri0h0TWbck9sOJ9CEDBvWCmRSJslAD?=
 =?us-ascii?Q?/8gbKlz9TwENaylzawEJUcCUOBlccNJKmtVZJLEmoGBBxjmcGnVolE7rBfLo?=
 =?us-ascii?Q?2vkdcXlWqlLYvWBYhJYAamEQ5vSCtRR1llRhA2KiSMoMLNprOz/g62SSDH1E?=
 =?us-ascii?Q?RkNoyJmWGxVE+IXg4O5nwB9OfbFgsofP4U4ZVmjTjCkgPfq0eBX6PfGleToP?=
 =?us-ascii?Q?5c03MnJDEcX3G+KcNz5jUWp1hSdD5EWSeZklfBhk4yosm42z8qPovSF0DnkN?=
 =?us-ascii?Q?+aWT9NUxE3F0C+K/lr0w//YlwgAKbgZypTvuxzcB+qhcGe3gybEEaYvdIhsQ?=
 =?us-ascii?Q?jUacZNeAUquIKRUmjLYAtnSciejRSPFmC+MFaTdrci91BRvLagpYZCY9yLN5?=
 =?us-ascii?Q?LMSbfKIAsGVGUzBGQ80HwQ0qID/A8wx4F8qB7hUoYnHvqMok5S7ASlRjgw+f?=
 =?us-ascii?Q?w7lamcvG8CqdAqUvAOXbCRNUopBcaJZHETsKk7xDZslq5vueAP8f6e1BVN35?=
 =?us-ascii?Q?11ImZbvdLXxvThtk5ihDqrVfIPIBJYmQ66DpLAPpdmSooDlxMXfGoS7D18L6?=
 =?us-ascii?Q?gmbUHeRq95KWN+URt/dMsHRocL9BMtnYPOkYTb3H5x9du3rRqqV5s3MSHtlY?=
 =?us-ascii?Q?e6I209m2j4pp2Wv/dBB2NDOs9UuGVL5n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 360a625f-e594-4ea9-0221-08da08e63446
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 13:50:04.2599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OyBR38Tv/KbXXZqdXG9HwRwmqP65f8zKAVTPmuF837quk8mSdzs43lWKl9kzftf8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5102
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Luck,
 Tony" <tony.luck@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
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

On Fri, Mar 18, 2022 at 08:01:04PM +0800, Lu Baolu wrote:
> On 2022/3/15 19:49, Tian, Kevin wrote:
> > > From: Jean-Philippe Brucker<jean-philippe@linaro.org>
> > > Sent: Tuesday, March 15, 2022 7:27 PM
> > > 
> > > On Mon, Mar 14, 2022 at 10:07:06PM -0700, Jacob Pan wrote:
> > > > From: Lu Baolu<baolu.lu@linux.intel.com>
> > > > 
> > > > An IOMMU domain represents an address space which can be attached by
> > > > devices that perform DMA within a domain. However, for platforms with
> > > > PASID capability the domain attachment needs be handled at device+PASID
> > > > level. There can be multiple PASIDs within a device and multiple devices
> > > > attached to a given domain.
> > > > This patch introduces a new IOMMU op which support device, PASID, and
> > > > IOMMU domain attachment. The immediate use case is for PASID capable
> > > > devices to perform DMA under DMA APIs.
> > > > 
> > > > Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> > > > Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
> > > >   include/linux/iommu.h | 6 ++++++
> > > >   1 file changed, 6 insertions(+)
> > > > 
> > > > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > > > index 369f05c2a4e2..fde5b933dbe3 100644
> > > > +++ b/include/linux/iommu.h
> > > > @@ -227,6 +227,8 @@ struct iommu_iotlb_gather {
> > > >    * @aux_get_pasid: get the pasid given an aux-domain
> > > >    * @sva_bind: Bind process address space to device
> > > >    * @sva_unbind: Unbind process address space from device
> > > > + * @attach_dev_pasid: attach an iommu domain to a pasid of device
> > > > + * @detach_dev_pasid: detach an iommu domain from a pasid of device
> > > Isn't that operation "assign a PASID to a domain" instead?  In patch 5,
> > > the domain is already attached to the device, so set_domain_pasid() might
> > > be clearer and to the point. If the IOMMU driver did the allocation we
> > > could also avoid patch 1.
> > iiuc this API can also work for future SIOV usage where each mdev attached
> > to the domain has its own pasid. "assigning a PASID to a domain" sounds
> > like going back to the previous aux domain approach which has one PASID
> > per domain and that PASID is used on all devices attached to the aux domain...
> > 
> 
> This also works for SVA as far as I can see. The sva_bind essentially is
> to  attach an SVA domain to the PASID of a device. The sva_bind/unbind
> ops could be removed with these two new callbacks.

As we talked before I would like to see 'sva bind' go away and be
replaced with:

  domain = alloc_sva_iommu_domain(device, current)
  attach_dev_pasid_domain(domain, device, pasid)

Which composes better with everything else. SVA is just a special kind
of iommu_domain

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
