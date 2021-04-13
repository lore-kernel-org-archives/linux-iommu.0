Return-Path: <SRS0=gU7u=JK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6262AC433B4
	for <iommu@archiver.kernel.org>; Tue, 13 Apr 2021 18:06:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E77D7613B6
	for <iommu@archiver.kernel.org>; Tue, 13 Apr 2021 18:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E77D7613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8AC86069E;
	Tue, 13 Apr 2021 18:05:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uyeyyw74DXzm; Tue, 13 Apr 2021 18:05:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 706F1606BD;
	Tue, 13 Apr 2021 18:05:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FD7DC000C;
	Tue, 13 Apr 2021 18:05:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9DF13C000A
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 18:05:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8D236607C6
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 18:05:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 56gqdPza9_JJ for <iommu@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 18:05:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B5D926069E
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 18:05:55 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DHxOtW132100;
 Tue, 13 Apr 2021 18:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=hlNJKe5ZQHqLJBRDE/GVAnsIZF7aOarhXY6k7i8Dylw=;
 b=FciRzDciVSbNwefWpUyrNgvLDwWVLtIxe63ZfSv+cnP4bZPY7TCW9kIuru74bppW7pWP
 qN2JPp+IN31FDUKJ9SLnIE6iDXmmT94GT+Zwj5y6yc41PBq/RzDgTi2lbEXn4bYcXWUj
 /b2FNdLJ3FztekbTRRm9trWusvyzt5PStNsqVtYr8oeZPxChrOlLzGQr5rmE1l5uFgtA
 ZBNqVM2klzp4t6HWY6NCxANQZCYpwzWn/NTYRWBXM+V/3bRDvDW41ADA1Zs6DfZs7/UW
 IJlZmIjegA81YsKR1yaannfx3ZUOe3/fRVlrEA0gftUvlO+052Z6yNVBHvJhroNfGJEh GA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2130.oracle.com with ESMTP id 37u1hbg4h9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Apr 2021 18:05:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DI1ivZ183168;
 Tue, 13 Apr 2021 18:05:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 37unx04dwa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Apr 2021 18:05:37 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13DI5akD020777;
 Tue, 13 Apr 2021 18:05:36 GMT
Received: from dhcp-10-159-224-82.vpn.oracle.com (/10.159.224.82)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 13 Apr 2021 18:05:36 +0000
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 5.4 v3 1/1] iommu/vt-d: Fix agaw for a supported 48 bit
 guest address width
From: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
In-Reply-To: <YHVJDM4CXINrO1KE@kroah.com>
Date: Tue, 13 Apr 2021 11:05:34 -0700
Message-Id: <0C3869E0-63C9-42D5-AAE2-D9D24011B93E@oracle.com>
References: <20210412202736.70765-1-saeed.mirzamohammadi@oracle.com>
 <YHVJDM4CXINrO1KE@kroah.com>
To: Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130122
X-Proofpoint-GUID: nnkPDQQoNtBu7Wr08YfCj6ThuPIZvrbx
X-Proofpoint-ORIG-GUID: nnkPDQQoNtBu7Wr08YfCj6ThuPIZvrbx
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 priorityscore=1501
 clxscore=1015 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130122
Cc: Camille Lu <camille.lu@hpe.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "# v4 . 16+" <stable@vger.kernel.org>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>
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

SGkgR3JlZywKCkkgZG9u4oCZdCBoYXZlIGFueSBjb21taXQgSUQgc2luY2UgdGhlIGZpeCBpcyBu
b3QgaW4gbWFpbmxpbmUgb3IgYW55IExpbnVz4oCZIHRyZWUgeWV0LiBUaGUgZHJpdmVyIGhhcyBj
b21wbGV0ZWx5IGNoYW5nZWQgZm9yIG5ld2VyIHN0YWJsZSB2ZXJzaW9ucyAoYW5kIGFsc28gbWFp
bmxpbmUpIGFuZCB0aGUgZml4IG9ubHkgYXBwbGllcyBmb3IgNS40LCA0LjE5LCBhbmQgNC4xNCBz
dGFibGUga2VybmVscy4KClRoYW5rcywKU2FlZWQKCgo+IE9uIEFwciAxMywgMjAyMSwgYXQgMTI6
MzIgQU0sIEdyZWcgS0ggPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToKPiAKPiAK
PiBPbiBNb24sIEFwciAxMiwgMjAyMSBhdCAwMToyNzozNVBNIC0wNzAwLCBTYWVlZCBNaXJ6YW1v
aGFtbWFkaSB3cm90ZToKPj4gVGhlIElPTU1VIGRyaXZlciBjYWxjdWxhdGVzIHRoZSBndWVzdCBh
ZGRyZXNzYWJpbGl0eSBmb3IgYSBETUEgcmVxdWVzdAo+PiBiYXNlZCBvbiB0aGUgdmFsdWUgb2Yg
dGhlIG1nYXcgcmVwb3J0ZWQgZnJvbSB0aGUgSU9NTVUuIEhvd2V2ZXIsIHRoaXMKPj4gaXMgYSBm
dXNlZCB2YWx1ZSBhbmQgYXMgbWVudGlvbmVkIGluIHRoZSBzcGVjLCB0aGUgZ3Vlc3Qgd2lkdGgK
Pj4gc2hvdWxkIGJlIGNhbGN1bGF0ZWQgYmFzZWQgb24gdGhlIG1pbmltdW0gb2Ygc3VwcG9ydGVk
IGFkanVzdGVkIGd1ZXN0Cj4+IGFkZHJlc3Mgd2lkdGggKFNBR0FXKSBhbmQgTUdBVy4KPj4gCj4+
IFRoaXMgaXMgZnJvbSBzcGVjaWZpY2F0aW9uOgo+PiAiR3Vlc3QgYWRkcmVzc2FiaWxpdHkgZm9y
IGEgZ2l2ZW4gRE1BIHJlcXVlc3QgaXMgbGltaXRlZCB0byB0aGUKPj4gbWluaW11bSBvZiB0aGUg
dmFsdWUgcmVwb3J0ZWQgdGhyb3VnaCB0aGlzIGZpZWxkIGFuZCB0aGUgYWRqdXN0ZWQKPj4gZ3Vl
c3QgYWRkcmVzcyB3aWR0aCBvZiB0aGUgY29ycmVzcG9uZGluZyBwYWdlLXRhYmxlIHN0cnVjdHVy
ZS4KPj4gKEFkanVzdGVkIGd1ZXN0IGFkZHJlc3Mgd2lkdGhzIHN1cHBvcnRlZCBieSBoYXJkd2Fy
ZSBhcmUgcmVwb3J0ZWQKPj4gdGhyb3VnaCB0aGUgU0FHQVcgZmllbGQpLiIKPj4gCj4+IFRoaXMg
Y2F1c2VzIGRvbWFpbiBpbml0aWFsaXphdGlvbiB0byBmYWlsIGFuZCBmb2xsb3dpbmcKPj4gZXJy
b3JzIGFwcGVhciBmb3IgRUhDSSBQQ0kgZHJpdmVyOgo+PiAKPj4gWyAgICAyLjQ4NjM5M10gZWhj
aS1wY2kgMDAwMDowMTowMC40OiBFSENJIEhvc3QgQ29udHJvbGxlcgo+PiBbICAgIDIuNDg2NjI0
XSBlaGNpLXBjaSAwMDAwOjAxOjAwLjQ6IG5ldyBVU0IgYnVzIHJlZ2lzdGVyZWQsIGFzc2lnbmVk
IGJ1cwo+PiBudW1iZXIgMQo+PiBbICAgIDIuNDg5MTI3XSBlaGNpLXBjaSAwMDAwOjAxOjAwLjQ6
IERNQVI6IEFsbG9jYXRpbmcgZG9tYWluIGZhaWxlZAo+PiBbICAgIDIuNDg5MzUwXSBlaGNpLXBj
aSAwMDAwOjAxOjAwLjQ6IERNQVI6IDMyYml0IERNQSB1c2VzIG5vbi1pZGVudGl0eQo+PiBtYXBw
aW5nCj4+IFsgICAgMi40ODkzNTldIGVoY2ktcGNpIDAwMDA6MDE6MDAuNDogY2FuJ3Qgc2V0dXA6
IC0xMgo+PiBbICAgIDIuNDg5NTMxXSBlaGNpLXBjaSAwMDAwOjAxOjAwLjQ6IFVTQiBidXMgMSBk
ZXJlZ2lzdGVyZWQKPj4gWyAgICAyLjQ5MDAyM10gZWhjaS1wY2kgMDAwMDowMTowMC40OiBpbml0
IDAwMDA6MDE6MDAuNCBmYWlsLCAtMTIKPj4gWyAgICAyLjQ5MDM1OF0gZWhjaS1wY2k6IHByb2Jl
IG9mIDAwMDA6MDE6MDAuNCBmYWlsZWQgd2l0aCBlcnJvciAtMTIKPj4gCj4+IFRoaXMgaXNzdWUg
aGFwcGVucyB3aGVuIHRoZSB2YWx1ZSBvZiB0aGUgc2FnYXcgY29ycmVzcG9uZHMgdG8gYQo+PiA0
OC1iaXQgYWdhdy4gVGhpcyBmaXggdXBkYXRlcyB0aGUgY2FsY3VsYXRpb24gb2YgdGhlIGFnYXcg
YmFzZWQgb24KPj4gdGhlIG1pbmltdW0gb2YgSU9NTVUncyBzYWdhdyB2YWx1ZSBhbmQgTUdBVy4K
Pj4gCj4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCj4+IFNpZ25lZC1vZmYtYnk6IFNhZWVk
IE1pcnphbW9oYW1tYWRpIDxzYWVlZC5taXJ6YW1vaGFtbWFkaUBvcmFjbGUuY29tPgo+PiBUZXN0
ZWQtYnk6IENhbWlsbGUgTHUgPGNhbWlsbGUubHVAaHBlLmNvbT4KPj4gUmV2aWV3ZWQtYnk6IEx1
IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+Cj4gCj4gV2hhdCBpcyB0aGUgZ2l0IGNv
bW1pdCBpZCBvZiB0aGlzIHBhdGNoIGluIExpbnVzJ3MgdHJlZT8KPiAKPiB0aGFua3MsCj4gCj4g
Z3JlZyBrLWgKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
