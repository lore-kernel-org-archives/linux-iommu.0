Return-Path: <SRS0=qkVD=5I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8688C4332B
	for <iommu@archiver.kernel.org>; Mon, 23 Mar 2020 09:16:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B4BD2076A
	for <iommu@archiver.kernel.org>; Mon, 23 Mar 2020 09:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksHDy8vt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4BD2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4558D86AE8;
	Mon, 23 Mar 2020 09:16:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TmrOGS-921_j; Mon, 23 Mar 2020 09:16:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C30DC86B1C;
	Mon, 23 Mar 2020 09:16:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADA5FC1AE2;
	Mon, 23 Mar 2020 09:16:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08DE7C0177
 for <iommu@lists.linux-foundation.org>; Mon, 23 Mar 2020 09:16:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E6FEB228A4
 for <iommu@lists.linux-foundation.org>; Mon, 23 Mar 2020 09:16:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ajJPw0-2PMv0 for <iommu@lists.linux-foundation.org>;
 Mon, 23 Mar 2020 09:16:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 2DE95204C5
 for <iommu@lists.linux-foundation.org>; Mon, 23 Mar 2020 09:16:38 +0000 (UTC)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AB8072072D;
 Mon, 23 Mar 2020 09:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584954997;
 bh=Dm0r422CvRydJKE4j6/j8QFKG1Je4s/6Zbl2XYLusK8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ksHDy8vtj11YaMBiS5JVXYm69heESrzfieQI8Bu/hOagkCJfH0QMk2S3WKEbqHm8l
 OSiyKn/obW7JkFPL8dnTfPFlrrd/fThhXSt7yhmVp2XO6icqASSIdt0YFBVdo0RDGI
 5eh3V6NiF0RpTm85eNzC+aksHw0Z4mnDw3jldRcU=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jGJCF-00EuSy-Tt; Mon, 23 Mar 2020 09:16:36 +0000
MIME-Version: 1.0
Date: Mon, 23 Mar 2020 09:16:35 +0000
From: Marc Zyngier <maz@kernel.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: arm-smmu-v3 high cpu usage for NVMe
In-Reply-To: <cca67355-672d-81c5-3d37-72004eb8f14f@huawei.com>
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
Message-ID: <dd375cf6bffacd82174c84a4c7d46283@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: john.garry@huawei.com, jean-philippe@linaro.org,
 will@kernel.org, iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 thunder.leizhen@huawei.com, ming.lei@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, Ming Lei <ming.lei@redhat.com>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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

T24gMjAyMC0wMy0yMyAwOTowMywgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAyMC8wMy8yMDIwIDE2
OjMzLCBNYXJjIFp5bmdpZXIgd3JvdGU6Cj4+PiBKRllJLCBJJ3ZlIGJlZW4gcGxheWluZyBmb3Ig
InBlcmYgYW5ub3RhdGUiIHRvZGF5IGFuZCBpdCdzIGdpdmluZwo+Pj4gc3RyYW5nZSByZXN1bHRz
IGZvciBteSBOVk1lIHRlc3RpbmcuIFNvICJyZXBvcnQiIGxvb2tzIHNvbWV3aGF0IHNhbmUsCj4+
PiBpZiBub3QgYSB3b3JyeWluZ2x5IGhpZ2ggJSBmb3IgYXJtX3NtbXVfY21kcV9pc3N1ZV9jbWRs
aXN0KCk6Cj4+PiAKPj4+IAo+Pj4gwqDCoMKgIDU1LjM5JcKgIGlycS8zNDItbnZtZTBxMcKgIFtr
ZXJuZWwua2FsbHN5bXNdwqAgW2tdIAo+Pj4gYXJtX3NtbXVfY21kcV9pc3N1ZV9jbWRsaXN0Cj4+
PiDCoMKgwqDCoCA5Ljc0JcKgIGlycS8zNDItbnZtZTBxMcKgIFtrZXJuZWwua2FsbHN5bXNdwqAg
W2tdIAo+Pj4gX3Jhd19zcGluX3VubG9ja19pcnFyZXN0b3JlCj4+PiDCoMKgwqDCoCAyLjAyJcKg
IGlycS8zNDItbnZtZTBxMcKgIFtrZXJuZWwua2FsbHN5bXNdwqAgW2tdIG52bWVfaXJxCj4+PiDC
oMKgwqDCoCAxLjg2JcKgIGlycS8zNDItbnZtZTBxMcKgIFtrZXJuZWwua2FsbHN5bXNdwqAgW2td
IGZwdXRfbWFueQo+Pj4gwqDCoMKgwqAgMS43MyXCoCBpcnEvMzQyLW52bWUwcTHCoCBba2VybmVs
LmthbGxzeW1zXcKgIFtrXQo+Pj4gYXJtX3NtbXVfYXRjX2ludl9kb21haW4uY29uc3Rwcm9wLjQy
Cj4+PiDCoMKgwqDCoCAxLjY3JcKgIGlycS8zNDItbnZtZTBxMcKgIFtrZXJuZWwua2FsbHN5bXNd
wqAgW2tdIF9fYXJtX2xwYWVfdW5tYXAKPj4+IMKgwqDCoMKgIDEuNDklwqAgaXJxLzM0Mi1udm1l
MHExwqAgW2tlcm5lbC5rYWxsc3ltc13CoCBba10gYWlvX2NvbXBsZXRlX3J3Cj4+PiAKPj4+IEJ1
dCAiYW5ub3RhdGUiIGNvbnNpc3RlbnRseSB0ZWxscyBtZSB0aGF0IGEgc3BlY2lmaWMgaW5zdHJ1
Y3Rpb24KPj4+IGNvbnN1bWVzIH45OSUgb2YgdGhlIGxvYWQgZm9yIHRoZSBlbnF1ZXVlIGZ1bmN0
aW9uOgo+Pj4gCj4+PiDCoMKgwqDCoMKgwqDCoMKgIDrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgLyogNS4gSWYgd2UgYXJlIGluc2VydGluZyBhIENNRF9TWU5DLAo+
Pj4gd2UgbXVzdCB3YWl0IGZvciBpdCB0byBjb21wbGV0ZSAqLwo+Pj4gwqDCoMKgwqDCoMKgwqDC
oCA6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChzeW5jKSB7
Cj4+PiDCoMKgwqAgMC4wMCA6wqDCoCBmZmZmODAwMDEwNzFjOTQ4OsKgwqDCoMKgwqDCoCBsZHLC
oMKgwqDCoCB3MCwgW3gyOSwgIzEwOF0KPj4+IMKgwqDCoMKgwqDCoMKgwqAgOsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgcmV0ID0gMDsKPj4+IMKgwqDCoCAw
LjAwIDrCoMKgIGZmZmY4MDAwMTA3MWM5NGM6wqDCoMKgwqDCoMKgIG1vdsKgwqDCoMKgIHcyNCwg
IzB4MMKgwqDCoMKgwqAgLy8gIzAKPj4+IMKgwqDCoMKgwqDCoMKgwqAgOsKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoc3luYykgewo+Pj4gwqDCoMKgIDAuMDAg
OsKgwqAgZmZmZjgwMDAxMDcxYzk1MDrCoMKgwqDCoMKgwqAgY2JuesKgwqDCoCB3MCwgZmZmZjgw
MDAxMDcxYzk5MAo+Pj4gPGFybV9zbW11X2NtZHFfaXNzdWVfY21kbGlzdCsweDQyMD4KPj4+IMKg
wqDCoMKgwqDCoMKgwqAgOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBhcmNoX2xvY2FsX2lycV9yZXN0b3JlKCk6Cj4+PiDCoMKgwqAgMC4wMCA6wqDCoCBmZmZmODAw
MDEwNzFjOTU0OsKgwqDCoMKgwqDCoCBtc3LCoMKgwqDCoCBkYWlmLCB4MjEKPj4+IMKgwqDCoMKg
wqDCoMKgwqAgOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhcm1f
c21tdV9jbWRxX2lzc3VlX2NtZGxpc3QoKToKPj4+IMKgwqDCoMKgwqDCoMKgwqAgOsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+PiDCoMKgwqDCoMKgwqDCoMKg
IDrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4gwqDCoMKg
wqDCoMKgwqDCoCA6Cj4+PiDCoMKgwqDCoMKgwqDCoMKgIDrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbG9jYWxfaXJxX3Jlc3RvcmUoZmxhZ3MpOwo+Pj4gwqDCoMKg
wqDCoMKgwqDCoCA6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiByZXQ7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgIDrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4gwqDCoCA5OS41MSA6wqDCoCBmZmZmODAwMDEwNzFjOTU4
OsKgwqDCoMKgwqDCoCBhZHJwwqDCoMKgIHgwLCBmZmZmODAwMDExOTA5MDAwCj4+PiA8cGFnZV93
YWl0X3RhYmxlKzB4MTRjMD4KPj4gCj4gCj4gSGkgTWFyYywKPiAKPj4gVGhpcyBpcyBsaWtlbHkg
dGhlIHNpZGUgZWZmZWN0IG9mIHRoZSByZS1lbmFibGluZyBvZiBpbnRlcnJ1cHRzIChtc3IgCj4+
IGRhaWYsIHgyMSkKPj4gb24gdGhlIHByZXZpb3VzIGluc3RydWN0aW9uIHdoaWNoIGNhdXNlcyB0
aGUgcGVyZiBpbnRlcnJ1cHQgdG8gZmlyZSAKPj4gcmlnaHQgYWZ0ZXIuCj4gCj4gb2ssIG1ha2Vz
IHNlbnNlLgo+IAo+PiAKPj4gVGltZSB0byBlbmFibGUgcHNldWRvLU5NSXMgaW4gdGhlIFBNVXYz
IGRyaXZlci4uLgo+PiAKPiAKPiBEbyB5b3Uga25vdyBpZiB0aGVyZSBpcyBhbnkgcGxhbiBmb3Ig
dGhpcz8KClRoZXJlIHdhcy4gSnVsaWVuIFRoaWVycnkgaGFzIGEgYnVuY2ggb2YgcGF0Y2hlcyBm
b3IgdGhhdCBbMV0sIGJ1dCB0aGV5IApuZWVkcwpyZXZpdmluZy4KCj4gCj4gSW4gdGhlIG1lYW50
aW1lLCBtYXliZSBJIGNhbiBkbyBzb21lIHRyaWNrZXJ5IGJ5IHB1dHRpbmcgdGhlCj4gbG9jYWxf
aXJxX3Jlc3RvcmUoKSBpbiBhIHNlcGFyYXRlIGZ1bmN0aW9uLCBvdXRzaWRlCj4gYXJtX3NtbXVf
Y21kcV9pc3N1ZV9jbWRsaXN0KCksIHRvIGdldCBhIGZhaXIgcHJvZmlsZSBmb3IgdGhhdCBzYW1l
Cj4gZnVuY3Rpb24uCgpJIGRvbid0IHNlZSBob3cgeW91IGNhbiBpbXByb3ZlIHRoZSBwcm9maWxp
bmcgd2l0aG91dCBjb21wcm9taXNpbmcKdGhlIGxvY2tpbmcgaW4gdGhpcyBjYXNlLi4uCgpUaGFu
a3MsCgogICAgICAgICBNLgoKWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvY292ZXIv
MTEwNDc0MDcvCi0tIApKYXp6IGlzIG5vdCBkZWFkLiBJdCBqdXN0IHNtZWxscyBmdW5ueS4uLgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
