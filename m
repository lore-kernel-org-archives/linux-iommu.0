Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEA1C433F5
	for <iommu@archiver.kernel.org>; Mon, 11 Apr 2022 14:36:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 755C9405E7;
	Mon, 11 Apr 2022 14:36:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FQTtIZNtFuEL; Mon, 11 Apr 2022 14:36:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C9732403C4;
	Mon, 11 Apr 2022 14:36:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2FD9C002F;
	Mon, 11 Apr 2022 14:36:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8CF4C002C
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 14:36:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C7407405CA
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 14:36:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n1ApGhLckdY4 for <iommu@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 14:36:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com
 [203.205.221.231])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D2837403C4
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 14:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1649687790;
 bh=PMJEWnBJEevCLXSBOAMnHQrSxTYZtwjQrgG2Fk8vdfU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To;
 b=L7lIqzhZ6rnh4kVq830pHeHs39ahcCExTjKirw1++3NaVRnUx+x18l2E+uWQzI/uf
 73JdZjIEmj7CHHIzR6CsDiS35yPye7OdVMeBjhh304J9vHC7+dN12ahBY693vHn9yk
 NZPQ+cLCrXRCssjM6bsGp1S8ODeLPGWQcVRIoqac=
Received: from [192.168.0.110] ([36.57.147.99])
 by newxmesmtplogicsvrsza8.qq.com (NewEsmtp) with SMTP
 id 52D8364F; Mon, 11 Apr 2022 22:20:45 +0800
X-QQ-mid: xmsmtpt1649686845tjojd7udb
Message-ID: <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeieHPHoHPzlRiET1OZCkc0WHmzMcbYdy3YLswmmjhd0B0r17XprQF
 lQ9f9emH5ARFpozrW6m5MhEh4335PkSWivTHd4rS4/5gDdjzoNGU9ssatGGUftnOUpWtjb1ZXkT9
 ooh+gni2Hd9EDQ/WiWNZEMBnJnvHfLHlKWepbEOD+ontczw8BVK1N1Tc1M5CLRUDtAy9PyzUIcYV
 Bnt3F/CWa8da19xLoeDILU790qmUcgaWP4HX83fQtnD8t/sFaaqgESZccpb4ynZH4/4ABJ6rCFyc
 oAONlDEIkY1aUeVTfR2InNrk4MTHZfN+ireEerWAZhmPCujv0YtWwdi9dGPPT22wnUdTLb6lF2YG
 Qt4oeEgPrShpiauRtm1Z85CeQ4MvxqEoh6ANy+oJwHk0Pk0KXxeREkdak1GpVRsdofrMT02J3Il0
 TpHoaBLdlfx+t/vXDJz9YCRuh22Vaf39caxAvmz+z8FbfFfDcv96iW8o49NrEN43OuOnDjWJLAGg
 Iy72RnVVsijpnqKIhSrLKmkuQTJ1KdB/moKqjZ65s2NkGuDcBw/mfu/ilppNO2Kxq4V9HU9ppptq
 Qh8v9mesCHLhatJD7GtjcT/ulR5fegh1wfUQJsgrKTXnhmROZ6O2C6Kladi3UU2bTwvvqfZcxCzv
 qb/7UkMT5cwxHO/G7jNVGnLjcsGi29Pb50VwXfd7TuSQ4a6HdHriqrPj5AIa+7K91fz6Gx0NF1BB
 4N+Ly6pvy5tkJsX3ezC+xsoxE+6/g3WZXA34p2iZVVjP67+Vib/8+X58UtkEwIttLvogVFrI8dj5
 KNchLOd8787rXQ9GCAFt1hpIVO2BIucSMRfODeX4weGH/ODINpnYXo3fejoNhgUph/7VCmHRcID0
 ysuaFNTLIIf1v2GA0pYZjEm5GTAyW9H4+5mFrJTvNWtG9yYb2pPl4FmLRZGmdFxIHZNF0cz7Z7Ll
 YZ2UtIQIu7WNfTXs6/dw==
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
To: Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Fenghua Yu <fenghua.yu@intel.com>, jean-philippe <jean-philippe@linaro.org>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com> <Ygt4h0PgYzKOiB38@8bytes.org>
 <tencent_F6830A1196DB4C6A904D7C691F0D961D1108@qq.com>
 <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
From: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <11c9764b-c9bf-4521-b3e8-58250059ae2b@foxmail.com>
Date: Mon, 11 Apr 2022 22:20:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
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

CgpPbiAyMDIyLzQvMTEg5LiL5Y2IMTA6MTAsIERhdmUgSGFuc2VuIHdyb3RlOgo+IE9uIDQvMTEv
MjIgMDc6MDAsIFpoYW5nZmVpIEdhbyB3cm90ZToKPj4gd2l0aCB0aGlzIHBhdGNoc2V0LCBlYWNo
IHRpbWUgYWZ0ZXIgIHNiaW4vbmdpbngsIGlvYXNpZCBpcyBmcmVlZAo+PiBpbW1lZGlhdGVseS4g
bHlueCB0ZXN0IHdpbGwgYWxsb2MgdGhlIHNhbWUgaW9hc2lkPTEuCj4gVGhhdCBkb2Vzbid0IHNl
ZW0gcmlnaHQuICBJc24ndCAnc2Jpbi9uZ2lueCcgc3RpbGwgcnVubmluZyB3aGVuIGx5bngKPiBy
dW5zPyAgSG93IGNhbiB0aGV5IGdldCB0aGUgc2FtZSBpb2FzaWQ/Clllcywgc2Jpbi9uZ2lueCBp
cyBzdGlsbCBydW5uaW5nLApyb290wqDCoMKgwqDCoMKgwqAgMzIyOMKgIDAuMMKgIDAuMMKgIDMx
MzE2IDEzNDc2ID/CoMKgwqDCoMKgwqDCoCBTc2zCoCAxMjo1MMKgwqAgMDowMCAKbmdpbng6IG1h
c3RlciBwcm9jZXNzIHNiaW4vbmdpbngKbm9ib2R5wqDCoMKgwqDCoCAzMjMwwqAgMC4wwqAgMC4w
wqAgMzIyOTYgMTY0NTYgP8KgwqDCoMKgwqDCoMKgIFNswqDCoCAxMjo1MMKgwqAgMDowMCAKbmdp
bng6IHdvcmtlciBwcm9jZXNzCgpTaW5jZSBpb2FzaWQgaXMgZnJlZWQsIHNvIGx5bnggY2FuIGdl
dCB0aGUgc2FtZSBpb2FzaWQuCj4KPiBUaGlzIHNvdW5kcyBsaWtlIGEgcmVmY291bnRpbmcgcHJv
YmxlbSwgbGlrZSB0aGF0IHRoZSBpb2FzaWQgd2Fzbid0Cj4gcHJvcGVybHkgcmVmY291bnRlZCBh
cyBuZ2lueCBmb3JrZWQgaW50byB0aGUgYmFja2dyb3VuZC4KWWVzLCBpbiBjaGVja2luZywgdGhh
bmtzCmFuZCB0aGlzIHBhdGNoc2V0IHJlbW92ZWQgdGhlIG9sZCByZWZjb3VudC4KPgo+PiBUbyB2
ZXJpZnksIGhhY2sgY29tbWVudMKgbW1fcGFzaWRfZHJvcCBpbsKgX19tbXB1dCB3aWxsIG1ha2Ug
dGhlIGlzc3VlCj4+IGRpc2FwcGVhci4KPj4KPj4gbG9nOiBhZnRlciBzYmluL25naW54Lgo+PiBb
wqAgwqA5Ni41MjY3MzBdIENhbGwgdHJhY2U6Cj4+IFvCoCDCoDk2LjUyNjczMl3CoCBkdW1wX2Jh
Y2t0cmFjZSsweGU0LzB4ZjAKPj4gW8KgIMKgOTYuNTI2NzQxXcKgIHNob3dfc3RhY2srMHgyMC8w
eDcwCj4+IFvCoCDCoDk2LjUyNjc0NF3CoCBkdW1wX3N0YWNrX2x2bCsweDhjLzB4YjgKPj4gW8Kg
IMKgOTYuNTI2NzUxXcKgIGR1bXBfc3RhY2srMHgxOC8weDM0Cj4+IFvCoCDCoDk2LjUyNjc1NF3C
oCBpb2FzaWRfZnJlZSsweGRjLzB4ZmMKPj4gW8KgIMKgOTYuNTI2NzU3XcKgIG1tcHV0KzB4MTM4
LzB4MTYwCj4+IFvCoCDCoDk2LjUyNjc2MF3CoCBkb19leGl0KzB4Mjg0LzB4OWQwCj4+IFvCoCDC
oDk2LjUyNjc2NV3CoCBkb19ncm91cF9leGl0KzB4M2MvMHhhOAo+PiBbwqAgwqA5Ni41MjY3Njdd
wqAgX193YWtlX3VwX3BhcmVudCsweDAvMHgzOAo+PiBbwqAgwqA5Ni41MjY3NzBdwqAgaW52b2tl
X3N5c2NhbGwrMHg0Yy8weDExMAo+PiBbwqAgwqA5Ni41MjY3NzVdwqAgZWwwX3N2Y19jb21tb24u
Y29uc3Rwcm9wLjArMHg2OC8weDEyOAo+PiBbwqAgwqA5Ni41MjY3NzhdwqAgZG9fZWwwX3N2Yysw
eDJjLzB4OTAKPj4gW8KgIMKgOTYuNTI2NzgxXcKgIGVsMF9zdmMrMHgzMC8weDk4Cj4+IFvCoCDC
oDk2LjUyNjc4M13CoCBlbDB0XzY0X3N5bmNfaGFuZGxlcisweGIwLzB4YjgKPj4gW8KgIMKgOTYu
NTI2Nzg1XcKgIGVsMHRfNjRfc3luYysweDE4Yy8weDE5MAo+IElzIHRoZXJlIG5vdGhpbmcgYmVm
b3JlIHRoaXMgY2FsbCB0cmFjZT8gIFVzdWFsbHkgdGhlcmUgd2lsbCBiZSBhdCBsZWFzdAo+IHNv
bWUgd2FybmluZyB0ZXh0LgpJIGFkZGVkIGR1bXBfc3RhY2soKSBpbiBpb2FzaWRfZnJlZS4KClRo
YW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
