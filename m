Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A67FC433F5
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 14:36:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CF0E840A5F;
	Fri, 29 Apr 2022 14:36:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vQRH7RTg_C_9; Fri, 29 Apr 2022 14:36:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B20C24040D;
	Fri, 29 Apr 2022 14:35:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E3D3C0039;
	Fri, 29 Apr 2022 14:35:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2B24C002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 14:35:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B172184029
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 14:35:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nUJ7c72qkKXE for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 14:35:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::62f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0CA6683FF8
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 14:35:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EC02Wa0QZqkO2vygAhYi9/76/bZw64bJwbz6HYxGX8cCwIicxNN3FcOIu6GbnyqMZmwY9Mz6hp7D5DCog9NMTJrAQ57Tk89EbbY8LKHOA7j2TrG5wXnnXTwGqQrH6qoVjLWYAKssPIXVY72s6R+UjOY72vzUZWpsaNIY9TNzp+gcgIGdb9Z7NVXSQV90YplX6nilZ5bRF7NNSOAtaSVGJdI2WP/Eut0egYNM/dFzB4Ig0WsmfG0ipYwaNJQVrwa1//PDyDvYqogfP6B+CDfM2WKN4EGrcxeHhpMSDcfXAyAgzjzfK0h5jqXic/YaykOW88h2OsoHRQ6WQQXSeeA15A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmBjqMK+RPMlOyJ01pvoEVUAtKVsG4PPrdecqNNv2Rk=;
 b=clQTIiqWrVQsnjAwLSZHs9D/E9+MYtdVoR3MZMnEFC0tQMYISKs55NEDn8eVZTMHhzYPU7fcj3iB5q85+fVyHcv35c/BYrci+N/cFdaKKjW8oPXwIC3cmbKKhMF6FH6bV0G6ybieczXPVP444HsyQ2cPCkt+8tN9XwVOJVR6sp1Dq2imdsAUSxxjFmQ8e1iQmw9eHlqCXHM5xO5oqZFvaavM4TZLhUsEk22lqsRwxPF6VY3Zv6St35rTGyngZGmvHJnM+Nb8aut0NW6/l7jurpzrgEtgvNpxCL9k85vZAvWWXDIDtk5TAZuC+RuGxGBwr9GKHk/+CFGtb9zPuuiRsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmBjqMK+RPMlOyJ01pvoEVUAtKVsG4PPrdecqNNv2Rk=;
 b=JFsKomzQv8n1/+AZ9oUpXU7S49sAIAoJtPdL731h+g/Nc8u+Bv3XTC/dsJzAl6WNZ+Am3l1xVIoWX7zmn1pDp52Ki+/SJNQdLRrk39kUNK99168CZho76aF+YpVoWz/1CSjhUrZhWhjszxkN5mHxgaks2o39YVwadfqquflUq+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BN8PR12MB2849.namprd12.prod.outlook.com (2603:10b6:408:6e::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Fri, 29 Apr 2022 14:35:53 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::309b:a704:5e87:8ce1]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::309b:a704:5e87:8ce1%4]) with mapi id 15.20.5186.026; Fri, 29 Apr 2022
 14:35:53 +0000
Message-ID: <07881bb5-4938-cc88-e5a0-3a4000c3d643@amd.com>
Date: Fri, 29 Apr 2022 20:05:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 00/37] iommu/amd: Add multiple PCI segments support
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
 <Ympq6Gtjq/Adwl2e@8bytes.org>
In-Reply-To: <Ympq6Gtjq/Adwl2e@8bytes.org>
X-ClientProxiedBy: PN2PR01CA0133.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::18) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64072e15-78d7-4ab7-9071-08da29ed902e
X-MS-TrafficTypeDiagnostic: BN8PR12MB2849:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2849AD57966CD8732FC728F687FC9@BN8PR12MB2849.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m8u4nWZXMAN1Qk19hFB7bMWoPTFRakGiZWDcbczaP1ZQ4nExv0OstL6HuxHqW6LBle4N6jfxpbKWpgVVrurMNFso2N27pO3R15YHmjiWsxuAMUWsAqxwl8OkD8lKtET5Xp1xv+sfXhDhlROglBM1BYVBXXhxLQLfP1fg950HRJ8EcOuYEO433zB2KJDXqY/SIb+dPDFqdMXPNLlOpB/CVD+KkanrCEYzdvWtOHBVC5v6wZ5QXZQ/xOw6ToYywb4xBQ1A1Y8FRrJtetORQ0dwArrRYuU9Up7uGlRJ1HBraweQhBcCebmGbdITjKicZQh0rTGDL09FU/AYuc3wJdf4W8iJaeUNH3o5ctWKElqAeyoGCmUud81+NB2RJNkIaFIwtYIVzwS3RnNDGNDw6HkvZX4sGnYt7X8BUVjwfDeNplSgA1Gr00cYoDZuw6Yfu29wn/pjr0wSkhDXfTTv8PHlHYrUMjVi/jnWwOnUoIZ/hbyvTgFKdnheyZlOGl6b4Wp8hc5VrMVCh19K1UqHlD97sOU85doz552495ySObaq+5RpaWD+/c6Tzo0VQOoaCXzKJ/ZI+52Mbe0Mtza33QmfUEZ6FZCBSNnzcpNxR5uw8glmEQlWHETnzphT+lndBImsNGXCUmkwILhjFUjEN80ZeZRqfj0Fpi4HMyenjxdq3CLjtqbanc7EZRuZVKbHzyPHLCgnsUHSummjhdzPojIrsazUgyUnOfuNBNNJ0oj/2NA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(508600001)(86362001)(31696002)(2616005)(53546011)(26005)(6506007)(6512007)(38100700002)(6666004)(2906002)(66946007)(44832011)(66476007)(316002)(66556008)(186003)(36756003)(5660300002)(4744005)(8936002)(31686004)(4326008)(6916009)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUF5WWZ4SXhaTUk2aEkyTVB3R0Qxd2Vyemx2SEJBUTJLN2FjUERyMjY0ajIv?=
 =?utf-8?B?QVFkTU95eS81RDhVdjZsd0NBZHNTMkxGRkY2OTJmTnd4eUhsRGxWRkRnNi9H?=
 =?utf-8?B?b0U1cC9ya2ZjL0RzNnI4UlU1b1pwbWtaTFBObUNBOHF3R1hkRE1Za2kxRUxl?=
 =?utf-8?B?TWpNdkw2RWhZUDVyVGlvZlRkUWJkRTdaSnNUYkczdFg4cmZISE1oVVdtTDk0?=
 =?utf-8?B?emE3Qjc0UVZoS2xOTnZOWHFBWnVJbWM0clJZbkJBQkNpM0tYTlgvZzk3YjZx?=
 =?utf-8?B?SGU1cTZNb2ZaT20yazdQL3NEcHYxYklKMUt0M2E0aWlhbWtXeVVxVDh3b2px?=
 =?utf-8?B?V2NGM1dEbXFjNHYxRWlZdEZkZ1lSQkVBYklYVlRZZ1pZbno0MFdzTHB4a0FK?=
 =?utf-8?B?blQreTcrbEo3UmFncm04V01SaVc2czVSU0tlT2JZbUZoakx4S0EyeHFGckx5?=
 =?utf-8?B?RnpYamtJVm9UalVlMTFiNXppK3UrczZNWkVtTlhVYThSTVpZejFYL3pteG1h?=
 =?utf-8?B?dGxqN0dTS3ZMOGxRR3NENGQ5SGFPMXhwYTRaQnlzVmZNNDFMUk90alp4QkVR?=
 =?utf-8?B?U1JJQkdrWVFZbS9xMFppelJabUVzUVdDQVNSTTh6RFRPNWJzS2FoM011NC9H?=
 =?utf-8?B?VklJSG5uUDZIbGJQNG1kNnhDK20vTDJReGt4TkwyMC9GZzlZdit3RTArZ0NU?=
 =?utf-8?B?akhZVFh4RVRhekwzRHoxNjBDam9vUy8xVEVrQ3BDMDdybHFRYTI1ajRBemdX?=
 =?utf-8?B?dWJkN0JUVG56Zm8ydm9UOWJpVk9WU1I3Y0NxMnEwRHl4S21mdkdBcUtYcXVq?=
 =?utf-8?B?a1VYQm9wRE50SytHK01BNjFuVTgzNmkvTnFMaU93VWI2UlN0UjZaQmF1akxH?=
 =?utf-8?B?NlZPMklmN2N2WitXU3NTM3ZLbGdvbi9BOFljMmdYZ0ptVHJpNjV0ZTRub2tx?=
 =?utf-8?B?NkM1WFYzNHBkWTBBUndiUmJSUDlZSWkyNkdrQjNXbkxZT1p2cytuMVBBbDlD?=
 =?utf-8?B?dENWSE9qK0s5UFdoQ2VDTzRoU3czVVdqbXhFMGl1UHBZMmVzRGo4Y1Q4SnVV?=
 =?utf-8?B?c2pCbERxK2UzSWkwODQ0MmNiL3NTSXF0ZjEyazZlNGs4ZFRsZVlBOVNkYlkv?=
 =?utf-8?B?UHhvbWJoMkJIU1dlTm42c3J0MXJxUmJ3UUtxUkVzYTBRZnA1OFZITE93aVo2?=
 =?utf-8?B?eGp2Y0hVdFlGSjVzVDRSMUxjUWd4V3JIRzJCSXNibDdwZmV0Rnk1VlMxclF1?=
 =?utf-8?B?eVRURTJpSm40Tyt2L2RnYnJYOVcxVkhlek9CeGdNdFl6VFBnVkVLTTlzWmVU?=
 =?utf-8?B?VzM3ZnhkMjQyakx1T1QwMm1mNmVkajJsa0hoWURPaGYyVUE5bkp3STlPeHNl?=
 =?utf-8?B?YzEwYkRBc216ZjlDcnEzMUFZcFk1RXJ1cjZ2WGdzLys5d21Oa0d0aGxSb3Ri?=
 =?utf-8?B?UTJZcElZUGJxSEtuWXN3VVJhLzloL25Sc0wwSkZVM2E2M05HWHphR3JocHZW?=
 =?utf-8?B?amg0SkJtU1J5OWdRUUxocEhwSHVzRTY1YWlmcmswVzdBVjc2Sll3dXpWVytn?=
 =?utf-8?B?SWU2THFwKzhLYzdwUFQ4OGZMLzFIZ21ZVFF2emYzRlk4UVFaZVFxbHkvd3A3?=
 =?utf-8?B?WERIeTRXa2trdDlTcFY1bFlIZWRETHF6aHRWL2hBSHVWY20rdXo2TzFiRC96?=
 =?utf-8?B?UXJuMFlzUEdRRkd1R1N6bFMyTjkzTnNkVkVubEVkeXhyb1Myd0Zac1pSTU91?=
 =?utf-8?B?Nm51OEpmUnhISk01dWdkN1ZVSmUyYWhiK0RDVzRxSWJZNzcvUXM0aVF4Um0y?=
 =?utf-8?B?cUZyV0R4UkVEWVl1bkJ4V0FXU3JUTVRiSlAzVk8ybFdQelB0czBSRWNRek9l?=
 =?utf-8?B?MHpUSzFzQysrSThydnBrMithM0dKZEN3UklROXlMZ1pLRXZSVEZnRGxMWlM2?=
 =?utf-8?B?bzAxMWxzakkvN1lrbDBJQlVyREx4SmtXRWVjL1BOMUgrYWRRdEFqczVLNEtw?=
 =?utf-8?B?NTFkbk9ucWtNZlMvZU9aK3FuRWdnMWt6VWUxNmhscXY3anZvZlZDSzVDdHR5?=
 =?utf-8?B?c2thWk1qeFhOUDAzOXhMWm5selJDM3ZiakdIdTFFR1hQckZNa2xPaTN3MWZQ?=
 =?utf-8?B?TC9WWGZsNzVKc21yNlBhN2V4c2UxTlFWU3U0VGZEU3JLajJDVndvUUswZ2w3?=
 =?utf-8?B?SE9LVkNlY0Iwak1PTk5VcC9FcUhMZEZhMS83UjNsclhMZWs1b29LMCtYZmFh?=
 =?utf-8?B?SzF6aFd4ajMzZTNjZ3g0bVVQU3F3dDQ2Z294UjdMT245MVlyV3FpUEpGQWJN?=
 =?utf-8?B?RXhZVkY1RWZXWW9lQlgrOFFLQnNzVVgyRnBhTUNkN0xIYVJZOHdNUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64072e15-78d7-4ab7-9071-08da29ed902e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 14:35:53.2586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CeJJOjfZzBG25L9fwKQo6uLzr17ZtDLuAB0ob/Iovd0ge3OtlTakIw9wlYcpYFLo1s2CpEp0d3Je7Od+giQgig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2849
Cc: iommu@lists.linux-foundation.org
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
From: Vasant Hegde via iommu <iommu@lists.linux-foundation.org>
Reply-To: Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Joerg,

On 4/28/2022 3:52 PM, Joerg Roedel wrote:
> Hi Vasant, Hi Suravee,
> 
> On Mon, Apr 25, 2022 at 05:03:38PM +0530, Vasant Hegde wrote:
>> Newer AMD systems can support multiple PCI segments, where each segment
>> contains one or more IOMMU instances. However, an IOMMU instance can only
>> support a single PCI segment.
> 
> Thanks for doing this, making the AMD IOMMU driver multi-segment aware
> has been on my todo list for a while too. Overall the series looks good
> to me, just some minor comments to some patches.

Thanks for the review. Will address review comments in v3.

-Vasant

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
