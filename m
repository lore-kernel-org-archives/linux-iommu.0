Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE42AC433EF
	for <iommu@archiver.kernel.org>; Mon, 21 Mar 2022 11:42:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9D2560EB6;
	Mon, 21 Mar 2022 11:42:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uqbwPD1xOcS6; Mon, 21 Mar 2022 11:42:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 961CE60E9A;
	Mon, 21 Mar 2022 11:42:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79EADC001A;
	Mon, 21 Mar 2022 11:42:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6640C000B
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 11:42:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B484782433
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 11:42:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pB60qj6fXnAc for <iommu@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 11:42:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0AFA081B10
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 11:42:42 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id x34so16308507ede.8
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 04:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=NNPeHmxdF8gHjFiX3QjGS+ywX8wOJltgInHjhtuRslo=;
 b=ifNll0L47nfcmc3hlduk3ET8FSxJenvOrndoBFQg+HkpqT7sDxUJpPs+NGlcKMfYUt
 CfoNb9T0Ht8yDZxbObm33aB8N4f/cU6+ACJEcXelxxhZgcOncbgwe4vRPTFkYww/hBND
 oTw7fhzpqcXstpdMQQPf4NKv2Ox9QWuY3oXyahPE3jF+7XrhyMB47Lx/iMppSrAQ4Zyr
 AFzbtH3qWdCdP3P5FUqbzs6QjINPhngUPbt+8STreA6OrmpWSrjZi4ttgnVoFSRW1pgQ
 z4kyhZF9qvieTrbbmpWHbJoNyrG7oHAqyN9lL+JpCaR53PUIJAsWbDSyQn0EW1uVP7Vi
 iBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=NNPeHmxdF8gHjFiX3QjGS+ywX8wOJltgInHjhtuRslo=;
 b=XRj1twQCr+A2TQkbUk06jSQ+/zNPWFPVD+ewML0tQXufWs0WHL6q0/AfJnkPTcSFI8
 sC0wi419s3mK8lCx2lUFFQYhUZBrSE6OaCgdTdU66g8+AxW1I2tOtPC3HFQGdbZwQXrg
 JnGJH3Zq2LG3NaYqgqmUTcoCx4a8tB5XLAtgj458Hb1OM69xzZ2VQVnzIVwGp7UmURkB
 JrrrKal1BJ5Z70dsGlioBQlZCya7WN7sTNyUrRvsh/3KkS2i19OxosWTgNiD83ZjHN5e
 7GHs2HGP9cavErnGDHLjVI7ONkDdx9vC3vPyYuq5gAV4PhSgAUAJFO5e3k3eAW0EhDss
 bvqA==
X-Gm-Message-State: AOAM532djcJwLKLxpPY+JTMLqZm5BdXBSjs30ROfxQx2AP4nmkr3yWvH
 sWES+YVTtTPK0TfaNVr8b2q/ig==
X-Google-Smtp-Source: ABdhPJwDX4IZxw1gclDOUzGxiWS+Ph3KwDQ4iz4g6W0Am91T/s5bNL6bHCnqaoXVmgmVbFgJGKJNwg==
X-Received: by 2002:a05:6402:5192:b0:415:c6e6:23b with SMTP id
 q18-20020a056402519200b00415c6e6023bmr22681814edd.336.1647862961242; 
 Mon, 21 Mar 2022 04:42:41 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 t22-20020a056402525600b00416cb5fdc56sm7810619edd.57.2022.03.21.04.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Mar 2022 04:42:40 -0700 (PDT)
Date: Mon, 21 Mar 2022 11:42:16 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH RFC 10/11] iommu: Make IOPF handling framework generic
Message-ID: <YjhkmDEGwF4EcM8R@myrica>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-11-baolu.lu@linux.intel.com>
 <BL1PR11MB5271DE11A868204D2E0D5B548C169@BL1PR11MB5271.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BL1PR11MB5271DE11A868204D2E0D5B548C169@BL1PR11MB5271.namprd11.prod.outlook.com>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Will Deacon <will@kernel.org>
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

SGkgS2V2aW4sCgpPbiBNb24sIE1hciAyMSwgMjAyMiBhdCAwODowOTozNkFNICswMDAwLCBUaWFu
LCBLZXZpbiB3cm90ZToKPiA+IEZyb206IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5j
b20+Cj4gPiBTZW50OiBTdW5kYXksIE1hcmNoIDIwLCAyMDIyIDI6NDAgUE0KPiA+IAo+ID4gVGhl
IGV4aXN0aW5nIElPUEYgaGFuZGxpbmcgZnJhbWV3b3JrIG9ubHkgaGFuZGxlcyB0aGUgSS9PIHBh
Z2UgZmF1bHRzIGZvcgo+ID4gU1ZBLiBHaW52ZW4gdGhhdCB3ZSBhcmUgYWJsZSB0byBsaW5rIGlv
bW11IGRvbWFpbiB3aXRoIGVhY2ggSS9PIHBhZ2UgZmF1bHQsCj4gPiB3ZSBjYW4gbm93IG1ha2Ug
dGhlIEkvTyBwYWdlIGZhdWx0IGhhbmRsaW5nIGZyYW1ld29yayBtb3JlIGdlbmVyYWwgZm9yCj4g
PiBtb3JlIHR5cGVzIG9mIHBhZ2UgZmF1bHRzLgo+IAo+ICJtYWtlIC4uLiBnZW5lcmljIiBpbiBz
dWJqZWN0IGxpbmUgaXMga2luZCBvZiBjb25mdXNpbmcuIFJlYWRpbmcgdGhpcyBwYXRjaCBJCj4g
dGhpbmsgeW91IHJlYWxseSBtZWFudCBjaGFuZ2luZyBmcm9tIHBlci1kZXZpY2UgZmF1bHQgaGFu
ZGxpbmcgdG8gcGVyLWRvbWFpbgo+IGZhdWx0IGhhbmRsaW5nLiBUaGlzIGlzIG1vcmUgYWNjdXJh
dGUgaW4gY29uY2VwdCBzaW5jZSB0aGUgZmF1bHQgaXMgY2F1c2VkIGJ5Cj4gdGhlIGRvbWFpbiBw
YWdlIHRhYmxlLiDwn5iKCgpJIHRlbmQgdG8gZGlzYWdyZWUgd2l0aCB0aGF0IGxhc3QgcGFydC4g
VGhlIGZhdWx0IGlzIGNhdXNlZCBieSBhIHNwZWNpZmljCmRldmljZSBhY2Nlc3Npbmcgc2hhcmVk
IHBhZ2UgdGFibGVzLiBXZSBzaG91bGQga2VlcCB0aGF0IGRldmljZQppbmZvcm1hdGlvbiB0aHJv
dWdob3V0IHRoZSBmYXVsdCBoYW5kbGluZywgc28gdGhhdCB3ZSBjYW4gcmVwb3J0IGl0IHRvIHRo
ZQpkcml2ZXIgd2hlbiB0aGluZ3MgZ28gd3JvbmcuIEEgcHJvY2VzcyBjYW4gaGF2ZSBtdWx0aXBs
ZSB0aHJlYWRzIGJvdW5kIHRvCmRpZmZlcmVudCBkZXZpY2VzLCB0aGV5IHNoYXJlIHRoZSBzYW1l
IG1tIHNvIGlmIHRoZSBkcml2ZXIgd2FudGVkIHRvCnNpZ25hbCBhIG1pc2JlaGF2aW5nIHRocmVh
ZCwgc2ltaWxhcmx5IHRvIGEgU0VHViBvbiB0aGUgQ1BVIHNpZGUsIGl0IHdvdWxkCm5lZWQgdGhl
IGRldmljZSBpbmZvcm1hdGlvbiB0byBwcmVjaXNlbHkgcmVwb3J0IGl0IHRvIHVzZXJzcGFjZS4K
ClRoYW5rcywKSmVhbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
