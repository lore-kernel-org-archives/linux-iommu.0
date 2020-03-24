Return-Path: <SRS0=P7ka=5J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B5FC43331
	for <iommu@archiver.kernel.org>; Tue, 24 Mar 2020 12:07:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 603F020714
	for <iommu@archiver.kernel.org>; Tue, 24 Mar 2020 12:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603F020714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1E55587DB2;
	Tue, 24 Mar 2020 12:07:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8mHiKU4xVulB; Tue, 24 Mar 2020 12:07:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 59E9B86D96;
	Tue, 24 Mar 2020 12:07:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4415EC089F;
	Tue, 24 Mar 2020 12:07:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10D7EC0177
 for <iommu@lists.linux-foundation.org>; Tue, 24 Mar 2020 12:07:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EE79A882A1
 for <iommu@lists.linux-foundation.org>; Tue, 24 Mar 2020 12:07:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aEsWv2HSo1Ev for <iommu@lists.linux-foundation.org>;
 Tue, 24 Mar 2020 12:07:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id AB42587B18
 for <iommu@lists.linux-foundation.org>; Tue, 24 Mar 2020 12:07:45 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 067EB1FB;
 Tue, 24 Mar 2020 05:07:45 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16A173F792;
 Tue, 24 Mar 2020 05:07:42 -0700 (PDT)
Subject: Re: arm-smmu-v3 high cpu usage for NVMe
To: John Garry <john.garry@huawei.com>, Marc Zyngier <maz@kernel.org>
References: <20190821151749.23743-1-will@kernel.org>
 <b2a6e26d-6d0d-7f0d-f222-589812f701d2@huawei.com>
 <20200318205313.GB8094@willie-the-truck>
 <c6ab8020-dc06-0c7d-7a41-e792d90f97ba@huawei.com>
 <20200319184349.GA1697676@myrica>
 <c9ebe17d-66b8-1b8c-cc2c-5be0bd1501a7@huawei.com>
 <20200320111842.GD1702630@myrica>
 <b412fc9c-6266-e320-0769-f214d7752675@huawei.com>
 <5198fcffc8ad6233e0274ebff9e9aa5f@kernel.org>
 <cca67355-672d-81c5-3d37-72004eb8f14f@huawei.com>
 <dd375cf6bffacd82174c84a4c7d46283@kernel.org>
 <0e00de15-596a-d342-f3cb-e19c389294e6@huawei.com>
 <20200324104307.57d2cde0@why>
 <4c5e2482-1493-6bb7-d592-58cd027d39f9@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <10d5bcb3-e7c4-18f0-ede6-9fd8f0385254@arm.com>
Date: Tue, 24 Mar 2020 12:07:42 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <4c5e2482-1493-6bb7-d592-58cd027d39f9@huawei.com>
Content-Language: en-GB
Cc: Mark Rutland <mark.rutland@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Ming Lei <ming.lei@redhat.com>, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, Julien Thierry <julien.thierry.kdev@gmail.com>
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

T24gMjAyMC0wMy0yNCAxMTo1NSBhbSwgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAyNC8wMy8yMDIw
IDEwOjQzLCBNYXJjIFp5bmdpZXIgd3JvdGU6Cj4+IE9uIFR1ZSwgMjQgTWFyIDIwMjAgMDk6MTg6
MTAgKzAwMDAKPj4gSm9obiBHYXJyeTxqb2huLmdhcnJ5QGh1YXdlaS5jb20+wqAgd3JvdGU6Cj4+
Cj4+PiBPbiAyMy8wMy8yMDIwIDA5OjE2LCBNYXJjIFp5bmdpZXIgd3JvdGU6Cj4+Pgo+Pj4gKyBK
dWxpZW4sIE1hcmsKPj4+Cj4+PiBIaSBNYXJjLAo+Pj4KPj4+Pj4+IFRpbWUgdG8gZW5hYmxlIHBz
ZXVkby1OTUlzIGluIHRoZSBQTVV2MyBkcml2ZXIuLi4KPj4+Pj4+Cj4+Pj4+IERvIHlvdSBrbm93
IGlmIHRoZXJlIGlzIGFueSBwbGFuIGZvciB0aGlzPwo+Pj4+IFRoZXJlIHdhcy4gSnVsaWVuIFRo
aWVycnkgaGFzIGEgYnVuY2ggb2YgcGF0Y2hlcyBmb3IgdGhhdCBbMV0sIGJ1dCAKPj4+PiB0aGV5
ID4gbmVlZHMKPj4+PiByZXZpdmluZy4KPj4+Pgo+Pj4gU28gdGhvc2UgcGF0Y2hlcyBzdGlsbCBh
cHBseSBjbGVhbmx5IChhcGFydCBmcm9tIHRoZSBrdm0gcGF0Y2gsIHdoaWNoCj4+PiBJIGNhbiBz
a2lwLCBJIHN1cHBvc2UpIGFuZCBidWlsZCwgc28gSSBjYW4gdHJ5IHRoaXMgSSBmaWd1cmUuIElz
Cj4+PiB0aGVyZSBhbnl0aGluZyBlbHNlIHdoaWNoIEkgc2hvdWxkIGVuc3VyZSBvciBrbm93IGFi
b3V0PyBBcGFydCBmcm9tCj4+PiBlbmFibGUgQ09ORklHX0FSTTY0X1BTVUVET19OTUkuCj4+IFlv
dSBuZWVkIHRvIG1ha2Ugc3VyZSB0aGF0IHlvdXIgZmlybXdhcmUgc2V0cyBTQ1JfRUwzLkZJUSB0
byAxLiBNeSBEMDUKPj4gaGFzIGl0IHNldCB0byAwLCBwcmV2ZW50aW5nIG1lIGZyb20gYmVpbmcg
YWJsZSB0byB1c2UgdGhlIGZlYXR1cmUKPj4gKGhpbnQsIG51ZGdlLi4uOy0pLgo+IAo+IFllYWgs
IGFwcGFyZW50bHkgaXQncyBzZXQgb24gb3VyIEQwNkNTIGJvYXJkLCBidXQgSSBqdXN0IG5lZWQg
dG8gZG91YmxlIAo+IGNoZWNrIHRoZSBGVyB2ZXJzaW9uIHdpdGggb3VyIEZXIGd1eS4KCkhvcGVm
dWxseSB5b3Ugc2F3IHRoZSBoZWxwIGZvciBDT05GSUdfQVJNNjRfUFNVRURPX05NSSBhbHJlYWR5
LCBidXQgCnNpbmNlIGl0J3Mgbm90IGJlZW4gY2FsbGVkIG91dDoKCgkgIFRoaXMgaGlnaCBwcmlv
cml0eSBjb25maWd1cmF0aW9uIGZvciBpbnRlcnJ1cHRzIG5lZWRzIHRvIGJlCiAgICAgICAgICAg
ZXhwbGljaXRseSBlbmFibGVkIGJ5IHNldHRpbmcgdGhlIGtlcm5lbCBwYXJhbWV0ZXIKICAgICAg
ICAgICAiaXJxY2hpcC5naWN2M19wc2V1ZG9fbm1pIiB0byAxLgoKRldJVyBJIGJlbGlldmUgaXMg
aXMgc3RpbGwgb24gdGhlIHBsYW4gZm9yIHNvbWVvbmUgaGVyZSB0byBkdXN0IG9mZiB0aGUgClBN
VSBwTk1JIHBhdGNoZXMgYXQgc29tZSBwb2ludC4KClJvYmluLgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
