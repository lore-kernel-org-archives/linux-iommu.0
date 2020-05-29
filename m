Return-Path: <SRS0=ta7q=7L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A5BC433DF
	for <iommu@archiver.kernel.org>; Fri, 29 May 2020 16:37:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F09CB2077D
	for <iommu@archiver.kernel.org>; Fri, 29 May 2020 16:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09CB2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=forcepoint.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AAE0C2612E;
	Fri, 29 May 2020 16:37:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UKmrlYQz3mGo; Fri, 29 May 2020 16:37:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 61ABC20390;
	Fri, 29 May 2020 16:37:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B98EC088A;
	Fri, 29 May 2020 16:37:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 991F8C016F
 for <iommu@lists.linux-foundation.org>; Fri, 29 May 2020 16:14:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 889D787F69
 for <iommu@lists.linux-foundation.org>; Fri, 29 May 2020 16:14:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uZFNdMi0RrTE for <iommu@lists.linux-foundation.org>;
 Fri, 29 May 2020 16:14:46 +0000 (UTC)
X-Greylist: delayed 00:15:04 by SQLgrey-1.7.6
Received: from esg-sm.forcepoint.com (esg-sm2.forcepoint.com [204.15.67.172])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 79E97884BB
 for <iommu@lists.linux-foundation.org>; Fri, 29 May 2020 16:14:46 +0000 (UTC)
Received: from webmailgov.forcepoint.com (unknown [172.29.172.3])
 by Forcepoint Email with ESMTPS id 963EF3D1C99204C673BE;
 Fri, 29 May 2020 08:59:39 -0700 (PDT)
Received: from SRCA019EXCH1A.tcs-sec.com (172.29.172.2) by
 SRCA019EXCH1B.tcs-sec.com (172.29.172.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1466.3; Fri, 29 May 2020 08:59:48 -0700
Received: from USG02-BN3-obe.outbound.protection.office365.us (23.103.199.152)
 by SRCA019EXCH1A.tcs-sec.com (172.29.172.2) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3
 via Frontend Transport; Fri, 29 May 2020 08:59:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=hveCcgUrIrftNXV43mu6lM/1ihQxDRdfNSE5waHwuS6MmmNR8UYaQ/GduM/tdqdkKh/1ctQOmoF9QCS1oZsqiKU+o73aIHnxi9CHdta3ufa8hH0+QcS9N5ptnd4M4zXvR4GSQERSlGrQHu8vAsfFW/e9d/p/Q92hbE5rBm9Uc+vYG8H7ymSiHBJ8qVsDL49/vHig6nD5URll9lEHJbFg8yKrsq0rKQUoV1/9QwwaKJ++ypAdvi0a9CAkJ9VEaKTs+zsbxsPBWFGRIfP5l5xx1qVZCB7QiBmlJHQbGWQyMMRN4UPMntocTSLDE1qBHFpEdZ3U3/ddxetWmjWrk0V0Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+eY/y64gj11U/Ml03JCaLC4Fqc8jcWYTLg+K8HGtKA=;
 b=tjpO215Kn4niHyZZNuwAzdqQk4ef9BxjVLfBgruh+gWZXg83ck7lVw4ADy9F4zv1XtfrGhz1XUwgZAdxEn4wAO5gBdxBhok0aZriHheZ7KixFR1j7bDwIaM9nsGRSvZds4/pwCupDS1rCl/7tbDYO2o1q9hBtPEgnOS8jV2fsglHwU/Ch1MQ5KXlF9gAXBIHLSDUXdIyDk5gFLpI3FZikzih8N5MggPKSZ7Od4kDfa2PAFPkvKqewTKv6fJZ4pqf7NB53gWARIz4GiiK8hVzwjL3WdExw3i2ulBoOtO76ZIXlpOYt8AhbizgwsfoeLTTFeTdVThTw+VY5zksk8DRTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=forcepointgov.com; dmarc=pass action=none
 header.from=forcepointgov.com; dkim=pass header.d=forcepointgov.com; arc=none
Authentication-Results: forcepoint.com; dkim=none (message not signed)
 header.d=none;forcepoint.com; dmarc=none action=none
 header.from=forcepointgov.com;
Received: from DM3P110MB0538.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:414::9)
 by DM3P110MB0441.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:412::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.32; Fri, 29 May
 2020 15:59:35 +0000
Received: from DM3P110MB0538.NAMP110.PROD.OUTLOOK.COM
 ([fe80::c08b:22f5:bb8a:a1d3]) by DM3P110MB0538.NAMP110.PROD.OUTLOOK.COM
 ([fe80::c08b:22f5:bb8a:a1d3%7]) with mapi id 15.20.3000.039; Fri, 29 May 2020
 15:59:35 +0000
Subject: Re: Re: [PATCH] PCI: Relax ACS requirement for Intel RCiEP devices.
To: Ashok Raj <ashok.raj@intel.com>
References: <1590699462-7131-1-git-send-email-ashok.raj@intel.com>
 <20200528153826.257a0145@x1.home>
From: Darrel Goeddel <dgoeddel@forcepoint.com>
Message-ID: <842370df-0ec3-fc81-f734-33078f2ccc4c@forcepointgov.com>
Date: Fri, 29 May 2020 10:59:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200528153826.257a0145@x1.home>
Content-Language: en-US
X-ClientProxiedBy: CY1P110CA0056.NAMP110.PROD.OUTLOOK.COM
 (2001:489a:200:400::26) To DM3P110MB0538.NAMP110.PROD.OUTLOOK.COM
 (2001:489a:200:414::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dgoeddel-pc.champ.us.fdo (192.241.53.215) by
 CY1P110CA0056.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:400::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.39 via Frontend Transport; Fri, 29 May 2020 15:59:34 +0000
X-Originating-IP: [192.241.53.215]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfc0dfce-e0b8-4f0b-0937-08d803e94871
X-MS-TrafficTypeDiagnostic: DM3P110MB0441:
X-Microsoft-Antispam-PRVS: <DM3P110MB044131CB6483A21D60ABD2C8DA8F0@DM3P110MB0441.NAMP110.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3P110MB0538.NAMP110.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(66946007)(66476007)(66556008)(54906003)(5660300002)(4326008)(83380400001)(16526019)(186003)(498600001)(53546011)(26005)(7416002)(2906002)(52116002)(31686004)(8936002)(6916009)(6486002)(2616005)(6512007)(8676002)(31696002)(956004)(86362001)(36756003)(6506007)(43740500002)(16060500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc0dfce-e0b8-4f0b-0937-08d803e94871
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 15:59:35.2335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c1def8d1-d468-417f-bc2c-0c2734eaec23
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3P110MB0441
X-Mailman-Approved-At: Fri, 29 May 2020 16:37:01 +0000
Cc: Darrel Goeddel <DGoeddel@forcepoint.com>, linux-pci@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, Mark
 Scott <mscott@forcepoint.com>, Romil Sharma <rsharma@forcepoint.com>,
 Bjorn Helgaas <bhelgaas@google.com>
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

T24gNS8yOC8yMCA0OjM4IFBNLCBBbGV4IFdpbGxpYW1zb24gd3JvdGU6Cj4gT24gVGh1LCAyOCBN
YXkgMjAyMCAxMzo1Nzo0MiAtMDcwMAo+IEFzaG9rIFJhaiA8YXNob2sucmFqQGludGVsLmNvbT4g
d3JvdGU6Cj4gCj4+IEFsbCBJbnRlbCBwbGF0Zm9ybXMgZ3VhcmFudGVlIHRoYXQgYWxsIHJvb3Qg
Y29tcGxleCBpbXBsZW1lbnRhdGlvbnMKPj4gbXVzdCBzZW5kIHRyYW5zYWN0aW9ucyB1cCB0byBJ
T01NVSBmb3IgYWRkcmVzcyB0cmFuc2xhdGlvbnMuIEhlbmNlIGZvcgo+PiBSQ2lFUCBkZXZpY2Vz
IHRoYXQgYXJlIFZlbmRvciBJRCBJbnRlbCwgY2FuIGNsYWltIGV4Y2VwdGlvbiBmb3IgbGFjayBv
Zgo+PiBBQ1Mgc3VwcG9ydC4KPj4KPj4KPj4gMy4xNiBSb290LUNvbXBsZXggUGVlciB0byBQZWVy
IENvbnNpZGVyYXRpb25zCj4+IFdoZW4gRE1BIHJlbWFwcGluZyBpcyBlbmFibGVkLCBwZWVyLXRv
LXBlZXIgcmVxdWVzdHMgdGhyb3VnaCB0aGUKPj4gUm9vdC1Db21wbGV4IG11c3QgYmUgaGFuZGxl
ZAo+PiBhcyBmb2xsb3dzOgo+PiDigKIgVGhlIGlucHV0IGFkZHJlc3MgaW4gdGhlIHJlcXVlc3Qg
aXMgdHJhbnNsYXRlZCAodGhyb3VnaCBmaXJzdC1sZXZlbCwKPj4gICAgc2Vjb25kLWxldmVsIG9y
IG5lc3RlZCB0cmFuc2xhdGlvbikgdG8gYSBob3N0IHBoeXNpY2FsIGFkZHJlc3MgKEhQQSkuCj4+
ICAgIFRoZSBhZGRyZXNzIGRlY29kaW5nIGZvciBwZWVyIGFkZHJlc3NlcyBtdXN0IGJlIGRvbmUg
b25seSBvbiB0aGUKPj4gICAgdHJhbnNsYXRlZCBIUEEuIEhhcmR3YXJlIGltcGxlbWVudGF0aW9u
cyBhcmUgZnJlZSB0byBmdXJ0aGVyIGxpbWl0Cj4+ICAgIHBlZXItdG8tcGVlciBhY2Nlc3NlcyB0
byBzcGVjaWZpYyBob3N0IHBoeXNpY2FsIGFkZHJlc3MgcmVnaW9ucwo+PiAgICAob3IgdG8gY29t
cGxldGVseSBkaXNhbGxvdyBwZWVyLWZvcndhcmRpbmcgb2YgdHJhbnNsYXRlZCByZXF1ZXN0cyku
Cj4+IOKAoiBTaW5jZSBhZGRyZXNzIHRyYW5zbGF0aW9uIGNoYW5nZXMgdGhlIGNvbnRlbnRzIChh
ZGRyZXNzIGZpZWxkKSBvZgo+PiAgICB0aGUgUENJIEV4cHJlc3MgVHJhbnNhY3Rpb24gTGF5ZXIg
UGFja2V0IChUTFApLCBmb3IgUENJIEV4cHJlc3MKPj4gICAgcGVlci10by1wZWVyIHJlcXVlc3Rz
IHdpdGggRUNSQywgdGhlIFJvb3QtQ29tcGxleCBoYXJkd2FyZSBtdXN0IHVzZQo+PiAgICB0aGUg
bmV3IEVDUkMgKHJlLWNvbXB1dGVkIHdpdGggdGhlIHRyYW5zbGF0ZWQgYWRkcmVzcykgaWYgaXQK
Pj4gICAgZGVjaWRlcyB0byBmb3J3YXJkIHRoZSBUTFAgYXMgYSBwZWVyIHJlcXVlc3QuCj4+IOKA
oiBSb290LXBvcnRzLCBhbmQgbXVsdGktZnVuY3Rpb24gcm9vdC1jb21wbGV4IGludGVncmF0ZWQg
ZW5kcG9pbnRzLCBtYXkKPj4gICAgc3VwcG9ydCBhZGRpdGlvbmFsIHBlZXJ0by1wZWVyIGNvbnRy
b2wgZmVhdHVyZXMgYnkgc3VwcG9ydGluZyBQQ0kgRXhwcmVzcwo+PiAgICBBY2Nlc3MgQ29udHJv
bCBTZXJ2aWNlcyAoQUNTKSBjYXBhYmlsaXR5LiBSZWZlciB0byBBQ1MgY2FwYWJpbGl0eSBpbgo+
PiAgICBQQ0kgRXhwcmVzcyBzcGVjaWZpY2F0aW9ucyBmb3IgZGV0YWlscy4KPj4KPj4gU2luY2Ug
TGludXggZGlkbid0IGdpdmUgc3BlY2lhbCB0cmVhdG1lbnQgdG8gYWxsb3cgdGhpcyBleGNlcHRp
b24sIGNlcnRhaW4KPj4gUkNpRVAgTUZEIGRldmljZXMgYXJlIGdldHRpbmcgZ3JvdXBlZCBpbiBh
IHNpbmdsZSBpb21tdSBncm91cC4gVGhpcwo+PiBkb2Vzbid0IHBlcm1pdCBhIHNpbmdsZSBkZXZp
Y2UgdG8gYmUgYXNzaWduZWQgdG8gYSBndWVzdCBmb3IgaW5zdGFuY2UuCj4+Cj4+IEluIG9uZSB2
ZW5kb3Igc3lzdGVtOiBEZXZpY2UgMTQueCB3ZXJlIGdyb3VwZWQgaW4gYSBzaW5nbGUgSU9NTVUg
Z3JvdXAuCj4+Cj4+IC9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy81L2RldmljZXMvMDAwMDowMDox
NC4wCj4+IC9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy81L2RldmljZXMvMDAwMDowMDoxNC4yCj4+
IC9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy81L2RldmljZXMvMDAwMDowMDoxNC4zCj4+Cj4+IEFm
dGVyIHRoZSBwYXRjaDoKPj4gL3N5cy9rZXJuZWwvaW9tbXVfZ3JvdXBzLzUvZGV2aWNlcy8wMDAw
OjAwOjE0LjAKPj4gL3N5cy9rZXJuZWwvaW9tbXVfZ3JvdXBzLzUvZGV2aWNlcy8wMDAwOjAwOjE0
LjIKPj4gL3N5cy9rZXJuZWwvaW9tbXVfZ3JvdXBzLzYvZGV2aWNlcy8wMDAwOjAwOjE0LjMgPDw8
IG5ldyBncm91cAo+Pgo+PiAxNC4wIGFuZCAxNC4yIGFyZSBpbnRlZ3JhdGVkIGRldmljZXMsIGJ1
dCBsZWdhY3kgZW5kIHBvaW50cy4KPj4gV2hlcmVhcyAxNC4zIHdhcyBhIFBDSWUgY29tcGxpYW50
IFJDaUVQLgo+Pgo+PiAwMDoxNC4zIE5ldHdvcmsgY29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRp
b24gRGV2aWNlIDlkZjAgKHJldiAzMCkKPj4gQ2FwYWJpbGl0aWVzOiBbNDBdIEV4cHJlc3MgKHYy
KSBSb290IENvbXBsZXggSW50ZWdyYXRlZCBFbmRwb2ludCwgTVNJIDAwCj4+Cj4+IFRoaXMgcGVy
bWl0cyBhc3NpZ25pbmcgdGhpcyBkZXZpY2UgdG8gYSBndWVzdCBWTS4KPj4KPj4gRml4ZXM6IGYw
OTZjMDYxZjU1MiAoImlvbW11OiBSZXdvcmsgaW9tbXVfZ3JvdXBfZ2V0X2Zvcl9wY2lfZGV2KCki
KQo+IAo+IEkgZG9uJ3QgcmVhbGx5IHVuZGVyc3RhbmQgdGhpcyBGaXhlcyB0YWcuICBUaGlzIHNl
ZW1zIGxpa2UgYSBmZWF0dXJlLAo+IG5vdCBhIGZpeC4gIElmIHlvdSB3YW50IGl0IGluIHN0YWJs
ZSByZWxlYXNlcyBhcyBhIGZlYXR1cmUsIHJlcXVlc3QgaXQKPiB2aWEgQ2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcuICBJJ2QgZHJvcCB0aGF0IHRhZywgdGhhdCdzIG15IG5pdC4KPiBPdGhlcndp
c2U6Cj4gCj4gUmV2aWV3ZWQtYnk6IEFsZXggV2lsbGlhbXNvbiA8YWxleC53aWxsaWFtc29uQHJl
ZGhhdC5jb20+CgpJIGhhdmUgdGVzdGVkIHRoaXMgcGF0Y2ggd2l0aCA1LjYuMTQgYXMgd2VsbCBh
cyBhIHNsaWdodGx5IG1vZGlmaWVkCnZlcnNpb24gKHdpdGhvdXQgcGNpX2Fjc19jdHJsX2VuYWJs
ZWQoKSkgaW4gYSAzLjEwIGVudGVycHJpc2UgbGludXgKa2VybmVsLgoKVGVzdGVkLWJ5OiBEYXJy
ZWwgR29lZGRlbCA8ZGdvZWRkZWxAZm9yY2Vwb2ludC5jb20+Cgo+PiBTaWduZWQtb2ZmLWJ5OiBB
c2hvayBSYWogPGFzaG9rLnJhakBpbnRlbC5jb20+Cj4+IFRvOiBKb2VyZyBSb2VkZWwgPGpvcm9A
OGJ5dGVzLm9yZz4KPj4gVG86IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+Cj4+
IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4+IENjOiBpb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwo+PiBDYzogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNv
bT4KPj4gQ2M6IEFsZXggV2lsbGlhbXNvbiA8YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb20+Cj4+
IENjOiBEYXJyZWwgR29lZGRlbCA8REdvZWRkZWxAZm9yY2Vwb2ludC5jb20+Cj4+IENjOiBNYXJr
IFNjb3R0IDxtc2NvdHRAZm9yY2Vwb2ludC5jb20+LAo+PiBDYzogUm9taWwgU2hhcm1hIDxyc2hh
cm1hQGZvcmNlcG9pbnQuY29tPgo+PiBDYzogQXNob2sgUmFqIDxhc2hvay5yYWpAaW50ZWwuY29t
Pgo+PiAtLS0KPj4gdjI6IE1vdmVkIGZ1bmN0aW9uYWxpdHkgZnJvbSBpb21tdSB0byBwY2kgcXVp
cmtzIC0gQWxleCBXaWxsaWFtc29uCj4+Cj4+ICAgZHJpdmVycy9wY2kvcXVpcmtzLmMgfCAxNSAr
KysrKysrKysrKysrKysKPj4gICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKQo+Pgo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcXVpcmtzLmMgYi9kcml2ZXJzL3BjaS9xdWlya3Mu
Ywo+PiBpbmRleCAyOGM5YTI0MDljNTAuLjYzMzczY2EwYTNmZSAxMDA2NDQKPj4gLS0tIGEvZHJp
dmVycy9wY2kvcXVpcmtzLmMKPj4gKysrIGIvZHJpdmVycy9wY2kvcXVpcmtzLmMKPj4gQEAgLTQ2
ODIsNiArNDY4MiwyMCBAQCBzdGF0aWMgaW50IHBjaV9xdWlya19tZl9lbmRwb2ludF9hY3Moc3Ry
dWN0IHBjaV9kZXYgKmRldiwgdTE2IGFjc19mbGFncykKPj4gICAJCVBDSV9BQ1NfQ1IgfCBQQ0lf
QUNTX1VGIHwgUENJX0FDU19EVCk7Cj4+ICAgfQo+PiAgIAo+PiArc3RhdGljIGludCBwY2lfcXVp
cmtfcmNpZXBfYWNzKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHUxNiBhY3NfZmxhZ3MpCj4+ICt7Cj4+
ICsJLyoKPj4gKwkgKiBSQ2lFUCdzIGFyZSByZXF1aXJlZCB0byBhbGxvdyBwMnAgb25seSBvbiB0
cmFuc2xhdGVkIGFkZHJlc3Nlcy4KPj4gKwkgKiBSZWZlciB0byBJbnRlbCBWVC1kIHNwZWNpZmlj
YXRpb24gU2VjdGlvbiAzLjE2IFJvb3QtQ29tcGxleCBQZWVyCj4+ICsJICogdG8gUGVlciBDb25z
aWRlcmF0aW9ucwo+PiArCSAqLwo+PiArCWlmIChwY2lfcGNpZV90eXBlKGRldikgIT0gUENJX0VY
UF9UWVBFX1JDX0VORCkKPj4gKwkJcmV0dXJuIC1FTk9UVFk7Cj4+ICsKPj4gKwlyZXR1cm4gcGNp
X2Fjc19jdHJsX2VuYWJsZWQoYWNzX2ZsYWdzLAo+PiArCQlQQ0lfQUNTX1NWIHwgUENJX0FDU19S
UiB8IFBDSV9BQ1NfQ1IgfCBQQ0lfQUNTX1VGKTsKPj4gK30KPj4gKwo+PiAgIHN0YXRpYyBpbnQg
cGNpX3F1aXJrX2JyY21fYWNzKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHUxNiBhY3NfZmxhZ3MpCj4+
ICAgewo+PiAgIAkvKgo+PiBAQCAtNDc2NCw2ICs0Nzc4LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBwY2lfZGV2X2Fjc19lbmFibGVkIHsKPj4gICAJLyogSTIxOSAqLwo+PiAgIAl7IFBDSV9WRU5E
T1JfSURfSU5URUwsIDB4MTViNywgcGNpX3F1aXJrX21mX2VuZHBvaW50X2FjcyB9LAo+PiAgIAl7
IFBDSV9WRU5ET1JfSURfSU5URUwsIDB4MTViOCwgcGNpX3F1aXJrX21mX2VuZHBvaW50X2FjcyB9
LAo+PiArCXsgUENJX1ZFTkRPUl9JRF9JTlRFTCwgUENJX0FOWV9JRCwgcGNpX3F1aXJrX3JjaWVw
X2FjcyB9LAo+PiAgIAkvKiBRQ09NIFFERjJ4eHggcm9vdCBwb3J0cyAqLwo+PiAgIAl7IFBDSV9W
RU5ET1JfSURfUUNPTSwgMHgwNDAwLCBwY2lfcXVpcmtfcWNvbV9ycF9hY3MgfSwKPj4gICAJeyBQ
Q0lfVkVORE9SX0lEX1FDT00sIDB4MDQwMSwgcGNpX3F1aXJrX3Fjb21fcnBfYWNzIH0sCj4gCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
