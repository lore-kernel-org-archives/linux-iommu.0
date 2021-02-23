Return-Path: <SRS0=j2S/=HZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69B3C433E0
	for <iommu@archiver.kernel.org>; Tue, 23 Feb 2021 05:10:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16E8264E21
	for <iommu@archiver.kernel.org>; Tue, 23 Feb 2021 05:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E8264E21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9813D605E1;
	Tue, 23 Feb 2021 05:10:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZDNwyTbwwWZb; Tue, 23 Feb 2021 05:10:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 072AA605BC;
	Tue, 23 Feb 2021 05:10:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85B53C000B;
	Tue, 23 Feb 2021 05:10:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6684C0001
 for <iommu@lists.linux-foundation.org>; Tue, 23 Feb 2021 05:10:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7F9CD832A9
 for <iommu@lists.linux-foundation.org>; Tue, 23 Feb 2021 05:10:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I0RceH86uiKI for <iommu@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 05:10:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0027483134
 for <iommu@lists.linux-foundation.org>; Tue, 23 Feb 2021 05:10:44 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id h26so9425468lfm.1
 for <iommu@lists.linux-foundation.org>; Mon, 22 Feb 2021 21:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Il79xTcmDqAf6XgpWPsurgMb0lSvbJy0MAk63OdeoEk=;
 b=dp8Y+5TX4ZXGtkpTvZ6t+nZd5AEXCU2IjUXkCuztzt9xlgYxTCFnE/380+T5Qf70RQ
 suTdGgDFNNCn6d1Gzj4MvY+5ih0kKw9Wyrom2bsnY42IhpjPaPWhZtaX8kgvkFCEz3E1
 FjwB8+eR9bIJvY57No+D1mFapKp1z/aaP4qh1CbnP+IPi2iSzAG3YD2ZV4cotnexeLmT
 f3RseJ5+B3aefvm+ntiO+vt38+FzzIgP8Qul0e/AYjrcLo07d1X+jJfXqudGyzqweFpC
 X3VqS/mVySwMD9sj5QYTUAJcu3RBynSl2e5sHnbmy+XwEEkQbLGjJJUm8SpBUei9M6dU
 L1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Il79xTcmDqAf6XgpWPsurgMb0lSvbJy0MAk63OdeoEk=;
 b=M5JOX7nvUq56qCdfEJQ5o/QfFsHbTw+/8k23axYGYQxOeu1tAR12WIz4sQV3Xncjcm
 kyokuU1L5RfRwYFAtla/eQoQW0rFsIYJU2fkCvVbMldbCMvPcdPwprCbnibk7f8FX0zo
 lG0R84G+huW9Rqm6lQe2GJoc8GC0O0zSS5ISS1z2Y18MQK0BYEtFAB/ZGKr6R1ryemgy
 LL8UqcyASSE3ojyvzQiVr5q3pb47Atx8rXjj6PgZfUhVTtd3KSdHpRfxqgj/asZ0XTiT
 +dxCmaG6xNx1s6N3dliLhGHo2ZkddDOGqbJwRg1QPNarnWx+uoUaji8mP7ORcMIKI3Tj
 Nv1Q==
X-Gm-Message-State: AOAM533qd40zga16tP1eYV4yFiPwDIFFXclRd5Grd3woN9nzYyfWXsfg
 ArO7RAqGT0RVPRuvqijx5Cg=
X-Google-Smtp-Source: ABdhPJx+/Kw4XAKnzZ7Hljj37voHLh1WXKBIBEwDoXLE02BdrgSHVIz017subWny3H/f9hu3jfTK8w==
X-Received: by 2002:a05:6512:2295:: with SMTP id
 f21mr16617041lfu.187.1614057042751; 
 Mon, 22 Feb 2021 21:10:42 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru.
 [109.252.193.52])
 by smtp.googlemail.com with ESMTPSA id t5sm1148367lfq.2.2021.02.22.21.10.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Feb 2021 21:10:42 -0800 (PST)
Subject: Re: [PATCH] iommu/tegra-smmu: Fix mc errors on tegra124-nyan
To: Nicolin Chen <nicoleotsuka@gmail.com>
References: <20210218220702.1962-1-nicoleotsuka@gmail.com>
 <9d6445c0-9574-1650-e327-32b11716f87e@gmail.com>
 <20210223021343.GA6539@Asurada-Nvidia>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <79bb1248-497f-8adf-663b-74448bea3849@gmail.com>
Date: Tue, 23 Feb 2021 08:10:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210223021343.GA6539@Asurada-Nvidia>
Content-Language: en-US
Cc: guillaume.tucker@collabora.com, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 will@kernel.org, linux-kernel@vger.kernel.org
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

MjMuMDIuMjAyMSAwNToxMywgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gSGkgRG1pdHJ5LAo+
IAo+IE9uIFNhdCwgRmViIDIwLCAyMDIxIGF0IDA4OjE2OjIyQU0gKzAzMDAsIERtaXRyeSBPc2lw
ZW5rbyB3cm90ZToKPj4gMTkuMDIuMjAyMSAwMTowNywgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6
Cj4+PiBDb21taXQgMjU5MzhjNzNjZDc5ICgiaW9tbXUvdGVncmEtc21tdTogUmV3b3JrIHRlZ3Jh
X3NtbXVfcHJvYmVfZGV2aWNlKCkiKQo+Pj4gcmVtb3ZlZCBjZXJ0YWluIGhhY2sgaW4gdGhlIHRl
Z3JhX3NtbXVfcHJvYmUoKSBieSByZWx5aW5nIG9uIElPTU1VIGNvcmUgdG8KPj4+IG9mX3hsYXRl
IFNNTVUncyBTSUQgcGVyIGRldmljZSwgc28gYXMgdG8gZ2V0IHJpZCBvZiB0ZWdyYV9zbW11X2Zp
bmQoKSBhbmQKPj4+IHRlZ3JhX3NtbXVfY29uZmlndXJlKCkgdGhhdCBhcmUgdHlwaWNhbGx5IGRv
bmUgaW4gdGhlIElPTU1VIGNvcmUgYWxzby4KPj4+Cj4+PiBUaGlzIGFwcHJvYWNoIHdvcmtzIGZv
ciBib3RoIGV4aXN0aW5nIGRldmljZXMgdGhhdCBoYXZlIERUIG5vZGVzIGFuZCBvdGhlcgo+Pj4g
ZGV2aWNlcyAobGlrZSBQQ0kgZGV2aWNlKSB0aGF0IGRvbid0IGV4aXN0IGluIERULCBvbiBUZWdy
YTIxMCBhbmQgVGVncmEzCj4+PiB1cG9uIHRlc3RpbmcuIEhvd2V2ZXIsIFBhZ2UgRmF1bHQgZXJy
b3JzIGFyZSByZXBvcnRlZCBvbiB0ZWdyYTEyNC1OeWFuOgo+Pj4KPj4+ICAgdGVncmEtbWMgNzAw
MTkwMDAubWVtb3J5LWNvbnRyb2xsZXI6IGRpc3BsYXkwYTogcmVhZCBAMHhmZTA1NmI0MDoKPj4+
IAkgRU1FTSBhZGRyZXNzIGRlY29kZSBlcnJvciAoU01NVSB0cmFuc2xhdGlvbiBlcnJvciBbLS1T
XSkKPj4+ICAgdGVncmEtbWMgNzAwMTkwMDAubWVtb3J5LWNvbnRyb2xsZXI6IGRpc3BsYXkwYTog
cmVhZCBAMHhmZTA1NmI0MDoKPj4+IAkgUGFnZSBmYXVsdCAoU01NVSB0cmFuc2xhdGlvbiBlcnJv
ciBbLS1TXSkKPj4+Cj4+PiBBZnRlciBkZWJ1Z2dpbmcsIEkgZm91bmQgdGhhdCB0aGUgbWVudGlv
bmVkIGNvbW1pdCBjaGFuZ2VkIHNvbWUgZnVuY3Rpb24KPj4+IGNhbGxiYWNrIHNlcXVlbmNlIG9m
IHRlZ3JhLXNtbXUncywgcmVzdWx0aW5nIGluIGVuYWJsaW5nIFNNTVUgZm9yIGRpc3BsYXkKPj4+
IGNsaWVudCBiZWZvcmUgZGlzcGxheSBkcml2ZXIgZ2V0cyBpbml0aWFsaXplZC4gSSBjb3VsZG4n
dCByZXByb2R1Y2UgZXhhY3QKPj4+IHNhbWUgaXNzdWUgb24gVGVncmEyMTAgYXMgVGVncmExMjQg
KGFybS0zMikgZGlmZmVycyBhdCBhcmNoLWxldmVsIGNvZGUuCj4+Cj4+IEhlbGxvIE5pY29saW4s
Cj4+Cj4+IENvdWxkIHlvdSBwbGVhc2UgZXhwbGFpbiBpbiBhIG1vcmUgZGV0YWlscyB3aGF0IGV4
YWN0bHkgbWFrZXMgdGhlCj4+IGRpZmZlcmVuY2UgZm9yIHRoZSBjYWxsYmFjayBzZXF1ZW5jZT8K
PiAKPiBIZXJlIGlzIGEgbG9nIHdpdGggNS4xMS4wLXJjNjoKPiBodHRwczovL2xhdmEuY29sbGFi
b3JhLmNvLnVrL3NjaGVkdWxlci9qb2IvMzE4Nzg0OQo+IFtkdW1wX3N0YWNrIHdhcyBhZGRlZCBp
biBzb21lIHRlZ3JhLXNtbXUgZnVuY3Rpb25zXQo+IAo+IEFuZCBoZXJlIGlzIGEgY29ycmVzcG9u
ZGluZyBsb2cgd2l0aCByZXZlcnRpbmcgdGhlIG9yaWdpbmFsIGNvbW1pdDoKPiBodHRwczovL2xh
dmEuY29sbGFib3JhLmNvLnVrL3NjaGVkdWxlci9qb2IvMzE4Nzg1MQo+IAo+IEhlcmUgaXMgYSBs
b2cgd2l0aCA1LjExLjAtcmM3LW5leHQtMjAyMTAyMTA6Cj4gaHR0cHM6Ly9sYXZhLmNvbGxhYm9y
YS5jby51ay9zY2hlZHVsZXIvam9iLzMyMTAyNDUKPiAKPiBBbmQgaGVyZSBpcyBhIGNvcnJlc3Bv
bmRpbmcgbG9nIHdpdGggcmV2ZXJ0aW5nIHRoZSBvcmlnaW5hbCBjb21taXQ6Cj4gaHR0cHM6Ly9s
YXZhLmNvbGxhYm9yYS5jby51ay9zY2hlZHVsZXIvam9iLzMyMTA1OTYKPiAKPiBCb3RoIGZhaWxp
bmcgbG9ncyBzaG93IHRoYXQgbWMgZXJyb3JzIHN0YXJ0ZWQgcmlnaHQgYWZ0ZXIgY2xpZW50IERD
Cj4gZ290IGVuYWJsZWQgYnkgLT5hdHRhY2hfZGV2KCkgY2FsbGJhY2sgdGhhdCBpbiB0aGUgcGFz
c2luZyBsb2dzIHdhcwo+IG5vdCBjYWxsZWQgdW50aWwgSG9zdDF4IGRyaXZlciBpbml0LiBBbmQg
bm90ZSB0aGF0IHR3byBmYWlsaW5nIGxvZ3MKPiBzaG93IHRoYXQgLT5hdHRhY2hfZGV2KCkgY291
bGQgYmUgY2FsbGVkIGZyb20gdHdvIGRpZmZlcmVudCBzb3VyY2VzLAo+IG9mX2RtYV9jb25maWd1
cmVfaWQoKSBvciBhcmNoX3NldHVwX2RtYV9vcHMoKS4KPiAKPiBUaGUgcmVhc29uIHdoeSAtPmF0
dGFjaF9kZXYoKSBnZXRzIGNhbGxlZCBpcyBwcm9iYWJseSByZWxhdGVkIHRvIHRoZQo+IGZvbGxv
d2luZyByZWFzb25zIChzb3JyeSwgY2FuJ3QgYmUgMTAwJSBzdXJlIGFzIEkgZG9uJ3QgaGF2ZSBU
ZWdyYTEyNAo+IG9yIG90aGVyIDMyYml0IFRlZ3JhIGJvYXJkIHRvIHRlc3QpOgo+IDEpIFdpdGgg
dGhlIGNvbW1pdCByZXZlcnRlZCwgYWxsIGNsaWVudHMgYXJlIHByb2JlZCBpbiAiYXJjaCIgc3Rh
Z2UsCj4gICAgd2hpY2ggaXMgZXZlbiBwcmlvciB0byBpb21tdSBjb3JlIGluaXRpYWxpemF0aW9u
IC0tIGluY2x1ZGluZyBpdAo+ICAgIHNldHRpbmcgZGVmYXVsdCBkb21haW4gdHlwZS4gVGhpcyBw
cm9iYWJseSBtZXNzZWQgdXAgdGhlIHR5cGUgb2YKPiAgICBhbGxvY2F0aW5nIGRvbWFpbnMgYWdh
aW5zdCB0aGUgZGVmYXVsdCBkb21haW4gdHlwZS4gQWxzbyBpbnRlcm5hbAo+ICAgIGdyb3VwIGlz
IHNvbWVob3cgYWZmZWN0ZWQuIFNvIHNvbWUgY29uZGl0aW9uIGNoZWNrIGluIGlvbW11IGNvcmUK
PiAgICBmYWlsZWQgYW5kIHRoZW4gaXQgYnlwYXNzZWQgLT5hdHRhY2hfZGV2IGNhbGxiYWNrIGlu
IHJlYWxseV9wcm9iZQo+ICAgIHN0YWdlLCB1bnRpbCBIb3N0MXggZHJpdmVyIGRvZXMgYXR0YWNo
X2RldiBhZ2Fpbi4KPiAKPiAyKSAzMmJpdCBBUk0gaGFzIGFyY2hfc2V0dXBfZG1hX29wcygpIGRv
ZXMgYW4gYWRkaXRpb25hbCBzZXQgb2YgaW9tbXUKPiAgICBkb21haW4gYWxsb2NhdGlvbiArIGF0
dGFjaF9kZXYoKSwgYWZ0ZXIgb2ZfZG1hX2NvbmZpZ3VyZV9pZCgpIGRpZAo+ICAgIG9uY2UuIFRo
aXMgaXNuJ3QgcmVwcm9kdWNpYmxlIGZvciBtZSBvbiBUZWdyYTIxMC4KPiAKPiBBcyBkZWJ1Z2dp
bmcgb25saW5lIGlzbid0IHZlcnkgZWZmaWNpZW50LCBhbmQgZ2l2ZW4gdGhhdCBUaGllcnJ5IGhh
cwo+IGJlZW4gd29ya2luZyBvbiB0aGUgbGluZWFyIG1hcHBpbmcgb2YgZnJhbWVidWZmZXIgY2Fy
dmVvdXQsIEkgY2hvb3NlCj4gdG8gcGFydGlhbGx5IHJldmVydCBhcyBhIHF1aWNrIGZpeC4KClRo
ZSBwYXJ0aWFsbHkgcmV2ZXJ0IHNob3VsZCBiZSBva2F5LCBidXQgaXQncyBub3QgY2xlYXIgdG8g
bWUgd2hhdCBtYWtlcwpkaWZmZXJlbmNlIGZvciBUMTI0IHNpbmNlIEkgZG9uJ3Qgc2VlIHRoYXQg
cHJvYmxlbSBvbiBUMzAsIHdoaWNoIGFsc28KaGFzIGFjdGl2ZSBkaXNwbGF5IGF0IGEgYm9vdCB0
aW1lLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
