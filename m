Return-Path: <SRS0=WqUy=VV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6D8C76186
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 17:34:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0D9720840
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 17:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zNiZ48dS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D9720840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DD7C71223;
	Wed, 24 Jul 2019 17:34:30 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C420CF98
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 17:34:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
	(mail-eopbgr810051.outbound.protection.outlook.com [40.107.81.51])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3E203F1
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 17:34:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=OnXJ7Vo5xk8Erj2azglHdVAFKxEAvxzEA52bKKlcnKP0BPphg0N06umcSyFZxc3AQIHPisV5GShyjUSZ4Mm5TqbyxFUrbTT9c7sW3i0B+HP2/G28JZk5lzJ3ndlimTZ9SfCOTrvp+9mJyJmUqtnq5j8AEjK3WRvpaDvzV4pCBLU4IMj7ZR1f1cMq0W2YiuXa1hVp/LgQKiGOSGWVLWXV+tb0hBpK3U1QDlDJ3bOzCucj3MY4hWJOtLk/+TQeDRXEYIC32dlvDblnhru6gz/cR1Mw4njU3yBpRnvzM/ig7Rz6joZJt6OvVWHg3/GgeNCXHqxUX/lvzciYA+I65BfSEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=1Z3leaBy+pRIAXXwPv0KAd/4/p5cs2eAokFeNYkaFdk=;
	b=Ee1zGLOMUFd0ammO/tPtAc1AUq/6JMTuYmuY9qfOhA6LTEnudrlgZLDRLnRgyDfC0mMYmGOa5CBGJ3cfRJm/OaGXmrDdisLOhaJd8pfHcBKjphREci62ylwC5hOXDAQjib1tqg75LFLth3X3JOctHpKZr+HN5XuCGq1U2xgRsYqSnNMdYyKpAjuprLamooREpjg/1ksPyxHC/12PSr1zvvEjT46+3FT0vyMwicHpc6Jej5T3AEKV/cRDggvSzB8YvZliTHNl/cVsEtPdpssJRWh2mMaQdUA+vDIPGK3YWvPV3YhW3lsCaMKGRT1rMQRyQjyk1Rwx8r9LKDSRdKYszw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
	smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com;
	dkim=pass header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=1Z3leaBy+pRIAXXwPv0KAd/4/p5cs2eAokFeNYkaFdk=;
	b=zNiZ48dSVtsDcUl1GUiO+9RR8jkXNzS2wt2YwiRWiUSGhtg0R5YyDc16jjZJqQWreQL1pdGeJRegYeGYyxRq1ZJJ0p9WAvC7Zx4mRsOvKon8zuhd5CHlJUopowdIKPHlC/Gs5iQuxQS2ROqxMCFS5lhgDotn+9cVn/yMfp+HTtI=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
	DM6PR12MB3049.namprd12.prod.outlook.com (20.178.30.91) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2094.16; Wed, 24 Jul 2019 17:34:27 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::9c3d:8593:906c:e4f7]) by
	DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2094.013;
	Wed, 24 Jul 2019 17:34:27 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To: Robin Murphy <robin.murphy@arm.com>, "Kirill A. Shutemov"
	<kirill@shutemov.name>
Subject: Re: [PATCH] dma-direct: Force unencrypted DMA under SME for certain
	DMA masks
Thread-Topic: [PATCH] dma-direct: Force unencrypted DMA under SME for certain
	DMA masks
Thread-Index: AQHVN1HbhkVejMp04kW0O/tJG/K57qbaAcwAgAANJYCAAAaagIAAB+IA
Date: Wed, 24 Jul 2019 17:34:26 +0000
Message-ID: <c4110c6b-686c-7e77-fedc-33782e5b3e50@amd.com>
References: <10b83d9ff31bca88e94da2ff34e30619eb396078.1562785123.git.thomas.lendacky@amd.com>
	<20190724155530.hlingpcirjcf2ljg@box>
	<acee0a74-77fc-9c81-087b-ce55abf87bd4@amd.com>
	<a89e7574-096d-9105-45ff-34bbb74918a5@arm.com>
In-Reply-To: <a89e7574-096d-9105-45ff-34bbb74918a5@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0069.namprd05.prod.outlook.com
	(2603:10b6:803:41::46) To DM6PR12MB3163.namprd12.prod.outlook.com
	(2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cacfdb1-e3f9-4cba-4972-08d7105d2cf5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB3049; 
x-ms-traffictypediagnostic: DM6PR12MB3049:
x-microsoft-antispam-prvs: <DM6PR12MB3049D842E62A866E0ADAD4C7ECC60@DM6PR12MB3049.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0108A997B2
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(189003)(199004)(31686004)(6246003)(6506007)(386003)(53546011)(305945005)(26005)(186003)(7736002)(25786009)(8676002)(99286004)(71190400001)(53936002)(36756003)(102836004)(52116002)(71200400001)(229853002)(478600001)(76176011)(4326008)(6512007)(446003)(68736007)(8936002)(66066001)(14454004)(6486002)(54906003)(64756008)(66446008)(66556008)(86362001)(3846002)(2616005)(66476007)(476003)(256004)(6436002)(11346002)(81166006)(2906002)(7416002)(316002)(81156014)(5660300002)(31696002)(66946007)(486006)(110136005)(6116002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3049;
	H:DM6PR12MB3163.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ab1lGdExGfF0iVL62Hwr+UkHXtlBDqbI31KJM3OePaWXUw54vC2hwLUYjyyvCAlM9iIwZMGt95syjnIJZb9ZUo1AIbrYLnP5dy6lBg0eStfB4PRgn6LISEqLfRcvHR+ts5pRYLWFe68gqvDQTcHyMFQRX6FOlng81U/vBcYh/DTTOOevXuN1RiWW6VDXjW+UnjzjcRcDKFhPl8cwo3zwvbR7+amHU3wpGzTWW9GKiq2+AAfSUJQCS4gK4uM4VSv8T+Vl8sTYPoz4RDdXnQbKCo2cXmM3A+YlhenGZ/9rHKkaAUB26yIln0pvyEhjVWN35jV3VCS8jguYDAI+KBGMkoltK8GGVZzdaWGLS0au2H0A5A/yfRUV95BdNgzuETDzZm99QiwUYQCC1WEvmFw6l3XDYHINflCLNTokDOWogFI=
Content-ID: <89CD18F909F8FE4886B93D54EF31032A@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cacfdb1-e3f9-4cba-4972-08d7105d2cf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2019 17:34:26.9949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3049
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Lianbo Jiang <lijiang@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>, "H . Peter
	Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
	Christoph Hellwig <hch@lst.de>
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

T24gNy8yNC8xOSAxMjowNiBQTSwgUm9iaW4gTXVycGh5IHdyb3RlOg0KPiBPbiAyNC8wNy8yMDE5
IDE3OjQyLCBMZW5kYWNreSwgVGhvbWFzIHdyb3RlOg0KPj4gT24gNy8yNC8xOSAxMDo1NSBBTSwg
S2lyaWxsIEEuIFNodXRlbW92IHdyb3RlOg0KPj4+IE9uIFdlZCwgSnVsIDEwLCAyMDE5IGF0IDA3
OjAxOjE5UE0gKzAwMDAsIExlbmRhY2t5LCBUaG9tYXMgd3JvdGU6DQo+Pj4+IEBAIC0zNTEsNiAr
MzU1LDMyIEBAIGJvb2wgc2V2X2FjdGl2ZSh2b2lkKQ0KPj4+PiDCoCB9DQo+Pj4+IMKgIEVYUE9S
VF9TWU1CT0woc2V2X2FjdGl2ZSk7DQo+Pj4+IMKgICsvKiBPdmVycmlkZSBmb3IgRE1BIGRpcmVj
dCBhbGxvY2F0aW9uIGNoZWNrIC0NCj4+Pj4gQVJDSF9IQVNfRk9SQ0VfRE1BX1VORU5DUllQVEVE
ICovDQo+Pj4+ICtib29sIGZvcmNlX2RtYV91bmVuY3J5cHRlZChzdHJ1Y3QgZGV2aWNlICpkZXYp
DQo+Pj4+ICt7DQo+Pj4+ICvCoMKgwqAgLyoNCj4+Pj4gK8KgwqDCoMKgICogRm9yIFNFViwgYWxs
IERNQSBtdXN0IGJlIHRvIHVuZW5jcnlwdGVkIGFkZHJlc3Nlcy4NCj4+Pj4gK8KgwqDCoMKgICov
DQo+Pj4+ICvCoMKgwqAgaWYgKHNldl9hY3RpdmUoKSkNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJl
dHVybiB0cnVlOw0KPj4+PiArDQo+Pj4+ICvCoMKgwqAgLyoNCj4+Pj4gK8KgwqDCoMKgICogRm9y
IFNNRSwgYWxsIERNQSBtdXN0IGJlIHRvIHVuZW5jcnlwdGVkIGFkZHJlc3NlcyBpZiB0aGUNCj4+
Pj4gK8KgwqDCoMKgICogZGV2aWNlIGRvZXMgbm90IHN1cHBvcnQgRE1BIHRvIGFkZHJlc3NlcyB0
aGF0IGluY2x1ZGUgdGhlDQo+Pj4+ICvCoMKgwqDCoCAqIGVuY3J5cHRpb24gbWFzay4NCj4+Pj4g
K8KgwqDCoMKgICovDQo+Pj4+ICvCoMKgwqAgaWYgKHNtZV9hY3RpdmUoKSkgew0KPj4+PiArwqDC
oMKgwqDCoMKgwqAgdTY0IGRtYV9lbmNfbWFzayA9IERNQV9CSVRfTUFTSyhfX2ZmczY0KHNtZV9t
ZV9tYXNrKSk7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCB1NjQgZG1hX2Rldl9tYXNrID0gbWluX25v
dF96ZXJvKGRldi0+Y29oZXJlbnRfZG1hX21hc2ssDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldi0+YnVzX2RtYV9tYXNrKTsNCj4+Pj4gKw0K
Pj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKGRtYV9kZXZfbWFzayA8PSBkbWFfZW5jX21hc2spDQo+
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiB0cnVlOw0KPj4+DQo+Pj4gSG0uIFdo
YXQgaXMgd3Jvbmcgd2l0aCB0aGUgZGV2IG1hc2sgYmVpbmcgZXF1YWwgdG8gZW5jIG1hc2s/IElJ
VUMsIGl0DQo+Pj4gbWVhbnMgdGhhdCBkZXZpY2UgbWFzayBpcyB3aWRlIGVub3VnaCB0byBjb3Zl
ciBlbmNyeXB0aW9uIGJpdCwgZG9lc24ndCBpdD8NCj4+DQo+PiBOb3QgcmVhbGx5Li4uwqAgaXQn
cyB0aGUgd2F5IERNQV9CSVRfTUFTSyB3b3JrcyB2cyBiaXQgbnVtYmVyaW5nLiBMZXQncyBzYXkN
Cj4+IHRoYXQgc21lX21lX21hc2sgaGFzIGJpdCA0NyBzZXQuIF9fZmZzNjQgcmV0dXJucyA0NyBh
bmQgRE1BX0JJVF9NQVNLKDQ3KQ0KPj4gd2lsbCBnZW5lcmF0ZSBhIG1hc2sgd2l0aG91dCBiaXQg
NDcgc2V0ICgweDdmZmZmZmZmZmZmZikuIFNvIHRoZSBjaGVjaw0KPj4gd2lsbCBjYXRjaCBhbnl0
aGluZyB0aGF0IGRvZXMgbm90IHN1cHBvcnQgYXQgbGVhc3QgNDgtYml0IERNQS4NCj4gDQo+IENv
dWxkbid0IHRoYXQgYmUgZXhwcmVzc2VkIGFzIGp1c3Q6DQo+IA0KPiDCoMKgwqDCoGlmIChzbWVf
bWVfbWFzayAmIGRtYV9kZXZfbWFzayA9PSBzbWVfbWVfbWFzaykNCg0KQWN0dWFsbHkgIT0sIGJ1
dCB5ZXMsIGl0IGNvdWxkIGhhdmUgYmVlbiBkb25lIGxpa2UgdGhhdCwgSSBqdXN0IGRpZG4ndA0K
dGhpbmsgb2YgaXQuDQoNClRoYW5rcywNClRvbQ0KDQo+IA0KPiA/DQo+IA0KPiBSb2Jpbi4NCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxp
bmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
