Return-Path: <SRS0=ishi=27=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FORGED_MUA_MOZILLA,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_MSGID,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A19FC282DD
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 14:51:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 298422072A
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 14:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="julhm7Zo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298422072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E8C5A87583;
	Fri, 10 Jan 2020 14:51:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jGSqMR0CFcA7; Fri, 10 Jan 2020 14:51:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 514CF86214;
	Fri, 10 Jan 2020 14:51:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37D3BC1796;
	Fri, 10 Jan 2020 14:51:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48C41C0881
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 14:51:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3642E86B89
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 14:51:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pAu1jPoHnum8 for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jan 2020 14:51:03 +0000 (UTC)
X-Greylist: delayed 03:21:14 by SQLgrey-1.7.6
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3875D86B87
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 14:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1578667816;
 bh=zd/G0dURGfQwiaKa1elnPODbFqKqJTEluNRTO1QI7g0=;
 h=Subject:To:From:Message-ID:Date:MIME-Version;
 b=julhm7ZouUX4fzbosb6QVTgqSulpvqIZFqt7gUlfm/aq3WzAiOMsl00M8IfzgZjUP
 zOqW5l6jGV0m7W320LeI8mD5yHBiG0vRqQNiuKAI+2UyjwuqQ+VP3YwDB21fGx0d7v
 uYlAWvAxzyCdpe7lY//VT+vs7Ov3Il9AW05SKlJc=
X-QQ-mid: esmtp7t1578667813tpzeoollx
Received: from [192.168.1.13] (unknown [36.57.147.241])
 by esmtp4.qq.com (ESMTP) with 
 id ; Fri, 10 Jan 2020 22:50:10 +0800 (CST)
X-QQ-SSF: B0000000000000M0ZI100000000000K
X-QQ-FEAT: kMeW/vJjv6bpZxLah6YmlZjsisLki+hjySVXMan8reTdOi9xCh6SQhS4Dw+ru
 pIAAtXnqN1w/Nb+7nhhyeEc86yoNFq5smil5gsGUU0MYka+DMYui7N7cJRbtlI+6kDbnJxG
 x1JpwL6f3gWWi6JtLCbdMl7EqOYzvhvaBRXT0/cXnT2dUAf5HbowdyCBrny10QcoVWgy298
 OVn8F+DDwhHYBoPh2r3QO8VAjBDrsw40JcE/M8FJ0e2y0W63cKCX/ct3RgoR7xHHGqx2kEt
 DbDjC2hsO9U6RiPHe+XLkDJFOpsuH3Rn1IFHuiqTXnAoUTO8UPTt9lRIPcTZrnIQGZpbr1Z
 bvaJPo+bF54Ot/0Tm8=
X-QQ-GoodBg: 0
Subject: Re: [PATCH v10 2/4] uacce: add uacce driver
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <1576465697-27946-1-git-send-email-zhangfei.gao@linaro.org>
 <1576465697-27946-3-git-send-email-zhangfei.gao@linaro.org>
 <20200109173819.00003cbf@Huawei.com>
 <8a9b535f-ce48-f991-ecd7-44fdf6ebdfe7@foxmail.com>
 <20200110101049.00004e6d@Huawei.com>
From: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Message-ID: <8ee4fd10-562f-1d1d-f0fc-e30a57b43917@foxmail.com>+8CB3DB5822362E64
Date: Fri, 10 Jan 2020 22:50:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200110101049.00004e6d@Huawei.com>
Content-Language: en-US
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgforeign:bgforeign12
X-QQ-Bgrelay: 1
Cc: jean-philippe <jean-philippe@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 francois.ozog@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 ilias.apalodimas@linaro.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
 grant.likely@arm.com, "haojian . zhuang" <haojian.zhuang@linaro.org>,
 linux-accelerators@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Kenneth Lee <liguozhu@hisilicon.com>,
 guodong.xu@linaro.org, kenneth-lee-2012@foxmail.com
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

CgpPbiAyMDIwLzEvMTAg5LiL5Y2INjoxMCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToKPiBPbiBG
cmksIDEwIEphbiAyMDIwIDE0OjU1OjM5ICswODAwCj4gInpoYW5nZmVpLmdhb0Bmb3htYWlsLmNv
bSIgPHpoYW5nZmVpLmdhb0Bmb3htYWlsLmNvbT4gd3JvdGU6Cj4KPj4gT24gMjAyMC8xLzEwIOS4
iuWNiDE6MzgsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6Cj4+PiBPbiBNb24sIDE2IERlYyAyMDE5
IDExOjA4OjE1ICswODAwCj4+PiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BsaW5hcm8ub3Jn
PiB3cm90ZToKPj4+ICAgCj4+Pj4gRnJvbTogS2VubmV0aCBMZWUgPGxpZ3Vvemh1QGhpc2lsaWNv
bi5jb20+Cj4+Pj4KPj4+PiBVYWNjZSAoVW5pZmllZC9Vc2VyLXNwYWNlLWFjY2Vzcy1pbnRlbmRl
ZCBBY2NlbGVyYXRvciBGcmFtZXdvcmspIHRhcmdldHMgdG8KPj4+PiBwcm92aWRlIFNoYXJlZCBW
aXJ0dWFsIEFkZHJlc3NpbmcgKFNWQSkgYmV0d2VlbiBhY2NlbGVyYXRvcnMgYW5kIHByb2Nlc3Nl
cy4KPj4+PiBTbyBhY2NlbGVyYXRvciBjYW4gYWNjZXNzIGFueSBkYXRhIHN0cnVjdHVyZSBvZiB0
aGUgbWFpbiBjcHUuCj4+Pj4gVGhpcyBkaWZmZXJzIGZyb20gdGhlIGRhdGEgc2hhcmluZyBiZXR3
ZWVuIGNwdSBhbmQgaW8gZGV2aWNlLCB3aGljaCBzaGFyZQo+Pj4+IG9ubHkgZGF0YSBjb250ZW50
IHJhdGhlciB0aGFuIGFkZHJlc3MuCj4+Pj4gU2luY2UgdW5pZmllZCBhZGRyZXNzLCBoYXJkd2Fy
ZSBhbmQgdXNlciBzcGFjZSBvZiBwcm9jZXNzIGNhbiBzaGFyZSB0aGUKPj4+PiBzYW1lIHZpcnR1
YWwgYWRkcmVzcyBpbiB0aGUgY29tbXVuaWNhdGlvbi4KPj4+Pgo+Pj4+IFVhY2NlIGNyZWF0ZSBh
IGNocmRldiBmb3IgZXZlcnkgcmVnaXN0cmF0aW9uLCB0aGUgcXVldWUgaXMgYWxsb2NhdGVkIHRv
Cj4+Pj4gdGhlIHByb2Nlc3Mgd2hlbiB0aGUgY2hyZGV2IGlzIG9wZW5lZC4gVGhlbiB0aGUgcHJv
Y2VzcyBjYW4gYWNjZXNzIHRoZQo+Pj4+IGhhcmR3YXJlIHJlc291cmNlIGJ5IGludGVyYWN0IHdp
dGggdGhlIHF1ZXVlIGZpbGUuIEJ5IG1tYXAgdGhlIHF1ZXVlCj4+Pj4gZmlsZSBzcGFjZSB0byB1
c2VyIHNwYWNlLCB0aGUgcHJvY2VzcyBjYW4gZGlyZWN0bHkgcHV0IHJlcXVlc3RzIHRvIHRoZQo+
Pj4+IGhhcmR3YXJlIHdpdGhvdXQgc3lzY2FsbCB0byB0aGUga2VybmVsIHNwYWNlLgo+Pj4+Cj4+
Pj4gVGhlIElPTU1VIGNvcmUgb25seSB0cmFja3MgbW08LT5kZXZpY2UgYm9uZHMgYXQgdGhlIG1v
bWVudCwgYmVjYXVzZSBpdAo+Pj4+IG9ubHkgbmVlZHMgdG8gaGFuZGxlIElPVExCIGludmFsaWRh
dGlvbiBhbmQgUEFTSUQgdGFibGUgZW50cmllcy4gSG93ZXZlcgo+Pj4+IHVhY2NlIG5lZWRzIGEg
ZmluZXIgZ3JhbnVsYXJpdHkgc2luY2UgbXVsdGlwbGUgcXVldWVzIGZyb20gdGhlIHNhbWUKPj4+
PiBkZXZpY2UgY2FuIGJlIGJvdW5kIHRvIGFuIG1tLiBXaGVuIHRoZSBtbSBleGl0cywgYWxsIGJv
dW5kIHF1ZXVlcyBtdXN0Cj4+Pj4gYmUgc3RvcHBlZCBzbyB0aGF0IHRoZSBJT01NVSBjYW4gc2Fm
ZWx5IGNsZWFyIHRoZSBQQVNJRCB0YWJsZSBlbnRyeSBhbmQKPj4+PiByZWFsbG9jYXRlIHRoZSBQ
QVNJRC4KPj4+Pgo+Pj4+IEFuIGludGVybWVkaWF0ZSBzdHJ1Y3QgdWFjY2VfbW0gbGlua3MgdWFj
Y2UgZGV2aWNlcyBhbmQgcXVldWVzLgo+Pj4+IE5vdGUgdGhhdCBhbiBtbSBtYXkgYmUgYm91bmQg
dG8gbXVsdGlwbGUgZGV2aWNlcyBidXQgYW4gdWFjY2VfbW0KPj4+PiBzdHJ1Y3R1cmUgb25seSBl
dmVyIGJlbG9uZ3MgdG8gYSBzaW5nbGUgZGV2aWNlLCBiZWNhdXNlIHdlIGRvbid0IG5lZWQKPj4+
PiBhbnl0aGluZyBtb3JlIGNvbXBsZXggKGlmIG11bHRpcGxlIGRldmljZXMgYXJlIGJvdW5kIHRv
IG9uZSBtbSwgdGhlbgo+Pj4+IHdlJ2xsIGNyZWF0ZSBvbmUgdWFjY2VfbW0gZm9yIGVhY2ggYm9u
ZCkuCj4+Pj4KPj4+PiAgICAgICAgICAgdWFjY2VfZGV2aWNlIC0tKy0tIHVhY2NlX21tIC0tKy0t
IHVhY2NlX3F1ZXVlCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAg
ICctLSB1YWNjZV9xdWV1ZQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICB8Cj4+Pj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICctLSB1YWNjZV9tbSAtLSstLSB1YWNjZV9xdWV1ZQo+Pj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArLS0gdWFjY2VfcXVldWUK
Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJy0tIHVhY2NlX3F1
ZXVlCj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBLZW5uZXRoIExlZSA8bGlndW96aHVAaGlzaWxp
Y29uLmNvbT4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBaYWlibyBYdSA8eHV6YWlib0BodWF3ZWkuY29t
Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IFpob3UgV2FuZyA8d2FuZ3pob3UxQGhpc2lsaWNvbi5jb20+
Cj4+Pj4gU2lnbmVkLW9mZi1ieTogSmVhbi1QaGlsaXBwZSBCcnVja2VyIDxqZWFuLXBoaWxpcHBl
QGxpbmFyby5vcmc+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogWmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5n
YW9AbGluYXJvLm9yZz4KPj4+IEhpLAo+Pj4KPj4+IFR3byBzbWFsbCB0aGluZ3MgSSdkIG1pc3Nl
ZCBwcmV2aW91c2x5LiAgRml4IHRob3NlIGFuZCBmb3IKPj4+IHdoYXQgaXQncyB3b3J0aAo+Pj4K
Pj4+IFJldmlld2VkLWJ5OiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdl
aS5jb20+Cj4+IFRoYW5rcyBKb25hdGhhbgo+Pj4gICAKPj4+PiAtLS0KPj4+PiAgICBEb2N1bWVu
dGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWRyaXZlci11YWNjZSB8ICAzNyArKwo+Pj4+ICAgIGRy
aXZlcnMvbWlzYy9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsKPj4+PiAg
ICBkcml2ZXJzL21pc2MvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArCj4+
Pj4gICAgZHJpdmVycy9taXNjL3VhY2NlL0tjb25maWcgICAgICAgICAgICAgICAgICAgfCAgMTMg
Kwo+Pj4+ICAgIGRyaXZlcnMvbWlzYy91YWNjZS9NYWtlZmlsZSAgICAgICAgICAgICAgICAgIHwg
ICAyICsKPj4+PiAgICBkcml2ZXJzL21pc2MvdWFjY2UvdWFjY2UuYyAgICAgICAgICAgICAgICAg
ICB8IDYyOCArKysrKysrKysrKysrKysrKysrKysrKysrKysKPj4+PiAgICBpbmNsdWRlL2xpbnV4
L3VhY2NlLmggICAgICAgICAgICAgICAgICAgICAgICB8IDE2MSArKysrKysrCj4+Pj4gICAgaW5j
bHVkZS91YXBpL21pc2MvdWFjY2UvdWFjY2UuaCAgICAgICAgICAgICAgfCAgMzggKysKPj4+PiAg
ICA4IGZpbGVzIGNoYW5nZWQsIDg4MSBpbnNlcnRpb25zKCspCj4+Pj4gICAgY3JlYXRlIG1vZGUg
MTAwNjQ0IERvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtZHJpdmVyLXVhY2NlCj4+Pj4g
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbWlzYy91YWNjZS9LY29uZmlnCj4+Pj4gICAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbWlzYy91YWNjZS9NYWtlZmlsZQo+Pj4+ICAgIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL21pc2MvdWFjY2UvdWFjY2UuYwo+Pj4+ICAgIGNyZWF0
ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2xpbnV4L3VhY2NlLmgKPj4+PiAgICBjcmVhdGUgbW9kZSAx
MDA2NDQgaW5jbHVkZS91YXBpL21pc2MvdWFjY2UvdWFjY2UuaAo+Pj4+ICAgCj4+PiAuLi4KPj4+
PiArCj4+Pj4gK1doYXQ6ICAgICAgICAgICAvc3lzL2NsYXNzL3VhY2NlLzxkZXZfbmFtZT4vYXZh
aWxhYmxlX2luc3RhbmNlcwo+Pj4+ICtEYXRlOiAgICAgICAgICAgRGVjIDIwMTkKPj4+PiArS2Vy
bmVsVmVyc2lvbjogIDUuNgo+Pj4+ICtDb250YWN0OiAgICAgICAgbGludXgtYWNjZWxlcmF0b3Jz
QGxpc3RzLm96bGFicy5vcmcKPj4+PiArRGVzY3JpcHRpb246ICAgIEF2YWlsYWJsZSBpbnN0YW5j
ZXMgbGVmdCBvZiB0aGUgZGV2aWNlCj4+Pj4gKyAgICAgICAgICAgICAgICBSZXR1cm4gLUVOT0RF
ViBpZiB1YWNjZV9vcHMgZ2V0X2F2YWlsYWJsZV9pbnN0YW5jZXMgaXMgbm90IHByb3ZpZGVkCj4+
Pj4gKwo+Pj4gU2VlIGJlbG93LiAgSXQgZG9lc24ndCAicmV0dXJuIiBpdCBwcmludHMgaXQgY3Vy
cmVudGx5Lgo+Pgo+Pj4gLi4uCj4+PiAgIAo+Pj4+ICtzdGF0aWMgc3NpemVfdCBhdmFpbGFibGVf
aW5zdGFuY2VzX3Nob3coc3RydWN0IGRldmljZSAqZGV2LAo+Pj4+ICsJCQkJCXN0cnVjdCBkZXZp
Y2VfYXR0cmlidXRlICphdHRyLAo+Pj4+ICsJCQkJCWNoYXIgKmJ1ZikKPj4+PiArewo+Pj4+ICsJ
c3RydWN0IHVhY2NlX2RldmljZSAqdWFjY2UgPSB0b191YWNjZV9kZXZpY2UoZGV2KTsKPj4+PiAr
CWludCB2YWwgPSAtRU5PREVWOwo+Pj4+ICsKPj4+PiArCWlmICh1YWNjZS0+b3BzLT5nZXRfYXZh
aWxhYmxlX2luc3RhbmNlcykKPj4+PiArCQl2YWwgPSB1YWNjZS0+b3BzLT5nZXRfYXZhaWxhYmxl
X2luc3RhbmNlcyh1YWNjZSk7Cj4+Pj4gKwo+Pj4+ICsJcmV0dXJuIHNwcmludGYoYnVmLCAiJWRc
biIsIHZhbCk7Cj4+PiBJdCdzIHVudXN1YWwgdG8gcGFzcyBhbiBlcnJvciB2YWx1ZSBiYWNrIGFz
IGEgc3RyaW5nLgo+Pj4gSSdkIGV4cGVjdCBzb21lIGxvZ2ljIGxpa2UuLgo+Pj4KPj4+IAlpZiAo
dmFsIDwgMCkKPj4+IAkJcmV0dXJuIHZhbDsKPj4+Cj4+PiAJcmV0dXJuIHNwcmludGYoYnVmLCAi
JWRcbiIsIHZhbCk7Cj4+Pgo+Pj4gTm90ZSB0aGlzIGlzIHRoZSBkb2N1bWVudGVkIGJlaGF2aW9y
ICJyZXR1cm5zIC1FTk9ERVYiLgo+PiBJZiByZXR1cm4gLUVOT0RFViwKPj4gY2F0IC9zeXMvY2xh
c3MvdWFjY2UvaGlzaV96aXAtMC9hdmFpbGFibGVfaW5zdGFuY2VzCj4+IGNhdDogL3N5cy9jbGFz
cy91YWNjZS9oaXNpX3ppcC0wL2F2YWlsYWJsZV9pbnN0YW5jZXM6IE5vIHN1Y2ggZGV2aWNlCj4+
Cj4+IEkgdGhpbmsgcHJpbnQgInVua25vd24iIG1heWJlIGJldHRlciwgbGlrZSBjcHVmcmVxLmMK
Pj4KPj4gICDCoMKgwqDCoMKgwqDCoCBpZiAodWFjY2UtPm9wcy0+Z2V0X2F2YWlsYWJsZV9pbnN0
YW5jZXMpCj4+ICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBzcHJpbnRm
KGJ1ZiwgIiVkXG4iLAo+PiB1YWNjZS0+b3BzLT5nZXRfYXZhaWxhYmxlX2luc3RhbmNlcyh1YWNj
ZSkpOwo+Pgo+PiAgIMKgwqDCoMKgwqDCoMKgIHJldHVybiBzcHJpbnRmKGJ1ZiwgInVua25vd25c
biIpOwo+ICBGcm9tIHVzZXJzcGFjZSBjb2RlIHBvaW50IGEgc2ltcGxlIGVycm9yIGNvZGUgcmV0
dXJuIGlzIGJldHRlciB0aGFuCj4gYSAnbWFnaWMnIHN0cmluZyBpbiB0aGUgZmlsZS4KPgo+IFlv
dSdsbCBmaW5kIHBlb3BsZSBqdXN0IHRyeSB0byByZWFkIGFuIGludGVnZXIgd2l0aG91dCBjaGVj
a2luZwo+IGZvciB1bmtub3duIGFuZCBoZW5jZSBnZXQgYSB2ZXJ5IG9kZCByZXN1bHQuIE11Y2gg
YmV0dGVyIHRvIHRocm93Cj4gdGhlbSBhbiBlcnJvciBjb2RlLgpPSywgdW5kZXJzdGFuZCwgdGhh
bmtzCj4KPgoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
