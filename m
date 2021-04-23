Return-Path: <SRS0=1bbG=JU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AC3C433B4
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 15:01:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 929DD61465
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 15:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929DD61465
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 377A740F57;
	Fri, 23 Apr 2021 15:01:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mB0L43QbpAuw; Fri, 23 Apr 2021 15:01:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id F40B140F7C;
	Fri, 23 Apr 2021 15:01:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9BDDC000E;
	Fri, 23 Apr 2021 15:01:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8D59C000B
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 15:01:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A20BB4063B
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 15:01:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IJ3osXayu9Pz for <iommu@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 15:01:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6A48F40610
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 15:01:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: gtucker) with ESMTPSA id C3FCF1F43D22
Subject: Re: [PATCH v1 2/2] iommu/tegra-smmu: Revert workaround that was
 needed for Nyan Big Chromebook
To: Dmitry Osipenko <digetx@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>
References: <20210328233256.20494-1-digetx@gmail.com>
 <20210328233256.20494-2-digetx@gmail.com>
 <20210401085549.GA31146@Asurada-Nvidia>
 <50a7e4c7-0e72-534a-a317-366e455213c1@gmail.com>
From: Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <d01ccde4-5fa9-2aa7-c28b-b3899cc54c54@collabora.com>
Date: Fri, 23 Apr 2021 16:01:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <50a7e4c7-0e72-534a-a317-366e455213c1@gmail.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMDIvMDQvMjAyMSAxNTo0MCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+IDAxLjA0LjIwMjEg
MTE6NTUsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+PiBPbiBNb24sIE1hciAyOSwgMjAyMSBh
dCAwMjozMjo1NkFNICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4+PiBUaGUgcHJldmlv
dXMgY29tbWl0IGZpeGVzIHByb2JsZW0gd2hlcmUgZGlzcGxheSBjbGllbnQgd2FzIGF0dGFjaGlu
ZyB0b28KPj4+IGVhcmx5IHRvIElPTU1VIGR1cmluZyBrZXJuZWwgYm9vdCBpbiBhIG11bHRpLXBs
YXRmb3JtIGtlcm5lbCBjb25maWd1cmF0aW9uCj4+PiB3aGljaCBlbmFibGVzIENPTkZJR19BUk1f
RE1BX1VTRV9JT01NVT15LiBUaGUgd29ya2Fyb3VuZCB0aGF0IGhlbHBlZCB0bwo+Pj4gZGVmZXIg
dGhlIElPTU1VIGF0dGFjaG1lbnQgZm9yIE55YW4gQmlnIENocm9tZWJvb2sgaXNuJ3QgbmVlZGVk
IGFueW1vcmUsCj4+PiByZXZlcnQgaXQuCj4+Cj4+IFNvcnJ5IGZvciB0aGUgbGF0ZSByZXBseS4g
SSBoYXZlIGJlZW4gYnVzeSB3aXRoIGRvd25zdHJlYW0gdGFza3MuCj4+Cj4+IEkgd2lsbCBnaXZl
IHRoZW0gYSB0cnkgYnkgdGhlIGVuZCBvZiB0aGUgd2Vlay4gWWV0LCBwcm9iYWJseSBpdCdkCj4+
IGJlIGJldHRlciB0byBpbmNsdWRlIEd1aWxsYXVtZSBhbHNvIGFzIGhlIGhhcyB0aGUgTnlhbiBw
bGF0Zm9ybS4KPj4KPiAKPiBJbmRlZWQsIHRoYW5rcy4gQWx0aG91Z2gsIEknbSBwcmV0dHkgc3Vy
ZSB0aGF0IGl0J3MgdGhlIHNhbWUgaXNzdWUgd2hpY2gKPiBJIHJlcHJvZHVjZWQgb24gTmV4dXMg
Ny4KPiAKPiBHdWlsbGF1bWUsIGNvdWxkIHlvdSBwbGVhc2UgZ2l2ZSBhIHRlc3QgdG8gdGhlc2Ug
cGF0Y2hlcyBvbiBOeWFuIEJpZz8KPiBUaGVyZSBzaG91bGQgYmUgbm8gRU1FTSBlcnJvcnMgaW4g
dGhlIGtlcm5lbCBsb2cgd2l0aCB0aGlzIHBhdGNoZXMuCj4gCj4gaHR0cHM6Ly9wYXRjaHdvcmsu
b3psYWJzLm9yZy9wcm9qZWN0L2xpbnV4LXRlZ3JhL2xpc3QvP3Nlcmllcz0yMzYyMTUKClNvIHNv
cnJ5IGZvciB0aGUgdmVyeSBsYXRlIHJlcGx5LiAgSSBoYXZlIHRyaWVkIHRoZSBwYXRjaGVzIGJ1
dApoaXQgc29tZSBpc3N1ZXMgb24gbGludXgtbmV4dCwgaXQncyBub3QgcmVhY2hpbmcgYSBsb2dp
biBwcm9tcHQKd2l0aCBuZXh0LTIwMjEwNDIyLiAgU28gSSB0aGVuIHRyaWVkIHdpdGggbmV4dC0y
MDIxMDQxOSB3aGljaApkb2VzIGJvb3QgYnV0IHNob3dzIHRoZSBJT01NVSBlcnJvcjoKCjw2Plsg
ICAgMi45OTUzNDFdIHRlZ3JhLWRjIDU0MjAwMDAwLmRjOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAg
MQo8ND5bICAgIDMuMDAxMDcwXSBGYWlsZWQgdG8gYXR0YWNoZWQgZGV2aWNlIDU0MjAwMDAwLmRj
IHRvIElPTU1VX21hcHBpbmcgIAoKICBodHRwczovL2xhdmEuY29sbGFib3JhLmNvLnVrL3NjaGVk
dWxlci9qb2IvMzU3MDA1MiNMMTEyMAoKVGhlIGJyYW5jaCBJJ20gdXNpbmcgd2l0aCB0aGUgcGF0
Y2hlcyBhcHBsaWVkIGNhbiBiZSBmb3VuZCBoZXJlOgoKICBodHRwczovL2dpdGxhYi5jb2xsYWJv
cmEuY29tL2d0dWNrZXIvbGludXgvLS9jb21taXRzL25leHQtMjAyMTA0MTktbnlhbi1iaWctZHJt
LXJlYWQvCgpIb3BlIHRoaXMgaGVscHMsIGxldCBtZSBrbm93IGlmIHlvdSBuZWVkIGFueXRoaW5n
IGVsc2UgdG8gYmUKdGVzdGVkLgoKQmVzdCB3aXNoZXMsCkd1aWxsYXVtZQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
