Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2445EC07E9A
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 06:03:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2E03613A9
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 06:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E03613A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C2E041480;
	Wed, 14 Jul 2021 06:03:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FDvh4Kgz7Gnu; Wed, 14 Jul 2021 06:03:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 64F1E40696;
	Wed, 14 Jul 2021 06:03:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11CD0C001A;
	Wed, 14 Jul 2021 06:03:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B82DC000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 06:03:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 40D7E41480
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 06:03:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VDj9cGYQzceR for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 06:03:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8E16E40E43
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 06:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626242586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7Q8ciSmkkFwqcK9Ly2flr5V7ufFOKmLdTuweetcBqc=;
 b=Ni8dhCeKAa6CFZEPBNbHxe5pbfl/jKG0kVLhm2oXoFYvWbq7fIhmQaWISWJ7HRqQL6p4Ag
 eRi/hH/OZ25Li3Ty0sYLiQz71X0jSaYp+0f2Ef5DtvG5sUTUtsmAPmlPh8qji/G7IImEXN
 RpdqwKbIfQlTtVhOnQNMG4ILsRQfWgQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-iF-bXXqBN0ew98sQ-FA3jw-1; Wed, 14 Jul 2021 02:03:05 -0400
X-MC-Unique: iF-bXXqBN0ew98sQ-FA3jw-1
Received: by mail-pg1-f197.google.com with SMTP id
 u8-20020a6345480000b0290227a64be361so741995pgk.9
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 23:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=c7Q8ciSmkkFwqcK9Ly2flr5V7ufFOKmLdTuweetcBqc=;
 b=VM+saR0/EY2xdg1/icX0/S4QmujWRzBVnUbLdITCKfYnBb3UZ25ZWR5fUwE2259GE7
 ef2MQG6uFuoOo65HH4AihKRl4NzEDKXmD4gpDpXKRX7rYfHgMRq6xlB7cxDYb5rJpfZN
 rJDpmAAzuZ88YEmR/NjqsfCDX+eNWHZXJNfA9n8BjnWQeu92gdGFfTp6GbyYp2Ua9/8y
 Yo87450ZNbqziJN3afUQiE2uD1rtPqSF4r2KC6ruQeTryBtieL8012qteW8UH382VuRH
 CJTjgUhrjzBX8+pia07uQda/Swcwd/fl7zaFTpbJVDNbU0PQt2T5eloWJW9GP2RCFWTZ
 YLKQ==
X-Gm-Message-State: AOAM5337O3n8ISwRXWreDkHjH09qpZDfcBrAn1wVeDXMKzpo8MtYKSX4
 pebTcsTMopdqjKfz697oPQ4x4Wi9MApjd/k0ybAjp7vUr7nKp1wAYz/z+rSFanBaRv9ur1I0srV
 Devk+M0rYSksryCx+pj73H+nqHBYXmg==
X-Received: by 2002:a63:111a:: with SMTP id g26mr7785894pgl.103.1626242584045; 
 Tue, 13 Jul 2021 23:03:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdA7Ox90h5XXIshMvBjDNcFMeGycsIxzhnY5/F/BBeS8iYsHUo11OJSfqeDY+OH4iEPOdWBg==
X-Received: by 2002:a63:111a:: with SMTP id g26mr7785847pgl.103.1626242583780; 
 Tue, 13 Jul 2021 23:03:03 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id d2sm4572795pjo.50.2021.07.13.23.02.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jul 2021 23:03:02 -0700 (PDT)
Subject: Re: [PATCH v9 16/17] vduse: Introduce VDUSE - vDPA Device in Userspace
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20210713084656.232-1-xieyongji@bytedance.com>
 <20210713084656.232-17-xieyongji@bytedance.com>
 <26116714-f485-eeab-4939-71c4c10c30de@redhat.com>
 <20210714014817-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0565ed6c-88e2-6d93-7cc6-7b4afaab599c@redhat.com>
Date: Wed, 14 Jul 2021 14:02:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714014817-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 christian.brauner@canonical.com, corbet@lwn.net, willy@infradead.org,
 hch@infradead.org, Xie Yongji <xieyongji@bytedance.com>,
 dan.carpenter@oracle.com, sgarzare@redhat.com, xiaodong.liu@intel.com,
 viro@zeniv.linux.org.uk, stefanha@redhat.com, songmuchun@bytedance.com,
 axboe@kernel.dk, zhe.he@windriver.com, gregkh@linuxfoundation.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, bcrl@kvack.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, mika.penttila@nextfour.com
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNy8xNCDPws7nMTo1NCwgTWljaGFlbCBTLiBUc2lya2luINC0tcA6Cj4gT24gV2Vk
LCBKdWwgMTQsIDIwMjEgYXQgMDE6NDU6MzlQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+
ICtzdGF0aWMgaW50IHZkdXNlX2Rldl9tc2dfc3luYyhzdHJ1Y3QgdmR1c2VfZGV2ICpkZXYsCj4+
PiArCQkJICAgICAgc3RydWN0IHZkdXNlX2Rldl9tc2cgKm1zZykKPj4+ICt7Cj4+PiArCWludCBy
ZXQ7Cj4+PiArCj4+PiArCWluaXRfd2FpdHF1ZXVlX2hlYWQoJm1zZy0+d2FpdHEpOwo+Pj4gKwlz
cGluX2xvY2soJmRldi0+bXNnX2xvY2spOwo+Pj4gKwltc2ctPnJlcS5yZXF1ZXN0X2lkID0gZGV2
LT5tc2dfdW5pcXVlKys7Cj4+PiArCXZkdXNlX2VucXVldWVfbXNnKCZkZXYtPnNlbmRfbGlzdCwg
bXNnKTsKPj4+ICsJd2FrZV91cCgmZGV2LT53YWl0cSk7Cj4+PiArCXNwaW5fdW5sb2NrKCZkZXYt
Pm1zZ19sb2NrKTsKPj4+ICsKPj4+ICsJd2FpdF9ldmVudF9raWxsYWJsZV90aW1lb3V0KG1zZy0+
d2FpdHEsIG1zZy0+Y29tcGxldGVkLAo+Pj4gKwkJCQkgICAgVkRVU0VfUkVRVUVTVF9USU1FT1VU
ICogSFopOwo+Pj4gKwlzcGluX2xvY2soJmRldi0+bXNnX2xvY2spOwo+Pj4gKwlpZiAoIW1zZy0+
Y29tcGxldGVkKSB7Cj4+PiArCQlsaXN0X2RlbCgmbXNnLT5saXN0KTsKPj4+ICsJCW1zZy0+cmVz
cC5yZXN1bHQgPSBWRFVTRV9SRVFfUkVTVUxUX0ZBSUxFRDsKPj4+ICsJfQo+Pj4gKwlyZXQgPSAo
bXNnLT5yZXNwLnJlc3VsdCA9PSBWRFVTRV9SRVFfUkVTVUxUX09LKSA/IDAgOiAtRUlPOwo+Pgo+
PiBJIHRoaW5rIHdlIHNob3VsZCBtYXJrIHRoZSBkZXZpY2UgYXMgbWFsZnVuY3Rpb24gd2hlbiB0
aGVyZSBpcyBhIHRpbWVvdXQgYW5kCj4+IGZvcmJpZCBhbnkgdXNlcnNwYWNlIG9wZXJhdGlvbnMg
ZXhjZXB0IGZvciB0aGUgZGVzdHJveSBhZnR3YXJkcyBmb3Igc2FmZXR5Lgo+IFRoaXMgbG9va3Mg
bGlrZSBpZiBvbmUgdHJpZWQgdG8gcnVuIGdkYiBvbiB0aGUgcHJvZ3JhbSB0aGUgYmVoYXZpb3Vy
Cj4gd2lsbCBjaGFuZ2UgY29tcGxldGVseSBiZWNhdXNlIGtlcm5lbCB3YW50cyBpdCB0byByZXNw
b25kIHdpdGhpbgo+IHNwZWNpZmljIHRpbWUuIExvb2tzIGxpa2UgYSByZWNlaXBlIGZvciBoZWlz
ZW5idWdzLgo+Cj4gTGV0J3Mgbm90IGJ1aWxkIGludGVyZmFjZXMgd2l0aCBhcmJpdHJhcnkgdGlt
ZW91dHMgbGlrZSB0aGF0Lgo+IEludGVycnVwdGlibGUgd2FpdCBleGlzdHMgZm9yIHRoaXMgdmVy
eSByZWFzb24uCgoKVGhlIHByb2JsZW0gaXMuIERvIHdlIHdhbnQgdXNlcnNwYWNlIHByb2dyYW0g
bGlrZSBtb2Rwcm9iZSB0byBiZSBzdHVjayAKZm9yIGluZGVmaW5pdGUgdGltZSBhbmQgZXhwZWN0
IHRoZSBhZG1pbmlzdHJhdG9yIHRvIGtpbGwgdGhhdD8KClRoYW5rcwoKCj4gICBMZXQgdXNlcnNw
YWNlIGhhdmUgaXRzCj4gb3duIGNvZGUgdG8gc2V0IGFuZCB1c2UgdGltZXJzLiBUaGlzIGRvZXMg
bWVhbiB0aGF0IHVzZXJzcGFjZSB3aWxsCj4gbGlrZWx5IGhhdmUgdG8gY2hhbmdlIGEgYml0IHRv
IHN1cHBvcnQgdGhpcyBkcml2ZXIsIHN1Y2ggaXMgbGlmZS4KPgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
