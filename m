Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924ECC43334
	for <iommu@archiver.kernel.org>; Thu, 16 Jun 2022 22:24:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0FFD84387;
	Thu, 16 Jun 2022 22:24:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F0FFD84387
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XD08cyGk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xmxCyB8fEwmK; Thu, 16 Jun 2022 22:24:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B8240842E2;
	Thu, 16 Jun 2022 22:24:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B8240842E2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BA16C0039;
	Thu, 16 Jun 2022 22:24:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59FD8C002D;
 Thu, 16 Jun 2022 22:24:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0460260BF7;
 Thu, 16 Jun 2022 22:24:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0460260BF7
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=XD08cyGk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DuaDLkglqbt2; Thu, 16 Jun 2022 22:24:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7BF87607AA
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::630])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7BF87607AA;
 Thu, 16 Jun 2022 22:24:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diktG6hTdVQkBYVmDWXs0LJ54eVpVmRRjxPSUwgnDQKDY12A2eqKbc8Lw3OKTM/9XWg4kmSW4dgBQoOiPJogJRV3VUEV9t2HAbObrX35mPmExrvsMVnwyaYibzocMJK2pFi5w2xrecJ+n3Ew/iY5MOeqddeTuOX+o78B34RS563gSMOPSJSTj3bQ8oG78QPOHtvJOHTq5ZJWwxYBXtpqaoC0g3JaAD9btfc3JTinpcGg/j/kCUkWfOcI0zR1MvDBK3kd8snxpKH/djUVcVWLM/6BiH4Mn3ksl3ECQQOK+AnS7xhU2UnZxTv/877hRANrw1zs2J7WsQ5DvlJ/05phUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRmIP8znmtXCxGg/0nCAah4uNhMATzm14FiLLgF+JEI=;
 b=HzVY8FXIRgnanWofdJci4xsAJn2JyV7PDewVi4d3i+cYztYF5QqOAnP7ni5v5Kv6WEgBlhyMgUyytxk0/QQBVHLgy58+fLp7+dTPfzqPb25gcmuVtAyMX53WCSJBeF5BWmiBaqBvEr79MxqxQRmfOayrHY+RBk9xHFCtdI2ekf9oAONZNy8644MQrBd7NgXMQDbkwtVZra6mtLrFD2DZevffquN60pQB/ptZqGjBXSxXIm76ftBZBr+erT5E9BQpbsIRpSr3G+c4pZztNVv4LOaihsGgxEAsW2CciK5SSNcAsbEkPFhozF4AplQLAAQoTCgiVAsK1CPvmT7vlxFjeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRmIP8znmtXCxGg/0nCAah4uNhMATzm14FiLLgF+JEI=;
 b=XD08cyGk43jniY/h0cH/KRq2Ju/iMhqb2p48bh7WL7jWU91aveqlvUhHDO/XOjT5msITe9lBuhTVo5nAgRZgbnC9/YT+3QVzJjqv+IfNf84QBplaSekFuwtvixR/5BUuxezkTVVt/dr8m5HRbDMyFlxXWo+1s/BXT7zEuFGQyOnQ6BntfSbO89qi4riuUxUacpYcFdx9LcD9sNoQ5Xgkf3CsExCEA20+mepmhj2y9pRFGoschtKSN/ToF0Tghy4M7x82HmfoHNzihQA8U9bVz8MvMg8Pl8VleCX+UZE7qQOPx4LwhsTSCTfbDaZjMRtVkSve+YU6WwplE2oPbgYSQQ==
Received: from BN6PR17CA0019.namprd17.prod.outlook.com (2603:10b6:404:65::29)
 by BN8PR12MB4595.namprd12.prod.outlook.com (2603:10b6:408:72::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 16 Jun
 2022 22:24:08 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::3b) by BN6PR17CA0019.outlook.office365.com
 (2603:10b6:404:65::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15 via Frontend
 Transport; Thu, 16 Jun 2022 22:24:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 22:24:08 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Thu, 16 Jun 2022 22:23:35 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 16 Jun
 2022 15:23:34 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22 via Frontend
 Transport; Thu, 16 Jun 2022 15:23:31 -0700
Date: Thu, 16 Jun 2022 15:23:30 -0700
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v2 3/5] vfio/iommu_type1: Remove the domain->ops comparison
Message-ID: <YqutYjgtFOTXCF0+@Asurada-Nvidia>
References: <20220616000304.23890-1-nicolinc@nvidia.com>
 <20220616000304.23890-4-nicolinc@nvidia.com>
 <BL1PR11MB52717050DBDE29A81637BBFA8CAC9@BL1PR11MB5271.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BL1PR11MB52717050DBDE29A81637BBFA8CAC9@BL1PR11MB5271.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34a7c6cd-c395-44b9-2216-08da4fe6ee1c
X-MS-TrafficTypeDiagnostic: BN8PR12MB4595:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB459545D1FE6C9E3F4E15CA9BABAC9@BN8PR12MB4595.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4BW5EicNQc0DG3bTHZFYE46rqR0BOhsWHPiXGhS7TfHcSjU8MMwC/IJHvrLx0CaVwHdd8AJLM82kAzglyvUTCCTzKEhVVFFDcULjKeWhwWCse2Lgs8mVFw7PloxbTOsnmuUmIrWVq+VIqSyEqzMsT2TDxyLIHOX1/apavt2HQSQ5T89cNIza8Vyk7Vt9ajaqpv/XD35ru5rAT0WSx5uGEpckyfO0CAz+hMWWHTkTVrbhmAHAxC9O/VonXQ8VpV7i/m2xQYxCEHy/vmTwWtVQpeA6tFNVs4joB48SKRUHUpXJTwwyWVcDO60XVu0yv3ICoOExE9VQRVQpcAzn3dtsTViAwJu6rmi59cNcL6jFv12WxO4FPvo76qeRiVFFo9XEoI8S8b/urlou7suodXRXI6FwGEw9z6jQFOdl117q+XhIait02lHusaiQBIFxTo388sEof4ybRsfFXhH5RgPucgxXNg/wXockX9BQMWYj3la2434ieBpGOvuGn+w5JvrmNsmy1vjuriQYu+xcSWPmIF121UIcXhyrGTBjvFldQpc7VIipcbLfnNHMfwHc4RO7fki5nKMsD7G2mEKsAG1Tng1PSLFxU8WIND92WkHbGtxypEuqQQW5kDYl9MR6hp1sT7lQWGzI6Z8lEk4nogG00rFn5qahPaJ1LgN/s7lJuZhDTasJ7S9eqTAA5yRs1sC/05xICgCPyJGQRIjiaxU6OA==
X-Forefront-Antispam-Report: CIP:12.22.5.238; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(356005)(81166007)(36860700001)(186003)(316002)(336012)(47076005)(7406005)(7416002)(8676002)(8936002)(5660300002)(70206006)(2906002)(82310400005)(33716001)(55016003)(4326008)(4744005)(40460700003)(6916009)(54906003)(26005)(9686003)(86362001)(70586007)(498600001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 22:24:08.0521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a7c6cd-c395-44b9-2216-08da4fe6ee1c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.238];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4595
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
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
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "marcan@marcan.st" <marcan@marcan.st>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

T24gVGh1LCBKdW4gMTYsIDIwMjIgYXQgMDY6NDA6MTRBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3Jv
dGU6Cgo+ID4gVGhlIGRvbWFpbi0+b3BzIHZhbGlkYXRpb24gd2FzIGFkZGVkLCBhcyBhIHByZWNh
dXRpb24sIGZvciBtaXhlZC1kcml2ZXIKPiA+IHN5c3RlbXMuIEhvd2V2ZXIsIGF0IHRoaXMgbW9t
ZW50IG9ubHkgb25lIGlvbW11IGRyaXZlciBpcyBwb3NzaWJsZS4gU28KPiA+IHJlbW92ZSBpdC4K
PiAKPiBJdCdzIHRydWUgb24gYSBwaHlzaWNhbCBwbGF0Zm9ybS4gQnV0IEknbSBub3Qgc3VyZSB3
aGV0aGVyIGEgdmlydHVhbCBwbGF0Zm9ybQo+IGlzIGFsbG93ZWQgdG8gaW5jbHVkZSBtdWx0aXBs
ZSBlLmcuIG9uZSB2aXJ0aW8taW9tbXUgYWxvbmdzaWRlIGEgdmlydHVhbCBWVC1kCj4gb3IgYSB2
aXJ0dWFsIHNtbXUuIEl0IG1pZ2h0IGJlIGNsZWFyZXIgdG8gY2xhaW0gdGhhdCAoYXMgUm9iaW4g
cG9pbnRlZCBvdXQpCj4gdGhlcmUgaXMgcGxlbnR5IG1vcmUgc2lnbmlmaWNhbnQgcHJvYmxlbXMg
dGhhbiB0aGlzIHRvIHNvbHZlIGluc3RlYWQgb2Ygc2ltcGx5Cj4gc2F5aW5nIHRoYXQgb25seSBv
bmUgaW9tbXUgZHJpdmVyIGlzIHBvc3NpYmxlIGlmIHdlIGRvbid0IGhhdmUgZXhwbGljaXQgY29k
ZQo+IHRvIHJlamVjdCBzdWNoIGNvbmZpZ3VyYXRpb24uIPCfmIoKCldpbGwgZWRpdCB0aGlzIHBh
cnQuIFRoYW5rcyEKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
