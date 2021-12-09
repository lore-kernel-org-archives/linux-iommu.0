Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF52C433FE
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 20:07:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 385A18607E;
	Thu,  9 Dec 2021 20:07:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d6OAdh35Vllp; Thu,  9 Dec 2021 20:07:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 04C318607D;
	Thu,  9 Dec 2021 20:07:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B787DC002F;
	Thu,  9 Dec 2021 20:07:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC872C0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 20:07:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 974E78607D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 20:07:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jEvO-sN_vCzN for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 20:07:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9D1688607B
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 20:07:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6Tpom3yRKvI21MTXOnKwACZKiz97mTwGVrHoNc6LMi504yoPtGraxrTpddw13H56z+0mDW7TBVTCO4lK8HnJqACweTXPizp+FwIM61opi7gbtXaUdPDjxC4E6KHG1YEuwXmtkt6UkT0s7LBXw8n3DLkvwqoMeZOTU8A9InpW1lpQyfyIjDmGBlYQc5C7X1Vjuxy4ksLAv3J5czCRZB1H18dNox4XCKqALqba2dy39Thk162TCKLRBI7YrbdkSvqT3BKUBteBVMBGFQmGXTCY2SaS/h49YB3gH/3oLpXKOrF2b7HcOAVcVWnnLBENPopPDulDCKtWc3UQ1W8h+3iDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qBDv9Qs1rohVW3WLB4vHrUfp/BI8Q15uIADSfnwuRM=;
 b=Wd6s4TdnriyLeY3iDBvhaFepcPZUbQr/37CijVlvplAV7YKug0b4OaEmTpE20H1AMHCCQbNOwZGmhKEVuS2dQG7D+x0aXLXbDDT7MmFec1SIJpQqFQyfOxGe0xAqa+wW826HbXftx3WsGLLGxNnmjtoCblZZzU6TflowKXSbQ4fkS0nVjS2FqYU8mZ0YGTniHbl5EKHy+z9UIhKYZEuRr3ZnZ6NcqF4rECpb3qHoFUVW7hFrOHKim4Uxk+tbyyaUmEh8I8Zgtfm49wSN2xwZvegHO7uBqOtEszqdDha6Wnk+PXWVJEs0RhUWiu25OLWRZhj3yNeAvzcJkkrVKUwC8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.13) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qBDv9Qs1rohVW3WLB4vHrUfp/BI8Q15uIADSfnwuRM=;
 b=JqYflR5joUFCPH/5qHd/53/5yTRAMTGXCbsADiDlrHsOIRbr5niZy2PbTjRm7nqlO0rtDcCyqffYuAnYgoG4LwotnXucP7QBxr6kHj51ejD/5Lcb0ERL6Hz2lWqF79Jmdsses7DqpGpMk0RqVPJ0GsGaydqVuApTzuT9ebeetktoKJzPqxcC7krb+A8KDIfrmWSU0VpEQ/dem1LKYsiaiOJEWCCBl+83bT/6rVr56QoZiXRDvMhrbOcyvXip4gMTHaujhouGj9W5gFjO8N/DEwiZs32hswtO+3ajGisP34MhobEhnNjOKbnuwo2S85Ncrh7a8RVvwdgvsXSOfLoWDA==
Received: from DM5PR07CA0053.namprd07.prod.outlook.com (2603:10b6:4:ad::18) by
 BN8PR12MB3009.namprd12.prod.outlook.com (2603:10b6:408:42::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Thu, 9 Dec 2021 20:07:27 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::b0) by DM5PR07CA0053.outlook.office365.com
 (2603:10b6:4:ad::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11 via Frontend
 Transport; Thu, 9 Dec 2021 20:07:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.13)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.13 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.13; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.13) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 20:07:26 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 20:07:00 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 20:06:59 +0000
Received: from Asurada-Nvidia (172.20.187.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18 via Frontend
 Transport; Thu, 9 Dec 2021 20:06:59 +0000
Date: Thu, 9 Dec 2021 12:06:57 -0800
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v8 6/6] iommu/tegra-smmu: Add pagetable mappings to debugfs
Message-ID: <20211209200657.GB35858@Asurada-Nvidia>
References: <20211209073822.26728-1-nicolinc@nvidia.com>
 <20211209073822.26728-7-nicolinc@nvidia.com>
 <5713902d-823b-63ca-00c9-aa6c64c1af41@gmail.com>
 <20211209193253.GB34762@Asurada-Nvidia>
 <97a32c9a-2ec7-6579-7d8d-026d6f820a3e@gmail.com>
 <20211209195128.GA35526@Asurada-Nvidia>
 <a4002ad9-70d9-22d1-7bcc-ae4f712187c8@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a4002ad9-70d9-22d1-7bcc-ae4f712187c8@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 726f8ad7-3b3b-4128-0f3e-08d9bb4f85fc
X-MS-TrafficTypeDiagnostic: BN8PR12MB3009:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB300991BF84BAF35DA295D2AAAB709@BN8PR12MB3009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HxaG7VQ7Kd5QIE2PWP8wVBh/qO2kcVhFUOApr4a+3o7QFGfe+c4u0miI+kO23OkO7HSu6iFN/9my3qUUG6qzmvj7R6oabHjVt2+ZOcU8aLT7DztFHmYlqDZ4/eWX5Lti9+2vk7IVQkHXUcuaP3HqYhesST7wAOQWghCSgy6MGrhKeLKwK9p/rdVd+nb3K76NXQ/+WwpAJ3bS8Hf/RIy7xXw4QaQRzToJRRYe8xiNsNjmaxTD2trK/qULJgIuQTnuABzgVdzeXP8zV+aHwpDZQ78Z5YiDFPTDwuyQjokmOgzd4SCzGIG5TVQCtIjaP4NlD2wRoUvaf1EDnskE0ed83ajGrDx9YNJNO18yx1XPBjfCcmdgXN85KiVTmv8W3I7I6UH09i94iErlCLHTqnKvf4Ugl5wa8fYtejB1tbQCk9CNQqdj6iww45iF+HnSs0r8yQMxgIQPz5dOVR6nQ8QdqUaN9VKh9Ifx8TjZLFAIlWwO/FoQV1X4YgUdMA0rVjwgV4D2gAe94MDKIjIAphX6uyA24sdxfNsIPWMAf0frwisoO9CJ5wdMEPnsF+QPEx/y+tA+F3ScYqjw1db8ZhD8KBuEC2YXUm5m0+/q72LgzA0dWKdsIsGJxRsWr0ctVsv5XDj6F4AjQ+J7yownjYToCKE3X3V94Wqce4XT8idHrDgvImW4UvaKbRbkOYX0DP7YcVyP9JVfZODsQsDbXZfT9Gz0QTLL2v83s+r/yJ+WoLP54jf2ilKsiB89esJoKBotW4GL5oK/Q7Ncx+bwyQil4q6StIwxBKLMKeUQ8NqEFsg=
X-Forefront-Antispam-Report: CIP:203.18.50.13; CTRY:HK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:hkhybrid02.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(86362001)(55016003)(40460700001)(82310400004)(33716001)(8936002)(8676002)(33656002)(316002)(6916009)(54906003)(7636003)(508600001)(26005)(9686003)(70206006)(186003)(70586007)(34020700004)(336012)(426003)(4326008)(356005)(2906002)(1076003)(36860700001)(83380400001)(5660300002)(47076005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 20:07:26.9803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 726f8ad7-3b3b-4128-0f3e-08d9bb4f85fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[203.18.50.13];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3009
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

T24gVGh1LCBEZWMgMDksIDIwMjEgYXQgMTA6NTg6MTVQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0
dGFjaG1lbnRzCj4gCj4gCj4gMDkuMTIuMjAyMSAyMjo1MSwgTmljb2xpbiBDaGVuINC/0LjRiNC1
0YI6Cj4gPiBPbiBUaHUsIERlYyAwOSwgMjAyMSBhdCAxMDo0MDo0MlBNICswMzAwLCBEbWl0cnkg
T3NpcGVua28gd3JvdGU6Cj4gPj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcg
bGlua3Mgb3IgYXR0YWNobWVudHMKPiA+Pgo+ID4+Cj4gPj4gMDkuMTIuMjAyMSAyMjozMiwgTmlj
b2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gPj4+IE9uIFRodSwgRGVjIDA5LCAyMDIxIGF0IDA1OjQ3
OjE4UE0gKzAzMDAsIERtaXRyeSBPc2lwZW5rbyB3cm90ZToKPiA+Pj4+IEV4dGVybmFsIGVtYWls
OiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzCj4gPj4+Pgo+ID4+Pj4K
PiA+Pj4+IDA5LjEyLjIwMjEgMTA6MzgsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+ID4+Pj4+
IEBAIC01NDUsNiArNzE5LDE1IEBAIHN0YXRpYyB2b2lkIHRlZ3JhX3NtbXVfZGV0YWNoX2FzKHN0
cnVjdCB0ZWdyYV9zbW11ICpzbW11LAo+ID4+Pj4+ICAgICAgICAgICAgICAgaWYgKGdyb3VwLT5z
d2dycCAhPSBzd2dycCkKPiA+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7Cj4g
Pj4+Pj4gICAgICAgICAgICAgICBncm91cC0+YXMgPSBOVUxMOwo+ID4+Pj4+ICsKPiA+Pj4+PiAr
ICAgICAgICAgICAgIGlmIChzbW11LT5kZWJ1Z2ZzX21hcHBpbmdzKSB7Cj4gPj4+PiBEbyB3ZSBy
ZWFsbHkgbmVlZCB0aGlzIGNoZWNrPwo+ID4+Pj4KPiA+Pj4+IExvb2tzIGxpa2UgYWxsIGRlYnVn
ZnNfY3JlYXRlX2RpcigpIHVzYWdlcyBpbiB0aGlzIGRyaXZlciBhcmUgaW5jb3JyZWN0LAo+ID4+
Pj4gdGhhdCBmdW5jdGlvbiBuZXZlciByZXR1cm5zIE5VTEwuIFBsZWFzZSBmaXggdGhpcy4KPiA+
Pj4gZGVidWdmc19jcmVhdGVfZGlyIHJldHVybnMgRVJSX1BUUiBvbiBmYWlsdXJlLiBTbyBoZXJl
IHNob3VsZCBiZQo+ID4+PiB0byBjaGVjayAhSVNfRVJSLiBUaGFua3MgZm9yIHBvaW50aW5nIGl0
IG91dCEKPiA+Pj4KPiA+Pgo+ID4+IEFsbCBkZWJ1Z2ZzIGZ1bmN0aW9ucyBoYW5kbGUgSVNfRVJS
KCkuIEdyZWdLSCByZW1vdmVzIGFsbCBzdWNoIGNoZWNrcwo+ID4+IGFsbCBvdmVyIHRoZSBrZXJu
ZWwuIFNvIHRoZSBjaGVjayBzaG91bGRuJ3QgYmUgbmVlZGVkIGF0IGFsbCwgcGxlYXNlCj4gPj4g
cmVtb3ZlIGl0IGlmIGl0J3MgdW5uZWVkZWQgb3IgcHJvdmUgdGhhdCBpdCdzIG5lZWRlZC4KPiA+
Cj4gPiBkZWJ1Z2ZzX2NyZWF0ZV9maWxlIGNhbiBoYW5kbGUgYSBOVUxMIHBhcmVudCwgYnV0IG5v
dCBFUlJfUFRSIG9uZSwKPiA+IGFuZCB0aGVuIGl0IHB1dHMgdGhlIG5ldyBub2RlIHVuZGVyIHRo
ZSByb290LiBTbyBlaXRoZXIgcGFzc2luZyBhbgo+ID4gRVJSX1BUUiBwYXJlbnQgb3IgY3JlYXRp
bmcgb3JwaGFuIG5vZGVzIGhlcmUgZG9lc24ndCBzb3VuZCBnb29kLi4uCj4gPgo+IAo+IFdoYXQg
bWFrZXMgeW91IHNheSBzbz8gUGxlYXNlIHNob3cgdGhlIGV4YWN0IHNvdXJjZSBjb2RlIHRoYXQg
d2lsbCBjYXVzZQo+IHRoZSBwcm9ibGVtLgo+IAo+IFRoZSBzbW11LT5kZWJ1Z2ZzX21hcHBpbmdz
IGNhbid0IGV2ZXIgYmUgTlVMTCBhbmQgZGVidWdmc19jcmVhdGVfZmlsZQo+IGhhbmRsZXMgdGhl
IEVSUl9QVFIgWzFdWzJdLgoKQWguLi5teSB0b29sIGp1bXBzIHRvIHN0YXJ0X2NyZWF0aW5nIGlu
IGZzL3RyYWNlZnMvaW5vZGUuYyBpbnN0ZWFkLgoKVGhhbmtzIGZvciB0aGUgcmVwbHkuIEkgd2ls
bCByZW1vdmUgdGhlIGlmIGxpbmUgdGhlbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2lvbW11
