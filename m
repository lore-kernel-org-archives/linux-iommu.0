Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBC1C433EF
	for <iommu@archiver.kernel.org>; Fri, 15 Apr 2022 10:17:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 91224419C4;
	Fri, 15 Apr 2022 10:17:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "Message-ID"
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 45Ow77Bc20ay; Fri, 15 Apr 2022 10:17:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A49B9419BC;
	Fri, 15 Apr 2022 10:17:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85713C002F;
	Fri, 15 Apr 2022 10:17:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71748C002C
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 10:17:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4953161099
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 10:17:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "Message-ID"
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=foxmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id le_vK4h2ExAF for <iommu@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 10:17:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com
 [203.205.221.242])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 16DEC60C14
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 10:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1650017862;
 bh=fQnh3qt0+gOsXVYOOm5JWym51U5VAolvTvqPtnE6nRs=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To;
 b=HqSnW3fbvN+cJROcc5CgNz+92OdNjiQWybNmu1P20GoDLIruCzLQnuFrr7duYu1Am
 YFh8VvSQolVK8crp4GcvFByDxjBpPozjV78a9Sa+9P4N5arN8gzHfNGAgooVNv05cL
 Xd6Q70Ol1KpyMjwJHTtMvm6G9ihl55wmIaORoL3M=
Received: from [IPv6:240e:362:47d:9500:6527:51dc:8ce2:179e]
 ([240e:362:47d:9500:6527:51dc:8ce2:179e])
 by newxmesmtplogicsvrszc8.qq.com (NewEsmtp) with SMTP
 id 3899F435; Fri, 15 Apr 2022 18:14:09 +0800
X-QQ-mid: xmsmtpt1650017649tealrp6ne
Message-ID: <tencent_960E0647C06CE7A9893545A5AD345876240A@qq.com>
X-QQ-XMAILINFO: MtZ6QPwsmM9XyOP1qhF3KgB2+kucOc1gMvPT135LHmRMtvFVUEDI0iGVuGhr8B
 EUR0HZZLG/j1xSWGe8rgNEYTidz0gQfjU0eTGuXhLr1FV/BrSyPrTbBdFEy2BsOIkqMl7lZqmord
 CSddmTakP+D+SHRWHRKXrHagq3kjb5LshM+vin3aJI8ZvjKUnrxDowozpflIEscgnMMNKWZH1sWR
 OGGDcMf57go750uLQh7s5+pl80BxRxekupn5AHjA4K7dfgyMrC9w3HmrK24b1D/k/Wz3Ec2UKUq7
 smzRzWf7erc8OLYiDHKZsncN54K6MNt9vN2ziCs6CHcZgqGkyQ5pVmB1E/N2utEMAFYuDQpTSp/8
 lI9/Owjq5HAfEAUyQScshW2pNISmSHeXAsq8Tiz5NP/k+Qv9I6Kh9Bw0uXWH62CL1cphkdes1gRu
 wsQzEvWobejAaNNpN30PW+Pz0DWLW/HX/3PZ/KqPD4gCJ1rwB4hSLtdVQe6l0F3VMKccumkxsB/3
 YuoPLDLUAsszen32Vk8KmxCrRFZLZ5gsfVnT2OwvPTyBFnY2uSvc1bYYxurpP3pTNoGN+jUQz776
 xF3CD33/5Y5dgHCgiVHDZ9TQVOyhE2zjpIpZfBOFBmMpwbACWbipR2I/n+pKUi8f0fRT33Y7juHW
 lVk0swTw/ppgMO3vy/seND01pVhTyNr8MhE16bk8zKoFX32nMrG/3xtse2y5YRArFn2T9r6txUBJ
 Kops9Agrp1S+ftpHh0Tgp56J/igyXM/tFap+UXVuf+NM4usJqkHDhfoYMTcp7lTe6r4ec6O25Klc
 lmFTlYXtkhYkW+flrYmwjYme6gnuCg81piGiohoDdRIpL47H0MGR4XzPuy1AyIXHyqrGOZyjqxQK
 KoNFSy9JHLR5F3UhoG1GggyiR+j5UrH76BmWhG3vnbslonS31Toxsxero1Y+eUkw/x8fvF0WqtNn
 5dZt5eELzJOarkZtavqIXTERoaTgoDJtCtEVjYwzc=
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
To: Fenghua Yu <fenghua.yu@intel.com>
References: <tencent_F6830A1196DB4C6A904D7C691F0D961D1108@qq.com>
 <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
 <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com>
From: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Message-ID: <99bcb9f5-4776-9c40-a776-cdecfa9e1010@foxmail.com>
Date: Fri, 15 Apr 2022 18:14:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YllADL6uMoLllzQo@fyu1.sc.intel.com>
Content-Language: en-US
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, jean-philippe <jean-philippe@linaro.org>,
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

CgpPbiAyMDIyLzQvMTUg5LiL5Y2INTo1MSwgRmVuZ2h1YSBZdSB3cm90ZToKPiBPbiBUaHUsIEFw
ciAxNCwgMjAyMiBhdCAwNjowODowOVBNICswODAwLCB6aGFuZ2ZlaS5nYW9AZm94bWFpbC5jb20g
d3JvdGU6Cj4+IE9uIDIwMjIvNC8xMiDkuIvljYgxMTozNSwgemhhbmdmZWkuZ2FvQGZveG1haWwu
Y29tIHdyb3RlOgo+Pj4gSGksIEZlbmdodWEKPj4+Cj4+PiBPbiAyMDIyLzQvMTIg5LiL5Y2IOTo0
MSwgRmVuZ2h1YSBZdSB3cm90ZToKPj4+PiBIaSwgWmhhbmdmZWksCj4+Pj4KPj4+PiBPbiBUdWUs
IEFwciAxMiwgMjAyMiBhdCAwMzowNDowOVBNICswODAwLCB6aGFuZ2ZlaS5nYW9AZm94bWFpbC5j
b20KPj4+PiB3cm90ZToKPj4+Pj4gT24gMjAyMi80LzExIOS4i+WNiDEwOjUyLCBEYXZlIEhhbnNl
biB3cm90ZToKPj4+Pj4+IE9uIDQvMTEvMjIgMDc6NDQsIHpoYW5nZmVpLmdhb0Bmb3htYWlsLmNv
bSB3cm90ZToKPj4+Pj4+PiBPbiAyMDIyLzQvMTEg5LiL5Y2IMTA6MzYsIERhdmUgSGFuc2VuIHdy
b3RlOgo+Pj4+Pj4+PiBPbiA0LzExLzIyIDA3OjIwLCB6aGFuZ2ZlaS5nYW9AZm94bWFpbC5jb20g
d3JvdGU6Cj4+PiBBZ3JlZSB3aXRoIERhdmUsIEkgdGhpbmsgdXNlciBzcGFjZSBzaG91bGQgbm90
IGJlIGJyb2tlbi4KPj4+Cj4+PiBUaGFua3MKPj4gQW55IHBsYW4gYWJvdXQgdGhpcyByZWdyZXNz
aW9uPwo+PiBDdXJyZW50bHkgSSBuZWVkIHRoaXMgcGF0Y2ggdG8gd29ya2Fyb3VuZCB0aGUgaXNz
dWUuCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0t
c21tdS12My1zdmEuYwo+PiBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11
LXYzLXN2YS5jCj4+IGluZGV4IDIyZGRkMDViYmRjZC4uMmQ3NGFjNTNkMTFjIDEwMDY0NAo+PiAt
LS0gYS9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My1zdmEuYwo+PiAr
KysgYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My1zdmEuYwo+PiBA
QCAtNCw2ICs0LDcgQEAKPj4gIMKgICovCj4+Cj4+ICDCoCNpbmNsdWRlIDxsaW51eC9tbS5oPgo+
PiArI2luY2x1ZGUgPGxpbnV4L3NjaGVkL21tLmg+Cj4+ICDCoCNpbmNsdWRlIDxsaW51eC9tbXVf
Y29udGV4dC5oPgo+PiAgwqAjaW5jbHVkZSA8bGludXgvbW11X25vdGlmaWVyLmg+Cj4+ICDCoCNp
bmNsdWRlIDxsaW51eC9zbGFiLmg+Cj4+IEBAIC0zNjMsNiArMzY0LDcgQEAgYXJtX3NtbXVfc3Zh
X2JpbmQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbW1fc3RydWN0Cj4+ICptbSwgdm9pZCAq
ZHJ2ZGF0YSkKPj4KPj4gIMKgwqDCoMKgwqDCoMKgIG11dGV4X2xvY2soJnN2YV9sb2NrKTsKPj4g
IMKgwqDCoMKgwqDCoMKgIGhhbmRsZSA9IF9fYXJtX3NtbXVfc3ZhX2JpbmQoZGV2LCBtbSk7Cj4+
ICvCoMKgwqDCoMKgwqAgbW1nZXQobW0pOwo+PiAgwqDCoMKgwqDCoMKgwqAgbXV0ZXhfdW5sb2Nr
KCZzdmFfbG9jayk7Cj4+ICDCoMKgwqDCoMKgwqDCoCByZXR1cm4gaGFuZGxlOwo+PiAgwqB9Cj4+
IEBAIC0zNzcsNiArMzc5LDcgQEAgdm9pZCBhcm1fc21tdV9zdmFfdW5iaW5kKHN0cnVjdCBpb21t
dV9zdmEgKmhhbmRsZSkKPj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhcm1fc21t
dV9tbXVfbm90aWZpZXJfcHV0KGJvbmQtPnNtbXVfbW4pOwo+PiAgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGtmcmVlKGJvbmQpOwo+PiAgwqDCoMKgwqDCoMKgwqAgfQo+PiArwqDCoMKg
wqDCoMKgIG1tcHV0KGJvbmQtPm1tKTsKPj4gIMKgwqDCoMKgwqDCoMKgIG11dGV4X3VubG9jaygm
c3ZhX2xvY2spOwo+PiAgwqB9Cj4gQ291bGQgeW91IHBsZWFzZSByZXZpZXcgYW5kL29yIHRlc3Qg
dGhpcyBwYXRjaD8gSXQncyBzdXBwb3NlZCB0byBmaXgKPiB0aGUgUEFTSUQgaXNzdWUgb24gYm90
aCBBUk0gYW5kIFg4Ni4KPgo+ICBGcm9tIGE2NDQ0ZTFlNWJkODA3NmY1ZTVjNWU5NTBkMzE5MmRl
MzI3ZjBjOWMgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCj4gRnJvbTogRmVuZ2h1YSBZdSA8ZmVu
Z2h1YS55dUBpbnRlbC5jb20+Cj4gRGF0ZTogRnJpLCAxNSBBcHIgMjAyMiAwMDo1MTozMyAtMDcw
MAo+IFN1YmplY3Q6IFtSRkMgUEFUQ0hdIGlvbW11L3N2YTogRml4IFBBU0lEIHVzZS1hZnRlci1m
cmVlIGlzc3VlCj4KPiBBIFBBU0lEIG1pZ2h0IGJlIHN0aWxsIHVzZWQgZXZlbiB0aG91Z2ggaXQg
aXMgZnJlZWQgb24gbW0gZXhpdC4KPgo+IHByb2Nlc3MgQToKPiAJc3ZhX2JpbmQoKTsKPiAJaW9h
c2lkX2FsbG9jKCkgPSBOOyAvLyBHZXQgUEFTSUQgTiBmb3IgdGhlIG1tCj4gCWZvcmsoKTogLy8g
c3Bhd24gcHJvY2VzcyBCCj4gCWV4aXQoKTsKPiAJaW9hc2lkX2ZyZWUoTik7Cj4KPiBwcm9jZXNz
IEI6Cj4gCWRldmljZSB1c2VzIFBBU0lEIE4gLT4gZmFpbHVyZQo+IAlzdmFfdW5iaW5kKCk7Cj4K
PiBEYXZlIEhhbnNlbiBzdWdnZXN0cyB0byB0YWtlIGEgcmVmY291bnQgb24gdGhlIG1tIHdoZW5l
dmVyIGJpbmRpbmcgdGhlCj4gUEFTSUQgdG8gYSBkZXZpY2UgYW5kIGRyb3AgdGhlIHJlZmNvdW50
IG9uIHVuYmluZGluZy4gVGhlIG1tIHdvbid0IGJlCj4gZHJvcHBlZCBpZiB0aGUgUEFTSUQgaXMg
c3RpbGwgYm91bmQgdG8gaXQuCj4KPiBGaXhlczogNzAxZmFjNDAzODRmICgiaW9tbXUvc3ZhOiBB
c3NpZ24gYSBQQVNJRCB0byBtbSBvbiBQQVNJRCBhbGxvY2F0aW9uIGFuZCBmcmVlIGl0IG9uIG1t
IGV4aXQiKQo+Cj4gUmVwb3J0ZWQtYnk6IFpoYW5nZmVpIEdhbyA8emhhbmdmZWkuZ2FvQGZveG1h
aWwuY29tPgo+IFN1Z2dlc3RlZC1ieTogRGF2ZSBIYW5zZW4iIDxkYXZlLmhhbnNlbkBsaW51eC5p
bnRlbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogRmVuZ2h1YSBZdSA8ZmVuZ2h1YS55dUBpbnRlbC5j
b20+Cj4gLS0tCj4gICBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My1z
dmEuYyB8IDYgKysrKysrCj4gICBkcml2ZXJzL2lvbW11L2ludGVsL3N2bS5jICAgICAgICAgICAg
ICAgICAgICAgICB8IDQgKysrKwo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCsp
Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUt
djMtc3ZhLmMgYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My1zdmEu
Ywo+IGluZGV4IDIyZGRkMDViYmRjZC4uM2ZjYjg0MmEwZGYwIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLXN2YS5jCj4gKysrIGIvZHJpdmVy
cy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMtc3ZhLmMKPiBAQCAtNyw2ICs3LDcg
QEAKPiAgICNpbmNsdWRlIDxsaW51eC9tbXVfY29udGV4dC5oPgo+ICAgI2luY2x1ZGUgPGxpbnV4
L21tdV9ub3RpZmllci5oPgo+ICAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KPiArI2luY2x1ZGUg
PGxpbnV4L3NjaGVkL21tLmg+Cj4gICAKPiAgICNpbmNsdWRlICJhcm0tc21tdS12My5oIgo+ICAg
I2luY2x1ZGUgIi4uLy4uL2lvbW11LXN2YS1saWIuaCIKPiBAQCAtMzYzLDYgKzM2NCw5IEBAIGFy
bV9zbW11X3N2YV9iaW5kKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IG1tX3N0cnVjdCAqbW0s
IHZvaWQgKmRydmRhdGEpCj4gICAKPiAgIAltdXRleF9sb2NrKCZzdmFfbG9jayk7Cj4gICAJaGFu
ZGxlID0gX19hcm1fc21tdV9zdmFfYmluZChkZXYsIG1tKTsKPiArCS8qIFRha2UgYW4gbW0gcmVm
Y291bnQgb24gYSBzdWNjZXNzZnVsIGJpbmQuICovCj4gKwlpZiAoIUlTX0VSUihoYW5kbGUpKQo+
ICsJCW1tZ2V0KG1tKTsKPiAgIAltdXRleF91bmxvY2soJnN2YV9sb2NrKTsKPiAgIAlyZXR1cm4g
aGFuZGxlOwo+ICAgfQo+IEBAIC0zNzIsNiArMzc2LDggQEAgdm9pZCBhcm1fc21tdV9zdmFfdW5i
aW5kKHN0cnVjdCBpb21tdV9zdmEgKmhhbmRsZSkKPiAgIAlzdHJ1Y3QgYXJtX3NtbXVfYm9uZCAq
Ym9uZCA9IHN2YV90b19ib25kKGhhbmRsZSk7Cj4gICAKPiAgIAltdXRleF9sb2NrKCZzdmFfbG9j
ayk7Cj4gKwkvKiBEcm9wIGFuIG1tIHJlZmNvdW50LiAqLwo+ICsJbW1wdXQoYm9uZC0+bW0pOwo+
ICAgCWlmIChyZWZjb3VudF9kZWNfYW5kX3Rlc3QoJmJvbmQtPnJlZnMpKSB7Cj4gICAJCWxpc3Rf
ZGVsKCZib25kLT5saXN0KTsKPiAgIAkJYXJtX3NtbXVfbW11X25vdGlmaWVyX3B1dChib25kLT5z
bW11X21uKTsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC9zdm0uYyBiL2RyaXZl
cnMvaW9tbXUvaW50ZWwvc3ZtLmMKPiBpbmRleCAyM2EzODc2M2MxZDEuLjM0NWEwZDVkNzkyMiAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL3N2bS5jCj4gKysrIGIvZHJpdmVycy9p
b21tdS9pbnRlbC9zdm0uYwo+IEBAIC00MDMsNiArNDAzLDggQEAgc3RhdGljIHN0cnVjdCBpb21t
dV9zdmEgKmludGVsX3N2bV9iaW5kX21tKHN0cnVjdCBpbnRlbF9pb21tdSAqaW9tbXUsCj4gICAJ
CWdvdG8gZnJlZV9zZGV2Owo+ICAgCj4gICAJbGlzdF9hZGRfcmN1KCZzZGV2LT5saXN0LCAmc3Zt
LT5kZXZzKTsKPiArCS8qIFRha2UgYW4gbW0gcmVmY291bnQgb24gYmluZGluZyBtbS4gKi8KPiAr
CW1tZ2V0KG1tKTsKPiAgIHN1Y2Nlc3M6Cj4gICAJcmV0dXJuICZzZGV2LT5zdmE7Cj4gICAKPiBA
QCAtNDY1LDYgKzQ2Nyw4IEBAIHN0YXRpYyBpbnQgaW50ZWxfc3ZtX3VuYmluZF9tbShzdHJ1Y3Qg
ZGV2aWNlICpkZXYsIHUzMiBwYXNpZCkKPiAgIAkJCQlrZnJlZShzdm0pOwo+ICAgCQkJfQo+ICAg
CQl9Cj4gKwkJLyogRHJvcCBhbiBtbSByZWZlcmVuY2Ugb24gdW5iaW5kaW5nIG1tLiAqLwo+ICsJ
CW1tcHV0KG1tKTsKPiAgIAl9Cj4gICBvdXQ6Cj4gICAJcmV0dXJuIHJldDsKVGhpcyBwYXRjaCBj
YW4gbm90IGJlIGFwcGxpZWQgb24gNS4xOC1yYzIgZm9yIGludGVsIHBhcnQuCkl0IHNob3VsZCB3
b3JrIGZvciBhcm0uCgpJbiBmYWN0IEkgaGF2ZSBhIHNpbWlsYXIgcGF0Y2ggYXQgaGFuZCBidXQg
cGVuZGluZyBzaW5jZSBJIGZvdW5kIGFuIGlzc3VlLgoKSSBzdGFydCAmIHN0b3Agbmdpbnggdmlh
IHRoaXMgY21kLgovL3N0YXJ0CnN1ZG8gc2Jpbi9uZ2lueMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKg
wqDCoCDCoMKgwqAgLy8gdGhpcyBhbGxvYyBhbiBpb2FzaWQ9MQovL3N0b3AKc3VkbyBzYmluL25n
aW54IC1zIHF1aXTCoMKgwqAgLy8gdGhpcyBkb2VzIG5vdCBmcmVlIGlvYXNpZD0xLCBidXQgc3Rp
bGwgCmFsbG9jIGlvYXNpZD0yLgpTbyBpb2FzaWQgd2lsbCBrZWVwIGFsbG9jYXRlZCBidXQgbm90
IGZyZWVkIGlmIGNvbnRpbnVlIHN0YXJ0L3N0b3AgCm5naW54LMKgIHRob3VnaCBub3QgaW1wYWN0
IHRoZSBuZ2lueCBmdW5jdGlvbi4KCnN0b3Agbmdpbnggd2l0aCAtcyBxdWl0IHN0aWxsIGNhbGxz
CnNyYy9jb3JlL25naW54LmMKbWFpbiAtPiBuZ3hfc3NsX2luaXQgLT4gb3BlbnNzbCBlbmdpbmU6
IMKgwqAgYmluZF9mbiAtPiAuLi4gLT4gYWxsb2MgYXNpZApCdXQgb3BlbnNzbCBlbmdpbmU6IEVO
R0lORV9mcmVlIGlzIG5vdCBjYWxsZWQKClN0aWxsIGluIGNoZWNraW5nIG5naW54IGNvZGUuCgpP
ciBkbyB5b3UgdGVzdCB3aXRoIG5naW54PwoKVGhhbmtzCgoKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
