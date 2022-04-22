Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3639BC433F5
	for <iommu@archiver.kernel.org>; Fri, 22 Apr 2022 13:16:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE44041C1A;
	Fri, 22 Apr 2022 13:16:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DWdXZfYmUVQ0; Fri, 22 Apr 2022 13:16:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 395E041C0D;
	Fri, 22 Apr 2022 13:16:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C949C0032;
	Fri, 22 Apr 2022 13:16:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3C10C002D
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 13:16:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D77E160FF9
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 13:16:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=foxmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CDP7Xa4K2w6w for <iommu@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 13:16:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com
 [203.205.221.191])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2FABA611D2
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 13:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1650633387;
 bh=zHuVbfzAKZiFcRUPtMifpg9OMMsnImpLTfyM0BnWlmA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To;
 b=JpM2jbLrWEDA/4482ARKPzr4lFnXh8dCmUhIdYCVC+O2+F5NCST739MPjeIKFd1KF
 4W4Okbji/iqOHUtcP4VL/0wd0eBdEudbuynLoD2lnwBmgAVzW1Iww1v1G51CyBQSbw
 7lvuhovnHDspOHqLtFyuBLVD/cEmkmg73fmV5Z1k=
Received: from [IPv6:240e:362:431:df00:2955:4366:920b:947f]
 ([240e:362:431:df00:2955:4366:920b:947f])
 by newxmesmtplogicsvrszb7.qq.com (NewEsmtp) with SMTP
 id 3C1AA630; Fri, 22 Apr 2022 21:15:01 +0800
X-QQ-mid: xmsmtpt1650633301tpw3lamyh
Message-ID: <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
X-QQ-XMAILINFO: M3Q/Kj4zjy60MwLBIzDEpzcu0q0dCeG+7LBaVLJxTyHvdg7eFxtj2IAvTPibBG
 cutfshSKICOuznttU/zQYoszxm2DpOEH0jfNGHe/AR7LqxPhcJIEONMIqxGEANtgve0cb6bUrdwH
 9juZK34jmyNDBOSQc2AQ9F33I1Cq6YiZch4GLyhQ1zmiEuAoQp1+TQ3dnjvl3yRJ3cDPq87rJuKk
 odize4VF1jy6KbupsTB6BTmYZ24Mx7uRy+yLsQsfOC9u9nmGWpA9p95Y4F6bJYMOzbHNNImYRXt+
 iHj5jdKhiE6EYHCKg+V/gByOnTMjuhciwiz9nY5LiHHXHu8yvamnb9JTAAjJPdMx/cqVwjC2VXyf
 yibw6hEqdNAbnRmQbkmZtjjL3on+gBqwOWJpVyyqGsVT4Du3T97mZSA7vuLvggR3sEjOcrIsINuV
 SJFBcSmPmMchqJTl+CDW3TCoaafT3C6MBAzIcHylo0SCqnY40yIAUhr6A3lPIJlvNhCfsU9wfIoc
 uShyp3yon/pCl91B1dCNzCYOTq1bjhPcRDtw/UghGgps1qYnRdJGeRj1fj+lqkw0ZC/A7hB4tM7b
 iISypXFAsa+QlEJ3REPpjVdkcH8orRmB5/ZlMy8uwhqWY+p/32vYhE4WFVczSO6h3h8rAmH3+xpU
 7DtIxspmKj/iR70sIj9fzPUG9f1a1qvJqZr4R7NqKRTmTcy1eih+L4jlzJUozhr/3zw9UQOhb3DQ
 cz3w87JxUO58PKo9lHi6xIsBS/pV8qy8XovoSIBSQkDIBuTCc6AKOi4NLSC2kgYa9ZpLo6s9o+jm
 JKi1xwp+8lzxByg0mjH3lvkOGCU2Mz+3f90hCw+RQUYvm1OwNkSAgqj3oFmQdGFRExvcM5uW7OSJ
 rqnJ3xoigFekgX3FHdGUTpnsm9qzy5OqwQGoThjfigCXWNqfF67x5zDCmTw15Pr2YIyTSdecJN6I
 AN3VetOxneOt/RbEYpF4mKbHR4RuTn
Subject: Re: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com> <YmA4pbgevqln/jSO@myrica>
 <tencent_76E043C4D1B6A21A5253579A61034107EB06@qq.com>
 <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com>
 <YmJ/WA6KAQU/xJjA@myrica>
From: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <dda655fc-7776-6d4d-0506-1443bb6c8b21@foxmail.com>
Date: Fri, 22 Apr 2022 21:15:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YmJ/WA6KAQU/xJjA@myrica>
Content-Language: en-US
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CkhpLCBKZWFuCgpPbiAyMDIyLzQvMjIg5LiL5Y2INjoxMSwgSmVhbi1QaGlsaXBwZSBCcnVja2Vy
IHdyb3RlOgo+IE9uIEZyaSwgQXByIDIyLCAyMDIyIGF0IDA1OjAzOjEwUE0gKzA4MDAsIHpoYW5n
ZmVpLmdhb0Bmb3htYWlsLmNvbSB3cm90ZToKPiBbLi4uXQo+Pj4gSGF2ZSB0ZXN0ZWQsIHN0aWxs
IGdvdCBzb21lIGlzc3VlIHdpdGggb3VyIG9wZW5zc2wtZW5naW5lLgo+Pj4KPj4+IDEuIElmIG9w
ZW5zc2wtZW5naW5lIGRvZXMgbm90IHJlZ2lzdGVyIHJzYSwgbmdpbnggd29ya3Mgd2VsbC4KPj4+
Cj4+PiAyLiBJZiBvcGVuc3NsLWVuZ2luZSByZWdpc3RlciByc2EsIG5naW54IGFsc28gd29ya3Ms
IGJ1dCBpb2FzaWQgaXMgbm90Cj4+PiBmcmVlZCB3aGVuIG5naW54IHN0b3AuCj4+Pgo+Pj4gSU1Q
TEVNRU5UX0RZTkFNSUNfQklORF9GTihiaW5kX2ZuKQo+Pj4gYmluZF9mbgo+Pj4gRU5HSU5FX3Nl
dF9SU0EoZSwgcnNhX21ldGhvZHMoKSkKPj4+Cj4+PiBkZXN0cm95X2ZuCj4+Pgo+Pj4gSWYgRU5H
SU5FX3NldF9SU0EgaXMgc2V0LCBuZ2lueCBzdGFydCBhbmQgc3RvcCB3aWxsIE5PVCBjYWxsIGRl
c3Ryb3lfZm4uCj4+PiBFdmVuIHJzYV9tZXRob2RzIGlzIGFsbW9zdCBuZXcgdmlhIFJTQV9tZXRo
X25ldy4KPj4+Cj4+PiBJbiA1LjE4LXJjeCwgdGhpcyBjYXVzZWQgaW9hc2lkwqAgbm90IGZyZWVk
IGluIG5naW54IHN0YXJ0IGFuZCBzdG9wLgo+Pj4gSW4gNS4xNywgdGhvdWdoIGRlc3Ryb3lfZm4g
aXMgbm90IGNhbGxlZCwgYnV0IGlvYXNpZCBpcyBmcmVlZCB3aGVuIG5naW54Cj4+PiBzdG9wLCBz
byBub3Qgbm90aWNlZCB0aGlzIGlzc3VlIGJlZm9yZS4KPj4gMS4gdWFjY2VfZm9wc19yZWxlYXNl
Cj4+IEluIDUuMTYgb3IgNS4xNwo+PiBJbiBmYWN0LCB3ZSBhc2xvIGhhcyB0aGUgaXNzdWU6IG9w
ZW5zc2wgZW5naW5lIGRvZXMgbm90IGNhbGwgZGVzdHJveV9mbiAtPgo+PiBjbG9zZSh1YWNjZV9m
ZCkKPj4gQnV0IHN5c3RlbSB3aWxsIGF1dG9tYXRpY2FsbHkgY2xvc2UgYWxsIG9wZW5lZCBmZCwK
Pj4gc28gdWFjY2VfZm9wc19yZWxlYXNlIGlzIGFsc28gY2FsbGVkIGFuZCBmcmVlIGlvYXNpZC4K
Pj4KPj4gSGF2ZSBvbmUgZXhwZXJpbWVudCwgbm90IGNhbGwgY2xvc2UgZmQKPj4KPj4gbG9nOiBv
cGVuIHVhY2NlIGZkIGJ1dCBubyBjbG9zZQo+PiBbIDI1ODMuNDcxMjI1XcKgIGR1bXBfYmFja3Ry
YWNlKzB4MC8weDFhMAo+PiBbIDI1ODMuNDc0ODc2XcKgIHNob3dfc3RhY2srMHgyMC8weDMwCj4+
IFsgMjU4My40NzgxNzhdwqAgZHVtcF9zdGFja19sdmwrMHg4Yy8weGI4Cj4+IFsgMjU4My40ODE4
MjVdwqAgZHVtcF9zdGFjaysweDE4LzB4MzQKPj4gWyAyNTgzLjQ4NTEyNl3CoCB1YWNjZV9mb3Bz
X3JlbGVhc2UrMHg0NC8weGRjCj4+IFsgMjU4My40ODkxMTddwqAgX19mcHV0KzB4NzgvMHgyNDAK
Pj4gWyAyNTgzLjQ5MjE1OV3CoCBfX19fZnB1dCsweDE4LzB4MjgKPj4gWyAyNTgzLjQ5NTI4OF3C
oCB0YXNrX3dvcmtfcnVuKzB4ODgvMHgxNjAKPj4gWyAyNTgzLjQ5ODkzNl3CoCBkb19ub3RpZnlf
cmVzdW1lKzB4MjE0LzB4NDkwCj4+IFsgMjU4My41MDI5MjddwqAgZWwwX3N2YysweDU4LzB4NzAK
Pj4gWyAyNTgzLjUwNTk2OF3CoCBlbDB0XzY0X3N5bmNfaGFuZGxlcisweGIwLzB4YjgKPj4gWyAy
NTgzLjUxMDEzMl3CoCBlbDB0XzY0X3N5bmMrMHgxYTAvMHgxYTQKPj4gWyAyNTgzLjU4MjI5Ml3C
oCB1YWNjZV9mb3BzX3JlbGVhc2UgcT0wMDAwMDAwMGQ2Njc0MTI4Cj4+Cj4+IEluIDUuMTgsIHNp
bmNlIHJlZmNvdW50IHdhcyBhZGQuCj4+IFRoZSBvcGVuZWQgdWFjY2UgZmQgd2FzIG5vdCBjbG9z
ZWQgYXV0b21hdGljYWxseSBieSBzeXN0ZW0KPj4gU28gd2Ugc2VlIHRoZSBpc3N1ZS4KPj4KPj4g
bG9nOiBvcGVuIHVhY2NlIGZkIGJ1dCBubyBjbG9zZQo+PiAgwqBbwqAgMTA2LjM2MDE0MF3CoCB1
YWNjZV9mb3BzX29wZW4gcT0wMDAwMDAwMGNjYzM4ZDc0Cj4+IFvCoCAxMDYuMzY0OTI5XcKgIGlv
YXNpZF9hbGxvYyBpb2FzaWQ9MQo+PiBbwqAgMTA2LjM2ODU4NV3CoCBpb21tdV9zdmFfYWxsb2Nf
cGFzaWQgcGFzaWQ9MQo+PiBbwqAgMTA2LjM3Mjk0M13CoCBpb21tdV9zdmFfYmluZF9kZXZpY2Ug
aGFuZGxlPTAwMDAwMDAwNmNjYTI5OGEKPj4gLy8gaW9hc2lkIGlzIG5vdCBmcmVlCj4gSSdtIHRy
eWluZyB0byBwaWVjZSB0b2dldGhlciB3aGF0IGhhcHBlbnMgZnJvbSB0aGUga2VybmVsIHBvaW50
IG9mIHZpZXcuCj4KPiAqIG1hc3RlciBwcm9jZXNzIHdpdGggbW0gQSBvcGVucyBhIHF1ZXVlIGZk
IHRocm91Z2ggdWFjY2UsIHdoaWNoIGNhbGxzCj4gICAgaW9tbXVfc3ZhX2JpbmRfZGV2aWNlKGRl
diwgQSkgLT4gUEFTSUQgMQo+Cj4gKiBtYXN0ZXIgZm9ya3MgYW5kIGV4aXRzLiBDaGlsZCAoZGFl
bW9uKSBnZXRzIG1tIEIsIGluaGVyaXRzIHRoZSBxdWV1ZSBmZC4KPiAgICBUaGUgZGV2aWNlIGlz
IHN0aWxsIGJvdW5kIHRvIG1tIEEgd2l0aCBQQVNJRCAxLCBzaW5jZSB0aGUgcXVldWUgZmQgaXMK
PiAgICBzdGlsbCBvcGVuLgoKPiBXZSBkaXNjdXNzZWQgdGhpcyBiZWZvcmUsIGJ1dCBJIGRvbid0
IHJlbWVtYmVyIHdoZXJlIHdlIGxlZnQgb2ZmLiBUaGUKPiBjaGlsZCBjYW4ndCB1c2UgdGhlIHF1
ZXVlIGJlY2F1c2UgaXRzIG1hcHBpbmdzIGFyZSBub3QgY29waWVkIG9uIGZvcmsoKSwKPiBhbmQg
dGhlIHF1ZXVlIGlzIHN0aWxsIGJvdW5kIHRvIHRoZSBwYXJlbnQgbW0gQS4gVGhlIGNoaWxkIGVp
dGhlciBuZWVkcyB0bwo+IG9wZW4gYSBuZXcgcXVldWUgb3IgdGFrZSBvd25lcnNoaXAgb2YgdGhl
IG9sZCBvbmUgd2l0aCBhIG5ldyB1YWNjZSBpb2N0bC4KWWVzLCBjdXJyZW50bHkgbmdpbnggYWxp
Z25lZCB3aXRoIHRoZSBjYXNlLgpDaGlsZCBwcm9jZXNzICh3b3JrZXIgcHJvY2VzcykgcmVvcGVu
IHVhY2NlLAoKTWFzdGVyIHByb2Nlc3MgKGRvIGluaXQpIG9wZW4gdWFjY2UsIGlvbW11X3N2YV9i
aW5kX2RldmljZShkZXYsIEEpIC0+IApQQVNJRCAxCk1hc3RlciBwcm9jZXNzIGZvcmsgQ2hpbGQg
KGRhZW1vbikgYW5kIGV4aXQuCgpDaGlsZCAoZGFlbW9uKcKgIGRvZXMgbm90IHVzZSBQQVNJRCAx
IGFueSBtb3JlLCBvbmx5IGZvcmsgYW5kIG1hbmFnZSAKd29ya2VyIHByb2Nlc3MuCldvcmtlciBw
cm9jZXNzIHJlb3BlbiB1YWNjZSwgaW9tbXVfc3ZhX2JpbmRfZGV2aWNlKGRldiwgQikgUEFTSUQg
MgoKU28gaXQgaXMgZXhwZWN0ZWQuCj4gSXMgdGhhdCB0aGUgIklNUExFTUVOVF9EWU5BTUlDX0JJ
TkRfRk4oKSIgeW91IG1lbnRpb24sIHNvbWV0aGluZyBvdXQgb2YKPiB0cmVlPyAgVGhpcyBvcGVy
YXRpb24gc2hvdWxkIHVuYmluZCBmcm9tIEEgYmVmb3JlIGJpbmRpbmcgdG8gQiwgbm8/Cj4gT3Ro
ZXJ3aXNlIHdlIGxlYWsgUEFTSUQgMS4KSW4gNS4xNiBQQVNJRCAxIGZyb20gbWFzdGVyIGlzIGhv
bGQgdW50aWwgbmdpbnggc2VydmljZSBzdG9wLgpuZ2lueCBzdGFydAptYXN0ZXI6CmlvbW11X3N2
YV9hbGxvY19wYXNpZCBtbS0+cGFzaWQ9McKgwqDCoCDCoCAvLyBtYXN0ZXIgcHJvY2VzcwoKbHlu
eCBodHRwcyBzdGFydDoKaW9tbXVfc3ZhX2FsbG9jX3Bhc2lkIG1tLT5wYXNpZD0ywqDCoMKgIC8v
d29ya2VyIHByb2Nlc3MKCm5naW54IHN0b3A6wqAgZnJvbSBmb3BzX3JlbGVhc2UKaW9tbXVfc3Zh
X2ZyZWVfcGFzaWQgbW0tPnBhc2lkPTLCoMKgIC8vIHdvcmtlciBwcm9jZXNzCmlvbW11X3N2YV9m
cmVlX3Bhc2lkIG1tLT5wYXNpZD0xwqAgLy8gbWFzdGVyIHByb2Nlc3MKCgpIYXZlIG9uZSBzaWxs
eSBxdWVzdGlvbi4KCmtlcm5lIGRyaXZlcgpmb3BzX29wZW4KaW9tbXVfc3ZhX2JpbmRfZGV2aWNl
Cgpmb3BzX3JlbGVhc2UKaW9tbXVfc3ZhX3VuYmluZF9kZXZpY2UKCmFwcGxpY2F0aW9uCm1haW4o
KQpmZCA9IG9wZW4KcmV0dXJuOwoKQXBwbGljYXRpb24gZXhpdCBidXQgbm90IGNsb3NlKGZkKSwg
aXMgaXQgZXhwZWN0ZWQgZm9wc19yZWxlYXNlIHdpbGwgYmUgCmNhbGxlZCBhdXRvbWF0aWNhbGx5
IGJ5IHN5c3RlbT8KCk9uIDUuMTcKZm9wc19yZWxlYXNlIGlzIGNhbGxlZCBhdXRvbWF0aWNhbGx5
LCBhcyB3ZWxsIGFzIGlvbW11X3N2YV91bmJpbmRfZGV2aWNlLgpPbiA1LjE4LXJjMS4KZm9wc19y
ZWxlYXNlIGlzIG5vdCBjYWxsZWQsIGhhdmUgdG8gbWFudWFsbHkgY2FsbCBjbG9zZShmZCkKClNp
bmNlIG5naW54IG1heSBoYXZlIGEgaXNzdWUsIGl0IGRvZXMgbm90IGNhbGwgY2xvc2UoZmQpIHdo
ZW4gbmdpbnggLXMgcXVpdC4KClRoYW5rcwoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vaW9tbXU=
