Return-Path: <SRS0=LARK=EF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1262C00A89
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 10:18:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B34622202
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 10:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xNIZ8cVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B34622202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A67278737C;
	Fri, 30 Oct 2020 10:18:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cR7ztoXm4v95; Fri, 30 Oct 2020 10:18:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CE9558736A;
	Fri, 30 Oct 2020 10:18:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A58BCC088B;
	Fri, 30 Oct 2020 10:18:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C047C0051
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 10:18:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6FE5285374
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 10:18:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jLOzCayh675j for <iommu@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 10:18:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E95218528B
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 10:18:49 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id v5so2337996wmh.1
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 03:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=9QnPAe/9TEZoI6Lq3d/QkgDd9m9jvfSBzhcmPvWbSw4=;
 b=xNIZ8cVBFbQ6bdjtq0Hmby0tUGqrogQ55WzB1NVugGBAxs6/uT7n7bTbHZG26skP/6
 vlBkhqQR3eH1Jh1mHIOKSojs8X8EfyS4S5Ck3WuvfBx1L89a7KWXB1WgMOpYcxRRC805
 I8j5s11o2aY3ulzx31MvrsaxIp5/9ov5SiZtTelhDB/pbex1AhTA5GLWYI5Z0McJChPO
 6MSvuxHNMhRWEGuowKnaPUgqPITviOE1D8Qtsg/3XDpv4nDGSkZ1i1Rw2Eg5Ycwrc1IC
 nZKvLRX+YDV7cPfrsoulWOqh6TJHwmx7YwkkL5kkvarpIlary1jzpnkRuyFGG4A0wPnn
 7PRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=9QnPAe/9TEZoI6Lq3d/QkgDd9m9jvfSBzhcmPvWbSw4=;
 b=gihYbbVt7fLURXBehmwAKPtKpEScPW/ZU/YtY2wCV1I9lPJjFAYGZiCIX1JJI6d82A
 4/ZLCJR/ngq5tODpF3g5Ln061QcYumbq7Jxko+B/MoSFsUJXRTKkCtOKfPCvkl4N9lpO
 YUPzKxeEVEXXhn10H7oN6Xh6QjtFlLrBB3UW5FFuCECe37KeUhGwVFCL2cyIfnMriFBw
 rARBVzZqqwwTqmLPyt9svNHXpp7FbeYEdpvkuK7Uq/nwXNlYH6Oou3LaCDNgdTroVvm6
 IV3BRon21SdgSOJKnPqD0jTxZS8Sz4re5ulUxE68RylHhCKBSoFhnJhVpAkARfEUQebs
 V+Uw==
X-Gm-Message-State: AOAM5339xBuNovuap8PKFi2dkcsFWegLMuA/oBltHNZ1tlw1CFbc/yRG
 zXPCAJ6+m2hTOq7sOmE3bk60Bw==
X-Google-Smtp-Source: ABdhPJzmWJXNv2J4SwRd2WDFh46KarNhPjy8eGcF6DQVOctpW3uaD4eXLFO5VUk+d7zrIy//n4cEUA==
X-Received: by 2002:a1c:1d51:: with SMTP id d78mr1755124wmd.60.1604053128250; 
 Fri, 30 Oct 2020 03:18:48 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id r28sm10482662wrr.81.2020.10.30.03.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 03:18:47 -0700 (PDT)
Date: Fri, 30 Oct 2020 11:18:27 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v3 01/14] docs: Document IO Address Space ID (IOASID) APIs
Message-ID: <20201030101827.GB122147@myrica>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1601329121-36979-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20201020135809.GA1515830@myrica>
 <20201026140506.1349dbb5@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201026140506.1349dbb5@jacob-builder>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.pan.linux@gmail.com>,
 Raj Ashok <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-api@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 linux-doc@vger.kernel.org, iommu@lists.linux-foundation.org,
 LKML <linux-kernel@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Dave Jiang <dave.jiang@intel.com>, Wu Hao <hao.wu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Yi Sun <yi.y.sun@intel.com>
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

T24gTW9uLCBPY3QgMjYsIDIwMjAgYXQgMDI6MDU6MDZQTSAtMDcwMCwgSmFjb2IgUGFuIHdyb3Rl
Ogo+ID4gVGhpcyBsb29rcyBnb29kIHRvIG1lLCB3aXRoIHNtYWxsIGNvbW1lbnRzIGJlbG93Lgo+
ID4gCj4gQ2FuIEkgYWRkIHlvdXIgUmV2aWV3ZWQtYnkgdGFnIGFmdGVyIGFkZHJlc3NpbmcgdGhl
IGNvbW1lbnRzPwoKWWVzIHN1cmUsIHRoaXMgdG9vayBmb3JldmVyIHRvIHJldmlldyBzbyBJJ20g
aGFwcHkgbm90IHRvIGRvIGFub3RoZXIgcGFzcyA6KQoKCj4gPiA+ICtFYWNoIElPQVNJRCBzZXQg
aXMgY3JlYXRlZCB3aXRoIGEgdG9rZW4sIHdoaWNoIGNhbiBiZSBvbmUgb2YgdGhlCj4gPiA+ICtm
b2xsb3dpbmcgdG9rZW4gdHlwZXM6Cj4gPiA+ICsKPiA+ID4gKyAtIElPQVNJRF9TRVRfVFlQRV9O
VUxMIChBcmJpdHJhcnkgdTY0IHZhbHVlKSAgCj4gPiAKPiA+IE1heWJlIE5VTEwgaXNuJ3QgdGhl
IGJlc3QgbmFtZSB0aGVuLiBOT05FPwo+ID4gCj4gQWdyZWVkLCAnTk9ORScgbWFrZXMgbW9yZSBz
ZW5zZS4KCkFsdGhvdWdoIHBhdGNoIDUgb25seSBhbGxvd3MgYSBOVUxMIHRva2VuIGZvciB0aGlz
IHR5cGUuIFNvIHRoZSBuYW1lIHNlZW1zCmZpbmUsIHlvdSBjb3VsZCBqdXN0IGZpeCB0aGlzIGRl
c2NyaXB0aW9uLgoKCj4gPiA+ICtJT0FTSUQgY29yZSBoYXMgdGhlIG5vdGlvbiBvZiAiY3VzdG9t
IGFsbG9jYXRvciIgc3VjaCB0aGF0IGd1ZXN0IGNhbgo+ID4gPiArcmVnaXN0ZXIgdmlydHVhbCBj
b21tYW5kIGFsbG9jYXRvciB0aGF0IHByZWNlZGVzIHRoZSBkZWZhdWx0IG9uZS4gIAo+ID4gCj4g
PiAiU3VwZXJzZWRlcyIsIHJhdGhlciB0aGFuICJwcmVjZWRlcyI/Cj4gPiAKPiBNeSB1bmRlcnN0
YW5kaW5nIGlzIHRoYXQgJ3N1cGVyc2VkZScgbWVhbnMgcmVwbGFjZSBzb21ldGhpbmcgYnV0ICdw
cmVjZWRlJwo+IG1lYW5zIGdldCBpbiBmcm9udCBvZiBzb21ldGhpbmcuIEkgZG8gd2FudCB0byBl
bXBoYXNpcyB0aGF0IHRoZSBjdXN0b20KPiBhbGxvY2F0b3IgdGFrZXMgcHJlY2VkZW5jZSBvdmVy
IHRoZSBkZWZhdWx0IGFsbG9jYXRvci4KClJpZ2h0IGl0J3MgYW1iaWd1b3VzLiBUaGUgY3VzdG9t
IGFsbG9jYXRvciBkb2VzIGVudGlyZWx5IHJlcGxhY2UgdGhlCmFsbG9jYXRpb24gYWN0aW9uLCBi
dXQgdGhlIGRlZmF1bHQgb25lIGlzIHN0aWxsIHVzZWQgZm9yIHN0b3JhZ2UuIEFueXdheSwKeW91
IGNhbiBsZWF2ZSB0aGlzLgoKCj4gPiA+ICtMZXQncyBleGFtaW5lIHRoZSBJT0FTSUQgbGlmZSBj
eWNsZSBhZ2FpbiB3aGVuIGZyZWUgaGFwcGVucyAqYmVmb3JlKgo+ID4gPiArdW5iaW5kLiBUaGlz
IGNvdWxkIGJlIGEgcmVzdWx0IG9mIG1pc2JlaGF2aW5nIGd1ZXN0cyBvciBjcmFzaC4gQXNzdW1p
bmcKPiA+ID4gK1ZGSU8gY2Fubm90IGVuZm9yY2UgdW5iaW5kLT5mcmVlIG9yZGVyLiBOb3RpY2Ug
dGhhdCB0aGUgc2V0dXAgcGFydCB1cAo+ID4gPiArdW50aWwgc3RlcCAjMTIgaXMgaWRlbnRpY2Fs
IHRvIHRoZSBub3JtYWwgY2FzZSwgdGhlIGZsb3cgYmVsb3cgc3RhcnRzCj4gPiA+ICt3aXRoIHN0
ZXAgMTMuCj4gPiA+ICsKPiA+ID4gKzo6Cj4gPiA+ICsKPiA+ID4gKyAgICAgVkZJTyAgICAgICAg
SU9NTVUgICAgICAgIEtWTSAgICAgICAgVkRDTSAgICAgICAgSU9BU0lEICAgICAgIFJlZgo+ID4g
PiArICAgLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uCj4gPiA+ICsgICAxMyAtLS0tLS0tLSBHVUVTVCBTVEFSVFMgRE1BIC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gPiA+ICsgICAxNCAtLS0tLS0tLSAqR1VFU1QgTUlT
QkVIQVZFUyEhISogLS0tLS0tLS0tLS0tLS0tLQo+ID4gPiArICAgMTUgaW9hc2lkX2ZyZWUoKQo+
ID4gPiArICAgMTYgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBp
b2FzaWRfbm90aWZ5KEZSRUUpCj4gPiA+ICsgICAxNyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIG1hcmtfZnJlZV9wZW5kaW5nCj4gPiA+ICgxKSAgCj4gPiAKPiA+
IENvdWxkIHdlIHVzZSBzdXBlcnNjcmlwdCDCucKywrPigbQgZm9yIGZvb3Rub3Rlcz8gVGhlc2Ug
bG9vayBsaWtlIGZ1bmN0aW9uCj4gPiBwYXJhbWV0ZXJzCj4gPiAKPiB5ZXMsIG11Y2ggYmV0dGVy
Cj4gCj4gPiA+ICsgICAxOCAgICAgICAgICAgICAgICAgICAgICAgICAga3ZtX25iX2hhbmRsZXIo
RlJFRSkKPiA+ID4gKyAgIDE5ICAgICAgICAgICAgICAgICAgICAgICAgICB2bWNzX3VwZGF0ZV9h
dG9taWMoKQo+ID4gPiArICAgMjAgICAgICAgICAgICAgICAgICAgICAgICAgIGlvYXNpZF9wdXRf
bG9ja2VkKCkgICAtPiAgICAgICAgICAgMwo+ID4gPiArICAgMjEgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHZkY21fbmJfaGFuZGxlcihGUkVFKQo+ID4gPiArICAgMjIgICAgICAg
ICAgICBpb21tX25iX2hhbmRsZXIoRlJFRSkgIAo+ID4gCj4gPiBpb21tdV9uYl9oYW5kbGVyCj4g
PiAKPiBnb3QgaXQKPiAKPiA+ID4gKyAgIDIzIGlvYXNpZF9mcmVlKCkgcmV0dXJucygyKSAgICAg
ICAgICBzY2hlZHVsZV93b3JrKCkgICAgICAgICAgIDIgIAo+ID4gCj4gPiBJIGNvbXBsZXRlbHkg
bG9zdCB0cmFjayBoZXJlLCBjb3VsZG4ndCBmaWd1cmUgb3V0IGluIHdoaWNoIGRpcmVjdGlvbiB0
bwo+ID4gcmVhZCB0aGUgZGlhZ3JhbS4gV2hhdCB3b3JrIGlzIHNjaGVkdWxlZD8KPiBUaGUgdGlt
ZSBsaW5lIGdvZXMgZG93bndhcmQgYnV0IHdlIG9ubHkgY29udHJvbCB0aGUgbm90aWZpY2F0aW9u
IG9yZGVyIGluCj4gdGVybXMgb2Ygd2hlbiB0aGUgZXZlbnRzIGFyZSByZWNlaXZlZC4gU29tZSBj
b21wbGV0aW9ucyBhcmUgYXN5bmMgdGh1cyBvdXQKPiBvZiBvcmRlciBkb25lIGJ5IHdvcmsgaXRl
bXMuIFRoZSBvbmx5IGluLW9yZGVyIGNvbXBsZXRpb24gaXMgdGhlIEtWTSB1cGRhdGUKPiBvZiBp
dHMgUEFTSUQgdHJhbnNsYXRpb24gdGFibGUuCj4gCj4gQWZ0ZXIgIzIzLCB0aGUgYXN5bmMgd29y
a3MgYXJlIHNjaGVkdWxlZCB0byBjb21wbGV0ZSBjbGVhbiB1cCB3b3JrIG91dHNpZGUKPiB0aGUg
c3BpbmxvY2soaGVsZCBieSB0aGUgY2FsbGVyIG9mIHRoZSBhdG9taWMgbm90aWZpZXIpLgo+IAo+
IEFueSBzdWdnZXN0aW9ucyB0byBpbXByb3ZlIHRoZSByZWFkYWJpbGl0eSBvZiB0aGUgdGltZSBs
aW5lPwoKTWF5YmUgZXhwbGFpbiB3aGF0IGhhcHBlbnMgZnJvbSBsaW5lIDIzOiBpb2FzaWRfZnJl
ZSgpIHNjaGVkdWxlcy4uLiBhIEZSRUUKbm90aWZpY2F0aW9uPyBXaGljaCBoYXBwZW5zIG9uIGxp
bmUgMjQgKGNvcnJlc3BvbmRpbmcgdG8gdGhlIHNlY29uZApzY2hlZHVsZV93b3JrKCk/KSBhbmQg
aXMgaGFuZGxlZCBieSAoYSkgVkRDTSB0byBjbGVhciB0aGUgZGV2aWNlIGNvbnRleHQKYW5kIChi
KSBJT01NVSB0byBjbGVhciB0aGUgUEFTSUQgY29udGV4dCwgYm90aCBlbmRpbmcgdXAgZHJvcHBp
bmcgdGhlaXIKcmVmLgoKPiAKPiA+IFdoeSBkb2VzIHRoZSBJT01NVSBkcml2ZXIgZHJvcAo+ID4g
aXRzIHJlZmVyZW5jZSB0byB0aGUgSU9BU0lEIGJlZm9yZSB1bmJkaW5kX2dwYXNpZCgpPwo+ID4g
Cj4gVGhpcyBpcyB0aGUgZXhjZXB0aW9uIGNhc2Ugd2hlcmUgdXNlcnNwYWNlIGlzc3VlcyBJT0FT
SUQgZnJlZSBiZWZvcmUKPiB1bmJpbmRfZ3Bhc2lkKCkuIFRoZSBlcXVpdmFsZW50IG9mIHVuYmlu
ZCBpcyBwZXJmb3JtZWQgaW4gdGhlIElPQVNJRF9GUkVFCj4gbm90aWZpY2F0aW9uIGhhbmRsZXIu
IEluIElPQVNJRF9GUkVFIGhhbmRsZXIsIHJlZmVyZW5jZSBpcyBkcm9wcGVkIGFuZAo+IHByaXZh
dGUgZGF0YSBkZWxldGVkLiBBZnRlciB0aGF0LCBpZiB1bmJpbmQgY29tZXMgdG8gSU9NTVUgZHJp
dmVyLCBpdCB3aWxsCj4gbm90IGZpbmQgSU9BU0lEIHByaXZhdGUgZGF0YSB0aGVyZWZvcmUganVz
dCByZXR1cm4uCgpSaWdodCBvay4gQXMgeW91IG5vdGVkIGJlbG93IHRoZSBkYW1hZ2UgaXMgY2F1
c2VkIGJ5IGFuZCBsaW1pdGVkIHRvIHRoZQpndWVzdCwgc28gSSB0aGluayBpdCdzIGZpbmUuCgo+
IAo+ID4gPiArICAgMjQgICAgICAgICAgICBzY2hlZHVsZV93b3JrKCkgICAgICAgIHZkZXZfY2xl
YXJfd2soaHBhc2lkKQo+ID4gPiArICAgMjUgICAgICAgICAgICB0ZWFyZG93bl9wYXNpZF93aygp
Cj4gPiA+ICsgICAyNiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW9hc2lkX3B1
dCgpIC0+ICAgICAgICAgICAxCj4gPiA+ICsgICAyNyAgICAgICAgICAgIGlvYXNpZF9wdXQoKSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwCj4gPiA+ICsgICAyOCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSZWNsYWltZWQKPiA+ID4g
KyAgIDI5IHVuYmluZF9ncGFzaWQoKQo+ID4gPiArICAgMzAgICAgICAgICAgICBpb21tdV91bmJp
bmQoKS0+aW9hc2lkX2ZpbmQoKSBGYWlscygzKQo+ID4gPiArICAgLS0tLS0tLS0tLS0tLS0gTmV3
IExpZmUgQ3ljbGUgQmVnaW4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ID4gPiArCj4g
PiA+ICtOb3RlOgo+ID4gPiArCj4gPiA+ICsxLiBCeSBtYXJraW5nIElPQVNJRCBGUkVFX1BFTkRJ
TkcgYXQgc3RlcCAjMTcsIG5vIG5ldyByZWZlcmVuY2VzIGNhbiBiZQo+ID4gPiArICAgaGVsZC4g
aW9hc2lkX2dldC9maW5kKCkgd2lsbCByZXR1cm4gLUVOT0VOVDsgIAo+ID4gCj4gPiBzL2hlbGQv
dGFrZW4KPiA+IAo+IEdvdCBpdC4KPiAKPiA+IFRoYW5rcywKPiA+IEplYW4KPiA+IAo+ID4gPiAr
Mi4gQWZ0ZXIgc3RlcCAjMjMsIGFsbCBldmVudHMgY2FuIGdvIG91dCBvZiBvcmRlci4gU2hhbGwg
bm90IGFmZmVjdAo+ID4gPiArICAgdGhlIG91dGNvbWUuCj4gPiA+ICszLiBJT01NVSBkcml2ZXIg
ZmFpbHMgdG8gZmluZCBwcml2YXRlIGRhdGEgZm9yIHVuYmluZGluZy4gSWYgdW5iaW5kIGlzCj4g
PiA+ICsgICBjYWxsZWQgYWZ0ZXIgdGhlIHNhbWUgSU9BU0lEIGlzIGFsbG9jYXRlZCBmb3IgdGhl
IHNhbWUgZ3Vlc3QgYWdhaW4sCj4gPiA+ICsgICB0aGlzIGlzIGEgcHJvZ3JhbW1pbmcgZXJyb3Iu
IFRoZSBkYW1hZ2UgaXMgbGltaXRlZCB0byB0aGUgZ3Vlc3QKPiA+ID4gKyAgIGl0c2VsZiBzaW5j
ZSB1bmJpbmQgcGVyZm9ybXMgcGVybWlzc2lvbiBjaGVja2luZyBiYXNlZCBvbiB0aGUKPiA+ID4g
KyAgIElPQVNJRCBzZXQgYXNzb2NpYXRlZCB3aXRoIHRoZSBndWVzdCBwcm9jZXNzLgoKImd1ZXN0
IHByb2Nlc3MiIGNhbiBiZSBjb25mdXNpbmcgKHByb2Nlc3MgcnVuIGJ5IHRoZSBndWVzdD8pLCBq
dXN0ICJndWVzdCIKbWlnaHQgYmUgYmV0dGVyLgoKVGhhbmtzLApKZWFuCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
