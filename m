Return-Path: <SRS0=boqS=DN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5FCC4363A
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 01:21:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA9A207F7
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 01:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IR2segjE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA9A207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 943F885DB5;
	Tue,  6 Oct 2020 01:21:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mHay0kPb+N0w; Tue,  6 Oct 2020 01:21:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E5F8585948;
	Tue,  6 Oct 2020 01:21:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8E55C0890;
	Tue,  6 Oct 2020 01:21:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BA40C016F
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 01:21:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 82639856E9
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 01:21:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3sTtIjguuBfQ for <iommu@lists.linux-foundation.org>;
 Tue,  6 Oct 2020 01:21:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 71B2285641
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 01:21:08 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id g9so6538914pgh.8
 for <iommu@lists.linux-foundation.org>; Mon, 05 Oct 2020 18:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=0yWXKrqXMFP3HPBRZ+yjO3u40MSxEa60RyZK91ANWVM=;
 b=IR2segjEJ+qR4NMC1gYN941vKF3ypk6RnWcPXyMrNE4vaUcV6vlM++CMQo+qS6pcWt
 voww5nAAvAGxSqSW1u3KPkqNqT2J4TRkKf6OI9m7VITITXKlgpbDd2sbHSaZG7zSUO7D
 WWUeu6P4x3+FWuC12b4SLzEp1RfY/nHE5l+tf5qD/MlPRSRxbiuNnN7Vdf1LL/AH1IjZ
 OUkuhRSZ/+FpnT6KiqemDn3RY7xoT5qLEtMFxkhPNCSqjUFRZRAHCDjd2BvZOylmyoM3
 RNmH0K4LTk6mjGpWKoA+8ruiBRszLQ/7En+bg/l5oAIKGgDdFDFuNURnRcNS2p7wjikH
 u22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=0yWXKrqXMFP3HPBRZ+yjO3u40MSxEa60RyZK91ANWVM=;
 b=kl29pZLAGF/3nqkBeZqTk278NykHGTv6z2IAYBMDxgD7wc+QxNtOK5BbUeem61ZyXV
 Tf2YqvJuKZ6V3zyb7n0jk8qpdgITZnsjUj4nWiB7mOtmH4kR68GAZ+pOQkxUe60klWFC
 DqhyvIVmxPHLuTgjba2555OKs2Mor2MNzIAugThMVSWJgrplcwBtZkbXvfmJrjyKCYEx
 Y3z7sHTplLDXbLuIJPTYd+nd9W8hItn7A6X/tP5WgW8+qEIS577Plu3C6Ja1kzLo/uw5
 Av/w+hwUGNmCBhOtw5VjD9HnyQycH8qVkj2xJ5EWgoGUetUMqAsSc3gI0DRxp/tghgeq
 0Srw==
X-Gm-Message-State: AOAM532CizvtE6yMMiN1c3oM9Ht94TY30KodJoenqI7KOV/q3wNpeQW+
 ud4L6bCvlxVBmNq7NxWbu0M=
X-Google-Smtp-Source: ABdhPJz++fvdW5BO+Yg+ry6Xixb6SSNf9AXvvqMX3oHryM90ksPOZMbv+p4+XqyTLnKWNS9FnSUgEA==
X-Received: by 2002:a63:e212:: with SMTP id q18mr1900863pgh.356.1601947267951; 
 Mon, 05 Oct 2020 18:21:07 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id v205sm1283135pfc.110.2020.10.05.18.21.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 05 Oct 2020 18:21:07 -0700 (PDT)
Date: Mon, 5 Oct 2020 18:14:34 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 2/3] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
Message-ID: <20201006011434.GC28640@Asurada-Nvidia>
References: <20201003065947.18671-1-nicoleotsuka@gmail.com>
 <20201003065947.18671-3-nicoleotsuka@gmail.com>
 <4a5a5b1c-080a-327a-1e2f-dc087948e1a1@gmail.com>
 <20201004215731.GA21420@Asurada-Nvidia>
 <689c3d90-e05c-d36a-bf37-0bec100040f5@gmail.com>
 <20201005105638.GO425362@ulmo>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201005105638.GO425362@ulmo>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>
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

T24gTW9uLCBPY3QgMDUsIDIwMjAgYXQgMTI6NTY6MzhQTSArMDIwMCwgVGhpZXJyeSBSZWRpbmcg
d3JvdGU6Cj4gT24gTW9uLCBPY3QgMDUsIDIwMjAgYXQgMTE6NDE6MDhBTSArMDMwMCwgRG1pdHJ5
IE9zaXBlbmtvIHdyb3RlOgo+ID4gMDUuMTAuMjAyMCAwMDo1NywgTmljb2xpbiBDaGVuINC/0LjR
iNC10YI6Cj4gPiA+IE9uIFNhdCwgT2N0IDAzLCAyMDIwIGF0IDA1OjA2OjQyUE0gKzAzMDAsIERt
aXRyeSBPc2lwZW5rbyB3cm90ZToKPiA+ID4+IDAzLjEwLjIwMjAgMDk6NTksIE5pY29saW4gQ2hl
biDQv9C40YjQtdGCOgo+ID4gPj4+ICBzdGF0aWMgaW50IHRlZ3JhX3NtbXVfb2ZfeGxhdGUoc3Ry
dWN0IGRldmljZSAqZGV2LAo+ID4gPj4+ICAJCQkgICAgICAgc3RydWN0IG9mX3BoYW5kbGVfYXJn
cyAqYXJncykKPiA+ID4+PiAgewo+ID4gPj4+ICsJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqaW9t
bXVfcGRldiA9IG9mX2ZpbmRfZGV2aWNlX2J5X25vZGUoYXJncy0+bnApOwo+ID4gPj4+ICsJc3Ry
dWN0IHRlZ3JhX21jICptYyA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKGlvbW11X3BkZXYpOwo+ID4g
Pj4+ICAJdTMyIGlkID0gYXJncy0+YXJnc1swXTsKPiA+ID4+PiAgCj4gPiA+Pj4gKwlwdXRfZGV2
aWNlKCZpb21tdV9wZGV2LT5kZXYpOwo+ID4gPj4+ICsKPiA+ID4+PiArCWlmICghbWMgfHwgIW1j
LT5zbW11KQo+ID4gPj4+ICsJCXJldHVybiAtRVBST0JFX0RFRkVSOwo+ID4gPj4KPiA+ID4+IEkn
bSBub3QgdmVyeSBleGNpdGVkIGJ5IHNlZWluZyBjb2RlIGluIHRoZSBwYXRjaGVzIHRoYXQgY2Fu
J3QgYmUKPiA+ID4+IGV4cGxhaW5lZCBieSB0aGUgcGF0Y2ggYXV0aG9ycyBhbmQgd2lsbCBhcHBy
ZWNpYXRlIGlmIHlvdSBjb3VsZCBwcm92aWRlCj4gPiA+PiBhIGRldGFpbGVkIGV4cGxhbmF0aW9u
IGFib3V0IHdoeSB0aGlzIE5VTEwgY2hlY2tpbmcgaXMgbmVlZGVkIGJlY2F1c2UgSQo+ID4gPj4g
dGhpbmsgaXQgaXMgdW5uZWVkZWQsIGVzcGVjaWFsbHkgZ2l2ZW4gdGhhdCBvdGhlciBJT01NVSBk
cml2ZXJzIGRvbid0Cj4gPiA+PiBoYXZlIHN1Y2ggY2hlY2suCj4gPiA+IAo+ID4gPiBUaGlzIGZ1
bmN0aW9uIGNvdWxkIGJlIGNhbGxlZCBmcm9tIG9mX2lvbW11X2NvbmZpZ3VyZSgpLCB3aGljaCBp
cwo+ID4gPiBhIHBhcnQgb2Ygb3RoZXIgZHJpdmVyJ3MgcHJvYmUoKS4gU28gSSB0aGluayBpdCdz
IHNhZmVyIHRvIGhhdmUgYQo+ID4gPiBjaGVjay4gWWV0LCBnaXZlbiBtYyBkcml2ZXIgaXMgYWRk
ZWQgdG8gdGhlICJhcmNoX2luaXRjYWxsIiBzdGFnZSwKPiA+ID4geW91IGFyZSBwcm9iYWJseSBy
aWdodCB0aGF0IHRoZXJlJ3Mgbm8gcmVhbGx5IG5lZWQgYXQgdGhpcyBtb21lbnQKPiA+ID4gYmVj
YXVzZSBhbGwgY2xpZW50cyBzaG91bGQgYmUgY2FsbGVkIGFmdGVyIG1jL3NtbXUgYXJlIGluaXRl
ZC4gU28KPiA+ID4gSSdsbCByZXNlbmQgYSB2NiwgaWYgdGhhdCBtYWtlcyB5b3UgaGFwcHkuCj4g
PiAKPiA+IEkgd2FudGVkIHRvIGdldCB0aGUgZXhwbGFuYXRpb24gOikgSSdtIHZlcnkgY3VyaW91
cyB3aHkgaXQncyBhY3R1YWxseQo+ID4gbmVlZGVkIGJlY2F1c2UgSSdtIG5vdCAxMDAlIHN1cmUg
d2hldGhlciBpdCdzIG5vdCBuZWVkZWQgYXQgYWxsLgo+ID4gCj4gPiBJJ2QgYXNzdW1lIHRoYXQg
dGhlIG9ubHkgcG9zc2libGUgcHJvYmxlbSBjb3VsZCBiZSBpZiBzb21lIGRldmljZSBpcwo+ID4g
Y3JlYXRlZCBpbiBwYXJhbGxlbCB3aXRoIHRoZSBNQyBwcm9iaW5nIGFuZCB0aGVyZSBpcyBubyBs
b2NraW5nIHRoYXQKPiA+IGNvdWxkIHByZXZlbnQgdGhpcyBpbiB0aGUgZHJpdmVycyBjb3JlLiBJ
dCdzIG5vdCBhcHBhcmVudCB0byBtZSB3aGV0aGVyCj4gPiB0aGlzIHNpdHVhdGlvbiBjb3VsZCBo
YXBwZW4gYXQgYWxsIGluIHByYWN0aWNlLgo+ID4gCj4gPiBUaGUgTUMgaXMgY3JlYXRlZCBlYXJs
eSBhbmQgYXQgdGhhdCB0aW1lIGV2ZXJ5dGhpbmcgaXMgc2VxdWVudGlhbCwgc28KPiA+IGl0J3Mg
aW5kZWVkIHNob3VsZCBiZSBzYWZlIHRvIHJlbW92ZSB0aGUgY2hlY2suCj4gCj4gSSB0aGluayBJ
IG5vdyByZW1lbWJlciBleGFjdGx5IHdoeSB0aGUgImhhY2siIGluIHRlZ3JhX3NtbXVfcHJvYmUo
KQo+IGV4aXN0cy4gVGhlIHJlYXNvbiBpcyB0aGF0IHRoZSBNQyBkcml2ZXIgZG9lcyB0aGlzOgo+
IAo+IAltYy0+c21tdSA9IHRlZ3JhX3NtbXVfcHJvYmUoLi4uKTsKPiAKPiBUaGF0IG1lYW5zIHRo
YXQgbWMtPnNtbXUgaXMgZ29pbmcgdG8gYmUgTlVMTCB1bnRpbCB0ZWdyYV9zbW11X3Byb2JlKCkK
PiBoYXMgZmluaXNoZWQuIEJ1dCB0ZWdyYV9zbW11X3Byb2JlKCkgY2FsbHMgYnVzX3NldF9pb21t
dSgpIGFuZCB0aGF0IGluCj4gdHVybiBjYWxscyAtPnByb2JlX2RldmljZSgpLiBTbyB0aGUgcHVy
cG9zZSBvZiB0aGUgImhhY2siIGluIHRoZQo+IHRlZ3JhX3NtbXVfcHJvYmUoKSBmdW5jdGlvbiB3
YXMgdG8gbWFrZSBzdXJlIG1jLT5zbW11IHdhcyBhdmFpbGFibGUgYXQKPiB0aGF0IHBvaW50LCBi
ZWNhdXNlLCB3ZWxsLCBpdCBpcyBhbHJlYWR5IGtub3duLCBidXQgd2UgaGF2ZW4ndCBnb3R0ZW4K
PiBhcm91bmQgdG8gc3RvcmluZyBpdCB5ZXQuCgpZZWEsIHRoYXQncyBleGFjdGx5IHdoYXQgSSBk
ZXNjcmliZWQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIG9mIGEKbGF0ZXIgdmVyc2lvbiBvZiB0aGlz
IHBhdGNoLiBZZXQsIHdlIGNhbiBkcm9wIGl0IG5vdyBhcyBhIGRldmljZQp3aWxsIHByb2JlKCkg
YW5kIGNhbGwgLT5wcm9iZV9kZXZpY2UoKSBhZ2Fpbi4KCj4gLT5vZl94bGF0ZSgpIGNhbiB0aGVv
cmV0aWNhbGx5IGJlIGNhbGxlZCBhcyBlYXJseSBhcyByaWdodCBhZnRlcgo+IGJ1c19zZXRfaW9t
bXUoKSB2aWEgb2ZfaW9tbXVfY29uZmlndXJlKCkgaWYgdGhhdCBpcyBjYWxsZWQgaW4gcGFyYWxs
ZWwKPiB3aXRoIHRlZ3JhX3NtbXVfcHJvYmUoKS4gSSB0aGluayB0aGF0J3MgdmVyeSB1bmxpa2Vs
eSwgYnV0IEknbSBub3QgMTAwJQo+IHN1cmUgdGhhdCBpdCBjYW4ndCBoYXBwZW4uCgpBcyBteSBw
cmV2aW91cyByZXBseSB0byBEbWl0cnkgYWJvdmUsIEkgZG9uJ3QgdGhpbmsgaXQnZCBoYXBwZW4s
CmdpdmVuIHRoYXQgbWMvc21tdSBkcml2ZXJzIGFyZSBpbml0ZWQgZHVyaW5nIGFyY2hfaW5pdGNh
bGwgc3RhZ2UKd2hpbGUgYWxsIGNsaWVudHMgc2hvdWxkIGJlIHByb2JlZCBkdXJpbmcgZGV2aWNl
X2luaXRjYWxsIHN0YWdlLApvbmNlIHRoaXMgcmV3b3JrIHBhdGNoIGdldHMgbWVyZ2VkLgoKPiBJ
biBhbnkgY2FzZSwgSSBkbyBhZ3JlZSB3aXRoIERtaXRyeSB0aGF0IHdlIHNob3VsZCBoYXZlIGEg
Y29tbWVudCBoZXJlCj4gZXhwbGFpbmluZyB3aHkgdGhpcyBpcyBuZWNlc3NhcnkuIEV2ZW4gaWYg
d2UncmUgY29tcGxldGVseSBjZXJ0YWluIHRoYXQKPiB0aGlzIGlzIG5lY2Vzc2FyeSwgaXQncyBu
b3Qgb2J2aW91cyBhbmQgdGhlcmVmb3JlIHNob3VsZCBnZXQgdGhhdAo+IGNvbW1lbnQuIEFuZCBp
ZiB3ZSdyZSBub3QgY2VydGFpbiB0aGF0IGl0J3MgbmVjZXNzYXJ5LCBpdCdzIHByb2JhYmx5Cj4g
YWxzbyBnb29kIHRvIG1lbnRpb24gdGhhdCBpbiB0aGUgY29tbWVudCBzbyB0aGF0IGV2ZW50dWFs
bHkgaXQgY2FuIGJlCj4gZGV0ZXJtaW5lZCBvciB0aGUgY2hlY2sgcmVtb3ZlZCBpZiBpdCBwcm92
ZXMgdG8gYmUgdW5uZWNlc3NhcnkuCgpXZWxsLCBJIGhhdmUgYW5zd2VyZWQgaGltLCBhbmQgYWxz
byByZW1vdmVkIHRoZSBtYy9zbW11IGNoZWNrIGluCnY2IGFscmVhZHkuCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
