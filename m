Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F98DC433FE
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 12:03:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 259CF41499;
	Thu, 12 May 2022 12:03:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3_B8iVlwmn73; Thu, 12 May 2022 12:03:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 93351410CB;
	Thu, 12 May 2022 12:03:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DEB1C0039;
	Thu, 12 May 2022 12:03:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D07BEC002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 12:03:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BD1C7402BC
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 12:03:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 83MuipF16tNj for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 12:03:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::628])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A0DE240192
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 12:03:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jd9HJnbexdKRggFaYo0w9aJVbnRIX4Un4EsJXsmQGW6G7q5k5OSO3ysXNgC2OkFR6KgsQWpNMsytTvEDXXCcElV+ObnYwsPPxZ1XiY+R3PV8gnv/bPzS2Lvhs5GegSr+73BJKdmKxA0fbBwrVdhnmY4W052iooKrK2mz3XwkytHycpQRixlOeDPTjBbHTWoG/z6s399QjgCOszY9c53ks+2V8Ti8t6R6hsbMfyXnr8hFOY3X0FyTKrYXm9HAM1g0A+4JLU2SKcMSJJQ0YjKIdF/8ti6DE5jDBVAta7WeDtsKI3hyzD2G7d3Rcg/M4e6DA6eXrXhezNyX+AymClcdSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwpRTGsk0zIzpVgs9lar3bWkyExgYHkEFohvqHHo784=;
 b=hfDE8Z12kxeGM5esd35jFBkzvtNBFQrStMfvRCd9Hb1zisnUx0g+JhaCbcw5sxdeWvwsHp7m0IDzgp3NLLH4K+2orDyZCGcj9N7cEtEXpT9Stg8fpVt+X2ldJSDXNxBjVdyoAFgVMVlKJyRIq0erJ7VHZV5VtRAIRim3zWCiWqfj7qMXfvbdF5m9pYBMGt31c2lj19b2Aq3Eiiwsp+puX0AxFzsFwMPgCnjR5yeZySlfsJVqSaH/EJj/ZSzs6y9Y0S/s32h4Cc5g+r5EzjarvuF9sXU8OYIloiNadjrPxm8T5iNef/UseezZv1rEgT45cVp2NH5kpMNDLnCPUYKBtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwpRTGsk0zIzpVgs9lar3bWkyExgYHkEFohvqHHo784=;
 b=Bcrq27/7fdIkV9RacJXQO2+R49hRa6QkglWYK1g7trauxdbIITRfNqay5niQNw7QmGifw7TG7zxhULFmD83zoRxM8rrT3TgPH9xOrPteu7oZY+JCHHsHoyxAzgt45mxjGC9z1fMj3FzKBezn/5CulDkhZK0+T1LgXT00mfnq2y1P7SlKoUz1P4EBlEURAzVFNRy0C81LZBZB20BuvU6u1busU86+g6m7fHadA4EHSwNCKjITvAD1djI4q0ptARsdcTK4c30PLqK/JgOFc84JNu9hB5aznf888GaMAnx0T2wl7Vm7ffzfYM9ClIvQE6f4Y6GGB8lianVlHzbpxwCwpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DS7PR12MB6213.namprd12.prod.outlook.com (2603:10b6:8:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Thu, 12 May
 2022 12:03:05 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 12:03:05 +0000
Date: Thu, 12 May 2022 09:03:03 -0300
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v6 08/12] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Message-ID: <20220512120303.GY49344@nvidia.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-9-baolu.lu@linux.intel.com>
 <20220510152330.GG49344@nvidia.com>
 <749a7d62-3e6c-ef5c-beaf-6b7add495740@linux.intel.com>
 <20220511145319.GZ49344@nvidia.com>
 <05a68e1e-8e18-5914-ebe7-d7b1a4aaa2ec@linux.intel.com>
 <BN9PR11MB5276C03134A898CA9EFEE9258CCB9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <64954f2d-2274-410e-269c-84efc0635633@linux.intel.com>
 <20220512114844.GT49344@nvidia.com>
 <1a78418a-8637-e8dd-d1de-5529f20058fd@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <1a78418a-8637-e8dd-d1de-5529f20058fd@linux.intel.com>
X-ClientProxiedBy: MN2PR12CA0036.namprd12.prod.outlook.com
 (2603:10b6:208:a8::49) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61afe269-7237-48f4-82cb-08da340f5f5c
X-MS-TrafficTypeDiagnostic: DS7PR12MB6213:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB6213C98D5A8BE3705EABB1B6C2CB9@DS7PR12MB6213.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ecDYopUaDA/cIMD6fVhpnqQM0ZZ/yE4A1tvquSNh4uXKg6yID3E8fsYGng4EfgxnArzjtYXy3reRwNB/7LO0G61n4OFONFqYcYHB8AkDxfg9o/jzMiLFRdKN0KDBfAilH5Mc1UyJ0lKdAisIKla4/X3o/V+R0zav5XUzfbxnQhppB1GbMamN2z6BhSbOqmzWey0rQuNC8vF0OXj1b6yNemZBCkZdhW5n5fQ+0xVQ8NmD7qic1JBFYjXGCDaxTrGhEsf2x/l4rXy9/gtopS6zAyF6pfhXHStamjOMPtlwRtNK8MPcitE+S4TNMY7dDvuJeh/EONLkhq8ihYS7UtaaF4AWhrqfQnqXX466xaA4Nz7IndudCH6jENaIGHMUxeT7pxEGOxFqL7SSihvto754Evg9V6Xtz1QkOUpD0L9YXNazL609uSyQcuabsRFwgu9Iz6prFxmH2wO2W0KQuJYQyOWw2yjfjJeXahwGa+Ne5ipgBvX55QbloqafdNOV7ALRDTUGzus/8HyF0POtOSGx7DMVLGnElNp4pl31M3VR0mDzu+NdiLieLnLeixnzhTRo6drEQQ/JDnUROpMV8LbpKrTQmaz/P84o7/W9BCBZC5HQKw6ltPoW9erm0n3zQxYyNYL9FEoptqfaZbkP9n1z5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(83380400001)(33656002)(508600001)(86362001)(1076003)(186003)(316002)(6486002)(6916009)(8676002)(26005)(4326008)(36756003)(6512007)(38100700002)(53546011)(7416002)(5660300002)(66476007)(66556008)(66946007)(6506007)(8936002)(2906002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5FoB9oMC9FvV25JIFn5m4MRqyvi+ufudF+dRAFdwoMfrtzsh8YQweM6NTF5z?=
 =?us-ascii?Q?ximcrdqhpyN1+IB87JjwCseS7pade/ui+WkGSR8LN72xLjINrOat0hYaep2m?=
 =?us-ascii?Q?q8883JTHUWg6ncCUd1OmW/7Kc9hgCSxA4pjcqtwUHhA4wfQhUGfv0X6gSElY?=
 =?us-ascii?Q?apFz3+j1MxxH+BmO5nz4uOr/YdUzOEWyf4tPyUqrPE3Em1oRWEgNMAAE3iYS?=
 =?us-ascii?Q?Na/kWGCx+qs0YUHuL+otDur2CNbW6gxcib7b1rPqnv/cIj2QRHfViYnQfXtk?=
 =?us-ascii?Q?bszlpx9Svj+cY6lOlkIhCOYlw48EpRUChS8+RSzlhi4CoZ+N0+ySDZMIeF/f?=
 =?us-ascii?Q?z/s4W6aclW0+Zmx0asQv8U50GaYxHWcLsCg6U1QNvwPJi5dY63ZOttf+f3DF?=
 =?us-ascii?Q?18fVwNAIwi+L47uiFYXu7IjfElmH3C0YAgII3F7EXE+zr0vdyqBkKtdboqNQ?=
 =?us-ascii?Q?aHFQ4HI9xmN7cLeal1SlVWtBomUVh08pXwPvfAIHu+9y9Ylbh8Su21CmeBVa?=
 =?us-ascii?Q?zqVvY7YZmo1N6aLA/jVzxEscpIyKU3DeVJFK59bcJ63qioOaxX3NJ5F98Z1+?=
 =?us-ascii?Q?26X/4tXq+kK/W9SZ3ltg/2UKPrmWTCEctdHnU51169dRrWeyCvgePw3LbYDV?=
 =?us-ascii?Q?s8GWSYNxaVnn2Vi2DKrhPvyVXbySOBq7qYjGxsTmZ1l6vL+rwrc+qHpVl1DQ?=
 =?us-ascii?Q?RpkhHM8A2ZCIxoPMygTy22YICc/23BP/GHbGItHAoDqNoR6+b9nVourmFeMO?=
 =?us-ascii?Q?DNbjoXiuQivAiaQ/fkDr5ax7vz+PQp8KhOCHUy1k1CdX0P9t3ie8/p36K1zw?=
 =?us-ascii?Q?Lli/HdVyaZA21MHm4TudNwEkpPc5n3ZiJo37CQblQZy/2FUWXanIFNmXQJta?=
 =?us-ascii?Q?bTJloW4H6WE1xnw5a6Tj59MK9F7Hsh6YVP43TcULNvz4D0fD6sCFEt94ibx3?=
 =?us-ascii?Q?uGYPZE8qFZa/aZAI2tTLGCsQz2JXxXr47FhpHtZ7bQ9/BKMLBLayqSUWFZfh?=
 =?us-ascii?Q?EV80pAUeUDTmRvrMJqqyIfPkZHGBBGv1Rq1M5hCcwpGzLCBgU1kkhxwiQ87z?=
 =?us-ascii?Q?f3oShTx3IC1Bs3jtH/tSFn3yMd+OLI8LdpxT6P2YppRggAhnl8RdSM/JsyqE?=
 =?us-ascii?Q?8M7FrNa5Y420Tuuch4KjzD5Ch/HbF4lGdM94mcgRivooHdf5yNG9bsGQyadi?=
 =?us-ascii?Q?cEw3DYSeh3wDsFB9hU8pH/EZAWTqbihFE9/J/Xihr1kizPxWLWaz+K+YUez0?=
 =?us-ascii?Q?pZ8okJb1fNzfZrOiFGznuVQeZ0Kzbny3crpvWpzx4P1JtHVsY9JNhEAb/G1m?=
 =?us-ascii?Q?/NlWmH7yWMto3GzQPZip9c9uOx0jjkcF+KeT/fxSX98Cx5sdxG4OUpXZ2Jef?=
 =?us-ascii?Q?ebn9JVEKFdkW34KLBtWpxso131qsU0iaHMKkdU/8olWdz8bmHOiUu8nDRS/C?=
 =?us-ascii?Q?poNqh1C+fjng4vI1szHzuGFTNAVosaL78WBrvYBjDvsRbjcMClVn8y/uqSrb?=
 =?us-ascii?Q?HFnbHqxM6YY/z5SPhhjSybUomk0XDvtyyUeiqZsSdEIctRVvTt+O4H4y6X9z?=
 =?us-ascii?Q?6IGllFiXz7eMpXrpwXib38P9yxu0yWj2PgdT2ClK82EtzQsmxKvUsytgyq20?=
 =?us-ascii?Q?1OEQfxmmKgrwdkuwdlk3mOIcKhLVXRpXzJmad+pFSNwRFPA6dqty8PLPIu1O?=
 =?us-ascii?Q?7BvnD05ScI1IG/9nXWL5y0Dohqrovmwk0gUAtb80pmJyFe4q+tCVFls0Rsj8?=
 =?us-ascii?Q?WV5LzU3L5g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61afe269-7237-48f4-82cb-08da340f5f5c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 12:03:05.7585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLTb5lVn11plH8VLDo+0IYYHZls97gAvXp0zAYPQJsjSoZsqy7suG/Y7iZxue3ly
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6213
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
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

On Thu, May 12, 2022 at 07:59:41PM +0800, Baolu Lu wrote:
> On 2022/5/12 19:48, Jason Gunthorpe wrote:
> > On Thu, May 12, 2022 at 01:17:08PM +0800, Baolu Lu wrote:
> > > On 2022/5/12 13:01, Tian, Kevin wrote:
> > > > > From: Baolu Lu <baolu.lu@linux.intel.com>
> > > > > Sent: Thursday, May 12, 2022 11:03 AM
> > > > > 
> > > > > On 2022/5/11 22:53, Jason Gunthorpe wrote:
> > > > > > > > Also, given the current arrangement it might make sense to have a
> > > > > > > > struct iommu_domain_sva given that no driver is wrappering this in
> > > > > > > > something else.
> > > > > > > Fair enough. How about below wrapper?
> > > > > > > 
> > > > > > > +struct iommu_sva_domain {
> > > > > > > +       /*
> > > > > > > +        * Common iommu domain header,*must*  be put at the top
> > > > > > > +        * of the structure.
> > > > > > > +        */
> > > > > > > +       struct iommu_domain domain;
> > > > > > > +       struct mm_struct *mm;
> > > > > > > +       struct iommu_sva bond;
> > > > > > > +}
> > > > > > > 
> > > > > > > The refcount is wrapped in bond.
> > > > > > I'm still not sure that bond is necessary
> > > > > 
> > > > > "bond" is the sva handle that the device drivers get through calling
> > > > > iommu_sva_bind().
> > > > > 
> > > > 
> > > > 'bond' was required before because we didn't have a domain to wrap
> > > > the page table at that time.
> > > > 
> > > > Now we have a domain and it is 1:1 associated to bond. Probably
> > > > make sense now by just returning the domain as the sva handle
> > > > instead?
> > > 
> > > It also includes the device information that the domain has been
> > > attached. So the sva_unbind() looks like this:
> > > 
> > > /**
> > >   * iommu_sva_unbind_device() - Remove a bond created with
> > > iommu_sva_bind_device
> > >   * @handle: the handle returned by iommu_sva_bind_device()
> > >   *
> > >   * Put reference to a bond between device and address space. The device
> > > should
> > >   * not be issuing any more transaction for this PASID. All outstanding page
> > >   * requests for this PASID must have been flushed to the IOMMU.
> > >   */
> > > void iommu_sva_unbind_device(struct iommu_sva *handle)
> > > 
> > > It's fine to replace the iommu_sva with iommu_sva_domain for sva handle,
> > > if we can include the device in the unbind() interface.
> > 
> > Why would we have a special unbind for SVA?
> 
> It's about SVA kAPI for device drivers. The existing kAPIs include:
> 
> struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>                                         struct mm_struct *mm,
>                                         void *drvdata);
> void iommu_sva_unbind_device(struct iommu_sva *handle);
> u32 iommu_sva_get_pasid(struct iommu_sva *handle);

This is not what we agreed the API should be. We agreed:

 iommu_sva_domain_alloc()
 iommu_attach_device_pasid()
 iommu_detach_device_pasid()

Again, SVA should not be different from normal domain stuff.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
