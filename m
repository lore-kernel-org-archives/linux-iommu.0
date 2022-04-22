Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92ACAC433EF
	for <iommu@archiver.kernel.org>; Fri, 22 Apr 2022 10:12:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CA5984356;
	Fri, 22 Apr 2022 10:12:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S2uFtzqAUfG2; Fri, 22 Apr 2022 10:12:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0DD3184196;
	Fri, 22 Apr 2022 10:12:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC955C0032;
	Fri, 22 Apr 2022 10:12:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 388F8C002D
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 10:12:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 33DCF60E3B
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 10:12:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nwLmqz-qvJ6J for <iommu@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 10:12:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1083360C06
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 10:12:05 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-e5c42b6e31so8108004fac.12
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 03:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=i1wvp/rMewldxZ0rnVdiAJj3COxTfU55vw1I4L2ncZk=;
 b=dSPNUihNFKJl2Ne2hHey/V1kYCou0YMDG0mqsnp6QGgS3IqT1v9FT7iXHLIi1UcjUa
 dhy/l5XsnqM7w7fYMZAE+3yd0yy4QYaO/Ze+Y5EvauCnnwrFiwudmO6g8Yyf+vg5BXaH
 xyhUe2wG0e+gbMrUb8qRg8+jM3QlELJYsImn7saAM/rOOtYbYFqwWdo41bXCuJxcTjSo
 Vn2iLM50cI8zznVqStbswK7VHCjSef6WXDx64rdU8gmGJxV6UPgzV0Zm6WuQDb3vVImA
 3SorBuF9MrcCOD7F6Za5XYtmc1jUITF1vxOYbP6Q5M9WcfiuhSuDLKMpirrxgNGviBQm
 xJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=i1wvp/rMewldxZ0rnVdiAJj3COxTfU55vw1I4L2ncZk=;
 b=39qaB4efWy1vogc3K6BrVeGhRj2FX7sr2rjLIq4zUig97q5gpY+vs4OPG1YvCSzgiE
 g2UEB1fsRv+Otm2XwNQqg4fjXwoqRE9erJsj5W6JvWB4OsnedMAismh+LazcDIf7bQM7
 JS39ul7hURIA0aT1J4DeuVAwQSyGj45kgW6cLEW5AfpisbyLeUBrb5250tXk4n3gKgLj
 pA7shIkpEWK326DdfS7KKLoV/1H2mvPOeDmhVvn+Syz7e4Og5nHByePy6ST3mhRzajMJ
 rcfT68g/jHidQTspxRldcbS7RyF38fk5pOWwntri4/If+vXh4n1ti+HiKq60Y2bRNdzb
 diYg==
X-Gm-Message-State: AOAM530Tv/5YszeuDSW+eIU5CoIDlkNivslf9Yc2BVXOeZtnPKBSwSQv
 WwWsf/ZWqWI0TU8P98dEr7NPUw==
X-Google-Smtp-Source: ABdhPJzZlughfLG8zc4bXFQPyY9X+tGSojEhYDQgJCScCNW6X0OFmMRS1v+Mrm+vKTlKn80ATyKA/A==
X-Received: by 2002:a05:6870:524b:b0:e5:f7a6:295f with SMTP id
 o11-20020a056870524b00b000e5f7a6295fmr1552227oai.89.1650622324966; 
 Fri, 22 Apr 2022 03:12:04 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 a11-20020a056830008b00b0060546411473sm555228oto.75.2022.04.22.03.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Apr 2022 03:12:04 -0700 (PDT)
Date: Fri, 22 Apr 2022 11:11:36 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YmJ/WA6KAQU/xJjA@myrica>
References: <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com> <YmA4pbgevqln/jSO@myrica>
 <tencent_76E043C4D1B6A21A5253579A61034107EB06@qq.com>
 <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, robin.murphy@arm.com,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, will@kernel.org
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

T24gRnJpLCBBcHIgMjIsIDIwMjIgYXQgMDU6MDM6MTBQTSArMDgwMCwgemhhbmdmZWkuZ2FvQGZv
eG1haWwuY29tIHdyb3RlOgpbLi4uXQo+ID4gSGF2ZSB0ZXN0ZWQsIHN0aWxsIGdvdCBzb21lIGlz
c3VlIHdpdGggb3VyIG9wZW5zc2wtZW5naW5lLgo+ID4gCj4gPiAxLiBJZiBvcGVuc3NsLWVuZ2lu
ZSBkb2VzIG5vdCByZWdpc3RlciByc2EsIG5naW54IHdvcmtzIHdlbGwuCj4gPiAKPiA+IDIuIElm
IG9wZW5zc2wtZW5naW5lIHJlZ2lzdGVyIHJzYSwgbmdpbnggYWxzbyB3b3JrcywgYnV0IGlvYXNp
ZCBpcyBub3QKPiA+IGZyZWVkIHdoZW4gbmdpbnggc3RvcC4KPiA+IAo+ID4gSU1QTEVNRU5UX0RZ
TkFNSUNfQklORF9GTihiaW5kX2ZuKQo+ID4gYmluZF9mbgo+ID4gRU5HSU5FX3NldF9SU0EoZSwg
cnNhX21ldGhvZHMoKSkKPiA+IAo+ID4gZGVzdHJveV9mbgo+ID4gCj4gPiBJZiBFTkdJTkVfc2V0
X1JTQSBpcyBzZXQsIG5naW54IHN0YXJ0IGFuZCBzdG9wIHdpbGwgTk9UIGNhbGwgZGVzdHJveV9m
bi4KPiA+IEV2ZW4gcnNhX21ldGhvZHMgaXMgYWxtb3N0IG5ldyB2aWEgUlNBX21ldGhfbmV3Lgo+
ID4gCj4gPiBJbiA1LjE4LXJjeCwgdGhpcyBjYXVzZWQgaW9hc2lkwqAgbm90IGZyZWVkIGluIG5n
aW54IHN0YXJ0IGFuZCBzdG9wLgo+ID4gSW4gNS4xNywgdGhvdWdoIGRlc3Ryb3lfZm4gaXMgbm90
IGNhbGxlZCwgYnV0IGlvYXNpZCBpcyBmcmVlZCB3aGVuIG5naW54Cj4gPiBzdG9wLCBzbyBub3Qg
bm90aWNlZCB0aGlzIGlzc3VlIGJlZm9yZS4KPiAKPiAxLiB1YWNjZV9mb3BzX3JlbGVhc2UKPiBJ
biA1LjE2IG9yIDUuMTcKPiBJbiBmYWN0LCB3ZSBhc2xvIGhhcyB0aGUgaXNzdWU6IG9wZW5zc2wg
ZW5naW5lIGRvZXMgbm90IGNhbGwgZGVzdHJveV9mbiAtPgo+IGNsb3NlKHVhY2NlX2ZkKQo+IEJ1
dCBzeXN0ZW0gd2lsbCBhdXRvbWF0aWNhbGx5IGNsb3NlIGFsbCBvcGVuZWQgZmQsCj4gc28gdWFj
Y2VfZm9wc19yZWxlYXNlIGlzIGFsc28gY2FsbGVkIGFuZCBmcmVlIGlvYXNpZC4KPiAKPiBIYXZl
IG9uZSBleHBlcmltZW50LCBub3QgY2FsbCBjbG9zZSBmZAo+IAo+IGxvZzogb3BlbiB1YWNjZSBm
ZCBidXQgbm8gY2xvc2UKPiBbIDI1ODMuNDcxMjI1XcKgIGR1bXBfYmFja3RyYWNlKzB4MC8weDFh
MAo+IFsgMjU4My40NzQ4NzZdwqAgc2hvd19zdGFjaysweDIwLzB4MzAKPiBbIDI1ODMuNDc4MTc4
XcKgIGR1bXBfc3RhY2tfbHZsKzB4OGMvMHhiOAo+IFsgMjU4My40ODE4MjVdwqAgZHVtcF9zdGFj
aysweDE4LzB4MzQKPiBbIDI1ODMuNDg1MTI2XcKgIHVhY2NlX2ZvcHNfcmVsZWFzZSsweDQ0LzB4
ZGMKPiBbIDI1ODMuNDg5MTE3XcKgIF9fZnB1dCsweDc4LzB4MjQwCj4gWyAyNTgzLjQ5MjE1OV3C
oCBfX19fZnB1dCsweDE4LzB4MjgKPiBbIDI1ODMuNDk1Mjg4XcKgIHRhc2tfd29ya19ydW4rMHg4
OC8weDE2MAo+IFsgMjU4My40OTg5MzZdwqAgZG9fbm90aWZ5X3Jlc3VtZSsweDIxNC8weDQ5MAo+
IFsgMjU4My41MDI5MjddwqAgZWwwX3N2YysweDU4LzB4NzAKPiBbIDI1ODMuNTA1OTY4XcKgIGVs
MHRfNjRfc3luY19oYW5kbGVyKzB4YjAvMHhiOAo+IFsgMjU4My41MTAxMzJdwqAgZWwwdF82NF9z
eW5jKzB4MWEwLzB4MWE0Cj4gWyAyNTgzLjU4MjI5Ml3CoCB1YWNjZV9mb3BzX3JlbGVhc2UgcT0w
MDAwMDAwMGQ2Njc0MTI4Cj4gCj4gSW4gNS4xOCwgc2luY2UgcmVmY291bnQgd2FzIGFkZC4KPiBU
aGUgb3BlbmVkIHVhY2NlIGZkIHdhcyBub3QgY2xvc2VkIGF1dG9tYXRpY2FsbHkgYnkgc3lzdGVt
Cj4gU28gd2Ugc2VlIHRoZSBpc3N1ZS4KPiAKPiBsb2c6IG9wZW4gdWFjY2UgZmQgYnV0IG5vIGNs
b3NlCj4gwqBbwqAgMTA2LjM2MDE0MF3CoCB1YWNjZV9mb3BzX29wZW4gcT0wMDAwMDAwMGNjYzM4
ZDc0Cj4gW8KgIDEwNi4zNjQ5MjldwqAgaW9hc2lkX2FsbG9jIGlvYXNpZD0xCj4gW8KgIDEwNi4z
Njg1ODVdwqAgaW9tbXVfc3ZhX2FsbG9jX3Bhc2lkIHBhc2lkPTEKPiBbwqAgMTA2LjM3Mjk0M13C
oCBpb21tdV9zdmFfYmluZF9kZXZpY2UgaGFuZGxlPTAwMDAwMDAwNmNjYTI5OGEKPiAvLyBpb2Fz
aWQgaXMgbm90IGZyZWUKCkknbSB0cnlpbmcgdG8gcGllY2UgdG9nZXRoZXIgd2hhdCBoYXBwZW5z
IGZyb20gdGhlIGtlcm5lbCBwb2ludCBvZiB2aWV3LgoKKiBtYXN0ZXIgcHJvY2VzcyB3aXRoIG1t
IEEgb3BlbnMgYSBxdWV1ZSBmZCB0aHJvdWdoIHVhY2NlLCB3aGljaCBjYWxscwogIGlvbW11X3N2
YV9iaW5kX2RldmljZShkZXYsIEEpIC0+IFBBU0lEIDEKCiogbWFzdGVyIGZvcmtzIGFuZCBleGl0
cy4gQ2hpbGQgKGRhZW1vbikgZ2V0cyBtbSBCLCBpbmhlcml0cyB0aGUgcXVldWUgZmQuCiAgVGhl
IGRldmljZSBpcyBzdGlsbCBib3VuZCB0byBtbSBBIHdpdGggUEFTSUQgMSwgc2luY2UgdGhlIHF1
ZXVlIGZkIGlzCiAgc3RpbGwgb3Blbi4KCldlIGRpc2N1c3NlZCB0aGlzIGJlZm9yZSwgYnV0IEkg
ZG9uJ3QgcmVtZW1iZXIgd2hlcmUgd2UgbGVmdCBvZmYuIFRoZQpjaGlsZCBjYW4ndCB1c2UgdGhl
IHF1ZXVlIGJlY2F1c2UgaXRzIG1hcHBpbmdzIGFyZSBub3QgY29waWVkIG9uIGZvcmsoKSwKYW5k
IHRoZSBxdWV1ZSBpcyBzdGlsbCBib3VuZCB0byB0aGUgcGFyZW50IG1tIEEuIFRoZSBjaGlsZCBl
aXRoZXIgbmVlZHMgdG8Kb3BlbiBhIG5ldyBxdWV1ZSBvciB0YWtlIG93bmVyc2hpcCBvZiB0aGUg
b2xkIG9uZSB3aXRoIGEgbmV3IHVhY2NlIGlvY3RsLgpJcyB0aGF0IHRoZSAiSU1QTEVNRU5UX0RZ
TkFNSUNfQklORF9GTigpIiB5b3UgbWVudGlvbiwgc29tZXRoaW5nIG91dCBvZgp0cmVlPyAgVGhp
cyBvcGVyYXRpb24gc2hvdWxkIHVuYmluZCBmcm9tIEEgYmVmb3JlIGJpbmRpbmcgdG8gQiwgbm8/
Ck90aGVyd2lzZSB3ZSBsZWFrIFBBU0lEIDEuCgpUaGFua3MsCkplYW4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
