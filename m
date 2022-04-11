Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E450AC433F5
	for <iommu@archiver.kernel.org>; Mon, 11 Apr 2022 14:44:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 640DC410E7;
	Mon, 11 Apr 2022 14:44:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yQSAb8fd_999; Mon, 11 Apr 2022 14:44:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D40A0410CA;
	Mon, 11 Apr 2022 14:44:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF7BAC002F;
	Mon, 11 Apr 2022 14:44:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CDBBC002C
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 14:44:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6997E410D5
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 14:44:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1goxdCuxagHb for <iommu@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 14:44:19 +0000 (UTC)
X-Greylist: delayed 00:22:06 by SQLgrey-1.8.0
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com
 [162.62.57.137])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2F9A6410CA
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 14:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1649688253;
 bh=7GopoeoK8zI4GB2l2eUN6bBtjkL/7R2gwbjUIUdvthE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To;
 b=eW0xstcWUyT4B9NM20y9wT/R8QwUbOSYT12qUzbcidpHB88jhMuili6sd3tHDYBLu
 aEiTf0MP0DGz/NcR+RcAmeWEO+ykBdqCiDmT1KRD5ivDQIQh3/fa+cn8e1Ld31L1g4
 BYWS1a37n6HQTtjc7ufU4bm+8droRJbAhUYkzFdE=
Received: from [192.168.0.110] ([36.57.147.99])
 by newxmesmtplogicsvrsza9.qq.com (NewEsmtp) with SMTP
 id B092E6BD; Mon, 11 Apr 2022 22:44:09 +0800
X-QQ-mid: xmsmtpt1649688249tqqsw39z6
Message-ID: <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
X-QQ-XMAILINFO: OUk+E8Vw5ntv/lqYBkZyCcCdpp8XhX2hlX1rqAcTh0BWTUq6rW9TdRRTC2ByXP
 k679H/OPozXD3bmep3k6pICozuz/THcQtK34zGXbsUR38rBK4pRZGKxWnRhm+1PfBFq7m3dI94nT
 Z+f0B1bqt0AbD5flZ6QUvO1kkofS2BpEUAONtJuQk0+4/u8l0Opugk4GV9C+noYnBjQ29QPstodw
 h/h7sJXnXkGRNdzxSYPhqRLMLjXIC2pLPzyUlktJ8uTG/CvrE8iBT0P+hRA13V8DY4MpkPeTR5eH
 bTZxqIowTrMOr4FwlffUmU4W6YXyuUO81oPOyPbN6nN5aOF/9CdbJTI9jlhav+v6SLNiW+FWFPWI
 OreZh4wqTZNqnjweUQjeb6iz5oIlMnl7RCfc8Jmr9sbmxqG+Y1bLis5B1ou1G8fbBPPlPTW+bBST
 YxFSd2/hhDFFBXSjpVzXC6N7A8EtJRkw03N0N2W8qwv/wMX2erwFxZV8FNnDy2b9SOoGYEj8jIy6
 3JEOFi05EhlLq3K+4Cef1dDBAmjGbi1pKtr9wLLquWLV2k4kwFG1Rs3FcUT3h6uARFVBse0nrj1/
 xnqeKqvrSSQJ3peIKIeN4YxuuOwVqTlusOhrYZn2MIh9uR5736hOzKTNEBPadYgg36UmFzYzSseO
 6XXTP2B0x2ImRwuHUs/D+k7nLv8Ly7BwHq0ofcpUMI8QtOXj3waYW6sxRFsHJOcZURfWQ9obyUlf
 Nox07YsIhL+6Ht5wmBNZrql5BOGE4VhlTgQ+K0d6fRox5Fn+/A0MJL/KWyMeCF0OwVfmKzILK3jG
 V+yE6tb6R68LUE+WIAkIUB/bhBc3tMwGOMxQOf4ib0CbsWzCobC6zicrHv4CqDcUCWcuJ6IlLok1
 2tOLf7HDm97/kydq4Q7ycxg22hdWYiyGZYDZ02FBO0CQQQYPexHbXRmLCcsn4Cbrlvck0as4wEfP
 3Fn80RAl9z/5qXlVuObrnCJ41VLPZ3nGHMNenmmMWJAZPRMzpsn0JSq652GkAGa7erphNFAQQ=
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
To: Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Fenghua Yu <fenghua.yu@intel.com>, jean-philippe <jean-philippe@linaro.org>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com> <Ygt4h0PgYzKOiB38@8bytes.org>
 <tencent_F6830A1196DB4C6A904D7C691F0D961D1108@qq.com>
 <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
 <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
From: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <88055f44-3106-feca-aeac-d7272f3ee824@foxmail.com>
Date: Mon, 11 Apr 2022 22:44:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
Content-Language: en-US
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Borislav Petkov <bp@alien8.de>,
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

CgpPbiAyMDIyLzQvMTEg5LiL5Y2IMTA6MzYsIERhdmUgSGFuc2VuIHdyb3RlOgo+IE9uIDQvMTEv
MjIgMDc6MjAsIHpoYW5nZmVpLmdhb0Bmb3htYWlsLmNvbSB3cm90ZToKPj4+IElzIHRoZXJlIG5v
dGhpbmcgYmVmb3JlIHRoaXMgY2FsbCB0cmFjZT/CoCBVc3VhbGx5IHRoZXJlIHdpbGwgYmUgYXQg
bGVhc3QKPj4+IHNvbWUgd2FybmluZyB0ZXh0Lgo+PiBJIGFkZGVkIGR1bXBfc3RhY2soKSBpbiBp
b2FzaWRfZnJlZS4KPiBIb2xkIG9uIGEgc2VjLCB0aG91Z2guLi4KPgo+IFdoYXQncyB0aGUgKnBy
b2JsZW0qIGhlcmU/ICBEaWQgc29tZXRoaW5nIGJyZWFrIG9yIGFyZSB5b3UganVzdCBzYXlpbmcK
PiB0aGF0IHNvbWV0aGluZyBsb29rcyB3ZWlyZCB0byBfeW91Xz8KCkFmdGVyIHRoaXMsIG5naW54
IGlzIG5vdCB3b3JraW5nIGF0IGFsbCwgYW5kIGhhcmR3YXJlIHJlcG9ydHMgZXJyb3IuClN1cHBv
c2UgdGhlIHRoZSBtYXN0ZXIgdXNlIHRoZSBpb2FzaWQgZm9yIGluaXQsIGJ1dCBnb3QgZnJlZWQu
CgpoYXJkd2FyZSByZXBvcnRzOgpbwqAgMTUyLjczMTg2OV0gaGlzaV9zZWMyIDAwMDA6NzY6MDAu
MDogcW1fYWNjX2RvX3Rhc2tfdGltZW91dCBbZXJyb3IgCnN0YXR1cz0weDIwXSBmb3VuZApbwqAg
MTUyLjczOTY1N10gaGlzaV9zZWMyIDAwMDA6NzY6MDAuMDogcW1fYWNjX3diX25vdF9yZWFkeV90
aW1lb3V0IApbZXJyb3Igc3RhdHVzPTB4NDBdIGZvdW5kClvCoCAxNTIuNzQ3ODc3XSBoaXNpX3Nl
YzIgMDAwMDo3NjowMC4wOiBzZWNfZnNtX2hiZWF0X3JpbnQgW2Vycm9yIApzdGF0dXM9MHgyMF0g
Zm91bmQKW8KgIDE1Mi43NTUzNDBdIGhpc2lfc2VjMiAwMDAwOjc2OjAwLjA6IENvbnRyb2xsZXIg
cmVzZXR0aW5nLi4uClvCoCAxNTIuNzYyMDQ0XSBoaXNpX3NlYzIgMDAwMDo3NjowMC4wOiBRTSBt
YWlsYm94IG9wZXJhdGlvbiB0aW1lb3V0IQpbwqAgMTUyLjc2ODE5OF0gaGlzaV9zZWMyIDAwMDA6
NzY6MDAuMDogRmFpbGVkIHRvIGR1bXAgc3FjIQpbwqAgMTUyLjc3MzQ5MF0gaGlzaV9zZWMyIDAw
MDA6NzY6MDAuMDogRmFpbGVkIHRvIGRyYWluIG91dCBkYXRhIGZvciAKc3RvcHBpbmchClvCoCAx
NTIuNzgxNDI2XSBoaXNpX3NlYzIgMDAwMDo3NjowMC4wOiBRTSBtYWlsYm94IGlzIGJ1c3kgdG8g
c3RhcnQhClvCoCAxNTIuNzg3NDY4XSBoaXNpX3NlYzIgMDAwMDo3NjowMC4wOiBGYWlsZWQgdG8g
ZHVtcCBzcWMhClvCoCAxNTIuNzkyNzUzXSBoaXNpX3NlYzIgMDAwMDo3NjowMC4wOiBGYWlsZWQg
dG8gZHJhaW4gb3V0IGRhdGEgZm9yIApzdG9wcGluZyEKW8KgIDE1Mi44MDA2ODVdIGhpc2lfc2Vj
MiAwMDAwOjc2OjAwLjA6IFFNIG1haWxib3ggaXMgYnVzeSB0byBzdGFydCEKW8KgIDE1Mi44MDY3
MzBdIGhpc2lfc2VjMiAwMDAwOjc2OjAwLjA6IEZhaWxlZCB0byBkdW1wIHNxYyEKW8KgIDE1Mi44
MTIwMTddIGhpc2lfc2VjMiAwMDAwOjc2OjAwLjA6IEZhaWxlZCB0byBkcmFpbiBvdXQgZGF0YSBm
b3IgCnN0b3BwaW5nIQpbwqAgMTUyLjgxOTk0Nl0gaGlzaV9zZWMyIDAwMDA6NzY6MDAuMDogUU0g
bWFpbGJveCBpcyBidXN5IHRvIHN0YXJ0IQpbwqAgMTUyLjgyNTk5Ml0gaGlzaV9zZWMyIDAwMDA6
NzY6MDAuMDogRmFpbGVkIHRvIGR1bXAgc3FjIQoKVGhhbmtzCgo+Cj4gRm9yIGluc3RhbmNlLCBp
ZiB3ZSBoYXZlOgo+Cj4gCW5naW54OiBpb2FzaWRfYWxsb2MoKT09MQo+IAkgICAgICAgZm9yaygp
OyAvLyBzcGF3biB0aGUgZGFlbW9uCj4gCSAgICAgICBleGl0KCk7Cj4gCSAgICAgICBpb2FzaWRf
ZnJlZSgxKTsKPgo+IGFuZCB0aGVuIGEgbW9tZW50IGxhdGVyOgo+Cj4gCWx5bng6ICBpb2FzaWRf
YWxsb2MoKT09MQo+IAkgICAgICAgZm9yaygpOwo+IAkgICAgICAgZXhpdCgpOwo+IAkgICAgICAg
aW9hc2lkX2ZyZWUoMSk7Cj4KPiBUaGVyZSdzIG5vIHByb2JsZW0uICBUaGUgb3JpZ2luYWwgbmdp
bnggcHJvY2VzcyB3aXRoIGlvYXNpZD09MSBleGl0ZWQuCj4gVGhlIGZhY3QgdGhhdCAqc29tZSog
cHJvY2VzcyBjYWxsZWQgbmdpbnggaXMgc3RpbGwgcnVubmluZyBkb2Vzbid0IG1lYW4KPiB0aGF0
IGl0IHN0aWxsIGhhcyBhIHJlZmVyZW5jZSB0byBhc2lkPT0xLgo+Cj4gQXJlIHlvdSBzdXJlIHRo
ZSBuZ2lueCBwcm9jZXNzIHRoYXQgYWxsb2NhdGVkIHRoZSBBU0lEIGlzIHRoZSBzYW1lCj4gcHJv
Y2VzcyB5b3Ugc2VlIGluIHBzPwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
