Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA117C433FE
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 15:10:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C021416EA;
	Tue, 12 Apr 2022 15:10:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IBsVl7xPgCRI; Tue, 12 Apr 2022 15:10:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 13978410A8;
	Tue, 12 Apr 2022 15:10:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E01EEC0033;
	Tue, 12 Apr 2022 15:10:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4734C002C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 15:10:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9121F40AF6
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 15:10:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X8q8PQo1XNdQ for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 15:10:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8382640AF2
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 15:10:39 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id w4so28114884wrg.12
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 08:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=dEtehde5cjGV9pdbeDZJ5mEUZSUw1tlthJqoKML+g0Y=;
 b=s8XYPFWdR/OTPJ6iEZkbBH/vpqPUQtbWi53fsalJbS859W1hri0trBZxuGteCEYa+i
 yy+syBRWikaBvxxDHOjBHYOaH/4JLGAETkbrCESo9iBj3GZi64wKtbfrViJ6egTOpQJi
 JUB9ZzMp6x7pza38q9oZ61TQrEeiXBBXFhKrd6nitj2xpI2tOoaWqG3UnsQC0oknQmVe
 PUYBNANDe28bVNmPEVgLFbVxK6SuLDBwsRgtCXcJRLJJNb2biW3TG/KISgWWHLyqdEH6
 oZ82VifUj+zzzeGeV+76S1jOksa4ffRMIP31I7YQzYWcffdhE/cvx6JxVqj9uN5P3a+b
 jsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=dEtehde5cjGV9pdbeDZJ5mEUZSUw1tlthJqoKML+g0Y=;
 b=NpGcX8B78G0LJiZ1ccqss+v4FL7JTyJ3nhHt21oGH3azDHUBlvAhjg/wiF4oHeUB/C
 d79/GWu5oCbaX2hxC+3N+D9TbU/9wlLqW6EAi7U/f+y7g65ZgrPMh1yD+M6MH+2srbYy
 PQXqp0828ENU7xKaoDnw0nLz+MIFbYLn1FIDM6sbUhHk8XOBrK8LIUV7tw68/dEXNryv
 yI4zwMcvnIe00Lnw1esNT8AsB9i79AksJoYO/blHCExBJdCj8wmCwk+aBuvoZXnyOwZp
 vL8p8XEyB85tf8K0oJ1i6k2zvyCYEZe5rjK7ISO5xdGCD663Wa1P5S/cIct6Tw2XujBB
 db6Q==
X-Gm-Message-State: AOAM533ZBKYW1jp2F6WORUaFzdwgtmUb3r0SNiB/afI4l+NqWgr3Wbq7
 sMiGbzXpEJMQYNm9m9p+Bm014Q==
X-Google-Smtp-Source: ABdhPJxARVef1Vp4HZQigFUbuclyFy1JIKJ4EXgGWuOZuSSbfh2u5nsKVKaKRtyYqKkM3QIJpO8maQ==
X-Received: by 2002:a5d:434f:0:b0:205:f514:8955 with SMTP id
 u15-20020a5d434f000000b00205f5148955mr30114394wrr.73.1649776237535; 
 Tue, 12 Apr 2022 08:10:37 -0700 (PDT)
Received: from larix (2a02-8428-1671-f801-d2dc-0c7f-2134-46d0.rev.sfr.net.
 [2a02:8428:1671:f801:d2dc:c7f:2134:46d0])
 by smtp.gmail.com with ESMTPSA id
 s1-20020adfb781000000b002060d4a8bd9sm24787772wre.17.2022.04.12.08.10.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Apr 2022 08:10:36 -0700 (PDT)
Date: Tue, 12 Apr 2022 16:10:34 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YlWWavIDMNpbD3Ye@larix>
References: <20220207230254.3342514-6-fenghua.yu@intel.com>
 <Ygt4h0PgYzKOiB38@8bytes.org>
 <tencent_F6830A1196DB4C6A904D7C691F0D961D1108@qq.com>
 <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
 <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <41ed3405-66d9-0cde-fc01-b3eacb85a081@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <41ed3405-66d9-0cde-fc01-b3eacb85a081@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
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

SGksCgpPbiBUdWUsIEFwciAxMiwgMjAyMiBhdCAwNzozNjoyMUFNIC0wNzAwLCBEYXZlIEhhbnNl
biB3cm90ZToKPiBPbiA0LzEyLzIyIDAwOjA0LCB6aGFuZ2ZlaS5nYW9AZm94bWFpbC5jb20gd3Jv
dGU6Cj4gPiBtYXN0ZXIgcHJvY2VzcyBxdWl0LCBtbXB1dCAtPsKgIG1tX3Bhc2lkX2Ryb3AtPmlv
YXNpZF9mcmVlCj4gPiBCdXQgdGhpcyBpZ25vcmUgZHJpdmVyJ3MgaW9tbXVfc3ZhX3VuYmluZF9k
ZXZpY2UgZnVuY3Rpb24sCj4gPiBpb21tdV9zdmFfYmluZF9kZXZpY2UgYW5kIGlvbW11X3N2YV91
bmJpbmRfZGV2aWNlIGFyZSBub3QgcGFpcizCoCBTbwo+ID4gZHJpdmVyIGRvZXMgbm90IGtub3cg
aW9hc2lkIGlzIGZyZWVkLgo+ID4gCj4gPiBBbnkgc3VnZ2VzdGlvbj8KPiAKPiBJdCBzb3VuZHMg
bGlrZSB5b3UncmUgc2F5aW5nIHRoYXQgdGhlIGRldmljZSBpcyBzdGlsbCBhYm91bmQgdG8gdGhl
Cj4gUEFTSUQgZXZlbiB0aG91Z2ggdGhlIG1tIGhhcyBleGl0ZWQgYW5kIGZyZWVkIHRoZSBQQVNJ
RC4gIFRoaXMgaXMKPiBlc3NlbnRpYWxseSBhIHVzZS1hZnRlci1mcmVlIGZvciB0aGUgUEFTSUQu
ICBSaWdodD8KPiAKPiBUaGUgcmlnaHQgdGhpbmcgdG8gZG8gaGVyZSBpcyB0byBoYXZlIHRoZSBQ
QVNJRCBjb2RlIGhvbGQgYSByZWZlcmVuY2Ugb24KPiB0aGUgbW0uICBUaGUgbW0gIm93bnMiIHRo
ZSBQQVNJRCBmb3IgaXRzIGVudGlyZSBsaWZldGltZSBhbmQgaWYgYW55dGhpbmcKPiBuZWVkcyB0
aGUgUEFTSUQgdG8gbGl2ZSBsb25nZXIsIGl0cyBvbmx5IHJlY291cnNlIGZvciBkb2luZyB0aGF0
IGlzIHZpYQo+IGFuIG1tZ2V0KCkuICBJIF90aGlua18gbW1nZXQoKSBpcyB0aGUgcmlnaHQgdGhp
bmcgYXMgb3Bwb3NlZCB0byBtbWdyYWIoKQo+IGJlY2F1c2UgdGhlIFBBU0lEIHVzZXJzIGFjdHVh
bGx5IG5lZWQgdGhlIHBhZ2UgdGFibGVzIHRvIGJlIGFyb3VuZC4KPiAKPiBUaGlzIHdvdWxkIHN0
aWxsIGJlIG5pY2UgdG8gY29uZmlybSB3aXRoIHNvbWUgdHJhY2VzIG9mIGZvcmsoKS9leGl0KCkK
PiBhbmQgdGhlIGlvbW11X3N2YV97YmluZCx1bmJpbmR9IGFuZCBpb2FzaWRfe2FsbG9jLGZyZWV9
IGZ1bmN0aW9ucy4KPiAKPiBJIHdvbmRlciBpZiB0aGUgSW50ZWwgYW5kIEFSTSBJT01NVSBjb2Rl
IGRpZmZlciBpbiB0aGUgd2F5IHRoZXkga2VlcAo+IHJlZmVyZW5jZXMgdG8gdGhlIG1tLCBvciBp
ZiB0aGlzIGFmZmVjdHMgSW50ZWwgYXMgd2VsbCwgYnV0IHdlIGp1c3QKPiBoYXZlbid0IHRlc3Rl
ZCB0aGUgY29kZSBlbm91Z2guCgpUaGUgQXJtIGNvZGUgd2FzIHdyaXR0ZW4gZXhwZWN0aW5nIHRo
ZSBQQVNJRCB0byBiZSBmcmVlZCBvbiB1bmJpbmQoKSwgbm90Cm1tIGV4aXQuIEkgbWlzc2VkIHRo
ZSBjaGFuZ2Ugb2YgYmVoYXZpb3IsIHNvcnJ5IChJIHRob3VnaHQgeW91ciBwbGFuIHdhcwp0byBl
eHRlbmQgUEFTSUQgbGlmZXRpbWUsIG5vdCBzaG9ydGVuIGl0PykgYnV0IGFzIGlzIGl0IHNlZW1z
IHZlcnkgYnJva2VuLgpGb3IgZXhhbXBsZSBpbiB0aGUgaW9tbXVfc3ZhX3VuYmluZF9kZXZpY2Uo
KSwgd2UgaGF2ZQphcm1fc21tdV9tbXVfbm90aWZpZXJfcHV0KCkgY2xlYXJpbmcgdGhlIFBBU0lE
IHRhYmxlIGVudHJ5IGZvcgoibW0tPnBhc2lkIiwgd2hpY2ggaXMgZ29pbmcgdG8gZW5kIGJhZGx5
IGlmIHRoZSBQQVNJRCBoYXMgYmVlbiBjbGVhcmVkIG9yCnJlYWxsb2NhdGVkLiBXZSBjYW4ndCBj
bGVhciB0aGUgUEFTSUQgZW50cnkgaW4gbW0gZXhpdCBiZWNhdXNlIGF0IHRoYXQKcG9pbnQgdGhl
IGRldmljZSBtYXkgc3RpbGwgYmUgaXNzdWluZyBETUEgZm9yIHRoYXQgUEFTSUQgYW5kIHdlIG5l
ZWQgdG8KcXVpZXNjZSB0aGUgZW50cnkgcmF0aGVyIHRoYW4gZGVhY3RpdmF0ZSBpdC4gV2UgY2Fu
IG9ubHkgZGVhY3RpdmF0ZSBpdApvbmNlIHRoZSBkZXZpY2UgZHJpdmVyIGhhcyBwcm9wZXJseSBz
dG9wcGVkIHRoZSBkZXZpY2UsIGF0IHdoaWNoIHBvaW50IGl0CmNhbiBjYWxsIHVuYmluZCgpLiBU
aGVyZSBtYXkgYmUgb3RoZXIgaXNzdWVzIGJ1dCBJIGNhbid0IGNoZWNrIGl0CnRob3JvdWdobHkg
dW50aWwgbmV4dCB3ZWVrLgoKVGhhbmtzLApKZWFuCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
