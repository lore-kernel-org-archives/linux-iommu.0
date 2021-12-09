Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A426C433FE
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 19:33:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC1014090E;
	Thu,  9 Dec 2021 19:33:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kpq-Yyd4G0_c; Thu,  9 Dec 2021 19:33:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A3CA2403D7;
	Thu,  9 Dec 2021 19:33:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6685BC006F;
	Thu,  9 Dec 2021 19:33:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CA89C0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 19:33:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5DE5B403D7
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 19:33:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id shmCv9Z8y4-m for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 19:33:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 75912402B5
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 19:33:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWQjJ90wcVSmj7FR9862E+Wazeuv+fFu7dwRV78VXGpXY5D3x/nLKU/5cFCRT1bi2+B+BAH+3+3G2uj0MDSPV9J81YgQyMhVmXQVlhQUwg3m8WYPr97KhHuqTZTZIfNIv5PRbwRV2Ai87pvXM+CpB80IsSqjipn224nzfn7iX+LzHGQfppVyr5HHfYyLm3ble3L1E2q+zjxlpWUKQKRpQ3QDFuCWB+YI+mAStVFro70yuFjuZr6aviItWtL7LR3eBs3y+6xOmm38JMJFBiPcZKN6Uev/tqTEQE17NiZpyP5hSsxb+Duqx+X84bTsVOPn5vDcETQssikz2tRfNV1fyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vC1oCsLsLFntE7Po+rLG7D6DxpSBMKUY1ECMyDmGcA=;
 b=YtW34fnFOmJFJ+3dsHKhIJl91jC4HnnzXJO2F/Ze3Dn9kASICYrGKHVhcNGDEuzQLh+pKjh0yAfUB6sFNVwJvsQC8/Yz7RaDBY36QFIuOLE3gORoKLGqKHHShSy2DrU1VVUPVT6AhLmoEs2+mRVrNEa7yvpHEi5WX06+c1vg5fZWCEmrB6rR1eLgvm+Y6qo16sUboh47VJLVySvQZwno0Du9F+NleN8MJwiVWTjkXd1dY40RrkuRuS/WCHjm+unVjuU/ynAXtS+LBXQcIDaQNZ9/OBCP2iAbkMrZmwD+t1KDpzCbKZJAWMNDhqhiO17KjSXcOJrOfYa2NMBKo+8hIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.13) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vC1oCsLsLFntE7Po+rLG7D6DxpSBMKUY1ECMyDmGcA=;
 b=NpZJ4+rVSWNJqNsfugr8ZcLIA32faFA7vpE7d1EV+wHQXTKAnZ15Qm0e+TaLcgWzK4FdBOMsc/8u5ocGyNwa6cQ4p1Oi414wUbMe6BluXNCNRX8cpOnWSON1jaZOuEkGR24uvegJXPqp/89WJm98IHWJs2J60jSFLJLJMrNtf4LBd9rU7HtHbSYFasRA572Jkx/FPIkkBUoZaXnLerp11C4NyI3QKR48mncADmlcw1S3zxYaOiI1m4f7IquVO1282KceNAeSxEmSfD2XlOf9ZwLUkBOk8NGY6FZ5CRbIzcoxPR8SEBGqSsKJJWZlduqjKYUJ9ItmePpWI1YZhCFMxg==
Received: from MW2PR16CA0012.namprd16.prod.outlook.com (2603:10b6:907::25) by
 DM6PR12MB4514.namprd12.prod.outlook.com (2603:10b6:5:2a7::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.14; Thu, 9 Dec 2021 19:33:07 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::d7) by MW2PR16CA0012.outlook.office365.com
 (2603:10b6:907::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Thu, 9 Dec 2021 19:33:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.13)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.13 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.13; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.13) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 19:33:06 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 19:32:57 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 19:32:56 +0000
Received: from Asurada-Nvidia (172.20.187.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18 via Frontend
 Transport; Thu, 9 Dec 2021 11:32:55 -0800
Date: Thu, 9 Dec 2021 11:32:54 -0800
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v8 6/6] iommu/tegra-smmu: Add pagetable mappings to debugfs
Message-ID: <20211209193253.GB34762@Asurada-Nvidia>
References: <20211209073822.26728-1-nicolinc@nvidia.com>
 <20211209073822.26728-7-nicolinc@nvidia.com>
 <5713902d-823b-63ca-00c9-aa6c64c1af41@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5713902d-823b-63ca-00c9-aa6c64c1af41@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 702f4faa-c5d3-4edb-2079-08d9bb4aba09
X-MS-TrafficTypeDiagnostic: DM6PR12MB4514:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB45145D4A8BC68C25ADB3E7FCAB709@DM6PR12MB4514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tNrOAFfLiF2ONhnxWTj5q6truJwelpjgmcAm3x/tapGMegDmsllml41nn1aaAgrmSSse5fcwuxhaIQyNi3yU/sf1BI1HM/nF0E0i983F32Du4xqtiiY0okdTXRjlq1d3xQXpt7BJ3pMF8I9Yy/ylRNzrUu6T25UtN0FCI6BBrzr+rK3RLFSqfr/idsx6yvOAgUdGbbSpmPLUNDAXCspXsynptG4q0sYhy5AgkwInK9C3egJO+EE+KiidcfMBMSKVaIuS8mJ/SBO5lbc4mZQFsIfg+RGAh6e16hY5l9IGPhVU/xMGJsRe/EuxePsN66bGvvFVhWZmetKHzOJLxwCjt5GRXqFLwe0h2AiDClz1puVVpZh7n24RCWWF34r2BGPm6zXkXbtX0ulajIb9XNpiykOiBCiKHnkPEuN/u1ak7M7E1uRg1PfOvBR8rHndfoBbaddtjco8XaJ5QXlphxRSLRP+FfhTvs6GoaVF9yR9loRSOstCrCsH0krSzszI8bPKSK7nuoml33ATKF5AVD9jgQEHitOuQNd1L+nXI43VDDeRK+wwwGIkZH5hx7xbfTbMZO56SqTKU0SJOkD74Zm1KKuPUkr0hfLYubCvmv6l9F8hIwS46vy6+PvL7B7K3of3rSG57vwGf/wm/ZsSYERKXpeV2J+ZSYSao/keDYkZRNpfP27BKngZZINfbcifk70TZJc9M8z/Xk129YjT8vAZvnyBaT8+2LVzHVuTNjWuV1Dm2w5Fvi5v4/hRXWnA8aZZOl1jTiorn2lMw8S+6Rx8TTRsJsHRwu0L+0REz9ImQMA=
X-Forefront-Antispam-Report: CIP:203.18.50.13; CTRY:HK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:hkhybrid02.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(316002)(34020700004)(9686003)(70206006)(54906003)(36860700001)(33716001)(2906002)(47076005)(4326008)(336012)(6916009)(426003)(86362001)(356005)(8936002)(7636003)(8676002)(5660300002)(55016003)(186003)(82310400004)(26005)(40460700001)(83380400001)(508600001)(70586007)(1076003)(33656002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 19:33:06.9489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 702f4faa-c5d3-4edb-2079-08d9bb4aba09
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[203.18.50.13];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4514
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

T24gVGh1LCBEZWMgMDksIDIwMjEgYXQgMDU6NDc6MThQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0
dGFjaG1lbnRzCj4gCj4gCj4gMDkuMTIuMjAyMSAxMDozOCwgTmljb2xpbiBDaGVuINC/0LjRiNC1
0YI6Cj4gPiBAQCAtNTQ1LDYgKzcxOSwxNSBAQCBzdGF0aWMgdm9pZCB0ZWdyYV9zbW11X2RldGFj
aF9hcyhzdHJ1Y3QgdGVncmFfc21tdSAqc21tdSwKPiA+ICAgICAgICAgICAgICAgaWYgKGdyb3Vw
LT5zd2dycCAhPSBzd2dycCkKPiA+ICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsKPiA+
ICAgICAgICAgICAgICAgZ3JvdXAtPmFzID0gTlVMTDsKPiA+ICsKPiA+ICsgICAgICAgICAgICAg
aWYgKHNtbXUtPmRlYnVnZnNfbWFwcGluZ3MpIHsKPiAKPiBEbyB3ZSByZWFsbHkgbmVlZCB0aGlz
IGNoZWNrPwo+IAo+IExvb2tzIGxpa2UgYWxsIGRlYnVnZnNfY3JlYXRlX2RpcigpIHVzYWdlcyBp
biB0aGlzIGRyaXZlciBhcmUgaW5jb3JyZWN0LAo+IHRoYXQgZnVuY3Rpb24gbmV2ZXIgcmV0dXJu
cyBOVUxMLiBQbGVhc2UgZml4IHRoaXMuCgpkZWJ1Z2ZzX2NyZWF0ZV9kaXIgcmV0dXJucyBFUlJf
UFRSIG9uIGZhaWx1cmUuIFNvIGhlcmUgc2hvdWxkIGJlCnRvIGNoZWNrICFJU19FUlIuIFRoYW5r
cyBmb3IgcG9pbnRpbmcgaXQgb3V0IQoKPiA+ICsgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qg
ZGVudHJ5ICpkOwo+IAo+IFRoZSBmaWxlIG5hbWUgaXMgd3JvbmcgaGVyZS4KPiAKPiAgICAgICAg
ICAgICAgICAgICAgICAgICBpZiAoZ3JvdXAtPnNvYykKPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIG5hbWUgPSBncm91cC0+c29jLT5uYW1lOwo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIGVsc2UKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5hbWUgPSBncm91cC0+
c3dncnAtPm5hbWU7CgpZZWEsIEknbGwgYWRkIHRoaXMuCgo+IAo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgIGQgPSBkZWJ1Z2ZzX2xvb2t1cChncm91cC0+c3dncnAtPm5hbWUsCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNtbXUtPmRlYnVnZnNfbWFwcGluZ3Mp
Owo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGRlYnVnZnNfcmVtb3ZlKGQpOwo+ID4gKyAgICAg
ICAgICAgICB9Cj4gCj4gVGhpcyBub3cgbG9va3MgcHJvYmxlbWF0aWMgdG8gbWUuIFlvdSBjcmVh
dGVkIGRlYnVnZnMgZmlsZSB3aGVuIHRoZQo+IGZpcnN0IG1lbWJlciBvZiB0aGUgc2hhcmVkIGdy
b3VwIHdhcyBhdHRhY2hlZCB0byBBUywgbm93IHlvdSByZW1vdmUgdGhpcwo+IGZpbGUgd2hlbiBh
bnkgZGV2aWNlIGlzIGRldGFjaGVkLiBUaGUgc2hhcmVkIGRlYnVnZnMgZmlsZSBzaG91bGQgYmUK
PiByZWZjb3VudGVkIG9yIHNvbWV0aGluZy5hCgpXaWxsIHNlZSBob3cgdG8gaGFuZGxlIGl0LgoK
VGhhbmtzCk5pYwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
