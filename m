Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD981C433EF
	for <iommu@archiver.kernel.org>; Wed,  1 Jun 2022 17:25:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7E828405B1;
	Wed,  1 Jun 2022 17:25:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WQE-Sl-BrOqT; Wed,  1 Jun 2022 17:25:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4D0AD400B8;
	Wed,  1 Jun 2022 17:25:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09253C0039;
	Wed,  1 Jun 2022 17:25:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3158C002D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 17:25:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BB251417AE
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 17:25:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4-qgF4RKOpt7 for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 17:25:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 59D2B417A8
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 17:25:39 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id DA5C2B81BC3;
 Wed,  1 Jun 2022 17:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301D1C385A5;
 Wed,  1 Jun 2022 17:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654104334;
 bh=jMMe7B3BhgdISh7uct3BKpjV+FPEgE6gFytMtHtHl0c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GHO+qMWQe5cP8tmgUQqj8fPGjJwS3Otgz+OXIEdGPVJSradD7wwZvicTh/XeTN6xn
 36cftZjh2U4vxTC907inz6H2ofvk+02etbYJZRSA3kWg1Zraq122z9y1G6zY5uAzjM
 9xDC4IBmiXmiVoI5M28u6BmC46gm/t04m9/d3Uk738NKcetPPZ1x+AIx5ihXth0Frb
 Ch9UusaL6Sktiv1EghEBMMueZ59I77EcbHnOJL4/Jl32ORyzuRmi00q7R572WE5XOK
 /zF9VgHnpoTDGhq77ORqvchBakQOe3gxA1stj2MKAJaA3beP0uvbuDT0szSX/KVl+i
 ui6hmrXqhf3Iw==
Date: Wed, 1 Jun 2022 10:25:31 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 09/15] swiotlb: make the swiotlb_init interface more useful
Message-ID: <YpehC7BwBlnuxplF@dev-arch.thelio-3990X>
References: <20220404050559.132378-1-hch@lst.de>
 <20220404050559.132378-10-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220404050559.132378-10-hch@lst.de>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 tboot-devel@lists.sourceforge.net, xen-devel@lists.xenproject.org,
 David Woodhouse <dwmw2@infradead.org>, Tom Lendacky <thomas.lendacky@amd.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 linux-arm-kernel@lists.infradead.org, Juergen Gross <jgross@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

SGkgQ2hyaXN0b3BoLAoKT24gTW9uLCBBcHIgMDQsIDIwMjIgYXQgMDc6MDU6NTNBTSArMDIwMCwg
Q2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gUGFzcyBhIGJvb2wgdG8gcGFzcyBpZiBzd2lvdGxi
IG5lZWRzIHRvIGJlIGVuYWJsZWQgYmFzZWQgb24gdGhlCj4gYWRkcmVzc2luZyBuZWVkcyBhbmQg
cmVwbGFjZSB0aGUgdmVyYm9zZSBhcmd1bWVudCB3aXRoIGEgc2V0IG9mCj4gZmxhZ3MsIGluY2x1
ZGluZyBvbmUgdG8gZm9yY2UgZW5hYmxlIGJvdW5jZSBidWZmZXJpbmcuCj4gCj4gTm90ZSB0aGF0
IHRoaXMgcGF0Y2ggcmVtb3ZlcyB0aGUgcG9zc2liaWxpdHkgdG8gZm9yY2UgeGVuLXN3aW90bGIK
PiB1c2UgdXNpbmcgc3dpb3RsYj1mb3JjZSBvbiB0aGUgY29tbWFuZCBsaW5lIG9uIHg4NiAoYXJt
IGFuZCBhcm02NAo+IG5ldmVyIHN1cHBvcnRlZCB0aGF0KSwgYnV0IHRoaXMgaW50ZXJmYWNlIHdp
bGwgYmUgcmVzdG9yZWQgc2hvcnRseS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVs
bHdpZyA8aGNoQGxzdC5kZT4KCkkgYmlzZWN0ZWQgYSBwZXJmb3JtYW5jZSByZWdyZXNzaW9uIGlu
IFdTTDIgdG8gdGhpcyBjaGFuZ2UgYXMgY29tbWl0CmM2YWYyYWE5ZmZjOSAoInN3aW90bGI6IG1h
a2UgdGhlIHN3aW90bGJfaW5pdCBpbnRlcmZhY2UgbW9yZSB1c2VmdWwiKSBpbgptYWlubGluZSAo
YmlzZWN0IGxvZyBiZWxvdykuIEkgaW5pdGlhbGx5IG5vdGljZWQgaXQgYmVjYXVzZSBhY2Nlc3Np
bmcgdGhlCldpbmRvd3MgZmlsZXN5c3RlbSB0aHJvdWdoIHRoZSAvbW50L2MgbW91bnQgaXMgYWJv
dXQgNDB4IHNsb3dlciBpZiBJIGFtIGRvaW5nCm15IG1hdGggcmlnaHQgYmFzZWQgb24gdGhlIGJl
bmNobWFya3MgYmVsb3cuCgpCZWZvcmU6CgokIHVuYW1lIC1yOyBhbmQgaHlwZXJmaW5lICJscyAt
bCAvbW50L2MvVXNlcnMvbmF0ZWMvRG93bmxvYWRzIgo1LjE4LjAtcmMzLW1pY3Jvc29mdC1zdGFu
ZGFyZC1XU0wyLTAwMDA4LWdhM2UyMzA5MjY3MDgKQmVuY2htYXJrIDE6IGxzIC1sIC9tbnQvYy9V
c2Vycy9uYXRlYy9Eb3dubG9hZHMKICBUaW1lIChtZWFuIMKxIM+DKTogICAgIDU2NC41IG1zIMKx
ICAyNC4xIG1zICAgIFtVc2VyOiAyLjUgbXMsIFN5c3RlbTogMTMwLjMgbXNdCiAgUmFuZ2UgKG1p
biDigKYgbWF4KTogICA1MTAuMiBtcyDigKYgNTg4LjAgbXMgICAgMTAgcnVucwoKQWZ0ZXIKCiQg
dW5hbWUgLXI7IGFuZCBoeXBlcmZpbmUgImxzIC1sIC9tbnQvYy9Vc2Vycy9uYXRlYy9Eb3dubG9h
ZHMiCjUuMTguMC1yYzMtbWljcm9zb2Z0LXN0YW5kYXJkLVdTTDItMDAwMDktZ2M2YWYyYWE5ZmZj
OQpCZW5jaG1hcmsgMTogbHMgLWwgL21udC9jL1VzZXJzL25hdGVjL0Rvd25sb2FkcwogIFRpbWUg
KG1lYW4gwrEgz4MpOiAgICAgMjMuMjgyIHMgwrEgIDEuMjIwIHMgICAgW1VzZXI6IDAuMDEzIHMs
IFN5c3RlbTogMC4xMDEgc10KICBSYW5nZSAobWluIOKApiBtYXgpOiAgIDIxLjc5MyBzIOKApiAy
NS4zMTcgcyAgICAxMCBydW5zCgpJIGRvIHNlZSAnc3dpb3RsYj1mb3JjZScgb24gdGhlIGNtZGxp
bmU6CgokIGNhdCAvcHJvYy9jbWRsaW5lCmluaXRyZD1caW5pdHJkLmltZyBwYW5pYz0tMSBucl9j
cHVzPTggc3dpb3RsYj1mb3JjZSBlYXJseWNvbj11YXJ0ODI1MCxpbywweDNmOCwxMTUyMDAgY29u
c29sZT1odmMwIGRlYnVnIHB0eS5sZWdhY3lfY291bnQ9MAoKL21udC9jIGFwcGVhcnMgdG8gYmUg
YSA5cCBtb3VudCwgbm90IHN1cmUgaWYgdGhhdCBpcyByZWxldmFudCBoZXJlOgoKJCBtb3VudCAm
fCBncmVwIC9tbnQvYwpkcnZmcyBvbiAvbW50L2MgdHlwZSA5cCAocncsbm9hdGltZSxkaXJzeW5j
LGFuYW1lPWRydmZzO3BhdGg9QzpcO3VpZD0xMDAwO2dpZD0xMDAwO3N5bWxpbmtyb290PS9tbnQv
LG1tYXAsYWNjZXNzPWNsaWVudCxtc2l6ZT0yNjIxNDQsdHJhbnM9dmlydGlvKQoKSWYgdGhlcmUg
aXMgYW55IG90aGVyIGluZm9ybWF0aW9uIEkgY2FuIHByb3ZpZGUsIHBsZWFzZSBsZXQgbWUga25v
dy4KCkNoZWVycywKTmF0aGFuCgojIGJhZDogWzcwMDE3MGJmNmI0ZDc3M2UzMjhmYTU0ZWJiNzBi
YTQ0NDAwN2M3MDJdIE1lcmdlIHRhZyAnbmZzLWZvci01LjE5LTEnIG9mIGdpdDovL2dpdC5saW51
eC1uZnMub3JnL3Byb2plY3RzL2FubmEvbGludXgtbmZzCiMgZ29vZDogWzRiMDk4NmEzNjEzYzky
ZjRlYzFiZGM3ZjYwZWM2NmZlYTEzNTk5MWZdIExpbnV4IDUuMTgKZ2l0IGJpc2VjdCBzdGFydCAn
NzAwMTcwYmY2YjRkNzczZTMyOGZhNTRlYmI3MGJhNDQ0MDA3YzcwMicgJ3Y1LjE4JwojIGdvb2Q6
IFs4NmM4N2JlYTZiNDIxMDBjNjc0MThhZjY5MDkxOWM0NGRlNmVkZTZlXSBNZXJnZSB0YWcgJ2Rl
dmljZXRyZWUtZm9yLTUuMTknIG9mIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC9yb2JoL2xpbnV4CmdpdCBiaXNlY3QgZ29vZCA4NmM4N2JlYTZiNDIxMDBjNjc0
MThhZjY5MDkxOWM0NGRlNmVkZTZlCiMgYmFkOiBbYWU4NjIxODMyODVjYmIyZWY5MDMyNzcwZDk4
ZmZhOWJlY2ZmZTlkNV0gTWVyZ2UgdGFnICdhcm0tZHQtNS4xOScgb2YgZ2l0Oi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3NvYy9zb2MKZ2l0IGJpc2VjdCBiYWQgYWU4
NjIxODMyODVjYmIyZWY5MDMyNzcwZDk4ZmZhOWJlY2ZmZTlkNQojIGdvb2Q6IFsyNTE4ZjIyNmM2
MGQ4ZTA0ZDE4YmE0Mjk1NTAwYTViMGI4YWM3NjU5XSBNZXJnZSB0YWcgJ2RybS1uZXh0LTIwMjIt
MDUtMjUnIG9mIGdpdDovL2Fub25naXQuZnJlZWRlc2t0b3Aub3JnL2RybS9kcm0KZ2l0IGJpc2Vj
dCBnb29kIDI1MThmMjI2YzYwZDhlMDRkMThiYTQyOTU1MDBhNWIwYjhhYzc2NTkKIyBiYWQ6IFti
YWJmMGJiOTc4ZTNjOWZjZTZjNGViYTZiNzQ0Yzg3NTRmZDQzZDhlXSBNZXJnZSB0YWcgJ3hmcy01
LjE5LWZvci1saW51cycgb2YgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9mcy94ZnMveGZz
LWxpbnV4CmdpdCBiaXNlY3QgYmFkIGJhYmYwYmI5NzhlM2M5ZmNlNmM0ZWJhNmI3NDRjODc1NGZk
NDNkOGUKIyBnb29kOiBbYmVlZDk4MzYyMWZiZGZkMjkxZTZlM2EwY2RjNGQxMDUxN2U2MGFmOF0g
QVNvQzogSW50ZWw6IGF2czogTWFjaGluZSBib2FyZCByZWdpc3RyYXRpb24KZ2l0IGJpc2VjdCBn
b29kIGJlZWQ5ODM2MjFmYmRmZDI5MWU2ZTNhMGNkYzRkMTA1MTdlNjBhZjgKIyBnb29kOiBbZmJl
ODZkYWNhMGJhODc4YjA0ZmEyNDFiODVlMjZlNTRkMTdkNDIyOV0gTWVyZ2UgdGFnICdzY3NpLW1p
c2MnIG9mIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9qZWpi
L3Njc2kKZ2l0IGJpc2VjdCBnb29kIGZiZTg2ZGFjYTBiYTg3OGIwNGZhMjQxYjg1ZTI2ZTU0ZDE3
ZDQyMjkKIyBnb29kOiBbMTY2YWZjNDVlZDU1MjMyOTg1NDFmZDAyOTdmOWFkNTg1Y2MyNzA4Y10g
TWVyZ2UgdGFnICdyZWZsaW5rLXNwZWVkdXBzLTUuMTlfMjAyMi0wNC0yOCcgb2YgZ2l0Oi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2Rqd29uZy94ZnMtbGludXggaW50
byB4ZnMtNS4xOS1mb3ItbmV4dApnaXQgYmlzZWN0IGdvb2QgMTY2YWZjNDVlZDU1MjMyOTg1NDFm
ZDAyOTdmOWFkNTg1Y2MyNzA4YwojIGJhZDogW2UzNzU3ODBiNjMxYTVmYzJhNjFhM2I0ZmExMjQy
OTI1NTM2MWEzMWVdIE1lcmdlIHRhZyAnZnNub3RpZnlfZm9yX3Y1LjE5LXJjMScgb2YgZ2l0Oi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2phY2svbGludXgtZnMKZ2l0
IGJpc2VjdCBiYWQgZTM3NTc4MGI2MzFhNWZjMmE2MWEzYjRmYTEyNDI5MjU1MzYxYTMxZQojIGJh
ZDogWzRhMzdmM2RkOWE4MzE4NmNiODhkNDQ4MDhhYjM1Yjc4Mzc1MDgyYzldIGRtYS1kaXJlY3Q6
IGRvbid0IG92ZXItZGVjcnlwdCBtZW1vcnkKZ2l0IGJpc2VjdCBiYWQgNGEzN2YzZGQ5YTgzMTg2
Y2I4OGQ0NDgwOGFiMzViNzgzNzUwODJjOQojIGJhZDogWzc0MjUxOTUzOGU2YjA3MjUwYzgwODVi
YmZmNGJkMzU4YmMwM2JmMTZdIHN3aW90bGI6IHBhc3MgYSBnZnBfbWFzayBhcmd1bWVudCB0byBz
d2lvdGxiX2luaXRfbGF0ZQpnaXQgYmlzZWN0IGJhZCA3NDI1MTk1MzhlNmIwNzI1MGM4MDg1YmJm
ZjRiZDM1OGJjMDNiZjE2CiMgZ29vZDogWzliYmU3YTdmYzEyNmUzZDE0ZmVmYTRiMDM1ODU0YWJh
MDgwOTI2ZDldIGFybS94ZW46IGRvbid0IGNoZWNrIGZvciB4ZW5faW5pdGlhbF9kb21haW4oKSBp
biB4ZW5fY3JlYXRlX2NvbnRpZ3VvdXNfcmVnaW9uCmdpdCBiaXNlY3QgZ29vZCA5YmJlN2E3ZmMx
MjZlM2QxNGZlZmE0YjAzNTg1NGFiYTA4MDkyNmQ5CiMgZ29vZDogW2EzZTIzMDkyNjcwODEyNTIw
NWZmZDA2ZDNkYzIxNzVhODI2M2FlN2VdIHg4NjogY2VudHJhbGl6ZSBzZXR0aW5nIFNXSU9UTEJf
Rk9SQ0Ugd2hlbiBndWVzdCBtZW1vcnkgZW5jcnlwdGlvbiBpcyBlbmFibGVkCmdpdCBiaXNlY3Qg
Z29vZCBhM2UyMzA5MjY3MDgxMjUyMDVmZmQwNmQzZGMyMTc1YTgyNjNhZTdlCiMgYmFkOiBbOGJh
MmVkMWJlOTBmYzIxMDEyNmY2ODE4NjU2NDcwNzQ3ODU1MmM5NV0gc3dpb3RsYjogYWRkIGEgU1dJ
T1RMQl9BTlkgZmxhZyB0byBsaWZ0IHRoZSBsb3cgbWVtb3J5IHJlc3RyaWN0aW9uCmdpdCBiaXNl
Y3QgYmFkIDhiYTJlZDFiZTkwZmMyMTAxMjZmNjgxODY1NjQ3MDc0Nzg1NTJjOTUKIyBiYWQ6IFtj
NmFmMmFhOWZmYzk3NjM4MjY2MDdiYzI2NjRlZjNlYTQ0NzVlZDE4XSBzd2lvdGxiOiBtYWtlIHRo
ZSBzd2lvdGxiX2luaXQgaW50ZXJmYWNlIG1vcmUgdXNlZnVsCmdpdCBiaXNlY3QgYmFkIGM2YWYy
YWE5ZmZjOTc2MzgyNjYwN2JjMjY2NGVmM2VhNDQ3NWVkMTgKIyBmaXJzdCBiYWQgY29tbWl0OiBb
YzZhZjJhYTlmZmM5NzYzODI2NjA3YmMyNjY0ZWYzZWE0NDc1ZWQxOF0gc3dpb3RsYjogbWFrZSB0
aGUgc3dpb3RsYl9pbml0IGludGVyZmFjZSBtb3JlIHVzZWZ1bApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
