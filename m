Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D594BC4332F
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 13:01:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EFCE6124D
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 13:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6EFCE6124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B98284391;
	Thu, 23 Sep 2021 13:01:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9ZxD8hkIhG3V; Thu, 23 Sep 2021 13:01:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D306C8437B;
	Thu, 23 Sep 2021 13:01:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABC2FC000F;
	Thu, 23 Sep 2021 13:01:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 251C5C000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 13:01:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 13A4640222
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 13:01:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JGKn42Opufip for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 13:01:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E997E401BD
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 13:01:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Al2R9aqsAYJ31oIl8lWqqWbcndoO8SJHid0/WqQPoqGHl9mPqW033+d9Zt8+2/rQkZmnflZ88VDqGpbHP1YKkFdXqt6PNWtZNuEplBfx2F3fJdifRIIRpm7QmtjdHcJSAEs8pVAhiilKOCRgL9KFZ8yT8TcdtAqAlCRbA7CNlYDoXEPMzE/YPTLux/srrpS4J1sC7JgBIgl3lZOb9LWYGEicIdF7oJAlM39hYmzzs2Ih2HU30OdsQSHhPsFG9lYh2yUNWnZah62xHPTgN1AtWiJ/QSpZunmveAa5y5LrJZQyEY0IDkHztcajvCOCOdGADvbppb9p2wneIAQyz/1U8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=5d8zAuwJHSwAadLISZqV3nHaCVNEbzTCCXvBDjrTEeY=;
 b=L1Wi0paSqq2BsskCT/0+84qWKi0y0zPxmRStiM2xmourYY0r8vCWLadtEelq5yIgAIwwMgfRvNOjVxKXJj8pohNZz+WKOzipRSmcHiAlCyDonOO4jjd1wOLoKY0Gt16/olaLwvPDnThM1fViq+5lIu4bvu9w6K99AE85M0dc1EKchRxlD4eGQ9nLcyNRnlw+dLolQ4IKIvlJVbTBRPVzv+MrxP2tzmpmFgfzV+7mnQE4mSuEi0RD8AEzxwnlavIV5mNMy97jnPF3H0x2CgS964zw7E3YxMIgCKlFHRUJVEbSQ5hOppmmgsthMUDKXkYiOJ9Vnsnky0E3Y0qwDIQd3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5d8zAuwJHSwAadLISZqV3nHaCVNEbzTCCXvBDjrTEeY=;
 b=eFpxnn1MRd9A03Y7X/bvlvnDySSGTAF5Qwcc5CIZ12YtMW8DPDzBWsoLBIo4lWQGg/feHtZXvtxrSWFjdFDyYkZ7lD0SXkbndkaXIPy11xJ9+pX7XcYh8KPWJE18VWi47Y+6AxEBvEeL8K0P+lJ0W3c6wov2EB0kGeNp4aN0ZFowm2UDqzGWaE36YNWNONYPdD4lJK+qimzcfw3a+9zw427Us/578pBxYaPgmvML06tqn5FIKSSkf78YynTVCqbIhEClDYEF0Eqt1gbOUyNuXykDMNnQX88UvVrA8RIaSWCRlUd8NsUpoekQUsToPV/jidCsSL7zqfYy2eJYCbQN7w==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5301.namprd12.prod.outlook.com (2603:10b6:208:31f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Thu, 23 Sep
 2021 13:01:36 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 13:01:36 +0000
Date: Thu, 23 Sep 2021 10:01:35 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Message-ID: <20210923130135.GO964074@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-12-yi.l.liu@intel.com>
 <20210921174438.GW327412@nvidia.com>
 <BN9PR11MB543362CEBDAD02DA9F06D8ED8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922140911.GT327412@nvidia.com>
 <BN9PR11MB5433A47FFA0A8C51643AA33C8CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210923120653.GK964074@nvidia.com>
 <BN9PR11MB543309C4D55D628278B95E008CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210923123118.GN964074@nvidia.com>
 <BN9PR11MB5433F297E3FA20DDC05020E18CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5433F297E3FA20DDC05020E18CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR0102CA0057.prod.exchangelabs.com
 (2603:10b6:208:25::34) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 BL0PR0102CA0057.prod.exchangelabs.com (2603:10b6:208:25::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 13:01:36 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mTOM3-004PeD-8u; Thu, 23 Sep 2021 10:01:35 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ca7736d-49c1-4e35-2234-08d97e924660
X-MS-TrafficTypeDiagnostic: BL1PR12MB5301:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB530185CFE499128689387C6BC2A39@BL1PR12MB5301.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RMrvrUBo0b1dug6dLCnisNMWGZGZUREfQDQFy7ZWEcPIS9GXw3pX5UbB5n+OZLxMNMswWAeooPxhdWZlMge8WUTFe/6yhrN4Vsai6l/7+iS8S0eYYbj3wrbIx4SKeV3mRQGjfUd1R2797vLtw9aqCY9TtpbAuus4wgbIz3Gnuo6Ete26AfgmDQauZHzfN/SBJXqDlIiHIJJPcy7p/B3t62FZ5qw4Jevw5rTp0N/FopszndoVFE7qRJ+RbNw1xDosqaNYVPOcJSxS2FFN+LDrZLtH58uX3iaZmV7wPpkREsGzAWvfgvLHr3hX7vcoIG6LVycrSOtp1BTyWp//o1UgL6HZy0PN4EJPwmIc6e1MgS9h43QQWIA9HdheZ4d9/4JJfG9YUgMtHP8CC/E4RO9G5Skc5t3xRb2nfmEzJN5cj8sxf1ZZ5NAGrhzyAACFwyKagB7hUAqXVrbwU20dGpD2RN7vdvnw3OXo3dd2KPC4sMaDWSzOo9uvsWlcoxJ5iUFiavWrB1cKr0wWqQJwqWfIJP8wHGIHuaWvgi8lxVRXsa6PFlKa5jhRSp7B3tQK19ynLFJu9xJS+llwAnZ3MG51K0FoCz5hMn6Qi+ItkmnL/Czf3AlXxlGzb0kKOIYL+d4GkgnrJt2nVWGcshjCzrWtFmUubtBmO6p3LdmVCVyULeEijGiaVeGhsJHdtxcrOMbjcAgyjMGI6pztSkIuFe4X7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(66476007)(2906002)(316002)(66556008)(6916009)(38100700002)(107886003)(54906003)(508600001)(426003)(86362001)(8936002)(5660300002)(8676002)(26005)(1076003)(2616005)(36756003)(9786002)(9746002)(186003)(7416002)(33656002)(4326008)(27376004)(84603001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IGuMGFFPUtgZTmTM1Pz8fhgO278QMZ9v8ivbKohV25o6xBWS5iPsJUVggsNK?=
 =?us-ascii?Q?wEb7clYRXthnW8Zm19Q4ThjMl4y4hSPnWKMmTGm21iZBsBozhStpmGuqJiG+?=
 =?us-ascii?Q?nHCCMekHYQfeno5QTpiFKaZ8UfH8Pi7rAmFTsfqFP+UN57CLcYCBo0xVfymM?=
 =?us-ascii?Q?4mCcIowgvXLrMI5ZEQVQY5pxlmLpJpd6ytQShA0r4GR39myfahc0FYRHLwBC?=
 =?us-ascii?Q?Ik6t76nFQNFkuiIulHvJHp6b+ne3NHpVeP02i/apt3rMG7nad37pvitPX2AV?=
 =?us-ascii?Q?PwtXPe32CHVtaZrUGN9s8pa72uI+K0tbtIp+Lxm0gggDj2WzQU/IehJchiDJ?=
 =?us-ascii?Q?YZ+bHhHhuNTi3gLMl8eqq87RbocuYuMMl+XoO8qwgCCHt46hbl8bwtgg2HjN?=
 =?us-ascii?Q?GafYu+YZ4rft80SwwOUFYyPRUSnKkJFsZB8BGvg11OEimpEVofOs0frX5tBC?=
 =?us-ascii?Q?oNaps1kcV81O4GwjrxkycykP+8lDsaCTCOxdRn5+UyfhX1r53zy2QtPGMc+b?=
 =?us-ascii?Q?hglF0rWu/3KTKjF1oblITwKiAblubjqXsGc1qU3D5aYFEOSoCD6l+7kGxMmd?=
 =?us-ascii?Q?Z21MX/Pxar8FlMi+d5NInqWncqKTblRle8jG9tdN7dknRfaUBlqZ60T8pFbt?=
 =?us-ascii?Q?sxDV9IirKUZdx2/NWol4T/pNzQaA89791DjJAx8nnnNqj98NgiyvM1DmF/ke?=
 =?us-ascii?Q?Xe+aBzh+Z/EoSc4ds/L2dOoFKAP4rXiKFsv/1L6exlQts4I7t7ecy+ZuWCGd?=
 =?us-ascii?Q?NGlxml3Ysqz/08FrAqCuW1Dj97NGRp3p5yKnH+TRt5SuGmKFZI2AJlkgf7oV?=
 =?us-ascii?Q?bK7aVStw/Xxu6q43ZtUS+ivqz6HG+2r6JF9w0AYUVGiiSd9jf8WQQCnBIyBx?=
 =?us-ascii?Q?G7AniWLhKqgl5e73j7JyOqWi2/PTJpz02kpkuORbwnw6MPAwgRwKg8VavCfr?=
 =?us-ascii?Q?AdZteD2MRU7e5ThgWwfVjRSZB/2xCJjCR+CZZ78+GFZc15Tksq5uhn4bWSyW?=
 =?us-ascii?Q?oJRTlDcbsTXkEOkqaWvhr6ZU0aTr3+f6mlAL8c28v47SGwbbKs44HwLJYptN?=
 =?us-ascii?Q?S8V6aIrX3TXitOmmJwjZz98NWW/HgPvuDvu56OdnVOv8jES6X2M+ddnun6OV?=
 =?us-ascii?Q?6K6r7i4Uh/dBDQ48M+fEsXU9l1qTmuEX5A2FLgSmp6Kf2LGXLWQQRRm9me1/?=
 =?us-ascii?Q?FRZ0gDK2wakSDhUR2Ic2q2qrK9fXLAuFUhYDS3RZn+D9tYZRif/Fa/4Hlc5E?=
 =?us-ascii?Q?iLptAQ+YK9maJKNEbJyX6gFTSzV8OKeWDnz+xmhn52QVzTl8zMqSTvUmE8Kj?=
 =?us-ascii?Q?AZaEjLW54grdgQ/mU2u5xa9p?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca7736d-49c1-4e35-2234-08d97e924660
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 13:01:36.2488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMpY/bP0+ea7yqsWA+lG03OIC7WgYYrb2rkv6y9+GbTYChTZIKYwKbrqcWzuw3xF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5301
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
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

On Thu, Sep 23, 2021 at 12:45:17PM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, September 23, 2021 8:31 PM
> > 
> > On Thu, Sep 23, 2021 at 12:22:23PM +0000, Tian, Kevin wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Thursday, September 23, 2021 8:07 PM
> > > >
> > > > On Thu, Sep 23, 2021 at 09:14:58AM +0000, Tian, Kevin wrote:
> > > >
> > > > > currently the type is aimed to differentiate three usages:
> > > > >
> > > > > - kernel-managed I/O page table
> > > > > - user-managed I/O page table
> > > > > - shared I/O page table (e.g. with mm, or ept)
> > > >
> > > > Creating a shared ios is something that should probably be a different
> > > > command.
> > >
> > > why? I didn't understand the criteria here...
> > 
> > I suspect the input args will be very different, no?
> 
> yes, but can't the structure be extended to incorporate it? 

You need to be thoughtful, giant structures with endless combinations
of optional fields turn out very hard. I haven't even seen what args
this shared thing will need, but I'm guessing it is almost none, so
maybe a new call is OK?

If it is literally just 'give me an ioas for current mm' then it has
no args or complexity at all.

> > > > > we can remove 'type', but is FORMAT_KENREL/USER/SHARED a good
> > > > > indicator? their difference is not about format.
> > > >
> > > > Format should be
> > > >
> > > > FORMAT_KERNEL/FORMAT_INTEL_PTE_V1/FORMAT_INTEL_PTE_V2/etc
> > >
> > > INTEL_PTE_V1/V2 are formats. Why is kernel-managed called a format?
> > 
> > So long as we are using structs we need to have values then the field
> > isn't being used. FORMAT_KERNEL is a reasonable value to have when we
> > are not creating a userspace page table.
> > 
> > Alternatively a userspace page table could have a different API
> 
> I don't know. Your comments really confused me on what's the right
> way to design the uAPI. If you still remember, the original v1 proposal
> introduced different uAPIs for kernel/user-managed cases. Then you
> recommended to consolidate everything related to ioas in one allocation
> command.

This is because you had almost completely duplicated the input args
between the two calls.

If it turns out they have very different args, then they should have
different calls.

> > > - open iommufd
> > > - create an ioas
> > > - attach vfio device to ioasid, with vPASID info
> > > 	* vfio converts vPASID to pPASID and then call
> > iommufd_device_attach_ioasid()
> > > 	* the latter then installs ioas to the IOMMU with RID/PASID
> > 
> > This was your flow for mdev's, I've always been talking about wanting
> > to see this supported for all use cases, including physical PCI
> > devices w/ PASID support.
> 
> this is not a flow for mdev. It's also required for pdev on Intel platform,
> because the pasid table is in HPA space thus must be managed by host 
> kernel. Even no translation we still need the user to provide the pasid info.

There should be no mandatory vPASID stuff in most of these flows, that
is just a special thing ENQCMD virtualization needs. If userspace
isn't doing ENQCMD virtualization it shouldn't need to touch this
stuff.

> as explained earlier, on Intel platform the user always needs to provide 
> a PASID in the attaching call. whether it's directly used (for pdev)
> or translated (for mdev) is the underlying driver thing. From kernel
> p.o.v, since this PASID is provided by the user, it's fine to call it vPASID
> in the uAPI.

I've always disagreed with this. There should be an option for the
kernel to pick an appropriate PASID for portability to other IOMMUs
and simplicity of the interface.

You need to keep it clear what is in the minimum basic path and what
is needed for special cases, like ENQCMD virtualization.

Not every user of iommufd is doing virtualization.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
