Return-Path: <SRS0=cnVx=DD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FF8C2D0A8
	for <iommu@archiver.kernel.org>; Sat, 26 Sep 2020 20:47:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 340FF20759
	for <iommu@archiver.kernel.org>; Sat, 26 Sep 2020 20:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQXfJ0JB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340FF20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A6E5386850;
	Sat, 26 Sep 2020 20:47:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n4fcHqhP7rih; Sat, 26 Sep 2020 20:47:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 02B1486803;
	Sat, 26 Sep 2020 20:47:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA71FC0859;
	Sat, 26 Sep 2020 20:47:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12295C0051
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 20:47:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 005F287164
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 20:47:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gHgfE4lxo-uc for <iommu@lists.linux-foundation.org>;
 Sat, 26 Sep 2020 20:47:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com
 [209.85.216.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 28C0A87163
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 20:47:20 +0000 (UTC)
Received: by mail-pj1-f65.google.com with SMTP id q4so1340615pjh.5
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 13:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=flpbUTh7mBOWgXDWpnvyG6c7LmGjsFBFhnUEgfVSV/k=;
 b=EQXfJ0JB0PC/pRAXXcwKvh6YBkIs2LiEhWFvvLinRQoI0tq58oWonc/+sXato3j9K8
 2rvISmxxixCpJYYaio9BarFNiEldQyyoaW2upoYSrFY2Ok1l2TNex+JuR1V/N5WXn/Tu
 F5owCcCMl0NwoGavDkewiLRMYI7rF1rmTxh4OkW8IbwC8L+ij1zrgauhkZtltOUM0ekC
 OW3nOjXHTfUaGkDKbvvgOkKJRv9Cq8P/7utzvQ8a9FO+br4HoM7Yr1SZ2YCLmeWES24Y
 a1VKRaCdLo3zJmHWXiSnL30YfB6UOqH8xrVveCtl8jk8cC6DLAsHsp2TyASXGXdhefCe
 jekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=flpbUTh7mBOWgXDWpnvyG6c7LmGjsFBFhnUEgfVSV/k=;
 b=lsO4JcNKww8wrasdYofIgr+ubYqET0DuCgsyP1/R8V6tTFzLZp3AhvLb9VV/tkL/Ac
 NrJugkoNEh9jc03ZAyFgd+C2gMiQNqahXTTz3pFQm9isrFMNqq5jCrVVCWpk7Yzg1/gm
 /80Gz8m0DIvDev87P4Ez8V2nlkmfTNcNGUK59MI/GtBXulI6hPiAOmWaDWjjWbkP1mid
 nQDJMAkoYPi7o5jLjKhVF1t9K5p7x7buGmilr5dRCR+CNR4WR5qz7RcRnvcv08/+Kkj8
 lG73bJicaRg+FOvEyYeVK/BMfnVPp2O0BCGkXBVjSU7alzop8G62RP3YGnydOKnQfpG1
 C8ow==
X-Gm-Message-State: AOAM5337k3lA8idOk81ALdwqA7M23S89HKEYCZ2Z0EgLG55j6wgdUB99
 txq4+rwFNy5k5E3uUNwVW/E=
X-Google-Smtp-Source: ABdhPJxg997HF2zPQOVeMqbZ9YSGytnZ/VLnkZo/q5GYFLjMaxx0J1AcRpMErsNZCXF7IhAFMZj1BA==
X-Received: by 2002:a17:90b:1741:: with SMTP id
 jf1mr3080921pjb.164.1601153239514; 
 Sat, 26 Sep 2020 13:47:19 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id y197sm6396914pfc.220.2020.09.26.13.47.18
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 26 Sep 2020 13:47:19 -0700 (PDT)
Date: Sat, 26 Sep 2020 13:42:22 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH 3/5] iommu/tegra-smmu: Use iommu_fwspec in
 .probe_/.attach_device()
Message-ID: <20200926204221.GA4947@Asurada-Nvidia>
References: <20200926080719.6822-1-nicoleotsuka@gmail.com>
 <20200926080719.6822-4-nicoleotsuka@gmail.com>
 <ccb95c4e-64ba-bab9-1f75-0c6d287540b0@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ccb95c4e-64ba-bab9-1f75-0c6d287540b0@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, krzk@kernel.org, jonathanh@nvidia.com,
 iommu@lists.linux-foundation.org, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org
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

SGkgRG1pdHJ5LAoKVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3IGFuZCBjb21tZW50cyEKCk9uIFNh
dCwgU2VwIDI2LCAyMDIwIGF0IDA1OjQ4OjE3UE0gKzAzMDAsIERtaXRyeSBPc2lwZW5rbyB3cm90
ZToKPiAyNi4wOS4yMDIwIDExOjA3LCBOaWNvbGluIENoZW4g0L/QuNGI0LXRgjoKPiAuLi4KPiA+
ICsJLyogTlVMTCBzbW11IHBvaW50ZXIgbWVhbnMgdGhhdCBTTU1VIGRyaXZlciBpcyBub3QgcHJv
YmVkIHlldCAqLwo+ID4gKwlpZiAodW5saWtlbHkoIXNtbXUpKQo+ID4gKwkJcmV0dXJuIEVSUl9Q
VFIoLUVQUk9CRV9ERUZFUik7Cj4gCj4gSGVsbG8sIE5pY29saW4hCj4gCj4gUGxlYXNlIGRvbid0
IHBvbGx1dGUgY29kZSB3aXRoIGxpa2VseS91bmxpa2VseS4gVGhpcyBpcyBub3QgYQo+IHBlcmZv
cm1hbmNlLWNyaXRpY2FsIGNvZGUuCgpXaWxsIGRyb3AgaXQuIFRoYW5rcy4KCj4gLi4uCj4gPiAt
c3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgdGVncmFfbWNfZHJpdmVyID0gewo+ID4gK3N0
cnVjdCBwbGF0Zm9ybV9kcml2ZXIgdGVncmFfbWNfZHJpdmVyID0gewo+ID4gIAkuZHJpdmVyID0g
ewo+ID4gIAkJLm5hbWUgPSAidGVncmEtbWMiLAo+ID4gIAkJLm9mX21hdGNoX3RhYmxlID0gdGVn
cmFfbWNfb2ZfbWF0Y2gsCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zb2MvdGVncmEvbWMuaCBi
L2luY2x1ZGUvc29jL3RlZ3JhL21jLmgKPiA+IGluZGV4IDEyMzhlMzU2NTNkMS4uNDlhNGNmNjRj
NGI5IDEwMDY0NAo+ID4gLS0tIGEvaW5jbHVkZS9zb2MvdGVncmEvbWMuaAo+ID4gKysrIGIvaW5j
bHVkZS9zb2MvdGVncmEvbWMuaAo+ID4gQEAgLTE4NCw0ICsxODQsNiBAQCBzdHJ1Y3QgdGVncmFf
bWMgewo+ID4gIGludCB0ZWdyYV9tY193cml0ZV9lbWVtX2NvbmZpZ3VyYXRpb24oc3RydWN0IHRl
Z3JhX21jICptYywgdW5zaWduZWQgbG9uZyByYXRlKTsKPiA+ICB1bnNpZ25lZCBpbnQgdGVncmFf
bWNfZ2V0X2VtZW1fZGV2aWNlX2NvdW50KHN0cnVjdCB0ZWdyYV9tYyAqbWMpOwo+ID4gIAo+ID4g
K2V4dGVybiBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIHRlZ3JhX21jX2RyaXZlcjsKPiAKPiBObyBn
bG9iYWwgdmFyaWFibGVzLCBwbGVhc2UuIFNlZSBmb3IgdGhlIGV4YW1wbGU6Cj4gCj4gaHR0cHM6
Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjUuOS1yYzYvc291cmNlL2RyaXZlcnMvZGV2ZnJl
cS90ZWdyYTIwLWRldmZyZXEuYyNMMTAwCgpXaWxsIGZpeCBpdC4gVGhhbmtzIGZvciB0aGUgZXhh
bXBsZS4KCj4gCj4gVGhlIHRlZ3JhX2dldF9tZW1vcnlfY29udHJvbGxlcigpIGlzIG5vdyBuZWVk
ZWQgYnkgbXVsdGlwbGUgVGVncmEKPiBkcml2ZXJzLCBJIHRoaW5rIGl0IHNob3VsZCBiZSBnb29k
IHRvIGhhdmUgaXQgYWRkZWQgaW50byB0aGUgTUMgZHJpdmVyCj4gYW5kIHRoZW4gbWFrZSBpdCBn
bG9iYWxseSBhdmFpbGFibGUgZm9yIGFsbCBkcml2ZXJzIGJ5IG1ha2luZyB1c2Ugb2YKPiBvZl9m
aW5kX21hdGNoaW5nX25vZGVfYW5kX21hdGNoKCkuCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bWVtb3J5L3RlZ3JhL21jLmMgYi9kcml2ZXJzL21lbW9yeS90ZWdyYS9tYy5jCj4gaW5kZXggZTFk
YjIwOWZkMmVhLi5lZDFiZDZkMDBhYWYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9tZW1vcnkvdGVn
cmEvbWMuYwo+ICsrKyBiL2RyaXZlcnMvbWVtb3J5L3RlZ3JhL21jLmMKPiBAQCAtNDMsNiArNDMs
MjkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgdGVncmFfbWNfb2ZfbWF0Y2hb
XSA9IHsKPiAgfTsKPiAgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgdGVncmFfbWNfb2ZfbWF0Y2gp
Owo+IAo+ICtzdHJ1Y3QgdGVncmFfbWMgKnRlZ3JhX2dldF9tZW1vcnlfY29udHJvbGxlcih2b2lk
KQo+ICt7Cj4gKwlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2Owo+ICsJc3RydWN0IGRldmlj
ZV9ub2RlICpucDsKPiArCXN0cnVjdCB0ZWdyYV9tYyAqbWM7Cj4gKwo+ICsJbnAgPSBvZl9maW5k
X21hdGNoaW5nX25vZGVfYW5kX21hdGNoKE5VTEwsIHRlZ3JhX21jX29mX21hdGNoLCBOVUxMKTsK
PiArCWlmICghbnApCj4gKwkJcmV0dXJuIEVSUl9QVFIoLUVOT0VOVCk7Cj4gKwo+ICsJcGRldiA9
IG9mX2ZpbmRfZGV2aWNlX2J5X25vZGUobnApOwo+ICsJb2Zfbm9kZV9wdXQobnApOwo+ICsJaWYg
KCFwZGV2KQo+ICsJCXJldHVybiBFUlJfUFRSKC1FTk9ERVYpOwo+ICsKPiArCW1jID0gcGxhdGZv
cm1fZ2V0X2RydmRhdGEocGRldik7Cj4gKwlpZiAoIW1jKQo+ICsJCXJldHVybiBFUlJfUFRSKC1F
UFJPQkVfREVGRVIpOwo+ICsKPiArCXJldHVybiBtYzsKPiArfQo+ICtFWFBPUlRfU1lNQk9MX0dQ
TCh0ZWdyYV9nZXRfbWVtb3J5X2NvbnRyb2xsZXIpOwoKV2lsbCB0cnkgdGhpcyBvbmUgYW5kIGlu
dGVncmF0ZSBpbnRvIG15IG5leHQgdmVyc2lvbi4KClRoYW5rcwpOaWMKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
