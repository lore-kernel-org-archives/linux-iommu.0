Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E56C433F5
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 18:32:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 584F761374
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 18:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 584F761374
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2595760B4F;
	Tue, 28 Sep 2021 18:32:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nHs5k8VvyfvA; Tue, 28 Sep 2021 18:32:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DC05C60B24;
	Tue, 28 Sep 2021 18:32:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF867C0011;
	Tue, 28 Sep 2021 18:32:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 346FBC000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 18:32:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2ED3240583
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 18:32:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oWzdyTp3Aatz for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 18:32:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2294540105
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 18:32:21 +0000 (UTC)
Received: by mail-qv1-xf32.google.com with SMTP id a14so14039358qvb.6
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 11:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=bg5/FXYy6+0jcxwwe7U26Md8Qo1QDW6vkKmJYeX4i1Y=;
 b=Hl/E00tVRRsG4VyZTxHCUyfFppftH6aDIraQlh7Zo4b85gvTNF+AYqXgzSNwc5/npf
 l06458g+lvnyddemEzX90uBn/bHB8RYcKfeo1e7FpLjMI+74Dzz/0g/94z+f7GzW+0Zd
 CfpRY5E+W8e1NS+sbJ1/ugjuNMbciPIgxXLMQk1vyLzXxq0uHenjiyziZ6R3dyiq9JVL
 p4sfE2H5q8AjNru6j9eT1fchBVmabhTgc0UQSbcACR3kakx5Tj48HjTa5txeDIwD47Yn
 QqR/fi/0MROMXY9kXIbtoFfIdbEtX3H3w3iXU5cvYHfX3miyrcJhnWwRC/Xh64nSBvuk
 yGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=bg5/FXYy6+0jcxwwe7U26Md8Qo1QDW6vkKmJYeX4i1Y=;
 b=yJZ21Ijy3gVk3usUzLt31oiC4Y/lsUv8rLzriVhb9h1lHPpZKkZe5h464x0sDFsccg
 fhBjKSAblTXAzzM4QR8winkcQknHm+RoJET9KQ2qFC7csTXat1StdakGjLkg7JxOr1bx
 tzgkmiMJxMJGWS76srN9sbGQD/ZXp4lSpsznQiZ4DrQZ53sjx3J4SKBiZ5a6Kq+WC+Z1
 eF4OXtgXWMPeRCat0mNH1ha5/a7uJJ3A6cAr+CU7UNvgQcmtm1L+ImywYEdUWf/Af5tU
 b0KEp/ag6R8vysCW8PbldKun53R8AjL9z/ydkdpoq2H7a8AzeP75htC7gt5zJ3J4D3KA
 W6IQ==
X-Gm-Message-State: AOAM533IRQiNYxdPtmgGpQ/mZTP0ODnGmsvrlD1sarZaMLJiH7x1yI84
 i/CSrU/Tddo1qjcVuvmb+6cQQA==
X-Google-Smtp-Source: ABdhPJzfCJn9TE545S5oPvfgJD/DrRXSPKUbE0avVhY8SKIQnFw2dHzYLn+zJmKsF3kZryoXkBtS0Q==
X-Received: by 2002:ad4:4652:: with SMTP id y18mr7157907qvv.2.1632853940961;
 Tue, 28 Sep 2021 11:32:20 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id w185sm16014000qkd.30.2021.09.28.11.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Sep 2021 11:32:20 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVHtr-007FEl-RE; Tue, 28 Sep 2021 15:32:19 -0300
Date: Tue, 28 Sep 2021 15:32:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v3 01/20] lib/scatterlist: add flag for indicating P2PDMA
 segments in an SGL
Message-ID: <20210928183219.GJ3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-2-logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, linux-block@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
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

T24gVGh1LCBTZXAgMTYsIDIwMjEgYXQgMDU6NDA6NDFQTSAtMDYwMCwgTG9nYW4gR3VudGhvcnBl
IHdyb3RlOgo+IE1ha2UgdXNlIG9mIHRoZSB0aGlyZCBmcmVlIExTQiBpbiBzY2F0dGVybGlzdCdz
IHBhZ2VfbGluayBvbiA2NGJpdCBzeXN0ZW1zLgo+IAo+IFRoZSBleHRyYSBiaXQgd2lsbCBiZSB1
c2VkIGJ5IGRtYV9bdW5dbWFwX3NnX3AycGRtYSgpIHRvIGRldGVybWluZSB3aGVuIGEKPiBnaXZl
biBTR0wgc2VnbWVudHMgZG1hX2FkZHJlc3MgcG9pbnRzIHRvIGEgUENJIGJ1cyBhZGRyZXNzLgo+
IGRtYV91bm1hcF9zZ19wMnBkbWEoKSB3aWxsIG5lZWQgdG8gcGVyZm9ybSBkaWZmZXJlbnQgY2xl
YW51cCB3aGVuIGEKPiBzZWdtZW50IGlzIG1hcmtlZCBhcyBQMlBETUEuCj4gCj4gVXNpbmcgdGhp
cyBiaXQgcmVxdWlyZXMgYWRkaW5nIGFuIGFkZGl0aW9uYWwgZGVwZW5kZW5jeSBvbiBDT05GSUdf
NjRCSVQgdG8KPiBDT05GSUdfUENJX1AyUERNQS4gVGhpcyBzaG91bGQgYmUgYWNjZXB0YWJsZSBh
cyB0aGUgbWFqb3JpdHkgb2YgUDJQRE1BCj4gdXNlIGNhc2VzIGFyZSByZXN0cmljdGVkIHRvIG5l
d2VyIHJvb3QgY29tcGxleGVzIGFuZCByb3VnaGx5IHJlcXVpcmUgdGhlCj4gZXh0cmEgYWRkcmVz
cyBzcGFjZSBmb3IgbWVtb3J5IEJBUnMgdXNlZCBpbiB0aGUgdHJhbnNhY3Rpb25zLgo+IAo+IFNp
Z25lZC1vZmYtYnk6IExvZ2FuIEd1bnRob3JwZSA8bG9nYW5nQGRlbHRhdGVlLmNvbT4KPiBSZXZp
ZXdlZC1ieTogSm9obiBIdWJiYXJkIDxqaHViYmFyZEBudmlkaWEuY29tPgo+ICBkcml2ZXJzL3Bj
aS9LY29uZmlnICAgICAgICAgfCAgMiArLQo+ICBpbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0Lmgg
fCA1MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tCj4gIDIgZmlsZXMgY2hh
bmdlZCwgNDcgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9wY2kvS2NvbmZpZyBiL2RyaXZlcnMvcGNpL0tjb25maWcKPiBpbmRleCAwYzQ3M2Q3
NWU2MjUuLjkwYjRiZGRiMzMwMCAxMDA2NDQKPiArKysgYi9kcml2ZXJzL3BjaS9LY29uZmlnCj4g
QEAgLTE2Myw3ICsxNjMsNyBAQCBjb25maWcgUENJX1BBU0lECj4gIAo+ICBjb25maWcgUENJX1Ay
UERNQQo+ICAJYm9vbCAiUENJIHBlZXItdG8tcGVlciB0cmFuc2ZlciBzdXBwb3J0Igo+IC0JZGVw
ZW5kcyBvbiBaT05FX0RFVklDRQo+ICsJZGVwZW5kcyBvbiBaT05FX0RFVklDRSAmJiA2NEJJVAoK
UGVyaGFwcyBhIGNvbW1lbnQgdG8gZXhwbGFpbiB3aGF0IHRoZSA2NGJpdCBpcyBkb2luZz8KCj4g
IAlzZWxlY3QgR0VORVJJQ19BTExPQ0FUT1IKPiAgCWhlbHAKPiAgCSAgRW5hYmxl0ZUgZHJpdmVy
cyB0byBkbyBQQ0kgcGVlci10by1wZWVyIHRyYW5zYWN0aW9ucyB0byBhbmQgZnJvbQo+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmggYi9pbmNsdWRlL2xpbnV4L3NjYXR0
ZXJsaXN0LmgKPiBpbmRleCAyNjY3NTRhNTUzMjcuLmU2MmIxY2Y2Mzg2ZiAxMDA2NDQKPiArKysg
Yi9pbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmgKPiBAQCAtNjQsNiArNjQsMjEgQEAgc3RydWN0
IHNnX2FwcGVuZF90YWJsZSB7Cj4gICNkZWZpbmUgU0dfQ0hBSU4JMHgwMVVMCj4gICNkZWZpbmUg
U0dfRU5ECQkweDAyVUwKPiAgCj4gKy8qCj4gKyAqIGJpdCAyIGlzIHRoZSB0aGlyZCBmcmVlIGJp
dCBpbiB0aGUgcGFnZV9saW5rIG9uIDY0Yml0IHN5c3RlbXMgd2hpY2gKPiArICogaXMgdXNlZCBi
eSBkbWFfdW5tYXBfc2coKSB0byBkZXRlcm1pbmUgaWYgdGhlIGRtYV9hZGRyZXNzIGlzIGEgUENJ
Cj4gKyAqIGJ1cyBhZGRyZXNzIHdoZW4gZG9pbmcgUDJQRE1BLgo+ICsgKiBOb3RlOiBDT05GSUdf
UENJX1AyUERNQSBkZXBlbmRzIG9uIENPTkZJR182NEJJVCBiZWNhdXNlIG9mIHRoaXMuCj4gKyAq
Lwo+ICsKPiArI2lmZGVmIENPTkZJR19QQ0lfUDJQRE1BCj4gKyNkZWZpbmUgU0dfRE1BX1BDSV9Q
MlBETUEJMHgwNFVMCgpBZGQgYSAKCXN0YXRpY19hc3NlcnQoX19hbGlnbm9mX18odm9pZCAqKSA9
PSA4KTsKCj8KCj4gKyNlbHNlCj4gKyNkZWZpbmUgU0dfRE1BX1BDSV9QMlBETUEJMHgwMFVMCj4g
KyNlbmRpZgo+ICsKPiArI2RlZmluZSBTR19QQUdFX0xJTktfTUFTSyAoU0dfQ0hBSU4gfCBTR19F
TkQgfCBTR19ETUFfUENJX1AyUERNQSkKPiArCj4gIC8qCj4gICAqIFdlIG92ZXJsb2FkIHRoZSBM
U0Igb2YgdGhlIHBhZ2UgcG9pbnRlciB0byBpbmRpY2F0ZSB3aGV0aGVyIGl0J3MKPiAgICogYSB2
YWxpZCBzZyBlbnRyeSwgb3Igd2hldGhlciBpdCBwb2ludHMgdG8gdGhlIHN0YXJ0IG9mIGEgbmV3
IHNjYXR0ZXJsaXN0Lgo+IEBAIC03Miw3ICs4Nyw5IEBAIHN0cnVjdCBzZ19hcHBlbmRfdGFibGUg
ewo+ICAjZGVmaW5lIHNnX2lzX2NoYWluKHNnKQkJKChzZyktPnBhZ2VfbGluayAmIFNHX0NIQUlO
KQo+ICAjZGVmaW5lIHNnX2lzX2xhc3Qoc2cpCQkoKHNnKS0+cGFnZV9saW5rICYgU0dfRU5EKQo+
ICAjZGVmaW5lIHNnX2NoYWluX3B0cihzZykJXAo+IC0JKChzdHJ1Y3Qgc2NhdHRlcmxpc3QgKikg
KChzZyktPnBhZ2VfbGluayAmIH4oU0dfQ0hBSU4gfCBTR19FTkQpKSkKPiArCSgoc3RydWN0IHNj
YXR0ZXJsaXN0ICopKChzZyktPnBhZ2VfbGluayAmIH5TR19QQUdFX0xJTktfTUFTSykpCj4gKwo+
ICsjZGVmaW5lIHNnX2lzX2RtYV9wY2lfcDJwZG1hKHNnKSAoKHNnKS0+cGFnZV9saW5rICYgU0df
RE1BX1BDSV9QMlBETUEpCgpJJ3ZlIGJlZW4gZW5jb3VyYWdpbmcgcGVvcGxlIHRvIHVzZSBzdGF0
aWMgaW5saW5lcyBtb3JlLi4KCnN0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IF9fc2dfZmxhZ3Mo
c3RydWN0IHNjYXR0ZXJsaXN0ICpzZykKewoJcmV0dXJuIHNnLT5wYWdlX2xpbmsgJiBTR19QQUdF
X0xJTktfTUFTSzsKfQpzdGF0aWMgaW5saW5lIGJvb2wgc2dfaXNfY2hhaW4oc3RydWN0IHNjYXR0
ZXJsaXN0ICpzZykKewoJcmV0dXJuIF9fc2dfZmxhZ3Moc2cpICYgU0dfQ0hBSU47Cn0Kc3RhdGlj
IGlubGluZSBib29sIHNnX2lzX2xhc3Qoc3RydWN0IHNjYXR0ZXJsaXN0ICpzZykKewoJcmV0dXJu
IF9fc2dfZmxhZ3Moc2cpICYgU0dfRU5EOwp9CnN0YXRpYyBpbmxpbmUgYm9vbCBzZ19pc19kbWFf
cGNpX3AycGRtYShzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnKQp7CglyZXR1cm4gX19zZ19mbGFncyhz
ZykgJiBTR19ETUFfUENJX1AyUERNQTsKfQoKPiAgLyoqCj4gICAqIHNnX2Fzc2lnbl9wYWdlIC0g
QXNzaWduIGEgZ2l2ZW4gcGFnZSB0byBhbiBTRyBlbnRyeQo+IEBAIC04NiwxMyArMTAzLDEzIEBA
IHN0cnVjdCBzZ19hcHBlbmRfdGFibGUgewo+ICAgKiovCj4gIHN0YXRpYyBpbmxpbmUgdm9pZCBz
Z19hc3NpZ25fcGFnZShzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnLCBzdHJ1Y3QgcGFnZSAqcGFnZSkK
PiAgewo+IC0JdW5zaWduZWQgbG9uZyBwYWdlX2xpbmsgPSBzZy0+cGFnZV9saW5rICYgKFNHX0NI
QUlOIHwgU0dfRU5EKTsKPiArCXVuc2lnbmVkIGxvbmcgcGFnZV9saW5rID0gc2ctPnBhZ2VfbGlu
ayAmIFNHX1BBR0VfTElOS19NQVNLOwoKSSB0aGluayB0aGlzIHNob3VsZCBqdXN0IGJlICcmIFNH
X0VORCcsIHNnX2Fzc2lnbl9wYWdlKCkgZG9lc24ndCBsb29rCmxpa2UgaXQgc2hvdWxkIGV2ZXIg
YmUgdXNlZCBvbiBhIHNnX2NoYWluIGVudHJ5LCBzbyB0aGlzIGlzIGp1c3QKdHJ5aW5nIHRvIHBy
ZXNlcnZlIHRoZSBlbmQgc3RhbXAuCgpBbnl3YXksIHRoaXMgbG9va3MgT0sKClJldmlld2VkLWJ5
OiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPgoKSmFzb24KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
