Return-Path: <SRS0=gU7u=JK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EB0C433B4
	for <iommu@archiver.kernel.org>; Tue, 13 Apr 2021 13:52:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C29661249
	for <iommu@archiver.kernel.org>; Tue, 13 Apr 2021 13:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C29661249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3ECE4842CC;
	Tue, 13 Apr 2021 13:52:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id np7ZXxOKhv17; Tue, 13 Apr 2021 13:52:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id F182584392;
	Tue, 13 Apr 2021 13:52:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBF4BC000B;
	Tue, 13 Apr 2021 13:52:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DEB6C000A
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 13:52:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6953684392
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 13:52:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 72yxi32OwlnF for <iommu@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 13:52:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7E486842CC
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 13:52:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCib8TeefJ+2wXoeX8XmYDh2tK2pTahraEL2o+5rLPQfp4XxJNEHD9H4QsVVCJutfij9D9Ajb+XbPCMg/TFHotgziGKpgUMB6yKOBSW/J3wU8UHnuOaIsn3rG8xufBx/McZzsj3qzGw18IbkBThZxH5k+qvWN+Ifhd1uEvJKZ+x4ZB8Z0wc2Kjl4fNSdAANcIeR9k9Tq7CxxCTFmMK0XxO+iMzHac4JdAPq4Lb9Gtna69pdilI4WgJ1DB+nPzDkF1OO69nfR4UF2YeCJMWA1Fm5vHhcP8dg07D1WIhmSd/ggJyM+sG71icmcM6zu2fxrFHJiU4F7cM+RTe5NQdcw9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3oFWaVMnfEkZo/UfG6m6HYDXy/H42ps8KgYRGF1YTs=;
 b=c/HNfzCXqcXYBAYcnMAayOqpRfeFo2W+hLgC85Xn2h0wQfKvlsjztOCr+2xCxXCN45Nonf0OFFbR/0j/J3IbJjQSrL6QInzIPGrqqIcvsjx7Lgx7NlFbm3FOihBadrlWcGkFnUQ4bda1knKW5pQIULVJaoERSfdcddtJsnJoDDkgq4eCTHXJ/Pv2TXZcZHHOHAPzMXi9rODon9zKIUYS2VA14fCWj00RC5oY5w/TwxaF0SeTZrhEtdkXYuqtiATIwgkJhJIEk+3rEMGFnmYdY6+yH0vC2zPqttncJeD1Ws9vmJL71B0MSvZhCAaAABIfOehvMVdPhKaJ8dUg4FJ7YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3oFWaVMnfEkZo/UfG6m6HYDXy/H42ps8KgYRGF1YTs=;
 b=A4c0kWyRN0JqP+Xio7tcha3Brb434RUt9KVFEEBQoNz4gf0DDC4/una2/vvEmuXvi2+umUe908E5CyKMExSvcJUebCliRLthphKcoa/tWm0OTl+zsgdbvOarW5Qe71JKBwP8jEW/yzfdnmtBfyKtl9Wt5CgnlD/EOPCJ2BW9Q8A=
Authentication-Results: bugs.launchpad.net; dkim=none (message not signed)
 header.d=none; bugs.launchpad.net; dmarc=none action=none header.from=amd.com; 
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BY5PR12MB4001.namprd12.prod.outlook.com (2603:10b6:a03:1ac::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Tue, 13 Apr
 2021 13:52:08 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::cc86:d78a:bb1d:5109]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::cc86:d78a:bb1d:5109%5]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 13:52:08 +0000
Subject: Re: [PATCH 2/2] iommu/amd: Remove performance counter
 pre-initialization test
To: David Coe <david.coe@live.co.uk>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20210409085848.3908-1-suravee.suthikulpanit@amd.com>
 <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
 <VI1PR09MB26380EED406F2F08ACB6B5BBC7729@VI1PR09MB2638.eurprd09.prod.outlook.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Message-ID: <add9d575-191e-d7a6-e3e1-dfc7ea7f35c8@amd.com>
Date: Tue, 13 Apr 2021 20:51:56 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <VI1PR09MB26380EED406F2F08ACB6B5BBC7729@VI1PR09MB2638.eurprd09.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [165.204.80.7]
X-ClientProxiedBy: KL1PR01CA0062.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::26) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.73.101] (165.204.80.7) by
 KL1PR01CA0062.apcprd01.prod.exchangelabs.com (2603:1096:820:5::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Tue, 13 Apr 2021 13:52:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 398bc6b8-2a37-4b9d-f513-08d8fe83547f
X-MS-TrafficTypeDiagnostic: BY5PR12MB4001:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB400104CE8B51C828F58E9413F34F9@BY5PR12MB4001.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aOdQpA4Iedbj+yiJCsYmTG0Jls9M+1qH4iJqUgbF3O0h8cP4CSvJrhLYW23Qw20qhLD6PYPJ07BCkL9Pc7KD+ngB6J2meX1ur2hu1T2SZPp2VpGIi2qG29P8PE7iJSEwuiGwZ41HB8E8OLUI8ma8PrWxqu/AKNTSgMDWX/PrMG+cgWAODOUkbK/2EgwyQMiZ+nF3Z1pZ6mJuJQACtyi9xrLeon6Lq2ukYAeJqypZ/NRE2jxnBavtccoynia/EU8x9yVcm4KG/nWZjbgB2C6J2l+UuRlbKgkab0P1q1UIJjr3zUZ0TfBX7Zlpnr+EFlHi/yw8IwqD4q6G6dMpbXTQ1obgv79xcG1A/c4bLRDWIdUL2wfsRrZRCNwN/iv95vyRMwNanRznQHzh3JKcJRkiOBFX7Ycjjbgihpiqiphl3xov4Ry8Lqn3ZInWclpSAoMuvcvHhqHPob8MYAwwfIot3TcheqLGE3xdcHKkJ7iTGUWXrC0zU8YgfcGhntkeQugtZLv9fIhtHy/+VP+ryJow+hY1y5bOdJYmRUbfKhVcfHs24MiuDxWyx0K1SVaQhLKJ5qbX80n9uq4qk+KSM4OVfIGQ2sPHL9zZ18qKMrU3uI+md5lldmD+HLFiURLeM+v/EAWG3+Hj9PP9OO6ywXRK18xS/qQ4eJ/mSU+CRpHOCz0swjG/RIxWryTwN1xaYGdjsAG24fRjcXQCUhiKDZvUbd30w09hB8oaOcgeUUt0c+0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(34580700001)(26005)(16526019)(186003)(66946007)(31686004)(2906002)(54906003)(956004)(52116002)(66476007)(53546011)(478600001)(6486002)(36756003)(16576012)(4326008)(38100700002)(38350700002)(7416002)(31696002)(8676002)(83380400001)(86362001)(6666004)(316002)(66556008)(8936002)(2616005)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZzIyTDlOQ25MN1NlSEtYaTJpTjcxOG56Zk50cnl3dysyOVA1TElXOVkyMS9P?=
 =?utf-8?B?UDhCQWVpcGk4b2x2bGFWVUpTMUJBNVRkcmhpalNXNTBRSG5IL3BWQ24xcTdr?=
 =?utf-8?B?Zno3WlQvOXd2ZlNBTXRSQ2xuaDdQdHFkMng1MGl4Mjk0TCtXTnBwTVc3bEgx?=
 =?utf-8?B?dXFxeTBVTG41WDVqQW4xU2FrMzRLN2VIYk9LK2VHb3VJVXc3cUw4WkQrVUlL?=
 =?utf-8?B?YmxTVE9acXMzQ0xNWGg2dS9PdDFpSTdXSWNlQm9lRGs1SUhYbWdrVEU2VVNU?=
 =?utf-8?B?Y3dsa0gzWUdMcWdiQm9YYTlzSWFlajNQK29TdGhLUDQvcHZMSkd1dGJsQnZY?=
 =?utf-8?B?YkdDV0NueW5YSHJ6dzNTUTAvVEhWcVRmRm9BYkZHUDZadVJWY1RHMllYcjdT?=
 =?utf-8?B?ekIxTUJmZGNJSmFGb2o2QWJRN2t3T3UwNTdEWXl5SG1WSVhRdEdnVkw0RktL?=
 =?utf-8?B?T0I2SjBCMnR3MTR0bkdKb2FQLytEaG4rbzFjL2dpSVNrZWtkOXNwOUhvdzQw?=
 =?utf-8?B?d0FSWVZsSXR6U0UxU1lPOWZycHZsQXY0aFZPVlhxRHo2NExJTGV6TzNFUXl5?=
 =?utf-8?B?Kzhrc05maVZVdUR1QURkVTl2TFJwSDJRWDZIT0ROemN6Yk5NV2ZuODMva215?=
 =?utf-8?B?aENlNHFqR2pIckxOU201V2lPZ2pvZ1BvOXdXak94em1CQUV6dmdFUDJxVXR5?=
 =?utf-8?B?YkRXV244T2JOUVRsUG9QbVg5VVorSXJNWVNaRVdDRVZKNy9YakptVUdVbzRI?=
 =?utf-8?B?THVPMnJ2MTVXc2RldGlHc0R5aTNDWEkrVzRCdEY5TWZkajhBL05wMXE1bC9W?=
 =?utf-8?B?aW5zWlVCWGgrdzNTa1NsUWJKR2ljMTMwc2VqcjJQZkpicE1RNkpaRTNIcDZh?=
 =?utf-8?B?bVcxdHBGR2F5UlFKbnBFU0VvMXA4eVViZUlxYm1BY0ZQbXoyM25WUStJekpK?=
 =?utf-8?B?dHdpQlhaWmNjQk9kZWNwbDduS0toeGJCREt2SmpsbFFsNHRPTHlTUUo0dU0y?=
 =?utf-8?B?U3lkNDIza0tIWTBSZVE2U0swRjQ1N0luL1crZjNTZWQxZDhyYnAva3hoRGlV?=
 =?utf-8?B?NzRwanlIa1N5SXF3OFJ5eXR4MnAzM2xrd2hnY0JDODl6T3FqUzdQQ1hmK0xG?=
 =?utf-8?B?b0xSb01XM0lNeEppUTN2ZzFEMzZKNGZnOUpSYVNIcUYyTWJLbm4yU2RrZit2?=
 =?utf-8?B?UUJIM29ZdE5MMXZ1YTdOOXFQdFlLV0hOMEV1NlpiM0toS1k3ZkhPVkRwaUx5?=
 =?utf-8?B?OUVyNTdrSzhVVjZlVHplcmRoUlRoaHdOUC9FWEo5OFRQd2dDOUJ6V0xzRkNz?=
 =?utf-8?B?Y1VUamRhMTBUQzU1K2FaK2YycUplQzNsR1ppYWpHMWVpQ09tcis2NEs3clZX?=
 =?utf-8?B?L0hTbDVqV3lXeHN6ZERPNlQyTkFpVXE0TWFJRU44aUxBOTZGdWhyYm5hK3VW?=
 =?utf-8?B?UWp5NmpiZXUvcUh0VS9VaFc2b3UrRnVYRENYSysrN3JFY3ozb0czOWMrQi9R?=
 =?utf-8?B?MGtjUkdiS29TMXFnL1dEaVZjRWxLeFN6eFF4RmxyVnNnajE1ekl1U1RXUTR1?=
 =?utf-8?B?VDVYeHpqZm1JUG1hWGZHT1h5Tis4bUpXTFlRclNpRjFZNHFDRlFRQXFxQncw?=
 =?utf-8?B?U2JhdFZoUE5XbU9aTWFGV1BxL05WNEdXR241ZW9XMUgrSmM1VEc1dlhIRElO?=
 =?utf-8?B?akNtVU9VdGlocnI4NFB5Zm5aSlpIeEJ4V1lJVVA4NnhwdFpjeFRnYmlpallB?=
 =?utf-8?Q?JEhyY+4f+7YQDPuwxObkcTCm4Myek88AulLIBAU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 398bc6b8-2a37-4b9d-f513-08d8fe83547f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 13:52:08.8226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVSJ05nMzkQrbhgIinW7JxjJE0ZbVLTmyDNaIZnqzgK28GupHXrdqIqKkaoqghSqiKpvCaXeGWCyE3ieognmbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4001
Cc: pmenzel@molgen.mpg.de, Alexander Monakov <amonakov@ispras.ru>,
 Alex Hung <1917203@bugs.launchpad.net>, Jon.Grimm@amd.com,
 Shuah Khan <skhan@linuxfoundation.org>, Tj <ml.linux@elloe.vision>,
 will@kernel.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CgpPbiA0LzEwLzIwMjEgNTowMyBQTSwgRGF2aWQgQ29lIHdyb3RlOgo+IFJlc3VsdHMgZm9yIEFN
RCBSeXplbiA0NzAwVSBydW5uaW5nIFVidW50dSAyMS4wNM6yIGtlcm5lbCA1LjExLjAtMTMKPiAK
PiAkIHN1ZG8gZG1lc2cgfCBncmVwIElPTU1VCj4gW8KgwqDCoCAwLjQ5MDM1Ml0gcGNpIDAwMDA6
MDA6MDAuMjogQU1ELVZpOiBJT01NVSBwZXJmb3JtYW5jZSBjb3VudGVycyBzdXBwb3J0ZWQKPiBb
wqDCoMKgIDAuNDkxOTg1XSBwY2kgMDAwMDowMDowMC4yOiBBTUQtVmk6IEZvdW5kIElPTU1VIGNh
cCAweDQwCj4gW8KgwqDCoCAwLjQ5MzczMl0gcGVyZi9hbWRfaW9tbXU6IERldGVjdGVkIEFNRCBJ
T01NVSAjMCAoMiBiYW5rcywgNCBjb3VudGVycy9iYW5rKS4KPiBbwqDCoMKgIDAuNzkzMjU5XSBB
TUQtVmk6IEFNRCBJT01NVXYyIGRyaXZlciBieSBKb2VyZyBSb2VkZWwgPGpyb2VkZWxAc3VzZS5k
ZT4KPiAKPiAuLi4uCj4gCj4gJCBzdWRvIHBlcmYgc3RhdCAtZSAnYW1kX2lvbW11XzAvY21kX3By
b2Nlc3NlZC8sIGFtZF9pb21tdV8wL2NtZF9wcm9jZXNzZWRfaW52LywgYW1kX2lvbW11XzAvaWdu
X3JkX3dyX21taW9fMWZmOGgvLCBhbWRfaW9tbXVfMC9pbnRfZHRlX2hpdC8sIGFtZF9pb21tdV8w
L2ludF9kdGVfbWlzLywgYW1kX2lvbW11XzAvbWVtX2R0ZV9oaXQvLCBhbWRfaW9tbXVfMC9tZW1f
ZHRlX21pcy8sIGFtZF9pb21tdV8wL21lbV9pb21tdV90bGJfcGRlX2hpdC8sIGFtZF9pb21tdV8w
L21lbV9pb21tdV90bGJfcGRlX21pcy8sIGFtZF9pb21tdV8wL21lbV9pb21tdV90bGJfcHRlX2hp
dC8sIGFtZF9pb21tdV8wL21lbV9pb21tdV90bGJfcHRlX21pcy8sIGFtZF9pb21tdV8wL21lbV9w
YXNzX2V4Y2wvLCBhbWRfaW9tbXVfMC9tZW1fcGFzc19wcmV0cmFucy8sIGFtZF9pb21tdV8wL21l
bV9wYXNzX3VudHJhbnMvLCBhbWRfaW9tbXVfMC9tZW1fdGFyZ2V0X2Fib3J0LywgCj4gYW1kX2lv
bW11XzAvbWVtX3RyYW5zX3RvdGFsLywgYW1kX2lvbW11XzAvcGFnZV90YmxfcmVhZF9nc3QvLCBh
bWRfaW9tbXVfMC9wYWdlX3RibF9yZWFkX25zdC8sIGFtZF9pb21tdV8wL3BhZ2VfdGJsX3JlYWRf
dG90LywgYW1kX2lvbW11XzAvc21pX2Jsay8sIGFtZF9pb21tdV8wL3NtaV9yZWN2LywgYW1kX2lv
bW11XzAvdGxiX2ludi8sIGFtZF9pb21tdV8wL3ZhcGljX2ludF9ndWVzdC8sIGFtZF9pb21tdV8w
L3ZhcGljX2ludF9ub25fZ3Vlc3QvJyBzbGVlcCAxMAo+IAo+IFBlcmZvcm1hbmNlIGNvdW50ZXIg
c3RhdHMgZm9yICdzeXN0ZW0gd2lkZSc6Cj4gCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgMTLCoMKgwqDCoMKgIGFtZF9pb21tdV8wL2NtZF9wcm9jZXNzZWQvwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICgzMy4yOCUpCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA2wqDC
oMKgwqDCoMKgIGFtZF9pb21tdV8wL2NtZF9wcm9jZXNzZWRfaW52L8KgwqDCoMKgwqDCoMKgICgz
My4zMiUpCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAwwqDCoMKgwqDCoMKgIGFt
ZF9pb21tdV8wL2lnbl9yZF93cl9tbWlvXzFmZjhoL8KgwqDCoMKgICgzMy4zNiUpCj4gIMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIDI5MMKgwqDCoMKgwqDCoCBhbWRfaW9tbXVfMC9pbnRfZHRl
X2hpdC/CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoMzMuNDAlKQo+ICDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIDIwwqDCoMKgwqDCoMKgIGFtZF9pb21tdV8wL2ludF9kdGVfbWlzL8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgzMy40NiUpCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIDM5McKgwqDCoMKgwqDCoCBhbWRfaW9tbXVfMC9tZW1fZHRlX2hpdC/CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAoMzMuNDklKQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDMsNzIw
wqDCoMKgwqDCoMKgIGFtZF9pb21tdV8wL21lbV9kdGVfbWlzL8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICgzMy40OSUpCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgNDTCoMKgwqDC
oMKgwqAgYW1kX2lvbW11XzAvbWVtX2lvbW11X3RsYl9wZGVfaGl0L8KgwqDCoCAoMzMuNDYlKQo+
ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA4MTDCoMKgwqDCoMKgwqAgYW1kX2lvbW11XzAv
bWVtX2lvbW11X3RsYl9wZGVfbWlzL8KgwqDCoCAoMzMuNDUlKQo+ICDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIDM1wqDCoMKgwqDCoMKgIGFtZF9pb21tdV8wL21lbV9pb21tdV90bGJfcHRl
X2hpdC/CoMKgwqAgKDMzLjQxJSkKPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgNzQ2wqDC
oMKgwqDCoMKgIGFtZF9pb21tdV8wL21lbV9pb21tdV90bGJfcHRlX21pcy/CoMKgwqAgKDMzLjM3
JSkKPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDDCoMKgwqDCoMKgwqAgYW1kX2lv
bW11XzAvbWVtX3Bhc3NfZXhjbC/CoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgzMy4zMiUpCj4gIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAwwqDCoMKgwqDCoMKgIGFtZF9pb21tdV8wL21l
bV9wYXNzX3ByZXRyYW5zL8KgwqDCoMKgwqDCoMKgICgzMy4yOCUpCj4gIMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAwwqDCoMKgwqDCoMKgIGFtZF9pb21tdV8wL21lbV9wYXNzX3VudHJh
bnMvwqDCoMKgwqDCoMKgwqDCoCAoMzMuMjglKQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgMMKgwqDCoMKgwqDCoCBhbWRfaW9tbXVfMC9tZW1fdGFyZ2V0X2Fib3J0L8KgwqDCoMKg
wqDCoMKgwqAgKDMzLjI3JSkKPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgNzE1wqDCoMKg
wqDCoMKgIGFtZF9pb21tdV8wL21lbV90cmFuc190b3RhbC/CoMKgwqDCoMKgwqDCoMKgwqAgKDMz
LjI3JSkKPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDDCoMKgwqDCoMKgwqAgYW1k
X2lvbW11XzAvcGFnZV90YmxfcmVhZF9nc3QvwqDCoMKgwqDCoMKgwqAgKDMzLjI4JSkKPiAgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAzNsKgwqDCoMKgwqDCoCBhbWRfaW9tbXVfMC9wYWdl
X3RibF9yZWFkX25zdC/CoMKgwqDCoMKgwqDCoCAoMzMuMjclKQo+ICDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIDM2wqDCoMKgwqDCoMKgIGFtZF9pb21tdV8wL3BhZ2VfdGJsX3JlYWRfdG90
L8KgwqDCoMKgwqDCoMKgICgzMy4yNyUpCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAwwqDCoMKgwqDCoMKgIGFtZF9pb21tdV8wL3NtaV9ibGsvwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAoMzMuMjglKQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
MMKgwqDCoMKgwqDCoCBhbWRfaW9tbXVfMC9zbWlfcmVjdi/CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAoMzMuMjYlKQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMMKg
wqDCoMKgwqDCoCBhbWRfaW9tbXVfMC90bGJfaW52L8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgKDMzLjIzJSkKPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDDCoMKg
wqDCoMKgwqAgYW1kX2lvbW11XzAvdmFwaWNfaW50X2d1ZXN0L8KgwqDCoMKgwqDCoMKgwqDCoCAo
MzMuMjQlKQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAzNjbCoMKgwqDCoMKgwqAgYW1k
X2lvbW11XzAvdmFwaWNfaW50X25vbl9ndWVzdC/CoMKgwqDCoMKgICgzMy4yNyUpCj4gCj4gVGhl
IGltbWVkaWF0ZWx5IG9idmlvdXMgZGlmZmVyZW5jZSBpcyB0aGUgd2l0aCB0aGUgZW5vcm1vdXMg
Y291bnQgc2VlbiBvbiBtZW1fZHRlX21pcyBvbiB0aGUgb2xkZXIgUnl6ZW4gMjQwMEcuIFdpbGwg
ZG8gc29tZSBSVEZNIGJ1dCBhbnlvbmUgd2l0aCBjb21tZW50cyBhbmQgaW5zaWdodD8KPiAKPiA4
NDEsNjg5LDE1MSwyMDIsOTM5wqDCoMKgwqDCoMKgIGFtZF9pb21tdV8wL21lbV9kdGVfbWlzL8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgzMy40NCUpCj4gCj4gT3RoZXJ3aXNlLCBhbGwgc2Vl
bXMgdG8gcnVubmluZyBzbW9vdGhseSAoZXNwZWNpYWxseSBmb3IgYSBkaXN0cmlidXRpb24gc3Rp
bGwgaW4gzrIpLiBCcmF2byBhbmQgbWFueSB0aGFua3MgYWxsIQo+IApUaGF0IGRvZXNuJ3QgbG9v
ayBjb3JyZWN0LiBMZW1tZSBkbyBzb21lIG1vcmUgaW52ZXN0aWdhdGlvbiBhbHNvLgoKVGhhbmtz
LApTdXJhdmVlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
