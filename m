Return-Path: <SRS0=f0z+=4K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAC8C35670
	for <iommu@archiver.kernel.org>; Sat, 22 Feb 2020 01:53:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 134C920656
	for <iommu@archiver.kernel.org>; Sat, 22 Feb 2020 01:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mPktKWlv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134C920656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CCBD88757D;
	Sat, 22 Feb 2020 01:53:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nM56i0l4r2fQ; Sat, 22 Feb 2020 01:53:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 16E4F86C02;
	Sat, 22 Feb 2020 01:53:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9758C1D81;
	Sat, 22 Feb 2020 01:53:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DD4CC013E
 for <iommu@lists.linux-foundation.org>; Sat, 22 Feb 2020 01:53:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B33C987E5E
 for <iommu@lists.linux-foundation.org>; Sat, 22 Feb 2020 01:53:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ad6LpmYL-FEV for <iommu@lists.linux-foundation.org>;
 Sat, 22 Feb 2020 01:53:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C312387E1D
 for <iommu@lists.linux-foundation.org>; Sat, 22 Feb 2020 01:53:22 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id p11so1625701plq.10
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 17:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=t2WN9Y6i+1sMeMmerTg/sIx0hN9tYd17GbQLJc7KWJ4=;
 b=mPktKWlv91J8zSVtP4T+e9BPp7EcbGwMkei5J/fBl3dBCAU7bzR0Gh9Hrdv25yYi9+
 KU5dPtNWsjM864SJ4zW/iT/MwY+dXe6EBn0QPYv5gaUfd537Ik6FOLz1nio5+5SPCACT
 H2zaNJsEkotdbxpnuzIDFodkNIKHUn62v1WuYFB7Flw6y4uugwe6ciVDBaAg/3DQTr7D
 yOYIWYs2ParfrKfXw8THe7ekRhRjoaUOIX3j0RtXRMw4/Rq89Y6QFmzWMmwrbXk9G6ZW
 YkPaP40q2o4cISWp+2fU2CXkLpsLcTJ/q7B27GoHMbSVvdbUrMMlVXIb/VXBqn2foHKb
 ww8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=t2WN9Y6i+1sMeMmerTg/sIx0hN9tYd17GbQLJc7KWJ4=;
 b=d5xgzFWbDBoJ6JjTvFvZZbPeW3ZyJuJp2Jo2lyNHJrClPsZAKRLQh+2hEPfP2ImtEn
 SFt/utdKfBixwSff2j1JRoWUiS4fbLXsDypt00tuTUnWOu34kT0V6qBHZCplFAZKmJt0
 VRg3OcPXnr54mXJydeLyRB1e0vaysGZE3eYTzLMQubZewMQJmMJOPA3CGnNTZOhWOska
 lV6Tr2OLVk3FNXy4sr2E+LEvJ+7SZREJBvzRX4ZvYcuTNkY/UCqSwNe8Aa0y7xnRBvlU
 lKEX5I70APbZ9meC+CUbHpVnB6LzKQ+HLa3VZ8fTwXUk1ajDT4ZjXPqvMRn/cqJHNd76
 5wYg==
X-Gm-Message-State: APjAAAXXn1ci9OZ0iwNxtApk3ALx9ev8kKWZb3DIe6KQVWC7Z9F2lY6n
 UtltSBl/Z47qJB36AW6SyIhyYVF4hIc=
X-Google-Smtp-Source: APXvYqzHrVqrmX9+Lk9w9FP91YPzkYcV0jkjab6rvQK3U4g9KuosSje8dbq9YgFdMYQh5L1aPjY6jQ==
X-Received: by 2002:a17:90a:cf08:: with SMTP id
 h8mr6352327pju.81.1582336401930; 
 Fri, 21 Feb 2020 17:53:21 -0800 (PST)
Received: from ?IPv6:240e:362:47d:ee00:e13e:da52:2837:6aff?
 ([240e:362:47d:ee00:e13e:da52:2837:6aff])
 by smtp.gmail.com with ESMTPSA id 78sm1436422pge.58.2020.02.21.17.52.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Feb 2020 17:53:21 -0800 (PST)
Subject: Re: [PATCH v13 0/4] Add uacce module for Accelerator
To: Herbert Xu <herbert@gondor.apana.org.au>
References: <1581407665-13504-1-git-send-email-zhangfei.gao@linaro.org>
 <20200222014148.GC19028@gondor.apana.org.au>
From: zhangfei <zhangfei.gao@linaro.org>
Message-ID: <9048453c-530a-9063-b266-faa8d434015b@linaro.org>
Date: Sat, 22 Feb 2020 09:52:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200222014148.GC19028@gondor.apana.org.au>
Content-Language: en-US
Cc: jean-philippe <jean-philippe@linaro.org>, dave.jiang@intel.com,
 kenneth-lee-2012@foxmail.com, Arnd Bergmann <arnd@arndb.de>,
 francois.ozog@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 ilias.apalodimas@linaro.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
 grant.likely@arm.com, "haojian . zhuang" <haojian.zhuang@linaro.org>,
 linux-accelerators@lists.ozlabs.org, guodong.xu@linaro.org,
 linux-crypto@vger.kernel.org
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

CgpPbiAyMDIwLzIvMjIg5LiK5Y2IOTo0MSwgSGVyYmVydCBYdSB3cm90ZToKPiBPbiBUdWUsIEZl
YiAxMSwgMjAyMCBhdCAwMzo1NDoyMVBNICswODAwLCBaaGFuZ2ZlaSBHYW8gd3JvdGU6Cj4+IFVh
Y2NlIChVbmlmaWVkL1VzZXItc3BhY2UtYWNjZXNzLWludGVuZGVkIEFjY2VsZXJhdG9yIEZyYW1l
d29yaykgdGFyZ2V0cyB0bwo+PiBwcm92aWRlIFNoYXJlZCBWaXJ0dWFsIEFkZHJlc3NpbmcgKFNW
QSkgYmV0d2VlbiBhY2NlbGVyYXRvcnMgYW5kIHByb2Nlc3Nlcy4KPj4gU28gYWNjZWxlcmF0b3Ig
Y2FuIGFjY2VzcyBhbnkgZGF0YSBzdHJ1Y3R1cmUgb2YgdGhlIG1haW4gY3B1Lgo+PiBUaGlzIGRp
ZmZlcnMgZnJvbSB0aGUgZGF0YSBzaGFyaW5nIGJldHdlZW4gY3B1IGFuZCBpbyBkZXZpY2UsIHdo
aWNoIHNoYXJlCj4+IGRhdGEgY29udGVudCByYXRoZXIgdGhhbiBhZGRyZXNzLgo+PiBCZWNhdXNl
IG9mIHVuaWZpZWQgYWRkcmVzcywgaGFyZHdhcmUgYW5kIHVzZXIgc3BhY2Ugb2YgcHJvY2VzcyBj
YW4gc2hhcmUKPj4gdGhlIHNhbWUgdmlydHVhbCBhZGRyZXNzIGluIHRoZSBjb21tdW5pY2F0aW9u
Lgo+Pgo+PiBVYWNjZSBpcyBpbnRlbmRlZCB0byBiZSB1c2VkIHdpdGggSmVhbiBQaGlsaXBwZSBC
cnVja2VyJ3MgU1ZBCj4+IHBhdGNoc2V0WzFdLCB3aGljaCBlbmFibGVzIElPIHNpZGUgcGFnZSBm
YXVsdCBhbmQgUEFTSUQgc3VwcG9ydC4KPj4gV2UgaGF2ZSBrZWVwIHZlcmlmeWluZyB3aXRoIEpl
YW4ncyBzdmEgcGF0Y2hzZXQgWzJdCj4+IFdlIGFsc28ga2VlcCB2ZXJpZnlpbmcgd2l0aCBFcmlj
J3MgU01NVXYzIE5lc3RlZCBTdGFnZSBwYXRjaGVzIFszXQo+Pgo+PiBUaGlzIHNlcmllcyBhbmQg
cmVsYXRlZCB6aXAgJiBxbSBkcml2ZXIKPj4gaHR0cHM6Ly9naXRodWIuY29tL0xpbmFyby9saW51
eC1rZXJuZWwtd2FycGRyaXZlL3RyZWUvdjUuNi1yYzEtdWFjY2UtdjEzCj4+Cj4+IFRoZSBsaWJy
YXJ5IGFuZCB1c2VyIGFwcGxpY2F0aW9uOgo+PiBodHRwczovL2dpdGh1Yi5jb20vTGluYXJvL3dh
cnBkcml2ZS90cmVlL3dkcHJkLXVwc3RyZWFtLXYxMwo+Pgo+Pgo+PiBLZW5uZXRoIExlZSAoMik6
Cj4+ICAgIHVhY2NlOiBBZGQgZG9jdW1lbnRzIGZvciB1YWNjZQo+PiAgICB1YWNjZTogYWRkIHVh
Y2NlIGRyaXZlcgo+Pgo+PiBaaGFuZ2ZlaSBHYW8gKDIpOgo+PiAgICBjcnlwdG86IGhpc2lsaWNv
biAtIFJlbW92ZSBtb2R1bGVfcGFyYW0gdWFjY2VfbW9kZQo+PiAgICBjcnlwdG86IGhpc2lsaWNv
biAtIHJlZ2lzdGVyIHppcCBlbmdpbmUgdG8gdWFjY2UKPj4KPj4gICBEb2N1bWVudGF0aW9uL0FC
SS90ZXN0aW5nL3N5c2ZzLWRyaXZlci11YWNjZSB8ICAzOSArKwo+PiAgIERvY3VtZW50YXRpb24v
bWlzYy1kZXZpY2VzL3VhY2NlLnJzdCAgICAgICAgIHwgMTc2ICsrKysrKwo+PiAgIGRyaXZlcnMv
Y3J5cHRvL2hpc2lsaWNvbi9xbS5jICAgICAgICAgICAgICAgIHwgMjM5ICsrKysrKy0KPj4gICBk
cml2ZXJzL2NyeXB0by9oaXNpbGljb24vcW0uaCAgICAgICAgICAgICAgICB8ICAxMSArCj4+ICAg
ZHJpdmVycy9jcnlwdG8vaGlzaWxpY29uL3ppcC96aXBfbWFpbi5jICAgICAgfCAgNDkgKy0KPj4g
ICBkcml2ZXJzL21pc2MvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArCj4+
ICAgZHJpdmVycy9taXNjL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwo+
PiAgIGRyaXZlcnMvbWlzYy91YWNjZS9LY29uZmlnICAgICAgICAgICAgICAgICAgIHwgIDEzICsK
Pj4gICBkcml2ZXJzL21pc2MvdWFjY2UvTWFrZWZpbGUgICAgICAgICAgICAgICAgICB8ICAgMiAr
Cj4+ICAgZHJpdmVycy9taXNjL3VhY2NlL3VhY2NlLmMgICAgICAgICAgICAgICAgICAgfCA2MTcg
KysrKysrKysrKysrKysrKysrKwo+PiAgIGluY2x1ZGUvbGludXgvdWFjY2UuaCAgICAgICAgICAg
ICAgICAgICAgICAgIHwgMTYxICsrKysrCj4+ICAgaW5jbHVkZS91YXBpL21pc2MvdWFjY2UvaGlz
aV9xbS5oICAgICAgICAgICAgfCAgMjMgKwo+PiAgIGluY2x1ZGUvdWFwaS9taXNjL3VhY2NlL3Vh
Y2NlLmggICAgICAgICAgICAgIHwgIDM4ICsrCj4+ICAgMTMgZmlsZXMgY2hhbmdlZCwgMTMzNyBp
bnNlcnRpb25zKCspLCAzMyBkZWxldGlvbnMoLSkKPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9j
dW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1kcml2ZXItdWFjY2UKPj4gICBjcmVhdGUgbW9k
ZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9taXNjLWRldmljZXMvdWFjY2UucnN0Cj4+ICAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvbWlzYy91YWNjZS9LY29uZmlnCj4+ICAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGRyaXZlcnMvbWlzYy91YWNjZS9NYWtlZmlsZQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL21pc2MvdWFjY2UvdWFjY2UuYwo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNs
dWRlL2xpbnV4L3VhY2NlLmgKPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS91YXBpL21p
c2MvdWFjY2UvaGlzaV9xbS5oCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvdWFwaS9t
aXNjL3VhY2NlL3VhY2NlLmgKPiBBbGwgYXBwbGllZC4gIFRoYW5rcy4KVGhhdCdzIEdyZWF0LApU
aGFua3MgSGVyYmVydCBmb3IgdGhlIGdyZWF0IGhlbHAuCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2lvbW11
