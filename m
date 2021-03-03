Return-Path: <SRS0=nNEG=IB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B92FC433DB
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 13:26:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FF3E64E21
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 13:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF3E64E21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B8444927A;
	Wed,  3 Mar 2021 13:26:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9YX2IiP-QAzp; Wed,  3 Mar 2021 13:26:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5CB847415;
	Wed,  3 Mar 2021 13:26:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76E58C000A;
	Wed,  3 Mar 2021 13:26:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C651C0001
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 13:26:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1BE258349A
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 13:26:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gjuI-NBfPpWj for <iommu@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 13:25:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A247A8336D
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 13:25:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaPR7L4bNPcwX6kqfjf4Me9uvMDp9u8lykrH4vrWLZ9ocP51LCzRkW7sLPLZoioUmlPwkJsY3+pdOKEhNxFY4KUYZMUFm0kfnfmYAaVc+sdF0sAazyo3B90pBz1jlCLAy7keTeOzZskppIbW16F2gl0VPHv01AhTivvaRZANkJRVlxvqCs2xcGBthWqwS11+MlDm2qNeJxv2wODAPCr0xpC1kzDGyyvJcGfZZ8FZqN327tSizlPTKbimz6oKYw+/tjaXclYls4M5nKguydoWgEqLkFYlKdUhTVSad0YkM1DwTfD+xFMe1pDWC/aQ26Xv72hUN9uA3l87dON0ewNPww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZK3/vspDBJAF4TS4KM22hC2rT6G11OjFtKM9BSe5rl8=;
 b=jVnQw9d1Vm86AkGiUSEnsroFfPWNUJYcl9Zs4NhKudpMJKIyO4P30jtdtFXfxcPBwgo/4wMvrJ3rUUeEWcF7PLjU4eF8ixe/aNbxOA/Gbggbt7kc5qkvYShRlgBAhyH0UHcd9DEnpxEsIfoNAyvX/zquadi1S2vpbJVrgc2K368+ZANJc4ptpL35FBCRraUDpoZcLPGLeb2WI33KoQsuHu+T19C965/PJ8KvGoakul13VSxfQWsiesl2tuVeaxabuHgaN8wRTpMtXg41vOKmcW7brHUORVVAPFqxKlUglhfPzKXXx4WcAD4OMgsBeEWMEQyAKcwPeFNw/GvhJ8iOoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZK3/vspDBJAF4TS4KM22hC2rT6G11OjFtKM9BSe5rl8=;
 b=FJESdpVaTiO8l3thQb/qw7BhCe8cn04SeG3DWDd6+3iwRROAYcRC4OmKbbDqbpfUqJKXtkrIb5sIIEFKDXCxeDCAw6LbwMt+r90nUUI600XGVoFjM/1BMzhUaJbE6Gw9B+ZaHlORS4JPLU2LGd9SlYoFJkDzSp8BeudJLquFS6k=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BY5PR12MB4853.namprd12.prod.outlook.com (2603:10b6:a03:1da::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 13:25:56 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972%7]) with mapi id 15.20.3890.030; Wed, 3 Mar 2021
 13:25:55 +0000
Subject: Re: [PATCH] Revert "iommu/amd: Fix performance counter initialization"
To: Paul Menzel <pmenzel@molgen.mpg.de>, Joerg Roedel <joro@8bytes.org>
References: <20210303121156.76621-1-pmenzel@molgen.mpg.de>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <a803de32-eec8-a0b1-69e6-43259ba5c656@amd.com>
Date: Wed, 3 Mar 2021 20:25:45 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <20210303121156.76621-1-pmenzel@molgen.mpg.de>
Content-Language: en-US
X-Originating-IP: [171.96.73.62]
X-ClientProxiedBy: KL1PR0401CA0005.apcprd04.prod.outlook.com
 (2603:1096:820:f::10) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (171.96.73.62) by
 KL1PR0401CA0005.apcprd04.prod.outlook.com (2603:1096:820:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Wed, 3 Mar 2021 13:25:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 38a33665-847a-449a-7106-08d8de47dfec
X-MS-TrafficTypeDiagnostic: BY5PR12MB4853:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4853145C5D44DB787DAB4DDBF3989@BY5PR12MB4853.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JNRWsMD9j2hd3aXFAF6zRM3F8vqBgeZnMiEqvtiMBLT5NxeiLz7s3Y9H6Ygg9QWRJJ2HPA3E+J7pL4SDmrpVYiqsCBGNQoZjQyxZpj+SAZFufn//IyAsTkgcZMcVYxiRLwLBd8Gh48tmwO0ONqazpzbD8ZNsCqO6mPVqjP9Dbntvfsr3etYEify7UgpgQ2t0dylb9BD+Q1GY9h/zA5tV6secja6Dr/aqmwBA769qcgdK7+4fyir8TUddzN6ullhswBM8jwfkNuE45Y4xzRIAfg8lGtnO6B/PwVyoO+8DxA8XoYDQj9kCz62ujocbv+sQO3xyCwOWaaNgHzRpteOyQNL2KypW2VXbBGPeuYAEUeGrcNOcBwO8zwum8RO4e0Hc7mZHqkjMyhE8G86ZqZTvqxvdzuuwiPg7uzZgYWPZTLuq2LPseuU4OlehLYmi15PvU8Ce0IofslmW8Eo0LcBLlMTX5G9VkRsrCAHhIeuKqczxuAjU0YNw/cxLv9ImFDCZ0R+lIW1Twr+rArjGZFKKnzbGrhwLoQeRdCJQ+QBrvsmLw46KoNwf03+vdDHy/nZTnc1LOlb3mQVzhf69oLKNzj96e/FYQH+bXnECslTPMwUOZ2S4IvDYQIJ7a1Y9xGxlIVYl/8xwoNLnZu7fO/LlSayJJnm1kb45uM7msu6/FokIkvGEBs9L7X0+acbR6bxU7U/B8QlI0dOBmU54mPNKEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(478600001)(34580700001)(6666004)(4326008)(36756003)(5660300002)(186003)(52116002)(2616005)(956004)(53546011)(6506007)(16526019)(83380400001)(8676002)(6486002)(316002)(86362001)(8936002)(2906002)(26005)(31686004)(110136005)(54906003)(66946007)(6512007)(44832011)(66556008)(31696002)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TWRIMjU5TStXRXRUcjM5UjlNVkY3ZlFXRkdiWjFLeHYzWjVzRjNmOTliVndz?=
 =?utf-8?B?WmxsNVc3UnQyQVhBeWU1Y0FycDV3dHlTRHh4c09lNkxPWjdjQWEyWFpDa21O?=
 =?utf-8?B?c0RxSXhIVmRQbEx0OXp4Wk9ISXFIN1YvT3ZLbVpvSS9scTRNdUFwa2oyT1N6?=
 =?utf-8?B?dHAvV0NjTXhGU1BESjJNZXo3M1ZxRzNrUWZtMXhPVVAyNEJ5NmRZT2l5VlBu?=
 =?utf-8?B?ZFZGUGxnUlc0aDY3VS9JRm9BMndOVXA5THI5R3NPbGp6MGw4elJwTlZhQnlx?=
 =?utf-8?B?emVjOFpPTkQzT3hib253STV6QnpCUHhTUGZ3UUxjTW9OL3pKb3lnQlBwLzlI?=
 =?utf-8?B?QUFKSlZtNHlaN0tMeEkzS0UrR3QrNy90SkhaM0Y0aGNRWHM3bCtPNkhVbGx3?=
 =?utf-8?B?NlArNE54MGNRdnM0b1Nnc3N4Smg4cVdGemxSY0p3VnVOQkNOaDJCQ3lJcHdw?=
 =?utf-8?B?VDQrM1JMM2F3cG9qdjVudGpRWDllRDRqQjNvaXgxSU4zWUdqdEdRRStLQWpR?=
 =?utf-8?B?Tk0yL1d1eitQT0VlaEdkdkZsZS8vUHB3RGo0dGZSS2o4QjFCU0Rtb0RVK3lN?=
 =?utf-8?B?ZXlqbDJkOHhEalN1UysxbE4wK0xyRjg5UnVzcTR3VkoybFk3OExHVkhLRE9L?=
 =?utf-8?B?Q213YVYrTHRkc3JWZEgzMDNXNi93Um9jU1dkcnFudlhxSk5CdCtiNnI4cGdQ?=
 =?utf-8?B?SDNZRndBMDlPSU9LZFB5dkJ4NVR4VGhMbitibWVITmdYUFZKd1F2bGg4d3gy?=
 =?utf-8?B?dDlpZURJOUVSTFpLeXVmZWhpTkFLR2N1RlN0dGlLZ05kdWxvc3gyR0xhOEsw?=
 =?utf-8?B?ZDI1MzQyTTYrTTJSdnpmUFZsYWt6TG5qZHpncjFnN3JjV1RJc2FweWtoMFdG?=
 =?utf-8?B?cEFsZXBrRjJYV1pqS29UVWZIQnI4YkV6UFQzbk1naWVIYmp3RlRzZ3ViSHlk?=
 =?utf-8?B?NllhTWlwUFpkcENob3I1WlliK1ZydUQwTGo0dW55eDZHMTIwdGVBNGJFdHMx?=
 =?utf-8?B?VTk5S1NDOGhuZGZBUEdTQ3MxZ2xDalFMRjFlTk45Yk44WUpFaTV2aTNDRXRI?=
 =?utf-8?B?STNxWTVpb0Q3UXVYMUFaT3l0R28wME84REdzd2hmcmMzWHAvdkorY21kQmFu?=
 =?utf-8?B?WEZkclZzczZ2RDFuLytKZ2I4SDlkeVRUKy92S1VjWFROSE13RENRTDBzNnY2?=
 =?utf-8?B?ejZkOGRud2dBcGZtVHRMNEd4NkJLblJDNW9mSW5YV2gzbUFQNTRmS3NnbnZP?=
 =?utf-8?B?MGtNR0MyUlYvdHdKTGtxRnZDekhTdDNuWkR4MmRaUHFDTEppWUhSVG8rL0xw?=
 =?utf-8?B?TEZ4YnZ3a3hhQzlLcjYyOXg1clFjS3FPM0VnUER4bk11aTBhSHI5aTVvbldy?=
 =?utf-8?B?SVFTVXdUMVl4bWoxVHUxSTBlUjZSQkg4dndmcVZQOXVkbUFXaTd3SWdMWDg3?=
 =?utf-8?B?S05GeGd4eGpPNnRIMXBSbUZYZDZBTlFXc3Izck5MODQyK0VHNldFa3lTWkZE?=
 =?utf-8?B?VnAyNDJ3ZjVoR2U0cmFhczIyZXBWK1FqRlVPM0JtamM3ditTZGhTRVgxZm5U?=
 =?utf-8?B?TFFncjRhRTdqSG5qOGdYTFlVcmVmRnBqWSsxZnVxWUJIWnYwWTJVQUVHUFZB?=
 =?utf-8?B?MWRMclpHbDJSZWFBV2FoVTlURjROVzJLbUc4R0plemVZR2hRS0djcVVaT3g5?=
 =?utf-8?B?d0hZSWhobHRpTWNUMCtNTVhkM3J2RTlQOXhHYnpEYi84QzFFK0pKYnhNWFJt?=
 =?utf-8?Q?ROGTIqyxFHgI7AnCjlniXwL/5gWPmwTrR/IjHm8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a33665-847a-449a-7106-08d8de47dfec
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 13:25:55.6842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+pBSfeHFCybCmX24VoPOYPYzpLUXxPava4wYKXi4j7vtT38Wn4hpUDDP2N+L+tqkLuA4Cm8a1N0uqrxjb/gGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4853
Cc: Tj <ml.linux@elloe.vision>, iommu@lists.linux-foundation.org,
 Alexander Monakov <amonakov@ispras.ru>, David Coe <david.coe@live.co.uk>,
 Shuah Khan <skhan@linuxfoundation.org>
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

UGF1bCwKCk9uIDMvMy8yMSA3OjExIFBNLCBQYXVsIE1lbnplbCB3cm90ZToKPiBUaGlzIHJldmVy
dHMgY29tbWl0IDY3NzhmZjViMjFiZDhlNzhjOGJkNTQ3ZmQ2NjQzN2NmMjY1N2ZkOWIuCj4gCj4g
VGhlIGNvbW1pdCBhZGRzIHVwIHRvIDEwMCBtcyB0byB0aGUgYm9vdCBwcm9jZXNzLCB3aGljaCBp
cyBub3QgbWVudGlvbmVkCj4gaW4gdGhlIGNvbW1pdCBtZXNzYWdlLCBhbmQgaXMgbWFraW5nIHVw
IG1vcmUgdGhhbiAyMCAlIG9uIGN1cnJlbnQKPiBzeXN0ZW1zLCB3aGVyZSB0aGUgTGludXgga2Vy
bmVsIHRha2VzIDUwMCBtcy4KClRoZSAxMDAgbXNlYyAoNSAqIDIwbXMpIGlzIG9ubHkgZm9yIHRo
ZSB3b3JzdC1jYXNlIHNjZW5hcmlvLiBGb3IgbW9zdCBjYXNlcywKdGhlIGRlbGF5IGlzIG5vdCBh
cHBsaWNhYmxlLiBJbiBhZGRpdGlvbiwgdGhpcyBwYXRjaCBoYXMgc2hvd24gdG8gZml4IHRoZSBp
c3N1ZSBmb3IKc29tZSB1c2VycyBpbiB0aGUgZmllbGQuCgo+IAo+ICAgICAgWyAgICAwLjAwMDAw
MF0gTGludXggdmVyc2lvbiA1LjExLjAtMTAyODEtZzE5YjRmM2VkZDVjOSAocm9vdEBhMmFiNjYz
ZDkzN2UpIChnY2MgKERlYmlhbiAxMC4yLjEtNikgMTAuMi4xIDIwMjEwMTEwLCBHTlUgbGQgKEdO
VSBCaW51dGlscyBmb3IgRGViaWFuKSAyLjM1LjEpICMxMzggU01QIFdlZCBGZWIgMjQgMTE6Mjg6
MTcgVVRDIDIwMjEKPiAgICAgIFvigKZdCj4gICAgICBbICAgIDAuMTA2NDIyXSBzbXBib290OiBD
UFUwOiBBTUQgUnl6ZW4gMyAyMjAwRyB3aXRoIFJhZGVvbiBWZWdhIEdyYXBoaWNzIChmYW1pbHk6
IDB4MTcsIG1vZGVsOiAweDExLCBzdGVwcGluZzogMHgwKQo+ICAgICAgW+KApl0KPiAgICAgIFsg
ICAgMC4yOTEyNTddIHBjaSAwMDAwOjAwOjAwLjI6IEFNRC1WaTogVW5hYmxlIHRvIHJlYWQvd3Jp
dGUgdG8gSU9NTVUgcGVyZiBjb3VudGVyLgo+ICAgICAgW+KApl0KPiAKPiBBbHNvLCBpdCBkb2Vz
IG5vdCBmaXggdGhlIHByb2JsZW0gb24gYW4gTVNJIEIzNTBNIE1PUlRBUiB3aXRoIEFNRCBSeXpl
bgo+IDMgMjIwMEcgKGV2ZW4gd2l0aCB0ZW4gcmV0cmllcywgcmVzdWx0aW5nIGluIDIwMCBtcyB0
aW1lLW91dCkuCgpXZSBhcmUgc3RpbGwgaW52ZXN0aWdhdGluZyB0byByb290IGNhdXNlIHRoZSBs
b25nIGRlbGF5IGZvciB0aGUgSU9NTVUKcGVyZm9ybWFuY2UgY291bnRlciB1bml0IHRvIGRpc2Fi
bGUgcG93ZXItZ2F0aW5nLCBhbmQgYWxsb3cgYWNjZXNzIHRvCnRoZSBwZXJmb3JtYW5jZSBjb3Vu
dGVycy4gSWYgeW91ciBjb25jZXJuIGlzIHRoZSBhbW91bnQgb2YgcmV0cmllcywKd2UgY2FuIHRy
eSB0byByZWR1Y2UgdGhlIG51bWJlciBvZiByZXRpcmVzLgoKPiAKPiAgICAgIFsgICAgMC40MDEx
NTJdIHBjaSAwMDAwOjAwOjAwLjI6IEFNRC1WaTogVW5hYmxlIHRvIHJlYWQvd3JpdGUgdG8gSU9N
TVUgcGVyZiBjb3VudGVyLgo+IAo+IEFkZGl0aW9uYWxseSwgYWx0ZXJuYXRpdmUgcHJvcG9zZWQg
c29sdXRpb25zIFsxXSB3ZXJlIG5vdCBjb25zaWRlcmVkIG9yCj4gZGlzY3Vzc2VkLgo+IAo+IFsx
XTpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1pb21tdS9hbHBpbmUuTE5YLjIuMjAuMTMu
MjAwNjAzMDkzNTU3MC4zMTgxQG1vbm9wb2QuaW50cmEuaXNwcmFzLnJ1LwoKVGhpcyBjaGVjayBo
YXMgYmVlbiBpbnRyb2R1Y2VkIGVhcmx5IG9uIHRvIGRldGVjdCBhIEhXIGlzc3VlIGZvciBjZXJ0
YWluIHBsYXRmb3JtcyBpbiB0aGUgcGFzdCwKd2hlcmUgdGhlIHBlcmZvcm1hbmNlIGNvdW50ZXJz
IGFyZSBub3QgYWNjZXNzaWJsZSBhbmQgd291bGQgcmVzdWx0IGluIHNpbGVudCBmYWlsdXJlIHdo
ZW4gdHJ5CnRvIHVzZSB0aGUgY291bnRlcnMuIFRoaXMgaXMgY29uc2lkZXJlZCBsZWdhY3kgY29k
ZSwgYW5kIGNhbiBiZSByZW1vdmVkIGlmIHdlIGRlY2lkZSB0byBubwpsb25nZXIgcHJvdmlkZSBz
YW5pdHkgY2hlY2sgZm9yIHN1Y2ggY2FzZS4KClJlZ2FyZHMsClN1cmF2ZWUKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
