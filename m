Return-Path: <SRS0=CQHw=AA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A45C433E0
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 18:56:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EF9A20EDD
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 18:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ND6zrUqU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="jpc0e6X0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF9A20EDD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 49A8287179;
	Fri, 19 Jun 2020 18:56:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XXA1f7Qm4Mc6; Fri, 19 Jun 2020 18:56:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2184D870EE;
	Fri, 19 Jun 2020 18:56:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 018A3C0865;
	Fri, 19 Jun 2020 18:56:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CEDEC016E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 18:55:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E53FF870EE
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 18:55:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mr8HZuzSHVov for <iommu@lists.linux-foundation.org>;
 Fri, 19 Jun 2020 18:55:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 52A1286FB4
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 18:55:56 +0000 (UTC)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05JIq8c7020159; Fri, 19 Jun 2020 11:55:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=mTUlJ66MkbEa0yQNtLrQIc75fWjZHpxWE7fs6/TEYzg=;
 b=ND6zrUqUF7IzkaS+NvgI2VTf4svTApL4zVdTQaNx5LvcFI15GG+N0LBAzbvkRkpebVbX
 J2Kq2tReWRtzqPTmIJBtGq7jME6aK3Qkw9cmTfLgD1gIkTEJogceq40puzQuzu0BhzXP
 D134pYC8Bwteqvwb3hd6Tv9WC788Tz96jjs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
 by mx0a-00082601.pphosted.com with ESMTP id 31q66161p3-7
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 19 Jun 2020 11:55:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 11:55:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYty7J/pDagNg70bmp0j/b1pDrQd9r2NgN7aM8bLxXToRhz3FsAjc57NKSS11OQZJdMs1LC4w15Gga57lrt8VKjCHOac1ZaDm/Fco4Qo+9FhJANZZhZnSfR7ayLnfrWhp8Pv4Gz1cwXn41Pb6T8wiNWHb5Ob1PV2upfUfy1vC+ARPRCws+aUNr+XUUm6n30qGg059q5MqDvVXjUwPqa2gkPj0U6jlsH8FiD+z+aSGfK7XybcK7TMTRljkCcF4A+uChTKvsE4sFhBIDPi328TcA/7VRvGYtuTw2ee1oj/+2puRAlyQgz2GGpo0IfhUien3HC0hCzq/5sPT5/jp45Rsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTUlJ66MkbEa0yQNtLrQIc75fWjZHpxWE7fs6/TEYzg=;
 b=gKqg33EPyVgSMfuRL+WCjQZENhSnd7QsJZE6WdBYaJW0gEeDo7tjbOzJa+/KRd2Yyu2eCWA63XpcCBOBG9CHuqqvplbnetdlQgVhFkT3aZWa2ibhngpKkH6xmXmDa+8U8C03Cg7ErEoPdn9PH2oLQuiUu7yQyjPu6vqAoMz0vo1HyNIwRaDOhoZ3GHXPahSLJwGk8/kQdbRZzwYI9dP0t4ZoEZkqVAAzomZsZMn6NK/5WpZa91LmWFMuJEYX70rlt1l1Ipw/ZgiDvTUuDxVsqHmAFTklZ47U+rjfgS5mFtlfpmX8VMKIcSe0MtRlZWEzIwUbyuoOJTw6lb3ol4bLLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTUlJ66MkbEa0yQNtLrQIc75fWjZHpxWE7fs6/TEYzg=;
 b=jpc0e6X02/YBpEcSgLMGjDZr8XN3JYYeEk6RLFBlmImUjibRMw4rgsN+4/R7p/ZAX8f92R61RN2fODGEd3yGB13hFbTVzE5j3NZF3Youl0V3aWRT6qrWNLf2rpAsHzjy5ywWM/fyPxjSi3UytBKVXZNpt+B7twltxc3SmHLDcls=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2280.namprd15.prod.outlook.com (2603:10b6:a02:8a::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Fri, 19 Jun
 2020 18:55:44 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 18:55:43 +0000
Date: Fri, 19 Jun 2020 11:55:40 -0700
To: Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: kernel BUG at mm/huge_memory.c:2613!
Message-ID: <20200619185540.GB217189@carbon.lan>
References: <20200619001938.GA135965@carbon.dhcp.thefacebook.com>
 <CAHbLzkrDcn-GQOrAM=m7+2g5_J6obsz4K50Oqb-1RD5p1iWTPQ@mail.gmail.com>
 <20200619011449.GC135965@carbon.dhcp.thefacebook.com>
 <20200619024026.GB21081@redhat.com>
Content-Disposition: inline
In-Reply-To: <20200619024026.GB21081@redhat.com>
X-ClientProxiedBy: BYAPR07CA0043.namprd07.prod.outlook.com
 (2603:10b6:a03:60::20) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:c16d) by
 BYAPR07CA0043.namprd07.prod.outlook.com (2603:10b6:a03:60::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 18:55:43 +0000
X-Originating-IP: [2620:10d:c090:400::5:c16d]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9cdfd13-f798-4ba8-e4d6-08d814825e7c
X-MS-TrafficTypeDiagnostic: BYAPR15MB2280:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2280858110090037166A7E67BE980@BYAPR15MB2280.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sf74MJoT0bfj/AZliQSgrCH0W2+L20Unyj3EAGkKawZckQv8XqH4uF/+VMaPoGz6tbUYwo9eaEgfK6fz3/ISF8ioSN42pC8sPI2qVYLZZaWdyKb/sZK6fN/2WjtQHdB5Ea9U2UnHgbNAXw6srWhiQL8gL9BLAhqleYyjE6aRqz01bAtqnfHYJv44U5T/yB2x6o8T7Ho1DGvAshCHdP0Rmf1DpR+4W7bUyRdHvVQBVnrTOB25/NFIat4Rp02ehq8bC9WqY3OVIVsFxwthCsshCRgh5aNwP07dF7mF6YBdXeNJ+38hPRepQubhaxRdO1DYrLo8QbJ79o71AQoQpoQfJyHn6cr+zBjGa8salPVK6d0cTfyLzqob2ZQfrs8XzVZOaw9mHbhc7Jblu5pGH5+Buw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR15MB4136.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(39860400002)(366004)(376002)(396003)(136003)(83380400001)(52116002)(478600001)(30864003)(9686003)(7696005)(66946007)(45080400002)(5660300002)(66556008)(66476007)(6506007)(86362001)(316002)(7416002)(186003)(55016002)(4326008)(8676002)(8886007)(33656002)(2906002)(8936002)(54906003)(6916009)(36756003)(1076003)(16526019)(27376004)(14583001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: N/C3CziVjnXD+qz34GEtxa9qYNEK0yaSoDhny96ItYxLPRneAYEk/nYzuGqckZ2UhtR3Xe60lVeH27xF+JaGHdEtj9eNnke7VeBBVO10zHAd8LUh1BMsaCCV2SuEStwFeHEBVwZN+DeH37bufeJTKQ9epE5u4NYgkswYvxaMc8ehyZaf3wQbwPDoxG1JfNfASOxWjo1jdlGrKPj48JXS6nSsuuSQrPxQeeTvtE7mrdQKryFR5k4DFLf2UJDVJbFCHDh9YyvINPnCqJONbnTfPdG9SAJvu0AHVPIJnLCtcTVWllS4o9CE93KV2BhHeAk/MTgtvATG10KrFIj/gysRU8dfHgvpkQ8nyy3n+Yhu/cH3pUZUILkz1CJAiz3ThR7vfVPYqvpmVNIuk5NQgwNLvlkQln0GdFIzX07MAajFRswlPIpmEKGg3bT/KX0RaSGoEniT+AKfONZHIjZoKrrYSQduQA6vDnWrk4FB1H5RF1cgM51yVMFBY3BM8KVvLRtHeObq0UTMtAGFLgQNJBr2uQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d9cdfd13-f798-4ba8-e4d6-08d814825e7c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 18:55:43.7750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: roMj2R6TFcVNkTg9zzoVCbg81qGzuLQNHl3Puq236Tb8z4eEB5E/wfwbZX/z4XNp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2280
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-19_21:2020-06-19,
 2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 suspectscore=7
 clxscore=1015 mlxscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 malwarescore=0
 cotscore=-2147483648 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006190136
X-FB-Internal: deliver
Cc: Yang Shi <shy828301@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Michal Hocko <mhocko@kernel.org>, Linux MM <linux-mm@kvack.org>,
 iommu@lists.linux-foundation.org, Wei Yang <richardw.yang@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>
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

On Thu, Jun 18, 2020 at 10:40:26PM -0400, Andrea Arcangeli wrote:
> Hello,
> 
> On Thu, Jun 18, 2020 at 06:14:49PM -0700, Roman Gushchin wrote:
> > I agree. The whole
> > 
> > 	page = alloc_pages_node(nid, alloc_flags, order);
> > 	if (!page)
> > 		continue;
> > 	if (!order)
> > 		break;
> > 	if (!PageCompound(page)) {
> > 		split_page(page, order);
> > 		break;
> > 	} else if (!split_huge_page(page)) {
> > 		break;
> > 	}
> > 
> > looks very suspicious to me.
> > My wild guess is that gfp flags changed somewhere above, so we hit
> > the branch which was never hit before.
> 
> Right to be suspicious about the above: split_huge_page on a regular
> page allocated by a driver was never meant to work.
> 
> The PageLocked BUG_ON is just a symptom of a bigger issue, basically
> split_huge_page it may survive, but it'll stay compound and in turn it
> must be freed as compound.
> 
> The respective free method doesn't even contemplate freeing compound
> pages, the only way the free method can survive, is by removing
> __GFP_COMP forcefully in the allocation that was perhaps set here
> (there are that many __GFP_COMP in that directory):
> 
> static void snd_malloc_dev_pages(struct snd_dma_buffer *dmab, size_t size)
> {
> 	gfp_t gfp_flags;
> 
> 	gfp_flags = GFP_KERNEL
> 		| __GFP_COMP	/* compound page lets parts be mapped */
> 
> And I'm not sure what the comment means here, compound or non compound
> doesn't make a difference when you map it, it's not a THP, the
> mappings must be handled manually so nothing should check PG_compound
> anyway in the mapping code.
> 
> Something like this may improve things, it's an untested quick hack,
> but this assumes it's always a bug to setup a compound page for these
> DMA allocations and given the API it's probably a correct
> assumption.. Compound is slower, unless you need it, you can avoid it
> and then split_page will give contiguous memory page granular. Ideally
> the code shouldn't call split_page at all and it should free it all at
> once by keeping track of the order and by returning the order to the
> caller, something the API can't do right now as it returns a plain
> array that can only represent individual small pages.
> 
> Once this is resolved, you may want to check your config, iommu passthrough
> sounds more optimal for a soundcard.

It's based on the default Fedora 32 config + all defaults for the 5.6..5.8-rc1
difference. But thanks for the advice!

> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index f68a62c3c32b..3dfbc010fa83 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -499,6 +499,10 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
>  
>  	/* IOMMU can map any pages, so himem can also be used here */
>  	gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
> +	if (unlikely(gfp & __GFP_COMP)) {
> +		WARN();
> +		gfp &= ~__GFP_COMP;
> +	}
>  
>  	while (count) {
>  		struct page *page = NULL;
> @@ -522,13 +526,8 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
>  				continue;
>  			if (!order)
>  				break;
> -			if (!PageCompound(page)) {
> -				split_page(page, order);
> -				break;
> -			} else if (!split_huge_page(page)) {
> -				break;
> -			}
> -			__free_pages(page, order);
> +			split_page(page, order);
> +			break;
>  		}
>  		if (!page) {
>  			__iommu_dma_free_pages(pages, i);
> diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
> index 6850d13aa98c..378f5a36ec5f 100644
> --- a/sound/core/memalloc.c
> +++ b/sound/core/memalloc.c
> @@ -28,7 +28,6 @@ static void snd_malloc_dev_pages(struct snd_dma_buffer *dmab, size_t size)
>  	gfp_t gfp_flags;
>  
>  	gfp_flags = GFP_KERNEL
> -		| __GFP_COMP	/* compound page lets parts be mapped */
>  		| __GFP_NORETRY /* don't trigger OOM-killer */
>  		| __GFP_NOWARN; /* no stack trace print - this call is non-critical */
>  	dmab->area = dma_alloc_coherent(dmab->dev.dev, size, &dmab->addr,
> 
> 

The patch looks very good to me, but unfortunately it seems to reveal
the next layer of problems:

[   23.864671] page:ffffcd0a8fc3a3c0 refcount:0 mapcount:0
mapping:0000000000000000 index:0x0
[   23.864674] flags: 0x17ffffc0000800(arch_1)
[   23.864678] raw: 0017ffffc0000800 0000000000000000 ffffcd0a8fc3a388
0000000000000000
[   23.864680] raw: 0000000000000000 0000000000000000 00000000ffffffff
0000000000000000
[   23.864705] page dumped because: VM_BUG_ON_PAGE(((unsigned int)
page_ref_count(page) + 127u <= 127u))
[   23.864771] ------------[ cut here ]------------
[   23.864771] kernel BUG at include/linux/mm.h:1137!
[   23.864783] invalid opcode: 0000 [#1] SMP NOPTI
[   23.864787] CPU: 14 PID: 1876 Comm: alsa-sink-HDMI  Not tainted
5.8.0-rc1+ #697
[   23.864788] Hardware name: Gigabyte Technology Co., Ltd.
AB350-Gaming/AB350-Gaming-CF, BIOS F25 01/16/2019
[   23.864799] RIP: 0010:snd_pcm_mmap_data_fault+0xe3/0x110 [snd_pcm]
[   23.864802] Code: 00 00 80 48 2b 05 f5 01 7a e1 48 01 f8 48 c1 e8
0c 48 c1 e0 06 48 03 05 d3 01 7a e1 eb 83 48 c7 c6 88 a9 cb c0 e8 bd
4f 5e e0 <0f> 0b 4c 89 c7 e8 23 53 60 e0 e9 68 ff ff ff e8 b9 af 00 00
e9 5e
[   23.864804] RSP: 0000:ffffa77b82477df0 EFLAGS: 00010286
[   23.864808] RAX: 0000000000000000 RBX: ffffa77b82477e30 RCX: 0000000000000000
[   23.864812] RDX: ffff90f78efa7060 RSI: 0000000000000000 RDI: ffff90f78ef98d00
[   23.864813] RBP: ffff90f76d164bb8 R08: 0000000000000548 R09: 0000000000000003
[   23.864815] R10: 0000000000000000 R11: 0000000000000001 R12: ffffa77b82477e30
[   23.864817] R13: 00000000000007b8 R14: ffff90f76d164bb8 R15: ffff90f78d1eb300
[   23.864820] FS:  00007f971efbf700(0000) GS:ffff90f78ef80000(0000)
knlGS:0000000000000000
[   23.864821] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   23.864823] CR2: 00007f971efcffa0 CR3: 00000003ffaa4000 CR4: 00000000003406e0
[   23.864825] Call Trace:
[   23.864834]  __do_fault+0x36/0x100
[   23.864838]  handle_mm_fault+0x11e3/0x1970
[   23.864846]  do_user_addr_fault+0x1f9/0x490
[   23.864853]  exc_page_fault+0x81/0x1a0
[   23.864858]  ? asm_exc_page_fault+0x8/0x30
[   23.864861]  asm_exc_page_fault+0x1e/0x30
[   23.864864] RIP: 0033:0x7f9730baba08
[   23.864866] Code: Bad RIP value.
[   23.864867] RSP: 002b:00007f971efbc538 EFLAGS: 00010202
[   23.864869] RAX: 00007f971efc0000 RBX: 0000000000000001 RCX: 00007f971efc0080
[   23.864871] RDX: 000000000000ffc0 RSI: 0000000000000000 RDI: 00007f971efc0000
[   23.864872] RBP: 00007f971efbec90 R08: 0000000000000004 R09: 000000000000ffc0
[   23.864874] R10: 0000000000020000 R11: 0000000000000000 R12: 00007f971efbec90
[   23.864876] R13: 00005630003cc1b0 R14: 00007f971efbc640 R15: 00005630003cc140
[   23.864880] Modules linked in: xt_CHECKSUM xt_MASQUERADE
xt_conntrack ipt_REJECT nf_nat_tftp nf_conntrack_tftp tun bridge stp
llc ccm nft_objref nf_conntrack_netbios_ns nf_conntrack_broadcast
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat
nf_tables ebtable_nat ebtable_broute ip6table_nat ip6table_mangle
ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw
iptable_security ip_set nfnetlink ebtable_filter ebtables
ip6table_filter ip6_tables iptable_filter cmac bnep sunrpc vfat fat
iwlmvm edac_mce_amd mac80211 kvm_amd snd_hda_codec_realtek libarc4
snd_hda_codec_generic snd_hda_codec_hdmi ledtrig_audio iwlwifi kvm
snd_hda_intel snd_intel_dspcfg irqbypass snd_usb_audio cfg80211
snd_hda_codec wmi_bmof snd_usbmidi_lib snd_rawmidi mc snd_hda_core
pcspkr snd_seq snd_hwdep snd_seq_device k10temp btusb snd_pcm
sp5100_tco btrtl i2c_piix4 btbcm btintel
[   23.864918]  bluetooth snd_timer snd soundcore ecdh_generic rfkill
ecc gpio_amdpt gpio_generic acpi_cpufreq ip_tables amdgpu iommu_v2
gpu_sched i2c_algo_bit ttm drm_kms_helper crct10dif_pclmul
crc32_pclmul drm ghash_clmulni_intel ccp r8169 nvme nvme_core wmi
pinctrl_amd btrfs blake2b_generic libcrc32c crc32c_intel xor raid6_pq
fuse
[   23.864940] ---[ end trace a6b3dead26df473b ]---
[   23.864947] RIP: 0010:snd_pcm_mmap_data_fault+0xe3/0x110 [snd_pcm]
[   23.864951] Code: 00 00 80 48 2b 05 f5 01 7a e1 48 01 f8 48 c1 e8
0c 48 c1 e0 06 48 03 05 d3 01 7a e1 eb 83 48 c7 c6 88 a9 cb c0 e8 bd
4f 5e e0 <0f> 0b 4c 89 c7 e8 23 53 60 e0 e9 68 ff ff ff e8 b9 af 00 00
e9 5e
[   23.864954] RSP: 0000:ffffa77b82477df0 EFLAGS: 00010286
[   23.864956] RAX: 0000000000000000 RBX: ffffa77b82477e30 RCX: 0000000000000000
[   23.864958] RDX: ffff90f78efa7060 RSI: 0000000000000000 RDI: ffff90f78ef98d00
[   23.864960] RBP: ffff90f76d164bb8 R08: 0000000000000548 R09: 0000000000000003
[   23.864961] R10: 0000000000000000 R11: 0000000000000001 R12: ffffa77b82477e30
[   23.864963] R13: 00000000000007b8 R14: ffff90f76d164bb8 R15: ffff90f78d1eb300
[   23.864965] FS:  00007f971efbf700(0000) GS:ffff90f78ef80000(0000)
knlGS:0000000000000000
[   23.864967] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   23.864968] CR2: 00007f971efcffa0 CR3: 00000003ffaa4000 CR4: 00000000003406e0
[   39.037054] rfkill: input handler enabled
[   40.287524] BUG: unable to handle page fault for address: ffffa77b833df000
[   40.287529] #PF: supervisor write access in kernel mode
[   40.287531] #PF: error_code(0x000b) - reserved bit violation
[   40.287532] PGD 40d14e067 P4D 40d14e067 PUD 40d14f067 PMD 3ec54d067
PTE 80001688033d9163
[   40.287538] Oops: 000b [#2] SMP NOPTI
[   40.287542] CPU: 9 PID: 1986 Comm: pulseaudio Tainted: G      D
      5.8.0-rc1+ #697
[   40.287544] Hardware name: Gigabyte Technology Co., Ltd.
AB350-Gaming/AB350-Gaming-CF, BIOS F25 01/16/2019
[   40.287550] RIP: 0010:__memset+0x24/0x30
[   40.287553] Code: cc cc cc cc cc cc 0f 1f 44 00 00 49 89 f9 48 89
d1 83 e2 07 48 c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48
0f af c6 <f3> 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89
d1 f3
[   40.287556] RSP: 0018:ffffa77b827a7e08 EFLAGS: 00010216
[   40.287558] RAX: 0000000000000000 RBX: ffff90f77dced800 RCX: 00000000000008a0
[   40.287560] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffa77b833df000
[   40.287561] RBP: ffff90f7898c7000 R08: ffff90f78c507768 R09: ffffa77b833df000
[   40.287563] R10: ffffa77b833df000 R11: ffff90f7839f2d40 R12: 0000000000000000
[   40.287564] R13: ffff90f76a802e00 R14: ffffffffc0cb8880 R15: ffff90f770f4e700
[   40.287567] FS:  00007f3d8e8df880(0000) GS:ffff90f78ee40000(0000)
knlGS:0000000000000000
[   40.287569] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   40.287570] CR2: ffffa77b833df000 CR3: 00000003fa556000 CR4: 00000000003406e0
[   40.287572] Call Trace:
[   40.287584]  snd_pcm_hw_params+0x3fd/0x490 [snd_pcm]
[   40.287593]  snd_pcm_common_ioctl+0x1c5/0x1110 [snd_pcm]
[   40.287601]  ? snd_pcm_info_user+0x64/0x80 [snd_pcm]
[   40.287608]  snd_pcm_ioctl+0x23/0x30 [snd_pcm]
[   40.287613]  ksys_ioctl+0x82/0xc0
[   40.287617]  __x64_sys_ioctl+0x16/0x20
[   40.287622]  do_syscall_64+0x4d/0x90
[   40.287627]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   40.287630] RIP: 0033:0x7f3d8f21047b
[   40.287631] Code: Bad RIP value.
[   40.287632] RSP: 002b:00007ffe22938b08 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[   40.287635] RAX: ffffffffffffffda RBX: 00007ffe22938d50 RCX: 00007f3d8f21047b
[   40.287636] RDX: 00007ffe22938d50 RSI: 00000000c2604111 RDI: 000000000000001d
[   40.287637] RBP: 000055dc9480fdf0 R08: 0000000000000000 R09: 0000000000000000
[   40.287639] R10: 0000000000000004 R11: 0000000000000246 R12: 000055dc9480fd70
[   40.287640] R13: 00007ffe22938b44 R14: 0000000000000000 R15: 00007ffe22938d50
[   40.287644] Modules linked in: xt_CHECKSUM xt_MASQUERADE
xt_conntrack ipt_REJECT nf_nat_tftp nf_conntrack_tftp tun bridge stp
llc ccm nft_objref nf_conntrack_netbios_ns nf_conntrack_broadcast
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat
nf_tables ebtable_nat ebtable_broute ip6table_nat ip6table_mangle
ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw
iptable_security ip_set nfnetlink ebtable_filter ebtables
ip6table_filter ip6_tables iptable_filter cmac bnep sunrpc vfat fat
iwlmvm edac_mce_amd mac80211 kvm_amd snd_hda_codec_realtek libarc4
snd_hda_codec_generic snd_hda_codec_hdmi ledtrig_audio iwlwifi kvm
snd_hda_intel snd_intel_dspcfg irqbypass snd_usb_audio cfg80211
snd_hda_codec wmi_bmof snd_usbmidi_lib snd_rawmidi mc snd_hda_core
pcspkr snd_seq snd_hwdep snd_seq_device k10temp btusb snd_pcm
sp5100_tco btrtl i2c_piix4 btbcm btintel
[   40.287688]  bluetooth snd_timer snd soundcore ecdh_generic rfkill
ecc gpio_amdpt gpio_generic acpi_cpufreq ip_tables amdgpu iommu_v2
gpu_sched i2c_algo_bit ttm drm_kms_helper crct10dif_pclmul
crc32_pclmul drm ghash_clmulni_intel ccp r8169 nvme nvme_core wmi
pinctrl_amd btrfs blake2b_generic libcrc32c crc32c_intel xor raid6_pq
fuse
[   40.287708] CR2: ffffa77b833df000
[   40.287711] ---[ end trace a6b3dead26df473c ]---
[   40.287717] RIP: 0010:snd_pcm_mmap_data_fault+0xe3/0x110 [snd_pcm]
[   40.287720] Code: 00 00 80 48 2b 05 f5 01 7a e1 48 01 f8 48 c1 e8
0c 48 c1 e0 06 48 03 05 d3 01 7a e1 eb 83 48 c7 c6 88 a9 cb c0 e8 bd
4f 5e e0 <0f> 0b 4c 89 c7 e8 23 53 60 e0 e9 68 ff ff ff e8 b9 af 00 00
e9 5e
[   40.287722] RSP: 0000:ffffa77b82477df0 EFLAGS: 00010286
[   40.287724] RAX: 0000000000000000 RBX: ffffa77b82477e30 RCX: 0000000000000000
[   40.287725] RDX: ffff90f78efa7060 RSI: 0000000000000000 RDI: ffff90f78ef98d00
[   40.287726] RBP: ffff90f76d164bb8 R08: 0000000000000548 R09: 0000000000000003
[   40.287728] R10: 0000000000000000 R11: 0000000000000001 R12: ffffa77b82477e30
[   40.287729] R13: 00000000000007b8 R14: ffff90f76d164bb8 R15: ffff90f78d1eb300
[   40.287731] FS:  00007f3d8e8df880(0000) GS:ffff90f78ee40000(0000)
knlGS:0000000000000000
[   40.287733] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   40.287734] CR2: ffffa77b833df000 CR3: 00000003fa556000 CR4: 00000000003406e0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
