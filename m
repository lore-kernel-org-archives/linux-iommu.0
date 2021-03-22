Return-Path: <SRS0=3kXM=IU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AECFC433C1
	for <iommu@archiver.kernel.org>; Mon, 22 Mar 2021 09:24:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C1B561937
	for <iommu@archiver.kernel.org>; Mon, 22 Mar 2021 09:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1B561937
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4E34826C2;
	Mon, 22 Mar 2021 09:24:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dHLWKmmhroNr; Mon, 22 Mar 2021 09:24:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id AAB1882695;
	Mon, 22 Mar 2021 09:24:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C16FC000B;
	Mon, 22 Mar 2021 09:24:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DBF3C0001
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 09:24:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 05BD440218
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 09:24:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gm_MNX0FsBPp for <iommu@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 09:24:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6D81B40203
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 09:24:21 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id x16so15846671wrn.4
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 02:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=VWtR8KlOcQ/dRYdCQQ3jM8KP7ad2PsBUuVXGD0LTdjA=;
 b=fRHQUYdDILcpfmFZPajioQDe1shm3v7+PmX5riSU+Vb7du56hShPmszeNHz0p/JF9y
 WTn6C5cEfg3ce/85Q7Kgah0vZQs2SFfUDSNZVFAQtr0wsI4SgRLyLibvoq7Da6+08ssd
 10TtaDTn5PcmmrJytU8mqDpFISfcb7jO/8AnkGDlwZjlCeIV7lUHeN2p8Z5W70DgtTSR
 yOICtMTkYMH0fw2uiuAreQp7KiLv2YZIglHPoO/CYtvH4r7U72jol+yJMW79TFddAWef
 53y1ZeP8GZWBt0HrJX17YbHxxhHzYno2MU+OuPWrsQ7wL8BCnLivBFxpPRGvZ7K9kz2y
 Mr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=VWtR8KlOcQ/dRYdCQQ3jM8KP7ad2PsBUuVXGD0LTdjA=;
 b=reNbdHDYYikyYAREhp6+KZ/CGtvLmLPgdziz27tSgRTD5cL/bxewsoVS3YcjnEnG4t
 PGc174ZUp+UNGiZCEyC0RKQIN2ZDdNn0peQaudS7RoNOSAmPL9F4JX4rspLebgiWweN5
 Ct3HuJSQzYhT+I30Deh3Ds+HM2uSu/yWI6bF+m85oaa/Fy7aHb6yLjJIfS/EvLh3SC+E
 QeN4qh29xi3/tk8Vm9Iy1jvxfmd8/Gm5RYPHmcRgvbopy0Nt04gQqN4LNcg3rlxPqV4m
 9DzY6i1aSKD+N1r3g9cC+iXhmRTvwf+6Tn0S5TP9cXMXYo0ZleV8kzRgcgkfZrgwz1Qe
 yDbg==
X-Gm-Message-State: AOAM531uNACuyQoDaKvxx8GwPQlDEu2MPjaEw4yd7ADfB4PwRxKWZ9EX
 ylFE9JzZ4L3UEUUypa4yEqrdHA==
X-Google-Smtp-Source: ABdhPJyWqQjRwjDKuYXT4l/U+wYd8vDYnHlFON2Z+w206Gu8iy4wPDPpZvHQprkb+ZsZNf5evw0SKg==
X-Received: by 2002:adf:fd91:: with SMTP id d17mr17275764wrr.0.1616405059461; 
 Mon, 22 Mar 2021 02:24:19 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id g16sm20103641wrs.76.2021.03.22.02.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Mar 2021 02:24:18 -0700 (PDT)
Date: Mon, 22 Mar 2021 10:24:00 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YFhiMLR35WWMW/Hu@myrica>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210318172234.3e8c34f7@jacob-builder> <YFR10eeDVf5ZHV5l@myrica>
 <20210319124645.GP2356281@nvidia.com> <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210319112221.5123b984@jacob-builder>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 iommu@lists.linux-foundation.org, Li Zefan <lizefan@huawei.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>
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

T24gRnJpLCBNYXIgMTksIDIwMjEgYXQgMTE6MjI6MjFBTSAtMDcwMCwgSmFjb2IgUGFuIHdyb3Rl
Ogo+IEhpIEphc29uLAo+IAo+IE9uIEZyaSwgMTkgTWFyIDIwMjEgMTA6NTQ6MzIgLTAzMDAsIEph
c29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+IHdyb3RlOgo+IAo+ID4gT24gRnJpLCBNYXIg
MTksIDIwMjEgYXQgMDI6NDE6MzJQTSArMDEwMCwgSmVhbi1QaGlsaXBwZSBCcnVja2VyIHdyb3Rl
Ogo+ID4gPiBPbiBGcmksIE1hciAxOSwgMjAyMSBhdCAwOTo0Njo0NUFNIC0wMzAwLCBKYXNvbiBH
dW50aG9ycGUgd3JvdGU6ICAKPiA+ID4gPiBPbiBGcmksIE1hciAxOSwgMjAyMSBhdCAxMDo1ODo0
MUFNICswMTAwLCBKZWFuLVBoaWxpcHBlIEJydWNrZXIgd3JvdGU6Cj4gPiA+ID4gICAKPiA+ID4g
PiA+IEFsdGhvdWdoIHRoZXJlIGlzIG5vIHVzZSBmb3IgaXQgYXQgdGhlIG1vbWVudCAob25seSB0
d28gdXBzdHJlYW0KPiA+ID4gPiA+IHVzZXJzIGFuZCBpdCBsb29rcyBsaWtlIGFtZGtmZCBhbHdh
eXMgdXNlcyBjdXJyZW50IHRvbyksIEkgcXVpdGUKPiA+ID4gPiA+IGxpa2UgdGhlIGNsaWVudC1z
ZXJ2ZXIgbW9kZWwgd2hlcmUgdGhlIHByaXZpbGVnZWQgcHJvY2VzcyBkb2VzCj4gPiA+ID4gPiBi
aW5kKCkgYW5kIHByb2dyYW1zIHRoZSBoYXJkd2FyZSBxdWV1ZSBvbiBiZWhhbGYgb2YgdGhlIGNs
aWVudAo+ID4gPiA+ID4gcHJvY2Vzcy4gIAo+ID4gPiA+IAo+ID4gPiA+IFRoaXMgY3JlYXRlcyBh
IGxvdCBjb21wbGV4aXR5LCBob3cgZG8gZG9lcyBwcm9jZXNzIEEgZ2V0IGEgc2VjdXJlCj4gPiA+
ID4gcmVmZXJlbmNlIHRvIEI/IEhvdyBkb2VzIGl0IGFjY2VzcyB0aGUgbWVtb3J5IGluIEIgdG8g
c2V0dXAgdGhlIEhXPyAgCj4gPiA+IAo+ID4gPiBtbV9hY2Nlc3MoKSBmb3IgZXhhbXBsZSwgYW5k
IHBhc3NpbmcgYWRkcmVzc2VzIHZpYSBJUEMgIAo+ID4gCj4gPiBJJ2QgcmF0aGVyIHRoZSBzb3Vy
Y2UgcHJvY2VzcyBlc3RhYmxpc2ggaXRzIG93biBQQVNJRCBhbmQgdGhlbiBwYXNzCj4gPiB0aGUg
cmlnaHRzIHRvIHVzZSBpdCB0byBzb21lIG90aGVyIHByb2Nlc3MgdmlhIEZEIHBhc3NpbmcgdGhh
biB0cnkgdG8KPiA+IGdvIHRoZSBvdGhlciB3YXkuIFRoZXJlIGFyZSBsb3RzIG9mIHNlY3VyaXR5
IHF1ZXN0aW9ucyB3aXRoIHNvbWV0aGluZwo+ID4gbGlrZSBtbV9hY2Nlc3MuCj4gPiAKPiAKPiBU
aGFuayB5b3UgYWxsIGZvciB0aGUgaW5wdXQsIGl0IHNvdW5kcyBsaWtlIHdlIGFyZSBPSyB0byBy
ZW1vdmUgbW0gYXJndW1lbnQKPiBmcm9tIGlvbW11X3N2YV9iaW5kX2RldmljZSgpIGFuZCBpb21t
dV9zdmFfYWxsb2NfcGFzaWQoKSBmb3Igbm93PwoKRmluZSBieSBtZS4gQnkgdGhlIHdheSB0aGUg
SURYRCBjdXJyZW50bHkgbWlzc3VlcyB0aGUgYmluZCBBUEkgZm9yCnN1cGVydmlzb3IgUEFTSUQs
IGFuZCB0aGUgZHJ2ZGF0YSBwYXJhbWV0ZXIgaXNuJ3Qgb3RoZXJ3aXNlIHVzZWQuIFRoaXMKd291
bGQgYmUgYSBnb29kIG9jY2FzaW9uIHRvIGNsZWFuIGJvdGguIFRoZSBuZXcgYmluZCBwcm90b3R5
cGUgY291bGQgYmU6CgpzdHJ1Y3QgaW9tbXVfc3ZhICppb21tdV9zdmFfYmluZF9kZXZpY2Uoc3Ry
dWN0IGRldmljZSAqZGV2LCBpbnQgZmxhZ3MpCgpBbmQgYSBmbGFnIElPTU1VX1NWQV9CSU5EX1NV
UEVSVklTT1IgKG5vdCB0aGF0IEkgcGxhbiB0byBpbXBsZW1lbnQgaXQgaW4KdGhlIFNNTVUsIGJ1
dCBJIHRoaW5rIHdlIG5lZWQgdG8gY2xlYW4gdGhlIGN1cnJlbnQgdXNhZ2UpCgo+IAo+IExldCBt
ZSB0cnkgdG8gc3VtbWFyaXplIFBBU0lEIGFsbG9jYXRpb24gYXMgYmVsb3c6Cj4gCj4gSW50ZXJm
YWNlcwl8IFVzYWdlCXwgIExpbWl0CXwgYmluZMK5IHxVc2VyIHZpc2libGUKPiAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQo+IC9kZXYvaW9hc2lkwrIJfCBHLVNWQS9JT1ZBCXwgIGNncm91cAl8IE5vCXxZZXMKPiAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQo+IGNoYXIgZGV2wrMJfCBTVkEJCXwgIGNncm91cAl8IFllcwl8Tm8KPiAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQo+IGlvbW11IGRyaXZlcgl8IGRlZmF1bHQgUEFTSUR8ICBubwkJfCBObwl8Tm8KCklzIHRo
aXMgUEFTSUQgIzA/Cgo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4ga2VybmVsCQl8IHN1cGVyIFNWQQl8IG5vCQl8
IHllcyAgIHxObwo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgpBbHNvIHdvbmRlcmluZyBhYm91dCBkZXZpY2UgZHJp
dmVyIGFsbG9jYXRpbmcgYXV4aWxpYXJ5IGRvbWFpbnMgZm9yIHRoZWlyCnByaXZhdGUgdXNlLCB0
byBkbyBpb21tdV9tYXAvdW5tYXAgb24gcHJpdmF0ZSBQQVNJRHMgKGEgY2xlYW4gcmVwbGFjZW1l
bnQKdG8gc3VwZXIgU1ZBLCBmb3IgZXhhbXBsZSkuIFdvdWxkIHRoYXQgZ28gdGhyb3VnaCB0aGUg
c2FtZSBwYXRoIGFzCi9kZXYvaW9hc2lkIGFuZCB1c2UgdGhlIGNncm91cCBvZiBjdXJyZW50IHRh
c2s/CgpUaGFua3MsCkplYW4KCj4gCj4gwrkgQWxsb2NhdGVkIGR1cmluZyBTVkEgYmluZAo+IMKy
IFBBU0lEcyBhbGxvY2F0ZWQgdmlhIC9kZXYvaW9hc2lkIGFyZSBub3QgYm91bmQgdG8gYW55IG1t
LiBCdXQgaXRzCj4gICBvd25lcnNoaXAgaXMgYXNzaWduZWQgdG8gdGhlIHByb2Nlc3MgdGhhdCBk
b2VzIHRoZSBhbGxvY2F0aW9uLgo+IMKzIEluY2x1ZGUgdWFjY2UsIG90aGVyIHByaXZhdGUgZGV2
aWNlIGRyaXZlciBjaGFyIGRldiBzdWNoIGFzIGlkeGQKPiAKPiBDdXJyZW50bHksIHRoZSBwcm9w
b3NlZCAvZGV2L2lvYXNpZCBpbnRlcmZhY2UgZG9lcyBub3QgbWFwIGluZGl2aWR1YWwgUEFTSUQK
PiB3aXRoIGFuIEZELiBUaGUgRkQgaXMgYXQgdGhlIGlvYXNpZF9zZXQgZ3JhbnVsYXJpdHkgYW5k
IGJvbmQgdG8gdGhlIGN1cnJlbnQKPiBtbS4gV2UgY291bGQgZXh0ZW5kIHRoZSBJT0NUTHMgdG8g
Y292ZXIgaW5kaXZpZHVhbCBQQVNJRC1GRCBwYXNzaW5nIGNhc2UKPiB3aGVuIHVzZSBjYXNlcyBh
cmlzZS4gV291bGQgdGhpcyB3b3JrPwo+IAo+IFRoYW5rcywKPiAKPiBKYWNvYgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
