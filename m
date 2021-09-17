Return-Path: <SRS0=dQER=OH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3E2C433EF
	for <iommu@archiver.kernel.org>; Fri, 17 Sep 2021 10:51:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C90061100
	for <iommu@archiver.kernel.org>; Fri, 17 Sep 2021 10:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C90061100
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EC83B401E3;
	Fri, 17 Sep 2021 10:51:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G2dajFMHFbec; Fri, 17 Sep 2021 10:51:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8BB444010E;
	Fri, 17 Sep 2021 10:51:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6CE91C0011;
	Fri, 17 Sep 2021 10:51:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98D8BC000D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 10:51:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 76C2381902
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 10:51:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6I7yn-8sR5Zv for <iommu@lists.linux-foundation.org>;
 Fri, 17 Sep 2021 10:51:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.111.102])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4CCA5817FD
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 10:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1631875860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kndVqjY9sCpaHVWNklWOKb8oFcdnKBVKLygRhlHka6U=;
 b=c/DjpkHXy5/HpILO1k3GSLXgRW7+1FBqkdmVgAGj4/CHuT7qtUSxfI+UuH2BZzqRyIXWZR
 eDlrrk1zWI9fUdatvKKDnRrHfzonyCrHCPPzyynJ/HXvtenlGf0f2Wd5+5JZGVVe8A8kgc
 yQNVsRW16TncX+Aoy2b8TvaY5I36gqw=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2056.outbound.protection.outlook.com [104.47.14.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-1-PkQaqTS1OHiajKqKIZMyHQ-1;
 Fri, 17 Sep 2021 12:49:08 +0200
X-MC-Unique: PkQaqTS1OHiajKqKIZMyHQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmFMBGQFtMAd5FDk1XbObktPuQyY9PE29Vh1aztnY4BW2K8F3rL3Qt7cpX3iN8hKygHqsKIzGnRBP+QrxMLyEivpMih4CTbVQaj3oTzcSQ/+/9RArJPzdHz+35PspHpCEJOEn8v106F4WVG3l3b/64uW4Tn/gbReK++FEINH6P0aMCxqhx206x2BCBN+qONLjN9eCVFJ0A0qO/Wu5cl9MsvoUF5c73ao2IPIsFiC+vz4v6o80E0t2Vcd94k5VYJ0IUMAAGS/n9uFzaWLCBsP4c6cDSicJmi0xLNmXKujz58wz8ygb2r3f3RCzwaOnadNHUjXWsHgR5al5/zn6VDSdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=kndVqjY9sCpaHVWNklWOKb8oFcdnKBVKLygRhlHka6U=;
 b=QoLU57JC/x81rEFxjlfeX6kCbuxpTWzm8rUaFZ/IWYGStvQlfH2VnwEh0Q+oXre8WysIiQN9pIpiUSiPcT0lE1xyY5+EqRF7Ux1eU9hV1yVQ86NAIYGlDw2OfpqIg4hdZ4xv6JFx8qrm9oswts//eKLJ1cMUoltg+/gxiNiDbQJbEAHFnbi/oqXfxi9GzEghmLU8umfsu2GqBLZ1xSetSdyBU4EC9v7FpR95tOfwzR5CRhqRCVPcA1fFbAYZs6Pe8eZZED4UhoD4As7FrF+i9vvKQanCOfOSB3EmJJI/v1GEc4rbwx5JnU/EKbvJx8FzikvOVgDFKwzfDaN9F/mblA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=suse.com;
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com (2603:10a6:803:e7::16)
 by VE1PR04MB6672.eurprd04.prod.outlook.com (2603:10a6:803:127::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 10:49:07 +0000
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::4d37:ec64:4e90:b16b]) by VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::4d37:ec64:4e90:b16b%7]) with mapi id 15.20.4523.016; Fri, 17 Sep 2021
 10:49:07 +0000
Subject: [PATCH v2 3/4] xen/pci-swiotlb: reduce visibility of symbols
To: Juergen Gross <jgross@suse.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <164e58ff-2edd-2c99-ac3d-e18eb06ff731@suse.com>
Message-ID: <aef5fc33-9c02-4df0-906a-5c813142e13c@suse.com>
Date: Fri, 17 Sep 2021 12:49:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <164e58ff-2edd-2c99-ac3d-e18eb06ff731@suse.com>
Content-Language: en-US
X-ClientProxiedBy: PR2PR09CA0022.eurprd09.prod.outlook.com
 (2603:10a6:101:16::34) To VI1PR04MB5600.eurprd04.prod.outlook.com
 (2603:10a6:803:e7::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.156.60.236] (37.24.206.209) by
 PR2PR09CA0022.eurprd09.prod.outlook.com (2603:10a6:101:16::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 10:49:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a54bc54f-3d61-4688-7218-08d979c8c5fa
X-MS-TrafficTypeDiagnostic: VE1PR04MB6672:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB667250B1123561ABEC648420B3DD9@VE1PR04MB6672.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FWbW2r4tXDfuI1LT+hNd8i8PNpnTorkZ1xGGNh/073M1Ypigs4NJuPrFiyj9axEXr+RccClClbveXpPVAEBSSC9wuKFZvZQUn0gE3urO947gXoUVKr7CWlt72yRoqhWisqSiSk0wxAI6/N3AKgj+JuX/wMmdTGmNrUrhlT3kiiY75TbPq3kJy8CImjIW7JfAW7z2kQ/q6/Ix7lh6xAODw0WUfMdQF6QCiSLPW51jFBAdi161yv6nQ8gENfIXaeHbKDLcuoGn9SVfQBk/mQkDsCO8zdJ4OxmfCfEgt6IePAbN3o+Orl3etS6bkSi5iP6gDqOqTO6T1heCT5Wz7BAWIuCWxPsOt7ueRS7GdDBtk8LzAs/EzbUHNR/aFbpxHo9d13f0LJPzKMQVvBmGUSZx9PBOK+dMf4Apiee9f0FOQw6L4axcdJdRjEkr4ex7sfLlZbbL8kx2i/Xh117Itk4x34+6FCKgbSAO4U4kBp33HqklGFaC3MEQL//uThTCwVDSge96aq0Go+ld52nOZ4cCRC/WN4QPCDUXx7m/4SkM5ZONL4Pitf5Ib9bqHbsI/cmQG32b8Giq6ezBvk2wwnBF6WIHdtZKv7HG4NZx2luwb3juQLpf1piGin5AL3R8pFZbxtbhXmJwyZ1BlttujrghYjc1imrv2rDv05XNuv6+MtqEofMKjEPatyf6thMhS4n6vyEdfaBRUSe9J8VYBMdUm6Ehk7abZw6Gq5M5b8e+RYg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB5600.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(396003)(136003)(346002)(376002)(366004)(478600001)(2906002)(956004)(26005)(8676002)(38100700002)(86362001)(31686004)(5660300002)(31696002)(186003)(66946007)(54906003)(2616005)(66476007)(16576012)(66556008)(110136005)(316002)(6486002)(83380400001)(8936002)(36756003)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmplNWRWQWVlUEZqNDdpQ0xYR2l6bk1YbElkRmRFSzZTVUZGT05MbVhxK29D?=
 =?utf-8?B?NjZHN3RKUkpuK3p4QURYZnZUTnhGdVkrKzdFZkIwRzRFVE05QXpqOEx6a0Jy?=
 =?utf-8?B?WWg1UDB1NlExckhlOExTK3c3ZjNncklsUFA1Q1c1eHFGOUVpMldCOHkxWnpO?=
 =?utf-8?B?OERYTHpESGg5bWxBZkxBaTIvVFdTclVwV0FVTTQ3K0M4UUozVHpOazNRV0hz?=
 =?utf-8?B?RnpjVXR2OTFDcGlvaWpybUd6enZySnJ5R0RoUTh6SnUwQ2JKR1lRMU1KaXZk?=
 =?utf-8?B?ckxOWUR5NVhROE5qQ1YxWkNWZXo0WThrN1crY29rOXVGVEdsUnBvOHNOQmhi?=
 =?utf-8?B?TDB5bkh4aXkzOVhKR01tWSt1VjN5MjA1Q1BzTEEyMHh3V0VOVElYeCtWeTRv?=
 =?utf-8?B?UlhkMWgwZTYvQmlnZE40VVp3K1Z2QVVzQXpIeGZjTW44RjZNbjhDdjc1bDdC?=
 =?utf-8?B?SmNlc1p4ay9lOFF0MGdSeWFCRi91UlFTTGZaem8xcDkrM2ljYSttQVVRNU5i?=
 =?utf-8?B?azJOdFBrNFc1d2NQSk0vcnNyVXRraU9kdFhNMTQzLzBQMDN6QTJxMjEwVjV0?=
 =?utf-8?B?QktYYitBUksweWNzUTlMbHFpUVFmVVVUME9mVFE4UEZRWjRGL0gyVVJtL3Ny?=
 =?utf-8?B?R3REVElvUERvOHlWNU9pamVQMldtM2w3d093WnVyRWJleWVweXhXSi9KeXJh?=
 =?utf-8?B?Y2kxWTJxMU9talJKSmoyNG12ZkgxT2dRTU41bE5SZ2lIQStxVjJNazFTeUk5?=
 =?utf-8?B?ZEE1RzhrNXROWHk4RVJxNjlEMWVRQjJJYjFFSWpyRkpaSzJUWVd3OXpvYURi?=
 =?utf-8?B?VEhqWng4b05IYS9uRFQvS2M1bGRZTjF1R1hzb2tvajlrZ09Qakw5eGY4MHBl?=
 =?utf-8?B?RERzdkZxd3Z2YlJFSjJBUnJDMXNPVGtRdTNZZEcwdnJuVEFBRnpSZzJnYXVJ?=
 =?utf-8?B?NjgrRkd4SjFaWEJqTlFaQkwvdUNuUy9kdzRNdmtDa0dXbit3TWhxYmdtMUdQ?=
 =?utf-8?B?MkFuMmw1MC9NZ2dHSU11RVpKbmFYWmc2M24vZ3JMZnBlbDVBRjNNNWt0RG96?=
 =?utf-8?B?ZmRnbnNjZWd0dkNKL3Q1UDVpQitOL3RYNURRd2o3bTczYlBXVldkcEhnOWtW?=
 =?utf-8?B?WTFtUVgvaEtkSGJhaG56TnZJZi8rNU9MWWxyVGNtdldFakpZZjJoZnN2cDFL?=
 =?utf-8?B?azhzeDJiRDZnY2pRemFEQUtZUWhnYmR6MTludGhBcWwrb2ExMC9FY2VmSzds?=
 =?utf-8?B?eXBBN1l6L001K1oxaVhHdFdhVHZPTmkvaHdSenZSVEJkWTNYTVVMSHlpRG1W?=
 =?utf-8?B?YkpKZ0I3aFJaZkRqRnQwUnZNMjhwRFdra0REM3lRY0kwUWhKajR1WHlhME1I?=
 =?utf-8?B?eXBwdGpDV05Qc3VHV1ROWnhjbkZwcGtlNVFtc2M1VHhQYksrZVVscnhNaXo4?=
 =?utf-8?B?YURLVitDa0RGV015RkVOMDlYbUtOcVBtemxtbkRJUkJkNVlYWUl5QVNyMlRM?=
 =?utf-8?B?NlpEeUxIS01IWU1BVktneVdvS0gySnY4WVN6bklqRU1GZXZFRFJLSVRtbEd6?=
 =?utf-8?B?dCtuT1RabEpFZ3lVNFA2TUJMUy9HN2t3byttcE9sWjF4MkFqYm5aNDRXWmNx?=
 =?utf-8?B?ZEVEMlVsZG9aREo2cWJWc2h5SnhUQ2s5QlU3VUtjS2hrY1lVZ3NSMThKd1pm?=
 =?utf-8?B?cTR3NkZhaWVraVVLcFJBRDZET2ZFelpnbHZBYXR4alRFNHY3Mi9xekR2OEs5?=
 =?utf-8?Q?Xriafnac+vppW8qKREz4bYAu1OGrQclhfDkfTDW?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a54bc54f-3d61-4688-7218-08d979c8c5fa
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5600.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 10:49:07.2300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcSZ6RLEwzc3lSy0RMwhB+2RbPH6c97eWXvHMHfpiw80A3tdK/At6WCsCRoK6BnEU6oza9I0Ryy8ZoqKtJZqyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6672
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Konrad Wilk <konrad.wilk@oracle.com>, lkml <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "hch@lst.de" <hch@lst.de>
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
From: Jan Beulich via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jan Beulich <jbeulich@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

xen_swiotlb and pci_xen_swiotlb_init() are only used within the file
defining them, so make them static and remove the stubs. Otoh
pci_xen_swiotlb_detect() has a use (as function pointer) from the main
pci-swiotlb.c file - convert its stub to a #define to NULL.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>

--- a/arch/x86/include/asm/xen/swiotlb-xen.h
+++ b/arch/x86/include/asm/xen/swiotlb-xen.h
@@ -3,14 +3,10 @@
 #define _ASM_X86_SWIOTLB_XEN_H
 
 #ifdef CONFIG_SWIOTLB_XEN
-extern int xen_swiotlb;
 extern int __init pci_xen_swiotlb_detect(void);
-extern void __init pci_xen_swiotlb_init(void);
 extern int pci_xen_swiotlb_init_late(void);
 #else
-#define xen_swiotlb (0)
-static inline int __init pci_xen_swiotlb_detect(void) { return 0; }
-static inline void __init pci_xen_swiotlb_init(void) { }
+#define pci_xen_swiotlb_detect NULL
 static inline int pci_xen_swiotlb_init_late(void) { return -ENXIO; }
 #endif
 
--- a/arch/x86/xen/pci-swiotlb-xen.c
+++ b/arch/x86/xen/pci-swiotlb-xen.c
@@ -18,7 +18,7 @@
 #endif
 #include <linux/export.h>
 
-int xen_swiotlb __read_mostly;
+static int xen_swiotlb __read_mostly;
 
 /*
  * pci_xen_swiotlb_detect - set xen_swiotlb to 1 if necessary
@@ -56,7 +56,7 @@ int __init pci_xen_swiotlb_detect(void)
 	return xen_swiotlb;
 }
 
-void __init pci_xen_swiotlb_init(void)
+static void __init pci_xen_swiotlb_init(void)
 {
 	if (xen_swiotlb) {
 		xen_swiotlb_init_early();

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
