Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA6FC433F5
	for <iommu@archiver.kernel.org>; Tue, 18 Jan 2022 17:01:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F0E5760E3C;
	Tue, 18 Jan 2022 17:01:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id um9qaQnbPSer; Tue, 18 Jan 2022 17:01:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BE08E60AE2;
	Tue, 18 Jan 2022 17:01:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 989B1C0039;
	Tue, 18 Jan 2022 17:01:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7F6AC002F
 for <iommu@lists.linux-foundation.org>; Tue, 18 Jan 2022 17:01:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9649760AF4
 for <iommu@lists.linux-foundation.org>; Tue, 18 Jan 2022 17:01:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 73ZROFcHRzFs for <iommu@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 17:01:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9D6E260AE2
 for <iommu@lists.linux-foundation.org>; Tue, 18 Jan 2022 17:01:10 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aecd1.dynamic.kabel-deutschland.de
 [95.90.236.209])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1154261EA1BE6;
 Tue, 18 Jan 2022 18:01:07 +0100 (CET)
Message-ID: <fd1c1767-0029-58d2-3878-5bc1a85b8e2c@molgen.mpg.de>
Date: Tue, 18 Jan 2022 18:01:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: nvme: IO_PAGE_FAULT logged with Intel SSDPEKKF512G8
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
References: <366b1545-fdea-3423-10a7-308ca2bef746@molgen.mpg.de>
 <20220118165325.GA3301052@dhcp-10-100-145-180.wdc.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220118165325.GA3301052@dhcp-10-100-145-180.wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org
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

RGVhciBLZWl0aCwKCgpUaGFuayB5b3UgZm9yIHlvdXIgcXVpY2sgcmVzcG9uc2UuCgoKQW0gMTgu
MDEuMjIgdW0gMTc6NTMgc2NocmllYiBLZWl0aCBCdXNjaDoKPiBPbiBUdWUsIEphbiAxOCwgMjAy
MiBhdCAwMzozMjo0NVBNICswMTAwLCBQYXVsIE1lbnplbCB3cm90ZToKPj4gT24gYSBEZWxsIE9w
dGlQbGV4IDUwNTUgd2l0aCBhbiBJbnRlbCBTU0RQRUtLRjUxMkc4LCBMaW51eCA1LjEwLjgyIHJl
cG9ydGVkCj4+IGFuIElPX1BBR0VfRkFVTFQgZXJyb3IuIFRoaXMgaXMgdGhlIGZpcnN0IGFuZCBv
bmx5IHRpbWUgdGhpcyBoYXMgaGFwcGVuZWQuCj4+Cj4+ICAgICAgJCBkbWVzZyAtLWxldmVsPWVy
cgo+PiAgICAgIFsgICAgNC4xOTQzMDZdIG52bWUgMDAwMDowMTowMC4wOiBBTUQtVmk6IEV2ZW50
IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCBkb21haW49MHgwMDBjIGFkZHJlc3M9MHhmZmZmYzA4MCBm
bGFncz0weDAwNTBdCj4+ICAgICAgWyAgICA0LjIwNjk3MF0gbnZtZSAwMDAwOjAxOjAwLjA6IEFN
RC1WaTogRXZlbnQgbG9nZ2VkIFtJT19QQUdFX0ZBVUxUIGRvbWFpbj0weDAwMGMgYWRkcmVzcz0w
eGZmZmZjMDAwIGZsYWdzPTB4MDA1MF0KPj4gICAgICBbICAgIDcuMzI3ODIwXSBrZmQga2ZkOiBW
RVJERSAgbm90IHN1cHBvcnRlZCBpbiBrZmQKPj4gICAgICAkIGxzcGNpIC1ubiAtcyAwMTowMC4w
Cj4+ICAgICAgMDE6MDAuMCBOb24tVm9sYXRpbGUgbWVtb3J5IGNvbnRyb2xsZXIgWzAxMDhdOiBJ
bnRlbCBDb3Jwb3JhdGlvbiBTU0QgUHJvIDc2MDBwLzc2MHAvRSA2MTAwcCBTZXJpZXMgWzgwODY6
ZjFhNl0gKHJldiAwMykKPiAKPiBJIHRoaW5rIGl0J3MgYSBidWcgd2l0aCB0aGUgaW9tbXUgaW1w
bGVtZW50YXRpb24uCgpUaGF0IHdvdWxkIHN1cnByaXNlIG1lLCBidXQgSSBhbSBhZGRpbmcgSsO2
cmcgYW5kIFN1cmF2ZWUgdG8gdGhlIApyZWNpcGllbnQgbGlzdC4gTGFzdCB0aW1lLCBJIHNhdyBh
biBJT19QQUdFX0ZBVUxULCBpdCB3YXMgYSBidWcgaW4gdGhlIAphbWRncHUgZHJpdmVyLgoKPiBJ
ZiBpdCBjYXVzZXMgcHJvYmxlbXMsIHlvdSBjYW4gdHlwaWNhbGx5IHdvcmsgYXJvdW5kIGl0IHdp
dGgga2VybmVsCj4gcGFyYW1ldGVyICJpb21tdT1zb2Z0Ii4KCkkgaGF2ZSBub3Qgbm90aWNlZCBh
bnkgcHJvYmxlbXMgeWV0LgoKCktpbmQgcmVnYXJkcywKClBhdWwKCgpQUzogTm8gaWRlYSwgaWYg
dXNlZnVsLCBidXQgSSBpbmNsdWRlIHRoZSBjb250ZW50IG9mIGAvcHJvYy9pb21lbWA6CgokIHN1
ZG8gbW9yZSAvcHJvYy9pb21lbQowMDAwMDAwMC0wMDAwMGZmZiA6IFJlc2VydmVkCjAwMDAxMDAw
LTAwMDg3ZmZmIDogU3lzdGVtIFJBTQowMDA4ODAwMC0wMDA4OGZmZiA6IFJlc2VydmVkCjAwMDg5
MDAwLTAwMDllZmZmIDogU3lzdGVtIFJBTQowMDA5ZjAwMC0wMDBiZmZmZiA6IFJlc2VydmVkCiAg
IDAwMGEwMDAwLTAwMGJmZmZmIDogUENJIEJ1cyAwMDAwOjAwCjAwMGMwMDAwLTAwMGMzZmZmIDog
UENJIEJ1cyAwMDAwOjAwCjAwMGM0MDAwLTAwMGM3ZmZmIDogUENJIEJ1cyAwMDAwOjAwCjAwMGM4
MDAwLTAwMGNiZmZmIDogUENJIEJ1cyAwMDAwOjAwCjAwMGNjMDAwLTAwMGNmZmZmIDogUENJIEJ1
cyAwMDAwOjAwCjAwMGQwMDAwLTAwMGQzZmZmIDogUENJIEJ1cyAwMDAwOjAwCjAwMGQ0MDAwLTAw
MGQ3ZmZmIDogUENJIEJ1cyAwMDAwOjAwCjAwMGQ4MDAwLTAwMGRiZmZmIDogUENJIEJ1cyAwMDAw
OjAwCjAwMGRjMDAwLTAwMGRmZmZmIDogUENJIEJ1cyAwMDAwOjAwCjAwMGUwMDAwLTAwMGUzZmZm
IDogUENJIEJ1cyAwMDAwOjAwCjAwMGU0MDAwLTAwMGU3ZmZmIDogUENJIEJ1cyAwMDAwOjAwCjAw
MGU4MDAwLTAwMGViZmZmIDogUENJIEJ1cyAwMDAwOjAwCjAwMGVjMDAwLTAwMGVmZmZmIDogUENJ
IEJ1cyAwMDAwOjAwCjAwMGYwMDAwLTAwMGZmZmZmIDogU3lzdGVtIFJPTQowMDEwMDAwMC0wOWNm
ZmZmZiA6IFN5c3RlbSBSQU0KICAgMDUwMDAwMDAtMDVlMDMzMTYgOiBLZXJuZWwgY29kZQogICAw
NjAwMDAwMC0wNjNhOGZmZiA6IEtlcm5lbCByb2RhdGEKICAgMDY0MDAwMDAtMDY3NjJlZmYgOiBL
ZXJuZWwgZGF0YQogICAwNmQzMTAwMC0wNmZmZmZmZiA6IEtlcm5lbCBic3MKMDlkMDAwMDAtMDll
NmZmZmYgOiBSZXNlcnZlZAowOWU3MDAwMC03YWZiNWZmZiA6IFN5c3RlbSBSQU0KN2FmYjYwMDAt
N2FmYjZmZmYgOiBSZXNlcnZlZAo3YWZiNzAwMC03YWZiYmZmZiA6IFN5c3RlbSBSQU0KN2FmYmMw
MDAtN2FmYmNmZmYgOiBSZXNlcnZlZAo3YWZiZDAwMC1kYWRiZWZmZiA6IFN5c3RlbSBSQU0KZGFk
YmYwMDAtZGFmYmVmZmYgOiBVbmtub3duIEU4MjAgdHlwZQpkYWZiZjAwMC1kY2ZiZWZmZiA6IFJl
c2VydmVkCmRjZmJmMDAwLWRlZmJlZmZmIDogQUNQSSBOb24tdm9sYXRpbGUgU3RvcmFnZQpkZWZi
ZjAwMC1kZWZmZWZmZiA6IEFDUEkgVGFibGVzCmRlZmZmMDAwLWRlZmZmZmZmIDogU3lzdGVtIFJB
TQpkZjAwMDAwMC1kZmZmZmZmZiA6IFJlc2VydmVkCmUwMDAwMDAwLWY3ZmZmZmZmIDogUENJIEJ1
cyAwMDAwOjAwCiAgIGUwMDAwMDAwLWVmZmZmZmZmIDogUENJIEJ1cyAwMDAwOjA2CiAgICAgZTAw
MDAwMDAtZWZmZmZmZmYgOiAwMDAwOjA2OjAwLjAKICAgZjAwMDAwMDAtZjAwZmZmZmYgOiBQQ0kg
QnVzIDAwMDA6MDIKICAgICBmMDAwMDAwMC1mMDBmZmZmZiA6IFBDSSBCdXMgMDAwMDowMwogICAg
ICAgZjAwMDAwMDAtZjAwZmZmZmYgOiBQQ0kgQnVzIDAwMDA6MDQKICAgICAgICAgZjAwMDAwMDAt
ZjAwMGZmZmYgOiAwMDAwOjA0OjAwLjAKICAgICAgICAgICBmMDAwMDAwMC1mMDAwZmZmZiA6IHRn
MwogICAgICAgICBmMDAxMDAwMC1mMDAxZmZmZiA6IDAwMDA6MDQ6MDAuMAogICAgICAgICAgIGYw
MDEwMDAwLWYwMDFmZmZmIDogdGczCiAgICAgICAgIGYwMDIwMDAwLWYwMDJmZmZmIDogMDAwMDow
NDowMC4wCiAgICAgICAgICAgZjAwMjAwMDAtZjAwMmZmZmYgOiB0ZzMKICAgZjAxMDAwMDAtZjAx
ZmZmZmYgOiBQQ0kgQnVzIDAwMDA6MDgKICAgICBmMDEwMDAwMC1mMDEwN2ZmZiA6IDAwMDA6MDg6
MDAuMwogICAgICAgZjAxMDAwMDAtZjAxMDdmZmYgOiBJQ0ggSEQgYXVkaW8KICAgICBmMDEwODAw
MC1mMDEwOGZmZiA6IDAwMDA6MDg6MDAuMgogICAgICAgZjAxMDgwMDAtZjAxMDhmZmYgOiBhaGNp
CiAgIGYwMjAwMDAwLWYwNGZmZmZmIDogUENJIEJ1cyAwMDAwOjA3CiAgICAgZjAyMDAwMDAtZjAy
ZmZmZmYgOiAwMDAwOjA3OjAwLjMKICAgICAgIGYwMjAwMDAwLWYwMmZmZmZmIDogeGhjaS1oY2QK
ICAgICBmMDMwMDAwMC1mMDNmZmZmZiA6IDAwMDA6MDc6MDAuMgogICAgIGYwNDAwMDAwLWYwNDAx
ZmZmIDogMDAwMDowNzowMC4yCiAgIGYwNTAwMDAwLWYwNWZmZmZmIDogUENJIEJ1cyAwMDAwOjA2
CiAgICAgZjA1MDAwMDAtZjA1M2ZmZmYgOiAwMDAwOjA2OjAwLjAKICAgICBmMDU0MDAwMC1mMDU0
M2ZmZiA6IDAwMDA6MDY6MDAuMQogICAgICAgZjA1NDAwMDAtZjA1NDNmZmYgOiBJQ0ggSEQgYXVk
aW8KICAgICBmMDU2MDAwMC1mMDU3ZmZmZiA6IDAwMDA6MDY6MDAuMAogICBmMDYwMDAwMC1mMDZm
ZmZmZiA6IFBDSSBCdXMgMDAwMDowMgogICAgIGYwNjAwMDAwLWYwNjFmZmZmIDogMDAwMDowMjow
MC4xCiAgICAgICBmMDYwMDAwMC1mMDYxZmZmZiA6IGFoY2kKICAgICBmMDYyMDAwMC1mMDYyN2Zm
ZiA6IDAwMDA6MDI6MDAuMAogICAgICAgZjA2MjAwMDAtZjA2MjdmZmYgOiB4aGNpLWhjZAogICAg
IGYwNjgwMDAwLWYwNmZmZmZmIDogMDAwMDowMjowMC4xCiAgIGYwNzAwMDAwLWYwN2ZmZmZmIDog
UENJIEJ1cyAwMDAwOjAxCiAgICAgZjA3MDAwMDAtZjA3MDNmZmYgOiAwMDAwOjAxOjAwLjAKICAg
ICAgIGYwNzAwMDAwLWYwNzAzZmZmIDogbnZtZQpmODAwMDAwMC1mYmZmZmZmZiA6IFBDSSBNTUNP
TkZJRyAwMDAwIFtidXMgMDAtM2ZdCiAgIGY4MDAwMDAwLWZiZmZmZmZmIDogUmVzZXJ2ZWQKZmMw
MDAwMDAtZmVhZmZmZmYgOiBQQ0kgQnVzIDAwMDA6MDAKICAgZmMwMDAwMDAtZmMwN2ZmZmYgOiBh
bWRfaW9tbXUKICAgZmRmMDAwMDAtZmRmZmZmZmYgOiBwbnAgMDA6MDAKZmVjMDAwMDAtZmVjMDBm
ZmYgOiBSZXNlcnZlZAogICBmZWMwMDAwMC1mZWMwMDNmZiA6IElPQVBJQyAwCmZlYzAxMDAwLWZl
YzAxM2ZmIDogSU9BUElDIDEKZmVjMTAwMDAtZmVjMTBmZmYgOiBSZXNlcnZlZApmZWMzMDAwMC1m
ZWMzMGZmZiA6IEFNRElGMDMwOjAwCmZlZDAwMDAwLWZlZDAwM2ZmIDogSFBFVCAwCiAgIGZlZDAw
MDAwLWZlZDAwM2ZmIDogUE5QMDEwMzowMApmZWQ0MDAwMC1mZWQ0NGZmZiA6IE1TRlQwMTAxOjAw
CmZlZDgwMDAwLWZlZDgwZmZmIDogUmVzZXJ2ZWQKZmVkODE1MDAtZmVkODE4ZmYgOiBBTURJMDAz
MDowMApmZWUwMDAwMC1mZWUwMGZmZiA6IExvY2FsIEFQSUMKICAgZmVlMDAwMDAtZmVlMDBmZmYg
OiBwbnAgMDA6MDAKZmYwMDAwMDAtZmZmZmZmZmYgOiBSZXNlcnZlZAogICBmZjAwMDAwMC1mZmZm
ZmZmZiA6IHBucCAwMDowMwoxMDAwMDAwMDAtODFlZmZmZmZmIDogU3lzdGVtIFJBTQo4MWYwMDAw
MDAtODFmZmZmZmZmIDogUkFNIGJ1ZmZlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
