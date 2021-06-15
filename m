Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DCEC48BE5
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 18:14:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFD66611CE
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 18:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD66611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4A1383C15;
	Tue, 15 Jun 2021 18:14:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AqxAluPcR-pv; Tue, 15 Jun 2021 18:14:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9D74D83C11;
	Tue, 15 Jun 2021 18:14:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7ECBCC000D;
	Tue, 15 Jun 2021 18:14:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24059C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 18:14:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 044EB4015C
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 18:14:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=vmware.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LjMyE6l9PNdQ for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 18:14:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BF1C8400F3
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 18:14:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/JF1AoDtSztLh+TP8VK/PeNEsq7OFdEWo7esN5yTNCm8X1m4FwwmtcgVrCSPAPrYr2tsIFrIO71FZZWSW2U9VjNt/wCibxWe977tHUH35gRnPItXkdkRKebv5dJrlU4Yd1curohb7rsoKxqsT7HmxGiVyXzWYDEStMO/lsjj3iLE9CrGY+EBFZWbPvsRWfiqVSp0Nr9Q0foBonXoYNVW0XK4i/Yb6a6vpCbQ8ksRnw5UI2tBQ/n51XexYSfftVSWDXqMmOONCxiCRL38qwd/uLAr1OxYUw8Hn+FyK739YrUHp9QZ8J0kNrd8Ah9AwrBToptx+sajfFjWhh0VmEL4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W53djKQPlYqXofviLDLYdv7gZhoIp93R8+T9Ec13lDo=;
 b=FqhALyvi4f3/lHbLyUfCDpd3LrZPt0cSfsvIw3sqB10zRdJWBQerGutqYVsbWRJgeth3bhaAkn8WtjLvSDZlTejCZbsi9exIEiGJ8oP7/uWsjoe+HbFjBsOAFc0qumAawickQZi1icSMCXTb9q/1tYcXk6MmS+urCHgWX+eK7iyaEdUyx0aW9nX14LLTL5rc6plH4lNaamEzl9StMHFMORKsSuy8tKl4T5DfCXm9gb3LahExatBBA3P+Pu7fGqd81ebswD0FABS0c3fSu57D7ddsz3cnIz0DE8dAkfWwlg42V635JVjCbuXctpkTym1FybNt7Or3L5zo6h56jv4V2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W53djKQPlYqXofviLDLYdv7gZhoIp93R8+T9Ec13lDo=;
 b=mHeXrgQf6kBtThrpmw973L8CiOScvQatHWtuB5pPwz50CvjfxYi7Hai9qclF3W2nQb+oAeuvuGBI1K2UzNjPmwJAQZmFkqSbHkGVyDOushFIlY6evatepbfZA4VjdaA2PoSy+t65YxfhO7rxRd/fYtJHOJvNV1yaapf3wYo5g3c=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BYAPR05MB6246.namprd05.prod.outlook.com (2603:10b6:a03:aa::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.13; Tue, 15 Jun
 2021 18:14:20 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::1c28:6a3d:d0d6:42fd]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::1c28:6a3d:d0d6:42fd%3]) with mapi id 15.20.4242.016; Tue, 15 Jun 2021
 18:14:20 +0000
From: Nadav Amit <namit@vmware.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 5/6] iommu/amd: Tailored gather logic for AMD
Thread-Topic: [PATCH v3 5/6] iommu/amd: Tailored gather logic for AMD
Thread-Index: AQHXYeW3GskVSozHUEKdFx/6mi7fQKsVYLiA
Date: Tue, 15 Jun 2021 18:14:20 +0000
Message-ID: <7549686F-1F53-475D-950C-8F44A2165475@vmware.com>
References: <20210607182541.119756-1-namit@vmware.com>
 <20210607182541.119756-6-namit@vmware.com>
 <1913c012-e6c0-1d5e-01b3-5f6da367c6bd@arm.com>
In-Reply-To: <1913c012-e6c0-1d5e-01b3-5f6da367c6bd@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfbac5a7-185a-41a1-afa3-08d9302965b9
x-ms-traffictypediagnostic: BYAPR05MB6246:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB624670F82E999C6EDD4D9D0ED0309@BYAPR05MB6246.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MV8X/2sAaXM1lbCyUCXnC/ItLYhoR1v1kmouojOwj5j12GA+8XGoVz6XGhi+uAu1f7MWDLyNkwcJXFDbL6y5G9WD7uf6FVtfzkjGGwN3Y1MgZ+NyPofH+A5jqo9KkonZGr6yyuVbaiORJXDssdFQqEbQ8eHGr2KIlkq6Wvy9kJ9GBwM9FqDWeAHuVE9by7LNDIoUzjskmGyhjV5dewQ+ilKZLUWhS9eD2Fpq/UeK0rE/47AaPMGEC6nIucJrM4J9W5Qkd3KhMPJqUvWv3wVcQ0tqlw8floRFKViu6EsG2SrPS7K1Qw/Z97oeJ0F+b3V9B8vPzcztebLzh4B6ipq9QxlO8uMz7T1RhuNLtq4ZC/JmtJf+CkxafeqrcG925NXzlN7oEu40tNIvP5jj5Qziq8qkXIv31tE5xWNmMHGjLaK1ZnkwxDaLeevm6vxtBs4XE1+fMdW5L77tZr+twb/Sz/tWEBDvNfSiXsqS1fbwLeE0Ba609CDAWa5FGDdCbLQApEUo9nFU3Md/kbeGlIQQTGBj9ZxZ8KgPFghm+CgSTmW/sNmtfLoqZmwYoUvq0PZFm8qcyFN1pts2hGfiG6rZKm8cdGFPmWzfhRl0Q0HcAIEIRIjB3NgqlcKAjp6qs4isj8lD+lXzAD4k4oaofwCoC4YHjuPAXVXuckO8Cj8U6z/6jYbDjXJt6cqT4sasOeYRV91yYdt0+NhntNhlIncLag==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR05MB8531.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(6512007)(66946007)(316002)(6486002)(6916009)(71200400001)(76116006)(86362001)(478600001)(26005)(4326008)(186003)(54906003)(33656002)(2616005)(122000001)(83380400001)(5660300002)(38100700002)(53546011)(8676002)(6506007)(66556008)(8936002)(36756003)(64756008)(66446008)(66476007)(2906002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVRXZXhZOURBTUVVOVFhcmQzTEhSS0U0a3dmdzdPSUFsRE1nRk5jRk8rUkdQ?=
 =?utf-8?B?RVUxN3FLOFB4M1NtV3oyV2pjd09oc2JyVEd2bVYxM2I4UmNwNzh4ZWtHYkxm?=
 =?utf-8?B?ajhmK2tnS3Vwc3ZhZWUzcWZPMTJSSUtIcWRRVUdyMitydGdrUnhaMFRXdTBo?=
 =?utf-8?B?V3g3Rm5EcU5sN0JWaUg1aHAxOE5RbzJnSzhLL29ZZ2J2Sk9xWnlSckdBVUtP?=
 =?utf-8?B?TC9jaElNVE1PUWE5ZkZwem9haWt0eE9ZNnJKa1lobTV5VmRUY2hRSlhCM2V5?=
 =?utf-8?B?QVQ4SC9lNkVjRHpTNWVEbjNkWGhnQmMwTzFhRzNmNktyWnRuK1VPc2ZQUEhR?=
 =?utf-8?B?dmVOVmNjNCs2S0k1eDY1WGl1MXBXQ3I1bGFMV3JsSDc4Y0lIYkhSNlJRRFBR?=
 =?utf-8?B?QXhoYkMwamlPYzBvWjNpNzhXaFZkWjlXd09vMll0NjBmam4zT1plbXFYQTR4?=
 =?utf-8?B?WlY4bTlTN1czV2RJSlIyQlJ0dFlleTFuUUszNjhuc2pyQllyK3BlZFQ5Mmdk?=
 =?utf-8?B?REJvbzF0YnRaaElWWTBlTitqcTRnWTZoV0lsMkh4cU9odytRcnpHMmdzNVBi?=
 =?utf-8?B?cFFWMGlQWWF0akxWTEtRajRzUjZXMThPRHo3c2dlM3Z5SDRkbFQ5ZzJrZ3VD?=
 =?utf-8?B?a2IrNkhxK2tzM0NxWC9QTTlHZmtUQzZJZGRGdXdDUEtSc2ZWOW4yR0tTdCtG?=
 =?utf-8?B?OG93eWl0OXM4OVl2VHhIV0VpdkpzRkxVRmVJNWpUcGhRMHR3aldBZ01GcGZo?=
 =?utf-8?B?SFROTnlCbitROHdmekNPeWQ3L1IzSkh4M2kxQ2xRTC9NcUFjMWJMeVVUTG5u?=
 =?utf-8?B?U0JETFZQZ3gweVZEdXdXUjA4OXJiako4b3pidmtWQ2V1cU1WTVR1VktUZ1h2?=
 =?utf-8?B?USsvOTNJYXMvUHdSbFFRRDBJUVp1dWpLWk5ac2N6bHJ5TVc2RHNmZnpBTjIr?=
 =?utf-8?B?WDZIcVpsdUFYWmtYbisrVVh0aE4rQkxWUmtZck5rN0dwQnJrakJjVjl4dlRu?=
 =?utf-8?B?amF2aThtdjJja2RnZFRpRURpbUE1M2loVWNibXpNMUtDZjNqQlhLSjY4M2Q5?=
 =?utf-8?B?dkhkQ2xOV2NpUnVPRmJEbkp5a1NydE9GK2FsVUdkVStoR1JBdmZsSVU5c0Z6?=
 =?utf-8?B?S0VsOGV4ZmVIdXJGc082bTJpTW9ocnJoOWdNaHdtOFhLaUdTeWR6YzJwcjhv?=
 =?utf-8?B?cE9hc1dBV1UvRHh2MUhVcmlFSDVVRlBiQ0xQdHpnTlZvL1Q1b0dpZTZoTHdm?=
 =?utf-8?B?TDNlNmFQVGlXcTVQcWI2a0VTbWpOc001NlExUXBnMW1sZDRRUGNRL09EMWFO?=
 =?utf-8?B?QjdsQzI4Mnc4NG0wL1hmQXE2aStTUXJhSDFtNE9meVRhYzB4OWxQanNUUDhp?=
 =?utf-8?B?MURyWWlPc00vM1dxbndUQkZaMEs5UStUcnFDcURQTElyWkJOd0FiMDFNb00z?=
 =?utf-8?B?YzdNem9rVjMwU1NXSWlNQ2pjYzNTWXpSTEE3V29pOE53THNaeTNPMytGT1Zi?=
 =?utf-8?B?eUUwSHVSTGl0eFZQN3FPaXRNbGVMb1Y0bTFncUtuVkNEbk5ZYXVaa0hyeGhr?=
 =?utf-8?B?VDNqTzBNT0VvWG1iUGlmUysvNzF0aGZTN3FGSVBXNU1TMHNyQlBnai8vZXJV?=
 =?utf-8?B?OVZHcEV1bGV5R0tiUkdsRXRtZGlzVTQyNnA1c0dlM3RyRWNmQk50MzF3Ymo3?=
 =?utf-8?B?MUNDTndXRG5UQlh4SzFoaTF6ak43TnFTQVlTS2dOL2ZDeEFIWXl4MGp6Z0Z0?=
 =?utf-8?Q?KTECFvEv0JO02n3+vFx9nDX7ACFnjHeIrpF8vw1?=
Content-ID: <FD67C2C9587D23468FD29F28FB4EDF64@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbac5a7-185a-41a1-afa3-08d9302965b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 18:14:20.6891 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cJE/iMlJnkoVBFHks3bxI/NHmRmFVawW+53Y/ik8e2LjhEtvGkfZ4rNjHhb8W/tlfJA5r/V7IPMbCSnKrD5lkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6246
Cc: Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jiajun Cao <caojiajun@vmware.com>
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

DQoNCj4gT24gSnVuIDE1LCAyMDIxLCBhdCA1OjU1IEFNLCBSb2JpbiBNdXJwaHkgPHJvYmluLm11
cnBoeUBhcm0uY29tPiB3cm90ZToNCj4gDQo+IE9uIDIwMjEtMDYtMDcgMTk6MjUsIE5hZGF2IEFt
aXQgd3JvdGU6DQo+PiBGcm9tOiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPg0KPj4gQU1E
J3MgSU9NTVUgY2FuIGZsdXNoIGVmZmljaWVudGx5IChpLmUuLCBpbiBhIHNpbmdsZSBmbHVzaCkg
YW55IHJhbmdlLg0KPj4gVGhpcyBpcyBpbiBjb250cmFzdCwgZm9yIGluc3RuYWNlLCB0byBJbnRl
bCBJT01NVXMgdGhhdCBoYXZlIGEgbGltaXQgb24NCj4+IHRoZSBudW1iZXIgb2YgcGFnZXMgdGhh
dCBjYW4gYmUgZmx1c2hlZCBpbiBhIHNpbmdsZSBmbHVzaC4gIEluIGFkZGl0aW9uLA0KPj4gQU1E
J3MgSU9NTVUgZG8gbm90IGNhcmUgYWJvdXQgdGhlIHBhZ2Utc2l6ZSwgc28gY2hhbmdlcyBvZiB0
aGUgcGFnZSBzaXplDQo+PiBkbyBub3QgbmVlZCB0byB0cmlnZ2VyIGEgVExCIGZsdXNoLg0KPj4g
U28gaW4gbW9zdCBjYXNlcywgYSBUTEIgZmx1c2ggZHVlIHRvIGRpc2pvaW50IHJhbmdlIG9yIHBh
Z2Utc2l6ZSBjaGFuZ2VzDQo+PiBhcmUgbm90IG5lZWRlZCBmb3IgQU1ELiBZZXQsIHZJT01NVXMg
cmVxdWlyZSB0aGUgaHlwZXJ2aXNvciB0bw0KPj4gc3luY2hyb25pemUgdGhlIHZpcnR1YWxpemVk
IElPTU1VJ3MgUFRFcyB3aXRoIHRoZSBwaHlzaWNhbCBvbmVzLiBUaGlzDQo+PiBwcm9jZXNzIGlu
ZHVjZSBvdmVyaGVhZHMsIHNvIGl0IGlzIGJldHRlciBub3QgdG8gY2F1c2UgdW5uZWNlc3NhcnkN
Cj4+IGZsdXNoZXMsIGkuZS4sIGZsdXNoZXMgb2YgUFRFcyB0aGF0IHdlcmUgbm90IG1vZGlmaWVk
Lg0KPj4gSW1wbGVtZW50IGFuZCB1c2UgYW1kX2lvbW11X2lvdGxiX2dhdGhlcl9hZGRfcGFnZSgp
IGFuZCB1c2UgaXQgaW5zdGVhZA0KPj4gb2YgdGhlIGdlbmVyaWMgaW9tbXVfaW90bGJfZ2F0aGVy
X2FkZF9wYWdlKCkuIElnbm9yZSBwYWdlLXNpemUgY2hhbmdlcw0KPj4gYW5kIGRpc2pvaW50IHJl
Z2lvbnMgdW5sZXNzICJub24tcHJlc2VudCBjYWNoZSIgZmVhdHVyZSBpcyByZXBvcnRlZCBieQ0K
Pj4gdGhlIElPTU1VIGNhcGFiaWxpdGllcywgYXMgdGhpcyBpcyBhbiBpbmRpY2F0aW9uIHdlIGFy
ZSBydW5uaW5nIG9uIGENCj4+IHBoeXNpY2FsIElPTU1VLiBBIHNpbWlsYXIgaW5kaWNhdGlvbiBp
cyB1c2VkIGJ5IFZULWQgKHNlZSAiY2FjaGluZw0KPj4gbW9kZSIpLiBUaGUgbmV3IGxvZ2ljIHJl
dGFpbnMgdGhlIHNhbWUgZmx1c2hpbmcgYmVoYXZpb3IgdGhhdCB3ZSBoYWQNCj4+IGJlZm9yZSB0
aGUgaW50cm9kdWN0aW9uIG9mIHBhZ2Utc2VsZWN0aXZlIElPVExCIGZsdXNoZXMgZm9yIEFNRC4N
Cj4+IE9uIHZpcnR1YWxpemVkIGVudmlyb25tZW50cywgY2hlY2sgaWYgdGhlIG5ld2x5IGZsdXNo
ZWQgcmVnaW9uIGFuZCB0aGUNCj4+IGdhdGhlcmVkIG9uZSBhcmUgZGlzam9pbnQgYW5kIGZsdXNo
IGlmIGl0IGlzLiBBbHNvIGNoZWNrIHdoZXRoZXIgdGhlIG5ldw0KPj4gcmVnaW9uIHdvdWxkIGNh
dXNlIElPVExCIGludmFsaWRhdGlvbiBvZiBsYXJnZSByZWdpb24gdGhhdCB3b3VsZCBpbmNsdWRl
DQo+PiB1bm1vZGlmaWVkIFBURS4gVGhlIGxhdHRlciBjaGVjayBpcyBkb25lIGFjY29yZGluZyB0
byB0aGUgIm9yZGVyIiBvZiB0aGUNCj4+IElPVExCIGZsdXNoLg0KPiANCj4gSWYgaXQgaGVscHMs
DQo+IA0KPiBSZXZpZXdlZC1ieTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4N
Cg0KVGhhbmtzIQ0KDQoNCj4gSSB3b25kZXIgaWYgaXQgbWlnaHQgYmUgbW9yZSBlZmZlY3RpdmUg
dG8gZGVmZXIgdGhlIGFsaWdubWVudC1iYXNlZCBzcGxpdHRpbmcgcGFydCB0byBhbWRfaW9tbXVf
aW90bGJfc3luYygpIGl0c2VsZiwgYnV0IHRoYXQgY291bGQgYmUgaW52ZXN0aWdhdGVkIGFzIGFu
b3RoZXIgZm9sbG93LXVwLg0KDQpOb3RlIHRoYXQgdGhlIGFsaWdubWVudC1iYXNlZCBzcGxpdHRp
bmcgaXMgb25seSB1c2VkIGZvciB2aXJ0dWFsaXplZCBBTUQgSU9NTVVzLCBzbyBpdCBoYXMgbm8g
aW1wYWN0IGZvciBtb3N0IHVzZXJzLg0KDQpSaWdodCBub3csIHRoZSBwZXJmb3JtYW5jZSBpcyBr
aW5kIG9mIGJhZCBvbiBWTXMgc2luY2UgQU1E4oCZcyBJT01NVSBkcml2ZXIgZG9lcyBhIGZ1bGwg
SU9UTEIgZmx1c2ggd2hlbmV2ZXIgaXQgdW5tYXBzIG1vcmUgdGhhbiBhIHNpbmdsZSBwYWdlLiBT
bywgYWx0aG91Z2ggeW91ciBpZGVhIG1ha2VzIHNlbnNlLCBJIGRvIG5vdCBrbm93IGV4YWN0bHkg
aG93IHRvIGltcGxlbWVudCBpdCByaWdodCBub3csIGFuZCByZWdhcmRsZXNzIGl0IGlzIGxpa2Vs
eSB0byBwcm92aWRlIG11Y2ggbG93ZXIgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnRzIHRoYW4gdGhv
c2UgdGhhdCBhdm9pZGluZyBmdWxsIElPVExCIGZsdXNoZXMgd291bGQuDQoNCkhhdmluZyBzYWlk
IHRoYXQsIGlmIEkgZmlndXJlIG91dCBhIHdheSB0byBpbXBsZW1lbnQgaXQsIEkgd291bGQgZ2l2
ZSBpdCBhIHRyeSAoYWx0aG91Z2ggSSBhbSBhZG1pdHRlZGx5IGFmcmFpZCBvZiBhIGNvbXBsaWNh
dGVkIGxvZ2ljIHRoYXQgbWlnaHQgY2F1c2Ugc3VidGxlLCBtb3N0bHkgdW5kZXRlY3RhYmxlIGJ1
Z3MpLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
