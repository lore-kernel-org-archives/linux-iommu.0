Return-Path: <SRS0=GPww=FV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEE7C4361B
	for <iommu@archiver.kernel.org>; Thu, 17 Dec 2020 22:56:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1402823A51
	for <iommu@archiver.kernel.org>; Thu, 17 Dec 2020 22:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1402823A51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8EB532E108;
	Thu, 17 Dec 2020 22:55:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lGs+dAtxH7qD; Thu, 17 Dec 2020 22:55:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8DA712151F;
	Thu, 17 Dec 2020 22:55:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5473AC0893;
	Thu, 17 Dec 2020 22:55:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD02DC013B;
 Thu, 17 Dec 2020 22:55:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D0D0E879E2;
 Thu, 17 Dec 2020 22:55:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5oNqR5Ny3q0T; Thu, 17 Dec 2020 22:55:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6D942879DF;
 Thu, 17 Dec 2020 22:55:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRGaiswSP26wiuBuieO8Q0FVMPHBO+tly9Q7/yNh87fCc4nZcsmgBZcgqv6n+X6+DRS09H5kOg3Aspmu60O6JCsVyjJljNoBjxyM26Vj9k8aN2RlQlJ+jyLUXMpDDGzP7fI8W0Q37/VYqFmXoH1yZzOseAtik6GTdVcUjTPlq4B+zKnzFzM5p/d5M1eeqxs7Dhwx2Lp8hknaOtRgneJ8DsBujUiwxvXBhzC6/MKLSBMlxewHGDt6KKezoHtASGh37DEUs1uy0KMFJNweRyOlY4TTIrEo27WosCKmB4KBNwOQ40QfgmImE6jVlogtQ0SmNP03MqeS7wZwlKSjaYzGzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTxzRs0SaWHHeWeKdrtHpSMQHbBypaZ9o3V7PKodmhM=;
 b=ki1cNnrfY9PiNPHSGCNm5oh7X8oiSrs+LHUSj3kPwY9z0P/0YZc53YkIilC3XKKIe1I3uRiw7XOCIEebOODaTHrfTjNwH0GvD8NaeucaB8T09ZcMzq5KZUlKbFDh9pwP5h9nd83T1xooDmAQSdkV7dXJfAe+1mwY+b5W5+h1c/XzrNd01uWXatjyv/OtRouRCuaWs6UQxqP8dWS33L1cmeBytcRbB0q+9Aor/j6KkjGfw9tcu1Hi7rCx7mbbKkyKIXdFYBltdgOQ7SpHqv5ZKWjRtuAIenI/jplMYkRQb1GUBGX6dQjh0qRwaO5CcUpRhVEYfJ52j7W0FCc4gao6Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTxzRs0SaWHHeWeKdrtHpSMQHbBypaZ9o3V7PKodmhM=;
 b=p4WuKvUgP5kNKPnBZW3G2k0cWqt3tTYl8nV+3kZuOYGUsIAgTxph5y+8SGPraHP8xwU+wRojAh1gNT9K9M/XHlJVpQZg0eraoRDaHungvzE7YlwA1byDSL5Vzt3SFTbsHJ1JqxgqABxEPGENsCPjOsf9XfCzAA2Y/hE63txsSuo=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SN6PR12MB4751.namprd12.prod.outlook.com (2603:10b6:805:df::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Thu, 17 Dec
 2020 22:55:51 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec%3]) with mapi id 15.20.3654.024; Thu, 17 Dec 2020
 22:55:51 +0000
Date: Thu, 17 Dec 2020 22:55:45 +0000
From: Ashish Kalra <ashish.kalra@amd.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: swiotlb/virtio: unchecked device dma address and length
Message-ID: <20201217225544.GA14861@ashkalra_ubuntu_server>
References: <d2ae0b1d-332b-42a1-87bf-7da2b749cac2@sect.tu-berlin.de>
 <20201214214950.GC18103@char.us.oracle.com>
 <c3629a27-3590-1d9f-211b-c0b7be152b32@redhat.com>
 <20201215142755.GB28810@char.us.oracle.com>
 <1330503106.36174346.1608098013639.JavaMail.zimbra@redhat.com>
 <613214145.36646222.1608100908658.JavaMail.zimbra@redhat.com>
 <2CCB61BD-19F0-48A3-A8D2-0D22E51D3677@oracle.com>
 <44650cf2-a56c-43e2-7041-5ea3c3f2a202@redhat.com>
Content-Disposition: inline
In-Reply-To: <44650cf2-a56c-43e2-7041-5ea3c3f2a202@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA0PR11CA0067.namprd11.prod.outlook.com
 (2603:10b6:806:d2::12) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by
 SA0PR11CA0067.namprd11.prod.outlook.com (2603:10b6:806:d2::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.13 via Frontend Transport; Thu, 17 Dec 2020 22:55:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e8daf303-f642-4697-68f1-08d8a2dee716
X-MS-TrafficTypeDiagnostic: SN6PR12MB4751:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4751453EDC6D83099E1404C78EC40@SN6PR12MB4751.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L92J2bDY5ouoUzxFLO1lMXNB5uC+iwJHNdvUNoArF3HFSaNu/ipiq0gNCVzAfCSFCE8ANt9M0BsoQlVoF49ywdIp9Bukd6sDgPB57RpCozUoWdB/F0Mju82uW7gw7rDCKs1M+xCNl1m8anM5FZG8rlT54CMvrMS1IcZfhxnphAayCk0WEq4MjBdbUqxRznYPlx1FN+jUKeAGBXYcfuTUEbH9Uu4f2JYbLmgOC2e6N9UJrIMjxgmNWmDtXChiP//JYItP61lE4Ir/35cvbAaVBns+hkSOOM4sRzDiPyOI4GbLs2dVdAoOEs/GKWdCdNil
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(66556008)(956004)(6916009)(4326008)(9686003)(478600001)(33716001)(1076003)(7416002)(16526019)(2906002)(6666004)(86362001)(8936002)(186003)(33656002)(6496006)(5660300002)(66476007)(52116002)(66946007)(26005)(8676002)(316002)(54906003)(83380400001)(55016002)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ekZ2L0lVSG04NVRGNW96bTNPL3JzN2x3VTVkanlRNVpGZm5oa0pOZktXMUZC?=
 =?utf-8?B?eFM2aHMzMUt2dDNEbk9PbWNLQXVoamlmODltekdVdlVadW9YeElkNktIRWpa?=
 =?utf-8?B?Uy9idHRTSjhFYWZJOFNqVDcvTWhxdUNCOTUrQUFGM3VDNE9zTHA0SCtJZVA1?=
 =?utf-8?B?dWpYZ3Nsc0Q1Tll4OElXTEtxQUhEbmVUcUZrRmVFZXVWVGtSQUZJWG5rMlJr?=
 =?utf-8?B?QVNKN0k3U1hzRzJHdWErU095WTBlR080VWVzUGJ5ZWgySmhpbG1qS01VblFE?=
 =?utf-8?B?andFK1FZNTZlV1A5MHBpUGVSK2tzNytvLzlJOUxLRTZPSE5FMkZLa3JHdWJz?=
 =?utf-8?B?ZkRZUVE0dHlGUm1nZ0dwNHVMVnRXa1hvcEdFaG1yK2MwTHRIT2VNMFYyQzl2?=
 =?utf-8?B?NnBUT2dtcnEyanpZRGhQTTRNSy9YL0pVUU9IU2xaa3RaazBmcjFWOGtsSFpS?=
 =?utf-8?B?WnJpbjJsQmlMaDN5U05pNU1Ua1RPYk5pSTFwdUtjbXAwZXkvU1lRajJydzE4?=
 =?utf-8?B?cE5GRmx5REtpWmhtK2VuODMwUEVZVWpZdU9yYXJnNzJtbGVnL1JiY2RqOXVY?=
 =?utf-8?B?UUZDTVlWdzhqVitxZTVDYTZIQklTS2hKVUlINVI2cmxJaElDdGdkNFNibmtH?=
 =?utf-8?B?ODB0K25BbXUxcGpPUmdJdUZyQU5qVFYyUzQ3dkVIeGplY1ZGdHBQNjVUMGlV?=
 =?utf-8?B?VFQ0K0ZEY1N3SVNuMjBVMmpvZzY0b0hhTjdJY0toSGg5Z3lwalFtSW5KMlQ3?=
 =?utf-8?B?ZEFyNnFNOGFzcUk5aHJnd1k1SjNwWTZaSHE2ZW16R3NvNXhjS3cyN1gvWGEz?=
 =?utf-8?B?amVnd2szZjk2Z2I4QUxueVZRZ3Bmd3pLZDh1WTdIcGxwVmQ3U3owNkxwL2gx?=
 =?utf-8?B?bUtXRkR3QW5PWFlyNlU5R0ZvZFZMM0NtTFNlNkF6eHBVcEZIUzRkMjA1VU9j?=
 =?utf-8?B?ajZaTHVTMCt4SWRweHhObGxwTFNzelgvMG4zVmxiN1d4Vk9kYUtwRXBDRTdG?=
 =?utf-8?B?NXhoVUdkYVFnR3ZBb1M4ZXhHNDR3ZjduTlVMQ3FBVEs3dWZYQVNPYkpaMzhP?=
 =?utf-8?B?Y3E3clBodGZlTGJrVHZTUkJTOCtWN3g3UHIyZXBzcDFFU1F1bmtSNG5QYmpi?=
 =?utf-8?B?ZFpmaEV0REhyellqYmExVk4wamRTN3ZGYWt1T1F0SDUyYzRPOEpoWUJVZmw1?=
 =?utf-8?B?UzhqMkNtTmdNVnpmWkpibXRTd0Nwc01LZm1ZY3R6eE1xaVVmUGxqclo4VEdF?=
 =?utf-8?B?Z3N6aFphUFRNY0JZeXBTblJuZyt1cnFsdWxnajUwSGIvN2pSS0hHYWp3Q29U?=
 =?utf-8?Q?FC6XMaNZmLsJja1mgXu4V7ic0Hd24d8rNA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2020 22:55:51.5960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: e8daf303-f642-4697-68f1-08d8a2dee716
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ToFOkM8PyCJXE4kp/a7HYpMZl2jdOVL9PRhYBHIZemlT0Zv/7a4un3dVvyHMnhqyO1S8ZFAJqelF8RMgaXgafA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4751
Cc: Thomas.Lendacky@amd.com, Jon.Grimm@amd.com,
 Felicitas Hetzelt <file@sect.tu-berlin.de>,
 Martin Radev <martin.radev@aisec.fraunhofer.de>,
 david kaplan <david.kaplan@amd.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Robert Buhren <robert@sect.tu-berlin.de>, iommu@lists.linux-foundation.org,
 brijesh.singh@amd.com,
 Mathias Morbitzer <mathias.morbitzer@aisec.fraunhofer.de>, hch@lst.de
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gVGh1LCBEZWMgMTcsIDIwMjAgYXQgMTI6MTk6MTZQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzEyLzE2IOS4i+WNiDk6MDQsIEtvbnJhZCBSemVzenV0ZWsgV2lsayB3
cm90ZToKPiA+IE9uIERlY2VtYmVyIDE2LCAyMDIwIDE6NDE6NDggQU0gRVNULCBKYXNvbiBXYW5n
IDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gCj4gPiA+IC0tLS0tIE9yaWdpbmFs
IE1lc3NhZ2UgLS0tLS0KPiA+ID4gPiAKPiA+ID4gPiAtLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0t
LS0tCj4gPiA+ID4gPiAuc25pcC4KPiA+ID4gPiA+ID4gPiA+IFRoaXMgcmFpc2VzIHR3byBpc3N1
ZXM6Cj4gPiA+ID4gPiA+ID4gPiAxKSBzd2lvdGxiX3RsYl91bm1hcF9zaW5nbGUgZmFpbHMgdG8g
Y2hlY2sgd2hldGhlciB0aGUgaW5kZXgKPiA+ID4gPiA+ID4gPiA+IGdlbmVyYXRlZAo+ID4gPiA+
ID4gPiA+ID4gZnJvbSB0aGUgZG1hX2FkZHIgaXMgaW4gcmFuZ2Ugb2YgdGhlIGlvX3RsYl9vcmln
X2FkZHIgYXJyYXkuCj4gPiA+ID4gPiA+ID4gVGhhdCBpcyBmYWlybHkgc2ltcGxlIHRvIGltcGxl
bWVudCBJIHdvdWxkIHRoaW5rLiBUaGF0IGlzIGl0Cj4gPiA+IGNhbiBjaGVjawo+ID4gPiA+ID4g
PiA+IHRoYXQgdGhlIGRtYV9hZGRyIGlzIGZyb20gdGhlIFBBIGluIHRoZSBpb190bGIgcG9vbCB3
aGVuCj4gPiA+IFNXSU9UTEI9Zm9yY2UKPiA+ID4gPiA+ID4gPiBpcyB1c2VkLgo+ID4gPiA+ID4g
PiAKPiA+ID4gPiA+ID4gSSdtIG5vdCBzdXJlIHRoaXMgY2FuIGZpeCBhbGwgdGhlIGNhc2VzLiBJ
dCBsb29rcyB0byBtZSB3ZSBzaG91bGQKPiA+ID4gbWFwCj4gPiA+ID4gPiA+IGRlc2NyaXB0b3Ig
Y29oZXJlbnQgYnV0IHJlYWRvbmx5ICh3aGljaCBpcyBub3Qgc3VwcG9ydGVkIGJ5Cj4gPiA+IGN1
cnJlbnQgRE1BCj4gPiA+ID4gPiA+IEFQSSkuCj4gPiA+ID4gPiBJIHRoaW5rIEkgYW0gbWlzc2lu
ZyBzb21ldGhpbmcgb2J2aW91cyBoZXJlLiBUaGUgYXR0YWNrZXIgaXMgdGhlCj4gPiA+ID4gPiBo
eXBlcnZpc29yLAo+ID4gPiA+ID4gYWthCj4gPiA+ID4gPiB0aGUgb3duZXIgb2YgdGhlIFZpcnRJ
TyBkZXZpY2UgKHJpbmcwKS4gVGhlIGF0dGFja2VyIGlzIHRoZSBvbmUKPiA+ID4gdGhhdAo+ID4g
PiA+ID4gcHJvdmlkZXMgdGhlIGFkZHIvbGVuIC0gaGF2aW5nIHRoYXQgcmVhZG9ubHkgZnJvbSBh
IGd1ZXN0Cj4gPiA+IHBlcnNwZWN0aXZlCj4gPiA+ID4gPiBkb2VzIG5vdCBjaGFuZ2UgdGhlIGZh
Y3QgdGhhdCB0aGUgaHlwZXJ2aXNvciBjYW4gbW9kaWZ5IHRoZSBtZW1vcnkKPiA+ID4gcmFuZ2UK
PiA+ID4gPiA+IGJ5IG1hcHBpbmcgaXQgdmlhIGEgZGlmZmVyZW50IHZpcnR1YWwgYWRkcmVzcyBp
biB0aGUgaHlwZXJ2aXNvcj8KPiA+ID4gKGFrYQo+ID4gPiA+ID4gYWxpYXNpbmcgaXQpLgo+ID4g
PiA+IFJpZ2h0LCBidXQgaWYgd2UgYWxsb3cgaHlwZXJ2aXNvciB0byBwcm92aWRlIGFyYml0cmFy
eSBhZGRyL2xlbiwgZG9lcwo+ID4gPiA+IGl0IG1lYW4gaHlwZXJ2aXNvciBjYW4gcmVhZCBlbmNy
eXB0ZWQgY29udGVudCBvZiBlbmNyeXB0ZWQgbWVtb3J5IG9mCj4gPiA+ID4gZ3Vlc3QgdGhyb3Vn
aCBzd2lvdGxiPwo+ID4gWWVzIC4KPiA+ID4gPiBUaGFua3MKPiA+ID4gQWN0dWFsbHkgbm90LiBJ
IHRoaW5rIHlvdSdyZSByaWdodC4KPiA+IAo+ID4gWW91ciBzZW50ZW5jZSBpcyB2ZXJ5IGNvbmZ1
c2luZy4KPiAKPiAKPiBTb3JyeSBmb3LCoCBiZWluZyB1bmNsZWFyLiBUaGlzIGlzIGFsbCBhIHJl
cGx5IHRvIHlvdXIgc3VnZ2VzdGlvbiBvZiBhZGRpbmcKPiBjaGVja3MgaW4gdGhlIHN3aW90bGIu
Cj4gCj4gCj4gPiAKPiA+IE9uIGEgRE1BIHVubWFwIFNXSU9UTEIgKHdoZW4gZm9yY2UgaXMgdXNl
ZCkgaXQgdHJ1c3RzIHRoZSBkcml2ZXIgZnJvbSBwcm92aWRpbmcgdGhlIGNvcnJlY3QgRE1BIGFk
ZHJlc3MgYW5kIGxlbmd0aCB3aGljaCBTV0lPVExCIHVzZXMgdG8gbWF0Y2ggdG8gaXRzIGFzc29j
aWF0ZWQgb3JpZ2luYWwgUEEgYWRkcmVzcy4KPiA+IAo+ID4gVGhpbmsgb3JpZ2luYWwgUEEgaGF2
aW5nIGEgbWFwcGluZyB0byBhIFBBIGluIHRoZSBTV0lPVExCIHBvb2wuCj4gPiAKPiA+IAo+ID4g
VGhlIGxlbmd0aCBpcyBub3QgY2hlY2tlZCBzbyB0aGUgYXR0YWNrZXIgY2FuIG1vZGlmeSB0aGF0
IHRvIHNheSBhIGh1Z2UgbnVtYmVyIGFuZCBjYXVzZSBTV0lPVExCIGJvdW5jZSBjb2RlIHRvIHdy
aXRlIG9yIHJlYWQgZGF0YSBmcm9tIG5vbiBTV0lPVExCIFBBIGludG8gdGhlIFNXSU9UTEIgUEEg
cG9vbC4KPiAKPiAKPiBIb3cgY2FuIHdlIHJlYWQgaW4gdGhpcyBjYXNlPyBJdCBsb29rcyB0byBt
ZSB3ZSBkb24ndCB0cnkgdG8gcmVhZCBkdXJpbmcKPiBkbWFfdW5tYXAoKS4KPiAKClRoYXQgc2Vl
bXMgdG8gYmUgY29ycmVjdCBhcyBpbiB0aGUgdW5tYXAgcGF0aCwgc3dpb3RsYl9ib3VuY2UoKSBp
cyBiZWluZwpjYWxsZWQgd2l0aCBETUFfRlJPTV9ERVZJQ0UgZmxhZywgc28gdGhlcmUgaXMgbm8g
cmVhZCBpbnZvbHZlZCBkdXJpbmcKZG1hX3VubWFwKCkuCgpUaGFua3MsCkFzaGlzaAoKPiAKPiAK
PiA+IAo+ID4gCj4gPiAKPiA+IAo+ID4gPiBUaGFua3MKPiA+ID4gCj4gPiA+ID4gPiA+IE90aGVy
d2lzZSwgZGV2aWNlIGNhbiBtb2RpZnkgdGhlIGRlc2NbaV0uYWRkci9kZXNjW2ldLmxlbiBhdCBh
bnkKPiA+ID4gdGltZSB0bwo+ID4gPiA+ID4gPiBwcmV0ZW5kIGEgdmFsaWQgbWFwcGluZy4KPiA+
ID4gPiA+IFdpdGggdGhlIHN3aW90bGI9Zm9yY2UgYXMgbG9uZyBhcyBhZGRyL2xlbiBhcmUgd2l0
aGluIHRoZSBQQQo+ID4gPiBib3VuZGFyaWVzCj4gPiA+ID4gPiB3aXRoaW4gdGhlIFNXSU9UTEIg
cG9vbCB0aGlzIHNob3VsZCBiZSBPSz8KPiA+ID4gPiA+IAo+ID4gPiA+ID4gQWZ0ZXIgYWxsIHRo
YXQgd2hvbGUgYXJlYSBpcyBpbiBjbGVhcnRleHQgYW5kIHZpc2libGUgdG8gdGhlCj4gPiA+IGF0
dGFja2VyLgo+ID4gPiA+ID4gCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by9pb21tdQ==
