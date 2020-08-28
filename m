Return-Path: <SRS0=8RI2=CG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9289C433E2
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 15:44:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E90820872
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 15:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xSNoaW+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E90820872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 42646203EF;
	Fri, 28 Aug 2020 15:44:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XM836C0lrmM5; Fri, 28 Aug 2020 15:44:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 35BE32037A;
	Fri, 28 Aug 2020 15:44:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F4D5C016F;
	Fri, 28 Aug 2020 15:44:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8CE1C0051
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 15:44:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A3A5F203A8
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 15:44:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Uk4Bl5mgRJ6N for <iommu@lists.linux-foundation.org>;
 Fri, 28 Aug 2020 15:44:51 +0000 (UTC)
X-Greylist: delayed 00:33:15 by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by silver.osuosl.org (Postfix) with ESMTPS id 2A37C2037A
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 15:44:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7h5wzvS/9YLyb07aEjEir34hFL5AE4f0belDWrm90D4aO+dpCI/wmz44trr/MDgitIRWmjL0Enc8U6JYnxAAuT2qJl0E4b+fsVVM7nzXsTlHpv2qG6RV1J3QOqTfA63F1NMmeC9y7/eA6fsg8bcZ4bYEldeo37tC6A4uZp4bnRcqmEYvNvzKKroHRgu5Y+RXWHYa4eZvHPnvmVgkG/s7Hq3b86UyOh6kgJRLEiO0k7rK79m9rbTuO362rwogwTq25sAhQ2ICQDVtG81p9MW2a5eE7B+UtanpDWrP+PXLsmkGnqFMir8DhcPlyGY2et4o8VyGzaXrcNkXBZDovhgmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFloP/PzPfEQO2SCHdgGRRvevMmmCYOe4vGwfMq0FD0=;
 b=VS9JpwOk9wWEhM8o/9Djy6WCp+qAL95UuEiIE/G/Xs2Ukd8urpY3wsjeDAkqaKlgez/8HIYOQTxia0dHUyhLVhWZ3XoDlu24gngy7ooZxhtag0tesLNRcdyJb5ugknnpOcmLVMnGfsqm5wh85Z5rozhdvz534B/8xyS9sDF5aouWaG1Jm8ZSQ1RRuOp0WCo9zZYEwMG+7Xx9kN3FvOB/QR5f2bNdAdm0G54vgqFfSLGaFN7MCFK7whsQj9AtsGhrsE6u1y2iAvY746U21pRtNDYBtxmZwfVQErq4TFAGnawiBzPLI5UUPU/YJG0FfukbwZSkCfQLeebnGuM2uWLbOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFloP/PzPfEQO2SCHdgGRRvevMmmCYOe4vGwfMq0FD0=;
 b=xSNoaW+dyiwrcLPTekhGMIMHDj437nRMXtObf/IdmKLcg0rwqXNhcZ7SkC8y5cYpuw+e7BBpJ6Ff/DbTLHIlfmvOYwhQV2eNTsqehQ/fu46fPZLHEwyIe/Un2t7zwRqiNBaA8RvK8ndRZfrpFJxWvUM4L/1x0SOQZt5rQjvF8EU=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 28 Aug
 2020 15:11:33 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3305.032; Fri, 28 Aug 2020
 15:11:32 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "jroedel@suse.de"
 <jroedel@suse.de>
Subject: RE: [PATCH 0/2] iommu/amd: Fix IOMMUv2 devices when SME is active
Thread-Topic: [PATCH 0/2] iommu/amd: Fix IOMMUv2 devices when SME is active
Thread-Index: AQHWegTrKFaLvteaIU+zNTDEWFvNM6lKcXK8gAATzoCAAABa0IADCauAgAACVICAABPWsA==
Date: Fri, 28 Aug 2020 15:11:32 +0000
Message-ID: <MN2PR12MB448849D3AD019749DB64A146F7520@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200824105415.21000-1-joro@8bytes.org>
 <MN2PR12MB4488D6B7BBF98845DF796E0BF7540@MN2PR12MB4488.namprd12.prod.outlook.com>
 <34db343f-cd23-09af-3bc5-29b9d385f85d@amd.com>
 <MN2PR12MB4488BF7DDE700378F7B2776CF7540@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20200828134639.GW3354@suse.de>
 <60067932-dbf4-d67b-cf11-4dd2b016ed63@amd.com>
In-Reply-To: <60067932-dbf4-d67b-cf11-4dd2b016ed63@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-28T15:11:24Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=393bb5a9-e5ee-4043-af31-000051829875;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-28T15:11:18Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 1d565f24-41f6-48ba-b6e3-0000e2140da4
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-28T15:11:26Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 5180bf43-5449-46d6-bc75-0000a773d2dd
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e515c213-e70b-40fe-0f9c-08d84b64a626
x-ms-traffictypediagnostic: MN2PR12MB4143:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB41430A2AFCA09C1D73D6DCA4F7520@MN2PR12MB4143.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mPNhvJIWYmaZcmC779bQxYGA1zJg9nRAbC3f90ex02036cmiE5DZTaUA1LLnm4rsZzBKUoCghce/hm6fUU1h2WsBDX99hNsXwXjtPDSWkht8M+aRmfKl9sTx6FfitPOpFPgVJOr/5TusO635J6yRvL0ToNwMG+kduIRqlO2pyaU++PeMwUaX6ixDJnmQCcANYkJOWuJ8Qmn+AHBD2SNEChG+gR5RKpvSWO7OhGgr3VlrfE0v673RSCtBe987DYge+NEADwmvs3aMk7pAdwhwCOcUt1M1+K2mV+57Mru2YKoP0kHwS0l6l6HNpojusVTRgBxCRgap7L2SMVVVfjzybQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(9686003)(5660300002)(83380400001)(7696005)(55016002)(2906002)(186003)(86362001)(54906003)(8936002)(4326008)(26005)(110136005)(6506007)(33656002)(53546011)(66476007)(66556008)(64756008)(66446008)(76116006)(71200400001)(66946007)(478600001)(8676002)(52536014)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: cUIRoRqtDb2j5ZLVlcROnzbFNCeVfFsA6SfdgxEjqK32dQvVGVRIRT9it/KJ63Wk9XjxmJCtLphf46mFKtzA02U3Pr4SjJnomgQ/OLU7Tz18rM4H8K6jPWPg/RS1ydpOYNYAakml49dVzH4xewlIg9kA1IAtVr6Via+SIb07s+eTt7pzgKxKBQMmVEZFAPGDwHZhd8cslUjUTA1U7nCZgKShNdLGcMe0KeVRV0YMg0vzhOTKq1QZcJut/l7CMKD8Iem/pCg/2oDj4tgrCavXHq+ggcp2wT/jOFTrk8//4Xe1qpdyR8+hTHnec/AcF9L3uUOpFaajH91q5aLGoSaHPKffrrCRJmW9QBssOP6qTajIbajk8/epKTwZl2UwbxsUj4vYg4vy8OAxkvCfySGnTwwy2vlNdt8NFam1W/lfTMsiqdaKNsGLg2fTUp93JCq9glwKuATVi7gB5NGSlsBW5NAvn8NTc+EAcSF1kPg33cREkzK37fDsLEroLvIiRqgBXgbueqp+9bf7gIl0+JbyO/twHqskRrEglbU3FlCkBGueuDiN92s/NHgiFPYGmIjkgn2ZU4yOrnvlRj4uewsoJHAQczYLG4ci56Hb5Ar1s+LXwGoYVm/PznuR02aLpPLyLo4xccEBmQHG0djffXXSuA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e515c213-e70b-40fe-0f9c-08d84b64a626
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 15:11:32.7776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GV0aKyVIjvlJ73r71JaRRunAJFTdxDzTPWfSQl0T+xY8r5vqJVVkskWBwPLXDtjM3wRAQJrt4bg7oyFIWtLMvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
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

W0FNRCBQdWJsaWMgVXNlXQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj4gU2VudDogRnJpZGF5
LCBBdWd1c3QgMjgsIDIwMjAgOTo1NSBBTQ0KPiBUbzoganJvZWRlbEBzdXNlLmRlOyBEZXVjaGVy
LCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IENjOiBKb2VyZyBSb2Vk
ZWwgPGpvcm9AOGJ5dGVzLm9yZz47IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOw0K
PiBIdWFuZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+IDxD
aHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBMZW5kYWNreSwgVGhvbWFzDQo+IDxUaG9tYXMuTGVu
ZGFja3lAYW1kLmNvbT47IFN1dGhpa3VscGFuaXQsIFN1cmF2ZWUNCj4gPFN1cmF2ZWUuU3V0aGlr
dWxwYW5pdEBhbWQuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIDAvMl0gaW9tbXUvYW1kOiBGaXggSU9NTVV2MiBkZXZpY2VzIHdoZW4gU01F
IGlzDQo+IGFjdGl2ZQ0KPiANCj4gQW0gMjAyMC0wOC0yOCB1bSA5OjQ2IGEubS4gc2NocmllYiBq
cm9lZGVsQHN1c2UuZGU6DQo+ID4gT24gV2VkLCBBdWcgMjYsIDIwMjAgYXQgMDM6MjU6NThQTSAr
MDAwMCwgRGV1Y2hlciwgQWxleGFuZGVyIHdyb3RlOg0KPiA+Pj4gQWxleCwgZG8geW91IGtub3cg
aWYgYW55b25lIGhhcyB0ZXN0ZWQgYW1kZ3B1IG9uIGFuIEFQVSB3aXRoIFNNRQ0KPiA+Pj4gZW5h
YmxlZD8gSXMgdGhpcyBjb25zaWRlcmVkIHNvbWV0aGluZyB3ZSBzdXBwb3J0Pw0KPiA+PiBJdCdz
IG5vdCBzb21ldGhpbmcgd2UndmUgdGVzdGVkLiAgSSdtIG5vdCBldmVuIHN1cmUgdGhlIEdQVSBw
b3J0aW9uDQo+ID4+IG9mIEFQVXMgd2lsbCB3b3JrIHByb3Blcmx5IHdpdGhvdXQgYW4gaWRlbnRp
dHkgbWFwcGluZy4gIFNNRSBzaG91bGQNCj4gPj4gd29yayBwcm9wZXJseSB3aXRoIGRHUFVzIGhv
d2V2ZXIsIHNvIHRoaXMgaXMgYSBwcm9wZXIgZml4IGZvciB0aGVtLg0KPiA+PiBXZSBkb24ndCB1
c2UgdGhlIElPTU1VdjIgcGF0aCBvbiBkR1BVcyBhdCBhbGwuDQo+ID4gSXMgaXQgcG9zc2libGUg
dG8gbWFrZSB0aGUgSU9NTVV2MiBwYXRocyBvcHRpb25hbCBvbiBpR1BVcyBhcyB3ZWxsDQo+ID4g
d2hlbiBTTUUgaXMgYWN0aXZlIChvciBiZXR0ZXIsIHdoZW4gdGhlIEdQVSBpcyBub3QgaWRlbnRp
dHkgbWFwcGVkKT8NCj4gDQo+IFllcywgd2UncmUgd29ya2luZyBvbiB0aGlzLiBJT01NVXYyIGlz
IG9ubHkgbmVlZGVkIGZvciBLRkQuIEl0J3Mgbm90IG5lZWRlZA0KPiBmb3IgZ3JhcGhpY3MuIEFu
ZCB3ZSdyZSBtYWtpbmcgaXQgb3B0aW9uYWwgZm9yIEtGRCBhcyB3ZWxsLg0KPiANCj4gVGhlIHF1
ZXN0aW9uIEFsZXggYW5kIEkgcmFpc2VkIGhlcmUgaXMgbW9yZSBnZW5lcmFsLiBXZSBtYXkgaGF2
ZSBzb21lDQo+IGFzc3VtcHRpb25zIGluIHRoZSBhbWRncHUgZHJpdmVyIHRoYXQgYXJlIGJyb2tl
biB3aGVuIHRoZSBmcmFtZWJ1ZmZlciBpcw0KPiBub3QgaWRlbnRpdHkgbWFwcGVkLiBUaGlzIHdv
dWxkIGJyZWFrIHRoZSBpR1BVIGluIGEgbW9yZSBnZW5lcmFsIHNlbnNlLA0KPiByZWdhcmRsZXNz
IG9mIEtGRCBhbmQgSU9NTVV2Mi4gSW4gdGhhdCBjYXNlLCB3ZSBkb24ndCByZWFsbHkgbmVlZCB0
byB3b3JyeQ0KPiBhYm91dCBicmVha2luZyBLRkQgYmVjYXVzZSB3ZSBoYXZlIGEgbXVjaCBiaWdn
ZXIgcHJvYmxlbS4NCg0KVGhlcmUgYXJlIGh3IGJ1Z3Mgb24gUmF2ZW4gYW5kIHByb2JhYmx5IENh
cnJpem8vU3RvbmV5IHdoZXJlIHRoZXkgbmVlZCAxOjEgbWFwcGluZyB0byBhdm9pZCBidWdzIGlu
IHNvbWUgY29ybmVyIGNhc2VzIHdpdGggdGhlIGRpc3BsYXlzLiAgT3RoZXIgR1BVcyBzaG91bGQg
YmUgZmluZS4gIFRoZSBWSURzIGlzIDB4MTAwMiBhbmQgdGhlIERJRHMgYXJlIDB4MTVkZCBhbmQg
MHgxNWQ4IGZvciByYXZlbiB2YXJpYW50cyBhbmQgMHg5ODcwLCAweDk4NzQsIDB4OTg3NSwgMHg5
ODc2LCAweDk4NzcgYW5kIDB4OThlNCBmb3IgY2Fycml6byBhbmQgc3RvbmV5LiAgQXMgbG9uZyBh
cyB3ZSBwcmVzZXJ2ZSB0aGUgMToxIG1hcHBpbmcgZm9yIHRob3NlIGFzaWNzLCB3ZSBzaG91bGQg
YmUgZmluZS4NCg0KQWxleA0KDQo+IA0KPiBSZWdhcmRzLA0KPiDCoCBGZWxpeA0KPiANCj4gDQo+
ID4NCj4gPiBSZWdhcmRzLA0KPiA+DQo+ID4gCUpvZXJnDQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
