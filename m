Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C313AC433EF
	for <iommu@archiver.kernel.org>; Tue, 19 Apr 2022 01:03:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14F6B842CC;
	Tue, 19 Apr 2022 01:03:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UdDApRUyZXuY; Tue, 19 Apr 2022 01:03:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C6D60842B1;
	Tue, 19 Apr 2022 01:03:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8218DC0033;
	Tue, 19 Apr 2022 01:03:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1852FC002C
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 01:03:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EFCB06126A
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 01:03:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=foxmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TkS-2BW1SrCY for <iommu@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 01:03:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com
 [203.205.221.221])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BA8FA61266
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 01:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1650330179;
 bh=yQw6ERdnn3s8Fdav1zgTS27N91rjx8DazpHXI6e3k9g=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To;
 b=wX9u6xnU+1iU+RQWEeun9aJ9e0cu4jgZXT5HiunHslNoszXVkxD5tspBoz/oGw8JJ
 U7JkwdLi1Y7TtDD7V4xC27RSkWmWyhEEhlQNSvrME0oKhjWH6OqB3h/Pu8I83MAVVl
 8T0bqwywbYMlJ4UIkhTL7TbaGkbI1i5bv/gr1R8I=
Received: from [IPv6:240e:362:460:400:41fe:9861:6ad0:79fe]
 ([240e:362:460:400:41fe:9861:6ad0:79fe])
 by newxmesmtplogicsvrsza9.qq.com (NewEsmtp) with SMTP
 id B6A6E5A; Tue, 19 Apr 2022 09:02:54 +0800
X-QQ-mid: xmsmtpt1650330174tqi25minl
Message-ID: <tencent_2EB84D1A69750D821D1A8324112BDBCE6A08@qq.com>
X-QQ-XMAILINFO: Nt+cTZuZCMyik92w9EY9stqsGSh/CDo9X0G+qzdUtdySpM/m5C070YTOea1dBJ
 +2Bs3QwRxH60eS6D7F55+CEt7KqH6xFEoI+us5qSfF6MTwwKKMLoDplJJxWPzhxL5PtsjJYIcABA
 tyS4ORs0Bh/+sQe/P8QvmDPxqZBvsjzrpGRdERBJRB16184gIJixl7GwBBe5xeXNwLssJf6oWeU1
 pzeozIytl6psXz6SqUVdsbEGdwzR/2xDAa+cVTTrwZlXfM+VLY5KtTHfgqSsvqGtlV/81EjzdeTi
 RtVsm15vD6fgfbB+g2u5KRIuQXPJH7YuyeWSXdRrZuWk/jUkY47XnjBxy71UjGppv+vWxByeCXcp
 C6ikojnvEotPwJBE2N8ZGP70yEOzEzhUVgvP4RbrQO4cy9ttzMrO4CmIhUwoRC2gvo81J4J8yMu/
 08KS4CfdPd3plqPxrap8bvkZUo8P7wHwiuoHlVhqD5efu8yn37EH28CDuK6OfpnawbgpHeXGIsjy
 QrVPvheS0keXO6ngqUT3xL2r/351F/FKZ1ff1PC1IEzq6MCajzFU6n9V3pBfiw1KGywAvJMmlvWd
 8pV6RywoXRqfVZY4RloXNrf3Li6qQ0+UV65yxTC0X6Fmm96V25Je7wpSn7EJFiaIzPbIOgBCcMIA
 QzQFxTQuajKPH2t7ESXO/b0K4WrwBJU4M8MFdp7ZIXbdTaviwruDwb49si0xunA++m7pHLOYIR/F
 O9OmQ3Q3Yn8YDe62mwY51wrbiCDgi4doT+rUPIc7QJ5fRoKAhSoUQ5ezsp8/5xLKk7rLGQG9WRNi
 662Yx4nqx01lztk+5WARBDC8GGUqSjRrpekBEj01iay773/sptva6nTwTwhAzA82irt2ELAf0Usw
 RB2kCusSp/lydO6n2m3C6XwV0pBGSaCeyLpGtzi1cGqiQ/BlFIKVcYNvV0yeEI1KesL7VanIT6jN
 SctJrB4XE=
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com>
 <99bcb9f5-4776-9c40-a776-cdecfa9e1010@foxmail.com>
 <YllN/OmjpYdT1tO9@otcwcpicx3.sc.intel.com>
 <tencent_CD35B6A6FBB48186B38EF641F088BAED1407@qq.com>
 <20220415140002.7c12b0d2@jacob-builder>
 <tencent_8EC09A26D25C1A263AE207952230B789D409@qq.com>
 <20220418111456.2f1a1285@jacob-builder>
From: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <16001fe9-34b1-e3aa-9aa6-ebcc9793c966@foxmail.com>
Date: Tue, 19 Apr 2022 09:02:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220418111456.2f1a1285@jacob-builder>
Content-Language: en-US
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 jean-philippe <jean-philippe@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

CgpPbiAyMDIyLzQvMTkg5LiK5Y2IMjoxNCwgSmFjb2IgUGFuIHdyb3RlOgo+IEhpIHpoYW5nZmVp
Lmdhb0Bmb3htYWlsLmNvbSwKPgo+IE9uIFNhdCwgMTYgQXByIDIwMjIgMDk6NDM6MDcgKzA4MDAs
ICJ6aGFuZ2ZlaS5nYW9AZm94bWFpbC5jb20iCj4gPHpoYW5nZmVpLmdhb0Bmb3htYWlsLmNvbT4g
d3JvdGU6Cj4KPj4gT24gMjAyMi80LzE2IOS4iuWNiDU6MDAsIEphY29iIFBhbiB3cm90ZToKPj4+
IEhpIHpoYW5nZmVpLmdhb0Bmb3htYWlsLmNvbSwKPj4+Cj4+PiBPbiBGcmksIDE1IEFwciAyMDIy
IDE5OjUyOjAzICswODAwLCAiemhhbmdmZWkuZ2FvQGZveG1haWwuY29tIgo+Pj4gPHpoYW5nZmVp
Lmdhb0Bmb3htYWlsLmNvbT4gd3JvdGU6Cj4+PiAgIAo+Pj4+Pj4+IEEgUEFTSUQgbWlnaHQgYmUg
c3RpbGwgdXNlZCBldmVuIHRob3VnaCBpdCBpcyBmcmVlZCBvbiBtbSBleGl0Lgo+Pj4+Pj4+Cj4+
Pj4+Pj4gcHJvY2VzcyBBOgo+Pj4+Pj4+IAlzdmFfYmluZCgpOwo+Pj4+Pj4+IAlpb2FzaWRfYWxs
b2MoKSA9IE47IC8vIEdldCBQQVNJRCBOIGZvciB0aGUgbW0KPj4+Pj4+PiAJZm9yaygpOiAvLyBz
cGF3biBwcm9jZXNzIEIKPj4+Pj4+PiAJZXhpdCgpOwo+Pj4+Pj4+IAlpb2FzaWRfZnJlZShOKTsK
Pj4+Pj4+Pgo+Pj4+Pj4+IHByb2Nlc3MgQjoKPj4+Pj4+PiAJZGV2aWNlIHVzZXMgUEFTSUQgTiAt
PiBmYWlsdXJlCj4+Pj4+Pj4gCXN2YV91bmJpbmQoKTsKPj4+Pj4+Pgo+Pj4+Pj4+IERhdmUgSGFu
c2VuIHN1Z2dlc3RzIHRvIHRha2UgYSByZWZjb3VudCBvbiB0aGUgbW0gd2hlbmV2ZXIgYmluZGlu
Zwo+Pj4+Pj4+IHRoZSBQQVNJRCB0byBhIGRldmljZSBhbmQgZHJvcCB0aGUgcmVmY291bnQgb24g
dW5iaW5kaW5nLiBUaGUgbW0KPj4+Pj4+PiB3b24ndCBiZSBkcm9wcGVkIGlmIHRoZSBQQVNJRCBp
cyBzdGlsbCBib3VuZCB0byBpdC4KPj4+Pj4+Pgo+Pj4+Pj4+IEZpeGVzOiA3MDFmYWM0MDM4NGYg
KCJpb21tdS9zdmE6IEFzc2lnbiBhIFBBU0lEIHRvIG1tIG9uIFBBU0lECj4+Pj4+Pj4gYWxsb2Nh
dGlvbiBhbmQgZnJlZSBpdCBvbiBtbSBleGl0IikKPj4+Pj4+PiAgIAo+Pj4gSXMgcHJvY2VzcyBB
J3MgbW0gaW50ZW5kZWQgdG8gYmUgdXNlZCBieSBwcm9jZXNzIEI/IE9yIHlvdSByZWFsbHkgc2hv
dWxkCj4+PiB1c2UgUEFTSUQgTiBvbiBwcm9jZXNzIEIncyBtbT8gSWYgdGhlIGxhdHRlciwgaXQg
bWF5IHdvcmsgZm9yIGEgd2hpbGUKPj4+IHVudGlsIEIgY2hhbmdlcyBtYXBwaW5nLgo+Pj4KPj4+
IEl0IHNlZW1zIHlvdSBhcmUganVzdCBleHRlbmRpbmcgdGhlIGxpZmUgb2YgYSBkZWZ1bmN0IG1t
Pwo+PiAgIEZyb20gbmdpbnggY29kZSwgdGhlIG1hc3RlciBwcm9jZXNzIGluaXQgcmVzb3VyY2Vz
LCB0aGVuIGZvcmsgZGFlbW9uCj4+IHByb2Nlc3MgdG8gdGFrZSBvdmVyLAo+PiB0aGVuIG1hc3Rl
ciBwcm9jZXNzIGV4aXQgYnkgaXRzZWxmLgo+Pgo+PiBzcmMvY29yZS9uZ2lueC5jCj4+IG1haW4K
Pj4gbmd4X3NzbF9pbml0KGxvZyk7wqDCoMKgIC0+IG9wZW5zc2wgZW5naW5lIC0+IGJpbmRfZm4g
LT4gc3ZhX2JpbmQoKQo+PiBuZ3hfZGFlbW9uKGN5Y2xlLT5sb2cpCj4+Cj4+IHNyYy9vcy91bml4
L25neF9kYWVtb24uYwo+PiBuZ3hfZGFlbW9uKG5neF9sb2dfdCAqbG9nKQo+PiB7Cj4+ICAgwqDC
oMKgwqAgaW50wqAgZmQ7Cj4+Cj4+ICAgwqDCoMKgwqAgc3dpdGNoIChmb3JrKCkpIHsKPj4gICDC
oMKgwqDCoCBjYXNlIC0xOgo+PiAgIMKgwqDCoMKgwqDCoMKgwqAgbmd4X2xvZ19lcnJvcihOR1hf
TE9HX0VNRVJHLCBsb2csIG5neF9lcnJubywgImZvcmsoKSBmYWlsZWQiKTsKPj4gICDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybiBOR1hfRVJST1I7Cj4+Cj4+ICAgwqDCoMKgwqAgY2FzZSAwOgo+PiAg
IMKgwqDCoMKgwqDCoMKgIC8vIHRoZSBmb3JrIGRhZW1vbiBwcm9jZXNzCj4+ICAgwqDCoMKgwqDC
oMKgwqDCoCBicmVhazsKPj4KPiBEb2VzIHRoaXMgY2hpbGQgcHJvY2VzcyBjYWxsIHN2YV9iaW5k
KCkgYWdhaW4gdG8gZ2V0IGFub3RoZXIgUEFTSUQ/IE9yIGl0Cj4gd2lsbCBrZWVwIHVzaW5nIHRo
ZSBwYXJlbnQncyBQQVNJRCBmb3IgRE1BPwpUaGUgbWFzdGVyIHByb2Nlc3MgY2FsbCBzdmFfYmlu
ZCAoUEFTSUQgQSksIGZvcmsgZGFlbW9uIHByb2Nlc3MsIHRoZW4gZXhpdC4KClRoZSBkYWVtb24g
cHJvY2VzcyBkb2VzIG5vdCBjYWxsIHN2YV9iaW5kIGFnYWluLCBvbmx5IGZvciBtYW5hZ2luZyAK
d29ya2VyIHByb2Nlc3Nlcy4KClRoZSB3b3JrZXIgcHJvY2VzcyB3aWxsIGNhbGwgc3ZhX2JpbmQg
Zm9yIG5ldyBQQVNJRCAoQiksIGZvciByZWFsIAp0cmFuc2FjdGlvbi4KCgpUaGUgd29ya2VyIHBy
b2Nlc3Mgd2lsbCBmcmVlIHRoZSBQQVNJRCAoQikgd2hlbiB3b3JrZXIgcHJvY2VzcyBleGl0IGxp
a2UgCm5naW54IHF1aXQuCgpuZ2lueCAtcyBxdWl0IGRvZXMgbm90IGZyZWUgUEFTSUQgQSB2aWEg
Y2FsbGJhY2ssIHdoaWNoIG1heSBzaG91bGQgYmUgCmZyZWVkIGJ5IHNpZ25hbCBoYW5kbGVyIGlu
IGVuZ2luZSBpdHNlbGYsIHN0aWxsIGluIGNoZWNrLgoKVGhhbmtzCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
