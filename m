Return-Path: <SRS0=U3VV=7Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2933CC433DF
	for <iommu@archiver.kernel.org>; Wed,  3 Jun 2020 03:55:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D6E420674
	for <iommu@archiver.kernel.org>; Wed,  3 Jun 2020 03:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Od6033S8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Mh7Cw6/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6E420674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4470A87DC5;
	Wed,  3 Jun 2020 03:55:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2WxfGda5KYxx; Wed,  3 Jun 2020 03:55:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 83C1887D5A;
	Wed,  3 Jun 2020 03:55:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 737CAC0178;
	Wed,  3 Jun 2020 03:55:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD4DBC016E
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 03:24:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BEC8086354
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 03:24:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kdSIxRwuhYQp for <iommu@lists.linux-foundation.org>;
 Wed,  3 Jun 2020 03:24:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9B37386294
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 03:24:13 +0000 (UTC)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
 by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0533DnYY010998;
 Tue, 2 Jun 2020 20:22:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=zbGG/PNuS0Ddo/tqnRwkl7V0MeS0ved7nGwtiiC1XYI=;
 b=Od6033S81ZztH9Pgvx9m7MxU+QUwhEaxN4nGzRqN5R+LlonE/VmQ+TDp8gzxBOPrlIwb
 DfL6Y0QcZ96QLqAQD3MDWi43gQmklfmltL36SER2wKchNGHbq4/0fbv6DcZntHIJ+gf+
 fWyqRTrfg7hCEqtoLAbPbh8l3lqAoN9INYY= 
Received: from mail.thefacebook.com ([163.114.132.120])
 by m0001303.ppops.net with ESMTP id 31bk5npkxu-11
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 02 Jun 2020 20:22:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 2 Jun 2020 20:22:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnncRHK093QtCvHEGBXRZGjSsP84I5mrCkKqf3IBWUOfUidGIyAWSU/nXO316jyfDkfarFIvj/23lsH0DZR6FIe7ayd2XfbinlA/t57aTcQMrDM1i5Y3DYK0JKX97xslHFpEMYxsd3ZeU99nGwA7s7lXJJe8Mr7CjhDAwlquKnhOcr8L1h0FlSPBXFlAbpXtWddiydAoai0Fcb7Ko7KCD3lytKDvcNJQn5Bzw0GRYLQ2gxnD8ujWOpgPTzvmdmjKurKkIGtax2WUWO0JeKMeR4DwHzvDQxZyASr9EBa1VHpN2AcJVWYhYktZPKc96oPwqq0/Ng/n3grumq5dyFUqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbGG/PNuS0Ddo/tqnRwkl7V0MeS0ved7nGwtiiC1XYI=;
 b=KxeYYxxmX0WS0YVL/jJES2Wfj2xTH8sHGcOxN+JNoeTEEzTRbzedKdARzqB/+BswmizdDMK4I4rX3KxdElI7DeSgOAB6CzLex+ObF14uRUR2tA4CUstzcKudUFExcrn5svk3ZokIMsA6gIDqH70XebaiUTLDEVngrDsOgUOwsXWwM3kN2pw/J9SDA29v6cvb390K+Dgkiqf2MyYwss31r5vLPbKp7SHE6XN3aHG+FNZfUUagNyMoQtIN9gujj88zR4OJWnKau3vn7HMvuWosBVcvZBrlcbAB+WzUEUFqXbzfM0yFOfmERts9mStkxrEnppDLlSBTBVPQlBnBkjH8tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbGG/PNuS0Ddo/tqnRwkl7V0MeS0ved7nGwtiiC1XYI=;
 b=Mh7Cw6/w8aUadl3LtSK4zz7M/7+xasDG1EXTDnM1gLn0egDtkhKu0ljPqJW9MymSa6vkmq2lD891tnr9NoBmKhoWW/JBZeIjyazBfI1z37TpfVYNzpla2Hyjm4Ib9osrBBLZMMRVqwV8fjHoY0Tnu0tL0YAQgLPdTrEgjIBhMBY=
Authentication-Results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2775.namprd15.prod.outlook.com (2603:10b6:a03:15a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.22; Wed, 3 Jun
 2020 03:22:22 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 03:22:22 +0000
Date: Tue, 2 Jun 2020 20:22:19 -0700
To: Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH 2/3] arm64: mm: reserve hugetlb CMA after numa_init
Message-ID: <20200603032219.GA548147@carbon.lan>
References: <20200603024231.61748-1-song.bao.hua@hisilicon.com>
 <20200603024231.61748-3-song.bao.hua@hisilicon.com>
Content-Disposition: inline
In-Reply-To: <20200603024231.61748-3-song.bao.hua@hisilicon.com>
X-ClientProxiedBy: BY5PR17CA0019.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::32) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:7f8a) by
 BY5PR17CA0019.namprd17.prod.outlook.com (2603:10b6:a03:1b8::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Wed, 3 Jun 2020 03:22:22 +0000
X-Originating-IP: [2620:10d:c090:400::5:7f8a]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90224910-3e4a-410c-b069-08d8076d5497
X-MS-TrafficTypeDiagnostic: BYAPR15MB2775:
X-Microsoft-Antispam-PRVS: <BYAPR15MB277541654E5DD80938CE9889BE880@BYAPR15MB2775.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0CqFG0KZk9EzO+Rc8DAadWRgnNb0cSxDO6ofkgxAq3ywLey46ZJ3kbpDvrf3al9ex/ITfUdGc3wcwnbJhSLX4TKuNIgkpLJXSRrnlwVdqBK61CyNLxgD/OyVqCJ766W8IgHloElbVt2wo7Pyk9mcVjRgVyyvTsdACHRSgJXm9aggseYfLhjmnIyMhSkthu4tsqIDFvmyPMI9AWgCWzljKYBkp1SVh7WvecegVjm3fkIz5d6R3886pwCnF6f1V2oy9bCOf4ZwRDoEV/n5ujfnGBUmJf4YX2M1bUgGdNySSHXY28TCc5MSzu9CMfTyDOODh0rXoTV+qyidEkmRouPILR3RLV+QSv9V9d1FjIaFmgvnVACDjzTuWSDNxgiCmf9V
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR15MB4136.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39860400002)(136003)(396003)(366004)(346002)(376002)(6666004)(1076003)(83380400001)(8936002)(8676002)(8886007)(6916009)(2906002)(7416002)(6506007)(9686003)(4326008)(36756003)(66476007)(86362001)(66556008)(66946007)(5660300002)(16526019)(316002)(52116002)(7696005)(478600001)(33656002)(55016002)(186003)(27376004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: qUA8nK+yjOLwiXVD4fCKV9HDpuTLpEEhCz1MwTamxJ3C2IwkqSXK4gi23VxsOEWFdCCDo0NLYvwIVoagDcqNTNTQcwDx36E057rsiQnW/AfYaIAKvKqeepKem3Vks00uWt6TuYZdvgdNh1/1Vi1P9FkLTVCxYmjeG8xFrAATpyX91cN5a+2sCD3vEaMHMeTMA28Xkr9A0O1PT3nyLrTefanfUQNwMGf20w10VRmVLfUPT302Iwhcp++T1RbZH9XhRiVz6x6enst1Y+r1rm9tf23gDZzJ1SsdaGQvi/zQPXf00hfXoGSs2HcRg+Z59+JgukMZu7D37UyR4Dpd5qG3WRBWUdFDFXpca5BzXUjaZfZvrP0fCJM8TrdpLmqZHqNKrWPLS8g6MCfY9/hoRoSdRuz62kdVRL3V0lFXdssoLoYNheVZFxPwjJbJDCvoXt7tgfalo5kpFuOztdnOZTF1cPzV+4nP0q73wuCXGime/h+gW9HHkyPrsJS16+vCbkTeN9Rx9fpyqf0SRmquZUp8Nw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 90224910-3e4a-410c-b069-08d8076d5497
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 03:22:22.7500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMiiHkMubMoC9AeGv/pnWpAgPyGWf0mRZ+4lDn8WaOd0zhwQM9uuuPMmHlC0HtEK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2775
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-02_15:2020-06-02,
 2020-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 spamscore=0
 impostorscore=0 clxscore=1011 malwarescore=0 suspectscore=1
 mlxlogscore=999 cotscore=-2147483648 phishscore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006030025
X-FB-Internal: deliver
X-Mailman-Approved-At: Wed, 03 Jun 2020 03:55:56 +0000
Cc: catalin.marinas@arm.com, linux-kernel@vger.kernel.org, linuxarm@huawei.com,
 iommu@lists.linux-foundation.org, prime.zeng@hisilicon.com,
 robin.murphy@arm.com, hch@lst.de, linux-arm-kernel@lists.infradead.org
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
From: Roman Gushchin via iommu <iommu@lists.linux-foundation.org>
Reply-To: Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Jun 03, 2020 at 02:42:30PM +1200, Barry Song wrote:
> hugetlb_cma_reserve() is called at the wrong place. numa_init has not been
> done yet. so all reserved memory will be located at node0.
> 
> Cc: Roman Gushchin <guro@fb.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!

> ---
>  arch/arm64/mm/init.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index e42727e3568e..8f0e70ebb49d 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -458,11 +458,6 @@ void __init arm64_memblock_init(void)
>  	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
>  
>  	dma_contiguous_reserve(arm64_dma32_phys_limit);
> -
> -#ifdef CONFIG_ARM64_4K_PAGES
> -	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> -#endif
> -
>  }
>  
>  void __init bootmem_init(void)
> @@ -478,6 +473,11 @@ void __init bootmem_init(void)
>  	min_low_pfn = min;
>  
>  	arm64_numa_init();
> +
> +#ifdef CONFIG_ARM64_4K_PAGES
> +	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> +#endif
> +
>  	/*
>  	 * Sparsemem tries to allocate bootmem in memory_present(), so must be
>  	 * done after the fixed reservations.
> -- 
> 2.23.0
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
