Return-Path: <SRS0=LjD4=JG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34787C433B4
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 17:10:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A19946101D
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 17:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19946101D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B8B16081B;
	Fri,  9 Apr 2021 17:10:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aKzDzdEWMBol; Fri,  9 Apr 2021 17:10:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id E767B606FF;
	Fri,  9 Apr 2021 17:10:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A91CCC000B;
	Fri,  9 Apr 2021 17:10:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD477C000A
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 17:10:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B44B0401B7
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 17:10:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id INc50zcUBQ8x for <iommu@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 17:10:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 99965400E4
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 17:10:31 +0000 (UTC)
Received: by mail-io1-xd31.google.com with SMTP id v26so6627030iox.11
 for <iommu@lists.linux-foundation.org>; Fri, 09 Apr 2021 10:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nCobqSwfZDla9Q+XsivHohjupQFazDMt1CW+z7r56vw=;
 b=f70bMEaIabgtympSuMmQtZg3AttmB0GlovZGjM6jUOF6+aHMCAA8ptxX/jdw7kvkyb
 sYYpbZK2elhek+LdqKVBJ81QinqhZkpqu2O5c56zYz3oa0nIapMA+4BYeWEMh4exe4g1
 tb6Irl+iMnyhBtfDkJi00F6RUhTgnQmZItLi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nCobqSwfZDla9Q+XsivHohjupQFazDMt1CW+z7r56vw=;
 b=GtKP/egw5OdFjwrAfyCcaWMz5rHvx20p8MwbkFAHqxfmhKMg3yqvb1+y4ytWcZC2RJ
 fjkhggqftdokE67u6fXn3SfmqEN2eGacVEz/tI4qg9TMNdgvEuVHT0hnginOBdOzS5R0
 HxaqIRfpQtdN8XpWPT12WA5jM6P8Fjn8oYahiTHB5y+bTsUpHRSlxkXFKBrWh/Kao9hV
 cPQI1XNUdfUYrtcZXApwrFZ5U7KlnQn8JkGNOEC5L8JpIutad4Pgudf8h2B/VH3xYfsY
 KuqmrXILXK0vmW3685l+3LvanGOQTr9Vf+neTLg3vyUB5d2SyD1dWy8mnu09NrE6yu2/
 KAag==
X-Gm-Message-State: AOAM531ZPtFjzBAYD/8nq80NwJck0Qfx/VqwlloWR3Zb2zKY/5YPNxws
 GTSFujGugJuxn8VVto8qz6RPo/Hg
X-Google-Smtp-Source: ABdhPJzPiL1DMFybVIX8F5dGlFFX1YtALTjKRNVUIifbdkF2ZUF4vlKOrpP+5zJ1KVoMb4K/MtSPZQ==
X-Received: by 2002:a6b:148f:: with SMTP id 137mr5146365iou.0.1617988230815;
 Fri, 09 Apr 2021 10:10:30 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net.
 [24.9.64.241])
 by smtp.gmail.com with ESMTPSA id k13sm1362401ilu.29.2021.04.09.10.10.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Apr 2021 10:10:30 -0700 (PDT)
Subject: Re: [PATCH 2/2] iommu/amd: Remove performance counter
 pre-initialization test
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20210409085848.3908-1-suravee.suthikulpanit@amd.com>
 <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
 <6d53ded8-9ab8-7205-f17e-d0c315b770bd@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4f64e9d4-dfc5-3dec-32c9-06bfbfeafd6b@linuxfoundation.org>
Date: Fri, 9 Apr 2021 11:10:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <6d53ded8-9ab8-7205-f17e-d0c315b770bd@linuxfoundation.org>
Content-Language: en-US
Cc: pmenzel@molgen.mpg.de, Alexander Monakov <amonakov@ispras.ru>,
 David Coe <david.coe@live.co.uk>, Jon.Grimm@amd.com,
 Shuah Khan <skhan@linuxfoundation.org>, Tj <ml.linux@elloe.vision>,
 will@kernel.org
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

T24gNC85LzIxIDEwOjM3IEFNLCBTaHVhaCBLaGFuIHdyb3RlOgo+IE9uIDQvOS8yMSAyOjU4IEFN
LCBTdXJhdmVlIFN1dGhpa3VscGFuaXQgd3JvdGU6Cj4+IEluIGVhcmx5IEFNRCBkZXNrdG9wL21v
YmlsZSBwbGF0Zm9ybXMgKGR1cmluZyAyMDEzKSwgd2hlbiB0aGUgSU9NTVUKPj4gUGVyZm9ybWFu
Y2UgQ291bnRlciAoUE1DKSBzdXBwb3J0IHdhcyBmaXJzdCBpbnRyb2R1Y2VkIGluCj4+IGNvbW1p
dCAzMDg2MWRkYzljY2EgKCJwZXJmL3g4Ni9hbWQ6IEFkZCBJT01NVSBQZXJmb3JtYW5jZSBDb3Vu
dGVyCj4+IHJlc291cmNlIG1hbmFnZW1lbnQiKSwgdGhlcmUgd2FzIGEgSFcgYnVnIHdoZXJlIHRo
ZSBjb3VudGVycyBjb3VsZCBub3QKPj4gYmUgYWNjZXNzZWQuIFRoZSByZXN1bHQgd2FzIHJlYWRp
bmcgb2YgdGhlIGNvdW50ZXIgYWx3YXlzIHJldHVybiB6ZXJvLgo+Pgo+PiBBdCB0aGUgdGltZSwg
dGhlIHN1Z2dlc3RlZCB3b3JrYXJvdW5kIHdhcyB0byBhZGQgYSB0ZXN0IGxvZ2ljIHByaW9yCj4+
IHRvIGluaXRpYWxpemluZyB0aGUgUE1DIGZlYXR1cmUgdG8gY2hlY2sgaWYgdGhlIGNvdW50ZXJz
IGNhbiBiZSAKPj4gcHJvZ3JhbW1lZAo+PiBhbmQgcmVhZCBiYWNrIHRoZSBzYW1lIHZhbHVlLiBU
aGlzIGhhcyBiZWVuIHdvcmtpbmcgZmluZSB1bnRpbCB0aGUgbW9yZQo+PiByZWNlbnQgZGVza3Rv
cC9tb2JpbGUgcGxhdGZvcm1zIHN0YXJ0IGVuYWJsaW5nIHBvd2VyIGdhdGluZyBmb3IgdGhlIFBN
QywKPj4gd2hpY2ggcHJldmVudHMgYWNjZXNzIHRvIHRoZSBjb3VudGVycy4gVGhpcyByZXN1bHRz
IGluIHRoZSBQTUMgc3VwcG9ydAo+PiBiZWluZyBkaXNhYmxlZCB1bm5lY2VzYXJpbHkuCj4gCj4g
dW5uZWNlc3NhcmlseQo+IAo+Pgo+PiBVbmZvcnR1bmF0bHksIHRoZXJlIGlzIG5vIGRvY3VtZW50
YXRpb24gb2Ygc2luY2Ugd2hpY2ggZ2VuZXJhdGlvbgo+IAo+IFVuZm9ydHVuYXRlbHksCj4gCj4g
UmVwaHJhc2Ugc3VnZ2VzdGlvbjoKPiBVbmZvcnR1bmF0ZWx5LCBpdCBpcyB1bmNsZWFyIHdoZW4g
dGhlIFBNQyBIVyBidWcgZml4ZWQuCj4gCj4+IG9mIGhhcmR3YXJlIHRoZSBvcmlnaW5hbCBQTUMg
SFcgYnVnIHdhcyBmaXhlZC4gQWx0aG91Z2gsIGl0IHdhcyBmaXhlZAo+PiBzb29uIGFmdGVyIHRo
ZSBmaXJzdCBpbnRyb2R1Y3Rpb24gb2YgdGhlIFBNQy4gQmFzZSBvbiB0aGlzLCB3ZSBhc3N1bWUK
PiAKPiBCYXNlZAo+IAo+PiB0aGF0IHRoZSBidWdneSBwbGF0Zm9ybXMgYXJlIGxlc3MgbGlrZWx5
IHRvIGJlIGluIHVzZWQsIGFuZCBpdCBzaG91bGQKPiAKPiBpbiB1c2UKPiAKPj4gYmUgcmVsYXRp
dmVseSBzYWZlIHRvIHJlbW92ZSB0aGlzIGxlZ2FjeSBsb2dpYy4KPiAKPj4KPj4gTGluazogCj4+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlvbW11L2FscGluZS5MTlguMy4yMC4xMy4y
MDA2MDMwOTM1NTcwLjMxODFAbW9ub3BvZC5pbnRyYS5pc3ByYXMucnUvIAo+Pgo+PiBCdWd6aWxs
YTogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMDE3NTMKPj4g
Q2M6IFRqIChFbGxvZSBMaW51eCkgPG1sLmxpbnV4QGVsbG9lLnZpc2lvbj4KPj4gQ2M6IFNodWFo
IEtoYW4gPHNraGFuQGxpbnV4Zm91bmRhdGlvbi5vcmc+Cj4+IENjOiBBbGV4YW5kZXIgTW9uYWtv
diA8YW1vbmFrb3ZAaXNwcmFzLnJ1Pgo+PiBDYzogRGF2aWQgQ29lIDxkYXZpZC5jb2VAbGl2ZS5j
by51az4KPj4gQ2M6IFBhdWwgTWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+Cj4+IFNpZ25l
ZC1vZmYtYnk6IFN1cmF2ZWUgU3V0aGlrdWxwYW5pdCA8c3VyYXZlZS5zdXRoaWt1bHBhbml0QGFt
ZC5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2lvbW11L2FtZC9pbml0LmMgfCAyNCArLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAy
MyBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvYW1kL2luaXQu
YyBiL2RyaXZlcnMvaW9tbXUvYW1kL2luaXQuYwo+PiBpbmRleCA2NDhjZGZkMDMwNzQuLjI0N2Nk
ZGE1ZDY4MyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS9hbWQvaW5pdC5jCj4+ICsrKyBi
L2RyaXZlcnMvaW9tbXUvYW1kL2luaXQuYwo+PiBAQCAtMTcxNCwzMyArMTcxNCwxNiBAQCBzdGF0
aWMgaW50IF9faW5pdCBpbml0X2lvbW11X2FsbChzdHJ1Y3QgCj4+IGFjcGlfdGFibGVfaGVhZGVy
ICp0YWJsZSkKPj4gwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4gwqAgfQo+PiAtc3RhdGljIGludCBp
b21tdV9wY19nZXRfc2V0X3JlZyhzdHJ1Y3QgYW1kX2lvbW11ICppb21tdSwgdTggYmFuaywgdTgg
Cj4+IGNudHIsCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdTggZnhuLCB1NjQg
KnZhbHVlLCBib29sIGlzX3dyaXRlKTsKPj4gLQo+PiDCoCBzdGF0aWMgdm9pZCBpbml0X2lvbW11
X3BlcmZfY3RyKHN0cnVjdCBhbWRfaW9tbXUgKmlvbW11KQo+PiDCoCB7Cj4+ICvCoMKgwqAgdTY0
IHZhbDsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IGlvbW11LT5kZXY7Cj4+
IC3CoMKgwqAgdTY0IHZhbCA9IDB4YWJjZCwgdmFsMiA9IDAsIHNhdmVfcmVnID0gMDsKCldoeSBu
b3QgbGVhdmUgdGhpcyB1NjQgdmFsIGhlcmU/IEhhdmluZyB0aGUgcGRldiBhc3NpZ25tZW50IGFz
IHRoZQpmaXJzdCBsaW5lIG1ha2VzIGl0IGVhc2llciB0byByZWFkL2ZvbGxvdy4KCj4+IMKgwqDC
oMKgwqAgaWYgKCFpb21tdV9mZWF0dXJlKGlvbW11LCBGRUFUVVJFX1BDKSkKPj4gwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybjsKPj4gwqDCoMKgwqDCoCBhbWRfaW9tbXVfcGNfcHJlc2VudCA9IHRy
dWU7Cj4+IC3CoMKgwqAgLyogc2F2ZSB0aGUgdmFsdWUgdG8gcmVzdG9yZSwgaWYgd3JpdGFibGUg
Ki8KPj4gLcKgwqDCoCBpZiAoaW9tbXVfcGNfZ2V0X3NldF9yZWcoaW9tbXUsIDAsIDAsIDAsICZz
YXZlX3JlZywgZmFsc2UpKQo+PiAtwqDCoMKgwqDCoMKgwqAgZ290byBwY19mYWxzZTsKPj4gLQo+
PiAtwqDCoMKgIC8qIENoZWNrIGlmIHRoZSBwZXJmb3JtYW5jZSBjb3VudGVycyBjYW4gYmUgd3Jp
dHRlbiB0byAqLwo+PiAtwqDCoMKgIGlmICgoaW9tbXVfcGNfZ2V0X3NldF9yZWcoaW9tbXUsIDAs
IDAsIDAsICZ2YWwsIHRydWUpKSB8fAo+PiAtwqDCoMKgwqDCoMKgwqAgKGlvbW11X3BjX2dldF9z
ZXRfcmVnKGlvbW11LCAwLCAwLCAwLCAmdmFsMiwgZmFsc2UpKSB8fAo+PiAtwqDCoMKgwqDCoMKg
wqAgKHZhbCAhPSB2YWwyKSkKCkFoYSAtIHRoaXMgaXMgZ29pbmcgYXdheSBhbnl3YXkuIFBsZWFz
ZSBpZ25vcmUgbXkgY29tbWVudCBvbiAxLzIKYWJvdXQgcGFyZW50aGVzaXMgYXJvdW5kICh2YWwg
IT0gdmFsMikgYmVpbmcgdW5uZWNlc3NhcnkuCgo+PiAtwqDCoMKgwqDCoMKgwqAgZ290byBwY19m
YWxzZTsKPj4gLQo+PiAtwqDCoMKgIC8qIHJlc3RvcmUgKi8KPj4gLcKgwqDCoCBpZiAoaW9tbXVf
cGNfZ2V0X3NldF9yZWcoaW9tbXUsIDAsIDAsIDAsICZzYXZlX3JlZywgdHJ1ZSkpCj4+IC3CoMKg
wqDCoMKgwqDCoCBnb3RvIHBjX2ZhbHNlOwo+PiAtCj4+IMKgwqDCoMKgwqAgcGNpX2luZm8ocGRl
diwgIklPTU1VIHBlcmZvcm1hbmNlIGNvdW50ZXJzIHN1cHBvcnRlZFxuIik7Cj4+IMKgwqDCoMKg
wqAgdmFsID0gcmVhZGwoaW9tbXUtPm1taW9fYmFzZSArIE1NSU9fQ05UUl9DT05GX09GRlNFVCk7
Cj4+IEBAIC0xNzQ4LDExICsxNzMxLDYgQEAgc3RhdGljIHZvaWQgaW5pdF9pb21tdV9wZXJmX2N0
cihzdHJ1Y3QgCj4+IGFtZF9pb21tdSAqaW9tbXUpCj4+IMKgwqDCoMKgwqAgaW9tbXUtPm1heF9j
b3VudGVycyA9ICh1OCkgKCh2YWwgPj4gNykgJiAweGYpOwo+PiDCoMKgwqDCoMKgIHJldHVybjsK
Pj4gLQo+PiAtcGNfZmFsc2U6Cj4+IC3CoMKgwqAgcGNpX2VycihwZGV2LCAiVW5hYmxlIHRvIHJl
YWQvd3JpdGUgdG8gSU9NTVUgcGVyZiBjb3VudGVyLlxuIik7Cj4+IC3CoMKgwqAgYW1kX2lvbW11
X3BjX3ByZXNlbnQgPSBmYWxzZTsKPj4gLcKgwqDCoCByZXR1cm47Cj4+IMKgIH0KPj4gwqAgc3Rh
dGljIHNzaXplX3QgYW1kX2lvbW11X3Nob3dfY2FwKHN0cnVjdCBkZXZpY2UgKmRldiwKPj4KPiAK
CnRoYW5rcywKLS0gU2h1YWgKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
