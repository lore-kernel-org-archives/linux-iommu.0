Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2861AC433EF
	for <iommu@archiver.kernel.org>; Tue, 26 Apr 2022 05:05:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF2AF60FAD;
	Tue, 26 Apr 2022 05:05:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R43LKT7XoK4F; Tue, 26 Apr 2022 05:04:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 818E16002E;
	Tue, 26 Apr 2022 05:04:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57DA6C0032;
	Tue, 26 Apr 2022 05:04:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D405FC002D
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 05:04:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C7FE160D55
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 05:04:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qc3j3dkPC-JT for <iommu@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 05:04:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1B0386002E
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 05:04:58 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id y38so1163922pfa.6
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 22:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=lPXsvXXGB7VzRP9ej4ptpjaenvWfGjQbLRTTAEwWda0=;
 b=jo/48cGIu/kMQ9mRy2bQKU5eHnn/f92jmtF0iR9CR/UrRqME7GNoU7GYIMgI8mEhep
 zy/VQmUa6lucV+0vu1gJgW4tHzaz04opC1mJ2FiRFyMXaRelrZ+YB5A+20X/GRbuvVXS
 HPS0Odmf6sHfqmg6mGn75ywZuE1xlpccshGRpsNW5TnadiRYQWb0xDG50+N1yNlccYu6
 +SpTX75xVCKHQm3sCTAgkI/ovpLb/oXsxUpcu20usNovyXK+FvegmPnGaYZ9jMW51mmI
 jc17P0+S1c2HxwgDIMrqfkYc0c4PdupZzr/dBxxVT1kJkL8Zj/X+c/qphcqvAdlLZZPB
 PXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=lPXsvXXGB7VzRP9ej4ptpjaenvWfGjQbLRTTAEwWda0=;
 b=l2H5dmIk1xaArZmwsylMbqEI0Ly72hyr1kDpD71VUHGV6sWAAk+BB0XK9yGn9SR6B6
 2qcIOP5UZIPK6UAkWb8/c+TaKVD1pERjqYjVYTdZvf63S3tbqP7z6XN5IXyVRzm+VX9j
 5tbuIxHg6d1mVQ/rZGHXCJ7+ynWeNpYSjAkzdfgouQY6jxFxhg0yN1KeN30hMnWlQrC6
 NpOMSTowJDj1IE5hW70vVqvej97wUjuDcszn81QFwYiRfE4QOnafBuZIbAAw7GPS6OZK
 aDMOuJJR9ab1s86MmlE8/JSx+QCKFZ+fRSKCCJ8KFvBXcKZ5sSg72GEkOHsiETzVWHtB
 rGGQ==
X-Gm-Message-State: AOAM532jzt73GrVJiUZzB+SKvKDowYQPvVAEj3OTZ2TL4myhHFVeWtUr
 4PvWLcdU5C2F7ivQhxPSf63xIA==
X-Google-Smtp-Source: ABdhPJx/qAZq2zf7Iyqg3U1jZcXi6gNTqwfkvznUFbMm5a7xwNnu4FewaA8aIJv1P1nd8KUwWw2DOQ==
X-Received: by 2002:a63:40c6:0:b0:39d:9463:94ac with SMTP id
 n189-20020a6340c6000000b0039d946394acmr17583134pga.289.1650949497556; 
 Mon, 25 Apr 2022 22:04:57 -0700 (PDT)
Received: from [10.69.0.6] ([94.177.118.37]) by smtp.gmail.com with ESMTPSA id
 i11-20020a17090a718b00b001cd4989feb9sm1108161pjk.5.2022.04.25.22.04.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Apr 2022 22:04:57 -0700 (PDT)
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
To: Fenghua Yu <fenghua.yu@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com>
 <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica> <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica> <20220425083444.00af5674@jacob-builder>
 <YmbIjnHtibY7n4Wb@myrica> <YmdzFFx7fN586jcf@fyu1.sc.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <51514a02-0de9-2f9e-ec0e-c86e147fa74c@linaro.org>
Date: Tue, 26 Apr 2022 13:04:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YmdzFFx7fN586jcf@fyu1.sc.intel.com>
Content-Language: en-US
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, will@kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu <iommu@lists.linux-foundation.org>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, robin.murphy@arm.com,
 Ingo Molnar <mingo@redhat.com>
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

CgpPbiAyMDIyLzQvMjYg5LiL5Y2IMTI6MjAsIEZlbmdodWEgWXUgd3JvdGU6Cj4gSGksIEplYW4g
YW5kIFpoYW5nZmVpLAo+Cj4gT24gTW9uLCBBcHIgMjUsIDIwMjIgYXQgMDU6MTM6MDJQTSArMDEw
MCwgSmVhbi1QaGlsaXBwZSBCcnVja2VyIHdyb3RlOgo+PiBDb3VsZCB3ZSBtb3ZlIG1tX3Bhc2lk
X2Ryb3AoKSB0byBfX21tZHJvcCgpIGluc3RlYWQgb2YgX19tbXB1dCgpPyAgRm9yIEFybQo+PiB3
ZSBkbyBuZWVkIHRvIGhvbGQgdGhlIG1tX2NvdW50IHVudGlsIHVuYmluZCgpLCBhbmQgbW1ncmFi
KCkvbW1kcm9wKCkgaXMKPj4gYWxzbyBwYXJ0IG9mIEx1J3MgcmV3b3JrIFsxXS4KPiBJcyB0aGlz
IGEgcmlnaHQgZml4IGZvciB0aGUgaXNzdWU/IENvdWxkIHlvdSBwbGVhc2UgdGVzdCBpdCBvbiBB
Uk0/Cj4gSSBkb24ndCBoYXZlIGFuIEFSTSBtYWNoaW5lLgo+Cj4gVGhhbmtzLgo+Cj4gLUZlbmdo
dWEKPgo+ICBGcm9tIDg0YWE2OGY2MTc0NDM5ZDg2M2M0MGNkYzJkYjBlMWI4OWQ2MjBkZDAgTW9u
IFNlcCAxNyAwMDowMDowMCAyMDAxCj4gRnJvbTogRmVuZ2h1YSBZdSA8ZmVuZ2h1YS55dUBpbnRl
bC5jb20+Cj4gRGF0ZTogRnJpLCAxNSBBcHIgMjAyMiAwMDo1MTozMyAtMDcwMAo+IFN1YmplY3Q6
IFtQQVRDSF0gaW9tbXUvc3ZhOiBGaXggUEFTSUQgdXNlLWFmdGVyLWZyZWUgaXNzdWUKPgo+IEEg
UEFTSUQgbWlnaHQgYmUgc3RpbGwgdXNlZCBvbiBBUk0gYWZ0ZXIgaXQgaXMgZnJlZWQgaW4gX19t
bXB1dCgpLgo+Cj4gcHJvY2VzczoKPiAJb3BlbigpLT5zdmFfYmluZCgpLT5pb2FzaWRfYWxsb2Mo
KSA9IE47IC8vIEdldCBQQVNJRCBOIGZvciB0aGUgbW0KPiAJZXhpdCgpOwo+IAlleGl0X21tKCkt
Pl9fbW1wdXQoKS0+bW1fcGFzaWRfZHJvcCgpLT5tbS0+cGFzaWQgPSAtMTsgLy8gUEFTSUQgLTEK
PiAJZXhpdF9maWxlcygpLT5yZWxlYXNlKGRldiktPnN2YV91bmJpbmQoKS0+dXNlIG1tLT5wYXNp
ZDsgLy8gRmFpbHVyZQo+Cj4gVG8gYXZvaWQgdGhlIHVzZS1hZnRlci1mcmVlIGlzc3VlLCBmcmVl
IHRoZSBQQVNJRCBhZnRlciBubyBkZXZpY2UgdXNlcyBpdCwKPiBpLmUuIGFmdGVyIGFsbCBkZXZp
Y2VzIGFyZSB1bmJvdW5kIGZyb20gdGhlIG1tLgo+Cj4gc3ZhX2JpbmQoKS9zdmFfdW5iaW5kKCkg
Y2FsbCBtbWdyYWIoKS9tbWRyb3AoKSB0byB0cmFjayBtbS0+bW1fY291bnQuCj4gX19tbWRyb3Ao
KSBpcyBjYWxsZWQgb25seSBhZnRlciBtbS0+bW1fY291bnQgaXMgemVyby4gU28gZnJlZWluZyB0
aGUgUEFTSUQKPiBpbiBfX21tZHJvcCgpIGd1YXJhbnRlZXMgdGhlIFBBU0lEIGlzIHNhZmVseSBm
cmVlZCBvbmx5IGFmdGVyIG5vIGRldmljZQo+IGlzIGJvdW5kIHRvIHRoZSBtbS4KPgo+IEZpeGVz
OiA3MDFmYWM0MDM4NGYgKCJpb21tdS9zdmE6IEFzc2lnbiBhIFBBU0lEIHRvIG1tIG9uIFBBU0lE
IGFsbG9jYXRpb24gYW5kIGZyZWUgaXQgb24gbW0gZXhpdCIpCj4KPiBSZXBvcnRlZC1ieTogWmhh
bmdmZWkgR2FvIDx6aGFuZ2ZlaS5nYW9AZm94bWFpbC5jb20+Cj4gU3VnZ2VzdGVkLWJ5OiBKZWFu
LVBoaWxpcHBlIEJydWNrZXIgPGplYW4tcGhpbGlwcGVAbGluYXJvLm9yZz4KPiBTdWdnZXN0ZWQt
Ynk6IEphY29iIFBhbiA8amFjb2IuanVuLnBhbkBsaW51eC5pbnRlbC5jb20+Cj4gU2lnbmVkLW9m
Zi1ieTogRmVuZ2h1YSBZdSA8ZmVuZ2h1YS55dUBpbnRlbC5jb20+ClRoYW5rcyBmb3IgdGhlIGZp
eC4KClRlc3RlZC1ieTogWmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZz4KCgo+
IC0tLQo+ICAga2VybmVsL2ZvcmsuYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9mb3JrLmMgYi9r
ZXJuZWwvZm9yay5jCj4gaW5kZXggOTc5Njg5NzU2MGFiLi4zNWEzYmVmZjE0MGIgMTAwNjQ0Cj4g
LS0tIGEva2VybmVsL2ZvcmsuYwo+ICsrKyBiL2tlcm5lbC9mb3JrLmMKPiBAQCAtNzkyLDYgKzc5
Miw3IEBAIHZvaWQgX19tbWRyb3Aoc3RydWN0IG1tX3N0cnVjdCAqbW0pCj4gICAJbW11X25vdGlm
aWVyX3N1YnNjcmlwdGlvbnNfZGVzdHJveShtbSk7Cj4gICAJY2hlY2tfbW0obW0pOwo+ICAgCXB1
dF91c2VyX25zKG1tLT51c2VyX25zKTsKPiArCW1tX3Bhc2lkX2Ryb3AobW0pOwo+ICAgCWZyZWVf
bW0obW0pOwo+ICAgfQo+ICAgRVhQT1JUX1NZTUJPTF9HUEwoX19tbWRyb3ApOwo+IEBAIC0xMTkw
LDcgKzExOTEsNiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgX19tbXB1dChzdHJ1Y3QgbW1fc3RydWN0
ICptbSkKPiAgIAl9Cj4gICAJaWYgKG1tLT5iaW5mbXQpCj4gICAJCW1vZHVsZV9wdXQobW0tPmJp
bmZtdC0+bW9kdWxlKTsKPiAtCW1tX3Bhc2lkX2Ryb3AobW0pOwo+ICAgCW1tZHJvcChtbSk7Cj4g
ICB9Cj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
