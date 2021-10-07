Return-Path: <SRS0=VyMr=O3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737A1C433EF
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 11:00:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F212261038
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 11:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F212261038
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCAA540909;
	Thu,  7 Oct 2021 11:00:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sSafs-SpS42a; Thu,  7 Oct 2021 11:00:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 25AD4405F7;
	Thu,  7 Oct 2021 11:00:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9062C0011;
	Thu,  7 Oct 2021 11:00:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73E48C000D
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 11:00:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 559D440909
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 11:00:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uzsHLou-cTNG for <iommu@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 11:00:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7DCF0405F7
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 11:00:18 +0000 (UTC)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1979aNfX021276; 
 Thu, 7 Oct 2021 06:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=jOJ33YjEn/VRMnsqj2+ffjTRn0vZYsJ/XCDQ0GiGnls=;
 b=jr+8GLibaHwM1kjWjATXF0cYfbeacTlie4xgKxlJ7bDH0gRKe2V8CRPS1H4fDyF0/L/g
 YIdDIHwL5HS9ETSZn+E9tWI0vqQjAry5apqmf0d4M+mlbN+uY7xyq6pXMiKxSdetUJAX
 QZmevIeuEBhYMZqWx5L5ZIVU09N8fm2pPXl/BRUEJclX+xeSuoMphowjwPnTNyXfFOSx
 ffQ8ZscPllw84WFaciDWrZFR5YUDQUTPuWETRpzREShITo0PumB7v8vnqvjdD0CCHIBZ
 yqDzVfjza6e9++HDJz7oSRWGG0fn2/68TydTHcuKUhHgAjHVov0RlRPXnU9OVAfzxAnb qQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3bhksy6j8g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Oct 2021 06:59:37 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 197Au2xF019413;
 Thu, 7 Oct 2021 10:59:35 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma06ams.nl.ibm.com with ESMTP id 3bhepd002r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Oct 2021 10:59:35 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 197AxWgC45613416
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 7 Oct 2021 10:59:32 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4973AE074;
 Thu,  7 Oct 2021 10:59:32 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E49E6AE070;
 Thu,  7 Oct 2021 10:59:31 +0000 (GMT)
Received: from [9.171.95.81] (unknown [9.171.95.81])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  7 Oct 2021 10:59:31 +0000 (GMT)
Message-ID: <fd4a2d8d-3f9d-51f3-1c86-8009ad50e6a1@linux.ibm.com>
Date: Thu, 7 Oct 2021 12:59:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: DPAA2 triggers, [PATCH] dma debug: report -EEXIST errors in
 add_dma_entry
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Hamza Mahfooz <someguy@effective-light.com>,
 Christoph Hellwig <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>
References: <20210518125443.34148-1-someguy@effective-light.com>
 <fd67fbac-64bf-f0ea-01e1-5938ccfab9d0@arm.com>
 <20210914154504.z6vqxuh3byqwgfzx@skbuf>
 <185e7ee4-3749-4ccb-6d2e-da6bc8f30c04@linux.ibm.com>
 <20211001145256.0323957a@thinkpad> <20211006151043.61fe9613@thinkpad>
 <4a96b583-1119-8b26-cc85-f77a6b4550a2@arm.com>
From: Karsten Graul <kgraul@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <4a96b583-1119-8b26-cc85-f77a6b4550a2@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kDPanIe3NO7XqJurDB-cWKBky-zO4U2A
X-Proofpoint-ORIG-GUID: kDPanIe3NO7XqJurDB-cWKBky-zO4U2A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-07_01,2021-10-07_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0
 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110070072
Cc: linux-s390 <linux-s390@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jeremy Linton <jeremy.linton@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Ioana Ciornei <ioana.ciornei@nxp.com>
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

T24gMDYvMTAvMjAyMSAxNjoyMywgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjEtMTAtMDYg
MTQ6MTAsIEdlcmFsZCBTY2hhZWZlciB3cm90ZToKPj4gT24gRnJpLCAxIE9jdCAyMDIxIDE0OjUy
OjU2ICswMjAwCj4+IEdlcmFsZCBTY2hhZWZlciA8Z2VyYWxkLnNjaGFlZmVyQGxpbnV4LmlibS5j
b20+IHdyb3RlOgo+Pgo+Pj4gT24gVGh1LCAzMCBTZXAgMjAyMSAxNTozNzozMyArMDIwMAo+Pj4g
S2Fyc3RlbiBHcmF1bCA8a2dyYXVsQGxpbnV4LmlibS5jb20+IHdyb3RlOgo+Pj4KPj4+PiBPbiAx
NC8wOS8yMDIxIDE3OjQ1LCBJb2FuYSBDaW9ybmVpIHdyb3RlOgo+Pj4+PiBPbiBXZWQsIFNlcCAw
OCwgMjAyMSBhdCAxMDozMzoyNlBNIC0wNTAwLCBKZXJlbXkgTGludG9uIHdyb3RlOgo+Pj4+Pj4g
K0RQQUEyLCBuZXRkZXYgbWFpbnRhaW5lcnMKPj4+Pj4+IEhpLAo+Pj4+Pj4KPj4+Pj4+IE9uIDUv
MTgvMjEgNzo1NCBBTSwgSGFtemEgTWFoZm9veiB3cm90ZToKPj4+Pj4+PiBTaW5jZSwgb3Zlcmxh
cHBpbmcgbWFwcGluZ3MgYXJlIG5vdCBzdXBwb3J0ZWQgYnkgdGhlIERNQSBBUEkgd2Ugc2hvdWxk
Cj4+Pj4+Pj4gcmVwb3J0IGFuIGVycm9yIGlmIGFjdGl2ZV9jYWNoZWxpbmVfaW5zZXJ0IHJldHVy
bnMgLUVFWElTVC4KPj4+Pj4+Cj4+Pj4+PiBJdCBzZWVtcyB0aGlzIHBhdGNoIGZvdW5kIGEgdmlj
dGltLiBJIHdhcyB0cnlpbmcgdG8gcnVuIGlwZXJmMyBvbiBhCj4+Pj4+PiBob25leWNvbWIgKDUu
MTQuMCwgZmVkb3JhIDM1KSBhbmQgdGhlIGNvbnNvbGUgaXMgYmxhc3RpbmcgdGhpcyBlcnJvciBt
ZXNzYWdlCj4+Pj4+PiBhdCAxMDAlIGNwdS4gU28sIEkgY2hhbmdlZCBpdCB0byBhIFdBUk5fT05D
RSgpIHRvIGdldCB0aGUgY2FsbCB0cmFjZSwgd2hpY2gKPj4+Pj4+IGlzIGF0dGFjaGVkIGJlbG93
Lgo+Pj4+Pj4KPj4+Pj4KPj4+Pj4gVGhlc2UgZnJhZ3MgYXJlIGFsbG9jYXRlZCBieSB0aGUgc3Rh
Y2ssIHRyYW5zZm9ybWVkIGludG8gYSBzY2F0dGVybGlzdAo+Pj4+PiBieSBza2JfdG9fc2d2ZWMg
YW5kIHRoZW4gRE1BIG1hcHBlZCB3aXRoIGRtYV9tYXBfc2cuIEl0IHdhcyBub3QgdGhlCj4+Pj4+
IGRwYWEyLWV0aCdzIGRlY2lzaW9uIHRvIHVzZSB0d28gZnJhZ21lbnRzIGZyb20gdGhlIHNhbWUg
cGFnZSAodGhhdCB3aWxsCj4+Pj4+IGFsc28gZW5kIHVuIGluIHRoZSBzYW1lIGNhY2hlbGluZSkg
aW4gdHdvIGRpZmZlcmVudCBpbi1mbGlnaHQgc2ticy4KPj4+Pj4KPj4+Pj4gSXMgdGhpcyBiZWhh
dmlvciBub3JtYWw/Cj4+Pj4+Cj4+Pj4KPj4+PiBXZSBzZWUgdGhlIHNhbWUgcHJvYmxlbSBoZXJl
IGFuZCBpdCBzdGFydGVkIHdpdGggNS4xNS1yYzIgaW4gb3VyIG5pZ2h0bHkgQ0kgcnVucy4KPj4+
PiBUaGUgQ0kgaGFzIHBhbmljX29uX3dhcm4gZW5hYmxlZCBzbyB3ZSBzZWUgdGhlIHBhbmljIGV2
ZXJ5IGRheSBub3cuCj4+Pgo+Pj4gQWRkaW5nIGEgV0FSTiBmb3IgYSBjYXNlIHRoYXQgYmUgZGV0
ZWN0ZWQgZmFsc2UtcG9zaXRpdmUgc2VlbXMgbm90Cj4+PiBhY2NlcHRhYmxlLCBleGFjdGx5IGZv
ciB0aGlzIHJlYXNvbiAoa2VybmVsIHBhbmljIG9uIHVuYWZmZWN0ZWQKPj4+IHN5c3RlbXMpLgo+
Pj4KPj4+IFNvIEkgZ3Vlc3MgaXQgYm9pbHMgZG93biB0byB0aGUgcXVlc3Rpb24gaWYgdGhlIGJl
aGF2aW9yIHRoYXQgSW9hbmEKPj4+IGRlc2NyaWJlZCBpcyBsZWdpdCBiZWhhdmlvciwgb24gYSBz
eXN0ZW0gdGhhdCBpcyBkbWEgY29oZXJlbnQuIFdlCj4+PiBhcmUgYXBwYXJlbnRseSBoaXR0aW5n
IHRoZSBzYW1lIHNjZW5hcmlvLCBhbHRob3VnaCBpdCBjb3VsZCBub3QgeWV0IGJlCj4+PiByZXBy
b2R1Y2VkIHdpdGggZGVidWcgcHJpbnRrcyBmb3Igc29tZSByZWFzb24uCj4+Pgo+Pj4gSWYgdGhl
IGFuc3dlciBpcyB5ZXMsIHRoYW4gcGxlYXNlIHJlbW92ZSBhdCBsZWFzZSB0aGUgV0FSTiwgc28g
dGhhdAo+Pj4gaXQgd2lsbCBub3QgbWFrZSBzeXN0ZW1zIGNyYXNoIHRoYXQgYmVoYXZlIHZhbGlk
LCBhbmQgaGF2ZQo+Pj4gcGFuaWNfb25fd2FybiBzZXQuIEV2ZW4gYSBub3JtYWwgcHJpbnRrIGZl
ZWxzIHdyb25nIHRvIG1lIGluIHRoYXQKPj4+IGNhc2UsIGl0IHJlYWxseSBzb3VuZHMgcmF0aGVy
IGxpa2UgeW91IHdhbnQgdG8gZml4IC8gYmV0dGVyIHJlZmluZQo+Pj4gdGhlIG92ZXJsYXAgY2hl
Y2ssIGlmIHlvdSB3YW50IHRvIHJlcG9ydCBhbnl0aGluZyBoZXJlLgo+Pgo+PiBEYW4sIENocmlz
dG9waCwgYW55IG9waW5pb24/Cj4+Cj4+IFNvIGZhciBpdCBhbGwgbG9va3MgYSBsb3QgbGlrZSBh
IGZhbHNlIHBvc2l0aXZlLCBzbyBjb3VsZCB5b3UgcGxlYXNlCj4+IHNlZSB0aGF0IHRob3NlIHBh
dGNoZXMgZ2V0IHJldmVydGVkPyBJIGRvIHdvbmRlciBhIGJpdCB3aHkgdGhpcyBpcwo+PiBub3Qg
YW4gaXNzdWUgZm9yIG90aGVycywgd2Ugc3VyZWx5IGNhbm5vdCBiZSB0aGUgb25seSBvbmVzIHJ1
bm5pbmcKPj4gQ0kgd2l0aCBwYW5pY19vbl93YXJuLgo+IAo+IFdoYXQgY29udmluY2VzIHlvdSBp
dCdzIGEgZmFsc2UtcG9zaXRpdmU/IEknbSBoYXJkbHkgZmFtaWxpYXIgd2l0aCBtb3N0IG9mIHRo
YXQgY2FsbHN0YWNrLCBidXQgaXQgYXBwZWFycyB0byBiZSByZWxhdGVkIHRvIG1seDUsIGFuZCBJ
IGtub3cgdGhhdCBleGlzdHMgb24gZXhwYW5zaW9uIGNhcmRzIHdoaWNoIGNvdWxkIGJlIHBsdWdn
ZWQgaW50byBhIHN5c3RlbSB3aXRoIG5vbi1jb2hlcmVudCBQQ0llIHdoZXJlIHBhcnRpYWwgY2Fj
aGVsaW5lIG92ZXJsYXAgKndvdWxkKiBiZSBhIHJlYWwgaXNzdWUuIE9mIGNvdXJzZSBpdCdzIGR1
YmlvdXMgdGhhdCB0aGVyZSBhcmUgbWFueSByZWFsIHVzZS1jYXNlcyBmb3IgcGx1Z2dpbmcgYSBO
SUMgd2l0aCBhIDQtZmlndXJlIHByaWNlIHRhZyBpbnRvIGEgbGl0dGxlIGkuTVg4IG9yIHdoYXRl
dmVyLCBidXQgdGhlIHBvaW50IGlzIHRoYXQgaXQgKnNob3VsZCogc3RpbGwgd29yayBjb3JyZWN0
bHkuCj4gCj4+IFdlIHdvdWxkIG5lZWQgdG8gZGlzYWJsZSBERUJVR19ETUEgaWYgdGhpcyBXQVJO
IHN0YXlzIGluLCB3aGljaAo+PiB3b3VsZCBiZSBhIHNoYW1lLiBPZiBjb3Vyc2UsIGluIHRoZW9y
eSwgdGhpcyBtaWdodCBhbHNvIGluZGljYXRlCj4+IHNvbWUgcmVhbCBidWcsIGJ1dCB0aGVyZSBy
ZWFsbHkgaXMgbm8gc2lnbiBvZiB0aGF0IHNvIGZhci4KPiAKPiBUaGUgd2hvbGUgcG9pbnQgb2Yg
RE1BIGRlYnVnIGlzIHRvIGZsYWcgdXAgdGhpbmdzIHRoYXQgeW91ICpkbyogZ2V0IGF3YXkgd2l0
aCBvbiB0aGUgdmFzdCBtYWpvcml0eSBvZiBzeXN0ZW1zLCBwcmVjaXNlbHkgYmVjYXVzZSBtb3N0
IHRlc3RpbmcgaGFwcGVucyBvbiB0aG9zZSBzeXN0ZW1zIHJhdGhlciB0aGFuIG1vcmUgZXNvdGVy
aWMgZW1iZWRkZWQgc2V0dXBzLiBTYXkgeW91ciBzeXN0ZW0gb25seSB1c2VzIGRtYS1kaXJlY3Qg
YW5kIGEgZHJpdmVyIHN0YXJ0cyB0cmlnZ2VyaW5nIHRoZSB3YXJuaW5nIGZvciBub3QgY2FsbGlu
ZyBkbWFfbWFwcGluZ19lcnJvcigpLCB3b3VsZCB5b3UgYXJndWUgZm9yIHJlbW92aW5nIHRoYXQg
d2FybmluZyBhcyB3ZWxsIHNpbmNlIGRtYV9tYXBfc2luZ2xlKCkgY2FuJ3QgZmFpbCBvbiB5b3Vy
IG1hY2hpbmUgc28gaXQncyAibm90IGEgYnVnIj8KPiAKPj4gSGF2aW5nIG11bHRpcGxlIHNnIGVs
ZW1lbnRzIGluIHRoZSBzYW1lIHBhZ2UgKG9yIGNhY2hlbGluZSkgaXMKPj4gdmFsaWQsIGNvcnJl
Y3Q/IEFuZCB0aGlzIGlzIGFsc28gbm90IGEgZGVjaXNpb24gb2YgdGhlIGRyaXZlcgo+PiBJSVVD
LCBzbyBpZiBpdCB3YXMgYnVnLCBpdCBzaG91bGQgYmUgYWRkcmVzc2VkIGluIGNvbW1vbiBjb2Rl
LAo+PiBjb3JyZWN0Pwo+IAo+IEFjY29yZGluZyB0byB0aGUgc3RyZWFtaW5nIERNQSBBUEkgZG9j
dW1lbnRhdGlvbiwgaXQgaXMgKm5vdCogdmFsaWQ6Cj4gCj4gIi4uIHdhcm5pbmc6Ogo+IAo+IMKg
IE1lbW9yeSBjb2hlcmVuY3kgb3BlcmF0ZXMgYXQgYSBncmFudWxhcml0eSBjYWxsZWQgdGhlIGNh
Y2hlCj4gwqAgbGluZSB3aWR0aC7CoCBJbiBvcmRlciBmb3IgbWVtb3J5IG1hcHBlZCBieSB0aGlz
IEFQSSB0byBvcGVyYXRlCj4gwqAgY29ycmVjdGx5LCB0aGUgbWFwcGVkIHJlZ2lvbiBtdXN0IGJl
Z2luIGV4YWN0bHkgb24gYSBjYWNoZSBsaW5lCj4gwqAgYm91bmRhcnkgYW5kIGVuZCBleGFjdGx5
IG9uIG9uZSAodG8gcHJldmVudCB0d28gc2VwYXJhdGVseSBtYXBwZWQKPiDCoCByZWdpb25zIGZy
b20gc2hhcmluZyBhIHNpbmdsZSBjYWNoZSBsaW5lKS7CoCBTaW5jZSB0aGUgY2FjaGUgbGluZSBz
aXplCj4gwqAgbWF5IG5vdCBiZSBrbm93biBhdCBjb21waWxlIHRpbWUsIHRoZSBBUEkgd2lsbCBu
b3QgZW5mb3JjZSB0aGlzCj4gwqAgcmVxdWlyZW1lbnQuwqAgVGhlcmVmb3JlLCBpdCBpcyByZWNv
bW1lbmRlZCB0aGF0IGRyaXZlciB3cml0ZXJzIHdobwo+IMKgIGRvbid0IHRha2Ugc3BlY2lhbCBj
YXJlIHRvIGRldGVybWluZSB0aGUgY2FjaGUgbGluZSBzaXplIGF0IHJ1biB0aW1lCj4gwqAgb25s
eSBtYXAgdmlydHVhbCByZWdpb25zIHRoYXQgYmVnaW4gYW5kIGVuZCBvbiBwYWdlIGJvdW5kYXJp
ZXMgKHdoaWNoCj4gwqAgYXJlIGd1YXJhbnRlZWQgYWxzbyB0byBiZSBjYWNoZSBsaW5lIGJvdW5k
YXJpZXMpLiIKPiAKPj4+IEJUVywgdGhlcmUgaXMgYWxyZWFkeSBhIFdBUk4gaW4gdGhlIGFkZF9k
bWFfZW50cnkoKSBwYXRoLCByZWxhdGVkCj4+PiB0byBjYWNobGxpbmUgb3ZlcmxhcCBhbmQgLUVF
WElTVDoKPj4+Cj4+PiBhZGRfZG1hX2VudHJ5KCkgLT4gYWN0aXZlX2NhY2hlbGluZV9pbnNlcnQo
KSAtPiAtRUVYSVNUIC0+Cj4+PiBhY3RpdmVfY2FjaGVsaW5lX2luY19vdmVybGFwKCkKPj4+Cj4+
PiBUaGF0IHdpbGwgb25seSB0cmlnZ2VyIHdoZW4gIm92ZXJsYXAgPiBBQ1RJVkVfQ0FDSEVMSU5F
X01BWF9PVkVSTEFQIi4KPj4+IE5vdCBmYW1pbGlhciB3aXRoIHRoYXQgY29kZSwgYnV0IGl0IHNl
ZW1zIHRoYXQgdGhlcmUgYXJlIG5vdyB0d28KPj4+IHdhcm5pbmdzIGZvciBtb3JlIG9yIGxlc3Mg
dGhlIHNhbWUsIGFuZCB0aGUgbmV3IHdhcm5pbmcgaXMgbXVjaCBtb3JlCj4+PiBwcm9uZSB0byBm
YWxzZS1wb3NpdGl2ZXMuCj4+Pgo+Pj4gSG93IGRvIHRoZXNlIDIgd2FybmluZ3MgcmVsYXRlLCBh
cmUgdGhleSBib3RoIHJlYWxseSBuZWNlc3Nhcnk/Cj4+PiBJIHRoaW5rIHRoZSBuZXcgd2Fybmlu
ZyB3YXMgb25seSBpbnRyb2R1Y2VkIGJlY2F1c2Ugb2Ygc29tZSBvbGQKPj4+IFRPRE8gY29tbWVu
dCBpbiBhZGRfZG1hX2VudHJ5KCksIHNlZSBjb21taXQgMmI0YmJjNjIzMWQ3OAo+Pj4gKCJkbWEt
ZGVidWc6IHJlcG9ydCAtRUVYSVNUIGVycm9ycyBpbiBhZGRfZG1hX2VudHJ5IikuCj4gCj4gQUZB
SUNTIHRoZXkgYXJlIGRpZmZlcmVudCB0aGluZ3MuIEkgYmVsaWV2ZSB0aGUgbmV3IHdhcm5pbmcg
aXMgc3VwcG9zZWQgdG8gYmUgZm9yIHRoZSBmdW5kZW1lbnRhbGx5IGluY29ycmVjdCBBUEkgdXNh
Z2UgKGFzIGFib3ZlKSBvZiBtYXBwaW5nIGRpZmZlcmVudCByZWdpb25zIG92ZXJsYXBwaW5nIHdp
dGhpbiB0aGUgc2FtZSBjYWNoZWxpbmUuIFRoZSBleGlzdGluZyBvbmUgaXMgYWJvdXQgZG1hLWRl
YnVnIGxvc2luZyBpbnRlcm5hbCBjb25zaXN0ZW5jeSB3aGVuIHRyYWNraW5nIHRoZSAqc2FtZSog
cmVnaW9uIGJlaW5nIG1hcHBlZCBtdWx0aXBsZSB0aW1lcywgd2hpY2ggaXMgYSBsZWdhbCB0aGlu
ZyB0byBkbyAtIGUuZy4gYnVmZmVyIHNoYXJpbmcgYmV0d2VlbiBkZXZpY2VzIC0gYnV0IGlmIGFu
eW9uZSdzIGRvaW5nIGl0IHRvIGV4Y2VzcyB0aGF0J3MgYWxtb3N0IGNlcnRhaW5seSBhIGJ1ZyAo
aS5lLiB0aGV5IHByb2JhYmx5IGludGVuZGVkIHRvIHVubWFwIGl0IGluIGJldHdlZW4gYnV0IG1p
c3NlZCB0aGF0IG91dCkuCgpUaGFua3MgZm9yIHRoZSBleHBsYW5hdGlvbiBSb2Jpbi4gCgpJbiBv
dXIgY2FzZSBpdHMgcmVhbGx5IHRoYXQgYSBidWZmZXIgaXMgbWFwcGVkIHR3aWNlIGZvciAyIGRp
ZmZlcmVudCBkZXZpY2VzIHdoaWNoIHdlIHVzZSBpbiBTTUMgdG8gcHJvdmlkZSBmYWlsb3ZlciBj
YXBhYmlsaXRpZXMuIFdlIHNlZSB0aGF0IC1FRVhJU1QgaXMgcmV0dXJuZWQgd2hlbiBhIGJ1ZmZl
ciBpcyBtYXBwZWQgZm9yIHRoZSBzZWNvbmQgZGV2aWNlLiBTaW5jZSB0aGVyZSBpcyBhIG1heGlt
dW0gb2YgMiBwYXJhbGxlbCBtYXBwaW5ncyB3ZSBuZXZlciBzZWUgdGhlIHdhcm5pbmcgc2hvd24g
YnkgYWN0aXZlX2NhY2hlbGluZV9pbmNfb3ZlcmxhcCgpIGJlY2F1c2Ugd2UgZG9uJ3QgZXhjZWVk
IEFDVElWRV9DQUNIRUxJTkVfTUFYX09WRVJMQVAuCgpTbyBob3cgdG8gZGVhbCB3aXRoIHRoaXMg
a2luZCBvZiAibGVnYWwgdGhpbmciLCBsb29rcyBsaWtlIHRoZXJlIGlzIG5vIHdheSB0byBzdXBw
cmVzcyB0aGUgbmV3bHkgaW50cm9kdWNlZCBFRVhJU1Qgd2FybmluZyBmb3IgdGhhdCBjYXNlPwoK
CkthcnN0ZW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
aW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
