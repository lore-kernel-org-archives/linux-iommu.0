Return-Path: <SRS0=9w/B=G7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619C6C433E0
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 17:16:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E343A64DE2
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 17:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E343A64DE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6CDF886E73;
	Thu, 28 Jan 2021 17:16:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j9xgMCOQlVXS; Thu, 28 Jan 2021 17:16:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A7AD786E6D;
	Thu, 28 Jan 2021 17:16:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75F53C08A1;
	Thu, 28 Jan 2021 17:16:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4484AC013A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 17:16:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2FF2F86E70
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 17:16:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3MXvu+AuRTH1 for <iommu@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 17:16:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B9DFF86E6D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 17:16:07 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SHAelO184502;
 Thu, 28 Jan 2021 17:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=Iui4vAgvoMar5XVf7t6WuU8qOxjFj2O+Ktt4kCn+RGI=;
 b=WO5y/ATOL8lxujD6/SOCFtd7Ss0ljNIKFxx/BorG8h4sNAAkA//0Q1y/nzpkh9u/CmSg
 we5MudxjDCvKTmPKRMjv/RW9q3OLpqUbE9YHEejpWwMKWukbThOqGTjy/G3o6myF5C8q
 R0nx18idaT6C2oiJAWFpCK2iqaKzHLH9aE2Z6WwmJnX51PHOZgG78cuj/SJp1KZ8Wu7X
 /KjkBeK057eirrS/8WugIWOY0Cl5ElyZLvqmmBX7d4jPFJzXzVrRKNRwz9mEITtkaQJ+
 9ff+Fja1eD5T/jzNXRtJO2S+EJ001xaAJGgfQWUCdrMRXVQ1ZexnrSjtTf4KsozstC42 Hg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 368brkw7dr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Jan 2021 17:15:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SHAeC7112496;
 Thu, 28 Jan 2021 17:15:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
 by aserp3020.oracle.com with ESMTP id 368wq1ywgn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Jan 2021 17:15:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9ADsQ9jMR8aZqowxrTN/yGPGmDwi64qMvwGuwc/BSzSR6MU3Snb+cBiNuZ9GSV9SHpkYZBdY9DkiY2BIj3AvH0OVS466ipTtywwDEWyJV7SrZMkUbCy2bXeb6DL9r7f3xYg61N+w0O69dHZyQTf/lKUOrWVjXw9txc5wcbpn3YNjHZEwCd/QSDwgYz+nL52Xiv7UrzPmXgNBad4pZcc1b8Z25a3cbQiojV4g4bpAAV8IS1MHzMtX7LfVyd4mYYhieWsZ2RbEKmWnmoxODvNyLNntvPMz8+flgMkeI/ZUsJYBjlx+AQ/Rqz3J4/8CvAtXlGtvbA3W88qKXqbdA3N7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iui4vAgvoMar5XVf7t6WuU8qOxjFj2O+Ktt4kCn+RGI=;
 b=cSY2xDkz4Naj5z6xhfIO1Gj8nLbXbkFsp4aWKfSSI/6jXtLZOlzWOGc9f3Fq1GR6MYlcx23PV+Ao+oxP/T9JgaFur8Sxs6p6yZxL+beAZ/Lam7MaTTgWysjmwhWEnAPElBu9AYaSZCFDYwep+8JPvxK5Y5Yu4PZhHU0tybS8UDigoCT2VLRC1gg8zJXTKQrUVAh8rveCfJpEVaUy2lpV/ZHWZyXkSNpai+lLsjd6oTsf57RvJzLX6T54Y0lO/VOVDH7BO2QKlinX1FW28DSaE4xxz7SImZKtLrcZbPj6lkTKrrYDgkbPbdZUbzZILLQ2O0T0o9ZcsnbNs3dKrR1GCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iui4vAgvoMar5XVf7t6WuU8qOxjFj2O+Ktt4kCn+RGI=;
 b=G727a58bjKRMRDjXWLwMYqpYibxSxdCpocHzejrb7AUOYUNWiJQso1b0j49X8KaLIjffUrFdR7UhhatdKFzbw3rqeBmDjEeA3H1yoHXZfqBRTtAJTKfE6lmowCF4EyuAwsU60x8HADLFaW4M72cWyo57Wa2Qya/0WizzQoLZvxg=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BYAPR10MB3736.namprd10.prod.outlook.com (2603:10b6:a03:121::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.16; Thu, 28 Jan
 2021 17:15:34 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 17:15:34 +0000
Date: Thu, 28 Jan 2021 12:15:28 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Jianxiong Gao <jxgao@google.com>
Subject: Re: [PATCH 2/3] Add swiotlb offset preserving mapping when
 dma_dma_parameters->page_offset_mask is non zero.
Message-ID: <YBLxMP3sr71BTL+d@Konrads-MacBook-Pro.local>
References: <20210128003829.1892018-1-jxgao@google.com>
 <20210128003829.1892018-3-jxgao@google.com>
Content-Disposition: inline
In-Reply-To: <20210128003829.1892018-3-jxgao@google.com>
X-Originating-IP: [138.3.200.34]
X-ClientProxiedBy: BY5PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::34) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Konrads-MacBook-Pro.local (138.3.200.34) by
 BY5PR04CA0024.namprd04.prod.outlook.com (2603:10b6:a03:1d0::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Thu, 28 Jan 2021 17:15:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbffaaeb-c311-4b15-f179-08d8c3b052a0
X-MS-TrafficTypeDiagnostic: BYAPR10MB3736:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3736917BA768CDD48FD13ED089BA9@BYAPR10MB3736.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S95JaRRWfuY6hOnzaV4l84Adqh11MnbnkFKdg4imLgk1Zd57X+ou3v4iVMLkKSn0ZFVBFLfbXh3mN8EAPrnWTiA1pX/I/KnYa7RCIjDUaTiUTmbtgpAKVAMdm4cJiBU5C9SAQHDyhqiEHyK01cmpNxHhGu0HOVn1KJuMt5UAL6EQGsTnzNxd88t83kE5xeEiCEd0eIP6QcKJm4jsMrtNXwTOnlJ80D4TREfW57OAj9iHe8icWzg6S9WRNTIj17p6TSkounOczPyNbO5yfGIMyIIVY1R4PJoTFbkI1ScB0NL+vtXYFNTm7/h9O+ECtSj7XAc3w0v8E5444Ra44s7YV1PYvaiMyHYZ9cTJUvpVpdbj2YKpv6FIUIR1HCAIzcENED/47IbL4vWakKtUVFPA6Z/g+6jzHgYoIMrsel94o8vJC0W9X12MJuq8CbVdfhzwv1yAXNhTg1V/LTNPulsUaxzt2l9doUIDchgBQIu+BYr4Tr81QUxBOTzLdZN/sKbYthvDAxQAHK8cm51caAd6Nf3Sd7ONoQH4/y9puRtcv906K6K4ssExrgumJ/MF5fWJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2999.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(39860400002)(376002)(396003)(366004)(346002)(8676002)(5660300002)(4326008)(2906002)(86362001)(186003)(8936002)(66556008)(26005)(956004)(6916009)(316002)(6506007)(52116002)(55016002)(9686003)(83380400001)(66476007)(66946007)(478600001)(7696005)(7416002)(16526019)(67856001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0To3o0A2tjlIMIPcWXAxdp4cbcsvJaq7SjXDVyFCZUssVe5pjB1G0KuWpiaG?=
 =?us-ascii?Q?pQb7+5pPrg6SVYh7w+9r8gt0FaKKYJNq8iMs0JdVdZHuOHsIzQ1ZidEWv9+C?=
 =?us-ascii?Q?wNVLFhOBFKheVRi/FxKLPFB3k5/VbMJhxRPX+HgBAUO+7yQDKLQICKLIAK/H?=
 =?us-ascii?Q?/6TGHihfDzEajebrjLZsxEVBD7fMNPe8X77ORf+PakbVWt0kDCjnJIH2S3t8?=
 =?us-ascii?Q?n6vmIM0VZGqAoACJj5uv3DRmXtoINu8Ct1cKNoxfFlVte+nxLR/jZ5gBYA4K?=
 =?us-ascii?Q?2a6LUFBFOnzF801FnUAb9GdAx61jisr0iL/XM+n+QnBvUW1mdThIpTP5Asx1?=
 =?us-ascii?Q?eWsHHB604she6yQk8P6ELxQg/qEGh8v6zrRNnIln3qQ+m9US/jvYhw9i0Sfg?=
 =?us-ascii?Q?QHQJJ8eNw4gvL9o/wHjQ/exaMJPRa4MQR4RTb2PJ/cqbiOhVb0xgpI0bG0qv?=
 =?us-ascii?Q?yTOAwH0A8cIPv5ZSrqj9ZtHjTfrEQKY21kBg28rMZSF12EfFEib8TcgUkFfZ?=
 =?us-ascii?Q?3WB+zrMUjbbMFhDICRWq6WI5ValZaWrQqn6tpTv2z1IUDEJAkowD17Ae7MXK?=
 =?us-ascii?Q?21kmJZCsoQGVldRx538OUQxts4DZ4JcDgKaWidJ0LDV5Hk8a7mMKHfR3nTV2?=
 =?us-ascii?Q?tUpX0p+JVq1TfjIKSN/yCpXy4F31Gugwdr5cnKTwEXrfpL1lm28IyJ0PBozL?=
 =?us-ascii?Q?a3V4i94RPrLf1te91uVBMidSv9iN/XZjmK3MgKFNWeT+XJtyUtjFLb9uDETB?=
 =?us-ascii?Q?pDF1B4tJDFazM4s4vZOntVGNsZeBkAwHaypLtW0q+RkMbae/gyYGBSv5N5CR?=
 =?us-ascii?Q?6KZhUe1fnbmJ88KIEcA2btmFLEqm73Rl6jwSxSDYhEIZTEP97YPE5oDjgVGD?=
 =?us-ascii?Q?o/cZ8VF1egzYKnXJtUDu1TIRk6NMDw333E4ceDH9/sy9aklkuPpjOuL0Vmtk?=
 =?us-ascii?Q?j3Hs/pNq7KIEj5idApyzQolU6TlQch3MsCY9Gu2bmIlfNMZeeMryRzhZlu0B?=
 =?us-ascii?Q?akTdhxBT/p4jWLFjvfqrOFXc73PKc2BR1lQPv8D27uIokc+VDohi/XEIomal?=
 =?us-ascii?Q?RocKHYgn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbffaaeb-c311-4b15-f179-08d8c3b052a0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 17:15:34.4043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uij+hqOgHlFCfQBDcqSivl2sODR+A+lW7L7fsCcsnov9OYVvN052bkp0FNscjU0oasH+OIeieiEsk8zWY3e7OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3736
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9878
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280083
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9878
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280083
Cc: axboe@fb.com, heikki.krogerus@linux.intel.com, sagi@grimberg.me,
 saravanak@google.com, marcorr@google.com, gregkh@linuxfoundation.org,
 rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, kbusch@kernel.org, bgolaszewski@baylibre.com,
 iommu@lists.linux-foundation.org, jroedel@suse.de, dan.j.williams@intel.com,
 andriy.shevchenko@linux.intel.com, robin.murphy@arm.com, hch@lst.de
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

On Wed, Jan 27, 2021 at 04:38:28PM -0800, Jianxiong Gao wrote:
> For devices that need to preserve address offset on mapping through
> swiotlb, this patch adds offset preserving based on page_offset_mask
> and keeps the offset if the mask is non zero. This is needed for
> device drivers like NVMe.

<scratches his head>

Didn't you send this patch like a month ago and someone pointed
out that the right fix would be in the NVMe driver?

Is there an issue with fixing the NVMe driver?

> 
> Signed-off-by: Jianxiong Gao <jxgao@google.com>
> ---
>  kernel/dma/swiotlb.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 7c42df6e6100..4cab35f2c9bc 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -468,7 +468,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
>  	dma_addr_t tbl_dma_addr = phys_to_dma_unencrypted(hwdev, io_tlb_start);
>  	unsigned long flags;
>  	phys_addr_t tlb_addr;
> -	unsigned int nslots, stride, index, wrap;
> +	unsigned int nslots, stride, index, wrap, page_offset_mask, page_offset;
>  	int i;
>  	unsigned long mask;
>  	unsigned long offset_slots;
> @@ -500,12 +500,16 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
>  		    ? ALIGN(mask + 1, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT
>  		    : 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
>  
> +	page_offset_mask = dma_get_page_offset_mask(hwdev);
> +	page_offset = orig_addr & page_offset_mask;
> +	alloc_size += page_offset;
> +
>  	/*
>  	 * For mappings greater than or equal to a page, we limit the stride
>  	 * (and hence alignment) to a page size.
>  	 */
>  	nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
> -	if (alloc_size >= PAGE_SIZE)
> +	if ((alloc_size >= PAGE_SIZE) || (page_offset_mask > (1 << IO_TLB_SHIFT)))
>  		stride = (1 << (PAGE_SHIFT - IO_TLB_SHIFT));
>  	else
>  		stride = 1;
> @@ -583,6 +587,11 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
>  	 */
>  	for (i = 0; i < nslots; i++)
>  		io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
> +	/*
> +	 * When keeping the offset of the original data, we need to advance
> +	 * the tlb_addr by the offset of orig_addr.
> +	 */
> +	tlb_addr += page_offset;
>  	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
>  	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
>  		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
> @@ -598,7 +607,9 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
>  			      enum dma_data_direction dir, unsigned long attrs)
>  {
>  	unsigned long flags;
> -	int i, count, nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
> +	unsigned int num_page_offset_slabs, page_offset_mask = dma_get_page_offset_mask(hwdev);
> +	int i, count;
> +	int nslots = ALIGN(alloc_size + tlb_addr & page_offset_mask, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
>  	int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
>  	phys_addr_t orig_addr = io_tlb_orig_addr[index];
>  
> @@ -610,6 +621,14 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
>  	    ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
>  		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_FROM_DEVICE);
>  
> +	/*
> +	 * When dma_get_page_offset_mask is used, we may have padded more slabs
> +	 * when padding exceeds one slab. We need to move index back to the
> +	 * beginning of the padding.
> +	 */
> +	num_page_offset_slabs =  (tlb_addr & page_offset_mask) / (1 << IO_TLB_SHIFT);
> +	index -= num_page_offset_slabs;
> +
>  	/*
>  	 * Return the buffer to the free list by setting the corresponding
>  	 * entries to indicate the number of contiguous entries available.
> -- 
> 2.27.0
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
