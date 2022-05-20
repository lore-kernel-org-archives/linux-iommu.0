Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362CCC433F5
	for <iommu@archiver.kernel.org>; Fri, 20 May 2022 09:55:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA39B845B3;
	Fri, 20 May 2022 09:55:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B1rT87OU2o_9; Fri, 20 May 2022 09:55:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BB6E184673;
	Fri, 20 May 2022 09:55:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DCC7C0039;
	Fri, 20 May 2022 09:55:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 216D9C002D
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 09:55:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1EBD242558
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 09:55:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rHoPiG2CqNIz for <iommu@lists.linux-foundation.org>;
 Fri, 20 May 2022 09:55:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::601])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CE2AD41D5B
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 09:55:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gp+nhXZC6VbOSXN6G2osEd/8n1bOMSnnWZLnpyxx57BAajXEkA+Pz0Hy866xtCO1Mu2hXaK/bYgK94fiHWlxw3ssPznu7jbKRmUqBFnrRCXGSh5DpQ0IQwsT8Sti5J7auBi3rgC+TSjzpPmXq97YAs4iugjz9qQ+hU6xqQT2EH939nWG4MBYJO7a4UE9msZweTLKjomqN0OE4y8h+RCVop0aQTmw9zher2knHQNBV9PjmX8k27uSSEaa9z2y1YTYO6yoeijFp6ECmF14THj1rSdAPNbJTYIHSSC7FAMs1CCY76KCC7TYtRrPpR5xcTNa0NR1BaCqtf8oCjHmB7IBmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5yCYZwBXOXsROBTFQAUsd8r9p7kwJ/lMDL9zDVC/W0=;
 b=LD4GjNXyJ0wkQpVJwwMYv3H/Q3vzSR4rBXtw4PpxYi6Bw4OEHxiiLJgp6MMOx17y7i6lNAeqDQoeqCU+wN7rd4qCctr4yTmSHoydXM6DusWxE4zCwXFMT+gEP8o3af4MBVQS/gbaIywehqMLoYWPdkLFPdxGzg675+RJWZc8VhHoElEp9ftruf4RnOxKFNR15jP5wUtT+NHeqTkmOeRqMzv0+3hko+DrC2wnZ427OISTmvagZrd+czx9UNwm7dz2BHtPtafUhnIVGWvL9+r1BMVp7wjFPH1FF71YwuGUCNuWqEApQrREZ424we7xfgJ57vRdMFeOPbb04PFhiWJJaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5yCYZwBXOXsROBTFQAUsd8r9p7kwJ/lMDL9zDVC/W0=;
 b=cxOi3S8wD9GM7wyGMEn2YQP5V891MsZ43ARqiMYF3kvD5q5teC27i5/dgM34M8X4jB4seW3Vmyi5/D77Gg+fg/MiR+3uueBC3Lvg3PQEWSELOmlb6gTp5xrwVLSb+l1m4Z9CeWowOZY6+JLqMvX2nR2IrSXNOHRK5dINIF8hwpw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.16; Fri, 20 May 2022 09:55:49 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::84a6:480c:5f19:fc10]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::84a6:480c:5f19:fc10%6]) with mapi id 15.20.5250.018; Fri, 20 May 2022
 09:55:49 +0000
Message-ID: <3b3b668f-64e1-1713-9126-59c7313bd894@amd.com>
Date: Fri, 20 May 2022 15:25:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 00/35] iommu/amd: Add multiple PCI segments support
Content-Language: en-US
To: iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
X-ClientProxiedBy: BM1PR0101CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::13) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45e78b60-dbb5-4ae3-7861-08da3a46eabf
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_
X-Microsoft-Antispam-PRVS: <SJ1PR12MB6363569E7B6D29508A7952A387D39@SJ1PR12MB6363.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e8ooslqcVLM2eQhW9A65zplvgB6nywCpR2HVd+vKiqMqPy1nVRF+vpJQtmfvhuoO633pK6ASdNLhKO6GPB8pATfDikXwBhOoAbiQqxfWUeM9K/Ke2JcnZ9vv5hBIUawL16t+bsdF3+xzVlNnaIKjnct4GMeo0CGHGh2q37oMmZOTT6lULbVOCVTDpOxZ3oO1QcSRyuDw+ON0pnzpLjW29GeD7EmZ1hj2yx+2oEraAQPmLpRwG9C4rdmSmdtf2nYHfhgTWXM7/u+XEx9hy2u/n1A0x0CkAHF8VhcNYjWlBD6ZkS3GMsrnDyp2s8SxZ7RYM15ceUc6ryqx6j2w+T2s0FKssA/0+bW11Z2TEPDElvekJ0xrrUKHMFX4WUX1SE1C3XaV74WJSJAWJOWyzNfW4xGh0kui4p2VpxDff29NHojqCMrEbZRY1Q9IpndLFlzH0j7m5xfUeoXc5Xug3LwFPQfJKFoQ0K+KmU6cj61nhYJktZ5yCNqf2zYrII64fLIKdWdzWZHj6kFjaaF10Ig1fMwEQ7byg0A+jpXKX4DSKMeZaxJtKw5HENQ8ZzD2l0u76fW5yhShGPr+N2fjvnfNzPSomzwytdmTj54wc51gNdZa0F6juskgT6xVYNYR1d0U/Hg4AuwaFJtT8FOPjxYFKlqVVIwUrSg59SgcxG0Pk0FqR590WIPCgA0S8eQ+dCaF5LV4/gkXmkI9ucV3xvW/HE9D0DyN/b54Sb9I8FyGMMZ+YkEe2bDzXa+omr2BC6aE7fiAP7tS2lBnrVIKRLRlbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(8676002)(316002)(558084003)(186003)(2616005)(6666004)(4326008)(36756003)(31686004)(8936002)(6512007)(26005)(53546011)(31696002)(66476007)(6486002)(508600001)(5660300002)(38100700002)(66946007)(66556008)(6916009)(44832011)(86362001)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHlxejB6c2x3K1B3L1lsU1g1WGNKUFJIR3RKMHBIMVJVODV5bWZPdnV6QUxS?=
 =?utf-8?B?TzV1MUl4Vit2SUplSnowdnBuSUFLVHpUTUdqOWdvYUJ3cDJUMzR6ZVVmWm5a?=
 =?utf-8?B?Wkt6YUhWazRxNDlicmxQOFR6ZjNIMDVlY3c3T1NQMzVSVXZZaHA5dnhKQ2VG?=
 =?utf-8?B?UGRFY3krYzYvY2NEWkRaNmRwN29HVm1TTHZZcnJxR1JyZUV6Vk53YkMrNnBE?=
 =?utf-8?B?Uld3YnJDamhKZXZ6dXlLZFE2ZjBMN0tKQkFPR0NmNyttMFhKMW5kclEzUjJM?=
 =?utf-8?B?U0ZsRXpoc2pOM0VrNlRKSVJxeFVEVkNzSDNrOTZsUUhTQkhGNS8yVlVGNVVn?=
 =?utf-8?B?bi9MRDB4M0JnZHVvemt5akdTc1NBSzd5cTJpTmlXbmdVakN2c1kxTGp5NWdR?=
 =?utf-8?B?SG9pNnNON1VlSk42TUVqTHcxQjJkV3A0SU5FZ1U3TThYbWRxQWFVem5pQ2g0?=
 =?utf-8?B?b3BTTkgzdmNXNzV3WEtDb0x1QmdSV25CaVl4d2pvY0xUSm5rQy85akxjWkFq?=
 =?utf-8?B?ZDBQMFlKazlQdmpURzVuSTdkSTRrZlN5RTY1Q0RjM0RWeVpVUWdIZ3FBcUlK?=
 =?utf-8?B?ek0wUFY4RksveGs3WGw4bkJ2NVpVMmtlekVqSFFKOUVTRVloR3lzSWRhUFFv?=
 =?utf-8?B?QnhxMjZLRnNOTGlxK0ZyL09wMVFJTWhKbE96Q1crWENCZGlkcHN4R0tSekFW?=
 =?utf-8?B?RGdaWlVJWjNQazlWVkFCNXliaEpXNXJNS2puaE4rMG9Wai9RcVZ2bEZ3cEU1?=
 =?utf-8?B?OHR6OGhqMGgrUGRialdWZHNsSEp6Z2djSVR0Z2FHdFAzamNHL3hZME5pd3pQ?=
 =?utf-8?B?RVJJSW9PSUc3N1FJNDE2MmN4d3Z3cU56cXJGYTVDSzRRNFZvYjJDaUJQY3Vl?=
 =?utf-8?B?dzNlejlhdWsyTGYydHphOEpOb0hXOGdPZGRySnp4S1RZc096MXVkVGZKWTBU?=
 =?utf-8?B?VG5mVWlHcGJvblNENExjNVl3b1FTWUZ3MzZxSFBuMWxmOTI2M1B1cFRSTWIw?=
 =?utf-8?B?NVM1SGtXTGNnUkZMRVVwK01sM29VQ1YxNGduUFVzMjh6Y2ZqWU9QTTdKOXFW?=
 =?utf-8?B?RUd2UW9Da29NRlJvdUcwU2VSSnM4clN4a1BwbmJRVkdQWlltR2hLcWYwM2Vz?=
 =?utf-8?B?NzNTaEV5bDFJV2ttVFh4OW0xZGJUVUlDZjNHTEVwVURiZnJ3TW9PTzNaTnJu?=
 =?utf-8?B?SFpYMjkyUHJuUWVTS2xUYlhSNWpZQ0RSa2UwMmttRTRFT01mQlJGaFFLdlla?=
 =?utf-8?B?ekIwYzZ5aUtrLzh4aVpzSllFYnl5SHNkR2Z6a2ZkeGk4MFZXZ0NPQk9JR2tr?=
 =?utf-8?B?Tnl1TXZKUVJzcVZxdGhIaVlnZmZJZW84cDRENjNQRzByWStQQVU4cFBUdmhZ?=
 =?utf-8?B?eXpWYUZITzBkdy8wMEg2UzJtdDMxVEhMZXlZUGp5S0VUZmpUZWNlaGJJSjJl?=
 =?utf-8?B?ei9Camp0NUlyZnVVa2dBQWltcXk3Q2xGOFRjN3RBZTYzMzJucStCbkdVeTla?=
 =?utf-8?B?OUd3Qk4vRnBiMjdwWlRSUTRRRGVEakwzNXRBY0hCNVZ6bUN0eDFLck9QdGxM?=
 =?utf-8?B?cFdLTytoV3hFcHFrM3FsRjBGY25hTEVVZ0hSRndsTE9BNFk4SDlwUFFsWXR0?=
 =?utf-8?B?cWZZWUtKK0lrNzlFWUthN3k3djBCRUNwVDlrVU5kb3FXYytKa3NCUTNJYWpD?=
 =?utf-8?B?ZWl6eVdGTS9tYllQRGkxcVl1T0x5TGJJaS94emswMWhFeWgxNFNTTWgvbXkv?=
 =?utf-8?B?ckpqcVdodDZoeG9VOFh0M3k3a01ZeHhSYUJsbDNLdXh5RWEvOC9tZ3FQMmZ3?=
 =?utf-8?B?WU1NUVJQS3hqUUluVzhKeVZhMUtqekgrSTVvVDJ1bmQwZnBWNHVUMmJSOE8r?=
 =?utf-8?B?K1FGWThQaDdlU1kxdFoxKzl5RHlTODZ3L0ltUVRyeW9QQzAwMURNWmVUdkl4?=
 =?utf-8?B?TGVJVlJkUXJKR3VjM2F1UmdQK2QzREIwNmJ2d2JLZDNvbXhFMUducmswM1ly?=
 =?utf-8?B?dmJPZkZYalF6aDJrSmRFa2xtWGlpb1YwaG1yVjFvYVFWVGNCelFseDh4SWNB?=
 =?utf-8?B?R1RUSHM0MzZNbVhXZzM5SkxGV1pEV2JHY1Jtcm4xTzQ0MUl0aWlUUEFwdlpn?=
 =?utf-8?B?Vm1rWmZHVzNaeURCRm1SaS9mVENYbGVLRDh1SW9YdjdTN1QzQXNOVWxWVjNL?=
 =?utf-8?B?cks0NTVNMTJhRmxzYjkvdGU5aUN5VzFrSFNuU2hUL04xMUNUc1lVSjNZazZU?=
 =?utf-8?B?Q2V0aGdTem0ybm45cEtXLzNUdld3RGFKeEpTRWF0aVQxSjRMNXNOWHROb01n?=
 =?utf-8?B?djlmNmx3REZMeTFFVVpDNmhPRG1ibTROYVBnT2dEQVRHL2VGWW9zZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e78b60-dbb5-4ae3-7861-08da3a46eabf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 09:55:49.1114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KvR2ff5K903shG43St3HRQzhyv7X4oXshIPHNLL6zDZFxiune7Jf3oLVEieOI3/qyan6V5PgmN18qI1R9YVI7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6363
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

Hello Joerg,



On 5/11/2022 12:51 PM, Vasant Hegde wrote:
> Newer AMD systems can support multiple PCI segments, where each segment
> contains one or more IOMMU instances. However, an IOMMU instance can only
> support a single PCI segment.

Ping. Did you get a chance to look into this series? 

-Vasant


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
