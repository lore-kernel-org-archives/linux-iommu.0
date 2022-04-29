Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E60C433F5
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 01:39:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1290161172;
	Fri, 29 Apr 2022 01:39:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PpEg8Oqzb_3D; Fri, 29 Apr 2022 01:39:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9C8FA60746;
	Fri, 29 Apr 2022 01:39:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3BDCEC0039;
	Fri, 29 Apr 2022 01:39:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0994FC002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 01:39:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E484E40C89
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 01:39:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DWKP4zuY-wV8 for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 01:39:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 03AFC405EB
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 01:39:21 +0000 (UTC)
Received: by mail-pg1-x532.google.com with SMTP id k14so5429746pga.0
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 18:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=rhA4aZUdRaNgOqnDVV3QzhoT8n++/dGWzUM62LHJQpE=;
 b=YpVVxkFOvaBfZTwyNXGDo+Gr0q/zc/izFhnZ0kSp0xp8DXzHB1Vhz7HEg5yEGk9Lup
 YqVJ4Jji5VQN5ToQuduIiSWpyfgRp6q35jcBRVqCZY3MH2VDrToKXurUtMP4CYo+4RYp
 tClatmIUqEuTphALX0jOQfN2TYYniHEJgKhchMNvxSVy/i8/gaRrMRVsXsm2pKmFYLWm
 fEUru6dQJKSiDwjpDi2qICmSJQVmhUptUFoTMpv7QIYHzgiIGIiOJESnm0N2ZmWP3Q7U
 x9ZXWGbJYbb/xEYE+LAaSN88EKwKXGtQ94UV5TszGa4g/ZGZzb1+wInB5Ik/W5FmGjqS
 rluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=rhA4aZUdRaNgOqnDVV3QzhoT8n++/dGWzUM62LHJQpE=;
 b=cEeBnY0ZTBW6AXvLTVEIBncT3s9x0tj8edNjH0VC2QLPK9XtI7tHKSN79j9BqUrLIf
 x2IuZMK09zsIghuBJGwjUf9NNQrWOyJiM1/rQp9COIG5ZZD6f3VeJg4/83EI1+lniMRF
 zuC1YUQsYV1U5SQFMeDWxhXKSOhq4QV2g00q/OWWM1D02Xn4oHNX2DjB0/Q2Y1G/MRhR
 rwm+HiY9iXV/ybNFVbPc9YCuwR/iIiuIQWN1imm7CQRhWLbpc7Cd3RkoDzTEfTtOi7zO
 xLAVRWHd5g96whpqTEjmtn2Bj/cwq8m1lkIchxR+anHd2klySGDkdFULuvmK1Qik3YPB
 tT9g==
X-Gm-Message-State: AOAM530FIm9OQQqcZ3HAkcIWJRF8woO6Wx2pD2u9zLFvfJpDJB34bYsG
 adiawlTdJwErWkCzwMc0XZfsV3u27n6yQw==
X-Google-Smtp-Source: ABdhPJyfoFDrOX4ugPpi20iiVdqc3EOn/QLxfQF3709bk7teLh0JelkDjqJXiA+CEkYSux7mQuRHXw==
X-Received: by 2002:a63:d145:0:b0:3c1:4ba0:d890 with SMTP id
 c5-20020a63d145000000b003c14ba0d890mr8385077pgj.607.1651196361096; 
 Thu, 28 Apr 2022 18:39:21 -0700 (PDT)
Received: from [10.52.0.6] ([94.177.118.121]) by smtp.gmail.com with ESMTPSA id
 k17-20020a628e11000000b0050d8d373331sm1021922pfe.214.2022.04.28.18.39.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Apr 2022 18:39:20 -0700 (PDT)
Subject: Re: [PATCH v2] iommu/sva: Fix PASID use-after-free issue
To: Fenghua Yu <fenghua.yu@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Tony Luck <tony.luck@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org
References: <20220428180041.806809-1-fenghua.yu@intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <8f50c673-fe92-3c42-993d-43e65fc7235c@linaro.org>
Date: Fri, 29 Apr 2022 09:39:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220428180041.806809-1-fenghua.yu@intel.com>
Content-Language: en-US
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

CgpPbiAyMDIyLzQvMjkg5LiK5Y2IMjowMCwgRmVuZ2h1YSBZdSB3cm90ZToKPiBUaGUgUEFTSUQg
aXMgYmVpbmcgZnJlZWQgdG9vIGVhcmx5LiAgSXQgbmVlZHMgdG8gc3RheSBhcm91bmQgdW50aWwg
YWZ0ZXIKPiBkZXZpY2UgZHJpdmVycyB0aGF0IG1pZ2h0IGJlIHVzaW5nIGl0IGhhdmUgaGFkIGEg
Y2hhbmNlIHRvIGNsZWFyIGl0IG91dAo+IG9mIHRoZSBoYXJkd2FyZS4KPgo+IEFzIGEgcmVtaW5k
ZXI6Cj4KPiBtbWdldCgpIC9tbXB1dCgpICByZWZjb3VudCB0aGUgbW0ncyBhZGRyZXNzIHNwYWNl
Cj4gbW1ncmFiKCkvbW1kcm9wKCkgcmVmY291bnQgdGhlIG1tIGl0c2VsZgo+Cj4gVGhlIFBBU0lE
IGlzIGN1cnJlbnRseSB0aWVkIHRvIHRoZSBsaWZlIG9mIHRoZSBtbSdzIGFkZHJlc3Mgc3BhY2Ug
YW5kCj4gZnJlZWQgaW4gX19tbXB1dCgpLiAgVGhpcyBtYWtlcyBsb2dpY2FsIHNlbnNlIGJlY2F1
c2UgdGhlIFBBU0lEIGNhbid0IGJlCj4gdXNlZCBvbmNlIHRoZSBhZGRyZXNzIHNwYWNlIGlzIGdv
bmUuCj4KPiBCdXQsIHRoaXMgbWlzc2VzIGFuIGltcG9ydGFudCBwb2ludDogZXZlbiBhZnRlciB0
aGUgYWRkcmVzcyBzcGFjZSBpcwo+IGdvbmUsIHRoZSBQQVNJRCB3aWxsIHN0aWxsIGJlIHByb2dy
YW1tZWQgaW50byBhIGRldmljZS4gIERldmljZSBkcml2ZXJzCj4gbWlnaHQsIGZvciBpbnN0YW5j
ZSwgc3RpbGwgbmVlZCB0byBmbHVzaCBvcGVyYXRpb25zIHRoYXQgYXJlIG91dHN0YW5kaW5nCj4g
YW5kIG5lZWQgdG8gdXNlIHRoYXQgUEFTSUQuICBUaGV5IGRvIHRoaXMgYXQgZmlsZS0+cmVsZWFz
ZSgpIHRpbWUuCj4KPiBEZXZpY2UgZHJpdmVycyBjYWxsIHRoZSBJT01NVSBkcml2ZXIgdG8gaG9s
ZCBhIHJlZmVyZW5jZSBvbiB0aGUgbW0gaXRzZWxmCj4gYW5kIGRyb3AgaXQgYXQgZmlsZS0+cmVs
ZWFzZSgpIHRpbWUuICBCdXQsIHRoZSBJT01NVSBkcml2ZXIgaG9sZHMgYQo+IHJlZmVyZW5jZSBv
biB0aGUgbW0gaXRzZWxmLCBub3QgdGhlIGFkZHJlc3Mgc3BhY2UuICBUaGUgYWRkcmVzcyBzcGFj
ZQo+IChhbmQgdGhlIFBBU0lEKSBpcyBsb25nIGdvbmUgYnkgdGhlIHRpbWUgdGhlIGRyaXZlciB0
cmllcyB0byBjbGVhbiB1cC4KPiBUaGlzIGlzIGVmZmVjdGl2ZWx5IGEgdXNlLWFmdGVyLWZyZWUg
YnVnIG9uIHRoZSBQQVNJRC4KPgo+IFRvIGZpeCB0aGlzLCBtb3ZlIHRoZSBQQVNJRCBmcmVlIG9w
ZXJhdGlvbiBmcm9tIF9fbW1wdXQoKSB0byBfX21tZHJvcCgpLgo+IFRoaXMgZW5zdXJlcyB0aGF0
IHRoZSBJT01NVSBkcml2ZXIncyBleGlzdGluZyBtbWdyYWIoKSBrZWVwcyB0aGUgUEFTSUQKPiBh
bGxvY2F0ZWQgdW50aWwgaXQgZHJvcHMgaXRzIG1tIHJlZmVyZW5jZS4KPgo+IEZpeGVzOiA3MDFm
YWM0MDM4NGYgKCJpb21tdS9zdmE6IEFzc2lnbiBhIFBBU0lEIHRvIG1tIG9uIFBBU0lEIGFsbG9j
YXRpb24gYW5kIGZyZWUgaXQgb24gbW0gZXhpdCIpCj4KPiBSZXBvcnRlZC1ieTogWmhhbmdmZWkg
R2FvIDx6aGFuZ2ZlaS5nYW9AZm94bWFpbC5jb20+Cj4gVGVzdGVkLWJ5OiBaaGFuZ2ZlaSBHYW8g
PHpoYW5nZmVpLmdhb0Bmb3htYWlsLmNvbT4KClRlc3RlZC1ieTogWmhhbmdmZWkgR2FvIDx6aGFu
Z2ZlaS5nYW9AbGluYXJvLm9yZz4KClVzZSB0aGUgZm9ybWFsIGVtYWlsLCB0aGFua3MKCj4gU3Vn
Z2VzdGVkLWJ5OiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgPGplYW4tcGhpbGlwcGVAbGluYXJvLm9y
Zz4KPiBTdWdnZXN0ZWQtYnk6IEphY29iIFBhbiA8amFjb2IuanVuLnBhbkBsaW51eC5pbnRlbC5j
b20+Cj4gUmV2aWV3ZWQtYnk6IEplYW4tUGhpbGlwcGUgQnJ1Y2tlciA8amVhbi1waGlsaXBwZUBs
aW5hcm8ub3JnPgo+IFNpZ25lZC1vZmYtYnk6IEZlbmdodWEgWXUgPGZlbmdodWEueXVAaW50ZWwu
Y29tPgo+IC0tLQo+Cj4gdjI6Cj4gLSBEYXZlIEhhbnNlbiByZXdyaXRlcyB0aGUgY2hhbmdlIGxv
Zy4KPiAtIEFkZCBUZXN0ZWQtYnk6IFpoYW5nZmVpIEdhbyA8emhhbmdmZWkuZ2FvQGZveG1haWwu
Y29tPgo+IC0gQWRkIFJldmlld2VkLWJ5OiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgPGplYW4tcGhp
bGlwcGVAbGluYXJvLm9yZz4KPgo+IFRoZSBvcmlnaW5hbCBwYXRjaCB3YXMgcG9zdGVkIGFuZCBk
aXNjdXNzZWQgaW46Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9ZbWR6RkZ4N2ZONTg2
amNmQGZ5dTEuc2MuaW50ZWwuY29tLwo+Cj4gICBrZXJuZWwvZm9yay5jIHwgMiArLQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0
IGEva2VybmVsL2ZvcmsuYyBiL2tlcm5lbC9mb3JrLmMKPiBpbmRleCA5Nzk2ODk3NTYwYWIuLjM1
YTNiZWZmMTQwYiAxMDA2NDQKPiAtLS0gYS9rZXJuZWwvZm9yay5jCj4gKysrIGIva2VybmVsL2Zv
cmsuYwo+IEBAIC03OTIsNiArNzkyLDcgQEAgdm9pZCBfX21tZHJvcChzdHJ1Y3QgbW1fc3RydWN0
ICptbSkKPiAgIAltbXVfbm90aWZpZXJfc3Vic2NyaXB0aW9uc19kZXN0cm95KG1tKTsKPiAgIAlj
aGVja19tbShtbSk7Cj4gICAJcHV0X3VzZXJfbnMobW0tPnVzZXJfbnMpOwo+ICsJbW1fcGFzaWRf
ZHJvcChtbSk7Cj4gICAJZnJlZV9tbShtbSk7Cj4gICB9Cj4gICBFWFBPUlRfU1lNQk9MX0dQTChf
X21tZHJvcCk7Cj4gQEAgLTExOTAsNyArMTE5MSw2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBfX21t
cHV0KHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKQo+ICAgCX0KPiAgIAlpZiAobW0tPmJpbmZtdCkKPiAg
IAkJbW9kdWxlX3B1dChtbS0+YmluZm10LT5tb2R1bGUpOwo+IC0JbW1fcGFzaWRfZHJvcChtbSk7
Cj4gICAJbW1kcm9wKG1tKTsKPiAgIH0KPiAgIAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2lvbW11
