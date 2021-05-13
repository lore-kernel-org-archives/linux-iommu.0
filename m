Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1774DC43461
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 13:38:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1138613B9
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 13:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1138613B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C2C483EF9;
	Thu, 13 May 2021 13:38:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 78m9nP1ZFPYK; Thu, 13 May 2021 13:38:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F2D1843A7;
	Thu, 13 May 2021 13:38:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D195C000E;
	Thu, 13 May 2021 13:38:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65062C0001
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 13:38:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 539DE400D0
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 13:38:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zE6IbrvxVeil for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 13:38:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 883AE400C4
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 13:38:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjXCSVRsoSJWp4+UBl1fdRJg2KeBR5CSGf06unUKzSLc99tb0uQ6ANQfdQuC5tejY0RZlkwSEDz4vrgmz52m8HAMBcvhgl/FCdJlfODUwTWcRTImeH70kKKSDvIV88tz77+0Hc05wP/fV7GlmXhzv/l8EdRPFr6zYgszouJt8BqMF0i0hYxpFTIiBbiILLRXRbs7WILirT+8ZQiL0tRx1R/ZM/kFkcQhR2rJcCytUE94IGJI+sfNoDBXP0sdmpWrZvaFY5AasUAao3alr1a5kMVbhOKYMXcYVVZ5H3o6ah05GbX3DqBbJ8ucIR10DgE71qBB7dKMQhdu4v4m/10PAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpsgqbSgcaxt/BOcRZcgDERarkbsN1yP8eweAxljaBw=;
 b=Rnk0O5eeOr2PFrJ+R1Nxm3UR6rXd9DjCcMlvonhCP2JO6zKCvjvaMS/Q/rsjkGxs/69Bf31ghFOE078aAvUgxcRxz0I5jnw5cdivmr/xiEXufbnzg+ykLRWszL+VoKHOheyh6OfywNnX+5snJqEtVMgR3MR7GfHd+/54cLUz/1XGAHFX7uLGejmJUCzbOVIkAcXF2Z6hVgsvpx9yBO984wCj016sBNFINqXJYD3MFViqpRJ1gSjBUiDpV2Fxis2ZMit8JwRBRbolpjp0wsanxVaWhYSd9qCd3x0oUlX5RJ03s71UcxF4A9JclpMbjH11oUa+9jxjLkZesyPnKgZLZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpsgqbSgcaxt/BOcRZcgDERarkbsN1yP8eweAxljaBw=;
 b=Vv9RpfQ1kkTGZC8GXZuF0bUsTtHA//YPRG+H27EUc83acQ0UukJgpDSgFxTz6hcKnQv0KsfnLQotLhffs4L9gqeqeKly/ybwzvUBeGJVMRS1u7mwLrIShfW2+mcu3dmCUbVtS8pgM2HplcDrOQKNHYroRORHDg5BSVvoEU6PiM0tbSbfIItDbo+Dtn+ag9kgfyqDU0SnCZow7v9zQrgciQxDgh1OPDhafiy+O5Jni12Wemz8a5It4OXn8Bx1h7+9hvmZ5WADKu726i5aqpvoT+/KfVUR0SzMTaWrcmqbBVBnZFIvfxmvtShJkVo9+25yidCQqx2GOWO/0r7cYsYoDw==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=nvidia.com; 
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1516.namprd12.prod.outlook.com (2603:10b6:4:5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25; Thu, 13 May 2021 13:38:36 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 13:38:36 +0000
Date: Thu, 13 May 2021 10:38:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit flags
Message-ID: <20210513133834.GC1002214@nvidia.com>
References: <1620653108-44901-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210510233749.GG1002214@nvidia.com>
 <20210510203145.086835cc@jacob-builder>
 <20210511114848.GK1002214@nvidia.com>
 <20210511091452.721e9a03@jacob-builder>
 <20210511163521.GN1002214@nvidia.com>
 <20210511110550.477a434f@jacob-builder>
 <20210511194726.GP1002214@nvidia.com>
 <YJt3tGlzFK3b4E82@infradead.org>
 <20210513060012.0fcc7653@jacob-builder>
Content-Disposition: inline
In-Reply-To: <20210513060012.0fcc7653@jacob-builder>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:207:3c::39) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BL0PR02CA0026.namprd02.prod.outlook.com (2603:10b6:207:3c::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Thu, 13 May 2021 13:38:35 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lhBXu-006pFA-Ei; Thu, 13 May 2021 10:38:34 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7425290-9b90-4e73-ab99-08d91614687e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1516:
X-Microsoft-Antispam-PRVS: <DM5PR12MB15168256934EB1CCF95B7099C2519@DM5PR12MB1516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JtdTjVS3KI1FvBXMWYGHHYbDtL9WH7WX9JAdcDTvu+VXgdI3XWWgBi7SIEby8z1qaFey4nxcsluypoG6Tpt0BofkN950k32a8dCiVCe3NIb8XlNRpFRPaklkW8WtRbgyjexdWTBKBisdaBRYw6uLrsP4ZNwjiwW6aoCDFCbEa2uOdZHDhRkHphG5OKtDGDtFSnw0FlVNqJmdH78sf8YBQ7r8AnG5V+EQzejEGhkp8B//FQ1RSxMfmkCUT48hNgRqJKKctBEPrLsUmpxMZO2v30UzC1JaTHOCdJDKjKU1OC0bWLcfhNLjRbPDnA5pffDBfL4PvGQUw51vPTe/UmrKGrikHiC7PRgdRhPe6cuVKIn/Tx0WWB5FPQD5qV8DDsi8aEWuDV1KT8Fbe9kMNwJQGCgqD6oAY5Y23fxCemb3RY376tjoIR7N8KyfSgq2YMVFHvDwqoWKfN0D52se+3Kv/yU0xrXUfAl00cPqesFvkEPZFaDxNySgMImm7nG0dH+G9uyZyj9Z3Iauz+yhWoI4I6OWqUvRhCPnpEFsBIJie/ryxd+JdXmV5Ejz0JwZ4FNMHXgezHuQyNU+ygBHBEy2yn5dJbi/cX59iB5W3HSeD8s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39850400004)(346002)(366004)(396003)(136003)(4744005)(8676002)(1076003)(36756003)(9746002)(66946007)(8936002)(4326008)(9786002)(478600001)(186003)(83380400001)(7416002)(2616005)(54906003)(5660300002)(6916009)(316002)(38100700002)(26005)(86362001)(33656002)(66556008)(66476007)(426003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QIVe0VNKggFK75Wy6YbUdQsCzuN+OJBorBvAU34ptqJPUozzNadV7o6CKvwc?=
 =?us-ascii?Q?HP5FUjxXA6lYBVEquO3ot/WmCYvLrsFP1wa7tEfh3u2Kas8dfK8gKSigeOZd?=
 =?us-ascii?Q?HAkgSpvRT0hIkxnn6DUq271TrzyUj5vjIGosGygNJFYFbqEoIbOrm+qDSRQ5?=
 =?us-ascii?Q?oKGzl30QahYsZ7Toc4iheU+MN9a4erBw10nDwbm/HKMUF0Dyf5jyJFvvOkLv?=
 =?us-ascii?Q?4a7Le2Jh4rNFISE+KdNHtWcchUgcX6ozJxaJYpL5SuTV6aHbz2h0oVrm7tBA?=
 =?us-ascii?Q?5/XnxQzjE7CBWhUw166TSEU92AQFIyJXy39e8RTwPNzA5dapSICQLAH0J/XU?=
 =?us-ascii?Q?sCJBIWbMypzoBo0tlzlu1eia2cmocv0ZiXpKhwMbKXINKdfRFih3R6kbR+EN?=
 =?us-ascii?Q?/GF2jKY+47DfKqoqTfiCF5tWq0409qlKvbxplVFTZcRo+iuMQj/Z0XWYR41Q?=
 =?us-ascii?Q?1PY1x1kD0G3VZAgVK92kfBvR7+SbmikH0yd9V7vghJY8KM1eTYNjOyKMoroI?=
 =?us-ascii?Q?fXdWdG6nC6iWqbjkZRo0MmvDVKrnpjqEFYfldBa5ayVEtNaHQlZnipAFOMrW?=
 =?us-ascii?Q?vLun+StAPul5/pMo5gZ4NJQhXqV87z8NmHfzFgZER5IgTHypKaOutnLmnH/o?=
 =?us-ascii?Q?K0UE/+sV12pf0W37mtYSBqj5nf7Mu6Za9QD/abRSFyiX42njkkiUXr7dlTw+?=
 =?us-ascii?Q?rGhPuIlgV2VKh6D2x2Rkja+Hmt48GlBiVYDa8Kqsny6VyG1eYTbQdp2XrM0y?=
 =?us-ascii?Q?fCtRI8EDJwTV3OOzKGbxzZzsGfpncjoAJfQhEutVLLHLLRZ8Bk4ChfXEHFgQ?=
 =?us-ascii?Q?VQIe5wee/BjwSsUnNR12lbNkj7hvjkgsg4dpy7qnlJ9POQiDsP4PagypzKfp?=
 =?us-ascii?Q?JiDYNt2Gbkfha5gWIw+9Kn0++L/uXqz3ANDTRblrJCs51Xk7xhevThmt8d+x?=
 =?us-ascii?Q?vHOAtBqarNehfzPXzEC1MHwvlZkcUd/RpIEYW0p0tdsY1gYmOUy4eGFtxg2S?=
 =?us-ascii?Q?WUrC/yyfMYxbrFCvS42Bur4H8rsH3pSGAjr9RJpZUI3yTz5N2YIriRMeC3K1?=
 =?us-ascii?Q?TLObuyxoV8vV7wjje456CMOmfqp67ev4EzKA6HizIQ1g9kyaUTsqMgvMwP7x?=
 =?us-ascii?Q?CoMSeIOT9KtSzvbjnvDJibXhxxWR391K6Kelygl96BQjXYv1ZCgkJHIOZtj4?=
 =?us-ascii?Q?KdmFvmUh/NzDLJu6L6fe4/3i166nx7nGeElopUD9NjQ5+Os+FZWkaCO0ADmQ?=
 =?us-ascii?Q?RagGv27IPYUgviMzOoCRgtM6UIZdcNVoGP0NJlEiY57IC5d8iiBqk2R7XRUt?=
 =?us-ascii?Q?VCaD8Oad5JZjsR9EK9K2aRHj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7425290-9b90-4e73-ab99-08d91614687e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 13:38:36.0223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjsTYvuhIxQfJsDRJLksAT9fIyr3QAQzzP5WD/YEWu4eDBtviTkvFLqOJ5lkKdFK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1516
Cc: vkoul@kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org, "Luck,
 Tony" <tony.luck@intel.com>, zhangfei.gao@linaro.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, May 13, 2021 at 06:00:12AM -0700, Jacob Pan wrote:
> > > If you want to do SVA PASID then it also must come with DMA APIs to
> > > manage the CPU cache coherence that are all NOP's on x86.  
> > 
> > Yes.  And we have plenty of precende where an IOMMU is in "bypass" mode
> > to allow access to all memory and then uses the simple dma-direct case.
> I agree it is better not to expose the entire direct map. But the missing
> piece of using DMA APIs is the PASID. The caller needs the PASID value to
> do work submission once buffer is mapped.

You still haven't explained why the kernel driver should have a PASID at all.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
