Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695E2C433EF
	for <iommu@archiver.kernel.org>; Fri, 15 Apr 2022 11:52:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F1ED140585;
	Fri, 15 Apr 2022 11:52:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UJOMfPwtgLcN; Fri, 15 Apr 2022 11:52:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9E9B1400AB;
	Fri, 15 Apr 2022 11:52:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76D02C0033;
	Fri, 15 Apr 2022 11:52:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22AB2C002C
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 11:52:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 08DE640585
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 11:52:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uwGAhIkk8HjW for <iommu@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 11:52:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com
 [162.62.57.210])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3B83D400AB
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 11:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1650023545;
 bh=Zq+vaNpRqP4VrswkHOyz0dXQz+AjsR8Pi4S6W+jeGU4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To;
 b=ExBXBtDoDi4L3IKdfYPDtMzlu8iXxf2HRex0i0tb91IlEkSV48L0tXuoDZWN1Q3e0
 SuZSK/MIad57cJjEtwEq3WWiM7YjvUlfA03qRm1t8jW0DvT3jnzDSG8E7faYTn/608
 0k6gIkxThCmcDNaml7krjm8TaQpst/mG+sT1SbkA=
Received: from [10.188.0.6] ([94.177.118.94])
 by newxmesmtplogicsvrszb7.qq.com (NewEsmtp) with SMTP
 id D072B49F; Fri, 15 Apr 2022 19:52:07 +0800
X-QQ-mid: xmsmtpt1650023527tskd35efu
Message-ID: <tencent_CD35B6A6FBB48186B38EF641F088BAED1407@qq.com>
X-QQ-XMAILINFO: NK7mH5+t7Gn7sK/Re4oRVkbcjXaWsb3WTzOpPSwFIW2fCDXKWFWmxIykuZkbJN
 pfhPLuaY3+ftdc6yrCYq5IxXroSK0nUQRO/Qjsp7fX7DXm63vSnerKPZjOxL1rkhvJvH59MwsYcp
 68N8RvaN28KQiq2UM2gF6SvuySxyj2eQo3duSZL0YJ8fYr78XL4TaJ6c4jzHqwiUPLrK68E1T/uS
 bthagbPrrOl1hPkjmC0MLfdPC48dtJFTFDMpxlgte/vJBUsSZ3LcnrV9OoRDR8SGlmwgoYdW4lQO
 B/OlqfzRMwu49FzDJutg1CyMIeXSMHtovjTBauzEHgIhTSzL32qub3OQIunxMBxHYVUtqxmdpC6X
 vpzXA1bSZaib7LTnSNoH+MpiUwDa2yM0R89vjuWEbqjYZNNDFMm3NEuZS3+DsBTKsGkw65lqw636
 8cpZ0ZhnJcN+J4DUF8Mag6/Ras94++CS7DaaIgytzxnFKtkbV7rkhWkbW3WwaA7v4Ly+eRgPiIgX
 LtOtY/fQz8jWq1ZGEQ+Lz/jm6Ra/6PFk6wA3doDoS4mZafQ8axR6e6PYWbOEdnJz7Sf8U5rPtsEO
 nB8ztR1kEC9ITMSK5yPq6rlwfuDO+NDaRLG+0NTat9rrjvbimOPvGlnq9xLyWxoC5g/v55LlnZHR
 UvJPcEeZbG5zC8JlDU+YKrXuwhnQKI0mhDa1o7SgYrdNmxfguI1HClAi0W+QTcCM9/wgvgiz+Ufy
 0hNJwF1ORuz5rB0EX3B/tszJztAErxefEiwOKE5bYh/YDCh5lGCT4WFnaMPvVhV8GL85cf6F/UI/
 mA2n1h+u3pTzTrInMLKzHzZPiz1cczZHniCczEq1Iztw676Fq/lzy2n7nCOUTXc84y8ogXrkEzWw
 YrsG3AXUcn8mYLz7nuP50YLQ2p5evUNXzmUEC4U1fV8nwmJKO/oc7prIzkZjfQoKT3fuKbnnwncO
 K1GWjczGIquPfYykmiHxYPy8annhuJZzjd3kdAYtp8m16LhwHHGXV01iTsCrH+
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
To: Fenghua Yu <fenghua.yu@intel.com>
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
From: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <722d4991-4c0c-23ba-a533-f496c13458c7@foxmail.com>
Date: Fri, 15 Apr 2022 19:52:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YllN/OmjpYdT1tO9@otcwcpicx3.sc.intel.com>
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

CgpPbiAyMDIyLzQvMTUg5LiL5Y2INjo1MCwgRmVuZ2h1YSBZdSB3cm90ZToKPiBIaSwgWmhhbmdm
ZWksCj4KPiBPbiBGcmksIEFwciAxNSwgMjAyMiBhdCAwNjoxNDowOVBNICswODAwLCB6aGFuZ2Zl
aS5nYW9AZm94bWFpbC5jb20gd3JvdGU6Cj4+Cj4+IE9uIDIwMjIvNC8xNSDkuIvljYg1OjUxLCBG
ZW5naHVhIFl1IHdyb3RlOgo+Pj4gT24gVGh1LCBBcHIgMTQsIDIwMjIgYXQgMDY6MDg6MDlQTSAr
MDgwMCwgemhhbmdmZWkuZ2FvQGZveG1haWwuY29tIHdyb3RlOgo+Pj4+IE9uIDIwMjIvNC8xMiDk
uIvljYgxMTozNSwgemhhbmdmZWkuZ2FvQGZveG1haWwuY29tIHdyb3RlOgo+Pj4+PiBIaSwgRmVu
Z2h1YQo+Pj4+Pgo+Pj4+PiBPbiAyMDIyLzQvMTIg5LiL5Y2IOTo0MSwgRmVuZ2h1YSBZdSB3cm90
ZToKPj4+ICAgRnJvbSBhNjQ0NGUxZTViZDgwNzZmNWU1YzVlOTUwZDMxOTJkZTMyN2YwYzljIE1v
biBTZXAgMTcgMDA6MDA6MDAgMjAwMQo+Pj4gRnJvbTogRmVuZ2h1YSBZdSA8ZmVuZ2h1YS55dUBp
bnRlbC5jb20+Cj4+PiBEYXRlOiBGcmksIDE1IEFwciAyMDIyIDAwOjUxOjMzIC0wNzAwCj4+PiBT
dWJqZWN0OiBbUkZDIFBBVENIXSBpb21tdS9zdmE6IEZpeCBQQVNJRCB1c2UtYWZ0ZXItZnJlZSBp
c3N1ZQo+Pj4KPj4+IEEgUEFTSUQgbWlnaHQgYmUgc3RpbGwgdXNlZCBldmVuIHRob3VnaCBpdCBp
cyBmcmVlZCBvbiBtbSBleGl0Lgo+Pj4KPj4+IHByb2Nlc3MgQToKPj4+IAlzdmFfYmluZCgpOwo+
Pj4gCWlvYXNpZF9hbGxvYygpID0gTjsgLy8gR2V0IFBBU0lEIE4gZm9yIHRoZSBtbQo+Pj4gCWZv
cmsoKTogLy8gc3Bhd24gcHJvY2VzcyBCCj4+PiAJZXhpdCgpOwo+Pj4gCWlvYXNpZF9mcmVlKE4p
Owo+Pj4KPj4+IHByb2Nlc3MgQjoKPj4+IAlkZXZpY2UgdXNlcyBQQVNJRCBOIC0+IGZhaWx1cmUK
Pj4+IAlzdmFfdW5iaW5kKCk7Cj4+Pgo+Pj4gRGF2ZSBIYW5zZW4gc3VnZ2VzdHMgdG8gdGFrZSBh
IHJlZmNvdW50IG9uIHRoZSBtbSB3aGVuZXZlciBiaW5kaW5nIHRoZQo+Pj4gUEFTSUQgdG8gYSBk
ZXZpY2UgYW5kIGRyb3AgdGhlIHJlZmNvdW50IG9uIHVuYmluZGluZy4gVGhlIG1tIHdvbid0IGJl
Cj4+PiBkcm9wcGVkIGlmIHRoZSBQQVNJRCBpcyBzdGlsbCBib3VuZCB0byBpdC4KPj4+Cj4+PiBG
aXhlczogNzAxZmFjNDAzODRmICgiaW9tbXUvc3ZhOiBBc3NpZ24gYSBQQVNJRCB0byBtbSBvbiBQ
QVNJRCBhbGxvY2F0aW9uIGFuZCBmcmVlIGl0IG9uIG1tIGV4aXQiKQo+Pj4KPj4+IFJlcG9ydGVk
LWJ5OiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0Bmb3htYWlsLmNvbT4KPj4+IFN1Z2dlc3Rl
ZC1ieTogRGF2ZSBIYW5zZW4iIDxkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb20+Cj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBGZW5naHVhIFl1IDxmZW5naHVhLnl1QGludGVsLmNvbT4KPj4+IC0tLQo+Pj4g
ICAgZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMtc3ZhLmMgfCA2ICsr
KysrKwo+Pj4gICAgZHJpdmVycy9pb21tdS9pbnRlbC9zdm0uYyAgICAgICAgICAgICAgICAgICAg
ICAgfCA0ICsrKysKPj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQo+Pj4K
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12
My1zdmEuYyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLXN2YS5j
Cj4+PiBpbmRleCAyMmRkZDA1YmJkY2QuLjNmY2I4NDJhMGRmMCAxMDA2NDQKPj4+IC0tLSBhL2Ry
aXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLXN2YS5jCj4+PiArKysgYi9k
cml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My1zdmEuYwo+Pj4gQEAgLTcs
NiArNyw3IEBACj4+PiAgICAjaW5jbHVkZSA8bGludXgvbW11X2NvbnRleHQuaD4KPj4+ICAgICNp
bmNsdWRlIDxsaW51eC9tbXVfbm90aWZpZXIuaD4KPj4+ICAgICNpbmNsdWRlIDxsaW51eC9zbGFi
Lmg+Cj4+PiArI2luY2x1ZGUgPGxpbnV4L3NjaGVkL21tLmg+Cj4+PiAgICAjaW5jbHVkZSAiYXJt
LXNtbXUtdjMuaCIKPj4+ICAgICNpbmNsdWRlICIuLi8uLi9pb21tdS1zdmEtbGliLmgiCj4+PiBA
QCAtMzYzLDYgKzM2NCw5IEBAIGFybV9zbW11X3N2YV9iaW5kKHN0cnVjdCBkZXZpY2UgKmRldiwg
c3RydWN0IG1tX3N0cnVjdCAqbW0sIHZvaWQgKmRydmRhdGEpCj4+PiAgICAJbXV0ZXhfbG9jaygm
c3ZhX2xvY2spOwo+Pj4gICAgCWhhbmRsZSA9IF9fYXJtX3NtbXVfc3ZhX2JpbmQoZGV2LCBtbSk7
Cj4+PiArCS8qIFRha2UgYW4gbW0gcmVmY291bnQgb24gYSBzdWNjZXNzZnVsIGJpbmQuICovCj4+
PiArCWlmICghSVNfRVJSKGhhbmRsZSkpCj4+PiArCQltbWdldChtbSk7Cj4+PiAgICAJbXV0ZXhf
dW5sb2NrKCZzdmFfbG9jayk7Cj4+PiAgICAJcmV0dXJuIGhhbmRsZTsKPj4+ICAgIH0KPj4+IEBA
IC0zNzIsNiArMzc2LDggQEAgdm9pZCBhcm1fc21tdV9zdmFfdW5iaW5kKHN0cnVjdCBpb21tdV9z
dmEgKmhhbmRsZSkKPj4+ICAgIAlzdHJ1Y3QgYXJtX3NtbXVfYm9uZCAqYm9uZCA9IHN2YV90b19i
b25kKGhhbmRsZSk7Cj4+PiAgICAJbXV0ZXhfbG9jaygmc3ZhX2xvY2spOwo+Pj4gKwkvKiBEcm9w
IGFuIG1tIHJlZmNvdW50LiAqLwo+Pj4gKwltbXB1dChib25kLT5tbSk7Cj4+PiAgICAJaWYgKHJl
ZmNvdW50X2RlY19hbmRfdGVzdCgmYm9uZC0+cmVmcykpIHsKPj4+ICAgIAkJbGlzdF9kZWwoJmJv
bmQtPmxpc3QpOwo+Pj4gICAgCQlhcm1fc21tdV9tbXVfbm90aWZpZXJfcHV0KGJvbmQtPnNtbXVf
bW4pOwo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvc3ZtLmMgYi9kcml2ZXJz
L2lvbW11L2ludGVsL3N2bS5jCj4+PiBpbmRleCAyM2EzODc2M2MxZDEuLjM0NWEwZDVkNzkyMiAx
MDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvc3ZtLmMKPj4+ICsrKyBiL2RyaXZl
cnMvaW9tbXUvaW50ZWwvc3ZtLmMKPj4+IEBAIC00MDMsNiArNDAzLDggQEAgc3RhdGljIHN0cnVj
dCBpb21tdV9zdmEgKmludGVsX3N2bV9iaW5kX21tKHN0cnVjdCBpbnRlbF9pb21tdSAqaW9tbXUs
Cj4+PiAgICAJCWdvdG8gZnJlZV9zZGV2Owo+Pj4gICAgCWxpc3RfYWRkX3JjdSgmc2Rldi0+bGlz
dCwgJnN2bS0+ZGV2cyk7Cj4+PiArCS8qIFRha2UgYW4gbW0gcmVmY291bnQgb24gYmluZGluZyBt
bS4gKi8KPj4+ICsJbW1nZXQobW0pOwo+Pj4gICAgc3VjY2VzczoKPj4+ICAgIAlyZXR1cm4gJnNk
ZXYtPnN2YTsKPj4+IEBAIC00NjUsNiArNDY3LDggQEAgc3RhdGljIGludCBpbnRlbF9zdm1fdW5i
aW5kX21tKHN0cnVjdCBkZXZpY2UgKmRldiwgdTMyIHBhc2lkKQo+Pj4gICAgCQkJCWtmcmVlKHN2
bSk7Cj4+PiAgICAJCQl9Cj4+PiAgICAJCX0KPj4+ICsJCS8qIERyb3AgYW4gbW0gcmVmZXJlbmNl
IG9uIHVuYmluZGluZyBtbS4gKi8KPj4+ICsJCW1tcHV0KG1tKTsKPj4+ICAgIAl9Cj4+PiAgICBv
dXQ6Cj4+PiAgICAJcmV0dXJuIHJldDsKPj4gVGhpcyBwYXRjaCBjYW4gbm90IGJlIGFwcGxpZWQg
b24gNS4xOC1yYzIgZm9yIGludGVsIHBhcnQuCj4gV2hhdCBlcnJvciBkbyB5b3Ugc2VlPyBDb3Vs
ZCB5b3UgcGxlYXNlIHNlbmQgdG8gbWUgZXJyb3JzPwo+Cj4gSSBkb3dubG9hZCB0aGlzIHBhdGNo
IGZyb206Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9ZbGxBREw2dU1vTGxselFvQGZ5
dTEuc2MuaW50ZWwuY29tL3Jhdwo+IGdpdCBhbSB0byBlaXRoZXIgdjUuMTgtcmMyIG9yIHRoZSBs
YXRlc3QgdXBzdHJlYW0gd2l0aG91dCBhbnkgaXNzdWUuCkl0IGlzIG15IGNvcHkgcGFzdGUgaXNz
dWUuCgpJIGhhdmUgdGVzdGVkLCBuZ2lueCB3b2tzIHdlbGwuCgpPdGhlciB0aGFuIHRoZSBmb2xs
b3dpbmcgaXNzdWUsCkVhY2ggdGltZSAvc2Jpbi9uZ2lueCB3aWxsIGFsbG9jIGlvYXNpZCBidXQg
bm90IGZyZWUuCndoaWNoIEkgdGhpbmsgaXQgbWF5YmUgbmdpbnggaXNzdWUgb3IgdGhlIG1pcy11
c2FnZSwgd2lsbCBhc2sgdGhlcmUuCgpUZXN0ZWQtYnk6IFpoYW5nZmVpIEdhbyA8emhhbmdmZWku
Z2FvQGxpbmFyby5vcmc+Cgo+Cj4+IEl0IHNob3VsZCB3b3JrIGZvciBhcm0uCj4+Cj4+IEluIGZh
Y3QgSSBoYXZlIGEgc2ltaWxhciBwYXRjaCBhdCBoYW5kIGJ1dCBwZW5kaW5nIHNpbmNlIEkgZm91
bmQgYW4gaXNzdWUuCj4+Cj4+IEkgc3RhcnQgJiBzdG9wIG5naW54IHZpYSB0aGlzIGNtZC4KPj4g
Ly9zdGFydAo+PiBzdWRvIHNiaW4vbmdpbnjCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDC
oMKgIC8vIHRoaXMgYWxsb2MgYW4gaW9hc2lkPTEKPj4gLy9zdG9wCj4+IHN1ZG8gc2Jpbi9uZ2lu
eCAtcyBxdWl0wqDCoMKgIC8vIHRoaXMgZG9lcyBub3QgZnJlZSBpb2FzaWQ9MSwgYnV0IHN0aWxs
IGFsbG9jCj4+IGlvYXNpZD0yLgo+PiBTbyBpb2FzaWQgd2lsbCBrZWVwIGFsbG9jYXRlZCBidXQg
bm90IGZyZWVkIGlmIGNvbnRpbnVlIHN0YXJ0L3N0b3AgbmdpbngsCj4+IHRob3VnaCBub3QgaW1w
YWN0IHRoZSBuZ2lueCBmdW5jdGlvbi4KPj4KPj4gc3RvcCBuZ2lueCB3aXRoIC1zIHF1aXQgc3Rp
bGwgY2FsbHMKPj4gc3JjL2NvcmUvbmdpbnguYwo+PiBtYWluIC0+IG5neF9zc2xfaW5pdCAtPiBv
cGVuc3NsIGVuZ2luZTogwqDCoCBiaW5kX2ZuIC0+IC4uLiAtPiBhbGxvYyBhc2lkCj4+IEJ1dCBv
cGVuc3NsIGVuZ2luZTogRU5HSU5FX2ZyZWUgaXMgbm90IGNhbGxlZAo+Pgo+PiBTdGlsbCBpbiBj
aGVja2luZyBuZ2lueCBjb2RlLgo+Pgo+PiBPciBkbyB5b3UgdGVzdCB3aXRoIG5naW54Pwo+IE9u
IG15IFg4NiBtYWNoaW5lLCBuZ2lueCBkb2Vzbid0IHRyaWdnZXIgdGhlIGtlcm5lbCBzdmEgYmlu
ZGluZyBmdW5jdGlvbgo+IHRvIGFsbG9jYXRlIGlvYXNpZC4gSSB0cmllZCBwcmUtIG5zdGFsbGVk
IG5naW54L29wZW5zc2wgYW5kIGFsc28gdHJpZWQgbXkgYnVpbHQKPiBhIGZldyB2ZXJzaW9ucyBv
ZiBuZ2lueC9vcGVuc3NsLiBuZ2lueCBkb2VzIGNhbGwgT1BFTlNTTF9pbml0X3NzbCgpIGJ1dAo+
IGRvZXNuJ3QgZ28gdG8gdGhlIGJpbmRpbmcgZnVuY3Rpb24uIERvbid0IGtub3cgaWYgaXQncyBt
eSBjb25maWd1cmF0aW9uIGlzc3VlLgo+IE1heWJlIHlvdSBjYW4gZ2l2ZSBtZSBzb21lIGFkdmlj
ZT8KSSBhbSB1c2luZyBvcGVuc3NsIGVuZ2luZSwgd2hpY2ggdXNlIGNyeXB0byBkcml2ZXIgYW5k
IHVzaW5nIHN2YSB2aWEgdWFjY2UuCm5naW54IC0+IG9wZW5zc2wgLT4gb3BlbnNzbCBlbmdpbmUg
LT4gc3ZhIHJlbGF0ZWQuCgo+Cj4gSSB0ZXN0IHRoZSBwYXRjaCB3aXRoIGEgZmV3IGludGVybmFs
IHRlc3QgdG9vbHMgYW5kIG9ic2VydmUgbW1nZXQoKS9tbXB1dCgpCj4gd29ya3MgZmluZSBpbiB2
YXJpb3VzIGNhc2VzLgpPSywgdGhhbmtzCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2lvbW11
