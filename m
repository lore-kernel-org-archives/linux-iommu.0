Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30663C433F5
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 19:51:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C408E6F8B8;
	Thu,  9 Dec 2021 19:51:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m4RphaxnfHWW; Thu,  9 Dec 2021 19:51:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9D1DC6F8B6;
	Thu,  9 Dec 2021 19:51:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74DF0C001E;
	Thu,  9 Dec 2021 19:51:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90E76C0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 19:51:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 85A026F8B8
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 19:51:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K1DXNz8i1Kwt for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 19:51:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::616])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B4F736F8B6
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 19:51:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMNDyNCWf8wD9mappMD1wV1rhMSkafr2urQY91O7ghy3H3FdmTfEjRlPfSrUAzOGSO/xdfK1vn68DtMr+EH1L27lBJjMkT7KT/M6pwi2unPZHnFtnenb9IL8rV/ZQ3RADpX/jb00I8SQYzT5Yegp4Z+AvHwl3ANfg745ld4CcigticNoTyJc9EKYpVg1JTpJYg/grGd+e99pbgleOmz8LYegMXInXWaQqcoKeUFagUoz24RpPQsWuc1YDOhfIV6QDd4pWDtLNUbDjLmZLpvfbCrAVRecskrG3xwPD5jleQ6v/IEIkD6oeda3ZHKz4QdqJ9kO/TI/Sa/0JM+hIF/1bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRReX6rrC4qe9FgkRERC6R62kVSq4YtfGMwN53WNlx0=;
 b=Tr5lZptIm3yeVinxtbiFLJcxdrBPJqWpwhEceSbeJ3hTx6G9RNQ7H25gLkD8FOV79+o2eZZfjnu2/ApXI4fuQ+3153yqNcp1ZgDtyxMOOgbP7CxG7TBjEZ+b9ECls+pxD+U4tKolLMmg7a/Y1HVqVmZsscxsfQe9Zm8o6OXAlKUkZEQGqp7WntpEEvb3wIsJjdMa4JZrGQP7v2uOMv1wRUJrZMMPgoRm8tCtWFrnBOE76N0PcNj18DDKhC7tAMHmTN8IRDB5vRNkR4i1FApc5ux0ooVV/xA7syR7Bp8YrGL1FYtNX4xQhfgJpT467yvQY0iFTiWLqWjQ6WfOX8J2sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.12) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRReX6rrC4qe9FgkRERC6R62kVSq4YtfGMwN53WNlx0=;
 b=VxrKPg21ghBuhLEDXIfAxN3YnKVG54dDSRwlzc0GA1NA/B2ZalrhOrUhMV3AlG+3nSEAeTuhcgHcE8OuWBjPcDY7gIM8cpvR8qb+eSz67jTGRQiNCIm1F7+mpTA7gNb+gC66HZtiXOyngDzWR5qw8EQycL062ZjX0Av/Kp1BPwb/C91sx7Yl8LeLkXJkCRfpCma6+NzHwOYklFpPjfQ2EAe1Zy12lSPimF2aQmwxjEOQTn+tgBJ9jwbjp26DPOG7LSliGi7EPqImtiSqYyOWmqZ5tmVoHDFABNywyCh78Y+WxEBTC+973ssPnweP1YnNdOhIltxoEo69nxTmlQjg7Q==
Received: from BN1PR14CA0018.namprd14.prod.outlook.com (2603:10b6:408:e3::23)
 by CY4PR1201MB2551.namprd12.prod.outlook.com (2603:10b6:903:d9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Thu, 9 Dec
 2021 19:51:47 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::77) by BN1PR14CA0018.outlook.office365.com
 (2603:10b6:408:e3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend
 Transport; Thu, 9 Dec 2021 19:51:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.12)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.12; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.12) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 19:51:46 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 19:51:33 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 19:51:31 +0000
Received: from Asurada-Nvidia (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18 via Frontend
 Transport; Thu, 9 Dec 2021 11:51:30 -0800
Date: Thu, 9 Dec 2021 11:51:29 -0800
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v8 6/6] iommu/tegra-smmu: Add pagetable mappings to debugfs
Message-ID: <20211209195128.GA35526@Asurada-Nvidia>
References: <20211209073822.26728-1-nicolinc@nvidia.com>
 <20211209073822.26728-7-nicolinc@nvidia.com>
 <5713902d-823b-63ca-00c9-aa6c64c1af41@gmail.com>
 <20211209193253.GB34762@Asurada-Nvidia>
 <97a32c9a-2ec7-6579-7d8d-026d6f820a3e@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <97a32c9a-2ec7-6579-7d8d-026d6f820a3e@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc928aa1-9a6c-4508-97fa-08d9bb4d554a
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2551:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2551ED44302D81CC3088FD03AB709@CY4PR1201MB2551.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: chiRlmhCa9cTOjJ2vfxrMhvcYhulhZUCqA2HrwI09BLouzBnb1pdhFF/FrSdRv83u8phOZ0y7uUoAXTNkL0SuOaWqWZzEdt1d5T1JOQ5HPQFJ4dba3W/WvLdT7oYb0CEDWpfOSUOQ/sSkP8BbAEbuebVAQRYNsfH/3zhwcMfztAoDniz14UpfHlyRqephbVJkk/b5w4wFY6Vgj6eCJM+2ZKakHHACX0GIpTV5wpPHLoYxxkJRbNmh27NbkesRH5uT/NJ8JinjCIuNVsOqbN1b6WPhTt81X5/PfQ2DAoiB/UIfeJIZJBuJin80Z/y7eDkNaFHUaNPCgcu6wt6+XAaHg0W4EZzAqBZG9X4ek20MVbjh9ukBXzTuaWtqXZPN1jpidIvGDrfUNcPEvCNiCSculLsQKemaOC1f070jU6CCjHASfiUy9eMNe5cyDyU30SoMQvrXv4UI8+i796pkJY14W4/F1hYpiOeMTA9XQtBHaO1UNSDwSJgjbT8gbIZfh/C7SFjiK2nfwUNiwFeFb3A500xi5fJXkYnbESuRmyY+HyCfrLUbhQ4zUfTIxWs/DOsuU5anqkAXyBnbIVm0J1ZWUijq6B0vGSrN+EsZexGoXNuQgerx3W98HS3OT8haztvbfcebLk9UZqNLupGGYQYN/DSImC7g6JbMw9x1hugxLW/iG3ZsMoeDkm/vmIdiGxoBnV+H1tU2/JCzwhDOLiKfT7roGbtPJzCAcOlEA4/DGQgTF9+qp7vd468wGUV7reoDqves+JuYpusJpge5X5bJoHqZ8cH5i4K9sPvY66RRgw=
X-Forefront-Antispam-Report: CIP:203.18.50.12; CTRY:HK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:hkhybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(54906003)(1076003)(33716001)(9686003)(7636003)(356005)(316002)(5660300002)(33656002)(86362001)(8676002)(4326008)(8936002)(36860700001)(55016003)(70586007)(40460700001)(47076005)(82310400004)(2906002)(426003)(83380400001)(336012)(70206006)(6916009)(186003)(26005)(508600001)(34020700004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 19:51:46.2463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc928aa1-9a6c-4508-97fa-08d9bb4d554a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[203.18.50.12];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2551
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

T24gVGh1LCBEZWMgMDksIDIwMjEgYXQgMTA6NDA6NDJQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0
dGFjaG1lbnRzCj4gCj4gCj4gMDkuMTIuMjAyMSAyMjozMiwgTmljb2xpbiBDaGVuINC/0LjRiNC1
0YI6Cj4gPiBPbiBUaHUsIERlYyAwOSwgMjAyMSBhdCAwNTo0NzoxOFBNICswMzAwLCBEbWl0cnkg
T3NpcGVua28gd3JvdGU6Cj4gPj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcg
bGlua3Mgb3IgYXR0YWNobWVudHMKPiA+Pgo+ID4+Cj4gPj4gMDkuMTIuMjAyMSAxMDozOCwgTmlj
b2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gPj4+IEBAIC01NDUsNiArNzE5LDE1IEBAIHN0YXRpYyB2
b2lkIHRlZ3JhX3NtbXVfZGV0YWNoX2FzKHN0cnVjdCB0ZWdyYV9zbW11ICpzbW11LAo+ID4+PiAg
ICAgICAgICAgICAgIGlmIChncm91cC0+c3dncnAgIT0gc3dncnApCj4gPj4+ICAgICAgICAgICAg
ICAgICAgICAgICBjb250aW51ZTsKPiA+Pj4gICAgICAgICAgICAgICBncm91cC0+YXMgPSBOVUxM
Owo+ID4+PiArCj4gPj4+ICsgICAgICAgICAgICAgaWYgKHNtbXUtPmRlYnVnZnNfbWFwcGluZ3Mp
IHsKPiA+PiBEbyB3ZSByZWFsbHkgbmVlZCB0aGlzIGNoZWNrPwo+ID4+Cj4gPj4gTG9va3MgbGlr
ZSBhbGwgZGVidWdmc19jcmVhdGVfZGlyKCkgdXNhZ2VzIGluIHRoaXMgZHJpdmVyIGFyZSBpbmNv
cnJlY3QsCj4gPj4gdGhhdCBmdW5jdGlvbiBuZXZlciByZXR1cm5zIE5VTEwuIFBsZWFzZSBmaXgg
dGhpcy4KPiA+IGRlYnVnZnNfY3JlYXRlX2RpciByZXR1cm5zIEVSUl9QVFIgb24gZmFpbHVyZS4g
U28gaGVyZSBzaG91bGQgYmUKPiA+IHRvIGNoZWNrICFJU19FUlIuIFRoYW5rcyBmb3IgcG9pbnRp
bmcgaXQgb3V0IQo+ID4KPiAKPiBBbGwgZGVidWdmcyBmdW5jdGlvbnMgaGFuZGxlIElTX0VSUigp
LiBHcmVnS0ggcmVtb3ZlcyBhbGwgc3VjaCBjaGVja3MKPiBhbGwgb3ZlciB0aGUga2VybmVsLiBT
byB0aGUgY2hlY2sgc2hvdWxkbid0IGJlIG5lZWRlZCBhdCBhbGwsIHBsZWFzZQo+IHJlbW92ZSBp
dCBpZiBpdCdzIHVubmVlZGVkIG9yIHByb3ZlIHRoYXQgaXQncyBuZWVkZWQuCgpkZWJ1Z2ZzX2Ny
ZWF0ZV9maWxlIGNhbiBoYW5kbGUgYSBOVUxMIHBhcmVudCwgYnV0IG5vdCBFUlJfUFRSIG9uZSwK
YW5kIHRoZW4gaXQgcHV0cyB0aGUgbmV3IG5vZGUgdW5kZXIgdGhlIHJvb3QuIFNvIGVpdGhlciBw
YXNzaW5nIGFuCkVSUl9QVFIgcGFyZW50IG9yIGNyZWF0aW5nIG9ycGhhbiBub2RlcyBoZXJlIGRv
ZXNuJ3Qgc291bmQgZ29vZC4uLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
aW9tbXU=
