Return-Path: <SRS0=CQHw=AA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAA0C433DF
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 00:20:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97DFE207FC
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 00:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kIPiOngX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Bi2Xg5lK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97DFE207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4D8C688324;
	Fri, 19 Jun 2020 00:19:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OqoIUef5dK7S; Fri, 19 Jun 2020 00:19:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6508B882F6;
	Fri, 19 Jun 2020 00:19:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57307C07FF;
	Fri, 19 Jun 2020 00:19:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3696FC016E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 00:19:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1C393882F6
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 00:19:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vW++6CbT2qOW for <iommu@lists.linux-foundation.org>;
 Fri, 19 Jun 2020 00:19:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DFB89882FB
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 00:19:53 +0000 (UTC)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
 by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05J0EsIc009974;
 Thu, 18 Jun 2020 17:19:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=facebook;
 bh=ocOXybR9FkNJDszhowLSlOxfW/RX7Yij46sF7ebuwU0=;
 b=kIPiOngX3j6f/3W8lfu8bMosmnn6o3oVSrXfmRqaM6JbfmSyOb9ean1vrwWZzlcZwcPy
 5B6DJCrXEBMONHktg8KF3PJpjKVd6RLxu65/0YaOOmO+8BG7w4a3vNoGR8Aj4z3TOgQV
 hEy7u+dEkSU2sWcl09d/Rn5nR0Cxvw81GbQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
 by m0089730.ppops.net with ESMTP id 31rcbe1ysf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 18 Jun 2020 17:19:45 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 17:19:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoMrWz++8RdgtT8cOzthGcBBLNUL09HShWKQw6uUfqMDD/rPRVA7J/g06VqHUhKdrJ58fnLxQwYJuJIdkB2eqn98MAcNgZLmuAMs2VqZ3YbytPotKXsGrwWOqspOtey+sYC5MUdN4ITjSQuHxdJCvCjvEbAlKsArVwYCrSF4/VCqTvRTNirLxS7cZmJZ21WcjDznrSWNoAZWj2ta7euH4Kz1/xOWwWEFwYn60Hd3it4VWREXdPYoijmbwTVac/YpJAIyjMwv19QtlpdwAzhmMIQxSdOMTpS2vgdzsNhQuO+iJOWd1wj4+CDLwAeOWxebh2wFeu1pgjr5lCimjXiHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocOXybR9FkNJDszhowLSlOxfW/RX7Yij46sF7ebuwU0=;
 b=lQvLuOYsBi4x6Zoc+MLWqjN/ExHm5EHEzJw8kFQjGHdRtBSfmy1hnxHjianAJWBI/+ABFHMm63yQQ+cQYznC3XcgjWS348ma4qBnuCykDpNyfhqtbD7biCZSHUo7ddRVR9LTa9m1Vif8vnI7ywRetVeWE2FufCA+ZEqIhVrewNivi3+VTFpMJemHsTP9HRsFEVjvzp/mNWVj2fx0OHES04OXS0YYXB98/CkhKbekJPkgYNx5pTeKBUAR22SyDwIkER5ybxH/C28QCyEg+yDIppfbv3sTkyBLmyGTw54bqB99+WJhgPzcXfaHrMu+EsnP0azcOHdjL3HJWFXFuaWQ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocOXybR9FkNJDszhowLSlOxfW/RX7Yij46sF7ebuwU0=;
 b=Bi2Xg5lKXJGlD4hVHoAwYmkYvOhJ30/hElggpsfks+6OZFMZJlu//YyuyhLsNhevwEoYLtHZEw/SN+KKT8fW1JdXogyyhJrGfiU73TenbdwDEPmHvSSBowafvbcB2S99aHHw1bNL1Z1xjMJjNmz2OvMrzZWH8cWf4fj+Ztzx2nA=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2280.namprd15.prod.outlook.com (2603:10b6:a02:8a::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Fri, 19 Jun
 2020 00:19:41 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 00:19:41 +0000
Date: Thu, 18 Jun 2020 17:19:38 -0700
To: <iommu@lists.linux-foundation.org>
Subject: kernel BUG at mm/huge_memory.c:2613!
Message-ID: <20200619001938.GA135965@carbon.dhcp.thefacebook.com>
Content-Disposition: inline
X-ClientProxiedBy: BY3PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:a03:255::13) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:32ff) by
 BY3PR10CA0008.namprd10.prod.outlook.com (2603:10b6:a03:255::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend
 Transport; Fri, 19 Jun 2020 00:19:41 +0000
X-Originating-IP: [2620:10d:c090:400::5:32ff]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bda9d7f3-d6ce-40c6-3b5d-08d813e675fb
X-MS-TrafficTypeDiagnostic: BYAPR15MB2280:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2280F1472E2CCCBF31B6E532BE980@BYAPR15MB2280.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FR0Oz8dR++z1VpQv/c1RF7D6xincxbI9orTG8QsbhTWFg290S5VvSdYTlUdyIy9tsU7Ya2NeyL1VdOHbYlWizDZOJu4dZ787U+tDGRylRJTrghONnFV7UVzg9NZCkPUXOxSYOE2NZbhAFoWPcgrJg3ULj1jQ/xrXigr+umsDQCs95Xz33r4c9C63X2t72/k/7dPDQOtvjjt7XuP+OjfoaIdFNiqNdhWs0aRD7S8+3RXvwPExkgM5DWQUjB7IKmSAFNnI64Gl/deDpSlTJwSDxodfSGvQlJKWBKjOuedmUfC/aDgsQRO70JAvgV8q05wLWvWZIjaus9JLXaLO6FQiDmC3jIFUB4X2NForrLI8RrqRsS60m00VNvQfnnf8vma2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR15MB4136.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39860400002)(366004)(346002)(396003)(376002)(136003)(478600001)(9686003)(52116002)(7696005)(5660300002)(6666004)(66946007)(6506007)(66556008)(86362001)(316002)(66476007)(7416002)(53546011)(83380400001)(186003)(16526019)(4326008)(8676002)(2906002)(33656002)(8936002)(54906003)(6916009)(1076003)(55016002)(14583001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: d1Sg13x1KC5hSXmBggqSFQc1JiYQrV7IXsW/L3dGV6gm7Nu6jVn75hjjLrxhy5xzQRvD0T6xCxnDICCZ8+a8vGcFCAhFw1DT07Nv77yb22gZahKe20HIcRrE3+HsoqU2uI2cEP9SBpS+vGozoSKfCehUvpjfIhtcVWMfww1EIYgdGq1bkfxO8s8Qr0GifQTyizhkiKzBr0O24yxxbUf28Jy6Zq7PujYJPkyNhd/6DQ+E/dOX5inFmDgeTjKzdaBTA/xO3i4g7fcHE9w2AK30Xs4kq2lRzkxEAq7cVbzll+Wf9pK7gHVhmo1ItRsq8WmEImpCbzC0ErdmpuNmJg+//NVQaAfyf/CvEb0FgAjtYtxk2V+sTUTcOq6d+rgSKxx0fEeEjIqSyyiSjpmFF0PZ249w11t2L2vqpSH/NMDewqAiTJuQFLDqDFyV535itBKsOqvbkGW9CNbmaoQpmqAfwrCGx3Yg/8V/158cmcpfETbkNS6JcBvpu40V775p6kRNgIgAl9rSpZWmUGUeSF3lXg==
X-MS-Exchange-CrossTenant-Network-Message-Id: bda9d7f3-d6ce-40c6-3b5d-08d813e675fb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 00:19:41.7142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: usrpGc5liLUSLf7Iu/StjylAtsPjadE5LYX2GBZX2NbLHZnBCGcC3733sOzbXv3V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2280
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-18_21:2020-06-18,
 2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 phishscore=0
 cotscore=-2147483648 malwarescore=0 adultscore=0 impostorscore=0
 bulkscore=0 suspectscore=10 mlxscore=0 mlxlogscore=999 spamscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190000
X-FB-Internal: deliver
Cc: Andrea Arcangeli <aarcange@redhat.com>, linux-kernel@vger.kernel.org,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
 Wei Yang <richardw.yang@linux.intel.com>, Johannes Weiner <hannes@cmpxchg.org>,
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

Hi!

I was consistently hitting a VM_BUG_ON_PAGE() in split_huge_page_to_list()
when running vanilla 5.8-rc1 on my desktop. It was happening on every boot
during the system start. I haven't seen this issue on 5.7.

It looks like split_huge_page() expects the page to be locked,
but it hasn't been changed from 5.7. I do not see any suspicious
commits around the call side either.

I've tried the following patch:

--
From 4af38fbf06a9354fadf22a78f1a42dfbb24fbc3a Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Thu, 18 Jun 2020 16:33:47 -0700
Subject: [PATCH] iommu/dma: lock page before calling split_huge_page()

split_huge_page() expects a locked page. The following stacktrace
is generated if debug is on. Fix this by locking the page before
passing it to split_huge_page().

[   24.861385] page:ffffef044fb1fa00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 head:ffffef044fb1fa00 order:2 compound_mapcount:0 compound_pincount:0
[   24.861389] flags: 0x17ffffc0010000(head)
[   24.861393] raw: 0017ffffc0010000 dead000000000100 dead000000000122 0000000000000000
[   24.861395] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
[   24.861396] page dumped because: VM_BUG_ON_PAGE(!PageLocked(head))
[   24.861411] ------------[ cut here ]------------
[   24.861413] kernel BUG at mm/huge_memory.c:2613!
[   24.861428] invalid opcode: 0000 [#1] SMP NOPTI
[   24.861432] CPU: 10 PID: 1505 Comm: pulseaudio Not tainted 5.8.0-rc1+ #689
[   24.861433] Hardware name: Gigabyte Technology Co., Ltd. AB350-Gaming/AB350-Gaming-CF, BIOS F25 01/16/2019
[   24.861441] RIP: 0010:split_huge_page_to_list+0x731/0xae0
[   24.861444] Code: 44 00 00 8b 47 34 85 c0 0f 84 b4 02 00 00 f0 ff 4f 34 75 c2 e8 e0 12 f7 ff eb bb 48 c7 c6 d0 16 39 ba 4c 89 c7 e8 ef 85 f9 ff <0f> 0b 48 c7 44 24 10 ff ff ff ff 31 db e9 bb fa ff ff 48 8b 7c 24
[   24.861446] RSP: 0018:ffffc1030254bb50 EFLAGS: 00010286
[   24.861449] RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff9b54cee98d08
[   24.861451] RDX: 00000000ffffffd8 RSI: 0000000000000000 RDI: ffff9b54cee98d00
[   24.861452] RBP: ffffef044fb1fa00 R08: 0000000000000547 R09: 0000000000000003
[   24.861454] R10: 0000000000000000 R11: 0000000000000001 R12: ffff9b54df37f188
[   24.861455] R13: ffff9b54df355000 R14: ffffef044fb1fa00 R15: ffffef044fb1fa00
[   24.861458] FS:  00007fd2dc132880(0000) GS:ffff9b54cee80000(0000) knlGS:0000000000000000
[   24.861460] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.861461] CR2: 00007fd2cb100000 CR3: 00000003feb16000 CR4: 00000000003406e0
[   24.861464] Call Trace:
[   24.861473]  ? __mod_lruvec_state+0x41/0xf0
[   24.861478]  ? __alloc_pages_nodemask+0x15c/0x320
[   24.861483]  iommu_dma_alloc+0x316/0x580
[   24.861496]  snd_dma_alloc_pages+0xdf/0x160 [snd_pcm]
[   24.861508]  snd_dma_alloc_pages_fallback+0x5d/0x80 [snd_pcm]
[   24.861516]  snd_malloc_sgbuf_pages+0x166/0x380 [snd_pcm]
[   24.861523]  ? snd_pcm_hw_refine+0x29d/0x310 [snd_pcm]
[   24.861529]  ? _cond_resched+0x16/0x40
[   24.861535]  snd_dma_alloc_pages+0x64/0x160 [snd_pcm]
[   24.861542]  snd_pcm_lib_malloc_pages+0x136/0x1d0 [snd_pcm]
[   24.861550]  ? snd_pcm_lib_ioctl+0x167/0x210 [snd_pcm]
[   24.861556]  snd_pcm_hw_params+0x3c0/0x490 [snd_pcm]
[   24.861563]  snd_pcm_common_ioctl+0x1c5/0x1110 [snd_pcm]
[   24.861571]  ? snd_pcm_info_user+0x64/0x80 [snd_pcm]
[   24.861578]  snd_pcm_ioctl+0x23/0x30 [snd_pcm]
[   24.861583]  ksys_ioctl+0x82/0xc0
[   24.861587]  __x64_sys_ioctl+0x16/0x20
[   24.861593]  do_syscall_64+0x4d/0x90
[   24.861597]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 drivers/iommu/dma-iommu.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 4959f5df21bd..31e4e305d8d5 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -24,6 +24,7 @@
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
 #include <linux/crash_dump.h>
+#include <linux/pagemap.h>
 
 struct iommu_dma_msi_page {
 	struct list_head	list;
@@ -549,8 +550,15 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 			if (!PageCompound(page)) {
 				split_page(page, order);
 				break;
-			} else if (!split_huge_page(page)) {
-				break;
+			} else {
+				int err;
+
+				lock_page(page);
+				err = split_huge_page(page);
+				unlock_page(page);
+
+				if (!err)
+					break;
 			}
 			__free_pages(page, order);
 		}
-- 
2.26.2


--

But applying it made the kernel panic somewhere else:

[   25.148419] BUG: unable to handle page fault for address: ffffb1a9c2429000
[   25.148424] #PF: supervisor write access in kernel mode
[   25.148426] #PF: error_code(0x000b) - reserved bit violation
[   25.148427] PGD 40d14e067 P4D 40d14e067 PUD 40d14f067 PMD 3e9938067 PTE 8000112400b4b163
[   25.148433] Oops: 000b [#1] SMP NOPTI
[   25.148436] CPU: 10 PID: 1504 Comm: pulseaudio Not tainted 5.8.0-rc1+ #690
[   25.148438] Hardware name: Gigabyte Technology Co., Ltd. AB350-Gaming/AB350-Gaming-CF, BIOS F25 01/16/2019
[   25.148445] RIP: 0010:__memset+0x24/0x30
[   25.148448] Code: cc cc cc cc cc cc 0f 1f 44 00 00 49 89 f9 48 89 d1 83 e2 07 48 c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6 <f3> 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 f3
[   25.148450] RSP: 0018:ffffb1a9c2497e08 EFLAGS: 00010216
[   25.148453] RAX: 0000000000000000 RBX: ffffa089ab428000 RCX: 00000000000008a0
[   25.148454] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffb1a9c2429000
[   25.148456] RBP: ffffa089b0036c00 R08: ffffa089c84c56e8 R09: ffffb1a9c2429000
[   25.148457] R10: ffffb1a9c2429000 R11: ffffa089ae3c1800 R12: 0000000000000000
[   25.148458] R13: ffffa089aa828600 R14: ffffffffc0f82880 R15: ffffa089c5121200
[   25.148461] FS:  00007f533f679880(0000) GS:ffffa089cee80000(0000) knlGS:0000000000000000
[   25.148463] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   25.148464] CR2: ffffb1a9c2429000 CR3: 0000000405f42000 CR4: 00000000003406e0
[   25.148466] Call Trace:
[   25.148479]  snd_pcm_hw_params+0x3fd/0x490 [snd_pcm]
[   25.148488]  snd_pcm_common_ioctl+0x1c5/0x1110 [snd_pcm]
[   25.148496]  ? snd_pcm_info_user+0x64/0x80 [snd_pcm]
[   25.148504]  snd_pcm_ioctl+0x23/0x30 [snd_pcm]


Any ideas? Is it a known issue?
It might be that some changes revealed one or more old bugs.

Does the proposed patch look sane?

Thanks!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
