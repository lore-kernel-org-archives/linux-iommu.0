Return-Path: <SRS0=fiLh=4U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95653C3F2D7
	for <iommu@archiver.kernel.org>; Tue,  3 Mar 2020 12:57:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B86C20848
	for <iommu@archiver.kernel.org>; Tue,  3 Mar 2020 12:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pBdyV79X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B86C20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2285885B80;
	Tue,  3 Mar 2020 12:57:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8XeK8gpnKait; Tue,  3 Mar 2020 12:57:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 49A4384D41;
	Tue,  3 Mar 2020 12:57:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 277D1C1AE2;
	Tue,  3 Mar 2020 12:57:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18376C013E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Mar 2020 12:57:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 067EE84E2E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Mar 2020 12:57:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hvol9lvERneK for <iommu@lists.linux-foundation.org>;
 Tue,  3 Mar 2020 12:57:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2802584D22
 for <iommu@lists.linux-foundation.org>; Tue,  3 Mar 2020 12:57:56 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id x7so1510281pgh.5
 for <iommu@lists.linux-foundation.org>; Tue, 03 Mar 2020 04:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Lg++IdYMeQd94pD/ZLBO5CJLpoQAjy8oNL8AZop1ans=;
 b=pBdyV79X5PzDSeKMLl78uCsyMMfApV/dm6Xt0abLb0CDLkPTIcuZfFfifhGyzHBFhQ
 uPB4L44CjJt97iTH9OX3ExajyF+uak9tl+MDBZELIkQQfJI1y1OkWiBWc7V5K5uXdoeX
 u6kP+HaiPiyu0ajhimW8fQaIwSIqfZ0BTiecuD48wzWbijj3BWVCVPXQ/vW7aH9X9HfV
 2XV3ry/BiJQIAjFEAV05BQrRjLk0QxP8gwLS54uTMj/wr7EVFpSiKBZf/OQXoqV5xBCi
 760oD2HdWo/B0hn2swU9vOQ+0n7r9yfX4BWiryhqSt8waHinEjBMk+4TlYNMMItRsRIC
 jZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Lg++IdYMeQd94pD/ZLBO5CJLpoQAjy8oNL8AZop1ans=;
 b=Oa+T6ee3xo55YgzxN/PbrMSAP7IC4CF7W7EbZ1N7y/GccKdj1kxtlGhR7+Ku9Rlx3k
 xPWLPcVLM6vP9sXF5j1XM0uE09hd9cv/LvnSpvSmigYUdnO+9MQuoOH6m2ZvCXo5x7rD
 zvad+FKrrMXI8Xh4v2Zvt92rmXhO7JuR904Aw059xghp0HhoahHNX4HAkH9FhymtY6ao
 4hbh2lyAWcm/pDTK3CwgEN01COlp1m1GFska1YAxJJ67vIHfD2JGXuOEL8+EVKhUZYIm
 zB2WeiCe01qjYHnKTDDgli0iliuZAh7zAh+Bmh2zRy5xHZGsWe1nVN985CQfAFiysK70
 XOoQ==
X-Gm-Message-State: ANhLgQ1fnuAxjMJI9Cvujxea/1IbxP8EEEgsazo676pljf1OQvHlzQVK
 bm0XXdVXgBKXifhZqXJFaWfdbw==
X-Google-Smtp-Source: ADFU+vvmaCiGdnLf7VVnD73qoTDE9qAVS2O4FvZFUlSW1+1T1yr52B7c7d1Vy26Nlbvk0udV+zchMA==
X-Received: by 2002:a63:91c1:: with SMTP id l184mr3862200pge.341.1583240275667; 
 Tue, 03 Mar 2020 04:57:55 -0800 (PST)
Received: from [10.122.2.74] ([45.135.186.15])
 by smtp.gmail.com with ESMTPSA id x66sm13299097pgb.9.2020.03.03.04.57.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 03 Mar 2020 04:57:54 -0800 (PST)
Subject: Re: Re: [PATCH v9 00/11] SMMUv3 Nested Stage Setup (VFIO part)
To: Auger Eric <eric.auger@redhat.com>, Tomasz Nowicki
 <tnowicki@marvell.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20190711135625.20684-1-eric.auger@redhat.com>
 <a35234a6-e386-fc8e-fcc4-5db4601b00d2@marvell.com>
 <3741c034-08f1-9dbb-ab06-434f3a8bd782@redhat.com>
From: zhangfei <zhangfei.gao@linaro.org>
Message-ID: <e0133df5-073b-13e1-8399-ff48bfaef5e5@linaro.org>
Date: Tue, 3 Mar 2020 20:57:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3741c034-08f1-9dbb-ab06-434f3a8bd782@redhat.com>
Content-Language: en-US
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "vincent.stehle@arm.com" <vincent.stehle@arm.com>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>,
 "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
 "tina.zhang@intel.com" <tina.zhang@intel.com>,
 Kenneth Lee <kenneth-lee-2012@foxmail.com>
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

SGksIEVyaWMKCk9uIDIwMTkvMTEvMjAg5LiL5Y2INjoxOCwgQXVnZXIgRXJpYyB3cm90ZToKPgo+
Pj4gVGhpcyBzZXJpZXMgYnJpbmdzIHRoZSBWRklPIHBhcnQgb2YgSFcgbmVzdGVkIHBhZ2luZyBz
dXBwb3J0Cj4+PiBpbiB0aGUgU01NVXYzLgo+Pj4KPj4+IFRoZSBzZXJpZXMgZGVwZW5kcyBvbjoK
Pj4+IFtQQVRDSCB2OSAwMC8xNF0gU01NVXYzIE5lc3RlZCBTdGFnZSBTZXR1cCAoSU9NTVUgcGFy
dCkKPj4+IChodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9rZXJuZWwvbXNnMzE4NzcxNC5o
dG1sKQo+Pj4KPj4+IDMgbmV3IElPQ1RMcyBhcmUgaW50cm9kdWNlZCB0aGF0IGFsbG93IHRoZSB1
c2Vyc3BhY2UgdG8KPj4+IDEpIHBhc3MgdGhlIGd1ZXN0IHN0YWdlIDEgY29uZmlndXJhdGlvbgo+
Pj4gMikgcGFzcyBzdGFnZSAxIE1TSSBiaW5kaW5ncwo+Pj4gMykgaW52YWxpZGF0ZSBzdGFnZSAx
IHJlbGF0ZWQgY2FjaGVzCj4+Pgo+Pj4gVGhleSBtYXAgb250byB0aGUgcmVsYXRlZCBuZXcgSU9N
TVUgQVBJIGZ1bmN0aW9ucy4KPj4+Cj4+PiBXZSBpbnRyb2R1Y2UgdGhlIGNhcGFiaWxpdHkgdG8g
cmVnaXN0ZXIgc3BlY2lmaWMgaW50ZXJydXB0Cj4+PiBpbmRleGVzIChzZWUgWzFdKS4gQSBuZXcg
RE1BX0ZBVUxUIGludGVycnVwdCBpbmRleCBhbGxvd3MgdG8gcmVnaXN0ZXIKPj4+IGFuIGV2ZW50
ZmQgdG8gYmUgc2lnbmFsZWQgd2hlbmV2ZXIgYSBzdGFnZSAxIHJlbGF0ZWQgZmF1bHQKPj4+IGlz
IGRldGVjdGVkIGF0IHBoeXNpY2FsIGxldmVsLiBBbHNvIGEgc3BlY2lmaWMgcmVnaW9uIGFsbG93
cwo+Pj4gdG8gZXhwb3NlIHRoZSBmYXVsdCByZWNvcmRzIHRvIHRoZSB1c2VyIHNwYWNlLgo+Pj4K
Pj4+IEJlc3QgUmVnYXJkcwo+Pj4KPj4+IEVyaWMKPj4+Cj4+PiBUaGlzIHNlcmllcyBjYW4gYmUg
Zm91bmQgYXQ6Cj4+PiBodHRwczovL2dpdGh1Yi5jb20vZWF1Z2VyL2xpbnV4L3RyZWUvdjUuMy4w
LXJjMC0yc3RhZ2UtdjkKPj4gSSB0aGluayB5b3UgaGF2ZSBhbHJlYWR5IHRlc3RlZCBvbiBUaHVu
ZGVyWDIsIGJ1dCBhcyBhIGZvcm1hbGl0eSwgZm9yCj4+IHRoZSB3aG9sZSBzZXJpZXM6Cj4+Cj4+
IFRlc3RlZC1ieTogVG9tYXN6IE5vd2lja2kgPHRub3dpY2tpQG1hcnZlbGwuY29tPgo+PiBxZW11
OiBodHRwczovL2dpdGh1Yi5jb20vZWF1Z2VyL3FlbXUvdHJlZS92NC4xLjAtcmMwLTJzdGFnZS1y
ZmN2NQo+PiBrZXJuZWw6IGh0dHBzOi8vZ2l0aHViLmNvbS9lYXVnZXIvbGludXgvdHJlZS92NS4z
LjAtcmMwLTJzdGFnZS12OSArCj4+IFNoYW1lZXIncyBmaXggcGF0Y2gKPj4KPj4gSW4gbXkgdGVz
dCBJIGFzc2lnbmVkIEludGVsIDgyNTc0TCBOSUMgYW5kIHBlcmZvcm0gaXBlcmYgdGVzdHMuCj4g
VGhhbmsgeW91IGZvciB5b3VyIHRlc3RpbmcgZWZmb3J0cy4KPj4gT3RoZXIgZm9sa3MgZnJvbSBN
YXJ2ZWxsIGNsYWltZWQgdGhpcyB0byBiZSBpbXBvcnRhbnQgZmVhdHVyZSBzbyBJIGFza2VkCj4+
IHRoZW0gdG8gcmV2aWV3IGFuZCBzcGVhayB1cCBvbiBtYWlsaW5nIGxpc3QuCj4gVGhhdCdzIG5p
Y2UgdG8gcmVhZCB0aGF0ISAgU28gaXQgaXMgdGltZSBmb3IgbWUgdG8gcmViYXNlIGJvdGggdGhl
IGlvbW11Cj4gYW5kIHZmaW8gcGFydHMuIEkgd2lsbCBzdWJtaXQgc29tZXRoaW5nIHF1aWNrbHku
IFRoZW4gSSB3b3VsZCBlbmNvdXJhZ2UKPiB0aGUgcmV2aWV3IGVmZm9ydHMgdG8gZm9jdXMgZmly
c3Qgb24gdGhlIGlvbW11IHBhcnQuCj4KPgp2U1ZBIGZlYXR1cmUgaXMgYWxzbyB2ZXJ5IGltcG9y
dGFudCB0byB1cywgaXQgd2lsbCBiZSBncmVhdCBpZiB2U1ZBIGNhbiAKYmUgc3VwcG9ydGVkIGlu
IGd1ZXN0IHdvcmxkLgoKV2UganVzdCBzdWJtaXR0ZWQgdWFjY2UgZm9yIGFjY2VsZXJhdG9yLCB3
aGljaCB3aWxsIGJlIHN1cHBvcnRpbmcgU1ZBIG9uIApob3N0LCB0aGFua3MgdG8gSmVhbidzIGVm
Zm9ydC4KCmh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIwLzIvMTEvNTQKCgpIb3dldmVyLCBzdXBw
b3J0aW5nIHZTVkEgaW4gZ3Vlc3QgaXMgYWxzbyBhIGtleSBjb21wb25lbnQgZm9yIGFjY2VsZXJh
dG9yLgoKTG9va2luZyBmb3J3YXJkIHRoaXMgZ29pbmcgdG8gYmUgaGFwcGVuLgoKCkFueSByZXNw
aW4sIEkgd2lsbCBiZSB2ZXJ5IGhhcHB5IHRvIHRlc3QuCgoKVGhhbmtzCgoKCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
