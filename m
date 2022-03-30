Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBB7C433F5
	for <iommu@archiver.kernel.org>; Wed, 30 Mar 2022 11:58:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6CC441B88;
	Wed, 30 Mar 2022 11:58:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6ktuk3buwJtH; Wed, 30 Mar 2022 11:58:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5EA5841B8F;
	Wed, 30 Mar 2022 11:58:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33C35C001D;
	Wed, 30 Mar 2022 11:58:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56B5CC0012
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 11:58:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 40EE540CC7
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 11:58:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eGAGAj-w3niy for <iommu@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 11:58:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::624])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 03738403E7
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 11:58:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlVyuW+2ATgriJEeokoQhmsKOIUdYGNddqspXKyZ3JI9lux3EiLTde8N3Lmi/C3l7gLfmLJnEfX2gMhPpLWjVrWNXJyxp49krXjLwzMwA9GXOWX7doH8jhZ9BWi4p4YjyikksZxA+DAxDAGkjRqLrb+4br7C+O7JRlKuGZdnNH25ZCMdcx1zC5sBXwjD2JuVQ4Ra1ZigMVA6hid9PZHAdIizjWHEcOTx7/XiPlGWn9WcEBOJUzw1ahD4Pnkne8JQQrWpGUfRsrU3eUyEmoLRqEyfUsFPgMyu2gKyIbAdq2wxxdHvLtiDBj0qHdTRW/77Jo9sl5DxFHu2x49BuKnIFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ND3rsjl1rzAIzwmN/rdQLHCsGBUnILNHQvNxwpCWXNg=;
 b=lV9FeC/kBP1Vd+KuqHH4dLU8c9/oMcaqoKtnmZ3kJRErTwoFvETQobeMXf46i/wI6j6PBrdUBfnd9GLEMgSCe+WRG+Szoc6ibRJYdj75ZXFmXPrnVK7mjaIchAqWrcVzHECrl8ELz34cf37s1JhNtwJn0ix2/+fslg/CQE8+Xi2Ar2UdMNzHQf6tHJVpLoVxDFn2IOcJ6teIKna/uhCg8UK9q4J1LyP/tTGpnIYZVKVoy/Z4OgnFg+fRjFjQ6V0t7XmTQZ0jWs6/4GzscUTdoQEUqu0bdhefZHNnu6VbVPNXtS8H6HsROFlSm6CDCTKK2/olxks+nihacbrGCGCUmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ND3rsjl1rzAIzwmN/rdQLHCsGBUnILNHQvNxwpCWXNg=;
 b=F3dRLHgFcVgknQFY5txi+Zq+GB+9Jp5cKa2TC9NjzayIuKH1p2bdAVVuxXpSyFHL+TGZKkwytEBRx7lcOhXWYydC94yKeB7MIasCHWB9+1l/t6zKrq4sNy4anT6TxfgWA6K1W4Zcyol96b9iPJjRVW81W1IuIyv3sgEjAe5Z9g8Rck41Kbl9Ctfmonyj4Sf8Od0KiNlcFUzTKnfPxnESsSNARM3tJ1ftg5jKAZ5hFs3nH9qZ4TB8q8GZNpLNhcTHzT1Sep9E9b5qs4GFnszyPKuWin6TBuEiK5zb68JwCyIOEf6U4JVB1qo6GOXw227JqylBwr++152zRbbi91cEzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by PH7PR12MB5999.namprd12.prod.outlook.com (2603:10b6:510:1db::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Wed, 30 Mar
 2022 11:58:22 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%6]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 11:58:21 +0000
Date: Wed, 30 Mar 2022 08:58:20 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Message-ID: <20220330115820.GE1716663@nvidia.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220329114259.GB1716663@nvidia.com>
 <BN9PR11MB5276239993592FF808726EF68C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276239993592FF808726EF68C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::24) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c86bdc98-a12d-4f4a-65ba-08da1244966e
X-MS-TrafficTypeDiagnostic: PH7PR12MB5999:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB59997ADFADE3D2A11A4C5268C21F9@PH7PR12MB5999.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t03wYRcFoXCNx+GS4icUW4/TVDyniq33w+gWYkBhxjjGFnoAbLDDlqrlSofwTOrO7XXe3FgaHsNZxMfmBwUiiKUEFrAGTdhX6X9HPYhXAyhqVewF/zT9yY/RgJlvd/m3AN0+DcBi2cM6PXe88zlQXsFDfsv85MV0QLH6GFvkQ+zFqLETL14GM38+dekFpbqHfK9vADS71QoGBa+3elnn0OJfaheNuu9nFJW5YQ7kY+Nb+ntSkpTfZuSl/824dKLtzJUhjNBOfxUAlviA6VqIc1KDudluD/xEvaDyQCMaNT3hpm+wJjSLxtzvDpvdnrA7qOQk8ke/BIO9SBry4JX8EkWlhZOYqhtUQSHesEH4Z8MtbHoxATvqbNZ1Pl2POARYY1V+LXU8qt6OyrSv5VVSG3sXCCJx8ia72KTqyO7ftl5aAVBREBXwuDknMXYHzVgSlTVIfFtnaH6LmcaBct7x2+2cMA5bDxYYR3AbIwapjGuGHetG691kL0drBhVJRAoMaCD3l0T6GttnzRFd16wJCZZQLvgVW4p/uC0duxSD0R+IG/Sh48KwYYTTUSJKvwp7Lgc+HzYDEYCFZznjieynvP6a6iWg0wUavck3SkC4wdee+ivjeCGro/4gs+xlB3UdmgwMaVRl9Td8AxULbSPBxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(7416002)(5660300002)(6916009)(2906002)(1076003)(6486002)(2616005)(186003)(508600001)(54906003)(4326008)(316002)(36756003)(8676002)(38100700002)(66946007)(66476007)(6506007)(33656002)(66556008)(6512007)(26005)(8936002)(86362001)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r7O6E4YY/k+p7ohcdSsxtPVZQbV0Ar7U3aA6c1aAESf8K2PlbsfTf1MhtP1Z?=
 =?us-ascii?Q?uLzouvtF0grbcKFAmpMrk/sqNdCq29BaCp4DXR8Nr1mGlpxRvM8px79uyYFw?=
 =?us-ascii?Q?hevy1HGXrsh5C5kNnDsLFBfb59rrQ8z0T8bgxPH/YtIfbUXWBhN7CwwQG7s8?=
 =?us-ascii?Q?fvOHcS5gxjoW/2LHxziO0LcduQAoXaYaeoItP4AJFN+mGa2ex//GW1sID4hm?=
 =?us-ascii?Q?25P8BcZpg6NQ10oh4cqOl3M4K7MhdU/Sbp++8Q6o9LBSXMnkAsHINtSKl1BT?=
 =?us-ascii?Q?hIeQncH96/3OplgOfYJ/jVhxLtiYxMQvZcHTR8JTJMgZKjYF8a3nek0Mrenw?=
 =?us-ascii?Q?TJYRU7A2ArrMHp9/NiL+fO65RRHzRcqO83qnzdR3SLAl6Z3JbEjqn0BE/e+f?=
 =?us-ascii?Q?9DTXHyovw3wcHelbaxp0EGka5Yxfe5PtT78OUA526O/2DApmlqfvqqxUSkO8?=
 =?us-ascii?Q?Lg5YanhDLe+nigv1T1TAVZS3SSLqz3lH1C5vi6ZFy+8foA4DS7EhPQRNKUh5?=
 =?us-ascii?Q?Lc+YVEgbwAz1DAUiFgsiIzuw2O9kflbNIvHFvQLqr+M4k6toUsK1UeffiZhS?=
 =?us-ascii?Q?E4LTTVjYz/IGpc+AQ5uetqe+IlFPYxcdMtBn0GKTsusuv37lOoLLRZwrN4q1?=
 =?us-ascii?Q?v6tEMt0SMJrLKnu7rv6rnAbV+B9EI0mlDEeVOkXJANBQ3pM6ESubKB0kmUCy?=
 =?us-ascii?Q?28v+oc72jxVv3rFlpCcLQPj1TpyOmuh4YIq7HTmCjQk0E593GRTGMMUwuhN7?=
 =?us-ascii?Q?y1gkL1Zf2uYvPVFxWjWs6+bH3P3Rn+XshbDJQRiNK78ndkZ0xkST2aJ2vceu?=
 =?us-ascii?Q?PjSOEMGlzNm5uyRNcuV1U25lhX2DVhtErZkqnbRQt4n67FmiFSh9GqQ00jm7?=
 =?us-ascii?Q?/El1qqRwDtMY6i6kG7U1DactZboInMAA3KBZZWo7HKjY2EIIi8vGKJMBcOxr?=
 =?us-ascii?Q?YaukDb7+DbpfqJ7HNBxvVii3daTf1TEFcKmoC1dUSZ39rwHX8jCYEhGkr8ch?=
 =?us-ascii?Q?+CHxh8Ed0YJkCOW4829m36V+ggU54joNz/P4nt2x5DLXG3ATAli0ypb9GYnp?=
 =?us-ascii?Q?EkYGTmmPJ1i38HCHWxRSeDS3vp3r3xb6e1QdqjL9+3BHesfhxlbkoEJ1YIPM?=
 =?us-ascii?Q?726ST46V3VGzZIEBxQguMQbpaSVTN9uVBrcLhCkagKINyR0RFwW6vIdqzDUf?=
 =?us-ascii?Q?3YBUiFTRWxCW0AkBQe7TP10OpUGlR2t6hNGo6dEaFFRQ7oIqowGw1nbsnVbC?=
 =?us-ascii?Q?ffHz5K6YiXx0iiuI2qe6hlQevWgDRxrF7bhqoOidLrV2ozCEAkWHH5a6GvmK?=
 =?us-ascii?Q?piDi5hOYuDpF/zhtKd2ssN6vNqLTOuUXs02j1D5p4JTgocoPrm0TZdcbUphc?=
 =?us-ascii?Q?bF+W5BcvvALGE05WBThNTT4LnvCF9sJAfa12cP0E6FJCQneZAAYtslLqZHEz?=
 =?us-ascii?Q?ij+OdIVAFDolhfTC3yG6CSrARC4izzlrJSonaR9y2IQbNHOPF7/7KXEs2t8Z?=
 =?us-ascii?Q?q/adgbVu9gqbLmMwZu8ioo57lbW6zHbvmjyU0hMY4HQMk8V5R0elMtGeoLV3?=
 =?us-ascii?Q?hCDHefYp0gbhcLj7tI300hiIkDKLo3Km8e4PUTaOPiU2zE0rPT3XZ5hnXWf6?=
 =?us-ascii?Q?pXpmiRwyK5hH79OPyt5Enxllls1nUDjLDYYFahRUbXH61/N0XbU0DgnT9tvZ?=
 =?us-ascii?Q?SYvec17Efcfw+KPSkjccEExaeIk2uhlH6fXHnni3ZkCOtnTK4FI8Fe8meKr/?=
 =?us-ascii?Q?u581rGqCtA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c86bdc98-a12d-4f4a-65ba-08da1244966e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 11:58:21.9114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehex+o+OTAQSRQuAVRzX+DdLwMkivL8diGf8yJr/kf10p/i4tmYMuGjgJwlDGrbp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5999
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Robin Murphy <robin.murphy@arm.com>
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

On Wed, Mar 30, 2022 at 06:50:11AM +0000, Tian, Kevin wrote:

> One thing that I'm not very sure is about DMA alias. Even when physically
> there is only a single device within the group the aliasing could lead
> to multiple RIDs in the group making it non-singleton. But probably we
> don't need support SVA on such device until a real demand comes?

How can we have multiple RIDs in the same group and have only one
device in the group?
 
> > ie if we have a singleton group that doesn't have ACS and someone
> > hotplugs in another device on a bridge, then our SVA is completely
> > broken and we get data corruption.
> 
> Can we capture that in iommu_probe_device() when identifying
> the group which the probed device will be added to has already been
> locked down for SVA? i.e. make iommu_group_singleton_lockdown()
> in this patch to lock down the fact of singleton group instead of
> the fact of singleton driver...

No, that is backwards

> > Testing the group size is inherently the wrong test to make.
> 
> What is your suggestion then?

Add a flag to the group that positively indicates the group can never
have more than one member, even after hot plug. eg because it is
impossible due to ACS, or lack of bridges, and so on.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
