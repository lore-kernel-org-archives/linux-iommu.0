Return-Path: <SRS0=GPDh=E7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5520FC56201
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 09:55:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C57AE206B5
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 09:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uau/cOV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57AE206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7249186969;
	Wed, 25 Nov 2020 09:55:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PUTkPHn2Kj3c; Wed, 25 Nov 2020 09:55:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0CB028554A;
	Wed, 25 Nov 2020 09:55:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4987C163C;
	Wed, 25 Nov 2020 09:55:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F68FC0052
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 09:55:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 39C8B86DA5
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 09:55:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VmlNinTl6dzT for <iommu@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:55:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 99B3786A5C
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 09:55:15 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9A026206B7;
 Wed, 25 Nov 2020 09:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606298115;
 bh=re7AA/JYRI8haIErRYirxD5qBBNucRha2mgCCLcEBdw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uau/cOV8xuxLqlAHyOwuhgXQj5gfAd69Ye96ug6M5hYeQd+3qxXFa51WdbVyB9rXi
 WfIth7NR1+dXktcByKqTBwpvQzIg5ovQr4UjreFibvMs5l41P+SANO1kJnPqLen/+R
 6LXv7rCZZ3lE/HBDUr+L4LC6Z/qeenih8S8MxBP8=
Date: Wed, 25 Nov 2020 09:55:10 +0000
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH RESEND 0/5] iommu/tegra-smmu: Some pending reviewed changes
Message-ID: <20201125095509.GB15052@willie-the-truck>
References: <20201111222129.15736-1-nicoleotsuka@gmail.com>
 <20201124212100.GA32108@Asurada-Nvidia>
 <68237d7c-12f7-3053-2e79-75b7e95f0af3@gmail.com>
 <20201124231215.GA32405@Asurada-Nvidia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201124231215.GA32405@Asurada-Nvidia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
 iommu@lists.linux-foundation.org, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>
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

T24gVHVlLCBOb3YgMjQsIDIwMjAgYXQgMDM6MTI6MTZQTSAtMDgwMCwgTmljb2xpbiBDaGVuIHdy
b3RlOgo+IE9uIFdlZCwgTm92IDI1LCAyMDIwIGF0IDAyOjA1OjE0QU0gKzAzMDAsIERtaXRyeSBP
c2lwZW5rbyB3cm90ZToKPiA+IDI1LjExLjIwMjAgMDA6MjEsIE5pY29saW4gQ2hlbiDQv9C40YjQ
tdGCOgo+ID4gPiBUaGVzZSBmaXZlIHBhdGNoZXMgd2VyZSBhY2tlZCBieSBUaGllcnJ5IGFuZCBh
Y2tlZC1uLXRlc3RlZCBieQo+ID4gPiBEbWl0cnkgYSB3aGlsZSBhZ28uIFdvdWxkIGl0IGJlIHBv
c3NpYmxlIGZvciB5b3UgdG8gYXBwbHkgdGhlbT8KPiA+ID4gCj4gPiA+IFRoYW5rcyEKPiA+IAo+
ID4gWW91IHByb2JhYmx5IHNob3VsZCB0cnkgdG8gcGluZyBXaWxsIERlYWNvbi4KPiA+IAo+ID4g
aHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjAvMTEvMTcvMjQzCj4gCj4gVGhhbmsgeW91LCBEbWl0
cnkuCj4gLS0KPiAKPiBXaWxsLCB3b3VsZCBpdCBiZSBwb3NzaWJsZSBmb3IgeW91IHRvIHRha2Ug
dGhlc2UgY2hhbmdlcz8KPiAKPiBJIHNlbnQgdGhlbSBvbiBOb3YgMTEgdG8gdGhlIGZvbGxvd2lu
ZyBsaXN0czoKPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4gaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKPiAKPiBJZiB5b3UgbmVlZCBtZSB0byByZXNlbmQgaXQgYWdhaW4g
YnkgYWRkaW5nIHlvdSBpbiBUbyBsaW5lLAo+IHBsZWFzZSBraW5kbHkgbGV0IG1lIGtub3cuCgpX
ZWlyZCwgdGhpcyBlbmRlZCB1cCBpbiBteSBzcGFtLiBJZiB5b3Ugd291bGRuJ3QgbWluZCByZXNl
bmRpbmcgd2l0aCBtZQpvbiBUbzogdGhlbiBwbGVhc2UgZG8gdGhhdC4gVGhlbiBJIGtub3cgSSdt
IGxvb2tpbmcgYXQgdGhlIGNvcnJlY3QgdmVyc2lvbi4KClRoYW5rcywKCldpbGwKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
