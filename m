Return-Path: <SRS0=ynGH=LB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908E5C47082
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 17:55:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27B82610C7
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 17:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B82610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0FA16067F;
	Mon,  7 Jun 2021 17:55:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sr3PfOUmgd6s; Mon,  7 Jun 2021 17:55:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id C967960626;
	Mon,  7 Jun 2021 17:55:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C4C9C000E;
	Mon,  7 Jun 2021 17:55:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B54C2C0001
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 17:55:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 96FBA82E95
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 17:55:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1ucFSAIiBXg3 for <iommu@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 17:55:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::62d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 610A4827B5
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 17:55:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQBZ0mTFjkYysFDYAe7pG/Kpx+TE+ymZnkTlGvl0gfzl+hsFlT6Ivm34ms6ZEdI6tqlNOpt9cvVVYSeftEWIU97EyP6+N3sA0qaED9EK/23d1sN2s9VvJ+IC3I3zBSoGa7sDhCvtUTCBIo7Xm01/B+fZSxcz7vVgmPPSWYfY025YWtlbBgqFWBgFoEWC2Svb6LS3OogK8COj8vW/eWJwYVgVM/Z48uLtNTIH32eqz8MpCxJXYXXuZfGnWSbYCTy3txju1qWSRGDLWqlwHjrgvv32PF3Q7B14FB08GWclFCap5zf3ZUJh0ArCrp4Kmb1SryMTygVwmF6r67q0N1cyIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLWYqMriEcXx5Z+8DjimEjR0gcSL5gdhI51yHWDCDHA=;
 b=J5vjC9FRxPInY72819Suqf06wOk6bYmLALI8GKx9dtGl7oO+ivFXQMwlbsC39yYPodPnIO97tGHCionVbXbdUpT3czOyJsczDVBP8PRKgvHulo0jhCqsgCzajEO2/jifmKcDWtwx1UrzCeRvXHxt3zaKbRyqRoEChPI9i/YAVEwXNAY+MtXAtQq7CisInWhrvTDB7I01uO9Qg0QC76I3qv/eIIp++ZZPT42br8GfUbgGEvCeyRTnePvL/Oec+41fkrS8NvovNKQQvR56oZ+pqttbo+gkRXka3qfIGmJ6dSiERtxgfToDUqtdWz8kJOKjfIu7CdQXpI2V3o+hVV9dJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLWYqMriEcXx5Z+8DjimEjR0gcSL5gdhI51yHWDCDHA=;
 b=kv/O3eNTgCIldoG6MGLE1YlnAYj3szdQQDJWM4zoZlX9qlBN+u6zC08Rwnpz4cZeVlYC622UaoFaL1AWstIyDtM6cEhGPCdvTtzbYVy/vRES7fsllhg7vecPUm9KARdfuOs5xPHm9ct9UvzQJrd+HxdHoR9KiBIv57ku7O8GdfR7NcbQe8hVj1BBTdl+YmAWEmhaMNAAw6c/AMQkI18xeVmq4EiCupW3VT4SONhhQUG/R6ik3vvd/wMOVQzdc8I7KOJXIgurXdE9A3wrq+vZEI71oTiCdCmiT6zPduYQbzv7pUwKME3gIw1eE/pGlUMXwhdiUEHIXqpif94TECF4Gg==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5255.namprd12.prod.outlook.com (2603:10b6:208:315::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Mon, 7 Jun
 2021 17:54:56 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 17:54:56 +0000
Date: Mon, 7 Jun 2021 14:54:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210607175454.GI1002214@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528233649.GB3816344@nvidia.com>
 <MWHPR11MB188621A9D1181A414D5491198C3C9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210603130519.GY1002214@nvidia.com>
 <MWHPR11MB1886B04D5A3D212B5623EB978C3B9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210604120903.GI1002214@nvidia.com>
 <MWHPR11MB18863B2D785138E12193983A8C3B9@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB18863B2D785138E12193983A8C3B9@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::11) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BL1P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.15 via Frontend Transport; Mon, 7 Jun 2021 17:54:56 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lqJSg-003Of4-HT; Mon, 07 Jun 2021 14:54:54 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5889c89-320a-47c5-4d97-08d929dd5c6f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5255:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5255B99128E344B7903C130FC2389@BL1PR12MB5255.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qkmkqGk5O49RwvOSW29UryqpHyWebzxz+jdOJNQg76jfQZG/Su/PIKvPS3jXcnIaN0JwB1VSdu24RXMXKMtd3Kn9rmVt5SZ8W7WFQQFU83FtTgM2ZnTMV6Kn3LxXJONY69mKixB5Sg5LewDP+25yTD1OGcrx2MHy08b0Wef17KEqaddPqW7hgsLuYYGy5RNmHhWSDQNcE7UVhdb6evkkNIVo9xhA+kcXs/WY9YqIuO3pGoNeKSuV+M1NlmG8X5hFJlE6xKCHXpVXUQQoVR5uTIP/FaX7V2ODDAl/3EGxtHZO9kaI1eZhlAlZ3ZDhuwYNibDN0HeDFDd9WxFPik07Dk6TlpoLRJuejuhspzpciyWLEio2jfaCN3LRD6DSQ9meqBZiwtXashRFliNmG7myAxj1BB5NzxQLSsWnYdydN+YpjmTC/ZZTCb6t1oYgfMSz9kJpPLEBH3U1HmkpRu9VhfveIyib53S9QoHSG/+5xq9IVIvWI7qxLW8RMr6V70Ndx0UZnXtfq7rbSmRhiPpgjkpJNGaGDr5iqwSwG8F3KHVJkigDRFACit19FYo3BsNfcSosh9qfTuIFbCvpD59w2slw5C0Dz58Lgff03oswGSo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(36756003)(2906002)(1076003)(5660300002)(6916009)(478600001)(54906003)(66476007)(66556008)(66946007)(26005)(83380400001)(38100700002)(4326008)(186003)(9786002)(2616005)(9746002)(86362001)(426003)(8936002)(316002)(8676002)(7416002)(33656002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UrcD6UI6FOO8XIlpo4+4HzHSkllZ59ZrQQ9SuAdopCf8q2QNe12odO0/b8rc?=
 =?us-ascii?Q?/tyzgd6uYM3Irq2U0/jxSUxRP1m0IpDPLLMJBTtMPSJpchMPu6jCtoMX/1nY?=
 =?us-ascii?Q?52+UjBaAVOPyRoOLDKzCH3J+C1AGVlbVAfOSFTaDr7ZQsMlRMsoAMqC4nGd7?=
 =?us-ascii?Q?7R+4T+1PP4rD2vUEaudI6arDVa2DuuB2dC4iRwvZEQkV+n9zgrmkLRHIH8gw?=
 =?us-ascii?Q?//VI8HjKAerYB6blGKDWvOG+v7p5Py1m4UrafiawOm48TPE42J4wV6ZFKcak?=
 =?us-ascii?Q?yID8BcB5DeSTaWStchMk7ZAqfZ/EdUpxJ16BEbP30kqY4jWa2kiqTvk7tgnm?=
 =?us-ascii?Q?pZaOzDceCEq9tSMRHphUIctYozGhmVw9hFEAv5BS6r9uztx3MRlGZxEOeg2Y?=
 =?us-ascii?Q?WvcWfTiHfeOW4qqiAv1D6nY3ALiKvhjbbuY5cpXT8CxnW57tFnWY9NLLOT+b?=
 =?us-ascii?Q?KjhM3Q3Ph+ZOmeal3ooQcuqsWe4wCD94gL8fA5JgT+6MHa1j2ZY4kF0FpKqj?=
 =?us-ascii?Q?WpaqaPStZaJBKPXV6sxHMXVdwrhntckN2O3nST2Z0xkt/QM0Wsvps/wFDajh?=
 =?us-ascii?Q?eczWsUBUTjLC+nsXgctqgRJD+eYjL942RyWCPp1er9u1+az9Xusho/nFbNpc?=
 =?us-ascii?Q?sOGgS+z3m4xNFMckEHD1yvpRvQ0UMXjgcjKIJDrLI0rvKFqSR6AyJOOwdXjt?=
 =?us-ascii?Q?aqaQ5f38fx2fMzMnq8l9Jap5AVmMXEjYjCiJF1O4Q4Cfynxl8KnGrreBGV9i?=
 =?us-ascii?Q?5mADjmxl3oB2/JXgwBwyEuQsST8olvu7UgFG/MQITvJamW+8kmbKt8/J6xpR?=
 =?us-ascii?Q?P6TE55X7iDpfWAzzQVcdKJQlSzQArd1jLAm1DJbgF/7m5WltafwSu188tJsR?=
 =?us-ascii?Q?zVK5jpvSaiW6nhujgQVBSnjDRKtmaBBzD6oaEai1ipl+Naume2FJRcuMPpBq?=
 =?us-ascii?Q?dRXc2Memfb0krsyy0D9+y8Sd7t/YyDsBKq5nfWNr8mRiXZupnsNVd299pAD9?=
 =?us-ascii?Q?7IqZNMRrbj2RTgI02ooU2cN5TcIhNmwaXhQYi8s6CXU8Am4u0HBzKeQ2bvxl?=
 =?us-ascii?Q?4gjzwUr0nTnDsCrWNTdVOszF4KvU5pcPnzLeIWEtMySaUhZDVK+kBaIgDcP5?=
 =?us-ascii?Q?j5EwiRDuShs/3AF4G22+MCrhmenWo6V922oGXSZva0vi6HAtypBiUHepiBiI?=
 =?us-ascii?Q?jSRnLNeE+UL3dbPJcuJSyNxnMxzZo2S0QYug7I2XGsXJVBLYE5l8I1VN1MY8?=
 =?us-ascii?Q?Hh3cVSBaowJSiFY3jpF4KueyrklrJfSb9m3rc6AJGSGCRixkaVX/frnmQKw7?=
 =?us-ascii?Q?f7DnSj113eH4cEvSOEEcfaPy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5889c89-320a-47c5-4d97-08d929dd5c6f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 17:54:56.6488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efxXMXQU82aMItR2QmmD9W1NMbZ/MNTefs4tWVRo7JjAme+QuaUM9fkayGoPNI/K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5255
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

On Fri, Jun 04, 2021 at 11:10:53PM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Friday, June 4, 2021 8:09 PM
> > 
> > On Fri, Jun 04, 2021 at 06:37:26AM +0000, Tian, Kevin wrote:
> > > > From: Jason Gunthorpe
> > > > Sent: Thursday, June 3, 2021 9:05 PM
> > > >
> > > > > >
> > > > > > 3) Device accepts any PASIDs from the guest. No
> > > > > >    vPASID/pPASID translation is possible. (classic vfio_pci)
> > > > > > 4) Device accepts any PASID from the guest and has an
> > > > > >    internal vPASID/pPASID translation (enhanced vfio_pci)
> > > > >
> > > > > what is enhanced vfio_pci? In my writing this is for mdev
> > > > > which doesn't support ENQCMD
> > > >
> > > > This is a vfio_pci that mediates some element of the device interface
> > > > to communicate the vPASID/pPASID table to the device, using Max's
> > > > series for vfio_pci drivers to inject itself into VFIO.
> > > >
> > > > For instance a device might send a message through the PF that the VF
> > > > has a certain vPASID/pPASID translation table. This would be useful
> > > > for devices that cannot use ENQCMD but still want to support migration
> > > > and thus need vPASID.
> > >
> > > I still don't quite get. If it's a PCI device why is PASID translation required?
> > > Just delegate the per-RID PASID space to user as type-3 then migrating the
> > > vPASID space is just straightforward.
> > 
> > This is only possible if we get rid of the global pPASID allocation
> > (honestly is my preference as it makes the HW a lot simpler)
> > 
> 
> In this proposal global vs. per-RID allocation is a per-device policy.
> for vfio-pci it can always use per-RID (regardless of whether the
> device is partially mediated or not) and no vPASID/pPASID conversion. 
> Even for mdev if no ENQCMD we can still do per-RID conversion.
> only for mdev which has ENQCMD we need global pPASID allocation.
> 
> I think this is the motivation you explained earlier that it's not good
> to have one global PASID allocator in the kernel. per-RID vs. global
> should be selected per device.

I thought we concluded this wasn't possible because the guest could
choose to bind the same vPASID to a RID and to a ENQCMD device and
then we run into trouble? Are are you saying that a RID device gets a
complete dedicated table and can always have a vPASID == pPASID?

In any event it needs clear explanation in the next RFC

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
