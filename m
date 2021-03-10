Return-Path: <SRS0=kCyf=II=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC756C433E0
	for <iommu@archiver.kernel.org>; Wed, 10 Mar 2021 19:23:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AEE264FD2
	for <iommu@archiver.kernel.org>; Wed, 10 Mar 2021 19:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AEE264FD2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB57D6ECE9;
	Wed, 10 Mar 2021 19:23:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BgRaMrkf1k6S; Wed, 10 Mar 2021 19:23:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id B95996062A;
	Wed, 10 Mar 2021 19:23:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7945EC000B;
	Wed, 10 Mar 2021 19:23:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D496C0001
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 19:23:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 72D95401A4
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 19:23:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FY_vCeAjQppB for <iommu@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 19:23:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::625])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4B38640003
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 19:23:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMOeLHvM36ebBS28N+2KqCfIkzfnNYbzHFtm8GIO0TTtr/h11S5fg52gosDyjmCUrQQhhB/DSZNdGerQoWdCriv460FQOqHbjCuPyaV1x6Z4CqMfXTijncn635B9tIG4GuoSwYQg+UDm44IBTFF8bbV/DJ5n47IBeqVUuQyIYCZiA8if3BlHr4/jPHkfnfUqts++Spi1Rs5054nj3c5BPHD2gateWaKBlY1NLreQKALImHeqnYba6xqcliaCphSGG/b8ZyM0nOfHmnvzG6Gl6PR82zAGL5a1PbhO22CillaZNO1VmaPar0aCpDy9pvx3gQ4XqDV27FBy4kEjQWksYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9vW5Tkli/mGOXhgNDkiWxksYvTGh56Erxhualjjxwc=;
 b=ibh3lrb4evhJWlId9mZ0fISjGGEJ3ktAvvy9HRNcXZAlqRIdQ4NA9gmb1OYzwlICPu54bX6qyCdX2QIx4jIftw+SUnCAi1Eh1UNp4XvWoMJnYSolCqIgx8oIyl+O7pYXXDXvTnl6BUTchaAYTYyfGYYFFGmDrr9Pu0GKYKVgABfU6mfAP2sq2MzY2eZFmjvj00GIW6AVzy+BCdR/RZpfxV1CPMzc9in+p6bQ8Pu6+SJQwIlhyOR+nwYaTIcy+dcHkVD/2kjUWdi6UHyKP8sZtfqLqJkxdRl965rEcCmpCdV9piJESJNzqVOyHyShe9Kwfz3B5zX7a68GC1JXpnjGhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9vW5Tkli/mGOXhgNDkiWxksYvTGh56Erxhualjjxwc=;
 b=LaXeEE8/z8xKwzOnzuOHFOraxwyZ4k4XccBmPjvoy2x9oSfZ1vT0VnPlV1BL+9aH+F3tqxaytcPbjqKMqIg79Xdo12+0pV4y/l8pIYcV51XnWlw8a8pqMqNkcY/yFNu3Zb3Hev6uZx5yq+HV1BjFVkmNoou1bsK8LRXAHd3fqQTswur7Q7VHNaC/mW1lq52x5pPCKN3t1Q7/Do+PfLRix9V6deI9tZTgmjcgYnxo08TRqhz4aaUJJFhSzEXwb/BjJA933SVHpS7inLZo1JnIsUELtMyUvSqQ8z6hSpNYXnF7xhmXe6snJxJ43jz0qLKpeIE1/Oned/IRWVvZdeR2ng==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=nvidia.com; 
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2938.namprd12.prod.outlook.com (2603:10b6:5:18a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 19:23:03 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3912.027; Wed, 10 Mar 2021
 19:23:03 +0000
Date: Wed, 10 Mar 2021 15:23:01 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [RFC PATCH 18/18] ioasid: Add /dev/ioasid for userspace
Message-ID: <20210310192301.GC2356281@nvidia.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-19-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <1614463286-97618-19-git-send-email-jacob.jun.pan@linux.intel.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR11CA0030.namprd11.prod.outlook.com
 (2603:10b6:208:23b::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 MN2PR11CA0030.namprd11.prod.outlook.com (2603:10b6:208:23b::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Wed, 10 Mar 2021 19:23:02 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lK4Q9-00AtRk-OB; Wed, 10 Mar 2021 15:23:01 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac3cf66f-1eab-49c7-adac-08d8e3f9ec91
X-MS-TrafficTypeDiagnostic: DM6PR12MB2938:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2938BCD41EF4666DD4C76C18C2919@DM6PR12MB2938.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u8wNKAJIGz+io6EWMz+4g3t/7xCEEGRPKAtFO2AYBL+t5ZsiMnuL8O2ZEvuKmdHwpKdlSmBDY1H2LdTLF69tMI2gju3RZ1FMjL8WJ+MFA17TwakaoiuX8slesYbC7TC6UmS4U15hXRp9ec6e4exWn2n/QrKUzwOzAVNfr8QpSqtCjl7u/oy82WJfS6LAX5qaldcNSZQvGryKNnD2PX/hqM+qU5E1qfKC+i4woIRQF9CqFkefCaDo19obpVQCRkKKuQjCkKxtMok64aZSJY8QrxBDYHcroExB7vTX8+FlAlvglkqPLMEBs18tynbOHyEroyPzXXVw77JZ7jsTGC9bevWzh+rvh/E6gO8Q/WgYMTrEQus2lvKaRFTZZCeugvYzdNvHnfhtf/8ZuuUsozYKnBBIldZMSj9dp0SiA3lF35uu2kmDUhNP/bMRNPw+3wCGJWw3ehRZ6HjCiIwHYMmbm3p28ApfKDQpdjvDwTUD62nn3kWQ8mOm7OPSRfvzC4iyELocJFH9HCr7jEcvkZht2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(316002)(426003)(86362001)(9746002)(26005)(478600001)(7416002)(4744005)(54906003)(1076003)(8676002)(33656002)(8936002)(2906002)(4326008)(5660300002)(66946007)(66476007)(66556008)(9786002)(186003)(36756003)(6916009)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?oDtHu1GZ3iYtTwMddLawo+MRw1h5A1kqSYRmosLGp8q7OwzRB4RucnAphwOF?=
 =?us-ascii?Q?+1B5jImQAStBljSLU6TpwK/YTPADireCh1TWsAHLPg0k4D7t2YcsTuT1lIXG?=
 =?us-ascii?Q?r8FR3NvqBBIX69UdGuecG9vD7d6l15ttIH6pDSyeoZOXWgAJXBS6sPIBf30j?=
 =?us-ascii?Q?rqpz3A1FD4d5hU8dBzOoEJ33IaV/hwJVUveq/+95GH0TiYLE9TkWh5ci9ILB?=
 =?us-ascii?Q?GAfoFNWMFaXQzx9lTfg58Ju3btQYmdjBgzT6ZhovVZ0NEd7syO119ey2bPf/?=
 =?us-ascii?Q?9GLeuaURKGZXVJtTz0zdLU9CPK6bT8gkp6WQQXDlwAYpO6KE506Mu0D1XPoP?=
 =?us-ascii?Q?P6aDpDNKCwe185DdnTTokJa1FbqxaVJ1rPK80uKJ8kmwWuVREZTHCGeEaRCJ?=
 =?us-ascii?Q?JEqFyEjfRj/kigXf/81qAg7Yzb2OtYjDLUMpCO4VrD3dHKWBhl5UfOsn1R2a?=
 =?us-ascii?Q?orIjFVwn6mEEkuOe7uP3NGq+ntchhkrwuVZWRyZ3vhUL/y/XTUNLvvzKbD4C?=
 =?us-ascii?Q?NehZZ+94EG5HcgFNxnPY6VZZDqrqKOsi5zUjQ9HsIJcaBlH02xSrfJOV+LXa?=
 =?us-ascii?Q?if4VJy49zC8zQixYJaxF1Nt8FWBqnVRO6BExFu04O+OvoK02qvHl3EIQ3wWI?=
 =?us-ascii?Q?pFYXqrEg4lLtmeGPactT5e6+idR1e/bhPLHVCO5ET2LlsFnngjuPPxOMPIPY?=
 =?us-ascii?Q?ydCsXbHItnd309Vo11fSwWktCBF+NHJIlPluwTFu7srSeW5dP3vtU43SQjtc?=
 =?us-ascii?Q?OZ5irWotDARL3M4smHOqa9H7CwTj/YeLU2FWNjHiLMQxpABEbbnwBC8KJIcL?=
 =?us-ascii?Q?bHpWSSZxvTSrwAEr5OuMV7ZDIDcLB8Bk5Lbq/LihQ6haPsgsDZ2bWewKhlmg?=
 =?us-ascii?Q?3//+UgmW4D8jKX9bkFW6uXAlkby6Vu4M2+v99Q4Xy0eQfv7C9dxUEKir4gLa?=
 =?us-ascii?Q?IoJEjAfz2BxEAoUQvvQTTInWkxIOJ3mQGsxXtC84jsBAsg2HrQBafdS3Lvy9?=
 =?us-ascii?Q?oKtFIKAMchyuyGEaOb0R/iqkedIhhC3P/bAErpuvmTIA3tS9XEbrAP7FNcgw?=
 =?us-ascii?Q?aEQDBQybR276ErvCkVwcJs07pke9ZCSRZbd5I6KGH5FDy7lbESvZNTwItcbC?=
 =?us-ascii?Q?g8oSu1EtX9wUQkI06reFrM95W0WqGFK4ppXz+gJDZ6DyNwsCo5SjNE17zVAU?=
 =?us-ascii?Q?Up2Bai+uO6SAeQfX6AG6WfiwTnslULAiWO8X0hpjxE2mNOXXi+Kc4x9//NXD?=
 =?us-ascii?Q?ksoFabLYNeEnqltTYiQOWzp0p4ePmUbp86EX09J1EaYwLTu8S/GywgwyB1LA?=
 =?us-ascii?Q?evcYri2jKJFLndfBs23IVkIrsnBbC98ljp50v+wxiL/zvw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3cf66f-1eab-49c7-adac-08d8e3f9ec91
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 19:23:03.0116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cYcNppCp5zwkCAmmq9nzz7BXOA/YU70Ml8kcQG37Pr2sSBnLO/esv8oRQhlbnfcm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2938
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

On Sat, Feb 27, 2021 at 02:01:26PM -0800, Jacob Pan wrote:

> +/* -------- IOCTLs for IOASID file descriptor (/dev/ioasid) -------- */
> +
> +/**
> + * IOASID_GET_API_VERSION - _IO(IOASID_TYPE, IOASID_BASE + 0)
> + *
> + * Report the version of the IOASID API.  This allows us to bump the entire
> + * API version should we later need to add or change features in incompatible
> + * ways.
> + * Return: IOASID_API_VERSION
> + * Availability: Always
> + */
> +#define IOASID_GET_API_VERSION		_IO(IOASID_TYPE, IOASID_BASE + 0)

I think this is generally a bad idea, if you change the API later then
also change the ioctl numbers and everything should work out

eg use the 4th argument to IOC to specify something about the ABI

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
