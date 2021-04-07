Return-Path: <SRS0=DRkM=JE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99413C433B4
	for <iommu@archiver.kernel.org>; Wed,  7 Apr 2021 11:58:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39C7E613CD
	for <iommu@archiver.kernel.org>; Wed,  7 Apr 2021 11:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C7E613CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E06514185B;
	Wed,  7 Apr 2021 11:58:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KTdBbBe1KQcU; Wed,  7 Apr 2021 11:58:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 428B64185D;
	Wed,  7 Apr 2021 11:58:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13DF0C000C;
	Wed,  7 Apr 2021 11:58:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A7F0C000A
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 11:58:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 613FD84B43
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 11:58:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hw4krIfdGXxw for <iommu@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 11:58:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760044.outbound.protection.outlook.com [40.107.76.44])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 44F3784B3C
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 11:58:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5J+2+pMVAzioiDZA+g6DoSF/8V9n5TxD2Q8EdWheHvJxP+y9/5wFEM3UuKfILeAQBm2fQh5lMZrYm6I5Y4qTJMuTU+p9V3EX761ikiNvFQBiflmtBGMeHkIx1ye3Nls0Xssqn1GXy6LuISoY08E+CfVEWSySn2wcN6V+XDKpHOZ4d420XS8GM6efiwSGflCh87jEO3oQAWetBe9yWp8qFVbZi6NfWE++3RxpLaYnsJ/5wNi0buR0vFQWlL6TOCzlNhe9LobldBxWEYLP+do+5zP2dNjW4ml7RT+4eDIFPJGC/iOfOQJnpfIXkiHs/xddZs8Iu2hDOexEwIi0hcGNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASMzTQ06ZilZBgO6QcthJXnUhhreqa1GJVMJtajmXI8=;
 b=Kq8BRp+i1Uf5GgtTK2GlzYlFlGEo9ERBG/HlQFSrJxv1JxLgfAIj2r3MKq0o4NmFChKMCI3FBrYnvyel4nz5jcKAyGNig3Rvu72mrNMAQXZeVqUV4lTnj9moEr0tOQ8jVD80fNqjJuJzFmJxKxbYGL2iJtwdofBjNDBv9dHADtDfZn2NCXMTsWQX9ZMh5UczhlQesJXQ2V5+69AAaSHr4lInkoVLZoHdkqDPdLlWwucVL1h2zwdgTpwlfMxbgpocKAHTC5RtjABrURIcg7VIRgf9Nh0ODirRc/2eJdYfacpqULXFM+WJp+UQEON+E/nhgglhZmEAz0cvZS5g03BxlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASMzTQ06ZilZBgO6QcthJXnUhhreqa1GJVMJtajmXI8=;
 b=RDL4pFBzruUBowT42rFcVDiUjGgauJRlHEiGY3koTieBmvILpSvHvr4A1Paov5ZwuqMXWKf9YtqrEzYkozSXmbrqfAFB9DUJnViICiZPdoiBoi1zkO02QSUoM7q86Ceroi/A4vS02MI5FolAAc7i8nsH3N/CsF8Vv4wxqe2K2wA/V7T1/1ZRkhaZ9Qyf09baeG36dXzlbD00YmejttOHAA91yqcxo7TVgzaIhOHCwRZd0axFVlFh+pRH1PRuZoY54cRSGy4qJZoAHhnYceXxDYDW+wNKISYl+kW0VoR2VsPdo4KUUlZ4UN8WjZwZRRFFYr91lV20Nt4r2KFPOH//yg==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4810.namprd12.prod.outlook.com (2603:10b6:5:1f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Wed, 7 Apr
 2021 11:58:28 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 11:58:28 +0000
Date: Wed, 7 Apr 2021 08:58:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210407115826.GE7405@nvidia.com>
References: <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <MWHPR11MB1886CAD48AFC156BFC7C1D398C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210405234230.GF7405@nvidia.com>
 <fa57bde5-472f-6e66-3521-bfac7d6e4f8d@redhat.com>
 <20210406124251.GO7405@nvidia.com>
 <MWHPR11MB1886A7E4C6F3E3A81240517B8C759@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886A7E4C6F3E3A81240517B8C759@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:208:160::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 MN2PR13CA0008.namprd13.prod.outlook.com (2603:10b6:208:160::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.6 via Frontend
 Transport; Wed, 7 Apr 2021 11:58:28 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lU6pG-00207w-PH; Wed, 07 Apr 2021 08:58:26 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdcde013-3433-4a43-a41c-08d8f9bc74f6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4810:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4810A1CB9895B6C88CB1B158C2759@DM6PR12MB4810.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eR1XSlNrE1rGiHRxAZmO7hneZzl/4hH9Lly+Gxt6WUFbvMyeMZUgFarRoP1CgCJOjH9lkLMhCDhQEbY+G2d9iF/MaNBbhclWQpof1iwaQaP1gPBq6HcQSwPXYf31Y8y3zTZMxNCdIqjQs1fOUYWUuUuwPf6+CSj/XZDCFmw7OYxIQj9YtV5SVfbIhqk/KsuMIhfGadjjgJ11WK5NmK+nJyzlU1rS3Sw8uEpmYB+Ldz05GPAiw7G3JOluVKWH+WC/Fqzr2lF7gPB3I7FOcRMK5mqhXJ7T4biq1YxFdxAfrNgS+LxP5GX55xDUHgwUsqgjGYY9rwq6c6PREZ0qRKn2tgm9VFoBsG5mvmGcKRAs+orR65wMBQhUDBpIevIbAHq423cIBdBaJFMxalGmc0desLEzOQSjpkClCAL09EDqbHpXYjmvieiMSXRCwTSTLXZ4nghrfqiLBOvcEsBAd7L7slso6zusFkZlFyV0r4H9noMfcBPTZZr1qH7AJu2be+dN8Cod3uMwzEan454WBxSoRPjHTvNwluL+2bbE2pKo6QRPcRuiR627zClJVke3137Spq8T7DzTKo61J4LD2bOWAisi4x3gHSHAP8N3iOXNXPz8lV7Oeg9xXxD+REr31ltbx0FJ7hjtmJnAtPhQ1+MI+1hYZDcRhRawHu7Z8MDHHxU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(426003)(66946007)(66476007)(66556008)(38100700001)(26005)(1076003)(86362001)(33656002)(7416002)(8936002)(6916009)(5660300002)(8676002)(186003)(2616005)(36756003)(478600001)(9746002)(9786002)(316002)(4326008)(54906003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?HYF+8fKDquiG3REv3fYNDZpxmOATugIpM9bow2zw2qoKi/HQeOpXYwhd9Cgm?=
 =?us-ascii?Q?0+vkWNxL1aEXCmCBN23He2w7KJLPpLt3v27dZIc1diYRYYOrbjBtvX5U6Xuo?=
 =?us-ascii?Q?140OuX+CTvzp3+GPdERBd7vlh08UpMtb0rXLutM8UBZP2JNVkPlCAHQ++5wG?=
 =?us-ascii?Q?9o8AL7n2jtyevKSIv/zTIW/qq8otOrhSD27/NmOhAJUlC5L5mDcBJc6h0iuS?=
 =?us-ascii?Q?txsPLoMPJnRivT5q7owN0GwOgoEzg03FVobQzmttYKCm0/L/U5KytxU7yWZu?=
 =?us-ascii?Q?6CXCH/qhzdlusPkRKxtdXYGZiwqRoD8MsFfdLFV6Ofh8N659xozdV0x9ZWnX?=
 =?us-ascii?Q?xcEHS22PTu3OG/u91877nlFoYeyTBFFQaXEtDgnrJwD6RF5qcTAE9TQmhZvV?=
 =?us-ascii?Q?nPk9czllm4iAwrf8xR/b9hv9Oe4gdlvTEWqD8//i3pjGvJOa+hleHxmuPKbV?=
 =?us-ascii?Q?pBzIAKzIIFOSXTELPCATBgc8CsY6tD40RDpNb2NGR7bqzBjvY/P6k/ILwGDI?=
 =?us-ascii?Q?i/n0B+/yZfEPKBkAzmvBAyWMKAh2eneKH1dOmAWhI25sn93RuH8Dnl4FfbKF?=
 =?us-ascii?Q?oQZq5tZtZuDGR6j5kLzV5/0CXChAQ7OX9L0DKc5VzWQ+yZNfEwpOIGCAebGR?=
 =?us-ascii?Q?burxVq3f6mgqaZuzQM29t5q130qw+rPLRQkR5Hxq9qyQglEMwn7jQDtE9j/T?=
 =?us-ascii?Q?ZwRgaarLeNHh6G4Wu8yg5yg6YNudX4aakJMx+rEB4JLsgeecH/Sw21kxLs3r?=
 =?us-ascii?Q?dRQI63yfAS7sClg27blcOWVfU0KFLEZ03rgQovpHguLv4fpZ4aNap88r83qt?=
 =?us-ascii?Q?BZjJD+4ZNW4vwU2EdCrpNLSX0xL4BwjN75fIt/AZtzcN+7q6vr7z6BQJSvLr?=
 =?us-ascii?Q?EUnNIvLHRP8nf23si7lcFT5ZwlqTOuNgAh3NtTdadQN5ViL0qrpW4P/o/PJ2?=
 =?us-ascii?Q?fkMVHQrQWqQ4tfoGntjD6H+iCnIZzYGk5W2ckqxyreNuEKBF/tS7EOl8J3zz?=
 =?us-ascii?Q?SwUYgedQuuTAnfhHpY5B7x0LpmS8WTHNh7sVnjTlRUqWVYn8llbDpxjf9UBQ?=
 =?us-ascii?Q?8kRGPsKWyVKr5g4KXLzkQKT18ABI1pXJ2MV89KJNX6jgynpxEDDU2ZGDzXMj?=
 =?us-ascii?Q?tbOdqBzeLbXLMsK6feCLsWusjLGCCi5qhesIU97oWxy6zy25azil5FoM3KqH?=
 =?us-ascii?Q?UG6qjhWobZlSYh0ds5HI5yK1I/ZLzD5P9qcDD+UhvUvkYIynEDnV3u73rj54?=
 =?us-ascii?Q?qVm3FD0/qwfnd9Z0hsIvSyCNB0BoCdOlNkwl7t421lBHUdDzZlFaE1uV0FDD?=
 =?us-ascii?Q?nv0TFrsXkHVVpohBtX4uUgFQDa8yXWFgld5Vj3b+0xFIhA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdcde013-3433-4a43-a41c-08d8f9bc74f6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 11:58:28.7032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pLKzOWz3XX+QO5a0vSWcFNEj6XPMI+dLs9Fg692xsoZF0GmU2T//Ix9+7dGlkRaV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4810
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>, Li Zefan <lizefan@huawei.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, "Wu, Hao" <hao.wu@intel.com>
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

On Wed, Apr 07, 2021 at 08:17:50AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe
> > Sent: Tuesday, April 6, 2021 8:43 PM
> > 
> > On Tue, Apr 06, 2021 at 09:35:17AM +0800, Jason Wang wrote:
> > 
> > > > VFIO and VDPA has no buisness having map/unmap interfaces once we
> > have
> > > > /dev/ioasid. That all belongs in the iosaid side.
> > > >
> > > > I know they have those interfaces today, but that doesn't mean we have
> > > > to keep using them for PASID use cases, they should be replaced with a
> > > > 'do dma from this pasid on /dev/ioasid' interface certainly not a
> > > > 'here is a pasid from /dev/ioasid, go ahead and configure it youself'
> > > > interface
> > >
> > > So it looks like the PASID was bound to SVA in this design. I think it's not
> > > necessairly the case:
> > 
> > No, I wish people would stop talking about SVA.
> > 
> > SVA and vSVA are a very special narrow configuration of a PASID. There
> > are lots of other PASID configurations! That is the whole point, a
> > PASID is complicated, there are many configuration scenarios, they
> > need to be in one place with a very clearly defined uAPI
> > 
> 
> I feel it also makes sense to allow a subsystem to specify which configurations
> are permitted when allowing a PASID on its device

huh? why?

> e.g. excluding things like
> GPA mappings that existing subsystems (VFIO/VDPA) already handle well:

They don't "handle well", they have some historical baggage that is no
longer suitable for the complexity this area has in the modern world.

Forget about the existing APIs and replace them in /dev/ioasid.

> - Share GPA mappings between multiple devices (w/ or w/o PASID) for 
> better IOTLB efficiency;
>
> - Share GPA mappings between transactions w/ PASID and transactions w/o
> PASID from the same device (e.g. GPU) for better IOTLB efficiency;
> 
> - Use the same page table for GPA mappings before and after the guest 
> turns on/off the PASID capability;

All of these are cases you need to design the /dev/ioasid to handle.

It is pretty clear to me that you'll need non-PASID IOASID's as
well.

Ideally a generic IOASID would just be a page table and it doesn't
crystalize into a RID or RID,PASID routing until devices are attached
to it.

Since IOASID can be nested the only thing that makes any sense is for
each level of the nest to be visible under /dev/ioasid. 

What a complete mess it would be if vfio-pci owns the GPA table,
/dev/ioasid has a nested PASID, and vfio-mdev is running a mdev on top
of that PASID.

> All above are given as long as we continue to let VFIO/VDPA manage the
> iommu domain and associated GPA mappings for PASID.

So don't do that. Don't I keep saying this weird split is making a
horrible mess?

You can't reasonably build the complex PASID scenarios you talk about
above unless the entire translation path is owned by one entity:
/dev/ioasid.

You need to focus on figuring out what that looks like then figure out
how to move VDPA and VFIO to consume /dev/ioasid for all of their
translation instead of open-coding half-baked internal versions.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
