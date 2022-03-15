Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CE0C433F5
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 23:05:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD30760C25;
	Tue, 15 Mar 2022 23:05:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cEoUaFz3SUML; Tue, 15 Mar 2022 23:05:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 461AE60634;
	Tue, 15 Mar 2022 23:05:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28106C001A;
	Tue, 15 Mar 2022 23:05:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36C5AC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 23:05:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 20AAA40132
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 23:05:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SCdee_CSDqyM for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 23:05:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::602])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2F70E40103
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 23:05:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbsafCwHaMXNtkRn1GiMeieJWEBZNbFZ06JQ4CRHuRVnNZpK1MnkEKwsisq7W2Q6BVw6qntpIhZmFQOpQNrfVAxd8EvZc4GX2MXqguhjMNfLtXXRLEgi8c+JDf892XqNeMnHdglSGtGTJRLOxGTf5GbJIh4Q6hYPZiinwwmMDv607u6KgdZpMJ645LiMc3wPBgrfEgEyEismle7iSp3iix7tkLWtvSLZnQgqHN8rvWf0OkI4wM/7U99UxHpCILfHGgMN8Co1reoyyROjbUKdSZJbT7MNWZppA0Ypf3ZD+yLAfXE+M1mKveo6AudxoW0XbHm8Pvu33ZydmVkIFviPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9h03Dd3u1kYT9O+gSs6/yCSyaTidz1oKnE8UVwoKxWo=;
 b=CxhNCOmD5SrjMpPQHmkaer1nifV2rLUNln8qIlTMomtKZx/H3y2WB3mZh1TNlG81cjwyT8XRRcRTO9iBbMv+r2D0kY0cnkGPVndlCicjWpCHAaaz+phnRwBipiWKmi+FvPcDyMbtudlpeeVUP/fzOhbtpyqv/5QzN4S5KPQaYo7EvN6iEAdTwGmaXqhO7bQuXiKd7BM7lIytW4rM7VxmyckHhq9TmcI/XAewTHs+g9c/Fg8ya4iUvRDxka0wDLq6gh0w3h1AQoTRX7BWBl4CPQPz3fxbd2euzbshfuHXVeN+9wuMBE0ZCYLheUXEoyynhNpMPfg+XANM9OphE0nRcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9h03Dd3u1kYT9O+gSs6/yCSyaTidz1oKnE8UVwoKxWo=;
 b=XjO/LNQhR+jtjaedmy0FpVTRvtO7XwE46QFk5ZmPOT+hMKf88xdZpNS/Yx2lpAksJsSXcEiKXgQRzEB8PRwlZq9jY2krC2kRQcZrBRSRKmmiXU8PLuKUNUzyqCEUdaLbexrIFlf6c3H6ACqTpOO8fQYsAtcsEAJkMSkL/NY9rDL5EfPkD1zVJ+Kgn/V0x3KALmIFErKlz9aSVkoyi85CUD2xcNaKEUijU6MfFS7p2cK/U3utV+WXPQmlRP9SehDzONJ/qzMsjBa+MngZdUX6+nM61ccfjmNQq2SFoLSb/SaT1VJhkcN9wMnSONlSgV0ZL3KHGxTNqqgAPNptA1sq8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by MWHPR1201MB2558.namprd12.prod.outlook.com (2603:10b6:300:e5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 23:05:50 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::9ce9:6278:15f:fd03]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::9ce9:6278:15f:fd03%9]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 23:05:50 +0000
Date: Tue, 15 Mar 2022 20:05:49 -0300
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 5/8] iommu: Add PASID support for DMA mapping API users
Message-ID: <20220315230549.GP11336@nvidia.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-6-jacob.jun.pan@linux.intel.com>
 <20220315143535.GX11336@nvidia.com>
 <20220315093810.4b4c5ebf@jacob-builder>
Content-Disposition: inline
In-Reply-To: <20220315093810.4b4c5ebf@jacob-builder>
X-ClientProxiedBy: MN2PR12CA0028.namprd12.prod.outlook.com
 (2603:10b6:208:a8::41) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96029072-f972-41b0-1593-08da06d85925
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2558:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB25584401C37F3DD41C3E04A1C2109@MWHPR1201MB2558.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sY9vWyHvn5/wpQnDXsnKH0YpeLGiIU/GLo4U6nL0vJRueFomRjlX8PGM+AjKU4x7OtuLSWMzRClf3qUTtrO5Es0lCDQXjGeeCqunS47BU9vETkgD36jXAp9N+bo18us0hNHJMxxV7kHngMAA0ZPlxNTylxsVzkKSGi85A38LDdYM1iE2ZsAszGku06D7eLWtXhLiv4zV3qoF3QFHQNQFdS1f45GR33319QXrYJIGVAs5WKaY0kiBGrisrSxtwPPyQAINgQYeRxmJagY1FxpcJ29Eu6T788mFyM3LA0/ckZGbamtmUyx9uvUocFo4K/vPCFRFb9bajzvTUH7HHuI1Wxa9PGhyb6+q1MDquiFBKdosgmkcaUMZFlOGAYJrImDnfA50VAj81MfPZcWAq9Sr9J921Xob+3FQ1K9//+1DlmG054fzOgiekWnLhT6TMJ/W81TtPRUZ87YBT1Y0R7g8v7AYr3oj4guKcdEtINOR1NWBr7OLRaNBCg7/ZrDMKaFv0vY2s1A9xc7acYabMgh5tCA6WzQYNIwfwntKGzVc5l2AV1nyD0Gtad4cYx5s5eamHrhRs4hisc9s2Tgv68KMCVxYKNLfyvkeOxsy/nwLBl5QwqXPm1QB+8vlbnMDdKLlxaebup4SrQqmX7x9IuDL38foq8LrNzKk6jaRu4wubYUU/6dcu7g6pNMNw+dM+Ie5ZRPO2d1trX+YmW8TBJvMTWgaH/xbBgTKlR8ugqaav7c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(66476007)(66946007)(66556008)(38100700002)(8676002)(316002)(7416002)(186003)(26005)(2616005)(5660300002)(8936002)(2906002)(1076003)(86362001)(4744005)(83380400001)(6506007)(6512007)(54906003)(6916009)(508600001)(6486002)(33656002)(36756003)(26730200005)(19860200003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KiXI/WBgXyf7+3Rk9PaCrK+xtJ9TFlRwqHLpuaSugKHaQsdUrWoGA+8O6zue?=
 =?us-ascii?Q?QESSRGdAMy2DsLLwNH6IJKWh7Qm2TTvcve/c4SS02JVmNWwCFvwQ4rphSGu+?=
 =?us-ascii?Q?BWDrHqnIDi5c2Bje4IpgrNPv9dCHMAg1ar+WfCWwaqtD0JCknk7bGR18k3W3?=
 =?us-ascii?Q?a0w0BQZtpu5oMJYWsfCpd878O5Zss1Slmk9xPIkvTh7VEEfHG7LhiiN5XpIQ?=
 =?us-ascii?Q?CVKa/hV4ENnhSLwMpuDGy3Oj6Iq3WYYtwgrv3BXUDm4a/AKlW5gC6SYWamxt?=
 =?us-ascii?Q?CoZlwIu3jdyqUgV9T1FV62Fg7wpZzA8abE0iwvIxMrBCjXRS9nc6QwYIe+Nz?=
 =?us-ascii?Q?m1ez5TALjTLr++VWoNO8NLrsaXdOkylb1nziiWWG7qcfe3+EKWyRAXH7zNbo?=
 =?us-ascii?Q?PTnFIvAYtdsu1prJIKkHHDbr9/NHZ73Z3EzEbjmZWEBAJ4IORXwIpo/+Ugme?=
 =?us-ascii?Q?a+BfHw9LGjqlMx64T4oQ1ApOZjFZO0qTjGFJYVsde/Ulh4P4xUGmZzXFePVR?=
 =?us-ascii?Q?WzVugdNAh/mI/BRUVi42DYckKm4sn9TM4ykh64bWhKB/cmnUADHAZEHUbShh?=
 =?us-ascii?Q?A7tqqJEzBPHi1CH8Scn/uFIGKIRzjMcsBjchRknh9R3Avn76dpxv5b5OvKyV?=
 =?us-ascii?Q?li05K1MB+Z68uzd8fV/nKsnsP8H9pIqc8SZ+B6wiNGm+mctU82Ba33JfBLEa?=
 =?us-ascii?Q?5z9plbHTmmUQOrH8Jo/4xQKCP8+3BNYjwDnDFsP/lhf1yW9FGIJTbpk5gFBX?=
 =?us-ascii?Q?KItqiMQyvpn4C/dST2UDpJvbxYxQGDd3NOERnpWUjsBJKMQKYmXZcnx9WSel?=
 =?us-ascii?Q?ILv2NUdLCV9+VjELJnKAUWp3Oylhff2nVA4zr5Ghc+DL3TTVMqCbCK1QOBhD?=
 =?us-ascii?Q?bE7ylDcKSkuAfPZRpJNhx2zk9RZ0/B/1R06vjK0XBCANZoixMAPP4fShtDGR?=
 =?us-ascii?Q?y9uEKy9hMO2AnJ8jgJ+1WyHkBXpktesKPVzxPNJvzQuQDHYq4Wj7Lt9O4RR+?=
 =?us-ascii?Q?MCrr3XU/glSCaVHEElaPHLZawmeK142PPIaRrukaWDOx7nsxvr6s0KL05RbX?=
 =?us-ascii?Q?b9v4bZJKA6/wW0W3fntGxzjwn25uXMdK1WMe2DOvi0OQCY1/sK9fEeT0WuL+?=
 =?us-ascii?Q?WjjSAGePQKNuwiH2Y/mw00uDhnM9/nRJzZ4klBtqF2aHfAcUx99yO4Mv/4mZ?=
 =?us-ascii?Q?bWBzwmUtD+GXs/b+xfjBTPcZ+Bmyw8BcL/srDAfWrz+dle0SN4WzxhIpuJSy?=
 =?us-ascii?Q?iGpFcWWJVFcBwMcl3eRlxhWmfBbUpjX43DMEimHMaKA2azy62HJPcHMIOiiB?=
 =?us-ascii?Q?qGHbv/NStXhcKunrihBQPEKxeYrZ4x3w2Di4S0M8Nc0bHeqa61K+ZnATbg1Q?=
 =?us-ascii?Q?aeMYhGTL+wh8rroZzlQBcQZ4ccayPl6NdXrXHbX8QNs68CLAI6nFN2bMTtXD?=
 =?us-ascii?Q?1/eR2b9RSTFslqBxjAe82MJAU4dQcm9M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96029072-f972-41b0-1593-08da06d85925
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 23:05:50.6057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PvRoNkV1K240iGXxkScI+VG3Trsc3H+t5icdy0KhLMbRo9mcVAMLEpsFcqZqU/Rc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2558
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Zanussi,
 Tom" <tom.zanussi@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, Jacob Pan <jacob.jun.pan@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
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

On Tue, Mar 15, 2022 at 09:38:10AM -0700, Jacob Pan wrote:
> > > +int iommu_enable_pasid_dma(struct device *dev, ioasid_t *pasid)
> > > +{
> > > +	struct iommu_domain *dom;
> > > +	ioasid_t id, max;
> > > +	int ret;
> > > +
> > > +	dom = iommu_get_domain_for_dev(dev);
> > > +	if (!dom || !dom->ops || !dom->ops->attach_dev_pasid)
> > > +		return -ENODEV;  
> > 
> > Given the purpose of this API I think it should assert that the device
> > has the DMA API in-use using the machinery from the other series.
> > 
> > ie this should not be used to clone non-DMA API iommu_domains..
> > 
> Let me try to confirm the specific here. I should check domain type and
> rejects all others except IOMMU_DOMAIN_DMA type, right? Should also allow
> IOMMU_DOMAIN_IDENTITY.
> 
> That makes sense.

That is one way, the other is to check the new group data that Lu's
patch added.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
