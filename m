Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7775ECCA47B
	for <iommu@archiver.kernel.org>; Mon, 13 Jun 2022 14:39:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EAA67410A1;
	Mon, 13 Jun 2022 14:39:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5gNxHTFX6KvF; Mon, 13 Jun 2022 14:39:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2486240942;
	Mon, 13 Jun 2022 14:39:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFDD1C0039;
	Mon, 13 Jun 2022 14:39:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E39CC002D
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 14:39:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5F1436068A
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 14:39:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hwk9FYNazdPR for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 14:39:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::60c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D131460687
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 14:39:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6Q/jH9pggx0p/YRreWwU6TLCfXL/e3HghSfJrOVjS7LN2sPmTNRufDsN6g5ymNwJolyWwUKpZAVvJntJlzezyVt2FSCx+rRcek/qLdvXy1KmjFoat2t3adCVjjWaXGf3Ls/pYZfnse2daV6Zew64AtLyADkfab87h/8YbyZ8grA6PLuE3z44pQdVtDRdC4ZOt0WHgk8lc6LlM7PC7JNG9ZAg1IP98O5L2LujK1vwHTvc5iYYU/jBHPUWLqekeywqNQXOClHo8I/Idk9rHR4XNRw5FkVY+JTdbJPSzV8oCOuxHcWE4VCOkEQogvR5a1BXCSKvGJXUwPpIPR5NzC9zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bPc8yOAqlxwjSn6l3m7I1LkU+4zDVomzRLftPEOr6o=;
 b=B88UteFlhuD2fJaxM0kKBRhnz36kTkfWZbcx6/0CmnQZsHT+7K7KzI9cA3uV+PBnue8OQKN5ZvggHGlJG8/JEytEKvg1gc1Q5UAtREFmc3+QpbQ8NrJ0WcI66KjhhpGKzvxpuj5LcvMrub8TbCLMxM+vpwcIwRA2l5kLsz2YCqc93RzWBj4CjOq93PSrPdlVQ7VOD+a2dq4rOZM+VyyaLrp5PRo7qcSH66H5YC5tJZ0zkHbyaqJTk9PCqFkZAUNPzZ19UR5QguBaiRhXTRgBBKx9KlLeah3p3C5XTlhRAiDFPv5hcYL9JJS5HAA2HqvyGxXLZGqSZAPJ2+O2zZOHcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bPc8yOAqlxwjSn6l3m7I1LkU+4zDVomzRLftPEOr6o=;
 b=eP7YYuhY4J6aLwL0bnY37lTMC14x9po2uGdT6k360euSRsOOv47zKdh/UbsiFoODOw0hrOEwzWhoxM9/zO3JpH5Ro/tnxuYSNWpZqPSd03kskSS8eSh8hQ+/BrgGX4DzW4x7xtOxCahqH2cPuUF+OzFlxLolSmuR1va1s7qkXN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 BN6PR12MB1172.namprd12.prod.outlook.com (2603:10b6:404:1f::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.12; Mon, 13 Jun 2022 14:39:02 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::14b:372d:338c:a594]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::14b:372d:338c:a594%7]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 14:39:02 +0000
Message-ID: <b6d64153-9dc4-372f-8c2b-a844199d3cb6@amd.com>
Date: Mon, 13 Jun 2022 21:38:52 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5/7] iommu: Add domain_type_supported() callback in
 iommu_ops
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org
References: <20220613012502.109918-1-suravee.suthikulpanit@amd.com>
 <20220613012502.109918-6-suravee.suthikulpanit@amd.com>
 <371cacea-368b-d722-8360-13c229b3112b@arm.com>
In-Reply-To: <371cacea-368b-d722-8360-13c229b3112b@arm.com>
X-ClientProxiedBy: SG2PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:4:7c::31) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b22019d-c2ac-423f-5afb-08da4d4a758d
X-MS-TrafficTypeDiagnostic: BN6PR12MB1172:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB117267C66C9B4FDF66206927F3AB9@BN6PR12MB1172.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZESWB6z5bw6tBYl+nXUPhbmI5OQV/0Ii7JoB12UeOMcqHfyKChCE+szSKLATQqjhS6Qmx1gi77tJat0Jh1u7u3E5tB+zl9DBQCJrmuqRG+0prjnvOvNXXKDND7cBOGwcOHr/wSd+/hhjrGOY9vLCYp7K8lLvn3r4JpQ59DtCrlgUE6AS6yb15o9LvP+Z/mUUmJoGA7/mgfrrfxd1KI9OKGWW4MvJE0tZqO2McJDO+prAnZoVBHJ9eMpgalS2TlImaxKX4sVtaAiagOffrP7pgkNl0rdu6XXR3pVl08KZnk3rUtujvLcTvAHrq+Quprvx+Sk/jQ2zTqKTMwEyYxCiKbaBnJ9nA3N1bwmbdh7kzRZTwPjNaY9ul8BpSv+CsJ1/FlgJ6cykJrFdS1PFeGXPbfrwoj4++N4X5Sl+F/1CNjmi6dN9hGsbHOSRCFXZ2VWEsyGf9fEGhNqZeNBWem9wI/CtIHrO3OmBSIt/9/Nt1xJtEpj1zQ7+QJ9XSvdbe0XylRxQsRtLluLH8yJxYp8UWbSf2e381QBiSNbDqmNx0eew+E8booIAQ1+ywihJJTGHg2PjIjAQwnSgDAT5Dy5DJB0H429g4Qk6/iNeG+RnloxU8OtKIrf6bJwIt7ET9CgQyTAYzXG3IVVoJhKGpsBVi8qIjF2QYpE1NTatMZl0xkeHtJjuwGCtP/sMPWbjdSrjJveixZw4ws/tgiKKTO9Fb/CDeATo9VajRO+XR1b0YdU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(31696002)(66476007)(66556008)(8676002)(4326008)(66946007)(8936002)(5660300002)(86362001)(2616005)(508600001)(6486002)(36756003)(53546011)(2906002)(6506007)(6666004)(26005)(83380400001)(186003)(6512007)(31686004)(38100700002)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elUvQzN5WVRyUzQvY1lmZXk3NHJSQ0dYZnJUeTRsQmtzS3VOclhnb1lQL1Jh?=
 =?utf-8?B?VE52WjByYmNHNVFJYlQyVnJPWjVNcEhXcTZ2RGI4eUlwRUV3T0FhQ2J4L2VV?=
 =?utf-8?B?T1FueFFYclR5WUZUMHhhV051elpraUJBYWRZaE81enhsU2huVXp4QUtZU3Vw?=
 =?utf-8?B?NkhpMTNQMjVCcWJiVTZWbS8rcEcwRytyYTZtdXhmZlpTN3p3QVVNQURQa20y?=
 =?utf-8?B?b2EyeWFXZmV0Vjdtd0lPS1c0QWZ0S0o3ajI2Ykc4VGZ4ZGpSV0pkWDVFZnEx?=
 =?utf-8?B?VUlzUnB3ODhyaTlCY0tFSDlUM1ltSTRzZnNLdVgzNmFsd2Q2QzhhNUo0b2Yr?=
 =?utf-8?B?Sms0NllIVzYxeE80UDU2NEZBWUtydXVMSlUrOTJsU2Rra3F1MmpWbFFyb2Fn?=
 =?utf-8?B?aW53Y0FtMlpobVkwckl1b1JnMWJ5LzlpOWtvVklZaXBvWVRnYUVDc2FoM1Ny?=
 =?utf-8?B?RU9wYzk3N090VmVuVVN6UDRPZ3Jqb2pBeThJU1FxREhPZGRGRUkrVkpIQzZ2?=
 =?utf-8?B?K0hJeDdjNkVXeTN5TDU5YU45YjhJL2IyOUlMV3NkUExYcE1uMjIwOE5McWFt?=
 =?utf-8?B?TGgxT2o4VnJuV0NtVDZ6Qi9NUnY4dXNMQ1RZeEFwUEExNjZZQnRLZGtPWS95?=
 =?utf-8?B?NWhZM2JBaE9rR1FLNEtjanpsd0JrMXlnVVBtdUNRSXFUc1hhblNYWUZzTmp6?=
 =?utf-8?B?TXgzaGJkUldibkc0S3FtbDRzZU10VklSQm9Tc3lzVW8rOGZuaXNSbStMZ1BI?=
 =?utf-8?B?aXRiWVhrbXR1NTNMMnJENk5uTExDUkhiVzdBc1dLdGkySGRURnBpbEcwdTJs?=
 =?utf-8?B?RWpZeXpkeDZZdjZ1YTlmUVVrSjZ6R3hRZHFyNDUwRTNNSENWTzhmNWJZM0dj?=
 =?utf-8?B?NFl4OWJ5UXhhVHhOQ0dYY3RNRVBlRTEzdDF0YmpreisvQytNRjB6c2poTUJF?=
 =?utf-8?B?Y3BkTmF1bnFsc01iZ3F4SDV4ZTJqb1IvMHdnQVM2L0wxekFWM2wyTTNpOGl6?=
 =?utf-8?B?dUVHc1N3amE4dVBGd1AyamF0Y2k5d0dPalZRQnpKbEs1TVRNT3E3d3I2ekdX?=
 =?utf-8?B?d0ZjazhXUkcwNTNzU2s4elpsaGVYN0Q2bE1MMjlGL2trMzJRM00wcFpmZTZ5?=
 =?utf-8?B?MW81RDdQbG5xZVlVcnZKVGZhVUFWSmEwWmFtT2EwNWZmV0xqS2puazVPMk9E?=
 =?utf-8?B?NlBMM3dCbXphaS92bzVjVWNuenZHWHRZNzd5UUdtWTdhOHU1MjVGKzMwTHgx?=
 =?utf-8?B?KzZwWVVvaDdDSUxhbkRTWjE2SERHZjNKR2JJSTEzWEl5bnRLUDNoUjE3aHlC?=
 =?utf-8?B?Vk9JSHo1elRwZTBHYlRCYnFGWXdFeWZMYWZ5Vzk3cGlsaVdzYWhjN2JINzA3?=
 =?utf-8?B?dENIUDJHakhtVFdGRFlUOE9OdXVzR2JsOXZtdHZRVEhVdnl5Y0hOdkJjNUIr?=
 =?utf-8?B?U2pkZ2d0bEJWckFPQ2RwcURZeVJxZmRYNWZLYW1mSEZOM094V1NaNUw0Z09k?=
 =?utf-8?B?Nys5Q0QvNUN4eVY4TjdQYi9ucmQ1cHdJM1o1TzBvOFlGMDdlY2RCdHFDOGZJ?=
 =?utf-8?B?QzRaK0lnRk42QXNlSEw4akFUV2thTmRHQUVMMUdXNXYrcmFDalhYcWhQb1Va?=
 =?utf-8?B?YUVDMkhPazFjMCtTcGJsUHR6R2krNjkzMjFyNTZ1RHlHTmZDa1ZMSkxYNVpl?=
 =?utf-8?B?V2pMTzA0VjVnSnpDMk5MYWhUSFM0SytLRXdXN1lHUVYzYXM2RlFCTzJzZUdM?=
 =?utf-8?B?TENibUhBZTRVckdiUzcvK0hDRi9BTEpnZXR2U1JuMEt5YlJIdHJ2b1FoRlN4?=
 =?utf-8?B?am9zWU9wdmt2SUxLUGxoeGpDeHNoNEE4MUhmdTF3OG5BS0NJVjVLMDN2Smw3?=
 =?utf-8?B?SFBDNm1IT1pLRk9mbERvZGN1TFEva3dwMU4yazQ0U0VlU3dSQThuTGlrMlhN?=
 =?utf-8?B?ZGpiWm1DQWhwOWtpOEJidFV5am5RVlJrYkQxaEFVNzZFa29SMGw1V1Y2RmlV?=
 =?utf-8?B?eVR0NkYwVlRSVkdoZnhrdzlzamtEejZkSmt4UXZYYVZaVEo1NHZrVHpBYlJQ?=
 =?utf-8?B?d0k1eXBSZzF3T2tYb0czQldldW5NMUdzK3FPTlpBMzNZWWJzeHZvTklTZmYw?=
 =?utf-8?B?ODZGTm5yOGdBUldOMlFYMWxVczdDQ2t2QVYzWWoxdlVWZWxOR3RxdzhCZnp6?=
 =?utf-8?B?SXp5NXBDMVA2MEZkUXVreWF3V09JSXJlZFI2M2hvckE3TFNjdEZ4UEJWM3VQ?=
 =?utf-8?B?NEh4aDRUS2dOOHo4MlJpVHp3c1QvemtPYXJORUx1bVpBaXBhSEw1SlBxazRw?=
 =?utf-8?B?TjUxQW1paC9DK0s5VEo4d2xXV1FXWkQwaU9hOHhQY0JHcGVDbHkyUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b22019d-c2ac-423f-5afb-08da4d4a758d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 14:39:02.4743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hUkX+OY7lpIlR7dEn9dKUo4jZoJjeXISpPA4txN5iObk2XNztz91S6E8gnjzhHGeE1A2OBMH0az3DH0311Alw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1172
Cc: ashish.kalra@amd.com, vasant.hegde@amd.com
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
From: "Suthikulpanit, Suravee via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Um9iaW4sCgpPbiA2LzEzLzIwMjIgNDozMSBQTSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uwqAy
MDIyLTA2LTEzwqAwMjoyNSzCoFN1cmF2ZWXCoFN1dGhpa3VscGFuaXTCoHdyb3RlOgo+PiBXaGVu
wqB1c2VywqByZXF1ZXN0c8KgdG/CoGNoYW5nZcKgSU9NTVXCoGRvbWFpbsKgdG/CoGHCoG5ld8Kg
dHlwZSzCoElPTU1VwqBnZW5lcmljCj4+IGxheWVywqBjaGVja3PCoHRoZcKgcmVxdWVzdGVkwqB0
eXBlwqBhZ2FpbnN0wqB0aGXCoGRlZmF1bHTCoGRvbWFpbsKgdHlwZcKgcmV0dXJuZWQKPj4gYnnC
oHZlbmRvci1zcGVjaWZpY8KgSU9NTVXCoGRyaXZlci4KPj4KPj4gSG93ZXZlcizCoHRoZXJlwqBp
c8Kgb25secKgb25lwqBkZWZhdWx0wqBkb21haW7CoHR5cGUswqBhbmTCoGN1cnJlbnTCoG1lY2hh
bmlzbQo+PiBkb2VzwqBub3TCoGFsbG93wqBpZsKgdGhlwqByZXF1ZXN0ZWTCoHR5cGXCoGRvZXPC
oG5vdMKgbWF0Y2jCoHRoZcKgZGVmYXVsdMKgdHlwZS4KPiAKPiBJIGRvbid0IHJlYWxseSBmb2xs
b3cgdGhlIHJlYXNvbmluZyBoZXJlLiBJZiBhIGRyaXZlcidzIGRlZl9kb21haW5fdHlwZSBjYWxs
YmFjayByZXR1cm5zIGEgc3BlY2lmaWMgdHlwZSwgaXQncyBzYXlpbmcgdGhhdCB0aGUgZGV2aWNl
ICpoYXMqIHRvIGhhdmUgdGhhdCBzcGVjaWZpYyBkb21haW4gdHlwZSBmb3IgZHJpdmVyL3BsYXRm
b3JtLXNwZWNpZmljIHJlYXNvbnMuIAoKQWdyZWUsIGFuZCBJIHVuZGVyc3RhbmQgdGhpcyBwYXJ0
LgoKPiBJZiB0aGF0J3PCoG5vdMKgdGhlwqBjYXNlLMKgdGhlbsKgdGhlwqBkcml2ZXLCoHNob3Vs
ZG4ndMKgc2F5wqBzb8KgaW7CoHRoZcKgZmlyc3TCoHBsYWNlLgoKQ29uc2lkZXJpbmcgdGhlIGNh
c2U6CjEuIEJvb3Qgdy8gZGVmYXVsdCBkb21haW4gPSBJT01NVV9ET01BSU5fRE1BX0ZRCjIuIFVz
ZXIgd2FudHMgdG8gY2hhbmdlIHRvIElPTU1VX0RPTUFJTl9JREVOVElUWSwgd2hpY2ggaXMgbm90
IHN1cHBvcnRlZCBieSBJT01NVSBkcml2ZXIuIEluIHRoaXMgY2FzZSwgSU9NTVUgZHJpdmVyIGNh
biByZXR1cm4gSU9NTVVfRE9NQUlOX0RNQV9GUSBhbmQgcHJldmVudCB0aGUgbW9kZSBjaGFuZ2Uu
CjMuIEhvd2V2ZXIsIGlmIHVzZXIgd2FudCB0byBjaGFuZ2UgdG8gSU9NTVVfRE9NQUlOX0RNQS4g
VGhlIGRyaXZlciBjYW4gc3VwcG9ydCB0aGlzLiBIb3dldmVyLCBzaW5jZSB0aGUgZGVmX2RvbWFp
bl90eXBlKCkgcmV0dXJucyBJT01NVV9ET01BSU5fRE1BX0ZRLCBpdCBlbmRzIHVwIHByZXZlbnQg
dGhlIG1vZGUgY2hhbmdlLgoKSUlVQywgd2Ugc2hvdWxkIHN1cHBvcnQgc3RlcCAzIGFib3ZlLiBC
YXNpY2FsbHksIHdpdGggdGhlIG5ld2x5IHByb3Bvc2VkIGludGVyZmFjZSwgaXQgYWxsb3dzIHVz
IHRvIGNoZWNrIHdpdGggSU9NTVUgZHJpdmVyIGlmIGl0IGNhbiBzdXBwb3J0IGNlcnRhaW4gZG9t
YWluIHR5cGVzIGJlZm9yZSB0cnlpbmcKdG8gYWxsb2NhdGUgdGhlIGRvbWFpbi4KCj4gCj4+IElu
dHJvZHVjaW5nwqBjaGVja19kb21haW5fdHlwZV9zdXBwb3J0ZWQoKcKgY2FsbGJhY2vCoGluwqBp
b21tdV9vcHMsCj4+IHdoaWNowqBhbGxvd3PCoElPTU1VwqBnZW5lcmljwqBsYXllcsKgdG/CoGNo
ZWNrwqB3aXRowqB2ZW5kb3Itc3BlY2lmaWPCoElPTU1VwqBkcml2ZXIKPj4gd2hldGhlcsKgdGhl
wqByZXF1ZXN0ZWTCoHR5cGXCoGlzwqBzdXBwb3J0ZWQuwqBUaGlzwqBhbGxvd3PCoHVzZXLCoHRv
wqByZXF1ZXN0Cj4+IHR5cGVzwqBvdGhlcsKgdGhhbsKgdGhlwqBkZWZhdWx0wqB0eXBlLgo+IAo+
IE5vdGUgYWxzbyB0aGF0IHlvdSdyZSBvbmx5IGFkZGluZyB0aGlzIGluIHRoZSBzeXNmcyBwYXRo
IC0gd2hhdCBhYm91dCB0aGXCoCJpb21tdS5wYXNzdGhyb3VnaD0iwqBwYXJhbWV0ZXLCoG9ywqBD
T05GSUdfSU9NTVVfREVGQVVMVF9QQVNTVEhST1VHSD8KCkZvciBTTlAgY2FzZSwgd2UgY2Fubm90
IGVuYWJsZSBTTlAgaWYgaW9tbXU9b2ZmIG9yIGlvbW11PXB0IG9yIGlvbW11LnBhc3N0aHJvdWdo
PTEgb3IgQ09ORklHX0lPTU1VX0RFRkFVTFRfUEFTU1RIUk9VR0g9eS4KU28sIHdoZW4gYW5vdGhl
ciBkcml2ZXIgdHJpZXMgdG8gZW5hYmxlIFNOUCwgdGhlIElPTU1VIGRyaXZlciBwcmV2ZW50cyBp
dCAoc2VlIGlvbW11X3Nldl9zbnBfc3VwcG9ydGVkKCkgaW4gcGF0Y2ggMykuCgpJbnN0ZWFkLCBp
ZiB3ZSBib290IHdpdGggaW9tbXUucGFzc2h0aHJvdWdoPTAsIHdoZW4gYW5vdGhlciBkcml2ZXIg
dHJpZXMgdG8gZW5hYmxlIFNOUCwgdGhlIElPTU1VIGRyaXZlciBhbGxvd3MgdGhpcyBhbmQgc3dp
dGNoIHRvIFNOUCBlbmFibGUgbW9kZS4KU3Vic2VxdWVudGx5LCBpZiB1c2VyIHRyaWVzIHRvIHN3
aXRjaCBhIGRvbWFpbiAodmlhIHN5c2ZzKSB0byBJT01NVV9ET01BSU5fSURFTlRJVFksIHRoZSBJ
T01NVSBuZWVkcyB0byBwcmV2ZW50IHRoaXMgYmVjYXVzZSBpdCBoYXMgYWxyZWFkeSBzd2l0Y2gK
dG8gU05QLWVuYWJsZWQgbW9kZS4KCj4gQUZBSUNTIHRoZXJlIHNob3VsZG4ndCBuZWVkIHRvIGJl
IGFueSBjb3JlLWxldmVsIGNoYW5nZXMgdG8gc3VwcG9ydCB0aGlzLiBXZSBhbHJlYWR5IGhhdmUg
ZHJpdmVycyB3aGljaCBkb24ndCBzdXBwb3J0IHBhc3N0aHJvdWdoIGF0IGFsbCwgc28gY29uZGl0
aW9uYWxseSBub3Qgc3VwcG9ydGluZyBpdCBzaG91bGQgYmUgbm8gYmlnIGRlYWwuIFdoYXQgc2hv
dWxkIGhhcHBlbiBjdXJyZW50bHkgaXMgdGhhdCBkZWZfZG9tYWluX3R5cGUgcmV0dXJucyAwIGZv
ciAiZG9uJ3QgY2FyZSIsIHRoZW4gZG9tYWluX2FsbG9jIHJlamVjdHMgSU9NTVVfRE9NQUlOX0lE
RU5USVRZIGFuZCBhbmQgcmV0dXJucyBOVUxMLCBzbyBpb21tdV9ncm91cF9hbGxvY19kZWZhdWx0
X2RvbWFpbigpwqBmYWxsc8KgYmFja8KgdG/CoElPTU1VX0RPTUFJTl9ETUEuCgpUZWNobmljYWxs
eSwgd2UgY2FuIGRvIGl0IHRoZSB3YXkgeW91IHN1Z2dlc3QuIEJ1dCBpc24ndCB0aGlzIGNvbmZ1
c2luZz8gQXQgZmlyc3QsIGRlZl9kb21haW5fdHlwZSgpIHJldHVybnMgMCBmb3IgImRvbid0IGNh
cmUiLApidXQgdGhlbiBpdCByZWplY3RzIHRoZSByZXF1ZXN0IHRvIGNoYW5nZSB0byBJT01NVV9E
T01BSU5fSURFTlRJVFkgd2hlbiB0cnlpbmcgdG8gY2FsbCBkb21haW5fYWxsb2MoKS4KClBsZWFz
ZSBsZXQgbWUga25vdyBpZiBJIGFtIG1pc3Npbmcgc29tZXRoaW5nLgoKQmVzdCBSZWdhcmRzLApT
dXJhdmVlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlv
bW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
