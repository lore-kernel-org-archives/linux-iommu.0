Return-Path: <SRS0=kCyf=II=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D68C433E0
	for <iommu@archiver.kernel.org>; Wed, 10 Mar 2021 20:23:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0737064FCA
	for <iommu@archiver.kernel.org>; Wed, 10 Mar 2021 20:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0737064FCA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AB2B843179;
	Wed, 10 Mar 2021 20:23:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NW3NCrl2KYBT; Wed, 10 Mar 2021 20:23:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5AA9A43138;
	Wed, 10 Mar 2021 20:23:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C365C000A;
	Wed, 10 Mar 2021 20:23:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7EF4BC0001
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 20:23:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6130C43138
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 20:23:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lGW_ILhho0dA for <iommu@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 20:23:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D738D431DE
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 20:23:00 +0000 (UTC)
Received: by mail-lj1-x22f.google.com with SMTP id q14so27330155ljp.4
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 12:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dc+9ECts2IZ064hl65L8HRp579vEHQIkiP5UJ9UmCDU=;
 b=JcqyTxSj32Bubbcc9ULL9PMQDkhWp66LFUp+Q5bW+SBrMUIrwPDF99JLyIwa39NC+e
 ERd9AM9I734yeTT2By3uvyPdlU+2yb1o1kZM/An6exRX6lzzOLhUwwk0AMGqikA0UnEQ
 ytwo+DMGNOUd2L0E4XOWABPEErNGB+siuViAuV1BjNB5WVBsy64CF2bjZGrzSEuN01v1
 /y8uY81f+/EHxlkwhJ60PT9uCr6BP3QER5WEHqeeoUDqQsPg3VDg0VuEQgesu5tP6t9l
 CrzEmxWtM+2+/kFEQ3kNV6RJeKr38dFqzyKbaBzV3RA/vvj3KwYgtxs9oepH/VxiME3r
 Yv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dc+9ECts2IZ064hl65L8HRp579vEHQIkiP5UJ9UmCDU=;
 b=GE+4VXDayHzFMjdBMfFjk60AdigEyMwhQaEFDiAjUFpr5axl2yE2YTSLRJWcz4BUAS
 qK9srdXvUQCMRu3N6ZASvWxGcJAaZI8d1AH2f1b3AVaEu1rFrOFR9TJurWzaIEHKKggu
 kLLwuKVKn/kIFoYbfaPW7dWc16OyEyi7UOZ6H4x+ikSXgWyzwjMCdyb0Om1vJ4gGb7Tm
 2yNx32M8+/069FZLIWOEqAI8buFB3KPFn6Y/h2940QjtZKCpjYPfH6PIRv/ledyijHHD
 O6Zue5MszXN7GtBscD/cVoWcTD9VhGcrigl9yhYbN48goc5EgRcdVztCCrOkFd+vC8ku
 eA8w==
X-Gm-Message-State: AOAM532g5GeGc286e+8p5+UlqnvbmA+ErY8kL42L+lFHiVxXQf0cMCJ6
 X7bgncniPBJ0gR8MLXJ70Bw=
X-Google-Smtp-Source: ABdhPJwl0AQhk01TKob1GoCfd1jHQKG3caFssOOoPSgQKNX2hT7JHB/54yyAXTrpahDh/m5eRVZGAg==
X-Received: by 2002:a2e:9bd0:: with SMTP id w16mr2741803ljj.465.1615407778621; 
 Wed, 10 Mar 2021 12:22:58 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru.
 [109.252.193.52])
 by smtp.googlemail.com with ESMTPSA id s7sm105571lfi.140.2021.03.10.12.22.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Mar 2021 12:22:58 -0800 (PST)
Subject: Re: [PATCH] iommu/tegra-smmu: Fix mc errors on tegra124-nyan
From: Dmitry Osipenko <digetx@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>, joro@8bytes.org,
 thierry.reding@gmail.com, will@kernel.org, guillaume.tucker@collabora.com
References: <20210218220702.1962-1-nicoleotsuka@gmail.com>
 <a8a7a0af-895f-9d79-410d-5dd03ebbd6dd@gmail.com>
Message-ID: <7714f272-3862-84ac-306d-86363a1c4880@gmail.com>
Date: Wed, 10 Mar 2021 23:22:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <a8a7a0af-895f-9d79-410d-5dd03ebbd6dd@gmail.com>
Content-Language: en-US
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jonathanh@nvidia.com
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

MTAuMDMuMjAyMSAyMjoxMywgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4gMTkuMDIuMjAy
MSAwMTowNywgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4+IENvbW1pdCAyNTkzOGM3M2NkNzkg
KCJpb21tdS90ZWdyYS1zbW11OiBSZXdvcmsgdGVncmFfc21tdV9wcm9iZV9kZXZpY2UoKSIpCj4+
IHJlbW92ZWQgY2VydGFpbiBoYWNrIGluIHRoZSB0ZWdyYV9zbW11X3Byb2JlKCkgYnkgcmVseWlu
ZyBvbiBJT01NVSBjb3JlIHRvCj4+IG9mX3hsYXRlIFNNTVUncyBTSUQgcGVyIGRldmljZSwgc28g
YXMgdG8gZ2V0IHJpZCBvZiB0ZWdyYV9zbW11X2ZpbmQoKSBhbmQKPj4gdGVncmFfc21tdV9jb25m
aWd1cmUoKSB0aGF0IGFyZSB0eXBpY2FsbHkgZG9uZSBpbiB0aGUgSU9NTVUgY29yZSBhbHNvLgo+
Pgo+PiBUaGlzIGFwcHJvYWNoIHdvcmtzIGZvciBib3RoIGV4aXN0aW5nIGRldmljZXMgdGhhdCBo
YXZlIERUIG5vZGVzIGFuZCBvdGhlcgo+PiBkZXZpY2VzIChsaWtlIFBDSSBkZXZpY2UpIHRoYXQg
ZG9uJ3QgZXhpc3QgaW4gRFQsIG9uIFRlZ3JhMjEwIGFuZCBUZWdyYTMKPj4gdXBvbiB0ZXN0aW5n
LiBIb3dldmVyLCBQYWdlIEZhdWx0IGVycm9ycyBhcmUgcmVwb3J0ZWQgb24gdGVncmExMjQtTnlh
bjoKPj4KPj4gICB0ZWdyYS1tYyA3MDAxOTAwMC5tZW1vcnktY29udHJvbGxlcjogZGlzcGxheTBh
OiByZWFkIEAweGZlMDU2YjQwOgo+PiAJIEVNRU0gYWRkcmVzcyBkZWNvZGUgZXJyb3IgKFNNTVUg
dHJhbnNsYXRpb24gZXJyb3IgWy0tU10pCj4+ICAgdGVncmEtbWMgNzAwMTkwMDAubWVtb3J5LWNv
bnRyb2xsZXI6IGRpc3BsYXkwYTogcmVhZCBAMHhmZTA1NmI0MDoKPj4gCSBQYWdlIGZhdWx0IChT
TU1VIHRyYW5zbGF0aW9uIGVycm9yIFstLVNdKQo+Pgo+PiBBZnRlciBkZWJ1Z2dpbmcsIEkgZm91
bmQgdGhhdCB0aGUgbWVudGlvbmVkIGNvbW1pdCBjaGFuZ2VkIHNvbWUgZnVuY3Rpb24KPj4gY2Fs
bGJhY2sgc2VxdWVuY2Ugb2YgdGVncmEtc21tdSdzLCByZXN1bHRpbmcgaW4gZW5hYmxpbmcgU01N
VSBmb3IgZGlzcGxheQo+PiBjbGllbnQgYmVmb3JlIGRpc3BsYXkgZHJpdmVyIGdldHMgaW5pdGlh
bGl6ZWQuIEkgY291bGRuJ3QgcmVwcm9kdWNlIGV4YWN0Cj4+IHNhbWUgaXNzdWUgb24gVGVncmEy
MTAgYXMgVGVncmExMjQgKGFybS0zMikgZGlmZmVycyBhdCBhcmNoLWxldmVsIGNvZGUuCj4+Cj4+
IEFjdHVhbGx5IHRoaXMgUGFnZSBGYXVsdCBpcyBhIGtub3duIGlzc3VlLCBhcyBvbiBtb3N0IG9m
IFRlZ3JhIHBsYXRmb3JtcywKPj4gZGlzcGxheSBnZXRzIGVuYWJsZWQgYnkgdGhlIGJvb3Rsb2Fk
ZXIgZm9yIHRoZSBzcGxhc2ggc2NyZWVuIGZlYXR1cmUsIHNvCj4+IGl0IGtlZXBzIGZpbGxpbmcg
dGhlIGZyYW1lYnVmZmVyIG1lbW9yeS4gQSBwcm9wZXIgZml4IHRvIHRoaXMgaXNzdWUgaXMgdG8K
Pj4gMToxIGxpbmVhciBtYXAgdGhlIGZyYW1lYnVmZmVyIG1lbW9yeSB0byBJT1ZBIHNwYWNlIHNv
IHRoZSBTTU1VIHdpbGwgaGF2ZQo+PiB0aGUgc2FtZSBhZGRyZXNzIGFzIHRoZSBwaHlzaWNhbCBh
ZGRyZXNzIGluIGl0cyBwYWdlIHRhYmxlLiBZZXQsIFRoaWVycnkKPj4gaGFzIGJlZW4gd29ya2lu
ZyBvbiB0aGUgc29sdXRpb24gYWJvdmUgZm9yIGEgeWVhciwgYW5kIGl0IGhhc24ndCBtZXJnZWQu
Cj4+Cj4+IFRoZXJlZm9yZSwgbGV0J3MgcGFydGlhbGx5IHJldmVydCB0aGUgbWVudGlvbmVkIGNv
bW1pdCB0byBmaXggdGhlIGVycm9ycy4KPj4KPj4gVGhlIHJlYXNvbiB3aHkgd2UgZG8gYSBwYXJ0
aWFsIHJldmVydCBoZXJlIGlzIHRoYXQgd2UgY2FuIHN0aWxsIHNldCBwcml2Cj4+IGluIC0+b2Zf
eGxhdGUoKSBjYWxsYmFjayBmb3IgUENJIGRldmljZXMuIE1lYW53aGlsZSwgZGV2aWNlcyBleGlz
dGluZyBpbgo+PiBEVCwgbGlrZSBkaXNwbGF5LCB3aWxsIGdvIHRocm91Z2ggdGVncmFfc21tdV9j
b25maWd1cmUoKSBhdCB0aGUgc3RhZ2Ugb2YKPj4gYnVzX3NldF9pb21tdSgpIHdoZW4gU01NVSBn
ZXRzIHByb2JlZCgpLCBhcyB3aGF0IGl0IGRpZCBiZWZvcmUgd2UgbWVyZ2VkCj4+IHRoZSBtZW50
aW9uZWQgY29tbWl0Lgo+Pgo+PiBPbmNlIHdlIGhhdmUgdGhlIGxpbmVhciBtYXAgc29sdXRpb24g
Zm9yIGZyYW1lYnVmZmVyIG1lbW9yeSwgdGhpcyBjaGFuZ2UKPj4gY2FuIGJlIGNsZWFuZWQgYXdh
eS4KPj4KPj4gW0JpZyB0aGFuayB0byBHdWlsbGF1bWUgd2hvIHJlcG9ydGVkIGFuZCBoZWxwZWQg
ZGVidWdnaW5nL3ZlcmlmaWNhdGlvbl0KPj4KPj4gRml4ZXM6IDI1OTM4YzczY2Q3OSAoImlvbW11
L3RlZ3JhLXNtbXU6IFJld29yayB0ZWdyYV9zbW11X3Byb2JlX2RldmljZSgpIikKPj4gUmVwb3J0
ZWQtYnk6IEd1aWxsYXVtZSBUdWNrZXIgPGd1aWxsYXVtZS50dWNrZXJAY29sbGFib3JhLmNvbT4K
Pj4gU2lnbmVkLW9mZi1ieTogTmljb2xpbiBDaGVuIDxuaWNvbGVvdHN1a2FAZ21haWwuY29tPgo+
PiAtLS0KPj4KPj4gR3VpbGxhdW1lLCB3b3VsZCB5b3UgcGxlYXNlIGdpdmUgYSAiVGVzdGVkLWJ5
IiB0byB0aGlzIGNoYW5nZT8gVGhhbmtzIQo+Pgo+PiAgZHJpdmVycy9pb21tdS90ZWdyYS1zbW11
LmMgfCA3MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQo+PiAgMSBmaWxl
IGNoYW5nZWQsIDcxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaW9tbXUvdGVncmEtc21tdS5jIGIvZHJpdmVycy9pb21tdS90ZWdyYS1zbW11
LmMKPj4gaW5kZXggNGEzZjA5NWExYzI2Li45N2ViNjJmNjY3ZDIgMTAwNjQ0Cj4+IC0tLSBhL2Ry
aXZlcnMvaW9tbXUvdGVncmEtc21tdS5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvdGVncmEtc21t
dS5jCj4+IEBAIC03OTgsMTAgKzc5OCw3MCBAQCBzdGF0aWMgcGh5c19hZGRyX3QgdGVncmFfc21t
dV9pb3ZhX3RvX3BoeXMoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLAo+PiAgCXJldHVybiBT
TU1VX1BGTl9QSFlTKHBmbikgKyBTTU1VX09GRlNFVF9JTl9QQUdFKGlvdmEpOwo+PiAgfQo+PiAg
Cj4+ICtzdGF0aWMgc3RydWN0IHRlZ3JhX3NtbXUgKnRlZ3JhX3NtbXVfZmluZChzdHJ1Y3QgZGV2
aWNlX25vZGUgKm5wKQo+PiArewo+PiArCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXY7Cj4+
ICsJc3RydWN0IHRlZ3JhX21jICptYzsKPj4gKwo+PiArCXBkZXYgPSBvZl9maW5kX2RldmljZV9i
eV9ub2RlKG5wKTsKPj4gKwlpZiAoIXBkZXYpCj4+ICsJCXJldHVybiBOVUxMOwo+PiArCj4+ICsJ
bWMgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsKPj4gKwlpZiAoIW1jKQo+PiArCQlyZXR1
cm4gTlVMTDsKPj4gKwo+PiArCXJldHVybiBtYy0+c21tdTsKPj4gK30KPj4gKwo+PiArc3RhdGlj
IGludCB0ZWdyYV9zbW11X2NvbmZpZ3VyZShzdHJ1Y3QgdGVncmFfc21tdSAqc21tdSwgc3RydWN0
IGRldmljZSAqZGV2LAo+PiArCQkJCXN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgKmFyZ3MpCj4+ICt7
Cj4+ICsJY29uc3Qgc3RydWN0IGlvbW11X29wcyAqb3BzID0gc21tdS0+aW9tbXUub3BzOwo+PiAr
CWludCBlcnI7Cj4+ICsKPj4gKwllcnIgPSBpb21tdV9md3NwZWNfaW5pdChkZXYsICZkZXYtPm9m
X25vZGUtPmZ3bm9kZSwgb3BzKTsKPj4gKwlpZiAoZXJyIDwgMCkgewo+PiArCQlkZXZfZXJyKGRl
diwgImZhaWxlZCB0byBpbml0aWFsaXplIGZ3c3BlYzogJWRcbiIsIGVycik7Cj4+ICsJCXJldHVy
biBlcnI7Cj4+ICsJfQo+PiArCj4+ICsJZXJyID0gb3BzLT5vZl94bGF0ZShkZXYsIGFyZ3MpOwo+
PiArCWlmIChlcnIgPCAwKSB7Cj4+ICsJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIHBhcnNlIFNX
IGdyb3VwIElEOiAlZFxuIiwgZXJyKTsKPj4gKwkJaW9tbXVfZndzcGVjX2ZyZWUoZGV2KTsKPj4g
KwkJcmV0dXJuIGVycjsKPj4gKwl9Cj4+ICsKPj4gKwlyZXR1cm4gMDsKPj4gK30KPj4gKwo+PiAg
c3RhdGljIHN0cnVjdCBpb21tdV9kZXZpY2UgKnRlZ3JhX3NtbXVfcHJvYmVfZGV2aWNlKHN0cnVj
dCBkZXZpY2UgKmRldikKPj4gIHsKPj4gLQlzdHJ1Y3QgdGVncmFfc21tdSAqc21tdSA9IGRldl9p
b21tdV9wcml2X2dldChkZXYpOwo+PiArCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBkZXYtPm9m
X25vZGU7Cj4+ICsJc3RydWN0IHRlZ3JhX3NtbXUgKnNtbXUgPSBOVUxMOwo+PiArCXN0cnVjdCBv
Zl9waGFuZGxlX2FyZ3MgYXJnczsKPj4gKwl1bnNpZ25lZCBpbnQgaW5kZXggPSAwOwo+PiArCWlu
dCBlcnI7Cj4+ICsKPj4gKwl3aGlsZSAob2ZfcGFyc2VfcGhhbmRsZV93aXRoX2FyZ3MobnAsICJp
b21tdXMiLCAiI2lvbW11LWNlbGxzIiwgaW5kZXgsCj4+ICsJCQkJCSAgJmFyZ3MpID09IDApIHsK
Pj4gKwkJc21tdSA9IHRlZ3JhX3NtbXVfZmluZChhcmdzLm5wKTsKPj4gKwkJaWYgKHNtbXUpIHsK
Pj4gKwkJCWVyciA9IHRlZ3JhX3NtbXVfY29uZmlndXJlKHNtbXUsIGRldiwgJmFyZ3MpOwo+PiAr
CQkJb2Zfbm9kZV9wdXQoYXJncy5ucCk7Cj4+ICAKPj4gKwkJCWlmIChlcnIgPCAwKQo+PiArCQkJ
CXJldHVybiBFUlJfUFRSKGVycik7Cj4+ICsKPj4gKwkJCWJyZWFrOwo+PiArCQl9Cj4+ICsKPj4g
KwkJb2Zfbm9kZV9wdXQoYXJncy5ucCk7Cj4+ICsJCWluZGV4Kys7Cj4+ICsJfQo+PiArCj4+ICsJ
c21tdSA9IGRldl9pb21tdV9wcml2X2dldChkZXYpOwo+PiAgCWlmICghc21tdSkKPj4gIAkJcmV0
dXJuIEVSUl9QVFIoLUVOT0RFVik7Cj4+ICAKPj4gQEAgLTEwMjgsNiArMTA4OCwxNiBAQCBzdHJ1
Y3QgdGVncmFfc21tdSAqdGVncmFfc21tdV9wcm9iZShzdHJ1Y3QgZGV2aWNlICpkZXYsCj4+ICAJ
aWYgKCFzbW11KQo+PiAgCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsKPj4gIAo+PiArCS8qCj4+
ICsJICogVGhpcyBpcyBhIGJpdCBvZiBhIGhhY2suIElkZWFsbHkgd2UnZCB3YW50IHRvIHNpbXBs
eSByZXR1cm4gdGhpcwo+PiArCSAqIHZhbHVlLiBIb3dldmVyIHRoZSBJT01NVSByZWdpc3RyYXRp
b24gcHJvY2VzcyB3aWxsIGF0dGVtcHQgdG8gYWRkCj4+ICsJICogYWxsIGRldmljZXMgdG8gdGhl
IElPTU1VIHdoZW4gYnVzX3NldF9pb21tdSgpIGlzIGNhbGxlZC4gSW4gb3JkZXIKPj4gKwkgKiBu
b3QgdG8gcmVseSBvbiBnbG9iYWwgdmFyaWFibGVzIHRvIHRyYWNrIHRoZSBJT01NVSBpbnN0YW5j
ZSwgd2UKPj4gKwkgKiBzZXQgaXQgaGVyZSBzbyB0aGF0IGl0IGNhbiBiZSBsb29rZWQgdXAgZnJv
bSB0aGUgLnByb2JlX2RldmljZSgpCj4+ICsJICogY2FsbGJhY2sgdmlhIHRoZSBJT01NVSBkZXZp
Y2UncyAuZHJ2ZGF0YSBmaWVsZC4KPj4gKwkgKi8KPj4gKwltYy0+c21tdSA9IHNtbXU7Cj4+ICsK
Pj4gIAlzaXplID0gQklUU19UT19MT05HUyhzb2MtPm51bV9hc2lkcykgKiBzaXplb2YobG9uZyk7
Cj4+ICAKPj4gIAlzbW11LT5hc2lkcyA9IGRldm1fa3phbGxvYyhkZXYsIHNpemUsIEdGUF9LRVJO
RUwpOwo+Pgo+IAo+IEkgZm91bmQgdGhhdCB0aGlzIHBhdGNoIGludHJvZHVjZWQgYSBzZXJpb3Vz
IHJlZ3Jlc3Npb24gb24gVGVncmEzMCB1c2luZwo+IHRvZGF5J3MgbGludXgtbmV4dC4gVGVncmEz
MCBoYXMgdHdvIDNkIGgvdyBibG9ja3MgY29ubmVjdGVkIGluIFNMSSBhbmQKPiBvbmx5IG9uZSBv
ZiB0aGUgYmxvY2tzIGlzIG5vdyBhdHRhY2hlZCB0byBJT01NVSBkb21haW4sIG1lYW5pbmcgdGhh
dCBHUFUKPiBpcyB1bnVzYWJsZSBub3cuIEFsbCAzZCwgMmQgYW5kIGRpc3BsYXkgZGV2aWNlcyBz
aGFyZSB0aGUgc2FtZSAiRFJNIgo+IGdyb3VwIG9uIFRlZ3JhMzAuCj4gCj4gTmljb2xpbiwgcGxl
YXNlIGxldCBtZSBrbm93IGlmIGhhdmUgYW55IHN1Z2dlc3Rpb25zLiBJIG1heSB0YWtlIGEgY2xv
c2VyCj4gbG9vayBhIGRheSBsYXRlciwgZm9yIG5vdyBJJ2xsIGp1c3QgcmV2ZXJ0IHRoaXMgcGF0
Y2ggbG9jYWxseS4gVGhhbmtzIGluCj4gYWR2YW5jZS4KPiAKCkFjdHVhbGx5LCB0aGlzIHdhcyBl
YXN5IHRvIGZpeDoKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L3RlZ3JhLXNtbXUuYyBiL2Ry
aXZlcnMvaW9tbXUvdGVncmEtc21tdS5jCmluZGV4IDk3ZWI2MmY2NjdkMi4uNjM5ZDVjZWFiNjBi
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2lvbW11L3RlZ3JhLXNtbXUuYworKysgYi9kcml2ZXJzL2lv
bW11L3RlZ3JhLXNtbXUuYwpAQCAtODUzLDggKzg1Myw2IEBAIHN0YXRpYyBzdHJ1Y3QgaW9tbXVf
ZGV2aWNlCip0ZWdyYV9zbW11X3Byb2JlX2RldmljZShzdHJ1Y3QgZGV2aWNlICpkZXYpCgogCQkJ
aWYgKGVyciA8IDApCiAJCQkJcmV0dXJuIEVSUl9QVFIoZXJyKTsKLQotCQkJYnJlYWs7CiAJCX0K
CiAJCW9mX25vZGVfcHV0KGFyZ3MubnApOwoKCk5pY29saW4sIHBsZWFzZSBtYWtlIGEgcHJvcGVy
IHBhdGNoLiBZb3UgbWF5IGFkZCBteSByZXBvcnRlZC1ieSBhbmQKdGVzdGVkLWJ5LgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxp
c3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
