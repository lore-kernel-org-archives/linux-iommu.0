Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1353C433FE
	for <iommu@archiver.kernel.org>; Tue, 26 Apr 2022 04:28:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38BA9416BE;
	Tue, 26 Apr 2022 04:28:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gtlB4b-2USwV; Tue, 26 Apr 2022 04:28:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A33BD4169E;
	Tue, 26 Apr 2022 04:28:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63BA7C0039;
	Tue, 26 Apr 2022 04:28:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC14DC002D
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 04:28:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C355460E2E
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 04:28:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7sBHvmqtMLpX for <iommu@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 04:28:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A3597605BE
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 04:28:21 +0000 (UTC)
Received: by mail-pg1-x52c.google.com with SMTP id k14so15129052pga.0
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 21:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=6121FvL1Agui+jgRIK6EJfVDrfD9B0AZyGQp+izN9SA=;
 b=kwmtSIA1VzkwnttMblbAzz+kfXu5zKeua/C1D14z0Lj3ag9aMXEahifhUWeMXmyYyc
 H6tvlpdOhTtY7YWchWX6mOMF6GBXnVBYKvHKF187+rJojcg5JpOPbdIpBZtJcuCYHF6T
 Tb0FmBSqDB+A5xXuN8UhhSs2Hormaf8rAmpwb1Ol16/E57b1IwA0VF7L3cpF45wUweHQ
 NGO+chxvQOcfs8ngbr+f+X5A2CmlK6z5g5kSbOcyKAIG/e6fu7I5EnpQIpd6DRkMxHbF
 di5QnHvorEf1RBW/zUlOXIK0RAA1z4JxE0jIR24/8Q6e2W4gKW8QDF4iE91ZEwq7orb4
 V8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=6121FvL1Agui+jgRIK6EJfVDrfD9B0AZyGQp+izN9SA=;
 b=6Psc5Av2qu5Pp7Ci7AI3s9OuEBMUGloZgNNwv1QnzU3+MJhLPy9Os6aorbtay8mK4z
 aMZZFAkOt/DT/rOWvEmW/IjsVNG9xttXF/uhF+NjnFLp33PDaLBCoVcM7PJPdKVmHgrq
 YtS5H7pZ4BHit0TCclRoD8WvFs+KoS/JtcOWRyY+z2plPo4FB7JtQHV9lR9VXuFUbo3C
 VnM+7oP+otc/1cR3Jz/ky9wHJ+bj6t9MGFQWriLNwJtRwFWF2Yu7DhFSIDztWDhN2PBz
 dW9w/4vYb8i1IjJpzwnXL/hcPywypzcVNANwsytGNfMA06zdu7u1CYE70sYSegNYYPZd
 a6Ng==
X-Gm-Message-State: AOAM533BgppJS64a76AAaWJCk/8CQ/CI5DAcTieNXHk5dvMeR42Qgjug
 nc3FnHtc+nWbeYVZdIXDx3CLBg==
X-Google-Smtp-Source: ABdhPJy8YhdEawCfwyIt1VWkYEmpxyAh1A1QAW/EycthB6WVtxCO83zxGEHNA81bt6nJQEVSmZsDew==
X-Received: by 2002:a05:6a00:2442:b0:4fd:8b00:d2f with SMTP id
 d2-20020a056a00244200b004fd8b000d2fmr22379519pfj.39.1650947300994; 
 Mon, 25 Apr 2022 21:28:20 -0700 (PDT)
Received: from [10.72.0.6] ([94.177.118.64]) by smtp.gmail.com with ESMTPSA id
 t29-20020a62d15d000000b0050d42864753sm4690106pfl.49.2022.04.25.21.28.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Apr 2022 21:28:20 -0700 (PDT)
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <tencent_76E043C4D1B6A21A5253579A61034107EB06@qq.com>
 <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com>
 <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica> <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica> <20220425083444.00af5674@jacob-builder>
 <YmbIjnHtibY7n4Wb@myrica>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <cf27bf82-ca68-86f1-ac8f-a138713edd5f@linaro.org>
Date: Tue, 26 Apr 2022 12:28:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YmbIjnHtibY7n4Wb@myrica>
Content-Language: en-US
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, will@kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, robin.murphy@arm.com
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

SGksIEplYW4KCk9uIDIwMjIvNC8yNiDkuIrljYgxMjoxMywgSmVhbi1QaGlsaXBwZSBCcnVja2Vy
IHdyb3RlOgo+IEhpIEphY29iLAo+Cj4gT24gTW9uLCBBcHIgMjUsIDIwMjIgYXQgMDg6MzQ6NDRB
TSAtMDcwMCwgSmFjb2IgUGFuIHdyb3RlOgo+PiBIaSBKZWFuLVBoaWxpcHBlLAo+Pgo+PiBPbiBN
b24sIDI1IEFwciAyMDIyIDE1OjI2OjQwICswMTAwLCBKZWFuLVBoaWxpcHBlIEJydWNrZXIKPj4g
PGplYW4tcGhpbGlwcGVAbGluYXJvLm9yZz4gd3JvdGU6Cj4+Cj4+PiBPbiBNb24sIEFwciAyNSwg
MjAyMiBhdCAwNzoxODozNkFNIC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToKPj4+PiBPbiA0LzI1
LzIyIDA2OjUzLCBKZWFuLVBoaWxpcHBlIEJydWNrZXIgd3JvdGU6Cj4+Pj4+IE9uIFNhdCwgQXBy
IDIzLCAyMDIyIGF0IDA3OjEzOjM5UE0gKzA4MDAsIHpoYW5nZmVpLmdhb0Bmb3htYWlsLmNvbQo+
Pj4+PiB3cm90ZToKPj4+Pj4+Pj4gT24gNS4xNwo+Pj4+Pj4+PiBmb3BzX3JlbGVhc2UgaXMgY2Fs
bGVkIGF1dG9tYXRpY2FsbHksIGFzIHdlbGwgYXMKPj4+Pj4+Pj4gaW9tbXVfc3ZhX3VuYmluZF9k
ZXZpY2UuIE9uIDUuMTgtcmMxLgo+Pj4+Pj4+PiBmb3BzX3JlbGVhc2UgaXMgbm90IGNhbGxlZCwg
aGF2ZSB0byBtYW51YWxseSBjYWxsIGNsb3NlKGZkKQo+Pj4+Pj4+IFJpZ2h0IHRoYXQncyB3ZWly
ZAo+Pj4+Pj4gTG9va3MgaXQgaXMgY2F1c2VkIGJ5IHRoZSBmaXggcGF0Y2gsIHZpYSBtbWdldCwg
d2hpY2ggbWF5IGFkZAo+Pj4+Pj4gcmVmY291bnQgb2YgZmQuCj4+Pj4+IFllcyBpbmRpcmVjdGx5
IEkgdGhpbms6IHdoZW4gdGhlIHByb2Nlc3MgbW1hcHMgdGhlIHF1ZXVlLAo+Pj4+PiBtbWFwX3Jl
Z2lvbigpIHRha2VzIGEgcmVmZXJlbmNlIHRvIHRoZSB1YWNjZSBmZC4gVGhhdCByZWZlcmVuY2Ug
aXMKPj4+Pj4gcmVsZWFzZWQgZWl0aGVyIGJ5IGV4cGxpY2l0IGNsb3NlKCkgb3IgbXVubWFwKCks
IG9yIGJ5IGV4aXRfbW1hcCgpCj4+Pj4+ICh3aGljaCBpcyB0cmlnZ2VyZWQgYnkgbW1wdXQoKSku
IFNpbmNlIHRoZXJlIGlzIGFuIG1tLT5mZCBkZXBlbmRlbmN5LAo+Pj4+PiB3ZSBjYW5ub3QgYWRk
IGEgZmQtPm1tIGRlcGVuZGVuY3ksIHNvIG5vIG1tZ2V0KCkvbW1wdXQoKSBpbgo+Pj4+PiBiaW5k
KCkvdW5iaW5kKCkuCj4+Pj4+Cj4+Pj4+IEkgZ3Vlc3Mgd2Ugc2hvdWxkIGdvIGJhY2sgdG8gcmVm
Y291bnRlZCBQQVNJRHMgaW5zdGVhZCwgdG8gYXZvaWQKPj4+Pj4gZnJlZWluZyB0aGVtIHVudGls
IHVuYmluZCgpLgo+Pj4+IFllYWgsIHRoaXMgaXMgYSBiaXQgZ25hcmx5IGZvciAtcmM0LiAgTGV0
J3MganVzdCBtYWtlIHN1cmUgdGhlcmUncwo+Pj4+IG5vdGhpbmcgZWxzZSBzaW1wbGUgd2UgY2Fu
IGRvLgo+Pj4+Cj4+Pj4gSG93IGRvZXMgdGhlIElPTU1VIGhhcmR3YXJlIGtub3cgdGhhdCBhbGwg
YWN0aXZpdHkgdG8gYSBnaXZlbiBQQVNJRCBpcwo+Pj4+IGZpbmlzaGVkPyAgVGhhdCBhY3Rpdml0
eSBzaG91bGQsIHRvZGF5LCBiZSBpbmRlcGVuZGVudCBvZiBhbiBtbSBvciBhCj4+Pj4gZmQncyBs
aWZldGltZS4KPj4+IEluIHRoZSBjYXNlIG9mIHVhY2NlLCBpdCdzIHRpZWQgdG8gdGhlIGZkIGxp
ZmV0aW1lOiBvcGVuaW5nIGFuIGFjY2VsZXJhdG9yCj4+PiBxdWV1ZSBjYWxscyBpb21tdV9zdmFf
YmluZF9kZXZpY2UoKSwgd2hpY2ggc2V0cyB1cCB0aGUgUEFTSUQgY29udGV4dCBpbgo+Pj4gdGhl
IElPTU1VLiBDbG9zaW5nIHRoZSBxdWV1ZSBjYWxscyBpb21tdV9zdmFfdW5iaW5kX2RldmljZSgp
IHdoaWNoCj4+PiBkZXN0cm95cyB0aGUgUEFTSUQgY29udGV4dCAoYWZ0ZXIgdGhlIGRldmljZSBk
cml2ZXIgc3RvcHBlZCBhbGwgRE1BIGZvcgo+Pj4gdGhpcyBQQVNJRCkuCj4+Pgo+PiBGb3IgVlQt
ZCwgaXQgaXMgZXNzZW50aWFsbHkgdGhlIHNhbWUgZmxvdyBleGNlcHQgbWFuYWdlZCBieSB0aGUg
aW5kaXZpZHVhbAo+PiBkcml2ZXJzIHN1Y2ggYXMgRFNBLgo+PiBJZiBmcmVlKCkgaGFwcGVucyBi
ZWZvcmUgdW5iaW5kKCksIHdlIGRlYWN0aXZhdGUgdGhlIFBBU0lEcyBhbmQgc3VwcHJlc3MKPj4g
ZmF1bHRzIGZyb20gdGhlIGRldmljZS4gV2hlbiB0aGUgdW5iaW5kIGZpbmFsbHkgY29tZXMsIHdl
IGZpbmFsaXplIHRoZQo+PiBQQVNJRCB0ZWFyZG93bi4gSXQgc2VlbXMgd2UgaGF2ZSBhIG5lZWQg
Zm9yIGFuIGludGVybWVkaWF0ZSBzdGF0ZSB3aGVyZQo+PiBQQVNJRCBpcyAicGVuZGluZyBmcmVl
Ij8KPiBZZXMgd2UgZG8gaGF2ZSB0aGF0IHN0YXRlLCB0aG91Z2ggSSdtIG5vdCBzdXJlIHdlIG5l
ZWQgdG8gbWFrZSBpdCBleHBsaWNpdAo+IGluIHRoZSBpb2FzaWQgYWxsb2NhdG9yLgo+Cj4gQ291
bGQgd2UgbW92ZSBtbV9wYXNpZF9kcm9wKCkgdG8gX19tbWRyb3AoKSBpbnN0ZWFkIG9mIF9fbW1w
dXQoKT8gIEZvciBBcm0KPiB3ZSBkbyBuZWVkIHRvIGhvbGQgdGhlIG1tX2NvdW50IHVudGlsIHVu
YmluZCgpLCBhbmQgbW1ncmFiKCkvbW1kcm9wKCkgaXMKPiBhbHNvIHBhcnQgb2YgTHUncyByZXdv
cmsgWzFdLgoKTW92ZSBtbV9wYXNpZF9kcm9wIHRvIF9fbW1kcm9wIGxvb2tzIHdvcmthYmxlLgoK
VGhlIG5naW54IHdvcmtzIHNpbmNlIGlvYXNpZCBpcyBub3QgZnJlZWQgd2hlbiBtYXN0ZXIgZXhp
dCB1bnRpbCBuZ2lueCBzdG9wLgoKVGhlIGlvYXNpZCBkb2VzIG5vdCBmcmVlIGltbWVkaWF0ZWx5
IHdoZW4gZm9wc19yZWxlYXNlLT51bmJpbmQgZmluaXNoZWQuCkluc3RlYWQsIF9fbW1kcm9wIGhh
cHBlbnMgYSBiaXQgbGF6eSzCoCB3aGljaCBoYXMgbm8gaXNzdWUgdGhvdWdoCkkgcGFzc2VkIDEw
MDAwIHRpbWVzIGV4aXQgd2l0aG91dCB1bmJpbmQgdGVzdCwgdGhlIHBhc2lkIGFsbG9jYXRpb24g
aXMgb2suCgpUaGFua3MKCgpkaWZmIC0tZ2l0IGEva2VybmVsL2ZvcmsuYyBiL2tlcm5lbC9mb3Jr
LmMKaW5kZXggOTc5Njg5NzU2MGFiLi42MGY0MTdmNjkzNjcgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9m
b3JrLmMKKysrIGIva2VybmVsL2ZvcmsuYwpAQCAtNzkyLDYgKzc5Miw4IEBAIHZvaWQgX19tbWRy
b3Aoc3RydWN0IG1tX3N0cnVjdCAqbW0pCiDCoMKgwqDCoMKgwqDCoCBtbXVfbm90aWZpZXJfc3Vi
c2NyaXB0aW9uc19kZXN0cm95KG1tKTsKIMKgwqDCoMKgwqDCoMKgIGNoZWNrX21tKG1tKTsKIMKg
wqDCoMKgwqDCoMKgIHB1dF91c2VyX25zKG1tLT51c2VyX25zKTsKK8KgwqDCoMKgwqDCoCBtbV9w
YXNpZF9kcm9wKG1tKTsKIMKgwqDCoMKgwqDCoMKgIGZyZWVfbW0obW0pOwogwqB9CiDCoEVYUE9S
VF9TWU1CT0xfR1BMKF9fbW1kcm9wKTsKQEAgLTExOTAsNyArMTE5Miw2IEBAIHN0YXRpYyBpbmxp
bmUgdm9pZCBfX21tcHV0KHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKQogwqDCoMKgwqDCoMKgwqAgfQog
wqDCoMKgwqDCoMKgwqAgaWYgKG1tLT5iaW5mbXQpCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgbW9kdWxlX3B1dChtbS0+YmluZm10LT5tb2R1bGUpOwotwqDCoMKgwqDCoMKgIG1tX3Bh
c2lkX2Ryb3AobW0pOwogwqDCoMKgwqDCoMKgwqAgbW1kcm9wKG1tKTsKIMKgfQoKPgo+IFRoYW5r
cywKPiBKZWFuCj4KPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW9tbXUvMjAy
MjA0MjEwNTIxMjEuMzQ2NDEwMC05LWJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbS8KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
