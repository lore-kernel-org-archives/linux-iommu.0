Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5080C2B9F4
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 05:52:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 864E1613CB
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 05:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 864E1613CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D5D941610;
	Thu, 17 Jun 2021 05:52:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zp_nvwjlHe31; Thu, 17 Jun 2021 05:52:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9E7C54160A;
	Thu, 17 Jun 2021 05:52:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F465C000D;
	Thu, 17 Jun 2021 05:52:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07720C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 05:52:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D5BDF83D87
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 05:51:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QeQt2cEeixEG for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 05:51:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::615])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4F84683D85
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 05:51:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q19Ot0t6OqBfeJC/3qs6Ju0IZbJ7ZwV/y67kAuVWUNwjpP6vHpId3gR6TUY1NJjDFH0dm1YRFvA+5MFUh+cOflk8/2aQi/TBcK8TCMqwem/6TItey3wik6eQDgDXrfMrNxuD3+hjCXeJ8GvAeTD0yK4PDarvS1/q/dv/ruDBkcF78I84JNHYiz0X2wqs7bEGZf+zslVB9die3G3LPHoCU769UHULx/P4TI7YVnTh5ThdRbJJxnZX76Jwy12Xi3AMmJTX5tuL48wP4ziRfYhB4VxCx6AWGcKe4qpwWK8Ekf0YJUKjV8sp9u6XPpCDwt9ueVFJI0qyPN6A3svSwaO1OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Rk0Tr5PbW9/2vXBsnb8a2hlO4SsJEBZ1oFO+LVYSsk=;
 b=IPS0Eb6j3aW/hbNfmWgYGcgMpU2sv0HUO43C39BJXcjsXcpjueUCRt8I+K6IZ57Rw+0DPUTyMrkAZkyUm9qMLt9+d9IAGXlFSsmRauzVLWixcl3cdx7By8nVzQpTGvYV/ogHVon5plGxf0IEZT2ZNHRw1YJiZR7pEFTvkwLoYH3OABlE2EHPWk/n6llnNLJJzr6B3FK3xyQDSFCmvGvXDmHKm/4PXIfQIdZaOuMGZKHQkSXGrVbE4vzTNWM6WtHQeZe194JT5XIXqZmM7VvVeJj2//AYV5H0ybMwIMnVomN0Zz+C52GlGgRycovAH/dxrDHRhcIxYqvVudG5F/yVSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Rk0Tr5PbW9/2vXBsnb8a2hlO4SsJEBZ1oFO+LVYSsk=;
 b=aEweZLqTXfdNkSwzzcHbE/BcXm9bcW3gAW3iy3PBpIsAODtkFThyK6E7/iu36QobqErL7Ir4D1xJ7GT7VUAN/NbDrjBpkTqMZkLuTxm8f04YF7BL0Z1geXlYHFR3YJU4nAhyd4OcW4lisX/G7WholuE3wCk63TDH11qy7TThXM2CWsVrtXJbXoqVj0QNOTrj9TtiGw+2zJJL3T7Z8GkxKu5RS6avq4JISuNPTSBnjDXdbbv9jl0vrmS/NUXrCtTOltjbjVcS0jaCO/56cAtvI64HqrRlg04zxxKmu6Q2Bg60pRjdSh01tp4FOIsUzVRQT+NUWaxwULoe663qhR9T3w==
Received: from DM5PR18CA0088.namprd18.prod.outlook.com (2603:10b6:3:3::26) by
 BL1PR12MB5270.namprd12.prod.outlook.com (2603:10b6:208:31e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.18; Thu, 17 Jun 2021 05:51:55 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::87) by DM5PR18CA0088.outlook.office365.com
 (2603:10b6:3:3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend
 Transport; Thu, 17 Jun 2021 05:51:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Thu, 17 Jun 2021 05:51:55 +0000
Received: from [10.40.103.48] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Jun
 2021 05:51:52 +0000
Subject: Re: [PATCH 1/2] iommu: Fix race condition during default domain
 allocation
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 <vdumpa@nvidia.com>
References: <1623298614-31755-1-git-send-email-amhetre@nvidia.com>
 <1623298614-31755-2-git-send-email-amhetre@nvidia.com>
 <20210611104524.GD15274@willie-the-truck>
 <faf4504c-43f2-f68e-9a00-5e450dd7f352@arm.com>
From: Ashish Mhetre <amhetre@nvidia.com>
Message-ID: <315fe1c5-2685-6ee3-2aa4-35a27233127b@nvidia.com>
Date: Thu, 17 Jun 2021 11:21:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <faf4504c-43f2-f68e-9a00-5e450dd7f352@arm.com>
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d476eb37-637f-4f17-9ccf-08d93154036d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5270:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5270323C8134A20E7DC31F7ACA0E9@BL1PR12MB5270.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NgKBSx0OsX18aQsVDtW+Lne+5qn9VVTHlK31P7DCcN5FchydaFB0/j1zLhGpMkcCO55HUYmKvxCaHMippBmA4sqcCmDcT5CsoW87LIZhPUOBcUqGhhvE/6QfspnMOl0W4G1jUf4KMfA1hX+5bohpwzEMX1fzb9s9Aw5D2qy1yPEg298blnjFEeaExElE4tlTG41x37ci7hxkbAX4FjYfc+lmuMO+f3AShoVMe49sJZiSP5w6/n736BrCyfq1iufIavf7FqcCWTltxFRrxpOQ6GVfT0e/3Laj+TGfa9u4heAJlMpRxS7VlHQn0Oauht9axsnaS4fyuKCvcsOlXr6LBeMirve1R8pCEmYwPGM0QUrfNNcxrcf0btu9DOwHhtYS/B5euLwU4wZF3+65QYvLTIHDvP8jYaenF3hcYXvsdWee8FgGevn9r4cy8MOqXKa4opG4Pbtw/d+JzF04XKfUhGgoNIm9cxBE7YQOhCqp+85t2jPF3I43jLAphjlbtyHOoVyZI8PgDL9M41dgulzr0PDgbW6QvS+B2moMEc4KDeouxWoQwBpk9TtJSDCO4fr0SRnxyr5idsfFphSOX+B4gwm1FyfUV5uQm/AFcWXcbEzcWssKE5BrqK6HwF8K+JoYGI+7QDRnjhXqGpSF1LhMiSwnzX2+sFViVgk09OFIhFUjDw2zzRIygcNsnbf/9ndw
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966006)(36840700001)(47076005)(16576012)(4326008)(5660300002)(110136005)(186003)(26005)(478600001)(54906003)(36906005)(2616005)(336012)(82740400003)(86362001)(2906002)(356005)(36860700001)(426003)(7636003)(316002)(8936002)(70206006)(82310400003)(70586007)(6636002)(31686004)(53546011)(36756003)(31696002)(16526019)(6666004)(8676002)(83380400001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 05:51:55.3035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d476eb37-637f-4f17-9ccf-08d93154036d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5270
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CgpPbiA2LzExLzIwMjEgNjoxOSBQTSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IEV4dGVybmFsIGVt
YWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzCj4gCj4gCj4gT24g
MjAyMS0wNi0xMSAxMTo0NSwgV2lsbCBEZWFjb24gd3JvdGU6Cj4+IE9uIFRodSwgSnVuIDEwLCAy
MDIxIGF0IDA5OjQ2OjUzQU0gKzA1MzAsIEFzaGlzaCBNaGV0cmUgd3JvdGU6Cj4+PiBEb21haW4g
aXMgZ2V0dGluZyBjcmVhdGVkIG1vcmUgdGhhbiBvbmNlIGR1cmluZyBhc3luY2hyb25vdXMgbXVs
dGlwbGUKPj4+IGRpc3BsYXkgaGVhZHMoZGV2aWNlcykgcHJvYmUuIEFsbCB0aGUgZGlzcGxheSBo
ZWFkcyBzaGFyZSBzYW1lIFNJRCBhbmQKPj4+IGFyZSBleHBlY3RlZCB0byBiZSBpbiBzYW1lIGRv
bWFpbi4gQXMgaW9tbXVfYWxsb2NfZGVmYXVsdF9kb21haW4oKSBjYWxsCj4+PiBpcyBub3QgcHJv
dGVjdGVkLCB0aGUgZ3JvdXAtPmRlZmF1bHRfZG9tYWluIGFuZCBncm91cC0+ZG9tYWluIGFyZSBl
bmRpbmcKPj4+IHVwIHdpdGggZGlmZmVyZW50IGRvbWFpbnMgYW5kIGxlYWRpbmcgdG8gc3Vic2Vx
dWVudCBJT01NVSBmYXVsdHMuCj4+PiBGaXggdGhpcyBieSBwcm90ZWN0aW5nIGlvbW11X2FsbG9j
X2RlZmF1bHRfZG9tYWluKCkgY2FsbCB3aXRoIAo+Pj4gZ3JvdXAtPm11dGV4Lgo+Pgo+PiBDYW4g
eW91IHByb3ZpZGUgc29tZSBtb3JlIGluZm9ybWF0aW9uIGFib3V0IGV4YWN0bHkgd2hhdCB0aGUg
aC93Cj4+IGNvbmZpZ3VyYXRpb24gaXMsIGFuZCB0aGUgY2FsbHN0YWNrIHdoaWNoIGV4aGliaXRz
IHRoZSByYWNlLCBwbGVhc2U/Cj4gCj4gSXQnbGwgYmUgYmFzaWNhbGx5IHRoZSBzYW1lIGFzIHRo
ZSBpc3N1ZSByZXBvcnRlZCBsb25nIGFnbyB3aXRoIFBDSQo+IGdyb3VwcyBpbiB0aGUgYWJzZW5j
ZSBvZiBBQ1Mgbm90IGJlaW5nIGNvbnN0cnVjdGVkIGNvcnJlY3RseS4gVHJpZ2dlcmluZwo+IHRo
ZSBpb21tdV9wcm9iZV9kZXZpY2UoKSByZXBsYXkgaW4gb2ZfaW9tbXVfY29uZmlndXJlKCkgb2Zm
IHRoZSBiYWNrIG9mCj4gZHJpdmVyIHByb2JlIGlzIHdheSB0b28gbGF0ZSBhbmQgYWxsb3dzIGNh
bGxzIHRvIGhhcHBlbiBpbiB0aGUgd3JvbmcKPiBvcmRlciwgb3IgaW5kZWVkIHJhY2UgaW4gcGFy
YWxsZWwgYXMgaGVyZS4gRml4aW5nIHRoYXQgaXMgc3RpbGwgb24gbXkKPiByYWRhciwgYnV0IHdp
bGwgbm90IGJlIHNpbXBsZSwgYW5kIHdpbGwgcHJvYmFibHkgZ28gaGFuZC1pbi1oYW5kIHdpdGgK
PiBwaGFzaW5nIG91dCB0aGUgYnVzIG9wcyAoZm9yIHRoZSBtdWx0aXBsZS1kcml2ZXItY29leGlz
dGVuY2UgcHJvYmxlbSkuCj4gCkZvciBpb21tdSBncm91cCBjcmVhdGlvbiwgdGhlIHN0YWNrIGZs
b3cgZHVyaW5nIHJhY2UgaXMgbGlrZToKRGlzcGxheSBkZXZpY2UgMToKaW9tbXVfcHJvYmVfZGV2
aWNlIC0+IGlvbW11X2dyb3VwX2dldF9mb3JfZGV2IC0+IGFybV9zbW11X2RldmljZV9ncm91cApE
aXNwbGF5IGRldmljZSAyOgppb21tdV9wcm9iZV9kZXZpY2UgLT4gaW9tbXVfZ3JvdXBfZ2V0X2Zv
cl9kZXYgLT4gYXJtX3NtbXVfZGV2aWNlX2dyb3VwCgpBbmQgdGhpcyB3YXkgaXQgZW5kcyB1cCBp
biBjcmVhdGluZyAyIGdyb3VwcyBmb3IgMiBkaXNwbGF5IGRldmljZXMgCnNoYXJpbmcgc2FtZSBT
SUQuCklkZWFsbHkgZm9yIDJuZCBkaXNwbGF5IGRldmljZSwgaW9tbXVfZ3JvdXBfZ2V0IGNhbGwg
ZnJvbSAKaW9tbXVfZ3JvdXBfZ2V0X2Zvcl9kZXYgc2hvdWxkIHJldHVybiBzYW1lIGdyb3VwIGFz
IDFzdCBkaXNwbGF5IGRldmljZS4gCkJ1dCBkdWUgdG8gdGhlIHJhY2UsIGl0IGVuZHMgdXAgd2l0
aCAyIGdyb3Vwcy4KCkZvciBkZWZhdWx0IGRvbWFpbiwgdGhlIHN0YWNrIGZsb3cgZHVyaW5nIHJh
Y2UgaXMgbGlrZToKRGlzcGxheSBkZXZpY2UgMToKaW9tbXVfcHJvYmVfZGV2aWNlIC0+IGlvbW11
X2FsbG9jX2RlZmF1bHRfZG9tYWluIC0+IGFybV9zbW11X2RvbWFpbl9hbGxvYwpEaXNwbGF5IGRl
dmljZSAyOgppb21tdV9wcm9iZV9kZXZpY2UgLT4gaW9tbXVfYWxsb2NfZGVmYXVsdF9kb21haW4g
LT4gYXJtX3NtbXVfZG9tYWluX2FsbG9jCgpIZXJlIGFsc28gMm5kIGRldmljZSBzaG91bGQgYWxy
ZWFkeSBoYXZlIGRvbWFpbiBhbGxvY2F0ZWQgYW5kIAonaWYoZ3JvdXAtPmRlZmF1bHRfZG9tYWlu
KScgY29uZGl0aW9uIGZyb20gaW9tbXVfYWxsb2NfZGVmYXVsdF9kb21haW4gCnNob3VsZCBiZSB0
cnVlIGZvciAybmQgZGV2aWNlLgoKSXNzdWUgd2l0aCB0aGlzIGlzIElPVkEgYWNjZXNzZXMgZnJv
bSAybmQgZGV2aWNlIHJlc3VsdHMgaW4gY29udGV4dCBmYXVsdHMuCgo+Pj4gU2lnbmVkLW9mZi1i
eTogQXNoaXNoIE1oZXRyZSA8YW1oZXRyZUBudmlkaWEuY29tPgo+Pj4gLS0tCj4+PiDCoCBkcml2
ZXJzL2lvbW11L2lvbW11LmMgfCAyICsrCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYyBiL2RyaXZl
cnMvaW9tbXUvaW9tbXUuYwo+Pj4gaW5kZXggODA4YWI3MC4uMjcwMDUwMCAxMDA2NDQKPj4+IC0t
LSBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwo+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9pb21tdS5j
Cj4+PiBAQCAtMjczLDcgKzI3Myw5IEBAIGludCBpb21tdV9wcm9iZV9kZXZpY2Uoc3RydWN0IGRl
dmljZSAqZGV2KQo+Pj4gwqDCoMKgwqDCoCAqIHN1cHBvcnQgZGVmYXVsdCBkb21haW5zLCBzbyB0
aGUgcmV0dXJuIHZhbHVlIGlzIG5vdCB5ZXQKPj4+IMKgwqDCoMKgwqAgKiBjaGVja2VkLgo+Pj4g
wqDCoMKgwqDCoCAqLwo+Pj4gK8KgwqDCoCBtdXRleF9sb2NrKCZncm91cC0+bXV0ZXgpOwo+Pj4g
wqDCoMKgwqAgaW9tbXVfYWxsb2NfZGVmYXVsdF9kb21haW4oZ3JvdXAsIGRldik7Cj4+PiArwqDC
oMKgIG11dGV4X3VubG9jaygmZ3JvdXAtPm11dGV4KTsKPj4KPj4gSXQgZmVlbHMgd3JvbmcgdG8g
c2VyaWFsaXNlIHRoaXMgZm9yIGV2ZXJ5Ym9keSBqdXN0IHRvIGNhdGVyIGZvciBzeXN0ZW1zCj4+
IHdpdGggYWxpYXNpbmcgU0lEcyBiZXR3ZWVuIGRldmljZXMuCj4gCj4gSWYgdHdvIG9yIG1vcmUg
ZGV2aWNlcyBhcmUgcmFjaW5nIGF0IHRoaXMgcG9pbnQgdGhlbiB0aGV5J3JlIGFscmVhZHkKPiBn
b2luZyB0byBiZSBzZXJpYWxpc2VkIGJ5IGF0IGxlYXN0IGlvbW11X2dyb3VwX2FkZF9kZXZpY2Uo
KSwgc28gSSBkb3VidAo+IHRoZXJlIHdvdWxkIGJlIG11Y2ggaW1wYWN0IC0gb25seSB0aGUgZmly
c3QgZGV2aWNlIHRocm91Z2ggaGVyZSB3aWxsCj4gaG9sZCB0aGUgbXV0ZXggZm9yIGFueSBhcHBy
ZWNpYWJsZSBsZW5ndGggb2YgdGltZS4gRXZlcnkgb3RoZXIgcGF0aAo+IHdoaWNoIG1vZGlmaWVz
IGdyb3VwLT5kb21haW4gZG9lcyBzbyB3aXRoIHRoZSBtdXRleCBoZWxkIChub3RlIHRoZQo+ICJl
eHBlY3RlZCIgZGVmYXVsdCBkb21haW4gYWxsb2NhdGlvbiBmbG93IGluIGJ1c19pb21tdV9wcm9i
ZSgpIGluCj4gcGFydGljdWxhciksIHNvIG5vdCBob2xkaW5nIGl0IGhlcmUgZG9lcyBzZWVtIGxp
a2UgYSBzdHJhaWdodGZvcndhcmQKPiBvdmVyc2lnaHQuCj4gCj4gUm9iaW4uClNlcmlhbGl6YXRp
b24gd2lsbCBvbmx5IGhhcHBlbiBmb3IgdGhlIGRldmljZXMgc2hhcmluZyBzYW1lIGdyb3VwLiBP
bmx5IAp0aGUgZmlyc3QgZGV2aWNlIGluIGdyb3VwIHdpbGwgaG9sZCB0aGlzIHRpbGwgZG9tYWlu
IGlzIGNyZWF0ZWQuIEZvciAKcmVzdCBvZiB0aGUgZGV2aWNlcyBpdCB3aWxsIGp1c3QgY2hlY2sg
Zm9yIGV4aXN0aW5nIGRvbWFpbiBpbiAKaW9tbXVfYWxsb2NfZGVmYXVsdF9kb21haW4gYW5kIHRo
ZW4gcmV0dXJuIGFuZCByZWxlYXNlIHRoZSBtdXRleC4KCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
