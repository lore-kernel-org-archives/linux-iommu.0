Return-Path: <SRS0=YfIy=NA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9048FC4338F
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 22:17:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE5560EB5
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 22:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2BE5560EB5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC4CC8318C;
	Mon,  9 Aug 2021 22:16:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7546I7KWWBZe; Mon,  9 Aug 2021 22:16:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8858482668;
	Mon,  9 Aug 2021 22:16:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5718AC0010;
	Mon,  9 Aug 2021 22:16:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D7FEC000E
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 22:16:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 375DD60794
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 22:16:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pbfUc7xNLrSu for <iommu@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 22:16:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::611])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 525B0605A2
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 22:16:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1b6fF+y6JsYt35N8A5iJVIWBft9UbgbAkiGbMH3O00bNBX1Y3vaYKpJ4rOXUXLS+/j7moEIjsrznEA/HajQXLBSCBUQorWtyA0iZ+A+r0OQkPOfcLSdrX8+zUA897hdH7j6a3jJNW5AuM+P+yqKgJNgJXtLvmjBBiXe2YuzE2m5ONh2Ts7D+ue5gtDJEw3KypQRWlHqhBG/vyVdYSQqThGvmg5CX9cg3QG+QIThKEtrqTRygDps4i67PrCRii/FG9IosQZIn7Nb0OVELbhhFzAE1LzN5NqLsG61Ifp+7/0lf0dbmakrbhfpWeZvZsO1Sq0FTl7JkYqIMKA8OnT/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+fwmX6Q39MkilgVtnsUqVDkLnT1mk/AV6fBAqAUqvU=;
 b=jTH1ZJv1jtriew0t4PW4Fd7LPv2hqwvotB+J47Xy5dO3fb/wXm1Tz/39HTH2z+M/d+rHcWcOqbQRekQTBWf2B76sIwZF8+lY8umIsUw9Jyf0xmyXloRtD6bOXADXe7ONou+8AKO/bnkNGRH0yfrLlZjmZbfhAkL+YEWqsgj37e+FOJS0OBKhtzurkcq0Ps9OGFBhkWLFK3ForbL7I47ZFwybwLhxcSREHIGCGCr2VG6vO03Z3Euxsxyf//9HRnxRrxWR/fvT721FDcKXmkB/h9Z/wkmdgCb108SvnEkCxbF4Tsd13oZCSt367yMEFudQMIMYXA12hpzeBHHO2PTu3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+fwmX6Q39MkilgVtnsUqVDkLnT1mk/AV6fBAqAUqvU=;
 b=cSe52ps/4KuS1UjyZ0KB3W8Fnttajsj1EbYfiX12ISWEYg1dCgQuY699Guu1p7WgcRqIo7o5wqYK4FhSC5VMGNZ2PcIKAbc9W4ZvqjM6u06PBsITtW1mnPt0gTxhkledkfOgbCBCYxwQzAbYQ2frUKeXxV4N1ba8fFiYYWZEAoI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Mon, 9 Aug
 2021 22:16:47 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208%3]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 22:16:47 +0000
Subject: Re: [PATCH 00/11] Implement generic prot_guest_has() helper function
To: "Kuppuswamy, Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
 linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <0d75f283-50b7-460d-3165-185cb955bd70@linux.intel.com>
Message-ID: <e4584e88-b0bf-175d-9494-4e133c03fc07@amd.com>
Date: Mon, 9 Aug 2021 17:16:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <0d75f283-50b7-460d-3165-185cb955bd70@linux.intel.com>
Content-Language: en-US
X-ClientProxiedBy: SA0PR11CA0032.namprd11.prod.outlook.com
 (2603:10b6:806:d0::7) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.241] (165.204.77.1) by
 SA0PR11CA0032.namprd11.prod.outlook.com (2603:10b6:806:d0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.17 via Frontend Transport; Mon, 9 Aug 2021 22:16:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f92fe84-d210-466e-0e93-08d95b8360cf
X-MS-TrafficTypeDiagnostic: DM4PR12MB5054:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5054F2315990F7A142DF5DC3ECF69@DM4PR12MB5054.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ybCsYxUJ4J/W/kEe8EnRAOwTv7wTPXurQOm1eqvwpSoKf0FlQPV9oXkFda4GMnlJUYagHy+zU1i1aBeAumUd0/FS0fvHpruZxlnsH80WmEFKJjmbHj4/UMGbYxrvmvZ7qQJfAfAkwRDQc/gUr7SB5vqId0c5MuByGAlgf0aBw1tNLJepubwJDWEdOUfI4GgCBh78CqAmBbh1POA2nWbm08JI4s4Kh6Dmw1gy2tyxkwtIyAcRmykvZCCjQPu9uZKXxDUFU4+LAYa0jE6Ny5AiVqFfzRdw382yxi7hkaMnRFEmetLcBo0z9csPSf2c++oohCcIp7OXIy8Il9uglpyJb54al79quGzsEliE2bx6Sto/qdehhcyHnytL1tSq31MuSRKWt2QY9nXgNVX4jAKMb7TQOA+VQiKZoHko2CD7pjpri9WOe+R1rF3Xl0c0G16lFbVF2qpJrirUClm6Uf6xkAkfrzSUsHhFcQ4Fk6cdj+AnRvBIxQn9dRZEjB058zhAe6QH0vYWWXAjsTQOquiu+ltvRVJ04XCwO2N7EE1ymQKAtgigHd/6lcNyXavVBDXFMVJjMpWeXr9eXw0eG+xKa1hVvhrz8WMAI4U1qScGn07IXEDSvrJP9I8fwxgIYlbDg18lTx65RtdY9FpffXY72pfv2cjatK9ymVwQ90VV2ketO+5nBDJwj/oDtAY1lH0t151a3QY55LyDl8eAcwNxRdnvbqVTDF7pwOcNigoTWx9oaBi721w+DplDH8bh5VDQ3YGvgiY4qQFopsN3Dd2P/VG6Yy/YQ1PbtzOAunfpljqbMGNHpkuxCXYZhQeHL1NUG8CfvYC9DgGpIQ8BQnSWb6LDchEAzM0qFTeMUr1Je6M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5229.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(53546011)(31686004)(66946007)(54906003)(8676002)(966005)(478600001)(66476007)(66556008)(16576012)(6486002)(83380400001)(8936002)(186003)(5660300002)(2906002)(26005)(86362001)(45080400002)(38100700002)(2616005)(7416002)(316002)(956004)(7406005)(36756003)(921005)(31696002)(4326008)(41533002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEM1WGl5SjdycFFsc0VHWmVoT3J4QUtKc2gyaUtRMmpVcEJuczU3aU43SnBM?=
 =?utf-8?B?a3YxL1JNaWc4REhyeTRMV2dCUEtyaHRaVnNrQXRPbGMxcUduM1JWTVN5OUpn?=
 =?utf-8?B?d2hQODU3R3Vqc1cwQUxLOG95dGVxTHQ4ZWtsbll5cW9LS0l2Z0VQajM2TEhG?=
 =?utf-8?B?cHJiMDRHWnE3dUdCT1plemgzTXB6Y29Hc1U0cktIMWNKdmFVb0ozQUMwTXpY?=
 =?utf-8?B?MndwL0FJUmlsSXR4aXI2bVBmV3ViR3hrUXkvSmplRm0rUTNuZjdUdENrVWVi?=
 =?utf-8?B?b1lPMzFsZjdwVjZEaDkwQlBjM2txVkZGK1pScmhSVXRydDBMV2tQalpNYTRh?=
 =?utf-8?B?TmJqVDVhRjB0dXJmSVpsT20xQmNrdzlXczZES0M1RVBhQmgwb3ZQUXlrQzl6?=
 =?utf-8?B?Q2hrUEhKc0dNaWpNaklhQmJ3elpieXBHQnJBWkJla2hlN2xTbk9UOWdVdHB6?=
 =?utf-8?B?NVd1RTVhSHhNdXlwSHlTejlEc0lacTV1ZklpTUd3eEtsYnFXWjJaN3Z5V3ZC?=
 =?utf-8?B?blBIekw0ampaWHNzR0F1WGRTeVhrMlM5MnFEamxueDZaVmRXUXd4Q0dPT3la?=
 =?utf-8?B?dnhpV01hSmxWeTVLTTNLL1lNTnB0L2NpOHBramVqZ1dHS3QvZ1hTbUhGY09O?=
 =?utf-8?B?cDJIdnVSelRZandjQ3lmcDAyNUg1eklMbTl1S0Q5L3E3Y1lyVUdiV2dROEJw?=
 =?utf-8?B?Qi9ENTJpUVlhYlJjYmRkaVZhd2dLOS84QWx2dlo4N1hKd053ODVZOU9IUHp3?=
 =?utf-8?B?Smg0VTZva0lKRUpweW1XYUtaZkdPbFRKd3QxOEdHVWY1cHROdEFVWUhvZFAw?=
 =?utf-8?B?QUZSRm1BcW1vano3aFdUOU5vcVZPTVdIYUgwMThaWE0yQXlHbWwraWVIM2JW?=
 =?utf-8?B?ZEp2YklRMkhXVXQzaDliM0wrNWJleXRIM1BCdGcvaHpUMmlxSXhFc1ZNQURO?=
 =?utf-8?B?ZlRHQTJSdEJBOTRKUG5sOXh1SnR0cXZDSTlqWFh1M2MwK1FrZGJhenVSZG5V?=
 =?utf-8?B?L3E5Qk1OdmJLazhJMVRma21rbnNWVjdZTCs3S2JKOURCT1E2dDEwWDRyelFq?=
 =?utf-8?B?bk45b2M3Qy9zTWVHTDRLMk40cmN3azFTZFkwOUU4OUJjMHJWeVNhb04yVHBK?=
 =?utf-8?B?Ump6KzF6bzVQYUw1WkN2clNxMzRVbThzcUVQU2ZzREl1Y2tRa2lmWmY0R3ds?=
 =?utf-8?B?MjJpLzlMcGhxY0VjSzlsSnltUjF3cVljOHdNKzlKL1p0ZVhLSWpqRTZzc3U1?=
 =?utf-8?B?RFJLVXZiQW9lb1Vwc2NyQWo2cVNPejc2ZzMxZTdxeUdjT0RXZHp2TWdhOU1U?=
 =?utf-8?B?NldCVjM5bzBWZ0t2R3RjalVlOWFYamhHa3VFYmI0NmJPNVJGNjZPaEV4bi9W?=
 =?utf-8?B?L2tuOTNxOHJxSWdnY0pHVmo2NU1NTDErWDU5THBpQzB5cllPanhob0ZRNHFY?=
 =?utf-8?B?eVQ0TFlhNitXdnhGbjF3RnoyNDlGSjFpdU5hYnpXeDhqeXBLc1dUWkhZekJS?=
 =?utf-8?B?TnVwcms3WCtISGhDYXhtdE5Tc0M5MmlKTk5STEpTY1kvYVorQmFNaTNsSWlv?=
 =?utf-8?B?azBOekxUcXBqblBFcjZDR2ltcWNwRG9hdFN5c0hEc2FwOEhpWFQvZTFOTFRZ?=
 =?utf-8?B?T2lDclp2cnlIMU5IKzJHd3RxNXd6RTMwdUtPcEpneTJrZEFKTFBma2RDLzBy?=
 =?utf-8?B?VlFJUFZzanpTekFWckNwNjJEeTFTdUZjdkdmWFhiVGlwYVFITW9YUnJrZDFO?=
 =?utf-8?Q?hsPIX0FzA5wl8+n6mtSbpcroiybnFiaSc2Zjg4b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f92fe84-d210-466e-0e93-08d95b8360cf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 22:16:47.4832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWonoL3hzNeEn7iFofjcGCY0PgdwEHXOt2iYa+B5GGK7Xyg5Ta4xjEGJFIvdErQdiMFgJggx8W+URScsRqMA1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054
Cc: Brijesh Singh <brijesh.singh@amd.com>, David Airlie <airlied@linux.ie>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Paul Mackerras <paulus@samba.org>,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Andi Kleen <ak@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Dave Young <dyoung@redhat.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Vasily Gorbik <gor@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Daniel Vetter <daniel@ffwll.ch>
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
From: Tom Lendacky via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gOC84LzIxIDg6NDEgUE0sIEt1cHB1c3dhbXksIFNhdGh5YW5hcmF5YW5hbiB3cm90ZToKPiBI
aSBUb20sCj4gCj4gT24gNy8yNy8yMSAzOjI2IFBNLCBUb20gTGVuZGFja3kgd3JvdGU6Cj4+IFRo
aXMgcGF0Y2ggc2VyaWVzIHByb3ZpZGVzIGEgZ2VuZXJpYyBoZWxwZXIgZnVuY3Rpb24sIHByb3Rf
Z3Vlc3RfaGFzKCksCj4+IHRvIHJlcGxhY2UgdGhlIHNtZV9hY3RpdmUoKSwgc2V2X2FjdGl2ZSgp
LCBzZXZfZXNfYWN0aXZlKCkgYW5kCj4+IG1lbV9lbmNyeXB0X2FjdGl2ZSgpIGZ1bmN0aW9ucy4K
Pj4KPj4gSXQgaXMgZXhwZWN0ZWQgdGhhdCBhcyBuZXcgcHJvdGVjdGVkIHZpcnR1YWxpemF0aW9u
IHRlY2hub2xvZ2llcyBhcmUKPj4gYWRkZWQgdG8gdGhlIGtlcm5lbCwgdGhleSBjYW4gYWxsIGJl
IGNvdmVyZWQgYnkgYSBzaW5nbGUgZnVuY3Rpb24gY2FsbAo+PiBpbnN0ZWFkIG9mIGEgY29sbGVj
dGlvbiBvZiBzcGVjaWZpYyBmdW5jdGlvbiBjYWxscyBhbGwgY2FsbGVkIGZyb20gdGhlCj4+IHNh
bWUgbG9jYXRpb25zLgo+Pgo+PiBUaGUgcG93ZXJwYyBhbmQgczM5MCBwYXRjaGVzIGhhdmUgYmVl
biBjb21waWxlIHRlc3RlZCBvbmx5LiBDYW4gdGhlCj4+IGZvbGtzIGNvcGllZCBvbiB0aGlzIHNl
cmllcyB2ZXJpZnkgdGhhdCBub3RoaW5nIGJyZWFrcyBmb3IgdGhlbS4KPiAKPiBXaXRoIHRoaXMg
cGF0Y2ggc2V0LCBzZWxlY3QgQVJDSF9IQVNfUFJPVEVDVEVEX0dVRVNUIGFuZCBzZXQKPiBDT05G
SUdfQU1EX01FTV9FTkNSWVBUPW4sIGNyZWF0ZXMgZm9sbG93aW5nIGVycm9yLgo+IAo+IGxkOiBh
cmNoL3g4Ni9tbS9pb3JlbWFwLm86IGluIGZ1bmN0aW9uIGBlYXJseV9tZW1yZW1hcF9pc19zZXR1
cF9kYXRhJzoKPiBhcmNoL3g4Ni9tbS9pb3JlbWFwLmM6NjcyOiB1bmRlZmluZWQgcmVmZXJlbmNl
IHRvIGBlYXJseV9tZW1yZW1hcF9kZWNyeXB0ZWQnCj4gCj4gSXQgbG9va3MgbGlrZSBlYXJseV9t
ZW1yZW1hcF9pc19zZXR1cF9kYXRhKCkgaXMgbm90IHByb3RlY3RlZCB3aXRoCj4gYXBwcm9wcmlh
dGUgY29uZmlnLgoKT2ssIHRoYW5rcyBmb3IgZmluZGluZyB0aGF0LiBJJ2xsIGZpeCB0aGF0LgoK
VGhhbmtzLApUb20KCj4gCj4gCj4+Cj4+IENjOiBBbmRpIEtsZWVuIDxha0BsaW51eC5pbnRlbC5j
b20+Cj4+IENjOiBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVsLm9yZz4KPj4gQ2M6IEFyZCBC
aWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+Cj4+IENjOiBCYW9xdWFuIEhlIDxiaGVAcmVkaGF0
LmNvbT4KPj4gQ2M6IEJlbmphbWluIEhlcnJlbnNjaG1pZHQgPGJlbmhAa2VybmVsLmNyYXNoaW5n
Lm9yZz4KPj4gQ2M6IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPgo+PiBDYzogQ2hyaXN0
aWFuIEJvcm50cmFlZ2VyIDxib3JudHJhZWdlckBkZS5pYm0uY29tPgo+PiBDYzogRGFuaWVsIFZl
dHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+PiBDYzogRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxp
bnV4LmludGVsLmNvbT4KPj4gQ2M6IERhdmUgWW91bmcgPGR5b3VuZ0ByZWRoYXQuY29tPgo+PiBD
YzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+PiBDYzogSGVpa28gQ2Fyc3RlbnMg
PGhjYUBsaW51eC5pYm0uY29tPgo+PiBDYzogSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+
Cj4+IENjOiBKb2VyZyBSb2VkZWwgPGpvcm9AOGJ5dGVzLm9yZz4KPj4gQ2M6IE1hYXJ0ZW4gTGFu
a2hvcnN0IDxtYWFydGVuLmxhbmtob3JzdEBsaW51eC5pbnRlbC5jb20+Cj4+IENjOiBNYXhpbWUg
UmlwYXJkIDxtcmlwYXJkQGtlcm5lbC5vcmc+Cj4+IENjOiBNaWNoYWVsIEVsbGVybWFuIDxtcGVA
ZWxsZXJtYW4uaWQuYXU+Cj4+IENjOiBQYXVsIE1hY2tlcnJhcyA8cGF1bHVzQHNhbWJhLm9yZz4K
Pj4gQ2M6IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4KPj4gQ2M6IFRob21h
cyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPgo+PiBDYzogVGhvbWFzIFppbW1lcm1hbm4g
PHR6aW1tZXJtYW5uQHN1c2UuZGU+Cj4+IENjOiBWYXNpbHkgR29yYmlrIDxnb3JAbGludXguaWJt
LmNvbT4KPj4gQ2M6IFZNd2FyZSBHcmFwaGljcyA8bGludXgtZ3JhcGhpY3MtbWFpbnRhaW5lckB2
bXdhcmUuY29tPgo+PiBDYzogV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz4KPj4KPj4gLS0t
Cj4+Cj4+IFBhdGNoZXMgYmFzZWQgb246Cj4+IMKgwqAKPj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlu
a3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGZ2l0Lmtlcm5lbC5v
cmclMkZwdWIlMkZzY20lMkZsaW51eCUyRmtlcm5lbCUyRmdpdCUyRnRpcCUyRnRpcC5naXQmYW1w
O2RhdGE9MDQlN0MwMSU3Q3Rob21hcy5sZW5kYWNreSU0MGFtZC5jb20lN0M1NjNiNWUzMGEzMjU0
ZjY3MzlhYTA4ZDk1YWQ2ZTI0MiU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdD
MCU3QzAlN0M2Mzc2NDA3MDEyMjg0MzQ1MTQlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lq
b2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4w
JTNEJTdDMTAwMCZhbXA7c2RhdGE9dng5djRFbVlxVlRzSjdLU3I5N2dRYUJXSiUyRnElMkJFOU5P
elhNaGUzRnA3VDglM0QmYW1wO3Jlc2VydmVkPTAKPj4gbWFzdGVyCj4+IMKgwqAgY29tbWl0IDc5
ZTkyMDA2MGZhNyAoIk1lcmdlIGJyYW5jaCAnV0lQL2ZpeGVzJyIpCj4+Cj4+IFRvbSBMZW5kYWNr
eSAoMTEpOgo+PiDCoMKgIG1tOiBJbnRyb2R1Y2UgYSBmdW5jdGlvbiB0byBjaGVjayBmb3Igdmly
dHVhbGl6YXRpb24gcHJvdGVjdGlvbgo+PiDCoMKgwqDCoCBmZWF0dXJlcwo+PiDCoMKgIHg4Ni9z
ZXY6IEFkZCBhbiB4ODYgdmVyc2lvbiBvZiBwcm90X2d1ZXN0X2hhcygpCj4+IMKgwqAgcG93ZXJw
Yy9wc2VyaWVzL3N2bTogQWRkIGEgcG93ZXJwYyB2ZXJzaW9uIG9mIHByb3RfZ3Vlc3RfaGFzKCkK
Pj4gwqDCoCB4ODYvc21lOiBSZXBsYWNlIG9jY3VycmVuY2VzIG9mIHNtZV9hY3RpdmUoKSB3aXRo
IHByb3RfZ3Vlc3RfaGFzKCkKPj4gwqDCoCB4ODYvc2V2OiBSZXBsYWNlIG9jY3VycmVuY2VzIG9m
IHNldl9hY3RpdmUoKSB3aXRoIHByb3RfZ3Vlc3RfaGFzKCkKPj4gwqDCoCB4ODYvc2V2OiBSZXBs
YWNlIG9jY3VycmVuY2VzIG9mIHNldl9lc19hY3RpdmUoKSB3aXRoIHByb3RfZ3Vlc3RfaGFzKCkK
Pj4gwqDCoCB0cmVld2lkZTogUmVwbGFjZSB0aGUgdXNlIG9mIG1lbV9lbmNyeXB0X2FjdGl2ZSgp
IHdpdGgKPj4gwqDCoMKgwqAgcHJvdF9ndWVzdF9oYXMoKQo+PiDCoMKgIG1tOiBSZW1vdmUgdGhl
IG5vdyB1bnVzZWQgbWVtX2VuY3J5cHRfYWN0aXZlKCkgZnVuY3Rpb24KPj4gwqDCoCB4ODYvc2V2
OiBSZW1vdmUgdGhlIG5vdyB1bnVzZWQgbWVtX2VuY3J5cHRfYWN0aXZlKCkgZnVuY3Rpb24KPj4g
wqDCoCBwb3dlcnBjL3BzZXJpZXMvc3ZtOiBSZW1vdmUgdGhlIG5vdyB1bnVzZWQgbWVtX2VuY3J5
cHRfYWN0aXZlKCkKPj4gwqDCoMKgwqAgZnVuY3Rpb24KPj4gwqDCoCBzMzkwL21tOiBSZW1vdmUg
dGhlIG5vdyB1bnVzZWQgbWVtX2VuY3J5cHRfYWN0aXZlKCkgZnVuY3Rpb24KPj4KPj4gwqAgYXJj
aC9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoCAzICsrCj4+IMKgIGFyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9tZW1f
ZW5jcnlwdC5owqDCoMKgwqAgfMKgIDUgLS0KPj4gwqAgYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNt
L3Byb3RlY3RlZF9ndWVzdC5oIHwgMzAgKysrKysrKysrKysKPj4gwqAgYXJjaC9wb3dlcnBjL3Bs
YXRmb3Jtcy9wc2VyaWVzL0tjb25maWfCoMKgwqDCoCB8wqAgMSArCj4+IMKgIGFyY2gvczM5MC9p
bmNsdWRlL2FzbS9tZW1fZW5jcnlwdC5owqDCoMKgwqDCoMKgwqAgfMKgIDIgLQo+PiDCoCBhcmNo
L3g4Ni9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8wqAgMSArCj4+IMKgIGFyY2gveDg2L2luY2x1ZGUvYXNtL2tleGVjLmjCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyICstCj4+IMKgIGFyY2gveDg2L2luY2x1ZGUvYXNt
L21lbV9lbmNyeXB0LmjCoMKgwqDCoMKgwqDCoMKgIHwgMTMgKy0tLS0KPj4gwqAgYXJjaC94ODYv
aW5jbHVkZS9hc20vcHJvdGVjdGVkX2d1ZXN0LmjCoMKgwqDCoCB8IDI3ICsrKysrKysrKysKPj4g
wqAgYXJjaC94ODYva2VybmVsL2NyYXNoX2R1bXBfNjQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgIDQgKy0KPj4gwqAgYXJjaC94ODYva2VybmVsL2hlYWQ2NC5jwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA0ICstCj4+IMKgIGFyY2gveDg2L2tlcm5lbC9rdm0uY8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMyArLQo+PiDCoCBh
cmNoL3g4Ni9rZXJuZWwva3ZtY2xvY2suY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoCA0ICstCj4+IMKgIGFyY2gveDg2L2tlcm5lbC9tYWNoaW5lX2tleGVjXzY0LmPCoMKgwqDC
oMKgwqDCoMKgIHwgMTkgKysrLS0tLQo+PiDCoCBhcmNoL3g4Ni9rZXJuZWwvcGNpLXN3aW90bGIu
Y8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA5ICsrLS0KPj4gwqAgYXJjaC94ODYva2Vy
bmVsL3JlbG9jYXRlX2tlcm5lbF82NC5TwqDCoMKgwqDCoMKgIHzCoCAyICstCj4+IMKgIGFyY2gv
eDg2L2tlcm5lbC9zZXYuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8wqAgNiArLS0KPj4gwqAgYXJjaC94ODYva3ZtL3N2bS9zdm0uY8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDMgKy0KPj4gwqAgYXJjaC94ODYvbW0vaW9yZW1h
cC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTYgKysrLS0t
Cj4+IMKgIGFyY2gveDg2L21tL21lbV9lbmNyeXB0LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHwgNjAgKysrKysrKysrKysrKysrLS0tLS0tLQo+PiDCoCBhcmNoL3g4Ni9tbS9t
ZW1fZW5jcnlwdF9pZGVudGl0eS5jwqDCoMKgwqDCoMKgwqDCoCB8wqAgMyArLQo+PiDCoCBhcmNo
L3g4Ni9tbS9wYXQvc2V0X21lbW9yeS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAg
MyArLQo+PiDCoCBhcmNoL3g4Ni9wbGF0Zm9ybS9lZmkvZWZpXzY0LmPCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgIDkgKystLQo+PiDCoCBhcmNoL3g4Ni9yZWFsbW9kZS9pbml0LmPCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDggKy0tCj4+IMKgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuY8KgwqDCoCB8wqAgNCArLQo+PiDCoCBkcml2ZXJz
L2dwdS9kcm0vZHJtX2NhY2hlLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDQg
Ky0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL3Ztd2dmeC92bXdnZnhfZHJ2LmPCoMKgwqDCoMKgwqDC
oCB8wqAgNCArLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9tc2cuY8KgwqDC
oMKgwqDCoMKgIHzCoCA2ICstLQo+PiDCoCBkcml2ZXJzL2lvbW11L2FtZC9pbml0LmPCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDcgKy0tCj4+IMKgIGRyaXZlcnMvaW9t
bXUvYW1kL2lvbW11LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAzICst
Cj4+IMKgIGRyaXZlcnMvaW9tbXUvYW1kL2lvbW11X3YyLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHzCoCAzICstCj4+IMKgIGRyaXZlcnMvaW9tbXUvaW9tbXUuY8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMyArLQo+PiDCoCBmcy9wcm9jL3ZtY29y
ZS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqAgNiArLS0KPj4gwqAgaW5jbHVkZS9saW51eC9tZW1fZW5jcnlwdC5owqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoCA0IC0tCj4+IMKgIGluY2x1ZGUvbGludXgvcHJvdGVjdGVkX2d1
ZXN0LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMzcgKysrKysrKysrKysrKwo+PiDCoCBrZXJu
ZWwvZG1hL3N3aW90bGIuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoCA0ICstCj4+IMKgIDM2IGZpbGVzIGNoYW5nZWQsIDIxOCBpbnNlcnRpb25zKCspLCAx
MDQgZGVsZXRpb25zKC0pCj4+IMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Bvd2VycGMvaW5j
bHVkZS9hc20vcHJvdGVjdGVkX2d1ZXN0LmgKPj4gwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gv
eDg2L2luY2x1ZGUvYXNtL3Byb3RlY3RlZF9ndWVzdC5oCj4+IMKgIGNyZWF0ZSBtb2RlIDEwMDY0
NCBpbmNsdWRlL2xpbnV4L3Byb3RlY3RlZF9ndWVzdC5oCj4+Cj4gCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
