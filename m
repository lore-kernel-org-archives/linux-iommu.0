Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B804AC433EF
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 09:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42E1E41952;
	Thu,  5 May 2022 09:10:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NCCtr1X9_LTL; Thu,  5 May 2022 09:10:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D944A41951;
	Thu,  5 May 2022 09:10:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B238AC0032;
	Thu,  5 May 2022 09:10:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ECF57C002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 09:10:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CBEEF41952
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 09:10:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wvfcvEJqzU6g for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 09:10:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::618])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3A57841910
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 09:10:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ks9QqSya1B1JVZMIMxEAxNwKwTs19T+uXEVgoiVuITU7p0dFjevBnUcOdSptKstNoszGTTewEHhVnDblD/2BpkPG2HMH8qTm53W/TmdDBOhAb9aEsJIVFySAOY6wV8MTrnGKCPZkmwPPVLPFEr1nnmNjW+xy8/SXTIDPXQzolt9P2qjPIVSOycYj0L7Gx3wPoIdAqzBAFSQkehGp1hldbbgoiMA8LoO2zOdO5RAsbkzPINzTr/Kefv9NHWrqMnMoHBFXxZZhCVupC0NC7NVuzLwwEN3AZvBJdFetvWipG9P+EOrWrc5sbApU5olFRP/MgViAeJ9dMOw7u0z0fKLQ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4q3cpSiIRK4jZxx78Cqdgs6XmoowI9tOi0cHJwlSF40=;
 b=AQ82h7YlHYxOX0eal/NQt/OfZJV125Nurc5Hb65omPjwuC47wF1mxIU5DExt5m20YK1XV+Jl5BzAMw584y7A9vok9l1JyXDI48Jp3npUPpnYMy/pi84RU2tKVQqMwaa76NDVCMl4tcSGBj37X03qL8KgjxuXOgW4tQBX0b9cM8n2fLdUI1rft2ZPrOBQu5X0/PXZBrlZ2RPWvvdjv2RDBEBhTDnArD0gEVRUf9Rb4eMan2/uIEeADB4Y7w4JNuk3ng13FG56dztDaYbgTmWHh8uPf/AfCHpDD2WCtaJ7w3GjBeRjxd1MgcLnwH1JROA06lUQ16eD/v2OzMqm9k9bng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4q3cpSiIRK4jZxx78Cqdgs6XmoowI9tOi0cHJwlSF40=;
 b=r0daWrvKMSl9ludvdcpLudIEYcmmZKVxRcvPRzHRTd+3/czppNCP06bCy6K6ddIaInAS0gm2ClzlohtVO46aNgYS7YR/K09Ra2rrliDch3nLQn71+oL0w49bdLKDljP0EV2VlTQOd/E+atlpf+/UFG3ctmfsGzXB5I83H1LKnBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN2PR12MB3471.namprd12.prod.outlook.com (2603:10b6:208:c8::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.27; Thu, 5 May 2022 09:09:55 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::309b:a704:5e87:8ce1]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::309b:a704:5e87:8ce1%4]) with mapi id 15.20.5206.024; Thu, 5 May 2022
 09:09:55 +0000
Message-ID: <0f2b79be-f075-9d61-2864-73c691013a32@amd.com>
Date: Thu, 5 May 2022 14:39:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 10/37] iommu/amd: Introduce per PCI segment last_bdf
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
 <20220425113415.24087-11-vasant.hegde@amd.com> <YmpoBWi60jPh6V/o@8bytes.org>
 <bc60989b-9f90-697f-f2f2-bad42f27f73b@amd.com> <Ym+4a1tBE5QIcurO@8bytes.org>
In-Reply-To: <Ym+4a1tBE5QIcurO@8bytes.org>
X-ClientProxiedBy: PN3PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::14) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b35688f-dcb8-43a8-a9fc-08da2e77051e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3471:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB34718C0943F7FFD8B099D24187C29@MN2PR12MB3471.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qxFYhjflIODel/1Y9LKBcLEG5UIXsjQ5sJyShuXZbVLxr6VNThrAf8RPTrad27drg5X/B6DbOdcpmJhjLNdhGaWvxgZWjLNiSFtOvZehF72Swisgxrb6kxJAo7jlGpCWH6IqkZrEctwq9Tue1jP4a9Ti7RKCNeIvtpAANbL0EsCXYZCcc930I3nr6SrJJ9GDAQ4Fg5k/WsSueRPwxxNpyQ4HxzZe4mdJEJva7GybsKvjHeF7HUe/AGXmxmUaBA0dUcDQyPDrr8sDlxVLmbDQx9epThbUDIn/JgcPRcmAXexOr0qfsYaggYy35UEBWq10rms5jxmS6yplGCIV9hWycOPZG2Lk65FnBzmaP+Suw6+6pO6/VHiF08CQjdU/+BMDAr2WvYZNT3cWSmTub6vLQ3CVEM9kAMHIUKmGr4hxd/uc5xdHqWe8cHf7R/nhh//1RljowWa9M4quy3mvDtc3VQr+67t2fJ684MxAr45IDyhnz0FDTuZizqzynqgxj3qDWq6VtlkffatmecIKy+jb/8Y1MpjQI7AJfj97LQv+iQNZZrW1mNhzNEfy9do/hiBuqszcfaN4PSUZzRJuYMWQIz31laJGji2yXQqy9aUCiNjXv3ANRzECLSn2mNQrOOmES1YUTUnGK3d/O/SOG6q0Eodx5xDRB8GtJAxzA5Ta2UeMJvrJxyyI9Etaa0G5XzZdsiZAxd3kTcp/9Fxlnnm1IffBCtZitcXw7oDwuk7yjLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31696002)(4326008)(66476007)(66556008)(86362001)(66946007)(8676002)(6916009)(508600001)(6486002)(6666004)(38100700002)(186003)(316002)(6506007)(6512007)(53546011)(2616005)(26005)(4744005)(44832011)(2906002)(8936002)(5660300002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azh4N25OY2NEQmlMSlRhOGp6RHU5YUl4dmJacC9lZ1NzSm8raUUzaWN4MUNz?=
 =?utf-8?B?a0pjK3BHb3oyc2lwMWdrbE1jYjhDQkc1dGhWRlRDR3JzOWRtSFc3RENmNStY?=
 =?utf-8?B?VUFrN0lpTStxNXpwRUFrdTJlSEVqcWx5Tjc2RXQwNkwzSmNHQVpoRHRZalB6?=
 =?utf-8?B?NVRqd25aQ0QwVis5N0JWTXBXNXBjVXNOT283MlN5VlhwUHVXRjZqdEpVSk5p?=
 =?utf-8?B?N1lGeWM1Q2NGbHBRblk4WkxTTlB0cS9WYlZaUGJQSXZUUndFNldDRkI4R0R6?=
 =?utf-8?B?LzNRVVhXanUvanJaWU1tUjV3bHlCWU1scitkVWU2a1Zid2Q3QXROS2ZtZ1ZX?=
 =?utf-8?B?bkEzTDRlbWJJL045UmxrVTlMMlZCSitHRDhqWjFDOEl5SjJSekY1dFlTMUNS?=
 =?utf-8?B?aEJ1ajd1WUhkNkU0cU5QRm1PdmRnMUpKeHRabVpTeWJqRHUzUGZVT3pUbVFT?=
 =?utf-8?B?SnZ6WU1FdmlxRUFZUE95aGd2eldNTzVGZGhjT2Z4Nnkyc0lQMVhzUlJHU0Zs?=
 =?utf-8?B?Q0w3TGRScjVzcWVwdTFGaWxRZFhhUWo3S1Q3UmhMdHVHdmFKd1RBMndrTEt6?=
 =?utf-8?B?U2tYeS9zb2UyV3M0MURRdHdmZ1NzMWxUZCt2Z3dOUkYzbFR1ZFVRWlB2TTZp?=
 =?utf-8?B?OCs2bHQwb3kzSVp3NnVkQW9sYThpVmd2RUdDeVJHSG95QmhVcmllZk5FMEhK?=
 =?utf-8?B?Qm82TnUrSjYvM0Jra1pjSEo3ZHNkSVpDNzFVbGdCblByeVFabW5iL2oyZ0VZ?=
 =?utf-8?B?SGVIM0pCS2tJdDJ2OE9jL1cyR3IrOFY4MWVCVk5RMjFIc1Q0QVRCcDJVVWRv?=
 =?utf-8?B?NzlDYXk5U0tvMXk0clRwTlk1TmNTK25ZNlJlTk5ac2lqcWdqZnR4bE9OMkJz?=
 =?utf-8?B?ZzZKM2pPMHBkaCtiYjQ3S2hBaEJCV0FDekVmM2Zjc3BoMEJqUTMxNW5CZGdB?=
 =?utf-8?B?cE5sSDhid2U5Um1nRHNwMXBRZkJKV1JpdU93M1hLSHA1MHphNGpTN0YyMmVF?=
 =?utf-8?B?bGlYR1ZzWm0wNWJoc3NLUnhlaE5QYmJIRWZ5YWFVVE1OS2hLcDc3Z09jK3FC?=
 =?utf-8?B?Wlp4MnhiQkRBWEExbmd6dUIrSnZtVXA3Z1FQUGpNNkpocCtRNjk5RHBvci8z?=
 =?utf-8?B?SUVwRnVTZXdKVTVrTXFKaHRPSVVyTmFHQ2ttejdJVHVRRyt5bmdYWFdvTnJI?=
 =?utf-8?B?ZmEzZUxSeVRuRU4zOXVUN25yNmkwNi9QMWVRQWVYR2lxVjBjbml2L2RYSEZn?=
 =?utf-8?B?RGFJR1dXcVFSUE1UZFFCSDBpSVVvRHROM05kV0RTY29uV0NTNmhHUUNFbXpv?=
 =?utf-8?B?WW5OaFh4ZmNyTTJDemFYMG9scmFKM1NkQmliUDA5bkhpa3BRL2tOVUlSNzd5?=
 =?utf-8?B?VEhjMGE3QjI3OGR3UFdWckxmUDFJZlNkM2N3M0pFd21sZ0FQSk50ekR0cWVQ?=
 =?utf-8?B?MVRuMjNTdm8rblFBK3FzQzRDZWJMem5COVhBd2hTaWhBZXgydC9keFptNmIv?=
 =?utf-8?B?c2RtUElucXdzMmg0alVtOVhodHgvUnNDOEkwTU5Oek5KSDkwZ29tWUlCUzMx?=
 =?utf-8?B?Z2lJaXFXOHY0WnpRZ2c5WVNteFBacldBdVJ2MVJvQ0ZLRTVOTVdTbjJYM1Z3?=
 =?utf-8?B?NVU3VlN2VXNTaGpVOFZZQnd0RHdYWWg2U0JUaTRkdTU0MWJUVTcyMHlON1V5?=
 =?utf-8?B?UzNKSTNMYzR4bFpZT29sVGpzaWtDOXdqVEdURGtybDg5OEFVVHNkbG5FN2xF?=
 =?utf-8?B?SDBydW5TaHc3anFReVFvMmxldEFMRTMyNHQ2ZkJBSStFUTZ1UEd1SG85ZW9S?=
 =?utf-8?B?VmdocjRBNDZrNGxMaHUvUW5rZ3hzaFpDN3hFbjY0cDhWazJjR2Q5c25CR2tz?=
 =?utf-8?B?YXFWRmRvNjlrMzlIbWZJM0M3VldadDNVVGZFNGo1NUQ2dUd6R3FVQU1FUWl6?=
 =?utf-8?B?cHh6TUZVOHpneldZbmlxUXpOK1hGK1o1SkNMRnhRUXlrbDg4REFMcyt6Mi8v?=
 =?utf-8?B?RmxERGpJVFJ6ZVVlZGQ4WmExbVR2U25wRjh1MzNnQzlpYWtSSnJmMXJac1lo?=
 =?utf-8?B?VlB3bHRndVA2ay9LMy9QaHZYbGRmczZZVER0Q1MwbXBoWGJWS0RCWjFSUnI2?=
 =?utf-8?B?TFh4K2tURTRsWTRocFQ2bEFEUWdyUlhFNFl0NlMzR3ErOTB3Um5oYy9IbmQ2?=
 =?utf-8?B?NUxWY2k1K3FRK09aY0lUU29SaUlnMmFQTFd0L1dKWWZPN0EzNTdyUE12UkVp?=
 =?utf-8?B?b200bEI4RWkrdkU2ektaNFVDME0rSThxOFkwZ3lqVHpKb0xlL0FNdGl5a1kw?=
 =?utf-8?B?TzBCWlpKWmNIV05RbWVza3VCZ0NGcllTNVM2MTZMMHYyUEJCQmltZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b35688f-dcb8-43a8-a9fc-08da2e77051e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 09:09:55.2301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSx02XFVxwxlYlNBcr5k0rVJn9fs7EVekggxisbYCxg0Gt3pOgLc8coj4PMgdEyJVUIo/Ietw0pu014gl4M8wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3471
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

Hi Joerg,


On 5/2/2022 4:24 PM, Joerg Roedel wrote:
> Hi Vasant,
> 
> On Fri, Apr 29, 2022 at 08:15:49PM +0530, Vasant Hegde wrote:
>> We still need to parse IVHD to find max devices supported by each PCI segment
>> (same as the way its doing it today). Hence we need all these variables.
> 
> From what I have seen since a few years the IVRS tables enumerate the
> whole PCI segment, up to device ff:1f.7. This results in the maximum
> being allocated for all data structures anyway. Therefore we can
> probably think about skipping the scan to find the largest bdf and just
> assume it is ff:1f.7, saving us all the size-tracking variables?

With PCI segment, I think we will have segments with less than ff:1f:7.
Hence we need these variables.

-Vasant

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
