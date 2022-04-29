Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5A4C433F5
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 14:37:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ACD434040D;
	Fri, 29 Apr 2022 14:37:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qKzB13Qp56Lj; Fri, 29 Apr 2022 14:37:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 88F364000B;
	Fri, 29 Apr 2022 14:37:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F324C0039;
	Fri, 29 Apr 2022 14:37:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47FCAC002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 14:37:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 35A4360E2C
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 14:37:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mc7q_skct3TH for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 14:37:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::624])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8CFA0605B2
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 14:37:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUf4hpzLqGQcQ5J/lilhQ8emFJ6GTkSGJu3LkVA0UywXRlSPODQoG5BoPlfevRyjWb7u0Yl1nx726hvKILbf4u+ntch3li/IZ1caWYF5sjsQah3UIkw27t4592pTWeUm6xjYgB6m32I2PghFwuCkmT6I1jjzjo5Pxx9mVhdDzxBDN5aRjAdRpV3EaI2NpPDRYblb/MnDrXSgW60JhGIphTs4xuzw74EA+zpg5cerwYOB46qwrQ9/Y2hh+Z9PpaAO6xe87wC341z/UKOcBzFKilN3QxDDwcr8qU86/LC/K2fuFzeP1swnaraCT6cqgFxL4SK/dbUmKgCjOmd+kwhaSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMB590roeV6K55/gusUPgsws8Ma4pIc2dKfpTPFgMHA=;
 b=PrnxOhvJOUGeGsWSaZd5vEOIsODR/GnvsQ6T0yfmEnEnq2ReTyp8LeFOxM23Vc4qxqu4a+5JL57MCetvMWisLU4d6lbh6kDU1J2R8ZCQABCD7rEafA1ApJ9MqnV0VOk2H+9zCap4XxAP2ALWatoo+xCwR+fW9JbWZZuNWCpfIhHAsdpRqkfUPq4/K6s0AFYkP5ZPUl+xNytsckOZCL9UeN4/EISgcOTgoZFg8DoTgeUSx0xV8kGxEzLasN2hiV946XbEOeUVJtKRA+3z9ZtvdQEd96WrfClcU4zZ7WUxQh9u4U23QLt/uiHN9viGXi8v5eVFmGel4TfRFtXlLiyE5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMB590roeV6K55/gusUPgsws8Ma4pIc2dKfpTPFgMHA=;
 b=w7WnSTdiQY514JSl7qjrisHXooWqrvx/ur3VR+p7oz1Fqm4E9bZd1nVtyqXLSXTaA4TBvit7e3P49hogkfSXhCL/4Qb5Zo603V0bqEQWmTPPxuLLkWgQ87WBYp3654ekQ+ojMAXdL0VTY7OkbXm2VHV92OId6Vx/IAlY+81ehrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BYAPR12MB2728.namprd12.prod.outlook.com (2603:10b6:a03:61::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.17; Fri, 29 Apr 2022 14:37:41 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::309b:a704:5e87:8ce1]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::309b:a704:5e87:8ce1%4]) with mapi id 15.20.5186.026; Fri, 29 Apr 2022
 14:37:41 +0000
Message-ID: <f9aa56df-fed9-98d1-6a5f-602a6a566e65@amd.com>
Date: Fri, 29 Apr 2022 20:07:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 37/37] iommu/amd: Update amd_iommu_fault structure to
 include PCI seg ID
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
 <20220425113415.24087-38-vasant.hegde@amd.com> <YmpqMVIVTVsYk+Me@8bytes.org>
In-Reply-To: <YmpqMVIVTVsYk+Me@8bytes.org>
X-ClientProxiedBy: PN3PR01CA0137.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::14) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62343501-d6b6-4901-e1ec-08da29edd076
X-MS-TrafficTypeDiagnostic: BYAPR12MB2728:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2728A4B60D2E999AED7D1BE587FC9@BYAPR12MB2728.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qGx+trEOtpOH1MtedA+vhFKA5Xeu5LhqplhalbuzZJu02CqeXwseqI6tOCkH2ysmN2YuB4Mg9Z3azleDo7KwYdDlAFPZ1j9PBqjeE/4Zfq5aTfk371PjiOTVOoHKQM7e329mjoUYBlEvUrNUxA6IjcVU6ggV34E/OlrHJZWyt+KQhGNGj2FuGIOrRFEZcDriqEESDAGVgdt2Cvo6rAlRePcCko9TQ3Y+DjIu2htchcw1YAjo5TUkVdD6ibTwUJy5tS0IK8CKdM4Kj6a256BcvNAE+uyTXTu84csNRAQ0UkMV7yMYz2cjh3EGa+0pvLZjO7pCY6qJ/X3fxYSP6oGmtv2Gc9/mg94YMYswZUW73pmJ04SH+ZacWqxo8UOYMyUqS5Sy8lxFgtMc4uIQoaBDHotLqrEQ5sU2KCBwSTGZPi4bhgwpf3VvvjVABdl5+uhkzSkz1NOEAA8Ua68j2r+QiVQAi+9cbII8K/E74d5mahmFWQNv7jYkjedcetqg8XZMf+nyscNf7Lta419ehHNJ/WJC+BfrWQ058Puey/qIVBLAWEII5fzgUVepZjNBG4U4WX+bUQBVEno7SoAB5kXNcqVA9vnQHm4YrBUwwrIfNy4Q9AApXGpLe7Fj54vWZfDCIaU9BpUZOFFW1T28yYZDM9dxVREEvX9f7RxlHknHCgDtudCrn2PoleUjrrQljsKdu3G+yP47RbEhf7UumhkNMO254ku9CpWFYqgjdPeRxQI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(66556008)(38100700002)(8676002)(4326008)(53546011)(6512007)(558084003)(316002)(86362001)(2906002)(2616005)(31686004)(8936002)(186003)(44832011)(6486002)(5660300002)(36756003)(31696002)(66476007)(6916009)(6506007)(508600001)(26005)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjQ0a1hTSXF5SHljUDJOYnpCK2VDQWQ2THpoK3hJVDNJVVJtc0ZjWnVzRmxh?=
 =?utf-8?B?MktXUG9UekQxM29tWEZmdXRSNTlvZlM5L0lUK3NlRVVRQ1lWV2xMcDgxM1U5?=
 =?utf-8?B?VDMvVzQ0ZDl0THZqNGxPQVlKYk9tcEF4WmNwcUdGNkdQSVllcTg5ZzJrejFv?=
 =?utf-8?B?ZFFBN0lDSGVJb2dWUStrc0NSNTE0WCtRVTFNSW5DSGZZeHhEWHVNMHFXS2ky?=
 =?utf-8?B?ZmVrdFNkbmlydVJML3RQQ1dWWmdSV0dUOU9TNjBXaW45WVRZTHdGd0RLRGYz?=
 =?utf-8?B?V1dVQkIyaTlacG1GQ1J1ZVc0VjNQOTNtYWxPaVdaZVBlSUMvZVdINHlzY2VX?=
 =?utf-8?B?UnViUmltaURrSjYrbUdYQURWS2o1blc2Y3owWWYrNTNVV0ZlcjRVTjk0azFp?=
 =?utf-8?B?ZFpxaWZMTFdoUXhML2FWb0k2c1A5eEN0RTB5UThOemFsSUJPUlVHVGxzQ2FJ?=
 =?utf-8?B?UDFBN3Izb0RTVXJZb0xhd0UzUDJzM1ZCRnR5bTBRTTRTOHRCS0JGMi9MZjcw?=
 =?utf-8?B?VjJEK2hRcGRRYk1aNnk1VHdwYkhpa29HOXdwT3grUW1YWHkvUnhObTlnMnVV?=
 =?utf-8?B?aUJ0clpoRm12Kzk3S3BjZSsxb0w4dEhhZFQrUXZkS0F6UldEV0trUEFmdnox?=
 =?utf-8?B?ZGpUK2dIVU00dURUbk1yZzl5WnNja1ZNZHlGd3psZmNhRmM0c2VzdU1jTy9B?=
 =?utf-8?B?enF5bmNLd0xIWlZTVVByZDhjSU9iNEJTQURuMSsvREhYbnQ3c0U4VzJmbEtI?=
 =?utf-8?B?NEM2NzNMVXFnbU1nWGpSbHdvOG90dDdPT3R1RXlKalVjTi83S0d4a3pKMy9I?=
 =?utf-8?B?eHNiU0dPdWRFb3JKU245YUNrQS9IV0M4M3piNVBmZGk2RncyTjRQMGswWGFS?=
 =?utf-8?B?OUtHOEF1VEwvV3NVT2VmNHlsSWF1a1NONXBoRW4zVS9keFZ1dHNmZUZOc3Z5?=
 =?utf-8?B?c0dSMnhuckdxL0wwZU9HTFVDbnl3V1FadnBjTzZiRkZ2TWhjL1ZyOUxoRnRB?=
 =?utf-8?B?TWVRMy9QcXFrVzF2bmNpaGcvcGlCSmQwb0w2U05KSjBNakFETERxVlgvUEtT?=
 =?utf-8?B?WTd1ZythM3FyTVZuZ3hZYWZGdEl2c3NnMnk5MXVmUXYvc3RXbWoxTzdrcTZY?=
 =?utf-8?B?Z0RpSUhPeE5aaWdaSkQvUTlab2dDOUU5dnJRNERsVHI0cHJSLzFiVUhUOW8y?=
 =?utf-8?B?K1ZNUGxicDhmakZVRy9xTDRRamJxbzBKUmtGcEYrU01UaFlMUXlvZVFkVVh5?=
 =?utf-8?B?TllzVmVjNUxscXI5SUx1Ly9oelhnYzczMFRkdjNqbFJwN0RBWVJINnloTjlw?=
 =?utf-8?B?UTZ3aStZZklqVGRzN2JHZE1MdVZETklNUXVabDUyZzhWYTJIeFFhOHdrMGo3?=
 =?utf-8?B?YlNZdXZHeGpJdkh3L2w5WC9YaUV6YnF4TTRUSllUR3lPVW1kc0hZTyt4Nml3?=
 =?utf-8?B?VU5ERHNpSWR1ekhqQlM1R29PM2FNWDZRSHJNbEEzbEt1SjRiZmdFTUhlQk9U?=
 =?utf-8?B?KzBJck1pSk1IVFJjZUFQZlhwK0IyZEo1Q3NFbWNreHNCSjBSekJScGVZbE9Z?=
 =?utf-8?B?ckF0ZjJRaHNheHFyMlZCaW5ZejdJa01lRDBMc0luNXY3WmhPZ3hTU09OSkRJ?=
 =?utf-8?B?Y3N2TGhhNldEa2dwZ29MWVR3N1hJeFdzMkE0ck9SbERXZ2YxMEc1UXNCaUF1?=
 =?utf-8?B?Y0l3dFlmVUg3TFhpNkRuRk55cTVobmljZUtPaFpGQ3dKSUxMdVEzb3BDOHkx?=
 =?utf-8?B?Y0hJejJlVzVNZ2UzZk5LVFFPbDFhVVV0RFFzaE5JcG9EdzkySDhpZ2ZBeVNp?=
 =?utf-8?B?SHczWExLVmtpN1N1a1pvbHBqOGZSd3duUHNybHg5ekNjbXVaZ3FqUTMxUGgv?=
 =?utf-8?B?bXB0SlcxMmNJZ1VyQlY5TDFDeEVCU3YyYmtKbmRhSjZJTUNuOThna21GdCsz?=
 =?utf-8?B?Wm05WFl1N3JXSnBIOTFISVh0QytiazBBRHBPbnZXRUdjL3o5U1pQVkVtNm5t?=
 =?utf-8?B?OFd3UTgrVk1PbHo2aW5Iai84dGJ6RjNYMk5GenpNcFJRTzNWbHJkMXZlS25C?=
 =?utf-8?B?TTcwZisrWGhRY1kzb1IxRnN1aTFybjJvVk12YVdlZjdpQmN6OXpxSVhRZ3I0?=
 =?utf-8?B?NTBOUGltSW1abEkweFVXanFIRW54TnBZc3JMRUtaNUk3UVJKbjdtNUdycDEv?=
 =?utf-8?B?YkhMUmFvVEhxak5Cd2hVWHM4ajd2TG5PbW9kZUlSOENqUklrUnRCOUNWWmVF?=
 =?utf-8?B?T0FJM3IwYzc1WFNwS2pLeW5xZTRzU3l4ajVXeHJCZmZaTjM3Z1RvbFdPNDh3?=
 =?utf-8?B?VE82MkR0ek5QdVNFcFZGdE00aHhJWUtKb1dkMFYvcEw2dmtldlBJUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62343501-d6b6-4901-e1ec-08da29edd076
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 14:37:41.1079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayP0L156fReVC0kc0XhPnhSIbLZUvDlksSO3cQW4dxTClh617xpJNhWhP72n6HdWOoJY66WM3SaNs1CbwS70CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2728
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

On 4/28/2022 3:49 PM, Joerg Roedel wrote:
> On Mon, Apr 25, 2022 at 05:04:15PM +0530, Vasant Hegde wrote:
>> +	seg_id = (iommu_fault->sbdf >> 16) & 0xffff;
>> +	devid = iommu_fault->sbdf & 0xffff;
> 
> This deserves some macros for readability.

Sure. Will add macros in next version.

-Vasant
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
