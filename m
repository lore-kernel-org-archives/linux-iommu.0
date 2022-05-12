Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA70C433F5
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 12:08:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D1749419E1;
	Thu, 12 May 2022 12:08:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FFAsIMioHeYW; Thu, 12 May 2022 12:07:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 69EF9403A7;
	Thu, 12 May 2022 12:07:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20652C0039;
	Thu, 12 May 2022 12:07:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9C95C002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 12:07:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B16F3403A7
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 12:07:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sdwrviAx6_Gd for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 12:07:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com
 [203.205.221.236])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1D3C4419D9
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 12:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1652357271;
 bh=dvRqU0wbN9ax2HWQ4MC6c/hLOSalaiLIB+fzDwL1SPE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To;
 b=NoIx5rBoLwU51AIHrFDk9TAquSlQ3A65e96UZeV4xd+xl250BFOjau292ECTQa6sR
 coaZKZbB+K7ol3JPmxYxH5aCMaPq5X4fkOSkYTxbzx/WfN5VBs1W6V0vc9hL/3n3L1
 aoMu/1aOcfQdmLKbFXzh/Tq2pWAOdQlIoq9iFCu0=
Received: from [192.168.0.110] ([36.57.146.152])
 by newxmesmtplogicsvrszc11.qq.com (NewEsmtp) with SMTP
 id 1EF2C8BA; Thu, 12 May 2022 20:07:47 +0800
X-QQ-mid: xmsmtpt1652357267t0p6u2g7l
Message-ID: <tencent_D40360903A6274DB4A4DA4A93F2DBC01BA05@qq.com>
X-QQ-XMAILINFO: M3Q/Kj4zjy60jyGphjlxBlNc42jR1kzEgeXF/c/IfnVoScKq/vQHRD1i1TQuMK
 Xlw4K4+66+LtW/VflVJbJHX6U7dwLuyRGsbAOpWRSyKTnsEGX7EXGTYHGl4y+EBbAq8EO8KAH2qs
 IzWL97+MJbN/xliUTNbedQ2wC5gEBY8xIWYQnX6tu9nmTNgs7OOA9aJK1WJvMb39wRocUqaChahF
 1yhDkL18jeUqFnDg3GHTlyxwxXdzTHByfhKD42gLXrrdrvmZHuMAJp372at6U1Ux+LtiywbCx8Im
 Ca18wnKvAQtirFz0i5sGRoj42P5tqVpbgl6PJ3fWEjlgck8lVMFeBIrcG0Hxdoynp2JmPJKA6dZS
 tyuI9KOpnNLcIZ0lFGDI7UbTw5bZ4GIud+OpgUP5yU6/wkhKVhhH6jYt4ker78FtFlFOKFXXhtIW
 5gshaaqD+AU/flN2LF3VhI7U8x6Yajinm9alBpHlyZdGPQVUx6l5cIa4tj+1P5fg3+YtxmftFqD7
 jwLKrNgNPFA5BLFnksic8xbBfL+n/52BBcnmKZJ8/Kd+ZGgCUGje+wNuFu+7y9tkuFkmCtM+Awfb
 ZEsMpESkpillcQK2+/l7nZ+Wx2F3u+2V4MUFUbr0nFzAugLVsDV0DapJZ/anAQWyGZAlQLSj+B3q
 0BMYDPKlt9cMLbTAyELK555T61RAfYJe7pR9nG86Npu/XnFU0uHHWMCKAgdbk0M9fAtDIiOAI58a
 PcBL1pNrlhvEJd1aEmglI/zhrOxVDBkv+JPgrBzDiyP2xjUVlFG3DyDAes0t5Fo2T0iP77/qLT8w
 9TOPUwobgHwrJIAueJC589x6UPvFJkAf+SSdjlFtAlCYDzroD6vBgm32ZXO8DlUI3OEd+cEw4Pel
 HG0yPloY9p36dKhPLR18dSxPJryQxb6ntPgSv1j6bgsFYBmgIee2hRDsSO26CUjf7qqJp7r0BOgr
 L/UCAELp67Lli0Z8UPaviVPsDndooeoETQib+l3d3kCjxBNmKFTvjf7AuPhj4Y3m2FNfCYxdla3v
 NEw/gmfw==
Subject: Re: [PATCH] vfio: Remove VFIO_TYPE1_NESTING_IOMMU
To: Jason Gunthorpe <jgg@nvidia.com>
References: <0-v1-0093c9b0e345+19-vfio_no_nesting_jgg@nvidia.com>
 <0e2f7cb8-f0d9-8209-6bc2-ca87fff57f1f@arm.com>
 <20220510181327.GM49344@nvidia.com>
 <6c6f3ecb-6339-4093-a15a-fcf95a7c61fb@linaro.org>
 <20220512113241.GQ49344@nvidia.com>
 <tencent_64CD1D42838611CFDB6E6A224DF469C10D08@qq.com>
 <20220512115906.GX49344@nvidia.com>
From: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <9ad4bddb-bd5d-9fbe-c2fe-fbfcc9b0b170@foxmail.com>
Date: Thu, 12 May 2022 20:07:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220512115906.GX49344@nvidia.com>
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kvm@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Cornelia Huck <cohuck@redhat.com>,
 iommu@lists.linux-foundation.org, Vivek Kumar Gautam <Vivek.Gautam@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Will Deacon <will@kernel.org>,
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

CgpPbiAyMDIyLzUvMTIg5LiL5Y2INzo1OSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOgo+IE9uIFRo
dSwgTWF5IDEyLCAyMDIyIGF0IDA3OjU3OjI2UE0gKzA4MDAsIHpoYW5nZmVpLmdhb0Bmb3htYWls
LmNvbSB3cm90ZToKPj4KPj4gT24gMjAyMi81LzEyIOS4i+WNiDc6MzIsIEphc29uIEd1bnRob3Jw
ZSB2aWEgaW9tbXUgd3JvdGU6Cj4+PiBPbiBUaHUsIE1heSAxMiwgMjAyMiBhdCAwMzowNzowOVBN
ICswODAwLCBaaGFuZ2ZlaSBHYW8gd3JvdGU6Cj4+Pj4+PiBJIGNhbid0IGhlbHAgZmVlbGluZyBh
IGxpdHRsZSB3YXJ5IGFib3V0IHJlbW92aW5nIHRoaXMgdW50aWwgSU9NTVVGRAo+Pj4+Pj4gY2Fu
IGFjdHVhbGx5IG9mZmVyIGEgZnVuY3Rpb25hbCByZXBsYWNlbWVudCAtIGlzIGl0IGluIHRoZSB3
YXkgb2YKPj4+Pj4+IGFueXRoaW5nIHVwY29taW5nPwo+Pj4+PiAgICBGcm9tIGFuIHVwc3RyZWFt
IHBlcnNwZWN0aXZlIGlmIHNvbWVvbmUgaGFzIGEgcGF0Y2hlZCBrZXJuZWwgdG8KPj4+Pj4gY29t
cGxldGUgdGhlIGZlYXR1cmUsIHRoZW4gdGhleSBjYW4gcGF0Y2ggdGhpcyBwYXJ0IGluIGFzIHdl
bGwsIHdlCj4+Pj4+IHNob3VsZCBub3QgY2FycnkgZGVhZCBjb2RlIGxpa2UgdGhpcyBpbiB0aGUg
a2VybmVsIGFuZCBpbiB0aGUgdWFwaS4KPj4+Pj4KPj4+Pj4gSXQgaXMgbm90IGRpcmVjdGx5IGlu
IHRoZSB3YXksIGJ1dCB0aGlzIG5lZWRzIHRvIGdldCBkb25lIGF0IHNvbWUKPj4+Pj4gcG9pbnQs
IEknZCByYXRoZXIganVzdCBnZXQgaXQgb3V0IG9mIHRoZSB3YXkuCj4+Pj4gV2UgYXJlIHVzaW5n
IHRoaXMgaW50ZXJmYWNlIGZvciBuZXN0ZWQgbW9kZS4KPj4+IEhvdyBhcmUgeW91IHVzaW5nIGl0
PyBJdCBkb2Vzbid0IGRvIGFueXRoaW5nLiBEbyB5b3UgaGF2ZSBvdXQgb2YgdHJlZQo+Pj4gcGF0
Y2hlcyBhcyB3ZWxsPwo+PiBZZXMsIHRoZXJlIGFyZSBzb21lIHBhdGNoZXMgb3V0IG9mIHRyZWUs
IHNpbmNlIHRoZXkgYXJlIHBlbmRpbmcgZm9yIGFsbW9zdAo+PiBvbmUgeWVhci4KPj4KPj4gQnkg
dGhlIHdheSwgSSBhbSB0cnlpbmcgdG8gdGVzdCBuZXN0aW5nIG1vZGUgYmFzZWQgb24gaW9tbXVm
ZCwgc3RpbGwKPj4gcmVxdWlyZXMgaW9tbXVfZW5hYmxlX25lc3RpbmcsCj4+IHdoaWNoIGlzIHJl
bW92ZWQgaW4gdGhpcyBwYXRjaCBhcyB3ZWxsLgo+IFRoaXMgaXMgdGVtcG9yYXJ5Lgo+Cj4+IFNv
IGNhbiB3ZSB3YWl0IGZvciBhbHRlcm5hdGl2ZSBwYXRjaCB0aGVuIHJlbW92ZSB0aGVtPwo+IERv
IHlvdSBzZWUgYSBwcm9ibGVtIHdpdGggcGF0Y2hpbmcgdGhpcyBhbG9uZyB3aXRoIGFsbCB0aGUg
b3RoZXIKPiBwYXRjaGVzIHlvdSBuZWVkPwpOb3QgeWV0LgoKQ3VycmVudGx5IEkgYW0gdXNpbmcg
dHdvIHdvcmthcm91bmRzLCBidXQgaXQgY2FuIHNpbXBseSB3b3JrLgoKMS4gSGFyZCBjb2RlIHRv
IHRvIGVuYWJsZSBuZXN0aW5nIG1vZGUsIGJvdGggaW4ga2VybmVsIGFuZCBxZW11LgpXaWxsIGNv
bnNpZGVyIHRoZW4uCgoyLiBBZGRpbmcgVkZJT0lPQVNId3B0ICpod3B0IGluIFZGSU9JT01NVUZE
Q29udGFpbmVyLgpBbmQgc2F2ZSBod3B0IHdoZW4gdmZpb19kZXZpY2VfYXR0YWNoX2NvbnRhaW5l
ci4KCldoaWxlIGN1cnJlbnRseSBWRklPSU9NTVVGRENvbnRhaW5lciBoYXMgaHdwdF9saXN0IG5v
dy4KSGF2ZSBhc2tlZCBZaSBpbiBhbm90aGVyIG1haWwuCgpUaGFua3MKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
