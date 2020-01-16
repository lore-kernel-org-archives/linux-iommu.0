Return-Path: <SRS0=QvS0=3F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3326C32771
	for <iommu@archiver.kernel.org>; Thu, 16 Jan 2020 02:12:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E1C82081E
	for <iommu@archiver.kernel.org>; Thu, 16 Jan 2020 02:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i2BXAPLH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1C82081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 838E085E8D;
	Thu, 16 Jan 2020 02:12:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y07kU1aWf0OB; Thu, 16 Jan 2020 02:12:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E810585E25;
	Thu, 16 Jan 2020 02:12:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4128C1D82;
	Thu, 16 Jan 2020 02:12:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0DA2C077D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jan 2020 02:12:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9D14285E25
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jan 2020 02:12:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2BGY732qOCBD for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jan 2020 02:12:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
 [209.85.214.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6688985DF7
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jan 2020 02:12:01 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id f14so349194plr.8
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 18:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=ISxVLQvK8s5nY6LD7WJ8K+q3IuJWjWSPNsTVjYjwR80=;
 b=i2BXAPLH47Eap5rnuaSk8R3uM2RBSpnlp2GmGBNYBu9aWN7QmFKWYXXjSZ0zO2NJ5l
 TtgRXB620x7o7cZqjHRAu5vtlw8XUy026f4IXofijWYbgiqL6OZkmTv0LALmnqLA3GI0
 apyz/E6RIb6mnB31hZ5IWR9SRCdBnv3ROCv4zfnvf7ABKpOha1w44MuNGwgY5aDHoGfy
 dZNbKRKgKfaNxkoOSGBRVZPlGyIOAkWZEpoZY0gUle3V95e44IgMYbrwbTbw+qWnwwFc
 tMqnci8VTrjsBHDFf1sunwD9DjGW33qVtO23fpOgUW05G3QsHLKwN/RpRkVszP7ZITFN
 QhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=ISxVLQvK8s5nY6LD7WJ8K+q3IuJWjWSPNsTVjYjwR80=;
 b=rN+cAwJ6gNrXANFlyXBa7wNxYiySpDtnAt+50bbgVqlrj+HrQdX+8Kt6bHKhDq0m6F
 fBPLZdVP6QlRee+WZyQozDzejdPgLMl37MQSJuknVlGOEJbz/B7vb+ADhYD7BM3aw7Yu
 9noLDev+BcEUEfoh/fz5QWHBv2WimSTIEueyEjRUhtrc6WxntkdzR/Dg+4GJsFu33mE9
 8A83UWNtM5FILxk192EpTJzlQP6gcy8zreUXn6G/5utKxge6Y5Bcy2N5DFWf6zoojGij
 zaBCu6OTQWBAmFPJc38u9ZyOosBdr+ki5/hg0lUsSjkVKlncLNL0hx5kqLlFfHqGMYaP
 m+DQ==
X-Gm-Message-State: APjAAAXawTJty0lVAK/ddgW0JLGNm78ChLj4bF20In1PMIooCq+ubcmD
 yeEIMoJd3JqobO3LBs6EkVCWAw==
X-Google-Smtp-Source: APXvYqwPtaRpD5q+1zpA9jWTonAeFglbEPocCdD4h8NzV1Oc8GcurWseUbRfe1v2M61Rtj3lXNrDwA==
X-Received: by 2002:a17:902:462:: with SMTP id
 89mr29644947ple.270.1579140720839; 
 Wed, 15 Jan 2020 18:12:00 -0800 (PST)
Received: from ?IPv6:240e:362:43d:200:56f:3d32:378b:3366?
 ([240e:362:43d:200:56f:3d32:378b:3366])
 by smtp.gmail.com with ESMTPSA id g11sm22149064pgd.26.2020.01.15.18.11.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Jan 2020 18:12:00 -0800 (PST)
Subject: Re: [PATCH v11 2/4] uacce: add uacce driver
To: Dave Jiang <dave.jiang@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1578710919-12141-1-git-send-email-zhangfei.gao@linaro.org>
 <1578710919-12141-3-git-send-email-zhangfei.gao@linaro.org>
 <20200111194006.GD435222@kroah.com>
 <053ccd05-4f11-5be6-47c2-eee5c2f1fdc4@linaro.org>
 <20200114145934.GA1960403@kroah.com>
 <c71b402c-a185-50a7-2827-c1836cc6c237@linaro.org>
 <9454d674-85db-32ba-4f28-eb732777d59d@intel.com>
From: zhangfei <zhangfei.gao@linaro.org>
Message-ID: <6c08d1ad-53a5-0238-3767-c40d7b10df3c@linaro.org>
Date: Thu, 16 Jan 2020 10:11:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9454d674-85db-32ba-4f28-eb732777d59d@intel.com>
Content-Language: en-US
Cc: jean-philippe <jean-philippe@linaro.org>,
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

SGksIERhdmUKCk9uIDIwMjAvMS8xNiDkuIrljYgxMjo0MywgRGF2ZSBKaWFuZyB3cm90ZToKPgo+
Cj4gT24gMS8xNS8yMCA0OjE4IEFNLCB6aGFuZ2ZlaSB3cm90ZToKPj4gSGksIEdyZWcKPj4KPj4g
T24gMjAyMC8xLzE0IOS4i+WNiDEwOjU5LCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6Cj4+PiBP
biBNb24sIEphbiAxMywgMjAyMCBhdCAxMTozNDo1NUFNICswODAwLCB6aGFuZ2ZlaSB3cm90ZToK
Pj4+PiBIaSwgR3JlZwo+Pj4+Cj4+Pj4gVGhhbmtzIGZvciB0aGUgcmV2aWV3Lgo+Pj4+Cj4+Pj4g
T24gMjAyMC8xLzEyIOS4iuWNiDM6NDAsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToKPj4+Pj4g
T24gU2F0LCBKYW4gMTEsIDIwMjAgYXQgMTA6NDg6MzdBTSArMDgwMCwgWmhhbmdmZWkgR2FvIHdy
b3RlOgo+Pj4+Pj4gK3N0YXRpYyBpbnQgdWFjY2VfZm9wc19vcGVuKHN0cnVjdCBpbm9kZSAqaW5v
ZGUsIHN0cnVjdCBmaWxlICpmaWxlcCkKPj4+Pj4+ICt7Cj4+Pj4+PiArwqDCoMKgIHN0cnVjdCB1
YWNjZV9tbSAqdWFjY2VfbW0gPSBOVUxMOwo+Pj4+Pj4gK8KgwqDCoCBzdHJ1Y3QgdWFjY2VfZGV2
aWNlICp1YWNjZTsKPj4+Pj4+ICvCoMKgwqAgc3RydWN0IHVhY2NlX3F1ZXVlICpxOwo+Pj4+Pj4g
K8KgwqDCoCBpbnQgcmV0ID0gMDsKPj4+Pj4+ICsKPj4+Pj4+ICvCoMKgwqAgdWFjY2UgPSB4YV9s
b2FkKCZ1YWNjZV94YSwgaW1pbm9yKGlub2RlKSk7Cj4+Pj4+PiArwqDCoMKgIGlmICghdWFjY2Up
Cj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9ERVY7Cj4+Pj4+PiArCj4+Pj4+PiAr
wqDCoMKgIGlmICghdHJ5X21vZHVsZV9nZXQodWFjY2UtPnBhcmVudC0+ZHJpdmVyLT5vd25lcikp
Cj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9ERVY7Cj4+Pj4+IFdoeSBhcmUgeW91
IHRyeWluZyB0byBncmFiIHRoZSBtb2R1bGUgcmVmZXJlbmNlIG9mIHRoZSBwYXJlbnQgZGV2aWNl
Pwo+Pj4+PiBXaHkgaXMgdGhhdCBuZWVkZWQgYW5kIHdoYXQgaXMgdGhhdCBnb2luZyB0byBoZWxw
IHdpdGggaGVyZT8KPj4+Pj4KPj4+Pj4gVGhpcyBzaG91bGRuJ3QgYmUgbmVlZGVkIGFzIHRoZSBt
b2R1bGUgcmVmZXJlbmNlIG9mIHRoZSBvd25lciBvZiB0aGUKPj4+Pj4gZmlsZW9wcyBmb3IgdGhp
cyBtb2R1bGUgaXMgaW5jcmVtZW50ZWQsIGFuZCB0aGUgInBhcmVudCIgbW9kdWxlIAo+Pj4+PiBk
ZXBlbmRzCj4+Pj4+IG9uIHRoaXMgbW9kdWxlLCBzbyBob3cgY291bGQgaXQgYmUgdW5sb2FkZWQg
d2l0aG91dCB0aGlzIGNvZGUgYmVpbmcKPj4+Pj4gdW5sb2FkZWQ/Cj4+Pj4+Cj4+Pj4+IFllcywg
aWYgeW91IGJ1aWxkIHRoaXMgY29kZSBpbnRvIHRoZSBrZXJuZWwgYW5kIHRoZSAicGFyZW50IiAK
Pj4+Pj4gZHJpdmVyIGlzIGEKPj4+Pj4gbW9kdWxlLCB0aGVuIHlvdSB3aWxsIG5vdCBoYXZlIGEg
cmVmZXJlbmNlLCBidXQgd2hlbiB5b3UgcmVtb3ZlIHRoYXQKPj4+Pj4gcGFyZW50IGRyaXZlciB0
aGUgZGV2aWNlIHdpbGwgYmUgcmVtb3ZlZCBhcyBpdCBoYXMgdG8gYmUgdW5yZWdpc3RlcmVkCj4+
Pj4+IGJlZm9yZSB0aGF0IHBhcmVudCBkcml2ZXIgY2FuIGJlIHJlbW92ZWQgZnJvbSB0aGUgc3lz
dGVtLCByaWdodD8KPj4+Pj4KPj4+Pj4gT3Igd2hhdCBhbSBJIG1pc3NpbmcgaGVyZT8KPj4+PiBU
aGUgcmVmY291bnQgaGVyZSBpcyBwcmV2ZW50aW5nIHJtbW9kICJwYXJlbnQiIG1vZHVsZSBhZnRl
ciBmZCBpcyAKPj4+PiBvcGVuZWQsCj4+Pj4gc2luY2UgdXNlciBkcml2ZXIgaGFzIG1tYXAga2Vy
bmVsIG1lbW9yeSB0byB1c2VyIHNwYWNlLCBsaWtlIG1taW8sIAo+Pj4+IHdoaWNoIG1heQo+Pj4+
IHN0aWxsIGluLXVzZS4KPj4+Pgo+Pj4+IFdpdGggdGhlIHJlZmNvdW50IHByb3RlY3Rpb24sIHJt
bW9kICJwYXJlbnQiIG1vZHVsZSB3aWxsIGZhaWwgdW50aWwKPj4+PiBhcHBsaWNhdGlvbiBmcmVl
IHRoZSBmZC4KPj4+PiBsb2cgbGlrZTogcm1tb2Q6IEVSUk9SOiBNb2R1bGUgaGlzaV96aXAgaXMg
aW4gdXNlCj4+PiBCdXQgaWYgdGhlICJwYXJlbnQiIG1vZHVsZSBpcyB0byBiZSB1bmxvYWRlZCwg
aXQgaGFzIHRvIHVucmVnaXN0ZXIgdGhlCj4+PiAiY2hpbGQiIGRldmljZSBhbmQgdGhhdCB3aWxs
IGNhbGwgdGhlIGRlc3RydWN0b3IgaW4gaGVyZSBhbmQgdGhlbiB5b3UKPj4+IHdpbGwgdGVhciBl
dmVyeXRoaW5nIGRvd24gYW5kIGFsbCBzaG91bGQgYmUgZ29vZC4KPj4+Cj4+PiBUaGVyZSdzIG5v
IG5lZWQgdG8gImZvcmJpZCIgYSBtb2R1bGUgZnJvbSBiZWluZyB1bmxvYWRlZCwgZXZlbiBpZiBp
dCBpcwo+Pj4gYmVpbmcgdXNlZC7CoCBMb29rIGF0IGFsbCBuZXR3b3JraW5nIGRyaXZlcnMsIHRo
ZXkgd29yayB0aGF0IHdheSwgcmlnaHQ/Cj4+IFRoYW5rcyBHcmVnIGZvciB0aGUga2luZCBzdWdn
ZXN0aW9uLgo+Pgo+PiBJIHN0aWxsIGhhdmUgb25lIHVuY2VydGFpbnR5Lgo+PiBEb2VzIHVhY2Nl
IGhhcyB0byBibG9jayBwcm9jZXNzIGNvbnRpbnVlIGFjY2Vzc2luZyB0aGUgbW1hcHBlZCBhcmVh
IAo+PiB3aGVuIHJlbW92ZSAicGFyZW50IiBtb2R1bGU/Cj4+IFVhY2NlIGNhbiBibG9jayBkZXZp
Y2UgYWNjZXNzIHRoZSBwaHlzaWNhbCBtZW1vcnkgd2hlbiBwYXJlbnQgbW9kdWxlIAo+PiBjYWxs
IHVhY2NlX3JlbW92ZS4KPj4gQnV0IGFwcGxpY2F0aW9uIGlzIHN0aWxsIHJ1bm5pbmcsIGFuZCBz
dXBwb3NlIGl0IGlzIG5vdCB0aGUga2VybmVsIAo+PiBkcml2ZXIncyByZXNwb25zaWJpbGl0eSB0
byBjYWxsIHVubWFwLgo+Pgo+PiBJIGFtIGxvb2tpbmcgZm9yIHNvbWUgZXhhbXBsZXMgaW4ga2Vy
bmVsLAo+PiBsb29rcyB2ZmlvIGRvZXMgbm90IGJsb2NrIHByb2Nlc3MgY29udGludWUgYWNjZXNz
aW5nIHdoZW4gCj4+IHZmaW9fdW5yZWdpc3Rlcl9pb21tdV9kcml2ZXIgZWl0aGVyLgo+Pgo+PiBJ
biBteSB0ZXN0LCBhcHBsaWNhdGlvbiB3aWxsIGtlZXAgd2FpdGluZyBhZnRlciBybW1vZCBwYXJl
bnQsIHVudGlsIAo+PiBjdHJsK2MsIHdoZW4gdW5tYXAgaXMgY2FsbGVkLgo+PiBEdXJpbmcgdGhl
IHByb2Nlc3MsIGtlcm5lbCBkb2VzIG5vdCByZXBvcnQgYW55IGVycm9yLgo+Pgo+PiBEbyB5b3Ug
aGF2ZSBhbnkgYWR2aWNlPwo+Cj4gV291bGQgaXQgd29yayB0byBjYWxsIHVubWFwX21hcHBpbmdf
cmFuZ2UoKSBvbiB0aGUgY2hhciBkZXYgCj4gaW5vZGUtPmlfbWFwcGluZ3M/IEkgdGhpbmsgeW91
IG5lZWQgdG8gc2V0IHRoZSB2bWEtPmZhdWx0IGZ1bmN0aW9uIHB0ciAKPiBmb3IgdGhlIHZtX29w
ZXJhdGlvbnNfc3RydWN0IGluIHRoZSBvcmlnaW5hbCBtbWFwKCkuIEFmdGVyIHRoZSAKPiBtYXBw
aW5ncyBhcmUgdW5tYXBwZWQsIHlvdSBjYW4gc2V0IGEgc3RhdGUgdmFyaWFibGUgdG8gdHJpZ2dl
ciB0aGUgCj4gcmV0dXJuIG9mIFZNX0ZBVUxUX1NJR0JVUyBpbiB0aGUgLT5mYXVsdCBmdW5jdGlv
biB3aGVuIHRoZSB1c2VyIGFwcCAKPiBhY2Nlc3NlcyB0aGUgbW1hcCByZWdpb24gYWdhaW4gYW5k
IHRyaWdnZXJzIGEgcGFnZSBmYXVsdC4gVGhlIHVzZXIgYXBwIAo+IG5lZWRzIHRvIGJlIHByb2dy
YW1tZWQgdG8gY2F0Y2ggZXhjZXB0aW9ucyB0byBkZWFsIHdpdGggdGhhdC4KClRoYW5rcyBEYXZl
IGZvciB0aGUgYWR2aWNlLgpXaWxsIGxvb2sgaW50byBpdCwgbWF5IG5lZWQgc29tZSB0aW1lIHRv
IGludmVzdGlnYXRlLgpJIHdvdWxkIGxpa2UgdG8gbWFrZSBhbiBhZGRpdGlvbmFsIHBhdGNoIGZv
ciB0aGlzIGlzc3VlLCBzaW5jZSBpdCBkb2VzIApub3QgaW1wYWN0IHRoZSBtYWluIGZ1bmN0aW9u
LgoKVGhhbmtzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
