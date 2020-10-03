Return-Path: <SRS0=7D56=DK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D92C41604
	for <iommu@archiver.kernel.org>; Sat,  3 Oct 2020 14:19:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9F70206F8
	for <iommu@archiver.kernel.org>; Sat,  3 Oct 2020 14:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEc4myML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F70206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 88D23868DB;
	Sat,  3 Oct 2020 14:19:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a-AWFS6tIgSs; Sat,  3 Oct 2020 14:19:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1F8A6868C9;
	Sat,  3 Oct 2020 14:19:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1A74C016F;
	Sat,  3 Oct 2020 14:19:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC8E9C0051
 for <iommu@lists.linux-foundation.org>; Sat,  3 Oct 2020 14:19:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C55C5870FE
 for <iommu@lists.linux-foundation.org>; Sat,  3 Oct 2020 14:19:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SYJhn9laIdEN for <iommu@lists.linux-foundation.org>;
 Sat,  3 Oct 2020 14:19:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id ABB3887064
 for <iommu@lists.linux-foundation.org>; Sat,  3 Oct 2020 14:19:09 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id b19so3517295lji.11
 for <iommu@lists.linux-foundation.org>; Sat, 03 Oct 2020 07:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jN8VgN7S7pjs1PzOSOFLnFJnbrtuHTaGBpTaIB/dfig=;
 b=BEc4myMLhmq3tcDouty00YxzIuK9lSi+P6qlkY/aLnpDlv3/3D+YMgHkXTlfim0OXb
 53/sDvTtdx54B3xoyPajsSTnkGJZqdBHzNFNAHOBGq6IPW2J39XcgPDHgb9SF8N2MOGt
 1Rovttm9dRUi3GQhYc3HOCB5jmtT+W90vIhnfQDDyxv0nO8XanOEwFfyzA+lLPjW/zXY
 wGAR5ni75OnVz8Y3dJUmQ6adIPuZhciuECOS7HLZ+i6qU1n8ikwBc0BmEJKwNOxZDo/w
 LGvSQ5L32fJUAO+GzIlp+o9vUHmKq5lU/N0tkpmXruD/oUbRelW6E/78TP7eD7VqZ8ko
 vqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jN8VgN7S7pjs1PzOSOFLnFJnbrtuHTaGBpTaIB/dfig=;
 b=UooBw1zr8mtSlw8p1Ua2jB+NNb7yU/i/P44UtW8hRbNUcpEQOUTn9RB8P11ib2riyd
 BSoUt+TEb1Ore9HLdmE6o85Cey/pzRMqx5UpbzZ1SKOjgbYo06mClVTwzdlyQ6tsTNe1
 LCzEjtcTb81nOoTH+BGIH4L8vu9eaSTMv5pVki/PWl35rTR6E/x0P5EDeyphFEebTP2B
 yblaUW52DgTr8K4hBJkTXK020wItvWm4OuMVEgxr434b0Fkm7+sH5irSv3jXw64k+P+j
 VomqUNNsXtwNvo8NT+6vrSauux6i4JokCBWeMmXoea6aRnDSbhlN46A/CAz7um5jQBWW
 i6Hg==
X-Gm-Message-State: AOAM5307bJJtiMqJHlEwqbhuxUUP2aqONmZGNcZJBUIALxRPQ6gRGHt4
 2a4WoASKyYIEqk8FA/DBH7s=
X-Google-Smtp-Source: ABdhPJz8HRkiH2e6yJaKfQVsXBwbSCTParLvavlh7kezkqoMDYHYISv/d74+Ey8VVb+z5CjBdiRViQ==
X-Received: by 2002:a2e:b006:: with SMTP id y6mr1782981ljk.462.1601734747881; 
 Sat, 03 Oct 2020 07:19:07 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-252.nat.spd-mgts.ru.
 [109.252.91.252]) by smtp.googlemail.com with ESMTPSA id
 i139sm1645750lfi.276.2020.10.03.07.19.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 07:19:07 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org
References: <20201003065947.18671-1-nicoleotsuka@gmail.com>
 <20201003065947.18671-3-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <386737ab-83e3-9424-66d9-afff04092599@gmail.com>
Date: Sat, 3 Oct 2020 17:19:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201003065947.18671-3-nicoleotsuka@gmail.com>
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

MDMuMTAuMjAyMCAwOTo1OSwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gVGhlIGJ1c19zZXRf
aW9tbXUoKSBpbiB0ZWdyYV9zbW11X3Byb2JlKCkgZW51bWVyYXRlcyBhbGwgY2xpZW50cwo+IHRv
IGNhbGwgaW4gdGVncmFfc21tdV9wcm9iZV9kZXZpY2UoKSB3aGVyZSBlYWNoIGNsaWVudCBzZWFy
Y2hlcwo+IGl0cyBEVCBub2RlIGZvciBzbW11IHBvaW50ZXIgYW5kIHN3Z3JvdXAgSUQsIHNvIGFz
IHRvIGNvbmZpZ3VyZQo+IGFuIGZ3c3BlYy4gQnV0IHRoaXMgcmVxdWlyZXMgYSB2YWxpZCBzbW11
IHBvaW50ZXIgZXZlbiBiZWZvcmUgbWMKPiBhbmQgc21tdSBkcml2ZXJzIGFyZSBwcm9iZWQuIFNv
IGluIHRlZ3JhX3NtbXVfcHJvYmUoKSB3ZSBhZGRlZCBhCj4gbGluZSBvZiBjb2RlIHRvIGZpbGwg
bWMtPnNtbXUsIG1hcmtpbmcgImEgYml0IG9mIGEgaGFjayIuCj4gCj4gVGhpcyB3b3JrcyBmb3Ig
bW9zdCBvZiBjbGllbnRzIGluIHRoZSBEVEIsIGhvd2V2ZXIsIGRvZXNuJ3Qgd29yawo+IGZvciBh
IGNsaWVudCB0aGF0IGRvZXNuJ3QgZXhpc3QgaW4gRFRCLCBhIFBDSSBkZXZpY2UgZm9yIGV4YW1w
bGUuCj4gCj4gQWN0dWFsbHksIGlmIHdlIHJldHVybiBFUlJfUFRSKC1FTk9ERVYpIGluIC0+cHJv
YmVfZGV2aWNlKCkgd2hlbgo+IGl0J3MgY2FsbGVkIGZyb20gYnVzX3NldF9pb21tdSgpLCBpb21t
dSBjb3JlIHdpbGwgbGV0IGV2ZXJ5dGhpbmcKPiBjYXJyeSBvbi4gVGhlbiB3aGVuIGEgY2xpZW50
IGdldHMgcHJvYmVkLCBvZl9pb21tdV9jb25maWd1cmUoKSBpbgo+IGlvbW11IGNvcmUgd2lsbCBz
ZWFyY2ggRFRCIGZvciBzd2dyb3VwIElEIGFuZCBjYWxsIC0+b2ZfeGxhdGUoKQo+IHRvIHByZXBh
cmUgYW4gZndzcGVjLCBzaW1pbGFyIHRvIHRlZ3JhX3NtbXVfcHJvYmVfZGV2aWNlKCkgYW5kCj4g
dGVncmFfc21tdV9jb25maWd1cmUoKS4gVGhlbiBpdCdsbCBjYWxsIHRlZ3JhX3NtbXVfcHJvYmVf
ZGV2aWNlKCkKPiBhZ2FpbiwgYW5kIHRoaXMgdGltZSB3ZSBzaGFsbCByZXR1cm4gc21tdS0+aW9t
bXUgcG9pbnRlciBwcm9wZXJseS4KPiAKPiBTbyB3ZSBjYW4gZ2V0IHJpZCBvZiB0ZWdyYV9zbW11
X2ZpbmQoKSBhbmQgdGVncmFfc21tdV9jb25maWd1cmUoKQo+IGFsb25nIHdpdGggRFQgcG9sbGlu
ZyBjb2RlIGJ5IGxldHRpbmcgdGhlIGlvbW11IGNvcmUgaGFuZGxlIGV2ZXJ5Cj4gdGhpbmcsIGV4
Y2VwdCBhIHByb2JsZW0gdGhhdCB3ZSBzZWFyY2ggaW9tbXVzIHByb3BlcnR5IGluIERUQiBub3QK
PiBvbmx5IGZvciBzd2dyb3VwIElEIGJ1dCBhbHNvIGZvciBtYyBub2RlIHRvIGdldCBtYy0+c21t
dSBwb2ludGVyCj4gdG8gY2FsbCBkZXZfaW9tbXVfcHJpdl9zZXQoKSBhbmQgcmV0dXJuIHRoZSBz
bW11LT5pb21tdSBwb2ludGVyLgo+IFNvIHdlJ2xsIG5lZWQgdG8gZmluZCBhbm90aGVyIHdheSB0
byBnZXQgc21tdSBwb2ludGVyLgo+IAo+IFJlZmVyZW5jaW5nIHRoZSBpbXBsZW1lbnRhdGlvbiBv
ZiBzdW41MGktaW9tbXUgZHJpdmVyLCBvZl94bGF0ZSgpCj4gaGFzIGNsaWVudCdzIGRldiBwb2lu
dGVyLCBtYyBub2RlIGFuZCBzd2dyb3VwIElELiBUaGlzIG1lYW5zIHRoYXQKPiB3ZSBjYW4gY2Fs
bCBkZXZfaW9tbXVfcHJpdl9zZXQoKSBpbiBvZl94bGF0ZSgpIGluc3RlYWQsIHNvIHdlIGNhbgo+
IHNpbXBseSBnZXQgc21tdSBwb2ludGVyIGluIC0+cHJvYmVfZGV2aWNlKCkuCj4gCj4gVGhpcyBw
YXRjaCByZXdvcmtzIHRlZ3JhX3NtbXVfcHJvYmVfZGV2aWNlKCkgYnk6Cj4gMSkgUmVtb3Zpbmcg
bWMtPnNtbXUgaGFjayBpbiB0ZWdyYV9zbW11X3Byb2JlKCkgc28gYXMgdG8gcmV0dXJuCj4gICAg
RVJSX1BUUigtRU5PREVWKSBpbiB0ZWdyYV9zbW11X3Byb2JlX2RldmljZSgpIGR1cmluZyBzdGFn
ZSBvZgo+ICAgIHRlZ3JhX3NtbXVfcHJvYmUvdGVncmFfbWNfcHJvYmUoKS4KPiAyKSBNb3Zpbmcg
ZGV2X2lvbW11X3ByaXZfc2V0KCkgdG8gb2ZfeGxhdGUoKSBzbyB3ZSBjYW4gZ2V0IHNtbXUKPiAg
ICBwb2ludGVyIGluIHRlZ3JhX3NtbXVfcHJvYmVfZGV2aWNlKCkgdG8gcmVwbGFjZSBEVEIgcG9s
bGluZy4KPiAzKSBSZW1vdmluZyB0ZWdyYV9zbW11X2NvbmZpZ3VyZSgpIGFjY29yZGluZ2x5IHNp
bmNlIGlvbW11IGNvcmUKPiAgICB0YWtlcyBjYXJlIG9mIGl0Lgo+IAo+IFRoaXMgYWxzbyBmaXhl
cyBhIHByb2JsZW0gdGhhdCBwcmV2aW91c2x5IHdlIGFkZGVkIGFsbCBjbGllbnRzIHRvCj4gaW9t
bXUgZ3JvdXBzIGJlZm9yZSBpb21tdSBjb3JlIGluaXRpYWxpemVzIGl0cyBkZWZhdWx0IGRvbWFp
bjoKPiAgICAgdWJ1bnR1QGpldHNvbjp+JCBkbWVzZyB8IGdyZXAgaW9tbXUKPiAgICAgcGxhdGZv
cm0gc21tdV9iZW5jaG1hcms6IEFkZGluZyB0byBpb21tdSBncm91cCAwCj4gICAgIHBsYXRmb3Jt
IDEwMDMwMDAucGNpZTogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDEKPiAgICAgcGxhdGZvcm0gNTAw
MDAwMDAuaG9zdDF4OiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMgo+ICAgICBwbGF0Zm9ybSA1NzAw
MDAwMC5ncHU6IEFkZGluZyB0byBpb21tdSBncm91cCAzCj4gICAgIHBsYXRmb3JtIDcwMDBjNDAw
LmkyYzogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDQKPiAgICAgcGxhdGZvcm0gNzAwMGM1MDAuaTJj
OiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgNAo+ICAgICBwbGF0Zm9ybSA3MDAwYzcwMC5pMmM6IEFk
ZGluZyB0byBpb21tdSBncm91cCA0Cj4gICAgIHBsYXRmb3JtIDcwMDBkMDAwLmkyYzogQWRkaW5n
IHRvIGlvbW11IGdyb3VwIDQKPiAgICAgaW9tbXU6IERlZmF1bHQgZG9tYWluIHR5cGU6IFRyYW5z
bGF0ZWQKPiAKPiBUaG91Z2ggaXQgd29ya3MgZmluZSB3aXRoIElPTU1VX0RPTUFJTl9VTk1BTkFH
RUQsIGJ1dCB3aWxsIGhhdmUKPiB3YXJuaW5ncyBpZiBzd2l0Y2hpbmcgdG8gSU9NTVVfRE9NQUlO
X0RNQToKPiAgICAgaW9tbXU6IEZhaWxlZCB0byBhbGxvY2F0ZSBkZWZhdWx0IElPTU1VIGRvbWFp
biBvZiB0eXBlIDAgZm9yCj4gICAgICAgICAgICBncm91cCAobnVsbCkgLSBGYWxsaW5nIGJhY2sg
dG8gSU9NTVVfRE9NQUlOX0RNQQo+ICAgICBpb21tdTogRmFpbGVkIHRvIGFsbG9jYXRlIGRlZmF1
bHQgSU9NTVUgZG9tYWluIG9mIHR5cGUgMCBmb3IKPiAgICAgICAgICAgIGdyb3VwIChudWxsKSAt
IEZhbGxpbmcgYmFjayB0byBJT01NVV9ET01BSU5fRE1BCj4gCj4gTm93LCBieXBhc3NpbmcgdGhl
IGZpcnN0IHByb2JlX2RldmljZSgpIGNhbGwgZnJvbSBidXNfc2V0X2lvbW11KCkKPiBmaXhlcyB0
aGUgc2VxdWVuY2U6Cj4gICAgIHVidW50dUBqZXRzb246fiQgZG1lc2cgfCBncmVwIGlvbW11Cj4g
ICAgIGlvbW11OiBEZWZhdWx0IGRvbWFpbiB0eXBlOiBUcmFuc2xhdGVkIAo+ICAgICB0ZWdyYS1p
MmMgNzAwMGM0MDAuaTJjOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMAo+ICAgICB0ZWdyYS1pMmMg
NzAwMGM1MDAuaTJjOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMAo+ICAgICB0ZWdyYS1pMmMgNzAw
MGQwMDAuaTJjOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMAo+ICAgICB0ZWdyYS1wY2llIDEwMDMw
MDAucGNpZTogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDEKPiAgICAgLi4uCj4gCj4gTm90ZSB0aGF0
IGRtZXNnIGxvZyBhYm92ZSBpcyB0ZXN0aW5nIHdpdGggSU9NTVVfRE9NQUlOX1VOTUFOQUdFRC4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBOaWNvbGluIENoZW4gPG5pY29sZW90c3VrYUBnbWFpbC5jb20+
Cj4gLS0tCgpFdmVyeXRoaW5nIGxvb2tzIGdvb2QgdG8gbWUsIGFwYXJ0IGZyb20gdGhlIHZlcnkg
bWlub3IgcGVuZGluZyBxdWVzdGlvbgphYm91dCB0aGUgTlVMTC1jaGVja2luZy4gVGhhbmtzIQoK
UmV2aWV3ZWQtYnk6IERtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT4KVGVzdGVkLWJ5
OiBEbWl0cnkgT3NpcGVua28gPGRpZ2V0eEBnbWFpbC5jb20+Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ==
