Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DFCC433F5
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 08:44:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D3F17826FB;
	Thu, 28 Apr 2022 08:44:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o4C2q5Vi66Sv; Thu, 28 Apr 2022 08:44:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A8A2B827DE;
	Thu, 28 Apr 2022 08:44:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BE1DC0039;
	Thu, 28 Apr 2022 08:44:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9EB43C002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 08:43:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7547B4197C
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 08:43:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ruNlSMsEz9dk for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 08:43:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 54DAD41979
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 08:43:58 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id l7so8155163ejn.2
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 01:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=9qK0+yT5ZuvbWECRaZtFlSv9cK0d+SeQzM8xONyxFCQ=;
 b=stS617MSascC+M/L8Vm06gYeVbC9Dv8jmbtIYvajmhdVFUgUEad4GGTmYf86a3gPMc
 gvOLmNgpK1lK1sbsCTVW+4luWQVpIPEg7SfHFaOMpKspPhr3oOl8f7ZSxS8qBr/8ik4F
 8R6JHbL5w1QREHlPS2LLB983z3AxBfJVqSFgcEv1EN0oCFNXy7mtlMt4R0Wh8eJCcxyi
 bZLuzpGQhFw4crbB6XiawB9l9SMUdKbMbECwK4Gvg37enM8206EJ1i4uiIYI9ZYLYbnL
 ldHlrbha0JSRHqDrbR7I1bmgqI1sSEkxELfwb+tRgxVsJ1MNFoFy0Gozo8gNRuRndFwR
 NbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=9qK0+yT5ZuvbWECRaZtFlSv9cK0d+SeQzM8xONyxFCQ=;
 b=mJNpvq7wPZaNVFkTnfXZwQAb0c+nMxv0wtqMILKAO6ZawRbnlHZAr086svQnR/N0lo
 9tSuxnpy/Sgsxln/XvEyE8HLFMs/WdANWUlMpfDhMfGtXzpspw2RWyjIEYntGfmgNL79
 WOosn5QRwoz9/MLfiSyWlOYVdAY2nH/igCINde2msLXx4/fr6wQj3cR8lPTMrvnuU8lX
 x8cR4lzss6GksZ9GQfQFlNgnljlZRYDe2Yqon4dXqKaKphe9wEhI5OjRjikirwaJsWGc
 mo7GYs6cKld9XoE7BK5IEnfAad+UEb0tRUvFBYYEYcxc0m8FUTCLC29OCFQl7g+5UbpU
 sBhQ==
X-Gm-Message-State: AOAM531/uESiRlCSBQa5DBhMkaB5it0tBN3B4Nytf00A4F5ihpp2EJJk
 TZSpndQx6ULFxg8O2EbRJkkY2w==
X-Google-Smtp-Source: ABdhPJzJBVpp2d/wZQwgCg1qkQkqpQYVKtQS90/gVQhiKAu6DHwNEfi97i9sDvJSY3AS5SYynQrv5g==
X-Received: by 2002:a17:906:6a14:b0:6f3:d26d:8923 with SMTP id
 qw20-20020a1709066a1400b006f3d26d8923mr5217702ejc.758.1651135436507; 
 Thu, 28 Apr 2022 01:43:56 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 x24-20020a1709064bd800b006ef606fe5c1sm8070635ejv.43.2022.04.28.01.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 01:43:55 -0700 (PDT)
Date: Thu, 28 Apr 2022 09:43:31 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YmpTsw1xArrtgXaY@myrica>
References: <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica>
 <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica> <20220425083444.00af5674@jacob-builder>
 <YmbIjnHtibY7n4Wb@myrica> <YmdzFFx7fN586jcf@fyu1.sc.intel.com>
 <51514a02-0de9-2f9e-ec0e-c86e147fa74c@linaro.org>
 <Ymnl4S6ukb8kgwaq@fyu1.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ymnl4S6ukb8kgwaq@fyu1.sc.intel.com>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, will@kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu <iommu@lists.linux-foundation.org>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 robin.murphy@arm.com, Ingo Molnar <mingo@redhat.com>
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

T24gV2VkLCBBcHIgMjcsIDIwMjIgYXQgMDU6NTQ6NTdQTSAtMDcwMCwgRmVuZ2h1YSBZdSB3cm90
ZToKPiBIaSwgRGF2ZSBhbmQgSmVhbiwKPiAKPiBPbiBUdWUsIEFwciAyNiwgMjAyMiBhdCAwMTow
NDo0NVBNICswODAwLCBaaGFuZ2ZlaSBHYW8gd3JvdGU6Cj4gPiAKPiA+IAo+ID4gT24gMjAyMi80
LzI2IOS4i+WNiDEyOjIwLCBGZW5naHVhIFl1IHdyb3RlOgo+ID4gPiBIaSwgSmVhbiBhbmQgWmhh
bmdmZWksCj4gPiA+IAo+ID4gPiBPbiBNb24sIEFwciAyNSwgMjAyMiBhdCAwNToxMzowMlBNICsw
MTAwLCBKZWFuLVBoaWxpcHBlIEJydWNrZXIgd3JvdGU6Cj4gPiA+ID4gQ291bGQgd2UgbW92ZSBt
bV9wYXNpZF9kcm9wKCkgdG8gX19tbWRyb3AoKSBpbnN0ZWFkIG9mIF9fbW1wdXQoKT8gIEZvciBB
cm0KPiA+ID4gPiB3ZSBkbyBuZWVkIHRvIGhvbGQgdGhlIG1tX2NvdW50IHVudGlsIHVuYmluZCgp
LCBhbmQgbW1ncmFiKCkvbW1kcm9wKCkgaXMKPiA+ID4gPiBhbHNvIHBhcnQgb2YgTHUncyByZXdv
cmsgWzFdLgo+ID4gPiBJcyB0aGlzIGEgcmlnaHQgZml4IGZvciB0aGUgaXNzdWU/IENvdWxkIHlv
dSBwbGVhc2UgdGVzdCBpdCBvbiBBUk0/Cj4gPiA+IEkgZG9uJ3QgaGF2ZSBhbiBBUk0gbWFjaGlu
ZS4KPiA+ID4gCj4gPiA+IFRoYW5rcy4KPiA+ID4gCj4gPiA+IC1GZW5naHVhCj4gPiA+IAo+ID4g
PiAgRnJvbSA4NGFhNjhmNjE3NDQzOWQ4NjNjNDBjZGMyZGIwZTFiODlkNjIwZGQwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQo+ID4gPiBGcm9tOiBGZW5naHVhIFl1IDxmZW5naHVhLnl1QGludGVs
LmNvbT4KPiA+ID4gRGF0ZTogRnJpLCAxNSBBcHIgMjAyMiAwMDo1MTozMyAtMDcwMAo+ID4gPiBT
dWJqZWN0OiBbUEFUQ0hdIGlvbW11L3N2YTogRml4IFBBU0lEIHVzZS1hZnRlci1mcmVlIGlzc3Vl
Cj4gPiA+IAo+ID4gPiBBIFBBU0lEIG1pZ2h0IGJlIHN0aWxsIHVzZWQgb24gQVJNIGFmdGVyIGl0
IGlzIGZyZWVkIGluIF9fbW1wdXQoKS4KPiA+ID4gCj4gPiA+IHByb2Nlc3M6Cj4gPiA+IAlvcGVu
KCktPnN2YV9iaW5kKCktPmlvYXNpZF9hbGxvYygpID0gTjsgLy8gR2V0IFBBU0lEIE4gZm9yIHRo
ZSBtbQo+ID4gPiAJZXhpdCgpOwo+ID4gPiAJZXhpdF9tbSgpLT5fX21tcHV0KCktPm1tX3Bhc2lk
X2Ryb3AoKS0+bW0tPnBhc2lkID0gLTE7IC8vIFBBU0lEIC0xCj4gPiA+IAlleGl0X2ZpbGVzKCkt
PnJlbGVhc2UoZGV2KS0+c3ZhX3VuYmluZCgpLT51c2UgbW0tPnBhc2lkOyAvLyBGYWlsdXJlCj4g
PiA+IAo+ID4gPiBUbyBhdm9pZCB0aGUgdXNlLWFmdGVyLWZyZWUgaXNzdWUsIGZyZWUgdGhlIFBB
U0lEIGFmdGVyIG5vIGRldmljZSB1c2VzIGl0LAo+ID4gPiBpLmUuIGFmdGVyIGFsbCBkZXZpY2Vz
IGFyZSB1bmJvdW5kIGZyb20gdGhlIG1tLgo+ID4gPiAKPiA+ID4gc3ZhX2JpbmQoKS9zdmFfdW5i
aW5kKCkgY2FsbCBtbWdyYWIoKS9tbWRyb3AoKSB0byB0cmFjayBtbS0+bW1fY291bnQuCj4gPiA+
IF9fbW1kcm9wKCkgaXMgY2FsbGVkIG9ubHkgYWZ0ZXIgbW0tPm1tX2NvdW50IGlzIHplcm8uIFNv
IGZyZWVpbmcgdGhlIFBBU0lECj4gPiA+IGluIF9fbW1kcm9wKCkgZ3VhcmFudGVlcyB0aGUgUEFT
SUQgaXMgc2FmZWx5IGZyZWVkIG9ubHkgYWZ0ZXIgbm8gZGV2aWNlCj4gPiA+IGlzIGJvdW5kIHRv
IHRoZSBtbS4KPiA+ID4gCj4gPiA+IEZpeGVzOiA3MDFmYWM0MDM4NGYgKCJpb21tdS9zdmE6IEFz
c2lnbiBhIFBBU0lEIHRvIG1tIG9uIFBBU0lEIGFsbG9jYXRpb24gYW5kIGZyZWUgaXQgb24gbW0g
ZXhpdCIpCj4gPiA+IAo+ID4gPiBSZXBvcnRlZC1ieTogWmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5n
YW9AZm94bWFpbC5jb20+Cj4gPiA+IFN1Z2dlc3RlZC1ieTogSmVhbi1QaGlsaXBwZSBCcnVja2Vy
IDxqZWFuLXBoaWxpcHBlQGxpbmFyby5vcmc+Cj4gPiA+IFN1Z2dlc3RlZC1ieTogSmFjb2IgUGFu
IDxqYWNvYi5qdW4ucGFuQGxpbnV4LmludGVsLmNvbT4KPiA+ID4gU2lnbmVkLW9mZi1ieTogRmVu
Z2h1YSBZdSA8ZmVuZ2h1YS55dUBpbnRlbC5jb20+Cj4gPiBUaGFua3MgZm9yIHRoZSBmaXguCj4g
PiAKPiA+IFRlc3RlZC1ieTogWmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZz4K
PiA+IAo+ID4gCj4gPiA+IC0tLQo+ID4gPiAgIGtlcm5lbC9mb3JrLmMgfCAyICstCj4gPiA+ICAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gPiA+IAo+ID4g
PiBkaWZmIC0tZ2l0IGEva2VybmVsL2ZvcmsuYyBiL2tlcm5lbC9mb3JrLmMKPiA+ID4gaW5kZXgg
OTc5Njg5NzU2MGFiLi4zNWEzYmVmZjE0MGIgMTAwNjQ0Cj4gPiA+IC0tLSBhL2tlcm5lbC9mb3Jr
LmMKPiA+ID4gKysrIGIva2VybmVsL2ZvcmsuYwo+ID4gPiBAQCAtNzkyLDYgKzc5Miw3IEBAIHZv
aWQgX19tbWRyb3Aoc3RydWN0IG1tX3N0cnVjdCAqbW0pCj4gPiA+ICAgCW1tdV9ub3RpZmllcl9z
dWJzY3JpcHRpb25zX2Rlc3Ryb3kobW0pOwo+ID4gPiAgIAljaGVja19tbShtbSk7Cj4gPiA+ICAg
CXB1dF91c2VyX25zKG1tLT51c2VyX25zKTsKPiA+ID4gKwltbV9wYXNpZF9kcm9wKG1tKTsKPiA+
ID4gICAJZnJlZV9tbShtbSk7Cj4gPiA+ICAgfQo+ID4gPiAgIEVYUE9SVF9TWU1CT0xfR1BMKF9f
bW1kcm9wKTsKPiA+ID4gQEAgLTExOTAsNyArMTE5MSw2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBf
X21tcHV0KHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKQo+ID4gPiAgIAl9Cj4gPiA+ICAgCWlmIChtbS0+
YmluZm10KQo+ID4gPiAgIAkJbW9kdWxlX3B1dChtbS0+YmluZm10LT5tb2R1bGUpOwo+ID4gPiAt
CW1tX3Bhc2lkX2Ryb3AobW0pOwo+ID4gPiAgIAltbWRyb3AobW0pOwo+ID4gPiAgIH0KPiA+IAo+
IAo+IElzIHRoaXMgcGF0Y2ggYSBnb29kIGZpeD8gV2lsbCB5b3UgaGVscCBwdXNoIHRoZSBmaXgg
aW50byB1cHN0cmVhbT8KClllcywgSSB0aGluayBpdCdzIHRoZSByaWdodCB0aGluZyB0byBkbyBm
b3Igbm93LiBDb3VsZCB5b3UgcmVzZW5kIGl0CnNlcGFyYXRlbHkgc28gaXQgZ2V0cyB2aXNpYmls
aXR5IGZyb20gdGhlIG1haW50YWluZXJzPwoKUmV2aWV3ZWQtYnk6IEplYW4tUGhpbGlwcGUgQnJ1
Y2tlciA8amVhbi1waGlsaXBwZUBsaW5hcm8ub3JnPgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
