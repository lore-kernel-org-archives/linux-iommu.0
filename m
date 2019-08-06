Return-Path: <SRS0=bP0W=WC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3544C31E40
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 14:18:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E47020818
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 14:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZLAHtaJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E47020818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1A018D81;
	Tue,  6 Aug 2019 14:18:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9418A265
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 14:18:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
	(mail-eopbgr700077.outbound.protection.outlook.com [40.107.70.77])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 61B3582F
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 14:18:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=nnbGwcYhcY4nWQ5+cBifHys90szgxOBXMl4abuQMwfUi15ihfx3ZQskD2sVUgkdQ6ML6qNtgWJkgjr+5tQmBpigYoOpAIRKb6cBmYBY9Q8uwcfr2+oV+5afkhRrqdRelL4dTeUMjoQu5YtoLlxko32plybffIJCzp0qNSrV4ixTjre1qjP6C0OnD5elaPjFBhmPHAD3vqKOoDrBpi4+mpYwDgryp7EIMYSuqFUxQ6UHKEk9vq3XHmd0FFY5xg0uY1hIsJvDlRAuaY4qXon7KSYaYnUG3lZSQZtLwtLuDKAOImDAx0RL8JAJZy0lAP9rrYxTtbeXIdiaCpLqA5aBrUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=gj7GKjLT/N+X/RBRdPGEi/Oj4Nh+AZ4NMO0kN71qCxs=;
	b=k2wFPbUtVGN2EjVF27YBkuoFFqt7O3zHCzua3ulIR9OGhyjS2eBgQV4JJq4h7XHTI5QQM+Zu+o9fOaGpymxDGWLTgFK/8gwzUa+MkzLZBhPlwyaMDoJTyV5Of1IjAUNxvyen/GFVIAPlG8zsx7ObzefujTjJSC5uBi4urHGwbHrHILksUpzjLQajZvoFZKdMUemaLO5E4dNoVKoyQSFiJE8G1a1B2kBipmHZTqpG0UpYYI4CcRan22ILzz/8ZjqEpJPEQ8qCPfxwWdICvtgT/FOzY2ppqShNqo19fj2Gwlos9M8YYXBYWHnRCtriljus7dNQkFi/7GcSw+pNCjLudw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
	smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com;
	dkim=pass header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=gj7GKjLT/N+X/RBRdPGEi/Oj4Nh+AZ4NMO0kN71qCxs=;
	b=ZLAHtaJU+eQBbzfY3xCv/lvWRUEX0t/ZBUkIpZ6wh3UWJ/YwBjSFvAL35p6x38cc1C177Bh18S2RdUXlUR1qQcDC62yRM55ZLdc+U9QnYvsMg1yN8NrDFT2G0FY4GTjzVvQ8jkD485WgsDebRB3pL8KAePGe76iqc4sxtptlnug=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
	DM6PR12MB3833.namprd12.prod.outlook.com (10.255.173.138) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2136.17; Tue, 6 Aug 2019 14:18:49 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::9c3d:8593:906c:e4f7]) by
	DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2136.018;
	Tue, 6 Aug 2019 14:18:49 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To: Lucas Stach <l.stach@pengutronix.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: Regression due to d98849aff879 (dma-direct: handle
	DMA_ATTR_NO_KERNEL_MAPPING in common code)
Thread-Topic: Regression due to d98849aff879 (dma-direct: handle
	DMA_ATTR_NO_KERNEL_MAPPING in common code)
Thread-Index: AQHVTDc5jxhkF6eBGE2vQ7mpw/Pby6bt/Q4AgAAjGICAAAcMAIAAAMsAgAADTYA=
Date: Tue, 6 Aug 2019 14:18:49 +0000
Message-ID: <78833204-cd30-1a4b-54e3-1580018c6d57@amd.com>
References: <1565082809.2323.24.camel@pengutronix.de>
	<20190806113318.GA20215@lst.de>
	<41cc93b1-62b5-7fb6-060d-01982e68503b@amd.com>
	<20190806140408.GA22902@lst.de>
	<1565100418.2323.32.camel@pengutronix.de>
In-Reply-To: <1565100418.2323.32.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR08CA0003.namprd08.prod.outlook.com
	(2603:10b6:805:66::16) To DM6PR12MB3163.namprd12.prod.outlook.com
	(2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a3e4f29-f288-48c3-da65-08d71a79000f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB3833; 
x-ms-traffictypediagnostic: DM6PR12MB3833:
x-microsoft-antispam-prvs: <DM6PR12MB383314726482752C40EA6A6EECD50@DM6PR12MB3833.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(189003)(199004)(66476007)(6506007)(3846002)(7736002)(6116002)(64756008)(386003)(66556008)(66446008)(14454004)(305945005)(110136005)(36756003)(256004)(76176011)(102836004)(71190400001)(71200400001)(14444005)(52116002)(486006)(53546011)(54906003)(68736007)(4326008)(99286004)(66946007)(316002)(2906002)(11346002)(6246003)(6512007)(31686004)(53936002)(86362001)(8936002)(31696002)(229853002)(6486002)(2616005)(6436002)(25786009)(5660300002)(81166006)(81156014)(26005)(478600001)(186003)(8676002)(66066001)(476003)(446003);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3833;
	H:DM6PR12MB3163.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lKx+BUlcDIYAul2bXPagh2gc6pO0ae6OcwMf5oSdUsbjoB40iPIaSKJSQkTuNYJ8P7JWCuWhyVqoEpAAALPCYnG5sWK7t8ZYMCd18F89CSuwL+R6v+LRkdomO81diO4nV/xwija5he34ZXq4oT7rb8bSGnOqxIa1dnhURN0po2f9J7b/TvmnEOLrUlF01QvemEpJV8sm2tNORs5UC+931jFBQrB5eVsErqTuikbaplp0chhVEQ1SQuZNSzeWCNN5OwGGlMefJGWkCgkZEN7K4j5hoxIYX+AnxjtLuPyztDCxdqZGhKhhM/Vta6guxOUEv+JcxIM5z2fTpCIJ07ufItwNPIzLOsHzaY0KjDdXwykn2aLf0eDMY56vR3eTsTeF6jCNVmoegoeorQO4qcY0t4zJEycsVyuz+q7EbpG/4tM=
Content-ID: <E288C55DCA018641AF497C0078ED9265@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3e4f29-f288-48c3-da65-08d71a79000f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 14:18:49.3156 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3833
Cc: Halil Pasic <pasic@linux.ibm.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

T24gOC82LzE5IDk6MDYgQU0sIEx1Y2FzIFN0YWNoIHdyb3RlOg0KPiBBbSBEaWVuc3RhZywgZGVu
IDA2LjA4LjIwMTksIDE2OjA0ICswMjAwIHNjaHJpZWIgQ2hyaXN0b3BoIEhlbGx3aWc6DQo+PiBP
aywgZG9lcyB0aGlzIHdvcms/DQo+Pg0KPj4gLS0NCj4+IEZyb20gMzRkMzVmMzM1YTk4ZjUxNWYy
NTE2YjUxNTA1MWUxMmVhZTc0NGM4ZCBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDENCj4+PiBGcm9t
OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4+IERhdGU6IFR1ZSwgNiBBdWcgMjAx
OSAxNDozMzoyMyArMDMwMA0KPj4gU3ViamVjdDogZG1hLWRpcmVjdDogZml4IERNQV9BVFRSX05P
X0tFUk5FTF9NQVBQSU5HDQo+Pg0KPj4gVGhlIG5ldyBETUFfQVRUUl9OT19LRVJORUxfTUFQUElO
RyBuZWVkcyB0byBhY3R1YWxseSBhc3NpZ24NCj4+IGEgZG1hX2FkZHIgdG8gd29yay7CoMKgQWxz
byBza2lwIGl0IGlmIHRoZSBhcmNoaXRlY3R1cmUgbmVlZHMNCj4+IGZvcmNlZCBkZWNyeXB0aW9u
IGhhbmRsaW5nLCBhcyB0aGF0IG5lZWRzIGEga2VybmVsIHZpcnR1YWwNCj4+IGFkZHJlc3MuDQo+
Pg0KPj4gRml4ZXM6IGQ5ODg0OWFmZjg3OSAoZG1hLWRpcmVjdDogaGFuZGxlIERNQV9BVFRSX05P
X0tFUk5FTF9NQVBQSU5HIGluIGNvbW1vbiBjb2RlKQ0KPj4+IFNpZ25lZC1vZmYtYnk6IENocmlz
dG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPj4gLS0tDQo+PiDCoGtlcm5lbC9kbWEvZGlyZWN0
LmMgfCA0ICsrKy0NCj4+IMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvZG1hL2RpcmVjdC5jIGIva2VybmVs
L2RtYS9kaXJlY3QuYw0KPj4gaW5kZXggNTliZGNlZWEzNzM3Li5iMDEwNjRkODg0ZjIgMTAwNjQ0
DQo+PiAtLS0gYS9rZXJuZWwvZG1hL2RpcmVjdC5jDQo+PiArKysgYi9rZXJuZWwvZG1hL2RpcmVj
dC5jDQo+PiBAQCAtMTMwLDExICsxMzAsMTMgQEAgdm9pZCAqZG1hX2RpcmVjdF9hbGxvY19wYWdl
cyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHNpemVfdCBzaXplLA0KPj4+IMKgCWlmICghcGFnZSkNCj4+
PiDCoAkJcmV0dXJuIE5VTEw7DQo+PiDCoA0KPj4+IC0JaWYgKGF0dHJzICYgRE1BX0FUVFJfTk9f
S0VSTkVMX01BUFBJTkcpIHsNCj4+PiArCWlmICgoYXR0cnMgJiBETUFfQVRUUl9OT19LRVJORUxf
TUFQUElORykgJiYNCj4+ICsJwqDCoMKgwqAhZm9yY2VfZG1hX3VuZW5jcnlwdGVkKGRldikpIHsN
Cg0KSSB0aGluayB5b3UgbmVlZCB0byBrZWVwIGV2ZXJ5dGhpbmcgaW5zaWRlIHRoZSBvcmlnaW5h
bCBpZiBzdGF0ZW1lbnQgc2luY2UNCnRoZSBjYWxsZXIgaXMgZXhwZWN0aW5nIGEgcGFnZSBwb2lu
dGVyIHRvIGJlIHJldHVybmVkIGluIHRoaXMgY2FzZSBhbmQgbm90DQp0aGUgcGFnZV9hZGRyZXNz
KCkgd2hpY2ggaXMgcmV0dXJuZWQgd2hlbiB0aGUgRE1BX0FUVFJfTk9fS0VSTkVMX01BUFBJTkcN
CmlzIG5vdCBwcmVzZW50Lg0KDQo+IA0KPiBkbWFfZGlyZWN0X2ZyZWVfcGFnZXMoKSB0aGVuIG5l
ZWRzIHRoZSBzYW1lIGNoZWNrLCBhcyBvdGhlcndpc2UgdGhlIGNwdQ0KDQpBZ3JlZWQuIEFuZCB0
aGUgY3B1X2FkZHIgcGFzc2VkIGluIGhlcmUgd2lsbCBiZSB0aGUgcGFnZSBwb2ludGVyLCBzbw0K
d2lsbCBuZWVkIHRvIGtlZXAgZXZlcnl0aGluZyBpbnNpZGUgdGhlIGlmIGNoZWNrIG9mIHRoZQ0K
RE1BX0FUVFJfTk9fS0VSTkVMX01BUFBJTkcgYXR0ciBoZXJlIGFzIHdlbGwuDQoNClRoYW5rcywN
ClRvbQ0KDQo+IGFkZHJlc3MgaXMgdHJlYXRlZCBhcyBhIGNvb2tpZSBpbnN0ZWFkIG9mIGEgcmVh
bCBhZGRyZXNzIGFuZCB0aGUNCj4gZW5jcnlwdGlvbiBuZWVkcyB0byBiZSByZS1lbmFibGVkLg0K
PiANCj4gUmVnYXJkcywNCj4gTHVjYXMNCj4gDQo+PiDCoAkJLyogcmVtb3ZlIGFueSBkaXJ0eSBj
YWNoZSBsaW5lcyBvbiB0aGUga2VybmVsIGFsaWFzICovDQo+Pj4gwqAJCWlmICghUGFnZUhpZ2hN
ZW0ocGFnZSkpDQo+Pj4gwqAJCQlhcmNoX2RtYV9wcmVwX2NvaGVyZW50KHBhZ2UsIHNpemUpOw0K
Pj4+IMKgCQkvKiByZXR1cm4gdGhlIHBhZ2UgcG9pbnRlciBhcyB0aGUgb3BhcXVlIGNvb2tpZSAq
Lw0KPj4+ICsJCSpkbWFfaGFuZGxlID0gcGh5c190b19kbWEoZGV2LCBwYWdlX3RvX3BoeXMocGFn
ZSkpOw0KPj4+IMKgCQlyZXR1cm4gcGFnZTsNCj4+PiDCoAl9DQo+PiDCoA0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
