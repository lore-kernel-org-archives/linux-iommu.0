Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3ADBC433EF
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 11:57:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9AEEE832A9;
	Thu, 12 May 2022 11:57:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OOLmSLQ__aCf; Thu, 12 May 2022 11:57:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 87F3A833C6;
	Thu, 12 May 2022 11:57:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C12AC0039;
	Thu, 12 May 2022 11:57:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26B38C002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 11:57:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0F28D402BC
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 11:57:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=foxmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vqyjuzEnd35i for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:57:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com
 [203.205.221.209])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C915240025
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 11:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1652356651;
 bh=iY2yJcOLbtsYvLDgfwb1awyh7iPMEY/G3mZOTKxuvSo=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To;
 b=h5YTEOcUp/cSeBcfW5vICGhwBpZ8fQWphC8O8CNtbO6yCuBJ1TBmABfyA9bfaDlNO
 cskk+Ind6Zj+EED2dxH38Foe6ykWMiAp5rbv9CD2aBmrI/Zo6RcxppLcP59K3TdheD
 mD+Jn+oV3m6hJR70qm6ZHTkO1XMbthvgidLV4dHc=
Received: from [192.168.0.110] ([36.57.146.152])
 by newxmesmtplogicsvrszc8.qq.com (NewEsmtp) with SMTP
 id E5B18659; Thu, 12 May 2022 19:57:27 +0800
X-QQ-mid: xmsmtpt1652356647tckuvhfck
Message-ID: <tencent_64CD1D42838611CFDB6E6A224DF469C10D08@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujtdw9xm6YqEJCpuOaHp7geMFL7LuaYCdhh86xQ58E5X0S1COleI
 g6J2yMjukbzR7JdZZ6k88mMftRMWnk0gNotf4G9j+N74QRTYmvn4aiiu91evfDmELV2wtPr7IXqd
 Rn6M0R34PwYUxJELpiqjxc1hUot8ADAMJKK5sNSyFWrN33Q33MbSSsUL9zOtVPddDSX3+vrjttoI
 I/fvLzR1puBh5l24yT72z4GvroL1LNrNj3ylsuJp7R6RrPdhvDlexxyoGL5kZb/vgq+n25O/BJn3
 TdES50w336OX53XHuIr89wNpX0gJlv4A4vI8z5Wq8z4SfLaB6WX2siyKI+4RdTmsxcP0P6qTsYxF
 uj/zShH4mLFDxwRc5zI4dXvhxUkB9+SEBdZ2XTkVEGeopZRFwiSpc2wMT+mudDbAgigFD/gbKMhr
 F1n0zENLia7unuI9lC58b9fbEAN9PjtlWKObcIF4FVVAKPwkc5Nz8FwJvsyWaOtcao8dFoEMKeMo
 7FsmA+6JodrlKGxQRixF8evrN30lbm3aNHb2n+6Kbk106J3QRybFlRcMsWaC3nMrj4+ROfwbTRhl
 ObNlAzR2RSm42de5O0zL52a58Z+Gk7zif3KalKCR05GmCIw8oO//SzpHuv+cSGHvJfUPWJBO1hRo
 QMWAxbYot9O8LG0JjO/b+n5sQS/N0WsJINq93VT6EeX0+hP9mPchs22cjH8wEakkKFeXSbDtNKXi
 hB+CPqa9FjGmHezgb3AD3U7Z4xDBRVBfmqyMSrvOESg4mCFdRyIxYf2Pp4aGx3A/MLfGDEuD6ELY
 vPZQNbwmknt7373yOoVGtRPuVkYu3PbWISa8vNSNTecBUiKNts1q4NdUoTdUSHPL0fEjml42DWgf
 Gi4TguWS5OzOmkvPGMivPNVShZxwaNNtFUfdXRjcuTFPw1MoX3czmflR+hq1h/12O8+eq6vy2XZo
 /NE/4UcMFQ6e2dpm8l1Q==
Subject: Re: [PATCH] vfio: Remove VFIO_TYPE1_NESTING_IOMMU
To: Jason Gunthorpe <jgg@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>
References: <0-v1-0093c9b0e345+19-vfio_no_nesting_jgg@nvidia.com>
 <0e2f7cb8-f0d9-8209-6bc2-ca87fff57f1f@arm.com>
 <20220510181327.GM49344@nvidia.com>
 <6c6f3ecb-6339-4093-a15a-fcf95a7c61fb@linaro.org>
 <20220512113241.GQ49344@nvidia.com>
From: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <95041b28-c676-4063-9a85-838f1b971b98@foxmail.com>
Date: Thu, 12 May 2022 19:57:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220512113241.GQ49344@nvidia.com>
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kvm@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Cornelia Huck <cohuck@redhat.com>,
 iommu@lists.linux-foundation.org, Vivek Kumar Gautam <Vivek.Gautam@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

CgpPbiAyMDIyLzUvMTIg5LiL5Y2INzozMiwgSmFzb24gR3VudGhvcnBlIHZpYSBpb21tdSB3cm90
ZToKPiBPbiBUaHUsIE1heSAxMiwgMjAyMiBhdCAwMzowNzowOVBNICswODAwLCBaaGFuZ2ZlaSBH
YW8gd3JvdGU6Cj4+Pj4gSSBjYW4ndCBoZWxwIGZlZWxpbmcgYSBsaXR0bGUgd2FyeSBhYm91dCBy
ZW1vdmluZyB0aGlzIHVudGlsIElPTU1VRkQKPj4+PiBjYW4gYWN0dWFsbHkgb2ZmZXIgYSBmdW5j
dGlvbmFsIHJlcGxhY2VtZW50IC0gaXMgaXQgaW4gdGhlIHdheSBvZgo+Pj4+IGFueXRoaW5nIHVw
Y29taW5nPwo+Pj4gICBGcm9tIGFuIHVwc3RyZWFtIHBlcnNwZWN0aXZlIGlmIHNvbWVvbmUgaGFz
IGEgcGF0Y2hlZCBrZXJuZWwgdG8KPj4+IGNvbXBsZXRlIHRoZSBmZWF0dXJlLCB0aGVuIHRoZXkg
Y2FuIHBhdGNoIHRoaXMgcGFydCBpbiBhcyB3ZWxsLCB3ZQo+Pj4gc2hvdWxkIG5vdCBjYXJyeSBk
ZWFkIGNvZGUgbGlrZSB0aGlzIGluIHRoZSBrZXJuZWwgYW5kIGluIHRoZSB1YXBpLgo+Pj4KPj4+
IEl0IGlzIG5vdCBkaXJlY3RseSBpbiB0aGUgd2F5LCBidXQgdGhpcyBuZWVkcyB0byBnZXQgZG9u
ZSBhdCBzb21lCj4+PiBwb2ludCwgSSdkIHJhdGhlciBqdXN0IGdldCBpdCBvdXQgb2YgdGhlIHdh
eS4KPj4gV2UgYXJlIHVzaW5nIHRoaXMgaW50ZXJmYWNlIGZvciBuZXN0ZWQgbW9kZS4KPiBIb3cg
YXJlIHlvdSB1c2luZyBpdD8gSXQgZG9lc24ndCBkbyBhbnl0aGluZy4gRG8geW91IGhhdmUgb3V0
IG9mIHRyZWUKPiBwYXRjaGVzIGFzIHdlbGw/CgpZZXMsIHRoZXJlIGFyZSBzb21lIHBhdGNoZXMg
b3V0IG9mIHRyZWUsIHNpbmNlIHRoZXkgYXJlIHBlbmRpbmcgZm9yIAphbG1vc3Qgb25lIHllYXIu
CgpCeSB0aGUgd2F5LCBJIGFtIHRyeWluZyB0byB0ZXN0IG5lc3RpbmcgbW9kZSBiYXNlZCBvbiBp
b21tdWZkLCBzdGlsbCAKcmVxdWlyZXMgaW9tbXVfZW5hYmxlX25lc3RpbmcsCndoaWNoIGlzIHJl
bW92ZWQgaW4gdGhpcyBwYXRjaCBhcyB3ZWxsLgoKU28gY2FuIHdlIHdhaXQgZm9yIGFsdGVybmF0
aXZlIHBhdGNoIHRoZW4gcmVtb3ZlIHRoZW0/CgpUaGFua3MKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
