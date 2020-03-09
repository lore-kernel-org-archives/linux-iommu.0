Return-Path: <SRS0=J+1i=42=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54798C10F27
	for <iommu@archiver.kernel.org>; Mon,  9 Mar 2020 16:01:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15860208C3
	for <iommu@archiver.kernel.org>; Mon,  9 Mar 2020 16:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXUr2th4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15860208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B0ED7250BF;
	Mon,  9 Mar 2020 16:01:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kelT6kTrWBN1; Mon,  9 Mar 2020 16:01:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9F08D20469;
	Mon,  9 Mar 2020 16:01:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94A29C1D74;
	Mon,  9 Mar 2020 16:01:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E588C0177
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 16:01:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EDE74883DA
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 16:01:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B0ORmWd6xkaz for <iommu@lists.linux-foundation.org>;
 Mon,  9 Mar 2020 16:01:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9F279883D6
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 16:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583769704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=94IZgGavdfaUL8Zkv4zTnhDZlaIIttEknSSNkC7OOwE=;
 b=SXUr2th4SZRdJTg8yZ8id7kM3WZ92g11sVE3cwy/T76bIniYLhIxuGr24LNUfy2U68qYSz
 7mL7g4CMB9a9diiOFpFgM5OkVdkJYxnjlmlxotCGQN/vKjA/YdO9fxj1JE81ZPTifRCZPQ
 uO3Xj7/ULjIuz5D/UzceyElo/bmRwSo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-drwzhuOZM1GoXju7FtgRaQ-1; Mon, 09 Mar 2020 12:01:42 -0400
X-MC-Unique: drwzhuOZM1GoXju7FtgRaQ-1
Received: by mail-wr1-f72.google.com with SMTP id z16so5388394wrm.15
 for <iommu@lists.linux-foundation.org>; Mon, 09 Mar 2020 09:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=94IZgGavdfaUL8Zkv4zTnhDZlaIIttEknSSNkC7OOwE=;
 b=AdqY4SIOsPHSWlK7qu5QggcOABfKiDAJre9dkYXnd/U6kFD5OTUQDjCv0I+IbbFibG
 uaGwBFuvy96p2CY2q9lSGV+1xUwgrTkI/43Tv/jItCJpAAoeIBp+7kPuLvMFZTdjntVC
 3inKF/pVttUytLdrD83mkS7o9kXo9sN5CGtIuaboiZRko5uxj8fO35DMx7W5yfE7E+Dn
 e8wVKR/+quYvG9MosKSzdAR0HHDyhZReWjiZdB+wrfEHeXQwrPbN4W7nJdYmo7w9nRp/
 z2PvLfRal+gV+ao3ErU2SGr9oDBwlBjHKpeUNxXte9M0rCo8AXDvfCaB1x4q+yKJeeSH
 /LUg==
X-Gm-Message-State: ANhLgQ2NptO2It9TdjjHBfL2WbO5PybETa4+X+5drmsbW0cAJ+0XyxGg
 OdZc3vZxp/oKJn1oxijdfVw3mqABYKe+jnQVaPm3rFZRfZBxBEin3wyeRkWuB6gLVyMN+JHwYMQ
 mhlZ1I956QnGm7kRo0P+l8FyCi4XhLw==
X-Received: by 2002:adf:b652:: with SMTP id i18mr1477061wre.310.1583769701282; 
 Mon, 09 Mar 2020 09:01:41 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuKSFM5gbK+49BRXb/KYPAnsy9nuu76KdYdpNjpCYH+8wnp6knbVxnwQasfwj2NJ/cw/re+mQ==
X-Received: by 2002:adf:b652:: with SMTP id i18mr1477043wre.310.1583769701040; 
 Mon, 09 Mar 2020 09:01:41 -0700 (PDT)
Received: from x1.localdomain
 (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
 by smtp.gmail.com with ESMTPSA id e1sm50248164wrx.90.2020.03.09.09.01.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2020 09:01:40 -0700 (PDT)
Subject: Re: [PATCH 2/2] iommu/vt-d: dmar_parse_one_rmrr: replace WARN_TAINT
 with pr_warn + add_taint
To: Barret Rhoden <brho@google.com>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
References: <20200309140138.3753-1-hdegoede@redhat.com>
 <20200309140138.3753-3-hdegoede@redhat.com>
 <34b13929-cbea-9906-0169-8f274bd40377@google.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <ef22beeb-fd9c-ead9-496f-e7466edc94f9@redhat.com>
Date: Mon, 9 Mar 2020 17:01:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <34b13929-cbea-9906-0169-8f274bd40377@google.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: iommu@lists.linux-foundation.org, stable@vger.kernel.org
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

SGksCgpPbiAzLzkvMjAgNDo1NyBQTSwgQmFycmV0IFJob2RlbiB3cm90ZToKPiBPbiAzLzkvMjAg
MTA6MDEgQU0sIEhhbnMgZGUgR29lZGUgd3JvdGU6Cj4+IFF1b3RpbmcgZnJvbSB0aGUgY29tbWVu
dCBkZXNjcmliaW5nIHRoZSBXQVJOIGZ1bmN0aW9ucyBpbgo+PiBpbmNsdWRlL2FzbS1nZW5lcmlj
L2J1Zy5oOgo+Pgo+PiDCoCAqIFdBUk4oKSwgV0FSTl9PTigpLCBXQVJOX09OX09OQ0UsIGFuZCBz
byBvbiBjYW4gYmUgdXNlZCB0byByZXBvcnQKPj4gwqAgKiBzaWduaWZpY2FudCBrZXJuZWwgaXNz
dWVzIHRoYXQgbmVlZCBwcm9tcHQgYXR0ZW50aW9uIGlmIHRoZXkgc2hvdWxkIGV2ZXIKPj4gwqAg
KiBhcHBlYXIgYXQgcnVudGltZS4KPj4gwqAgKgo+PiDCoCAqIERvIG5vdCB1c2UgdGhlc2UgbWFj
cm9zIHdoZW4gY2hlY2tpbmcgZm9yIGludmFsaWQgZXh0ZXJuYWwgaW5wdXRzCj4+Cj4+IFRoZSAo
YnVnZ3kpIGZpcm13YXJlIHRhYmxlcyB3aGljaCB0aGUgZG1hciBjb2RlIHdhcyBjYWxsaW5nIFdB
Uk5fVEFJTlQKPj4gZm9yIHJlYWxseSBhcmUgaW52YWxpZCBleHRlcm5hbCBpbnB1dHMuIFRoZXkg
YXJlIG5vdCB1bmRlciB0aGUga2VybmVsJ3MKPj4gY29udHJvbCBhbmQgdGhlIGlzc3VlcyBpbiB0
aGVtIGNhbm5vdCBiZSBmaXhlZCBieSBhIGtlcm5lbCB1cGRhdGUuCj4gCj4gVGhpcyBwYXRjaCBz
b3VuZHMgZ29vZCB0byBtZS4KCkNhbiB3ZSBoYXZlIHlvdXIgQWNrZWQtYnkgdGhlbiA/Cgo+IEdp
dmVuIHRoZSBydWxlcyB3aXRoIFdBUk4gYW5kIGV4dGVybmFsIGlucHV0cywgaXQgc291bmRzIGxp
a2UgKmFsbCogdXNlcyBvZiBXQVJOX1RBSU5UIHdpdGggVEFJTlRfRklSTVdBUkVfV09SS0FST1VO
RCBhcmUgYmFkOiBXQVJOcyB0aGF0IGFyZSBsaWtlbHkgYmFzZWQgb24gaW52YWxpZCBleHRlcm5h
bCBpbnB1dC7CoCBQcmVzdW1hYmx5IHdlJ3JlIHdvcmtpbmcgYXJvdW5kIEZXIGJ1Z3MuCgpSaWdo
dCwgYXMgSSBtZW50aW9uZWQgaW4gdGhlIGNvdmVyIGxldHRlciBJJ20gd29ya2luZyBvbiBhIGZv
bGxvdy11cApzZXJpZXMgZml4aW5nIHRoZSBvdGhlciBjYXNlcy4gSSB3YW50ZWQgdG8gZ2V0IHRo
ZXNlIDIgb3V0IHRoZXJlIChhbmQKaG9wZWZ1bGx5IGludG8gNS42LXJjIyBzb29uKSBhcyB0aGV5
IGFyZSBjYXVzaW5nIGFwcm94IDEtMiBuZXcKYnVnLXJlcG9ydHMgdG8gYmUgZmlsZWQgZXZlcnkg
ZGF5IGZvciBqdXN0IEZlZG9yYS4KCj4gV2hpbGUgd2UncmUgb24gdGhlIHN1YmplY3QsIGlzIFdB
Uk5fVEFJTlQoKSBldmVyIHdvcnRoIHRoZSBiYWNrdHJhY2UgKyBidWcgcmVwb3J0P8KgIEdpdmVu
IHRoZSBjcml0ZXJpYSBpcyAicHJvbXB0IGF0dGVudGlvbiIsIGl0IHNob3VsZCBiZSBzb21ldGhp
bmcgbGlrZSAibmljZSB0byBrbm93IGFib3V0IHdoZW4gZGVidWdnaW5nLiIKCkkgaGF2ZSBub3Qg
bG9va2VkIGF0IFdBUk5fVEFJTlQgdXNhZ2VzIG90aGVyIHRoZW4gdGhvc2Ugd2l0aCB0aGUKVEFJ
TlRfRklSTVdBUkVfV09SS0FST1VORCBmbGFnOyBhbmQgYXMgbWVudGlvbmVkIEkgZG8gcGxhbiB0
byBmaXgKdGhvc2UuIEZlZWwgZnJlZSB0byB0YWtlIGEgbG9vayBhdCBhbnkgb3RoZXIgY2FsbGVy
cyA6KQoKUmVnYXJkcywKCkhhbnMKCgoKPj4gU28gbG9nZ2luZyBhIGJhY2t0cmFjZSwgd2hpY2gg
aW52aXRlcyBidWcgcmVwb3J0cyB0byBiZSBmaWxlZCBhYm91dCB0aGlzLAo+PiBpcyBub3QgaGVs
cGZ1bC4KPj4KPj4gU29tZSBkaXN0cm9zLCBlLmcuIEZlZG9yYSwgaGF2ZSB0b29scyB3YXRjaGlu
ZyBmb3IgdGhlIGtlcm5lbCBiYWNrdHJhY2VzCj4+IGxvZ2dlZCBieSB0aGUgV0FSTiBtYWNyb3Mg
YW5kIG9mZmVyIHRoZSB1c2VyIGFuIG9wdGlvbiB0byBmaWxlIGEgYnVnIGZvcgo+PiB0aGlzIHdo
ZW4gdGhlc2UgYXJlIGVuY291bnRlcmVkLiBUaGUgV0FSTl9UQUlOVCBpbiBkbWFyX3BhcnNlX29u
ZV9ybXJyCj4+ICsgYW5vdGhlciBpb21tdSBXQVJOX1RBSU5ULCBhZGRyZXNzZWQgaW4gYW5vdGhl
ciBwYXRjaCwgaGF2ZSBsZWFkIHRvIG92ZXIKPj4gYSAxMDAgYnVncyBiZWluZyBmaWxlZCB0aGlz
IHdheS4KPj4KPj4gVGhpcyBjb21taXQgcmVwbGFjZXMgdGhlIFdBUk5fVEFJTlQoIi4uLiIpIGNh
bGwsIHdpdGggYQo+PiBwcl93YXJuKEZXX0JVRyAiLi4uIikgKyBhZGRfdGFpbnQoVEFJTlRfRklS
TVdBUkVfV09SS0FST1VORCwgLi4uKSBjYWxsCj4+IGF2b2lkaW5nIHRoZSBiYWNrdHJhY2UgYW5k
IHRodXMgYWxzbyBhdm9pZGluZyBidWctcmVwb3J0cyBiZWluZyBmaWxlZAo+PiBhYm91dCB0aGlz
IGFnYWluc3QgdGhlIGtlcm5lbC4KPj4KPj4gQnVnTGluazogaHR0cHM6Ly9idWd6aWxsYS5yZWRo
YXQuY29tL3Nob3dfYnVnLmNnaT9pZD0xODA4ODc0Cj4+IEZpeGVzOiBmNWE2OGJiMDc1MmUgKCJp
b21tdS92dC1kOiBNYXJrIGZpcm13YXJlIHRhaW50ZWQgaWYgUk1SUiBmYWlscyBzYW5pdHkgY2hl
Y2siKQo+PiBDYzogQmFycmV0IFJob2RlbiA8YnJob0Bnb29nbGUuY29tPgo+PiBDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZwo+PiBTaWduZWQtb2ZmLWJ5OiBIYW5zIGRlIEdvZWRlIDxoZGVnb2Vk
ZUByZWRoYXQuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jIHwg
NiArKysrLS0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYyBiL2Ry
aXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYwo+PiBpbmRleCA2ZmE2ZGUyYjZhZDUuLjM4NTdhNWNk
MWE3NSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jCj4+ICsrKyBi
L2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYwo+PiBAQCAtNDQ2MCwxNCArNDQ2MCwxNiBAQCBp
bnQgX19pbml0IGRtYXJfcGFyc2Vfb25lX3JtcnIoc3RydWN0IGFjcGlfZG1hcl9oZWFkZXIgKmhl
YWRlciwgdm9pZCAqYXJnKQo+PiDCoMKgwqDCoMKgIHN0cnVjdCBkbWFyX3JtcnJfdW5pdCAqcm1y
cnU7Cj4+IMKgwqDCoMKgwqAgcm1yciA9IChzdHJ1Y3QgYWNwaV9kbWFyX3Jlc2VydmVkX21lbW9y
eSAqKWhlYWRlcjsKPj4gLcKgwqDCoCBpZiAocm1ycl9zYW5pdHlfY2hlY2socm1ycikpCj4+IC3C
oMKgwqDCoMKgwqDCoCBXQVJOX1RBSU5UKDEsIFRBSU5UX0ZJUk1XQVJFX1dPUktBUk9VTkQsCj4+
ICvCoMKgwqAgaWYgKHJtcnJfc2FuaXR5X2NoZWNrKHJtcnIpKSB7Cj4+ICvCoMKgwqDCoMKgwqDC
oCBwcl93YXJuKEZXX0JVRwo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiWW91
ciBCSU9TIGlzIGJyb2tlbjsgYmFkIFJNUlIgWyUjMDE4THgtJSMwMThMeF1cbiIKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIkJJT1MgdmVuZG9yOiAlczsgVmVyOiAlczsgUHJv
ZHVjdCBWZXJzaW9uOiAlc1xuIiwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cm1yci0+YmFzZV9hZGRyZXNzLCBybXJyLT5lbmRfYWRkcmVzcywKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZG1pX2dldF9zeXN0ZW1faW5mbyhETUlfQklPU19WRU5ET1IpLAo+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkbWlfZ2V0X3N5c3RlbV9pbmZvKERN
SV9CSU9TX1ZFUlNJT04pLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkbWlf
Z2V0X3N5c3RlbV9pbmZvKERNSV9QUk9EVUNUX1ZFUlNJT04pKTsKPj4gK8KgwqDCoMKgwqDCoMKg
IGFkZF90YWludChUQUlOVF9GSVJNV0FSRV9XT1JLQVJPVU5ELCBMT0NLREVQX1NUSUxMX09LKTsK
Pj4gK8KgwqDCoCB9Cj4+IMKgwqDCoMKgwqAgcm1ycnUgPSBremFsbG9jKHNpemVvZigqcm1ycnUp
LCBHRlBfS0VSTkVMKTsKPj4gwqDCoMKgwqDCoCBpZiAoIXJtcnJ1KQo+Pgo+IAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
