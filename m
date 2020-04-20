Return-Path: <SRS0=cOz4=6E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A819C3815B
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 16:14:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FC8B2074F
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 16:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="e0rZAY+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC8B2074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7489585E06;
	Mon, 20 Apr 2020 16:14:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5gGt7AwAy6wt; Mon, 20 Apr 2020 16:14:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E622A85DE1;
	Mon, 20 Apr 2020 16:14:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9004C07FF;
	Mon, 20 Apr 2020 16:14:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 107A1C0177
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 16:14:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F3A1885E06
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 16:14:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mSWd881QYRjI for <iommu@lists.linux-foundation.org>;
 Mon, 20 Apr 2020 16:14:50 +0000 (UTC)
X-Greylist: delayed 04:29:43 by SQLgrey-1.7.6
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EDAAC85DE1
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 16:14:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuTKzlnaAap+PflC6UNAwkdWbAWWFO2/3KH9FCLvLa+GLvZhjopdtrgjxLgKjQO1nlcjpMv+xVHXbZgMKrSP7rdMN5pkZ5JhOXKMkPiRHvzhfg1Ew83yS6kIpJFJr6106wqHuTUug+WShyYdpsj3VnIjQazAXH4LH/pdATxRSsZVu28+hxym5UoGdST8pd3vvothd1qYT7d0QZBN3mdOoyEqM2IvKYV0RwePiMw9aiWA0YS34RdQf5nwSI9tRz9lsyj28b+dP5OVf7rhJUw4Gq2GjnAg1KHrjirxGnZMGPE9jGqDJFxfuAypySxloulj0lK3YdtB/UzaodSm0BFvMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15a3GnumC19u3Q448ZVTc3UIlKkPdASCim+iBINpgck=;
 b=dm7BUTQd+Q8hswrlvXDCnelShlNDThMXjvUHn26eOBiOLjFDnnGwen2y1+7KrsJ8EP+TCvk/1NSD4D6J8hUd8+Itx5I9qM2r1paYgVg35XfyudykXwDfOpxR+hEX3fWtxKumkGde/kIxFNaGv2WWS9njJ+L2WbaUTQSKdNCdp6wy04PMxblpcvDQDL2f3BWo8wdnoALO+5gXxHwOli9fr2zMh+mMBZQ95Nu07M9+NnIb1DxOkvQahxjrqu3bKkDdDpSRdfaFSCXkMA5iNY8XwoTMFoNOm/HbdaMZm+PlkrjYD+2kzKnyDtlXOI7WflSxXl6xbdFSDJB5g4ZW8PXEnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15a3GnumC19u3Q448ZVTc3UIlKkPdASCim+iBINpgck=;
 b=e0rZAY+roCY7STiIrQzPPJ3S9wAFMI1ewTIPYqd7VwVA8yzvYOKr/RMXyVaYqKfhqexWYmcIRf5MtWJjRW5wcjGeVrUDQgfAMm577wU9jsF3mCTwaq0tbhrP7MlDgJTO/Lq8DSXqCoSZKc0LX0gQs+7r1YNQhs/hV1fv3DF6xOU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3098.namprd12.prod.outlook.com (2603:10b6:5:11c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Mon, 20 Apr
 2020 12:40:14 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 12:40:14 +0000
Subject: Re: [PATCH v5 02/25] iommu/sva: Manage process address spaces
To: Christoph Hellwig <hch@infradead.org>,
 Felix Kuehling <felix.kuehling@amd.com>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
 <20200414170252.714402-3-jean-philippe@linaro.org>
 <20200416072852.GA32000@infradead.org> <20200416085402.GB1286150@myrica>
 <20200416121331.GA18661@infradead.org> <20200420074213.GA3180232@myrica>
 <20200420081034.GA17305@infradead.org>
 <6b195512-fa73-9a49-03d8-1ed92e86f607@amd.com>
 <20200420115504.GA20664@infradead.org>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <966e190e-ca9f-4c64-af05-43b0f0d8d012@amd.com>
Date: Mon, 20 Apr 2020 14:40:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200420115504.GA20664@infradead.org>
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0103.eurprd07.prod.outlook.com
 (2603:10a6:207:7::13) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR07CA0103.eurprd07.prod.outlook.com (2603:10a6:207:7::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.5 via Frontend Transport; Mon, 20 Apr 2020 12:40:10 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3160d303-c6c8-49d9-d749-08d7e527f913
X-MS-TrafficTypeDiagnostic: DM6PR12MB3098:|DM6PR12MB3098:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB309823358CB495CF0C01E1B683D40@DM6PR12MB3098.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(36756003)(52116002)(186003)(6636002)(31696002)(16526019)(31686004)(478600001)(6486002)(5660300002)(86362001)(8936002)(4326008)(6666004)(2906002)(66946007)(66556008)(66476007)(81156014)(66574012)(8676002)(110136005)(7416002)(316002)(2616005);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: efugUPiNs5RHrr8Fj8C6f0/P8LmMrLf2vPMppXcgf8/x+emZxErQj68ajkrim60Ulpb7qLE7LgBvbgLH13UAiIXWGoLg9pgJCzu0D/ZzSfSuwWme/HD4d0IonMJFyubAtJ1Z7O0jYCz9790mAdtjruuJZxiVqLmUIUvEXJnx0jTgA4/rIgjCTnid9zBvjJXZglX4VwCR9R0hwfFJ4/VQlPkUEUGlZ56TKT1yKbsw7JWitZ9APwWistmp4I9WpE4QA3SRwOGLGKrvpLhwXolul07HxKXtt9Xtz2P9CuzsqFqA8NhpyVstXSu9UYgJSs3nMaWNazZGzqXHYyO4kQw6AMtVOvRRs32t/5ken+izZSoogZk2s+IiIi2r03JRuJJseYTVd0+6KITqKIV7MVwsCcwnqu5LAny7jSbuMyg9S9RXeHEJ4hKddzKdV+XMwlyz
X-MS-Exchange-AntiSpam-MessageData: KGs7kskpLNZ814rjWPchfm2aEHQ3igHquB9ZfeHHXrFwe5S1nbTlRlqffdCyBNlvi2n6LzlEz9t9H8c4uy5AGa9haNu1tijutkEc3c60iMf6Fzt1dxc3bJMz8Aec4XKdEckkSaBifunslbzINGBnyOmLWvguV/N2s9bbkloJNgVSfb9blMRBQ29Nv9AMKMHDVhxjbkuuMt/QE9urDKh+SP+csHys4opdb0jRSeyu1c/CujtrM+ZRcD4wkE2BUlPTme0IxlGHcZGtXiPlCJ41pDdceKCFZ1ae8cJnyzJBwdiuWfs2PqHM3aCzB+QYFL/86l60HC/jkzkvouoVfSK++Ld2sibAiSqhvn0n2ZA8SUoMX6r+Fo86ZRupmuQLEb/D0MX+NL8K1nMb+TFFJS7tmQoMBkP0/kx4z4MBXAxQMnFTa+54fxamjln6+XBIpkYIoKFCOxvr1/0ie1PFkmB8vPPFTcPqoJVDtn4w7oCwBmmKJ7pcQzgMQdrIUJOGGXwX4Tj+QBr3U+c2ouseHkQgn0rwwY1tDIuvnAryi5MuV3wASLbjmHd0qNlGfLeOzZtmBoGylsdKWfdNF3tw1azS9BPDRUMNTrdJe1kuGEcWIlTSUUC/twEIz0zv8nmG0oHkGY1r2DlyZuo+wXFKd1xMFiQAQoLhgEYFexJd5F7z10/wJzBfIIxDq79c03elTmlV3HBCiOvMgZxZcl4ujZtiK35Dm0dDE/ETc006B4Rbmfg8BTUN9kiKlprj4CSUL96HtX/YRSahuGyvVVWT/oyYoupEpHB9H/ooUJZIRdKDunxf7kO6Wup7pWKnVJF4nPVHs26wxzQghyaw2gTlMcZPAiCkV70shxW/j7ZhlLEdPHg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3160d303-c6c8-49d9-d749-08d7e527f913
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 12:40:14.4055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0c6qHkoa3ugzEHQmd3AsEsoI3JBDwiO4toqkxqk5offu+fcrlzTpGdMPiFL5Ci6D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3098
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 devicetree@vger.kernel.org, jgg@ziepe.ca, linux-pci@vger.kernel.org,
 robin.murphy@arm.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 catalin.marinas@arm.com, zhangfei.gao@linaro.org, will@kernel.org,
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

QW0gMjAuMDQuMjAgdW0gMTM6NTUgc2NocmllYiBDaHJpc3RvcGggSGVsbHdpZzoKPiBPbiBNb24s
IEFwciAyMCwgMjAyMCBhdCAwMTo0NDo1NlBNICswMjAwLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3Rl
Ogo+PiBBbSAyMC4wNC4yMCB1bSAxMDoxMCBzY2hyaWViIENocmlzdG9waCBIZWxsd2lnOgo+Pj4g
T24gTW9uLCBBcHIgMjAsIDIwMjAgYXQgMDk6NDI6MTNBTSArMDIwMCwgSmVhbi1QaGlsaXBwZSBC
cnVja2VyIHdyb3RlOgo+Pj4+IFJpZ2h0LCBJIGNhbiBzZWUgdGhlIGFwcGVhbC4gSSBzdGlsbCBs
aWtlIGhhdmluZyBhIHNpbmdsZSBtbXUgbm90aWZpZXIgcGVyCj4+Pj4gbW0gYmVjYXVzZSBpdCBl
bnN1cmVzIHdlIGFsbG9jYXRlIGEgc2luZ2xlIFBBU0lEIHBlciBtbSAoYXMgcmVxdWlyZWQgYnkK
Pj4+PiB4ODYpLiBJIHN1cHBvc2Ugb25lIGFsdGVybmF0aXZlIGlzIHRvIG1haW50YWluIGEgaGFz
aHRhYmxlIG9mIG1tLT5wYXNpZCwKPj4+PiB0byBhdm9pZCBpdGVyYXRpbmcgb3ZlciBhbGwgYm9u
ZHMgZHVyaW5nIGFsbG9jYXRpb24uCj4+PiBHaXZlbiB0aGF0IHRoZSBQQVNJRCBpcyBhIHByZXR0
eSBnZW5lcmljIGFuZCBpbXBvcnRhbnQgY29uY2VwdCBjYW4KPj4+IHdlIGp1c3QgYWRkIGl0IGRp
cmVjdGx5IHRvIHRoZSBtbV9zdHJ1Y3QgYW5kIGFsbG9jYXRlIGl0IGxhemlseSBvbmNlCj4+PiB3
ZSBmaXJzdCBuZWVkIGl0Pwo+PiBXZWxsIHRoZSBwcm9ibGVtIGlzIHRoYXQgdGhlIFBBU0lEIG1p
Z2h0IGFzIHdlbGwgYmUgZGV2aWNlIHNwZWNpZmljLiBFLmcuCj4+IHNvbWUgZGV2aWNlcyB1c2Ug
MTZiaXQgUEFTSURzLCBzb21lIDE1Yml0LCBzb21lIG90aGVyIG9ubHkgMTJiaXQuCj4+Cj4+IFNv
IHdoYXQgY291bGQgKGF0IGxlYXN0IGluIHRoZW9yeSkgaGFwcGVuIGlzIHRoYXQgeW91IG5lZWQg
dG8gYWxsb2NhdGUKPj4gZGlmZmVyZW50IFBBU0lEcyBmb3IgdGhlIHNhbWUgcHJvY2VzcyBiZWNh
dXNlIGRpZmZlcmVudCBkZXZpY2VzIG5lZWQgb25lLgo+IFRoaXMgZGlyZWN0bHkgY29udHJhZGlj
dHMgdGhlIHN0YXRlbWVudCBmcm9tIEplYW4tUGhpbGlwcGUgYWJvdmUgdGhhdAo+IHg4NiByZXF1
aXJlcyBhIHNpbmdsZSBQQVNJRCBwZXIgbW1fc3RydWN0LiAgSWYgd2UgbWF5IG5lZWQgZGlmZmVy
ZW50Cj4gUEFTSURzIGZvciBkaWZmZXJlbnQgZGV2aWNlcyBhbmQgY2FuIGFjdHVhbGx5IHN1cHBv
cnQgdGhpcyBqdXN0Cj4gYWxsb2NhdGluZyBvbmUgcGVyIFtkZXZpY2UsIG1tX3N0cnVjdF0gd291
bGQgbWFrZSBtb3N0IHNlbnNlIG9mIG1lLCBhcwo+IGl0IGRvZXNuJ3QgY291cGxlIG90aGVyd2lz
ZSBkaXNqb2ludCBzdGF0ZS4KCldlbGwgSSdtIG5vdCBhbiBleHBlcnQgb24gdGhpcyB0b3BpYy4g
RmVsaXggY2FuIHByb2JhYmx5IHRlbGwgeW91IGEgYml0IAptb3JlIGFib3V0IHRoYXQuCgpNYXli
ZSBpdCBpcyBzdWZmaWNpZW50IHRvIGtlZXAgdGhlIGFsbG9jYXRlZCBQQVNJRHMgYXMgc21hbGwg
YXMgcG9zc2libGUgCmFuZCByZXR1cm4gYW4gYXBwcm9wcmlhdGUgZXJyb3IgaWYgYSBkZXZpY2Ug
Y2FuJ3QgZGVhbCB3aXRoIHRoZSAKYWxsb2NhdGVkIG51bWJlci4KCklmIGEgZGV2aWNlIGNhbiBv
bmx5IGRlYWwgd2l0aCAxMmJpdCBQQVNJRHMgYW5kIG1vcmUgdGhhbiAyXjEyIHRyeSB0byAKdXNl
IGl0IHRoZXJlIGlzbid0IG11Y2ggZWxzZSB3ZSBjYW4gZG8gdGhhbiByZXR1cm5pbmcgYW4gZXJy
b3IgYW55d2F5LgoKUmVnYXJkcywKQ2hyaXN0aWFuLgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
