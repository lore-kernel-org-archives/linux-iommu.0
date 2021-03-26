Return-Path: <SRS0=A+5j=IY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437B2C433E0
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 16:56:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2B9E61A2A
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 16:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B9E61A2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5936A405F5;
	Fri, 26 Mar 2021 16:56:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DV-RwmbmwExW; Fri, 26 Mar 2021 16:56:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3E215405E4;
	Fri, 26 Mar 2021 16:56:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED4C4C000D;
	Fri, 26 Mar 2021 16:56:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81579C000A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 16:56:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5A9BA84C8F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 16:56:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 20F9ABtSA561 for <iommu@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 16:55:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8C39A84C8A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 16:55:59 +0000 (UTC)
Received: by mail-lj1-x22c.google.com with SMTP id u20so8102022lja.13
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 09:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lhyOjxCs+l3MNv905gvs5Nsa/THv4syTxxBwZP4KE3k=;
 b=s1LmS7BwlxUC5fYMpsY/r5C0k4N6uMyMEUBhMb17FwH4VuESuMHAMS+KHxbscsX19N
 i4xsWCLrCi+OI7Bid2JBoFbyPFGc5h2P8lh2A6GVQqGP+zv95VqHmvO07Iv5aehTID9i
 7W2rceZ6u8ep51Mhbji64UpFRI8zxu2QDAzy/tG/dsVL179EvspQNrqNe1GrZ0ghrYQl
 hckCvtWHouLxJS+QsUL4MuFUAGgy4ATUv2Oo3Cta5KdURJ53AVSf5pQzVWfMpxztFCrI
 YzEqH2ajthweRg/ivIiA0k2nJIHYXGGTEafm6/a7Plbe75862iA6ctEzGlRzDmslkQ9R
 PnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lhyOjxCs+l3MNv905gvs5Nsa/THv4syTxxBwZP4KE3k=;
 b=SNyeHOmZrZrqhnXB1L6BXZUX46cDS8n6XBKB23C3yLn7PyvBCYJ3Bzt1PSZRsfVgq/
 lzyNpU8837OoYJpvzeI3QYoIQcf7EaJrPJ1cdgtIao7VldLfaCskvLbeqrstIUgXs/yR
 Son6MtS+ZFzW+xRzYlbeCJ879OIA1kIPRc9NqqZ/VL+sGsgs/HQJVndHJOmdVExvf0YC
 3DoURYgH/cueJvypTZt9G7xGXymjAovL9hV3qvQNE2jquWISvTvPU36GBRajbN1OG3B8
 nJnCSm6YRsweZ8pACCGWqgNSqwuPMZfaYneixQEYPpM5eed8rhK2KToZfE8A9+m2yr4d
 U/BA==
X-Gm-Message-State: AOAM532QVWSmtNwdNPXrvPtOHgf5tx4zzzOIkDftwtZsIgOhsT0bQHv+
 v2giYJZs4UIfCgoXlpdUnC0=
X-Google-Smtp-Source: ABdhPJxK3x5g1sh4ng3XERSxCJLJcMj4mSTpotrlnRxwSesJwLiNTIVymxaoExRzGAnlMWjU9yZeMQ==
X-Received: by 2002:a2e:8e36:: with SMTP id r22mr9826222ljk.427.1616777757503; 
 Fri, 26 Mar 2021 09:55:57 -0700 (PDT)
Received: from ?IPv6:2a00:1370:814d:99a9:a10:76ff:fe69:21b6?
 ([2a00:1370:814d:99a9:a10:76ff:fe69:21b6])
 by smtp.googlemail.com with ESMTPSA id x13sm1232656ljj.4.2021.03.26.09.55.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Mar 2021 09:55:57 -0700 (PDT)
Subject: Re: [PATCH 0/9] arm64: tegra: Prevent early SMMU faults
To: Thierry Reding <thierry.reding@gmail.com>
References: <20210325130332.778208-1-thierry.reding@gmail.com>
 <197876d1-0046-f673-5d3e-818d1002542b@gmail.com>
 <YF4NQPee+/Qi6zVd@orome.fritz.box>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9f1a8455-f7a6-1f66-f36c-032abacf71f5@gmail.com>
Date: Fri, 26 Mar 2021 19:55:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YF4NQPee+/Qi6zVd@orome.fritz.box>
Content-Language: en-US
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Will Deacon <will@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
 iommu@lists.linux-foundation.org, Nicolin Chen <nicolinc@nvidia.com>,
 linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

MjYuMDMuMjAyMSAxOTozNSwgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPiBPbiBGcmksIE1h
ciAyNiwgMjAyMSBhdCAwNjoyOToyOFBNICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4+
IDI1LjAzLjIwMjEgMTY6MDMsIFRoaWVycnkgUmVkaW5nINC/0LjRiNC10YI6Cj4+PiBGcm9tOiBU
aGllcnJ5IFJlZGluZyA8dHJlZGluZ0BudmlkaWEuY29tPgo+Pj4KPj4+IEhpLAo+Pj4KPj4+IHRo
aXMgaXMgYSBzZXQgb2YgcGF0Y2hlcyB0aGF0IGlzIHRoZSByZXN1bHQgb2YgZWFybGllciBkaXNj
dXNzaW9ucwo+Pj4gcmVnYXJkaW5nIGVhcmx5IGlkZW50aXR5IG1hcHBpbmdzIHRoYXQgYXJlIG5l
ZWRlZCB0byBhdm9pZCBTTU1VIGZhdWx0cwo+Pj4gZHVyaW5nIGVhcmx5IGJvb3QuCj4+Pgo+Pj4g
VGhlIGdvYWwgaGVyZSBpcyB0byBhdm9pZCBlYXJseSBpZGVudGl0eSBtYXBwaW5ncyBhbHRvZ2V0
aGVyIGFuZCBpbnN0ZWFkCj4+PiBwb3N0cG9uZSB0aGUgbmVlZCBmb3IgdGhlIGlkZW50aXR5IG1h
cHBpbmdzIHRvIHdoZW4gZGV2aWNlcyBhcmUgYXR0YWNoZWQKPj4+IHRvIHRoZSBTTU1VLiBUaGlz
IHdvcmtzIGJ5IG1ha2luZyB0aGUgU01NVSBkcml2ZXIgY29vcmRpbmF0ZSB3aXRoIHRoZQo+Pj4g
bWVtb3J5IGNvbnRyb2xsZXIgZHJpdmVyIG9uIHdoZW4gdG8gc3RhcnQgZW5mb3JjaW5nIFNNTVUg
dHJhbnNsYXRpb25zLgo+Pj4gVGhpcyBtYWtlcyBUZWdyYSBiZWhhdmUgaW4gYSBtb3JlIHN0YW5k
YXJkIHdheSBhbmQgcHVzaGVzIHRoZSBjb2RlIHRvCj4+PiBkZWFsIHdpdGggdGhlIFRlZ3JhLXNw
ZWNpZmljIHByb2dyYW1taW5nIGludG8gdGhlIE5WSURJQSBTTU1VCj4+PiBpbXBsZW1lbnRhdGlv
bi4KPj4KPj4gSXQgaXMgYW4gaW50ZXJlc3RpbmcgaWRlYSB3aGljaCBpbnNwaXJlZCBtZSB0byB0
cnkgdG8gYXBwbHkgYSBzb21ld2hhdCBzaW1pbGFyIHRoaW5nIHRvIFRlZ3JhIFNNTVUgZHJpdmVy
IGJ5IGhvbGRpbmcgdGhlIFNNTVUgQVNJRCBlbmFibGUtYml0IHVudGlsIGRpc3BsYXkgZHJpdmVy
IGFsbG93cyB0byB0b2dnbGUgaXQuIFRoaXMgbWVhbnMgdGhhdCB3ZSB3aWxsIG5lZWQgYW4gZXh0
cmEgc21hbGwgdGVncmEtc3BlY2lmaWMgU01NVSBBUEkgZnVuY3Rpb24sIGJ1dCBpdCBzaG91bGQg
YmUgb2theS4KPj4KPj4gSSB0eXBlZCBhIHBhdGNoIGFuZCBzZWVtcyBpdCdzIHdvcmtpbmcgZ29v
ZCwgSSdsbCBwcmVwYXJlIGEgcHJvcGVyIHBhdGNoIGlmIHlvdSBsaWtlIGl0Lgo+IAo+IFRoYXQg
d291bGQgYWN0dWFsbHkgYmUgd29ya2luZyBhcm91bmQgdGhlIHByb2JsZW0gdGhhdCB0aGlzIHBh
dGNoIHdhcwo+IHN1cHBvc2VkIHRvIHByZXBhcmUgZm9yLiBUaGUgcmVhc29uIGZvciB0aGlzIGN1
cnJlbnQgcGF0Y2ggc2VyaWVzIGlzIHRvCj4gbWFrZSBzdXJlIFNNTVUgdHJhbnNsYXRpb24gaXNu
J3QgZW5hYmxlZCB1bnRpbCBhIGRldmljZSBoYXMgYWN0dWFsbHkKPiBiZWVuIGF0dGFjaGVkIHRv
IHRoZSBTTU1VLiBPbmNlIGl0IGhhcyBiZWVuIGF0dGFjaGVkLCB0aGUgYXNzdW1wdGlvbiBpcwo+
IHRoYXQgYW55IGlkZW50aXR5IG1hcHBpbmdzIHdpbGwgaGF2ZSBiZWVuIGNyZWF0ZWQuCj4gCj4g
T25lIFRlZ3JhIFNNTVUgdGhhdCBzaG91bGRuJ3QgYmUgYSBwcm9ibGVtIGJlY2F1c2UgdHJhbnNs
YXRpb25zIGFyZW4ndAo+IGVuYWJsZWQgdW50aWwgZGV2aWNlIGF0dGFjaCB0aW1lLiBTbyBpbiBv
dGhlciB3b3JkcyB0aGlzIHBhdGNoIHNldCBpcyB0bwo+IGdldCBUZWdyYTE4NiBhbmQgbGF0ZXIg
dG8gcGFyaXR5IHdpdGggZWFybGllciBjaGlwcyBmcm9tIHRoaXMgcG9pbnQgb2YKPiB2aWV3Lgo+
IAo+IEkgdGhpbmsgdGhlIHByb2JsZW0gdGhhdCB5b3UncmUgdHJ5aW5nIHRvIHdvcmsgYXJvdW5k
IGlzIGJldHRlciBzb2x2ZWQKPiBieSBlc3RhYmxpc2hpbmcgdGhlc2UgaWRlbnRpdHkgbWFwcGlu
Z3MuIEkgZG8gaGF2ZSBwYXRjaGVzIHRvIGltcGxlbWVudAo+IHRoaXMgZm9yIFRlZ3JhMjEwIGFu
ZCBlYXJsaWVyLCB0aG91Z2ggdGhleSBtYXkgcmVxdWlyZSBhZGRpdGlvbmFsIHdvcmsKPiBpZiB5
b3UgaGF2ZSBib290bG9hZGVycyB0aGF0IGRvbid0IHVzZSBzdGFuZGFyZCBEVCBiaW5kaW5ncyBm
b3IgcGFzc2luZwo+IGluZm9ybWF0aW9uIGFib3V0IHRoZSBmcmFtZWJ1ZmZlciB0byB0aGUga2Vy
bmVsLgoKSSdtIG5vdCBzdXJlIHdoYXQgZWxzZSByZWFzb25hYmxlIGNvdWxkIGJlIGRvbmUgd2l0
aG91dCB1cGdyYWRpbmcgdG8gYQp2ZXJ5IHNwZWNpZmljIHZlcnNpb24gb2YgZmlybXdhcmUsIHdo
aWNoIGRlZmluaXRlbHkgaXNuJ3QgYSB2YXJpYW50IGZvcgpvbGRlciBkZXZpY2VzIHdoaWNoIGhh
dmUgYSB3aWxkIHZhcmlldHkgb2YgYm9vdGxvYWRlcnMsIGN1c3RvbWl6ZWQKdXNlLWNhc2VzIGFu
ZCBldGMuCgpXZSBjb3VsZCBhZGQgYSBrbHVkZ2UgdGhhdCBJJ20gc3VnZ2VzdGluZyBhcyBhIHVu
aXZlcnNhbCBmYWxsYmFjawpzb2x1dGlvbiwgaXQgc2hvdWxkIHdvcmsgd2VsbCBmb3IgYWxsIGNh
c2VzIHRoYXQgSSBjYXJlIGFib3V0LgoKU28gd2UgY291bGQgaGF2ZSB0aGUgdmFyaWFudCB3aXRo
IGlkZW50aXR5IG1hcHBpbmdzLCBhbmQgaWYgbWFwcGluZwppc24ndCBwcm92aWRlZCwgdGhlbiBm
YWxsIGJhY2sgdG8gdGhlIGtsdWRnZS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2lvbW11
