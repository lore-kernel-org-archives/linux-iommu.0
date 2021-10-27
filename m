Return-Path: <SRS0=XM0R=PP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E01DC433F5
	for <iommu@archiver.kernel.org>; Wed, 27 Oct 2021 17:24:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F307060E78
	for <iommu@archiver.kernel.org>; Wed, 27 Oct 2021 17:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F307060E78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2824405C1;
	Wed, 27 Oct 2021 17:24:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x4K8bzYIWlr1; Wed, 27 Oct 2021 17:24:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9C1F1405BA;
	Wed, 27 Oct 2021 17:24:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74EB5C0012;
	Wed, 27 Oct 2021 17:24:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28111C0036
 for <iommu@lists.linux-foundation.org>; Wed, 27 Oct 2021 17:24:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EC74560821
 for <iommu@lists.linux-foundation.org>; Wed, 27 Oct 2021 17:24:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wlP2cNcir_Mo for <iommu@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 17:24:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E127760B3A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Oct 2021 17:24:16 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id q124so4418735oig.3
 for <iommu@lists.linux-foundation.org>; Wed, 27 Oct 2021 10:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZTpDujXUs8AgiTYay7x9mo53A+jrUMMnqRa2UanwXXU=;
 b=H+nZpoyo+68UwBEBmhwaP3AV5LjR872sOY3DTnp0b5wIJrBk6dDgYepLfXn1cYXVuw
 5UXzjnSolau+QJdPwPsVNdDiCRnggiGvq3/V+UjEC5PDHz9xJQhDTQHJTGwcqobOi0MF
 mdc30+FN0+uQvSA32jjI6z4PrV28rBiPZO7+yk/BYRZd2QH8EJxGqFWfBJoGzBz5ARAV
 XHz+Qk9hTOwmRNklby2zl7hT+1l+oLoCMjO6eh+e0eSid7gGwZRR3K5Be9zXDVsWeRXU
 RqWqiROt20t7IfuPDX3AbKPvF0e9RIg8EyNv3mvoZygWFP16CZYS4OiDi2vE8lF48yAk
 unKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZTpDujXUs8AgiTYay7x9mo53A+jrUMMnqRa2UanwXXU=;
 b=liK+lazRPVnz4xdnjD3ri0BYEbo/6brhLLsOBINjy2ZG2opQDEvPcD4hDefrWE7MUO
 Yo4rR6C9pLben2GfZikQ6q+njTjxt9oJgyq8KJHyCUHucIJGiLAgJIJHVNtAgmUK022Y
 7tHvu4dEl7soLUWpv2imGaiTH3/u+Rnh6+6Rjb/CHQGe23BCjUfta1rpRNe/SX/07FNy
 F0b+aTlkrC+35goq2mWzK+5kMrL9hwP72zxz9SiGEzkDriiDbGGW6DeIDBNeOCl96UO5
 JEMhcnumCN2w2KiaCr7knXjXQ51rWv1IXurnnkFfxYVKejdC1Ws4KOpDE/tsBnC+opFD
 DHCA==
X-Gm-Message-State: AOAM532G9L40yROlETtTvlO4FiYqBT9ih4sxMyHflu0UnsN6irzqfwL/
 T0pa90biwWrmCFurmueq9ma6rhRolMQQYv2thLk=
X-Google-Smtp-Source: ABdhPJzgy+PBIXCwu4lAyqaAU5LxAsB82sOF5UiHFh8XhLbSe4+mWz/uU24XI0PXBRhAXlO81/VD6jmqXW0JkcxrLg4=
X-Received: by 2002:aca:3f87:: with SMTP id m129mr4569296oia.5.1635355455913; 
 Wed, 27 Oct 2021 10:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <7a5123b0-6370-59dc-f0c2-8be5b370d9ba@molgen.mpg.de>
 <0cfccc44-6cc6-98f5-ecd6-2f376839ec18@gmail.com>
 <bc7142a1-82d3-43bf-dee2-25f9297e7182@arm.com>
 <3c2de089-8f80-3644-7735-7df1c6151d70@molgen.mpg.de>
 <82fccb9d-43e8-4485-0ddb-7ff260f3ed32@arm.com>
In-Reply-To: <82fccb9d-43e8-4485-0ddb-7ff260f3ed32@arm.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 Oct 2021 13:24:04 -0400
Message-ID: <CADnq5_NiigOVnahNWrro+ur2aejcHLTLJMH5ndUyg3cO8E+NRw@mail.gmail.com>
Subject: Re: I got an IOMMU IO page fault. What to do now?
To: Robin Murphy <robin.murphy@arm.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Xinhui Pan <Xinhui.Pan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Alex Deucher <alexander.deucher@amd.com>, it+linux-iommu@molgen.mpg.de,
 Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

T24gV2VkLCBPY3QgMjcsIDIwMjEgYXQgMToyMCBQTSBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBo
eUBhcm0uY29tPiB3cm90ZToKPgo+IE9uIDI3LzEwLzIwMjEgNTo0NSBwbSwgUGF1bCBNZW56ZWwg
d3JvdGU6Cj4gPiBEZWFyIFJvYmluLAo+ID4KPiA+Cj4gPiBPbiAyNS4xMC4yMSAxODowMSwgUm9i
aW4gTXVycGh5IHdyb3RlOgo+ID4+IE9uIDIwMjEtMTAtMjUgMTI6MjMsIENocmlzdGlhbiBLw7Zu
aWcgd3JvdGU6Cj4gPgo+ID4+PiBub3Qgc3VyZSBob3cgdGhlIElPTU1VIGdpdmVzIG91dCBhZGRy
ZXNzZXMsIGJ1dCB0aGUgcHJpbnRlZCBvbmVzIGxvb2sKPiA+Pj4gc3VzcGljaW91cyB0byBtZS4g
U29tZXRoaW5nIGxpa2Ugd2UgYXJlIHVzaW5nIGFuIGludmFsaWQgYWRkcmVzcyBsaWtlCj4gPj4+
IC0xIG9yIHNpbWlsYXIuCj4gPj4KPiA+PiBGV0lXIHRob3NlIGxvb2sgbGlrZSBiZWxpZXZhYmxl
IERNQSBhZGRyZXNzZXMgdG8gbWUsIGFzc3VtaW5nIHRoYXQgdGhlCj4gPj4gRE1BIG1hcHBpbmcg
QVBJcyBhcmUgYmVpbmcgYmFja2VkIGlvbW11X2RtYV9vcHMgYW5kIHRoZSBkZXZpY2UgaGFzIGEK
PiA+PiA0MC1iaXQgRE1BIG1hc2ssIHNpbmNlIHRoZSBJT1ZBIGFsbG9jYXRvciB3b3JrcyB0b3At
ZG93bi4KPiA+Pgo+ID4+IExpa2VseSBjYXVzZXMgYXJlIGVpdGhlciBhIHJhY2Ugd2hlcmUgdGhl
IGRtYV91bm1hcF8qKCkgY2FsbCBoYXBwZW5zCj4gPj4gYmVmb3JlIHRoZSBoYXJkd2FyZSBoYXMg
cmVhbGx5IHN0b3BwZWQgYWNjZXNzaW5nIHRoZSByZWxldmFudAo+ID4+IGFkZHJlc3Nlcywgb3Ig
dGhlIGRldmljZSdzIERNQSBtYXNrIGhhcyBiZWVuIHNldCBsYXJnZXIgdGhhbiBpdCBzaG91bGQK
PiA+PiBiZSwgYW5kIHRodXMgdGhlIHVwcGVyIGJpdHMgaGF2ZSBiZWVuIHRydW5jYXRlZCBpbiB0
aGUgcm91bmQtdHJpcAo+ID4+IHRocm91Z2ggdGhlIGhhcmR3YXJlLgo+ID4+Cj4gPj4gR2l2ZW4g
dGhlIGFkZHJlc3NlcyBpbnZvbHZlZCwgbXkgc3VzcGljaW9ucyB3b3VsZCBpbml0aWFsbHkgbGVh
bgo+ID4+IHRvd2FyZHMgdGhlIGxhdHRlciBjYXNlIC0gdGhlIGZhdWx0cyBhcmUgaW4gdGhlIHZl
cnkgdG9wbW9zdCBwYWdlcwo+ID4+IHdoaWNoIGltcGx5IHRoZXkncmUgdGhlIGZpcnN0IHRoaW5n
cyBtYXBwZWQgaW4gdGhhdCByYW5nZS4gVGhlIG90aGVyCj4gPj4gY29udHJpYnV0aW5nIGZhY3Rv
ciBiZWluZyB0aGUgdHJpY2sgdGhhdCB0aGUgSU9WQSBhbGxvY2F0b3IgcGxheXMgZm9yCj4gPj4g
UENJIGRldmljZXMsIHdoZXJlIGl0IHRyaWVzIHRvIHByZWZlciAzMi1iaXQgYWRkcmVzc2VzLiBU
aHVzIHlvdSdyZQo+ID4+IG9ubHkgbGlrZWx5IHRvIHNlZSB0aGlzIGhhcHBlbiBvbmNlIHlvdSBh
bHJlYWR5IGhhdmUgfjMuNS00R0Igb2YgbGl2ZQo+ID4+IERNQS1tYXBwZWQgbWVtb3J5IHRvIGV4
aGF1c3QgdGhlIDMyLWJpdCBJT1ZBIHNwYWNlIChtaW51cyBzb21lCj4gPj4gcmVzZXJ2ZWQgYXJl
YXMpIGFuZCBzdGFydCBhbGxvY2F0aW5nIGZyb20gdGhlIGZ1bGwgRE1BIG1hc2suIFlvdQo+ID4+
IHNob3VsZCBiZSBhYmxlIHRvIGNoZWNrIHRoYXQgd2l0aCBhIDUuMTMgb3IgbmV3ZXIga2VybmVs
IGJ5IGJvb3RpbmcKPiA+PiB3aXRoICJpb21tdS5mb3JjZWRhYz0xIiBhbmQgc2VlaW5nIGlmIGl0
IGJyZWFrcyBpbW1lZGlhdGVseQo+ID4+ICh1bmZvcnR1bmF0ZWx5IHdpdGggYW4gb2xkZXIga2Vy
bmVsIHlvdSdkIGhhdmUgdG8gbWFudWFsbHkgaGFjawo+ID4+IGlvbW11X2RtYV9hbGxvY19pb3Zh
KCkgdG8gdGhlIHNhbWUgZWZmZWN0KS4KPiA+Cj4gPiBJIGJvb3RlZCBMaW51eCA1LjE1LXJjNyB3
aXRoIGBpb21tdS5mb3JjZWRhYz0xYCBhbmQgdGhlIHN5c3RlbSBib290ZWQsCj4gPiBhbmQgSSBj
b3VsZCBsb2cgaW4gcmVtb3RlbHkgb3ZlciBTU0guIFBsZWFzZSBmaW5kIHRoZSBMaW51eCBrZXJu
ZWwKPiA+IG1lc3NhZ2VzIGF0dGFjaGVkLiAoVGhlIHN5c3RlbSBsb2dzIHNheSBsaWdodGRtIGZh
aWxlZCB0byBzdGFydCwgYnV0IGl0Cj4gPiBtaWdodCBiZSBzb21lIG90aGVyIGlzc3VlIGR1ZSB0
byBhIGNoYW5nZSBpbiB0aGUgb3BlcmF0aW5nIHN5c3RlbS4pCj4KPiBPSywgdGhhdCBsb29rcyBs
aWtlIGl0J3MgbWFkZSB0aGUgR1BVIGJsb3cgdXAgc3RyYWlnaHQgYXdheSwgd2hpY2ggaXMKPiB3
aGF0IEkgd2FzIGhvcGluZyBmb3IgKGFuZCBhbHNvIGFwcGVhcnMgdG8gcmV2ZWFsIGFub3RoZXIg
YnVnIHdoZXJlIGl0J3MKPiBub3QgaGFuZGxpbmcgcHJvYmUgZmFpbHVyZSB2ZXJ5IHdlbGwgLSBw
b3NzaWJseSB0cnlpbmcgdG8gcmVtb3ZlIGEKPiBub24tZXhpc3RlbnQgYXVkaW8gZGV2aWNlPyku
IExpZ2h0ZG0gcHJlc3VtYWJseSBmYWlscyB0byBzdGFydCBiZWNhdXNlCj4gaXQgZG9lc24ndCBm
aW5kIGFueSBkaXNwbGF5IGRldmljZXMsIHNpbmNlIGFtZGdwdSBmYWlsZWQgdG8gcHJvYmUuCj4K
PiBJZiB5b3UgY2FuIGJvb3QgdGhlIHNhbWUga2VybmVsIHdpdGhvdXQgImlvbW11LmZvcmNlZGFj
IiBhbmQgZ2V0IGEKPiBzdWNjZXNzZnVsIHByb2JlIGFuZCB3b3JraW5nIGRpc3BsYXksIHRoYXQg
d2lsbCBpbXBseSB0aGF0IGl0IGlzCj4gbWFuYWdpbmcgdG8gd29yayBPSyB3aXRoIDMyLWJpdCBE
TUEgYWRkcmVzc2VzLCBhdCB3aGljaCBwb2ludCBJJ2QgaGF2ZQo+IHRvIGxlYXZlIGl0IHRvIENo
cmlzdGlhbiBhbmQgQWxleCB0byBmaWd1cmUgb3V0IGV4YWN0bHkgd2hlcmUgRE1BCj4gYWRkcmVz
c2VzIGFyZSBnZXR0aW5nIG1hbmdsZWQuIFRoZSBvbmx5IHRoaW5nIHRoYXQgc3RhbmRzIG91dCB0
byBtZSBpcwo+IHRoZSByZWZlcmVuY2UgdG8gImdmeF92Nl8wIiwgd2hpY2ggbWFrZXMgbWUgd29u
ZGVyIHdoZXRoZXIgaXQncyByZWxhdGVkCj4gdG8gZ21jX3Y2XzBfc3dfaW5pdCgpIHdoZXJlIGEg
NDQtYml0IERNQSBtYXNrIGdldHMgc2V0LiBJZiBzbywgdGhhdAo+IHdvdWxkIHN1Z2dlc3QgdGhh
dCBlaXRoZXIgdGhpcyBwYXJ0aWN1bGFyIG1vZGVsIG9mIEdQVSBpcyBtb3JlIGxpbWl0ZWQKPiB0
aGFuIGV4cGVjdGVkLCBvciB0aGF0IFNvQyBvbmx5IGhhcyA0MCBiaXRzIG9mIGFkZHJlc3Mgd2ly
ZWQgdXAgYmV0d2Vlbgo+IHRoZSBQQ0kgaG9zdCBicmlkZ2UgYW5kIHRoZSBJT01NVS4KClRoYXQg
ZGV2aWNlIG9ubHkgaGFzIGEgNDAgYml0IERNQSBtYXNrLiAgSXQgbG9va3MgbGlrZSB0aGUgY29k
ZSBpcyB3cm9uZyB0aGVyZS4KCkFsZXgKCgo+Cj4gQ2hlZXJzLAo+IFJvYmluLgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
