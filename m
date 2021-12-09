Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D53BC433F5
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 20:01:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19E068606A;
	Thu,  9 Dec 2021 20:01:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E3SlbEpIaBoh; Thu,  9 Dec 2021 20:01:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A832186068;
	Thu,  9 Dec 2021 20:01:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BD20C001E;
	Thu,  9 Dec 2021 20:01:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53269C0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 20:01:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2C2224EDF6
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 20:01:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ds2U6pe1HqG3 for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 20:01:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::609])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3476C4EDF5
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 20:01:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h285Yy5NEa4oAlxnTWGoLVahi/VtYuG5zirVyGqO4QeYKRfR4sTQ+vi+XVWpMFJJIV3Ax8AB44jH/cGX2sCq5W90Svw2TxSWmsbPnFeWiurj4OgjoDPJj8zb0cjs/pEIiQUxDLgwyvK9PBOFTWYu5kp6MwBmTPinAAFIp1ovEr+rx9GA0/iYKheEBrA6AlYeMaEPIw9Bi70r6DQq2JQefWsCbC1v6Fsf+bDIwyhspKQV1hsWzLAudDUySOMMHA6bDMG1EK2kPh4B7aSgeNb5yW9EOa/zertXqt7S5P7hlQXHw31pbPlmZW6FMtQv8eFq8Y/jhZvxyW5IwuFA8WjC7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/sKYk0Sk9uGT5Vu3aWJ9CSXpXyin9UyGQTDj4gkVaE=;
 b=KBK+blXQ0aX89zB0989bmXSbJY97nDXQybg/LFo0FKsKAcuL+WuczPUVPJSLqS76fLLImrPovwmTaJXA03Oyy7G6ZQh2B47s8xVZRjm58AyO9xjJ1kHgkAzjdczIlOHMt2dauibTmOTisnFYz3853bb5Cahq0AkZNxYJfGusZXVYSUSMugpLSCpfIr1jJ6dOyNFSQHCgxkfXRRWJHDDGAemsyOvEMkNiuQlx/Ge/vGt6ltNnwbT+t6NlybcTQQ1hpF3O9mQB86kVGY2jgls0dohZOKQdH+D0Z71xlt0rJq/fq8buDP4Psceqmwgo5YbuoMKW22vkxLWxarCq+dRp/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.14) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/sKYk0Sk9uGT5Vu3aWJ9CSXpXyin9UyGQTDj4gkVaE=;
 b=RKP+eKr/wWMXJUq0WVPkrgB6vv1IolDumyfGNLo9/JIhH7/Hwe6UUIcxQWCNc/5H7cXF31W4n7zdkRv+Rs6hG1n/ewXiumffz5VUGPdSJqmPofJJAz1GgoAgaRaHwKdqR7tDes3X5ifOnG7YgjWtAU8/cReYepCjqx0W856CIzENAsOaioatwKKZRi7ZG0pFRKkacYVS5Nq64xkANqh5EPnXuesmYaEt8PBZRYeqxU6kRGXPKlzlIRg7NvjW78yrzCxT+FzRDlY7Lr1QBH01yJvp5wzmXzEFUmTFyJ9G+rHyGs+pT5PRVU6PO5Wzxq2WkjtFzfQe2M8GQJjexp361w==
Received: from BN6PR1201CA0012.namprd12.prod.outlook.com
 (2603:10b6:405:4c::22) by BN9PR12MB5258.namprd12.prod.outlook.com
 (2603:10b6:408:11f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 20:01:47 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4c:cafe::d4) by BN6PR1201CA0012.outlook.office365.com
 (2603:10b6:405:4c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Thu, 9 Dec 2021 20:01:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.14)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.14 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.14; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.14) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 20:01:47 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 20:01:45 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 20:01:43 +0000
Received: from Asurada-Nvidia (172.20.187.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18 via Frontend
 Transport; Thu, 9 Dec 2021 20:01:43 +0000
Date: Thu, 9 Dec 2021 12:01:41 -0800
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v8 6/6] iommu/tegra-smmu: Add pagetable mappings to debugfs
Message-ID: <20211209200141.GA35858@Asurada-Nvidia>
References: <20211209073822.26728-1-nicolinc@nvidia.com>
 <20211209073822.26728-7-nicolinc@nvidia.com>
 <63b4c2e2-0e55-5701-4c45-70684c7e058e@gmail.com>
 <20211209192450.GA34762@Asurada-Nvidia>
 <fab11209-a579-bbfb-a701-e613cecabd56@gmail.com>
 <20211209195450.GB35526@Asurada-Nvidia>
 <520bc232-7173-dc28-2d81-6b0f42773bc8@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <520bc232-7173-dc28-2d81-6b0f42773bc8@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 539773a0-17ca-4d06-61d1-08d9bb4ebb95
X-MS-TrafficTypeDiagnostic: BN9PR12MB5258:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5258DD2710694843C1BA84E3AB709@BN9PR12MB5258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55u3wO0dJfXDmoz4Y5us58rEGiJF2kpkK6hIL2dAeTkNE4S8RDty3zC5mDatODNpI4EfN+8OOKVsVea5OTXnvP2Z/89uvN83Duv4xZuOXeWWhEID1+z0ouu9MwDA9LKW9YDbF1Z/PmWoCEa0lOvnv51rqi+NJtvRvchrtd7uldodAGYnUXaQ+0aNpZFddlW2CfN07pn7vUembNpcSyTJYbG3a5jIP0cMiFN8jZ17awEHaVUq+xyNHzvFzwKT6lLtcQqzmpVgKCzwMTn/c1zjrkpY48AgfJywPSWbjJfTImuI8MIfy/dh0l5J3IdkT7ZW0sowj15vbQaDEz6S0SeLhCRcFkOknXA5suzU7DwAxjPM+4uAf0ZRQ4tpBa/xmV7lQGGhWKrYsB3OhdhKnSQP3Sh33tVYexijE+8o0tKwRmNh/tb3DKU+LXFxbiJawxoK0XP4YIeDHWl5rbY/Qie+xeQ9kQm7BeT4SUbZ2cQetV3bGrLAKF7IEE2mjKZPfsTZ+CFgW++4HiLs/xIP9iaGsZ8r25xSEIc0R+QfEs+sm0yWx1+itszWX0iEZsoYAAuYwyLyHzB6MBLX88sRg+giPlWORisWGIAuKRXxULyi0NXMr9UIeUY1VvGHaAJ1Syj9vN9o+Sayo6+J0QLhk4sIDN3m+AaQqWc8pvon5fRXxjFiPbKoElvVQC8F0Q+EuUHmNnOE2Y/G5AZe4zwoGZO/b9PayUK/2TIdDWCo8IJk0mae+8EX9QM2xiFJiP8hW7pDMDoyhV4MDaMVUQKCYvuvBoeVVNp1TL5mZQhW30osn2o=
X-Forefront-Antispam-Report: CIP:203.18.50.14; CTRY:HK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:hkhybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(82310400004)(186003)(40460700001)(55016003)(8676002)(47076005)(34020700004)(8936002)(6916009)(426003)(26005)(356005)(508600001)(7636003)(336012)(33656002)(9686003)(4326008)(70586007)(1076003)(33716001)(70206006)(2906002)(316002)(54906003)(36860700001)(5660300002)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 20:01:47.3608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 539773a0-17ca-4d06-61d1-08d9bb4ebb95
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[203.18.50.14];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5258
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

T24gVGh1LCBEZWMgMDksIDIwMjEgYXQgMTA6NTg6MzJQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0
dGFjaG1lbnRzCj4gCj4gCj4gMDkuMTIuMjAyMSAyMjo1NCwgTmljb2xpbiBDaGVuINC/0LjRiNC1
0YI6Cj4gPiBPbiBUaHUsIERlYyAwOSwgMjAyMSBhdCAxMDo0NDoyNVBNICswMzAwLCBEbWl0cnkg
T3NpcGVua28gd3JvdGU6Cj4gPj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcg
bGlua3Mgb3IgYXR0YWNobWVudHMKPiA+Pgo+ID4+Cj4gPj4gMDkuMTIuMjAyMSAyMjoyNCwgTmlj
b2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gPj4+IE9uIFRodSwgRGVjIDA5LCAyMDIxIGF0IDA1OjQ5
OjA5UE0gKzAzMDAsIERtaXRyeSBPc2lwZW5rbyB3cm90ZToKPiA+Pj4+IEV4dGVybmFsIGVtYWls
OiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzCj4gPj4+Pgo+ID4+Pj4K
PiA+Pj4+IDA5LjEyLjIwMjEgMTA6MzgsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+ID4+Pj4+
ICtzdGF0aWMgdW5zaWduZWQgbG9uZyBwZF9wdF9pbmRleF9pb3ZhKHVuc2lnbmVkIGludCBwZF9p
bmRleCwgdW5zaWduZWQgaW50IHB0X2luZGV4KQo+ID4+Pj4+ICt7Cj4gPj4+Pj4gKyAgICAgcmV0
dXJuIChwZF9pbmRleCAmIChTTU1VX05VTV9QREUgLSAxKSkgPDwgU01NVV9QREVfU0hJRlQgfAo+
ID4+Pj4+ICsgICAgICAgICAgICAocHRfaW5kZXggJiAoU01NVV9OVU1fUFRFIC0gMSkpIDw8IFNN
TVVfUFRFX1NISUZUOwo+ID4+Pj4+ICt9Cj4gPj4+Pgo+ID4+Pj4gSSdkIGNoYW5nZSB0aGUgcmV0
dXJuIHR5cGUgdG8gdTMyIGhlcmUsIGZvciBjb25zaXN0ZW5jeS4KPiA+Pj4KPiA+Pj4gVGhlIHdo
b2xlIGZpbGUgZGVmaW5lcyBpb3ZhIHVzaW5nICJ1bnNpZ25lZCBsb25nIiwgd2hpY2ggSSBzZWUK
PiA+Pj4gYXMgdGhlIGNvbnNpc3RlbmN5Li4uIElmIHdlIGNoYW5nZSBpdCB0byB1MzIsIGl0J2Qg
YmUgcHJvYmFibHkKPiA+Pj4gbmVjZXNzYXJ5IHRvIGNoYW5nZSBhbGwgaW92YSB0eXBlcyB0byB1
MzIgdG9vLi4uIFNvIEknZCByYXRoZXIKPiA+Pj4ga2VlcCBpdCAidW5zaWduZWQgbG9uZyIgaGVy
ZS4gSWYgeW91IHNlZSBhIGJpZyBuZWNlc3NpdHkgdG8gZG8KPiA+Pj4gdGhhdCwgYW4gYWRkaXRp
b25hbCBwYXRjaCB3b3VsZCBiZSBuaWNlciBJTUhPLgo+ID4+Pgo+ID4+Cj4gPj4gSW4gZ2VuZXJh
bCBJT1ZBIGlzICJ1bnNpZ25lZCBsb25nIiwgb2YgY291cnNlLiBCdXQgaW4gY2FzZSBvZiBUZWdy
YQo+ID4+IFNNTVUsIHdlIGtub3cgdGhhdCBpcyBhbHdheXMgdTMyLgo+ID4+Cj4gPj4gQWxyaWdo
dCwgSSBzZWUgbm93IHRoYXQgdGhlcmUgYXJlIG90aGVyIHBsYWNlcyBpbiB0aGUgZHJpdmVyIGNv
ZGUgdGhhdAo+ID4+IHVzZSAidW5zaWduZWQgbG9uZyIsIHNvIG5lZWQgdG8gY2hhbmdlIGl0IGlu
IHRoaXMgcGF0Y2guCj4gPgo+ID4gSSB0aGluayB3ZSBzaG91bGQgZG8gdGhhdCBpbiBhIHNlcGFy
YXRlIHBhdGNoIHRoYXQgY2hhbmdlcyB0aGUgaW92YQo+ID4gdHlwZSBpbiB0aGUgZW50aXJlIHRl
Z3JhLXNtbXUgZmlsZS4gSSBjYW4gYWRkIG9uZSBpbiB0aGlzIHNlcmllcywgaWYKPiA+IHRoaXMg
bWFrZXMgeW91IGhhcHB5Li4uCj4gPgo+IAo+IFBsZWFzZSBrZWVwIGl0ICJ1bnNpZ25lZCBsb25n
Iiwgbm8gbmVlZCBmb3IgZXh0cmEgcGF0Y2hlcy4KCk9oLCBJIGd1ZXNzIHRoYXQgInNvIG5lZWQg
dG8gY2hhbmdlIGl0IGluIHRoaXMgcGF0Y2giIHNob3VsZCBiZQoic28gKG5vKSBuZWVkIHRvIGNo
YW5nZSBpdCBpbiB0aGlzIHBhdGNoIiB0aGVuPwpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vaW9tbXU=
