Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4485C433EF
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 12:14:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 586A3611E9;
	Fri, 29 Apr 2022 12:14:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DQ11-7uZAlxy; Fri, 29 Apr 2022 12:14:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2C1D960ABD;
	Fri, 29 Apr 2022 12:14:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9624C0039;
	Fri, 29 Apr 2022 12:14:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31FFDC002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 12:14:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 09C8D610FA
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 12:14:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bvn05CcqqIG3 for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 12:14:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::623])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2D3CC60ABD
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 12:14:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3xl9fnvwYaClsN2K6F8H9DAl5b2pEoffHOcym0XlxnSZznm6mfYVDZ+5YP3xXP/3wqrSJyx33iaxVGsNJpTz0NUrY5tJNthOP1a2vmGds3CazqPw0jo6b7QYWj5NIGhvBEiwgmTOhe9ZpTl1iuF3UIvonzvskOZJNE5oAA07/Wd9sU3KyS27+RtWypNB2YG+Ksx9JNx8JMU9MIU8S9k+AnKklCOWEHWJCtORGLNlEonS5PQkY/H8PlMmvMo2C1kU7W2iq7B0ayhN/r8KWOXIX/GCWyhpcYJOTPZX3e8HnMSixbjowa6pA0Dd1iqug+vNljkGK1UXXFyIVmG/3WBSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRqZ+JGO/RXWoe0eJnH+MY7K7D/Wyy2E+m5Jz/iwEEA=;
 b=Rw+U5Th4sPmtwlY36Ucu4lv5ldys1Niy/szBZ53EzTq7jKgJZLHSLkehskxBSzERC4rGWn3qEYqMFNObZmBhcnJ692ekV2teZW0KYnxrIpJcQH1bxDouP55KRq5wmwimXHnWmsVz2/R5YmR0rcLxYAirnWAkfHdcvn5ZVdiXW/NufeRvi448SYYsTG+apezBzUIAeqaQMVW/prO9Gn6vOOC/cHOhZB8slAYMiqc/dsxDjt/TUl+mHMV0v3mGyfIMM/WC7/8Z1ZaPKJo5gMk8pCM9J3rVNR6OTJOmNwitoAi2B4P3XzwF2PbqQHwfwDsTmKTS8n1eapQ5SpDJM6/Tzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRqZ+JGO/RXWoe0eJnH+MY7K7D/Wyy2E+m5Jz/iwEEA=;
 b=Q9e2f+su1wKfHcV6QvrMQtY180nHL+Q5Ctw9YcPkJCuB6jQWYL0ixUg/A3VFGRIpmt37bwNR+9/yQCLm6H9DeVEfo2pxS3PYkbjpyjjVDxTCShRdAIDsMl0ww7ZokmMv1PKaGmcR1ObrlzhPtgwvkELayqeteF+v5CXo7dorlb3+J9YkXc1PzudsNF6oelCtrT9d9mxDjslNkRrd7CekoOiAJ/YiStjEdMlwd3tGv6SFcuMD5jgbmYoKa1mfH3ad6ANnNWzZnQQ82OPnGmjHvAKjFFgiPVwuWRctq6+YSbggh7ldsHgrwjaH9olhV4cfD2jydo463Gkq+5hhr/4Rsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR12MB1462.namprd12.prod.outlook.com (2603:10b6:910:8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 12:14:18 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5186.026; Fri, 29 Apr 2022
 12:14:18 +0000
Date: Fri, 29 Apr 2022 09:14:17 -0300
To: Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH RFC 05/19] iommufd: Add a dirty bitmap to iopt_unmap_iova()
Message-ID: <20220429121417.GS8364@nvidia.com>
References: <20220428210933.3583-1-joao.m.martins@oracle.com>
 <20220428210933.3583-6-joao.m.martins@oracle.com>
Content-Disposition: inline
In-Reply-To: <20220428210933.3583-6-joao.m.martins@oracle.com>
X-ClientProxiedBy: BL1PR13CA0328.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::33) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8be2c3a5-f0ca-45a7-9fa8-08da29d9c91b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1462:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB14624A109D8AB8E5C0C6300AC2FC9@CY4PR12MB1462.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iyw5sxjOhSKplOIM9uDLgqhI2QF7Z5CUtjzvxExC4/UOTGIAXEv+u5HH+LJsogiRSZ2zcPlQ7pwdgHot4q8OHZdustYidcIyGQazpErf3HdHapULLKGMBtmxHPcT2q/+AqXB/J+dL82BWMYxEJKRXc6YYo5edqzUFjaHRmzkC+BTFQDNEoS2bmaGzgGAEkfI5tfkk2a3fEtmroJR8nzsEIDd8msAGql2ztlCllDLpzlVAAfALIDzeiivp87r7Y+wqYGToZega/taO5KE+OV0Jnm4BL9XroKNSyBPoj06QW+w0QMjTBSItXXDoMyafe9RJ5qqHxWPQgXNXSt+xvhO0B1MX9/+Ma++NoUH5LFuL5mFvWeCAMDjPhvHuZZOo6bQvZa7QGBIBos8L4acgj5tPua8+nMFDXS4cc7RD6bYjadmUIguKmMt0cXaLwrCtbSOFfh+RPrRLRngdVkbxAr53vBJckgyaMqdt300z5tgCczTdqI/mib9rurmn8rBcF1nS23DT9fiEFKREzB5k2opWJnB0VQtXFdbyN7sFULKihB+U5njSCOYRSqHhbYltowWRDk9fDB73HRpMxJTpgx8lZIUglNmlCB8OK7sHxEh4HZhZUxgGPJoiGJBjjEcgGys4FSMsfPZ6cmu6im0N9cYcT7mMLi79JkdehQ6DYNstwzEyMDs1p6JHbiaeKQCYB2Ig7TrmL0FQ6rE+TBZSVwg6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(2906002)(66476007)(33656002)(66556008)(1076003)(6916009)(8676002)(4326008)(54906003)(66946007)(8936002)(6512007)(36756003)(4744005)(86362001)(508600001)(38100700002)(7416002)(186003)(6486002)(5660300002)(316002)(6506007)(26005)(14143004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7r29XudfhnyJBzJ1WqkzGc4rwOtcNAE8+5bUYBtXdv6Zky8UjO8eYfHKkjSi?=
 =?us-ascii?Q?ttmFExuiVpkvG0J7edoZidwy+LcCvY1plRi7BUi9XU2ClfOTS7Cxaw0QOcCz?=
 =?us-ascii?Q?1fkqYpq/li+xAz8gRp4a9r52Uozx+3SO4fkxEQSmcJk8SqWuoLaIaqCY51Qi?=
 =?us-ascii?Q?udsH4XHk6vhUeGzMcOoFpBGRUnbP27zrYiYs0HDbM2FkhSA9eNz0hrm0dfXS?=
 =?us-ascii?Q?FeyxYt0Gz5LqA1LTOhJJgW7WuYODoa9Fh0w8JJ5BSfOb0+y74Sq7AXw08167?=
 =?us-ascii?Q?gLPu7VQPtWgZhCPVjPFebkg0xg9WsiAg07RFmNrBZRdZ/gdgihTO+rerErnp?=
 =?us-ascii?Q?B74iDfODJ3w1VWBEJwwAyOie7J7jkOwYJ8zr0uXioTWIVLGBXw/bLearDPJC?=
 =?us-ascii?Q?BdixZNNcZZiB/L1Soc97jU3nmB3QLJpCLl+9ARCYhh9wYsKbtqHquPdRadtW?=
 =?us-ascii?Q?QnJV6v4gjXiuISENmK7lRk+1Kw9rEBL1M67Rl7AtlEYytI3i3jnGoUTxuyIC?=
 =?us-ascii?Q?LolL/WRI8yz+kypImmCZZPRAbNEXSvqP9043qiUMQjnKipFAYF+x3l7MUwNs?=
 =?us-ascii?Q?hVUWszbA/d1Fr9EzSkRcR8w9u4QTnjAn3bfoTjrHB6gF4o55buGjfvuUzhTy?=
 =?us-ascii?Q?KTnM8juBwcWbBKbQedDmkce40wk4IQcJH7bbggC59TTUFBk8I24M52tZcDZ7?=
 =?us-ascii?Q?RNsJT4KnjZ7KxUqL0PlRouA6LsuFwyzHNuUrYec2rIhWVkL820SQ6nc3fqD8?=
 =?us-ascii?Q?zhUhXTRJCmtZBTrKlOKPz+qbHTDn0aeuPvGPoe/i0Q+k8b5XBTIWRXcCuKGf?=
 =?us-ascii?Q?5hPAWWcTtF+BI6i3ITGd0MsY08VBPxqqeGXMWw5KGEQ7vk+kpvqqMkdnKDd9?=
 =?us-ascii?Q?mlB4MCEo+YRU1On37dtttoAK+FRxePaRes/38MERCi4AqWE0QuLb9B0bQ+QR?=
 =?us-ascii?Q?4it6KlQ9UzgrGSTvgG6A/FBX37BcZnhIqjW9t5TKnKuad5tfO7CahRwX/QXZ?=
 =?us-ascii?Q?G8U6FJRzdUhgP0TsXwZngMAaNYChfHZQoh2JRaNpGZKXynFSVitnaqpKwQC8?=
 =?us-ascii?Q?DdvLidBMoo3CG0sQNYmCmBZ9ykf7/msysRWC07YzLpmJFhmUHDs1Othv70xl?=
 =?us-ascii?Q?WY8LAgCOufUTaLmf1hNFRPYHoIDb+zxiSxqfFVx/2OfaCeqi8HApxBuJDbjc?=
 =?us-ascii?Q?8bZ2Bjp6gg7GbFuOAQ4DbWHbod0TWPtEYixdLJ3MpPBZlh2wB1OE7lejB64g?=
 =?us-ascii?Q?POgwpYBGr+5woLhknWIEReQbNvg8TdhWJSu/bMrIUAgWrDry/9uCJufSui8x?=
 =?us-ascii?Q?SpQXZxqO88UnQirj4S/5FrY80my7ozPPStJuk5cPOiSDCgfLuCBqYfo+NMt1?=
 =?us-ascii?Q?1mdQDWS2ElJjiH9DPJripOmf6iJdlksYOIbihqWwdr4UHsch38Y9fU+Lk/7j?=
 =?us-ascii?Q?ZRvr0F25xaX8jPkeOoBolGZ72tCJetEDGaVDlyUhNpYSfC6sDX5hEmtR75kM?=
 =?us-ascii?Q?sPjsRJr6Z8jvf3yLjpA6MtMTIg0sws8K0wqogT9TKkiJsoLtYUzt6gTfMiI7?=
 =?us-ascii?Q?AZYJD/gAc/0xHrL6jCXZ11hsRNG4vK84G1ZTAd1j560pjWodgdEIU66iUwwq?=
 =?us-ascii?Q?MQubuEfOeu4A/avSuwqdbVAmqiLHCHso3CfgWl1WYv5nbzt4U82uYrEsreTy?=
 =?us-ascii?Q?VIAiLCmdYyzglr7mpemNldwYZ9/U9amm8fr4+DJi/+LT0cd3xixdSeZVLJFr?=
 =?us-ascii?Q?1bYVsDeEiQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be2c3a5-f0ca-45a7-9fa8-08da29d9c91b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 12:14:18.6269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOmwAIDeHV1OofbMHZJRg3zMPCkTVggaxAxo/l750Goeo+8ca+JIgd0Vpl944JGd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1462
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>, Robin Murphy <robin.murphy@arm.com>
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

On Thu, Apr 28, 2022 at 10:09:19PM +0100, Joao Martins wrote:

> +static void iommu_unmap_read_dirty_nofail(struct iommu_domain *domain,
> +					  unsigned long iova, size_t size,
> +					  struct iommufd_dirty_data *bitmap,
> +					  struct iommufd_dirty_iter *iter)
> +{

This shouldn't be a nofail - that is only for path that trigger from
destroy/error unwindow, which read dirty never does. The return code
has to be propogated.

It needs some more thought how to organize this.. only unfill_domains
needs this path, but it is shared with the error unwind paths and
cannot generally fail..

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
