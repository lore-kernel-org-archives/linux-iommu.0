Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0737C433F5
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 11:51:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4581419EC;
	Thu, 12 May 2022 11:51:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z2YOu6iDcIHO; Thu, 12 May 2022 11:51:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 599F3419E0;
	Thu, 12 May 2022 11:51:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 320F4C0039;
	Thu, 12 May 2022 11:51:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EFB47C002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 11:51:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DD112402BC
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 11:51:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IJYGUVDvpKBm for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:51:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::617])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2327B40025
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 11:51:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Co40mwRjz9rscz4d4wVCYbL2PJMHfg7Wg+cRSEg74L1b+hp98BDiVMf/l/tsuNpJ3RkRT+JGhUi7/5/cpstl9u3pcDUZoFo+QmgyLkSnXUovsTgcESChITsiPOMy3gJiGTABcNNWgaw4AYsHAXd5afTvpu+tB/lmuA77uPyLjxFh6O3TcrRy0QfGdtez8hmmuNfxhLJSOMi5CbFgfm8zoJsIOvUV/K7kDY7k+4o5/S9xihLE+LBbkAMbvs7OUQGN9yBOkSTQZ2Qkn3gGSwSAdPVgeE9N3dpai2OTKpCjJMJupRiP4STmaImLR7u9DNzz3JvghO8cQ9FSzJSlKV6O8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsqAcW7D9oinbaW1fqWhPoUMRQR5yDbASoREakkB+hg=;
 b=TtA5Lc8bO5z7CPHcbjWWO+NyuiG1P8Rm2Wefw1I7a1ZZHcd2uzR8fJ8ghaW9izINFhADJdWOj4+LJYHzB3vEjHjT8tavBKWLciqfR9rV39NJu19F2VMkmraq3fTgo/Q6Bzq0WPwxAu5UWL7ZeN5errtpVSiF0wMKixQS4ov4IPJs8mv0VrIPoyuoOl94FcXZTymZA7Wb5oyhL8rfJEip4d3SJ6QJWklx+VIDImUFnkimrqcislvxasGbVcUlj8PmgeObHG9srsq/6yHQCwulSOaGe1k1zt9M8xzgjMvWD7thPHxfKuJxIgzfiX1hnzRyu4ogbrrpSA+AOyNIjRGWXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsqAcW7D9oinbaW1fqWhPoUMRQR5yDbASoREakkB+hg=;
 b=P/vUnElUWCKHKan17BM18jXBmIqE8HXCJ1jGLJH59tvV3GoDatulFg8S20gQMNkZojaeyJ7zhlpBoWf7eGhCGudwgEn+pvSiOSuUzNBIEFLN76PchmKLRrI2BID8fLo9TH40DUtrsHfVe9ZxjThkY8cCATjJv/kT+RJU1zFI8FD/Ap7VctIo2MmwOv4zISBEWOcWRxWq1iKKssw1gEEmOUj+zkjmQXyRtTqU/nrYexVGJKd/GV3ufUBwbO5dTLYiS2rfgvJSCqmRzxA2wTgOk1CxkVef70PCl2Cgq57uRRp/Gu0poFEssDlIUaOaKFLz21FcMdaoSwBiKsiVI2wcAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4893.namprd12.prod.outlook.com (2603:10b6:5:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 11:51:03 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 11:51:03 +0000
Date: Thu, 12 May 2022 08:51:01 -0300
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v6 03/12] iommu: Add attach/detach_dev_pasid domain ops
Message-ID: <20220512115101.GU49344@nvidia.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-4-baolu.lu@linux.intel.com>
 <20220510140238.GD49344@nvidia.com>
 <f56ea479-aa82-37ae-91c3-754816a4ed8b@linux.intel.com>
 <BN9PR11MB5276100AC9BBB7DE5CB800CF8CC89@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Yntrv+nq2t/IeVo2@myrica> <20220511120240.GY49344@nvidia.com>
 <Ynywqxo4P+aEeS6c@myrica>
Content-Disposition: inline
In-Reply-To: <Ynywqxo4P+aEeS6c@myrica>
X-ClientProxiedBy: BL0PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:208:91::18) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c974da9-ef31-4211-3295-08da340db0c8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4893:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB489310EB39B05BA1C812F944C2CB9@DM6PR12MB4893.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WViOGWyanLRRr6OVtRUFEflN63cT7f03s2NdurmqJJovtwD3AKDQ0ztwhEVsM4WvYWkhG7l3v5rzPM/osShwWi7hHiOZztjBpgCy98ShPxUJqXU26FJi+iWymm2X7OZnqWq6n2aVdBDsfoR60DGLyiOhPHA5HIezsiW3dRzFxLImJhIY5D8SpfUHcNlnTO45Qo2JxtEUIX2n+TOhOS4KMHU7EP04+2N/ETcAbA6pRZr5aeJJFthIvkDdeS4HG95WF2RDny3g3XKKaP8Eb+bgjJ84KLFgTfUp4+AeAjlvoibhAWp09j/aJ+FIDERqP9qZtI2YeB2CRytuOSzaeVE/uTst1W0gcF2sel4aKSHSEt0GIJVfQv+NTsysQcPgM8Z8vFGSH/lvc2b4te913d/hiHmbADzlgRu6WUQLMPTPYIV1ATH+HuWoRmSv0c7VJ4Tv0AeIVjHcYMMZMZqYXG3uQnMEr+dyok3PeYM6RSxCQq74obRZJEh8AdIgUj5S0zVpgh0gftyNLpq/SOOe4thtD97UPvWPmfqRdlkErrY5MM4fGM3nVLvs0rBm7htkrpTkDl95xNGBbiG52k6KcqhpLI1l0ndxpwJ7JLQ+t5o50wlZpGxbnrUbUmjTdzzdkjPJ8SqHFoqu84qPneblgsahtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(4326008)(66946007)(6486002)(6916009)(508600001)(2906002)(36756003)(8676002)(8936002)(33656002)(6512007)(1076003)(316002)(7416002)(26005)(66476007)(186003)(5660300002)(2616005)(38100700002)(6506007)(86362001)(4744005)(54906003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z4emeG/Y4sdDgMLtzpZZ7FLSV0a2PIPbNMW0YPsvvMzOR9jg5939gs/atwfF?=
 =?us-ascii?Q?DXBxddVJAfomxfmxWHzXOQHACq2WFzYc6+RUCYrXQRKzSIJcWSbhxSoX327u?=
 =?us-ascii?Q?AFaZptydJ/AJMLDoQxDpuzq0KgmEfuSzlhljfA4GVKYzhFOuGapZxW7CtKSI?=
 =?us-ascii?Q?LSPFmHEMt6SurvAQ7isCiFAzQWedAK9El5GOtInKMIzVvlzL3hMh1L5s8iqu?=
 =?us-ascii?Q?9b16cJKjJKwdKszYziwq+Ez7/j36SImAhbZJh+ITeiwJHQ+OWkDvvLRGOnTn?=
 =?us-ascii?Q?Hys573xpaIR9RB8klqvvdBHMV6h3FFbG7r/DN8GqHhbQ4oOIvPtAe3lXLCde?=
 =?us-ascii?Q?fZL9wGvPtOGkx8G7XW4S/S/BZD1rM52l2GmjObxCRitbst29hwra1boLnzIs?=
 =?us-ascii?Q?cYJddlkwiwNG4bF0qNPBkULnaenL+p8PhDXRx2TEi4c4g1xgvO5kMcfUB8Th?=
 =?us-ascii?Q?G85n24OlXKyqh6Kttu2KQM6j7fLVunx60TsmWUNc3q8ULSSZZJ6d26vAcJ0T?=
 =?us-ascii?Q?vcmP6qGoRxhSt+WQNhwcWfE939OMO3YsJO0HNyccFjut0yqOtBxBIT/vhIh+?=
 =?us-ascii?Q?eQsJ/Qd8e70Z1ps4ZKPQAkD13M2yiMiKj8ppaWgu48YT2BIpn8KOxejHqu8A?=
 =?us-ascii?Q?+txbvjquPew3Cqq++cKdAT6TyK5Fz45JadXDm00Y57PwUYYumSchMdk1pxjB?=
 =?us-ascii?Q?aUg2N4d0D5fEqIk7c/IDxw9uKPVBmaik7gRUX9Dam3zgPkOJQBBLRHzl3PoZ?=
 =?us-ascii?Q?H3DtU/KK2o2QDxnvz7DtBGReEnUnbJX44AxOYLT59JcH2EVsbhgUN6IxMjjx?=
 =?us-ascii?Q?2uTPYOLdlNF6vzIvgaVvkJR7hnGblmFN5YfVhgU4XVlnUU8ypYR2nWaN3FCc?=
 =?us-ascii?Q?GCBwwHU/EM8dqV8AoU0hMlu2KvT8a7H+JfRhw8EVbS5eDINX4CCd1NerPkrh?=
 =?us-ascii?Q?lM9PaZ10i188/1TYsL5BOuBo2yWFdm1lkhqq/Y4Nqx3zpnFGOrnvAJI4QDCv?=
 =?us-ascii?Q?rt4K2AI+MuP8yZrDSK6ytt1ntlhq7g/qzTBy4kTf1Wx1l0CxZBY/Qx19E9q/?=
 =?us-ascii?Q?JnZ+uGgvXibiboJ6k+nEG2F1rztG+jyPIiJA0y7tRhmhd4wUhIcVHVc1vdIi?=
 =?us-ascii?Q?9B3okxVCIH4S6PlriPMfsqPT3CRCeVxwXKsVCJHnyWKsF1YnhDRSSHLEE1Mi?=
 =?us-ascii?Q?U6bP8d3Q1w+lUXVBkLons4JVXHJWzDnYIdxOEu5omlJsHvas5a2b2L1aoTVE?=
 =?us-ascii?Q?ybSOtygXou4zZFIO18qcFq73s5+kOKk9gQ9mEW+t8zkiYEhFgx2Pdiy11xlS?=
 =?us-ascii?Q?f66dHFkjZL9VAST1Tc8R2TPneFvI4uA9BaTX5H0K3XQID+0zbRf33xfQINId?=
 =?us-ascii?Q?+9E2YnZHaxCLxU7u77Sx4s5PImiaLbiBFbUB59Pv0hnkr4l1YrWqwDUQmLX0?=
 =?us-ascii?Q?L+mtgAEBWZh8dKEw535klJDsbhpWIfaLzW6oyuUnPq571mnyDHcCsMeTL78Q?=
 =?us-ascii?Q?MzWvfBVz7NacAqPT9v7NRYkBt7zuPy0VwSY9zSNifjpcs8n0mkjem1jkWV3F?=
 =?us-ascii?Q?5EyQWa/L8BmHR7Y+XKslt7Dq3txrPHwwXCGVhB+BNLrbvtAnAnDg9fhcowPp?=
 =?us-ascii?Q?oq0e1LO2JTAXAZUKUsNVodxWPHnlHjDkKrJMSYocdUkHyBLFlZxPYYsm1lea?=
 =?us-ascii?Q?T6tV/L7ladLDgmPBfj3xeQcJdv/iyYIfxvwYutZrMO66MFpWN2g3xklZLEUT?=
 =?us-ascii?Q?nqbvhJKXxw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c974da9-ef31-4211-3295-08da340db0c8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 11:51:03.3819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzMDfUvc3IBtulv4z0uhetqcJkvVSCnvTU72z381+XXJ0fICX9XTI3GNpZEyVRAP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4893
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
 Will Deacon <will@kernel.org>
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

On Thu, May 12, 2022 at 08:00:59AM +0100, Jean-Philippe Brucker wrote:

> > It is not "missing" it is just renamed to blocking_domain->ops->set_dev_pasid()
> > 
> > The implementation of that function would be identical to
> > detach_dev_pasid.
> 
>   attach(dev, pasid, sva_domain)
>   detach(dev, pasid, sva_domain)
> 
> versus
> 
>   set_dev_pasid(dev, pasid, sva_domain)
>   set_dev_pasid(dev, pasid, blocking)
> 
> we loose the information of the domain previously attached, and the SMMU
> driver has to retrieve it to find the ASID corresponding to the mm. 

It would be easy to have the old domain be an input as well - the core
code knows it.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
