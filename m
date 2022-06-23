Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8DDC43334
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 07:47:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C56C4136B;
	Thu, 23 Jun 2022 07:47:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3C56C4136B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=l2tU7xqL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QSNlvs2JzhBo; Thu, 23 Jun 2022 07:47:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 30EF6410BB;
	Thu, 23 Jun 2022 07:47:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 30EF6410BB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02AE8C0039;
	Thu, 23 Jun 2022 07:47:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B115FC002D;
 Thu, 23 Jun 2022 07:47:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7033D4051D;
 Thu, 23 Jun 2022 07:47:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7033D4051D
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=l2tU7xqL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vla78djpclh6; Thu, 23 Jun 2022 07:47:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CABA140123
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CABA140123;
 Thu, 23 Jun 2022 07:47:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQDyLETTeRG9Hiuj+wZed+Hb8HkuNuuJZ0ZFWE/jg1oxfiU+XU5ttSjAbZC6JBNw9LV061/9SmgVY1B3xgD3piFCGSud+OUyu81YajN30EqRQmVLl42mqlUWYSNUX681PuIvVSgloqcY50wDnJrLfBDgv9Kz3brUqXdcOnNcq/Y2Tr2KGJMz54eO9IIheveNgdZzkK3jMipjqdorqje3LOfrFRgbQpr/88vUAfcQ9FCZgkYHKmrNkFErtNPSp/kekJSLn+NPHfD2R5BHatvTTgHnpRB5CvYmiDSS3j7ApGHM0SgzAUw8SjAL4uSpWgsJM9uBVe0/VTQ+SE5mAHtYxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7eAAzrkzqQvAFIImCEht+etkeZakamJbPX7HA2lJBo=;
 b=Tjk0WS8PB4rx73QuA6QpgLmwOObHbaFPLBJaSMBcIV2i5KByhoqAbZ6JlAoQlNWmhJVVB6AnWXOrDKGylQg+BjASXgebMnUmqF4s78TUhyp45/g4qAn8pFa9uKrpq03ysV7E4N8Ekf3Dzy0wN2wdrvl0IiqklKUpgKJuFJUfhyVHWBT/EAu/ZzzG+8VYatpMqfJW9N/VqpiMHPV8SIrH7J4qsL2gZsOfvvqEgswfQiaoNDXBM5S3o6pBeQ5k+fcDzh1gxXIBrsYck9Lty70KKS4uCcDcqz8bH3Ba8V+JcfqPkfKs/VmZlIkT5WItEPVwAaLdqCBGOgn6npU2Xt/q+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7eAAzrkzqQvAFIImCEht+etkeZakamJbPX7HA2lJBo=;
 b=l2tU7xqLgswYGoKlIgT7oXsametqBrykUjmms9AHuIHwkksFkJ+0QwrvKbnPeghNY2osSauoFgA1Q4mlRO6HVUpBl3uURqtSTNnRCIuguHOqXZqHTfQPk9UdVGp88XNQ6yL6fdAAzIqUAqYbXYBIWP/OZTFjAtaAgqLC09lenwZtRDZcX5rFnykxYOKGS786SstKcedSXOOhlfUrKP4QrfjpYBhwx/SeO7a2oTRt9aTAZ4D/Thj4Qa06ozY52/AelHKHGndLWcbFE+nI6BJJlwD0vGCFMxQZhrtyPPv5kyHCScNypnTW+KL3MEle4FrY6BEgQbnF7tKNEtOHayh4iw==
Received: from BN9PR03CA0371.namprd03.prod.outlook.com (2603:10b6:408:f7::16)
 by MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 23 Jun
 2022 07:47:12 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::10) by BN9PR03CA0371.outlook.office365.com
 (2603:10b6:408:f7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Thu, 23 Jun 2022 07:47:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.15 via Frontend Transport; Thu, 23 Jun 2022 07:47:12 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Thu, 23 Jun 2022 07:47:04 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 23 Jun
 2022 00:47:04 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26 via Frontend
 Transport; Thu, 23 Jun 2022 00:47:01 -0700
Date: Thu, 23 Jun 2022 00:47:00 -0700
To: Robin Murphy <robin.murphy@arm.com>, "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v2 3/5] vfio/iommu_type1: Remove the domain->ops comparison
Message-ID: <YrQRgaHXi1bscYzj@Asurada-Nvidia>
References: <20220616000304.23890-1-nicolinc@nvidia.com>
 <20220616000304.23890-4-nicolinc@nvidia.com>
 <BL1PR11MB52717050DBDE29A81637BBFA8CAC9@BL1PR11MB5271.namprd11.prod.outlook.com>
 <YqutYjgtFOTXCF0+@Asurada-Nvidia>
 <6e1280c5-4b22-ebb3-3912-6c72bc169982@arm.com>
 <BN9PR11MB52760486306A90A208D7C6768CB59@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52760486306A90A208D7C6768CB59@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26759e5c-e47f-44c0-434d-08da54ec959d
X-MS-TrafficTypeDiagnostic: MW3PR12MB4554:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB455449DD9E829F25F433DD38ABB59@MW3PR12MB4554.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7IPSNh0AuummZJiCNFhCcaC2myM6rJtlM5wSVFNZK2Lm6+n92egHHQGJvZXdtHXVSepsN0l8EmLSQOyLK6iWWoefKgbfG6Dshd5TYzbPTL1W+piBBJnLwh1qtnQDQKshfUh8PDL4X8GYbQtFY9Ww+Edt3FYBYF+yqJYcSkDbb3jYjTQ2wnlDZ9XFbKKsQEiIfx6mHnV7BBIZyuOG0O2JeGNfoxvlf5QQOo45N7XY5wjC1zxTELKYCIJMSfyBeMV0f5Ahr7TInl/336rIVdlurHgeEDT5HUXSHFR8vgcUdc8+bCoyKn3GQr9JrLmvtpupYOum7bi2L3solHTTnDhg2+U2Dd9rEBNXwd8E8io19Gvz4Z4sAp0wGOBqTzgPG0psd0v8FxBIhWoHyan1T1Zj7vzqxNmo86/qeYXa1pJ6j4sIFSS7NT/xljZPOWNoQr7ShJJBP8wORiigJskb/QxubqEijA/oLRRdBDncgpHEJFnNqU7QlxMQeUA+nzy1bw4dO4oIDJKEW6wq7sfdFgY9jAIRg5xK3Sr6qO0RCQxUBKScifW985MTv6fL/b/3sDsF0VyDlrNJsoqrJJx1szz+ymsQm+Nkz3N5K6XOyRVJVG1t2ha9/VlL/pu4duHryiE/v+8vdc5GPpixSP3echtzH93xwh7aLyWWOEwusyV3oiIREvGbc75a04Pq6sDVynJ6JgcAYTTO0oakvh9fnN8+tkGcdKGvrKOVEcWCHuRIHa7dBv6ablWSl8VCQxKoupIb7klmb8J7zg1fOzRj6+0jb8O/Mm5X4ioXjSe4T/u4tc0=
X-Forefront-Antispam-Report: CIP:12.22.5.236; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(396003)(346002)(39860400002)(40470700004)(36840700001)(46966006)(41300700001)(26005)(40480700001)(83380400001)(47076005)(7416002)(55016003)(2906002)(70586007)(33716001)(40460700003)(82740400003)(82310400005)(8676002)(70206006)(81166007)(9686003)(5660300002)(4326008)(86362001)(336012)(8936002)(54906003)(356005)(53546011)(186003)(110136005)(316002)(478600001)(36860700001)(426003)(7406005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 07:47:12.3754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26759e5c-e47f-44c0-434d-08da54ec959d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.236];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4554
Cc: "cohuck@redhat.com" <cohuck@redhat.com>,
 "jordan@cosmicpenguin.net" <jordan@cosmicpenguin.net>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 "will@kernel.org" <will@kernel.org>,
 "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "saiprakash.ranjan@codeaurora.org" <saiprakash.ranjan@codeaurora.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>,
 "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
 "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
 "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "isaacm@codeaurora.org" <isaacm@codeaurora.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "marcan@marcan.st" <marcan@marcan.st>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
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
From: Nicolin Chen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gVGh1LCBKdW4gMjMsIDIwMjIgYXQgMDM6NTA6MjJBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3Jv
dGU6Cj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNo
bWVudHMKPiAKPiAKPiA+IEZyb206IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+
Cj4gPiBTZW50OiBXZWRuZXNkYXksIEp1bmUgMjIsIDIwMjIgMzo1NSBQTQo+ID4KPiA+IE9uIDIw
MjItMDYtMTYgMjM6MjMsIE5pY29saW4gQ2hlbiB3cm90ZToKPiA+ID4gT24gVGh1LCBKdW4gMTYs
IDIwMjIgYXQgMDY6NDA6MTRBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6Cj4gPiA+Cj4gPiA+
Pj4gVGhlIGRvbWFpbi0+b3BzIHZhbGlkYXRpb24gd2FzIGFkZGVkLCBhcyBhIHByZWNhdXRpb24s
IGZvciBtaXhlZC0KPiA+IGRyaXZlcgo+ID4gPj4+IHN5c3RlbXMuIEhvd2V2ZXIsIGF0IHRoaXMg
bW9tZW50IG9ubHkgb25lIGlvbW11IGRyaXZlciBpcyBwb3NzaWJsZS4gU28KPiA+ID4+PiByZW1v
dmUgaXQuCj4gPiA+Pgo+ID4gPj4gSXQncyB0cnVlIG9uIGEgcGh5c2ljYWwgcGxhdGZvcm0uIEJ1
dCBJJ20gbm90IHN1cmUgd2hldGhlciBhIHZpcnR1YWwKPiA+IHBsYXRmb3JtCj4gPiA+PiBpcyBh
bGxvd2VkIHRvIGluY2x1ZGUgbXVsdGlwbGUgZS5nLiBvbmUgdmlydGlvLWlvbW11IGFsb25nc2lk
ZSBhIHZpcnR1YWwgVlQtCj4gPiBkCj4gPiA+PiBvciBhIHZpcnR1YWwgc21tdS4gSXQgbWlnaHQg
YmUgY2xlYXJlciB0byBjbGFpbSB0aGF0IChhcyBSb2JpbiBwb2ludGVkIG91dCkKPiA+ID4+IHRo
ZXJlIGlzIHBsZW50eSBtb3JlIHNpZ25pZmljYW50IHByb2JsZW1zIHRoYW4gdGhpcyB0byBzb2x2
ZSBpbnN0ZWFkIG9mCj4gPiBzaW1wbHkKPiA+ID4+IHNheWluZyB0aGF0IG9ubHkgb25lIGlvbW11
IGRyaXZlciBpcyBwb3NzaWJsZSBpZiB3ZSBkb24ndCBoYXZlIGV4cGxpY2l0Cj4gPiBjb2RlCj4g
PiA+PiB0byByZWplY3Qgc3VjaCBjb25maWd1cmF0aW9uLiDwn5iKCj4gPiA+Cj4gPiA+IFdpbGwg
ZWRpdCB0aGlzIHBhcnQuIFRoYW5rcyEKPiA+Cj4gPiBPaCwgcGh5c2ljYWwgcGxhdGZvcm1zIHdp
dGggbWl4ZWQgSU9NTVVzIGRlZmluaXRlbHkgZXhpc3QgYWxyZWFkeS4gVGhlCj4gPiBtYWluIHBv
aW50IGlzIHRoYXQgd2hpbGUgYnVzX3NldF9pb21tdSBzdGlsbCBleGlzdHMsIHRoZSBjb3JlIGNv
ZGUKPiA+IGVmZmVjdGl2ZWx5ICpkb2VzKiBwcmV2ZW50IG11bHRpcGxlIGRyaXZlcnMgZnJvbSBy
ZWdpc3RlcmluZyAtIGV2ZW4gaW4KPiA+IGVtdWxhdGVkIGNhc2VzIGxpa2UgdGhlIGV4YW1wbGUg
YWJvdmUsIHZpcnRpby1pb21tdSBhbmQgVlQtZCB3b3VsZCBib3RoCj4gPiB0cnkgdG8gYnVzX3Nl
dF9pb21tdSgmcGNpX2J1c190eXBlKSwgYW5kIG9uZSBvZiB0aGVtIHdpbGwgbG9zZS4gVGhlCj4g
PiBhc3BlY3Qgd2hpY2ggbWlnaHQgd2FycmFudCBjbGFyaWZpY2F0aW9uIGlzIHRoYXQgdGhlcmUn
cyBubyBjb21iaW5hdGlvbgo+ID4gb2Ygc3VwcG9ydGVkIGRyaXZlcnMgd2hpY2ggY2xhaW0gbm9u
LW92ZXJsYXBwaW5nIGJ1c2VzICphbmQqIGNvdWxkCj4gPiBhcHBlYXIgaW4gdGhlIHNhbWUgc3lz
dGVtIC0gZXZlbiBpZiB5b3UgdHJpZWQgdG8gY29udHJpdmUgc29tZXRoaW5nIGJ5Cj4gPiBlbXVs
YXRpbmcsIHNheSwgVlQtZCAoUENJKSBhbG9uZ3NpZGUgcm9ja2NoaXAtaW9tbXUgKHBsYXRmb3Jt
KSwgeW91Cj4gPiBjb3VsZCBzdGlsbCBvbmx5IGRlc2NyaWJlIG9uZSBvciB0aGUgb3RoZXIgZHVl
IHRvIEFDUEkgdnMuIERldmljZXRyZWUuCj4gPgo+IAo+IFRoaXMgZXhwbGFuYXRpb24gaXMgbXVj
aCBjbGVhcmVyISB0aGFua3MuCgpUaGFua3MgKzEKCkkndmUgYWxzbyB1cGRhdGVkIHRoZSBjb21t
aXQgbG9nLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpp
b21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
