Return-Path: <SRS0=Olas=7M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE402C433DF
	for <iommu@archiver.kernel.org>; Sat, 30 May 2020 13:17:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C602074B
	for <iommu@archiver.kernel.org>; Sat, 30 May 2020 13:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I02qo87O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C602074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7D4BA887DC;
	Sat, 30 May 2020 13:17:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 55L9t4Qdm5AU; Sat, 30 May 2020 13:17:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 60CE58854A;
	Sat, 30 May 2020 13:17:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B1A4C0895;
	Sat, 30 May 2020 13:17:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A48E7C016F
 for <iommu@lists.linux-foundation.org>; Sat, 30 May 2020 11:08:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8EEC781392
 for <iommu@lists.linux-foundation.org>; Sat, 30 May 2020 11:08:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YRGM+DglW4zT for <iommu@lists.linux-foundation.org>;
 Sat, 30 May 2020 11:08:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 27BED864DA
 for <iommu@lists.linux-foundation.org>; Sat, 30 May 2020 11:08:44 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A7FA021475
 for <iommu@lists.linux-foundation.org>; Sat, 30 May 2020 11:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590836924;
 bh=earXz4/P68uRR/iSgsEcpzwdpo2LMphL6TdGN7XN94I=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=I02qo87OBfKdtmsSNSsWpcRIcQR/gub2ZBVaSW2xy+XZPuUm6Bd4NecSne2rq5jOv
 a1KFNQJMUIvVg9UR2wMgWYcmZRPNs2fu8kz4xlZgpl7mT7I9wKl6enxULTLH4TOvdn
 TrgXh099LCuJU+WabcnIySUkpggkz34gI6vGiFjE=
Received: by mail-ej1-f43.google.com with SMTP id y13so4635221eju.2
 for <iommu@lists.linux-foundation.org>; Sat, 30 May 2020 04:08:43 -0700 (PDT)
X-Gm-Message-State: AOAM532tC710Yufae0Qo8a1o7Frgm1YYoV0kjLmFBm3OmA73Lxulngns
 8PzJjNh5W4NuzCrpXwLt/yqLolnhiv63m165zA==
X-Google-Smtp-Source: ABdhPJzSDMCU40D8bF0+JP28mWgFd65hKqdR/CfP94iWZgZQDTtaux5DHBxin4XXosAMmg6E2mex7jDQ/0FXg9nqJ+Y=
X-Received: by 2002:a17:906:538d:: with SMTP id
 g13mr11350028ejo.194.1590836922106; 
 Sat, 30 May 2020 04:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
 <1590826218-23653-12-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1590826218-23653-12-git-send-email-yong.wu@mediatek.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Sat, 30 May 2020 19:08:31 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-7ES_tdO4p7aSeVO3x+=0kzWVtCAve-EV_Mrj=WGEmGg@mail.gmail.com>
Message-ID: <CAAOTY_-7ES_tdO4p7aSeVO3x+=0kzWVtCAve-EV_Mrj=WGEmGg@mail.gmail.com>
Subject: Re: [PATCH v4 11/17] drm/mediatek: Get rid of mtk_smi_larb_get/put
To: Yong Wu <yong.wu@mediatek.com>
X-Mailman-Approved-At: Sat, 30 May 2020 13:17:22 +0000
Cc: Will Deacon <will.deacon@arm.com>, youlin.pei@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, Evan Green <evgreen@chromium.org>,
 eizan@chromium.org, Matthias Kaehlcke <mka@chromium.org>,
 CK Hu <ck.hu@mediatek.com>, devicetree@vger.kernel.org, cui.zhang@mediatek.com,
 Tomasz Figa <tfiga@google.com>, Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, anan.sun@mediatek.com,
 acourbot@chromium.org, srv_heupstream <srv_heupstream@mediatek.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, chao.hao@mediatek.com,
 iommu@lists.linux-foundation.org, Philipp Zabel <p.zabel@pengutronix.de>,
 Robin Murphy <robin.murphy@arm.com>
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

SGksIFlvbmc6CgpZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4g5pa8IDIwMjDlubQ15pyI
MzDml6Ug6YCx5YWtIOS4i+WNiDQ6Mjflr6vpgZPvvJoKPgo+IE1lZGlhVGVrIElPTU1VIGhhcyBh
bHJlYWR5IGFkZGVkIHRoZSBkZXZpY2VfbGluayBiZXR3ZWVuIHRoZSBjb25zdW1lcgo+IGFuZCBz
bWktbGFyYiBkZXZpY2UuIElmIHRoZSBkcm0gZGV2aWNlIGNhbGwgdGhlIHBtX3J1bnRpbWVfZ2V0
X3N5bmMsCj4gdGhlIHNtaS1sYXJiJ3MgcG1fcnVudGltZV9nZXRfc3luYyBhbHNvIGJlIGNhbGxl
ZCBhdXRvbWF0aWNhbGx5Lgo+CgpBY2tlZC1ieTogQ2h1bi1LdWFuZyBIdSA8Y2h1bmt1YW5nLmh1
QGtlcm5lbC5vcmc+Cgo+IENDOiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPgo+IENDOiBQaGls
aXBwIFphYmVsIDxwLnphYmVsQHBlbmd1dHJvbml4LmRlPgo+IFNpZ25lZC1vZmYtYnk6IFlvbmcg
V3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPgo+IFJldmlld2VkLWJ5OiBFdmFuIEdyZWVuIDxldmdy
ZWVuQGNocm9taXVtLm9yZz4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fY3J0Yy5jICAgICB8ICA5IC0tLS0tLS0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RybV9kZHBfY29tcC5jIHwgMjEgLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gIGRyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmggfCAgMSAtCj4gIDMgZmlsZXMgY2hh
bmdlZCwgMzEgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fY3J0Yy5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
Y3J0Yy5jCj4gaW5kZXggYzliYzg0NC4uZDRjNDA3OCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RybV9jcnRjLmMKPiBAQCAtOCw3ICs4LDYgQEAKPiAgI2luY2x1ZGUgPGxpbnV4
L3NvYy9tZWRpYXRlay9tdGstY21kcS5oPgo+Cj4gICNpbmNsdWRlIDxhc20vYmFycmllci5oPgo+
IC0jaW5jbHVkZSA8c29jL21lZGlhdGVrL3NtaS5oPgo+Cj4gICNpbmNsdWRlIDxkcm0vZHJtX2F0
b21pY19oZWxwZXIuaD4KPiAgI2luY2x1ZGUgPGRybS9kcm1fcGxhbmVfaGVscGVyLmg+Cj4gQEAg
LTUzMiwxMiArNTMxLDYgQEAgc3RhdGljIHZvaWQgbXRrX2RybV9jcnRjX2F0b21pY19lbmFibGUo
c3RydWN0IGRybV9jcnRjICpjcnRjLAo+Cj4gICAgICAgICBEUk1fREVCVUdfRFJJVkVSKCIlcyAl
ZFxuIiwgX19mdW5jX18sIGNydGMtPmJhc2UuaWQpOwo+Cj4gLSAgICAgICByZXQgPSBtdGtfc21p
X2xhcmJfZ2V0KGNvbXAtPmxhcmJfZGV2KTsKPiAtICAgICAgIGlmIChyZXQpIHsKPiAtICAgICAg
ICAgICAgICAgRFJNX0VSUk9SKCJGYWlsZWQgdG8gZ2V0IGxhcmI6ICVkXG4iLCByZXQpOwo+IC0g
ICAgICAgICAgICAgICByZXR1cm47Cj4gLSAgICAgICB9Cj4gLQo+ICAgICAgICAgcmV0ID0gcG1f
cnVudGltZV9nZXRfc3luYyhjb21wLT5kZXYpOwo+ICAgICAgICAgaWYgKHJldCA8IDApCj4gICAg
ICAgICAgICAgICAgIERSTV9ERVZfRVJST1IoY29tcC0+ZGV2LCAiRmFpbGVkIHRvIGVuYWJsZSBw
b3dlciBkb21haW46ICVkXG4iLAo+IEBAIC01NDUsNyArNTM4LDYgQEAgc3RhdGljIHZvaWQgbXRr
X2RybV9jcnRjX2F0b21pY19lbmFibGUoc3RydWN0IGRybV9jcnRjICpjcnRjLAo+Cj4gICAgICAg
ICByZXQgPSBtdGtfY3J0Y19kZHBfaHdfaW5pdChtdGtfY3J0Yyk7Cj4gICAgICAgICBpZiAocmV0
KSB7Cj4gLSAgICAgICAgICAgICAgIG10a19zbWlfbGFyYl9wdXQoY29tcC0+bGFyYl9kZXYpOwo+
ICAgICAgICAgICAgICAgICBwbV9ydW50aW1lX3B1dChjb21wLT5kZXYpOwo+ICAgICAgICAgICAg
ICAgICByZXR1cm47Cj4gICAgICAgICB9Cj4gQEAgLTU4Miw3ICs1NzQsNiBAQCBzdGF0aWMgdm9p
ZCBtdGtfZHJtX2NydGNfYXRvbWljX2Rpc2FibGUoc3RydWN0IGRybV9jcnRjICpjcnRjLAo+Cj4g
ICAgICAgICBkcm1fY3J0Y192Ymxhbmtfb2ZmKGNydGMpOwo+ICAgICAgICAgbXRrX2NydGNfZGRw
X2h3X2ZpbmkobXRrX2NydGMpOwo+IC0gICAgICAgbXRrX3NtaV9sYXJiX3B1dChjb21wLT5sYXJi
X2Rldik7Cj4gICAgICAgICByZXQgPSBwbV9ydW50aW1lX3B1dChjb21wLT5kZXYpOwo+ICAgICAg
ICAgaWYgKHJldCA8IDApCj4gICAgICAgICAgICAgICAgIERSTV9ERVZfRVJST1IoY29tcC0+ZGV2
LCAiRmFpbGVkIHRvIGRpc2FibGUgcG93ZXIgZG9tYWluOiAlZFxuIiwKPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYyBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMKPiBpbmRleCA1OTMwMjdhLi5hNmU3ZjNh
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21w
LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jCj4g
QEAgLTQzMiw4ICs0MzIsNiBAQCBpbnQgbXRrX2RkcF9jb21wX2luaXQoc3RydWN0IGRldmljZSAq
ZGV2LCBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUsCj4gICAgICAgICAgICAgICAgICAgICAgIGNv
bnN0IHN0cnVjdCBtdGtfZGRwX2NvbXBfZnVuY3MgKmZ1bmNzKQo+ICB7Cj4gICAgICAgICBlbnVt
IG10a19kZHBfY29tcF90eXBlIHR5cGU7Cj4gLSAgICAgICBzdHJ1Y3QgZGV2aWNlX25vZGUgKmxh
cmJfbm9kZTsKPiAtICAgICAgIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmxhcmJfcGRldjsKPiAg
I2lmIElTX1JFQUNIQUJMRShDT05GSUdfTVRLX0NNRFEpCj4gICAgICAgICBzdHJ1Y3QgcmVzb3Vy
Y2UgcmVzOwo+ICAgICAgICAgc3RydWN0IGNtZHFfY2xpZW50X3JlZyBjbWRxX3JlZzsKPiBAQCAt
NDY4LDMxICs0NjYsMTIgQEAgaW50IG10a19kZHBfY29tcF9pbml0KHN0cnVjdCBkZXZpY2UgKmRl
diwgc3RydWN0IGRldmljZV9ub2RlICpub2RlLAo+ICAgICAgICAgaWYgKElTX0VSUihjb21wLT5j
bGspKQo+ICAgICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihjb21wLT5jbGspOwo+Cj4gLSAg
ICAgICAvKiBPbmx5IERNQSBjYXBhYmxlIGNvbXBvbmVudHMgbmVlZCB0aGUgTEFSQiBwcm9wZXJ0
eSAqLwo+IC0gICAgICAgY29tcC0+bGFyYl9kZXYgPSBOVUxMOwo+ICAgICAgICAgaWYgKHR5cGUg
IT0gTVRLX0RJU1BfT1ZMICYmCj4gICAgICAgICAgICAgdHlwZSAhPSBNVEtfRElTUF9PVkxfMkwg
JiYKPiAgICAgICAgICAgICB0eXBlICE9IE1US19ESVNQX1JETUEgJiYKPiAgICAgICAgICAgICB0
eXBlICE9IE1US19ESVNQX1dETUEpCj4gICAgICAgICAgICAgICAgIHJldHVybiAwOwo+Cj4gLSAg
ICAgICBsYXJiX25vZGUgPSBvZl9wYXJzZV9waGFuZGxlKG5vZGUsICJtZWRpYXRlayxsYXJiIiwg
MCk7Cj4gLSAgICAgICBpZiAoIWxhcmJfbm9kZSkgewo+IC0gICAgICAgICAgICAgICBkZXZfZXJy
KGRldiwKPiAtICAgICAgICAgICAgICAgICAgICAgICAiTWlzc2luZyBtZWRpYWRlayxsYXJiIHBo
YW5kbGUgaW4gJXBPRiBub2RlXG4iLCBub2RlKTsKPiAtICAgICAgICAgICAgICAgcmV0dXJuIC1F
SU5WQUw7Cj4gLSAgICAgICB9Cj4gLQo+IC0gICAgICAgbGFyYl9wZGV2ID0gb2ZfZmluZF9kZXZp
Y2VfYnlfbm9kZShsYXJiX25vZGUpOwo+IC0gICAgICAgaWYgKCFsYXJiX3BkZXYpIHsKPiAtICAg
ICAgICAgICAgICAgZGV2X3dhcm4oZGV2LCAiV2FpdGluZyBmb3IgbGFyYiBkZXZpY2UgJXBPRlxu
IiwgbGFyYl9ub2RlKTsKPiAtICAgICAgICAgICAgICAgb2Zfbm9kZV9wdXQobGFyYl9ub2RlKTsK
PiAtICAgICAgICAgICAgICAgcmV0dXJuIC1FUFJPQkVfREVGRVI7Cj4gLSAgICAgICB9Cj4gLSAg
ICAgICBvZl9ub2RlX3B1dChsYXJiX25vZGUpOwo+IC0KPiAtICAgICAgIGNvbXAtPmxhcmJfZGV2
ID0gJmxhcmJfcGRldi0+ZGV2Owo+IC0KPiAgICAgICAgIGNvbXAtPmRldiA9IGRldjsKPgo+ICAj
aWYgSVNfUkVBQ0hBQkxFKENPTkZJR19NVEtfQ01EUSkKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuaCBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2RkcF9jb21wLmgKPiBpbmRleCA0YzA2M2UwLi4xMWM3MTIwIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmgKPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oCj4gQEAgLTk4LDcg
Kzk4LDYgQEAgc3RydWN0IG10a19kZHBfY29tcCB7Cj4gICAgICAgICBzdHJ1Y3QgY2xrICpjbGs7
Cj4gICAgICAgICB2b2lkIF9faW9tZW0gKnJlZ3M7Cj4gICAgICAgICBpbnQgaXJxOwo+IC0gICAg
ICAgc3RydWN0IGRldmljZSAqbGFyYl9kZXY7Cj4gICAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXY7
Cj4gICAgICAgICBlbnVtIG10a19kZHBfY29tcF9pZCBpZDsKPiAgICAgICAgIGNvbnN0IHN0cnVj
dCBtdGtfZGRwX2NvbXBfZnVuY3MgKmZ1bmNzOwo+IC0tCj4gMS45LjEKPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IExpbnV4LW1lZGlhdGVrIG1haWxp
bmcgbGlzdAo+IExpbnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW1lZGlhdGVrCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
