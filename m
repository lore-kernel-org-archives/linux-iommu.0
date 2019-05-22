Return-Path: <SRS0=VKv6=TW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946A5C282CE
	for <iommu@archiver.kernel.org>; Wed, 22 May 2019 19:42:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 624992089E
	for <iommu@archiver.kernel.org>; Wed, 22 May 2019 19:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNfDrv//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624992089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 38A16B0B;
	Wed, 22 May 2019 19:42:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7E1A3A59
	for <iommu@lists.linux-foundation.org>;
	Wed, 22 May 2019 19:41:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com
	[209.85.219.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E4950102
	for <iommu@lists.linux-foundation.org>;
	Wed, 22 May 2019 19:41:58 +0000 (UTC)
Received: by mail-yb1-f193.google.com with SMTP id k128so1339881ybf.0
	for <iommu@lists.linux-foundation.org>;
	Wed, 22 May 2019 12:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=Q19RztagPywupfj/J4DqX3LJhIyXp53CM3bbmnwAQI4=;
	b=UNfDrv//AipAlrKipQXskKoxdJ2WtyHM6zC+iXQvoSKDQ1xWXnw4KTXkT38SsmHf0v
	KIe58FwtZxyDiXkSfZ6M1RstrZLgPH2pQ8C7cPvGvGNym49DipYStwFJgW1yxQw9Thsx
	3qMvEXhUxNkLePzGsWh0whoKXODOhNRybDWn7sfS/Zydbv3kzTXg+AhDEfqLeagQBhoY
	gnR/j3HbggY7pTe+Ycz3AFsB4Dn3WV0jqtN3sjyrbZzdtDPUUStbBZMSL8O3NHW7Q1wK
	UYT8iWI8W15dz490WDuQErQYBf+B36yLyXTxFmeNfEjJFl3XgUAyx8MukKhh+Qw3BWa6
	deFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=Q19RztagPywupfj/J4DqX3LJhIyXp53CM3bbmnwAQI4=;
	b=Z5kXbTWCYiQTyA9GJFJm27LB4Cr+wd0xdLo7i4uVsQHXP1u9pJVV/oGrRSiVn+uhHT
	fRmAOu4p0ihO0LvFMg35mBx/M76kEeXxVkPei6Y17Iae+rCgyIAnElxM2OSvHD8YQmo6
	WqfKjXNoHuJadzCsfKo9+dV25FYmFo6a3RN4aG4n4i9nYxO8Y2lLrTrlKlRVcxuf903h
	z2iYPB6O6JrKKnLQy1fIkMNjvfQiOtQaGnFTto60z08nUByHRMiLhLDg7w5HjPpKwm2b
	cnNN0Lgrm8gXegDJ0klSQCH9GjKr0GJoYYNdgvRelVZPHK/8g7yiprdsqD45y1Cn+mQR
	nBTA==
X-Gm-Message-State: APjAAAXaud6JGIjKw6UX3J1gk7iGa0SinRfoAK/1haVvmFeH/cujqNev
	MtKjTfSQr0vOdxUoxI/8hivSY+ZXUsBMJmKL+Kk=
X-Google-Smtp-Source: APXvYqw2xVvUgbCYG8yMU6wkqfSXTHCekPF2FBrZThkJBWJI1JX36gXbv5kknq16+qzBuCEjqhC/PD0it4+M3Z6X3Ac=
X-Received: by 2002:a25:138a:: with SMTP id 132mr41990542ybt.127.1558554117758;
	Wed, 22 May 2019 12:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190521161102.29620-1-peron.clem@gmail.com>
	<CAL_Jsq+86nNEBzjbf_GLWWrAN91jwU+JQ7zrEoFaT_dxUzVv4A@mail.gmail.com>
In-Reply-To: <CAL_Jsq+86nNEBzjbf_GLWWrAN91jwU+JQ7zrEoFaT_dxUzVv4A@mail.gmail.com>
From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date: Wed, 22 May 2019 21:41:46 +0200
Message-ID: <CAJiuCcdPXdG1ZcWypJZy_d04c2obEuqFZXna-voMmbK6Au84CA@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Allwinner H6 Mali GPU support
To: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	devicetree <devicetree@vger.kernel.org>,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>,
	Neil Armstrong <narmstrong@baylibre.com>, David Airlie <airlied@linux.ie>,
	Will Deacon <will.deacon@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Steven Price <steven.price@arm.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
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

SGkgUm9iLAoKT24gV2VkLCAyMiBNYXkgMjAxOSBhdCAyMToyNywgUm9iIEhlcnJpbmcgPHJvYmgr
ZHRAa2VybmVsLm9yZz4gd3JvdGU6Cj4KPiBPbiBUdWUsIE1heSAyMSwgMjAxOSBhdCAxMToxMSBB
TSBDbMOpbWVudCBQw6lyb24gPHBlcm9uLmNsZW1AZ21haWwuY29tPiB3cm90ZToKPiA+Cj4gPiBI
aSwKPiA+Cj4gPiBUaGUgQWxsd2lubmVyIEg2IGhhcyBhIE1hbGktVDcyMCBNUDIgd2hpY2ggc2hv
dWxkIGJlIHN1cHBvcnRlZCBieQo+ID4gdGhlIG5ldyBwYW5mcm9zdCBkcml2ZXIuIFRoaXMgc2Vy
aWVzIGZpeCB0d28gaXNzdWVzIGFuZCBpbnRyb2R1Y2UgdGhlCj4gPiBkdC1iaW5kaW5ncyBidXQg
YSBzaW1wbGUgYmVuY2htYXJrIHNob3cgdGhhdCBpdCdzIHN0aWxsIE5PVCBXT1JLSU5HLgo+ID4K
PiA+IEknbSBwdXNoaW5nIGl0IGluIGNhc2Ugc29tZW9uZSB3YW50IHRvIGNvbnRpbnVlIHRoZSB3
b3JrLgo+ID4KPiA+IFRoaXMgaGFzIGJlZW4gdGVzdGVkIHdpdGggTWVzYTNEIDE5LjEuMC1SQzIg
YW5kIGEgR1BVIGJpdG5lc3MgcGF0Y2hbMV0uCj4gPgo+ID4gT25lIHBhdGNoIGlzIGZyb20gSWNl
bm93eSBaaGVuZyB3aGVyZSBJIGNoYW5nZWQgdGhlIG9yZGVyIGFzIHJlcXVpcmVkCj4gPiBieSBS
b2IgSGVycmluZ1syXS4KPiA+Cj4gPiBUaGFua3MsCj4gPiBDbGVtZW50Cj4gPgo+ID4gWzFdIGh0
dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9rc3phcS9tZXNhL3RyZWUvcGFuZnJvc3RfNjRf
MzIKPiA+IFsyXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwNjk5ODI5Lwo+
ID4KPiA+Cj4gPiBbICAzNDUuMjA0ODEzXSBwYW5mcm9zdCAxODAwMDAwLmdwdTogbW11IGlycSBz
dGF0dXM9MQo+ID4gWyAgMzQ1LjIwOTYxN10gcGFuZnJvc3QgMTgwMDAwMC5ncHU6IFVuaGFuZGxl
ZCBQYWdlIGZhdWx0IGluIEFTMCBhdCBWQQo+ID4gMHgwMDAwMDAwMDAyNDAwNDAwCj4gPiBbICAz
NDUuMjA5NjE3XSBSZWFzb246IFRPRE8KPiA+IFsgIDM0NS4yMDk2MTddIHJhdyBmYXVsdCBzdGF0
dXM6IDB4ODAwMDAyQzEKPiA+IFsgIDM0NS4yMDk2MTddIGRlY29kZWQgZmF1bHQgc3RhdHVzOiBT
TEFWRSBGQVVMVAo+ID4gWyAgMzQ1LjIwOTYxN10gZXhjZXB0aW9uIHR5cGUgMHhDMTogVFJBTlNM
QVRJT05fRkFVTFRfTEVWRUwxCj4gPiBbICAzNDUuMjA5NjE3XSBhY2Nlc3MgdHlwZSAweDI6IFJF
QUQKPiA+IFsgIDM0NS4yMDk2MTddIHNvdXJjZSBpZCAweDgwMDAKPiA+IFsgIDM0NS43Mjk5NTdd
IHBhbmZyb3N0IDE4MDAwMDAuZ3B1OiBncHUgc2NoZWQgdGltZW91dCwganM9MCwKPiA+IHN0YXR1
cz0weDgsIGhlYWQ9MHgyNDAwNDAwLCB0YWlsPTB4MjQwMDQwMCwgc2NoZWRfam9iPTAwMDAwMDAw
OWUyMDRkZTkKPiA+IFsgIDM0Ni4wNTU4NzZdIHBhbmZyb3N0IDE4MDAwMDAuZ3B1OiBtbXUgaXJx
IHN0YXR1cz0xCj4gPiBbICAzNDYuMDYwNjgwXSBwYW5mcm9zdCAxODAwMDAwLmdwdTogVW5oYW5k
bGVkIFBhZ2UgZmF1bHQgaW4gQVMwIGF0IFZBCj4gPiAweDAwMDAwMDAwMDJDMDBBMDAKPiA+IFsg
IDM0Ni4wNjA2ODBdIFJlYXNvbjogVE9ETwo+ID4gWyAgMzQ2LjA2MDY4MF0gcmF3IGZhdWx0IHN0
YXR1czogMHg4MTAwMDJDMQo+ID4gWyAgMzQ2LjA2MDY4MF0gZGVjb2RlZCBmYXVsdCBzdGF0dXM6
IFNMQVZFIEZBVUxUCj4gPiBbICAzNDYuMDYwNjgwXSBleGNlcHRpb24gdHlwZSAweEMxOiBUUkFO
U0xBVElPTl9GQVVMVF9MRVZFTDEKPiA+IFsgIDM0Ni4wNjA2ODBdIGFjY2VzcyB0eXBlIDB4Mjog
UkVBRAo+ID4gWyAgMzQ2LjA2MDY4MF0gc291cmNlIGlkIDB4ODEwMAo+ID4gWyAgMzQ2LjU2MTk1
NV0gcGFuZnJvc3QgMTgwMDAwMC5ncHU6IGdwdSBzY2hlZCB0aW1lb3V0LCBqcz0xLAo+ID4gc3Rh
dHVzPTB4OCwgaGVhZD0weDJjMDBhMDAsIHRhaWw9MHgyYzAwYTAwLCBzY2hlZF9qb2I9MDAwMDAw
MDBiNTVhOWE4NQo+ID4gWyAgMzQ2LjU3MzkxM10gcGFuZnJvc3QgMTgwMDAwMC5ncHU6IG1tdSBp
cnEgc3RhdHVzPTEKPiA+IFsgIDM0Ni41Nzg3MDddIHBhbmZyb3N0IDE4MDAwMDAuZ3B1OiBVbmhh
bmRsZWQgUGFnZSBmYXVsdCBpbiBBUzAgYXQgVkEKPiA+IDB4MDAwMDAwMDAwMkMwMEI4MAo+ID4K
PiA+IENoYW5nZSBpbiB2NToKPiA+ICAtIFJlbW92ZSBmaXggaW5kZW50Cj4gPgo+ID4gQ2hhbmdl
cyBpbiB2NDoKPiA+ICAtIEFkZCBidXNfY2xvY2sgcHJvYmUKPiA+ICAtIEZpeCBzYW5pdHkgY2hl
Y2sgaW4gaW8tcGd0YWJsZQo+ID4gIC0gQWRkIHZyYW1wLWRlbGF5Cj4gPiAgLSBNZXJnZSBhbGwg
Ym9hcmRzIGludG8gb25lIHBhdGNoCj4gPiAgLSBSZW1vdmUgdXBzdHJlYW1lZCBOZWlsIEEuIHBh
dGNoCj4gPgo+ID4gQ2hhbmdlIGluIHYzIChUaGFua3MgdG8gTWF4aW1lIFJpcGFyZCk6Cj4gPiAg
LSBSZWF1dGhvciBJY2Vub3d5IGZvciBoZXIgcGF0aAo+ID4KPiA+IENoYW5nZXMgaW4gdjIgKFRo
YW5rcyB0byBNYXhpbWUgUmlwYXJkKToKPiA+ICAtIERyb3AgR1BVIE9QUCBUYWJsZQo+ID4gIC0g
QWRkIGNsb2NrcyBhbmQgY2xvY2stbmFtZXMgaW4gcmVxdWlyZWQKPiA+Cj4gPiBDbMOpbWVudCBQ
w6lyb24gKDUpOgo+ID4gICBkcm06IHBhbmZyb3N0OiBhZGQgb3B0aW9uYWwgYnVzX2Nsb2NrCj4g
PiAgIGlvbW11OiBpby1wZ3RhYmxlOiBmaXggc2FuaXR5IGNoZWNrIGZvciBub24gNDgtYml0IG1h
bGkgaW9tbXUKPiA+ICAgZHQtYmluZGluZ3M6IGdwdTogbWFsaS1taWRnYXJkOiBBZGQgSDYgbWFs
aSBncHUgY29tcGF0aWJsZQo+ID4gICBhcm02NDogZHRzOiBhbGx3aW5uZXI6IEFkZCBBUk0gTWFs
aSBHUFUgbm9kZSBmb3IgSDYKPiA+ICAgYXJtNjQ6IGR0czogYWxsd2lubmVyOiBBZGQgbWFsaSBH
UFUgc3VwcGx5IGZvciBINiBib2FyZHMKPiA+Cj4gPiBJY2Vub3d5IFpoZW5nICgxKToKPiA+ICAg
ZHQtYmluZGluZ3M6IGdwdTogYWRkIGJ1cyBjbG9jayBmb3IgTWFsaSBNaWRnYXJkIEdQVXMKPgo+
IEkndmUgYXBwbGllZCBwYXRjaGVzIDEgYW5kIDMgdG8gZHJtLW1pc2MuIEkgd2FzIGdvaW5nIHRv
IGRvIHBhdGNoIDQKPiB0b28sIGJ1dCBpdCBkb2Vzbid0IGFwcGx5LgoKVGhhbmtzLAoKSSBoYXZl
IHRyaWVkIHRvIGFwcGxpZWQgb24gZHJtLW1pc2MvZm9yLWxpbnV4LW5leHQgYnV0IGl0IGRvZXNu
J3QgYXBwbHkgdG9vLgpJdCBsb29rcyBsaWtlIGNvbW1pdCBkNWZmMWFkYjM4MDllMmY3NGEzYjU3
Y2VhMmU1N2M4ZTM3ZDY5M2M0IGlzCm1pc3Npbmcgb24gZHJtLW1pc2MgPwpodHRwczovL2dpdGh1
Yi5jb20vdG9ydmFsZHMvbGludXgvY29tbWl0L2Q1ZmYxYWRiMzgwOWUyZjc0YTNiNTdjZWEyZTU3
YzhlMzdkNjkzYzQjZGlmZi1jMzE3MmY1ZDQyMWQ0OTJmZjkxZDdiYjQ0ZGQ0NDkxNwoKQ2zDqW1l
bnQKCj4KPiBQYXRjaCAyIGNhbiBnbyBpbiB2aWEgdGhlIGlvbW11IHRyZWUgYW5kIHRoZSByZXN0
IHZpYSB0aGUgYWxsd2lubmVyIHRyZWUuCj4KPiBSb2IKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
