Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E44C433F5
	for <iommu@archiver.kernel.org>; Fri, 22 Apr 2022 15:51:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6DC61404F3;
	Fri, 22 Apr 2022 15:51:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jaIgAj9cKeby; Fri, 22 Apr 2022 15:51:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3CFCA4017B;
	Fri, 22 Apr 2022 15:51:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1694CC0032;
	Fri, 22 Apr 2022 15:51:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDB89C002D
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 15:51:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AABBC83ECF
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 15:51:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 76iEyNTu0iAw for <iommu@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 15:51:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DB1A0813AD
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 15:51:05 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id w4so11626947wrg.12
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 08:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=Kkx5q4bDuKIBWWRZ1iuX1/tTM3jPLbx5We3xs6gumo0=;
 b=L2VjsLIOtpktJxq3umRR7TQtnjogP9inTCc0xf3C6++XYPN3ZFi2DEEQoAd6CUfAaD
 4WZKFcd4dku3naGKn6iQZkNKRlAfbFN3wo/oknoSSfBfangVtjrtJVdrlg/cSwM76UCf
 BMT7/JMS8YxgrlPNOQ7RE+yh0LbBVcO+GFhvziU6mhyDPN9veT5tguouIvmGwZBWP+9C
 gnqaBzI1FGxkeYEbw4jJkLM01jvXMBfCF0+5IoZ/31UET+CWHMZ1q8XRTqrL25wwdcz9
 IqmASl3m8jE4BNw7mUjV5D1jYYnZQvA3Uv5JJ43jSCG8B1Ml//FhMOsa1mqpMR+hruAM
 Nvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Kkx5q4bDuKIBWWRZ1iuX1/tTM3jPLbx5We3xs6gumo0=;
 b=z7yLH7EuSaP4d5cggVdx+CzgySt36tMPXieZ2CkElnXnf1kpvDnDHw5bt4VViEUgh4
 8asFu0giJ13C6NEbendENrwd0ng0HX+pwSoHFbxNnQlaSffhzg//ffPz/k3N1k359SPP
 vw+d5YmG3TT4V52lvFGwBdweQJameQ1xobYmJT9RYnpk3Qgql1xnodJ2tBQ7T+ARAkgt
 HPR6nNAXRzCuTqDNWIOaTyLj2LwTXJvppPvV7PkeJuo3hXcb+75wDwyNLeYmdKPdS9qA
 t8NCoRQEHuklO63lYn+hox2ICAQ8TtHriMdqJXxlwu1IuH0ezd4DjWQkWdu+DMTgEAdD
 TAkg==
X-Gm-Message-State: AOAM5317tAJLbMw1Iw6OJyIfZr66DNUOFpRLnscO/edtdv70vGYiq7bt
 yJMQ7RK1Z1vCCqQw8yiRhikkuA==
X-Google-Smtp-Source: ABdhPJw4SOIGlvN2+JSfHf5lo2bGhXRf89s6K7ZbmqtrpaHqxjTmU6l+goCUsrHOQd9TZFkN8zME9A==
X-Received: by 2002:a05:6000:1287:b0:209:16c7:16af with SMTP id
 f7-20020a056000128700b0020916c716afmr4368691wrx.702.1650642664100; 
 Fri, 22 Apr 2022 08:51:04 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 u20-20020a05600c19d400b003929c4bf23asm1858009wmq.44.2022.04.22.08.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Apr 2022 08:51:03 -0700 (PDT)
Date: Fri, 22 Apr 2022 16:50:38 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Subject: Re: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YmLOznyBF0f7COYT@myrica>
References: <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com> <YmA4pbgevqln/jSO@myrica>
 <tencent_76E043C4D1B6A21A5253579A61034107EB06@qq.com>
 <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com>
 <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, robin.murphy@arm.com,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 zhangfei.gao@linaro.org, Thomas Gleixner <tglx@linutronix.de>, will@kernel.org
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

T24gRnJpLCBBcHIgMjIsIDIwMjIgYXQgMDk6MTU6MDFQTSArMDgwMCwgemhhbmdmZWkuZ2FvQGZv
eG1haWwuY29tIHdyb3RlOgo+ID4gSSdtIHRyeWluZyB0byBwaWVjZSB0b2dldGhlciB3aGF0IGhh
cHBlbnMgZnJvbSB0aGUga2VybmVsIHBvaW50IG9mIHZpZXcuCj4gPiAKPiA+ICogbWFzdGVyIHBy
b2Nlc3Mgd2l0aCBtbSBBIG9wZW5zIGEgcXVldWUgZmQgdGhyb3VnaCB1YWNjZSwgd2hpY2ggY2Fs
bHMKPiA+ICAgIGlvbW11X3N2YV9iaW5kX2RldmljZShkZXYsIEEpIC0+IFBBU0lEIDEKPiA+IAo+
ID4gKiBtYXN0ZXIgZm9ya3MgYW5kIGV4aXRzLiBDaGlsZCAoZGFlbW9uKSBnZXRzIG1tIEIsIGlu
aGVyaXRzIHRoZSBxdWV1ZSBmZC4KPiA+ICAgIFRoZSBkZXZpY2UgaXMgc3RpbGwgYm91bmQgdG8g
bW0gQSB3aXRoIFBBU0lEIDEsIHNpbmNlIHRoZSBxdWV1ZSBmZCBpcwo+ID4gICAgc3RpbGwgb3Bl
bi4KPiAKPiA+IFdlIGRpc2N1c3NlZCB0aGlzIGJlZm9yZSwgYnV0IEkgZG9uJ3QgcmVtZW1iZXIg
d2hlcmUgd2UgbGVmdCBvZmYuIFRoZQo+ID4gY2hpbGQgY2FuJ3QgdXNlIHRoZSBxdWV1ZSBiZWNh
dXNlIGl0cyBtYXBwaW5ncyBhcmUgbm90IGNvcGllZCBvbiBmb3JrKCksCj4gPiBhbmQgdGhlIHF1
ZXVlIGlzIHN0aWxsIGJvdW5kIHRvIHRoZSBwYXJlbnQgbW0gQS4gVGhlIGNoaWxkIGVpdGhlciBu
ZWVkcyB0bwo+ID4gb3BlbiBhIG5ldyBxdWV1ZSBvciB0YWtlIG93bmVyc2hpcCBvZiB0aGUgb2xk
IG9uZSB3aXRoIGEgbmV3IHVhY2NlIGlvY3RsLgo+IFllcywgY3VycmVudGx5IG5naW54IGFsaWdu
ZWQgd2l0aCB0aGUgY2FzZS4KPiBDaGlsZCBwcm9jZXNzICh3b3JrZXIgcHJvY2VzcykgcmVvcGVu
IHVhY2NlLAo+IAo+IE1hc3RlciBwcm9jZXNzIChkbyBpbml0KSBvcGVuIHVhY2NlLCBpb21tdV9z
dmFfYmluZF9kZXZpY2UoZGV2LCBBKSAtPiBQQVNJRAo+IDEKPiBNYXN0ZXIgcHJvY2VzcyBmb3Jr
IENoaWxkIChkYWVtb24pIGFuZCBleGl0Lgo+IAo+IENoaWxkIChkYWVtb24pwqAgZG9lcyBub3Qg
dXNlIFBBU0lEIDEgYW55IG1vcmUsIG9ubHkgZm9yayBhbmQgbWFuYWdlIHdvcmtlcgo+IHByb2Nl
c3MuCj4gV29ya2VyIHByb2Nlc3MgcmVvcGVuIHVhY2NlLCBpb21tdV9zdmFfYmluZF9kZXZpY2Uo
ZGV2LCBCKSBQQVNJRCAyCj4gCj4gU28gaXQgaXMgZXhwZWN0ZWQuCgpZZXMsIHRoYXQncyBmaW5l
Cgo+ID4gSXMgdGhhdCB0aGUgIklNUExFTUVOVF9EWU5BTUlDX0JJTkRfRk4oKSIgeW91IG1lbnRp
b24sIHNvbWV0aGluZyBvdXQgb2YKPiA+IHRyZWU/ICBUaGlzIG9wZXJhdGlvbiBzaG91bGQgdW5i
aW5kIGZyb20gQSBiZWZvcmUgYmluZGluZyB0byBCLCBubz8KPiA+IE90aGVyd2lzZSB3ZSBsZWFr
IFBBU0lEIDEuCj4gSW4gNS4xNiBQQVNJRCAxIGZyb20gbWFzdGVyIGlzIGhvbGQgdW50aWwgbmdp
bnggc2VydmljZSBzdG9wLgo+IG5naW54IHN0YXJ0Cj4gbWFzdGVyOgo+IGlvbW11X3N2YV9hbGxv
Y19wYXNpZCBtbS0+cGFzaWQ9McKgwqDCoCDCoCAvLyBtYXN0ZXIgcHJvY2Vzcwo+IAo+IGx5bngg
aHR0cHMgc3RhcnQ6Cj4gaW9tbXVfc3ZhX2FsbG9jX3Bhc2lkIG1tLT5wYXNpZD0ywqDCoMKgIC8v
d29ya2VyIHByb2Nlc3MKPiAKPiBuZ2lueCBzdG9wOsKgIGZyb20gZm9wc19yZWxlYXNlCj4gaW9t
bXVfc3ZhX2ZyZWVfcGFzaWQgbW0tPnBhc2lkPTLCoMKgIC8vIHdvcmtlciBwcm9jZXNzCj4gaW9t
bXVfc3ZhX2ZyZWVfcGFzaWQgbW0tPnBhc2lkPTHCoCAvLyBtYXN0ZXIgcHJvY2VzcwoKVGhhdCdz
IHRoZSBleHBlY3RlZCBiZWhhdmlvciAobWFzdGVyIGNvdWxkIGNsb3NlIGl0cyBmZCBiZWZvcmUg
Zm9ya2luZywgaW4Kb3JkZXIgdG8gZnJlZSB0aGluZ3MgdXAgZWFybGllciwgYnV0IGl0J3Mgbm90
IG1hbmRhdG9yeSkKCj4gSGF2ZSBvbmUgc2lsbHkgcXVlc3Rpb24uCj4gCj4ga2VybmUgZHJpdmVy
Cj4gZm9wc19vcGVuCj4gaW9tbXVfc3ZhX2JpbmRfZGV2aWNlCj4gCj4gZm9wc19yZWxlYXNlCj4g
aW9tbXVfc3ZhX3VuYmluZF9kZXZpY2UKPiAKPiBhcHBsaWNhdGlvbgo+IG1haW4oKQo+IGZkID0g
b3Blbgo+IHJldHVybjsKPiAKPiBBcHBsaWNhdGlvbiBleGl0IGJ1dCBub3QgY2xvc2UoZmQpLCBp
cyBpdCBleHBlY3RlZCBmb3BzX3JlbGVhc2Ugd2lsbCBiZQo+IGNhbGxlZCBhdXRvbWF0aWNhbGx5
IGJ5IHN5c3RlbT8KClllcywgdGhlIGFwcGxpY2F0aW9uIGRvZXNuJ3QgaGF2ZSB0byBjYWxsIGNs
b3NlKCkgZXhwbGljaXRseSwgdGhlIGZpbGUKZGVzY3JpcHRvciBpcyBjbG9zZWQgYXV0b21hdGlj
YWxseSBvbiBleGl0LiBOb3RlIHRoYXQgdGhlIGZkIGlzIGNvcGllZCBvbgpmb3JrKCksIHNvIGl0
IGlzIG9ubHkgcmVsZWFzZWQgb25jZSBwYXJlbnQgYW5kIGFsbCBjaGlsZCBwcm9jZXNzZXMgZXhp
dC4KCj4gT24gNS4xNwo+IGZvcHNfcmVsZWFzZSBpcyBjYWxsZWQgYXV0b21hdGljYWxseSwgYXMg
d2VsbCBhcyBpb21tdV9zdmFfdW5iaW5kX2RldmljZS4KPiBPbiA1LjE4LXJjMS4KPiBmb3BzX3Jl
bGVhc2UgaXMgbm90IGNhbGxlZCwgaGF2ZSB0byBtYW51YWxseSBjYWxsIGNsb3NlKGZkKQoKUmln
aHQgdGhhdCdzIHdlaXJkCgo+IFNpbmNlIG5naW54IG1heSBoYXZlIGEgaXNzdWUsIGl0IGRvZXMg
bm90IGNhbGwgY2xvc2UoZmQpIHdoZW4gbmdpbnggLXMgcXVpdC4KCkFuZCB5b3UncmUgc3VyZSB0
aGF0IG5vbmUgb2YgdGhlIHByb2Nlc3NlcyBhcmUgc3RpbGwgYWxpdmUgb3IgaW4gem9tYmllCnN0
YXRlPyAgSnVzdCB0byBjb3ZlciBldmVyeSBwb3NzaWJpbGl0eS4KClRoYW5rcywKSmVhbgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
