Return-Path: <SRS0=ekvE=HY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968B2C433E0
	for <iommu@archiver.kernel.org>; Mon, 22 Feb 2021 18:00:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 256B664E40
	for <iommu@archiver.kernel.org>; Mon, 22 Feb 2021 18:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256B664E40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D39406F579;
	Mon, 22 Feb 2021 18:00:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gqvd5pwCKTk8; Mon, 22 Feb 2021 17:59:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 480066F510;
	Mon, 22 Feb 2021 17:59:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1991BC000A;
	Mon, 22 Feb 2021 17:59:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 367D4C0001
 for <iommu@lists.linux-foundation.org>; Mon, 22 Feb 2021 17:59:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 24926834B6
 for <iommu@lists.linux-foundation.org>; Mon, 22 Feb 2021 17:59:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FscnHxBeEsMl for <iommu@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 17:59:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 755D9834FC
 for <iommu@lists.linux-foundation.org>; Mon, 22 Feb 2021 17:59:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGa7FGojeHbmFYFsSpx7IUY2UHBSxI+4CDMDKaby+ccue9T56HYZmLDDCX/Sk56S9OETMHhUUek1gBiXAVLtdQ1cI4jUxgQNwemUsJbm9hkzMdYlPAezWps0jDDT/Fs4zVsmd8vprX1GKyyahcgFzMFi7dhiXqKu29dr1cadL1BTXiByGs8ph6DMmFPcWPuC/E3mWIv3DPdHACaNFI6+xPFmGf3TogrgIEkwqSZX17kx1uj9BVAzoRs9XdFPTXReyLF4DbNyHI8FFmZuCFNK8AaTJ1fsWqYnDBpBckZrzuYHaiwwyV1C8OLF7Mv2CQUfx1/S8j3fpYshIfNN2fxi4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/rPX1oc6zOhNtifGe8ZR8LE0ZdRrGRB5XchlZWIq7U=;
 b=V3AJf0CYWXCAo6dR2h6vcCQxfnEwq/Kqz5JpROqYNrcqJ9WpesyFBl8b1Bp1c+3kCbfXPEF2kbPZgmILRp1q2/Jr+DsmQj37+AM8TdAPQ0FJeKhGx+Rcskq45nXtJTEDRR7mf7Wo53HXKD4BjAyVUYcmDnN2VJCGkftD9VyJuoqr6I5nDs4pquQTmRFF7ebAIpT2b2xQK9cuwERllkrUSpZFqfo0ZKFQoARVQ8MjdCgmg7h/1jE6wMXNRBW3SaI/FIn39/sd82Sf1XPbkCO1k5WQ8PI33s2xVsr1alGNDqt4YVcjh/IB15k9BgNBINMKkb3arw7j1wvYTYgtWiP3QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/rPX1oc6zOhNtifGe8ZR8LE0ZdRrGRB5XchlZWIq7U=;
 b=Sbe4QlQR1kxVvlGiNkHfD+c5jnbhO0RMhDqCSqLQ+hHhC5rvYr81JYr2dvI4sZkAAr+48gHxMYCgeJwMvDz8RzMeaqSyrqflWihCu0NeU950tY/UIhSx3d6app1OUn/CAid2Z5YJxxT3Pp73hccWnpsLilIfC9kXULxWIOqQRJ8=
Authentication-Results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB2824.namprd12.prod.outlook.com (2603:10b6:a03:97::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Mon, 22 Feb
 2021 17:59:52 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972%7]) with mapi id 15.20.3868.033; Mon, 22 Feb 2021
 17:59:52 +0000
Subject: Re: [PATCH] iommu/amd: Fix event counter availability check
To: Paul Menzel <pmenzel@molgen.mpg.de>
References: <20200529200738.1923-1-amonakov@ispras.ru>
 <56761139-f794-39b1-4dfa-dfc05fbe5f60@amd.com>
 <alpine.LNX.2.20.13.2006011132530.16067@monopod.intra.ispras.ru>
 <dba1e37a-1ed7-ef7f-7252-2ebd1d6bde8c@amd.com>
 <alpine.LNX.2.20.13.2006152346320.21123@monopod.intra.ispras.ru>
 <b01994db-da9b-d8e6-e0c1-1af35dd62191@amd.com>
 <alpine.LNX.2.20.13.2009172052480.29869@monopod.intra.ispras.ru>
 <23d42e73-91ac-8f47-af64-40edff8bc027@molgen.mpg.de>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <290635dc-723e-a55e-8447-95cef703b090@amd.com>
Date: Tue, 23 Feb 2021 00:59:41 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <23d42e73-91ac-8f47-af64-40edff8bc027@molgen.mpg.de>
Content-Language: en-US
X-Originating-IP: [124.121.4.202]
X-ClientProxiedBy: SG2PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:54::24) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (124.121.4.202) by
 SG2PR02CA0060.apcprd02.prod.outlook.com (2603:1096:4:54::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.27 via Frontend Transport; Mon, 22 Feb 2021 17:59:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 61d55878-cb25-4501-6037-08d8d75ba735
X-MS-TrafficTypeDiagnostic: BYAPR12MB2824:
X-Microsoft-Antispam-PRVS: <BYAPR12MB282467083ABCDD5C4104AC70F3819@BYAPR12MB2824.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tZdbB9BoO/jbwx1sBmE1dHjtU++xBcH7REhY+KqZGK0UuK56+I1zlSTHNIN7vjS6cqPSki9gUw2nf+hd7Qidrz595uuNeXh9f+UG8wekAMwf3GAJDRfYrsFSoqjs7gLA6mR44uqVadwn5a2oAM3eTEKMQHQ/HW3Anm5fFSfRuXFlHoGLRP/93T7BKnYcGSYI2n1XzAH+GYEHa3V210HwKTiS3EwjEoQlaMI7rIwxiy9kc9cikkVBfq4mJOuJwsYvVXgpTF451XRRUJ0yZaAq0U5nOPojgMqrf6t+mSsck879qdaPDP4mP6gbtWqgK822KbVQw5hxLYZjBT+WiJXMg5GS44vQQ9ZZ7ApwD5KPhkzpJP1we+CNWLWdr2sEVNI53YK54V5urNarq39uX0lLp8Cbs5v5UTeJMabM9VyKLhDBNQvY8ckFSOqZMaB852QtS15ZfXOPGrU9/h2TTgDV5SOFwW16hnbEbYiHfQ8ab+K/ofB6hh77IBldQhoGmy7c3tXed6HJ2b/O+OWjc+Wc6FSkfmiKAHp24SpI8UtHBRqTa8qlSqZ406f5tkYccmWY9MaGwHo2Jdjo/nHk6OQa3/WRVpH1z1qIIoyMELOT2DwJ3PhxQXOtmkmDlQTCidllRWEYKzj/UJdhPtHJ9ehZBsqKY9xjGqpXX2sjluTnH2+MD0Xn7BcOoUOf0clAIqh6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(6666004)(6512007)(6486002)(86362001)(52116002)(2906002)(316002)(31696002)(31686004)(36756003)(6916009)(4326008)(8676002)(8936002)(16526019)(478600001)(966005)(5660300002)(66946007)(53546011)(44832011)(26005)(66476007)(83380400001)(54906003)(66556008)(186003)(956004)(6506007)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aWZZanBmWUJ0ZDZXb0doeTB2T014UThOTDh1UWRqSWdLaDhCWkRnYWRYbUZz?=
 =?utf-8?B?Y1ZlNlVnUWlqeGc5dUZRS0hldXZEcVZMcTkyYlk2dThKOFZldXAwVTJYVGd3?=
 =?utf-8?B?ZU50SWptbGVXZEQvU1d0NGVlUFV4d1d2aitpNlRVdVp2OVFFa28vdSt3T0lz?=
 =?utf-8?B?Tkd0dzhJTjJYM01LWVI4L28yMTFIOWNDenN0bXlHaGZXMkRjOVNrdnNwc2h3?=
 =?utf-8?B?T2FDN1pkenRnT1p3Yi80a0NmVllTOXpMZjRUZVdLb3NpMEt6ZTZKQWZNczZH?=
 =?utf-8?B?MVJPVUl6ODRrM01NdXdlaWJ1Z1IzaHpHWnVFTlRtZTNqRmVBeExqelZ4b1pR?=
 =?utf-8?B?VDBySVlGTDJiREJEU3RBdURlZUN2ZFV6MU9JVklxNXR4clBGemhJcDNuNWtP?=
 =?utf-8?B?UlZ6SUZTYWZlazlTZTlUdHdoUW5IVmtuL2xVTWluM21XajlHS2NiRnFDb04y?=
 =?utf-8?B?eEJtT2M4NWpvWmNvazNSbHk1V1AyeUVaYk5IbzUydTRVODlMeTljSVB3OWx3?=
 =?utf-8?B?UzJONmJKTm04MmhtOUJCSGNmN2toZndpWXVwV0JPN1J0YjQyYytlNTZsRE02?=
 =?utf-8?B?eS8xUTZKMHQzS1J1dVpBLys5eDI5QUNrTEtmTG1UZTJmckVKTy9saVhPWkpR?=
 =?utf-8?B?c2lpQlVwMWxVNlhCSEZYWXB2WXNWL1dvWUVBdW5MdjVpTElSR3A4aklsVEdx?=
 =?utf-8?B?UU1FSEZsTU1XN1N2ejZNQ0R4RjFQMTdaQmRJVEV5VDdvSkMrc25CNlplUVM5?=
 =?utf-8?B?QUhXMzVFNjAzdmJMRG15V1JYMC9XMlVSLzVxcW0zL0dUT3V6b082eXFheUJX?=
 =?utf-8?B?b1BTMmtVK0xlUGlSWkpkb0YzRXZHckRXV0JNVDZHSW1oSkFyZmZTdlE5SjhW?=
 =?utf-8?B?RVc0MDZ0NkxKU0NrM0FySitCSitVYUN2N2FPemVGYnZ1MFRTenM4OXU2Mlhq?=
 =?utf-8?B?Ym84WWF0VnBYNllUVUhzNGhGY2p3RkJPV1o1S0RoQTAzb3JHbkZ5ZlltL2hD?=
 =?utf-8?B?SzA1R0JPTDFsczYweDRRUGU3L0JXQVRBZjhKTFFJZVdVckQ1aldsTU9aYkpL?=
 =?utf-8?B?UURuUVNMU1VnWXBqYmtGMnU0Y3VsQm5GYnd6YUE3d3FjUmY5TndOd2lKTEYr?=
 =?utf-8?B?SW9KeFFxNjhKdEdZNHJkaGdwR2ZGUkVUU2dISlZjVmswbjZzK2ZDekczWVVQ?=
 =?utf-8?B?WlNlMTZYeGMwb0E1NHlYeE5xTVJESTAxVEx2YlJNZFh4WnFNZjArcW1DVTc3?=
 =?utf-8?B?T0cyNVRSQWhQVUNyWjZyaU53Uy9nVWIraGVQVEgzb2pjckNONkJNS0txU1ND?=
 =?utf-8?B?bWc5MU1TVXdOdDRSZVJWMk9VcDNpUm1xUnovcjVBTWlYVDA3eU9SbldwRjRt?=
 =?utf-8?B?clJyeTgvQ3lzNWRhQTQvZTJqZEliRWZ5c2NaVGRmU1hwMUNCSG9yNGw2Z3ND?=
 =?utf-8?B?YWdSemRjL3N6bXJ4WDRwYVM5a3kyQXNSaklaQklSdEVsS01oMC9YcFZ3MFEy?=
 =?utf-8?B?Wmg3czB4MmlsbmMvSUtDYWtLUkZKdkF0NHJQV3RFWVBib2N6ZFZIbUhzUXRq?=
 =?utf-8?B?OGlQMU5NSWFrM1NSQWRqRVhVQW5ZbFdaU3ZnRC9waytsODBIaXB0NVVTSDRF?=
 =?utf-8?B?RlRySmxrWnNla3hidVNraGl4dU9SWmJwNk1Fa0ovN214eW1waXJPTW95VTJF?=
 =?utf-8?B?Tk5pbkh5V3FBYnpTOWZkNi9IZVNDVHFlelR1cTZVQ1YzSXUwa3JlVUNySkpC?=
 =?utf-8?Q?Ko2YE7MpoyFfbUceKPrPOhMdQvbzdHe9fOEmYrt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d55878-cb25-4501-6037-08d8d75ba735
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 17:59:52.3512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxTwlgvmZScItvrx5x6vCufP8BgGSRcddj48ZDre3yfnPDk+NkyvBrPKk+MMm6f4Nlfr8aJ+ccrqpsUh6+ixsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2824
Cc: iommu@lists.linux-foundation.org, Alexander Monakov <amonakov@ispras.ru>,
 linux-kernel@vger.kernel.org
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

VGhpcyBmaXggaGFzIGJlZW4gYWNjZXB0ZWQgaW4gdGhlIHVwc3RyZWFtIHJlY2VudGx5LgoKaHR0
cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvam9yby9pb21tdS5n
aXQvY29tbWl0Lz9oPXg4Ni9hbWQKCkNvdWxkIHlvdSBwbGVhc2UgZ2l2ZSB0aGlzIGEgdHJ5PwoK
VGhhbmtzLApTdXJhdmVlCgpPbiAyLzIxLzIxIDg6NDkgUE0sIFBhdWwgTWVuemVsIHdyb3RlOgo+
IERlYXIgU3VyYXZlZSwKPiAKPiAKPiBBbSAxNy4wOS4yMCB1bSAxOTo1NSBzY2hyaWViIEFsZXhh
bmRlciBNb25ha292Ogo+PiBPbiBUdWUsIDE2IEp1biAyMDIwLCBTdXJhdmVlIFN1dGhpa3VscGFu
aXQgd3JvdGU6Cj4+Cj4+Pj4+IEluc3RlYWQgb2YgYmxpbmRseSBtb3ZpbmcgdGhlIGNvZGUgYXJv
dW5kIHRvIGEgc3BvdCB0aGF0IHdvdWxkIGp1c3Qgd29yaywKPj4+Pj4gSSBhbSB0cnlpbmcgdG8g
dW5kZXJzdGFuZCB3aGF0IG1pZ2h0IGJlIHJlcXVpcmVkIGhlcmUuIEluIHRoaXMgY2FzZSwKPj4+
Pj4gdGhlIGluaXRfZGV2aWNlX3RhYmxlX2RtYSgpc2hvdWxkIG5vdCBiZSBuZWVkZWQuIEkgc3Vz
cGVjdCBpdCdzIHRoZSBJT01NVQo+Pj4+PiBpbnZhbGlkYXRlIGFsbCBjb21tYW5kIHRoYXQncyBh
bHNvIG5lZWRlZCBoZXJlLgo+Pj4+Pgo+Pj4+PiBJJ20gYWxzbyBjaGVja2luZyB3aXRoIHRoZSBI
VyBhbmQgQklPUyB0ZWFtLiBNZWFud2hpbGUsIGNvdWxkIHlvdSBwbGVhc2UKPj4+Pj4gZ2l2ZQo+
Pj4+PiB0aGUgZm9sbG93aW5nIGNoYW5nZSBhIHRyeToKPj4+PiBIZWxsby4gQ2FuIHlvdSBnaXZl
IGFueSB1cGRhdGUgcGxlYXNlPwo+IAo+IFvigKZdCj4gCj4+PiBTb3JyeSBmb3IgbGF0ZSByZXBs
eS4gSSBoYXZlIGEgcmVwcm9kdWNlciBhbmQgd29ya2luZyB3aXRoIHRoZSBIVyB0ZWFtIHRvCj4+
PiB1bmRlcnN0YW5kIHRoZSBpc3N1ZS4KPj4+IEkgc2hvdWxkIGJlIGFibGUgdG8gcHJvdmlkZSB1
cGRhdGUgd2l0aCBzb2x1dGlvbiBieSB0aGUgZW5kIG9mIHRoaXMgd2Vlay4KPj4KPj4gSGVsbG8s
IGhvcGUgeW91IGFyZSBkb2luZyB3ZWxsLiBIYXMgdGhpcyBpbnZlc3RpZ2F0aW9uIGZvdW5kIGFu
eXRoaW5nPwo+IAo+IEkgYW0gd29uZGVyaW5nIHRoZSBzYW1lLiBJdOKAmWQgYmUgZ3JlYXQgdG8g
aGF2ZSB0aGlzIGZpeGVkIGluIHRoZSB1cHN0cmVhbSBMaW51eCBrZXJuZWwuCj4gCj4gCj4gS2lu
ZCByZWdhcmRzLAo+IAo+IFBhdWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
