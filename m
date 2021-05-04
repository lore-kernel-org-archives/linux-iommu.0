Return-Path: <SRS0=4008=J7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AD4C433B4
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 17:04:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50674613C4
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 17:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50674613C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0EED6607AB;
	Tue,  4 May 2021 17:04:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0UocV0ZqsOBD; Tue,  4 May 2021 17:04:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC2E0607C9;
	Tue,  4 May 2021 17:04:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4229C000E;
	Tue,  4 May 2021 17:04:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D82E8C0001
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 17:04:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B582C829F2
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 17:04:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3EUYrEiTnH9v for <iommu@lists.linux-foundation.org>;
 Tue,  4 May 2021 17:04:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-oln040092072019.outbound.protection.outlook.com [40.92.72.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A89B82A2E
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 17:04:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIOgTwDfjRbogIkj6bpZmjIS3/c4dKbkqZR6Q4WijwTAmtwHMu4MmkdNJNdZK/hGFeDfSWNCDFQk2bsx2FmBRJb3gD6PPzcAcWYiM+XCCvCJERiX49v9IeIrR/kfTYM6/Gg1KyQtLSly56yH5s8cU4l2Oa6R7tIJPP3heLNbidljbpZmWOxNndfBkBPMENOyxs1fD1OmtEE7RSEAzAIwO5Irp990cQ6pfci6fiw916+B2WK0Y6vDOJA90xHohFkDuexU2bLaHAZ7qiyDShuvmHoecf5+AIRKUPiHh7fVT3twY+JVp/YqNbE5hguNYKXtNNcRqF229e3aK5ZDI0lSfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsLvITt/pcmAny7NwL000AZ0z1QTxpN0cZAm0dtVgRI=;
 b=dMps/81vo4m5ScDbDFiAQcUkBb8B6ZwbnWRSsr0/X9+Ejv2EQS5Se2MGyW6MMNaXiqHmUS6faw25EcOppLzNsmIEY7aLyY7KC/HeoPoX+lId4GQA3Vtvr3w7QHPdLdzQI3yPl+PBT4AJKLOHlCF2udGrHajW0AlgwoRiTH3e2pm2dYVkyuQ672TOHswIKcGHUaEoKFZBNyQYUj7u2PAg9gfxAgxXYuhOFsQ88Ttx+DCfiy/dMa1XzPHb/AX6zLwem5B5NFvpK1o4xGl0lfywaNgj1gxMzk4VLf5xmDZkLsSJ7CP/1YE3pGijq/aSoCOIO7kfIujOC9bkJpimutzDsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB5EUR03FT064.eop-EUR03.prod.protection.outlook.com
 (2a01:111:e400:7e0a::4f) by
 DB5EUR03HT030.eop-EUR03.prod.protection.outlook.com (2a01:111:e400:7e0a::343)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27; Tue, 4 May
 2021 17:04:33 +0000
Received: from VI1PR09MB2638.eurprd09.prod.outlook.com
 (2a01:111:e400:7e0a::42) by DB5EUR03FT064.mail.protection.outlook.com
 (2a01:111:e400:7e0a::455) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Tue, 4 May 2021 17:04:33 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:3A8C3698AD094A502E31F136B7BD1E977FB695C67E9994AA1644462ADCC9D264;
 UpperCasedChecksum:975B24C4FC20C17213FBBF2B1FB8EB51CB4736FA270ACC183FF154411902B071;
 SizeAsReceived:8924; Count:48
Received: from VI1PR09MB2638.eurprd09.prod.outlook.com
 ([fe80::948b:987c:566b:198e]) by VI1PR09MB2638.eurprd09.prod.outlook.com
 ([fe80::948b:987c:566b:198e%5]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 17:04:33 +0000
Subject: Re: [PATCH] x86/events/amd/iommu: Fix invalid Perf result due to
 IOMMU PMC power-gating
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20210504065236.4415-1-suravee.suthikulpanit@amd.com>
From: David Coe <david.coe@live.co.uk>
Message-ID: <VI1PR09MB2638D44EE0C3E4626203E4B0C75A9@VI1PR09MB2638.eurprd09.prod.outlook.com>
Date: Tue, 4 May 2021 18:04:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <20210504065236.4415-1-suravee.suthikulpanit@amd.com>
Content-Language: en-GB
X-TMN: [Tc9XiwchOD3EvIBiOaQEVNcvApOar+2G]
X-ClientProxiedBy: LO4P123CA0026.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::13) To VI1PR09MB2638.eurprd09.prod.outlook.com
 (2603:10a6:803:7b::27)
X-Microsoft-Original-Message-ID: <cb8a9734-632b-fb8a-9254-6e4b0c510007@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.6] (90.246.218.100) by
 LO4P123CA0026.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:151::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.32 via Frontend Transport; Tue, 4 May 2021 17:04:32 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 6d7131cb-b941-48f8-25d8-08d90f1eb072
X-MS-TrafficTypeDiagnostic: DB5EUR03HT030:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KdroPsCE/Ualyw1blJFeqESaiRrht2X8LYKW0LhlSrKr/d7Mt2QSe5FoduW1/2VJTfJrgd22QpUULB7TTUVIBu15MYO6oPAXTC+r96TpTx5ngF22ODtik2AJ8u7j3HNdAgUx0c6sYrRaKRPYomZMHcWzSpdGmOoXbUSKLcqhRqwWTyRxiZ+kFxr4vMxpoY3X7JArL0OZN4oz+CCLU9MRVW7NQle3nlmDfLKUcq/XVNU7NLtpi6ZzA/P/ws9l87XrpESiUAWt0BR6b+8miquWV2D+tLLMUhK/KLfBHMHFUhr3f44rhxUHQgEaCfoNXrxXJjI3Ri4aFPgS+X4NrQxcO8eP1quHfpvoHB7uY9naIzLhxJlTsymqOXLY6urP3RgFW1DU6bKnVwyDmEXAKuS8Qg==
X-MS-Exchange-AntiSpam-MessageData: Mv7CKSDbHPafC9U0vBe4nvNvMeMMQwGUSOS4FFsFlQD+PzIC9YwkTNm9CVud7ZHh7jwH4g4qug6MEz4mX7eJCEd/tSWoo1htFRytwl/8SWNR28mRyrQ8rgRYyJW7+1hPf2xteWttoPAZj5NqksAKWA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7131cb-b941-48f8-25d8-08d90f1eb072
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 17:04:33.5620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT064.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5EUR03HT030
Cc: peterz@infradead.org, mingo@redhat.com, amonakov@ispras.ru,
 Jon.Grimm@amd.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi again!

On 04/05/2021 07:52, Suravee Suthikulpanit wrote:
> On certain AMD platforms, when the IOMMU performance counter source
> (csource) field is zero, power-gating for the counter is enabled, which
> prevents write access and returns zero for read access.
> 
> This can cause invalid perf result especially when event multiplexing
> is needed (i.e. more number of events than available counters) since
> the current logic keeps track of the previously read counter value,
> and subsequently re-program the counter to continue counting the event.
> With power-gating enabled, we cannot gurantee successful re-programming
> of the counter.
> 
> Workaround this issue by :
> 
> 1. Modifying the ordering of setting/reading counters and enabing/
>     disabling csources to only access the counter when the csource
>     is set to non-zero.
> 
> 2. Since AMD IOMMU PMU does not support interrupt mode, the logic
>     can be simplified to always start counting with value zero,
>     and accumulate the counter value when stopping without the need
>     to keep track and reprogram the counter with the previously read
>     counter value.
> 

Results for Ryzen 4700U running Ubuntu 21.04 kernel 5.11.0-16 patched as 
above.

All amd_iommu events:

  Performance counter stats for 'system wide':

                 18       amd_iommu_0/cmd_processed/            (33.29%)
                  9       amd_iommu_0/cmd_processed_inv/        (33.33%)
                  0       amd_iommu_0/ign_rd_wr_mmio_1ff8h/     (33.36%)
                308       amd_iommu_0/int_dte_hit/              (33.40%)
                  5       amd_iommu_0/int_dte_mis/              (33.45%)
                346       amd_iommu_0/mem_dte_hit/              (33.46%)
              8,954       amd_iommu_0/mem_dte_mis/              (33.48%)
                  0       amd_iommu_0/mem_iommu_tlb_pde_hit/    (33.46%)
                771       amd_iommu_0/mem_iommu_tlb_pde_mis/    (33.44%)
                 14       amd_iommu_0/mem_iommu_tlb_pte_hit/    (33.40%)
                836       amd_iommu_0/mem_iommu_tlb_pte_mis/    (33.36%)
                  0       amd_iommu_0/mem_pass_excl/            (33.32%)
                  0       amd_iommu_0/mem_pass_pretrans/        (33.28%)
              1,601       amd_iommu_0/mem_pass_untrans/         (33.27%)
                  0       amd_iommu_0/mem_target_abort/         (33.27%)
              1,130       amd_iommu_0/mem_trans_total/          (33.27%)
                  0       amd_iommu_0/page_tbl_read_gst/        (33.27%)
                312       amd_iommu_0/page_tbl_read_nst/        (33.28%)
                279       amd_iommu_0/page_tbl_read_tot/        (33.27%)
                  0       amd_iommu_0/smi_blk/                  (33.29%)
                  0       amd_iommu_0/smi_recv/                 (33.27%)
                  0       amd_iommu_0/tlb_inv/                  (33.26%)
                  0       amd_iommu_0/vapic_int_guest/          (33.25%)
                366       amd_iommu_0/vapic_int_non_guest/      (33.27%)

       10.001941666 seconds time elapsed


Groups of 8 amd_iommu events:

  Performance counter stats for 'system wide':

                 14       amd_iommu_0/cmd_processed/ 

                  7       amd_iommu_0/cmd_processed_inv/ 

                  0       amd_iommu_0/ign_rd_wr_mmio_1ff8h/ 

                502       amd_iommu_0/int_dte_hit/ 

                  6       amd_iommu_0/int_dte_mis/ 

                532       amd_iommu_0/mem_dte_hit/ 

             13,622       amd_iommu_0/mem_dte_mis/ 

                159       amd_iommu_0/mem_iommu_tlb_pde_hit/ 


       10.002170562 seconds time elapsed


  Performance counter stats for 'system wide':

                762       amd_iommu_0/mem_iommu_tlb_pde_mis/ 

                 20       amd_iommu_0/mem_iommu_tlb_pte_hit/ 

                698       amd_iommu_0/mem_iommu_tlb_pte_mis/ 

                  0       amd_iommu_0/mem_pass_excl/ 

                  0       amd_iommu_0/mem_pass_pretrans/ 

                 15       amd_iommu_0/mem_pass_untrans/ 

                  0       amd_iommu_0/mem_target_abort/ 

                718       amd_iommu_0/mem_trans_total/ 


       10.001683428 seconds time elapsed


  Performance counter stats for 'system wide':

                  0       amd_iommu_0/page_tbl_read_gst/ 

                 33       amd_iommu_0/page_tbl_read_nst/ 

                 33       amd_iommu_0/page_tbl_read_tot/ 

                  0       amd_iommu_0/smi_blk/ 

                  0       amd_iommu_0/smi_recv/ 

                  0       amd_iommu_0/tlb_inv/ 

                  0       amd_iommu_0/vapic_int_guest/ 

             11,638       amd_iommu_0/vapic_int_non_guest/ 


       10.002205748 seconds time elapsed
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
