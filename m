Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC19CC433EF
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 20:59:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 505CE40903;
	Wed,  8 Dec 2021 20:59:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b48sVHHz-t3S; Wed,  8 Dec 2021 20:59:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3628F40195;
	Wed,  8 Dec 2021 20:59:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D60FC001E;
	Wed,  8 Dec 2021 20:59:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7A81C0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 20:59:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 97E9260BA7
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 20:59:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e1GOYUmE0EHg for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 20:59:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CAA8960B91
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 20:59:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvJTeM/qEJqUHnJi4kmlsshLyjhxlX9eOqfKfNsMyaAQzqQ6OYFY9Ef9XHuOQGvQYalR4I9L0zzj8x4QN2PN8K8yP6cWEDZagY2kJOyhOEyUKQkQaRxajsIYnHC0mdP3ijOq6z08CuDF8DYqj+17lydTM0Er2qjkafFHriM3YRMJeLBaE62PnhWaMiRQAFf1B5CoVRIslXj/je+1gaTu/ZuH/K3ZOHeCfUI2xCw0MTH1ngH2Q6lnySe4bIHHKyf7ustN4aHX59ORID05ZoOR56m3pYlTVcYX5QnKmrLha9K5KQ2NSJkLDLw0GNWAy2Zr7LhXm75WjAUT9Zi8N96XcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfzE93B1XQO5sUE7mcQ9XWGBnUEc1oIR5TGlenpC6xY=;
 b=LRC5c5qGb8XBNZX4dcYNxeaPEKT41j3+O/RZrLgqCNXvdUwmzwk4LBxmfqScBfW2NzbvbR5ev+7WY/pS4dcsgwzi61cMQHP4NjDWm9RLRD8AqcPWMDK3riPxxnZJ5M9/NQ+mTwX0t02JQA1juqRfmsAQjyOxL+bRhj+/8LNmWmtOC3Ny6pLJ06HetgltQRt4EH79ucBVlMyASuncUIh/zE9dccHeR3w/2CggdhmH99rel8i2gq/Ft3j8xeagrioF9tEmjWZJl8sWryI7fEC4iktgAl00ldcH7Lshn40vIdQe616hVsom26GrT/V1ZpvS4v+toRKBSyEAiuDo+Os49g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.13) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfzE93B1XQO5sUE7mcQ9XWGBnUEc1oIR5TGlenpC6xY=;
 b=KYabe7EjyUzkFRVTMTqMSexwIJIpUbxEiQp1ZhP/9xfPdSqeDY68hmzspBqgkB9JGguYUpPr3bFLNdfXXgK3m0NfCNLA64NEZ3521RnZLiQd2P9u8EtK+vIk+vGTM9DvO7K/8dtsdg4ePTGbNiDmUOI3kC/xNSWfX+iDJnL1noM8dpQJfVkpkKy8KGNHjXOVx/79tlhvmimHhx2X+6HrM/68KM2F5WpAyAbyTQPTPkagii00JqfXVXCYsueaR5hlvlLq7MIpXvU7A+pZHTg+KG2ERAiXtvY2aPn9omQT7yWHwi+Wrzc/rmOnOyV2fIgOPlA8wRiLgNAJFJ34TzEh5A==
Received: from BN9PR03CA0088.namprd03.prod.outlook.com (2603:10b6:408:fc::33)
 by PH0PR12MB5419.namprd12.prod.outlook.com (2603:10b6:510:e9::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Wed, 8 Dec
 2021 20:59:01 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::63) by BN9PR03CA0088.outlook.office365.com
 (2603:10b6:408:fc::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend
 Transport; Wed, 8 Dec 2021 20:59:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.13)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.13 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.13; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.13) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 20:59:00 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Dec
 2021 20:58:57 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Dec
 2021 12:58:55 -0800
Received: from Asurada-Nvidia (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18 via Frontend
 Transport; Wed, 8 Dec 2021 12:58:55 -0800
Date: Wed, 8 Dec 2021 12:58:54 -0800
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v7 6/6] iommu/tegra-smmu: Add pagetable mappings to debugfs
Message-ID: <20211208205853.GA25739@Asurada-Nvidia>
References: <20211208084732.23363-1-nicolinc@nvidia.com>
 <20211208084732.23363-7-nicolinc@nvidia.com>
 <090bcb4e-ae22-bdcd-2837-e1afc3317cb6@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <090bcb4e-ae22-bdcd-2837-e1afc3317cb6@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71d95bca-f166-4fb1-ec0c-08d9ba8d8f87
X-MS-TrafficTypeDiagnostic: PH0PR12MB5419:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5419E25386FA6BF0A8D4F62CAB6F9@PH0PR12MB5419.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dodme6FiiV8jFX1KVsrJLj5slDKvAwW4DumkkLIiv1mkYVkqBjRD93fJtC1wj483EBaEN4lrwadRIjBSkVA8a8diJVqOCtv1F8uEtHiWnFqgmOY5Fl8/aE5uPM2MdEv3Lz/aE2+CeC8mDs2wvfBI0tCGgLE/IOs2ywp49cVhWz882jFFqETuEZKm/veOW+jK6413XeI2jWU7MMvzNFRr3HNn8vXzR13Pvj7G4sKkCKMGw/p21Nrh84+RcdpqwkrPSxownZ5Ps+4/ai92Z+PqUaz9uXW9Hhde08+fA4pwX2bLYZstmKiqfaVNqUJ6+uB4qlsXU8hqiWJJ3pJg+2k7HAoRh9cY5xOtPgQCx9jnXBKaiaUn6lDIt2ONAmy4I8GRZPHrqLbJMdUGPfQni0ZI8I4M9HIanuhYwjZWkN2kNsGVCJN+zXufz0pX+2pbcHihZGX5jHMNOwq6HyWIhLdU/8pEeynbKybTwuAfin5opbPJQOFtwrETjpCTRG/U/5iDCcrFriwZHv66bBcdUedDVhabFM3w8r+DSWSbT159nZ9dv1a35ELc7ud7vocYF0gE8pt4phBOzM5AOkw3YgCAl/dYxJAloFVvozflsZUuIQUXGps68yt13lwNUyrRorfLUjVZKYmtAtDG3MVhRDymi3sq9PuUMtMSYFXN59g1JEVgPa+kdXce55ydl7Kjk1HfB4x3ZNEoTk7H0RsS9DNU+4P3MddzLMtRw392Ewwo7ji96ucHKYSkdiH4NdooWEDsrqmPXoVNTRqOmOWCh2puF8v2ibIWmHhlvsTQuSYx6bQ=
X-Forefront-Antispam-Report: CIP:203.18.50.13; CTRY:HK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:hkhybrid02.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(83380400001)(4326008)(5660300002)(70206006)(70586007)(6916009)(8676002)(33656002)(7636003)(2906002)(54906003)(9686003)(47076005)(86362001)(186003)(40460700001)(426003)(356005)(316002)(34070700002)(82310400004)(1076003)(508600001)(336012)(55016003)(26005)(8936002)(36860700001)(33716001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 20:59:00.5997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d95bca-f166-4fb1-ec0c-08d9ba8d8f87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[203.18.50.13];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5419
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

T24gV2VkLCBEZWMgMDgsIDIwMjEgYXQgMDc6MDk6MzdQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0
dGFjaG1lbnRzCj4gCj4gCj4gMDguMTIuMjAyMSAxMTo0NywgTmljb2xpbiBDaGVuINC/0LjRiNC1
0YI6Cj4gPiAgc3RhdGljIHZvaWQgdGVncmFfc21tdV9hdHRhY2hfYXMoc3RydWN0IHRlZ3JhX3Nt
bXUgKnNtbXUsCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHRlZ3Jh
X3NtbXVfYXMgKmFzLAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVk
IGludCBzd2dyb3VwKQo+ID4gQEAgLTUxNyw2ICs2NDYsMTIgQEAgc3RhdGljIHZvaWQgdGVncmFf
c21tdV9hdHRhY2hfYXMoc3RydWN0IHRlZ3JhX3NtbXUgKnNtbXUsCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgZGV2X3dhcm4oc21tdS0+ZGV2LAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICJvdmVyd3JpdGluZyBncm91cC0+YXMgZm9yIHN3Z3JvdXA6ICVzXG4iLCBzd2dycC0+
bmFtZSk7Cj4gPiAgICAgICAgICAgICAgIGdyb3VwLT5hcyA9IGFzOwo+ID4gKwo+ID4gKyAgICAg
ICAgICAgICBpZiAoc21tdS0+ZGVidWdmc19tYXBwaW5ncykKPiA+ICsgICAgICAgICAgICAgICAg
ICAgICBkZWJ1Z2ZzX2NyZWF0ZV9maWxlKGdyb3VwLT5zd2dycC0+bmFtZSwgMDQ0NCwKPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNtbXUtPmRlYnVnZnNfbWFw
cGluZ3MsIGdyb3VwLAo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgJnRlZ3JhX3NtbXVfZGVidWdmc19tYXBwaW5nc19mb3BzKTsKPiAKPiBJIG5vdGljZWQgdGhp
cyBpbiBLTVNHOgo+IAo+ICB0ZWdyYS1tYyA3MDAwZjAwMC5tZW1vcnktY29udHJvbGxlcjogb3Zl
cndyaXRpbmcgZ3JvdXAtPmFzIGZvciBzd2dyb3VwOiBnMgo+ICBkZWJ1Z2ZzOiBGaWxlICdnMicg
aW4gZGlyZWN0b3J5ICdtYXBwaW5ncycgYWxyZWFkeSBwcmVzZW50IQo+ICB0ZWdyYS1tYyA3MDAw
ZjAwMC5tZW1vcnktY29udHJvbGxlcjogb3ZlcndyaXRpbmcgZ3JvdXAtPmFzIGZvciBzd2dyb3Vw
OiBnMgo+ICBkZWJ1Z2ZzOiBGaWxlICdnMicgaW4gZGlyZWN0b3J5ICdtYXBwaW5ncycgYWxyZWFk
eSBwcmVzZW50Cj4gCj4gRG9lc24ndCBsb29rIG9rYXksIHBsZWFzZSBmaXguCgpUaGFua3MgZm9y
IHRlc3RpbmcgYW5kIHJlcG9ydGluZyEKCkkgd2lsbCBzZWUgYW5kIGZpeCBpdCBhbG9uZyB3aXRo
IHlvdXIgb3RoZXIgY29tbWVudHMuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by9pb21tdQ==
