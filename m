Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CA7C433F5
	for <iommu@archiver.kernel.org>; Mon, 11 Apr 2022 15:13:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AC9E540A90;
	Mon, 11 Apr 2022 15:13:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Crif2dgU6RJT; Mon, 11 Apr 2022 15:13:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8C5C040A95;
	Mon, 11 Apr 2022 15:13:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B2D1C002F;
	Mon, 11 Apr 2022 15:13:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C21F8C002F
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 15:13:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC8A540998
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 15:13:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=foxmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d054YTq21cJk for <iommu@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 15:13:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com
 [203.205.221.190])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5CBCF408D0
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 15:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1649690024;
 bh=28M5lhAtnZOyUfE1LzLlkbiL5y+pZYDo9mGQ5Q/tvIs=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To;
 b=BSDt4mSkN4hjoijsc/dLY21pilM9yAooR3R/aAzy4aVTANA+0E964bY1+6pRulIYt
 2pFuuU3I8YZ0VZSS0A25BFQ2f+OAvOc179IKE7pnFcPwehHluNpeveXLWfnFAbmesh
 E10vnN6dpMMPeu1X1xXNodEuh1vI5U/AGSbLDz24=
Received: from [192.168.0.110] ([36.57.147.99])
 by newxmesmtplogicsvrszb7.qq.com (NewEsmtp) with SMTP
 id 3681BC5A; Mon, 11 Apr 2022 23:13:40 +0800
X-QQ-mid: xmsmtpt1649690020ta5upzabz
Message-ID: <tencent_4D5A6753559A4D835707D1A06484CF369606@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9LEcvCo3XM0873Nsg49FRdhT228Ob+jseg4lPImmFyJDw0dyjq2
 1inUfGtSQpjOKkT1c+/th+IVe6qc1RFG/LSh8Gbi2z1qDOdz3I2UVGjj+pvEkcsElir20rb4OLvJ
 OG9mIlkZ33dyfiBswIrAx/A/guTUsRWelXSPyZlSyJSPA1tCro61SVyI2n8F9cPCu9x2CL4rI92N
 MhZvRHV2eiUjqIbW84A9EbMPX5nyxybB/D+lHI0eHN/w21qMD2xsoNsU/iNp3uATraiiKXf3KdfX
 QDUbEQKSDbof/qj6hx2eOhgw/Uy4hIwiggh/FoHURVSMScsEirhtJhhLfIvk75qIwNGO5dl5du8c
 O9MbA3imrNUtODhcDVzJQFk6zzwk8VhyVqDq1/e+7uZJycBxmzynGJk3mJfOgoWODYIKw8cSopLG
 9CTxaHU7MCpKG/gxksyFzWF2K8a0sppFTt3Pd9Tfrl8+Y1V9/k+5AmzD56hw1ztJ8kKtVo+du28J
 IV+dtyWKUFyaOUPJZH3MvL43gx9tDsrsFZ8LIEobkhqLu55s0PsGDjhXGuX+wCFTw/5+8EIIzVoS
 BtSWlJcwNvvOOtIUYyH6YHmPtPDsp0TUgae+XFxH4wBb0TrCI1k3e0Bu81qbTHwkLTCPT1ZbKs4F
 GuBegEHaryk2Q0nhvGrG5yOtPiSKQW3ECBpkglLyopCpmEZGGmKxwx0YhpoZhew1X9clMipXktu1
 Vs0GZta3wjJHsyKF0DLdntrRPfCGmFuCQQQEiRyH27uStAiqA6uddJfy/ABNgJWOgXu4Sqneh5sw
 PqWnJccEn8uEHFcZ+xqUiOPDBQDkN1xxopJtBO1NdW0Ct2aIZYjLO/H7/smEiIdJ3NYmYGTXzbKB
 Fb3eAQKcdT6rHg8JL34NOc3QLWm9wzn2cGwKQaWKIPA5Cz20MX/F9K4l/W8fTe/RPfdkQrBNoGnl
 h/YSHY29w=
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
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
From: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <0da0fea2-2b19-a9b6-910a-122ff57cb8f5@foxmail.com>
Date: Mon, 11 Apr 2022 23:13:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
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

CgpPbiAyMDIyLzQvMTEg5LiL5Y2IMTA6NTIsIERhdmUgSGFuc2VuIHdyb3RlOgo+IE9uIDQvMTEv
MjIgMDc6NDQsIHpoYW5nZmVpLmdhb0Bmb3htYWlsLmNvbSB3cm90ZToKPj4gT24gMjAyMi80LzEx
IOS4i+WNiDEwOjM2LCBEYXZlIEhhbnNlbiB3cm90ZToKPj4+IE9uIDQvMTEvMjIgMDc6MjAsIHpo
YW5nZmVpLmdhb0Bmb3htYWlsLmNvbSB3cm90ZToKPj4+Pj4gSXMgdGhlcmUgbm90aGluZyBiZWZv
cmUgdGhpcyBjYWxsIHRyYWNlP8KgIFVzdWFsbHkgdGhlcmUgd2lsbCBiZSBhdCBsZWFzdAo+Pj4+
PiBzb21lIHdhcm5pbmcgdGV4dC4KPj4+PiBJIGFkZGVkIGR1bXBfc3RhY2soKSBpbiBpb2FzaWRf
ZnJlZS4KPj4+IEhvbGQgb24gYSBzZWMsIHRob3VnaC4uLgo+Pj4KPj4+IFdoYXQncyB0aGUgKnBy
b2JsZW0qIGhlcmU/wqAgRGlkIHNvbWV0aGluZyBicmVhayBvciBhcmUgeW91IGp1c3Qgc2F5aW5n
Cj4+PiB0aGF0IHNvbWV0aGluZyBsb29rcyB3ZWlyZCB0byBfeW91Xz8KPj4gQWZ0ZXIgdGhpcywg
bmdpbnggaXMgbm90IHdvcmtpbmcgYXQgYWxsLCBhbmQgaGFyZHdhcmUgcmVwb3J0cyBlcnJvci4K
Pj4gU3VwcG9zZSB0aGUgdGhlIG1hc3RlciB1c2UgdGhlIGlvYXNpZCBmb3IgaW5pdCwgYnV0IGdv
dCBmcmVlZC4KPj4KPj4gaGFyZHdhcmUgcmVwb3J0czoKPj4gW8KgIDE1Mi43MzE4NjldIGhpc2lf
c2VjMiAwMDAwOjc2OjAwLjA6IHFtX2FjY19kb190YXNrX3RpbWVvdXQgW2Vycm9yIHN0YXR1cz0w
eDIwXSBmb3VuZAo+PiBbwqAgMTUyLjczOTY1N10gaGlzaV9zZWMyIDAwMDA6NzY6MDAuMDogcW1f
YWNjX3diX25vdF9yZWFkeV90aW1lb3V0IFtlcnJvciBzdGF0dXM9MHg0MF0gZm91bmQKPj4gW8Kg
IDE1Mi43NDc4NzddIGhpc2lfc2VjMiAwMDAwOjc2OjAwLjA6IHNlY19mc21faGJlYXRfcmludCBb
ZXJyb3Igc3RhdHVzPTB4MjBdIGZvdW5kCj4+IFvCoCAxNTIuNzU1MzQwXSBoaXNpX3NlYzIgMDAw
MDo3NjowMC4wOiBDb250cm9sbGVyIHJlc2V0dGluZy4uLgo+PiBbwqAgMTUyLjc2MjA0NF0gaGlz
aV9zZWMyIDAwMDA6NzY6MDAuMDogUU0gbWFpbGJveCBvcGVyYXRpb24gdGltZW91dCEKPj4gW8Kg
IDE1Mi43NjgxOThdIGhpc2lfc2VjMiAwMDAwOjc2OjAwLjA6IEZhaWxlZCB0byBkdW1wIHNxYyEK
Pj4gW8KgIDE1Mi43NzM0OTBdIGhpc2lfc2VjMiAwMDAwOjc2OjAwLjA6IEZhaWxlZCB0byBkcmFp
biBvdXQgZGF0YSBmb3Igc3RvcHBpbmchCj4+IFvCoCAxNTIuNzgxNDI2XSBoaXNpX3NlYzIgMDAw
MDo3NjowMC4wOiBRTSBtYWlsYm94IGlzIGJ1c3kgdG8gc3RhcnQhCj4+IFvCoCAxNTIuNzg3NDY4
XSBoaXNpX3NlYzIgMDAwMDo3NjowMC4wOiBGYWlsZWQgdG8gZHVtcCBzcWMhCj4+IFvCoCAxNTIu
NzkyNzUzXSBoaXNpX3NlYzIgMDAwMDo3NjowMC4wOiBGYWlsZWQgdG8gZHJhaW4gb3V0IGRhdGEg
Zm9yIHN0b3BwaW5nIQo+PiBbwqAgMTUyLjgwMDY4NV0gaGlzaV9zZWMyIDAwMDA6NzY6MDAuMDog
UU0gbWFpbGJveCBpcyBidXN5IHRvIHN0YXJ0IQo+PiBbwqAgMTUyLjgwNjczMF0gaGlzaV9zZWMy
IDAwMDA6NzY6MDAuMDogRmFpbGVkIHRvIGR1bXAgc3FjIQo+PiBbwqAgMTUyLjgxMjAxN10gaGlz
aV9zZWMyIDAwMDA6NzY6MDAuMDogRmFpbGVkIHRvIGRyYWluIG91dCBkYXRhIGZvciBzdG9wcGlu
ZyEKPj4gW8KgIDE1Mi44MTk5NDZdIGhpc2lfc2VjMiAwMDAwOjc2OjAwLjA6IFFNIG1haWxib3gg
aXMgYnVzeSB0byBzdGFydCEKPj4gW8KgIDE1Mi44MjU5OTJdIGhpc2lfc2VjMiAwMDAwOjc2OjAw
LjA6IEZhaWxlZCB0byBkdW1wIHNxYyEKPiBUaGF0IHdvdWxkIGhhdmUgYmVlbiBhd2Z1bGx5IGhh
bmR5IGluZm9ybWF0aW9uIHRvIGhhdmUgaW4gYW4gaW5pdGlhbCBidWcgcmVwb3J0LiA6KQo+IElz
IHRoZXJlIGEgY2hhbmNlIHlvdSBjb3VsZCBkdW1wIG91dCB0aGF0IGlvYXNpZCBhbGxvYyAqYW5k
KiBmcmVlIGluZm9ybWF0aW9uIGluIGlvYXNpZF9hbGxvYy9mcmVlKCk/ICBUaGlzIGNvdWxkIGJl
IHNvbWUga2luZCBvZiBwcm9ibGVtIHdpdGggdGhlIGFsbG9jYXRvciwgb3Igd2l0aCBjb3B5aW5n
IHRoZSBpb2FzaWQgYXQgZm9yay4KU3VyZSwgd2lsbCBhZGQgc29tZSB0cmFjZSB0b21vcnJvdy4K
ClRoYW5rcyBEYXZlCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
