Return-Path: <SRS0=GTcZ=FL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18104C4361B
	for <iommu@archiver.kernel.org>; Mon,  7 Dec 2020 22:20:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9946B23976
	for <iommu@archiver.kernel.org>; Mon,  7 Dec 2020 22:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9946B23976
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 496388721E;
	Mon,  7 Dec 2020 22:20:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Blr6I-8OnSL7; Mon,  7 Dec 2020 22:20:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9F72B870FB;
	Mon,  7 Dec 2020 22:20:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84F59C0FA7;
	Mon,  7 Dec 2020 22:20:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 664CBC013B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 22:20:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 60E3587987
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 22:20:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9z+YkF6Rx9VW for <iommu@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 22:20:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 40CA387983
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 22:20:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SitXOdDDoDC4dYMZp98DLVgfB+WHl0X1IM8FUe9FP2V9jkKyGxN/DjMJAcryJNmzu2xH+g/Ru4fYz2RXBSX6eLS9CiTs5+XrFx9r1jw7X5ETo0FDIqrexybeaaLpZm9CDR4tTdnoG2riXNUX5IjC0E1BLKQ0cxpkQVKLLFilDL8yxSaTXJhGej8uVK5hmgD8JwokG1aDGz46VQvnZOcKP1CnnmjeO6Pu5Ao0NqOyvQcDWuJHQZlbzPy88zJNa4aibmhIXsfBSZ2PV0jvrcK6YPftd7OhK/p0c75iY6Q9U1jinYBEIk79au9qBOk6DXgtkwbTtqddHVb+P3TuPUUrgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K03og3SnhegWj4PSPPPz5JDEG9HLiTivWCPKuqp3jS8=;
 b=Z0U9TKO3Y+G+UvJ0mZYyrY0rLIl1kW06gx/6RbeG9oAJAEQ+Z/xNfDYJhpDI3rk+cj9TmlLXL0g+ZHQu237k/235IqRiFttzuzrmPgg4DOezplorNOCG5NHtrSi6d5k1486IguDIYxgLOkTK7dUgDO4SdcS0CGQAaSUHeSZjbG9gsNdhVk9mEJ6tg1qHxaFB6vJfW33uP3x+yH5YvnI0jBqp2esqf2m01j/DX/uQJfvlDHNUCIXVgThn+7SdPZrPGnF8dg7B5G5CG5cuQq3U/yp5T5mT6d7NXIWYMap8LtRCruf2V+HGNlq4DFR//9XbMd7rTzBbxe4qa9xg1hG2HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K03og3SnhegWj4PSPPPz5JDEG9HLiTivWCPKuqp3jS8=;
 b=fvmQFv86n1HKsk+QUdv/uhHPpCPCDrmtHimuCmUyTNSaHDC4pUzm/rYjqIrOek3fpSXYebMg8KdFTUVdbF50CfdPK/wgyZFhxx54NKfsVE0FlZFsaowq+pb5NWbSCp7+lJH8wrfCOS/Duga41rluHQYmj9LgJG+p5pTsx9OY6K4=
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Mon, 7 Dec
 2020 22:20:21 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec%3]) with mapi id 15.20.3632.021; Mon, 7 Dec 2020
 22:20:21 +0000
From: "Kalra, Ashish" <Ashish.Kalra@amd.com>
To: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Thread-Topic: [PATCH v7] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Thread-Index: AQHWySQLBB68k2x6+UCJ0Df9iPf5sanrkYWAgACmmgCAAAJHgIAAAZ75
Date: Mon, 7 Dec 2020 22:20:20 +0000
Message-ID: <60FF61F4-9A7D-4467-A148-2956903C74AA@amd.com>
References: <20201203032559.3388-1-Ashish.Kalra@amd.com>
 <20201207121007.GD20489@zn.tnic>
 <20201207220624.GB6855@ashkalra_ubuntu_server>,
 <20201207221433.GI20489@zn.tnic>
In-Reply-To: <20201207221433.GI20489@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [136.49.12.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 855eebd5-b12c-4021-cadf-08d89afe4904
x-ms-traffictypediagnostic: SA0PR12MB4384:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR12MB4384CAB5E4F07BD8DE47F3318ECE0@SA0PR12MB4384.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hoqjZua6jk3FksFKlbZNH3whBoqFW1ZmvyS/qkTBgdIXGH1qtozzBZTKqRtHVO9qxLrc5MvdsB7GrekZP7QBNBYokKlKFNxLnCBLPK6TbcGEKD0On9RU0kQld0TZxp1/fvDklFHGA7JiFOfAolBW7dCyNiimpp00pEI+26uG+7UyMvCkxaj+nk4q7REZBEHltmuTk4HgKknGIniY/WnhFqVOVT5ne+s97YokDyLtniAK8RMt1JLzkAeiK9Rs+8bbm3AjSmMFgYsx8IzYnzDLyQLq0/iPmUUY+N0CADeL9k61VGNgB7Kqzs4LcLrjsktpwC/SPTPGPwX1y4DmpWCBoAgB8faXeV56S4HSFjgChNQ/Vtw+venFGE+XqoYSHcag
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(8936002)(6512007)(36756003)(2906002)(478600001)(316002)(4744005)(33656002)(5660300002)(86362001)(54906003)(186003)(2616005)(4326008)(66556008)(26005)(66476007)(8676002)(6916009)(53546011)(71200400001)(76116006)(66946007)(6506007)(66446008)(7416002)(6486002)(64756008)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?c3BUTTg4SlcrOUNIL2RUNitHTjZOamR3RXVjSkpmS0RzQTExL2hSTFR5QjNi?=
 =?utf-8?B?Q2lOQng0N0UzTHZPZzR5b2QvU25JaWlFMjVaUEpJTkdMdG5idVNGMnVxU1Qy?=
 =?utf-8?B?bXlYSTFaSmROS2ZBc1NOK2pFT2lkMjgzaHUzNXVVdWxyUnh1NFZHN0xqMEl5?=
 =?utf-8?B?UitsUnRGdGV4ZHZ4eXhKcE5LakFVSnBDSGF4aHdaNk9ZMWk0Z05sMXEvYWZy?=
 =?utf-8?B?WS82d2QyNW1qbGpUN1IwZWhiZHJLQThVWWQ1a1BPZGpIOUF5ckpoUWhUSUkr?=
 =?utf-8?B?NmxtWHg0SjNrTjZtaEdvSFVjTCtoR21PNXMzNEVESHNkczYrdHIxMGRxUFYr?=
 =?utf-8?B?czNUeDVzM0crMHQrYjJVa3N5OGFTb2xjSVltKzd6NUcxZlN3REF4all1MHR2?=
 =?utf-8?B?VkVycFpzMytLOU9obHpSaVNMaDNENEQwK1hVQk1FZ0hGZi9JamRtT1owbFdk?=
 =?utf-8?B?QVRjQXluUm80dXZqZWJHR0ZuV0xSSG50ME5SbDFaOUt4bzc5eGZlWWhiM2lM?=
 =?utf-8?B?WHpsUkRzNG10M091MEV3RUVrRzNZRlYrRG5VeWxIZTNNNnEwWmxxRnBZRnFQ?=
 =?utf-8?B?YkpUTGxvcDB1aEluMW1pTFhrYjFCVHAyeDVFTTdUejBUNkdpMDV4RkFuakZx?=
 =?utf-8?B?WTN2c1Z0VDgvY3dxVVhLRUoxRElEeVVkWm1FSHpqYWpsa3J5NW42V1ZwSzBM?=
 =?utf-8?B?WXVQdnBZL0tvK0N1OVJJWGpWSUFITndyRUJCMGQ5cjllYTR3VVhoNzJTaXY2?=
 =?utf-8?B?NTArTThZekRjSVJwelpiS1JTUGxmWVF2a0xMaUNNVzZkVmJSWEdXalRLL2JN?=
 =?utf-8?B?a29YVzNDcE5TMG4vRHh3ZmUwYlFWdm1JQm94ajE5NWNMOG4yeEhIL09MVmdp?=
 =?utf-8?B?REdLSkhlbjdUWmFFQ045MUh1blQ5b3VXbWROL2RjWk5pajNTMHNwR25PSUJi?=
 =?utf-8?B?aCtXS0lGempTbkY2Mm54NUVrUnpja0pvZUtTWExZU3NJQklON1hxUlZ6aCtM?=
 =?utf-8?B?d2xzZ1IrYnovRkljdVBMWFhUUVFKcm10OWlzbkxYNkhYaVJoMEl6UkxRYmJI?=
 =?utf-8?B?M3NQQit1eXBZZzBNcXdFNlZOdHEyOVpZOXhpRFZxa3B2WU1XRUJCcG03K2NW?=
 =?utf-8?B?aVNIMlZVQnllSGp1QmJORlZPeUw4Z2lucDg2amdleUdKcjBsdmtGQW15Q1du?=
 =?utf-8?B?L25kTDBPTG1ralFOUjYwZCt0YW13RHdvZlhlSmV4YnljUkF5cjhneEVTZlV6?=
 =?utf-8?B?QUg3OFlWa3hLSktVMUxMbGV1QnBYc0tVOHlLaGZKbE9kRU1mTDg2eVhpNmhI?=
 =?utf-8?Q?vwnZNHkTbJqUE=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 855eebd5-b12c-4021-cadf-08d89afe4904
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 22:20:20.9507 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xPGQZPXI1+4SnzF0QUcgad+io5MYPDfxK70xXZjJgZNcut4HvbWBINrC59ArYpu97e3zfcipmXqOeEe7zT2i7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Grimm,
 Jon" <Jon.Grimm@amd.com>, "Singh, Brijesh" <brijesh.singh@amd.com>,
 "dave.hansen@linux-intel.com" <dave.hansen@linux-intel.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "luto@kernel.org" <luto@kernel.org>,
 "hpa@zytor.com" <hpa@zytor.com>, "rientjes@google.com" <rientjes@google.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "hch@lst.de" <hch@lst.de>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

DQoNCj4gT24gRGVjIDcsIDIwMjAsIGF0IDQ6MTQgUE0sIEJvcmlzbGF2IFBldGtvdiA8YnBAYWxp
ZW44LmRlPiB3cm90ZToNCj4gDQo+IO+7v09uIE1vbiwgRGVjIDA3LCAyMDIwIGF0IDEwOjA2OjI0
UE0gKzAwMDAsIEFzaGlzaCBLYWxyYSB3cm90ZToNCj4+IFRoaXMgaXMgcmVsYXRlZCB0byB0aGUg
ZWFybGllciBzdGF0aWMgYWRqdXN0bWVudCBvZiB0aGUgU1dJT1RMQiBidWZmZXJzDQo+PiBhcyBw
ZXIgZ3Vlc3QgbWVtb3J5IHNpemUgYW5kIEtvbnJhZCdzIGZlZWRiYWNrIG9uIHRoZSBzYW1lLCBh
cyBjb3BpZWQNCj4+IGJlbG93IDogDQo+PiANCj4+Pj4gVGhhdCBpcyBlYXRpbmcgMTI4TUIgZm9y
IDFHQiwgYWthIDEyJSBvZiB0aGUgZ3Vlc3QgbWVtb3J5IGFsbG9jYXRlZCBzdGF0aWNhbGx5IGZv
ciB0aGlzLg0KPj4+PiANCj4+Pj4gQW5kIGZvciBndWVzdHMgdGhhdCBhcmUgMkdCLCB0aGF0IGlz
IDEyJSB1bnRpbCBpdCBnZXRzIHRvIDNHQiB3aGVuIA0KPj4+PiBpdCBpcyA4JSBhbmQgdGhlbiA2
JSBhdCA0R0IuDQo+Pj4+IA0KPj4+PiBJIHdvdWxkIHByZWZlciB0aGlzIHRvIGJlIGJhc2VkIG9u
IHlvdXIgbWVtb3J5IGNvdW50LCB0aGF0IGlzIDYlIG9mIA0KPj4+PiB0b3RhbCBtZW1vcnkuDQo+
IA0KPiBTbyBubyBydWxlIG9mIHRodW1iIGFuZCBubyBtZWFzdXJlbWVudHM/IEp1c3QgYSBtYWdp
YyBudW1iZXIgNi4NCg0KSXQgaXMgbW9yZSBvZiBhbiBhcHByb3hpbWF0aW9uIG9mIHRoZSBlYXJs
aWVyIHN0YXRpYyBhZGp1c3RtZW50IHdoaWNoIHdhcyAxMjhNIGZvciA8MUcgZ3Vlc3RzLCAyNTZN
IGZvciAxRy00RyBndWVzdHMgYW5kIDUxMk0gZm9yID40RyBndWVzdHMuDQoNClRoYW5rcywNCkFz
aGlzaApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
