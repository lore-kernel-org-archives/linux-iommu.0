Return-Path: <SRS0=z3hi=EK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25403C2D0A3
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 14:35:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E27C20709
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 14:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emerson.onmicrosoft.com header.i=@emerson.onmicrosoft.com header.b="JBmDpizU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E27C20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emerson.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F2DFE8722E;
	Wed,  4 Nov 2020 14:35:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WaNDO6l9W1or; Wed,  4 Nov 2020 14:35:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2FB72871F1;
	Wed,  4 Nov 2020 14:35:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0003FC088B;
	Wed,  4 Nov 2020 14:35:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BD40C0051
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 14:35:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 673748573E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 14:35:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DMfi0w+m23lp for <iommu@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 14:35:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-00300601.pphosted.com (mx0a-00300601.pphosted.com
 [148.163.146.64])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 73FF185620
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 14:35:54 +0000 (UTC)
Received: from pps.filterd (m0142705.ppops.net [127.0.0.1])
 by mx0b-00300601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0A4EXccU001968; Wed, 4 Nov 2020 14:35:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
 by mx0b-00300601.pphosted.com with ESMTP id 34kwg3rt4x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Nov 2020 14:35:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+RYd5QtDxmOFAaJgq/MchjDltvFUDsix7RwA1sFI1MHhcLnxc7olF76XsUK2hqoZxzRfesihk283zpC2IyvYRPsuU+NZe/hBhkklGJrg7yqNt5ppqCFkGn+2MYGuAdkzXAW4K7iHJjhNC9WT91MHeltqdETCXJX6tVWn/qoHgCZNsbtpQJWEWEnMgYRL5cbSbqZbb7D4yLR73ZiBfnxRo3u2TfPnJRu1H8cWb2npqACMUW5p/8ZCGZttOwRI2ktvOhqPEIpZJi9XSlE7Y/KdwdMvXv3Ai803rwRJ/oyBskv3zvguB9xXDnRsSLa3aMP/aFMIDVknb76L1+OuqKC5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXHP5VB1JoDdVMrCnHqLk3uoOPOuf4PRbzGM84pZEiE=;
 b=fodoYelY2Ee/sPiyNAk+1ks3YFVsHuT2u4RBokLmqwBnz8FVVlWqiSM4836kbNl7GLXmCXSUOP1DyCfwYqtnllFa3nL8JhzCi0PeKek5X1cRQN0AAoNNDUw2uuAOuFdap+ygg8DlmnpW4RP0xBN3CvdQWuEgEcw1I3VKFZscShi7nifuoyE333m1X+VQ5wdJXj8i6N4zh1P4IzDb4qZmqyZkQGK+UbNtdLNf/4c1ag42XU4/Z9OAPHFwXkXJ2mewqMpnevnXwp97r202T5NSRpjae0SpASltqpu/jOqrPteNjRJP4NeXmQp+c3Ydfvy5g9WtPF+S9J+B3yobDOgKSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emerson.com; dmarc=pass action=none header.from=emerson.com;
 dkim=pass header.d=emerson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emerson.onmicrosoft.com; s=selector2-emerson-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXHP5VB1JoDdVMrCnHqLk3uoOPOuf4PRbzGM84pZEiE=;
 b=JBmDpizUXvGm1k3tIiY50I47N6rj4h+WyF2aGKSAoKdj1ePp1cSmi8cs9/lQXVIEYvqclG3UFydbqFXTgylN1e47jBM5k/o++b8g1Ft/nMrrDCoilUGlL6tBNkaJ2o5NRvcSaOK4PyiR7gVkNbUkH64kfk0/HNJhJPk70cPHPpI=
Received: from MWHPR10MB1310.namprd10.prod.outlook.com (2603:10b6:300:21::18)
 by CO1PR10MB4563.namprd10.prod.outlook.com (2603:10b6:303:92::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.22; Wed, 4 Nov
 2020 14:35:52 +0000
Received: from MWHPR10MB1310.namprd10.prod.outlook.com
 ([fe80::d85:aa30:739f:496e]) by MWHPR10MB1310.namprd10.prod.outlook.com
 ([fe80::d85:aa30:739f:496e%12]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 14:35:52 +0000
From: "Merger, Edgar [AUTOSOL/MAS/AUGS]" <Edgar.Merger@emerson.com>
To: "jroedel@suse.de" <jroedel@suse.de>
Subject: RE: [EXTERNAL] Re: amdgpu error whenever IOMMU is enabled
Thread-Topic: [EXTERNAL] Re: amdgpu error whenever IOMMU is enabled
Thread-Index: Adaux7yL4OYKNrMETgKrPGK8SdhnWADwCzYAAADVBeAAAgZUAAAHYTJQAAGocXA=
Date: Wed, 4 Nov 2020 14:35:52 +0000
Message-ID: <MWHPR10MB13106AFEA3B68E666DD9CA6089EF0@MWHPR10MB1310.namprd10.prod.outlook.com>
References: <MWHPR10MB1310CDB6829DDCF5EA84A14689150@MWHPR10MB1310.namprd10.prod.outlook.com>
 <20201104085306.GQ22179@suse.de>
 <MWHPR10MB13109574BDA0F1D8219A225C89EF0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <20201104101454.GR22179@suse.de>
 <MWHPR10MB13108FAFDAD3D33132B6593489EF0@MWHPR10MB1310.namprd10.prod.outlook.com>
In-Reply-To: <MWHPR10MB13108FAFDAD3D33132B6593489EF0@MWHPR10MB1310.namprd10.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=emerson.com;
x-originating-ip: [2a00:79c0:760:a700:b1aa:e7d7:75af:e80e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e2ba779-2e1c-44b6-af60-08d880ceeea0
x-ms-traffictypediagnostic: CO1PR10MB4563:
x-microsoft-antispam-prvs: <CO1PR10MB4563DBB7044AADF1EC942FBA89EF0@CO1PR10MB4563.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PboNf0hMfpR79q/q7n9qE83/WhFkBqFkGQfjkRr0i2btS5NWmW8Fz0fV7bhWKqjTpL0wh6CJ8DmhywTTLv/PGzIdOSCbsO3Ykto8q8GBPxWjtAWettRxlA95mRE0kchHpPI9ZO/cWomDYnhrob7tgJd1cuMYaS4evpets+MMOkGIeSESqQm8wCDjZluhjnbxl3iRWwa5RQ8LI00rC96GZzlNsJ7m7wSiY1fA38CqijtliRPT5LugScI3DJW221KqPlJDgfNxaHXldnQ84xJJpxmy5G7qRCrefjfT/Bm5HUGTwPfPGadbm/ohk5YBOZoXR9jhZUeKxBCPkic2y2vRIg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR10MB1310.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(346002)(396003)(376002)(136003)(39860400002)(71200400001)(52536014)(66946007)(66446008)(5660300002)(64756008)(66476007)(83380400001)(33656002)(66556008)(76116006)(9686003)(6916009)(316002)(86362001)(4326008)(6506007)(53546011)(55016002)(7696005)(2940100002)(8936002)(478600001)(8676002)(186003)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: FIYfPvkg4C59oyRLxeqiSzDhfHyiIrFtaIvhO6K4+fifiajhpy7Gze53cP+bApPoMGBYXfImguPkXPIAuhvYlNwr6LeAiPyyGe5cGsW4PwUZBC5weixli4VdhLfrEkSsr2TEanXDib0+y0Ajj9P7wRQrEZoRklegE7E7jVCyvM2SHpmwTXurSrw23dFIHg+I5npC23IBfsJW2PRUBqIrZHzKy0/EeWfU6t+y16yA5hOPA5eHgsG7suvoYoaBvLeqp74fiD30z6tMYNQWFKeJKM+dby6PIhoDcx5EICZw9j6xJ7Usd8MVFu2xYRpIGoNWjlWMEeB6WrxbiZnBcBUwtRZJGksALT8OqalCpafdMmorzv5fVPbB36UqtiiGdbSHkR5yn/XIeIU05sj/gJOMBgE9KhnzpjmHgjkB7lMVpKmtM+PXIdq+WNPabLnvAwe96FiHiibIpg6AcoS6XdTl8g7Xgx0Ytn90eeI+geA3iKkCPFTH5uQgHIMA7idaznqaI9XZ102nKaA0YZ4htkQ9udl/taj2LdDeFJXCg6aBl8IrJTgHgE/OiNfblwS4ycwkXi7u1hgoT8m9jKmRrzoapd4mOjUzhqDpMHLWcVpWoONMQtYJeIxJRSE+UBQHK7DqbYK4f4rXtOYxqNveZq+ALObgqQ3wfcSbAzGM4kq75FLt5YMekoA6sRhf24CI7WqNEoYKuX2T7UU5KplOCPvlbg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Emerson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1310.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2ba779-2e1c-44b6-af60-08d880ceeea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 14:35:52.6752 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eb06985d-06ca-4a17-81da-629ab99f6505
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: frO7YXKopR70ZMuo4+Ai5dfxcMgsgAx9FQAfZO7s6Jh8Dvy3W5oBPpIcK5stso+FT4blvpEM9/J3r1sFgyq9Vxyt20jjT+jXGNL9pQ7wtSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4563
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-04_08:2020-11-04,
 2020-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040109
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

Sm9lcmcsDQoNCk9uZSByZW1hcms6IA0KPiBIb3dldmVyIEkgZm91bmQgb3V0IHRoYXQgd2l0aCBL
ZXJuZWwgNS45LjMgdGhlIGFtZGdwdSBrZXJuZWwgbW9kdWxlIGlzIG5vdCBsb2FkZWQvaW5zdGFs
bGVkDQpUaGF0IGlzIGxpa2VseSBteSBmYXVsdCBiZWNhdXNlIEkgd2FzIGNvbXBpbGluZyB0aGF0
IGxpbnV4IGtlcm5lbCBvbiBhIGZhc3RlciBtYWNoaW5lIChWMTgwN0IgQ1BVIGFnYWluc3QgUjEz
MDVHIENQVSAodGFyZ2V0KSkuIEkgcmVzdGFydGVkIHRoYXQgY29tcGlsZSBqdXN0IG5vdyBvbiB0
aGUgdGFyZ2V0IG1hY2hpbmUgdG8gYXZvaWQgYW55IHByb2JsZW1zLg0KDQpCZXN0IHJlZ2FyZHMs
DQpFZGdhcg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTWVyZ2VyLCBFZGdh
ciBbQVVUT1NPTC9NQVMvQVVHU10gDQpTZW50OiBNaXR0d29jaCwgNC4gTm92ZW1iZXIgMjAyMCAx
NToxOQ0KVG86IGpyb2VkZWxAc3VzZS5kZQ0KQ2M6IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnDQpTdWJqZWN0OiBSRTogW0VYVEVSTkFMXSBSZTogYW1kZ3B1IGVycm9yIHdoZW5ldmVy
IElPTU1VIGlzIGVuYWJsZWQNCg0KPiBZZXMsIGJ1dCBpdCBjb3VsZCBiZSB0aGUgc2FtZSB1bmRl
cmx5aW5nIHJlYXNvbi4NClRoZXJlIGlzIG5vIFBDSSBzZXR1cCBpc3N1ZSB0aGF0IHdlIGFyZSBh
d2FyZSBvZi4NCg0KPiBGb3IgYSBmaXJzdCB0cnksIHVzZSA1LjkuMy4gSWYgaXQgcmVwcm9kdWNl
cyB0aGVyZSwgcGxlYXNlIHRyeSBib290aW5nIHdpdGggInBjaT1ub2F0cyIgb24gdGhlIGtlcm5l
bCBjb21tYW5kIGxpbmUuDQpEaWQgY29tcGlsZSB0aGUga2VybmVsIDUuOS4zIGFuZCBzdGFydGVk
IGEgcmVib290IHRlc3QgdG8gc2VlIGlmIGl0IGlzIGdvaW5nIHRvIGZhaWwgYWdhaW4uIEhvd2V2
ZXIgSSBmb3VuZCBvdXQgdGhhdCB3aXRoIEtlcm5lbCA1LjkuMyB0aGUgYW1kZ3B1IGtlcm5lbCBt
b2R1bGUgaXMgbm90IGxvYWRlZC9pbnN0YWxsZWQuIFNvIHRoaXMgd2F5IEkgZG9uwrR0IHNlZSBp
dCBtYWtlcyBzZW5zZSBmb3IgZnVydGhlciBpbnZlc3RpZ2F0aW9uLiBJIG1pZ2h0IGRpZCBzb21l
dGhpbmcgd3Jvbmcgd2hlbiBjb21waWxpbmcgdGhlIGxpbnV4IGtlcm5lbCA1LjkuMy4gSSBkaWQg
cmV1c2UgbXkgLmNvbmZpZyBmaWxlIHRoYXQgSSB1c2VkIHdpdGggNS40LjAtNDcgZm9yIGNvbmZp
Z3VyYXRpb24gb2YgdGhlIGtlcm5lbCA1LjkuMy4gSG93ZXZlciBJIGRvIG5vdCBrbm93IHdoeSBp
dCBkaWQgbm90IGluc3RhbGwgYW1kZ3B1Lg0KDQo+IFBsZWFzZSBhbHNvIHNlbmQgbWUgdGhlIG91
dHB1dCBvZiAnbHNwY2kgLXZ2dicgYW5kICdsc3BjaSAtdCcgb2YgdGhlIG1hY2hpbmUgd2hlcmUg
dGhpcyBoYXBwZW5zLg0KRm9yIGNvbXBhcmlzb24gSSBhdHRhY2hlZCB0aGUgbG9ncyB3aGVuIHVz
aW5nIDUuNC4wLTQ3IGFuZCA1LjkuMy4gDQoNCkJlc3QgcmVnYXJkcywNCkVkZ2FyDQoNCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBqcm9lZGVsQHN1c2UuZGUgPGpyb2VkZWxAc3Vz
ZS5kZT4NClNlbnQ6IE1pdHR3b2NoLCA0LiBOb3ZlbWJlciAyMDIwIDExOjE1DQpUbzogTWVyZ2Vy
LCBFZGdhciBbQVVUT1NPTC9NQVMvQVVHU10gPEVkZ2FyLk1lcmdlckBlbWVyc29uLmNvbT4NCkNj
OiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZw0KU3ViamVjdDogUmU6IFtFWFRFUk5B
TF0gUmU6IGFtZGdwdSBlcnJvciB3aGVuZXZlciBJT01NVSBpcyBlbmFibGVkDQoNCk9uIFdlZCwg
Tm92IDA0LCAyMDIwIGF0IDA5OjIxOjM1QU0gKzAwMDAsIE1lcmdlciwgRWRnYXIgW0FVVE9TT0wv
TUFTL0FVR1NdIHdyb3RlOg0KPiBBTUQtVmk6IENvbXBsZXRpb24tV2FpdCBsb29wIHRpbWVkIG91
dCBpcyBhdCBbNjU0OTkuOTY0MTA1XSBidXQgYW1kZ3B1LWVycm9yIGlzIGF0IFsgICA1Mi43NzIy
NzNdLCBoZW5jZSBtdWNoIGVhcmxpZXIuDQoNClllcywgYnV0IGl0IGNvdWxkIGJlIHRoZSBzYW1l
IHVuZGVybHlpbmcgcmVhc29uLg0KDQo+IEhhdmUgbm90IHRyaWVkIHRvIHVzZSBhbiB1cHN0cmVh
bSBrZXJuZWwgeWV0LiBXaGljaCBvbmUgd291bGQgeW91IHJlY29tbWVuZD8NCg0KRm9yIGEgZmly
c3QgdHJ5LCB1c2UgNS45LjMuIElmIGl0IHJlcHJvZHVjZXMgdGhlcmUsIHBsZWFzZSB0cnkgYm9v
dGluZyB3aXRoICJwY2k9bm9hdHMiIG9uIHRoZSBrZXJuZWwgY29tbWFuZCBsaW5lLg0KDQpQbGVh
c2UgYWxzbyBzZW5kIG1lIHRoZSBvdXRwdXQgb2YgJ2xzcGNpIC12dnYnIGFuZCAnbHNwY2kgLXQn
IG9mIHRoZSBtYWNoaW5lIHdoZXJlIHRoaXMgaGFwcGVucy4NCg0KUmVnYXJkcywNCg0KCUpvZXJn
DQoNCg0KPiANCj4gQXMgZmFyIGFzIGluY29uc2lzdGVuY2llcyBpbiB0aGUgUENJLXNldHVwIGlz
IGNvbmNlcm5lZCwgdGhlIG9ubHkgdGhpbmcgdGhhdCBJIGtub3cgb2YgcmlnaHQgbm93IGlzIHRo
YXQgd2UgaGF2ZW7CtHQgZW50ZXJlZCBhIFBDSSBzdWJzeXN0ZW0gdmVuZG9yIGFuZCBkZXZpY2Ug
SUQgeWV0LiBJdCBpcyBzdGlsbCAiQWR2YW5jZWQgTWljcm8gRGV2aWNlcyIuIFdlIHdpbGwgY2hh
bmdlIHRoYXQgc29vbiB0byAiR2VuZXJhbCBFbGVjdHJpYyIgb3IgIkVtZXJzb24iLg0KPiANCj4g
QmVzdCByZWdhcmRzLA0KPiBFZGdhcg0KPiANCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbToganJvZWRlbEBzdXNlLmRlIDxqcm9lZGVsQHN1c2UuZGU+DQo+IFNlbnQ6IE1pdHR3
b2NoLCA0LiBOb3ZlbWJlciAyMDIwIDA5OjUzDQo+IFRvOiBNZXJnZXIsIEVkZ2FyIFtBVVRPU09M
L01BUy9BVUdTXSA8RWRnYXIuTWVyZ2VyQGVtZXJzb24uY29tPg0KPiBDYzogaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcNCj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogYW1kZ3B1IGVy
cm9yIHdoZW5ldmVyIElPTU1VIGlzIGVuYWJsZWQNCj4gDQo+IEhpIEVkZ2FyLA0KPiANCj4gT24g
RnJpLCBPY3QgMzAsIDIwMjAgYXQgMDI6MjY6MjNQTSArMDAwMCwgTWVyZ2VyLCBFZGdhciBbQVVU
T1NPTC9NQVMvQVVHU10gd3JvdGU6DQo+ID4gV2l0aCBvbmUgYm9hcmQgd2UgaGF2ZSBhIGJvb3Qt
cHJvYmxlbSB0aGF0IGlzIHJlcHJvZHVjaWJsZSBhdCBldmVyeSB+NTAgYm9vdC4NCj4gPiBUaGUg
c3lzdGVtIGlzIGFjY2Vzc2libGUgdmlhIHNzaCBhbmQgd29ya3MgZmluZSBleGNlcHQgZm9yIHRo
ZSANCj4gPiBHcmFwaGljcy4gVGhlIGdyYXBoaWNzIGlzIG9mZi4gV2UgZG9uwrR0IHNlZSBhIHNj
cmVlbi4gUGxlYXNlIHNlZSANCj4gPiBhdHRhY2hlZCDigJxkbWVzZy5sb2figJ0uIEZyb20gWzUy
Ljc3MjI3M10gb253YXJkcyB0aGUga2VybmVsIHJlcG9ydHMgDQo+ID4gZHJtL2FtZGdwdSBlcnJv
cnMuIEl0IGV2ZW4gdHJpZXMgdG8gcmVzZXQgdGhlIEdQVSBidXQgdGhhdCBmYWlscyB0b28uDQo+
ID4gSSB0cmllZCB0byByZXNldCBhbWRncHUgYWxzbyBieSBjb21tYW5kIOKAnHN1ZG8gY2F0IC9z
eXMva2VybmVsL2RlYnVnL2RyaS9OL2FtZGdwdV9ncHVfcmVjb3ZlcuKAnS4gVGhhdCBkaWQgbm90
IGhlbHAgZWl0aGVyLg0KPiANCj4gQ2FuIHlvdSByZXByb2R1Y2UgdGhlIHByb2JsZW0gd2l0aCBh
biB1cHN0cmVhbSBrZXJuZWwgdG9vPw0KPiANCj4gVGhlc2UgbWVzc2FnZXMgaW4gZG1lc2cgaW5k
aWNhdGUgc29tZSBwcm9ibGVtIGluIHRoZSBwbGF0Zm9ybSBzZXR1cDoNCj4gDQo+IAlBTUQtVmk6
IENvbXBsZXRpb24tV2FpdCBsb29wIHRpbWVkIG91dA0KPiANCj4gTWlnaHQgdGhlcmUgYmUgc29t
ZSBpbmNvbnNpc3RlbmNpZXMgaW4gdGhlIFBDSSBzZXR1cCBiZXR3ZWVuIHRoZSBicmlkZ2VzIGFu
ZCB0aGUgZW5kcG9pbnRzIG9yIHNvbWV0aGluZz8NCj4gDQo+IFJlZ2FyZHMsDQo+IA0KPiAJSm9l
cmcNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11
IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
