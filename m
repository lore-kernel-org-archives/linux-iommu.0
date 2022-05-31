Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E29C433F5
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 17:09:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B8DA61293;
	Tue, 31 May 2022 17:09:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZHnY1CDwfnNe; Tue, 31 May 2022 17:09:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4F46960E29;
	Tue, 31 May 2022 17:09:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 057CAC0039;
	Tue, 31 May 2022 17:09:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79811C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 17:09:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 560DC41834
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 17:09:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yh-fNUdYhteW for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 17:09:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DA59641830
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 17:09:23 +0000 (UTC)
Received: by mail-lf1-x12a.google.com with SMTP id j10so22407254lfe.12
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 10:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=oXC+omMyhQE+yQOLbS6KJe5K78bZY03LjtAozxlOWS4=;
 b=TAyjZkyHiTXmbmHCSrE2qWJwfpy2mK18RqayHB9KPwF3D5Pg+bZ6eGYNeN34jbspjz
 XKAIAKaqLBFgTkjxxqEqqjzKoQ4toUSB64OhXxsfMMRXeKBxTuUTXvyIQGUiGfioo7kC
 oMkYvmT4C0UXva0czCxfN3JpmbeZVhWBsYi1qGOpj0WhxatmjVmbr0Qp0zNQmGicVbqD
 XOkcjG3W1KKt5f0akOma0UDAHja0EIq/KJOrVyQ2kluOg8ugvRzH57Wsp2EqTBQKNt5m
 4tqMtwtv+jysyfjiBaAa2EYLry0bXPvGexMdU0w2FewQWJm/hZYWq2QWm7FRLYNLGMi4
 npkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=oXC+omMyhQE+yQOLbS6KJe5K78bZY03LjtAozxlOWS4=;
 b=0eiJv5AADWIW729nIQDh++/KdORD45DdDbblrNsxA68tuUjYhYWT7dkYgua1NRjn1f
 WY5p5RqzyYqpPm4PcdX4x3j9l3luURuLZKJyAOgI8K4pqZPnx1FSFqcwLfoxFoSrgrgi
 qoMhVNcEt1VCG68rUtwOuGjkByQUJ/SAwFX5XLCuQWeHrX5JJCsLuCrqODpYn6wExcS9
 pyo4xv0TwJdY+ptmT8DZwEkvjH+7L02EmqTCOsP87sty8YwGPofc9opgwCczeiwQmQob
 ncChJPLGi0RnLQYRDsBbb/NVY3wzohDpAUTdKE56S2HHnBU5W6sgrKNa203IiT5FZCDz
 zwpQ==
X-Gm-Message-State: AOAM531MAyh4IXyE6ayw2sVp0a/zSAO66O1BbTHarfil6Hl+Q8dPdSP3
 3ZQHuFlGWeLy1VvYbBpclBU=
X-Google-Smtp-Source: ABdhPJwx9hqwCt9lTBlhLuxF3159ZiuKQMGeaQRRGSerHfQCM1lHwBJOFfe0u0PJDGwPNceRQMYbag==
X-Received: by 2002:ac2:4f09:0:b0:478:6c80:64fc with SMTP id
 k9-20020ac24f09000000b004786c8064fcmr26696653lfr.34.1654016961692; 
 Tue, 31 May 2022 10:09:21 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
 by smtp.gmail.com with ESMTPSA id
 i6-20020a196d06000000b00477cab33759sm3072432lfc.256.2022.05.31.10.09.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 May 2022 10:09:21 -0700 (PDT)
Subject: Re: [PATCH V3 5/8] dt-bindings: Add xen,grant-dma IOMMU description
 for xen-grant DMA ops
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 xen-devel@lists.xenproject.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org
References: <1653944417-17168-1-git-send-email-olekstysh@gmail.com>
 <1653944417-17168-6-git-send-email-olekstysh@gmail.com>
 <15eef004-74c7-0eb5-3f87-86e164ef70ff@linaro.org>
From: Oleksandr <olekstysh@gmail.com>
Message-ID: <f5aa3337-e1fc-752e-5337-120599ed508b@gmail.com>
Date: Tue, 31 May 2022 20:09:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <15eef004-74c7-0eb5-3f87-86e164ef70ff@linaro.org>
Content-Language: en-US
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Julien Grall <julien@xen.org>,
 Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christoph Hellwig <hch@infradead.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Will Deacon <will@kernel.org>
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

Ck9uIDMxLjA1LjIyIDE0OjUyLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOgoKSGVsbG8gS3J6
eXN6dG9mCgo+IE9uIDMwLzA1LzIwMjIgMjM6MDAsIE9sZWtzYW5kciBUeXNoY2hlbmtvIHdyb3Rl
Ogo+PiBGcm9tOiBPbGVrc2FuZHIgVHlzaGNoZW5rbyA8b2xla3NhbmRyX3R5c2hjaGVua29AZXBh
bS5jb20+Cj4gVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLiBUaGVyZSBpcyBzb21ldGhpbmcgdG8g
ZGlzY3Vzcy9pbXByb3ZlLgo+Cj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvaW9tbXUveGVuLGdyYW50LWRtYS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2lvbW11L3hlbixncmFudC1kbWEueWFtbAo+PiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NAo+PiBpbmRleCAwMDAwMDAwMC4uYWI1NzY1Ywo+PiAtLS0gL2Rldi9udWxsCj4+ICsr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pb21tdS94ZW4sZ3JhbnQtZG1h
LnlhbWwKPj4gQEAgLTAsMCArMSw0OSBAQAo+PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
KEdQTC0yLjAtb25seSBvciBCU0QtMi1DbGF1c2UpCj4+ICslWUFNTCAxLjIKPj4gKy0tLQo+PiAr
JGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9pb21tdS94ZW4sZ3JhbnQtZG1hLnlh
bWwjCj4+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUu
eWFtbCMKPj4gKwo+PiArdGl0bGU6IFhlbiBzcGVjaWZpYyBJT01NVSBmb3IgdmlydHVhbGl6ZWQg
ZGV2aWNlcyAoZS5nLiB2aXJ0aW8pCj4+ICsKPj4gK21haW50YWluZXJzOgo+PiArICAtIFN0ZWZh
bm8gU3RhYmVsbGluaSA8c3N0YWJlbGxpbmlAa2VybmVsLm9yZz4KPj4gKwo+PiArZGVzY3JpcHRp
b246Cj4+ICsgIFRoZSByZWZlcmVuY2UgdG8gWGVuIHNwZWNpZmljIElPTU1VIG5vZGUgdXNpbmcg
ImlvbW11cyIgcHJvcGVydHkgaW5kaWNhdGVzCj4+ICsgIHRoYXQgWGVuIGdyYW50IG1hcHBpbmdz
IG5lZWQgdG8gYmUgZW5hYmxlZCBmb3IgdGhlIGRldmljZSwgYW5kIGl0IHNwZWNpZmllcwo+PiAr
ICB0aGUgSUQgb2YgdGhlIGRvbWFpbiB3aGVyZSB0aGUgY29ycmVzcG9uZGluZyBiYWNrZW5kIHJl
c2lkZXMuCj4+ICsgIFRoZSBiaW5kaW5nIGlzIHJlcXVpcmVkIHRvIHJlc3RyaWN0IG1lbW9yeSBh
Y2Nlc3MgdXNpbmcgWGVuIGdyYW50IG1hcHBpbmdzLgo+PiArCj4+ICtwcm9wZXJ0aWVzOgo+PiAr
ICBjb21wYXRpYmxlOgo+PiArICAgIGNvbnN0OiB4ZW4sZ3JhbnQtZG1hCj4+ICsKPj4gKyAgJyNp
b21tdS1jZWxscyc6Cj4+ICsgICAgY29uc3Q6IDEKPj4gKyAgICBkZXNjcmlwdGlvbjoKPj4gKyAg
ICAgIFhlbiBzcGVjaWZpYyBJT01NVSBpcyBtdWx0aXBsZS1tYXN0ZXIgSU9NTVUgZGV2aWNlLgo+
PiArICAgICAgVGhlIHNpbmdsZSBjZWxsIGRlc2NyaWJlcyB0aGUgZG9taWQgKGRvbWFpbiBJRCkg
b2YgdGhlIGRvbWFpbiB3aGVyZQo+PiArICAgICAgdGhlIGJhY2tlbmQgaXMgcnVubmluZy4KPj4g
Kwo+PiArcmVxdWlyZWQ6Cj4+ICsgIC0gY29tcGF0aWJsZQo+PiArICAtICIjaW9tbXUtY2VsbHMi
Cj4+ICsKPj4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQo+PiArCj4+ICtleGFtcGxlczoK
Pj4gKyAgLSB8Cj4+ICsgICAgeGVuX2lvbW11IHsKPiBObyB1bmRlcnNjb3JlcyBpbiBub2RlIG5h
bWVzLCBnZW5lcmljIG5vZGUgbmFtZXMsIHNvIHRoaXMgbG9va3MgbGlrZQo+ICJpb21tdSIuCgoK
b2ssIHdpbGwgY2hhbmdlCgoKPgo+PiArICAgICAgICBjb21wYXRpYmxlID0gInhlbixncmFudC1k
bWEiOwo+PiArICAgICAgICAjaW9tbXUtY2VsbHMgPSA8MT47Cj4+ICsgICAgfTsKPj4gKwo+PiAr
ICAgIHZpcnRpb0AzMDAwIHsKPj4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJ2aXJ0aW8sbW1pbyI7
Cj4+ICsgICAgICAgIHJlZyA9IDwweDMwMDAgMHgxMDA+Owo+PiArICAgICAgICBpbnRlcnJ1cHRz
ID0gPDQxPjsKPj4gKwo+PiArICAgICAgICAvKiBUaGUgYmFja2VuZCBpcyBsb2NhdGVkIGluIFhl
biBkb21haW4gd2l0aCBJRCAxICovCj4+ICsgICAgICAgIGlvbW11cyA9IDwmeGVuX2lvbW11IDE+
Owo+IFRoZXJlIGlzIG5vIG5lZWQgdXN1YWxseSB0byBnaXZlIGNvbnN1bWVyIGV4YW1wbGVzIGlu
IHByb3ZpZGVyIGJpbmRpbmcuCj4gSWYgdGhlcmUgaXMgbm90aGluZyBzcGVjaWZpYyBoZXJlIChs
b29rcyBleGFjdGx5IGxpa2UgZXZlcnkgSU9NTVUKPiBjb25zdW1lciBpbiBMaW51eCBrZXJuZWwp
LCBkcm9wIHRoZSBjb25zdW1lci4KCgpJIGdvdCBpdC7CoCBUaGVyZSBpcyBub3RoaW5nIHNwZWNp
ZmljIGZyb20gdGhlIGRldmljZSB0cmVlJ3MgcGVyc3BlY3RpdmUsIApJIHdhcyB0aGlua2luZyB0
byBkcmF3IGF0dGVudGlvbiB0byB0aGUgSU9NTVUgc3BlY2lmaWVyIChpbiBvdXIgY2FzZSwgCnRo
ZSBtYXN0ZXIgZGV2aWNlJ3MgSUQgPT0gYmFja2VuZCdzIGRvbWFpbiBJRCkuIEJ1dMKgICcjaW9t
bXUtY2VsbHMnIApkZXNjcmlwdGlvbiBhYm92ZSBhbHJlYWR5IGNsYXJpZmllcyB0aGF0LiBXaWxs
IGRyb3AuCgoKPgo+PiArICAgIH07Cj4KPiBCZXN0IHJlZ2FyZHMsCj4gS3J6eXN6dG9mCgotLSAK
UmVnYXJkcywKCk9sZWtzYW5kciBUeXNoY2hlbmtvCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
