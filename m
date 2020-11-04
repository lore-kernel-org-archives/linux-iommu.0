Return-Path: <SRS0=z3hi=EK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B2DC2D0A3
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 09:21:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 677742071A
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 09:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emerson.onmicrosoft.com header.i=@emerson.onmicrosoft.com header.b="i2f4rkR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677742071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emerson.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CE05222844;
	Wed,  4 Nov 2020 09:21:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZXePiKkxB8rb; Wed,  4 Nov 2020 09:21:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8218B20445;
	Wed,  4 Nov 2020 09:21:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 666FDC0889;
	Wed,  4 Nov 2020 09:21:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71613C0051
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 09:21:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3A6F42049B
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 09:21:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SqROGrkhFb7v for <iommu@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 09:21:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-00300601.pphosted.com (mx0a-00300601.pphosted.com
 [148.163.146.64])
 by silver.osuosl.org (Postfix) with ESMTPS id 2CC5220445
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 09:21:41 +0000 (UTC)
Received: from pps.filterd (m0142705.ppops.net [127.0.0.1])
 by mx0b-00300601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0A49Ja4N136898; Wed, 4 Nov 2020 09:21:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
 by mx0b-00300601.pphosted.com with ESMTP id 34kdyqfr7m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Nov 2020 09:21:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=En2JLoVT7JawU0Tm4s6j2san6TAe36AgG6x8uarLDNBb9fudIqIRTir0Rt3U3IYBDvawVQDfc+W5lk7KicHa44hxG00vSL0DHRCsfrPodkR9sfS3L+wxH6V+LEoxT7Bolop53BPyZG3eNynX4jxvHJS7LZF95QuHZk6dpWX0rvFZwOYPxRgdKtNcyXPUpVP5MSh0Gm72Nj6CJnSjRYjeTGgNin9wBmr+leiPZ6Nhn5tSnlUPx32XvE5pLNGsI0Q1Lpi9wxGr9js/osOmoCibfa+PTcJO6uXN24851bIZIaK5zKkI2ocOO5gGjuKmIrg53++9CXgskZtMRq+x/70L1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0ivSBXnyNJt5UXRRnThrX7vxpmDTY6EmsBcgCF+KG0=;
 b=BnVKTmgBOoWrRB3UcN2+H7c4nwcnY/ndGWtAYq3eKtKW2sxyQkBeu7vvG875e2IzyCz4ZrIITsZQDzZuyhikOvhOfueoUk0YuDZe3uGaXr2F/P+S6C3FJaWZSGNvlHIo+Afs6n6ijup3b+AfxU5G6a9fJ7fJl/NO8qXwSxVUiX0Xzhqyhjy0ye+VL7Yp3mVXKAzr4ju47jCjChm98P13H6xkHBiZlgNI31QYb0/6904iQGNlSZU2t5oqKY+cr34STOCglfpZulxcdrb5b+qLZVomOZCkufyNcw6LUK9wReAn6XlLJm8UOCtdU8bFvMw0U1gETxva/UT0ZtsFvez5nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emerson.com; dmarc=pass action=none header.from=emerson.com;
 dkim=pass header.d=emerson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emerson.onmicrosoft.com; s=selector2-emerson-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0ivSBXnyNJt5UXRRnThrX7vxpmDTY6EmsBcgCF+KG0=;
 b=i2f4rkR5hUZj7TG3UUfcmqqTQ5wqo0udDF8EfXdpORTpc4hBQqUb3+mZuuLdZb98sV/za9/RtM+a6M5mg1tevDkMU0kcFIxhs9ADTax8RM10BwHPpaVl0I9OWFq0CivFPIDN+RVaiDXCyPBWI8oj2E/zC5qBCrmjnPuEVWxD9yk=
Received: from MWHPR10MB1310.namprd10.prod.outlook.com (2603:10b6:300:21::18)
 by MWHPR1001MB2125.namprd10.prod.outlook.com (2603:10b6:301:2b::37)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Wed, 4 Nov
 2020 09:21:35 +0000
Received: from MWHPR10MB1310.namprd10.prod.outlook.com
 ([fe80::d85:aa30:739f:496e]) by MWHPR10MB1310.namprd10.prod.outlook.com
 ([fe80::d85:aa30:739f:496e%12]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 09:21:35 +0000
From: "Merger, Edgar [AUTOSOL/MAS/AUGS]" <Edgar.Merger@emerson.com>
To: "jroedel@suse.de" <jroedel@suse.de>
Subject: RE: [EXTERNAL] Re: amdgpu error whenever IOMMU is enabled
Thread-Topic: [EXTERNAL] Re: amdgpu error whenever IOMMU is enabled
Thread-Index: Adaux7yL4OYKNrMETgKrPGK8SdhnWADwCzYAAADVBeA=
Date: Wed, 4 Nov 2020 09:21:35 +0000
Message-ID: <MWHPR10MB13109574BDA0F1D8219A225C89EF0@MWHPR10MB1310.namprd10.prod.outlook.com>
References: <MWHPR10MB1310CDB6829DDCF5EA84A14689150@MWHPR10MB1310.namprd10.prod.outlook.com>
 <20201104085306.GQ22179@suse.de>
In-Reply-To: <20201104085306.GQ22179@suse.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=emerson.com;
x-originating-ip: [2a00:79c0:760:a700:b1aa:e7d7:75af:e80e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5492607-b4c6-4c58-2a60-08d880a306f8
x-ms-traffictypediagnostic: MWHPR1001MB2125:
x-microsoft-antispam-prvs: <MWHPR1001MB21253F122FABD42595A9AE1889EF0@MWHPR1001MB2125.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N0O2rf7ktfzYWR3UNj7Zww5+GkGWI5w0k8m0bTpsb1RXDXypdH05lfae2ka6l3jAtAGwDKmIgQbNFJhYRYw8pJ4GP/kEcYX6h7CYlTbpo+tQja0aPyqn6QUliXOZhJ5Dfa83cO5Wvhtsj1tjWSLJ2bHTRDrxQDd/dw0E7lw7zjwKrfyomAki4HInZImnQFFuvmJDqOilX0JWJY/10qa4s96G65W1yqXu68NS+1OCWKD8lx1oVnZ08cU3lBla+fBNfmLAXCnO6Y93ZPtdgg5GZQwCHvrvvLzkNv/eHY8rioqkcoZoirXUBW3qvC152rA3MfeF2+a+nKTxPc84LwCpJA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR10MB1310.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(366004)(396003)(376002)(39840400004)(346002)(7696005)(186003)(53546011)(71200400001)(6506007)(86362001)(33656002)(83380400001)(5660300002)(2906002)(478600001)(66556008)(64756008)(66476007)(8936002)(76116006)(9686003)(66446008)(8676002)(4326008)(55016002)(52536014)(6916009)(316002)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 6H3DODlos6iLnSfUQaQoJW4DD6f7a4O65Wek1FvcQk2w57k2a76pyUI0HS1G2gqV2iIMLNb4a6eg4polUWsQwwNQbKIQfbm44p95JerzLUpJBNN3CQ9qLf91aDj5RqbCm2Mhfqo9LqlG7rNP1TZ4UECcTwTU093Tpuu4hiV2I0ZXQne1Bub7EiueCm4hDMMYoT5BN1K8VtESbvbInWVNDqdyH6x2F8J55K97RutFv2pjoFI7bXupHFUezYjMkQOIA6u8w9Gy97PWygUqwG/AeTE9GQ1tPU9NzMUQZ80tgFIfNpRJq7Ku7BY6TO6CEGPnn80lOjKNGs+2ggHh3FHf50nN5Mk5edGe5R7yeQ9sQwbejbB5hTtv3lwTNvVnt1fHMEqk7+YtwIuyWEIKjYnMadtrg/qgH0cYg/HmQWQSyDMYtVBYLhN8j5J9L9FDFSTVseLnRKrJiiT6Fj0NcRM7lkmkUVqCd3a5MfC9K+aWRq30UsT3PmFcv/4KTl6hp9rzaksRVbUITGfKjI0y827e8blKblaJs0ZvjUOrJTZoIUzwGg7Z0Zsfl1A5y6x+peArHd3ueJ5ZEUlPCp/rI02HCwcIkZu9XD3WEhTBjWYc9whwqKzwvllxZvxx58N5IS11PXLIoHV5vZnK/K6iQ3Bjaq9BKfZTx/jIeUcRmZdmycYGrPO4OBv8nA/COTN0jknB7FGpppLbuC2v7n2j7yUGKQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Emerson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1310.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5492607-b4c6-4c58-2a60-08d880a306f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 09:21:35.6887 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eb06985d-06ca-4a17-81da-629ab99f6505
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2/DxC/6DXZu9mDlzFR68ciBfC8CLsi7v1tQQK5ekxLDKGBgvKVJd7ELXZA7GE7DAA8gVlsjmUvvrdJGQntvQUtpS/5yAEDUsytbsGqj8aYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2125
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-04_06:2020-11-04,
 2020-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040069
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

SGkgSsO2cmcsDQoNCkFNRC1WaTogQ29tcGxldGlvbi1XYWl0IGxvb3AgdGltZWQgb3V0IGlzIGF0
IFs2NTQ5OS45NjQxMDVdIGJ1dCBhbWRncHUtZXJyb3IgaXMgYXQgWyAgIDUyLjc3MjI3M10sIGhl
bmNlIG11Y2ggZWFybGllci4NCg0KSGF2ZSBub3QgdHJpZWQgdG8gdXNlIGFuIHVwc3RyZWFtIGtl
cm5lbCB5ZXQuIFdoaWNoIG9uZSB3b3VsZCB5b3UgcmVjb21tZW5kPw0KDQpBcyBmYXIgYXMgaW5j
b25zaXN0ZW5jaWVzIGluIHRoZSBQQ0ktc2V0dXAgaXMgY29uY2VybmVkLCB0aGUgb25seSB0aGlu
ZyB0aGF0IEkga25vdyBvZiByaWdodCBub3cgaXMgdGhhdCB3ZSBoYXZlbsK0dCBlbnRlcmVkIGEg
UENJIHN1YnN5c3RlbSB2ZW5kb3IgYW5kIGRldmljZSBJRCB5ZXQuIEl0IGlzIHN0aWxsICJBZHZh
bmNlZCBNaWNybyBEZXZpY2VzIi4gV2Ugd2lsbCBjaGFuZ2UgdGhhdCBzb29uIHRvICJHZW5lcmFs
IEVsZWN0cmljIiBvciAiRW1lcnNvbiIuDQoNCkJlc3QgcmVnYXJkcywNCkVkZ2FyDQoNCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBqcm9lZGVsQHN1c2UuZGUgPGpyb2VkZWxAc3Vz
ZS5kZT4gDQpTZW50OiBNaXR0d29jaCwgNC4gTm92ZW1iZXIgMjAyMCAwOTo1Mw0KVG86IE1lcmdl
ciwgRWRnYXIgW0FVVE9TT0wvTUFTL0FVR1NdIDxFZGdhci5NZXJnZXJAZW1lcnNvbi5jb20+DQpD
YzogaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcNClN1YmplY3Q6IFtFWFRFUk5BTF0g
UmU6IGFtZGdwdSBlcnJvciB3aGVuZXZlciBJT01NVSBpcyBlbmFibGVkDQoNCkhpIEVkZ2FyLA0K
DQpPbiBGcmksIE9jdCAzMCwgMjAyMCBhdCAwMjoyNjoyM1BNICswMDAwLCBNZXJnZXIsIEVkZ2Fy
IFtBVVRPU09ML01BUy9BVUdTXSB3cm90ZToNCj4gV2l0aCBvbmUgYm9hcmQgd2UgaGF2ZSBhIGJv
b3QtcHJvYmxlbSB0aGF0IGlzIHJlcHJvZHVjaWJsZSBhdCBldmVyeSB+NTAgYm9vdC4NCj4gVGhl
IHN5c3RlbSBpcyBhY2Nlc3NpYmxlIHZpYSBzc2ggYW5kIHdvcmtzIGZpbmUgZXhjZXB0IGZvciB0
aGUgDQo+IEdyYXBoaWNzLiBUaGUgZ3JhcGhpY3MgaXMgb2ZmLiBXZSBkb27CtHQgc2VlIGEgc2Ny
ZWVuLiBQbGVhc2Ugc2VlIA0KPiBhdHRhY2hlZCDigJxkbWVzZy5sb2figJ0uIEZyb20gWzUyLjc3
MjI3M10gb253YXJkcyB0aGUga2VybmVsIHJlcG9ydHMgDQo+IGRybS9hbWRncHUgZXJyb3JzLiBJ
dCBldmVuIHRyaWVzIHRvIHJlc2V0IHRoZSBHUFUgYnV0IHRoYXQgZmFpbHMgdG9vLiANCj4gSSB0
cmllZCB0byByZXNldCBhbWRncHUgYWxzbyBieSBjb21tYW5kIOKAnHN1ZG8gY2F0IC9zeXMva2Vy
bmVsL2RlYnVnL2RyaS9OL2FtZGdwdV9ncHVfcmVjb3ZlcuKAnS4gVGhhdCBkaWQgbm90IGhlbHAg
ZWl0aGVyLg0KDQpDYW4geW91IHJlcHJvZHVjZSB0aGUgcHJvYmxlbSB3aXRoIGFuIHVwc3RyZWFt
IGtlcm5lbCB0b28/DQoNClRoZXNlIG1lc3NhZ2VzIGluIGRtZXNnIGluZGljYXRlIHNvbWUgcHJv
YmxlbSBpbiB0aGUgcGxhdGZvcm0gc2V0dXA6DQoNCglBTUQtVmk6IENvbXBsZXRpb24tV2FpdCBs
b29wIHRpbWVkIG91dA0KDQpNaWdodCB0aGVyZSBiZSBzb21lIGluY29uc2lzdGVuY2llcyBpbiB0
aGUgUENJIHNldHVwIGJldHdlZW4gdGhlIGJyaWRnZXMgYW5kIHRoZSBlbmRwb2ludHMgb3Igc29t
ZXRoaW5nPw0KDQpSZWdhcmRzLA0KDQoJSm9lcmcNCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
