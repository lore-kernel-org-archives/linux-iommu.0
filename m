Return-Path: <SRS0=JfyE=EX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C45DC2D0E4
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 19:05:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6966424181
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 19:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vmDQvDIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6966424181
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F0D2A8609F;
	Tue, 17 Nov 2020 19:05:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IERvSj5ux0Q5; Tue, 17 Nov 2020 19:05:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C848E8528B;
	Tue, 17 Nov 2020 19:05:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BF2EC0891;
	Tue, 17 Nov 2020 19:05:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98E25C07FF
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 19:05:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 82B0485608
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 19:05:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LtrhNNoZLcjq for <iommu@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 19:05:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 17F3885621
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 19:05:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/5XwcrnxrqnzY9CODOXn1wv/uoVE7CxQagFqVmjBuVtKsPdVbOrWzJ6pJTfnzuSiHYhStN/PdbISPeSHVXs3QXwqez3szxmwvS1oaBHyAQZ0przJuJhXY+BrL8Gl2r6BgFP9uBRjUANPGjg3Wv/Jed3EXiXbkMzdqx56g2KkTUKSEghOCw3H/QxSOer9Ix7Cd0o0QAmX09XNSxQIOLDivHt0Uwqw7DsSizOdZKfdcyLN80ZL2sLa6OIKEHAcXA3JuulNKbp4ZRYNBVsl4nr0SFRSKPghFG5FKUnhnp2UEgilP7zYapTyPmYqwYLvOaJRiCAiIBZgncLqBxlaULHlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UUIy3u7R378jam0X09iNld3N3ogfACx2zhsaI7xebs=;
 b=EZ5eBmtsY6U5+nOuIb0wYInnBIPL6eLT/VqTUDXKgLpkak27bmo874MAmvlcFfF2u0aRxMkrZA1SqAxj/l7/I3d8nKrqTNCZTVDdPRpBUzzL7XWXYocjYI60oncGkZKe3EDFNjOoTzLnzPetlmEpcyPTXc2QTZcxZBRH8d3/lHd9pe2+9ebNxL9NhXHgZZeEMuJ5o4n+s9KP2MXSy4EzKHyonF/bLe6ugRm/gyb1tBh5PAF315eMPMxbiCxO+QTtUUnAm2FYTgfFbNrgeda7a+4dyTnFoKIgwF9+k/wyzf3wXLfPFAVu/0CVrMDbGUm+9YZXPY8imqPAEDSTikg9iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UUIy3u7R378jam0X09iNld3N3ogfACx2zhsaI7xebs=;
 b=vmDQvDICbMjCgzMz888JSRhVnWgdMuNHQkjDc7IVrdbTDiRE+uAb1QlwvtuBAsIGI6U8Jixa3uwJ6V7tmfG6qZs+To/veehMOEvFToCVrUe9sjqmr1quyNuy1WQWVAzaYCZIESowZBbucyxwnyq2Ujph7MNiAlnccDEzNlQhdQs=
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SA0PR12MB4592.namprd12.prod.outlook.com (2603:10b6:806:9b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Tue, 17 Nov
 2020 19:04:59 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec%3]) with mapi id 15.20.3541.025; Tue, 17 Nov 2020
 19:04:59 +0000
From: "Kalra, Ashish" <Ashish.Kalra@amd.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v3] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Thread-Topic: [PATCH v3] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Thread-Index: AQHWsvb+PlxyCq4OFEaOkoN4Zhq3Xam4iecAgAAGzoCAAT+mgIAAEDKAgAAHJYCAAAjXAIAAC6OAgAAQ8YCADJJHgIAF6LMAgAAYKYCAAAq9gIAAGCsQ
Date: Tue, 17 Nov 2020 19:04:59 +0000
Message-ID: <7EAA7A38-50B7-4291-9A4E-34668455B59D@amd.com>
References: <20201104223913.GA25311@ashkalra_ubuntu_server>
 <20201105174317.GA4294@char.us.oracle.com>
 <20201105184115.GA25261@ashkalra_ubuntu_server>
 <20201105190649.GB5366@char.us.oracle.com>
 <20201105193828.GA25303@ashkalra_ubuntu_server>
 <20201105202007.GA6370@char.us.oracle.com>
 <20201105212045.GB25303@ashkalra_ubuntu_server>
 <20201113211925.GA6096@char.us.oracle.com>
 <20201117153302.GA29293@ashkalra_ubuntu_server>
 <20201117170003.GF10360@char.us.oracle.com>,
 <20201117173829.GA29387@ashkalra_ubuntu_server>
In-Reply-To: <20201117173829.GA29387@ashkalra_ubuntu_server>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=amd.com;
x-originating-ip: [136.49.12.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c811347b-c2a1-498d-a9c9-08d88b2bae5a
x-ms-traffictypediagnostic: SA0PR12MB4592:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR12MB4592375E3AAB3DFB886A5D5A8EE20@SA0PR12MB4592.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SrkLfzPhSNW6ZEg3wQpPeaOLRAs4WJG7MsOaavfOuP+q3Ul8QgCCJkbzW6EX0ilE0kslG072bR4e8cy/Hem+tamLqJpKYz2D0sQHEhBMZlApqGmgSI01aKeQuhIliWxX7J3Ls9ruuUrsO6HeHQvK47YrYYmSMlLG2IANRiW4kXbZcwx/vpzyyBfABW5TGiTpo17GZ3sXuCFwH3zCjL2e2lUQ4v1e/TrJrEu58foDCA+Btls5TUsv1/HLoXCg+3x0NepmwwxKnSjgGn/1J3PeTLdMHwNR6Ru5CW/sJiD+vrMU6TWS3XDeb7i1WxAZ/7D2dg7Z6kCpdpxiTdnNfH6xEg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(316002)(83380400001)(71200400001)(66476007)(36756003)(86362001)(66556008)(64756008)(5660300002)(4326008)(33656002)(6486002)(6512007)(66446008)(8936002)(54906003)(2906002)(8676002)(6506007)(6916009)(7416002)(186003)(26005)(66946007)(478600001)(2616005)(76116006)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 8y7jDBTu/P021ZsudTIfMIXRjNFPviYAQDCa+vMiFZ0Sb5wXHISU4EGc41oHqx40tgJs15exfYcjjxAn2JQ0UAYORjJ8A7wHs4vCETnkHU7gSBzxNg5g8fkASRTMuKE1wiaYWMMiHfi047nehIV3iaqTZIXmTnTiI6tSGG5EYb9Bb+yZPR0pckGLQXYiFDjR5xGTuSModYnLVBjc9ui+B0ldMRkcRYTmpzYAFRnFY6R8fI2JeKwO76GWmX1aotVfRFOfqxTHbGKGc3EQSZojufE5OdIGdN9ilwKZpqr3MrdiPe+8sx+4OQ8ZIVJ5dbKp7ZeWRYraPSwf9oRzCqZB/hFtk7PzgYN0WfeyJGLktBVR39L3lPgx3Hy5eUvbn/n1onM7RwxkizChYNfeN63lcpUZFMJH4WGe+MXzsQ1AF0vHgaCZLGmiyTH5+F9u3qgF/CFY3xWlATWCCe+hgyBjPdV67Ay5hKToPeLCR7p1eQcWyWcz+TQVFR9YnMoiYDNU4kfUmc68dW7jvBNNv/xB3fIHqLOJkoxGBQCxphEGaYDocHCl/GyygDXHKPUapHNd2XxxoOSVWWtuoVrNDGBc9nFAeHE8MwqHKfCx9Yiv0Ag56utJVkWHw8vEPE/MyUtdFTOtXgwz1sdrqbzzjWwxR5D/fkEnYhrgWHPpi4xM9i/h9CO79aVcTYV9dyH1gdUbp976VLGouCwNm3Q44d2MYDHA4MGXEQ1LBGXvzAjdm3xGy1IRf03GpL2ozFSaWmnV24bnDW5gINMI34zw/+IEO6hbnP2ULPf1+tks6jy7FgUK7Bn2IWxYPEatHIdpsvN5rFL2OF7h0ajYNnZNZ8aw6GdcX4xXSIUSW4iZLvpSUgl28bOsqz8zAAGjQki3WTXqqRU+262YLN65hx8J7AAGUQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c811347b-c2a1-498d-a9c9-08d88b2bae5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 19:04:59.3869 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XqTf79ny0Sg5sFQR3wsNz81ZcSovClW6hL+bTn+xYE82FTuU1c5rSRaQeBAauFG6AcSlhstyg5KsELlRLvv2wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4592
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Grimm,
 Jon" <Jon.Grimm@amd.com>, "Singh, Brijesh" <brijesh.singh@amd.com>,
 "ssg.sos.patches" <ssg.sos.patches@amd.com>,
 "dave.hansen@linux-intel.com" <dave.hansen@linux-intel.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "luto@kernel.org" <luto@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "rientjes@google.com" <rientjes@google.com>,
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

SGVsbG8gS29ucmFkLA0KDQpBY3R1YWxseSBJIGRpZG7igJl0IGdldCB0aGF0LCBkbyB5b3UgbWVh
biB5b3UgYXJlIHRha2luZyAxRyBhbmQgPD00RyBjYXNlcyBvdXQgb2YgdGhlIHBhdGNoIGFuZCBv
bmx5IGdvaW5nIHRvIGFwcGx5IHRoZSA+NEcgY2FzZSBhcyBwYXJ0IG9mIHRoZSBwYXRjaCA/DQoN
ClRoYW5rcywNCkFzaGlzaCANCg0KPiBPbiBOb3YgMTcsIDIwMjAsIGF0IDExOjM4IEFNLCBLYWxy
YSwgQXNoaXNoIDxBc2hpc2guS2FscmFAYW1kLmNvbT4gd3JvdGU6DQo+IA0KPiDvu79IZWxsbyBL
b25yYWQsIA0KPiANCj4+IE9uIFR1ZSwgTm92IDE3LCAyMDIwIGF0IDEyOjAwOjAzUE0gLTA1MDAs
IEtvbnJhZCBSemVzenV0ZWsgV2lsayB3cm90ZToNCj4+IC5zbmlwLi4NCj4+Pj4+PiBMZXRzIGJy
ZWFrIHRoaXMgZG93bjoNCj4+Pj4+PiANCj4+Pj4+PiBIb3cgZG9lcyB0aGUgcGVyZm9ybWFuY2Ug
aW1wcm92ZSBmb3Igb25lIHNpbmdsZSBkZXZpY2UgaWYgeW91IGluY3JlYXNlIHRoZSBTV0lPVExC
Pw0KPj4+Pj4+IElzIHRoZXJlIGEgc3BlY2lmaWMgZGV2aWNlL2RyaXZlciB0aGF0IHlvdSBjYW4g
dGFsayBhYm91dCB0aGF0IGltcHJvdmUgd2l0aCB0aGlzIHBhdGNoPw0KPj4+Pj4+IA0KPj4+Pj4+
IA0KPj4+Pj4gDQo+Pj4+PiBZZXMsIHRoZXNlIGFyZSBtYWlubHkgZm9yIG11bHRpLXF1ZXVlIGRl
dmljZXMgc3VjaCBhcyBOSUNzIG9yIGV2ZW4NCj4+Pj4+IG11bHRpLXF1ZXVlIHZpcnRpby4gDQo+
Pj4+PiANCj4+Pj4+IFRoaXMgYmFzaWNhbGx5IGltcHJvdmVzIHBlcmZvcm1hbmNlIHdpdGggY29u
Y3VycmVudCBETUEsIGhlbmNlLA0KPj4+Pj4gYmFzaWNhbGx5IG11bHRpLXF1ZXVlIGRldmljZXMu
DQo+Pj4+IA0KPj4+PiBPSywgYW5kIGZvciBfMUdCXyBndWVzdCAtIHdoYXQgYXJlIHRoZSAiaW50
ZXJuYWwgdGVhbXMvZXh0ZXJuYWwgY3VzdG9tZXJzIiBhbW91bnQgDQo+Pj4+IG9mIENQVXMgdGhl
eSB1c2U/IFBsZWFzZSBsZXRzIHVzZSByZWFsIHVzZS1jYXNlcy4NCj4+PiANCj4+Pj4+IEkgYW0g
c3VyZSB5b3Ugd2lsbCB1bmRlcnN0YW5kIHdlIGNhbm5vdCBzaGFyZSBhbnkgZXh0ZXJuYWwgY3Vz
dG9tZXINCj4+Pj4+IGRhdGEgYXMgYWxsIHRoYXQgY3VzdG9tZXIgaW5mb3JtYXRpb24gaXMgcHJv
cHJpZXRhcnkuDQo+Pj4+PiANCj4+Pj4+IEluIHNpbWlsYXIgc2l0dWF0aW9uIGlmIHlvdSBoYXZl
IHRvIHNoYXJlIE9yYWNsZSBkYXRhLCB5b3Ugd2lsbA0KPj4+Pj4gc3VyZWx5IGhhdmUgdGhlIHNh
bWUgY29uY2VybnMgYW5kIGkgZG9uJ3QgdGhpbmsgeW91IHdpbGwgYmUgYWJsZQ0KPj4+Pj4gdG8g
c2hhcmUgYW55IHN1Y2ggaW5mb3JtYXRpb24gZXh0ZXJuYWxseSwgaS5lLiwgb3V0c2lkZSBPcmFj
bGUuDQo+Pj4+PiANCj4+Pj4gSSBhbSBhc2tpbmcgZm9yIGEgc2ltcGxlIHF1ZXJ5IC0gd2hhdCBh
bW91bnQgb2YgQ1BVcyBkb2VzIGEgMUdCDQo+Pj4+IGd1ZXN0IGhhdmU/IFRoZSByZWFzb24gZm9y
IHRoaXMgc2hvdWxkIGJlIGZhaXJseSBvYnZpb3VzIC0gaWYNCj4+Pj4gaXQgaXMgYSAxdkNQVSwg
dGhlbiB0aGVyZSBpcyBubyBtdWx0aS1xdWV1ZSBhbmQgdGhlIGV4aXN0aW5nDQo+Pj4+IFNXSU9U
TEIgcG9vbCBzaXplIGFzIGl0IGlzIE9LLg0KPj4+PiANCj4+Pj4gSWYgaG93ZXZlciB0aGVyZSBh
cmUgc2F5IDIgYW5kIG11bHRpcXVldWUgaXMgZW5hYmxlZCwgdGhhdA0KPj4+PiBnaXZlcyBtZSBh
biBpZGVhIG9mIGhvdyBtYW55IHlvdSB1c2UgYW5kIEkgY2FuIGZpbmQgb3V0IHdoYXQNCj4+Pj4g
dGhlIG1heGltdW0gcG9vbCBzaXplIHVzYWdlIG9mIHZpcnRpbyB0aGVyZSBpcyB3aXRoIHRoYXQg
Y29uZmlndXJhdGlvbi4NCj4+PiANCj4+PiBBZ2FpbiB3ZSBjYW5ub3Qgc2hhcmUgYW55IGN1c3Rv
bWVyIGRhdGEuDQo+Pj4gDQo+Pj4gQWxzbyBpIGRvbid0IHRoaW5rIHRoZXJlIGNhbiBiZSBhIGRl
ZmluaXRpdmUgYW5zd2VyIHRvIGhvdyBtYW55IHZDUFVzIGENCj4+PiAxR0IgZ3Vlc3Qgd2lsbCBo
YXZlLCBpdCB3aWxsIGRlcGVuZCBvbiB3aGF0IGtpbmQgb2YgY29uZmlndXJhdGlvbiB3ZSBhcmUN
Cj4+PiB0ZXN0aW5nLg0KPj4+IA0KPj4+IEZvciBleGFtcGxlLCBpIHVzdWFsbHkgc2V0dXAgNC0x
NiB2Q1BVcyBmb3IgYXMgbG93IGFzIDUxMk0gY29uZmlndXJlZA0KPj4+IGd1ZWVzdCBtZW1vcnku
DQo+PiANCj4+IFN1cmUsIGJ1dCB5b3UgYXJlIG5vdCB0aGUgbm9ybWFsIHVzZXIuDQo+PiANCj4+
IFRoYXQgaXMgSSBkb24ndCBsaWtlIHRoYXQgZm9yIDFHQiBndWVzdHMgeW91ciBwYXRjaCBlbmRz
IHVwIGRvdWJsaW5nIHRoZQ0KPj4gU1dJT1RMQiBtZW1vcnkgcG9vbC4gVGhhdCBzZWVtcyB0byBt
ZSB3ZSBhcmUgdHJ5aW5nIHRvIHNvbHZlIGEgcHJvYmxlbQ0KPj4gdGhhdCBub3JtYWwgdXNlcnMg
d2lsbCBub3QgaGl0LiBUaGF0IGlzIHdoeSBJIHdhbnQgJ2hlcmUgaXMgdGhlIGN1c3RvbWVyDQo+
PiBidWcnLg0KPj4gDQo+PiBIZXJlIGlzIHdoYXQgSSBhbSBnb2luZyB0byBkbyAtIEkgd2lsbCB0
YWtlIG91dCB0aGUgMUdCIGFuZCA0R0IgY2FzZSBvdXQgb2YNCj4+IHlvdXIgcGF0Y2ggYW5kIGNh
bGwgaXQgYSBkYXkuIElmIHRoZXJlIGFyZSBjdXN0b21lcnMgd2hvIHN0YXJ0IHJlcG9ydGluZyBp
c3N1ZXMNCj4+IHdlIGNhbiByZXZpc3QgdGhhdC4gTm90aGluZyB3cm9uZyB3aXRoICdSZXBvcnRl
ZC1ieScgWFpZICh3ZSBvZnRlbiBhc2sgdGhlDQo+PiBjdXN0b21lciBpZiBoZSBvciBzaGUgd291
bGQgbGlrZSB0byBiZSByZWNvZ25pemVkIG9uIHVwc3RyZWFtIGJ1Z3MpLg0KPj4gDQo+IA0KPiBP
ay4NCj4gDQo+PiBBbmQgaW4gdGhlIG1lYW50aW1lIEkgYW0gZ29pbmcgdG8gbG9vayBhYm91dCBh
ZGRpbmcgLi4NCj4+PiANCj4+PiBJIGhhdmUgYmVlbiBhbHNvIHRlc3Rpbmcgd2l0aCAxNiB2Q1BV
cyBjb25maWd1cmF0aW9uIGZvciA1MTJNLTFHIGd1ZXN0DQo+Pj4gbWVtb3J5IHdpdGggTWVsbGFu
b3ggU1JJT1YgTklDcywgYW5kIHRoaXMgd2lsbCBiZSBhIG11bHRpLXF1ZXVlIE5JQw0KPj4+IGRl
dmljZSBlbnZpcm9ubWVudC4NCj4+IA0KPj4gLi4gbGF0ZSBTV0lPVExCIGV4cGFuc2lvbiB0byBz
dGljaCB0aGUgRE1BIHBvb2xzIHRvZ2V0aGVyIGFzIGJvdGgNCj4+IE1lbGxhbm94IGFuZCBWaXJ0
SU8gYXJlIG5vdCAzMi1iaXQgRE1BIGJvdW5kLg0KPj4gDQo+Pj4gDQo+Pj4gU28gd2UgbWlnaHQg
YmUgaGF2aW5nIGxlc3MgY29uZmlndXJlZCBndWVzdCBtZW1vcnksIGJ1dCB3ZSBzdGlsbCBtaWdo
dA0KPj4+IGJlIHVzaW5nIHRoYXQgY29uZmlndXJhdGlvbiB3aXRoIEkvTyBpbnRlbnNpdmUgd29y
a2xvYWRzLg0KPj4+IA0KPiANCj4gSSBhbSBnb2luZyB0byBzdWJtaXQgdjQgb2YgbXkgY3VycmVu
dCBwYXRjaC1zZXQgd2hpY2ggdXNlcyBtYXgoKSBpbnN0ZWFkDQo+IG9mIGNsYW1wKCkgYW5kIGFs
c28gcmVwbGFjZXMgY29uc3RhbnRzIGRlZmluZWQgaW4gdGhpcyBwYXRjaCB3aXRoIHRoZQ0KPiBw
cmUtZGVmaW5lZCBvbmVzIGluIHNpemVzLmgNCj4gDQo+IFRoYW5rcywNCj4gQXNoaXNoDQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
