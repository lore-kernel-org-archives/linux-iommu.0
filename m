Return-Path: <SRS0=Ze3H=LT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE152C2B9F4
	for <iommu@archiver.kernel.org>; Fri, 25 Jun 2021 16:47:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D81461969
	for <iommu@archiver.kernel.org>; Fri, 25 Jun 2021 16:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D81461969
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0295B60823;
	Fri, 25 Jun 2021 16:47:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R8FWVzNR0RTZ; Fri, 25 Jun 2021 16:47:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E7FD460B1A;
	Fri, 25 Jun 2021 16:47:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3BCCC0010;
	Fri, 25 Jun 2021 16:47:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35437C000E
 for <iommu@lists.linux-foundation.org>; Fri, 25 Jun 2021 16:47:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 16D59405E1
 for <iommu@lists.linux-foundation.org>; Fri, 25 Jun 2021 16:47:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yAy8aJKBwTdP for <iommu@lists.linux-foundation.org>;
 Fri, 25 Jun 2021 16:47:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 35A08400D2
 for <iommu@lists.linux-foundation.org>; Fri, 25 Jun 2021 16:47:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 178521396;
 Fri, 25 Jun 2021 09:47:36 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 008023F719;
 Fri, 25 Jun 2021 09:47:34 -0700 (PDT)
Subject: Re: IOMMU regression in 5.11 kernel related to device removal from
 PCI topolgy
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 iommu@lists.linux-foundation.org, joro@8bytes.org, will@kernel.org,
 jroedel@suse.de
References: <c2ec75c7-d7b4-47ca-cbc0-03421285c64c@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <00cc5e03-ebf2-6d94-8980-f956bb08e9c6@arm.com>
Date: Fri, 25 Jun 2021 17:47:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <c2ec75c7-d7b4-47ca-cbc0-03421285c64c@amd.com>
Content-Language: en-GB
Cc: "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
 "anatoli.antonovitch@amd.com" <anatoli.antonovitch@amd.com>
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

SGkgQW5kcmV5LAoKT24gMjAyMS0wNi0yNCAxNzoxOSwgQW5kcmV5IEdyb2R6b3Zza3kgdmlhIGlv
bW11IHdyb3RlOgo+IEhlbGxvLAo+IAo+IFdlIGFyZSB0ZXN0aW5nIEFNRCBHUFUgcmVtb3ZhbCBm
cm9tIFBDSSB0b3BvbG9neSB1c2luZyBzeXNmcyAncmVtb3ZlJwo+IGhvb2suIFdlIGVuY291bnRl
cmVkIGEgY3Jhc2ggaW4gSU9NTVUgY29kZSByZWxhdGVkIHRvIGRvdWJsZSBmcmVlLgo+IE5vdGUg
dGhhdCB0aGUgY3Jhc2ggaGFwcGVucyB3aXRob3V0IGV2ZW4gbG9hZGluZyBBTUQgZ3JhcGhpYyBk
cml2ZXIgLQo+IGFtZGdwdS4gVGhlIGRtZXNnIHdpdGggS0FTQU4gcmVwb3J0IGFuZCBQQ0kgdG9w
b2xvZ3kgaXMgYXR0YWNoZWQgaGVyZQo+IGluIGxvZy4gSSB3ZW50IGEgYml0IGFoZWFkIHRvIDUu
MTItcmMzIGtlcm5lbCBhbmQgYWxyZWFkeSB0aGVyZSB0aGlzCj4gY3Jhc2ggaXMgZ29uZS4gQWxz
byB3ZSBkaWRuJ3QgaGF2ZSBzdWNoIGlzc3VlIGluIDUuOSBrZXJuZWwuCj4gSXQncyBlc3NlbnRp
YWwgdG8gdXMgdG8gdXNlIDUuMTEga2VybmVsIGFuZCBzbyB3ZSBjYW5ub3QgY3VycmVudGx5Cj4g
dG8ganVzdCBza2lwIHRvIDUuMTIga2VybmVsIHRvIGF2b2lkIHRoaXMgaXNzdWUuIEkgd291bGQg
dmVyeSBtdWNoCj4gYXBwcmVjaWF0ZSBpZiBzb21lb25lIG9uIHRoZSBsaXN0IGlzIGF3YXJlIG9m
IGEgZml4wqAgZm9yIHRoaXMgaXNzdWUKPiB3aGljaCB3YXMgZG9uZSB0aGF0IHdlIGNvdWxkIGJh
Y2stcG9ydCB0byBvdXIgcHJpdmF0ZSA1LjExIGtlcm5lbCB0cmVlLgoKVW5mb3J0dW5hdGVseSBJ
IGRvbid0IHJlY2FsbCBhbnkgc3BlY2lmaWMgaXNzdWVzIHdpdGggdGhlIElPVkEgYW5kIAppb21t
dS1kbWEgY29kZSBpbiB0aGF0IHRpbWVmcmFtZSwgYW5kIEkgZmVhciBpdCBtYXkgYmUgbmFzdGll
ciB0aGFuIGl0IApsb29rcy4gVGhlIEtBU0FOIHJlcG9ydCBpbXBsaWVzIHRoYXQgcHV0X2lvdmFf
ZG9tYWluKCkgKHByb2JhYmx5IHRoZSAKZnJlZV9pb3ZhX21lbSgpIGxvb3ApIGlzIHRyeWluZyB0
byBmcmVlIHNvbWV0aGluZyBhbGxvY2F0ZWQgYnkgCmlvbW11X2dldF9kbWFfY29va2llKCkgLSB0
aGF0J3MgYSBiaWcgcmVkIGZsYWcgdG8gc3RhcnQgd2l0aC4gVGhlIG9ubHkgCnRoaW5nIHRoYXQg
aW9tbXVfZ2V0X2RtYV9jb29raWUoKSBhbGxvY2F0ZXMgaXMgdGhlIGlvdmFfZG9tYWluIGl0c2Vs
ZiwgCnNvIHRoZSBtb3N0IGxvZ2ljYWwgY2F1c2Ugd291bGQgc2VlbSB0byBiZSBwdXRfaW92YV9k
b21haW4oKSB0cnlpbmcgdG8gCmZyZWUgaW92YWQtPmFuY2hvciwgZXhjZXB0IEknbSBzdHJ1Z2ds
aW5nIHRvIG1ha2UgdGhhdCAxMzYtYnl0ZSBvZmZzZXQgCmxpbmUgdXAgaW4gYSB3YXkgdGhhdCBt
YWtlcyBzZW5zZSwgYW5kIGV2ZW4gdGhlbiBmcmVlX2lvdmFfbWVtKCkgCmV4cGxpY2l0bHkga25v
d3Mgbm90IHRvIGRvIHRoYXQgc28gc29tZXRoaW5nIHdvdWxkIGhhdmUgaGFkIHRvIGNvcnJ1cHQg
CmFuY2hvci0+cGZuX2xvIGluIHRoZSBtZWFudGltZSA6LwoKSXMgdGhpcyByZXByb2R1Y2libGUg
cmVsaWFibHkgZW5vdWdoIHRoYXQgeW91IGNhbiBiaXNlY3QgaXQ/CgpSb2Jpbi4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
