Return-Path: <SRS0=En+E=3E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9002C33CB1
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 11:19:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C62E2187F
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 11:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3Mcxwnk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C62E2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 40CFD203B9;
	Wed, 15 Jan 2020 11:19:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HyhX-MnYjS2C; Wed, 15 Jan 2020 11:19:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 50AF320016;
	Wed, 15 Jan 2020 11:19:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44361C1D83;
	Wed, 15 Jan 2020 11:19:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33816C077D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 11:19:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2177284F24
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 11:19:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CObP07X1kSYb for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jan 2020 11:18:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 22C7084029
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 11:18:58 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id z16so8401996pfk.0
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 03:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=fXqQU6rEG13cTg0zIPcmRK0xunIDxm/XK6227+s03nA=;
 b=g3McxwnkUANkgahUsKI7co1RacshzyopeqJjkhK09l59YJUmMmGMx6/LWt3mOzcUO4
 mw3t0NReHqJDSWcyPsbwbwjtA/tAjeFFeJpb5e+QJhaHuJT5ZiyiiXzqpZqrkwE0EL2T
 CSSa/Eeg+ZCYGW7arDj+xGWsXc3E+2liHsByajZb2107lndiT4wwOi127YPB8mAOWCwI
 JYHw14WoDEFoeNk9yxP1XtMEoYfEeGkkAI4nxW6PWcWzKHPBeiIyNOTNs1Jlcrwf9YyM
 3v6UdXIs9DS4zqOWlKHOXCyhk5UflqruxB1yYtWiIFvxWMnGWsJHhnlEkD8+goIpAzad
 OQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=fXqQU6rEG13cTg0zIPcmRK0xunIDxm/XK6227+s03nA=;
 b=qPHEZxPqBRYrGpvq/AqNAa3z07HkR6bUBSq3KYm/kK2zcvAbBifrM16X+5Hq9uVRno
 kaTdjHkOQrbqeydPVeLcRIEsyRrbwX/zLINhK2WN1ehnopb6SSmtIHIfqa8CNgyszRiC
 052iCCLjFFLifIHff0cUT9stnTHczT7EJYs3dS6Opxo1Iw2/GhoDtbsADoMk44jtnabb
 QRtgN4+5T7NcxLP+Tp9geoGKArlnXCRdhPKsbX7UbkH9WcuHgoApK0+ZtgP6yuQLqIJA
 wQHKbqbkp+ZxJOx3dTwgZoDivcoUJ+pax5yOWhuSjVbKwBKzbVH3lS7zk6zEai7ZmuPp
 XRUQ==
X-Gm-Message-State: APjAAAWjefT7a9mJCil8w0jHOpE3pbuSBXmq4CsSrftERdJhF9lFB0nu
 z5urzwl3I6pcre3Kwg2ZaJuoOQ==
X-Google-Smtp-Source: APXvYqwzl+XFVZuDlxHINgXocwnPKmenS6n4tYr3MFMQB417i0lAf852X/6hrV3aU+jpJeUh7Th2Fw==
X-Received: by 2002:a63:3409:: with SMTP id b9mr32626131pga.320.1579087137475; 
 Wed, 15 Jan 2020 03:18:57 -0800 (PST)
Received: from [10.79.0.170] ([45.135.186.87])
 by smtp.gmail.com with ESMTPSA id a28sm21582026pfh.119.2020.01.15.03.18.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Jan 2020 03:18:56 -0800 (PST)
Subject: Re: [PATCH v11 2/4] uacce: add uacce driver
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1578710919-12141-1-git-send-email-zhangfei.gao@linaro.org>
 <1578710919-12141-3-git-send-email-zhangfei.gao@linaro.org>
 <20200111194006.GD435222@kroah.com>
 <053ccd05-4f11-5be6-47c2-eee5c2f1fdc4@linaro.org>
 <20200114145934.GA1960403@kroah.com>
From: zhangfei <zhangfei.gao@linaro.org>
Message-ID: <c71b402c-a185-50a7-2827-c1836cc6c237@linaro.org>
Date: Wed, 15 Jan 2020 19:18:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200114145934.GA1960403@kroah.com>
Content-Language: en-US
Cc: jean-philippe <jean-philippe@linaro.org>, dave.jiang@intel.com,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 francois.ozog@linaro.org, linux-accelerators@lists.ozlabs.org,
 ilias.apalodimas@linaro.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
 grant.likely@arm.com, "haojian . zhuang" <haojian.zhuang@linaro.org>,
 linux-crypto@vger.kernel.org, Kenneth Lee <liguozhu@hisilicon.com>,
 guodong.xu@linaro.org, kenneth-lee-2012@foxmail.com
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

SGksIEdyZWcKCk9uIDIwMjAvMS8xNCDkuIvljYgxMDo1OSwgR3JlZyBLcm9haC1IYXJ0bWFuIHdy
b3RlOgo+IE9uIE1vbiwgSmFuIDEzLCAyMDIwIGF0IDExOjM0OjU1QU0gKzA4MDAsIHpoYW5nZmVp
IHdyb3RlOgo+PiBIaSwgR3JlZwo+Pgo+PiBUaGFua3MgZm9yIHRoZSByZXZpZXcuCj4+Cj4+IE9u
IDIwMjAvMS8xMiDkuIrljYgzOjQwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6Cj4+PiBPbiBT
YXQsIEphbiAxMSwgMjAyMCBhdCAxMDo0ODozN0FNICswODAwLCBaaGFuZ2ZlaSBHYW8gd3JvdGU6
Cj4+Pj4gK3N0YXRpYyBpbnQgdWFjY2VfZm9wc19vcGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0
cnVjdCBmaWxlICpmaWxlcCkKPj4+PiArewo+Pj4+ICsJc3RydWN0IHVhY2NlX21tICp1YWNjZV9t
bSA9IE5VTEw7Cj4+Pj4gKwlzdHJ1Y3QgdWFjY2VfZGV2aWNlICp1YWNjZTsKPj4+PiArCXN0cnVj
dCB1YWNjZV9xdWV1ZSAqcTsKPj4+PiArCWludCByZXQgPSAwOwo+Pj4+ICsKPj4+PiArCXVhY2Nl
ID0geGFfbG9hZCgmdWFjY2VfeGEsIGltaW5vcihpbm9kZSkpOwo+Pj4+ICsJaWYgKCF1YWNjZSkK
Pj4+PiArCQlyZXR1cm4gLUVOT0RFVjsKPj4+PiArCj4+Pj4gKwlpZiAoIXRyeV9tb2R1bGVfZ2V0
KHVhY2NlLT5wYXJlbnQtPmRyaXZlci0+b3duZXIpKQo+Pj4+ICsJCXJldHVybiAtRU5PREVWOwo+
Pj4gV2h5IGFyZSB5b3UgdHJ5aW5nIHRvIGdyYWIgdGhlIG1vZHVsZSByZWZlcmVuY2Ugb2YgdGhl
IHBhcmVudCBkZXZpY2U/Cj4+PiBXaHkgaXMgdGhhdCBuZWVkZWQgYW5kIHdoYXQgaXMgdGhhdCBn
b2luZyB0byBoZWxwIHdpdGggaGVyZT8KPj4+Cj4+PiBUaGlzIHNob3VsZG4ndCBiZSBuZWVkZWQg
YXMgdGhlIG1vZHVsZSByZWZlcmVuY2Ugb2YgdGhlIG93bmVyIG9mIHRoZQo+Pj4gZmlsZW9wcyBm
b3IgdGhpcyBtb2R1bGUgaXMgaW5jcmVtZW50ZWQsIGFuZCB0aGUgInBhcmVudCIgbW9kdWxlIGRl
cGVuZHMKPj4+IG9uIHRoaXMgbW9kdWxlLCBzbyBob3cgY291bGQgaXQgYmUgdW5sb2FkZWQgd2l0
aG91dCB0aGlzIGNvZGUgYmVpbmcKPj4+IHVubG9hZGVkPwo+Pj4KPj4+IFllcywgaWYgeW91IGJ1
aWxkIHRoaXMgY29kZSBpbnRvIHRoZSBrZXJuZWwgYW5kIHRoZSAicGFyZW50IiBkcml2ZXIgaXMg
YQo+Pj4gbW9kdWxlLCB0aGVuIHlvdSB3aWxsIG5vdCBoYXZlIGEgcmVmZXJlbmNlLCBidXQgd2hl
biB5b3UgcmVtb3ZlIHRoYXQKPj4+IHBhcmVudCBkcml2ZXIgdGhlIGRldmljZSB3aWxsIGJlIHJl
bW92ZWQgYXMgaXQgaGFzIHRvIGJlIHVucmVnaXN0ZXJlZAo+Pj4gYmVmb3JlIHRoYXQgcGFyZW50
IGRyaXZlciBjYW4gYmUgcmVtb3ZlZCBmcm9tIHRoZSBzeXN0ZW0sIHJpZ2h0Pwo+Pj4KPj4+IE9y
IHdoYXQgYW0gSSBtaXNzaW5nIGhlcmU/Cj4+IFRoZSByZWZjb3VudCBoZXJlIGlzIHByZXZlbnRp
bmcgcm1tb2QgInBhcmVudCIgbW9kdWxlIGFmdGVyIGZkIGlzIG9wZW5lZCwKPj4gc2luY2UgdXNl
ciBkcml2ZXIgaGFzIG1tYXAga2VybmVsIG1lbW9yeSB0byB1c2VyIHNwYWNlLCBsaWtlIG1taW8s
IHdoaWNoIG1heQo+PiBzdGlsbCBpbi11c2UuCj4+Cj4+IFdpdGggdGhlIHJlZmNvdW50IHByb3Rl
Y3Rpb24sIHJtbW9kICJwYXJlbnQiIG1vZHVsZSB3aWxsIGZhaWwgdW50aWwKPj4gYXBwbGljYXRp
b24gZnJlZSB0aGUgZmQuCj4+IGxvZyBsaWtlOiBybW1vZDogRVJST1I6IE1vZHVsZSBoaXNpX3pp
cCBpcyBpbiB1c2UKPiBCdXQgaWYgdGhlICJwYXJlbnQiIG1vZHVsZSBpcyB0byBiZSB1bmxvYWRl
ZCwgaXQgaGFzIHRvIHVucmVnaXN0ZXIgdGhlCj4gImNoaWxkIiBkZXZpY2UgYW5kIHRoYXQgd2ls
bCBjYWxsIHRoZSBkZXN0cnVjdG9yIGluIGhlcmUgYW5kIHRoZW4geW91Cj4gd2lsbCB0ZWFyIGV2
ZXJ5dGhpbmcgZG93biBhbmQgYWxsIHNob3VsZCBiZSBnb29kLgo+Cj4gVGhlcmUncyBubyBuZWVk
IHRvICJmb3JiaWQiIGEgbW9kdWxlIGZyb20gYmVpbmcgdW5sb2FkZWQsIGV2ZW4gaWYgaXQgaXMK
PiBiZWluZyB1c2VkLiAgTG9vayBhdCBhbGwgbmV0d29ya2luZyBkcml2ZXJzLCB0aGV5IHdvcmsg
dGhhdCB3YXksIHJpZ2h0PwpUaGFua3MgR3JlZyBmb3IgdGhlIGtpbmQgc3VnZ2VzdGlvbi4KCkkg
c3RpbGwgaGF2ZSBvbmUgdW5jZXJ0YWludHkuCkRvZXMgdWFjY2UgaGFzIHRvIGJsb2NrIHByb2Nl
c3MgY29udGludWUgYWNjZXNzaW5nIHRoZSBtbWFwcGVkIGFyZWEgd2hlbiAKcmVtb3ZlICJwYXJl
bnQiIG1vZHVsZT8KVWFjY2UgY2FuIGJsb2NrIGRldmljZSBhY2Nlc3MgdGhlIHBoeXNpY2FsIG1l
bW9yeSB3aGVuIHBhcmVudCBtb2R1bGUgCmNhbGwgdWFjY2VfcmVtb3ZlLgpCdXQgYXBwbGljYXRp
b24gaXMgc3RpbGwgcnVubmluZywgYW5kIHN1cHBvc2UgaXQgaXMgbm90IHRoZSBrZXJuZWwgCmRy
aXZlcidzIHJlc3BvbnNpYmlsaXR5IHRvIGNhbGwgdW5tYXAuCgpJIGFtIGxvb2tpbmcgZm9yIHNv
bWUgZXhhbXBsZXMgaW4ga2VybmVsLApsb29rcyB2ZmlvIGRvZXMgbm90IGJsb2NrIHByb2Nlc3Mg
Y29udGludWUgYWNjZXNzaW5nIHdoZW4gCnZmaW9fdW5yZWdpc3Rlcl9pb21tdV9kcml2ZXIgZWl0
aGVyLgoKSW4gbXkgdGVzdCwgYXBwbGljYXRpb24gd2lsbCBrZWVwIHdhaXRpbmcgYWZ0ZXIgcm1t
b2QgcGFyZW50LCB1bnRpbCAKY3RybCtjLCB3aGVuIHVubWFwIGlzIGNhbGxlZC4KRHVyaW5nIHRo
ZSBwcm9jZXNzLCBrZXJuZWwgZG9lcyBub3QgcmVwb3J0IGFueSBlcnJvci4KCkRvIHlvdSBoYXZl
IGFueSBhZHZpY2U/Cgo+Pj4+ICtzdGF0aWMgdm9pZCB1YWNjZV9yZWxlYXNlKHN0cnVjdCBkZXZp
Y2UgKmRldikKPj4+PiArewo+Pj4+ICsJc3RydWN0IHVhY2NlX2RldmljZSAqdWFjY2UgPSB0b191
YWNjZV9kZXZpY2UoZGV2KTsKPj4+PiArCj4+Pj4gKwlrZnJlZSh1YWNjZSk7Cj4+Pj4gKwl1YWNj
ZSA9IE5VTEw7Cj4+PiBUaGF0IGxpbmUgZGlkbid0IGRvIGFueXRoaW5nIDopCj4+IFllcywgdGhp
cyBpcyBhIG1pc3Rha2UuCj4+IEl0IGlzIHVwIHRvIGNhbGxlciB0byBzZXQgdG8gTlVMTCB0byBw
cmV2ZW50IHJlbGVhc2UgbXVsdGkgdGltZXMuCj4gUmVsZWFzZSBmdW5jdGlvbiBpcyBjYWxsZWQg
YnkgdGhlIGRyaXZlciBjb3JlIHdoaWNoIHdpbGwgbm90IHRvdWNoIHRoZQo+IHZhbHVlIGFnYWlu
LgpZZXMsIEkgdW5kZXJzdGFuZCwgaXQncyBteSBtaXN0YWtlLiBXaWxsIHJlbW92ZSBpdC4KClRo
YW5rcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
