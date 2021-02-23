Return-Path: <SRS0=j2S/=HZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D6EC433E0
	for <iommu@archiver.kernel.org>; Tue, 23 Feb 2021 02:12:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A89C164E4D
	for <iommu@archiver.kernel.org>; Tue, 23 Feb 2021 02:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89C164E4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F447605C7;
	Tue, 23 Feb 2021 02:12:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LuhCtNrjvJIY; Tue, 23 Feb 2021 02:12:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E9E0605B3;
	Tue, 23 Feb 2021 02:12:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77815C000C;
	Tue, 23 Feb 2021 02:12:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1EBBFC0001
 for <iommu@lists.linux-foundation.org>; Tue, 23 Feb 2021 02:12:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1B19586FAF
 for <iommu@lists.linux-foundation.org>; Tue, 23 Feb 2021 02:12:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N-ZLDQY4H6Bc for <iommu@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 02:12:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 61D2086EC0
 for <iommu@lists.linux-foundation.org>; Tue, 23 Feb 2021 02:12:50 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id o6so854206pjf.5
 for <iommu@lists.linux-foundation.org>; Mon, 22 Feb 2021 18:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=c5ZGNOEFsq06O3hDL6Dkcj0DN73dBzxBLUMcvrx4vz8=;
 b=PLpTI6iZ95+2Hpv+V69z/FmaAV3HebWieADBp0LmkCVcJWyWRqHGX4GrMad0MqbLO0
 SbSRecFFlIH73tSepywsfNwDEtmKFC2P4m8jMrBHH9GD8vVdv482iAkTe6qT8RFsofND
 Ps1mslDMQwBAY4jOZFcj2wlmDQ6Eevyn/FV33k4obz/aOBDCYk4Il4UD3tbQIIvYChTK
 dsFOZFBq/IPrSujTdetbUoDxAC6hvy3TMncB2gFgihJendfclDtaTDpbnW8JDV3xATRD
 pr00y6+5EVHtHLH2YBAWCPmSKcBedUuzhYoKCIpYyLrcpm9JiXWyBMSZV8mn7FVUXVQA
 X9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=c5ZGNOEFsq06O3hDL6Dkcj0DN73dBzxBLUMcvrx4vz8=;
 b=hkqTxTPH3C4gAgDHMMTV+mnx3VGh/3w4a9aUwtwayoM2fQat5Fdwp/K/z5GfDAC5y6
 shD+bfujd+49A1eh2dtWtLFI+yR0OVcMGTNgHppMPxG6XKZfbNLRGdSfzERJxEGaUSQD
 nM79TMJniI8S3PBbN/PVQILoHPrPCKSLON1Hdn0CCp1FZB7RIrC9yuGLfultVfQyxhC1
 vONxGIgGuW4l2iT0dHcWtqJGiEifjI3neVXf6HoeZO4rfzOeVhINo7xMEx5GJ1FN6SDz
 ewGAjsOBds+r2pDKniVK1++GfWGMONiuqKg/AjCHkOOfFKw2tiEqeAGD6hdXdPbc5SkX
 gQ5w==
X-Gm-Message-State: AOAM531mVYoUO85BX2hG8VcJD4enrLeRV0wfjXJYZg6a41LkoCbwmMc+
 meQjvDi3jDaEaaNzhxJQ12I=
X-Google-Smtp-Source: ABdhPJyBcNDbkq2zlENqdPwG/ui/noxDrcs/Rvpcj5HMzJyyrXKsSa+YbMa5RPaTdVSHxWtFWdl+bg==
X-Received: by 2002:a17:90a:e17:: with SMTP id
 v23mr26904664pje.193.1614046369902; 
 Mon, 22 Feb 2021 18:12:49 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id w202sm10092100pff.198.2021.02.22.18.12.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 22 Feb 2021 18:12:49 -0800 (PST)
Date: Mon, 22 Feb 2021 18:13:44 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH] iommu/tegra-smmu: Fix mc errors on tegra124-nyan
Message-ID: <20210223021343.GA6539@Asurada-Nvidia>
References: <20210218220702.1962-1-nicoleotsuka@gmail.com>
 <9d6445c0-9574-1650-e327-32b11716f87e@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9d6445c0-9574-1650-e327-32b11716f87e@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: guillaume.tucker@collabora.com, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 will@kernel.org, linux-kernel@vger.kernel.org
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

SGkgRG1pdHJ5LAoKT24gU2F0LCBGZWIgMjAsIDIwMjEgYXQgMDg6MTY6MjJBTSArMDMwMCwgRG1p
dHJ5IE9zaXBlbmtvIHdyb3RlOgo+IDE5LjAyLjIwMjEgMDE6MDcsIE5pY29saW4gQ2hlbiDQv9C4
0YjQtdGCOgo+ID4gQ29tbWl0IDI1OTM4YzczY2Q3OSAoImlvbW11L3RlZ3JhLXNtbXU6IFJld29y
ayB0ZWdyYV9zbW11X3Byb2JlX2RldmljZSgpIikKPiA+IHJlbW92ZWQgY2VydGFpbiBoYWNrIGlu
IHRoZSB0ZWdyYV9zbW11X3Byb2JlKCkgYnkgcmVseWluZyBvbiBJT01NVSBjb3JlIHRvCj4gPiBv
Zl94bGF0ZSBTTU1VJ3MgU0lEIHBlciBkZXZpY2UsIHNvIGFzIHRvIGdldCByaWQgb2YgdGVncmFf
c21tdV9maW5kKCkgYW5kCj4gPiB0ZWdyYV9zbW11X2NvbmZpZ3VyZSgpIHRoYXQgYXJlIHR5cGlj
YWxseSBkb25lIGluIHRoZSBJT01NVSBjb3JlIGFsc28uCj4gPiAKPiA+IFRoaXMgYXBwcm9hY2gg
d29ya3MgZm9yIGJvdGggZXhpc3RpbmcgZGV2aWNlcyB0aGF0IGhhdmUgRFQgbm9kZXMgYW5kIG90
aGVyCj4gPiBkZXZpY2VzIChsaWtlIFBDSSBkZXZpY2UpIHRoYXQgZG9uJ3QgZXhpc3QgaW4gRFQs
IG9uIFRlZ3JhMjEwIGFuZCBUZWdyYTMKPiA+IHVwb24gdGVzdGluZy4gSG93ZXZlciwgUGFnZSBG
YXVsdCBlcnJvcnMgYXJlIHJlcG9ydGVkIG9uIHRlZ3JhMTI0LU55YW46Cj4gPiAKPiA+ICAgdGVn
cmEtbWMgNzAwMTkwMDAubWVtb3J5LWNvbnRyb2xsZXI6IGRpc3BsYXkwYTogcmVhZCBAMHhmZTA1
NmI0MDoKPiA+IAkgRU1FTSBhZGRyZXNzIGRlY29kZSBlcnJvciAoU01NVSB0cmFuc2xhdGlvbiBl
cnJvciBbLS1TXSkKPiA+ICAgdGVncmEtbWMgNzAwMTkwMDAubWVtb3J5LWNvbnRyb2xsZXI6IGRp
c3BsYXkwYTogcmVhZCBAMHhmZTA1NmI0MDoKPiA+IAkgUGFnZSBmYXVsdCAoU01NVSB0cmFuc2xh
dGlvbiBlcnJvciBbLS1TXSkKPiA+IAo+ID4gQWZ0ZXIgZGVidWdnaW5nLCBJIGZvdW5kIHRoYXQg
dGhlIG1lbnRpb25lZCBjb21taXQgY2hhbmdlZCBzb21lIGZ1bmN0aW9uCj4gPiBjYWxsYmFjayBz
ZXF1ZW5jZSBvZiB0ZWdyYS1zbW11J3MsIHJlc3VsdGluZyBpbiBlbmFibGluZyBTTU1VIGZvciBk
aXNwbGF5Cj4gPiBjbGllbnQgYmVmb3JlIGRpc3BsYXkgZHJpdmVyIGdldHMgaW5pdGlhbGl6ZWQu
IEkgY291bGRuJ3QgcmVwcm9kdWNlIGV4YWN0Cj4gPiBzYW1lIGlzc3VlIG9uIFRlZ3JhMjEwIGFz
IFRlZ3JhMTI0IChhcm0tMzIpIGRpZmZlcnMgYXQgYXJjaC1sZXZlbCBjb2RlLgo+IAo+IEhlbGxv
IE5pY29saW4sCj4gCj4gQ291bGQgeW91IHBsZWFzZSBleHBsYWluIGluIGEgbW9yZSBkZXRhaWxz
IHdoYXQgZXhhY3RseSBtYWtlcyB0aGUKPiBkaWZmZXJlbmNlIGZvciB0aGUgY2FsbGJhY2sgc2Vx
dWVuY2U/CgpIZXJlIGlzIGEgbG9nIHdpdGggNS4xMS4wLXJjNjoKaHR0cHM6Ly9sYXZhLmNvbGxh
Ym9yYS5jby51ay9zY2hlZHVsZXIvam9iLzMxODc4NDkKW2R1bXBfc3RhY2sgd2FzIGFkZGVkIGlu
IHNvbWUgdGVncmEtc21tdSBmdW5jdGlvbnNdCgpBbmQgaGVyZSBpcyBhIGNvcnJlc3BvbmRpbmcg
bG9nIHdpdGggcmV2ZXJ0aW5nIHRoZSBvcmlnaW5hbCBjb21taXQ6Cmh0dHBzOi8vbGF2YS5jb2xs
YWJvcmEuY28udWsvc2NoZWR1bGVyL2pvYi8zMTg3ODUxCgpIZXJlIGlzIGEgbG9nIHdpdGggNS4x
MS4wLXJjNy1uZXh0LTIwMjEwMjEwOgpodHRwczovL2xhdmEuY29sbGFib3JhLmNvLnVrL3NjaGVk
dWxlci9qb2IvMzIxMDI0NQoKQW5kIGhlcmUgaXMgYSBjb3JyZXNwb25kaW5nIGxvZyB3aXRoIHJl
dmVydGluZyB0aGUgb3JpZ2luYWwgY29tbWl0OgpodHRwczovL2xhdmEuY29sbGFib3JhLmNvLnVr
L3NjaGVkdWxlci9qb2IvMzIxMDU5NgoKQm90aCBmYWlsaW5nIGxvZ3Mgc2hvdyB0aGF0IG1jIGVy
cm9ycyBzdGFydGVkIHJpZ2h0IGFmdGVyIGNsaWVudCBEQwpnb3QgZW5hYmxlZCBieSAtPmF0dGFj
aF9kZXYoKSBjYWxsYmFjayB0aGF0IGluIHRoZSBwYXNzaW5nIGxvZ3Mgd2FzCm5vdCBjYWxsZWQg
dW50aWwgSG9zdDF4IGRyaXZlciBpbml0LiBBbmQgbm90ZSB0aGF0IHR3byBmYWlsaW5nIGxvZ3MK
c2hvdyB0aGF0IC0+YXR0YWNoX2RldigpIGNvdWxkIGJlIGNhbGxlZCBmcm9tIHR3byBkaWZmZXJl
bnQgc291cmNlcywKb2ZfZG1hX2NvbmZpZ3VyZV9pZCgpIG9yIGFyY2hfc2V0dXBfZG1hX29wcygp
LgoKVGhlIHJlYXNvbiB3aHkgLT5hdHRhY2hfZGV2KCkgZ2V0cyBjYWxsZWQgaXMgcHJvYmFibHkg
cmVsYXRlZCB0byB0aGUKZm9sbG93aW5nIHJlYXNvbnMgKHNvcnJ5LCBjYW4ndCBiZSAxMDAlIHN1
cmUgYXMgSSBkb24ndCBoYXZlIFRlZ3JhMTI0Cm9yIG90aGVyIDMyYml0IFRlZ3JhIGJvYXJkIHRv
IHRlc3QpOgoxKSBXaXRoIHRoZSBjb21taXQgcmV2ZXJ0ZWQsIGFsbCBjbGllbnRzIGFyZSBwcm9i
ZWQgaW4gImFyY2giIHN0YWdlLAogICB3aGljaCBpcyBldmVuIHByaW9yIHRvIGlvbW11IGNvcmUg
aW5pdGlhbGl6YXRpb24gLS0gaW5jbHVkaW5nIGl0CiAgIHNldHRpbmcgZGVmYXVsdCBkb21haW4g
dHlwZS4gVGhpcyBwcm9iYWJseSBtZXNzZWQgdXAgdGhlIHR5cGUgb2YKICAgYWxsb2NhdGluZyBk
b21haW5zIGFnYWluc3QgdGhlIGRlZmF1bHQgZG9tYWluIHR5cGUuIEFsc28gaW50ZXJuYWwKICAg
Z3JvdXAgaXMgc29tZWhvdyBhZmZlY3RlZC4gU28gc29tZSBjb25kaXRpb24gY2hlY2sgaW4gaW9t
bXUgY29yZQogICBmYWlsZWQgYW5kIHRoZW4gaXQgYnlwYXNzZWQgLT5hdHRhY2hfZGV2IGNhbGxi
YWNrIGluIHJlYWxseV9wcm9iZQogICBzdGFnZSwgdW50aWwgSG9zdDF4IGRyaXZlciBkb2VzIGF0
dGFjaF9kZXYgYWdhaW4uCgoyKSAzMmJpdCBBUk0gaGFzIGFyY2hfc2V0dXBfZG1hX29wcygpIGRv
ZXMgYW4gYWRkaXRpb25hbCBzZXQgb2YgaW9tbXUKICAgZG9tYWluIGFsbG9jYXRpb24gKyBhdHRh
Y2hfZGV2KCksIGFmdGVyIG9mX2RtYV9jb25maWd1cmVfaWQoKSBkaWQKICAgb25jZS4gVGhpcyBp
c24ndCByZXByb2R1Y2libGUgZm9yIG1lIG9uIFRlZ3JhMjEwLgoKQXMgZGVidWdnaW5nIG9ubGlu
ZSBpc24ndCB2ZXJ5IGVmZmljaWVudCwgYW5kIGdpdmVuIHRoYXQgVGhpZXJyeSBoYXMKYmVlbiB3
b3JraW5nIG9uIHRoZSBsaW5lYXIgbWFwcGluZyBvZiBmcmFtZWJ1ZmZlciBjYXJ2ZW91dCwgSSBj
aG9vc2UKdG8gcGFydGlhbGx5IHJldmVydCBhcyBhIHF1aWNrIGZpeC4KClRoYW5rcwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxp
c3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
