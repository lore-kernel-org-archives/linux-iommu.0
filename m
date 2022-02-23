Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC31AC433EF
	for <iommu@archiver.kernel.org>; Wed, 23 Feb 2022 18:02:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6CC37408EA;
	Wed, 23 Feb 2022 18:02:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2PpjAqlql_wd; Wed, 23 Feb 2022 18:02:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 05294408E6;
	Wed, 23 Feb 2022 18:02:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD39FC001A;
	Wed, 23 Feb 2022 18:02:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A2A0C0011
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 18:02:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DD6AD828DA
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 18:02:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 27iPOcH00UoC for <iommu@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 18:02:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::61b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A72D282846
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 18:02:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgBxJl9dzMJ31aEfSGEwDTheZq3rQAolVybqMgptU/Yyhhou9V8w48t/3zTQZZjyMDmgHj+j1xenKaJpdCcXWPBEaRcsmdbRko9ogKw+f+FotEHc4W0lN1O+kdo2WABa2iqFZKbCbp5kGyabqrerHbBqZYeZGIcQPktfNDAlad/KgaqmPXLQacZEORNEH1H962Un9eyl8oVDQLeXytnSX1RIiEsucIaIPeeRQIW8YjBvlozn5ErCeC2uu/oFRe7UWJUPmGIQKQIMNcm6rfcK52sgobd9dOLG6vReWcVAg56vNwSAA4WaasAZ8VFy6jjBhwc3L338jaIPDmUrjttS9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3g4AM9cByxCJ17rp5AHZ6bmXXTAvtmB0GIGSMl95+0Y=;
 b=epo6bKqVgNqC4CYLZoUwo/75L7jCWGr6TjZeY+oq/PH+c63cxPpvL1Qymqx9Aaclle8brVlMaTtQwCeUhOmsGKb3q1nXzHt7/4gebLd0Y35FCjy3B+NdpSoGcurtQdvxDif7nM/DK8toJjdgEL5ya0XSFWbUteCRCx0JOLnsCbCQvXILsF4QfnWrZdih2oXFXGlDS9Zx3i+Bz1dalQuOcRTxbnI4Ez6FKL9IEDrWy8K06vtu+4feNOtKSW88vqnDayjZdo0F0ZsTJZYrALFYxJI64YPw5wOW+heJnzUPywpbxztf7/+MC6e3SYO/iB+xXVBJ3rDjnHb0Bi6SlHLhkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3g4AM9cByxCJ17rp5AHZ6bmXXTAvtmB0GIGSMl95+0Y=;
 b=Ul8TIca+IfabmX6S5VeLRtL4sMPWOZsu38z+zir55F2O5tMCZKX1bqeRWc3SB69jFmCaywHU0wEUUbtVfSW1+xmYubP7D6PObli830hJPB7hGhMykdUHyGECxNRL/LMVVoj1qabl06Ng9O/+dTQBuzqxJUYF4JK1EvMArIJXx/sO+tmG2BkEx5F2Vwa6Ft4q9uJgSOtuPEujVff34tXYrJvzzr6erS56vltYvGjYEYUWtmHh/nmDt9lgqzXhiY6UU3wPSLYDth2zgZGNz5T92TMKA7dYmWpJaEku29ovRE4l2l+HgfiClDfAPCUseXY5qdv/jHOfWjty4ga/Wconxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SA0PR12MB4542.namprd12.prod.outlook.com (2603:10b6:806:73::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 18:02:45 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.5017.022; Wed, 23 Feb 2022
 18:02:45 +0000
Date: Wed, 23 Feb 2022 14:02:44 -0400
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v6 01/11] iommu: Add dma ownership management interfaces
Message-ID: <20220223180244.GA390403@nvidia.com>
References: <20220218005521.172832-1-baolu.lu@linux.intel.com>
 <20220218005521.172832-2-baolu.lu@linux.intel.com>
 <f830c268-daca-8e8f-a429-0c80496a7273@arm.com>
Content-Disposition: inline
In-Reply-To: <f830c268-daca-8e8f-a429-0c80496a7273@arm.com>
X-ClientProxiedBy: MN2PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:208:d4::41) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6c71bf6-ba50-4fcb-a11a-08d9f6f6b1aa
X-MS-TrafficTypeDiagnostic: SA0PR12MB4542:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4542FCBEB5EB3D661EB7FDBDC23C9@SA0PR12MB4542.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TdMa0cgVZF5kEoZ3d/gR+bVUN72Xe6yLAKXP6xE9g4BsixzakpecCA4AS7ANOibneiRl70e8CjQx8Zk8PtbslXYqSd1t99N90vMMHVP+X+40dmk5E+mSBMDc6gpdWyxrufwXQvx/RHqMiWg9XKSK5dc7dLu19SDJP+hEOA/4cqYq6IaXRKJQZtb7Ff+5y5JCTKetAUSG3ADsrznPoiSa1ecWhIo9nz3t0apd9Jf9ScbafUItRH5f9IEuUWMBIMflR4idyF+cs1thSDsQO7U7vsh1JMmeDs0YIoWhbflMrjzFW+LymtIrSBigNQmyYVYAkHfBxNjbG7dZYtTdTggvWyMKkkymJz49K2iQsI51nTW1hxr85WVD2HZialVzLzF+kgqZNsp2HlNjvGUXi3+HxJqCH6IrVHk3Ch7PGR7fSODTOJeaACKUmubeyEqICfL7g9dvtqleerURHh9qrJakrccNZDl/wLhhOPBqQvG2wz2eW4g0ovcjLkqOiMQ3Oy7wMSteXkU7nMgJLaAkAVdr0tB9EFu/oPR3+7PyoNVwveUU7YjkpC3i9oTY2ja+CDmGRAfsxsOpfvXGIDXlZpvSyuBxNEJXUt+42SqjWnf6IA08yhLsfvwLk2WWMe85zEf2QbuoHT65oNHnHq5CybURRIo2PnLVAtBrG9YF2yjriz5SO/I3vTPIP0Qpr3NnHBXE9rXzafvDgWQHA7E9HhKnTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(4744005)(4326008)(6506007)(6512007)(5660300002)(86362001)(36756003)(508600001)(2616005)(2906002)(186003)(8936002)(7416002)(26005)(1076003)(316002)(33656002)(54906003)(6916009)(8676002)(66476007)(66946007)(66556008)(38100700002)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ai/v6zAHKGrVbPy6v876WjOX4aJ3IHK+p/E59I5x3Q+GR9k+sV1mQy2KRRJz?=
 =?us-ascii?Q?fUBaEgFWzYQF6W+FiZznx9kKCeYuzh10feH9aC1jmN4Xf+OSKyLbzGkXLQxX?=
 =?us-ascii?Q?LL3Kc5Bkk/lFc8pJNkkoPjX7gzx0CFNQzl4VOwSQbvwU53mN+7T/KQaTx9NN?=
 =?us-ascii?Q?/R2WjY7QigocTJtsIVSwPA/AVccxjXdp45KH5tHPIW30SGGfU+jUZrz95o9D?=
 =?us-ascii?Q?zelQ6cgHvxUZOwTkXKNgkpT7sPMd5yBdd6VFe/SeT26ofi0XfsYQQmZCtWsC?=
 =?us-ascii?Q?aljv8TWiC+uI9wkEJNGzObRjckZNhiSaMM8WHUItuY6UxmfWsZcHYIrAtyAo?=
 =?us-ascii?Q?YWUiaAQvrbJj7bCTDmriX5Gcewv0zAKwb5vL4z97YPPxBlNmeiFBgUVFyNyA?=
 =?us-ascii?Q?NThFP8FlayLIxVoUPYgbm26ovirQvAFAEcR3uQGQoVz6qx7Wxi0n9j/9Vd6l?=
 =?us-ascii?Q?li9O/efbM5/+bK3/Ec3DKxUe0mMDBL0u+VbinoYXbahJtXEmBiNtMPsGF3EH?=
 =?us-ascii?Q?8xGyAq7Jm89gxOsArFE/wesVY8GHcSYLZdv2O3+U4JxBq8mwyHmcjV3ElPJW?=
 =?us-ascii?Q?I2+4/zZaxUXvA6cDpy7yG+2Znb04855e4lIX/QqkEIEdaeTQOeOGe2GlvTc4?=
 =?us-ascii?Q?OS0YtUmtA7+GS9Vs7jRHV0QzU+qjqqOIv7HQRYL7gWx8I/OA+MZ4Qfrn6J0s?=
 =?us-ascii?Q?lp2uZl9gGMgXJXpk3c30OK5vX19MQeSqSqhHA1sDv0g08pNVcK7Q1Vuntusj?=
 =?us-ascii?Q?JzWeOpF2UkuGgSEsHnt8baxN6LQb7K4T9HPK+kXbR4AKF4tf0zTRkFJ9wHI6?=
 =?us-ascii?Q?IT9BPIrWMzieBYaTb5SfEPfLWegkf2N6UNhHNxwG+95PLYDtCqKZqMjR26vn?=
 =?us-ascii?Q?ENsp1A0KNkQvGPk+NAl/0M8saU1rDJ2kyFOZSLDQJrQUZQKA40RYGONW/JCu?=
 =?us-ascii?Q?RIQjiedBGwpsA/oMu/BrA3UZYNCceDuqfasRWo6swThbsLAJSEce1Tjk8Sap?=
 =?us-ascii?Q?IcoLi1lijXedsbMjt/1wYxBFrgUhAI6jlmCmWv0jdKDql90fUFnu7d4VZ7vl?=
 =?us-ascii?Q?UhvL9EhhLV4399zCGLJ2aYyeDcRubfLgVIBWC2uaQl+Dit5ocXyDl516+sPb?=
 =?us-ascii?Q?ts3GINieePYDwiAmId4Y9PvqO4zynTkMd9MHtXGGbSbcK23h0sLPT9mypi1D?=
 =?us-ascii?Q?fVMupUtfGZLeyXYRQNvBemm0pdGLTLvTwOvKF5gTBLdXL0q1MofScNuqDn1I?=
 =?us-ascii?Q?lwMTkdUeucbR07Wm3CcfqxjYfvEPpgruh84DQj9DMi2oMM5ct/sHXNEF7cjo?=
 =?us-ascii?Q?LgHUgQHAp4a1UFKYK2K5gOdyUSfqNQ8ZaD0TR0X87jOm7AU2zYPGo3D3/Was?=
 =?us-ascii?Q?TSLA8zftohHCkU7Y6NjtqsE1iwu7SX76iZISiVDfHNiIuhamT/RHd3G7CXxW?=
 =?us-ascii?Q?59WrQAiqnwO/bZkzxdF0rBIN3rn4SToErl5004ubV3fLfx7egptQFEn3U8PE?=
 =?us-ascii?Q?Pp8/QPvERC+KIF3IDO2kDGWHy53AxDrNtkPEQnPUCCvCXwl4Uu1XXtw52NZi?=
 =?us-ascii?Q?S9aVpTXcLDjspvIba4w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c71bf6-ba50-4fcb-a11a-08d9f6f6b1aa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 18:02:45.4022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQYeKOi99G7AzSQ0D7uJzrzv7yhdogu1acN7H4FUe2/U3G84c8NSp5r6XLUTbPtX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4542
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
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>
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

On Wed, Feb 23, 2022 at 06:00:06PM +0000, Robin Murphy wrote:

> ...and equivalently just set owner_cnt directly to 0 here. I don't see a
> realistic use-case for any driver to claim the same group more than once,
> and allowing it in the API just feels like opening up various potential
> corners for things to get out of sync.

I am Ok if we toss it out to get this merged, as there is no in-kernel
user right now.

Something will have to come back for iommufd, but we can look at what
is best suited then.

Thanks,
Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
