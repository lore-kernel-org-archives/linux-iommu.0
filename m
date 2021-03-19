Return-Path: <SRS0=1/OX=IR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB97C433E0
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 12:46:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E59BB64E60
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 12:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59BB64E60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 392C983C26;
	Fri, 19 Mar 2021 12:46:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WkbyaK27bqcQ; Fri, 19 Mar 2021 12:46:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16F4183B81;
	Fri, 19 Mar 2021 12:46:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE020C000B;
	Fri, 19 Mar 2021 12:46:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 505B2C0001
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 12:46:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 296E34C9CE
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 12:46:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DdXDxrctXesZ for <iommu@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 12:46:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BBFD94B978
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 12:46:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EePDw7d4AAQXFmEKe7vekkGKuGriUNOs0SmKRS3vJYNxZEFAcgwcMkeUy/Bbo/rb04aepgLMAY5bmwIJ/h5z9JMYbA/NFQmDFUUNrV+PupVXkBpfH8Y+kZfUpx/+ZGw9grHcfga9fTo1EajjJz5fwx3k4gxwEUiQ/Q+BpQcxETVFY+4dkNDYcSkd4QFUGwSpkGpP0e4Vw9GO/jCkGSZaYjnICzqPKLRexyeGmDDICOVz1Onc+p5BfH5s/SAxNs/F+78GYy4l7MfFPQhQZSXHTMvqwUhLH/Z713wDCM4ZYKBHa/ZI85OAGIuvF9bLCi8xdRxzkCiRdWhj8Qna8oq2dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/nsU6ATM1M8lSjy/TMu9GVYVVA4i5cKPjws1WsiPcE=;
 b=f/LXl831xSOMpyIbWz6Rhp3WaDybDIlfGW2juYl/+pfgal2CDVEEXyHXosl240VncUrHWev1tb4e8dA4hnnaBo1YcZQ2s2XOngRjc0arJCBSF8S4isehG3+BfwWN3CJcaYkRklW3A/n+m+2VXZbA0fGzl5JD4dosc+A9tNGf1WU57WgOybHbjWdIuGZ3FAEcBhs81A8tBh5Vs3g3h2lvDwCEtpv8R/RDJt3966oLdxODqDpHElVAXhNqpbFQScYKYOOHaPAkZB3bdTjvedHBWS1+N+mVrWx2vvSFJjdYEScg/hAbKhtGXttqLjz3wy70fha5vSZDci07Wy6UCXLliw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/nsU6ATM1M8lSjy/TMu9GVYVVA4i5cKPjws1WsiPcE=;
 b=uEritXANFQG9Bn/p5GsiLsdhMB3nJCOyTybyQHux5rmSPPBo2G6ryAUzXwr++B8XxBaveDtPL64dDaB5Q3iVDRzLcT5fPyntxu1W2y0RXngGQ8hPvLx/w9j0+MzTnnaLJCYawYG/x3kjvC9gLCw5yEKGZBs2CpquGEt3I1ooO+2UEwi1Emf+O9TJpdsubfCqnK/bwcl1yRHFdi12VZv7UxAE42iQihPC/gVX7iduaCJeB6RV5UZR/RpiYwz90nmYkHCR6zTDUNHtW/xtyT1qVIApYU/Rr5geV4OZk71gQp5nkk1YE4C01mjmHvm+lMqutkbIrv9AkoHagzMm9/iB7g==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3738.namprd12.prod.outlook.com (2603:10b6:5:1c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 12:46:47 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 12:46:47 +0000
Date: Fri, 19 Mar 2021 09:46:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210319124645.GP2356281@nvidia.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210318172234.3e8c34f7@jacob-builder> <YFR10eeDVf5ZHV5l@myrica>
Content-Disposition: inline
In-Reply-To: <YFR10eeDVf5ZHV5l@myrica>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR02CA0052.namprd02.prod.outlook.com
 (2603:10b6:207:3d::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 BL0PR02CA0052.namprd02.prod.outlook.com (2603:10b6:207:3d::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 12:46:47 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lNEWb-00H8g5-E4; Fri, 19 Mar 2021 09:46:45 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f48e6198-757a-4451-940c-08d8ead50ed8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3738:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3738761B66E4FDC32B595953C2689@DM6PR12MB3738.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iqLfC8e7oBivWuk/yKFjvYtAe/RKY9kQ7fzNbeeBXeh0UTEb/H/o8DJcrh//r8VXyifMIHSLcIxN/ht7S8dTaivzgcopl2gb0mS+IH62adMHfnDENpQaSAuacJv8NmP//oK+wGLlublicY6Ld51Z5EhF1UB/RYhAhGd65ordzR/YoTlbuoVwbtel0s+rS6es3x+ysNlziLiZh+hbX26ZN/Yhp0hIa2h+CXfT2wE59lK20BMTznfjd7pS7822E2vI2AsuQoI+FlUB3lUKdudh48rUtaG0c253wQVlFfnXCb+dSlX5kis8MFU9vooyTrgv6o6uuSSTx9Yn1Fio888qhOQTD4Ac4LW/fX3pb2kGOhY1Q9rpjBGLEqy1rwDf9Fbo63o0YhC3kl/mu20T9WFjU+eVNn5ClZAtXw6caj5T0Db7QVoZ7v9kPgsb3NDgFXLU9pjdTZseJNd1DeCn/nyRWVdRV5hSmAB8Kwu7l7mLWt5qjA2a9oLLO/J5VsoeZVx//2bt2AoQlgwKOiqorMpKDOIFxP/o+AwgnCqM4fEVMWFEcVw+Jfyrzv2UTOr3cX6sX30YAphejzJ/7bXVST5G5jrpfmG64T9g0GxSRf0sURX8zrckOaySADE3oyGSCNu6pinBGKyE7ASHO7Qo7CUtEFG1fwF3a/WZjGQQIaZmGh0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(66556008)(186003)(5660300002)(8676002)(426003)(83380400001)(2906002)(478600001)(38100700001)(316002)(7416002)(26005)(66946007)(6916009)(66476007)(54906003)(36756003)(8936002)(9746002)(9786002)(33656002)(4326008)(2616005)(86362001)(1076003)(4744005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QH9pANrXqm9QkYjfxGmv9MhML7hmK9/NecOUlwv0PRHE2YecxDNIcHNbrb1P?=
 =?us-ascii?Q?d65fIDikWnCt8e8UOSr9hvWvrTMCs8I0kapH2eeLmH6xToqc5BGdUmZenSwS?=
 =?us-ascii?Q?G0qyqs/UQQJdz0ov/E7d0lBahVW9jUQPCjHmBzfm11VpQrlFYT2bqmQhEPQ3?=
 =?us-ascii?Q?yZZnCu66Mq1DEMPons2Dcr1KKflYwf4GTCMzEMpgvuoRstghkgZJTYyw95rn?=
 =?us-ascii?Q?Qd5tfurQ69YTkT7ExlHDBe3kMeMOJ4wRsWstYxQz1EKO3Wr5JQ8KkhKBGjKi?=
 =?us-ascii?Q?0um+Qnq2bIooROuOZUAu0szOQsv/BfmzF2IgMpfjWAj0gHt4c5vKZ7nzBmGS?=
 =?us-ascii?Q?mZNEscYmwKHzeH1rYoN2KfPrZZDQlIF9xjKcT+ecZqJK0IxM2QAYG1YNWZ6a?=
 =?us-ascii?Q?c3kKeeNK+0HM3zzIceTM6Ve1fuP0Sb8BMAExeBbdEllpJz4GLqs4+obksIKZ?=
 =?us-ascii?Q?wShsJ9ebvU7w1UF7azXIu/qztjBtm2eUAWncc7bMzFtcOFAgAo/FWMlKiaSW?=
 =?us-ascii?Q?PvuVAiYrvGS2VPi95f93CyN63acY6JW4tUj3qGQ0NR8g5snsskmeEIOyzzHH?=
 =?us-ascii?Q?GklTn2kYLbgnmy92KBv7OueYfVSza0P6lbEmWDEwzGNvG9+6/jwRwZXPb//m?=
 =?us-ascii?Q?RhSJKRQw+jEbxHWrv1g1/xOUOMyWTJBf7Qrdkz5sam3407f1jBGUmmrIWF2v?=
 =?us-ascii?Q?DqbWsd4llI90ZMnltaUViwpp3gEt1qiuDRQUk1HAXPl+OytYoUQwu/K2tr5v?=
 =?us-ascii?Q?uJ7HivPng//DYphZhKVN8n7yB6r80Ka6P+keKZhIt9flIxQACSCZ5ik5QtB5?=
 =?us-ascii?Q?2uO9WoI7tf/PwmLJVw9/R6ev5GOvgj/LPWpfHB8ZCORcbZT18MnEOlW7HpEq?=
 =?us-ascii?Q?spGodZNNu6OZPtMaISOnbbdSK0UKucTsAS6iNIm7Wgn8svg6lETcdLpvuQG0?=
 =?us-ascii?Q?antVEDMJPrQyT8v+7Sy1vCnGtxECt2gIpU5JGBRhdeJ7v7lG5dmKIyEMNZA+?=
 =?us-ascii?Q?UF2yATZtrdTb+rSx9+UYM4TYxFoq/VV4epNiHkZETZvZ3Y1rRHArIAn4732K?=
 =?us-ascii?Q?Zev8sWlpF8XOS1UmDVXbkaXPWxTttDfUlYztP5q3VcWWkfs7hiA2Sp256KBu?=
 =?us-ascii?Q?QRUz8xumI1WkHMcY80d897x/aE4FVkqQrrl14VZXvAN7rfBFlLmR9n6dt09Q?=
 =?us-ascii?Q?URiH1n57xvYPqyHJsYcL9O/6dS7cljY8eV79nHFyhJNh2T9AUXN3LEjL4hrr?=
 =?us-ascii?Q?zTfQ+FaQrWn/bua6D0+8nnOlUISoco4QT1dRFyYLMKlJv/nkEehIZVncGXMw?=
 =?us-ascii?Q?k1oblf/1eQB8shSXtPqMRkf4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f48e6198-757a-4451-940c-08d8ead50ed8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 12:46:47.4171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5pgPyulmbJeFsMIq2x0rOT9ywJazTCJ1lwQvXy7mJQ9CabDxtlxeloANrU3mcsd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3738
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 iommu@lists.linux-foundation.org, Li Zefan <lizefan@huawei.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 cgroups@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>
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

On Fri, Mar 19, 2021 at 10:58:41AM +0100, Jean-Philippe Brucker wrote:

> Although there is no use for it at the moment (only two upstream users and
> it looks like amdkfd always uses current too), I quite like the
> client-server model where the privileged process does bind() and programs
> the hardware queue on behalf of the client process.

This creates a lot complexity, how do does process A get a secure
reference to B? How does it access the memory in B to setup the HW?

Why do we need separation anyhow? SVM devices are supposed to be
secure or they shouldn't do SVM.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
