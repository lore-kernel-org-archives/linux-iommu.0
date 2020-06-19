Return-Path: <SRS0=CQHw=AA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A466BC433E1
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 01:15:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3709520776
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 01:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DV8E1vP9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="G5AK52BI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3709520776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4E5A726808;
	Fri, 19 Jun 2020 01:15:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lJ0xr1HuqYCC; Fri, 19 Jun 2020 01:15:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EBCFC231A1;
	Fri, 19 Jun 2020 01:15:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D881EC088C;
	Fri, 19 Jun 2020 01:15:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76A5AC016E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 01:15:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5E12F87D0D
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 01:15:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Inn2myFefS49 for <iommu@lists.linux-foundation.org>;
 Fri, 19 Jun 2020 01:15:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2B4C087BA4
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 01:15:06 +0000 (UTC)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05J15m1C018904; Thu, 18 Jun 2020 18:14:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=vu8KwpiSVKlYcXXfTU224pzj/w/3WGsei6eE22btJ9Y=;
 b=DV8E1vP9FRBE7ZEtK2YGG9w7icNUoeMEdDmzzXhYoxmePxqdShlNiBjEX5VbpU7qADhm
 oNi49Zxu3XbehfS3rXz2/A7Td8jjYs6RHw0/ZC5WMZqyrTtd+ZRxcTLLMryKwtLESCaL
 kP/e9Vu0X/iiQ8Id1APISEMpC1NIYxAoJpc= 
Received: from mail.thefacebook.com ([163.114.132.120])
 by mx0a-00082601.pphosted.com with ESMTP id 31q660yd0v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 18 Jun 2020 18:14:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 18:14:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwgYCO3sQ+S0nL96/dC6fdsvm3ctAwTyGEOJcLUSfyMCwsR3CgqnMpv264ifcZdUc18E1G0lQDiHLZDW8FGNjmKuSegJGiQDjL/MM5doIlE0gxXs9IcQUXZxeuSW24bVSun3LObDyPA4L24gHQdMGyhrMdXKXZJAOhtAfVUXMjvLqCyqjfUXyLvRt7L3OtT0a3U0efbJpaK5J969d4fz9sK8qKFDKQ1YlAuU6zgUo6AAlACxK6NNwH+eKVny8Zm5qAmBU0bwo8m3R+Bqmz9TEqup94Ju8PV6Nd65Ye0ivOHa5IpHI6y8yjEDeKuebGQl7cZb5AVzFPCCE4adg3JqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vu8KwpiSVKlYcXXfTU224pzj/w/3WGsei6eE22btJ9Y=;
 b=UX9ZdjFnrPogjC68lIniaQEn8ubHuqDRGawfZZLYfT3ua/81aPkkdQvBl2FRR/82lyajCIXdQlzYIm+vpY5FeD7f8mL7tcEk6FEIBfHb/lvuoNuKIP9VBPc+4rqF44Ue1u6H4Bcrv1eDsYr+1wSiHS0OM2oAPeefw4FazDYYUDgxU1s4xuLu6llNUjix0WVuarR4bn1TYz3uCa1f2TVjm+o3xoPBSIRuOPA9NrMJLYB4lA/Rcd+tJANYr8zpSM/OobXDDfi7NThol4aY4QkrexhSTsa6UO1NejiVf4bg8I9mdX0MvHICzvjreoWYnL4XIRVXeM/mrvzRWyczCCG7ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vu8KwpiSVKlYcXXfTU224pzj/w/3WGsei6eE22btJ9Y=;
 b=G5AK52BI2g5LJuADvbRCkaoGgm2BX/bxKgLTk5HYO+wSK3o6fBxKXzbhpJGLxpmKxdo4/1rnPPbLGfQtW20EKqcp6U7PnwsDvdvOAG2CaLeblsrIVFkCP9xVLKynrbJeO4RY//gRTJ2ZEZQBNShA+ckzgehz6LoyD390x+aZjAU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2504.namprd15.prod.outlook.com (2603:10b6:a02:8e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Fri, 19 Jun
 2020 01:14:53 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 01:14:53 +0000
Date: Thu, 18 Jun 2020 18:14:49 -0700
To: Yang Shi <shy828301@gmail.com>
Subject: Re: kernel BUG at mm/huge_memory.c:2613!
Message-ID: <20200619011449.GC135965@carbon.dhcp.thefacebook.com>
References: <20200619001938.GA135965@carbon.dhcp.thefacebook.com>
 <CAHbLzkrDcn-GQOrAM=m7+2g5_J6obsz4K50Oqb-1RD5p1iWTPQ@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CAHbLzkrDcn-GQOrAM=m7+2g5_J6obsz4K50Oqb-1RD5p1iWTPQ@mail.gmail.com>
X-ClientProxiedBy: BYAPR07CA0034.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::47) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:32ff) by
 BYAPR07CA0034.namprd07.prod.outlook.com (2603:10b6:a02:bc::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 01:14:52 +0000
X-Originating-IP: [2620:10d:c090:400::5:32ff]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dd8ccf5-0441-4ce6-7764-08d813ee2bc7
X-MS-TrafficTypeDiagnostic: BYAPR15MB2504:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2504646D3A4D6B6B9FA3B6E7BE980@BYAPR15MB2504.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6WdcNSZEXL8H7jF+8db402szO3dHg4s2+9bVgWSrGGIM6MSDJWewgDvYL9JFbDHkdUCVPD0L0PmFpVzSfr7jqg0O1U5Y8QgSSN7cmkK9kgeR617AkXjIs5U5BlNP2E6x5aRT8oZBjSaBGWjWrj5JGjmu1rWv6ZxUPIByhMpyNye4QPj3gU6pzdECzZHEkqYOMqQhRxOi27ZTdOt4FdGdVST1QGPDWiseQ7dtFldycEjUvTK/5VaLVp1BaUiSOXyFZUsOYI84+XdIPqY1/VLnPw3ddpinP7bbFWDjvRUGa2AewCjxpp0oDVoWC4PpYNIZMdHC7MbkxMRJm6hVESzEc0yYM7QtNVFeVFLieQ9Kljq8Jkhg9TUEpmTbQj7Vtz6C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR15MB4136.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(376002)(346002)(136003)(39860400002)(396003)(6506007)(16526019)(478600001)(186003)(53546011)(8936002)(8676002)(4326008)(86362001)(55016002)(9686003)(33656002)(6916009)(54906003)(316002)(7696005)(52116002)(2906002)(66556008)(1076003)(5660300002)(83380400001)(66946007)(66476007)(7416002)(6666004)(14583001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 4UUbPXOvR+iowIFkHE0T5/ybcnQrAyN2syb8N4oKC2P+GuuhmvxzqBZkVHz5gCS4TBHO41D2EY6LW+XxAvP6gI5u1kX15VIqBSvbZE7wmr1Z3ssd2wPFnuKU9iXNTIACZsP83/0UB9C7bNRydlDJWk7EpV7z9r19JLfbLNkZrON0q1zqw/6Fb1aViCbUq/m3hJM7jp+AYmoNEX5cIA/6i/E0qEH0TaS8pj6N216cFrmnXtvW/CsRHsRU93H0Tv/EAp+1idoxoGH27R8MQ9YvEuRNBbLxWvyT80YOtyRYZT0g8cPYv+9VI+npJzUepN5p2EVXpB1WTMf2aUmDZgdiovXXMJXvzZw8erAx1Dj65AlGNwozdKVCUkSOSBBqvKlBvgtoQ5G/kkv8RkFjvmeuEoTHcz372bH+u6TF5o2xJQY9lXsxs4JHoNgJRGsxODM8Q8+JCHkDuaNZr1BIdzobjEO3LroBi97n3QhBSH/Le0a9SZlk4McQ4P68gbexjd5jwLBodCHNjtFwL6qJtGOEbQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd8ccf5-0441-4ce6-7764-08d813ee2bc7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 01:14:53.4090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3gm03mm9UK/ePJGkohdztuJajMCAesvV4ngPFKXEKyqUPO6D+HVvFTvfVXwbySmD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2504
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-18_21:2020-06-18,
 2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 suspectscore=1
 clxscore=1011 mlxscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 malwarescore=0
 cotscore=-2147483648 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006190005
X-FB-Internal: deliver
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Michal Hocko <mhocko@kernel.org>, Linux MM <linux-mm@kvack.org>,
 iommu@lists.linux-foundation.org, Wei Yang <richardw.yang@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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

On Thu, Jun 18, 2020 at 05:46:24PM -0700, Yang Shi wrote:
> On Thu, Jun 18, 2020 at 5:19 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > Hi!
> >
> > I was consistently hitting a VM_BUG_ON_PAGE() in split_huge_page_to_list()
> > when running vanilla 5.8-rc1 on my desktop. It was happening on every boot
> > during the system start. I haven't seen this issue on 5.7.
> >
> > It looks like split_huge_page() expects the page to be locked,
> > but it hasn't been changed from 5.7. I do not see any suspicious
> > commits around the call side either.
> >
> > I've tried the following patch:
> >
> > --
> > From 4af38fbf06a9354fadf22a78f1a42dfbb24fbc3a Mon Sep 17 00:00:00 2001
> > From: Roman Gushchin <guro@fb.com>
> > Date: Thu, 18 Jun 2020 16:33:47 -0700
> > Subject: [PATCH] iommu/dma: lock page before calling split_huge_page()
> >
> > split_huge_page() expects a locked page. The following stacktrace
> > is generated if debug is on. Fix this by locking the page before
> > passing it to split_huge_page().
> >
> > [   24.861385] page:ffffef044fb1fa00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 head:ffffef044fb1fa00 order:2 compound_mapcount:0 compound_pincount:0
> > [   24.861389] flags: 0x17ffffc0010000(head)
> > [   24.861393] raw: 0017ffffc0010000 dead000000000100 dead000000000122 0000000000000000
> > [   24.861395] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> > [   24.861396] page dumped because: VM_BUG_ON_PAGE(!PageLocked(head))
> > [   24.861411] ------------[ cut here ]------------
> > [   24.861413] kernel BUG at mm/huge_memory.c:2613!
> > [   24.861428] invalid opcode: 0000 [#1] SMP NOPTI
> > [   24.861432] CPU: 10 PID: 1505 Comm: pulseaudio Not tainted 5.8.0-rc1+ #689
> > [   24.861433] Hardware name: Gigabyte Technology Co., Ltd. AB350-Gaming/AB350-Gaming-CF, BIOS F25 01/16/2019
> > [   24.861441] RIP: 0010:split_huge_page_to_list+0x731/0xae0
> > [   24.861444] Code: 44 00 00 8b 47 34 85 c0 0f 84 b4 02 00 00 f0 ff 4f 34 75 c2 e8 e0 12 f7 ff eb bb 48 c7 c6 d0 16 39 ba 4c 89 c7 e8 ef 85 f9 ff <0f> 0b 48 c7 44 24 10 ff ff ff ff 31 db e9 bb fa ff ff 48 8b 7c 24
> > [   24.861446] RSP: 0018:ffffc1030254bb50 EFLAGS: 00010286
> > [   24.861449] RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff9b54cee98d08
> > [   24.861451] RDX: 00000000ffffffd8 RSI: 0000000000000000 RDI: ffff9b54cee98d00
> > [   24.861452] RBP: ffffef044fb1fa00 R08: 0000000000000547 R09: 0000000000000003
> > [   24.861454] R10: 0000000000000000 R11: 0000000000000001 R12: ffff9b54df37f188
> > [   24.861455] R13: ffff9b54df355000 R14: ffffef044fb1fa00 R15: ffffef044fb1fa00
> > [   24.861458] FS:  00007fd2dc132880(0000) GS:ffff9b54cee80000(0000) knlGS:0000000000000000
> > [   24.861460] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   24.861461] CR2: 00007fd2cb100000 CR3: 00000003feb16000 CR4: 00000000003406e0
> > [   24.861464] Call Trace:
> > [   24.861473]  ? __mod_lruvec_state+0x41/0xf0
> > [   24.861478]  ? __alloc_pages_nodemask+0x15c/0x320
> > [   24.861483]  iommu_dma_alloc+0x316/0x580
> > [   24.861496]  snd_dma_alloc_pages+0xdf/0x160 [snd_pcm]
> > [   24.861508]  snd_dma_alloc_pages_fallback+0x5d/0x80 [snd_pcm]
> > [   24.861516]  snd_malloc_sgbuf_pages+0x166/0x380 [snd_pcm]
> > [   24.861523]  ? snd_pcm_hw_refine+0x29d/0x310 [snd_pcm]
> > [   24.861529]  ? _cond_resched+0x16/0x40
> > [   24.861535]  snd_dma_alloc_pages+0x64/0x160 [snd_pcm]
> > [   24.861542]  snd_pcm_lib_malloc_pages+0x136/0x1d0 [snd_pcm]
> > [   24.861550]  ? snd_pcm_lib_ioctl+0x167/0x210 [snd_pcm]
> > [   24.861556]  snd_pcm_hw_params+0x3c0/0x490 [snd_pcm]
> > [   24.861563]  snd_pcm_common_ioctl+0x1c5/0x1110 [snd_pcm]
> > [   24.861571]  ? snd_pcm_info_user+0x64/0x80 [snd_pcm]
> > [   24.861578]  snd_pcm_ioctl+0x23/0x30 [snd_pcm]
> > [   24.861583]  ksys_ioctl+0x82/0xc0
> > [   24.861587]  __x64_sys_ioctl+0x16/0x20
> > [   24.861593]  do_syscall_64+0x4d/0x90
> > [   24.861597]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > ---
> >  drivers/iommu/dma-iommu.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 4959f5df21bd..31e4e305d8d5 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/scatterlist.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/crash_dump.h>
> > +#include <linux/pagemap.h>
> >
> >  struct iommu_dma_msi_page {
> >         struct list_head        list;
> > @@ -549,8 +550,15 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
> >                         if (!PageCompound(page)) {
> >                                 split_page(page, order);
> >                                 break;
> > -                       } else if (!split_huge_page(page)) {
> > -                               break;
> > +                       } else {
> > +                               int err;
> > +
> > +                               lock_page(page);
> > +                               err = split_huge_page(page);
> > +                               unlock_page(page);
> 
> Yes, THP split does need the page locked, in addition it needs the
> caller hold a pin on the page too (refcount bump).
> 
> But, I don't get how the code could even really work by a quick look.
> Actually split_huge_page() assumes the passed in THP is user THP (anon
> or file cache) and the order is PMD order However, it looks the iommu
> driver just wants to allocate a bunch of base pages by allocating a
> huge page (could by any order if I read the code correctly) then split
> them to base pages. I don't think this is the correct approach IMO.
> Anyway I'm not iommu expert, if I miss anything please feel free to
> let me know.

I agree. The whole

	page = alloc_pages_node(nid, alloc_flags, order);
	if (!page)
		continue;
	if (!order)
		break;
	if (!PageCompound(page)) {
		split_page(page, order);
		break;
	} else if (!split_huge_page(page)) {
		break;
	}

looks very suspicious to me.
My wild guess is that gfp flags changed somewhere above, so we hit
the branch which was never hit before.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
