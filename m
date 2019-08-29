Return-Path: <SRS0=xflu=WZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03650C3A59F
	for <iommu@archiver.kernel.org>; Thu, 29 Aug 2019 13:59:27 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB716215EA
	for <iommu@archiver.kernel.org>; Thu, 29 Aug 2019 13:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCM6HoSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB716215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 17D46457C;
	Thu, 29 Aug 2019 13:59:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5A44D47D1
	for <iommu@lists.linux-foundation.org>;
	Thu, 29 Aug 2019 13:58:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
	[209.85.208.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 89528EC
	for <iommu@lists.linux-foundation.org>;
	Thu, 29 Aug 2019 13:58:26 +0000 (UTC)
Received: by mail-lj1-f195.google.com with SMTP id x3so3146996lji.5
	for <iommu@lists.linux-foundation.org>;
	Thu, 29 Aug 2019 06:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=pXpfC9fVJDCmYksnQ+VHfuPY/W7iUuvQ53sueGC6Na4=;
	b=LCM6HoSz2hrMB3LeCxNEXp1AY1mamuUn8RLdXvD9Tr/2qrjnokLAwAp6SwvrZDEKk1
	hffIKGm3aRPmo8FKD8oqHrASYqAUZtDS1TJNkXDWDemv5AF63k77eEqmTncFz7FG5DDB
	JDKmF7rjguaZJT2u/8c3CxZWft2Qu8PpT0JtmSEkHJHpGP3mDY1G/ILZI/C9z9vFYWjx
	4Ivfdep4607Dqq1DtA6Ngfhrew6BuUWc+9GVu1o8KSOObbwkbZhliu5OMmDF/UpXvLG6
	npfBbuRWhm/u3me8aMkXSqsIUrp3NLX6CcWpe3ZM7UrBga1EGCSZc1O7/ZDQKWI76SRO
	WHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=pXpfC9fVJDCmYksnQ+VHfuPY/W7iUuvQ53sueGC6Na4=;
	b=Utw4M5xetjjuTytDX/5RNkQaVxvYA/BJ5aoVk1B6eJdJOC2Lwov87/SmIDaglZI9st
	cliB4kQgKwHljwVO/Zd4bI9m7iydMyIN0OipOWvc0scGSwHRhmzA/Rk2DOGwmyHa2anF
	IMlB/bFDRYsYepZKDL7Bj/j1+jvBaq1BzMYMBIIFw7bItrh6qRdyk1mvAFfZybHOXOwa
	CjEOgeqs3tw/5nvCEuWWXD6t4jGcI3abcSvZeeZizTZTcJ//f9gpaBj5/VoDSWhli5rH
	Xqcqa8hGzcGPBuT10LgnTDXFhztazAicBMlfGcyv50LGwnKB181fHUbNeNtpiLUscHyv
	3mbQ==
X-Gm-Message-State: APjAAAVp0r/GclY7mrcWAGPvDJ/DV9EwQ6yh5Fws8lRKdQL8OhI+TLat
	5Eq2QvjtLyHznEtk6jYDe9T885Sb
X-Google-Smtp-Source: APXvYqyhU2nYYcl/nKHC9106K7uLheLIAY7mR95TcX2AamAh/vQGuUAipL2F1k86FVP0yJcYYa/PAw==
X-Received: by 2002:a2e:870f:: with SMTP id m15mr5500259lji.223.1567087104736; 
	Thu, 29 Aug 2019 06:58:24 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
	by smtp.googlemail.com with ESMTPSA id
	z3sm365177lji.4.2019.08.29.06.58.23
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 29 Aug 2019 06:58:23 -0700 (PDT)
Subject: Re: [PATCH] media: staging: tegra-vde: Disable building with
	COMPILE_TEST
To: Thierry Reding <thierry.reding@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, YueHaibing <yuehaibing@huawei.com>
References: <20190826133140.13456-1-yuehaibing@huawei.com>
	<7f73bcac-f52d-f1b3-324c-e9b551c5378b@xs4all.nl>
	<20190829124034.GA19842@ulmo>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b048b460-9d58-8e38-e335-f9a3fface559@gmail.com>
Date: Thu, 29 Aug 2019 16:58:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829124034.GA19842@ulmo>
Content-Language: en-US
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
	iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
	mchehab@kernel.org, robin.murphy@arm.com, linux-media@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

MjkuMDguMjAxOSAxNTo0MCwgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPiBPbiBUaHUsIEF1
ZyAyOSwgMjAxOSBhdCAwMTozOTozMlBNICswMjAwLCBIYW5zIFZlcmt1aWwgd3JvdGU6Cj4+IE9u
IDgvMjYvMTkgMzozMSBQTSwgWXVlSGFpYmluZyB3cm90ZToKPj4+IElmIENPTVBJTEVfVEVTVCBp
cyB5IGFuZCBJT01NVV9TVVBQT1JUIGlzIG4sIHNlbGVjdGluZyBURUdSQV9WREUKPj4+IHRvIG0g
d2lsbCBzZXQgSU9NTVVfSU9WQSB0byBtLCB0aGlzIGZhaWxzIHRoZSBidWlsZGluZyBvZgo+Pj4g
VEVHUkFfSE9TVDFYIGFuZCBEUk1fVEVHUkEgd2hpY2ggaXMgeSBsaWtlIHRoaXM6Cj4+Pgo+Pj4g
ZHJpdmVycy9ncHUvaG9zdDF4L2NkbWEubzogSW4gZnVuY3Rpb24gYGhvc3QxeF9jZG1hX2luaXQn
Ogo+Pj4gY2RtYS5jOigudGV4dCsweDY2Yyk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGFsbG9j
X2lvdmEnCj4+PiBjZG1hLmM6KC50ZXh0KzB4Njk4KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBg
X19mcmVlX2lvdmEnCj4+Pgo+Pj4gZHJpdmVycy9ncHUvZHJtL3RlZ3JhL2RybS5vOiBJbiBmdW5j
dGlvbiBgdGVncmFfZHJtX3VubG9hZCc6Cj4+PiBkcm0uYzooLnRleHQrMHhlYjApOiB1bmRlZmlu
ZWQgcmVmZXJlbmNlIHRvIGBwdXRfaW92YV9kb21haW4nCj4+PiBkcm0uYzooLnRleHQrMHhlYjQp
OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBpb3ZhX2NhY2hlX3B1dCcKPj4+Cj4+PiBSZXBvcnRl
ZC1ieTogSHVsayBSb2JvdCA8aHVsa2NpQGh1YXdlaS5jb20+Cj4+PiBGaXhlczogNmIyMjY1OTc1
MjM5ICgibWVkaWE6IHN0YWdpbmc6IHRlZ3JhLXZkZTogRml4IGJ1aWxkIGVycm9yIikKPj4+IEZp
eGVzOiBiMzAxZjhkZTE5MjUgKCJtZWRpYTogc3RhZ2luZzogbWVkaWE6IHRlZ3JhLXZkZTogQWRk
IElPTU1VIHN1cHBvcnQiKQo+Pj4gU2lnbmVkLW9mZi1ieTogWXVlSGFpYmluZyA8eXVlaGFpYmlu
Z0BodWF3ZWkuY29tPgo+Pj4gLS0tCj4+PiAgZHJpdmVycy9zdGFnaW5nL21lZGlhL3RlZ3JhLXZk
ZS9LY29uZmlnIHwgNCArKy0tCj4+PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL21lZGlh
L3RlZ3JhLXZkZS9LY29uZmlnIGIvZHJpdmVycy9zdGFnaW5nL21lZGlhL3RlZ3JhLXZkZS9LY29u
ZmlnCj4+PiBpbmRleCBiYTQ5ZWE1Li5hNDFkMzBjIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9z
dGFnaW5nL21lZGlhL3RlZ3JhLXZkZS9LY29uZmlnCj4+PiArKysgYi9kcml2ZXJzL3N0YWdpbmcv
bWVkaWEvdGVncmEtdmRlL0tjb25maWcKPj4+IEBAIC0xLDkgKzEsOSBAQAo+Pj4gICMgU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKPj4+ICBjb25maWcgVEVHUkFfVkRFCj4+PiAgCXRy
aXN0YXRlICJOVklESUEgVGVncmEgVmlkZW8gRGVjb2RlciBFbmdpbmUgZHJpdmVyIgo+Pj4gLQlk
ZXBlbmRzIG9uIEFSQ0hfVEVHUkEgfHwgQ09NUElMRV9URVNUCj4+PiArCWRlcGVuZHMgb24gQVJD
SF9URUdSQQo+Pgo+PiBXaGF0IGhhcHBlbnMgaWYgeW91IGRyb3AgdGhpcyBjaGFuZ2UsCj4+Cj4+
PiAgCXNlbGVjdCBETUFfU0hBUkVEX0JVRkZFUgo+Pj4gLQlzZWxlY3QgSU9NTVVfSU9WQSBpZiAo
SU9NTVVfU1VQUE9SVCB8fCBDT01QSUxFX1RFU1QpCj4+PiArCXNlbGVjdCBJT01NVV9JT1ZBIGlm
IElPTU1VX1NVUFBPUlQKPj4KPj4gYnV0IGtlZXAgdGhpcyBjaGFuZ2U/Cj4+Cj4+IGlvdmEuaCBo
YXMgc3R1YnMgdGhhdCBhcmUgdXNlZCBpZiBJT01NVV9JT1ZBIGlzIG5vdCBzZXQsIHNvIGl0IHNo
b3VsZAo+PiB3b3JrIHdoZW4gY29tcGlsZSB0ZXN0aW5nIHRoaXMgdGVncmEtdmRlIGRyaXZlci4K
Pj4KPj4gSGF2ZW4ndCB0cmllZCBpdCwgYnV0IG1ha2luZyBzdXJlIHRoYXQgY29tcGlsZSB0ZXN0
aW5nIGtlZXAgd29ya2luZyBpcwo+PiByZWFsbHkgaW1wb3J0YW50LgoKVGhlIGRyaXZlcidzIGNv
ZGUgY29tcGlsYXRpb24gd29ya3Mgb2theSwgaXQncyB0aGUgbGlua2FnZSBzdGFnZSB3aGljaApm
YWlscyBkdXJpbmcgY29tcGlsZS10ZXN0aW5nLgoKPiBZZWFoLCB0aGF0IHZhcmlhbnQgc2VlbXMg
dG8gd29yayBmb3IgbWUuIEkgdGhpbmsgaXQncyBhbHNvIG1vcmUgY29ycmVjdAo+IGJlY2F1c2Ug
dGhlIElPTU1VX0lPVkEgaWYgSU9NTVVfU1VQUE9SVCBkZXBlbmRlbmN5IHJlYWxseSBzYXlzIHRo
YXQgdGhlCj4gSU9WQSB1c2FnZSBpcyBib3VuZCB0byBJT01NVSBzdXBwb3J0LiBJZiBJT01NVSBz
dXBwb3J0IGlzIG5vdCBlbmFibGVkLAo+IHRoZW4gSU9WQSBpcyBub3QgbmVlZGVkIGVpdGhlciwg
c28gdGhlIGR1bW1pZXMgd2lsbCBkbyBqdXN0IGZpbmUuCgpBbSBJIHVuZGVyc3RhbmRpbmcgY29y
cmVjdGx5IHRoYXQgeW91J3JlIHN1Z2dlc3RpbmcgdG8gcmV2ZXJ0IFsxXVsyXSBhbmQKZ2V0IGJh
Y2sgdG8gdGhlIG90aGVyIHByb2JsZW0/CgpbMV0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtbWVkaWEvZGQ1NDdiNDQtN2FiYi0zNzFmLWFlZWUtYTgyYjk2ZjgyNGUyQGdtYWlsLmNvbS9U
LwpbMl0gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wYXRjaC8xMTM2NjE5LwoKSWYgd2Ug
d2FudCB0byBrZWVwIGNvbXBpbGUgdGVzdGluZywgSSBndWVzcyB0aGUgb25seSByZWFzb25hYmxl
IHZhcmlhbnQKcmlnaHQgbm93IGlzIHRvIHNlbGVjdCBJT01NVV9JT1ZBIHVuY29uZGl0aW9uYWxs
eSBpbiBhbGwgb2YgdGhlIGRyaXZlcnMKKHZkZSwgaG9zdDF4LCBkcm0gYW5kIGV0YykgYW5kIHRo
ZW4ganVzdCBpZ25vcmUgdGhhdCBJT1ZBIHdpbGwgYmUKY29tcGlsZWQtYW5kLXVudXNlZCBpZiBJ
T01NVV9TVVBQT1JUPW4gKG5vdGUgdGhhdCBJT01NVV9TVVBQT1JUPXkgaW4gYWxsCm9mIGRlZmF1
bHQga2VybmVsIGNvbmZpZ3VyYXRpb25zKS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2lvbW11
