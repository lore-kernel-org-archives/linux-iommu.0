Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F15BC433F5
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 19:25:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1F458424A8;
	Thu,  9 Dec 2021 19:25:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qClxCzYcNfiG; Thu,  9 Dec 2021 19:25:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 962F1424A5;
	Thu,  9 Dec 2021 19:25:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F740C001E;
	Thu,  9 Dec 2021 19:25:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2EEABC0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 19:25:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1DDEF4297D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 19:25:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HPh-APP31cbj for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 19:25:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C06EC42938
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 19:25:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zj53xkaozwTv8K5/AxFp94cdn421lTefcOc+GHRj4AqtxBbDc+jUy/jVYXUDMAjNFkDwtaQoDElP1z1tt//namKywfANiuHLOk3nJX/KTzzBsOBzvylh8HaqNj5l5foNMdURdmPgqoYJ5mlgSPCjkg8DFAtnFycAJ/N2xwrS83eGpHNX6+UIF01NwWQ7fm+6hI0vl0+TXtZ7cTSzz9jumgkFDvsTa27vAm2AX3QQXGne0DQ99b98P57EaXaMfTbEE0AWt6TKvGSbw8ofhS8FcgRw5eAeSSEiTHtXxN47ufD6+F4sCssgx9C7ljAjZEpXHBCXy4bglrzB6o2thcL6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YoTjcosVtVSVKl7IhFxzy9ZE8iHtrD+jGoOC0yGJaI=;
 b=BBDfQOzofP9JxMmmR+MQFwX8hvn+8yzPOjAkpxfo7BZCbUvg69/2xfNBkSRjDBCUA2XwIj+QgI00nrxOcn/G88YPcAIr4nVTsTeivLr8BNVhXcfYjAzdAVR0pLBdh5LWE42RBSZd4bW34NtRdItELBeQYCj4w0Fv97ZK6GWC3hizjM8R+gsixqA5/JMLdZzjqmZV9eyZszqnjjRtpwOZqgvpFrnvodHlV/rNIkLpRivB07NQx3yFo5+yX73qdWNIBYnWGgQ2KblTZGrHm179AVR7bVRFQgqQKyAtKwR5wzCfvpiRKbzn6DAvPr/0Sfog861kkAIUYS+82C1XrQZl4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.14) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YoTjcosVtVSVKl7IhFxzy9ZE8iHtrD+jGoOC0yGJaI=;
 b=Rf3l8qxe5Hwykurh6OoW+xMF3JU7HFPD84fV1s23IUbX1hCmJkgRPQZMgtVB4ldniRBt4scOVly2l91Oz2DO9SMYW5jjGwpohZYaAIkcTUj2ZYznImSPEKjpMbcUD8its+pyf29oD8y2iI4FIzJ3cTkapTcAIiXNwU02uSms4dXg+3EG5mcrbzLKYA8UPaI7gafFHkE/zA2mFfkseELsncZ4Y1J62SQiFEIv+YzOCsz19QbueZDzsZ03oM8hHbMUlTsaIBfawy559fG7qd15hgMGTp++FTrmnjksMxxw7agTLHAJLuCv+vFegkTr6BiKfzG6WIL6y4HOTjJ9fparog==
Received: from MWHPR04CA0041.namprd04.prod.outlook.com (2603:10b6:300:ee::27)
 by MN2PR12MB3456.namprd12.prod.outlook.com (2603:10b6:208:ca::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Thu, 9 Dec
 2021 19:24:57 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ee:cafe::25) by MWHPR04CA0041.outlook.office365.com
 (2603:10b6:300:ee::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Thu, 9 Dec 2021 19:24:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.14)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.14 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.14; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.14) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 19:24:56 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 19:24:55 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 19:24:53 +0000
Received: from Asurada-Nvidia (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18 via Frontend
 Transport; Thu, 9 Dec 2021 19:24:52 +0000
Date: Thu, 9 Dec 2021 11:24:51 -0800
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v8 6/6] iommu/tegra-smmu: Add pagetable mappings to debugfs
Message-ID: <20211209192450.GA34762@Asurada-Nvidia>
References: <20211209073822.26728-1-nicolinc@nvidia.com>
 <20211209073822.26728-7-nicolinc@nvidia.com>
 <63b4c2e2-0e55-5701-4c45-70684c7e058e@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <63b4c2e2-0e55-5701-4c45-70684c7e058e@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f35654e-47f4-4428-5f62-08d9bb4995e0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3456:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3456E2A184A0E3C112282194AB709@MN2PR12MB3456.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D0TkpQkgsOxTvCed4lra6RVCl3TSC/+iUeVle6eiItgBvJqOaI1XXhm+5Bkb0YV6bBOALv06cjLtpoI53tg5FmjPyRN8uckZkl+RVnuYWBsDqRbj4H/o5uT7OqPWtmY3h/QZZv1gI9yxXbTKfLpACFAFznylPCUmgdFVlmqZLVXOsVbH711d8kLindNfDVpQw2lCN3M5nRbJxsoww1cpwlqBBt9FwkHbFKUFuLvoM8I9p7x38+T9maZZ2anI1gFU2h+LKe+0XDOX3ruJzhvA+CuX0caVRlo/YhFP001v48HlSI1kb2S/9c5J+g5jR7Bc/OUvcuKKUYtjfyPL7ZdbAEOYFbfGHbAM/SaospBRQO/5qDvbaz957PJVkfnNzTZl5SLwhWdwcab2AIQGcEGJCvvfHvGOF+/qe0xfD58o4oeAEaukTu2oNIx2fE9CsufnmgSex3INDuhRV9fV/lwXqZr/MWvnVjkaRG8owG6Fa00o/5pUoaC25ye0Ofsf/G1Ky0ZXm5az/OJbDOusCLdWGCihR/CceXMS26Ra3AyNTi4YaKW/VdeZajE3In32KXImzZ8hvZ4p/NQmMV1y0gPrfVrJCcRDLg5Fb9ok+kdu8r5+zIzWJ8b9jEDMRHqEMZdKSisxA8TY9+bvtSsXfsbLnwY1aYhWxuBJ+3mF4G8fR3NTSmHMCzCkBMdcVObfHK2EaoEul/YJgmfndHMdqPuh8DIFvm+vwnZV0qQwB7zN2Lthx01vzBfiIVn67Q9qUK0umfvXo8gnmiC7ezoRWCgn51uioos/8L84nLN4ZcdI9vk=
X-Forefront-Antispam-Report: CIP:203.18.50.14; CTRY:HK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:hkhybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(186003)(4744005)(26005)(33716001)(4326008)(1076003)(54906003)(9686003)(356005)(508600001)(86362001)(2906002)(36860700001)(8936002)(8676002)(316002)(47076005)(82310400004)(55016003)(34020700004)(6916009)(7636003)(336012)(426003)(33656002)(70206006)(70586007)(5660300002)(40460700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 19:24:56.6777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f35654e-47f4-4428-5f62-08d9bb4995e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[203.18.50.14];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3456
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 will@kernel.org
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

T24gVGh1LCBEZWMgMDksIDIwMjEgYXQgMDU6NDk6MDlQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0
dGFjaG1lbnRzCj4gCj4gCj4gMDkuMTIuMjAyMSAxMDozOCwgTmljb2xpbiBDaGVuINC/0LjRiNC1
0YI6Cj4gPiArc3RhdGljIHVuc2lnbmVkIGxvbmcgcGRfcHRfaW5kZXhfaW92YSh1bnNpZ25lZCBp
bnQgcGRfaW5kZXgsIHVuc2lnbmVkIGludCBwdF9pbmRleCkKPiA+ICt7Cj4gPiArICAgICByZXR1
cm4gKHBkX2luZGV4ICYgKFNNTVVfTlVNX1BERSAtIDEpKSA8PCBTTU1VX1BERV9TSElGVCB8Cj4g
PiArICAgICAgICAgICAgKHB0X2luZGV4ICYgKFNNTVVfTlVNX1BURSAtIDEpKSA8PCBTTU1VX1BU
RV9TSElGVDsKPiA+ICt9Cj4gCj4gSSdkIGNoYW5nZSB0aGUgcmV0dXJuIHR5cGUgdG8gdTMyIGhl
cmUsIGZvciBjb25zaXN0ZW5jeS4KClRoZSB3aG9sZSBmaWxlIGRlZmluZXMgaW92YSB1c2luZyAi
dW5zaWduZWQgbG9uZyIsIHdoaWNoIEkgc2VlCmFzIHRoZSBjb25zaXN0ZW5jeS4uLiBJZiB3ZSBj
aGFuZ2UgaXQgdG8gdTMyLCBpdCdkIGJlIHByb2JhYmx5Cm5lY2Vzc2FyeSB0byBjaGFuZ2UgYWxs
IGlvdmEgdHlwZXMgdG8gdTMyIHRvby4uLiBTbyBJJ2QgcmF0aGVyCmtlZXAgaXQgInVuc2lnbmVk
IGxvbmciIGhlcmUuIElmIHlvdSBzZWUgYSBiaWcgbmVjZXNzaXR5IHRvIGRvCnRoYXQsIGFuIGFk
ZGl0aW9uYWwgcGF0Y2ggd291bGQgYmUgbmljZXIgSU1ITy4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2lvbW11
